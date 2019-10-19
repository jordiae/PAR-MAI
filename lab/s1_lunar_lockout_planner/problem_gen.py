import sys
import collections

def usage():
    print('USAGE: python3.6 problem_name [craft x y] > problem_name.pddl')
    print('with craft in [red, green, purple, yellow, orange]')
    print('and x, y in [0-4]')
    print('All crafts must be defined')

def main():
    try:
        Pos = collections.namedtuple('Pos', 'x y')
        crafts = {}
        problem_name = sys.argv[1]
        args = sys.argv[2:]
        nums2names = ['zeroCoord', 'oneCoord', 'twoCoord', 'threeCoord', 'fourCoord']
        print(args)
        for index, arg in enumerate(args):
            if index % 3 == 0:
                crafts[arg] = Pos(nums2names[int(args[index+1])], \
                    nums2names[int(args[index+2])])
        redCraft, greenCraft, purpleCraft, yellowCraft, orangeCraft = \
            crafts['red'],crafts['green'], crafts['purple'], crafts['yellow'], crafts['orange']
    except BaseException as e:
        print(e)
        usage()
        exit()

    PROBLEM_TEMPLATE =\
f'''(define (problem {problem_name}) (:domain lunar_lockout)
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

    (locatedAt redCraft {redCraft.x} {redCraft.y})
    (locatedAt greenCraft {greenCraft.x} {greenCraft.y})
    (locatedAt purpleCraft {purpleCraft.x} {purpleCraft.y})
    (locatedAt yellowCraft {yellowCraft.x} {yellowCraft.y})
    (locatedAt orangeCraft {orangeCraft.x} {orangeCraft.y})
)

(:goal (and
    (locatedAt redCraft twoCoord twoCoord)
))
)'''

    print(PROBLEM_TEMPLATE)


if __name__ == '__main__':
    main()
