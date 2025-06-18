Return-Path: <netdev+bounces-199027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB1ADEABB
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41ECB189F149
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670322E7622;
	Wed, 18 Jun 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDsXTwvB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4338D2DE200;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247212; cv=none; b=cATNM32Rmjm8HWUzW8AalrY4WrID29m7IycE61moZJ1ajBhh/aCsfy18h8ara6eipGldH5L2DpgaNCP5idsJhitHfet30n+l3JdjM9MokE6j2pfgGd9vBOZSFTM4ekpADVNIQi4nCGLM4gWhfmXp1nue+B2YF5MSQpmyx+GpVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247212; c=relaxed/simple;
	bh=x9AeS/miPbBkEF42gU7I9M77AvT46AbR0fPXxclljq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6hZv01UfYBM0ekIk5u1AfSDz2ss6zoFq3+c+LgtmZf1SiV1As9xO/NOTuqXlQbcFUN/Gq8rmhEH1KVBURrhfbNILfrZljqTGie2cC6nWY6KeujMs3xgme6Zg/m924d1H8V++5K/jiESKDVNnyj/L5QMLDdDpt15e6S9hMTBozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDsXTwvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7083DC4CEF5;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247211;
	bh=x9AeS/miPbBkEF42gU7I9M77AvT46AbR0fPXxclljq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDsXTwvBmZ6inEQ0GHo42mMBV2jpCmnV6UZth+MhAXsZj69ehsYRseecuhiPyrVTW
	 S0ht994iFisgUxnwl7UoJAanhfHukyaGk8AzxJZ0qQkwdoljdhIJNPE7NCh7bEX/uT
	 WRf/rTeIyIgLCtivY3No7sqKzGxXtxbdBDVM/mb78sajFjiMZ0SNadSoM8CC2D7MBF
	 lAG1kFAGLJlurI5MPWr4hWWHbKuMJQwOAfieIxNXoOHaiP6DZNN4MOtuBmUBICtdYk
	 YaSVhzrRAhTXdR/RzNYEoYYWknYeaIDyqpFmImvsJUry3ouhuq3fBpbwBM+t3iXyiu
	 2uQ4hKjUkB9Hg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRrFh-000000036Um-2hSN;
	Wed, 18 Jun 2025 13:46:49 +0200
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
Subject: [PATCH v6 08/15] docs: use parser_yaml extension to handle Netlink specs
Date: Wed, 18 Jun 2025 13:46:35 +0200
Message-ID: <4ee82983b4702f4c52296c3bae9c5be8b452650a.1750246291.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750246291.git.mchehab+huawei@kernel.org>
References: <cover.1750246291.git.mchehab+huawei@kernel.org>
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


