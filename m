Return-Path: <netdev+bounces-271219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOGWDZXUwmllmgQAu9opvQ
	(envelope-from <netdev+bounces-271219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:14:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A0531A94E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6882E30AE935
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4229438C2D7;
	Tue, 24 Mar 2026 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RquFiSa7"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7875438911A
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375984; cv=none; b=FehGaOS9wIgphSf+Doqn+3/g8xhrAtvX1u1+zqYCk0wEiMRs3+lC01x1hia7yVdsRaL+aEJK2ERqIOGdJouu8ii21wmMfr0tonDezLs9N7+g+s+Jshi9JnljKZi9yyRaW1GZDZfnXv/JwrwmjbzGYeMm3CfPZp+/lGgA5k2umCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375984; c=relaxed/simple;
	bh=gogaLhmzjeMdjLJmR+30oDMpSwBI3O0me8wxujtONII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7sVW9AbJS0i3deXjuuuDLr/YL6GiihfYHkhenPjgfKxbBMkAX+47Ank1Kt50d5cgnMWShnWRjythwsoz18WUlAflh2d1g2FmVcdlXBD7j+P17QahwjVo9+wUmMBzv05d7R0L43tSxnpN8mGdchw0CfitolBREqondQokKBT/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RquFiSa7; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f0f271ae-4d4c-4d52-8670-a14204da437d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774375979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8EL19L491G0HDzBug1MJZdxH8m2EyauqFp/7/0yep3s=;
	b=RquFiSa7RT6UeyDrcOpgmOP1WKmiWsvPKwAFC/NzhjDdh2G1Uu/vhQdNPPLoK2QVh2UucP
	zpwgBRt4QD7rRrvSxGcLZvBSdNQVa55knxoS+8r4Izh+iXDjno4ZdVTZHHp46oFGM1jLny
	DlDoDV8hOCqWKOJw36uoYuysdUHBz0o=
Date: Tue, 24 Mar 2026 11:12:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/5] bpf: add helper masks for ADJ_ROOM flags and encap
 validation
To: Nick Hudson <nhudson@akamai.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Max Tottenham <mtottenh@akamai.com>, Anna Glasgall <aglasgal@akamai.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-4-nhudson@akamai.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260318134242.2725749-4-nhudson@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271219-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,akamai.com:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 90A0531A94E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/26 6:42 AM, Nick Hudson wrote:
> Introduce helper masks for bpf_skb_adjust_room() flags to simplify
> validation logic:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_MASK
> - BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK
> - BPF_F_ADJ_ROOM_ENCAP_MASK
> - BPF_F_ADJ_ROOM_DECAP_MASK
> 
> Add flag validation to bpf_skb_net_grow() to reject invalid encap
> flags early. Refactor existing validation checks in bpf_skb_net_shrink()
> and bpf_skb_adjust_room() to use the new masks (no behavior change).
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> ---
>   net/core/filter.c | 31 +++++++++++++++++++++++--------
>   1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 0d5d5a17acb2..7c2871b40fe4 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3483,14 +3483,25 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
>   #define BPF_F_ADJ_ROOM_DECAP_L3_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
>   					 BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>   
> -#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
> -					 BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
> +#define BPF_F_ADJ_ROOM_DECAP_L4_MASK	(BPF_F_ADJ_ROOM_DECAP_L4_UDP | \
> +					 BPF_F_ADJ_ROOM_DECAP_L4_GRE)
> +
> +#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK	(BPF_F_ADJ_ROOM_DECAP_IPXIP4 | \
> +					 BPF_F_ADJ_ROOM_DECAP_IPXIP6)
> +
> +#define BPF_F_ADJ_ROOM_ENCAP_MASK	(BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
>   					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
>   					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
>   					 BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
>   					 BPF_F_ADJ_ROOM_ENCAP_L2( \
> -					  BPF_ADJ_ROOM_ENCAP_L2_MASK) | \
> -					 BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> +					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
> +
> +#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> +
> +#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
> +					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
> +					 BPF_F_ADJ_ROOM_DECAP_MASK | \
> +					 BPF_F_ADJ_ROOM_NO_CSUM_RESET)

The patch does two things: refactoring of existing macros 
(BPF_F_ADJ_ROOM_ENCAP_MASK, BPF_F_ADJ_ROOM_DECAP_MASK) and new additions 
(BPF_F_ADJ_ROOM_DECAP_L4_MASK, BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) that 
depend on the new flags from the UAPI changes in patch 2.

The refactoring does not depend on the new UAPI flags and could be a 
separate patch placed earlier in the series. That way a reviewer can 
verify it is a no-op without the new flag additions getting in
the way. The (BPF_F_ADJ_ROOM_DECAP_L4_MASK, 
BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) can be introduced together in patch 4 
when it is first used.

>   
>   static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>   			    u64 flags)
> @@ -3502,6 +3513,11 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>   	unsigned int gso_type = SKB_GSO_DODGY;
>   	int ret;
>   
> +	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_ENCAP_MASK |
> +			       BPF_F_ADJ_ROOM_NO_CSUM_RESET |
> +			       BPF_F_ADJ_ROOM_FIXED_GSO)))

Under which case this new check will be hit?

> +		return -EINVAL;
> +
>   	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
>   		/* udp gso_size delineates datagrams, only allow if fixed */
>   		if (!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ||
> @@ -3611,8 +3627,8 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>   {
>   	int ret;
>   
> -	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
> -			       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
> +	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_DECAP_MASK |
> +			       BPF_F_ADJ_ROOM_FIXED_GSO |
>   			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
>   		return -EINVAL;
>   
> @@ -3708,8 +3724,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
>   	u32 off;
>   	int ret;
>   
> -	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_MASK |
> -			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
> +	if (unlikely(flags & ~BPF_F_ADJ_ROOM_MASK))
>   		return -EINVAL;
>   	if (unlikely(len_diff_abs > 0xfffU))
>   		return -EFAULT;


