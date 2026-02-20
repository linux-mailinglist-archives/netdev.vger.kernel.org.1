Return-Path: <netdev+bounces-259632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKCnApSul2nO5QIAu9opvQ
	(envelope-from <netdev+bounces-259632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:45:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 853F9163F67
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F264C307671E
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457882192FA;
	Fri, 20 Feb 2026 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZB0041/C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E4421D3E4
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548056; cv=none; b=dRd4v++YU7WRK9u55EqV5uCJECswucn+ABalKSd0fYcdTKJLHAYyNxURVcFu7eswbKhPADv3nykdxq5VAuqafKXRf51rfsnmPZOS14So3OkcbkI/T+XY6oK0uLgsvMg0axWnMVaRofZxSy33PY19EXLz62t7T/vahEOQzBfyfSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548056; c=relaxed/simple;
	bh=MGubghjhN9PQ8ssIJloG3o4o8SFnLfxAFR2w+JvTTsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJWBsI7oPTJ8f3PGVMB3djeurvvIrSG4cZ2/pUGN2xqT8XPGOpeyurcKi8yQ7Y9eYS5Rout5eIt0IhHpj0Ub//kGvrg1/KfrTRLWdvMyX5fMBPLGknN7Piyuv2pYistCVA+UHZX8x6oarXPemIsw+I31Et+zXz37hZUpTj0tTV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZB0041/C; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771548045; x=1803084045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MGubghjhN9PQ8ssIJloG3o4o8SFnLfxAFR2w+JvTTsg=;
  b=ZB0041/C/sUtqO6HdZwXVrfleq5HDKGm5KRuhvQ8DYSqjOjnhnXM9/UU
   7gQ/+Zs1d/o+kXmcilxFBDuXQg4tMjaJFFkdSzflukDfK9O5sURBw4ie7
   UNlsFB3AmRPV1vd5WEpXEDBUqlLV7xf583dn4I+5FXr6Ko9r4kiIvBxuJ
   iHebJc/K4eUBzxiWnqp04uuDYUvuzfo9mXW4SWUJaTaaPKK48uXQJhDux
   4HNL1+eIW+IVZQ+o35lJLznPiWq2BoAIDuD6JlJqYElcDAjUlV8pA/Ne/
   2dRsDO/SMI4N/dEU9HBaW0m2WC4pjkU8EhJ3SVWYIFau4tcgXbB1saNzY
   w==;
X-CSE-ConnectionGUID: G091eXW3SgSQWMs4vDCUtA==
X-CSE-MsgGUID: hyoLx1lyRTa+Is6a6ViWrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76484252"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76484252"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 16:40:35 -0800
X-CSE-ConnectionGUID: u8ZokjQYRB634WyM+dkgtA==
X-CSE-MsgGUID: hxIAK35dQf+Ga10+2XamJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218850501"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 16:40:34 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	richardcochran@gmail.com,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net 13/13] e1000e: correct TIMINCA on ADP/TGP systems with wrong XTAL frequency
Date: Thu, 19 Feb 2026 16:40:25 -0800
Message-ID: <20260220004027.729384-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
References: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259632-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 853F9163F67
X-Rspamd-Action: no action

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

On some Tiger Lake (TGP) and Alder Lake (ADP) platforms, the hardware
XTAL clock is incorrectly interpreted as 24 MHz instead of the actual
38.4 MHz. This causes the PHC to run significantly faster than system
time, breaking PTP synchronization.

To mitigate this at runtime, measure PHC vs system time over ~1 ms using
cross-timestamps. If the PHC increment differs from system time beyond
the expected tolerance (currently >100 uSecs), reprogram TIMINCA for the
38.4 MHz profile and reinitialize the timecounter.

Tested on an affected system using phc_ctl:
Without fix:
sudo phc_ctl enp0s31f6 set 0.0 wait 10 get
clock time: 16.000541250 (expected ~10s)

With fix:
sudo phc_ctl enp0s31f6 set 0.0 wait 10 get
clock time: 9.984407212 (expected ~10s)

Fixes: fb776f5d57ee ("e1000e: Add support for Tiger Lake")
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 814698807f3d..ae35ac479026 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3905,6 +3905,80 @@ static void e1000_flush_desc_rings(struct e1000_adapter *adapter)
 		e1000_flush_rx_ring(adapter);
 }
 
