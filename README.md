# TScene 

Isolated buffered container control for FireMonkey.

# FireMonkey Drawing Model

FireMonkey drawing model is different from classic UI model used for example on Windows. FM doesn't have own canvas for each control. Canvas is shared between all children controls of the form. 

The main goal of this model is supporting composition and semi-transparency controls. But disadvantage of it is processing whole tree of controls in every frame. On desktop platform FM quite optimised to use updating regions, but it is still requires to process whole tree.

# TScene drawing model

TScene is a TControl descendant which incapsulated IScene interface and provide isolated drawing of his children. Internally it has buffer where all children controls paint. 

When TScene paints to the form canvas it paints his buffer only. If children control want to be updated, TScene paints this control to own buffer and keep it unmodified to next update requiest.

Using of TScene allows dramatically improve drawing performance of complicated controls tree or complcated control (for example group of TPath or big image).

TScene break FM drawing model, which means when form paints all his children it stops on TScene and doesn't process TScene's children controls. 

[![TScene Demo](https://img.youtube.com/vi/LawyqK2tz9E/0.jpg)](https://www.youtube.com/watch?v=LawyqK2tz9E)

# Compatibility

TScene tested on Delphi Tokyo. Supports all FireMonkey platforms. Linux version requires FmxLinux from http://www.fmxlinux.com

Copyright (c) 2017 Eugene Kryukov

http://www.ksdev.com