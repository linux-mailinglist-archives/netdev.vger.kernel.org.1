Return-Path: <netdev+bounces-300737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LWCjK/93NWq1xAYAu9opvQ
	(envelope-from <netdev+bounces-300737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 19:10:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2323F6A73E2
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 19:10:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=B5sXQM2T;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300737-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300737-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45DD73028C4A
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1573C10AE;
	Fri, 19 Jun 2026 17:09:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427753C10BA
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 17:09:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888986; cv=none; b=PqD1oaMcOKCfBaIjSOkFr13DxmuPNuZQ7usH7B/ZPAsJREK1rhHbrWU2Rfiew2FlEbdp1/te7avdVy2YdK/pH0HdTBJvx3Y+6JXEkS9qW66nZi4u8FgJiIFBe2Q+j8hASFuJrg3r6zu/2TitgflSwkeQfrsEtRuAW30KrZQJZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888986; c=relaxed/simple;
	bh=+A3eEmpBZzNjGihmYdke178Pc9uA0q4lLGN3pIreXIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WzhquCs3cItGM51o5kpW6GD4h/gf1xjgHtqe1fu2w8my8dckFFz7axmLRuyIsybDlqays6+aKnxZEkRoOV5aPxjfqVrMNCUMqPj4n7I4eydnGofvpVKAqrFxO7dLneyH+mWm1RONYjAPbVIBOy0ynpmZIIxn1dMW3nOktqgUcaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=B5sXQM2T; arc=none smtp.client-ip=209.85.208.53
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6976c215e7aso572536a12.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781888982; x=1782493782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYorBRGAPZp4Sqwz4MGVPQhJj7W0dCWeTo2JqCKIDRA=;
        b=B5sXQM2TKvAdDUIsHLzwEUPdgfhYPO2agWOLv2AepKxezrsQ7X/cGMzFUlZxUxZV9T
         a/PS96+4uHrncfQLNWFdeNkVpc255zFVbiD8WVo+64euigkh707j5r3JDVuvXZXawkEO
         1gvof4o51aherh8rgx9wdXsp1YJGiN1yfURGDESJfuE+sM9feeS0Q1lz9Tr2KsDthlFO
         dKQCOsG7foH58esk5h8h9mYXxAbOv/enRpcVm9mG42mu9lPuzVxENETd0I14XHpk2Ob6
         5QbAYdJTP2V69zt8+0tXzH9KdH2eOgOdoReiUqu+uRnDA049l17AmVu9rz0ICe0s5kTz
         GZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781888982; x=1782493782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tYorBRGAPZp4Sqwz4MGVPQhJj7W0dCWeTo2JqCKIDRA=;
        b=BWM0fW0cAREApU2FwmKBKk/JlH59pe/J3uPFzq3v8AykGA4gRvudji6UzquxwmXkx8
         q5CFppCLS9PrZiJxPzcnbZMpydp4cjgdOM7iwYlEaYrCtQUD0CM++hpk3nElRh20FZZb
         5hQaLzUrPVISgGPs8HXP/enSetR8mkBcrT/Xt0wCGeUieTmywqOlRuWw8DqdPonhEfYg
         Mu/lEP3WTnwD4CDMWSLH7RytMFTH0LxNO4+n2KefLwoMjryfNQP3XrX8kAyAIgbA1oPG
         ysPfVQNLFt4dla1A0SZqUo9+Iq1TDphpOH6TDw82QoP0zs69f0yA+cXWKJvL1aL5lskE
         q/0w==
X-Gm-Message-State: AOJu0YykpaepZqjXA2zIpfPFMbCooRkRoRalJPKRcf1Co9wMMP2aICd3
	XaBw+Ji54Omu+EBOonVt3Igwf68vfgHgS8s95mYMhZu9J96PGrE4wPUJfcNl0uC/Bhg=
X-Gm-Gg: AfdE7ckLGyO0Nw4tYRgZCeSoDI0z4oaHA2nvr03J6vWlmEhIXEKGS5D4thzRF9JV+rI
	9232UkbF1xqNvPGlJ2KZYBjm2FamwynOgTIegS+Pun8PjFO1dCf/nRrRFZP4nIS+k9RkCszKTJe
	rddWQT5bcEH8bMe2o4YXguFyGv3iYcbfabf9uuIoEIgmfUS2ESwX/pXnTSsNvJLSN/GzSO74+st
	UvGhq+Ns8BVQTrv0vggw6hCmnaCIqcV2dfbXgl8rfPvOnyIQoaog6gzv/8to1Aq/CQBcVO4uePR
	PB3aDP8/q3pT0/zwAyNamBLVss+QzaFWr9IX0ZLadVwoNdtkmNAnXXAfNwPgVdO5yoWsRe6iS+P
	1FLfDeFTwPeHNxlLPBUpo405oLWMiOQ7wseEVZlDM37p8UubPq+sVm/2L1fUINuSlIIBmOpX+QE
	6TAYVZ1A2ml5mpIz/oHrCImXL7+um6z9Pk88aqwFFSAd0hrYRMlHE5TFPNs5U=
X-Received: by 2002:a05:6402:158f:b0:691:b5aa:5a66 with SMTP id 4fb4d7f45d1cf-69756879ab0mr1583635a12.16.1781888981675;
        Fri, 19 Jun 2026 10:09:41 -0700 (PDT)
Received: from cloudflare.com (79.184.207.15.ipv4.supernova.orange.pl. [79.184.207.15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69711f4d5c4sm1072291a12.24.2026.06.19.10.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 10:09:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 19 Jun 2026 19:09:29 +0200
Subject: [PATCH net v3 2/2] selftests/bpf: Add LWT encap tests for skb
 metadata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-bpf-lwt-drop-skb-metadata-v3-2-71d6a33ab76b@cloudflare.com>
References: <20260619-bpf-lwt-drop-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com>
In-Reply-To: <20260619-bpf-lwt-drop-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300737-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:martin.lau@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2323F6A73E2

Test that an LWT encapsulation does not silently corrupt XDP metadata
sitting in the skb headroom. Exercise all three LWT dispatch paths:

- BPF LWT xmit prog reserves headroom on the LWT .xmit redirect,
- mpls pushes an MPLS label on the LWT .xmit redirect,
- seg6 in encap mode runs on the LWT .input redirect,
- ioam6 encap inserts an IOAM Hop-by-Hop option on LWT .output redirect.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/config                 |   3 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 175 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 123 +++++++++------
 3 files changed, 249 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index bac60b444551..adb25146e88c 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -45,13 +45,16 @@ CONFIG_IPV6=y
 CONFIG_IPV6_FOU=y
 CONFIG_IPV6_FOU_TUNNEL=y
 CONFIG_IPV6_GRE=y
+CONFIG_IPV6_IOAM6_LWTUNNEL=y
 CONFIG_IPV6_SEG6_BPF=y
+CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_IPV6_SIT=y
 CONFIG_IPV6_TUNNEL=y
 CONFIG_KEYS=y
 CONFIG_LIRC=y
 CONFIG_LIVEPATCH=y
 CONFIG_LWTUNNEL=y
+CONFIG_LWTUNNEL_BPF=y
 CONFIG_MODULE_SIG=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 26159e0499c7..448807676176 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <network_helpers.h>
+#include <linux/ipv6.h>
+#include <arpa/inet.h>
 #include "test_xdp_context_test_run.skel.h"
 #include "test_xdp_meta.skel.h"
 
@@ -8,9 +10,12 @@
 #define TX_NAME "veth1"
 #define TX_NETNS "xdp_context_tx"
 #define RX_NETNS "xdp_context_rx"
+#define RX_MAC "02:00:00:00:00:01"
+#define TX_MAC "02:00:00:00:00:02"
 #define TAP_NAME "tap0"
 #define DUMMY_NAME "dum0"
 #define TAP_NETNS "xdp_context_tuntap"
+#define LWT_NETNS "xdp_context_lwt"
 
 #define TEST_PAYLOAD_LEN 32
 static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
@@ -187,6 +192,42 @@ static int write_test_packet(int tap_fd)
 	return 0;
 }
 
+/* Inject Ethernet+IPv6+UDP frame into TAP */
+static int write_test_packet_udp(int tap_fd)
+{
+	__u8 pkt[sizeof(struct ethhdr) + sizeof(struct ipv6hdr) +
+		 sizeof(struct udphdr) + TEST_PAYLOAD_LEN] = {};
+	struct ethhdr *eth = (void *)pkt;
+	struct ipv6hdr *ip6 = (void *)(eth + 1);
+	struct udphdr *udp = (void *)(ip6 + 1);
+	__u8 *payload = (void *)(udp + 1);
+	const __u8 tap_mac[ETH_ALEN] = { 0x02, 0, 0, 0, 0, 0x01 };
+	int n;
+
+	memcpy(eth->h_dest, tap_mac, ETH_ALEN);
+	eth->h_proto = htons(ETH_P_IPV6);
+
+	ip6->version = 6;
+	ip6->hop_limit = 64;
+	ip6->nexthdr = IPPROTO_UDP;
+	ip6->payload_len = htons(sizeof(*udp) + TEST_PAYLOAD_LEN);
+	inet_pton(AF_INET6, "fd00::2", &ip6->saddr);
+	inet_pton(AF_INET6, "fd00:1::1", &ip6->daddr);
+
+	udp->source = htons(42);
+	udp->dest = htons(42);
+	udp->len = htons(sizeof(*udp) + TEST_PAYLOAD_LEN);
+	/* UDP checksum is not validated on the forwarding path. */
+
+	memcpy(payload, test_payload, TEST_PAYLOAD_LEN);
+
+	n = write(tap_fd, pkt, sizeof(pkt));
+	if (!ASSERT_EQ(n, sizeof(pkt), "write frame"))
+		return -1;
+
+	return 0;
+}
+
 static void dump_err_stream(const struct bpf_program *prog)
 {
 	char buf[512];
@@ -518,3 +559,137 @@ void test_xdp_context_tuntap(void)
 
 	test_xdp_meta__destroy(skel);
 }
+
+/*
+ * Test topology:
+ *
+ *	tap0 fd00::1
+ *	  RX:  injected IPv6 UDP frame, XDP ingress sets metadata
+ *	  fwd: encap route prepends outer header(s)
+ *	  TX:  TC egress validates metadata
+ *
+ * A routable IPv6 UDP frame is written into the tap fd, so it enters the RX
+ * path where XDP stores metadata. Routing then forwards it back out the same
+ * tap through an encapsulating route that prepends outer header(s). The TC
+ * egress program checks that the pushed header did not silently corrupt
+ * metadata.
+ */
+#define LWT_PIN_PATH "/sys/fs/bpf/xdp_context_lwt_xmit"
+
+enum lwt_encap_type {
+	LWT_ENCAP_BPF,
+	LWT_ENCAP_MPLS,
+	LWT_ENCAP_SEG6,
+	LWT_ENCAP_IOAM6,
+};
+
+static void test_lwt_encap(struct test_xdp_meta *skel,
+			   enum lwt_encap_type type)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_program *lwt_prog = NULL;
+	struct netns_obj *ns = NULL;
+	const char *encap;
+	bool pinned = false;
+	int tap_ifindex;
+	int tap_fd = -1;
+	int ret;
+
+	skel->bss->test_pass = false;
+
+	switch (type) {
+	case LWT_ENCAP_BPF:
+		encap = "encap bpf xmit pinned " LWT_PIN_PATH " via fd00::2";
+		lwt_prog = skel->progs.dummy_lwt_xmit;
+		break;
+	case LWT_ENCAP_MPLS:
+		encap = "encap mpls 100 via inet6 fd00::2";
+		break;
+	case LWT_ENCAP_SEG6:
+		encap = "encap seg6 mode encap segs fd00::2";
+		break;
+	case LWT_ENCAP_IOAM6:
+		encap = "encap ioam6 mode encap tundst fd00::2 "
+			"trace prealloc type 0x800000 ns 0 size 4 via fd00::2";
+		break;
+	default:
+		return;
+	}
+
+	if (lwt_prog) {
+		unlink(LWT_PIN_PATH);
+		ret = bpf_program__pin(lwt_prog, LWT_PIN_PATH);
+		if (!ASSERT_OK(ret, "pin lwt prog"))
+			return;
+		pinned = true;
+	}
+
+	ns = netns_new(LWT_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto close;
+
+	tap_fd = open_tuntap(TAP_NAME, true);
+	if (!ASSERT_GE(tap_fd, 0, "open_tuntap"))
+		goto close;
+
+	SYS(close, "ip link set dev " TAP_NAME " address " RX_MAC);
+	SYS(close, "sysctl -wq net.ipv6.conf.all.forwarding=1");
+	SYS(close, "ip addr add fd00::1/64 dev " TAP_NAME " nodad");
+	SYS(close, "ip link set dev " TAP_NAME " up");
+	SYS(close, "ip neigh add fd00::2 lladdr " TX_MAC " nud permanent dev " TAP_NAME);
+	SYS(close, "ip -6 route add fd00:1::/64 %s dev %s", encap, TAP_NAME);
+
+	tap_ifindex = if_nametoindex(TAP_NAME);
+	if (!ASSERT_GE(tap_ifindex, 0, "if_nametoindex"))
+		goto close;
+
+	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(skel->progs.ing_xdp),
+			     0, NULL);
+	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
+		goto close;
+
+	tc_hook.ifindex = tap_ifindex;
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto close;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_is_meta_empty);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto close;
+
+	ret = write_test_packet_udp(tap_fd);
+	if (!ASSERT_OK(ret, "write_test_packet_udp"))
+		goto close;
+
+	if (!ASSERT_TRUE(skel->bss->test_pass, "test_pass"))
+		dump_err_stream(skel->progs.tc_is_meta_empty);
+
+close:
+	if (tap_fd >= 0)
+		close(tap_fd);
+	netns_free(ns);
+	if (pinned)
+		unlink(LWT_PIN_PATH);
+}
+
+void test_xdp_context_lwt_encap(void)
+{
+	struct test_xdp_meta *skel;
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		return;
+
+	if (test__start_subtest("bpf_encap"))
+		test_lwt_encap(skel, LWT_ENCAP_BPF);
+	if (test__start_subtest("mpls_encap"))
+		test_lwt_encap(skel, LWT_ENCAP_MPLS);
+	if (test__start_subtest("seg6_encap"))
+		test_lwt_encap(skel, LWT_ENCAP_SEG6);
+	if (test__start_subtest("ioam6_encap"))
+		test_lwt_encap(skel, LWT_ENCAP_IOAM6);
+
+	test_xdp_meta__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index fa73b17cb999..08b03be0b891 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -21,10 +21,6 @@
 
 bool test_pass;
 
-static const __u8 smac_want[ETH_ALEN] = {
-	0x12, 0x34, 0xDE, 0xAD, 0xBE, 0xEF,
-};
-
 static const __u8 meta_want[META_SIZE] = {
 	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
@@ -32,11 +28,6 @@ static const __u8 meta_want[META_SIZE] = {
 	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
 };
 
-static bool check_smac(const struct ethhdr *eth)
-{
-	return !__builtin_memcmp(eth->h_source, smac_want, ETH_ALEN);
-}
-
 static bool check_metadata(const char *file, int line, __u8 *meta_have)
 {
 	if (!__builtin_memcmp(meta_have, meta_want, META_SIZE))
@@ -280,18 +271,47 @@ int ing_cls_dynptr_offset_oob(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Test packets carry test metadata pattern as payload. */
+static bool is_test_packet_xdp(struct xdp_md *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	__u32 len;
+
+	len = bpf_xdp_get_buff_len(ctx);
+	if (len < META_SIZE)
+		return false;
+	if (bpf_xdp_load_bytes(ctx, len - META_SIZE, meta_have, META_SIZE))
+		return false;
+	if (__builtin_memcmp(meta_have, meta_want, META_SIZE))
+		return false;
+
+	return true;
+}
+
+/* Test packets carry test metadata pattern as payload. */
+static bool is_test_packet_tc(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+
+	if (ctx->len < META_SIZE)
+		return false;
+	if (bpf_skb_load_bytes(ctx, ctx->len - META_SIZE, meta_have, META_SIZE))
+		return false;
+	if (__builtin_memcmp(meta_have, meta_want, META_SIZE))
+		return false;
+
+	return true;
+}
+
 /* Reserve and clear space for metadata but don't populate it */
 SEC("xdp")
 int ing_xdp_zalloc_meta(struct xdp_md *ctx)
 {
-	struct ethhdr *eth = ctx_ptr(ctx, data);
 	__u8 *meta;
 	int ret;
 
 	/* Drop any non-test packets */
-	if (eth + 1 > ctx_ptr(ctx, data_end))
-		return XDP_DROP;
-	if (!check_smac(eth))
+	if (!is_test_packet_xdp(ctx))
 		return XDP_DROP;
 
 	ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
@@ -310,33 +330,24 @@ int ing_xdp_zalloc_meta(struct xdp_md *ctx)
 SEC("xdp")
 int ing_xdp(struct xdp_md *ctx)
 {
-	__u8 *data, *data_meta, *data_end, *payload;
-	struct ethhdr *eth;
+	__u8 *data, *data_meta;
 	int ret;
 
+	/* Drop any non-test packets */
+	if (!is_test_packet_xdp(ctx))
+		return XDP_DROP;
+
 	ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
 	if (ret < 0)
 		return XDP_DROP;
 
 	data_meta = ctx_ptr(ctx, data_meta);
-	data_end  = ctx_ptr(ctx, data_end);
 	data      = ctx_ptr(ctx, data);
 
-	eth = (struct ethhdr *)data;
-	payload = data + sizeof(struct ethhdr);
-
-	if (payload + META_SIZE > data_end ||
-	    data_meta + META_SIZE > data)
+	if (data_meta + META_SIZE > data)
 		return XDP_DROP;
 
-	/* The Linux networking stack may send other packets on the test
-	 * interface that interfere with the test. Just drop them.
-	 * The test packets can be recognized by their source MAC address.
-	 */
-	if (!check_smac(eth))
-		return XDP_DROP;
-
-	__builtin_memcpy(data_meta, payload, META_SIZE);
+	__builtin_memcpy(data_meta, meta_want, META_SIZE);
 	return XDP_PASS;
 }
 
@@ -353,7 +364,7 @@ int clone_data_meta_survives_data_write(struct __sk_buff *ctx)
 	if (eth + 1 > ctx_ptr(ctx, data_end))
 		goto out;
 	/* Ignore non-test packets */
-	if (!check_smac(eth))
+	if (!is_test_packet_tc(ctx))
 		goto out;
 
 	if (meta_have + META_SIZE > eth)
@@ -383,7 +394,7 @@ int clone_data_meta_survives_meta_write(struct __sk_buff *ctx)
 	if (eth + 1 > ctx_ptr(ctx, data_end))
 		goto out;
 	/* Ignore non-test packets */
-	if (!check_smac(eth))
+	if (!is_test_packet_tc(ctx))
 		goto out;
 
 	if (meta_have + META_SIZE > eth)
@@ -416,7 +427,7 @@ int clone_meta_dynptr_survives_data_slice_write(struct __sk_buff *ctx)
 	if (!eth)
 		goto out;
 	/* Ignore non-test packets */
-	if (!check_smac(eth))
+	if (!is_test_packet_tc(ctx))
 		goto out;
 
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
@@ -436,16 +447,11 @@ int clone_meta_dynptr_survives_data_slice_write(struct __sk_buff *ctx)
 SEC("tc")
 int clone_meta_dynptr_survives_meta_slice_write(struct __sk_buff *ctx)
 {
-	struct bpf_dynptr data, meta;
-	const struct ethhdr *eth;
+	struct bpf_dynptr meta;
 	__u8 *meta_have;
 
-	bpf_dynptr_from_skb(ctx, 0, &data);
-	eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
-	if (!eth)
-		goto out;
 	/* Ignore non-test packets */
-	if (!check_smac(eth))
+	if (!is_test_packet_tc(ctx))
 		goto out;
 
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
@@ -471,15 +477,10 @@ int clone_meta_dynptr_rw_before_data_dynptr_write(struct __sk_buff *ctx)
 {
 	struct bpf_dynptr data, meta;
 	__u8 meta_have[META_SIZE];
-	const struct ethhdr *eth;
 	int err;
 
-	bpf_dynptr_from_skb(ctx, 0, &data);
-	eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
-	if (!eth)
-		goto out;
 	/* Ignore non-test packets */
-	if (!check_smac(eth))
+	if (!is_test_packet_tc(ctx))
 		goto out;
 
 	/* Expect read-write metadata before unclone */
@@ -492,6 +493,7 @@ int clone_meta_dynptr_rw_before_data_dynptr_write(struct __sk_buff *ctx)
 		goto out;
 
 	/* Helper write to payload will unclone the packet */
+	bpf_dynptr_from_skb(ctx, 0, &data);
 	bpf_dynptr_write(&data, offsetof(struct ethhdr, h_proto), "x", 1, 0);
 
 	err = bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
@@ -511,17 +513,12 @@ int clone_meta_dynptr_rw_before_data_dynptr_write(struct __sk_buff *ctx)
 SEC("tc")
 int clone_meta_dynptr_rw_before_meta_dynptr_write(struct __sk_buff *ctx)
 {
-	struct bpf_dynptr data, meta;
+	struct bpf_dynptr meta;
 	__u8 meta_have[META_SIZE];
-	const struct ethhdr *eth;
 	int err;
 
-	bpf_dynptr_from_skb(ctx, 0, &data);
-	eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
-	if (!eth)
-		goto out;
 	/* Ignore non-test packets */
-	if (!check_smac(eth))
+	if (!is_test_packet_tc(ctx))
 		goto out;
 
 	/* Expect read-write metadata before unclone */
@@ -545,6 +542,28 @@ int clone_meta_dynptr_rw_before_meta_dynptr_write(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+SEC("lwt_xmit")
+int dummy_lwt_xmit(struct __sk_buff *ctx)
+{
+	if (bpf_skb_change_head(ctx, sizeof(struct ipv6hdr), 0))
+		return BPF_DROP;
+
+	return BPF_OK;
+}
+
+SEC("tc")
+int tc_is_meta_empty(struct __sk_buff *ctx)
+{
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_OK;
+
+	if (ctx->data_meta != ctx->data)
+		return TC_ACT_OK;
+
+	test_pass = true;
+	return TC_ACT_OK;
+}
+
 SEC("tc")
 int helper_skb_vlan_push_pop(struct __sk_buff *ctx)
 {

-- 
2.43.0


