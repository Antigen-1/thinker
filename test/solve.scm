(import (data connective) (data primitive) (parallel solve) (srfi srfi-64))

(test-begin "solve")
(test-assert
    (equal? (solve (& (Prim "A") (|| (Prim "B") (! (Prim "C")))))
            '((("B" . #f) ("C" . #f) ("A" . #t))
              (("B" . #t) ("C" . #f) ("A" . #t))
              (("B" . #t) ("C" . #t) ("A" . #t)))))
(test-end "solve")