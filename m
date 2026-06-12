Return-Path: <netdev+bounces-298705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h3/bHJkeLGrzLgQAu9opvQ
	(envelope-from <netdev+bounces-298705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:58:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4F167A5EE
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:58:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rZYA9nmo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298705-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298705-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BC4D3006201
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC41C385D6E;
	Fri, 12 Jun 2026 14:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C62383C89
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:58:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276305; cv=none; b=rt6iVj5o60KB1VQ4iI8JR8SvOuJpX8maZE5CSNr7izMgFsMHghNP+6hY4NzE5CduKURSyN7YgRM+Du0bJ+8KrVxgOPQIKzT4xiZgV3KZPqISCY3aOPYW5IynNgX5ltycnRSPXc4npZ344cnKSU87Em7vSp3GJ8xqwNyRT3Ef59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276305; c=relaxed/simple;
	bh=k0qUAcGriL9M3ldME0Wx7uurzJb6Wq7dm2Bl1WpnN98=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Utojp2xFnRE3RVLy7CHsNUokKq4J0tP7VYrOXIUC+O3IaN3OocF8BhZ+dZ+IdrHPrKJ+RbRqCWMZ3O6btA+oHjvkyLrCBOVmx83+R2F0eLgDnsbahlx6hA1qjZQ+RlP2+OP4NhZn0vl0XVtAE0H0WSs472L5B5SC7N14ot+c1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZYA9nmo; arc=none smtp.client-ip=74.125.224.41
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66039d3efcbso1202060d50.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781276303; x=1781881103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S6NHQe4ZIyWygNURSfM9i/aQz8oPyjRNWHr8uR1BO4=;
        b=rZYA9nmoVuUTHNZk5qxpLYhI9b/2eEx4ouNkM1NXJAHHZgx1XFPvZcSYf7rdaSis4Z
         uMkqDaNk9bQJ6xhsvDFsgFoqz4ewdKq2uUZmWqMzFd8PGEGwyNbhMXu1IyKLkWtbwUZb
         ZlPYog4VDp9+O9OD8XVlK7Uab/JRgbyzfimL0D3AWdIWwttbh8ht8Ch78ENIbY7GPIW9
         ijxj6tmI8JFAgfsi2b4/AITTtz/Io2rlLxSk2JrGCODfP6tPTXWNlS/u9Pc4gup9zyYd
         UFB86r11MAP9/kg3/0vYLwAXTXCfb4BKMBBCW8+S6oeQB3iu3mnITJGesJ3G0zoYgMoB
         iDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781276303; x=1781881103;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3S6NHQe4ZIyWygNURSfM9i/aQz8oPyjRNWHr8uR1BO4=;
        b=jwEjHbM2Z0QNYEuagqwOVRHgW8LCPwtFxa5Bv048CLj92zvceXxN5/tgV0mjrMS+YM
         P0Uk7wxeRq6ITGyTksFJxrleDHtlj86hqMPwTEw1opyaxJl3jKdXkB8fbLLv/Pyt9lt5
         6QHM7Ll6JV62wtzMftLfiyOne6zbyV31uVCzDUHm/g41RKtNqIHY7y9fSWgNiSqLx+Sg
         H7QOT+EbPiGtcxfAr3QMXskih1S4cWlDnegrbd6DPEQQnyRFwtlcIA3tFWVdlIzxpVcO
         PR964VlQiQpZVwHymVX1cCVETn4XVQQqKIJmcxSkspC9b4PWBe/j0Ho3IwPkGWk+e/QC
         j0Vg==
X-Gm-Message-State: AOJu0YzNw7t8FPz5OJ0rZLQyxSvoWoc0HB4X+nnsf+dXpWQZMIp1Qh8p
	xIhGEKut6Bh2OPjKIh2j2pSjJ1aEDTciNlB3M3WGkmKmhgxoOpUN7q1A
X-Gm-Gg: Acq92OGzX3e70YqvqRcoC0zcEANjvdr6Q9fRUQSERgXk4gUjH4OUhhccsI1Ras5xE24
	ttczUCGl2q7MUZQgab5wGMKAujNVyxW7jgyTmrxnnf1n6xD79kkZ0P7G4L3EIWCfqaKsTj7wWAm
	erx2CiDQa6p6GQfI8J1Jqj4NtH3pCMJM0yCChLgXVF9LA4TnkDq8NMxlhykrR+71DjaokqnmXwX
	i9g+Yj4LdYnD1JznLQk3wXQvrE50Ajxl2pDdpYLRgtmw2kK9GnagA715Ee6Kfc8dB0iTkQqDA07
	5jeTxZeJXprkGkogexlxJ4bI3Hl1HVaB19K/YoTYXulRxtMXNjnLwydgjRvKpetd7QCKXVkBk69
	N5wC6thn8yHe7M7GdYjNsVcuQS5HrDc6BnvJP3gWVRVYONOMPqDj9QVy3OG1Yea9fdAiSez8mwd
	vxBdoWKXyr0TCkpV9xK18Dbx3oSBKHQBGZeGRnbuGPemF7RtPqhL5X0UM90L4HIGU784eSbGCmN
	Rq2uZs=
X-Received: by 2002:a05:690e:144f:b0:65e:43da:a470 with SMTP id 956f58d0204a3-662782f5925mr2641422d50.30.1781276303255;
        Fri, 12 Jun 2026 07:58:23 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66274c4017asm1259158d50.1.2026.06.12.07.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:58:21 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:58:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, 
 sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
Message-ID: <willemdebruijn.kernel.26a37316bb5e2@gmail.com>
In-Reply-To: <20260612-getsockopt_phase2-v1-2-7b01f1f5d106@debian.org>
References: <20260612-getsockopt_phase2-v1-0-7b01f1f5d106@debian.org>
 <20260612-getsockopt_phase2-v1-2-7b01f1f5d106@debian.org>
Subject: Re: [PATCH net-next 2/2] udp: convert udp_lib_getsockopt to sockopt_t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298705-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[debian.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A4F167A5EE

Breno Leitao wrote:
> In preparation for converting the proto-layer getsockopt callbacks to the
> sockopt_t interface, switch udp_lib_getsockopt() to take a sockopt_t.

What is the benefit of this conversion?

It does add a lot more complexity and makes the code less obvious.
 
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
> -
> -	if (len < 0)
> -		return -EINVAL;
> -
> -	len = min_t(unsigned int, len, sizeof(int));
> +	len = min_t(unsigned int, opt->optlen, sizeof(int));
>  
>  	switch (optname) {
>  	case UDP_CORK:
> @@ -3037,9 +3032,8 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
>  		return -ENOPROTOOPT;
>  	}
>  
> -	if (put_user(len, optlen))
> -		return -EFAULT;
> -	if (copy_to_user(optval, &val, len))
> +	opt->optlen = len;
> +	if (copy_to_iter(&val, len, &opt->iter_out) != len)
>  		return -EFAULT;
>  	return 0;
>  }
> @@ -3047,9 +3041,27 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
>  static int udp_getsockopt(struct sock *sk, int level, int optname,
>  			  char __user *optval, int __user *optlen)
>  {
> -	if (level == SOL_UDP)
> -		return udp_lib_getsockopt(sk, level, optname, optval, optlen);
> -	return ip_getsockopt(sk, level, optname, optval, optlen);
> +	sockopt_t opt;
> +	int err;
> +
> +	/*
> +	 * keep the old __user pointers, until ip_getsockopt() moves
> +	 * to sockopt_t
> +	 */
> +	if (level != SOL_UDP)
> +		return ip_getsockopt(sk, level, optname, optval, optlen);
> +
> +	err = sockopt_init_user(&opt, optval, optlen);
> +	if (err)
> +		return err;
> +
> +	err = udp_lib_getsockopt(sk, level, optname, &opt);
> +	/* indepedendent of the err, return optlen */

typo

> +	if (put_user(opt.optlen, optlen))
> +		return -EFAULT;
> +	/* Optval was updated in copy_to_iter in udp_lib_getsockopt() */
> +
> +	return err;
>  }
>  
>  /**
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 15e032194eccc..731122deed8a5 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1826,9 +1826,20 @@ static int udpv6_setsockopt(struct sock *sk, int level, int optname,
>  static int udpv6_getsockopt(struct sock *sk, int level, int optname,
>  			    char __user *optval, int __user *optlen)
>  {
> -	if (level == SOL_UDP)
> -		return udp_lib_getsockopt(sk, level, optname, optval, optlen);
> -	return ipv6_getsockopt(sk, level, optname, optval, optlen);
> +	sockopt_t opt;
> +	int err;
> +
> +	if (level != SOL_UDP)
> +		return ipv6_getsockopt(sk, level, optname, optval, optlen);
> +
> +	err = sockopt_init_user(&opt, optval, optlen);
> +	if (err)
> +		return err;
> +
> +	err = udp_lib_getsockopt(sk, level, optname, &opt);
> +	if (put_user(opt.optlen, optlen))
> +		return -EFAULT;
> +	return err;
>  }
>  
>  
> 
> -- 
> 2.53.0-Meta
> 



