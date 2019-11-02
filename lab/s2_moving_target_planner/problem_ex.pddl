(define (problem problem_ex) (:domain moving_target)
(:objects 
    zero one two three four five - Coord
)

(:init
    (exactlyOneLessThan zero one)
    (exactlyOneLessThan one two)
    (exactlyOneLessThan two three)
    (exactlyOneLessThan three four)
    (exactlyOneLessThan four five)

    (locatedAt zero zero zero)

    (= (cost) 0)
)

(:goal (or
    (locatedAt three three zero)
    (locatedAt two three one)
    (locatedAt two two two)
    (locatedAt two two three)
    (locatedAt two two four)
    (locatedAt two two five)
))

(:metric 
    minimize (cost)
)

)
 
