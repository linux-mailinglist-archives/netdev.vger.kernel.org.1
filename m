Return-Path: <netdev+bounces-253890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J2VLb/BeGmltAEAu9opvQ
	(envelope-from <netdev+bounces-253890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:46:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B1695144
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E3043011B49
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F70C35DD1E;
	Tue, 27 Jan 2026 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YBc3+5Ug"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9235E55F;
	Tue, 27 Jan 2026 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521369; cv=none; b=dNQSHnVYrQGwMTxq9fpDnnqmpaKD6wlSpoG9r6dETfPI1I8pJ8yYf8+SB02aa9wWoEGlva8fltwIyGdkcqJSbz8SEVeLL/Qsslqyn40tqBavNCnV+bboSJ5db9eexjTMnC7WMD8Wn6vvzPAuvKx9QC/N6KWrxQuBH++7PcAv+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521369; c=relaxed/simple;
	bh=eaH4DCg8PG4Qegz0pzNo2jDRbz5YV59l7hffXKKyWVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSIp354Z/AsEgoT0zIeZNu8QFVCyL7LOviyYoA5OV2Yi10H1jAnkLw3hrEFD43HeWsbfvsMKRWn0r7I2wd/kFw96q6Qmtmc7NXjATwWYAqmOG6R69VEXt0R+9t0iU6+0+ET+mJCVCllz1+YMasoyu6q8X3zQANkUikhm94yCz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YBc3+5Ug; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9A4A14E422D2;
	Tue, 27 Jan 2026 13:42:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CAA9606F5;
	Tue, 27 Jan 2026 13:42:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07AB0119A8695;
	Tue, 27 Jan 2026 14:42:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769521365; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=H9jO5cGzIFudrj2fBUC0gHtKPdipIN1zDR03sFJ/icQ=;
	b=YBc3+5UgxfAtJlCe0ul8djtlz0fzu18HWByJcAncmqIZ8hzk6Nt+PzFIq3q8unte4P2/LP
	KZHnwuvug7j4HpsU5Norfgr1SP/a4wpF9Aem2Wj6NCcvTXkuWrN3xFToujZ6Hh1NFBliN9
	2M++ojZcRl3z7iKTTHcQV3pa5J3uPqXEfHNC0z7KAZl76OvFxTCBx2U0wIBQVVpNSCfOfF
	4L+RKOsxILumhdtyDZQUvQbWL0e6T8C75+KSe8j7EZtWfEx2z0On08xaarpmp8xBajGGgJ
	nLRoB/W0busmPJXgdIwfAj7ZEdI+qhMJx3JPtWB24/MHB5PVjsJcDr3yK92/1Q==
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
Subject: [PATCH net-next 11/13] net: phy: store phy_modes in a static array
Date: Tue, 27 Jan 2026 14:41:59 +0100
Message-ID: <20260127134202.8208-12-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-253890-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80B1695144
X-Rspamd-Action: no action

The phy_modes() helper provided by include/linux/phy.h returns the name of
a phy_interface_t value.

As it may be used by callers that don't depend on PHYLIB, it's a static
inline function.

We want to report using netlink the phy_interface_t types that may be
accessible on a phy_port, especially for SFP cages. We need access to
that array of phy_interface_t names, let's therefore store it into a
dedicated array in net/ethtool/common.c. This is part of CONFIG_NET, so
it's accessible even without dependency on PHYLIB.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 include/linux/phy.h  | 84 +++-----------------------------------------
 net/ethtool/common.c | 44 +++++++++++++++++++++++
 2 files changed, 49 insertions(+), 79 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index dc788ae4da64..cf607c1a5127 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -199,6 +199,8 @@ static inline void phy_interface_set_rgmii(unsigned long *intf)
 	__set_bit(PHY_INTERFACE_MODE_RGMII_TXID, intf);
 }
 
