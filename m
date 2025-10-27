Return-Path: <netdev+bounces-233177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BF8C0D8A6
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 13:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE73C1897E7C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C0B30FF20;
	Mon, 27 Oct 2025 12:28:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A589830DED5
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568122; cv=none; b=dhDdmB2NbJxJi6VZsbLgb6f/Imnv7BtXsWE/rSyRX47crAI0m/UFgQmOyU3kF9Dz6tJYdaU7ofpHB4DkPuxyViFqs7fzrUEChCt9AwZAI8QlG/sQI+bdW8Iro3PJTPoziXsFDW3B/KyuDm2ggvzBFWobL/DQXUN+22oNBiwT9FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568122; c=relaxed/simple;
	bh=Fe3/T52d5USGpyqwkh8Z/IXOQVZpktpwJyaJH3RrK5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5GeaMIJIsT6s6nGJnNGYP9j1e/nIXj3PI4q+K+YUDoUoZBhpRLBWWYXDdcStfQIzsDDgltv47bADldi9wznOdLPvqOd8eFnZ1xcupuHOCQlw9BvrNANYRThqCOvilOcPP/S0fJTTWruEGuHMMKfyiWjQt/7WIylPh7i1voW4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMKX-0004fp-TA; Mon, 27 Oct 2025 13:28:09 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMKV-005hdw-1U;
	Mon, 27 Oct 2025 13:28:07 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMKV-000000047a1-1WYq;
	Mon, 27 Oct 2025 13:28:07 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nishanth Menon <nm@ti.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>,
	Roan van Dijk <roan@protonic.nl>
Subject: [PATCH net-next v8 2/4] ethtool: netlink: add ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Date: Mon, 27 Oct 2025 13:27:59 +0100
Message-ID: <20251027122801.982364-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027122801.982364-1-o.rempel@pengutronix.de>
References: <20251027122801.982364-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Introduce the userspace entry point for PHY MSE diagnostics via
ethtool netlink. This exposes the core API added previously and
returns both capability information and one or more snapshots.

Userspace sends ETHTOOL_MSG_MSE_GET. The reply carries:
- ETHTOOL_A_MSE_CAPABILITIES: scale limits and timing information
- ETHTOOL_A_MSE_CHANNEL_* nests: one or more snapshots (per-channel
  if available, otherwise WORST, otherwise LINK)

Link down returns -ENETDOWN.

Changes:
  - YAML: add attribute sets (mse, mse-capabilities, mse-snapshot)
    and the mse-get operation
  - UAPI (generated): add ETHTOOL_A_MSE_* enums and message IDs,
    ETHTOOL_MSG_MSE_GET/REPLY
  - ethtool core: add net/ethtool/mse.c implementing the request,
    register genl op, and hook into ethnl dispatch
  - docs: document MSE_GET in ethtool-netlink.rst

The include/uapi/linux/ethtool_netlink_generated.h is generated
from Documentation/netlink/specs/ethtool.yaml.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v8:
- drop user-space channel selector; kernel always returns available selectors
- drop supported-caps bitset from UAPI; keep only scale/timing fields
- keep capability flags internal to PHY API
- switch docs accordingly; clarify conditional presence of fields
changes v7:
- fix "Malformed table" error
changes v6:
- YAML: rename mse-config -> mse-capabilities;
        rename top-level attr "config" -> "capabilities".
- YAML: drop all explicit UNSPEC entries; start enums at 1 with _CNT/_MAX tails.
- YAML: switch scalar fields to type: uint; remove pad attrs.
- YAML: per-channel reply layout:
        replace multi-attr "snapshot" with fixed nests
        ETHTOOL_A_MSE_CHANNEL_A/B/C/D/WORST_CHANNEL/LINK;
	drop inner "channel" field.
- UAPI: regenerate include/uapi/linux/ethtool_netlink_generated.h
- mse.c: implement capabilities container and per-channel snapshot nests;
        use nla_put_uint() for all YAML uint fields; size using sizeof(u64) in
	reply_size(); no pad usage.
