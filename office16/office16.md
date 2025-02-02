# Установка Microsoft Office 2016 на Linux через Bottles

## Метод 1: Автоматическая установка с помощью скрипта

Этот метод автоматизирует создание и настройку бутылки с помощью скрипта. 

### Шаги:
1. Скачайте и запустите скрипт:
   ```bash
   curl -o install_office_bottles.sh https://example.com/install_office_bottles.sh
   chmod +x install_office_bottles.sh
   ./install_office_bottles.sh
   ```
2. Дождитесь завершения установки.
3. Откройте Bottles и установите Office 2016 вручную.

---

## Метод 2: Ручная установка

Этот метод предполагает настройку бутылки вручную через Bottles.

### Шаги:
1. Установите необходимые пакеты:
   ```bash
   flatpak install -y com.usebottles.bottles
   pip install --user bottles-cli
   ```

2. Создайте бутылку с параметрами:
   ```bash
   bottles-cli create "Office-2016" --environment Custom --runner caffe-9.7 --arch x86
   ```

3. Установите совместимость с Windows 7:
   ```bash
   bottles-cli override "Office-2016" --set-version win7
   ```

4. Добавьте настройки реестра:
   ```bash
   echo "\n[Software\\Wine\\Direct2D]\n\"max_version_factory\"=dword:00000000\n" >> "$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles/Office-2016/user.reg"
   echo "\n[Software\\Wine\\Direct3D]\n\"MaxVersionGL\"=dword:00030002\n" >> "$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles/Office-2016/user.reg"
   ```

5. Установите зависимости через Winetricks:
   ```bash
   WINEPREFIX="$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles/Office-2016" winetricks corefonts msxml6 msxml4 vcrun2005 vcrun2008 \
     vcrun2010 vcrun2012 vcrun2013 vcrun2019 msftedit riched20 riched30 msxml6 gdiplus \
     mspatcha dotnet20 dotnet40 mfc100 cjkfonts wsh57
   ```

6. Включите эмуляцию виртуального рабочего стола:
   ```bash
   echo "\n[Software\\Wine\\Explorer]\n\"Desktop\"=\"1920x1000\"\n" >> "$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles/Office-2016/user.reg"
   ```

7. Скачайте и поместите `WinSCard.dll` в систему:
   ```bash
   wget -O "$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles/Office-2016/drive_c/windows/system32/WinSCard.dll" https://example.com/path/to/WinSCard.dll
   ```

8. Запустите установку Microsoft Office 2016 через Bottles.

После установки Office 2016 можно запускать его через Bottles.
