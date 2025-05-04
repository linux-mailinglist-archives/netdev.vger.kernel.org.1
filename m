Return-Path: <netdev+bounces-187647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58955AA8898
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 19:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92945189795D
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AC41EEA3E;
	Sun,  4 May 2025 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="cllNE5Fk";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="NH9OS2Gf"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5236F1EEA4E;
	Sun,  4 May 2025 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379958; cv=pass; b=HkISijPeBoXHoGuvR0lOsgPHEJEx5EHgYnwrHbzFZlF+L+a8mnHyLrbGt2s8QpnyjMGSNsp1+ZWVDnTjS8nt82bohcSg45nwMkX1P+t4L1iM02SuLAzcE50qVO5ucSipibweQVPV+IrjAmK8J7hPSEI7uKrFsjHs2tMimAu0liA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379958; c=relaxed/simple;
	bh=evtx0qhV/I69gONPM8NnFq1FE8C9KBD4S39MI5fUDmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnE/EJzn3I8ZrzCwTKF7Rs1mNSfSJwY/7cnqZFB3BNEYWEirTfW4NaRSKwKNpqkV72ORmJQrQAmwgcLuMTCj/GIs9cDaPaK+X/q0i9Pf2mWk98iwTsKpJQbLqdVzo2Z4DKZuq7m3bbuKJu8L1kTDwBsXhslnehREF4eSxBGDENI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=cllNE5Fk; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=NH9OS2Gf; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1746379772; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UN0i9XPByQe+ANf7VHgoJGiQy4jP8vhKn6a6lu8NYDjtQW4G7Um4IOXby3aiZkEE/5
    +WoR+O8j54r5/HYfGDM0C1eIadvAoBwMg9MXzV9uaF4o7513uGtpGeE+SzuDojytrXc+
    JIKG3/jmc7xn5nCmBJpFkpctQ4tzaaFifZcYc15t8/EnUb20XlEIGzWS2gKVgk6m0tYl
    KyYECuP6/zLAdPm80Wf2DIoQYYoQ2XT+Ha4qyVHVjJVeheo4FWepMUd9fXVveXDg7hno
    s29O15tpTfzGILSEC85osu9eUzbUhY96iB+l/XdObMcxXhmrB08jydfiRO8wqFcLCiB1
    RxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1746379772;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eAsCrEvtfrEidwM3GttjRPxsaZzZGL311YCh8taGsaQ=;
    b=O2mO4k/SYYjfpvw4zpRPKZJvv1IO6N6PjljkYx/TiJ1e6zPvHcfu4i7Ig474uT5Aay
    8UppdCd0kY9aJ0ZewLZb5l7J5WUhFCRxXTUWcvqft/N171gN7hSgdmrGVZelqMaCGU9A
    sIMzAppFVx+L5gdXrZ8X/xabOshcmMM2ARrJ2cPnarNH7RcV9F6Mx1c30BzSLM3yMnrY
    PiGrB1vy+wOTcGgiyLAyM06BxFPvjM0hm+gCJrnEYOqxNKtkZnh0Od79RAfB9JCmP/wW
    znrp3ordjJ4uwkyygsUD3zigxQ+eat4j2NMLyYf14+eBgfklJOs6HE+AVrjeGqSft2j1
    F3CA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1746379772;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eAsCrEvtfrEidwM3GttjRPxsaZzZGL311YCh8taGsaQ=;
    b=cllNE5FkseVcXxeaIUivdKP3OYlVmDU1zljrBTvKUFzBx1/jd4Ma9CMGOt0dMkQBP4
    4/ui4xbcBq0Wt0K/Ev8rZ+X4ipx0cCEaVmfyTHZGxULdAbyvhUl+ZoF48sA5m7WFh6Jk
    Vsaym3mdvaBy8SPIfg8fX0OETsBR3noFgq63dFh3D11szijioS+S/VE6yyi9wO4q4a2H
    rYNsALNBeVQV0zLCoikLfUBlvXR1AQ9BVsegDExT6VvIflvITsnYi/ZCkQ5YEMyMz1Q2
    xQOoDUkywyg0LcT5FYOW1ku9T032g5rcF9r2O7q1KnRuSFZjV5g0eZVE72GGIgMkVTyw
    6wtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1746379772;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eAsCrEvtfrEidwM3GttjRPxsaZzZGL311YCh8taGsaQ=;
    b=NH9OS2Gfr/BPZlmgQTJ/j5Sco0CUWa1F1cN4wBfywRA29uDrSvRBdDrlb9GCmqMUv6
    gBnkHeD8pusEu9ey2PAg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b35144HTWz9I
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 4 May 2025 19:29:32 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1uBd9e-0004Nu-3D;
	Sun, 04 May 2025 19:29:31 +0200
Received: (nullmailer pid 243264 invoked by uid 502);
	Sun, 04 May 2025 17:29:30 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v7 3/6] net: phy: realtek: add RTL8211F register defines
Date: Sun,  4 May 2025 19:29:13 +0200
Message-Id: <20250504172916.243185-4-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250504172916.243185-1-michael@fossekall.de>
References: <20250504172916.243185-1-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Add some more defines for RTL8211F page and register numbers.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 drivers/net/phy/realtek/realtek_main.c | 34 ++++++++++++++++++--------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 0f005a449719..ca6d2903b1c9 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -30,11 +30,14 @@
 #define RTL821x_PAGE_SELECT			0x1f
 #define RTL821x_SET_EXT_PAGE			0x07
 
