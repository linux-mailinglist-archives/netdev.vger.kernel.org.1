Return-Path: <netdev+bounces-211851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE452B1BE39
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 03:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0500189C9F2
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 01:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9605502BE;
	Wed,  6 Aug 2025 01:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="AK7nXAMQ"
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F37B2A1BA;
	Wed,  6 Aug 2025 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442972; cv=none; b=irxoI3T3MGzaX3C0N8rS9xvIccT0jFxCOO5e2oYYU3vm5YEZHcASPktdk4uXjFC5MDIJZyXcrCWhmLvl0sWN60qByBDI1L22WMLp5/3xciZ1ckw8gRNJ9sXALl+gUsvqzQVeWB4cImirW0PRNNsdPc2KpNtIvGprPYG3254EwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442972; c=relaxed/simple;
	bh=HiKJMKrrzhKdrbo1xtyqabyBvkLf4kGU95hdMN3rE2g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=shU4GKFUEZ9cCUETvuuUsWN7Sm7vYxJMQAX6t7HQH1eIs1A6MpUH2XzvP7Qz0dxbZqrWzcvRQQhPHHZl67bH3OEFlDfS6GL6zG+JteYP/A3FbXuDREo2I89dhbv2iRCOuA8O69A6mp+xHcgSIKerXsilg32WRLYmVINgpEsD4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=AK7nXAMQ; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1754442853;
	bh=V4RaJ1Se4NL5O3wmyRABO7eqwflr25ayetGnQRjwR4g=;
	h=From:To:Subject:Date:Message-Id;
	b=AK7nXAMQYnBNo9K3x7aZh+dRBs+h/4oOxAjeSWeXxmwmxF0JHdlgSAAnmk5AdjmHX
	 sQq62d8zLJzU0xxNctRsNQdnkxTnewwj8J3g9Mmoo5w4EeGDa72U1eJWPDn1eAhqO2
	 lnuQl995SiBJ+QpDsj60l8ijYB5tACLTkwzjvFHY=
X-QQ-mid: zesmtpsz5t1754442851tccb2169c
X-QQ-Originating-IP: Upns4K98WQPZ+nhbkTV8Mu3PYlo3Q5rJ1jS/uYj8JwI=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 Aug 2025 09:14:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 794500594761782103
From: Chaoyi Chen <kernel@airkyi.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonas Karlman <jonas@kwiboo.se>,
	David Wu <david.wu@rock-chips.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH] net: ethernet: stmmac: dwmac-rk: Make the clk_phy could be used for external phy
Date: Wed,  6 Aug 2025 09:14:05 +0800
Message-Id: <20250806011405.115-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NoS5wdqc5dY8filCnKoiiWDopRo26igGdH6iGYEmjDqUfx/9BANeJNq3
	0DRir6bzns71Jpv2LTy2tL3fy/lfRpksUP02w4zWqlkmo3JELULpXJHmPKJi7N3G9nIoNy4
	//I6Qqtrc0PK21vl2LUoz0OE6YndlVol9L6fZqVKjxEns7CeCWKfoUP6wRs27n+g5GrUfRx
	xMxow+ie2PWHpo0Nxp5S+KXWp1xntXVNKjnpMhmdsM4u7zNLZuFAh4CYecXpBTMKDluLMrH
	CCEkQZJc2ehOmnAToxXXxwalnMPzbcrg5lbT1iTEOuSRlUMasuOe2Rob5hIDlapli6t3mFC
	naV6w8SH5d5XgRmUhBEX/Uw1Z7om62W+hNqaD/Dt/Nh/Tpn90pm20vJ8X/16up5ZYrQ5bag
	IxElEDAgW5XWszbmEBMM3o31Q7Cuz3qExl8slE+isFUNGA7JeyKW40LvedB1M67BcsykbQU
	fROPJiAElvvEU9RK428OIOE4pBhe8oN3VI3xkAaSoBaYcAV7965b04wKukExrvwdBvR8Eel
	QRtH8GPa5blNi/3gH4fr/rnsWCaN9qXiruBR2jmMTxu51lgSIE63IGM04Ft0+yA9djdRwij
	SLy4g71xKyaaNF0i+seB+cg8x1/NaBDlAhTaLKjTKm5g/zu3Hr9YG4iXWmXVxgvIIV46T5m
	qKFeWe2A78yOyhExsLm9/yyjaufBMFqezpU+7c+8jgivPx9Edyim+ZLu97ylAOewp/UC3Vy
	hlan9MQygEYRD1SsZbAwoSI43W1OEuShf2Z4houQiPyRGiYYjuoCX781MHCxLvmc8+61tY8
	hibdqXiZ4xjDFjTEMClkKA1tP0FYj1xs+J4/Ms+tYvB+UmLLluT9c3/fYIKlyVjU46PCfXJ
	2Tl5M0lA3NCXwBFRxB9HgN28H67v6M30V9+hRdRQNND3DyjbP1YtUeW1fPtGSmFYz18Inuq
	CCZWWvCsTuj68WRBLF/P508RjpOsbPYz+bwo=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

For external phy, clk_phy should be optional, and some external phy
need the clock input from clk_phy. This patch adds support for setting
clk_phy for external phy.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 700858ff6f7c..703b4b24f3bc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1558,6 +1558,7 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 	struct device *dev = &bsp_priv->pdev->dev;
 	int phy_iface = bsp_priv->phy_iface;
 	int i, j, ret;
+	unsigned int rate;
 
 	bsp_priv->clk_enabled = false;
 
@@ -1595,12 +1596,19 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 		clk_set_rate(bsp_priv->clk_mac, 50000000);
 	}
 
-	if (plat->phy_node && bsp_priv->integrated_phy) {
+	if (plat->phy_node) {
 		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
 		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
-		if (ret)
-			return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
-		clk_set_rate(bsp_priv->clk_phy, 50000000);
+		/* If it is not integrated_phy, clk_phy is optional */
+		if (bsp_priv->integrated_phy) {
+			if (ret)
+				return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
+
+			ret = of_property_read_u32(plat->phy_node, "clock-frequency", &rate);
+			if (ret)
+				rate = 0;
+			clk_set_rate(bsp_priv->clk_phy, rate ? rate : 50000000);
+		}
 	}
 
 	return 0;
-- 
2.49.0


