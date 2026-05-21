Return-Path: <netdev+bounces-290383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ6IOuf2DmoSDwYAu9opvQ
	(envelope-from <netdev+bounces-290383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:13:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2C55A49A3
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 542113056623
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0673491C4;
	Thu, 21 May 2026 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hUs47Z/F"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119FF3D0C16
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365475; cv=none; b=iU+tNhgxKDxR9n+BTINdT0CeLPY57IRqznwAZiB9eNThGa5vJ8+8QPwz8wbU9/Zb9dobCFd7Iae8kKJBoWVInOTk9CcYZJ0CoIQB2wJDRZzZchlZE2aBDsSNKMVgDDbG5XzUqH5yrt0a7ygvMS/J9fOLT293/bro3JLbG6WirKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365475; c=relaxed/simple;
	bh=oikM9kMOf3D3wSnstY2KS0qPIkMx4DeNVS8cieDejnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVEMV2jjeFliShbHX2O6xWX+eyu4ml0e6w7Zhz7FfeZA1/0zL3sXKE5Gd+iZq8DyTnWkBsAoha57sKXnefefW+Fx/wsuFk6Hl5dxL7evowj3uCXKDn7mj9FNhaOAoLasKLf4sN5xq93F9oFyOlLKtXRBKuX4oeUU8XsjjwpHnN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hUs47Z/F; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 67CFE1A3661;
	Thu, 21 May 2026 12:11:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 35EED60495;
	Thu, 21 May 2026 12:11:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A85CB107E8A81;
	Thu, 21 May 2026 14:11:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779365469; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=q6JmGD2h0hdk4OCPA7IOW7FYLMqebNdRWdEUSON54K0=;
	b=hUs47Z/F4bvHMLFi4XxuGOXgeR40XryHxI11IeVxuAEDzRPlPBV1SN8C2qvVDgO9FdF3+4
	nqGdvyu6rc/0y52H/5WBlw9DDAzdXMMgvVjYiG3B4Rh7tapmFZPDljFZWF/0S91cm8KFUy
	8vX9Oq9Ut3rixpMi5OuOQcmGIsLTB624rNjE2E8keMB4vCnLx7eh3puYoK5mbkhtgLKDS7
	S22zmKiK0Er0xzx+Y+BDdovWJvspPpqqNrF53+7wC7xBrXtt5AjZ0FCP+MgbwcLymgmz9R
	eVzkA8Y6sCRdjiuRgk8ragFGYfX48PO37t1DtJDqlg1/9iRdz+Ff6meUgavE/A==
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
Subject: [PATCH net-next v11 03/10] net: phylink: Register a phy_port for MAC-driven SFP cages
Date: Thu, 21 May 2026 14:10:31 +0200
Message-ID: <20260521121040.1199622-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
References: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-290383-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 8E2C55A49A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

phy_port tracks the interfaces that a netdevice feeds into. SFP cages are
such ports, but so far we are only tracking the ones that are driven by
PHYs acting as media-converters.

Let's populate a phy_port for MAC driver SFP cages, handled by phylink.

This phy_port represents the SFP cage itself, and not the module that
may be plugged into it. It's therefore not an MDI interface, so only the
'interfaces' field is relevant here.

The phy_port is only populated for 'NETDEV' phylink instances, as
otherwise we don't have any topology to attach the port to.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 087ac63f9193..640b3f4f45f9 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -14,6 +14,8 @@
 #include <linux/of_mdio.h>
 #include <linux/phy.h>
 #include <linux/phy_fixed.h>
+#include <linux/phy_link_topology.h>
+#include <linux/phy_port.h>
 #include <linux/phylink.h>
 #include <linux/rtnetlink.h>
 #include <linux/spinlock.h>
@@ -93,6 +95,7 @@ struct phylink {
 	DECLARE_PHY_INTERFACE_MASK(sfp_interfaces);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
 	u8 sfp_port;
+	struct phy_port *sfp_cage_port;
 
 	struct eee_config eee_cfg;
 
@@ -1765,6 +1768,46 @@ static void phylink_fixed_poll(struct timer_list *t)
 
 static const struct sfp_upstream_ops sfp_phylink_ops;
 
+static int phylink_create_sfp_cage_port(struct phylink *pl)
+{
+	struct phy_port *port;
+	int ret = 0;
+
+	if (!pl->netdev || !pl->sfp_bus)
+		return 0;
+
+	port = phy_port_alloc();
+	if (!port)
+		return -ENOMEM;
+
+	port->is_sfp = true;
+	port->is_mii = true;
+	port->active = true;
+
+	phy_interface_and(port->interfaces, pl->config->supported_interfaces,
+			  phylink_sfp_interfaces);
+	phy_port_update_supported(port);
+
+	ret = phy_link_topo_add_port(pl->netdev, port);
+	if (ret)
+		phy_port_destroy(port);
+	else
+		pl->sfp_cage_port = port;
+
+	return ret;
+}
+
+static void phylink_destroy_sfp_cage_port(struct phylink *pl)
+{
+	if (pl->netdev && pl->sfp_cage_port)
+		phy_link_topo_del_port(pl->netdev, pl->sfp_cage_port);
+
+	if (pl->sfp_cage_port)
+		phy_port_destroy(pl->sfp_cage_port);
+
+	pl->sfp_cage_port = NULL;
+}
+
 static int phylink_register_sfp(struct phylink *pl,
 				const struct fwnode_handle *fwnode)
 {
@@ -1782,9 +1825,18 @@ static int phylink_register_sfp(struct phylink *pl,
 
 	pl->sfp_bus = bus;
 
+	ret = phylink_create_sfp_cage_port(pl);
+	if (ret) {
+		sfp_bus_put(bus);
+		return ret;
+	}
+
 	ret = sfp_bus_add_upstream(bus, pl, &sfp_phylink_ops);
 	sfp_bus_put(bus);
 
+	if (ret)
+		phylink_destroy_sfp_cage_port(pl);
+
 	return ret;
 }
 
@@ -1946,6 +1998,7 @@ EXPORT_SYMBOL_GPL(phylink_create);
 void phylink_destroy(struct phylink *pl)
 {
 	sfp_bus_del_upstream(pl->sfp_bus);
+	phylink_destroy_sfp_cage_port(pl);
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
 
-- 
2.54.0


