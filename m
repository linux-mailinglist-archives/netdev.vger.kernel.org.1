Return-Path: <netdev+bounces-288432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBHlCEZuB2rY2gIAu9opvQ
	(envelope-from <netdev+bounces-288432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:04:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CAD556934
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15EDB3001A43
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD529385D77;
	Fri, 15 May 2026 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HMFoZgRx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA9386C0D
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871866; cv=none; b=ahr6KlIliAgOCskdoYeavKvy5W2Uz7vuc0zVpdIM2tB0G/Pe6lrDPJrCyDGuy1k8m1bIakb0TOk9OWVJ+VOfHrA4Nf3blXQjSHEZHBgfYmuTYKYRfYeo6nqYdvjpjacmEcih7A8HmwgYZ23ja2nAsCXWzMT2Q/aq4Bwx5o84uOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871866; c=relaxed/simple;
	bh=KWAoFAF1GvnTMMC9rlxROg6EOORDVvCfaTHCIrglN3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+nlLcj5Pno8/6IBuaFlXHThmsT8xak0Z0ZThE078nHRTYD59Peznp3vT9BIYaHioHTqL2h7EJpgLZKD8LCDNDKgPk1QhKfsaZrh/qICALZRH3ORDhzPcoRKlc4flouf0HldFKRRCymsiQHAQnpXQKFRtzf7qE/WyoOsin21Bpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HMFoZgRx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778871866; x=1810407866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KWAoFAF1GvnTMMC9rlxROg6EOORDVvCfaTHCIrglN3k=;
  b=HMFoZgRxkwPmJ0YA74H2UnjubNjbz4CbPw/xxswZxMPTefwEZwhuuZuP
   Y0+4dgVtVwh+D6yF5vzfJcZmAyFcS0zdC5wqL1efcssjSIonYEcgjfZuL
   AX6nF0Lq90QHPObK4VE3OO7LWjOXbUsk8bCN4lWn38WVsOD0TJngbfS/I
   JshPwQlfKgPDNzyU9PCuifHK8qUAr0otoqEyCUjVCtbrZVm9nDyebU6xg
   JHpXi97ctuPehpqGukKwqc0JaVXtggfzMXAVSURR0XqiP6cu93y0SsglB
   C2LODIwxsTpnVVu1P4cyQ+akT5OCloZgb/9J7Owo6evW8cZa1/apCpo5S
   Q==;
X-CSE-ConnectionGUID: SY5xjhTdRmGy0/xJmF5lJg==
X-CSE-MsgGUID: X7wPm1Y3QYy5kehJPDIrYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79725703"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79725703"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 12:04:25 -0700
X-CSE-ConnectionGUID: sp2pY6EtQMmSz3VTHjW0CQ==
X-CSE-MsgGUID: T+i9RlrySPKz4DA9H2wTlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238895633"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa009.jf.intel.com with ESMTP; 15 May 2026 12:04:23 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v5 3/4] ixgbe: fix ITR value overflow in adaptive interrupt throttling
Date: Fri, 15 May 2026 21:04:16 +0200
Message-ID: <20260515090000.5112345-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515090000.5112345-1-aleksandr.loktionov@intel.com>
References: <20260515090000.5112345-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 62CAD556934
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-288432-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

ixgbe_update_itr() packs a mode flag (IXGBE_ITR_ADAPTIVE_LATENCY,
bit 7) and a usecs delay (bits [6:0]) into an unsigned int, then
stores the combined value in ring_container->itr which is declared as
u8.  Values above 0xFF wrap on truncation, corrupting both the delay
and the mode flag on the next readback.

Keep the mode bit (IXGBE_ITR_ADAPTIVE_LATENCY) and the usec delay as
separate operands in the final store expression.  Clamp only the usecs
portion to [IXGBE_ITR_ADAPTIVE_MIN_USECS, IXGBE_ITR_ADAPTIVE_MAX_USECS]
using clamp_val() so that:
 - overflow cannot bleed into the mode bit (bit 7),
 - the delay cannot exceed 126 us (IXGBE_ITR_ADAPTIVE_MAX_USECS),
 - the delay cannot drop below 10 us (IXGBE_ITR_ADAPTIVE_MIN_USECS).

Fixes: b4ded8327fea ("ixgbe: Update adaptive ITR algorithm")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2 -> v3:
 - Use clamp_val() instead of min_t() to also guard the lower bound
   (IXGBE_ITR_ADAPTIVE_MIN_USECS); keep mode and delay as separate
   operands until final store; use IXGBE_ITR_ADAPTIVE_MAX_USECS (126)
   as upper bound instead of IXGBE_ITR_ADAPTIVE_LATENCY - 1 (127)
   (Simon Horman).

v1 -> v2:
 - Add proper [N/M] numbering so patchwork tracks it as part of the set;
   no code change.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 +++++++---
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..9f3ae21 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2886,11 +2886,17 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 			    IXGBE_ITR_ADAPTIVE_MIN_INC * 64) *
 		       IXGBE_ITR_ADAPTIVE_MIN_INC;
 		break;
 	}
 
 clear_counts:
-	/* write back value */
-	ring_container->itr = itr;
+	/* Separate mode bit (IXGBE_ITR_ADAPTIVE_LATENCY) from usec delay;
+	 * clamp delay to [MIN_USECS, MAX_USECS] before storing to prevent
+	 * u8 truncation from corrupting the mode flag or delay on readback.
+	 */
+	ring_container->itr = (itr & IXGBE_ITR_ADAPTIVE_LATENCY) |
+		clamp_val(itr & ~IXGBE_ITR_ADAPTIVE_LATENCY,
+			  IXGBE_ITR_ADAPTIVE_MIN_USECS,
+			  IXGBE_ITR_ADAPTIVE_MAX_USECS);
 
 	/* next update should occur within next jiffy */
 	ring_container->next_update = next_update + 1;
-- 
2.52.0

