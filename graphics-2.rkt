#lang racket
(require racket/gui/base)

(define (test canvas dc)
  (send dc set-brush "red" 'solid)
  (send dc set-pen "black"  0 'transparent)
  (thread (λ ()
            (for ([i (in-range 291)])
              (sleep 1/60)
              (send dc draw-rectangle i i 10 10)))))

(define frame (new frame%
                   [label "Example"]
                   [width 300]
                   [height 300]))

(send frame show #t)

(new canvas% [parent frame]
             [paint-callback test])
       ;(lambda (canvas dc)
       ;  (send dc set-brush "red" 'solid)
       ;  (send dc set-pen "black"  0 'transparent)
       ;  (send dc draw-rectangle 0 10 30 10))])
;(send frame show #t)
