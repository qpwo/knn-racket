#lang racket
;; Luke Miles, June 2015
(require "knn.rkt")

(define (string->digits str)
  (for/list ([char (in-string str)])
    (- (char->integer char) 48)))

(define (parse-data ls)
  (if (null? ls)
    '()
    (begin
      (let-values ([(soon later) (split-at ls 32)])
        (cons (cons (string->number (string-trim (car later)))
                    (apply append (map string->digits soon)))
              (parse-data (cdr later)))))))

(define (parse-file path)
  (call-with-input-file
    path
    (λ (in)
      (parse-data (string-split (string-trim (port->string in)) "\n")))))

(define train-data (parse-file "optdigits/train.txt"))
(define test-data  (parse-file "optdigits/test.txt"))

(define (distance p1 p2)
  (for/sum ([x1 p1] [x2 p2]) (abs (- x1 x2))))

(define my-knn (make-knn-classifier train-data 8 distance))

;(test-knn-classifier my-knn test-data)
; above line returns 0.9671675013912076
