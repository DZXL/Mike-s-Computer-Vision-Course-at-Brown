#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Sep 17 12:54:44 2023

@author: wxdycq
"""


import numpy as np


'''P1'''
def my_conv(image, Filter):
    # Get dimensions of the input image and kernel
    imgh, imgw = image.shape
    filterh, filterw = Filter.shape
    
    # Calculate the padding required for valid convolution
    padh = filterh // 2
    padw = filterw // 2
    
    # Initialize the output matrix with zeros
    ret = np.zeros_like(image)
    
    # Perform the convolution
    for i in range(imgh):
        for j in range(imgw):
            # Extract the region of the image that overlaps with the kernel
            con = image[max(i - padh, 0):min(i + padw + 1, imgh),
                           max(j - padw, 0):min(j + padw + 1, imgw)]
            
            # Ensure that the region and kernel have the same dimensions
            conh, conw = con.shape
            
            # Apply the kernel and sum the result
            if conh == filterh and conw == filterw:
                ret[i, j] = np.sum(con * Filter)
    
    return ret


