" brew install python-lsp-server, pip install python-lsp-server
packadd lsp

if executable('pylsp')
  call LspAddServer([#{name: 'pylsp',
        \  filetype: 'python',
        \  path: '/opt/homebrew/bin/pylsp',
        \  args: []}])
endif

" if executable('lua-language-server')
" call LspAddServer([#{name: 'lua-language-server',
" \  filetype: 'lua',
" \  path: '/opt/homebrew/bin/lua-language-server',
" \  args: [],
" \  workspaceConfig: #{
" \    Lua: #{
" \      hint: #{
" \        enable: v:true,
" \      }
" \    }
" \  }}])
" endif

" if executable('emmylua_ls')
" call LspAddServer([#{name: 'emmylua_ls',
" \  filetype: 'lua',
" \  path: '/Users/cedre/.cargo/bin/emmylua_ls',
" \  args: []}])
" endif

" if executable('clangd')
" call LspAddServer([#{name: 'clangd',
" \  filetype: ['c', 'cpp', 'objc'],
" \  path: '/usr/bin/clangd',
" \  args: ['-j=8',
" \         '--background-index',
" \         '--background-index-priority=normal',
" \         '--pch-storage=memory',
" \         '--header-insertion=never',
" \         '--limit-references=64',
" \         '--limit-results=16',
" \         '--enable-config']}])
" endif

" if executable('ccls')
" call LspAddServer([#{name: 'ccls',
" \  filetype: ['c', 'cpp', 'objc'],
" \  path: '/opt/homebrew/bin/ccls',
" \  args: ['']}])
" endif

" if executable('pyright')
" call LspAddServer([#{name: 'pyright',
" \  filetype: 'python',
" \  path: '/opt/homebrew/bin/pyright-langserver',
" \  args: ['--stdio'],
" \  workspaceConfig: #{
" \    python: #{
" \      pythonPath: '/Users/cedre/repos/explainable_graphs/.venv/bin/python3'
" \  }}
" \ }])
" endif

" call LspAddServer([#{name: 'ruff',
" \   filetype: 'python',
" \   path: '/opt/homebrew/bin/ruff',
" \   args: [server]
" \ }])
" brew install texlab

call LspOptionsSet(#{aleSupport: v:false,
      \ autoComplete: v:true,
      \ autoHighlight: v:false,
      \ autoHighlightDiags: v:true,
      \ autoPopulateDiags: v:false,
      \ completionMatcher: 'icase',
      \ completionMatcherValue: 1,
      \ diagSignErrorText: '!>',
      \ diagSignHintText: '->',
      \ diagSignInfoText: '=>',
      \ diagSignWarningText: '?>',
      \ echoSignature: v:false,
      \ hideDisabledCodeActions: v:false,
      \ highlightDiagInline: v:true,
      \ hoverInPreview: v:false,
      \ ignoreMissingServer: v:false,
      \ keepFocusInDiags: v:true,
      \ keepFocusInReferences: v:true,
      \ completionTextEdit: v:true,
      \ diagVirtualTextAlign: 'after',
      \ diagVirtualTextWrap: 'truncate',
      \ noNewlineInCompletion: v:true,
      \ omniComplete: v:null,
      \ outlineOnRight: v:true,
      \ outlineWinSize: 32,
      \ semanticHighlight: v:true,
      \ showDiagInBalloon: v:false,
      \ showDiagInPopup: v:true,
      \ showDiagOnStatusLine: v:true,
      \ showDiagWithSign: v:true,
      \ showDiagWithVirtualText: v:false,
      \ showInlayHints: v:false,
      \ showSignature: v:false,
      \ snippetSupport: v:false,
      \ ultisnipsSupport: v:false,
      \ useBufferCompletion: v:false,
      \ usePopupInCodeAction: v:false,
      \ useQuickfixForLocations: v:false,
      \ vsnipSupport: v:false,
      \ bufferCompletionTimeout: 20,
      \ customCompletionKinds: v:false,
      \ completionKinds: {},
      \ filterCompletionDuplicates: v:false})

augroup lsp_settings | au!
  au VimEnter * set keywordprg=:LspHover

  au VimEnter * noremap ]e <cmd>LspDiag nextWrap<cr>
  au VimEnter * noremap [e <cmd>LspDiag prevWrap<cr>

  au VimEnter * nnoremap [d <cmd>botright LspGotoDefinition<cr>
  au VimEnter * nnoremap ]d <cmd>LspGotoDefinition<cr>
  au VimEnter * nnoremap ]D <cmd>LspGotoDeclaration<cr>
  au VimEnter * nnoremap ]i <cmd>LspGotoImpl<cr>
  au VimEnter * nnoremap ]t <cmd>LspGotoTypeDef<cr>

  au VimEnter * nnoremap gd <cmd>LspPeekDefinition<cr>
  au VimEnter * nnoremap gD <cmd>LspPeekDeclaration<cr>
  " au VimEnter * nnoremap gi <cmd>LspPeekImpl<cr>
  au VimEnter * nnoremap gt <cmd>LspPeekTypeDef<cr>

  au VimEnter * nnoremap gm <cmd>LspDiag current<cr>

  au VimEnter * nnoremap gh <cmd>LspDiag highlight toggle<cr>

  au VimEnter * nnoremap gs <cmd>LspShowSignature<cr>
  " au VimEnter * nnoremap gS <cmd>LspHighlightClear<cr>

  " function! s:CheckSig(timer)
  " if g:lsp_trigger_flag
  " let g:lsp_trigger_flag = 0
  " call g:LspShowSignature()
  " endif
  " endfunction

  " let g:lsp_trigger_flag = 0

  " autocmd InsertCharPre call g:LspShowSignature()
  " " autocmd InsertCharPre * if v:char ==# '(' | let g:lsp_trigger_flag = 1 | call timer_start(10, function('s:CheckSig')) | endif
  " " autocmd InsertCharPre * if v:char ==# '{' | let g:lsp_trigger_flag = 1 | call timer_start(10, function('s:CheckSig')) | endif
  " autocmd InsertEnter * call g:LspShowSignature()
augroup END
