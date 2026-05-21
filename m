Return-Path: <netdev+bounces-290229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDwNNmt1DmqG+wUAu9opvQ
	(envelope-from <netdev+bounces-290229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 05:00:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3EA59E431
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 05:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA420305CBB8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F2F38399D;
	Thu, 21 May 2026 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="afIBeJOe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B4381AE7
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332373; cv=none; b=TsErSx0qpmjDa+1bwFNnkIkJ0kDzP5J0ljyujUjV/xtgmAZfulqhZ6bzqGST3W3Z4J47+E2zSOFC0t9IUC8z85pvOH4zkAF79KTJeGW5e0TK4ybVicNqd80T1TrRh2sFSnmz0Hf/Odwe9EUC7LgTyPWJDS5rdvQVOC3FyJn6P7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332373; c=relaxed/simple;
	bh=QXGk+N7UKdb5UEa/p2m6D1TJ82lDDhUIOB4+GhpmpN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6rx6TxTyImnSd3FNCls09EBg+3ZA11KccZAImuzI9Qj1O5Qf7Ru6j1tsY17sHvF8C88dWgIYAlbChyg9qE2r08k7dYqnhS/Nm9LKdsKMhBzqxAbfmWY+UEilIDPL1y24nX7mrVNod+4P1VGESP1UzG2f9aH/oC7IBo+gt+7CDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=afIBeJOe; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7bdf6db2c70so11348217b3.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1779332371; x=1779937171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKA+nc2M+9i0cbABiaxwn8cSkvOwNM/DV9gdI4m3CAA=;
        b=afIBeJOeskmJecIQ3YRoY3doQjgi9DV7RLSyaUKCL2fPbZ5ZtCDp8PVq666VPvyHH6
         Yv+c7lRf7I0iXS8YFqKuEFWVVlvYKDycRSUwu+y5gBMz3PnScobQg2kVx1SRebRB2fnl
         lah57OWk/tw59HE96/3pz+Orr8bX9kXDmBjl8UhWq2LVk1/GunPB4qXhzsYF/QIC9Lp3
         sEsOFD/JoPOYgZWsF+hYNLuQdOKw+IXzs8nFW1T/cent859Iec2MyGMfd8NfWzwk04a9
         GSqiwOOQYXX7IXirTRhzuJMp8rq16XqTYnWkocXuLacDSwNLJCc9Di06b/hGBehvAa8l
         Dh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779332371; x=1779937171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mKA+nc2M+9i0cbABiaxwn8cSkvOwNM/DV9gdI4m3CAA=;
        b=RDNTrAViqqjDCAycmPl413FxpX9oqtfD9S2TS1VGRbjDjrkT2LL5PE1/ppxSUnwp/U
         IEp1uwDrCy5uuFJ4lSoypHPhccLAuvx1nt3LT84fYSJ6TSMbJha6mAzoZ963gjrteSJu
         8zFV09xE6OJBIx9hkd0Dk5zRN1eUSk2pR7KnD58eqL1jLCVUyQZB+Syo/DjCb4iuhYtw
         7+O9kt0yuqXKLn/ckChV2jjzaWcQgJZomN/CBzhfjtGk07jK1oUdqIl/nYYdywc8IZBO
         E8mgqud0kDmNyRjLy+3W4UmMr7vvY1B0HN6M374URD5oVsRs1NWyjdeFQqRZZMNSQ18/
         AArQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bpix0oUnbcklZokbjH8dqAJGuMZDBLCEZlSdcq0xIAyPeZKm/IZzyK89tiNS/DyVvgW6gV8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1uFyamtw0CDn0csKvVxrJp+pH6zVkEDXEvTUpOy+fwsE0cwun
	V27TeeTHKDQ9icShzes1NIngNnU49OYLcTBz8lsc2+NqET02UJkTv0REafGzV2cPR2lZstq0eu9
	FjZqRpAgqHFE=
X-Gm-Gg: Acq92OFQSt+7YzWscB/nMre2NKzazv7KVjGzRG8+elchSMr/xTJXkbldDkF7w3A2cSL
	8UOeVjzTradE+fHYRkUj78f0l3PgdEECojqtMNrprEOZTuCI15GC9YpK3j3FHDwWHDDnQv+JpVN
	OPRrjr9fcWkXovlY/ZmwMgEZTLS89F3nj42eFP+lBb1hC+xorXABhfDHXagOT53pf5OfkyuBHLF
	wY4uYwhUNQLSdgAB/afJ+7wI8a68WgVxEGuIsmPX3NLSNuTmkmftR6bIDTD+/xCat4ZjgYonyh2
	eh5af1CnEy4zfHpBh8M14fDKPQsWlYFcq1P6WIp3g8u58PiGqhxXaW4drPxQCGkZkAuGpYhtD8Y
	v2RSXgyxMfSJjM/6bZSgOo0J1/3JVLdbHMGYiJTSdYAZAwJUF9rgMOv/4zsZAxzi/sJQGlYhxVt
	nm+CWUuRGw5jMhNJZyIgsVh/n7RbyHpi8u7gFm+z/mOrJdEVFFO0LSiP3dj+5lyi7MQRzqeIq8S
	c9cMy11bYtf4+o=
X-Received: by 2002:a05:690e:bca:b0:650:20d6:7098 with SMTP id 956f58d0204a3-65eae3c0194mr463771d50.4.1779332370609;
        Wed, 20 May 2026 19:59:30 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d86c850sm10092743d50.1.2026.05.20.19.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 19:59:30 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] selftests: net: add kTLS async split record regression
