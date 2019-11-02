import sys
import collections
import random

nums2names = ['zero', 'one', 'two', 'three', 'four', 'five', 'six']
Pos = collections.namedtuple('Pos', 'x y t')

def usage():
    print('USAGE FOR PRE-DEFINED BOARDS: python3.6 <problem_name> robot <x> <y> target <x> <y> [x1, y1] > <problem_name>.pddl')
    print('with x, y in [0-3]')
    print('USAGE FOR RANDOM BOARDS: python3.6 <problem_name> random <seed> <n_steps> > <problem_name>.pddl')



def random_non_equal_pairs(n=2, start=0, end=3, seed=0):
    random.seed(seed)
    pairs = []
    for i in range(0, n):
        pair = random.randint(start, end), random.randint(start, end)
        while pair in pairs:
            pair = random.randint(start, end), random.randint(start, end)
        pairs.append(pair)
    return pairs

def random_consecutive_coords(start, n=6, seed=0):
    random.seed(seed)
    trajectory = [Pos(nums2names[start.x], nums2names[start.y], nums2names[start.t])]
    current_x = start.x
    current_y = start.y
    for i in range(n):
        moved = False
        while not moved:
            mov = random.randint(0,4)
            if mov == 0: # left
                if current_x > 0:
                    current_x = current_x - 1
                    moved = True
                else:
                    continue
            if mov == 1: # right
                if current_x < 3:
                    current_x = current_x + 1
                    moved = True
                else:
                    continue
            if mov == 2: # up
                if current_y > 0:
                    current_y = current_y - 1
                    moved = True
                else:
                    continue
            if mov == 3: # down
                if current_y < 3:
                    current_y = current_y + 1
                    moved = True
                else:
                    continue
            if mov == 4: # stay
                moved = True
        trajectory.append(Pos(nums2names[current_x], nums2names[current_y], nums2names[i]))
    return trajectory

def main():
    try:
        problem_name = sys.argv[1]
        if sys.argv[2] == 'random':
            [robot, target] = list(map(lambda coords: Pos(coords[0], coords[1], 0), random_non_equal_pairs(seed=int(sys.argv[3]))))
            if int(sys.argv[4]) > 7 or int(sys.argv[4]) < 1:
                sys.exit()
            trajectory = random_consecutive_coords(start=target, n=int(sys.argv[4]), seed=int(sys.argv[3]))
            
        else:
            args = sys.argv[2:]
            if args[0] != 'robot':
                sys.exit()
            robot = Pos(nums2names[int(args[1])], nums2names[int(args[2])], 'zero')
            if args[3] != 'target':
                sys.exit()
            target = Pos(nums2names[int(args[4])], nums2names[int(args[5])], 'zero')
            trajectory = [target]
            for index, x in enumerate(args[6:]):
                if index % 2 == 0:
                    trajectory.append(Pos(nums2names[int(x)], nums2names[int(args[6+index+1])], nums2names[index+1]))
        robot = Pos(nums2names[robot.x], nums2names[robot.y], nums2names[robot.t])
        trajectory_preds = f'(locatedAt {trajectory[0].x} {trajectory[0].y} {trajectory[0].t})\n'
        for coords in trajectory[1:]:
            trajectory_preds += f'    (locatedAt {coords.x} {coords.y} {coords.t})\n'

    except BaseException as e:
        print(e)
        usage()
        exit()

    PROBLEM_TEMPLATE =\
f'''(define (problem {problem_name}) (:domain moving_target)
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

    (locatedAt {robot.x} {robot.y} {robot.t})

    (= (cost) 0)
)

(:goal (or
    {trajectory_preds}
))

(:metric 
    minimize (cost)
)

)'''

    print(PROBLEM_TEMPLATE)


if __name__ == '__main__':
    main()
