	.file	"snakes.c"
# GNU C17 (GCC) version 10.0.0 20200111 (experimental) (moxiebox)
#	compiled by GNU C version 7.4.0, GMP version 6.1.2, MPFR version 4.0.1, MPC version 1.1.0, isl version none
# GGC heuristics: --param ggc-min-expand=30 --param ggc-min-heapsize=4096
# options passed:  snakes.c -mel -auxbase-strip snakes.s -fverbose-asm
# options enabled:  -faggressive-loop-optimizations -fallocation-dce
# -fauto-inc-dec -fdelete-null-pointer-checks -fearly-inlining
# -feliminate-unused-debug-symbols -feliminate-unused-debug-types
# -ffp-int-builtin-inexact -ffunction-cse -fgcse-lm -fgnu-unique -fident
# -finline-atomics -fipa-stack-alignment -fira-hoist-pressure
# -fira-share-save-slots -fira-share-spill-slots -fivopts
# -fkeep-static-consts -fleading-underscore -flifetime-dse -fmath-errno
# -fmerge-debug-strings -fpcc-struct-return -fpeephole -fplt
# -fprefetch-loop-arrays -fsched-critical-path-heuristic
# -fsched-dep-count-heuristic -fsched-group-heuristic -fsched-interblock
# -fsched-last-insn-heuristic -fsched-rank-heuristic -fsched-spec
# -fsched-spec-insn-heuristic -fsched-stalled-insns-dep -fschedule-fusion
# -fsemantic-interposition -fshow-column -fshrink-wrap-separate
# -fsigned-zeros -fsplit-ivs-in-unroller -fssa-backprop -fstdarg-opt
# -fstrict-volatile-bitfields -fsync-libcalls -ftrapping-math
# -ftree-forwprop -ftree-loop-if-convert -ftree-loop-im -ftree-loop-ivcanon
# -ftree-loop-optimize -ftree-parallelize-loops= -ftree-phiprop
# -ftree-reassoc -ftree-scev-cprop -funit-at-a-time -fverbose-asm
# -fzero-initialized-in-bss -mel -mmul.x

	.text
	.global	MaxN
	.data
	.p2align	2
	.type	MaxN, @object
	.size	MaxN, 4
MaxN:
	.long	2000
	.global	zx
	.p2align	2
	.type	zx, @object
	.size	zx, 4
zx:
	.long	520000
	.global	zy
	.p2align	2
	.type	zy, @object
	.size	zy, 4
zy:
	.long	530000
	.global	N
	.section	.bss,"aw",@nobits
	.p2align	2
	.type	N, @object
	.size	N, 4
N:
	.zero	4
	.global	smer
	.p2align	2
	.type	smer, @object
	.size	smer, 4
smer:
	.zero	4
	.global	Poeni
	.p2align	2
	.type	Poeni, @object
	.size	Poeni, 4
Poeni:
	.zero	4
	.global	kraj
	.p2align	2
	.type	kraj, @object
	.size	kraj, 4
kraj:
	.zero	4
	.global	Usporenje
	.p2align	2
	.type	Usporenje, @object
	.size	Usporenje, 4
Usporenje:
	.zero	4
	.global	c
	.p2align	2
	.type	c, @object
	.size	c, 4
c:
	.zero	4
	.global	sx
	.p2align	2
	.type	sx, @object
	.size	sx, 4
sx:
	.zero	4
	.global	sy
	.p2align	2
	.type	sy, @object
	.size	sy, 4
sy:
	.zero	4
	.text
	.p2align	1
	.global	SlucajanBroj
	.type	SlucajanBroj, @function
SlucajanBroj:
	push	r13		#
	mov.w	r13, sp	#,
	sub.w	sp, 24 #111	#,
# snakes.c:23:   return a + rand() % (b - a + 1);
	call	rand		#
	mov.w	r2, r0	# _1,
# snakes.c:23:   return a + rand() % (b - a + 1);
	ld.w	r0, [r13 + (12)]	# tmp32, b
	ld.w	r1, [r13 + (8)]	# tmp33, a
	sub.w	r0, r1 #222	# _2, tmp33
# snakes.c:23:   return a + rand() % (b - a + 1);
	mov.w	r1, r0	# _3, _2
	add.w	r1, 1 #111	# _3,
# snakes.c:23:   return a + rand() % (b - a + 1);
	mov.w	r0, r2	# _4, _1
	div.w	r0, r1	# _4, _3
mov.w	r0, r14	# _4
# snakes.c:23:   return a + rand() % (b - a + 1);
	ld.w	r1, [r13 + (8)]	# tmp34, a
	add.w	r0, r1 #222	# _9, tmp34
# snakes.c:24: }
	mov.w	sp, r13	#,
	pop	r13		#
	ret	
	.size	SlucajanBroj, .-SlucajanBroj
	.p2align	1
	.global	IzracunajZvezdu
	.type	IzracunajZvezdu, @function
IzracunajZvezdu:
	push	r13		#
	mov.w	r13, sp	#,
	sub.w	sp, 28 #111	#,
.L6:
# snakes.c:32:     sx = SlucajanBroj(2, 79);
	mov.w	r0, sp	# tmp56,
	mov.w	r1, 79	# tmp57,
	st.w	[r0 + (4)], r1	#, tmp57
	mov.w	r1, 2	# tmp58,
	st.w	[r0], r1	#, tmp58
	call	SlucajanBroj		#
# snakes.c:32:     sx = SlucajanBroj(2, 79);
	st.w	[sx], r0	# sx, _1
# snakes.c:33:     sy = SlucajanBroj(3, 24);
	mov.w	r0, sp	# tmp59,
	mov.w	r1, 24	# tmp60,
	st.w	[r0 + (4)], r1	#, tmp60
	mov.w	r1, 3	# tmp61,
	st.w	[r0], r1	#, tmp61
	call	SlucajanBroj		#
# snakes.c:33:     sy = SlucajanBroj(3, 24);
	st.w	[sy], r0	# sy, _2
# snakes.c:34:     zx[N + 1] = sx;
	ld.w	r0, [zx]	# zx.0_3, zx
	ld.w	r1, [N]	# N.1_4, N
	add.w	r1, 1 #111	# _6,
	mov.w	r2, 2	# tmp62,
	shl.w	r1, r2	# _7, tmp62
	add.w	r0, r1 #222	# _8, _7
# snakes.c:34:     zx[N + 1] = sx;
	ld.w	r1, [sx]	# sx.3_9, sx
	st.w	[r0], r1	# *_8, sx.3_9
# snakes.c:35:     zy[N + 1] = sy;
	ld.w	r0, [zy]	# zy.4_10, zy
	ld.w	r1, [N]	# N.5_11, N
	add.w	r1, 1 #111	# _13,
	mov.w	r2, 2	# tmp63,
	shl.w	r1, r2	# _14, tmp63
	add.w	r0, r1 #222	# _15, _14
# snakes.c:35:     zy[N + 1] = sy;
	ld.w	r1, [sy]	# sy.7_16, sy
	st.w	[r0], r1	# *_15, sy.7_16
# snakes.c:36:     i = 0;
	xor.w	r0, r0	# tmp64
	st.w	[r13 + (-4)], r0	# i, tmp64
# snakes.c:37:     while ((zx[i] != sx) || (zy[i] != sy)) i = i + 1;
	j	.L4		#
.L5:
# snakes.c:37:     while ((zx[i] != sx) || (zy[i] != sy)) i = i + 1;
	ld.w	r0, [r13 + (-4)]	# tmp66, i
	add.w	r0, 1 #111	# tmp65,
	st.w	[r13 + (-4)], r0	# i, tmp65
.L4:
# snakes.c:37:     while ((zx[i] != sx) || (zy[i] != sy)) i = i + 1;
	ld.w	r0, [zx]	# zx.8_17, zx
	ld.w	r1, [r13 + (-4)]	# i.9_18, i
	mov.w	r2, 2	# tmp67,
	shl.w	r1, r2	# _19, tmp67
	add.w	r0, r1 #222	# _20, _19
	ld.w	r1, [r0]	# _21, *_20
# snakes.c:37:     while ((zx[i] != sx) || (zy[i] != sy)) i = i + 1;
	ld.w	r0, [sx]	# sx.10_22, sx
# snakes.c:37:     while ((zx[i] != sx) || (zy[i] != sy)) i = i + 1;
	cmp.w	r1, r0	# _21, sx.10_22
	jnz	.L5		#
# snakes.c:37:     while ((zx[i] != sx) || (zy[i] != sy)) i = i + 1;
	ld.w	r0, [zy]	# zy.11_23, zy
	ld.w	r1, [r13 + (-4)]	# i.12_24, i
	mov.w	r2, 2	# tmp68,
	shl.w	r1, r2	# _25, tmp68
	add.w	r0, r1 #222	# _26, _25
	ld.w	r1, [r0]	# _27, *_26
# snakes.c:37:     while ((zx[i] != sx) || (zy[i] != sy)) i = i + 1;
	ld.w	r0, [sy]	# sy.13_28, sy
# snakes.c:37:     while ((zx[i] != sx) || (zy[i] != sy)) i = i + 1;
	cmp.w	r1, r0	# _27, sy.13_28
	jnz	.L5		#
# snakes.c:38:   } while (i != N + 1);
	ld.w	r0, [N]	# N.14_29, N
	add.w	r0, 1 #111	# _30,
# snakes.c:38:   } while (i != N + 1);
	ld.w	r1, [r13 + (-4)]	# tmp69, i
	cmp.w	r1, r0	# tmp69, _30
	jnz	.L6		#
# snakes.c:39: }
	nop	
	nop	
	mov.w	sp, r13	#,
	pop	r13		#
	ret	
	.size	IzracunajZvezdu, .-IzracunajZvezdu
	.p2align	1
	.global	IscrtajOkvir
	.type	IscrtajOkvir, @function
IscrtajOkvir:
	push	r13		#
	mov.w	r13, sp	#,
	sub.w	sp, 32 #111	#,
# snakes.c:45:   cls();
	call	cls		#
# snakes.c:46:   xy(1, 2);
	mov.w	r0, sp	# tmp26,
	mov.w	r1, 2	# tmp27,
	st.w	[r0 + (4)], r1	#, tmp27
	mov.w	r1, 1	# tmp28,
	st.w	[r0], r1	#, tmp28
	call	xy		#
# snakes.c:47:   printf("+");
	mov.w	r1, sp	# tmp29,
	mov.w	r0, 43	# tmp30,
	st.w	[r1], r0	#, tmp30
	call	putchar		#
# snakes.c:48:   for (i = 1; i <= 78; i++) printf("-");
	mov.w	r0, 1	# tmp31,
	st.w	[r13 + (-4)], r0	# i, tmp31
