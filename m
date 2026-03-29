Return-Path: <netdev+bounces-272960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D23BcFpyWnqxwUAu9opvQ
	(envelope-from <netdev+bounces-272960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:04:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 901E5353868
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0DC9300370D
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97317386C20;
	Sun, 29 Mar 2026 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwtRQY79"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C2386578;
	Sun, 29 Mar 2026 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774807480; cv=none; b=nflXGRU7BfdSJQagjlDtMLrS2h1x3oHOOkuVuC5YupBXGb9Mkc2/MfJaKrrbNtdcwU/nDQlDAp/7C/QZ63OViY8xOz+z2Nsna1GQca8BUm7uCZRyLFcNtC9O+NBNAyQwb8UCiKy6WT4aAoDmXRX3SGrN7qJfWbzSokbaeJ0A/mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774807480; c=relaxed/simple;
	bh=RQmJSTgeYlHzTm6YHQv+LZXZKDSGYerO9dS13cpXStY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hc2MSFbmPHd73e1ZML25LpVOezynU84eg2lzKqhESF+sZD0TTZ0luywg/N79WEM5Dz06r4xcRg1b7teH4o/KnjzIMMKvGRCTtOScA24WNEYrxjfhuV3toUsKkOCf9S2Gtg3d+91FJY5tAqteeudNl743pDgNyzd9dswZMilwzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwtRQY79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4148EC2BCB4;
	Sun, 29 Mar 2026 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774807480;
	bh=RQmJSTgeYlHzTm6YHQv+LZXZKDSGYerO9dS13cpXStY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IwtRQY79J1cVcilTK8krJfV5OIFLSUQKrxlcu5IZUTHbJU7nrGabCGU4Yco0QgZ4d
	 oZTw/EmkjzWTavPB2AAbU1TYnKeJxSxkrBFHYn4FEn7PzK61Xmf5cpPmQ8NblYdSD1
	 XQQ0BthWbwdzV0poMovwrOhO4+toDINjIu4/LEs/EamcxcJZxnKmOK2+bX1I3NcVvl
	 N4FxFxWBBLfDuPTHG4eeTXKPjBVvJLy3ApQdT0Ub9NJvFJY8sRNkaxgLaTVvs82Z4Q
	 67FukvqIQxb/QY8xt0Lt0ZpyYh/OUMyXI3XYfFFpehpRt3XSiOEdhBBC3zBYcU9Kdl
	 Fb0uy/+4Jz0pA==
From: Jakub Kicinski <kuba@kernel.org>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: test that dst is cleared on same-protocol encap
Date: Sun, 29 Mar 2026 11:04:28 -0700
Message-ID: <20260329180428.2657785-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329180428.2657785-1-kuba@kernel.org>
References: <20260329180428.2657785-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-272960-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iogearbox.net:email]
X-Rspamd-Queue-Id: 901E5353868
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Verify that bpf_skb_adjust_room() clears the routing dst even when
the encap L3 protocol matches the original packet (e.g. IPIP).
The dst selected for the inner packet is not valid for the
encapsulated result; a stale dst could lead to misrouting.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrii@kernel.org
CC: eddyz87@gmail.com
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: martin.lau@linux.dev
CC: song@kernel.org
CC: yonghong.song@linux.dev
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: sdf@fomichev.me
CC: haoluo@google.com
CC: jolsa@kernel.org
CC: shuah@kernel.org
CC: bpf@vger.kernel.org
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/bpf/prog_tests/test_dst_clear.c | 75 +++++++++++++++++++
 .../selftests/bpf/progs/test_dst_clear.c      | 57 ++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_dst_clear.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_dst_clear.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_dst_clear.c b/tools/testing/selftests/bpf/prog_tests/test_dst_clear.c
