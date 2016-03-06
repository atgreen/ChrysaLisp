%include 'inc/func.inc'
%include 'inc/heap.inc'

	fn_function sys/mem_deinit, no_debug_enter
		;get statics
		static_bind mem, statics, r0
		vp_cpy r0, r5

		;14 heaps, from 1KB bytes to 8MB
		for r6, 0, 14, 1
			vp_cpy r5, r0
			static_call heap, deinit
			vp_add hp_heap_size, r5
		next
		vp_ret

	fn_function_end
