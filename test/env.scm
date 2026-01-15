(import (srfi srfi-64) (srfi srfi-41) (algo env))

(test-begin "env")
(test-assert
    (equal? (stream->list (labels->env-stream '("A" "B" "C")))
            '((("A" . #f) ("B" . #f) ("C" . #f))
              (("A" . #f) ("B" . #f) ("C" . #t))
              (("A" . #f) ("B" . #t) ("C" . #f))
              (("A" . #f) ("B" . #t) ("C" . #t))
              (("A" . #t) ("B" . #f) ("C" . #f))
              (("A" . #t) ("B" . #f) ("C" . #t))
              (("A" . #t) ("B" . #t) ("C" . #f))
              (("A" . #t) ("B" . #t) ("C" . #t)))))
(test-end "env")