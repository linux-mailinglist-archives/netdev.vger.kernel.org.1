Return-Path: <netdev+bounces-299505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hwa6FcEcMGpyNwUAu9opvQ
	(envelope-from <netdev+bounces-299505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:39:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9B8687C82
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:39:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=f9IAX6Nz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299505-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299505-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 394E5302516E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261B2406837;
	Mon, 15 Jun 2026 15:39:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE2406833;
	Mon, 15 Jun 2026 15:39:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537968; cv=none; b=P0Ba9rPZNGNSOCLfpqWieBTP4KE8zO0buCLBvPxLL/rdznK2aKUJPcA0dQk9k5pSLyH4RkZLrKZA/MjD5ZOpny1WhhUDthCzi7oU67VIkHiX75+Sk+6A0Wja+snblW3tcmhnB2LDpfTHJN6DyFsRpTRPLu2YEE/7Ql4O+1PtyRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537968; c=relaxed/simple;
	bh=ohK1Ar+J9tiJioFqp/SACoDDMA6j6vED5Vhk2tctnL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOnt1luxZNVx8AqyFNSU/0YKI2fuySNJXSEqKA65L4Y8aEVVpWAHfZm2UmUo+1NtbYDMeCNGCeRDTsymAhtjroVjGZ3ET9NdMWbZYGm6nZkLOdWnQluxksbH+j0N03mCBn+8ajceiYswCxT8WhknG1eY6C5hb8Q0CU/lrq9xTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f9IAX6Nz; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AC358C5146A;
	Mon, 15 Jun 2026 15:39:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8438360015;
	Mon, 15 Jun 2026 15:39:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC63D106C9656;
	Mon, 15 Jun 2026 17:39:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781537961; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GmUvxqz8syiAdfZwju7ZDux5hsrBP7X5Nc6gdCSxH1w=;
	b=f9IAX6NzpfiuYMgLYhvVV+VPL7ZzSiqwX8B010ufLeyG4QPxgxfxo/q3xSmMWIoR6l8kiy
	BRYTS9j91kQ1ZqGkuAbVYCcLBTa3Akpz+tUdCkMNzYqwdb4SuzixO54eHsUvQSro/6YO//
	N0rTSsQjht3W/+a3Ng3lmwSyPvUHY8IMkIYAcAOwiYNEdnjmCnZVmU4vTmylA2DLKkQfrf
	iNlSgGzif5mL5+wHCr9s2w3YbUn/+qCKCk9KNoSOVaVbgFTNFMt/auEfff1FiHfn8AWkCy
	7VIGNpWis0bsQqUHcSbCef+TuANeHZY1lrAm2ykKkLVrinb6cK+STRk9DS0OzA==
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
Subject: [PATCH net-next v12 02/10] net: phy: phy_link_topology: Track ports in phy_link_topology
Date: Mon, 15 Jun 2026 17:38:58 +0200
Message-ID: <20260615153907.862987-3-maxime.chevallier@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299505-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB9B8687C82

phy_port is aimed at representing the various physical interfaces of a
net_device. They can be controlled by various components in the link,
such as the Ethernet PHY, the Ethernet MAC, and SFP module, etc.

Let's therefore make so we keep track of all the ports connected to a
netdev in phy_link_topology. The only ports added for now are phy-driven
ports.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_link_topology.c | 53 +++++++++++++++++++++++++++++
 include/linux/phy_link_topology.h   | 18 ++++++++++
 include/linux/phy_port.h            |  2 ++
 net/core/dev.c                      |  1 +
 4 files changed, 74 insertions(+)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 99f1842afcbd..a7ff36a12c4e 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/phy_link_topology.h>
+#include <linux/phy_port.h>
 #include <linux/phy.h>
 #include <linux/rtnetlink.h>
 #include <linux/xarray.h>
@@ -23,6 +24,9 @@ static int netdev_alloc_phy_link_topology(struct net_device *dev)
 	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
 	topo->next_phy_index = 1;
 
+	xa_init_flags(&topo->ports, XA_FLAGS_ALLOC1);
+	topo->next_port_index = 1;
+
 	dev->link_topo = topo;
 
 	return 0;
@@ -45,12 +49,45 @@ static struct phy_link_topology *phy_link_topo_get_or_alloc(struct net_device *d
 	return dev->link_topo;
 }
 
+int phy_link_topo_add_port(struct net_device *dev, struct phy_port *port)
+{
+	struct phy_link_topology *topo;
+	int ret;
+
+	topo = phy_link_topo_get_or_alloc(dev);
+	if (IS_ERR(topo))
+		return PTR_ERR(topo);
+
+	/* Attempt to re-use a previously allocated port_id */
+	if (port->id)
+		ret = xa_insert(&topo->ports, port->id, port, GFP_KERNEL);
+	else
+		ret = xa_alloc_cyclic(&topo->ports, &port->id, port,
+				      xa_limit_32b, &topo->next_port_index,
+				      GFP_KERNEL);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_link_topo_add_port);
+
+void phy_link_topo_del_port(struct net_device *dev, struct phy_port *port)
+{
+	struct phy_link_topology *topo = dev->link_topo;
+
+	if (!topo)
+		return;
+
+	xa_erase(&topo->ports, port->id);
+}
+EXPORT_SYMBOL_GPL(phy_link_topo_del_port);
+
 int phy_link_topo_add_phy(struct net_device *dev,
 			  struct phy_device *phy,
 			  enum phy_upstream upt, void *upstream)
 {
 	struct phy_link_topology *topo;
 	struct phy_device_node *pdn;
+	struct phy_port *port;
 	int ret;
 
 	/* ethtool ops may run without rtnl_lock, and rtnl_lock is what
@@ -99,8 +136,20 @@ int phy_link_topo_add_phy(struct net_device *dev,
 	if (ret < 0)
 		goto err;
 
+	/* Add all the PHY's ports to the topology */
+	list_for_each_entry(port, &phy->ports, head) {
+		ret = phy_link_topo_add_port(dev, port);
+		if (ret)
+			goto del_ports;
+	}
+
 	return 0;
 
+del_ports:
+	list_for_each_entry_continue_reverse(port, &phy->ports, head)
+		phy_link_topo_del_port(dev, port);
+
+	xa_erase(&topo->phys, phy->phyindex);
 err:
 	kfree(pdn);
 	return ret;
@@ -112,10 +161,14 @@ void phy_link_topo_del_phy(struct net_device *dev,
 {
 	struct phy_link_topology *topo = dev->link_topo;
 	struct phy_device_node *pdn;
+	struct phy_port *port;
 
 	if (!topo)
 		return;
 
+	list_for_each_entry(port, &phy->ports, head)
+		phy_link_topo_del_port(dev, port);
+
 	pdn = xa_erase(&topo->phys, phy->phyindex);
 
 	/* We delete the PHY from the topology, however we don't re-set the
diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
index 95575f68d5bc..296ee514ba46 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -16,11 +16,15 @@
 
 struct xarray;
 struct phy_device;
+struct phy_port;
 struct sfp_bus;
 
 struct phy_link_topology {
 	struct xarray phys;
 	u32 next_phy_index;
+
+	struct xarray ports;
+	u32 next_port_index;
 };
 
 struct phy_device_node {
@@ -48,6 +52,9 @@ int phy_link_topo_add_phy(struct net_device *dev,
 
 void phy_link_topo_del_phy(struct net_device *dev, struct phy_device *phy);
 
+int phy_link_topo_add_port(struct net_device *dev, struct phy_port *port);
+void phy_link_topo_del_port(struct net_device *dev, struct phy_port *port);
+
 static inline struct phy_device *
 phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
 {
@@ -77,6 +84,17 @@ static inline void phy_link_topo_del_phy(struct net_device *dev,
 {
 }
 
+static inline int phy_link_topo_add_port(struct net_device *dev,
+					 struct phy_port *port)
+{
+	return 0;
+}
+
+static inline void phy_link_topo_del_port(struct net_device *dev,
+					  struct phy_port *port)
+{
+}
+
 static inline struct phy_device *
 phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
 {
diff --git a/include/linux/phy_port.h b/include/linux/phy_port.h
index 0ef0f5ce4709..4e2a3fdd2f2e 100644
--- a/include/linux/phy_port.h
+++ b/include/linux/phy_port.h
@@ -36,6 +36,7 @@ struct phy_port_ops {
 /**
  * struct phy_port - A representation of a network device physical interface
  *
+ * @id: Unique identifier for the port within the topology
  * @head: Used by the port's parent to list ports
  * @parent_type: The type of device this port is directly connected to
  * @phy: If the parent is PHY_PORT_PHYDEV, the PHY controlling that port
@@ -52,6 +53,7 @@ struct phy_port_ops {
  * @is_sfp: Indicates if this port drives an SFP cage.
  */
 struct phy_port {
+	u32 id;
 	struct list_head head;
 	enum phy_port_parent parent_type;
 	union {
diff --git a/net/core/dev.c b/net/core/dev.c
index 202e35acb15b..3a91b8efa2bc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11300,6 +11300,7 @@ static void netdev_free_phy_link_topology(struct net_device *dev)
 
 	if (IS_ENABLED(CONFIG_PHYLIB) && topo) {
 		xa_destroy(&topo->phys);
+		xa_destroy(&topo->ports);
 		kfree(topo);
 		dev->link_topo = NULL;
 	}
-- 
2.54.0


