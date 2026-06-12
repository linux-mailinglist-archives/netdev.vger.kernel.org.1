Return-Path: <netdev+bounces-298417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QEG4G05QK2oi6gMAu9opvQ
	(envelope-from <netdev+bounces-298417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:18:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05929675E6C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:18:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ebZX6VJS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298417-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298417-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AC5B302F25F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B682D73B8;
	Fri, 12 Jun 2026 00:18:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544CF2C3255
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 00:18:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223494; cv=none; b=fs/zKpJI/it/jaV9gu86Ulir/+gfx/B3HuHmqm4lZvZ7qMWKNGAMJJKCbJCsEd3vTz/+fMWSebHtqSdPEcPjn3bOB2mD2qJloPJu3ioWLTTlPlR5GXxca+/veEFIZWfpBW3Q9hls8DPxPuCU/MkYTQO7l7QeJmAvLopjv5QKn8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223494; c=relaxed/simple;
	bh=Ktl5M62rkKio6WITS7Orp2DHXTaNCEZASfz28yjCCls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E9Q6Unfc8jS21UNgRSAnA0AhGSRrCWlXRu1K8atDLVRs4KGHYK6kEF/VZn42x7OglrZaOGuJtDad21+Lbzq1RnQZ4zm2XM/puonR+660+m3zLf4I76oHdsWt8SfeiRyDJLTxA7U3gdd9+Q5E6wPPut4xDW93FvLsxEYo0x7gIto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ebZX6VJS; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b934a336eso313427a91.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781223492; x=1781828292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HO7n9ye/5Lm3eErUVBpQ0JVW75B04oPDwvOPzng1mjc=;
        b=ebZX6VJSGKfGseZh166UfM3KGMwEVmpg8Xv4tQmVWJ3tRSQtTFB6D2JaPuEwkMlTXZ
         wIvukwgEJEsjMrHCuttFFu0FHnMa6G7bqiOkc6/TQZcT2nPQWfaE/WHyJJLD5P0Mby+F
         WHi/iXrsot8iFjRwqug+0rK4oXgpVA9INgOpG3PBOQs5MEqSd7DulEeH6e4btLLX2U/s
         Q5PyFvQZgjkmoLa+HEoUeBvQVzl6iylzBJEVnf+NzJKLeIhGSJ1UZCGBEJ8Brbf4iqEM
         01pbGKWUbOAz5m1yEFGH9efbmIfoLTzcmZZ9/mmYE30gzI8OWsoCpgCIL+JyNRVxM7t5
         UAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781223492; x=1781828292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HO7n9ye/5Lm3eErUVBpQ0JVW75B04oPDwvOPzng1mjc=;
        b=At/DMqv4N8XVow0BJ+OouDrpLAM2OxdVFmDOxNzrzgSB+mnc+qALMszfBLLohXAb8w
         EPV/AID4yxlOpVpoMhvqR6VxK4mLXtxSA/KRuWvfjm1nAk79ZFj0e9hwIKP3qXbtkRlu
         AQVlkfA7hZ1z+PS0ne5bf1SQwSS4kJv6PCMALHEabvZRvTXYdQgi2gsCvwjthmd/c1TF
         sO1fWkNn27RbRoMbzG30oC1Mm0Z1lWKtNoBdAPUCQAVsrznGK6XryP5AmTNEIavvCnGT
         PY/Al1l5ZA0jLMsMVvYFobJFH+6NmslquKtie0I28fZh2S9ROsBVIHpau/PL4LoD5rgI
         fGmw==
X-Forwarded-Encrypted: i=1; AFNElJ8C53XMXgdrq4SxNlvW+m/WQ9QFwVKua1N+5NggRN44xGLeklrOQPxT3mE6t5STHPKRnQU89l8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIsqdQDCfa5k+R98U+1nhjxCchkSVpf1LN0RcePU6dN8IaSIDF
	uhm0KnAR8HL7LtS6SUSZJ5SOi2Ps5uzF57eS9/gpXIbafTTo4TZSftBsWvdWwyKkn22E7Ee5fBG
	LHpZb9A==
X-Received: from pgaq66.prod.google.com ([2002:a63:4345:0:b0:c80:24e3:5130])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b81:b0:36b:7725:defd
 with SMTP id 98e67ed59e1d1-379fef5ed63mr652019a91.0.1781223491336; Thu, 11
 Jun 2026 17:18:11 -0700 (PDT)
Date: Fri, 12 Jun 2026 00:17:36 +0000
In-Reply-To: <20260612001803.23341-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612001803.23341-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612001803.23341-6-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 5/5] selftest: bpf: Add test for hwtstamp proxy.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:kuniyu@google.com,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298417-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05929675E6C

This selftest simulates the hardware timestamp proxy scenario mentioned
in the previous commits using two UDP sockets.

