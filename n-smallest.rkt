#lang racket
;; Luke Miles, June 2015
;; actually useless because so slow, better to use sort

(define (pair-> p1 p2) (> (cdr p1) (cdr p2)))

;; add a pair to a list of decreasing-by-second-element pairs,
;; preserving order
(define (pair-set-add ls x)
  (let-values
    ([(larger smaller)
      (splitf-at ls (λ (elm) (pair-> elm x)))])
    (append larger (list x) smaller)))

;; returns the n smallest elements of ls under f
(define (n-smallest n ls [f identity])
  (define f@ls (map (λ (x) (cons x (f x))) ls))
  (let S ([best (sort (take f@ls n) pair->)] [left (drop f@ls n)])
    (cond [(null? left) (reverse (map car best))]
          [(pair-> (car best) (car left))
           (S (pair-set-add (cdr best) (car left)) (cdr left))]
          [else (S best (cdr left))])))

(provide n-smallest)
