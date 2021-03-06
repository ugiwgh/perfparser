TARGET = dw

QMAKE_LFLAGS += \
        -Wl,--whole-archive \
        ../libebl.a ../libdwelf.a ../libdwfl.a \
        -Wl,--no-whole-archive \

include(../dynamic.pri)
include(../libelf/elfheaders.pri)
include(dwheaders.pri)

LIBS += -L$$DESTDIR -l$$libraryName(elf)

# libebl includes libasm headers, but doesn't actually use any symbols.
# So, we don't link it here for now.
linux: LIBS += -ldl

SOURCES += \
    $$PWD/cfi.c \
    $$PWD/cie.c \
    $$PWD/dwarf_abbrev_hash.c \
    $$PWD/dwarf_abbrevhaschildren.c \
    $$PWD/dwarf_addrdie.c \
    $$PWD/dwarf_aggregate_size.c \
    $$PWD/dwarf_arrayorder.c \
    $$PWD/dwarf_attr_integrate.c \
    $$PWD/dwarf_attr.c \
    $$PWD/dwarf_begin_elf.c \
    $$PWD/dwarf_begin.c \
    $$PWD/dwarf_bitoffset.c \
    $$PWD/dwarf_bitsize.c \
    $$PWD/dwarf_bytesize.c \
    $$PWD/dwarf_cfi_addrframe.c \
    $$PWD/dwarf_cfi_end.c \
    $$PWD/dwarf_child.c \
    $$PWD/dwarf_cu_die.c \
    $$PWD/dwarf_cu_getdwarf.c \
    $$PWD/dwarf_cuoffset.c \
    $$PWD/dwarf_decl_column.c \
    $$PWD/dwarf_decl_file.c \
    $$PWD/dwarf_decl_line.c \
    $$PWD/dwarf_diecu.c \
    $$PWD/dwarf_diename.c \
    $$PWD/dwarf_dieoffset.c \
    $$PWD/dwarf_end.c \
    $$PWD/dwarf_entry_breakpoints.c \
    $$PWD/dwarf_entrypc.c \
    $$PWD/dwarf_error.c \
    $$PWD/dwarf_filesrc.c \
    $$PWD/dwarf_formaddr.c \
    $$PWD/dwarf_formblock.c \
    $$PWD/dwarf_formflag.c \
    $$PWD/dwarf_formref_die.c \
    $$PWD/dwarf_formref.c \
    $$PWD/dwarf_formsdata.c \
    $$PWD/dwarf_formstring.c \
    $$PWD/dwarf_formudata.c \
    $$PWD/dwarf_frame_cfa.c \
    $$PWD/dwarf_frame_info.c \
    $$PWD/dwarf_frame_register.c \
    $$PWD/dwarf_func_inline.c \
    $$PWD/dwarf_getabbrev.c \
    $$PWD/dwarf_getabbrevattr.c \
    $$PWD/dwarf_getabbrevcode.c \
    $$PWD/dwarf_getabbrevtag.c \
    $$PWD/dwarf_getalt.c \
    $$PWD/dwarf_getarange_addr.c \
    $$PWD/dwarf_getarangeinfo.c \
    $$PWD/dwarf_getaranges.c \
    $$PWD/dwarf_getattrcnt.c \
    $$PWD/dwarf_getattrs.c \
    $$PWD/dwarf_getcfi_elf.c \
    $$PWD/dwarf_getcfi.c \
    $$PWD/dwarf_getelf.c \
    $$PWD/dwarf_getfuncs.c \
    $$PWD/dwarf_getlocation_attr.c \
    $$PWD/dwarf_getlocation_die.c \
    $$PWD/dwarf_getlocation_implicit_pointer.c \
    $$PWD/dwarf_getlocation.c \
    $$PWD/dwarf_getmacros.c \
    $$PWD/dwarf_getpubnames.c \
    $$PWD/dwarf_getscopes_die.c \
    $$PWD/dwarf_getscopes.c \
    $$PWD/dwarf_getscopevar.c \
    $$PWD/dwarf_getsrc_die.c \
    $$PWD/dwarf_getsrc_file.c \
    $$PWD/dwarf_getsrcdirs.c \
    $$PWD/dwarf_getsrcfiles.c \
    $$PWD/dwarf_getsrclines.c \
    $$PWD/dwarf_getstring.c \
    $$PWD/dwarf_hasattr_integrate.c \
    $$PWD/dwarf_hasattr.c \
    $$PWD/dwarf_haschildren.c \
    $$PWD/dwarf_hasform.c \
    $$PWD/dwarf_haspc.c \
    $$PWD/dwarf_highpc.c \
    $$PWD/dwarf_lineaddr.c \
    $$PWD/dwarf_linebeginstatement.c \
    $$PWD/dwarf_lineblock.c \
    $$PWD/dwarf_linecol.c \
    $$PWD/dwarf_linediscriminator.c \
    $$PWD/dwarf_lineendsequence.c \
    $$PWD/dwarf_lineepiloguebegin.c \
    $$PWD/dwarf_lineisa.c \
    $$PWD/dwarf_lineno.c \
    $$PWD/dwarf_lineop_index.c \
    $$PWD/dwarf_lineprologueend.c \
    $$PWD/dwarf_linesrc.c \
    $$PWD/dwarf_lowpc.c \
    $$PWD/dwarf_macro_getparamcnt.c \
    $$PWD/dwarf_macro_getsrcfiles.c \
    $$PWD/dwarf_macro_opcode.c \
    $$PWD/dwarf_macro_param.c \
    $$PWD/dwarf_macro_param1.c \
    $$PWD/dwarf_macro_param2.c \
    $$PWD/dwarf_next_cfi.c \
    $$PWD/dwarf_nextcu.c \
    $$PWD/dwarf_offabbrev.c \
    $$PWD/dwarf_offdie.c \
    $$PWD/dwarf_onearange.c \
    $$PWD/dwarf_onesrcline.c \
    $$PWD/dwarf_peel_type.c \
    $$PWD/dwarf_ranges.c \
    $$PWD/dwarf_setalt.c \
    $$PWD/dwarf_siblingof.c \
    $$PWD/dwarf_sig8_hash.c \
    $$PWD/dwarf_srclang.c \
    $$PWD/dwarf_tag.c \
    $$PWD/dwarf_whatattr.c \
    $$PWD/dwarf_whatform.c \
    $$PWD/fde.c \
    $$PWD/frame-cache.c \
    $$PWD/libdw_alloc.c \
    $$PWD/libdw_findcu.c \
    $$PWD/libdw_form.c \
    $$PWD/libdw_visit_scopes.c
