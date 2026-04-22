Return-Path: <netdev+bounces-280549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ3AEk866WnFWAIAu9opvQ
	(envelope-from <netdev+bounces-280549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 23:14:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEF344AD55
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 23:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DCBA30C2EBF
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5108B36BCC4;
	Wed, 22 Apr 2026 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J257CulQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4515365A1D
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892323; cv=none; b=ceS1nNaJBIFMp6toT8d9xKIOc1SNcCoUwzeCfHX/SMIgCoNp2gMVVGqCfVur6q+6S98p/0eqEmNgVgEhKv/WnWCP0K/To7TVeEgpcu8rYEg973kQN6VZgYweK5ksZAskKSi+yfpbq9M2QqKL7DAVefl4gY62iiyLK8u0YM0ZtP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892323; c=relaxed/simple;
	bh=v7U75NKiCPYtTdQcEnkj2wpWyCLF3eSW0cslj4j/1DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lc5rthnuxDwHP/llqkf7SLhSySwLhYL29CRvoBTb0Qp0tweMF63eIM7xdDqDT4S6ecz9XMbX+7hiu3lbCEayVul7KgQKTHyeXrABH6veNBHNFvha5S+z+YKnbmQQK5QAGAk7IT+zypW0zFdYvCXLNwYabA2E2SFdWvyEYmc1c/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J257CulQ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 22 Apr 2026 14:11:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776892310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEandxuFafG0C/7810R/J7c3UrG1zSU4EJVrzgVn8Pc=;
	b=J257CulQuZDOKAP+hzxI5m1x/1f7RRcZvINwLvEqjQYq4bjPPs5X0QpCTGoLcWmFqADdLp
	GK6KMC54APkAvW4xZ1bw6YlSpPubaIXn9c1ptGPMxwjkj1KVROaqnB5SZe3HDHwn5aKCGn
	0M7OTrg6f0N7RExaee2KtNlWER+8oEQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Werner Kasselman <werner@verivus.ai>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: cover same-reg sock_ops
 rtt_min request_sock access
Message-ID: <202642221444.tUNv.martin.lau@linux.dev>
References: <20260417023119.3830723-1-werner@verivus.com>
 <20260420230030.2802408-1-werner@verivus.com>
 <20260420230030.2802408-3-werner@verivus.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420230030.2802408-3-werner@verivus.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280549-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,iogearbox.net,linux.dev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9BEF344AD55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:00:37PM +0000, Werner Kasselman wrote:
> Add a tcpbpf sock_ops selftest that forces a same-register ctx->rtt_min read on request_sock-backed callbacks and verifies the observed value is zero.
> 
> This covers the dst_reg == src_reg path that the previous ctx_rewrite-only test did not exercise.

Same formatting issue.

> 
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
>  .../testing/selftests/bpf/prog_tests/tcpbpf_user.c |  4 ++++
>  .../testing/selftests/bpf/progs/test_tcpbpf_kern.c | 14 ++++++++++++++
>  tools/testing/selftests/bpf/test_tcpbpf.h          |  2 ++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> index 7e8fe1bad03f..1b08e49327d0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> @@ -42,6 +42,10 @@ static void verify_result(struct tcpbpf_globals *result)
>  	/* check getsockopt for window_clamp */
>  	ASSERT_EQ(result->window_clamp_client, 9216, "window_clamp_client");
>  	ASSERT_EQ(result->window_clamp_server, 9216, "window_clamp_server");
> +
> +	/* check same-reg rtt_min read on request_sock-backed callbacks */
> +	ASSERT_NEQ(result->rtt_min_req_seen, 0, "rtt_min_req_seen");
> +	ASSERT_EQ(result->rtt_min_req_nonzero, 0, "rtt_min_req_nonzero");
>  }
>  
>  static void run_test(struct tcpbpf_globals *result)
> diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> index 6935f32eeb8f..a488b282b5dd 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> @@ -33,6 +33,7 @@ int bpf_testcb(struct bpf_sock_ops *skops)
>  {
>  	char header[sizeof(struct ipv6hdr) + sizeof(struct tcphdr)];
>  	struct bpf_sock_ops *reuse = skops;
> +	long rtt_min = (long)skops;

It is overly smart to test the same dst_reg == src_reg.
A new test has just been added to test it in a cleaner way.

pw-bot: cr

You haven't spent time to take a look of the patches first.
Please don't post again. I will stop reviewing your patches from now.

