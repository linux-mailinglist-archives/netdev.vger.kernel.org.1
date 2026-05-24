Return-Path: <netdev+bounces-291163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEO9MJ3XEmom4gYAu9opvQ
	(envelope-from <netdev+bounces-291163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:49:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C6B5C21E9
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B4E43019B86
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 10:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE0E3932EA;
	Sun, 24 May 2026 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs0QgsUy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5ED2882D7
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779619503; cv=none; b=n9r8LRUzBY8eRA5GqYek5l6or1wx7UrcVPmgD8lHlvCgjI3Rg7Ujhw2FmEw93KEU1iVct4h2qBu/NsssfrBhE3k5+NEbPYu2orspFPMwgLELav0aQiug0u9L3nM2LYFGnuERGmqpX1OwIhKgoZOqTITeFn/ZRaj8XpWlVEHxksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779619503; c=relaxed/simple;
	bh=rRle6VHq43rybdBxKovEgxEbnVv8lomEAMrTysrLkQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d9e7LiMP7oIgFX5JLY74PhCywjPtWAZJdX0bOZavr54tywZBScl+umy8fvLJXVG69pila1t5ZXr5CevqJjteLwqtr+ge9rxK5LX1Nyi1C7KuNQIQO5n31PZVG6Ye5701fgFh4JlbPG897GS4h90kkoupG6CbSsgo09gbQYEhvZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs0QgsUy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490426d72f7so20124575e9.3
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779619496; x=1780224296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zm/GwOmcvY0qOSCGXEdJb6NNauNokk7/UCTOiBwcXzY=;
        b=Zs0QgsUyDk0NHG4XoiQICsVkAiXxwgDF636BVTruNtRFRZUnCG6T7W/OzMaImKrSZP
         TkF0SmQh8iSKUajP6IcvLfvloLxmxyIOVF7X2RmxcmA8GXCw0saC0iYhYdRxnuX4fLio
         kxmIHFbPuob4aaXSUyPx2RcOwp2ujqIygruVblmoInp9EYKKsACInHDLK3wmwIo4ej7J
         kf8y63/Zt7NRX2skrp5DbtNWiyEwKf7IzIhzZDE8hgcpm4gtgD+o4TXOaZEeVrZqxHz6
         cu/Kpzpyls+dS/EEqzumcNJ6rsyxNmoZA9rggl58qnCJzfQa2fKz4RigVleFcCkaJ+O9
         T/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779619496; x=1780224296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zm/GwOmcvY0qOSCGXEdJb6NNauNokk7/UCTOiBwcXzY=;
        b=JxDxJBsERKGpXE9z8VJTqsyNZ2Tx5SktcoewJGCifcr+7919oRawSECGkwjgRnsOmc
         iwjB+otB2ExFhw2PuYevdJFC6MmP3yO8roXeWZYZMtWieUvp0oYK0CSbzmqLPu8Pyehh
         uRKyufN/86z5RLyTXi8aL3hyaDII1zzWAwJIEbhevySj7LG5jUVmhCEkjqaCSMB316LX
         UM0HMvlXdm1cxpBVdTDO5XK9KVztPqKndexpFocPSPebdR/a8winDp/AtR4zlI2Kj8yF
         IruAFiw6SguE64u4jMFM68UyqHeD5DiUpTKrV4uOlmf8MbWTToN0m8nuW0yr5XHgPZB2
         Qh5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8ErV4SAcKskbj+8hFh4ZtMMbPiFfzcgcgIVAdZFwDavC+h3Yjj8YbSvpgvb43OZ9oPgoeHU70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAx6Qz01x8q7++p/iavQdhv+M9EzgB9nGRyyNwLO+QlEfd9XAd
	DjQykQNOrDcm3pqaiePEHYIOGyBBejto9a3363ihDW7ITGqQtmmC16lo
X-Gm-Gg: Acq92OGeBV5eFkUrH9htl/kd5zvSqhCJBO1SNk6unzqzP+GDnAmXPAafbbQTj4fZtt2
	RAg0rRVS49p7D3HghD2gJnXU2dBrCbmpdbVafjyKTle3JpNALsvOfbpFrUXZSFi1Xigb7RwseBd
	Uzs5iNCmnjkO1lEsvdqYuhKl8Nefupj9jE9zikYJ+QBvo26FwsoFDG/auTnFnoFXPlL7jIXyD+q
	rNzq24JhtM954xR0kMlaGGChtcDwh6F0K8sbmAcDdjdhiwSyuveo4erHU3MAC+Q3yGP4n2TG8mM
	mglB5KIC/4KoOwGGPdOCp65GXFlN/N1ztTdBMY+dzNpJ6ESpXl7l+Ftu197pHD2pdzarmspBH0k
	SJkg5L1NqbvNKQd0rmzx27NUH7lbpn4NLz5+1Jj3gbZTEdSQy+B5pnb6V12+y82QR4CS7uqtEIU
	9J31BpYNiMTU+CmKjRPL1gm8ohBAhQ5WgHJ0v6PcfX43nLzzvueJHMr7xpEvjHDZi2BbicHDe3I
	ie/t4AxsXln8CeQ1UEl
X-Received: by 2002:a05:600c:4ecc:b0:48a:557e:6b4f with SMTP id 5b1f17b1804b1-490426d2805mr155632375e9.23.1779619496392;
        Sun, 24 May 2026 03:44:56 -0700 (PDT)
Received: from [127.0.1.1] (2a01cb0c131d7300e352009073da06b6.ipv6.abo.wanadoo.fr. [2a01:cb0c:131d:7300:e352:90:73da:6b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527f7f7sm258967105e9.7.2026.05.24.03.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 03:44:56 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Sun, 24 May 2026 12:44:26 +0200
Subject: [PATCH net-next v7 3/3] net: phy: micrel: expose KSZ87xx low-loss
 cable tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-ksz87xx_errata_low_loss_connections-v7-3-1cd49cfa24f0@exotec.com>
References: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
In-Reply-To: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Tristram Ha <Tristram.Ha@microchip.com>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779619492; l=3380;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=rRle6VHq43rybdBxKovEgxEbnVv8lomEAMrTysrLkQM=;
 b=IhoZMRrufbEFkhpcXfKrI3wcV+/FZnLOl2mFCErfOeoUaqqWYeJnXmEbmCrgjTfjRJBwpUG0H
 l3Dmnjcwka+AcDf8SKfpcL349AsTxlpcixDzRMzJODQ1EQ8ny93rwvH
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291163-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:mid,exotec.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 73C6B5C21E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the KSZ87xx low-loss cable PHY tunables in the Micrel
PHY driver by implementing get_tunable and set_tunable callbacks.

These callbacks expose vendor-specific PHY tunables used to control the
KSZ87xx embedded PHY receiver behavior when operating with short or
low-loss Ethernet cables. The tunables provide:

- a boolean short-cable preset applying known good settings;
- an integer LPF bandwidth control;
- an integer DSP EQ initial value control.

The Micrel PHY driver forwards these tunables via standard phy_read() /
phy_write() operations, which are virtualized by the KSZ8 DSA driver and
translated into the appropriate indirect switch register accesses.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 drivers/net/phy/micrel.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index e211a523c258..bb8f3054e257 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -287,6 +287,12 @@
 /* PHY Control 2 / PHY Control (if no PHY Control 1) */
 #define MII_KSZPHY_CTRL_2			0x1f
 #define MII_KSZPHY_CTRL				MII_KSZPHY_CTRL_2
+
+/* Vendor-specific Clause 22 register, virtualized by KSZ87xx embedded PHYs DSA driver */
+#define MII_KSZ87XX_SHORT_CABLE			0x1a
+#define MII_KSZ87XX_LPF_BW				0x1b
+#define MII_KSZ87XX_EQ_INIT				0x1c
+
 /* bitmap of PHY register to set interrupt mode */
 #define KSZ8081_CTRL2_HP_MDIX			BIT(15)
 #define KSZ8081_CTRL2_MDI_MDI_X_SELECT		BIT(14)
@@ -940,6 +946,52 @@ static int ksz8795_match_phy_device(struct phy_device *phydev,
 	return ksz8051_ksz8795_match_phy_device(phydev, false);
 }
 
+static int ksz8795_get_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, void *data)
+{
+	int ret;
+
+	switch (tuna->id) {
+	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
+		ret = phy_read(phydev, MII_KSZ87XX_SHORT_CABLE);
+		if (ret < 0)
+			return ret;
+		*(u8 *)data = ret;
+		return 0;
+	case ETHTOOL_PHY_LPF_BW:
+		ret = phy_read(phydev, MII_KSZ87XX_LPF_BW);
+		if (ret < 0)
+			return ret;
+		*(u8 *)data = ret;
+		return 0;
+	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
+		ret = phy_read(phydev, MII_KSZ87XX_EQ_INIT);
+		if (ret < 0)
+			return ret;
+		*(u8 *)data = ret;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ksz8795_set_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, const void *data)
+{
+	u8 val = *(const u8 *)data;
+
+	switch (tuna->id) {
+	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
+		return phy_write(phydev, MII_KSZ87XX_SHORT_CABLE, val);
+	case ETHTOOL_PHY_LPF_BW:
+		return phy_write(phydev, MII_KSZ87XX_LPF_BW, val);
+	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
+		return phy_write(phydev, MII_KSZ87XX_EQ_INIT, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int ksz9021_load_values_from_of(struct phy_device *phydev,
 				       const struct device_node *of_node,
 				       u16 reg,
@@ -6961,6 +7013,8 @@ static struct phy_driver ksphy_driver[] = {
 	/* PHY_BASIC_FEATURES */
 	.config_init	= kszphy_config_init,
 	.match_phy_device = ksz8795_match_phy_device,
+	.get_tunable	= ksz8795_get_tunable,
+	.set_tunable	= ksz8795_set_tunable,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {

-- 
2.54.0


