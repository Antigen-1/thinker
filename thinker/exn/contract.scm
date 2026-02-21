(library (thinker exn contract)
  (export raise-contract-error &contract-error make-contract-error contract-error?)
  (import (ice-9 exceptions) (rnrs (6)) (srfi srfi-28) (srfi srfi-9 gnu))

  (define-exception-type &contract-error &assertion-failure make-contract-error contract-error?
    (origin contract-error-origin)
    (expect contract-error-expect)
    (given contract-error-given))

  ;; The printer
  (set-record-type-printer! &contract-error
    (lambda (r p)
      (display 
        (format "Contract error:\n  ~a:\n    expect: ~a\n    given: ~s\n" 
                (contract-error-origin r)
                (contract-error-expect r)
                (contract-error-given r))
        p)))

  (define (raise-contract-error name exp act)
    (raise-exception (make-contract-error name exp act))))
