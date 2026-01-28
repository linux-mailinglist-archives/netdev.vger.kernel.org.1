Return-Path: <netdev+bounces-254206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEuCJfHreWkF1AEAu9opvQ
	(envelope-from <netdev+bounces-254206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:58:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 348BF9FD47
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C4B7300C809
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FAE33A707;
	Wed, 28 Jan 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="anskj2M2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F62DC798
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597935; cv=none; b=P5/Op+lhDikdnYrxOrJUzEFr70qqSKE51GcWZaoK5tDb454XRNovZqcKnirWkdWsF1o+ufdtum/u57whYu/af5pBxGrBxmd0Fo/l2h9z+ndTLr4pUW9uivvMhlwedK4e7cviiB51N83Y24B7QlHZSwxJPIFLZT9rShNWTgfhnlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597935; c=relaxed/simple;
	bh=RVF0p/z/5AEb3CMNKa1yMW9qTsLXJ040SFWzWUUJLDA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=s3PpnghCbP9cuCX5AgKQ77WA9dm2yMxJU7jPIx+UOhiTgVZLK/eByVBxKIDtLcJwgFGs1GrtvtSpTBwYB5C55jQ0K3V+30dVQB6OtrIBD2FzPrIgGq//uhJovibEVdedVa67sKLLj96X+IVr/P8vTb9kFJjL/KjPsqepU4m+5dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=anskj2M2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ou39/Xy5Es2A6iCJkQTz7Z9vwTYRb2TloAc6XqwUygc=; b=anskj2M22BVF7cplWISIrvo68a
	wFwexeWinkW9YUCAdGLveHvl+E39zpYi1idTYZKZiSZRNfLfubyebt68CmTZQxTNd6Se6EF9hEbfX
	2jSIcG6Rx0ceQUz8w4TeMn+CPrO32gYxVZmeLGWMHgH2661A5WTlLnUrhZOL6E2ExaFK6OgiKgY8z
	QvzGwbgY8Zi85I2CfCUhKZotIxcRKVMJzFDyOJLYjdD2ArB2bKnOso4AfCHt8Q3ShSXKhOrVU13lU
	d96NwEfT/vuc1dsZqhvzlf27Qwl2mr/lWuQDbId/5vBr0Li++PhCesltfpfdawQoRz37HzwRMJAN8
	NC4Tf83A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42252 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vl3G1-000000007G4-1g4u;
	Wed, 28 Jan 2026 10:58:45 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vl3G0-00000006v3R-2ZBc;
	Wed, 28 Jan 2026 10:58:44 +0000
In-Reply-To: <aXnrzIbZN-gaZTia@shell.armlinux.org.uk>
References: <aXnrzIbZN-gaZTia@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH net-next 2/3] net: stmmac: rk: add GMAC_CLK_xx constants,
 simplify RGMII definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vl3G0-00000006v3R-2ZBc@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 28 Jan 2026 10:58:44 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254206-lists,netdev=lfdr.de,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 348BF9FD47
X-Rspamd-Action: no action

All the definitions of the RGMII related xxx_GMAC_CLK_xxx definitions
use the same field values to select the clock rate. Provide common
definitions for these field values, passing them in to a single macro
for each variant that generates the appropriate values for the speed
register.

