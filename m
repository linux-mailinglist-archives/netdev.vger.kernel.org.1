Return-Path: <netdev+bounces-158939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88721A13DE9
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71FD18899AC
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2309E22BAB3;
	Thu, 16 Jan 2025 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tw8mU5iV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19422B8CF
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041960; cv=none; b=H6X9gUJKQuuorg9wTi7vGqD1DRihtZNm+KhEL+yz6RepMhd7rP9q6UpctHtpgtsBc8peYwH5xfTWJuKRYCVeknpqpWkavdPUyt3JdnpVeJF7ameFgR2VJQqWWIUU/zO88q3BN4TTcaaAR6el+gL06t12+TwEZgb+JXtASURuPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041960; c=relaxed/simple;
	bh=3GmVLuxxbi4g4T09/bkQN4mvHiaxWCcvhJcBG+vRRew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lm9qKm0p5uTxyAta0Q3Nv4sAQx7gtBctrWHPe8Gq33ZdWQtItZjGgd0UfHKqRaK1IPdyGRtzHLkn83njMV468i45UiwRDXd4f7dFPPhIqzOq9AHOyuEOvqDEZSLwcynCrZ8Xxg8JkuvvCTeUcvet4Wq9biJicFXIjTBGBlf6ZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tw8mU5iV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737041958; x=1768577958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3GmVLuxxbi4g4T09/bkQN4mvHiaxWCcvhJcBG+vRRew=;
  b=Tw8mU5iVfCm0cmYtWbK/eS8vwf71ZL/EZyvVrdWf3e92fvqPnZX2pZla
   H6Qdh69JfrOr2WArwQLNr+s+sj+pHFb6lbKglA2Meg7QzJONKFcN46HYm
   eo+6XUiSfx6a9pLwIHfQNp8UOl/nx4tdk4Z2UxUrYJZv+jswUiSvigXnU
   DROOOUiRE1vcA6Rt1czyHYY9FsuXNP3cZnBd50bIopL2F9TBYzwdkbpDy
   WOzCPA3jCaZgQ2/7gotQ2JLQUlrsxQsPjqlCApV9kyOLo3SzAofOqwKVx
   pyGoEC7R97XpoUBPTjx7IdaZwRxhlyojazn1/4nR7YIiz3XtlxOBv0mxN
   A==;
X-CSE-ConnectionGUID: ALKIKNykSfyOxzFZhbS7iA==
X-CSE-MsgGUID: QuPgKLkESfaJiSirjT0qpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="25037416"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="25037416"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:39:18 -0800
X-CSE-ConnectionGUID: tiwiIcBIRLOhoktUrbM2/A==
X-CSE-MsgGUID: am+qa0LqRaWB0JzwaPvm8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="110540992"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa004.jf.intel.com with ESMTP; 16 Jan 2025 07:39:15 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	jacob.e.keller@intel.com,
	xudu@redhat.com,
	mschmidt@redhat.com,
	jmaxwell@redhat.com,
	poros@redhat.com,
	przemyslaw.kitszel@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH intel-net 1/3] ice: put Rx buffers after being done with current frame
Date: Thu, 16 Jan 2025 16:39:06 +0100
Message-Id: <20250116153908.515848-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250116153908.515848-1-maciej.fijalkowski@intel.com>
References: <20250116153908.515848-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new helper ice_put_rx_mbuf() that will go through gathered
frags from current frame and will call ice_put_rx_buf() on them. Current
logic that was supposed to simplify and optimize the driver where we go
through a batch of all buffers processed in current NAPI instance turned
out to be broken for jumbo frames and very heavy load that was coming
from both multi-thread iperf and nginx/wrk pair between server and
client. The delay introduced by approach that we are dropping is simply
too big and we need to take the decision regarding page
recycling/releasing as quick as we can.

While at it, address an error path of ice_add_xdp_frag() - we were
missing buffer putting from day 1 there.

As a nice side effect we get rid of annoying and repetetive three-liner:

	xdp->data = NULL;
	rx_ring->first_desc = ntc;
	rx_ring->nr_frags = 0;

by embedding it within introduced routine.

