Return-Path: <netdev+bounces-277644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNiQJ8Oq2WnGrwgAu9opvQ
	(envelope-from <netdev+bounces-277644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:58:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A94D3DDEF8
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81794302FA93
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815CE282F17;
	Sat, 11 Apr 2026 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/6d6//m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E101E1024;
	Sat, 11 Apr 2026 01:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775872701; cv=none; b=cKJs0TNGXIg4q6/eM2KQ8YHSAyMPdQAwuxKKGZMJJ1SpC6Lk4j1GxtBAa4O+89tAdY978lJAAqfxYfnEvv5tOIdthJ/8Fqy6QCTb6I6kYCrRAYZJOY1RI2CtMecD3XiNqoTES7/UwTCTiAZGH8mcX2z3xH1qKwiihm8R1Q0eRXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775872701; c=relaxed/simple;
	bh=aBwGo9H+b8nY0B7VJPDqnBQObCCiBEaUXkwMctr59Uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pw3mHLiVnwGu1MNtxQwoehQkc441VpPXkwE5GljApVyRv/lOZOKV/yDg5rq9ErbhDB1xGmrNlaWzYAzLTr6ajROIGDHyMiRST4S9AO7TZn4iAsvd5dVMoCP/jfIhCZc45lVOwtvn2TD7MHFrs3noKFvJZe3hZtpJQCrtkxM5vHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/6d6//m; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775872700; x=1807408700;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=aBwGo9H+b8nY0B7VJPDqnBQObCCiBEaUXkwMctr59Uw=;
  b=G/6d6//mH0cYk6RFkEi8loz67AknIw6r9gCd6O0CymFv2gOSNG2Jimhq
   CGR9cKhQ6sJF34ikYFMrZ32x4W6Bd7x2re2HrvdrgK2JCb9EOCBtwbCdY
   sDo80r33sn6vagDJCek8ne+3wwrcddXQCE7u54cpOdxWD+vxLt7hoUrzj
   eOIeSbHa7yA3+zqWlkvyfMEWiylJvQ2vvZsnTDzwTfAWu6At1oRHdeMyp
   X3URS6dDA92pPoIIdTVoQcElF17L2neNdHZ1IufAtb7O96OsVtNhM3xld
   xVvmRvqfNJ6a7n+kmNHUADVgoHevapdqKW3sOXAQjxyabtMTMEqVkwpmY
   Q==;
X-CSE-ConnectionGUID: feNWzUPUTLS+NyYa06lFFw==
X-CSE-MsgGUID: 0XGkuGB1Tf2tpdjxR/1jKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76611215"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="76611215"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 18:58:20 -0700
X-CSE-ConnectionGUID: Q8Sh3e4iT+2ofRQvT+XGbw==
X-CSE-MsgGUID: xPKpWEnIT/uZxZHSvbnvqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="229166873"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [192.168.68.61]) ([10.125.109.75])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 18:58:19 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 10 Apr 2026 18:57:57 -0700
Subject: [PATCH net] net/sched: taprio: fix use-after-free in
 advance_sched() on schedule switch
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-taprio-user-after-free-fix-net-v1-1-0931b1579988@intel.com>
X-B4-Tracking: v=1; b=H4sIAKSq2WkC/yVNzQrCMAx+lZGzgbbMDnwV8dBuiWaHbqSdCGPvv
 qiXD77/HSqpUIVbt4PSW6osxYi/dDC+UnkSymQcggvR9d5hS6vKgpv1MHEzZCVClg8Wash5igP
 HePUhg42sSmb9Du5gAXj8xbrlmcb2nYbjOAHrJi3ahwAAAA==
X-Change-ID: 20260410-taprio-user-after-free-fix-net-fbd67f66512b
To: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Junxi Qian <qjx1298677004@gmail.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.16-dev-62088
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775872698; l=2054;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=aBwGo9H+b8nY0B7VJPDqnBQObCCiBEaUXkwMctr59Uw=;
 b=Fl8YM3LlTFGnrBgIp1dYjiNqqYrYBJ8I5Rt2VdTwU6Ql8CUeJOflQQNOYkfwh1z36JZfcDdDL
 cwt5wUjp77ECSNZdF0UgOZStt1Eb/rWP1iYeGDg29+JeKFyoF2WNM3U
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com];
	TAGGED_FROM(0.00)[bounces-277644-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 0A94D3DDEF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In advance_sched(), when should_change_schedules() returns true,
switch_schedules() is called to promote the admin schedule to oper.
switch_schedules() queues the old oper schedule for RCU freeing via
call_rcu(), but 'next' still points into an entry of the old oper
schedule. The subsequent 'next->end_time = end_time' and
rcu_assign_pointer(q->current_entry, next) are use-after-free.

Fix this by selecting 'next' from the new oper schedule immediately
after switch_schedules(), and using its pre-calculated end_time.
setup_first_end_time() sets the first entry's end_time to
base_time + interval when the schedule is installed, so the value
is already correct.

The deleted 'end_time = sched_base_time(admin)' assignment was also
harmful independently: it would overwrite the new first entry's
pre-calculated end_time with just base_time.

Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
Reported-by: Junxi Qian <qjx1298677004@gmail.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 net/sched/sch_taprio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index f721c03514f6..0316f2dee06a 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -972,11 +972,12 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	}
 
 	if (should_change_schedules(admin, oper, end_time)) {
-		/* Set things so the next time this runs, the new
-		 * schedule runs.
-		 */
-		end_time = sched_base_time(admin);
 		switch_schedules(q, &admin, &oper);
+		/* After changing schedules, the next entry is the first one
+		 * in the new schedule, with a pre-calculated end_time.
+		 */
+		next = list_first_entry(&oper->entries, struct sched_entry, list);
+		end_time = next->end_time;
 	}
 
 	next->end_time = end_time;

---
base-commit: 02f72964395911e7a09bb2ea2fe6f79eda4ea2c2
change-id: 20260410-taprio-user-after-free-fix-net-fbd67f66512b

Best regards,
--  
Vinicius


