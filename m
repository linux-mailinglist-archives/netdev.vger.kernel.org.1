Return-Path: <netdev+bounces-274610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BqyH2SQzmkbogYAu9opvQ
	(envelope-from <netdev+bounces-274610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:51:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6807638B7A3
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 319AE302B9CF
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6033537E4;
	Thu,  2 Apr 2026 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYPq+lBw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC70346AD4;
	Thu,  2 Apr 2026 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145037; cv=none; b=lg+JTlpg4sCOxUjVSJCMcMO1fVlDrQlnO56kRu9FS6HvjNgxKzZeL1GGLNPcohBDicvf3F5bEFgrGA9KEHebIGld/UNBIWve38tjrMQh4tjZPUbjqonNrYqMP+22sXfCDji/+njn1mzhmEECQHKnjH48w1SlTLcs9YUG5GR7CCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145037; c=relaxed/simple;
	bh=K1B9v2pIldPyJy4eOGqhB39stLmZyhpKCcFtgknLso8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQgIE6raa0tQ5bi+vLGl2CCBQgESCTA0CGw53UmCiqEnCC1xgm7wLvXyo+cfEYoB7TCRSAdNWz224VTZzs0rcOebmBNt3qfZkIOQD38Y0a1kbz3cnfE6U2L4fof18iQrxF+IgxRv2mwe39TWEVHaQRuRRWMYTrmfcmMeOEGd6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYPq+lBw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775145037; x=1806681037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1B9v2pIldPyJy4eOGqhB39stLmZyhpKCcFtgknLso8=;
  b=bYPq+lBwkd/hTSnoECV0fjDGUNYTGPN2msEe2CDtsp76F/zUAl8/42MP
   846RQ0ymyLRkar/qYJsANVW1pSjHwngXU2jCchlaLPLKdwxVls07hJJU9
   IxHxS0PTEesI0MVKew6qaTJWKl3My4PdfME+GezD2ZK7Crb/AynXKEaOc
   Ywut+tQ0Sb0dBOGiosDNh+s9+1Kid7wHY23ozcE+VXjFYOa8Hv6aP/vOT
   H4tn0U9PjLD9pl9tLLi8NlyTCo/bVKNChohPTwDlA5I+c0no2EV1zAzy2
   owCqueDm91fEfi9cWq217MmxLLLwYCxaN+/ExJbZOFupqDsze/DriNJx/
   Q==;
X-CSE-ConnectionGUID: F4CSSvKTSR2thxnLIHYrGg==
X-CSE-MsgGUID: 99umQlqIRX6QTL7vFipg+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75927967"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75927967"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 08:50:36 -0700
X-CSE-ConnectionGUID: ITdT5P5tSFS7btILo2y2qw==
X-CSE-MsgGUID: x/M4th2lTN6VRSM9rk8v0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="224157597"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa008.fm.intel.com with ESMTP; 02 Apr 2026 08:50:33 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v6 net 2/8] xsk: respect tailroom for ZC setups
Date: Thu,  2 Apr 2026 17:49:52 +0200
Message-Id: <20260402154958.562179-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274610-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,fomichev.me:email]
X-Rspamd-Queue-Id: 6807638B7A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Multi-buffer XDP stores information about frags in skb_shared_info that
sits at the tailroom of a packet. The storage space is reserved via
xdp_data_hard_end():

	((xdp)->data_hard_start + (xdp)->frame_sz -	\
	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))

and then we refer to it via macro below:

static inline struct skb_shared_info *
xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
{
        return (struct skb_shared_info *)xdp_data_hard_end(xdp);
}

Currently we do not respect this tailroom space in multi-buffer AF_XDP
ZC scenario. To address this, introduce xsk_pool_get_tailroom() and use
it within xsk_pool_get_rx_frame_size() which is used in ZC drivers to
configure length of HW Rx buffer.

Typically drivers on Rx Hw buffers side work on 128 byte alignment so
let us align the value returned by xsk_pool_get_rx_frame_size() in order
to avoid addressing this on driver's side. This addresses the fact that
idpf uses mentioned function *before* pool->dev being set so we were at
risk that after subtracting tailroom we would not provide 128-byte
aligned value to HW.

Since xsk_pool_get_rx_frame_size() is actively used in xsk_rcv_check()
and __xsk_rcv(), add a variant of this routine that will not include 128
byte alignment and therefore old behavior is preserved.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock_drv.h | 23 ++++++++++++++++++++++-
 net/xdp/xsk.c              |  4 ++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 6b9ebae2dc95..46797645a0c2 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -41,16 +41,37 @@ static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
 	return XDP_PACKET_HEADROOM + pool->headroom;
 }
 
+static inline u32 xsk_pool_get_tailroom(bool mbuf)
+{
+	return mbuf ? SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) : 0;
+}
+
 static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
 {
 	return pool->chunk_size;
 }
 
-static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
+static inline u32 __xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
 {
 	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool);
 }
 
+static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
+{
+	u32 frame_size =  __xsk_pool_get_rx_frame_size(pool);
+	struct xdp_umem *umem = pool->umem;
+	bool mbuf;
+
+	/* Reserve tailroom only for zero-copy pools that opted into
+	 * multi-buffer. The reserved area is used for skb_shared_info,
+	 * matching the XDP core's xdp_data_hard_end() layout.
+	 */
+	mbuf = pool->dev && (umem->flags & XDP_UMEM_SG_FLAG);
+	frame_size -= xsk_pool_get_tailroom(mbuf);
+
+	return ALIGN_DOWN(frame_size, 128);
+}
+
 static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
 {
 	return pool->unaligned ? 0 : xsk_pool_get_chunk_size(pool);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index c078c9e4b243..000cbfb66d5b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -250,7 +250,7 @@ static u32 xsk_copy_xdp(void *to, void **from, u32 to_len,
 
 static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
-	u32 frame_size = xsk_pool_get_rx_frame_size(xs->pool);
+	u32 frame_size = __xsk_pool_get_rx_frame_size(xs->pool);
 	void *copy_from = xsk_copy_xdp_start(xdp), *copy_to;
 	u32 from_len, meta_len, rem, num_desc;
 	struct xdp_buff_xsk *xskb;
@@ -350,7 +350,7 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
 		return -EINVAL;
 
-	if (len > xsk_pool_get_rx_frame_size(xs->pool) && !xs->sg) {
+	if (len > __xsk_pool_get_rx_frame_size(xs->pool) && !xs->sg) {
 		xs->rx_dropped++;
 		return -ENOSPC;
 	}
-- 
2.43.0


