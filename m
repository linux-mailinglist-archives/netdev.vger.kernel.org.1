Return-Path: <netdev+bounces-252791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNdmE9JUc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:00:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C2D74AE1
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3687300A746
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046FE231829;
	Fri, 23 Jan 2026 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="b1J7LgmS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6D1DF261
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166030; cv=none; b=IlEPDpmul6nrlCoEBfPBzpBl2Yy3DxSjUjNtCqqfl7aTxzDDASSJpUuuJeR+ZSQaQnFnmdniD6HGuV4Ubq9v3BncumIUxpgC4HGsbPAcS0wQY93rjjLlLXkep4Xen5kF9PEWSKASqjJQhYHmX76rxK/nm4tJZlPvAZCKWgHalvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166030; c=relaxed/simple;
	bh=XT2ehDiBGo/GgY3Dt9xrRrzqgqeVCDkCPoPe5ibpB7g=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=UFz2UrKZ6STU66fgD3Dfiv3pHUUi0xLVWDvEUFGqg0umWKx2Jy16eOIQRmgswe3z3GiAC+LGAJvSZPEEdtGZ0dzpWHeZiH7p4ZGeaN9QPrjxihYRbkQvjNOHeJrMUWdnifGxH0oiE0Vpe/WFn++YzoC7mijOF8NVv4/zElUXtds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=b1J7LgmS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q75ZGBuJxVx+TLZl2i9flltdJqFjAWm+npZcCaXfPOg=; b=b1J7LgmSGp+2uGSN2eCmmEmUMX
	8x8ysbRZn22ud8LDCny4HE62FsPDkfvVCjGdhh/n/xrR00YdKjaPE0azkgOM81gca7d0ks/lx9IoU
	OMKJQRlUkKn20Ufsv7UT006yv/oop/jnsBxKOXDWMgg/MWhj9tJiu03HRZIkqEHZKPrWvuHGEYfoE
	EkfPQAg3pIbvr1k8gk2c1uTDxNi/asMZz1I4/lDIg59Y4l0N3FGjudY2zaPJ1pOj0dLet1t8Em6zy
	CqrpWTK09HAIeAS2zUhXZNoz4d1ihkPX2JRnueWlmj0GXM34PIzo05CS9ZjUr/ZAXH8KxFFpKhsBR
	3CxjwaVQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56118 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vjEtr-000000001mS-2Cuf;
	Fri, 23 Jan 2026 11:00:23 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vjEtq-00000005gfe-3ILz;
	Fri, 23 Jan 2026 11:00:22 +0000
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
Subject: [PATCH net-next 01/21] net: stmmac: rk: avoid phy_power_on()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vjEtq-00000005gfe-3ILz@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jan 2026 11:00:22 +0000
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
	TAGGED_FROM(0.00)[bounces-252791-lists,netdev=lfdr.de,kernel];
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
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3C2D74AE1
X-Rspamd-Action: no action

In https://lore.kernel.org/netdev/aDne1Ybuvbk0AwG0@shell.armlinux.org.uk/
I requested that a follow-up patch to change the name of dwmac-rk's
phy_power_on() function, which clashes with the drivers/phy function
of the same name. This can cause confusion when grepping for this
function name, or when reviewing code. Thankfully, stmmac doesn't make
use of drivers/phy which saves this from compile errors.

However, as is the usual case when a request is made as part of a
review, if the review leads to successful application of the patch the
author doesn't bother following up with any such requests, and so the
problem falls back onto the reviewer to address... so here is the
solution.

Rename dwmac-rk's function to rk_phy_power_ctl(), as the function both
powers up and down.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 0a95f54e725e..de420997e21f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1498,7 +1498,7 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 	return 0;
 }
 
-static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
+static int rk_phy_power_ctl(struct rk_priv_data *bsp_priv, bool enable)
 {
 	struct regulator *ldo = bsp_priv->regulator;
 	struct device *dev = bsp_priv->dev;
@@ -1692,7 +1692,7 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 		dev_err(dev, "NO interface defined!\n");
 	}
 
-	ret = phy_power_on(bsp_priv, true);
+	ret = rk_phy_power_ctl(bsp_priv, true);
 	if (ret) {
 		gmac_clk_enable(bsp_priv, false);
 		return ret;
@@ -1713,7 +1713,7 @@ static void rk_gmac_powerdown(struct rk_priv_data *gmac)
 
 	pm_runtime_put_sync(gmac->dev);
 
-	phy_power_on(gmac, false);
+	rk_phy_power_ctl(gmac, false);
 	gmac_clk_enable(gmac, false);
 }
 
-- 
2.47.3


