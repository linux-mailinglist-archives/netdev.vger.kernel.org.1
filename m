Return-Path: <netdev+bounces-196912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A156AAD6DDF
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397BC173318
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D5924A049;
	Thu, 12 Jun 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIvFjxxH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73CE23BCF5;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724344; cv=none; b=qSjJdG2bKkxHuEtFqYbB/782+z6QbKYeRZi+hGmp69BuTt1tO7o8Cov8WQiKnrpTbEiG85udBwvMgSKZohUfjkq5JKP9H+40HdSBs8JC1zdV0c9nsJ93HB4jnjhchjNW+Mh+bcHyn/MIck196aojwEVCRDImhpa75ha+Jm60NoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724344; c=relaxed/simple;
	bh=YBkjGXm+GCy8o/xx1o50ol5uO7XCwqyBr79mwHQ/z4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDEX4w+nxEpodtoGbXPXou1oOl+XnC8iA5NVyFyUiu11NP4SGJoN3wxksVMQs3gnLLRnaBeRPrA7Z289op123iOfp9en2sckvl3HEo0Oc84soiMn9F8X7Uyl2+5te8IJLxRoyRK4J7SP9eZ9DWYBjRTtJI+PEVxmJgyBnCnm3t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIvFjxxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E750C4CEF5;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749724344;
	bh=YBkjGXm+GCy8o/xx1o50ol5uO7XCwqyBr79mwHQ/z4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIvFjxxHXLjtu9RG/0hh2fAT2EhjsnI8WGVtWNmo0ksejwV2BjolKsW21iWSqx4Qi
	 fKIUob50ROUZZ5Y7ow8D3vjjloDjxde8nx+YQjmpu2bRGWA/XyZaT2q0sFbj3WPJio
	 dQ6iSDLLdr81WcEomt97OQOjrEp9b5N0B4lm9pgEEqAB9GgAN8VkeJYc1Gb11te8fn
	 7XVNHmMIYXzlOoaeU6BEW1If8f7EAKU+9Q5JhM124DaBHFei9g1YkaMvxL9pGSCKSD
	 ddK3LO+dLlO9835dYauiKjknYfCq7PC8EMA2IB7q6zGCPTp2BrTDbKsWrpdGZoPl06
	 XZd2vC9Ky4cTQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uPfEM-00000004yvk-2SQD;
	Thu, 12 Jun 2025 12:32:22 +0200
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
Subject: [PATCH v2 11/12] docs: use parser_yaml extension to handle Netlink specs
Date: Thu, 12 Jun 2025 12:32:03 +0200
Message-ID: <931e46a6fdda4fa67df731b052c121b9094fbd8a.1749723671.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749723671.git.mchehab+huawei@kernel.org>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
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


