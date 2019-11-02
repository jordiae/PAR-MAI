; Moving target domain

(define (domain moving_target )

(:requirements :strips :typing :adl :fluents)

(:types
    Coord Object
)

(:predicates
    (locatedAt ?coordY - Coord ?coordX - Coord ?time - Coord)
    (exactlyOneLessThan ?a - Coord ?b - Coord) ; a + 1 = b
)

(:functions
  (cost)
)

; define actions here
; note; for us, up means going from (1,0) to (0,0), for instance, and going down means going from (2,1) to (3,1)
; ie. going up  means decreasing the Y coordinate while keeping constant the X coordinate
; the board looks like:
; (0,0) (0,1) (0,2) (0,3)
; (1,0) (1,1) (1,2) (1,3)
; (2,0) (2,1) (2,2) (2,3)
; (3,0) (3,1) (3,2) (3,3)
; We define the predicate locatedAt with Y X (and not X Y) for preserving the order in the table
; In the previous delivery, since the board was not given with the coordinates, I interpreted that
; the first coordinate was X, so the first row would have been (0,0) (1,0)...
( :action up
    :parameters (
    ?currentCoordX - Coord
    ?currentCoordY - Coord
    ?nextCoordY - Coord
    ?currentTime - Coord
    ?nextTime - Coord
    )
    :precondition 
    (and 
      (locatedAt ?currentCoordY ?currentCoordX ?currentTime)
      (exactlyOneLessThan ?currentTime ?nextTime)
      (exactlyOneLessThan ?nextCoordY ?currentCoordY)
    )
    :effect
    (and
      ; delete list: the robot is no longer at the same position, same for time
      (not (locatedAt ?currentCoordY ?currentCoordX ?currentTime))
      ; add list: the robot is at the next location, same for time
      (locatedAt ?nextCoordY ?currentCoordX ?nextTime)
      ; cost of visiting one cell: 1
      (increase (cost) 1)
    )
)

; analogously to the up action, now we define actions for moving down, left and right, respectively

( :action down
    :parameters (
    ?currentCoordX - Coord
    ?currentCoordY - Coord
    ?nextCoordY - Coord
    ?currentTime - Coord
    ?nextTime - Coord
    )
    :precondition 
    (and 
      (locatedAt ?currentCoordY ?currentCoordX ?currentTime)
      (exactlyOneLessThan ?currentTime ?nextTime)
      (exactlyOneLessThan ?currentCoordY ?nextCoordY) ; the only difference with respect to UP!
    )
    :effect
    (and
      ; delete list: the robot is no longer at the same position, same for time
      (not (locatedAt ?currentCoordY ?currentCoordX ?currentTime))
      ; add list: the robot is at the next location, same for time
      (locatedAt ?nextCoordY ?currentCoordX ?nextTime)
      ; cost of visiting one cell: 1
      (increase (cost) 1)
    )
)

( :action left
    :parameters (
    ?currentCoordX - Coord
    ?currentCoordY - Coord
    ?nextCoordX - Coord ; now we move alongside the X axis, not Y
    ?currentTime - Coord
    ?nextTime - Coord
    )
    :precondition 
    (and 
      (locatedAt ?currentCoordY ?currentCoordX ?currentTime)
      (exactlyOneLessThan ?currentTime ?nextTime)
      (exactlyOneLessThan ?nextCoordX ?currentCoordX) ; now we move alongside the X axis, not Y
    )
    :effect
    (and
      ; delete list: the robot is no longer at the same position, same for time
      (not (locatedAt ?currentCoordY ?currentCoordX ?currentTime))
      ; add list: the robot is at the next location, same for time
      (locatedAt ?currentCoordY ?nextCoordX ?nextTime) ; now we move alongside the X axis, not Y
      ; cost of visiting one cell: 1
      (increase (cost) 1)
    )
)

( :action right
    :parameters (
    ?currentCoordX - Coord
    ?currentCoordY - Coord
    ?nextCoordX - Coord ; now we move alongside the X axis, not Y
    ?currentTime - Coord
    ?nextTime - Coord
    )
    :precondition 
    (and 
      (locatedAt ?currentCoordY ?currentCoordX ?currentTime)
      (exactlyOneLessThan ?currentTime ?nextTime)
      (exactlyOneLessThan ?currentCoordX ?nextCoordX) ; the only difference with respect to LEFT!
    )
    :effect
    (and
      ; delete list: the robot is no longer at the same position, same for time
      (not (locatedAt ?currentCoordY ?currentCoordX ?currentTime))
      ; add list: the robot is at the next location, same for time
      (locatedAt ?currentCoordY ?nextCoordX ?nextTime) ; now we move alongside the X axis, not Y
      ; cost of visiting one cell: 1
      (increase (cost) 1)
    )
)

( :action stay
    :parameters (
    ?currentCoordX - Coord
    ?currentCoordY - Coord
    ?currentTime - Coord
    ?nextTime - Coord
    )
    :precondition 
    (and 
      (locatedAt ?currentCoordY ?currentCoordX ?currentTime)
      (exactlyOneLessThan ?currentTime ?nextTime)
    )
    :effect
    (and
      ; delete list: the robot is not moving, so we don't modify its position
      ; however, the timestep is increased
      (not (locatedAt ?currentCoordY ?currentCoordX ?currentTime))
      ; add list: timestep increased
      (locatedAt ?currentCoordY ?currentCoordX ?nextTime)
      ; cost of visiting one cell: 1
      (increase (cost) 1)
    )
)

)