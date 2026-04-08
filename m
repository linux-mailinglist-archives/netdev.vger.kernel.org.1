Return-Path: <netdev+bounces-276358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKISBFIT1mngAwgAu9opvQ
	(envelope-from <netdev+bounces-276358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:35:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3873B91FF
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8EEC3006138
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C56B3A63EF;
	Wed,  8 Apr 2026 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zi9U7WU8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED0364EB2
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637326; cv=none; b=BeH5p9irLQlgSwtBdueWhVqwonnXMTbxP4GnBKevIIxzrIvPJUZ81yzwQzwfAgieP1reITBg13UvBD33nuC+bsVBul6w2ToffjlRHHRBK1cONsDzoXO71UotzJDFr1LRSIUyvmEccpsCmQkf2GXeO32WPQtkAlAlxM76ubdzh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637326; c=relaxed/simple;
	bh=RrMvobtANsk93uCs04DRCxo131qBQlIpolPmcHmOfk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpVu9XaFsM9gfSJ1FEGwZDPztUmu9eT2fXEDyBE659TR6qEIjCYVQw6g4LkwxEy68peTV4aWBKEyuyumD2QOTzB1Jgp3/VA8c4ExlPmPaGj4uV1Tk668zaK7Lt7t9wLSrYpQ8mm0zIktbNjVZnwZC2CohBx6DorOyQQi9sOdEaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zi9U7WU8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775637325; x=1807173325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RrMvobtANsk93uCs04DRCxo131qBQlIpolPmcHmOfk4=;
  b=Zi9U7WU8t2SlGXHyHllxjmzdH/P/SB5mUkYNx8THzw0hGy4y1E3xjnLS
   CrXZrSkYdigcHmfbu/3OCU5WYTd21D+wVJXLGvwh0IqQO7ST/A3Cwh2ds
   d1ffjG22FuUK3F5zDFfqSzV/w/rc4kVwO6LG2C5kH4VDvWbZLcbNLTH8A
   Y0t7WioRo22kfBNABmIT94+PbqVI4lgmGVPepSaCat8ucyRtggHswtn92
   kMXlDr1ZGgCFrrX10rJuLtVrve33gSYh2Z4pnuJ3zhe+1KUQh//AU2Cp5
   cbi22cW9kEBhkJFCR9F6Pm8yJjg1RVR1pgD5jPoIiNBMUJXWa9LZbFMNo
   A==;
X-CSE-ConnectionGUID: RMv7qi0PRH26D3AN3HC0Ng==
X-CSE-MsgGUID: N+MQeDpNQ+eIxXuCMmMSqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="99239332"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="99239332"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 01:35:25 -0700
X-CSE-ConnectionGUID: 005DSDcsSPKRJqtYppLh1g==
X-CSE-MsgGUID: HxHaPNh/RPaU+5n2cqbusg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="233286750"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa005.fm.intel.com with ESMTP; 08 Apr 2026 01:35:23 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next] igb: use ktime_get_real helpers in igb_ptp_reset()
Date: Wed,  8 Apr 2026 10:35:21 +0200
Message-ID: <20260408083521.1620447-1-aleksandr.loktionov@intel.com>
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
	TAGGED_FROM(0.00)[bounces-276358-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: AB3873B91FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
ktime_get_real_ns() and ktime_to_timespec64(ktime_get_real()) with
ktime_get_real_ts64() in igb_ptp_reset().  Using the combined helpers
avoids the unnecessary intermediate ktime_t variable and makes the
intent clearer.

Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
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


