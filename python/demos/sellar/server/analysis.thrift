# -*- coding: utf-8 -*-
/*
  analysis.thrift generated by WhatsOpt. 
*/
namespace py sellar

typedef double Float
typedef i32 Integer
typedef list<Float> Vector
typedef list<Integer> IVector
typedef list<Vector> Matrix
typedef list<IVector> IMatrix
typedef list<Matrix> Cube
typedef list<IMatrix> ICube

struct Disc1Input {
    1: Float x      
    2: Float y2      
    3: Vector z      
}

struct Disc1Output {
    1: Float y1     
}
struct Disc2Input {
    1: Vector z      
    2: Float y1      
}

struct Disc2Output {
    1: Float y2     
}
struct FunctionsInput {
    1: Float y2      
    2: Float y1      
    3: Float x      
    4: Vector z      
}

struct FunctionsOutput {
    1: Float obj     
    2: Float g1     
    3: Float g2     
}

service Sellar {
    Disc1Output compute_disc1(1:Disc1Input input)
    Disc2Output compute_disc2(1:Disc2Input input)
    FunctionsOutput compute_functions(1:FunctionsInput input)

    void ping()
    oneway void shutdown()
}