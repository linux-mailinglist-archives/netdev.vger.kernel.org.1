Return-Path: <netdev+bounces-241591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09279C863C3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1D06353164
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F86532AADC;
	Tue, 25 Nov 2025 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWyZMKKP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868E32824A;
	Tue, 25 Nov 2025 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092206; cv=none; b=IZt2WVaca4BF4dObQhpSrYJuWjjq2cjipFYxKCNjdDUB8qYGXWcYETPUUBMlB/ZkAAL7XIW9fUpTDf5b5eqS+oA7YbAf/UpRZD7sF+90DweofISQWZTw1w6Pjcr2uZW/K1mpofXNd1rRpod24x73aCDcnDkeV9UBe2gbQiUfi0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092206; c=relaxed/simple;
	bh=+DFq6dbzD3lc+CDVNerVm77IALgzgfxpNZyKVSb2ApU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBBdB8OLdM00VK6GnKdlq32fOrDBWhylFnkwhXSlXjHh0sNnHiN8Q4BPhJfI9Rgaa8MNmVBGcXlP2CSIDt70IvW6zhbAnDy4uAcSMRs4k602K6myzkYkCAsnPufT12cmb23314+oYrq8ETAwsas+AZYi/SSMNKk+h1iPw6l9a2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWyZMKKP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764092204; x=1795628204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+DFq6dbzD3lc+CDVNerVm77IALgzgfxpNZyKVSb2ApU=;
  b=BWyZMKKPCybtv2v17FYpOGEz5Gl915vsTN5c8QqS6pTHXIwk622r5b8x
   N4ffVPqUM30IxfDx13b1FxS2MXrXpIOhvSpe77zcgXxkJODW4HSoajqva
   JnDDqN22Vi97L+54RL3jv9Dfg37as9TJL9xy53illqPZURw3iUV0C/Pf2
   C3O4Ue5h7thKdHAr0VXdBzgYfSh+8/Pp/mpgjRfms6B/RrgIsnboHKH0e
   W2OfHjbnBBD0dy3oizt69TSHpcuGzpsojfgEnE4TTpF/rEgXMKrW+xFi6
   TAgNoHxCTE+WculcbTwoE/O8OaUbYaqiv8d0NTO1Uo+tA7TyPdLp/ubDW
   w==;
X-CSE-ConnectionGUID: YapaV8IDTHyVwwT9zyEDNQ==
X-CSE-MsgGUID: wgkdenwwTPmBsvWFddI0hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="69979879"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="69979879"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 09:36:38 -0800
X-CSE-ConnectionGUID: oDga+snDRSe9QN1Pz3pnew==
X-CSE-MsgGUID: lls53vmoQ7ytKkRrLVdvhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="216040337"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 25 Nov 2025 09:36:34 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 1/5] libeth: pass Rx queue index to PP when creating a fill queue
Date: Tue, 25 Nov 2025 18:35:59 +0100
Message-ID: <20251125173603.3834486-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125173603.3834486-1-aleksander.lobakin@intel.com>
References: <20251125173603.3834486-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since recently, page_pool_create() accepts optional stack index of
the Rx queue which the pool will be created for. It can then be
used on control path for stuff like memory providers.
Add the same field to libeth_fq and pass the index from all the
drivers using libeth for managing Rx to simplify implementing MP
support later.
idpf has one libeth_fq per buffer/fill queue and each Rx queue has
two fill queues, but since fill queues can never be shared, we can
store the corresponding Rx queue index there during the
initialization to pass it to libeth.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  2 ++
 include/net/libeth/rx.h                     |  2 ++
 drivers/net/ethernet/intel/iavf/iavf_txrx.c |  1 +
 drivers/net/ethernet/intel/ice/ice_base.c   |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 13 +++++++++++++
 drivers/net/ethernet/intel/libeth/rx.c      |  1 +
 6 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 75b977094741..1f368c4e0a76 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -744,6 +744,7 @@ libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
  * @q_id: Queue id
  * @size: Length of descriptor ring in bytes
  * @dma: Physical address of ring
+ * @rxq_idx: stack index of the corresponding Rx queue
  * @q_vector: Backreference to associated vector
  * @rx_buffer_low_watermark: RX buffer low watermark
  * @rx_hbuf_size: Header buffer size
