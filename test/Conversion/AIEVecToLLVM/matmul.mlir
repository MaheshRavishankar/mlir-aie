// RUN: aie-opt %s -split-input-file -convert-aievec-to-llvm | FileCheck %s

func.func @matmul(%A : vector<4x8xbf16>, %B : vector<8x4xbf16>,
                  %C : vector<4x4xf32>) -> vector<4x4xf32> {
  %0 = aievec.matmul %A, %B, %C : vector<4x8xbf16>, vector<8x4xbf16>
                                  into vector<4x4xf32>
  return %0 : vector<4x4xf32>
}

// CHECK-LABEL: llvm.func @llvm.aie2.bf.mac16.conf(vector<32xbf16>,
// CHECK-SAME:  vector<32xbf16>, vector<16xf32>, i32) -> vector<16xf32>
// CHECK-LABEL: @matmul
// CHECK-SAME: %[[A:.*]]: vector<4x8xbf16>
// CHECK-SAME: %[[B:.*]]: vector<8x4xbf16>
// CHECK-SAME: %[[C:.*]]: vector<4x4xf32>
// CHECK:      %[[FA:.*]] = vector.shape_cast %[[A]] :
// CHECK-SAME:                      vector<4x8xbf16> to vector<32xbf16>
// CHECK:      %[[FB:.*]] = vector.shape_cast %[[B]] :
// CHECK-SAME:                      vector<8x4xbf16> to vector<32xbf16>
// CHECK:      %[[FC:.*]] = vector.shape_cast %[[C]] :
// CHECK-SAME:                      vector<4x4xf32> to vector<16xf32>
// CHECK:      %[[CONF:.*]] = arith.constant 28 : i32
// CHECK:      %[[FR:.*]] = llvm.call @llvm.aie2.bf.mac16.conf(
// CHECK-SAME:         %[[FA]], %[[FB]], %[[FC]], %[[CONF]]) :
// CHECK-SAME:         (vector<32xbf16>, vector<32xbf16>, vector<16xf32>, i32)
// CHECK-SAME:         -> vector<16xf32>
// CHECK:      %[[R:.*]] = vector.shape_cast %[[FR]] :
// CHECK-SAME:                      vector<16xf32> to vector<4x4xf32>
// CHECK:      return %[[R]] : vector<4x4xf32>

// -----

func.func @matmul(%A : vector<4x8xi8>, %B : vector<8x8xi8>,
                  %C : vector<4x8xi32>) -> vector<4x8xi32> {
  %0 = aievec.matmul %A, %B, %C : vector<4x8xi8>, vector<8x8xi8>
                                  into vector<4x8xi32>
  return %0 : vector<4x8xi32>
}

// CHECK-LABEL: llvm.func @llvm.aie2.i512.i512.acc1024.acc32.mac.conf(
// CHECK-SAME:    vector<32xi8>, vector<64xi8>, vector<32xi32>, i32)
// CHECK-SAME:      -> vector<32xi32>
// CHECK-LABEL: @matmul
// CHECK-SAME: %[[A:.*]]: vector<4x8xi8>
// CHECK-SAME: %[[B:.*]]: vector<8x8xi8>
// CHECK-SAME: %[[C:.*]]: vector<4x8xi32>
// CHECK:      %[[FA:.*]] = vector.shape_cast %[[A]] :
// CHECK-SAME:                      vector<4x8xi8> to vector<32xi8>
// CHECK:      %[[FB:.*]] = vector.shape_cast %[[B]] :
// CHECK-SAME:                      vector<8x8xi8> to vector<64xi8>
// CHECK:      %[[FC:.*]] = vector.shape_cast %[[C]] :
// CHECK-SAME:                      vector<4x8xi32> to vector<32xi32>
// CHECK:      %[[CONF:.*]] = arith.constant 776 : i32
// CHECK:      %[[FR:.*]] =
// CHECK-SAME:         llvm.call @llvm.aie2.i512.i512.acc1024.acc32.mac.conf(
// CHECK-SAME:           %[[FA]], %[[FB]], %[[FC]], %[[CONF]]) :
// CHECK-SAME:           (vector<32xi8>, vector<64xi8>, vector<32xi32>, i32)
// CHECK-SAME:           -> vector<32xi32>
// CHECK:      %[[R:.*]] = vector.shape_cast %[[FR]] :
// CHECK-SAME:                      vector<32xi32> to vector<4x8xi32>
// CHECK:      return %[[R]] : vector<4x8xi32>

// -----

func.func @matmul(%A : vector<4x2xi32>, %B : vector<2x4xi16>,
                  %C : vector<4x4xi64>) -> vector<4x4xi64> {
  %0 = aievec.matmul %A, %B, %C : vector<4x2xi32>, vector<2x4xi16>
                                  into vector<4x4xi64>
  return %0 : vector<4x4xi64>
}

// CHECK-LABEL: llvm.func @llvm.aie2.i512.i512.acc1024.acc64.mac.conf(
// CHECK-SAME:    vector<8xi32>, vector<8xi16>, vector<16xi64>, i32)
// CHECK-SAME:      -> vector<16xi64>
// CHECK-LABEL: @matmul
// CHECK-SAME: %[[A:.*]]: vector<4x2xi32>
// CHECK-SAME: %[[B:.*]]: vector<2x4xi16>
// CHECK-SAME: %[[C:.*]]: vector<4x4xi64>
// CHECK:      %[[FA:.*]] = vector.shape_cast %[[A]] :
// CHECK-SAME:                      vector<4x2xi32> to vector<8xi32>
// CHECK:      %[[FB:.*]] = vector.shape_cast %[[B]] :
// CHECK-SAME:                      vector<2x4xi16> to vector<8xi16>
// CHECK:      %[[FC:.*]] = vector.shape_cast %[[C]] :
// CHECK-SAME:                      vector<4x4xi64> to vector<16xi64>
// CHECK:      %[[CONF:.*]] = arith.constant 770 : i32
// CHECK:      %[[FR:.*]] =
// CHECK-SAME:         llvm.call @llvm.aie2.i512.i512.acc1024.acc64.mac.conf(
// CHECK-SAME:           %[[FA]], %[[FB]], %[[FC]], %[[CONF]]) :
// CHECK-SAME:           (vector<8xi32>, vector<8xi16>, vector<16xi64>, i32)
// CHECK-SAME:           -> vector<16xi64>
// CHECK:      %[[R:.*]] = vector.shape_cast %[[FR]] :
// CHECK-SAME:                      vector<16xi64> to vector<4x4xi64>
// CHECK:      return %[[R]] : vector<4x4xi64>