Fixes: 1dc1a7e7f410 ("ice: Centrallize Rx buffer recycling")
Reported-and-tested-by: Xu Du <xudu@redhat.com>
Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 67 +++++++++++++----------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 5d2d7736fd5f..501df1bc881d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1103,6 +1103,37 @@ ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf)
 	rx_buf->page = NULL;
 }
 
+static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
+			    u32 *xdp_xmit)
+{
+	u32 nr_frags = rx_ring->nr_frags + 1;
+	u32 idx = rx_ring->first_desc;
+	u32 cnt = rx_ring->count;
+	struct ice_rx_buf *buf;
+
+	for (int i = 0; i < nr_frags; i++) {
+		buf = &rx_ring->rx_buf[idx];
+
+		if (buf->act & (ICE_XDP_TX | ICE_XDP_REDIR)) {
+			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
+			*xdp_xmit |= buf->act;
+		} else if (buf->act & ICE_XDP_CONSUMED) {
+			buf->pagecnt_bias++;
+		} else if (buf->act == ICE_XDP_PASS) {
+			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
+		}
+
+		ice_put_rx_buf(rx_ring, buf);
+
+		if (++idx == cnt)
+			idx = 0;
+	}
+
+	xdp->data = NULL;
+	rx_ring->first_desc = ntc;
+	rx_ring->nr_frags = 0;
+}
+
 /**
  * ice_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
  * @rx_ring: Rx descriptor ring to transact packets on
@@ -1120,7 +1151,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 	unsigned int total_rx_bytes = 0, total_rx_pkts = 0;
 	unsigned int offset = rx_ring->rx_offset;
 	struct xdp_buff *xdp = &rx_ring->xdp;
-	u32 cached_ntc = rx_ring->first_desc;
 	struct ice_tx_ring *xdp_ring = NULL;
 	struct bpf_prog *xdp_prog = NULL;
 	u32 ntc = rx_ring->next_to_clean;
@@ -1128,7 +1158,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 	u32 xdp_xmit = 0;
 	u32 cached_ntu;
 	bool failure;
-	u32 first;
 
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	if (xdp_prog) {
@@ -1190,6 +1219,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
 			xdp_buff_clear_frags_flag(xdp);
 		} else if (ice_add_xdp_frag(rx_ring, xdp, rx_buf, size)) {
+			ice_put_rx_mbuf(rx_ring, xdp, NULL);
 			break;
 		}
 		if (++ntc == cnt)
@@ -1205,9 +1235,8 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		total_rx_bytes += xdp_get_buff_len(xdp);
 		total_rx_pkts++;
 
-		xdp->data = NULL;
-		rx_ring->first_desc = ntc;
-		rx_ring->nr_frags = 0;
+		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit);
+
 		continue;
 construct_skb:
 		if (likely(ice_ring_uses_build_skb(rx_ring)))
@@ -1221,14 +1250,11 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			if (unlikely(xdp_buff_has_frags(xdp)))
 				ice_set_rx_bufs_act(xdp, rx_ring,
 						    ICE_XDP_CONSUMED);
-			xdp->data = NULL;
-			rx_ring->first_desc = ntc;
-			rx_ring->nr_frags = 0;
-			break;
 		}
-		xdp->data = NULL;
-		rx_ring->first_desc = ntc;
-		rx_ring->nr_frags = 0;
+		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit);
+
+		if (!skb)
+			break;
 
 		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
 		if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
@@ -1257,23 +1283,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		total_rx_pkts++;
 	}
 
-	first = rx_ring->first_desc;
-	while (cached_ntc != first) {
-		struct ice_rx_buf *buf = &rx_ring->rx_buf[cached_ntc];
-
-		if (buf->act & (ICE_XDP_TX | ICE_XDP_REDIR)) {
-			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
-			xdp_xmit |= buf->act;
-		} else if (buf->act & ICE_XDP_CONSUMED) {
-			buf->pagecnt_bias++;
-		} else if (buf->act == ICE_XDP_PASS) {
-			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
-		}
-
-		ice_put_rx_buf(rx_ring, buf);
-		if (++cached_ntc >= cnt)
-			cached_ntc = 0;
-	}
 	rx_ring->next_to_clean = ntc;
 	/* return up to cleaned_count buffers to hardware */
 	failure = ice_alloc_rx_bufs(rx_ring, ICE_RX_DESC_UNUSED(rx_ring));
-- 
2.43.0


