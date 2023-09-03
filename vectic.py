import math


class Vectic:
    """Vectic class
    """

    def __init__(self, x: int, y: int):
        """Vectic instance

        :param x: x component of vector
        :param y: y component of vector
        """
        self.x = x
        self.y = y

    def __add__(self, v: "Vectic"):
        return Vectic(v.x+self.x, v.y+self.y)

    def __iadd__(self, v: "Vectic"):
        self.x += v.x
        self.y += v.y
        return self

    def __sub__(self, v: "Vectic"):
        return Vectic(self.x-v.x, self.y-v.y)

    def __isub__(self, v: "Vectic"):
        self.x -= v.x
        self.y -= v.y
        return self

    def __mul__(self, s: int | float):
        return Vectic(self.x*s, self.y*s)

    def __imul__(self, s: int | float):
        self.x *= s
        self.y *= s
        return self

    def __repr__(self):
        return f"Vectic({self.x}, {self.y})"

    def __truediv__(self, s):
        if isinstance(s, Vectic):
            return Vectic(self.x/s.x, self.y/s.y)
        return Vectic(self.x/s, self.y/s)

    def __floordiv__(self, s):
        if isinstance(s, Vectic):
            return Vectic(self.x//s.x, self.y//s.y)
        return Vectic(self.x//s, self.y//s)

    def __floor__(self):
        return self//1

    def __len__(self):
        return self.norm()

    def __eq__(self, v: "Vectic"):
        return self.x == v.x and self.y == v.y

    def dist(self, v: "Vectic") -> float:
        """Distance between two vectors

        $\sqrt{(x_a-x_b)^2+(y_a-y_b)^2}$

        :param v: vector
        :return: float
        """
        return math.sqrt(self.dist2(v))

    def dist2(self, v: "Vectic"):
        """Distance between two vectors squared

        $(x_a-x_b)^2+(y_a-y_b)^2$

        :param v: vector
        :return: float
        """
        return (self.x-v.x)**2 + (self.y-v.y)**2

    def norm(self) -> float:
        """Vector norm

        $|v|$

        :return: float
        """
        return self.dist(Vectic.zero())

    def normalized(self) -> "Vectic":
        """Normalized vector

        $\frac{v}{|v|}$

        :return: vector
        """
        return self / self.norm()

    def rot(self, t: int | float) -> "Vectic":
        """Rotate vector by given amount (in radians)

        :param t: theta radians to rotate the vector by
        :return: rotated vector
        """
        return Vectic(self.x*math.cos(t)-self.x*math.sin(t), self.y*math.sin(t)+self.y*math.cos(t))

    def copy(self):
        return Vectic(self.x, self.y)

    def zero() -> float:
        """Zero vector

        :return: vector
        """
        return Vectic(0, 0)


if __name__ == '__main__':
    a = Vectic(1, 2)
    b = Vectic(2, 3)
    print(a+b)
    a += b
    print(a)
    print(b*1.5)
    print(a*2)
    print(isinstance(a, Vectic))
