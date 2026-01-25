(library (io)
    (export read-proposition)
    (import (rnrs (6)) (algo parse) (exn contract))
    
    (define (read-proposition port)
        (unless (input-port? port)
            (raise-contract-error 'read-proposition "input-port?" port))
        (parse-tree (read port))))