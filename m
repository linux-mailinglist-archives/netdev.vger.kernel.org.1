Return-Path: <netdev+bounces-277631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD1ZI0qb2WkTrQgAu9opvQ
	(envelope-from <netdev+bounces-277631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 02:52:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0930B3DDC71
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 02:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BDD3303AF3F
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D422DF137;
	Sat, 11 Apr 2026 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GTXt9UX0"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9B2836BE
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775868735; cv=none; b=gAp4bHnIIHki+96y9XPnBfnjHtI7cdAnwLlNSJRTm54HGM5Ydpegq3FegBZVfVdmZudMCtZrjHIWSCaLJATTDf0ffWf9ADDmH4CvxefxM+0jDDsFYvuF7UAAKdyTSspbQs1nFuOtOkrL/cL5w6vFu4cpJYuKYDEC16ZXIS9ShVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775868735; c=relaxed/simple;
	bh=G4RWmcYL+5NqK+i/tAB+tgwa0aa5TIvET8w5CtHz1io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyMQly85yvGw1l8LN+9wOF9tsYWXNAgdFeTbjuKyWPz1ZNqFaC+tVbX1k8ayTdvT9mbvXFCZeQ33tFkp/yo3aiNzBUIUpFDh3PtczM70WoUczLqaHwGIEzvb+HAvTSHi497fQ8HniNVB5uimIvMDURDwd+VMJ0VPhIWjtwWEAMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GTXt9UX0; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc734e36-e2e4-4932-aa6d-c9bb72eed64f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775868720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKXM337EXHBBU2sSAwCoGOaqesVN/KfvuTy8OnCKCBA=;
	b=GTXt9UX076jfl2qV7Nrgw8KQ++HremIy+lcBr4eGdIP+sBxKbgkzJxi4TssacbLj9tFhiu
	JR2phR0qsi2bhcj9vkxpkvZqfN4kSRmtGT6cJwiRQoWn6ArneltaY2MjSfmepR7VkCwir+
	A3yWrtDoCvgRnNuYAthj5jg7aeMZFfw=
Date: Sat, 11 Apr 2026 08:51:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v6 2/2] selftests/bpf: add test for
 xdp_master_redirect with bond not up
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
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
 <f8782293-1ec5-474d-b288-e2546016869b@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <f8782293-1ec5-474d-b288-e2546016869b@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277631-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,vger.kernel.org,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 0930B3DDC71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/11/26 12:28 AM, Daniel Borkmann wrote:
> On 4/10/26 1:37 PM, Jiayuan Chen wrote:
>> Add a selftest that reproduces the null-ptr-deref in
>> bond_rr_gen_slave_id() when XDP redirect targets a bond device in
>> round-robin mode that was never brought up. The test verifies the fix
>> by ensuring no crash occurs.
>>
>> Test setup:
>> - bond0: active-backup mode, UP, with native XDP (enables
>>    bpf_master_redirect_enabled_key globally)
>> - bond1: round-robin mode, never UP
>> - veth1: slave of bond1, with generic XDP (XDP_TX)
>> - BPF_PROG_TEST_RUN with live frames triggers the redirect path
>>
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> I checked locally that this XDP test passes fine and triggers a NULL
> pointer deref without the fix.
>
> [...]
>> +    /* Attach generic XDP (XDP_TX) to veth1.
>> +     * When packets arrive at veth1 via netif_receive_skb, 
>> do_xdp_generic()
>> +     * runs this program. XDP_TX + bond slave triggers 
>> xdp_master_redirect().
>> +     */
>> +    xdp_tx_fd = bpf_program__fd(skeletons->xdp_tx->progs.xdp_tx);
>> +    if (!ASSERT_GE(xdp_tx_fd, 0, "xdp_tx prog_fd"))
>> +        goto out;
>
> nit: no need for the ASSERT_GE given the skeleton loaded, see also the 
> various
> other tests gathering bpf_program__fd().
>
>> +    err = bpf_xdp_attach(veth1_ifindex, xdp_tx_fd,
>> +                 XDP_FLAGS_SKB_MODE, NULL);
>> +    if (!ASSERT_OK(err, "attach generic XDP to veth1"))
>> +        goto out;
>> +
>> +    /* Run BPF_PROG_TEST_RUN with XDP_PASS live frames on veth1.
>> +     * XDP_PASS frames become SKBs with skb->dev = veth1, entering
>> +     * netif_receive_skb -> do_xdp_generic -> xdp_master_redirect.
>> +     * Without the fix, bond_rr_gen_slave_id() dereferences NULL
>> +     * rr_tx_counter and crashes.
>> +     */
>> +    xdp_pass_fd = 
>> bpf_program__fd(skeletons->xdp_dummy->progs.xdp_dummy_prog);
>> +    if (!ASSERT_GE(xdp_pass_fd, 0, "xdp_pass prog_fd"))
>> +        goto out;
>
> ditto, can be simplified a bit into:
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c 
> b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
> index 0d4ec1e5b401..c42488e445c2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
> @@ -506,7 +506,7 @@ static void test_xdp_bonding_nested(struct 
> skeletons *skeletons)
>  static void test_xdp_bonding_redirect_no_up(struct skeletons *skeletons)
>  {
>      struct nstoken *nstoken = NULL;
> -    int xdp_pass_fd, xdp_tx_fd;
> +    int xdp_pass_fd;
>      int veth1_ifindex;
>      int err;
>      char pkt[ETH_HLEN + 1];
> @@ -555,11 +555,8 @@ static void 
> test_xdp_bonding_redirect_no_up(struct skeletons *skeletons)
>       * When packets arrive at veth1 via netif_receive_skb, 
> do_xdp_generic()
>       * runs this program. XDP_TX + bond slave triggers 
> xdp_master_redirect().
>       */
> -    xdp_tx_fd = bpf_program__fd(skeletons->xdp_tx->progs.xdp_tx);
> -    if (!ASSERT_GE(xdp_tx_fd, 0, "xdp_tx prog_fd"))
> -        goto out;
> -
> -    err = bpf_xdp_attach(veth1_ifindex, xdp_tx_fd,
> +    err = bpf_xdp_attach(veth1_ifindex,
> + bpf_program__fd(skeletons->xdp_tx->progs.xdp_tx),
>                   XDP_FLAGS_SKB_MODE, NULL);
>      if (!ASSERT_OK(err, "attach generic XDP to veth1"))
>          goto out;
> @@ -571,8 +568,6 @@ static void test_xdp_bonding_redirect_no_up(struct 
> skeletons *skeletons)
>       * rr_tx_counter and crashes.
>       */
>      xdp_pass_fd = 
> bpf_program__fd(skeletons->xdp_dummy->progs.xdp_dummy_prog);
> -    if (!ASSERT_GE(xdp_pass_fd, 0, "xdp_pass prog_fd"))
> -        goto out;
>
>      memset(pkt, 0, sizeof(pkt));
>      ctx_in.data_end = sizeof(pkt);
>
Hi daniel

Thanks for the review and for verifying the crash reproduces without the 
fix.

I've applied your suggestion.



