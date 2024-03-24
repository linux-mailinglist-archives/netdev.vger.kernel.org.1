Return-Path: <netdev+bounces-81427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A69F887E29
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 18:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D301F21113
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 17:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64F5199BA;
	Sun, 24 Mar 2024 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElklL+g8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8EA2F58;
	Sun, 24 Mar 2024 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711301926; cv=none; b=N7MxJPphfrRgkEetC9mCybHjhWdbrdYsHkr/XkpJQFczofXCAcP60M2ci2bMZo07bRuIuQB9S6jiJj0dzrM8r+gwmML+kta157HISJUExT+X2PcK/IwQu74GGSrQnmMIIevkSWJfpodslwXlH5cJfqhn4c67HKraIB4I8lb4jWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711301926; c=relaxed/simple;
	bh=Xuo9iLujSVYahCKtcdJNWWrcUGj1LDtoCClBFrSIwUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLC/9DczSigYyzC8+HXQnleYabqRbfR1gCvJQ2nFAYn0YX9rx713EY9ENtre+TUjOt4zsDdNo8PP548XCLJfe1MOzvjewekN7pAiigmwE9fCldmwjtGUXl0HRutcZwE+UTUUIld5XvKodI/wdzA/nKvk125UUr6CcmepFam8Ddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElklL+g8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9F8C433F1;
	Sun, 24 Mar 2024 17:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711301926;
	bh=Xuo9iLujSVYahCKtcdJNWWrcUGj1LDtoCClBFrSIwUI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ElklL+g84w+2q1GcQNMWDmPCK9JNyBKISWE0HMzyNgX1vsJI4LH3Q0t5Okaz+RL10
	 3xNTECu7o16HkuZTSb0vei53Zm9RkcXeS7WIqKjtYwWfUOM39hrkJZIucu+CFp1IHa
	 kl9JQMBQmnK/hZWNxg4yHznehSIr/rjbPaYubAvqeubWFttmhRcSt9KJbxLgkTz+k7
	 hHdExmzsQ35XVUbtst22qIR1bF9eloQwlnnTSORlRSlZZ08hWxXuQUT9WmNRClTnqW
	 9oPiYEQEuWajpfKtSpXx+7M+4Vn2LXl+CvlUlYOZ+k8K3b8n0ECWQ8tYpBJyIz+PDH
	 3n6nhCPmbeRFQ==
Message-ID: <6879f076-ff73-496c-84be-a18b639f94f0@kernel.org>
Date: Sun, 24 Mar 2024 11:38:44 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 bpf-next 1/2] bpf: add support for passing mark with
 bpf_fib_lookup
Content-Language: en-US
To: Anton Protopopov <aspsk@isovalent.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev
 <sdf@google.com>, bpf@vger.kernel.org
Cc: Rumen Telbizov <rumen.telbizov@menlosecurity.com>, netdev@vger.kernel.org
References: <20240322140244.50971-1-aspsk@isovalent.com>
 <20240322140244.50971-2-aspsk@isovalent.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240322140244.50971-2-aspsk@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/24 8:02 AM, Anton Protopopov wrote:
