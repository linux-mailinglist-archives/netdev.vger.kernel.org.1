Return-Path: <netdev+bounces-275021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDXZLui1z2l1zgYAu9opvQ
	(envelope-from <netdev+bounces-275021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 14:43:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BFB39425C
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 14:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E18B330BC40A
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 12:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC6C39EF3F;
	Fri,  3 Apr 2026 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pZqw/CGE"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE52B39B942;
	Fri,  3 Apr 2026 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775219910; cv=none; b=c18VPz94uV1lARn9z+yscPhJH5HdQ8WyHVVnn7xvpcW7gLCoUkofWaJQ/H1E1vBbC49OMvqjbvPJwjI123yba23PfMlld2ND68vEWhYIX7/2JIFHlmCTX11c0Z8ZA5WwI5/ulNi+IOb/KUWYPfqbcdkto3qLwhvwvgmSKGf1ubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775219910; c=relaxed/simple;
	bh=rRJ72v6wKYliD1sOn+BsxD6q3fY47+OlL6QjOuqE6OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUX5Cu46h+ETtBgVbdTCs0Rvh0BZO5lwEOCnYLqbOoVrFJQ+JKMVv4V2CZZTGFqcaOGNkfD+X42nxiU3Occgl4CcIwQa8ORsaoE68be/yJm80KD5Rs0HOlH0HMxRsV8Xv3e82/WdtFgCYquE+b7KNWNdD8zg98+Te2PTPhZikuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pZqw/CGE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A0BDE1A3128;
	Fri,  3 Apr 2026 12:38:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7593B603C1;
	Fri,  3 Apr 2026 12:38:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B5F2104500CA;
	Fri,  3 Apr 2026 14:38:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775219906; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=bOFXYj53zoGGIpSXvOyfbddgtLvAOthzQGTdXfDSQac=;
	b=pZqw/CGERnuO1GSB2SXCacDiKoSbCUk/KSK7Y0DH17eOXIoTE36Aa6sl6RzutTBYeubai5
	QgfqaTS2NG9xtOPnrHeG/XAGol1oMPEmJPWVhYtXBLD9bgPmI59IlMItq20XwpfgqvRMS0
	BJlbbCgssL2oeSIjIvZ75wYOPMMi6MoXcG9RoT/C7LnI9r/Gmzel079chxHfFyHmMDVZet
	BigNXb9kcS+ZiujOPfrDPRfAYdJ1Lyv9YDmdbQwmbHWK/6nv86vxNAOMUH4H72zCTpWh9T
	DcRTWFWy2sHLCgBeBNLHSCEAWNSs1bhhsZMFO27dIuxZPr7Mbx+pPTcHXd2Isw==
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
Subject: [PATCH net-next v9 06/10] net: phylink: Represent PHY-less SFP modules with phy_port
Date: Fri,  3 Apr 2026 14:37:50 +0200
Message-ID: <20260403123755.175742-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
References: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-275021-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18BFB39425C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Let phylink handle the phy_port for PHY-less modules, and register it to
the topology.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c | 76 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0728dd4c4d56..8d57c95f877a 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -96,6 +96,7 @@ struct phylink {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
 	u8 sfp_port;
 	struct phy_port *sfp_bus_port;
+	struct phy_port *mod_port;
 
 	struct eee_config eee_cfg;
 
@@ -1790,10 +1791,15 @@ static int phylink_create_sfp_port(struct phylink *pl)
 
 	ret = phy_link_topo_add_port(pl->netdev, port);
 	if (ret)
-		phy_port_destroy(port);
-	else
-		pl->sfp_bus_port = port;
+		goto out_destroy_port;
+
+	pl->sfp_bus_port = port;
+
+	return 0;
 
+out_destroy_port:
+	phy_port_destroy(port);
+	pl->sfp_bus_port = NULL;
 	return ret;
 }
 
@@ -3924,14 +3930,65 @@ static void phylink_sfp_module_remove(void *upstream)
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
@@ -3940,7 +3997,16 @@ static int phylink_sfp_module_start(void *upstream)
 	if (!pl->sfp_may_have_phy)
 		return 0;
 
-	return phylink_sfp_config_optical(pl);
+	ret = phylink_sfp_config_optical(pl);
+	if (ret)
+		goto del_mod_port;
+
+	return 0;
+
+del_mod_port:
+	phylink_del_sfp_mod_port(pl);
+
+	return ret;
 }
 
 static void phylink_sfp_module_stop(void *upstream)
@@ -3950,6 +4016,8 @@ static void phylink_sfp_module_stop(void *upstream)
 	/* If this SFP module has a PHY, stop it. */
 	if (pl->phydev)
 		phy_stop(pl->phydev);
+	else
+		phylink_del_sfp_mod_port(pl);
 }
 
 static void phylink_sfp_link_down(void *upstream)
-- 
2.49.0


