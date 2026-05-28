Return-Path: <netdev+bounces-292872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APn1LmPIGGqZnQgAu9opvQ
	(envelope-from <netdev+bounces-292872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:57:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 215765FB229
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32B5A305D5F7
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA14D3672A5;
	Thu, 28 May 2026 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="ZQcHhRoi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8298730567E
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780008906; cv=none; b=LKEQiznz2KAZQKoRo+YuV5y8tBBjdVmIDZxqpyLpXVp/S5s3lGN/49a9le1AOd6SQG5HHR60o4GweEeO3lzmGYkAUYYZjBB3yw0GPLzodB00tHe2dC7pFXHi8SZFBGgbjqRC+6mZe8kKSZpkCtnQmNf0o9TN4zidF3a3ksSdkK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780008906; c=relaxed/simple;
	bh=gtljMXsLt3yuATSOx6mN+Y1Zs+1DRSvC1XdeM0vs0f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jveg5lgA8R/sv9woZsaujKycelL5L/8WdIQ+vJZYpz1XqjH3zPJlyjiTgPMDZPTApVCWKPv40CecEDfyksEL59AoCGc4pypE7ygjIhru5XN/s7foV5AJrAC/CytTg+AY3TSeG3lz9uT+a3cyPgLUCAuACwkk7Dd21oR6cyK34KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=ZQcHhRoi; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304dc707c7eso93078eec.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 15:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1780008905; x=1780613705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+Bu3whT8wDoGy2urfE3+6z84iXvQgIkWagXFGYPZBs=;
        b=ZQcHhRoiGR38XJVF/n6G2Psao3II+34qFYoBDdFiVh9EfpFhbUwIBhURdWC4kZ8IfD
         ce7GBpdWersACKR7dFQP7kJcvm+7YTTzr79y9TbU1hlOBpbsFx8Swwrlwm4sksxZXWnM
         oNRyEtyq89SLGFPIIfqFf1LSiklec8Hccu8O7YoR+A5okWXJqfxQRuNDy2WWll30ZjCU
         4EafKsD5FQpiRj26IkWQ0/6RT8XzvR4nIZQzq2fNTQflLJZ6+Ia4KrlKhg31OTVgBzH2
         cTD6/h8ubuSmYjd1u5iT8pPx/1n+0MF6WeWCd7YQuzrnZKzx+WmwCMEQM+5gtOw/AaWT
         ZQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780008905; x=1780613705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+Bu3whT8wDoGy2urfE3+6z84iXvQgIkWagXFGYPZBs=;
        b=QZivWRWsMVDTXeKMszVNA9jqnbQ0NHJ4aRYJSYkL+R7L7Z76fIJDddEUqChlnp6Fte
         hfdsbKlZyi1dQwf5EdIJR2IVdWLI/HpottnfkPNzucrBY3MTl8CDuJYG59aFKRA0TLM1
         PCUHzw5FHkIuyQRZ0XJWtAIDsOLZGTWxe/sWKWvOho+nyHdjO/EujDNXStrDWCBojf+o
         52zhqihmKfS43q2LNPlcCsg1KEebBrDgQ2/Ff9QwO3/9uTAey6kziI8+8S9sl54g7O0B
         DF8afAlJFL5AV5vyhf6xtjq5E60BUO3pLDFdoJ3X4kAjU6sOsjLAzocESUstiIDbTCWe
         OuIw==
X-Forwarded-Encrypted: i=1; AFNElJ8C2WXc/gAcu8WBviMq7thNwStcZrHVwb22FHDrRSmPxIleQwcrP/U3+kDXeoUto2P9X/Trlc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVtjAlILOvRdBsbxkZi4jDA0RT8iinTRVF71YgQu5pHC7PU72v
	BafyH+G7TJisQ+zKOTS+ER2Nb6IM6QjMjx7p3A9SVI/RuzU/chTbyjz6uCWmjWdyFkI=
X-Gm-Gg: Acq92OHNkc8SE5d0j3vX4+iT8rXWfk01RIzrMpWMY1H94uQu3BQvPjIQYOyWCf/WUEt
	Z46Aot8HUQpKaWBrTjwXTX0qpcu2HcqR/W26wQBpjksJOVpQ7EqpbDwiuCsIlGEsoizgo9NAgyH
	poiByk0gFBG23m3ZbSSWe8jEUeBZ7Eyp7PaAEoG28PcLAAC5Pu8ZfvccSQBSerEDzMopBuayq+0
	X3yinSCOm095YZzXUHXyIeyVmY3Ys+kGMNVgAdQyCHL3btHrSPrO2rkjbDB0cvjG3QAYl/fskdO
	b2gmj/SY/llEfSkPeGMNfpDGKM7Ajzg+7DUKesaU7VIKDaf4GMxPfY6KlIb1aku5YizR4+ci/uq
	8WSINc4ufAmk/uwy2ohcl+TpU+sbj+6rqY9SyVGswqbgD0JI0bom8KxYAnLDfoMdE3gY88TwdYi
	M6uy68+LE7ZGpwd4KIaE2YqnuX
X-Received: by 2002:a05:7300:5b9e:b0:2da:a813:a629 with SMTP id 5a478bee46e88-304eadf06bfmr126990eec.2.1780008904637;
        Thu, 28 May 2026 15:55:04 -0700 (PDT)
Received: from m2 ([83.171.251.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304eb9cea7fsm172041eec.9.2026.05.28.15.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:55:04 -0700 (PDT)
Date: Thu, 28 May 2026 15:55:02 -0700
From: Jordan Rife <jordan@jrife.io>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net, 
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH bpf-next v7 2/7] net: move netfilter
 nf_reject6_fill_skb_dst to core ipv6
Message-ID: <gh2qntycqbbsaotyrzisuvv7nqckehtiz25negdykjdvnewv3h@zquvaw6h5dq5>
References: <20260526153708.279717-1-mahe.tardy@gmail.com>
 <20260526153708.279717-3-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526153708.279717-3-mahe.tardy@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[jrife-io.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292872-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[jrife.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,gmail.com,kernel.org,google.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[jrife-io.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jrife.io:email,jrife-io.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 215765FB229
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 03:37:03PM +0000, Mahe Tardy wrote:
> Move and rename nf_reject6_fill_skb_dst from
> ipv6/netfilter/nf_reject_ipv6 to ip6_route_reply_fill_dst in
> ipv6/route.c so that it can be reused in the following patches by BPF
> kfuncs.
> 
> Netfilter uses nf_ip6_route that is almost a transparent wrapper around
> ip6_route_output so this patch inlines it.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  include/net/ip6_route.h             |  2 ++
>  net/ipv6/netfilter/nf_reject_ipv6.c | 17 +----------------
>  net/ipv6/route.c                    | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> index 09ffe0f13ce7..eb5a60d3babe 100644
> --- a/include/net/ip6_route.h
> +++ b/include/net/ip6_route.h
> @@ -100,6 +100,8 @@ static inline struct dst_entry *ip6_route_output(struct net *net,
>  	return ip6_route_output_flags(net, sk, fl6, 0);
>  }
> 
> +int ip6_route_reply_fill_dst(struct sk_buff *skb);
> +
>  /* Only conditionally release dst if flags indicates
>   * !RT6_LOOKUP_F_DST_NOREF or dst is in uncached_list.
>   */
> diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
> index ef5b7e85cffa..7d2f577e72b8 100644
> --- a/net/ipv6/netfilter/nf_reject_ipv6.c
> +++ b/net/ipv6/netfilter/nf_reject_ipv6.c
> @@ -293,21 +293,6 @@ nf_reject_ip6_tcphdr_put(struct sk_buff *nskb,
>  						   sizeof(struct tcphdr), 0));
>  }
> 
> -static int nf_reject6_fill_skb_dst(struct sk_buff *skb_in)
> -{
> -	struct dst_entry *dst = NULL;
> -	struct flowi fl;
> -
> -	memset(&fl, 0, sizeof(struct flowi));
> -	fl.u.ip6.daddr = ipv6_hdr(skb_in)->saddr;
> -	nf_ip6_route(dev_net(skb_in->dev), &dst, &fl, false);
> -	if (!dst)
> -		return -1;
> -
> -	skb_dst_set(skb_in, dst);
> -	return 0;
> -}
> -
>  void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
>  		    int hook)
>  {
> @@ -440,7 +425,7 @@ void nf_send_unreach6(struct net *net, struct sk_buff *skb_in,
>  	if (hooknum == NF_INET_LOCAL_OUT && skb_in->dev == NULL)
>  		skb_in->dev = net->loopback_dev;
> 
> -	if (!skb_dst(skb_in) && nf_reject6_fill_skb_dst(skb_in) < 0)
> +	if (!skb_dst(skb_in) && ip6_route_reply_fill_dst(skb_in) < 0)
>  		return;
> 
>  	icmpv6_send(skb_in, ICMPV6_DEST_UNREACH, code, 0);
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index e3d355d1fbd6..37a7627a94de 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -2725,6 +2725,24 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
>  }
>  EXPORT_SYMBOL_GPL(ip6_route_output_flags);
> 
> +int ip6_route_reply_fill_dst(struct sk_buff *skb)
> +{
> +	struct dst_entry *result;
> +	struct flowi6 fl = {
> +		.daddr = ipv6_hdr(skb)->saddr
> +	};
> +	int err;
> +
> +	result = ip6_route_output(dev_net(skb->dev), NULL, &fl);
> +	err = result->error;
> +	if (err)
> +		dst_release(result);
> +	else
> +		skb_dst_set(skb, result);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(ip6_route_reply_fill_dst);
> +
>  struct dst_entry *ip6_blackhole_route(struct net *net, struct dst_entry *dst_orig)
>  {
>  	struct rt6_info *rt, *ort = dst_rt6_info(dst_orig);
> --
> 2.34.1
> 

Reviewed-by: Jordan Rife <jordan@jrife.io>

