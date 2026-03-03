Return-Path: <netdev+bounces-263464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEj3If1qp2mWhQAAu9opvQ
	(envelope-from <netdev+bounces-263464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:13:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AEE1F84B5
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A3EC307FFCB
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 23:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7394D39A063;
	Tue,  3 Mar 2026 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NnKqQRXt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72A39A055;
	Tue,  3 Mar 2026 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772579529; cv=none; b=qj9hdDyH8568gi5Eg2p7j13JfuxvBODAR1Px7irBMLKb3LMc6DxwHXkXIHBrWpu4DBpoaQnh7j6ryrcLMcBk85OY4oAWQD9KtKoJuvMkWIpV6qXidn3nz67czIs8ZGcMDXnh+aGz0nNqq0S1tDkgZuKSU+MoFJpdYzgmhfEEyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772579529; c=relaxed/simple;
	bh=it3J/LZ+wo2pUMheg6nqBzMIFIy4vXVvGzIzuw8Kokg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDs7nurCXsPE6DKYAIJTbtI21RMLQgmW59expmzGyUuyFFY2d0P8w7+iJ97dXnS6Znt3m/exxiCl2FmlYuU8Q7yzyTcC7+zZMcdH0+Tyv/5n+sik+L75edhns+oHHyTYzg+g45paW9Pk5jaxNd1/uic840XoYpAWbwBDokbDBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NnKqQRXt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772579526; x=1804115526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=it3J/LZ+wo2pUMheg6nqBzMIFIy4vXVvGzIzuw8Kokg=;
  b=NnKqQRXtzFFoOnrxtymNLZQhzyf2XXJiD6bHASAH77n8ejb0+tSjLzrj
   8EiPJ6+yfYm4eduhg0HDdQQXo5GKRsucNFzgeFCL+/jkV804Hh/H3bXSu
   7SYL515jttMelXDNdfI3hC/clDpNCFZwNWMQRXvd1/CHGvuccq6O9D08Z
   Q6QZo16cjy/8iWtpBSEKTp1tyfgtOpfWEcTNqu+ZndKwfl7r/nOYJ75Es
   Jx8yyXQzvBpM7zTY/D5ECQ2nRamqmn2Il30BlxU1kNRP8zl8OLw6aq4Ww
   3lusTbV9ujkeGox19tbf/HR36n3jqEkZQC7NXZHg0SHwpGezj71HdqsMx
   w==;
X-CSE-ConnectionGUID: e+gDLSB0TgCaR5qfyIEh4g==
X-CSE-MsgGUID: 7jnLlxgnQ0e77+kpNCLx8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77238834"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="77238834"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 15:11:59 -0800
X-CSE-ConnectionGUID: tdNHAytXSZGrM/X4bXSC7w==
X-CSE-MsgGUID: 768EK7aBRFmIlcHH+ULJZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="248633818"
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
	jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	kurt@linutronix.de,
	sriram.yagnaraman@ericsson.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Saritha Sanigani <sarithax.sanigani@intel.com>
Subject: [PATCH net 7/8] igb: Fix trigger of incorrect irq in igb_xsk_wakeup
Date: Tue,  3 Mar 2026 15:11:53 -0800
Message-ID: <20260303231155.2895065-8-anthony.l.nguyen@intel.com>
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
X-Rspamd-Queue-Id: 28AEE1F84B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[siemens.com,intel.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,linutronix.de,ericsson.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-263464-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Vivek Behera <vivek.behera@siemens.com>

The current implementation in the igb_xsk_wakeup expects
the Rx and Tx queues to share the same irq. This would lead
to triggering of incorrect irq in split irq configuration.
This patch addresses this issue which could impact environments
with 2 active cpu cores
or when the number of queues is reduced to 2 or less

cat /proc/interrupts | grep eno2
 167:          0          0          0          0 IR-PCI-MSIX-0000:08:00.0
 0-edge      eno2
 168:          0          0          0          0 IR-PCI-MSIX-0000:08:00.0
 1-edge      eno2-rx-0
 169:          0          0          0          0 IR-PCI-MSIX-0000:08:00.0
 2-edge      eno2-rx-1
 170:          0          0          0          0 IR-PCI-MSIX-0000:08:00.0
 3-edge      eno2-tx-0
 171:          0          0          0          0 IR-PCI-MSIX-0000:08:00.0
 4-edge      eno2-tx-1

Furthermore it uses the flags input argument to trigger either rx, tx or
both rx and tx irqs as specified in the ndo_xsk_wakeup api documentation

Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
Signed-off-by: Vivek Behera <vivek.behera@siemens.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Saritha Sanigani <sarithax.sanigani@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_xsk.c | 38 +++++++++++++++++++-----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 30ce5fbb5b77..ce4a7b58cad2 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -524,6 +524,16 @@ bool igb_xmit_zc(struct igb_ring *tx_ring, struct xsk_buff_pool *xsk_pool)
 	return nb_pkts < budget;
 }
 
+static u32 igb_sw_irq_prep(struct igb_q_vector *q_vector)
+{
+	u32 eics = 0;
+
+	if (!napi_if_scheduled_mark_missed(&q_vector->napi))
+		eics = q_vector->eims_value;
+
+	return eics;
+}
+
 int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 {
 	struct igb_adapter *adapter = netdev_priv(dev);
@@ -542,20 +552,32 @@ int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 
 	ring = adapter->tx_ring[qid];
 
-	if (test_bit(IGB_RING_FLAG_TX_DISABLED, &ring->flags))
-		return -ENETDOWN;
-
 	if (!READ_ONCE(ring->xsk_pool))
 		return -EINVAL;
 
-	if (!napi_if_scheduled_mark_missed(&ring->q_vector->napi)) {
+	if (flags & XDP_WAKEUP_TX) {
+		if (test_bit(IGB_RING_FLAG_TX_DISABLED, &ring->flags))
+			return -ENETDOWN;
+
+		eics |= igb_sw_irq_prep(ring->q_vector);
+	}
+
+	if (flags & XDP_WAKEUP_RX) {
+		/* If IGB_FLAG_QUEUE_PAIRS is active, the q_vector
+		 * and NAPI is shared between RX and TX.
+		 * If NAPI is already running it would be marked as missed
+		 * from the TX path, making this RX call a NOP
+		 */
+		ring = adapter->rx_ring[qid];
+		eics |= igb_sw_irq_prep(ring->q_vector);
+	}
+
+	if (eics) {
 		/* Cause software interrupt */
-		if (adapter->flags & IGB_FLAG_HAS_MSIX) {
-			eics |= ring->q_vector->eims_value;
+		if (adapter->flags & IGB_FLAG_HAS_MSIX)
 			wr32(E1000_EICS, eics);
-		} else {
+		else
 			wr32(E1000_ICS, E1000_ICS_RXDMT0);
-		}
 	}
 
 	return 0;
-- 
2.47.1


