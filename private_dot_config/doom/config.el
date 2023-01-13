;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.



;; My config
;; I use customize-set-variable since I used it in my custom config to ensure
;; setters are invoked and to be able to see my constumizations in Easy
;; Customization UI with the 'customized-unsaved' command.

;; ---------------------------------------------------------------------------
;; Doom UI settings
;; Make sure that 'which-key-use-C-h-commands' is set to 't', otherwise you will
;; not be able to scroll through which-key pop up pages, e.g. when you invoke
;; 'which-key-show-major-mode' ('SPC-h-b m')
;; Source: https://www.reddit.com/r/DoomEmacs/comments/rtpflx/comment/hqw8hnt/.
(setq which-key-use-C-h-commands t)

;; Disable modal icon at doom modeline, I find it more pleasant to read letters
;; rather than checking colors which are indistinguishable in some themes.
(after! doom-modeline
  (setq doom-modeline-modal-icon nil))

;; Maximize/fullscreen Emacs on startup.
;; There are two ways to do it: using 'default-frame-alist' or
;; 'initial-frame-alist':
;; 1. Maximize all frames.
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; 2. Should only the first frame be maximized, use 'initial-frame-alist',
;; ((un)comment the following(previous) line)
;; (add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Doom sets 'text-mode-hook to display line numbers, I do not like to see line
;; numbers in org files.
(remove-hook 'text-mode-hook #'display-line-numbers-mode)


;; Doom says: "...but don't do any wrapping by default. It's expensive. Enable
;; `visual-line-mode' if you want soft line-wrapping. `auto-fill-mode' for hard
;; line-wrapping.".
;; But I'm a bad boy — I'll enable line wrapping by default, I like those arrows
;; in the fringes and 'visual-line-mode' doesn't show arrows.
(customize-set-variable 'truncate-lines nil)
;; ---------------------------------------------------------------------------



;; ---------------------------------------------------------------------------
;; Buffer management.

;; Bind IBuffer to 'C-x C-b', the shortcut executes `list-buffer` by default but
;; IBuffer is superior. IBuffer is a major mode for viewing a list of buffers
;; and operating on them in a way analogous to that of Dired, including
;; filtering, marking, sorting in various ways, and acting on buffers.
(global-set-key (kbd "C-x C-b") #'ibuffer)
;; ---------------------------------------------------------------------------


;; ---------------------------------------------------------------------------
;; Editing settings.

;; Set column beyond which automatic line-wrapping should happen (e.g. by
;; hitting M-q).
(customize-set-variable 'fill-column 80)

;; Enable Flyspell mode in Text mode. Flyspell is a minor mode that performs
;; automatic spell-checking of the text you type as you type it. Note that, as
;; Flyspell mode needs to check each word across which you move, it will slow
;; down cursor motion and scrolling commands. It also doesn't automatically
;; check the text you didn't type or move across; use 'flyspell-region' or
;; 'flyspell-buffer' for that.
;;
;; Prerequisites.
;; - Ispell and Flyspell commands only work if one of spell
;; checkers programs: Hunspell, Aspell, Ispell or Enchant, is installed on your
;; OS.
;; - 'ispell-complete-word' only works if you have a plain word-list dictionary
;; (sorted, case insensitive). You can install the 'words' package on Arch Linux
;; to get such dictionaries. Emacs configures 'ispell-alternate-dictionary' to
;; have the right path on Linux and macOS. But on windows, you need to set
;; 'ispell-complete-word-dict' manually.
(add-hook 'text-mode-hook #'flyspell-mode)
;; Enable Flyspell Prog mode in comments in Prog mode. Flyspell Prog mode only
;; checks words in comments and string constants.
(add-hook 'prog-mode-hook #'flyspell-prog-mode)

;; Important configuration of flyspell: you need to disable the M-<TAB> (C-M-i,
;; <ESC> <TAB>) binding for flyspell, because it's already used for the
;; 'complete-symbol' or 'ispell-complete-word' commands, e.g. this binding
;; overrides 'complete-symbol' in org-mode.
(customize-set-variable 'flyspell-use-meta-tab nil)

;; Let a period followed by a single space be treated as end of sentence. By
;; default, Emacs uses the rather old-fashioned convention of treating a period
;; followed by double spaces as end of sentence.
(customize-set-variable 'sentence-end-double-space nil)

;; Remember and restore the last cursor position of opened files.
(save-place-mode 1)

;; Auto refresh buffers when the underlying file has changed outside of Emacs.
;; It's called Auto Revert mode in Emacs.
(global-auto-revert-mode 1)
;; When Auto Revert mode a buffer that is under version control, it updates the
;; version control information in the mode line. However, Auto Revert mode may
;; not properly update this information if the version control status changes
;; without changes to the work file, from outside the current Emacs session. If
;; you set ‘auto-revert-check-vc-info’ to ‘t’, Auto Revert mode updates the
;; version control status information every ‘auto-revert-interval’ seconds, even
;; if the work file itself is unchanged. The resulting CPU usage depends on the
;; version control system, but is usually not excessive.
;; (customize-set-variable 'auto-revert-check-vc-info t)

;; Auto refresh Dired and other similar buffers.
(customize-set-variable 'global-auto-revert-non-file-buffers t)

;; Highlight trailing whitespace at the end of lines: any stray trailing
;; whitespace at the end of lines is highlighted (usually with a red
;; background).
;;
;; It is possible to set it globally using
;; (customize-set-variable 'show-trailing-whitespace t)
;; but it is annoying to see trailing spaces in buffers like *Choices*, *Dired*,
;; etc.
(defun highlight-trailing-whitespace ()
  (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook #'highlight-trailing-whitespace)
(add-hook 'conf-mode-hook #'highlight-trailing-whitespace)
(add-hook 'text-mode-hook #'highlight-trailing-whitespace)

;; Always add a newline automatically at the end of a file while saving. Many
;; Emacs major modes do this by default, but some do not, let's change it.
(customize-set-variable 'require-final-newline t)

;; Use spaces, not tabs, for indentation.
(customize-set-variable 'indent-tabs-mode nil)

;; Enable highlighting of matching pair of parentheses. By default, there is a
;; small delay between the movement of a cursor and the highlighting of the
;; matching pair of parentheses. The following line of code gets rid of this
;; delay.
(customize-set-variable 'show-paren-delay 0)

;; Make Emacs hotkeys work in Russian layout.
;; http://reangdblog.blogspot.com/2015/05/emacs.html.
;; LOR suggests that method does not always work:
;; https://www.linux.org.ru/forum/general/13857712
(defun cfg:reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key local-function-key-map
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))
    (when input-method
      (activate-input-method current))))
(cfg:reverse-input-method 'russian-computer)
;; Note. 'cfg:reverse-input-method' causes Emacs to open the *Quail Completions*
;; buffer, let's auto-close it.
(kill-buffer "*Quail Completions*")
;; ---------------------------------------------------------------------------


;; ---------------------------------------------------------------------------
;; Org mode settings.
;; Fontify (e.g., highlight with a background color) the whole line for
;; headings. Looks nice with the leuven theme.
;; (customize-set-variable 'org-fontify-whole-heading-line t)

;; Display the buffer in the indented view, this also hides leading heading
;; stars, only one star (the rightmost) at each heading is visible, the rest are
;; masked with the same font color as background.
(customize-set-variable 'org-startup-indented t)

;; Customize org-M-RET-may-split-line to make M-RET not split the line. Doom
;; Emacs sets it to nil by default.
;; Source: https://orgmode.org/manual/Structure-Editing.html#index-M_002dRET.
(customize-set-variable 'org-M-RET-may-split-line nil)

;; Enable syntax highlighting for latex fragments.
;; Note: I didn't understood
(customize-set-variable 'org-highlight-latex-and-related '(native))

;; Add by default additional LaTeX packages for Russian language support.
;; (require 'org)
;; (add-to-list 'org-latex-packages-alist '("" "cmap" t))
;; (add-to-list 'org-latex-packages-alist '("english,russian" "babel" t))

;; Org mode sets 'truncate-lines' to 't', so each line of text has just one
;; scree line. But there is a problem with it: you can be left with horizontal
;; scroll after you invoke 'org-fill-paragraph' on a long line and you will have
;; to manually scroll to adjust the view. Let's change 'auto-hscholl-mode' to
;; f'current-line' locally to 'org-mode' to avoid the problem.
;;
;; BTW, maybe instead of setting 'auto-hscroll-mode' to 'current-line' it's
;; better to remap org-fill-paragraph to scroll horizontally to left after
;; filling the paragraph.
(setq-hook! org-mode auto-hscroll-mode 'current-line)

;; TODO 1. Bind next/prev list item in Org mode.
;;      2. Rewrite org mode configuration via use-package.
;; ---------------------------------------------------------------------------


;; ---------------------------------------------------------------------------
;; Packages
;; Load Modus theme.
;;
;; TODO, modify the 'shadow' face, to make org properties (e.g., lines like
;; "#+title: ...") distinguishable from comments. I want 'yellow-comments' in
;; operandi, but standard comments in vivendi with appropriate 'shadow' face.
(use-package! modus-themes
  :init
  ;; Add all your customizations prior to loading the themes.

  ;; Adjust modus-vivendi colors.
  (setq modus-themes-vivendi-color-overrides
        '((fg-main . "#f0fff0")))       ; Default face is white on black, dim white a bit.

  (setq modus-themes-mode-line '(borderless accented)
        modus-themes-syntax '(yellow-comments))

  ;; Load the theme files before enabling a theme.
  (modus-themes-load-themes)
  :config
  ;; Load the theme of your choice:
  (modus-themes-load-operandi) ;; OR (modus-themes-load-vivendi).
  :bind ("<f5>" . modus-themes-toggle))


;; Poke-line inspired by nyan-mode but with Pokemons!
(use-package! poke-line
  :config
  (poke-line-set-random-pokemon)
  (poke-line-global-mode 1))


;; Configure completion using 'company'.
(after! company
    (setq company-minimum-prefix-length 1
          company-idle-delay 0.0)         ; Default is 0.2.
)

;; Snipe mode shadows default bindings for 's' and 'S', disable the mode and not
;; disable the package to have incremental highlighting for f/F/t/T.
(after! evil-snipe
  (remove-hook 'doom-first-input-hook #'evil-snipe-mode))
;; ---------------------------------------------------------------------------
