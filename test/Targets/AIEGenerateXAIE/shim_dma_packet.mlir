//===- shim_dma_packet.mlir ------------------------------------*- MLIR -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// (c) Copyright 2021 Xilinx Inc.
//
//===----------------------------------------------------------------------===//

// RUN: aie-translate --aie-generate-xaie %s | FileCheck %s

// CHECK-LABEL: int mlir_aie_configure_shimdma_70(aie_libxaie_ctx_t* ctx) {
// CHECK: XAie_DmaDesc dma_tile70_bd0;
// CHECK: XAie_DmaDescInit(&(ctx->DevInst), &(dma_tile70_bd0), XAie_TileLoc(7,0))
// CHECK: XAie_DmaSetLock(&(dma_tile70_bd0), XAie_LockInit(0,1),XAie_LockInit(0,0))
// CHECK: XAie_DmaSetAddrLen(&(dma_tile70_bd0), /* addrA */ mlir_aie_external_get_addr_myBuffer_70_0(),  /* len */ 1024 * 4)
// CHECK: XAie_DmaSetAxi(&(dma_tile70_bd0), /* smid */ 0, /* burstlen */ 4, /* QoS */ 0, /* Cache */ 0, /* Secure */ XAIE_ENABLE)
// CHECK: XAie_DmaSetNextBd(&(dma_tile70_bd0),  /* nextbd */ 0,  /* enableNextBd */ 1)
// CHECK: XAie_DmaSetPkt(&(dma_tile70_bd0), XAie_PacketInit(2,0))
// CHECK: XAie_DmaEnableBd(&(dma_tile70_bd0))
// CHECK: XAie_DmaWriteBd(&(ctx->DevInst), &(dma_tile70_bd0), XAie_TileLoc(7,0),  /* bd */ 0)
// CHECK: XAie_DmaChannelPushBdToQueue(&(ctx->DevInst), XAie_TileLoc(7,0), /* ChNum */0, /* dmaDir */ DMA_MM2S, /* BdNum */0)
// CHECK: XAie_DmaChannelEnable(&(ctx->DevInst), XAie_TileLoc(7,0), /* ChNum */ 0, /* dmaDir */ DMA_MM2S)


module {
 AIE.device(xcvc1902) {
  %buf = AIE.external_buffer { sym_name = "buf" } : memref<32x32xi32>

  %tile70 = AIE.tile(7, 0)
  %lock70 = AIE.lock(%tile70, 0)

  %shimdma70 = AIE.shimDMA(%tile70)  {
    AIE.dmaStart(MM2S, 0, ^bb1, ^bb2)
  ^bb1:  // 2 preds: ^bb0, ^bb1
    AIE.useLock(%lock70, Acquire, 1)
    AIE.dmaBdPacket(0, 2)
    AIE.dmaBd(<%buf : memref<32x32xi32>, 0, 1024>, 0)
    AIE.useLock(%lock70, Release, 0)
    AIE.nextBd ^bb1
  ^bb2:  // pred: ^bb0
    AIE.end
  }
 }
}
