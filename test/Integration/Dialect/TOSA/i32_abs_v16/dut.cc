void dut(int32_t *restrict v1, int32_t *restrict v2) {
  v16int32 v3 = broadcast_zero_s32();
  size_t v4 = 0;
  size_t v5 = 1024;
  size_t v6 = 16;
  for (size_t v7 = v4; v7 < v5; v7 += v6)
    chess_prepare_for_pipelining chess_loop_range(64, 64) {
      v16int32 v8 = *(v16int32 *)(v1 + v7);
      uint32_t v9 = gt(v8, v3);
      v16int32 v10 = sub(v3, v8);
      v16int32 v11 = sel(v10, v8, v9);
      *(v16int32 *)(v2 + v7) = v11;
    }
  return;
}
