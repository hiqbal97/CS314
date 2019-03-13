#lang racket

; *********************************************
; *  314 Principles of Programming Languages  *
; *  Spring 2019                              *
; *  Student Version                          *
; *********************************************

;; contains "ctv", "A", and "reduce" definitions
(require "include.rkt")

;; contains simple dictionary definition
(require "test-dictionary.rkt")

;; -----------------------------------------------------
;; HELPER FUNCTIONS

;; *** CODE FOR ANY HELPER FUNCTION GOES HERE ***

(define multiply
  (lambda (w)
    (- (* (key w) A) (floor (* (key w) A)))
))

(define create
  (lambda (a temp)
    (+ (* temp 29) (ctv a))
))

(define (foldl f init temp) 
   (if (null? temp) 
       init 
       (foldl f 
              (f (car temp) init) 
              (cdr temp))
))

(define add (lambda (hashfunctionlist dict)
               (foldl (lambda (x temp)
               (append (map x dict) temp)) '() hashfunctionlist)
))

(define (helper? x list)
  (if (null? list) #false
      (if (= x (car list)) #true
          (helper? x (cdr list)))
))

(define find (lambda (hashfunctionlist test word)
  (finder  (foldl (lambda (x temp)
    (cons (x word) temp ))  '() hashfunctionlist ) test)
))

(define finder (lambda (l1 l2)
                        (cond
    ((null? l1) #true)
      ((helper? (car l1) l2) (finder (cdr l1) l2))
    (else #false))
))
;; -----------------------------------------------------
;; KEY FUNCTION

(define key
  (lambda (w)
     (reduce create w 5413)
))


;; -----------------------------------------------------
;; EXAMPLE KEY VALUES
;;   (key '(h e l l o))       = 111037761665
;;   (key '(m a y))           = 132038724
;;   (key '(t r e e f r o g)) = 2707963878412931

;; -----------------------------------------------------
;; HASH FUNCTION GENERATORS

;; value of parameter "size" should be a prime number
(define gen-hash-division-method
  (lambda (size) ;; range of values: 0..size-1
     (lambda (w)
       (modulo (key w) size))
))


;; value of parameter "size" is not critical
;; Note: hash functions may return integer values in "real"
;;       format, e.g., 17.0 for 17

(define gen-hash-multiplication-method
  (lambda (size) ;; range of values: 0..size-1
     (lambda (w)
       (floor (* size (multiply w))))
))


;; -----------------------------------------------------
;; EXAMPLE HASH FUNCTIONS AND HASH FUNCTION LISTS

(define hash-1 (gen-hash-division-method 70111))
(define hash-2 (gen-hash-division-method 89989))
(define hash-3 (gen-hash-multiplication-method 700426))
(define hash-4 (gen-hash-multiplication-method 952))

(define hashfl-1 (list hash-1 hash-2 hash-3 hash-4))
(define hashfl-2 (list hash-1 hash-3))
(define hashfl-3 (list hash-2 hash-3))

;; -----------------------------------------------------
;; EXAMPLE HASH VALUES
;;   to test your hash function implementation
;;
;; (hash-1 '(h e l l o))        ==> 26303
;; (hash-1 '(m a y))            ==> 19711
;; (hash-1 '(t r e e f r o g))  ==> 3010
;;
;; (hash-2 '(h e l l o))        ==> 64598
;; (hash-2 '(m a y))            ==> 24861
;; (hash-2 '(t r e e f r o g))  ==> 23090
;;
;; (hash-3 '(h e l l o))        ==> 313800.0
;; (hash-3 '(m a y))            ==> 317136.0
;; (hash-3 '(t r e e f r o g))  ==> 525319.0
;;
;; (hash-4 '(h e l l o))        ==> 426.0
;; (hash-4 '(m a y))            ==> 431.0
;; (hash-4 '(t r e e f r o g))  ==> 714.0

;; -----------------------------------------------------
;; SPELL CHECKER GENERATOR

(define gen-checker
  (lambda (hashfunctionlist dict)
     (lambda (w)
       (find hashfunctionlist (add hashfunctionlist dict) w))
))

;; -----------------------------------------------------
;; EXAMPLE SPELL CHECKERS

(define checker-1 (gen-checker hashfl-1 dictionary))
(define checker-2 (gen-checker hashfl-2 dictionary))
(define checker-3 (gen-checker hashfl-3 dictionary))

;; EXAMPLE APPLICATIONS OF A SPELL CHECKER
;;
;;  (checker-1 '(a r g g g g)) ==> #f
;;  (checker-2 '(h e l l o)) ==> #t
;;  (checker-2 '(a r g g g g)) ==> #f
