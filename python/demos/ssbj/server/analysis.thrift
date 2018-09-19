# -*- coding: utf-8 -*-
/*
  analysis.thrift generated by WhatsOpt. 
*/
namespace py ssbj

typedef double Float
typedef i32 Integer
typedef list<Float> Vector
typedef list<Integer> IVector
typedef list<Vector> Matrix
typedef list<IVector> IMatrix
typedef list<Matrix> Cube
typedef list<IMatrix> ICube

struct StructureInput {
    1: Vector L      
    2: Vector WE      
    3: Vector x_str      
    4: Vector z      
}

struct StructureOutput {
    1: Vector Theta     
    2: Vector sigma     
    3: Vector WT     
    4: Vector WF     
}
struct AerodynamicsInput {
    1: Vector ESF      
    2: Vector Theta      
    3: Vector WT      
    4: Vector x_aer      
    5: Vector z      
}

struct AerodynamicsOutput {
    1: Vector dpdx     
    2: Vector D     
    3: Vector L     
    4: Vector fin     
}
struct PropulsionInput {
    1: Vector D      
    2: Vector x_pro      
    3: Vector z      
}

struct PropulsionOutput {
    1: Vector DT     
    2: Vector ESF     
    3: Vector Temp     
    4: Vector WE     
    5: Vector SFC     
}
struct PerformanceInput {
    1: Vector SFC      
    2: Vector WF      
    3: Vector WT      
    4: Vector fin      
    5: Vector z      
}

struct PerformanceOutput {
    1: Float R     
}
struct ConstraintsInput {
    1: Vector DT      
    2: Vector ESF      
    3: Vector Temp      
    4: Vector Theta      
    5: Vector dpdx      
    6: Vector sigma      
}

struct ConstraintsOutput {
    1: Float con1_esf     
    2: Float con2_esf     
    3: Float con_dpdx     
    4: Float con_dt     
    5: Float con_sigma1     
    6: Float con_sigma2     
    7: Float con_sigma3     
    8: Float con_sigma4     
    9: Float con_sigma5     
    10: Float con_temp     
    11: Float con_theta_low     
    12: Float con_theta_up     
}

service Ssbj {
    StructureOutput compute_structure(1:StructureInput input)
    AerodynamicsOutput compute_aerodynamics(1:AerodynamicsInput input)
    PropulsionOutput compute_propulsion(1:PropulsionInput input)
    PerformanceOutput compute_performance(1:PerformanceInput input)
    ConstraintsOutput compute_constraints(1:ConstraintsInput input)

    void ping()
    oneway void shutdown()
}