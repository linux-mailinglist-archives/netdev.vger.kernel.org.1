Return-Path: <netdev+bounces-264283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE/yADtfqWlc6QAAu9opvQ
	(envelope-from <netdev+bounces-264283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:47:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 537BC20FEF4
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 836ED30B39DB
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9A0377563;
	Thu,  5 Mar 2026 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mzd9Vi17"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F423A26D4E5
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707369; cv=none; b=jhyA3Gh0Yy0OrGlYG4emv7CxtrDMpgh4Z2tB1o78iDTCvzLWgEcDFGP4kW4f9CtadCeMcPbKdLPTJfgaXjgwopzWtQYuZT8WvupGKfMTmPBGhlRPFajWggNlslNqV/P2fR7xSoVDeX5XRX5Eo7vlzt8+UCjN1DQHO3YgKFGPJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707369; c=relaxed/simple;
	bh=544HoulnilcgBI/L9M/V+w+YeboEbjwqqmAgZO/OefE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ECsZgsfBxIo9XpQR4Fr7IiquBOP6WReMDMfIDQMjSumO/5Q/UYZBECeFm7xJ+xkT1OUZgJc4aGQqN75D7YzEBTtzH0TfapiOyvRSbRo8GCpU/VYIkx39hR0lYa6InwyHvuEqE7QNfmg5a085aDzHnQnaVIyQSTJ5V2GOxfZ0L0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mzd9Vi17; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ogTF0nwdsw9SfsXkkXPmG+1dcoUkKCrfCK9EtBt6iXY=; b=mzd9Vi17Y8fsq1lbF7B6trNGzX
	XciP0EMRAq+KpqWqEoCSGQ2Efb0n7upecnA6cu5jov3LMwAlOg7JEnqBADsb9eVXVBHxDcdg11t6A
	PDZ4aCfxNVsoVXEsiucJ8biSaKIWh3sI2EineFZopP5PTr6Q858Z20o1rANsAK8nShLGKo550I8dQ
	EzHooF4548FFvurv6hc2Rn5VZAj6khnDCe1OLf4NNFf+fYMceVwjxac0tXQW+fgQZ60UquqOmNalG
	be6aQojUFJ+M+fMAHFd3qj3eEWbv6tqCkR0E0xmDRmMbUcdm4EXtDxNLUwpR42Ov5cSI1wY6OwJWd
	GxoAg6Yg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46580 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vy6AA-000000007nC-10GC;
	Thu, 05 Mar 2026 10:42:38 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vy6A9-0000000Btwp-0lxY;
	Thu, 05 Mar 2026 10:42:37 +0000
In-Reply-To: <aald--qJquWGIvmO@shell.armlinux.org.uk>
References: <aald--qJquWGIvmO@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 3/8] net: stmmac: mdio: simplify MDC clock divisor
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
Message-Id: <E1vy6A9-0000000Btwp-0lxY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 05 Mar 2026 10:42:37 +0000
X-Rspamd-Queue-Id: 537BC20FEF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264283-lists,netdev=lfdr.de,kernel];
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
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.249];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email]
X-Rspamd-Action: no action

As each lookup now iterates over each table in the same way, simplfy
the code to select the table, and then walk that table.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 29 +++++++------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 6292911fb54b..c9f0b8b601d2 100644
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
@@ -548,25 +549,17 @@ static u32 stmmac_clk_csr_set(struct stmmac_priv *priv)
 	 * the frequency of clk_csr_i. So we do not change the default
 	 * divider.
 	 */
-	for (i = 0; stmmac_std_csr_to_mdc[i].rate; i++)
-		if (clk_rate > stmmac_std_csr_to_mdc[i].rate)
-			break;
-	if (stmmac_std_csr_to_mdc[i].cr != (u8)~0)
-		value = stmmac_std_csr_to_mdc[i].cr;
-
-	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I) {
-		for (i = 0; stmmac_sun8i_csr_to_mdc[i].rate; i++)
-			if (clk_rate > stmmac_sun8i_csr_to_mdc[i].rate)
-				break;
-		value = stmmac_sun8i_csr_to_mdc[i].cr;
-	}
+	rates = stmmac_std_csr_to_mdc;
+	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I)
+		rates = stmmac_sun8i_csr_to_mdc;
+	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
+		rates = stmmac_xgmac_csr_to_mdc;
 
-	if (priv->plat->core_type == DWMAC_CORE_XGMAC) {
-		for (i = 0; stmmac_xgmac_csr_to_mdc[i].rate; i++)
-			if (clk_rate > stmmac_xgmac_csr_to_mdc[i].rate)
-				break;
-		value = stmmac_xgmac_csr_to_mdc[i].cr;
-	}
+	for (i = 0; rates[i].rate; i++)
+		if (clk_rate > rates[i].rate)
+			break;
+	if (rates[i].cr != (u8)~0)
+		value = rates[i].cr;
 
 	return value;
 }
-- 
2.47.3


