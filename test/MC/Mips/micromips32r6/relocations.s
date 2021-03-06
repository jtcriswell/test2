# RUN: llvm-mc %s -triple=mips-unknown-linux -show-encoding -mcpu=mips32r6 \
# RUN:   -mattr=micromips | FileCheck %s -check-prefix=CHECK-FIXUP
# RUN: llvm-mc %s -filetype=obj -triple=mips-unknown-linux -mcpu=mips32r6 \
# RUN:   -mattr=micromips | llvm-readobj -r | FileCheck %s -check-prefix=CHECK-ELF
#------------------------------------------------------------------------------
# Check that the assembler can handle the documented syntax for fixups.
#------------------------------------------------------------------------------
# CHECK-FIXUP: balc  bar        # encoding: [0b101101AA,A,A,A]
# CHECK-FIXUP:                  #   fixup A - offset: 0,
# CHECK-FIXUP:                      value: bar-4, kind: fixup_MICROMIPS_PC26_S1
# CHECK-FIXUP: bc    bar        # encoding: [0b100101AA,A,A,A]
# CHECK-FIXUP:                  #   fixup A - offset: 0,
# CHECK-FIXUP:                      value: bar-4, kind: fixup_MICROMIPS_PC26_S1
# CHECK-FIXUP: addiupc $2, bar  # encoding: [0x78,0b01000AAA,A,A]
# CHECK-FIXUP:                  #   fixup A - offset: 0,
# CHECK-FIXUP:                      value: bar, kind: fixup_MICROMIPS_PC19_S2
# CHECK-FIXUP: lwpc    $2, bar  # encoding: [0x78,0b01001AAA,A,A]
# CHECK-FIXUP:                  #   fixup A - offset: 0,
# CHECK-FIXUP:                      value: bar, kind: fixup_MICROMIPS_PC19_S2
#------------------------------------------------------------------------------
# Check that the appropriate relocations were created.
#------------------------------------------------------------------------------
# CHECK-ELF: Relocations [
# CHECK-ELF:     0x0 R_MICROMIPS_PC26_S1 bar 0x0
# CHECK-ELF:     0x4 R_MICROMIPS_PC26_S1 bar 0x0
# CHECK-ELF: ]

  balc  bar
  bc    bar
  addiupc $2,bar
  lwpc    $2,bar
