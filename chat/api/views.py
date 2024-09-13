import os
import json
from django.contrib.auth.models import User
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
# from langchain_community.embeddings import OpenAIEmbeddings  # 수정된 임포트
# # from langchain_community.vectorstores import Chroma  # 수정된 임포트
# from langchain.prompts import ChatPromptTemplate, SystemMessagePromptTemplate, HumanMessagePromptTemplate
# from langchain.memory import ConversationBufferMemory
# from langchain.chains import ConversationalRetrievalChain
from chat.models import Message, Chat


# from langchain_openai import OpenAIEmbeddings
# from langchain_chroma import Chroma
# from langchain_openai import ChatOpenAI

# from langchain_community.embeddings import OpenAIEmbeddings  # 수정된 임포트
# from langchain_community.vectorstores import Chroma  # 수정된 임포트
# from langchain.chat_models import ChatOpenAI 


from rest_framework.decorators import api_view
from .serializers import MessageSerializer
from rest_framework.response import Response

from .chat_search import custom_chain  # LangChain 기반 응답 함수 가져오기

from django.core.serializers.json import DjangoJSONEncoder


@api_view(['GET'])
def getMessages(request, pk):
    user = User.objects.get(username=request.user.username)
    chat = Chat.objects.filter(user=user)[pk-1]
    messages = Message.objects.filter(chat=chat)
    serializer = MessageSerializer(messages, many=True)
    return Response(serializer.data)

@csrf_exempt
def get_prompt_result(request):
    if request.method == 'POST':
        # 요청 본문에서 사용자 입력을 가져옴
        data = json.loads(request.body.decode('utf-8'))
        prompt = data.get('prompt')
        user = User.objects.get(username=request.user.username)
        chat = Chat.objects.filter(user=user)[0]

        # 프롬프트가 없는 경우 오류 처리
        if not prompt:
            return JsonResponse({'error': 'Prompt is missing in the request'}, status=400)

        # 사용자 질문 저장
        user_message = Message(message=prompt, is_user=True, chat=chat)
        user_message.save()

        messages_db = Message.objects.filter(chat = chat)
        messages=[
                {"role": "system", "content": "You are chatbot. Reply all questions in markdown format."},
                {"role": "user", "content": "Hey! How are you?"},
                {"role": "assistant",
                    "content": "Hi! I'm fine! What about you?"},
                {"role": "user", "content": prompt}
            ]

        for msg in messages_db:
            role = "user" if msg.is_user else "assistant"
            messages.append({"role" : role, "content" : msg.message})

        try:
            # LangChain 기반으로 응답 생성 (chat_search.py에서 정의한 함수 호출)
            response = custom_chain.invoke(messages[-1]['content'])
            print(response['answer'])
            # 응답 메시지 저장
            response_message = Message(message=response['answer'], is_user=False, chat=chat)
            response_message.save()
    

            # return JsonResponse({"content" : response["content"]})
        
        # 결과 반환 - 응답 객체의 필요한 속성만 추출하여 JSON으로 반환
            response_data = {
                'message': response_message.message,  # 메시지 내용만 반환
                'role': 'assistant'  # 역할 지정
            }
            print(response_data)
            print(type(response_data))
            return JsonResponse(response_data)

        except Exception as error:
            error_msg = str(error)
            print(error_msg)
            return JsonResponse({'error': error_msg}, status=500)

    # POST 외의 요청에 대한 처리
    return JsonResponse({'error': 'Method not allowed'}, status=405)