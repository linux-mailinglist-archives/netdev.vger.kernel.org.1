Return-Path: <netdev+bounces-256388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPPQCoEygml5QQMAu9opvQ
	(envelope-from <netdev+bounces-256388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:38:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6701DDCE3F
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A9E330691C7
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EFC3D649D;
	Tue,  3 Feb 2026 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hk23vlIG"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AEC3D6496
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139758; cv=none; b=HGHNpsR9Tf2DtcJKuFE6fQmtjx56L0C0XjfoJe/FBfE5eSOK9fXkBgiK3v9yRCCu94uM4/JhzNLIweCu3tGS2GJwWPbSlpfDge9wkPTiDo2y67k+haKgMwTWMAH/iEhyGYVxEo+gIWvGgxe/VlFIbOUXyuzAYqVIM9bZOy0lp38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139758; c=relaxed/simple;
	bh=hxU9uTphzVdXJ546kTYHYBQ7irsclrcINT2p/qgcf/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqWA1zHUxF4L4SjOBYFkDTvWr2RZjLY78gvIXq4QEtQtU5dSY2Tc3nINMXAOQbQr+akFkwkkCdgagITP+FC5tsRGvMZNl0ahEGaMFmsOb/zUlMgnHYmElPfvpnaq8GGQWGHcIvw/hAKVshRWwAizG+cunLabLldAcF9/3kQOaO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hk23vlIG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1F70F1A2BC4;
	Tue,  3 Feb 2026 17:29:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7D3260728;
	Tue,  3 Feb 2026 17:29:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CDFB119A88FB;
	Tue,  3 Feb 2026 18:29:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770139754; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=bRI683hcvnEM35da1o7ilYv7pwt3yyezbBrMJM8t6dQ=;
	b=Hk23vlIGaKQSCFCsWMYeTx/2kVHZslTepJTqcO56IlWaH+srUMTvsUDMyrJJahalVHFqyh
	IZGJzPAfQouVNY2hFBxA8ovHD4vCJ/gIYvz08dRwWgZb6gAXHcC4xaauQSe6CFnxAujlYi
	5Yl6SeXZNIdA45j/5VdkS0fasTNXPmi6c5u88x6V9ox7uPwi9WGDBVyKSaJdo2dquH7mCP
	VQJCfCNVmSLNVV/bBHIQsyVQhAJdbmjyCCshZiXZsmP7aGGsCa3lH6CxpvWHDqm3piX9zL
	DuLpLBQmovPrnbGc8+8rdO0FGxsH2eCL+H5y2FUnzPTHQLjUYz2spv8HMZbNtg==
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
Subject: [PATCH net-next v4 09/13] net: phylink: Represent PHY-less SFP modules with phy_port
Date: Tue,  3 Feb 2026 18:28:33 +0100
Message-ID: <20260203172839.548524-10-maxime.chevallier@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256388-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6701DDCE3F
X-Rspamd-Action: no action

Let phylink handle the phy_port for PHY-less modules, and register it to
the topology.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c | 76 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 7a07de1d42bb..d65fa6cd1ebb 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -96,6 +96,7 @@ struct phylink {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
 	u8 sfp_port;
 	struct phy_port *sfp_bus_port;
+	struct phy_port *mod_port;
 
 	struct eee_config eee_cfg;
 
@@ -1787,13 +1788,31 @@ static int phylink_create_sfp_port(struct phylink *pl)
 	else
 		pl->sfp_bus_port = port;
 
+	if (pl->mod_port) {
+		ret = phy_link_topo_add_port(pl->netdev, pl->mod_port);
+		if (ret)
+			goto out_bus_port;
+	}
+
+	return 0;
+out_bus_port:
+	phy_link_topo_del_port(pl->netdev, port);
+	phy_port_destroy(port);
 	return ret;
 }
 
 static void phylink_destroy_sfp_port(struct phylink *pl)
 {
-	if (pl->netdev && pl->sfp_bus_port)
-		phy_link_topo_del_port(pl->netdev, pl->sfp_bus_port);
+	if (pl->netdev) {
+		if (pl->sfp_bus_port)
+			phy_link_topo_del_port(pl->netdev, pl->sfp_bus_port);
+
+		/* Only remove it from the topology, it will be destroyed at
+		 * module removal.
+		 */
+		if (pl->mod_port)
+			phy_link_topo_del_port(pl->netdev, pl->mod_port);
+	}
 
 	if (pl->sfp_bus_port)
 		phy_port_destroy(pl->sfp_bus_port);
@@ -3919,14 +3938,65 @@ static void phylink_sfp_module_remove(void *upstream)
 	phy_interface_zero(pl->sfp_interfaces);
 }
 
+static int phylink_add_sfp_mod_port(struct phylink *pl)
+{
+	const struct sfp_module_caps *caps;
+	struct phy_port *port;
+	int ret = 0;
+
+	if (!pl->sfp_bus_port)
+		return 0;
+
+	/* Create mod port */
+	port = phy_port_alloc();
+	if (!port)
+		return -ENOMEM;
+
+	port->active = true;
+
+	caps = sfp_get_module_caps(pl->sfp_bus);
+
+	phy_caps_linkmode_filter_ifaces(port->supported, caps->link_modes,
+					pl->sfp_bus_port->interfaces);
+
+	if (pl->netdev) {
+		ret = phy_link_topo_add_port(pl->netdev, port);
+		if (ret) {
+			phy_port_destroy(port);
+			return ret;
+		}
+	}
+
+	pl->mod_port = port;
+
+	return 0;
+}
+
+static void phylink_del_sfp_mod_port(struct phylink *pl)
+{
+	if (!pl->mod_port)
+		return;
+
+	if (pl->netdev)
+		phy_link_topo_del_port(pl->netdev, pl->mod_port);
+
+	phy_port_destroy(pl->mod_port);
+	pl->mod_port = NULL;
+}
+
 static int phylink_sfp_module_start(void *upstream)
 {
 	struct phylink *pl = upstream;
+	int ret;
 
 	/* If this SFP module has a PHY, start the PHY now. */
 	if (pl->phydev) {
 		phy_start(pl->phydev);
 		return 0;
+	} else {
+		ret = phylink_add_sfp_mod_port(pl);
+		if (ret)
+			return ret;
 	}
 
 	/* If the module may have a PHY but we didn't detect one we
@@ -3945,6 +4015,8 @@ static void phylink_sfp_module_stop(void *upstream)
 	/* If this SFP module has a PHY, stop it. */
 	if (pl->phydev)
 		phy_stop(pl->phydev);
+	else
+		phylink_del_sfp_mod_port(pl);
 }
 
 static void phylink_sfp_link_down(void *upstream)
-- 
2.49.0


