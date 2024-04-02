Return-Path: <netdev+bounces-83972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E51895254
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2C11F225F5
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFEB762EB;
	Tue,  2 Apr 2024 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hD/olzkA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC56997B;
	Tue,  2 Apr 2024 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059337; cv=none; b=hetPqGxYL9qiwVJfDYKjkfcenRsz9jCWB/T/uv17LM9Ub971DksCy84V6ntRFv5I5k2y1OOIgVOinNNzzD8e0u8vwHqK5eQgPMFuMs/PZKvSax6ObdCqkM3fwccrYJfHMfbhz1ktL/LWyYAt10ouA6nhcEvIx+1YVLZHGLDNqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059337; c=relaxed/simple;
	bh=hBmhM4yNE9bIwRPkbyIQxY1VuKDep4BXHxhqAzHSN3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QUbrmizvz/tW/6dLJm2XeihzQgRYDwypSU5zjQpuwoXLa1EIIUQjV3OVnq30oKqUXTHAEbDPWLSYfHttFyeTLWhJwuqgq+e8nXwmRFQN24q96z6DAFdH6prP48B1dDFmg7ClxKhzOc1vBNInQp9JyCKxkq3CREKhfp154giHnnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hD/olzkA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712059336; x=1743595336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hBmhM4yNE9bIwRPkbyIQxY1VuKDep4BXHxhqAzHSN3c=;
  b=hD/olzkAnz6yFXr2fK02XGxtySYZoEvdXYppaTrC8DmNZwe5cS85ZzIn
   7NRy6jp1F30NsYenKll5AU7dy4VGqRAfw3AvQQyqRsddFQCYeEUQ6QAjx
   IdLYGrWHF+2jdoaMiGHRP1ZH7Dyc0z5U4rf14e2qnwoj242plulv6LWqw
   UiKJ9kxGyHXPs/hParW6+gdSPMgIdAg9nOqgO9hId2iGPKj8NGWruOgMQ
   cbc2OZgMIcXCikRMLPfgAc6/nu+IOP17kRVwA9HY8Ty8BJ7oro7GFzMY7
   UCIJRSgUCPQtF4gLwq5ZOwZGX8NX9JZi/4LxM4fjn4QDoqSYYTAv/gEET
   g==;
X-CSE-ConnectionGUID: tutDSEAPTbCP0EV6TISX5A==
X-CSE-MsgGUID: 9+1FyM5mQ1OKByxiBpEf7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7067013"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7067013"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:02:15 -0700
X-CSE-ConnectionGUID: fH9MOJo8SFCfjQTRjRF96Q==
X-CSE-MsgGUID: QEdCavCPRpOAQJWaf0zKog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="55494344"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:02:11 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next v3 2/7] selftests/xsk: make batch size variable
Date: Tue,  2 Apr 2024 11:45:24 +0000
Message-Id: <20240402114529.545475-3-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402114529.545475-1-tushar.vyavahare@intel.com>
References: <20240402114529.545475-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the constant BATCH_SIZE into a variable named batch_size to allow
dynamic modification at runtime. This is required for the forthcoming
changes to support testing different hardware ring sizes.

While running these tests, a bug [1] was identified when the batch size is
roughly the same as the NIC ring size. This has now been addressed by
Maciej's fix.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=913eda2b08cc49d31f382579e2be34c2709eb789

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 20 +++++++++++---------
 tools/testing/selftests/bpf/xskxceiver.h |  3 ++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index b1102ee13faa..eaa102c8098b 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -239,7 +239,7 @@ static void enable_busy_poll(struct xsk_socket_info *xsk)
 		       (void *)&sock_opt, sizeof(sock_opt)) < 0)
 		exit_with_error(errno);
 
-	sock_opt = BATCH_SIZE;
+	sock_opt = xsk->batch_size;
 	if (setsockopt(xsk_socket__fd(xsk->xsk), SOL_SOCKET, SO_BUSY_POLL_BUDGET,
 		       (void *)&sock_opt, sizeof(sock_opt)) < 0)
 		exit_with_error(errno);
