*ale.txt* Plugin to lint and fix files asynchronously
*ale*

ALE - Asynchronous Lint Engine

===============================================================================
CONTENTS                                                         *ale-contents*

  1. Introduction.........................|ale-introduction|
  2. Supported Languages & Tools..........|ale-support|
  3. Linting..............................|ale-lint|
    3.1 Linting On Other Machines.........|ale-lint-other-machines|
    3.2 Adding Language Servers...........|ale-lint-language-servers|
    3.3 Other Sources.....................|ale-lint-other-sources|
  4. Fixing Problems......................|ale-fix|
  5. Language Server Protocol Support.....|ale-lsp|
    5.1 Completion........................|ale-completion|
    5.2 Go To Definition..................|ale-go-to-definition|
    5.3 Go To Type Definition.............|ale-go-to-type-definition|
    5.4 Go To Implementation..............|ale-go-to-type-implementation|
    5.5 Find References...................|ale-find-references|
    5.6 Hovering..........................|ale-hover|
    5.7 Symbol Search.....................|ale-symbol-search|
    5.8 Refactoring: Rename, Actions......|ale-refactor|
  6. Global Options.......................|ale-options|
    6.1 Highlights........................|ale-highlights|
  7. Linter/Fixer Options.................|ale-integration-options|
    7.1 Options for alex..................|ale-alex-options|
    7.2 Options for cspell................|ale-cspell-options|
    7.3 Options for languagetool..........|ale-languagetool-options|
    7.4 Options for write-good............|ale-write-good-options|
    7.5 Other Linter/Fixer Options........|ale-other-integration-options|
  8. Commands/Keybinds....................|ale-commands|
  9. API..................................|ale-api|
  10. Special Thanks......................|ale-special-thanks|
  11. Contact.............................|ale-contact|

===============================================================================
1. Introduction                                              *ale-introduction*

ALE provides the means to run linters asynchronously in Vim in a variety of
languages and tools. ALE sends the contents of buffers to linter programs
using the |job-control| features available in Vim 8 and NeoVim. For Vim 8,
Vim must be compiled with the |job| and |channel| and |timers| features
as a minimum.

ALE supports the following key features for linting:

1. Running linters when text is changed.
2. Running linters when files are opened.
3. Running linters when files are saved. (When a global flag is set.)
4. Populating the |loclist| with warning and errors.
5. Setting |signs| with warnings and errors for error markers.
6. Using |echo| to show error messages when the cursor moves.
7. Setting syntax highlights for errors.

ALE can fix problems with files with the |ALEFix| command, using the same job
control functionality used for checking for problems. Try using the
|ALEFixSuggest| command for browsing tools that can be used to fix problems
for the current buffer.

If you are interested in contributing to the development of ALE, read the
developer documentation. See |ale-development|

===============================================================================
2. Supported Languages & Tools                                    *ale-support*

ALE supports a wide variety of languages and tools. See |ale-supported-list|
for the full list.

===============================================================================
3. Linting                                                           *ale-lint*

ALE's primary focus is on checking for problems with your code with various
programs via some Vim code for integrating with those programs, referred to
as 'linters.' ALE supports a wide array of programs for linting by default,
but additional programs can be added easily by defining files in |runtimepath|
with the filename pattern `ale_linters/<filetype>/<filename>.vim`. For more
information on defining new linters, see the extensive documentation
for |ale#linter#Define()|.

Without any configuration, ALE will attempt to check all of the code for every
file you open in Vim with all available tools by default. To see what ALE
is doing, and what options have been set, try using the |:ALEInfo| command.

Most of the linters ALE runs will check the Vim buffer you are editing instead
of the file on disk. This allows you to check your code for errors before you
have even saved your changes. ALE will check your code in the following
circumstances, which can be configured with the associated options.

* When you modify a buffer.                - |g:ale_lint_on_text_changed|
* On leaving insert mode.                  - |g:ale_lint_on_insert_leave|
* When you open a new or modified buffer.  - |g:ale_lint_on_enter|
* When you save a buffer.                  - |g:ale_lint_on_save|
* When the filetype changes for a buffer.  - |g:ale_lint_on_filetype_changed|
* If ALE is used to check code manually.   - |:ALELint|

                                                 *ale-lint-settings-on-startup*

It is worth reading the documentation for every option. You should configure
which events ALE will use before ALE is loaded, so it can optimize which
autocmd commands to run. You can force autocmd commands to be reloaded with
`:ALEDisable | ALEEnable`

This also applies to the autocmd commands used for |g:ale_echo_cursor|.

                                                        *ale-lint-file-linters*

Some programs must be run against files which have been saved to disk, and
simply do not support reading temporary files or stdin, either of which are
required for ALE to be able to check for errors as you type. The programs
which behave this way are documented in the lists and tables of supported
programs. ALE will only lint files with these programs in the following
circumstances.

* When you open a new or modified buffer.  - |g:ale_lint_on_enter|
* When you save a buffer.                  - |g:ale_lint_on_save|
* When the filetype changes for a buffer.  - |g:ale_lint_on_filetype_changed|
* If ALE is used to check code manually.   - |:ALELint|

ALE will report problems with your code in the following ways, listed with
their relevant options.

* By updating loclist. (On by default)             - |g:ale_set_loclist|
* By updating quickfix. (Off by default)           - |g:ale_set_quickfix|
* By setting error highlights.                     - |g:ale_set_highlights|
* By creating signs in the sign column.            - |g:ale_set_signs|
* By echoing messages based on your cursor.        - |g:ale_echo_cursor|
* By inline text based on your cursor.             - |g:ale_virtualtext_cursor|
* By displaying the preview based on your cursor.  - |g:ale_cursor_detail|
* By showing balloons for your mouse cursor        - |g:ale_set_balloons|

Please consult the documentation for each option, which can reveal some other
ways of tweaking the behavior of each way of displaying problems. You can
disable or enable whichever options you prefer.

Most settings can be configured for each buffer. (|b:| instead of |g:|),
including disabling ALE for certain buffers with |b:ale_enabled|. The
|g:ale_pattern_options| setting can be used to configure files differently
based on regular expressions for filenames. For configuring entire projects,
the buffer-local options can be used with external plugins for reading Vim
project configuration files. Buffer-local settings can also be used in
ftplugin files for different filetypes.

ALE offers several options for controlling which linters are run.

* Selecting linters to run.            - |g:ale_linters|
* Aliasing filetypes for linters       - |g:ale_linter_aliases|
* Only running linters you asked for.  - |g:ale_linters_explicit|
* Disabling only a subset of linters.  - |g:ale_linters_ignore|
* Disabling LSP linters and `tsserver`.  - |g:ale_disable_lsp|

You can stop ALE any currently running linters with the |ALELintStop| command.
Any existing problems will be kept.

-------------------------------------------------------------------------------
3.1 Linting On Other Machines                         *ale-lint-other-machines*

ALE offers support for running linters or fixers on files you are editing
locally on other machines, so long as the other machine has access to the file
you are editing. This could be a linter or fixer run inside of a Docker image,
running in a virtual machine, running on a remote server, etc.

In order to run tools on other machines, you will need to configure your tools
to run via scripts that execute commands on those machines, such as by setting
the ALE `_executable` options for those tools to a path for a script to run,
or by using |g:ale_command_wrapper| to specify a script to wrap all commands
that are run by ALE, before they are executed. For tools that ALE runs where
ALE looks for locally installed executables first, you may need to set the
`_use_global` options for those tools to `1`, or you can set
|g:ale_use_global_executables| to `1` before ALE is loaded to only use global
executables for all tools.

In order for ALE to properly lint or fix files which are running on another
file system, you must provide ALE with |List|s of strings for mapping paths to
and from your local file system and the remote file system, such as the file
system of your Docker container. See |g:ale_filename_mappings| for all of the
different ways these filename mappings can be configured.

For example, you might configure `pylint` to run via Docker by creating a
script like so. >

  #!/usr/bin/env bash

  exec docker run -i --rm -v "$(pwd):/data" cytopia/pylint "$@"
<

You will run to run Docker commands with `-i` in order to read from stdin.

With the above script in mind, you might configure ALE to lint your Python
project with `pylint` by providing the path to the script to execute, and
mappings which describe how to between the two file systems in your
`python.vim` |ftplugin| file, like so: >

  if expand('%:p') =~# '^/home/w0rp/git/test-pylint/'
    let b:ale_linters = ['pylint']
    let b:ale_python_pylint_use_global = 1
    " This is the path to the script above.
    let b:ale_python_pylint_executable = '/home/w0rp/git/test-pylint/pylint.sh'
    " /data matches the path in Docker.
    let b:ale_filename_mappings = {
    \ 'pylint': [
    \   ['/home/w0rp/git/test-pylint', '/data'],
    \ ],
    \}
  endif
<

You might consider using a Vim plugin for loading Vim configuration files
specific to each project, if you have a lot of projects to manage.


-------------------------------------------------------------------------------
3.2 Adding Language Servers                         *ale-lint-language-servers*

ALE comes with many default configurations for language servers, so they can
be detected and run automatically. ALE can connect to other language servers
by defining a new linter for a filetype. New linters can be defined in |vimrc|,
in plugin files, or `ale_linters` directories in |runtimepath|.

See |ale-linter-loading-behavior| for more information on loading linters.

A minimal configuration for a language server linter might look so. >

  call ale#linter#Define('filetype_here', {
  \   'name': 'any_name_you_want',
  \   'lsp': 'stdio',
  \   'executable': '/path/to/executable',
  \   'command': '%e run',
  \   'project_root': '/path/to/root_of_project',
  \})
<
For language servers that use a TCP or named pipe socket connection, you
should define the address to connect to instead. >

  call ale#linter#Define('filetype_here', {
  \   'name': 'any_name_you_want',
  \   'lsp': 'socket',
  \   'address': 'servername:1234',
  \   'project_root': '/path/to/root_of_project',
  \})
<
  Most of the options for a language server can be replaced with a |Funcref|
  for a function accepting a buffer number for dynamically computing values
  such as the executable path, the project path, the server address, etc,
  most of which can also be determined based on executing some other
  asynchronous task. See |ale#command#Run()| for computing linter options
  based on asynchronous results.

  See |ale#linter#Define()| for a detailed explanation of all of the options
  for configuring linters.


-------------------------------------------------------------------------------
3.3 Other Sources                                      *ale-lint-other-sources*

Problems for a buffer can be taken from other sources and rendered by ALE.
This allows ALE to be used in combination with other plugins which also want
to display any problems they might find with a buffer. ALE's API includes the
following components for making this possible.

* |ale#other_source#StartChecking()| - Tell ALE that a buffer is being checked.
* |ale#other_source#ShowResults()|   - Show results from another source.
* |ALEWantResults|                   - A signal for when ALE wants results.

Other resources can provide results for ALE to display at any time, following
ALE's loclist format. (See |ale-loclist-format|) For example: >

  " Tell ALE to show some results.
  " This function can be called at any time.
  call ale#other_source#ShowResults(bufnr(''), 'some-linter-name', [
  \ {'text': 'Something went wrong', 'lnum': 13},
  \])
<

Other sources should use a unique name for identifying themselves. A single
linter name can be used for all problems from another source, or a series of
unique linter names can be used. Results can be cleared for that source by
providing an empty List.

|ale#other_source#StartChecking()| should be called whenever another source
starts checking a buffer, so other tools can know that a buffer is being
checked by some plugin. The |ALEWantResults| autocmd event can be used to
start checking a buffer for problems every time that ALE does. When
|ALEWantResults| is signaled, |g:ale_want_results_buffer| will be set to the
number of the buffer that ALE wants to check.
|ale#other_source#StartChecking()| should be called synchronously, and other
sources should perform their checks on a buffer in the background
asynchronously, so they don't interrupt editing.

|ale#other_source#ShowResults()| must not be called synchronously before
ALE's engine executes its code after the |ALEWantResults| event runs. If
there are immediate results to provide to ALE, a 0 millisecond timer with
|timer_start()| can be set instead up to call |ale#other_source#ShowResults()|
after ALE has first executed its engine code for its own sources.

A plugin might integrate its own checks with ALE like so: >

  augroup SomeGroupName
    autocmd!
    autocmd User ALEWantResults call Hook(g:ale_want_results_buffer)
  augroup END

  function! DoBackgroundWork(buffer) abort
    " Start some work in the background here.
    " ...
    " Then call WorkDone(a:buffer, results)
  endfunction

  function! Hook(buffer) abort
    " Tell ALE we're going to check this buffer.
    call ale#other_source#StartChecking(a:buffer, 'some-name')
    call DoBackgroundWork(a:buffer)
  endfunction

  function! WorkDone(buffer, results) abort
    " Send results to ALE after they have been collected.
    call ale#other_source#ShowResults(a:buffer, 'some-name', a:results)
  endfunction
<

===============================================================================
4. Fixing Problems                                                    *ale-fix*

ALE can fix problems with files with the |ALEFix| command. |ALEFix|
accepts names of fixers to be applied as arguments. Alternatively,
when no arguments are provided, the variable |g:ale_fixers| will be
read for getting a |List| of commands for filetypes, split on `.`, and
the functions named in |g:ale_fixers| will be executed for fixing the
errors.

The |ALEFixSuggest| command can be used to suggest tools that be used to
fix problems for the current buffer.

The values for `g:ale_fixers` can be a list of |String|, |Funcref|, or
|lambda| values. String values must either name a function, or a short name
for a function set in the ALE fixer registry.

Each function for fixing errors must accept either one argument `(buffer)` or
two arguments `(buffer, lines)`, representing the buffer being fixed and the
lines to fix. The functions must return either `0`, for changing nothing, a
|List| for new lines to set, a |Dictionary| for describing a command to be
run in the background, or the result of |ale#command#Run()|.

Functions receiving a variable number of arguments will not receive the second
argument `lines`. Functions should name two arguments if the `lines` argument
is desired. This is required to avoid unnecessary copying of the lines of
the buffers being checked.

When a |Dictionary| is returned for an |ALEFix| callback, the following keys
are supported for running the commands.

  `cwd`                 An optional |String| for setting the working directory
                      for the command.

                      If not set, or `v:null`, the `cwd` of the last command
                      that spawn this one will be used.

  `command`             A |String| for the command to run. This key is required.

                      When `%t` is included in a command string, a temporary
                      file will be created, containing the lines from the file
                      after previous adjustment have been done.

                      See |ale-command-format-strings| for formatting options.

  `read_temporary_file` When set to `1`, ALE will read the contents of the
                      temporary file created for `%t`. This option can be used
                      for commands which need to modify some file on disk in
                      order to fix files.

  `process_with`        An optional callback for post-processing.

                      The callback must accept arguments `(bufnr, output)`:
                      the buffer number undergoing fixing and the fixer's
                      output as a |List| of |String|s. It must return a |List|
                      of |String|s that will be the new contents of the
                      buffer.

                      This callback is useful to remove excess lines from the
                      command's output or apply additional changes to the
                      output.


  `read_buffer`         An optional key for disabling reading the buffer.

                      When set to `0`, ALE will not pipe the buffer's data
                      into the command via stdin. This option is ignored and
                      the buffer is not read when `read_temporary_file` is
                      `1`.

                      This option defaults to `1`.

                                                        *ale-fix-configuration*

Synchronous functions and asynchronous jobs will be run in a sequence for
fixing files, and can be combined. For example:
>
  let g:ale_fixers = {
  \   'javascript': [
  \       'DoSomething',
  \       'eslint',
  \       {buffer, lines -> filter(lines, 'v:val !=~ ''^\s*//''')},
  \   ],
  \}

  ALEFix
<
The above example will call a function called `DoSomething` which could act
upon some lines immediately, then run `eslint` from the ALE registry, and
then call a lambda function which will remove every single line comment
from the file.

For buffer-local settings, such as in |g:ale_pattern_options| or in ftplugin
files, a |List| may be used for configuring the fixers instead.
>
  " Same as the above, only a List can be used instead of a Dictionary.
  let b:ale_fixers = [
  \   'DoSomething',
  \   'eslint',
  \   {buffer, lines -> filter(lines, 'v:val !=~ ''^\s*//''')},
  \]

  ALEFix
<
For convenience, a plug mapping is defined for |ALEFix|, so you can set up a
keybind easily for fixing files. >

  " Bind F8 to fixing problems with ALE
  nmap <F8> <Plug>(ale_fix)
<
Files can be fixed automatically with the following options, which are all off
by default.

|g:ale_fix_on_save| - Fix files when they are saved.

Fixers can be disabled on save with |g:ale_fix_on_save_ignore|. They will
still be run when you manually run |ALEFix|.

Fixers can be run on another machines, just like linters, such as fixers run
from a Docker container, running in a virtual machine, running a remote
server, etc. See |ale-lint-other-machines|.


===============================================================================
5. Language Server Protocol Support                                   *ale-lsp*

ALE offers some support for integrating with Language Server Protocol (LSP)
servers. LSP linters can be used in combination with any other linter, and
will automatically connect to LSP servers when needed. ALE also supports
`tsserver` for TypeScript, which uses a different but very similar protocol.

If you want to use another plugin for LSP features and tsserver, you can use
the |g:ale_disable_lsp| setting to disable ALE's own LSP integrations, or
ignore particular linters with |g:ale_linters_ignore|.

-------------------------------------------------------------------------------
5.1 Completion                                                 *ale-completion*

ALE offers support for automatic completion of code while you type.
Completion is only supported while at least one LSP linter is enabled. ALE
will only suggest symbols provided by the LSP servers.

                                                     *ale-deoplete-integration*

ALE integrates with Deoplete for offering automatic completion data. ALE's
completion source for Deoplete is named `'ale'`, and should enabled
automatically if Deoplete is enabled and configured correctly. Deoplete
integration should not be combined with ALE's own implementation.

                                                 *ale-asyncomplete-integration*

ALE additionally integrates with asyncomplete.vim for offering automatic
completion data. ALE's asyncomplete source requires registration and should
use the defaults provided by the |asyncomplete#sources#ale#get_source_options| function >

  " Use ALE's function for asyncomplete defaults
  au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options({
      \ 'priority': 10, " Provide your own overrides here
      \ }))
>
ALE also offers its own completion implementation, which does not require any
other plugins. Suggestions will be made while you type after completion is
enabled. ALE's own completion implementation can be enabled by setting
|g:ale_completion_enabled| to `1`. This setting must be set to `1` before ALE
is loaded. The delay for completion can be configured with
|g:ale_completion_delay|. This setting should not be enabled if you wish to
use ALE as a completion source for other plugins.

ALE automatic completion will not work when 'paste' is active. Only set
'paste' when you are copy and pasting text into your buffers.

ALE automatic completion will interfere with default insert completion with
`CTRL-N` and so on (|compl-vim|). You can write your own keybinds and a
function in your |vimrc| file to force insert completion instead, like so: >

  function! SmartInsertCompletion() abort
    " Use the default CTRL-N in completion menus
    if pumvisible()
      return "\<C-n>"
    endif

    " Exit and re-enter insert mode, and use insert completion
    return "\<C-c>a\<C-n>"
  endfunction

  inoremap <silent> <C-n> <C-R>=SmartInsertCompletion()<CR>
<
ALE provides an 'omnifunc' function |ale#completion#OmniFunc| for triggering
completion manually with CTRL-X CTRL-O. |i_CTRL-X_CTRL-O| >

  " Use ALE's function for omnicompletion.
  set omnifunc=ale#completion#OmniFunc
<
                                                      *ale-completion-fallback*

You can write your own completion function and fallback on other methods of
completion by checking if there are no results that ALE can determine. For
example, for Python code, you could fall back on the `python3complete`
function. >

  function! TestCompletionFunc(findstart, base) abort
    let l:result = ale#completion#OmniFunc(a:findstart, a:base)

    " Check if ALE couldn't find anything.
    if (a:findstart && l:result is -3)
    \|| (!a:findstart && empty(l:result))
      " Defer to another omnifunc if ALE couldn't find anything.
      return python3complete#Complete(a:findstart, a:base)
    endif

    return l:result
  endfunction

  set omnifunc=TestCompletionFunc
<
See |complete-functions| for documentation on how to write completion
functions.

ALE will only suggest so many possible matches for completion. The maximum
number of items can be controlled with |g:ale_completion_max_suggestions|.

If you don't like some of the suggestions you see, you can filter them out
with |g:ale_completion_excluded_words| or |b:ale_completion_excluded_words|.

The |ALEComplete| command can be used to show completion suggestions manually,
even when |g:ale_completion_enabled| is set to `0`. For manually requesting
completion information with Deoplete, consult Deoplete's documentation.

