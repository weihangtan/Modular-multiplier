#!/usr/bin/env python
# coding: utf-8

# In[26]:


#!/usr/bin/python
#=====================================================================================
# Set the power of polynomial 
n=256;
def is_prime(n):
	#https://stackoverflow.com/questions/15285534/isprime-function-for-python-language
  if n == 2 or n == 3: return True
  if n < 2 or n%2 == 0: return False
  if n < 9: return True
  if n%3 == 0: return False
  r = int(n**0.5)
  f = 5
  while f <= r:    #print '\t',f
    if n%f == 0: return False
    if n%(f+2) == 0: return False
    f +=6
  return True 
def second_check(Q):
    temp=(Q-1)%(2*n)
    if temp==0:
        return True
    else:
        return False
      
#Set the range of v
for v in range(5,8):  
    #Case v1 and v2 
    for v1 in range(2,v-3+1):
        for v2 in range(1 , v1):
            Q = 2**(2*v) - 2**v1 + 2**v2 + 1      
            if is_prime(Q):
               # print(Q,(Q-1)/(2*n))
                if second_check(Q):
                    print("Q=2^(2*v) - 2^v1 + 2^v2 + 1", Q, bin(Q), "2v=",2*v,"v1=",v1,"v2=", v2, "NTT-Friendly")
                else:
                    print("Q=2^(2*v) - 2^v1 + 2^v2 + 1", Q, bin(Q), "2v=",2*v,"v1=",v1,"v2=", v2)
            Q = 2**(2*v) - 2**v1 + 2**v2 - 1
            if is_prime(Q):
               # print(Q,(Q-1)/(2*n))
                if is_prime(Q)&second_check(Q):
                    print("Q=2^(2*v) - 2^v1 + 2^v2 - 1", Q,  bin(Q), "2v=",2*v,"v1=",v1,"v2=", v2, "NTT-Friendly")
                else:
                    print("Q=2^(2*v) - 2^v1 + 2^v2 - 1", Q,  bin(Q), "2v=",2*v,"v1=",v1,"v2=", v2)        
            
    for v1 in range(2,v-2+1):
        for v2 in range(1 , v1):                    
            
            Q = 2**(2*v) - 2**v1 - 2**v2 - 1
            if is_prime(Q):
                #print(Q,(Q-1)/(2*n))
                if is_prime(Q)&second_check(Q):
                    print("Q=2^(2*v) - 2^v1 - 2^v2 - 1", Q,  bin(Q), "2v=",2*v,"v1=",v1,"v2=", v2, "NTT-Friendly")
                else:
                    print("Q=2^(2*v) - 2^v1 - 2^v2 - 1", Q,  bin(Q), "2v=",2*v,"v1=",v1,"v2=", v2)
            Q = 2**(2*v) - 2**v1 - 2**v2 + 1
            if is_prime(Q):
               # print(Q,(Q-1)/(2*n))
                if is_prime(Q)&second_check(Q):
                    print("Q=2^(2*v) - 2^v1 - 2^v2 + 1", Q,  bin(Q), "2v=",2*v,"v1=",v1,"v2=", v2, "NTT-Friendly")
                else:
                    print("Q=2^(2*v) - 2^v1 - 2^v2 + 1", Q,  bin(Q), "2v=",2*v,"v1=",v1,"v2=", v2)

                    
    #Case v1 only  
    for v1 in range(1,v-2+1):
        Q = 2**(2*v) - 2**v1  + 1
        if is_prime(Q):
            #print(Q,(Q-1)/(2*n))
            if is_prime(Q)&second_check(Q):
                print("Q = 2^(2*v) - 2^v1  + 1", Q,  bin(Q), "2v=",2*v,"v1=",v1, "NTT-Friendly")
            else:
                print("Q = 2^(2*v) - 2^v1  + 1", Q,  bin(Q), "2v=",2*v,"v1=",v1)
        Q = 2**(2*v) - 2**v1  - 1    
        if is_prime(Q):
           # print(Q,(Q-1)/(2*n))
            if is_prime(Q)&second_check(Q):
                print("Q = 2^(2*v) - 2^v1  - 1", Q,  bin(Q), "2v=",2*v,"v1=",v1, "NTT-Friendly")
            else:
                print("Q = 2^(2*v) - 2^v1  - 1", Q,  bin(Q), "2v=",2*v,"v1=",v1)