- mse.c: encode supported-caps with ethnl_bitset32_size()/ethnl_put_bitset32();
- mse.c: return -ENETDOWN on link down (commit message updated accordingly).
- docs: ethtool-netlink.rst updated to new attribute names/layout and
        terminology (capabilities, per-channel nests).
changes v5:
- add struct phy_mse_snapshot and phy_mse_config in the documentation
changes v4:
- s/__ethtool-a-mse/--ethtool-a-mse
- remove duplicate kernel-doc line
- fix htmldocs compile warnings
---
 Documentation/netlink/specs/ethtool.yaml      |  86 +++++
 Documentation/networking/ethtool-netlink.rst  |  64 ++++
 .../uapi/linux/ethtool_netlink_generated.h    |  35 ++
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/mse.c                             | 329 ++++++++++++++++++
 net/ethtool/netlink.c                         |  10 +
 net/ethtool/netlink.h                         |   2 +
 7 files changed, 527 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/mse.c

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 6a0fb1974513..05d2b6508b59 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1823,6 +1823,73 @@ attribute-sets:
         type: uint
         enum: pse-event
         doc: List of events reported by the PSE controller
+  -
+    name: mse-capabilities
+    doc: MSE capabilities attribute set
+    attr-cnt-name: --ethtool-a-mse-capabilities-cnt
+    attributes:
+      -
+        name: max-average-mse
+        type: uint
+      -
+        name: max-peak-mse
+        type: uint
+      -
+        name: refresh-rate-ps
+        type: uint
+      -
+        name: num-symbols
+        type: uint
+  -
+    name: mse-snapshot
+    doc: MSE snapshot attribute set
+    attr-cnt-name: --ethtool-a-mse-snapshot-cnt
+    attributes:
+      -
+        name: average-mse
+        type: uint
+      -
+        name: peak-mse
+        type: uint
+      -
+        name: worst-peak-mse
+        type: uint
+  -
+    name: mse
+    attr-cnt-name: --ethtool-a-mse-cnt
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: capabilities
+        type: nest
+        nested-attributes: mse-capabilities
+      -
+        name: channel-a
+        type: nest
+        nested-attributes: mse-snapshot
+      -
+        name: channel-b
+        type: nest
+        nested-attributes: mse-snapshot
+      -
+        name: channel-c
+        type: nest
+        nested-attributes: mse-snapshot
+      -
+        name: channel-d
+        type: nest
+        nested-attributes: mse-snapshot
+      -
+        name: worst-channel
+        type: nest
+        nested-attributes: mse-snapshot
+      -
+        name: link
+        type: nest
+        nested-attributes: mse-snapshot

 operations:
   enum-model: directional
@@ -2756,6 +2823,25 @@ operations:
         attributes:
           - header
           - context
+    -
+      name: mse-get
+      doc: Get PHY MSE measurement data and capabilities.
+      attribute-set: mse
+      do: &mse-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes:
+            - header
+            - capabilities
+            - channel-a
+            - channel-b
+            - channel-c
+            - channel-d
+            - worst-channel
+            - link
+      dump: *mse-get-op

 mcast-groups:
   list:
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index b270886c5f5d..af56c304cef4 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -242,6 +242,7 @@ Userspace to kernel:
   ``ETHTOOL_MSG_RSS_SET``               set RSS settings
   ``ETHTOOL_MSG_RSS_CREATE_ACT``        create an additional RSS context
   ``ETHTOOL_MSG_RSS_DELETE_ACT``        delete an additional RSS context
+  ``ETHTOOL_MSG_MSE_GET``               get MSE diagnostic data
   ===================================== =================================

 Kernel to userspace:
@@ -299,6 +300,7 @@ Kernel to userspace:
   ``ETHTOOL_MSG_RSS_CREATE_ACT_REPLY``     create an additional RSS context
   ``ETHTOOL_MSG_RSS_CREATE_NTF``           additional RSS context created
   ``ETHTOOL_MSG_RSS_DELETE_NTF``           additional RSS context deleted
