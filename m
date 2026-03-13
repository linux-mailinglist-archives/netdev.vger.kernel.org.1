Return-Path: <netdev+bounces-267348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEwAHhrYs2mzbgAAu9opvQ
	(envelope-from <netdev+bounces-267348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:25:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7F828072E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C28B231F075B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AF738D693;
	Fri, 13 Mar 2026 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="g/AiXdG2"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133EB38C406;
	Fri, 13 Mar 2026 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393692; cv=none; b=Z3v5RWmFxso54DtGpVLJ3WmdbV411Q60U6SML2XI+LF4o98L6bhhWZpi4z1CbDSB5JKi1LwgaNntTtswce8uiFUwcGNVZRttkc7dWF5OwGmUkdl9od2B5c/1wjgI9+aC6j3CFICA65WCniCyG2dJ6MvnqVBNeykMxKcmnoKMiPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393692; c=relaxed/simple;
	bh=3kA9lM7oCDmwBK8M854mec3iiuzF6TGWVkELDzJqUno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AX6ceSG/3OXiNbZgtd1TzGZb0mHar7OYrvmiZ91pATOmTU20RDj/nyhXVEw1G4kuzr2HqzcXtLN3wkL7tD1cp5a5J2Lbyh3laK0rrggW+0OeiyWmELImUR3sRO0mvypVVCaxVgB/xmy+s4bE37t3g8AE8jOQI5wEbfxL1TdzH+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=g/AiXdG2; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C946A5707;
	Fri, 13 Mar 2026 10:21:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773393683; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=sUBslANvz1iK7buw/1PFrNaGDaQNEW2r48m8snuZBHw=;
	b=g/AiXdG2441GysUrJsgQlQZUg9YWTsI8GD16OlJSlofhqQbCEuWMjqkeAtfXdkCPOVo0Y+
	8sENIDnCOC6mwyhrBwEJsEgC6sR+UXffqknD+Kl5oyrvEztlN6ou+UAR09ERKwZlIBU0P1
	n/XAUu4LGj0Ddou+atCcTGqJMhIr1BRIvuAjdSTp4fxgdwsE/xtsR9FVD8TDVrY8Dvnwc0
	VHWHcMet+x0Ay+NduqAhsafQHj1jeXhzZNawSxK3N+VySHLHpcTM7SOJibojGgQhAxQh+y
	WSzmKSgrzRjfyFgNMrGbIAhmaH5qwqRuSYH1QLi4hvdJajRV+CoElXGKpxdF/Q==
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
Subject: [PATCH net-next 5/6] net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support
Date: Fri, 13 Mar 2026 10:21:00 +0100
Message-ID: <20260313092101.1344954-6-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313092101.1344954-1-nb@tipi-net.de>
References: <20260313092101.1344954-1-nb@tipi-net.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-267348-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Queue-Id: CA7F828072E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add XDP_REDIRECT support and implement ndo_xdp_xmit for receiving
redirected frames from other devices.

XDP_REDIRECT uses xdp_do_redirect() in the RX path with xdp_do_flush()
called once per NAPI poll cycle.

ndo_xdp_xmit batches multiple frames into the default TX ring under a
single spinlock acquisition, ringing the doorbell once after all frames
are queued. Call xdp_features_set/clear_redirect_target in the setup
path.

Advertise NETDEV_XDP_ACT_REDIRECT and NETDEV_XDP_ACT_NDO_XMIT in
xdp_features.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 93 +++++++++++++++----
 1 file changed, 76 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 373ba5878ca1..30181f9cff98 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2305,21 +2305,21 @@ static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
 	return skb;
 }
 
+/* Submit a single XDP frame to the TX ring. Caller must hold ring->lock.
+ * Returns true on success. Does not ring the doorbell - caller must
+ * write TDMA_PROD_INDEX after batching.
+ */
 static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