ALE supports automatic imports from external modules. This behavior can be
disabled by setting the |g:ale_completion_autoimport| variable to `0`.
Disabling automatic imports can drop some or all completion items from
some LSP servers (e.g. eclipselsp).

You can manually request imports for symbols at the cursor with the
|ALEImport| command. The word at the cursor must be an exact match for some
potential completion result which includes additional text to insert into the
current buffer, which ALE will assume is code for an import line. This command
can be useful when your code already contains something you need to import.

You can execute other commands whenever ALE inserts some completion text with
the |ALECompletePost| event.

When working with TypeScript files, ALE can remove warnings from your
completions by setting the |g:ale_completion_tsserver_remove_warnings|
variable to 1.

                                               *ale-completion-completeopt-bug*

ALE Automatic completion implementation replaces |completeopt| before opening
the omnicomplete menu with <C-x><C-o>. In some versions of Vim, the value set
for the option will not be respected. If you experience issues with Vim
automatically inserting text while you type, set the following option in
vimrc, and your issues should go away. >

  set completeopt=menu,menuone,preview,noselect,noinsert
<
Or alternatively, if you want to show documentation in popups: >

  set completeopt=menu,menuone,popup,noselect,noinsert
<
                                                                  *ale-symbols*

ALE provides a set of basic completion symbols. If you want to replace those
symbols with others, you can set the variable |g:ale_completion_symbols| with
a mapping of the type of completion to the symbol or other string that you
would like to use. An example here shows the available options for symbols  >

  let g:ale_completion_symbols = {
  \ 'text': '',
  \ 'method': '',
  \ 'function': '',
  \ 'constructor': '',
  \ 'field': '',
  \ 'variable': '',
  \ 'class': '',
  \ 'interface': '',
  \ 'module': '',
  \ 'property': '',
  \ 'unit': 'unit',
  \ 'value': 'val',
  \ 'enum': '',
  \ 'keyword': 'keyword',
  \ 'snippet': '',
  \ 'color': 'color',
  \ 'file': '',
  \ 'reference': 'ref',
  \ 'folder': '',
  \ 'enum member': '',
  \ 'constant': '',
  \ 'struct': '',
  \ 'event': 'event',
  \ 'operator': '',
  \ 'type_parameter': 'type param',
  \ '<default>': 'v'
  \ }
<
-------------------------------------------------------------------------------
5.2 Go To Definition                                     *ale-go-to-definition*

ALE supports jumping to the files and locations where symbols are defined
through any enabled LSP linters. The locations ALE will jump to depend on the
information returned by LSP servers. The |ALEGoToDefinition| command will jump
to the definition of symbols under the cursor. See the documentation for the
command for configuring how the location will be displayed.

ALE will update Vim's |tagstack| automatically unless |g:ale_update_tagstack| is
set to `0`.

-------------------------------------------------------------------------------
5.3 Go To Type Definition                           *ale-go-to-type-definition*

ALE supports jumping to the files and locations where symbols' types are
defined through any enabled LSP linters. The locations ALE will jump to depend
on the information returned by LSP servers. The |ALEGoToTypeDefinition|
command will jump to the definition of symbols under the cursor. See the
documentation for the command for configuring how the location will be
displayed.

-------------------------------------------------------------------------------
5.4 Go To Implementation                             *ale-go-to-implementation*

ALE supports jumping to the files and locations where symbols are implemented
through any enabled LSP linters. The locations ALE will jump to depend on the
information returned by LSP servers. The |ALEGoToImplementation| command will
jump to the implementation of symbols under the cursor. See the documentation
for the command for configuring how the location will be displayed.

-------------------------------------------------------------------------------
5.5 Find References                                       *ale-find-references*

ALE supports finding references for symbols though any enabled LSP linters
with the |ALEFindReferences| command. See the documentation for the command
for a full list of options.

-------------------------------------------------------------------------------
5.6 Hovering                                                        *ale-hover*

ALE supports "hover" information for printing brief information about symbols
at the cursor taken from LSP linters. The following commands are supported:

|ALEHover| - Print information about the symbol at the cursor.

Truncated information will be displayed when the cursor rests on a symbol by
default, as long as there are no problems on the same line. You can disable
this behavior by setting |g:ale_hover_cursor| to `0`.

If |g:ale_set_balloons| is set to `1` and your version of Vim supports the
|balloon_show()| function, then "hover" information also show up when you move
the mouse over a symbol in a buffer. Diagnostic information will take priority
over hover information for balloons. If a line contains a problem, that
problem will be displayed in a balloon instead of hover information.

Hover information can be displayed in the preview window instead by setting
|g:ale_hover_to_preview| to `1`.

When using Neovim or Vim with |popupwin|, if |g:ale_hover_to_floating_preview|
or |g:ale_floating_preview| is set to 1, the hover information will show in a
floating window. And |g:ale_floating_window_border| for the border setting.

For Vim 8.1+ terminals, mouse hovering is disabled by default. Enabling
|balloonexpr| commands in terminals can cause scrolling issues in terminals,
so ALE will not attempt to show balloons unless |g:ale_set_balloons| is set to
`1` before ALE is loaded.

For enabling mouse support in terminals, you may have to change your mouse
settings. For example: >

  " Example mouse settings.
  " You will need to try different settings, depending on your terminal.
  set mouse=a
  set ttymouse=xterm
<

Documentation for symbols at the cursor can be retrieved using the
|ALEDocumentation| command. This command is only available for `tsserver`.

-------------------------------------------------------------------------------
5.7 Symbol Search                                           *ale-symbol-search*

ALE supports searching for workspace symbols via LSP linters with the
|ALESymbolSearch| command. See the documentation for the command
for a full list of options.

-------------------------------------------------------------------------------
5.8 Refactoring: Rename, Actions                                 *ale-refactor*

ALE supports renaming symbols in code such as variables or class names with
the |ALERename| command.

`ALEFileRename` will rename file and fix import paths (tsserver only).

|ALECodeAction| will execute actions on the cursor or applied to a visual
range selection, such as automatically fixing errors.

Actions will appear in the right click mouse menu by default for GUI versions
of Vim, unless disabled by setting |g:ale_popup_menu_enabled| to `0`.

Make sure to set your Vim to move the cursor position whenever you right
click, and enable the mouse menu: >

  set mouse=a
  set mousemodel=popup_setpos
<
You may wish to remove some other menu items you don't want to see: >

  silent! aunmenu PopUp.Select\ Word
  silent! aunmenu PopUp.Select\ Sentence
  silent! aunmenu PopUp.Select\ Paragraph
  silent! aunmenu PopUp.Select\ Line
  silent! aunmenu PopUp.Select\ Block
  silent! aunmenu PopUp.Select\ Blockwise
  silent! aunmenu PopUp.Select\ All
<
===============================================================================
6. Global Options                                                 *ale-options*

g:airline#extensions#ale#enabled             *g:airline#extensions#ale#enabled*

  Type: |Number|
  Default: `1`

  Enables or disables the |airline|'s native extension for ale, which displays
  warnings and errors in the status line, prefixed by
  |airline#extensions#ale#error_symbol| and
  |airline#extensions#ale#warning_symbol|.


g:ale_cache_executable_check_failures   *g:ale_cache_executable_check_failures*

  Type: |Number|
  Default: undefined

  When set to `1`, ALE will cache failing executable checks for linters. By
  default, only executable checks which succeed will be cached.

  When this option is set to `1`, Vim will have to be restarted after new
  executables are installed for ALE to be able to run linters for those
  executables.


g:ale_change_sign_column_color                 *g:ale_change_sign_column_color*

  Type: |Number|
  Default: `0`

  When set to `1`, this option will set different highlights for the sign
  column itself when ALE reports problems with a file. This option can be
  combined with |g:ale_sign_column_always|.

  ALE uses the following highlight groups for highlighting the sign column:

  `ALESignColumnWithErrors`    -  Links to `error` by default.
  `ALESignColumnWithoutErrors` -  Uses the value for `SignColumn` by default.

  The sign column color can only be changed globally in Vim. The sign column
  might produce unexpected results if editing different files in split
  windows.


g:ale_close_preview_on_insert                   *g:ale_close_preview_on_insert*

  Type: |Number|
  Default: `0`

  When this option is set to `1`, ALE's |preview-window| will be automatically
  closed upon entering Insert Mode. This option can be used in combination
  with |g:ale_cursor_detail| for automatically displaying the preview window
  on problem lines, and automatically closing it again when editing text.

  This setting must be set to `1` before ALE is loaded for this behavior
  to be enabled. See |ale-lint-settings-on-startup|.


g:ale_command_wrapper                                   *g:ale_command_wrapper*
                                                        *b:ale_command_wrapper*
  Type: |String|
  Default: `''`

  An option for wrapping all commands that ALE runs, for linters, fixers,
  and LSP commands. This option can be set globally, or for specific buffers.

  This option can be used to apply nice to all commands. For example: >

    " Prefix all commands with nice.
    let g:ale_command_wrapper = 'nice -n5'
<
  Use the |ALEInfo| command to view the commands that are run. All of the
  arguments for commands will be put on the end of the wrapped command by
  default. A `%*` marker can be used to spread the arguments in the wrapped
  command. >

    " Has the same effect as the above.
    let g:ale_command_wrapper = 'nice -n5 %*'
<

  For passing all of the arguments for a command as one argument to a wrapper,
  `%@` can be used instead. >

    " Will result in say: /bin/bash -c 'other-wrapper -c "some command" -x'
    let g:ale_command_wrapper = 'other-wrapper -c %@ -x'
<
  For commands including `&&` or `;`, only the last command in the list will
  be passed to the wrapper. `&&` is most commonly used in ALE to change the
  working directory before running a command.


g:ale_completion_delay                                 *g:ale_completion_delay*

  Type: |Number|
  Default: `100`

  The number of milliseconds before ALE will send a request to a language
  server for completions after you have finished typing.

  See |ale-completion|


g:ale_completion_enabled                             *g:ale_completion_enabled*
                                                     *b:ale_completion_enabled*

  Type: |Number|
  Default: `0`

  When this option is set to `1`, completion support will be enabled.

  This setting must be set to `1` before ALE is loaded for this behavior
  to be enabled.

  This setting should not be enabled if you wish to use ALE as a completion
  source for other completion plugins.

  ALE automatic completion will not work when 'paste' is active. Only set
  'paste' when you are copy and pasting text into your buffers.

  A buffer-local version of this setting `b:ale_completion_enabled` can be set
  to `0` to disable ALE's automatic completion support for a single buffer.
  ALE's completion support must be enabled globally to be enabled locally.

  See |ale-completion|


                                    *g:ale_completion_tsserver_remove_warnings*
g:ale_completion_tsserver_remove_warnings

  Type: Number
  Default: `0`

  When this option is set to `0`, ALE will return all completion items,
  including those that are a warning. Warnings can be excluded from completed
  items by setting it to `1`.


g:ale_completion_autoimport                       *g:ale_completion_autoimport*

  Type: Number
  Default: `1`

  When this option is set to `1`, ALE will try to automatically import
  completion results from external modules. It can be disabled by setting it
  to `0`. Some LSP servers include auto imports on every completion item so
  disabling automatic imports may drop some or all completion items returnend
  by it (e.g. eclipselsp).


g:ale_completion_excluded_words               *g:ale_completion_excluded_words*
                                              *b:ale_completion_excluded_words*
  Type: |List|
  Default: `[]`

  This option can be set to a list of |String| values for "words" to exclude
  from completion results, as in the words for |complete-items|. The strings
  will be matched exactly in a case-sensitive manner. (|==#|)

  This setting can be configured in ftplugin files with buffer variables, so
  that different lists can be used for different filetypes. For example: >

  " In ~/.vim/ftplugin/typescript.vim

  " Don't suggest `it` or `describe` so we can use snippets for those words.
  let b:ale_completion_excluded_words = ['it', 'describe']
<

g:ale_completion_symbols                             *g:ale_completion_symbols*

  Type: |Dictionary|


  A mapping from completion types to symbols for completions. See
  |ale-symbols| for more information.

  By default, this mapping only uses built in Vim completion kinds, but it can
  be updated to use any unicode character for the completion kind. For
  example: >
    let g:ale_completion_symbols = {
    \ 'text': '',
    \ 'method': '',
    \ 'function': '',
    \ 'constructor': '',
    \ 'field': '',
    \ 'variable': '',
    \ 'class': '',
    \ 'interface': '',
    \ 'module': '',
    \ 'property': '',
    \ 'unit': 'v',
    \ 'value': 'v',
    \ 'enum': 't',
    \ 'keyword': 'v',
    \ 'snippet': 'v',
    \ 'color': 'v',
    \ 'file': 'v',
    \ 'reference': 'v',
    \ 'folder': 'v',
    \ 'enum_member': 'm',
    \ 'constant': 'm',
    \ 'struct': 't',
    \ 'event': 'v',
    \ 'operator': 'f',
    \ 'type_parameter': 'p',
    \ '<default>': 'v'
    \ })
<

g:ale_completion_max_suggestions             *g:ale_completion_max_suggestions*

  Type: |Number|
  Default: `50`

  The maximum number of items ALE will suggest in completion menus for
  automatic completion.

  Setting this number higher will require more processing time, and may
  suggest too much noise. Setting this number lower will require less
  processing time, but some suggestions will not be included, so you might not
  be able to see the suggestions you want.

  Adjust this option as needed, depending on the complexity of your codebase
  and your available processing power.

g:ale_cursor_detail                                       *g:ale_cursor_detail*

  Type: |Number|
  Default: `0`

  When this option is set to `1`, ALE's |preview-window| will be automatically
  opened when the cursor moves onto lines with problems. ALE will search for
  problems using the same logic that |g:ale_echo_cursor| uses. The preview
  window will be closed automatically when you move away from the line.

  Messages are only displayed after a short delay. See |g:ale_echo_delay|.

  The preview window is opened without stealing focus, which means your cursor
  will stay in the same buffer as it currently is.

  The preview window can be closed automatically upon entering Insert mode
  by setting |g:ale_close_preview_on_insert| to `1`.

  Either this setting or |g:ale_echo_cursor| must be set to `1` before ALE is
  loaded for messages to be displayed. See |ale-lint-settings-on-startup|.


g:ale_default_navigation                             *g:ale_default_navigation*
                                                     *b:ale_default_navigation*

  Type: |String|
  Default: `'buffer'`

  The default method for navigating away from the current buffer to another
  buffer, such as for |ALEFindReferences|, or |ALEGoToDefinition|.


g:ale_detail_to_floating_preview             *g:ale_detail_to_floating_preview*
                                             *b:ale_detail_to_floating_preview*
  Type: |Number|
  Default: `0`

  When this option is set to `1`, Neovim or Vim with |popupwin| will use a
  floating window for ALEDetail output.


g:ale_disable_lsp                                           *g:ale_disable_lsp*
                                                            *b:ale_disable_lsp*

  Type: |Number|
  Default: `0`

  When this option is set to `1`, ALE ignores all linters powered by LSP,
  and also `tsserver`.

  Please see also |ale-lsp|.


g:ale_echo_cursor                                           *g:ale_echo_cursor*

  Type: |Number|
  Default: `1`

  When this option is set to `1`, a truncated message will be echoed when a
  cursor is near a warning or error. ALE will attempt to find the warning or
  error at a column nearest to the cursor when the cursor is resting on a line
  which contains a warning or error. This option can be set to `0` to disable
  this behavior.

  Messages are only displayed after a short delay. See |g:ale_echo_delay|.

  The format of the message can be customized with |g:ale_echo_msg_format|.

  Either this setting or |g:ale_cursor_detail| must be set to `1` before ALE
  is loaded for messages to be displayed. See |ale-lint-settings-on-startup|.


g:ale_echo_delay                                             *g:ale_echo_delay*
                                                             *b:ale_echo_delay*
  Type: |Number|
  Default: `10`

  Given any integer, this option controls the number of milliseconds before
  ALE will echo or preview a message for a problem near the cursor.

  The value can be increased to decrease the amount of processing ALE will do
  for files displaying a large number of problems.


g:ale_echo_msg_error_str                             *g:ale_echo_msg_error_str*

  Type: |String|
  Default: `'Error'`

  The string used for `%severity%` for errors. See |g:ale_echo_msg_format|


g:ale_echo_msg_format                                   *g:ale_echo_msg_format*
                                                        *b:ale_echo_msg_format*

  Type: |String|
  Default: `'%code: %%s'`

  This variable defines a message format for echoed messages. The following
  sequences of characters will be replaced.

    `%s`           - replaced with the text for the problem
    `%...code...% `- replaced with the error code
    `%linter%`     - replaced with the name of the linter
    `%severity%`   - replaced with the severity of the problem

  The strings for `%severity%` can be configured with the following options.

    |g:ale_echo_msg_error_str|   - Defaults to `'Error'`
    |g:ale_echo_msg_info_str|    - Defaults to `'Info'`
    |g:ale_echo_msg_warning_str| - Defaults to `'Warning'`

  `%code%` is replaced with the error code, and replaced with an empty string
  when there is no error code. Any extra characters between the percent signs
  will be printed when an error code is present. For example, a message like
  `(error code): message` will be printed for `'%(code): %%s'` and simply the
  message will be printed when there is no code.

  |g:ale_echo_cursor| needs to be set to 1 for messages to be displayed.

  The echo message format can also be configured separately for each buffer,
  so different formats can be used for different languages. (Say in ftplugin
  files.)


g:ale_echo_msg_info_str                               *g:ale_echo_msg_info_str*

  Type: |String|
  Default: `'Info'`

  The string used for `%severity%` for info. See |g:ale_echo_msg_format|


g:ale_echo_msg_log_str                                 *g:ale_echo_msg_log_str*

  Type: |String|
  Default: `'Log'`

  The string used for `%severity%` for log, used only for handling LSP show
  message requests. See |g:ale_lsp_show_message_format|


g:ale_echo_msg_warning_str                         *g:ale_echo_msg_warning_str*

  Type: |String|
  Default: `'Warning'`

  The string used for `%severity%` for warnings. See |g:ale_echo_msg_format|


g:ale_enabled                                                   *g:ale_enabled*
                                                                *b:ale_enabled*

  Type: |Number|
  Default: `1`

  When set to `0`, this option will completely disable ALE, such that no
  error checking will be performed, etc. ALE can be toggled on and off with
  the |ALEToggle| command, which changes this option.

  ALE can be disabled in each buffer by setting `let b:ale_enabled = 0`
  Disabling ALE based on filename patterns can be accomplished by setting
  a regular expression for |g:ale_pattern_options|. For example: >

  " Disable linting for all minified JS files.
  let g:ale_pattern_options = {'\.min.js$': {'ale_enabled': 0}}
<

  See |g:ale_pattern_options| for more information on that option.


g:ale_exclude_highlights                             *g:ale_exclude_highlights*
                                                     *b:ale_exclude_highlights*

  Type: |List|
  Default: `[]`

  A list of regular expressions for matching against highlight messages to
  remove. For example: >

  " Do not highlight messages matching strings like these.
  let b:ale_exclude_highlights = ['line too long', 'foo.*bar']
<
  See also: |g:ale_set_highlights|


g:ale_fixers                                                     *g:ale_fixers*
                                                                 *b:ale_fixers*

  Type: |Dictionary|
  Default: `{}`

  A mapping from filetypes to |List| values for functions for fixing errors.
  See |ale-fix| for more information.

  This variable can be overridden with variables in each buffer.
  `b:ale_fixers` can be set to a |List| of callbacks instead, which can be
  more convenient.

  A special `'*'` key be used as a wildcard filetype for configuring fixers
  for every other type of file. For example: >

    " Fix Python files with 'bar'.
    " Don't fix 'html' files.
    " Fix everything else with 'foo'.
    let g:ale_fixers = {'python': ['bar'], 'html': [], '*': ['foo']}
<

g:ale_fix_on_save                                           *g:ale_fix_on_save*
                                                            *b:ale_fix_on_save*

  Type: |Number|
  Default: `0`

  When set to 1, ALE will fix files when they are saved.

  If |g:ale_lint_on_save| is set to 1, files will be checked with linters
  after files are fixed, only when the buffer is open, or re-opened. Changes
  to the file will be saved to the file on disk.

  Files will not be fixed on `:wq`, so you should check your code before
  closing a buffer.

  Fixing files can be disabled or enabled for individual buffers by setting
  `b:ale_fix_on_save` to `0` or `1`.

  Some fixers can be excluded from being run automatically when you save files
  with the |g:ale_fix_on_save_ignore| setting.


