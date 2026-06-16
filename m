Return-Path: <netdev+bounces-299896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WKHaKDV0MWryjgUAu9opvQ
	(envelope-from <netdev+bounces-299896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:05:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F04691AC2
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:05:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=eRyuYXQO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299896-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299896-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25AB431B2273
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D9343E486;
	Tue, 16 Jun 2026 15:50:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A902EEE74;
	Tue, 16 Jun 2026 15:50:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625034; cv=none; b=Y/AxtfP+46AxKzYNAaSjpWun0VqyVlC/44ES2Xsu26tu+nZzcyny5UFtoALFMdWnlSjA5KF2ZWSma/B0EbMAHY4w8WfzqqQTKB5A1vD8AkuNNyhh6Jw7mRmkk1pC4XNQXHJs7GLU5zBEIUoejwkJh5gyeEfjbpI0clkxVY9coqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625034; c=relaxed/simple;
	bh=Q+Xaq+AMRkNpmWtP9AFXupbcgyioW9wk8K/YLL6J5Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfX37ON33lEnhsPaTSlDCbzFUY+tv1jr0bPdM4RCR5Pzl8v5xhk7UtHF0oJ+6qVtGA/vWQNXWh6IBnGycY3Cc2NJPf8gyXVrbdrVq+jRajcJFfSOmg67FZN394fWqSMXWlmuOZqtSCww6/FiMJZxXfpdRhFKCXVVhZBx5OSFzcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRyuYXQO; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781625033; x=1813161033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q+Xaq+AMRkNpmWtP9AFXupbcgyioW9wk8K/YLL6J5Cw=;
  b=eRyuYXQODYBR++xI9mfmkA2KQUovuGfspVB8pB5/ESJKruZePKUoSICH
   c8th1d7BXhRbGhh378yiTzzofOywNAX0gActXRgsr65J2B9gmJBCmipjA
   NrEFyVBOsGth7j7uxAVAosdQ3t6dIAcCawciOn+FJMUWR+YYoTd460/kV
   iDsaGEkM/06OLhd9xtrdgZOjugV9BWr3v1g6GGXwAgmpSiy2x9aH5F+Eq
   jQeX7Ucuvh40HiSLAhfyF3vrZzR2jmWzbsBhUuS+299Zw3cGva+Ch0DNG
   PdMUVSGaafAXBkm0ikmbtehdvUGoefW+tLAZkbHJwMlbAZPKbOJ8ncUEE
   g==;
X-CSE-ConnectionGUID: TK0pplR/RIKBlTkWfN6rNA==
X-CSE-MsgGUID: RzUlkzaKQz2PsvBM3FNwDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86233019"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86233019"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 08:50:32 -0700
X-CSE-ConnectionGUID: AZW4aDheTMi9GnONvwF9kA==
X-CSE-MsgGUID: LxYxD8lwR/agYnU02Db8pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247684332"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 08:50:29 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	stfomichev@gmail.com,
	kernelxing@tencent.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Cc: bpf@vger.kernel.org
Subject: [PATCH net-next 3/3] selftests/xsk: restore shared_umem after POLL_TXQ_FULL
Date: Tue, 16 Jun 2026 21:19:54 +0530
Message-ID: <20260616154955.1492560-4-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:tushar.vyavahare@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299896-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_SENDER(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17F04691AC2

POLL_TXQ_FULL temporarily disables shared_umem on TX to exercise the
TX timeout path in isolation.

With shared_umem enabled, TX setup expects RX UMEM to be initialized
first and fails with: "RX UMEM is not initialized before shared-UMEM TX
setup".

Save and restore shared_umem around POLL_TXQ_FULL execution, and restore
it on both success and pkt_stream_replace() failure paths.

Also add an in-code comment explaining why shared_umem is temporarily
disabled in this test.

This keeps timeout setup local and prevents cross-test state leakage.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index d4702d2aac5e..6eb9096d084c 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -2226,13 +2226,28 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 
 int testapp_poll_txq_tmout(struct test_spec *test)
 {
+	bool shared_umem = test->ifobj_tx->shared_umem;
+	int ret;
+
 	test->poll_tmout = true;
+	/*
+	 * POLL_TXQ_FULL exercises TX timeout setup in isolation.
+	 * Keep TX out of shared-UMEM mode here so TX setup does not require
+	 * RX UMEM to be initialized first.
+	 */
+	test->ifobj_tx->shared_umem = false;
 	test->ifobj_tx->use_poll = true;
 	/* create invalid frame by set umem frame_size and pkt length equal to 2048 */
 	test->ifobj_tx->xsk->umem->frame_size = 2048;
-	if (pkt_stream_replace(test, 2 * DEFAULT_PKT_CNT, 2048))
+	if (pkt_stream_replace(test, 2 * DEFAULT_PKT_CNT, 2048)) {
+		test->ifobj_tx->shared_umem = shared_umem;
 		return TEST_FAILURE;
-	return testapp_validate_traffic_single_thread(test, test->ifobj_tx);
+	}
+
+	ret = testapp_validate_traffic_single_thread(test, test->ifobj_tx);
+	test->ifobj_tx->shared_umem = shared_umem;
+
+	return ret;
 }
 
 int testapp_poll_rxq_tmout(struct test_spec *test)
-- 
2.43.0


