Return-Path: <netdev+bounces-254446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGioL6N1emmE6wEAu9opvQ
	(envelope-from <netdev+bounces-254446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:46:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61421A8C77
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CED730074AD
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D656C376488;
	Wed, 28 Jan 2026 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F/267Jah"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCCD227BB9
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633165; cv=none; b=Ssi5gnsNn8PG9jl+80vAbZZOwjxnr1kPHRzSvG3MM9MZZCOM7J8Mk6jTbfL1QWkkQB2lIHXTgtcId5w/ISdfs8HQBdElgWvBHDJYN4f+M8LIQA9uWQ+lFB0k0uczOVXv9G3z+Iy4c6D+GK2DXJ/iQKU+TFA1D+rNuncSWALqlXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633165; c=relaxed/simple;
	bh=5LnkBfoB7QllJKIseqDIe8FHMXiM9rQixryHtaI8fjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzNHKuKgD47Z3i5YXlCyrvFoOfeiyc3QNTyEGSuWn2ghhjApe4xgFXGNQ6dvw0gF7ZZ8fPBkYHZP0cGIiHL2LDwSkd8EHlfGE+4I0MJD9gEIE0YICtQ6iDnTHO9mDet+9xB1F1+Z8jnhvCqHsAHHtRuCjofzcrUQhrlD2blayfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F/267Jah; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 621C51A2AD4;
	Wed, 28 Jan 2026 20:45:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 37EC16071F;
	Wed, 28 Jan 2026 20:45:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 11C9A119A8835;
	Wed, 28 Jan 2026 21:45:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769633155; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=vSUr6ReAFYTUjAYmZ597frc70URndFFYWhKPXvo42Xs=;
	b=F/267JahJA6LbhFSM5jVVFPGtd7fZhMsSu1+9wQWhcpA3hfizGoAkTuI+eGWGHS08+cF+0
	eiVNuwYw0MkOnZGN8EjYp+6Qz/Di7QggifGdGXaEKsHYIF/bUOJ/5ac8qwq2Z/h1dCYVZR
	sfwUIuXrVSd0YkGRHiM9g70U+B+pF9vK/6bzB/VGs89DaqA3bRlUtRXGyV9Mc1VBmp2hO8
	N8SNxMRH/USczA30d9IFGRCZm8qWv1jksQYEFoBVHYFZlmzEd8DXzJO/+JfvQ+Q3j2BaqT
	vGWFZVpJwXGYXrsGZP+CVQXCo0boYaJmqOf8tpi4L2kkE/t0bwWiOuKnoX85dg==
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
Subject: [PATCH net-next v2 07/12] net: phy: Represent PHY-less SFP modules with phy_port
Date: Wed, 28 Jan 2026 21:45:20 +0100
Message-ID: <20260128204526.170927-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260128204526.170927-1-maxime.chevallier@bootlin.com>
References: <20260128204526.170927-1-maxime.chevallier@bootlin.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-254446-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61421A8C77
X-Rspamd-Action: no action

Now that th SFP bus infrastructure notifies when PHY-less modules are
connected, we can create a phy_port to represent it. Instead of letting
the SFP subsystem handle that, the Bus' upstream is in charge of
maintaining that phy_port and register it to the topology, as the
upstream (in this case a phy device) is directly interacting with the
underlying net_device.

Add a phy_caps helper alongside to get the achievable modes on this
module based on what the phy_port representing the bus supports.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-caps.h   |  2 ++
 drivers/net/phy/phy_caps.c   | 26 +++++++++++++++
 drivers/net/phy/phy_device.c | 62 +++++++++++++++++++++++++++++++++++-
 include/linux/phy.h          |  4 +++
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 421088e6f6e8..ec3d39a0ae06 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -66,5 +66,7 @@ void phy_caps_medium_get_supported(unsigned long *supported,
 				   enum ethtool_link_medium medium,
 				   int lanes);
 u32 phy_caps_mediums_from_linkmodes(unsigned long *linkmodes);
+void phy_caps_linkmode_filter_ifaces(unsigned long *to, const unsigned long *from,
+				     const unsigned long *interfaces);
 
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 942d43191561..558e4df4d63c 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -445,3 +445,29 @@ u32 phy_caps_mediums_from_linkmodes(unsigned long *linkmodes)
 	return mediums;
 }
 EXPORT_SYMBOL_GPL(phy_caps_mediums_from_linkmodes);
+
+/**
+ * phy_caps_linkmode_filter_ifaces() - Filter linkmodes with an interface list
+ * @to: Stores the filtered linkmodes
+ * @from: Linkmodes to filter
+ * @interfaces: Bitfield of phy_interface_t that we use for filtering
+ *
+ * Filter the provided linkmodes, only to keep the ones we can possibly achieve
+ * when using any of the provided MII interfaces.
+ */
+void phy_caps_linkmode_filter_ifaces(unsigned long *to,
+				     const unsigned long *from,
+				     const unsigned long *interfaces)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(ifaces_supported) = {};
+	unsigned int ifaces_caps = 0;
+	phy_interface_t interface;
+
+	for_each_set_bit(interface, interfaces, PHY_INTERFACE_MODE_MAX)
+		ifaces_caps |= phy_caps_from_interface(interface);
+
+	phy_caps_linkmodes(ifaces_caps, ifaces_supported);
+
+	linkmode_and(to, from, ifaces_supported);
+}
+EXPORT_SYMBOL_GPL(phy_caps_linkmode_filter_ifaces);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 49696b1a2f13..b3125cf30bf3 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1609,6 +1609,53 @@ static void phy_sfp_link_down(void *upstream)
 		port->ops->link_down(port);
 }
 
