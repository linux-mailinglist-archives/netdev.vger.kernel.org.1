Return-Path: <netdev+bounces-229729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13475BE04A2
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD823A98C7
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DA61FDE14;
	Wed, 15 Oct 2025 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T2gFrar5"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252714B96E
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554840; cv=none; b=DC9ENtXqvegUC9jWPZc9tLY/C7RlSAyOZozIjfIiRyiLdf64LHKl3VWWxP5F0Tw0WBeBh0rGhFs1pDl6zAE+k5CUa6ftkvIb7EbZtcUoCBwND6GEwKr2O8JuMXC5gr5hRxpTXlGb9X7lbsRcvPAqnc3BPMlO10dYl1ZBJCBHN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554840; c=relaxed/simple;
	bh=FgyJRLpm6GvA8r1CRZcDFbvJgDwQ911aKdVKpy4Rd5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBjZ/PYabPkYf95WNRTr0ZSg2Z75L9clBPbIcJ+KqAoZnhPorPtOkICWSEK4cGZ9P1S3nrJEBx14C7gE4k+tM5wpop+68KXIajGD8eyWOvWqHwKN0E+Z3kw0LtLpOl8nHpP+oPVk0u12Ohh08cy3kiSii8SFUhNIE0rS9XoThbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T2gFrar5; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e8aeb1b8-06f0-4eb3-a1ef-26b943d1c6b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760554824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ViHS6o7TjQ1SExpzKDwFLJCmbItkiEqx2/j5dGG/ukQ=;
	b=T2gFrar5CIyG+IQEbo3W6MQ8gPxv7Xz0mhPtS3mh+9fEnd5MeDp9NzZN7kUSmQy4uRU4y3
	fsZRl52NYp7FOi8pqoNKTd8sxehhOGZ11yWw/LY+yUwAO8s1TqNXTgWQ36tbOvZ5ghjKKz
	sedlnUNciiaFAt/OPKcsblPl+sSaZ/k=
Date: Wed, 15 Oct 2025 12:00:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next/net 5/6] bpf: Introduce
 SK_BPF_BYPASS_PROT_MEM.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20251014235604.3057003-1-kuniyu@google.com>
 <20251014235604.3057003-6-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251014235604.3057003-6-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/14/25 4:54 PM, Kuniyuki Iwashima wrote:
>   BPF_CALL_5(bpf_sock_create_getsockopt, struct sock *, sk, int, level,
>   	   int, optname, char *, optval, int, optlen)
>   {
> +	if (level == SOL_SOCKET && optname == SK_BPF_BYPASS_PROT_MEM)
> +		return sk_bpf_set_get_bypass_prot_mem(sk, optval, optlen, true);

The optval (ARG_PTR_TO_UNINIT_MEM) needs to be initialized for error case.
The __bpf_getsockopt below does that but it returns early here.
I changed to this:

	if (level == SOL_SOCKET && optname == SK_BPF_BYPASS_PROT_MEM) {
		int err = sk_bpf_set_get_bypass_prot_mem(sk, optval, optlen, true);

		if (err)
			memset(optval, 0, optlen);

		return err;
	}

> +
>   	return __bpf_getsockopt(sk, level, optname, optval, optlen);
>   }
>   
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 6829936d33f58..9b17d937edf73 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7200,6 +7200,7 @@ enum {
>   	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
>   	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
>   	SK_BPF_CB_FLAGS		= 1009, /* Get or set sock ops flags in socket */
> +	SK_BPF_BYPASS_PROT_MEM	= 1010, /* Get or Set sk->sk_bypass_prot_mem */
>   };
>   
>   enum {


