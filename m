Return-Path: <netdev+bounces-253442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K7cOT5Ud2mdeAEAu9opvQ
	(envelope-from <netdev+bounces-253442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:47:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3573B87CCB
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F5C302D087
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4A030F958;
	Mon, 26 Jan 2026 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bAnmRT/p"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799FD1DDA18
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427953; cv=none; b=b0Spsb6Lmyi+tYNkO0pwZO6tOj3jtzC+97HcdHRJL5KoDZENXVl6Cm6fuGyzw7dQN9XF2JzhOPUhLNS0hilHaNQAQtfOX5mLBgWbABFa5ra+dg0o8aAvqekUWIMsMj5WF37EPAq7dYOotkgsjQB8ZEhPTyOeBXwdUB8T7f4Ij60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427953; c=relaxed/simple;
	bh=EtVwG5me1zmouRIl4cRKHH538enYYXWVwqXQkrKCRjs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=PfyX4k55FNUQfUcO76okwrKcv2ElleZG3/AhFI7Z8pj9pqLuYEMjGEpdR5avmZSo0CSGW4uGU/QSOGRvqZQGA+smGfu5Z1D2LEUN4ijgkMX1Pa0DBHGt/NlkBbux+dhWppYSWFxndcrsfeQhN6RgBTuENoWXxaIGidpWhTun8sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bAnmRT/p; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jrvVZwtNMg6Z73jUZdb4aDJ6/1AUnZabnXeJiRAdzL0=; b=bAnmRT/pLUl6YjWnaqLl/s924+
	AiRjIwIFUOXow1TzUC7D/oxei+J8YD9+rd5LzIAkYUwse/XSWNhETyQyuCuqkBVHeulj7lF2SdDQ1
	TlGADGhjdvYfdoofGQlBmddyq4oQY/aJD219f/LD4NbfdtGL6vHRsLp1jKw3VZxexyQBastiLr7sz
	WqabHUlS4OtJck+9UWLh85hvMqVsvEr09y21xP/13O7QUGoKkzy0DbgLqz/sLh+pw/mYSJyvpUpDn
	QVnkHFwWGVhaTSasfADxcYELQWl6QexN7QcFA6/1/pT+UYuXO7Y7HxGAU+VxZ82xdg+9+IsB0Ge6F
	AtJDrLMA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57372 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vkL2K-000000004fY-0kKv;
	Mon, 26 Jan 2026 11:45:40 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vkL2I-00000005usu-42Hy;
	Mon, 26 Jan 2026 11:45:38 +0000
In-Reply-To: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
References: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 08/22] net: stmmac: rk: convert rk3588 to
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
Message-Id: <E1vkL2I-00000005usu-42Hy@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 26 Jan 2026 11:45:38 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253442-lists,netdev=lfdr.de,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 3573B87CCB
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
index 35836ffdfc1d..5bbdcc963430 100644
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
+	return regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);
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
@@ -1712,7 +1737,7 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 		val |= rk_encode_wm16(intf == PHY_INTF_SEL_RMII,
 				      bsp_priv->gmac_rmii_mode_mask);
 
-		ret = regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);
+		ret = rk_write_gmac_grf_reg(bsp_priv, val);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.47.3


