Return-Path: <netdev+bounces-242986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7BFC97E86
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 15:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5C0A4E0514
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973DC3195E6;
	Mon,  1 Dec 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Wx7Hk9JJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A73101A7
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600659; cv=none; b=dG6Ee3UzQdziIJh1sVXoX8ftOrg8vzrI1S1vU7rirIRWK9x/UhI4NitCFOtfqUgDa4DGCLnCMnUM4QQzcoVVKSy+va0YX3nzaLocvcUPUeDPKmt6f0hBokqRguA+tcK+DLMh3MssTL6umqUN1orX3Prut4OsNxzMHjVe4ptPnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600659; c=relaxed/simple;
	bh=cuHq/L36C01/DtIL019910Bfz2glSANx19b9ygOpwTo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jJH4NohX6o2x/qSuj/8fHhU+g0WsblU39yibfMtSorfrLFZ/tlaS4ir22RCqP6x2y1yjfNguI/FDrx0ghK1QlsriKLqq+g0XLTGc87ayU5vKkf8jExymgOUe6t3EsXjNn6xJ2cuWyXd2en36z8QiLVvd3gB4c/SCqwiA4cFNCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Wx7Hk9JJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gqZvdVoLz/zAs557F0AyMYwvA2hJhSYemA0gqhrhp6I=; b=Wx7Hk9JJymQgUxQP9MMqZ6SpCr
	q/CdjhzHq5AaMc1KKIOr0lRURANqHheiXxBANWVX7yNYUN+X+ISiWswjYGpsYVfAb7MRl9BYMPDt4
	9h0OJjBJ8wWlnQakFdlH5Nre34QPTN/jwQvm34DEoBJWB9Zibl9XH2imV5V17X2q3F+YJlTQMefpr
	3S/Tc/TwPJNk9Z87SrjFwR6MqcWGI670n9jlhqe6TTIZx4U0hA/pXoQP5hR3nznfUQasumx7EYpv9
	NMXPQI59d3F7JXqQCFWt0tsgeJ3bR1YJzz0DiHPT+YT3nTsIi4D0C1ZRm8LLgqXKUhBNnHJpjKRlY
	fvi+KrUg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51926 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vQ5Em-000000000f4-23em;
	Mon, 01 Dec 2025 14:50:48 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vQ5El-0000000GNvU-2sXL;
	Mon, 01 Dec 2025 14:50:47 +0000
In-Reply-To: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
References: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
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
Subject: [PATCH RFC net-next 01/15] net: stmmac: rk: add GMAC_CLK_xx
 constants, simplify RGMII definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vQ5El-0000000GNvU-2sXL@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 01 Dec 2025 14:50:47 +0000

All the definitions of the RGMII related xxx_GMAC_CLK_xxx definitions
use the same field values to select the clock rate. Provide common
defintions for these field values, passing them in to a single macro
for each variant that generates the appropriate values for the speed
register.

No change to produced code on aarch64.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 108 ++++++++----------
 1 file changed, 45 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 0a95f54e725e..3679081047e0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -91,6 +91,10 @@ struct rk_priv_data {
 	struct regmap *php_grf;
 };
 
+#define GMAC_CLK_DIV1_125M		0
+#define GMAC_CLK_DIV50_2_5M		2
+#define GMAC_CLK_DIV5_25M		3
+
 static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 			    const struct rk_reg_speed_data *rsd,
 			    unsigned int reg, phy_interface_t interface,
