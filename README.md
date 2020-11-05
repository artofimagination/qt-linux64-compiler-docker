# qt-linux64-compiler-docker
Contains the setup to create a qt application complier docker image under linux.

At the moment it supports Qt 5.12.8

Installed modules
 - QtBase
 - QtCharts
 - QtVisualize

The prebuilt docker image can be pulled using:
```docker pull artofimagination/qt-linux-compiler```

If specific version is needed the tags are formatted as follows
```docker pull artofimagination/qt-linux-compiler:v1.0.2_qt5.12.8```
