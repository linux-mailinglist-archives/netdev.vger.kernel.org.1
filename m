Return-Path: <netdev+bounces-256666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAr7LZUhg2ltiAMAu9opvQ
	(envelope-from <netdev+bounces-256666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:38:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D210E4A53
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 215623011C47
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 10:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85AC3DA7F5;
	Wed,  4 Feb 2026 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hfQ2YHQG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636613B8D4F
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201489; cv=none; b=NWjooqbX4Gge6GSbSDNPmsuKv+yJK5lkG7HbtnLsp6YwQiir3bYqu7ValNZ4GYC3nCD8fEZazI4zwSqWVqQDiYDQCCF/BrDNBflVftYQ0PstSF/z6qnAWOBQXF7Ri39RUnlm5xsvmuL9l4NLypHEPSwEwRg8/pGuP3Adv25B6Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201489; c=relaxed/simple;
	bh=7NsKgj4oO9DEQlj7JSZm1oRVn5uZiWnpF/DaUeIZH/A=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=Wu4yfaIyTCK8EuW5kHu9VKmMbA+pYlaoTYFa+KXxmbk8l85QGBF9bytCPZXc1UFwYNH2VDtpi11N3Hl9G6SMPixLGSW3pomZNwNMOrCF9f+fcowVJkhg66bHDYglg1ylOf+sk5s2kdl7FGcDwuhdCBJyMcS+Hv8JrSCz8qvzA4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hfQ2YHQG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cmBXQFWwMJpNA6HYvHV+pn0Z7Isl9C8hhe8elfOnPD4=; b=hfQ2YHQGZIQm0RQasJiJholAJ4
	W8EaKCsaNrbAclFFje09t0ZJg3V9Fysk4jo/8059NJOFCFZgN/uWmgEX9nf9F51qmlixOhJoIZcXS
	zRvFZQUduZdslxT/ACRO61vDTzJXkSkV2TMbzk1elI+uJMF90wlldW4LupYMH1q3o5AuFSP3X6+Uu
	tMms6oQxwtYvFBotgzcJrjThgJPJRxAsb7B5FfliZBocxzscxeM1A2FssY7mqQoTe4Q7TJ/jaYv0W
	P8QVYnPm25HlblUSdiFXh71VdJFlp+zxJ2XxTyFo/jjzy7k4Wf+3dXsT02dIA3tacRcz8tOS0MXkc
	b4/hjrgw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53300 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vnaGl-000000006DG-3gVg;
	Wed, 04 Feb 2026 10:37:59 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vnaGl-00000007i9f-0ZMw;
	Wed, 04 Feb 2026 10:37:59 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next] net: stmmac: imx: fix iMX93 register definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vnaGl-00000007i9f-0ZMw@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 04 Feb 2026 10:37:59 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256666-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 2D210E4A53
X-Rspamd-Action: no action

When looking at the iMX93 documentation, the definitions in the driver
do not correspond with the documentation, which makes the driver
confusing.

The driver, for example, re-uses a definition for bit 0 for two
different registers, where this bit have completely different purposes.

Fix this by renaming the second register, and adding a definition that
reflects the true purpose of bit 0 in the first register (EQOS enable.)

Replace MX93_GPR_ENET_QOS_INTF_MODE_MASK with MX93_GPR_ENET_QOS_ENABLE
and MX93_GPR_ENET_QOS_INTF_SEL_MASK as MX93_GPR_ENET_QOS_INTF_MODE_MASK
is not a register field.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index ecc0c3483423..c4e85197629d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -28,11 +28,11 @@
 #define GPR_ENET_QOS_CLK_TX_CLK_SEL	(0x1 << 20)
 #define GPR_ENET_QOS_RGMII_EN		(0x1 << 21)
 
-#define MX93_GPR_ENET_QOS_INTF_MODE_MASK	GENMASK(3, 0)
 #define MX93_GPR_ENET_QOS_INTF_SEL_MASK		GENMASK(3, 1)
-#define MX93_GPR_ENET_QOS_CLK_GEN_EN		(0x1 << 0)
-#define MX93_GPR_ENET_QOS_CLK_SEL_MASK		BIT_MASK(0)
-#define MX93_GPR_CLK_SEL_OFFSET			(4)
+#define MX93_GPR_ENET_QOS_ENABLE		BIT(0)
+
+#define MX93_ENET_CLK_SEL_OFFSET		(4)
+#define MX93_ENET_QOS_CLK_TX_SEL_MASK		BIT_MASK(0)
 
 #define DMA_BUS_MODE			0x00001000
 #define DMA_BUS_MODE_SFT_RESET		(0x1 << 0)
@@ -95,17 +95,18 @@ static int imx93_set_intf_mode(struct imx_priv_data *dwmac, u8 phy_intf_sel)
 	if (phy_intf_sel == PHY_INTF_SEL_RMII && dwmac->rmii_refclk_ext) {
 		ret = regmap_clear_bits(dwmac->intf_regmap,
 					dwmac->intf_reg_off +
-					MX93_GPR_CLK_SEL_OFFSET,
-					MX93_GPR_ENET_QOS_CLK_SEL_MASK);
+					MX93_ENET_CLK_SEL_OFFSET,
+					MX93_ENET_QOS_CLK_TX_SEL_MASK);
 		if (ret)
 			return ret;
 	}
 
 	val = FIELD_PREP(MX93_GPR_ENET_QOS_INTF_SEL_MASK, phy_intf_sel) |
-	      MX93_GPR_ENET_QOS_CLK_GEN_EN;
+	      MX93_GPR_ENET_QOS_ENABLE;
 
 	return regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
-				  MX93_GPR_ENET_QOS_INTF_MODE_MASK, val);
+				  MX93_GPR_ENET_QOS_INTF_SEL_MASK |
+				  MX93_GPR_ENET_QOS_ENABLE, val);
 };
 
 static int imx_dwmac_clks_config(void *priv, bool enabled)
@@ -205,7 +206,8 @@ static void imx93_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 	old_ctrl = readl(dwmac->base_addr + MAC_CTRL_REG);
 	ctrl = old_ctrl & ~CTRL_SPEED_MASK;
 	regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
-			   MX93_GPR_ENET_QOS_INTF_MODE_MASK, 0);
+			   MX93_GPR_ENET_QOS_INTF_SEL_MASK |
+			   MX93_GPR_ENET_QOS_ENABLE, 0);
 	writel(ctrl, dwmac->base_addr + MAC_CTRL_REG);
 
 	 /* Ensure the settings for CTRL are applied. */
@@ -213,9 +215,10 @@ static void imx93_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 
 	usleep_range(10, 20);
 	iface &= MX93_GPR_ENET_QOS_INTF_SEL_MASK;
-	iface |= MX93_GPR_ENET_QOS_CLK_GEN_EN;
+	iface |= MX93_GPR_ENET_QOS_ENABLE;
 	regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
-			   MX93_GPR_ENET_QOS_INTF_MODE_MASK, iface);
+			   MX93_GPR_ENET_QOS_INTF_SEL_MASK |
+			   MX93_GPR_ENET_QOS_ENABLE, iface);
 
 	writel(old_ctrl, dwmac->base_addr + MAC_CTRL_REG);
 }
-- 
2.47.3


