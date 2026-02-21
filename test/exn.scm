(import (srfi srfi-64) (thinker exn internal) (thinker exn contract))

(test-begin "exn")
(test-assert (equal? "Contract error:\n  thinker:\n    expect: (or/c (quote clear) (quote add) (quote list-prims) (quote remove) (quote list-conns) (quote list) (quote entails?))\n    given: -\n"
                     (with-output-to-string
                      (lambda ()
                        (display (make-contract-error 'thinker "(or/c (quote clear) (quote add) (quote list-prims) (quote remove) (quote list-conns) (quote list) (quote entails?))" '-))))))
(test-assert (equal? "Internal error:\n  thinker:\n    reason: internal error\n"
                     (with-output-to-string
                      (lambda ()
                        (display (make-internal-error 'thinker "internal error"))))))
(test-end "exn")