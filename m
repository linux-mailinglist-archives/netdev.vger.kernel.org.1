Return-Path: <netdev+bounces-288306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBMjBjwTB2rgrQIAu9opvQ
	(envelope-from <netdev+bounces-288306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:36:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE1354FAB7
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BD933044F81
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9948033F;
	Fri, 15 May 2026 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0aJSVAe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C347F2D3
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848268; cv=none; b=YjJWgXmV1hqXvvdWSurblZ2IZ+4ldq+UiWnTP/BJO9h9zL9q319p3STD/yHLvHYtb4mgQQeZJHuarV9/UiinjTa/v9tQQ99rEs+zNt8TdOoBAbfmO4mIwB4kt2bwYiyiH83fHN5PBQF1RDdzC6NNgz9gugnVutIaDkkShorlPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848268; c=relaxed/simple;
	bh=hs2LmSIgH01STiKcSK/9r7IMxHjaUYifUvfsId0jjzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UyQdpc3jlsVG2ClozbRYZi69iSiWFwNuYrOlbgSCg7Lq18erZSGLecWZZW68a4lWcF+i6SUxeNWth6SEduS7Csmgtmy9M3ZcLSL0tBa5YRJfBKvljTUj3RZWTGjI6k4IeutTYQ4jwiD6Tcsc4vAwDUBcG1zTEfqLEKrXq7Bgu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0aJSVAe; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b458ca2296so62183735ad.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848264; x=1779453064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q3NoUKNJRcKRULVuQjFHc0i+Q4I9vYzom+1zY7kmT0=;
        b=L0aJSVAeiFPPVpYVdcEHPf1wQV6ZahjQreY8P4A3juXOZ5Sthe4/LA19T3b6qOCm6k
         F/vSMDe9pde1PXZ8FdNt028vnpzahd/k2FV4UDP37/2636mBRpCob/1SV7mr7V+Jsn0L
         ZwyH57iec9omXVNaOxyFKocbtSBVXc06bidfIfP/SjwuUzCpwqzSiJ38l9izoyEaf21B
         S9QOB5CalNPN282uXHktwRMo7pyVjYDzRIQDNY0iGKgzKT9VbhyKHPGK89mbrLLr6dis
         rT8bCW0H0zyV7Qi5R2wQb8H3LyGpsuAGkomkMtFv1Pfjz9h1WmDT6ZYnWnY85F/ti1Ed
         W/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848264; x=1779453064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Q3NoUKNJRcKRULVuQjFHc0i+Q4I9vYzom+1zY7kmT0=;
        b=Usbesyp5XVSYMX/UShA7obo7vc5IdSSZNtsv1FfUhI5ucmszEq08qZCuIVsu6zQ4CB
         R0MLmvrjmBmlCUztpSkiD/fx1KIMOJXz9FbOzOCi6HZkijD7+FOfhf05QSrxU00JNmbH
         sKSIPTeXLuGQLx5QT253XQOkyVtQXnsUExcO50KNx7AvveUb8L/YfEf9o1fv6bZbuns+
         /YhA2JoK1NJur+5Pe31nXqGWSfAEjmenJdTQHUf22HXLZuSY0YbQmecPR+q6sOPPdZ2l
         C08PmicxPtlG5O0FxGp3Yjm0Z+m0wS0MzHouf80VVRJOlQyyelbBNY35235BZ0H1rACY
         gMRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/l8H0tXP1I1LOniaGHXMkoR1IG+QA9wEPU1d54zCwrcbdupcdfXDv4NmO2EyN0sayQo0FYAT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgCohpyODaQ3Ell/mP7mL44SnamBDd6ZH6jpKhn1yrRV4iv+y7
	MtLXyOQgualQO8BXQ8BPfKOGoMt0YfpxXjt8zghY1sksXUHh4ug+RC12
X-Gm-Gg: Acq92OGuWm3A3cbtwkgAA5qLgwuJqnqeVa8BB6vZ8YNV3/15ZXq+Rnc9eL9NzJT6hI4
	kD3owCA3cDX/++cv7LL4wx7gqTFd5yH9y6HTYa9VO+RPb5X5AIn++CrOcZ+mc1wAhewJDa6GStB
	KLIm8d7FwGsadjkO6kxXkOYW7iLSD7sLqEO8YReLsXK2NufiA9xrWY9F6yBVQzdctwFZDkPlAcD
	pDrpboE26lJi7li2zfzDXcubwn9soP2jntvwNB7qTs+fVevxX+8a5qJWVDB5zJQhpD4RGyYwXWS
	f3NTtW3LcBWK5lZGlSRf7jsDPfHoCMUlkKKUK4grZCtQCF33TFMPd8GIPfFLrlNTlXm65LOiZXl
	NRpD0hpXJdmv1tV2wJlpMrJXDoRlOLCKlPcq2/b4g35oVgpfnnulywHajpUWEFr88Szpzt5iCsa
	Y+p8vvzWbRvSrQVZP6BQObUOyAImZ3rvUpNIBX7q5WrIZJ//Wm1FXDv2lQlCdSLknNweO7NEyBj
	VMudrx/yCDAbsHgefCoRE3bVmvale0=
X-Received: by 2002:a17:903:1b45:b0:2bd:93b0:2c1c with SMTP id d9443c01a7336-2bd93b02ea0mr13453935ad.3.1778848263992;
        Fri, 15 May 2026 05:31:03 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:a48a:1116:aa2d:1122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe492asm60348885ad.48.2026.05.15.05.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:31:03 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 5/5] selftests/xsk: fix multi-buffer invalid desc tests for drain_cont
