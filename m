Return-Path: <netdev+bounces-253436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGUhOdVTd2mdeAEAu9opvQ
	(envelope-from <netdev+bounces-253436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:45:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6222787C01
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A9CC301177F
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172430DD12;
	Mon, 26 Jan 2026 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jxNxykkH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA61E55C
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427917; cv=none; b=VJ67HZYnvLM+RRQpI1on5AQ4VtQpVM46G3iEzL7SHKt+uVJkHDmXKEr1Pp2BazFbTnTfT4lpBZiuHtgyqrvp33pt4YugZAbkhq51JHzJa8SAZriLKgbQ4dovasaXguob1qql4agRfNBXveLHLI6oXrc3alcWbgn1VH1rL6fjem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427917; c=relaxed/simple;
	bh=tLF2YefkRQZcCchZrJS9RavY5z9sRFqRWtbB2fKttgA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Apn0xi4uOe3XfDBO/N5nMzgwnb7RcbOQkwGSEcsa3WXuNI8kpTqxuEA16p+4Tvw1IHkDzPyqbr4/qAwnTE1gx+2fSBcWyONmjEZUzCGuP7g53Me5xc5HCI0MvezPGAUao1qXbHLS78PoyuofybIklkSMsrwXQ0LjCO6/kaAG5Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jxNxykkH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/SkAk/HQjq++pv0D7MjbKmK0nTCeSLlFCfgp7rotRsM=; b=jxNxykkHKh+ZuLzUirprKzT7Y7
	yk4srktjz9OPzXNViwubPhIcnEiijGjOK8Q9CHmELfr2UefQEVM9OfxAvirBktUTMWKNTHExK/GjH
	QBJ+N4IPOAfj/hBZK9NIHh2W6z7mpl8H0FLBXtMMbXR41Y1DvdNeG8fP0Alpa693hTkTqfw1II9Ez
	byg38GQ63a7AbHAN8Bdx+GUu+Cz+12NyuMM9TBuk+wm1Y9U8YbXs6Za+X8/jWzuB3LcqbD6zfHnsS
	uLw10kV/1v+Uof6WoKRDvXEDA+HX0OD8gIklyMMNXxjNjufdVP2c++K/vqpWTUel+gkyZCVlGKkjO
	JLN/yYiA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35456 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vkL1o-000000004dm-3WJo;
	Mon, 26 Jan 2026 11:45:08 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vkL1o-00000005usJ-08hy;
	Mon, 26 Jan 2026 11:45:08 +0000
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
Subject: [PATCH net-next v2 02/22] net: stmmac: rk: get rid of
 rk_phy_power_ctl()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vkL1o-00000005usJ-08hy@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 26 Jan 2026 11:45:08 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253436-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 6222787C01
X-Rspamd-Action: no action

It is not worth having a common rk_phy_power_ctl() when the only
difference is which regulator function is called. Also, passing
true/false is non-descriptive. Split this function, moving the code
appropriately into rk_phy_powerup() and rk_phy_powerdown().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 31 ++++++++++---------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index de420997e21f..0e66252eb5ae 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1498,23 +1498,26 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 	return 0;
 }
 
-static int rk_phy_power_ctl(struct rk_priv_data *bsp_priv, bool enable)
+static int rk_phy_powerup(struct rk_priv_data *bsp_priv)
 {
 	struct regulator *ldo = bsp_priv->regulator;
-	struct device *dev = bsp_priv->dev;
 	int ret;
 
-	if (enable) {
-		ret = regulator_enable(ldo);
-		if (ret)
-			dev_err(dev, "fail to enable phy-supply\n");
-	} else {
-		ret = regulator_disable(ldo);
-		if (ret)
-			dev_err(dev, "fail to disable phy-supply\n");
-	}
+	ret = regulator_enable(ldo);
+	if (ret)
+		dev_err(bsp_priv->dev, "fail to enable phy-supply\n");
 
-	return 0;
+	return ret;
+}
+
+static void rk_phy_powerdown(struct rk_priv_data *bsp_priv)
+{
+	struct regulator *ldo = bsp_priv->regulator;
+	int ret;
+
+	ret = regulator_disable(ldo);
+	if (ret)
+		dev_err(bsp_priv->dev, "fail to disable phy-supply\n");
 }
 
 static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
@@ -1692,7 +1695,7 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 		dev_err(dev, "NO interface defined!\n");
 	}
 
-	ret = rk_phy_power_ctl(bsp_priv, true);
+	ret = rk_phy_powerup(bsp_priv);
 	if (ret) {
 		gmac_clk_enable(bsp_priv, false);
 		return ret;
@@ -1713,7 +1716,7 @@ static void rk_gmac_powerdown(struct rk_priv_data *gmac)
 
 	pm_runtime_put_sync(gmac->dev);
 
-	rk_phy_power_ctl(gmac, false);
+	rk_phy_powerdown(gmac);
 	gmac_clk_enable(gmac, false);
 }
 
-- 
2.47.3


