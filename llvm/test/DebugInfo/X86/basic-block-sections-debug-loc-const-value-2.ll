; RUN: llc %s --dwarf-version=4 --basic-block-sections=none -filetype=obj -o %t
; RUN: llvm-dwarfdump %t | FileCheck %s
; RUN: llc %s --dwarf-version=4 --basic-block-sections=all -filetype=obj -o %t
; RUN: llvm-dwarfdump %t | FileCheck %s

; RUN: llc %s --dwarf-version=5 --basic-block-sections=none -filetype=obj -o %t
; RUN: llvm-dwarfdump %t | FileCheck %s
; RUN: llc %s --dwarf-version=5 --basic-block-sections=all -filetype=obj -o %t
; RUN: llvm-dwarfdump %t | FileCheck %s


; CHECK:      DW_TAG_variable
; CHECK-NEXT: DW_AT_const_value	(7)
; CHECK-NEXT: DW_AT_name	("i")


; void f1();
; void test() {
;   // constant value with a single location description
;   // Shouldn't change with BB-sections
;   int i = 7;
;   f1();
; }
; $ clang++ -S -emit-llvm -g -O2 const_value_2.cc



define dso_local void @_Z4testv() local_unnamed_addr !dbg !7 {
entry:
  call void @llvm.dbg.value(metadata i32 7, metadata !11, metadata !DIExpression()), !dbg !13
  tail call void @_Z2f1v(), !dbg !14
  ret void, !dbg !15
}

declare !dbg !16 dso_local void @_Z2f1v() local_unnamed_addr

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata)

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 13.0.0 (git@github.com:llvm/llvm-project.git 593cb4655097552ac6d81ce18a2851ae0feb8d3c)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "const_value_2.cc", directory: "/code")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 13.0.0 (git@github.com:llvm/llvm-project.git 593cb4655097552ac6d81ce18a2851ae0feb8d3c)"}
!7 = distinct !DISubprogram(name: "test", linkageName: "_Z4testv", scope: !1, file: !1, line: 5, type: !8, scopeLine: 5, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !10)
!8 = !DISubroutineType(types: !9)
!9 = !{null}
!10 = !{!11}
!11 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 8, type: !12)
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocation(line: 0, scope: !7)
!14 = !DILocation(line: 9, column: 3, scope: !7)
!15 = !DILocation(line: 10, column: 1, scope: !7)
!16 = !DISubprogram(name: "f1", linkageName: "_Z2f1v", scope: !1, file: !1, line: 1, type: !8, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !2)
