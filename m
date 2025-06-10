Return-Path: <netdev+bounces-196043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE9AD33F7
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583E77AAEFA
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D1E28D8D0;
	Tue, 10 Jun 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPJ8WUKu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2528D83B;
	Tue, 10 Jun 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552385; cv=none; b=qEThMWV6BjjTrQ4HE6JU2cEh1QOMNWb6zmMlqNo6NdaEAUP7SHjG2eSY5FP3XFQaUmtMLXO2rAbV6lOKv7Zo2U9awL5qPKvrjGGfWtZj764gG8itiggvqOOYxFaPs0HVp/lszjTasqkoQX1zDjDOkYD0gXJTpZlIu+ht+nlYAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552385; c=relaxed/simple;
	bh=DqGnZHFQp8okuryYab7hQcwECvzwCl4MaxLyGwcrIQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhfmK7s5ZSnlteklA+q+vaTR8NWidBYU9ZraU5xaX8U/DpAl9aFtC7MEFgh5p1i6N9HvhoJxa9gNOEA9tAbXjgbRCO2miyZS7o1c+uMNogjJj5FvfSD7szRCT8LUpaNEyXOtXpIZIopoNSNrHaL+jq6tFADIkwVOsYKojBOXwWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPJ8WUKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF638C4CEF3;
	Tue, 10 Jun 2025 10:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749552385;
	bh=DqGnZHFQp8okuryYab7hQcwECvzwCl4MaxLyGwcrIQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPJ8WUKukYWFWmWP9QnaP5c5AQPTfVT2OANISbaIUy6pmbh53JNPUpK1VBLjARB8o
	 naKBZ1l6iN1lL2/yd0DwZ3OezOcI2zCiaIllnqSmPsQbSuPSgOEcplMaJAPXYr006X
	 4cesXZ2qpsOMhOEYtVJjhGETR8HFHddJrcA3AfDGiEyCOLcd9BLrLuOcT6WGNgC87X
	 /MxsPn78Drj9fapsaTbGtV42lM4K+OVSRBWFr4vzU6MSXjUsq/ln0TIH0MI8+s6Gag
	 IdnQ10MItiGwQwh34NDOlM9MTKbWhAx1PnK2QEJSyYNPXl3qykghtshJpJqi/ALwFU
	 QdZ7BLaL0RRTw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uOwUp-00000003jv7-0NSM;
	Tue, 10 Jun 2025 12:46:23 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paul E. McKenney" <mchehab+huawei@kernel.org>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ruben Wauters <rubenru09@aol.com>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH 4/4] docs: netlink: store generated .rst files at Documentation/output
Date: Tue, 10 Jun 2025 12:46:07 +0200
Message-ID: <5183ad8aacc1a56e2dce9cc125b62905b93e83ca.1749551140.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749551140.git.mchehab+huawei@kernel.org>
References: <cover.1749551140.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

It is not a good practice to store build-generated files
inside $(srctree), as one may be using O=<BUILDDIR> and even
have the Kernel on a read-only directory.

Change the YAML generation for netlink files to be inside
the documentation output directory.

This solution is not perfect, though, as sphinx-build only produces
html files only for files inside the source tree. As it is desired
to have one netlink file per family, it means that one template
file is required for every file inside Documentation/netlink/specs.
Such template files are simple enough. All they need is:

	# Template for Documentation/netlink/specs/<foo>.yaml
	.. kernel-include:: $BUILDDIR/networking/netlink_spec/<foo>.rst

