Return-Path: <netdev+bounces-210580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B673B13F66
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90762164F0E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BBC27465C;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVtETEYT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC0B273D7C;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718542; cv=none; b=iiZDjhnjGhmmc39ajqToY3YL5iyRTp/KWPvIKQESn41aAg4Qy/+K0fxyVNWNUuTdiy6KOjLVxFFkdXg1xMqShJ8C0pCbWGyeMvktgRfFERj56fXP9OZ4Mr/GbAX6IsVteYLe7W8sJNporNDeXTJJ2cZCIKODcOkxPh0ntH5qgoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718542; c=relaxed/simple;
	bh=CA8rENJCqrPXF4f4frEOOWVuEMYfDrH4SLtxePG/My8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3yjBx3bcxuxSyikNIIwrJkuty9kb1Dwe33PIwE2atHgnV8/dVGmyUuUjU1NRKL/+Yy6W3deSaG9v/nYAblMPxvGMefAjE4aNMU8/mYVATmGRvs5cWyiymMZmq7rL1CFeEdrPzzsAYKYqWZlXIP4wYrebdnD8twmNKR2cgUz4c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVtETEYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21148C116D0;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753718542;
	bh=CA8rENJCqrPXF4f4frEOOWVuEMYfDrH4SLtxePG/My8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVtETEYTFqLYBIljuChujb1J58Zw8yQbjVgsgEWAVOy4b20CDT7F+a3/Ffx5jOWqM
	 IYBZl9NfTRe+sKSq1X6dSTB5D5xqXCM9o0saX26xhtv4gL1vzL7kn+viD8BAHW16y1
	 1nw0SJ+tjRZ+K1aaRnGDBYYk6z2eSI3Tw+k3c8NR4COqKVsfT9QOV1zYETRqSpCP94
	 7q7bBsD7KLbie6pb2yFXeMSzSRVbAc3haeaIWnWbAA1T0A/Dtt+Spita90+QGxG9Kj
	 aBnGIWf9J7AJuDsxEaZvbegeK0kbdJ2wF4AYcjQb4kOB0EMtIJ+RdjdgaQ5V5Ne6l9
	 o1+eqR8zC25gA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugQIq-00000000Gcw-1Y3S;
	Mon, 28 Jul 2025 18:02:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Message-ID :" <cover.1752076293.git.mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Marco Elver" <elver@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"Simon Horman" <horms@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v10 06/14] docs: use parser_yaml extension to handle Netlink specs
Date: Mon, 28 Jul 2025 18:01:59 +0200
Message-ID: <4c97889f0674b69f584dedc543a879d227ef5de0.1753718185.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753718185.git.mchehab+huawei@kernel.org>
References: <cover.1753718185.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Instead of manually calling ynl_gen_rst.py, use a Sphinx extension.
This way, no .rst files would be written to the Kernel source
directories.

We are using here a toctree with :glob: property. This way, there
is no need to touch the netlink/specs/index.rst file every time
a new Netlink spec is added/renamed/removed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/Makefile                        | 17 ----------------
 Documentation/conf.py                         | 20 ++++++++++++++-----
 Documentation/networking/index.rst            |  2 +-
 .../networking/netlink_spec/readme.txt        |  4 ----
 4 files changed, 16 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b98477df5ddf..820f07e0afe6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -104,22 +104,6 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
 	fi
 
-YNL_INDEX:=$(srctree)/Documentation/networking/netlink_spec/index.rst
-YNL_RST_DIR:=$(srctree)/Documentation/networking/netlink_spec
-YNL_YAML_DIR:=$(srctree)/Documentation/netlink/specs
-YNL_TOOL:=$(srctree)/tools/net/ynl/pyynl/ynl_gen_rst.py
-
-YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
-YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))
-
-$(YNL_INDEX): $(YNL_RST_FILES)
-	$(Q)$(YNL_TOOL) -o $@ -x
-
-$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
-	$(Q)$(YNL_TOOL) -i $< -o $@
-
-htmldocs texinfodocs latexdocs epubdocs xmldocs: $(YNL_INDEX)
-
 htmldocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
@@ -186,7 +170,6 @@ refcheckdocs:
 	$(Q)cd $(srctree);scripts/documentation-file-ref-check
 
 cleandocs:
-	$(Q)rm -f $(YNL_INDEX) $(YNL_RST_FILES)
 	$(Q)rm -rf $(BUILDDIR)
 	$(Q)$(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media clean
 
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 700516238d3f..f9828f3862f9 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -42,6 +42,15 @@ exclude_patterns = []
 dyn_include_patterns = []
 dyn_exclude_patterns = ["output"]
 
+# Currently, only netlink/specs has a parser for yaml.
+# Prefer using include patterns if available, as it is faster
+if has_include_patterns:
+    dyn_include_patterns.append("netlink/specs/*.yaml")
+else:
+    dyn_exclude_patterns.append("netlink/*.yaml")
+    dyn_exclude_patterns.append("devicetree/bindings/**.yaml")
+    dyn_exclude_patterns.append("core-api/kho/bindings/**.yaml")
+
 # Properly handle include/exclude patterns
 # ----------------------------------------
 
@@ -102,12 +111,12 @@ extensions = [
     "kernel_include",
     "kfigure",
     "maintainers_include",
+    "parser_yaml",
     "rstFlatTable",
     "sphinx.ext.autosectionlabel",
     "sphinx.ext.ifconfig",
     "translations",
 ]
-
 # Since Sphinx version 3, the C function parser is more pedantic with regards
 # to type checking. Due to that, having macros at c:function cause problems.
 # Those needed to be escaped by using c_id_attributes[] array
@@ -204,10 +213,11 @@ else:
 # Add any paths that contain templates here, relative to this directory.
 templates_path = ["sphinx/templates"]
 
-# The suffix(es) of source filenames.
-# You can specify multiple suffix as a list of string:
-# source_suffix = ['.rst', '.md']
-source_suffix = '.rst'
+# The suffixes of source filenames that will be automatically parsed
+source_suffix = {
+    ".rst": "restructuredtext",
+    ".yaml": "yaml",
+}
 
 # The encoding of source files.
 # source_encoding = 'utf-8-sig'
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index ac90b82f3ce9..b7a4969e9bc9 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -57,7 +57,7 @@ Contents:
    filter
    generic-hdlc
    generic_netlink
-   netlink_spec/index
+   ../netlink/specs/index
    gen_stats
    gtp
    ila
diff --git a/Documentation/networking/netlink_spec/readme.txt b/Documentation/networking/netlink_spec/readme.txt
deleted file mode 100644
index 030b44aca4e6..000000000000
--- a/Documentation/networking/netlink_spec/readme.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-SPDX-License-Identifier: GPL-2.0
-
-This file is populated during the build of the documentation (htmldocs) by the
-tools/net/ynl/pyynl/ynl_gen_rst.py script.
-- 
2.49.0


