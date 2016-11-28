# ruby ffi and D

## 環境

- 言語

```
( ՞ਊ ՞) :~/dev/dlang $ ruby -v
ruby 2.3.3p222 (2016-11-21 revision 56859) [x86_64-linux]
( ՞ਊ ՞) :~/dev/dlang $ dmd --version
DMD64 D Compiler v2.072.0
Copyright (c) 1999-2016 by Digital Mars written by Walter Bright
```

- OS

```
( ՞ਊ ՞) :~/dev/dlang $ cat /proc/version
Linux version 4.8.0-27-generic (buildd@lgw01-11) (gcc version 6.2.0 20161005 (Ubuntu 6.2.0-5ubuntu12) ) #29-Ubuntu SMP Thu Oct 20 21:03:13 UTC 2016
```

## 実行

```
( ՞ਊ ՞) :~/dev/dlang/ffi $ dmd -g -shared -fPIC hoge.d
( ՞ਊ ՞) :~/dev/dlang/ffi $ gdb --quiet --args `rbenv which ruby` ./hoge.rb
Reading symbols from /home/kubo39/.anyenv/envs/rbenv/versions/2.3.3/bin/ruby...done.
(gdb) r
Starting program: /home/kubo39/.anyenv/envs/rbenv/versions/2.3.3/bin/ruby ./hoge.rb
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7ffff7ff4700 (LWP 17911)]

Thread 1 "ruby" received signal SIGSEGV, Segmentation fault.
0x00007ffff5a3eb04 in gc_malloc () from /home/kubo39/dlang/dmd-2.072.0/linux/lib64/libphobos2.so.0.72
(gdb) bt
#0  0x00007ffff5a3eb04 in gc_malloc () from /home/kubo39/dlang/dmd-2.072.0/linux/lib64/libphobos2.so.0.72
#1  0x00007ffff5a5bd1f in _d_newclass () from /home/kubo39/dlang/dmd-2.072.0/linux/lib64/libphobos2.so.0.72
#2  0x00007ffff5928a10 in std.exception.bailOut!(Exception).bailOut(immutable(char)[], ulong, const(char[])) () from /home/kubo39/dlang/dmd-2.072.0/linux/lib64/libphobos2.so.0.72
#3  0x00007ffff59289de in std.exception.enforce!(Exception, bool).enforce(bool, lazy const(char)[], immutable(char)[], ulong) () from /home/kubo39/dlang/dmd-2.072.0/linux/lib64/libphobos2.so.0.72
#4  0x00007ffff5968482 in std.stdio.File.LockingTextWriter.this(ref std.stdio.File) () from /home/kubo39/dlang/dmd-2.072.0/linux/lib64/libphobos2.so.0.72
#5  0x00007ffff596856c in std.stdio.File.lockingTextWriter() () from /home/kubo39/dlang/dmd-2.072.0/linux/lib64/libphobos2.so.0.72
#6  0x00007ffff5e19947 in std.stdio.writeln!(immutable(char)[]).writeln(immutable(char)[]) (_param_0=...) at /home/kubo39/dlang/dmd-2.072.0/linux/bin64/../../src/phobos/std/stdio.d:3436
#7  0x00007ffff5e198bf in fib (n=40) at hoge.d:8
#8  0x00007ffff6021e18 in ffi_call_unix64 () from /usr/lib/x86_64-linux-gnu/libffi.so.6
#9  0x00007ffff602187a in ffi_call () from /usr/lib/x86_64-linux-gnu/libffi.so.6
#10 0x00007ffff6231720 in rbffi_CallFunction (argc=<optimized out>, argv=<optimized out>, function=0x7ffff5e198a0 <fib>, fnInfo=0x555555ef05e0) at Call.c:430
#11 0x00007ffff6233f56 in custom_trampoline (argc=<optimized out>, argv=<optimized out>, self=<optimized out>, handle=<optimized out>) at MethodHandle.c:232
#12 0x00005555556bd90d in vm_call_cfunc_with_frame (ci=<optimized out>, cc=<optimized out>, calling=<optimized out>, reg_cfp=0x7ffff7fc0f90, th=0x555555a52610) at vm_insnhelper.c:1642
#13 vm_call_cfunc (th=0x555555a52610, reg_cfp=0x7ffff7fc0f90, calling=<optimized out>, ci=<optimized out>, cc=<optimized out>) at vm_insnhelper.c:1737
#14 0x00005555556ca3fe in vm_call_method_each_type (th=th@entry=0x555555a52610, cfp=cfp@entry=0x7ffff7fc0f90, calling=0x7fffffffca30, ci=<optimized out>, cc=<optimized out>) at vm_insnhelper.c:2026
#15 0x00005555556ca953 in vm_call_method (th=0x555555a52610, cfp=0x7ffff7fc0f90, calling=<optimized out>, ci=<optimized out>, cc=<optimized out>) at vm_insnhelper.c:2176
#16 0x00005555556c4329 in vm_exec_core (th=th@entry=0x555555a52610, initial=initial@entry=0) at insns.def:994
#17 0x00005555556c935f in vm_exec (th=0x555555a52610) at vm.c:1650
#18 0x00005555556d2233 in rb_iseq_eval_main (iseq=iseq@entry=0x555555c5fcd8) at vm.c:1893
#19 0x000055555557846a in ruby_exec_internal (n=0x555555c5fcd8) at eval.c:245
#20 0x000055555557c00f in ruby_exec_node (n=<optimized out>) at eval.c:310
#21 ruby_run_node (n=<optimized out>) at eval.c:302
#22 0x000055555557803b in main (argc=<optimized out>, argv=<optimized out>) at main.c:36
```
