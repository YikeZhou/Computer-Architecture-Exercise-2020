import numpy as np
import matplotlib.pyplot as plt
 
x = np.linspace(0, 1, 100)
y = 1 / (1 - 0.875 * x)
 
plt.plot(x, y)

plt.xlabel('x')
plt.ylabel('s')
 
plt.show()
