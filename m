Return-Path: <netdev+bounces-298884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TMEFFBO8LGqdVwQAu9opvQ
	(envelope-from <netdev+bounces-298884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 04:10:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 989AA67D80B
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 04:10:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WYBNAx6R;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298884-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298884-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E70A731372FE
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966D839E6E4;
	Sat, 13 Jun 2026 02:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70849368D43
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 02:10:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781316623; cv=none; b=fHuXWopkhPcTpt7yaVLMrcfXk2E3RLBtzom/xH8gUgfZUn7atJtMlhEXwp7+KS5yr/PVN1vUPURgGx+z3KfNTxWUjjFcQ9tjSkRApd7uWqCDHIYyv26vN13lfRFE6hF590EG5NSx53apQMVisRRaFHZFkpJmBTNRz9rggHCjURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781316623; c=relaxed/simple;
	bh=uTqsrI3kXHlZ9s5FCWhR0+ezVXqQfpVv9lD9udQjaag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2T77RGt+Jotz1Bq98UhejLYdE88n6OuahmnK5myYk0fgUfal9XVn6+10VmlWxMYxqJW0UzIi2aD42om9DC54Jrq5OD5jLZXJJrHw7QkRzcYS8bdGUm3M9WnNF95w+uAJNXIOU3zebuwb9SWdFKcOqnrH2m3WxmSLgQ+AvD9Hfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYBNAx6R; arc=none smtp.client-ip=209.85.216.67
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso1606268a91.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 19:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781316622; x=1781921422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlXZARvbuLg9eimNdY6LbUYqojjxqaDI2VXv+ws27Jk=;
        b=WYBNAx6RA3iHPgNBsHKg4uE+y16iBvAyMLIjSJjtVZOb3mrw5ALHYKZAjujzpuizAn
         XEYzSZUyhdLbQVSbmvk37prtPys0Khb7V+gyjUkS4L8PHfAVHYpwRCgeUJTTD3Tmn+Fs
         HZz8V5BzT8DmnRgJFK/o/ms07Q4nCvFGkXDZN95clbcrAkTry6NWv+UgcJ9S661w5vqs
         gADNzKaJ9VKbF7MlUjQNW7oINoGnsOxItnXPmNmUDPEi2B+1Wv9HxCtjLFTKxZ7YRdXR
         xhblQkcNhsdXFBYM/ahhBritH+mfGzNmbsSQqkaI9xMsjQi75yiW10zD75Fq7LjqXqji
         ujaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781316622; x=1781921422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlXZARvbuLg9eimNdY6LbUYqojjxqaDI2VXv+ws27Jk=;
        b=abUusfia3uFSq9pNb7MEb6aCM4ye9Uuvd5YfT5cuvc0U5UO5Ij1LRlx7svksXI8OCJ
         X7z2g23fXLwdsqIlbm0zEpFWgv1oH4kxLCPSQfCh5VxKNAIrD3uG/zc6i66Cv6k65D4+
         J4jWE4ygXTiFDpNtSMKI5PM/CpcyA4IW3c9MynIhLQuGEZxCAQbditERuo2Uma8IzbkL
         UPCSh8eM0ti6hstXXkUMhEK/WG9w6HNMbFvnB03Co8sdvtRGtYKN2Q/sdYwSQAbDmDAO
         ND9G3Oog319ihtuUm6uEmmJtvEBXvJphyQQypCjRSalESjPeHgsSGIjGfgivpVc5JtYP
         IaJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9TqyrFSaKEo7TsmY3d1HjKk9cl8hSYZggKb07vkTY0vrixB0OYjDLFH4W96TW9HYNf2vxNkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBJP7b/hSVFmZdgZ6fm2Hwp1mS7VYnH4qYArw8Jvu/ORgCBYQ6
	ng7vgxrxHF7aBHP+UG6aM0mRbw89rqvCaDtyNy3RrMju/uY7ZHdgqVZY
X-Gm-Gg: Acq92OEp7OsWlQeR9499l+osY5cNrs7sKyADroGk86DIqW2j/ya1P8DePRHeauZAoG+
	VS0PUY483IL+VRy2h/TC0pYPA3rWBKvTtvT+NL+Wm0tJLKpQ96rdib1OX6fG3L6xyr4ap42fZ+0
	ro4mxU2TcoJ0LJGSAYlTJkHHcYLqUqSwJ3tZjDM7HtxdcWi5apCwO6dF9WfctfXdwn0gkDEkoto
	7LCtml0XXwwi76V4sZD7cXceBE7yqoOlgPpczLWKtl7/AS793WTGWlztdBDO++2Kbd2PJHqaMdY
	IQr/l57HT1UjPoNRq6yLxYsK/8sYhKtN1oUE+mwpzZ6oT9o7fbvb+H0AvvXUFlgHQrhMSw29skk
	uQZF2RKacGWBTq8WRcKQsSl17d2ABE0LZbjfDlAMfks1rfE3AVGzvKCS+kicYzxpwpEFgXE6uZI
	8QI+LdtLAV1qsQ9yQzfpaEG0C9rjE=
X-Received: by 2002:a17:90a:d44e:b0:36b:2179:6d23 with SMTP id 98e67ed59e1d1-37a01c36da1mr5844647a91.7.1781316621781;
        Fri, 12 Jun 2026 19:10:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379c3240b5esm2395134a91.0.2026.06.12.19.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 19:10:21 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:10:15 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/2] udp: convert udp_lib_getsockopt to sockopt_t
