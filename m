Return-Path: <netdev+bounces-197455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04005AD8B19
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B585F3BE8E4
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235052E2F1E;
	Fri, 13 Jun 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy3mxKtn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515042E7F0E;
	Fri, 13 Jun 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814967; cv=none; b=AxFUYCCynBo46xf/5JQaw8tOb8MZqlFW4u59VeNu89ssSBvILV9RAcv8/DrF5+Kl1XSxcIlyS2ZhZ57ysLfWkgAg0ysscGU9UeWmOyv0iTCKcbAmio86S+HT1jFyVJdfOyLu/ixj0GDI3niTaFo844iW+nHIKC/qYsN4jr4GjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814967; c=relaxed/simple;
	bh=YBkjGXm+GCy8o/xx1o50ol5uO7XCwqyBr79mwHQ/z4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/NLc+ox9zW5/e65YRhe98XGdHhN/tmbS1UueCq3/l+pMLQjVSnKFngI+nrjyWg1XO+f0feXGcS3y5xN6RyPix5jcE8abW6iA89ODSZFOdgRGBSRoxAUSLJxnFd64GlQkrRbxCWzzvDrZSxd9qxBOEov2v3gNe8rAJWnR97W1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy3mxKtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD90DC4CEFC;
	Fri, 13 Jun 2025 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749814966;
	bh=YBkjGXm+GCy8o/xx1o50ol5uO7XCwqyBr79mwHQ/z4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gy3mxKtnerMdNmaAfxLjcCdYev3j4LJ4Ma6S4xmXIuYZOG5rTcqSp0P2bRHTcy7p3
	 Q9XbPn9aViuqPD94eHh5mePfrxKwfdO7i1SHNE9dNOkIH+Vui3LO7z8csPWQqnIkhm
	 dBzRPx2+UYNo/UsfKSPD6YnB40Xu2cuBZfAnko6dOv/IC/ydzWYY/NNUWLBzIUJ2YD
	 D+rn48dAvUPrssNOtTYiC5OfHMtzPvyVATuWmTz6n7Arh6x4Jz54HMIw7GZ073lPpL
	 bjRdJpknjpciPMeJ5Trr37i0QpZNlbMzlA+vgsC3X6qXhowmDSdOm1kBJn4vqIYxMU
	 0jS65AuRqEnEA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQ2o1-00000005dFP-0XeS;
	Fri, 13 Jun 2025 13:42:45 +0200
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
Subject: [PATCH v3 11/16] docs: use parser_yaml extension to handle Netlink specs
Date: Fri, 13 Jun 2025 13:42:32 +0200
Message-ID: <931e46a6fdda4fa67df731b052c121b9094fbd8a.1749812870.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749812870.git.mchehab+huawei@kernel.org>
References: <cover.1749812870.git.mchehab+huawei@kernel.org>
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile                        | 17 ---------
 Documentation/conf.py                         | 11 +++---
 Documentation/netlink/specs/index.rst         | 38 +++++++++++++++++++
 Documentation/networking/index.rst            |  2 +-
 .../networking/netlink_spec/readme.txt        |  4 --
 Documentation/sphinx/parser_yaml.py           |  2 +-
 6 files changed, 46 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/netlink/specs/index.rst
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d30d66ddf1ad..9185680b1e86 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -102,22 +102,6 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
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
@@ -184,7 +168,6 @@ refcheckdocs:
 	$(Q)cd $(srctree);scripts/documentation-file-ref-check
 
 cleandocs:
-	$(Q)rm -f $(YNL_INDEX) $(YNL_RST_FILES)
 	$(Q)rm -rf $(BUILDDIR)
 	$(Q)$(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media clean
 
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 12de52a2b17e..add6ce78dd80 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -45,7 +45,7 @@ needs_sphinx = '3.4.3'
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
-              'kernel_abi', 'kernel_feat', 'translations']
+              'kernel_abi', 'kernel_feat', 'translations', 'parser_yaml']
 
 # Since Sphinx version 3, the C function parser is more pedantic with regards
 # to type checking. Due to that, having macros at c:function cause problems.
@@ -143,10 +143,11 @@ else:
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
diff --git a/Documentation/netlink/specs/index.rst b/Documentation/netlink/specs/index.rst
new file mode 100644
index 000000000000..ca0bf816dc3f
--- /dev/null
+++ b/Documentation/netlink/specs/index.rst
@@ -0,0 +1,38 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. NOTE: This document was auto-generated.
+
+.. _specs:
+
+=============================
+Netlink Family Specifications
+=============================
+
+.. toctree::
+   :maxdepth: 1
+
+   conntrack
+   devlink
+   dpll
+   ethtool
+   fou
+   handshake
+   lockd
+   mptcp_pm
+   net_shaper
+   netdev
+   nfsd
+   nftables
+   nl80211
+   nlctrl
+   ovpn
+   ovs_datapath
+   ovs_flow
+   ovs_vport
+   rt-addr
+   rt-link
+   rt-neigh
+   rt-route
+   rt-rule
+   tc
+   tcp_metrics
+   team
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
index eb32e3249274..cdcafe5b3937 100755
--- a/Documentation/sphinx/parser_yaml.py
+++ b/Documentation/sphinx/parser_yaml.py
@@ -55,7 +55,7 @@ class YamlParser(Parser):
         fname = document.current_source
 
         # Handle netlink yaml specs
-        if re.search("/netlink/specs/", fname):
+        if re.search("netlink/specs/", fname):
             if fname.endswith("index.yaml"):
                 msg = self.netlink_parser.generate_main_index_rst(fname, None)
             else:
-- 
2.49.0


