Return-Path: <netdev+bounces-255812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIB2EnB4gGne8gIAu9opvQ
	(envelope-from <netdev+bounces-255812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:12:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E0CCAA1A
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22F81305BBFF
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9554035770C;
	Mon,  2 Feb 2026 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0gHxQ/qU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E69126BF1
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026655; cv=none; b=OR/R6i1m2cpQNl8T83rtSxjV01fyP+2A89znBXE/prRTDAG9QUiNUYCky7MMZ8yUFIQHMIeEUzUOoSpUkLp0QpiuvJ7xk231YWLW4okz3woTzkJkqh/LbrDoTF7OQb0KHTBckvs5QtibH0d+Na9A80g+5ywjIpvDkr4ID4wLlZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026655; c=relaxed/simple;
	bh=LQ428hAkVDHqTErlA6L31Xj+FPcbXall6ynu1p2Ch/U=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=O94/+qhtW7hNMzNIvyuSisSMn0gsLUgNbGIUAqVYEY6+a4Z48wflT7D63oTKBDlXX6cl86+KOcM0Gn2vYCNRAmB9EXPJzv8X1PupcCLozzj9njvJ0PloAFs0JAox4qGP6rnIPtp1NHE1DXf/IoSip7w4efjNUzBZv7QuXbyTl6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0gHxQ/qU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DA2zo4VkPp9Hb1N6kn5rmQ0FsEMtqPCJrHCq7qQkDTU=; b=0gHxQ/qUiJ9GO8sz/mK3tcq502
	CBhAFH58zslUSKCg8GC6hCZ0VBS2/VOYFNOiN25CLDEymyIaS6VVHgivzmLHyLgWE/AD1xnVnNZN/
	h8CHvwU0Wev+xxqxPnwvN4Q5xNDt6qDqw00Vo9BGAMAcSWT85voOgliW/PK6sJIel8ajpQzh0qZoy
	Uu9WnVwP5IJD9YT45mSd9f/fM5HYxqoMcvr62b+JKXczonORSoSJiW2nLmZ6XayRyrxGzhuzVQeH4
	+xmVBkgZMoaBNYEfX8rQNfujN6b4xFK92POtBnCzXnfT/YX2EO4punQESxfV2HGYdvH9pyLg0u4SO
	eqqXl2tw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51302 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vmqmn-000000003mQ-2KAg;
	Mon, 02 Feb 2026 10:04:01 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vmqmm-00000007VCP-2XZc;
	Mon, 02 Feb 2026 10:04:00 +0000
In-Reply-To: <aYB2cKRu3DQh6yXK@shell.armlinux.org.uk>
References: <aYB2cKRu3DQh6yXK@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 02/10] net: stmmac: rk: convert rk3588 to
 mask-based interface mode config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vmqmm-00000007VCP-2XZc@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 02 Feb 2026 10:04:00 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255812-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: A9E0CCAA1A
X-Rspamd-Action: no action

rk3588 has a quirk compared to the other Rockchip implementations in
that the interface mode configuration register is in the php_grf
regmap rather than the grf regmap. Add a flag to indicate this, and
a separate function to write to the appropriate regmap. This allows
rk3588 to be converted.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 45 ++++++++++++++-----
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 60c13dfc0726..96a1d6b60a35 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -50,6 +50,7 @@ struct rk_gmac_ops {
 	u16 gmac_phy_intf_sel_mask;
 	u16 gmac_rmii_mode_mask;
 
+	bool gmac_grf_reg_in_php;
 	bool php_grf_required;
 	bool regs_valid;
 	u32 regs[];
@@ -126,6 +127,18 @@ static u32 rk_encode_wm16(u16 val, u16 mask)
 	return reg_val;
 }
 
+static int rk_write_gmac_grf_reg(struct rk_priv_data *bsp_priv, u32 val)
+{
+	struct regmap *regmap;
+
+	if (bsp_priv->ops->gmac_grf_reg_in_php)
+		regmap = bsp_priv->php_grf;
+	else
+		regmap = bsp_priv->grf;
+
+	return regmap_write(regmap, bsp_priv->gmac_grf_reg, val);
+}
+
 static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 			    const struct rk_reg_speed_data *rsd,
 			    unsigned int reg, phy_interface_t interface,
@@ -1225,9 +1238,6 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GRF_GMAC_CON0			0X0008
 #define RK3588_GRF_CLK_CON1			0X0070
 
-#define RK3588_GMAC_PHY_INTF_SEL(id, val)	\
-	(GRF_FIELD(5, 3, val) << ((id) * 6))
-
 #define RK3588_GMAC_CLK_RMII_MODE(id)		GRF_BIT(5 * (id))
 #define RK3588_GMAC_CLK_RGMII_MODE(id)		GRF_CLR_BIT(5 * (id))
 
@@ -1243,6 +1253,22 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GMAC_CLK_RMII_GATE(id)		GRF_BIT(5 * (id) + 1)
 #define RK3588_GMAC_CLK_RMII_NOGATE(id)		GRF_CLR_BIT(5 * (id) + 1)
 
+static int rk3588_init(struct rk_priv_data *bsp_priv)
+{
+	switch (bsp_priv->id) {
+	case 0:
+		bsp_priv->gmac_phy_intf_sel_mask = GENMASK_U16(5, 3);
+		return 0;
+
+	case 1:
+		bsp_priv->gmac_phy_intf_sel_mask = GENMASK_U16(11, 9);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
@@ -1251,9 +1277,6 @@ static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 	offset_con = bsp_priv->id == 1 ? RK3588_GRF_GMAC_CON9 :
 					 RK3588_GRF_GMAC_CON8;
 
-	regmap_write(bsp_priv->php_grf, RK3588_GRF_GMAC_CON0,
-		     RK3588_GMAC_PHY_INTF_SEL(id, PHY_INTF_SEL_RGMII));
-
 	regmap_write(bsp_priv->php_grf, RK3588_GRF_CLK_CON1,
 		     RK3588_GMAC_CLK_RGMII_MODE(id));
 
@@ -1268,9 +1291,6 @@ static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	regmap_write(bsp_priv->php_grf, RK3588_GRF_GMAC_CON0,
-		     RK3588_GMAC_PHY_INTF_SEL(bsp_priv->id, PHY_INTF_SEL_RMII));
-
 	regmap_write(bsp_priv->php_grf, RK3588_GRF_CLK_CON1,
 		     RK3588_GMAC_CLK_RMII_MODE(bsp_priv->id));
 }
@@ -1323,10 +1343,15 @@ static void rk3588_set_clock_selection(struct rk_priv_data *bsp_priv, bool input
 }
 
 static const struct rk_gmac_ops rk3588_ops = {
+	.init = rk3588_init,
 	.set_to_rgmii = rk3588_set_to_rgmii,
 	.set_to_rmii = rk3588_set_to_rmii,
 	.set_speed = rk3588_set_gmac_speed,
 	.set_clock_selection = rk3588_set_clock_selection,
+
+	.gmac_grf_reg_in_php = true,
+	.gmac_grf_reg = RK3588_GRF_GMAC_CON0,
+
 	.php_grf_required = true,
 	.regs_valid = true,
 	.regs = {
@@ -1713,7 +1738,7 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 		val |= rk_encode_wm16(intf == PHY_INTF_SEL_RMII,
 				      bsp_priv->gmac_rmii_mode_mask);
 
-		ret = regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);
+		ret = rk_write_gmac_grf_reg(bsp_priv, val);
 		if (ret < 0) {
 			gmac_clk_enable(bsp_priv, false);
 			return ret;
-- 
2.47.3


