Return-Path: <netdev+bounces-299019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XoD4IMOiLWpaiAQAu9opvQ
	(envelope-from <netdev+bounces-299019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:34:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D1A67F50F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:34:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jrife-io.20251104.gappssmtp.com header.s=20251104 header.b=HdhOnMAm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299019-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299019-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B45F630065D3
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1CE27F4F5;
	Sat, 13 Jun 2026 18:34:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12D32F75B
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 18:34:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781375680; cv=none; b=R8gijhqxxs5gHtj7+taKcfeQ5IxjxktCRVDY2rwT2rIyHTG4g6xVx2QED27BXMbpVxoMhtgo8cXWX9xbVH7BpQsSOzMtpTOsInlBYC4/hsnMZDFNVTTCJiW14VJ3kNcUuoPDRTNF1++5s6W0D03I4aQgERYK6eZ79smS3I9Qu6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781375680; c=relaxed/simple;
	bh=GAKLF6aJLsrCYkl7Wo8RMDaiJFXvHtwXW6Fc3rVfCck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXXj275O/JscHpLUoB5DyjoKJvyLEFU1H+nQcx9Im2yxTa1GRCVyNUvT6wVNh9BQglbTxBoEH0fLk64BmkRb6twn0nyKlBxxAjEcVMBizC/IEjpC8JzG0BF8WGEnqhjqYg+BkEKP73v5nFy+BFNgrV6OYVU6wthX2Hnkf7GfUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=HdhOnMAm; arc=none smtp.client-ip=74.125.82.180
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304dd3bb7a6so221371eec.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1781375677; x=1781980477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVRa8MFqgEcIxTeX5DcRDdMMa2fq5Bm7zRkC5sjv8Ls=;
        b=HdhOnMAmMZ4UwlWs4b0beZGyoJ9232KwVD1bLiyLKl12vpVkvEfJU75vLSNMrelIZN
         kaFx568M4A/FamZWg44rTYUTyfliXL6olKmovUkUm7HaIRagz9I3NdRgyhijgjVg45Wg
         dQCSwxpFF+OuBJAE2KPKCsoiUcG7RYsZSQoLAK9xcuh7j1sIVbWBCmAt8GEndCU3wO0b
         yJwq1OyqTkKJP6qmZXr4cdQhZiOwSVxi563a6RHtW8QDsotXKbu4OamPv7RsIn61H18Z
         V/GNxWSdqprvSWo13LnWPhAOiZavQ/oHhq29sEIQDXhnYPgwqr3H81d+hWVDXp+/4uWb
         vWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781375677; x=1781980477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yVRa8MFqgEcIxTeX5DcRDdMMa2fq5Bm7zRkC5sjv8Ls=;
        b=MDipCDzET7JFqUGwY7dgJaUXiQiIj3xDkhgKjJT3mDyfx2qyIQEk97AnNY2njdMec0
         hBljn/H1dXTGzesWkDD8MxuX/XAj+IBm4Q5Mc6jtbXzKejeKBi74cbrLWmYp/uX4i3ZV
         GydIJ99eUZbdxvY9fR5TShzjqV39YsButfxjHIFmTdQO9qwu/k7eH+fpqE2mfqjtWqa4
         oars1nD80VG2r8a66t6ukHlORamAhFHAmXZ5JwTMTqHow0ZnbJSr9JYsMyIFqLS6jD33
         ZmFGlu8qk9WOIXZFQv7S7ZH5lat/IHjavX517nHD8hoG3puzwbjTHxRqU5gGEWsVkKrr
         7buA==
X-Forwarded-Encrypted: i=1; AFNElJ8hYfIrPAr4tfHDbc2D0cJFuasEBctEpUV+wt20RJYvdMn9eqD2cJwsSjb89OgPuzRBSq6pnzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7I4brJOcPwLdFyZ/jA0s8Ugim3cBYupvZ7vwxk3VxFfzCIgcF
	CXj6SyYKsf1EZ0ecCiG+rdhv2bykREE9SU1a3VvYi6m2sn11/CTonsraYI7UHyjObVg=
X-Gm-Gg: Acq92OFBVqkT1MWT4rUDGaPH3J76N9qSKcZdbpzbXQWZ+J34re9mO4yVNc8ZrnMxKGs
	K7BauxbPzeXZ++JiNtd1N4KqpslLsK8LqUs0rrsgx3dEjgmUvc7GfnqDRJ91qsQl9IPVlGhC6nq
	5HpoaZZaYR0pC9YU7SabqEs35sPz4bEi9sJcnburRvBOJOF35YneIieMwPJDfRh/vnF14nHVul/
	lh/FSEfb83HbuTY1txX1Pg4OMSZcoTiZpY5fUL39dywNcnWSXh/OcwI8cUhMF6u8Wy3U5a9HxzA
	gjoTu4YGUinC0JYh43pnFNloeyamtFFZdN7Qp3dEfSC/pfc2GaKHO91HGPx19lHwIgKCR0PNa6n
	saCXgTGABGi3lw5wG18D+S/weroYoactpTbgxFZpfX8V8cM+QRSCnOSMnhZnuUd3jPfO3J+v9Nn
	99jfVSTZ3Br34=
X-Received: by 2002:a05:7300:640e:b0:2e5:faa9:ca76 with SMTP id 5a478bee46e88-308200bc9fbmr1859223eec.7.1781375676545;
        Sat, 13 Jun 2026 11:34:36 -0700 (PDT)
Received: from t14.. ([2001:5a8:47ec:d700:7881:81f1:548c:e2d3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm9181543eec.4.2026.06.13.11.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 11:34:36 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v1 bpf-next 2/2] selftests/bpf: Add tests for bpf_redirect_peer with BPF_F_INGRESS
Date: Sat, 13 Jun 2026 11:34:06 -0700
Message-ID: <20260613183424.1198073-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613183424.1198073-1-jordan@jrife.io>
References: <20260613183424.1198073-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[jrife-io.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-299019-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:jordan@jrife.io,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[jrife.io];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[jrife-io.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jrife-io.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27D1A67F50F

Extend redirect tests to cover bpf_redirect_peer(BPF_F_INGRESS). SRC
redirects to DST using bpf_redirect_peer(BPF_F_INGRESS) then traffic is
hairpinned into DST using bpf_redirect(BPF_F_INGRESS).

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 68 +++++++++++++++++++
 .../selftests/bpf/progs/test_tc_peer.c        | 22 ++++++
 2 files changed, 90 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 64fbda082309..af8968b89ad7 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -192,6 +192,8 @@ static int create_netkit(int mode, char *prim, char *peer)
 	req.n.nlmsg_len += sizeof(struct ifinfomsg);
 	addattr_l(&req.n, sizeof(req), IFLA_IFNAME, peer, strlen(peer));
 	addattr_nest_end(&req.n, peer_info);
+	addattr32(&req.n, sizeof(req), IFLA_NETKIT_SCRUB,
+		  NETKIT_SCRUB_NONE);
 	addattr_nest_end(&req.n, data);
 	addattr_nest_end(&req.n, linkinfo);
 
@@ -405,6 +407,24 @@ static int netns_load_bpf(const struct bpf_program *src_prog,
 	return -1;
 }
 
+static struct bpf_link *netns_attach_nk(const char *ns, int ifindex,
+					struct bpf_program *prog)
+{
+	LIBBPF_OPTS(bpf_netkit_opts, optl);
+	struct nstoken *nstoken = NULL;
+	struct bpf_link *link = NULL;
+
+	nstoken = open_netns(ns);
+	if (!ASSERT_OK_PTR(nstoken, "setns"))
+		goto cleanup;
+
+	link = bpf_program__attach_netkit(prog, ifindex, &optl);
+cleanup:
+	if (nstoken)
+		close_netns(nstoken);
+	return link;
+}
+
 static void test_tcp(int family, const char *addr, __u16 port)
 {
 	int listen_fd = -1, accept_fd = -1, client_fd = -1;
@@ -1082,6 +1102,53 @@ static void test_tc_redirect_peer(struct netns_setup_result *setup_result)
 	close_netns(nstoken);
 }
 
+static void test_tc_redirect_peer_ing(struct netns_setup_result *setup_result)
+{
+	struct test_tc_peer *skel;
+	struct nstoken *nstoken;
+	int err;
+
+	nstoken = open_netns(NS_FWD);
+	if (!ASSERT_OK_PTR(nstoken, "setns fwd"))
+		return;
+
+	skel = test_tc_peer__open();
+	if (!ASSERT_OK_PTR(skel, "test_tc_peer__open"))
+		goto done;
+
+	skel->rodata->IFINDEX_SRC = setup_result->ifindex_src_fwd;
+	skel->rodata->IFINDEX_DST = setup_result->ifindex_dst_fwd;
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc_src_ing,
+		  BPF_NETKIT_PRIMARY), 0, "src_prog_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc_dst_ing,
+		  BPF_NETKIT_PRIMARY), 0, "dst_prog_attach_type");
+
+	err = test_tc_peer__load(skel);
+	if (!ASSERT_OK(err, "test_tc_peer__load"))
+		goto done;
+
+	skel->links.tc_src_ing = netns_attach_nk(NS_SRC,
+						 setup_result->ifindex_src,
+						 skel->progs.tc_src_ing);
+	if (!ASSERT_OK_PTR(skel->links.tc_src_ing, "attach_src"))
+		goto done;
+	skel->links.tc_dst_ing = netns_attach_nk(NS_DST,
+						 setup_result->ifindex_dst,
+						 skel->progs.tc_dst_ing);
+	if (!ASSERT_OK_PTR(skel->links.tc_dst_ing, "attach_dst"))
+		goto done;
+
+	if (!ASSERT_OK(set_forwarding(false), "disable forwarding"))
+		goto done;
+
+	test_connectivity();
+
+done:
+	if (skel)
+		test_tc_peer__destroy(skel);
+	close_netns(nstoken);
+}
+
 static int tun_open(char *name)
 {
 	struct ifreq ifr;
@@ -1280,6 +1347,7 @@ static void *test_tc_redirect_run_tests(void *arg)
 
 	RUN_TEST(tc_redirect_peer, MODE_VETH);
 	RUN_TEST(tc_redirect_peer, MODE_NETKIT);
+	RUN_TEST(tc_redirect_peer_ing, MODE_NETKIT);
 	RUN_TEST(tc_redirect_peer_l3, MODE_VETH);
 	RUN_TEST(tc_redirect_peer_l3, MODE_NETKIT);
 	RUN_TEST(tc_redirect_neigh, MODE_VETH);
diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
index 365eacb5dc34..1f2345f05fcd 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_peer.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_peer.c
@@ -34,6 +34,28 @@ int tc_src(struct __sk_buff *skb)
 	return bpf_redirect_peer(IFINDEX_DST, 0);
 }
 
+SEC("tc")
+int tc_dst_ing(struct __sk_buff *skb)
+{
+	if (!skb->mark) {
+		skb->mark = 0x1;
+		return bpf_redirect_peer(IFINDEX_SRC, BPF_F_INGRESS);
+	}
+
+	return bpf_redirect(IFINDEX_DST, 0);
+}
+
+SEC("tc")
+int tc_src_ing(struct __sk_buff *skb)
+{
+	if (!skb->mark) {
+		skb->mark = 0x1;
+		return bpf_redirect_peer(IFINDEX_DST, BPF_F_INGRESS);
+	}
+
+	return bpf_redirect(IFINDEX_SRC, 0);
+}
+
 SEC("tc")
 int tc_dst_l3(struct __sk_buff *skb)
 {
-- 
2.43.0


