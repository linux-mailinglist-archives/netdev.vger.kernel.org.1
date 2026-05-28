Return-Path: <netdev+bounces-292871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE5TNUzIGGqZnQgAu9opvQ
	(envelope-from <netdev+bounces-292871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:57:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0B65FB222
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F7E831155F7
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A247368276;
	Thu, 28 May 2026 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="T07ZFvxo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A961368D76
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780008892; cv=none; b=LCoz8j46++Iytc5u/p+ebEgoCe1R79ncacgnWLDWWhwi0NUPy1WfsCd+MYYyA5ERLrjHrvO86j63nkd3OIHFq/bDxggpi+t06TW2Hscq0a+S8uyQQoltKerzAeniWf7QGzWvgxNv3vlHrIRvCpXLj9cn+Sq/U2SupOyEO6QJZ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780008892; c=relaxed/simple;
	bh=CkIgU+9p9BfiCkr8KKIac0MYY7FTP/DUbBoGj0dhHrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+YWJb88zRc4DOsuJb4u9kYkZWKnvOl7gemBk5tm45j8lKDB2D3JcHjdPwXgRYkzU4dOSb3JbBu0GPKQpO6G6SSOU8+MD2jrhDu0wJjLv1ooBMf06JGMTSf8V10Pgn1+lxvfYA+viwh3V9QA/QJo8VeQigVhyx73QHOcr0aNuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=T07ZFvxo; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304eb0fc233so14707eec.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 15:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1780008889; x=1780613689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eVZ4DejMwq9y5/TGGt0Qr2Xm4AzQr3mA1ghIFaC058=;
        b=T07ZFvxoSRswgnTAKD7m62ZuUCYnDuQvlJx0JfoN+Y9nMCscibM4usYiq8YgqJYne0
         JbM1DJrmdRzBle7DVEQnwcIdi4alvQyXftpuHvkPumMO4kNkNpjgDACMwe0elhxgWABp
         jGndyO6MMXvrk0UoPxefZEEg2NRHiKwWZVGKZgNQmMeEZ5GZhFMBYg4EMGHkGEWqBm5R
         1TC4SRmAFjEMH0yLP0COWZWg1mN33XKrEtp/EvjfH61Pb39ZOinL+BqrLrH0VDVyQP5d
         nF0OlzgFvawV3JHzqm2LgSp3Ei4wkEf0WBVQo9UFblsX0ki6bKY4Jt73X5lYGbfWNRSJ
         47hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780008889; x=1780613689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eVZ4DejMwq9y5/TGGt0Qr2Xm4AzQr3mA1ghIFaC058=;
        b=VQ+l8ehn9NCkA7/I3LTWJZKKbTwJ+xqHWfRCSTcHQF0LL2hu9V5wVba+v7vwxFfbyy
         IgDalcELc+FXCaJ//pvsZHOV0vMLOElJ+AYBQdrlA/+jk80MVDGDw1uOliALKoB1IzMX
         xmVJvcX3k0DBnLMMZW8HKT+bPi5ukuztUlXC4gSRQe6IMoNl95+lWkD1sWUjja1wTdYm
         v7b3jn07/L/DKjxBG9ySjEoPOuIdB4nTq8uYnTV93gve1+z1m/kmgofd/NL0xRVQwf4w
         Vl3H44j6TOj4MmxpEcx8LISZm+SPMVM6ufxvK02C1zkPKd7EEaiXfalMgLBcSHoYi7mv
         yZIw==
X-Forwarded-Encrypted: i=1; AFNElJ87p5B0XaVXuFCW4B6D//wgoQZQfcP7U7XQAuomixY2DmujLKSvMy4k7R0slZXjn7TpSdg50wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwYC2h1xDodOUiMRh4OnBnHS55LujNKqFOjojQY99O0ANlS4Ar
	clHy836A21yOrJ7DJngcsnPbx4OrDC++AqHVkmIzSjvNLwD9YWyeU3C3l+nOtkGs2ms=
X-Gm-Gg: Acq92OGqTjm9L0kSx7lb/qmuL6vSoIa5fn8K/t/SU0oXsxVA8JoRfKo0UK1XPc/6lrT
	8DZvkJ3IQQMsD3jFgLujV6tpMAt2QsFq2sbuDyvaf0uUsBldpI6VES+TQFkY/xylU0sJ9iB4cuF
	kGu2sXhBgtkQ8DnIcFN3dKHGEW6yQLtb2A8NJwlVaivFGOplJqJPleQ1vGUgZFojbF7cZyU9lnc
	hcWrMO8o+wb/c04O6BrhSaIJixdQHrDQHpIov9pt5fMiLQ3uK3bQ5KbAZgV9Vi5JOwJvcykAJa1
	UIEBEZevVgbU/7T1T0h4ypE14K5sK2wbiBjHAnpSCnGdyvk37Oc38wwrjfGbjQ1p0y6D4+i3r6i
	FPVEIyj2ZxDtGGRSg2TUYzasYQqq+/In80GS7apNHq4d2AkkO0yuKTZRsS4+bDWpR4csnraT0Lp
	07ezMinMsG1fNwVWiclTrzu2oAD8mBBh6wbmM=
X-Received: by 2002:a05:7301:4186:b0:2ea:5057:a320 with SMTP id 5a478bee46e88-304eb0f1c17mr99701eec.2.1780008888653;
        Thu, 28 May 2026 15:54:48 -0700 (PDT)
Received: from m2 ([83.171.251.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304eb9975b7sm181947eec.6.2026.05.28.15.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:54:48 -0700 (PDT)
Date: Thu, 28 May 2026 15:54:46 -0700
From: Jordan Rife <jordan@jrife.io>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net, 
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH bpf-next v7 1/7] net: move netfilter
 nf_reject_fill_skb_dst to core ipv4
Message-ID: <46rav7qeseaysu5tlzvkst2ukbqgzj5nyk5joar4pnlokj5e6o@4fh4loahchyi>
References: <20260526153708.279717-1-mahe.tardy@gmail.com>
 <20260526153708.279717-2-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526153708.279717-2-mahe.tardy@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-292871-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 3A0B65FB222
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 03:37:02PM +0000, Mahe Tardy wrote:
> Move and rename nf_reject_fill_skb_dst from
> ipv4/netfilter/nf_reject_ipv4 to ip_route_reply_fill_dst in ipv4/route.c
> so that it can be reused in the following patches by BPF kfuncs.
> 
> Netfilter uses nf_ip_route that is almost a transparent wrapper around
> ip_route_output_key so this patch inlines it.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  include/net/route.h                 |  1 +
>  net/ipv4/netfilter/nf_reject_ipv4.c | 19 ++-----------------
>  net/ipv4/route.c                    | 15 +++++++++++++++
>  3 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/include/net/route.h b/include/net/route.h
> index f90106f383c5..300d292cd9a1 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -173,6 +173,7 @@ struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
>  				    const struct sock *sk);
>  struct dst_entry *ipv4_blackhole_route(struct net *net,
>  				       struct dst_entry *dst_orig);
> +int ip_route_reply_fill_dst(struct sk_buff *skb);
> 
>  static inline struct rtable *ip_route_output_key(struct net *net, struct flowi4 *flp)
>  {
> diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
> index fecf6621f679..c1c0724e4d4d 100644
> --- a/net/ipv4/netfilter/nf_reject_ipv4.c
> +++ b/net/ipv4/netfilter/nf_reject_ipv4.c
> @@ -252,21 +252,6 @@ static void nf_reject_ip_tcphdr_put(struct sk_buff *nskb, const struct sk_buff *
>  	nskb->csum_offset = offsetof(struct tcphdr, check);
>  }
> 
> -static int nf_reject_fill_skb_dst(struct sk_buff *skb_in)
> -{
> -	struct dst_entry *dst = NULL;
> -	struct flowi fl;
> -
> -	memset(&fl, 0, sizeof(struct flowi));
> -	fl.u.ip4.daddr = ip_hdr(skb_in)->saddr;
> -	nf_ip_route(dev_net(skb_in->dev), &dst, &fl, false);
> -	if (!dst)
> -		return -1;
> -
> -	skb_dst_set(skb_in, dst);
> -	return 0;
> -}
> -
>  /* Send RST reply */
>  void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
>  		   int hook)
> @@ -279,7 +264,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
>  	if (!oth)
>  		return;
> 
> -	if (!skb_dst(oldskb) && nf_reject_fill_skb_dst(oldskb) < 0)
> +	if (!skb_dst(oldskb) && ip_route_reply_fill_dst(oldskb) < 0)
>  		return;
> 
>  	if (skb_rtable(oldskb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
> @@ -352,7 +337,7 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
>  	if (iph->frag_off & htons(IP_OFFSET))
>  		return;
> 
> -	if (!skb_dst(skb_in) && nf_reject_fill_skb_dst(skb_in) < 0)
> +	if (!skb_dst(skb_in) && ip_route_reply_fill_dst(skb_in) < 0)
>  		return;
> 
>  	if (skb_csum_unnecessary(skb_in) ||
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index bc1296f0ea69..1f031c5ef554 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -2945,6 +2945,21 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
>  }
>  EXPORT_SYMBOL_GPL(ip_route_output_flow);
> 
> +int ip_route_reply_fill_dst(struct sk_buff *skb)
> +{
> +	struct rtable *rt;
> +	struct flowi4 fl4 = {
> +		.daddr = ip_hdr(skb)->saddr
> +	};
> +
> +	rt = ip_route_output_key(dev_net(skb->dev), &fl4);
> +	if (IS_ERR(rt))
> +		return PTR_ERR(rt);
> +	skb_dst_set(skb, &rt->dst);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ip_route_reply_fill_dst);
> +
>  /* called with rcu_read_lock held */
>  static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
>  			struct rtable *rt, u32 table_id, dscp_t dscp,
> --
> 2.34.1
> 

Reviewed-by: Jordan Rife <jordan@jrife.io>

