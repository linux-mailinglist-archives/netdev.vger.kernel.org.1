Return-Path: <netdev+bounces-201448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 302F7AE97CA
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5993AC9FB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824FA25D546;
	Thu, 26 Jun 2025 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH+BjQ78"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80025A34F;
	Thu, 26 Jun 2025 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925612; cv=none; b=fLwSJOiIZz89FZKTeR29D24Jf9oQ7sKBtOBNCxNVxeebZ6IGIM/660QxVwYwdW32K2ct+WM/jZQEODH5ZEMKjmdSn1MPqEoi6hfWKrui5Wj/U0/SBLEAWB5hiwyXWJpm80X8WoHrWTI/3bTxnO4hO/TUcqNYDaXYogTf/Y5yS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925612; c=relaxed/simple;
	bh=iHs2YLyiVm8cEYcKdKpWDZ6rHJvAKljViYBGkYvueqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liIS7KPUJNv+asbVis3F92pxaxP9pSPchLRtm/WtQsRMkX0roW2/4rrpoLNd+Ysek04ZIjoaDpuc2/7NaaqkO75VkIVQpyRii9GvGyxhgAE+vCmy0zAhWuZg3arAolOQEtNwMXUBjc/U8eApB58MLakUPuVpZpVJDVUidZuaU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH+BjQ78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01E6C4CEEE;
	Thu, 26 Jun 2025 08:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925611;
	bh=iHs2YLyiVm8cEYcKdKpWDZ6rHJvAKljViYBGkYvueqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OH+BjQ787r9n2iPDLPZAeIZdctF6GKPi7AVCTcOP+R7LAg9q1slvyngycQVOIrJ3a
	 IN1yi0zcttgSJ0n4l9hupq/ytrKrjBtEby87niQ4vb5KCt6jlIQHfDeVZCFzTj2xlI
	 rDShkj2lKOkp9FSfevGyBpbF7ESs6pDoTKU8FQxIAP8kh21GOUHhzz8f3oCi0S9Ni/
	 3m3xSPyMGIpcLp/w5XF7YOnvy2jFE+LJP/GxrzkBVbMtRbOoZG8MHHYtNZT/1yv5xr
	 3dkNzKI70AaAu0HG8+yiAc7U+9O+iCqs5KEXuxy9tOk2+8l8ZXUQazOuDAqIyWFCXp
	 A2FuCB5UWj3nA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uUhjT-00000004svn-1Ywz;
	Thu, 26 Jun 2025 10:13:19 +0200
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
	"Randy Dunlap" <rdunlap@infradead.org>,
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
Subject: [PATCH v8 06/13] docs: use parser_yaml extension to handle Netlink specs
Date: Thu, 26 Jun 2025 10:13:02 +0200
Message-ID: <34e491393347ca1ba6fd65e73a468752b1436a80.1750925410.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750925410.git.mchehab+huawei@kernel.org>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
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
index df99a4d96b58..61dcc5fecb7c 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -106,6 +106,15 @@ exclude_patterns = []
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
 
@@ -166,12 +175,12 @@ extensions = [
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
@@ -268,10 +277,11 @@ else:
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
diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
index 585a7ec81ba0..fa2e6da17617 100755
--- a/Documentation/sphinx/parser_yaml.py
+++ b/Documentation/sphinx/parser_yaml.py
@@ -18,9 +18,9 @@ from sphinx.util import logging
 from sphinx.parsers import Parser
 
 srctree = os.path.abspath(os.environ["srctree"])
-sys.path.insert(0, os.path.join(srctree, "tools/net/ynl/pyynl"))
+sys.path.insert(0, os.path.join(srctree, "tools/net/ynl/pyynl/lib"))
 
-from netlink_yml_parser import YnlDocGenerator        # pylint: disable=C0413
+from doc_generator import YnlDocGenerator        # pylint: disable=C0413
 
 logger = logging.getLogger(__name__)
 
-- 
2.49.0