g:ale_fix_on_save_ignore                             *g:ale_fix_on_save_ignore*
                                                     *b:ale_fix_on_save_ignore*

  Type: |Dictionary| or |List|
  Default: `{}`

  Given a |Dictionary| mapping filetypes to |Lists| of fixers to ignore, or
  just a |List| of fixers to ignore, exclude those fixers from being run
  automatically when files are saved.

  You can disable some fixers in your ftplugin file: >

  " Disable fixers 'b' and 'c' when fixing on safe for this buffer.
  let b:ale_fix_on_save_ignore = ['b', 'c']
  " Alternatively, define ignore lists for different filetypes.
  let b:ale_fix_on_save_ignore = {'foo': ['b'], 'bar': ['c']}
<
  You can disable some fixers globally per filetype like so: >

  let g:ale_fixers = {'foo': ['a', 'b'], 'bar': ['c', 'd']}
  let g:ale_fix_on_save = 1
  " For filetype `foo.bar`, only fixers 'b' and 'd' will be run on save.
  let g:ale_fix_on_save_ignore = {'foo': ['a'], 'bar': ['c']}
  " Alternatively, disable these fixers on save for all filetypes.
  let g:ale_fix_on_save_ignore = ['a', 'c']
<
  You can ignore fixers based on matching |Funcref| values too: >

  let g:AddBar = {buffer, lines -> lines + ['bar']}
  let g:ale_fixers = {'foo': g:AddBar}
  " The lambda fixer will be ignored, as it will be found in the ignore list.
  let g:ale_fix_on_save_ignore = [g:AddBar]
<

g:ale_floating_preview                                 *g:ale_floating_preview*

  Type: |Number|
  Default: `0`

  When set to `1`, Neovim or Vim with |popupwin| will use a floating window
  for ale's preview window.
  This is equivalent to setting |g:ale_hover_to_floating_preview| and
  |g:ale_detail_to_floating_preview| to `1`.


g:ale_floating_window_border                       *g:ale_floating_window_border*

  Type: |List|
  Default: `['|', '-', '+', '+', '+', '+']`

  When set to `[]`, window borders are disabled. The elements in the list set
  the horizontal, top, top-left, top-right, bottom-right and bottom-left
  border characters, respectively.

  If the terminal supports Unicode, you might try setting the value to
  ` ['│', '─', '╭', '╮', '╯', '╰']`, to make it look nicer.


g:ale_history_enabled                                   *g:ale_history_enabled*

  Type: |Number|
  Default: `1`

  When set to `1`, ALE will remember the last few commands which were run
  for every buffer which is open. This information can be viewed with the
  |ALEInfo| command. The size of the buffer can be controlled with the
  |g:ale_max_buffer_history_size| option.

  This option can be disabled if storing a command history is not desired.


g:ale_history_log_output                             *g:ale_history_log_output*

  Type: |Number|
  Default: `1`

  When set to `1`, ALE will store the output of commands which have completed
  successfully in the command history, and the output will be displayed when
  using |ALEInfo|.

  |g:ale_history_enabled| must be set to `1` for this output to be stored or
  printed.

  Some memory will be consumed by this option. It is very useful for figuring
  out what went wrong with linters, and for bug reports. Turn this option off
  if you want to save on some memory usage.


g:ale_hover_cursor                                         *g:ale_hover_cursor*

  Type: |Number|
  Default: `1`

  If set to `1`, ALE will show truncated information in the echo line about
  the symbol at the cursor automatically when the |CursorHold| event is fired.
  The delay before requesting hover information is based on 'updatetime', as
  with all |CursorHold| events.

  If there's a problem on the line where the cursor is resting, ALE will not
  show any hover information.

  See |ale-hover| for more information on hover information.

  This setting must be set to `1` before ALE is loaded for this behavior
  to be enabled. See |ale-lint-settings-on-startup|.


g:ale_hover_to_preview                                 *g:ale_hover_to_preview*
                                                       *b:ale_hover_to_preview*
  Type: |Number|
  Default: `0`

  If set to `1`, hover messages will be displayed in the preview window,
  instead of in balloons or the message line.


g:ale_hover_to_floating_preview               *g:ale_hover_to_floating_preview*
                                              *b:ale_hover_to_floating_preview*
  Type: |Number|
  Default: `0`

  If set to `1`, Neovim or Vim with |popupwin| will use floating windows for
  hover messages.


g:ale_keep_list_window_open                       *g:ale_keep_list_window_open*
                                                  *b:ale_keep_list_window_open*
  Type: |Number|
  Default: `0`

  When set to `1`, this option will keep the loclist or quickfix windows event
  after all warnings/errors have been removed for files. By default the
  loclist or quickfix windows will be closed automatically when there are no
  warnings or errors.

  See |g:ale_open_list|


g:ale_list_window_size                                 *g:ale_list_window_size*
                                                       *b:ale_list_window_size*
  Type: |Number|
  Default: `10`

  This number configures the number of lines to set for the height of windows
  opened automatically for ALE problems. The default of `10` matches the Vim
  default height.

  See |g:ale_open_list| for information on automatically opening windows
  for quickfix or the loclist.


g:ale_lint_delay                                             *g:ale_lint_delay*
                                                             *b:ale_lint_delay*
  Type: |Number|
  Default: `200`

  This variable controls the milliseconds delay after which the linters will
  be run after text is changed. This option is only meaningful with the
  |g:ale_lint_on_text_changed| variable set to `always`, `insert`, or `normal`.

  A buffer-local option, `b:ale_lint_delay`, can be set to change the delay
  for different buffers, such as in |ftplugin| files.


g:ale_lint_on_enter                                       *g:ale_lint_on_enter*

  Type: |Number|
  Default: `1`

  When this option is set to `1`, the |BufWinEnter| event will be used to
  apply linters when buffers are first opened. If this is not desired, this
  variable can be set to `0` in your vimrc file to disable this behavior.

  The |FileChangedShellPost| and |BufEnter| events will be used to check if
  files have been changed outside of Vim. If a file is changed outside of
  Vim, it will be checked when it is next opened.

  You should set this setting once before ALE is loaded, and restart Vim if
  you want to change your preferences. See |ale-lint-settings-on-startup|.


g:ale_lint_on_filetype_changed                 *g:ale_lint_on_filetype_changed*

  Type: |Number|
  Default: `1`

  This option will cause ALE to run when the filetype for a file is changed
  after a buffer has first been loaded. A short delay will be used before
  linting will be done, so the filetype can be changed quickly several times
  in a row, but resulting in only one lint cycle.

  You should set this setting once before ALE is loaded, and restart Vim if
  you want to change your preferences. See |ale-lint-settings-on-startup|.


g:ale_lint_on_save                                         *g:ale_lint_on_save*

  Type: |Number|
  Default: `1`

  This option will make ALE run the linters whenever a file is saved when it
  it set to `1` in your vimrc file. This option can be used in combination
  with the |g:ale_lint_on_enter| and |g:ale_lint_on_text_changed| options to
  make ALE only check files after that have been saved, if that is what is
  desired.


g:ale_lint_on_text_changed                         *g:ale_lint_on_text_changed*

  Type: |String|
  Default: `'normal'`

  This option controls how ALE will check your files as you make changes.
  The following values can be used.

  `'always'`, `'1'`, or `1` - Check buffers on |TextChanged| or |TextChangedI|.
  `'normal'`            - Check buffers only on |TextChanged|.
  `'insert'`            - Check buffers only on |TextChangedI|.
  `'never'`, `'0'`, or `0`  - Never check buffers on changes.

  ALE will check buffers after a short delay, with a timer which resets on
  each change. The delay can be configured by adjusting the |g:ale_lint_delay|
  variable.
                                               *ale-linting-interrupts-mapping*

  Due to a bug in Vim, ALE can interrupt mappings with pending key presses,
  per |timeoutlen|. If this happens, follow the advice for enabling
  |g:ale_lint_on_insert_leave| below, and set this option to `'normal'`, or
  disable it entirely.

  You should set this setting once before ALE is loaded, and restart Vim if
  you want to change your preferences. See |ale-lint-settings-on-startup|.


g:ale_lint_on_insert_leave                         *g:ale_lint_on_insert_leave*
                                                   *b:ale_lint_on_insert_leave*

  Type: |Number|
  Default: `1`

  When set to `1` in your vimrc file, this option will cause ALE to run
  linters when you leave insert mode.

  ALE will not lint files when you escape insert mode with |CTRL-C| by
  default. You can make ALE lint files with this option when you use |CTRL-C|
  with the following mapping. >

    " Make using Ctrl+C do the same as Escape, to trigger autocmd commands
    inoremap <C-c> <Esc>
<
  A buffer-local version of this setting `b:ale_lint_on_insert_leave` can be
  set to `0` to disable linting when leaving insert mode. The setting must
  be enabled globally to be enabled locally.

  You should set this setting once before ALE is loaded, and restart Vim if
  you want to change your preferences. See |ale-lint-settings-on-startup|.


g:ale_linter_aliases                                     *g:ale_linter_aliases*
                                                         *b:ale_linter_aliases*
  Type: |Dictionary|
  Default: `{}`

  The |g:ale_linter_aliases| option can be used to set aliases from one
  filetype to another. A given filetype can be mapped to use the linters
  run for another given filetype.

  This |Dictionary| will be merged with a default dictionary containing the
  following values: >

  {
  \   'Dockerfile': 'dockerfile',
  \   'csh': 'sh',
  \   'javascriptreact': ['javascript', 'jsx'],
  \   'plaintex': 'tex',
  \   'ps1': 'powershell',
  \   'rmarkdown': 'r',
  \   'rmd': 'r',
  \   'systemverilog': 'verilog',
  \   'typescriptreact': ['typescript', 'tsx'],
  \   'vader': ['vim', 'vader'],
  \   'verilog_systemverilog': ['verilog_systemverilog', 'verilog'],
  \   'vimwiki': 'markdown',
  \   'vue': ['vue', 'javascript'],
  \   'xsd': ['xsd', 'xml'],
  \   'xslt': ['xslt', 'xml'],
  \   'zsh': 'sh',
  \}
<
  For example, if you wish to map a new filetype `'foobar'` to run the `'php'`
  linters, you could set the following: >

  let g:ale_linter_aliases = {'foobar': 'php'}
<
  When combined with the |g:ale_linters| option, the original filetype
  (`'foobar'`) will be used for determining which linters to run,
  not the aliased type (`'php'`). This allows an aliased type to run a
  different set of linters from the type it is being mapped to.

  Passing a list of filetypes is also supported. Say you want to lint
  javascript and css embedded in HTML (using linters that support that).
  You could alias `html` like so:

  `let g:ale_linter_aliases = {'html': ['html', 'javascript', 'css']}`

  Note that `html` itself was included as an alias. That is because aliases
  will override the original linters for the aliased filetype.

  Linter aliases can be configured in each buffer with buffer-local variables.
  ALE will first look for aliases for filetypes in the `b:ale_linter_aliases`
  variable, then `g:ale_linter_aliases`, and then a default Dictionary.

  `b:ale_linter_aliases` can be set to a |List| or a |String|, to tell ALE to
  load the linters for specific filetypes for a given buffer. >

  let b:ale_linter_aliases = ['html', 'javascript', 'css']
  " OR, Alias a filetype to only a single filetype with a String.
  let b:ale_linter_aliases = 'javascript'
<
  No linters will be loaded when the buffer's filetype is empty.


g:ale_filename_mappings                               *g:ale_filename_mappings*
                                                      *b:ale_filename_mappings*

  Type: |Dictionary| or |List|
  Default: `{}`

  Either a |Dictionary| mapping a linter or fixer name, as displayed in
  |:ALEInfo|, to a |List| of two-item |List|s for filename mappings, or just a
  |List| of two-item |List|s. When given some paths to files, the value of
  this setting will be used to convert filenames on a local file system to
  filenames on some remote file system, such as paths in a Docker image,
  virtual machine, or network drive.

  For example: >

  let g:ale_filename_mappings = {
  \   'pylint': [
  \       ['/home/john/proj', '/data'],
  \   ],
  \}
<
  With the above configuration, a filename such as `/home/john/proj/foo.py`
  will be provided to the linter/fixer as `/data/foo.py`, and paths parsed
  from linter results such as `/data/foo.py` will be converted back to
  `/home/john/proj/foo.py`.

  You can use `*` as to apply a |List| of filename mappings to all other
  linters or fixers not otherwise matched. >

  " Use one List of paths for pylint.
  " Use another List of paths for everything else.
  let g:ale_filename_mappings = {
  \   'pylint': [
  \       ['/home/john/proj', '/data'],
  \   ],
  \   '*': [
  \       ['/home/john/proj', '/other-data'],
  \   ],
  \}
<
  If you just want every single linter or fixer to use the same filename
  mapping, you can just use a |List|. >

  " Same as above, but for ALL linters and fixers.
  let g:ale_filename_mappings = [
  \   ['/home/john/proj', '/data'],
  \]
<
  You can provide many such filename paths for multiple projects. Paths are
  matched by checking if the start of a file path matches the given strings,
  in a case-sensitive manner. Earlier entries in the |List| will be tried
  before later entries when mapping to a given file system.

  Buffer-local options can be set to the same values to override the global
  options, such as in |ftplugin| files.

  NOTE: Only fixers registered with a short name can support filename mapping
  by their fixer names. See |ale-fix|. Filename mappings set for all tools by
  using only a |List| for the setting will also be applied to fixers not in
  the registry.

  NOTE: In order for this filename mapping to work correctly, linters and
  fixers must exclusively determine paths to files to lint or fix via ALE
  command formatting as per |ale-command-format-strings|, and paths parsed
  from linter files must be provided in `filename` keys if a linter returns
  results for more than one file at a time, as per |ale-loclist-format|. If
  you discover a linter or fixer which does not behave properly, please report
  it as an issue.

  If you are running a linter or fixer through Docker or another remote file
  system, you may have to mount your temporary directory, which you can
  discover with the following command: >

  :echo fnamemodify(tempname(), ':h:h')
<
  You should provide a mapping from this temporary directory to whatever you
  mount this directory to in Docker, or whatever remote file system you are
  working with.

  You can inspect the filename mappings ALE will use with the
  |ale#GetFilenameMappings()| function.


g:ale_linters                                                   *g:ale_linters*
                                                                *b:ale_linters*
  Type: |Dictionary|
  Default: `{}`

  The |g:ale_linters| option sets a |Dictionary| mapping a filetype to a
  |List| of linter programs to be run when checking particular filetypes.

  This |Dictionary| will be merged with a default dictionary containing the
  following values: >

  {
  \   'apkbuild': ['apkbuild_lint', 'secfixes_check'],
  \   'csh': ['shell'],
  \   'elixir': ['credo', 'dialyxir', 'dogma'],
  \   'go': ['gofmt', 'golint', 'gopls', 'govet'],
  \   'hack': ['hack'],
  \   'help': [],
  \   'inko': ['inko'],
  \   'json': ['jsonlint', 'spectral'],
  \   'json': ['jsonlint', 'spectral', 'vscodejson'],
  \   'json5': [],
  \   'jsonc': [],
  \   'perl': ['perlcritic'],
  \   'perl6': [],
  \   'python': ['flake8', 'mypy', 'pylint', 'pyright'],
  \   'rust': ['cargo', 'rls'],
  \   'spec': [],
  \   'text': [],
  \   'vader': ['vimls'],
  \   'vue': ['eslint', 'vls'],
  \   'zsh': ['shell'],
  \   'v': ['v'],
  \   'yaml': ['spectral', 'yaml-language-server', 'yamllint'],
  \}
<
  This option can be used to enable only a particular set of linters for a
  file. For example, you can enable only `eslint` for JavaScript files: >

  let g:ale_linters = {'javascript': ['eslint']}
<
  If you want to disable all linters for a particular filetype, you can pass
  an empty list of linters as the value: >

  let g:ale_linters = {'javascript': []}
<
  All linters will be run for unspecified filetypes. All available linters can
  be enabled explicitly for a given filetype by passing the string `'all'`,
  instead of a List. >

  let g:ale_linters = {'c': 'all'}
<
  Linters can be configured in each buffer with buffer-local variables. ALE
  will first look for linters for filetypes in the `b:ale_linters` variable,
  then `g:ale_linters`, and then the default Dictionary mentioned above.

  `b:ale_linters` can be set to a List, or the string `'all'`. When linters
  for two different filetypes share the same name, the first linter loaded
  will be used. Any ambiguity can be resolved by using a Dictionary specifying
  which linter to run for which filetype instead. >

  " Use ESLint for the buffer if the filetype includes 'javascript'.
  let b:ale_linters = {'javascript': ['eslint'], 'html': ['tidy']}
  " Use a List for the same setting. This will work in most cases.
  let b:ale_linters = ['eslint', 'tidy']
  " Disable all linters for the buffer.
  let b:ale_linters = []
  " Explicitly enable all available linters for the filetype.
  let b:ale_linters = 'all'
<
  ALE can be configured to disable all linters unless otherwise specified with
  `g:ale_enabled` or `b:ale_enabled` with the option |g:ale_linters_explicit|.


g:ale_linters_explicit                                 *g:ale_linters_explicit*

  Type: |Number|
  Default: `0`

  When set to `1`, only the linters from |g:ale_linters| and |b:ale_linters|
  will be enabled. The default behavior for ALE is to enable as many linters
  as possible, unless otherwise specified.


g:ale_linters_ignore                                     *g:ale_linters_ignore*
                                                         *b:ale_linters_ignore*

  Type: |Dictionary| or |List|
  Default: `{}`

  Linters to ignore. Commands for ignored linters will not be run, and
  diagnostics for LSP linters will be ignored. (See |ale-lsp|)

  This setting can be set to a |Dictionary| mapping filetypes to linter names,
  just like |g:ale_linters|, to list linters to ignore. Ignore lists will be
  applied after everything else. >

  " Select flake8 and pylint, and ignore pylint, so only flake8 is run.
  let g:ale_linters = {'python': ['flake8', 'pylint']}
  let g:ale_linters_ignore = {'python': ['pylint']}
<
  This setting can be set to simply a |List| of linter names, which is
  especially more convenient when using the setting in ftplugin files for
  particular buffers. >

  " The same as above, in a ftplugin/python.vim.
  let b:ale_linters = ['flake8', 'pylint']
  let b:ale_linters_ignore = ['pylint']
<

g:ale_list_vertical                                       *g:ale_list_vertical*
                                                          *b:ale_list_vertical*
  Type: |Number|
  Default: `0`

  When set to `1`, this will cause ALE to open any windows (loclist or
  quickfix) vertically instead of horizontally (|vert| |lopen|) or (|vert|
  |copen|)


g:ale_loclist_msg_format                             *g:ale_loclist_msg_format*
                                                     *b:ale_loclist_msg_format*

  Type: |String|
  Default: `g:ale_echo_msg_format`

  This option is the same as |g:ale_echo_msg_format|, but for formatting the
  message used for the loclist and the quickfix list.

  The strings for configuring `%severity%` are also used for this option.


g:ale_lsp_show_message_format                   *g:ale_lsp_show_message_format*

  Type: |String|
  Default: `'%severity%:%linter%: %s'`

  This variable defines the format that messages received from an LSP will
  have when echoed. The following sequences of characters will be replaced.

    `%s`           - replaced with the message text
    `%linter%`     - replaced with the name of the linter
    `%severity%`   - replaced with the severity of the message

  The strings for `%severity%` levels "error", "info" and "warning" are shared
  with |g:ale_echo_msg_format|. Severity "log" is unique to
  |g:ale_lsp_show_message_format| and it can be configured via

    |g:ale_echo_msg_log_str|     - Defaults to `'Log'`

  Please note that |g:ale_lsp_show_message_format| *can not* be configured
  separately for each buffer like |g:ale_echo_msg_format| can.


g:ale_lsp_show_message_severity               *g:ale_lsp_show_message_severity*

  Type: |String|
  Default: `'error'`

  This variable defines the minimum severity level an LSP message needs to be
  displayed. Messages below this level are discarded; please note that
  messages with `Log` severity level are always discarded.

  Possible values follow the LSP spec `MessageType` definition:

  `'error'`       - Displays only errors.
  `'warning'`     - Displays errors and warnings.
  `'information'` - Displays errors, warnings and infos
  `'log'`         - Same as `'information'`
  `'disabled'`    - Doesn't display any information at all.


g:ale_lsp_suggestions                                   *g:ale_lsp_suggestions*

  Type: |Number|
  Default: `0`

  If set to `1`, show hints/suggestions from LSP servers or tsserver, in
  addition to warnings and errors.


