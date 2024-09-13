import os
# from langchain.vectorstores import Chroma
# from langchain.embeddings import OpenAIEmbeddings
from typing import List, Optional
from langchain_core.pydantic_v1 import BaseModel, Field
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough
# from langchain_openai import ChatOpenAI
from langchain.memory import ConversationBufferMemory
from langchain.chains import ConversationalRetrievalChain
from langchain_core.runnables import chain

from langchain.prompts import ChatPromptTemplate, SystemMessagePromptTemplate, HumanMessagePromptTemplate


from langchain_openai import OpenAIEmbeddings
from langchain_chroma import Chroma
from langchain_openai import ChatOpenAI

from dotenv import load_dotenv
load_dotenv()

# OpenAI API Key
OPENAI_KEY = os.getenv("OPENAI_API_KEY")

# Embeddings 설정
aiembedding = OpenAIEmbeddings(openai_api_key=OPENAI_KEY, model='text-embedding-3-small')

# 파일 목록 (차종별 디렉토리 구조에 맞게 수정)
files = [
    "SsangYong_Rexton_chroma",
    "SsangYong_Korando_chroma",
    "SsangYong_Torres_chroma",
    "SsangYong_Tivoli_Air_chroma",
    "KIA_K3_chroma",
    "KIA_K5_chroma",
    "KIA_Niro_chroma",
    "KIA_Ray_chroma",
    "KIA_Morning_chroma",
    "KIA_Seltos_chroma",
    "Chevrolet_Trailblazer_chroma",
    "Chevrolet_Trax_Crossover_chroma",
    "Hyundai_Venue_chroma",
    "Hyundai_Elantra_chroma",
    "Hyundai_Casper_chroma"
]


# 차종별 Chroma 객체 및 리트리버 생성
vector_stores = {}
retrievers = {}

for file in files:
    parts = file.split('_')
    brand = parts[0]  # 브랜드 이름
    model = parts[1]  # 모델 이름
    model_name = f"{brand}_{model}"  # 전체 모델명
    
    # Chroma 객체 생성
    vector_store = Chroma(persist_directory=f"C:/chat/chroma/{model_name}_chroma", embedding_function=aiembedding)
    vector_stores[model_name] = vector_store
    
    # 리트리버 생성
    retrievers[model_name] = vector_store.as_retriever(search_kwargs={'k': 5})

# 검색 모델 정의
class Search(BaseModel):
    query: str = Field(
        ..., description="자동차 모델에 대해 검색할 질문"
    )
    category: str = Field(
        ..., description="""자동차 제조사와 모델을 결합한 형식. 예:  ' 
                            "SsangYong_Rexton",
                            "SsangYong_Korando",
                            "SsangYong_Torres",
                            "SsangYong_Tivoli_Air",
                            "KIA_K3",
                            "KIA_K5",
                            "KIA_Niro",
                            "KIA_Ray",
                            "KIA_Morning",
                            "KIA_Seltos",
                            "Chevrolet_Trailblazer",
                            "Chevrolet_Trax_Crossover",
                            "Hyundai_Venue",
                            "Hyundai_Elantra",
                            "Hyundai_Casper" """
    )

# LLM 및 체인 설정
system = """You have the ability to issue search queries to get information to help answer car model information."""
prompt = ChatPromptTemplate.from_messages(
    [
        ("system", system),
        ("human", "{question}"),
    ]
)
llm = ChatOpenAI(model="gpt-4o-mini", temperature=0, openai_api_key=OPENAI_KEY)
structured_llm = llm.with_structured_output(Search)
query_analyzer = {"question": RunnablePassthrough()} | prompt | structured_llm


promptse = ChatPromptTemplate(
    messages=[
        SystemMessagePromptTemplate.from_template(
            """
            너는 친절하고 기억력이 좋은 챗봇이며, 사용자의 질문에 정확하고 일관성 있게 답변할 수 있는 능력을 갖추고 있습니다. 다음 지침에 따라 질문에 답하십시오:

            정보 누락 시 대처:
                - 만약 필요한 정보를 찾지 못하거나 검색 결과가 충분하지 않다면, 사용자에게 해당 정보를 제공할 수 없음을 알리고, 구체적인 추가 정보를 요청하십시오.

            답을 모를 경우:
                - "모릅니다"라고만 답하고, 답을 지어내지 마십시오. 모르는 것은 반드시 "모릅니다"라고 답해야 합니다.

            현재 대화내용 : {chat_history}
            이전 대화의 맥락을 참고하여 질문에 정확하고 일관성 있는 답변을 제공하십시오.
            이전 대화가 없다면 다시 질문을 해달라고 요청하십시오.

            다음은 실제로 사용자에게 보여질 답변입니다:
            {context}를 주로 활용해서 대답하십시오.
            """
        ),
        HumanMessagePromptTemplate.from_template("{question}"),
    ]
)

memory = ConversationBufferMemory(memory_key="chat_history", return_messages=True)

@chain
def custom_chain(question : str):
    

    # 질문 분석
    response = query_analyzer.invoke(question)
    print(response)
    # 카테고리에 맞는 리트리버 선택
    # retriever = retrievers.get(response.category)
    print(response.category)

    if response.category in retrievers :
        retriever = retrievers[response.category]
        print(response)
        # # 리트리버를 통해 검색 결과 가져옴
        # retrieved_data = retriever.invoke(response.query)
        # Conversational Retrieval Chain 생성
        qa = ConversationalRetrievalChain.from_llm(
            llm=llm,
            retriever=retriever,
            memory=memory,
            combine_docs_chain_kwargs={"prompt": promptse}
        )
        # 답변 반환
        result = qa({"question":question})
        
        return result
    else : 
        retriever = retrievers['KIA_K3']
        promptse2 = ChatPromptTemplate(
            messages=[
                SystemMessagePromptTemplate.from_template(
                    """
                    사용자가 자동차 설명에 대한 질문이 아닌 다른 질문을 하고있으면 목적에 맞는 질문을 해달라고 요청하십시오.

                    너는 친절하고 기억력이 좋은 챗봇이며, 사용자의 질문에 정확하고 일관성 있게 답변할 수 있는 능력을 갖추고 있습니다. 다음 지침에 따라 질문에 답하십시오:

                    현재 대화내용 : {chat_history}
                    이전 대화의 맥락을 참고하여 질문에 정확하고 일관성 있는 답변을 제공하십시오.
                    이전 대화가 없다면 다시 질문을 해달라고 요청하십시오.

                    다음은 실제로 사용자에게 보여질 답변입니다:
                    {context}를 주로 활용해서 대답하십시오.
                    """
                ),
                HumanMessagePromptTemplate.from_template("{question}"),
            ]
        )

        qa = ConversationalRetrievalChain.from_llm(
            llm=llm,
            retriever=retriever,
            memory=memory,
            combine_docs_chain_kwargs={"prompt": promptse2}
            )
            # 답변 반환
        result = qa({"question":question})
        
        return result
  
    

# custom_chain을 호출하는 함수
def get_chatbot_response(question: str):
    return custom_chain.invoke(question)
