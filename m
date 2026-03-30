Return-Path: <netdev+bounces-273089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ7PEJAuymkA6AUAu9opvQ
	(envelope-from <netdev+bounces-273089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:04:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3947E356D78
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECDB6300954A
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306D23AC0F1;
	Mon, 30 Mar 2026 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rMGJXaow"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7330F3AB299;
	Mon, 30 Mar 2026 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857833; cv=none; b=rjKY/aKGheMgincpN3XhdGg30Tm7h02lVLRMXk5MQtGxf/ElsFUM7UCLB+LtTmRVipuDQdeUWum1sNEw5LANSR8PlVJd0Ht6bJXqJ7QvFi0QeA6SZZRE7sBwiSkyiDcobQbLORbn3V/w4uXWzOBsEAlAO1rcbcoLcljGg13JjNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857833; c=relaxed/simple;
	bh=09C/OzGwqqMv+kkQJpECbI+iQQ6V2dADdMjc2ANykCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UH4K00UCMAtvtlGqGV0ZXPIKqjOJ0B8jEdx+a+rti3/xtIr60imPQd7sTqKubM6lA6FVwDE7RATlDZhLmJYS29whlkEbls2ZON141YajX2NYjtAqpLyFWiUwstH85JI0Jie2QhIHgdZfApPwwF5ID8aDizu23esJZuDXY+Z3IAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rMGJXaow; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GOWEtAf9N1qRA+nzgdIl4Ke886MQ7Kmtcy1GKvdhTK8=; b=rMGJXaowZjxvBAvapevPWez30t
	G1BQn9KbtVWKCeWxJ3NN7imyu/PxsSfuJI0P+pHvvLsdJiRcS1+Q/ptitt4FsYosomNx2xL8WM48m
	Szj0wg0SUrP8UmpVLTzkGxopT4zDrx+dmopoJMP5mgac49ZaZ5D2BNFTCPr7Ix6btbbRiAue/r1na
	xxrqeDGqj2T5GfJk8AF/vKLE+Af3GRO7WrlJHiIGSEUpEzeESXn2t0jSM31K3KKvg+jRbvnzfr5oD
	YrgtlI8YYGA8jSwh89zazCJHC+ovKCCVFZjY10K6JgBGnodve0h3ui3d6wpJ9wfzFP6+sPq8Yxuy3
	EC9YCGUA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w77b9-000MC3-2m;
	Mon, 30 Mar 2026 10:03:47 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1w77b8-0005Vi-2M;
	Mon, 30 Mar 2026 10:03:46 +0200
Message-ID: <3532664e-1f62-412c-9819-b048f62da010@iogearbox.net>
Date: Mon, 30 Mar 2026 10:03:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: test that dst is cleared
 on same-protocol encap
To: Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20260329180428.2657785-1-kuba@kernel.org>
 <20260329180428.2657785-2-kuba@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260329180428.2657785-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27956/Mon Mar 30 08:24:32 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273089-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,linux.dev,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3947E356D78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/29/26 8:04 PM, Jakub Kicinski wrote:
> Verify that bpf_skb_adjust_room() clears the routing dst even when
> the encap L3 protocol matches the original packet (e.g. IPIP).
> The dst selected for the inner packet is not valid for the
> encapsulated result; a stale dst could lead to misrouting.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

For new tests we should ideally only be using tcx links and not the old
qdisc approach unless there is specifc reason to. Any objections if I
fold this in while applying?

  .../selftests/bpf/prog_tests/test_dst_clear.c | 23 ++++++-------------
  .../selftests/bpf/progs/test_dst_clear.c      |  2 +-
  2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_dst_clear.c b/tools/testing/selftests/bpf/prog_tests/test_dst_clear.c
index 8190c56556fb..c8e9c6947a2c 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_dst_clear.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_dst_clear.c
@@ -15,11 +15,11 @@
  
  void test_dst_clear(void)
  {
-	LIBBPF_OPTS(bpf_tc_hook, qdisc_hook, .attach_point = BPF_TC_EGRESS);
-	LIBBPF_OPTS(bpf_tc_opts, tc_attach);
+	LIBBPF_OPTS(bpf_tcx_opts, tcx_opts);
  	struct nstoken *nstoken = NULL;
  	struct test_dst_clear *skel;
  	struct sockaddr_in addr;
+	struct bpf_link *link;
  	socklen_t addrlen;
  	char buf[128] = {};
  	int sockfd, err;
@@ -36,18 +36,11 @@ void test_dst_clear(void)
  	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
  		goto fail;
  
-	qdisc_hook.ifindex = if_nametoindex("lo");
-	if (!ASSERT_GT(qdisc_hook.ifindex, 0, "if_nametoindex lo"))
-		goto fail;
-
-	err = bpf_tc_hook_create(&qdisc_hook);
-	if (!ASSERT_OK(err, "create qdisc hook"))
-		goto fail;
-
-	tc_attach.prog_fd = bpf_program__fd(skel->progs.dst_clear);
-	err = bpf_tc_attach(&qdisc_hook, &tc_attach);
-	if (!ASSERT_OK(err, "attach filter"))
+	link = bpf_program__attach_tcx(skel->progs.dst_clear,
+				       if_nametoindex("lo"), &tcx_opts);
+	if (!ASSERT_OK_PTR(link, "attach_tcx"))
  		goto fail;
+	skel->links.dst_clear = link;
  
  	addrlen = sizeof(addr);
  	err = make_sockaddr(AF_INET, IPV4_IFACE_ADDR, UDP_TEST_PORT,
@@ -66,10 +59,8 @@ void test_dst_clear(void)
  	ASSERT_TRUE(skel->bss->dst_cleared, "dst_cleared");
  
  fail:
-	if (nstoken) {
-		bpf_tc_hook_destroy(&qdisc_hook);
+	if (nstoken)
  		close_netns(nstoken);
-	}
  	SYS_NOFAIL("ip netns del " NS_TEST);
  	test_dst_clear__destroy(skel);
  }
diff --git a/tools/testing/selftests/bpf/progs/test_dst_clear.c b/tools/testing/selftests/bpf/progs/test_dst_clear.c
index 7ac9604fd99c..c22a6eeb4798 100644
--- a/tools/testing/selftests/bpf/progs/test_dst_clear.c
+++ b/tools/testing/selftests/bpf/progs/test_dst_clear.c
@@ -13,7 +13,7 @@ void *bpf_cast_to_kern_ctx(void *) __ksym;
  bool had_dst = false;
  bool dst_cleared = false;
  
-SEC("tc")
+SEC("tc/egress")
  int dst_clear(struct __sk_buff *skb)
  {
  	struct sk_buff *kskb;
-- 
2.43.0



