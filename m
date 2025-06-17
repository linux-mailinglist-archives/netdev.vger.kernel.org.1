Return-Path: <netdev+bounces-198462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DB9ADC410
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE557A4E18
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27825293C73;
	Tue, 17 Jun 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T89YkpEh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4C428DB76;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147352; cv=none; b=ej9zQdPGae2DdJ/7feiOfspVWtbfdb+ShqnJrNInVgt+6QtqAyTvRFcH2XHUaonXmIpj3PM6wljMCDGYzVyvEGf0R/EO2WRsZqJXA2veEtWWjc86BxU3W1KCAptaFBU9qZ2AcOnhIVj8MgAFDVuCwZH5QSebYK6aIJnP6ZCSHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147352; c=relaxed/simple;
	bh=kQHlY3bWllau5HvjKpHpFCWRhH0lO7fc0jbc3mDapcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqqcQzLltLshKMN8ZR1FaEhY/IlZOOEC/71UeE9Njy1Wj7JLIuZB4uQ7CCpkRX8NfZ4PqvceenYoXvYkPKiIKhnLYI444V9T2wUx/EQ/lqlpbuhVVPPXP2QZ03QGSM2F/NEaJcldT/9rd7l16g8ACazqJpqOvo02dsKlzzb0GLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T89YkpEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1369C4AF0C;
	Tue, 17 Jun 2025 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750147352;
	bh=kQHlY3bWllau5HvjKpHpFCWRhH0lO7fc0jbc3mDapcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T89YkpEh+yt7E9PInVmtgyC2VDTBKs7zzPkmPoAaZkLz2LrXbXnwfVDE70OlWLtx+
	 0jAotLmsVKi6yOsZEyptFffUQ1BcuiT3JB47zpJX7OiVAixDEcAGmse7HKKgi6aU2t
	 uv/nlmr1d1120spfzMgqt/i3mxqcv0jSr62cRcvv6zTm5P6S16Tf13J6BeYV1HU8Tz
	 xOVRVkNdJEUYc7CRgh3H0ug3WO9x+LH1QWW/Ev9H/mJj3b1mU8vHo5woYxJVE9ZMcI
	 TTgWuokyEo1obBsCVkRB2vKs1ErAjDWp/+sQDX/L3AuCSVSa0BFkD8gjMDqedlbcqX
	 Kzm4OUdAYHiDg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRRH4-00000001vdV-0m2s;
	Tue, 17 Jun 2025 10:02:30 +0200
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
Subject: [PATCH v5 11/15] docs: use parser_yaml extension to handle Netlink specs
Date: Tue, 17 Jun 2025 10:02:08 +0200
Message-ID: <f4eecf1c638c0d98369dd16818d5b175e208d138.1750146719.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750146719.git.mchehab+huawei@kernel.org>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
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
---
 Documentation/Makefile                          | 17 -----------------
 Documentation/conf.py                           | 13 +++++++------
 Documentation/networking/index.rst              |  2 +-
 .../networking/netlink_spec/readme.txt          |  4 ----
 4 files changed, 8 insertions(+), 28 deletions(-)
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
index e887c1b786a4..a17940ac730f 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -25,7 +25,7 @@ include_patterns = ['**.rst']
 exclude_patterns = []
 
 # List of patterns that contain directory names in glob format.
-dyn_include_patterns = []
+dyn_include_patterns = ['netlink/specs/*.yaml']
 dyn_exclude_patterns = ['output']
 
 # Properly handle include/exclude patterns
@@ -93,7 +93,7 @@ needs_sphinx = '3.4.3'
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
-              'kernel_abi', 'kernel_feat', 'translations']
+              'kernel_abi', 'kernel_feat', 'translations', 'parser_yaml']
 
 # Since Sphinx version 3, the C function parser is more pedantic with regards
 # to type checking. Due to that, having macros at c:function cause problems.
@@ -191,10 +191,11 @@ else:
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
-- 
2.49.0


