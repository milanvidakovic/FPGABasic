	.file	"test.c"
# GNU C17 (GCC) version 10.0.0 20200111 (experimental) (moxiebox)
#	compiled by GNU C version 7.4.0, GMP version 6.1.2, MPFR version 4.0.1, MPC version 1.1.0, isl version none
# GGC heuristics: --param ggc-min-expand=30 --param ggc-min-heapsize=4096
# options passed:  test.c -mel -auxbase-strip test.s -fverbose-asm
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
	.global	_history
	.section	.bss,"aw",@nobits
	.type	_history, @object
	.size	_history, 1024
_history:
	.zero	1024
	.global	n
	.p2align	2
	.type	n, @object
	.size	n, 40
n:
	.zero	40
	.section	.rodata
	.p2align	2
.LC0:
	.string	"tekst"
	.p2align	2
.LC1:
	.string	"%d, %d\n"
	.p2align	2
.LC2:
	.string	"2"
	.p2align	2
.LC3:
	.string	"Starting counting (10 million)..."
	.p2align	2
.LC4:
	.string	"start time:\t%d\n"
	.p2align	2
.LC5:
	.string	"end time:\t%d\n"
	.p2align	2
.LC6:
	.string	"delta: %d, %d\n"
	.text
	.p2align	1
	.global	main
	.type	main, @function
main:
	push	r13		#
	mov.w	r13, sp	#,
	mov.w	r12, 1040	#,
	sub.w	sp, r12 #222	#,
# test.c:12: 	char *d = "tekst";
	mov.w	r0, .LC0	# tmp33,
	st.w	[r13 + (-8)], r0	# d, tmp33
# test.c:15: 	init_stdio();
	call	init_stdio		#
# test.c:16: 	cls();
	call	cls		#
# test.c:18: 	n[3] = 5;
	mov.w	r0, 5	# tmp34,
	st.w	[n+12], r0	# n, tmp34
# test.c:19: 	n[-3] = 6;
	mov.w	r0, 6	# tmp35,
	st.w	[n-12], r0	# n, tmp35
# test.c:20: 	printf("%d, %d\n", n[3], n[-3]);
	ld.w	r1, [n+12]	# _1, n
	ld.w	r2, [n-12]	# _2, n
	mov.w	r0, sp	# tmp36,
	st.w	[r0 + (8)], r2	#, _2
	st.w	[r0 + (4)], r1	#, _1
	mov.w	r1, .LC1	# tmp37,
	st.w	[r0], r1	#, tmp37
	call	printf		#
# test.c:21: 	delay(2000);
	mov.w	r1, sp	# tmp38,
	mov.w	r0, 2000	# tmp39,
	st.w	[r1], r0	#, tmp39
	call	delay		#
# test.c:22: 	printf("2\n");
	mov.w	r1, sp	# tmp40,
	mov.w	r0, .LC2	# tmp41,
	st.w	[r1], r0	#, tmp41
	call	puts		#
# test.c:23: 	printf("Starting counting (10 million)...\n");
	mov.w	r1, sp	# tmp42,
	mov.w	r0, .LC3	# tmp43,
	st.w	[r1], r0	#, tmp43
	call	puts		#
# test.c:24: 	i = get_millis();
	call	get_millis		#
	st.w	[r13 + (-12)], r0	# i,
# test.c:25: 	for (j = 0; j < 10000000; j++) 
	xor.w	r0, r0	# tmp44
	st.w	[r13 + (-4)], r0	# j, tmp44
# test.c:25: 	for (j = 0; j < 10000000; j++) 
	j	.L2		#
.L3:
# test.c:25: 	for (j = 0; j < 10000000; j++) 
	ld.w	r0, [r13 + (-4)]	# tmp46, j
	add.w	r0, 1 #111	# tmp45,
	st.w	[r13 + (-4)], r0	# j, tmp45
.L2:
# test.c:25: 	for (j = 0; j < 10000000; j++) 
	ld.w	r1, [r13 + (-4)]	# tmp47, j
	mov.w	r0, 9999999	# tmp48,
	cmp.w	r1, r0	# tmp47, tmp48
	jses	.L3		#
# test.c:27: 	k = get_millis();
	call	get_millis		#
	st.w	[r13 + (-16)], r0	# k,
# test.c:28: 	printf("start time:\t%d\n", i);
	mov.w	r0, sp	# tmp49,
	ld.w	r1, [r13 + (-12)]	# tmp50, i
	st.w	[r0 + (4)], r1	#, tmp50
	mov.w	r1, .LC4	# tmp51,
	st.w	[r0], r1	#, tmp51
	call	printf		#
# test.c:29: 	printf("end time:\t%d\n", k);
	mov.w	r0, sp	# tmp52,
	ld.w	r1, [r13 + (-16)]	# tmp53, k
	st.w	[r0 + (4)], r1	#, tmp53
	mov.w	r1, .LC5	# tmp54,
	st.w	[r0], r1	#, tmp54
	call	printf		#
# test.c:30: 	printf("delta: %d, %d\n", k - i, (k - i)/1000);
	ld.w	r1, [r13 + (-16)]	# tmp55, k
	ld.w	r0, [r13 + (-12)]	# tmp56, i
	sub.w	r1, r0 #222	# _3, tmp56
# test.c:30: 	printf("delta: %d, %d\n", k - i, (k - i)/1000);
	ld.w	r2, [r13 + (-16)]	# tmp57, k
	ld.w	r0, [r13 + (-12)]	# tmp58, i
	sub.w	r2, r0 #222	# _4, tmp58
# test.c:30: 	printf("delta: %d, %d\n", k - i, (k - i)/1000);
	mov.w	r0, 1000	# tmp59,
	div.w	r2, r0	# _5, tmp59
	mov.w	r0, sp	# tmp60,
	st.w	[r0 + (8)], r2	#, _5
	st.w	[r0 + (4)], r1	#, _3
	mov.w	r1, .LC6	# tmp61,
	st.w	[r0], r1	#, tmp61
	call	printf		#
# test.c:39: 	return 0;
	xor.w	r0, r0	# _25
# test.c:72: }
	mov.w	sp, r13	#,
	pop	r13		#
	ret	
	.size	main, .-main
	.ident	"GCC: (GNU) 10.0.0 20200111 (experimental)"
