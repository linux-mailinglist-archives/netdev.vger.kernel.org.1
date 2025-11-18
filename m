Return-Path: <netdev+bounces-239747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E99C6C0E5
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 00:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E0FA355F61
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C2D31326A;
	Tue, 18 Nov 2025 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAgyfFjF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55FD2F90CD
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763509940; cv=none; b=cJSR+URNEaQ+0kioZLPyys+TAN+SsZyw/LzURO+oZynGJS3ckokhfDRPsEGZKrF1erYkRmB7/0mmLh5mzbWMfp22MhZb4LvInInpaMUxH6wNzClW4FWMF5ZWIRfhD+I2g0UI2u2yU/61UvtwGPjyZyWwJja4vizSLs7RNkSXfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763509940; c=relaxed/simple;
	bh=xBLD5bbZuhtxGf7Z1Oik+VEzzzAw24C540EMOQw9jqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWtvnffHA1rA2YFVZJNqRds7YJ0W5JOQv57FQEGC0XmmEh2aUbe0UhFFGJp14EeICdXfb68P66lbBDJNH3G/qwTS2lnlFZTtXs1wAycStlnPy6SZykLemkNBWDam93b2nWebD8D4EtKGDzzzaCgaLVcLQMdw8bDLC/VqyZrXomk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAgyfFjF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763509939; x=1795045939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xBLD5bbZuhtxGf7Z1Oik+VEzzzAw24C540EMOQw9jqU=;
  b=GAgyfFjFBUBRoJ7aLD7uEooUSHLETlRKuSJ9YGy1jAXMvn+IY5M2PKs6
   qjHMNpTzdPXZoxmnn0UxxuybysN+bKQVJox+ShBtPCNnQ+EtIudPjmWtI
   FKVio5eJlGwrYbl9RLF/m1xhkssHytbFkamceWYcjRyrlCGAewXSSovut
   m+cuf7TZ+D1TaJCDSg87ujN/luTfPcHCFle5mnCXQOpXC7oibp2kF6lgI
   khqal4cPn+cZ/ufnFALujCtDHiOlvUniHHQzEziPc7KfcirCrYTvr64t7
   rvek8NohWvDOwgBbs9yHYY/p1oEd6YRuWU/U+se2cGPFpbraItRYrHOKt
   A==;
X-CSE-ConnectionGUID: /ian/1T2TuSNaPlOrz3C1w==
X-CSE-MsgGUID: nyABfb7HRgqSwttq90+dXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76225841"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76225841"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:52:16 -0800
X-CSE-ConnectionGUID: gUw07IWQRiuo4/IZ0lGCVg==
X-CSE-MsgGUID: GemtlG73QIu+mtnKKMiYNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190699495"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 18 Nov 2025 15:52:16 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	przemyslaw.kitszel@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 2/2] ice: fix PTP cleanup on driver removal in error path
Date: Tue, 18 Nov 2025 15:52:05 -0800
Message-ID: <20251118235207.2165495-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251118235207.2165495-1-anthony.l.nguyen@intel.com>
References: <20251118235207.2165495-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Improve the cleanup on releasing PTP resources in error path.
The error case might happen either at the driver probe and PTP
feature initialization or on PTP restart (errors in reset handling, NVM
update etc). In both cases, calls to PF PTP cleanup (ice_ptp_cleanup_pf
function) and 'ps_lock' mutex deinitialization were missed.
Additionally, ptp clock was not unregistered in the latter case.

Keep PTP state as 'uninitialized' on init to distinguish between error
scenarios and to avoid resource release duplication at driver removal.

The consequence of missing ice_ptp_cleanup_pf call is the following call
trace dumped when ice_adapter object is freed (port list is not empty,
as it is required at this stage):

[  T93022] ------------[ cut here ]------------
[  T93022] WARNING: CPU: 10 PID: 93022 at
ice/ice_adapter.c:67 ice_adapter_put+0xef/0x100 [ice]
...
[  T93022] RIP: 0010:ice_adapter_put+0xef/0x100 [ice]
...
[  T93022] Call Trace:
[  T93022]  <TASK>
[  T93022]  ? ice_adapter_put+0xef/0x100 [ice
33d2647ad4f6d866d41eefff1806df37c68aef0c]
[  T93022]  ? __warn.cold+0xb0/0x10e
[  T93022]  ? ice_adapter_put+0xef/0x100 [ice
33d2647ad4f6d866d41eefff1806df37c68aef0c]
[  T93022]  ? report_bug+0xd8/0x150
[  T93022]  ? handle_bug+0xe9/0x110
[  T93022]  ? exc_invalid_op+0x17/0x70
[  T93022]  ? asm_exc_invalid_op+0x1a/0x20
[  T93022]  ? ice_adapter_put+0xef/0x100 [ice
33d2647ad4f6d866d41eefff1806df37c68aef0c]
[  T93022]  pci_device_remove+0x42/0xb0
[  T93022]  device_release_driver_internal+0x19f/0x200
[  T93022]  driver_detach+0x48/0x90
[  T93022]  bus_remove_driver+0x70/0xf0
[  T93022]  pci_unregister_driver+0x42/0xb0
[  T93022]  ice_module_exit+0x10/0xdb0 [ice
33d2647ad4f6d866d41eefff1806df37c68aef0c]
...
[  T93022] ---[ end trace 0000000000000000 ]---
[  T93022] ice: module unloaded

Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index fb0f6365a6d6..8ec0f7d0fceb 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3246,7 +3246,7 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	err = ice_ptp_init_port(pf, &ptp->port);
 	if (err)
-		goto err_exit;
+		goto err_clean_pf;
 
 	/* Start the PHY timestamping block */
 	ice_ptp_reset_phy_timestamping(pf);
@@ -3263,13 +3263,19 @@ void ice_ptp_init(struct ice_pf *pf)
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;
 
+err_clean_pf:
+	mutex_destroy(&ptp->port.ps_lock);
+	ice_ptp_cleanup_pf(pf);
 err_exit:
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
 		ptp_clock_unregister(ptp->clock);
 		pf->ptp.clock = NULL;
 	}
-	ptp->state = ICE_PTP_ERROR;
+	/* Keep ICE_PTP_UNINIT state to avoid ambiguity at driver unload
+	 * and to avoid duplicated resources release.
+	 */
+	ptp->state = ICE_PTP_UNINIT;
 	dev_err(ice_pf_to_dev(pf), "PTP failed %d\n", err);
 }
 
@@ -3282,9 +3288,19 @@ void ice_ptp_init(struct ice_pf *pf)
  */
 void ice_ptp_release(struct ice_pf *pf)
 {
-	if (pf->ptp.state != ICE_PTP_READY)
+	if (pf->ptp.state == ICE_PTP_UNINIT)
 		return;
 
+	if (pf->ptp.state != ICE_PTP_READY) {
+		mutex_destroy(&pf->ptp.port.ps_lock);
+		ice_ptp_cleanup_pf(pf);
+		if (pf->ptp.clock) {
+			ptp_clock_unregister(pf->ptp.clock);
+			pf->ptp.clock = NULL;
+		}
+		return;
+	}
+
 	pf->ptp.state = ICE_PTP_UNINIT;
 
 	/* Disable timestamping for both Tx and Rx */
-- 
2.47.1


