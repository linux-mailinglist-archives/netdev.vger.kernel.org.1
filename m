Return-Path: <netdev+bounces-305200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TxE0A4D7S2oseAEAu9opvQ
	(envelope-from <netdev+bounces-305200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:01:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7530D714C17
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:01:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=ED24KCNO;
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305200-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305200-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F7C330433D7
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6E83D4121;
	Mon,  6 Jul 2026 18:56:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E1367B9E;
	Mon,  6 Jul 2026 18:56:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364176; cv=none; b=MC5julDKGaml5iaUXk0TaFF3HcNIWF/5t+dW9FuaSCQcNl8kBWoQwvACAdxKkAzxnZrmUzOqMYmkD3lc9BEfPiT0A6Ofd5a8OQSuzix92R9w2FWpZZdGNUVu4EcLCqazSa+yKkV70SikcRJTzlqxR/DUpgirFqrtU7QG7tRmUQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364176; c=relaxed/simple;
	bh=Zz8KjLmVV8oLZr319S5rBhLFi4n0ZT3Sim6NgMGYb5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0pN/WzVD8uNQmRE2/sEmGfbzGnbgo77pUwoMaAmWxPS60BqMmGevIgmL2Dn/4SPOOrSTBqLWvgXl9beivKYsNUqX+hCyhXDTMAoTl1Ejh521mUZLW5YNa3emxxu3vPbKB3cWiBkWYbF1643q4j4CSkzFVPXuJEoc2uG3RiE7qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ED24KCNO; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=nMK6PzCzA/c/AmwS75K8v3GQckv8SLFTcdl9hSYieEU=; b=ED24KCNOrONc+YkYHhmztFUMtq
	68EztArqzovqHJQivNn9djZexYNFKDeI4yQxudIs2UyIWmp/7qB6tpa1+x7IQb68owar/9KiR+vXk
	fV1vvNoiuHf7mcRLCos2I/6HdqhdF5oklIbrDoX6Mq6UO/TZ+GLvLow8xn8C0w/YCDHHzDZYtBa1t
	PqEFD21XiGcvBofdayeaSiG2Z2WR4o7AEZL6znsZKg/Tpt1HbLsfhTKM79fGyooGHB1fbD4WOAo5d
	QzTHNMSbldNiwoLMLBkmheN/iiZa04ZSA+G1LUPfqVEZowPJCCFFbasUmKV4GlVAwNy26PlxS2+A0
	LqKL6yVA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wgoUG-000Psv-2X;
	Mon, 06 Jul 2026 20:56:12 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: pabeni@redhat.com,
	jhs@mojatatu.com,
	bigeasy@linutronix.de,
	andrii@kernel.org,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net v2 3/3] selftests/bpf: Add test for redirect from qdisc qevent block
Date: Mon,  6 Jul 2026 20:56:09 +0200
Message-ID: <20260706185609.330006-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706185609.330006-1-daniel@iogearbox.net>
References: <20260706185609.330006-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28052/Mon Jul  6 08:24:35 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,mojatatu.com,linutronix.de,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305200-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:bigeasy@linutronix.de,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iogearbox.net:from_mime,iogearbox.net:email,iogearbox.net:mid,iogearbox.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7530D714C17

