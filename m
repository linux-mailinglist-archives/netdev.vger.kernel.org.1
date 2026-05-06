Return-Path: <netdev+bounces-284770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHicDGMQ+2mbVQMAu9opvQ
	(envelope-from <netdev+bounces-284770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:56:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 306A54D908E
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 586CD301530B
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B143F9F27;
	Wed,  6 May 2026 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="1eXugjMk"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41D3F7865;
	Wed,  6 May 2026 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061386; cv=none; b=qY/Xjdk7q4xajAht2Z2JznXRDNpFZe6uh/1/SGre5Vxyx9ORqDgRScAZvAaZg4lKaLfqaFfJrtlogKIh31bTF8r6TRl/FumfA9feRtGVEf3zVWOYVsihi8qsC0x4AcD1NQESHBEc8+FicQRp63h5bb9WPcHOxjD8q8QLIl5WDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061386; c=relaxed/simple;
	bh=uJHYNI+4SbONsAxhMzvLGo8D7LEzdL2fCafDYRKRigM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idfFzYDt+ABQaNrEmx+eB3loj15jp3U1bOFVTSxKObVdenP3MtZry6D1nDlQ7m05bX+K9G+Xhc8jeRW4xYmpr1FdheHf7WNj+iH/Py10PPhv54dF/GbBfEu9iXERYfRBFwQOEnhcoSTVNLtmFWIu1L0EK9/jcXXjYV6hdBPLlrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=1eXugjMk; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 270ADA50C8;
	Wed,  6 May 2026 11:56:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1778061365; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=iPep1S0MBMDmzie9CAoC4CWSIFuFwFlInqpWxEJXeHs=;
	b=1eXugjMkD7tPMJelzstMADEUo0Klt+HyLpHr0XAML9AjO7FuF8OEPbojVyHO4Za50tp4ZF
	MMOWWT+qwsOvpID9aLzAjRmhK5BXbOqKAh/JO7H79YBRx4nKswSyqmedFK/dGbZc+hgyo3
	leUOf7r35jHkBRgmVA2U5elGX+S+tWwBwNbOAbjUuoNmXkHkn/KFsGMXCSr2VI8yswrwnY
	RkqFUYnib1SCEtrXT0MlyXJ3YtWjyeYev3YeUrV8lLQQRuyg/oAXukeyLlwd2IEYNH44u7
	XKlQo1U+kPCsdfknya6hEdzvsvl+jkK0DhcBkIudwDUDaTxkYJYa/FPfCWo26w==
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
Subject: [PATCH net-next v9 3/7] net: bcmgenet: add basic XDP support (PASS/DROP)
Date: Wed,  6 May 2026 11:55:46 +0200
Message-ID: <20260506095553.55357-4-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260506095553.55357-1-nb@tipi-net.de>
References: <20260506095553.55357-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 306A54D908E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284770-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,tipi-net.de,davemloft.net,iogearbox.net,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Add XDP program attachment via ndo_bpf and execute XDP programs in the
RX path. XDP_PASS builds an SKB from the xdp_buff (handling
xdp_adjust_head/tail), XDP_DROP returns the page to page_pool without
SKB allocation.

XDP_TX and XDP_REDIRECT are not yet supported and return XDP_ABORTED.

Advertise NETDEV_XDP_ACT_BASIC in xdp_features.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 129 +++++++++++++++---
 .../net/ethernet/broadcom/genet/bcmgenet.h    |   4 +
 2 files changed, 116 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 5bedc18685b0..ee1d4ecc2b87 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -36,6 +36,8 @@
 #include <linux/ipv6.h>
 #include <linux/phy.h>
 #include <linux/bpf.h>
+#include <linux/bpf_trace.h>
+#include <linux/filter.h>
 
 #include <linux/unaligned.h>
 
@@ -2276,6 +2278,56 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
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
+	if (!prog)
+		return XDP_PASS;
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
@@ -2285,6 +2337,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 	struct bcmgenet_rx_stats64 *stats = &ring->stats64;
 	struct bcmgenet_priv *priv = ring->priv;
 	struct net_device *dev = priv->dev;
+	struct bpf_prog *xdp_prog;
 	struct enet_cb *cb;
 	struct sk_buff *skb;
 	u32 dma_length_status;
@@ -2295,6 +2348,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 	unsigned int p_index, mask;
 	unsigned int discards;
 
+	xdp_prog = READ_ONCE(priv->xdp_prog);
+
 	/* Clear status before servicing to reduce spurious interrupts */
 	mask = 1 << (UMAC_IRQ1_RX_INTR_SHIFT + ring->index);
 	bcmgenet_intrl2_1_writel(priv, mask, INTRL2_CPU_CLEAR);
@@ -2326,9 +2381,12 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 	       (rxpktprocessed < budget)) {
 		struct status_64 *status;
 		struct page *rx_page;
+		unsigned int xdp_act;
 		unsigned int rx_off;
-		__be16 rx_csum;
+		struct xdp_buff xdp;
+		__be16 rx_csum = 0;
 		void *hard_start;
+		int pkt_len;
 
 		cb = &priv->rx_cbs[ring->read_ptr];
 
@@ -2413,30 +2471,34 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 			goto next;
 		} /* error packet */
 
