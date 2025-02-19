//===- flow_test_3.mlir ----------------------------------------*- MLIR -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// (c) Copyright 2021 Xilinx Inc.
//
//===----------------------------------------------------------------------===//

// RUN: aie-opt --aie-create-pathfinder-flows %s | FileCheck %s

// CHECK-LABEL:   AIE.device(xcvc1902) {
// CHECK:           %[[VAL_0:.*]] = AIE.tile(0, 1)
// CHECK:           %[[VAL_1:.*]] = AIE.tile(0, 2)
// CHECK:           %[[VAL_2:.*]] = AIE.tile(0, 3)
// CHECK:           %[[VAL_3:.*]] = AIE.tile(0, 4)
// CHECK:           %[[VAL_4:.*]] = AIE.tile(1, 1)
// CHECK:           %[[VAL_5:.*]] = AIE.tile(1, 2)
// CHECK:           %[[VAL_6:.*]] = AIE.tile(1, 3)
// CHECK:           %[[VAL_7:.*]] = AIE.tile(1, 4)
// CHECK:           %[[VAL_8:.*]] = AIE.tile(2, 0)
// CHECK:           %[[VAL_9:.*]] = AIE.tile(2, 1)
// CHECK:           %[[VAL_10:.*]] = AIE.tile(2, 2)
// CHECK:           %[[VAL_11:.*]] = AIE.tile(2, 3)
// CHECK:           %[[VAL_12:.*]] = AIE.tile(2, 4)
// CHECK:           %[[VAL_13:.*]] = AIE.tile(3, 0)
// CHECK:           %[[VAL_14:.*]] = AIE.tile(7, 1)
// CHECK:           %[[VAL_15:.*]] = AIE.tile(7, 2)
// CHECK:           %[[VAL_16:.*]] = AIE.tile(7, 3)
// CHECK:           %[[VAL_17:.*]] = AIE.tile(7, 4)
// CHECK:           %[[VAL_18:.*]] = AIE.tile(8, 1)
// CHECK:           %[[VAL_19:.*]] = AIE.tile(8, 2)
// CHECK:           %[[VAL_20:.*]] = AIE.tile(8, 3)
// CHECK:           %[[VAL_21:.*]] = AIE.tile(8, 4)
// CHECK:           %[[VAL_22:.*]] = AIE.switchbox(%[[VAL_0]]) {
// CHECK:             AIE.connect<East : 0, North : 0>
// CHECK:             AIE.connect<East : 1, Core : 0>
// CHECK:             AIE.connect<Core : 0, East : 0>
// CHECK:             AIE.connect<East : 2, Core : 1>
// CHECK:             AIE.connect<Core : 1, East : 1>
// CHECK:           }
// CHECK:           %[[VAL_23:.*]] = AIE.switchbox(%[[VAL_1]]) {
// CHECK:             AIE.connect<South : 0, North : 0>
// CHECK:             AIE.connect<East : 0, Core : 1>
// CHECK:             AIE.connect<Core : 1, North : 1>
// CHECK:           }
// CHECK:           %[[VAL_24:.*]] = AIE.switchbox(%[[VAL_2]]) {
// CHECK:             AIE.connect<South : 0, DMA : 0>
// CHECK:             AIE.connect<Core : 0, East : 0>
// CHECK:             AIE.connect<South : 1, North : 0>
// CHECK:           }
// CHECK:           %[[VAL_25:.*]] = AIE.tile(1, 0)
// CHECK:           %[[VAL_26:.*]] = AIE.switchbox(%[[VAL_25]]) {
// CHECK:             AIE.connect<East : 0, North : 0>
// CHECK:           }
// CHECK:           %[[VAL_27:.*]] = AIE.switchbox(%[[VAL_4]]) {
// CHECK:             AIE.connect<South : 0, West : 0>
// CHECK:             AIE.connect<East : 0, Core : 0>
// CHECK:             AIE.connect<Core : 0, North : 0>
// CHECK:             AIE.connect<East : 1, North : 1>
// CHECK:             AIE.connect<North : 0, West : 1>
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<North : 1, West : 2>
// CHECK:             AIE.connect<West : 1, East : 1>
// CHECK:           }
// CHECK:           %[[VAL_28:.*]] = AIE.switchbox(%[[VAL_8]]) {
// CHECK:             AIE.connect<South : 3, West : 0>
// CHECK:             AIE.connect<North : 0, South : 2>
// CHECK:             AIE.connect<East : 0, North : 0>
// CHECK:             AIE.connect<South : 7, North : 1>
// CHECK:             AIE.connect<North : 1, South : 3>
// CHECK:           }
// CHECK:           %[[VAL_29:.*]] = AIE.shimmux(%[[VAL_8]]) {
// CHECK:             AIE.connect<DMA : 0, North : 3>
// CHECK:             AIE.connect<North : 2, DMA : 0>
// CHECK:             AIE.connect<DMA : 1, North : 7>
// CHECK:             AIE.connect<North : 3, DMA : 1>
// CHECK:           }
// CHECK:           %[[VAL_30:.*]] = AIE.switchbox(%[[VAL_6]]) {
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<South : 0, North : 0>
// CHECK:             AIE.connect<North : 0, South : 0>
// CHECK:             AIE.connect<East : 0, South : 1>
// CHECK:           }
// CHECK:           %[[VAL_31:.*]] = AIE.switchbox(%[[VAL_11]]) {
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<South : 0, North : 0>
// CHECK:             AIE.connect<North : 0, South : 0>
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:           }
// CHECK:           %[[VAL_32:.*]] = AIE.tile(3, 3)
// CHECK:           %[[VAL_33:.*]] = AIE.switchbox(%[[VAL_32]]) {
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<East : 0, South : 0>
// CHECK:             AIE.connect<East : 1, West : 0>
// CHECK:           }
// CHECK:           %[[VAL_34:.*]] = AIE.tile(4, 3)
// CHECK:           %[[VAL_35:.*]] = AIE.switchbox(%[[VAL_34]]) {
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<North : 0, South : 0>
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:             AIE.connect<South : 0, East : 1>
// CHECK:             AIE.connect<East : 1, West : 1>
// CHECK:             AIE.connect<North : 1, South : 1>
// CHECK:           }
// CHECK:           %[[VAL_36:.*]] = AIE.tile(5, 3)
// CHECK:           %[[VAL_37:.*]] = AIE.switchbox(%[[VAL_36]]) {
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:             AIE.connect<West : 1, East : 1>
// CHECK:             AIE.connect<South : 0, East : 2>
// CHECK:             AIE.connect<East : 1, West : 1>
// CHECK:           }
// CHECK:           %[[VAL_38:.*]] = AIE.tile(6, 3)
// CHECK:           %[[VAL_39:.*]] = AIE.switchbox(%[[VAL_38]]) {
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:             AIE.connect<West : 1, East : 1>
// CHECK:             AIE.connect<West : 2, East : 2>
// CHECK:             AIE.connect<East : 1, West : 1>
// CHECK:             AIE.connect<North : 0, South : 0>
// CHECK:           }
// CHECK:           %[[VAL_40:.*]] = AIE.switchbox(%[[VAL_14]]) {
// CHECK:             AIE.connect<North : 0, Core : 0>
// CHECK:             AIE.connect<Core : 0, North : 0>
// CHECK:             AIE.connect<West : 0, Core : 1>
// CHECK:             AIE.connect<Core : 1, North : 1>
// CHECK:           }
// CHECK:           %[[VAL_41:.*]] = AIE.switchbox(%[[VAL_15]]) {
// CHECK:             AIE.connect<North : 0, South : 0>
// CHECK:             AIE.connect<South : 0, East : 0>
// CHECK:             AIE.connect<West : 0, North : 0>
// CHECK:             AIE.connect<North : 1, East : 1>
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:             AIE.connect<West : 1, Core : 1>
// CHECK:             AIE.connect<Core : 1, West : 1>
// CHECK:             AIE.connect<South : 1, East : 2>
// CHECK:           }
// CHECK:           %[[VAL_42:.*]] = AIE.switchbox(%[[VAL_16]]) {
// CHECK:             AIE.connect<West : 0, South : 0>
// CHECK:             AIE.connect<South : 0, East : 0>
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:             AIE.connect<West : 1, Core : 0>
// CHECK:             AIE.connect<Core : 0, South : 1>
// CHECK:             AIE.connect<West : 2, East : 1>
// CHECK:             AIE.connect<East : 1, West : 1>
// CHECK:           }
// CHECK:           %[[VAL_43:.*]] = AIE.switchbox(%[[VAL_19]]) {
// CHECK:             AIE.connect<West : 0, North : 0>
// CHECK:             AIE.connect<West : 1, Core : 0>
// CHECK:             AIE.connect<DMA : 0, West : 0>
// CHECK:             AIE.connect<West : 2, North : 1>
// CHECK:           }
// CHECK:           %[[VAL_44:.*]] = AIE.switchbox(%[[VAL_20]]) {
// CHECK:             AIE.connect<South : 0, North : 0>
// CHECK:             AIE.connect<West : 0, Core : 0>
// CHECK:             AIE.connect<Core : 0, West : 0>
// CHECK:             AIE.connect<West : 1, DMA : 1>
// CHECK:             AIE.connect<Core : 1, West : 1>
// CHECK:             AIE.connect<South : 1, North : 1>
// CHECK:           }
// CHECK:           %[[VAL_45:.*]] = AIE.switchbox(%[[VAL_21]]) {
// CHECK:             AIE.connect<South : 0, Core : 0>
// CHECK:             AIE.connect<Core : 0, West : 0>
// CHECK:             AIE.connect<South : 1, Core : 1>
// CHECK:             AIE.connect<DMA : 1, West : 1>
// CHECK:           }
// CHECK:           %[[VAL_46:.*]] = AIE.switchbox(%[[VAL_9]]) {
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:             AIE.connect<North : 0, South : 0>
// CHECK:             AIE.connect<South : 0, West : 1>
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<East : 1, Core : 0>
// CHECK:             AIE.connect<Core : 0, East : 1>
// CHECK:             AIE.connect<South : 1, North : 0>
// CHECK:             AIE.connect<West : 1, East : 2>
// CHECK:             AIE.connect<East : 2, South : 1>
// CHECK:           }
// CHECK:           %[[VAL_47:.*]] = AIE.tile(3, 1)
// CHECK:           %[[VAL_48:.*]] = AIE.switchbox(%[[VAL_47]]) {
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<North : 0, West : 1>
// CHECK:             AIE.connect<West : 1, East : 1>
// CHECK:             AIE.connect<North : 1, South : 0>
// CHECK:             AIE.connect<West : 2, East : 2>
// CHECK:             AIE.connect<East : 1, West : 2>
// CHECK:           }
// CHECK:           %[[VAL_49:.*]] = AIE.tile(4, 1)
// CHECK:           %[[VAL_50:.*]] = AIE.switchbox(%[[VAL_49]]) {
// CHECK:             AIE.connect<North : 0, West : 0>
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<West : 1, North : 0>
// CHECK:             AIE.connect<West : 2, East : 1>
// CHECK:             AIE.connect<North : 1, West : 1>
// CHECK:           }
// CHECK:           %[[VAL_51:.*]] = AIE.tile(4, 2)
// CHECK:           %[[VAL_52:.*]] = AIE.switchbox(%[[VAL_51]]) {
// CHECK:             AIE.connect<North : 0, South : 0>
// CHECK:             AIE.connect<South : 0, North : 0>
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<East : 1, West : 1>
// CHECK:             AIE.connect<North : 1, South : 1>
// CHECK:           }
// CHECK:           %[[VAL_53:.*]] = AIE.tile(4, 4)
// CHECK:           %[[VAL_54:.*]] = AIE.switchbox(%[[VAL_53]]) {
// CHECK:             AIE.connect<East : 0, South : 0>
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<East : 1, South : 1>
// CHECK:           }
// CHECK:           %[[VAL_55:.*]] = AIE.tile(5, 4)
// CHECK:           %[[VAL_56:.*]] = AIE.switchbox(%[[VAL_55]]) {
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<East : 1, West : 1>
// CHECK:           }
// CHECK:           %[[VAL_57:.*]] = AIE.tile(6, 4)
// CHECK:           %[[VAL_58:.*]] = AIE.switchbox(%[[VAL_57]]) {
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:             AIE.connect<West : 0, South : 0>
// CHECK:             AIE.connect<East : 1, West : 1>
// CHECK:           }
// CHECK:           %[[VAL_59:.*]] = AIE.switchbox(%[[VAL_17]]) {
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:             AIE.connect<East : 1, West : 1>
// CHECK:           }
// CHECK:           %[[VAL_60:.*]] = AIE.switchbox(%[[VAL_5]]) {
// CHECK:             AIE.connect<South : 0, East : 0>
// CHECK:             AIE.connect<South : 1, North : 0>
// CHECK:             AIE.connect<North : 0, South : 0>
// CHECK:             AIE.connect<North : 1, South : 1>
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:           }
// CHECK:           %[[VAL_61:.*]] = AIE.switchbox(%[[VAL_10]]) {
// CHECK:             AIE.connect<West : 0, North : 0>
// CHECK:             AIE.connect<North : 0, South : 0>
// CHECK:             AIE.connect<South : 0, East : 0>
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:           }
// CHECK:           %[[VAL_62:.*]] = AIE.switchbox(%[[VAL_12]]) {
// CHECK:             AIE.connect<South : 0, Core : 0>
// CHECK:             AIE.connect<DMA : 0, South : 0>
// CHECK:             AIE.connect<West : 0, Core : 1>
// CHECK:             AIE.connect<Core : 1, East : 0>
// CHECK:           }
// CHECK:           %[[VAL_63:.*]] = AIE.switchbox(%[[VAL_7]]) {
// CHECK:             AIE.connect<South : 0, DMA : 0>
// CHECK:             AIE.connect<Core : 0, South : 0>
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:           }
// CHECK:           %[[VAL_64:.*]] = AIE.switchbox(%[[VAL_13]]) {
// CHECK:             AIE.connect<South : 3, West : 0>
// CHECK:             AIE.connect<North : 0, South : 2>
// CHECK:           }
// CHECK:           %[[VAL_65:.*]] = AIE.shimmux(%[[VAL_13]]) {
// CHECK:             AIE.connect<DMA : 0, North : 3>
// CHECK:             AIE.connect<North : 2, DMA : 0>
// CHECK:           }
// CHECK:           %[[VAL_66:.*]] = AIE.tile(5, 1)
// CHECK:           %[[VAL_67:.*]] = AIE.switchbox(%[[VAL_66]]) {
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<West : 1, East : 1>
// CHECK:           }
// CHECK:           %[[VAL_68:.*]] = AIE.tile(6, 1)
// CHECK:           %[[VAL_69:.*]] = AIE.switchbox(%[[VAL_68]]) {
// CHECK:             AIE.connect<West : 0, North : 0>
// CHECK:             AIE.connect<West : 1, North : 1>
// CHECK:             AIE.connect<North : 0, East : 0>
// CHECK:           }
// CHECK:           %[[VAL_70:.*]] = AIE.tile(6, 2)
// CHECK:           %[[VAL_71:.*]] = AIE.switchbox(%[[VAL_70]]) {
// CHECK:             AIE.connect<South : 0, East : 0>
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:             AIE.connect<South : 1, East : 1>
// CHECK:             AIE.connect<East : 1, West : 1>
// CHECK:             AIE.connect<North : 0, South : 0>
// CHECK:           }
// CHECK:           %[[VAL_72:.*]] = AIE.tile(3, 2)
// CHECK:           %[[VAL_73:.*]] = AIE.switchbox(%[[VAL_72]]) {
// CHECK:             AIE.connect<North : 0, South : 0>
// CHECK:             AIE.connect<East : 0, South : 1>
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:             AIE.connect<East : 1, West : 0>
// CHECK:           }
// CHECK:           %[[VAL_74:.*]] = AIE.tile(5, 2)
// CHECK:           %[[VAL_75:.*]] = AIE.switchbox(%[[VAL_74]]) {
// CHECK:             AIE.connect<East : 0, West : 0>
// CHECK:             AIE.connect<West : 0, North : 0>
// CHECK:             AIE.connect<East : 1, West : 1>
// CHECK:           }
// CHECK:           %[[VAL_76:.*]] = AIE.switchbox(%[[VAL_3]]) {
// CHECK:             AIE.connect<South : 0, East : 0>
// CHECK:           }
// CHECK:           %[[VAL_77:.*]] = AIE.tile(3, 4)
// CHECK:           %[[VAL_78:.*]] = AIE.switchbox(%[[VAL_77]]) {
// CHECK:             AIE.connect<West : 0, East : 0>
// CHECK:           }
// CHECK:           AIE.wire(%[[VAL_0]] : Core, %[[VAL_79:.*]] : Core)
// CHECK:           AIE.wire(%[[VAL_0]] : DMA, %[[VAL_79]] : DMA)
// CHECK:           AIE.wire(%[[VAL_1]] : Core, %[[VAL_80:.*]] : Core)
// CHECK:           AIE.wire(%[[VAL_1]] : DMA, %[[VAL_80]] : DMA)
// CHECK:           AIE.wire(%[[VAL_79]] : North, %[[VAL_80]] : South)
// CHECK:           AIE.wire(%[[VAL_2]] : Core, %[[VAL_81:.*]] : Core)
// CHECK:           AIE.wire(%[[VAL_2]] : DMA, %[[VAL_81]] : DMA)
// CHECK:           AIE.wire(%[[VAL_80]] : North, %[[VAL_81]] : South)
// CHECK:           AIE.wire(%[[VAL_3]] : Core, %[[VAL_82:.*]] : Core)
// CHECK:           AIE.wire(%[[VAL_3]] : DMA, %[[VAL_82]] : DMA)
// CHECK:           AIE.wire(%[[VAL_81]] : North, %[[VAL_82]] : South)
// CHECK:           AIE.wire(%[[VAL_79]] : East, %[[VAL_83:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_4]] : Core, %[[VAL_83]] : Core)
// CHECK:           AIE.wire(%[[VAL_4]] : DMA, %[[VAL_83]] : DMA)
// CHECK:           AIE.wire(%[[VAL_84:.*]] : North, %[[VAL_83]] : South)
// CHECK:           AIE.wire(%[[VAL_80]] : East, %[[VAL_85:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_5]] : Core, %[[VAL_85]] : Core)
// CHECK:           AIE.wire(%[[VAL_5]] : DMA, %[[VAL_85]] : DMA)
// CHECK:           AIE.wire(%[[VAL_83]] : North, %[[VAL_85]] : South)
// CHECK:           AIE.wire(%[[VAL_81]] : East, %[[VAL_86:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_6]] : Core, %[[VAL_86]] : Core)
// CHECK:           AIE.wire(%[[VAL_6]] : DMA, %[[VAL_86]] : DMA)
// CHECK:           AIE.wire(%[[VAL_85]] : North, %[[VAL_86]] : South)
// CHECK:           AIE.wire(%[[VAL_82]] : East, %[[VAL_87:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_7]] : Core, %[[VAL_87]] : Core)
// CHECK:           AIE.wire(%[[VAL_7]] : DMA, %[[VAL_87]] : DMA)
// CHECK:           AIE.wire(%[[VAL_86]] : North, %[[VAL_87]] : South)
// CHECK:           AIE.wire(%[[VAL_84]] : East, %[[VAL_88:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_89:.*]] : North, %[[VAL_88]] : South)
// CHECK:           AIE.wire(%[[VAL_8]] : DMA, %[[VAL_89]] : DMA)
// CHECK:           AIE.wire(%[[VAL_83]] : East, %[[VAL_90:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_9]] : Core, %[[VAL_90]] : Core)
// CHECK:           AIE.wire(%[[VAL_9]] : DMA, %[[VAL_90]] : DMA)
// CHECK:           AIE.wire(%[[VAL_88]] : North, %[[VAL_90]] : South)
// CHECK:           AIE.wire(%[[VAL_85]] : East, %[[VAL_91:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_10]] : Core, %[[VAL_91]] : Core)
// CHECK:           AIE.wire(%[[VAL_10]] : DMA, %[[VAL_91]] : DMA)
// CHECK:           AIE.wire(%[[VAL_90]] : North, %[[VAL_91]] : South)
// CHECK:           AIE.wire(%[[VAL_86]] : East, %[[VAL_92:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_11]] : Core, %[[VAL_92]] : Core)
// CHECK:           AIE.wire(%[[VAL_11]] : DMA, %[[VAL_92]] : DMA)
// CHECK:           AIE.wire(%[[VAL_91]] : North, %[[VAL_92]] : South)
// CHECK:           AIE.wire(%[[VAL_87]] : East, %[[VAL_93:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_12]] : Core, %[[VAL_93]] : Core)
// CHECK:           AIE.wire(%[[VAL_12]] : DMA, %[[VAL_93]] : DMA)
// CHECK:           AIE.wire(%[[VAL_92]] : North, %[[VAL_93]] : South)
// CHECK:           AIE.wire(%[[VAL_88]] : East, %[[VAL_94:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_95:.*]] : North, %[[VAL_94]] : South)
// CHECK:           AIE.wire(%[[VAL_13]] : DMA, %[[VAL_95]] : DMA)
// CHECK:           AIE.wire(%[[VAL_90]] : East, %[[VAL_96:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_47]] : Core, %[[VAL_96]] : Core)
// CHECK:           AIE.wire(%[[VAL_47]] : DMA, %[[VAL_96]] : DMA)
// CHECK:           AIE.wire(%[[VAL_94]] : North, %[[VAL_96]] : South)
// CHECK:           AIE.wire(%[[VAL_91]] : East, %[[VAL_97:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_72]] : Core, %[[VAL_97]] : Core)
// CHECK:           AIE.wire(%[[VAL_72]] : DMA, %[[VAL_97]] : DMA)
// CHECK:           AIE.wire(%[[VAL_96]] : North, %[[VAL_97]] : South)
// CHECK:           AIE.wire(%[[VAL_92]] : East, %[[VAL_98:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_32]] : Core, %[[VAL_98]] : Core)
// CHECK:           AIE.wire(%[[VAL_32]] : DMA, %[[VAL_98]] : DMA)
// CHECK:           AIE.wire(%[[VAL_97]] : North, %[[VAL_98]] : South)
// CHECK:           AIE.wire(%[[VAL_93]] : East, %[[VAL_99:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_77]] : Core, %[[VAL_99]] : Core)
// CHECK:           AIE.wire(%[[VAL_77]] : DMA, %[[VAL_99]] : DMA)
// CHECK:           AIE.wire(%[[VAL_98]] : North, %[[VAL_99]] : South)
// CHECK:           AIE.wire(%[[VAL_96]] : East, %[[VAL_100:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_49]] : Core, %[[VAL_100]] : Core)
// CHECK:           AIE.wire(%[[VAL_49]] : DMA, %[[VAL_100]] : DMA)
// CHECK:           AIE.wire(%[[VAL_97]] : East, %[[VAL_101:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_51]] : Core, %[[VAL_101]] : Core)
// CHECK:           AIE.wire(%[[VAL_51]] : DMA, %[[VAL_101]] : DMA)
// CHECK:           AIE.wire(%[[VAL_100]] : North, %[[VAL_101]] : South)
// CHECK:           AIE.wire(%[[VAL_98]] : East, %[[VAL_102:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_34]] : Core, %[[VAL_102]] : Core)
// CHECK:           AIE.wire(%[[VAL_34]] : DMA, %[[VAL_102]] : DMA)
// CHECK:           AIE.wire(%[[VAL_101]] : North, %[[VAL_102]] : South)
// CHECK:           AIE.wire(%[[VAL_99]] : East, %[[VAL_103:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_53]] : Core, %[[VAL_103]] : Core)
// CHECK:           AIE.wire(%[[VAL_53]] : DMA, %[[VAL_103]] : DMA)
// CHECK:           AIE.wire(%[[VAL_102]] : North, %[[VAL_103]] : South)
// CHECK:           AIE.wire(%[[VAL_100]] : East, %[[VAL_104:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_66]] : Core, %[[VAL_104]] : Core)
// CHECK:           AIE.wire(%[[VAL_66]] : DMA, %[[VAL_104]] : DMA)
// CHECK:           AIE.wire(%[[VAL_101]] : East, %[[VAL_105:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_74]] : Core, %[[VAL_105]] : Core)
// CHECK:           AIE.wire(%[[VAL_74]] : DMA, %[[VAL_105]] : DMA)
// CHECK:           AIE.wire(%[[VAL_104]] : North, %[[VAL_105]] : South)
// CHECK:           AIE.wire(%[[VAL_102]] : East, %[[VAL_106:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_36]] : Core, %[[VAL_106]] : Core)
// CHECK:           AIE.wire(%[[VAL_36]] : DMA, %[[VAL_106]] : DMA)
// CHECK:           AIE.wire(%[[VAL_105]] : North, %[[VAL_106]] : South)
// CHECK:           AIE.wire(%[[VAL_103]] : East, %[[VAL_107:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_55]] : Core, %[[VAL_107]] : Core)
// CHECK:           AIE.wire(%[[VAL_55]] : DMA, %[[VAL_107]] : DMA)
// CHECK:           AIE.wire(%[[VAL_106]] : North, %[[VAL_107]] : South)
// CHECK:           AIE.wire(%[[VAL_104]] : East, %[[VAL_108:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_68]] : Core, %[[VAL_108]] : Core)
// CHECK:           AIE.wire(%[[VAL_68]] : DMA, %[[VAL_108]] : DMA)
// CHECK:           AIE.wire(%[[VAL_105]] : East, %[[VAL_109:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_70]] : Core, %[[VAL_109]] : Core)
// CHECK:           AIE.wire(%[[VAL_70]] : DMA, %[[VAL_109]] : DMA)
// CHECK:           AIE.wire(%[[VAL_108]] : North, %[[VAL_109]] : South)
// CHECK:           AIE.wire(%[[VAL_106]] : East, %[[VAL_110:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_38]] : Core, %[[VAL_110]] : Core)
// CHECK:           AIE.wire(%[[VAL_38]] : DMA, %[[VAL_110]] : DMA)
// CHECK:           AIE.wire(%[[VAL_109]] : North, %[[VAL_110]] : South)
// CHECK:           AIE.wire(%[[VAL_107]] : East, %[[VAL_111:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_57]] : Core, %[[VAL_111]] : Core)
// CHECK:           AIE.wire(%[[VAL_57]] : DMA, %[[VAL_111]] : DMA)
// CHECK:           AIE.wire(%[[VAL_110]] : North, %[[VAL_111]] : South)
// CHECK:           AIE.wire(%[[VAL_108]] : East, %[[VAL_112:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_14]] : Core, %[[VAL_112]] : Core)
// CHECK:           AIE.wire(%[[VAL_14]] : DMA, %[[VAL_112]] : DMA)
// CHECK:           AIE.wire(%[[VAL_109]] : East, %[[VAL_113:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_15]] : Core, %[[VAL_113]] : Core)
// CHECK:           AIE.wire(%[[VAL_15]] : DMA, %[[VAL_113]] : DMA)
// CHECK:           AIE.wire(%[[VAL_112]] : North, %[[VAL_113]] : South)
// CHECK:           AIE.wire(%[[VAL_110]] : East, %[[VAL_114:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_16]] : Core, %[[VAL_114]] : Core)
// CHECK:           AIE.wire(%[[VAL_16]] : DMA, %[[VAL_114]] : DMA)
// CHECK:           AIE.wire(%[[VAL_113]] : North, %[[VAL_114]] : South)
// CHECK:           AIE.wire(%[[VAL_111]] : East, %[[VAL_115:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_17]] : Core, %[[VAL_115]] : Core)
// CHECK:           AIE.wire(%[[VAL_17]] : DMA, %[[VAL_115]] : DMA)
// CHECK:           AIE.wire(%[[VAL_114]] : North, %[[VAL_115]] : South)
// CHECK:           AIE.wire(%[[VAL_113]] : East, %[[VAL_116:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_19]] : Core, %[[VAL_116]] : Core)
// CHECK:           AIE.wire(%[[VAL_19]] : DMA, %[[VAL_116]] : DMA)
// CHECK:           AIE.wire(%[[VAL_114]] : East, %[[VAL_117:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_20]] : Core, %[[VAL_117]] : Core)
// CHECK:           AIE.wire(%[[VAL_20]] : DMA, %[[VAL_117]] : DMA)
// CHECK:           AIE.wire(%[[VAL_116]] : North, %[[VAL_117]] : South)
// CHECK:           AIE.wire(%[[VAL_115]] : East, %[[VAL_118:.*]] : West)
// CHECK:           AIE.wire(%[[VAL_21]] : Core, %[[VAL_118]] : Core)
// CHECK:           AIE.wire(%[[VAL_21]] : DMA, %[[VAL_118]] : DMA)
// CHECK:           AIE.wire(%[[VAL_117]] : North, %[[VAL_118]] : South)
// CHECK:         }