No change to produced code on aarch64.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 108 ++++++++----------
 1 file changed, 45 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index bc69cbb5a7d4..976d42fd90df 100644
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
@@ -299,9 +303,7 @@ static const struct rk_gmac_ops px30_ops = {
 #define RK3128_GMAC_SPEED_100M         GRF_BIT(10)
 #define RK3128_GMAC_RMII_CLK_25M       GRF_BIT(11)
 #define RK3128_GMAC_RMII_CLK_2_5M      GRF_CLR_BIT(11)
-#define RK3128_GMAC_CLK_125M           GRF_FIELD_CONST(13, 12, 0)
-#define RK3128_GMAC_CLK_25M            GRF_FIELD_CONST(13, 12, 3)
-#define RK3128_GMAC_CLK_2_5M           GRF_FIELD_CONST(13, 12, 2)
+#define RK3128_GMAC_CLK(val)           GRF_FIELD_CONST(13, 12, val)
 #define RK3128_GMAC_RMII_MODE          GRF_BIT(14)
 #define RK3128_GMAC_RMII_MODE_CLR      GRF_CLR_BIT(14)
 
@@ -325,9 +327,9 @@ static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
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
@@ -362,9 +364,7 @@ static const struct rk_gmac_ops rk3128_ops = {
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
@@ -399,9 +399,9 @@ static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
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
@@ -440,9 +440,7 @@ static const struct rk_gmac_ops rk3228_ops = {
 #define RK3288_GMAC_SPEED_100M		GRF_BIT(10)
 #define RK3288_GMAC_RMII_CLK_25M	GRF_BIT(11)
 #define RK3288_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(11)
-#define RK3288_GMAC_CLK_125M		GRF_FIELD_CONST(13, 12, 0)
-#define RK3288_GMAC_CLK_25M		GRF_FIELD_CONST(13, 12, 3)
-#define RK3288_GMAC_CLK_2_5M		GRF_FIELD_CONST(13, 12, 2)
+#define RK3288_GMAC_CLK(val)		GRF_FIELD_CONST(13, 12, val)
 #define RK3288_GMAC_RMII_MODE		GRF_BIT(14)
 #define RK3288_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(14)
 
@@ -474,9 +472,9 @@ static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
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
@@ -543,9 +541,7 @@ static const struct rk_gmac_ops rk3308_ops = {
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
@@ -580,9 +576,9 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
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
@@ -632,9 +628,7 @@ static const struct rk_gmac_ops rk3328_ops = {
 #define RK3366_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3366_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3366_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3366_GMAC_CLK_125M		GRF_FIELD_CONST(5, 4, 0)
-#define RK3366_GMAC_CLK_25M		GRF_FIELD_CONST(5, 4, 3)
-#define RK3366_GMAC_CLK_2_5M		GRF_FIELD_CONST(5, 4, 2)
+#define RK3366_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
 #define RK3366_GMAC_RMII_MODE		GRF_BIT(6)
 #define RK3366_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
 
@@ -666,9 +660,9 @@ static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
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
@@ -697,9 +691,7 @@ static const struct rk_gmac_ops rk3366_ops = {
 #define RK3368_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3368_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3368_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3368_GMAC_CLK_125M		GRF_FIELD_CONST(5, 4, 0)
-#define RK3368_GMAC_CLK_25M		GRF_FIELD_CONST(5, 4, 3)
-#define RK3368_GMAC_CLK_2_5M		GRF_FIELD_CONST(5, 4, 2)
+#define RK3368_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
 #define RK3368_GMAC_RMII_MODE		GRF_BIT(6)
 #define RK3368_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
 
@@ -731,9 +723,9 @@ static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
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
@@ -762,9 +754,7 @@ static const struct rk_gmac_ops rk3368_ops = {
 #define RK3399_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3399_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3399_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3399_GMAC_CLK_125M		GRF_FIELD_CONST(5, 4, 0)
-#define RK3399_GMAC_CLK_25M		GRF_FIELD_CONST(5, 4, 3)
-#define RK3399_GMAC_CLK_2_5M		GRF_FIELD_CONST(5, 4, 2)
+#define RK3399_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
 #define RK3399_GMAC_RMII_MODE		GRF_BIT(6)
 #define RK3399_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
 
@@ -796,9 +786,9 @@ static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
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
@@ -905,9 +895,7 @@ static const struct rk_gmac_ops rk3506_ops = {
 #define RK3528_GMAC1_CLK_RMII_DIV2	GRF_BIT(10)
 #define RK3528_GMAC1_CLK_RMII_DIV20	GRF_CLR_BIT(10)
 
-#define RK3528_GMAC1_CLK_RGMII_DIV1	GRF_FIELD_CONST(11, 10, 0)
-#define RK3528_GMAC1_CLK_RGMII_DIV5	GRF_FIELD_CONST(11, 10, 3)
-#define RK3528_GMAC1_CLK_RGMII_DIV50	GRF_FIELD_CONST(11, 10, 2)
+#define RK3528_GMAC1_CLK_RGMII(val)	GRF_FIELD_CONST(11, 10, val)
 
 #define RK3528_GMAC0_CLK_RMII_GATE	GRF_BIT(2)
 #define RK3528_GMAC0_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
@@ -945,9 +933,9 @@ static const struct rk_reg_speed_data rk3528_gmac0_reg_speed_data = {
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
@@ -1099,9 +1087,7 @@ static const struct rk_gmac_ops rk3568_ops = {
 #define RK3576_GMAC_CLK_RMII_DIV2		GRF_BIT(5)
 #define RK3576_GMAC_CLK_RMII_DIV20		GRF_CLR_BIT(5)
 
-#define RK3576_GMAC_CLK_RGMII_DIV1		GRF_FIELD_CONST(6, 5, 0)
-#define RK3576_GMAC_CLK_RGMII_DIV5		GRF_FIELD_CONST(6, 5, 3)
-#define RK3576_GMAC_CLK_RGMII_DIV50		GRF_FIELD_CONST(6, 5, 2)
+#define RK3576_GMAC_CLK_RGMII(val)		GRF_FIELD_CONST(6, 5, val)
 
 #define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
 #define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
@@ -1145,9 +1131,9 @@ static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
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
@@ -1223,12 +1209,8 @@ static const struct rk_gmac_ops rk3576_ops = {
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
@@ -1275,17 +1257,17 @@ static int rk3588_set_gmac_speed(struct rk_priv_data *bsp_priv,
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


