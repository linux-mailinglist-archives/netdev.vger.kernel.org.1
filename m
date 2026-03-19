Return-Path: <netdev+bounces-269597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NUsESE7vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:06:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7B82D085E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 712EF31588CC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BAE3D8100;
	Thu, 19 Mar 2026 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVDgvm9s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFFC3E8661;
	Thu, 19 Mar 2026 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942954; cv=none; b=jnthiT0nd1xuWOmWjw0lBkJ/KseWYbiPVB0jnnt4rZggslhykRnXCZDt20eWB4G9ZRkYxAWGeFip1ipHcpP/hNJxSF+RfdtyHDwiU0yBYz9iQWriK+OwgZDRDUqdbUA+Z7qrIvh2jmfaH7F2Fd4RNJ1Fg2WsseB4H0RfkWvohkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942954; c=relaxed/simple;
	bh=9pq6X9CKxVa40lk3uDIMaIyECsGMxfrgYsBR72OtY4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AaeVKSE5DNpcY456bwTfxs8Y6/4q92+q1omVEBgFJGbahZF3hG3rQa8zFgvFPvnpwKDXdhLXQvyJ1gXHljeA3cdLI4dD+BHe9wB8+uaqxdp8Fv+JxbxNkdZY95zyQD1BtVE2SwTv7UseBlF+7RzOXz7axPcilHPvviF9TDfZ+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVDgvm9s; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773942953; x=1805478953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9pq6X9CKxVa40lk3uDIMaIyECsGMxfrgYsBR72OtY4s=;
  b=gVDgvm9sV9kMK+L51e5AUZCsaPzyiY4u/wMQKRTZ7pLOFBz67lPvG75a
   uME4c3dSKg64XzvG/JO232xIfPQoyqAhGPmbr/MATxG+HUxy4yQukG3R5
   aK7ulSyqaaO4jcrvCoTvf7ibW+BrFRjxXDhCVPbOm1APfZ0ZPidzuX0zL
   sd83I2WCIHV4Qmi4lg22/ke/RavSTE/OsDN2XGX7BrsRjaFeaiq5NlF26
   1OAY9aOoft4EJxdpny63Ldyn8enfaOWyPU22yRJlh3Q1yweWW1T507Yjy
   buaKyulWFT2ITFyUatvkwEWN0EBXcpwCTjU6CsncrOPgT/Gi8VYgTOVTX
   g==;
X-CSE-ConnectionGUID: lC9b7SOqTRerlLDuAtKIrg==
X-CSE-MsgGUID: xlzGQ8JuTzmiXWGI3mh42Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74038597"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74038597"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 10:55:52 -0700
X-CSE-ConnectionGUID: rLeiSoiNTSaNpywhd6Y9dw==
X-CSE-MsgGUID: SBvmmW4iTpehTZ2JFCsPEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="246058577"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 19 Mar 2026 10:55:49 -0700
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
Subject: [PATCH v2 net 3/8] ice: do not round up result of dbuf calculation for xsk pool
Date: Thu, 19 Mar 2026 18:55:33 +0100
Message-Id: <20260319175538.479139-4-maciej.fijalkowski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269597-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A7B82D085E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When programming dbuf on rx queue context, avoid division round up as
it causes to actually corrupt the tailroom for AF_XDP ZC. Below is an
example based on 4k chunk size when xsk pool pointer is valid on given
rx ring:

chunk_size = 4096
headroom = 256
tailroom = 320

ring->rx_buf_len = 4096 - 256 - 320 = 3520

rx_ctx.dbuf = DIV_ROUND_UP(3520, 128) ->
3520 / 128 = 27.5 -> round up results in 28

dbuf programming unit is 128. If we give 128 * 28 = 3584. So HW will
corrupt 64 bytes from tailroom. Decrement dbuf by 1 when xsk_pool is
present on given ice_rx_ring.

Also, restore ::rx_buf_len setting via xsk_pool_get_rx_frame_size() as
of now it respects the tailroom.

Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1667f686ff75..f9514d7bb83c 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -500,6 +500,8 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	 */
 	rlan_ctx.dbuf = DIV_ROUND_UP(ring->rx_buf_len,
 				     BIT_ULL(ICE_RLAN_CTX_DBUF_S));
+	if (ring->xsk_pool)
+		rlan_ctx.dbuf--;
 
 	/* use 32 byte descriptors */
 	rlan_ctx.dsize = 1;
@@ -673,6 +675,9 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		if (ring->xsk_pool) {
 			u32 frag_size =
 				xsk_pool_get_rx_frag_step(ring->xsk_pool);
+
+			ring->rx_buf_len =
+				xsk_pool_get_rx_frame_size(ring->xsk_pool);
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
 						 ring->q_vector->napi.napi_id,
-- 
2.43.0


