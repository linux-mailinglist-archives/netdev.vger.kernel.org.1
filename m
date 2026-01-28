Return-Path: <netdev+bounces-254445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HUmAst2emmE6wEAu9opvQ
	(envelope-from <netdev+bounces-254445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:51:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFEEA8D68
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11E2D3056150
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CD2376486;
	Wed, 28 Jan 2026 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SEUmTiLu"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562C37474F
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633165; cv=none; b=Hgz4PvluU9qsKXRayajuWXl03YtZ5I3C2g8BFZlO346Jg6sVWR7GTXe1SRlvfEoaB6i30pR4e79mYyAFuyicM9x63kMlSodOffKtMYJ3QZSzq2d8QCr/aJXI+6+gIiVl5mFqRjyoLuLg/kbtxuGfNVY46y5oMpImr0La8/jfe9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633165; c=relaxed/simple;
	bh=8TVyC6x+LERylINnEFufkxpsszyKPPCV4NogcQE1PX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e++w2jVeifqmJMYsYvJJ4ClPWgB2RIhLpgl3BIO+6ubu983id1N1oa3vRW+3QtOifhDRHwSgy81AfVZZrfp+wfaJ4MizaEWjUnhMLYDcHPOfF9Fja0IYQm/M96xHx5zs17uWtneZpS83O//KnJyDg5xg5CnsxGv1OTrSHAX+yXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SEUmTiLu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B756C4E42308;
	Wed, 28 Jan 2026 20:46:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8CE816071F;
	Wed, 28 Jan 2026 20:46:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3FDC119A883A;
	Wed, 28 Jan 2026 21:45:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769633159; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=EfrB/TlHWZaN3FYrouByYYSXCqEx7CiilkYmV+/LR/M=;
	b=SEUmTiLugsrDI5cguJIBFmA3WAP1z80mXBa5V1pSDuxhEmMkjXUJF+NcZIH01LH6pKcU1X
	NnfW5FvT3hZEqS4rQ3k1VGJW33eghjxABpS6vvYa2Qq6a+cV3J5oQWBEEkiiqTepsE5xNe
	FTCjHOMG/IH7MeZupe/4GTFczmUIRw/YQ3xkAo7Q6f1q5HBUu+uX1yp0xJOJioiw1zl/hu
	9TYolcCn9EDOQAkhp7EDOHPPl4szbjbmrZwglwb+Zt0+rccWRwdYWsHAXfrP9bGFOzyViK
	mfWbnP3bShfpZpquLZSbElzO72Z5nsOZWaWlrWMEdjdhstCmP24Ok1t1X9aZyA==
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
Subject: [PATCH net-next v2 09/12] net: phy: phy_port: Store information about a MII port's occupancy
Date: Wed, 28 Jan 2026 21:45:22 +0100
Message-ID: <20260128204526.170927-10-maxime.chevallier@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-254445-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 7FFEEA8D68
X-Rspamd-Action: no action

MII phy_ports are not meant to be connected directly to a link partner.
They are meant to feed into some media converter devices, so far we only
support SFP modules for that.

We have information about what MII they can handle, however we don't
store anything about whether they are currently connected to an SFP
module or not. As phy_port aims at listing the front-facing ports, let's
store an "occupied" bit to know whether or not a MII port is currently
front-facing (i.e. there's no module in the SFP cage), or occupied (i.e.
there's an SFP module).

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 4 ++++
 drivers/net/phy/phylink.c    | 4 ++++
 include/linux/phy_port.h     | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b3125cf30bf3..9dba31b9cb86 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1636,6 +1636,8 @@ static int phy_sfp_connect_nophy(void *upstream)
 		}
 	}
 
+	phydev->sfp_bus_port->occupied = true;
+
 	/* we don't use phy_add_port() here as the module port isn't a direct
 	 * interface from the PHY, but rather an extension to the sfp-bus, that
 	 * is already represented by its own phy_port
@@ -1649,6 +1651,8 @@ static void phy_sfp_disconnect_nophy(void *upstream)
 {
 	struct phy_device *phydev = upstream;
 
+	phydev->sfp_bus_port->occupied = false;
+
 	if (phydev->attached_dev)
 		phy_link_topo_del_port(phydev->attached_dev, phydev->mod_port);
 
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 21af1dffa837..bb257e91cdf6 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -4047,6 +4047,8 @@ static int phylink_sfp_connect_nophy(void *upstream)
 		}
 	}
 
+	pl->sfp_bus_port->occupied = true;
+
 	pl->mod_port = port;
 
 	return 0;
@@ -4056,6 +4058,8 @@ static void phylink_sfp_disconnect_nophy(void *upstream)
 {
 	struct phylink *pl = upstream;
 
+	pl->sfp_bus_port->occupied = false;
+
 	if (pl->netdev)
 		phy_link_topo_del_port(pl->netdev, pl->mod_port);
 
diff --git a/include/linux/phy_port.h b/include/linux/phy_port.h
index 4e2a3fdd2f2e..8d4f20bfd9dd 100644
--- a/include/linux/phy_port.h
+++ b/include/linux/phy_port.h
@@ -51,6 +51,8 @@ struct phy_port_ops {
  * @is_mii: Indicates if this port is MII (Media Independent Interface),
  *          or MDI (Media Dependent Interface).
  * @is_sfp: Indicates if this port drives an SFP cage.
+ * @occupied: Indicates if this port feeds into an another component that has
+ *	      a front-facing interface.
  */
 struct phy_port {
 	u32 id;
@@ -71,6 +73,7 @@ struct phy_port {
 	unsigned int active:1;
 	unsigned int is_mii:1;
 	unsigned int is_sfp:1;
+	unsigned int occupied:1;
 };
 
 struct phy_port *phy_port_alloc(void);
-- 
2.49.0