g:ale_max_buffer_history_size                   *g:ale_max_buffer_history_size*

  Type: |Number|
  Default: `20`

  This setting controls the maximum number of commands which will be stored in
  the command history used for |ALEInfo|. Command history will be rotated in
  a FIFO manner. If set to a number <= 0, then the history will be
  continuously set to an empty |List|.

  History can be disabled completely with |g:ale_history_enabled|.


g:ale_max_signs                                               *g:ale_max_signs*
                                                              *b:ale_max_signs*
  Type: |Number|
  Default: `-1`

  When set to any positive integer, ALE will not render any more than the
  given number of signs for any one buffer.

  When set to `0`, no signs will be set, but sign processing will still be
  done, so existing signs can be removed.

  When set to any other value, no limit will be imposed on the number of signs
  set.

  For disabling sign processing, see |g:ale_set_signs|.


g:ale_maximum_file_size                               *g:ale_maximum_file_size*
                                                      *b:ale_maximum_file_size*
  Type: |Number|
  Default: undefined

  A maximum file size in bytes for ALE to check. If set to any positive
  number, ALE will skip checking files larger than the given size.


g:ale_open_list                                               *g:ale_open_list*
                                                              *b:ale_open_list*
  Type: |Number| or |String|
  Default: `0`

  When set to `1`, this will cause ALE to automatically open a window for the
  loclist (|lopen|) or for the quickfix list instead if |g:ale_set_quickfix|
  is `1`. (|copen|)

  When set to any higher numberical value, ALE will only open the window when
  the number of warnings or errors are at least that many.

  When set to `'on_save'`, ALE will only open the loclist after buffers have
  been saved. The list will be opened some time after buffers are saved and
  any linter for a buffer returns results.

  The window will be kept open until all warnings or errors are cleared,
  including those not set by ALE, unless |g:ale_keep_list_window_open| is set
  to `1`, in which case the window will be kept open when no problems are
  found.

  The window size can be configured with |g:ale_list_window_size|.

  Windows can be opened vertically with |g:ale_list_vertical|.

  If you want to close the loclist window automatically when the buffer is
  closed, you can set up the following |autocmd| command: >

  augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
  augroup END

<
g:ale_pattern_options                                   *g:ale_pattern_options*

  Type: |Dictionary|
  Default: undefined

  This option maps regular expression patterns to |Dictionary| values for
  buffer variables. This option can be set to automatically configure
  different settings for different files. For example: >

  " Use just ESLint for linting and fixing files which end in '.foo.js'
  let g:ale_pattern_options = {
  \   '\.foo\.js$': {
  \       'ale_linters': ['eslint'],
  \       'ale_fixers': ['eslint'],
  \   },
  \}
<
  See |b:ale_linters| and |b:ale_fixers| for information for those options.

  Filenames are matched with |match()|, and patterns depend on the |magic|
  setting, unless prefixed with the special escape sequences like `'\v'`, etc.
  The patterns can match any part of a filename. The absolute path of the
  filename will be used for matching, taken from `expand('%:p')`.

  The options for every match for the filename will be applied, with the
  pattern keys sorted in alphabetical order. Options for `'zebra'` will
  override the options for `'alpha'` for a filename `alpha-zebra`.


g:ale_pattern_options_enabled                   *g:ale_pattern_options_enabled*

  Type: |Number|
  Default: undefined

  This option can be used for disabling pattern options. If set to `0`, ALE
  will not set buffer variables per |g:ale_pattern_options|.


g:ale_popup_menu_enabled                             *g:ale_popup_menu_enabled*

  Type: |Number|
  Default: `has('gui_running')`

  When this option is set to `1`, ALE will show code actions and rename
  capabilities in the right click mouse menu when there's a LSP server or
  tsserver available. See |ale-refactor|.

  This feature is only supported in GUI versions of Vim.

  This setting must be set to `1` before ALE is loaded for this behavior
  to be enabled. See |ale-lint-settings-on-startup|.


g:ale_rename_tsserver_find_in_comments *g:ale_rename_tsserver_find_in_comments*

  Type: |Number|
  Default: `0`

  If enabled, this option will tell tsserver to find and replace text in
  comments when calling |ALERename|. It can be enabled by settings the value
  to `1`.


g:ale_rename_tsserver_find_in_strings   *g:ale_rename_tsserver_find_in_strings*


  Type: |Number|
  Default: `0`

  If enabled, this option will tell tsserver to find and replace text in
  strings when calling |ALERename|. It can be enabled by settings the value to
  `1`.


g:ale_root                                                         *g:ale_root*
                                                                   *b:ale_root*

  Type: |Dictionary| or |String|
  Default: {}

  This option is used to determine the project root for a linter. If the value
  is a |Dictionary|, it maps a linter to either a |String| containing the
  project root or a |Funcref| to call to look up the root. The |Funcref| is
  provided the buffer number as its argument.

  The buffer-specific variable may additionally be a string containing the
  project root itself.

  If neither variable yields a result, a linter-specific function is invoked to
  detect a project root. If this, too, yields no result, and the linter is an
  LSP linter, it will not run.


g:ale_set_balloons                                         *g:ale_set_balloons*
                                                           *b:ale_set_balloons*

  Type: |Number| or |String|
  Default: `has('balloon_eval') && has('gui_running')`

  When this option is set to `1`, balloon messages will be displayed for
  problems or hover information if available.

  Problems nearest to the line the mouse cursor is over will be displayed. If
  there are no problems to show, and one of the linters is an LSP linter
  supporting "Hover" information, per |ale-hover|, then brief information
  about the symbol under the cursor will be displayed in a balloon.

  This option can be set to `'hover'` to only enable balloons for hover
  message, so diagnostics are never shown in balloons. You may wish to
  configure use this setting only in GUI Vim like so: >

  let g:ale_set_balloons = has('gui_running') ? 'hover' : 0
<

  Balloons can be enabled for terminal versions of Vim that support balloons,
  but some versions of Vim will produce strange mouse behavior when balloons
  are enabled. To configure balloons for your terminal, you should first
  configure your |ttymouse| setting, and then consider setting
  `g:ale_set_balloons` to `1` before ALE is loaded.

  `b:ale_set_balloons` can be set to `0` to disable balloons for a buffer.
  Balloons cannot be enabled for a specific buffer when not initially enabled
  globally.

  Balloons will not be shown when |g:ale_enabled| or |b:ale_enabled| is `0`.


g:ale_set_balloons_legacy_echo                 *g:ale_set_balloons_legacy_echo*
                                               *b:ale_set_balloons_legacy_echo*
  Type: |Number|
  Default: undefined

  If set to `1`, moving your mouse over documents in Vim will make ALE ask
  `tsserver` or `LSP` servers for information about the symbol where the mouse
  cursor is, and print that information into Vim's echo line. This is an
  option for supporting older versions of Vim which do not properly support
  balloons in an asynchronous manner.

  If your version of Vim supports the |balloon_show| function, then this
  option does nothing meaningful.


g:ale_set_highlights                                     *g:ale_set_highlights*

  Type: |Number|
  Default: `has('syntax')`

  When this option is set to `1`, highlights will be set for problems.

  ALE will use the following highlight groups for problems:

  |ALEError|        - Items with `'type': 'E'`
  |ALEWarning|      - Items with `'type': 'W'`
  |ALEInfo.|        - Items with `'type': 'I'`
  |ALEStyleError|   - Items with `'type': 'E'` and `'sub_type': 'style'`
  |ALEStyleWarning| - Items with `'type': 'W'` and `'sub_type': 'style'`

  When |g:ale_set_signs| is set to `0`, the following highlights for entire
  lines will be set.

  |ALEErrorLine|   - All items with `'type': 'E'`
  |ALEWarningLine| - All items with `'type': 'W'`
  |ALEInfoLine|    - All items with `'type': 'I'`

  Vim can only highlight the characters up to the last column in a buffer for
  match highlights, whereas the line highlights when signs are enabled will
  run to the edge of the screen.

  Highlights can be excluded with the |g:ale_exclude_highlights| option.


g:ale_set_loclist                                           *g:ale_set_loclist*

  Type: |Number|
  Default: `1`

  When this option is set to `1`, the |loclist| will be populated with any
  warnings and errors which are found by ALE. This feature can be used to
  implement jumping between errors through typical use of |lnext| and |lprev|.


g:ale_set_quickfix                                         *g:ale_set_quickfix*

  Type: |Number|
  Default: `0`

  When this option is set to `1`, the |quickfix| list will be populated with
  any problems which are found by ALE, instead of the |loclist|. The loclist
  will never be populated when this option is on.

  Problems from every buffer ALE has checked will be included in the quickfix
  list, which can be checked with |:copen|. Problems will be de-duplicated.

  This feature should not be used in combination with tools for searching for
  matches and commands like |:cfdo|, as ALE will replace the quickfix list
  pretty frequently. If you wish to use such tools, you should populate the
  loclist or use |ALEPopulateQuickfix| instead.


g:ale_set_signs                                               *g:ale_set_signs*

  Type: |Number|
  Default: `has('signs')`

  When this option is set to `1`, the |sign| column will be populated with
  signs marking where problems appear in the file.

  ALE will use the following highlight groups for problems:

  |ALEErrorSign|        - Items with `'type': 'E'`
  |ALEWarningSign|      - Items with `'type': 'W'`
  |ALEInfoSign|         - Items with `'type': 'I'`
  |ALEStyleErrorSign|   - Items with `'type': 'E'` and `'sub_type': 'style'`
  |ALEStyleWarningSign| - Items with `'type': 'W'` and `'sub_type': 'style'`

  In addition to the style of the signs, the style of lines where signs appear
  can be configured with the following highlights:

  |ALEErrorLine|   - All items with `'type': 'E'`
  |ALEWarningLine| - All items with `'type': 'W'`
  |ALEInfoLine|    - All items with `'type': 'I'`

  With Neovim 0.3.2 or higher, ALE can use the `numhl` option to highlight the
  'number' column. It uses the following highlight groups.

  |ALEErrorSignLineNr|        - Items with `'type': 'E'`
  |ALEWarningSignLineNr|      - Items with `'type': 'W'`
  |ALEInfoSignLineNr|         - Items with `'type': 'I'`
  |ALEStyleErrorSignLineNr|   - Items with `'type': 'E'` and `'sub_type': 'style'`
  |ALEStyleWarningSignLineNr| - Items with `'type': 'W'` and `'sub_type': 'style'`

  To enable line number highlighting |g:ale_sign_highlight_linenrs| must be
  set to `1` before ALE is loaded.

  The markers for the highlights can be customized with the following options:

  |g:ale_sign_error|
  |g:ale_sign_warning|
  |g:ale_sign_info|
  |g:ale_sign_style_error|
  |g:ale_sign_style_warning|

  When multiple problems exist on the same line, the signs will take
  precedence in the order above, from highest to lowest.

  To limit the number of signs ALE will set, see |g:ale_max_signs|.


g:ale_sign_priority                                       *g:ale_sign_priority*

  Type: |Number|
  Default: `30`

  From Neovim 0.4.0 and Vim 8.1, ALE can set sign priority to all signs. The
  larger this value is, the higher priority ALE signs have over other plugin
  signs. See |sign-priority| for further details on how priority works.


g:ale_shell                                                       *g:ale_shell*
                                                                  *b:ale_shell*

  Type: |String|
  Default: not set

  Override the shell used by ALE for executing commands. ALE uses 'shell' by
  default, but falls back in `/bin/sh` if the default shell looks like `fish`
  or `pwsh`, which are not compatible with all of the commands run by ALE. The
  shell specified with this option will be used even if it might not work in
  all cases.

  For Windows, ALE uses `cmd` when this option isn't set. Setting this option
  will apply shell escaping to the command string, even on Windows.

  NOTE: Consider setting |g:ale_shell_arguments| if this option is defined.


g:ale_shell_arguments                                   *g:ale_shell_arguments*
                                                        *b:ale_shell_arguments*

  Type: |String|
  Default: not set

  This option specifies the arguments to use for executing a command with a
  custom shell, per |g:ale_shell|. If this option is not set, 'shellcmdflag'
  will be used instead.


g:ale_sign_column_always                             *g:ale_sign_column_always*

  Type: |Number|
  Default: `0`

  By default, the sign gutter will disappear when all warnings and errors have
  been fixed for a file. When this option is set to `1`, the sign column will
  remain open. This can be preferable if you don't want the text in your file
  to move around as you edit a file.


g:ale_sign_error                                             *g:ale_sign_error*

  Type: |String|
  Default: `'>>'`

  The sign for errors in the sign gutter.


g:ale_sign_info                                               *g:ale_sign_info*

  Type: |String|
  Default: `g:ale_sign_warning`

  The sign for "info" markers in the sign gutter.


g:ale_sign_style_error                                 *g:ale_sign_style_error*

  Type: |String|
  Default: `g:ale_sign_error`

  The sign for style errors in the sign gutter.


g:ale_sign_style_warning                             *g:ale_sign_style_warning*

  Type: |String|
  Default: `g:ale_sign_warning`

  The sign for style warnings in the sign gutter.


g:ale_sign_offset                                           *g:ale_sign_offset*

  Type: |Number|
  Default: `1000000`

  This variable controls offset from which numeric IDs will be generated for
  new signs. Signs cannot share the same ID values, so when two Vim plugins
  set signs at the same time, the IDs have to be configured such that they do
  not conflict with one another. If the IDs used by ALE are found to conflict
  with some other plugin, this offset value can be changed, and hopefully both
  plugins will work together. See |sign-place| for more information on how
  signs are set.


g:ale_sign_warning                                         *g:ale_sign_warning*

  Type: |String|
  Default: `'--'`

  The sign for warnings in the sign gutter.


g:ale_sign_highlight_linenrs                     *g:ale_sign_highlight_linenrs*

  Type: |Number|
  Default: `0`

  When set to `1`, this option enables highlighting problems on the 'number'
  column in Vim versions that support `numhl` highlights. This option must be
  configured before ALE is loaded.


g:ale_update_tagstack                                   *g:ale_update_tagstack*
                                                        *b:ale_update_tagstack*
 Type: |Number|
 Default: `1`

 This option can be set to disable updating Vim's |tagstack| automatically.


g:ale_type_map                                                 *g:ale_type_map*
                                                               *b:ale_type_map*
  Type: |Dictionary|
  Default: `{}`

  This option can be set re-map problem types for linters. Each key in the
  |Dictionary| should be the name of a linter, and each value must be a
  |Dictionary| mapping problem types from one type to another. The following
  types are supported:

  `'E'`  - `{'type': 'E'}`
  `'ES'` - `{'type': 'E', 'sub_type': 'style'}`
  `'W'`  - `{'type': 'W'}`
  `'WS'` - `{'type': 'W', 'sub_type': 'style'}`
  `'I'`  - `{'type': 'I'}`

  For example, if you want to turn flake8 errors into warnings, you can write
  the following: >

  let g:ale_type_map = {'flake8': {'ES': 'WS', 'E': 'W'}}
<
  If you wanted to turn style errors and warnings into regular errors and
  warnings, you can write the following: >

  let g:ale_type_map = {'flake8': {'ES': 'E', 'WS': 'W'}}
<
  Type maps can be set per-buffer with `b:ale_type_map`.


g:ale_use_global_executables                     *g:ale_use_global_executables*

  Type: |Number|
  Default: not set

  This option can be set to change the default for all `_use_global` options.
  This option must be set before ALE is loaded, preferably in a vimrc file.

  See |ale-integrations-local-executables| for more information on those
  options.


g:ale_virtualtext_cursor                             *g:ale_virtualtext_cursor*

  Type: |Number|
  Default: `0`

  When this option is set to `1`, a message will be shown when a cursor is
  near a warning or error. ALE will attempt to find the warning or error at a
  column nearest to the cursor when the cursor is resting on a line which
  contains a warning or error. This option can be set to `0` to disable this
  behavior.

  Messages are only displayed after a short delay. See |g:ale_virtualtext_delay|.

  Messages can be prefixed prefixed with a string. See |g:ale_virtualtext_prefix|.

  ALE will use the following highlight groups for problems:

  |ALEVirtualTextError|        - Items with `'type': 'E'`
  |ALEVirtualTextWarning|      - Items with `'type': 'W'`
  |ALEVirtualTextInfo|         - Items with `'type': 'I'`
  |ALEVirtualTextStyleError|   - Items with `'type': 'E'` and `'sub_type': 'style'`
  |ALEVirtualTextStyleWarning| - Items with `'type': 'W'` and `'sub_type': 'style'`


g:ale_virtualtext_delay                               *g:ale_virtualtext_delay*
                                                      *b:ale_virtualtext_delay*

  Type: |Number|
  Default: `10`

  Given any integer, this option controls the number of milliseconds before
  ALE will show a message for a problem near the cursor.

  The value can be increased to decrease the amount of processing ALE will do
  for files displaying a large number of problems.


g:ale_virtualtext_prefix                             *g:ale_virtualtext_prefix*

  Type: |String|
  Default: `'> '`

  Prefix to be used with |g:ale_virtualtext_cursor|.

