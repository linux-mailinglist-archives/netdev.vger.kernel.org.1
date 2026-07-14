Return-Path: <netdev+bounces-307549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7VQTEZx3Vmoa6QAAu9opvQ
	(envelope-from <netdev+bounces-307549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:53:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D013F757A17
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:53:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=Xw9cpyQN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307549-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307549-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F6B731C2F27
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB76948033F;
	Tue, 14 Jul 2026 17:49:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5D348C68
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 17:48:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051337; cv=none; b=UAn9L4hxkF1jmMuLyjiLcrEckyPyg4PF6/I++8lIC9MzyGTLQTTkkloWRDxmFxD1uHUGPR39uWpoB7OWDtY0ltyg06mSlrM1ECjh0hiO//u3F3BI8UwVG+OTAX2ugN+KmsQT+M4LBzy6tzz3S2ymjT2eCbJf1yzUSQQm1IRUd0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051337; c=relaxed/simple;
	bh=LI0LKFKKEejZLZJRTHj7QDsR1x57PXJtp08abBjtGVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khXraetQRrBAUpwDxwHQ6hVs6Za8KevAwNCnUsg7O0CQ3TxZCK1G1F2qH3G2DAfIkIP8Pk6gGgg5DtJpg0TtfJ/HtLWqTBGlwhSd8bnQAm5wCIkJWkSqKyOCPZ4YAgxL8NXT+nHbw6QcE9ao17Dtyvlzt8VROQBD/RDQDuDk5c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Xw9cpyQN; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4720f3bf164so627016f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784051315; x=1784656115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vGSFs74aEtBd1sRRPWl9XB8Pr6s6QabN5aaAQJoaLzM=;
        b=Xw9cpyQNk1LSSXJ5Rzi1VqlkdNYX8DGtTlMdxyE11lnh1zIJbnZgUMIGA72fl47dht
         eT5O+2Itsia53bdlMDAxEZR9JCUUsokLrF+rPO4KLLgxwTsZJEDjZI44i9pobeUyLIY9
         ZRKjfL+q0vOWGF/3kkMqm1nftMUJh6+p3ZB0pkSlVPVAApkc6CRHauBOjUVzPwva/Wi0
         yKRCVgZrDw4jtHOeBaKKPeS4dL/nZSxkDOk5+z/k2H8csIge0ZEUsHo8+UStWKNdHDcv
         hMbPFL8/v8SPVLyy2svAqiefmCz/kDaFjcdLFzYWbeMhODFpJNzEtzGP9+IQ+9TQORJd
         e1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051315; x=1784656115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vGSFs74aEtBd1sRRPWl9XB8Pr6s6QabN5aaAQJoaLzM=;
        b=guRZtDfu+wreYeHq/El0qmYXb4AqmzrSrqZ0m+mVX8facHZPyW3zwW+jgHMi/ug8JK
         zNIOhb6MZFfm5BbVzX81E10FAnkBiw8pNLGGn3t6szIijL/MuuQMA44zLrJ/teaLYHY1
         W9RFvKSZTYrTRiAy0krDibCraKIjG+FJSK3yq5B3f0DaAiTBHdi/a/9fVuWp7vwT0bZx
         AyxW4gaX111ACbbHkoR3Ru3S4JvM+pDFVkvVhvvoa26gG4cFs9S0gPALM/rhBr2aXhSs
         b4NW8JalKw1uQ7eetpnOb6TXnJ2RsX9KC+VB0ctKJv8OgAohNB7Ic5wYY+MeZUd7Idiy
         ioNw==
X-Gm-Message-State: AOJu0Yxj7HQ+MQZ+43DpCfKj9AORL5FEAiwjP4YiHlNGEQAond2pLJ/u
	nQoUD3ZaQ3F7BnYoEpmJ+VIm2D34V9p4PBo/ZTs8G0TOepg7Xoi3/jsmqUrWcd5pPso=
X-Gm-Gg: AfdE7cn6SV4aFv7xZdvWdYim3qehmcwIYGePIGJ8HIepmoFJ05qx5AzrvnTI/A/lTXS
	9OL+3MWGilIibL3xn/757givOZ65HOwI1YHbmgZKn+++MWUOafnau+dtS8Ip0RyMdZZ3vIt7oEy
	DM35ufgLlS5nfeazLP7TUkVIfo+YAeN9AQSn72PITS3MXRs2PnFybAvKVEkfNgWxcxcBc/vNKZi
	UNpWOtdwWZrOHIQsBfZg+vgXna0SdDiaRavr+q11htm+7TSE/w4hTWn2sHW9dkofSgvkajzjVJu
	tDQJOmMQQqhbmFgoYwMgJh4b78XEX/hb4f8FtX3GPW7IJX1772hKbikYcpVYyowvLLjrH/rUYFY
	keQjFwTSkiTD406BFB/bQqgivyroZd9DvaVn4J57lCx9hyDaqbzcB00wYlEpsEt/VodxPS7YTYn
	lKAzirY/3HRLy4TglZ6/6AFfwcsAmOFtViJPThBAO5JjFVj6o=
X-Received: by 2002:a05:6000:250d:b0:473:fc10:f675 with SMTP id ffacd0b85a97d-47f2dcc0fe2mr14428179f8f.18.1784051314887;
        Tue, 14 Jul 2026 10:48:34 -0700 (PDT)
Received: from cloudflare.com (93-57-92-86.ip163.fastwebnet.it. [93.57.92.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a974csm11713100f8f.18.2026.07.14.10.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:48:34 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 14 Jul 2026 19:48:24 +0200
Subject: [PATCH RFC net-next 5/6] selftests/bpf: Test skb_ext scrubbing
 across tunnels and veths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-bpf-meta-inside-skb-ext-v1-5-5871c07a8dd6@cloudflare.com>
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
In-Reply-To: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307549-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:from_mime,cloudflare.com:mid,cloudflare.com:email,cloudflare.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D013F757A17

Add tests for BPF_SKB_EXT_F_NO_SCRUB covering extension survival and
scrubbing across veth cross-netns forwarding and GRE tunnel
encap/decap:

- no_scrub_veth: ext with F_NO_SCRUB survives veth forwarding
- scrubbed_veth: ext without the flag is scrubbed on veth forwarding
- no_scrub_gre: ext with F_NO_SCRUB survives GRE encap+decap
- scrubbed_gre: ext without the flag is scrubbed on GRE decap

The GRE tests use a single netns with two gretap endpoints over
loopback. The veth tests use a cross-netns veth pair.

Move skb_ext subtests from xdp_context_tuntap into a dedicated
test_skb_ext test group.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 240 ++++++++++++++++++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  18 ++
 2 files changed, 224 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index c603f2484803..a697e8f63722 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -847,72 +847,236 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.helper_skb_change_proto,
 			    NULL, /* tc prio 2 */
 			    &skel->bss->test_pass);
-	/* Tests for BPF dynptr from skb_ext */
-	if (test__start_subtest("tc_skb_ext__write_read"))
+
+	test_xdp_meta__destroy(skel);
+}
+
+static void test_mirred_clone_ext_cow(struct test_xdp_meta *skel)
+{
+	struct bpf_link *tp_link;
+
+	skel->bss->clone_cow_done = false;
+	tp_link = bpf_program__attach(skel->progs.tp_kfree_skb_cow_check);
+	if (!ASSERT_OK_PTR(tp_link, "attach_tp"))
+		return;
+
+	test_mirred_clone_ext(skel, skel->progs.tc_skb_ext_clone_redir_cow);
+	bpf_link__destroy(tp_link);
+}
+
+/* Test skb_ext across veth cross-netns forwarding.
+ * Writer on TX_NAME egress, reader on RX_NAME ingress.
+ * When no_scrub is true, ext should survive. Otherwise it should be scrubbed.
+ */
+static void test_skb_ext_scrub_veth(struct test_xdp_meta *skel, bool no_scrub)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tx_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tx_opts, .handle = 1, .priority = 1);
+	LIBBPF_OPTS(bpf_tc_hook, rx_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, rx_opts, .handle = 1, .priority = 1);
+	struct netns_obj *rx_ns = NULL, *tx_ns = NULL;
+	struct nstoken *nstoken = NULL;
+	int rx_ifindex, tx_ifindex;
+	int ret;
+
+	tx_ns = netns_new(TX_NETNS, false);
+	if (!ASSERT_OK_PTR(tx_ns, "create tx_ns"))
+		return;
+
+	rx_ns = netns_new(RX_NETNS, false);
+	if (!ASSERT_OK_PTR(rx_ns, "create rx_ns"))
+		goto close;
+
+	SYS(close, "ip link add " RX_NAME " netns " RX_NETNS
+	    " type veth peer name " TX_NAME " netns " TX_NETNS);
+
+	/* Setup RX side: TC ingress reader */
+	nstoken = open_netns(RX_NETNS);
+	if (!ASSERT_OK_PTR(nstoken, "setns rx_ns"))
+		goto close;
+
+	SYS(close, "ip link set dev " RX_NAME " up");
+
+	rx_ifindex = if_nametoindex(RX_NAME);
+	if (!ASSERT_GE(rx_ifindex, 0, "if_nametoindex rx"))
+		goto close;
+
+	rx_hook.ifindex = rx_ifindex;
+	ret = bpf_tc_hook_create(&rx_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create rx"))
+		goto close;
+
+	rx_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_read);
+	ret = bpf_tc_attach(&rx_hook, &rx_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach rx"))
+		goto close;
+
+	close_netns(nstoken);
+
+	/* Setup TX side: TC egress writer */
+	nstoken = open_netns(TX_NETNS);
+	if (!ASSERT_OK_PTR(nstoken, "setns tx_ns"))
+		goto close;
+
+	SYS(close, "ip link set dev " TX_NAME " up");
+
+	tx_ifindex = if_nametoindex(TX_NAME);
+	if (!ASSERT_GE(tx_ifindex, 0, "if_nametoindex tx"))
+		goto close;
+
+	tx_hook.ifindex = tx_ifindex;
+	ret = bpf_tc_hook_create(&tx_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create tx"))
+		goto close;
+
+	tx_opts.prog_fd = no_scrub
+		? bpf_program__fd(skel->progs.tc_skb_ext_write_no_scrub)
+		: bpf_program__fd(skel->progs.tc_skb_ext_write);
+	ret = bpf_tc_attach(&tx_hook, &tx_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach tx"))
+		goto close;
+
+	skel->bss->test_pass = false;
+
+	ret = send_test_packet(tx_ifindex);
+	if (!ASSERT_OK(ret, "send_test_packet"))
+		goto close;
+
+	if (no_scrub)
+		ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+	else
+		ASSERT_FALSE(skel->bss->test_pass, "ext_scrubbed");
+
+close:
+	close_netns(nstoken);
+	netns_free(rx_ns);
+	netns_free(tx_ns);
+}
+
+/* Test skb_ext across GRE tunnel encap+decap.
+ * When no_scrub is true, ext should survive. Otherwise it should be scrubbed.
+ */
+static void test_skb_ext_scrub_gre(struct test_xdp_meta *skel, bool no_scrub)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tx_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tx_opts, .handle = 1, .priority = 1);
+	LIBBPF_OPTS(bpf_tc_hook, rx_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, rx_opts, .handle = 1, .priority = 1);
+	struct netns_obj *ns = NULL;
+	int tx_ifindex;
+	int rx_ifindex;
+	int ret;
+
+	skel->bss->test_pass = false;
+
+	ns = netns_new("gre_test", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	/* Setup: gre_tx -> lo -> gre_rx */
+	SYS(close, "ip link set lo up");
+	SYS(close, "ip link add gre_tx type gretap"
+	    " local 127.0.0.1 remote 127.0.0.2");
+	SYS(close, "ip link set gre_tx up");
+	SYS(close, "ip addr add 127.0.0.2/8 dev lo");
+	SYS(close, "ip link add gre_rx type gretap"
+	    " local 127.0.0.2 remote 127.0.0.1");
+	SYS(close, "ip link set gre_rx up");
+
+	/* Write skb_ext on TC egress on GRE tx */
+	tx_ifindex = if_nametoindex("gre_tx");
+	if (!ASSERT_GE(tx_ifindex, 0, "tx_ifindex"))
+		goto close;
+
+	tx_hook.ifindex = tx_ifindex;
+	ret = bpf_tc_hook_create(&tx_hook);
+	if (!ASSERT_OK(ret, "tx_hook_create"))
+		goto close;
+
+	tx_opts.prog_fd = no_scrub
+		? bpf_program__fd(skel->progs.tc_skb_ext_write_no_scrub)
+		: bpf_program__fd(skel->progs.tc_skb_ext_write);
+	ret = bpf_tc_attach(&tx_hook, &tx_opts);
+	if (!ASSERT_OK(ret, "tx_attach"))
+		goto close;
+
+	/* Read skb_ext on TC ingress on GRE rx */
+	rx_ifindex = if_nametoindex("gre_rx");
+	if (!ASSERT_GE(rx_ifindex, 0, "rx_ifindex"))
+		goto close;
+
+	rx_hook.ifindex = rx_ifindex;
+	ret = bpf_tc_hook_create(&rx_hook);
+	if (!ASSERT_OK(ret, "rx_hook_create"))
+		goto close;
+
+	rx_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_read);
+	ret = bpf_tc_attach(&rx_hook, &rx_opts);
+	if (!ASSERT_OK(ret, "rx_attach"))
+		goto close;
+
+	/* Then use send_test_packet on GRE tx */
+	ret = send_test_packet(tx_ifindex);
+	if (!ASSERT_OK(ret, "send_test_packet"))
+		goto close;
+
+	if (no_scrub)
+		ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+	else
+		ASSERT_FALSE(skel->bss->test_pass, "ext_scrubbed");
+
+close:
+	netns_free(ns);
+}
+
+void test_skb_ext(void)
+{
+	struct test_xdp_meta *skel = NULL;
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		return;
+
+	if (test__start_subtest("tc_write_read"))
 		test_tuntap(NULL, /* xdp */
 			    skel->progs.tc_skb_ext_write,
 			    skel->progs.tc_skb_ext_read,
 			    &skel->bss->test_pass);
-	if (test__start_subtest("tc_skb_ext__write_clone_read"))
+	if (test__start_subtest("tc_write_clone_read"))
 		test_tuntap(NULL, /* xdp */
 			    skel->progs.tc_skb_ext_write,
 			    skel->progs.tc_skb_ext_clone_read,
 			    &skel->bss->test_pass);
-	if (test__start_subtest("tc_skb_ext__write_slice_read"))
+	if (test__start_subtest("tc_write_slice_read"))
 		test_tuntap(NULL, /* xdp */
 			    skel->progs.tc_skb_ext_write,
 			    skel->progs.tc_skb_ext_slice_read,
 			    &skel->bss->test_pass);
-	if (test__start_subtest("tc_skb_ext__slice_write_read"))
+	if (test__start_subtest("tc_slice_write_read"))
 		test_tuntap(NULL, /* xdp */
 			    skel->progs.tc_skb_ext_slice_write,
 			    skel->progs.tc_skb_ext_read,
 			    &skel->bss->test_pass);
-	if (test__start_subtest("tc_skb_ext__no_alloc"))
+	if (test__start_subtest("tc_no_alloc"))
 		test_tuntap(NULL, /* xdp */
 			    skel->progs.tc_skb_ext_no_alloc,
 			    NULL, /* tc prio 2 */
 			    &skel->bss->test_pass);
-	if (test__start_subtest("tc_skb_ext__invalid_flags"))
+	if (test__start_subtest("tc_invalid_flags"))
 		test_tuntap(NULL, /* xdp */
 			    skel->progs.tc_skb_ext_invalid_flags,
 			    NULL, /* tc prio 2 */
 			    &skel->bss->test_pass);
-	if (test__start_subtest("tc_skb_ext__rdonly"))
+	if (test__start_subtest("tc_rdonly"))
 		test_tuntap(NULL, /* xdp */
 			    skel->progs.tc_skb_ext_rdonly,
 			    NULL, /* tc prio 2 */
 			    &skel->bss->test_pass);
-	if (test__start_subtest("tc_skb_ext__double_alloc"))
+	if (test__start_subtest("tc_double_alloc"))
 		test_tuntap(NULL, /* xdp */
 			    skel->progs.tc_skb_ext_double_alloc,
 			    NULL, /* tc prio 2 */
 			    &skel->bss->test_pass);
-
-	test_xdp_meta__destroy(skel);
-}
-
-static void test_mirred_clone_ext_cow(struct test_xdp_meta *skel)
-{
-	struct bpf_link *tp_link;
-
-	skel->bss->clone_cow_done = false;
-	tp_link = bpf_program__attach(skel->progs.tp_kfree_skb_cow_check);
-	if (!ASSERT_OK_PTR(tp_link, "attach_tp"))
-		return;
-
-	test_mirred_clone_ext(skel, skel->progs.tc_skb_ext_clone_redir_cow);
-	bpf_link__destroy(tp_link);
-}
-
-void test_skb_ext_cross_hook(void)
-{
-	struct test_xdp_meta *skel = NULL;
-
-	skel = test_xdp_meta__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
-		return;
-
 	if (test__start_subtest("tc_to_cgrp"))
 		test_skb_ext_udp(skel, "tc_to_cgrp", READER_CGRP_SKB);
 	if (test__start_subtest("tc_to_sk_filter"))
@@ -927,6 +1091,14 @@ void test_skb_ext_cross_hook(void)
 		test_mirred_clone_ext(skel, skel->progs.tc_skb_ext_read);
 	if (test__start_subtest("clone_ext_cow"))
 		test_mirred_clone_ext_cow(skel);
+	if (test__start_subtest("no_scrub_veth"))
+		test_skb_ext_scrub_veth(skel, true);
+	if (test__start_subtest("scrubbed_veth"))
+		test_skb_ext_scrub_veth(skel, false);
+	if (test__start_subtest("no_scrub_gre"))
+		test_skb_ext_scrub_gre(skel, true);
+	if (test__start_subtest("scrubbed_gre"))
+		test_skb_ext_scrub_gre(skel, false);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 25fbdc00657c..a1a3cbdb85bc 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -703,6 +703,24 @@ int tc_skb_ext_write(struct __sk_buff *ctx)
 	return TC_ACT_UNSPEC;
 }
 
+/* Write to skb_ext with NO_SCRUB flag to survive scrubbing */
+SEC("tc")
+int tc_skb_ext_write_no_scrub(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_from_skb_ext(ctx, 0,
+				    BPF_SKB_EXT_F_CREATE | BPF_SKB_EXT_F_NO_SCRUB,
+				    &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_want, ARRAY_SIZE(meta_want), 0))
+		return TC_ACT_SHOT;
+
+	return TC_ACT_UNSPEC;
+}
+
 /* Read from skb-ext metadata using bpf_dynptr_read helper */
 SEC("tc")
 int tc_skb_ext_read(struct __sk_buff *ctx)

-- 
2.43.0


