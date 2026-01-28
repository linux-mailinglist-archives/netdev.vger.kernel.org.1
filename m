Return-Path: <netdev+bounces-254444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAAsGdx2emmE6wEAu9opvQ
	(envelope-from <netdev+bounces-254444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:51:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCBCA8D77
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEED730564ED
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAE0376482;
	Wed, 28 Jan 2026 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q1s+mY2T"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676837474C;
	Wed, 28 Jan 2026 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633165; cv=none; b=CEiqHRTpzFrFtYEOyVe4oP8jMsQF6meTUm1ZyOzBN6axzfSkHkIMuvl8HeSh9QKZ0pdwQapkLqX0s/Ce2aD4N5gb9xYG0awoM2IqJvBYz7txDMBvTHKwIEiAc+GRJjJDykzV0PCUfjZrMLJiBqXBnBn3sa9HG2CK+2e6gVb8vN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633165; c=relaxed/simple;
	bh=07iRNpUNsbBPH6Szj7tXNtrkE9omvubg/HSfMgsnHeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbolO32qVZBW03EAHC9byY19cJIWHc5C+IcQ8JqFN+8OrFiorT/2JW3bAakftdwLvhonzl6INQk/P/HMhlWHKWobrhG8NhjxvnPWSidL3hNVYwiqZkOURMGWNM7359IfkNjedlzDecwZPGcUaU3aaTg+gW+9f5XF1JK9B6P9Vmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q1s+mY2T; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 26A77C211F2;
	Wed, 28 Jan 2026 20:46:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7B2C56071F;
	Wed, 28 Jan 2026 20:45:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 730D3119A8839;
	Wed, 28 Jan 2026 21:45:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769633157; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=aSlo6fpytFPeRO/3rcUa8O6Tp4iGzNbOtCMyHVTaty0=;
	b=Q1s+mY2Ton5mlNsrOlHjSulUZrAlhlKD5obe7wcJU9FHm+FF2Gx0KfT40BW+gK146k/Nvk
	YxLITH/mpbifJbLiExWSboq85psYkq7XNTuDBS+GZGBJ7rB3E9pOYcIwK/DVNuKJaOBVHk
	fMIZ8nzAg7jwYFckHaH4lkVH1YMirG+Keq/NYfD69t8A06AJUJEkIbFyKR6BBOIpHfle+k
	7u5NRTOurPNoZWpStm9SQcgHTeMyAGZCasKgEQ/7f6g+Q4FzATyrfQPBXeUYwevz+Zc2iv
	vmyi7+v9ZInaZ954LX6xrmnaPIvWCKsf38QXiET3RZ+mZ02UZRl9S0esWns1/w==
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
Subject: [PATCH net-next v2 08/12] net: phylink: Represent PHY-less SFP modules with phy_port
Date: Wed, 28 Jan 2026 21:45:21 +0100
Message-ID: <20260128204526.170927-9-maxime.chevallier@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-254444-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDCBCA8D77
X-Rspamd-Action: no action

Let phylink handle the phy_port for PHY-less modules, and register it to
the topology.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c | 71 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 310af33d49a0..21af1dffa837 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -96,6 +96,7 @@ struct phylink {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
 	u8 sfp_port;
 	struct phy_port *sfp_bus_port;
+	struct phy_port *mod_port;
 
 	struct eee_config eee_cfg;
 
@@ -1786,13 +1787,31 @@ static int phylink_create_sfp_port(struct phylink *pl)
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
@@ -3998,6 +4017,52 @@ static void phylink_sfp_disconnect_phy(void *upstream,
 	phylink_disconnect_phy(upstream);
 }
 
+static int phylink_sfp_connect_nophy(void *upstream)
+{
+	const struct sfp_module_caps *caps;
+	struct phylink *pl = upstream;
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
+static void phylink_sfp_disconnect_nophy(void *upstream)
+{
+	struct phylink *pl = upstream;
+
+	if (pl->netdev)
+		phy_link_topo_del_port(pl->netdev, pl->mod_port);
+
+	phy_port_destroy(pl->mod_port);
+	pl->mod_port = NULL;
+}
+
 static const struct sfp_upstream_ops sfp_phylink_ops = {
 	.attach = phylink_sfp_attach,
 	.detach = phylink_sfp_detach,
@@ -4009,6 +4074,8 @@ static const struct sfp_upstream_ops sfp_phylink_ops = {
 	.link_down = phylink_sfp_link_down,
 	.connect_phy = phylink_sfp_connect_phy,
 	.disconnect_phy = phylink_sfp_disconnect_phy,
+	.connect_nophy = phylink_sfp_connect_nophy,
+	.disconnect_nophy = phylink_sfp_disconnect_nophy,
 };
 
 /* Helpers for MAC drivers */
-- 
2.49.0