@@ -439,6 +439,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 		for (j = 0; j < MAX_SOCKETS; j++) {
 			memset(&ifobj->xsk_arr[j], 0, sizeof(ifobj->xsk_arr[j]));
 			ifobj->xsk_arr[j].rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
+			ifobj->xsk_arr[j].batch_size = DEFAULT_BATCH_SIZE;
 			if (i == 0)
 				ifobj->xsk_arr[j].pkt_stream = test->tx_pkt_stream_default;
 			else
@@ -1087,7 +1088,7 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 			return TEST_CONTINUE;
 	}
 
-	rcvd = xsk_ring_cons__peek(&xsk->rx, BATCH_SIZE, &idx_rx);
+	rcvd = xsk_ring_cons__peek(&xsk->rx, xsk->batch_size, &idx_rx);
 	if (!rcvd)
 		return TEST_CONTINUE;
 
@@ -1239,7 +1240,8 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 
 	buffer_len = pkt_get_buffer_len(umem, pkt_stream->max_pkt_len);
 	/* pkts_in_flight might be negative if many invalid packets are sent */
-	if (pkts_in_flight >= (int)((umem_size(umem) - BATCH_SIZE * buffer_len) / buffer_len)) {
+	if (pkts_in_flight >= (int)((umem_size(umem) - xsk->batch_size * buffer_len) /
+	    buffer_len)) {
 		ret = kick_tx(xsk);
 		if (ret)
 			return TEST_FAILURE;
@@ -1249,7 +1251,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 	fds.fd = xsk_socket__fd(xsk->xsk);
 	fds.events = POLLOUT;
 
-	while (xsk_ring_prod__reserve(&xsk->tx, BATCH_SIZE, &idx) < BATCH_SIZE) {
+	while (xsk_ring_prod__reserve(&xsk->tx, xsk->batch_size, &idx) < xsk->batch_size) {
 		if (use_poll) {
 			ret = poll(&fds, 1, POLL_TMOUT);
 			if (timeout) {
@@ -1269,10 +1271,10 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 			}
 		}
 
-		complete_pkts(xsk, BATCH_SIZE);
+		complete_pkts(xsk, xsk->batch_size);
 	}
 
-	for (i = 0; i < BATCH_SIZE; i++) {
+	for (i = 0; i < xsk->batch_size; i++) {
 		struct pkt *pkt = pkt_stream_get_next_tx_pkt(pkt_stream);
 		u32 nb_frags_left, nb_frags, bytes_written = 0;
 
@@ -1280,9 +1282,9 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 			break;
 
 		nb_frags = pkt_nb_frags(umem->frame_size, pkt_stream, pkt);
-		if (nb_frags > BATCH_SIZE - i) {
+		if (nb_frags > xsk->batch_size - i) {
 			pkt_stream_cancel(pkt_stream);
-			xsk_ring_prod__cancel(&xsk->tx, BATCH_SIZE - i);
+			xsk_ring_prod__cancel(&xsk->tx, xsk->batch_size - i);
 			break;
 		}
 		nb_frags_left = nb_frags;
@@ -1370,7 +1372,7 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 			return TEST_FAILURE;
 		}
 
-		complete_pkts(xsk, BATCH_SIZE);
+		complete_pkts(xsk, xsk->batch_size);
 	}
 
 	return TEST_PASS;
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index f174df2d693f..425304e52f35 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -44,7 +44,7 @@
 #define MAX_ETH_JUMBO_SIZE 9000
 #define USLEEP_MAX 10000
 #define SOCK_RECONF_CTR 10
-#define BATCH_SIZE 64
+#define DEFAULT_BATCH_SIZE 64
 #define POLL_TMOUT 1000
 #define THREAD_TMOUT 3
 #define DEFAULT_PKT_CNT (4 * 1024)
@@ -91,6 +91,7 @@ struct xsk_socket_info {
 	struct pkt_stream *pkt_stream;
 	u32 outstanding_tx;
 	u32 rxqsize;
+	u32 batch_size;
 	u8 dst_mac[ETH_ALEN];
 	u8 src_mac[ETH_ALEN];
 };
-- 
2.34.1


