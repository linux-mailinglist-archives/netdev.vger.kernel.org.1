Return-Path: <netdev+bounces-259987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPzxGEornGmcAQQAu9opvQ
	(envelope-from <netdev+bounces-259987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:26:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C56ED174D5B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57344307721F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147A35B63B;
	Mon, 23 Feb 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GaZNKIx1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DFD35B656;
	Mon, 23 Feb 2026 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842182; cv=none; b=BDDq/K4DQGkMJ+ciRb+2TXocVqhTv7suWmAqZ3N+6mRuTMoz+swtUdADOOs8UBBYJ8wCXV91SGbGOZ9aoKzS5w997u8ZUNYiK6LDCZgylxxNvoH8Y6JNWFdtAizfZFBPaZbdoVK/l7S2kPyIij2mk3Nm1BukWFUc5K6vEPFQDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842182; c=relaxed/simple;
	bh=PhZmw2HezwgE5pFRtdOSxaDFfThUcjyd1oY4SxpvDQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNkHwcVC/cxuRC6UX08KEQ2FJfFT1hWOguGimiqzkoZoxYObJTvrB0h2T/3AsfItyH7nwZwj55mKRwynx8elp092NnIiataiWVBglbqa6WplwhHPCBloNUmG00ZRr0+Xl0lZPwfso0GpwcyokdT9cX9I3O6vS5zh4nfCBeOvnxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GaZNKIx1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771842176; x=1803378176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PhZmw2HezwgE5pFRtdOSxaDFfThUcjyd1oY4SxpvDQk=;
  b=GaZNKIx1iI5+TqE1XlrxN6sou0Cz/OKXUwFtaMh4Hwh0o4rlvKvMP/tz
   kkrNSiOD5kWK+t1o0Mm4pdJcw9sy9nQem6Z2cubqF/LMt8NethEmZOdxy
   eVAJVPdnO5uUEbPpNpQsomt3y+GdJez6SE+cnW4Y/ny8gNpxtUsu29/RW
   bqjab+Hl9eD6HGf41fiw8wgsuVOhYDC8jhtZS0wnAUEB7/nbDhJp4HHpb
   98P0nj+bi1q5+L5+L1EQjR1fRIdxBnm55CorO8tOoLb2EYCxlVFX/2OOX
   38U/iZRX09FzvHX+BF0jxeRFebXH92VvRW4U5nxMz/o45Q399T2rW07tV
   Q==;
X-CSE-ConnectionGUID: HqkzESLTT8i3lAQ0/mB7Rw==
X-CSE-MsgGUID: 8KNkEhOtSNiIyfxjw1wcQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="76444720"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="76444720"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 02:22:55 -0800
X-CSE-ConnectionGUID: 8u7F0LlCR3qRjeI9gQ1A4g==
X-CSE-MsgGUID: p2KXPAsoSUCEVswHJN9s+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="246121746"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 23 Feb 2026 02:22:51 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id EACD328169;
	Mon, 23 Feb 2026 10:22:48 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Natalia Wochtman <natalia.wochtman@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next 04/10] ixgbevf: branch prediction and cleanup
Date: Mon, 23 Feb 2026 10:52:11 +0100
Message-ID: <20260223095222.3205363-5-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223095222.3205363-1-larysa.zaremba@intel.com>
References: <20260223095222.3205363-1-larysa.zaremba@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259987-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C56ED174D5B
X-Rspamd-Action: no action

Add likely/unlikely markers for better branch prediction. While touching
some functions, cleanup the code a little bit.

This patch is not supposed to make any logic changes.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 24b8f4bb415b..39124c430537 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -570,7 +570,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 	u16 ntu = rx_ring->next_to_use;
 
 	/* nothing to do or no valid netdev defined */
-	if (!cleaned_count || !rx_ring->netdev)
+	if (unlikely(!cleaned_count || !rx_ring->netdev))
 		return;
 
 	rx_desc = IXGBEVF_RX_DESC(rx_ring, ntu);
@@ -586,7 +586,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 
 		rx_desc++;
 		ntu++;
-		if (unlikely(ntu == rx_ring->count)) {
+		if (unlikely(ntu == fq.count)) {
 			rx_desc = IXGBEVF_RX_DESC(rx_ring, 0);
 			ntu = 0;
 		}
@@ -823,7 +823,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 
 		rx_desc = IXGBEVF_RX_DESC(rx_ring, rx_ring->next_to_clean);
 		size = le16_to_cpu(rx_desc->wb.upper.length);
-		if (!size)
+		if (unlikely(!size))
 			break;
 
 		/* This memory barrier is needed to keep us from reading
@@ -855,7 +855,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		}
 
 		/* exit if we failed to retrieve a buffer */
-		if (!xdp_res && !skb) {
+		if (unlikely(!xdp_res && !skb)) {
 			rx_ring->rx_stats.alloc_rx_buff_failed++;
 			break;
 		}
@@ -867,21 +867,19 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 			continue;
 
 		/* verify the packet layout is correct */
-		if (xdp_res || ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
+		if (xdp_res ||
+		    unlikely(ixgbevf_cleanup_headers(rx_ring, rx_desc, skb))) {
 			skb = NULL;
 			continue;
 		}
 
-		/* probably a little skewed due to removing CRC */
-		total_rx_bytes += skb->len;
-
 		/* Workaround hardware that can't do proper VEPA multicast
 		 * source pruning.
 		 */
-		if ((skb->pkt_type == PACKET_BROADCAST ||
-		     skb->pkt_type == PACKET_MULTICAST) &&
-		    ether_addr_equal(rx_ring->netdev->dev_addr,
-				     eth_hdr(skb)->h_source)) {
+		if (unlikely((skb->pkt_type == PACKET_BROADCAST ||
+			      skb->pkt_type == PACKET_MULTICAST) &&
+			     ether_addr_equal(rx_ring->netdev->dev_addr,
+					      eth_hdr(skb)->h_source))) {
 			dev_kfree_skb_irq(skb);
 			continue;
 		}
@@ -889,13 +887,14 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		/* populate checksum, VLAN, and protocol */
 		ixgbevf_process_skb_fields(rx_ring, rx_desc, skb);
 
+		/* probably a little skewed due to removing CRC */
+		total_rx_bytes += skb->len;
+		total_rx_packets++;
+
 		ixgbevf_rx_skb(q_vector, skb);
 
 		/* reset skb pointer */
 		skb = NULL;
-
-		/* update budget accounting */
-		total_rx_packets++;
 	}
 
 	/* place incomplete frames back on ring for completion */
-- 
2.52.0


