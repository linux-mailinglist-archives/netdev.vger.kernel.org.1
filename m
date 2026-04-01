Return-Path: <netdev+bounces-273935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF+6BGTIzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:25:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1CF375CE2
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D751130FD79D
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8043537C113;
	Wed,  1 Apr 2026 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DKQkXiJC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21AD37C101
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028130; cv=none; b=Kh/0vjR8Svo7SnTTVcyzsKUCZKnhZCgWMZQOVpkO3B1iAIJ3V/vvXXCPoAUr4Osoyw0D2Q6aRb8Sx/rOF51fAlNQf9B0roTUEs5BnxQ+OB4T6vTMEvILDltRDXm5oxHiSRslSK39JOVEIAsVhMJwjpvtuGgp+Syzbw7COPy/Fz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028130; c=relaxed/simple;
	bh=aM+B1hNDZu62DooEl95Idp02nmRmWJ28uT+Q6IzF2gc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dq3tGxwRA4Z0oGrWUCea6RWNCh501jZSSNIaQILV1pF7i+McRRsLGY71I119vu2IlW/aeX+rNhsiEHDP2y4oeckjE3GBVJfsfj6zr6SVAIEA/xcxwyzjBG0ZHyKQBx9h4v+Whq95N0dmnu4q/iChwy/XZObcABn86mlnMA2v+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DKQkXiJC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=savUdynNQeYEd7h5mjaKKtMm1gt1Y/kK7gCSnE5/gVQ=; b=DKQkXiJCaGisM+oe3gHGjQnzDI
	giGBbjJUh3zc0agDIuQRMGAAu/vtPUYBw1ODRzXcAbGqKltXdQH0iqdt8tm10MOcCUJj9Ph3neVYd
	DK01z+W8Xu4p/O8Xs+SWq3m9K2oPm4GZbATUjASW3BUqNN9uvIie7M1QyfHBFsppVHE7zDx56hxet
	/c/yJQc5uDBxjVzfCqOhPtOjFDQ6jUhOz7CpIExiNeVlRKnT9z84bhfZz7GSYMQ+8wGxeP15Ku/mS
	XhIn/IvCLQ95SSBUhXjeNiDoR9c04uPMJf2+caqziTYctGoGKBSVz3XezwEYokEnLQweP6PIQ154g
	d59gDxpQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57418 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w7ptk-000000002ht-1Lqh;
	Wed, 01 Apr 2026 08:21:56 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w7ptj-0000000Eatb-11zK;
	Wed, 01 Apr 2026 08:21:55 +0100
In-Reply-To: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
References: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
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
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 09/14] net: stmmac: simplify GSO/TSO test in
 stmmac_xmit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w7ptj-0000000Eatb-11zK@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 01 Apr 2026 08:21:55 +0100
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273935-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.868];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 7D1CF375CE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The test in stmmac_xmit() to see whether we should pass the skbuff to
stmmac_tso_xmit() is more complex than it needs to be. This test can
be simplified by storing the mask of GSO types that we will pass, and
setting it according to the enabled features.

Note that "tso" is a mis-nomer since commit b776620651a1 ("net:
stmmac: Implement UDP Segmentation Offload"). Also note that this
commit controls both via the TSO feature. We preserve this behaviour
in this commit.

Also, this commit unconditionally accessed skb_shinfo(skb)->gso_type
for all frames, even when skb_is_gso() was false. This access is
eliminated.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 +++++++++++--------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 919a93a52390..8ba8f03e1ce0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -265,8 +265,9 @@ struct stmmac_priv {
 	u32 rx_coal_frames[MTL_MAX_RX_QUEUES];
 
 	int hwts_tx_en;
+	/* skb_shinfo(skb)->gso_type types that we handle */
+	unsigned int gso_enabled_types;
 	bool tx_path_in_lpi_mode;
-	bool tso;
 	bool sph_active;
 	bool sph_capable;
 	u32 sarc_type;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d3cbe71b9af1..42e2196e82a4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4373,6 +4373,18 @@ static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
 	stmmac_set_queue_tx_tail_ptr(priv, tx_q, queue, tx_q->cur_tx);
 }
 
+static void stmmac_set_gso_types(struct stmmac_priv *priv, bool tso)
+{
+	if (!tso) {
+		priv->gso_enabled_types = 0;
+	} else {
+		/* Manage oversized TCP frames for GMAC4 device */
+		priv->gso_enabled_types = SKB_GSO_TCPV4 | SKB_GSO_TCPV6;
+		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
+			priv->gso_enabled_types |= SKB_GSO_UDP_L4;
+	}
+}
+
 static size_t stmmac_tso_header_size(struct sk_buff *skb)
 {
 	size_t size;
@@ -4706,7 +4718,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	u32 queue = skb_get_queue_mapping(skb);
 	int nfrags = skb_shinfo(skb)->nr_frags;
 	unsigned int first_entry, tx_packets;
-	int gso = skb_shinfo(skb)->gso_type;
 	struct stmmac_txq_stats *txq_stats;
 	struct dma_desc *desc, *first_desc;
 	struct stmmac_tx_queue *tx_q;
@@ -4718,14 +4729,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
 		stmmac_stop_sw_lpi(priv);
 
-	/* Manage oversized TCP frames for GMAC4 device */
-	if (skb_is_gso(skb) && priv->tso) {
-		if (gso & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))
-			return stmmac_tso_xmit(skb, dev);
-		if (priv->plat->core_type == DWMAC_CORE_GMAC4 &&
-		    (gso & SKB_GSO_UDP_L4))
-			return stmmac_tso_xmit(skb, dev);
-	}
+	if (skb_is_gso(skb) &&
+	    skb_shinfo(skb)->gso_type & priv->gso_enabled_types)
+		return stmmac_tso_xmit(skb, dev);
 
 	if (priv->est && priv->est->enable &&
 	    priv->est->max_sdu[queue]) {
@@ -6151,7 +6157,7 @@ static int stmmac_set_features(struct net_device *netdev,
 			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
 	}
 
-	priv->tso = !!(features & NETIF_F_TSO);
+	stmmac_set_gso_types(priv, features & NETIF_F_TSO);
 
 	if (features & NETIF_F_HW_VLAN_CTAG_RX)
 		priv->hw->hw_vlan_en = true;
@@ -7886,7 +7892,7 @@ static int __stmmac_dvr_probe(struct device *device,
 		ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
 		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
 			ndev->hw_features |= NETIF_F_GSO_UDP_L4;
-		priv->tso = true;
+		stmmac_set_gso_types(priv, true);
 		dev_info(priv->device, "TSO feature enabled\n");
 	}
 
-- 
2.47.3


