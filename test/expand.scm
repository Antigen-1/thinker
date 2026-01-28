(import (srfi srfi-64) (expander expand) (srfi srfi-69))

(test-begin "expand")
(install-connective! '=> (lambda (a b) `(or (not ,a) ,b)))
(install-connective! '- (lambda (_) 1))
(test-assert (equal? '(or (not "a") "b") (expand-proposition '(=> "a" "b"))))
(test-error &exception (expand-proposition '(<=> "A" "B") e))
(test-error &exception (expand-proposition '(- "A") e))
(test-end "expand")