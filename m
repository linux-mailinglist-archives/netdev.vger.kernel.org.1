Return-Path: <netdev+bounces-307588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wHrwHLaeVmrP/AAAu9opvQ
	(envelope-from <netdev+bounces-307588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:40:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8233758C45
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:40:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ooSAJlV0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307588-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307588-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CF7C30D0366
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9A1427F9A;
	Tue, 14 Jul 2026 20:39:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5F73C8717
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 20:39:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061589; cv=none; b=a6XY6Fy6k9l9U1SvwXE4P6bL/a0y92jXVIE3LNsGNq2+PsV51MZNnafShZFeuN4xsyekDjResygdAKSVdSeFj3adRJC1Pf6++0+lLemSr25mbAT6C+cOHtB5as00hfigpmlKceoFMZyKjtAFgmzGmFt291QREN4gpZUCNLbEDSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061589; c=relaxed/simple;
	bh=/gSEwmdBlYPN7aqOOHwPDQmA+v6n14Rv3v5K3iZYEPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9cJTI9WM+FyGxxJTlb09hvLx1F5D3RG4An3pxt23w/Dz76U+051tKS6RumTnw7iBoViDWaff7I/+aQT3Aks8pN14+x7wRtNrmtLLrj9skFrPAzRXubVmWoK0oz9ZIW/zXYQRBA7/JOZLthDgtDaIw+VQOmVz/Ym5QU/HoFPb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ooSAJlV0; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso34176865e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784061586; x=1784666386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fle1iZbssca8vJW2Vmh1UL73wszHnxSFVeGIJaGDBIk=;
        b=ooSAJlV0KqUx358cy1NVR3/YyV8cPyg1MSJ8jNlyhHE8f4LVR7RJEGcbQIjvm518uh
         +OZkcNQJg2NxTx80hedwszCvRMsv9J94Acls+DdbDN+Lwq2z9g/DGwV2sFunRECM+ond
         UGozN62ZWiOagUqiQI+sGQ49DtGhpGPpz+vKsK+PFAmOFuYMmeUNCDeOhLF/uoVQsJC6
         C8gjh/N45MgTDojHx/NhrbbeGCJ4OciYhGFWvdgeXKg68Mz5UzYT5WryUVPiLG8ytDcc
         JsEOZA/dzyg6x1HQLS8kazSeELWNh+6GnKORDuDEmF2Q8iLoQEniaKxYE+FG4Ph2WUHf
         MIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061586; x=1784666386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fle1iZbssca8vJW2Vmh1UL73wszHnxSFVeGIJaGDBIk=;
        b=UApC3NxE/zjii8PbrLR0QlsNg87pgtsUs18JOIpqLhOln9Wh6CH110KRIvF4jnmetu
         eNlAxzrTcVXmEkih+juQfYYMGnhLvayvmRLwblveNL5pgQrN2VmMH//TzXb08xq5yJ/R
         WdDERVwo0euxuvXE0Q/vpU72Li7EQZ7uBvuNQIoVHE6gIo3zJDA/GFyE4QAeFjdfatpR
         Lpe2CthoPyQUM61EyPVw1ohs9+L3K+N2HwfIVzskQku5WX/1BIIZOhUibkDmaIhLFZDR
         owC9LFMEi9J7kUgUb7fuqDpHarv1ownHvhJRhPN1PD3YyVzxeQDbA8ktyPVVUGT5Vkfm
         ioXg==
X-Forwarded-Encrypted: i=1; AHgh+RqlfDCX1pBQg/aNgZxfVqc+8Dfr1xE2QQBUCBlwlAWWeh+Da1Kd67XEV83y1J8kCnsxAyiH9Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGFVTTxc2i9VctRaSd9atAkOfTU41jIWKYwtQ/RDdFx4lIbK55
	Dt79I7m9HSP13ChcnptjVS32aSZlcKYQsPgXUlfvBKMzeIjd9b6Ru8DH
X-Gm-Gg: AfdE7cmdWsH13uhmmgqB++vyS4Er1CEYi4dSAAm7IpZ406Rp4HXeek3RRK6N+ucRVv3
	aPcyAWJQEwlVsB4vqD67N8Sk8PHlrARtqvOibPEK2UJLC5sNAzH0ig9unsTIX/pxdNUuw91K493
	qYYZopGkI98Y/2Zhqn/GUAaiskJcv45ufK6F9xtGs7C0+o9xqhxQmCJ8MiVutcc4NbxC8rZjIQA
	ORhCX39E0fzPq/bQbGAfkG4RbiT0Y0dSkoY24D1IbOEmep9asM7n6BFiZpiNtbfhm7HSPjQURtD
	iW7FFD5bwO6pp3nH22Gmk8NW50hHxPU06Ge1TvTHi4qOxLeeDGfyjzZrKoDARycC0eQJD6iE/mj
	WnXPUeMFdN0bGuzr50owkWPv8Mdu45vHYZESH8OppJlF367232wkgGNJfQfoupAvEzdUAQ43LZK
	3jvNWjbncoV/S8E1pOPI9mt+oCvqNYYMJpwcq5S+nSFMF3zeyViousP4+HyObqYhbz95/VUTDGG
	2hx
X-Received: by 2002:a05:600c:524b:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-495159060f6mr61356335e9.24.1784061586300;
        Tue, 14 Jul 2026 13:39:46 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32c65asm98894115e9.14.2026.07.14.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:39:45 -0700 (PDT)
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: jiayuan.chen@linux.dev
Cc: nnamdio@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: [PATCH v3 2/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Tue, 14 Jul 2026 21:39:27 +0100
Message-ID: <20260714203927.32289-3-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260714203927.32289-1-nnamdio@gmail.com>
References: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
 <20260714203927.32289-1-nnamdio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307588-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:nnamdio@gmail.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:sashiko-reviews@lists.linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nnamdio@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nnamdio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bpf.mk:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8233758C45

This selftest exercises the tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser()
functions, to ensure that they are properly handling spurious wakeups in
tcp_msg_wait_data().

The expected behaviour is that:

  * Without a timeout - recvfrom() does not return an EAGAIN error.

  * With a timeout - recvfrom() returns EAGAIN, but only after the
    SO_RCVTIMEO timeout has expired.

If the spurious wakeups are not correctly handled, the above assertions
fail.

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
 tools/testing/selftests/net/.gitignore        |   2 +
 tools/testing/selftests/net/Makefile          |   6 +
 .../selftests/net/sockmap_recvfrom.bpf.c      |  31 ++
 .../testing/selftests/net/sockmap_recvfrom.c  | 288 ++++++++++++++++++
 4 files changed, 327 insertions(+)
 create mode 100644 tools/testing/selftests/net/sockmap_recvfrom.bpf.c
 create mode 100644 tools/testing/selftests/net/sockmap_recvfrom.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index c9f46031ac73..a1840a5d45f6 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -39,6 +39,8 @@ sk_connect_zero_addr
 sk_so_peek_off
 skf_net_off
 socket
+sockmap_recvfrom
+sockmap_recvfrom.bpf.o
 so_incoming_cpu
 so_netns_cookie
 so_rcv_listener
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 708d960ae07d..a05a4a924402 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -161,6 +161,7 @@ TEST_GEN_FILES := \
 	so_netns_cookie \
 	so_rcv_listener \
 	socket \
+	sockmap_recvfrom.bpf.o \
 	stress_reuseport_listen \
 	tcp_fastopen_backup_key \
 	tcp_inq \
@@ -191,6 +192,7 @@ TEST_GEN_PROGS := \
 	sk_connect_zero_addr \
 	sk_so_peek_off \
 	so_incoming_cpu \
+	sockmap_recvfrom \
 	tap \
 	tcp_port_share \
 	tls \
@@ -238,3 +240,7 @@ $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
 $(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
 
 include bpf.mk
+
+$(OUTPUT)/sockmap_recvfrom: $(BPFOBJ)
+$(OUTPUT)/sockmap_recvfrom: LDLIBS += $(BPFOBJ) -lelf -lz -lpthread
+$(OUTPUT)/sockmap_recvfrom: CFLAGS += -I$(OUTPUT)/tools/include
diff --git a/tools/testing/selftests/net/sockmap_recvfrom.bpf.c b/tools/testing/selftests/net/sockmap_recvfrom.bpf.c
new file mode 100644
index 000000000000..fec470c738f1
--- /dev/null
+++ b/tools/testing/selftests/net/sockmap_recvfrom.bpf.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+#define AF_INET 2
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, 1024);
+	__type(key, __u64);
+	__type(value, __u64);
+
+} map_socks SEC(".maps");
+
+SEC("sockops") int on_sockops(struct bpf_sock_ops *ctx)
+{
+	if (ctx->family == AF_INET && ctx->op == BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB) {
+		__u64 cookie = bpf_get_socket_cookie(ctx);
+
+		bpf_sock_hash_update(ctx, &map_socks, &cookie, BPF_NOEXIST);
+	}
+
+	return 0;
+}
+
+SEC("sk_skb/stream_verdict") int on_recv(struct __sk_buff *ctx)
+{
+	return SK_PASS;
+}
diff --git a/tools/testing/selftests/net/sockmap_recvfrom.c b/tools/testing/selftests/net/sockmap_recvfrom.c
new file mode 100644
index 000000000000..f96b4673c977
--- /dev/null
+++ b/tools/testing/selftests/net/sockmap_recvfrom.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <arpa/inet.h>
+#include <bpf/libbpf.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <stdatomic.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <unistd.h>
+
+#include "kselftest_harness.h"
+
+#define MAX_ITERATIONS 100
+#define PAYLOAD_END 'e'
+
+static int start_listening(struct __test_metadata *_metadata, uint16_t *port)
+{
+	struct sockaddr_in addr;
+	socklen_t addrlen;
+	int fd;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = INADDR_ANY;
+
+	fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+
+	ASSERT_NE(fd, -1);
+	ASSERT_EQ(bind(fd, (struct sockaddr *)&addr, sizeof(addr)), 0);
+	ASSERT_EQ(listen(fd, 5), 0);
+
+	addrlen = sizeof(addr);
+
+	ASSERT_EQ(getsockname(fd, (struct sockaddr *)&addr, &addrlen), 0);
+
+	*port = addr.sin_port;
+
+	return fd;
+}
+
+static void process_client(struct __test_metadata *_metadata, int fd, atomic_int *running)
+{
+	char buf[1024];
+	struct timeval timeo;
+
+	timeo.tv_sec = 0;
+	timeo.tv_usec = 1000;
+
+	EXPECT_EQ(setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo)), 0);
+
+	while (atomic_load(running)) {
+		ssize_t len = recvfrom(fd, buf, sizeof(buf), 0, NULL, NULL);
+
+		if (len == -1) {
+			EXPECT_TRUE(errno == EAGAIN || errno == EINTR);
+			continue;
+		}
+
+		EXPECT_GE(len, 0);
+
+		if (len <= 0 || buf[len - 1] == PAYLOAD_END)
+			break;
+	}
+
+	write(fd, "test", 4);
+
+	close(fd);
+}
+
+struct bpf_t {
+	struct bpf_object *obj;
+	struct bpf_link *on_sockops;
+	struct bpf_link *on_recv;
+};
+
+static void setup_bpf(struct __test_metadata *_metadata, const char *path, bool recv,
+						struct bpf_t *bpf)
+{
+	struct bpf_program *prog;
+	int cgroup;
+
+	memset(bpf, 0, sizeof(*bpf));
+	bpf->obj = bpf_object__open_file(path, NULL);
+
+	ASSERT_NE(bpf->obj, NULL);
+	ASSERT_EQ(bpf_object__load(bpf->obj), 0);
+
+	prog = bpf_object__find_program_by_name(bpf->obj, "on_sockops");
+	ASSERT_NE(prog, NULL);
+
+	cgroup = open("/sys/fs/cgroup", O_RDONLY);
+	ASSERT_NE(cgroup, -1);
+
+	bpf->on_sockops = bpf_program__attach_cgroup(prog, cgroup);
+	close(cgroup);
+
+	ASSERT_NE(bpf->on_sockops, NULL);
+
+	if (recv) {
+		struct bpf_map *map = bpf_object__find_map_by_name(bpf->obj, "map_socks");
+
+		ASSERT_NE(map, NULL);
+
+		prog = bpf_object__find_program_by_name(bpf->obj, "on_recv");
+		ASSERT_NE(prog, NULL);
+
+		bpf->on_recv = bpf_program__attach_sockmap(prog, bpf_map__fd(map));
+		ASSERT_NE(bpf->on_recv, NULL);
+	}
+}
+
+struct server_t {
+	int fd;
+	atomic_int running;
+	pthread_t thread;
+	struct __test_metadata *metadata;
+};
+
+static void *run_server(void *arg)
+{
+	struct server_t *server = arg;
+	struct __test_metadata *_metadata = server->metadata;
+
+	while (atomic_load(&server->running)) {
+		int client_fd = accept(server->fd, NULL, NULL);
+
+		if (client_fd == -1) {
+			if (!atomic_load(&server->running))
+				break;
+
+			continue;
+		}
+
+		process_client(_metadata, client_fd, &server->running);
+	}
+
+	return NULL;
+}
+
+static int send_payload(struct __test_metadata *_metadata, int fd, const char *buf, size_t len)
+{
+	size_t remaining = len;
+
+	do {
+		ssize_t bytes = write(fd, buf + (len - remaining), remaining);
+
+		if (bytes < 0) {
+			if (errno == EINTR)
+				continue;
+
+			return -1;
+		}
+
+		remaining -= bytes;
+	} while (remaining);
+
+	return 0;
+}
+
+FIXTURE(sockmap_recvfrom)
+{
+	struct server_t server;
+	struct sockaddr_in addr;
+	struct bpf_t bpf;
+	char *payload;
+	size_t payload_len;
+};
+
+FIXTURE_VARIANT(sockmap_recvfrom)
+{
+	bool with_recv;
+};
+
+FIXTURE_VARIANT_ADD(sockmap_recvfrom, recvmsg)
+{
+	.with_recv = false
+};
+
+FIXTURE_VARIANT_ADD(sockmap_recvfrom, recvmsg_parser)
+{
+	.with_recv = true
+};
+
+FIXTURE_SETUP(sockmap_recvfrom)
+{
+	memset(&self->addr, 0, sizeof(self->addr));
+
+	self->payload_len = 1024 * 1024 * 25;
+	self->payload = malloc(self->payload_len);
+	ASSERT_NE(self->payload, NULL);
+
+	memset(self->payload, 0, self->payload_len);
+	self->payload[self->payload_len - 1] = PAYLOAD_END;
+
+	setup_bpf(_metadata, "sockmap_recvfrom.bpf.o", variant->with_recv, &self->bpf);
+	atomic_store(&self->server.running, 1);
+	self->server.fd = start_listening(_metadata, &self->addr.sin_port);
+	self->server.metadata = _metadata;
+
+	self->addr.sin_family = AF_INET;
+	self->addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+
+	pthread_create(&self->server.thread, NULL, &run_server, &self->server);
+}
+
+FIXTURE_TEARDOWN(sockmap_recvfrom)
+{
+	atomic_store(&self->server.running, 0);
+
+	if (self->server.fd) {
+		shutdown(self->server.fd, SHUT_RD);
+		close(self->server.fd);
+	}
+
+	if (self->server.thread)
+		pthread_join(self->server.thread, NULL);
+
+	free(self->payload);
+	bpf_link__destroy(self->bpf.on_sockops);
+
+	if (self->bpf.on_recv)
+		bpf_link__destroy(self->bpf.on_recv);
+
+	bpf_object__close(self->bpf.obj);
+}
+
+TEST_F(sockmap_recvfrom, no_timeout)
+{
+	char ignored[128];
+
+	for (int i = 0; i < MAX_ITERATIONS; ++i) {
+		int fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+
+		ASSERT_NE(fd, -1);
+		ASSERT_EQ(connect(fd, (struct sockaddr *)&self->addr, sizeof(self->addr)), 0);
+
+		ASSERT_EQ(send_payload(_metadata, fd, self->payload, self->payload_len), 0);
+
+		if (recvfrom(fd, ignored, sizeof(ignored), 0, NULL, NULL) < 0)
+			ASSERT_NE(errno, EAGAIN);
+
+		close(fd);
+	}
+}
+
+static int64_t to_nanos(struct timespec *time)
+{
+	return (time->tv_sec * 1000000000LL) + time->tv_nsec;
+}
+
+TEST_F(sockmap_recvfrom, with_timeout)
+{
+	char ignored[128];
+	struct timeval timeo;
+
+	timeo.tv_sec = 0;
+	timeo.tv_usec = 5000;
+
+	/* remove the payload end delimiter so the server never responds and recvfrom times out. */
+	self->payload[self->payload_len - 1] = 0;
+
+	for (int i = 0; i < MAX_ITERATIONS; ++i) {
+		struct timespec beg;
+		struct timespec end;
+		int err;
+
+		int fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+
+		ASSERT_NE(fd, -1);
+		ASSERT_EQ(connect(fd, (struct sockaddr *)&self->addr, sizeof(self->addr)), 0);
+
+		ASSERT_EQ(send_payload(_metadata, fd, self->payload, self->payload_len), 0);
+
+		ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo)), 0);
+
+		clock_gettime(CLOCK_MONOTONIC, &beg);
+		ASSERT_EQ(recvfrom(fd, ignored, sizeof(ignored), 0, NULL, NULL), -1);
+		err = errno;
+		clock_gettime(CLOCK_MONOTONIC, &end);
+
+		ASSERT_EQ(err, EAGAIN);
+		ASSERT_GE(to_nanos(&end) - to_nanos(&beg), timeo.tv_usec * 1000);
+
+		close(fd);
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.52.0