g:ale_virtualenv_dir_names                         *g:ale_virtualenv_dir_names*
                                                   *b:ale_virtualenv_dir_names*

  Type: |List|
  Default: `['.env', '.venv', 'env', 've-py3', 've', 'virtualenv', 'venv']`

  A list of directory names to be used when searching upwards from Python
  files to discover virtulenv directories with.

  For directory named `'foo'`, ALE will search for `'foo/bin/activate'`
  (`foo\Scripts\activate\` on Windows) in all directories on and above the
  directory containing the Python file to find virtualenv paths.


g:ale_warn_about_trailing_blank_lines   *g:ale_warn_about_trailing_blank_lines*
                                        *b:ale_warn_about_trailing_blank_lines*

  Type: |Number|
  Default: `1`

  When this option is set to `1`, warnings about trailing blank lines will be
  shown.

  This option behaves similarly to |g:ale_warn_about_trailing_whitespace|.


g:ale_warn_about_trailing_whitespace     *g:ale_warn_about_trailing_whitespace*
                                         *b:ale_warn_about_trailing_whitespace*

  Type: |Number|
  Default: `1`

  When this option is set to `1`, warnings relating to trailing whitespace on
  lines will be shown. If warnings are too irritating while editing buffers,
  and you have configured Vim to automatically remove trailing whitespace,
  you can disable these warnings by setting this option to `0`.

  Not all linters may respect this option. If a linter does not, please file a
  bug report, and it may be possible to add such support.

  This option may be configured on a per buffer basis.


g:ale_windows_node_executable_path         *g:ale_windows_node_executable_path*
                                           *b:ale_windows_node_executable_path*

  Type: |String|
  Default: `'node.exe'`

  This variable is used as the path to the executable to use for executing
  scripts with Node.js on Windows.

  For Windows, any file with a `.js` file extension needs to be executed with
  the node executable explicitly. Otherwise, Windows could try and open the
  scripts with other applications, like a text editor. Therefore, these
  scripts are executed with whatever executable is configured with this
  setting.


-------------------------------------------------------------------------------
6.1. Highlights                                                *ale-highlights*

ALEError                                                             *ALEError*

  Default: `highlight link ALEError SpellBad`

  The highlight for highlighted errors. See |g:ale_set_highlights|.


ALEErrorLine                                                     *ALEErrorLine*

  Default: Undefined

  The highlight for an entire line where errors appear. Only the first
  line for a problem will be highlighted.

  See |g:ale_set_signs| and |g:ale_set_highlights|.


ALEErrorSign                                                     *ALEErrorSign*

  Default: `highlight link ALEErrorSign error`

  The highlight for error signs. See |g:ale_set_signs|.


ALEErrorSignLineNr                                         *ALEErrorSignLineNr*

  Default: `highlight link ALEErrorSignLineNr CursorLineNr`

  The highlight for error signs. See |g:ale_set_signs|.

  NOTE: This highlight is only available on Neovim 0.3.2 or higher.


ALEInfo                                                              *ALEInfo.*
                                                            *ALEInfo-highlight*
  Default: `highlight link ALEInfo ALEWarning`

  The highlight for highlighted info messages. See |g:ale_set_highlights|.


ALEInfoSign                                                       *ALEInfoSign*

  Default: `highlight link ALEInfoSign ALEWarningSign`

  The highlight for info message signs. See |g:ale_set_signs|.


ALEInfoLine                                                       *ALEInfoLine*

  Default: Undefined

  The highlight for entire lines where info messages appear. Only the first
  line for a problem will be highlighted.

  See |g:ale_set_signs| and |g:ale_set_highlights|.


ALEInfoSignLineNr                                           *ALEInfoSignLineNr*

  Default: `highlight link ALEInfoSignLineNr CursorLineNr`

  The highlight for error signs. See |g:ale_set_signs|.

  NOTE: This highlight is only available on Neovim 0.3.2 or higher.


ALEStyleError                                                   *ALEStyleError*

  Default: `highlight link ALEStyleError ALEError`

  The highlight for highlighted style errors. See |g:ale_set_highlights|.


ALEStyleErrorSign                                           *ALEStyleErrorSign*

  Default: `highlight link ALEStyleErrorSign ALEErrorSign`

  The highlight for style error signs. See |g:ale_set_signs|.


ALEStyleErrorSignLineNr                               *ALEStyleErrorSignLineNr*

  Default: `highlight link ALEStyleErrorSignLineNr CursorLineNr`

  The highlight for error signs. See |g:ale_set_signs|.

  NOTE: This highlight is only available on Neovim 0.3.2 or higher.


ALEStyleWarning                                               *ALEStyleWarning*

  Default: `highlight link ALEStyleWarning ALEError`

  The highlight for highlighted style warnings. See |g:ale_set_highlights|.


ALEStyleWarningSign                                       *ALEStyleWarningSign*

  Default: `highlight link ALEStyleWarningSign ALEWarningSign`

  The highlight for style warning signs. See |g:ale_set_signs|.


ALEStyleWarningSignLineNr                           *ALEStyleWarningSignLineNr*

  Default: `highlight link ALEStyleWarningSignLineNr CursorLineNr`

  The highlight for error signs. See |g:ale_set_signs|.

  NOTE: This highlight is only available on Neovim 0.3.2 or higher.


ALEVirtualTextError                                       *ALEVirtualTextError*

  Default: `highlight link ALEVirtualTextError ALEError`

  The highlight for virtualtext errors. See |g:ale_virtualtext_cursor|.


ALEVirtualTextInfo                                         *ALEVirtualTextInfo*

  Default: `highlight link ALEVirtualTextInfo ALEVirtualTextWarning`

  The highlight for virtualtext info. See |g:ale_virtualtext_cursor|.


ALEVirtualTextStyleError                             *ALEVirtualTextStyleError*

  Default: `highlight link ALEVirtualTextStyleError ALEVirtualTextError`

  The highlight for virtualtext style errors. See |g:ale_virtualtext_cursor|.


ALEVirtualTextStyleWarning                         *ALEVirtualTextStyleWarning*

  Default: `highlight link ALEVirtualTextStyleWarning ALEVirtualTextWarning`

  The highlight for virtualtext style warnings. See |g:ale_virtualtext_cursor|.


ALEVirtualTextWarning                                   *ALEVirtualTextWarning*

  Default: `highlight link ALEVirtualTextWarning ALEWarning`

  The highlight for virtualtext errors. See |g:ale_virtualtext_cursor|.


ALEWarning                                                         *ALEWarning*

  Default: `highlight link ALEWarning SpellCap`

  The highlight for highlighted warnings. See |g:ale_set_highlights|.


ALEWarningLine                                                 *ALEWarningLine*

  Default: Undefined

  The highlight for entire lines where warnings appear. Only the first line
  for a problem will be highlighted.

  See |g:ale_set_signs| and |g:ale_set_highlights|.


ALEWarningSign                                                 *ALEWarningSign*

  Default: `highlight link ALEWarningSign todo`

  The highlight for warning signs. See |g:ale_set_signs|.


ALEWarningSignLineNr                                     *ALEWarningSignLineNr*

  Default: `highlight link ALEWarningSignLineNr CursorLineNr`

  The highlight for error signs. See |g:ale_set_signs|.

  NOTE: This highlight is only available on Neovim 0.3.2 or higher.


===============================================================================
7. Linter/Fixer Options                               *ale-integration-options*

Linter and fixer options are documented below and in individual help files.

Every option for programs can be set globally, or individually for each
buffer. For example, `b:ale_python_flake8_executable` will override any
values set for `g:ale_python_flake8_executable`.

                                           *ale-integrations-local-executables*

Some tools will prefer to search for locally-installed executables, unless
configured otherwise. For example, the `eslint` linter will search for
various executable paths in `node_modules`. The `flake8` linter will search
for virtualenv directories.

If you prefer to use global executables for those tools, set the relevant
`_use_global` and `_executable` options for those linters. >

  " Use the global executable with a special name for eslint.
  let g:ale_javascript_eslint_executable = 'special-eslint'
  let g:ale_javascript_eslint_use_global = 1

  " Use the global executable with a special name for flake8.
  let g:ale_python_flake8_executable = '/foo/bar/flake8'
  let g:ale_python_flake8_use_global = 1
<
|g:ale_use_global_executables| can be set to `1` in your vimrc file to make
ALE use global executables for all linters by default.

The option |g:ale_virtualenv_dir_names| controls the local virtualenv paths
ALE will use to search for Python executables.


-------------------------------------------------------------------------------
7.1. Options for alex                                        *ale-alex-options*

The options for `alex` are shared between all filetypes, so options can be
configured once.

g:ale_alex_executable                                   *g:ale_alex_executable*
                                                        *b:ale_alex_executable*
  Type: |String|
  Default: `'alex'`

  See |ale-integrations-local-executables|


g:ale_alex_use_global                                   *g:ale_alex_use_global*
                                                        *b:ale_alex_use_global*
  Type: |Number|
  Default: `get(g:, 'ale_use_global_executables', 0)`

  See |ale-integrations-local-executables|


-------------------------------------------------------------------------------
7.2. Options for cspell                                    *ale-cspell-options*

The options for `cspell` are shared between all filetypes, so options can be
configured only once.

g:ale_cspell_executable                               *g:ale_cspell_executable*
                                                      *b:ale_cspell_executable*
  Type: |String|
  Default: `'cspell'`

  See |ale-integrations-local-executables|


g:ale_cspell_options                                     *g:ale_cspell_options*
                                                         *b:ale_cspell_options*
  Type: |String|
  Default: `''`

  This variable can be set to pass additional options to `cspell`.


g:ale_cspell_use_global                               *g:ale_cspell_use_global*
                                                      *b:ale_cspell_use_global*
  Type: |Number|
  Default: `get(g: 'ale_use_global_executables', 0)`

  See |ale-integrations-local-executables|


-------------------------------------------------------------------------------
7.3. Options for dprint                                    *ale-dprint-options*

`dprint` is a fixer for many file types, including: (java|type)script,
json(c?), markdown, and more. See https://dprint.dev/plugins for an up-to-date
list of supported plugins and their configuration options.

g:ale_dprint_executable                               *g:ale_dprint_executable*
                                                      *b:ale_dprint_executable*
  Type: |String|
  Default: `'dprint'`

  See |ale-integrations-local-executables|


g:ale_dprint_config                                       *g:ale_dprint_config*
                                                          *b:ale_dprint_config*
  Type: |String|
  Default: `'dprint.json'`

  This variable can be changed to provide a config file to `dprint`. The
  default is the nearest `dprint.json` searching upward from the current
  buffer.

  See https://dprint.dev/config and https://plugins.dprint.dev


g:ale_dprint_options                                     *g:ale_dprint_options*
                                                         *b:ale_dprint_options*
  Type: |String|
  Default: `''`

  This variable can be set to pass additional options to `dprint`.


g:ale_dprint_use_global                               *g:ale_dprint_use_global*
                                                      *b:ale_dprint_use_global*
  Type: |Number|
  Default: `get(g: 'ale_use_global_executables', 0)`

  See |ale-integrations-local-executables|


-------------------------------------------------------------------------------
7.4. Options for languagetool                        *ale-languagetool-options*

g:ale_languagetool_executable                   *g:ale_languagetool_executable*
                                                *b:ale_languagetool_executable*

  Type: |String|
  Default: `'languagetool'`

  The executable to run for languagetool.


g:ale_languagetool_options                         *g:ale_languagetool_options*
                                                   *b:ale_languagetool_options*
  Type: |String|
  Default: `'--autoDetect'`

  This variable can be set to pass additional options to languagetool.


-------------------------------------------------------------------------------
7.5. Options for write-good                            *ale-write-good-options*

The options for `write-good` are shared between all filetypes, so options can
be configured once.

g:ale_writegood_executable                         *g:ale_writegood_executable*
                                                   *b:ale_writegood_executable*
  Type: |String|
  Default: `'writegood'`

  See |ale-integrations-local-executables|


g:ale_writegood_options                               *g:ale_writegood_options*
                                                      *b:ale_writegood_options*
  Type: |String|
  Default: `''`

  This variable can be set to pass additional options to writegood.


g:ale_writegood_use_global                         *g:ale_writegood_use_global*
                                                   *b:ale_writegood_use_global*
  Type: |Number|
  Default: `get(g:, 'ale_use_global_executables', 0)`

  See |ale-integrations-local-executables|


-------------------------------------------------------------------------------
7.6. Other Linter/Fixer Options                 *ale-other-integration-options*

ALE supports a very wide variety of tools. Other linter or fixer options are
documented in additional help files.

  ada.....................................|ale-ada-options|
    cspell................................|ale-ada-cspell|
    gcc...................................|ale-ada-gcc|
    gnatpp................................|ale-ada-gnatpp|
    ada-language-server...................|ale-ada-language-server|
  ansible.................................|ale-ansible-options|
    ansible-lint..........................|ale-ansible-ansible-lint|
  apkbuild................................|ale-apkbuild-options|
    apkbuild-lint.........................|ale-apkbuild-apkbuild-lint|
    secfixes-check........................|ale-apkbuild-secfixes-check|
  asciidoc................................|ale-asciidoc-options|
    cspell................................|ale-asciidoc-cspell|
    write-good............................|ale-asciidoc-write-good|
    textlint..............................|ale-asciidoc-textlint|
  asm.....................................|ale-asm-options|
    gcc...................................|ale-asm-gcc|
  avra....................................|ale-avra-options|
    avra..................................|ale-avra-avra|
  awk.....................................|ale-awk-options|
    gawk..................................|ale-awk-gawk|
  bats....................................|ale-bats-options|
    shellcheck............................|ale-bats-shellcheck|
  bazel...................................|ale-bazel-options|
    buildifier............................|ale-bazel-buildifier|
  bib.....................................|ale-bib-options|
    bibclean..............................|ale-bib-bibclean|
  bitbake.................................|ale-bitbake-options|
    oelint-adv............................|ale-bitbake-oelint_adv|
  c.......................................|ale-c-options|
    astyle................................|ale-c-astyle|
    cc....................................|ale-c-cc|
    ccls..................................|ale-c-ccls|
    clangd................................|ale-c-clangd|
    clang-format..........................|ale-c-clangformat|
    clangtidy.............................|ale-c-clangtidy|
    cppcheck..............................|ale-c-cppcheck|
    cquery................................|ale-c-cquery|
    cspell................................|ale-c-cspell|
    flawfinder............................|ale-c-flawfinder|
    uncrustify............................|ale-c-uncrustify|
  chef....................................|ale-chef-options|
    cookstyle.............................|ale-chef-cookstyle|
    foodcritic............................|ale-chef-foodcritic|
  clojure.................................|ale-clojure-options|
    clj-kondo.............................|ale-clojure-clj-kondo|
    joker.................................|ale-clojure-joker|
  cloudformation..........................|ale-cloudformation-options|
    cfn-python-lint.......................|ale-cloudformation-cfn-python-lint|
  cmake...................................|ale-cmake-options|
    cmakelint.............................|ale-cmake-cmakelint|
    cmake-lint............................|ale-cmake-cmake-lint|
    cmake-format..........................|ale-cmake-cmakeformat|
  cpp.....................................|ale-cpp-options|
    astyle................................|ale-cpp-astyle|
    cc....................................|ale-cpp-cc|
    ccls..................................|ale-cpp-ccls|
    clangcheck............................|ale-cpp-clangcheck|
    clangd................................|ale-cpp-clangd|
    clang-format..........................|ale-cpp-clangformat|
    clangtidy.............................|ale-cpp-clangtidy|
    clazy.................................|ale-cpp-clazy|
    cppcheck..............................|ale-cpp-cppcheck|
    cpplint...............................|ale-cpp-cpplint|
    cquery................................|ale-cpp-cquery|
    cspell................................|ale-cpp-cspell|
    flawfinder............................|ale-cpp-flawfinder|
    uncrustify............................|ale-cpp-uncrustify|
  c#......................................|ale-cs-options|
    csc...................................|ale-cs-csc|
    cspell................................|ale-cs-cspell|
    dotnet-format.........................|ale-cs-dotnet-format|
    mcs...................................|ale-cs-mcs|
    mcsc..................................|ale-cs-mcsc|
    uncrustify............................|ale-cs-uncrustify|
  css.....................................|ale-css-options|
    cspell................................|ale-css-cspell|
    fecs..................................|ale-css-fecs|
    prettier..............................|ale-css-prettier|
    stylelint.............................|ale-css-stylelint|
    vscodecss.............................|ale-css-vscode|
  cuda....................................|ale-cuda-options|
    nvcc..................................|ale-cuda-nvcc|
    clangd................................|ale-cuda-clangd|
    clang-format..........................|ale-cuda-clangformat|
  d.......................................|ale-d-options|
    dfmt..................................|ale-d-dfmt|
    dls...................................|ale-d-dls|
    uncrustify............................|ale-d-uncrustify|
  dafny...................................|ale-dafny-options|
    dafny.................................|ale-dafny-dafny|
  dart....................................|ale-dart-options|
    analysis_server.......................|ale-dart-analysis_server|
    dart-analyze..........................|ale-dart-analyze|
    dart-format...........................|ale-dart-format|
    dartfmt...............................|ale-dart-dartfmt|
  desktop.................................|ale-desktop-options|
    desktop-file-validate.................|ale-desktop-desktop-file-validate|
  dhall...................................|ale-dhall-options|
    dhall-format..........................|ale-dhall-format|
    dhall-freeze..........................|ale-dhall-freeze|
    dhall-lint............................|ale-dhall-lint|
  dockerfile..............................|ale-dockerfile-options|
    dockerfile_lint.......................|ale-dockerfile-dockerfile_lint|
    dprint................................|ale-dockerfile-dprint|
    hadolint..............................|ale-dockerfile-hadolint|
  elixir..................................|ale-elixir-options|
    mix...................................|ale-elixir-mix|
    mix_format............................|ale-elixir-mix-format|
    dialyxir..............................|ale-elixir-dialyxir|
    elixir-ls.............................|ale-elixir-elixir-ls|
    credo.................................|ale-elixir-credo|
    cspell................................|ale-elixir-cspell|
  elm.....................................|ale-elm-options|
    elm-format............................|ale-elm-elm-format|
    elm-ls................................|ale-elm-elm-ls|
    elm-make..............................|ale-elm-elm-make|
  erlang..................................|ale-erlang-options|
    dialyzer..............................|ale-erlang-dialyzer|
    elvis.................................|ale-erlang-elvis|
    erlc..................................|ale-erlang-erlc|
    erlfmt................................|ale-erlang-erlfmt|
    syntaxerl.............................|ale-erlang-syntaxerl|
  eruby...................................|ale-eruby-options|
    erblint...............................|ale-eruby-erblint|
    ruumba................................|ale-eruby-ruumba|
  fish....................................|ale-fish-options|
    fish_indent...........................|ale-fish-fish_indent|
  fortran.................................|ale-fortran-options|
    gcc...................................|ale-fortran-gcc|
    language_server.......................|ale-fortran-language-server|
  fountain................................|ale-fountain-options|
  fusionscript............................|ale-fuse-options|
    fusion-lint...........................|ale-fuse-fusionlint|
  git commit..............................|ale-gitcommit-options|
    gitlint...............................|ale-gitcommit-gitlint|
  glsl....................................|ale-glsl-options|
    glslang...............................|ale-glsl-glslang|
    glslls................................|ale-glsl-glslls|
  go......................................|ale-go-options|
    bingo.................................|ale-go-bingo|
    cspell................................|ale-go-cspell|
    gobuild...............................|ale-go-gobuild|
    gofmt.................................|ale-go-gofmt|
    gofumpt...............................|ale-go-gofumpt|
    golangci-lint.........................|ale-go-golangci-lint|
    golangserver..........................|ale-go-golangserver|
    golines...............................|ale-go-golines|
    golint................................|ale-go-golint|
    gometalinter..........................|ale-go-gometalinter|
    gopls.................................|ale-go-gopls|
    govet.................................|ale-go-govet|
    revive................................|ale-go-revive|
    staticcheck...........................|ale-go-staticcheck|
  graphql.................................|ale-graphql-options|
    eslint................................|ale-graphql-eslint|
    gqlint................................|ale-graphql-gqlint|
    prettier..............................|ale-graphql-prettier|
  hack....................................|ale-hack-options|
    hack..................................|ale-hack-hack|
    hackfmt...............................|ale-hack-hackfmt|
    hhast.................................|ale-hack-hhast|
  handlebars..............................|ale-handlebars-options|
    prettier..............................|ale-handlebars-prettier|
    ember-template-lint...................|ale-handlebars-embertemplatelint|
  haskell.................................|ale-haskell-options|
    brittany..............................|ale-haskell-brittany|
    cspell................................|ale-haskell-cspell|
    floskell..............................|ale-haskell-floskell|
    ghc...................................|ale-haskell-ghc|
    ghc-mod...............................|ale-haskell-ghc-mod|
    cabal-ghc.............................|ale-haskell-cabal-ghc|
    hdevtools.............................|ale-haskell-hdevtools|
    hfmt..................................|ale-haskell-hfmt|
    hindent...............................|ale-haskell-hindent|
    hlint.................................|ale-haskell-hlint|
    hls...................................|ale-haskell-hls|
    stack-build...........................|ale-haskell-stack-build|
    stack-ghc.............................|ale-haskell-stack-ghc|
    stylish-haskell.......................|ale-haskell-stylish-haskell|
    hie...................................|ale-haskell-hie|
    ormolu................................|ale-haskell-ormolu|
  hcl.....................................|ale-hcl-options|
    packer-fmt............................|ale-hcl-packer-fmt|
    terraform-fmt.........................|ale-hcl-terraform-fmt|
  help....................................|ale-help-options|
    cspell................................|ale-help-cspell|
  html....................................|ale-html-options|
    angular...............................|ale-html-angular|
    cspell................................|ale-html-cspell|
    fecs..................................|ale-html-fecs|
    html-beautify.........................|ale-html-beautify|
    htmlhint..............................|ale-html-htmlhint|
    prettier..............................|ale-html-prettier|
    stylelint.............................|ale-html-stylelint|
    tidy..................................|ale-html-tidy|
    vscodehtml............................|ale-html-vscode|
    write-good............................|ale-html-write-good|
  idris...................................|ale-idris-options|
    idris.................................|ale-idris-idris|
  ink.....................................|ale-ink-options|
    ink-language-server...................|ale-ink-language-server|
  inko....................................|ale-inko-options|
    inko..................................|ale-inko-inko|
  ispc....................................|ale-ispc-options|
    ispc..................................|ale-ispc-ispc|
  java....................................|ale-java-options|
    checkstyle............................|ale-java-checkstyle|
    cspell................................|ale-java-cspell|
    javac.................................|ale-java-javac|
    google-java-format....................|ale-java-google-java-format|
    pmd...................................|ale-java-pmd|
    javalsp...............................|ale-java-javalsp|
    eclipselsp............................|ale-java-eclipselsp|
    uncrustify............................|ale-java-uncrustify|
  javascript..............................|ale-javascript-options|
    cspell................................|ale-javascript-cspell|
    deno..................................|ale-javascript-deno|
    dprint................................|ale-javascript-dprint|
    eslint................................|ale-javascript-eslint|
    fecs..................................|ale-javascript-fecs|
    flow..................................|ale-javascript-flow|
    importjs..............................|ale-javascript-importjs|
    jscs..................................|ale-javascript-jscs|
    jshint................................|ale-javascript-jshint|
    prettier..............................|ale-javascript-prettier|
    prettier-eslint.......................|ale-javascript-prettier-eslint|
    prettier-standard.....................|ale-javascript-prettier-standard|
    standard..............................|ale-javascript-standard|
    xo....................................|ale-javascript-xo|
  json....................................|ale-json-options|
    cspell................................|ale-json-cspell|
    dprint................................|ale-json-dprint|
    eslint................................|ale-json-eslint|
    fixjson...............................|ale-json-fixjson|
    jsonlint..............................|ale-json-jsonlint|
    jq....................................|ale-json-jq|
    prettier..............................|ale-json-prettier|
    spectral..............................|ale-json-spectral|
    vscodejson............................|ale-json-vscode|
  jsonc...................................|ale-jsonc-options|
    eslint................................|ale-jsonc-eslint|
  jsonnet.................................|ale-jsonnet-options|
    jsonnetfmt............................|ale-jsonnet-jsonnetfmt|
    jsonnet-lint..........................|ale-jsonnet-jsonnet-lint|
  json5...................................|ale-json5-options|
    eslint................................|ale-json5-eslint|
  julia...................................|ale-julia-options|
    languageserver........................|ale-julia-languageserver|
  kotlin..................................|ale-kotlin-options|
    kotlinc...............................|ale-kotlin-kotlinc|
    ktlint................................|ale-kotlin-ktlint|
    languageserver........................|ale-kotlin-languageserver|
  latex...................................|ale-latex-options|
    cspell................................|ale-latex-cspell|
    write-good............................|ale-latex-write-good|
    textlint..............................|ale-latex-textlint|
  less....................................|ale-less-options|
    lessc.................................|ale-less-lessc|
    prettier..............................|ale-less-prettier|
    stylelint.............................|ale-less-stylelint|
  llvm....................................|ale-llvm-options|
    llc...................................|ale-llvm-llc|
  lua.....................................|ale-lua-options|
    cspell................................|ale-lua-cspell|
    lua-format............................|ale-lua-lua-format|
    luac..................................|ale-lua-luac|
    luacheck..............................|ale-lua-luacheck|
    luafmt................................|ale-lua-luafmt|
    selene................................|ale-lua-selene|
    stylua................................|ale-lua-stylua|
  markdown................................|ale-markdown-options|
    cspell................................|ale-markdown-cspell|
    dprint................................|ale-markdown-dprint|
    markdownlint..........................|ale-markdown-markdownlint|
    mdl...................................|ale-markdown-mdl|
    pandoc................................|ale-markdown-pandoc|
    prettier..............................|ale-markdown-prettier|
    remark-lint...........................|ale-markdown-remark-lint|
    textlint..............................|ale-markdown-textlint|
    write-good............................|ale-markdown-write-good|
  mercury.................................|ale-mercury-options|
    mmc...................................|ale-mercury-mmc|
  nasm....................................|ale-nasm-options|
    nasm..................................|ale-nasm-nasm|
  nim.....................................|ale-nim-options|
    nimcheck..............................|ale-nim-nimcheck|
    nimlsp................................|ale-nim-nimlsp|
    nimpretty.............................|ale-nim-nimpretty|
  nix.....................................|ale-nix-options|
    nixfmt................................|ale-nix-nixfmt|
    nixpkgs-fmt...........................|ale-nix-nixpkgs-fmt|
    statix................................|ale-nix-statix|
  nroff...................................|ale-nroff-options|
    write-good............................|ale-nroff-write-good|
  objc....................................|ale-objc-options|
    clang.................................|ale-objc-clang|
    clangd................................|ale-objc-clangd|
    uncrustify............................|ale-objc-uncrustify|
    ccls..................................|ale-objc-ccls|
  objcpp..................................|ale-objcpp-options|
    clang.................................|ale-objcpp-clang|
    clangd................................|ale-objcpp-clangd|
    uncrustify............................|ale-objcpp-uncrustify|
  ocaml...................................|ale-ocaml-options|
    merlin................................|ale-ocaml-merlin|
    ocamllsp..............................|ale-ocaml-ocamllsp|
    ols...................................|ale-ocaml-ols|
    ocamlformat...........................|ale-ocaml-ocamlformat|
    ocp-indent............................|ale-ocaml-ocp-indent|
  openapi.................................|ale-openapi-options|
    ibm_validator.........................|ale-openapi-ibm-validator|
    prettier..............................|ale-openapi-prettier|
    yamllint..............................|ale-openapi-yamllint|
  packer..................................|ale-packer-options|
    packer-fmt-fixer......................|ale-packer-fmt-fixer|
  pascal..................................|ale-pascal-options|
    ptop..................................|ale-pascal-ptop|
  pawn....................................|ale-pawn-options|
    uncrustify............................|ale-pawn-uncrustify|
  perl....................................|ale-perl-options|
    perl..................................|ale-perl-perl|
    perlcritic............................|ale-perl-perlcritic|
    perltidy..............................|ale-perl-perltidy|
  perl6...................................|ale-perl6-options|
    perl6.................................|ale-perl6-perl6|
  php.....................................|ale-php-options|
    cspell................................|ale-php-cspell|
    langserver............................|ale-php-langserver|
    phan..................................|ale-php-phan|
    phpcbf................................|ale-php-phpcbf|
    phpcs.................................|ale-php-phpcs|
    phpmd.................................|ale-php-phpmd|
    phpstan...............................|ale-php-phpstan|
    psalm.................................|ale-php-psalm|
    php-cs-fixer..........................|ale-php-php-cs-fixer|
    php...................................|ale-php-php|
    tlint.................................|ale-php-tlint|
    intelephense..........................|ale-php-intelephense|
  po......................................|ale-po-options|
    write-good............................|ale-po-write-good|
  pod.....................................|ale-pod-options|
    write-good............................|ale-pod-write-good|
  pony....................................|ale-pony-options|
    ponyc.................................|ale-pony-ponyc|
  powershell..............................|ale-powershell-options|
    cspell................................|ale-powershell-cspell|
    powershell............................|ale-powershell-powershell|
    psscriptanalyzer......................|ale-powershell-psscriptanalyzer|
  prolog..................................|ale-prolog-options|
    swipl.................................|ale-prolog-swipl|
  proto...................................|ale-proto-options|
    buf-format............................|ale-proto-buf-format|
    buf-lint..............................|ale-proto-buf-lint|
    protoc-gen-lint.......................|ale-proto-protoc-gen-lint|
    protolint.............................|ale-proto-protolint|
  pug.....................................|ale-pug-options|
    puglint...............................|ale-pug-puglint|
  puppet..................................|ale-puppet-options|
    puppet................................|ale-puppet-puppet|
    puppetlint............................|ale-puppet-puppetlint|
    puppet-languageserver.................|ale-puppet-languageserver|
  purescript..............................|ale-purescript-options|
    purescript-language-server............|ale-purescript-language-server|
    purs-tidy.............................|ale-purescript-tidy|
    purty.................................|ale-purescript-purty|
  pyrex (cython)..........................|ale-pyrex-options|
    cython................................|ale-pyrex-cython|
  python..................................|ale-python-options|
    autoflake.............................|ale-python-autoflake|
    autoimport............................|ale-python-autoimport|
    autopep8..............................|ale-python-autopep8|
    bandit................................|ale-python-bandit|
    black.................................|ale-python-black|
    cspell................................|ale-python-cspell|
    flake8................................|ale-python-flake8|
    flakehell.............................|ale-python-flakehell|
    isort.................................|ale-python-isort|
    mypy..................................|ale-python-mypy|
    prospector............................|ale-python-prospector|
    pycodestyle...........................|ale-python-pycodestyle|
    pydocstyle............................|ale-python-pydocstyle|
    pyflakes..............................|ale-python-pyflakes|
    pylama................................|ale-python-pylama|
    pylint................................|ale-python-pylint|
    pylsp.................................|ale-python-pylsp|
    pyre..................................|ale-python-pyre|
    pyright...............................|ale-python-pyright|
    reorder-python-imports................|ale-python-reorder_python_imports|
    unimport..............................|ale-python-unimport|
    vulture...............................|ale-python-vulture|
    yapf..................................|ale-python-yapf|
  qml.....................................|ale-qml-options|
    qmlfmt................................|ale-qml-qmlfmt|
  r.......................................|ale-r-options|
    languageserver........................|ale-r-languageserver|
    lintr.................................|ale-r-lintr|
    styler................................|ale-r-styler|
  reasonml................................|ale-reasonml-options|
    merlin................................|ale-reasonml-merlin|
    ols...................................|ale-reasonml-ols|
    reason-language-server................|ale-reasonml-language-server|
    refmt.................................|ale-reasonml-refmt|
  rego....................................|ale-rego-options|
    cspell................................|ale-rego-cspell|
    opacheck..............................|ale-rego-opa-check|
    opafmt................................|ale-rego-opa-fmt-fixer|
  restructuredtext........................|ale-restructuredtext-options|
    cspell................................|ale-restructuredtext-cspell|
    textlint..............................|ale-restructuredtext-textlint|
    write-good............................|ale-restructuredtext-write-good|
  robot...................................|ale-robot-options|
    rflint................................|ale-robot-rflint|
  ruby....................................|ale-ruby-options|
    brakeman..............................|ale-ruby-brakeman|
    cspell................................|ale-ruby-cspell|
    debride...............................|ale-ruby-debride|
    prettier..............................|ale-ruby-prettier|
    rails_best_practices..................|ale-ruby-rails_best_practices|
    reek..................................|ale-ruby-reek|
    rubocop...............................|ale-ruby-rubocop|
    ruby..................................|ale-ruby-ruby|
    rufo..................................|ale-ruby-rufo|
    solargraph............................|ale-ruby-solargraph|
    sorbet................................|ale-ruby-sorbet|
    standardrb............................|ale-ruby-standardrb|
  rust....................................|ale-rust-options|
    analyzer..............................|ale-rust-analyzer|
    cargo.................................|ale-rust-cargo|
    cspell................................|ale-rust-cspell|
    rls...................................|ale-rust-rls|
    rustc.................................|ale-rust-rustc|
    rustfmt...............................|ale-rust-rustfmt|
  salt....................................|ale-salt-options|
    salt-lint.............................|ale-salt-salt-lint|
  sass....................................|ale-sass-options|
    sasslint..............................|ale-sass-sasslint|
    stylelint.............................|ale-sass-stylelint|
  scala...................................|ale-scala-options|
    cspell................................|ale-scala-cspell|
    metals................................|ale-scala-metals|
    sbtserver.............................|ale-scala-sbtserver|
    scalafmt..............................|ale-scala-scalafmt|
    scalastyle............................|ale-scala-scalastyle|
  scss....................................|ale-scss-options|
    prettier..............................|ale-scss-prettier|
    sasslint..............................|ale-scss-sasslint|
    stylelint.............................|ale-scss-stylelint|
  sh......................................|ale-sh-options|
    bashate...............................|ale-sh-bashate|
    cspell................................|ale-sh-cspell|
    sh-language-server....................|ale-sh-language-server|
    shell.................................|ale-sh-shell|
    shellcheck............................|ale-sh-shellcheck|
    shfmt.................................|ale-sh-shfmt|
  sml.....................................|ale-sml-options|
    smlnj.................................|ale-sml-smlnj|
  solidity................................|ale-solidity-options|
    solc..................................|ale-solidity-solc|
    solhint...............................|ale-solidity-solhint|
    solium................................|ale-solidity-solium|
  spec....................................|ale-spec-options|
    rpmlint...............................|ale-spec-rpmlint|
  sql.....................................|ale-sql-options|
    dprint................................|ale-sql-dprint|
    pgformatter...........................|ale-sql-pgformatter|
    sqlfmt................................|ale-sql-sqlfmt|
    sqlformat.............................|ale-sql-sqlformat|
  stylus..................................|ale-stylus-options|
    stylelint.............................|ale-stylus-stylelint|
  sugarss.................................|ale-sugarss-options|
    stylelint.............................|ale-sugarss-stylelint|
  svelte..................................|ale-svelte-options|
    prettier..............................|ale-svelte-prettier|
    svelteserver..........................|ale-svelte-svelteserver|
  swift...................................|ale-swift-options|
    apple-swift-format....................|ale-swift-apple-swift-format|
    cspell................................|ale-swift-cspell|
    sourcekitlsp..........................|ale-swift-sourcekitlsp|
  systemd.................................|ale-systemd-options|
    systemd-analyze.......................|ale-systemd-analyze|
  tcl.....................................|ale-tcl-options|
    nagelfar..............................|ale-tcl-nagelfar|
  terraform...............................|ale-terraform-options|
    checkov...............................|ale-terraform-checkov|
    terraform-fmt-fixer...................|ale-terraform-fmt-fixer|
    terraform.............................|ale-terraform-terraform|
    terraform-ls..........................|ale-terraform-terraform-ls|
    terraform-lsp.........................|ale-terraform-terraform-lsp|
    tflint................................|ale-terraform-tflint|
  tex.....................................|ale-tex-options|
    chktex................................|ale-tex-chktex|
    cspell................................|ale-tex-cspell|
    lacheck...............................|ale-tex-lacheck|
    latexindent...........................|ale-tex-latexindent|
    texlab................................|ale-tex-texlab|
  texinfo.................................|ale-texinfo-options|
    cspell................................|ale-texinfo-cspell|
    write-good............................|ale-texinfo-write-good|
  text....................................|ale-text-options|
    cspell................................|ale-text-cspell|
    textlint..............................|ale-text-textlint|
    write-good............................|ale-text-write-good|
  thrift..................................|ale-thrift-options|
    thrift................................|ale-thrift-thrift|
    thriftcheck...........................|ale-thrift-thriftcheck|
  toml....................................|ale-toml-options|
    dprint................................|ale-toml-dprint|
  typescript..............................|ale-typescript-options|
    cspell................................|ale-typescript-cspell|
    deno..................................|ale-typescript-deno|
    dprint................................|ale-typescript-dprint|
    eslint................................|ale-typescript-eslint|
    prettier..............................|ale-typescript-prettier|
    standard..............................|ale-typescript-standard|
    tslint................................|ale-typescript-tslint|
    tsserver..............................|ale-typescript-tsserver|
    xo....................................|ale-typescript-xo|
  v.......................................|ale-v-options|
    v.....................................|ale-v-v|
    vfmt..................................|ale-v-vfmt|
  vala....................................|ale-vala-options|
    uncrustify............................|ale-vala-uncrustify|
  verilog/systemverilog...................|ale-verilog-options|
    hdl-checker...........................|ale-verilog-hdl-checker|
    iverilog..............................|ale-verilog-iverilog|
    verilator.............................|ale-verilog-verilator|
    vlog..................................|ale-verilog-vlog|
    xvlog.................................|ale-verilog-xvlog|
    yosys.................................|ale-verilog-yosys|
  vhdl....................................|ale-vhdl-options|
    ghdl..................................|ale-vhdl-ghdl|
    hdl-checker...........................|ale-vhdl-hdl-checker|
    vcom..................................|ale-vhdl-vcom|
    xvhdl.................................|ale-vhdl-xvhdl|
  vim help................................|ale-vim-help-options|
    write-good............................|ale-vim-help-write-good|
  vim.....................................|ale-vim-options|
    vimls.................................|ale-vim-vimls|
    vint..................................|ale-vim-vint|
  vue.....................................|ale-vue-options|
    cspell................................|ale-vue-cspell|
    prettier..............................|ale-vue-prettier|
    vls...................................|ale-vue-vls|
    volar.................................|ale-vue-volar|
  wgsl....................................|ale-wgsl-options|
    naga..................................|ale-wgsl-naga|
  xhtml...................................|ale-xhtml-options|
    cspell................................|ale-xhtml-cspell|
    write-good............................|ale-xhtml-write-good|
  xml.....................................|ale-xml-options|
    xmllint...............................|ale-xml-xmllint|
  yaml....................................|ale-yaml-options|
    actionlint............................|ale-yaml-actionlint|
    circleci..............................|ale-yaml-circleci|
    prettier..............................|ale-yaml-prettier|
    spectral..............................|ale-yaml-spectral|
    swaglint..............................|ale-yaml-swaglint|
    yaml-language-server..................|ale-yaml-language-server|
    yamlfix...............................|ale-yaml-yamlfix|
    yamllint..............................|ale-yaml-yamllint|
  yang....................................|ale-yang-options|
    yang-lsp..............................|ale-yang-lsp|
  zeek....................................|ale-zeek-options|
    zeek..................................|ale-zeek-zeek|
  zig.....................................|ale-zig-options|
    zigfmt................................|ale-zig-zigfmt|
    zls...................................|ale-zig-zls|


===============================================================================
8. Commands/Keybinds                                             *ale-commands*

ALEComplete                                                       *ALEComplete*

  Manually trigger LSP autocomplete and show the menu. Works only when called
  from insert mode. >

    inoremap <silent> <C-Space> <C-\><C-O>:ALEComplete<CR>
<
  A plug mapping `<Plug>(ale_complete)` is defined for this command. >

    imap <C-Space> <Plug>(ale_complete)
<
ALEDocumentation                                             *ALEDocumentation*

  Similar to the |ALEHover| command, retrieve documentation information for
  the symbol at the cursor. Documentation data will always be shown in a
  preview window, no matter how small the documentation content is.

  NOTE: This command is only available for `tsserver`.

  A plug mapping `<Plug>(ale_documentation)` is defined for this command.


ALEFindReferences                                           *ALEFindReferences*

  Find references in the codebase for the symbol under the cursor using the
  enabled LSP linters for the buffer. ALE will display a preview window
  containing the results if some references are found.

  The window can be navigated using the usual Vim navigation commands. The
  Enter key (`<CR>`) can be used to jump to a referencing location, or the `t`
  key can be used to jump to the location in a new tab.

  The locations opened in different ways using the following variations.

  `:ALEFindReferences -tab`       - Open the location in a new tab.
  `:ALEFindReferences -split`     - Open the location in a horizontal split.
  `:ALEFindReferences -vsplit`    - Open the location in a vertical split.
  `:ALEFindReferences -quickfix`  - Put the locations into quickfix list.

  The default method used for navigating to a new location can be changed
  by modifying |g:ale_default_navigation|.

  You can add `-relative` to the command to view results with relatives paths,
  instead of absolute paths. This option has no effect if `-quickfix` is used.

  The selection can be opened again with the |ALERepeatSelection| command.

  You can jump back to the position you were at before going to a reference of
  something with jump motions like CTRL-O. See |jump-motions|.

  A plug mapping `<Plug>(ale_find_references)` is defined for this command.
  You can define additional plug mapping with any additional options you want
  like so: >

  nnoremap <silent> <Plug>(my_mapping) :ALEFindReferences -relative<Return>
<

ALEFix                                                                 *ALEFix*

  Fix problems with the current buffer. See |ale-fix| for more information.

  If the command is run with a bang (`:ALEFix!`), all warnings will be
  suppressed, including warnings about no fixers being defined, and warnings
  about not being able to apply fixes to a file because it has been changed.

  A plug mapping `<Plug>(ale_fix)` is defined for this command.


ALEFixSuggest                                                   *ALEFixSuggest*

  Suggest tools that can be used to fix problems in the current buffer.

  See |ale-fix| for more information.


ALEGoToDefinition `<options>`                               *ALEGoToDefinition*

  Jump to the definition of a symbol under the cursor using the enabled LSP
  linters for the buffer. ALE will jump to a definition if an LSP server
  provides a location to jump to. Otherwise, ALE will do nothing.

  The locations opened in different ways using the following variations.

  `:ALEGoToDefinition -tab`    - Open the location in a new tab.
  `:ALEGoToDefinition -split`  - Open the location in a horizontal split.
  `:ALEGoToDefinition -vsplit` - Open the location in a vertical split.

  The default method used for navigating to a new location can be changed
  by modifying |g:ale_default_navigation|.

  You can jump back to the position you were at before going to the definition
  of something with jump motions like CTRL-O. See |jump-motions|.

  You should consider using the 'hidden' option in combination with this
  command. Otherwise, Vim will refuse to leave the buffer you're jumping from
  unless you have saved your edits.

  The following Plug mappings are defined for this command, which correspond
  to the following commands.

  `<Plug>(ale_go_to_definition)`           - `:ALEGoToDefinition`
  `<Plug>(ale_go_to_definition_in_tab)`    - `:ALEGoToDefinition -tab`
  `<Plug>(ale_go_to_definition_in_split)`  - `:ALEGoToDefinition -split`
  `<Plug>(ale_go_to_definition_in_vsplit)` - `:ALEGoToDefinition -vsplit`


ALEGoToTypeDefinition                                   *ALEGoToTypeDefinition*

  This works similar to |ALEGoToDefinition| but instead jumps to the
  definition of a type of a symbol under the cursor. ALE will jump to a
  definition if an LSP server provides a location to jump to. Otherwise, ALE
  will do nothing.

  The locations opened in different ways using the following variations.

  `:ALEGoToTypeDefinition -tab`    - Open the location in a new tab.
  `:ALEGoToTypeDefinition -split`  - Open the location in a horizontal split.
  `:ALEGoToTypeDefinition -vsplit` - Open the location in a vertical split.

  The default method used for navigating to a new location can be changed
  by modifying |g:ale_default_navigation|.

  You can jump back to the position you were at before going to the definition
  of something with jump motions like CTRL-O. See |jump-motions|.

  The following Plug mappings are defined for this command, which correspond
  to the following commands.

  `<Plug>(ale_go_to_type_definition)`           - `:ALEGoToTypeDefinition`
  `<Plug>(ale_go_to_type_definition_in_tab)`    - `:ALEGoToTypeDefinition -tab`
  `<Plug>(ale_go_to_type_definition_in_split)`  - `:ALEGoToTypeDefinition -split`
  `<Plug>(ale_go_to_type_definition_in_vsplit)` - `:ALEGoToTypeDefinition -vsplit`


ALEGoToImplementation                                   *ALEGoToImplementation*

  This works similar to |ALEGoToDefinition| but instead jumps to the
  implementation of symbol under the cursor. ALE will jump to a definition if
  an LSP server provides a location to jump to. Otherwise, ALE will do nothing.

  The locations opened in different ways using the following variations.

  `:ALEGoToImplementation -tab`    - Open the location in a new tab.
  `:ALEGoToImplementation -split`  - Open the location in a horizontal split.
  `:ALEGoToImplementation -vsplit` - Open the location in a vertical split.

  The default method used for navigating to a new location can be changed
  by modifying |g:ale_default_navigation|.

  You can jump back to the position you were at before going to the definition
  of something with jump motions like CTRL-O. See |jump-motions|.

  The following Plug mappings are defined for this command, which correspond
  to the following commands.

  `<Plug>(ale_go_to_implementation)`           - `:ALEGoToImplementation`
  `<Plug>(ale_go_to_implementation_in_tab)`    - `:ALEGoToImplementation -tab`
  `<Plug>(ale_go_to_implementation_in_split)`  - `:ALEGoToImplementation -split`
  `<Plug>(ale_go_to_implementation_in_vsplit)` - `:ALEGoToImplementation -vsplit`


ALEHover                                                             *ALEHover*

  Print brief information about the symbol under the cursor, taken from any
  available LSP linters. There may be a small non-blocking delay before
  information is printed.

  NOTE: In Vim 8, long messages will be shown in a preview window, as Vim 8
  does not support showing a prompt to press enter to continue for long
  messages from asynchronous callbacks.

  A plug mapping `<Plug>(ale_hover)` is defined for this command.


ALEImport                                                           *ALEImport*

  Try to import a symbol using `tsserver` or a Language Server.

  ALE will look for completions for the word at the cursor which contain
  additional text edits that possible insert lines to import the symbol. The
  first match with additional text edits will be used, and may add other code
  to the current buffer other than import lines.

  If linting is enabled, and |g:ale_lint_on_text_changed| is set to ever check
  buffers when text is changed, the buffer will be checked again after changes
  are made.

  A Plug mapping `<Plug>(ale_import)` is defined for this command. This
  mapping should only be bound for normal mode.


ALEOrganizeImports                                         *ALEOrganizeImports*

  Organize imports using tsserver. Currently not implemented for LSPs.


ALERename                                                           *ALERename*

  Rename a symbol using `tsserver` or a Language Server.

  The symbol where the cursor is resting will be the symbol renamed, and a
  prompt will open to request a new name.

  The rename operation will save all modified buffers when `set nohidden` is
  set, because that disables leaving unsaved buffers in the background. See
  `:help hidden` for more details.

ALEFileRename                                                   *ALEFileRename*

  Rename a file and fix imports using `tsserver`.

ALECodeAction                                                   *ALECodeAction*

  Apply a code action via LSP servers or `tsserver`.

  If there is an error present on a line that can be fixed, ALE will
  automatically fix a line, unless there are multiple possible code fixes to
  apply.

  This command can be run in visual mode apply actions, such as applicable
  refactors. A menu will be shown to select code action to apply.


ALERepeatSelection                                         *ALERepeatSelection*

  Repeat the last selection displayed in the preview window.


ALESymbolSearch `<query>`                                     *ALESymbolSearch*

  Search for symbols in the workspace, taken from any available LSP linters.

  The arguments provided to this command will be used as a search query for
  finding symbols in the workspace, such as functions, types, etc.

  You can add `-relative` to the command to view results with relatives paths,
  instead of absolute paths.

                                                                     *:ALELint*
ALELint                                                               *ALELint*

  Run ALE once for the current buffer. This command can be used to run ALE
  manually, instead of automatically, if desired.

  This command will also run linters where `lint_file` is evaluates to `1`,
  meaning linters which check the file instead of the Vim buffer.

  A plug mapping `<Plug>(ale_lint)` is defined for this command.


ALELintStop                                                       *ALELintStop*

  Stop any currently running jobs for checking the current buffer.

  Any problems from previous linter results will continue to be shown.


ALEPopulateQuickfix                                       *ALEPopulateQuickfix*
ALEPopulateLocList                                         *ALEPopulateLocList*

  Manually populate the |quickfix| or |location-list| and show the
  corresponding list. Useful when you have other uses for both the |quickfix|
  and |location-list| and don't want them automatically populated. Be sure to
  disable auto populating: >

    let g:ale_set_quickfix = 0
    let g:ale_set_loclist = 0
<
  With these settings, ALE will still run checking and display it with signs,
  highlighting, and other output described in |ale-lint-file-linters|.

ALEPrevious                                                       *ALEPrevious*
ALEPreviousWrap                                               *ALEPreviousWrap*
ALENext                                                               *ALENext*
ALENextWrap                                                       *ALENextWrap*
ALEFirst                                                             *ALEFirst*
ALELast                                                               *ALELast*
                                                      *ale-navigation-commands*

  Move between warnings or errors in a buffer. ALE will only navigate between
  the errors or warnings it generated, even if both |g:ale_set_quickfix|
  and |g:ale_set_loclist| are set to `0`.

  `ALEPrevious` and `ALENext` will stop at the top and bottom of a file, while
  `ALEPreviousWrap` and `ALENextWrap` will wrap around the file to find
  the last or first warning or error in the file, respectively.

  `ALEPrevious` and `ALENext` take optional flags arguments to custom their
  behavior :
  `-wrap` enable wrapping around the file
  `-error`, `-warning` and `-info` enable jumping to errors, warnings or infos
    respectively, ignoring anything else. They are mutually exclusive and if
    several are provided the priority is the following: error > warning > info.
  `-style` and `-nostyle` allow you to jump respectively to style error or
    warning and to not style error or warning. They also are mutually
    exclusive and nostyle has priority over style.

  Flags can be combined to create create custom jumping. Thus you can use
  ":ALENext -wrap -error -nosyle" to jump to the next error which is not a
  style error while going back to the beginning of the file if needed.

  `ALEFirst` goes to the first error or warning in the buffer, while `ALELast`
  goes to the last one.

  The following |<Plug>| mappings are defined for the commands: >
  <Plug>(ale_previous) - ALEPrevious
  <Plug>(ale_previous_wrap) - ALEPreviousWrap
  <Plug>(ale_previous_error) - ALEPrevious -error
  <Plug>(ale_previous_wrap_error) - ALEPrevious -wrap -error
  <Plug>(ale_previous_warning) - ALEPrevious -warning
  <Plug>(ale_previous_wrap_warning) - ALEPrevious -wrap -warning
  <Plug>(ale_next) - ALENext
  <Plug>(ale_next_wrap) - ALENextWrap
  <Plug>(ale_next_error) - ALENext -error
  <Plug>(ale_next_wrap_error) - ALENext -wrap -error
  <Plug>(ale_next_warning) - ALENext -warning
  <Plug>(ale_next_wrap_warning) - ALENext -wrap -warning
  <Plug>(ale_first) - ALEFirst
  <Plug>(ale_last) - ALELast
<
  For example, these commands could be bound to the keys Ctrl + j
  and Ctrl + k: >

  " Map movement through errors without wrapping.
  nmap <silent> <C-k> <Plug>(ale_previous)
  nmap <silent> <C-j> <Plug>(ale_next)
  " OR map keys to use wrapping.
  nmap <silent> <C-k> <Plug>(ale_previous_wrap)
  nmap <silent> <C-j> <Plug>(ale_next_wrap)
<

ALEToggle                                                           *ALEToggle*
ALEEnable                                                           *ALEEnable*
ALEDisable                                                         *ALEDisable*
ALEToggleBuffer                                               *ALEToggleBuffer*
ALEEnableBuffer                                               *ALEEnableBuffer*
ALEDisableBuffer                                             *ALEDisableBuffer*

  `ALEToggle`, `ALEEnable`, and `ALEDisable` enable or disable ALE linting,
  including all of its autocmd events, loclist items, quickfix items, signs,
  current jobs, etc., globally. Executing any of these commands will change
  the |g:ale_enabled| variable.

  ALE can be disabled or enabled for only a single buffer with
  `ALEToggleBuffer`, `ALEEnableBuffer`, and `ALEDisableBuffer`. Disabling ALE
  for a buffer will not remove autocmd events, but will prevent ALE from
  checking for problems and reporting problems for whatever buffer the
  `ALEDisableBuffer` or `ALEToggleBuffer` command is executed from. These
  commands can be used for temporarily disabling ALE for a buffer. These
  commands will modify the |b:ale_enabled| variable.

  ALE linting cannot be enabled for a single buffer when it is disabled
  globally, as disabling ALE globally removes the autocmd events needed to
  perform linting with.

  The following plug mappings are defined, for conveniently defining keybinds:

  |ALEToggle|        - `<Plug>(ale_toggle)`
  |ALEEnable|        - `<Plug>(ale_enable)`
  |ALEDisable|       - `<Plug>(ale_disable)`
  |ALEToggleBuffer|  - `<Plug>(ale_toggle_buffer)`
  |ALEEnableBuffer|  - `<Plug>(ale_enable_buffer)`
  |ALEDisableBuffer| - `<Plug>(ale_disable_buffer)`

  For removing problems reported by ALE, but leaving ALE enabled, see
  |ALEReset| and |ALEResetBuffer|.

                                                                   *:ALEDetail*
ALEDetail                                                           *ALEDetail*

  Show the full linter message for the problem nearest to the cursor on the
  given line in the preview window. The preview window can be easily closed
  with the `q` key. If there is no message to show, the window will not be
  opened.

  If a loclist item has a `detail` key set, the message for that key will be
  preferred over `text`. See |ale-loclist-format|.

  A plug mapping `<Plug>(ale_detail)` is defined for this command.


                                                                     *:ALEInfo*
ALEInfo                                                               *ALEInfo*
ALEInfoToClipboard                                         *ALEInfoToClipboard*

  Print runtime information about ALE, including the values of global and
  buffer-local settings for ALE, the linters that are enabled, the commands
  that have been run, and the output of commands.

  ALE will log the commands that are run by default. If you wish to disable
  this, set |g:ale_history_enabled| to `0`. Because it could be expensive, ALE
  does not remember the output of recent commands by default. Set
  |g:ale_history_log_output| to `1` to enable logging of output for commands.
  ALE will only log the output captured for parsing problems, etc.

  The command `:ALEInfoToClipboard` can be used to output ALEInfo directly to
  your clipboard. This might not work on every machine.

  `:ALEInfoToFile` will write the ALE runtime information to a given filename.
  The filename works just like |:w|.


ALEReset                                                             *ALEReset*
ALEResetBuffer                                                 *ALEResetBuffer*

  `ALEReset` will remove all problems reported by ALE for all buffers.
  `ALEResetBuffer` will remove all problems reported for a single buffer.

  Either command will leave ALE linting enabled, so ALE will report problems
  when linting is performed again. See |ale-lint| for more information.

  The following plug mappings are defined, for conveniently defining keybinds:

  |ALEReset|       - `<Plug>(ale_reset)`
  |ALEResetBuffer| - `<Plug>(ale_reset_buffer)`

  ALE can be disabled globally or for a buffer with |ALEDisable| or
  |ALEDisableBuffer|.


ALEStopAllLSPs                                                 *ALEStopAllLSPs*

  `ALEStopAllLSPs` will close and stop all channels and jobs for all LSP-like
  clients, including tsserver, remove all of the data stored for them, and
  delete all of the problems found for them, updating every linted buffer.

  This command can be used when LSP clients mess up and need to be restarted.


===============================================================================
9. API                                                                *ale-api*

ALE offers a number of functions for running linters or fixers, or defining
them. The following functions are part of the publicly documented part of that
API, and should be expected to continue to work.


ale#Env(variable_name, value)                                       *ale#Env()*

  Given a variable name and a string value, produce a string for including in
  a command for setting environment variables. This function can be used for
  building a command like so. >

    :echo string(ale#Env('VAR', 'some value') . 'command')
    'VAR=''some value'' command'      # On Linux or Mac OSX
    'set VAR="some value" && command' # On Windows


ale#GetFilenameMappings(buffer, name)               *ale#GetFilenameMappings()*

  Given a `buffer` and the `name` of either a linter for fixer, return a
  |List| of two-item |List|s that describe mapping to and from the local and
  foreign file systems for running a particular linter or fixer.

  See |g:ale_filename_mappings| for details on filename mapping.


ale#Has(feature)                                                    *ale#Has()*

  Return `1` if ALE supports a given feature, like |has()| for Vim features.

  ALE versions can be checked with version strings in the format
  `ale#Has('ale-x.y.z')`, such as `ale#Has('ale-2.4.0')`.


ale#Pad(string)                                                     *ale#Pad()*

  Given a string or any |empty()| value, return either the string prefixed
  with a single space, or an empty string. This function can be used to build
  parts of a command from variables.


ale#Queue(delay, [linting_flag, buffer_number])                   *ale#Queue()*

  Run linters for the current buffer, based on the filetype of the buffer,
  with a given `delay`. A `delay` of `0` will run the linters immediately.
  The linters will always be run in the background. Calling this function
  again from the same buffer

  An optional `linting_flag` argument can be given. If `linting_flag` is
  `'lint_file'`, then linters where the `lint_file` option evaluates to `1`
  will be run. Otherwise, those linters will not be run.

  An optional `buffer_number` argument can be given for specifying the buffer
  to check. The active buffer (`bufnr('')`) will be checked by default.

                                                                *ale-cool-down*
  If an exception is thrown when queuing/running ALE linters, ALE will enter
  a cool down period where it will stop checking anything for a short period
  of time. This is to prevent ALE from seriously annoying users if a linter
  is broken, or when developing ALE itself.


ale#command#CreateDirectory(buffer)             *ale#command#CreateDirectory()*

  Create a new temporary directory with a unique name, and manage that
  directory with |ale#command#ManageDirectory()|, so it will be removed as soon
  as possible.

  It is advised to only call this function from a callback function for
  returning a linter command to run.


ale#command#CreateFile(buffer)                       *ale#command#CreateFile()*

  Create a new temporary file with a unique name, and manage that file with
  |ale#command#ManageFile()|, so it will be removed as soon as possible.

  It is advised to only call this function from a callback function for
  returning a linter command to run.


ale#command#Run(buffer, command, callback, [options])       *ale#command#Run()*

  Start running a job in the background, and pass the results to the given
  callback later.

  This function can be used for computing the results of ALE linter or fixer
  functions asynchronously with jobs. `buffer` must match the buffer being
  linted or fixed, `command` must be a |String| for a shell command to
  execute, `callback` must be defined as a |Funcref| to call later with the
  results, and an optional |Dictionary| of `options` can be provided.

  The `callback` will receive the arguments `(buffer, output, metadata)`,
  where the `buffer` will match the buffer given to the function, the `output`
  will be a `List` of lines of output from the job that was run, and the
  `metadata` will be a |Dictionary| with additional information about the job
  that was run, including:

    `exit_code` - A |Number| with the exit code for the program that was run.

  The result of this function is either a special |Dictionary| ALE will use
  for waiting for the command to finish, or `0` if the job is not started. The
  The return value of the `callback` will be used as the eventual result for
  whatever value is being given to ALE. For example: >

    function! s:GetCommand(buffer, output, meta) abort
        " Do something with a:output here, from the foo command.

        " This is used as the command to run for linting.
        return 'final command'
    endfunction

    " ...

    'command': {b -> ale#command#Run(b, 'foo', function('s:GetCommand'))}
<
  The result of a callback can also be the result of another call to this
  function, so that several commands can be arbitrarily chained together. For
  example: >

    function! s:GetAnotherCommand(buffer, output, meta) abort
        " We can finally return this command.
        return 'last command'
    endfunction

    function! s:GetCommand(buffer, output, meta) abort
        " We can return another deferred result.
        return ale#command#Run(
        \   a:buffer,
        \   'second command',
        \   function('s:GetAnotherCommand')
        \)
    endfunction

    " ...

    'command': {b -> ale#command#Run(b, 'foo', function('s:GetCommand'))}
<
  The following `options` can be provided.

    `cwd`               - An optional |String| for setting the working directory
                        for the command, just as per |ale#linter#Define|.

                        If not set, or `v:null`, the `cwd` of the last command
                        that spawned this one will be used.

    `output_stream`     - Either `'stdout'`, `'stderr'`, `'both'`, or
                        `'none`' for selecting which output streams to read
                        lines from.

                        The default is `'stdout'`

    `executable`        - An executable for formatting into `%e` in the
                        command. If this option is not provided, formatting
                        commands with `%e` will not work.

    `read_buffer`       - If set to `1`, the buffer will be piped into the
                        command.

                        The default is `0`.

    `input`             - When creating temporary files with `%t` or piping
                        text into a command `input` can be set to a |List| of
                        text to use instead of the buffer's text.

    `filename_mappings` - A |List| of two-item |List|s describing filename
                        mappings to apply for formatted filenames in the
                        command string, as per |g:ale_filename_mappings|.

                        If the call to this function is being used for a
                        linter or fixer, the mappings should be provided with
                        this option, and can be retrieved easily with
                        |ale#GetFilenameMappings()|.

                        The default is `[]`.



ale#command#EscapeCommandPart(command_part)   *ale#command#EscapeCommandPart()*

  Given a |String|, return a |String| with all `%` characters replaced with
  `%%` instead. This function can be used to escape strings which are
  dynamically generated for commands before handing them over to ALE,
  so that ALE doesn't treat any strings with `%` formatting sequences
  specially.


ale#command#ManageDirectory(buffer, directory)  *ale#command#ManageDirectory()*

  Like |ale#command#ManageFile()|, but directories and all of their contents
  will be deleted, akin to `rm -rf directory`, which could lead to loss of
  data if mistakes are made. This command will also delete any temporary
  filenames given to it.

  It is advised to use |ale#command#ManageFile()| instead for deleting single
  files.


ale#command#ManageFile(buffer, filename)             *ale#command#ManageFile()*

  Given a buffer number for a buffer currently running some linting or fixing
  tasks and a filename, register a filename with ALE for automatic deletion
  after linting or fixing is complete, or when Vim exits.

  If Vim exits suddenly, ALE will try its best to remove temporary files, but
  ALE cannot guarantee with absolute certainty that the files will be removed.
  It is advised to create temporary files in the operating system's managed
  temporary file directory, such as with |tempname()|.

  Directory names should not be given to this function. ALE will only delete
  files and symlinks given to this function. This is to prevent entire
  directories from being accidentally deleted, say in cases of writing
  `dir . '/' . filename` where `filename` is actually `''`, etc. ALE instead
  manages directories separately with the |ale#command#ManageDirectory| function.


ale#completion#OmniFunc(findstart, base)            *ale#completion#OmniFunc()*

  A completion function to use with 'omnifunc'.

  See |ale-completion|.


ale#engine#GetLoclist(buffer)                         *ale#engine#GetLoclist()*

  Given a buffer number, this function will return the list of problems
  reported by ALE for a given buffer in the format accepted by |setqflist()|.

  A reference to the buffer's list of problems will be returned. The list must
  be copied before applying |map()| or |filter()|.


ale#engine#IsCheckingBuffer(buffer)             *ale#engine#IsCheckingBuffer()*

  Given a buffer number, returns `1` when ALE is busy checking that buffer.

  This function can be used for status lines, tab names, etc.


ale#fix#registry#Add(name, func, filetypes, desc, [aliases])
                                                       *ale#fix#registry#Add()*

  Given a |String| `name` for a name to add to the registry, a |String| `func`
  for a function name, a |List| `filetypes` for a list of filetypes to
  set for suggestions, and a |String| `desc` for a short description of
  the fixer, register a fixer in the registry.

  The `name` can then be used for |g:ale_fixers| in place of the function
  name, and suggested for fixing files.

  An optional |List| of |String|s for aliases can be passed as the `aliases`
  argument. These aliases can also be used for looking up a fixer function.
  ALE will search for fixers in the registry first by `name`, then by their
  `aliases`.

  For example to register a custom fixer for `luafmt`: >

  function! FormatLua(buffer) abort
    return {
    \   'command': 'luafmt --stdin'
    \}
  endfunction

  execute ale#fix#registry#Add('luafmt', 'FormatLua', ['lua'], 'luafmt for lua')

  " You can now use it in g:ale_fixers
  let g:ale_fixers = {
    \ 'lua': ['luafmt']
  }
<

ale#linter#Define(filetype, linter)                       *ale#linter#Define()*

  Given a |String| for a filetype and a |Dictionary| Describing a linter
  configuration, add a linter for the given filetype. The dictionaries each
  offer the following options:

  `name`                   The name of the linter. These names will be used by
                         |g:ale_linters| option for enabling/disabling
                         particular linters.

                         This argument is required.

  `callback`               A |String| or |Funcref| for a callback function
                         accepting two arguments (buffer, lines), for a
                         buffer number the output is for, and the lines of
                         output from a linter.

                         This callback function should return a |List| of
                         |Dictionary| objects in the format accepted by
                         |setqflist()|. The |List| will be sorted by line and
                         then column order so it can be searched with a binary
                         search by in future before being passed on to the
                         |loclist|, etc.

                         This argument is required, unless the linter is an
                         LSP linter. In which case, this argument must not be
                         defined, as LSP linters handle diagnostics
                         automatically. See |ale-lsp-linters|.

                         If the function named does not exist, including if
                         the function is later deleted, ALE will behave as if
                         the callback returned an empty list.

                         The keys for each item in the List will be handled in
                         the following manner:
                                                           *ale-loclist-format*
                         `text` - This error message is required.
                         `detail` - An optional, more descriptive message.
                           This message can be displayed with the |ALEDetail|
                           command instead of the message for `text`, if set.
                         `lnum` - The line number is required. Any strings
                           will be automatically converted to numbers by
                           using `str2nr()`.

                           Line 0 will be moved to line 1, and lines beyond
                           the end of the file will be moved to the end.
                         `col` - The column number is optional and will
                           default to `0`. Any strings will be automatically
                           converted to number using `str2nr()`.
                         `end_col` - An optional end column number.
                           This key can be set to specify the column problems
                           end on, for improved highlighting.
                         `end_lnum` - An optional end line number.
                           This key can set along with `end_col` for
                           highlighting multi-line problems.
                         `bufnr` - This key represents the buffer number the
                           problems are for. This value will default to
                           the buffer number being checked.

                           The `filename` key can be set instead of this key,
                           and then the eventual `bufnr` value in the final
                           list will either represent the number for an open
                           buffer or `-1` for a file not open in any buffer.
                         `filename` - An optional filename for the file the
                           problems are for. This should be an absolute path to
                           a file.

                           Problems for files which have not yet been opened
                           will be set in those files after they are opened
                           and have been checked at least once.

                           Temporary files in directories used for Vim
                           temporary files with `tempname()` will be assumed
                           to be the buffer being checked, unless the `bufnr`
                           key is also set with a valid number for some other
                           buffer.
                         `vcol` - Defaults to `0`.

                           If set to `1`, ALE will convert virtual column
                           positions for `col` and `end_col` to byte column
                           positions. If the buffer is changed in-between
                           checking it and displaying the results, the
                           calculated byte column positions will probably be
                           wrong.
                         `type` - Defaults to `'E'`.
                         `nr` - Defaults to `-1`.

                           Numeric error code. If `nr` is not `-1`, `code`
                           likely should contain the string representation of
                           the same value.
                         `code` - No default; may be unset.

                           Human-readable |String| error code.

  `executable`             A |String| naming the executable itself which
                         will be run, or a |Funcref| for a function to call
                         for computing the executable, accepting a buffer
                         number.

                         The result can be computed with |ale#command#Run()|.

                         This value will be used to check if the program
                         requested is installed or not.

                         If an `executable` is not defined, the command will
                         be run without checking if a program is executable
                         first. Defining an executable path is recommended to
                         avoid starting too many processes.

  `command`                A |String| for a command to run asynchronously, or a
                         |Funcref| for a function to call for computing the
                         command, accepting a buffer number.

                         The result can be computed with |ale#command#Run()|.

                         The command string can be formatted with format
                         markers. See |ale-command-format-strings|.

                         This command will be fed the lines from the buffer to
                         check, and will produce the lines of output given to
                         the `callback`.

  `cwd`                    An optional |String| for setting the working
                         directory for the command, or a |Funcref| for a
                         function to call for computing the command, accepting
                         a buffer number. The working directory can be
                         specified as a format string for determining the path
                         dynamically. See |ale-command-format-strings|.

                         To set the working directory to the directory
                         containing the file you're checking, you should
                         probably use `'%s:h'` as the option value.

                         If this option is absent or the string is empty, the
                         `command` will be run with no determined working
                         directory in particular.

                         The directory specified with this option will be used
                         as the default working directory for all commands run
                         in a chain with |ale#command#Run()|, unless otherwise
                         specified.

  `output_stream`          A |String| for the output stream the lines of output
                         should be read from for the command which is run. The
                         accepted values are `'stdout'`, `'stderr'`, and
                         `'both'`. This argument defaults to `'stdout'`. This
                         argument can be set for linter programs which output
                         their errors and warnings to the stderr stream
                         instead of stdout. The option `'both'` will read
                         from both stder and stdout at the same time.

  `read_buffer`            A |Number| (`0` or `1`) indicating whether a command
                         should read the Vim buffer as input via stdin. This
                         option is set to `1` by default, and can be disabled
                         if a command manually reads from a temporary file
                         instead, etc.

                         This option behaves as if it was set to `0` when the
                         `lint_file` option evaluates to `1`.

                                                                *ale-lint-file*
  `lint_file`              A |Number| (`0` or `1`), or a |Funcref| for a function
                         accepting a buffer number for computing either `0` or
                         `1`, indicating whether a command should read the file
                         instead of the Vim buffer. This option can be used
                         for linters which must check the file on disk, and
                         which cannot check a Vim buffer instead.

                         The result can be computed with |ale#command#Run()|.

                         Linters where the eventual value of this option
                         evaluates to `1` will not be run as a user types, per
                         |g:ale_lint_on_text_changed|. Linters will instead be
                         run only when events occur against the file on disk,
                         including |g:ale_lint_on_enter| and
                         |g:ale_lint_on_save|. Linters where this option
                         evaluates to `1` will also be run when the |ALELint|
                         command is run.

                         When this option is evaluates to `1`, ALE will behave
                         as if `read_buffer` was set to `0`.

                                                              *ale-lsp-linters*
  `lsp`                    A |String| for defining LSP (Language Server Protocol)
                         linters.

                         This argument may be omitted or `''` when a linter
                         does not represent an LSP linter.

                         When this argument is set to `'stdio'`, then the
                         linter will be defined as an LSP linter which keeps a
                         process for a language server running, and
                         communicates with it directly via a |channel|.
                         `executable` and `command` must be set.

                         When this argument is set to `'socket'`, then the
                         linter will be defined as an LSP linter via a TCP
                         or named pipe socket connection. `address` must be set.

                         ALE will not start a server automatically.

                         When this argument is not empty `project_root` must
                         be defined.

                         `language` can be defined to describe the language
                         for a file. The filetype will be used as the language
                         by default.

                         LSP linters handle diagnostics automatically, so
                         the `callback` argument must not be defined.

                         An optional `completion_filter` callback may be
                         defined for filtering completion results.

                         `initialization_options` may be defined to pass
                         initialization options to the LSP.

                         `lsp_config` may be defined to pass configuration
                         settings to the LSP.

  `address`                A |String| representing an address to connect to,
                         or a |Funcref| accepting a buffer number and
                         returning the |String|. If the value contains a
                         colon, it is interpreted as referring to a TCP
                         socket; otherwise it is interpreted as the path of a
                         named pipe.

                         The result can be computed with |ale#command#Run()|.

                         This argument must only be set if the `lsp` argument
                         is set to `'socket'`.

  `project_root`           A |String| representing a path to the project for
                         the file being checked with the language server, or
                         a |Funcref| accepting a buffer number and returning
                         the |String|.

                         If an empty string is returned, the file will not be
                         checked at all.

                         This argument must only be set if the `lsp` argument
                         is also set to a non-empty string.

  `language`               A |String| representing the name of the language
                         being checked, or a |Funcref| accepting a buffer
                         number and returning the |String|. This string will
                         be sent to the LSP to tell it what type of language
                         is being checked.

                         If a language isn't provided, the language will
                         default to the value of the filetype given to
                         |ale#linter#Define|.

  `completion_filter`      A |String| or |Funcref| for a callback function
                         accepting a buffer number and a completion item.

                         The completion item will be a |Dictionary| following
                         the Language Server Protocol `CompletionItem`
                         interface as described in the specification,
                         available online here:
                         https://microsoft.github.io/language-server-protocol

  `aliases`                A |List| of aliases for the linter name.

                         This argument can be set with alternative names for
                         selecting the linter with |g:ale_linters|. This
                         setting can make it easier to guess the linter name
                         by offering a few alternatives.

  `initialization_options` A |Dictionary| of initialization options for LSPs,
                         or a |Funcref| for a callback function accepting
                         a buffer number and returning the |Dictionary|.

                         This will be fed (as JSON) to the LSP in the
                         initialize command.

  `lsp_config`             A |Dictionary| for configuring a language server,
                         or a |Funcref| for a callback function accepting
                         a buffer number and returning the |Dictionary|.

                         This will be fed (as JSON) to the LSP in the
                         workspace/didChangeConfiguration command.

  If temporary files or directories are created for commands run with
  `command`, then these temporary files or directories can be managed by ALE,
  for automatic deletion. See |ale#command#ManageFile()| and
  |ale#command#ManageDirectory| for more information.

                                                   *ale-command-format-strings*

  All command strings will be formatted for special character sequences.
  Any substring `%s` will be replaced with the full path to the current file
  being edited. This format option can be used to pass the exact filename
  being edited to a program.

  For example: >
  'command': 'eslint -f unix --stdin --stdin-filename %s'
<
  Any substring `%t` will be replaced with a path to a temporary file. Merely
  adding `%t` will cause ALE to create a temporary file containing the
  contents of the buffer being checked. All occurrences of `%t` in command
  strings will reference the one temporary file. The temporary file will be
  created inside a temporary directory, and the entire temporary directory
  will be automatically deleted, following the behavior of
  |ale#command#ManageDirectory|. This option can be used for some linters which
  do not support reading from stdin.

  For example: >
  'command': 'ghc -fno-code -v0 %t',
<
  Any substring `%e` will be replaced with the escaped executable supplied
  with `executable`. This provides a convenient way to define a command string
  which needs to include a dynamic executable name, but which is otherwise
  static.

  For example: >
  'command': '%e --some-argument',
<
  The character sequence `%%` can be used to emit a literal `%` into a
  command, so literal character sequences `%s` and `%t` can be escaped by
  using `%%s` and `%%t` instead, etc.

  Some |filename-modifiers| can be applied to `%s` and `%t`. Only `:h`, `:t`,
  `:r`, and `:e` may be applied, other modifiers will be ignored. Filename
  modifiers can be applied to the format markers by placing them after them.

  For example: >
  'command': '%s:h %s:e %s:h:t',
<
  Given a path `/foo/baz/bar.txt`, the above command string will generate
  something akin to `'/foo/baz' 'txt' 'baz'`

  If a callback for a command generates part of a command string which might
  possibly contain `%%`, `%s`, `%t`, or `%e`, where the special formatting
  behavior is not desired, the |ale#command#EscapeCommandPart()| function can
  be used to replace those characters to avoid formatting issues.

                                                  *ale-linter-loading-behavior*

  Linters for ALE will be loaded by searching |runtimepath| in the following
  format: >

  ale_linters/<filetype>/<linter_name>.vim
<
  Any linters which exist anywhere in |runtimepath| with that directory
  structure will be automatically loaded for the matching |filetype|. Filetypes
  containing `.` characters will be split into individual parts, and files
  will be loaded for each filetype between the `.` characters.

  Linters can be defined from vimrc and other files as long as this function
  is loaded first. For example, the following code will define a Hello World
  linter in vimrc in Vim 8: >

  " Plugins have to be loaded first.
  " If you are using a plugin manager, run that first.
  packloadall

  call ale#linter#Define('vim', {
  \   'name': 'echo-test',
  \   'executable': 'echo',
  \   'command': 'echo hello world',
  \   'callback': {buffer, lines -> map(lines, '{"text": v:val, "lnum": 1}')},
  \})
