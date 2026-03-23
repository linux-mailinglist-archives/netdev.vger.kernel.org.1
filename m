Return-Path: <netdev+bounces-270685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFtwNjyXwWkuUAQAu9opvQ
	(envelope-from <netdev+bounces-270685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:40:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2A72FC733
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AB1C320AB4B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4F732AABD;
	Mon, 23 Mar 2026 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuRqtCvE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E07032C937
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293032; cv=none; b=o1VTVMOzghnMt/3QWEhMOEr/9Nq6S1LjavOvb/z04UkT2I+XDfRzV1Vf8bzveD3m/oS4pM82lZyHzcG7GHw+pfkmrBasllD+u7GhPe597+lpM30APZBoCE+n5yuk0KJc317O3kVqPq1TTgHuq9DQQMphIDH6sc4t/JWaQIiKL08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293032; c=relaxed/simple;
	bh=u70jMS93ZGGf12b9u664ZuoNzvkPh/Jd7rvrgWDjRkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX0l48l2mHsC5T5GoXx/qnpWPWNYT8Uq6BwA42oLiShujzQd0fUCSMNGPQMICOI+uB35MuWqJA+jqpHkOiS6Qg29NpxHttRCZzgKI+YRDQpgcyXYPMWAl+nTfHfBsPpX4PSvIpyq2IritS2T7q6ZiJpAaVznWxTC7UHAmZG5VMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuRqtCvE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b7c844b20so771156f8f.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774293026; x=1774897826; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D9t95D8xEX/7Je1aEX2cgVLU/Fxa2+umElabflj3GR8=;
        b=VuRqtCvEEgqQf4FiVvYu/NCgh9bR2yA0gQNYllKtKg2IiO2f6dgJxY6Vy8g3AmKcAA
         Z5TC0KFFMHomGkifqTnRs9SQz3CsA2N5jwafM0ObjCYd2TR/mW8AoeWQuVuS4JX8vtNQ
         L3THQojJ99QCrmLXytWOYHdGZfDXo5XAkZjWwd/w7uUM/1SqoBAeHQ+C8e4Qwxv/GeWC
         NNlqiqN7vDgIICNKN2px5rYSbbax3Kmn+Pk2riVMj+xGauXqjiv8VyR2rB1xxE5mOvCH
         p+dGNm/MTwP+bHpMMToIO97hjyBvxwdpaTjG4OxZ3MTfVP56aqDkaFcC5SDHxEpl2YYD
         VzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774293026; x=1774897826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9t95D8xEX/7Je1aEX2cgVLU/Fxa2+umElabflj3GR8=;
        b=W5qwlDhSey8QF9FGM97gPFKosdkKduDaqzsSBeO1xm/OngdB9UTukNizgMPr8XzAiq
         8VUbZh6yGmjzrdqUR9hqRot8DsMXdND/KtG02pldQncFMGmMxJO5nSVQ1mYPPPyMbBx0
         xp6QhiRknvZcajuTi2Q+iIclCUxudrddupJ3DIEnY1voxCebEDn0lS7CEDW/ki1N+Qt4
         hDkOJp7r7vh6wAgCAdDzX8Hi3PIxMd6roIXyJqw6FF+lslPdAIKXxMIxY8XeyTrqo+1W
         9GE+F77bwygUw+iIYqETZq8d98xBrdffOMcjOfLplCZg7Sc+jLJL36DXGpEgv1fyKxTk
         f/LA==
X-Forwarded-Encrypted: i=1; AJvYcCXG7Ys5jY3xwORx6PTKorrNVqrsnL29njdpbgXsyEAYDM1gDRyBU42pxPHJmZWSO1ywqQeWet8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Krhs+QeSmu+TT4E56lEBN1+L3K5QX5cOJyPkGbOezP47UUkX
	djf9LJxUSswUM4s1VBMSyqeh+hxUj7w7zJ8X+mAPPwGLIB3ZtjsPNon6
X-Gm-Gg: ATEYQzz5SeCZApROw9PClmpsrB0Yb3xGgR8jCzjRn8QtyOKgqussDc1zXfyL4oJeTEv
	q2kWsdMnDJwTbOy+uN8OcaZ56gyJEbJJ2aZ9SL5qu6asvRjE1XoEQt0jCtmvuVvtJGd6odpi7dP
	mdaiUnLp3jHJw8D6t6Vc03IpCtk5KiGT+G8sGNOKn7EJAAupMIX/jhx6H33z4STPLj3/VL5EQvk
	Ok+qodW6xoCXUdtxyAz+q6lkg2bbSNzXBYVBlrNxXxBDmIk1t7nM5iDXLvh1uEQmDZ1wJp0NX6f
	lJVWCz4OLU85cQZhvmPZRhyst5rh+U4ZPHH1rBxw0gN3c7cBWcRa8JdAo1vsbu0x8ZXAIuwtVjy
	gEEd+hluW8RLEzsu6vt64O560vs3VOYLGYIER5TmcDIWcScxeuzFNP+M7WXrExxcudeK3QyCf23
	vdRzQ7DsxK8PiNW7Yp0WMF/YOP4Cfdp/JpPmuBThp46CduRz8i63e93OT11jw=
X-Received: by 2002:a05:6000:420e:b0:439:ddf9:a205 with SMTP id ffacd0b85a97d-43b64232830mr19438002f8f.10.1774293026166;
        Mon, 23 Mar 2026 12:10:26 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b647120a1sm32247095f8f.30.2026.03.23.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:10:25 -0700 (PDT)
Date: Mon, 23 Mar 2026 20:10:24 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 01/11] lsm: Add LSM hook security_unix_find
Message-ID: <20260323.4eae8ac1df61@gnoack.org>
References: <20260323165654.193957-1-gnoack3000@gmail.com>
 <20260323165654.193957-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323165654.193957-2-gnoack3000@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270685-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[maowtm.org,gmail.com,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,kernel.org,zeniv.linux.org.uk];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:email,digikod.net:email,gnoack.org:mid]
