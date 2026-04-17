Return-Path: <netdev+bounces-279189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Du/KzSF4WkiuQAAu9opvQ
	(envelope-from <netdev+bounces-279189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:56:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41044415E2B
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24CBA30849A9
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 00:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBBB24336D;
	Fri, 17 Apr 2026 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iurct1bB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD20D23183B
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776387273; cv=none; b=OMQ3ka0t/sFAa/PvLn0q37tL+MgUc7mkzuIaifUn/t+3oyMflpfYOocmJUWS4QfR4lRFKzdFbXmbSmZbOJtgHbVvkdR9XzyrjaeDMmsiEZrE6DPknhpS+nHJlizUqcJX/q4D5bcppfxU62j8Qdq/CZ8515secp0iqrB118d1kyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776387273; c=relaxed/simple;
	bh=PqTxSDBORdWWiJS8F2YZ2eLGNM5H85zzBcZ8cJUiZG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k1/HW82LRnZqER2SrTbDu8bXmd2qB/Y+NxLt9p3P+i+C+l7R02xMHJgRpy5TKEyRjxYyZ0V2Q+m4nGGeasKnbWfD49xl7SY06b/EvYpPwmJvv5w+e+l4e22ESjVhY6s2bzYF/2vzHoQHkgpN49uRSGxo+LN2LCVvU7wMbTs98Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iurct1bB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776387273; x=1807923273;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PqTxSDBORdWWiJS8F2YZ2eLGNM5H85zzBcZ8cJUiZG4=;
  b=Iurct1bB9hPzdCBMmZgY4if7g+vjczmlRzDEOYv4L6SE/1wJ1HXPmiPo
   9INgIRujmVCMdLuS6EPe9FDEViXDRyoCul0W2S9p9rOVsGuWDWSBYYtDj
   m28pdEpYazblRWXhl1BRdRwSVRVP2uQNO954P253pNGeUkbFqEXaTEHbX
   jFXwMcJopF/50matiuWjGuTJm6cLukLu+IA29LNsEdeYcAuxEs08Az3PM
   +R8u1eNgufdf44v5WP8BfV6l6mIlXP4TXypyhsXxOvjpjOPq8nSVL8Szh
   Sn49NnvL0cn6l4CNpbaJ7jfUqsjvRrkBuoUOC4Z4AHJ/K3kqTimSAENTL
   w==;
X-CSE-ConnectionGUID: fIQKAkuVRBOq2SLJK0gaLw==
X-CSE-MsgGUID: 7/nandY2QQ+48Y1ESsVRVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="81000535"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="81000535"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:54:30 -0700
X-CSE-ConnectionGUID: vsvUwsHTS1uIeSDxclsOFA==
X-CSE-MsgGUID: eWCNVYaLSfquD+5O338CKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226539866"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:54:29 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 16 Apr 2026 17:53:28 -0700
Subject: [PATCH net v2 04/12] ice: fix double-free of tx_buf skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-iwl-net-submission-2026-04-14-v2-4-686c33c9828d@intel.com>
References: <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
In-Reply-To: <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Schmidt <mschmidt@redhat.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=YY3POxhFf7FQAw32R6+tn/opjIONU6ASN8H1kjNqte8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyHLQfXHaw47JbMJPboUJCQ6Y/reZNeb9U6JiA172P8v
 AffGWP+dZSyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRxH+MDBvqwucf1Zrapcu4
 KKfn3FqdjzN0knXur3lwTrNcMdHpbhbDb5aVXybHT/ywUtXhc/DWOWd8zti1x8udy2wVd745a78
 NAxsA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279189-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41044415E2B
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
2.54.0.rc2.531.gaf818d63126a