# snakes.c:48:   for (i = 1; i <= 78; i++) printf("-");
	j	.L8		#
.L9:
# snakes.c:48:   for (i = 1; i <= 78; i++) printf("-");
	mov.w	r1, sp	# tmp32,
	mov.w	r0, 45	# tmp33,
	st.w	[r1], r0	#, tmp33
	call	putchar		#
# snakes.c:48:   for (i = 1; i <= 78; i++) printf("-");
	ld.w	r0, [r13 + (-4)]	# tmp35, i
	add.w	r0, 1 #111	# tmp34,
	st.w	[r13 + (-4)], r0	# i, tmp34
.L8:
# snakes.c:48:   for (i = 1; i <= 78; i++) printf("-");
	ld.w	r1, [r13 + (-4)]	# tmp36, i
	mov.w	r0, 78	# tmp37,
	cmp.w	r1, r0	# tmp36, tmp37
	jses	.L9		#
# snakes.c:49:   printf("+");
	mov.w	r1, sp	# tmp38,
	mov.w	r0, 43	# tmp39,
	st.w	[r1], r0	#, tmp39
	call	putchar		#
# snakes.c:50:   for (i = 3; i <= 24; i++) 
	mov.w	r0, 3	# tmp40,
	st.w	[r13 + (-4)], r0	# i, tmp40
# snakes.c:50:   for (i = 3; i <= 24; i++) 
	j	.L10		#
.L13:
# snakes.c:52:     xy(1, i);
	mov.w	r0, sp	# tmp41,
	ld.w	r1, [r13 + (-4)]	# tmp42, i
	st.w	[r0 + (4)], r1	#, tmp42
	mov.w	r1, 1	# tmp43,
	st.w	[r0], r1	#, tmp43
	call	xy		#
# snakes.c:53:     printf("|");
	mov.w	r1, sp	# tmp44,
	mov.w	r0, 124	# tmp45,
	st.w	[r1], r0	#, tmp45
	call	putchar		#
# snakes.c:54:     for (j = 1; j <= 78; j++) printf(" ");
	mov.w	r0, 1	# tmp46,
	st.w	[r13 + (-8)], r0	# j, tmp46
# snakes.c:54:     for (j = 1; j <= 78; j++) printf(" ");
	j	.L11		#
.L12:
# snakes.c:54:     for (j = 1; j <= 78; j++) printf(" ");
	mov.w	r1, sp	# tmp47,
	mov.w	r0, 32	# tmp48,
	st.w	[r1], r0	#, tmp48
	call	putchar		#
# snakes.c:54:     for (j = 1; j <= 78; j++) printf(" ");
	ld.w	r0, [r13 + (-8)]	# tmp50, j
	add.w	r0, 1 #111	# tmp49,
	st.w	[r13 + (-8)], r0	# j, tmp49
.L11:
# snakes.c:54:     for (j = 1; j <= 78; j++) printf(" ");
	ld.w	r1, [r13 + (-8)]	# tmp51, j
	mov.w	r0, 78	# tmp52,
	cmp.w	r1, r0	# tmp51, tmp52
	jses	.L12		#
# snakes.c:55:     printf("|");
	mov.w	r1, sp	# tmp53,
	mov.w	r0, 124	# tmp54,
	st.w	[r1], r0	#, tmp54
	call	putchar		#
# snakes.c:50:   for (i = 3; i <= 24; i++) 
	ld.w	r0, [r13 + (-4)]	# tmp56, i
	add.w	r0, 1 #111	# tmp55,
	st.w	[r13 + (-4)], r0	# i, tmp55
.L10:
# snakes.c:50:   for (i = 3; i <= 24; i++) 
	ld.w	r1, [r13 + (-4)]	# tmp57, i
	mov.w	r0, 24	# tmp58,
	cmp.w	r1, r0	# tmp57, tmp58
	jses	.L13		#
# snakes.c:57:   xy(1, 25);
	mov.w	r0, sp	# tmp59,
	mov.w	r1, 25	# tmp60,
	st.w	[r0 + (4)], r1	#, tmp60
	mov.w	r1, 1	# tmp61,
	st.w	[r0], r1	#, tmp61
	call	xy		#
# snakes.c:58:   printf("+");
	mov.w	r1, sp	# tmp62,
	mov.w	r0, 43	# tmp63,
	st.w	[r1], r0	#, tmp63
	call	putchar		#
# snakes.c:59:   for (i = 1; i <= 78; i++) printf("-");
	mov.w	r0, 1	# tmp64,
	st.w	[r13 + (-4)], r0	# i, tmp64
# snakes.c:59:   for (i = 1; i <= 78; i++) printf("-");
	j	.L14		#
.L15:
# snakes.c:59:   for (i = 1; i <= 78; i++) printf("-");
	mov.w	r1, sp	# tmp65,
	mov.w	r0, 45	# tmp66,
	st.w	[r1], r0	#, tmp66
	call	putchar		#
# snakes.c:59:   for (i = 1; i <= 78; i++) printf("-");
	ld.w	r0, [r13 + (-4)]	# tmp68, i
	add.w	r0, 1 #111	# tmp67,
	st.w	[r13 + (-4)], r0	# i, tmp67
.L14:
# snakes.c:59:   for (i = 1; i <= 78; i++) printf("-");
	ld.w	r1, [r13 + (-4)]	# tmp69, i
	mov.w	r0, 78	# tmp70,
	cmp.w	r1, r0	# tmp69, tmp70
	jses	.L15		#
# snakes.c:60:   printf("+");
	mov.w	r1, sp	# tmp71,
	mov.w	r0, 43	# tmp72,
	st.w	[r1], r0	#, tmp72
	call	putchar		#
# snakes.c:61: }
	nop	
	mov.w	sp, r13	#,
	pop	r13		#
	ret	
	.size	IscrtajOkvir, .-IscrtajOkvir
	.section	.rodata
	.p2align	2
.LC0:
	.string	"POENI: %d"
	.text
	.p2align	1
	.global	IspisiStatus
	.type	IspisiStatus, @function
IspisiStatus:
	push	r13		#
	mov.w	r13, sp	#,
	sub.w	sp, 24 #111	#,
# snakes.c:65:   xy(1,1);
	mov.w	r0, sp	# tmp27,
	mov.w	r1, 1	# tmp28,
	st.w	[r0 + (4)], r1	#, tmp28
	mov.w	r1, 1	# tmp29,
	st.w	[r0], r1	#, tmp29
	call	xy		#
# snakes.c:66:   printf("POENI: %d", Poeni);
	ld.w	r1, [Poeni]	# Poeni.15_1, Poeni
	mov.w	r0, sp	# tmp30,
	st.w	[r0 + (4)], r1	#, Poeni.15_1
	mov.w	r1, .LC0	# tmp31,
	st.w	[r0], r1	#, tmp31
	call	printf		#
# snakes.c:67: }
	nop	
	mov.w	sp, r13	#,
	pop	r13		#
	ret	
	.size	IspisiStatus, .-IspisiStatus
	.p2align	1
	.global	InicijalizujZmiju
	.type	InicijalizujZmiju, @function
InicijalizujZmiju:
	push	r13		#
	mov.w	r13, sp	#,
	push	r6		#
	sub.w	sp, 40 #111	#,
# snakes.c:71: 	int i0 = 0, i1 = 1, i2 = 2;
	xor.w	r0, r0	# tmp193
	st.w	[r13 + (-12)], r0	# i0, tmp193
# snakes.c:71: 	int i0 = 0, i1 = 1, i2 = 2;
	mov.w	r0, 1	# tmp194,
	st.w	[r13 + (-16)], r0	# i1, tmp194
# snakes.c:71: 	int i0 = 0, i1 = 1, i2 = 2;
	mov.w	r0, 2	# tmp195,
	st.w	[r13 + (-20)], r0	# i2, tmp195
# snakes.c:72:   N = 2;
	mov.w	r0, 2	# tmp196,
	st.w	[N], r0	# N, tmp196
# snakes.c:73:   for (int i = 0; i <= N; i++) {
	xor.w	r0, r0	# tmp197
	st.w	[r13 + (-8)], r0	# i, tmp197
# snakes.c:73:   for (int i = 0; i <= N; i++) {
	j	.L18		#
.L19:
# snakes.c:74:     zx[i] = 0;
	ld.w	r0, [zx]	# zx.16_1, zx
	ld.w	r1, [r13 + (-8)]	# i.17_2, i
	mov.w	r2, 2	# tmp198,
	shl.w	r1, r2	# _3, tmp198
	add.w	r0, r1 #222	# _4, _3
# snakes.c:74:     zx[i] = 0;
	xor.w	r1, r1	# tmp199
	st.w	[r0], r1	# *_4, tmp199
# snakes.c:75:     zy[i] = 0;
	ld.w	r0, [zy]	# zy.18_5, zy
	ld.w	r1, [r13 + (-8)]	# i.19_6, i
	mov.w	r2, 2	# tmp200,
	shl.w	r1, r2	# _7, tmp200
	add.w	r0, r1 #222	# _8, _7
# snakes.c:75:     zy[i] = 0;
	xor.w	r1, r1	# tmp201
	st.w	[r0], r1	# *_8, tmp201
# snakes.c:73:   for (int i = 0; i <= N; i++) {
	ld.w	r0, [r13 + (-8)]	# tmp203, i
	add.w	r0, 1 #111	# tmp202,
	st.w	[r13 + (-8)], r0	# i, tmp202
.L18:
# snakes.c:73:   for (int i = 0; i <= N; i++) {
	ld.w	r0, [N]	# N.20_9, N
# snakes.c:73:   for (int i = 0; i <= N; i++) {
	ld.w	r1, [r13 + (-8)]	# tmp204, i
	cmp.w	r1, r0	# tmp204, N.20_9
	jses	.L19		#
# snakes.c:77:   zx[0] = SlucajanBroj(10, 72);
	ld.w	r6, [zx]	# zx.21_10, zx
# snakes.c:77:   zx[0] = SlucajanBroj(10, 72);
	mov.w	r0, sp	# tmp205,
	mov.w	r1, 72	# tmp206,
	st.w	[r0 + (4)], r1	#, tmp206
	mov.w	r1, 10	# tmp207,
	st.w	[r0], r1	#, tmp207
	call	SlucajanBroj		#
# snakes.c:77:   zx[0] = SlucajanBroj(10, 72);
	st.w	[r6], r0	# *zx.21_10, _11
# snakes.c:78:   zy[0] = SlucajanBroj(10, 17);
	ld.w	r6, [zy]	# zy.22_12, zy
