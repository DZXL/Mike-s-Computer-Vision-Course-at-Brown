#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 18 20:34:41 2023

@author: wxdycq
"""

from P1 import my_conv
import numpy as np
import cv2
import matplotlib.pyplot as plt


'''P2'''


''''Smoothing Filters'''
# Read the image
lenna = cv2.imread('figures/Lenna.png')
lenna=cv2.cvtColor(lenna, cv2.COLOR_BGR2GRAY)

traffic = cv2.imread('figures/traffic.jpg')
traffic=cv2.cvtColor(traffic, cv2.COLOR_BGR2GRAY)

#Define filters
bf= 1/9*np.array([[1,1,1],[1,1,1],[1,1,1]])
wbf=1/16*np.array([[1,2,1],[2,4,2],[1,2,1]])
hf=1/3*np.array([[0,0,0],[1,1,1],[0,0,0]])
vf=1/3*np.array([[0,1,0],[0,1,0],[0,1,0]])
csf=1/5*np.array([[0,1,0],[1,1,1],[0,1,0]])
bf55=1/25*np.array([[1,1,1,1,1],[1,1,1,1,1],[1,1,1,1,1],[1,1,1,1,1],[1,1,1,1,1]])
csf55=1/25*np.array([[0,1,1,1,0],[1,1,1,1,1],[1,1,1,1,1],[1,1,1,1,1],[0,1,1,1,0]])

#bf
bf_lenna=my_conv(lenna, bf)
plt.subplot(2, 2, 1)
plt.imshow(lenna,cmap='gray')
plt.title('Lenna')
plt.subplot(2, 2, 2)
plt.imshow(bf_lenna,cmap='gray')
plt.title('bf_Lenna')

bf_traffic=my_conv(traffic, bf)
plt.subplot(2, 2, 3)
plt.imshow(traffic,cmap='gray')
plt.title('traffic')
plt.subplot(2, 2, 4)
plt.imshow(bf_traffic,cmap='gray')
plt.title('bf_traffic')

plt.tight_layout()
plt.show()

#wbf
wbf_lenna=my_conv(lenna,wbf )
plt.subplot(2, 2, 1)
plt.imshow(lenna,cmap='gray')
plt.title('Lenna')
plt.subplot(2, 2, 2)
plt.imshow(wbf_lenna,cmap='gray')
plt.title('wbf_Lenna')

wbf_traffic=my_conv(traffic, wbf)
plt.subplot(2, 2, 3)
plt.imshow(traffic,cmap='gray')
plt.title('traffic')
plt.subplot(2, 2, 4)
plt.imshow(wbf_traffic,cmap='gray')
plt.title('wbf_traffic')

plt.tight_layout()
plt.show()

#hf
hf_lenna=my_conv(lenna,hf )
plt.subplot(2, 2, 1)
plt.imshow(lenna,cmap='gray')
plt.title('Lenna')
plt.subplot(2, 2, 2)
plt.imshow(hf_lenna,cmap='gray')
plt.title('hf_Lenna')

hf_traffic=my_conv(traffic, hf)
plt.subplot(2, 2, 3)
plt.imshow(traffic,cmap='gray')
plt.title('traffic')
plt.subplot(2, 2, 4)
plt.imshow(hf_traffic,cmap='gray')
plt.title('hf_traffic')

plt.tight_layout()
plt.show()

#vf
vf_lenna=my_conv(lenna, vf)
plt.subplot(2, 2, 1)
plt.imshow(lenna,cmap='gray')
plt.title('Lenna')
plt.subplot(2, 2, 2)
plt.imshow(vf_lenna,cmap='gray')
plt.title('vf_Lenna')

vf_traffic=my_conv(traffic, vf)
plt.subplot(2, 2, 3)
plt.imshow(traffic,cmap='gray')
plt.title('traffic')
plt.subplot(2, 2, 4)
plt.imshow(vf_traffic,cmap='gray')
plt.title('vf_traffic')

plt.tight_layout()
plt.show()

#csf
csf_lenna=my_conv(lenna,csf )
plt.subplot(2, 2, 1)
plt.imshow(lenna,cmap='gray')
plt.title('Lenna')
plt.subplot(2, 2, 2)
plt.imshow(csf_lenna,cmap='gray')
plt.title('csf_Lenna')

csf_traffic=my_conv(traffic,csf )
plt.subplot(2, 2, 3)
plt.imshow(traffic,cmap='gray')
plt.title('traffic')
plt.subplot(2, 2, 4)
plt.imshow(csf_traffic,cmap='gray')
plt.title('csf_traffic')

plt.tight_layout()
plt.show()

#bf55
bf55_lenna=my_conv(lenna,bf55 )
plt.subplot(2, 2, 1)
plt.imshow(lenna,cmap='gray')
plt.title('Lenna')
plt.subplot(2, 2, 2)
plt.imshow(bf55_lenna,cmap='gray')
plt.title('bf55_Lenna')

bf55_traffic=my_conv(traffic, bf55)
plt.subplot(2, 2, 3)
plt.imshow(traffic,cmap='gray')
plt.title('traffic')
plt.subplot(2, 2, 4)
plt.imshow(bf55_traffic,cmap='gray')
plt.title('bf55_traffic')

plt.tight_layout()
plt.show()

#csf55
csf55_lenna=my_conv(lenna,csf55 )
plt.subplot(2, 2, 1)
plt.imshow(lenna,cmap='gray')
plt.title('Lenna')
plt.subplot(2, 2, 2)
plt.imshow(csf55_lenna,cmap='gray')
plt.title('csf55_Lenna')

csf55_traffic=my_conv(traffic, csf55)
plt.subplot(2, 2, 3)
plt.imshow(traffic,cmap='gray')
plt.title('traffic')
plt.subplot(2, 2, 4)
plt.imshow(csf55_traffic,cmap='gray')
plt.title('csf55_traffic')

plt.tight_layout()
plt.show()


''''Enhancment Filters'''
IA = cv2.imread('figures/ImageA.jpg')
IA=cv2.cvtColor(IA, cv2.COLOR_BGR2GRAY)

IB = cv2.imread('figures/ImageB.jpg')
IB=cv2.cvtColor(IB, cv2.COLOR_BGR2GRAY)

la44=1/16*np.array([[0,1,0],[1,-4,1],[0,1,0]])
la88=1/16*np.array([[1,1,1],[1,-8,1],[1,1,1]])
#4 × 4 Laplacian 
la44_IA=my_conv(IA,la44 )
plt.subplot(2, 2, 1)
plt.imshow(IA,cmap='gray')
plt.title('IA')
plt.subplot(2, 2, 2)
plt.imshow(la44_IA,cmap='gray')
plt.title('la44_IA')

la44_IB=my_conv(IB, la44)
plt.subplot(2, 2, 3)
plt.imshow(IB,cmap='gray')
plt.title('IB')
plt.subplot(2, 2, 4)
plt.imshow(la44_IB,cmap='gray')
plt.title('la44_IB')

plt.tight_layout()
plt.show()

#8 × 8 Laplacian
la88_IA=my_conv(IA,la88 )
plt.subplot(2, 2, 1)
plt.imshow(IA,cmap='gray')
plt.title('IA')
plt.subplot(2, 2, 2)
plt.imshow(la88_IA,cmap='gray')
plt.title('la88_IA')

la88_IB=my_conv(IB,la88 )
plt.subplot(2, 2, 3)
plt.imshow(IB,cmap='gray')
plt.title('IB')
plt.subplot(2, 2, 4)
plt.imshow(la88_IB,cmap='gray')
plt.title('la88_IB')

plt.tight_layout()
plt.show()



'''Edge Filters'''
px=1/16*np.array([[1,0,-1],[1,0,-1],[1,0,-1]])
py=1/16*np.array([[1,1,1],[0,0,0],[-1,-1,-1]])
sx=1/16*np.array([[1,0,-1],[2,0,-2],[1,0,-1]])
sy=1/16*np.array([[1,2,1],[0,0,0],[-1,-2,-1]])
#Prewitt X 
px_IA=my_conv(IA,px )
plt.subplot(2, 2, 1)
plt.imshow(IA,cmap='gray')
plt.title('IA')
plt.subplot(2, 2, 2)
plt.imshow(px_IA,cmap='gray')
plt.title('px_IA')

px_IB=my_conv(IB, px)
plt.subplot(2, 2, 3)
plt.imshow(IB,cmap='gray')
plt.title('IB')
plt.subplot(2, 2, 4)
plt.imshow(px_IB,cmap='gray')
plt.title('px_IB')

plt.tight_layout()
plt.show()
#Prewitt Y 
py_IA=my_conv(IA, py)
plt.subplot(2, 2, 1)
plt.imshow(IA,cmap='gray')
plt.title('IA')
plt.subplot(2, 2, 2)
plt.imshow(py_IA,cmap='gray')
plt.title('py_IA')

py_IB=my_conv(IB, py)
plt.subplot(2, 2, 3)
plt.imshow(IB,cmap='gray')
plt.title('IB')
plt.subplot(2, 2, 4)
plt.imshow(py_IB,cmap='gray')
plt.title('py_IB')

plt.tight_layout()
plt.show()
#Sobel X 
sx_IA=my_conv(IA, sx)
plt.subplot(2, 2, 1)
plt.imshow(IA,cmap='gray')
plt.title('IA')
plt.subplot(2, 2, 2)
plt.imshow(sx_IA,cmap='gray')
plt.title('sx_IA')

sx_IB=my_conv(IB,sx )
plt.subplot(2, 2, 3)
plt.imshow(IB,cmap='gray')
plt.title('IB')
plt.subplot(2, 2, 4)
plt.imshow(sx_IB,cmap='gray')
plt.title('sx_IB')

plt.tight_layout()
plt.show()
#Sobel Y
sy_IA=my_conv(IA, sy)
plt.subplot(2, 2, 1)
plt.imshow(IA,cmap='gray')
plt.title('IA')
plt.subplot(2, 2, 2)
plt.imshow(sy_IA,cmap='gray')
plt.title('sy_IA')

sy_IB=my_conv(IB,sy )
plt.subplot(2, 2, 3)
plt.imshow(IB,cmap='gray')
plt.title('IB')
plt.subplot(2, 2, 4)
plt.imshow(sy_IB,cmap='gray')
plt.title('sy_IB')

plt.tight_layout()
plt.show()