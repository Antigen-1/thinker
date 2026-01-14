(import (algo label) (algo list) (data connective) (data primitive) (srfi srfi-64))

(test-begin "label")
(define labels (get-labels (& (Prim "A") (|| (Prim "B") (! (Prim "C"))))))
(test-assert (andmap (lambda (s) (index '("A" "B" "C") s string=?)) labels))
(test-end "label")