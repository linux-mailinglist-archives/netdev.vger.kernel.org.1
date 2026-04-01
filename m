Return-Path: <netdev+bounces-274094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP+SMNwUzWmMZwYAu9opvQ
	(envelope-from <netdev+bounces-274094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:51:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D198037AC0C
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFE11305BCBB
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00182408232;
	Wed,  1 Apr 2026 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="MVPnmeK/"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739423E92A7;
	Wed,  1 Apr 2026 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047170; cv=none; b=jZBoFLuNccGPKJ/5b18D/XKabjg+UJQiQ/JiMeaxf89FtAcPl0ihY0CDLDreMPnldPo81b++WFxRyajpT6pBJGtEl7FXUE7HEfW3D6J2KNX5UKzTULmSCcfyf8gxOjlQKDaI/NfllPVzbithkFmb1sAFS0FGEfL+7LTDX4OGNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047170; c=relaxed/simple;
	bh=J8pIL+3nLduqmqUa2K6ijetClNrMZajqMZoagU5lLXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIpULS4FTlLsPr7iiCRVIP/7GJ8sHGgK0uMFJZLuOm+CpNUWacFoYP3MosyWXznxV4eniT/zZzsEffnBddGH/OxmWOvGjOfkVZVby58Cbw4XLCbqgEwp5doHiL05SL9+TwVTj63BEATV7yFKwogDA06/63976+B7Kbu8kbbgC5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=MVPnmeK/; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E40FA5880;
	Wed,  1 Apr 2026 14:39:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775047164; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=34BUwFNlD6qwyTipKWAsNgkks4c7NvSnL028HttCoZ0=;
	b=MVPnmeK/Y4VVZ4XxrVTdgT8aRJy/HA/AwZjKgc3N8d/fwVtpII27q9u3Bz13pOsg8HhQDZ
	9KWr0YLSheWzhSmeBfzPj7nCzrF7NijdvXlDGegww4E5TyIcBPJr6lJjuehl5BHgNEf8rt
	zwJL3m0dI6IS23H1atLUdfcEBZmJmdTXT+CWf7tSBdX80jP9plx2bhVUwwgylGM79OcmVI
	Eoa+Pxf3xN9DAohG3u41Eclqwxe1IWGi6s2lhFNY1CCDk2vu/NiP1nCMRRJcqlJMusBlYe
	ot4lroM9Kw/B3dDmx+DrOyTb8odHT+WKlevJzLjwSJoL3OCKVKGY42ULNWhPTA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/2] net: phy: microchip: enable downshift by default on LAN88xx
Date: Wed,  1 Apr 2026 14:38:45 +0200
Message-ID: <20260401123848.696766-3-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401123848.696766-1-nb@tipi-net.de>
References: <20260329224202.500229-1-nb@tipi-net.de>
 <20260401123848.696766-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274094-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[raspberrypi.com,armlinux.org.uk,lunn.ch,tipi-net.de,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Queue-Id: D198037AC0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable auto-downshift from 1000BASE-T to 100BASE-TX after 2 failed
auto-negotiation attempts by default. This ensures that links with
faulty or missing cable pairs (C and D) fall back to 100Mbps without
requiring userspace configuration.

The downshift count is stored in the driver's private data and applied
in config_init, so user changes via ethtool are preserved across
suspend/resume cycles.

Users can override or disable downshift at runtime:

  ethtool --set-phy-tunable eth0 downshift off

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/microchip.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index bc293d2dd130..33bc633bdba0 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -26,6 +26,7 @@ struct lan88xx_priv {
 	int	chip_id;
 	int	chip_rev;
 	__u32	wolopts;
+	u8	downshift_cnt;
 };
 
 static int lan88xx_read_page(struct phy_device *phydev)
@@ -247,9 +248,15 @@ static int lan88xx_get_tunable(struct phy_device *phydev,
 static int lan88xx_set_tunable(struct phy_device *phydev,
 			       struct ethtool_tunable *tuna, const void *data)
 {
+	struct lan88xx_priv *priv = phydev->priv;
+	int ret;
+
 	switch (tuna->id) {
 	case ETHTOOL_PHY_DOWNSHIFT:
-		return lan88xx_set_downshift(phydev, *(const u8 *)data);
+		ret = lan88xx_set_downshift(phydev, *(const u8 *)data);
+		if (!ret)
+			priv->downshift_cnt = *(const u8 *)data;
+		return ret;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -267,6 +274,7 @@ static int lan88xx_probe(struct phy_device *phydev)
 		return -ENOMEM;
 
 	priv->wolopts = 0;
+	priv->downshift_cnt = 2;
 
 	len = of_property_read_variable_u32_array(dev->of_node,
 						  "microchip,led-modes",
@@ -346,7 +354,8 @@ static void lan88xx_set_mdix(struct phy_device *phydev)
 
 static int lan88xx_config_init(struct phy_device *phydev)
 {
-	int val;
+	struct lan88xx_priv *priv = phydev->priv;
+	int val, err;
 
 	/*Zerodetect delay enable */
 	val = phy_read_mmd(phydev, MDIO_MMD_PCS,
@@ -359,6 +368,10 @@ static int lan88xx_config_init(struct phy_device *phydev)
 	/* Config DSP registers */
 	lan88xx_config_TR_regs(phydev);
 
+	err = lan88xx_set_downshift(phydev, priv->downshift_cnt);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
-- 
2.51.0


