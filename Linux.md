## Reaper on Linux
Download Reaper for linux from http://landoleet.org and make sure you have JACK installed.




#### Installing the SWS Extension

```bash
git clone http://www-dev.cockos.com/wdl/WDL.git
git clone https://github.com/reaper-oss/sws.git
cd sws
git checkout next
```
Run the action *"Write C++ API functions header"* to generate ```git/sws/reaper_plugin_functions.h``` from the  action")

 ```bash
make
ln -s `pwd`/reaper_sws64.so .../REAPER/Plugins
```
