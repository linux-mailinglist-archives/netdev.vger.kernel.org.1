Return-Path: <netdev+bounces-299121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H4WTO+cGLmqNogQAu9opvQ
	(envelope-from <netdev+bounces-299121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:42:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62294680320
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:41:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cQm1azU6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299121-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299121-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D51D4301BEF2
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F62EC0A2;
	Sun, 14 Jun 2026 01:41:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258BB2D8DA8;
	Sun, 14 Jun 2026 01:41:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401274; cv=none; b=Pb4S5vqUbv09NohlHXT5yFJ5zAOAXn8l2sWHl2PcBRM7uJncp1jzNo8no6dPW4KTMUqHj59PM4AeWCLYZc2CQ1F0LF23frs/AW+1+3T7NlJQWiOp/GkfmTqSNqs5gqhp9s8bh0nnQkRKgRy/Vy8omswxQAL+4i0+1JYKokwSeQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401274; c=relaxed/simple;
	bh=xyZtGEyxGtrlTrmoHMvUQ2yEchNKf1dlBSLVD8iPm64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVzkopSluKfGQGYiJYG3OplmUxKZaHHXw2lRjojD4UN+tpyFmf2mo7SGuPgOQ+kn8WJ5XqAIVaE/DlLdfADZdEYCG6JV3UqzqoGIvF/Nrd1Qu27/evCNxPRlGJG93VcIUxwE2hBjOqfxAQ1lyXww9rGoTXqjlhcqSKEW1Al7BbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQm1azU6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED441F00A3E;
	Sun, 14 Jun 2026 01:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401272;
	bh=4uJqwd996Y9svTK5ktWjeQ/Kbl3kcYyFuR+7F5YOaGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cQm1azU676ZZ20++Ar//uu2vjHc964gHH1NhRphSUkmvhQaaXeX1Z65qo1N40vpnO
	 w2QwOCk+ZUxz3NFgpckRO6kAoxd+5qyD3v0gXrrazko8/42eY3I53Z4sX6STzzcfUD
	 nlEeRkVZDpTekfCNE1qs7eedV9CL/XcmUpbrnCmunClVYMShxpbopcUqI98ExxxFmf
	 YvovgUejyhalLLKfDxPjz74wwYhaKfNOKSK+FaaUK9lAkp5YjVpgsMrclfwJB3KxxD
	 s3oePauyRbFJ0McPhGkZzeYSLPxiNV6btZsJT7wbX4SvR5O74Ejcg8i2rT5+IMJ3hE
	 1/jb8j67zOBWQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/5] selftests/bpf: remove sockmap + ktls tests
Date: Sat, 13 Jun 2026 18:40:58 -0700
Message-ID: <20260614014102.461064-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614014102.461064-1-kuba@kernel.org>
References: <20260614014102.461064-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299121-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bpf@vger.kernel.org,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kuba@kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,cloudflare.com,gmail.com,queasysnail.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62294680320

The combination of sockmap and TLS is no longer supported - installing
the TLS ULP on a sockmap socket (and vice versa) is now rejected. Remove
the tests that exercise the combination along with their BPF program;
the file covered nothing but sockmap sockets holding kTLS contexts.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 355 ------------------
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  61 ---
 tools/testing/selftests/bpf/test_sockmap.c    | 227 +----------
 3 files changed, 1 insertion(+), 642 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_ktls.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 6ed8e149e3d5..cda6b22cf759 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -9,7 +9,6 @@
 #include "test_progs.h"
 #include "sockmap_helpers.h"
 #include "test_skmsg_load_helpers.skel.h"
-#include "test_sockmap_ktls.skel.h"
 
 #define MAX_TEST_NAME 80
 #define TCP_ULP 31
@@ -160,249 +159,6 @@ static void test_sockmap_ktls_offload(int family, int sotype)
 		close(p);
 }
 