@@ -297,9 +301,7 @@ static const struct rk_gmac_ops px30_ops = {
 #define RK3128_GMAC_SPEED_100M         GRF_BIT(10)
 #define RK3128_GMAC_RMII_CLK_25M       GRF_BIT(11)
 #define RK3128_GMAC_RMII_CLK_2_5M      GRF_CLR_BIT(11)
-#define RK3128_GMAC_CLK_125M           GRF_FIELD_CONST(13, 12, 0)
-#define RK3128_GMAC_CLK_25M            GRF_FIELD_CONST(13, 12, 3)
-#define RK3128_GMAC_CLK_2_5M           GRF_FIELD_CONST(13, 12, 2)
+#define RK3128_GMAC_CLK(val)           GRF_FIELD_CONST(13, 12, val)
 #define RK3128_GMAC_RMII_MODE          GRF_BIT(14)
 #define RK3128_GMAC_RMII_MODE_CLR      GRF_CLR_BIT(14)
 
@@ -323,9 +325,9 @@ static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3128_reg_speed_data = {
-	.rgmii_10 = RK3128_GMAC_CLK_2_5M,
-	.rgmii_100 = RK3128_GMAC_CLK_25M,
-	.rgmii_1000 = RK3128_GMAC_CLK_125M,
+	.rgmii_10 = RK3128_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
+	.rgmii_100 = RK3128_GMAC_CLK(GMAC_CLK_DIV5_25M),
+	.rgmii_1000 = RK3128_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3128_GMAC_RMII_CLK_2_5M | RK3128_GMAC_SPEED_10M,
 	.rmii_100 = RK3128_GMAC_RMII_CLK_25M | RK3128_GMAC_SPEED_100M,
 };
@@ -360,9 +362,7 @@ static const struct rk_gmac_ops rk3128_ops = {
 #define RK3228_GMAC_SPEED_100M		GRF_BIT(2)
 #define RK3228_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RK3228_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
-#define RK3228_GMAC_CLK_125M		GRF_FIELD_CONST(9, 8, 0)
-#define RK3228_GMAC_CLK_25M		GRF_FIELD_CONST(9, 8, 3)
-#define RK3228_GMAC_CLK_2_5M		GRF_FIELD_CONST(9, 8, 2)
+#define RK3228_GMAC_CLK(val)		GRF_FIELD_CONST(9, 8, val)
 #define RK3228_GMAC_RMII_MODE		GRF_BIT(10)
 #define RK3228_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(10)
 #define RK3228_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
@@ -397,9 +397,9 @@ static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3228_reg_speed_data = {
-	.rgmii_10 = RK3228_GMAC_CLK_2_5M,
-	.rgmii_100 = RK3228_GMAC_CLK_25M,
-	.rgmii_1000 = RK3228_GMAC_CLK_125M,
+	.rgmii_10 = RK3228_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
+	.rgmii_100 = RK3228_GMAC_CLK(GMAC_CLK_DIV5_25M),
+	.rgmii_1000 = RK3228_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3228_GMAC_RMII_CLK_2_5M | RK3228_GMAC_SPEED_10M,
 	.rmii_100 = RK3228_GMAC_RMII_CLK_25M | RK3228_GMAC_SPEED_100M,
 };
@@ -438,9 +438,7 @@ static const struct rk_gmac_ops rk3228_ops = {
 #define RK3288_GMAC_SPEED_100M		GRF_BIT(10)
 #define RK3288_GMAC_RMII_CLK_25M	GRF_BIT(11)
 #define RK3288_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(11)
-#define RK3288_GMAC_CLK_125M		GRF_FIELD_CONST(13, 12, 0)
-#define RK3288_GMAC_CLK_25M		GRF_FIELD_CONST(13, 12, 3)
-#define RK3288_GMAC_CLK_2_5M		GRF_FIELD_CONST(13, 12, 2)
+#define RK3288_GMAC_CLK(val)		GRF_FIELD_CONST(13, 12, val)
 #define RK3288_GMAC_RMII_MODE		GRF_BIT(14)
 #define RK3288_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(14)
 
@@ -472,9 +470,9 @@ static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3288_reg_speed_data = {
-	.rgmii_10 = RK3288_GMAC_CLK_2_5M,
-	.rgmii_100 = RK3288_GMAC_CLK_25M,
-	.rgmii_1000 = RK3288_GMAC_CLK_125M,
+	.rgmii_10 = RK3288_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
+	.rgmii_100 = RK3288_GMAC_CLK(GMAC_CLK_DIV5_25M),
+	.rgmii_1000 = RK3288_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3288_GMAC_RMII_CLK_2_5M | RK3288_GMAC_SPEED_10M,
 	.rmii_100 = RK3288_GMAC_RMII_CLK_25M | RK3288_GMAC_SPEED_100M,
 };
@@ -541,9 +539,7 @@ static const struct rk_gmac_ops rk3308_ops = {
 #define RK3328_GMAC_SPEED_100M		GRF_BIT(2)
 #define RK3328_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RK3328_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
-#define RK3328_GMAC_CLK_125M		GRF_FIELD_CONST(12, 11, 0)
-#define RK3328_GMAC_CLK_25M		GRF_FIELD_CONST(12, 11, 3)
-#define RK3328_GMAC_CLK_2_5M		GRF_FIELD_CONST(12, 11, 2)
+#define RK3328_GMAC_CLK(val)		GRF_FIELD_CONST(12, 11, val)
 #define RK3328_GMAC_RMII_MODE		GRF_BIT(9)
 #define RK3328_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(9)
 #define RK3328_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
@@ -579,9 +575,9 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3328_reg_speed_data = {
-	.rgmii_10 = RK3328_GMAC_CLK_2_5M,
-	.rgmii_100 = RK3328_GMAC_CLK_25M,
-	.rgmii_1000 = RK3328_GMAC_CLK_125M,
+	.rgmii_10 = RK3328_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
+	.rgmii_100 = RK3328_GMAC_CLK(GMAC_CLK_DIV5_25M),
+	.rgmii_1000 = RK3328_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3328_GMAC_RMII_CLK_2_5M | RK3328_GMAC_SPEED_10M,
 	.rmii_100 = RK3328_GMAC_RMII_CLK_25M | RK3328_GMAC_SPEED_100M,
 };
@@ -627,9 +623,7 @@ static const struct rk_gmac_ops rk3328_ops = {
 #define RK3366_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3366_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3366_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3366_GMAC_CLK_125M		GRF_FIELD_CONST(5, 4, 0)
-#define RK3366_GMAC_CLK_25M		GRF_FIELD_CONST(5, 4, 3)
-#define RK3366_GMAC_CLK_2_5M		GRF_FIELD_CONST(5, 4, 2)
+#define RK3366_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
 #define RK3366_GMAC_RMII_MODE		GRF_BIT(6)
 #define RK3366_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
 
@@ -661,9 +655,9 @@ static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3366_reg_speed_data = {
-	.rgmii_10 = RK3366_GMAC_CLK_2_5M,
-	.rgmii_100 = RK3366_GMAC_CLK_25M,
-	.rgmii_1000 = RK3366_GMAC_CLK_125M,
+	.rgmii_10 = RK3366_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
+	.rgmii_100 = RK3366_GMAC_CLK(GMAC_CLK_DIV5_25M),
+	.rgmii_1000 = RK3366_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3366_GMAC_RMII_CLK_2_5M | RK3366_GMAC_SPEED_10M,
 	.rmii_100 = RK3366_GMAC_RMII_CLK_25M | RK3366_GMAC_SPEED_100M,
 };
@@ -692,9 +686,7 @@ static const struct rk_gmac_ops rk3366_ops = {
 #define RK3368_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3368_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3368_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3368_GMAC_CLK_125M		GRF_FIELD_CONST(5, 4, 0)
-#define RK3368_GMAC_CLK_25M		GRF_FIELD_CONST(5, 4, 3)
-#define RK3368_GMAC_CLK_2_5M		GRF_FIELD_CONST(5, 4, 2)
+#define RK3368_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
 #define RK3368_GMAC_RMII_MODE		GRF_BIT(6)
 #define RK3368_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
 
@@ -726,9 +718,9 @@ static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3368_reg_speed_data = {
-	.rgmii_10 = RK3368_GMAC_CLK_2_5M,
-	.rgmii_100 = RK3368_GMAC_CLK_25M,
-	.rgmii_1000 = RK3368_GMAC_CLK_125M,
+	.rgmii_10 = RK3368_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
+	.rgmii_100 = RK3368_GMAC_CLK(GMAC_CLK_DIV5_25M),
+	.rgmii_1000 = RK3368_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3368_GMAC_RMII_CLK_2_5M | RK3368_GMAC_SPEED_10M,
 	.rmii_100 = RK3368_GMAC_RMII_CLK_25M | RK3368_GMAC_SPEED_100M,
 };
@@ -757,9 +749,7 @@ static const struct rk_gmac_ops rk3368_ops = {
 #define RK3399_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3399_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3399_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3399_GMAC_CLK_125M		GRF_FIELD_CONST(5, 4, 0)
-#define RK3399_GMAC_CLK_25M		GRF_FIELD_CONST(5, 4, 3)
-#define RK3399_GMAC_CLK_2_5M		GRF_FIELD_CONST(5, 4, 2)
+#define RK3399_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
 #define RK3399_GMAC_RMII_MODE		GRF_BIT(6)
 #define RK3399_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
 
@@ -791,9 +781,9 @@ static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3399_reg_speed_data = {
-	.rgmii_10 = RK3399_GMAC_CLK_2_5M,
-	.rgmii_100 = RK3399_GMAC_CLK_25M,
-	.rgmii_1000 = RK3399_GMAC_CLK_125M,
+	.rgmii_10 = RK3399_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
+	.rgmii_100 = RK3399_GMAC_CLK(GMAC_CLK_DIV5_25M),
+	.rgmii_1000 = RK3399_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3399_GMAC_RMII_CLK_2_5M | RK3399_GMAC_SPEED_10M,
 	.rmii_100 = RK3399_GMAC_RMII_CLK_25M | RK3399_GMAC_SPEED_100M,
 };
@@ -900,9 +890,7 @@ static const struct rk_gmac_ops rk3506_ops = {
 #define RK3528_GMAC1_CLK_RMII_DIV2	GRF_BIT(10)
 #define RK3528_GMAC1_CLK_RMII_DIV20	GRF_CLR_BIT(10)
 
-#define RK3528_GMAC1_CLK_RGMII_DIV1	GRF_FIELD_CONST(11, 10, 0)
-#define RK3528_GMAC1_CLK_RGMII_DIV5	GRF_FIELD_CONST(11, 10, 3)
-#define RK3528_GMAC1_CLK_RGMII_DIV50	GRF_FIELD_CONST(11, 10, 2)
+#define RK3528_GMAC1_CLK_RGMII(val)	GRF_FIELD_CONST(11, 10, val)
 
 #define RK3528_GMAC0_CLK_RMII_GATE	GRF_BIT(2)
 #define RK3528_GMAC0_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
@@ -940,9 +928,9 @@ static const struct rk_reg_speed_data rk3528_gmac0_reg_speed_data = {
 };
 
 static const struct rk_reg_speed_data rk3528_gmac1_reg_speed_data = {
-	.rgmii_10 = RK3528_GMAC1_CLK_RGMII_DIV50,
-	.rgmii_100 = RK3528_GMAC1_CLK_RGMII_DIV5,
-	.rgmii_1000 = RK3528_GMAC1_CLK_RGMII_DIV1,
+	.rgmii_10 = RK3528_GMAC1_CLK_RGMII(GMAC_CLK_DIV50_2_5M),
+	.rgmii_100 = RK3528_GMAC1_CLK_RGMII(GMAC_CLK_DIV5_25M),
+	.rgmii_1000 = RK3528_GMAC1_CLK_RGMII(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3528_GMAC1_CLK_RMII_DIV20,
 	.rmii_100 = RK3528_GMAC1_CLK_RMII_DIV2,
 };
@@ -1094,9 +1082,7 @@ static const struct rk_gmac_ops rk3568_ops = {
 #define RK3576_GMAC_CLK_RMII_DIV2		GRF_BIT(5)
 #define RK3576_GMAC_CLK_RMII_DIV20		GRF_CLR_BIT(5)
 
-#define RK3576_GMAC_CLK_RGMII_DIV1		GRF_FIELD_CONST(6, 5, 0)
-#define RK3576_GMAC_CLK_RGMII_DIV5		GRF_FIELD_CONST(6, 5, 3)
-#define RK3576_GMAC_CLK_RGMII_DIV50		GRF_FIELD_CONST(6, 5, 2)
+#define RK3576_GMAC_CLK_RGMII(val)		GRF_FIELD_CONST(6, 5, val)
 
 #define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
 #define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
@@ -1140,9 +1126,9 @@ static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3578_reg_speed_data = {
-	.rgmii_10 = RK3576_GMAC_CLK_RGMII_DIV50,
-	.rgmii_100 = RK3576_GMAC_CLK_RGMII_DIV5,
-	.rgmii_1000 = RK3576_GMAC_CLK_RGMII_DIV1,
+	.rgmii_10 = RK3576_GMAC_CLK_RGMII(GMAC_CLK_DIV50_2_5M),
+	.rgmii_100 = RK3576_GMAC_CLK_RGMII(GMAC_CLK_DIV5_25M),
+	.rgmii_1000 = RK3576_GMAC_CLK_RGMII(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3576_GMAC_CLK_RMII_DIV20,
 	.rmii_100 = RK3576_GMAC_CLK_RMII_DIV2,
 };
@@ -1218,12 +1204,8 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GMA_CLK_RMII_DIV2(id)		GRF_BIT(5 * (id) + 2)
 #define RK3588_GMA_CLK_RMII_DIV20(id)		GRF_CLR_BIT(5 * (id) + 2)
 
-#define RK3588_GMAC_CLK_RGMII_DIV1(id)		\
-	(GRF_FIELD_CONST(3, 2, 0) << ((id) * 5))
-#define RK3588_GMAC_CLK_RGMII_DIV5(id)		\
-	(GRF_FIELD_CONST(3, 2, 3) << ((id) * 5))
-#define RK3588_GMAC_CLK_RGMII_DIV50(id)		\
-	(GRF_FIELD_CONST(3, 2, 2) << ((id) * 5))
+#define RK3588_GMAC_CLK_RGMII(id, val)		\
+	(GRF_FIELD_CONST(3, 2, val) << ((id) * 5))
 
 #define RK3588_GMAC_CLK_RMII_GATE(id)		GRF_BIT(5 * (id) + 1)
 #define RK3588_GMAC_CLK_RMII_NOGATE(id)		GRF_CLR_BIT(5 * (id) + 1)
@@ -1270,17 +1252,17 @@ static int rk3588_set_gmac_speed(struct rk_priv_data *bsp_priv,
 		if (interface == PHY_INTERFACE_MODE_RMII)
 			val = RK3588_GMA_CLK_RMII_DIV20(id);
 		else
-			val = RK3588_GMAC_CLK_RGMII_DIV50(id);
+			val = RK3588_GMAC_CLK_RGMII(id, GMAC_CLK_DIV50_2_5M);
 		break;
 	case 100:
 		if (interface == PHY_INTERFACE_MODE_RMII)
 			val = RK3588_GMA_CLK_RMII_DIV2(id);
 		else
-			val = RK3588_GMAC_CLK_RGMII_DIV5(id);
+			val = RK3588_GMAC_CLK_RGMII(id, GMAC_CLK_DIV5_25M);
 		break;
 	case 1000:
 		if (interface != PHY_INTERFACE_MODE_RMII)
-			val = RK3588_GMAC_CLK_RGMII_DIV1(id);
+			val = RK3588_GMAC_CLK_RGMII(id, GMAC_CLK_DIV1_125M);
 		else
 			goto err;
 		break;
-- 
2.47.3


