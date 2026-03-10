Return-Path: <netdev+bounces-266341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNADAKqMsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:27:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F66C25841B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5DAC3201002
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D70C3DA7D4;
	Tue, 10 Mar 2026 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="YjvV6V99"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1C3ED5B1
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177787; cv=none; b=K0988n2BRgJ4j7COROwqMYWUHSvK61cRTOeGrhmpNVMaYXm/2Ea8GDu01oUCdvHmyj63Ro6Qe3DQ0yu9Htzp+91thZPvGJrAsmqhdIaxYInSu8YAynp4JqX7ktYdRwuxpENWaLAnwWpMbTP8SBc4k2jjdVx8nyLZHTcXQ8jYbkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177787; c=relaxed/simple;
	bh=khy8AVx3doiUMrd9qJur7EVK1fQ0F9HwWkPOOL6vd9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfnv8VJ/YM+x9UMpZ1C7KN2f3AGzX9xo0MbDzQhz2iOL+y93iT0MAd9gYFh6/llUlnVkpqK1ZSIRFlju1n4Ry0RWJz+Xg6KyH4YthQRSvL1EmHUJM48xooSl+hbbKn9f6POCTxK+WT5cKmKXGiFsK0ioFkqSbiS2fP4/Ys61WpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=YjvV6V99; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8299c75f730so175391b3a.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773177779; x=1773782579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2067E4shQM8NlUtqVs4AWG5HTqwBiaYCbw4afwwP34A=;
        b=YjvV6V99YjuFpcfGsM5oSSVzylHf3ejAgQRc6c5vRlgy/yjw3YZ/xy31iejF6vfqzH
         kIjszrLxZqf3x2WCseTpB1d1oxKB6qnF7kKH9llucezKc6jsXkwKi+AYFShnYenYcqik
         EoTiO1YdEfyoDosMptTNLZuN2mYKHAIawio2KlwQTl8eP+O7bB2AEi4+oSI2ZWzAPt44
         WFbXZjvT+hML0KtH8a2gAOEne1EmnBn59fGY8i418SfwdFGGpfJtUEPwdP8DAu+RcJdc
         GpLDNmkkUo13QjYi95WwaNuLCqFKyQ9v0/5sWyRSbPKU6uXDnphM8lvGIBTV6IQncQmc
         ubug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177779; x=1773782579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2067E4shQM8NlUtqVs4AWG5HTqwBiaYCbw4afwwP34A=;
        b=rqEPID+upQWw/zQQagykChvINYfhY/k/0wk3f1waCQlCO1KINYkR+vlDWgV/ZDEwFi
         mH86o3/skvyja9wvMxk7HYJh2p3A1SmMZ5AuOxH4tlsEvVHDlxeoI5zhGHTf+6f6epPH
         5jVN5Fa2IiQxHS0ND72gtPtLqyU7eLP+sPL4kY6UEw5vliiAzdQv/UbJnzZFXJkV7nQb
         7VGl0ci1+OOq78hiVL3UJwWyVIbfsTqsg5XlVrE9ipcoNAYSJY/Ps9Z/6/ktIXE6uxJ8
         J0KTARvLMtqjP8cYqUqBf0yP2H4CzydsrihL/cyt9mKYgFDGl/HYXPcgp4ns7efTOLmF
         AelQ==
X-Gm-Message-State: AOJu0YyyU5xl+NBsRuBlG3X5PuzI49PmjWC4bprhMOwuXSdFcEXVpoCF
	dUrr3d6Mj2OEb+MTww7+8iCozQnvH6oeBdLmSMTVJEG5zJ4xMzzSIEReEzpnE0v01FDmZ5XDWma
	aRb8yq4E=
X-Gm-Gg: ATEYQzyp/IDx+h6n3F1FuGN4BBjdLeE3yIar4eVqCGNjXKyBVojl/mNUCLreUEYMlSI
	eId+Lp/dME3tap0caFEO6goEkv/J5zRw8RkGc7IeNgVW2YIbz4hGfdtFO69lNY46tGnkez2Qx8W
	eMPTBivPLPrFpNxvBZqiBl0mEhoNwDJk7uH7H2mV0s+DE6H8OBGe0uMwRNUyyASUnaOHxAdLeAc
	8h7cQELt/jwE8xWvaNWHBrLc3mDQ6hqMHyCcgMgEW6/PPh9mEJSaijZ2yL82gm3prJITm5Yf3sV
	5ZRKKVPb3Y9QCQIQbnMXHTVKIp5dB9RQBCdBOJj5tbXUWLk19++AB8XyM94r1XPKnPFq7fqrn5r
	q7poHMmjMPEue40CHJzuKIhUJb98AFvGpY/VsfSY+NkuoKO/rjBCxe6KZFFzcHCp2e7P/H44wM6
	7pQ2tL
