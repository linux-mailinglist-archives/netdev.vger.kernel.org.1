Return-Path: <netdev+bounces-288415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHf4J6JmB2ps1wIAu9opvQ
	(envelope-from <netdev+bounces-288415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:32:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAD4556420
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1560D309B9E9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EAE4EA387;
	Fri, 15 May 2026 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDlxo6SA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815530C17B
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869471; cv=none; b=sEXA67OCvS1egLU0lxsbZraZbG/ubB/ABzO4vyKlM05Rzbp1UpZSULMd7rdzVW0T8ODPdlvby1LHsC7pZRfU6fbyIlNHrO0kvyNu4MRsSZGkYsi3QwkxCiA8ndpRea7Yaf5N3mzheg9m0Zyx2Cq7nivtZKeGGP6wdDEJqxMMOm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869471; c=relaxed/simple;
	bh=+kkoGxvbZndDRM6tNXaR0zcmzRqf8jATFTF2iAfhMGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVpUEQCt8Vm40XiwgvwatZ6D+Q3vylzVhp9DhKkaQtj7xudbGb4EMSg0g9DmRr6zttCRDOw/c3A0Hvjc+npTN4zi2nVOLfgKhjRZ2tz3vQ9llWt7BXnNNwmpzPiFvZp62QHhGSKnv/zcQDE7ey/nGYZGOmXb0C70JDOi9nh7oj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDlxo6SA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778869469; x=1810405469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+kkoGxvbZndDRM6tNXaR0zcmzRqf8jATFTF2iAfhMGg=;
  b=KDlxo6SATWLhyExA30VTtlHMpiXjTWJorRGDv9cX3f+5TVLX2xCcbLmt
   jUiMDl3oUbCZz3dyw1SDbcVVQLftOQRBqvOM8d9KvZnoE4SbmBEugfPoD
   n+4DQmOUJlRAfb0MWnArMiNc/c9wZ1qaZa0t6N99kciW+OQEPl8C7/f9L
   7Xp8L/EG4pq6tSwqncwusYgUEgWHMpGuonzAl/vPXKwEKQHEik7mCU+Oy
   KDtzyBfx/N+qSMrnZ5O/ARRQdBCVGGSw730M8vvD8lC7BHlf6VhRfrpEb
   FC3FJAOys481UuH5Nje4M5ZuuvYgUj3nDAl1wK6hI8QxCX8kpNVYpMJXA
   A==;
X-CSE-ConnectionGUID: pnv7eSp+Q1OB5ykNlSrgJw==
X-CSE-MsgGUID: F0WzOA8kRASZukJciuSlDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="83701147"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83701147"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:24:27 -0700
X-CSE-ConnectionGUID: zNnKV4RhQfqfHMWc2lhMuQ==
X-CSE-MsgGUID: 4av8MhRZQH+GOkwryYisbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238647445"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 15 May 2026 11:24:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	przemyslaw.kitszel@intel.com,
	Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 04/10] ice: ptp: serialize E825 PHY timer start with PTP lock
Date: Fri, 15 May 2026 11:24:11 -0700
Message-ID: <20260515182419.1597859-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260515182419.1597859-1-anthony.l.nguyen@intel.com>
References: <20260515182419.1597859-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0AAD4556420
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288415-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

ice_start_phy_timer_eth56g() programs TIMETUS registers and issues
INIT_INCVAL without holding the global PTP semaphore.

This allows concurrent PTP command paths to interleave with PHY timer
start, which can make the sequence fail and leave timer initialization
inconsistent.

Take the PTP lock around TIMETUS registers programming and INIT_INCVAL
command execution, and make sure the lock is released on all error paths.

Keep the subsequent sync step outside of this critical section, since
ice_sync_phy_timer_eth56g() takes the same semaphore internally.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 672218e5d1f9..8bb94e785f2a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2141,16 +2141,23 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	}
 	incval = (u64)hi << 32 | lo;
 
+	if (!ice_ptp_lock(hw)) {
+		dev_err(ice_hw_to_dev(hw), "Failed to acquire PTP semaphore\n");
+		return -EBUSY;
+	}
+
 	err = ice_write_40b_ptp_reg_eth56g(hw, port, PHY_REG_TIMETUS_L, incval);
 	if (err)
-		return err;
+		goto err_ptp_unlock;
 
 	err = ice_ptp_one_port_cmd(hw, port, ICE_PTP_INIT_INCVAL);
 	if (err)
-		return err;
+		goto err_ptp_unlock;
 
 	ice_ptp_exec_tmr_cmd(hw);
 
+	ice_ptp_unlock(hw);
+
 	err = ice_sync_phy_timer_eth56g(hw, port);
 	if (err)
 		return err;
@@ -2166,6 +2173,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	ice_debug(hw, ICE_DBG_PTP, "Enabled clock on PHY port %u\n", port);
 
 	return 0;
+
+err_ptp_unlock:
+	ice_ptp_unlock(hw);
+	return err;
 }
 
 /**
-- 
2.47.1


