Return-Path: <netdev+bounces-301308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DF4QJuxNOmq/5gcAu9opvQ
	(envelope-from <netdev+bounces-301308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:12:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5C6B5A54
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:12:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=NS0aC2s7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301308-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301308-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E6EA3050E59
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C083630C37A;
	Tue, 23 Jun 2026 09:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1452DCF6C;
	Tue, 23 Jun 2026 09:10:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205822; cv=none; b=hYvqnla0eSRlB/ywbGt94ZZ42dVeqDrWrdflUJrbgspMh3JIhGTw4XCslUkzeJRPeqqiW+qIxurAb+/PYvx4HcrPkZSCkI6ZyOQDrqhzGXmhEsgISJnTrBnxjxuvs+bXubJsiH33bK8yUt6QbmSCicE8BnBR5aWCWjMG3tllhYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205822; c=relaxed/simple;
	bh=8T7a6XFiQW5FjXNXf6ApxxXet+uPYOEeejpkCBZrULw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Trvx7g0ud/Yg/Rrh0u5pDnHD9KbFhLlmAi/x/oE73dYfoISfEIGcX2HGnXe3CvyC9+peBdlNiOs4p1rCdRZplNj7cUQuAo8ucWmBEjjfQ56o6aSdPLBuYE7PLsIeuM3aidnjLPdP/s6O32aiOOfydQNOfkAdXNT9c0dWDS3s9RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NS0aC2s7; arc=none smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782205822; x=1813741822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8T7a6XFiQW5FjXNXf6ApxxXet+uPYOEeejpkCBZrULw=;
  b=NS0aC2s7Ix8bjfH3I4LuKgduuz1uFtXcbZoSkWgzpRRb0pYN3ocydETq
   DdUleqywTRfdlXs/AfCvggdwH/3XiSkL659oHI0fk6Idy8RdUpuw6odMq
   0A2WTnPffwiSo/zm0YAIdOzzV3I0Sxp5gHF/3iLdHVBATlwc/wzXiQf+3
   UWhasM8dJCYlAv3ChxzhgQ3QehyNzH/MhBqMeQPP1lGcmAGqqRhLuf+RP
   sWdYoT+jpLQffTjIYXlS92viAqjgox0RQF5TsO/TyoCQlQF9k/18YbS/3
   xb+08mIJn7Q/QapCINePpz7lprWyMCppGFtwiDTD1NftjZRcyLKhyE2Nc
   g==;
X-CSE-ConnectionGUID: ol27wEWjTCOlw/d7HtTjOg==
X-CSE-MsgGUID: n4QE3Gx+QBWaGNazRTfL0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="94438659"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="94438659"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:10:21 -0700
X-CSE-ConnectionGUID: dupOZkCyS2a+pS+w5rAh9A==
X-CSE-MsgGUID: iUStIykWTUeTmRtyp4ctsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="249505933"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa007.jf.intel.com with ESMTP; 23 Jun 2026 02:10:19 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
Date: Tue, 23 Jun 2026 11:10:08 +0200
Message-Id: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
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
	TAGGED_FROM(0.00)[bounces-301308-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tushar.vyavahare@intel.com,m:kerneljasonxing@gmail.com,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AF5C6B5A54

The UMEM state refactor made __send_pkts() use xsk->umem for Tx
address generation. At the same time, the shared-UMEM Tx setup copies the
Rx UMEM state into a Tx-local state object and resets base_addr and
next_buffer before configuring the Tx socket.

Passing that Tx-local object to xsk_configure() makes xsk->umem point to
the zero-based Tx allocator state. This breaks the BIDIRECTIONAL test once
the roles are switched: the same socket is then used for Rx validation, but
received descriptors from the other logical UMEM half are checked against
base_addr == 0. With the new UMEM bounds check, a valid address such as
base_addr + XDP_PACKET_HEADROOM is rejected as being outside the UMEM
window.

Keep xsk->umem as the shared/Rx UMEM view used for socket configuration
and Rx validation. Use the ifobject-local UMEM copy only for Tx descriptor
address generation, preserving the BIDIRECTIONAL test's intent of using
the proper logical UMEM half after the direction switch.

Fixes: b17631032769 ("selftests/xsk: Move UMEM state from ifobject to xsk_socket_info")
Signed-off-by: Maciej Fijalkowski maciej.fijalkowski@intel.com
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index d8a1c0d40e5a..50a8dbacb63d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1169,8 +1169,8 @@ static int receive_pkts(struct test_spec *test)
 static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, bool timeout)
 {
 	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
+	struct xsk_umem_info *umem = ifobject->xsk_arr[0].umem_real;
 	struct pkt_stream *pkt_stream = xsk->pkt_stream;
-	struct xsk_umem_info *umem = xsk->umem;
 	bool use_poll = ifobject->use_poll;
 	struct pollfd fds = { };
 	int ret;
@@ -1524,7 +1524,7 @@ static int thread_common_ops_tx(struct test_spec *test, struct ifobject *ifobjec
 	umem_tx->base_addr = 0;
 	umem_tx->next_buffer = 0;
 
-	ret = xsk_configure(test, ifobject, umem_tx, true);
+	ret = xsk_configure(test, ifobject, umem_rx, true);
 	if (ret)
 		return ret;
 	ifobject->xsk = &ifobject->xsk_arr[0];
-- 
2.43.0


