Return-Path: <netdev+bounces-199341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CF3ADFE12
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8EF17E9D5
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC2C25F986;
	Thu, 19 Jun 2025 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWjU2mvT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F6E248F7C;
	Thu, 19 Jun 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750315821; cv=none; b=HSU9B5YdID6gGoE31O0hey9CjQ0QnKHGMKJf+Ab+TQCVkCQWHFCjXYpAG/JLC20wK0dt5W+QoUm+e+RBudRD4ogaSLCCrdQxekvWhlJ8zu1j/8qn80/IyPNAuRxA+ZcErIyID2NtlX1+/oyTz7si1zTTPsFoXqDEhG2164hkp8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750315821; c=relaxed/simple;
	bh=x9AeS/miPbBkEF42gU7I9M77AvT46AbR0fPXxclljq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psHnY05aH6s9YeIRW2U20EQhSAk3L+12hJuBuhIBhKH8hyW6y4+P2s5PsdNnAc9cCx0SBjv8LD3w8OVASyqJpsdaKFA9RGd22T9jvi756X62Kv0HfWwtMvRPfyNmmodYLeL/yY8wd2O00N5ZrYzSvChHGI26zs541tB8lHQKx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWjU2mvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9C7C4AF0B;
	Thu, 19 Jun 2025 06:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750315820;
	bh=x9AeS/miPbBkEF42gU7I9M77AvT46AbR0fPXxclljq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hWjU2mvTM8g3G+veWzWN4pE+zeRfUiKQcQoXloMNBLLEWidB9wwBFLG74ItSk9Tos
	 CaB4dY++KdR0QYeMWJoW+S+YegVvX8Q8n7u42SNZKU/GlYBFDQhHKhOm4qi3cOoZmM
	 BPvYL31Pg6GFTpnns3+c9ocfk/f+r2gO8iSjwugZEd4L5TDTtucjK0tqD20rD6ehHx
	 qMMxLtMq3CSRsqykDJLdG+dLPlxjXC8GB5sQUxV5rb68jpkfxL0bRCPdXn/PAAMjWp
	 zuhyYBQcw2jNybPnWauMF5XSlGLXu9u5v8CW+zNbGznsrTmOgX074oFiODWEHR9kOf
	 DMxsbygqf1EDw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uS96J-00000003dH3-09OJ;
	Thu, 19 Jun 2025 08:50:19 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v7 08/17] docs: use parser_yaml extension to handle Netlink specs
Date: Thu, 19 Jun 2025 08:49:01 +0200
Message-ID: <4ee82983b4702f4c52296c3bae9c5be8b452650a.1750315578.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750315578.git.mchehab+huawei@kernel.org>
References: <cover.1750315578.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

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
 Documentation/sphinx/parser_yaml.py           |  4 ++--
 5 files changed, 18 insertions(+), 29 deletions(-)
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
index 4ba4ee45e599..6af61e26cec5 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -38,6 +38,15 @@ exclude_patterns = []
 dyn_include_patterns = []
 dyn_exclude_patterns = ['output']
 
+# Currently, only netlink/specs has a parser for yaml.
+# Prefer using include patterns if available, as it is faster
+if has_include_patterns:
+    dyn_include_patterns.append('netlink/specs/*.yaml')
+else:
+    dyn_exclude_patterns.append('netlink/*.yaml')
+    dyn_exclude_patterns.append('devicetree/bindings/**.yaml')
+    dyn_exclude_patterns.append('core-api/kho/bindings/**.yaml')
+
 # Properly handle include/exclude patterns
 # ----------------------------------------
 
@@ -105,7 +114,7 @@ needs_sphinx = '3.4.3'
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
-              'kernel_abi', 'kernel_feat', 'translations']
+              'kernel_abi', 'kernel_feat', 'translations', 'parser_yaml']
 
 # Since Sphinx version 3, the C function parser is more pedantic with regards
 # to type checking. Due to that, having macros at c:function cause problems.
@@ -203,10 +212,11 @@ else:
 # Add any paths that contain templates here, relative to this directory.
 templates_path = ['sphinx/templates']
 
-# The suffix(es) of source filenames.
-# You can specify multiple suffix as a list of string:
-# source_suffix = ['.rst', '.md']
-source_suffix = '.rst'
+# The suffixes of source filenames that will be automatically parsed
+source_suffix = {
+        '.rst': 'restructuredtext',
+        '.yaml': 'yaml',
+}
 
 # The encoding of source files.
 #source_encoding = 'utf-8-sig'
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
diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
index 635945e1c5ba..2b2af239a1c2 100755
--- a/Documentation/sphinx/parser_yaml.py
+++ b/Documentation/sphinx/parser_yaml.py
@@ -15,9 +15,9 @@ from sphinx.util import logging
 from sphinx.parsers import Parser
 
 srctree = os.path.abspath(os.environ["srctree"])
-sys.path.insert(0, os.path.join(srctree, "tools/net/ynl/pyynl"))
+sys.path.insert(0, os.path.join(srctree, "tools/net/ynl/pyynl/lib"))
 
-from netlink_yml_parser import YnlDocGenerator        # pylint: disable=C0413
+from doc_generator import YnlDocGenerator        # pylint: disable=C0413
 
 logger = logging.getLogger(__name__)
 
-- 
2.49.0


