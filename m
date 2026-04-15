Return-Path: <netdev+bounces-278656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHhILDYn32nmPQAAu9opvQ
	(envelope-from <netdev+bounces-278656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:50:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCCE400986
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66801302493F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE68037FF6A;
	Wed, 15 Apr 2026 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnY+8wT1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC780372EEA
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232169; cv=none; b=GGpskZSjRTiqXGdmrBb/YcgZW0Uxf4fFCWYNYuhuCAYhTzEboWdwPzuyNR3PkLjD50QTBCXW+KNNAMoKO6aTADneujqi9jG/MdN59wA0caRhO9Bwmele7WLV7iOhlWYsX0scfedKCKnIpiU8Y4M6t22w0psXcFyj6TLEo5Ld7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232169; c=relaxed/simple;
	bh=Av1lCViY2yEDf7+M46cn+epgVIPUj9xAsP0ojxmu2ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=leRg5vrp09TUzgas3gQyirx9yHf+GgoYcxh5CZhxeMuDj7nA566R5fei8Pjg+JGI3ciA/rtNdf2uTZkTHnXfeDh72tjH4k2urUWaw38E3jN7IsyhB2MNkCJpsb0l2GuKve0qRqK5LoqPspcBvIIkCxR13QfgdJXLYIsJr+CHD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnY+8wT1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776232168; x=1807768168;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Av1lCViY2yEDf7+M46cn+epgVIPUj9xAsP0ojxmu2ag=;
  b=hnY+8wT1roV6urKIhbL0Ypdj7uABs/o1fhogsMoLzabZ6sm2W6jS48KQ
   P+rag2osdEbKH4A//cWIIkBascA+sfLNbyfiSPOeIuOLvCpE1MTnl0iCD
   uUJxw+Wd9csownWY+dHawKB6KdIaJn4dlyWuylnrY31PeLmDCGA5hl1ZF
   rDSo8zr/StDGks+NHvOnjiJNhvHhw9FdD2ElFIoqn4CsfjqzTu2IJ2xi7
   8D5nmU3AZYi18jeM42EEM7wKdfmCEEsUb5abesnjIJAYm9m21YNg9e0TK
   HEvk2/c5ydql6GkDZBrD5qyP1nU3s3Dd6xqqaQC67GApSxadFhkmR5L9J
   g==;
X-CSE-ConnectionGUID: X/pjwArCQluWgZnzRnI5ew==
X-CSE-MsgGUID: 7omL+CfaRUCAZurXa1F39g==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77105933"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77105933"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:25 -0700
X-CSE-ConnectionGUID: YiO4N25cT4+1qhaTmXM4Og==
X-CSE-MsgGUID: al0VO0UNQnywCiMkC6ar9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253714799"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 14 Apr 2026 22:47:59 -0700
Subject: [PATCH net 04/13] ice: fix double-free of tx_buf skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-iwl-net-submission-2026-04-14-v1-4-852f38e7da39@intel.com>
References: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
In-Reply-To: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Schmidt <mschmidt@redhat.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2646;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=zcDmEncguX82dES11Ym7T4gdUnwCvY8q5L4B+FDjp4Q=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsz7ag9f+mkt2qPS0NvT6X/EfbLM+l0ZyQ9WnrP6EK/uo
 ++lcT2yo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgImsWc7wh+8q9zVLtzC73v91
 /61tOTYubPgh6MmvtUnlErP9nvt1MQz/42UL1tjUCDmWOG0+UtqYv/vJofDczT9uGzdu+pclvFC
 HHwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278656-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABCCE400986
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michal Schmidt <mschmidt@redhat.com>

If ice_tso() or ice_tx_csum() fail, the error path in
ice_xmit_frame_ring() frees the skb, but the 'first' tx_buf still points
to it and is marked as valid (ICE_TX_BUF_SKB).
'next_to_use' remains unchanged, so the potential problem will
likely fix itself when the next packet is transmitted and the tx_buf
gets overwritten. But if there is no next packet and the interface is
brought down instead, ice_clean_tx_ring() -> ice_unmap_and_free_tx_buf()
will find the tx_buf and free the skb for the second time.

The fix is to reset the tx_buf type to ICE_TX_BUF_EMPTY in the error
path, so that ice_unmap_and_free_tx_buf().
Move the initialization of 'first' up, to ensure it's already valid in
case we hit the linearization error path.

The bug was spotted by AI while I had it looking for something else.
It also proposed an initial version of the patch.

I reproduced the bug and tested the fix by adding code to inject
failures, on a build with KASAN.

I looked for similar bugs in related Intel drivers and did not find any.

Fixes: d76a60ba7afb ("ice: Add support for VLANs and offloads")
Assisted-by: Claude:claude-4.6-opus-high Cursor
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index a2cd4cf37734..7be9c062949b 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2158,6 +2158,9 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 
 	ice_trace(xmit_frame_ring, tx_ring, skb);
 
+	/* record the location of the first descriptor for this packet */
+	first = &tx_ring->tx_buf[tx_ring->next_to_use];
+
 	count = ice_xmit_desc_count(skb);
 	if (ice_chk_linearize(skb, count)) {
 		if (__skb_linearize(skb))
@@ -2183,8 +2186,6 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 
 	offload.tx_ring = tx_ring;
 
-	/* record the location of the first descriptor for this packet */
-	first = &tx_ring->tx_buf[tx_ring->next_to_use];
 	first->skb = skb;
 	first->type = ICE_TX_BUF_SKB;
 	first->bytecount = max_t(unsigned int, skb->len, ETH_ZLEN);
@@ -2249,6 +2250,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 out_drop:
 	ice_trace(xmit_frame_ring_drop, tx_ring, skb);
 	dev_kfree_skb_any(skb);
+	first->type = ICE_TX_BUF_EMPTY;
 	return NETDEV_TX_OK;
 }
 

-- 
2.53.0.1066.g1eceb487f285