-static void test_sockmap_ktls_tx_cork(int family, int sotype, bool push)
-{
-	int err, off;
-	int i, j;
-	int start_push = 0, push_len = 0;
-	int c = 0, p = 0, one = 1, sent, recvd;
-	int prog_fd, map_fd;
-	char msg[12] = "hello world\0";
-	char rcv[20] = {0};
-	struct test_sockmap_ktls *skel;
-
-	skel = test_sockmap_ktls__open_and_load();
-	if (!ASSERT_TRUE(skel, "open ktls skel"))
-		return;
-
-	err = create_pair(family, sotype, &c, &p);
-	if (!ASSERT_OK(err, "create_pair()"))
-		goto out;
-
-	prog_fd = bpf_program__fd(skel->progs.prog_sk_policy);
-	map_fd = bpf_map__fd(skel->maps.sock_map);
-
-	err = bpf_prog_attach(prog_fd, map_fd, BPF_SK_MSG_VERDICT, 0);
-	if (!ASSERT_OK(err, "bpf_prog_attach sk msg"))
-		goto out;
-
-	err = bpf_map_update_elem(map_fd, &one, &c, BPF_NOEXIST);
-	if (!ASSERT_OK(err, "bpf_map_update_elem(c)"))
-		goto out;
-
-	err = init_ktls_pairs(c, p);
-	if (!ASSERT_OK(err, "init_ktls_pairs(c, p)"))
-		goto out;
-
-	skel->bss->cork_byte = sizeof(msg);
-	if (push) {
-		start_push = 1;
-		push_len = 2;
-	}
-	skel->bss->push_start = start_push;
-	skel->bss->push_end = push_len;
-
-	off = sizeof(msg) / 2;
-	sent = send(c, msg, off, 0);
-	if (!ASSERT_EQ(sent, off, "send(msg)"))
-		goto out;
-
-	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
-	if (!ASSERT_EQ(-1, recvd, "expected no data"))
-		goto out;
-
-	/* send remaining msg */
-	sent = send(c, msg + off, sizeof(msg) - off, 0);
-	if (!ASSERT_EQ(sent, sizeof(msg) - off, "send remaining data"))
-		goto out;
-
-	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
-	if (!ASSERT_OK(err, "recv(msg)") ||
-	    !ASSERT_EQ(recvd, sizeof(msg) + push_len, "check length mismatch"))
-		goto out;
-
-	for (i = 0, j = 0; i < recvd;) {
-		/* skip checking the data that has been pushed in */
-		if (i >= start_push && i <= start_push + push_len - 1) {
-			i++;
-			continue;
-		}
-		if (!ASSERT_EQ(rcv[i], msg[j], "data mismatch"))
-			goto out;
-		i++;
-		j++;
-	}
-out:
-	if (c)
-		close(c);
-	if (p)
-		close(p);
-	test_sockmap_ktls__destroy(skel);
-}
-
-static void test_sockmap_ktls_tx_no_buf(int family, int sotype, bool push)
-{
-	int c = -1, p = -1, one = 1, two = 2;
-	struct test_sockmap_ktls *skel;
-	unsigned char *data = NULL;
-	struct msghdr msg = {0};
-	struct iovec iov[2];
-	int prog_fd, map_fd;
-	int txrx_buf = 1024;
-	int iov_length = 8192;
-	int err;
-
-	skel = test_sockmap_ktls__open_and_load();
-	if (!ASSERT_TRUE(skel, "open ktls skel"))
-		return;
-
-	err = create_pair(family, sotype, &c, &p);
-	if (!ASSERT_OK(err, "create_pair()"))
-		goto out;
-
-	err = setsockopt(c, SOL_SOCKET, SO_RCVBUFFORCE, &txrx_buf, sizeof(int));
-	err |= setsockopt(p, SOL_SOCKET, SO_SNDBUFFORCE, &txrx_buf, sizeof(int));
-	if (!ASSERT_OK(err, "set buf limit"))
-		goto out;
-
-	prog_fd = bpf_program__fd(skel->progs.prog_sk_policy_redir);
-	map_fd = bpf_map__fd(skel->maps.sock_map);
-
-	err = bpf_prog_attach(prog_fd, map_fd, BPF_SK_MSG_VERDICT, 0);
-	if (!ASSERT_OK(err, "bpf_prog_attach sk msg"))
-		goto out;
-
-	err = bpf_map_update_elem(map_fd, &one, &c, BPF_NOEXIST);
-	if (!ASSERT_OK(err, "bpf_map_update_elem(c)"))
-		goto out;
-
-	err = bpf_map_update_elem(map_fd, &two, &p, BPF_NOEXIST);
-	if (!ASSERT_OK(err, "bpf_map_update_elem(p)"))
-		goto out;
-
-	skel->bss->apply_bytes = 1024;
-
-	err = init_ktls_pairs(c, p);
-	if (!ASSERT_OK(err, "init_ktls_pairs(c, p)"))
-		goto out;
-
-	data = calloc(iov_length, sizeof(char));
-	if (!data)
-		goto out;
-
-	iov[0].iov_base = data;
-	iov[0].iov_len = iov_length;
-	iov[1].iov_base = data;
-	iov[1].iov_len = iov_length;
-	msg.msg_iov = iov;
-	msg.msg_iovlen = 2;
-
-	for (;;) {
-		err = sendmsg(c, &msg, MSG_DONTWAIT);
-		if (err <= 0)
-			break;
-	}
-
-out:
-	if (data)
-		free(data);
-	if (c != -1)
-		close(c);
-	if (p != -1)
-		close(p);
-
-	test_sockmap_ktls__destroy(skel);
-}
-
-static void test_sockmap_ktls_tx_pop(int family, int sotype)
-{
-	char msg[37] = "0123456789abcdefghijklmnopqrstuvwxyz\0";
-	int c = 0, p = 0, one = 1, sent, recvd;
-	struct test_sockmap_ktls *skel;
-	int prog_fd, map_fd;
-	char rcv[50] = {0};
-	int err;
-	int i, m, r;
-
-	skel = test_sockmap_ktls__open_and_load();
-	if (!ASSERT_TRUE(skel, "open ktls skel"))
-		return;
-
-	err = create_pair(family, sotype, &c, &p);
-	if (!ASSERT_OK(err, "create_pair()"))
-		goto out;
-
-	prog_fd = bpf_program__fd(skel->progs.prog_sk_policy);
-	map_fd = bpf_map__fd(skel->maps.sock_map);
-
-	err = bpf_prog_attach(prog_fd, map_fd, BPF_SK_MSG_VERDICT, 0);
-	if (!ASSERT_OK(err, "bpf_prog_attach sk msg"))
-		goto out;
-
-	err = bpf_map_update_elem(map_fd, &one, &c, BPF_NOEXIST);
-	if (!ASSERT_OK(err, "bpf_map_update_elem(c)"))
-		goto out;
-
-	err = init_ktls_pairs(c, p);
-	if (!ASSERT_OK(err, "init_ktls_pairs(c, p)"))
-		goto out;
-
-	struct {
-		int	pop_start;
-		int	pop_len;
-	} pop_policy[] = {
-		/* trim the start */
-		{0, 2},
-		{0, 10},
-		{1, 2},
-		{1, 10},
-		/* trim the end */
-		{35, 2},
-		/* New entries should be added before this line */
-		{-1, -1},
-	};
-
-	i = 0;
-	while (pop_policy[i].pop_start >= 0) {
-		skel->bss->pop_start = pop_policy[i].pop_start;
-		skel->bss->pop_end =  pop_policy[i].pop_len;
-
-		sent = send(c, msg, sizeof(msg), 0);
-		if (!ASSERT_EQ(sent, sizeof(msg), "send(msg)"))
-			goto out;
-
-		recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
-		if (!ASSERT_EQ(recvd, sizeof(msg) - pop_policy[i].pop_len, "pop len mismatch"))
-			goto out;
-
-		/* verify the data
-		 * msg: 0123456789a bcdefghij klmnopqrstuvwxyz
-		 *                  |       |
-		 *                  popped data
-		 */
-		for (m = 0, r = 0; m < sizeof(msg);) {
-			/* skip checking the data that has been popped */
-			if (m >= pop_policy[i].pop_start &&
-			    m <= pop_policy[i].pop_start + pop_policy[i].pop_len - 1) {
-				m++;
-				continue;
-			}
-
-			if (!ASSERT_EQ(msg[m], rcv[r], "data mismatch"))
-				goto out;
-			m++;
-			r++;
-		}
-		i++;
-	}
-out:
-	if (c)
-		close(c);
-	if (p)
-		close(p);
-	test_sockmap_ktls__destroy(skel);
-}
-
 static void run_tests(int family, enum bpf_map_type map_type)
 {
 	int map;
@@ -417,121 +173,10 @@ static void run_tests(int family, enum bpf_map_type map_type)
 	close(map);
 }
 
