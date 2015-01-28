/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd
** All rights reserved.
** For any questions to The Qt Company, please use contact form at http://www.qt.io/contact-us
**
** This file is part of the Qt Enterprise Perf Profiler Add-on.
**
** GNU General Public License Usage
** This file may be used under the terms of the GNU General Public License
** version 3 as published by the Free Software Foundation and appearing in
** the file LICENSE.GPLv3 included in the packaging of this file. Please
** review the following information to ensure the GNU General Public License
** requirements will be met: https://www.gnu.org/licenses/gpl.html.
**
** If you have questions regarding the use of this file, please use
** contact form at http://www.qt.io/contact-us
**
****************************************************************************/

#ifndef PERFUNWIND_H
#define PERFUNWIND_H

#include "perfdata.h"
#include <elfutils/libdwfl.h>
#include <QFileInfo>
#include <QMap>

class PerfUnwind
{
public:
    struct Frame {
        Frame(quint64 addr = 0, const QByteArray &symbol = QByteArray(),
              const QByteArray &file = QByteArray()) : addr(addr), symbol(symbol), file(file) {}
        quint64 addr;
        QByteArray symbol;
        QByteArray file;
    };

    PerfUnwind(quint32 pid, const QMap<quint32, QString> &threads, const PerfFeatures *features,
               const QString &systemRoot, const QString &debugInfo, const QString &extraLibs,
               const QString &appPath);
    ~PerfUnwind();

    uint architecture() const { return registerArch; }

    void registerElf(const PerfRecordMmap &mmap);
    Dwfl_Module *reportElf(quint64 ip) const;

    void analyze(QIODevice *output, const PerfRecordSample &sample);

private:
    static const quint64 s_callchainMax = (quint64)-4095;

    quint32 pid;
    QMap<quint32, QString> threads;
    const PerfFeatures *features;
    Dwfl *dwfl;
    Dwfl_Callbacks offlineCallbacks;
    char *debugInfoPath;

    uint registerArch;


    // Root of the file system of the machine that recorded the data. Any binaries and debug
    // symbols not found in appPath or extraLibsPath have to appear here.
    QString systemRoot;

    // Extra path to search for binaries and debug symbols before considering the system root
    QString extraLibsPath;

    // Path where the application being profiled resides. This is the first path to look for
    // binaries and debug symbols.
    QString appPath;

    struct ElfInfo {
        ElfInfo(const QFileInfo &file = QFileInfo(), quint64 length = 0) :
            file(file), length(length) {}
        QFileInfo file;
        quint64 length;
    };

    QMap<quint64, ElfInfo> elfs;

    void unwindStack(QVector<Frame> *frames, const PerfRecordSample &sample);
    void resolveCallchain(QVector<Frame> *frames, const PerfRecordSample &sample);
};

#endif // PERFUNWIND_H
