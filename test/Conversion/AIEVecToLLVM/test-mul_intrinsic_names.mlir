// RUN: aie-opt %s --convert-aievec-to-llvm | FileCheck %s
module {
  func.func @test() {
    %v32i16 = llvm.mlir.undef : vector<32xi16>
    %v16i16 = llvm.mlir.undef : vector<16xi16>
    %v64i8 = llvm.mlir.undef : vector<64xi8>
    %v32i8 = llvm.mlir.undef : vector<32xi8>
    %v8i48 = llvm.mlir.undef : vector<8xi48>
    %v16i32 = llvm.mlir.undef : vector<16xi32>
    %v8i32 = llvm.mlir.undef : vector<8xi32>
    %0 = aievec.mul %v32i16, %v16i16 : vector<32xi16>, vector<16xi16>, vector<16xi48>
    %1 = aievec.mul %v64i8, %v32i8 : vector<64xi8>, vector<32xi8>, vector<8xi48>
    %2 = aievec.mul %v16i32, %v8i32 : vector<16xi32>, vector<8xi32>, vector<8xi80>
    return
  }
}

// The function declarations are in reverse order of creation
// CHECK: llvm.func @llvm.aie.mul8.v16int32(vector<16xi32>, vector<8xi32>, i32, i32, i32, vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<8xi80>
// CHECK: llvm.func @llvm.aie.mul8.v64int8(vector<64xi8>, vector<32xi8>, i32, i32, i32, vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<8xi48>
// CHECK: llvm.func @llvm.aie.mul16.v32int16(vector<32xi16>, vector<16xi16>, i32, i32, i32, vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<16xi48>
