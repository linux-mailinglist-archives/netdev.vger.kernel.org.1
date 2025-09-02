Return-Path: <netdev+bounces-219359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B42A3B410B2
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7487F70025B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776F027CCE2;
	Tue,  2 Sep 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGhidM1A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C211271476
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855301; cv=none; b=T99fsze/cLhyYoULJF50G3vMLIl/9tsd96zkkitgDQ/1EU/jGjwlYEInUF5SCMXfMxj4gkBOe8E6he715wEkVdjHdum/3miF6t1WDK9cMgMmuKYAsCMuIzTWjiy/wCzPCVQ0/Ijx4extGMPxx4Pdq1BKQvwSwtITRq4rJdgY0KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855301; c=relaxed/simple;
	bh=/eOSo7Y2nIawUWn280natOE45hMwje8D+0VI/Vtmtv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQP5+IuJqlSvAV4niY0fjxgLULlD17wLEWPAukHg5u3+0zx8F061g3P4eoN4gPwL5VLVbzuzwCdqm3sOeIgDg+C0IwANRGc/vQO7y5xJ0AlXHveg92t2tBXCEHI1VJgfky/W7QDdvcbYs4kClAFuwjwbhYdbn7I8SWRYKQAGoxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGhidM1A; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756855299; x=1788391299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/eOSo7Y2nIawUWn280natOE45hMwje8D+0VI/Vtmtv8=;
  b=MGhidM1AEQgvDQz4fg8z5EPOhbszicPTQbDGsn/nsBnBSwJDmzC2e3jR
   H98yoqyRNPjrdIeM/CLj75/jBbmH8WGyUDCUcjcr1XlpZqX4QTZ9wY541
   NdkbecOfyDNfffrMQoWqv5fV9H80C3TiqgfDY64+jSz1zlp8kKsYjrf76
   Em/KZ1Er9VbtlEQkT++MgveL15tgMtEW85B18rqDud0/BRs173/vcXV9U
   wZVC7JAzAj0I4FkN3J97Tj1o8mR6kdrKuzpyL1hgGe2sGqaUZueihSHpo
   HPkVEufc4avRrkRw4I+0X8NeZoIeKlpRC+7DrrfGQEcepiXhEmfnrH2tH
   A==;
X-CSE-ConnectionGUID: nnVBV3mfSZqEM7A7iTTyIw==
X-CSE-MsgGUID: i5LK8C6+RGeMzrGTH3umog==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69767184"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="69767184"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 16:21:37 -0700
X-CSE-ConnectionGUID: 5Nfz+IJORs+o/uEW7tIvyg==
X-CSE-MsgGUID: jbuoyyKUQLa4ZPtB/rN2Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171575889"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 02 Sep 2025 16:21:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 1/8] ice: fix NULL access of tx->in_use in ice_ptp_ts_irq
Date: Tue,  2 Sep 2025 16:21:21 -0700
Message-ID: <20250902232131.2739555-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
References: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The E810 device has support for a "low latency" firmware interface to
access and read the Tx timestamps. This interface does not use the standard
Tx timestamp logic, due to the latency overhead of proxying sideband
command requests over the firmware AdminQ.

The logic still makes use of the Tx timestamp tracking structure,
ice_ptp_tx, as it uses the same "ready" bitmap to track which Tx
timestamps complete.

Unfortunately, the ice_ptp_ts_irq() function does not check if the tracker
is initialized before its first access. This results in NULL dereference or
use-after-free bugs similar to the following:

[245977.278756] BUG: kernel NULL pointer dereference, address: 0000000000000000
[245977.278774] RIP: 0010:_find_first_bit+0x19/0x40
[245977.278796] Call Trace:
[245977.278809]  ? ice_misc_intr+0x364/0x380 [ice]

This can occur if a Tx timestamp interrupt races with the driver reset
logic.

Fix this by only checking the in_use bitmap (and other fields) if the
tracker is marked as initialized. The reset flow will clear the init field
under lock before it tears the tracker down, thus preventing any
use-after-free or NULL access.

Fixes: f9472aaabd1f ("ice: Process TSYN IRQ in a separate function")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index e358eb1d719f..fb0f6365a6d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2701,16 +2701,19 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 		 */
 		if (hw->dev_caps.ts_dev_info.ts_ll_int_read) {
 			struct ice_ptp_tx *tx = &pf->ptp.port.tx;
-			u8 idx;
+			u8 idx, last;
 
 			if (!ice_pf_state_is_nominal(pf))
 				return IRQ_HANDLED;
 
 			spin_lock(&tx->lock);
-			idx = find_next_bit_wrap(tx->in_use, tx->len,
-						 tx->last_ll_ts_idx_read + 1);
-			if (idx != tx->len)
-				ice_ptp_req_tx_single_tstamp(tx, idx);
+			if (tx->init) {
+				last = tx->last_ll_ts_idx_read + 1;
+				idx = find_next_bit_wrap(tx->in_use, tx->len,
+							 last);
+				if (idx != tx->len)
+					ice_ptp_req_tx_single_tstamp(tx, idx);
+			}
 			spin_unlock(&tx->lock);
 
 			return IRQ_HANDLED;
-- 
2.47.1