Here, app_fd represents a standard socket application, and proxy_fd
simulates a userspace proxy that receives and injects encapsulated
packets from/to app_fd via a GENEVE device (geneve0).

TX:
   1. app_fd sends data w/ SCM_TS_OPT_ID
   2. BPF prog hooks at tc/egress of geneve0
   3. BPF inserts the GENEVE option with Type 0x1 to save SCM_TS_OPT_ID
   4. proxy_fd receives the encapsulated packet
   5. proxy changes the option Type to 0x2 and sets TX hwtstamp
   6. proxy sends it back to geneve0
   7. BPF prog hooks at tc/ingress of geneve0
   8. BPF extracts TX hwtstamp into skb
   9. BPF looks up the app_fd socket
  10. BPF enqueues skb to app_fd's sk->sk_error_queue
  11. app_fd receives TX hwtstamp and verifies the value

RX:
  12. proxy_fd generates RX packet from TX packet
       by swapping src/dst in each header
  13. proxy changes the option Type to 0x3 and sets RX hwtstamp
  14. proxy sends the encapsulated packet to geneve0
  15. BPF prog hooks at tc/ingress of geneve0
  16. BPF extracts RX hwtstamp into skb
  17. app_fd receives RX hwtstamp and verifies the value

The GENEVE TLV option is structured as follows:

    0                   1                   2                   3
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |          Option Class         |      Type     |0|0|0| Length  |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                                                               |
   +                     HW Timestamp  (8 bytes)                   +
   |                                                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                     Timestamp key (4 bytes)                   |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

   Type:
   - 0x1: TX packet
   - 0x2: TX completion packet w/ TX hwtstamp
   - 0x3: RX packet w/ RX hwtstamp

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  10 +
 .../selftests/bpf/prog_tests/proxy_hwtstamp.c | 580 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/proxy_hwtstamp.c      | 234 +++++++
 4 files changed, 825 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
 create mode 100644 tools/testing/selftests/bpf/progs/proxy_hwtstamp.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 7dad01439391..8d119b10ed0d 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -92,4 +92,14 @@ extern int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
 				const struct bpf_dynptr *value_p, int flags) __ksym __weak;
 extern int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str) __ksym __weak;
 