# snakes.c:78:   zy[0] = SlucajanBroj(10, 17);
	mov.w	r0, sp	# tmp208,
	mov.w	r1, 17	# tmp209,
	st.w	[r0 + (4)], r1	#, tmp209
	mov.w	r1, 10	# tmp210,
	st.w	[r0], r1	#, tmp210
	call	SlucajanBroj		#
# snakes.c:78:   zy[0] = SlucajanBroj(10, 17);
	st.w	[r6], r0	# *zy.22_12, _13
# snakes.c:79:   smer  = SlucajanBroj(0, 3);
	mov.w	r0, sp	# tmp211,
	mov.w	r1, 3	# tmp212,
	st.w	[r0 + (4)], r1	#, tmp212
	xor.w	r1, r1	# tmp213
	st.w	[r0], r1	#, tmp213
	call	SlucajanBroj		#
# snakes.c:79:   smer  = SlucajanBroj(0, 3);
	st.w	[smer], r0	# smer, _14
# snakes.c:80:   switch(smer)
	ld.w	r0, [smer]	# smer.23_15, smer
	mov.w	r1, 3	# tmp214,
	cmp.w	r0, r1	# smer.23_15, tmp214
	jz	.L20		#
	mov.w	r1, 3	# tmp215,
	cmp.w	r0, r1	# smer.23_15, tmp215
	jgs	.L25		#
	mov.w	r1, 2	# tmp216,
	cmp.w	r0, r1	# smer.23_15, tmp216
	jz	.L22		#
	mov.w	r1, 2	# tmp217,
	cmp.w	r0, r1	# smer.23_15, tmp217
	jgs	.L25		#
	xor.w	r1, r1	# tmp218
	cmp.w	r0, r1	# smer.23_15, tmp218
	jz	.L23		#
	mov.w	r1, 1	# tmp219,
	cmp.w	r0, r1	# smer.23_15, tmp219
	jz	.L24		#
# snakes.c:99: }
	j	.L25		#
.L23:
# snakes.c:83:       zx[i1] = zx[i0]; zy[i1] = zy[i0] + 1;
	ld.w	r1, [zx]	# zx.24_16, zx
	ld.w	r0, [r13 + (-12)]	# i0.25_17, i0
	mov.w	r2, 2	# tmp220,
	shl.w	r0, r2	# _18, tmp220
	add.w	r1, r0 #222	# _19, _18
# snakes.c:83:       zx[i1] = zx[i0]; zy[i1] = zy[i0] + 1;
	ld.w	r0, [zx]	# zx.26_20, zx
	ld.w	r2, [r13 + (-16)]	# i1.27_21, i1
	mov.w	r3, 2	# tmp221,
	shl.w	r2, r3	# _22, tmp221
	add.w	r0, r2 #222	# _23, _22
# snakes.c:83:       zx[i1] = zx[i0]; zy[i1] = zy[i0] + 1;
	ld.w	r1, [r1]	# _24, *_19
# snakes.c:83:       zx[i1] = zx[i0]; zy[i1] = zy[i0] + 1;
	st.w	[r0], r1	# *_23, _24
# snakes.c:83:       zx[i1] = zx[i0]; zy[i1] = zy[i0] + 1;
	ld.w	r0, [zy]	# zy.28_25, zy
	ld.w	r1, [r13 + (-12)]	# i0.29_26, i0
	mov.w	r2, 2	# tmp222,
	shl.w	r1, r2	# _27, tmp222
	add.w	r0, r1 #222	# _28, _27
	ld.w	r1, [r0]	# _29, *_28
# snakes.c:83:       zx[i1] = zx[i0]; zy[i1] = zy[i0] + 1;
	ld.w	r0, [zy]	# zy.30_30, zy
	ld.w	r2, [r13 + (-16)]	# i1.31_31, i1
	mov.w	r3, 2	# tmp223,
	shl.w	r2, r3	# _32, tmp223
	add.w	r0, r2 #222	# _33, _32
# snakes.c:83:       zx[i1] = zx[i0]; zy[i1] = zy[i0] + 1;
	add.w	r1, 1 #111	# _34,
# snakes.c:83:       zx[i1] = zx[i0]; zy[i1] = zy[i0] + 1;
	st.w	[r0], r1	# *_33, _34
# snakes.c:84:       zx[i2] = zx[i0]; zy[i2] = zy[i0] + 2;
	ld.w	r1, [zx]	# zx.32_35, zx
	ld.w	r0, [r13 + (-12)]	# i0.33_36, i0
	mov.w	r2, 2	# tmp224,
	shl.w	r0, r2	# _37, tmp224
	add.w	r1, r0 #222	# _38, _37
# snakes.c:84:       zx[i2] = zx[i0]; zy[i2] = zy[i0] + 2;
	ld.w	r0, [zx]	# zx.34_39, zx
	ld.w	r2, [r13 + (-20)]	# i2.35_40, i2
	mov.w	r3, 2	# tmp225,
	shl.w	r2, r3	# _41, tmp225
	add.w	r0, r2 #222	# _42, _41
# snakes.c:84:       zx[i2] = zx[i0]; zy[i2] = zy[i0] + 2;
	ld.w	r1, [r1]	# _43, *_38
# snakes.c:84:       zx[i2] = zx[i0]; zy[i2] = zy[i0] + 2;
	st.w	[r0], r1	# *_42, _43
# snakes.c:84:       zx[i2] = zx[i0]; zy[i2] = zy[i0] + 2;
	ld.w	r0, [zy]	# zy.36_44, zy
	ld.w	r1, [r13 + (-12)]	# i0.37_45, i0
	mov.w	r2, 2	# tmp226,
	shl.w	r1, r2	# _46, tmp226
	add.w	r0, r1 #222	# _47, _46
	ld.w	r1, [r0]	# _48, *_47
# snakes.c:84:       zx[i2] = zx[i0]; zy[i2] = zy[i0] + 2;
	ld.w	r0, [zy]	# zy.38_49, zy
	ld.w	r2, [r13 + (-20)]	# i2.39_50, i2
	mov.w	r3, 2	# tmp227,
	shl.w	r2, r3	# _51, tmp227
	add.w	r0, r2 #222	# _52, _51
# snakes.c:84:       zx[i2] = zx[i0]; zy[i2] = zy[i0] + 2;
	add.w	r1, 2 #111	# _53,
# snakes.c:84:       zx[i2] = zx[i0]; zy[i2] = zy[i0] + 2;
	st.w	[r0], r1	# *_52, _53
# snakes.c:85:       break;
	j	.L21		#
.L24:
# snakes.c:87:       zy[i1] = zy[i0]; zx[i1] = zx[i0] - 1;
	ld.w	r1, [zy]	# zy.40_54, zy
	ld.w	r0, [r13 + (-12)]	# i0.41_55, i0
	mov.w	r2, 2	# tmp228,
	shl.w	r0, r2	# _56, tmp228
	add.w	r1, r0 #222	# _57, _56
# snakes.c:87:       zy[i1] = zy[i0]; zx[i1] = zx[i0] - 1;
	ld.w	r0, [zy]	# zy.42_58, zy
	ld.w	r2, [r13 + (-16)]	# i1.43_59, i1
	mov.w	r3, 2	# tmp229,
	shl.w	r2, r3	# _60, tmp229
	add.w	r0, r2 #222	# _61, _60
# snakes.c:87:       zy[i1] = zy[i0]; zx[i1] = zx[i0] - 1;
	ld.w	r1, [r1]	# _62, *_57
# snakes.c:87:       zy[i1] = zy[i0]; zx[i1] = zx[i0] - 1;
	st.w	[r0], r1	# *_61, _62
# snakes.c:87:       zy[i1] = zy[i0]; zx[i1] = zx[i0] - 1;
	ld.w	r0, [zx]	# zx.44_63, zx
	ld.w	r1, [r13 + (-12)]	# i0.45_64, i0
	mov.w	r2, 2	# tmp230,
	shl.w	r1, r2	# _65, tmp230
	add.w	r0, r1 #222	# _66, _65
	ld.w	r1, [r0]	# _67, *_66
# snakes.c:87:       zy[i1] = zy[i0]; zx[i1] = zx[i0] - 1;
	ld.w	r0, [zx]	# zx.46_68, zx
	ld.w	r2, [r13 + (-16)]	# i1.47_69, i1
	mov.w	r3, 2	# tmp231,
	shl.w	r2, r3	# _70, tmp231
	add.w	r0, r2 #222	# _71, _70
# snakes.c:87:       zy[i1] = zy[i0]; zx[i1] = zx[i0] - 1;
	add.w	r1, -1 #111	# _72,
# snakes.c:87:       zy[i1] = zy[i0]; zx[i1] = zx[i0] - 1;
	st.w	[r0], r1	# *_71, _72
# snakes.c:88:       zy[i2] = zy[i0]; zx[i2] = zx[i0] - 2;
	ld.w	r1, [zy]	# zy.48_73, zy
	ld.w	r0, [r13 + (-12)]	# i0.49_74, i0
	mov.w	r2, 2	# tmp232,
	shl.w	r0, r2	# _75, tmp232
	add.w	r1, r0 #222	# _76, _75
# snakes.c:88:       zy[i2] = zy[i0]; zx[i2] = zx[i0] - 2;
	ld.w	r0, [zy]	# zy.50_77, zy
	ld.w	r2, [r13 + (-20)]	# i2.51_78, i2
	mov.w	r3, 2	# tmp233,
	shl.w	r2, r3	# _79, tmp233
	add.w	r0, r2 #222	# _80, _79
# snakes.c:88:       zy[i2] = zy[i0]; zx[i2] = zx[i0] - 2;
	ld.w	r1, [r1]	# _81, *_76
# snakes.c:88:       zy[i2] = zy[i0]; zx[i2] = zx[i0] - 2;
	st.w	[r0], r1	# *_80, _81
# snakes.c:88:       zy[i2] = zy[i0]; zx[i2] = zx[i0] - 2;
	ld.w	r0, [zx]	# zx.52_82, zx
	ld.w	r1, [r13 + (-12)]	# i0.53_83, i0
	mov.w	r2, 2	# tmp234,
	shl.w	r1, r2	# _84, tmp234
	add.w	r0, r1 #222	# _85, _84
	ld.w	r1, [r0]	# _86, *_85
# snakes.c:88:       zy[i2] = zy[i0]; zx[i2] = zx[i0] - 2;
	ld.w	r0, [zx]	# zx.54_87, zx
	ld.w	r2, [r13 + (-20)]	# i2.55_88, i2
	mov.w	r3, 2	# tmp235,
	shl.w	r2, r3	# _89, tmp235
	add.w	r0, r2 #222	# _90, _89
# snakes.c:88:       zy[i2] = zy[i0]; zx[i2] = zx[i0] - 2;
	add.w	r1, -2 #111	# _91,
