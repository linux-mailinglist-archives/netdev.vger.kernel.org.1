Return-Path: <netdev+bounces-279314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMPRJRYs4mns2QAAu9opvQ
	(envelope-from <netdev+bounces-279314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:48:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1928A41B4D6
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 267FF3131B25
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683D039D6D2;
	Fri, 17 Apr 2026 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVIL01Tm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CE639D6F2
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776429898; cv=none; b=qbqz0kCv8XwVYsdQC4fL4m35c9FcMYqJMzEHyAvWY+B1FMrLiMuBXAh18928PPuhXV1M1A61mpa7BAPXLFdKJ2pFvUZWXpicYUcW3tboxF6S2hoz9fNwUEuZZIg1vLmrBnGHtXVvUqDe32Ew+dbkF3bf5mikNDtZoNfbJLvUVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776429898; c=relaxed/simple;
	bh=1JygUzA/h3LiigIAXa4eAjNMynaVQWP1U2qxMTvbsiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJS7/nHn5UCzk7Lb2nAlxR0E+sSUvZsog/5U17QsXoMLKc0ruQkTGc08GS0g/k5xEkQVC5WZjJ+/P24f7kPw9sBQoUbW01f50y4TROw4fb9+JaFSzk3UdKED8H6VOqOVlJnuJBFFieykDhOuSlLiKnwhenQ7rtVY0/JAvvXuwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVIL01Tm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48896199cbaso6932555e9.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 05:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776429895; x=1777034695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5AFGmIxEc8dseQ5H/CWt6cOyXOCtB/D+ayVpHCCwUD0=;
        b=fVIL01TmuUJpBNjIZsTpLz2LY0+P3YN9TxvCNLuaKgUPSuUGJ5N2lUlFiJNoEq0mMv
         KS//WC3Q3LJsqvnf2GTSDJ9O4LAbuEXY+kkn1HDZL7drxumAULiWYzgzSDIAA8tXUi5t
         yfXZK9KfjloEQHDOdkQqx5TXBJjx+O1xBukXy+osULdsR11fiWNzdvjyTiOnf2s1KAdC
         R5MLwwZNAJ5BiQrIkSdFN6VCrFw+cCo3qMJqqq1+rLVPu21u/84RDkch7SaT+h/WkyKK
         MR46uHK6M4qqlhfppgAPTwDPMxJ+dp+5dmfIg3C1j2fprN8mfTT2gbO42+5jnN7ig6ko
         hG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776429895; x=1777034695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5AFGmIxEc8dseQ5H/CWt6cOyXOCtB/D+ayVpHCCwUD0=;
        b=a+PTUPpoWGvu88UuTSmZlL1CNLKvdDwf2HZioCcOEmBVW93ncd5Jrza9AF/Ovy5M/E
         uYbsxGccvXrhumrpeFCaIvHsmYSKiyLT56wtfIXjt75SBimpyWq5bxL+BxdP0bq862Qi
         p6+AquTcGxN9OaiD/PIEtlyjdWsAGMaN2o/D0M7/z2jT3Ly9jo1HOxYyjfPoR5GFkvz/
         w8yZcVHA8kzua9i+s030ztwwsnaaDbshLrRgWQ+kKuiGTdlE6P2vUBO/qY18Z3LJrykJ
         +IJQ9uJK5Q4MN/SWHHTg5Q7jHDlB56XQgTVFchzSIUrGnccaw9orfc1hsrak1AnbtTo2
         u4rw==
X-Forwarded-Encrypted: i=1; AFNElJ+filNLDTmG5CLGmN82PoOVXiSbyqCRDkfV19oZEic++wlP1FtjQRDvfwsJv3c+7+eEaW7ZYwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqC1dz45qks39U/10JxSp4PML8mPm0MHcq5L6476hIMWZ/wZnO
	8Xlq9aiRFFcel++mC1NstuHknhD26418mSTBCmKtKTZpEz5XwTqJtNdU
X-Gm-Gg: AeBDieuN8EMs6tpEWXeXUEhea3ADeRCfalZLzSc2iA0q55GZBT43rvEnaBKi2JWaclg
	11kfvTQha+cgcf4mh89o8PnXk5zwY98DshedeAv3DdedVOKQTguN2Sh5Dl88pLC3S0iwriDqr2V
	9WwOePIhuh23yzuNaV2XRZ0AALbPGOIVr10gAhvt8mNzMRWoCHfRS9WFmPEIWe73lAoDs95MLss
	BMO4iyIGZ210ZYCDfgBKWeLprryekV3aDfVT5bjQZHHpE4szhU9nu1J7NHNyRLrV3b4CIq26OQk
	WV1EJjvhSfdfxmv9rND9k7zp0ivbaznBnEto3BtB8Cck4imQMEZ8gOcsZ0ZjtBR47M3tOyLatM+
	Xm5UhvgyZAmtfIYDg0audLRaMpGZxpwFyTZDKwQ1ypS5Ly1wJGSJ/AKPhb05B3RqZGuEE2sHONS
	SbNZwjXMwGfgCmjfoH3lixY2shj1pIosWxg/nxcurcnEndFdhLZ6zkiS4kAu7U2lOqu4Cd2HI5u
	9ILKo19HtdUR/o1S0Tx
X-Received: by 2002:a05:600c:c171:b0:485:40c6:f507 with SMTP id 5b1f17b1804b1-488fb793228mr40749305e9.30.1776429894721;
        Fri, 17 Apr 2026 05:44:54 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm47416315e9.5.2026.04.17.05.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:44:53 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Fri, 17 Apr 2026 14:44:29 +0200
Subject: [PATCH v4 3/3] net: phy: micrel: expose KSZ87xx low-loss cable
 tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-ksz87xx_errata_low_loss_connections-v4-3-6c7044ec4363@exotec.com>
References: <20260417-ksz87xx_errata_low_loss_connections-v4-0-6c7044ec4363@exotec.com>
In-Reply-To: <20260417-ksz87xx_errata_low_loss_connections-v4-0-6c7044ec4363@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776429890; l=3380;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=1JygUzA/h3LiigIAXa4eAjNMynaVQWP1U2qxMTvbsiY=;
 b=uEUSkMD2k307AChDuDvHVSyqyJIsk0BHJKOUHRGZ5ubGe5cm3D73BY9XpUE1GUzThd8dwzBGN
 lyaAREzL7GKBqlmuqMfgG6n1rSwdr2IrCkWIxVgckx8dhtzWBqtsycY
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279314-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:mid,exotec.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1928A41B4D6
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
index c6b011a9d636..1852e9bd0e01 100644
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
 
+static int ksz87xx_get_tunable(struct phy_device *phydev,
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
+static int ksz87xx_set_tunable(struct phy_device *phydev,
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
@@ -6809,6 +6861,8 @@ static struct phy_driver ksphy_driver[] = {
 	/* PHY_BASIC_FEATURES */
 	.config_init	= kszphy_config_init,
 	.match_phy_device = ksz8795_match_phy_device,
+	.get_tunable	= ksz87xx_get_tunable,
+	.set_tunable	= ksz87xx_set_tunable,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {

-- 
2.53.0