X-Received: by 2002:a05:6a00:1826:b0:818:1e8c:a513 with SMTP id d2e1a72fcca58-829f7ab62c1mr127271b3a.17.1773177778635;
        Tue, 10 Mar 2026 14:22:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f703a7casm184936b3a.59.2026.03.10.14.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:22:58 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next 09/10] net: bnxt: Add SW GSO completion and teardown support
Date: Tue, 10 Mar 2026 14:21:57 -0700
Message-ID: <20260310212209.2263939-10-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310212209.2263939-1-joe@dama.to>
References: <20260310212209.2263939-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F66C25841B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-266341-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dama-to.20230601.gappssmtp.com:dkim,dama.to:mid,dama.to:email]
X-Rspamd-Action: no action

Update __bnxt_tx_int and bnxt_free_one_tx_ring_skbs to handle SW GSO
segments:

- MID segments: adjust tx_pkts/tx_bytes accounting and skip skb free
  (the skb is shared across all segments and freed only once)

- LAST segments: no special cleanup needed -- payload DMA unmapping is
  handled by the existing per-BD dma_unmap_len walk, and the header
  inline buffer is pre-allocated per-ring (freed at ring teardown)

sw_gso is initialized to zero, so the new code paths are not run.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 63 ++++++++++++++++---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 +++++-
 2 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 906e842d9c53..47dc98479066 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -74,6 +74,8 @@
 #include "bnxt_debugfs.h"
 #include "bnxt_coredump.h"
 #include "bnxt_hwmon.h"
+#include "bnxt_gso.h"
+#include <net/tso.h>
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -818,12 +820,13 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	bool rc = false;
 
 	while (RING_TX(bp, cons) != hw_cons) {
-		struct bnxt_sw_tx_bd *tx_buf;
+		struct bnxt_sw_tx_bd *tx_buf, *head_buf;
 		struct sk_buff *skb;
 		bool is_ts_pkt;
 		int j, last;
 
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
+		head_buf = tx_buf;
 		skb = tx_buf->skb;
 
 		if (unlikely(!skb)) {
@@ -870,6 +873,14 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 							    DMA_TO_DEVICE, 0);
 			}
 		}
+		if (unlikely(head_buf->is_sw_gso)) {
+			if (head_buf->is_sw_gso == BNXT_SW_GSO_MID) {
+				tx_pkts--;
+				tx_bytes -= skb->len;
+				skb = NULL;
+			}
+			head_buf->is_sw_gso = 0;
+		}
 		if (unlikely(is_ts_pkt)) {
 			if (BNXT_CHIP_P5(bp)) {
 				/* PTP worker takes ownership of the skb */
@@ -3417,6 +3428,7 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 
 	for (i = 0; i < max_idx;) {
 		struct bnxt_sw_tx_bd *tx_buf = &txr->tx_buf_ring[i];
+		struct bnxt_sw_tx_bd *head_buf = tx_buf;
 		struct sk_buff *skb;
 		int j, last;
 
@@ -3467,7 +3479,10 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 									  len),
 							    DMA_TO_DEVICE, 0);
 		}
-		dev_kfree_skb(skb);
+		if (head_buf->is_sw_gso == BNXT_SW_GSO_MID)
+			skb = NULL;
+		if (skb)
+			dev_kfree_skb(skb);
 	}
 	netdev_tx_reset_queue(netdev_get_tx_queue(bp->dev, idx));
 }
@@ -3975,9 +3990,9 @@ static void bnxt_free_tx_inline_buf(struct bnxt_tx_ring_info *txr,
 	txr->tx_inline_size = 0;
 }
 
-static int __maybe_unused bnxt_alloc_tx_inline_buf(struct bnxt_tx_ring_info *txr,
-						   struct pci_dev *pdev,
-						   unsigned int size)
+static int bnxt_alloc_tx_inline_buf(struct bnxt_tx_ring_info *txr,
+				    struct pci_dev *pdev,
+				    unsigned int size)
 {
 	txr->tx_inline_buf = kmalloc(size, GFP_KERNEL);
 	if (!txr->tx_inline_buf)
@@ -4080,6 +4095,14 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
 				sizeof(struct tx_push_bd);
 			txr->data_mapping = cpu_to_le64(mapping);
 		}
+		if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+		    (bp->dev->features & NETIF_F_GSO_UDP_L4)) {
+			rc = bnxt_alloc_tx_inline_buf(txr, pdev,
+						      BNXT_SW_USO_MAX_SEGS *
+						      TSO_HEADER_SIZE);
+			if (rc)
+				return rc;
+		}
 		qidx = bp->tc_to_qidx[j];
 		ring->queue_id = bp->q_info[qidx].queue_id;
 		spin_lock_init(&txr->xdp_tx_lock);
