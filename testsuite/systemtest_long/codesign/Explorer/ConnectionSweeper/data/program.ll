; ModuleID = 'program.bc'
target datalayout = "E-p:32:32:32-i1:8:8-i8:8:32-i16:16:32-i32:32:32-i64:32:32-f32:32:32-f64:32:32-v64:32:32-v128:32:32-a0:0:32-n32"
target triple = "tce-tut-llvm"

%0 = type { %1 }
%1 = type { [30 x i8*], [30 x i32] }
%2 = type { i32, %struct.__FILE*, %struct.__FILE*, %struct.__FILE*, i32, [25 x i8], i32, i8*, i32, void (%struct._reent*)*, %struct._Bigint*, i32, %struct._Bigint*, %struct._Bigint**, i32, i8*, %3, %struct._atexit*, %struct._atexit, void (i32)**, %struct._glue, [3 x %struct.__FILE] }
%3 = type { %4, [44 x i8] }
%4 = type { i32, i8*, [26 x i8], %struct.__tm, i32, i32, %struct._rand48, %struct._mbstate_t, %struct._mbstate_t, %struct._mbstate_t, [8 x i8], [24 x i8], i32, %struct._mbstate_t, %struct._mbstate_t, %struct._mbstate_t, %struct._mbstate_t, %struct._mbstate_t }
%struct._reent = type { i32, %struct.__FILE*, %struct.__FILE*, %struct.__FILE*, i32, [25 x i8], i32, i8*, i32, void (%struct._reent*)*, %struct._Bigint*, i32, %struct._Bigint*, %struct._Bigint**, i32, i8*, %0, %struct._atexit*, %struct._atexit, void (i32)**, %struct._glue, [3 x %struct.__FILE] }
%struct.__FILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*, i8*, i32)*, i32 (i8*, i8*, i32)*, i32 (i8*, i32, i32)*, i32 (i8*)*, %struct.__sbuf, i8*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i32, %struct._reent*, i32 }
%struct.__sbuf = type { i8*, i32 }
%struct._Bigint = type { %struct._Bigint*, i32, i32, i32, i32, [1 x i32] }
%struct._atexit = type { %struct._atexit*, i32, [32 x void ()*], %struct._on_exit_args }
%struct._on_exit_args = type { [32 x i8*], [32 x i8*], i32, i32 }
%struct._glue = type { %struct._glue*, i32, %struct.__FILE* }
%struct.__tm = type { i32, i32, i32, i32, i32, i32, i32, i32, i32 }
%struct._rand48 = type { [3 x i16], [3 x i16], i16 }
%struct._mbstate_t = type { i32, %struct.anon }
%struct.anon = type { i32 }

@A = internal global [100 x i32] zeroinitializer
@B = internal global [100 x i32] zeroinitializer
@C = internal global [100 x i32] zeroinitializer
@_Output = internal global [100 x i32] zeroinitializer
@_profiling = internal global i32 0
@_global_impure_ptr = internal constant %struct._reent* bitcast (%2* @impure_data to %struct._reent*)
@.str1 = internal constant [2 x i8] c"C\00"
@impure_data = internal global %2 { i32 0, %struct.__FILE* getelementptr (%struct._reent* bitcast (%2* @impure_data to %struct._reent*), i32 0, i32 21, i32 0), %struct.__FILE* getelementptr (%struct._reent* bitcast (%2* @impure_data to %struct._reent*), i32 0, i32 21, i32 1), %struct.__FILE* getelementptr (%struct._reent* bitcast (%2* @impure_data to %struct._reent*), i32 0, i32 21, i32 2), i32 0, [25 x i8] zeroinitializer, i32 0, i8* getelementptr inbounds ([2 x i8]* @.str1, i32 0, i32 0), i32 0, void (%struct._reent*)* null, %struct._Bigint* null, i32 0, %struct._Bigint* null, %struct._Bigint** null, i32 0, i8* null, %3 { %4 { i32 0, i8* null, [26 x i8] zeroinitializer, %struct.__tm zeroinitializer, i32 0, i32 1, %struct._rand48 { [3 x i16] [i16 13070, i16 -21555, i16 4660], [3 x i16] [i16 -6547, i16 -8468, i16 5], i16 11 }, %struct._mbstate_t zeroinitializer, %struct._mbstate_t zeroinitializer, %struct._mbstate_t zeroinitializer, [8 x i8] zeroinitializer, [24 x i8] zeroinitializer, i32 0, %struct._mbstate_t zeroinitializer, %struct._mbstate_t zeroinitializer, %struct._mbstate_t zeroinitializer, %struct._mbstate_t zeroinitializer, %struct._mbstate_t zeroinitializer }, [44 x i8] zeroinitializer }, %struct._atexit* null, %struct._atexit zeroinitializer, void (i32)** null, %struct._glue zeroinitializer, [3 x %struct.__FILE] zeroinitializer }
@_impure_ptr = internal global %struct._reent* bitcast (%2* @impure_data to %struct._reent*)
@end = internal global i8 0

