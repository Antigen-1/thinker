(import (srfi srfi-64) (app) (data connective) (data primitive))

(test-begin "app")
(define thinker (rules->thinker (& (Prim "A") (|| (Prim "B") (! (Prim "C"))) (! (Prim "D")))))
(test-assert (thinker (Prim "A")))
(test-assert (not (thinker (Prim "D"))))
(test-assert (not (thinker (Prim "B"))))
(test-end "app")