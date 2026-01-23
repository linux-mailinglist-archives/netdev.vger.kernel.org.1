Return-Path: <netdev+bounces-252805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF5eC25Vc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:03:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F31974BFC
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F7E53008D1A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9923033C8;
	Fri, 23 Jan 2026 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wkf36Y/W"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46510258CD7
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166122; cv=none; b=T9cAWfGw6EgZXKSr/mAbYdoYOxoRp1IjOxbT0RLs4JodzPMib8jRAceFsk/EDFaXcabnoa15t5x0eYg49/BoVhhcLVrvx0C74RNoDGy4kJZ6mjsrU0msWwg0eltChVSPz0SuBJh6epxq/8dE8Uun7MDQMf7H+9BjjWPvKXveYyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166122; c=relaxed/simple;
	bh=jEi9fwXz0usz6V9k3gDUvOIZC1CPvofouHCNgbUNE90=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Shp22J5nWyrDV/0xqsXPhcGtRlG2yZgQ+qNuIoyF7DS4E3uPnpiOlAzmD5hJ94OWbWE1OaGPS33ifXh6zBNYpwb9Fe4eUr9sgoBKlcR8c0EK6BjXlKD+V5KCm9uwHkGfGyQuIVib8BB966bESXftjfOYMib9kMY7nXIN8D87SbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wkf36Y/W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=siUz6Rf39Wszy8PXQnr6b5myc2YgOaPjeYFvBM/YHms=; b=wkf36Y/We+O9BoSAbwiShH/wpx
	UgcPb/+75jDKT2hRYQUBi2ORSc+o9URPsQSvqccKSyHisF3n0kGvqN/OsGgNyxcoel8nz1xbIuTz5
	iCxhWoLLyiS3aAxBHtkbp07nO24xT9SR8tU4M9elXAQEoMiI9jnGUK9nczycusnMU/v8N86vJLRZ3
	Kd4K7wAeCNOc/AxQnfDS48FnL8JWeM/Y+Me4lStQyrT2Iyg9TuDtziQHmVYchuFCmswhL5YOoKW/X
	3uHYJ5BhH/FkrXguhlCXgDzeITkPgErcD5GOt848drkCqUxBLI4F8NpuE9YYSaGv3suBGbnPveZRU
	mY0MunsA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48478 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vjEv4-000000001qV-0w8r;
	Fri, 23 Jan 2026 11:01:38 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vjEv0-00000005gh1-1dTz;
	Fri, 23 Jan 2026 11:01:34 +0000
In-Reply-To: <aXNUlVZilT-CTgph@shell.armlinux.org.uk>
References: <aXNUlVZilT-CTgph@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 15/21] net: stmmac: rk: convert px30
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vjEv0-00000005gh1-1dTz@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jan 2026 11:01:34 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252805-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F31974BFC
X-Rspamd-Action: no action

Use rk_set_clk_mac_speed() rather than px30 specific function for
configuring RMII clock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 38 ++-----------------
 1 file changed, 4 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 812e6729a703..802052beb668 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -251,49 +251,19 @@ static void rk_gmac_integrated_fephy_powerdown(struct rk_priv_data *priv,
 
 #define PX30_GRF_GMAC_CON1		0x0904
 
-/* PX30_GRF_GMAC_CON1 */
-#define PX30_GMAC_SPEED_10M		GRF_CLR_BIT(2)
-#define PX30_GMAC_SPEED_100M		GRF_BIT(2)
-
 static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static int px30_set_speed(struct rk_priv_data *bsp_priv,
-			  phy_interface_t interface, int speed)
-{
-	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
-	struct device *dev = bsp_priv->dev;
-	unsigned int con1;
-	long rate;
-
-	if (!clk_mac_speed) {
-		dev_err(dev, "%s: Missing clk_mac_speed clock\n", __func__);
-		return -EINVAL;
-	}
-
-	if (speed == 10) {
-		con1 = PX30_GMAC_SPEED_10M;
-		rate = 2500000;
-	} else if (speed == 100) {
-		con1 = PX30_GMAC_SPEED_100M;
-		rate = 25000000;
-	} else {
-		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
-		return -EINVAL;
-	}
-
-	regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1, con1);
-
-	return clk_set_rate(clk_mac_speed, rate);
-}
-
 static const struct rk_gmac_ops px30_ops = {
 	.set_to_rmii = px30_set_to_rmii,
-	.set_speed = px30_set_speed,
+	.set_speed = rk_set_clk_mac_speed,
 
 	.gmac_grf_reg = PX30_GRF_GMAC_CON1,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
+
+	.clock_grf_reg = PX30_GRF_GMAC_CON1,
+	.clock.mac_speed_mask = BIT_U16(2),
 };
 
 #define RK3128_GRF_MAC_CON0	0x0168
-- 
2.47.3


