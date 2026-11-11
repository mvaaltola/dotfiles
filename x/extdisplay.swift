// extdisplay: disable/enable an external display without making it permanent.
//
//   extdisplay list                  show online displays
//   extdisplay off [--scope S]       disable the first external display, remember its ID
//   extdisplay on  [--scope S]       re-enable the remembered display(s)
//   extdisplay hold <seconds>        disable with app-only scope, exit after N seconds (test)
//
// Scope: session (default; reverts at logout) | app (reverts when this process exits).
import CoreGraphics
import Foundation

@_silgen_name("CGSConfigureDisplayEnabled")
func CGSConfigureDisplayEnabled(_ config: CGDisplayConfigRef, _ display: CGDirectDisplayID, _ enabled: Bool) -> CGError

let stateFile = FileManager.default.homeDirectoryForCurrentUser
    .appendingPathComponent(".cache/extdisplay-disabled")

func online() -> [CGDirectDisplayID] {
    var n: UInt32 = 0
    CGGetOnlineDisplayList(0, nil, &n)
    var ids = [CGDirectDisplayID](repeating: 0, count: Int(n))
    CGGetOnlineDisplayList(n, &ids, &n)
    return Array(ids.prefix(Int(n)))
}

func active() -> Set<CGDirectDisplayID> {
    var n: UInt32 = 0
    CGGetActiveDisplayList(0, nil, &n)
    var ids = [CGDirectDisplayID](repeating: 0, count: Int(n))
    CGGetActiveDisplayList(n, &ids, &n)
    return Set(ids.prefix(Int(n)))
}

func setEnabled(_ ids: [CGDirectDisplayID], _ enabled: Bool, _ option: CGConfigureOption) -> Bool {
    var cfg: CGDisplayConfigRef?
    guard CGBeginDisplayConfiguration(&cfg) == .success, let cfg else { return false }
    for id in ids {
        let err = CGSConfigureDisplayEnabled(cfg, id, enabled)
        if err != .success { fputs("CGSConfigureDisplayEnabled(\(id), \(enabled)) -> \(err.rawValue)\n", stderr) }
    }
    let err = CGCompleteDisplayConfiguration(cfg, option)
    if err != .success { fputs("CGCompleteDisplayConfiguration -> \(err.rawValue)\n", stderr); return false }
    return true
}

func option(_ args: [String]) -> CGConfigureOption {
    if let i = args.firstIndex(of: "--scope"), i + 1 < args.count, args[i + 1] == "app" { return .forAppOnly }
    return .forSession
}

func list() {
    let act = active()
    for id in online() {
        print("id \(id)  builtin=\(CGDisplayIsBuiltin(id) != 0)  active=\(act.contains(id))  main=\(CGDisplayIsMain(id) != 0)")
    }
}

var args = Array(CommandLine.arguments.dropFirst())
if args.first == "toggle" {
    let externalActive = online().contains { CGDisplayIsBuiltin($0) == 0 && active().contains($0) }
    args[0] = externalActive ? "off" : "on"
}
switch args.first ?? "list" {
case "list":
    list()
case "off", "hold":
    let targets = online().filter { CGDisplayIsBuiltin($0) == 0 && active().contains($0) }
    guard !targets.isEmpty else { fputs("no active external display\n", stderr); exit(1) }
    try? FileManager.default.createDirectory(at: stateFile.deletingLastPathComponent(), withIntermediateDirectories: true)
    try? targets.map(String.init).joined(separator: "\n").write(to: stateFile, atomically: true, encoding: .utf8)
    let opt: CGConfigureOption = args.first == "hold" ? .forAppOnly : option(args)
    guard setEnabled(targets, false, opt) else { exit(1) }
    print("disabled \(targets)")
    if args.first == "hold" {
        let secs = UInt32(args.dropFirst().first ?? "10") ?? 10
        sleep(secs)
        print("exiting (app-only config should revert)")
    }
case "on":
    var ids = (try? String(contentsOf: stateFile, encoding: .utf8))?
        .split(separator: "\n").compactMap { CGDirectDisplayID($0) } ?? []
    // Also catch anything online but inactive, in case the ID changed.
    ids += online().filter { !active().contains($0) && !ids.contains($0) }
    guard !ids.isEmpty else { print("nothing to enable"); exit(0) }
    guard setEnabled(ids, true, option(args)) else { exit(1) }
    try? FileManager.default.removeItem(at: stateFile)
    print("enabled \(ids)")
default:
    fputs("usage: extdisplay [list|off|on|hold N] [--scope session|app]\n", stderr); exit(2)
}
