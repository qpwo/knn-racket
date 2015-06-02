#lang racket
(require racket/gui/base)
(define frame (new frame%
                   [label "Example"]
                   [width 300]
                   [height 300]))
(define canvas
  (new canvas% [parent frame]))
(define dc (send canvas get-dc))
(send frame show #t)

(define drawing-thread
  (thread (λ ()
            (for ([i (in-range 200)])
              (sleep 1/30)
              (send dc draw-rectangle i i 10 40)))))
