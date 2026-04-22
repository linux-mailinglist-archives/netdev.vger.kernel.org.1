Return-Path: <netdev+bounces-280495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHOsGEf46GkgSQIAu9opvQ
	(envelope-from <netdev+bounces-280495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:33:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4986448B47
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A19330C0FD0
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4554937F017;
	Wed, 22 Apr 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eA5OjckL"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C974238D017
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874849; cv=none; b=D84h6EB/shmxCG7mz2CqMr0lrr8jYvgB8QjdjQYW+0PcDMJhLAhZM7n55Vk/Uo8wVjp9gL8WNWjtRfEUHU176VpIAOTZ04tYpokuGd3ZDb+PKpfLweYm8QEJHU5E4ahEivOotNzeFw+nWHbNxX0Py35UUC5Z5f5PlEmICSBmKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874849; c=relaxed/simple;
	bh=h3xv39jUZ/R+lfGs6ko1ajmxnX4uTAA68skLyghAfZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bB9lyTlkMpClHwF3JyQEFzaa4+o8zPR+HR0HHxGlZXAYDMkfnSpYeq4kQnTSb8iPhYudaRr4azDEBB4gvMaUCWXmmWZ37uLSBIacXIjwsJM/z0QB6DWIQ53F/jDCj8YecL/GpA/1jTtj05wQtNbX9pHgEYsjYQh90BhOPjA1bjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eA5OjckL; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 81C634E42AB6;
	Wed, 22 Apr 2026 16:20:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 553775FA8F;
	Wed, 22 Apr 2026 16:20:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB9AF10460BF0;
	Wed, 22 Apr 2026 18:20:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776874844; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Q3PA2FXpnk6YdWcpbs4KcZaHnJZnOtGX1Ufqkx8Nrns=;
	b=eA5OjckLYd+do2birui7IIshr7p50dsHtGqbEqskX7Vj1bRcCNx2wzr/yukAHaBfg4DTJi
	dwqXoVCSK11kEK1Zj8gMbXS3V1lKqTh1xWcTLolDd8SIS+7xC4QuMcElEyXF2LPDqCSDxd
	SAFrlfbtDIYaTk0MWrBRslV5CD+NY0nhl5M0Qo6CZ7RBXYN0q1gT5+2QJuaQ5j88Klqyxp
	uV8v95DTg8J9D5e9nW070pfWaKJZJG5pvmA+K1pAS1hYHzpwhqYzfYKJ7POUzwUe1Yprks
	pyTq9MCTjD54Xwd8XcC1D04eJsbsCJcF7jWevkv1GGwleYsSPByBbe+3C8HdSg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 22 Apr 2026 18:20:25 +0200
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: drop xdping tool
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260422-xdping-v2-2-c0f8ccedcf91@bootlin.com>
References: <20260422-xdping-v2-0-c0f8ccedcf91@bootlin.com>
In-Reply-To: <20260422-xdping-v2-0-c0f8ccedcf91@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
 Alan Maguire <alan.maguire@oracle.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280495-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexis.lothore@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,xsk_prereqs.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,liburandom_read.so:url]
X-Rspamd-Queue-Id: A4986448B47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As part of a larger cleanup effort in the bpf selftests directory,
tests and scripts are either being converted to the test_progs framework
(so they are executed automatically in bpf CI), or removed if not
relevant for such integration.

The test_xdping.sh script (with the associated xdping.c) acts as a RTT
measurement tool, by attaching two small xdp programs to two interfaces.
Converting this test to test_progs may not make much sense:
- RTT measurement does not really fit in the scope of a functional test,
  this is rather about measuring some performance level.
- there are other existing tests in test_progs that actively validate
  XDP features like program attachment, return value processing, packet
  modification, etc

