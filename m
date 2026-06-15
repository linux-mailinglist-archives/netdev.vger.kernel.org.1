Return-Path: <netdev+bounces-299509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EBMKJTgeMGoPOAUAu9opvQ
	(envelope-from <netdev+bounces-299509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:46:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA93687D7D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:46:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=DqPN94hU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299509-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299509-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D6D031FF887
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BFB4071F4;
	Mon, 15 Jun 2026 15:39:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B00B3D3331
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:39:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537980; cv=none; b=Y5S+anXpVfYBSjLYIb4Wikz3K/mNaS7XX2JZm3NGpfry4uxnAtDtfulSdGuR/0P0d/Hf+a9ddYorYhS/q18H7XGlluqXOvd4jiDgjF9REE5spGj2imjGnMWpFEdEq/z0mUIMStm5X7RWVCVwWJ/MWiJclL2dmKblw/ytjyKDEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537980; c=relaxed/simple;
	bh=/8kBzx6kVhhvbFziqjAC/CDWbH500ywR2Xlyp4hn3Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UulFAoc2gxbjGNGX/d167ZhsPvKclLYhlre9KYJE2/OsovlZloVfBLk7HLmqI/dZqA2xqe3udtXTqLbAcLyc8olqaQ6/oqOz8FU2ronyTZOF2ozskQldLQXDf/z0kIM8h7YVfIsb3PZlde0KJBfx6g1j51Mjb/zrgm4m7iC+EOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DqPN94hU; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1D9FF4E42F03;
	Mon, 15 Jun 2026 15:39:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E4EEE60015;
	Mon, 15 Jun 2026 15:39:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1FCE1106C96F3;
	Mon, 15 Jun 2026 17:39:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781537975; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=IaRnFKfO44yFZIEwYJxR/f8ybC0ZzCdpql6agUnH3PU=;
	b=DqPN94hUK5jjLiubASx8Suin0lx+RORdU658xrD4yxzDZGE/bCs4jc+WhD15eBTvQMeVLQ
	qAwLaAoHSNCgZfPZEQ+xIDpSPpvkaj1X5fHheoG6sJgDL96s8JCQlSsUqIEzyTXE70JHYF
	NzeNya/G37VQ/NQskglNPcnQBQE82WOuPgYtuNQio6KcS5/SmnoNihFfc4A1lmylzgoupo
	GRXaEwTYl41Wg2zkOLVoSWc35w1qWZ6vdkzd/SdF+nKnn8tG+r6krJzHEmKMV6A7/cZjVF
	p2jOvGY0gLc6smPGczlVG+9sAeBjaF87GNNvEFmL/WwhEpVAKDso1hzqv53BNw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>
Subject: [PATCH net-next v12 06/10] net: phy: phy_port: Store information about a port's upstream
Date: Mon, 15 Jun 2026 17:39:02 +0200
Message-ID: <20260615153907.862987-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615153907.862987-1-maxime.chevallier@bootlin.com>
References: <20260615153907.862987-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299509-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:andrew@lunn.ch,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:christophe.leroy@csgroup.eu,m:herve.codina@bootlin.com,m:f.fainelli@gmail.com,m:vladimir.oltean@nxp.com,m:kory.maincent@bootlin.com,m:kabel@kernel.org,m:o.rempel@pengutronix.de,m:nicveronese@gmail.com,m:horms@kernel.org,m:mwojtas@chromium.org,m:romain.gantois@bootlin.com,m:daniel@makrotopia.org,m:dimitri.fedrau@liebherr.com,m:frank.wunderlich@linux.dev,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BA93687D7D

MII phy_ports are not meant to be connected directly to a link partner.
They are meant to feed into some media converter devices that will
expose an MDI phy_port, so far we only support SFP modules for that.

In the case an MDI phy_port is backed by an MII port (e.g. a SFP
module's port, backed by the SFP cage port), let's keep track of the
port id of the MII port backing it.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 27 +++++++++++++++++++++++++++
 drivers/net/phy/phylink.c    |  5 +++++
 include/linux/phy.h          |  4 ++++
 include/linux/phy_port.h     |  3 +++
 4 files changed, 39 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c72582701e66..b7cd152aaaa3 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1493,6 +1493,7 @@ static int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
 	int ret;
 
 	phydev->has_sfp_mod_phy = true;
+	phy_set_upstream_port(phy, phydev->sfp_cage_port);
 
 	/* If we aren't attached to a netdev, we can't add the SFP PHY to its
 	 * topology.
@@ -1526,6 +1527,8 @@ static void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy)
 
 	if (dev)
 		phy_link_topo_del_phy(dev, phy);
+
+	phy_set_upstream_port(phy, NULL);
 }
 
 /**
@@ -1661,6 +1664,8 @@ static int phy_add_sfp_mod_port(struct phy_device *phydev)
 	 */
 	phydev->mod_port = port;
 
+	port->upstream_port = phydev->sfp_cage_port->id;
+
 	return 0;
 }
 
@@ -3696,6 +3701,28 @@ struct phy_port *phy_get_sfp_port(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(phy_get_sfp_port);
 
+/**
+ * phy_set_upstream_port() - Sets the phy_port controlling the MII this PHY is
+ *			     attached to.
+ * @phydev: pointer to the PHY device we set the upstream of.
+ * @port: The phy_port upstream of this PHY, can be NULL.
+ */
+void phy_set_upstream_port(struct phy_device *phydev, struct phy_port *port)
+{
+	struct phy_port *local_port;
+
+	ASSERT_RTNL();
+
+	phydev->upstream_port = port;
+
+	phy_for_each_port(phydev, local_port)
+		if (port)
+			local_port->upstream_port = port->id;
+		else
+			local_port->upstream_port = 0;
+}
+EXPORT_SYMBOL_GPL(phy_set_upstream_port);
+
 /**
  * fwnode_mdio_find_device - Given a fwnode, find the mdio_device
  * @fwnode: pointer to the mdio_device's fwnode
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 59ea3a2e5da4..d069338e8e4d 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3959,6 +3959,8 @@ static int phylink_add_sfp_mod_port(struct phylink *pl)
 		}
 	}
 
+	port->upstream_port = pl->sfp_cage_port->id;
+
 	pl->mod_port = port;
 
 	return 0;
@@ -4062,6 +4064,8 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
 			  pl->config->supported_interfaces);
 
+	phy_set_upstream_port(phy, pl->sfp_cage_port);
+
 	/* Do the initial configuration */
 	return phylink_sfp_config_phy(pl, phy);
 }
@@ -4070,6 +4074,7 @@ static void phylink_sfp_disconnect_phy(void *upstream,
 				       struct phy_device *phydev)
 {
 	phylink_disconnect_phy(upstream);
+	phy_set_upstream_port(phydev, NULL);
 }
 
 static const struct sfp_upstream_ops sfp_phylink_ops = {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 59903257e978..33ed10d4502a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -597,6 +597,7 @@ struct phy_oatc14_sqi_capability {
  * @sfp_bus: SFP bus attached to this PHY's fiber port
  * @sfp_cage_port: The phy_port connected to the downstream SFP cage
  * @mod_port: phy_port representing the SFP module, if it is phy-less
+ * @upstream_port: phy_port this PHY's MII attaches to, if any
  * @attached_dev: The attached enet driver's device instance ptr
  * @adjust_link: Callback for the enet controller to respond to changes: in the
  *               link state.
@@ -791,6 +792,7 @@ struct phy_device {
 	struct sfp_bus *sfp_bus;
 	struct phy_port *sfp_cage_port;
 	struct phy_port *mod_port;
+	struct phy_port *upstream_port;
 	struct phylink *phylink;
 	struct net_device *attached_dev;
 	struct mii_timestamper *mii_ts;
@@ -2466,6 +2468,8 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
 
 struct phy_port *phy_get_sfp_port(struct phy_device *phydev);
 
+void phy_set_upstream_port(struct phy_device *phydev, struct phy_port *port);
+
 /**
  * phy_module_driver() - Helper macro for registering PHY drivers
  * @__phy_drivers: array of PHY drivers to register
diff --git a/include/linux/phy_port.h b/include/linux/phy_port.h
index 4e2a3fdd2f2e..e3a41cedebdc 100644
--- a/include/linux/phy_port.h
+++ b/include/linux/phy_port.h
@@ -40,6 +40,8 @@ struct phy_port_ops {
  * @head: Used by the port's parent to list ports
  * @parent_type: The type of device this port is directly connected to
  * @phy: If the parent is PHY_PORT_PHYDEV, the PHY controlling that port
+ * @upstream_port: For non-MII ports, indicates the MII port that feeds this
+ *		   port, e.g. the SFP cage port for a SFP module port.
  * @ops: Callback ops implemented by the port controller
  * @pairs: The number of  pairs this port has, 0 if not applicable
  * @mediums: Bitmask of the physical mediums this port provides access to
@@ -59,6 +61,7 @@ struct phy_port {
 	union {
 		struct phy_device *phy;
 	};
+	u32 upstream_port;
 
 	const struct phy_port_ops *ops;
 
-- 
2.54.0


