Return-Path: <netdev+bounces-269599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L08NOs4vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:56:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B56C2D062B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69A323055555
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314003F2115;
	Thu, 19 Mar 2026 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIicOWXK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19A13F0A86;
	Thu, 19 Mar 2026 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942958; cv=none; b=QASQvt6zv9oo+jYrcyvfSFU+1iS2d6iQsFcvJpqW2jnuwQ8x82sahfaf+1GWubdTjMB1nlhByRFnJ4PNG6BTrwigtOSYRPjQhcxsremFDRNtFXyvQjt36zINqrFidbkdhaxn1l/uoJ0KeD43vQLJMkvdOgNa9p44OJkUmgeWhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942958; c=relaxed/simple;
	bh=az5leVVFtJsKZ1g58jHUn5a6qN2El4k312CL0uqU6CU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SuEfbTSObI+VYnswQnqTOWw9kSZKMeXmaVGEE6UIH0CS6hJBr1723WKFay8C7mVAfAhrV6snTrx8Li/uSGUdkUawxGMhsEQ/YGnIvENR76XIDrb3ovl0lcmhSt0DMc8cj3cj1V5XixmXIYZeCvT+J0OkWxv9VEQsumDrjh3tqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIicOWXK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773942957; x=1805478957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=az5leVVFtJsKZ1g58jHUn5a6qN2El4k312CL0uqU6CU=;
  b=IIicOWXKExnbAiQZSaO6L3gfn1r1uMCF8dpuy56dkLl9QKTX6lEeO02h
   wR5BcQgd05Qp3u8TJ/V1pLSbnh6fBFUOIF7KPh46e8z0OpC3yHptRDMbg
   9jrlp0JrvBgOLTRQ/CyTS48YBryx/tu/mAiU8vy9yEuQpom1KcD99AM+O
   nQ0Ys63fZ812QkU2PTdWQLJBZq1tENwWD4yfqP6jEAxc2JMC6nOizg6Bt
   lK6/kjHbMYCwW5hqW5ETnfXurYoCaPIpyIfmRuh/w+zdttmn8hV0D+igg
   3IeqhYvqCi1U97NO6pXVEr8afirktm5mO9pqLsN6y5lXfKQwFs03poXXN
   w==;
X-CSE-ConnectionGUID: jS3cQZvGRtSW0Klr6Y2GgA==
X-CSE-MsgGUID: 9GaDTvGcR2KQy1C79LQV+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74038615"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74038615"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 10:55:56 -0700
X-CSE-ConnectionGUID: QAz3COnTT+OvWExWvQBBBw==
X-CSE-MsgGUID: q5esyhNXRf6hw9sckJfOKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="246058626"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 19 Mar 2026 10:55:54 -0700
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 net 5/8] xsk: validate MTU against usable frame size on bind
Date: Thu, 19 Mar 2026 18:55:35 +0100
Message-Id: <20260319175538.479139-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269599-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 8B56C2D062B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

AF_XDP bind currently accepts zero-copy pool configurations without
verifying that the device MTU fits into the usable frame space provided
by the UMEM chunk.

This becomes a problem since we started to respect tailroom which is
subtracted from chunk_size (among with headroom). 2k chunk size might
not provide enough space for standard 1500 MTU, so let us catch such
settings at bind time.

This prevents creating an already-invalid setup and complements the
MTU change restriction for devices with an attached XSK pool.

Currently xp_assign_dev_shared() is missing XDP_USE_SG being propagated
to flags so set it in order to preserve mtu check that is supposed to be
done only when no multi-buffer setup is in picture.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk_buff_pool.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 37b7a68b89b3..e9377b05118b 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -157,6 +157,7 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
 int xp_assign_dev(struct xsk_buff_pool *pool,
 		  struct net_device *netdev, u16 queue_id, u16 flags)
 {
+	bool mbuf = flags & XDP_USE_SG;
 	bool force_zc, force_copy;
 	struct netdev_bpf bpf;
 	int err = 0;
@@ -178,7 +179,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	if (err)
 		return err;
 
-	if (flags & XDP_USE_SG)
+	if (mbuf)
 		pool->umem->flags |= XDP_UMEM_SG_FLAG;
 
 	if (flags & XDP_USE_NEED_WAKEUP)
@@ -200,10 +201,18 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_pool;
 	}
 
-	if (netdev->xdp_zc_max_segs == 1 && (flags & XDP_USE_SG)) {
+	if (netdev->xdp_zc_max_segs == 1 && mbuf) {
 		err = -EOPNOTSUPP;
 		goto err_unreg_pool;
 	}
+#define ETH_PAD_LEN (ETH_HLEN + 2 * VLAN_HLEN  + ETH_FCS_LEN)
+	if (!mbuf) {
+		if (READ_ONCE(netdev->mtu) +  ETH_PAD_LEN >
+		    xsk_pool_get_rx_frame_size(pool)) {
+			err = -EINVAL;
+			goto err_unreg_pool;
+		}
+	}
 
 	if (dev_get_min_mp_channel_count(netdev)) {
 		err = -EBUSY;
@@ -247,6 +256,9 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
 	struct xdp_umem *umem = umem_xs->umem;
 
 	flags = umem->zc ? XDP_ZEROCOPY : XDP_COPY;
+	if (umem->flags & XDP_UMEM_SG_FLAG)
+		flags |= XDP_USE_SG;
+
 	if (umem_xs->pool->uses_need_wakeup)
 		flags |= XDP_USE_NEED_WAKEUP;
 
-- 
2.43.0


