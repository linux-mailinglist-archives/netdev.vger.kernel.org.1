Return-Path: <netdev+bounces-288343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHnuCxc5B2ottwIAu9opvQ
	(envelope-from <netdev+bounces-288343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:17:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2D2552019
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C800E3013ABC
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEFF48C3EC;
	Fri, 15 May 2026 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="lFH9Kiad"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F937187F
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858177; cv=none; b=GoThKy437u/M+VychlCqCjFdOTYYeT7yMqr5/1O1iX3vYTHhTpk3o3VXoZaztnK0BJgDc483U6v8hau8yxHLFVjaBX1LRxbDdfi9e9Fp9izzWCr9PgUeDlRESz06vNR53C7OBa55Sd9EINlwwb3/kd9LneMZ1hrY8+1b/pvuaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858177; c=relaxed/simple;
	bh=GIJIJDp6NwwYX0Q1AbNNOxWqITIK3rl3pHKEHpkJ2us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5yANUeVqbF8iD0wvatRQlUqMqWOlHax1n2FpQxOjf/zaGPh3BEb2ptc753sGwgg6aYgB96HRqcRRgqErLkQeLEOfB0oi2UiYSCCbOpgOfy972lj9aFYAg49crRFe30InGS+fRC2djvIkEZH72COHncBb8GMbFSGPsnpjUUVcXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=lFH9Kiad; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65dd2b22372so804185d50.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1778858174; x=1779462974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1gP18CObPDJD3QB+9rYWPUzAtOZhH2+QD3gPrVbM98=;
        b=lFH9Kiad8WOQl2SddwASMzOlFrl8dYOSDTWgrWpfmZ6gmHkwff/wlFwYPpcMx9WA6z
         sCbJgrjgTMObh59mzYk6io1jUoDFX+VDP9RNhqB+C19ecbSSrv2KTUlNt/UAwJyNzKpb
         Nu0E9PL3l4fvMYucVXfJmWceP5qKlcMGZrvuFzQ4f9Qk0QOf09wuqSKEbQLqKviiTpIO
         +7P/FtGssH5PrzGmx9jHVWDjbukAOAw/AWDOxq+vyJLaVFZGD/C/FNL91FSVFTrGEtYU
         qp8S6j9r9IqPaFoj148bwtufVY6857gdCK4e5T8AklaFF9mSrgaAqvCFRtH2twww0nvL
         UKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858174; x=1779462974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T1gP18CObPDJD3QB+9rYWPUzAtOZhH2+QD3gPrVbM98=;
        b=e4eb9Ie+681seH9J2Qo8E5Db2aPvRRatEzUw1H32ho4u5sxWEe+tHyoRkMCsHeYJFN
         IzOt2qrfFtEiofWvKRNB9nEN5g+PHfBuv/Fm195fVuKG6bHFwhuYTZyR7D0G1JT82xB1
         Nq5CpgSK72UqpkcAJR3yT5oJZXxFEXc16QiugX0dlqTHq3N94FxusiQac25MYFgxau7h
         l3f7z53qAsNNgNeHXt6AIcDWqVgjcOTDiB9nfRuUAQe+UNgJX+vxOZKjjNnPeyx1UB3z
         /dakK2r52yqE+CgHJTV9+Z0NiI/8h43k2PLfMDQ4cXeStriawUXZfiKprcuAlmaj1J9M
         wtOA==
X-Forwarded-Encrypted: i=1; AFNElJ/dw5xusX18/w9ZjATrG/PH0rrJl3m8NfxzccDvPLC17t2btojkOHC7ea3nAd21tky3PklJaCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPipaFkkifyDEFtig+hfTgj79m+XmOOwb1lmF4oqfUYaZo8RJ
	4TVCIRgJbyo3r2IqJlQ1w8xH/sB8HgkbofG2L6PxFpkiYT9HOPKkYuI3xnSwaiRAkAzy
X-Gm-Gg: Acq92OFjidj6EnAgIhwC/gOwHPHCUgK4laaTnKBrGWuxRKmMIe6j9DJAkZau52ZfdmU
	sfjLGY+xVmE5KPRq5/ZrvAuH+6KRdCbI5+Bgr0E+pb47fwY+gepm7G62NdNB458IbeLXsOul4Mj
	+DPN/uQS+eD/fKN9yfU8wntpW6nPX/CaAt1XOVLifSCiX+11Z31j8fQU8UpWOyf9DI1umDQHGJ5
	HDdthIT7TIoggtT1aouqap7/9bfGDq31qFq1F3U1GdhXu0qEk75Aw4HkiOA4apQBcdCUTF3t7W1
	pvUGBT8Wb1iWQULG7q1ERLsVl6CwD1x1GbTX7RYeZ/aZ3yDrlYvpseGtulNbjHOohko5LGf2KtN
	QT8jAG11swyjTyiULP73iYmpF30/AYF+UrcmpgsyI0JBYB4D6bbEVVDp/MjBDgfvhhYje9V6pRQ
	Hw/HWRn4releCQKahJlc6MEXwce7X0grX1yZLBwlvCPiDR3s5mCHcZhhOJsgI/woRJeIUcgYPXT
	oYKZgFg7HwpMFc=
X-Received: by 2002:a05:690e:1206:b0:653:9e2:1059 with SMTP id 956f58d0204a3-65e223a1712mr2896993d50.0.1778858173484;
        Fri, 15 May 2026 08:16:13 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d878cf2sm2724116d50.2.2026.05.15.08.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:16:12 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] selftests: net: add kTLS async split record regression
Date: Fri, 15 May 2026 11:15:56 -0400
Message-ID: <20260515151556.189841-3-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515151556.189841-1-clusk@northecho.dev>
References: <20260515151556.189841-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2B2D2552019
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[northecho-dev.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-288343-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[northecho.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[northecho.dev:email,northecho.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a kTLS TX regression test for the BPF sk_msg apply_bytes
split-record path. The test sends four 4096-byte writes through
a sockmap verdict program that applies 512-byte verdict windows,
then verifies that the peer receives the full TLS-protected stream.

Run the case once with the synchronous provider and once after
instantiating an async pcrypt gcm(aes) provider. Vulnerable kernels
silently truncate the async run because the split open-record remainder
is lost when encryption returns -EINPROGRESS.

Signed-off-by: Christopher Lusk <clusk@northecho.dev>
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4-7
---
 tools/testing/selftests/net/Makefile          |   5 +
 .../selftests/net/ktls_async_split.bpf.c      |  24 ++
 .../testing/selftests/net/ktls_async_split.c  | 391 ++++++++++++++++++
 3 files changed, 420 insertions(+)
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
index 000000000..a9a84e0f5
--- /dev/null
+++ b/tools/testing/selftests/net/ktls_async_split.c
@@ -0,0 +1,391 @@
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


