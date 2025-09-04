Return-Path: <netdev+bounces-219861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31EFB43827
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251385806A3
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D622FDC49;
	Thu,  4 Sep 2025 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="duBZzL7b"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59BA2FD1A6;
	Thu,  4 Sep 2025 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980687; cv=none; b=ZzFPxTVhYBCLAbla184gATiroInDx4atrEdyGS7CGBY3cg+0oYy1fz5SNn/aKGnU3XAB/0v9Rw+VcMMg73Tx4d7bnm7odh/A2YxDRirM5ElVjI/m+oEcW3Bw1SqHRMREHZRDXc1tuQgP3177gNb5M7Tk+z97xlbr+Vx3FWancrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980687; c=relaxed/simple;
	bh=YVcckO5jBZAgbvX3OtUxOAoC1bvJIGVV+T1xUWM+My0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rFXVkCT8Y5G1O3VhoWYGz5BbqujOamlSqrGZEecnGIee1bN2pqRoeD0b4povV7b2Mzm36YbpORPOV4C+IpnGkyhdkmQUB2wTbDIP38Dznqg8yTBloHp2zh3MU4031ZIIlW9KhJS193tHvJW4juN44TB1jG0YhcKyM8eXUXxk+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=duBZzL7b; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3B5CBC8EC7F;
	Thu,  4 Sep 2025 10:11:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 63EC6606BB;
	Thu,  4 Sep 2025 10:11:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4CB841C22DC75;
	Thu,  4 Sep 2025 12:11:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756980681; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ulz9LCgOlPLFkcXBBcxm3XotfG+b0NSQamGGLR8FGsg=;
	b=duBZzL7bsDj/DxSdRfajyc+GQHTJm4gEWZum9+PMEpixHd3BxjggkdMu39FDL6Zlu4JeYG
	NQnT+XIWx0oS7neruqwrDd+JM1kPYyayLr9Yy3Gb+Idx7gq0Yuo6SBm+Tk/7JLn+itiUE2
	kcyRSa9hXAp8CL3gFm8f+wop9PvuzaTbrRNFNM6f00e6fDSeSEQN8+QKaSkNcLW937YRnr
	efWF41uAvqpBPF/bxnVW3F2H0t9JaNDJN7jB4h1qDxIoIyJ45RmqAk+DMGRbWBXOpEHl8u
	PvY4dXrBhoYZyibZET9QC92TDbUxLiHQ+nLBIVVNnmYPmdQiqkfowRwUKU1oag==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 04 Sep 2025 12:10:18 +0200
Subject: [PATCH bpf-next v3 03/14] selftests/bpf: test_xsk: Fix memory
 leaks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-xsk-v3-3-ce382e331485@bootlin.com>
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
In-Reply-To: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Some tests introduce memory leaks by not freeing all the pkt_stream
objects they're creating.

Fix these memory leaks.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 37752b2dad651b36d155051931d7b3b902fac403..e4059c7d0a289449a6b73669fa87f7440b7f55c0 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -546,6 +546,13 @@ static void pkt_stream_receive_half(struct test_spec *test)
 	struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
 	u32 i;
 
+	if (test->ifobj_rx->xsk->pkt_stream != test->rx_pkt_stream_default)
+		/* Packet stream has already been replaced so we have to release this one.
+		 * The newly created one will be freed by the restore_default() at the
+		 * end of the test
+		 */
+		pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
+
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(pkt_stream->nb_pkts,
 							      pkt_stream->pkts[0].len);
 	pkt_stream = test->ifobj_rx->xsk->pkt_stream;
@@ -573,6 +580,22 @@ static void pkt_stream_even_odd_sequence(struct test_spec *test)
 	}
 }
 
+static void release_even_odd_sequence(struct test_spec *test)
+{
+	struct pkt_stream *later_free_tx = test->ifobj_tx->xsk->pkt_stream;
+	struct pkt_stream *later_free_rx = test->ifobj_rx->xsk->pkt_stream;
+	int i;
+
+	for (i = 0; i < test->nb_sockets; i++) {
+		/* later_free_{rx/tx} will be freed by restore_default() */
+		if (test->ifobj_tx->xsk_arr[i].pkt_stream != later_free_tx)
+			pkt_stream_delete(test->ifobj_tx->xsk_arr[i].pkt_stream);
+		if (test->ifobj_rx->xsk_arr[i].pkt_stream != later_free_rx)
+			pkt_stream_delete(test->ifobj_rx->xsk_arr[i].pkt_stream);
+	}
+
+}
+
 static u64 pkt_get_addr(struct pkt *pkt, struct xsk_umem_info *umem)
 {
 	if (!pkt->valid)
@@ -1874,6 +1897,7 @@ int testapp_stats_tx_invalid_descs(struct test_spec *test)
 int testapp_stats_rx_full(struct test_spec *test)
 {
 	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
+	pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
 	test->ifobj_rx->xsk->rxqsize = DEFAULT_UMEM_BUFFERS;
@@ -1885,6 +1909,7 @@ int testapp_stats_rx_full(struct test_spec *test)
 int testapp_stats_fill_empty(struct test_spec *test)
 {
 	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
+	pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
 	test->ifobj_rx->use_fill_ring = false;
@@ -2043,6 +2068,7 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 {
 	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
 	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
+	int ret;
 
 	test->total_steps = 1;
 	test->nb_sockets = 2;
@@ -2053,7 +2079,11 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 
 	pkt_stream_even_odd_sequence(test);
 
-	return testapp_validate_traffic(test);
+	ret = testapp_validate_traffic(test);
+
+	release_even_odd_sequence(test);
+
+	return ret;
 }
 
 int testapp_poll_txq_tmout(struct test_spec *test)

-- 
2.50.1


