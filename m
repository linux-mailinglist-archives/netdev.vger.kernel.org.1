Return-Path: <netdev+bounces-160765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08065A1B453
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 12:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7258D1681A8
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E06B1D516C;
	Fri, 24 Jan 2025 11:01:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C270815;
	Fri, 24 Jan 2025 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737716478; cv=none; b=gdovep3UP6c9kcsrGpJeF68M7Fq97rS+1MrXz6NT1mzaUOKJ9UAacAZK1PVjLN9C42RD9UB3UBvfWFZ0UpufJnKK+bFZAnfjDHI/RNHIcASVsQo84n9AGv1jYSAX8zeAh7FDlfZH5HeJPja6y6oQfyrB7l7z6peSsfm4d7gOIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737716478; c=relaxed/simple;
	bh=OF6WwY3BCRAfC237B+OD+PylPIRU7WUAUlvU7TVK7NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h9xZgmdpAJiOAF5chqKDFihYlct/FzyU0m4pPQu0N3/lr5jlOEA2HuyrzfHw1aXgifWRRObhGBFqmXud7WMT5nwukMIQ/SM8bcMIFCepxkq+cSbypj1fvhVtKGI4kXLVzTl0Rkp1zg3qaHk2bCj/w+N9VQVARaGrOP98RuHPAeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YfZZ91FjYz6L50p;
	Fri, 24 Jan 2025 18:59:13 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id E53541402DB;
	Fri, 24 Jan 2025 19:01:11 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 24 Jan 2025 14:01:10 +0300
