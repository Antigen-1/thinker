(library (thinker exn internal)
    (export raise-internal-error &internal-error make-internal-error internal-error?)
    (import (rnrs (6)) (ice-9 exceptions) (srfi srfi-9 gnu) (srfi srfi-28))
    
    (define-exception-type &internal-error &programming-error make-internal-error internal-error?
        (origin internal-error-origin)
        (reason internal-error-reason))

    ;; The printer
    (set-record-type-printer! &internal-error
        (lambda (r p)
          (display 
            (format "Internal error:\n  ~a:\n    reason: ~a\n" 
                    (internal-error-origin r)
                    (internal-error-reason r))
            p)))

    (define (raise-internal-error name msg)
        (raise-exception (make-internal-error name msg))))