%include 'inc/func.inc'
%include 'class/class_string.inc'
%include 'class/class_stream_str.inc'

def_func class/stream_str/write_next
	;inputs
	;r0 = stream_str object
	;outputs
	;r0 = stream_str object
	;trashes
	;all but r0, r4

	ptr inst, old_str, new_str
	ulong length, new_length

	push_scope
	retire {r0}, {inst}

	assign {inst->stream_object - ptr_size}, {old_str}
	assign {inst->stream_bufp - old_str}, {length}
	func_call sys_mem, alloc, {length * 2}, {new_str, new_length}
	func_call sys_mem, copy, {old_str, new_str, length}, {_, inst->stream_bufp}
	assign {new_str + new_length - 1}, {inst->stream_bufe}
	assign {new_str + ptr_size}, {new_str}
	assign {old_str + ptr_size}, {old_str}
	assign {1}, {new_str->ref_count}
	func_call string, deref, {old_str}
	assign {new_str}, {inst->stream_object}

	eval {inst}, {r0}
	pop_scope
	return

def_func_end