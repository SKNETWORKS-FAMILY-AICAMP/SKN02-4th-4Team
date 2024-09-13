# SKN02-4th-4Team
Mobility Director는 자동차 매뉴얼을 읽고 사용자의 질문에 대해 답변하는 AI 챗봇입니다. 사용자가 자신의 차량에 대한 질문을 입력하면, 챗봇은 해당 차량의 매뉴얼을 기반으로 정확한 정보를 제공하여 차량 사용에 대한 이해를 돕습니다. 이 챗봇은 빠르고 효율적인 정보 제공을 통해 사용자들이 차량을 보다 안전하고 편리하게 이용할 수 있도록 지원합니다.

#  팀 소개
## 👩‍🏫 팀 구성
<table>
  <tr>
    <th>진정현</th>
    <th>사재민</th>
    <th>서종호</th>
    <th>장정원</th>
  </tr>
  <tr>
    <td>
      <img src= "https://github.com/user-attachments/assets/40015b52-3204-480a-ae08-8a4defc1454c"
                alt="Snorlax" width="100" height="148"> 
    </td>

  <td>
      <img src= "https://github.com/user-attachments/assets/872e3c87-64e9-485b-bb81-01d90ac84ff2" 
                alt="Mankey" width="110" height="148">
  </td>
    
  <td>
      <img src= "https://github.com/user-attachments/assets/4da134ba-afd6-4d73-b2d4-2a3a05ab1fda" 
                alt="Mimikyu" width="100" height="148"> 
  </td>
  
  <td>
      <img src= "https://github.com/user-attachments/assets/9d5340c2-d114-401f-bae2-28fd1689a480" 
                alt="Piplup" width="100" height="148"> 
  </td>
  </tr>
  <tr>
    <td>@SnorLaXD98</td>
    <td>@4jam</td>
    <td>@Seo-jong-ho</td>
    <td>@jwjang1</td>
  </tr>
</table>

<br>

#  프로젝트
## 👨‍🏫 프로젝트 개요
현재 자동차 시장은 다양한 모델과 브랜드, 기능으로 넘쳐나고 있으며, 소비자들은 평균적으로 8~12개의 모델을 고려하게 됩니다. 이러한 선택의 폭이 넓어질수록, 사용자가 원하는 정보를 빠르게 찾는 것이 중요해지고 있습니다. 그러나 자동차 매뉴얼은 방대하고 복잡하여, 필요할 때 원하는 정보를 즉각적으로 찾아내기 어렵습니다.

## 👩‍🏫 서비스 목표
이를 해결하기 위해 Mobility Director라는 AI 챗봇을 개발하였습니다. Mobility Director은 자동차 매뉴얼을 자동으로 분석하여 사용자가 질문하는 내용을 빠르고 정확하게 답변할 수 있습니다. 이를 통해 소비자들은 차량의 기능, 경고등 의미, 정비 정보 등과 같은 중요한 정보를 손쉽게 얻을 수 있습니다. Mobility Director는 사용자 경험을 향상시키고, 매뉴얼 탐색에 소요되는 시간을 줄여주는 효율적인 솔루션을 제공합니다.

## 🔨 기술 스택
#### Development Tools (개발 도구)
<img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=Python&logoColor=white" /> <img src="https://img.shields.io/badge/VSCode-2F80ED?style=for-the-badge&logo=codefactor&logoColor=white" /> <img src="https://img.shields.io/badge/GoogleColab-F9AB00?style=for-the-badge&logo=googlecolab&logoColor=white" />

#### Collaboration Tools (협업 도구)
<img src="https://img.shields.io/badge/Discord-5865F2?style=for-the-badge&logo=Discord&logoColor=white" /> <img src="https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=notion&logoColor=white" /> <img src="https://img.shields.io/badge/GoogleDrive-4285F4?style=for-the-badge&logo=googledrive&logoColor=white" />

#### Version Control (버전 관리)
<img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white" /> <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" />

#### AI & Machine Learning (인공지능 및 머신러닝)
<img src="https://img.shields.io/badge/OpenAi-412991?style=for-the-badge&logo=openai&logoColor=whitee" /> <img src="https://img.shields.io/badge/LangChain-1C3C3C?style=for-the-badge&logo=langchain&logoColor=white" />

#### Web Development (웹 개발)
<img src="https://img.shields.io/badge/django-%23092E20.svg?style=for-the-badge&logo=django&logoColor=white" />

## ✅ 요구사항 명세서

### 1. 프로젝트 범위
- **포함되는 범위**: 
  - 자동차 설명서에 있는 내용을 검색하여 사용자 질문에 답변 제공
  - **예시**: 배터리 방전 시 문 여는 방법 검색
- **제외되는 범위**: 
  - 각 자동차 모델별 비교, 가격, 자세한 제원 (자동차의 트림별로 다를 수 있기 때문)

### 2. 기능 요구사항

#### 2.1. 기능 1: 모델 검색
- **설명**: 사용자의 입력을 바탕으로 해당 자동차 모델을 확인
- **입력**: 사용자의 질문
- **출력**: 해당 모델에 맞는 질문 카테고리 생성
- **시나리오**: 
  - 사용자가 질문을 입력하면, 챗봇이 질문에 맞는 자동차 모델을 검색하여 해당 모델에 대한 설명서를 기반으로 질문 카테고리를 구성
- **제약 조건**: 
  - 자동차 모델을 찾을 수 없는 경우, 사용자가 다시 검색을 하도록 요청

#### 2.2. 기능 2: 설명 검색
- **설명**: 선택된 자동차 모델의 설명서에서 질문에 맞는 정보를 검색하고 출력
- **입력**: 카테고리가 적용된 사용자의 질문
- **출력**: AI 모델(LLM)을 통해 분석된 정보 제공
- **시나리오**: 
  - 사용자가 질문을 입력하면, 해당 모델의 설명서를 검색하여 관련 정보를 제공
- **제약 조건**: 
  - 설명서에 해당 정보가 없을 경우, 답변을 제공하지 않음


## 💻 DB 테이블 - ERD 및 DDL
<img src="https://github.com/user-attachments/assets/eb7c8b6b-2181-44ae-9314-94db1cc08b70" />
<img src="https://github.com/user-attachments/assets/5b26d713-22e9-4ac0-b73e-5be80b3a7a65" />


## 📚 수행결과
<img src="https://github.com/user-attachments/assets/e4102cd8-6f27-4544-b24f-380f8c9015e1" />
<img src="https://github.com/user-attachments/assets/1d766509-3c03-4f2a-97d1-191a93d38d5c" />
<img src="https://github.com/user-attachments/assets/d500834a-4c59-4377-8421-d5e5440494d4" />



## 📚 한줄 회고
* **진정현 :** 넣고싶은 기능이 많았지만 시간이 조금 부족하다고 느껴서 시간관리가 조금 필요할 것같다.
* **사재민 :** 구현해둔 것을 활용하지 못해 아쉬움을 느끼고 부족함에 자극을 받았다. 부족한 시간에도 열심히 해준 팀원들에게 감사함을 느낀다다
* **서종호 :** 
* **장정원 :** 장고가 낯설어 생각보다 시간이 많이 걸려 시간적 제약이 아쉬웠지만 모두 열심히 협력해서 발표까지 마칠수 있어서 감사하다. 기회가 된다면 프로젝트를 이어나가서 기능을 더 추가해 발전된 챗봇을 만들고 싶다.

  * 발표 노션 주소 : https://burnt-paneer-0f6.notion.site/SKN02-4rd-4Team-1006c152949280849b8fc158b7002c46?pvs=4
