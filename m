Return-Path: <netdev+bounces-276875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDuuB3Nb12kCNAgAu9opvQ
	(envelope-from <netdev+bounces-276875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:55:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B24E53C755C
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2537A3008263
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67912378D92;
	Thu,  9 Apr 2026 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5cCZARn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EDD2DFF04
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721327; cv=none; b=tODqlxmFXfO0E0i9X1qpavrD0gTpgKFtMt9MF7QqDlZTdUWXl3ZeJP9coSwmC7JNHN+ekRenhFNzWwQuPj8OMVWODYheeCIYdqr7QVgvjQ5V9/lHvH4jXxa92sIBKPBg0HCXhEzVXfyHUQVSJY/tAXRAHAceb1y72jnjMZNmabA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721327; c=relaxed/simple;
	bh=/5ZJ1FafXGgB0BH35EwTR8rcplGlVRfAu4DR25wM9Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSs1edYV+L67eZhRP0hy5p0EwTmu5A0SEqmkExyATcOqryekU91O0+E3UhSW5rdryhfBVAewXWd5GikkRfxBldpvBTt4+znKgaCqGtR7qQrVhQS/dBBGOo2VtgxCUfkdXVhHtJMOGsbtQW/Le+DP9UQH8tjvt8N4zrIaVt6UBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5cCZARn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775721327; x=1807257327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/5ZJ1FafXGgB0BH35EwTR8rcplGlVRfAu4DR25wM9Wo=;
  b=a5cCZARnwdSBMn2WbeCiw7MEumrBhNDwb44Py5HPqpd6d35VTshO8rbG
   2xqduUftiAg6B7BdFf0GB5mLH/Xy5uLGjy1jUuYT+RZC5RDQ38805yb/+
   UTf8Lpof1BEf9N2pV5fK5Ry1R9VbeOatcy3Nh/jV0O8pGKH9viaCcQsHe
   6gyf1TumF6bDa/DrN86eA4CvfSIgK0uov3IEP9PWq8QPyJGYZFgD618zT
   GrROCCaSjLtGLS/Wd060hZkuSlVjtSHAMurVo83d/Ijsgl/NmlArkzUge
   ubm2o/Uj8kO+fEPfMK2NRU320FMmrHkjByQAZDXSiSBXQ1rwkSW2Piw7Z
   A==;
X-CSE-ConnectionGUID: AtLM2dfBRoGu84b/+Al5Qw==
X-CSE-MsgGUID: GDTH+74vQIqVJz09FYT8BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="99346305"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="99346305"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:55:26 -0700
X-CSE-ConnectionGUID: IWD2CF2fTrqWGyKgTGudOg==
X-CSE-MsgGUID: BV+lYnXdTIu9DNNXNk9UBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="228628765"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 09 Apr 2026 00:55:24 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH iwl-next v2] igb: use ktime_get_real helpers in igb_ptp_reset()
Date: Thu,  9 Apr 2026 09:55:23 +0200
Message-ID: <20260409075523.3728506-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276875-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: B24E53C755C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
ktime_get_real_ns() and ktime_to_timespec64(ktime_get_real()) with
ktime_get_real_ts64() in igb_ptp_reset().  Using the combined helpers
makes the intent clearer.

Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Suggested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2 removed the inaccurate claim, + Pauls RB
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index bd85d02..638d824 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1500,12 +1500,13 @@ void igb_ptp_reset(struct igb_adapter *adapter)
 
 	/* Re-initialize the timer. */
 	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211)) {
-		struct timespec64 ts = ktime_to_timespec64(ktime_get_real());
+		struct timespec64 ts;
 
+		ktime_get_real_ts64(&ts);
 		igb_ptp_write_i210(adapter, &ts);
 	} else {
 		timecounter_init(&adapter->tc, &adapter->cc,
-				 ktime_to_ns(ktime_get_real()));
+				 ktime_get_real_ns());
 	}
 out:
 	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
-- 
2.52.0


