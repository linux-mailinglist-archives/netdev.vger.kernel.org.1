Return-Path: <netdev+bounces-272478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LHcIxRSxmk2IgUAu9opvQ
	(envelope-from <netdev+bounces-272478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:47:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 246A6341F6E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDDB430BBCC3
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED3C3DC4CA;
	Fri, 27 Mar 2026 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WHuW0+z7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28ED3DBD69
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604419; cv=none; b=MmSZYI+qRhtXqgWTx1ckDvjw92lB7Vl71wcwhvDTg2mejD3YpUyIkCk4j4kvWzi9xMk7pvuYY4C+WkaB/7+WgThh4Qy8xhi7YItvq7I0dCxuaL9jqRFqSl7QxA8HHiTmNQFzpiybYGZ1dr1lfeY5yRTf+XiGAbf0eHCG6yBbtfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604419; c=relaxed/simple;
	bh=K8ovAYpHSnxBI1qb+v+ji0RMShlh1egqXNpbkFwFpik=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=QUBR6qf8IH9+PfpF5czbZaquSuFNJZa+BCrgZsBuuugXHgfVuGdFtG4LvKvRy97WHKymr32fMlVB6pJAND2Zs2bLSi9tQgMvhFC4RrKRrUufShq/9gJ7QzCjIg2FvgaZj0C0BybGAAHwuU/JffQaElG5Fd/DDa1orXoFkaPX3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WHuW0+z7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fawkXS8Rr0AZqEUfKJTfuG1xiHahNuC6zqO8x6E7Pd4=; b=WHuW0+z7d6VcWutbo537wyEp64
	CvkiirJPxga0vxnD1fHvOnEYL6ggp+agAkKPAf6L+bQJSFmGjEIC7KuT9R2PnUWc0zHjwbVwrM587
	5HOjZWzzvCDA6vi0Psd+AUa5V2oJ/fbfVHGhDJvtclVB9us8f/HyMUxBEBvnMQFXixrCEjQG1AREI
	zSWxxSHs78uEhwbTAPdurRRykAmjGVQyR4BED8JOg2DQex678fw5rfAGe/2O0dfssqFt3jcw6bLjk
	isYopso905kdCwwTPXge5fME+d1CEX5Ijrymw0xUXLhmmjyAhxs55fPlt79zGp/X5DRxXHA45frWN
	vbIjDcng==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46908 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w63fm-000000005xn-2XFJ;
	Fri, 27 Mar 2026 09:40:10 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w63fl-0000000E3Vb-3JkY;
	Fri, 27 Mar 2026 09:40:09 +0000
In-Reply-To: <acZQaDeCoib5S5UA@shell.armlinux.org.uk>
References: <acZQaDeCoib5S5UA@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/2] net: stmmac: simplify GSO/TSO test in
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
Message-Id: <E1w63fl-0000000E3Vb-3JkY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Mar 2026 09:40:09 +0000
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
	TAGGED_FROM(0.00)[bounces-272478-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 246A6341F6E
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
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 30 +++++++++++--------
 2 files changed, 20 insertions(+), 13 deletions(-)

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
index 8203d6845b00..d3e8d793af52 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3700,7 +3700,7 @@ static int stmmac_hw_setup(struct net_device *dev)
 	stmmac_set_rings_length(priv);
 
 	/* Enable TSO */
-	if (priv->tso) {
+	if (priv->gso_enabled_types) {
 		for (chan = 0; chan < tx_cnt; chan++) {
 			struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[chan];
 
@@ -4675,7 +4675,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	u32 queue = skb_get_queue_mapping(skb);
 	int nfrags = skb_shinfo(skb)->nr_frags;
 	unsigned int first_entry, tx_packets;
-	int gso = skb_shinfo(skb)->gso_type;
 	struct stmmac_txq_stats *txq_stats;
 	struct dma_desc *desc, *first_desc;
 	struct stmmac_tx_queue *tx_q;
@@ -4687,14 +4686,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -6049,6 +6043,18 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
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
 static netdev_features_t stmmac_fix_features(struct net_device *dev,
 					     netdev_features_t features)
 {
@@ -6094,7 +6100,7 @@ static int stmmac_set_features(struct net_device *netdev,
 			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
 	}
 
-	priv->tso = !!(features & NETIF_F_TSO);
+	stmmac_set_gso_types(priv, features & NETIF_F_TSO);
 
 	if (features & NETIF_F_HW_VLAN_CTAG_RX)
 		priv->hw->hw_vlan_en = true;
@@ -7828,7 +7834,7 @@ static int __stmmac_dvr_probe(struct device *device,
 		ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
 		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
 			ndev->hw_features |= NETIF_F_GSO_UDP_L4;
-		priv->tso = true;
+		stmmac_set_gso_types(priv, true);
 		dev_info(priv->device, "TSO feature enabled\n");
 	}
 
-- 
2.47.3