<

ale#linter#Get(filetype)                                     *ale#linter#Get()*

  Return all of linters configured for a given filetype as a |List| of
  |Dictionary| values in the format specified by |ale#linter#Define()|.

  Filetypes may be dot-separated to invoke linters for multiple filetypes:
  for instance, the filetype `javascript.jsx` will return linters for both the
  `javascript` and `jsx` filetype.

  Aliases may be defined in as described in |g:ale_linter_aliases|. Aliases
  are applied after dot-separated filetypes are broken up into their
  components.


ale#linter#PreventLoading(filetype)               *ale#linter#PreventLoading()*

  Given a `filetype`, prevent any more linters from being loaded from
  |runtimepath| for that filetype. This function can be called from vimrc or
  similar to prevent ALE from loading linters.


ale#lsp_linter#SendRequest(buffer, linter_name, message, [Handler])
                                                 *ale#lsp_linter#SendRequest()*

  Send a custom request to an LSP linter. The arguments are defined as
  follows:

  `buffer`       A valid buffer number.

  `linter_name`  A |String| identifying an LSP linter that is available and
                 enabled for the |filetype| of `buffer`.

  `message`      A |List| in the form `[is_notification, method, parameters]`,
                 containing three elements:
                 `is_notification` - an |Integer| that has value 1 if the
                   request is a notification, 0 otherwise;
                 `method` - a |String|, identifying an LSP method supported
                   by `linter`;
                 `parameters` - a |dictionary| of LSP parameters that are
                   applicable to `method`.

  `Handler`      Optional argument, meaningful only when `message[0]` is 0.
                 A |Funcref| that is called when a response to the request is
                 received, and takes as unique argument a dictionary
                 representing the response obtained from the server.


