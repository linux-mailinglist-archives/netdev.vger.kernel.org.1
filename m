Return-Path: <netdev+bounces-273668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Gx4MkHjy2n0MAYAu9opvQ
	(envelope-from <netdev+bounces-273668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:07:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6738E36B6C8
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BE6F31096F9
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED803E928B;
	Tue, 31 Mar 2026 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqXzpR9o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB323E6DD3;
	Tue, 31 Mar 2026 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969346; cv=none; b=exTJOITuYzHjpJF0GnH/arGi1aaP/DKiJqBmu6IS4IRGTmKPpJDvCno9VvNcVyEPj0tFSwb4pL+wt1/ADCVMKUhgRh83Jwu29HlI2E0q0r1bFQWNf0KvxpLP8cV+Tolcis1TaYGD5t+e6II5SwYOUKYkLihHWBsT0XGjRUdI2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969346; c=relaxed/simple;
	bh=GNt6EVbuR0IqobNm2aeZ+/yDT6uFqDBB/MC/pzZY7TM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POMiyWW8ngomTBzyqMOSj3qOSIIDSErjOhbdZ3V65US+FIuU7yvA4/1JfrW8Iha0xHE5dPNwJih+nFIEKCNjY0Y1N2bBV6BrszPW9wQILXznaCt8V3n0bZL2RnI8eS5yJUWlhuIHe5JTb4R69cpawIg5H1v18psfhIP00duKLfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqXzpR9o; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774969345; x=1806505345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNt6EVbuR0IqobNm2aeZ+/yDT6uFqDBB/MC/pzZY7TM=;
  b=aqXzpR9otVhTSiQ8Ym657rjmPjUbnLfVLd4ug3W49kxlSF5oGlmUB2Z8
   5IKqq8kDMXZzyUankAwx7smTkKbkgDT2A1BckuuFmT3ACAurW4frSSnxz
   4+mdlGdkzcaJjOQLE7dLHqnnFR/Ma7CmAu2tF8yS+tXtCe9UzXwJrPg5e
   VG9fpIh3rspdXroIAMl2MlYRjR5QoJsT2xI390jNFPzM5jlFQLzWgAADw
   lnKE4kdLDYGjTaoKVF7NeGo625EnhIdLRnF30K8vd+wMUAmmk34GygNN4
   Az+C20ctJ7UdOJk7ky76tJjnmxDCN6pVQ7lPp89n/zzF5NrZ3cXoj5zh3
   w==;
X-CSE-ConnectionGUID: P+tNolIjRn+w2XS18PXE2w==
X-CSE-MsgGUID: fMZKpcCcTaebSywj4cGf+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76046122"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76046122"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:02:25 -0700
X-CSE-ConnectionGUID: f9OPpjfqR2C54kOB22o0YQ==
X-CSE-MsgGUID: fclijOhxRvy7Gb9EYRI64g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="219735528"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 31 Mar 2026 08:02:21 -0700
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
Subject: [PATCH v5 net 02/11] xsk: respect tailroom for ZC setups
Date: Tue, 31 Mar 2026 17:02:04 +0200
Message-Id: <20260331150213.550797-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
References: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273668-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 6738E36B6C8
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

xsk_pool_get_tailroom() is only reserving necessary space when pool is
zc and underlying netdev supports zc multi-buffer. Rely on umem->zc
state when configuring tailroom. xsk_pool_get_rx_frame_size() is going
to be used in further MTU validation so move setting of umem->zc before
ndo_bpf() call and on error path clear only when there are no other
users of umem, as we want to preserve the setting for other active
sockets already bound to this entity.

Typically drivers on Rx Hw buffers side work on 128 byte alignment so
let us align the value returned by xsk_pool_get_rx_frame_size() in order
to avoid addressing this on driver's side.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock_drv.h | 17 ++++++++++++++++-
 net/xdp/xsk_buff_pool.c    |  4 +++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 6b9ebae2dc95..cd9eeff536a6 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -41,6 +41,19 @@ static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
 	return XDP_PACKET_HEADROOM + pool->headroom;
 }
 
+static inline u32 xsk_pool_get_tailroom(struct xsk_buff_pool *pool)
+{
+	struct xdp_umem *umem = pool->umem;
+
+	/* Reserve tailroom only for zero-copy pools that opted into
+	 * multi-buffer. The reserved area is used for skb_shared_info,
+	 * matching the XDP core's xdp_data_hard_end() layout.
+	 */
+	if (umem->zc && (umem->flags & XDP_UMEM_SG_FLAG))
+		return SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	return 0;
+}
+
 static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
 {
 	return pool->chunk_size;
@@ -48,7 +61,9 @@ static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
 
 static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
 {
-	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool);
+	return ALIGN_DOWN(xsk_pool_get_chunk_size(pool) -
+			  xsk_pool_get_headroom(pool) -
+			  xsk_pool_get_tailroom(pool), 128);
 }
 
 static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 37b7a68b89b3..0f40bee606d3 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -200,6 +200,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_pool;
 	}
 
+	pool->umem->zc = true;
 	if (netdev->xdp_zc_max_segs == 1 && (flags & XDP_USE_SG)) {
 		err = -EOPNOTSUPP;
 		goto err_unreg_pool;
@@ -224,13 +225,14 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		err = -EINVAL;
 		goto err_unreg_xsk;
 	}
-	pool->umem->zc = true;
 	pool->xdp_zc_max_segs = netdev->xdp_zc_max_segs;
 	return 0;
 
 err_unreg_xsk:
 	xp_disable_drv_zc(pool);
 err_unreg_pool:
+	if (refcount_read(&pool->umem->users) == 1)
+		pool->umem->zc = false;
 	if (!force_zc)
 		err = 0; /* fallback to copy mode */
 	if (err) {
-- 
2.43.0


