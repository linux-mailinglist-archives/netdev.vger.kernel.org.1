Return-Path: <netdev+bounces-256384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALGeAJ0ygml5QQMAu9opvQ
	(envelope-from <netdev+bounces-256384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:38:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B79DCE73
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2E6131AA9EA
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B5631961A;
	Tue,  3 Feb 2026 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2Qo+Fxox"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C44C3D330A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139748; cv=none; b=CiVk/68gwPVM+dWkqneYM8OZ19XcGu2rDgt+UfConoD57c5+HX6wIkbSY+joi2Z+/jEsGLxZ98Ti/Ty0mXl37LclX9f+9xdFulQhVv0ywcyw86K0db9TaCf8d6X9HFxmY/mSDxly9nWVv9GIuvnByeWtCBpfpbgGdeH+fGg815I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139748; c=relaxed/simple;
	bh=ceTw3Y+2k1owesKq9VRkvE3lyH9jPSiyaxkXTcGp/Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9PhFK2ULv0e0+AAAFQUG3/ne1+/Sjq96TLqHTAJGUxyJ+Il5mNsiWnFIJt3hbtxhKIyPkbQi7WEKHtKs3qTQUkrUHLo1YZMWrDsGsUX695SrcFrWYLr+XyWaKYFFwhkF3mfzTE6Y84rRlKfn2+b8XMtiBXrNCuGfFp4zdKVoPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2Qo+Fxox; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3CA2B1A2BC4;
	Tue,  3 Feb 2026 17:29:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 11E2560728;
	Tue,  3 Feb 2026 17:29:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CF2C119A88F8;
	Tue,  3 Feb 2026 18:29:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770139743; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=IRk0K+iuT7PNYANBHukpfnb6ronXpCa6nfbjQJcF9QU=;
	b=2Qo+Fxox7KBPLX7Nqfyo+aMZtklsrcVkFQo+aaixjG7LQ9Iy+Sc+kqXXr5Gy1jtMKUWjeu
	fgIYcDZTkCV9IHyAZ0IwY02GVAKeQ22DiTg1XaA2WWa58iJlciNwKz/rpnwtfXcHPr+VDo
	L/k1gYDhN3EHlwIAy8IlHV/ONG65ngc0khrtpC2m/P/Pi0B/z7x7hHPthFWmdI46VQMQl2
	Wh0Nd9HkvxSuzC5Z+zyzlVrKnVw8mD7Z6tAdqnUOAfqS0S4iDqkhK7gYGTJsFnKOIYEOZA
	LZpDVRBidCWffL/9s8pEAH54JWr+k0GoB9XoXtf5FxB9gAs9VWvpBPv/HAYOKw==
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
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: [PATCH net-next v4 05/13] net: phy: phy_link_topology: Track ports in phy_link_topology
Date: Tue,  3 Feb 2026 18:28:29 +0100
Message-ID: <20260203172839.548524-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260203172839.548524-1-maxime.chevallier@bootlin.com>
References: <20260203172839.548524-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256384-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 91B79DCE73
X-Rspamd-Action: no action

phy_port is aimed at representing the various physical interfaces of a
net_device. They can be controlled by various components in the link,
such as the Ethernet PHY, the Ethernet MAC, and SFP module, etc.

Let's therefore make so we keep track of all the ports connected to a
netdev in phy_link_topology. The only ports added for now are phy-driven
ports.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_link_topology.c | 53 +++++++++++++++++++++++++++++
 include/linux/phy_link_topology.h   | 18 ++++++++++
 include/linux/phy_port.h            |  2 ++
 net/core/dev.c                      |  1 +
 4 files changed, 74 insertions(+)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 7dc2ff10c74a..456f1144e83e 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/phy_link_topology.h>
+#include <linux/phy_port.h>
 #include <linux/phy.h>
 #include <linux/rtnetlink.h>
 #include <linux/xarray.h>
@@ -22,6 +23,9 @@ static int netdev_alloc_phy_link_topology(struct net_device *dev)
 	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
 	topo->next_phy_index = 1;
 
+	xa_init_flags(&topo->ports, XA_FLAGS_ALLOC1);
+	topo->next_port_index = 1;
+
 	dev->link_topo = topo;
 
 	return 0;
@@ -44,12 +48,45 @@ static struct phy_link_topology *phy_link_topo_get_or_alloc(struct net_device *d
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
 
 	topo = phy_link_topo_get_or_alloc(dev);
@@ -89,8 +126,20 @@ int phy_link_topo_add_phy(struct net_device *dev,
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
+	list_for_each_entry_from_reverse(port, &phy->ports, head)
+		phy_link_topo_del_port(dev, port);
+
+	xa_erase(&topo->phys, phy->phyindex);
 err:
 	kfree(pdn);
 	return ret;
@@ -102,10 +151,14 @@ void phy_link_topo_del_phy(struct net_device *dev,
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
index 68a59e25821c..66bceff72b19 100644
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
@@ -43,6 +47,9 @@ int phy_link_topo_add_phy(struct net_device *dev,
 
 void phy_link_topo_del_phy(struct net_device *dev, struct phy_device *phy);
 
+int phy_link_topo_add_port(struct net_device *dev, struct phy_port *port);
+void phy_link_topo_del_port(struct net_device *dev, struct phy_port *port);
+
 static inline struct phy_device *
 phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
 {
@@ -72,6 +79,17 @@ static inline void phy_link_topo_del_phy(struct net_device *dev,
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
index 43de5af0d6ec..fe2dfcc95400 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11277,6 +11277,7 @@ static void netdev_free_phy_link_topology(struct net_device *dev)
 
 	if (IS_ENABLED(CONFIG_PHYLIB) && topo) {
 		xa_destroy(&topo->phys);
+		xa_destroy(&topo->ports);
 		kfree(topo);
 		dev->link_topo = NULL;
 	}
-- 
2.49.0


