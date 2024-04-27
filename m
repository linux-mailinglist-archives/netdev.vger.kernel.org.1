Return-Path: <netdev+bounces-91953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC63B8B4866
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 23:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BF01F21ACE
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 21:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631ED1465A5;
	Sat, 27 Apr 2024 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Vj36Wsra"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18B23A6
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714254724; cv=none; b=eqW2mFMPDix3TMFOHPWNVMjvb2+gY9K9O8U+NjN8NoQ2vG7Bd/XFdZBm0dUtk9ZcalHNgGjgdP/HOW8zdN3GEmqQe3GzWVAVWi/ZQQ7MVEFzqRSVaPwRqBZoEBce39NStZluLU4EY6vOJfeornsTcLCNT22koYvlvY7Kyq/HwzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714254724; c=relaxed/simple;
	bh=kjaGwRg+vk1xheRV8EmYftUpXgWDVG3KNkeHHOJTQTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8S36ap5nbYEXOhZmCos4EEX7+zkZgoKl7SFbxemToYQg5fzOXJ3Erkdp0lAD3IYNDdIx/eQ8WW7inv86QoCdPciBhvfYoFH06ywTYYADkClR+1KpJPF+3w3VLiES16mHLM86izHNC7S2D77x7X20FbfTjQKxd99BFyEMiKcACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Vj36Wsra; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6D54488205;
	Sat, 27 Apr 2024 23:51:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714254713;
	bh=CIOEgjbpud4dQYL+aNcVaJ26238L761Zi+HC4g1+GBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vj36WsraHrpplVFDWTMqg29Mbz3W1va5MCTjLhrxmUAu+c5KT5K4WgUaadVopT8dj
	 7HCjydvoHzCepdCubPPHitYwDyyOhwpuVXESZ7Uvk+PvRSkrIZ4SHVXOXJCvt6q23l
	 fpN9UwtAzh4VtlFNjKZJ5dKONzrWgJsln9tyzPJsqOCpKzclIj1KmDSOLkzndGIyOf
	 9Iqfti8JAfgWGOYYQw96+bwRJ7DMwhBkCsBEUMrYDEl63YuXX3QX8gffKfB33r+e3Z
	 Q5+bdCtwGYw5rSRAidJey2m3Yp5NPVxl6ECmhxGJs8Fv4vhGhnK7PZtZ26Jcc1vDX8
	 RRra32JLD4ylA==
From: Marek Vasut <marex@denx.de>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [net-next,RFC,PATCH 2/5] net: stmmac: dwmac-stm32: Separate out external clock selector
Date: Sat, 27 Apr 2024 23:50:41 +0200
Message-ID: <20240427215113.57548-2-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240427215113.57548-1-marex@denx.de>
References: <20240427215113.57548-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Pull the external clock selector into a separate function, to avoid
conflating it with external clock rate validation and clock mux
register configuration. This should make the code easier to read and
understand.

The dwmac->enable_eth_ck variable in the end indicates whether the MAC
clock are supplied by external oscillator (true) or internal RCC clock
IP (false). The dwmac->enable_eth_ck value is set based on multiple DT
properties, some of them deprecated, some of them specific to bus mode.

The following DT properties and variables are taken into account. In
each case, if the property is present or true, MAC clock is supplied
by external oscillator.
- "st,ext-phyclk", assigned to variable dwmac->ext_phyclk
  - Used in any mode (MII/RMII/GMII/RGMII)
  - The only non-deprecated DT property of the three
- "st,eth-clk-sel", assigned to variable dwmac->eth_clk_sel_reg
  - Valid only in GMII/RGMII mode
  - Deprecated property, backward compatibility only
- "st,eth-ref-clk-sel", assigned to variable dwmac->eth_ref_clk_sel_reg
  - Valid only in RMII mode
  - Deprecated property, backward compatibility only

The stm32mp1_select_ethck_external() function handles the aforementioned
DT properties and sets dwmac->enable_eth_ck accordingly.

The stm32mp1_set_mode() is adjusted to call stm32mp1_select_ethck_external()
first and then only use dwmac->enable_eth_ck to determine hardware clock mux
settings.

No functional change intended.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: netdev@vger.kernel.org
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 50 ++++++++++++++-----
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 43340a5573c64..e552cc25fb808 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -157,6 +157,37 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat, bool resume)
 	return stm32_dwmac_clk_enable(dwmac, resume);
 }
 
+static int stm32mp1_select_ethck_external(struct plat_stmmacenet_data *plat_dat)
+{
+	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
+
+	switch (plat_dat->mac_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		dwmac->enable_eth_ck = dwmac->ext_phyclk;
+		return 0;
+	case PHY_INTERFACE_MODE_GMII:
+		dwmac->enable_eth_ck = dwmac->eth_clk_sel_reg ||
+				       dwmac->ext_phyclk;
+		return 0;
+	case PHY_INTERFACE_MODE_RMII:
+		dwmac->enable_eth_ck = dwmac->eth_ref_clk_sel_reg ||
+				       dwmac->ext_phyclk;
+		return 0;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		dwmac->enable_eth_ck = dwmac->eth_clk_sel_reg ||
+				       dwmac->ext_phyclk;
+		return 0;
+	default:
+		dwmac->enable_eth_ck = false;
+		dev_err(dwmac->dev, "Mode %s not supported",
+			phy_modes(plat_dat->mac_interface));
+		return -EINVAL;
+	}
+}
+
 static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
 {
 	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
@@ -197,28 +228,25 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	u32 reg = dwmac->mode_reg;
 	int val, ret;
 
-	dwmac->enable_eth_ck = false;
+	ret = stm32mp1_select_ethck_external(plat_dat);
+	if (ret)
+		return ret;
+
 	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
-		if (dwmac->ext_phyclk)
-			dwmac->enable_eth_ck = true;
 		val = SYSCFG_PMCR_ETH_SEL_MII;
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
 		break;
 	case PHY_INTERFACE_MODE_GMII:
 		val = SYSCFG_PMCR_ETH_SEL_GMII;
-		if (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk) {
-			dwmac->enable_eth_ck = true;
+		if (dwmac->enable_eth_ck)
 			val |= SYSCFG_PMCR_ETH_CLK_SEL;
-		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_GMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val = SYSCFG_PMCR_ETH_SEL_RMII;
-		if (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk) {
-			dwmac->enable_eth_ck = true;
+		if (dwmac->enable_eth_ck)
 			val |= SYSCFG_PMCR_ETH_REF_CLK_SEL;
-		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
@@ -226,10 +254,8 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val = SYSCFG_PMCR_ETH_SEL_RGMII;
-		if (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk) {
-			dwmac->enable_eth_ck = true;
+		if (dwmac->enable_eth_ck)
 			val |= SYSCFG_PMCR_ETH_CLK_SEL;
-		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
 		break;
 	default:
-- 
2.43.0


