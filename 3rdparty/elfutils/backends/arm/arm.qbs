import qbs

ElfUtilsBackend {
    arch: "arm"
    additionalSources: [
        "attrs.c",
        "auxv.c",
        "cfi.c",
        "corenote.c",
        "initreg.c",
        "regs.c",
        "retval.c",
        "symbol.c",
        "unwind.c"
    ]
}