+extern int bpf_skb_scrub_tx_tstamp(struct __sk_buff *s) __ksym __weak;
+
+struct bpf_hwtstamp;
+extern int bpf_skb_set_hwtstamp(struct __sk_buff *s,
+				struct bpf_hwtstamp *attrs, int attrs__sz) __ksym __weak;
+
+struct bpf_tx_tstamp_cmpl;
+extern int bpf_skb_complete_tx_tstamp(struct __sk_buff *s,
+				      struct bpf_tx_tstamp_cmpl *attrs,
+				      int attrs__sz) __ksym __weak;
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c b/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
new file mode 100644
index 000000000000..d0f90f22bea2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
@@ -0,0 +1,580 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2026 Google LLC */
+
+#include <sys/epoll.h>
+#include <net/if.h>
+#include <linux/errqueue.h>
+#include <linux/net_tstamp.h>
+
+#include "test_progs.h"
+#include <network_helpers.h>
+#include "proxy_hwtstamp.skel.h"
+
+#define swap(a, b)				\
+	do {					\
+		typeof(a) __tmp = (a);		\
+		(a) = (b);			\
+		(b) = __tmp;			\
+	} while (0)
+
+#define swap_array(a, b)			\
+	do {					\
+		char __tmp[sizeof(a)];		\
+		memcpy(__tmp, a, sizeof(a));	\
+		memcpy(a, b, sizeof(a));	\
+		memcpy(b, __tmp, sizeof(a));	\
+	} while (0)
+
+struct genevehdr {
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	u8 opt_len:6;
+	u8 ver:2;
+	u8 rsvd1:6;
+	u8 critical:1;
+	u8 oam:1;
+#else
+	u8 ver:2;
+	u8 opt_len:6;
+	u8 oam:1;
+	u8 critical:1;
+	u8 rsvd1:6;
+#endif
+	__be16 proto_type;
+	u8 vni[3];
+	u8 rsvd2;
+};
+
+struct geneve_opt {
+	__be16	opt_class;
+	u8	type;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	u8	length:5;
+	u8	r3:1;
+	u8	r2:1;
+	u8	r1:1;
+#else
+	u8	r1:1;
+	u8	r2:1;
+	u8	r3:1;
+	u8	length:5;
+#endif
+};
+
+struct proxy_header {
+	struct genevehdr geneve;
+	struct geneve_opt geneve_opt;
+	s64 hwtstamp;
+	u32 tskey;
+	struct ethhdr eth;
+	union {
+		struct {
+			struct iphdr ip;
+			struct udphdr udp;
+		} v4;
+		struct {
+			struct ipv6hdr ip;
+			struct udphdr udp;
+		} v6;
+	};
+} __attribute__((packed));
+
+#define GENEVE_VNI		0x900913
+#define GENEVE_OPT_CLASS	0x9009
+#define GENEVE_OPT_LEN		((sizeof(struct proxy_hwtstamp_opt)	\
+				  - sizeof(struct geneve_opt)) / 4)
+enum {
+	GENEVE_OPT_TYPE_TX	= 1,
+	GENEVE_OPT_TYPE_TX_CMPL	= 2,
+	GENEVE_OPT_TYPE_RX	= 3,
+};
+
+#define APP_DST_IPV4		"192.168.0.1"
+#define APP_DST_IPV6		"2001:db7::92"
+
+#define GENEVE_PORT		6081
+#define APP_SRC_IPV4		"10.0.3.1"
+#define APP_SRC_IPV6		"2001:db8::1"
+
+#define HWTSTAMP		0x12345678
+#define TSKEY			0xaabbccdd
+
+static struct proxy_hwtstamp_test_case {
+	char name[8];
+	int family;
+	char geneve_remote_ip[16];
+	char geneve_local_ip[16];
+	char app_dst_ip[16];
+	int app_dst_port;
+	int encap_payload_len;
+
+	/* fields below are populated during test. */
+	struct proxy_hwtstamp *skel;
+	struct netns_obj *netns;
+	struct sockaddr_storage geneve_remote_addr;
+	struct sockaddr_storage geneve_local_addr;
+	socklen_t addrlen;
+	int proxy_fd;
+	int app_fd;
+#define APP_PAYLOAD_LEN		512
+	char app_payload[APP_PAYLOAD_LEN];
+	char encap_payload[APP_PAYLOAD_LEN + sizeof(struct proxy_header)];
+} test_cases[] = {
+	{
+		.name = "IPv4",
+		.family = AF_INET,
+		.geneve_remote_ip = "127.0.0.1",
+		.geneve_local_ip = APP_SRC_IPV4,
+		.app_dst_ip = APP_DST_IPV4,
+		.app_dst_port = 443,
+		.encap_payload_len = APP_PAYLOAD_LEN + offsetofend(struct proxy_header, v4),
+	},
+	{
+		.name = "IPv6",
+		.family = AF_INET6,
+		.geneve_remote_ip = "::1",
+		.geneve_local_ip = APP_SRC_IPV6,
+		.app_dst_ip = APP_DST_IPV6,
+		.app_dst_port = 443,
+		.encap_payload_len = APP_PAYLOAD_LEN + offsetofend(struct proxy_header, v6),
+	},
+};
+
+char *ipv4_commands[] = {
+	"ip link set dev lo up",
+	"ip link add geneve0 type geneve local " APP_SRC_IPV4 " external",
+	"ip addr add " APP_SRC_IPV4 "/24 dev geneve0",
+	"ip link set dev geneve0 address aa:bb:cc:dd:ee:ff",
+	"ip link set dev geneve0 up",
+	"ip route add " APP_DST_IPV4 "/32 dev geneve0",
+	/* We do not forward ARP to the wire in this test,
+	 * so a static neighbour entry is needed for APP_DST_IPV4.
+	 */
+	"ip neigh add " APP_DST_IPV4 " lladdr ab:bc:cd:de:ef:fa dev geneve0",
+};
+
+char *ipv6_commands[] = {
+	"ip link set dev lo up",
+	"ip link add geneve0 type geneve local " APP_SRC_IPV6 " external",
+	"ip -6 addr add " APP_SRC_IPV6 "/32 dev geneve0 nodad",
+	"ip link set dev geneve0 address aa:bb:cc:dd:ee:ff",
+	"ip link set dev geneve0 up",
+	"ip -6 route add " APP_DST_IPV6 "/128 dev geneve0",
+	/* Similarly, APP_DST_IPV6 needs a static neighbour entry */
+	"ip -6 neigh add " APP_DST_IPV6 " lladdr ab:bc:cd:de:ef:fa dev geneve0",
+};
+
+static int setup_netns(struct proxy_hwtstamp_test_case *test_case)
+{
+	int i, array_size, ret;
+	char **commands;
+
+	if (test_case->family == AF_INET) {
+		commands = ipv4_commands;
+		array_size = ARRAY_SIZE(ipv4_commands);
+	} else {
+		commands = ipv6_commands;
+		array_size = ARRAY_SIZE(ipv6_commands);
+	}
+
+	for (i = 0; i < array_size; i++) {
+		ret = system(commands[i]);
+		if (!ASSERT_OK(ret, commands[i]))
+			break;
+	}
+
+	return ret;
+}
+
+static int setup_tcx(struct proxy_hwtstamp_test_case *test_case)
+{
+	struct proxy_hwtstamp *skel = test_case->skel;
+	LIBBPF_OPTS(bpf_tcx_opts, tcx_opts_ingress);
+	LIBBPF_OPTS(bpf_tcx_opts, tcx_opts_egress);
+	struct bpf_link *link;
+	int ifindex;
+
+	ifindex = if_nametoindex("geneve0");
+
+	if (make_sockaddr(test_case->family, test_case->geneve_remote_ip, GENEVE_PORT,
+			  &test_case->geneve_remote_addr, &test_case->addrlen))
+		goto err;
+
+	if (make_sockaddr(test_case->family, test_case->geneve_local_ip, GENEVE_PORT,
+			  &test_case->geneve_local_addr, &test_case->addrlen))
+		goto err;
+
+	/* Set up struct bpf_tunnel_key for GENEVE.
+	 * Note that bpf_skb_set_tunnel_key() expects
+	 *   IPv4 address in host byte order
+	 *   IPv6 address in network byte order.
+	 */
+	skel->bss->key_dst.tunnel_id = GENEVE_VNI;
+	if (test_case->family == AF_INET) {
+		struct sockaddr_in *addr4;
+
+		addr4 = (struct sockaddr_in *)&test_case->geneve_remote_addr;
+		skel->bss->key_dst.remote_ipv4 = ntohl(addr4->sin_addr.s_addr);
+
+		addr4 = (struct sockaddr_in *)&test_case->geneve_local_addr;
+		skel->bss->key_dst.local_ipv4 = ntohl(addr4->sin_addr.s_addr);
+
+		skel->bss->tunnel_tx_flags = BPF_F_ZERO_CSUM_TX;
+		skel->bss->tunnel_rx_flags = 0;
+	} else {
+		struct sockaddr_in6 *addr6;
+
+		addr6 = (struct sockaddr_in6 *)&test_case->geneve_remote_addr;
+		memcpy(&skel->bss->key_dst.remote_ipv6,
+		       &addr6->sin6_addr, sizeof(addr6->sin6_addr));
+
+		addr6 = (struct sockaddr_in6 *)&test_case->geneve_local_addr;
+		memcpy(&skel->bss->key_dst.local_ipv6,
+		       &addr6->sin6_addr, sizeof(addr6->sin6_addr));
+
+		/* IPv6 requires BPF_F_TUNINFO_IPV6.
+		 * Since udpv6_rcv() drops 0 csum packets unlike udp_rcv()
+		 * by default, UDP_NO_CHECK6_RX must be set on the proxy socket.
+		 */
+		skel->bss->tunnel_tx_flags = BPF_F_ZERO_CSUM_TX | BPF_F_TUNINFO_IPV6;
+		skel->bss->tunnel_rx_flags = BPF_F_TUNINFO_IPV6;
+	}
+
+	/* Attach BPF progs to egress and ingress. */
+	link = bpf_program__attach_tcx(skel->progs.proxy_hwtstamp_ingress,
+				       ifindex, &tcx_opts_ingress);
+	if (!ASSERT_OK_PTR(link, "attach_tcx(ingress)"))
+		goto err;
+
+	skel->links.proxy_hwtstamp_ingress = link;
+
+	link = bpf_program__attach_tcx(skel->progs.proxy_hwtstamp_egress,
+				       ifindex, &tcx_opts_egress);
+	if (!ASSERT_OK_PTR(link, "attach_tcx(egress)"))
+		goto err;
+
+	skel->links.proxy_hwtstamp_egress = link;
+
+	return 0;
+err:
+	return -1;
+}
+
+static int setup_fd(struct proxy_hwtstamp_test_case *test_case)
+{
+	int proxy_fd, app_fd;
+	int val, ret;
+
+	proxy_fd = start_server_addr(SOCK_DGRAM, &test_case->geneve_remote_addr,
+				     test_case->addrlen, NULL);
+	if (!ASSERT_OK_FD(proxy_fd, "start_server"))
+		goto err;
+
+	if (test_case->family == AF_INET6) {
+		/* udpv6_rcv() drops 0 csum (BPF_F_ZERO_CSUM_TX) packets
+		 * unless UDP_NO_CHECK6_RX is set.
+		 */
+		val = 1;
+		ret = setsockopt(proxy_fd, SOL_UDP, UDP_NO_CHECK6_RX, &val, sizeof(val));
+		if (!ASSERT_OK(ret, "setsockopt(UDP_NO_CHECK6_RX)"))
+			goto close_proxy;
+	}
+
+	app_fd = connect_to_addr_str(test_case->family, SOCK_DGRAM,
+				     test_case->app_dst_ip,
+				     test_case->app_dst_port, NULL);
+	if (!ASSERT_OK_FD(app_fd, "connect_to_addr_str"))
+		goto close_proxy;
+
+	val = SOF_TIMESTAMPING_RX_HARDWARE |
+	      SOF_TIMESTAMPING_TX_HARDWARE |
+	      SOF_TIMESTAMPING_RAW_HARDWARE |
+	      SOF_TIMESTAMPING_OPT_ID;
+	ret = setsockopt(app_fd, SOL_SOCKET, SO_TIMESTAMPING_NEW, &val, sizeof(val));
+	if (!ASSERT_OK(ret, "setsockopt(SO_TIMESTAMPING_NEW)"))
+		goto close_app;
+
+	test_case->proxy_fd = proxy_fd;
+	test_case->app_fd = app_fd;
+
+	return 0;
+
+close_app:
+	close(app_fd);
+close_proxy:
+	close(proxy_fd);
+err:
+	return -1;
+}
+
+static void destroy_env(struct proxy_hwtstamp_test_case *test_case)
+{
+	close(test_case->app_fd);
+	close(test_case->proxy_fd);
+	proxy_hwtstamp__destroy(test_case->skel);
+	netns_free(test_case->netns);
+}
+
+static int setup_env(struct proxy_hwtstamp_test_case *test_case)
+{
+	test_case->netns = netns_new("proxy_hwtstamp", true);
+	if (!ASSERT_OK_PTR(test_case->netns, "netns_new"))
+		goto err;
+
+	if (setup_netns(test_case))
+		goto free_netns;
+
+	test_case->skel = proxy_hwtstamp__open_and_load();
+	if (!ASSERT_OK_PTR(test_case->skel, "open_and_load"))
+		goto free_netns;
+
+	if (setup_tcx(test_case))
+		goto destroy_skel;
+
+	if (setup_fd(test_case))
+		goto destroy_skel;
+
+	return 0;
+
+destroy_skel:
+	proxy_hwtstamp__destroy(test_case->skel);
+free_netns:
+	netns_free(test_case->netns);
+err:
+	return -1;
+}
+
+static int wait_data(struct proxy_hwtstamp_test_case *test_case, bool tx)
+{
+	struct epoll_event event = {
+		.events = tx ? EPOLLERR : EPOLLIN,
+		.data.fd = test_case->app_fd,
+	};
+	int epoll_fd;
+	int ret = -1;
+
+	epoll_fd = epoll_create1(0);
+	if (!ASSERT_GE(epoll_fd, 0, "epoll_create1"))
+		goto out;
+
+	ret = epoll_ctl(epoll_fd, EPOLL_CTL_ADD, test_case->app_fd, &event);
+	if (!ASSERT_OK(ret, "epoll_ctl"))
+		goto close_epoll;
+
+	ret = epoll_wait(epoll_fd, &event, 1, 3000);
+	if (ASSERT_EQ(ret, 1, "epoll_wait"))
+		ret = 0;
+	else
+		ret = -1;
+
+close_epoll:
+	close(epoll_fd);
+out:
+	return ret;
+}
+
+static int check_tstamp(struct proxy_hwtstamp_test_case *test_case, bool tx)
+{
+	char buf_msg[APP_PAYLOAD_LEN * 2], buf_cmsg[1024];
+	bool saw_tstamp = false, saw_tskey = false;
+	struct msghdr msg = {};
+	struct iovec iov = {};
+	struct cmsghdr *cmsg;
+	int ret;
+
+	if (wait_data(test_case, tx))
+		return -1;
+
+	iov.iov_base = buf_msg;
+	iov.iov_len = sizeof(buf_msg);
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = buf_cmsg;
+	msg.msg_controllen = sizeof(buf_cmsg);
+
+	ret = recvmsg(test_case->app_fd, &msg, tx ? MSG_ERRQUEUE : 0);
+
+	if (ret > 0)
+		hexdump(tx ? "tx tstamp  " : "rx tstamp  ", buf_msg, ret);
+
+	if (!ASSERT_EQ(ret, APP_PAYLOAD_LEN, "recvmsg"))
+		return -1;
+
+	ret = memcmp(buf_msg, test_case->app_payload, sizeof(test_case->app_payload));
+	ASSERT_OK(ret, "memcmp");
+
+	ret = -1;
+
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SO_TIMESTAMPING_NEW) {
+			struct scm_timestamping *ts;
+
+			ts = (struct scm_timestamping *)CMSG_DATA(cmsg);
+			ASSERT_EQ(ts->ts[2].tv_sec, 0, "tv_sec");
+			ASSERT_EQ(ts->ts[2].tv_nsec, HWTSTAMP, "tv_nsec");
+
+			saw_tstamp = true;
+		} else if ((cmsg->cmsg_level == SOL_IP && cmsg->cmsg_type == IP_RECVERR) ||
+			   (cmsg->cmsg_level == SOL_IPV6 && cmsg->cmsg_type == IPV6_RECVERR)) {
+			struct sock_extended_err *ee;
+
+			ee = (struct sock_extended_err *)CMSG_DATA(cmsg);
+
+			if (ee->ee_origin == SO_EE_ORIGIN_TIMESTAMPING) {
+				ASSERT_EQ(ee->ee_data, TSKEY, "tskey");
+				saw_tskey = true;
+			}
+		}
+	}
+
+	ASSERT_TRUE(saw_tstamp && (!tx || saw_tstamp), "no timestamp");
+
+	return ret;
+}
+
+static int test_proxy_hwtstamp_tx(struct proxy_hwtstamp_test_case *test_case)
+{
+	char h_source_dummy[ETH_HLEN] = {0xFF, 0xEE, 0xDD, 0xCC, 0xBB, 0xAA};
+	char buf_cmsg[CMSG_SPACE(sizeof(u32))];
+	struct proxy_header *phdr;
+	struct msghdr msg = {};
+	struct iovec iov = {};
+	struct cmsghdr *cmsg;
+	int ret;
+
+	memset(test_case->app_payload, 0xAB, sizeof(test_case->app_payload));
+	iov.iov_base = test_case->app_payload;
+	iov.iov_len = sizeof(test_case->app_payload);
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = buf_cmsg;
+	msg.msg_controllen = sizeof(buf_cmsg);
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_TS_OPT_ID;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(u32));
+	*(u32 *)CMSG_DATA(cmsg) = TSKEY;
+
+	ret = sendmsg(test_case->app_fd, &msg, 0);
+	if (!ASSERT_EQ(ret, sizeof(test_case->app_payload), "send"))
+		return -1;
+
+	while (1) {
+		memset(test_case->encap_payload, 0, sizeof(test_case->encap_payload));
+
+		ret = recv(test_case->proxy_fd, test_case->encap_payload,
+			   sizeof(test_case->encap_payload), 0);
+		if (ret <= (int)sizeof(phdr->geneve)) {
+			ASSERT_GT(ret, (int)sizeof(phdr->geneve), "recv(tx ingress)");
+			return -1;
+		}
+
+		phdr = (struct proxy_header *)test_case->encap_payload;
+
+		/* In the real world, we forward all packets,
+		 * including ARP, NDP, etc, but now we ignore them.
+		 * In this test case, we only care about skb with
+		 * the GENEVE option, meaning it was sent by app_fd.
+		 */
+		if (phdr->geneve.opt_len)
+			break;
+	}
+
+	hexdump("tx payload ", test_case->encap_payload,
+		test_case->encap_payload_len);
+
+	if (!ASSERT_EQ(ret, test_case->encap_payload_len, "encap payload len"))
+		return -1;
+
+	if (!ASSERT_EQ(phdr->tskey, TSKEY, "tskey"))
+		return -1;
+
+	/* Assume we have got TX hwtstamp now.
+	 * Reuse the original payload to "regenerate" the
+	 * same skb to put into app_fd's sk_error_queue.
+	 */
+	phdr->geneve_opt.type = GENEVE_OPT_TYPE_TX_CMPL;
+	phdr->hwtstamp = HWTSTAMP;
+
+	/* GENEVE drops a packet if the outer/inner eth headers
+	 * have the same source address. (See geneve_rx())
+	 * Work around it by filling a fake address.
+	 */
+	swap_array(phdr->eth.h_source, h_source_dummy);
+
+	/* Send the TX completion packet to geneve0. */
+	ret = sendto(test_case->proxy_fd,
+		     test_case->encap_payload, test_case->encap_payload_len, 0,
+		     (struct sockaddr *)&test_case->geneve_local_addr, test_case->addrlen);
+	if (!ASSERT_EQ(ret, test_case->encap_payload_len, "sendto(tx cmpl)"))
+		return -1;
+
+	swap_array(phdr->eth.h_source, h_source_dummy);
+
+	return check_tstamp(test_case, true);
+}
+
+static int test_proxy_hwtstamp_rx(struct proxy_hwtstamp_test_case *test_case)
+{
+	struct proxy_header *phdr;
+	int ret;
+
+	/* Assume we have received a packet w/ RX hwtstamp.
+	 * Generate RX packet by swapping source/dest of the
+	 * original TX packet.
+	 */
+	phdr = (struct proxy_header *)test_case->encap_payload;
+
+	swap_array(phdr->eth.h_dest, phdr->eth.h_source);
+
+	if (test_case->family == AF_INET) {
+		swap(phdr->v4.ip.daddr, phdr->v4.ip.saddr);
+		swap(phdr->v4.udp.dest, phdr->v4.udp.source);
+	} else {
+		swap(phdr->v6.ip.daddr, phdr->v6.ip.saddr);
+		swap(phdr->v6.udp.dest, phdr->v6.udp.source);
+	}
+
+	/* Embed RX hwtstamp into the GENEVE option. */
+	phdr->geneve_opt.type = GENEVE_OPT_TYPE_RX;
+	phdr->hwtstamp = HWTSTAMP;
+	phdr->tskey = 0;
+
+	/* Send the packet to geneve0. */
+	ret = sendto(test_case->proxy_fd,
+		     test_case->encap_payload, test_case->encap_payload_len, 0,
+		     (struct sockaddr *)&test_case->geneve_local_addr, test_case->addrlen);
+	if (!ASSERT_EQ(ret, test_case->encap_payload_len, "sendto(rx)"))
+		return -1;
+
+	return check_tstamp(test_case, false);
+}
+
+static void run_test(struct proxy_hwtstamp_test_case *test_case)
+{
+	int ret;
+
+	ret = setup_env(test_case);
+	if (ret)
+		return;
+
+	ret = test_proxy_hwtstamp_tx(test_case);
+	if (!ret)
+		test_proxy_hwtstamp_rx(test_case);
+
+	destroy_env(test_case);
+}
+
+void test_proxy_hwtstamp(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
+		if (!test__start_subtest(test_cases[i].name))
+			continue;
+
+		run_test(&test_cases[i]);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index d8dacef37c16..77a88dc20a64 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -73,6 +73,7 @@
 #define ETH_P_IPV6		0x86DD
 
 #define NEXTHDR_TCP		6
+#define NEXTHDR_UDP		17
 
 #define TCPOPT_NOP		1
 #define TCPOPT_EOL		0
diff --git a/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c b/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c
new file mode 100644
index 000000000000..c15428e4c20f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2026 Google LLC */
+
+#include "vmlinux.h"
+#include <errno.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_tracing_net.h"
+
+struct proxy_hwtstamp_opt {
+	struct geneve_opt header;
+	ktime_t hwtstamp;
+	u32 tskey;
+} __attribute__((packed));
+
+#define GENEVE_VNI		0x900913
+#define GENEVE_OPT_CLASS	0x9009
+#define GENEVE_OPT_LEN		((sizeof(struct proxy_hwtstamp_opt)	\
+				  - sizeof(struct geneve_opt)) / 4)
+enum {
+	GENEVE_OPT_TYPE_TX	= 1,
+	GENEVE_OPT_TYPE_TX_CMPL	= 2,
+	GENEVE_OPT_TYPE_RX	= 3,
+};
+
+struct bpf_tunnel_key key_dst;	/* Populated from userspace for TX encap. */
+int tunnel_tx_flags;
+int tunnel_rx_flags;
+
+SEC("tcx/egress")
+int proxy_hwtstamp_egress(struct __sk_buff *skb)
+{
+	struct skb_shared_info *shared_info;
+	struct proxy_hwtstamp_opt opt = {};
+	struct sk_buff *kskb;
+	int ret;
+
+	/* Outgoing packet will be |ETH|IP|UDP|GENEVE|ETH|IP|UDP|Payload| */
+	ret = bpf_skb_set_tunnel_key(skb, &key_dst, sizeof(key_dst), tunnel_tx_flags);
+	if (ret < 0)
+		goto drop;
+
+	kskb = bpf_cast_to_kern_ctx(skb);
+	shared_info = bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info);
+	if (!shared_info->tx_flags) {
+		/* If TX tstamp is not needed, don't insert the GENEVE option.
+		 * The proxy socket will see genevehdr.opt_len == 0.
+		 */
+		goto pass;
+	}
+
+	opt.header.opt_class = bpf_htons(GENEVE_OPT_CLASS);
+	opt.header.type = GENEVE_OPT_TYPE_TX;
+	opt.header.length = GENEVE_OPT_LEN;
+	opt.tskey = shared_info->tskey;
+
+	/* Outgoing packet will be |ETH|IP|UDP|GENEVE|GENEVE_OPT|ETH|IP|UDP|Payload| */
+	ret = bpf_skb_set_tunnel_opt(skb, &opt, sizeof(opt));
+	if (ret < 0)
+		goto drop;
+
+	bpf_skb_scrub_tx_tstamp(skb);
+pass:
+	return TCX_PASS;
+drop:
+	return TCX_DROP;
+}
+
+static int proxy_hwtstamp_sk_assign(struct __sk_buff *skb,
+				    struct bpf_tx_tstamp_cmpl *attrs)
+{
+	struct bpf_sock_tuple tuple;
+	void *data_end, *data_l4;
+	__be16 *dport, *sport;
+	struct bpf_sock *skc;
+	struct ethhdr *eth;
+	int protocol_l4;
+	int tuple_size;
+	int ret;
+
+	data_end = (void *)(long)skb->data_end;
+	eth = (struct ethhdr *)(long)skb->data;
+
+	if (eth + 1 > data_end)
+		goto drop;
+
+	attrs->protocol = eth->h_proto;
+
+	switch (bpf_ntohs(eth->h_proto)) {
+	case ETH_P_IP: {
+		struct iphdr *ipv4 = (struct iphdr *)(eth + 1);
+
+		if (ipv4 + 1 > data_end)
+			goto drop;
+
+		attrs->payload_offset += sizeof(struct iphdr);
+
+		protocol_l4 = ipv4->protocol;
+		data_l4 = ipv4 + 1;
+
+		/* Swap daddr/saddr since this skb has the original TX headers. */
+		tuple.ipv4.daddr = ipv4->saddr;
+		tuple.ipv4.saddr = ipv4->daddr;
+
+		tuple_size = sizeof(tuple.ipv4);
+		dport = &tuple.ipv4.dport;
+		sport = &tuple.ipv4.sport;
+		break;
+	}
+	case ETH_P_IPV6: {
+		struct ipv6hdr *ipv6 = (struct ipv6hdr *)(eth + 1);
+
+		if (ipv6 + 1 > data_end)
+			goto drop;
+
+		attrs->payload_offset += sizeof(struct ipv6hdr);
+
+		protocol_l4 = ipv6->nexthdr;
+		data_l4 = ipv6 + 1;
+
+		/* Swap daddr/saddr since this skb has the original TX headers. */
+		__builtin_memcpy(tuple.ipv6.daddr, &ipv6->saddr, sizeof(tuple.ipv6.daddr));
+		__builtin_memcpy(tuple.ipv6.saddr, &ipv6->daddr, sizeof(tuple.ipv6.saddr));
+
+		tuple_size = sizeof(tuple.ipv6);
+		dport = &tuple.ipv6.dport;
+		sport = &tuple.ipv6.sport;
+		break;
+	}
+	default:
+		goto drop;
+	}
+
+	switch (protocol_l4) {
+	case IPPROTO_UDP: {
+		struct udphdr *udp = data_l4;
+
+		if (udp + 1 > data_end)
+			goto drop;
+
+		attrs->payload_offset += sizeof(struct udphdr);
+
+		/* Swap sport/dport since this skb has the original TX headers. */
+		*dport = udp->source;
+		*sport = udp->dest;
+
+		skc = bpf_sk_lookup_udp(skb, &tuple, tuple_size, -1, 0);
+		break;
+	}
+	default:
+		goto drop;
+	}
+	if (!skc)
+		goto drop;
+
+	ret = bpf_sk_assign(skb, skc, 0);
+	bpf_sk_release(skc);
+
+	if (ret)
+		goto drop;
+
+	return 0;
+drop:
+	return TCX_DROP;
+}
+
+static int proxy_hwtstamp_tx_completion(struct __sk_buff *skb, u32 tskey)
+{
+	struct bpf_tx_tstamp_cmpl attrs = {
+		.network_offset = sizeof(struct ethhdr),
+		.payload_offset = sizeof(struct ethhdr),
+		.tskey = tskey,
+	};
+	int ret;
+
+	/* Set skb->sk to the socket of the original sender. */
+	ret = proxy_hwtstamp_sk_assign(skb, &attrs);
+	if (ret)
+		return ret;
+
+	ret = bpf_skb_complete_tx_tstamp(skb, &attrs, sizeof(attrs));
+	if (ret)
+		return TCX_DROP;
+
+	return TCX_ERRQUEUE;
+}
+
+SEC("tcx/ingress")
+int proxy_hwtstamp_ingress(struct __sk_buff *skb)
+{
+	struct proxy_hwtstamp_opt opt;
+	struct bpf_tunnel_key key;
+	int ret;
+
+	/* Get the GENEVE header. */
+	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), tunnel_rx_flags);
+	if (ret < 0)
+		goto drop;
+
+	if (key.tunnel_id != GENEVE_VNI)
+		goto drop;
+
+	/* Get the GENEVE option. */
+	ret = bpf_skb_get_tunnel_opt(skb, &opt, sizeof(opt));
+	if (ret < sizeof(opt)) {
+		 /* If TX/RX tstamp is not needed, the proxy socket
+		  * does not insert the GENEVE option.
+		  */
+		goto pass;
+	}
+
+	if (opt.header.opt_class != bpf_htons(GENEVE_OPT_CLASS) ||
+	    opt.header.length != GENEVE_OPT_LEN)
+		goto drop;
+
+	if (opt.header.type == GENEVE_OPT_TYPE_TX_CMPL ||
+	    opt.header.type == GENEVE_OPT_TYPE_RX) {
+		struct bpf_hwtstamp attrs = {
+			.hwtstamp = opt.hwtstamp,
+		};
+
+		bpf_skb_set_hwtstamp(skb, &attrs, sizeof(attrs));
+
+		if (opt.header.type == GENEVE_OPT_TYPE_TX_CMPL)
+			return proxy_hwtstamp_tx_completion(skb, opt.tskey);
+	}
+pass:
+	return TCX_PASS;
+drop:
+	return TCX_DROP;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.54.0.1136.gdb2ca164c4-goog


