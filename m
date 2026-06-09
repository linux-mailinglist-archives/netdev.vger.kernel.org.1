Return-Path: <netdev+bounces-297303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wfp4BQmJKGpxFwMAu9opvQ
	(envelope-from <netdev+bounces-297303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:43:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 844C26644F6
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:43:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=dzJwv2ei;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297303-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297303-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9F330F769F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1854F403135;
	Tue,  9 Jun 2026 21:36:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB304ADDA7
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040978; cv=none; b=iSftMw5ZzTnJGeHcaWlfdU4ltttsr0P0JmhCOWMxpalVDQoYMzMQ0+gq7U3NsdvTq1fpX3SsT4VE1/6KVZNITDvyZ5ptFaWqVfn4l6dvVUfG9jwHSMJXA2iI5dkfaTIGbNtTMx24W+p0VXImc9RWtOCRflmJp2NMNtYAWaP4wO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040978; c=relaxed/simple;
	bh=zDqLygAbQMyHo9jQ46PSUvyy7KJXWrEaKsCxx4VEZjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9fiSBNw777VDXhx0T/DC5ZfviNqwvrC61yWV1cNMzg6kw2tpIULSa4cbliB+riN6zJsF9p3S+BmJ2+SX3GJKb4pYYzmkEQ/VnwyUmHPTNS7eP8XjBCtC84cKI0wvwgKYc87oJzsBn1pq2SFlRqrkEPX0M2SzF+LTiszN+XKbUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzJwv2ei; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040973; x=1812576973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zDqLygAbQMyHo9jQ46PSUvyy7KJXWrEaKsCxx4VEZjE=;
  b=dzJwv2eiJ2dOty9nfpC3LViBPRE9jppfRVDmTVBFAlcE9UjnUXToll45
   QVzUdjABcLxQc4irz52FY4tc91kiqGjpLzGB0e8KuLBtaxiaZXDzJgMnc
   /4OL2zKir3HRJE217MWUlGL9z3zlmolT2Eu2my4IkVsokVKPBPoOQDscT
   W+Z749mAtXvxqzVFGsmWG5XO1UFr9E3fO0yS/kNzfGO2d32vJVFGG039s
   oGSS0LJoi6EMbhbh7oiXf/StXetD87OMMDRvEM8p+bcYO65ctPeJsTnKb
   do4at7DNrrLoEr6rJAFUaoiN2Wc/9k5E5YJNH6YJuoi9GI9M7GdO3v+Z3
   Q==;
X-CSE-ConnectionGUID: fyMTN6Y0RYqUas2/iwfvtg==
X-CSE-MsgGUID: BbTcg/MxRiiL3aCj9h7IAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568560"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568560"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:08 -0700
X-CSE-ConnectionGUID: mTa8C7aTTO+z7N+L+oSFeg==
X-CSE-MsgGUID: bPo5LylHTsWI+hW/dLLEJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838585"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	vinicius.gomes@intel.com,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	vadim.fedorenko@linux.dev,
	pmenzel@molgen.mpg.de,
	bigeasy@linutronix.de,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 06/15] igb: Retrieve Tx timestamp from BH workqueue
