;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     asm
     (auto-completion :variables
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-enable-snippets-in-popup t)
     better-defaults
     (c-c++ :variables
            c-c++-enable-clang-support t
            c-c++-default-mode-for-headers 'c++-mode)
     ;; colors
     csharp
     csv
     docker
     emacs-lisp
     emoji
     (erc :variables
          erc-server-list
          '(("yashsriv.org"
             :port "6667"
             :ssl t
             :nick "yashsriv")))
     ess
     games
     (go :variables
         gofmt-command "goimports"
         go-use-gometalinter t
         go-tab-width 4)
     git
     graphviz
     (haskell :variables haskell-completion-backend 'intero)
     helm
     html
     java
     javascript
     latex
     major-modes
     markdown
     neotree
     nginx
     octave
     org
     php
     protobuf
     python
     ruby
     rust
     (scala :variables
            scala-indent:use-javadoc-style t
            scala-enable-eldoc t
            scala-auto-insert-asterisk-in-comments t
            scala-use-unicode-arrows t)
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-shell 'multi-term
            shell-default-term-shell "/bin/bash")
     shell-scripts
     spacemacs-evil
     spotify
     (spell-checking :variables
                     spell-checking-enable-by-default nil
                     enable-flyspell-auto-completion t)
     sql
     syntax-checking
     (typescript :variables
                 tide-tsserver-executable "/usr/bin/tsserver")
     version-control
     xkcd
     yaml
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(editorconfig all-the-icons dtrt-indent '(ebnf-mode :location "~/.emacs.d/private/local/ebnf-mode.el"))

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 10

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'hybrid
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `vim-powerline' and `vanilla'. The first three
   ;; are spaceline themes. `vanilla' is default Emacs mode-line. `custom' is a
   ;; user defined themes, refer to the DOCUMENTATION.org for more info on how
   ;; to create your own spaceline theme. Value can be a symbol or list with\
   ;; additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(all-the-icons :separator arrow :separator-scale 1.7)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 20
                               :weight semi-bold
                               :width normal
                               :powerline-scale 1.0)
   ;; The leader key
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; If non-nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil

   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t

   ;; If non-nil, `J' and `K' move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil

   ;; If non-nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil

   ;; if non-nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil

   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom

   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always

   ;; If non-nil, the paste transient-state is enabled. While enabled, pressing
   ;; `p' several times cycles through the elements in the `kill-ring'.
   ;; (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers 'relative
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   dotspacemacs-enable-server t

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server t
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded.  If you are unsure, you should try in setting them
in `dotspacemacs/user-config' first."
  (push '("melpa-stable" . "stable.melpa.org/packages/") configuration-layer-elpa-archives)
  (push '(ensime . "melpa-stable") package-pinned-packages)
  (with-eval-after-load 'org
    ;; here goes your Org config :)
    ;; ....
    ;; active Babel languages
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((gnuplot . t)))
    (plist-put org-format-latex-options :scale 1.5)
    )
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done.
Unless it is explicitly specified that a variable should be set
before a package is loaded, you should place your code here."
  (setq powerline-default-separator 'arrow-fade)

  (spacemacs/set-leader-keys "wd" 'evil-quit)
  (spacemacs/set-leader-keys-for-major-mode 'erc-mode "b" 'erc-switch-to-buffer)
  (define-key evil-normal-state-map (kbd ";") 'evil-ex)
  (define-key evil-visual-state-map (kbd ";") 'evil-ex)

  (setq-default company-show-numbers t)
  (evil-initial-state 'term-mode 'emacs)

  (defun flycheck-mode-hook ()
    (flycheck-mode 1)
    (flyspell-mode -1))

  (defun cpp-hooks ()
    (setq flycheck-gcc-language-standard "c++11"))

  (golden-ratio-mode)

  (setq-default flycheck-scalastylerc "/home/yash/bin/scalastyle_config.xml")

  (setq-default js2-basic-offset 2)
  (setq-default js-indent-level 2)
  (setq-default web-mode-code-indent-offset 2 web-mode-indent-style 2 web-mode-markup-indent-offset 2)
  (setq-default css-indent-offset 2)

  (setq-default typescript-indent-level 2)
  (setq tide-format-options '(:indentSize 2))

  (setq split-height-threshold nil)
  (setq split-width-threshold 0)

  (setq magit-repository-directories '("~/git/", "~/dotfiles/"))

  (add-hook 'doc-view-mode-hook 'auto-revert-mode)
  ;; (add-hook 'prog-mode-hook 'flycheck-mode-hook)
  (add-hook 'prog-mode-hook #'(lambda ()
                                (flycheck-mode-hook)
                                (dtrt-indent-mode)
                                (dtrt-indent-adapt)))


  ; Disable clang check, gcc check works better
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(c/c++-clang haskell-stack-ghc)))

  ; Enable C++11 support for gcc
  (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))


  (setq spaceline-org-clock-p t)

  (setq browse-url-generic-program "vivaldi-stable"
        browse-url-browser-function 'browse-url-generic)

  (set-fontset-font "fontset-default" 'unicode "Noto Emoji")

  (setq neo-theme (if (display-graphic-p) 'nerd 'icons))

  (global-evil-mc-mode)
  (save-place-mode 1)
  (setq save-place-file (locate-user-emacs-file "places" "~/.emacs.d/private/.emacs-places"))

  (setenv "GOPATH" "/home/yash/git/go")

  (setq flycheck-gometalinter-vendor t)
  ;; only run fast linters
  (setq flycheck-gometalinter-fast t)
  ;; disable gotype for the issues it causes
  ;; (setq flycheck-gometalinter-disable-linters '("gotype" "gotypex"))

  (setq flycheck-ghc-search-path '("lib"))

  (setq flycheck-gcc-include-path '("/usr/lib/dbus-1.0/include" "/usr/include/dbus-1.0" "/usr/include/dbus-c++-1" "/usr/include/glib-2.0" "/usr/lib/glib-2.0/include" "/usr/include/gio-unix-2.0"))

  ;; (spacemacs/toggle-transparency)

  (setq TeX-view-program-list
        '(("zathura"
           ("zathura" (mode-io-correlate "-sync.sh")
            " "
            (mode-io-correlate "%n:1:%b ")
            "%o"))))

  (setq erc-hide-list '("JOIN" "PART" "QUIT"))

  )

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   (quote
    (vala-snippets vala-mode thrift stan-mode scad-mode qml-mode pkgbuild-mode matlab-mode logcat kivy-mode hoon-mode ebuild-mode arduino-mode yapfify yaml-mode xterm-color web-mode typit mmt tide typescript-mode string-inflection scss-mode realgud rake racer pyvenv pug-mode pip-requirements phpunit persp-mode paradox orgit org-present org-download org-bullets org-brain omnisharp mwim mmm-mode meghanada live-py-mode linum-relative js2-refactor intero impatient-mode hy-mode hindent highlight-indentation helm-swoop helm-projectile helm-flx helm-company git-timemachine flycheck-rust flycheck-haskell flx-ido fish-mode fill-column-indicator eyebrowse expand-region evil-surround evil-org evil-nerd-commenter evil-matchit evil-magit magit eshell-prompt-extras emojify ht editorconfig dumb-jump dockerfile-mode docker diff-hl define-word dante lcr cython-mode csv-mode csharp-mode company-php ac-php-core company-auctex company-anaconda clang-format chruby cargo rust-mode browse-at-remote auto-compile anaconda-mode ace-window ace-link auctex ghc company sbt-mode ess iedit smartparens highlight flycheck flyspell-correct git-commit helm helm-core avy magit-popup ghub let-alist with-editor markdown-mode alert projectile epl dash-functional php-mode pythonic f inf-ruby js2-mode simple-httpd all-the-icons powerline s dash yasnippet which-key use-package hydra font-lock+ exec-path-from-shell bind-key async evil goto-chg org-plus-contrib yasnippet-snippets xkcd xcscope x86-lookup ws-butler winum web-beautify volatile-highlights vi-tilde-fringe uuidgen unfill undo-tree toml-mode toc-org test-simple tagedit tablist symon sudoku sql-indent spotify spinner spaceline-all-the-icons smeargle slim-mode shut-up shell-pop seq sass-mode rvm ruby-tools ruby-test-mode ruby-refactor ruby-hash-syntax rubocop rspec-mode robe restart-emacs rbenv rainbow-delimiters pytest pyenv-mode py-isort protobuf-mode popwin pippel pipenv phpcbf php-extras php-auto-yasnippets password-generator pacmacs packed overseer org-projectile org-pomodoro org-mime open-junk-file noflet nginx-mode neotree nasm-mode nameless mvn multiple-cursors multi-term move-text minitest maven-test-mode markdown-toc magit-gitflow macrostep lorem-ipsum log4e loc-changes load-relative livid-mode link-hint less-css-mode julia-mode json-mode js-doc insert-shebang indent-guide importmagic hungry-delete htmlize hlint-refactor hl-todo highlight-parentheses highlight-numbers helm-xref helm-themes helm-spotify-plus helm-rtags helm-pydoc helm-purpose helm-mode-manager helm-make helm-hoogle helm-gitignore helm-descbinds helm-css-scss helm-c-yasnippet helm-ag haskell-snippets groovy-mode groovy-imports graphviz-dot-mode gradle-mode google-translate google-c-style golden-ratio godoctor go-tag go-rename go-guru go-eldoc gnuplot gntp gitconfig-mode gitattributes-mode git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md fuzzy flyspell-popup flyspell-correct-helm flycheck-rtags flycheck-pos-tip flycheck-gometalinter flycheck-bashate flx fancy-battery evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-search-highlight-persist evil-numbers evil-mc evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu ess-R-data-view eshell-z esh-help erc-yt erc-view-log erc-social-graph erc-image erc-hl-nicks ensime emoji-cheat-sheet-plus emmet-mode elisp-slime-nav dtrt-indent drupal-mode docker-tramp disaster diminish counsel-projectile company-web company-tern company-statistics company-shell company-rtags company-go company-ghci company-ghc company-emoji company-emacs-eclim company-cabal company-c-headers column-enforce-mode coffee-mode cmm-mode clean-aindent-mode centered-cursor-mode bundler auto-yasnippet auto-highlight-symbol auto-dictionary auctex-latexmk aggressive-indent adaptive-wrap ace-jump-helm-line ac-ispell 2048-game))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)