Message-ID: <3f7d0c6f-615b-9fa6-d4f5-0f074f2b678e@huawei-partners.com>
Date: Fri, 24 Jan 2025 14:01:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] landlock: Add UDP bind+connect access control
Content-Language: ru
To: Matthieu Buffet <matthieu@buffet.re>, Mickael Salaun <mic@digikod.net>
CC: Gunther Noack <gnoack@google.com>, <konstantin.meskhidze@huawei.com>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20241214184540.3835222-1-matthieu@buffet.re>
 <20241214184540.3835222-2-matthieu@buffet.re>
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <20241214184540.3835222-2-matthieu@buffet.re>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 12/14/2024 9:45 PM, Matthieu Buffet wrote:
> If an app doesn't need to be able to open UDP sockets, it should be
> denied the right to create UDP sockets altogether (via seccomp and/or
> https://github.com/landlock-lsm/linux/issues/6 when it lands).
> For apps using UDP, add support for two more fine-grained access rights:
> 
> - LANDLOCK_ACCESS_NET_CONNECT_UDP, to gate the possibility to connect()
>    a UDP socket. For client apps (those which want to avoid specifying a
>    destination for each datagram in sendmsg()), and for a few servers
>    (those creating per-client sockets, which want to receive traffic only
>    from a specific address)
> 
> - LANDLOCK_ACCESS_NET_BIND_UDP, to gate the possibility to bind() a UDP
>    socket. For most servers (to start listening for datagrams on a
>    non-ephemeral port) and can be useful for some client applications (to
>    set the source port of future datagrams, e.g. mDNS requires to use
>    source port 5353)
> 
> No restriction is enforced on send()/recv() to preserve performance.
> The security boundary is to prevent acquiring a bound/connected socket.
> 
> Bump ABI to v7 to allow userland to detect and use these new restrictions.
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>   include/uapi/linux/landlock.h | 53 ++++++++++++++++++++++++++---------
>   security/landlock/limits.h    |  2 +-
>   security/landlock/net.c       | 49 ++++++++++++++++++++++----------
>   security/landlock/syscalls.c  |  2 +-
>   4 files changed, 76 insertions(+), 30 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 33745642f787..3f7b8e85822d 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -119,12 +119,15 @@ struct landlock_net_port_attr {
>   	 *
>   	 * It should be noted that port 0 passed to :manpage:`bind(2)` will bind
>   	 * to an available port from the ephemeral port range.  This can be
> -	 * configured with the ``/proc/sys/net/ipv4/ip_local_port_range`` sysctl
> -	 * (also used for IPv6).
> +	 * configured globally with the
> +	 * ``/proc/sys/net/ipv4/ip_local_port_range`` sysctl (also used for
> +	 * IPv6), and, within that first range, on a per-socket basis using
> +	 * ``setsockopt(IP_LOCAL_PORT_RANGE)``.
>   	 *
> -	 * A Landlock rule with port 0 and the ``LANDLOCK_ACCESS_NET_BIND_TCP``
> -	 * right means that requesting to bind on port 0 is allowed and it will
> -	 * automatically translate to binding on the related port range.
> +	 * A Landlock rule with port 0 and the %LANDLOCK_ACCESS_NET_BIND_TCP
> +	 * or %LANDLOCK_ACCESS_NET_BIND_UDP right means that requesting to
> +	 * bind on port 0 is allowed and it will automatically translate to
> +	 * binding on the ephemeral port range.
>   	 */
>   	__u64 port;
>   };
> @@ -267,18 +270,42 @@ struct landlock_net_port_attr {
>    * Network flags
>    * ~~~~~~~~~~~~~~~~
>    *
> - * These flags enable to restrict a sandboxed process to a set of network
> - * actions. This is supported since the Landlock ABI version 4.
> - *
> - * The following access rights apply to TCP port numbers:
> - *
> - * - %LANDLOCK_ACCESS_NET_BIND_TCP: Bind a TCP socket to a local port.
> - * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect an active TCP socket to
> - *   a remote port.
> + * These flags enable to restrict which network-related actions a sandboxed
> + * process can take. TCP support was added in Landlock ABI version 4, and UDP
> + * support in version 7.

Better to place ABI version of TCP and UDP support in the related
headers (similar to fs flags).

> + *
> + * TCP access rights:
> + *
> + * - %LANDLOCK_ACCESS_NET_BIND_TCP: bind sockets to the given local port,
> + *   for servers that will listen() on that port, or for clients that want
> + *   to open connections with that specific source port instead of using a
> + *   kernel-assigned random ephemeral one
> + * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: connect client sockets to servers
> + *   listening on that remote port

Changes related to refactoring are better to be placed in a separate
commit.

(Following notes related to UDP flags as well):

Please follow format of the comments: sentences should start with an
upper letter and end with a dot (Cf. fs flags).

I'm not sure if we need to explain the semantics of bind(2), connect(2)
here and use "server - client" wording.

I suggest specifying that socket is a "TCP socket" for the sake of
clarity.

> + *
> + * UDP access rights:
> + *
> + * - %LANDLOCK_ACCESS_NET_BIND_UDP: bind sockets to the given local port,
> + *   for servers that will listen() on that port, or for clients that want
> + *   to send datagrams with that specific source port instead of using a
> + *   kernel-assigned random ephemeral one

listen(2) is not supported for UDP sockets.

> + * - %LANDLOCK_ACCESS_NET_CONNECT_UDP: connect sockets to the given remote
> + *   port, either for clients that will send datagrams to that destination
> + *   (and want to send them faster without specifying an explicit address
> + *   every time), or for servers that want to filter which client address
> + *   they want to receive datagrams from (e.g. creating a client-specific
> + *   socket)

It's not very correct to say that a UDP socket *connects* to a remote
port with connect(2), since UDP is connectionless and in this case
connect(2) only assigns UDP socket with a destination port.

> + *
> + * Note that binding on port 0 means binding to an ephemeral
> + * kernel-assigned port, in the range configured in
> + * ``/proc/sys/net/ipv4/ip_local_port_range`` globally (and, within that
> + * range, on a per-socket basis with ``setsockopt(IP_LOCAL_PORT_RANGE)``).

I think it'll be better to have note about handling 0 port in a single
place only.

>    */
>   /* clang-format off */
>   #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
>   #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
> +#define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL << 2)
> +#define LANDLOCK_ACCESS_NET_CONNECT_UDP			(1ULL << 3)
>   /* clang-format on */
>   
>   /**
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 15f7606066c8..ca90c1c56458 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -22,7 +22,7 @@
>   #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>   #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>   
> -#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_TCP
> +#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_UDP
>   #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
>   #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
>   
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index d5dcc4407a19..1c5cf2ddb7c1 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -63,10 +63,6 @@ static int current_check_access_socket(struct socket *const sock,
>   	if (WARN_ON_ONCE(dom->num_layers < 1))
>   		return -EACCES;
>   
> -	/* Checks if it's a (potential) TCP socket. */
> -	if (sock->type != SOCK_STREAM)
> -		return 0;
> -
>   	/* Checks for minimal header length to safely read sa_family. */
>   	if (addrlen < offsetofend(typeof(*address), sa_family))
>   		return -EINVAL;
> @@ -94,17 +90,19 @@ static int current_check_access_socket(struct socket *const sock,
>   	/* Specific AF_UNSPEC handling. */
>   	if (address->sa_family == AF_UNSPEC) {
>   		/*
> -		 * Connecting to an address with AF_UNSPEC dissolves the TCP
> -		 * association, which have the same effect as closing the
> -		 * connection while retaining the socket object (i.e., the file
> -		 * descriptor).  As for dropping privileges, closing
> -		 * connections is always allowed.
> -		 *
> -		 * For a TCP access control system, this request is legitimate.
> +		 * Connecting to an address with AF_UNSPEC dissolves the
> +		 * remote association while retaining the socket object
> +		 * (i.e., the file descriptor). For TCP, it has the same
> +		 * effect as closing the connection. For UDP, it removes
> +		 * any preset destination for future datagrams.
> +		 * Like dropping privileges, these actions are always
> +		 * allowed: access control is performed when bind()ing or
> +		 * connect()ing.

May be better to remove the last line - "access control is performed..".

>   		 * Let the network stack handle potential inconsistencies and
>   		 * return -EINVAL if needed.
>   		 */
> -		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP)
> +		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> +		    access_request == LANDLOCK_ACCESS_NET_CONNECT_UDP)
>   			return 0;
>   
>   		/*
> @@ -118,7 +116,8 @@ static int current_check_access_socket(struct socket *const sock,
>   		 * checks, but it is safer to return a proper error and test
>   		 * consistency thanks to kselftest.
>   		 */
> -		if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
> +		if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
> +		    access_request == LANDLOCK_ACCESS_NET_BIND_UDP) {
>   			/* addrlen has already been checked for AF_UNSPEC. */
>   			const struct sockaddr_in *const sockaddr =
>   				(struct sockaddr_in *)address;
> @@ -159,16 +158,36 @@ static int current_check_access_socket(struct socket *const sock,
>   static int hook_socket_bind(struct socket *const sock,
>   			    struct sockaddr *const address, const int addrlen)
>   {
> +	access_mask_t access_request;
> +
> +	/* Checks if it's a (potential) TCP socket. */
> +	if (sock->type == SOCK_STREAM)
> +		access_request = LANDLOCK_ACCESS_NET_BIND_TCP;
> +	else if (sk_is_udp(sock->sk))
> +		access_request = LANDLOCK_ACCESS_NET_BIND_UDP;
> +	else
> +		return 0;
> +
>   	return current_check_access_socket(sock, address, addrlen,
> -					   LANDLOCK_ACCESS_NET_BIND_TCP);
> +					   access_request);
>   }
>   
>   static int hook_socket_connect(struct socket *const sock,
>   			       struct sockaddr *const address,
>   			       const int addrlen)
>   {
> +	access_mask_t access_request;
> +
> +	/* Checks if it's a (potential) TCP socket. */
> +	if (sock->type == SOCK_STREAM)
> +		access_request = LANDLOCK_ACCESS_NET_CONNECT_TCP;
> +	else if (sk_is_udp(sock->sk))
> +		access_request = LANDLOCK_ACCESS_NET_CONNECT_UDP;
> +	else
> +		return 0;
> +
>   	return current_check_access_socket(sock, address, addrlen,
> -					   LANDLOCK_ACCESS_NET_CONNECT_TCP);
> +					   access_request);
>   }
>   
>   static struct security_hook_list landlock_hooks[] __ro_after_init = {
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index c097d356fa45..200f771fa3a4 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -150,7 +150,7 @@ static const struct file_operations ruleset_fops = {
>   	.write = fop_dummy_write,
>   };
>   
> -#define LANDLOCK_ABI_VERSION 6
> +#define LANDLOCK_ABI_VERSION 7
>   
>   /**
>    * sys_landlock_create_ruleset - Create a new ruleset