+  ``ETHTOOL_MSG_MSE_GET_REPLY``            MSE diagnostic data
   ======================================== =================================

 ``GET`` requests are sent by userspace applications to retrieve device
@@ -2458,6 +2460,68 @@ Kernel response contents:

 For a description of each attribute, see ``TSCONFIG_GET``.

+MSE_GET
+=======
+
+Retrieves detailed Mean Square Error (MSE) diagnostic information from the PHY.
+
+Request Contents:
+
+  ====================================  ======  ============================
+  ``ETHTOOL_A_MSE_HEADER``              nested  request header
+  ====================================  ======  ============================
+
+Kernel Response Contents:
+
+  ====================================  ======  ================================
+  ``ETHTOOL_A_MSE_HEADER``              nested  reply header
+  ``ETHTOOL_A_MSE_CAPABILITIES``        nested  capability/scale info for MSE
+                                                measurements
+  ``ETHTOOL_A_MSE_CHANNEL_A``           nested  snapshot for Channel A
+  ``ETHTOOL_A_MSE_CHANNEL_B``           nested  snapshot for Channel B
+  ``ETHTOOL_A_MSE_CHANNEL_C``           nested  snapshot for Channel C
+  ``ETHTOOL_A_MSE_CHANNEL_D``           nested  snapshot for Channel D
+  ``ETHTOOL_A_MSE_WORST_CHANNEL``       nested  snapshot for worst channel
+  ``ETHTOOL_A_MSE_LINK``                nested  snapshot for link-wide aggregate
+  ====================================  ======  ================================
+
+MSE Capabilities
+----------------
+
+This nested attribute reports the capability / scaling properties used to
+interpret snapshot values.
+
+  ============================================== ======  =========================
+  ``ETHTOOL_A_MSE_CAPABILITIES_MAX_AVERAGE_MSE`` uint    max avg_mse scale
+  ``ETHTOOL_A_MSE_CAPABILITIES_MAX_PEAK_MSE``    uint    max peak_mse scale
+  ``ETHTOOL_A_MSE_CAPABILITIES_REFRESH_RATE_PS`` uint    sample rate (picoseconds)
+  ``ETHTOOL_A_MSE_CAPABILITIES_NUM_SYMBOLS``     uint    symbols per HW sample
+  ============================================== ======  =========================
+
+The max-average/peak fields are included only if the corresponding metric
+is supported by the PHY. Their absence indicates that the metric is not
+available.
+
+See ``struct phy_mse_capability`` kernel documentation in
+``include/linux/phy.h``.
+
+MSE Snapshot
+------------
+
+Each per-channel nest contains an atomic snapshot of MSE values for that
+selector (channel A/B/C/D, worst channel, or link).
+
+  ==========================================  ======  ===================
+  ``ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE``      uint    average MSE value
+  ``ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE``         uint    current peak MSE
+  ``ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE``   uint    worst-case peak MSE
+  ==========================================  ======  ===================
+
+Within each channel nest, only the metrics supported by the PHY will be present.
+
+See ``struct phy_mse_snapshot`` kernel documentation in
+``include/linux/phy.h``.
+
 Request translation
 ===================

diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 0e8ac0d974e2..b71b175df46d 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -803,6 +803,39 @@ enum {
 	ETHTOOL_A_PSE_NTF_MAX = (__ETHTOOL_A_PSE_NTF_CNT - 1)
 };