-/*
- * Regression test for the KTLS + sockmap (verdict) reverse-order UAF.
- *
- * Vulnerable sequence:
- *   1. Insert receiver socket into sockmap with BPF_SK_SKB_VERDICT program.
- *      sk->sk_data_ready becomes sk_psock_verdict_data_ready.
- *   2. Configure TLS RX: tls_sw_strparser_arm() saves
- *      sk_psock_verdict_data_ready as rx_ctx->saved_data_ready.
- *
- * When data arrives, tls_rx_msg_ready() calls saved_data_ready() =
- * sk_psock_verdict_data_ready(), which calls tcp_read_skb() and drains
- * sk_receive_queue via __skb_unlink() without advancing copied_seq.
- * tls_strp_msg_load() then finds the queue empty while tcp_inq() is still
- * non-zero, hits WARN_ON_ONCE(!first), and leaves a dangling frag_list
- * pointer that tls_decrypt_sg() walks — a use-after-free.
- *
- * The fix adds a tls_sw_has_ctx_rx() check to sk_psock_verdict_data_ready(),
- * mirroring what sk_psock_strp_data_ready() already does: when a TLS RX
- * context is present, defer to psock->saved_data_ready (sock_def_readable)
- * instead of calling tcp_read_skb(), so TLS retains sole ownership of the
- * receive queue.  Data is then decrypted and returned correctly by
- * tls_sw_recvmsg().
- */
-static void test_sockmap_ktls_verdict_with_tls_rx(int family, int sotype)
-{
-	struct tls12_crypto_info_aes_gcm_128 crypto_info = {};
-	char send_buf[] = "hello ktls sockmap reverse order";
-	char recv_buf[sizeof(send_buf)] = {};
-	struct test_sockmap_ktls *skel;
-	int c = -1, p = -1, zero = 0;
-	int prog_fd, map_fd;
-	ssize_t n;
-	int err;
-
-	skel = test_sockmap_ktls__open_and_load();
-	if (!ASSERT_TRUE(skel, "open_and_load"))
-		return;
-
-	err = create_pair(family, sotype, &c, &p);
-	if (!ASSERT_OK(err, "create_pair"))
-		goto out;
-
-	prog_fd = bpf_program__fd(skel->progs.prog_skb_verdict_pass);
-	map_fd = bpf_map__fd(skel->maps.sock_map_verdict);
-
-	err = bpf_prog_attach(prog_fd, map_fd, BPF_SK_SKB_VERDICT, 0);
-	if (!ASSERT_OK(err, "bpf_prog_attach sk_skb verdict"))
-		goto out;
-
-	/* Step 1: configure TLS TX on sender (no sockmap involvement) */
-	err = setsockopt(c, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
-	if (!ASSERT_OK(err, "setsockopt(TCP_ULP) client"))
-		goto out;
-
-	crypto_info.info.version = TLS_1_2_VERSION;
-	crypto_info.info.cipher_type = TLS_CIPHER_AES_GCM_128;
-	memset(crypto_info.key, 0x01, sizeof(crypto_info.key));
-	memset(crypto_info.salt, 0x02, sizeof(crypto_info.salt));
-
-	err = setsockopt(c, SOL_TLS, TLS_TX, &crypto_info, sizeof(crypto_info));
-	if (!ASSERT_OK(err, "setsockopt(TLS_TX)"))
-		goto out;
-
-	/* Step 2: insert receiver into sockmap BEFORE TLS RX */
-	err = bpf_map_update_elem(map_fd, &zero, &p, BPF_NOEXIST);
-	if (!ASSERT_OK(err, "bpf_map_update_elem"))
-		goto out;
-
-	/* Step 3: configure TLS RX AFTER sockmap insertion */
-	err = setsockopt(p, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
-	if (!ASSERT_OK(err, "setsockopt(TCP_ULP) server"))
-		goto out;
-
-	err = setsockopt(p, SOL_TLS, TLS_RX, &crypto_info, sizeof(crypto_info));
-	if (!ASSERT_OK(err, "setsockopt(TLS_RX)"))
-		goto out;
-
-	/*
-	 * A buggy kernel hits WARN_ON_ONCE in tls_strp_load_anchor_with_queue
-	 * and may UAF in tls_decrypt_sg here.  With the fix,
-	 * sk_psock_verdict_data_ready defers to sock_def_readable and TLS
-	 * decrypts the record normally.
-	 */
-	n = send(c, send_buf, sizeof(send_buf), 0);
-	if (!ASSERT_EQ(n, (ssize_t)sizeof(send_buf), "send"))
-		goto out;
-
-	n = recv_timeout(p, recv_buf, sizeof(recv_buf), 0, 5);
-	if (!ASSERT_EQ(n, (ssize_t)sizeof(send_buf), "recv"))
-		goto out;
-
-	ASSERT_OK(memcmp(send_buf, recv_buf, sizeof(send_buf)), "data integrity");
-
-out:
-	if (c != -1)
-		close(c);
-	if (p != -1)
-		close(p);
-	test_sockmap_ktls__destroy(skel);
-}
-
 static void run_ktls_test(int family, int sotype)
 {
 	if (test__start_subtest("tls simple offload"))
 		test_sockmap_ktls_offload(family, sotype);
-	if (test__start_subtest("tls tx cork"))
-		test_sockmap_ktls_tx_cork(family, sotype, false);
-	if (test__start_subtest("tls tx cork with push"))
-		test_sockmap_ktls_tx_cork(family, sotype, true);
-	if (test__start_subtest("tls tx egress with no buf"))
-		test_sockmap_ktls_tx_no_buf(family, sotype, true);
-	if (test__start_subtest("tls tx with pop"))
-		test_sockmap_ktls_tx_pop(family, sotype);
-	if (test__start_subtest("tls verdict with tls rx"))
-		test_sockmap_ktls_verdict_with_tls_rx(family, sotype);
 }
 
 void test_sockmap_ktls(void)
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
deleted file mode 100644
index facafeaf4620..000000000000
--- a/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
+++ /dev/null
@@ -1,61 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_endian.h>
-
-int cork_byte;
-int push_start;
-int push_end;
-int apply_bytes;
-int pop_start;
-int pop_end;
-
-struct {
-	__uint(type, BPF_MAP_TYPE_SOCKMAP);
-	__uint(max_entries, 20);
-	__type(key, int);
-	__type(value, int);
-} sock_map SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_SOCKMAP);
-	__uint(max_entries, 2);
-	__type(key, int);
-	__type(value, int);
-} sock_map_verdict SEC(".maps");
-
-SEC("sk_msg")
-int prog_sk_policy(struct sk_msg_md *msg)
-{
-	if (cork_byte > 0)
-		bpf_msg_cork_bytes(msg, cork_byte);
-	if (push_start > 0 && push_end > 0)
-		bpf_msg_push_data(msg, push_start, push_end, 0);
-	if (pop_start >= 0 && pop_end > 0)
-		bpf_msg_pop_data(msg, pop_start, pop_end, 0);
-
-	return SK_PASS;
-}
-
-SEC("sk_msg")
-int prog_sk_policy_redir(struct sk_msg_md *msg)
-{
-	int two = 2;
-
-	bpf_msg_apply_bytes(msg, apply_bytes);
-	return bpf_msg_redirect_map(msg, &sock_map, two, 0);
-}
-
-/*
- * Verdict program for the reverse-order TLS/sockmap regression test.
- * Returns SK_PASS so tcp_read_skb() drains the receive queue via
- * sk_psock_verdict_recv() without calling tcp_eat_skb(), which is
- * the precondition for the KTLS strparser frag_list UAF.
- */
-SEC("sk_skb/verdict")
-int prog_skb_verdict_pass(struct __sk_buff *skb)
-{
-	return SK_PASS;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 76568db7a664..32d6068df4b3 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -26,7 +26,6 @@
 #include <linux/sock_diag.h>
 #include <linux/bpf.h>
 #include <linux/if_link.h>
-#include <linux/tls.h>
 #include <assert.h>
 #include <libgen.h>
 
@@ -41,13 +40,6 @@
 int running;
 static void running_handler(int a);
 
-#ifndef TCP_ULP
-# define TCP_ULP 31
-#endif
-#ifndef SOL_TLS
-# define SOL_TLS 282
-#endif
-
 /* randomly selected ports for testing on lo */
 #define S1_PORT 10000
 #define S2_PORT 10001
@@ -81,10 +73,6 @@ int txmsg_start_pop;
 int txmsg_pop;
 int txmsg_ingress;
 int txmsg_redir_skb;
-int txmsg_ktls_skb;
-int txmsg_ktls_skb_drop;
-int txmsg_ktls_skb_redir;
-int ktls;
 int peek_flag;
 int skb_use_parser;
 int txmsg_omit_skb_parser;
@@ -115,7 +103,6 @@ static const struct option long_options[] = {
 	{"txmsg_pop",	     required_argument,	NULL, 'x'},
 	{"txmsg_ingress", no_argument,		&txmsg_ingress, 1 },
 	{"txmsg_redir_skb", no_argument,	&txmsg_redir_skb, 1 },
-	{"ktls", no_argument,			&ktls, 1 },
 	{"peek", no_argument,			&peek_flag, 1 },
 	{"txmsg_omit_skb_parser", no_argument,      &txmsg_omit_skb_parser, 1},
 	{"whitelist", required_argument,	NULL, 'n' },
@@ -183,7 +170,6 @@ static void test_reset(void)
 	txmsg_pass = txmsg_drop = txmsg_redir = 0;
 	txmsg_apply = txmsg_cork = 0;
 	txmsg_ingress = txmsg_redir_skb = 0;
-	txmsg_ktls_skb = txmsg_ktls_skb_drop = txmsg_ktls_skb_redir = 0;
 	txmsg_omit_skb_parser = 0;
 	skb_use_parser = 0;
 }
@@ -238,71 +224,6 @@ static void usage(char *argv[])
 	printf("\n");
 }
 