Date: Tue,  9 Jun 2026 14:35:47 -0700
Message-ID: <20260609213559.178657-7-anthony.l.nguyen@intel.com>
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
	TAGGED_FROM(0.00)[bounces-297303-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:kurt@linutronix.de,m:anthony.l.nguyen@intel.com,m:richardcochran@gmail.com,m:vinicius.gomes@intel.com,m:jacob.e.keller@intel.com,m:aleksandr.loktionov@intel.com,m:przemyslaw.kitszel@intel.com,m:vadim.fedorenko@linux.dev,m:pmenzel@molgen.mpg.de,m:bigeasy@linutronix.de,m:sx.rinitha@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linutronix.de,intel.com,gmail.com,linux.dev,molgen.mpg.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mpg.de:email,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 844C26644F6

From: Kurt Kanzenbach <kurt@linutronix.de>

Retrieve Tx timestamp from system BH instead of regular system workqueue.

The current implementation uses schedule_work() which is executed by the
system work queue and kworkers to retrieve Tx timestamps. This increases
latency and can lead to timeouts in case of heavy system load. i210 is
often used in industrial systems, where timestamp timeouts can be fatal.

Therefore, switch to the system BH workqueues which are executed in softirq
context shortly after the IRQ handler returns.

Tested between Intel i210 and i350 with ptp4l gPTP profile:

|ptp4l[30.405]: rms    4 max    7 freq +12825 +/-   3 delay   247 +/-   0
|ptp4l[31.406]: rms    2 max    3 freq +12829 +/-   3 delay   248 +/-   0
|ptp4l[32.406]: rms    3 max    3 freq +12827 +/-   3 delay   248 +/-   0
|ptp4l[33.406]: rms    2 max    3 freq +12827 +/-   3 delay   248 +/-   0
|ptp4l[34.407]: rms    3 max    6 freq +12825 +/-   4 delay   248 +/-   0
|ptp4l[35.407]: rms    3 max    6 freq +12822 +/-   4 delay   246 +/-   0
|ptp4l[36.407]: rms    7 max   10 freq +12812 +/-   5 delay   248 +/-   0
|ptp4l[37.408]: rms    5 max    8 freq +12808 +/-   3 delay   248 +/-   0

Furthermore, Miroslav Lichvar tested with ntpperf and chrony on Intel i350:

Without the patch:

|               |          responses            |        response time (ns)
|rate   clients |  lost invalid   basic  xleave |    min    mean     max stddev
|150000   15000   0.00%   0.00%   0.00% 100.00%    +4188  +36475 +193328  16179
|157500   15750   0.02%   0.00%   0.02%  99.96%    +6373  +42969 +683894  22682
|165375   16384   0.03%   0.00%   0.00%  99.97%    +7911  +43960 +692471  24454
|173643   16384   0.06%   0.00%   0.00%  99.94%    +8323  +45627 +707240  28452
|182325   16384   0.06%   0.00%   0.00%  99.94%    +8404  +47292 +722524  26936
|191441   16384   0.00%   0.00%   0.00% 100.00%    +8930  +51738 +223727  14272
|201013   16384   0.05%   0.00%   0.00%  99.95%    +9634  +53696 +776445  23783
|211063   16384   0.00%   0.00%   0.00% 100.00%   +14393  +54558 +329546  20473
|221616   16384   2.59%   0.00%   0.05%  97.36%   +23924 +321205 +518192  21838
|232696   16384   7.00%   0.00%   0.10%  92.90%   +33396 +337709 +575661  21017
|244330   16384  10.82%   0.00%   0.15%  89.03%   +34188 +340248 +556237  20880
|
|With the patch:
|150000   15000   5.11%   0.00%   0.00%  94.88%    +4426 +460642 +640884  83746
|157500   15750  11.54%   0.00%   0.26%  88.20%   +14434 +543656 +738355  30349
|165375   16384  15.61%   0.00%   0.31%  84.08%   +35822 +515304 +833859  25596
|173643   16384  19.58%   0.00%   0.37%  80.05%   +20762 +568962 +900100  28118
|182325   16384  23.46%   0.00%   0.42%  76.13%   +41829 +547974 +804170  27890
|191441   16384  27.23%   0.00%   0.46%  72.31%   +15182 +557920 +798212  28868
|201013   16384  30.51%   0.00%   0.49%  69.00%   +15980 +560764 +805576  29979
|211063   16384   0.06%   0.00%   0.00%  99.94%   +12668  +80487 +410555  62182
|221616   16384   2.94%   0.00%   0.05%  97.00%   +21587 +342769 +517566  23359
|232696   16384   6.94%   0.00%   0.10%  92.96%   +16581 +336068 +484574  18453
|244330   16384  11.45%   0.00%   0.14%  88.41%   +23608 +345023 +564130  19177

There are some minor differences at lower rates, but no performance
regressions at higher ones.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 49d46670695f..17eff90af9e3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6571,7 +6571,7 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 			adapter->ptp_tx_skb = skb_get(skb);
 			adapter->ptp_tx_start = jiffies;
 			if (adapter->hw.mac.type == e1000_82576)
-				schedule_work(&adapter->ptp_tx_work);
+				queue_work(system_bh_wq, &adapter->ptp_tx_work);
 		} else {
 			adapter->tx_hwtstamp_skipped++;
 		}
@@ -7075,7 +7075,7 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
 
 	if (tsicr & E1000_TSICR_TXTS) {
 		/* retrieve hardware timestamp */
-		schedule_work(&adapter->ptp_tx_work);
+		queue_work(system_bh_wq, &adapter->ptp_tx_work);
 	}
 
 	if (tsicr & TSINTR_TT0)
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index bd85d02ecadd..7b44f9090631 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -832,7 +832,7 @@ static void igb_ptp_tx_work(struct work_struct *work)
 		igb_ptp_tx_hwtstamp(adapter);
 	else
 		/* reschedule to check later */
-		schedule_work(&adapter->ptp_tx_work);
+		queue_work(system_bh_wq, &adapter->ptp_tx_work);
 }
 
 static void igb_ptp_overflow_check(struct work_struct *work)
-- 
2.47.1


