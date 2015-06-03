#lang racket

(define (make-array n m [v 0])
  (for/vector ([__ (in-range n)])
    (make-vector m v)))

(define (array-ref array row col)
  (vector-ref (vector-ref array row) col))

(define (array-set! array row col val)
  (vector-set! (vector-ref array row) col val))

(define (array->list array)
  (apply append (for/list ([row (in-vector array)])
                  (vector->list row))))

(provide make-array array-ref array-set! array->list)
