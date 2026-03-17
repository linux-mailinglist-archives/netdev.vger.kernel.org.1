Return-Path: <netdev+bounces-268740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAwAMkHEuWmcNQIAu9opvQ
	(envelope-from <netdev+bounces-268740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:14:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E5F2B28B4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E926C30698F2
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F13B3909AA;
	Tue, 17 Mar 2026 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="AE2sstpk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C038F92F
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782077; cv=none; b=qtsq7ifIUC4FYXy8IGTgCqbh8a2XEX5s7UvsmpsdFm6iFACmb4xhkCO2b/pv7+FAZhl2d0xOpiGNdfmVvPm5dg2K3BQwzjhs4oR3MUlO6z1EwvGdEO/CKlAkPNKjt836hEcCw/UCtH6ucokG3Yk0ujmhTYhdnzMUbX4Q7U+qOag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782077; c=relaxed/simple;
	bh=TGqDQVKenKst7ulkB8U2FPYOSqBdO6CBrwx/TU5vxvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A22AFl+R5YYK0yDCqgC7sZ6HG65CCIFELh2wfaRKiSIGtB2OS6ilB4RpynekpTyQKzsigqgPHBngnbPkW7xbQ8vhcFhGrd8W74/enrhj7UyD3ZW6AbAFBQ2oL3zVie1N+R4hYDpUcY1cR1ndvTHJxkHuUAdorzKExf7ClMX4HKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=AE2sstpk; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fb4TZ5w39z2RS;
	Tue, 17 Mar 2026 22:14:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773782066;
	bh=9PdX0GoF+dwhSnTxhQP6xSC/aUKyJh+SmOgu8OgcULE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AE2sstpkYihXXRJ/A5ZQNWjOTKCFVk/U3E+sNDnugqB1XY1KLhpwj6DB+YKpZm43l
	 2PUNziPG4SeM6bTGMhuqudDTn550ikIdgTwjMwQCCVG2dhoL35gIOWSslx6MMVyy42
	 PyHcbAeO7Ou4BrIZJZDn4pYyIJKvj2g8qNWW0tTs=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fb4TY2dTNzrFg;
	Tue, 17 Mar 2026 22:14:25 +0100 (CET)
Date: Tue, 17 Mar 2026 22:14:23 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
Message-ID: <20260317.Re1jaiThoo5i@digikod.net>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315222150.121952-2-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-0.89 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.77)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,canonical.com,namei.org,hallyn.com,maowtm.org,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,zeniv.linux.org.uk,kernel.org];
	DKIM_TRACE(0.00)[digikod.net:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[digikod.net];
	TAGGED_FROM(0.00)[bounces-268740-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 45E5F2B28B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Paul and netdev folks, I think this new hook is now good.  I'd like to
push this series to -next this week.  Please let us know if you find any
issue, otherwise I guess we'll get more eyes and bots in the -next tree.

On Sun, Mar 15, 2026 at 11:21:42PM +0100, Günther Noack wrote:
> From: Justin Suess <utilityemal77@gmail.com>
> 
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
> index 3756a93dc63a..aced28179bac 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1231,11 +1231,18 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>  		goto path_put;
>  
>  	err = -EPROTOTYPE;
> -	if (sk->sk_type == type)
> -		touch_atime(&path);
> -	else
> +	if (sk->sk_type != type)
>  		goto sock_put;
>  
> +	/*
> +	 * We call the hook because we know that the inode is a socket and we
> +	 * hold a valid reference to it via the path.
> +	 */
> +	err = security_unix_find(&path, sk, flags);
> +	if (err)
> +		goto sock_put;
> +	touch_atime(&path);
> +
>  	path_put(&path);
>  
>  	return sk;
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
> 2.53.0
> 
> 

