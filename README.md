# EmptyStandbyList

Auto task to empty standby memory

> **Note**
>
> - This 'Empty Standby List' was recovered from <https://web.archive.org/>

## Table of Contents

- [EmptyStandbyList](#emptystandbylist)
  - [Table of Contents](#table-of-contents)
  - [Instructions](#instructions)
    - [Online installation](#online-installation)
    - [Offline installation](#offline-installation)
  - [Special Thanks To](#special-thanks-to)

## Instructions

> **Warning**
>
> - You'll need powershell for any of both versions (online/offline)
> - You'll need git for offline installation

### Online installation

```powershell
iwr -useb https://raw.githubusercontent.com/Milton797/AutoEmptyStandbyList/master/installer.ps1 | iex
```

### Offline installation

```powershell
git clone https://github.com/Milton797/AutoEmptyStandbyList
```

```powershell
cd AutoEmptyStandbyList
```

```powershell
.\Manager.ps1
```

## Special Thanks To

- [wj32 - Empty Standby List](https://web.archive.org/web/20220523182843/https://wj32.org/wp/software/empty-standby-list/ "Empty Standby List")