module {
    AIE.device(xcvc1902) {
        %t01 = AIE.tile(0, 1)
        %t02 = AIE.tile(0, 2)
        %t03 = AIE.tile(0, 3)
        %t04 = AIE.tile(0, 4)
        %t11 = AIE.tile(1, 1)
        %t12 = AIE.tile(1, 2)
        %t13 = AIE.tile(1, 3)
        %t14 = AIE.tile(1, 4)
        %t20 = AIE.tile(2, 0)
        %t21 = AIE.tile(2, 1)
        %t22 = AIE.tile(2, 2)
        %t23 = AIE.tile(2, 3)
        %t24 = AIE.tile(2, 4)
        %t30 = AIE.tile(3, 0)
        %t71 = AIE.tile(7, 1)
        %t72 = AIE.tile(7, 2)
        %t73 = AIE.tile(7, 3)
        %t74 = AIE.tile(7, 4)
        %t81 = AIE.tile(8, 1)
        %t82 = AIE.tile(8, 2)
        %t83 = AIE.tile(8, 3)
        %t84 = AIE.tile(8, 4)

        //TASK 1
        AIE.flow(%t20, DMA : 0, %t03, DMA : 0)
        AIE.flow(%t03, Core : 0, %t71, Core : 0)
        AIE.flow(%t71, Core : 0, %t84, Core : 0)
        AIE.flow(%t84, Core : 0, %t11, Core : 0)
        AIE.flow(%t11, Core : 0, %t24, Core : 0)
        AIE.flow(%t24, DMA : 0, %t20, DMA : 0)

        //TASK 2
        AIE.flow(%t30, DMA : 0, %t14, DMA : 0)
        AIE.flow(%t14, Core : 0, %t01, Core : 0)
        AIE.flow(%t01, Core : 0, %t83, Core : 0)
        AIE.flow(%t83, Core : 0, %t21, Core : 0)
        AIE.flow(%t21, Core : 0, %t73, Core : 0)
        AIE.flow(%t73, Core : 0, %t82, Core : 0)
        AIE.flow(%t82, DMA : 0, %t30, DMA : 0)

        //TASK 3
        AIE.flow(%t20, DMA : 1, %t83, DMA : 1)
        AIE.flow(%t83, Core : 1, %t01, Core : 1)
        AIE.flow(%t01, Core : 1, %t72, Core : 1)
        AIE.flow(%t72, Core : 1, %t02, Core : 1)
        AIE.flow(%t02, Core : 1, %t24, Core : 1)
        AIE.flow(%t24, Core : 1, %t71, Core : 1)
        AIE.flow(%t71, Core : 1, %t84, Core : 1)
        AIE.flow(%t84, DMA : 1, %t20, DMA : 1)
    }
}
