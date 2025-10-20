Return-Path: <netdev+bounces-230857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 379DBBF08BF
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEE604F27E3
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF002F7AA8;
	Mon, 20 Oct 2025 10:32:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3D2F744A
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956332; cv=none; b=UXEcOCAbGClZmOxidoNhpN5TfV7vlqszdp64WBtccc8X58m7iSYD1zozm+ZohU4WeumbW7TOkBReusj/epSKPwyJdVNxpnqRwCWAVkFbbNGWG/w/F22nur/G6yqxhvV/kjcMLlOFnz2Q8KhUoS0J4r0xx5yY9U7OGslY3K8CW8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956332; c=relaxed/simple;
	bh=T27SIL/WNrPCPNJuZfhXr9jfhkUP8l1YtXOufHojNeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUSmuXsHjOMV199An/9G6xSbrpxWJEmxB8jId+WgdUUfwNCqAj9KwurD1P0zXMjIfSI2fCyMCxuhqni2DrGHS485KyGvzbUAIZVxo3DRqyAK2o+aUdob5sNKMKnC7x8bYOqksivjjqWOAE6pBU9r/ZDeVlQ3LUkjhmfCbFs0mLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vAnB8-0002zx-AU; Mon, 20 Oct 2025 12:31:50 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vAnB6-004WvS-0e;
	Mon, 20 Oct 2025 12:31:48 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vAnB6-0000000B1Km-0RBt;
	Mon, 20 Oct 2025 12:31:48 +0200
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
Subject: [PATCH net-next v7 3/5] ethtool: netlink: add lightweight MSE reporting to LINKSTATE_GET
Date: Mon, 20 Oct 2025 12:31:45 +0200
Message-ID: <20251020103147.2626645-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020103147.2626645-1-o.rempel@pengutronix.de>
References: <20251020103147.2626645-1-o.rempel@pengutronix.de>
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

Extend ETHTOOL_MSG_LINKSTATE_GET to optionally return a simplified
Mean Square Error (MSE) reading alongside existing link status fields.

The new attributes are:
  - ETHTOOL_A_LINKSTATE_MSE_VALUE: current average MSE value
  - ETHTOOL_A_LINKSTATE_MSE_MAX: scale limit for the reported value
  - ETHTOOL_A_LINKSTATE_MSE_CHANNEL: source channel selector

This path reuses the PHY MSE core API (struct phy_mse_capability and
struct phy_mse_snapshot), but only retrieves a single value intended for
quick link-health checks:
  * If the PHY supports a WORST channel selector, report its current
    average MSE.
  * Otherwise, if LINK-wide measurements are supported, report those.
  * If neither is available, omit the attributes.

Unlike the full MSE_GET interface, LINKSTATE_GET does not expose
per-channel or peak/worst-peak values and incurs minimal overhead.
Drivers that implement get_mse_capability() / get_mse_snapshot() will
automatically populate this data.

The intent is to provide tooling with a "fast path" health indicator
without issuing a separate MSE_GET request, though the long-term overlap
with the full interface may need reevaluation.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
---
changes v6:
- rename struct phy_mse_config -> struct phy_mse_capability (consistency with v6 API)
- switch ETHTOOL_A_LINKSTATE_MSE_VALUE and ETHTOOL_A_LINKSTATE_MSE_MAX
  from u32 -> uint (64-bit capable)
changes v3:
- add missing yaml spec
---
 Documentation/netlink/specs/ethtool.yaml      | 10 ++
 Documentation/networking/ethtool-netlink.rst  | 11 +++
 .../uapi/linux/ethtool_netlink_generated.h    |  3 +
 net/ethtool/linkstate.c                       | 94 +++++++++++++++++++
 4 files changed, 118 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index deaa598fee22..4e2320e23b50 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -721,6 +721,16 @@ attribute-sets:
       -
         name: ext-down-cnt
         type: u32
