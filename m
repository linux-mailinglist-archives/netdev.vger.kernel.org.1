Return-Path: <netdev+bounces-280950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O9EIZYL62lJHwAAu9opvQ
	(envelope-from <netdev+bounces-280950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 08:20:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0D045A309
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 08:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D76B30039BE
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 06:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE6F342523;
	Fri, 24 Apr 2026 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkZwKtJM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB719C556
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777011603; cv=none; b=WNYvZ3T2I+Kylh4d+Oq37NS75XZvEh4Kkphwr+lVZkRFoqJ/l0qCDJoexhseT/Kw7S9kQk8Hts0pbSI6nJqoymQMlcX+VH0AlQ/c6FWW0g+uN74F25GG75L2q9KUlOOxHsMmZV/FsEP1p7J5qCGYHzPSLdMCIBPZtlo8PeC0jL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777011603; c=relaxed/simple;
	bh=8FCSqw0T65YwOTutmJofsBTnijCoHEsSgp28t0Ta0y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3wPXig5t1i4HVuX5ASy7Ly+43ERMBZ1TmAKVg7PAI8sLmz6aTvL2rMN7oBUPeRA5B1UeewPeXQcXDAETK6zpr/bCoDJxcj33zvBtan/3HZbtWTJSp0SKKRJWa6VlhGwk/TNE31qkBAdUSnbkz0g+iZ5qp7qKHGXDk0EH77kmRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkZwKtJM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777011603; x=1808547603;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8FCSqw0T65YwOTutmJofsBTnijCoHEsSgp28t0Ta0y8=;
  b=KkZwKtJMCsVWBCOzwxf/Bcvawk9JzX3Wj0JEEOMym0B7vUxx9nKDNM0R
   7Rt1lSXuno1Qcq4q+C1c0WlmnI7Ln9xybq/e3P3seu94WtDbIPLLXo/qC
   i5L/8XDj2h4UC1R5ULD2tdXGA+bh4F2qmiKHLc7IGpWtENeRZOsa2qE+k
   lF5XyjGp8kispvdanVmR3FJpZ8N9vh6scMxZZX3qyegfna/DhODvfG9Bv
   qcHgtv9O3og52jZQG18SMiRqPB/oKu2skDcjDPhTL14D5LdIuMSrH++Q/
   tU0dJ0dMHVKVhSTBgl0wBlwJkKqAku0h9x1afFiKnAYYlT+QMrYT9uKZS
   g==;
X-CSE-ConnectionGUID: vvTpqjsMT+2r6QXZGTQJ1g==
X-CSE-MsgGUID: 6WWgrC6FSmOCXZHCXmp8bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77873869"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="77873869"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:20:02 -0700
X-CSE-ConnectionGUID: mEILhK05RXm4qLMwAgUi1Q==
X-CSE-MsgGUID: xV8i61CmSK25qX6dTMnf4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="232776879"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 23 Apr 2026 23:20:01 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH iwl-net] ice: only free LL TS IRQ when the handler is present
Date: Fri, 24 Apr 2026 08:19:58 +0200
Message-ID: <20260424061958.918404-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A0D045A309
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280950-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

Free LL TS IRQ handler only when the handler was previously installed.
Unguarded calls to ice_free_irq_msix_ll_ts() may result in a double
free when the LL TS interrupt is not supported by the firmware because
ll_ts_irq.index is zero-initialised and would pass the index >= 0 check.

Track whether the LL TS IRQ was successfully requested by initialising
ll_ts_irq.index to -ENOENT in ice_init_pf() and when taking the
"not supported" skip path or on request failure, then guard the free
paths with ll_ts_irq.index >= 0.

Fixes: 82e71b226e0e ("ice: Enable SW interrupt from FW for LL TS")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3c36e36..cc3743a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3389,7 +3389,7 @@ static void ice_free_irq_msix_misc(struct ice_pf *pf)
 	devm_free_irq(ice_pf_to_dev(pf), misc_irq_num, pf);
 
 	ice_free_irq(pf, pf->oicr_irq);
-	if (pf->hw.dev_caps.ts_dev_info.ts_ll_int_read)
+	if (pf->ll_ts_irq.index >= 0)
 		ice_free_irq_msix_ll_ts(pf);
 }
 
@@ -3473,8 +3473,10 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 	}
 
 	/* reserve one vector in irq_tracker for ll_ts interrupt */
-	if (!pf->hw.dev_caps.ts_dev_info.ts_ll_int_read)
+	if (!pf->hw.dev_caps.ts_dev_info.ts_ll_int_read) {
+		pf->ll_ts_irq.index = -ENOENT;
 		goto skip_req_irq;
+	}
 
 	irq = ice_alloc_irq(pf, false);
 	if (irq.index < 0)
@@ -3487,6 +3489,7 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 		dev_err(dev, "devm_request_irq for %s failed: %d\n",
 			pf->int_name_ll_ts, err);
 		ice_free_irq(pf, pf->ll_ts_irq);
+		pf->ll_ts_irq.index = -ENOENT;
 		return err;
 	}
 
@@ -3496,7 +3499,7 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 	ice_ena_ctrlq_interrupts(hw, pf->oicr_irq.index);
 	/* This enables LL TS interrupt */
 	pf_intr_start_offset = rd32(hw, PFINT_ALLOC) & PFINT_ALLOC_FIRST;
-	if (pf->hw.dev_caps.ts_dev_info.ts_ll_int_read)
+	if (pf->ll_ts_irq.index >= 0)
 		wr32(hw, PFINT_SB_CTL,
 		     ((pf->ll_ts_irq.index + pf_intr_start_offset) &
 		      PFINT_SB_CTL_MSIX_INDX_M) | PFINT_SB_CTL_CAUSE_ENA_M);
@@ -4090,6 +4093,7 @@ int ice_init_pf(struct ice_pf *pf)
 	 * the misc functionality and queue processing is combined in
 	 * the same vector and that gets setup at open.
 	 */
+	pf->ll_ts_irq.index = -ENOENT;
 	err = ice_req_irq_msix_misc(pf);
 	if (err) {
 		dev_err(dev, "setup of misc vector failed: %d\n", err);
-- 
2.52.0


