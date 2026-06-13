Return-Path: <netdev+bounces-299048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oYsiBvLDLWrHjgQAu9opvQ
	(envelope-from <netdev+bounces-299048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:56:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B4867FBD8
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:56:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=digikod.net header.s=20191114 header.b=zLErSww5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299048-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299048-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2826A300D6A5
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3C136CDE0;
	Sat, 13 Jun 2026 20:56:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719D357CFF
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:56:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781384172; cv=none; b=rjOfS3RbFFd25j0EK+kYeuSJSgmkRkVlx1BTvWJM6fA6+bTLqgqP+phYffmEqrljB/Q5CdlV+DoxLdfVcs0v48FH9oU7I5JX+cDDKCDCGiSTtc9MNwlcnOanPpIx06sFUs8MVrhdlrPQJZ55TJ4AhyqiG+MHqTcg46M85e5xQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781384172; c=relaxed/simple;
	bh=hGr+h6spCkUT5CZRkyIkjFITmIsGA0Z7PiXFRIZ94+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFGh9PwHrKN12HeI4bL9CVOiBOFoQlMc1nIukX5Gj5H80Eoeut67k3UNkM6uKDU4e8RvXSOuc5tXzLSAJBwIeq3vobWC2iSzmLrEaHMdhbFRqMQEuHa/MMIKavoVpN1wZ5nk4zHnAJH+cKwuxTUp5elWHPLJmNseZRnzeqc9M1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zLErSww5; arc=none smtp.client-ip=185.125.25.9
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gd7vh6BqYz9SN;
	Sat, 13 Jun 2026 22:56:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781384160;
	bh=Q0kJJUoiZCmP/sIpP04fpOoepySYT52l9jt2tcq/VvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zLErSww5lDsxxZ6+Aum4zOOazNTGdZAgh4Kmyc2/gO02Uv3sxymqKRdAbt3atTKie
	 bXlI8S7oGJLNkpCGwn0BXT1zq8z3a0ghl9BvUbV6B/oEcUsVK/dOyjoSuNTwmjuO8H
	 RO2uyn5j+BYmmLIgTV3MCC2uy2WQ8kMKrIQhp5h4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gd7vg3d2BzHxy;
	Sat, 13 Jun 2026 22:55:59 +0200 (CEST)
Date: Sat, 13 Jun 2026 22:55:58 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v5 2/6] landlock: Add UDP send+connect access control
Message-ID: <20260613.aiteizei1aiJ@digikod.net>
References: <20260611162107.49278-1-matthieu@buffet.re>
 <20260611162107.49278-3-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611162107.49278-3-matthieu@buffet.re>