@@ -4611,6 +4634,10 @@ static int bnxt_init_tx_rings(struct bnxt *bp)
 
 	bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
 				   BNXT_MIN_TX_DESC_CNT);
+	if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    (bp->dev->features & NETIF_F_GSO_UDP_L4))
+		bp->tx_wake_thresh = max_t(int, bp->tx_wake_thresh,
+					   BNXT_SW_USO_MAX_DESCS);
 
 	for (i = 0; i < bp->tx_nr_rings; i++) {
 		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
@@ -13778,6 +13805,11 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 	if ((features & NETIF_F_NTUPLE) && !bnxt_rfs_capable(bp, false))
 		features &= ~NETIF_F_NTUPLE;
 
+	if ((features & NETIF_F_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    bp->tx_ring_size < 2 * BNXT_SW_USO_MAX_DESCS)
+		features &= ~NETIF_F_GSO_UDP_L4;
+
 	if ((bp->flags & BNXT_FLAG_NO_AGG_RINGS) || bp->xdp_prog)
 		features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
 
@@ -13823,6 +13855,15 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
 	int rc = 0;
 	bool re_init = false;
 
+	if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
+		if (features & NETIF_F_GSO_UDP_L4)
+			bp->tx_wake_thresh = max_t(int, bp->tx_wake_thresh,
+						   BNXT_SW_USO_MAX_DESCS);
+		else
+			bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
+						   BNXT_MIN_TX_DESC_CNT);
+	}
+
 	flags &= ~BNXT_FLAG_ALL_CONFIG_FEATS;
 	if (features & NETIF_F_GRO_HW)
 		flags |= BNXT_FLAG_GRO;
@@ -16803,8 +16844,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			   NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_GSO_GRE_CSUM |
 			   NETIF_F_GSO_PARTIAL | NETIF_F_RXHASH |
 			   NETIF_F_RXCSUM | NETIF_F_GRO;
-	if (bp->flags & BNXT_FLAG_UDP_GSO_CAP)
-		dev->hw_features |= NETIF_F_GSO_UDP_L4;
+	dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
 	if (BNXT_SUPPORTS_TPA(bp))
 		dev->hw_features |= NETIF_F_LRO;
@@ -16837,8 +16877,15 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->priv_flags |= IFF_UNICAST_FLT;
 
 	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
-	if (bp->tso_max_segs)
+	if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
+		u16 max_segs = BNXT_SW_USO_MAX_SEGS;
+
+		if (bp->tso_max_segs)
+			max_segs = min_t(u16, max_segs, bp->tso_max_segs);
+		netif_set_tso_max_segs(dev, max_segs);
+	} else if (bp->tso_max_segs) {
 		netif_set_tso_max_segs(dev, bp->tso_max_segs);
+	}
 
 	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			    NETDEV_XDP_ACT_RX_SG;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 3ce092bc8bba..50a4736f512a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -33,6 +33,7 @@
 #include "bnxt_xdp.h"
 #include "bnxt_ptp.h"
 #include "bnxt_ethtool.h"
+#include "bnxt_gso.h"
 #include "bnxt_nvm_defs.h"	/* NVRAM content constant and structure defs */
 #include "bnxt_fw_hdr.h"	/* Firmware hdr constant and structure defs */
 #include "bnxt_coredump.h"
@@ -846,12 +847,18 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	u8 tcp_data_split = kernel_ering->tcp_data_split;
 	struct bnxt *bp = netdev_priv(dev);
 	u8 hds_config_mod;
+	int rc;
 
 	if ((ering->rx_pending > BNXT_MAX_RX_DESC_CNT) ||
 	    (ering->tx_pending > BNXT_MAX_TX_DESC_CNT) ||
 	    (ering->tx_pending < BNXT_MIN_TX_DESC_CNT))
 		return -EINVAL;
 
+	if ((dev->features & NETIF_F_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    ering->tx_pending < 2 * BNXT_SW_USO_MAX_DESCS)
+		return -EINVAL;
+
 	hds_config_mod = tcp_data_split != dev->cfg->hds_config;
 	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED && hds_config_mod)
 		return -EINVAL;
@@ -876,9 +883,17 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	bp->tx_ring_size = ering->tx_pending;
 	bnxt_set_ring_params(bp);
 
-	if (netif_running(dev))
-		return bnxt_open_nic(bp, false, false);
+	if (netif_running(dev)) {
+		rc = bnxt_open_nic(bp, false, false);
+		if (rc)
+			return rc;
+	}
 
+	/* ring size changes may affect features (SW USO requires a minimum
+	 * ring size), so recalculate features to ensure the correct features
+	 * are blocked/available.
+	 */
+	netdev_update_features(dev);
 	return 0;
 }
 
-- 
2.52.0


