#lang racket
;; Luke Miles, June 2015

(define (zip . lists)
  (apply map list lists))

(require (only-in math normal-dist sample))
(define (normal-cluster x y std-dev [count 100])
  (zip (sample (normal-dist x std-dev) count)
       (sample (normal-dist y std-dev) count)))

(define (list-label sym lst)
  (map (λ (x) (cons x sym)) lst))

(define (make-data)
  (append (list-label 'left (normal-cluster -4 0 3))
          (list-label 'right (normal-cluster 4 0 3))))

(define train-data (make-data))
(define test-data (make-data))

(define (dist p1 p2)
  (for/sum ([x1 p1] [x2 p2]) (expt (- x1 x2) 2)))

(require "knn.rkt")
(for ([k (in-range 1 20)])
     (printf "accuracy for k=~a: ~a\n" k
             (test-classifier (make-knn-classifier train-data k dist)
                                  test-data)))
; TODO: why doesn't it get worse for k near 100?