define void @_start() {
entry:
  %tmp = tail call i32 @main()
  tail call void @exit(i32 0)
  unreachable
}

define internal i32 @main() {
entry:
  br label %bb.i

bb.i:                                             ; preds = %bb.i, %entry
  %i.036.0.i = phi i32 [ 0, %entry ], [ %indvar.next40, %bb.i ]
  %tmp2.i = getelementptr [100 x i32]* @A, i32 0, i32 %i.036.0.i
  store i32 1, i32* %tmp2.i, align 4
  %indvar.next40 = add i32 %i.036.0.i, 1
  %exitcond41 = icmp eq i32 %indvar.next40, 100
  br i1 %exitcond41, label %bb10.i, label %bb.i

bb10.i:                                           ; preds = %bb10.i, %bb.i
  %i.141.0.i = phi i32 [ 0, %bb.i ], [ %indvar.next38, %bb10.i ]
  %tmp13.i = getelementptr [100 x i32]* @B, i32 0, i32 %i.141.0.i
  store i32 1, i32* %tmp13.i, align 4
  %indvar.next38 = add i32 %i.141.0.i, 1
  %exitcond39 = icmp eq i32 %indvar.next38, 100
  br i1 %exitcond39, label %bb22.i, label %bb10.i

bb22.i:                                           ; preds = %bb22.i, %bb10.i
  %i.246.i = phi i32 [ 0, %bb10.i ], [ %indvar.next36, %bb22.i ]
  %tmp25.i = getelementptr [100 x i32]* @C, i32 0, i32 %i.246.i
  store i32 0, i32* %tmp25.i, align 4
  %indvar.next36 = add i32 %i.246.i, 1
  %exitcond37 = icmp eq i32 %indvar.next36, 100
  br i1 %exitcond37, label %bb61.outer, label %bb22.i

bb61.outer:                                       ; preds = %bb66, %bb22.i
  %k.0110.0.ph = phi i32 [ 0, %bb22.i ], [ %indvar.next33, %bb66 ]
  %p_c.0.ph.rec = mul i32 %k.0110.0.ph, 10
  %tmp11 = getelementptr [100 x i32]* @B, i32 0, i32 %p_c.0.ph.rec
  %tmp11.sum = add i32 %p_c.0.ph.rec, 1
  %p_b.0125 = getelementptr [100 x i32]* @B, i32 0, i32 %tmp11.sum
  br label %bb8.us

bb8.us:                                           ; preds = %bb8.us, %bb61.outer
  %i.0137.us = phi i32 [ 0, %bb61.outer ], [ %indvar.next30, %bb8.us ]
  %p_a.0136.us.rec = mul i32 %i.0137.us, 10
  %p_a.0136.us = getelementptr [100 x i32]* @A, i32 0, i32 %p_a.0136.us.rec
  %p_c.0.ph.sum = add i32 %p_c.0.ph.rec, %i.0137.us
  %p_c.0135.us = getelementptr [100 x i32]* @C, i32 0, i32 %p_c.0.ph.sum
  %tmp13.us = load i32* %p_a.0136.us, align 4
  %tmp15.us = load i32* %tmp11, align 4
  %tmp16.us = mul i32 %tmp15.us, %tmp13.us
  %p_a.0136.us.sum49 = add i32 %p_a.0136.us.rec, 1
  %p_a.1123.us = getelementptr [100 x i32]* @A, i32 0, i32 %p_a.0136.us.sum49
  %tmp26129.us = load i32* %p_a.1123.us, align 4
  %tmp28130.us = load i32* %p_b.0125, align 4
  %tmp29131.us = mul i32 %tmp28130.us, %tmp26129.us
  %tmp30132.us = add i32 %tmp29131.us, %tmp16.us
  %p_a.0136.us.sum48 = add i32 %p_a.0136.us.rec, 2
  %p_a.1.us = getelementptr [100 x i32]* @A, i32 0, i32 %p_a.0136.us.sum48
  %p_b.0125.sum = add i32 %p_c.0.ph.rec, 2
  %p_b.0.us = getelementptr [100 x i32]* @B, i32 0, i32 %p_b.0125.sum
  %tmp26.us = load i32* %p_a.1.us, align 4
  %tmp28.us = load i32* %p_b.0.us, align 4
  %tmp29.us = mul i32 %tmp28.us, %tmp26.us
  %tmp30.us = add i32 %tmp29.us, %tmp30132.us
  %p_a.0136.us.sum47 = add i32 %p_a.0136.us.rec, 3
  %p_a.1.us.1 = getelementptr [100 x i32]* @A, i32 0, i32 %p_a.0136.us.sum47
  %p_b.0125.sum.1 = add i32 %p_c.0.ph.rec, 3
  %p_b.0.us.1 = getelementptr [100 x i32]* @B, i32 0, i32 %p_b.0125.sum.1
  %tmp26.us.1 = load i32* %p_a.1.us.1, align 4
  %tmp28.us.1 = load i32* %p_b.0.us.1, align 4
  %tmp29.us.1 = mul i32 %tmp28.us.1, %tmp26.us.1
  %tmp30.us.1 = add i32 %tmp29.us.1, %tmp30.us
  %p_a.0136.us.sum46 = add i32 %p_a.0136.us.rec, 4
  %p_a.1.us.2 = getelementptr [100 x i32]* @A, i32 0, i32 %p_a.0136.us.sum46
  %p_b.0125.sum.2 = add i32 %p_c.0.ph.rec, 4
  %p_b.0.us.2 = getelementptr [100 x i32]* @B, i32 0, i32 %p_b.0125.sum.2
  %tmp26.us.2 = load i32* %p_a.1.us.2, align 4
  %tmp28.us.2 = load i32* %p_b.0.us.2, align 4
  %tmp29.us.2 = mul i32 %tmp28.us.2, %tmp26.us.2
  %tmp30.us.2 = add i32 %tmp29.us.2, %tmp30.us.1
  %p_a.0136.us.sum45 = add i32 %p_a.0136.us.rec, 5
  %p_a.1.us.3 = getelementptr [100 x i32]* @A, i32 0, i32 %p_a.0136.us.sum45
  %p_b.0125.sum.3 = add i32 %p_c.0.ph.rec, 5
  %p_b.0.us.3 = getelementptr [100 x i32]* @B, i32 0, i32 %p_b.0125.sum.3
  %tmp26.us.3 = load i32* %p_a.1.us.3, align 4
  %tmp28.us.3 = load i32* %p_b.0.us.3, align 4
  %tmp29.us.3 = mul i32 %tmp28.us.3, %tmp26.us.3
  %tmp30.us.3 = add i32 %tmp29.us.3, %tmp30.us.2
  %p_a.0136.us.sum44 = add i32 %p_a.0136.us.rec, 6
  %p_a.1.us.4 = getelementptr [100 x i32]* @A, i32 0, i32 %p_a.0136.us.sum44
  %p_b.0125.sum.4 = add i32 %p_c.0.ph.rec, 6
  %p_b.0.us.4 = getelementptr [100 x i32]* @B, i32 0, i32 %p_b.0125.sum.4
  %tmp26.us.4 = load i32* %p_a.1.us.4, align 4
  %tmp28.us.4 = load i32* %p_b.0.us.4, align 4
  %tmp29.us.4 = mul i32 %tmp28.us.4, %tmp26.us.4
  %tmp30.us.4 = add i32 %tmp29.us.4, %tmp30.us.3
  %p_a.0136.us.sum43 = add i32 %p_a.0136.us.rec, 7
  %p_a.1.us.5 = getelementptr [100 x i32]* @A, i32 0, i32 %p_a.0136.us.sum43
  %p_b.0125.sum.5 = add i32 %p_c.0.ph.rec, 7
  %p_b.0.us.5 = getelementptr [100 x i32]* @B, i32 0, i32 %p_b.0125.sum.5
  %tmp26.us.5 = load i32* %p_a.1.us.5, align 4
  %tmp28.us.5 = load i32* %p_b.0.us.5, align 4
  %tmp29.us.5 = mul i32 %tmp28.us.5, %tmp26.us.5
  %tmp30.us.5 = add i32 %tmp29.us.5, %tmp30.us.4
  %p_a.0136.us.sum42 = add i32 %p_a.0136.us.rec, 8
  %p_a.1.us.6 = getelementptr [100 x i32]* @A, i32 0, i32 %p_a.0136.us.sum42
  %p_b.0125.sum.6 = add i32 %p_c.0.ph.rec, 8
  %p_b.0.us.6 = getelementptr [100 x i32]* @B, i32 0, i32 %p_b.0125.sum.6
  %tmp26.us.6 = load i32* %p_a.1.us.6, align 4
  %tmp28.us.6 = load i32* %p_b.0.us.6, align 4
  %tmp29.us.6 = mul i32 %tmp28.us.6, %tmp26.us.6
  %tmp30.us.6 = add i32 %tmp29.us.6, %tmp30.us.5
  %p_a.0136.us.sum = add i32 %p_a.0136.us.rec, 9
  %p_a.1.us.7 = getelementptr [100 x i32]* @A, i32 0, i32 %p_a.0136.us.sum
  %p_b.0125.sum.7 = add i32 %p_c.0.ph.rec, 9
  %p_b.0.us.7 = getelementptr [100 x i32]* @B, i32 0, i32 %p_b.0125.sum.7
  %tmp26.us.7 = load i32* %p_a.1.us.7, align 4
  %tmp28.us.7 = load i32* %p_b.0.us.7, align 4
  %tmp29.us.7 = mul i32 %tmp28.us.7, %tmp26.us.7
  %tmp30.us.7 = add i32 %tmp29.us.7, %tmp30.us.6
  store i32 %tmp30.us.7, i32* %p_c.0135.us, align 4
  %indvar.next30 = add i32 %i.0137.us, 1
  %exitcond31 = icmp eq i32 %indvar.next30, 10
  br i1 %exitcond31, label %bb66, label %bb8.us

bb66:                                             ; preds = %bb8.us
  %indvar.next33 = add i32 %k.0110.0.ph, 1
  %exitcond34 = icmp eq i32 %indvar.next33, 10
  br i1 %exitcond34, label %bb76.outer, label %bb61.outer

bb76.outer:                                       ; preds = %bb76.outer, %bb66
  %k.1117.ph = phi i32 [ 0, %bb66 ], [ %indvar.next, %bb76.outer ]
  %tmp85 = getelementptr [100 x i32]* @C, i32 0, i32 %k.1117.ph
  %tmp86 = load i32* %tmp85, align 4
  %tmp87 = getelementptr [100 x i32]* @_Output, i32 0, i32 %k.1117.ph
  store i32 %tmp86, i32* %tmp87, align 4
  %tmp80.1 = add i32 %k.1117.ph, 10
  %tmp85.1 = getelementptr [100 x i32]* @C, i32 0, i32 %tmp80.1
  %tmp86.1 = load i32* %tmp85.1, align 4
  %tmp87.1 = getelementptr [100 x i32]* @_Output, i32 0, i32 %tmp80.1
  store i32 %tmp86.1, i32* %tmp87.1, align 4
  %tmp80.2 = add i32 %k.1117.ph, 20
  %tmp85.2 = getelementptr [100 x i32]* @C, i32 0, i32 %tmp80.2
  %tmp86.2 = load i32* %tmp85.2, align 4
  %tmp87.2 = getelementptr [100 x i32]* @_Output, i32 0, i32 %tmp80.2
  store i32 %tmp86.2, i32* %tmp87.2, align 4
  %tmp80.3 = add i32 %k.1117.ph, 30
  %tmp85.3 = getelementptr [100 x i32]* @C, i32 0, i32 %tmp80.3
  %tmp86.3 = load i32* %tmp85.3, align 4
  %tmp87.3 = getelementptr [100 x i32]* @_Output, i32 0, i32 %tmp80.3
  store i32 %tmp86.3, i32* %tmp87.3, align 4
  %tmp80.4 = add i32 %k.1117.ph, 40
  %tmp85.4 = getelementptr [100 x i32]* @C, i32 0, i32 %tmp80.4
  %tmp86.4 = load i32* %tmp85.4, align 4
  %tmp87.4 = getelementptr [100 x i32]* @_Output, i32 0, i32 %tmp80.4
  store i32 %tmp86.4, i32* %tmp87.4, align 4
  %tmp80.5 = add i32 %k.1117.ph, 50
  %tmp85.5 = getelementptr [100 x i32]* @C, i32 0, i32 %tmp80.5
  %tmp86.5 = load i32* %tmp85.5, align 4
  %tmp87.5 = getelementptr [100 x i32]* @_Output, i32 0, i32 %tmp80.5
  store i32 %tmp86.5, i32* %tmp87.5, align 4
  %tmp80.6 = add i32 %k.1117.ph, 60
  %tmp85.6 = getelementptr [100 x i32]* @C, i32 0, i32 %tmp80.6
  %tmp86.6 = load i32* %tmp85.6, align 4
  %tmp87.6 = getelementptr [100 x i32]* @_Output, i32 0, i32 %tmp80.6
  store i32 %tmp86.6, i32* %tmp87.6, align 4
  %tmp80.7 = add i32 %k.1117.ph, 70
  %tmp85.7 = getelementptr [100 x i32]* @C, i32 0, i32 %tmp80.7
  %tmp86.7 = load i32* %tmp85.7, align 4
  %tmp87.7 = getelementptr [100 x i32]* @_Output, i32 0, i32 %tmp80.7
  store i32 %tmp86.7, i32* %tmp87.7, align 4
  %tmp80.8 = add i32 %k.1117.ph, 80
  %tmp85.8 = getelementptr [100 x i32]* @C, i32 0, i32 %tmp80.8
  %tmp86.8 = load i32* %tmp85.8, align 4
  %tmp87.8 = getelementptr [100 x i32]* @_Output, i32 0, i32 %tmp80.8
  store i32 %tmp86.8, i32* %tmp87.8, align 4
  %tmp80.9 = add i32 %k.1117.ph, 90
  %tmp85.9 = getelementptr [100 x i32]* @C, i32 0, i32 %tmp80.9
  %tmp86.9 = load i32* %tmp85.9, align 4
  %tmp87.9 = getelementptr [100 x i32]* @_Output, i32 0, i32 %tmp80.9
  store i32 %tmp86.9, i32* %tmp87.9, align 4
  %indvar.next = add i32 %k.1117.ph, 1
  %exitcond = icmp eq i32 %indvar.next, 10
  br i1 %exitcond, label %bb.i5, label %bb76.outer

bb.i5:                                            ; preds = %bb.i5, %bb76.outer
  %i.036.0.i1 = phi i32 [ 0, %bb76.outer ], [ %indvar.next24, %bb.i5 ]
  %tmp2.i2 = getelementptr [100 x i32]* @A, i32 0, i32 %i.036.0.i1
  store i32 1, i32* %tmp2.i2, align 4
  %indvar.next24 = add i32 %i.036.0.i1, 1
  %exitcond25 = icmp eq i32 %indvar.next24, 100
  br i1 %exitcond25, label %bb10.i10, label %bb.i5

bb10.i10:                                         ; preds = %bb10.i10, %bb.i5
  %i.141.0.i6 = phi i32 [ 0, %bb.i5 ], [ %indvar.next22, %bb10.i10 ]
  %tmp13.i7 = getelementptr [100 x i32]* @B, i32 0, i32 %i.141.0.i6
  store i32 1, i32* %tmp13.i7, align 4
  %indvar.next22 = add i32 %i.141.0.i6, 1
  %exitcond23 = icmp eq i32 %indvar.next22, 100
  br i1 %exitcond23, label %bb22.i15, label %bb10.i10

bb22.i15:                                         ; preds = %bb22.i15, %bb10.i10
  %i.246.i11 = phi i32 [ 0, %bb10.i10 ], [ %indvar.next20, %bb22.i15 ]
  %tmp25.i12 = getelementptr [100 x i32]* @C, i32 0, i32 %i.246.i11
  store i32 0, i32* %tmp25.i12, align 4
  %indvar.next20 = add i32 %i.246.i11, 1
  %exitcond21 = icmp eq i32 %indvar.next20, 100
  br i1 %exitcond21, label %pin_down.exit16, label %bb22.i15

pin_down.exit16:                                  ; preds = %bb22.i15
  ret i32 0
}

