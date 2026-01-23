Return-Path: <netdev+bounces-252799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B++AHtVc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:03:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 656B474C0C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D1DB30160C2
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D052304BDF;
	Fri, 23 Jan 2026 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ugtXpt6W"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B512F0C62
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166083; cv=none; b=ntwr8HgvRvBFzfx/O9Sblx2EK3f95vUSZoI8TQyNDY3/0a12EyfYWpcaE1lwm7vKUYYNDByCPncYmvaaLDAlApEv4H1LNeSOv6fjARB5iWqJqJlz8t5CvGxADp71YZEkR2vnIzE73b131axTAMF4Yc9i6Hk2iYVwKrKIK+GmuK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166083; c=relaxed/simple;
	bh=aA9w5B4Up8KH2+/J7BQ5ZBTma40RdyqcCDV7AvNqkFE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=d3L/vjz7UjXCHK7v1GoD8DHiPqmLuAIi1GVM/N43UqBXeTHZDKngnleOoCL7Bjz3aJHwTNUb8jNraqaQ0I9S3S97CyiEwR0pE8/oB7GZRdWXx4xiJEod7bLvTx9bXypawVpWSCNa+Tz8vZI3IKi1/akkBsPBYzMxMzoWK1jSQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ugtXpt6W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q9NIt6Y3ergTBJSyDPGuk9fogn/PCMAxMtuWVmRJsJY=; b=ugtXpt6W31YdJK8zhVRHo/Ja0t
	jJQJmoDJs2eP0CUrcOh8tJIaSB+XB2UgrLRrEWXT2IHW5s3oBQ2n1BqldWULTh0HTssSGKo/x0wYN
	7VL1EP0T07+aaGBGBpx3T4+3avc1mZW8Qi3WqRAE8ddZcc+P7a1eiWWeT+47icePna8xxm6MozuZd
	Dfr1iw5xs3Lzv9WedaXSyG+40gZAK54RRWFy5V7A5VWA8MyPMUU2K5YmKUmgorAA+M0kkuIrreeHQ
	1gtJY7jDhfFQ8ph9xUuqp0dxM9O0H3PAxZGT6Spl7jLabec3WWemDQRga/MNJNZOnVYuLQgZH9qK/
	1rMPvx9A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54982 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vjEuY-000000001om-2qsB;
	Fri, 23 Jan 2026 11:01:06 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vjEuV-00000005ggQ-2psl;
	Fri, 23 Jan 2026 11:01:03 +0000
In-Reply-To: <aXNUlVZilT-CTgph@shell.armlinux.org.uk>
References: <aXNUlVZilT-CTgph@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 09/21] net: stmmac: rk: convert rk3588 to
 rk_set_reg_speed()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vjEuV-00000005ggQ-2psl@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jan 2026 11:01:03 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252799-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 656B474C0C
X-Rspamd-Action: no action

Update rk_set_reg_speed() to use either the grf or php_grf regmap
depending on the SoC's requirements and convert rk3588, removing
its custom code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 63 ++++++++++---------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 246a7b9205a5..4f32e4b3769c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -52,6 +52,7 @@ struct rk_gmac_ops {
 
 	u16 clock_grf_reg;
 
+	bool clock_grf_reg_in_php;
 	bool php_grf_required;
 	bool regs_valid;
 	u32 regs[];
@@ -132,7 +133,14 @@ static u32 rk_encode_wm16(u16 val, u16 mask)
 
 static int rk_write_clock_grf_reg(struct rk_priv_data *bsp_priv, u32 val)
 {
-	return regmap_write(bsp_priv->grf, bsp_priv->clock_grf_reg, val);
+	struct regmap *regmap;
+
+	if (bsp_priv->ops->clock_grf_reg_in_php)
+		regmap = bsp_priv->php_grf;
+	else
+		regmap = bsp_priv->grf;
+
+	return regmap_write(regmap, bsp_priv->clock_grf_reg, val);
 }
 
 static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
@@ -1325,39 +1333,33 @@ static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RK3588_GMAC_CLK_RMII_MODE(bsp_priv->id));
 }
 
+static const struct rk_reg_speed_data rk3588_gmac0_speed_data = {
+	.rgmii_10 = RK3588_GMAC_CLK_RGMII(0, GMAC_CLK_DIV50_2_5M),
+	.rgmii_100 = RK3588_GMAC_CLK_RGMII(0, GMAC_CLK_DIV5_25M),
+	.rgmii_1000 = RK3588_GMAC_CLK_RGMII(0, GMAC_CLK_DIV1_125M),
+	.rmii_10 = RK3588_GMA_CLK_RMII_DIV20(0),
+	.rmii_100 = RK3588_GMA_CLK_RMII_DIV2(0),
+};
+
+static const struct rk_reg_speed_data rk3588_gmac1_speed_data = {
+	.rgmii_10 = RK3588_GMAC_CLK_RGMII(1, GMAC_CLK_DIV50_2_5M),
+	.rgmii_100 = RK3588_GMAC_CLK_RGMII(1, GMAC_CLK_DIV5_25M),
+	.rgmii_1000 = RK3588_GMAC_CLK_RGMII(1, GMAC_CLK_DIV1_125M),
+	.rmii_10 = RK3588_GMA_CLK_RMII_DIV20(1),
+	.rmii_100 = RK3588_GMA_CLK_RMII_DIV2(1),
+};
+
 static int rk3588_set_gmac_speed(struct rk_priv_data *bsp_priv,
 				 phy_interface_t interface, int speed)
 {
-	unsigned int val = 0, id = bsp_priv->id;
-
-	switch (speed) {
-	case 10:
-		if (interface == PHY_INTERFACE_MODE_RMII)
-			val = RK3588_GMA_CLK_RMII_DIV20(id);
-		else
-			val = RK3588_GMAC_CLK_RGMII(id, GMAC_CLK_DIV50_2_5M);
-		break;
-	case 100:
-		if (interface == PHY_INTERFACE_MODE_RMII)
-			val = RK3588_GMA_CLK_RMII_DIV2(id);
-		else
-			val = RK3588_GMAC_CLK_RGMII(id, GMAC_CLK_DIV5_25M);
-		break;
-	case 1000:
-		if (interface != PHY_INTERFACE_MODE_RMII)
-			val = RK3588_GMAC_CLK_RGMII(id, GMAC_CLK_DIV1_125M);
-		else
-			goto err;
-		break;
-	default:
-		goto err;
-	}
+	const struct rk_reg_speed_data *rsd;
 
-	regmap_write(bsp_priv->php_grf, RK3588_GRF_CLK_CON1, val);
+	if (bsp_priv->id == 0)
+		rsd = &rk3588_gmac0_speed_data;
+	else
+		rsd = &rk3588_gmac1_speed_data;
 
-	return 0;
-err:
-	return -EINVAL;
+	return rk_set_reg_speed(bsp_priv, rsd, interface, speed);
 }
 
 static void rk3588_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
@@ -1381,6 +1383,9 @@ static const struct rk_gmac_ops rk3588_ops = {
 
 	.gmac_grf_reg = RK3588_GRF_GMAC_CON0,
 
+	.clock_grf_reg_in_php = true,
+	.clock_grf_reg = RK3588_GRF_CLK_CON1,
+
 	.php_grf_required = true,
 	.regs_valid = true,
 	.regs = {
-- 
2.47.3