@@ -788,6 +789,7 @@ struct idpf_buf_queue {
 	dma_addr_t dma;
 
 	struct idpf_q_vector *q_vector;
+	u16 rxq_ixd;
 
 	u16 rx_buffer_low_watermark;
 	u16 rx_hbuf_size;
diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 5d991404845e..3b3d7acd13c9 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -71,6 +71,7 @@ enum libeth_fqe_type {
  * @xdp: flag indicating whether XDP is enabled
  * @buf_len: HW-writeable length per each buffer
  * @nid: ID of the closest NUMA node with memory
+ * @idx: stack index of the corresponding Rx queue
  */
 struct libeth_fq {
 	struct_group_tagged(libeth_fq_fp, fp,
@@ -88,6 +89,7 @@ struct libeth_fq {
 
 	u32			buf_len;
 	int			nid;
+	u32			idx;
 };
 
 int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 363c42bf3dcf..d3c68659162b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -771,6 +771,7 @@ int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
 		.count		= rx_ring->count,
 		.buf_len	= LIBIE_MAX_RX_BUF_LEN,
 		.nid		= NUMA_NO_NODE,
+		.idx		= rx_ring->queue_index,
 	};
 	int ret;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index eadb1e3d12b3..1aa40f13947e 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -607,6 +607,7 @@ static int ice_rxq_pp_create(struct ice_rx_ring *rq)
 	struct libeth_fq fq = {
 		.count		= rq->count,
 		.nid		= NUMA_NO_NODE,
+		.idx		= rq->q_index,
 		.hsplit		= rq->vsi->hsplit,
 		.xdp		= ice_is_xdp_ena_vsi(rq->vsi),
 		.buf_len	= LIBIE_MAX_RX_BUF_LEN,
@@ -629,6 +630,7 @@ static int ice_rxq_pp_create(struct ice_rx_ring *rq)
 		.count		= rq->count,
 		.type		= LIBETH_FQE_HDR,
 		.nid		= NUMA_NO_NODE,
+		.idx		= rq->q_index,
 		.xdp		= ice_is_xdp_ena_vsi(rq->vsi),
 	};
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 828f7c444d30..5e397560a515 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -557,6 +557,7 @@ static int idpf_rx_hdr_buf_alloc_all(struct idpf_buf_queue *bufq)
 		.type	= LIBETH_FQE_HDR,
 		.xdp	= idpf_xdp_enabled(bufq->q_vector->vport),
 		.nid	= idpf_q_vector_to_mem(bufq->q_vector),
+		.idx	= bufq->rxq_ixd,
 	};
 	int ret;
 
@@ -698,6 +699,7 @@ static int idpf_rx_bufs_init_singleq(struct idpf_rx_queue *rxq)
 		.count	= rxq->desc_count,
 		.type	= LIBETH_FQE_MTU,
 		.nid	= idpf_q_vector_to_mem(rxq->q_vector),
+		.idx	= rxq->idx,
 	};
 	int ret;
 
@@ -757,6 +759,7 @@ static int idpf_rx_bufs_init(struct idpf_buf_queue *bufq,
 		.hsplit		= idpf_queue_has(HSPLIT_EN, bufq),
 		.xdp		= idpf_xdp_enabled(bufq->q_vector->vport),
 		.nid		= idpf_q_vector_to_mem(bufq->q_vector),
+		.idx		= bufq->rxq_ixd,
 	};
 	int ret;
 
@@ -1900,6 +1903,16 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 							LIBETH_RX_LL_LEN;
 			idpf_rxq_set_descids(vport, q);
 		}
+
+		if (!idpf_is_queue_model_split(vport->rxq_model))
+			continue;
+
+		for (j = 0; j < vport->num_bufqs_per_qgrp; j++) {
+			struct idpf_buf_queue *bufq;
+
+			bufq = &rx_qgrp->splitq.bufq_sets[j].bufq;
+			bufq->rxq_ixd = rx_qgrp->splitq.rxq_sets[0]->rxq.idx;
+		}
 	}
 
 err_alloc:
diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 62521a1f4ec9..8874b714cdcc 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -156,6 +156,7 @@ int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi)
 		.order		= LIBETH_RX_PAGE_ORDER,
 		.pool_size	= fq->count,
 		.nid		= fq->nid,
+		.queue_idx	= fq->idx,
 		.dev		= napi->dev->dev.parent,
 		.netdev		= napi->dev,
 		.napi		= napi,
-- 
2.51.1