# snakes.c:88:       zy[i2] = zy[i0]; zx[i2] = zx[i0] - 2;
	st.w	[r0], r1	# *_90, _91
# snakes.c:89:       break;
	j	.L21		#
.L22:
# snakes.c:91:       zx[i1] = zx[i0]; zy[i1] = zy[i0] - 1;
	ld.w	r1, [zx]	# zx.56_92, zx
	ld.w	r0, [r13 + (-12)]	# i0.57_93, i0
	mov.w	r2, 2	# tmp236,
	shl.w	r0, r2	# _94, tmp236
	add.w	r1, r0 #222	# _95, _94
# snakes.c:91:       zx[i1] = zx[i0]; zy[i1] = zy[i0] - 1;
	ld.w	r0, [zx]	# zx.58_96, zx
	ld.w	r2, [r13 + (-16)]	# i1.59_97, i1
	mov.w	r3, 2	# tmp237,
	shl.w	r2, r3	# _98, tmp237
	add.w	r0, r2 #222	# _99, _98
# snakes.c:91:       zx[i1] = zx[i0]; zy[i1] = zy[i0] - 1;
	ld.w	r1, [r1]	# _100, *_95
# snakes.c:91:       zx[i1] = zx[i0]; zy[i1] = zy[i0] - 1;
	st.w	[r0], r1	# *_99, _100
# snakes.c:91:       zx[i1] = zx[i0]; zy[i1] = zy[i0] - 1;
	ld.w	r0, [zy]	# zy.60_101, zy
	ld.w	r1, [r13 + (-12)]	# i0.61_102, i0
	mov.w	r2, 2	# tmp238,
	shl.w	r1, r2	# _103, tmp238
	add.w	r0, r1 #222	# _104, _103
	ld.w	r1, [r0]	# _105, *_104
# snakes.c:91:       zx[i1] = zx[i0]; zy[i1] = zy[i0] - 1;
	ld.w	r0, [zy]	# zy.62_106, zy
	ld.w	r2, [r13 + (-16)]	# i1.63_107, i1
	mov.w	r3, 2	# tmp239,
	shl.w	r2, r3	# _108, tmp239
	add.w	r0, r2 #222	# _109, _108
# snakes.c:91:       zx[i1] = zx[i0]; zy[i1] = zy[i0] - 1;
	add.w	r1, -1 #111	# _110,
# snakes.c:91:       zx[i1] = zx[i0]; zy[i1] = zy[i0] - 1;
	st.w	[r0], r1	# *_109, _110
# snakes.c:92:       zx[i2] = zx[i0]; zy[i2] = zy[i0] - 2;
	ld.w	r1, [zx]	# zx.64_111, zx
	ld.w	r0, [r13 + (-12)]	# i0.65_112, i0
	mov.w	r2, 2	# tmp240,
	shl.w	r0, r2	# _113, tmp240
	add.w	r1, r0 #222	# _114, _113
# snakes.c:92:       zx[i2] = zx[i0]; zy[i2] = zy[i0] - 2;
	ld.w	r0, [zx]	# zx.66_115, zx
	ld.w	r2, [r13 + (-20)]	# i2.67_116, i2
	mov.w	r3, 2	# tmp241,
	shl.w	r2, r3	# _117, tmp241
	add.w	r0, r2 #222	# _118, _117
# snakes.c:92:       zx[i2] = zx[i0]; zy[i2] = zy[i0] - 2;
	ld.w	r1, [r1]	# _119, *_114
# snakes.c:92:       zx[i2] = zx[i0]; zy[i2] = zy[i0] - 2;
	st.w	[r0], r1	# *_118, _119
# snakes.c:92:       zx[i2] = zx[i0]; zy[i2] = zy[i0] - 2;
	ld.w	r0, [zy]	# zy.68_120, zy
	ld.w	r1, [r13 + (-12)]	# i0.69_121, i0
	mov.w	r2, 2	# tmp242,
	shl.w	r1, r2	# _122, tmp242
	add.w	r0, r1 #222	# _123, _122
	ld.w	r1, [r0]	# _124, *_123
# snakes.c:92:       zx[i2] = zx[i0]; zy[i2] = zy[i0] - 2;
	ld.w	r0, [zy]	# zy.70_125, zy
	ld.w	r2, [r13 + (-20)]	# i2.71_126, i2
	mov.w	r3, 2	# tmp243,
	shl.w	r2, r3	# _127, tmp243
	add.w	r0, r2 #222	# _128, _127
# snakes.c:92:       zx[i2] = zx[i0]; zy[i2] = zy[i0] - 2;
	add.w	r1, -2 #111	# _129,
# snakes.c:92:       zx[i2] = zx[i0]; zy[i2] = zy[i0] - 2;
	st.w	[r0], r1	# *_128, _129
# snakes.c:93:       break;
	j	.L21		#
.L20:
# snakes.c:95:       zy[i1] = zy[i0]; zx[i1] = zx[i0] + 1;
	ld.w	r1, [zy]	# zy.72_130, zy
	ld.w	r0, [r13 + (-12)]	# i0.73_131, i0
	mov.w	r2, 2	# tmp244,
	shl.w	r0, r2	# _132, tmp244
	add.w	r1, r0 #222	# _133, _132
# snakes.c:95:       zy[i1] = zy[i0]; zx[i1] = zx[i0] + 1;
	ld.w	r0, [zy]	# zy.74_134, zy
	ld.w	r2, [r13 + (-16)]	# i1.75_135, i1
	mov.w	r3, 2	# tmp245,
	shl.w	r2, r3	# _136, tmp245
	add.w	r0, r2 #222	# _137, _136
# snakes.c:95:       zy[i1] = zy[i0]; zx[i1] = zx[i0] + 1;
	ld.w	r1, [r1]	# _138, *_133
# snakes.c:95:       zy[i1] = zy[i0]; zx[i1] = zx[i0] + 1;
	st.w	[r0], r1	# *_137, _138
# snakes.c:95:       zy[i1] = zy[i0]; zx[i1] = zx[i0] + 1;
	ld.w	r0, [zx]	# zx.76_139, zx
	ld.w	r1, [r13 + (-12)]	# i0.77_140, i0
	mov.w	r2, 2	# tmp246,
	shl.w	r1, r2	# _141, tmp246
	add.w	r0, r1 #222	# _142, _141
	ld.w	r1, [r0]	# _143, *_142
# snakes.c:95:       zy[i1] = zy[i0]; zx[i1] = zx[i0] + 1;
	ld.w	r0, [zx]	# zx.78_144, zx
	ld.w	r2, [r13 + (-16)]	# i1.79_145, i1
	mov.w	r3, 2	# tmp247,
	shl.w	r2, r3	# _146, tmp247
	add.w	r0, r2 #222	# _147, _146
# snakes.c:95:       zy[i1] = zy[i0]; zx[i1] = zx[i0] + 1;
	add.w	r1, 1 #111	# _148,
# snakes.c:95:       zy[i1] = zy[i0]; zx[i1] = zx[i0] + 1;
	st.w	[r0], r1	# *_147, _148
# snakes.c:96:       zy[i2] = zy[i0]; zx[i2] = zx[i0] + 2;
	ld.w	r1, [zy]	# zy.80_149, zy
	ld.w	r0, [r13 + (-12)]	# i0.81_150, i0
	mov.w	r2, 2	# tmp248,
	shl.w	r0, r2	# _151, tmp248
	add.w	r1, r0 #222	# _152, _151
# snakes.c:96:       zy[i2] = zy[i0]; zx[i2] = zx[i0] + 2;
	ld.w	r0, [zy]	# zy.82_153, zy
	ld.w	r2, [r13 + (-20)]	# i2.83_154, i2
	mov.w	r3, 2	# tmp249,
	shl.w	r2, r3	# _155, tmp249
	add.w	r0, r2 #222	# _156, _155
# snakes.c:96:       zy[i2] = zy[i0]; zx[i2] = zx[i0] + 2;
	ld.w	r1, [r1]	# _157, *_152
# snakes.c:96:       zy[i2] = zy[i0]; zx[i2] = zx[i0] + 2;
	st.w	[r0], r1	# *_156, _157
# snakes.c:96:       zy[i2] = zy[i0]; zx[i2] = zx[i0] + 2;
	ld.w	r0, [zx]	# zx.84_158, zx
	ld.w	r1, [r13 + (-12)]	# i0.85_159, i0
	mov.w	r2, 2	# tmp250,
	shl.w	r1, r2	# _160, tmp250
	add.w	r0, r1 #222	# _161, _160
	ld.w	r1, [r0]	# _162, *_161
# snakes.c:96:       zy[i2] = zy[i0]; zx[i2] = zx[i0] + 2;
	ld.w	r0, [zx]	# zx.86_163, zx
	ld.w	r2, [r13 + (-20)]	# i2.87_164, i2
	mov.w	r3, 2	# tmp251,
	shl.w	r2, r3	# _165, tmp251
	add.w	r0, r2 #222	# _166, _165
# snakes.c:96:       zy[i2] = zy[i0]; zx[i2] = zx[i0] + 2;
	add.w	r1, 2 #111	# _167,
# snakes.c:96:       zy[i2] = zy[i0]; zx[i2] = zx[i0] + 2;
	st.w	[r0], r1	# *_166, _167
# snakes.c:97:       break;
	nop	
.L21:
.L25:
# snakes.c:99: }
	nop	
	mov.w	r12, r13	#,
	sub.w	r12, 4 #111	#,
	pop	r6		#
	mov.w	sp, r13	#,
	pop	r13		#
	ret	
	.size	InicijalizujZmiju, .-InicijalizujZmiju
	.p2align	1
	.global	IscrtajZmiju
	.type	IscrtajZmiju, @function
IscrtajZmiju:
	push	r13		#
	mov.w	r13, sp	#,
	sub.w	sp, 28 #111	#,
# snakes.c:104:   xy(zx[0], zy[0]); printf("@");
	ld.w	r0, [zx]	# zx.88_1, zx
	ld.w	r1, [r0]	# _2, *zx.88_1
	ld.w	r0, [zy]	# zy.89_3, zy
	ld.w	r2, [r0]	# _4, *zy.89_3
	mov.w	r0, sp	# tmp41,
	st.w	[r0 + (4)], r2	#, _4
	st.w	[r0], r1	#, _2
	call	xy		#
# snakes.c:104:   xy(zx[0], zy[0]); printf("@");
	mov.w	r1, sp	# tmp42,
	mov.w	r0, 64	# tmp43,
	st.w	[r1], r0	#, tmp43
	call	putchar		#
# snakes.c:105:   for (i = 1; i <= N; i++)
	mov.w	r0, 1	# tmp44,
	st.w	[r13 + (-4)], r0	# i, tmp44
