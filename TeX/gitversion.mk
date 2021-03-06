ifndef ITG_MAKEUTILS_LOADED
$(error 'ITG.MakeUtils/common.mk' must be included before any ITG.MakeUtils files.)
endif

ifndef MAKE_TEX_GITVERSION_DIR
MAKE_TEX_GITVERSION_DIR = $(ITG_MAKEUTILS_DIR)TeX/

include $(ITG_MAKEUTILS_DIR)gitversion.mk

%/version.tex %/version.dtx: $(REPOVERSION)
	$(call writeinformation,Generating latex version file "$@"...)
	$(MAKETARGETDIR)
	@git log -1 --date=format:%Y/%m/%d --format="format:\
%%\iffalse%n\
%%<*version>%n\
%%\fi%n\
\def\GITCommitterName{%cn}%n\
\def\GITCommitterEmail{%ce}%n\
\def\GITCommitterDate{%cd}%n\
\def\ExplFileDate{%ad}%n\
\def\ExplFileVersion{$(FULLVERSION)}%n\
\def\ExplFileAuthor{%an}%n\
\def\ExplFileAuthorEmail{%ae}%n\
%%\iffalse%n\
%%</version>%n\
%%\fi%n\
" > $@
	touch $@
	$(call writeinformation,File "$@" is ready.)

endif
