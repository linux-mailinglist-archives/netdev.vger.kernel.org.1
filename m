Return-Path: <netdev+bounces-257084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGseOrphhGng2gMAu9opvQ
	(envelope-from <netdev+bounces-257084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:24:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA45AF09CA
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 887E03010621
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 09:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96398393DCA;
	Thu,  5 Feb 2026 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LrnRRMgk"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290B83939D7
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283422; cv=none; b=dn+bsMrMge3U4WSQ/Rl5f1cW0zAkUvHT1qkPJyJrQpTzmdNRxM7aK6HJg5vTN77PLju8W1xovIdRla9p3n47SNe84lRjZtQHwiF0ujCh69kfcH1qjCBfWnHLR1jf6CfRQ7ASlmQdna1/fIwu5jkMkJkTQdeassNiZBCblliClUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283422; c=relaxed/simple;
	bh=mWyMx4Wb/HCw51vDYbHGsY4S6C9v30+HtBdi1q1SCSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOXc9jXuuEPikqz773RKQnbUF8dV7mH+nLMnFXmOXikdkxVgyIvcL8yQ4jGde8Aa5s0Bv+hQB5gOgb7jQioDOtxZzvLSIy7BLKtTiPCYtCtRIyWP0rLnqYlrgq/e+gT7OsY34ZYK0BJZWccN0MeKKRQPWv2amhVyCbMaeFN2fAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LrnRRMgk; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 656A5C243A8;
	Thu,  5 Feb 2026 09:23:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 60D4D606FD;
	Thu,  5 Feb 2026 09:23:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12E66119A88EE;
	Thu,  5 Feb 2026 10:23:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770283418; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=KecJRPe2Bv70TIJpdknGkVxhofD7qopvizBIlkrUTDs=;
	b=LrnRRMgkbQJF7Am5qND1WcrHoeGfJnm0S5TpuJAoalZ9D17tQ3TU2q2VC9/jlFN19JgYNM
	0aH6groa+FXi+jcxzsgR4sXaUwzNDFn036DLviycVf1ON44Vby3Hqg738778ja4jj9pu8e
	7V0UdZK++BWy55dJUdvBxHuhyMHSd5cY4xWN5bW8HVSuqbhRVB2QKx3Qciqe6sIQ6mBxBX
	dOYJEncGL+kjt97q08eGs1hUNy8lz+CtsGd9VopqeWnLoglf30bwxOSbOBY9vkE/0FAgHq
	ukvJxZEtyOrgK4k4hPxstOL9Ls7lcQctC4BoLO2iCNWBHK+BCBEe5HbJCKC2Ow==
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
Subject: [PATCH net-next v5 02/13] net: phy: phy_port: Cleanup the of-parsing logic for phy_port
Date: Thu,  5 Feb 2026 10:23:05 +0100
Message-ID: <20260205092317.755906-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260205092317.755906-1-maxime.chevallier@bootlin.com>
References: <20260205092317.755906-1-maxime.chevallier@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-257084-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA45AF09CA
X-Rspamd-Action: no action

We don't need to maintain a mediums bitfield, let's drop it and drop a
bogus check for empty mediums, as we already check it above.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_port.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c
index ec93c8ca051e..a269e9ea12c4 100644
--- a/drivers/net/phy/phy_port.c
+++ b/drivers/net/phy/phy_port.c
@@ -53,7 +53,7 @@ struct phy_port *phy_of_parse_port(struct device_node *dn)
 	enum ethtool_link_medium medium;
 	struct phy_port *port;
 	const char *med_str;
-	u32 pairs = 0, mediums = 0;
+	u32 pairs = 0;
 	int ret;
 
 	ret = fwnode_property_read_string(fwnode, "media", &med_str);
@@ -85,17 +85,12 @@ struct phy_port *phy_of_parse_port(struct device_node *dn)
 		return ERR_PTR(-EINVAL);
 	}
 
-	mediums |= BIT(medium);
-
-	if (!mediums)
-		return ERR_PTR(-EINVAL);
-
 	port = phy_port_alloc();
 	if (!port)
 		return ERR_PTR(-ENOMEM);
 
 	port->pairs = pairs;
-	port->mediums = mediums;
+	port->mediums = BIT(medium);
 
 	return port;
 }
-- 
2.49.0


