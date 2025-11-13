Return-Path: <netdev+bounces-238473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D27AC594A0
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E0B3B99B3
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E786A265621;
	Thu, 13 Nov 2025 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wqI7nteE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A33357723
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056017; cv=none; b=be+yaC2uB66woFnH+VgAXZHmGy7GBzMxzr3XuyTBw02Qmg0SoxMORZinbi+IMmPrqt9l5plWV0/GrfLH5mYgVZWTbupgwsKHpej8Bngb0PhuRu9WWTxaVLqBpcwdLzftNxKuo86Ebuzv2TXQzPBWjmbrC+jbbRk1EDzNKj6qd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056017; c=relaxed/simple;
	bh=+N5/yLw8qs913D76gjeVH6Oa1+iVgKmRew/y88P3HVw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WWoSVMvxcWCs7kK9naHAQD5ChQCtQCp+FiSW4rjwDOjXuOD31zvY18NA0uyzeZBDStPZCPGNhGV7dAH31EkRXw+JuovlV78O221R7pd86RTMHNpcpb+UKhRDsCm3GnTiP01FZXLMXv1+PvowFVa1TNiSQJKCPUEbGkmPvh2rbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wqI7nteE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0rNju7eQFm0esNy2lFB6OI4OIIy97M3G9CzH/q8kZmQ=; b=wqI7nteEBuAimdgboDc56uOIV2
	exg4mCxEDbMjx/YePg6KXWXk2eJDdzeYxxZoAGQs6yK9junMVvbDQCnvt+dsnEsiJ2dnq+HalOhLW
	r0JXIQ6jhWmNsusZLnU601UmMb9Q8pWEZTJ4LQ8p99gEX8VgokwmT+xQX1Bj94pIFTFPHss0ZEZVt
	nIWynopf8au6G471C4WH1NE/6adYpZ6rKMEs/JbuFdMS1ZMslkzhaYHhsUXL5xBW6VYn4/BOL3617
	CyVeMeC1VhKUJoOHGSd9aP71X4qjXq5/bM6PJ4BEUTMeQvizo1mNaQwA4xKjAwZHEAEidvmho2BZA
	7h/c4cVg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57062 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vJbPC-000000005o4-2480;
	Thu, 13 Nov 2025 17:46:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vJbPB-0000000EBqV-27GS;
	Thu, 13 Nov 2025 17:46:45 +0000
In-Reply-To: <aRYZaKTIvfYoV3wE@shell.armlinux.org.uk>
References: <aRYZaKTIvfYoV3wE@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/4] net: stmmac: rk: use PHY_INTF_SEL_x constants
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vJbPB-0000000EBqV-27GS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Nov 2025 17:46:45 +0000

The values used in the xxx_GMAC_PHY_INTF_SEL_xxx() macros are the
phy_intf_sel values used for the dwmac core. Use these to define these
constants.

