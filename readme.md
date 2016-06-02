������ ���� ���� 2.304-81
=========================

����� ������� �������� �������� ������� �� ���� 2.304-81 � ��������� ��������, �������������� [FontForge][].

�������������� � �������� ���� ������� - ������� ������ True Type �������, ���������������� ��� �������������
� XeLaTeX (LuaTeX).
������, [FontForge][] ������������ � ��������� TeX �������, ������� �� ���� ������� ������� �������� ��������
TeX ����������� ������� �� ���� 2.304-81.

������ �������� ����������� �������������� �������, ����������� ������������ �� � �������������� ������ TeX.

������ �������
--------------

��� �������� ��������� � ����� � ��������� ������ ������� ����������� ��������� ��������:

- [CygWin][]
- [GitVersion][]
- [FontForge][] ������ �� ������ 27.08.2015
- [TTFAutoHint][]
- [FastFont][] (��� ����������� ������������ ttf �������)
- [WIX][] (������ ��� ������ msi ������� � msi ������������ ��� ��������� ������ � Windows, ��������� WiX 4)
- [MikTeX][]
- [CTANupload][]
- [latexmk][] (������ ��� ������ TeX ������� � ����������)

��� ���������� ����� ������ ������� ��������������� ��������� `prepare.ps1` (��������� �� ����� ��������������).
��������� �������� ��������� ��� ����������� ����������.

������ ������� �������������� ��������� �������:

	make

����

	make all

### ����

#### True Type Fonts - `ttf`

������ True Type Fonts (.ttf) �������������� ��������� �������:

	make ttf

[TTFAutoHint][] �� ����������, ����������� ��� ��� ����, ����� �������� ���������� �������� ����������� �������
��� ����� ������, ��� ���� �� ������� � ������ "�������" ������������. � ��������, ����� ��������� 
������� �������� ����� � ������ ������, ����� ������������� [TTFAutoHint][] �� ����������� �����.

�� ������ ������ �� ��������� ������������ �������������������� ���������� [TTFAutoHint][], � �� [FontForge][].
��� ��������������� ������������� [FontForge][]:

	make ttf AUTOHINT=fontforge
	
#### True Type Fonts Collection - `ttc`

������ [True Type Fonts Collection (.ttc)](<http://en.wikipedia.org/wiki/TrueType#TrueType_Collection>) �������������� ��������� �������:

	make ttc

������ ���� ������� ��������������� ������ ���� `ttf`.

������ ������ - ������� ����� �������� ������ ������� ��������� ���� 2.304-81 � ����� �����. �������������� Windows.

#### Web Open Font Format - `woff`

������ [WOFF][] �������������� ��������� �������:

	make woff

������ ���� ������� ��������������� ������ ���� `ttf`.

#### �������� ����� ��� LaTeX gost2.304 - `tex-pkg`

������ ��������� ������ �������������� ��������� �������:

	make tex-pkg

������ ���� ������� ��������������� ������ ���� `ttf`.

#### .pdf ���� ������������ ������ gost2.304 - `doc`

������ ������������ �������������� ��������� �������:

	make doc

������ ���� ������� ��������������� ������ ���� `tex-pkg`, �������.
�� ��������� ��������� .pdf �� ������������. ������, ��������� ��������� ������

	make doc VIEWPDF=yes

������� .pdf �� �������� ����� ������� ������.

#### ���� ��� �������� ��������� ������ ��� LaTeX gost2.304 � CTAN - `ctan`

������ ������ ��� CTAN �������������� ��������� �������:

	make ctan

#### �������� ��������� ������ ��� LaTeX gost2.304 � CTAN - `ctanupload`

�������� ��������������� ������ � CTAN �������������� ��������� �������:

	make ctanupload

#### MSI ������ (.msm ����) ��� ��������� � ������ MS Installer �������������

������ .msm ����� �������������� ��������� �������:

	make msm

������ ���� ������� ��������������� ������ ���� `ttf`.

#### MSI ����� (.msi ����) ��� ��������� ������� � MS Windows, � ��� ����� - ��� ������������ � ������ ����� GPO

������ .msi ������ �������������� ��������� �������:

	make msi

������ ���� ������� ��������������� ������ ����� `ttf`, `msm`.

�������� ���������
------------------

����������� ������� �������� �� ������ https://github.com/Metrolog/Font.GOST2.304-81.
��������� ��������� - [GitFlow](https://habrahabr.ru/post/106912/). � �������� GUI
� ���������� ����������� � ���������� GitFlow ����������
[SourceTree](https://www.sourcetreeapp.com/).

��� �������� ��������� � ������ ����������� ����������� fork �������, � ������������
� GitFlow �������� ���� feature, ���� patch �����, � ���������� Pull Request � �������� 
�����������. ��� ������ ����� ����� ��������� patch/<����� issue>.

������������ ����������
-----------------------

������ ����� ������������� ���������� ������� � ����� ������, � ����� �������� �� ��������� ������: <http://scripts.sil.org/OFL>.
������������ ������, � ��� ����� - �������������� ������������ ������, �� ��������������� � �� ��������.

[CTANupload]: http://ctan.org/pkg/ctanupload
[FontForge]: https://github.com/fontforge/fontforge
[CygWin]: http://cygwin.com/install.html "Cygwin"
[GitVersion]: https://github.com/GitTools/GitVersion
[GNUWin32 make]: http://gnuwin32.sourceforge.net/packages/make.htm "GNU make for windows"
[GNUWin32 Core Utils]: http://gnuwin32.sourceforge.net/packages/coreutils.htm
[GNUWin32 ZIP]: http://gnuwin32.sourceforge.net/packages/zip.htm
[GNUWin32 TAR]: http://gnuwin32.sourceforge.net/packages/gtar.htm
[MikTeX]: http://www.miktex.org
[latexmk]: https://www.ctan.org/pkg/latexmk/ "latexmk � Fully automated LaTeX document generation"
[Perl]: https://www.perl.org/get.html#win32 "Perl"
[TTC]: http://en.wikipedia.org/wiki/TrueType#TrueType_Collection "True Type Fonts Collection"
[TTFAutoHint]: http://www.freetype.org/ttfautohint
[FastFont]: http://www.microsoft.com/typography/tools/tools.aspx "FastFont"
[WOFF]: http://en.wikipedia.org/wiki/Web_Open_Font_Format "Web Open Font Format"
[WIX]: http://wixtoolset.org/releases/ "WiX Toolset 4"