# snakes.c:105:   for (i = 1; i <= N; i++)
	j	.L27		#
.L28:
# snakes.c:107:     xy(zx[i], zy[i]); printf("O");
	ld.w	r0, [zx]	# zx.90_5, zx
	ld.w	r1, [r13 + (-4)]	# i.91_6, i
	mov.w	r2, 2	# tmp45,
	shl.w	r1, r2	# _7, tmp45
	add.w	r0, r1 #222	# _8, _7
# snakes.c:107:     xy(zx[i], zy[i]); printf("O");
	ld.w	r1, [r0]	# _9, *_8
# snakes.c:107:     xy(zx[i], zy[i]); printf("O");
	ld.w	r0, [zy]	# zy.92_10, zy
	ld.w	r2, [r13 + (-4)]	# i.93_11, i
	mov.w	r3, 2	# tmp46,
	shl.w	r2, r3	# _12, tmp46
	add.w	r0, r2 #222	# _13, _12
# snakes.c:107:     xy(zx[i], zy[i]); printf("O");
	ld.w	r2, [r0]	# _14, *_13
	mov.w	r0, sp	# tmp47,
	st.w	[r0 + (4)], r2	#, _14
	st.w	[r0], r1	#, _9
	call	xy		#
# snakes.c:107:     xy(zx[i], zy[i]); printf("O");
	mov.w	r1, sp	# tmp48,
	mov.w	r0, 79	# tmp49,
	st.w	[r1], r0	#, tmp49
	call	putchar		#
# snakes.c:105:   for (i = 1; i <= N; i++)
	ld.w	r0, [r13 + (-4)]	# tmp51, i
	add.w	r0, 1 #111	# tmp50,
	st.w	[r13 + (-4)], r0	# i, tmp50
.L27:
# snakes.c:105:   for (i = 1; i <= N; i++)
	ld.w	r0, [N]	# N.94_15, N
# snakes.c:105:   for (i = 1; i <= N; i++)
	ld.w	r1, [r13 + (-4)]	# tmp52, i
	cmp.w	r1, r0	# tmp52, N.94_15
	jses	.L28		#
# snakes.c:109: }
	nop	
	nop	
	mov.w	sp, r13	#,
	pop	r13		#
	ret	
	.size	IscrtajZmiju, .-IscrtajZmiju
	.p2align	1
	.global	IzracunajPolozajGlave
	.type	IzracunajPolozajGlave, @function
IzracunajPolozajGlave:
	push	r13		#
	mov.w	r13, sp	#,
# snakes.c:113:   switch(smer)
	ld.w	r0, [smer]	# smer.95_1, smer
	mov.w	r1, 3	# tmp47,
	cmp.w	r0, r1	# smer.95_1, tmp47
	jz	.L30		#
	mov.w	r1, 3	# tmp48,
	cmp.w	r0, r1	# smer.95_1, tmp48
	jgs	.L35		#
	mov.w	r1, 2	# tmp49,
	cmp.w	r0, r1	# smer.95_1, tmp49
	jz	.L32		#
	mov.w	r1, 2	# tmp50,
	cmp.w	r0, r1	# smer.95_1, tmp50
	jgs	.L35		#
	xor.w	r1, r1	# tmp51
	cmp.w	r0, r1	# smer.95_1, tmp51
	jz	.L33		#
	mov.w	r1, 1	# tmp52,
	cmp.w	r0, r1	# smer.95_1, tmp52
	jz	.L34		#
# snakes.c:120: }
	j	.L35		#
.L33:
# snakes.c:115:   	case 0: {*x = zx[0]; 		 *y = zy[0] - 1; 	break;}
	ld.w	r0, [zx]	# zx.96_2, zx
	ld.w	r1, [r0]	# _3, *zx.96_2
# snakes.c:115:   	case 0: {*x = zx[0]; 		 *y = zy[0] - 1; 	break;}
	ld.w	r0, [r13 + (8)]	# tmp53, x
	st.w	[r0], r1	# *x_24(D), _3
# snakes.c:115:   	case 0: {*x = zx[0]; 		 *y = zy[0] - 1; 	break;}
	ld.w	r0, [zy]	# zy.97_4, zy
	ld.w	r0, [r0]	# _5, *zy.97_4
# snakes.c:115:   	case 0: {*x = zx[0]; 		 *y = zy[0] - 1; 	break;}
	mov.w	r1, r0	# _6, _5
	add.w	r1, -1 #111	# _6,
# snakes.c:115:   	case 0: {*x = zx[0]; 		 *y = zy[0] - 1; 	break;}
	ld.w	r0, [r13 + (12)]	# tmp54, y
	st.w	[r0], r1	# *y_26(D), _6
# snakes.c:115:   	case 0: {*x = zx[0]; 		 *y = zy[0] - 1; 	break;}
	j	.L31		#
.L34:
# snakes.c:116:   	case 1: {*x = zx[0] + 1; *y = zy[0]; 			break;}
	ld.w	r0, [zx]	# zx.98_7, zx
	ld.w	r0, [r0]	# _8, *zx.98_7
# snakes.c:116:   	case 1: {*x = zx[0] + 1; *y = zy[0]; 			break;}
	mov.w	r1, r0	# _9, _8
	add.w	r1, 1 #111	# _9,
# snakes.c:116:   	case 1: {*x = zx[0] + 1; *y = zy[0]; 			break;}
	ld.w	r0, [r13 + (8)]	# tmp55, x
	st.w	[r0], r1	# *x_24(D), _9
# snakes.c:116:   	case 1: {*x = zx[0] + 1; *y = zy[0]; 			break;}
	ld.w	r0, [zy]	# zy.99_10, zy
	ld.w	r1, [r0]	# _11, *zy.99_10
# snakes.c:116:   	case 1: {*x = zx[0] + 1; *y = zy[0]; 			break;}
	ld.w	r0, [r13 + (12)]	# tmp56, y
	st.w	[r0], r1	# *y_26(D), _11
# snakes.c:116:   	case 1: {*x = zx[0] + 1; *y = zy[0]; 			break;}
	j	.L31		#
.L32:
# snakes.c:117:   	case 2: {*x = zx[0]; 		 *y = zy[0] + 1; 	break;}
	ld.w	r0, [zx]	# zx.100_12, zx
	ld.w	r1, [r0]	# _13, *zx.100_12
# snakes.c:117:   	case 2: {*x = zx[0]; 		 *y = zy[0] + 1; 	break;}
	ld.w	r0, [r13 + (8)]	# tmp57, x
	st.w	[r0], r1	# *x_24(D), _13
# snakes.c:117:   	case 2: {*x = zx[0]; 		 *y = zy[0] + 1; 	break;}
	ld.w	r0, [zy]	# zy.101_14, zy
	ld.w	r0, [r0]	# _15, *zy.101_14
# snakes.c:117:   	case 2: {*x = zx[0]; 		 *y = zy[0] + 1; 	break;}
	mov.w	r1, r0	# _16, _15
	add.w	r1, 1 #111	# _16,
# snakes.c:117:   	case 2: {*x = zx[0]; 		 *y = zy[0] + 1; 	break;}
	ld.w	r0, [r13 + (12)]	# tmp58, y
	st.w	[r0], r1	# *y_26(D), _16
# snakes.c:117:   	case 2: {*x = zx[0]; 		 *y = zy[0] + 1; 	break;}
	j	.L31		#
.L30:
# snakes.c:118:   	case 3: {*x = zx[0] - 1; *y = zy[0]; 			break;}
	ld.w	r0, [zx]	# zx.102_17, zx
	ld.w	r0, [r0]	# _18, *zx.102_17
# snakes.c:118:   	case 3: {*x = zx[0] - 1; *y = zy[0]; 			break;}
	mov.w	r1, r0	# _19, _18
	add.w	r1, -1 #111	# _19,
# snakes.c:118:   	case 3: {*x = zx[0] - 1; *y = zy[0]; 			break;}
	ld.w	r0, [r13 + (8)]	# tmp59, x
	st.w	[r0], r1	# *x_24(D), _19
# snakes.c:118:   	case 3: {*x = zx[0] - 1; *y = zy[0]; 			break;}
	ld.w	r0, [zy]	# zy.103_20, zy
	ld.w	r1, [r0]	# _21, *zy.103_20
# snakes.c:118:   	case 3: {*x = zx[0] - 1; *y = zy[0]; 			break;}
	ld.w	r0, [r13 + (12)]	# tmp60, y
	st.w	[r0], r1	# *y_26(D), _21
# snakes.c:118:   	case 3: {*x = zx[0] - 1; *y = zy[0]; 			break;}
	nop	
.L31:
.L35:
# snakes.c:120: }
	nop	
	mov.w	sp, r13	#,
	pop	r13		#
	ret	
	.size	IzracunajPolozajGlave, .-IzracunajPolozajGlave
	.p2align	1
	.global	UKolizijiSaZidom
	.type	UKolizijiSaZidom, @function
UKolizijiSaZidom:
	push	r13		#
	mov.w	r13, sp	#,
# snakes.c:124:   return (x == 1) || (x == 80) || (y == 2) || (y == 25);
	ld.w	r1, [r13 + (8)]	# tmp28, x
	mov.w	r0, 1	# tmp29,
	cmp.w	r1, r0	# tmp28, tmp29
	jz	.L37		#
# snakes.c:124:   return (x == 1) || (x == 80) || (y == 2) || (y == 25);
	ld.w	r1, [r13 + (8)]	# tmp30, x
	mov.w	r0, 80	# tmp31,
	cmp.w	r1, r0	# tmp30, tmp31
	jz	.L37		#
# snakes.c:124:   return (x == 1) || (x == 80) || (y == 2) || (y == 25);
	ld.w	r1, [r13 + (12)]	# tmp32, y
	mov.w	r0, 2	# tmp33,
	cmp.w	r1, r0	# tmp32, tmp33
	jz	.L37		#
# snakes.c:124:   return (x == 1) || (x == 80) || (y == 2) || (y == 25);
	ld.w	r1, [r13 + (12)]	# tmp34, y
	mov.w	r0, 25	# tmp35,
	cmp.w	r1, r0	# tmp34, tmp35
	jnz	.L38		#
.L37:
	mov.w	r0, 1	# iftmp.104_1,
	j	.L40		#
.L38:
	xor.w	r0, r0	# iftmp.104_1
.L40:
# snakes.c:125: }
	mov.w	sp, r13	#,
	pop	r13		#
	ret	
	.size	UKolizijiSaZidom, .-UKolizijiSaZidom
	.p2align	1
	.global	UKolizijiSaRepom
	.type	UKolizijiSaRepom, @function
UKolizijiSaRepom:
	push	r13		#
	mov.w	r13, sp	#,
	sub.w	sp, 4 #111	#,
