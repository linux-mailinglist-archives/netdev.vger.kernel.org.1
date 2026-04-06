Return-Path: <netdev+bounces-275542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NPHKsNw02n2iAcAu9opvQ
	(envelope-from <netdev+bounces-275542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 10:37:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2827A3A2493
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 10:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3201C301603C
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80FE3218BA;
	Mon,  6 Apr 2026 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="FpjvOEJj"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64D2DC765;
	Mon,  6 Apr 2026 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775464599; cv=none; b=cM7PjXteqyHAR7wuWmfIfRqQ3d08nXeOsBEw/dHH29Bu5i2NP0vXkUqWRD/DLuVdAFoUooW2OOoroFgZak6d8YR1z+N4JKWIGePsihVPIzD9BXgWZFzXzkUTkIepg9Iz4iv3VJNHX8vnUl2Ijk6d1QJQbmetugwo9LxksEZrR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775464599; c=relaxed/simple;
	bh=F06HwZw3JWNSE8Y3p2jZPqi1IU/SFLwVCkmK8lZ2uJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sajFIIp7GFy7frtF8G3JYrNsqdlkphulCxgZ2PHDWYmCEiJpn1UaIzU3AOd5PDUP2/MNr3+na3ZzyYhvTDVpEolSo1uTgSP2mzJvfVbTRuQE0od3L3oXNQzngU0NIAkZLbX3TBa081ORn2W+vS6BYK+rjPdGZrlfaVrLkazxqW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=FpjvOEJj; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F695A58A2;
	Mon,  6 Apr 2026 10:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775464595; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zz7Fx5/Wb7T6R6H+FhlMLCRSd17QJr0+4ZlXifVj7vA=;
	b=FpjvOEJjwSE1DYqUfSKig/Jdntl6AWUrI8gmr3Qd7fUGEWXBt44ZfArKZnCZj8R2viFjNN
	eyjgk2bdQ8csEbTgyxoWaALrDDl8bWFQ0UgTdL58NkzpFn/JeQ12B9Nm4LsEwbAhz/XPZQ
	H4+b21XbvTBXONKlzxQ2jIJslwA2Xv23KacXNnzDVJ2UA63Xq4MIHCbg3adh1f/6/ZzKdG
	Q/WNQ+oZ+InoJsNwNXT9ek171hlmnGIEPfZiTAtX00LMl8CYwJ0Sna9iPFcy9gpS1kg7Xg
	9urJqS3oJFFaakNPZlnDf8JQKtL5m0BuuzPcD0jXKzdTd+RVfWMwRe7n4C/rWg==
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
Subject: [PATCH net-next v6 3/7] net: bcmgenet: add basic XDP support (PASS/DROP)
Date: Mon,  6 Apr 2026 10:35:27 +0200
Message-ID: <20260406083536.839517-4-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406083536.839517-1-nb@tipi-net.de>
References: <20260406083536.839517-1-nb@tipi-net.de>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275542-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,tipi-net.de,davemloft.net,iogearbox.net,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2827A3A2493
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add XDP program attachment via ndo_bpf and execute XDP programs in the
RX path. XDP_PASS builds an SKB from the xdp_buff (handling
xdp_adjust_head/tail), XDP_DROP returns the page to page_pool without
SKB allocation.

XDP_TX and XDP_REDIRECT are not yet supported and return XDP_ABORTED.

Advertise NETDEV_XDP_ACT_BASIC in xdp_features.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 139 +++++++++++++++---
 .../net/ethernet/broadcom/genet/bcmgenet.h    |   4 +
 2 files changed, 123 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 6b66a95c2f08..187fa11ad5c2 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -35,6 +35,8 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/phy.h>
+#include <linux/bpf_trace.h>
+#include <linux/filter.h>
 
 #include <linux/unaligned.h>
 
@@ -2274,6 +2276,53 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
 	return 0;
 }
 
+static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
+					      struct xdp_buff *xdp)
+{
+	unsigned int metasize;
+	struct sk_buff *skb;
+
+	skb = napi_build_skb(xdp->data_hard_start, PAGE_SIZE);
+	if (unlikely(!skb))
+		return NULL;
+
+	skb_mark_for_recycle(skb);
+
+	metasize = xdp->data - xdp->data_meta;
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
+	__skb_put(skb, xdp->data_end - xdp->data);
+
+	if (metasize)
+		skb_metadata_set(skb, metasize);
+
+	return skb;
+}
+
+static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
+				     struct bpf_prog *prog,
+				     struct xdp_buff *xdp,
+				     struct page *rx_page)
+{
+	unsigned int act;
+
+	act = bpf_prog_run_xdp(prog, xdp);
+
+	switch (act) {
+	case XDP_PASS:
+		return XDP_PASS;
+	case XDP_DROP:
+		page_pool_put_full_page(ring->page_pool, rx_page, true);
+		return XDP_DROP;
+	default:
+		bpf_warn_invalid_xdp_action(ring->priv->dev, prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+		trace_xdp_exception(ring->priv->dev, prog, act);
+		page_pool_put_full_page(ring->page_pool, rx_page, true);
+		return XDP_ABORTED;
+	}
+}
+
 /* bcmgenet_desc_rx - descriptor based rx process.
  * this could be called from bottom half, or from NAPI polling method.
  */
@@ -2283,6 +2332,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 	struct bcmgenet_rx_stats64 *stats = &ring->stats64;
 	struct bcmgenet_priv *priv = ring->priv;
 	struct net_device *dev = priv->dev;
+	struct bpf_prog *xdp_prog;
 	struct enet_cb *cb;
 	struct sk_buff *skb;
 	u32 dma_length_status;
@@ -2293,6 +2343,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 	unsigned int p_index, mask;
 	unsigned int discards;
 
+	xdp_prog = READ_ONCE(priv->xdp_prog);
+
 	/* Clear status before servicing to reduce spurious interrupts */
 	mask = 1 << (UMAC_IRQ1_RX_INTR_SHIFT + ring->index);
 	bcmgenet_intrl2_1_writel(priv, mask, INTRL2_CPU_CLEAR);
@@ -2325,7 +2377,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		struct status_64 *status;
 		struct page *rx_page;
 		unsigned int rx_off;
-		__be16 rx_csum;
+		__be16 rx_csum = 0;
 		void *hard_start;
 
 		cb = &priv->rx_cbs[ring->read_ptr];
@@ -2403,30 +2455,44 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 			goto next;
 		} /* error packet */
 
