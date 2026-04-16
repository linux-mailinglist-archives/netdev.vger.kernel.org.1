Return-Path: <netdev+bounces-278937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DPmAnV44GkfhgAAu9opvQ
	(envelope-from <netdev+bounces-278937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:49:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E8240A773
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78E363103275
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579237C11C;
	Thu, 16 Apr 2026 05:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="DNzxU1jh"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6BF37B014;
	Thu, 16 Apr 2026 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318511; cv=none; b=oloXvLlh6tT4XhrRk7vBevx/g8ExTVuOqoFG1jh2Br5+Gdq9Nw/FryzNsjkxSn30LrsQoqNr2XBxXd4AWfE28dRz9OrRgh7tm6iXyUa8XzoAncYx6npMAl2DGp9YYPKlQuN33MkPt0JGph2yBoixK5gfN2GofPgksPSSbSjc/Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318511; c=relaxed/simple;
	bh=ddZ9eutBx8TYQ5UQwHGIKp9VzmjurkX87v89C8qWRLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAdFyiE4SVOaHOhM8iZgSHPWWCTvNNMOYR8XhRLxg11S9pv4fuv2cCe4fBS44nvshmrHPHun0ttkmX2OUTkNnjhGEeljYSNSGJtfCZOrLNecW+wPzMnaL0xEGde/HVTLbpZF/QmYveXTwqnRM9xzSf+IFhZtH08vYqALebkqwtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=DNzxU1jh; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3992A3858;
	Thu, 16 Apr 2026 07:48:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1776318504; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=BbBiXf2wR/vJcDJsUaayibLe5iuk/l+F1TyNdFmTf5Q=;
	b=DNzxU1jhX5jdMJjs6D2SdkqzC9ncYIVhOSK/Nnk5b7U0b9o13dhpky5bscRhNC7qwjT2sa
	7ORvsET1z0Ld85l9/Q1UVuyoIsZsjcbNI90CLj7FKJdoAOEKJxS/pqOQtLVmGcBevC6Xkt
	QMNEUyKCuzgTLEJP4WQLw2+Ke1QlCsZw60zvlBOszNIG4hN6efMfRLE10WQEKz1bfozgMv
	kM2sMDkoHoxrGnXYpcGAnMre0XKXS4oqxt1CS31F5KfDiTSvU7kJjD+6ATomPTLjaC+l63
	is9emEJdLuKJtqoa4bQ6H5Ycq/Y/xeIjwvOxqFaJboS/I4Crt4846duxKcg5bQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v7 5/7] net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support
Date: Thu, 16 Apr 2026 07:47:37 +0200
Message-ID: <20260416054743.1289191-6-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260416054743.1289191-1-nb@tipi-net.de>
References: <20260416054743.1289191-1-nb@tipi-net.de>
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
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tipi-net.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:server fail];
	TAGGED_FROM(0.00)[bounces-278937-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,tipi-net.de,davemloft.net,iogearbox.net,fomichev.me,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tipi-net.de:email,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: C9E8240A773
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
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 87 ++++++++++++++++---
 1 file changed, 73 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 3f3682e39267..f94e9e287fe9 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2326,22 +2326,22 @@ static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
 	return skb;
 }
 
+/* Submit a single XDP frame to the TX ring. Caller must hold ring->lock.
+ * Returns true on success. Does not ring the doorbell - caller must
+ * write TDMA_PROD_INDEX after batching.
+ */
 static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
+				     struct bcmgenet_tx_ring *ring,
 				     struct xdp_frame *xdpf, bool dma_map)
 {
-	struct bcmgenet_tx_ring *ring = &priv->xdp_tx_ring;
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
 
@@ -2355,7 +2355,6 @@ static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
 		 */
 		if (unlikely(xdpf->headroom < sizeof(struct status_64))) {
 			bcmgenet_put_txcb(priv, ring);
-			spin_unlock(&ring->lock);
 			return false;
 		}
 
@@ -2369,7 +2368,6 @@ static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
 			tx_cb_ptr->skb = NULL;
 			tx_cb_ptr->xdpf = NULL;
 			bcmgenet_put_txcb(priv, ring);
-			spin_unlock(&ring->lock);
 			return false;
 		}
 	} else {
@@ -2401,12 +2399,14 @@ static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
 	ring->prod_index++;
 	ring->prod_index &= DMA_P_INDEX_MASK;
 
+	return true;
+}
+
+static void bcmgenet_xdp_ring_doorbell(struct bcmgenet_priv *priv,
+				       struct bcmgenet_tx_ring *ring)
+{
 	bcmgenet_tdma_ring_writel(priv, ring->index, ring->prod_index,
 				  TDMA_PROD_INDEX);
-
-	spin_unlock(&ring->lock);
-
-	return true;
 }
 
 static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