+enum {
+	ETHTOOL_A_MSE_CAPABILITIES_MAX_AVERAGE_MSE = 1,
+	ETHTOOL_A_MSE_CAPABILITIES_MAX_PEAK_MSE,
+	ETHTOOL_A_MSE_CAPABILITIES_REFRESH_RATE_PS,
+	ETHTOOL_A_MSE_CAPABILITIES_NUM_SYMBOLS,
+
+	__ETHTOOL_A_MSE_CAPABILITIES_CNT,
+	ETHTOOL_A_MSE_CAPABILITIES_MAX = (__ETHTOOL_A_MSE_CAPABILITIES_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE = 1,
+	ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE,
+	ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE,
+
+	__ETHTOOL_A_MSE_SNAPSHOT_CNT,
+	ETHTOOL_A_MSE_SNAPSHOT_MAX = (__ETHTOOL_A_MSE_SNAPSHOT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MSE_HEADER = 1,
+	ETHTOOL_A_MSE_CAPABILITIES,
+	ETHTOOL_A_MSE_CHANNEL_A,
+	ETHTOOL_A_MSE_CHANNEL_B,
+	ETHTOOL_A_MSE_CHANNEL_C,
+	ETHTOOL_A_MSE_CHANNEL_D,
+	ETHTOOL_A_MSE_WORST_CHANNEL,
+	ETHTOOL_A_MSE_LINK,
+
+	__ETHTOOL_A_MSE_CNT,
+	ETHTOOL_A_MSE_MAX = (__ETHTOOL_A_MSE_CNT - 1)
+};
+
 enum {
 	ETHTOOL_MSG_USER_NONE = 0,
 	ETHTOOL_MSG_STRSET_GET = 1,
@@ -855,6 +888,7 @@ enum {
 	ETHTOOL_MSG_RSS_SET,
 	ETHTOOL_MSG_RSS_CREATE_ACT,
 	ETHTOOL_MSG_RSS_DELETE_ACT,
+	ETHTOOL_MSG_MSE_GET,

 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -915,6 +949,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_ACT_REPLY,
 	ETHTOOL_MSG_RSS_CREATE_NTF,
 	ETHTOOL_MSG_RSS_DELETE_NTF,
+	ETHTOOL_MSG_MSE_GET_REPLY,

 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 1e493553b977..629c10916670 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -9,4 +9,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
 		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o \
-		   phy.o tsconfig.o
+		   phy.o tsconfig.o mse.o
diff --git a/net/ethtool/mse.c b/net/ethtool/mse.c
new file mode 100644
index 000000000000..dcc4c93c5d04
--- /dev/null
+++ b/net/ethtool/mse.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/ethtool.h>
+#include <linux/phy.h>
+#include <linux/slab.h>
+
+#include "netlink.h"
+#include "common.h"
+
+/* Channels A-D only; WORST and LINK are exclusive alternatives */
+#define PHY_MSE_CHANNEL_COUNT 4
+
+struct mse_req_info {
+	struct ethnl_req_info base;
+};
+
+struct mse_snapshot_entry {
+	struct phy_mse_snapshot snapshot;
+	int channel;
+};
+
+struct mse_reply_data {
+	struct ethnl_reply_data base;
+	struct phy_mse_capability capability;
+	struct mse_snapshot_entry *snapshots;
+	unsigned int num_snapshots;
+};
+
+static struct mse_reply_data *
+mse_repdata(const struct ethnl_reply_data *reply_base)
+{
+	return container_of(reply_base, struct mse_reply_data, base);
+}
+
+const struct nla_policy ethnl_mse_get_policy[] = {
+	[ETHTOOL_A_MSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy_phy),
+};
+
+static int get_snapshot_if_supported(struct phy_device *phydev,
+				     struct mse_reply_data *data,
+				     unsigned int *idx, u32 cap_bit,
+				     enum phy_mse_channel channel)
+{
+	int ret;
+
+	if (data->capability.supported_caps & cap_bit) {
+		ret = phydev->drv->get_mse_snapshot(phydev, channel,
+					&data->snapshots[*idx].snapshot);
+		if (ret)
+			return ret;
+		data->snapshots[*idx].channel = channel;
+		(*idx)++;
+	}
+
+	return 0;
+}
+
+static int mse_get_channels(struct phy_device *phydev,
+			    struct mse_reply_data *data)
+{
+	unsigned int i = 0;
+	int ret;
+
+	if (!data->capability.supported_caps)
+		return 0;
+
+	data->snapshots = kcalloc(PHY_MSE_CHANNEL_COUNT,
+				  sizeof(*data->snapshots), GFP_KERNEL);
+	if (!data->snapshots)
+		return -ENOMEM;
+
+	/* Priority 1: Individual channels */
+	ret = get_snapshot_if_supported(phydev, data, &i, PHY_MSE_CAP_CHANNEL_A,
+					PHY_MSE_CHANNEL_A);
+	if (ret)
+		return ret;
+	ret = get_snapshot_if_supported(phydev, data, &i, PHY_MSE_CAP_CHANNEL_B,
+					PHY_MSE_CHANNEL_B);
+	if (ret)
+		return ret;
+	ret = get_snapshot_if_supported(phydev, data, &i, PHY_MSE_CAP_CHANNEL_C,
+					PHY_MSE_CHANNEL_C);
+	if (ret)
+		return ret;
+	ret = get_snapshot_if_supported(phydev, data, &i, PHY_MSE_CAP_CHANNEL_D,
+					PHY_MSE_CHANNEL_D);
+	if (ret)
+		return ret;
+
+	/* If any individual channels were found, we are done. */
+	if (i > 0) {
+		data->num_snapshots = i;
+		return 0;
+	}
+
+	/* Priority 2: Worst channel, if no individual channels supported. */
+	ret = get_snapshot_if_supported(phydev, data, &i,
+					PHY_MSE_CAP_WORST_CHANNEL,
+					PHY_MSE_CHANNEL_WORST);
+	if (ret)
+		return ret;
+
+	/* If worst channel was found, we are done. */
+	if (i > 0) {
+		data->num_snapshots = i;
+		return 0;
+	}
+
+	/* Priority 3: Link-wide, if nothing else is supported. */
+	ret = get_snapshot_if_supported(phydev, data, &i, PHY_MSE_CAP_LINK,
+					PHY_MSE_CHANNEL_LINK);
+	if (ret)
+		return ret;
+
+	data->num_snapshots = i;
+	return 0;
+}
+
+static int mse_prepare_data(const struct ethnl_req_info *req_base,
+			    struct ethnl_reply_data *reply_base,
+			    const struct genl_info *info)
+{
+	struct mse_reply_data *data = mse_repdata(reply_base);
+	struct net_device *dev = reply_base->dev;
+	struct phy_device *phydev;
+	int ret;
+
+	phydev = ethnl_req_get_phydev(req_base, info->attrs,
+				      ETHTOOL_A_MSE_HEADER, info->extack);
+	if (IS_ERR(phydev))
+		return PTR_ERR(phydev);
+	if (!phydev)
+		return -EOPNOTSUPP;
+
+	ret = ethnl_ops_begin(dev);
+	if (ret)
+		return ret;
+
+	mutex_lock(&phydev->lock);
+
+	if (!phydev->drv || !phydev->drv->get_mse_capability ||
+	    !phydev->drv->get_mse_snapshot) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+	if (!phydev->link) {
+		ret = -ENETDOWN;
+		goto out_unlock;
+	}
+
+	ret = phydev->drv->get_mse_capability(phydev, &data->capability);
+	if (ret)
+		goto out_unlock;
+
+	ret = mse_get_channels(phydev, data);
+
+out_unlock:
+	mutex_unlock(&phydev->lock);
+	ethnl_ops_complete(dev);
+	if (ret)
+		kfree(data->snapshots);
+	return ret;
+}
+
+static void mse_cleanup_data(struct ethnl_reply_data *reply_base)
+{
+	struct mse_reply_data *data = mse_repdata(reply_base);
+
+	kfree(data->snapshots);
+}
+
+static int mse_reply_size(const struct ethnl_req_info *req_base,
+			  const struct ethnl_reply_data *reply_base)
+{
+	const struct mse_reply_data *data = mse_repdata(reply_base);
+	size_t len = 0;
+	unsigned int i;
+
+	/* ETHTOOL_A_MSE_CAPABILITIES */
+	len += nla_total_size(0);
+	if (data->capability.supported_caps & PHY_MSE_CAP_AVG)
+		/* ETHTOOL_A_MSE_CAPABILITIES_MAX_AVERAGE_MSE */
+		len += nla_total_size(sizeof(u64));
+	if (data->capability.supported_caps & (PHY_MSE_CAP_PEAK |
+					       PHY_MSE_CAP_WORST_PEAK))
+		/* ETHTOOL_A_MSE_CAPABILITIES_MAX_PEAK_MSE */
+		len += nla_total_size(sizeof(u64));
+	/* ETHTOOL_A_MSE_CAPABILITIES_REFRESH_RATE_PS */
+	len += nla_total_size(sizeof(u64));
+	/* ETHTOOL_A_MSE_CAPABILITIES_NUM_SYMBOLS */
+	len += nla_total_size(sizeof(u64));
+
+	for (i = 0; i < data->num_snapshots; i++) {
+		size_t snapshot_len = 0;
+
+		/* Per-channel nest (e.g., ETHTOOL_A_MSE_CHANNEL_A / _B / _C /
+		 * _D / _WORST_CHANNEL / _LINK)
+		 */
+		snapshot_len += nla_total_size(0);
+
+		if (data->capability.supported_caps & PHY_MSE_CAP_AVG)
+			snapshot_len += nla_total_size(sizeof(u64));
+		if (data->capability.supported_caps & PHY_MSE_CAP_PEAK)
+			snapshot_len += nla_total_size(sizeof(u64));
+		if (data->capability.supported_caps & PHY_MSE_CAP_WORST_PEAK)
+			snapshot_len += nla_total_size(sizeof(u64));
+
+		len += snapshot_len;
+	}
+
+	return len;
+}
+
+static int mse_channel_to_attr(int ch)
+{
+	switch (ch) {
+	case PHY_MSE_CHANNEL_A:
+		return ETHTOOL_A_MSE_CHANNEL_A;
+	case PHY_MSE_CHANNEL_B:
+		return ETHTOOL_A_MSE_CHANNEL_B;
+	case PHY_MSE_CHANNEL_C:
+		return ETHTOOL_A_MSE_CHANNEL_C;
+	case PHY_MSE_CHANNEL_D:
+		return ETHTOOL_A_MSE_CHANNEL_D;
+	case PHY_MSE_CHANNEL_WORST:
+		return ETHTOOL_A_MSE_WORST_CHANNEL;
+	case PHY_MSE_CHANNEL_LINK:
+		return ETHTOOL_A_MSE_LINK;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mse_fill_reply(struct sk_buff *skb,
+			  const struct ethnl_req_info *req_base,
+			  const struct ethnl_reply_data *reply_base)
+{
+	const struct mse_reply_data *data = mse_repdata(reply_base);
+	struct nlattr *nest;
+	unsigned int i;
+	int ret;
+
+	nest = nla_nest_start(skb, ETHTOOL_A_MSE_CAPABILITIES);
+	if (!nest)
+		return -EMSGSIZE;
+
+	if (data->capability.supported_caps & PHY_MSE_CAP_AVG) {
+		ret = nla_put_uint(skb,
+				   ETHTOOL_A_MSE_CAPABILITIES_MAX_AVERAGE_MSE,
+				   data->capability.max_average_mse);
+		if (ret < 0)
+			goto nla_put_nest_failure;
+	}
+
+	if (data->capability.supported_caps & (PHY_MSE_CAP_PEAK |
+					       PHY_MSE_CAP_WORST_PEAK)) {
+		ret = nla_put_uint(skb, ETHTOOL_A_MSE_CAPABILITIES_MAX_PEAK_MSE,
+				   data->capability.max_peak_mse);
+		if (ret < 0)
+			goto nla_put_nest_failure;
+	}
+
+	ret = nla_put_uint(skb, ETHTOOL_A_MSE_CAPABILITIES_REFRESH_RATE_PS,
+			   data->capability.refresh_rate_ps);
+	if (ret < 0)
+		goto nla_put_nest_failure;
+
+	ret = nla_put_uint(skb, ETHTOOL_A_MSE_CAPABILITIES_NUM_SYMBOLS,
+			   data->capability.num_symbols);
+	if (ret < 0)
+		goto nla_put_nest_failure;
+
+	nla_nest_end(skb, nest);
+
+	for (i = 0; i < data->num_snapshots; i++) {
+		const struct mse_snapshot_entry *s = &data->snapshots[i];
+		int chan_attr;
+
+		chan_attr = mse_channel_to_attr(s->channel);
+		if (chan_attr < 0)
+			return chan_attr;
+
+		nest = nla_nest_start(skb, chan_attr);
+		if (!nest)
+			return -EMSGSIZE;
+
+		if (data->capability.supported_caps & PHY_MSE_CAP_AVG) {
+			ret = nla_put_uint(skb,
+					   ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE,
+					   s->snapshot.average_mse);
+			if (ret)
+				goto nla_put_nest_failure;
+		}
+		if (data->capability.supported_caps & PHY_MSE_CAP_PEAK) {
+			ret = nla_put_uint(skb, ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE,
+					   s->snapshot.peak_mse);
+			if (ret)
+				goto nla_put_nest_failure;
+		}
+		if (data->capability.supported_caps & PHY_MSE_CAP_WORST_PEAK) {
+			ret = nla_put_uint(skb,
+					   ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE,
+					   s->snapshot.worst_peak_mse);
+			if (ret)
+				goto nla_put_nest_failure;
+		}
+
+		nla_nest_end(skb, nest);
+	}
+
+	return 0;
+
+nla_put_nest_failure:
+	nla_nest_cancel(skb, nest);
+	return ret;
+}
+
+const struct ethnl_request_ops ethnl_mse_request_ops = {
+	.request_cmd = ETHTOOL_MSG_MSE_GET,
+	.reply_cmd = ETHTOOL_MSG_MSE_GET_REPLY,
+	.hdr_attr = ETHTOOL_A_MSE_HEADER,
+	.req_info_size = sizeof(struct mse_req_info),
+	.reply_data_size = sizeof(struct mse_reply_data),
+
+	.prepare_data = mse_prepare_data,
+	.cleanup_data = mse_cleanup_data,
+	.reply_size = mse_reply_size,
+	.fill_reply = mse_fill_reply,
+};
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 2f813f25f07e..6e5f0f4f815a 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -420,6 +420,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_TSCONFIG_GET]	= &ethnl_tsconfig_request_ops,
 	[ETHTOOL_MSG_TSCONFIG_SET]	= &ethnl_tsconfig_request_ops,
 	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
+	[ETHTOOL_MSG_MSE_GET]		= &ethnl_mse_request_ops,
 };

 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -1534,6 +1535,15 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy	= ethnl_rss_delete_policy,
 		.maxattr = ARRAY_SIZE(ethnl_rss_delete_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_MSE_GET,
+		.doit	= ethnl_default_doit,
+		.start	= ethnl_perphy_start,
+		.dumpit	= ethnl_perphy_dumpit,
+		.done	= ethnl_perphy_done,
+		.policy = ethnl_mse_get_policy,
+		.maxattr = ARRAY_SIZE(ethnl_mse_get_policy) - 1,
+	},
 };

 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 1d4f9ecb3d26..89010eaa67df 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -442,6 +442,7 @@ extern const struct ethnl_request_ops ethnl_plca_status_request_ops;
 extern const struct ethnl_request_ops ethnl_mm_request_ops;
 extern const struct ethnl_request_ops ethnl_phy_request_ops;
 extern const struct ethnl_request_ops ethnl_tsconfig_request_ops;
+extern const struct ethnl_request_ops ethnl_mse_request_ops;

 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
@@ -497,6 +498,7 @@ extern const struct nla_policy ethnl_module_fw_flash_act_policy[ETHTOOL_A_MODULE
 extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_get_policy[ETHTOOL_A_TSCONFIG_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_set_policy[ETHTOOL_A_TSCONFIG_MAX + 1];
+extern const struct nla_policy ethnl_mse_get_policy[ETHTOOL_A_MSE_HEADER + 1];

 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
--
2.47.3


