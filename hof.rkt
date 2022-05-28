#lang racket


; foldr
(define (my-foldr function init lst)
  (if (null? lst)
      init
      (function (first lst)
                (my-foldr function init (rest lst)))))


; foldl
(define (my-foldl function init lst)
  (if (null? lst)
      init
      (function (last lst)
                (my-foldl function init (drop-right lst 1)))))


; map
(define (my-map function lst)    
 (foldr (lambda (a b) (cons (function a) b))
        empty lst))


; foldtree
; the only way I coud think of implementring foldtree was using a map,
; so let's use our own map defined above
(define (my-foldtree num function tree)
  (if (null? tree) num
      (apply function (cons (car tree)
                            my-map (lambda (a) (my-foldtree num function a)) (cdr tree)))))


; reduce
(define (my-reduce function lst)
  (and (not (null? lst)) (my-foldl function (first lst) (rest lst))))


; filter
(define (my-filter function lst)
  (my-foldr (lambda (a b)
              (if (function a) (cons a b) b))
            '()
            lst))


; using foldl, we can implement insertion sort (by defining
; and calling insertion function inside of our sort function)
(define (my-in-sort lst)
  (define (my-insert element lst)
    (if (null? lst)
        (list element)
        (let ([first_el (first lst)])
          (if (> first_el element)
              (cons element lst)
              (cons first_el (my-insert element (rest lst)))))))

  (foldl my-insert '() lst))



; using filter, we can implement some kind of a quick sort
; function by simply filtering all of the elements that are
; less/greater than some selected pivot
(define (my-qsort comparator lst)
  (if (null? lst)
      '()
      (let ([pivot (car lst)])
        (append (my-qsort comparator
                          (my-filter (lambda (a)
                                    (comparator a pivot)) (cdr lst)))
                (list pivot)
                (my-qsort comparator
                          (my-filter (lambda (a)
                                    (not (comparator a pivot))) (cdr lst)))))))


; tests
(printf "(my-foldr cons '() '(1 2 3 4 5)): ")
(my-foldr cons '() '(1 2 3 4 5))

(printf "(my-foldl cons '() '(1 2 3 4 5)): ")
(my-foldl cons '() '(1 2 3 4 5))

(printf "(my-reduce + '(10 10 10 10 10)): ")
(my-reduce + '(10 10 10 10 10))

(printf "(my-map add1 '(9 19 29 39)): ")
(my-map add1 '(9 19 29 39))

(printf "(my-filter odd? ' (1 2 3 4 5 6 7 8 9)): ")
(my-filter odd? ' (1 2 3 4 5 6 7 8 9))

(printf "(my-in-sort '(89 67 5 4 67 90 12)): ")
(my-in-sort '(89 67 5 4 67 90 12))

(printf "(my-qsort (lambda (a b) (< (abs a) (abs b))) '(1 9 -7 2 4 -8 7 -6 2)): ")
(my-qsort (lambda (a b) (< (abs a) (abs b))) '(1 9 -7 2 4 -8 7 -6 2))
