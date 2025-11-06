Return-Path: <netdev+bounces-236293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5950C3A94C
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6887C42472E
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067C030E838;
	Thu,  6 Nov 2025 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1gKYzpft"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A67630E849
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428243; cv=none; b=Ealqkf7HLgkPuzbzM86fl4wWjLAeC8aSV+EwQ0c/9UCEd44GWMkHb8bH7zVVfw3TWL6J0A36BBo4RQpv395OZkV0mFIpeMym25l7WvkSUqUAf40ypA1pkl7tdWajst0tMpyBwox7eS/umnOFFPeLxoN+Qi82WUBRLSmPc+9OekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428243; c=relaxed/simple;
	bh=HvUrfZMOTV2Y1kIo8VOssHiuSsHR2AwsJI7RQArNVYQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=QPWVNiD1QS/AapviuYWiQcPCp9UVv7qiFMFqcQWY+mxZQo89MWbOKaSIb5xIvoIcMqxSK41/PSX003GXmnEhax8Tjb9WAfyGoS7jVTgfVXzmWW133zChXu+ux4mYkXI1jBWlQBasTqDBtCtr6LRKZH791794/pyb52YMHshx304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1gKYzpft; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UzBB2UijmCHVcRf7zDJoQKSDLaPP35srt0SKwOk7mnI=; b=1gKYzpftgWqRE5TRemFZNjchAw
	kUej7N0A1oleBKN8fdgR3jJemeX3S85a2ohNJGFOc1EeYIp0urBE8xR0gm9VNR8znWWOCBKHYHlZ6
	0FVu1ocR+LwdGxurJVqe/gGgl0H1kiOH4c/9Ux6Y/fTeacQndeQGGwcGmtswBGzZXnRIP65xhOQkc
	09GA+qeZvQdGLOcLqDRx2J8weQZtmg5QhOaVtp/ZZ9sFWxASNRa/lra0X72vp3IMBxAlsCPc3Ldqc
	uJtUVDpLJPgQBRXEmgvGNIpqlrfUDS8o18MnM0THVA1UD8QSut22pswYRuSoXjdoTfeFTfhoDhUoq
	4D1tQaAA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60354 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGy5q-000000004wp-0M57;
	Thu, 06 Nov 2025 11:23:54 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGy5o-0000000DhQn-34JE;
	Thu, 06 Nov 2025 11:23:52 +0000
In-Reply-To: <aQyEs4DAZRWpAz32@shell.armlinux.org.uk>
References: <aQyEs4DAZRWpAz32@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH net-next 9/9] net: stmmac: sti: use ->set_phy_intf_sel()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGy5o-0000000DhQn-34JE@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 11:23:52 +0000

Rather than placing the phy_intf_sel() setup in the ->init() method,
move it to the new ->set_phy_intf_sel() method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sti.c   | 25 +++++++------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
index 593e154b5957..b0509ab6b31c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
@@ -146,17 +146,18 @@ static void stih4xx_fix_retime_src(void *priv, int spd, unsigned int mode)
 			   stih4xx_tx_retime_val[src]);
 }
 
-static int sti_dwmac_set_mode(struct sti_dwmac *dwmac)
+static int sti_set_phy_intf_sel(void *bsp_priv, u8 phy_intf_sel)
 {
-	struct regmap *regmap = dwmac->regmap;
-	u32 reg = dwmac->ctrl_reg;
-	int phy_intf_sel;
-	u32 val;
+	struct sti_dwmac *dwmac = bsp_priv;
+	struct regmap *regmap;
+	u32 reg, val;
+
+	regmap = dwmac->regmap;
+	reg = dwmac->ctrl_reg;
 
 	if (dwmac->gmac_en)
 		regmap_update_bits(regmap, reg, EN_MASK, EN);
 
-	phy_intf_sel = stmmac_get_phy_intf_sel(dwmac->interface);
 	if (phy_intf_sel != PHY_INTF_SEL_GMII_MII &&
 	    phy_intf_sel != PHY_INTF_SEL_RGMII &&
 	    phy_intf_sel != PHY_INTF_SEL_SGMII &&
@@ -231,17 +232,8 @@ static int sti_dwmac_parse_data(struct sti_dwmac *dwmac,
 static int sti_dwmac_init(struct platform_device *pdev, void *bsp_priv)
 {
 	struct sti_dwmac *dwmac = bsp_priv;
-	int ret;
-
-	ret = clk_prepare_enable(dwmac->clk);
-	if (ret)
-		return ret;
-
-	ret = sti_dwmac_set_mode(dwmac);
-	if (ret)
-		clk_disable_unprepare(dwmac->clk);
 
-	return ret;
+	return clk_prepare_enable(dwmac->clk);
 }
 
 static void sti_dwmac_exit(struct platform_device *pdev, void *bsp_priv)
@@ -286,6 +278,7 @@ static int sti_dwmac_probe(struct platform_device *pdev)
 	dwmac->fix_retime_src = data->fix_retime_src;
 
 	plat_dat->bsp_priv = dwmac;
+	plat_dat->set_phy_intf_sel = sti_set_phy_intf_sel;
 	plat_dat->fix_mac_speed = data->fix_retime_src;
 	plat_dat->init = sti_dwmac_init;
 	plat_dat->exit = sti_dwmac_exit;
-- 
2.47.3


