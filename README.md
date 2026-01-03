# Imprint Rescue ISO (KDE Edition)

This repository contains the build scripts and configuration used to create the **Imprint Rescue ISO** — a lightweight, KDE‑based live environment designed for safe, reliable offline backup and restore operations using **Imprint**.

The ISO provides a clean, modern environment with excellent hardware support (including USB4/Thunderbolt enclosures, NVMe bridges, and newer chipsets), making it ideal for full‑system imaging and recovery.

---

## What Is Imprint?

Imprint is a modern, Linux‑native reimagining of the classic Norton Ghost workflow.  
It provides a clean, safe, and fast way to back up and restore partitions using partclone, with strong integrity guarantees and a simple Zenity‑based UI.

**Main project:**  
https://github.com/jalongx/imprint

The rescue ISO in this repository is simply a convenient way to run Imprint on any machine — even when the main OS cannot boot or when system partitions must remain unmounted.

---

## Features of the Rescue ISO

- **KDE Plasma desktop:** Lightweight, focused configuration  
- **Arch Linux base:** Excellent hardware and driver support  
- **Imprint preinstalled:** Ready to run out of the box  
- **Network support:** Wired and wireless networking  
- **Maintenance tools:** Useful CLI and GUI utilities for troubleshooting  
- **Recovery‑focused environment:** Clean, minimal, and purpose‑built for imaging tasks  

---

## Building the ISO

The ISO is fully open‑source and reproducible.  
You can build it yourself using the included scripts.

### Requirements

- Arch Linux or an Arch‑based environment  
- `archiso` package installed  
- Sufficient disk space (approx. 3–4 GB)

### Build Steps

```bash
git clone https://github.com/jalongx/imprint_iso_kde
cd imprint_iso_kde
sudo mkarchiso -v -w work -o out .
```

The finished ISO will appear in the out/ directory.

### Notes

- Building must be done as root (required by mkarchiso)
- The build process may take several minutes depending on hardware
- The ISO includes the latest version of Imprint available at build time

---

## Prebuilt ISOs

If you prefer not to build the ISO yourself, prebuilt images may be available to project supporters as a convenience perk.

The source code and build scripts will always remain free and open.
Providing prebuilt ISOs simply helps support ongoing development and hardware testing.
Supporting the Project

Imprint and the rescue ISO are developed and maintained by a retired senior on a fixed income.
If this project helps you, or if you’d like to support continued development toward Imprint 1.0, consider becoming a sponsor.

Your support helps fund:

- ongoing maintenance
- hardware compatibility testing
- ISO improvements
- future roadmap features

Thank you for helping keep Imprint sustainable.

---

## Related Repositories

- Imprint (main project):  
    https://github.com/jalongx/imprint
- Imprint Rescue ISO (this repo):  
    https://github.com/jalongx/imprint_iso_kde
