; Lunar lockout game domain

(define (domain lunar_lockout)

(:requirements :strips :typing :adl)

(:types
    Craft Coord - Object
)

(:predicates
    (locatedAt ?craft - Craft ?coordX - Coord ?coordY - Coord)
    (lessThan ?coord1 - Coord ?coord2 - Coord) ; coord1 < coord2
    ; the moved craft must be immediately next to the the one we want to hit
    (exactlyOneLessThan ?coord1 - Coord ?coord2 - Coord) 
)


;define actions here
; note; for us, up means going from (3,4) to (3,1), for instance, and going down means going from (4,1) to (4,3)
; ie. going up  means decreasing the Y coordinate while keeping constant the X coordinate
; the board looks like:
; (0,0) (1,0) (2,0) (3,0) (4,0)
; (0,1) (1,1) (2,1) (3,1) (4,1)
; (0,2) (1,2) (2,2) (3,2) (4,2)
; (0,3) (1,3) (2,3) (3,3) (4,3)
; (0,4) (1,4) (2,4) (3,4) (4,4)  
( :action up
    :parameters (
    ?craftToMove - Craft
    ?sharedCoordX ?craftToMoveCurrentCoordY ?craftToHitCurrentCoordY ; shared X!
    ?craftToMoveNextCoordY - Coord
    ?craftToHit - Craft
    )
    :precondition 
    (and 
      (locatedAt ?craftToMove ?sharedCoordX ?craftToMoveCurrentCoordY)
      (locatedAt ?craftToHit ?sharedCoordX ?craftToHitCurrentCoordY)
      (lessThan ?craftToHitCurrentCoordY ?craftToMoveCurrentCoordY) ; craft to hit with Y < craft to move
      (exactlyOneLessThan ?craftToHitCurrentCoordY ?craftToMoveNextCoordY) ; target pos: immediately next to the craft to hit
      ; we need to guarantee that the craft to hit is the closest one in the corresponding axis
      ; otherwise, we could jump over other crafts, which is not allowed
      ; check that there is no craft s.t. it is between the craft to move and the craft to hit
      (forall (?craft - Craft ?coordY - Coord)
        (not
          (and
            (locatedAt ?craft ?sharedCoordX ?coordY)
            (lessThan ?craftToHitCurrentCoordY ?coordY)
            (lessThan ?coordY ?craftToMoveCurrentCoordY)
          )
        )
      )

    )
    :effect
    (and
      ; delete list: the moved craft is no longer in the same position
      (not (locatedAt ?craftToMove ?sharedCoordX ?craftToMoveCurrentCoordY))
      ; add list: the moved craft is in the next location
      (locatedAt ?craftToMove ?sharedCoordX ?craftToMoveNextCoordY)
    )
)

; analagously to the up action, now we define actions for moving down, left and right, respectively

( :action down
    :parameters (
    ?craftToMove - Craft
    ?sharedCoordX ?craftToMoveCurrentCoordY ?craftToHitCurrentCoordY ; shared X!
    ?craftToMoveNextCoordY - Coord
    ?craftToHit - Craft
    )
    :precondition 
    (and 
      (locatedAt ?craftToMove ?sharedCoordX ?craftToMoveCurrentCoordY)
      (locatedAt ?craftToHit ?sharedCoordX ?craftToHitCurrentCoordY)
      (lessThan ?craftToMoveCurrentCoordY ?craftToHitCurrentCoordY) ; craft to move with Y < craft to hit
      (exactlyOneLessThan ?craftToMoveNextCoordY ?craftToHitCurrentCoordY) ; target pos: immediately next to the craft to hit
      ; we need to guarantee that the craft to hit is the closest one in the corresponding axis
      ; otherwise, we could jump over other crafts, which is not allowed
      ; check that there is no craft s.t. it is between the craft to move and the craft to hit
      (forall (?craft - Craft ?coordY - Coord)
        (not
          (and
            (locatedAt ?craft ?sharedCoordX ?coordY)
            (lessThan ?coordY ?craftToHitCurrentCoordY)
            (lessThan ?craftToMoveCurrentCoordY ?coordY)
          )
        )
      )

    )
    :effect
    (and
      ; delete list: the moved craft is no longer in the same position
      (not (locatedAt ?craftToMove ?sharedCoordX ?craftToMoveCurrentCoordY))
      ; add list: the moved craft is in the next location
      (locatedAt ?craftToMove ?sharedCoordX ?craftToMoveNextCoordY)
    )
  )

  ; now, for moving left and right, Y is fixed, while we will move a craft alongisde the X axis

  ( :action left
    :parameters (
    ?craftToMove - Craft
    ?sharedCoordY ?craftToMoveCurrentCoordX ?craftToHitCurrentCoordX ; shared Y!
    ?craftToMoveNextCoordX - Coord
    ?craftToHit - Craft
    )
    :precondition 
    (and 
      (locatedAt ?craftToMove ?craftToMoveCurrentCoordX ?sharedCoordY)
      (locatedAt ?craftToHit ?craftToHitCurrentCoordX ?sharedCoordY)
      (lessThan ?craftToHitCurrentCoordX ?craftToMoveCurrentCoordX ) ; craft to hit with X < craft to move
      (exactlyOneLessThan ?craftToHitCurrentCoordX ?craftToMoveNextCoordX) ; target pos: immediately next to the craft to hit
      ; we need to guarantee that the craft to hit is the closest one in the corresponding axis
      ; otherwise, we could jump over other crafts, which is not allowed
      ; check that there is no craft s.t. it is between the craft to move and the craft to hit
      (forall (?craft - Craft ?coordX - Coord)
        (not
          (and
            (locatedAt ?craft ?coordX ?sharedCoordY)
            (lessThan ?craftToHitCurrentCoordX ?coordX)
            (lessThan ?coordX ?craftToMoveCurrentCoordX )
          )
        )
      )

    )
    :effect
    (and
      ; delete list: the moved craft is no longer in the same position
      (not (locatedAt ?craftToMove ?craftToMoveCurrentCoordX ?sharedCoordY))
      ; add list: the moved craft is in the next location
      (locatedAt ?craftToMove ?craftToMoveNextCoordX ?sharedCoordY)
    )
  )

  ( :action right
    :parameters (
    ?craftToMove - Craft
    ?sharedCoordY ?craftToMoveCurrentCoordX ?craftToHitCurrentCoordX ; shared Y!
    ?craftToMoveNextCoordX - Coord
    ?craftToHit - Craft
    )
    :precondition 
    (and 
      (locatedAt ?craftToMove ?craftToMoveCurrentCoordX ?sharedCoordY)
      (locatedAt ?craftToHit ?craftToHitCurrentCoordX ?sharedCoordY)
      (lessThan  ?craftToMoveCurrentCoordX ?craftToHitCurrentCoordX) ; craft to move with X < craft to hit
      (exactlyOneLessThan ?craftToMoveNextCoordX ?craftToHitCurrentCoordX) ; target pos: immediately next to the craft to hit
      ; we need to guarantee that the craft to hit is the closest one in the corresponding axis
      ; otherwise, we could jump over other crafts, which is not allowed
      ; check that there is no craft s.t. it is between the craft to move and the craft to hit
      (forall (?craft - Craft ?coordX - Coord)
        (not
          (and
            (locatedAt ?craft ?coordX ?sharedCoordY)
            (lessThan ?coordX ?craftToHitCurrentCoordX)
            (lessThan ?craftToMoveCurrentCoordX ?coordX)
          )
        )
      )

    )
    :effect
    (and
      ; delete list: the moved craft is no longer in the same position
      (not (locatedAt ?craftToMove ?craftToMoveCurrentCoordX ?sharedCoordY))
      ; add list: the moved craft is in the next location
      (locatedAt ?craftToMove ?craftToMoveNextCoordX ?sharedCoordY)
    )
  )  

)