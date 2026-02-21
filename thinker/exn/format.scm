(library (thinker exn format)
    (export format-simple-exn)
    (import (scheme base) (rnrs records inspection (6)) (rnrs records procedural (6)) (srfi srfi-28) (srfi srfi-9))
    
    (define (format-simple-exn k e)
        (define sep "    ")
        (define type (record-rtd e))
        (define name (record-type-name type))
        (define fields (vector->list (record-type-field-names type)))
        (define values 
            (let loop ((fields fields) (n 0))
                (if (null? fields) '() (cons ((record-accessor type n) e) (loop (cdr fields) (+ n 1))))))
        (apply 
         string-append 
         k ":\n"
         (map (lambda (f v) (format "~a~a: ~a\n" sep f v)) fields values))))