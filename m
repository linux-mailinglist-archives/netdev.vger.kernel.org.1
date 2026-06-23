Return-Path: <netdev+bounces-301460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OW45MrfSOmqFHwgAu9opvQ
	(envelope-from <netdev+bounces-301460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:38:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7DD6B97A8
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:38:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rbox.co header.s=selector2 header.b=WYuYfGVK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301460-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301460-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=rbox.co;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36E3C30166E5
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEAB388E68;
	Tue, 23 Jun 2026 18:38:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826C61FFE;
	Tue, 23 Jun 2026 18:38:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782239924; cv=none; b=QgIHngDUF6r/Rxxtz7Z+SV+X/qoaBNk0GX845ULjgpuCm0uYlFwQEn9BDa7T396iqglc1BcMaioQ6ejfBl1ZjsdX3vWO0TIfxN6q8PwAdfgcGrcVcsKHS34uqZ+50NF4+nSIM8yRqxQsHR7em5oqOXv6VKUNAwMHJtvZuD4A1vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782239924; c=relaxed/simple;
	bh=hGOZXg+4Pj8RgWzRgCiRrOv/zxm78ySvax8WAt5dwHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2HdQ/nYq2kvkBB2p4Yv35sYB1AMaliicNOty5JY0c0CMrvMgKxB5CNcxvtXBcg6oocAM7f0H31dVkQzZJNEw2/z6ihIsu8jzVEmY6LnDZMVhhwUjijE3KrsFtObkMEnGwjDqct8XnYtioKAQNwgdHib0GhAmzb8cN48b6nqAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=WYuYfGVK; arc=none smtp.client-ip=185.226.149.37
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wc5Td-001WVB-Bm; Tue, 23 Jun 2026 20:04:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=Sti1jCguCRpBBBvquWfU5zjAjdyTJJuitKusSD+nWeE=; b=WYuYfGVKfcZK7LOuvf/wVgI8UH
	xSolqAAnvanY6Z6qpu5Mr+gcjtL6wZBxRQNpL+wsHFI+CoR5XC7yLc34WeUYgCv+kDtjuGsmfM7QX
	KK3Weo+fU51M5TaKgfBf4yAqngUIzqkfD4CEc434J0ift7ltmwICTGljlghBI13IBXVKbr2AlQlxq
	p3GPD++CYVHrGyDu9vRIuka0ggWSahI6r4n1BhQxDw6ZP2z+bB+oS78SAAOpqRv7eQpMONgZ7Mf4p
	WgaX/piN7nBQwszlExV8zK3ON6mRqOxaLYDm71BPuN3vcFIRl8zV81nNI7WE+yPvaHKCLajaXP3Cb
	RAzfLUiw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wc5TX-0006Rz-HL; Tue, 23 Jun 2026 20:03:55 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wc5TR-00GZY0-9K;
	Tue, 23 Jun 2026 20:03:49 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 23 Jun 2026 20:03:10 +0200
Subject: [PATCH bpf 2/2] selftests/bpf: Add test for UDP sock leak on
 sockmap lookup-bind-release
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-sockmap-lookup-udp-leak-v1-2-05804f9308e4@rbox.co>
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
In-Reply-To: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301460-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,linux.dev,davemloft.net,google.com,kernel.org,redhat.com,bytedance.com,iogearbox.net,etsalapatis.com];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:mhal@rbox.co,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rbox.co:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,rbox.co:dkim,rbox.co:email,rbox.co:mid,rbox.co:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A7DD6B97A8

Setup and join a cgroup, then attach a cgroup/connect4 program that runs

   sk = bpf_map_lookup_elem(sockmap, 0)
   bpf_bind(ctx, sa, sizeof(sa))
   bpf_sk_release(sk)

Unpatched kernel leaks the socket.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 50 ++++++++++++++++++++++
 .../bpf/progs/test_sockmap_lookup_bind_release.c   | 37 ++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index cb3229711f93..11972ffdb16e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -7,6 +7,7 @@
 
 #include "test_progs.h"
 #include "test_skmsg_load_helpers.skel.h"
+#include "test_sockmap_lookup_bind_release.skel.h"
 #include "test_sockmap_update.skel.h"
 #include "test_sockmap_invalid_update.skel.h"
 #include "test_sockmap_skb_verdict_attach.skel.h"
@@ -17,6 +18,7 @@
 #include "test_sockmap_msg_pop_data.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
+#include "cgroup_helpers.h"
 #include "sockmap_helpers.h"
 
 #define TCP_REPAIR		19	/* TCP sock is under repair right now */
@@ -1373,6 +1375,52 @@ static void test_sockmap_multi_channels(int sotype)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
+#define LOOKUP_BIND_RELEASE_CG	"/sockmap_lookup-bind-release"
+#define LOOKUP_BIND_RELEASE_REP	64
+
+static void test_sockmap_lookup_bind_release(void)
+{
+	struct test_sockmap_lookup_bind_release *skel;
+	struct sockaddr_in sa;
+	int cg, i;
+
+	cg = cgroup_setup_and_join(LOOKUP_BIND_RELEASE_CG);
+	if (!ASSERT_OK_FD(cg, "cgroup_setup_and_join"))
+		return;
+
+	skel = test_sockmap_lookup_bind_release__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto cleanup;
+
+	skel->links.connect = bpf_program__attach_cgroup(skel->progs.connect, cg);
+	if (!ASSERT_OK_PTR(skel->links.connect, "attach_cgroup"))
+		goto destroy;
+
+	sa.sin_family = AF_INET;
+	sa.sin_port = bpf_htons(1234);
+	sa.sin_addr.s_addr = bpf_htonl(INADDR_LOOPBACK);
+
+	for (i = 0; i < LOOKUP_BIND_RELEASE_REP; ++i) {
+		__close_fd int sk;
+
+		sk = xsocket(AF_INET, SOCK_DGRAM, 0);
+		if (sk < 0)
+			break;
+
+		if (xbpf_map_update_elem(bpf_map__fd(skel->maps.sockmap), &u32(0),
+					 &sk, BPF_ANY))
+			break;
+
+		if (xconnect(sk, (struct sockaddr *)&sa, sizeof(sa)))
+			break;
+	}
+
+destroy:
+	test_sockmap_lookup_bind_release__destroy(skel);
+cleanup:
+	cleanup_cgroup_environment();
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -1451,4 +1499,6 @@ void test_sockmap_basic(void)
 		test_sockmap_multi_channels(SOCK_STREAM);
 	if (test__start_subtest("sockmap udp multi channels"))
 		test_sockmap_multi_channels(SOCK_DGRAM);
+	if (test__start_subtest("sockmap lookup-bind-release"))
+		test_sockmap_lookup_bind_release();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_lookup_bind_release.c b/tools/testing/selftests/bpf/progs/test_sockmap_lookup_bind_release.c
new file mode 100644
index 000000000000..cc77b193893b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_lookup_bind_release.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/in.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sockmap SEC(".maps");
+
+SEC("cgroup/connect4")
+int connect(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock *sk;
+	int ret = SK_DROP;
+
+	sk = bpf_map_lookup_elem(&sockmap, &(int){0});
+	if (sk) {
+		if (sk == ctx->sk) {
+			struct sockaddr_in sa = {
+				.sin_family = ctx->user_family,
+				.sin_port = ctx->user_port,
+				.sin_addr.s_addr = ctx->user_ip4
+			};
+
+			ret = !bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa));
+		}
+
+		bpf_sk_release(sk);
+	}
+
+	return ret;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.54.0


