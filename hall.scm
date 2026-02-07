(hall-description
  (name "thinker")
  (prefix "guile")
  (version "1.4")
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
              "thinker"
              ((directory
                 "algo"
                 ((scheme-file "pkg")
                  (scheme-file "env")
                  (scheme-file "label")
                  (scheme-file "list")
                  (scheme-file "eval")))
               (directory
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
                 "parallel"
                 ((scheme-file "entail")))
               (scheme-file "app")))))
         (tests ((directory
                   "test"
                   ((scheme-file "expand")
                    (scheme-file "parse")
                    (scheme-file "entail")
                    (scheme-file "app")
                    (scheme-file "env")
                    (scheme-file "label")
                    (scheme-file "eval")
                    (scheme-file "data")))))
         (programs
           ((directory
              "scripts"
              ((scheme-file "thinker")))))
         (documentation
           ((directory
              "doc"
              ((texi-file "thinker")))
            (text-file "COPYING")
            (text-file "HACKING")
            (symlink "README" "README.org")))
         (infrastructure
           ((directory "examples"
              ((scheme-file "connectives")))
            (scheme-file "hall")))))
