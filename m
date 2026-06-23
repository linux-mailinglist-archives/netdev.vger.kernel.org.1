Return-Path: <netdev+bounces-301374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w4nWBsyLOmpC/gcAu9opvQ
	(envelope-from <netdev+bounces-301374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:36:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D006B77F3
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:36:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Hgy38gv+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301374-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301374-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81DED30BFFFC
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9613637BE95;
	Tue, 23 Jun 2026 13:33:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04737A4AF;
	Tue, 23 Jun 2026 13:33:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221614; cv=none; b=pzdpvckB8tyWa71BW8/cI5wiYy+Jb8mKny/u4kRT1PLbWWqEvqRVCPWx9Jyc/8v0HhxbyDk+i2Tf4rSNEMTlAbyQVsgYZCSZz2hEVqtEJgiA5YdeEIkSJvgPC9QgB2D9zTIWDFGHSyfZ/FmWRXal9i5XEkZKEkn/4ghAjYUqxEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221614; c=relaxed/simple;
	bh=is7zopIAMhOW8oDZVX6eFpOs59mHojYC2SVJaus1deQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o2DZnKe9G3rIm81Md+m5I5e/bGhk6NsIVVZ8+cY7RgHPCvQ6QWxc4cPvG9/GCGaAYdahWgKixrZkzzI9LGuBRCfmvtUCFmrpVuL2RWu28zithuFvrsJQPAz1FXY4SaAQ2IbvB4mpDIEgYzH/949VIXWWvqnBD5iFbCR77CtDbPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hgy38gv+; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782221613; x=1813757613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=is7zopIAMhOW8oDZVX6eFpOs59mHojYC2SVJaus1deQ=;
  b=Hgy38gv+YKEUceOtukQySTmZP0eOXy4nfFd0ygyYq5uPmF8W5olUNI+x
   5Nzcct3+7pgqfWrED2NaC2JqhCxi2dekKYx9QEchSQCv+UygcS1Zv8mB6
   M2f0MLp7qJ4lPAYylzHMsqnVVZWE21q0Rm7Dd7eiIzn5/loWfRyRRXXhI
   BgLs0LN5ae4BWyNMPK9fkbcxrJiQf40R4Zye2iGeXSd6QGWlrE1fGr9qm
   YIB+yETc8rRiR2dkZNxW05UfqX3e5B/w5yVQLNVywbFC32GAnOaBlCzj8
   xOl/Zu7OSv3JDnn6tQKYdPnOPto5qmS07sFuKRjuYGKaOGhdOoJd8uc/6
   Q==;
X-CSE-ConnectionGUID: z5Nrnh3DTyy75LMDqecHpA==
X-CSE-MsgGUID: H4YD4uHHSH2Mml3KE8EtOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83153565"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="83153565"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 06:33:32 -0700
X-CSE-ConnectionGUID: e5PO2b20TeCWwyAXsm4Hkw==
X-CSE-MsgGUID: K+jWfzFeSUubIBz8iwMDhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="251447524"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jun 2026 06:33:30 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 6/7] selftests/xsk: fix too-many-frags multi-buffer Tx test
Date: Tue, 23 Jun 2026 15:32:39 +0200
Message-Id: <20260623133240.1048434-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301374-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:bjorn@kernel.org,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78D006B77F3

The too-many-frags test describes a packet that is valid from the Tx
ring ownership point of view, but invalid for transmission because it
exceeds the supported number of fragments.

Keep the generated Tx descriptors valid so that __send_pkts() accounts
them as outstanding descriptors that must be reclaimed through the CQ.
Then mark the corresponding Rx packet invalid so the test still does
not expect the oversized packet to appear on the receive side.

Add a valid synchronization packet after the oversized packet so the
test can verify that the Tx path drains the bad packet and resumes at
the next packet boundary.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 72875071d4f1..de1e63c3fdf6 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -2258,7 +2258,7 @@ int testapp_too_many_frags(struct test_spec *test)
 		max_frags += 1;
 	}
 
-	pkts = calloc(2 * max_frags + 2, sizeof(struct pkt));
+	pkts = calloc(2 * max_frags + 3, sizeof(struct pkt));
 	if (!pkts)
 		return TEST_FAILURE;
 
@@ -2279,21 +2279,29 @@ int testapp_too_many_frags(struct test_spec *test)
 	/* An invalid packet with the max amount of frags but signals packet
 	 * continues on the last frag
 	 */
-	for (i = max_frags + 1; i < 2 * max_frags + 1; i++) {
+	for (i = max_frags + 1; i < 2 * max_frags + 2; i++) {
 		pkts[i].len = MIN_PKT_SIZE;
 		pkts[i].options = XDP_PKT_CONTD;
-		pkts[i].valid = false;
+		pkts[i].valid = true;
 	}
+	pkts[2 * max_frags + 1].options = 0;
 
 	/* Valid packet for synch */
-	pkts[2 * max_frags + 1].len = MIN_PKT_SIZE;
-	pkts[2 * max_frags + 1].valid = true;
+	pkts[2 * max_frags + 2].len = MIN_PKT_SIZE;
+	pkts[2 * max_frags + 2].valid = true;
 
-	if (pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2)) {
+	if (pkt_stream_generate_custom(test, pkts, 2 * max_frags + 3)) {
 		free(pkts);
 		return TEST_FAILURE;
 	}
 
+	/* The generated Tx stream must keep the too-big packet valid so that
+	 * __send_pkts() accounts its descriptors in outstanding_tx. The Rx
+	 * stream, however, must not expect this packet on the wire.
+	 */
+	test->ifobj_rx->xsk->pkt_stream->pkts[2].valid = false;
+	test->ifobj_rx->xsk->pkt_stream->nb_valid_entries--;
+
 	ret = testapp_validate_traffic(test);
 	free(pkts);
 	return ret;
-- 
2.43.0