Drop test_xdping.sh, the corresponding xdping.c userspace part, the
xdping_kern.c program, and the shared header, xdping.h

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/.gitignore          |   1 -
 tools/testing/selftests/bpf/Makefile            |   3 -
 tools/testing/selftests/bpf/progs/xdping_kern.c | 183 -----------------
 tools/testing/selftests/bpf/test_xdping.sh      | 103 ----------
 tools/testing/selftests/bpf/xdping.c            | 254 ------------------------
 tools/testing/selftests/bpf/xdping.h            |  13 --
 6 files changed, 557 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index bfdc5518ecc8..986a6389186b 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -21,7 +21,6 @@ test_lirc_mode2_user
 flow_dissector_load
 test_tcpnotify_user
 test_libbpf
-xdping
 test_cpp
 *.d
 *.subskel.h
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 78e60040811e..00a986a7d088 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -111,7 +111,6 @@ TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
 	test_lirc_mode2.sh \
-	test_xdping.sh \
 	test_bpftool_build.sh \
 	test_doc_build.sh \
 	test_xsk.sh \
@@ -134,7 +133,6 @@ TEST_GEN_PROGS_EXTENDED = \
 	xdp_features \
 	xdp_hw_metadata \
 	xdp_synproxy \
-	xdping \
 	xskxceiver
 
 TEST_GEN_FILES += $(TEST_KMODS) liburandom_read.so urandom_read sign-file uprobe_multi
