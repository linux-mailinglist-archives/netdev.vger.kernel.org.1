Return-Path: <netdev+bounces-255611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOgCFb9tf2nNqQIAu9opvQ
	(envelope-from <netdev+bounces-255611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:14:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B956CC644D
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBD6B300F9EA
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA31231A21;
	Sun,  1 Feb 2026 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OUT8vVDU"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16269210F59;
	Sun,  1 Feb 2026 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769958799; cv=none; b=Sn04W3/f8Sdjusd4VHpHzXVZrwXGRo5FesJCTjyp34wAzz6mZ0fwVg6UycGjePXevFfam0gmvHXwQI2YHDs8ooc8+/jaYe10fZ19EYSGR/pROliU3PJvHaX/EkQNL4KDVS+/WZQzrhHixTN64eSy00Edf71/o5eeJWCN1bf7Uu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769958799; c=relaxed/simple;
	bh=uOT0ACkkaQE7Tu05Lo6cceFSzMxC66TIiG83sESc9b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIlz0p/tKmyQXo1bMMdMD/ZgKcv6dCIx9n67Ml21V5cr+m1X9ro7bDIiHBUkjoK88XK7OTY4Gz8ggcC/4DxxFKUE52Ykv8V6RpGsnJYGBHLr/Fi0AQyKf6AhwuTt4VhaNa1xwPtIxM1XX2hHkgtMsK4yblGKfNUSUnPELbq9bJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OUT8vVDU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0EE991A2B84;
	Sun,  1 Feb 2026 15:13:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D8FD760720;
	Sun,  1 Feb 2026 15:13:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99AE1119A88EE;
	Sun,  1 Feb 2026 16:13:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769958789; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=l+Rp6Yl7ITjibk5awHjn/5hIqdMq5jHRP74fmk55B4Y=;
	b=OUT8vVDUYupKBZic8J6Suw2qME6++37jLwBg6mfTDbIIA2rOAUBOFyqqc97lmjY9fmzPvo
	zeYMmXj0pqQAKSmllolwow++BlaoHEVdTHHOdF5ZD2iLRuRQh5soeOg+Z1xMgCHR3LewS+
	0fk7My0Pe/MIu3CWV/O2YD9UjjV0DCqtVKeO4j8zZDTm7K2ouMmK00igwfFeR2DjEH/rff
	PaL6FfsgXr7InZUO5bbRH4fwaU4eo1oflwfoIJvwGtWtYY1j0a/4DdjSkzO/qfd0FVukuN
	yon5zkrnlMPCT4DoxiKQzo5G38MGGwieCA++6QmHkwgIiRATMBbZMuD2OKnFzA==
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
Subject: [PATCH net-next v3 01/11] net: phy: phy_port: Correctly recompute the port's linkmodes
Date: Sun,  1 Feb 2026 16:12:38 +0100
Message-ID: <20260201151249.642015-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260201151249.642015-1-maxime.chevallier@bootlin.com>
References: <20260201151249.642015-1-maxime.chevallier@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-255611-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: B956CC644D
X-Rspamd-Action: no action

a PHY-driven phy_port contains a 'supported' field containing the
linkmodes available on this port. This is populated based on :
 - The PHY's reported features
 - The DT representation of the connector
 - The PHY's attach_mdi() callback

As these different attrbution methods work in conjunction, the helper
phy_port_update_supported() recomputes the final 'supported' value based
on the populated mediums, linkmodes and pairs.

However this recompute wasn't correctly implemented, and added more
modes than necessary by or'ing the medium-specific modes to the existing
support. Let's fix this and properly filter the modes.

Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_port.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c
index ec93c8ca051e..6c1d3c487b13 100644
--- a/drivers/net/phy/phy_port.c
+++ b/drivers/net/phy/phy_port.c
@@ -117,12 +117,6 @@ void phy_port_update_supported(struct phy_port *port)
 	unsigned long mode;
 	int i;
 
-	for_each_set_bit(i, &port->mediums, __ETHTOOL_LINK_MEDIUM_LAST) {
-		linkmode_zero(supported);
-		phy_caps_medium_get_supported(supported, i, port->pairs);
-		linkmode_or(port->supported, port->supported, supported);
-	}
-
 	/* If there's no pairs specified, we grab the default number of
 	 * pairs as the max of the default pairs for each linkmode
 	 */
@@ -132,6 +126,19 @@ void phy_port_update_supported(struct phy_port *port)
 			port->pairs = max_t(int, port->pairs,
 					    ethtool_linkmode_n_pairs(mode));
 
+	if (linkmode_empty(port->supported)) {
+		for_each_set_bit(i, &port->mediums,
+				 __ETHTOOL_LINK_MEDIUM_LAST) {
+			__ETHTOOL_DECLARE_LINK_MODE_MASK(med_supported) = {0};
+
+			phy_caps_medium_get_supported(med_supported, i,
+						      port->pairs);
+			linkmode_or(supported, supported, med_supported);
+		}
+
+		linkmode_and(port->supported, port->supported, supported);
+	}
+
 	/* Serdes ports supported through SFP may not have any medium set,
 	 * as they will output PHY_INTERFACE_MODE_XXX modes. In that case, derive
 	 * the supported list based on these interfaces
-- 
2.49.0


