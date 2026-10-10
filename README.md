# Antivirus Daemon & Restore Tool

A lightweight Linux-based security system built with Bash and Makefile. It features a background daemon that periodically monitors a specified directory for malicious files, automatically quarantines them upon detection, and provides an interactive CLI tool to review and restore falsely flagged files.

---

## 1. Project Structure & Overview

```text
.
├── antivirusd.sh     # Antivirus daemon script for monitoring & scanning
├── restore.sh        # Interactive quarantine review and file restore utility
├── Makefile          # Automation tool for setup and running components
└── README.md         # Documentation and project guide