-		/* Build SKB from the page - data starts at hard_start,
-		 * frame begins after RSB(64) + pad(2) = 66 bytes.
-		 */
-		skb = napi_build_skb(hard_start, PAGE_SIZE - GENET_XDP_HEADROOM);
-		if (unlikely(!skb)) {
-			BCMGENET_STATS64_INC(stats, dropped);
-			page_pool_put_full_page(ring->page_pool, rx_page,
-						true);
-			goto next;
-		}
-
-		skb_mark_for_recycle(skb);
-
-		/* Reserve the RSB + pad, then set the data length */
-		skb_reserve(skb, GENET_RSB_PAD);
-		__skb_put(skb, len - GENET_RSB_PAD);
+		{
+			struct xdp_buff xdp;
+			unsigned int xdp_act;
+			int pkt_len;
+
+			pkt_len = len - GENET_RSB_PAD;
+			if (priv->crc_fwd_en)
+				pkt_len -= ETH_FCS_LEN;
+
+			/* Save rx_csum before XDP runs - an XDP program
+			 * could overwrite the RSB via bpf_xdp_adjust_head.
+			 */
+			if (dev->features & NETIF_F_RXCSUM)
+				rx_csum = (__force __be16)(status->rx_csum
+							   & 0xffff);
+
+			xdp_init_buff(&xdp, PAGE_SIZE, &ring->xdp_rxq);
+			xdp_prepare_buff(&xdp, page_address(rx_page),
+					 GENET_RX_HEADROOM, pkt_len, true);
+
+			if (xdp_prog) {
+				xdp_act = bcmgenet_run_xdp(ring, xdp_prog,
+							   &xdp, rx_page);
+				if (xdp_act != XDP_PASS)
+					goto next;
+			}
 
-		if (priv->crc_fwd_en) {
-			skb_trim(skb, skb->len - ETH_FCS_LEN);
+			skb = bcmgenet_xdp_build_skb(ring, &xdp);
+			if (unlikely(!skb)) {
+				BCMGENET_STATS64_INC(stats, dropped);
+				page_pool_put_full_page(ring->page_pool,
+							rx_page, true);
+				goto next;
+			}
 		}
 
 		/* Set up checksum offload */
 		if (dev->features & NETIF_F_RXCSUM) {
-			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
 			if (rx_csum) {
 				skb->csum = (__force __wsum)ntohs(rx_csum);
 				skb->ip_summed = CHECKSUM_COMPLETE;
@@ -3744,6 +3810,37 @@ static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
 	return 0;
 }
 
+static int bcmgenet_xdp_setup(struct net_device *dev,
+			      struct netdev_bpf *xdp)
+{
+	struct bcmgenet_priv *priv = netdev_priv(dev);
+	struct bpf_prog *old_prog;
+	struct bpf_prog *prog = xdp->prog;
+
+	if (prog && dev->mtu > PAGE_SIZE - GENET_RX_HEADROOM -
+	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {
+		NL_SET_ERR_MSG_MOD(xdp->extack,
+				   "MTU too large for single-page XDP buffer");
+		return -EOPNOTSUPP;
+	}
+
+	old_prog = xchg(&priv->xdp_prog, prog);
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	return 0;
+}
+
+static int bcmgenet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	switch (xdp->command) {
+	case XDP_SETUP_PROG:
+		return bcmgenet_xdp_setup(dev, xdp);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_open		= bcmgenet_open,
 	.ndo_stop		= bcmgenet_close,
@@ -3755,6 +3852,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_set_features	= bcmgenet_set_features,
 	.ndo_get_stats64	= bcmgenet_get_stats64,
 	.ndo_change_carrier	= bcmgenet_change_carrier,
+	.ndo_bpf		= bcmgenet_xdp,
 };
 
 /* GENET hardware parameters/characteristics */
@@ -4057,6 +4155,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 			 NETIF_F_RXCSUM;
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC;
 
 	netdev_sw_irq_coalesce_default_on(dev);
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 82a6d29f481d..1459473ac1b0 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -16,6 +16,7 @@
 #include <linux/dim.h>
 #include <linux/ethtool.h>
 #include <net/page_pool/helpers.h>
+#include <linux/bpf.h>
 #include <net/xdp.h>
 
 #include "../unimac.h"
@@ -671,6 +672,9 @@ struct bcmgenet_priv {
 	u8 sopass[SOPASS_MAX];
 
 	struct bcmgenet_mib_counters mib;
+
+	/* XDP */
+	struct bpf_prog *xdp_prog;
 };
 
 static inline bool bcmgenet_has_40bits(struct bcmgenet_priv *priv)
-- 
2.51.0


