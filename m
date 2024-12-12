Return-Path: <netdev+bounces-151501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737A69EFC90
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 20:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F92289E9B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96A41A0AFB;
	Thu, 12 Dec 2024 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YiIbmGbv"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96D19D089
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032108; cv=none; b=OI3xAifMhflTuBi5eDfgMss5RiymIn9Jj372j8O8hAX3SxZjSBEPNrPmPCscvWU+o0KsOgNKQqyRNpqjDpvzfH/tDZVtO+C3HXZKYAawUM4iwlEDZm58ijkYP3/YROEL+vhfElUfmoFyQxfgYNpwr9DCV3IWrAOXhGDz+UnAuPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032108; c=relaxed/simple;
	bh=tnUSTCUCV3YbtAqd+dXe3qV/gXDB7PsdGL/K5e4W2pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HB7WIQdjyM6t8sANEzuQXyc2CZHwQyIfU8VSxzmjMAJEuhTf5kEecQEwPg1g2mvbVxvouCi73d0EK4AxNlavivEaL2fP52AbVZvaV8qddal2mE0xE/B5mGJ7U2Kf2dr6jm4ZMA3u9hIgCMSs7Krl5do2k0exOjMs1xFs6zaWLhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YiIbmGbv; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a464155-3115-468b-88f3-5ee81d9e3b84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734032103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ojw80EIqrCZctLiiIevFYV0ImOn3GkYm7ZZRe2ml6qY=;
	b=YiIbmGbvq02j4tFQW/iYxkkovrKCH6HNQAP9clas4o/4rEvI607CAaze9xjfgx+n5ZfJ4R
	hyjmyDw6JbFegQNF636k+P2RPHbR/Xrf29CQGCwWdaDbxnX2qx2U48ZnNMIEXZMYkeAiGK
	f8OydmSoHljcnii6UeUMLHm07Bio6Ik=
Date: Thu, 12 Dec 2024 11:34:52 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 01/11] net-timestamp: add support for
 bpf_setsockopt()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-2-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241207173803.90744-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/7/24 9:37 AM, Jason Xing wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 6625b3f563a4..f7e9f88e09b1 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5214,6 +5214,24 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
>   	.arg1_type      = ARG_PTR_TO_CTX,
>   };
>   
> +static int sk_bpf_set_cb_flags(struct sock *sk, sockptr_t optval, bool getopt)

It is confusing to take a sockptr_t argument. It is called by the kernel bpf 
prog only. It must be from the kernel memory. Directly pass the "int 
sk_bpf_cb_flags" as the argument.

> +{
> +	int sk_bpf_cb_flags;
> +
> +	if (getopt)
> +		return -EINVAL;
> +
> +	if (copy_from_sockptr(&sk_bpf_cb_flags, optval, sizeof(sk_bpf_cb_flags)))

It is an unnecessary copy. Directly use the "int sk_bpf_cb_flags" arg instead.

> +		return -EFAULT;

This should never happen.

> +
> +	if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
> +		return -EINVAL;
> +
> +	sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
> +
> +	return 0;
> +}
> +
>   static int sol_socket_sockopt(struct sock *sk, int optname,
>   			      char *optval, int *optlen,
>   			      bool getopt)
> @@ -5230,6 +5248,7 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
>   	case SO_MAX_PACING_RATE:
>   	case SO_BINDTOIFINDEX:
>   	case SO_TXREHASH:
> +	case SK_BPF_CB_FLAGS:
>   		if (*optlen != sizeof(int))
>   			return -EINVAL;
>   		break;
> @@ -5239,6 +5258,9 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
>   		return -EINVAL;
>   	}
>   
> +	if (optname == SK_BPF_CB_FLAGS)
> +		return sk_bpf_set_cb_flags(sk, KERNEL_SOCKPTR(optval), getopt);
> +
>   	if (getopt) {
>   		if (optname == SO_BINDTODEVICE)
>   			return -EINVAL;

