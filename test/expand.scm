(import (srfi srfi-64) (algo expand) (srfi srfi-69))

(test-begin "expand")
(define e (make-hash-table eq?))
(hash-table-set! e '=> (lambda (a b) `(or (not ,a) ,b)))
(test-assert (equal? '(or (not "a") "b") (expand-proposition '(=> "a" "b") e)))
(test-error &exception (expand-proposition '(<=> "A" "B") e))
(test-end "expand")