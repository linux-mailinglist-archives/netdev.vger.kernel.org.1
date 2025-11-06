Return-Path: <netdev+bounces-236202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 757F2C39B22
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 09:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7847E3BEEA4
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 08:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B768B309DC4;
	Thu,  6 Nov 2025 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="q5Kr8gpv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5401309DB1
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419501; cv=none; b=beVZELRzqU3dO+FeitFVr2DTmkOE2g7IAJtMOjaXsxmERVNhZjLxBNs8UvsUR5Y1FuE4lh+qez/HRq5eMzNsvpizx8h6ZD1m53hh4FTHq9HYqCM9UK0GeK5mKdJJtrDyqhZ5sNQvxxXwiw+ol/DpIvZ75wWFRi8R5rgSQssP21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419501; c=relaxed/simple;
	bh=VMgFHFpq6CLnO2ceaKxatDHh5omePnQrQbm5SKKGgnQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=mLNDSVFIFWurtxBSqaP8u/a63oIEVvyDakzs7Nh1m42ttf3NdRomhLlpNlStmGK/yt4j6QBcApq80GcLoE1x2WxzRyjGgW8wEP8s3p1qA0mkEEbD7+SVLDMBQlEGoGBysPByL03mtIcf51YqylaTocnS90uzHEPV/10S5TsaQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=q5Kr8gpv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PBhWxaZT6UffHDdX98fOIO9jD70cg+pB2X4Sy7SNo5w=; b=q5Kr8gpvzEluu+RhV+3CM5qk3Q
	iqA0qxJsm5+auVWRRouecZ0rHvYciW3+zhhao/UfgcSurfYhdqDLs0xP8NTjHvA135GiVev298FvO
	eL525qJz8TIbk9OLI1duVKd8YcUTfKnNTrtEaHqfo7SqpYg5uMkFYMpq0O9nreAyengnBD6tuMfES
	dsPMie3sVW5MfYYWDjT7bbQcofdjx7f3oJEePB+i4/v1xHVIeIuYZmzUEzj8CdFehouuZqLIleblr
	6RlfMsyjunPSAD7tvsTxnVyghMwhTupoq1IDqe8MhvDvEpzFBxHORB8DGNJfoGZD0zq4dILXySqcp
	CDN+ahqw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35048 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGvop-000000004a8-3g7B;
	Thu, 06 Nov 2025 08:58:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGvoo-0000000DWpK-47nP;
	Thu, 06 Nov 2025 08:58:11 +0000
In-Reply-To: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
References: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 11/11] net: stmmac: ingenic: use
 ->set_phy_intf_sel()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGvoo-0000000DWpK-47nP@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 08:58:10 +0000

Rather than placing the phy_intf_sel() setup in the ->init() method,
move it to the new ->set_phy_intf_sel() method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 33 +++++++------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 41a2071262bc..957bc78d5a1e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -134,32 +134,21 @@ static int x2000_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
-static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
+static int ingenic_set_phy_intf_sel(void *bsp_priv, u8 phy_intf_sel)
 {
 	struct ingenic_mac *mac = bsp_priv;
-	phy_interface_t interface;
-	int phy_intf_sel, ret;
-
-	if (mac->soc_info->set_mode) {
-		interface = mac->plat_dat->phy_interface;
-
-		phy_intf_sel = stmmac_get_phy_intf_sel(interface);
-		if (phy_intf_sel < 0 || phy_intf_sel >= BITS_PER_BYTE ||
-		    ~mac->soc_info->valid_phy_intf_sel & BIT(phy_intf_sel)) {
-			dev_err(mac->dev, "unsupported interface %s\n",
-				phy_modes(interface));
-			return phy_intf_sel < 0 ? phy_intf_sel : -EINVAL;
-		}
 
-		dev_dbg(mac->dev, "MAC PHY control register: interface %s\n",
-			phy_modes(interface));
+	if (!mac->soc_info->set_mode)
+		return 0;
 
-		ret = mac->soc_info->set_mode(mac, phy_intf_sel);
-		if (ret)
-			return ret;
-	}
+	if (phy_intf_sel >= BITS_PER_BYTE ||
+	    ~mac->soc_info->valid_phy_intf_sel & BIT(phy_intf_sel))
+		return phy_intf_sel < 0 ? phy_intf_sel : -EINVAL;
+
+	dev_dbg(mac->dev, "MAC PHY control register: interface %s\n",
+		phy_modes(mac->plat_dat->phy_interface));
 
-	return 0;
+	return mac->soc_info->set_mode(mac, phy_intf_sel);
 }
 
 static int ingenic_mac_probe(struct platform_device *pdev)
@@ -221,7 +210,7 @@ static int ingenic_mac_probe(struct platform_device *pdev)
 	mac->plat_dat = plat_dat;
 
 	plat_dat->bsp_priv = mac;
-	plat_dat->init = ingenic_mac_init;
+	plat_dat->set_phy_intf_sel = ingenic_set_phy_intf_sel;
 
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
-- 
2.47.3


