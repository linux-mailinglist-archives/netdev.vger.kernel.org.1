Return-Path: <netdev+bounces-271452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEVXMUSbw2myrwQAu9opvQ
	(envelope-from <netdev+bounces-271452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:22:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB53A3215A9
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 324E03054F48
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCD539C639;
	Wed, 25 Mar 2026 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qza87Pjb"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC91039B95C
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774426813; cv=none; b=lDIXRZfm92Hq3VM8jjH2i2It++x/XBI9/5uN9LqY/JcDqLlZ5RLoUAtVzBjzAYinlovtY61rr2k+4NCfymnuZcacKGJ2WftdVqlB5jUcoGaZIgw3a0Wu7MQuM/axJfocWWBxop4bkjeaGTNcrs4j1R0j5hQt6qpeAYC3pfKDniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774426813; c=relaxed/simple;
	bh=P89XoIX5xTpIgcPAy9Rqn11WzqpcB75XjYG9hlbzdZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eg/nvKRAO6pRIprOB3g/l+L8SxUA87SzII6T1P7a20OSIEmOMANMsbXXUkKldBrpIGgHijt034aVjlCFl74h2wHAUhdQDITbXEB8tjmpBxopy7xVeQdy/nMfPxfA65CnSTAsTyb63YnGaQQ7FmSDCfoamx5b+zGh+pDeUFa1gm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qza87Pjb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DACAD1A2FDF;
	Wed, 25 Mar 2026 08:20:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5CFC4601A1;
	Wed, 25 Mar 2026 08:20:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4CC3410451368;
	Wed, 25 Mar 2026 09:20:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774426807; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Wnzb92n8n6jzst7oG6QZziN8KevfYfIOW5TWQ8o8SBg=;
	b=Qza87Pjb55QQGF9Sjsu3sV1oOTHvr4cUtuBr76KGiL00Uava9+LPKqvFznYITdtaJkfTFI
	q7rxu16lcZOTk2QGb2wlLD5GQI0mgR6xAx8UGqend+5JoH6ZjPrCHUmEl3t7v7P3bVe81a
	LuXxunGu8hADro75FYjEf3dlYxYr3hZ6OPSUjvsvCD+LJhW2IHADq4xvyuA4ZFGhnOTE0B
	Co5mZhXgvGt57i5ZU3KNCyCGvM1HYb2FNIxPyBdbw+DqlOxuImIsNqVrUMRdZW2ODch/QO
	5+lIDGxzq0cayI5YgRZF9wpkw6fuEiF3UNESARNR3zS4yodFH8HALa5DpKoU+w==
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
Subject: [PATCH net-next v8 04/10] net: phy: Create SFP phy_port before registering upstream
Date: Wed, 25 Mar 2026 09:19:29 +0100
Message-ID: <20260325081937.571115-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260325081937.571115-1-maxime.chevallier@bootlin.com>
References: <20260325081937.571115-1-maxime.chevallier@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-271452-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB53A3215A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When dealing with PHY-driven SFP, we create a phy_port representing the
SFP bus when we know we have such a bus.

We can move the port creation before registering the sfp upstream ops,
as long as we know the SFP bus is there. This will allow passing the
phy_port along with the upstream information to the SFP bus.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 42 ++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0edff47478c2..a5400f01fe17 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1665,13 +1665,13 @@ static void phy_del_port(struct phy_device *phydev, struct phy_port *port)
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
@@ -1686,10 +1686,12 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
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
@@ -1698,22 +1700,34 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
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
2.49.0