define internal void @exit(i32 %code) {
entry:
  tail call void @__call_exitprocs(i32 %code, i8* null)
  %tmp3 = load void (%struct._reent*)** getelementptr (%struct._reent* bitcast (%2* @impure_data to %struct._reent*), i32 0, i32 9), align 4
  %tmp4 = icmp eq void (%struct._reent*)* %tmp3, null
  br i1 %tmp4, label %cond_next, label %cond_true

cond_true:                                        ; preds = %entry
  tail call void %tmp3(%struct._reent* bitcast (%2* @impure_data to %struct._reent*))
  tail call void @_exit(i32 %code)
  unreachable

cond_next:                                        ; preds = %entry
  tail call void @_exit(i32 %code)
  unreachable
}

define internal i32 @pin_down(i32* %A, i32* %B, i32* %C) {
entry:
  br label %bb

bb:                                               ; preds = %bb, %entry
  %i.036.0 = phi i32 [ 0, %entry ], [ %indvar.next3, %bb ]
  %tmp2 = getelementptr i32* %A, i32 %i.036.0
  store i32 1, i32* %tmp2, align 4
  %indvar.next3 = add i32 %i.036.0, 1
  %exitcond4 = icmp eq i32 %indvar.next3, 100
  br i1 %exitcond4, label %bb10, label %bb

bb10:                                             ; preds = %bb10, %bb
  %i.141.0 = phi i32 [ 0, %bb ], [ %indvar.next, %bb10 ]
  %tmp13 = getelementptr i32* %B, i32 %i.141.0
  store i32 1, i32* %tmp13, align 4
  %indvar.next = add i32 %i.141.0, 1
  %exitcond = icmp eq i32 %indvar.next, 100
  br i1 %exitcond, label %bb22, label %bb10

bb22:                                             ; preds = %bb22, %bb10
  %i.246 = phi i32 [ 0, %bb10 ], [ %indvar.next1, %bb22 ]
  %tmp25 = getelementptr i32* %C, i32 %i.246
  store i32 0, i32* %tmp25, align 4
  %indvar.next1 = add i32 %i.246, 1
  %exitcond2 = icmp eq i32 %indvar.next1, 100
  br i1 %exitcond2, label %bb33, label %bb22

bb33:                                             ; preds = %bb22
  ret i32 0
}

