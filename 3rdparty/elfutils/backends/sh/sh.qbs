import qbs

ElfUtilsBackend {
    arch: "sh"
    additionalSources: ["corenote.c", "regs.c", "retval.c", "symbol.c"]
}
