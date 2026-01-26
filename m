Return-Path: <netdev+bounces-253617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM3yMh7ud2kVmgEAu9opvQ
	(envelope-from <netdev+bounces-253617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:43:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0537C8E026
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B32A300846C
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95323093CB;
	Mon, 26 Jan 2026 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g23y7XMj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43630AD02;
	Mon, 26 Jan 2026 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467410; cv=none; b=NmzkMR4UVGyrQQThZxRGs9bPM9RWdIewzMcvJ40Ole8yZk3dNCJhhGrPMKc7YjJO2oDML6tZwYcCINgecw2y8htxMJIYmUEeLdpE0WvEooIrmE8Lnr0lK2e7nnrFCZNk+JcOd1/y3Je0nkajgrHcqenS3XdY1HDsGFnG7Jy3mhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467410; c=relaxed/simple;
	bh=5q1Wf9vuZXDeyI1+7XA5Y6Y1giwsGPq1AGESntabpvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zu69EIS9EUm8uD3o46GslfwlNOxh54IrKue68gaPVRUpvoT3YudDEe8BmFT3RB+sxWFjwqrY7F9I3qlaR+/K6A2LaBRwQj//NLZ49hl2F7nw8ID69opJdfsELsTnwM49FPxKcvTD+bS4XCQaknRW7AgsyrwsUTzI+SRauWarl0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g23y7XMj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769467405; x=1801003405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5q1Wf9vuZXDeyI1+7XA5Y6Y1giwsGPq1AGESntabpvI=;
  b=g23y7XMj3iif20IbNbxlSzEhf2P6vtd07q7rsVGPhRsm1UxKQ4l78RYk
   awMFIpGpZvFnapm48iceQoRlYS6MByI9J7qQ/S84VFLoc19WMr8OTOEZ3
   s3Pm9nPc3CNGfjd3pDD1xaVmRzJzmJBcIh6z9rdg+MA3vCBavjNfDunQQ
   BHSPKG8pCid9c9BDUVHjLuUGoZxQAYZn4hwySJFneegFEgnBN3u86Hafr
   xCUVKesH+T061jhcEDETOY+TxiMLya/piHNspzVMtWqNqOZAsB1QN4OdG
   oo2VQuQX4tUrewD0X0cezKzDQIj/G1iaWOsfgV5bh5mZ/KCeYn6OxIHMO
   w==;
X-CSE-ConnectionGUID: e6Fw5nLSQhKxe/VE+9Ytxg==
X-CSE-MsgGUID: tjQ556e8R3GMMHl1sSgHRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70369420"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70369420"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 14:43:25 -0800
X-CSE-ConnectionGUID: yJQW2NxWSWmpmYmTerAmHA==
X-CSE-MsgGUID: McfdtltMTA2mjLRQG4wiqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="230754311"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jan 2026 14:43:23 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: YiFei Zhu <zhuyifei@google.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Mina Almasry <almasrymina@google.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 7/7] idpf: export RX hardware timestamping information to XDP
Date: Mon, 26 Jan 2026 14:43:11 -0800
Message-ID: <20260126224313.3847849-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260126224313.3847849-1-anthony.l.nguyen@intel.com>
References: <20260126224313.3847849-1-anthony.l.nguyen@intel.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,intel.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253617-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,osuosl.org:email]
X-Rspamd-Queue-Id: 0537C8E026
X-Rspamd-Action: no action

From: YiFei Zhu <zhuyifei@google.com>

The logic is similar to idpf_rx_hwtstamp, but the data is exported
as a BPF kfunc instead of appended to an skb to support grabbing
timestamps in xsk packets.

A idpf_queue_has(PTP, rxq) condition is added to check the queue
supports PTP similar to idpf_rx_process_skb_fields.

Tested using an xsk connection and checking xdp timestamps are
retrievable in received packets.

Cc: intel-wired-lan@lists.osuosl.org
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c | 31 +++++++++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/xdp.h | 20 +++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 0fe435fdbb6c..2b60f2a78684 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include "idpf.h"
+#include "idpf_ptp.h"
 #include "idpf_virtchnl.h"
 #include "xdp.h"
 #include "xsk.h"
@@ -398,8 +399,38 @@ static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
 				    pt);
 }
 
