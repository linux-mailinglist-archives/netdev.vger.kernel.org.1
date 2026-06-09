Return-Path: <netdev+bounces-297302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /+UhH/SIKGpwFwMAu9opvQ
	(envelope-from <netdev+bounces-297302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:43:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEBF6644F1
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:43:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ZleaU6tH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297302-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297302-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BBA030EE3B6
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685A948B380;
	Tue,  9 Jun 2026 21:36:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586EF4ADDBE
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040975; cv=none; b=IZSGub7FgAcHGeyy+9ryQ+ZwSy01JSAr3xWTnOhAPdLzLB9v5vtMMlG2+1AYPUARxn6UyrbejtGlHOVjXqXwpzq1Z+T5mNblLKAlNjcttZ4Si2zFTOJ4QxFdMzDAoNwWataSja/3kMNjwJbd566PQvAOpKeMaROgW8LkwGB+jqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040975; c=relaxed/simple;
	bh=b8iGJJ8IOAs+qHj+bRWo9JiLSdfaF2ODkL109xWDffc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtCCWw2ICtQcM7FcO/E5eXCQnWPPcqvucjMq/rEXF8DYyoU4rTEk1kNQarp/mublBB/c45o4knzI3xnYpKsy9bT0Ld2O/OcfXmIuSHTRlayF3sZth0TzE4nxgcZ4xdaiYRodhho60wICpBWwXMjnwiEOs8PhXBekfY236mRv78c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZleaU6tH; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040974; x=1812576974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b8iGJJ8IOAs+qHj+bRWo9JiLSdfaF2ODkL109xWDffc=;
  b=ZleaU6tHTi3E7xgP3x/jba0GqAm9R0RKCYDvAwlWAws2vGKw06Dn5M3+
   CKVI9RryAY1xjZMFXEDr2Hj8YaZHgU79OE01gvG8kc8xUiS8kE+yMdCFX
   7LjY19IMfIUIEGkA1YMCOZw1K5aMzJ+7d0Ufo3ooqeDrmJ3JntUFfHuc2
   bqaTJWZY2fjlYPu8RZUPeGRjQkxbPMBuihD7bD1QxLckFefVdm0ROqThO
   mM2bGi2yqcxKdMXp0ScjpvWQpnKiK+xQ921zZJdtq+I/TfZ1qELGjvgRA
   RUz3WwE5S793e+v4PCpBOT8Rn6QLO7e9W3dM76oMptLd55WSqojW5J/n5
   Q==;
X-CSE-ConnectionGUID: n1G53jooRB+F9qaLkZJ+aw==
X-CSE-MsgGUID: ArzXYOG0S8GTI5rkhmNL4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568568"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568568"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:09 -0700
X-CSE-ConnectionGUID: kLeJWH0QQ0CXaqgcIjGuOQ==
X-CSE-MsgGUID: FZ/Q61NqSR+ASI+7oq+43Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838588"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net-next 07/15] igb: use ktime_get_real helpers in igb_ptp_reset()
Date: Tue,  9 Jun 2026 14:35:48 -0700
Message-ID: <20260609213559.178657-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
References: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297302-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:aleksandr.loktionov@intel.com,m:anthony.l.nguyen@intel.com,m:richardcochran@gmail.com,m:jacob.e.keller@intel.com,m:horms@kernel.org,m:pmenzel@molgen.mpg.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,kernel.org,molgen.mpg.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mpg.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEEBF6644F1

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
ktime_get_real_ns() and ktime_to_timespec64(ktime_get_real()) with
ktime_get_real_ts64() in igb_ptp_reset().  Using the combined helpers
makes the intent clearer.

Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Suggested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 7b44f9090631..f63765e9249b 100644
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
2.47.1


