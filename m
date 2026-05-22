Return-Path: <netdev+bounces-290917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOFvCEzGEGoLdgYAu9opvQ
	(envelope-from <netdev+bounces-290917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:10:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A22D15BA423
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B025E3010BC3
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 21:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3AF35A385;
	Fri, 22 May 2026 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="NjXxJjy9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFDE299959
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484233; cv=none; b=Zm4BeUiP0hWLNe59j+WqBFwLLwSYfudZr5bWXJOq0RWfhgnGthH0yaOo/n7eemiEOYVJ+/Ms1WTfy2/AvDtNoFLNSBbTS5NCm3g062cQwjVceKhJcxD4tfOsgTtFdrndlUFOATUNo0q0P5eSrF4G5s2W4bHBouYtP/M1TUfCoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484233; c=relaxed/simple;
	bh=1NBAGMqZSxE6KPNyiTXQbGmjAAYbhI49dLJb2u3kCHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwyV2lUYjAB56Dhlyr1Pf/jMLhwQQrbm89S4nOQGLyitIu/8qTupoImsviN14wjdJQJbVhk+QSWLHc7xxK77jDXi3IN08I9p3u0ER/HiOQXD02Oe2OQ24+51QBSC//+dgqmNkl395fUG7/y5CDuU+yRoEL10iV9xJ7fgD1ntRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=NjXxJjy9; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gMdGN2k27zrPx;
	Fri, 22 May 2026 23:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779484220;
	bh=ZPSXiynGA0vhXn9kvmqPudDBcHCUdcRnayzOKtuO5AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NjXxJjy9q8B24g321FB5yOWAb0jghqdewVm2/ODH8ISdO+uxJ5V7lek4ySA7Unb0D
	 kdVQe4FgAc/LM/rxnP8hzY6CYW9GnnGvZBJ/18YHu7FvTgfaTQngInRQQRMzRKpXzD
	 U9Nwwq/iy9EHiP7Hj5Mudt49okWpsOvxV8N0HAOw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gMdGM5FTMzNfL;
	Fri, 22 May 2026 23:10:19 +0200 (CEST)
Date: Fri, 22 May 2026 23:10:17 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/7] landlock: Add UDP connect() access control
Message-ID: <20260522.reif5feiX0Ce@digikod.net>
References: <20260502124306.3975990-1-matthieu@buffet.re>
 <20260502124306.3975990-3-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260502124306.3975990-3-matthieu@buffet.re>
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-0.95 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	TAGGED_FROM(0.00)[bounces-290917-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,buffet.re:email]
X-Rspamd-Queue-Id: A22D15BA423
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 02, 2026 at 02:43:01PM +0200, Matthieu Buffet wrote:
> Add support for a second fine-grained UDP access right.
> This first half of LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP controls the
> ability to set the remote port of a socket (via connect()). It will be
> useful for applications that send datagrams, and for some servers too
> (those creating per-client sockets, which want to receive traffic only
> from a specific address).
> 
> Similarly as for bind(), this access control is performed when
> configuring sockets, not in hot code paths.
> 
> Include detection of when autobind is about to be required, and check if
> the process would be allowed to call bind(0) explicitly. Autobind can
> only be performed when sending a first datagram, when connect()ing, and
> in some splice() EOF edge case which, afaiu, can only happen after a
> remote peer has been set (which is already covered).
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  include/uapi/linux/landlock.h               | 19 +++++
>  security/landlock/audit.c                   |  2 +
>  security/landlock/limits.h                  |  2 +-
>  security/landlock/net.c                     | 79 +++++++++++++++++----
>  tools/testing/selftests/landlock/net_test.c |  5 +-
>  5 files changed, 92 insertions(+), 15 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 045b251ff1b4..22c8cc63f30e 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -378,11 +378,30 @@ struct landlock_net_port_attr {
>   *
>   * - %LANDLOCK_ACCESS_NET_BIND_UDP: Bind UDP sockets to the given local
>   *   port. Support added in Landlock ABI version 10.
> + * - %LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP: Set the remote port of UDP
> + *   sockets to the given port, or send datagrams to the given remote port
> + *   ignoring any destination pre-set on a socket. Support added in
> + *   Landlock ABI version 10.
> + *
> + * .. note:: Setting a remote address or sending a first datagram
> + *   auto-binds UDP sockets to an ephemeral local source port if not
> + *   already bound. To allow this if both %LANDLOCK_ACCESS_NET_BIND_UDP
> + *   and %LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP are handled, you need to
> + *   either:
> + *
> + *   - use a socket already bound to a port before the ruleset started
> + *     being enforced;
> + *   - or grant %LANDLOCK_ACCESS_NET_BIND_UDP on port 0, meaning "any
> + *     port in the ephemeral port range";
> + *   - or grant %LANDLOCK_ACCESS_NET_BIND_UDP on a specific port, and
> + *     call :manpage:`bind(2)` on that port before trying to
> + *     :manpage:`connect(2)` or send datagrams.
>   */
>  /* clang-format off */
>  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
>  #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
>  #define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL << 2)
> +#define LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP		(1ULL << 3)
>  /* clang-format on */
>  
>  /**
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index e676ebffeebe..851647197a01 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -46,6 +46,8 @@ static const char *const net_access_strings[] = {
>  	[BIT_INDEX(LANDLOCK_ACCESS_NET_BIND_TCP)] = "net.bind_tcp",
>  	[BIT_INDEX(LANDLOCK_ACCESS_NET_CONNECT_TCP)] = "net.connect_tcp",
>  	[BIT_INDEX(LANDLOCK_ACCESS_NET_BIND_UDP)] = "net.bind_udp",
> +	[BIT_INDEX(LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP)] =
> +		"net.connect_send_udp",
>  };
>  
>  static_assert(ARRAY_SIZE(net_access_strings) == LANDLOCK_NUM_ACCESS_NET);
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index c0f30a4591b8..a4d908b240a2 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -23,7 +23,7 @@
>  #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>  
> -#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_BIND_UDP
> +#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP
>  #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
>  
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index f9ccb52e7d45..045881f81295 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -68,16 +68,17 @@ static int current_check_access_socket(struct socket *const sock,
>  
>  	switch (address->sa_family) {
>  	case AF_UNSPEC:
> -		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> +		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> +		    access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
>  			/*
>  			 * Connecting to an address with AF_UNSPEC dissolves
> -			 * the TCP association, which have the same effect as
> -			 * closing the connection while retaining the socket
> -			 * object (i.e., the file descriptor).  As for dropping
> -			 * privileges, closing connections is always allowed.
> -			 *
> -			 * For a TCP access control system, this request is
> -			 * legitimate. Let the network stack handle potential
> +			 * the remote association while retaining the socket
> +			 * object (i.e., the file descriptor). For TCP, it has
> +			 * the same effect as closing the connection. For UDP,
> +			 * it removes any preset remote address. As for
> +			 * dropping privileges, these actions are always
> +			 * allowed.
> +			 * Let the network stack handle potential
>  			 * inconsistencies and return -EINVAL if needed.
>  			 */
>  			return 0;
> @@ -134,7 +135,8 @@ static int current_check_access_socket(struct socket *const sock,
>  		addr4 = (struct sockaddr_in *)address;
>  		port = addr4->sin_port;
>  
> -		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> +		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> +		    access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
>  			audit_net.dport = port;
>  			audit_net.v4info.daddr = addr4->sin_addr.s_addr;
>  		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
> @@ -157,7 +159,8 @@ static int current_check_access_socket(struct socket *const sock,
>  		addr6 = (struct sockaddr_in6 *)address;
>  		port = addr6->sin6_port;
>  
> -		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> +		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> +		    access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
>  			audit_net.dport = port;
>  			audit_net.v6info.daddr = addr6->sin6_addr;
>  		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
> @@ -213,6 +216,50 @@ static int current_check_access_socket(struct socket *const sock,
>  	return -EACCES;
>  }
>  
> +static int current_check_autobind_udp_socket(struct socket *const sock)
> +{
> +	struct sockaddr_storage port0 = { 0 };

unsigned short num;
bool slow;

> +
> +	/*
> +	 * On UDP sockets, if a local port has not already been bound,
> +	 * calling connect() or sending a first datagram has the side
> +	 * effect of autobinding an ephemeral port: we also have to check
> +	 * that the process would have had the right to bind(0) explicitly.


> +	 * Note: socket is not locked, so another thread could do an
> +	 * explicit bind(!=0) on this socket, changing inet_num to non-zero
> +	 * after we read it, but this would only have us enforce an
> +	 * additional bind(0) access check and would not bypass policy.
> +	 */
> +	if (inet_sk(sock->sk)->inet_num != 0)

There is still a race condition, this should fix it:

 *
 * Hold the socket lock around the inet_num read to exclude
 * udp_lib_get_port()'s transient inet_num = snum write that is reverted
 * to 0 on a failing reuseport bind.
 */
if (inet_sk(sock->sk)->inet_num != 0)
slow = lock_sock_fast(sock->sk);
num = inet_sk(sock->sk)->inet_num;
unlock_sock_fast(sock->sk, slow);
if (num != 0)
	return 0;


> +		return 0;
> +
> +	/*
> +	 * Construct a struct sockaddr* with port 0 to pretend the
> +	 * process tried to bind() on that address.
> +	 */
> +	port0.ss_family = sock->sk->__sk_common.skc_family;

Looking at net/, __sk_common.skc_family (and other __sk_common.* fields)
should be replaced by sk_family (see #define in include/net/sock.h).
Same for all other __sk_common.

In fact, it should be READ_ONCE(sock->sk->sk_family) for consistency
with the net/ code and because the socket are not locked when the LSM
hooks are called.  I realized that the existing Landlock code have the
same issue...  Could you please add a new patch (to be backported) to
always use this pattern?

> +	switch (port0.ss_family) {
> +	case AF_INET: {
> +		((struct sockaddr_in *)&port0)->sin_port = 0;
> +		break;
> +	}
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6: {
> +		((struct sockaddr_in6 *)&port0)->sin6_port = 0;
> +		break;
> +	}
> +#endif /* IS_ENABLED(CONFIG_IPV6) */
> +
> +	default:
> +		return 0;
> +	}
> +
> +	return current_check_access_socket(sock, (struct sockaddr *)&port0,
> +					   sizeof(port0),
> +					   LANDLOCK_ACCESS_NET_BIND_UDP);
> +}
> +
>  static int hook_socket_bind(struct socket *const sock,
>  			    struct sockaddr *const address, const int addrlen)
>  {
> @@ -234,14 +281,22 @@ static int hook_socket_connect(struct socket *const sock,
>  			       const int addrlen)
>  {
>  	access_mask_t access_request;
> +	int ret = 0;
>  
>  	if (sk_is_tcp(sock->sk))
>  		access_request = LANDLOCK_ACCESS_NET_CONNECT_TCP;
> +	else if (sk_is_udp(sock->sk))
> +		access_request = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
>  	else
>  		return 0;
>  
> -	return current_check_access_socket(sock, address, addrlen,
> -					   access_request);
> +	ret = current_check_access_socket(sock, address, addrlen,
> +					  access_request);
> +
> +	if (ret == 0 && sk_is_udp(sock->sk))
> +		ret = current_check_autobind_udp_socket(sock);
> +
> +	return ret;
>  }
>  
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index ec392d971ea3..016c7277e370 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -1326,12 +1326,13 @@ FIXTURE_TEARDOWN(mini)
>  
>  /* clang-format off */
>  
> -#define ACCESS_LAST LANDLOCK_ACCESS_NET_BIND_UDP
> +#define ACCESS_LAST LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP
>  
>  #define ACCESS_ALL ( \
>  	LANDLOCK_ACCESS_NET_BIND_TCP | \
>  	LANDLOCK_ACCESS_NET_CONNECT_TCP | \
> -	LANDLOCK_ACCESS_NET_BIND_UDP)
> +	LANDLOCK_ACCESS_NET_BIND_UDP | \
> +	LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP)
>  
>  /* clang-format on */
>  
> -- 
> 2.39.5
> 

