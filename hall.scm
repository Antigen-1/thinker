(hall-description
  (name "thinker")
  (prefix "guile")
  (version "1.1")
  (author "Hao Zhang")
  (copyright (2026))
  (synopsis "")
  (description "")
  (home-page "")
  (license gpl3+)
  (dependencies `())
  (skip ())
  (files (libraries
           ((directory
              "lib"
              ((directory
                 "data"
                 ((scheme-file "parse")
                  (scheme-file "expand")
                  (scheme-file "node")
                  (scheme-file "connective")
                  (scheme-file "primitive")))
               (directory
                 "exn"
                 ((scheme-file "internal")
                  (scheme-file "contract")))
               (directory
                 "algo"
                 ((scheme-file "pkg")
                  (scheme-file "env")
                  (scheme-file "label")
                  (scheme-file "list")
                  (scheme-file "eval")))
               (directory "parallel" ((scheme-file "entail")))
               (scheme-file "app")))))
         (tests ((directory "tests" ())))
         (programs
           ((directory "scripts" ((scheme-file "thinker")))))
         (documentation
           ((symlink "README" "README.org")
            (text-file "HACKING")
            (text-file "COPYING")
            (directory "doc" ((texi-file "thinker")))))
         (infrastructure
           ((scheme-file "guix")
            (text-file ".gitignore")
            (scheme-file "hall")))))
