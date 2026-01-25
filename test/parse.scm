(import (srfi srfi-64) (algo parse))

(test-begin "parse")
(define r '(and (or "a") "b" (not "c")))
(test-assert (equal? r (unparse-proposition (parse-proposition r))))
(test-end "parse")