No change to produced code on aarch64.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 4257cc1f66e9..49076ee00877 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -234,7 +234,7 @@ static void rk_gmac_integrated_fephy_powerdown(struct rk_priv_data *priv,
 #define PX30_GRF_GMAC_CON1		0x0904
 
 /* PX30_GRF_GMAC_CON1 */
-#define PX30_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, 4)
+#define PX30_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RMII)
 #define PX30_GMAC_SPEED_10M		GRF_CLR_BIT(2)
 #define PX30_GMAC_SPEED_100M		GRF_BIT(2)
 
@@ -290,8 +290,8 @@ static const struct rk_gmac_ops px30_ops = {
 #define RK3128_GMAC_CLK_TX_DL_CFG(val) GRF_FIELD(6, 0, val)
 
 /* RK3128_GRF_MAC_CON1 */
-#define RK3128_GMAC_PHY_INTF_SEL_RGMII GRF_FIELD(8, 6, 1)
-#define RK3128_GMAC_PHY_INTF_SEL_RMII  GRF_FIELD(8, 6, 4)
+#define RK3128_GMAC_PHY_INTF_SEL_RGMII GRF_FIELD(8, 6, PHY_INTF_SEL_RGMII)
+#define RK3128_GMAC_PHY_INTF_SEL_RMII  GRF_FIELD(8, 6, PHY_INTF_SEL_RMII)
 #define RK3128_GMAC_FLOW_CTRL          GRF_BIT(9)
 #define RK3128_GMAC_FLOW_CTRL_CLR      GRF_CLR_BIT(9)
 #define RK3128_GMAC_SPEED_10M          GRF_CLR_BIT(10)
@@ -353,8 +353,8 @@ static const struct rk_gmac_ops rk3128_ops = {
 #define RK3228_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 /* RK3228_GRF_MAC_CON1 */
-#define RK3228_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, 1)
-#define RK3228_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, 4)
+#define RK3228_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RGMII)
+#define RK3228_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RMII)
 #define RK3228_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3228_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RK3228_GMAC_SPEED_10M		GRF_CLR_BIT(2)
@@ -432,8 +432,8 @@ static const struct rk_gmac_ops rk3228_ops = {
 #define RK3288_GRF_SOC_CON3	0x0250
 
 /*RK3288_GRF_SOC_CON1*/
-#define RK3288_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(8, 6, 1)
-#define RK3288_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(8, 6, 4)
+#define RK3288_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(8, 6, PHY_INTF_SEL_RGMII)
+#define RK3288_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(8, 6, PHY_INTF_SEL_RMII)
 #define RK3288_GMAC_FLOW_CTRL		GRF_BIT(9)
 #define RK3288_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(9)
 #define RK3288_GMAC_SPEED_10M		GRF_CLR_BIT(10)
@@ -496,7 +496,7 @@ static const struct rk_gmac_ops rk3288_ops = {
 #define RK3308_GRF_MAC_CON0		0x04a0
 
 /* RK3308_GRF_MAC_CON0 */
-#define RK3308_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(4, 2, 4)
+#define RK3308_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(4, 2, PHY_INTF_SEL_RMII)
 #define RK3308_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3308_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RK3308_GMAC_SPEED_10M		GRF_CLR_BIT(0)
@@ -535,8 +535,8 @@ static const struct rk_gmac_ops rk3308_ops = {
 #define RK3328_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 /* RK3328_GRF_MAC_CON1 */
-#define RK3328_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, 1)
-#define RK3328_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, 4)
+#define RK3328_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RGMII)
+#define RK3328_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RMII)
 #define RK3328_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3328_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RK3328_GMAC_SPEED_10M		GRF_CLR_BIT(2)
@@ -622,8 +622,8 @@ static const struct rk_gmac_ops rk3328_ops = {
 #define RK3366_GRF_SOC_CON7	0x041c
 
 /* RK3366_GRF_SOC_CON6 */
-#define RK3366_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(11, 9, 1)
-#define RK3366_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(11, 9, 4)
+#define RK3366_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(11, 9, PHY_INTF_SEL_RGMII)
+#define RK3366_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(11, 9, PHY_INTF_SEL_RMII)
 #define RK3366_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3366_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
 #define RK3366_GMAC_SPEED_10M		GRF_CLR_BIT(7)
@@ -687,8 +687,8 @@ static const struct rk_gmac_ops rk3366_ops = {
 #define RK3368_GRF_SOC_CON16	0x0440
 
 /* RK3368_GRF_SOC_CON15 */
-#define RK3368_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(11, 9, 1)
-#define RK3368_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(11, 9, 4)
+#define RK3368_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(11, 9, PHY_INTF_SEL_RGMII)
+#define RK3368_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(11, 9, PHY_INTF_SEL_RMII)
 #define RK3368_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3368_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
 #define RK3368_GMAC_SPEED_10M		GRF_CLR_BIT(7)
@@ -752,8 +752,8 @@ static const struct rk_gmac_ops rk3368_ops = {
 #define RK3399_GRF_SOC_CON6	0xc218
 
 /* RK3399_GRF_SOC_CON5 */
-#define RK3399_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(11, 9, 1)
-#define RK3399_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(11, 9, 4)
+#define RK3399_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(11, 9, PHY_INTF_SEL_RGMII)
+#define RK3399_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(11, 9, PHY_INTF_SEL_RMII)
 #define RK3399_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3399_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
 #define RK3399_GMAC_SPEED_10M		GRF_CLR_BIT(7)
@@ -1015,8 +1015,8 @@ static const struct rk_gmac_ops rk3528_ops = {
 #define RK3568_GRF_GMAC1_CON1		0x038c
 
 /* RK3568_GRF_GMAC0_CON1 && RK3568_GRF_GMAC1_CON1 */
-#define RK3568_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, 1)
-#define RK3568_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, 4)
+#define RK3568_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RGMII)
+#define RK3568_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RMII)
 #define RK3568_GMAC_FLOW_CTRL			GRF_BIT(3)
 #define RK3568_GMAC_FLOW_CTRL_CLR		GRF_CLR_BIT(3)
 #define RK3568_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(1)
@@ -1209,9 +1209,9 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GRF_CLK_CON1			0X0070
 
 #define RK3588_GMAC_PHY_INTF_SEL_RGMII(id)	\
-	(GRF_FIELD(5, 3, 1) << ((id) * 6))
+	(GRF_FIELD(5, 3, PHY_INTF_SEL_RGMII) << ((id) * 6))
 #define RK3588_GMAC_PHY_INTF_SEL_RMII(id)	\
-	(GRF_FIELD(5, 3, 4) << ((id) * 6))
+	(GRF_FIELD(5, 3, PHY_INTF_SEL_RMII) << ((id) * 6))
 
 #define RK3588_GMAC_CLK_RMII_MODE(id)		GRF_BIT(5 * (id))
 #define RK3588_GMAC_CLK_RGMII_MODE(id)		GRF_CLR_BIT(5 * (id))
@@ -1328,7 +1328,7 @@ static const struct rk_gmac_ops rk3588_ops = {
 #define RV1108_GRF_GMAC_CON0		0X0900
 
 /* RV1108_GRF_GMAC_CON0 */
-#define RV1108_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, 4)
+#define RV1108_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RMII)
 #define RV1108_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RV1108_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RV1108_GMAC_SPEED_10M		GRF_CLR_BIT(2)
@@ -1364,8 +1364,8 @@ static const struct rk_gmac_ops rv1108_ops = {
 #define RV1126_GRF_GMAC_CON2		0X0078
 
 /* RV1126_GRF_GMAC_CON0 */
-#define RV1126_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, 1)
-#define RV1126_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, 4)
+#define RV1126_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RGMII)
+#define RV1126_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RMII)
 #define RV1126_GMAC_FLOW_CTRL			GRF_BIT(7)
 #define RV1126_GMAC_FLOW_CTRL_CLR		GRF_CLR_BIT(7)
 #define RV1126_GMAC_M0_RXCLK_DLY_ENABLE		GRF_BIT(1)
-- 
2.47.3


