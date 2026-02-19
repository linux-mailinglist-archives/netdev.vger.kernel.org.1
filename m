Return-Path: <netdev+bounces-259586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DvhHOxxl2nUygIAu9opvQ
	(envelope-from <netdev+bounces-259586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:26:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D35A91624D1
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C671F301681D
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3B1316915;
	Thu, 19 Feb 2026 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu4TYd1I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5D311C2D
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771532776; cv=none; b=kyFi3+jwfCAsK5+ZE38ZDEAQiPqu12zA37GknoT4nkYhh2DLShlLzi3t8cm7A26P92GxcfnZDqcycpGBeNPLydPQNSQK7A/TgHXYGizFMoHkH9acoKMMJBUrQaEWK3SD2vO94sgtISxc1yzoFCY8PyGv094V0B+nlnwczcshl7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771532776; c=relaxed/simple;
	bh=lU3vpxRoA7Lrd5Mcj7am2OVGUSxLkLjaNQK6YWgO4kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDarzpOBxUGXvisN9bHLsnS4TOTURl4NAzOMavtNGuG4B6t7KAhMCFCgPTiFGLnR034Rg1TKurSHgaf2mSGY5rRaS02Y7EnTqtFP/RrnO59IFEQ1yY1D2Hf1Qhu8TA05Dzt8envDKaKmfRsvm+tUXZ25UglI0KWeWlt71+86tIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu4TYd1I; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48371119eacso12595795e9.2
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 12:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771532773; x=1772137573; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jRM8tuheMzh9OOGizoOHRGNoarMk96qRAJKHeKpf0es=;
        b=Cu4TYd1IM/hSHKmJBC1rOhOQMjCrbR6EVA3vUPUqgdiKWCZKfnie0VjJqmxC2WCSh2
         IgCbglIU8P/ezmJVrugSsgXaByBchHNku8tEalAMMBcoUds6xFllChhYFWhILQnshPNC
         gJ69skCi3LBGEsDeO5/kMyGmSjH60ZtGRCGNWJcoRvsdBe8zlV9bYWXZUK3oZmuUcG7I
         WBZIiLXdFGfSuhgxlM8luSK8desgQG7MUCy4pMYo3LBm85fvWKkME8KWjuwCJZqZTzLO
         vp1VFzXII8PsymJIuT4j2IjY1dXUleZsx8ZMPk0FePAXpKG6G2gFNlNLRiwHJyNpmcA8
         oxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771532773; x=1772137573;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRM8tuheMzh9OOGizoOHRGNoarMk96qRAJKHeKpf0es=;
        b=fPNM0cVUSv1P8roDWtONOHKmPYdgOZOUx+ctOoVaz9H0SSDkmk7gPK/UesJeB0pZp+
         IoUCzp7gVJF14DRTE4uOn0QT7FpISOK3ZGbOZt6Y85b/rcHEiIbatbE8laQ5Dy+nkOZ3
         lBcX9wkU8EaPW5yEnFfnHdK+AWIddDyzuzR6rY0MEP33fPybpwtyRFriaYBOOm1yddAZ
         fztQcMn6X1QNNBm2BEbgWe4kOZpPcDWeYAHnlFeMhHXK1ZdT8AwHo1QhMQCo8hRQEW6Q
         SneEkCWbYXcNfuXPGQ1KnW80oHI7HOnDWRfV0VMIGLNheoek/8lE4OGIHAUXX3zqBsqH
         NyUg==
X-Forwarded-Encrypted: i=1; AJvYcCV8RG1W/GBkfrj9XrWpxdxJuoUR+WlwPWjjHGtpVo6mxoMQV1g8ZtHNEMPFCwHSYv76boCmx2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ1XxL0bqCYRCeAR932gLxRPPg4OAqDVK8y1iEPV4YYkUyiaLx
	thV6DXDdMqTdzlYeHKRZWfb58iwMfuKTErYhVONf+S5Z/ydHfDIGb0qT
X-Gm-Gg: AZuq6aKLi19lvFi31COVRF90jwYsg0Rz3u9CoSvFrwH8n5zxmHhDsiu9e9MWtIO0WL4
	qhi8C82yM4WCsVNX4x1LNlinCyFS0k7Q7G7mvn2kuD5SUMfFv6E1NKvy/vqqMAgCYdG6XOHwvfv
	820kij8fSPr3Xqqm64kMCO4u5XYDDszvREiAsif1/aLK5OB3aIa7Gsaw7ubpX6wTXIN1IjM8TPD
	nnwk/GFotVF9M0aQU03hrmudy8MM9hRD9Y9doITEfZ3IfA2c92oeq2NEoXHGb8CCbex56sG7T89
	JcqLbSOolryRVWE7XvPQgk9i5QjJ4aD7Z/2urB2roT+xV8o64LsegQRBjtpWfiaTnSQYkjW00Yo
	aTuqXZ2ewCH6EnzbpLFsAG+8z16/rSdpeSe+th2AVncgWyyXGdDAfK/zcQRibvAzXyFtbMHosqS
	3i4jahEXhkQdfnFxT3d80UTYkQKISUCj4rIdSXyOVavPvm/03y
X-Received: by 2002:a05:600c:3e0c:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-48398a65ecdmr99591345e9.2.1771532772772;
        Thu, 19 Feb 2026 12:26:12 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b0e63sm47342245e9.2.2026.02.19.12.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:26:12 -0800 (PST)
Date: Thu, 19 Feb 2026 21:26:10 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: brauner@kernel.org, demiobenour@gmail.com, fahimitahera@gmail.com,
	hi@alyssa.is, horms@kernel.org, ivanov.mikhail1@huawei-partners.com,
	jannh@google.com, jmorris@namei.org, john.johansen@canonical.com,
	konstantin.meskhidze@huawei.com,
	linux-security-module@vger.kernel.org, m@maowtm.org,
	matthieu@buffet.re, mic@digikod.net, netdev@vger.kernel.org,
	paul@paul-moore.com, samasth.norway.ananda@oracle.com,
	serge@hallyn.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v6] lsm: Add LSM hook security_unix_find