ale#other_source#ShowResults(buffer, linter_name, loclist)
                                               *ale#other_source#ShowResults()*

  Show results from another source of information.

  `buffer` must be a valid buffer number, and `linter_name` must be a unique
  name for identifying another source of information. The `loclist` given
  where the problems in a buffer are, and should be provided in the format ALE
  uses for regular linter results. See |ale-loclist-format|.


ale#other_source#StartChecking(buffer, linter_name)
                                             *ale#other_source#StartChecking()*

  Tell ALE that another source of information has started checking a buffer.

  `buffer` must be a valid buffer number, and `linter_name` must be a unique
  name for identifying another source of information.


ale#statusline#Count(buffer)                           *ale#statusline#Count()*

  Given the number of a buffer which may have problems, return a |Dictionary|
  containing information about the number of problems detected by ALE. The
  following keys are supported:

  `error`         -> The number of problems with type `E` and `sub_type != 'style'`
  `warning`       -> The number of problems with type `W` and `sub_type != 'style'`
  `info`          -> The number of problems with type `I`
  `style_error`   -> The number of problems with type `E` and `sub_type == 'style'`
  `style_warning` -> The number of problems with type `W` and `sub_type == 'style'`
  `total`         -> The total number of problems.


ale#statusline#FirstProblem(buffer, type)       *ale#statusline#FirstProblem()*

  Returns a copy of the first entry in the `loclist` that matches the supplied
  buffer number and problem type. If there is no such entry, an empty dictionary
  is returned.
  Problem type should be one of the strings listed below:

  `error`         -> Returns the first `loclist` item with type `E` and
                     `sub_type != 'style'`
  `warning`       -> First item with type `W` and `sub_type != 'style'`
  `info`          -> First item with type `I`
  `style_error`   -> First item with type `E` and `sub_type == 'style'`
  `style_warning` -> First item with type `W` and `sub_type == 'style'`


