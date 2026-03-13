Return-Path: <netdev+bounces-267345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIYBE3DXs2mzbgAAu9opvQ
	(envelope-from <netdev+bounces-267345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:22:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD48F28067E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00097317A380
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219593859F3;
	Fri, 13 Mar 2026 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="oan2ZMwe"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52094305E3B;
	Fri, 13 Mar 2026 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393690; cv=none; b=Fu8VFhQxyk7G0E/nN9B0srpUVd1dVDm9uJqbwuF82Z4oUV4E4jnWUPZdHorraa0768acfQ72GhwOX61lBqCEvb1Gkrco3e09mzK2UYDF/pkoMJOu0PlaN+CBO2aNfILygaUMUbzh++ZyTvVfSsXYcGIKeLwbaQDAyfFHFdu2qJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393690; c=relaxed/simple;
	bh=MbnJQdSNcFqOWql5mRLiNxcRZbqDnDIjGYtTvtNHtic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJbngFn2u9IPF3/Cx2VCv69EGuYeJJklqPDVfoZ2/vvkdG920rtAY7tXcqLGxahuT4cS90ra2onMIlXlKWJ1eDJx0lV1OmJgaSWckSi3xO6Em0GhoPQwDxrfCFJoDn6knwD1Wc42aOClt6epMhkDLTmu1H03BuQqnGA3oCOzWsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=oan2ZMwe; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB77EA5703;
	Fri, 13 Mar 2026 10:21:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773393681; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=fKVAA6EH0rNf/n0LrOeoSx0T22QsKnVt3p/nUXBzg5A=;
	b=oan2ZMweOwy3VeCZpaoP4ytIGyzxcQWcmrFoUpHbr0zVodT8TpvOs5xPbfyV6AoitQCc29
	kxH+GQHwjoq6a5NH8XP/Ht3ja+Roer0gyR3yQhDFwsEZPHA0hmwG1LxSe1ieK6Yz63NXd+
	q8UbXKUe+0vqudk6LxEoKsSc9Nm/sVjInrCoOt9FMlEsv90Jd/SCXhZP6SdY8cwwUJrXpm
	Xk/zGFfUivLqcP8t3C+TgXEmS21J9OlnxTpFN4yViKzHKZA9W5Xv4Oi5Gk3d7I/qsB0N6c
	BuxGwC+9z5EoLU4mT+W9ioINWhAoDg8Jfbp/oHPAzLI2mhBFxlm0OK/3kkDQRw==
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
Subject: [PATCH net-next 3/6] net: bcmgenet: add basic XDP support (PASS/DROP)
Date: Fri, 13 Mar 2026 10:20:58 +0100
Message-ID: <20260313092101.1344954-4-nb@tipi-net.de>
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
	TAGGED_FROM(0.00)[bounces-267345-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Queue-Id: AD48F28067E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add XDP program attachment via ndo_bpf and execute XDP programs in the
RX path. Supported actions:

  - XDP_PASS: build SKB from the (possibly modified) xdp_buff and pass
    to the network stack, handling xdp_adjust_head/tail correctly
  - XDP_DROP: return the page to page_pool, no SKB allocated
  - XDP_ABORTED: same as DROP with trace_xdp_exception

XDP_TX and XDP_REDIRECT are not yet supported and will return
XDP_ABORTED.

The XDP hook runs after the HW error checks but before SKB construction,
so dropped packets avoid all SKB allocation overhead.

Advertise NETDEV_XDP_ACT_BASIC in xdp_features.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 153 +++++++++++++++---
 .../net/ethernet/broadcom/genet/bcmgenet.h    |   4 +
 2 files changed, 133 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index dd70e5af2b1e..d43729fc2b1b 100644
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
+					      struct xdp_buff *xdp,
+					      struct page *rx_page)
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
+static unsigned int
+bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
+		 struct xdp_buff *xdp, struct page *rx_page)
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
@@ -2345,12 +2397,6 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		hard_start = page_address(rx_page) + rx_off;
 		status = (struct status_64 *)hard_start;
 		dma_length_status = status->length_status;
-		if (dev->features & NETIF_F_RXCSUM) {
-			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
-			if (rx_csum) {
-				/* defer csum setup to after skb is built */
-			}
-		}
 
 		/* DMA flags and length are still valid no matter how
 		 * we got the Receive Status Vector (64B RSB or register)
@@ -2409,26 +2455,52 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
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
+		/* XDP: frame data starts after RSB + pad */
+		if (xdp_prog) {
+			struct xdp_buff xdp;
+			unsigned int xdp_act;
+			int pkt_len;
+
+			pkt_len = len - GENET_RSB_PAD;
+			if (priv->crc_fwd_en)
+				pkt_len -= ETH_FCS_LEN;
+
+			xdp_init_buff(&xdp, PAGE_SIZE, &ring->xdp_rxq);
+			xdp_prepare_buff(&xdp, page_address(rx_page),
+					 GENET_RX_HEADROOM, pkt_len, false);
+
+			xdp_act = bcmgenet_run_xdp(ring, xdp_prog, &xdp,
+						   rx_page);
+			if (xdp_act != XDP_PASS)
+				goto next;
+
+			/* XDP_PASS: build SKB from (possibly modified) xdp */
+			skb = bcmgenet_xdp_build_skb(ring, &xdp, rx_page);
+			if (unlikely(!skb)) {
+				BCMGENET_STATS64_INC(stats, dropped);
+				page_pool_put_full_page(ring->page_pool,
+							rx_page, true);
+				goto next;
+			}
+		} else {
+			/* Build SKB from the page - data starts at
+			 * hard_start, frame begins after RSB(64) + pad(2).
+			 */
+			skb = napi_build_skb(hard_start,
+					     PAGE_SIZE - GENET_XDP_HEADROOM);
+			if (unlikely(!skb)) {
+				BCMGENET_STATS64_INC(stats, dropped);
+				page_pool_put_full_page(ring->page_pool,
+							rx_page, true);
+				goto next;
+			}
 
-		/* Reserve the RSB + pad, then set the data length */
-		skb_reserve(skb, GENET_RSB_PAD);
-		__skb_put(skb, len - GENET_RSB_PAD);
+			skb_mark_for_recycle(skb);
+			skb_reserve(skb, GENET_RSB_PAD);
+			__skb_put(skb, len - GENET_RSB_PAD);
 
-		if (priv->crc_fwd_en) {
-			skb_trim(skb, skb->len - ETH_FCS_LEN);
-			len -= ETH_FCS_LEN;
+			if (priv->crc_fwd_en)
+				skb_trim(skb, skb->len - ETH_FCS_LEN);
 		}
 
 		/* Set up checksum offload */
@@ -3750,6 +3822,37 @@ static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
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
@@ -3761,6 +3864,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_set_features	= bcmgenet_set_features,
 	.ndo_get_stats64	= bcmgenet_get_stats64,
 	.ndo_change_carrier	= bcmgenet_change_carrier,
+	.ndo_bpf		= bcmgenet_xdp,
 };
 
 /* GENET hardware parameters/characteristics */
@@ -4063,6 +4167,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
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