define internal void @__call_exitprocs(i32 %code, i8* %d) {
entry:
  %tmp2 = load %struct._atexit** getelementptr (%struct._reent* bitcast (%2* @impure_data to %struct._reent*), i32 0, i32 17), align 4
  %tmp120 = icmp eq %struct._atexit* %tmp2, null
  br i1 %tmp120, label %return, label %bb

bb:                                               ; preds = %entry
  %tmp8 = getelementptr %struct._atexit* %tmp2, i32 0, i32 1
  %tmp9 = load i32* %tmp8, align 4
  %n.0138 = add i32 %tmp9, -1
  %tmp114140 = icmp sgt i32 %n.0138, -1
  br i1 %tmp114140, label %bb11.preheader, label %return

bb11.preheader:                                   ; preds = %bb
  %tmp6 = getelementptr %struct._atexit* %tmp2, i32 0, i32 3
  %tmp15 = icmp eq i8* %d, null
  %tmp18 = icmp eq %struct._on_exit_args* %tmp6, null
  %tmp72 = getelementptr %struct._atexit* %tmp2, i32 0, i32 3, i32 2
  %tmp83 = getelementptr %struct._atexit* %tmp2, i32 0, i32 3, i32 3
  br label %bb11

bb11:                                             ; preds = %bb112, %cond_true90, %bb79, %bb11.preheader
  %n.0124.0 = phi i32 [ %n.0138, %bb11.preheader ], [ %n.0142, %bb79 ], [ %n.0145, %cond_true90 ], [ %n.0, %bb112 ]
  %tmp13 = shl i32 1, %n.0124.0
  br i1 %tmp15, label %cond_next33, label %cond_true

cond_true:                                        ; preds = %bb11
  br i1 %tmp18, label %bb112, label %cond_next

cond_next:                                        ; preds = %cond_true
  %tmp25 = getelementptr %struct._atexit* %tmp2, i32 0, i32 3, i32 1, i32 %n.0124.0
  %tmp26 = load i8** %tmp25, align 4
  %tmp28 = icmp eq i8* %tmp26, %d
  br i1 %tmp28, label %cond_next33, label %bb112

cond_next33:                                      ; preds = %cond_next, %bb11
  %tmp37 = getelementptr %struct._atexit* %tmp2, i32 0, i32 2, i32 %n.0124.0
  %tmp38 = load void ()** %tmp37, align 4
  %tmp41 = load i32* %tmp8, align 4
  %tmp42 = add i32 %tmp41, -1
  %tmp44 = icmp eq i32 %tmp42, %n.0124.0
  %tmp60 = icmp eq void ()* %tmp38, null
  br i1 %tmp44, label %cond_true47, label %cond_false

cond_true47:                                      ; preds = %cond_next33
  store i32 %tmp42, i32* %tmp8, align 4
  br i1 %tmp60, label %bb112, label %cond_next64

cond_false:                                       ; preds = %cond_next33
  store void ()* null, void ()** %tmp37, align 4
  br i1 %tmp60, label %bb112, label %cond_next64

cond_next64:                                      ; preds = %cond_false, %cond_true47
  br i1 %tmp18, label %bb79, label %cond_next70

cond_next70:                                      ; preds = %cond_next64
  %tmp73 = load i32* %tmp72, align 4
  %tmp75 = and i32 %tmp73, %tmp13
  %tmp76 = icmp eq i32 %tmp75, 0
  br i1 %tmp76, label %bb79, label %bb81

bb79:                                             ; preds = %cond_next70, %cond_next64
  tail call void %tmp38()
  %n.0142 = add i32 %n.0124.0, -1
  %tmp114144 = icmp sgt i32 %n.0142, -1
  br i1 %tmp114144, label %bb11, label %return

bb81:                                             ; preds = %cond_next70
  %tmp84 = load i32* %tmp83, align 4
  %tmp86 = and i32 %tmp84, %tmp13
  %tmp87 = icmp eq i32 %tmp86, 0
  br i1 %tmp87, label %cond_true90, label %cond_false99

cond_true90:                                      ; preds = %bb81
  %tmp9192 = bitcast void ()* %tmp38 to void (i32, i8*)*
  %tmp96 = getelementptr %struct._atexit* %tmp2, i32 0, i32 3, i32 0, i32 %n.0124.0
  %tmp97 = load i8** %tmp96, align 4
  tail call void %tmp9192(i32 %code, i8* %tmp97)
  %n.0145 = add i32 %n.0124.0, -1
  %tmp114147 = icmp sgt i32 %n.0145, -1
  br i1 %tmp114147, label %bb11, label %return

cond_false99:                                     ; preds = %bb81
  %tmp100101 = bitcast void ()* %tmp38 to void (i8*)*
  %tmp105 = getelementptr %struct._atexit* %tmp2, i32 0, i32 3, i32 0, i32 %n.0124.0
  %tmp106 = load i8** %tmp105, align 4
  tail call void %tmp100101(i8* %tmp106)
  br label %bb112

bb112:                                            ; preds = %cond_false99, %cond_false, %cond_true47, %cond_next, %cond_true
  %n.0 = add i32 %n.0124.0, -1
  %tmp114 = icmp sgt i32 %n.0, -1
  br i1 %tmp114, label %bb11, label %return

return:                                           ; preds = %bb112, %cond_true90, %bb79, %bb, %entry
  ret void
}

define internal void @_exit(i32 %rc) {
entry:
  ret void
}
