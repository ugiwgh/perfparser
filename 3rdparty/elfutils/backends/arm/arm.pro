TARGET = ebl_arm
include(../backends.pri)

SOURCES += \
    ../arm_attrs.c \
    ../arm_auxv.c \
    ../arm_cfi.c \
    ../arm_corenote.c \
    ../arm_init.c \
    ../arm_initreg.c \
    ../arm_regs.c \
    ../arm_retval.c \
    ../arm_symbol.c \
    ../arm_unwind.c

HEADERS += \
    ../arm_reloc.def
