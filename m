Return-Path: <netdev+bounces-304200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1p9VNdBvRmpGVAsAu9opvQ
	(envelope-from <netdev+bounces-304200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:04:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C54476F8AA3
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:03:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=EpFBEDHm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304200-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304200-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B450300184D
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F34F4BC01F;
	Thu,  2 Jul 2026 14:01:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A7C4B8DE1;
	Thu,  2 Jul 2026 14:01:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000878; cv=none; b=XNdIAIHKGBXKf2/7Z1Tzfj/WWa7gK5fEJMOY+E+x/l+RuQ/aIuF/IYi2/SM5iE3Rrb2vdA2gDcaOp0xCXnOeO+HKwxU+Am3H6idxpJ9ScxEVOgnF4qvh8bCEvbXJfDo0NA7XzJ5HExRD397MknJPf95ED9+UI37O+W/uQfPmd34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000878; c=relaxed/simple;
	bh=l2GDWoCRl2ghl3QVXEouQl50bAeAFW2E2Xq1bfIvgCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQZeLhPMaewSlDTow0VhFUXB2C7w47H1HWJ5WfDoN3gfdo0+ut21mjuVrrGFZkDhkceFYZQ5ZPVXK3X5uKMyHDv3LUbJUsQkqhNKvJKg2LmJUp1v9R9l4PSRtXJR6sG9vuZ6VRyBAHjhKMxs5k0RsxXvk0KCcC6zEFh1yhXovhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EpFBEDHm; arc=none smtp.client-ip=113.46.200.216
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UYEcfABS3rXsYIi9GxuFgomvsuhp90fOfMtQFJDuxrs=;
	b=EpFBEDHmHYonqtjecPBEkCYGvBXdhJPvuTD+abyCOSL8AEWwP/ckMt8DAiaP9Q9p2p3P2QxQf
	053hDzFgZIuFwxCpRIpNVh+/ft6oKPqlE6YYBVXFTFLR9pz3nc3YdQpt5ynwgURZ6ckWz4enXqG
	4b1SBRf3VfaQG+JeO7mmh2o=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4grdbT4LrFz1T4yw;
	Thu,  2 Jul 2026 21:51:49 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1434D40561;
	Thu,  2 Jul 2026 22:00:42 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 2 Jul 2026 22:00:41 +0800
Received: from localhost.localdomain (10.50.85.175) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 2 Jul 2026 22:00:41 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <daniel@iogearbox.net>, <edumazet@google.com>, <ncardwell@google.com>,
	<kuniyu@google.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<jiayuan.chen@linux.dev>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <zhangchangzhong@huawei.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: [PATCH net 2/2] selftests/bpf: cover sockmap drop after partial TCP read
Date: Thu, 2 Jul 2026 22:09:59 +0800
Message-ID: <20260702140959.1806754-3-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260702140959.1806754-1-dongchenchen2@huawei.com>
References: <20260702140959.1806754-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200002.china.huawei.com (7.202.195.90)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304200-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:zhangchangzhong@huawei.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:dongchenchen2@huawei.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,google.com,gmail.com,cloudflare.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[dongchenchen2@huawei.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongchenchen2@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C54476F8AA3

Add a regression test for a TCP socket that is partially read before it
is inserted into a sockmap with an SK_DROP verdict.

The test leaves part of the original skb on the receive queue, adds the
socket to the map, and sends another byte to drive the verdict path.
After removing the socket from the map, it invokes TCP_ZEROCOPY_RECEIVE
on newly arrived native data.

Without the tcp_eat_skb() fix, copied_seq includes the already consumed
prefix, TCP_ZEROCOPY_RECEIVE triggers the sequence warning, and no data
is copied. With the fix, the new byte is copied without a warning.

Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index cb3229711f93..106dd03cde84 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1275,6 +1275,77 @@ static void test_sockmap_copied_seq(bool strp)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
+static void test_sockmap_drop_after_partial_read(void)
+{
+	int map, err, sent, recvd, zero = 0, on = 1;
+	struct test_sockmap_drop_prog *skel;
+	int c0 = -1, p0 = -1, c1 = -1, p1 = -1;
+	struct tcp_zerocopy_receive zc = {};
+	socklen_t zc_len = sizeof(zc);
+	char buf[200] = {}, rcv[50], addr[100];
+	struct bpf_program *prog;
+
+	skel = test_sockmap_drop_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1))
+		goto end;
+
+	sent = xsend(c0, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(sent, sizeof(buf), "xsend(native)"))
+		goto end;
+
+	recvd = recv_timeout(p0, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
+	if (!ASSERT_EQ(recvd, sizeof(rcv), "recv_timeout(partial)"))
+		goto end;
+
+	prog = skel->progs.prog_skb_verdict;
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+	err = bpf_prog_attach(bpf_program__fd(prog), map,
+			      BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto end;
+
+	err = bpf_map_update_elem(map, &zero, &p0, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto end;
+
+	sent = xsend(c0, buf, 1, 0);
+	if (!ASSERT_EQ(sent, 1, "xsend(drop)"))
+		goto end;
+
+	err = bpf_map_delete_elem(map, &zero);
+	if (!ASSERT_OK(err, "bpf_map_delete_elem"))
+		goto end;
+
+	sent = xsend(c0, buf, 1, 0);
+	if (!ASSERT_EQ(sent, 1, "xsend(native again)"))
+		goto end;
+
+	err = setsockopt(p0, SOL_SOCKET, SO_ZEROCOPY, &on, sizeof(on));
+	if (!ASSERT_OK(err, "setsockopt(SO_ZEROCOPY)"))
+		goto end;
+
+	zc.copybuf_address = (__u64)(unsigned long)addr;
+	zc.copybuf_len = sizeof(addr);
+	err = getsockopt(p0, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, &zc, &zc_len);
+	if (!ASSERT_OK(err, "getsockopt(TCP_ZEROCOPY_RECEIVE)"))
+		goto end;
+
+	ASSERT_EQ(zc.copybuf_len, 1, "TCP_ZEROCOPY_RECEIVE copied");
+end:
+	if (c0 >= 0)
+		close(c0);
+	if (p0 >= 0)
+		close(p0);
+	if (c1 >= 0)
+		close(c1);
+	if (p1 >= 0)
+		close(p1);
+	test_sockmap_drop_prog__destroy(skel);
+}
+
 /* Wait until FIONREAD returns the expected value or timeout */
 static int wait_for_fionread(int fd, int expected, unsigned int timeout_ms)
 {
@@ -1447,6 +1518,8 @@ void test_sockmap_basic(void)
 		test_sockmap_copied_seq(false);
 	if (test__start_subtest("sockmap recover with strp"))
 		test_sockmap_copied_seq(true);
+	if (test__start_subtest("sockmap drop after partial read"))
+		test_sockmap_drop_after_partial_read();
 	if (test__start_subtest("sockmap tcp multi channels"))
 		test_sockmap_multi_channels(SOCK_STREAM);
 	if (test__start_subtest("sockmap udp multi channels"))
-- 
2.43.0


