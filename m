Return-Path: <netdev+bounces-255105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK1eFAaQfGkQNwIAu9opvQ
	(envelope-from <netdev+bounces-255105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:03:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EE0B9B90
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14EAA300F9F1
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C64736AB70;
	Fri, 30 Jan 2026 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="U3BdgZ90"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B7828C2BF
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770856; cv=none; b=eFJTtm39AOIp1tYZGWeL+JehLWn+u4la57s29/DST6TgNHJ8r8fC4NyTtmJvzZuz6SfnBCcpkJ04zl8wigGFR1zlW3t2mhCP8u4OIxBaOnUsFugdhN5d2VMKxZh1Z8jnFNDw7pMH8UgbLw9oE4pgg6h2OlhDfpFHE0kt7NHIVyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770856; c=relaxed/simple;
	bh=j2zGX0KMwK6MAQbfU0jaonYcvSxm/CILzcFlNFWUIvY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=StqdXTxFVIpAUx9dTMIwVSD7o44j0n+kj9I2x+8p3vjhon/Q7KPQ3qubuq5udBX1cZ/OQxnFhgC5ipi3vjxsanDmTlE3GMuplroMSz05TiifseWNhmUBBivbYHmmfe6/1qwRCErfMajBFtnA9JL5vP/at6gbh+ixeQtZ5tfuRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=U3BdgZ90; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fpgYTwozvuEEX+PMurGR6OKATG57EMs24aW533ldqAc=; b=U3BdgZ90xDWfkPi36ujZqrs9OQ
	8hJZ1nrDud+Fn7/PKB7SJKS1TCDf23R+XquX/wDlbOOLcYHc/Y2Rlu/SaeBk8Dgu+Oo/FtcUd9tDQ
	xy2bsf8mEM7YYEHDgaonrP716LY6GDShZK0CVZtKQMUx2iB+HjxBjQ4KtlLT9mPqmw4mNjroh17uZ
	g3svd6Y5HMEnvg/pYGCbMiQBkeNPhpXN/Zv10Gw9dyX05T0sCs41+pqFyEdJjSXVCt6YtXFJhCtnG
	pyfbo0UFH+n2OQz3swBLSGMqmvknAvl6hnEF1MiGqHtclptgJsodDO9+oIVB0fQ8TKDvmStLqEQrY
	+Qjs+47w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50654 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vlmEu-000000000y5-23y6;
	Fri, 30 Jan 2026 11:00:36 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vlmEs-00000006zoC-2MX8;
	Fri, 30 Jan 2026 11:00:34 +0000
In-Reply-To: <aXyPK9rlMt8h_fze@shell.armlinux.org.uk>
References: <aXyPK9rlMt8h_fze@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 05/10] net: stmmac: rk: remove rk3528 RMII clock
 initialisation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vlmEs-00000006zoC-2MX8@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 30 Jan 2026 11:00:34 +0000
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
	TAGGED_FROM(0.00)[bounces-255105-lists,netdev=lfdr.de,kernel];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: B9EE0B9B90
X-Rspamd-Action: no action

There is no need to pre-initialise the rk3528 RMII clock when
selecting RMII mode on gmac0.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 5bb805330cbc..2e2b76d588e6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1003,8 +1003,7 @@ static void rk3528_set_to_rmii(struct rk_priv_data *bsp_priv)
 			     RK3528_GMAC1_PHY_INTF_SEL_RMII);
 	else
 		regmap_write(bsp_priv->grf, RK3528_VO_GRF_GMAC_CON,
-			     RK3528_GMAC0_PHY_INTF_SEL_RMII |
-			     RK3528_GMAC0_CLK_RMII_DIV2);
+			     RK3528_GMAC0_PHY_INTF_SEL_RMII);
 }
 
 static const struct rk_reg_speed_data rk3528_gmac0_reg_speed_data = {
-- 
2.47.3


