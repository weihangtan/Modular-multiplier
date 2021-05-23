# High-Speed Modular Multiplier for Lattice-Based Cryptosystems (IEEE TCAS-II)

Authors: Weihang Tan, Benjamin Case, Antian Wang, Shuhong Gao and Yingjie Lao

Published in: IEEE Transactions on Circuits and Systems II: Express Briefs

Link of the paper: https://ieeexplore.ieee.org/document/9372338
# Abstract
Thanks to the inherent post-quantum resistant properties, lattice-based cryptography has gained increasing attention in various cryptographic applications recently. To facilitate the practical deployment, efficient hardware architectures are demanded to accelerate the operations and reduce the computational resources, especially for the polynomial multiplication, which is the bottleneck of lattice-based cryptosystems. In this brief, we present a novel high-speed modular multiplier architecture for polynomial multiplication. The proposed architecture employs a  divide  and  conquer  strategy  and  exploits a  special  modulus  to  increase  the  parallelism  and  speed up  the  calculation, while enabling wider applications across various cryptosystems.  The experimental results show that our design achieves around 27% and 39% reduction on the area consumption and delay, respectively, compared to prior works.

# Description
First, we need to use our  program to generate the prime that will satisfy the requirements in *Section.III.B*. Also, the specific bit-length need to be defined in range of v, which is shown below:

```python
for v in range(15,17):
```

If we want to generate the NTT-frendly primes, please define parameter `n = 1024` as well. 

For example, if we want a 32-bit prime, just simply define `range(15,17)`.

Then, based on the generated parameter v1 and v2, the parameters of the top-level module "km_rtl.v" in km_RTL file can be defined as below:

```verilog
parameter v = 16;
parameter v1 = 13;
parameter v2 = 12;
parameter Q = 32'd4294955009;//2^(2*16) - 2^13 - 2^12 + 1
```

#### 

# Citation
If you find our work useful, please consider citing our paper:

@article{tan2021high,
  title={High-Speed Modular Multiplier for Lattice-Based Cryptosystems},
  author={Tan, Weihang and Case, Benjamin M and Wang, Antian and Gao, Shuhong and Lao, Yingjie},
  journal={IEEE Transactions on Circuits and Systems II: Express Briefs},
  year={2021},
  publisher={IEEE}
}
