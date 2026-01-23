//
//  PIATunnelKitLogger.swift
//  TunnelKit
//
//  Created by Diego Trevisan on 02.01.26.
//  Copyright © 2026 Private Internet Access, Inc.
//
//  This file is part of TunnelKit.
//
//  TunnelKit is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  TunnelKit is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with TunnelKit.  If not, see <http://www.gnu.org/licenses/>.
//

import Logging

public enum PIATunnelKitLogger {
    private static var isBootstrapped = false

    public static func bootstrap() {
        guard !isBootstrapped else { return }
        LoggingSystem.bootstrap { label in
            PIATunnelKitLogHandler(label: label)
        }
        isBootstrapped = true
    }

    public static func logger(for type: Any.Type) -> Logger {
        bootstrap()
        let category = String(describing: type)
        return Logger(label: category)
    }
}
