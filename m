Return-Path: <netdev+bounces-270675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHFOKiaLwWlxTwQAu9opvQ
	(envelope-from <netdev+bounces-270675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:49:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C562FB903
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BF9030ECA39
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7B43D567A;
	Mon, 23 Mar 2026 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="ZscSm5G6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629612E719C
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291163; cv=none; b=mE5Yu+qDuZIMSnVLqtYrH0tepXpCf80UTncC1GIHr/DxOdzn9eHt2wzajgvzlxOH9sAt5NjD4PtTHSdQBoSLbl1cU4bfC69/aGoc7dRo73Tpe6C2jr25GNSeuZAaqOrJy8y3UIR4jI7Dq4XF/N3JprS0v/NnHIbVP6fMqAAJTV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291163; c=relaxed/simple;
	bh=wZ9a+8VFvuKCei1yujXWesCt/iH2GQLrp9nnWViTt/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWw3iEM9hhhSsV2XZ98YZJLVsyEu3JvQ2ZWR7zMnANFJGzDXPE2Xa3cZe/cjrK+KarU/rCD0Ta5LWMTmBFzLb4/z8lw94RuKChfpFG+g5brnikbRhwb8ZKfq9s6q2nl9A2h6TI2yIjeFnKylLGn7j8MgWB/eMLKADZChwJRluFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=ZscSm5G6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso2944040a91.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774291157; x=1774895957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Em/5YOnjyQUn+CPxHAJYhh+fDGfpOSNFFMrZDobsG4A=;
        b=ZscSm5G6tsBmJN9jaXJFLvUI7+Vh/7dpEaTj8vhBcHO9hwoFgRO1/x3kc8qIb2UQuw
         TUxeFT2tNIRDKwGjbdKoLiROZ+TB9nCYpXlshUYKoD4SJkebsunA65lC2TotEmcBgcsd
         qT3uv+q2LLgV2NcHdWjSa7vbBYa4lQIBhAg5bx8yr/qnBMMAZ52U8fZSOFW8+YZCSLX5
         jQ5QV2B6SB/yyYUsbGTZppRiGoIu8szby6V4PZn0Ydr9M7hMP8o9VelJvRrmYRJpW/d8
         LCY9zOJOBDXFcTZ0z0ArNsmB2A8hEmmR1NCoTsoalwmEy4BA1sAkkBa24EcHi52eOAa3
         +Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291157; x=1774895957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Em/5YOnjyQUn+CPxHAJYhh+fDGfpOSNFFMrZDobsG4A=;
        b=KaoP4cqhYNqVZMHhGsjlfT8IhUj12jrUyH1jvX/KoXSIXCyG02cTxInq5ddqLr3z0a
         Govfy6sxYwAAyWfBuSKRn9TXS4JxII/IuRbtVw8dkrlDuilTLcU/jQNkPi+uLzqgdTz1
         c9MbPbaM45/MDaokW8K9fF3uKG/WVpLxFJRSffUcnk+3BLjHGx8C/rFzEr/FiUkNhWFW
         cp0AdgX645ONaeERROvR9OXXuyRCsp4+7gSfLbMr+ovKVc54eBSHbEygLw2C7zFcNG2x
         fUPbM1p7vDHQWt6nkVBuMoT6eoFacG80gAzSatd3ijBkbt/2zk8XQpGm0Afe33iwJbTr
         ulRA==
X-Gm-Message-State: AOJu0YwntYT+82FbNUFjA+QNNfrVc2mT2G0bTW9EZwDKcyl7teAhnTNV
	N0dn9EEgcYXNDaOCr1DdpFgObbF9CaneRCxlAMvXLBOruvPLK9cJRcqC/bdHcjv3H6JP9MTPw3l
	+f7RVbsc=
X-Gm-Gg: ATEYQzwbhn39jFpcQGhvOazT6rjgbPnImJ0vkUxVVoq7DLzPrjZx/4uJPkoYKK04FaN
	wtDw/oJWsLsbG7ppTQK7ngk3vympzOy2qHiGD+gX1UapJfobqJMmgH3LRWlmgEjHvSpfcr7XTK3
	C56Q6lhVLlIioF6tFAVaQkeDcVnldoz7miaULTO2fxAUIklLMp0DzAsmvCliXH/qcE84/uv3vM2
	ASQKdz+YB9ItMbIJ/Jv0A61pqiuvJz/rKssI9dV2Fwg3Ln6U5G1EtAjv6es6dsCgO0Y5+paRDDr
	3jvogEA92mNyVOYrc7UeCWFewGXospynHMPp8qpR/MqoY/qxm9d3ZB8kj/U4TzHhAJK2SOmAS/8
	fNKIkYDvhH0TaIjp0IWdM9g89bXeJ1LsdZxh0yYI23neDsZ5UUvKFZw2bCv51c2trN4cbzAAa5H
	Ls2Zs=
X-Received: by 2002:a17:90b:3d01:b0:359:fe72:3554 with SMTP id 98e67ed59e1d1-35bd2bb09c6mr10868161a91.5.1774291156965;
        Mon, 23 Mar 2026 11:39:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd412b73bsm9711218a91.15.2026.03.23.11.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:39:16 -0700 (PDT)
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
Subject: [net-next v5 09/12] net: bnxt: Add SW GSO completion and teardown support
Date: Mon, 23 Mar 2026 11:38:34 -0700
Message-ID: <20260323183844.3146982-10-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323183844.3146982-1-joe@dama.to>
References: <20260323183844.3146982-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-270675-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,dama.to:email,dama.to:mid,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 39C562FB903
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
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 v3:
   - completion paths updated to use DMA IOVA APIs to teardown mappings.

 rfcv2:
   - Update the shared header buffer consumer on TX completion.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 82 +++++++++++++++++--
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 ++++-
 2 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2759a4e2b148..40a16f96feba 100644
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
@@ -3420,6 +3440,7 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 
 	for (i = 0; i < max_idx;) {
 		struct bnxt_sw_tx_bd *tx_buf = &txr->tx_buf_ring[i];
+		struct bnxt_sw_tx_bd *head_buf = tx_buf;
 		struct sk_buff *skb;
 		int j, last;
 
@@ -3472,7 +3493,20 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
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
@@ -3998,9 +4032,9 @@ static void bnxt_free_tx_inline_buf(struct bnxt_tx_ring_info *txr,
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
@@ -4103,6 +4137,14 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
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
@@ -4645,6 +4687,10 @@ static int bnxt_init_tx_rings(struct bnxt *bp)
 
 	bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
 				   BNXT_MIN_TX_DESC_CNT);
+	if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    (bp->dev->features & NETIF_F_GSO_UDP_L4))
+		bp->tx_wake_thresh = max_t(int, bp->tx_wake_thresh,
+					   BNXT_SW_USO_MAX_DESCS);
 
 	for (i = 0; i < bp->tx_nr_rings; i++) {
 		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
@@ -13833,6 +13879,11 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 	if ((features & NETIF_F_NTUPLE) && !bnxt_rfs_capable(bp, false))
 		features &= ~NETIF_F_NTUPLE;
 
+	if ((features & NETIF_F_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    bp->tx_ring_size < 2 * BNXT_SW_USO_MAX_DESCS)
+		features &= ~NETIF_F_GSO_UDP_L4;
+
 	if ((bp->flags & BNXT_FLAG_NO_AGG_RINGS) || bp->xdp_prog)
 		features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
 
@@ -13878,6 +13929,15 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
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
@@ -16881,8 +16941,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			   NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_GSO_GRE_CSUM |
 			   NETIF_F_GSO_PARTIAL | NETIF_F_RXHASH |
 			   NETIF_F_RXCSUM | NETIF_F_GRO;
-	if (bp->flags & BNXT_FLAG_UDP_GSO_CAP)
-		dev->hw_features |= NETIF_F_GSO_UDP_L4;
+	dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
 	if (BNXT_SUPPORTS_TPA(bp))
 		dev->hw_features |= NETIF_F_LRO;
@@ -16915,8 +16974,15 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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


