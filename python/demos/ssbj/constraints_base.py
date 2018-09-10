# -*- coding: utf-8 -*-
"""
  constraints_base.py generated by WhatsOpt. 
"""
# DO NOT EDIT unless you know what you are doing
# analysis_id: 124

import numpy as np
from openmdao.api import ExplicitComponent

class ConstraintsBase(ExplicitComponent):
    """ An OpenMDAO base component to encapsulate Constraints discipline """

    
    def setup(self):
		
        self.add_input('DT', val=np.ones((1,)), desc='')
        self.add_input('ESF', val=np.ones((1,)), desc='')
        self.add_input('Temp', val=np.ones((1,)), desc='')
        self.add_input('Theta', val=np.ones((1,)), desc='')
        self.add_input('dpdx', val=np.ones((1,)), desc='')
        self.add_input('sigma', val=np.ones((5,)), desc='')
		
        self.add_output('con1_esf', val=1.0, desc='')
        self.add_output('con2_esf', val=1.0, desc='')
        self.add_output('con_dpdx', val=1.0, desc='')
        self.add_output('con_dt', val=1.0, desc='')
        self.add_output('con_sigma1', val=1.0, desc='')
        self.add_output('con_sigma2', val=1.0, desc='')
        self.add_output('con_sigma3', val=1.0, desc='')
        self.add_output('con_sigma4', val=1.0, desc='')
        self.add_output('con_sigma5', val=1.0, desc='')
        self.add_output('con_temp', val=1.0, desc='')
        self.add_output('con_theta_low', val=1.0, desc='')
        self.add_output('con_theta_up', val=1.0, desc='')
	

        