+      -
+        name: mse-value
+        type: uint
+      -
+        name: mse-max
+        type: uint
+      -
+        name: mse-channel
+        type: uint
+        enum: phy-mse-channel
   -
     name: debug
     attr-cnt-name: __ethtool-a-debug-cnt
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index d7a3dca182f0..71170a5b70c5 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -530,6 +530,9 @@ Kernel response contents:
   ``ETHTOOL_A_LINKSTATE_EXT_STATE``     u8      link extended state
   ``ETHTOOL_A_LINKSTATE_EXT_SUBSTATE``  u8      link extended substate
   ``ETHTOOL_A_LINKSTATE_EXT_DOWN_CNT``  u32     count of link down events
+  ``ETHTOOL_A_LINKSTATE_MSE_VALUE``     uint    Current average MSE value
+  ``ETHTOOL_A_LINKSTATE_MSE_MAX``       uint    Max scale for average MSE
+  ``ETHTOOL_A_LINKSTATE_MSE_CHANNEL``   uint    Source of MSE value
   ====================================  ======  ============================
 
 For most NIC drivers, the value of ``ETHTOOL_A_LINKSTATE_LINK`` returns
@@ -541,6 +544,14 @@ optional values. ethtool core can provide either both
 ``ETHTOOL_A_LINKSTATE_EXT_STATE`` and ``ETHTOOL_A_LINKSTATE_EXT_SUBSTATE``,
 or only ``ETHTOOL_A_LINKSTATE_EXT_STATE``, or none of them.
 