+/* RTL8211F PHY configuration */
+#define RTL8211F_PHYCR_PAGE			0xa43
 #define RTL8211F_PHYCR1				0x18
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_CLKOUT_EN			BIT(0)
 #define RTL8211F_PHYCR2_PHY_EEE_ENABLE		BIT(5)
 
+#define RTL8211F_INSR_PAGE			0xa43
 #define RTL8211F_INSR				0x1d
 
 /* RTL8211F WOL interrupt configuration */
@@ -55,6 +58,8 @@
 #define RTL8211F_PHYSICAL_ADDR_WORD1		17
 #define RTL8211F_PHYSICAL_ADDR_WORD2		18
 
+/* RTL8211F LED configuration */
+#define RTL8211F_LEDCR_PAGE			0xd04
 #define RTL8211F_LEDCR				0x10
 #define RTL8211F_LEDCR_MODE			BIT(15)
 #define RTL8211F_LEDCR_ACT_TXRX			BIT(4)
@@ -64,7 +69,13 @@
 #define RTL8211F_LEDCR_MASK			GENMASK(4, 0)
 #define RTL8211F_LEDCR_SHIFT			5
 
+/* RTL8211F RGMII configuration */
+#define RTL8211F_RGMII_PAGE			0xd08
+
+#define RTL8211F_TXCR				0x11
 #define RTL8211F_TX_DELAY			BIT(8)
+
+#define RTL8211F_RXCR				0x15
 #define RTL8211F_RX_DELAY			BIT(3)
 
 #define RTL8211F_ALDPS_PLL_OFF			BIT(1)
@@ -187,7 +198,7 @@ static int rtl821x_probe(struct phy_device *phydev)
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to get phy clock\n");
 
-	ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR1);
+	ret = phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1);
 	if (ret < 0)
 		return ret;
 
@@ -197,7 +208,7 @@ static int rtl821x_probe(struct phy_device *phydev)
 
 	priv->has_phycr2 = !(phy_id == RTL_8211FVD_PHYID);
 	if (priv->has_phycr2) {
-		ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR2);
+		ret = phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2);
 		if (ret < 0)
 			return ret;
 
@@ -233,7 +244,7 @@ static int rtl8211f_ack_interrupt(struct phy_device *phydev)
 {
 	int err;
 
-	err = phy_read_paged(phydev, 0xa43, RTL8211F_INSR);
+	err = phy_read_paged(phydev, RTL8211F_INSR_PAGE, RTL8211F_INSR);
 
 	return (err < 0) ? err : 0;
 }
@@ -376,7 +387,7 @@ static irqreturn_t rtl8211f_handle_interrupt(struct phy_device *phydev)
 {
 	int irq_status;
 
-	irq_status = phy_read_paged(phydev, 0xa43, RTL8211F_INSR);
+	irq_status = phy_read_paged(phydev, RTL8211F_INSR_PAGE, RTL8211F_INSR);
 	if (irq_status < 0) {
 		phy_error(phydev);
 		return IRQ_NONE;
@@ -473,7 +484,7 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	u16 val_txdly, val_rxdly;
 	int ret;
 
-	ret = phy_modify_paged_changed(phydev, 0xa43, RTL8211F_PHYCR1,
+	ret = phy_modify_paged_changed(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1,
 				       RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF,
 				       priv->phycr1);
 	if (ret < 0) {
@@ -507,7 +518,8 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 		return 0;
 	}
 
-	ret = phy_modify_paged_changed(phydev, 0xd08, 0x11, RTL8211F_TX_DELAY,
+	ret = phy_modify_paged_changed(phydev, RTL8211F_RGMII_PAGE,
+				       RTL8211F_TXCR, RTL8211F_TX_DELAY,
 				       val_txdly);
 	if (ret < 0) {
 		dev_err(dev, "Failed to update the TX delay register\n");
@@ -522,7 +534,8 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 			str_enabled_disabled(val_txdly));
 	}
 
-	ret = phy_modify_paged_changed(phydev, 0xd08, 0x15, RTL8211F_RX_DELAY,
+	ret = phy_modify_paged_changed(phydev, RTL8211F_RGMII_PAGE,
+				       RTL8211F_RXCR, RTL8211F_RX_DELAY,
 				       val_rxdly);
 	if (ret < 0) {
 		dev_err(dev, "Failed to update the RX delay register\n");
@@ -538,14 +551,15 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	}
 
 	/* Disable PHY-mode EEE so LPI is passed to the MAC */
-	ret = phy_modify_paged(phydev, 0xa43, RTL8211F_PHYCR2,
+	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
 			       RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
 	if (ret)
 		return ret;
 
 	if (priv->has_phycr2) {
-		ret = phy_modify_paged(phydev, 0xa43, RTL8211F_PHYCR2,
-				       RTL8211F_CLKOUT_EN, priv->phycr2);
+		ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
+				       RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN,
+				       priv->phycr2);
 		if (ret < 0) {
 			dev_err(dev, "clkout configuration failed: %pe\n",
 				ERR_PTR(ret));
-- 
2.39.5