A better long term solution is to have an extension at
Documentation/sphinx that parses *.yaml files for netlink files,
which could internally be calling ynl_gen_rst.py. Yet, some care
needs to be taken, as yaml extensions are also used inside device
tree.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile                        |  8 ++++----
 .../networking/netlink_spec/conntrack.rst     |  3 +++
 .../networking/netlink_spec/devlink.rst       |  3 +++
 .../networking/netlink_spec/dpll.rst          |  3 +++
 .../networking/netlink_spec/ethtool.rst       |  3 +++
 Documentation/networking/netlink_spec/fou.rst |  3 +++
 .../networking/netlink_spec/handshake.rst     |  3 +++
 .../networking/netlink_spec/index.rst         |  6 ++++++
 .../networking/netlink_spec/lockd.rst         |  3 +++
 .../networking/netlink_spec/mptcp_pm.rst      |  3 +++
 .../networking/netlink_spec/net_shaper.rst    |  3 +++
 .../networking/netlink_spec/netdev.rst        |  3 +++
 .../networking/netlink_spec/nfsd.rst          |  3 +++
 .../networking/netlink_spec/nftables.rst      |  3 +++
 .../networking/netlink_spec/nl80211.rst       |  3 +++
 .../networking/netlink_spec/nlctrl.rst        |  3 +++
 .../networking/netlink_spec/ovpn.rst          |  3 +++
 .../networking/netlink_spec/ovs_datapath.rst  |  3 +++
 .../networking/netlink_spec/ovs_flow.rst      |  3 +++
 .../networking/netlink_spec/ovs_vport.rst     |  3 +++
 .../networking/netlink_spec/readme.txt        |  4 ----
 .../networking/netlink_spec/rt-addr.rst       |  3 +++
 .../networking/netlink_spec/rt-link.rst       |  3 +++
 .../networking/netlink_spec/rt-neigh.rst      |  3 +++
 .../networking/netlink_spec/rt-route.rst      |  3 +++
 .../networking/netlink_spec/rt-rule.rst       |  3 +++
 Documentation/networking/netlink_spec/tc.rst  |  3 +++
 .../networking/netlink_spec/tcp_metrics.rst   |  3 +++
 .../networking/netlink_spec/team.rst          |  3 +++
 tools/net/ynl/pyynl/ynl_gen_rst.py            | 19 +++++++++++++------
 30 files changed, 101 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/networking/netlink_spec/conntrack.rst
 create mode 100644 Documentation/networking/netlink_spec/devlink.rst
 create mode 100644 Documentation/networking/netlink_spec/dpll.rst
 create mode 100644 Documentation/networking/netlink_spec/ethtool.rst
 create mode 100644 Documentation/networking/netlink_spec/fou.rst
 create mode 100644 Documentation/networking/netlink_spec/handshake.rst
 create mode 100644 Documentation/networking/netlink_spec/index.rst
 create mode 100644 Documentation/networking/netlink_spec/lockd.rst
 create mode 100644 Documentation/networking/netlink_spec/mptcp_pm.rst
 create mode 100644 Documentation/networking/netlink_spec/net_shaper.rst
 create mode 100644 Documentation/networking/netlink_spec/netdev.rst
 create mode 100644 Documentation/networking/netlink_spec/nfsd.rst
 create mode 100644 Documentation/networking/netlink_spec/nftables.rst
 create mode 100644 Documentation/networking/netlink_spec/nl80211.rst
 create mode 100644 Documentation/networking/netlink_spec/nlctrl.rst
 create mode 100644 Documentation/networking/netlink_spec/ovpn.rst
 create mode 100644 Documentation/networking/netlink_spec/ovs_datapath.rst
 create mode 100644 Documentation/networking/netlink_spec/ovs_flow.rst
 create mode 100644 Documentation/networking/netlink_spec/ovs_vport.rst
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100644 Documentation/networking/netlink_spec/rt-addr.rst
 create mode 100644 Documentation/networking/netlink_spec/rt-link.rst
 create mode 100644 Documentation/networking/netlink_spec/rt-neigh.rst
 create mode 100644 Documentation/networking/netlink_spec/rt-route.rst
 create mode 100644 Documentation/networking/netlink_spec/rt-rule.rst
 create mode 100644 Documentation/networking/netlink_spec/tc.rst
 create mode 100644 Documentation/networking/netlink_spec/tcp_metrics.rst
 create mode 100644 Documentation/networking/netlink_spec/team.rst

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d30d66ddf1ad..2383825dba49 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -102,8 +102,8 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
 	fi
 
