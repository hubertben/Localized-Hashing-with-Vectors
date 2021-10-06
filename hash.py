import math
import random

total_size = 1000

class Vector:

    def __init__(self, components, id = -1):
        self.components = components
        self.length = math.sqrt(sum([x*x for x in components]))
        self.ID = id
    
    def __repr__(self):
        return str(self.ID)
     
    def normalized(self):
        return [x / self.length for x in self.components]

    def dot(self, vector):
        return sum([self.components[i] * vector.components[i] for i in range(len(self.components))])

    def angle(self, vector):
        return self.dot(vector) / (self.length * vector.length)


def hash(v1, anchor):
    ang = math.trunc(v1.angle(anchor) * total_size)
    try:
        hash_table[ang].append(v1)
    except:
        hash_table[ang] = [v1]
    
def random_num():
    return (random.random() * 2) - 1

hash_table = {}
anchor = Vector([random_num(), random_num(), random_num()])

vectors = []
for i in range(1000):
    hash(Vector([random_num(), random_num(), random_num()], i), anchor)

print('Items, farthest to closest, from the Anchor Vector')
for k, v in sorted(hash_table.items()):
    print(k, v)

print('Anchor Vector:', anchor.components)
print('Closest to the Anchor Vector:', list( sorted(hash_table.items()))[-1][1][0].components)
print('Farthest from the Anchor Vector:', list( sorted(hash_table.items()))[0][1][0].components)