Return-Path: <netdev+bounces-276194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADbvKhiA1Wn36wcAu9opvQ
	(envelope-from <netdev+bounces-276194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:07:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1239F3B538C
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0C26308CD8E
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 22:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07781386C3A;
	Tue,  7 Apr 2026 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="jFnpD/d0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DBA37F8CA
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599421; cv=none; b=KWJIR2A9JIKWrRifauSNdhXp9rI7dHayD3GnEzPj4HfdAPADjwozcgdevt+n3+TGf6IUJ/+EBHVcIwb938Sy4noXuGQxLpOjVLHWOawBnEZFb/2f3ttypawPp3NwUx2yrIRfjEu9FlGU5ETqB85zWSH85PgGp+1uEJ8GqMfMV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599421; c=relaxed/simple;
	bh=HYlvd4hdkKKiXCo5HphlpZZZNWfu5yEtf/3fSFF+HlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpsPcLTMwMYTqRaXf+zAuPIthcqsstECHN4D+oazpNYl3irrkMY9KkSeJWLVpwahAyKDZ/ji9N9OIQuqrN1ERe733y8wOanS742X8x+9wUUq3G0gm16j0GIAHo/2gRaHqr9rRiDP6XTV3Ek6Win89MI7XVkm3hCkibURnLUI89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=jFnpD/d0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a9296b3926so31613755ad.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 15:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775599419; x=1776204219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Qw+qkEZgXflo58O5g+5pEjkieZdH1X7wxaS+/Ig/Ls=;
        b=jFnpD/d0eBgEV8JX7EwxoSSzRhI4TaXgyZ+l9n7Qg/fako059vvnDJuQ8n6OJahULr
         9CbZgqGO//mJRtl5BgPjguagu2AyrJ8CF4oKjU7KgR1S2ktWynXqFyVGNOXmMFjvTCWl
         KqIa4UivMKDAJNDNHuRh6X1/2J4ZOoLFKWVuzHSWNsTfPl7IAgZJ102zPBLXCXovQaVZ
         lKhJPXEd00C022tlZroT+AKKjwciX8fFhlHvx3dy+fv9EJ5C21bfj54OSUR5RKPSOFGv
         PgynRyQcK8bwFH357yc7cmmcEr/1xz+vHwMkUNJEBa8KTmL8bsSsZLroHplSK0il4kzq
         8cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599419; x=1776204219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Qw+qkEZgXflo58O5g+5pEjkieZdH1X7wxaS+/Ig/Ls=;
        b=XnTftKC3vmQnzWfy1YgELf/KU7lZJ1U9+xQE77Ifd7baawSBqKHBoSbAi0PsNhLCuv
         XimjauyA9ajyQR8Gl5+wnpS+nsH8qE+uU/gYOWt/pBvdBrKRbkHWPhh+02DiXkuyTbO+
         LIzt8HBPGJkJFHV9ZTulQnkvZftY8xLpSDkGwGRBCWzIPg60IYusPb1ZMQxZGraHLERx
         XRGnM6FMY1XiA6oeow79Fwz4wgyO2sQFkxNmK12peARgy6mEKEwJ1Sp+FtgvTZfQ3ZFh
         /5IeyhuTZ1aLXBiPh/R4wwSf1KGLy3VLI3t21IqPFNm2CqAfG+2Gn53ekXmYh0VmM4zq
         4PkQ==
X-Gm-Message-State: AOJu0YwBJgdzBu/jGvsj7LUYGcsZXduxaIMtBJDauTRBaShIO/c5pwqP
	9wZ75JHrmMIy4C6z45qF0qo831dJYJ5Ewjb10Xx3gB4en/ZJm0WkmHNnp1M5JzcENtMi/MR4DaZ
	cXcgmj2s=
X-Gm-Gg: AeBDietVoWO8YrIPoqb3CZJSb+br/nHjrKHRVq+oX4EV3B0vCE1IEK/Z1GeSOmCeWdF
	nEttFkYP4zWdaNsqTTsJqNid34S0wAPoq9yMYEvHGpZWeOFV4B8TWVF6/oNK4qhE5T9bHb5r/Lh
	3VVNa+gJIOE5DHVSqKmDJcQyFrIPK2vXi+8YXXZr4mZCvO1rDgN3Q++ixYL8Ix3RZuHZtIMyjf+
	xpZTRPNsmGX3na3Bo9ANxSm2nJXdSJPkB3ohJAhcdE5SGHKIs4Y7RGdNkfnPU6pqiqUUMZ4jFhW
	QqTdbUvsWQCCtJ8bL1qAAgvpQVZCCegIT7vOjY3YdCuTqZol7HQN8BPfSLSDJX99db1dzoAaSSy
	X687HFGlRc2esogHkQWpT2e8oeryR1ohh5vICympS17QO/s7MC1PqMj8VWL7vzM8ibxrdWIT2LD
	5tuyrO
X-Received: by 2002:a17:902:c409:b0:2b0:b290:f2f4 with SMTP id d9443c01a7336-2b2818e31femr206668765ad.32.1775599419175;
        Tue, 07 Apr 2026 15:03:39 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d618sm175379465ad.12.2026.04.07.15.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:03:38 -0700 (PDT)
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
Subject: [net-next v9 08/10] net: bnxt: Add SW GSO completion and teardown support
Date: Tue,  7 Apr 2026 15:03:04 -0700
Message-ID: <20260407220313.3990909-9-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407220313.3990909-1-joe@dama.to>
References: <20260407220313.3990909-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-276194-lists,netdev=lfdr.de];
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
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 1239F3B538C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update __bnxt_tx_int and bnxt_free_one_tx_ring_skbs to handle SW GSO
segments:

- MID segments: adjust tx_pkts/tx_bytes accounting and skip skb free
  (the skb is shared across all segments and freed only once)

- LAST segments: call tso_dma_map_complete() to tear down the IOVA
  mapping if one was used. On the fallback path, payload DMA unmapping
  is handled by the existing per-BD dma_unmap_len walk.

Both MID and LAST completions advance tx_inline_cons to release the
segment's inline header slot back to the ring.

is_sw_gso is initialized to zero, so the new code paths are not run.

Add logic for feature advertisement and guardrails for ring sizing.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v9:
   - Always allocate header buffer for non-HW-USO NICs. Avoids a possible
     NULL deref if USO is toggled off and the device is brought down, up,
     and USO is re-enabled (suggested by AI).
   - Adjust bnxt_min_tx_desc_cnt to take a feature parameter. This is needed
     to prevent stale features from being examined (suggested by AI).

 v7:
   - Dropped Pavan's Reviewed-by because some changes were made.
   - Added helper bnxt_min_tx_desc_cnt to avoid repeated code computing
     descriptor counts.
   - Updated to use tso_dma_map_complete helper instead of calling the DMA
     IOVA API directly.

 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 v3:
   - completion paths updated to use DMA IOVA APIs to teardown mappings.

 rfcv2:
   - Update the shared header buffer consumer on TX completion.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 70 ++++++++++++++++---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 ++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |  9 +++
 3 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 74968ca1f4e2..73e692ae2253 100644
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
@@ -869,6 +872,20 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 							    DMA_TO_DEVICE, 0);
 			}
 		}
+
+		if (unlikely(head_buf->is_sw_gso)) {
+			txr->tx_inline_cons++;
+			if (head_buf->is_sw_gso == BNXT_SW_GSO_LAST) {
+				tso_dma_map_complete(&pdev->dev,
+						     &head_buf->sw_gso_cstate);
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
@@ -3412,6 +3429,7 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 
 	for (i = 0; i < max_idx;) {
 		struct bnxt_sw_tx_bd *tx_buf = &txr->tx_buf_ring[i];
+		struct bnxt_sw_tx_bd *head_buf = tx_buf;
 		struct sk_buff *skb;
 		int j, last;
 
@@ -3464,7 +3482,17 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 							    DMA_TO_DEVICE, 0);
 			}
 		}
