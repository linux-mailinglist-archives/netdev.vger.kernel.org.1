Return-Path: <netdev+bounces-269167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL0UG8z5umlwdwIAu9opvQ
	(envelope-from <netdev+bounces-269167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:15:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D418B2C1E26
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80A9B303AF1A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EE53F0AB7;
	Wed, 18 Mar 2026 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="zUmkUYP9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFA73F7AA5
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861238; cv=none; b=ZWRDRNLDeAoEX9ewPjb8FziQ+RqQ9o8+4LuRmBpCcFXL+U6k0XXM/HD3tB7bv/Kyo5WyOGH/7BsOPm7mTZVzH+WOOBoS+elsYx6qmBc+5mwspVztEm5xCB8Otg+MkqNTplx7ZyX33MAhm8Kl9c9szu5CpoMyaHkGHJs3LIdd4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861238; c=relaxed/simple;
	bh=YzKXajmKc0ASt3KsvZpVHQxjsM4waE4u3jEZJ2oRbpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1KuggKUCmROUPVKUbJpROatxzA46YEPC/WJbarGy/8C4NFf9eCPOA/JBIj6YRX9gzFZ7yIOsNsUq3g/b5Egz0pWWSqBsdVQg2/u0Hlxk6NQOYFKeqVXY25gl3SOclDaTsl7Ccpb8b6nbC+tM6OMLbRqoGC3nscpcZsOFg7tT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=zUmkUYP9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35bb9070644so123769a91.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773861232; x=1774466032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE0NX7RG+iFP3hDspYtJNUt8M+6AmihieJBZLfIyPVc=;
        b=zUmkUYP96oRjdjN8nL5VFQI7jjHpqRabhUi/Y6lpJ0F9Cev3YJPc47orxUc5C61N1T
         lFIS9amM9I0hi7rvt2nZwRPnS703I29N1DbagPIT8xYA6K768YMElkl7PDuXMNvvVCWr
         k5w+VaCTarLVqnJPZTrRHJBH4vgmr8i4P+GdOCOY3hgp6ktLX3krYTkIxwY1EGYkBw3d
         5diMLXUNOR7Iz9ft8iF95YwLBJOSuexBMDzL3CBNNsWZ/jtTDVDlCSGspqCx39tljEOH
         JLgT3VowVkMWzjvHUU83j7FoP/s96P1jjTqFbEf8DPKej832DPljRUhrvjn8CRq74+tr
         DehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861232; x=1774466032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AE0NX7RG+iFP3hDspYtJNUt8M+6AmihieJBZLfIyPVc=;
        b=RxlyVx+RDqWQsiZ1Rtrv1nkN/CMDVYs/WqXQecrVv1qnVmm5AjG5EnHNj7idIZoNLt
         uYtOtQyeIT3sY9wwsps02qbCt1bhavGBL52zmCcyJkFIKB7wKadYPSDs+F2YvRxFo1FJ
         wd/ZatfS5IkQQXQsWRDKJd/nE7Vu/SFcDlpnCO7iAQszPbPBTBVeGrU+qrBDfZbVWBPv
         INhhMnH/5egH/nDPb1R8addg1BmSpk7J0pqUGtjPLelciJQ/Ry7710Er8V7ViLGYB7q6
         nAHEr4y8GVNk5uVG6j+xW4SKtYzbm3HCDPcA6BdH6LNwx3lDvRFayZQEKp1M9EpyfNOE
         jXRw==
X-Gm-Message-State: AOJu0YxgJkdBv1QRrSjkxSOf8lovN6MMQ6T6NP05obUpdfdXtqssSI30
	CGOkRGJFb94alcj8irii0fp7N6Nibc4oKpIczFeIPZ77hchAousEVshfOwRHvW+EQCUDYvHcVrc
	+T0Wi6lo=
X-Gm-Gg: ATEYQzxvrWDkWZW3Arxa5B8MZF1zEfZCAUXnrKX7bPxExmftxWTnOWpIEDzxDcwsxJ1
	7HOPCzVaRozfjOI72gIEO+tvRboDfyLeQt2HhNkFiqSaSMA2LuszFE/a8o/esX2u6oU2Iwlj4qT
	9JlSCcWBxHN3AidD2cAVs4mbwpbJ+0mJYwyIBrcR+5WN3VjP/PCq+mWzGyidOrl60Bc9ATXQAaS
	Z69pKHaSbiS4gifb7Q+GJm/kXK+uJii/GLJLyRq42P1zB4WHsrlTyeopeWBuJjwGTON9lyPh+Dy
	3mqrU0tdaFUggnrFcPNKw5AKebvQwGg7AfT1MRnbyUcsUN1n86fJuz7DPj7MJRAro6WfAHuV59W
	hdu/wsd/VhNCvigSq01XEQPrGxsjBLC4H/hGxy17aBjK7gCghq/SShLHJSnPPz2j2llJ4zg6lSL
	vSCbU=
X-Received: by 2002:a17:90b:5346:b0:352:f2a6:334 with SMTP id 98e67ed59e1d1-35bb9ef6093mr3931761a91.16.1773861232354;
        Wed, 18 Mar 2026 12:13:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc63093d9sm324194a91.12.2026.03.18.12.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:13:51 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v3 09/12] net: bnxt: Add SW GSO completion and teardown support
