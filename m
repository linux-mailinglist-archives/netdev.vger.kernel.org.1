Return-Path: <netdev+bounces-273674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLNQIYjiy2n0MAYAu9opvQ
	(envelope-from <netdev+bounces-273674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:04:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3173636B586
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D5DD3055A3B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73193FB051;
	Tue, 31 Mar 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4OVXFTy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6B3E9291;
	Tue, 31 Mar 2026 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969370; cv=none; b=dhHfOnlSmj1jdCWe67e/oX53JP/cGyFpfAV5yAy2Adm96nBhXRB7Dg5dFrcL06Do7JBAkNX3DoJzrvT9PXozT6khs7rqqwOPOmBL5pJtpu/0E2Op9q+6ZAfcHllWlFqzeGbi6SyOyUJYx4gp3iLfrRN+UxAxoBPWlZqkcazsT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969370; c=relaxed/simple;
	bh=0AYtxJhoqaYmH/rea/aKqhrXfui+FxIboHIJ69CFgXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9cnYSsnjBcjINXN1t8/WktbAeiA8BywAb5KNzR+rvTQMVyaaPDdcSO6eIouhUz3DkhF++HYJeeBNq1DQ64pmKJKrKFq4RAH+9FpNIEcFocXqa+6ZGIZZCH51IUdpPfK2tdDwoLzKXPNAZDdMQXGM1H1wsoSUjRpRTy77shv7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4OVXFTy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774969370; x=1806505370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0AYtxJhoqaYmH/rea/aKqhrXfui+FxIboHIJ69CFgXA=;
  b=R4OVXFTybzNfLXag4B8zTgVfkp4a+Ds85+oxUmlADrGdqnQTTILQfoXt
   7sUIdkYZAq//0jHgddqtpuTsJ+2ykR0HGXGB1GSRHsn0aGHHpMFPIN2yo
   DOgfYhztt9g0gmEvQ/FXyuFGUwmcooxDBPKFmKoU5AJt5lIi/lIPc97ZY
   zyN7U1Wv/PXi/JOfrdvXFomC4TDdfPuY7YZtHrQfXgxRw+c9jlk5Kn1h7
   R9RbwaWP2kquvHuisEQvjzBCz7CUkPckKGkP0d2gVbgO8TY4TG2+EwAO0
   ltp1b1eioBMfpb/REPNxO7Xv7mYq5laPbF/+fH21NjaDz4XR8YIGdn7ad
   g==;
X-CSE-ConnectionGUID: LT60111qSb+XWWau7gHyQQ==
X-CSE-MsgGUID: ciodOr/zSBapT+3XwaZsjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76046199"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76046199"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:02:43 -0700
X-CSE-ConnectionGUID: 8HKpOHEkRtuykcRKX5WKkA==
X-CSE-MsgGUID: ZLBodek1RJunJhy38HBDFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="219735635"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 31 Mar 2026 08:02:39 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v5 net 08/11] selftests: bpf: adjust rx_dropped xskxceiver's test to respect tailroom
Date: Tue, 31 Mar 2026 17:02:10 +0200
Message-Id: <20260331150213.550797-9-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
References: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273674-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 3173636B586
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since we have changed how big user defined headroom in umem can be,
change the logic in testapp_stats_rx_dropped() so we pass updated
headroom validation in xdp_umem_reg() and still drop half of frames.

Test works on non-mbuf setup so xsk_pool_get_rx_frame_size() that is
called on xsk_rcv_check() will not account skb_shared_info size. Taking
the tailroom size into account in test being fixed is needed as
xdp_umem_reg() defaults to respect it.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index ee60bcc22ee4..a96ca4b39d1e 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1959,15 +1959,17 @@ int testapp_headroom(struct test_spec *test)
 
 int testapp_stats_rx_dropped(struct test_spec *test)
 {
+	u32 umem_tr = test->ifobj_tx->umem_tailroom;
+
 	if (test->mode == TEST_MODE_ZC) {
 		ksft_print_msg("Can not run RX_DROPPED test for ZC mode\n");
 		return TEST_SKIP;
 	}
 
-	if (pkt_stream_replace_half(test, MIN_PKT_SIZE * 4, 0))
+	if (pkt_stream_replace_half(test, (MIN_PKT_SIZE * 2) + umem_tr, 0))
 		return TEST_FAILURE;
 	test->ifobj_rx->umem->frame_headroom = test->ifobj_rx->umem->frame_size -
-		XDP_PACKET_HEADROOM - MIN_PKT_SIZE * 3;
+		XDP_PACKET_HEADROOM - (MIN_PKT_SIZE * 2) - umem_tr - 1;
 	if (pkt_stream_receive_half(test))
 		return TEST_FAILURE;
 	test->ifobj_rx->validation_func = validate_rx_dropped;
-- 
2.43.0