-		dev_kfree_skb(skb);
+		if (head_buf->is_sw_gso) {
+			txr->tx_inline_cons++;
+			if (head_buf->is_sw_gso == BNXT_SW_GSO_LAST) {
+				tso_dma_map_complete(&pdev->dev,
+						     &head_buf->sw_gso_cstate);
+			} else {
+				skb = NULL;
+			}
+		}
+		if (skb)
+			dev_kfree_skb(skb);
 	}
 	netdev_tx_reset_queue(netdev_get_tx_queue(bp->dev, idx));
 }
@@ -3990,9 +4018,9 @@ static void bnxt_free_tx_inline_buf(struct bnxt_tx_ring_info *txr,
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
@@ -4095,6 +4123,13 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
 				sizeof(struct tx_push_bd);
 			txr->data_mapping = cpu_to_le64(mapping);
 		}
+		if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
+			rc = bnxt_alloc_tx_inline_buf(txr, pdev,
+						      BNXT_SW_USO_MAX_SEGS *
+						      TSO_HEADER_SIZE);
+			if (rc)
+				return rc;
+		}
 		qidx = bp->tc_to_qidx[j];
 		ring->queue_id = bp->q_info[qidx].queue_id;
 		spin_lock_init(&txr->xdp_tx_lock);
@@ -4633,10 +4668,13 @@ static int bnxt_init_rx_rings(struct bnxt *bp)
 
 static int bnxt_init_tx_rings(struct bnxt *bp)
 {
+	netdev_features_t features;
 	u16 i;
 
+	features = bp->dev->features;
+
 	bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
-				   BNXT_MIN_TX_DESC_CNT);
+				   bnxt_min_tx_desc_cnt(bp, features));
 
 	for (i = 0; i < bp->tx_nr_rings; i++) {
 		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
@@ -13835,6 +13873,11 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 	if ((features & NETIF_F_NTUPLE) && !bnxt_rfs_capable(bp, false))
 		features &= ~NETIF_F_NTUPLE;
 
+	if ((features & NETIF_F_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    bp->tx_ring_size < 2 * BNXT_SW_USO_MAX_DESCS)
+		features &= ~NETIF_F_GSO_UDP_L4;
+
 	if ((bp->flags & BNXT_FLAG_NO_AGG_RINGS) || bp->xdp_prog)
 		features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
 
@@ -13880,6 +13923,9 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
 	int rc = 0;
 	bool re_init = false;
 
+	bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
+				   bnxt_min_tx_desc_cnt(bp, features));
+
 	flags &= ~BNXT_FLAG_ALL_CONFIG_FEATS;
 	if (features & NETIF_F_GRO_HW)
 		flags |= BNXT_FLAG_GRO;
@@ -16905,8 +16951,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			   NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_GSO_GRE_CSUM |
 			   NETIF_F_GSO_PARTIAL | NETIF_F_RXHASH |
 			   NETIF_F_RXCSUM | NETIF_F_GRO;
-	if (bp->flags & BNXT_FLAG_UDP_GSO_CAP)
-		dev->hw_features |= NETIF_F_GSO_UDP_L4;
+	dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
 	if (BNXT_SUPPORTS_TPA(bp))
 		dev->hw_features |= NETIF_F_LRO;
@@ -16939,8 +16984,15 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
index 6826bf762d26..9ded88196bb4 100644
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
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
index f01e8102dcd7..3bee626a6303 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
@@ -23,6 +23,15 @@
  */
 #define BNXT_SW_USO_MAX_DESCS	(3 * BNXT_SW_USO_MAX_SEGS + MAX_SKB_FRAGS + 1)
 
+static inline int bnxt_min_tx_desc_cnt(struct bnxt *bp,
+				       netdev_features_t features)
+{
+	if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    (features & NETIF_F_GSO_UDP_L4))
+		return BNXT_SW_USO_MAX_DESCS;
+	return BNXT_MIN_TX_DESC_CNT;
+}
+
 netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 				 struct bnxt_tx_ring_info *txr,
 				 struct netdev_queue *txq,
-- 
2.52.0