Message-ID: <20260219.de5dc35ec231@gnoack.org>
References: <aZcPd3OKqxwCZV-5@suesslenovo>
 <20260219200459.1474232-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219200459.1474232-1-utilityemal77@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259586-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,alyssa.is,huawei-partners.com,google.com,namei.org,canonical.com,huawei.com,vger.kernel.org,maowtm.org,buffet.re,digikod.net,paul-moore.com,oracle.com,hallyn.com,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,maowtm.org:email]
X-Rspamd-Queue-Id: D35A91624D1
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 03:04:59PM -0500, Justin Suess wrote:
> Add a LSM hook security_unix_find.
> 
> This hook is called to check the path of a named unix socket before a
> connection is initiated. The peer socket may be inspected as well.
> 
> Why existing hooks are unsuitable:
> 
> Existing socket hooks, security_unix_stream_connect(),
> security_unix_may_send(), and security_socket_connect() don't provide
> TOCTOU-free / namespace independent access to the paths of sockets.
> 
> (1) We cannot resolve the path from the struct sockaddr in existing hooks.
> This requires another path lookup. A change in the path between the
> two lookups will cause a TOCTOU bug.
> 
> (2) We cannot use the struct path from the listening socket, because it
> may be bound to a path in a different namespace than the caller,
> resulting in a path that cannot be referenced at policy creation time.
> 
> Cc: Günther Noack <gnoack3000@gmail.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++++
>  include/linux/security.h      | 11 +++++++++++
>  net/unix/af_unix.c            | 13 ++++++++++---
>  security/security.c           | 20 ++++++++++++++++++++
>  4 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 8c42b4bde09c..7a0fd3dbfa29 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -317,6 +317,11 @@ LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
>  LSM_HOOK(int, 0, watch_key, struct key *key)
>  #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +LSM_HOOK(int, 0, unix_find, const struct path *path, struct sock *other,
> +	 int flags)
> +#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +
>  #ifdef CONFIG_SECURITY_NETWORK
>  LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
>  	 struct sock *newsk)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 83a646d72f6f..99a33d8eb28d 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1931,6 +1931,17 @@ static inline int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>  }
>  #endif	/* CONFIG_SECURITY_NETWORK */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +
> +int security_unix_find(const struct path *path, struct sock *other, int flags);
> +
> +#else /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +static inline int security_unix_find(const struct path *path, struct sock *other, int flags)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +
>  #ifdef CONFIG_SECURITY_INFINIBAND
>  int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey);
>  int security_ib_endport_manage_subnet(void *sec, const char *name, u8 port_num);
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f6d56e70c7a2..41698460194b 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1231,10 +1231,17 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>  		goto path_put;
>  
>  	err = -EPROTOTYPE;
> -	if (sk->sk_type == type)
> -		touch_atime(&path);
> -	else
> +	if (sk->sk_type != type)
> +		goto sock_put;
> +
> +	/*
> +	 * We call the hook because we know that the inode is a socket and we
> +	 * hold a valid reference to it via the path.
> +	 */
> +	err = security_unix_find(&path, sk, flags);
> +	if (err)
>  		goto sock_put;
> +	touch_atime(&path);
>  
>  	path_put(&path);
>  
> diff --git a/security/security.c b/security/security.c
> index 67af9228c4e9..c73196b8db4b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>  
>  #endif	/* CONFIG_SECURITY_NETWORK */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +/**
> + * security_unix_find() - Check if a named AF_UNIX socket can connect
> + * @path: path of the socket being connected to
> + * @other: peer sock
> + * @flags: flags associated with the socket
> + *
> + * This hook is called to check permissions before connecting to a named
> + * AF_UNIX socket.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_unix_find(const struct path *path, struct sock *other, int flags)
> +{
> +	return call_int_hook(unix_find, path, other, flags);
> +}
> +EXPORT_SYMBOL(security_unix_find);
> +
> +#endif	/* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +
>  #ifdef CONFIG_SECURITY_INFINIBAND
>  /**
>   * security_ib_pkey_access() - Check if access to an IB pkey is allowed
> -- 
> 2.52.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Thank you, this looks good. I'll include it in the next version of the
Unix connect patch set again.

–Günther