+/**
+ * e1000e_xtal_tgp_workaround - Adjust XTAL clock based on PHC and system
+ * clock delta.
+ * @adapter: Pointer to the private adapter structure
+ *
+ * Measures the time difference between the PHC (Precision Hardware Clock)
+ * and the system clock over a 1 millisecond interval. If the delta
+ * exceeds 100 microseconds, reconfigure the XTAL clock to 38.4 MHz.
+ */
+static void e1000e_xtal_tgp_workaround(struct e1000_adapter *adapter)
+{
+	s64 phc_delta, sys_delta, sys_start_ns, sys_end_ns, delta_ns;
+	struct ptp_system_timestamp sys_start = {}, sys_end = {};
+	struct ptp_clock_info *info = &adapter->ptp_clock_info;
+	struct timespec64 phc_start, phc_end;
+	struct e1000_hw *hw = &adapter->hw;
+	struct netlink_ext_ack extack = {};
+	unsigned long flags;
+	u32 timinca;
+	s32 ret_val;
+
+	/* Capture start */
+	if (info->gettimex64(info, &phc_start, &sys_start)) {
+		e_dbg("PHC gettimex(start) failed\n");
+		return;
+	}
+
+	/* Small interval to measure increment */
+	usleep_range(1000, 1100);
+
+	/* Capture end */
+	if (info->gettimex64(info, &phc_end, &sys_end)) {
+		e_dbg("PHC gettimex(end) failed\n");
+		return;
+	}
+
+	/* Compute deltas */
+	phc_delta = timespec64_to_ns(&phc_end) -
+		    timespec64_to_ns(&phc_start);
+
+	sys_start_ns = (timespec64_to_ns(&sys_start.pre_ts) +
+			timespec64_to_ns(&sys_start.post_ts)) >> 1;
+
+	sys_end_ns = (timespec64_to_ns(&sys_end.pre_ts) +
+		      timespec64_to_ns(&sys_end.post_ts)) >> 1;
+
+	sys_delta = sys_end_ns - sys_start_ns;
+
+	delta_ns = phc_delta - sys_delta;
+	if (delta_ns > 100000) {
+		e_dbg("Corrected PHC frequency: TIMINCA set for 38.4 MHz\n");
+		/* Program TIMINCA for 38.4 MHz */
+		timinca = (INCPERIOD_38400KHZ <<
+			   E1000_TIMINCA_INCPERIOD_SHIFT) |
+			  (((INCVALUE_38400KHZ <<
+			     adapter->cc.shift) &
+			   E1000_TIMINCA_INCVALUE_MASK));
+		ew32(TIMINCA, timinca);
+
+		/* reset the systim ns time counter */
+		spin_lock_irqsave(&adapter->systim_lock, flags);
+		timecounter_init(&adapter->tc, &adapter->cc,
+				 ktime_to_ns(ktime_get_real()));
+		spin_unlock_irqrestore(&adapter->systim_lock, flags);
+
+		/* restore the previous hwtstamp configuration settings */
+		ret_val = e1000e_config_hwtstamp(adapter,
+						 &adapter->hwtstamp_config,
+						 &extack);
+		if (ret_val && extack._msg)
+			e_err("%s\n", extack._msg);
+	}
+}
+
 /**
  * e1000e_systim_reset - reset the timesync registers after a hardware reset
  * @adapter: board private structure
@@ -3956,6 +4030,9 @@ static void e1000e_systim_reset(struct e1000_adapter *adapter)
 		if (extack._msg)
 			e_err("%s\n", extack._msg);
 	}
+
+	if (hw->mac.type == e1000_pch_adp || hw->mac.type == e1000_pch_tgp)
+		e1000e_xtal_tgp_workaround(adapter);
 }
 
 /**
-- 
2.47.1