Date: Wed, 20 May 2026 22:58:40 -0400
Message-ID: <20260521025840.976378-3-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521025840.976378-1-clusk@northecho.dev>
References: <20260521025840.976378-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[northecho-dev.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-290229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[northecho.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clusk@northecho.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[northecho-dev.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[northecho.dev:mid,northecho.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,northecho-dev.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 9C3EA59E431
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a kTLS TX regression test for the BPF sk_msg apply_bytes
split-record path. The test sends four 4096-byte writes through
a sockmap verdict program that applies 512-byte verdict windows,
then verifies that the peer receives the full TLS-protected stream.

Run the case once with the synchronous provider and once after
instantiating an async pcrypt gcm(aes) provider. Vulnerable kernels
silently truncate the async run because the split open-record remainder
is lost when encryption returns -EINPROGRESS.

Validate the loaded BPF program fd before attaching it so setup failures
are reported directly instead of being passed to bpf_prog_attach().

Signed-off-by: Christopher Lusk <clusk@northecho.dev>
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4-7
---
 tools/testing/selftests/net/Makefile          |   5 +
 .../selftests/net/ktls_async_split.bpf.c      |  24 ++
 .../testing/selftests/net/ktls_async_split.c  | 393 ++++++++++++++++++
 3 files changed, 422 insertions(+)
 create mode 100644 tools/testing/selftests/net/ktls_async_split.bpf.c
 create mode 100644 tools/testing/selftests/net/ktls_async_split.c

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index f3da38c54..0435327e9 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -179,6 +179,7 @@ TEST_GEN_PROGS := \
 	epoll_busy_poll \
 	icmp_rfc4884 \
 	ipv6_fragmentation \
+	ktls_async_split \
 	proc_net_pktgen \
 	reuseaddr_conflict \
 	reuseport_bpf \
@@ -236,3 +237,7 @@ $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
 $(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
 
 include bpf.mk
+
+$(OUTPUT)/ktls_async_split: CFLAGS += -I../../../lib
+$(OUTPUT)/ktls_async_split: LDLIBS += $(BPFOBJ) -lelf -lz
+$(OUTPUT)/ktls_async_split: $(BPFOBJ)
diff --git a/tools/testing/selftests/net/ktls_async_split.bpf.c b/tools/testing/selftests/net/ktls_async_split.bpf.c
new file mode 100644
index 000000000..c7caafb73
--- /dev/null
+++ b/tools/testing/selftests/net/ktls_async_split.bpf.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+#ifndef SK_PASS
+#define SK_PASS 1
+#endif
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 4);
+	__type(key, __u32);
+	__type(value, int);
+} sock_map SEC(".maps");
+
+SEC("sk_msg")
+int apply_bytes_verdict(struct sk_msg_md *msg)
+{
+	bpf_msg_apply_bytes(msg, 512);
+	return SK_PASS;
+}
diff --git a/tools/testing/selftests/net/ktls_async_split.c b/tools/testing/selftests/net/ktls_async_split.c
new file mode 100644
index 000000000..5601ce4b5
--- /dev/null
+++ b/tools/testing/selftests/net/ktls_async_split.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <arpa/inet.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/if_alg.h>
+#include <linux/bpf.h>
+#include <linux/tls.h>
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "kselftest.h"
+
+#ifndef SOL_TLS
+#define SOL_TLS 282
+#endif
+
+#define EXPECTED_BYTES 17312
+
+static void fill_seq(unsigned char *p, size_t n, unsigned char seed)
+{
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		p[i] = (unsigned char)(seed + i);
+}
+
+static void bump_memlock(void)
+{
+	struct rlimit r = { RLIM_INFINITY, RLIM_INFINITY };
+
+	setrlimit(RLIMIT_MEMLOCK, &r);
+}
+
+static int run_cmd(const char *cmd)
+{
+	int ret = system(cmd);
+
+	if (ret == -1)
+		return -1;
+	if (WIFEXITED(ret))
+		return WEXITSTATUS(ret);
+	return 1;
+}
+
+static int instantiate_aead(const char *name)
+{
+	struct sockaddr_alg sa = {
+		.salg_family = AF_ALG,
+	};
+	int fd, ret;
+
+	strncpy((char *)sa.salg_type, "aead", sizeof(sa.salg_type) - 1);
+	strncpy((char *)sa.salg_name, name, sizeof(sa.salg_name) - 1);
+
+	fd = socket(AF_ALG, SOCK_SEQPACKET, 0);
+	if (fd < 0)
+		return -errno;
+
+	ret = bind(fd, (struct sockaddr *)&sa, sizeof(sa));
+	if (ret < 0)
+		ret = -errno;
+
+	close(fd);
+	return ret;
+}
+
+static bool have_async_pcrypt(void)
+{
+	FILE *f = fopen("/proc/crypto", "r");
+	char line[256];
+	bool in_driver = false;
+	bool async = false;
+
+	if (!f)
+		return false;
+
+	while (fgets(line, sizeof(line), f)) {
+		if (!strncmp(line, "driver", 6)) {
+			in_driver = strstr(line, "pcrypt(") &&
+				    strstr(line, "gcm");
+			async = false;
+			continue;
+		}
+		if (in_driver && !strncmp(line, "async", 5)) {
+			async = strstr(line, "yes");
+			if (async) {
+				fclose(f);
+				return true;
+			}
+		}
+	}
+
+	fclose(f);
+	return false;
+}
+
+static bool module_loaded(const char *name)
+{
+	FILE *f = fopen("/proc/modules", "r");
+	char line[256], mod[128];
+
+	if (!f)
+		return false;
+
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "%127s", mod) == 1 && !strcmp(mod, name)) {
+			fclose(f);
+			return true;
+		}
+	}
+
+	fclose(f);
+	return false;
+}
+
+static int make_listener(unsigned short *port)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		.sin_port = 0,
+	};
+	socklen_t len = sizeof(addr);
+	int fd, one = 1;
+
+	fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (fd < 0)
+		return -errno;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)) < 0)
+		goto err;
+	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
+		goto err;
+	if (listen(fd, 1) < 0)
+		goto err;
+	if (getsockname(fd, (struct sockaddr *)&addr, &len) < 0)
+		goto err;
+
+	*port = ntohs(addr.sin_port);
+	return fd;
+
+err:
+	close(fd);
+	return -errno;
+}
+
+static int connect_client(unsigned short port)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		.sin_port = htons(port),
+	};
+	int fd;
+
+	fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (fd < 0)
+		return -errno;
+	if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		close(fd);
+		return -errno;
+	}
+
+	return fd;
+}
+
+static int make_tcp_pair(int *client_fd, int *peer_fd)
+{
+	unsigned short port = 0;
+	int listen_fd, c, p;
+
+	listen_fd = make_listener(&port);
+	if (listen_fd < 0)
+		return listen_fd;
+
+	c = connect_client(port);
+	if (c < 0) {
+		close(listen_fd);
+		return c;
+	}
+
+	p = accept(listen_fd, NULL, NULL);
+	close(listen_fd);
+	if (p < 0) {
+		close(c);
+		return -errno;
+	}
+
+	*client_fd = c;
+	*peer_fd = p;
+	return 0;
+}
+
+static int enable_ktls_tx(int fd)
+{
+	struct tls12_crypto_info_aes_gcm_128 info;
+	static const char ulp[] = "tls";
+
+	if (setsockopt(fd, IPPROTO_TCP, TCP_ULP, ulp, sizeof(ulp)) < 0)
+		return -errno;
+
+	memset(&info, 0, sizeof(info));
+	info.info.version = TLS_1_2_VERSION;
+	info.info.cipher_type = TLS_CIPHER_AES_GCM_128;
+	fill_seq(info.iv, sizeof(info.iv), 0x11);
+	fill_seq(info.key, sizeof(info.key), 0x22);
+	fill_seq(info.salt, sizeof(info.salt), 0x33);
+	fill_seq(info.rec_seq, sizeof(info.rec_seq), 0x44);
+
+	if (setsockopt(fd, SOL_TLS, TLS_TX, &info, sizeof(info)) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static int attach_bpf(const char *obj_path, int sock_fd, struct bpf_object **obj_out)
+{
+	struct bpf_object *obj;
+	struct bpf_program *prog;
+	int map_fd, prog_fd;
+	__u32 key = 0;
+
+	obj = bpf_object__open_file(obj_path, NULL);
+	if (libbpf_get_error(obj))
+		return -EINVAL;
+	if (bpf_object__load(obj))
+		return -EINVAL;
+
+	prog = bpf_object__find_program_by_name(obj, "apply_bytes_verdict");
+	if (!prog)
+		return -ENOENT;
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0)
+		return prog_fd;
+
+	map_fd = bpf_object__find_map_fd_by_name(obj, "sock_map");
+	if (map_fd < 0)
+		return -ENOENT;
+
+	if (bpf_prog_attach(prog_fd, map_fd, BPF_SK_MSG_VERDICT, 0))
+		return -errno;
+	if (bpf_map_update_elem(map_fd, &key, &sock_fd, BPF_ANY))
+		return -errno;
+
+	*obj_out = obj;
+	return 0;
+}
+
+static void server_loop(int fd, int out_fd)
+{
+	unsigned char buf[16384];
+	int total = 0;
+
+	for (;;) {
+		ssize_t n = read(fd, buf, sizeof(buf));
+
+		if (n < 0) {
+			if (errno == EINTR)
+				continue;
+			_exit(1);
+		}
+		if (!n)
+			break;
+		total += (int)n;
+	}
+
+	(void)write(out_fd, &total, sizeof(total));
+	close(fd);
+	close(out_fd);
+	_exit(0);
+}
+
+static int run_case(const char *obj_path, int *server_read)
+{
+	struct bpf_object *obj = NULL;
+	unsigned char buf[4096];
+	int client_fd = -1, peer_fd = -1, pipefd[2] = { -1, -1 };
+	pid_t pid;
+	int status, ret, i;
+	ssize_t n, got;
+
+	ret = make_tcp_pair(&client_fd, &peer_fd);
+	if (ret)
+		return ret;
+	if (pipe(pipefd)) {
+		close(client_fd);
+		close(peer_fd);
+		return -errno;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		close(client_fd);
+		close(peer_fd);
+		close(pipefd[0]);
+		close(pipefd[1]);
+		return -errno;
+	}
+	if (!pid) {
+		close(pipefd[0]);
+		server_loop(peer_fd, pipefd[1]);
+	}
+
+	close(peer_fd);
+	close(pipefd[1]);
+
+	ret = attach_bpf(obj_path, client_fd, &obj);
+	if (ret)
+		goto out;
+	ret = enable_ktls_tx(client_fd);
+	if (ret)
+		goto out;
+
+	fill_seq(buf, sizeof(buf), 0x80);
+	for (i = 0; i < 4; i++) {
+		n = send(client_fd, buf, sizeof(buf), 0);
+		if (n != sizeof(buf)) {
+			ret = n < 0 ? -errno : -EIO;
+			goto out;
+		}
+	}
+
+	shutdown(client_fd, SHUT_WR);
+	got = read(pipefd[0], server_read, sizeof(*server_read));
+	if (got != sizeof(*server_read))
+		ret = -EIO;
+
+out:
+	close(client_fd);
+	close(pipefd[0]);
+	if (obj)
+		bpf_object__close(obj);
+	if (waitpid(pid, &status, 0) < 0)
+		return -errno;
+	if (!ret && (!WIFEXITED(status) || WEXITSTATUS(status)))
+		ret = -EIO;
+	return ret;
+}
+
+int main(int argc, char **argv)
+{
+	const char *obj_path = argc > 1 ? argv[1] : "./ktls_async_split.bpf.o";
+	int sync_read = 0, async_read = 0, ret;
+
+	ksft_print_header();
+	ksft_set_plan(2);
+	bump_memlock();
+
+	if (run_cmd("modprobe tls >/dev/null 2>&1") && !module_loaded("tls"))
+		ksft_exit_skip("missing tls module\n");
+
+	/* Keep the first run on the synchronous provider. */
+	run_cmd("modprobe -r pcrypt >/dev/null 2>&1");
+	ret = run_case(obj_path, &sync_read);
+	if (ret)
+		ksft_exit_fail_msg("sync case failed: %s\n", strerror(-ret));
+	if (sync_read != EXPECTED_BYTES)
+		ksft_exit_fail_msg("sync case read %d, expected %d\n",
+				   sync_read, EXPECTED_BYTES);
+	ksft_test_result_pass("sync provider transmits split record\n");
+
+	run_cmd("modprobe af_alg algif_aead pcrypt >/dev/null 2>&1");
+	ret = instantiate_aead("pcrypt(generic-gcm-vaes-avx2)");
+	if (ret)
+		ret = instantiate_aead("pcrypt(gcm(aes))");
+	if (ret || !have_async_pcrypt())
+		ksft_exit_skip("missing async pcrypt gcm(aes) provider\n");
+
+	ret = run_case(obj_path, &async_read);
+	if (ret)
+		ksft_exit_fail_msg("async case failed: %s\n", strerror(-ret));
+	if (async_read != EXPECTED_BYTES)
+		ksft_exit_fail_msg("async case read %d, expected %d\n",
+				   async_read, EXPECTED_BYTES);
+	ksft_test_result_pass("async provider transmits split record\n");
+
+	ksft_finished();
+}
-- 
2.54.0


