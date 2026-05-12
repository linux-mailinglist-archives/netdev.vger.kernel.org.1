Return-Path: <netdev+bounces-287193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP7uMBg9A2oq2AEAu9opvQ
	(envelope-from <netdev+bounces-287193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:45:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E85AF522D7C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 198AB3099814
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DE93AB5D0;
	Tue, 12 May 2026 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4ACGW+0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A80B3A83BD
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594955; cv=none; b=JAnXkQSbd+tXi+0Uybs8kdJWFqU2WScNW+n1J0hYIJPBbJEMXhHhpLZy1BuUN5kEbZqk05BlHq1PUZ2wbVZ0t8+RZTR5dl5NRZvsrBWyK4DEO9+giJM6ABDL7jOC+m1GJ3SPsQQLxH5pwBhP5ODT3dVtGWNyQ6QItRK9blzP7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594955; c=relaxed/simple;
	bh=f+cnbiB4fpHGYtE/osVmWXJrV/zk9d7Jo6pGyD1jSc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQfVs2NIXcae1WGPQUjQOtN2UWn1/pmhvlLldc8K89TCI2/gNig5kHjuo4NGb5Mu5LPTHPpNu5U+K8wIjLNlsnqU6zJU90yVkECKoJhLaDDW0mT7m/gwaOiPfjrSfMYdoOc8j70PHUPThwoOrXNaUT7IQnxgNq0jmBD2TGb5YMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4ACGW+0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778594954; x=1810130954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f+cnbiB4fpHGYtE/osVmWXJrV/zk9d7Jo6pGyD1jSc0=;
  b=P4ACGW+07KD7rCbNj14fA1PrsCnuDgZ3tI+e3KqNXsCSbSAyHzCLcHor
   0fWjVirwWkoWNVEd0OmVSWIcR/vKjoiwZA8nMO31QdU8Tsu0gj/sbGk+p
   Kc/obQovaSjd/6DLzRu+E6LtR+E9b3/jIDv0josRwM1iEuakGY7o0SJ9f
   ZNT98if7YnYmFaPJNTsb7hW2/FwIG7Y/YyNxu1WaFI5wUQ+bHDXy/qZ6h
   GQXfHLVPY6EVRVOH1K+8JvP4ScsRhham6KlluRszdhin7zpVtU+ELV5WW
   4dkU/Tl2PDROzyoH4zuXPvRTCEB4SGNQ/TPpZUZv6bXvEDYwuMH0JkaYY
   Q==;
X-CSE-ConnectionGUID: KjlCBzzuT9SNT2io37ao8A==
X-CSE-MsgGUID: imKDA2lOSS2vy73M08z8Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="96929666"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="96929666"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:09:14 -0700
X-CSE-ConnectionGUID: Vxwu3oBHT9S610l3zT+s+w==
X-CSE-MsgGUID: 8AOD/5RLTm6R2thPkFOAAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="275892484"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 12 May 2026 07:09:13 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 4/8] ixgbe: increase SECRX_RDY polling frequency in ixgbe_disable_rx_buff_generic
Date: Tue, 12 May 2026 16:09:00 +0200
Message-ID: <20260512140904.4105236-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
References: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E85AF522D7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287193-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

From: Maciej Rabeda <maciej.rabeda@intel.com>

ixgbe_disable_rx_buff_generic polls for SECRX_RDY with 40 iterations
and a 1000 us (1 ms) busy-wait per iteration via udelay(), giving an
exact total wait of 40 ms.  On fast hardware the security block is
typically ready well under 1 ms, so each iteration wastes up to
999 us of stalled initialization time.

Replace udelay(1000) with usleep_range(10, 20) and raise the iteration
limit to 4000.  Because usleep_range(min, max) is guaranteed to sleep
at least 'min' microseconds, 4000 * 10 us preserves the original 40 ms
minimum wait before timeout.  The nominal worst-case rises to ~80 ms
(4000 * 20 us); on a loaded system actual scheduler wakeup latency may
push this higher.  This is acceptable because SECRX_RDY failing to
assert is a non-fatal informational condition: the function just logs
a debug message and returns success.

On platforms where SECRX_RDY asserts quickly this reduces the typical
stall from up to ~1 ms per iteration to ~10-20 us.  The function is
called only from process context, so usleep_range is appropriate.

Signed-off-by: Maciej Rabeda <maciej.rabeda@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 3ea6765..c85618c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -2683,7 +2683,7 @@ int prot_autoc_write_generic(struct ixgbe_hw *hw, u32 reg_val, bool locked)
  **/
 int ixgbe_disable_rx_buff_generic(struct ixgbe_hw *hw)
 {
-#define IXGBE_MAX_SECRX_POLL 40
+#define IXGBE_MAX_SECRX_POLL 4000
 	int i;
 	int secrxreg;
 
@@ -2695,8 +2695,7 @@ int ixgbe_disable_rx_buff_generic(struct ixgbe_hw *hw)
 		if (secrxreg & IXGBE_SECRXSTAT_SECRX_RDY)
 			break;
 		else
-			/* Use interrupt-safe sleep just in case */
-			udelay(1000);
+			usleep_range(10, 20);
 	}
 
 	/* For informational purposes only */
-- 
2.52.0


