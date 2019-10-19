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

    (locatedAt redCraft zeroCoord zeroCoord)
    (locatedAt greenCraft threeCoord threeCoord)
    (locatedAt purpleCraft oneCoord oneCoord)
    (locatedAt yellowCraft threeCoord zeroCoord)
    (locatedAt orangeCraft oneCoord fourCoord)
)

(:goal (and
    (locatedAt redCraft twoCoord twoCoord)
))
)