@@ -2415,6 +2415,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 				     struct page *rx_page)
 {
 	struct bcmgenet_priv *priv = ring->priv;
+	struct bcmgenet_tx_ring *tx_ring;
 	struct xdp_frame *xdpf;
 	unsigned int act;
 
@@ -2449,11 +2450,25 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 						true);
 			return XDP_DROP;
 		}
-		if (unlikely(!bcmgenet_xdp_xmit_frame(priv, xdpf, false))) {
+
+		tx_ring = &priv->xdp_tx_ring;
+		spin_lock(&tx_ring->lock);
+		if (unlikely(!bcmgenet_xdp_xmit_frame(priv, tx_ring,
+						      xdpf, false))) {
+			spin_unlock(&tx_ring->lock);
 			xdp_return_frame_rx_napi(xdpf);
 			return XDP_DROP;
 		}
+		bcmgenet_xdp_ring_doorbell(priv, tx_ring);
+		spin_unlock(&tx_ring->lock);
 		return XDP_TX;
+	case XDP_REDIRECT:
+		if (unlikely(xdp_do_redirect(priv->dev, xdp, prog))) {
+			page_pool_put_full_page(ring->page_pool, rx_page,
+						true);
+			return XDP_DROP;
+		}
+		return XDP_REDIRECT;
 	case XDP_DROP:
 		page_pool_put_full_page(ring->page_pool, rx_page, true);
 		return XDP_DROP;
@@ -2477,6 +2492,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 	struct bcmgenet_priv *priv = ring->priv;
 	struct net_device *dev = priv->dev;
 	struct bpf_prog *xdp_prog;
+	bool xdp_flush = false;
 	struct enet_cb *cb;
 	struct sk_buff *skb;
 	u32 dma_length_status;
@@ -2617,6 +2633,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 				 GENET_RX_HEADROOM, pkt_len, true);
 
 		xdp_act = bcmgenet_run_xdp(ring, xdp_prog, &xdp, rx_page);
+		if (xdp_act == XDP_REDIRECT)
+			xdp_flush = true;
 		if (xdp_act != XDP_PASS)
 			goto next;
 
@@ -2668,6 +2686,9 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		bcmgenet_rdma_ring_writel(priv, ring->index, ring->c_index, RDMA_CONS_INDEX);
 	}
 
+	if (xdp_flush)
+		xdp_do_flush();
+
 	ring->dim.bytes = bytes_processed;
 	ring->dim.packets = rxpktprocessed;
 
@@ -3998,10 +4019,16 @@ static int bcmgenet_xdp_setup(struct net_device *dev,
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
 
@@ -4015,6 +4042,36 @@ static int bcmgenet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+static int bcmgenet_xdp_xmit(struct net_device *dev, int num_frames,
+			     struct xdp_frame **frames, u32 flags)
+{
+	struct bcmgenet_priv *priv = netdev_priv(dev);
+	struct bcmgenet_tx_ring *ring = &priv->xdp_tx_ring;
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
@@ -4027,6 +4084,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_get_stats64	= bcmgenet_get_stats64,
 	.ndo_change_carrier	= bcmgenet_change_carrier,
 	.ndo_bpf		= bcmgenet_xdp,
+	.ndo_xdp_xmit		= bcmgenet_xdp_xmit,
 };
 
 /* GENET hardware parameters/characteristics */
@@ -4329,7 +4387,8 @@ static int bcmgenet_probe(struct platform_device *pdev)
 			 NETIF_F_RXCSUM;
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
-	dev->xdp_features = NETDEV_XDP_ACT_BASIC;
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			    NETDEV_XDP_ACT_NDO_XMIT;
 
 	netdev_sw_irq_coalesce_default_on(dev);
 
-- 
2.51.0


