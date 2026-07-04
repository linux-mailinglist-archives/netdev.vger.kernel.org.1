Return-Path: <netdev+bounces-304695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tPvTBFPRSGqVuAAAu9opvQ
	(envelope-from <netdev+bounces-304695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 11:24:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 828AA7073C9
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 11:24:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Vd9At8Hy;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304695-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304695-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CFDE303983C
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EB33A5E67;
	Sat,  4 Jul 2026 09:22:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212F23290DB
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 09:22:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783156962; cv=none; b=jhCpdH+LRLrhzECyoz+Jg03yogi/ZnBSRNnSmvYdTl49xf0o5gobX1Za8swt5J2w7zB3Z2ry3FTC3My4sJTehrScHrfUWJfohM9aficioObnETLsJSgY/nkne0UjgwIUhvkAUFj5YLWSH8yxn3pPOLL7r6YZ9kt+eHziG8MbGjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783156962; c=relaxed/simple;
	bh=iqXajN1Bc9owYywdBFAprLa5LexpZ7w11cSgTFdWgBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2Fc+2Fi7ZmTY6IA9ew8dp9DROUxHMsTxzhCWMVULeTR+TGxlXiLMO8g0z5N3MmQw0KT/U8M/syReUi8+r7utrSSmy3MxAT004FkXmM694RU19Pyv/mxugQW4WxZLx2o/NeoLjyL1slgBXa6CWhIC/s0vxSzBGYloSH1PAS2VC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd9At8Hy; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3811f512167so1157284a91.3
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783156958; x=1783761758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coBaQF4D2EXw4zHEjOPF19e8YbDm+r6EUkWF5Z/gX8U=;
        b=Vd9At8HyOKuDRDaoqBecmiwSIxxArnJd2Ll9X8G4TZtTxgaZ7aa3cqws69eaim0G8+
         qM4V2uX3Hehv87iNpBaWR1Fbxf2kaKbBpTNYQd8daKcovSucueVg13uIO7k71u6A8J0P
         owO+hIsfBj1B0TddZchuGB6zZ8mrNtWh/H17N2P1baBLSt+SWl1c5xs7CJ94+6Kzoi7l
         CnIsLxnzb5XcMrNAW3vQpwvQi9L8UXXIxYc1Sp2HGRLASjbSfQdRH5+c/WOI51ajh9DY
         z+L8SVQG/UliJKtEB3b4vu1ubiMrTQSaGzyNW7GiBTdusUEGLXJMka9UYtUp7YcuFMmF
         ZpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783156958; x=1783761758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=coBaQF4D2EXw4zHEjOPF19e8YbDm+r6EUkWF5Z/gX8U=;
        b=LbZCdz+wOxMkaI0X+AguILnvdNoD2mfi2Zd6QJWOLN97iCGg3QupWd8SYqMu1dDqEf
         I034nJ+2Jwahc+GMwd9IPJsOl20Rw5Vc5UlUlw+Y2CMRfG3zarPGL8pBdo5/zhSrgBGO
         9/C4UbgiQAlas/k4VL6B6Zn6A8FKemiGjxlzTqbbuvDvodwkDITniStlXu2VwRc67eMN
         ijNSydyYLt3sz8B05FWA6riSI/jW+XTdGKWMrNnI5zMBe7AhF/ck5UXSPyWoE8HukB4Q
         uRXPKkaibWUYHoJLrSHTJrjn9P0y26yOrb2iYmy1xy7B+qzX2y9OzQG6UrIJ2cfPSQjx
         rygA==
X-Forwarded-Encrypted: i=1; AHgh+RrWqkLg4+bV5/xGiR3smRaLJMgQNGXqUrJzWXqK3jQNMVNi6TdG+j7kHwjgbMwsMI4RzGyeVNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeqid/fIWBQ1eHr5f7SdEBozicsqIBQ3TKpflS5Skh5rw6rClC
	2jQTaWTWShKr24TweRIxgUu35nlcuCuemyM8bvmfBFSDHEtP4qRMo1Ja
X-Gm-Gg: AfdE7cn2zsx+MB3kYw0rOq9K1duv3XBBpRUd7u1o8jAe2IA5ja2ZBZEqF3/EcriiK4U
	plbvoWGfApUXGXPgvOWmzFJKtsRRnuEcCrQInKanceI8yyTJKufddlV+4gr8J/w9i3yM+GudFTi
	xEtxGUvIaxj1RWArLdC1AvolfJilopMm7w4BtTFtylKx13NFJgxqNQcIb8yv0Dx0B9iMKO7WdjX
	vFqSD4oAZdwsC9Cr7N/Fj+Q7Ve5QybK57fAi+5COnxVH6NXuxf+v1XN6u7Py0HIN7S4+r9tWgpZ
	ukjXedXuECY/fPmvlnEvK+swD9SFqxk6cQ74zPNOkGh1dpMrDUuAOAwVZA5QVtk7BoS/h9ANKCR
	jFJQiV6Fl9naxWOV1Nlu3yHzfwCfYz1McEm9V3VZnRJhqnsIuQP5k3R/WRG6xfbx7FoVd9rzLWR
	JQ0EcGfPobILQ7a0WRk3YWmSJm0bModr74s3GIkPiOFK1ftA+NC60ntIlfwCnI
X-Received: by 2002:a17:90a:ec86:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-38280d8e396mr2911935a91.9.1783156958102;
        Sat, 04 Jul 2026 02:22:38 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc27ae7sm28006464eec.26.2026.07.04.02.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 02:22:37 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	yatsenko@meta.com,
	leon.hwang@linux.dev,
	kpsingh@kernel.org,
	a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	rongtao@cestc.cn,
	eyal.birger@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	toke@redhat.com,
	dsahern@kernel.org
Subject: [PATCH bpf-next v6 3/3] selftests/bpf: Add bpf_fib_lookup() VLAN flag tests
Date: Sat,  4 Jul 2026 14:51:59 +0530
Message-ID: <20260704092159.1256823-4-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704092159.1256823-1-avinash.duduskar@gmail.com>
References: <20260704092159.1256823-1-avinash.duduskar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-304695-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:toke@redhat.com,m:dsahern@kernel.org,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 828AA7073C9

Cover both new VLAN flags in the fib_lookup test. BPF_FIB_LOOKUP_VLAN
reduces a VLAN egress to its physical parent plus the tag, and
BPF_FIB_LOOKUP_VLAN_INPUT scopes the lookup to a VLAN subinterface.

BPF_FIB_LOOKUP_VLAN is XDP-only, since VLAN devices have no XDP xmit; the
tc helper rejects it with -EINVAL, which the table runner asserts for
every flag arm, and the egress result is checked through
bpf_xdp_fib_lookup(). Non-VLAN cases run through both helpers and assert
the path-independent results match; the XDP loop also checks dmac and,
for the tot_len cases, the route mtu_result, so the VLAN-egress dmac and
frag-needed coverage stays even though the tc path no longer reaches it.

The egress arms pin the reduction (parent ifindex plus tag, including
via a neighbour on the VLAN device, in OUTPUT mode, over a bond, and
through a DIRECT|TBID table) and the failure contract: a stacked-VLAN
(QinQ) egress returns BPF_FIB_LKUP_RET_VLAN_FAILURE with params->ifindex
left at the input. That is distinct from a no-neighbour return, which
reports the egress ifindex; only VLAN_FAILURE rewinds params->ifindex,
and a guard arm whose input and egress devices differ pins the
distinction. The VLAN_FAILURE arms are IPv4; the IPv6 path reaches it
through the same shared code, so an IPv6 arm would only re-test that.

The input arms use an iif rule that routes one destination to two
gateways, so the asserted gateway reveals which device the lookup used
as ingress, including VRF table selection through the l3mdev rule and
l3mdev_fib_table_rcu(). A cross-netns subtest moves a VLAN device into a
second netns while it stays registered on its parent and checks both
directions fail closed at the boundary.

A live-frames subtest (test_fib_lookup_vlan_redirect, with
BPF_F_TEST_XDP_LIVE_FRAMES) drives real frames through the native
xdp_do_redirect() / xdp_do_flush() path: a reducible egress is
redirected to the parent and delivered to its peer, while a QinQ egress
is passed to the stack, since redirecting to the VLAN device would drop
the frame at flush (no ndo_xdp_xmit).

The remaining per-case assertions are in the test table: resolution
semantics, the -EINVAL and NOT_FWDED error arms, and the SRC/SKIP_NEIGH
combinations.

Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 .../selftests/bpf/prog_tests/fib_lookup.c     | 712 +++++++++++++++++-
 .../testing/selftests/bpf/progs/fib_lookup.c  |  36 +
 2 files changed, 744 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index bd7658958004..18b6fdeca382 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
 
 #include <linux/rtnetlink.h>
+#include <linux/if_ether.h>
 #include <sys/types.h>
 #include <net/if.h>
 
@@ -23,6 +24,7 @@
 #define IPV4_TBID_ADDR		"172.0.0.254"
 #define IPV4_TBID_NET		"172.0.0.0"
 #define IPV4_TBID_DST		"172.0.0.2"
+#define IPV4_TBID_NONEIGH_DST	"172.0.0.5"
 #define IPV6_TBID_ADDR		"fd00::FFFF"
 #define IPV6_TBID_NET		"fd00::"
 #define IPV6_TBID_DST		"fd00::2"
@@ -37,6 +39,41 @@
 #define IPV6_LOCAL		"fd01::3"
 #define IPV6_GW1		"fd01::1"
 #define IPV6_GW2		"fd01::2"
+#define VLAN_ID			100
+#define VLAN_IFACE		"veth1.100"
+#define VLAN_ID_DOWN		102
+#define VLAN_IFACE_DOWN		"veth1.102"
+#define QINQ_OUTER_IFACE	"veth1.200"
+#define QINQ_INNER_IFACE	"veth1.200.300"
+#define VLAN_TABLE		"300"
+#define IPV4_VLAN_IFACE_ADDR	"10.5.0.254"
+#define IPV4_VLAN_EGRESS_DST	"10.5.0.2"
+#define IPV4_QINQ_DST		"10.7.0.2"
+#define IPV4_VLAN_DST		"10.6.0.2"
+#define IPV4_VLAN_GW		"10.5.0.1"
+#define IPV6_VLAN_IFACE_ADDR	"fd02::254"
+#define IPV6_VLAN_EGRESS_DST	"fd02::2"
+#define IPV6_VLAN_DST		"fd03::2"
+#define IPV6_VLAN_GW		"fd02::1"
+#define VLAN_VID_UNUSED		999
+#define VRF_IFACE		"vrf-blue"
+#define VRF_TABLE		"1000"
+#define VRF_VLAN_ID		101
+#define VRF_VLAN_IFACE		"veth1.101"
+#define IPV4_VRF_IFACE_ADDR	"10.8.0.254"
+#define IPV4_VRF_GW		"10.8.0.1"
+#define IPV4_VRF_DST		"10.9.0.2"
+#define TBID_VLAN_ID		50
+#define TBID_VLAN_IFACE		"veth2.50"
+#define IPV4_TBID_VLAN_DST	"172.2.0.2"
+#define IPV4_BOND_VLAN_DST	"10.11.0.2"
+#define IPV4_VLAN_MTU_DST	"10.5.9.2"
+#define QINQ_AD_VLAN_ID		200
+#define QINQ_INNER_VLAN_ID	300
+#define BOND_IFACE		"bond99"
+#define BOND_PORT		"veth3"
+#define BOND_PORT_PEER		"veth4"
+#define BOND_VLAN_ID		500
 #define DMAC			"11:11:11:11:11:11"
 #define DMAC_INIT { 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, }
 #define DMAC2			"01:01:01:01:01:01"
@@ -52,6 +89,17 @@ struct fib_lookup_test {
 	__u32 tbid;
 	__u8 dmac[6];
 	__u32 mark;
+	/*
+	 * input tag with BPF_FIB_LOOKUP_VLAN_INPUT; expected output tag
+	 * with BPF_FIB_LOOKUP_VLAN (checked when check_vlan is set)
+	 */
+	__u16 vlan_proto;
+	__u16 vlan_id;
+	bool check_vlan;
+	const char *expected_dev; /* expected params->ifindex after lookup */
+	const char *iif;	  /* override the default veth1 input device */
+	__u16 tot_len;		  /* triggers the in-lookup mtu check when set */
+	__u16 expected_mtu;	  /* expected mtu_result (union with tot_len) */
 };
 
 static const struct fib_lookup_test tests[] = {
@@ -79,6 +127,17 @@ static const struct fib_lookup_test tests[] = {
 	  .daddr = IPV4_TBID_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
 	  .lookup_flags = BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID, .tbid = 100,
 	  .dmac = DMAC_INIT2, },
+	/*
+	 * An error that returns after the egress device is resolved must
+	 * report the egress ifindex, not the input. This routes from input
+	 * veth1 via veth2 (table 100) to a dst with no neighbour, so
+	 * input != egress, pinning NO_NEIGH to the egress device.
+	 */
+	{ .desc = "IPv4 NO_NEIGH reports the egress ifindex, not the input",
+	  .daddr = IPV4_TBID_NONEIGH_DST,
+	  .expected_ret = BPF_FIB_LKUP_RET_NO_NEIGH,
+	  .lookup_flags = BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID, .tbid = 100,
+	  .expected_dev = "veth2", },
 	{ .desc = "IPv6 TBID lookup failure",
 	  .daddr = IPV6_TBID_DST, .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
 	  .lookup_flags = BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID,
@@ -142,6 +201,218 @@ static const struct fib_lookup_test tests[] = {
 	  .expected_dst = IPV6_GW1,
 	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
 	  .mark = MARK, },
+	/* vlan egress resolution */
+	/*
+	 * Invariant the VLAN-egress arms jointly enforce: a
+	 * BPF_FIB_LOOKUP_VLAN SUCCESS always carries a physical,
+	 * xmit-capable ifindex; no SUCCESS ever returns a VLAN-device
+	 * ifindex. Reducible arms pin ifindex == the physical parent; the
+	 * QinQ and foreign-netns arms pin VLAN_FAILURE with params->ifindex
+	 * left at the input, so a regression to best-effort (SUCCESS + the
+	 * VLAN ifindex) fails one.
+	 */
+	{ .desc = "IPv4 VLAN egress, no flag",
+	  .daddr = IPV4_VLAN_EGRESS_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = VLAN_IFACE, .check_vlan = true, },
+	{ .desc = "IPv4 VLAN egress, single VLAN",
+	  .daddr = IPV4_VLAN_EGRESS_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	/*
+	 * skb path without tot_len: mtu_result is the VLAN device's mtu
+	 * (1400), not the parent's (1500)
+	 */
+	{ .desc = "IPv4 VLAN egress, skb-path mtu is the VLAN device's without the flag",
+	  .daddr = IPV4_VLAN_EGRESS_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = VLAN_IFACE, .check_vlan = true, .expected_mtu = 1400, },
+	{ .desc = "IPv4 VLAN egress, flag set but egress is not a VLAN",
+	  .daddr = IPV4_NUD_FAILED_ADDR, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = "veth1", .check_vlan = true, },
+	{ .desc = "IPv4 VLAN egress, QinQ not reducible (VLAN_FAILURE)",
+	  .daddr = IPV4_QINQ_DST,
+	  .expected_ret = BPF_FIB_LKUP_RET_VLAN_FAILURE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = "veth1", .check_vlan = true, },
+	{ .desc = "IPv4 QinQ egress without the flag (escape hatch)",
+	  .daddr = IPV4_QINQ_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = QINQ_INNER_IFACE, },
+	{ .desc = "IPv6 VLAN egress, single VLAN",
+	  .daddr = IPV6_VLAN_EGRESS_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN egress, neighbour on the VLAN device",
+	  .daddr = IPV4_VLAN_EGRESS_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, .dmac = DMAC_INIT, },
+	{ .desc = "IPv4 VLAN egress in OUTPUT mode",
+	  .daddr = IPV4_VLAN_EGRESS_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .iif = VLAN_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_VLAN |
+			  BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN egress over a bond",
+	  .daddr = IPV4_BOND_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = BOND_IFACE, .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = BOND_VLAN_ID, },
+	{ .desc = "IPv4 VLAN egress via TBID table",
+	  .daddr = IPV4_TBID_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID |
+			  BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .tbid = 100,
+	  .expected_dev = "veth2", .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = TBID_VLAN_ID, },
+	{ .desc = "IPv4 VLAN egress, success writes mtu_result with the swap",
+	  .daddr = IPV4_VLAN_MTU_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .tot_len = 500, .expected_mtu = 1000,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN egress, FRAG_NEEDED reports mtu, swap unwritten",
+	  .daddr = IPV4_VLAN_MTU_DST, .expected_ret = BPF_FIB_LKUP_RET_FRAG_NEEDED,
+	  .tot_len = 1400, .expected_mtu = 1000,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = "veth1", .check_vlan = true, },
+	/* vlan tag as lookup input */
+	{ .desc = "IPv4 VLAN input, no flag",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_GW1,
+	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv4 VLAN input, tag selects subinterface route",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_VLAN_GW, .expected_dev = VLAN_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv6 VLAN input, tag selects subinterface route",
+	  .daddr = IPV6_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV6_VLAN_GW, .expected_dev = VLAN_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN input and egress combined",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_VLAN_GW, .expected_dev = "veth1",
+	  .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_VLAN |
+			  BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN input, neighbour resolved on the route",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_VLAN_GW, .expected_dev = VLAN_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, .dmac = DMAC_INIT2, },
+	{ .desc = "IPv4 VLAN input, source address from the subinterface",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_src = IPV4_VLAN_IFACE_ADDR,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SRC |
+			  BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	/*
+	 * VRF: the resolved subinterface is enslaved, so the l3mdev rule
+	 * (full lookup) and l3mdev_fib_table_rcu() (DIRECT) must select
+	 * the VRF table from the resolved ingress
+	 */
+	{ .desc = "IPv4 VLAN input, VRF subinterface, no flag",
+	  .daddr = IPV4_VRF_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_GW1,
+	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv4 VLAN input, tag selects VRF table",
+	  .daddr = IPV4_VRF_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_VRF_GW, .expected_dev = VRF_VLAN_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VRF_VLAN_ID, },
+	{ .desc = "IPv4 VLAN input, DIRECT uses VRF table from resolved ingress",
+	  .daddr = IPV4_VRF_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_VRF_GW, .expected_dev = VRF_VLAN_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_DIRECT |
+			  BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VRF_VLAN_ID, },
+	/*
+	 * failure arms also assert params is left untouched: ifindex still
+	 * names the physical device and the input tag bytes survive
+	 */
+	{ .desc = "IPv4 VLAN input, invalid proto",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = -EINVAL,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = 0x1234, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN input, unmatched VID",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_VID_UNUSED, },
+	{ .desc = "IPv4 VLAN input, subinterface down",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID_DOWN, },
+	/*
+	 * the resolver runs before the forwarding check, so on devices
+	 * with forwarding off FWD_DISABLED (not NOT_FWDED) proves the tag
+	 * resolved to that device and the lookup used it as ingress
+	 */
+	{ .desc = "IPv4 VLAN input, 802.1ad tag",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_FWD_DISABLED,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021AD, .vlan_id = QINQ_AD_VLAN_ID, },
+	{ .desc = "IPv4 VLAN input, PCP and DEI bits ignored in TCI",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_VLAN_GW,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = 0xe000 | VLAN_ID, },
+	{ .desc = "IPv4 VLAN input, inner QinQ device from VLAN ifindex",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_FWD_DISABLED,
+	  .iif = QINQ_OUTER_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = QINQ_INNER_VLAN_ID, },
+	/*
+	 * bonding: the VLANs live on the master, as on receive, where the
+	 * frame is steered to the master before VLAN processing; a port
+	 * ifindex does not match (ports carry vid state but no VLAN devs)
+	 */
+	{ .desc = "IPv4 VLAN input, tag on bond master resolves",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_FWD_DISABLED,
+	  .iif = BOND_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = BOND_VLAN_ID, },
+	{ .desc = "IPv4 VLAN input, tag on bond port does not match",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
+	  .iif = BOND_PORT, .expected_dev = BOND_PORT, .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = BOND_VLAN_ID, },
+	{ .desc = "IPv6 VLAN input, invalid proto",
+	  .daddr = IPV6_VLAN_DST, .expected_ret = -EINVAL,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = 0x1234, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN input, VID 0 priority tag fails closed",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = 0, },
+	{ .desc = "IPv6 VLAN input, unmatched VID",
+	  .daddr = IPV6_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_VID_UNUSED, },
+	{ .desc = "unknown flag bit rejected",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = -EINVAL,
+	  .lookup_flags = (1 << 14) | BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv4 VLAN input rejected with TBID",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = -EINVAL,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_TBID,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN input rejected with OUTPUT",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = -EINVAL,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_OUTPUT,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
 };
 
 static int setup_netns(void)
@@ -204,6 +475,105 @@ static int setup_netns(void)
 	SYS(fail, "ip rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
 	SYS(fail, "ip -6 rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
 
+	/*
+	 * Setup for vlan tests: a subinterface for egress resolution and
+	 * tag-as-input, a QinQ stack, and an iif rule so the input tests
+	 * observe which device the lookup used as ingress.
+	 */
+	SYS(fail, "ip link add link veth1 name %s type vlan id %d",
+	    VLAN_IFACE, VLAN_ID);
+	SYS(fail, "ip link set dev %s up", VLAN_IFACE);
+	/*
+	 * lower than the veth1 parent (1500): the skb-path mtu check uses the
+	 * FIB result (VLAN) device, so mtu_result is this value with or
+	 * without the egress swap, which two arms below pin
+	 */
+	SYS(fail, "ip link set dev %s mtu 1400", VLAN_IFACE);
+	SYS(fail, "ip addr add %s/24 dev %s", IPV4_VLAN_IFACE_ADDR, VLAN_IFACE);
+	SYS(fail, "ip addr add %s/64 dev %s nodad", IPV6_VLAN_IFACE_ADDR, VLAN_IFACE);
+
+	/*
+	 * stays down: the input flag must treat its tag the way real
+	 * ingress treats a frame arriving on a down VLAN device (drop)
+	 */
+	SYS(fail, "ip link add link veth1 name %s type vlan id %d",
+	    VLAN_IFACE_DOWN, VLAN_ID_DOWN);
+
+	err = write_sysctl("/proc/sys/net/ipv4/conf/" VLAN_IFACE "/forwarding", "1");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.conf." VLAN_IFACE ".forwarding)"))
+		goto fail;
+
+	err = write_sysctl("/proc/sys/net/ipv6/conf/" VLAN_IFACE "/forwarding", "1");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf." VLAN_IFACE ".forwarding)"))
+		goto fail;
+
+	SYS(fail, "ip link add link veth1 name %s type vlan proto 802.1ad id 200",
+	    QINQ_OUTER_IFACE);
+	SYS(fail, "ip link add link %s name %s type vlan id 300",
+	    QINQ_OUTER_IFACE, QINQ_INNER_IFACE);
+	SYS(fail, "ip link set dev %s up", QINQ_OUTER_IFACE);
+	SYS(fail, "ip link set dev %s up", QINQ_INNER_IFACE);
+	SYS(fail, "ip route add %s/32 dev %s", IPV4_QINQ_DST, QINQ_INNER_IFACE);
+
+	SYS(fail, "ip route add %s/32 via %s", IPV4_VLAN_DST, IPV4_GW1);
+	SYS(fail, "ip route add table %s %s/32 via %s",
+	    VLAN_TABLE, IPV4_VLAN_DST, IPV4_VLAN_GW);
+	SYS(fail, "ip rule add prio 3 iif %s lookup %s", VLAN_IFACE, VLAN_TABLE);
+	SYS(fail, "ip -6 route add %s/128 via %s", IPV6_VLAN_DST, IPV6_GW1);
+	SYS(fail, "ip -6 route add table %s %s/128 via %s",
+	    VLAN_TABLE, IPV6_VLAN_DST, IPV6_VLAN_GW);
+	SYS(fail, "ip -6 rule add prio 3 iif %s lookup %s", VLAN_IFACE, VLAN_TABLE);
+
+	/* a bond with one port and a VLAN on the bond */
+	SYS(fail, "ip link add %s type bond", BOND_IFACE);
+	SYS(fail, "ip link add %s type veth peer name %s", BOND_PORT, BOND_PORT_PEER);
+	SYS(fail, "ip link set %s master %s", BOND_PORT, BOND_IFACE);
+	SYS(fail, "ip link set dev %s up", BOND_IFACE);
+	SYS(fail, "ip link set dev %s up", BOND_PORT);
+	SYS(fail, "ip link add link %s name %s.%d type vlan id %d",
+	    BOND_IFACE, BOND_IFACE, BOND_VLAN_ID, BOND_VLAN_ID);
+	SYS(fail, "ip link set dev %s.%d up", BOND_IFACE, BOND_VLAN_ID);
+	SYS(fail, "ip route add %s/32 dev %s.%d",
+	    IPV4_BOND_VLAN_DST, BOND_IFACE, BOND_VLAN_ID);
+
+	/*
+	 * a VRF with its own dedicated subinterface (the iif rules above
+	 * must not see it), for the table-selection-by-ingress cases
+	 */
+	SYS(fail, "ip link add %s type vrf table %s", VRF_IFACE, VRF_TABLE);
+	SYS(fail, "ip link set dev %s up", VRF_IFACE);
+	SYS(fail, "ip link add link veth1 name %s type vlan id %d",
+	    VRF_VLAN_IFACE, VRF_VLAN_ID);
+	SYS(fail, "ip link set %s master %s", VRF_VLAN_IFACE, VRF_IFACE);
+	SYS(fail, "ip link set dev %s up", VRF_VLAN_IFACE);
+	SYS(fail, "ip addr add %s/24 dev %s", IPV4_VRF_IFACE_ADDR, VRF_VLAN_IFACE);
+	err = write_sysctl("/proc/sys/net/ipv4/conf/" VRF_VLAN_IFACE "/forwarding", "1");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.conf." VRF_VLAN_IFACE ".forwarding)"))
+		goto fail;
+	SYS(fail, "ip route add %s/32 via %s", IPV4_VRF_DST, IPV4_GW1);
+	SYS(fail, "ip route add table %s %s/32 via %s",
+	    VRF_TABLE, IPV4_VRF_DST, IPV4_VRF_GW);
+
+	/* neighbours on the VLAN subinterface for the non-SKIP_NEIGH cases */
+	err = write_sysctl("/proc/sys/net/ipv4/neigh/" VLAN_IFACE "/gc_stale_time", "900");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.neigh." VLAN_IFACE ".gc_stale_time)"))
+		goto fail;
+	SYS(fail, "ip neigh add %s dev %s lladdr %s nud stale",
+	    IPV4_VLAN_EGRESS_DST, VLAN_IFACE, DMAC);
+	SYS(fail, "ip neigh add %s dev %s lladdr %s nud stale",
+	    IPV4_VLAN_GW, VLAN_IFACE, DMAC2);
+
+	/* a VLAN on veth2 with a route in the tbid test table */
+	SYS(fail, "ip link add link veth2 name %s type vlan id %d",
+	    TBID_VLAN_IFACE, TBID_VLAN_ID);
+	SYS(fail, "ip link set dev %s up", TBID_VLAN_IFACE);
+	SYS(fail, "ip route add table 100 %s/32 dev %s",
+	    IPV4_TBID_VLAN_DST, TBID_VLAN_IFACE);
+
+	/* a locked-mtu route via the subinterface for the FRAG_NEEDED case */
+	SYS(fail, "ip route add %s/32 dev %s mtu lock 1000",
+	    IPV4_VLAN_MTU_DST, VLAN_IFACE);
+
 	return 0;
 fail:
 	return -1;
@@ -218,9 +588,16 @@ static int set_lookup_params(struct bpf_fib_lookup *params,
 	memset(params, 0, sizeof(*params));
 
 	params->l4_protocol = IPPROTO_TCP;
-	params->ifindex = ifindex;
+	params->ifindex = test->iif ? if_nametoindex(test->iif) : ifindex;
 	params->tbid = test->tbid;
 	params->mark = test->mark;
+	params->tot_len = test->tot_len;
+
+	/* h_vlan_proto/h_vlan_TCI union with tbid */
+	if (test->lookup_flags & BPF_FIB_LOOKUP_VLAN_INPUT) {
+		params->h_vlan_proto = htons(test->vlan_proto);
+		params->h_vlan_TCI = htons(test->vlan_id);
+	}
 
 	if (inet_pton(AF_INET6, test->daddr, params->ipv6_dst) == 1) {
 		params->family = AF_INET6;
@@ -298,7 +675,7 @@ void test_fib_lookup(void)
 	struct nstoken *nstoken = NULL;
 	struct __sk_buff skb = { };
 	struct fib_lookup *skel;
-	int prog_fd, err, ret, i;
+	int prog_fd, xdp_fd, err, ret, i;
 
 	/* The test does not use the skb->data, so
 	 * use pkt_v6 for both v6 and v4 test.
@@ -309,11 +686,16 @@ void test_fib_lookup(void)
 		    .ctx_in = &skb,
 		    .ctx_size_in = sizeof(skb),
 	);
+	LIBBPF_OPTS(bpf_test_run_opts, xdp_opts,
+		    .data_in = &pkt_v6,
+		    .data_size_in = sizeof(pkt_v6),
+	);
 
 	skel = fib_lookup__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
 		return;
 	prog_fd = bpf_program__fd(skel->progs.fib_lookup);
+	xdp_fd = bpf_program__fd(skel->progs.fib_lookup_xdp);
 
 	SYS(fail, "ip netns add %s", NS_TEST);
 
@@ -343,6 +725,16 @@ void test_fib_lookup(void)
 		if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
 			continue;
 
+		/*
+		 * BPF_FIB_LOOKUP_VLAN is XDP-only; the tc helper rejects it.
+		 * These cases are exercised on the XDP path below.
+		 */
+		if (tests[i].lookup_flags & BPF_FIB_LOOKUP_VLAN) {
+			ASSERT_EQ(skel->bss->fib_lookup_ret, -EINVAL,
+				  "tc rejects BPF_FIB_LOOKUP_VLAN");
+			continue;
+		}
+
 		ASSERT_EQ(skel->bss->fib_lookup_ret, tests[i].expected_ret,
 			  "fib_lookup_ret");
 
@@ -352,6 +744,21 @@ void test_fib_lookup(void)
 		if (tests[i].expected_dst)
 			assert_dst_ip(fib_params, tests[i].expected_dst);
 
+		if (tests[i].expected_dev)
+			ASSERT_EQ(fib_params->ifindex,
+				  if_nametoindex(tests[i].expected_dev), "ifindex");
+
+		if (tests[i].expected_mtu)
+			ASSERT_EQ(fib_params->mtu_result, tests[i].expected_mtu,
+				  "mtu_result");
+
+		if (tests[i].check_vlan) {
+			ASSERT_EQ(fib_params->h_vlan_proto,
+				  htons(tests[i].vlan_proto), "h_vlan_proto");
+			ASSERT_EQ(fib_params->h_vlan_TCI,
+				  htons(tests[i].vlan_id), "h_vlan_TCI");
+		}
+
 		ret = memcmp(tests[i].dmac, fib_params->dmac, sizeof(tests[i].dmac));
 		if (!ASSERT_EQ(ret, 0, "dmac not match")) {
 			char expected[18], actual[18];
@@ -361,15 +768,312 @@ void test_fib_lookup(void)
 			printf("dmac expected %s actual %s ", expected, actual);
 		}
 
-		// ensure tbid is zero'd out after fib lookup.
-		if (tests[i].lookup_flags & BPF_FIB_LOOKUP_DIRECT) {
+		/*
+		 * ensure tbid is zero'd out after fib lookup. With
+		 * BPF_FIB_LOOKUP_VLAN the union holds the packed vlan
+		 * fields instead, so skip the check for those.
+		 */
+		if ((tests[i].lookup_flags & BPF_FIB_LOOKUP_DIRECT) &&
+		    !(tests[i].lookup_flags & BPF_FIB_LOOKUP_VLAN)) {
 			if (!ASSERT_EQ(skel->bss->fib_params.tbid, 0,
 					"expected fib_params.tbid to be zero"))
 				goto fail;
 		}
 	}
 
+	/*
+	 * Re-run the cases through bpf_xdp_fib_lookup(). test_run uses the
+	 * current netns' loopback for ctx->rxq->dev, so dev_net() is NS_TEST
+	 * and the lookup runs against its FIB. The path-independent results
+	 * (return code, swapped ifindex, vlan tag, gateway) must match the skb
+	 * path; the no-tot_len mtu_result is skb-specific and not rechecked.
+	 */
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (set_lookup_params(fib_params, &tests[i], skb.ifindex))
+			continue;
+
+		skel->bss->fib_lookup_ret = -1;
+		skel->bss->lookup_flags = tests[i].lookup_flags;
+
+		err = bpf_prog_test_run_opts(xdp_fd, &xdp_opts);
+		if (!ASSERT_OK(err, "xdp test_run"))
+			continue;
+
+		if (!ASSERT_EQ(skel->bss->fib_lookup_ret, tests[i].expected_ret,
+			       "xdp fib_lookup_ret"))
+			printf("(xdp) %s\n", tests[i].desc);
+
+		if (tests[i].expected_dev)
+			ASSERT_EQ(fib_params->ifindex,
+				  if_nametoindex(tests[i].expected_dev),
+				  "xdp ifindex");
+
+		if (tests[i].expected_dst)
+			assert_dst_ip(fib_params, tests[i].expected_dst);
+
+		if (tests[i].check_vlan) {
+			ASSERT_EQ(fib_params->h_vlan_proto,
+				  htons(tests[i].vlan_proto), "xdp h_vlan_proto");
+			ASSERT_EQ(fib_params->h_vlan_TCI,
+				  htons(tests[i].vlan_id), "xdp h_vlan_TCI");
+		}
+
+		ret = memcmp(tests[i].dmac, fib_params->dmac, sizeof(tests[i].dmac));
+		ASSERT_EQ(ret, 0, "xdp dmac");
+
+		/*
+		 * mtu_result from a tot_len lookup is the route mtu and is
+		 * path-independent; the no-tot_len arm reads dev->mtu and is
+		 * skb-only, so gate on tot_len
+		 */
+		if (tests[i].expected_mtu && tests[i].tot_len)
+			ASSERT_EQ(fib_params->mtu_result, tests[i].expected_mtu,
+				  "xdp mtu_result");
+	}
+
+fail:
+	if (nstoken)
+		close_netns(nstoken);
+	SYS_NOFAIL("ip netns del " NS_TEST);
+	fib_lookup__destroy(skel);
+}
+
+#define NS_VLAN_A	"fib_lookup_vlan_ns_a"
+#define NS_VLAN_B	"fib_lookup_vlan_ns_b"
+
+/*
+ * A VLAN device can be moved to another netns while staying registered
+ * on its parent. Neither direction may then cross the boundary: the
+ * egress flag must not publish the foreign parent's ifindex, and the
+ * input flag must fail closed rather than use a foreign ingress.
+ */
+void test_fib_lookup_vlan_netns(void)
+{
+	struct bpf_fib_lookup *fib_params;
+	struct nstoken *nstoken = NULL;
+	struct __sk_buff skb = { };
+	struct fib_lookup *skel = NULL;
+	int prog_fd, xdp_fd, err, parent_idx, vlan_idx;
+
+	LIBBPF_OPTS(bpf_test_run_opts, run_opts,
+		    .data_in = &pkt_v6,
+		    .data_size_in = sizeof(pkt_v6),
+		    .ctx_in = &skb,
+		    .ctx_size_in = sizeof(skb),
+	);
+	LIBBPF_OPTS(bpf_test_run_opts, xdp_opts,
+		    .data_in = &pkt_v6,
+		    .data_size_in = sizeof(pkt_v6),
+	);
+
+	skel = fib_lookup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		return;
+	prog_fd = bpf_program__fd(skel->progs.fib_lookup);
+	xdp_fd = bpf_program__fd(skel->progs.fib_lookup_xdp);
+	fib_params = &skel->bss->fib_params;
+
+	SYS(fail, "ip netns add %s", NS_VLAN_A);
+	SYS(fail, "ip netns add %s", NS_VLAN_B);
+
+	nstoken = open_netns(NS_VLAN_A);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns(a)"))
+		goto fail;
+
+	SYS(fail, "ip link add veth7 type veth peer name veth8");
+	SYS(fail, "ip link set dev veth7 up");
+	SYS(fail, "ip link add link veth7 name veth7.66 type vlan id 66");
+	SYS(fail, "ip link set veth7.66 netns %s", NS_VLAN_B);
+
+	parent_idx = if_nametoindex("veth7");
+	if (!ASSERT_NEQ(parent_idx, 0, "if_nametoindex(veth7)"))
+		goto fail;
+
+	/*
+	 * input: the moved device is still in veth7's VLAN group, but it
+	 * lives in another netns, so the lookup must fail closed
+	 */
+	skb.ifindex = parent_idx;
+	memset(fib_params, 0, sizeof(*fib_params));
+	fib_params->family = AF_INET;
+	fib_params->l4_protocol = IPPROTO_TCP;
+	fib_params->ifindex = parent_idx;
+	fib_params->h_vlan_proto = htons(ETH_P_8021Q);
+	fib_params->h_vlan_TCI = htons(66);
+	if (!ASSERT_EQ(inet_pton(AF_INET, "10.66.0.2", &fib_params->ipv4_dst),
+		       1, "inet_pton(dst)"))
+		goto fail;
+
+	skel->bss->fib_lookup_ret = -1;
+	skel->bss->lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT |
+				  BPF_FIB_LOOKUP_SKIP_NEIGH;
+	err = bpf_prog_test_run_opts(prog_fd, &run_opts);
+	if (!ASSERT_OK(err, "test_run(input)"))
+		goto fail;
+	ASSERT_EQ(skel->bss->fib_lookup_ret, BPF_FIB_LKUP_RET_NOT_FWDED,
+		  "input across netns fails closed");
+	ASSERT_EQ(fib_params->ifindex, parent_idx, "ifindex untouched");
+	ASSERT_EQ(fib_params->h_vlan_TCI, htons(66), "tag untouched");
+
+	close_netns(nstoken);
+	nstoken = open_netns(NS_VLAN_B);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns(b)"))
+		goto fail;
+
+	/*
+	 * egress: the fib result is the VLAN device here, but its parent
+	 * is in the other netns, so the swap must not happen
+	 */
+	SYS(fail, "ip link set dev veth7.66 up");
+	SYS(fail, "ip addr add 10.66.0.1/24 dev veth7.66");
+	err = write_sysctl("/proc/sys/net/ipv4/conf/veth7.66/forwarding", "1");
+	if (!ASSERT_OK(err, "write_sysctl(forwarding)"))
+		goto fail;
+
+	vlan_idx = if_nametoindex("veth7.66");
+	if (!ASSERT_NEQ(vlan_idx, 0, "if_nametoindex(veth7.66)"))
+		goto fail;
+
+	memset(fib_params, 0, sizeof(*fib_params));
+	fib_params->family = AF_INET;
+	fib_params->l4_protocol = IPPROTO_TCP;
+	fib_params->ifindex = vlan_idx;
+	if (!ASSERT_EQ(inet_pton(AF_INET, "10.66.0.2", &fib_params->ipv4_dst),
+		       1, "inet_pton(dst)") ||
+	    !ASSERT_EQ(inet_pton(AF_INET, "10.66.0.1", &fib_params->ipv4_src),
+		       1, "inet_pton(src)"))
+		goto fail;
+
+	skel->bss->fib_lookup_ret = -1;
+	skel->bss->lookup_flags = BPF_FIB_LOOKUP_VLAN |
+				  BPF_FIB_LOOKUP_SKIP_NEIGH;
+	err = bpf_prog_test_run_opts(xdp_fd, &xdp_opts);
+	if (!ASSERT_OK(err, "test_run(egress)"))
+		goto fail;
+	ASSERT_EQ(skel->bss->fib_lookup_ret, BPF_FIB_LKUP_RET_VLAN_FAILURE,
+		  "egress returns VLAN_FAILURE");
+	ASSERT_EQ(fib_params->ifindex, vlan_idx,
+		  "foreign parent not published");
+	ASSERT_EQ(fib_params->h_vlan_TCI, 0, "vlan fields zero");
+
+fail:
+	if (nstoken)
+		close_netns(nstoken);
+	SYS_NOFAIL("ip netns del " NS_VLAN_A);
+	SYS_NOFAIL("ip netns del " NS_VLAN_B);
+	fib_lookup__destroy(skel);
+}
+
+#define REDIRECT_NPKTS 1000
+
+/*
+ * The egress flag exists so an XDP program can redirect to the physical
+ * parent. A redirect that lands on a VLAN device is dropped at
+ * xdp_do_flush(), because a VLAN device has no ndo_xdp_xmit. Drive real
+ * frames with BPF_F_TEST_XDP_LIVE_FRAMES, which runs the native
+ * xdp_do_redirect() + xdp_do_flush() path: a reducible VLAN egress
+ * resolves to veth1 and is delivered to its peer veth2, while a QinQ
+ * egress returns VLAN_FAILURE and is passed to the stack instead of
+ * redirected to a device that would silently drop it.
+ */
+void test_fib_lookup_vlan_redirect(void)
+{
+	int redirect_fd, err, veth1_idx, veth2_idx = -1;
+	struct bpf_fib_lookup *fib_params;
+	struct nstoken *nstoken = NULL;
+	struct fib_lookup *skel = NULL;
+	bool xdp_attached = false;
+
+	LIBBPF_OPTS(bpf_test_run_opts, lf_opts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4),
+		    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
+		    .repeat = REDIRECT_NPKTS,
+	);
+
+	skel = fib_lookup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		return;
+	redirect_fd = bpf_program__fd(skel->progs.fib_lookup_redirect);
+	fib_params = &skel->bss->fib_params;
+
+	SYS(fail, "ip netns add %s", NS_TEST);
+	nstoken = open_netns(NS_TEST);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto fail;
+	if (setup_netns())
+		goto fail;
+
+	veth1_idx = if_nametoindex("veth1");
+	veth2_idx = if_nametoindex("veth2");
+	if (!ASSERT_NEQ(veth1_idx, 0, "if_nametoindex(veth1)") ||
+	    !ASSERT_NEQ(veth2_idx, 0, "if_nametoindex(veth2)"))
+		goto fail;
+
+	/*
+	 * A redirect to veth1 is delivered to its peer veth2. veth_xdp_xmit()
+	 * only accepts the frame if veth2's NAPI is up, which on veth means
+	 * veth2 carries an XDP program; xdp_count tallies what arrives.
+	 */
+	err = bpf_xdp_attach(veth2_idx, bpf_program__fd(skel->progs.xdp_count),
+			     XDP_FLAGS_DRV_MODE, NULL);
+	if (!ASSERT_OK(err, "attach xdp_count on veth2"))
+		goto fail;
+	xdp_attached = true;
+
+	/* reducible VLAN egress: resolves to the physical parent veth1 */
+	memset(fib_params, 0, sizeof(*fib_params));
+	fib_params->family = AF_INET;
+	fib_params->l4_protocol = IPPROTO_TCP;
+	fib_params->ifindex = veth1_idx;
+	if (!ASSERT_EQ(inet_pton(AF_INET, IPV4_IFACE_ADDR, &fib_params->ipv4_src),
+		       1, "inet_pton(src)") ||
+	    !ASSERT_EQ(inet_pton(AF_INET, IPV4_VLAN_EGRESS_DST, &fib_params->ipv4_dst),
+		       1, "inet_pton(reducible dst)"))
+		goto fail;
+	skel->bss->lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH;
+	skel->bss->redirected = 0;
+	skel->bss->passed = 0;
+	skel->bss->delivered = 0;
+
+	err = bpf_prog_test_run_opts(redirect_fd, &lf_opts);
+	if (!ASSERT_OK(err, "test_run(reducible egress)"))
+		goto fail;
+	ASSERT_EQ(skel->bss->redirected, REDIRECT_NPKTS, "reducible egress redirected");
+	ASSERT_EQ(skel->bss->passed, 0, "reducible egress not passed");
+	ASSERT_GT(skel->bss->delivered, 0, "reducible egress delivered to veth2");
+
+	/*
+	 * QinQ egress: not reducible, so the lookup returns VLAN_FAILURE and
+	 * the program passes the frame instead of redirecting to the inner
+	 * VLAN device. redirected == 0 is the assertion that matters: the
+	 * program did not redirect to a device that would drop the frame at
+	 * xdp_do_flush(). veth2's delivered count is not checked here, since
+	 * a passed frame can still reach veth2 through the stack's forwarding
+	 * path, which is unrelated to the redirect under test.
+	 */
+	memset(fib_params, 0, sizeof(*fib_params));
+	fib_params->family = AF_INET;
+	fib_params->l4_protocol = IPPROTO_TCP;
+	fib_params->ifindex = veth1_idx;
+	if (!ASSERT_EQ(inet_pton(AF_INET, IPV4_IFACE_ADDR, &fib_params->ipv4_src),
+		       1, "inet_pton(src)") ||
+	    !ASSERT_EQ(inet_pton(AF_INET, IPV4_QINQ_DST, &fib_params->ipv4_dst),
+		       1, "inet_pton(qinq dst)"))
+		goto fail;
+	skel->bss->lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH;
+	skel->bss->redirected = 0;
+	skel->bss->passed = 0;
+
+	err = bpf_prog_test_run_opts(redirect_fd, &lf_opts);
+	if (!ASSERT_OK(err, "test_run(qinq egress)"))
+		goto fail;
+	ASSERT_EQ(skel->bss->passed, REDIRECT_NPKTS, "qinq egress passed");
+	ASSERT_EQ(skel->bss->redirected, 0, "qinq egress not redirected");
+
 fail:
+	if (xdp_attached)
+		bpf_xdp_detach(veth2_idx, XDP_FLAGS_DRV_MODE, NULL);
 	if (nstoken)
 		close_netns(nstoken);
 	SYS_NOFAIL("ip netns del " NS_TEST);
diff --git a/tools/testing/selftests/bpf/progs/fib_lookup.c b/tools/testing/selftests/bpf/progs/fib_lookup.c
index 7b5dd2214ff4..862a1e9457b4 100644
--- a/tools/testing/selftests/bpf/progs/fib_lookup.c
+++ b/tools/testing/selftests/bpf/progs/fib_lookup.c
@@ -19,4 +19,40 @@ int fib_lookup(struct __sk_buff *skb)
 	return TC_ACT_SHOT;
 }
 
+SEC("xdp")
+int fib_lookup_xdp(struct xdp_md *ctx)
+{
+	fib_lookup_ret = bpf_fib_lookup(ctx, &fib_params, sizeof(fib_params),
+					lookup_flags);
+
+	return XDP_DROP;
+}
+
+int redirected = 0;
+int passed = 0;
+int delivered = 0;
+
+SEC("xdp")
+int fib_lookup_redirect(struct xdp_md *ctx)
+{
+	struct bpf_fib_lookup params = fib_params;
+	long ret;
+
+	ret = bpf_fib_lookup(ctx, &params, sizeof(params), lookup_flags);
+	if (ret == BPF_FIB_LKUP_RET_SUCCESS) {
+		redirected++;
+		return bpf_redirect(params.ifindex, 0);
+	}
+
+	passed++;
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int xdp_count(struct xdp_md *ctx)
+{
+	delivered++;
+	return XDP_DROP;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0