-		/* Build SKB from the page - data starts at hard_start,
-		 * frame begins after RSB(64) + pad(2) = 66 bytes.
+		pkt_len = len - GENET_RSB_PAD;
+		if (priv->crc_fwd_en)
+			pkt_len -= ETH_FCS_LEN;
+
+		/* Save rx_csum before XDP runs - an XDP program
+		 * could overwrite the RSB via bpf_xdp_adjust_head.
 		 */
-		skb = napi_build_skb(hard_start, PAGE_SIZE - XDP_PACKET_HEADROOM);
-		if (unlikely(!skb)) {
-			BCMGENET_STATS64_INC(stats, dropped);
-			page_pool_put_full_page(ring->page_pool, rx_page,
-						true);
-			goto next;
-		}
+		if (dev->features & NETIF_F_RXCSUM)
+			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
 
-		skb_mark_for_recycle(skb);
+		xdp_init_buff(&xdp, PAGE_SIZE, &ring->xdp_rxq);
+		xdp_prepare_buff(&xdp, page_address(rx_page),
+				 GENET_RX_HEADROOM, pkt_len, true);
 
-		/* Reserve the RSB + pad, then set the data length */
-		skb_reserve(skb, GENET_RSB_PAD);
-		__skb_put(skb, len - GENET_RSB_PAD);
+		xdp_act = bcmgenet_run_xdp(ring, xdp_prog, &xdp, rx_page);
+		if (xdp_act != XDP_PASS)
+			goto next;
 
-		if (priv->crc_fwd_en) {
-			skb_trim(skb, skb->len - ETH_FCS_LEN);
+		skb = bcmgenet_xdp_build_skb(ring, &xdp);
+		if (unlikely(!skb)) {
+			BCMGENET_STATS64_INC(stats, dropped);
+			page_pool_put_full_page(ring->page_pool,
+						rx_page, true);
+			goto next;
 		}
 
 		/* Set up checksum offload */
 		if (dev->features & NETIF_F_RXCSUM) {
-			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
 			if (rx_csum) {
 				skb->csum = (__force __wsum)ntohs(rx_csum);
 				skb->ip_summed = CHECKSUM_COMPLETE;
@@ -3750,6 +3812,37 @@ static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
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
@@ -3761,6 +3854,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_set_features	= bcmgenet_set_features,
 	.ndo_get_stats64	= bcmgenet_get_stats64,
 	.ndo_change_carrier	= bcmgenet_change_carrier,
+	.ndo_bpf		= bcmgenet_xdp,
 };
 
 /* GENET hardware parameters/characteristics */
@@ -4063,6 +4157,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 			 NETIF_F_RXCSUM;
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC;
 
 	netdev_sw_irq_coalesce_default_on(dev);
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index da7b7fee896f..3d65f0e4b4b4 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -16,6 +16,7 @@
 #include <linux/dim.h>
 #include <linux/ethtool.h>
 #include <net/page_pool/helpers.h>
+#include <linux/bpf.h>
 #include <net/xdp.h>
 
 #include "../unimac.h"
@@ -670,6 +671,9 @@ struct bcmgenet_priv {
 	u8 sopass[SOPASS_MAX];
 
 	struct bcmgenet_mib_counters mib;
+
+	/* XDP */
+	struct bpf_prog *xdp_prog;
 };
 
 static inline bool bcmgenet_has_40bits(struct bcmgenet_priv *priv)
-- 
2.51.0


