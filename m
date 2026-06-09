Return-Path: <netdev+bounces-297309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +e2IEV+JKGqDFwMAu9opvQ
	(envelope-from <netdev+bounces-297309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:45:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DFE664518
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:45:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=YcCsAjLJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297309-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297309-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 031A8310F362
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28CF4968FB;
	Tue,  9 Jun 2026 21:36:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E7D4ADDA8
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040984; cv=none; b=qqE2Z3tF5P7JDAs7mP/l+r76/zfQmoQMRen6XuCdYzmA0vMasEr086ODhkfrnNX2lChDkq7I5Xdrb38Dv3T4ZFJb+pc33hJqJk22/xn1iTzrsreKBOci89Ws4Ots9qphkKyrshcQa3bZV4uPZozuGPkvcpKVLAl00sKoYX9nPaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040984; c=relaxed/simple;
	bh=Iu3MB1mJ2UYUzI3OmO3w6rMljmIsoo1HlajZWTKCnuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dl7QNP8OzXj/bPNCuARe/PvqLcwVrDTr6f2DK3lWsaLNFZCAe+rxZLpiTZisB0h/e2n6Nsbp9oK9krL+G/egMMDHxR4ZKcbRucJ6Eh3Hi7I8IpWNPX5J1QccG+P00xDCCCVvojyW0TOv7P7z/PTm4TaZDzfv+DYk1bZgXjeVE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcCsAjLJ; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040984; x=1812576984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iu3MB1mJ2UYUzI3OmO3w6rMljmIsoo1HlajZWTKCnuo=;
  b=YcCsAjLJLRWwBijgm1/ohagK+lhLJj2lJ3Z0FuW4LWNmNZszZQCx7TVZ
   jB3LctDl+bshglt0hJyKFb47lXIILcd4R+cUc8Ci7XLW9slqyZ3/R6b/V
   Bge2ZRsxqIze/3JVlMdU4g/47j26KK5RFvASHpk8BcIOahICwDvJoVn5R
   NxLoctawF0+0qTVLsGTl0/YZEQfC5q7I3ahz+welY2jXObqQcTR1ToD0c
   Vgw1EGvZRJLIn8LQ3eKUtWsuDVNPR1s34+k/P44AneozZjbTTq05GINCY
   e3QfyGY2WnCJtlXUo7j3FdIzfqPmwMV/EpmQwLeBidWaK9I+ictnTf3IT
   g==;
X-CSE-ConnectionGUID: XWVk69VgTwuogoul96/GdQ==
X-CSE-MsgGUID: ntVllwnGQPi9q/T1IS77XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568621"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568621"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:10 -0700
X-CSE-ConnectionGUID: qEZlf0HvQJiFYqF0yQwzpA==
X-CSE-MsgGUID: CLbtT6sqSNCR1j38n0q2sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838613"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Maximilian Pezzullo <maximilianpezzullo@gmail.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Joe Damato <joe@dama.to>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net-next 15/15] igc: fix typos in comments
Date: Tue,  9 Jun 2026 14:35:56 -0700
Message-ID: <20260609213559.178657-16-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297309-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:maximilianpezzullo@gmail.com,m:anthony.l.nguyen@intel.com,m:dima.ruinskiy@intel.com,m:aleksandr.loktionov@intel.com,m:joe@dama.to,m:avigailx.dahan@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,dama.to];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,dama.to:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95DFE664518

From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

Fix spelling errors in code comments:
 - igc_diag.c: 'autonegotioation' -> 'autonegotiation'
 - igc_main.c: 'revisons' -> 'revisions' (two occurrences)

Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Joe Damato <joe@dama.to>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_diag.c | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_diag.c b/drivers/net/ethernet/intel/igc/igc_diag.c
index a43d7244ee70..031561fdce49 100644
--- a/drivers/net/ethernet/intel/igc/igc_diag.c
+++ b/drivers/net/ethernet/intel/igc/igc_diag.c
@@ -172,7 +172,7 @@ bool igc_link_test(struct igc_adapter *adapter, u64 *data)
 
 	*data = 0;
 
-	/* add delay to give enough time for autonegotioation to finish */
+	/* add delay to give enough time for autonegotiation to finish */
 	ssleep(5);
 
 	link_up = igc_has_link(adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 9143d591083f..e0d719c11105 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1797,7 +1797,7 @@ static const enum pkt_hash_types igc_rss_type_table[IGC_RSS_TYPE_MAX_TABLE] = {
 	[IGC_RSS_TYPE_HASH_UDP_IPV6_EX] = PKT_HASH_TYPE_L4,
 	[10] = PKT_HASH_TYPE_NONE, /* RSS Type above 9 "Reserved" by HW  */
 	[11] = PKT_HASH_TYPE_NONE, /* keep array sized for SW bit-mask   */
-	[12] = PKT_HASH_TYPE_NONE, /* to handle future HW revisons       */
+	[12] = PKT_HASH_TYPE_NONE, /* to handle future HW revisions       */
 	[13] = PKT_HASH_TYPE_NONE,
 	[14] = PKT_HASH_TYPE_NONE,
 	[15] = PKT_HASH_TYPE_NONE,
@@ -7039,7 +7039,7 @@ static enum xdp_rss_hash_type igc_xdp_rss_type[IGC_RSS_TYPE_MAX_TABLE] = {
 	[IGC_RSS_TYPE_HASH_UDP_IPV6_EX] = XDP_RSS_TYPE_L4_IPV6_UDP_EX,
 	[10] = XDP_RSS_TYPE_NONE, /* RSS Type above 9 "Reserved" by HW  */
 	[11] = XDP_RSS_TYPE_NONE, /* keep array sized for SW bit-mask   */
-	[12] = XDP_RSS_TYPE_NONE, /* to handle future HW revisons       */
+	[12] = XDP_RSS_TYPE_NONE, /* to handle future HW revisions       */
 	[13] = XDP_RSS_TYPE_NONE,
 	[14] = XDP_RSS_TYPE_NONE,
 	[15] = XDP_RSS_TYPE_NONE,
-- 
2.47.1


