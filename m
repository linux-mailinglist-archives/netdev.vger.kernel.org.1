Return-Path: <netdev+bounces-267974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPpwMmUqt2kLNQEAu9opvQ
	(envelope-from <netdev+bounces-267974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 22:53:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39017292BE0
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 22:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A6AA30AB5D0
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE2737EFE8;
	Sun, 15 Mar 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="swzCEM2G"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762C37D128;
	Sun, 15 Mar 2026 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773611411; cv=none; b=pofBe+egDUNiehwD0WFelUkl2W5uBp61T6DF6M15ugU/Cufx+o/xMuRyd0pZHxkzbiMXE/aE/21xNnqO3HDRzyLJJ9Y4T5qQpdl149dJ5e+52Tp4lEUpJYoMzy82IsCedkg/jZ6FpkeazXJ4b9b3DwkWp0jnIn99YeMUmWZVhjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773611411; c=relaxed/simple;
	bh=vVlU/tLju4Y1C+amxm9HQKjeleu1zqO9lZT3LOSTwaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDffZ2uf7Y5RvOMbhQboy+RFy1ik8P1pfLBDGzPswyQxLF/4gm1ZfIrQfW/tL4D/OZqstaL7tzy+f2kKjNxQ+Ens2HhPZHEviBzaGosLAd3r5wN9fAHLg8WTQHV8TiX8qLYtMJfigdPhEUVSP85kE+bNzywz87JDWZH9diVuFjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=swzCEM2G; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57229A575C;
	Sun, 15 Mar 2026 22:50:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773611403; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Cll75lNtnT5wlTHQImlKL6wvWpXQYzV8bB5+50bW3fM=;
	b=swzCEM2GU5G0GfDBKUZfUoZK6QelRFsAW57uUnb/9DgvWoaZgRavj4BhT1X4M2603sVbb7
	DhpRjdBNOB57gsn0nCI3kaT1uqKDk7vENNpKgJUnmWF2v8mNvc/Wkjnd8sCPkEjHapcbqN
	d97DII8sG242lxGN5HOqZD5hFsnRZf6fL5lW88tVFLtrsN9o9TpUl78LFAzzmYOpe01GpS
	4mtIDz8xyu4yqxfJmirpXdO0Hjv8caNeKgUAUcn6/g27pa3M36kVUzFvj/hjd0BMPGDQNU
	tSJuINrAQGwBMezgtJRSTfxYVyGn/BpdjpfcgrsMnAvIVa9PPm1vEWP5ZIlFvg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Markus=20Bl=C3=B6chl?= <mbloch@rooftopnetworks.de>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v2 5/6] net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support
Date: Sun, 15 Mar 2026 22:49:13 +0100
Message-ID: <20260315214914.1555777-6-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315214914.1555777-1-nb@tipi-net.de>
References: <20260315214914.1555777-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-267974-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,rooftopnetworks.de,arndb.de,vger.kernel.org,tipi-net.de];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39017292BE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add XDP_REDIRECT support and implement ndo_xdp_xmit for receiving
redirected frames from other devices.

XDP_REDIRECT calls xdp_do_redirect() in the RX path with
xdp_do_flush() once per NAPI poll cycle. ndo_xdp_xmit batches frames
into ring 16 under a single spinlock acquisition.

Advertise NETDEV_XDP_ACT_REDIRECT and NETDEV_XDP_ACT_NDO_XMIT in
xdp_features.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 96 +++++++++++++++----
 1 file changed, 78 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 922895bc7461..5dfe6b764930 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2320,23 +2320,23 @@ static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
 	return skb;
 }
 
+/* Submit a single XDP frame to the TX ring. Caller must hold ring->lock.
+ * Returns true on success. Does not ring the doorbell - caller must
+ * write TDMA_PROD_INDEX after batching.
+ */
 static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
+				     struct bcmgenet_tx_ring *ring,
 				     struct xdp_frame *xdpf,
 				     bool dma_map)
 {
-	struct bcmgenet_tx_ring *ring = &priv->tx_rings[DESC_INDEX];
 	struct device *kdev = &priv->pdev->dev;
 	struct enet_cb *tx_cb_ptr;
 	dma_addr_t mapping;
 	unsigned int dma_len;
 	u32 len_stat;
 
-	spin_lock(&ring->lock);
-
-	if (ring->free_bds < 1) {
-		spin_unlock(&ring->lock);
+	if (ring->free_bds < 1)
 		return false;
-	}
 
 	tx_cb_ptr = bcmgenet_get_txcb(priv, ring);
 
@@ -2350,7 +2350,6 @@ static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
 		 */
 		if (unlikely(xdpf->headroom < sizeof(struct status_64))) {
 			bcmgenet_put_txcb(priv, ring);
-			spin_unlock(&ring->lock);
 			return false;
 		}
 
@@ -2364,7 +2363,6 @@ static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
 			tx_cb_ptr->skb = NULL;
 			tx_cb_ptr->xdpf = NULL;
 			bcmgenet_put_txcb(priv, ring);
-			spin_unlock(&ring->lock);
 			return false;
 		}
 	} else {
@@ -2396,12 +2394,14 @@ static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
 	ring->prod_index++;
 	ring->prod_index &= DMA_P_INDEX_MASK;
 
+	return true;
+}
+
+static void bcmgenet_xdp_ring_doorbell(struct bcmgenet_priv *priv,
+					struct bcmgenet_tx_ring *ring)
+{
 	bcmgenet_tdma_ring_writel(priv, ring->index, ring->prod_index,
 				  TDMA_PROD_INDEX);
-
-	spin_unlock(&ring->lock);
-
-	return true;
 }
 
 static unsigned int
