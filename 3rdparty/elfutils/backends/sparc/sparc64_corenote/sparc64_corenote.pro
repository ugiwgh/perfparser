TARGET = sparc64_corenote

include(../../../libasm/asmheaders.pri)
include(../../../libebl/eblheaders.pri)
include(../../../libelf/elfheaders.pri)
include(../../../libdw/dwheaders.pri)
include(../../../static.pri)

SOURCES += ../../sparc64_corenote.c
HEADERS += ../../sparc_corenote.c
