/****************************************************************************
**
** Copyright (C) 2017 Klarälvdalens Datakonsult AB, a KDAB Group company, info@kdab.com, author Milian Wolff <milian.wolff@kdab.com>
** Contact: http://www.qt.io/licensing/
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

#include "perfkallsyms.h"

#include <QFile>
#include <QTextStream>

#include <algorithm>

PerfKallsyms::PerfKallsyms(const QString &path)
{
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning("Failed to open kallsyms file \"%s\".", qPrintable(path));
        return;
    }

    QTextStream stream(&file);
    stream.setLocale(QLocale::c());

    QByteArray address;

    // NOTE: don't use atEnd here, as /proc/kallsyms is has size of 0
    while (true) {
        PerfKallsymEntry entry;
        char type = 0;
        char eol = '\n';

        stream >> address >> ws >> type >> ws >> entry.symbol >> eol;
        if (address.isEmpty())
            break;

        bool ok = false;
        entry.address = address.toULongLong(&ok, 16);
        if (!ok) {
            qWarning("Failed to parse kallsyms file, invalid address: %s.", address.constData());
            break;
        }

        if (eol == '\t')
            stream >> entry.module;

        m_entries.push_back(entry);
    }

    std::sort(m_entries.begin(), m_entries.end(),
        [](const PerfKallsymEntry& lhs, const PerfKallsymEntry& rhs) -> bool {
            return lhs.address < rhs.address;
        });
}

PerfKallsymEntry PerfKallsyms::findEntry(quint64 address) const
{
    auto entry = std::upper_bound(m_entries.begin(), m_entries.end(), address,
        [](quint64 address, const PerfKallsymEntry& entry) -> bool {
            return address < entry.address;
        });

    if (entry != m_entries.begin()) {
        --entry;
        return *entry;
    }

    return {};
}
