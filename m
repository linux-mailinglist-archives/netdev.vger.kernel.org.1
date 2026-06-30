Return-Path: <netdev+bounces-303408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H4JJKClVRGontAoAu9opvQ
	(envelope-from <netdev+bounces-303408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:45:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E709E6E8B34
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:45:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=jbTiGrGR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303408-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303408-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF6A33073ED5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 23:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E72D2397;
	Tue, 30 Jun 2026 23:45:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893A272816
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 23:45:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863131; cv=none; b=kg3mStTeas1oClROC6usJTJTXyT80Q5zeADUp4c4ck0g5xTK3cmnOXUwTi1+xmvmtFr6WFa7Y2dEzsRhJ6UNA5qHCdoPAa9b1ZZXatGs8ggZV9W0Y9pMPl8acMTWhWzaWTIwyB4rMprwaqB25ZSVBU8Bpz6fTeM1K0Rx8O5QCFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863131; c=relaxed/simple;
	bh=VVU1Aawok25MxGOIJ6dAsnFw5aNp2IWcF/0CXay64Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SnHncvvR8SRyQip6CJCbX0aKJ2comzObIrXRg/QpeJqGiMwyCzOyLc/nTCyeKTLmXgi901XtUCsY21OUpYVbUh0rZsfmSEOmfX90MKYA+Xw4w4nKCipFmXURNS9KWKaHWM2i3d+Ke0hka32tG3PvXT4HqUSrZ+eEserQfvGC690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbTiGrGR; arc=none smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782863130; x=1814399130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VVU1Aawok25MxGOIJ6dAsnFw5aNp2IWcF/0CXay64Sw=;
  b=jbTiGrGRN4HAZQ312lTFC9vvilduxzEXuN2x0KVf5PwZIHbA3CCrd3GY
   00GQ/kll5wf18voXsknXBDBQOo+TYsBrqQcasx1T6/D7AMTHFDUp+oPxD
   8Op9CrxXj8sZ0xfnlzKh5XaFn+/C1dXAZ5IxNQBFAfwOp2H+rK071T7ng
   ocDB4DeO+T35PqY79V5QygbypZCchixYTo1sOJk7AEAQj60NoHLrmcrmy
   LGy9PbWaLbrZkFnRjI0ywDK7XCZCbmoXgGnLHR8YzLXZ/cOkqa15E1x/f
   HqAeMH4p5sJSn0AuM3/7fy/N1+T4QNO2vSMVpTPvWSLD35KcfBsDtbvLM
   A==;
X-CSE-ConnectionGUID: jaknYnzyRdyYaIL5qkJ65w==
X-CSE-MsgGUID: SNz7brtfTuaXsyxr1nPovw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="71111734"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="71111734"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 16:45:29 -0700
X-CSE-ConnectionGUID: 2jDqwQ7pTVSDiSUDqEDaPw==
X-CSE-MsgGUID: 3mr3C2r+TA6fqJv4NmV1YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="246061748"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by fmviesa009.fm.intel.com with ESMTP; 30 Jun 2026 16:45:27 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH iwl-net] idpf: adjust TxQ ring count minimum
Date: Tue, 30 Jun 2026 16:56:19 -0700
Message-Id: <20260630235619.756633-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303408-lists,netdev=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E709E6E8B34

Set the TxQ ring count minimum to 128 descriptors. Any lower than this,
and the queue will stall and trigger Tx timeouts in flow based
scheduling mode. This is because next_to_clean might never be updated.

In flow based scheduling mode, next_to_clean is only updated after a
descriptor completion is processed, i.e. after the RE bit is set in the
last descriptor of a Tx packet. This will never happen with a ring size
of 64 and an IDPF_TX_SPLITQ_RE_MIN_GAP of 64. No matter what the value
of last_re is initialized/set to, the calculated gap will be at most 63
and never trigger the RE bit.

Even a ring size of 96 does not solve this. Because of how infrequent
next_to_clean is updated and how small the ring is, IDPF_DESC_UNUSED
will be much smaller on average. This increases the chance the queue
will be stopped because a multi-descriptor packet, e.g. a large LSO
packet, does not see enough resources on the ring. In this case, the
queue will trigger the stop logic. The queue permanently stalls because
there is no chance for a descriptor completion to update next_to_clean
since it is dependent on a packet being sent.

Fixes: 5f417d551324 ("idpf: replace flow scheduling buffer ring with buffer pool")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 5 +----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 7f9056404f64..c724d429a7aa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3097,10 +3097,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
-		/* Set the RE bit to periodically "clean" the descriptor ring.
-		 * MIN_GAP is set to MIN_RING size to ensure it will be set at
-		 * least once each time around the ring.
-		 */
+		/* Set the RE bit periodically to "clean" the descriptor ring */
 		if (idpf_tx_splitq_need_re(tx_q)) {
 			tx_params.eop_cmd |= IDPF_TXD_FLEX_FLOW_CMD_RE;
 			tx_q->txq_grp->num_completions_pending++;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4be5b3b6d3ed..908dfa28674e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -21,7 +21,7 @@
 /* Mailbox Queue */
 #define IDPF_MAX_MBXQ				1
 
-#define IDPF_MIN_TXQ_DESC			64
+#define IDPF_MIN_TXQ_DESC			128
 #define IDPF_MIN_RXQ_DESC			64
 #define IDPF_MIN_TXQ_COMPLQ_DESC		256
 #define IDPF_MAX_QIDS				256
-- 
2.39.2


