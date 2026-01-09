# ADVANCED BOOT REPAIR (UEFI & LEGACY)

## 🔹 UEFI (GPT Disk)
```cmd
diskpart
list vol
select vol EFI
assign letter=S
exit
bcdboot C:\Windows /s S: /f UEFI
```

## 🔹 Legacy (MBR Disk)
```cmd
bootrec /fixmbr
bootrec /fixboot
bootrec /rebuildbcd
```