-char *sock_to_string(int s)
-{
-	if (s == c1)
-		return "client1";
-	else if (s == c2)
-		return "client2";
-	else if (s == s1)
-		return "server1";
-	else if (s == s2)
-		return "server2";
-	else if (s == p1)
-		return "peer1";
-	else if (s == p2)
-		return "peer2";
-	else
-		return "unknown";
-}
-
-static int sockmap_init_ktls(int verbose, int s)
-{
-	struct tls12_crypto_info_aes_gcm_128 tls_tx = {
-		.info = {
-			.version     = TLS_1_2_VERSION,
-			.cipher_type = TLS_CIPHER_AES_GCM_128,
-		},
-	};
-	struct tls12_crypto_info_aes_gcm_128 tls_rx = {
-		.info = {
-			.version     = TLS_1_2_VERSION,
-			.cipher_type = TLS_CIPHER_AES_GCM_128,
-		},
-	};
-	int so_buf = 6553500;
-	int err;
-
-	err = setsockopt(s, 6, TCP_ULP, "tls", sizeof("tls"));
-	if (err) {
-		fprintf(stderr, "setsockopt: TCP_ULP(%s) failed with error %i\n", sock_to_string(s), err);
-		return -EINVAL;
-	}
-	err = setsockopt(s, SOL_TLS, TLS_TX, (void *)&tls_tx, sizeof(tls_tx));
-	if (err) {
-		fprintf(stderr, "setsockopt: TLS_TX(%s) failed with error %i\n", sock_to_string(s), err);
-		return -EINVAL;
-	}
-	err = setsockopt(s, SOL_TLS, TLS_RX, (void *)&tls_rx, sizeof(tls_rx));
-	if (err) {
-		fprintf(stderr, "setsockopt: TLS_RX(%s) failed with error %i\n", sock_to_string(s), err);
-		return -EINVAL;
-	}
-	err = setsockopt(s, SOL_SOCKET, SO_SNDBUF, &so_buf, sizeof(so_buf));
-	if (err) {
-		fprintf(stderr, "setsockopt: (%s) failed sndbuf with error %i\n", sock_to_string(s), err);
-		return -EINVAL;
-	}
-	err = setsockopt(s, SOL_SOCKET, SO_RCVBUF, &so_buf, sizeof(so_buf));
-	if (err) {
-		fprintf(stderr, "setsockopt: (%s) failed rcvbuf with error %i\n", sock_to_string(s), err);
-		return -EINVAL;
-	}
-
-	if (verbose)
-		fprintf(stdout, "socket(%s) kTLS enabled\n", sock_to_string(s));
-	return 0;
-}
 static int sockmap_init_sockets(int verbose)
 {
 	int i, err, one = 1;
@@ -557,19 +478,6 @@ static int msg_verify_data(struct msghdr *msg, int size, int chunk_sz,
 	for (i = 0, j = 0; i < msg->msg_iovlen && size; i++, j = 0) {
 		unsigned char *d = msg->msg_iov[i].iov_base;
 
-		/* Special case test for skb ingress + ktls */
-		if (i == 0 && txmsg_ktls_skb) {
-			if (msg->msg_iov[i].iov_len < 4)
-				return -EDATAINTEGRITY;
-			if (memcmp(d, "PASS", 4) != 0) {
-				fprintf(stderr,
-					"detected skb data error with skb ingress update @iov[%i]:%i \"%02x %02x %02x %02x\" != \"PASS\"\n",
-					i, 0, d[0], d[1], d[2], d[3]);
-				return -EDATAINTEGRITY;
-			}
-			j = 4; /* advance index past PASS header */
-		}
-
 		for (; j < msg->msg_iov[i].iov_len && size; j++) {
 			if (push > 0 &&
 			    check_cnt == verify_push_start + verify_push_len - push) {
@@ -849,21 +757,6 @@ static int sendmsg_test(struct sockmap_options *opt)
 	else
 		rx_fd = p2;
 
-	if (ktls) {
-		/* Redirecting into non-TLS socket which sends into a TLS
-		 * socket is not a valid test. So in this case lets not
-		 * enable kTLS but still run the test.
-		 */
-		if (!txmsg_redir || txmsg_ingress) {
-			err = sockmap_init_ktls(opt->verbose, rx_fd);
-			if (err)
-				return err;
-		}
-		err = sockmap_init_ktls(opt->verbose, c1);
-		if (err)
-			return err;
-	}
-
 	if (opt->tx_wait_mem) {
 		struct timeval timeout;
 		int rxtx_buf_len = 1024;
@@ -882,7 +775,7 @@ static int sendmsg_test(struct sockmap_options *opt)
 
 	rxpid = fork();
 	if (rxpid == 0) {
-		if (opt->drop_expected || txmsg_ktls_skb_drop)
+		if (opt->drop_expected)
 			_exit(0);
 
 		if (!iov_buf) /* zero bytes sent case */
@@ -1073,26 +966,6 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 		return -1;
 	}
 
-	/* Attach programs to TLS sockmap */
-	if (txmsg_ktls_skb) {
-		if (!txmsg_omit_skb_parser) {
-			links[2] = bpf_program__attach_sockmap(progs[0], map_fd[8]);
-			if (!links[2]) {
-				fprintf(stderr,
-					"ERROR: bpf_program__attach_sockmap (TLS sockmap %i->%i): (%s)\n",
-					bpf_program__fd(progs[0]), map_fd[8], strerror(errno));
-				return -1;
-			}
-		}
-
-		links[3] = bpf_program__attach_sockmap(progs[2], map_fd[8]);
-		if (!links[3]) {
-			fprintf(stderr, "ERROR: bpf_program__attach_sockmap (TLS sockmap): (%s)\n",
-				strerror(errno));
-			return -1;
-		}
-	}
-
 	/* Attach to cgroups */
 	err = bpf_prog_attach(bpf_program__fd(progs[3]), cg_fd, BPF_CGROUP_SOCK_OPS, 0);
 	if (err) {
@@ -1291,34 +1164,6 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 			}
 		}
 
-		if (txmsg_ktls_skb) {
-			int ingress = BPF_F_INGRESS;
-
-			i = 0;
-			err = bpf_map_update_elem(map_fd[8], &i, &p2, BPF_ANY);
-			if (err) {
-				fprintf(stderr,
-					"ERROR: bpf_map_update_elem (c1 sockmap): %d (%s)\n",
-					err, strerror(errno));
-			}
-
-			if (txmsg_ktls_skb_redir) {
-				i = 1;
-				err = bpf_map_update_elem(map_fd[7],
-							  &i, &ingress, BPF_ANY);
-				if (err) {
-					fprintf(stderr,
-						"ERROR: bpf_map_update_elem (txmsg_ingress): %d (%s)\n",
-						err, strerror(errno));
-				}
-			}
-
-			if (txmsg_ktls_skb_drop) {
-				i = 1;
-				err = bpf_map_update_elem(map_fd[7], &i, &i, BPF_ANY);
-			}
-		}
-
 		if (txmsg_redir_skb) {
 			int skb_fd = (test == SENDMSG || test == SENDPAGE) ?
 					p2 : p1;
@@ -1457,10 +1302,6 @@ static void test_options(char *options)
 		append_str(options, "ingress,", OPTSTRING);
 	if (txmsg_redir_skb)
 		append_str(options, "redir_skb,", OPTSTRING);
-	if (txmsg_ktls_skb)
-		append_str(options, "ktls_skb,", OPTSTRING);
-	if (ktls)
-		append_str(options, "ktls,", OPTSTRING);
 	if (peek_flag)
 		append_str(options, "peek,", OPTSTRING);
 }
@@ -1602,57 +1443,6 @@ static void test_txmsg_ingress_redir(int cgrp, struct sockmap_options *opt)
 	test_send(opt, cgrp);
 }
 
-static void test_txmsg_skb(int cgrp, struct sockmap_options *opt)
-{
-	bool data = opt->data_test;
-	int k = ktls;
-
-	opt->data_test = true;
-	ktls = 1;
-
-	txmsg_pass = txmsg_drop = 0;
-	txmsg_ingress = txmsg_redir = 0;
-	txmsg_ktls_skb = 1;
-	txmsg_pass = 1;
-
-	/* Using data verification so ensure iov layout is
-	 * expected from test receiver side. e.g. has enough
-	 * bytes to write test code.
-	 */
-	opt->iov_length = 100;
-	opt->iov_count = 1;
-	opt->rate = 1;
-	test_exec(cgrp, opt);
-
-	txmsg_ktls_skb_drop = 1;
-	test_exec(cgrp, opt);
-
-	txmsg_ktls_skb_drop = 0;
-	txmsg_ktls_skb_redir = 1;
-	test_exec(cgrp, opt);
-	txmsg_ktls_skb_redir = 0;
-
-	/* Tests that omit skb_parser */
-	txmsg_omit_skb_parser = 1;
-	ktls = 0;
-	txmsg_ktls_skb = 0;
-	test_exec(cgrp, opt);
-
-	txmsg_ktls_skb_drop = 1;
-	test_exec(cgrp, opt);
-	txmsg_ktls_skb_drop = 0;
-
-	txmsg_ktls_skb_redir = 1;
-	test_exec(cgrp, opt);
-
-	ktls = 1;
-	test_exec(cgrp, opt);
-	txmsg_omit_skb_parser = 0;
-
-	opt->data_test = data;
-	ktls = k;
-}
-
 /* Test cork with hung data. This tests poor usage patterns where
  * cork can leave data on the ring if user program is buggy and
  * doesn't flush them somehow. They do take some time however
@@ -1908,8 +1698,6 @@ static void test_txmsg_ingress_parser(int cgrp, struct sockmap_options *opt)
 {
 	txmsg_pass = 1;
 	skb_use_parser = 512;
-	if (ktls == 1)
-		skb_use_parser = 570;
 	opt->iov_length = 256;
 	opt->iov_count = 1;
 	opt->rate = 2;
@@ -1918,8 +1706,6 @@ static void test_txmsg_ingress_parser(int cgrp, struct sockmap_options *opt)
 
 static void test_txmsg_ingress_parser2(int cgrp, struct sockmap_options *opt)
 {
-	if (ktls == 1)
-		return;
 	skb_use_parser = 10;
 	opt->iov_length = 20;
 	opt->iov_count = 1;
@@ -1988,7 +1774,6 @@ struct _test test[] = {
 	{"txmsg test redirect wait send mem", test_txmsg_redir_wait_sndmem},
 	{"txmsg test drop", test_txmsg_drop},
 	{"txmsg test ingress redirect", test_txmsg_ingress_redir},
-	{"txmsg test skb", test_txmsg_skb},
 	{"txmsg test apply", test_txmsg_apply},
 	{"txmsg test cork", test_txmsg_cork},
 	{"txmsg test hanging corks", test_txmsg_cork_hangs},
@@ -2085,20 +1870,10 @@ static void test_selftests_sockhash(int cg_fd, struct sockmap_options *opt)
 	__test_selftests(cg_fd, opt);
 }
 
-static void test_selftests_ktls(int cg_fd, struct sockmap_options *opt)
-{
-	opt->map = BPF_SOCKHASH_FILENAME;
-	opt->prepend = "ktls";
-	ktls = 1;
-	__test_selftests(cg_fd, opt);
-	ktls = 0;
-}
-
 static int test_selftest(int cg_fd, struct sockmap_options *opt)
 {
 	test_selftests_sockmap(cg_fd, opt);
 	test_selftests_sockhash(cg_fd, opt);
-	test_selftests_ktls(cg_fd, opt);
 	test_print_results();
 	return 0;
 }
-- 
2.54.0