X-Rspamd-Queue-Id: 3D2A72FC733
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 05:56:43PM +0100, Günther Noack wrote:
> From: Justin Suess <utilityemal77@gmail.com>
> 
> Add an LSM hook security_unix_find.
> 
> This hook is called to check the path of a named UNIX socket before a
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
> Consumers of the hook wishing to reference @other are responsible
> for acquiring the unix_state_lock and checking for the SOCK_DEAD flag
> therein, ensuring the socket hasn't died since lookup.
> 
> Cc: Günther Noack <gnoack3000@gmail.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Cc: Mickaël Salaün <mic@digikod.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++++
>  include/linux/security.h      | 11 +++++++++++
>  net/unix/af_unix.c            | 10 +++++++---
>  security/security.c           | 20 ++++++++++++++++++++
>  4 files changed, 43 insertions(+), 3 deletions(-)
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
> index 3756a93dc63a..5ef3c2e31757 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1231,11 +1231,15 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>  		goto path_put;
>  
>  	err = -EPROTOTYPE;
> -	if (sk->sk_type == type)
> -		touch_atime(&path);
> -	else
> +	if (sk->sk_type != type)
>  		goto sock_put;
>  
> +	err = security_unix_find(&path, sk, flags);
> +	if (err)
> +		goto sock_put;
> +
> +	touch_atime(&path);
> +
>  	path_put(&path);
>  
>  	return sk;
> diff --git a/security/security.c b/security/security.c
> index 67af9228c4e9..28ccea205874 100644
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
> + * AF_UNIX socket. The caller does not hold any locks on @other.
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
> 2.53.0
> 

P.S. I noticed it too late today, so it's not on the commit message,
but we also got a Reviewed-by from Georgia Garcia in
https://lore.kernel.org/all/c3fccd822db5fc76b7fab00a9515eb276a71b421.camel@canonical.com/
(in response to V6 of the patch).

Thanks, Georgia!
–Günther