+extern const char phy_interface_names[][ETH_GSTRING_LEN];
+
 /**
  * phy_modes - map phy_interface_t enum to device tree binding of phy-mode
  * @interface: enum phy_interface_t value
@@ -209,86 +211,10 @@ static inline void phy_interface_set_rgmii(unsigned long *intf)
  */
 static inline const char *phy_modes(phy_interface_t interface)
 {
-	switch (interface) {
-	case PHY_INTERFACE_MODE_NA:
-		return "";
-	case PHY_INTERFACE_MODE_INTERNAL:
-		return "internal";
-	case PHY_INTERFACE_MODE_MII:
-		return "mii";
-	case PHY_INTERFACE_MODE_GMII:
-		return "gmii";
-	case PHY_INTERFACE_MODE_SGMII:
-		return "sgmii";
-	case PHY_INTERFACE_MODE_TBI:
-		return "tbi";
-	case PHY_INTERFACE_MODE_REVMII:
-		return "rev-mii";
-	case PHY_INTERFACE_MODE_RMII:
-		return "rmii";
-	case PHY_INTERFACE_MODE_REVRMII:
-		return "rev-rmii";
-	case PHY_INTERFACE_MODE_RGMII:
-		return "rgmii";
-	case PHY_INTERFACE_MODE_RGMII_ID:
-		return "rgmii-id";
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-		return "rgmii-rxid";
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-		return "rgmii-txid";
-	case PHY_INTERFACE_MODE_RTBI:
-		return "rtbi";
-	case PHY_INTERFACE_MODE_SMII:
-		return "smii";
-	case PHY_INTERFACE_MODE_XGMII:
-		return "xgmii";
-	case PHY_INTERFACE_MODE_XLGMII:
-		return "xlgmii";
-	case PHY_INTERFACE_MODE_MOCA:
-		return "moca";
-	case PHY_INTERFACE_MODE_PSGMII:
-		return "psgmii";
-	case PHY_INTERFACE_MODE_QSGMII:
-		return "qsgmii";
-	case PHY_INTERFACE_MODE_TRGMII:
-		return "trgmii";
-	case PHY_INTERFACE_MODE_1000BASEX:
-		return "1000base-x";
-	case PHY_INTERFACE_MODE_1000BASEKX:
-		return "1000base-kx";
-	case PHY_INTERFACE_MODE_2500BASEX:
-		return "2500base-x";
-	case PHY_INTERFACE_MODE_5GBASER:
-		return "5gbase-r";
-	case PHY_INTERFACE_MODE_RXAUI:
-		return "rxaui";
-	case PHY_INTERFACE_MODE_XAUI:
-		return "xaui";
-	case PHY_INTERFACE_MODE_10GBASER:
-		return "10gbase-r";
-	case PHY_INTERFACE_MODE_25GBASER:
-		return "25gbase-r";
-	case PHY_INTERFACE_MODE_USXGMII:
-		return "usxgmii";
-	case PHY_INTERFACE_MODE_10GKR:
-		return "10gbase-kr";
-	case PHY_INTERFACE_MODE_100BASEX:
-		return "100base-x";
-	case PHY_INTERFACE_MODE_QUSGMII:
-		return "qusgmii";
-	case PHY_INTERFACE_MODE_10G_QXGMII:
-		return "10g-qxgmii";
-	case PHY_INTERFACE_MODE_50GBASER:
-		return "50gbase-r";
-	case PHY_INTERFACE_MODE_LAUI:
-		return "laui";
-	case PHY_INTERFACE_MODE_100GBASEP:
-		return "100gbase-p";
-	case PHY_INTERFACE_MODE_MIILITE:
-		return "mii-lite";
-	default:
+	if (interface > PHY_INTERFACE_MODE_MAX)
 		return "unknown";
-	}
+
+	return phy_interface_names[interface];
 }
 
 /**
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 4036561b078b..d795d9a8b0cd 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -483,6 +483,50 @@ static const char ethtool_link_medium_names[][ETH_GSTRING_LEN] = {
 };
 static_assert(ARRAY_SIZE(ethtool_link_medium_names) == __ETHTOOL_LINK_MEDIUM_LAST);
 
+const char phy_interface_names[][ETH_GSTRING_LEN] = {
+	[PHY_INTERFACE_MODE_NA] =	"",
+	[PHY_INTERFACE_MODE_INTERNAL] =	"internal",
+	[PHY_INTERFACE_MODE_MII] =	"mii",
+	[PHY_INTERFACE_MODE_GMII] =	"gmii",
+	[PHY_INTERFACE_MODE_SGMII] =	"sgmii",
+	[PHY_INTERFACE_MODE_TBI] =	"tbi",
+	[PHY_INTERFACE_MODE_REVMII] =	"rev-mii",
+	[PHY_INTERFACE_MODE_RMII] =	"rmii",
+	[PHY_INTERFACE_MODE_REVRMII] =	"rev-rmii",
+	[PHY_INTERFACE_MODE_RGMII] =	"rgmii",
+	[PHY_INTERFACE_MODE_RGMII_ID] = "rgmii-id",
+	[PHY_INTERFACE_MODE_RGMII_RXID] = "rgmii-rxid",
+	[PHY_INTERFACE_MODE_RGMII_TXID] = "rgmii-txid",
+	[PHY_INTERFACE_MODE_RTBI] =	"rtbi",
+	[PHY_INTERFACE_MODE_SMII] =	"smii",
+	[PHY_INTERFACE_MODE_XGMII] =	"xgmii",
+	[PHY_INTERFACE_MODE_XLGMII] =	"xlgmii",
+	[PHY_INTERFACE_MODE_MOCA] =	"moca",
+	[PHY_INTERFACE_MODE_PSGMII] =	"psgmii",
+	[PHY_INTERFACE_MODE_QSGMII] =	"qsgmii",
+	[PHY_INTERFACE_MODE_TRGMII] =	"trgmii",
+	[PHY_INTERFACE_MODE_1000BASEX] = "1000base-x",
+	[PHY_INTERFACE_MODE_1000BASEKX] = "1000base-kx",
+	[PHY_INTERFACE_MODE_2500BASEX] = "2500base-x",
+	[PHY_INTERFACE_MODE_5GBASER] =	"5gbase-r",
+	[PHY_INTERFACE_MODE_RXAUI] =	"rxaui",
+	[PHY_INTERFACE_MODE_XAUI] =	"xaui",
+	[PHY_INTERFACE_MODE_10GBASER] =	"10gbase-r",
+	[PHY_INTERFACE_MODE_25GBASER] =	"25gbase-r",
+	[PHY_INTERFACE_MODE_USXGMII] =	"usxgmii",
+	[PHY_INTERFACE_MODE_10GKR] =	"10gbase-kr",
+	[PHY_INTERFACE_MODE_100BASEX] =	"100base-x",
+	[PHY_INTERFACE_MODE_QUSGMII] =	"qusgmii",
+	[PHY_INTERFACE_MODE_10G_QXGMII] = "10g-qxgmii",
+	[PHY_INTERFACE_MODE_50GBASER] =	"50gbase-r",
+	[PHY_INTERFACE_MODE_LAUI] =	"laui",
+	[PHY_INTERFACE_MODE_100GBASEP] = "100gbase-p",
+	[PHY_INTERFACE_MODE_MIILITE] =	"mii-lite",
+
+};
+static_assert(ARRAY_SIZE(phy_interface_names) == PHY_INTERFACE_MODE_MAX);
+EXPORT_SYMBOL_GPL(phy_interface_names);
+
 const char netif_msg_class_names[][ETH_GSTRING_LEN] = {
 	[NETIF_MSG_DRV_BIT]		= "drv",
 	[NETIF_MSG_PROBE_BIT]		= "probe",
-- 
2.49.0