# snakes.c:130:   zx[N + 1] = x;
	ld.w	r0, [zx]	# zx.105_1, zx
	ld.w	r1, [N]	# N.106_2, N
	add.w	r1, 1 #111	# _4,
	mov.w	r2, 2	# tmp52,
	shl.w	r1, r2	# _5, tmp52
	add.w	r0, r1 #222	# _6, _5
# snakes.c:130:   zx[N + 1] = x;
	ld.w	r1, [r13 + (8)]	# tmp53, x
	st.w	[r0], r1	# *_6, tmp53
# snakes.c:131:   zy[N + 1] = y;
	ld.w	r0, [zy]	# zy.108_7, zy
	ld.w	r1, [N]	# N.109_8, N
	add.w	r1, 1 #111	# _10,
	mov.w	r2, 2	# tmp54,
	shl.w	r1, r2	# _11, tmp54
	add.w	r0, r1 #222	# _12, _11
# snakes.c:131:   zy[N + 1] = y;
	ld.w	r1, [r13 + (12)]	# tmp55, y
	st.w	[r0], r1	# *_12, tmp55
# snakes.c:132:   i = 1;
	mov.w	r0, 1	# tmp56,
	st.w	[r13 + (-4)], r0	# i, tmp56
# snakes.c:133:   while ((x != zx[i]) || (y != zy[i])) i = i + 1;
	j	.L42		#
.L43:
# snakes.c:133:   while ((x != zx[i]) || (y != zy[i])) i = i + 1;
	ld.w	r0, [r13 + (-4)]	# tmp58, i
	add.w	r0, 1 #111	# tmp57,
	st.w	[r13 + (-4)], r0	# i, tmp57
.L42:
# snakes.c:133:   while ((x != zx[i]) || (y != zy[i])) i = i + 1;
	ld.w	r0, [zx]	# zx.111_13, zx
	ld.w	r1, [r13 + (-4)]	# i.112_14, i
	mov.w	r2, 2	# tmp59,
	shl.w	r1, r2	# _15, tmp59
	add.w	r0, r1 #222	# _16, _15
	ld.w	r0, [r0]	# _17, *_16
# snakes.c:133:   while ((x != zx[i]) || (y != zy[i])) i = i + 1;
	ld.w	r1, [r13 + (8)]	# tmp60, x
	cmp.w	r1, r0	# tmp60, _17
	jnz	.L43		#
# snakes.c:133:   while ((x != zx[i]) || (y != zy[i])) i = i + 1;
	ld.w	r0, [zy]	# zy.113_18, zy
	ld.w	r1, [r13 + (-4)]	# i.114_19, i
	mov.w	r2, 2	# tmp61,
	shl.w	r1, r2	# _20, tmp61
	add.w	r0, r1 #222	# _21, _20
	ld.w	r0, [r0]	# _22, *_21
# snakes.c:133:   while ((x != zx[i]) || (y != zy[i])) i = i + 1;
	ld.w	r1, [r13 + (12)]	# tmp62, y
	cmp.w	r1, r0	# tmp62, _22
	jnz	.L43		#
# snakes.c:134:   return i <= N;
	ld.w	r1, [N]	# N.115_23, N
	mov.b	r0, 1	# _24,
	ld.w	r2, [r13 + (-4)]	# tmp63, i
	cmp.w	r2, r1	# tmp63, N.115_23
	jses	.L44		#
	xor.w	r0, r0	# _24
.L44:
	zex.b	r0, r0	# _32, _24
# snakes.c:135: }
	mov.w	sp, r13	#,
	pop	r13		#
	ret	
	.size	UKolizijiSaRepom, .-UKolizijiSaRepom
	.p2align	1
	.global	PomeriZmiju
	.type	PomeriZmiju, @function
PomeriZmiju:
	push	r13		#
	mov.w	r13, sp	#,
	sub.w	sp, 36 #111	#,
# snakes.c:142:   IzracunajPolozajGlave(&x, &y);
	mov.w	r0, sp	# tmp118,
	mov.w	r1, r13	# tmp119,
	add.w	r1, -12 #111	# tmp119,
	st.w	[r0 + (4)], r1	#, tmp119
	mov.w	r1, r13	# tmp120,
	add.w	r1, -8 #111	# tmp120,
	st.w	[r0], r1	#, tmp120
	call	IzracunajPolozajGlave		#
# snakes.c:144:   if (UKolizijiSaZidom(x, y) || UKolizijiSaRepom(x, y))
	ld.w	r1, [r13 + (-8)]	# x.116_1, x
	ld.w	r2, [r13 + (-12)]	# y.117_2, y
	mov.w	r0, sp	# tmp121,
	st.w	[r0 + (4)], r2	#, y.117_2
	st.w	[r0], r1	#, x.116_1
	call	UKolizijiSaZidom		#
	mov.w	r1, r0	# _3,
# snakes.c:144:   if (UKolizijiSaZidom(x, y) || UKolizijiSaRepom(x, y))
	xor.w	r0, r0	# tmp122
	cmp.w	r1, r0	# _3, tmp122
	jnz	.L47		#
# snakes.c:144:   if (UKolizijiSaZidom(x, y) || UKolizijiSaRepom(x, y))
	ld.w	r1, [r13 + (-8)]	# x.118_4, x
	ld.w	r2, [r13 + (-12)]	# y.119_5, y
	mov.w	r0, sp	# tmp123,
	st.w	[r0 + (4)], r2	#, y.119_5
	st.w	[r0], r1	#, x.118_4
	call	UKolizijiSaRepom		#
	mov.w	r1, r0	# _6,
# snakes.c:144:   if (UKolizijiSaZidom(x, y) || UKolizijiSaRepom(x, y))
	xor.w	r0, r0	# tmp124
	cmp.w	r1, r0	# _6, tmp124
	jz	.L48		#
.L47:
# snakes.c:146:     kraj = 1;
	mov.w	r0, 1	# tmp125,
	st.w	[kraj], r0	# kraj, tmp125
# snakes.c:147:     xy(x, y);
	ld.w	r1, [r13 + (-8)]	# x.120_7, x
	ld.w	r2, [r13 + (-12)]	# y.121_8, y
	mov.w	r0, sp	# tmp126,
	st.w	[r0 + (4)], r2	#, y.121_8
	st.w	[r0], r1	#, x.120_7
	call	xy		#
# snakes.c:148:     printf("X");
	mov.w	r1, sp	# tmp127,
	mov.w	r0, 88	# tmp128,
	st.w	[r1], r0	#, tmp128
	call	putchar		#
	j	.L49		#
.L48:
# snakes.c:150:   else if ((x == sx) && (y == sy)) 
	ld.w	r1, [r13 + (-8)]	# x.122_9, x
	ld.w	r0, [sx]	# sx.123_10, sx
# snakes.c:150:   else if ((x == sx) && (y == sy)) 
	cmp.w	r1, r0	# x.122_9, sx.123_10
	jnz	.L50		#
# snakes.c:150:   else if ((x == sx) && (y == sy)) 
	ld.w	r1, [r13 + (-12)]	# y.124_11, y
	ld.w	r0, [sy]	# sy.125_12, sy
# snakes.c:150:   else if ((x == sx) && (y == sy)) 
	cmp.w	r1, r0	# y.124_11, sy.125_12
	jnz	.L50		#
# snakes.c:152:     xy(zx[0], zy[0]); printf("O");
	ld.w	r0, [zx]	# zx.126_13, zx
	ld.w	r1, [r0]	# _14, *zx.126_13
	ld.w	r0, [zy]	# zy.127_15, zy
	ld.w	r2, [r0]	# _16, *zy.127_15
	mov.w	r0, sp	# tmp129,
	st.w	[r0 + (4)], r2	#, _16
	st.w	[r0], r1	#, _14
	call	xy		#
# snakes.c:152:     xy(zx[0], zy[0]); printf("O");
	mov.w	r1, sp	# tmp130,
	mov.w	r0, 79	# tmp131,
	st.w	[r1], r0	#, tmp131
	call	putchar		#
# snakes.c:153:     xy(x, y); printf("@");
	ld.w	r1, [r13 + (-8)]	# x.128_17, x
	ld.w	r2, [r13 + (-12)]	# y.129_18, y
	mov.w	r0, sp	# tmp132,
	st.w	[r0 + (4)], r2	#, y.129_18
	st.w	[r0], r1	#, x.128_17
	call	xy		#
# snakes.c:153:     xy(x, y); printf("@");
	mov.w	r1, sp	# tmp133,
	mov.w	r0, 64	# tmp134,
	st.w	[r1], r0	#, tmp134
	call	putchar		#
# snakes.c:154:     N = N + 1;
	ld.w	r0, [N]	# N.130_19, N
	add.w	r0, 1 #111	# _20,
# snakes.c:154:     N = N + 1;
	st.w	[N], r0	# N, _20
# snakes.c:155:     for (i = N; i >= 1; i--)
	ld.w	r0, [N]	# tmp135, N
	st.w	[r13 + (-4)], r0	# i, tmp135
# snakes.c:155:     for (i = N; i >= 1; i--)
	j	.L51		#
.L52:
# snakes.c:157:       zx[i] =zx[i-1];
	ld.w	r1, [zx]	# zx.131_21, zx
	ld.w	r0, [r13 + (-4)]	# i.132_22, i
	mov.w	r2, 1073741823	# tmp136,
	add.w	r0, r2 #222	# _23, tmp136
	mov.w	r2, 2	# tmp137,
	shl.w	r0, r2	# _24, tmp137
	add.w	r1, r0 #222	# _25, _24
# snakes.c:157:       zx[i] =zx[i-1];
	ld.w	r0, [zx]	# zx.133_26, zx
	ld.w	r2, [r13 + (-4)]	# i.134_27, i
	mov.w	r3, 2	# tmp138,
	shl.w	r2, r3	# _28, tmp138
	add.w	r0, r2 #222	# _29, _28
# snakes.c:157:       zx[i] =zx[i-1];
	ld.w	r1, [r1]	# _30, *_25
# snakes.c:157:       zx[i] =zx[i-1];
	st.w	[r0], r1	# *_29, _30
# snakes.c:158:       zy[i] =zy[i-1];
	ld.w	r1, [zy]	# zy.135_31, zy
	ld.w	r0, [r13 + (-4)]	# i.136_32, i
	mov.w	r2, 1073741823	# tmp139,
	add.w	r0, r2 #222	# _33, tmp139
	mov.w	r2, 2	# tmp140,
	shl.w	r0, r2	# _34, tmp140
	add.w	r1, r0 #222	# _35, _34
