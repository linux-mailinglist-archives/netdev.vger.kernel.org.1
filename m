Return-Path: <netdev+bounces-259042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH1LFrhzlGnVDwIAu9opvQ
	(envelope-from <netdev+bounces-259042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:57:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 717F714CD50
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E87553010919
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B77836C0CF;
	Tue, 17 Feb 2026 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5K7CVes"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E0C36B057;
	Tue, 17 Feb 2026 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336492; cv=none; b=LtD5wBpVlNquDvMTzIy5WYiw3JkOfb6Y8d/o96P5tkbZarrJiFUX2xRjXVqNnd4PT8yJDcJ8t099ORU3mjAxjosTJuuQ+Fz7T7X16GVAW+aEK3rkcW97aUGoOL8avHNTAiSa79j0zbragJiJScPM5JW3uFg1Fnq4JpKq5z9OZno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336492; c=relaxed/simple;
	bh=xn1XKEnqEO3bO9oNkjypFpVlWOWknkEzwjahmIcNFWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0fBvAGzLFacZB32W2BPijxOCKumQtfgcjMLdSR8fCJwLBbWXXF1MJSjCkxG2P59t4HnEi6BranVAbqN8HkDjMl+wn2DQx4yPIcPIvPCkxeYR30d1QHg9KOoSYlfRYNbOn8AmZhjutv44jZ0spmtWm5NDyurFBWA8RKqRzNyaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5K7CVes; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771336491; x=1802872491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xn1XKEnqEO3bO9oNkjypFpVlWOWknkEzwjahmIcNFWY=;
  b=k5K7CVessji0YG+sPV2AIAGGv7+WjnuhM9xzthE2mBNEFrVA/qCSU8/D
   vLaHg46aGfHec7UoaziQ3EL0Df18gKxPjrRlfGY9Sn0fmMU+r2xWBREBw
   z+bZ8zfsfNfnTnLaScER2yBFA1JThm3PWvGj/S3Ys2kRSZnTOTvt+PGSD
   fXuw64JLPuTRnZEtpHl70onXmQ3oEwCENadggyHVIrnbuwJ8V8CMU41fC
   E+WJ1rGCuy6pFJJaJhVnMzYW2Ivaw8zmNwZwEGjBbCzkna/ZMZYFzMUdf
   XX3Z/3YsYdLskgzfw+hevN/ndG7vsUfqFsJH1MDFk36Ci4aaHlIX8/j5V
   Q==;
X-CSE-ConnectionGUID: sXOg81dfTRGkASui0/xs2w==
X-CSE-MsgGUID: cFtdFiltToSbRU54uDOcDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72470455"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72470455"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 05:54:50 -0800
X-CSE-ConnectionGUID: 6OsvV+O0RIieNkT8AAeg/w==
X-CSE-MsgGUID: ftAtZ2DTS7eQf25ElQGWkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="213904652"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 17 Feb 2026 05:54:41 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1C1C928795;
	Tue, 17 Feb 2026 13:54:38 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kernelxing@tencent.com>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH bpf v3 5/9] i40e: fix registering XDP RxQ info
Date: Tue, 17 Feb 2026 14:24:43 +0100
Message-ID: <20260217132450.1936200-6-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260217132450.1936200-1-larysa.zaremba@intel.com>
References: <20260217132450.1936200-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,vger.kernel.org,lists.osuosl.org,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-259042-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 717F714CD50
X-Rspamd-Action: no action

Current way of handling XDP RxQ info in i40e has following problems:
* when xsk_buff_pool is detached, memory model is not unregistered before
  registering a new one, this leads to a dangling xsk_buff_pool in the
  memory model table
* frag_size is not updated when xsk_buff_pool is detached or when MTU is
  changed, this leads to growing tail always failing for multi-buffer
  packets.

Couple XDP RxQ info registering with buffer allocations and unregistering
with cleaning the ring.

Fixes: a045d2f2d03d ("i40e: set xdp_rxq_info::frag_size")
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 34 ++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  5 +--
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d3bc3207054f..eaa5b65e6daf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3577,18 +3577,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	if (ring->vsi->type != I40E_VSI_MAIN)
 		goto skip;
 
-	if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
-		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
-					 ring->queue_index,
-					 ring->q_vector->napi.napi_id,
-					 ring->rx_buf_len);
-		if (err)
-			return err;
-	}
-
 	ring->xsk_pool = i40e_xsk_pool(ring);
 	if (ring->xsk_pool) {
-		xdp_rxq_info_unreg(&ring->xdp_rxq);
 		ring->rx_buf_len = xsk_pool_get_rx_frame_size(ring->xsk_pool);
 		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 					 ring->queue_index,
@@ -3600,17 +3590,23 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 						 MEM_TYPE_XSK_BUFF_POOL,
 						 NULL);
 		if (err)
-			return err;
+			goto unreg_xdp;
 		dev_info(&vsi->back->pdev->dev,
 			 "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
 			 ring->queue_index);
 
 	} else {
+		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+					 ring->queue_index,
+					 ring->q_vector->napi.napi_id,
+					 ring->rx_buf_len);
+		if (err)
+			return err;
 		err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 						 MEM_TYPE_PAGE_SHARED,
 						 NULL);
 		if (err)
-			return err;
+			goto unreg_xdp;
 	}
 
 skip:
@@ -3648,7 +3644,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 		dev_info(&vsi->back->pdev->dev,
 			 "Failed to clear LAN Rx queue context on Rx ring %d (pf_q %d), error: %d\n",
 			 ring->queue_index, pf_q, err);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto unreg_xdp;
 	}
 
 	/* set the context in the HMC */
@@ -3657,7 +3654,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 		dev_info(&vsi->back->pdev->dev,
 			 "Failed to set LAN Rx queue context on Rx ring %d (pf_q %d), error: %d\n",
 			 ring->queue_index, pf_q, err);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto unreg_xdp;
 	}
 
 	/* configure Rx buffer alignment */
@@ -3665,7 +3663,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 		if (I40E_2K_TOO_SMALL_WITH_PADDING) {
 			dev_info(&vsi->back->pdev->dev,
 				 "2k Rx buffer is too small to fit standard MTU and skb_shared_info\n");
-			return -EOPNOTSUPP;
+			err = -EOPNOTSUPP;
+			goto unreg_xdp;
 		}
 		clear_ring_build_skb_enabled(ring);
 	} else {
@@ -3695,6 +3694,11 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	}
 
 	return 0;
+unreg_xdp:
+	if (ring->vsi->type == I40E_VSI_MAIN)
+		xdp_rxq_info_unreg(&ring->xdp_rxq);
+
+	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index cc0b9efc2637..816179c7e271 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1470,6 +1470,9 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
 	if (!rx_ring->rx_bi)
 		return;
 
+	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
+		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
+
 	if (rx_ring->xsk_pool) {
 		i40e_xsk_clean_rx_ring(rx_ring);
 		goto skip_free;
@@ -1527,8 +1530,6 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
 void i40e_free_rx_resources(struct i40e_ring *rx_ring)
 {
 	i40e_clean_rx_ring(rx_ring);
-	if (rx_ring->vsi->type == I40E_VSI_MAIN)
-		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	rx_ring->xdp_prog = NULL;
 	kfree(rx_ring->rx_bi);
 	rx_ring->rx_bi = NULL;
-- 
2.52.0


