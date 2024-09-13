const API_URL = '/api/';
const converter = new showdown.Converter();
let promptToRetry = null;
let uniqueIdToRetry = null;

const submitButton = document.getElementById('submit-button');
const regenerateResponseButton = document.getElementById('regenerate-response-button');
const promptInput = document.getElementById('prompt-input');
const responseList = document.getElementById('response-list');
let isGeneratingResponse = false;

let loadInterval = null;

promptInput.addEventListener('keydown', function(event) {
    if (event.key === 'Enter') {
        event.preventDefault();
        if (event.ctrlKey || event.shiftKey) {
            document.execCommand('insertHTML', false, '<br/><br/>');
        } else {
            getGPTResult();
        }
    }
});

function generateUniqueId() {
    const timestamp = Date.now();
    const randomNumber = Math.random();
    const hexadecimalString = randomNumber.toString(16);

    return `id-${timestamp}-${hexadecimalString}`;
}

function addResponse(selfFlag, prompt) {
    const uniqueId = generateUniqueId();
    const html = `
        <div class="response-container ${selfFlag ? 'my-question' : 'chatgpt-response'}">
            <img class="avatar-image" src="../../static/chat/img/${selfFlag ? 'me' : 'chatgpt'}.png" alt="avatar"/>
            <div class="prompt-content" id="${uniqueId}">${prompt}</div>
        </div>
    `;
    responseList.insertAdjacentHTML('beforeend', html);
    responseList.scrollTop = responseList.scrollHeight;
    return uniqueId;
}

function loader(element) {
    element.textContent = '';
    loadInterval = setInterval(() => {
        element.textContent += '.';
        if (element.textContent === '....') {
            element.textContent = '';
        }
    }, 300);
}

function setErrorForResponse(element, message) {
    element.innerText = message;
    element.style.color = 'rgb(255, 84, 84)';
}

function setRetryResponse(prompt, uniqueId) {
    promptToRetry = prompt;
    uniqueIdToRetry = uniqueId;
    regenerateResponseButton.style.display = 'flex';
}

async function regenerateGPTResult() {
    try {
        await getGPTResult(promptToRetry, uniqueIdToRetry);
        regenerateResponseButton.classList.add("loading");
    } finally {
        regenerateResponseButton.classList.remove("loading");
    }
}

// 수정된 getGPTResult 함수
// async function getGPTResult(_promptToRetry, _uniqueIdToRetry) {
//     const prompt = _promptToRetry ?? promptInput.textContent;

//     if (isGeneratingResponse || !prompt) {
//         return;
//     }

//     submitButton.classList.add("loading");
//     promptInput.textContent = '';

//     if (!_uniqueIdToRetry) {
//         addResponse(true, prompt);
//     }

//     const uniqueId = _uniqueIdToRetry ?? addResponse(false);
//     const responseElement = document.getElementById(uniqueId);
//     loader(responseElement);
//     isGeneratingResponse = true;

//     if (!prompt) {
//         console.error('Prompt is empty or undefined.');
//         return;
//     }

//     console.log('Sending prompt:', prompt);

//     try {
//         const response = await fetch(API_URL + 'get_prompt_result/', {
//             method: 'POST',
//             headers: { 'Content-Type': 'application/json' },
//             body: JSON.stringify({ prompt })
//         });

//         if (!response.ok) {
//             setRetryResponse(prompt, uniqueId);
//             setErrorForResponse(responseElement, `HTTP Error: ${await response.text()}`);
//             return;
//         }

//         const responseData = await response.json();
//         // const responseText = responseData.result || '';
//         console.log(responseData)
//         // 응답이 문자열인지 확인한 후 trim() 적용
//         // if (typeof responseText === 'string') {
//         responseElement.innerHTML = converter.makeHtml(responseData.message.trim());
//         // } else {
//         //     responseElement.innerHTML = converter.makeHtml(JSON.stringify(responseText));
//         // }

//         promptToRetry = null;
//         uniqueIdToRetry = null;
//         regenerateResponseButton.style.display = 'none';

//         setTimeout(() => {
//             responseList.scrollTop = responseList.scrollHeight;
//             hljs.highlightAll();
//         }, 10);
//     } catch (err) {
//         setRetryResponse(prompt, uniqueId);
//         setErrorForResponse(responseElement, `Error: ${err.message}`);
//     } finally {
//         isGeneratingResponse = false;
//         clearInterval(loadInterval);
//     }
// }


async function getGPTResult(_promptToRetry, _uniqueIdToRetry) {
    const prompt = _promptToRetry ?? promptInput.textContent;

    if (isGeneratingResponse || !prompt) {
        return;
    }

    submitButton.classList.add("loading");
    promptInput.textContent = '';

    if (!_uniqueIdToRetry) {
        addResponse(true, prompt);
    }

    const uniqueId = _uniqueIdToRetry ?? addResponse(false);
    const responseElement = document.getElementById(uniqueId);
    loader(responseElement);
    isGeneratingResponse = true;

    if (!prompt) {
        console.error('Prompt is empty or undefined.');
        return;
    }

    console.log('Sending prompt:', prompt);

    try {
        const response = await fetch(API_URL + 'get_prompt_result/', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ prompt })
        });

        if (!response.ok) {
            setRetryResponse(prompt, uniqueId);
            setErrorForResponse(responseElement, `HTTP Error: ${await response.text()}`);
            return;
        }

        const responseData = await response.json();
        // responseData.message는 문자열로서 trim()이 적용 가능
        responseElement.innerHTML = converter.makeHtml(responseData.message.trim());

        promptToRetry = null;
        uniqueIdToRetry = null;
        regenerateResponseButton.style.display = 'none';

        setTimeout(() => {
            responseList.scrollTop = responseList.scrollHeight;
            hljs.highlightAll();
        }, 10);
    } catch (err) {
        setRetryResponse(prompt, uniqueId);
        setErrorForResponse(responseElement, `Error: ${err.message}`);
    } finally {
        isGeneratingResponse = false;
        clearInterval(loadInterval);
    }
}

