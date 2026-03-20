Return-Path: <netdev+bounces-269979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBrsCJF9vWmt9wIAu9opvQ
	(envelope-from <netdev+bounces-269979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:02:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 953902DE2D3
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC88D304FF53
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164193C3BEC;
	Fri, 20 Mar 2026 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RokbSFW1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1993D413C
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025257; cv=none; b=MetJqHOfQq+2+l8y6SgErYRoq8avaaIwYeqQ2pv2675l0/ExRjgrWF2DAe5d7GrLUE89cLzTwYGDNTxbbcfbGbHdQpoT54s4WBR7wlojw02Co+K0kNNyymhQvVgDH1ye2H8MWjHZOt4YyqF6xTMDHnkpTmdl/Tj5Bck3RZBle5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025257; c=relaxed/simple;
	bh=PnW4jYVtvJFw0YCCeBsRsrjIrdcrLT+NkwzC2REjMjw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bLql/7fwerYyGkKwds6AOb3XOpyn4hL20m+6RtzBgWsFT1H7/RAEOXXNNay1k5hIfsmttokD9d68VB3kTKp4CSga3gnZDIxm0ch7l+lcDEFQy2EYpMLF72Ca/F+mURA+NCx5jW8xOEQ0s+RlTuLtdvH0g9JIGVteapGK+LvV75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RokbSFW1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eZ2KERFjyyQf8dxQP/UdKYTPcwvV1gn7poLNdNWhNwc=; b=RokbSFW1YJaX5DndiPpnSPZipq
	nvI5JqJpgi4FGAoenz7kBeFm5T8xsfWEvrKGq2BQ5vRSa7zqyut9pEqx5fF6h4VfjvfgUTb0aIcO8
	AwPi+xPfVhV19p9rsf9eZAHiOR0xTl5K4YesEAHm8dVd1EYblLAqvPqbomVuI5vtSWipJzjhDEp0R
	ccZqXDTrG0AlehxC/dxivmMJO48y1pHwarH0iNajxZGl0KKecUFOoedjmt5yjrTi4029LeXREtiH+
	c9ueZOdtsKIRvQFdw0DlJO96d/gpEhjvutmJeNLAwJySINj0WlHBjLMVNRhr3fjUzwu8NZIhjM72S
	t3xiNjmg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34054 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w3d0S-000000006M2-27Lp;
	Fri, 20 Mar 2026 16:47:28 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w3d0R-0000000DfM1-1itN;
	Fri, 20 Mar 2026 16:47:27 +0000
In-Reply-To: <ab15_JvLGFtUH_3x@shell.armlinux.org.uk>
References: <ab15_JvLGFtUH_3x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 4/6] net: stmmac: move stmmac_xmit() initial variable
 init
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w3d0R-0000000DfM1-1itN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 20 Mar 2026 16:47:27 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269979-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.414];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 953902DE2D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move tx_q, first_tx and txq_stats just before their first use.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d5e28ecf9fb4..95da2940cc3d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4692,10 +4692,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	dma_addr_t dma_addr;
 	u32 sdu_len;
 
-	tx_q = &priv->dma_conf.tx_queue[queue];
-	txq_stats = &priv->xstats.txq_stats[queue];
-	first_tx = tx_q->cur_tx;
-
 	if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
 		stmmac_stop_sw_lpi(priv);
 
@@ -4732,6 +4728,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_BUSY;
 	}
 
+	tx_q = &priv->dma_conf.tx_queue[queue];
+	first_tx = tx_q->cur_tx;
+
 	/* Check if VLAN can be inserted by HW */
 	has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
 
@@ -4889,6 +4888,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
 	}
 
+	txq_stats = &priv->xstats.txq_stats[queue];
 	u64_stats_update_begin(&txq_stats->q_syncp);
 	u64_stats_add(&txq_stats->q.tx_bytes, skb->len);
 	if (set_ic)
-- 
2.47.3


