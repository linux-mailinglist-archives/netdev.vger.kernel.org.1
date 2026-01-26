Return-Path: <netdev+bounces-253593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wORKJEXOd2mxlQEAu9opvQ
	(envelope-from <netdev+bounces-253593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:27:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE31F8D0FA
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3D903009B3A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FD62D5926;
	Mon, 26 Jan 2026 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBAM8N2F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD984285C8C
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459199; cv=none; b=qGFNTWqFlaJi6fYEIhQnoc8z8M23yd7qrzdQ2B6o7n2GUFABBgCcm6zgNq/08PWsPzc0rbuxou/ZAkLxcEKQwa1b8abFERdwbnDsrhNJweBHJ+PaKAVgbVZEUKoqS1drifWt150u6X5GimQXcP3RpROZppoiH5DywGtBcnhmeOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459199; c=relaxed/simple;
	bh=QojildKJVNfOzJ2FA2VbQreb53+szZ8jOJA25sDd4MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxBpLE6+U06QleYyMPlv8n8gzXopnljs0VNBcA3KWVCN4fBHUV6WXtfrP3Kn8ussJab5ZVTkEJo/doNYKVv1jwi7LtFjCh24hg5MLH2y7SqMeWT6yfCR6ukOJWBXbXgQMbF908mpFS5KtsLsWJ/Kh1YDjCpxqqL9x+dzDS8nlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBAM8N2F; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78fba1a1b1eso73980557b3.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 12:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769459197; x=1770063997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K+77MEX92w21ydV8W8Ch081Vt4q/87vkSywxoRlWdug=;
        b=IBAM8N2FMck07wgKXakVwZT0f40Cce7D7L9f/h/u5LM/L0LsE+Wqfex2tyqyiu2Pcj
         nmjZfNFFqK6WxCtgEe2lLlEgjLI4zTUfKZFgcmkh1GBNy/uiddPDwD3tsW1BEZw4Ol0H
         tk798vxp+Yc6WaE/Al8WJRUNT+0l0Xyw1WHVTObjP48s1vBvLDs9eZ9Q9Q9sJ3263Hem
         o6DNw4FPGZys+SkrDPwMZKQY0j3Nfed9QBFg2KHqjO9XwZX5rOl6+d9O2gSKUt9ohdX5
         Lp4bcPX+TYojc7EQdYjau5+AxydmOERtLrk6hnmJE/A5rEu8D+zaYaYYLLyR3Wnamuuk
         rbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769459197; x=1770063997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+77MEX92w21ydV8W8Ch081Vt4q/87vkSywxoRlWdug=;
        b=u2EQBpP+yenZczphjkPs3YMGX/Ftt8llzCl66GpwHpYrZ7/1zMYUdWiHyzJ8O5wPeN
         aNpIXFR6GF62ZSXTau/erK4ouhJLg8lfvaKRswIz2kkVZZarLVTE9YgHUxc1TsxdsZzs
         aAoWGsUGMfetC95ZMtzEbHTRl1+P81K8N1/oV1brozHm+C25anTLjszsO18/6vpDGsoi
         GxcAjeqOjGT+pJI9RtdfL7/jlIx7xvu7gXrTZhz+SXx8tOymVYNvrcskIXzG9M6+HxlU
         CT2fglGsKIUDsgbWvPbNl/fngEIseloHmK9awuCcQBV5Ze1A1Ss07I2EiHwPktx11eWV
         fZjg==
X-Forwarded-Encrypted: i=1; AJvYcCXYmnZ9HEo/+blNI7JEn31IOrD0R+ft+WXpoot5sV8bo15YihfWyxcYnHAnk5yyj3U28yoHcy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJOD5DIQLWo1i5arByCQ3MgR+3LZbaDngDcK62O1JID4/1dzwr
	UcxkiSqf8rFM2b7FOLMGIU0jYCror/yMoEM6jaPC8mvpItWwYOvp6Tfk
X-Gm-Gg: AZuq6aKhtnV7FBZHomMKa8N1I2kHz6lUiBh5mz4c6ZdhEuzjLP4Bh+t+Z4xR2IhQQFu
	KiyMSgoBo5riltmUt/zQSgbkLpR/XGDaI5frUiuDeHiFSUnhxdgbGKfOHy8IJL5IgpSV9ATowG/
	2WnEFpgXzqI3PL/5Co96hOpfe4dl3W+RyeC0NF7qse93PwfJX9Td5WJSnZWIIf8xVaxdDfdOEyK
	OQqwjcUPsYvVvdKjMEi4EdeuladY1V5Ff0D6STYTCZL7el/JK9bt71+G4hdvBqbMmQhlvRTpnzT
	XoksoEK/5+zXwgreTXmlR1hZ9isMNTyfy74gdsSUI+tQLJBFdL3qJYTy6nKeuYLdR4iRHSWpoE4
	ztjK0Y92XU4tUOMKHiS1Zm93Q4DZl4O3UoOCJVhikv1TbyORtjehrcK+Kn7OTDLt0Tg8DV5sAUb
	hZ+bJ1LDtApYh0amxEMsqeiuwWxQvIRYGL1oY=
X-Received: by 2002:a05:690c:c52e:b0:792:7745:72fc with SMTP id 00721157ae682-7945ad3dda6mr40762637b3.21.1769459196761;
        Mon, 26 Jan 2026 12:26:36 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:55::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7944aa7b302sm39785637b3.48.2026.01.26.12.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 12:26:36 -0800 (PST)
Date: Mon, 26 Jan 2026 12:26:35 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 4/4] net: inline get_netmem() and put_netmem()
Message-ID: <aXfN+/v8JAh9GcQU@devvm11784.nha0.facebook.com>
References: <20260122045720.1221017-1-edumazet@google.com>
 <20260122045720.1221017-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122045720.1221017-5-edumazet@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253593-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,209.85.128.172:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: CE31F8D0FA
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:57:19AM +0000, Eric Dumazet wrote:
> These helpers are used in network fast paths.
> 
> Only call out-of-line helpers for netmem case.
> 
> We might consider inlining __get_netmem() and __put_netmem()
> in the future.
> 
> $ scripts/bloat-o-meter -t vmlinux.3 vmlinux.4
> add/remove: 6/6 grow/shrink: 22/1 up/down: 2614/-646 (1968)
> Function                                     old     new   delta
> pskb_carve                                  1669    1894    +225
> gro_pull_from_frag0                            -     206    +206
> get_page                                     190     380    +190
> skb_segment                                 3561    3747    +186
> put_page                                     595     765    +170
> skb_copy_ubufs                              1683    1822    +139
> __pskb_trim_head                             276     401    +125
> __pskb_copy_fclone                           734     858    +124
> skb_zerocopy                                1092    1215    +123
> pskb_expand_head                             892    1008    +116
> skb_split                                    828     940    +112
> skb_release_data                             297     409    +112
> ___pskb_trim                                 829     941    +112
> __skb_zcopy_downgrade_managed                120     226    +106
> tcp_clone_payload                            530     634    +104
> esp_ssg_unref                                191     294    +103
> dev_gro_receive                             1464    1514     +50
> __put_netmem                                   -      41     +41
> __get_netmem                                   -      41     +41
> skb_shift                                   1139    1175     +36
> skb_try_coalesce                             681     714     +33
> __pfx_put_page                               112     144     +32
> __pfx_get_page                                32      64     +32
> __pskb_pull_tail                            1137    1168     +31
> veth_xdp_get                                 250     267     +17
> __pfx_gro_pull_from_frag0                      -      16     +16
> __pfx___put_netmem                             -      16     +16
> __pfx___get_netmem                             -      16     +16
> __pfx_put_netmem                              16       -     -16
> __pfx_gro_try_pull_from_frag0                 16       -     -16
> __pfx_get_netmem                              16       -     -16
> put_netmem                                   114       -    -114
> get_netmem                                   130       -    -130
> napi_gro_frags                               929     771    -158
> gro_try_pull_from_frag0                      196       -    -196
> Total: Before=22565857, After=22567825, chg +0.01%
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/netmem.h | 20 ++++++++++++++++++--
>  net/core/skbuff.c    | 31 ++++++++++---------------------
>  2 files changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 2113a197abb315f608ee3d6d3e8a60811b3781f8..a96b3e5e5574c1800ae7949c39366968707ab5d5 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -401,8 +401,24 @@ static inline bool net_is_devmem_iov(const struct net_iov *niov)
>  }
>  #endif
>  
> -void get_netmem(netmem_ref netmem);
> -void put_netmem(netmem_ref netmem);
> +void __get_netmem(netmem_ref netmem);
> +void __put_netmem(netmem_ref netmem);
> +
> +static __always_inline void get_netmem(netmem_ref netmem)
> +{
> +	if (netmem_is_net_iov(netmem))
> +		__get_netmem(netmem);
> +	else
> +		get_page(netmem_to_page(netmem));
> +}
> +
> +static __always_inline void put_netmem(netmem_ref netmem)
> +{
> +	if (netmem_is_net_iov(netmem))
> +		__put_netmem(netmem);
> +	else
> +		put_page(netmem_to_page(netmem));
> +}
>  
>  #define netmem_dma_unmap_addr_set(NETMEM, PTR, ADDR_NAME, VAL)   \
>  	do {                                                     \
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c57c806edba8524d3d498800e61ae6901fbfe5fb..2a8235c3d6f7fcee8b0b28607c10db985965b8d4 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7422,31 +7422,20 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
>  }
>  EXPORT_SYMBOL(csum_and_copy_from_iter_full);
>  
> -void get_netmem(netmem_ref netmem)
> +void __get_netmem(netmem_ref netmem)
>  {
> -	struct net_iov *niov;
> +	struct net_iov *niov = netmem_to_net_iov(netmem);
>  
> -	if (netmem_is_net_iov(netmem)) {
> -		niov = netmem_to_net_iov(netmem);
> -		if (net_is_devmem_iov(niov))
> -			net_devmem_get_net_iov(netmem_to_net_iov(netmem));
> -		return;
> -	}
> -	get_page(netmem_to_page(netmem));
> +	if (net_is_devmem_iov(niov))
> +		net_devmem_get_net_iov(netmem_to_net_iov(netmem));

I wonder if this is a good time to move to just re-use niov from above
here instead of re-convert with netmem_to_net_iov()? I do acknowledge
the original code did not do this.

Best,
Bobby

