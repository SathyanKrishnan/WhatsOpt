# -*- coding: utf-8 -*-
"""
  con_sigma2_base.py generated by WhatsOpt. 
"""
# DO NOT EDIT unless you know what you are doing
# analysis_id: 47

import numpy as np
from openmdao.api import ExplicitComponent

class ConSigma2Base(ExplicitComponent):
    """ An OpenMDAO base component to encapsulate ConSigma2 discipline """

    def setup(self):
		
        self.add_input('sigma', val=np.ones((5,)), desc='')
		
        self.add_output('con_sigma2', val=1.0, desc='')
		

        