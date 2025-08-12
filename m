Return-Path: <netdev+bounces-212700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80377B21A14
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C954609AB
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D68A2D46DD;
	Tue, 12 Aug 2025 01:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="Nof0oMhK"
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A10BF9EC;
	Tue, 12 Aug 2025 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754961799; cv=none; b=jjWsenjfp0D2KbHnQjsG0llx6RXChXBC6/6QXILGktPs7u0Nl98JhSxVd9miTiqWSdr3/1jjAQR31di1lMGCD+WU+DeA1BS+BLTcMq3ePRUn1WQSGEyeC3Mez58a/ibCfzxBLq/QjORWV77A84G3wGOOyHz/M86kgcqxlAAjoAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754961799; c=relaxed/simple;
	bh=JDdrAFA+4+2WSGgI580DFOJdGhWmb2e0MaidwUHa2Gc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=KSYtg20yg4lOXoe86pRCHsoie2kOxPXKaUKLGDXosxYWbfgu2+y6tTp2iy77GET9lts+CQ8Dy4ESg2PF08JpHyQhJa8sMudciG0Eet3DIaXe52S2dHmL+YXoYHxDs5F7dvKtoIBPHxoOHzgwEWptsUZrL3wbymwo8fpS3fqvPH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=Nof0oMhK; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1754961696;
	bh=DXt1l6NWEaWvzzRNmToj4TiWvhp///AcGoYhD9MVs5s=;
	h=From:To:Subject:Date:Message-Id;
	b=Nof0oMhKtKmIn/22ZAPux75Kuq2h0QAuobVGpPP5iXsQV68LNB7HhKw+TckXvNQdP
	 XihKIHpOYuaPjQxVeNJzShx7DORpTyijMxxv1+CoSLcXu6ZLIRVKqMEmUdK5bh0jYK
	 /UTqHQt853NGqlEBJHadmeYhKjLfz/06WzA+0tgk=
X-QQ-mid: zesmtpgz1t1754961694t7321c736
X-QQ-Originating-IP: AO0T0YrLnu0VCFmyG0tj5tjzd+Lt/0si4Io9f5QdS7Y=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 09:21:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6442695282303422714
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
Subject: [PATCH net-next v2] net: ethernet: stmmac: dwmac-rk: Make the clk_phy could be used for external phy
Date: Tue, 12 Aug 2025 09:21:27 +0800
Message-Id: <20250812012127.197-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NSEFX6u+4l+K7TWvxdky8ksyKCIi64Qy2e+dvVbjeTAEhhpOVwFfVSMp
	4eJ0ntfE28l8on9fQ64b6AncSDHiBuqSpfhIoz/F7yk2n9MaP6mtfOAarPAuc9T2s2rk3Mt
	OWd7k7uVOJPe75fZf1ZDfNYsDH/ef9ruDyGmxKpFKEjGv82b6vhroXLCXvTHxD99w28nyfC
	P+6GuIfKoFwBdUVkgouDRBdsslLMamxnlDY9kfd4AfsBXAIfOslr6mR9P7cM1StCkHu1yy2
	mNjjVNYs5W/PzxoxDzhY7XXs2wX4Fta+LeTIzVm5chlICpGu+kJQUbWwBFTR1bS6o9m2M/o
	TNlced8V5pENFlIgsYYbsIAdFuh0H9oWSrNAdQlqVONDuaxiPwpWQ2EOKcF6ythPU/c6f3s
	UeeDkcMSohFKkzojqC083MMOsj0t888svYdbbhLdOGr7ASBvKwwPmG27PHbFRAJGmDMiAna
	m2CO5v3rgnrpcYmB5jADg//n4pr9sNq6dLHufMMY0ghoGkjx5yPq3SyMAaOLS7eoWGwl82I
	ZGp2MEtf9HvLkzbvVRCe2NPM7TUpN2YE4586JVssGTSxZmbWkmlzqv7LkAuAJIBzIb/v1iJ
	MCX5A4IikYD21ozZ4P5DplIk/4Q7bIP894bN6flYKxothcoG9s6DZKBdw+NZ2uVTlwmNjVs
	xlMfDGhQwZlY2sHlgR7SSxvFL3Lu+QNPWpU5Yjey5ZY4Z0j7burS6IoCMHqOfEEHcrwD7Ni
	IAzTPEZRrEmz55IeRZgo38sS6eGhSNXeHBy37OQ5DivQ8DXx/RIn0ik/cPweAZQztLYF3k6
	HNBuKi8XgP1ZoHXq1ytAiC3fFHTyx2oBiOazyzElWPkokwa+/1L8WR/rbJ/d3ozUXE07nW5
	+b5CSnBtavQdgnXySmJevYAPcfitKLlQN/M1MJ2GFLeFvr0RUtoCGyQXRguNOG0lwPKkwwD
	Y+VwFcxBw5u6KghoKpRM1nM/7TGU8YKtdGOMUbnnXb2/sHxA6GySGpvlzCByY6cqOtqI=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

Changes in v2:
- Link to V1: https://lore.kernel.org/netdev/20250806011405.115-1-kernel@airkyi.com/
- Remove get clock frequency from DT prop

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 700858ff6f7c..36fab70283de 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1595,12 +1595,15 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
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
+			clk_set_rate(bsp_priv->clk_phy, 50000000);
+		}
 	}
 
 	return 0;
-- 
2.49.0