+``ETHTOOL_A_LINKSTATE_MSE_VALUE`` and ``ETHTOOL_A_LINKSTATE_MSE_MAX`` are
+optional values. The MSE value provided by this interface is a lightweight,
+less detailed version for quick health checks. If a WORST-channel selector is
+supported, the value comes from that selector; otherwise, if a LINK-wide
+selector is supported, it is used. If neither is available, the attributes are
+omitted. ``ETHTOOL_A_LINKSTATE_MSE_CHANNEL`` carries an
+``ethtool_phy_mse_channel``.
+
 ``LINKSTATE_GET`` allows dump requests (kernel returns reply messages for all
 devices supporting the request).
 
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index fb35f9ea8e81..ccadc9c6059e 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -337,6 +337,9 @@ enum {
 	ETHTOOL_A_LINKSTATE_EXT_STATE,
 	ETHTOOL_A_LINKSTATE_EXT_SUBSTATE,
 	ETHTOOL_A_LINKSTATE_EXT_DOWN_CNT,
+	ETHTOOL_A_LINKSTATE_MSE_VALUE,
+	ETHTOOL_A_LINKSTATE_MSE_MAX,
+	ETHTOOL_A_LINKSTATE_MSE_CHANNEL,
 
 	__ETHTOOL_A_LINKSTATE_CNT,
 	ETHTOOL_A_LINKSTATE_MAX = (__ETHTOOL_A_LINKSTATE_CNT - 1)
diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index 05a5f72c99fa..cc6bf7273102 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -14,6 +14,9 @@ struct linkstate_reply_data {
 	int					link;
 	int					sqi;
 	int					sqi_max;
+	u64					mse_value;
+	u64					mse_max;
+	u64					mse_channel;
 	struct ethtool_link_ext_stats		link_stats;
 	bool					link_ext_state_provided;
 	struct ethtool_link_ext_state_info	ethtool_link_ext_state_info;
@@ -76,6 +79,72 @@ static bool linkstate_sqi_valid(struct linkstate_reply_data *data)
 	       data->sqi <= data->sqi_max;
 }
 
+static int linkstate_get_mse(struct phy_device *phydev,
+			     struct linkstate_reply_data *data)
+{
+	struct phy_mse_snapshot snapshot = {};
+	struct phy_mse_capability cap = {};
+	int channel, ret;
+
+	if (!phydev)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&phydev->lock);
+
+	if (!phydev->drv || !phydev->drv->get_mse_capability ||
+	    !phydev->drv->get_mse_snapshot) {
+		ret = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	if (!phydev->link) {
+		ret = -ENETDOWN;
+		goto unlock;
+	}
+
+	ret = phydev->drv->get_mse_capability(phydev, &cap);
+	if (ret)
+		goto unlock;
+
+	/* We only expose average MSE on LINKSTATE. */
+	if (!(cap.supported_caps & PHY_MSE_CAP_AVG)) {
+		ret = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	if (cap.supported_caps & PHY_MSE_CAP_WORST_CHANNEL) {
+		channel = PHY_MSE_CHANNEL_WORST;
+	} else if (cap.supported_caps & PHY_MSE_CAP_LINK) {
+		channel = PHY_MSE_CHANNEL_LINK;
+	} else {
+		ret = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	ret = phydev->drv->get_mse_snapshot(phydev, channel, &snapshot);
+	if (ret)
+		goto unlock;
+
+	data->mse_value = snapshot.average_mse;
+	data->mse_max = cap.max_average_mse;
+	data->mse_channel = channel;
+
+unlock:
+	mutex_unlock(&phydev->lock);
+	return ret;
+}
+
+static bool linkstate_mse_critical_error(int err)
+{
+	return err < 0 && err != -EOPNOTSUPP && err != -ENETDOWN &&
+	       err != -EAGAIN;
+}
+
+static bool linkstate_mse_valid(struct linkstate_reply_data *data)
+{
+	return data->mse_max > 0 && data->mse_value <= data->mse_max;
+}
+
 static int linkstate_get_link_ext_state(struct net_device *dev,
 					struct linkstate_reply_data *data)
 {
@@ -125,6 +194,10 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 		goto out;
 	data->sqi_max = ret;
 
+	ret = linkstate_get_mse(phydev, data);
+	if (linkstate_mse_critical_error(ret))
+		goto out;
+
 	if (dev->flags & IFF_UP) {
 		ret = linkstate_get_link_ext_state(dev, data);
 		if (ret < 0 && ret != -EOPNOTSUPP && ret != -ENODATA)
@@ -164,6 +237,15 @@ static int linkstate_reply_size(const struct ethnl_req_info *req_base,
 		len += nla_total_size(sizeof(u32)); /* LINKSTATE_SQI_MAX */
 	}
 
+	if (linkstate_mse_valid(data)) {
+		/* LINKSTATE_MSE_VALUE */
+		len += nla_total_size(sizeof(u64));
+		/* LINKSTATE_MSE_MAX */
+		len += nla_total_size(sizeof(u64));
+		/* LINKSTATE_MSE_CHANNEL */
+		len += nla_total_size(sizeof(u64));
+	}
+
 	if (data->link_ext_state_provided)
 		len += nla_total_size(sizeof(u8)); /* LINKSTATE_EXT_STATE */
 
@@ -195,6 +277,18 @@ static int linkstate_fill_reply(struct sk_buff *skb,
 			return -EMSGSIZE;
 	}
 
+	if (linkstate_mse_valid(data)) {
+		if (nla_put_uint(skb, ETHTOOL_A_LINKSTATE_MSE_VALUE,
+				 data->mse_value))
+			return -EMSGSIZE;
+		if (nla_put_uint(skb, ETHTOOL_A_LINKSTATE_MSE_MAX,
+				 data->mse_max))
+			return -EMSGSIZE;
+		if (nla_put_uint(skb, ETHTOOL_A_LINKSTATE_MSE_CHANNEL,
+				 data->mse_channel))
+			return -EMSGSIZE;
+	}
+
 	if (data->link_ext_state_provided) {
 		if (nla_put_u8(skb, ETHTOOL_A_LINKSTATE_EXT_STATE,
 			       data->ethtool_link_ext_state_info.link_ext_state))
-- 
2.47.3


