Return-Path: <netdev+bounces-290384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIS2A8j3DmoSDwYAu9opvQ
	(envelope-from <netdev+bounces-290384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:17:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 586295A4A5E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FFDD3085E65
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D5A3D3CE0;
	Thu, 21 May 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mjAVlWHO"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE80E3D25CE;
	Thu, 21 May 2026 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365477; cv=none; b=WJnJPGGKpgt6IvJ+evcjUAscwP2KaaUGpW6qA5NJSOrtavXRLN/YpPUqQbP9rfURNinsCCZh+HR/fgseGgGml7BgmOittclNHHbgi35hTgCARkeDNZWOnobvSVfedxAnOY2X8HBHMTwNndQVacYoF/qHncn04VC1qevh29JcNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365477; c=relaxed/simple;
	bh=t8JUWUOpottkDAhxnkfbLl1tuwM0BAMyu0WZQMqk0Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZVnVq87fZgkdaFk62GciuK9i0YPX6y0SzDM/4lAAvZLXVDaTQ/yAVjSEPYfGiUODsDbDmi8mBftWuGAImrXJ6tvbb3ymTATViiHPRh+/pscocDJpSWXDz3/CU68+pKwIE86maxCgrX8VQ0tOfio3jrqmzb4gndxi+Nr55YLkek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mjAVlWHO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8C0244E42D12;
	Thu, 21 May 2026 12:11:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 59F6E60495;
	Thu, 21 May 2026 12:11:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED526107E8B40;
	Thu, 21 May 2026 14:11:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779365472; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=4M9L9jzLB37Sf3RMZday7KqG8JHVvHZe6jV1TxR4dBM=;
	b=mjAVlWHOsldtvmj/9oPORBqJDbjE4nQZTlpwA4kxpHxPjiCeUqrTg/+S0Ig0H9zB1vjm50
	InB3GZLbtJfwOiogZmwA40UNEyk3TvQCsk4UD9O0JYLDqa1fOUov9ucMYaNtwV8Lwjrlj9
	6on2k9d57uAfwaRYFw+2m2+1gfUrzkyv3ag8hsmhL+gjSk125FoTFd6iUxCk7OBMZjY6VR
	yKVQupMT1lZLHVe0/ox5h5bQ4o8FuZ+NuNSUQ9QbN/tcvmaPEjSn9fMMqyAlmuDggDjGJ8
	Vh1cCWRJlT49JbVDuCJDEglpPgqpSnx4wP3dt528Fuaa5qnBF6fYb1EvT7hbog==
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
Subject: [PATCH net-next v11 04/10] net: phy: Create SFP phy_port before registering upstream
Date: Thu, 21 May 2026 14:10:32 +0200
Message-ID: <20260521121040.1199622-5-maxime.chevallier@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-290384-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,lunn.ch:email]
X-Rspamd-Queue-Id: 586295A4A5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When dealing with PHY-driven SFP, we create a phy_port representing the
SFP bus when we know we have such a bus.

We can move the port creation before registering the sfp upstream ops,
as long as we know the SFP bus is there. This will allow passing the
phy_port along with the upstream information to the SFP bus.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 43 ++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c2cdf1ae3542..301e9c365345 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1673,13 +1673,13 @@ static void phy_del_port(struct phy_device *phydev, struct phy_port *port)
 	phydev->n_ports--;
 }
 
-static int phy_setup_sfp_port(struct phy_device *phydev)
+static struct phy_port *phy_setup_sfp_port(struct phy_device *phydev)
 {
 	struct phy_port *port = phy_port_alloc();
 	int ret;
 
 	if (!port)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	port->parent_type = PHY_PORT_PHY;
 	port->phy = phydev;
@@ -1694,10 +1694,12 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
 	 * when attaching the port to the phydev.
 	 */
 	ret = phy_add_port(phydev, port);
-	if (ret)
+	if (ret) {
 		phy_port_destroy(port);
+		return ERR_PTR(ret);
+	}
 
-	return ret;
+	return port;
 }
 
 /**
@@ -1706,22 +1708,35 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
  */
 static int phy_sfp_probe(struct phy_device *phydev)
 {
+	struct phy_port *port = NULL;
 	struct sfp_bus *bus;
-	int ret = 0;
+	int ret;
 
-	if (phydev->mdio.dev.fwnode) {
-		bus = sfp_bus_find_fwnode(phydev->mdio.dev.fwnode);
-		if (IS_ERR(bus))
-			return PTR_ERR(bus);
+	if (!phydev->mdio.dev.fwnode)
+		return 0;
+
+	bus = sfp_bus_find_fwnode(phydev->mdio.dev.fwnode);
+	if (IS_ERR(bus))
+		return PTR_ERR(bus);
 
-		phydev->sfp_bus = bus;
+	phydev->sfp_bus = bus;
 
-		ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
-		sfp_bus_put(bus);
+	if (bus) {
+		port = phy_setup_sfp_port(phydev);
+		if (IS_ERR(port)) {
+			sfp_bus_put(bus);
+			phydev->sfp_bus = NULL;
+			return PTR_ERR(port);
+		}
 	}
 
-	if (!ret && phydev->sfp_bus)
-		ret = phy_setup_sfp_port(phydev);
+	ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
+	sfp_bus_put(bus);
+
+	if (ret && port) {
+		phy_del_port(phydev, port);
+		phy_port_destroy(port);
+	}
 
 	return ret;
 }
-- 
2.54.0


