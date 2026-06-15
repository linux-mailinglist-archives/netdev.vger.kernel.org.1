Return-Path: <netdev+bounces-299510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UvB8AlUdMGqcNwUAu9opvQ
	(envelope-from <netdev+bounces-299510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:42:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBDA687CCB
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:42:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=llxmBf5o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299510-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299510-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A28313081098
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95037407CF5;
	Mon, 15 Jun 2026 15:39:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025940757B
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:39:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537982; cv=none; b=F71vzvMbhe6CGZxi96/zGpfemFBzL5n+zXPhqXVvRlRkTm/rz+PB9GenA324E26P+KQAT9ISdrhxZKQ1CK4xknirFjY72MiWtmi9yvuCETN0BNe3Hf3ej1Xw9EPA6xCZsmPMmcLwRSSFp7t6WwDzLIA1bU3Za5h2dzzwI1ShQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537982; c=relaxed/simple;
	bh=MpiyDkp1X53C98IvLAeBokmGvdAtST/aNJy9XBCWoys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLEOWRavgFJF1RgBPIIrjyiWNYIf64pCignxRI8N21JkjPd48sCJFeu7jptE5qk2T4B+ViY5ToK/HyyDGfpQ/iTmLRE5qfAKCpVraSzyZS7bW6K24HAFgGo1gIG8cuoq+U01pMltNEm+VKkjU47Orm66wwa4b3tmVZMCYvWrCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=llxmBf5o; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 244E9C51474;
	Mon, 15 Jun 2026 15:39:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EF88960015;
	Mon, 15 Jun 2026 15:39:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2C3A106C9731;
	Mon, 15 Jun 2026 17:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781537978; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=HJSj0+hWeYwlZOA+WqPDczY1e7Nz+sg4LAnrwkSTI20=;
	b=llxmBf5oEBeXzwcoiXzX+OKJpmbUpcXDkvV9kQemUjNZEp/pzFwsVu8Q+KUEu6YePgSCc4
	ferR5B8TpRalYbyI6xO7NGn0Me20aw3ALPV4pW46tgVRfWFU7LPsNH/jrTmCNurM5NIIHX
	JJeaGo0fb4g3IRk1kbpQBoIk6EodmJ5CRUyv9EpQnb51w4eZTcwQF4NILTWHl59MN0eeNx
	szYmbGQJXGxMQ31R7s1EavokFLUz+/SyLGAZcI3HUh45RXnc8pZ4TN6knRGQlt1LmVblOE
	RnEirHlmWGL3DPwO95HIYUfPl4hGdW5CYxMHJvaFUQ3Y4gjHNdpE1z/ATvQLdA==
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
Subject: [PATCH net-next v12 07/10] net: phy: phy_link_topology: Add a helper to retrieve ports
Date: Mon, 15 Jun 2026 17:39:03 +0200
Message-ID: <20260615153907.862987-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615153907.862987-1-maxime.chevallier@bootlin.com>
References: <20260615153907.862987-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299510-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:andrew@lunn.ch,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:christophe.leroy@csgroup.eu,m:herve.codina@bootlin.com,m:f.fainelli@gmail.com,m:vladimir.oltean@nxp.com,m:kory.maincent@bootlin.com,m:kabel@kernel.org,m:o.rempel@pengutronix.de,m:nicveronese@gmail.com,m:horms@kernel.org,m:mwojtas@chromium.org,m:romain.gantois@bootlin.com,m:daniel@makrotopia.org,m:dimitri.fedrau@liebherr.com,m:frank.wunderlich@linux.dev,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BBDA687CCB

In order to allow netlink access to phy_ports, let's add a helper to
retrieve them. When handling a port coming from phy_link_topology, the
caller must hold rtnl until it's done with it.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 include/linux/phy_link_topology.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
index 296ee514ba46..95629112204e 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -13,6 +13,7 @@
 
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 
 struct xarray;
 struct phy_device;
@@ -71,6 +72,20 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
 	return NULL;
 }
 
+static inline struct phy_port *
+phy_link_topo_get_port(struct net_device *dev, u32 port_id)
+{
+	struct phy_link_topology *topo = dev->link_topo;
+
+	ASSERT_RTNL();
+
+	if (!topo)
+		return NULL;
+
+	/* Caller must hold RTNL while handling the phy_port */
+	return xa_load(&topo->ports, port_id);
+}
+
 #else
 static inline int phy_link_topo_add_phy(struct net_device *dev,
 					struct phy_device *phy,
@@ -100,6 +115,12 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
 {
 	return NULL;
 }
+
+static inline struct phy_port *
+phy_link_topo_get_port(struct net_device *dev, u32 port_id)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __PHY_LINK_TOPOLOGY_H */
-- 
2.54.0


