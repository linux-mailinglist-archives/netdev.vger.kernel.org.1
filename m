Return-Path: <netdev+bounces-281730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D5YLUJ38GlgTwEAu9opvQ
	(envelope-from <netdev+bounces-281730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:00:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9514A480C92
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73E4A3002B47
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865AE3D1CB1;
	Tue, 28 Apr 2026 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvjgSUVH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8860439448B;
	Tue, 28 Apr 2026 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365978; cv=none; b=CCY1Y+ENEaDUPmejZ2h7EQnzq+YfzBYyXzTDSNIy8zCPifdfu1ice3boQztjzQms9/1cHH/v9JlqmNm+JcB/DRGqnQG4n+XgtQeimIdwccVPXjsRO62q3gdtcJJnh6/UYc29BwZnYhFmPD079Ukbh5kQPS0YaOjlZ49NLd1/wBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365978; c=relaxed/simple;
	bh=q868tFKCmkRPr0UDRySnLUQ8dho0gw9P6x7lMiGF/gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/V/uPROym5ssCYWKvCR4IxEIB+4laVzAASf/kCBChtCdwRnTMUm8HNCGeqUe/Ntk10PPht9fm0ogOaCSDPjNE5NBmWV/gvkg7FyeE92oNTU1Wp6Hl9gWDYhspVKGmBTRVm5FZqi8cpqrTlxIiwghGIN8LvIxE9LUPSpm4TYGko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvjgSUVH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777365976; x=1808901976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q868tFKCmkRPr0UDRySnLUQ8dho0gw9P6x7lMiGF/gQ=;
  b=IvjgSUVHbm/yMlZ2NeSpKsGWIZPp4f41Mt5Qz00F+Iri5jUlh0+hEGNZ
   d2SnUJ1q1IKnQH7REKAS1AYqMejmraEIqCETNp5fPebpWs/Dtlba3E9CQ
   4/kESXcSETkV59Xix/qOLuW9GJo8PsHnyUEkxrz/pqboH0LWQcf6p0vtj
   3mYSrFFicGPnihPsAYQxDwEUXBmQGb0h9ijkJiKS/MnFmQ9VSiP3hIGHR
   prQnzOQKmvntC8MxujOsZkwBFgSkU3UtCoymguD/zqTF7vqScq0tizi9F
   ckv4pSDeMxtbclGJNyoPRthszWb+3ce9ySWmqDbqIBHuhX5b4/ho1W8MK
   A==;
X-CSE-ConnectionGUID: YiE6TqoZRneTHE8WzpscBQ==
X-CSE-MsgGUID: lxr3J8vmTT2AzW1Dp/+C0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77433269"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77433269"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:46:16 -0700
X-CSE-ConnectionGUID: LFm87fSPQnCCvzv04TBWQA==
X-CSE-MsgGUID: SpjGIn+tR2G4ZroaJnmcig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="233027343"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:46:12 -0700
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
Subject: [PATCH 3/5] selftests/xsk: Remove umem from pkt_generate parameters
Date: Tue, 28 Apr 2026 13:33:14 +0530
Message-ID: <20260428080317.702124-4-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428080317.702124-1-tushar.vyavahare@intel.com>
References: <20260428080317.702124-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9514A480C92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281730-lists,netdev=lfdr.de];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

After moving UMEM ownership to socket-level state, passing UMEM
explicitly into pkt_generate() is redundant and can drift from the
active socket state.

Drop the UMEM parameter and use the socket-attached UMEM directly. This
simplifies call sites and keeps packet generation aligned with the
configured socket/UMEM pairing.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index ad5ada9216fc..ea229ea446ca 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -630,10 +630,10 @@ static void pkt_stream_cancel(struct pkt_stream *pkt_stream)
 	pkt_stream->current_pkt_nb--;
 }
 
-static void pkt_generate(struct xsk_socket_info *xsk, struct xsk_umem_info *umem, u64 addr, u32 len,
-			 u32 pkt_nb, u32 bytes_written)
+static void pkt_generate(struct xsk_socket_info *xsk, u64 addr, u32 len, u32 pkt_nb,
+			 u32 bytes_written)
 {
-	void *data = xsk_umem__get_data(umem->buffer, addr);
+	void *data = xsk_umem__get_data(xsk->umem->buffer, addr);
 
 	if (len < MIN_PKT_SIZE)
 		return;
@@ -1241,7 +1241,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 				tx_desc->options = 0;
 			}
 			if (pkt->valid)
-				pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, pkt->pkt_nb,
+				pkt_generate(xsk, tx_desc->addr, tx_desc->len, pkt->pkt_nb,
 					     bytes_written);
 			bytes_written += tx_desc->len;
 
-- 
2.43.0


