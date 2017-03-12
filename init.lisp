(in-package :stumpwm)

(set-module-dir "~/.stumpwm.d/contrib")

(set-prefix-key (kbd "C-t"))

;; These programs are started by Unity/Ubuntu.
;; Run them here too for no unexpected hiccups.
(mapcar (lambda (command)
          (stumpwm::run-shell-command command))
        '("/usr/bin/vmware-user-suid-wrapper"
          "/usr/bin/gnome-software --gapplication-service"
          "/usr/lib/x86_64-linux-gnu/indicator-application/indicator-application-service"
          "/usr/bin/gnome-keyring-daemon --start --components=ssh"))

;; Change the keyboard repeat delay.
(stumpwm::run-shell-command "xset r rate 250 60")

;; Swap Ctrl and Caps Lock
(stumpwm::run-shell-command "/usr/bin/setxkbmap -option \"ctrl:swapcaps\"")

;; Scrolling in GTK apps.
(run-shell-command "export GDK_CORE_DEVICE_EVENTS=1")

;; Wallpaper
(run-with-timer 0 10
                (lambda ()
                  (run-shell-command "feh --bg-scale ~/.pictures/song.jpg")))

(require 'swank)
(swank:create-server)

;; Focus Follows Mouse
(setf *mouse-focus-policy* :sloppy)

;; Redefine Emacs command.
(defcommand emacs () ()
  "Start Emacs or switch to it, if it is already running."
  (run-or-raise "emacs25" '(:class "Emacs")))

;; Keybindings
(define-key *root-map* (kbd "_") "fclear")
(define-key *root-map* (kbd "-") "vsplit")
(define-key *root-map* (kbd "\\") "hsplit")
(define-key *root-map* (kbd "k") "move-focus up")
(define-key *root-map* (kbd "j") "move-focus down")
(define-key *root-map* (kbd "l") "move-focus right")
(define-key *root-map* (kbd "h") "move-focus left")
(define-key *root-map* (kbd "L") "redisplay")
(define-key *root-map* (kbd "DEL") "remove")

;; Mode Line Configuration
(setf *mode-line-position* :bottom)
(toggle-mode-line (current-screen) (current-head))