new file mode 100644
index 000000000000..8190c56556fb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_dst_clear.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <net/if.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "test_dst_clear.skel.h"
+
+#define NS_TEST "dst_clear_ns"
+#define IPV4_IFACE_ADDR "1.0.0.1"
+#define UDP_TEST_PORT 7777
+
+void test_dst_clear(void)
+{
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_attach);
+	struct nstoken *nstoken = NULL;
+	struct test_dst_clear *skel;
+	struct sockaddr_in addr;
+	socklen_t addrlen;
+	char buf[128] = {};
+	int sockfd, err;
+
+	skel = test_dst_clear__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		return;
+
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/8 dev lo", NS_TEST, IPV4_IFACE_ADDR);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	nstoken = open_netns(NS_TEST);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto fail;
+
+	qdisc_hook.ifindex = if_nametoindex("lo");
+	if (!ASSERT_GT(qdisc_hook.ifindex, 0, "if_nametoindex lo"))
+		goto fail;
+
+	err = bpf_tc_hook_create(&qdisc_hook);
+	if (!ASSERT_OK(err, "create qdisc hook"))
+		goto fail;
+
+	tc_attach.prog_fd = bpf_program__fd(skel->progs.dst_clear);
+	err = bpf_tc_attach(&qdisc_hook, &tc_attach);
+	if (!ASSERT_OK(err, "attach filter"))
+		goto fail;
+
+	addrlen = sizeof(addr);
+	err = make_sockaddr(AF_INET, IPV4_IFACE_ADDR, UDP_TEST_PORT,
+			    (void *)&addr, &addrlen);
+	if (!ASSERT_OK(err, "make_sockaddr"))
+		goto fail;
+	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_NEQ(sockfd, -1, "socket"))
+		goto fail;
+	err = sendto(sockfd, buf, sizeof(buf), 0, (void *)&addr, addrlen);
+	close(sockfd);
+	if (!ASSERT_EQ(err, sizeof(buf), "send"))
+		goto fail;
+
+	ASSERT_TRUE(skel->bss->had_dst, "had_dst");
+	ASSERT_TRUE(skel->bss->dst_cleared, "dst_cleared");
+
+fail:
+	if (nstoken) {
+		bpf_tc_hook_destroy(&qdisc_hook);
+		close_netns(nstoken);
+	}
+	SYS_NOFAIL("ip netns del " NS_TEST);
+	test_dst_clear__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_dst_clear.c b/tools/testing/selftests/bpf/progs/test_dst_clear.c
new file mode 100644
index 000000000000..7ac9604fd99c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_dst_clear.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define UDP_TEST_PORT 7777
+
+void *bpf_cast_to_kern_ctx(void *) __ksym;
+
+bool had_dst = false;
+bool dst_cleared = false;
+
+SEC("tc")
+int dst_clear(struct __sk_buff *skb)
+{
+	struct sk_buff *kskb;
+	struct iphdr iph;
+	struct udphdr udph;
+	int err;
+
+	if (skb->protocol != __bpf_constant_htons(ETH_P_IP))
+		return TC_ACT_OK;
+
+	if (bpf_skb_load_bytes(skb, ETH_HLEN, &iph, sizeof(iph)))
+		return TC_ACT_OK;
+
+	if (iph.protocol != IPPROTO_UDP)
+		return TC_ACT_OK;
+
+	if (bpf_skb_load_bytes(skb, ETH_HLEN + sizeof(iph), &udph, sizeof(udph)))
+		return TC_ACT_OK;
+
+	if (udph.dest != __bpf_constant_htons(UDP_TEST_PORT))
+		return TC_ACT_OK;
+
+	kskb = bpf_cast_to_kern_ctx(skb);
+	had_dst = (kskb->_skb_refdst != 0);
+
+	/* Same-protocol encap (IPIP): protocol stays IPv4, but the dst
+	 * from the original routing is no longer valid for the outer hdr.
+	 */
+	err = bpf_skb_adjust_room(skb, (s32)sizeof(struct iphdr),
+				  BPF_ADJ_ROOM_MAC,
+				  BPF_F_ADJ_ROOM_FIXED_GSO |
+				  BPF_F_ADJ_ROOM_ENCAP_L3_IPV4);
+	if (err)
+		return TC_ACT_SHOT;
+
+	dst_cleared = (kskb->_skb_refdst == 0);
+
+	return TC_ACT_SHOT;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.53.0


