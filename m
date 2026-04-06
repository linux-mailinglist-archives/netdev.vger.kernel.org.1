Return-Path: <netdev+bounces-275751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJA0ClEm1Gn5rgcAu9opvQ
	(envelope-from <netdev+bounces-275751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:32:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A33E43A7907
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96BFE3066BC3
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 21:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1483538F622;
	Mon,  6 Apr 2026 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcZw/GER"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D7C38F254
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775511047; cv=none; b=jS9ZvhjLLMIQ8vFDDNysTfpljGS6OscTWZvwHjobOcZA3Jr/LFmpz5NP1CB5k0PvcIncxZoZrRbdLYt4Tjr42ZfFPmklUegc5Y7LyExwHBI1BLLU81foo5SWDk0c+Gi+s1w5fO6rmYIyH97bUwc7QZmC9fZFW5dLI+at5fDuwXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775511047; c=relaxed/simple;
	bh=lW4jm7xK0Xr0Jz6vN1z+av6txmPZ8JrrMo7XLj5eRhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAw3rboln/FHrZxc3TSpve+uq8sbwFsX962eqr9YSURosnf5O56i7ly2zuAKMoLV73HDtkypGTEo2CjeEgMrwghutXU3QqBPJW5CT9STJ4nERkET3O5lEapN7H38S20t5skKFR3qtkd63LHpXpN509G1aobDFHMAjRIXTVnT+YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcZw/GER; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775511045; x=1807047045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lW4jm7xK0Xr0Jz6vN1z+av6txmPZ8JrrMo7XLj5eRhY=;
  b=gcZw/GER11HNn71FFaO5SA/EYdpHrmau6i2an5xpOUE3kUyBrT+1eT4m
   yAb+o711jO3ywfLmnEwBNeTYruBiJwmSNcDvyNnT5aknbsv6N+MDGtuzX
   S2TvurfwZMqmFyBEKuv37Z0/pi6MKW+6TDSPaBqaJazzH6y11JXkuz2bV
   kJA9RvMQ4iWEejHIE04uQz/C3l4K0EgUbs9yxd/jRqWL9gfn2pLrjF8OO
   p67JhgvzGCb7Wk3DS1v66lk+RwCyNjA2k4SVSC4vWCKLGl9qbZEoUtCbw
   2C/w+Cg3+jCnA+LchP77DYFo88j2JZnoc25Bke5od6/4kpwqDqePPcO8Q
   w==;
X-CSE-ConnectionGUID: Y/2nPrklRCSWczEt7oLUTw==
X-CSE-MsgGUID: e2rjfgm4R0+cap/g/zTpAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="79057417"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="79057417"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 14:30:42 -0700
X-CSE-ConnectionGUID: 01ZaIAPUSAqCoxA6wywaaQ==
X-CSE-MsgGUID: msyUWJxbRziAAlnQMtErug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="228248111"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 06 Apr 2026 14:30:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	przemyslaw.kitszel@intel.com,
	ivecera@redhat.com,
	richardcochran@gmail.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net 5/9] ice: fix PTP timestamping broken by SyncE code on E825C
Date: Mon,  6 Apr 2026 14:30:32 -0700
Message-ID: <20260406213038.444732-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260406213038.444732-1-anthony.l.nguyen@intel.com>
References: <20260406213038.444732-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_CC(0.00)[redhat.com,intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275751-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A33E43A7907
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Petr Oros <poros@redhat.com>

The E825C SyncE support added in commit ad1df4f2d591 ("ice: dpll:
Support E825-C SyncE and dynamic pin discovery") introduced a SyncE
reconfiguration block in ice_ptp_link_change() that prevents
ice_ptp_port_phy_restart() from being called in several error paths.
Without the PHY restart, PTP timestamps stop working after any link
change event.

There are three ways the PHY restart gets blocked:

1. When DPLL initialization fails (e.g. missing ACPI firmware node
   properties), ICE_FLAG_DPLL is not set and the function returns early
   before reaching the PHY restart.

2. When ice_tspll_bypass_mux_active_e825c() fails to read the CGU
   register, WARN_ON_ONCE fires and the function returns early.

3. When ice_tspll_cfg_synce_ethdiv_e825c() fails to configure the
   clock divider for an active pin, same early return.

SyncE and PTP are independent features. SyncE reconfiguration failures
must not prevent the PTP PHY restart that is essential for timestamp
recovery after link changes.

Fix by making the entire SyncE block conditional on ICE_FLAG_DPLL
without an early return, and replacing the WARN_ON_ONCE + return error
handling inside the loop with dev_err_once + break. The function always
proceeds to ice_ptp_port_phy_restart() regardless of SyncE errors.

Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a3c5f0a5e09b..6cb0cf7a9891 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1296,12 +1296,10 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	if (pf->hw.reset_ongoing)
 		return;
 
-	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825) {
+	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
+	    test_bit(ICE_FLAG_DPLL, pf->flags)) {
 		int pin, err;
 
-		if (!test_bit(ICE_FLAG_DPLL, pf->flags))
-			return;
-
 		mutex_lock(&pf->dplls.lock);
 		for (pin = 0; pin < ICE_SYNCE_CLK_NUM; pin++) {
 			enum ice_synce_clk clk_pin;
@@ -1314,15 +1312,19 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 								port_num,
 								&active,
 								clk_pin);
-			if (WARN_ON_ONCE(err)) {
-				mutex_unlock(&pf->dplls.lock);
-				return;
+			if (err) {
+				dev_err_once(ice_pf_to_dev(pf),
+					     "Failed to read SyncE bypass mux for pin %d, err %d\n",
+					     pin, err);
+				break;
 			}
 
 			err = ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
-			if (active && WARN_ON_ONCE(err)) {
-				mutex_unlock(&pf->dplls.lock);
-				return;
+			if (active && err) {
+				dev_err_once(ice_pf_to_dev(pf),
+					     "Failed to configure SyncE ETH divider for pin %d, err %d\n",
+					     pin, err);
+				break;
 			}
 		}
 		mutex_unlock(&pf->dplls.lock);
-- 
2.47.1