Date: Fri, 15 May 2026 20:30:18 +0800
Message-Id: <20260515123018.80147-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260515123018.80147-1-kerneljasonxing@gmail.com>
References: <20260515123018.80147-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5AE1354FAB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288306-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

After the kernel xsk drain_cont patches, dropped and drained
multi-buffer descriptors have their buffer addresses published to the
completion queue (CQ) rather than being cancelled. This is the crucial
and correct way, but it leads to the selftests failure.

In the existing selftest, we need to take care of all the sub-tests
with those two things in mind:
1) Invalid packets whose last descriptor has XDP_PKT_CONTD set
   cause drain_cont to leak past the packet boundary, consuming
   subsequent valid packets from the TX ring.
2) The extra CQ entries from dropped descriptors cause outstanding_tx
   to reach zero before the kernel finishes processing all TX ring
   descriptors, so wait_for_tx_completion() exits early and valid
   packets after invalid ones are never transmitted.

This patch makes the following changes to follow the right fixes.
- XSK_DESC__INVALID_OPTION: change the value from 0xffff to 0xfffe,
  so it no longer sets the XDP_PKT_CONTD bit (bit 0).
- complete_pkts: tolerate extra CQ completions by clamping
  outstanding_tx to zero instead of failing.
- wait_for_tx_completion: add a drain loop that consumes CQ entries
  after outstanding_tx reaches zero. Ensure remaining valid packets
  are transmitted. This change is made because of patch 3 in the
  series adds a logic in __xsk_generic_xmit(): return -EOVERFLOW
  after detecting and handling the remaining part of the skb.
- testapp_invalid_desc_mb: clearing XDP_PKT_CONTD on the last
  descriptor of each invalid test packet, so drain stops at the
  packet boundary.
- testapp_too_many_frags: add one new/extra terminating descriptor
  to the invalid packet, so drain_cont stops before the trailing
  sync packet.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 45 ++++++++++---------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 7e38ec6e656b..e23131ef7f18 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -31,7 +31,7 @@
 #define POLL_TMOUT			1000
 #define THREAD_TMOUT			3
 #define UMEM_HEADROOM_TEST_SIZE		128
-#define XSK_DESC__INVALID_OPTION	(0xffff)
+#define XSK_DESC__INVALID_OPTION	(0xfffe)
 #define XSK_UMEM__INVALID_FRAME_SIZE	(MAX_ETH_JUMBO_SIZE + 1)
 #define XSK_UMEM__LARGE_FRAME_SIZE	(3 * 1024)
 #define XSK_UMEM__MAX_FRAME_SIZE	(4 * 1024)
@@ -969,17 +969,11 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 
 	rcvd = xsk_ring_cons__peek(&xsk->umem->cq, batch_size, &idx);
 	if (rcvd) {
-		if (rcvd > xsk->outstanding_tx) {
-			u64 addr = *xsk_ring_cons__comp_addr(&xsk->umem->cq, idx + rcvd - 1);
-
-			ksft_print_msg("[%s] Too many packets completed\n", __func__);
-			ksft_print_msg("Last completion address: %llx\n",
-				       (unsigned long long)addr);
-			return TEST_FAILURE;
-		}
-
 		xsk_ring_cons__release(&xsk->umem->cq, rcvd);
-		xsk->outstanding_tx -= rcvd;
+		if (rcvd > xsk->outstanding_tx)
+			xsk->outstanding_tx = 0;
+		else
+			xsk->outstanding_tx -= rcvd;
 	}
 
 	return TEST_PASS;
@@ -1293,6 +1287,8 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 {
 	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
+	unsigned int rcvd;
+	u32 idx;
 	int ret;
 
 	ret = gettimeofday(&tv_now, NULL);
@@ -1312,6 +1308,14 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 		complete_pkts(xsk, xsk->batch_size);
 	}
 
+	do {
+		if (xsk_ring_prod__needs_wakeup(&xsk->tx))
+			kick_tx(xsk);
+		rcvd = xsk_ring_cons__peek(&xsk->umem->cq, xsk->batch_size, &idx);
+		if (rcvd)
+			xsk_ring_cons__release(&xsk->umem->cq, rcvd);
+	} while (rcvd);
+
 	return TEST_PASS;
 }
 
@@ -2092,10 +2096,10 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 		{0, 0, 0, false, 0},
 		/* Invalid address in the second frame */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
-		{umem_size, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{umem_size, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, 0},
 		/* Invalid len in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
-		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, 0},
 		/* Invalid options in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XSK_DESC__INVALID_OPTION},
@@ -2250,7 +2254,7 @@ int testapp_too_many_frags(struct test_spec *test)
 		max_frags += 1;
 	}
 
-	pkts = calloc(2 * max_frags + 2, sizeof(struct pkt));
+	pkts = calloc(2 * max_frags + 3, sizeof(struct pkt));
 	if (!pkts)
 		return TEST_FAILURE;
 
@@ -2268,20 +2272,19 @@ int testapp_too_many_frags(struct test_spec *test)
 	}
 	pkts[max_frags].options = 0;
 
-	/* An invalid packet with the max amount of frags but signals packet
-	 * continues on the last frag
-	 */
-	for (i = max_frags + 1; i < 2 * max_frags + 1; i++) {
+	/* An invalid packet with too many frags */
+	for (i = max_frags + 1; i < 2 * max_frags + 2; i++) {
 		pkts[i].len = MIN_PKT_SIZE;
 		pkts[i].options = XDP_PKT_CONTD;
 		pkts[i].valid = false;
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
-- 
2.41.3


