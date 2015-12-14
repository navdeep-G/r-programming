######   complex numbers

a = complex( real = 3, imaginary = 5)
print(a)

#    The main functions for complex numbers are capitalized
b = Conj(a)
print(b)
r = Mod(a)
print(r)
a.arg = Arg(a)
b.arg = Arg(b)
print(a.arg)
print(b.arg)
a.re  = Re(a)
a.im  =Im(a) 
sprintf("real part = %4.2f  imag part = %4.2f",a.re,a.im)
print(is.complex(a)) # yes  
print(is.numeric(a)) # no
print(a*b)
print(r^2)

v.c = complex(4)  # this is similar to numeric(4), but elements are complex
print(v.c)

v.c = complex( re = c(2,7), im = c(5.-1)) # can use re and im
print(v.c)

### or
v.c = complex( mod = c(25,7), arg = c(pi/4,2*pi/3) )
print(v.c)

ang = (0:2)*(2*pi)/3
r   = rep(1,3)
z.cube.root = complex( mod = r, arg = ang)
print(z.cube.root)
print(z.cube.root^3)

ang = (0:6)*(2*pi)/7
r   = rep(1,7)
z.seventh.root = complex( mod = r, arg = ang)
print(z.seventh.root)
print(z.seventh.root^7)
dev.new()
plot(z.seventh.root);abline(h=0);abline(v=0)

# complex multiplication rule: multiply Mod and add Arg
z1 = complex( mod = 2, arg = 0.5 )
z2 = complex( mod = 3, arg = 1.0 )
print(Mod(z1*z2))
print(Arg(z1*z2))

print(z1)
z1.sqroot = z1^(0.5)  # returns one of the square roots
print(Mod(z1.sqroot))
print(Arg(z1.sqroot))
#  the other square root has same Mod but Ang is pi more (or pi less)
#  the same strategy can get the other cube roots, fourth roots, etc.
#  Mod remains the same, and angle increases by multiple of  2pi/n
z.other = complex( mod = Mod(z1.sqroot), arg = Arg(z1.sqroot)+pi )
dev.new()
plot(z1, col = 'red', xlim = c(-2,2), ylim = c(-2,2))
points(z1.sqroot, col = 'blue')
points(z.other, col = 'green')
abline(v=0);abline(h=0)
print(z.other^2) 