-YNL_INDEX:=$(srctree)/Documentation/networking/netlink_spec/index.rst
-YNL_RST_DIR:=$(srctree)/Documentation/networking/netlink_spec
+YNL_INDEX:=$(BUILDDIR)/networking/netlink_spec/netlink_index.rst
+YNL_RST_DIR:=$(BUILDDIR)/networking/netlink_spec/
 YNL_YAML_DIR:=$(srctree)/Documentation/netlink/specs
 YNL_TOOL:=$(srctree)/tools/net/ynl/pyynl/ynl_gen_rst.py
 
@@ -111,12 +111,12 @@ YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
 YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))
 
 $(YNL_INDEX): $(YNL_RST_FILES)
-	$(Q)$(YNL_TOOL) -o $@ -x
+	$(Q)$(YNL_TOOL) -o $@ -d $(YNL_YAML_DIR) -x
 
 $(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
 	$(Q)$(YNL_TOOL) -i $< -o $@
 
-htmldocs texinfodocs latexdocs epubdocs xmldocs: $(YNL_INDEX)
+htmldocs texinfodocs latexdocs epubdocs xmldocs: $(YNL_INDEX) $(YNL_RST_FILES)
 
 htmldocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
diff --git a/Documentation/networking/netlink_spec/conntrack.rst b/Documentation/networking/netlink_spec/conntrack.rst
new file mode 100644
index 000000000000..6fc6af1e6de4
--- /dev/null
+++ b/Documentation/networking/netlink_spec/conntrack.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/conntrack.rst
diff --git a/Documentation/networking/netlink_spec/devlink.rst b/Documentation/networking/netlink_spec/devlink.rst
new file mode 100644
index 000000000000..412295d396c1
--- /dev/null
+++ b/Documentation/networking/netlink_spec/devlink.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/devlink.rst
diff --git a/Documentation/networking/netlink_spec/dpll.rst b/Documentation/networking/netlink_spec/dpll.rst
new file mode 100644
index 000000000000..913e1d9ef744
--- /dev/null
+++ b/Documentation/networking/netlink_spec/dpll.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/dpll.rst
diff --git a/Documentation/networking/netlink_spec/ethtool.rst b/Documentation/networking/netlink_spec/ethtool.rst
new file mode 100644
index 000000000000..42136a8572b9
--- /dev/null
+++ b/Documentation/networking/netlink_spec/ethtool.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/ethtool.rst
diff --git a/Documentation/networking/netlink_spec/fou.rst b/Documentation/networking/netlink_spec/fou.rst
new file mode 100644
index 000000000000..103528337d46
--- /dev/null
+++ b/Documentation/networking/netlink_spec/fou.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/fou.rst
diff --git a/Documentation/networking/netlink_spec/handshake.rst b/Documentation/networking/netlink_spec/handshake.rst
new file mode 100644
index 000000000000..600abec80431
--- /dev/null
+++ b/Documentation/networking/netlink_spec/handshake.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/handshake.rst
diff --git a/Documentation/networking/netlink_spec/index.rst b/Documentation/networking/netlink_spec/index.rst
new file mode 100644
index 000000000000..8a07a77f2e8b
--- /dev/null
+++ b/Documentation/networking/netlink_spec/index.rst
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Netlink documentation is populated during the build of the documentation
+# (htmldocs) by the tools/net/ynl/pyynl/ynl_gen_rst.py script.
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/netlink_index.rst
diff --git a/Documentation/networking/netlink_spec/lockd.rst b/Documentation/networking/netlink_spec/lockd.rst
new file mode 100644
index 000000000000..6374dc2a982c
--- /dev/null
+++ b/Documentation/networking/netlink_spec/lockd.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/lockd.rst
diff --git a/Documentation/networking/netlink_spec/mptcp_pm.rst b/Documentation/networking/netlink_spec/mptcp_pm.rst
new file mode 100644
index 000000000000..8923db35603e
--- /dev/null
+++ b/Documentation/networking/netlink_spec/mptcp_pm.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/mptcp_pm.rst
diff --git a/Documentation/networking/netlink_spec/net_shaper.rst b/Documentation/networking/netlink_spec/net_shaper.rst
new file mode 100644
index 000000000000..82d9300f1c0c
--- /dev/null
+++ b/Documentation/networking/netlink_spec/net_shaper.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/net_shaper.rst
diff --git a/Documentation/networking/netlink_spec/netdev.rst b/Documentation/networking/netlink_spec/netdev.rst
new file mode 100644
index 000000000000..c379a79c5f23
--- /dev/null
+++ b/Documentation/networking/netlink_spec/netdev.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/netdev.rst
diff --git a/Documentation/networking/netlink_spec/nfsd.rst b/Documentation/networking/netlink_spec/nfsd.rst
new file mode 100644
index 000000000000..40716f4a3fa8
--- /dev/null
+++ b/Documentation/networking/netlink_spec/nfsd.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/nfsd.rst
diff --git a/Documentation/networking/netlink_spec/nftables.rst b/Documentation/networking/netlink_spec/nftables.rst
new file mode 100644
index 000000000000..1dc6d7c5ca58
--- /dev/null
+++ b/Documentation/networking/netlink_spec/nftables.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/nftables.rst
diff --git a/Documentation/networking/netlink_spec/nl80211.rst b/Documentation/networking/netlink_spec/nl80211.rst
new file mode 100644
index 000000000000..c056418f7068
--- /dev/null
+++ b/Documentation/networking/netlink_spec/nl80211.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/nl80211.rst
diff --git a/Documentation/networking/netlink_spec/nlctrl.rst b/Documentation/networking/netlink_spec/nlctrl.rst
new file mode 100644
index 000000000000..7fe48f26718e
--- /dev/null
+++ b/Documentation/networking/netlink_spec/nlctrl.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/nlctrl.rst
diff --git a/Documentation/networking/netlink_spec/ovpn.rst b/Documentation/networking/netlink_spec/ovpn.rst
new file mode 100644
index 000000000000..c146b803d742
--- /dev/null
+++ b/Documentation/networking/netlink_spec/ovpn.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/ovpn.rst
diff --git a/Documentation/networking/netlink_spec/ovs_datapath.rst b/Documentation/networking/netlink_spec/ovs_datapath.rst
new file mode 100644
index 000000000000..0b1242f2cc9c
--- /dev/null
+++ b/Documentation/networking/netlink_spec/ovs_datapath.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/ovs_datapath.rst
diff --git a/Documentation/networking/netlink_spec/ovs_flow.rst b/Documentation/networking/netlink_spec/ovs_flow.rst
new file mode 100644
index 000000000000..c1019ab06aff
--- /dev/null
+++ b/Documentation/networking/netlink_spec/ovs_flow.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/ovs_flow.rst
diff --git a/Documentation/networking/netlink_spec/ovs_vport.rst b/Documentation/networking/netlink_spec/ovs_vport.rst
new file mode 100644
index 000000000000..13eb53ff4c75
--- /dev/null
+++ b/Documentation/networking/netlink_spec/ovs_vport.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/ovs_vport.rst
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
diff --git a/Documentation/networking/netlink_spec/rt-addr.rst b/Documentation/networking/netlink_spec/rt-addr.rst
new file mode 100644
index 000000000000..2739e81b7a04
--- /dev/null
+++ b/Documentation/networking/netlink_spec/rt-addr.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/rt-addr.rst
diff --git a/Documentation/networking/netlink_spec/rt-link.rst b/Documentation/networking/netlink_spec/rt-link.rst
new file mode 100644
index 000000000000..d4df7268d07c
--- /dev/null
+++ b/Documentation/networking/netlink_spec/rt-link.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/rt-link.rst
diff --git a/Documentation/networking/netlink_spec/rt-neigh.rst b/Documentation/networking/netlink_spec/rt-neigh.rst
new file mode 100644
index 000000000000..6c8b62d7b2ff
--- /dev/null
+++ b/Documentation/networking/netlink_spec/rt-neigh.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/rt-neigh.rst
diff --git a/Documentation/networking/netlink_spec/rt-route.rst b/Documentation/networking/netlink_spec/rt-route.rst
new file mode 100644
index 000000000000..a629d14bf405
--- /dev/null
+++ b/Documentation/networking/netlink_spec/rt-route.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/rt-route.rst
diff --git a/Documentation/networking/netlink_spec/rt-rule.rst b/Documentation/networking/netlink_spec/rt-rule.rst
new file mode 100644
index 000000000000..e4a991b1bacd
--- /dev/null
+++ b/Documentation/networking/netlink_spec/rt-rule.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/rt-rule.rst
diff --git a/Documentation/networking/netlink_spec/tc.rst b/Documentation/networking/netlink_spec/tc.rst
new file mode 100644
index 000000000000..1e78d3caeb5d
--- /dev/null
+++ b/Documentation/networking/netlink_spec/tc.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/tc.rst
diff --git a/Documentation/networking/netlink_spec/tcp_metrics.rst b/Documentation/networking/netlink_spec/tcp_metrics.rst
new file mode 100644
index 000000000000..ea43bd6f6925
--- /dev/null
+++ b/Documentation/networking/netlink_spec/tcp_metrics.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/tcp_metrics.rst
diff --git a/Documentation/networking/netlink_spec/team.rst b/Documentation/networking/netlink_spec/team.rst
new file mode 100644
index 000000000000..45a3f4d3ed80
--- /dev/null
+++ b/Documentation/networking/netlink_spec/team.rst
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.. kernel-include:: $BUILDDIR/networking/netlink_spec/team.rst
diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
index 7bfb8ceeeefc..70417a9a8e96 100755
--- a/tools/net/ynl/pyynl/ynl_gen_rst.py
+++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
@@ -365,6 +365,7 @@ def parse_arguments() -> argparse.Namespace:
 
     parser.add_argument("-v", "--verbose", action="store_true")
     parser.add_argument("-o", "--output", help="Output file name")
+    parser.add_argument("-d", "--input_dir", help="YAML input directory")
 
     # Index and input are mutually exclusive
     group = parser.add_mutually_exclusive_group()
@@ -405,11 +406,14 @@ def write_to_rstfile(content: str, filename: str) -> None:
     """Write the generated content into an RST file"""
     logging.debug("Saving RST file to %s", filename)
 
+    dir = os.path.dirname(filename)
+    os.makedirs(dir, exist_ok=True)
+
     with open(filename, "w", encoding="utf-8") as rst_file:
         rst_file.write(content)
 
 
-def generate_main_index_rst(output: str) -> None:
+def generate_main_index_rst(output: str, index_dir: str, ) -> None:
     """Generate the `networking_spec/index` content and write to the file"""
     lines = []
 
@@ -418,12 +422,15 @@ def generate_main_index_rst(output: str) -> None:
     lines.append(rst_title("Netlink Family Specifications"))
     lines.append(rst_toctree(1))
 
-    index_dir = os.path.dirname(output)
-    logging.debug("Looking for .rst files in %s", index_dir)
+    index_fname = os.path.basename(output)
+    if not index_dir:
+        index_dir = os.path.dirname(output)
+
+    logging.debug("Looking for .yaml files in %s", index_dir)
     for filename in sorted(os.listdir(index_dir)):
-        if not filename.endswith(".rst") or filename == "index.rst":
+        if not filename.endswith(".yaml") or filename == index_fname:
             continue
-        lines.append(f"   {filename.replace('.rst', '')}\n")
+        lines.append(f"   {filename.replace('.yaml', '')}\n")
 
     logging.debug("Writing an index file at %s", output)
     write_to_rstfile("".join(lines), output)
@@ -447,7 +454,7 @@ def main() -> None:
 
     if args.index:
         # Generate the index RST file
-        generate_main_index_rst(args.output)
+        generate_main_index_rst(args.output, args.input_dir)
 
 
 if __name__ == "__main__":
-- 
2.49.0