+static int idpf_xdpmo_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
+{
+	const struct libeth_xdp_buff *xdp = (typeof(xdp))ctx;
+	struct idpf_xdp_rx_desc desc __uninitialized;
+	const struct idpf_rx_queue *rxq;
+	u64 cached_time, ts_ns;
+	u32 ts_high;
+
+	rxq = libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
+
+	if (!idpf_queue_has(PTP, rxq))
+		return -ENODATA;
+
+	idpf_xdp_get_qw1(&desc, xdp->desc);
+
+	if (!(idpf_xdp_rx_ts_low(&desc) & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
+		return -ENODATA;
+
+	cached_time = READ_ONCE(rxq->cached_phc_time);
+
+	idpf_xdp_get_qw3(&desc, xdp->desc);
+
+	ts_high = idpf_xdp_rx_ts_high(&desc);
+	ts_ns = idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
+
+	*timestamp = ts_ns;
+	return 0;
+}
+
 static const struct xdp_metadata_ops idpf_xdpmo = {
 	.xmo_rx_hash		= idpf_xdpmo_rx_hash,
+	.xmo_rx_timestamp	= idpf_xdpmo_rx_timestamp,
 };
 
 void idpf_xdp_set_features(const struct idpf_vport *vport)
diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
index 7ffc6955dfae..63e56f7d43e0 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.h
+++ b/drivers/net/ethernet/intel/idpf/xdp.h
@@ -112,11 +112,13 @@ struct idpf_xdp_rx_desc {
 	aligned_u64		qw1;
 #define IDPF_XDP_RX_BUF		GENMASK_ULL(47, 32)
 #define IDPF_XDP_RX_EOP		BIT_ULL(1)
+#define IDPF_XDP_RX_TS_LOW	GENMASK_ULL(31, 24)
 
 	aligned_u64		qw2;
 #define IDPF_XDP_RX_HASH	GENMASK_ULL(31, 0)
 
 	aligned_u64		qw3;
+#define IDPF_XDP_RX_TS_HIGH	GENMASK_ULL(63, 32)
 } __aligned(4 * sizeof(u64));
 static_assert(sizeof(struct idpf_xdp_rx_desc) ==
 	      sizeof(struct virtchnl2_rx_flex_desc_adv_nic_3));
@@ -128,6 +130,8 @@ static_assert(sizeof(struct idpf_xdp_rx_desc) ==
 #define idpf_xdp_rx_buf(desc)	FIELD_GET(IDPF_XDP_RX_BUF, (desc)->qw1)
 #define idpf_xdp_rx_eop(desc)	!!((desc)->qw1 & IDPF_XDP_RX_EOP)
 #define idpf_xdp_rx_hash(desc)	FIELD_GET(IDPF_XDP_RX_HASH, (desc)->qw2)
+#define idpf_xdp_rx_ts_low(desc)	FIELD_GET(IDPF_XDP_RX_TS_LOW, (desc)->qw1)
+#define idpf_xdp_rx_ts_high(desc)	FIELD_GET(IDPF_XDP_RX_TS_HIGH, (desc)->qw3)
 
 static inline void
 idpf_xdp_get_qw0(struct idpf_xdp_rx_desc *desc,
@@ -149,6 +153,9 @@ idpf_xdp_get_qw1(struct idpf_xdp_rx_desc *desc,
 	desc->qw1 = ((const typeof(desc))rxd)->qw1;
 #else
 	desc->qw1 = ((u64)le16_to_cpu(rxd->buf_id) << 32) |
+		    ((u64)rxd->ts_low << 24) |
+		    ((u64)rxd->fflags1 << 16) |
+		    ((u64)rxd->status_err1 << 8) |
 		    rxd->status_err0_qw1;
 #endif
 }
@@ -166,6 +173,19 @@ idpf_xdp_get_qw2(struct idpf_xdp_rx_desc *desc,
 #endif
 }
 
+static inline void
+idpf_xdp_get_qw3(struct idpf_xdp_rx_desc *desc,
+		 const struct virtchnl2_rx_flex_desc_adv_nic_3 *rxd)
+{
+#ifdef __LIBETH_WORD_ACCESS
+	desc->qw3 = ((const typeof(desc))rxd)->qw3;
+#else
+	desc->qw3 = ((u64)le32_to_cpu(rxd->ts_high) << 32) |
+		    ((u64)le16_to_cpu(rxd->fmd6) << 16) |
+		    le16_to_cpu(rxd->l2tag1);
+#endif
+}
+
 void idpf_xdp_set_features(const struct idpf_vport *vport);
 
 int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp);
-- 
2.47.1