@@ -320,7 +318,6 @@ $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELP
 $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tag: $(TESTING_HELPERS)
 $(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
-$(OUTPUT)/xdping: $(TESTING_HELPERS)
 $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
 $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
diff --git a/tools/testing/selftests/bpf/progs/xdping_kern.c b/tools/testing/selftests/bpf/progs/xdping_kern.c
deleted file mode 100644
index 44e2b0ef23ae..000000000000
--- a/tools/testing/selftests/bpf/progs/xdping_kern.c
+++ /dev/null
@@ -1,183 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved. */
-
-#define KBUILD_MODNAME "foo"
-#include <stddef.h>
-#include <string.h>
-#include <linux/bpf.h>
-#include <linux/icmp.h>
-#include <linux/in.h>
-#include <linux/if_ether.h>
-#include <linux/if_packet.h>
-#include <linux/if_vlan.h>
-#include <linux/ip.h>
-
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_endian.h>
-
-#include "bpf_compiler.h"
-#include "xdping.h"
-
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__uint(max_entries, 256);
-	__type(key, __u32);
-	__type(value, struct pinginfo);
-} ping_map SEC(".maps");
-
-static __always_inline void swap_src_dst_mac(void *data)
-{
-	unsigned short *p = data;
-	unsigned short dst[3];
-
-	dst[0] = p[0];
-	dst[1] = p[1];
-	dst[2] = p[2];
-	p[0] = p[3];
-	p[1] = p[4];
-	p[2] = p[5];
-	p[3] = dst[0];
-	p[4] = dst[1];
-	p[5] = dst[2];
-}
-
-static __always_inline __u16 csum_fold_helper(__wsum sum)
-{
-	sum = (sum & 0xffff) + (sum >> 16);
-	return ~((sum & 0xffff) + (sum >> 16));
-}
-
-static __always_inline __u16 ipv4_csum(void *data_start, int data_size)
-{
-	__wsum sum;
-
-	sum = bpf_csum_diff(0, 0, data_start, data_size, 0);
-	return csum_fold_helper(sum);
-}
-
-#define ICMP_ECHO_LEN		64
-
-static __always_inline int icmp_check(struct xdp_md *ctx, int type)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
-	struct ethhdr *eth = data;
-	struct icmphdr *icmph;
-	struct iphdr *iph;
-
-	if (data + sizeof(*eth) + sizeof(*iph) + ICMP_ECHO_LEN > data_end)
-		return XDP_PASS;
-
-	if (eth->h_proto != bpf_htons(ETH_P_IP))
-		return XDP_PASS;
-
-	iph = data + sizeof(*eth);
-
-	if (iph->protocol != IPPROTO_ICMP)
-		return XDP_PASS;
-
-	if (bpf_ntohs(iph->tot_len) - sizeof(*iph) != ICMP_ECHO_LEN)
-		return XDP_PASS;
-
-	icmph = data + sizeof(*eth) + sizeof(*iph);
-
-	if (icmph->type != type)
-		return XDP_PASS;
-
-	return XDP_TX;
-}
-
-SEC("xdp")
-int xdping_client(struct xdp_md *ctx)
-{
-	void *data = (void *)(long)ctx->data;
-	struct pinginfo *pinginfo = NULL;
-	struct ethhdr *eth = data;
-	struct icmphdr *icmph;
-	struct iphdr *iph;
-	__u64 recvtime;
-	__be32 raddr;
-	__be16 seq;
-	int ret;
-	__u8 i;
-
-	ret = icmp_check(ctx, ICMP_ECHOREPLY);
-
-	if (ret != XDP_TX)
-		return ret;
-
-	iph = data + sizeof(*eth);
-	icmph = data + sizeof(*eth) + sizeof(*iph);
-	raddr = iph->saddr;
-
-	/* Record time reply received. */
-	recvtime = bpf_ktime_get_ns();
-	pinginfo = bpf_map_lookup_elem(&ping_map, &raddr);
-	if (!pinginfo || pinginfo->seq != icmph->un.echo.sequence)
-		return XDP_PASS;
-
-	if (pinginfo->start) {
-		__pragma_loop_unroll_full
-		for (i = 0; i < XDPING_MAX_COUNT; i++) {
-			if (pinginfo->times[i] == 0)
-				break;
-		}
-		/* verifier is fussy here... */
-		if (i < XDPING_MAX_COUNT) {
-			pinginfo->times[i] = recvtime -
-					     pinginfo->start;
-			pinginfo->start = 0;
-			i++;
-		}
-		/* No more space for values? */
-		if (i == pinginfo->count || i == XDPING_MAX_COUNT)
-			return XDP_PASS;
-	}
-
-	/* Now convert reply back into echo request. */
-	swap_src_dst_mac(data);
-	iph->saddr = iph->daddr;
-	iph->daddr = raddr;
-	icmph->type = ICMP_ECHO;
-	seq = bpf_htons(bpf_ntohs(icmph->un.echo.sequence) + 1);
-	icmph->un.echo.sequence = seq;
-	icmph->checksum = 0;
-	icmph->checksum = ipv4_csum(icmph, ICMP_ECHO_LEN);
-
-	pinginfo->seq = seq;
-	pinginfo->start = bpf_ktime_get_ns();
-
-	return XDP_TX;
-}
-
-SEC("xdp")
-int xdping_server(struct xdp_md *ctx)
-{
-	void *data = (void *)(long)ctx->data;
-	struct ethhdr *eth = data;
-	struct icmphdr *icmph;
-	struct iphdr *iph;
-	__be32 raddr;
-	int ret;
-
-	ret = icmp_check(ctx, ICMP_ECHO);
-
-	if (ret != XDP_TX)
-		return ret;
-
-	iph = data + sizeof(*eth);
-	icmph = data + sizeof(*eth) + sizeof(*iph);
-	raddr = iph->saddr;
-
-	/* Now convert request into echo reply. */
-	swap_src_dst_mac(data);
-	iph->saddr = iph->daddr;
-	iph->daddr = raddr;
-	icmph->type = ICMP_ECHOREPLY;
-	icmph->checksum = 0;
-	icmph->checksum = ipv4_csum(icmph, ICMP_ECHO_LEN);
-
-	return XDP_TX;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_xdping.sh b/tools/testing/selftests/bpf/test_xdping.sh
deleted file mode 100755
index c3d82e0a7378..000000000000
--- a/tools/testing/selftests/bpf/test_xdping.sh
+++ /dev/null
@@ -1,103 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-# xdping tests
-#   Here we setup and teardown configuration required to run
-#   xdping, exercising its options.
-#
-#   Setup is similar to test_tunnel tests but without the tunnel.
-#
-# Topology:
-# ---------
-#     root namespace   |     tc_ns0 namespace
-#                      |
-#      ----------      |     ----------
-#      |  veth1  | --------- |  veth0  |
-#      ----------    peer    ----------
-#
-# Device Configuration
-# --------------------
-# Root namespace with BPF
-# Device names and addresses:
-#	veth1 IP: 10.1.1.200
-#	xdp added to veth1, xdpings originate from here.
-#
-# Namespace tc_ns0 with BPF
-# Device names and addresses:
-#       veth0 IPv4: 10.1.1.100
-#	For some tests xdping run in server mode here.
-#
-
-readonly TARGET_IP="10.1.1.100"
-readonly TARGET_NS="xdp_ns0"
-
-readonly LOCAL_IP="10.1.1.200"
-
-setup()
-{
-	ip netns add $TARGET_NS
-	ip link add veth0 type veth peer name veth1
-	ip link set veth0 netns $TARGET_NS
-	ip netns exec $TARGET_NS ip addr add ${TARGET_IP}/24 dev veth0
-	ip addr add ${LOCAL_IP}/24 dev veth1
-	ip netns exec $TARGET_NS ip link set veth0 up
-	ip link set veth1 up
-}
-
-cleanup()
-{
-	set +e
-	ip netns delete $TARGET_NS 2>/dev/null
-	ip link del veth1 2>/dev/null
-	if [[ $server_pid -ne 0 ]]; then
-		kill -TERM $server_pid
-	fi
-}
-
-test()
-{
-	client_args="$1"
-	server_args="$2"
-
-	echo "Test client args '$client_args'; server args '$server_args'"
-
-	server_pid=0
-	if [[ -n "$server_args" ]]; then
-		ip netns exec $TARGET_NS ./xdping $server_args &
-		server_pid=$!
-		sleep 10
-	fi
-	./xdping $client_args $TARGET_IP
-
-	if [[ $server_pid -ne 0 ]]; then
-		kill -TERM $server_pid
-		server_pid=0
-	fi
-
-	echo "Test client args '$client_args'; server args '$server_args': PASS"
-}
-
-set -e
-
-server_pid=0
-
-trap cleanup EXIT
-
-setup
-
-for server_args in "" "-I veth0 -s -S" ; do
-	# client in skb mode
-	client_args="-I veth1 -S"
-	test "$client_args" "$server_args"
-
-	# client with count of 10 RTT measurements.
-	client_args="-I veth1 -S -c 10"
-	test "$client_args" "$server_args"
-done
-
-# Test drv mode
-test "-I veth1 -N" "-I veth0 -s -N"
-test "-I veth1 -N -c 10" "-I veth0 -s -N"
-
-echo "OK. All tests passed"
-exit 0
diff --git a/tools/testing/selftests/bpf/xdping.c b/tools/testing/selftests/bpf/xdping.c
deleted file mode 100644
index 9ed8c796645d..000000000000
--- a/tools/testing/selftests/bpf/xdping.c
+++ /dev/null
@@ -1,254 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved. */
-
-#include <linux/bpf.h>
-#include <linux/if_link.h>
-#include <arpa/inet.h>
-#include <assert.h>
-#include <errno.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <libgen.h>
-#include <net/if.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netdb.h>
-
-#include "bpf/bpf.h"
-#include "bpf/libbpf.h"
-
-#include "xdping.h"
-#include "testing_helpers.h"
-
-static int ifindex;
-static __u32 xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
-
-static void cleanup(int sig)
-{
-	bpf_xdp_detach(ifindex, xdp_flags, NULL);
-	if (sig)
-		exit(1);
-}
-
-static int get_stats(int fd, __u16 count, __u32 raddr)
-{
-	struct pinginfo pinginfo = { 0 };
-	char inaddrbuf[INET_ADDRSTRLEN];
-	struct in_addr inaddr;
-	__u16 i;
-
-	inaddr.s_addr = raddr;
-
-	printf("\nXDP RTT data:\n");
-
-	if (bpf_map_lookup_elem(fd, &raddr, &pinginfo)) {
-		perror("bpf_map_lookup elem");
-		return 1;
-	}
-
-	for (i = 0; i < count; i++) {
-		if (pinginfo.times[i] == 0)
-			break;
-
-		printf("64 bytes from %s: icmp_seq=%d ttl=64 time=%#.5f ms\n",
-		       inet_ntop(AF_INET, &inaddr, inaddrbuf,
-				 sizeof(inaddrbuf)),
-		       count + i + 1,
-		       (double)pinginfo.times[i]/1000000);
-	}
-
-	if (i < count) {
-		fprintf(stderr, "Expected %d samples, got %d.\n", count, i);
-		return 1;
-	}
-
-	bpf_map_delete_elem(fd, &raddr);
-
-	return 0;
-}
-
-static void show_usage(const char *prog)
-{
-	fprintf(stderr,
-		"usage: %s [OPTS] -I interface destination\n\n"
-		"OPTS:\n"
-		"    -c count		Stop after sending count requests\n"
-		"			(default %d, max %d)\n"
-		"    -I interface	interface name\n"
-		"    -N			Run in driver mode\n"
-		"    -s			Server mode\n"
-		"    -S			Run in skb mode\n",
-		prog, XDPING_DEFAULT_COUNT, XDPING_MAX_COUNT);
-}
-
-int main(int argc, char **argv)
-{
-	__u32 mode_flags = XDP_FLAGS_DRV_MODE | XDP_FLAGS_SKB_MODE;
-	struct addrinfo *a, hints = { .ai_family = AF_INET };
-	__u16 count = XDPING_DEFAULT_COUNT;
-	struct pinginfo pinginfo = { 0 };
-	const char *optstr = "c:I:NsS";
-	struct bpf_program *main_prog;
-	int prog_fd = -1, map_fd = -1;
-	struct sockaddr_in rin;
-	struct bpf_object *obj;
-	struct bpf_map *map;
-	char *ifname = NULL;
-	char filename[256];
-	int opt, ret = 1;
-	__u32 raddr = 0;
-	int server = 0;
-	char cmd[256];
-
-	while ((opt = getopt(argc, argv, optstr)) != -1) {
-		switch (opt) {
-		case 'c':
-			count = atoi(optarg);
-			if (count < 1 || count > XDPING_MAX_COUNT) {
-				fprintf(stderr,
-					"min count is 1, max count is %d\n",
-					XDPING_MAX_COUNT);
-				return 1;
-			}
-			break;
-		case 'I':
-			ifname = optarg;
-			ifindex = if_nametoindex(ifname);
-			if (!ifindex) {
-				fprintf(stderr, "Could not get interface %s\n",
-					ifname);
-				return 1;
-			}
-			break;
-		case 'N':
-			xdp_flags |= XDP_FLAGS_DRV_MODE;
-			break;
-		case 's':
-			/* use server program */
-			server = 1;
-			break;
-		case 'S':
-			xdp_flags |= XDP_FLAGS_SKB_MODE;
-			break;
-		default:
-			show_usage(basename(argv[0]));
-			return 1;
-		}
-	}
-
-	if (!ifname) {
-		show_usage(basename(argv[0]));
-		return 1;
-	}
-	if (!server && optind == argc) {
-		show_usage(basename(argv[0]));
-		return 1;
-	}
-
-	if ((xdp_flags & mode_flags) == mode_flags) {
-		fprintf(stderr, "-N or -S can be specified, not both.\n");
-		show_usage(basename(argv[0]));
-		return 1;
-	}
-
-	if (!server) {
-		/* Only supports IPv4; see hints initialization above. */
-		if (getaddrinfo(argv[optind], NULL, &hints, &a) || !a) {
-			fprintf(stderr, "Could not resolve %s\n", argv[optind]);
-			return 1;
-		}
-		memcpy(&rin, a->ai_addr, sizeof(rin));
-		raddr = rin.sin_addr.s_addr;
-		freeaddrinfo(a);
-	}
-
-	/* Use libbpf 1.0 API mode */
-	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
-
-	snprintf(filename, sizeof(filename), "%s_kern.bpf.o", argv[0]);
-
-	if (bpf_prog_test_load(filename, BPF_PROG_TYPE_XDP, &obj, &prog_fd)) {
-		fprintf(stderr, "load of %s failed\n", filename);
-		return 1;
-	}
-
-	main_prog = bpf_object__find_program_by_name(obj,
-						     server ? "xdping_server" : "xdping_client");
-	if (main_prog)
-		prog_fd = bpf_program__fd(main_prog);
-	if (!main_prog || prog_fd < 0) {
-		fprintf(stderr, "could not find xdping program");
-		return 1;
-	}
-
-	map = bpf_object__next_map(obj, NULL);
-	if (map)
-		map_fd = bpf_map__fd(map);
-	if (!map || map_fd < 0) {
-		fprintf(stderr, "Could not find ping map");
-		goto done;
-	}
-
-	signal(SIGINT, cleanup);
-	signal(SIGTERM, cleanup);
-
-	printf("Setting up XDP for %s, please wait...\n", ifname);
-
-	printf("XDP setup disrupts network connectivity, hit Ctrl+C to quit\n");
-
-	if (bpf_xdp_attach(ifindex, prog_fd, xdp_flags, NULL) < 0) {
-		fprintf(stderr, "Link set xdp fd failed for %s\n", ifname);
-		goto done;
-	}
-
-	if (server) {
-		close(prog_fd);
-		close(map_fd);
-		printf("Running server on %s; press Ctrl+C to exit...\n",
-		       ifname);
-		do { } while (1);
-	}
-
-	/* Start xdping-ing from last regular ping reply, e.g. for a count
-	 * of 10 ICMP requests, we start xdping-ing using reply with seq number
-	 * 10.  The reason the last "real" ping RTT is much higher is that
-	 * the ping program sees the ICMP reply associated with the last
-	 * XDP-generated packet, so ping doesn't get a reply until XDP is done.
-	 */
-	pinginfo.seq = htons(count);
-	pinginfo.count = count;
-
-	if (bpf_map_update_elem(map_fd, &raddr, &pinginfo, BPF_ANY)) {
-		fprintf(stderr, "could not communicate with BPF map: %s\n",
-			strerror(errno));
-		cleanup(0);
-		goto done;
-	}
-
-	/* We need to wait for XDP setup to complete. */
-	sleep(10);
-
-	snprintf(cmd, sizeof(cmd), "ping -c %d -I %s %s",
-		 count, ifname, argv[optind]);
-
-	printf("\nNormal ping RTT data\n");
-	printf("[Ignore final RTT; it is distorted by XDP using the reply]\n");
-
-	ret = system(cmd);
-
-	if (!ret)
-		ret = get_stats(map_fd, count, raddr);
-
-	cleanup(0);
-
-done:
-	if (prog_fd > 0)
-		close(prog_fd);
-	if (map_fd > 0)
-		close(map_fd);
-
-	return ret;
-}
diff --git a/tools/testing/selftests/bpf/xdping.h b/tools/testing/selftests/bpf/xdping.h
deleted file mode 100644
index afc578df77be..000000000000
--- a/tools/testing/selftests/bpf/xdping.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved. */
-
-#define	XDPING_MAX_COUNT	10
-#define	XDPING_DEFAULT_COUNT	4
-
-struct pinginfo {
-	__u64	start;
-	__be16	seq;
-	__u16	count;
-	__u32	pad;
-	__u64	times[XDPING_MAX_COUNT];
-};

-- 
2.53.0


