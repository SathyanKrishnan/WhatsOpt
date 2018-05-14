# -*- coding: utf-8 -*-
"""
  sap_aero_base.py generated by WhatsOpt. 
"""
# DO NOT EDIT unless you know what you are doing
# analysis_id: 47

import numpy as np
from openmdao.api import ExplicitComponent

class SapAeroBase(ExplicitComponent):
    """ An OpenMDAO base component to encapsulate SapAero discipline """

    def setup(self):
		
        self.add_input('ESF', val=1.0, desc='')
        self.add_input('Theta', val=1.0, desc='')
        self.add_input('WT', val=1.0, desc='')
        self.add_input('x_aer', val=1.0, desc='')
        self.add_input('z', val=np.ones((6,)), desc='')
		
        self.add_output('fin', val=1.0, desc='')
        self.add_output('dpdx', val=1.0, desc='')
        self.add_output('D', val=1.0, desc='')
        self.add_output('L', val=1.0, desc='')
		

        