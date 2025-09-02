Return-Path: <netdev+bounces-219276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 059C1B40DAD
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3E41889EA0
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 19:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48C721CFF6;
	Tue,  2 Sep 2025 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HulprmXx"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8381C68F
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840257; cv=none; b=az2BAdR/u2SrFzMkzfddqqKm9vypNJvQLrCwBJp31vk3vx9AgYxC4IS8sx5ed4WvJWPIGXHTwpyljvdASaOCqGJb1VIMiY+b6rjnAtAu8CXKEpiQIYP0fpUUpQ+K9h5UTz2+UtUJ3cDhmj3ZuVanFAJn3c0r7twsW21gZGiBdYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840257; c=relaxed/simple;
	bh=zzI+BTJuKFkczAKdKEPRVzaUgHwvNtFkNf3THRBoB9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYaVYoplwY3Of8tXyuDhf6Zc2Xz2JF+Rc17bDoEjmrOZMtPJOuA+HZegMbAJ9MUA3ThtqyOWmsmZ9Gu7Ya9cqbRR4k7Xil/VRQzRNyjI0QLIJA5qn06kmf3zO20yjZCWCTrKdcgyG3RXNReEuZze1ksYWCNZK4/qBRs8tgvk3Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HulprmXx; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9bc995b4-d0bd-41a8-8867-97507a55d449@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756840253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4uauO2rWcC3oaLaZU8v8xXb2o7/WF7PmAUWyjlQDLg=;
	b=HulprmXxCL2Z48+cJtLr4QvUrY6FR81HxfrT2Dcr1JBdUR1pobVzxCjif4RLsOW6qRqv4n
	VrtYAuJFAvgyeDaihzuDdARV1dChSTAxny6KwS0vYebmGfGR5ZGylJiXeu3Sv/NtipYfYU
	8j/A5fKkZJlYYPouPCDQG3iGPJCs4ic=
Date: Tue, 2 Sep 2025 12:10:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for
 BPF_CGROUP_INET_SOCK_CREATE.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250829010026.347440-1-kuniyu@google.com>
 <20250829010026.347440-3-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250829010026.347440-3-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
> +BPF_CALL_5(bpf_unlocked_sock_setsockopt, struct sock *, sk, int, level,
> +	   int, optname, char *, optval, int, optlen)
> +{
> +	return __bpf_setsockopt(sk, level, optname, optval, optlen);
> +}
> +
> +static const struct bpf_func_proto bpf_unlocked_sock_setsockopt_proto = {

nit. There is a bpf_unlocked_"sk"_{get,set}sockopt_proto which its .func is also 
taking "struct sock *". This one is sock_create specific, how about renaming it 
to bpf_sock_create_{get,set}sockopt_proto. The same for the its .func.


> +	.func		= bpf_unlocked_sock_setsockopt,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_CTX,
> +	.arg2_type	= ARG_ANYTHING,
> +	.arg3_type	= ARG_ANYTHING,
> +	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
> +	.arg5_type	= ARG_CONST_SIZE,
> +};
> +
> +BPF_CALL_5(bpf_unlocked_sock_getsockopt, struct sock *, sk, int, level,
> +	   int, optname, char *, optval, int, optlen)
> +{
> +	return __bpf_getsockopt(sk, level, optname, optval, optlen);
> +}
> +
> +static const struct bpf_func_proto bpf_unlocked_sock_getsockopt_proto = {
> +	.func		= bpf_unlocked_sock_getsockopt,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_CTX,
> +	.arg2_type	= ARG_ANYTHING,
> +	.arg3_type	= ARG_ANYTHING,
> +	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
> +	.arg5_type	= ARG_CONST_SIZE,
> +};


