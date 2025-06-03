// ==UserScript==
// @name         aistudio.google.com/prompts/new_chat - Collapsible Code Blocks (v1.0.9)
// @namespace    github.com/openstyles/stylus
// @version      1.0.9
// @description  Сворачиваемые блоки кода. Добавлена кнопка сворачивания/разворачивания.
// @author       Me (adapted for Tampermonkey by AI)
// @match        https://aistudio.google.com/prompts/new_chat
// @grant        GM_addStyle
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// ==/UserScript==

(function() {
    'use strict';

    console.log('[AI Studio Code Collapse] Script execution started (v1.0.9).');

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

        /* В развернутом состоянии код не должен сворачиваться при клике */
        .syntax-highlighted-code-wrapper.expanded .syntax-highlighted-code pre {
            cursor: text; /* Указывает, что это текст для выделения */
            pointer-events: auto;
        }

        /* Отступ для кода, чтобы не перекрывался футером */
        .syntax-highlighted-code-wrapper .syntax-highlighted-code pre {
            padding-top: 38px; /* Место для футера */
        }

        /* Градиент-затемнение внизу свёрнутого блока */
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
          z-index: 5;
        }

        .syntax-highlighted-code-wrapper.expanded::after {
          opacity: 0;
          pointer-events: none;
        }

        /* Футер теперь ВСЕГДА ПЕРВЫЙ дочерний элемент .syntax-highlighted-code */
        .syntax-highlighted-code-wrapper .syntax-highlighted-code > footer {
          display: flex;
          align-items: center;
          padding: 4px;
          z-index: 10;
          pointer-events: auto;
          box-sizing: border-box;
        }

        /* Футер в СВЕРНУТОМ состоянии */
        .syntax-highlighted-code-wrapper:not(.expanded) .syntax-highlighted-code > footer {
          position: absolute;
          top: 4px;
          right: 4px;
          background-color: var(--color-surface-container-low, rgba(30,32,35,0.75));
          border-radius: 6px;
          width: auto;
        }
        .syntax-highlighted-code-wrapper:not(.expanded) .syntax-highlighted-code > footer .collapse-text-indicator {
          display: none !important;
        }

        /* Футер в РАЗВЕРНУТОМ состоянии */
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
          display: inline !important;
          content: "Нажмите чтобы свернуть";
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

        /* Текстовый индикатор по умолчанию скрыт */
        .collapse-text-indicator {
            display: none;
        }

        /* Кнопка сворачивания/разворачивания */
        .collapse-toggle-button {
          width: 28px !important;
          height: 28px !important;
          padding: 2px !important;
          margin-left: 4px !important;
          background-color: transparent !important;
          border: none !important;
          cursor: pointer !important;
          border-radius: 4px !important;
          display: flex !important;
          align-items: center !important;
          justify-content: center !important;
          color: var(--color-on-surface-variant, #c4c7c5) !important;
          transition: background-color 0.2s ease !important;
        }
        .collapse-toggle-button:hover {
          background-color: rgba(255, 255, 255, 0.15) !important;
        }
        .collapse-toggle-button .material-symbols-outlined {
          font-size: 18px !important;
          font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 20 !important;
        }

        /* Скрываем ненужные элементы из футера */
        .syntax-highlighted-code-wrapper footer .disclaimer,
        .syntax-highlighted-code-wrapper footer .spacer,
        .syntax-highlighted-code-wrapper footer .language {
          display: none !important;
        }

        /* Кнопки в футере */
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

    function createCollapseButton(wrapper) {
        const button = document.createElement('button');
        button.className = 'collapse-toggle-button';
        button.setAttribute('type', 'button');
        button.setAttribute('aria-label', 'Toggle code block');

        const icon = document.createElement('span');
        icon.className = 'material-symbols-outlined';
        updateButtonIcon(icon, wrapper.classList.contains('expanded'));

        button.appendChild(icon);

        button.addEventListener('click', function(event) {
            event.stopPropagation();
            wrapper.classList.toggle('expanded');
            updateButtonIcon(icon, wrapper.classList.contains('expanded'));
        });

        return button;
    }

    function updateButtonIcon(icon, isExpanded) {
        icon.textContent = isExpanded ? 'expand_less' : 'expand_more';
    }

    function prepareCodeBlock(wrapper) {
        const codeContentDiv = wrapper.querySelector('.syntax-highlighted-code');
        let footer = wrapper.querySelector('footer');

        if (!codeContentDiv) {
            console.warn('[AI Studio Code Collapse] .syntax-highlighted-code not found in wrapper:', wrapper);
            return;
        }

        const originalFooter = wrapper.querySelector(':scope > footer');
        if (originalFooter) {
            footer = originalFooter;
        } else {
            footer = codeContentDiv.querySelector(':scope > footer');
        }

        if (!footer) {
            console.error('[AI Studio Code Collapse] CRITICAL: Footer element not found for processing in wrapper:', wrapper);
            return;
        }

        if (footer.parentElement !== codeContentDiv) {
            codeContentDiv.insertBefore(footer, codeContentDiv.firstChild);
        }

        let collapseText = footer.querySelector('.collapse-text-indicator');
        if (!collapseText) {
            collapseText = document.createElement('span');
            collapseText.className = 'collapse-text-indicator';
            const firstButtonOrChild = footer.querySelector('.mat-mdc-icon-button, :scope > *:first-child');
            if (firstButtonOrChild) {
                footer.insertBefore(collapseText, firstButtonOrChild);
            } else {
                footer.appendChild(collapseText);
            }
        }

        // Добавляем кнопку сворачивания/разворачивания если её еще нет
        let collapseButton = footer.querySelector('.collapse-toggle-button');
        if (!collapseButton) {
            collapseButton = createCollapseButton(wrapper);
            // Добавляем кнопку в конец футера
            footer.appendChild(collapseButton);
        } else {
            // Обновляем иконку существующей кнопки
            const icon = collapseButton.querySelector('.material-symbols-outlined');
            if (icon) {
                updateButtonIcon(icon, wrapper.classList.contains('expanded'));
            }
        }
    }

    // Функция для проверки, есть ли выделенный текст
    function hasTextSelection() {
        const selection = window.getSelection();
        return selection && selection.toString().length > 0;
    }

    // Переменные для отслеживания начала клика
    let mouseDownTarget = null;
    let mouseDownTime = 0;

    document.addEventListener('mousedown', function(event) {
        mouseDownTarget = event.target;
        mouseDownTime = Date.now();
    }, true);

    // Инициализация для существующих блоков
    document.querySelectorAll('.syntax-highlighted-code-wrapper').forEach(prepareCodeBlock);

    document.addEventListener('click', function(event) {
        const wrapper = event.target.closest('.syntax-highlighted-code-wrapper');
        if (!wrapper) return;

        // Проверяем, не кликнули ли на кнопку действия (включая нашу кнопку)
        const clickedActionButton = event.target.closest('.syntax-highlighted-code > footer .mat-mdc-icon-button, .collapse-toggle-button');
        if (clickedActionButton) {
            return;
        }

        // Проверяем клик на текст "свернуть"
        const clickedCollapseText = event.target.closest('.collapse-text-indicator');

        // Если кликнули на индикатор сворачивания - сворачиваем
        if (clickedCollapseText) {
            wrapper.classList.toggle('expanded');
            // Обновляем иконку кнопки
            const button = wrapper.querySelector('.collapse-toggle-button');
            if (button) {
                const icon = button.querySelector('.material-symbols-outlined');
                if (icon) {
                    updateButtonIcon(icon, wrapper.classList.contains('expanded'));
                }
            }
            return;
        }

        // Проверяем, не выделяется ли текст
        if (hasTextSelection()) {
            return; // Не сворачиваем, если есть выделение
        }

        // Проверяем, не кликнули ли на код (pre элемент) в развернутом состоянии
        const clickedOnCode = event.target.closest('pre');
        if (clickedOnCode && wrapper.classList.contains('expanded')) {
            // Дополнительная проверка: если между mousedown и click прошло больше 200ms,
            // то это вероятно было выделение текста
            const timeDiff = Date.now() - mouseDownTime;
            if (timeDiff > 200 || mouseDownTarget !== event.target) {
                return; // Не сворачиваем
            }
        }

        // Разворачиваем только если:
        // 1. Кликнули прямо на wrapper
        // 2. Кликнули на пустое место внутри wrapper (но не на код)
        // 3. Блок свернут
        if ((event.target === wrapper ||
             (wrapper.contains(event.target) && !clickedOnCode)) &&
            !wrapper.classList.contains('expanded')) {
            wrapper.classList.add('expanded');
            // Обновляем иконку кнопки
            const button = wrapper.querySelector('.collapse-toggle-button');
            if (button) {
                const icon = button.querySelector('.material-symbols-outlined');
                if (icon) {
                    updateButtonIcon(icon, true);
                }
            }
        }
        // Сворачиваем только если кликнули на wrapper напрямую в развернутом состоянии
        else if (event.target === wrapper && wrapper.classList.contains('expanded')) {
            wrapper.classList.remove('expanded');
            // Обновляем иконку кнопки
            const button = wrapper.querySelector('.collapse-toggle-button');
            if (button) {
                const icon = button.querySelector('.material-symbols-outlined');
                if (icon) {
                    updateButtonIcon(icon, false);
                }
            }
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
