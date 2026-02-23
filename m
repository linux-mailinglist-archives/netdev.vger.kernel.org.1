Return-Path: <netdev+bounces-260010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGQSA1M9nGklCAQAu9opvQ
	(envelope-from <netdev+bounces-260010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:43:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61665175A2B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6788030607AF
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD5E3644BA;
	Mon, 23 Feb 2026 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SH+SziQr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5D3644AF
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846922; cv=none; b=L1YQBcBZS6l6p4gJqezPVu2JS7CxOi8IfXXtHX5NY6OZ/LePQW/3asqadKJf9Wmat6EvJaR6lQBx0eqcggziFC5HDvp224SfZXped8SVCG7clb1ndqBkAoTyQkvtD7Mj6+WLh5ffv7CFsiOmPwIS4ps3I+B5saAVlumzLvM8ySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846922; c=relaxed/simple;
	bh=AHCsNEhqveb2kuYOOzSvCuKTTIt3uG4Llr3NsGpLIyI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=uQcQqCJrX4DoHGqlY3ZV8CUb1V0dAxR3eGPr7GFPQ5gN6hGxUzi3D/IaAUzhjtFSx6JhW9J85paRSZY0ap6kkQM0aNngRpaCWHYhJA6Vu/thuea/fslHTB0rKr8LfXNnHYJ2wBvGwR/qvXtbYr6jP2iHCVbpPfI3fgc6VCFK4+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SH+SziQr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OujM+5YOGBG7Jz4/7Ztk/MF5TTjI8tB7z3D1VsAINX4=; b=SH+SziQryOR3JDUMp/37fhcp0X
	rJtg+4yYW9ihIMqrach944yT4WHO5ONxDps4Hhpahx1skVGB2E0jLnjmXJKQ7P38B/Em9AfLA1ytz
	UQot/ab2B0W8fJnqm+3ZSY1B5In9Pfbj7xTiBmausLbxJROg34TjPSe3KGzTkqJUPbyX638nypcxW
	e8Xb7tavhg2EuTVc9M+euDc4hS++z7CXHgfbbmd807WRQS43CrrZZ5D9Z67WwILAqMG4vArcmdkH0
	6YHvRskuOtVxNHRbDGdj9GW01vh3y5cPYgx39tUF6WgYVRHeyPD2gdn1jkEeioRfoUATKU6/r5xRL
	xXGyYrLQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54558 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vuUK0-000000003zg-2igo;
	Mon, 23 Feb 2026 11:41:52 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vuUJz-0000000AfEU-3KIy;
	Mon, 23 Feb 2026 11:41:51 +0000
In-Reply-To: <aZw86hpjQ-3w3xqJ@shell.armlinux.org.uk>
References: <aZw86hpjQ-3w3xqJ@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/2] net: stmmac: fix transmit interrupt coalescing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vuUJz-0000000AfEU-3KIy@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 23 Feb 2026 11:41:51 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260010-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.961];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 61665175A2B
X-Rspamd-Action: no action

The accounting for transmit frames does not count the descriptors
correctly. It uses:

	tx_packets = (tx_q->cur_tx + 1) - first_tx;

however, these are indexes into a circular buffer, so cur_tx can be
less than first_tx, and when that happens, tx_packets becomes a very
large unsigned integer. When this is added to tx_q->tx_count_frames,
it has the effect of reducing the count of frames, possibly causing
it to also wrap to a very large unsigned integer.

Fix this by using CIRC_CNT() to calculate the number of descriptors
used.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3277aecc5454..baf2ff577f45 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4503,7 +4503,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
 
 	/* Manage tx mitigation */
-	tx_packets = (tx_q->cur_tx + 1) - first_tx;
+	tx_packets = CIRC_CNT(tx_q->cur_tx + 1, first_tx,
+			      priv->dma_conf.dma_tx_size);
 	tx_q->tx_count_frames += tx_packets;
 
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && priv->hwts_tx_en)
@@ -4562,7 +4563,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* If we only have one entry used, then the first entry is the last
 	 * segment.
 	 */
-	is_last_segment = CIRC_CNT(tx_q->cur_tx, first_entry,,
+	is_last_segment = CIRC_CNT(tx_q->cur_tx, first_entry,
 				   priv->dma_conf.dma_tx_size) == 1;
 
 	/* Complete the first descriptor before granting the DMA */
@@ -4781,7 +4782,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * This approach takes care about the fragments: desc is the first
 	 * element in case of no SG.
 	 */
-	tx_packets = (entry + 1) - first_tx;
+	tx_packets = CIRC_CNT(entry + 1, first_tx, priv->dma_conf.dma_tx_size);
 	tx_q->tx_count_frames += tx_packets;
 
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && priv->hwts_tx_en)
-- 
2.47.3


