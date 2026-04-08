Return-Path: <netdev+bounces-276405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKn4Nkoj1mklBQgAu9opvQ
	(envelope-from <netdev+bounces-276405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:43:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 949973BA0BA
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E960300ACAE
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3433B27EE;
	Wed,  8 Apr 2026 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pMmFVqfW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38223B27FF
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641408; cv=none; b=PIUPWFFCxP8+YHWtFZs6dlN25EBPbh8YtcSSYODshyTwW9Mz2Olj/VY/HXS6Ca9CWWDDcsTVDFCqWjBBSRZwWZuBzz8xwtfyOfD2kjCbieAzNd5Kg5+CwpPsi5X2b4gyMfO4vKBPdurDytUfOAxoPwq9nfmrJ6Jkn1Na+5zMxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641408; c=relaxed/simple;
	bh=42cTnhbRNXDI42kmq2UqvJhTgEsYYP6zV+heY4u/ph4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WwzSum77qaCZGDloSoFVyT+x+0BcgdxqVoPM/1zpVoOTs6BtuUtivDg5AR9mUJExLNARNKIEFSEhfFj7OdTLiaqutnzAWejsS8NEG8De+GFJbRyQ2NcXmhxQt7eu3zurlXutwV1aUv/dRSEiXWhy+WVHv74HBnsk3hs1rVtixmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pMmFVqfW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dtVN72wGnZ6TO0cAYb5J7S2eJNnpZu9n4ngwxR3LA7o=; b=pMmFVqfW9d0y0Vunkjgw90tppX
	e6SHEF9NLrmIAYbhuF6NYMuzwDOppOsK4e22goBrdIiKzvwduIXBRma6wH5ml1NdEv6wFPF46mgjY
	ZjleLyH++ly3sn9TqN8TkvoxEpyRVEG/JnAG40jPB6MfzSIA1BCj91LVWhBomWJMcd4iaFjqmE6cF
	6tn+0yEbovFt6d5tYDwYkcYq2HfcBD6VTd78TXwFg0EDFcrcCsX1oCgXHy24shjczrNA34YJABqLq
	bWPkQB0TU6h7mui5mHBwDdhMZcH/sVs+TMusmJGUn/E/oJ+/eW9OAIhWiXviE4E+XFLAb9rge0YTg
	vYTvPrrg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33734 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1wAPC7-00000000244-1u7L;
	Wed, 08 Apr 2026 10:27:31 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1wAPBw-0000000F7kf-0VA5;
	Wed, 08 Apr 2026 10:27:20 +0100
In-Reply-To: <adYfPBHsXxQUsMyr@shell.armlinux.org.uk>
References: <adYfPBHsXxQUsMyr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH RFC net-next 08/10] net: stmmac: simplify
 stmmac_get_ethtool_stats()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1wAPBw-0000000F7kf-0VA5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 08 Apr 2026 10:27:20 +0100
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276405-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.094];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 949973BA0BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As documented, stmmac_dma_diagnostic_fr() will return non-zero for
all non-DWMAC_CORE_MAC100 core types.

However, as DWMAC_CORE_MAC100 core types do not have DMA capabilities,
priv->dma_cap.rmon and priv->dma_cap.eee will be zero, and thus there
is no need to make this also conditional on the
stmmac_dma_diagnostic_fr() return value.

Remove this test and unindent the code, and remove unnecessary parens.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 60 +++++++++----------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 0caa5b992519..77cb67f4c63c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -519,9 +519,9 @@ static void stmmac_get_ethtool_stats(struct net_device *dev,
 	u32 rx_queues_count = priv->plat->rx_queues_to_use;
 	u32 tx_queues_count = priv->plat->tx_queues_to_use;
 	u64 napi_poll = 0, normal_irq_n = 0;
-	int i, j = 0, pos, ret;
 	unsigned long count;
 	unsigned int start;
+	int i, j = 0, pos;
 
 	if (priv->dma_cap.asp) {
 		for (i = 0; i < STMMAC_SAFETY_FEAT_SIZE; i++) {
@@ -531,42 +531,38 @@ static void stmmac_get_ethtool_stats(struct net_device *dev,
 		}
 	}
 
-	/* Update the DMA HW counters for dwmac10/100 (DWMAC_CORE_MAC100),
-	 * where this will return zero. Other core types will have a non-zero
-	 * return value.
-	 */
-	ret = stmmac_dma_diagnostic_fr(priv, &priv->xstats, priv->ioaddr);
-	if (ret) {
-		/* If supported, for new GMAC chips expose the MMC counters */
-		if (priv->dma_cap.rmon) {
-			stmmac_mmc_read(priv, priv->mmcaddr, &priv->mmc);
+	/* Update the DMA HW counters for dwmac10/100 (DWMAC_CORE_MAC100). */
+	stmmac_dma_diagnostic_fr(priv, &priv->xstats, priv->ioaddr);
 
-			for (i = 0; i < STMMAC_MMC_STATS_LEN; i++) {
-				char *p;
-				p = (char *)priv + stmmac_mmc[i].stat_offset;
+	/* If supported, for new GMAC chips expose the MMC counters */
+	if (priv->dma_cap.rmon) {
+		stmmac_mmc_read(priv, priv->mmcaddr, &priv->mmc);
 
-				data[j++] = (stmmac_mmc[i].sizeof_stat ==
-					     sizeof(u64)) ? (*(u64 *)p) :
-					     (*(u32 *)p);
-			}
-		}
-		if (priv->dma_cap.eee) {
-			int val = phylink_get_eee_err(priv->phylink);
-			if (val)
-				priv->xstats.phy_eee_wakeup_error_n = val;
+		for (i = 0; i < STMMAC_MMC_STATS_LEN; i++) {
+			char *p = (char *)priv + stmmac_mmc[i].stat_offset;
+
+			data[j++] = stmmac_mmc[i].sizeof_stat == sizeof(u64) ?
+				    *(u64 *)p : *(u32 *)p;
 		}
+	}
 
-		/* Only dwmac1000 and dwmac4 implements the MAC .debug() method.
-		 * As there are different version spaces depending on core_type,
-		 * make this conditional on the appropriate core type.
-		 */
-		if ((priv->plat->core_type == DWMAC_CORE_GMAC ||
-		     priv->plat->core_type == DWMAC_CORE_GMAC4) &&
-		    priv->snpsver >= DWMAC_CORE_3_50)
-			stmmac_mac_debug(priv, priv->ioaddr,
-					(void *)&priv->xstats,
-					rx_queues_count, tx_queues_count);
+	if (priv->dma_cap.eee) {
+		int val = phylink_get_eee_err(priv->phylink);
+		if (val)
+			priv->xstats.phy_eee_wakeup_error_n = val;
 	}
+
+	/* Only dwmac1000 and dwmac4 implements the MAC .debug() method.
+	 * As there are different version spaces depending on core_type,
+	 * make this conditional on the appropriate core type.
+	 */
+	if ((priv->plat->core_type == DWMAC_CORE_GMAC ||
+	     priv->plat->core_type == DWMAC_CORE_GMAC4) &&
+	    priv->snpsver >= DWMAC_CORE_3_50)
+		stmmac_mac_debug(priv, priv->ioaddr,
+				(void *)&priv->xstats,
+				rx_queues_count, tx_queues_count);
+
 	for (i = 0; i < STMMAC_STATS_LEN; i++) {
 		char *p = (char *)priv + stmmac_gstrings_stats[i].stat_offset;
 		data[j++] = (stmmac_gstrings_stats[i].sizeof_stat ==
-- 
2.47.3


