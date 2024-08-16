Return-Path: <netdev+bounces-119263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C296955016
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5981C2258F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9FC1C231B;
	Fri, 16 Aug 2024 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1hiL2CM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FA11C2301;
	Fri, 16 Aug 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829760; cv=none; b=nH9PPrJ1M0mqALRjyBflspeT/gLD0XOM9Yd4NGt7h9KVE7jwmZaZMQqzOZZMc0qdEc+hsPsgMr5cVSvA65OH05DYh6SQDeRlf7isB8Mt3cqF8mv805mrCCvVOSVNxcvNTJcF2WBC1tCX3LaLN/Z7Vb6CLOORG8KabzWyPXRfbi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829760; c=relaxed/simple;
	bh=lYv635/C4u6qQuwam5UQqVyzGASCueQpeeh4rKMWfHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oe5oxZ2943fPMDIdgJci+DkWZ6eZJgKHnMgK4mfPXpBoem6SW3+uRmVCnxtDwkP/CUeqYoeIEobVfkaFBMCPgt/IGAaeLMM4JgEXCjyX5/OU2tsQ28oXXFtynNADft/Wf2CKaL3daCveErL4O9hTz5FF0edXmkSmfDgPKpKWP+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1hiL2CM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B46FC32782;
	Fri, 16 Aug 2024 17:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723829759;
	bh=lYv635/C4u6qQuwam5UQqVyzGASCueQpeeh4rKMWfHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y1hiL2CMp8YUuSirri2XHCUh3ffj3E6dI3Y5pv+z/SAkFfc2caFEEdX3OdqxkYENS
	 qOwE9JeGI89WiLnP1SiwI+mq4cXhXU2h921NQo4bKAOYcSE+RDm2Vb+S97FW739+4m
	 4VcywQQnFbgMKmYK/yoib4N7EQKbFIR3BTkaZpydEHYbtQvKbQJeAMvJ0Rd2gtcR2I
	 XbHTwvVdsKz4GN81qapT0vI9X4mqJSPrt7uQcqmXzvMkMV7pwZb2Mp31RG1ZxAvlhZ
	 zY3q9VBmJCRVFG5OKjbsWmZAC2i30ITNF16nJUGqihF1qEdg3YD3NU3prMO74+kcKJ
	 AOBOUmOX/LQRA==
Date: Fri, 16 Aug 2024 10:35:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: ipv6: ioam6: new feature tunsrc
Message-ID: <20240816103558.16502b74@kernel.org>
In-Reply-To: <20240813122723.22169-3-justin.iurman@uliege.be>
References: <20240813122723.22169-1-justin.iurman@uliege.be>
	<20240813122723.22169-3-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 14:27:23 +0200 Justin Iurman wrote:
> This patch provides a new feature (i.e., "tunsrc") for the tunnel (i.e.,
> "encap") mode of ioam6. Just like seg6 already does, except it is
> attached to a route. The "tunsrc" is optional: when not provided (by
> default), the automatic resolution is applied. Using "tunsrc" when
> possible has a benefit: performance. See the comparison:
>  - before (= "encap" mode): https://ibb.co/bNCzvf7
>  - after (= "encap" mode with "tunsrc"): https://ibb.co/PT8L6yq

No need to extend the selftests ?

> diff --git a/include/uapi/linux/ioam6_iptunnel.h b/include/uapi/linux/ioam6_iptunnel.h
> index 38f6a8fdfd34..6cdbd0da7ad8 100644
> --- a/include/uapi/linux/ioam6_iptunnel.h
> +++ b/include/uapi/linux/ioam6_iptunnel.h
> @@ -50,6 +50,13 @@ enum {
>  	IOAM6_IPTUNNEL_FREQ_K,		/* u32 */
>  	IOAM6_IPTUNNEL_FREQ_N,		/* u32 */
>  
> +	/* Tunnel src address.
> +	 * For encap,auto modes.
> +	 * Optional (automatic if
> +	 * not provided).

The wrapping of this text appears excessive

> +	 */
> +	IOAM6_IPTUNNEL_SRC,		/* struct in6_addr */
> +
>  	__IOAM6_IPTUNNEL_MAX,
>  };

> @@ -178,6 +186,23 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
>  	ilwt->freq.n = freq_n;
>  
>  	ilwt->mode = mode;
> +
> +	if (!tb[IOAM6_IPTUNNEL_SRC]) {
> +		ilwt->has_tunsrc = false;
> +	} else {
> +		ilwt->has_tunsrc = true;
> +		ilwt->tunsrc = nla_get_in6_addr(tb[IOAM6_IPTUNNEL_SRC]);
> +
> +		if (ipv6_addr_any(&ilwt->tunsrc)) {
> +			dst_cache_destroy(&ilwt->cache);
> +			kfree(lwt);

Let's put the cleanup at the end of the function, and use a goto / label
to jump there.

> +			NL_SET_ERR_MSG_ATTR(extack, tb[IOAM6_IPTUNNEL_SRC],
> +					    "invalid tunnel source address");
> +			return -EINVAL;
> +		}
> +	}
> +
>  	if (tb[IOAM6_IPTUNNEL_DST])
>  		ilwt->tundst = nla_get_in6_addr(tb[IOAM6_IPTUNNEL_DST]);
>  
> @@ -257,6 +282,8 @@ static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
>  
>  static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
>  			  struct ioam6_lwt_encap *tuninfo,
> +			  bool has_tunsrc,
> +			  struct in6_addr *tunsrc,
>  			  struct in6_addr *tundst)
>  {
>  	struct dst_entry *dst = skb_dst(skb);
> @@ -286,8 +313,13 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
>  	hdr->nexthdr = NEXTHDR_HOP;
>  	hdr->payload_len = cpu_to_be16(skb->len - sizeof(*hdr));
>  	hdr->daddr = *tundst;
> -	ipv6_dev_get_saddr(net, dst->dev, &hdr->daddr,
> -			   IPV6_PREFER_SRC_PUBLIC, &hdr->saddr);
> +
> +	if (has_tunsrc) {
> +		memcpy(&hdr->saddr, tunsrc, sizeof(*tunsrc));
> +	} else {
> +		ipv6_dev_get_saddr(net, dst->dev, &hdr->daddr,
> +				   IPV6_PREFER_SRC_PUBLIC, &hdr->saddr);
> +	}

single statement branches, no need for {}

>  	skb_postpush_rcsum(skb, hdr, len);
>  

