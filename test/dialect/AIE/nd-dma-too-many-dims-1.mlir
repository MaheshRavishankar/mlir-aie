//===- aie.mlir ------------------------------------------------*- MLIR -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// Copyright (C) 2023, Advanced Micro Devices, Inc.
//
//===----------------------------------------------------------------------===//

// RUN: aie-opt --verify-diagnostics %s

module @tutorial_2b {
    
    AIE.device(xcve2802) {
        %tile31 = AIE.tile(3, 1)

        %buf31 = AIE.buffer(%tile31) { sym_name = "buf31" } : memref<128xi32>

        %mem31 = AIE.memTileDMA(%tile31) {
          %srcDma = AIE.dmaStart("MM2S", 0, ^bd0, ^end)
          ^bd0:
            //expected-error@+1 {{Cannot give more than 4 dimensions}}
            AIE.dmaBd(<%buf31 : memref<128xi32>, 0, 128>, 0, [<1, 1>, <1, 1>, <1, 1>, <1, 1>, <1, 1>])
            AIE.nextBd ^end
          ^end: 
            AIE.end
        }

    }
}