Return-Path: <netdev+bounces-263465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA2/EwBrp2mWhQAAu9opvQ
	(envelope-from <netdev+bounces-263465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:13:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F8B1F84C5
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29EAC3041522
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 23:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209F4395D97;
	Tue,  3 Mar 2026 23:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ktl4iUwS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A39387584;
	Tue,  3 Mar 2026 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772579532; cv=none; b=PZc1cG1LNPWDydkwcvdIKtPg1u6fn3i1z2Y9aoMNuwnJ5tFp1gQgahwtS3ow1sQVTchRnObAE2S/aznuA7OY5o2bXYY/mnKibTX2vPwSg5JLHGTofdn1Dlm4KG+XTyCik7uhqDq2mD7pThdFT0KvTUKx65eQw2gG+tv9v/8naQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772579532; c=relaxed/simple;
	bh=Wq6z70rDqWKXpei+tfRZs6qyswbQ1EF6TzjhqWkJwME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBy3O/w6oYPoVW3B3fmaehsI0T+Nbz/bGQoQrofqXDj5L0BDv5xy+0UbJ0491NTQMHDAKRqu3P86KbRkskfPtlHnqTIsAbZxHNd7VMNGGx4P3DAoCyu7qdq8OXffrrKK6wXFI3TKl4lZibg2BHMOyEKWHHlhrFqWBv/HtO0R+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ktl4iUwS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772579528; x=1804115528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wq6z70rDqWKXpei+tfRZs6qyswbQ1EF6TzjhqWkJwME=;
  b=Ktl4iUwSZa4lbrb/KGtvG1NXr9W+ZE0aVF32FojUsRej8FaM0eOPqohQ
   lgXeXCTFJJeTVLuLPG8GJjG3yzLnL262ZHdLuTRPdNwGt6gPqnXDhFml0
   fFiIyNcDf3HZ9q6WlR7jDw455gtj3ohF7sczVLylvtQgx6iZQGWX4qrpq
   wEYn23jGiuyCCtfED852gdpUETQso2ImsWcoc5M1Kvxe/+nSOtUQSwNnH
   iKsNhR6zps1hafUC5x2MKvTa9+Yh+A2DktILS5o2ZoNsYY0J/1QJ/a2zB
   LQCWNtt8ZxkTFeBQu+LhkfEER5BXzo9rGE/kZ/OXZ1p9J+EsaPOc9OSVO
   w==;
X-CSE-ConnectionGUID: mGddAIymQqWvKFBJDuAdIA==
X-CSE-MsgGUID: XJoWs3teSXmEOd0xJT+C3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77238846"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="77238846"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 15:12:00 -0800
X-CSE-ConnectionGUID: OyNcPQ9BS8qZgKlMEkH+hg==
X-CSE-MsgGUID: KEogq1ZMRwagKDey1SA2KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="248633822"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 03 Mar 2026 15:12:00 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Vivek Behera <vivek.behera@siemens.com>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	vinicius.gomes@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	richardcochran@gmail.com,
	Jacob Keller <jacob.keller@intel.com>,
	Aleksandr loktinov <aleksandr.loktionov@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net 8/8] igc: Fix trigger of incorrect irq in igc_xsk_wakeup function
Date: Tue,  3 Mar 2026 15:11:54 -0800
Message-ID: <20260303231155.2895065-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
References: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D8F8B1F84C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[siemens.com,intel.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-263465-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Vivek Behera <vivek.behera@siemens.com>

This patch addresses the issue where the igc_xsk_wakeup function
was triggering an incorrect IRQ for tx-0 when the i226 is configured
with only 2 combined queues or in an environment with 2 active CPU cores.
This prevented XDP Zero-copy send functionality in such split IRQ
configurations.

The fix implements the correct logic for extracting q_vectors saved
during rx and tx ring allocation and utilizes flags provided by the
ndo_xsk_wakeup API to trigger the appropriate IRQ.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Fixes: 15fd021bc427 ("igc: Add Tx hardware timestamp request for AF_XDP zero-copy packet")
Signed-off-by: Vivek Behera <vivek.behera@siemens.com>
Reviewed-by: Jacob Keller <jacob.keller@intel.com>
Reviewed-by: Aleksandr loktinov <aleksandr.loktionov@intel.com>
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Song Yoong Siang <yoong.siang.song@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 34 ++++++++++++++++-------
 drivers/net/ethernet/intel/igc/igc_ptp.c  |  3 +-
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27e5c2109138..b2e8d0c0f827 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6906,28 +6906,29 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	return nxmit;
 }
 
-static void igc_trigger_rxtxq_interrupt(struct igc_adapter *adapter,
-					struct igc_q_vector *q_vector)
+static u32 igc_sw_irq_prep(struct igc_q_vector *q_vector)
 {
-	struct igc_hw *hw = &adapter->hw;
 	u32 eics = 0;
 
-	eics |= q_vector->eims_value;
-	wr32(IGC_EICS, eics);
+	if (!napi_if_scheduled_mark_missed(&q_vector->napi))
+		eics = q_vector->eims_value;
+
+	return eics;
 }
 
 int igc_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 {
 	struct igc_adapter *adapter = netdev_priv(dev);
-	struct igc_q_vector *q_vector;
+	struct igc_hw *hw = &adapter->hw;
 	struct igc_ring *ring;
+	u32 eics = 0;
 
 	if (test_bit(__IGC_DOWN, &adapter->state))
 		return -ENETDOWN;
 
 	if (!igc_xdp_is_enabled(adapter))
 		return -ENXIO;
-
+	/* Check if queue_id is valid. Tx and Rx queue numbers are always same */
 	if (queue_id >= adapter->num_rx_queues)
 		return -EINVAL;
 
@@ -6936,9 +6937,22 @@ int igc_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 	if (!ring->xsk_pool)
 		return -ENXIO;
 
-	q_vector = adapter->q_vector[queue_id];
-	if (!napi_if_scheduled_mark_missed(&q_vector->napi))
-		igc_trigger_rxtxq_interrupt(adapter, q_vector);
+	if (flags & XDP_WAKEUP_RX)
+		eics |= igc_sw_irq_prep(ring->q_vector);
+
+	if (flags & XDP_WAKEUP_TX) {
+		/* If IGC_FLAG_QUEUE_PAIRS is active, the q_vector
+		 * and NAPI is shared between RX and TX.
+		 * If NAPI is already running it would be marked as missed
+		 * from the RX path, making this TX call a NOP
+		 */
+		ring = adapter->tx_ring[queue_id];
+		eics |= igc_sw_irq_prep(ring->q_vector);
+	}
+
+	if (eics)
+		/* Cause software interrupt */
+		wr32(IGC_EICS, eics);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 7aae83c108fd..44ee19386766 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -550,7 +550,8 @@ static void igc_ptp_free_tx_buffer(struct igc_adapter *adapter,
 		tstamp->buffer_type = 0;
 
 		/* Trigger txrx interrupt for transmit completion */
-		igc_xsk_wakeup(adapter->netdev, tstamp->xsk_queue_index, 0);
+		igc_xsk_wakeup(adapter->netdev, tstamp->xsk_queue_index,
+			       XDP_WAKEUP_TX);
 
 		return;
 	}
-- 
2.47.1


