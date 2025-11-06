Return-Path: <netdev+bounces-236289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF72C3A931
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886C34604C6
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEAC305954;
	Thu,  6 Nov 2025 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xCxiD2W5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947FE30BF66
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428223; cv=none; b=PESjttJaLSuAVm10n1t/iTOnDUlYwK/Wz7kd2C7XtgtQPj2u84R9BKhHkdBVCdY9m6SGlklc0URbGHmPaZklnyiNEMmAL/8FRzNTjc9Ohi4Jmtb6bQc9ow9kAlAK1NDGjcv/gZCVpIAnU4btZ3sF/OiLS25MpGGoWj98R5BPwK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428223; c=relaxed/simple;
	bh=0XFlutlzePv4GxXHcSvV/7VTujQe7bGVK1MHhpUF7E8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=EvtGjkA9XnRHnO7/YJFTyKWByYvAtb0s3PDTQDERE4d5kQLJMPswJ5XpXRSAD3tbD6eV3BsELU8FlGjUFhHQtsvrPrt8hWfaHumSKZW7TgCsgcYfWmmAeQXOsPCikzAplev6pe1gmQD/hlOku4ZZfXgku9EnuAy2jz2YwrW1swA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xCxiD2W5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Pm3M/GkwAlHdRzJaOCKAH5BeWyh6teUGh1ibpL2tD7I=; b=xCxiD2W5WoDjma1U32cRXi0Z98
	m7N1XQNJINfJqlct9VjhLk0lknOuakFec2B+HirRWbu5kLNbY7GwpiO1xpH3lOn19xkEFHO26twcX
	8Eunx0cWitlALSVMHFfz7F7dTd79Tq5ntzyumajWUHB7nm71gOC5uqqlwk9MZtOwb+Ir/+nh++xN5
	YHA+kEoNwoWCJt7XvEhxdmSpLOaTzxOuUBtE/I4dq+IPd7ovCVsNpOY2SDA4iCHPB7HJtT+hM3AN/
	+ekExdH2xvktv49yd3cjVgNZe83qqC27QFdRZcxcTtdKSuenle20S6Y0pwmX0H3AWFFfLlpPTT8gS
	whXK9X2g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53554 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGy5V-000000004vP-0N8H;
	Thu, 06 Nov 2025 11:23:33 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGy5U-0000000DhQP-19Hd;
	Thu, 06 Nov 2025 11:23:32 +0000
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
Subject: [PATCH net-next 5/9] net: stmmac: lpc18xx: use ->set_phy_intf_sel()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGy5U-0000000DhQP-19Hd@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 11:23:32 +0000

Move the configuration of the dwmac PHY interface selection to the new
->set_phy_intf_sel() method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-lpc18xx.c   | 36 +++++++++++--------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
index ec60968113b8..c68d7de1f8ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
@@ -23,12 +23,27 @@
 #define LPC18XX_CREG_CREG6			0x12c
 # define LPC18XX_CREG_CREG6_ETHMODE_MASK	GENMASK(2, 0)
 
+static int lpc18xx_set_phy_intf_sel(void *bsp_priv, u8 phy_intf_sel)
+{
+	struct regmap *reg = bsp_priv;
+
+	if (phy_intf_sel != PHY_INTF_SEL_GMII_MII &&
+	    phy_intf_sel != PHY_INTF_SEL_RMII)
+		return -EINVAL;
+
+	regmap_update_bits(reg, LPC18XX_CREG_CREG6,
+			   LPC18XX_CREG_CREG6_ETHMODE_MASK,
+			   FIELD_PREP(LPC18XX_CREG_CREG6_ETHMODE_MASK,
+				      phy_intf_sel));
+
+	return 0;
+}
+
 static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
-	struct regmap *reg;
-	u8 ethmode;
+	struct regmap *regmap;
 	int ret;
 
 	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
@@ -41,21 +56,14 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 
 	plat_dat->core_type = DWMAC_CORE_GMAC;
 
-	reg = syscon_regmap_lookup_by_compatible("nxp,lpc1850-creg");
-	if (IS_ERR(reg)) {
+	regmap = syscon_regmap_lookup_by_compatible("nxp,lpc1850-creg");
+	if (IS_ERR(regmap)) {
 		dev_err(&pdev->dev, "syscon lookup failed\n");
-		return PTR_ERR(reg);
-	}
-
-	ethmode = stmmac_get_phy_intf_sel(plat_dat->phy_interface);
-	if (ethmode != PHY_INTF_SEL_GMII_MII &&
-	    ethmode != PHY_INTF_SEL_RMII) {
-		dev_err(&pdev->dev, "Only MII and RMII mode supported\n");
-		return -EINVAL;
+		return PTR_ERR(regmap);
 	}
 
-	regmap_update_bits(reg, LPC18XX_CREG_CREG6,
-			   LPC18XX_CREG_CREG6_ETHMODE_MASK, ethmode);
+	plat_dat->bsp_priv = regmap;
+	plat_dat->set_phy_intf_sel = lpc18xx_set_phy_intf_sel;
 
 	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 }
-- 
2.47.3