Message-ID: <aiy7ZR7Yz2Z4Ioyd@devvm7509.cco0.facebook.com>
References: <20260612-getsockopt_phase2-v1-0-7b01f1f5d106@debian.org>
 <20260612-getsockopt_phase2-v1-2-7b01f1f5d106@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260612-getsockopt_phase2-v1-2-7b01f1f5d106@debian.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298884-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devvm7509.cco0.facebook.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 989AA67D80B

On 06/12, Breno Leitao wrote:
> In preparation for converting the proto-layer getsockopt callbacks to the
> sockopt_t interface, switch udp_lib_getsockopt() to take a sockopt_t.
> 
> The thin udp_getsockopt()/udpv6_getsockopt() wrappers keep their __user
> signature for now: they build a user-backed sockopt_t with
> sockopt_init_user(), call the helper, and write the returned length back
> to optlen. The helper uses copy_to_iter() instead of copy_to_user().
> No functional change.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/net/udp.h |  2 +-
>  net/ipv4/udp.c    | 40 ++++++++++++++++++++++++++--------------
>  net/ipv6/udp.c    | 17 ++++++++++++++---
>  3 files changed, 41 insertions(+), 18 deletions(-)
> 
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 8262e2b215b4e..1fee17274745f 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -430,7 +430,7 @@ struct sk_buff *skb_udp_tunnel_segment(struct sk_buff *skb,
>  				       netdev_features_t features,
>  				       bool is_ipv6);
>  int udp_lib_getsockopt(struct sock *sk, int level, int optname,
> -		       char __user *optval, int __user *optlen);
> +		       sockopt_t *opt);
>  int udp_lib_setsockopt(struct sock *sk, int level, int optname,
>  		       sockptr_t optval, unsigned int optlen,
>  		       int (*push_pending_frames)(struct sock *));
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 70f6cbd4ef73b..0691f74db2c11 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -76,6 +76,7 @@
>  
>  #include <linux/bpf-cgroup.h>
>  #include <linux/uaccess.h>
> +#include <linux/uio.h>
>  #include <asm/ioctls.h>
>  #include <linux/memblock.h>
>  #include <linux/highmem.h>
> @@ -2995,18 +2996,12 @@ static int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t opt
>  }
>  
>  int udp_lib_getsockopt(struct sock *sk, int level, int optname,
> -		       char __user *optval, int __user *optlen)
> +		       sockopt_t *opt)
>  {
>  	struct udp_sock *up = udp_sk(sk);
>  	int val, len;
>  
> -	if (get_user(len, optlen))
> -		return -EFAULT;

[..]

> -	if (len < 0)
> -		return -EINVAL;

I see this part now in sockopt_init_user, but you mention that it's a
transitional helper. When we drop it, will we loose this <0 check?
Maybe keep `if ((int)opt->optlen < 0))` here for backwards
compatibility?