+static int phy_sfp_connect_nophy(void *upstream)
+{
+	struct phy_device *phydev = upstream;
+	const struct sfp_module_caps *caps;
+	struct phy_port *port;
+	int ret = 0;
+
+	/* Create mod port */
+	port = phy_port_alloc();
+	if (!port)
+		return -ENOMEM;
+
+	port->active = true;
+
+	caps = sfp_get_module_caps(phydev->sfp_bus);
+
+	phy_caps_linkmode_filter_ifaces(port->supported, caps->link_modes,
+					phydev->sfp_bus_port->interfaces);
+
+	if (phydev->attached_dev) {
+		ret = phy_link_topo_add_port(phydev->attached_dev, port);
+		if (ret) {
+			phy_port_destroy(port);
+			return ret;
+		}
+	}
+
+	/* we don't use phy_add_port() here as the module port isn't a direct
+	 * interface from the PHY, but rather an extension to the sfp-bus, that
+	 * is already represented by its own phy_port
+	 */
+	phydev->mod_port = port;
+
+	return 0;
+}
+
+static void phy_sfp_disconnect_nophy(void *upstream)
+{
+	struct phy_device *phydev = upstream;
+
+	if (phydev->attached_dev)
+		phy_link_topo_del_port(phydev->attached_dev, phydev->mod_port);
+
+	phy_port_destroy(phydev->mod_port);
+	phydev->mod_port = NULL;
+}
+
 static const struct sfp_upstream_ops sfp_phydev_ops = {
 	.attach = phy_sfp_attach,
 	.detach = phy_sfp_detach,
@@ -1618,6 +1665,8 @@ static const struct sfp_upstream_ops sfp_phydev_ops = {
 	.link_down = phy_sfp_link_down,
 	.connect_phy = phy_sfp_connect_phy,
 	.disconnect_phy = phy_sfp_disconnect_phy,
+	.connect_nophy = phy_sfp_connect_nophy,
+	.disconnect_nophy = phy_sfp_disconnect_nophy,
 };
 
 static int phy_add_port(struct phy_device *phydev, struct phy_port *port)
@@ -1700,7 +1749,7 @@ static struct phy_port *phy_setup_sfp_port(struct phy_device *phydev)
  */
 static int phy_sfp_probe(struct phy_device *phydev)
 {
-	struct phy_port *port;
+	struct phy_port *port = NULL;
 	struct sfp_bus *bus;
 	int ret;
 
@@ -1729,6 +1778,8 @@ static int phy_sfp_probe(struct phy_device *phydev)
 		phy_port_destroy(port);
 	}
 
+	phydev->sfp_bus_port = port;
+
 	return ret;
 }
 
@@ -1818,6 +1869,12 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		err = phy_link_topo_add_phy(dev, phydev, PHY_UPSTREAM_MAC, dev);
 		if (err)
 			goto error;
+
+		if (phydev->mod_port) {
+			err = phy_link_topo_add_port(dev, phydev->mod_port);
+			if (err)
+				goto error;
+		}
 	}
 
 	/* Some Ethernet drivers try to connect to a PHY device before
@@ -1991,6 +2048,8 @@ void phy_detach(struct phy_device *phydev)
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
 		phy_link_topo_del_phy(dev, phydev);
+		if (phydev->mod_port)
+			phy_link_topo_del_port(dev, phydev->mod_port);
 	}
 
 	phydev->phy_link_change = NULL;
@@ -3818,6 +3877,7 @@ static int phy_remove(struct device *dev)
 
 	sfp_bus_del_upstream(phydev->sfp_bus);
 	phydev->sfp_bus = NULL;
+	phydev->sfp_bus_port = NULL;
 
 	if (phydev->drv && phydev->drv->remove)
 		phydev->drv->remove(phydev);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 6f9979a26892..dc788ae4da64 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -594,6 +594,8 @@ struct phy_oatc14_sqi_capability {
  * @phylink: Pointer to phylink instance for this PHY
  * @sfp_bus_attached: Flag indicating whether the SFP bus has been attached
  * @sfp_bus: SFP bus attached to this PHY's fiber port
+ * @sfp_bus_port: The phy_port connected to the downstream SFP bus
+ * @mod_port: phy_port representing the SFP module, if it is phy-less
  * @attached_dev: The attached enet driver's device instance ptr
  * @adjust_link: Callback for the enet controller to respond to changes: in the
  *               link state.
@@ -782,6 +784,8 @@ struct phy_device {
 	/* This may be modified under the rtnl lock */
 	bool sfp_bus_attached;
 	struct sfp_bus *sfp_bus;
+	struct phy_port *sfp_bus_port;
+	struct phy_port *mod_port;
 	struct phylink *phylink;
 	struct net_device *attached_dev;
 	struct mii_timestamper *mii_ts;
-- 
2.49.0


