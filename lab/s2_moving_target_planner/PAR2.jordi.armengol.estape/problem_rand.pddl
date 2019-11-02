(define (problem problem_rand) (:domain moving_target)
(:objects 
    zero one two three four five six - Coord
)

(:init
    (exactlyOneLessThan zero one)
    (exactlyOneLessThan one two)
    (exactlyOneLessThan two three)
    (exactlyOneLessThan three four)
    (exactlyOneLessThan four five)
    (exactlyOneLessThan five six)

    (locatedAt zero three zero)

    (= (cost) 0)
)

(:goal (or
    (locatedAt three zero zero)
    (locatedAt three zero zero)
    (locatedAt two zero one)
    (locatedAt two one two)
    (locatedAt two two three)
    (locatedAt two two four)
    (locatedAt one two five)

))

(:metric 
    minimize (cost)
)

)