@@ -2417,7 +2417,11 @@ bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
 	switch (act) {
 	case XDP_PASS:
 		return XDP_PASS;
-	case XDP_TX:
+	case XDP_TX: {
+		struct bcmgenet_tx_ring *tx_ring;
+
+		tx_ring = &priv->tx_rings[DESC_INDEX];
+
 		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
 		 * MAC has TBUF_64B_EN set globally, so hardware expects every
 		 * TX buffer to begin with a 64-byte struct status_64.  Back
@@ -2429,14 +2433,26 @@ bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
 		memset(xdp->data, 0, sizeof(struct status_64));
 
 		xdpf = xdp_convert_buff_to_frame(xdp);
-		if (unlikely(!xdpf) ||
-		    unlikely(!bcmgenet_xdp_xmit_frame(priv, xdpf, false))) {
-			page_pool_put_full_page(ring->page_pool, rx_page,
-						true);
+		if (unlikely(!xdpf))
+			goto drop_page;
+
+		spin_lock(&tx_ring->lock);
+		if (unlikely(!bcmgenet_xdp_xmit_frame(priv, tx_ring, xdpf,
+						       false))) {
+			spin_unlock(&tx_ring->lock);
+			xdp_return_frame_rx_napi(xdpf);
 			return XDP_DROP;
 		}
+		bcmgenet_xdp_ring_doorbell(priv, tx_ring);
+		spin_unlock(&tx_ring->lock);
 		return XDP_TX;
+	}
+	case XDP_REDIRECT:
+		if (unlikely(xdp_do_redirect(priv->dev, xdp, prog)))
+			goto drop_page;
+		return XDP_REDIRECT;
 	case XDP_DROP:
+drop_page:
 		page_pool_put_full_page(ring->page_pool, rx_page, true);
 		return XDP_DROP;
 	default:
@@ -2459,6 +2475,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 	struct bcmgenet_priv *priv = ring->priv;
 	struct net_device *dev = priv->dev;
 	struct bpf_prog *xdp_prog;
+	bool xdp_flush = false;
 	struct enet_cb *cb;
 	struct sk_buff *skb;
 	u32 dma_length_status;
@@ -2597,6 +2614,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 
 			xdp_act = bcmgenet_run_xdp(ring, xdp_prog, &xdp,
 						   rx_page);
+			if (xdp_act == XDP_REDIRECT)
+				xdp_flush = true;
 			if (xdp_act != XDP_PASS)
 				goto next;
 
@@ -2670,6 +2689,9 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		bcmgenet_rdma_ring_writel(priv, ring->index, ring->c_index, RDMA_CONS_INDEX);
 	}
 
+	if (xdp_flush)
+		xdp_do_flush();
+
 	ring->dim.bytes = bytes_processed;
 	ring->dim.packets = rxpktprocessed;
 
@@ -3996,10 +4018,16 @@ static int bcmgenet_xdp_setup(struct net_device *dev,
 		return -EOPNOTSUPP;
 	}
 
+	if (!prog)
+		xdp_features_clear_redirect_target(dev);
+
 	old_prog = xchg(&priv->xdp_prog, prog);
 	if (old_prog)
 		bpf_prog_put(old_prog);
 
+	if (prog)
+		xdp_features_set_redirect_target(dev, false);
+
 	return 0;
 }
 
@@ -4013,6 +4041,36 @@ static int bcmgenet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+static int bcmgenet_xdp_xmit(struct net_device *dev, int num_frames,
+			      struct xdp_frame **frames, u32 flags)
+{
+	struct bcmgenet_priv *priv = netdev_priv(dev);
+	struct bcmgenet_tx_ring *ring = &priv->tx_rings[DESC_INDEX];
+	int sent = 0;
+	int i;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	if (unlikely(!netif_running(dev)))
+		return -ENETDOWN;
+
+	spin_lock(&ring->lock);
+
+	for (i = 0; i < num_frames; i++) {
+		if (!bcmgenet_xdp_xmit_frame(priv, ring, frames[i], true))
+			break;
+		sent++;
+	}
+
+	if (sent)
+		bcmgenet_xdp_ring_doorbell(priv, ring);
+
+	spin_unlock(&ring->lock);
+
+	return sent;
+}
+
 static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_open		= bcmgenet_open,
 	.ndo_stop		= bcmgenet_close,
@@ -4025,6 +4083,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_get_stats64	= bcmgenet_get_stats64,
 	.ndo_change_carrier	= bcmgenet_change_carrier,
 	.ndo_bpf		= bcmgenet_xdp,
+	.ndo_xdp_xmit		= bcmgenet_xdp_xmit,
 };
 
 /* GENET hardware parameters/characteristics */
@@ -4327,7 +4386,8 @@ static int bcmgenet_probe(struct platform_device *pdev)
 			 NETIF_F_RXCSUM;
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
-	dev->xdp_features = NETDEV_XDP_ACT_BASIC;
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			    NETDEV_XDP_ACT_NDO_XMIT;
 
 	netdev_sw_irq_coalesce_default_on(dev);
 
-- 
2.51.0


