Return-Path: <netdev+bounces-263730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMCoCCEIqGnSnQAAu9opvQ
	(envelope-from <netdev+bounces-263730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:23:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 953B11FE463
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19E1B3023D8D
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CCD372674;
	Wed,  4 Mar 2026 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pvhRUhSC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB6434B194
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619774; cv=none; b=QnAURINlzdef5d2ypSjXG41+XmtKgF6Ki+4p69E2dVW2B+GbFgfSsNLR8e4Zy0ncyiGpSFU+ECMjT7F9oNT65pQT65I9wiQhIftdBF2wOKOa7nfbH5nG/W4/CFQyVqGHnFNfVHn1/cUpyJGESvJugNwR0cNlSlt6I16IGJFJXuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619774; c=relaxed/simple;
	bh=MpWRKi4UWumROdu2/Hsyub8lv780IiRl/dkIZNCnFKU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=LYQNSND8CoOEz6/ZXIsbQ3EWG+/9qIv3H1CC6hRPifMbWT0ZN8ZJ2dNS+9s98lhgsBw+wHcjYq8mzF84lNiw6yohIYJzZH/Q8Qr2KjuNFTaXAB2tnEH2bVcNU4o07/WwrwgXgsbxJhZmE6xTzx/c5tn1PaUh+jQm1+VAy7wP3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pvhRUhSC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=52X/BulkGNjlU03mY+rQgB6PxxV/PyTPUJEYegWdRoA=; b=pvhRUhSCwKSrU0FHSuokqIX3uG
	ZkPYB7XI7k1n+B8DKM2hah20K5GSGmCZ1q2kagLVVQitT8WHkUE+nzoaR+Np5z9ugFqAgE9FM8g3L
	Q9QuFKRnAFk+r2cYz9r9YiLSCjm9YlldKFeOxYdT2T7Sn8SGWN4uYICNsK+/0m0/TaQiuJ2Lx0sPe
	Lq9tscgSqhtUZXKt6Cf+LtjUU/553bZzsjDFZanAMoA4xdEbDmJJLyiUZXRk/Qc4YOnP3RHKNgO6z
	OEGlxa0kkHZrc2VP7UBlunfF8q3XFbxIwiAVJQqN8lK4GwGdde4YYcKYNhxcc6mdVd0I1ukb5mA7V
	kOWC0WRQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43038 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vxjNK-000000006LP-3kJM;
	Wed, 04 Mar 2026 10:22:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vxjNJ-0000000Br18-3sVv;
	Wed, 04 Mar 2026 10:22:41 +0000
In-Reply-To: <aagH023pvswd0tlT@shell.armlinux.org.uk>
References: <aagH023pvswd0tlT@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH net-next 3/8] net: stmmac: mdio: simplify MDC clock divisor
 lookup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vxjNJ-0000000Br18-3sVv@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 04 Mar 2026 10:22:41 +0000
X-Rspamd-Queue-Id: 953B11FE463
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
	TAGGED_FROM(0.00)[bounces-263730-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.262];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

As each lookup now iterates over each table in the same way, simplfy
the code to select the table, and then walk that table.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 27 +++++++------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 6292911fb54b..55dd3e07223d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -535,6 +535,7 @@ static const struct stmmac_clk_rate stmmac_xgmac_csr_to_mdc[] = {
  */
 static u32 stmmac_clk_csr_set(struct stmmac_priv *priv)
 {
+	const struct stmmac_clk_rate *rates;
 	unsigned long clk_rate;
 	u32 value = ~0;
 	int i;
@@ -548,26 +549,18 @@ static u32 stmmac_clk_csr_set(struct stmmac_priv *priv)
 	 * the frequency of clk_csr_i. So we do not change the default
 	 * divider.
 	 */
-	for (i = 0; stmmac_std_csr_to_mdc[i].rate; i++)
-		if (clk_rate > stmmac_std_csr_to_mdc[i].rate)
+	rates = stmmac_std_csr_to_mdc;
+	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I)
+		rates = stmmac_sun8i_csr_to_mdc;
+	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
+		rates = stmmac_xgmac_csr_to_mdc;
+
+	for (i = 0; rates[i].rate; i++)
+		if (clk_rate > rates[i].rate)
 			break;
-	if (stmmac_std_csr_to_mdc[i].cr != (u8)~0)
+	if (rates[i].cr != (u8)~0)
 		value = stmmac_std_csr_to_mdc[i].cr;
 
-	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I) {
-		for (i = 0; stmmac_sun8i_csr_to_mdc[i].rate; i++)
-			if (clk_rate > stmmac_sun8i_csr_to_mdc[i].rate)
-				break;
-		value = stmmac_sun8i_csr_to_mdc[i].cr;
-	}
-
-	if (priv->plat->core_type == DWMAC_CORE_XGMAC) {
-		for (i = 0; stmmac_xgmac_csr_to_mdc[i].rate; i++)
-			if (clk_rate > stmmac_xgmac_csr_to_mdc[i].rate)
-				break;
-		value = stmmac_xgmac_csr_to_mdc[i].cr;
-	}
-
 	return value;
 }
 
-- 
2.47.3


