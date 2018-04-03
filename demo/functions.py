# -*- coding: utf-8 -*-
"""
  functions.py generated by WhatsOpt. 
"""
from functions_base import FunctionsBase
from math import exp

class Functions(FunctionsBase):
    """ An OpenMDAO component to encapsulate Functions discipline """
		
    def compute(self, inputs, outputs):
        """ Functions computation """
        
        z = inputs['z']
        x = inputs['x']
        y1 = inputs['y1']
        y2 = inputs['y2']

        outputs['obj'] = x**2 + z[1] + y1 + exp(-y2)
        outputs['g1'] = 3.16 - y1
        outputs['g2'] = y2 - 24.0
				
        
