(import (thinker algo eval) (thinker data connective) (thinker data primitive) (srfi srfi-64) (ice-9 exceptions))

(test-begin "eval")
(test-assert (not (eval-proposition (& (Prim "A") (|| (Prim "B") (! (Prim "C")))) '(("A" . #t) ("B" . #f) ("C" . #t)))))
(test-assert (eval-proposition (& (Prim "A") (|| (Prim "B") (! (Prim "C")))) '(("A" . #t) ("B" . #f) ("C" . #f))))
(test-end "eval")