Date: Wed, 18 Mar 2026 12:13:14 -0700
Message-ID: <20260318191325.1819881-10-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318191325.1819881-1-joe@dama.to>
References: <20260318191325.1819881-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269167-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D418B2C1E26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update __bnxt_tx_int and bnxt_free_one_tx_ring_skbs to handle SW GSO
segments:

- MID segments: adjust tx_pkts/tx_bytes accounting and skip skb free
  (the skb is shared across all segments and freed only once)

- LAST segments: if the DMA IOVA path was used, use dma_iova_destroy to
  tear down the contiguous mapping. On the fallback path, payload DMA
  unmapping is handled by the existing per-BD dma_unmap_len walk.

Both MID and LAST completions advance tx_inline_cons to release the
segment's inline header slot back to the ring.

is_sw_gso is initialized to zero, so the new code paths are not run.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v3:
   - completion paths updated to use DMA IOVA APIs to teardown mappings.

 rfcv2:
   - Update the shared header buffer consumer on TX completion.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 82 +++++++++++++++++--
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 ++++-
 2 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8929264a54b1..d9ca4933ee62 100644
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
@@ -817,12 +819,13 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
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
@@ -869,6 +872,23 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 							    DMA_TO_DEVICE, 0);
 			}
 		}
+
+		if (unlikely(head_buf->is_sw_gso)) {
+			txr->tx_inline_cons++;
+			if (head_buf->is_sw_gso == BNXT_SW_GSO_LAST) {
+				if (dma_use_iova(&head_buf->iova_state))
+					dma_iova_destroy(&pdev->dev,
+							 &head_buf->iova_state,
+							 head_buf->iova_total_len,
+							 DMA_TO_DEVICE, 0);
+			} else {
+				tx_pkts--;
+				tx_bytes -= skb->len;
+				skb = NULL;
+			}
+			head_buf->is_sw_gso = 0;
+		}
+
 		if (unlikely(is_ts_pkt)) {
 			if (BNXT_CHIP_P5(bp)) {
 				/* PTP worker takes ownership of the skb */
@@ -3418,6 +3438,7 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 
 	for (i = 0; i < max_idx;) {
 		struct bnxt_sw_tx_bd *tx_buf = &txr->tx_buf_ring[i];
+		struct bnxt_sw_tx_bd *head_buf = tx_buf;
 		struct sk_buff *skb;
 		int j, last;
 
@@ -3470,7 +3491,20 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 							    DMA_TO_DEVICE, 0);
 			}
 		}
-		dev_kfree_skb(skb);
+		if (head_buf->is_sw_gso) {
+			txr->tx_inline_cons++;
+			if (head_buf->is_sw_gso == BNXT_SW_GSO_LAST) {
+				if (dma_use_iova(&head_buf->iova_state))
+					dma_iova_destroy(&pdev->dev,
+							 &head_buf->iova_state,
+							 head_buf->iova_total_len,
+							 DMA_TO_DEVICE, 0);
+			} else {
+				skb = NULL;
+			}
+		}
+		if (skb)
+			dev_kfree_skb(skb);
 	}
 	netdev_tx_reset_queue(netdev_get_tx_queue(bp->dev, idx));
 }
@@ -3996,9 +4030,9 @@ static void bnxt_free_tx_inline_buf(struct bnxt_tx_ring_info *txr,
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
@@ -4101,6 +4135,14 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
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
@@ -4643,6 +4685,10 @@ static int bnxt_init_tx_rings(struct bnxt *bp)
 
 	bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
 				   BNXT_MIN_TX_DESC_CNT);
+	if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    (bp->dev->features & NETIF_F_GSO_UDP_L4))
+		bp->tx_wake_thresh = max_t(int, bp->tx_wake_thresh,
+					   BNXT_SW_USO_MAX_DESCS);
 
 	for (i = 0; i < bp->tx_nr_rings; i++) {
 		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
@@ -13831,6 +13877,11 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 	if ((features & NETIF_F_NTUPLE) && !bnxt_rfs_capable(bp, false))
 		features &= ~NETIF_F_NTUPLE;
 
+	if ((features & NETIF_F_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    bp->tx_ring_size < 2 * BNXT_SW_USO_MAX_DESCS)
+		features &= ~NETIF_F_GSO_UDP_L4;
+
 	if ((bp->flags & BNXT_FLAG_NO_AGG_RINGS) || bp->xdp_prog)
 		features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
 
@@ -13876,6 +13927,15 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
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
@@ -16879,8 +16939,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			   NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_GSO_GRE_CSUM |
 			   NETIF_F_GSO_PARTIAL | NETIF_F_RXHASH |
 			   NETIF_F_RXCSUM | NETIF_F_GRO;
-	if (bp->flags & BNXT_FLAG_UDP_GSO_CAP)
-		dev->hw_features |= NETIF_F_GSO_UDP_L4;
+	dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
 	if (BNXT_SUPPORTS_TPA(bp))
 		dev->hw_features |= NETIF_F_LRO;
@@ -16913,8 +16972,15 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
index 48e8e3be70d3..44b3fd18fcbe 100644
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
@@ -852,12 +853,18 @@ static int bnxt_set_ringparam(struct net_device *dev,
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
@@ -882,9 +889,17 @@ static int bnxt_set_ringparam(struct net_device *dev,
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