X-Infomaniak-Routing: alpha
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.99 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299048-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	FORGED_RECIPIENTS(0.00)[m:matthieu@buffet.re,m:gnoack@google.com,m:linux-security-module@vger.kernel.org,m:ivanov.mikhail1@huawei-partners.com,m:konstantin.meskhidze@huawei.com,m:m@maowtm.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[digikod.net];
	FORGED_SENDER(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,audit_net.sk:url,audit_net.family:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57B4867FBD8

A few issues were identified by Sashiko:
https://sashiko.dev/#/patchset/20260611162107.49278-1-matthieu%40buffet.re

I squashed this patch:

diff --git a/security/landlock/net.c b/security/landlock/net.c
index 9273cdbbf844..b12568666a9e 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -261,10 +261,17 @@ static int current_check_access_socket(struct socket *const sock,
 
 static int current_check_autobind_udp_socket(struct socket *const sock)
 {
+	const struct access_masks bind_udp = {
+		.net = LANDLOCK_ACCESS_NET_BIND_UDP,
+	};
 	struct sockaddr_storage port0 = {};
 	unsigned short num;
 	bool slow;
 
+	/* Quick return for non-Landlocked tasks. */
+	if (!landlock_get_applicable_subject(current_cred(), bind_udp, NULL))
+		return 0;
+
 	/*
 	 * On UDP sockets, if a local port has not already been bound, calling
 	 * connect() or sending a first datagram has the side effect of
@@ -287,8 +294,7 @@ static int current_check_autobind_udp_socket(struct socket *const sock)
 	port0.ss_family = READ_ONCE(sock->sk->sk_family);
 
 	return current_check_access_socket(sock, (struct sockaddr *)&port0,
-					   sizeof(port0),
-					   LANDLOCK_ACCESS_NET_BIND_UDP, false);
+					   sizeof(port0), bind_udp.net, false);
 }
 
 static int hook_socket_bind(struct socket *const sock,
@@ -328,7 +334,9 @@ static int hook_socket_connect(struct socket *const sock,
 	 * connect()ing to an AF_UNSPEC address does not trigger an autobind and
 	 * should never be restricted.
 	 */
-	if (ret == 0 && sk_is_udp(sock->sk) && address->sa_family != AF_UNSPEC)
+	if (ret == 0 && sk_is_udp(sock->sk) &&
+	    addrlen >= offsetofend(typeof(*address), sa_family) &&
+	    address->sa_family != AF_UNSPEC)
 		ret = current_check_autobind_udp_socket(sock);
 
 	return ret;


We might want to factor out some code, but that should be good for now.


On Thu, Jun 11, 2026 at 06:21:02PM +0200, Matthieu Buffet wrote:
> Add support for a second fine-grained UDP access right.
> LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP controls the ability to set the
> remote port of a socket (via connect()) and to specify an explicit
> destination when sending a datagram, to override any remote peer set on
> a UDP socket (e.g. in sendto() or sendmsg()).
> It will be useful for applications that send datagrams, and for some
> servers too (those creating per-client sockets, which want to receive
> traffic only from a specific address).
> 
> Similarly as for bind(), this access control is performed when
> configuring sockets, not in hot code paths.
> 
> Add detection of when autobind is about to be required, and deny the
> operation if the process would not be allowed to call bind(0)
> explicitly. Autobind can only be performed in udp_lib_get_port() from
> code paths already controlled by LSM hooks: when connect()ing,
> sending a first datagram, and in some splice() EOF edge case which,
> afaiu, can only happen after a remote peer has been set. This invariant
> needs to be preserved to keep bind policies actually enforced.
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  include/uapi/linux/landlock.h               |  23 ++++
>  security/landlock/audit.c                   |   2 +
>  security/landlock/limits.h                  |   2 +-
>  security/landlock/net.c                     | 137 +++++++++++++++++---
>  tools/testing/selftests/landlock/net_test.c |   5 +-
>  5 files changed, 151 insertions(+), 18 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 045b251ff1b4..b147223efc97 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -378,11 +378,34 @@ struct landlock_net_port_attr {
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
> + *
> + * .. note:: Sending datagrams to an ``AF_UNSPEC`` destination address
> + *   family is not supported for IPv6 UDP sockets: you will need to use a
> + *   ``NULL`` address instead.
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
> index 8da40614c452..0e697403eca9 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -44,7 +44,8 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
>  static int current_check_access_socket(struct socket *const sock,
>  				       struct sockaddr *const address,
>  				       const int addrlen,
> -				       access_mask_t access_request)
> +				       access_mask_t access_request,
> +				       bool connecting)
>  {
>  	unsigned short sock_family;
>  	__be16 port;
> @@ -75,19 +76,51 @@ static int current_check_access_socket(struct socket *const sock,
>  
>  	switch (address->sa_family) {
>  	case AF_UNSPEC:
> -		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> +		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> +		    (access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP &&
> +		     connecting)) {
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
> +		} else if (access_request ==
> +			   LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
> +			if (sock_family == AF_INET6) {
> +				/*
> +				 * We cannot allow sending UDP datagrams to an
> +				 * explicit AF_UNSPEC address on IPv6 sockets,
> +				 * even if AF_UNSPEC is treated as "no address"
> +				 * on such sockets (so it should always be allowed).
> +				 * That's because the socket's family can change under
> +				 * our feet (if another thread calls setsockopt(IPV6_ADDRFORM))
> +				 * to IPv4, which would then treat AF_UNSPEC as
> +				 * AF_INET.
> +				 */
> +				audit_net.family = AF_UNSPEC;
> +				audit_net.sk = sock->sk;
> +				landlock_init_layer_masks(
> +					subject->domain, access_request,
> +					&layer_masks, LANDLOCK_KEY_NET_PORT);
> +				landlock_log_denial(
> +					subject,
> +					&(struct landlock_request){
> +						.type = LANDLOCK_REQUEST_NET_ACCESS,
> +						.audit.type =
> +							LSM_AUDIT_DATA_NET,
> +						.audit.u.net = &audit_net,
> +						.access = access_request,
> +						.layer_masks = &layer_masks,
> +					});
> +				return -EACCES;
> +			}
>  		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
>  			   access_request == LANDLOCK_ACCESS_NET_BIND_UDP) {
>  			/*
> @@ -130,7 +163,11 @@ static int current_check_access_socket(struct socket *const sock,
>  		} else {
>  			WARN_ON_ONCE(1);
>  		}
> -		/* Only for bind(AF_UNSPEC+INADDR_ANY) on IPv4 socket. */
> +		/*
> +		 * AF_UNSPEC is treated as AF_INET only in
> +		 * bind(AF_UNSPEC+INADDR_ANY) on IPv4 sockets and
> +		 * when sending to AF_UNSPEC addresses on IPv4 sockets.
> +		 */
>  		fallthrough;
>  	case AF_INET: {
>  		const struct sockaddr_in *addr4;
> @@ -141,7 +178,8 @@ static int current_check_access_socket(struct socket *const sock,
>  		addr4 = (struct sockaddr_in *)address;
>  		port = addr4->sin_port;
>  
> -		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> +		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> +		    access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
>  			audit_net.dport = port;
>  			audit_net.v4info.daddr = addr4->sin_addr.s_addr;
>  		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
> @@ -164,7 +202,8 @@ static int current_check_access_socket(struct socket *const sock,
>  		addr6 = (struct sockaddr_in6 *)address;
>  		port = addr6->sin6_port;
>  
> -		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> +		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> +		    access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
>  			audit_net.dport = port;
>  			audit_net.v6info.daddr = addr6->sin6_addr;
>  		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
> @@ -221,6 +260,38 @@ static int current_check_access_socket(struct socket *const sock,
>  	return -EACCES;
>  }
>  
> +static int current_check_autobind_udp_socket(struct socket *const sock)
> +{
> +	struct sockaddr_storage port0 = {};
> +	unsigned short num;
> +	bool slow;
> +
> +	/*
> +	 * On UDP sockets, if a local port has not already been bound,
> +	 * calling connect() or sending a first datagram has the side
> +	 * effect of autobinding an ephemeral port: we also have to check
> +	 * that the process would have had the right to bind(0) explicitly.
> +	 * Hold the socket lock around the inet_num read to exclude
> +	 * udp_lib_get_port()'s transient inet_num = snum write that is
> +	 * reverted to 0 on a failing reuseport bind.
> +	 */
> +	slow = lock_sock_fast(sock->sk);
> +	num = inet_sk(sock->sk)->inet_num;
> +	unlock_sock_fast(sock->sk, slow);
> +	if (num != 0)
> +		return 0;
> +
> +	/*
> +	 * Construct a struct sockaddr* with port 0 to pretend the
> +	 * process tried to bind() on that address.
> +	 */
> +	port0.ss_family = READ_ONCE(sock->sk->sk_family);
> +
> +	return current_check_access_socket(sock, (struct sockaddr *)&port0,
> +					   sizeof(port0),
> +					   LANDLOCK_ACCESS_NET_BIND_UDP, false);
> +}
> +
>  static int hook_socket_bind(struct socket *const sock,
>  			    struct sockaddr *const address, const int addrlen)
>  {
> @@ -234,7 +305,7 @@ static int hook_socket_bind(struct socket *const sock,
>  		return 0;
>  
>  	return current_check_access_socket(sock, address, addrlen,
> -					   access_request);
> +					   access_request, false);
>  }
>  
>  static int hook_socket_connect(struct socket *const sock,
> @@ -242,19 +313,55 @@ static int hook_socket_connect(struct socket *const sock,
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
> +					  access_request, true);
> +
> +	/*
> +	 * connect()ing to an AF_UNSPEC address does not trigger an
> +	 * autobind and should never be restricted.
> +	 */
> +	if (ret == 0 && sk_is_udp(sock->sk) && address->sa_family != AF_UNSPEC)
> +		ret = current_check_autobind_udp_socket(sock);
> +
> +	return ret;
> +}
> +
> +static int hook_socket_sendmsg(struct socket *const sock,
> +			       struct msghdr *const msg, const int size)
> +{
> +	struct sockaddr *const address = msg->msg_name;
> +	const int addrlen = msg->msg_namelen;
> +	access_mask_t access_request;
> +	int ret = 0;
> +
> +	if (sk_is_udp(sock->sk))
> +		access_request = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
> +	else
> +		return 0;
> +
> +	if (address != NULL)
> +		ret = current_check_access_socket(sock, address, addrlen,
> +						  access_request, false);
> +
> +	if (ret == 0)
> +		ret = current_check_autobind_udp_socket(sock);
> +
> +	return ret;
>  }
>  
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(socket_bind, hook_socket_bind),
>  	LSM_HOOK_INIT(socket_connect, hook_socket_connect),
> +	LSM_HOOK_INIT(socket_sendmsg, hook_socket_sendmsg),
>  };
>  
>  __init void landlock_add_net_hooks(void)
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
> 2.47.3
> 
> 

