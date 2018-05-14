# -*- coding: utf-8 -*-
"""
  con_sigma2.py generated by WhatsOpt. 
"""
from con_sigma2_base import ConSigma2Base

class ConSigma2(ConSigma2Base):
    """ An OpenMDAO component to encapsulate ConSigma2 discipline """
		
    def __init__(self, scalers):
    	super(ConSigma2, self).__init__()
        self.scalers=scalers
	
    def compute(self, inputs, outputs):
        """ ConSigma2 computation """
    
        outputs['con_sigma2'] = inputs['sigma'][1]*self.scalers['sigma'][1]-1.9  


	
# To declare partial derivatives computation ...
# 
#    def setup()
#        super(ConSigma2, self).setup()
#        declare_partials('*', '*')  
			
#    def compute_partials(self, inputs, partials):
#        """ Jacobian for ConSigma2 """
    
   		
#       	partials['con_sigma2', 'sigma'] = np.zeros((1, 5))        
