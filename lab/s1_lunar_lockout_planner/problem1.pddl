(define (problem problem2) (:domain lunar_lockout)
(:objects 
    redCraft greenCraft purpleCraft yellowCraft orangeCraft - Craft
    zeroCoord oneCoord twoCoord threeCoord fourCoord - Coord
)

(:init
    (lessThan zeroCoord oneCoord)
    (lessThan zeroCoord twoCoord)
    (lessThan zeroCoord threeCoord)
    (lessThan zeroCoord fourCoord)
    (lessThan oneCoord twoCoord)
    (lessThan oneCoord threeCoord)
    (lessThan oneCoord fourCoord)
    (lessThan twoCoord threeCoord)
    (lessThan twoCoord fourCoord)
    (lessThan threeCoord fourCoord)

    (exactlyOneLessThan zeroCoord oneCoord)
    (exactlyOneLessThan oneCoord twoCoord)
    (exactlyOneLessThan twoCoord threeCoord)
    (exactlyOneLessThan threeCoord fourCoord)

    (locatedAt redCraft fourCoord fourCoord)
    (locatedAt greenCraft twoCoord oneCoord)
    (locatedAt purpleCraft oneCoord twoCoord)
    (locatedAt yellowCraft threeCoord threeCoord)
    (locatedAt orangeCraft fourCoord zeroCoord)
)

(:goal (and
    (locatedAt redCraft twoCoord twoCoord)
))
)