# snakes.c:158:       zy[i] =zy[i-1];
	ld.w	r0, [zy]	# zy.137_36, zy
	ld.w	r2, [r13 + (-4)]	# i.138_37, i
	mov.w	r3, 2	# tmp141,
	shl.w	r2, r3	# _38, tmp141
	add.w	r0, r2 #222	# _39, _38
# snakes.c:158:       zy[i] =zy[i-1];
	ld.w	r1, [r1]	# _40, *_35
# snakes.c:158:       zy[i] =zy[i-1];
	st.w	[r0], r1	# *_39, _40
# snakes.c:155:     for (i = N; i >= 1; i--)
	ld.w	r0, [r13 + (-4)]	# tmp143, i
	add.w	r0, -1 #111	# tmp142,
	st.w	[r13 + (-4)], r0	# i, tmp142
.L51:
# snakes.c:155:     for (i = N; i >= 1; i--)
	ld.w	r1, [r13 + (-4)]	# tmp144, i
	xor.w	r0, r0	# tmp145
	cmp.w	r1, r0	# tmp144, tmp145
	jgs	.L52		#
# snakes.c:161:     zx[0] = x;
	ld.w	r0, [zx]	# zx.139_41, zx
# snakes.c:161:     zx[0] = x;
	ld.w	r1, [r13 + (-8)]	# x.140_42, x
	st.w	[r0], r1	# *zx.139_41, x.140_42
# snakes.c:162:     zy[0] = y;
	ld.w	r0, [zy]	# zy.141_43, zy
# snakes.c:162:     zy[0] = y;
	ld.w	r1, [r13 + (-12)]	# y.142_44, y
	st.w	[r0], r1	# *zy.141_43, y.142_44
# snakes.c:163:     Poeni = Poeni + 10;
	ld.w	r0, [Poeni]	# Poeni.143_45, Poeni
	add.w	r0, 10 #111	# _46,
# snakes.c:163:     Poeni = Poeni + 10;
	st.w	[Poeni], r0	# Poeni, _46
# snakes.c:164:     IspisiStatus();
	call	IspisiStatus		#
# snakes.c:165:     IzracunajZvezdu();
	call	IzracunajZvezdu		#
# snakes.c:166:     xy(sx, sy); printf("*");
	ld.w	r1, [sx]	# sx.144_47, sx
	ld.w	r2, [sy]	# sy.145_48, sy
	mov.w	r0, sp	# tmp146,
	st.w	[r0 + (4)], r2	#, sy.145_48
	st.w	[r0], r1	#, sx.144_47
	call	xy		#
# snakes.c:166:     xy(sx, sy); printf("*");
	mov.w	r1, sp	# tmp147,
	mov.w	r0, 42	# tmp148,
	st.w	[r1], r0	#, tmp148
	call	putchar		#
# snakes.c:167:     Usporenje -= 5;
	ld.w	r0, [Usporenje]	# Usporenje.146_49, Usporenje
	add.w	r0, -5 #111	# _50,
	st.w	[Usporenje], r0	# Usporenje, _50
	j	.L49		#
.L50:
# snakes.c:171:     xy(zx[N], zy[N]); printf(" ");
	ld.w	r0, [zx]	# zx.147_51, zx
	ld.w	r1, [N]	# N.148_52, N
	mov.w	r2, 2	# tmp149,
	shl.w	r1, r2	# _54, tmp149
	add.w	r0, r1 #222	# _55, _54
# snakes.c:171:     xy(zx[N], zy[N]); printf(" ");
	ld.w	r1, [r0]	# _56, *_55
# snakes.c:171:     xy(zx[N], zy[N]); printf(" ");
	ld.w	r0, [zy]	# zy.150_57, zy
	ld.w	r2, [N]	# N.151_58, N
	mov.w	r3, 2	# tmp150,
	shl.w	r2, r3	# _60, tmp150
	add.w	r0, r2 #222	# _61, _60
# snakes.c:171:     xy(zx[N], zy[N]); printf(" ");
	ld.w	r2, [r0]	# _62, *_61
	mov.w	r0, sp	# tmp151,
	st.w	[r0 + (4)], r2	#, _62
	st.w	[r0], r1	#, _56
	call	xy		#
# snakes.c:171:     xy(zx[N], zy[N]); printf(" ");
	mov.w	r1, sp	# tmp152,
	mov.w	r0, 32	# tmp153,
	st.w	[r1], r0	#, tmp153
	call	putchar		#
# snakes.c:172:     xy(zx[0], zy[0]); printf("O");
	ld.w	r0, [zx]	# zx.153_63, zx
	ld.w	r1, [r0]	# _64, *zx.153_63
	ld.w	r0, [zy]	# zy.154_65, zy
	ld.w	r2, [r0]	# _66, *zy.154_65
	mov.w	r0, sp	# tmp154,
	st.w	[r0 + (4)], r2	#, _66
	st.w	[r0], r1	#, _64
	call	xy		#
# snakes.c:172:     xy(zx[0], zy[0]); printf("O");
	mov.w	r1, sp	# tmp155,
	mov.w	r0, 79	# tmp156,
	st.w	[r1], r0	#, tmp156
	call	putchar		#
# snakes.c:173:     xy(x, y); printf("@");
	ld.w	r1, [r13 + (-8)]	# x.155_67, x
	ld.w	r2, [r13 + (-12)]	# y.156_68, y
	mov.w	r0, sp	# tmp157,
	st.w	[r0 + (4)], r2	#, y.156_68
	st.w	[r0], r1	#, x.155_67
	call	xy		#
# snakes.c:173:     xy(x, y); printf("@");
	mov.w	r1, sp	# tmp158,
	mov.w	r0, 64	# tmp159,
	st.w	[r1], r0	#, tmp159
	call	putchar		#
# snakes.c:174:     for (i = N; i >= 1; i--)
	ld.w	r0, [N]	# tmp160, N
	st.w	[r13 + (-4)], r0	# i, tmp160
# snakes.c:174:     for (i = N; i >= 1; i--)
	j	.L53		#
.L54:
# snakes.c:176:       zx[i] = zx[i-1];
	ld.w	r1, [zx]	# zx.157_69, zx
	ld.w	r0, [r13 + (-4)]	# i.158_70, i
	mov.w	r2, 1073741823	# tmp161,
	add.w	r0, r2 #222	# _71, tmp161
	mov.w	r2, 2	# tmp162,
	shl.w	r0, r2	# _72, tmp162
	add.w	r1, r0 #222	# _73, _72
# snakes.c:176:       zx[i] = zx[i-1];
	ld.w	r0, [zx]	# zx.159_74, zx
	ld.w	r2, [r13 + (-4)]	# i.160_75, i
	mov.w	r3, 2	# tmp163,
	shl.w	r2, r3	# _76, tmp163
	add.w	r0, r2 #222	# _77, _76
# snakes.c:176:       zx[i] = zx[i-1];
	ld.w	r1, [r1]	# _78, *_73
# snakes.c:176:       zx[i] = zx[i-1];
	st.w	[r0], r1	# *_77, _78
# snakes.c:177:       zy[i] = zy[i-1];
	ld.w	r1, [zy]	# zy.161_79, zy
	ld.w	r0, [r13 + (-4)]	# i.162_80, i
	mov.w	r2, 1073741823	# tmp164,
	add.w	r0, r2 #222	# _81, tmp164
	mov.w	r2, 2	# tmp165,
	shl.w	r0, r2	# _82, tmp165
	add.w	r1, r0 #222	# _83, _82
# snakes.c:177:       zy[i] = zy[i-1];
	ld.w	r0, [zy]	# zy.163_84, zy
	ld.w	r2, [r13 + (-4)]	# i.164_85, i
	mov.w	r3, 2	# tmp166,
	shl.w	r2, r3	# _86, tmp166
	add.w	r0, r2 #222	# _87, _86
# snakes.c:177:       zy[i] = zy[i-1];
	ld.w	r1, [r1]	# _88, *_83
# snakes.c:177:       zy[i] = zy[i-1];
	st.w	[r0], r1	# *_87, _88
# snakes.c:174:     for (i = N; i >= 1; i--)
	ld.w	r0, [r13 + (-4)]	# tmp168, i
	add.w	r0, -1 #111	# tmp167,
	st.w	[r13 + (-4)], r0	# i, tmp167
.L53:
# snakes.c:174:     for (i = N; i >= 1; i--)
	ld.w	r1, [r13 + (-4)]	# tmp169, i
	xor.w	r0, r0	# tmp170
	cmp.w	r1, r0	# tmp169, tmp170
	jgs	.L54		#
# snakes.c:180:     zx[0] = x;
	ld.w	r0, [zx]	# zx.165_89, zx
# snakes.c:180:     zx[0] = x;
	ld.w	r1, [r13 + (-8)]	# x.166_90, x
	st.w	[r0], r1	# *zx.165_89, x.166_90
# snakes.c:181:     zy[0] = y;
	ld.w	r0, [zy]	# zy.167_91, zy
# snakes.c:181:     zy[0] = y;
	ld.w	r1, [r13 + (-12)]	# y.168_92, y
	st.w	[r0], r1	# *zy.167_91, y.168_92
# snakes.c:183: }
	nop	
.L49:
	nop	
	mov.w	sp, r13	#,
	pop	r13		#
	ret	
	.size	PomeriZmiju, .-PomeriZmiju
	.section	.rodata
	.p2align	2
.LC1:
	.string	"!!! KRAJ IGRE [ENTER]/ESC !!!"
	.p2align	2
.LC2:
	.string	"                         "
	.p2align	2
.LC3:
	.string	"                            "
	.text
	.p2align	1
	.global	KrajIgre
	.type	KrajIgre, @function
KrajIgre:
	push	r13		#
	mov.w	r13, sp	#,
	sub.w	sp, 32 #111	#,
# snakes.c:190:   ch = 0;
	xor.w	r0, r0	# tmp29
	st.w	[r13 + (-4)], r0	# ch, tmp29
# snakes.c:191:   flop = 1;
	mov.w	r0, 1	# tmp30,
	st.w	[r13 + (-8)], r0	# flop, tmp30
# snakes.c:192:   while (ch != 13)
	j	.L56		#
.L62:
# snakes.c:194:     xy(40, 1);
	mov.w	r0, sp	# tmp31,
	mov.w	r1, 1	# tmp32,
	st.w	[r0 + (4)], r1	#, tmp32
	mov.w	r1, 40	# tmp33,
	st.w	[r0], r1	#, tmp33
	call	xy		#
# snakes.c:195:     if (flop) 
	ld.w	r1, [r13 + (-8)]	# tmp34, flop
	xor.w	r0, r0	# tmp35
	cmp.w	r1, r0	# tmp34, tmp35
	jz	.L57		#
