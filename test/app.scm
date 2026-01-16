(import (srfi srfi-64) (app) (data connective) (data primitive))

(test-begin "app")
(define thinker (rules->thinker (& (Prim "A") (|| (Prim "B") (! (Prim "C"))) (! (Prim "D")))))
(test-assert (equal? (thinker (Prim "B")) '(("B" . true) ("C" . uncertain) ("D" . false) ("A" . true))))
(test-end "app")