Return-Path: <netdev+bounces-197056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F3FAD76D0
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B2516C41A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFE229A323;
	Thu, 12 Jun 2025 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OV8rgJAQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5A429B771
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742925; cv=none; b=FrdLUG33fzPNrB0QjLDQAnPfBFqq258lpEem5unAHaaBvNFBdPOzjJ128k6i59cojJ51Tm7yNxwQks2tu2yRCY2v2rYZdKmLvNMdsF3pSkZMwsjoiWfxBeRBZRtdDGxDftCSMij2A8qBWru4a2AJkjpBOfRgvzS9IW2qXk6MyuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742925; c=relaxed/simple;
	bh=rVJO6i3t44ip08jBHwB10rrZddU2UgsS/yWANODKQsc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WcujllTKX2xI81VSwR7NfkLTcDxit0D/5QGouKl48UZTBonRTcF3TtF18uWT4d0uJFBo3H0QwJ5HQPOv7a67SsZQw2MnQb0TG1zF/K4QG/EuaYrVPSxLfE5ff0NxogVGXNY/+ZfKbvrriAWYhsKeRC66SQns+UCkwWWvWYF6V88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OV8rgJAQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wY+eCXCVGTGusBEHAW8kNT7MMSIsV/Ri13PvFprdNrs=; b=OV8rgJAQ3GWl2LTl5+MvARs5fR
	BOahYIV+iOvroz3UMVYgttPq3H7tRCaejfazD/tLSZ3LHh8cLDX3G7BZUwYe9lYtpYz0eJj6qc2Qs
	kZpMs3SmnIhAVSvSlhglCmpvZpKnI2nz12fuQjC4JA5npMds7lnQHavJ40t9oGfJXMd6Wayrj2F0J
	DV48SGaSrVeQMxNisJoocWj8csYtvKjWDOj8drh7ogoizfgB7DTVeURL/pFRtDT3kFkm33rQVoDJx
	s/yQoZWExy8KKMkzXCx4aZXIGLlNG2q6xvCxji7vz7GStAS9axu1iuyvsp+IOLPGIJlp42b0iMmhy
	YlSxP0zA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42652 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uPk3x-000858-1w;
	Thu, 12 Jun 2025 16:41:57 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uPk3J-004CFr-FE; Thu, 12 Jun 2025 16:41:17 +0100
In-Reply-To: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
References: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 8/9] net: stmmac: rk: convert px30_set_rmii_speed()
 to .set_speed()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uPk3J-004CFr-FE@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Jun 2025 16:41:17 +0100

Convert px30_set_rmii_speed() to use the common .set_speed() method,
which eliminates another user of the older .set_*_speed() methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 72f2b80bf3bb..7cdb09037da0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -246,17 +246,17 @@ static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     PX30_GMAC_PHY_INTF_SEL_RMII);
 }
 
-static void px30_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
+static int px30_set_speed(struct rk_priv_data *bsp_priv,
+			  phy_interface_t interface, int speed)
 {
 	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
 	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned int con1;
 	long rate;
-	int ret;
 
 	if (!clk_mac_speed) {
 		dev_err(dev, "%s: Missing clk_mac_speed clock\n", __func__);
-		return;
+		return -EINVAL;
 	}
 
 	if (speed == 10) {
@@ -267,20 +267,17 @@ static void px30_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 		rate = 25000000;
 	} else {
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
-		return;
+		return -EINVAL;
 	}
 
 	regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1, con1);
 
-	ret = clk_set_rate(clk_mac_speed, rate);
-	if (ret)
-		dev_err(dev, "%s: set clk_mac_speed rate %ld failed: %d\n",
-			__func__, rate, ret);
+	return clk_set_rate(clk_mac_speed, rate);
 }
 
 static const struct rk_gmac_ops px30_ops = {
 	.set_to_rmii = px30_set_to_rmii,
-	.set_rmii_speed = px30_set_rmii_speed,
+	.set_speed = px30_set_speed,
 };
 
 #define RK3128_GRF_MAC_CON0	0x0168
-- 
2.30.2


