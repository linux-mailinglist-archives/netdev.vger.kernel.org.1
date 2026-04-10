Return-Path: <netdev+bounces-277487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J9PCMkn2WkPmwgAu9opvQ
	(envelope-from <netdev+bounces-277487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:39:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A13DA827
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBCA1300E716
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6983DBD69;
	Fri, 10 Apr 2026 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="bVCxTGf5"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD0B3D9DAA;
	Fri, 10 Apr 2026 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838492; cv=none; b=NLDFEwfIKHqeR9V1Akv8j6Kzi96+zoLP1WmE34G0huuChnukUp6csa3ro329yc04EnIpLsFeLnUBbsFqWeMdKC0Cxi7IsEdpyxoRTrLw5oHcfJBHddtLJ5Q8SOEdyRSBYzXxkBn5CeDY+KVUan6hDF04lTb1YmxbuRJTQ0X5C8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838492; c=relaxed/simple;
	bh=0BxY+Sw0YozqmGULypSYTOf58lyVZZRNDj4glC4NcoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USKd35ddf/m2RVcXjJsE8UN7QtpKQ9AR4NCmvLYfONmZ/++xU5UtqiIau7n39UvdoUDvnKzIso00K/vgXjZmQvYCV7bL8Zl+sw3J8OnnpDrt/9hOMZmT/nRzuCcYv/jLbfws3HEfJM8dEf9o5BbmBBRgsFi8W7wSqPd0ezAQHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=bVCxTGf5; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RXurTOWH4CFrJUg4tvINl7cUUFVNq2C4h3woo2AFtBo=; b=bVCxTGf5t6gYX60/RTl8bzPc5N
	IlcQeKmrS24N6FdL9XGtzNBldXH8HDK5QodHfqm8l/qByWhiDJOp/touXdbFKb/YW2esUYT8BNbjd
	+A+exII5dQCQD0i0i0wyfSwYPv8n0mlLU3FE49GpeiaTd0y7cyMiQNv6Nkn1IgzRDauB/dxX2LZ7w
	ACFC43rgINnBArJ8tL0ZqJASmMkxq6h8TXLofAcvv/SCQ/PH0n1DdHZkuBSLxJUM+w7FVlkSZ0cFu
	aL0azpdHcZG5AzA+64BB0TqD2u9r1GrbntXF6K7VWjJnX1DeBz0/JHe7Q3kVAQqs0PqcSoX2Ay8XE
	MxiFqIjw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wBEiG-000HnV-0p;
	Fri, 10 Apr 2026 18:28:08 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wBEiE-000FfL-22;
	Fri, 10 Apr 2026 18:28:06 +0200
Message-ID: <f8782293-1ec5-474d-b288-e2546016869b@iogearbox.net>
Date: Fri, 10 Apr 2026 18:28:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6 2/2] selftests/bpf: add test for
 xdp_master_redirect with bond not up
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jussi Maki <joamaki@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Nikolay Aleksandrov <razor@blackwall.org>
References: <20260410113726.368111-1-jiayuan.chen@linux.dev>
 <20260410113726.368111-3-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260410113726.368111-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27967/Fri Apr 10 08:24:45 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277487-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,vger.kernel.org,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:dkim,iogearbox.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 759A13DA827
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/26 1:37 PM, Jiayuan Chen wrote:
> Add a selftest that reproduces the null-ptr-deref in
> bond_rr_gen_slave_id() when XDP redirect targets a bond device in
> round-robin mode that was never brought up. The test verifies the fix
> by ensuring no crash occurs.
> 
> Test setup:
> - bond0: active-backup mode, UP, with native XDP (enables
>    bpf_master_redirect_enabled_key globally)
> - bond1: round-robin mode, never UP
> - veth1: slave of bond1, with generic XDP (XDP_TX)
> - BPF_PROG_TEST_RUN with live frames triggers the redirect path
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

I checked locally that this XDP test passes fine and triggers a NULL
pointer deref without the fix.

[...]
> +	/* Attach generic XDP (XDP_TX) to veth1.
> +	 * When packets arrive at veth1 via netif_receive_skb, do_xdp_generic()
> +	 * runs this program. XDP_TX + bond slave triggers xdp_master_redirect().
> +	 */
> +	xdp_tx_fd = bpf_program__fd(skeletons->xdp_tx->progs.xdp_tx);
> +	if (!ASSERT_GE(xdp_tx_fd, 0, "xdp_tx prog_fd"))
> +		goto out;

nit: no need for the ASSERT_GE given the skeleton loaded, see also the various
other tests gathering bpf_program__fd().

> +	err = bpf_xdp_attach(veth1_ifindex, xdp_tx_fd,
> +			     XDP_FLAGS_SKB_MODE, NULL);
> +	if (!ASSERT_OK(err, "attach generic XDP to veth1"))
> +		goto out;
> +
> +	/* Run BPF_PROG_TEST_RUN with XDP_PASS live frames on veth1.
> +	 * XDP_PASS frames become SKBs with skb->dev = veth1, entering
> +	 * netif_receive_skb -> do_xdp_generic -> xdp_master_redirect.
> +	 * Without the fix, bond_rr_gen_slave_id() dereferences NULL
> +	 * rr_tx_counter and crashes.
> +	 */
> +	xdp_pass_fd = bpf_program__fd(skeletons->xdp_dummy->progs.xdp_dummy_prog);
> +	if (!ASSERT_GE(xdp_pass_fd, 0, "xdp_pass prog_fd"))
> +		goto out;

ditto, can be simplified a bit into:

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index 0d4ec1e5b401..c42488e445c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -506,7 +506,7 @@ static void test_xdp_bonding_nested(struct skeletons *skeletons)
  static void test_xdp_bonding_redirect_no_up(struct skeletons *skeletons)
  {
  	struct nstoken *nstoken = NULL;
-	int xdp_pass_fd, xdp_tx_fd;
+	int xdp_pass_fd;
  	int veth1_ifindex;
  	int err;
  	char pkt[ETH_HLEN + 1];
@@ -555,11 +555,8 @@ static void test_xdp_bonding_redirect_no_up(struct skeletons *skeletons)
  	 * When packets arrive at veth1 via netif_receive_skb, do_xdp_generic()
  	 * runs this program. XDP_TX + bond slave triggers xdp_master_redirect().
  	 */
-	xdp_tx_fd = bpf_program__fd(skeletons->xdp_tx->progs.xdp_tx);
-	if (!ASSERT_GE(xdp_tx_fd, 0, "xdp_tx prog_fd"))
-		goto out;
-
-	err = bpf_xdp_attach(veth1_ifindex, xdp_tx_fd,
+	err = bpf_xdp_attach(veth1_ifindex,
+			     bpf_program__fd(skeletons->xdp_tx->progs.xdp_tx),
  			     XDP_FLAGS_SKB_MODE, NULL);
  	if (!ASSERT_OK(err, "attach generic XDP to veth1"))
  		goto out;
@@ -571,8 +568,6 @@ static void test_xdp_bonding_redirect_no_up(struct skeletons *skeletons)
  	 * rr_tx_counter and crashes.
  	 */
  	xdp_pass_fd = bpf_program__fd(skeletons->xdp_dummy->progs.xdp_dummy_prog);
-	if (!ASSERT_GE(xdp_pass_fd, 0, "xdp_pass prog_fd"))
-		goto out;
  
  	memset(pkt, 0, sizeof(pkt));
  	ctx_in.data_end = sizeof(pkt);


