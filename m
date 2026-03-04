Return-Path: <netdev+bounces-263729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBZ3J90IqGn2nQAAu9opvQ
	(envelope-from <netdev+bounces-263729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:26:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2B71FE509
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDED530E8C84
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3F83A2547;
	Wed,  4 Mar 2026 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OFEyZFO5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FCF3A1D10
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619769; cv=none; b=E448WjLj8FkSWmtQmr2QmiSa1SozSOztDIOdHFNPR20Nts3+9+tCIWbMtnInWOOMDp/PKWw6J9spywjn1HLsnvjagDM5ZY4IOGm/NKTUpO6RK3EFAFv/Oo+wSDBsDpFb0lLAgM/xCygx5WBODoDBU8cdkJIncQp5ZUsUZbk1GG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619769; c=relaxed/simple;
	bh=+pSLzm7YsrHaOBtZEmKqLdYcL2pnGiaXCoC2n124K10=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=NBY99oojtWxKQyzuI86zdq+Q835prQ9Xr9Z3FHsOOoWSfAZjr+5bM1u9b1D8Cpz3MDtnnTtzDoJpY4BHCG4VTq8cfEdobjlX4Xxcr1gks11Eg+H87J/VMblaMXuSghtRtIs8im3yDKVstmnZP/0juzGeM1/BMIOc+biTzGr3Is0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OFEyZFO5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bckk18FEL/WKB1zH3bibgFcRIdBT/iIOu/cwDyzcVjY=; b=OFEyZFO5HE41yX5nhXxqt2sCzA
	5aR1EEeoZwn5WRlZT/qBFP4gdnoz++XNscEEgCchKGJ8uvEqOpWygNiXZDfsDK55+EOJeLG+pcaSK
	cDC2wFhs7J0s7XAaf2ze6l9XNxqTPa5kIyiXbm1UylU+30MOxxMl6X2vrFhfimt0yKjtpXyfqwWpS
	WhJaoZ6KCuvRJ0TTWK/q42U5fG23O48qfotZRMSA3kqvwi4G8zlsrLBT0DQds/UCtI1RuLonpHbca
	J/9nJb3aj8Uq4hvtuWerqEXFoDAOAF7mPlUI1iJs/dRXDND4U2FGrf1bOxywRfdkETE2syViumrU+
	hnU2Q4tQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33524 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vxjNF-000000006L8-2sV0;
	Wed, 04 Mar 2026 10:22:37 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vxjNE-0000000Br0z-35Xu;
	Wed, 04 Mar 2026 10:22:36 +0000
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
Subject: [PATCH net-next 2/8] net: stmmac: mdio: use same test for MDC clock
 divisor lookups
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vxjNE-0000000Br0z-35Xu@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 04 Mar 2026 10:22:36 +0000
X-Rspamd-Queue-Id: DD2B71FE509
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
	TAGGED_FROM(0.00)[bounces-263729-lists,netdev=lfdr.de,kernel];
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
	NEURAL_SPAM(0.00)[0.171];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use the same frequency test for all clk_csr value lookups (clock
rate > table rate). This has the side effect that the standard rate
table results in the divider being used for the maximum frequency
for the divider rather than the next higher divider. This still
allows MDC to meet the IEE 802.3 specification, but at a rate closer
to 2.5MHz for these frequencies.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 27 +++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 42a48f655849..e4ce1167ebab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -257,6 +257,7 @@ struct stmmac_safety_stats {
 	(sizeof(struct stmmac_safety_stats) / sizeof(unsigned long))
 
 /* CSR Frequency Access Defines*/
+#define CSR_F_20M	20000000
 #define CSR_F_35M	35000000
 #define CSR_F_60M	60000000
 #define CSR_F_100M	100000000
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index c4123d2260bd..6292911fb54b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -484,15 +484,16 @@ struct stmmac_clk_rate {
  * clock frequencies.
  */
 static const struct stmmac_clk_rate stmmac_std_csr_to_mdc[] = {
-	{ CSR_F_35M, STMMAC_CSR_20_35M },
-	{ CSR_F_60M, STMMAC_CSR_35_60M },
-	{ CSR_F_100M, STMMAC_CSR_60_100M },
-	{ CSR_F_150M, STMMAC_CSR_100_150M },
-	{ CSR_F_250M, STMMAC_CSR_150_250M },
-	{ CSR_F_300M, STMMAC_CSR_250_300M },
-	{ CSR_F_500M, STMMAC_CSR_300_500M },
-	{ CSR_F_800M, STMMAC_CSR_500_800M },
-	{ },
+	{ CSR_F_800M, ~0 },
+	{ CSR_F_500M, STMMAC_CSR_500_800M },
+	{ CSR_F_300M, STMMAC_CSR_300_500M },
+	{ CSR_F_250M, STMMAC_CSR_250_300M },
+	{ CSR_F_150M, STMMAC_CSR_150_250M },
+	{ CSR_F_100M, STMMAC_CSR_100_150M },
+	{ CSR_F_60M,  STMMAC_CSR_60_100M },
+	{ CSR_F_35M,  STMMAC_CSR_35_60M },
+	{ CSR_F_20M,  STMMAC_CSR_20_35M },
+	{ 0, ~0 },
 };
 
 /* The sun8i clk_csr_i to GMII_Address CR field mapping uses rate as the
@@ -548,13 +549,12 @@ static u32 stmmac_clk_csr_set(struct stmmac_priv *priv)
 	 * divider.
 	 */
 	for (i = 0; stmmac_std_csr_to_mdc[i].rate; i++)
-		if (clk_rate < stmmac_std_csr_to_mdc[i].rate) {
-			value = stmmac_std_csr_to_mdc[i].cr;
+		if (clk_rate > stmmac_std_csr_to_mdc[i].rate)
 			break;
-		}
+	if (stmmac_std_csr_to_mdc[i].cr != (u8)~0)
+		value = stmmac_std_csr_to_mdc[i].cr;
 
 	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I) {
-		/* Note the different test - this is intentional. */
 		for (i = 0; stmmac_sun8i_csr_to_mdc[i].rate; i++)
 			if (clk_rate > stmmac_sun8i_csr_to_mdc[i].rate)
 				break;
@@ -562,7 +562,6 @@ static u32 stmmac_clk_csr_set(struct stmmac_priv *priv)
 	}
 
 	if (priv->plat->core_type == DWMAC_CORE_XGMAC) {
-		/* Note the different test - this is intentional. */
 		for (i = 0; stmmac_xgmac_csr_to_mdc[i].rate; i++)
 			if (clk_rate > stmmac_xgmac_csr_to_mdc[i].rate)
 				break;
-- 
2.47.3