+				     struct bcmgenet_tx_ring *ring,
 				     struct xdp_frame *xdpf)
 {
-	struct bcmgenet_tx_ring *ring = &priv->tx_rings[DESC_INDEX];
 	struct device *kdev = &priv->pdev->dev;
 	struct enet_cb *tx_cb_ptr;
 	dma_addr_t mapping;
 	u32 len_stat;
 
-	spin_lock(&ring->lock);
-
-	if (ring->free_bds < 1) {
-		spin_unlock(&ring->lock);
+	if (ring->free_bds < 1)
 		return false;
-	}
 
 	tx_cb_ptr = bcmgenet_get_txcb(priv, ring);
 
@@ -2328,7 +2328,6 @@ static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
 		tx_cb_ptr->skb = NULL;
 		tx_cb_ptr->xdpf = NULL;
 		bcmgenet_put_txcb(priv, ring);
-		spin_unlock(&ring->lock);
 		return false;
 	}
 
@@ -2347,12 +2346,14 @@ static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
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
@@ -2368,16 +2369,30 @@ bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
 	switch (act) {
 	case XDP_PASS:
 		return XDP_PASS;
-	case XDP_TX:
+	case XDP_TX: {
+		struct bcmgenet_tx_ring *tx_ring;
+
+		tx_ring = &priv->tx_rings[DESC_INDEX];
 		xdpf = xdp_convert_buff_to_frame(xdp);
-		if (unlikely(!xdpf) ||
-		    unlikely(!bcmgenet_xdp_xmit_frame(priv, xdpf))) {
-			page_pool_put_full_page(ring->page_pool, rx_page,
-						true);
+		if (unlikely(!xdpf))
+			goto drop_page;
+
+		spin_lock(&tx_ring->lock);
+		if (unlikely(!bcmgenet_xdp_xmit_frame(priv, tx_ring, xdpf))) {
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
@@ -2400,6 +2415,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 	struct bcmgenet_priv *priv = ring->priv;
 	struct net_device *dev = priv->dev;
 	struct bpf_prog *xdp_prog;
+	bool xdp_flush = false;
 	struct enet_cb *cb;
 	struct sk_buff *skb;
 	u32 dma_length_status;
@@ -2538,6 +2554,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 
 			xdp_act = bcmgenet_run_xdp(ring, xdp_prog, &xdp,
 						   rx_page);
+			if (xdp_act == XDP_REDIRECT)
+				xdp_flush = true;
 			if (xdp_act != XDP_PASS)
 				goto next;
 
@@ -2611,6 +2629,9 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		bcmgenet_rdma_ring_writel(priv, ring->index, ring->c_index, RDMA_CONS_INDEX);
 	}
 
+	if (xdp_flush)
+		xdp_do_flush();
+
 	ring->dim.bytes = bytes_processed;
 	ring->dim.packets = rxpktprocessed;
 
@@ -3903,10 +3924,16 @@ static int bcmgenet_xdp_setup(struct net_device *dev,
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
 
@@ -3920,6 +3947,36 @@ static int bcmgenet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
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
+		if (!bcmgenet_xdp_xmit_frame(priv, ring, frames[i]))
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
@@ -3932,6 +3989,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_get_stats64	= bcmgenet_get_stats64,
 	.ndo_change_carrier	= bcmgenet_change_carrier,
 	.ndo_bpf		= bcmgenet_xdp,
+	.ndo_xdp_xmit		= bcmgenet_xdp_xmit,
 };
 
 /* GENET hardware parameters/characteristics */
@@ -4234,7 +4292,8 @@ static int bcmgenet_probe(struct platform_device *pdev)
 			 NETIF_F_RXCSUM;
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
-	dev->xdp_features = NETDEV_XDP_ACT_BASIC;
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			    NETDEV_XDP_ACT_NDO_XMIT;
 
 	netdev_sw_irq_coalesce_default_on(dev);
 
-- 
2.51.0