# snakes.c:196:       printf("!!! KRAJ IGRE [ENTER]/ESC !!!");
	mov.w	r1, sp	# tmp36,
	mov.w	r0, .LC1	# tmp37,
	st.w	[r1], r0	#, tmp37
	call	printf		#
	j	.L58		#
.L57:
# snakes.c:198:       printf("                         ");
	mov.w	r1, sp	# tmp38,
	mov.w	r0, .LC2	# tmp39,
	st.w	[r1], r0	#, tmp39
	call	printf		#
.L58:
# snakes.c:199:     flop = !flop;
	mov.b	r0, 1	# _1,
	ld.w	r2, [r13 + (-8)]	# tmp40, flop
	xor.w	r1, r1	# tmp41
	cmp.w	r2, r1	# tmp40, tmp41
	jz	.L59		#
	xor.w	r0, r0	# _1
.L59:
# snakes.c:199:     flop = !flop;
	zex.b	r0, r0	# tmp42, _1
	st.w	[r13 + (-8)], r0	# flop, tmp42
# snakes.c:200:     ch = is_key_pressed();
	call	is_key_pressed		#
	st.w	[r13 + (-4)], r0	# ch,
# snakes.c:201:     if (ch == 27)
	ld.w	r1, [r13 + (-4)]	# tmp43, ch
	mov.w	r0, 27	# tmp44,
	cmp.w	r1, r0	# tmp43, tmp44
	jnz	.L60		#
# snakes.c:202:     	return 1;
	mov.w	r0, 1	# _4,
	j	.L61		#
.L60:
# snakes.c:203:     delay(200);
	mov.w	r1, sp	# tmp45,
	mov.w	r0, 200	# tmp46,
	st.w	[r1], r0	#, tmp46
	call	delay		#
.L56:
# snakes.c:192:   while (ch != 13)
	ld.w	r1, [r13 + (-4)]	# tmp47, ch
	mov.w	r0, 13	# tmp48,
	cmp.w	r1, r0	# tmp47, tmp48
	jnz	.L62		#
# snakes.c:205:   xy(40, 1);
	mov.w	r0, sp	# tmp49,
	mov.w	r1, 1	# tmp50,
	st.w	[r0 + (4)], r1	#, tmp50
	mov.w	r1, 40	# tmp51,
	st.w	[r0], r1	#, tmp51
	call	xy		#
# snakes.c:206:   printf("                            ");
	mov.w	r1, sp	# tmp52,
	mov.w	r0, .LC3	# tmp53,
	st.w	[r1], r0	#, tmp53
	call	printf		#
# snakes.c:207:   return 0;
	xor.w	r0, r0	# _4
.L61:
# snakes.c:208: }
	mov.w	sp, r13	#,
	pop	r13		#
	ret	
	.size	KrajIgre, .-KrajIgre
	.section	.rodata
	.p2align	2
.LC4:
	.string	"%%%%%%%%%%%%%%"
	.text
	.p2align	1
	.global	main
	.type	main, @function
main:
	push	r13		#
	mov.w	r13, sp	#,
	sub.w	sp, 24 #111	#,
# snakes.c:213: 	current_video_mode = 0;
	xor.w	r0, r0	# tmp42
	st.w	[current_video_mode], r0	# current_video_mode, tmp42
# snakes.c:214: 	video_mode(0);
	mov.w	r1, sp	# tmp43,
	xor.w	r0, r0	# tmp44
	st.w	[r1], r0	#, tmp44
	call	video_mode		#
.L72:
# snakes.c:218: 		Usporenje = 200;
	mov.w	r0, 200	# tmp45,
	st.w	[Usporenje], r0	# Usporenje, tmp45
# snakes.c:219: 	  Poeni = 0;
	xor.w	r0, r0	# tmp46
	st.w	[Poeni], r0	# Poeni, tmp46
# snakes.c:220: 	  kraj = 0;
	xor.w	r0, r0	# tmp47
	st.w	[kraj], r0	# kraj, tmp47
# snakes.c:221: 	  IscrtajOkvir();
	call	IscrtajOkvir		#
# snakes.c:222: 	  IspisiStatus();
	call	IspisiStatus		#
# snakes.c:223: 	  InicijalizujZmiju();
	call	InicijalizujZmiju		#
# snakes.c:224: 	  IscrtajZmiju();
	call	IscrtajZmiju		#
# snakes.c:225: 	  IzracunajZvezdu();
	call	IzracunajZvezdu		#
# snakes.c:226: 	  xy(sx, sy); printf("*");
	ld.w	r1, [sx]	# sx.169_1, sx
	ld.w	r2, [sy]	# sy.170_2, sy
	mov.w	r0, sp	# tmp48,
	st.w	[r0 + (4)], r2	#, sy.170_2
	st.w	[r0], r1	#, sx.169_1
	call	xy		#
# snakes.c:226: 	  xy(sx, sy); printf("*");
	mov.w	r1, sp	# tmp49,
	mov.w	r0, 42	# tmp50,
	st.w	[r1], r0	#, tmp50
	call	putchar		#
# snakes.c:227: 	  while (!kraj)
	j	.L64		#
.L69:
# snakes.c:229: 	      c = is_key_pressed();
	call	is_key_pressed		#
# snakes.c:229: 	      c = is_key_pressed();
	st.w	[c], r0	# c, _3
# snakes.c:230: 	      if ((c == 4000) && (smer != 2)) smer = 0;
	ld.w	r1, [c]	# c.171_4, c
# snakes.c:230: 	      if ((c == 4000) && (smer != 2)) smer = 0;
	mov.w	r0, 4000	# tmp51,
	cmp.w	r1, r0	# c.171_4, tmp51
	jnz	.L65		#
# snakes.c:230: 	      if ((c == 4000) && (smer != 2)) smer = 0;
	ld.w	r1, [smer]	# smer.172_5, smer
# snakes.c:230: 	      if ((c == 4000) && (smer != 2)) smer = 0;
	mov.w	r0, 2	# tmp52,
	cmp.w	r1, r0	# smer.172_5, tmp52
	jz	.L65		#
# snakes.c:230: 	      if ((c == 4000) && (smer != 2)) smer = 0;
	xor.w	r0, r0	# tmp53
	st.w	[smer], r0	# smer, tmp53
	j	.L66		#
.L65:
# snakes.c:231: 	      else if ((c == 4001) && (smer != 1)) smer = 3;
	ld.w	r1, [c]	# c.173_6, c
# snakes.c:231: 	      else if ((c == 4001) && (smer != 1)) smer = 3;
	mov.w	r0, 4001	# tmp54,
	cmp.w	r1, r0	# c.173_6, tmp54
	jnz	.L67		#
# snakes.c:231: 	      else if ((c == 4001) && (smer != 1)) smer = 3;
	ld.w	r1, [smer]	# smer.174_7, smer
# snakes.c:231: 	      else if ((c == 4001) && (smer != 1)) smer = 3;
	mov.w	r0, 1	# tmp55,
	cmp.w	r1, r0	# smer.174_7, tmp55
	jz	.L67		#
# snakes.c:231: 	      else if ((c == 4001) && (smer != 1)) smer = 3;
	mov.w	r0, 3	# tmp56,
	st.w	[smer], r0	# smer, tmp56
	j	.L66		#
.L67:
# snakes.c:232: 	      else if ((c == 4002) && (smer != 0)) smer = 2;
	ld.w	r1, [c]	# c.175_8, c
# snakes.c:232: 	      else if ((c == 4002) && (smer != 0)) smer = 2;
	mov.w	r0, 4002	# tmp57,
	cmp.w	r1, r0	# c.175_8, tmp57
	jnz	.L68		#
# snakes.c:232: 	      else if ((c == 4002) && (smer != 0)) smer = 2;
	ld.w	r1, [smer]	# smer.176_9, smer
# snakes.c:232: 	      else if ((c == 4002) && (smer != 0)) smer = 2;
	xor.w	r0, r0	# tmp58
	cmp.w	r1, r0	# smer.176_9, tmp58
	jz	.L68		#
# snakes.c:232: 	      else if ((c == 4002) && (smer != 0)) smer = 2;
	mov.w	r0, 2	# tmp59,
	st.w	[smer], r0	# smer, tmp59
	j	.L66		#
.L68:
# snakes.c:233: 	      else if ((c == 4003) && (smer != 3)) smer = 1;
	ld.w	r1, [c]	# c.177_10, c
# snakes.c:233: 	      else if ((c == 4003) && (smer != 3)) smer = 1;
	mov.w	r0, 4003	# tmp60,
	cmp.w	r1, r0	# c.177_10, tmp60
	jnz	.L66		#
# snakes.c:233: 	      else if ((c == 4003) && (smer != 3)) smer = 1;
	ld.w	r1, [smer]	# smer.178_11, smer
# snakes.c:233: 	      else if ((c == 4003) && (smer != 3)) smer = 1;
	mov.w	r0, 3	# tmp61,
	cmp.w	r1, r0	# smer.178_11, tmp61
	jz	.L66		#
# snakes.c:233: 	      else if ((c == 4003) && (smer != 3)) smer = 1;
	mov.w	r0, 1	# tmp62,
	st.w	[smer], r0	# smer, tmp62
.L66:
# snakes.c:234: 	    	PomeriZmiju();
	call	PomeriZmiju		#
# snakes.c:235: 	    	delay(Usporenje);
	ld.w	r0, [Usporenje]	# Usporenje.179_12, Usporenje
	mov.w	r1, sp	# tmp63,
	st.w	[r1], r0	#, Usporenje.179_12
	call	delay		#
.L64:
# snakes.c:227: 	  while (!kraj)
	ld.w	r1, [kraj]	# kraj.180_13, kraj
# snakes.c:227: 	  while (!kraj)
	xor.w	r0, r0	# tmp64
	cmp.w	r1, r0	# kraj.180_13, tmp64
	jz	.L69		#
# snakes.c:237: 	  if (KrajIgre())
	call	KrajIgre		#
	mov.w	r1, r0	# _14,
# snakes.c:237: 	  if (KrajIgre())
	xor.w	r0, r0	# tmp65
	cmp.w	r1, r0	# _14, tmp65
	jnz	.L75		#
# snakes.c:239: 	  printf("%%%%%%%%%%%%%%");
	mov.w	r1, sp	# tmp66,
	mov.w	r0, .LC4	# tmp67,
	st.w	[r1], r0	#, tmp67
	call	printf		#
# snakes.c:218: 		Usporenje = 200;
	j	.L72		#
.L75:
# snakes.c:238: 	  	break;
	nop	
	xor.w	r0, r0	# _33
# snakes.c:241: }
	mov.w	sp, r13	#,
	pop	r13		#
	ret	
	.size	main, .-main
	.ident	"GCC: (GNU) 10.0.0 20200111 (experimental)"