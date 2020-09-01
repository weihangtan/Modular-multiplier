# Modular-multiplier
First, we need to use our  program to generate the prime that will satisfy the requirements in *Section.III.B*. Also, the specific bit-length need to be defined in range of $v$, which is shown below:

```python
for v in range(11,13):
```

If we want to generate the NTT-frendly primes, please define parameter `n = 1024` as well. 

For example, if we want a $32$-bit prime, just simply define `range(15,17)`.

Then, based on the generated parameter $v1$ and $v2$, the parameters in the top-level module "km_rtl.v" can be defined as below:

```verilog
parameter v = 16;
parameter v1 = 13;
parameter v2 = 12;
parameter Q = 32'd4294955009;//2^(2*16) - 2^13 - 2^12 + 1
```

#### 