b:ale_linted                                                     *b:ale_linted*

  `b:ale_linted` is set to the number of times a buffer has been checked by
  ALE after all linters for one lint cycle have finished checking a buffer.
  This variable may not be defined until ALE first checks a buffer, so it
  should be accessed with |get()| or |getbufvar()|. For example: >

    " Print a message indicating how many times ALE has checked this buffer.
    echo 'ALE has checked this buffer ' . get(b:, 'ale_linted') . ' time(s).'
    " Print 'checked' using getbufvar() if a buffer has been checked.
    echo getbufvar(bufnr(''), 'ale_linted', 0) > 0 ? 'checked' : 'not checked'
<

g:ale_want_results_buffer                           *g:ale_want_results_buffer*

  `g:ale_want_results_buffer` is set to the number of the buffer being checked
  when the |ALEWantResults| event is signaled. This variable should be read to
  figure out which buffer other sources should lint.


ALECompletePost                                       *ALECompletePost-autocmd*
                                                              *ALECompletePost*

  This |User| autocmd is triggered after ALE inserts an item on
  |CompleteDone|. This event can be used to run commands after a buffer
  is changed by ALE as the result of completion. For example, |ALEFix| can
  be configured to run automatically when completion is done: >

  augroup FixAfterComplete
      autocmd!
      " Run ALEFix when completion items are added.
      autocmd User ALECompletePost ALEFix!
      " If ALE starts fixing a file, stop linters running for now.
      autocmd User ALEFixPre ALELintStop
  augroup END
<

ALELintPre                                                 *ALELintPre-autocmd*
                                                                   *ALELintPre*
ALELintPost                                               *ALELintPost-autocmd*
                                                                  *ALELintPost*
ALEFixPre                                                   *ALEFixPre-autocmd*
                                                                    *ALEFixPre*
ALEFixPost                                                 *ALEFixPost-autocmd*
                                                                   *ALEFixPost*

  These |User| autocommands are triggered before and after every lint or fix
  cycle. They can be used to update statuslines, send notifications, etc.
  The autocmd commands are run with |:silent|, so |:unsilent| is required for
  echoing messges.

  For example to change the color of the statusline while the linter is
  running:
>
    augroup ALEProgress
        autocmd!
        autocmd User ALELintPre  hi Statusline ctermfg=darkgrey
        autocmd User ALELintPost hi Statusline ctermfg=NONE
    augroup END
<
  Or to display the progress in the statusline:
>
    let s:ale_running = 0
    let l:stl .= '%{s:ale_running ? "[linting]" : ""}'
    augroup ALEProgress
        autocmd!
        autocmd User ALELintPre  let s:ale_running = 1 | redrawstatus
        autocmd User ALELintPost let s:ale_running = 0 | redrawstatus
    augroup END

<
ALEJobStarted                                           *ALEJobStarted-autocmd*
                                                                *ALEJobStarted*

  This |User| autocommand is triggered immediately after a job is successfully
  run. This provides better accuracy for checking linter status with
  |ale#engine#IsCheckingBuffer()| over |ALELintPre-autocmd|, which is actually
  triggered before any linters are executed.

ALELSPStarted                                           *ALELSPStarted-autocmd*
                                                                *ALELSPStarted*

  This |User| autocommand is trigged immediately after an LSP connection is
  successfully initialized. This provides a way to perform any additional
  initialization work, such as setting up buffer-level mappings.


ALEWantResults                                         *ALEWantResults-autocmd*
                                                               *ALEWantResults*

  This |User| autocommand is triggered before ALE begins a lint cycle. Another
  source can respond by calling |ale#other_source#StartChecking()|, and
  |ALELintPre| will be signaled thereafter, to allow other plugins to know
  that another source is checking the buffer.

  |g:ale_want_results_buffer| will be set to the number for a buffer being
  checked when the event is signaled, and deleted after the event is done.
  This variable should be read to know which buffer to check.

  Other plugins can use this event to start checking buffers when ALE events
  for checking buffers are triggered.


===============================================================================
10. Special Thanks                                         *ale-special-thanks*

Special thanks to Mark Grealish (https://www.bhalash.com/) for providing ALE's
snazzy looking ale glass logo. Cheers, Mark!

===============================================================================
11. Contact                                                       *ale-contact*

If you like this plugin, and wish to get in touch, check out the GitHub
page for issues and more at https://github.com/dense-analysis/ale

If you wish to contact the author of this plugin directly, please feel
free to send an email to devw0rp@gmail.com.

Please drink responsibly, or not at all, which is ironically the preference
of w0rp, who is teetotal.

===============================================================================
  vim:tw=78:ts=2:sts=2:sw=2:ft=help:norl: