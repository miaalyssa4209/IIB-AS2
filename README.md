# ds1202-project — System Information Report

## What this project is

A small Linux shell-scripting project. It contains one script, `scripts/sysinfo.sh`,
that collects and prints a system-information report, and writes a timestamped copy
of that report to `logs/`.

The project was built to practise: writing Bash scripts, setting file permissions,
authenticating to GitHub over HTTPS with a personal access token, and using a
feature-branch Git workflow.

## What sysinfo.sh reports

| Section | Details |
|---|---|
| Hostname | The machine's hostname |
| OS / Kernel | Distribution name from `/etc/os-release`, kernel release, architecture |
| Uptime | Human-readable uptime (`uptime -p`, with a fallback) |
| CPU load | 1/5/15-minute load averages from `/proc/loadavg`, plus core count from `nproc` |
| Memory usage | `free -h` — total, used, free, shared, buff/cache, available |
| Disk usage | `df -h` — filesystem, size, used, available, use %, mount point |
| Logged-in users | `who` |
| Log file | Every line is also appended to `logs/sysinfo-<YYYYMMDD-HHMMSS>.log` |

The script wraps its output in a `report()` function that pipes through `tee -a`, so
each line goes to the screen and the log file at the same time. A trailing
`} 2>&1` block redirects stderr as well, so errors are captured in the log too.
`mkdir -p` creates `logs/` if it is missing, so the script works on a fresh clone.

## Setup, step by step

### 1. Create a personal access token

GitHub no longer accepts account passwords for HTTPS pushes, so a token is required.

1. Open `https://github.com/settings/tokens`
2. *Generate new token* → *classic*
3. Name it something specific, e.g. `iib-as2-push`
4. Set an expiry (30 or 90 days is sensible)
5. Tick the **`repo`** scope — that covers cloning, committing and pushing
6. Click *Generate token* and **copy it immediately** — it is shown only once

A classic token is account-wide; it cannot be limited to one repository. If you want
it scoped to a single repo, use a **fine-grained token** instead, set
*Repository access* to `IIB-AS2`, and give it *Contents: Read and write*.

A token can only do what your account can already do — it cannot grant access to a
repository you do not have write permission on.

### 2. Point the remote at the repository

```bash
cd ~/ds1202-project
git remote -v
git remote set-url origin https://github.com/miaalyssa4209/IIB-AS2.git
git remote -v
