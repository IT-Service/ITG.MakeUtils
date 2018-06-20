ifndef ITG_MAKEUTILS_LOADED
$(error 'ITG.MakeUtils/common.mk' must be included before any ITG.MakeUtils files.)
endif

ifndef MAKE_SIGNING_SIGN_BASIC_DIR
MAKE_SIGNING_SIGN_BASIC_DIR = $(ITG_MAKEUTILS_DIR)signing/

include $(ITG_MAKEUTILS_DIR)signing/sign.mk

CODE_SIGNING_CERTIFICATE_DIR = certificate/
CODE_SIGNING_CERTIFICATE := $(CODE_SIGNING_CERTIFICATE_DIR)cert.pfx
export CODE_SIGNING_CERTIFICATE_PFX := $(basename $(CODE_SIGNING_CERTIFICATE)).pfx
$(eval $(call pushArtifactTarget,CODE_SIGNING_CERTIFICATE_PFX))
export CODE_SIGNING_CERTIFICATE_PVK := $(basename $(CODE_SIGNING_CERTIFICATE)).pvk
$(eval $(call pushArtifactTarget,CODE_SIGNING_CERTIFICATE_PVK))
CODE_SIGNING_CERTIFICATE_PVK_PEM := $(basename $(CODE_SIGNING_CERTIFICATE)).key.pem
export CODE_SIGNING_CERTIFICATE_SPC := $(basename $(CODE_SIGNING_CERTIFICATE)).spc
$(eval $(call pushArtifactTarget,CODE_SIGNING_CERTIFICATE_SPC))
CODE_SIGNING_CERTIFICATE_SPC_PEM := $(basename $(CODE_SIGNING_CERTIFICATE)).spc.pem
export CODE_SIGNING_CERTIFICATE_TARGETS := $(CODE_SIGNING_CERTIFICATE_PFX) $(CODE_SIGNING_CERTIFICATE_PVK) $(CODE_SIGNING_CERTIFICATE_SPC)
$(eval $(call pushArtifactTarget,CODE_SIGNING_CERTIFICATE_TARGETS))

ifneq ($(CI),True)

$(eval $(call exportCodeSigningCertificate,$(CODE_SIGNING_CERTIFICATE_PFX)))

endif

.PHONY: pfx
pfx: $(CODE_SIGNING_CERTIFICATE_PFX)

$(eval $(call exportCertificateKeyFromPfx2Pem,$(CODE_SIGNING_CERTIFICATE_PVK_PEM),$(CODE_SIGNING_CERTIFICATE_PFX)))
$(eval $(call convertCertificateKeyPem2Pvk,$(CODE_SIGNING_CERTIFICATE_PVK),$(CODE_SIGNING_CERTIFICATE_PVK_PEM)))
.PHONY: pvk
pvk: $(CODE_SIGNING_CERTIFICATE_PVK)

$(eval $(call exportCertificateFromPfx2Pem,$(CODE_SIGNING_CERTIFICATE_SPC_PEM),$(CODE_SIGNING_CERTIFICATE_PFX)))
$(eval $(call convertCertificatePem2Spc,$(CODE_SIGNING_CERTIFICATE_SPC),$(CODE_SIGNING_CERTIFICATE_SPC_PEM)))
.PHONY: spc
spc: $(CODE_SIGNING_CERTIFICATE_SPC)

clean::
	$(RMDIR) $(CODE_SIGNING_CERTIFICATE_DIR)

endif
