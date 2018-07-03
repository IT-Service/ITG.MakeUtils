ifndef ITG_MAKEUTILS_LOADED
$(error 'ITG.MakeUtils/common.mk' must be included before any ITG.MakeUtils files.)
endif

ifndef MAKE_GHOSTSCRIPT_DIR

MAKE_GHOSTSCRIPT_DIR = $(ITG_MAKEUTILS_DIR)

ifeq ($(OS),Windows_NT)

GSTOOL ?= gswin64c

else

GSTOOL ?= gs

endif

GS = $(GSTOOL) \
  -dSAFER \
  -dNOPAUSE \
  -dBATCH

PSRESOURCEOUTPUTDIR ?= $(OUTPUTDIR)Resource/
PSGENERICRESOURCEDIR =
GSINCDIR ?= %rom%Resource/ $(PSRESOURCEOUTPUTDIR)
GSFONTDIR ?=
PSRESOURCESOURCEDIR ?= ./
ENCODINGRESOURCEDIR := Encoding/
PROCSETRESOURCEDIR := ProcSet/
FONTRESOURCEDIR := Font/
RESOURCEDIRSUBDIRS = $(ENCODINGRESOURCEDIR) $(PROCSETRESOURCEDIR)

$(PSRESOURCEOUTPUTDIR) $(PSRESOURCEOUTPUTDIR)$(ENCODINGRESOURCEDIR) $(PSRESOURCEOUTPUTDIR)$(PROCSETRESOURCEDIR):
	$(MAKETARGETASDIR)


# $(call getPostScriptResourceSourceFiles[, resSourceDir])
getPostScriptResourceSourceFiles = \
  $(foreach d,$(if $1,$1,$(PSRESOURCESOURCEDIR)),$(wildcard $d*.ps) $(foreach s,$(RESOURCEDIRSUBDIRS), $(wildcard $d$s*.ps)))

# $(call getPostScriptResourceOutputFiles[, resSourceDir[, resOutputDir[, files]])
getPostScriptResourceOutputFiles = \
  $(patsubst %.ps,%,$(patsubst $(if $1,$1,$(PSRESOURCESOURCEDIR))%,$(if $2,$2,$(PSRESOURCEOUTPUTDIR))%,$(if $3,$3,$(call getPostScriptResourceSourceFiles,$1))))

# $(call preparePostScriptResource[, fromDir[, toDir[, files]]] )
define preparePostScriptResource

$(if $3,$(call getPostScriptResourceOutputFiles,$1,$2,$3):) $(if $2,$2,$$(PSRESOURCEOUTPUTDIR))%: $(if $1,$1,$$(PSRESOURCESOURCEDIR))%.ps
	$$(MAKETARGETDIR)
	$$(COPY) $$< $$@
	$$(TOUCH) $$@

$(if $2,$2,$$(PSRESOURCEOUTPUTDIR)): $(call getPostScriptResourceOutputFiles,$1,$2,$3)

endef

# $(call copyPostScriptResource[, fromDir[, toDir[, files]]] )
define copyPostScriptResource

$(if $3,$(call getPostScriptResourceOutputFiles,$1,$2,$3):) $(if $2,$2,$$(PSRESOURCEOUTPUTDIR))%: $(if $1,$1,$$(PSRESOURCESOURCEDIR))%
	$$(MAKETARGETDIR)
	$$(COPY) $$< $$@
	$$(TOUCH) $$@

$(if $2,$2,$$(PSRESOURCEOUTPUTDIR)): $(call getPostScriptResourceOutputFiles,$1,$2,$3)

endef


GSCMDLINE = $(GS) \
  $(if $(PSGENERICRESOURCEDIR),-sGenericResourceDir='$(PSGENERICRESOURCEDIR)') \
  $(foreach incdir,$(GSINCDIR),-I'$(strip $(incdir))') \
  $(if $(GSFONTDIR),-sFONTPATH='$(subst $(SPACE),$(PATHSEP),$(strip $(GSFONTDIR)))')

GSPSTOPDFCMDLINE = $(GSCMDLINE) \
  -sDEVICE=pdfwrite

$(OUTPUTDIR)%.pdf: $(SOURCESDIR)%.ps
	$(call writeinformation,Build file "$@" from "$<"...)
	$(MAKETARGETDIR)
	$(GSPSTOPDFCMDLINE) -sOutputFile='$@' '$<'
	$(call writeinformation,File "$@" is ready.)


ifdef MAKE_TESTS_DIR

TESTSPSFILES = $(wildcard $(TESTSDIR)*.ps)
TESTSPDFFILES = $(patsubst $(TESTSDIR)%.ps,$(AUXDIR)%.pdf,$(TESTSPSFILES))

# $(call definePostScriptTest,target,source,dependencies)
define definePostScriptTest

$(call defineTest,$(basename $(notdir $1)),ps_build,\
  $(GSCMDLINE) '$2';,\
  $2 $3 \
)

endef

# $(call definePostScriptTests,dependencies)
definePostScriptTests = $(foreach test,$(TESTSPSFILES),$(call definePostScriptTest,$(patsubst $(TESTSDIR)%.ps,$(AUXDIR)%.pdf,$(test)),$(test),$1))

# $(call definePostScriptBuildTest,target,source,dependencies)
define definePostScriptBuildTest

$(call defineTest,$(basename $(notdir $1)),ps_build,\
  $(GSPSTOPDFCMDLINE) -sOutputFile='$1' '$2';\
  $$(call pushDeploymentArtifactFile,$$(notdir $1),$1);,\
  $2 $3 \
)

endef

# $(call definePostScriptBuildTests,dependencies)
definePostScriptBuildTests = $(foreach test,$(TESTSPSFILES),$(call definePostScriptBuildTest,$(patsubst $(TESTSDIR)%.ps,$(AUXDIR)%.pdf,$(test)),$(test),$1))

endif

endif
