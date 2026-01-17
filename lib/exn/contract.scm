(library (exn contract)
  (export raise-contract-error)
  (import (ice-9 exceptions) (rnrs (6)) (srfi srfi-28))

  (define (raise-contract-error name exp act)
    (raise (make-exception
	          (make-exception-with-origin name)
	          (make-exception-with-message (format "Contract error: Expected ~a; Given ~s" exp act))
	          (make-programming-error)))))
