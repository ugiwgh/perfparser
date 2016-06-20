import qbs

ElfUtilsDynamicLib {
    name: "dw"
    Depends { name: "ebl" }
    Depends { name: "dwfl" }
    Depends { name: "elf" }
    Depends { name: "dwelf" }
    cpp.dynamicLibraries: base.concat(["dl", "z"])

    // Workaround for broken dependencies
    cpp.linkerFlags: base.concat([
        "-L" + project.buildDirectory + "/elfutils",
        "-Wl,--whole-archive", "-lebl", "-ldwelf", "-ldwfl", "-Wl,--no-whole-archive"
    ])

    Export {
        Depends { name: "cpp" }
        cpp.includePaths: base.concat(".")
    }

    files: [
        "cfi.c",
        "cfi.h",
        "cie.c",
        "dwarf_abbrev_hash.h",
        "dwarf_sig8_hash.h",
        "dwarf.h",
        "dwarf_abbrev_hash.c",
        "dwarf_abbrevhaschildren.c",
        "dwarf_addrdie.c",
        "dwarf_aggregate_size.c",
        "dwarf_arrayorder.c",
        "dwarf_attr_integrate.c",
        "dwarf_attr.c",
        "dwarf_begin_elf.c",
        "dwarf_begin.c",
        "dwarf_bitoffset.c",
        "dwarf_bitsize.c",
        "dwarf_bytesize.c",
        "dwarf_cfi_addrframe.c",
        "dwarf_cfi_end.c",
        "dwarf_child.c",
        "dwarf_cu_die.c",
        "dwarf_cu_getdwarf.c",
        "dwarf_cuoffset.c",
        "dwarf_decl_column.c",
        "dwarf_decl_file.c",
        "dwarf_decl_line.c",
        "dwarf_diecu.c",
        "dwarf_diename.c",
        "dwarf_dieoffset.c",
        "dwarf_end.c",
        "dwarf_entry_breakpoints.c",
        "dwarf_entrypc.c",
        "dwarf_error.c",
        "dwarf_filesrc.c",
        "dwarf_formaddr.c",
        "dwarf_formblock.c",
        "dwarf_formflag.c",
        "dwarf_formref_die.c",
        "dwarf_formref.c",
        "dwarf_formsdata.c",
        "dwarf_formstring.c",
        "dwarf_formudata.c",
        "dwarf_frame_cfa.c",
        "dwarf_frame_info.c",
        "dwarf_frame_register.c",
        "dwarf_func_inline.c",
        "dwarf_getabbrev.c",
        "dwarf_getabbrevattr.c",
        "dwarf_getabbrevcode.c",
        "dwarf_getabbrevtag.c",
        "dwarf_getalt.c",
        "dwarf_getarange_addr.c",
        "dwarf_getarangeinfo.c",
        "dwarf_getaranges.c",
        "dwarf_getattrcnt.c",
        "dwarf_getattrs.c",
        "dwarf_getcfi_elf.c",
        "dwarf_getcfi.c",
        "dwarf_getelf.c",
        "dwarf_getfuncs.c",
        "dwarf_getlocation_attr.c",
        "dwarf_getlocation_die.c",
        "dwarf_getlocation_implicit_pointer.c",
        "dwarf_getlocation.c",
        "dwarf_getmacros.c",
        "dwarf_getpubnames.c",
        "dwarf_getscopes_die.c",
        "dwarf_getscopes.c",
        "dwarf_getscopevar.c",
        "dwarf_getsrc_die.c",
        "dwarf_getsrc_file.c",
        "dwarf_getsrcdirs.c",
        "dwarf_getsrcfiles.c",
        "dwarf_getsrclines.c",
        "dwarf_getstring.c",
        "dwarf_hasattr_integrate.c",
        "dwarf_hasattr.c",
        "dwarf_haschildren.c",
        "dwarf_hasform.c",
        "dwarf_haspc.c",
        "dwarf_highpc.c",
        "dwarf_lineaddr.c",
        "dwarf_linebeginstatement.c",
        "dwarf_lineblock.c",
        "dwarf_linecol.c",
        "dwarf_linediscriminator.c",
        "dwarf_lineendsequence.c",
        "dwarf_lineepiloguebegin.c",
        "dwarf_lineisa.c",
        "dwarf_lineno.c",
        "dwarf_lineop_index.c",
        "dwarf_lineprologueend.c",
        "dwarf_linesrc.c",
        "dwarf_lowpc.c",
        "dwarf_macro_getparamcnt.c",
        "dwarf_macro_getsrcfiles.c",
        "dwarf_macro_opcode.c",
        "dwarf_macro_param.c",
        "dwarf_macro_param1.c",
        "dwarf_macro_param2.c",
        "dwarf_next_cfi.c",
        "dwarf_nextcu.c",
        "dwarf_offabbrev.c",
        "dwarf_offdie.c",
        "dwarf_onearange.c",
        "dwarf_onesrcline.c",
        "dwarf_peel_type.c",
        "dwarf_ranges.c",
        "dwarf_setalt.c",
        "dwarf_siblingof.c",
        "dwarf_sig8_hash.c",
        "dwarf_srclang.c",
        "dwarf_tag.c",
        "dwarf_whatattr.c",
        "dwarf_whatform.c",
        "encoded-value.h",
        "fde.c",
        "frame-cache.c",
        "libdw_alloc.c",
        "libdw_findcu.c",
        "libdw_form.c",
        "libdw_visit_scopes.c",
        "known-dwarf.h",
        "libdw.h",
        "libdwP.h",
        "memory-access.h",
    ]
}