// 메시지 가져오는 함수
async function getMessages() {
    const currentUrl = window.location.href.split('/');
    const response = await fetch(API_URL + 'messages/' + currentUrl.at(-2), {
        method: 'GET',
        headers: { 'Content-Type': 'application/json' },
    });
    const messages = await response.json();

    for (let message of messages) {
        let responseElement = document.getElementById(addResponse(message.is_user, message.message));
        responseElement.innerHTML = converter.makeHtml(message.message.trim());
    }

    setTimeout(() => {
        responseList.scrollTop = responseList.scrollHeight;
        hljs.highlightAll();
    }, 10);
}

submitButton.addEventListener("click", () => {
    getGPTResult();
});
regenerateResponseButton.addEventListener("click", () => {
    regenerateGPTResult();
});

document.addEventListener("DOMContentLoaded", function() {
    getMessages();
    promptInput.focus();
});



// 입력창의 내용이 변경될 때마다 호출되는 함수
function adjustScroll() {
    // 입력창의 높이를 자동으로 조절 (필요한 경우)
    promptInput.style.height = 'auto';
    promptInput.style.height = (promptInput.scrollHeight) + 'px';

    // 메시지 리스트의 스크롤을 맨 아래로 설정
    responseList.scrollTop = responseList.scrollHeight;
}

// 입력창에 이벤트 리스너 추가
promptInput.addEventListener('input', adjustScroll);

// 페이지 로드 시 초기 스크롤 설정
document.addEventListener("DOMContentLoaded", function() {
    // 기존 코드...
    adjustScroll();
});





// 현재 대화의 세션 ID를 저장할 변수   js
let sessionId = generateSessionId();

// 세션 ID를 생성하는 함수
function generateSessionId() {
    return 'session-' + Date.now() + '-' + Math.random().toString(16).slice(2);
}

// 페이지 로드 시 세션 ID를 설정합니다.
document.addEventListener("DOMContentLoaded", function() {
    sessionId = generateSessionId();
    getMessages();
    getConversationList();
    promptInput.focus();
});



// 대화 목록을 가져오는 함수
async function getConversationList() {
    try {
        const response = await fetch(API_URL + 'conversations/', {
            method: 'GET',
            headers: { 'Content-Type': 'application/json' },
        });
        const conversations = await response.json();

        const conversationList = document.getElementById('conversation-list');
        conversationList.innerHTML = '';

        conversations.forEach(convo => {
            const listItem = document.createElement('li');
            listItem.textContent = `대화 ${convo.id} - ${convo.created_at}`;
            listItem.dataset.sessionId = convo.session_id;
            listItem.addEventListener('click', () => {
                loadConversation(convo.session_id);
            });
            conversationList.appendChild(listItem);
        });
    } catch (err) {
        console.error('Error fetching conversation list:', err);
    }
}



// 선택한 대화를 불러오는 함수
async function loadConversation(sessionIdToLoad) {
    sessionId = sessionIdToLoad; // 현재 세션 ID를 선택한 대화의 세션 ID로 변경

    // 메시지 리스트를 초기화
    responseList.innerHTML = '';

    try {
        const response = await fetch(API_URL + 'messages/' + sessionId, {
            method: 'GET',
            headers: { 'Content-Type': 'application/json' },
        });
        const messages = await response.json();

        for (let message of messages) {
            let responseElement = document.getElementById(addResponse(message.is_user, message.message));
            responseElement.innerHTML = converter.makeHtml(message.message.trim());
        }

        setTimeout(() => {
            responseList.scrollTop = responseList.scrollHeight;
            hljs.highlightAll();
        }, 10);
    } catch (err) {
        console.error('Error loading conversation:', err);
    }
}



// 페이지 로드 시 대화 목록을 가져옵니다.
document.addEventListener("DOMContentLoaded", function() {
    getConversationList();
   
});






const newConversationButton = document.getElementById('new-conversation-button');

// 새 대화 시작 함수
function startNewConversation() {
    // 대화 내용 초기화
    responseList.innerHTML = '';

    // 필요한 경우 추가 변수 초기화
    // 예: 대화 관련 상태 변수 초기화

    // 입력창 초기화
    promptInput.textContent = '';
    promptInput.focus();
}

// 새 대화 시작 버튼에 이벤트 리스너 추가
newConversationButton.addEventListener('click', startNewConversation);
function startNewConversation() {
    if (confirm('현재 대화를 초기화하고 새 대화를 시작하시겠습니까?')) {
        // 대화 내용 초기화
        responseList.innerHTML = '';
        promptInput.textContent = '';
        promptInput.focus();
    }
}