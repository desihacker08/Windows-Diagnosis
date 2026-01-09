# 🧠 COMMON WINDOWS BOOT ERRORS

## ❌ 1. No Bootable Device / No Boot Device Found
![Image](https://github.com/user-attachments/assets/704a2496-2c1e-4fdb-a5f3-0c8f6cd857ab)

**What it REALLY means:**
_BIOS/UEFI cannot find a bootloader_

*Common causes:* 
- Wrong Boot Mode (UEFI ↔ Legacy mismatch)
- BCD missing
- EFI partition deleted
- SSD/HDD failing

*Technician steps:*
- Enter BIOS → check disk detected
- Check Boot Mode
- Boot WinPE  [must know when use WinPE off Secure boot]
- Check `C:\Windows`
- Rebuild BCD

## ❌ 2. BOOTMGR is Missing
**Menas:** _Legacy bootloader is broken_


*Seen on:*
- Old PCs
- MBR disks

### Fix (CMD):
```bash
bootrec /fixmbr
bootrec /fixboot
bootrec /rebuildbcd
```

## ❌ 3. Windows Boot Manager Missing

### Meaning

* UEFI firmware cannot find EFI boot files

### Causes

* EFI System Partition (ESP) damaged or deleted
* Wrong BIOS mode selected (Legacy instead of UEFI)

### Technician Fix

Run the following from **Windows Recovery Environment (WinRE) → Command Prompt**:

```cmd
bcdboot C:\Windows /f UEFI
```

If the EFI partition requires a drive letter:

```cmd
bcdboot C:\Windows /s S: /f UEFI
```

> Ensure the system is booted in **UEFI mode**, not Legacy/CSM.

---

## ❌ 4. Error Code: 0xc000000f / 0xc0000225

### Meaning

* Boot Configuration Data (BCD) store is corrupted or missing

### Causes

* Improper shutdown
* Disk errors
* Deleted or damaged BCD files

### Technician Action

1. Check disk errors:

```cmd
chkdsk C: /f
```

2. Rebuild boot files:

```cmd
bcdboot C:\Windows
```

---

## ❌ 5. Automatic Repair Loop

### Meaning

* Windows starts → fails → restarts endlessly

### Common Causes

* Failed or bad Windows update
* Disk errors
* Corrupt system files

### Technician Flow

1. **Backup customer data first** (WinPE or another OS)
2. Run offline system file check:

```cmd
sfc /scannow /offbootdir=C:\ /offwindir=C:\Windows
```

3. If repair fails:

* Perform **clean Windows installation**

---

## ❌ 6. INACCESSIBLE_BOOT_DEVICE (BSOD)

### Meaning

* Windows cannot access the system disk during boot

### Causes

* SATA mode changed (AHCI ↔ RAID)
* Missing or incompatible storage driver
* Disk hardware failure

### Technician Fix

* Restore **original SATA mode** in BIOS
* Check disk health (SMART / diagnostics)
* Replace disk if failing

---

## ❌ 7. Black Screen with Cursor

### Meaning

* Windows loads partially but desktop does not appear

### Causes

* Explorer.exe crash
* GPU / display driver issue
* Corrupted user profile

### Technician Solution

* Enable built‑in Administrator account
* Create a new user profile
* Copy data from old profile to new one

---

> [!NOTE]
> **Technician Tip:** Always verify BIOS mode (UEFI vs Legacy), disk health, and data safety before advanced repairs.


### 🧠 QUICK MEMORY TABLE
> Error	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; First Check

>No Boot Device	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BIOS mode

> BOOTMGR missing	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Legacy BCD

> Boot Manager &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;missing	EFI

> 0xc0000225	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BCD

> Repair loop	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Disk / SFC

> Inaccessible boot	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SATA mode