> Extend the bpf_fib_lookup() helper by making it to utilize mark if
> the BPF_FIB_LOOKUP_MARK flag is set. In order to pass the mark the
> four bytes of struct bpf_fib_lookup are used, shared with the
> output-only smac/dmac fields.
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/uapi/linux/bpf.h       | 20 ++++++++++++++++++--
>  net/core/filter.c              | 12 +++++++++---
>  tools/include/uapi/linux/bpf.h | 20 ++++++++++++++++++--
>  3 files changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 9585f5345353..96d57e483133 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3394,6 +3394,10 @@ union bpf_attr {
>   *			for the nexthop. If the src addr cannot be derived,
>   *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned. In this
>   *			case, *params*->dmac and *params*->smac are not set either.
> + *		**BPF_FIB_LOOKUP_MARK**
> + *			Use the mark present in *params*->mark for the fib lookup.
> + *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
> + *			as it only has meaning for full lookups.
>   *
>   *		*ctx* is either **struct xdp_md** for XDP programs or
>   *		**struct sk_buff** tc cls_act programs.
> @@ -7120,6 +7124,7 @@ enum {
>  	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
>  	BPF_FIB_LOOKUP_TBID    = (1U << 3),
>  	BPF_FIB_LOOKUP_SRC     = (1U << 4),
> +	BPF_FIB_LOOKUP_MARK    = (1U << 5),
>  };
>  
>  enum {
> @@ -7197,8 +7202,19 @@ struct bpf_fib_lookup {
>  		__u32	tbid;
>  	};
>  
> -	__u8	smac[6];     /* ETH_ALEN */
> -	__u8	dmac[6];     /* ETH_ALEN */
> +	union {
> +		/* input */
> +		struct {
> +			__u32	mark;   /* policy routing */
> +			/* 2 4-byte holes for input */
> +		};
> +
> +		/* output: source and dest mac */
> +		struct {
> +			__u8	smac[6];	/* ETH_ALEN */
> +			__u8	dmac[6];	/* ETH_ALEN */
> +		};
> +	};
>  };
>  
>  struct bpf_redir_neigh {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 0c66e4a3fc5b..1205dd777dc2 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5884,7 +5884,10 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>  
>  		err = fib_table_lookup(tb, &fl4, &res, FIB_LOOKUP_NOREF);
>  	} else {
> -		fl4.flowi4_mark = 0;
> +		if (flags & BPF_FIB_LOOKUP_MARK)
> +			fl4.flowi4_mark = params->mark;
> +		else
> +			fl4.flowi4_mark = 0;
>  		fl4.flowi4_secid = 0;
>  		fl4.flowi4_tun_key.tun_id = 0;
>  		fl4.flowi4_uid = sock_net_uid(net, NULL);
> @@ -6027,7 +6030,10 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>  		err = ipv6_stub->fib6_table_lookup(net, tb, oif, &fl6, &res,
>  						   strict);
>  	} else {
> -		fl6.flowi6_mark = 0;
> +		if (flags & BPF_FIB_LOOKUP_MARK)
> +			fl6.flowi6_mark = params->mark;
> +		else
> +			fl6.flowi6_mark = 0;
>  		fl6.flowi6_secid = 0;
>  		fl6.flowi6_tun_key.tun_id = 0;
>  		fl6.flowi6_uid = sock_net_uid(net, NULL);
> @@ -6105,7 +6111,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>  
>  #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
>  			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
> -			     BPF_FIB_LOOKUP_SRC)
> +			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK)
>  
>  BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
>  	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index bf80b614c4db..4c9b5bfbd9c6 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -3393,6 +3393,10 @@ union bpf_attr {
>   *			for the nexthop. If the src addr cannot be derived,
>   *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned. In this
>   *			case, *params*->dmac and *params*->smac are not set either.
> + *		**BPF_FIB_LOOKUP_MARK**
> + *			Use the mark present in *params*->mark for the fib lookup.
> + *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
> + *			as it only has meaning for full lookups.
>   *
>   *		*ctx* is either **struct xdp_md** for XDP programs or
>   *		**struct sk_buff** tc cls_act programs.
> @@ -7119,6 +7123,7 @@ enum {
>  	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
>  	BPF_FIB_LOOKUP_TBID    = (1U << 3),
>  	BPF_FIB_LOOKUP_SRC     = (1U << 4),
> +	BPF_FIB_LOOKUP_MARK    = (1U << 5),
>  };
>  
>  enum {
> @@ -7196,8 +7201,19 @@ struct bpf_fib_lookup {
>  		__u32	tbid;
>  	};
>  
> -	__u8	smac[6];     /* ETH_ALEN */
> -	__u8	dmac[6];     /* ETH_ALEN */
> +	union {
> +		/* input */
> +		struct {
> +			__u32	mark;   /* policy routing */
> +			/* 2 4-byte holes for input */
> +		};
> +
> +		/* output: source and dest mac */
> +		struct {
> +			__u8	smac[6];	/* ETH_ALEN */
> +			__u8	dmac[6];	/* ETH_ALEN */
> +		};
> +	};
>  };
>  
>  struct bpf_redir_neigh {

It would be good to add

static_assert(sizeof(struct bpf_fib_lookup) == 64, "bpf_fib_lookup size
check");

to ensure this struct never exceeds a cacheline.

The patch itself looks good to me:

Reviewed-by: David Ahern <dsahern@kernel.org>


