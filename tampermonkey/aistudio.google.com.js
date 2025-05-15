// ==UserScript==
// @name         aistudio.google.com/prompts/new_chat - Collapsible Code Blocks (v1.0.7)
// @namespace    github.com/openstyles/stylus
// @version      1.0.7
// @description  Сворачиваемые блоки кода. Отладка видимости кнопок в свернутом состоянии.
// @author       Me (adapted for Tampermonkey by AI)
// @match        https://aistudio.google.com/prompts/new_chat*
// @grant        GM_addStyle
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// ==/UserScript==

(function() {
    'use strict';

    console.log('[AI Studio Code Collapse] Script execution started (v1.0.7).');

    const css = `
        /* Базовые стили для обертки блока кода */
        .syntax-highlighted-code-wrapper {
          position: relative;
          max-height: 150px; /* Default collapsed height */
          overflow: hidden;
          transition: max-height 0.3s ease-in-out;
          cursor: pointer;
          border: 1px solid var(--color-surface-container-highest, #303134);
          border-radius: 8px;
          display: flex;
          flex-direction: column;
        }

        .syntax-highlighted-code-wrapper.expanded {
          max-height: 70vh;
          cursor: default;
          /* overflow: hidden; /* Убираем, т.к. скролл на внутреннем */
        }

        /* Контейнер для самого кода (pre) */
        .syntax-highlighted-code-wrapper .syntax-highlighted-code {
          flex-grow: 1;
          position: relative;
          overflow-y: hidden; /* По умолчанию скрыт */
          height: 100%;
        }

        .syntax-highlighted-code-wrapper.expanded .syntax-highlighted-code {
            overflow-y: auto; /* Внутренний скролл при разворачивании */
        }

        /* Отступ для кода, чтобы не перекрывался футером */
        /* Общий отступ для <pre> теперь один, т.к. футер всегда внутри .syntax-highlighted-code */
        .syntax-highlighted-code-wrapper .syntax-highlighted-code pre {
            padding-top: 38px; /* Место для футера, который будет ВНУТРИ .syntax-highlighted-code */
                               /* Высота футера ~36px + небольшой зазор */
        }


        /* Градиент-затемнение внизу свёрнутого блока (индикатор "развернуть") */
        .syntax-highlighted-code-wrapper:not(.expanded)::after {
          content: "Нажмите чтобы развернуть";
          position: absolute;
          bottom: 0;
          left: 0;
          width: 100%;
          height: 40px;
          background: linear-gradient(transparent, var(--color-surface-container-lowest, #111416) 80%);
          color: var(--color-primary, #87a9ff);
          font-size: 12px;
          display: flex;
          justify-content: center;
          align-items: flex-end;
          padding-bottom: 8px;
          opacity: 1;
          transition: opacity 0.3s ease;
          pointer-events: none;
          border-bottom-left-radius: 7px;
          border-bottom-right-radius: 7px;
          z-index: 5; /* Ниже футера, если он absolute */
        }

        .syntax-highlighted-code-wrapper.expanded::after {
          opacity: 0;
          pointer-events: none;
        }

        /* Футер теперь ВСЕГДА ПЕРВЫЙ дочерний элемент .syntax-highlighted-code (перемещается JS) */
        .syntax-highlighted-code-wrapper .syntax-highlighted-code > footer {
          display: flex;
          align-items: center;
          padding: 4px;
          z-index: 10; /* Выше чем ::after и сам код */
          pointer-events: auto;
          box-sizing: border-box;
        }

        /* Футер в СВЕРНУТОМ состоянии: маленький, в углу .syntax-highlighted-code */
        .syntax-highlighted-code-wrapper:not(.expanded) .syntax-highlighted-code > footer {
          position: absolute;
          top: 4px;
          right: 4px;
          background-color: var(--color-surface-container-low, rgba(30,32,35,0.75));
          border-radius: 6px;
          width: auto; /* Только по ширине кнопок */
        }
        .syntax-highlighted-code-wrapper:not(.expanded) .syntax-highlighted-code > footer .collapse-text-indicator {
          display: none !important; /* Важно, чтобы текст "свернуть" точно не показывался */
        }

        /* Футер в РАЗВЕРНУТОМ состоянии: sticky, на всю ширину .syntax-highlighted-code */
        .syntax-highlighted-code-wrapper.expanded .syntax-highlighted-code > footer {
          position: sticky;
          top: 0;
          left: 0;
          width: 100%;
          background-color: var(--color-surface-container-low, rgba(30,32,35,0.92));
          backdrop-filter: blur(4px);
          border-bottom: 1px solid var(--color-surface-container-highest, #303134);
          border-radius: 0;
          padding: 4px 8px;
        }
        .syntax-highlighted-code-wrapper.expanded .syntax-highlighted-code > footer .collapse-text-indicator {
          display: inline !important; /* Важно, чтобы текст "свернуть" показывался */
          content: "Нажмите чтобы свернуть"; /* Устанавливаем текст через content для надежности */
          font-size: 12px;
          color: var(--color-primary, #87a9ff);
          margin-right: auto;
          padding-left: 8px;
          cursor: pointer;
          user-select: none;
        }
         .syntax-highlighted-code-wrapper.expanded .syntax-highlighted-code > footer .collapse-text-indicator:hover {
          text-decoration: underline;
        }

        /* Текстовый индикатор по умолчанию скрыт и не имеет текста */
        .collapse-text-indicator {
            display: none;
        }


        /* Скрываем ненужные текстовые элементы из оригинального футера Google */
        .syntax-highlighted-code-wrapper footer .disclaimer,
        .syntax-highlighted-code-wrapper footer .spacer,
        .syntax-highlighted-code-wrapper footer .language {
          display: none !important;
        }

        /* Кнопки в футере (общие стили) */
        .syntax-highlighted-code-wrapper footer .mat-mdc-icon-button {
          width: 28px;
          height: 28px;
          padding: 2px;
          margin-left: 4px;
          background-color: transparent;
          pointer-events: auto;
          color: var(--color-on-surface-variant, #c4c7c5);
        }
        .syntax-highlighted-code-wrapper footer .mat-mdc-icon-button:hover {
          background-color: rgba(255, 255, 255, 0.15);
        }
        .syntax-highlighted-code-wrapper footer .material-symbols-outlined {
          font-size: 18px;
        }
    `;

    try {
        if (typeof GM_addStyle !== "undefined") {
            GM_addStyle(css);
            console.log('[AI Studio Code Collapse] CSS injected using GM_addStyle.');
        } else {
            const styleSheet = document.createElement("style");
            styleSheet.innerText = css;
            document.head.appendChild(styleSheet);
            console.log('[AI Studio Code Collapse] CSS injected manually.');
        }
    } catch (e) {
        console.error('[AI Studio Code Collapse] Error injecting CSS:', e);
    }

    function prepareCodeBlock(wrapper) {
        const codeContentDiv = wrapper.querySelector('.syntax-highlighted-code');
        let footer = wrapper.querySelector('footer'); // Ищем футер где угодно внутри wrapper (мог быть перемещен)

        if (!codeContentDiv) {
            console.warn('[AI Studio Code Collapse] .syntax-highlighted-code not found in wrapper:', wrapper);
            return;
        }

        // Если оригинальный футер еще не перемещен (т.е. он прямой потомок wrapper)
        const originalFooter = wrapper.querySelector(':scope > footer');
        if (originalFooter) {
            footer = originalFooter; // Используем его
        } else { // Иначе, он уже должен быть внутри codeContentDiv
            footer = codeContentDiv.querySelector(':scope > footer');
        }

        if (!footer) {
            console.error('[AI Studio Code Collapse] CRITICAL: Footer element not found for processing in wrapper:', wrapper);
            return; // Не можем продолжить без футера
        }

        // Перемещаем футер ВНУТРЬ .syntax-highlighted-code, если он еще не там
        if (footer.parentElement !== codeContentDiv) {
            codeContentDiv.insertBefore(footer, codeContentDiv.firstChild);
            // console.log('[AI Studio Code Collapse] Footer moved inside .syntax-highlighted-code for wrapper:', wrapper.id || wrapper);
        }

        // Теперь футер точно внутри codeContentDiv. Гарантируем наличие индикатора.
        let collapseText = footer.querySelector('.collapse-text-indicator');
        if (!collapseText) {
            collapseText = document.createElement('span');
            collapseText.className = 'collapse-text-indicator';
            // Вставляем его перед первой кнопкой (или просто в начало, если кнопок нет)
            const firstButtonOrChild = footer.querySelector('.mat-mdc-icon-button, :scope > *:first-child');
            if (firstButtonOrChild) {
                footer.insertBefore(collapseText, firstButtonOrChild);
            } else {
                footer.appendChild(collapseText); // Или prepend, если footer пуст
            }
            // console.log('[AI Studio Code Collapse] Collapse text indicator SPAN added/ensured for footer in wrapper:', wrapper.id || wrapper);
        }
        // Текст для индикатора теперь полностью управляется CSS через content свойство,
        // так что JS не должен его менять. JS только обеспечивает наличие span.
    }


    // Инициализация для существующих блоков
    document.querySelectorAll('.syntax-highlighted-code-wrapper').forEach(prepareCodeBlock);

    document.addEventListener('click', function(event) {
        const wrapper = event.target.closest('.syntax-highlighted-code-wrapper');
        if (!wrapper) return;

        const clickedActionButton = event.target.closest('.syntax-highlighted-code > footer .mat-mdc-icon-button');
        if (clickedActionButton) {
            return;
        }

        const clickedCollapseText = event.target.closest('.collapse-text-indicator');

        if (event.target === wrapper ||
            (wrapper.contains(event.target) && !clickedActionButton) || // Клик внутри wrapper, но не на кнопке
            clickedCollapseText) {

            wrapper.classList.toggle('expanded');
            // Вызов prepareCodeBlock здесь не нужен, если CSS правильно управляет видимостью и текстом индикатора.
            // Если же prepareCodeBlock нужен для других целей после toggle, можно раскомментировать.
            // prepareCodeBlock(wrapper);

            // Отладочный лог
            // const footerAfterToggle = wrapper.querySelector('.syntax-highlighted-code > footer');
            // console.log(`[AI Studio Code Collapse] Wrapper ${wrapper.id || 'NO_ID'} toggled. Expanded: ${wrapper.classList.contains('expanded')}. Footer display: ${footerAfterToggle ? getComputedStyle(footerAfterToggle).display : 'not found'}`);
        }
    }, true);

    console.log('[AI Studio Code Collapse] Click listener attached.');

    const observer = new MutationObserver(function(mutationsList) {
        for (const mutation of mutationsList) {
            if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
                mutation.addedNodes.forEach(node => {
                    if (node.nodeType === Node.ELEMENT_NODE) {
                        const processNode = (targetNode) => {
                            if (targetNode.matches && targetNode.matches('.syntax-highlighted-code-wrapper')) {
                                // if (!targetNode.id) targetNode.id = `code-block-${Math.random().toString(36).substr(2, 9)}`; // для отладки
                                prepareCodeBlock(targetNode);
                            }
                            const newWrappersInNode = targetNode.querySelectorAll(':scope .syntax-highlighted-code-wrapper');
                            newWrappersInNode.forEach(prepareCodeBlock);
                        };
                        processNode(node);
                    }
                });
            }
        }
    });

    try {
        observer.observe(document.body, { childList: true, subtree: true });
        console.log('[AI Studio Code Collapse] MutationObserver started.');
    } catch (e) {
        console.error('[AI Studio Code Collapse] Error starting MutationObserver:', e);
    }

    console.log('[AI Studio Code Collapse] Script initialization complete.');
})();