Add a regression test for the NULL current->bpf_net_context deref hit
when a BPF classifier attached to a qdisc qevent block asks for a
redirect. The classifier runs from tcf_qevent_handle() on the qdisc
enqueue path, outside any bpf_net_context.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t qevent
  [...]
  + /etc/rcS.d/S50-startup
  ./test_progs -t qevent
  #496/1   tc_qevent/redirect_verdict:OK
  #496/2   tc_qevent/redirect_helper:OK
  #496     tc_qevent:OK
  Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/tc_qevent.c      | 113 ++++++++++++++++++
 .../selftests/bpf/progs/test_tc_qevent.c      |  23 ++++
 3 files changed, 137 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_qevent.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_qevent.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index adb25146e88c..ea7044f30adc 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -82,6 +82,7 @@ CONFIG_NET_SCH_BPF=y
 CONFIG_NET_SCH_FQ=y
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NET_SCH_HTB=y
+CONFIG_NET_SCH_RED=y
 CONFIG_NET_SCHED=y
 CONFIG_NETDEVSIM=y
 CONFIG_NETFILTER=y
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_qevent.c b/tools/testing/selftests/bpf/prog_tests/tc_qevent.c
new file mode 100644
index 000000000000..67e1d17567ab
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tc_qevent.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <unistd.h>
+#include <string.h>
+
+#include "test_tc_qevent.skel.h"
+
+#define NS_TX		"tc_qevent_tx"
+#define NS_RX		"tc_qevent_rx"
+#define IP_TX		"10.255.0.1"
+#define IP_RX		"10.255.0.2"
+#define PIN_PATH	"/sys/fs/bpf/tc_qevent_redirect"
+
+static void blast_udp(void)
+{
+	struct sockaddr_in dst = {};
+	char buf[1400] = {};
+	int fd, i;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_GE(fd, 0, "udp socket"))
+		return;
+
+	dst.sin_family = AF_INET;
+	dst.sin_port = htons(12345);
+	inet_pton(AF_INET, IP_RX, &dst.sin_addr);
+
+	/*
+	 * Push far more than the RED queue can hold. Once qavg crosses qth_min
+	 * every further packet hits the congestion_drop / early_drop qevent.
+	 */
+	for (i = 0; i < 50000; i++)
+		sendto(fd, buf, sizeof(buf), MSG_DONTWAIT,
+		       (struct sockaddr *)&dst, sizeof(dst));
+
+	close(fd);
+}
+
+static void run_qevent_redirect(struct bpf_program *prog, __u64 *counter)
+{
+	struct nstoken *tok = NULL;
+	int err;
+
+	SYS_NOFAIL("ip netns del %s", NS_TX);
+	SYS_NOFAIL("ip netns del %s", NS_RX);
+	unlink(PIN_PATH);
+
+	err = bpf_program__pin(prog, PIN_PATH);
+	if (!ASSERT_OK(err, "pin prog"))
+		return;
+
+	SYS(unpin,  "ip netns add %s", NS_TX);
+	SYS(del_tx, "ip netns add %s", NS_RX);
+	SYS(del_rx, "ip -n %s link add veth0 type veth peer name veth1 netns %s", NS_TX, NS_RX);
+	SYS(del_rx, "ip -n %s addr add %s/24 dev veth0", NS_TX, IP_TX);
+	SYS(del_rx, "ip -n %s link set veth0 up", NS_TX);
+	SYS(del_rx, "ip -n %s addr add %s/24 dev veth1", NS_RX, IP_RX);
+	SYS(del_rx, "ip -n %s link set veth1 up", NS_RX);
+
+	tok = open_netns(NS_TX);
+	if (!ASSERT_OK_PTR(tok, "open_netns"))
+		goto del_rx;
+
+	SYS(close_ns, "tc qdisc add dev veth0 root handle 1: htb default 1");
+	SYS(close_ns, "tc class add dev veth0 parent 1: classid 1:1 htb rate 1mbit ceil 1mbit");
+
+	if (system("tc qdisc add dev veth0 parent 1:1 handle 11: red "
+		   "limit 500000 avpkt 1000 probability 1 min 5000 max 6000 "
+		   "burst 6 qevent early_drop block 10 2>/dev/null")) {
+		test__skip();
+		goto close_ns;
+	}
+
+	if (system("tc filter add block 10 bpf da object-pinned "
+		   PIN_PATH " 2>/dev/null")) {
+		test__skip();
+		goto close_ns;
+	}
+
+	blast_udp();
+	ASSERT_GT(*counter, 0, "qevent classifier ran");
+close_ns:
+	close_netns(tok);
+del_rx:
+	SYS_NOFAIL("ip netns del %s", NS_RX);
+del_tx:
+	SYS_NOFAIL("ip netns del %s", NS_TX);
+unpin:
+	bpf_program__unpin(prog, PIN_PATH);
+}
+
+void test_tc_qevent(void)
+{
+	struct test_tc_qevent *skel;
+
+	skel = test_tc_qevent__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (test__start_subtest("redirect_verdict"))
+		run_qevent_redirect(skel->progs.qevent_redirect_verdict,
+				    &skel->bss->verdict_calls);
+	if (test__start_subtest("redirect_helper"))
+		run_qevent_redirect(skel->progs.qevent_redirect_helper,
+				    &skel->bss->helper_calls);
+
+	test_tc_qevent__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_qevent.c b/tools/testing/selftests/bpf/progs/test_tc_qevent.c
new file mode 100644
index 000000000000..1529c111f4aa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tc_qevent.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+int redirect_ifindex = 1;
+__u64 verdict_calls = 0;
+__u64 helper_calls = 0;
+
+SEC("tc")
+int qevent_redirect_verdict(struct __sk_buff *skb)
+{
+	__sync_fetch_and_add(&verdict_calls, 1);
+	return TCX_REDIRECT;
+}
+
+SEC("tc")
+int qevent_redirect_helper(struct __sk_buff *skb)
+{
+	__sync_fetch_and_add(&helper_calls, 1);
+	return bpf_redirect(redirect_ifindex, 0);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


