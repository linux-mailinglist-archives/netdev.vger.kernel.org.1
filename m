Return-Path: <netdev+bounces-160766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01BEA1B463
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 12:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDC13A797F
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5374B1CDA19;
	Fri, 24 Jan 2025 11:05:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4E23B0;
	Fri, 24 Jan 2025 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737716749; cv=none; b=PBVCxpOBah6A8998WTPU3sTl4tDmmlYVNhJ1Z2dxrriszZoht0FtjQFfNNIs9hAlIFz8J8hiP4IeVO6Y3gJS2kgQ8fTrhq4roFaAvPS2fxRaeotXiUJptZNXQFYiBdkQ9NShXpOIoWHRZs5/gBXNyjQTPNRaoCliEuAKkcHsK9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737716749; c=relaxed/simple;
	bh=5nY2o5sU7aLXqQ9kn/LZK1GlINByl8IHmNr1xj3mPY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ggS5QIayxhdv0xePZYv2sv7Uo1kHXallJJaQ0uBw18k3uUuXDz9+n5qVcBLzTK3nDngI3SfPmYk11Z+ordVRndYU8K1ewgryJRfvdjKUtVQ0qjoEk2Md4JJ4q8Vw5o/hcUwbIvZSwhIL/25Ll7eVYXxvRYf5lSNR2dFn2W5YNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YfZgP1X08z6M4HB;
	Fri, 24 Jan 2025 19:03:45 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F17D140119;
	Fri, 24 Jan 2025 19:05:43 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 24 Jan 2025 14:05:41 +0300
Message-ID: <277b6e70-7749-c75d-3ac0-f55c886f9d57@huawei-partners.com>
Date: Fri, 24 Jan 2025 14:05:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] landlock: Add UDP sendmsg access control
Content-Language: ru
To: Matthieu Buffet <matthieu@buffet.re>, Mickael Salaun <mic@digikod.net>
CC: Gunther Noack <gnoack@google.com>, <konstantin.meskhidze@huawei.com>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20241214184540.3835222-1-matthieu@buffet.re>
 <20241214184540.3835222-4-matthieu@buffet.re>
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <20241214184540.3835222-4-matthieu@buffet.re>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 12/14/2024 9:45 PM, Matthieu Buffet wrote:
> Add support for a LANDLOCK_ACCESS_NET_SENDTO_UDP access right,
> complementing the two previous LANDLOCK_ACCESS_NET_CONNECT_UDP and
> LANDLOCK_ACCESS_NET_BIND_UDP.
> It allows denying and delegating the right to sendto() datagrams with an
> explicit destination address and port, without requiring to connect() the
> socket first.

What do you mean by "delegating" here? I suggest changing last sentence
to something like

"This provides control over setting of the UDP socket destination
address in sendto(), sendmsg(), send(), sendmmsg(), complementing
the control of connect(2)".

> 
> Performance is of course worse if you send many datagrams this way,
> compared to just connect() then sending without an address (except if you
> use sendmmsg() which caches LSM results). This may still be desired by
> applications which send few enough datagrams to different clients that
> opening and connecting a socket for each one of them is not worth it.

I'm not sure if overhead is gonna be sensible for the average case, we
need to get some testing results first.

> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>   include/uapi/linux/landlock.h | 14 ++++++
>   security/landlock/limits.h    |  2 +-
>   security/landlock/net.c       | 88 +++++++++++++++++++++++++++++++++++
>   3 files changed, 103 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 3f7b8e85822d..8b355891e986 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -295,6 +295,19 @@ struct landlock_net_port_attr {
>    *   every time), or for servers that want to filter which client address
>    *   they want to receive datagrams from (e.g. creating a client-specific
>    *   socket)
> + * - %LANDLOCK_ACCESS_NET_SENDTO_UDP: send datagrams with an explicit
> + *   destination address set to the given remote port. This access right
> + *   is checked in sendto(), sendmsg() and sendmmsg() when the destination
> + *   address passed is not NULL. This access right is not required when
> + *   sending datagrams without an explicit destination (via a connected
> + *   socket, e.g. with send()). Sending datagrams with explicit addresses
> + *   induces a non-negligible overhead, so calling connect() once and for
> + *   all should be preferred. When not possible and sending many datagrams,
> + *   using sendmmsg() may reduce the access control overhead.

I suggest changing:
* "send datagrams" to "Send datagrams",
* "send datagrams" to "send UDP datagrams" for clarity,
* "This access right is not required when sending [...]" to "This access
   right do not control sending [...]".

Again, I don't think that overhead should be noted here: we do not have
any data yet.

> + *
> + * Blocking an application from sending UDP traffic requires adding both
> + * %LANDLOCK_ACCESS_NET_SENDTO_UDP and %LANDLOCK_ACCESS_NET_CONNECT_UDP
> + * to the handled access rights list.
>    *
>    * Note that binding on port 0 means binding to an ephemeral
>    * kernel-assigned port, in the range configured in
> @@ -306,6 +319,7 @@ struct landlock_net_port_attr {
>   #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
>   #define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL << 2)
>   #define LANDLOCK_ACCESS_NET_CONNECT_UDP			(1ULL << 3)
> +#define LANDLOCK_ACCESS_NET_SENDTO_UDP			(1ULL << 4)
>   /* clang-format on */
>   
>   /**
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index ca90c1c56458..8d12ca39cf2e 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -22,7 +22,7 @@
>   #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>   #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>   
> -#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_UDP
> +#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_SENDTO_UDP
>   #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
>   #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
>   
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index 1c5cf2ddb7c1..0556d8a21d0b 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -10,6 +10,8 @@
>   #include <linux/net.h>
>   #include <linux/socket.h>
>   #include <net/ipv6.h>
> +#include <net/transp_v6.h>
> +#include <net/ip.h>
>   
>   #include "common.h"
>   #include "cred.h"
> @@ -155,6 +157,27 @@ static int current_check_access_socket(struct socket *const sock,
>   	return -EACCES;
>   }
>   
> +static int check_access_port(const struct landlock_ruleset *const dom,
> +			     access_mask_t access_request, __be16 port)
> +{
> +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_NET] = {};
> +	const struct landlock_rule *rule;
> +	const struct landlock_id id = {
> +		.key.data = (__force uintptr_t)port,
> +		.type = LANDLOCK_KEY_NET_PORT,
> +	};
> +	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
> +
> +	rule = landlock_find_rule(dom, id);
> +	access_request = landlock_init_layer_masks(
> +		dom, access_request, &layer_masks, LANDLOCK_KEY_NET_PORT);
> +	if (landlock_unmask_layers(rule, access_request, &layer_masks,
> +				   ARRAY_SIZE(layer_masks)))
> +		return 0;
> +
> +	return -EACCES;
> +}
> +
>   static int hook_socket_bind(struct socket *const sock,
>   			    struct sockaddr *const address, const int addrlen)
>   {
> @@ -190,9 +213,74 @@ static int hook_socket_connect(struct socket *const sock,
>   					   access_request);
>   }
>   
> +static int hook_socket_sendmsg(struct socket *const sock,
> +			       struct msghdr *const msg, const int size)
> +{
> +	const struct landlock_ruleset *const dom =
> +		landlock_get_applicable_domain(landlock_get_current_domain(),
> +					       any_net);
> +	const struct sockaddr *address = (const struct sockaddr *)msg->msg_name;
> +	const int addrlen = msg->msg_namelen;
> +	__be16 port;
> +
> +	if (!dom)
> +		return 0;
> +	if (WARN_ON_ONCE(dom->num_layers < 1))
> +		return -EACCES;
> +	/*
> +	 * If there is no explicit address in the message, we have no
> +	 * policy to enforce here because either:
> +	 * - the socket was previously connect()ed, so the appropriate
> +	 *   access check has already been done back then;

I suggest changing "connect()ed" to "assigned with destination address":
connected socket usually implies connection-oriented protocol and
"connect()ed" implies connect(2) operation, but socket may be connected
by previous sendto() call.

> +	 * - the socket is unconnected, so we can let the networking stack
> +	 *   reply -EDESTADDRREQ

nit: missing dot

> +	 */
> +	if (!address)
> +		return 0;
> +
> +	if (!sk_is_udp(sock->sk))
> +		return 0;
> +
> +	/* Checks for minimal header length to safely read sa_family. */
> +	if (addrlen < offsetofend(typeof(*address), sa_family))
> +		return -EINVAL;
> +
> +	switch (address->sa_family) {
> +	case AF_UNSPEC:
> +		/*
> +		 * Parsed as "no address" in udpv6_sendmsg(), which means
> +		 * we fall back into the case checked earlier: policy was
> +		 * enforced at connect() time, nothing to enforce here.
> +		 */
> +		if (sock->sk->sk_prot == &udpv6_prot)
> +			return 0;
> +		/* Parsed as "AF_INET" in udp_sendmsg() */
> +		fallthrough;
> +	case AF_INET:
> +		if (addrlen < sizeof(struct sockaddr_in))
> +			return -EINVAL;
> +		port = ((struct sockaddr_in *)address)->sin_port;
> +		break;
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +		if (addrlen < SIN6_LEN_RFC2133)
> +			return -EINVAL;
> +		port = ((struct sockaddr_in6 *)address)->sin6_port;
> +		break;
> +#endif /* IS_ENABLED(CONFIG_IPV6) */
> +
> +	default:
> +		return -EAFNOSUPPORT;

IPv6 socket should return -EINVAL here (Cf. udpv6_sendmsg()).

> +	}
> +
> +	return check_access_port(dom, LANDLOCK_ACCESS_NET_SENDTO_UDP, port);
> +}
> +
>   static struct security_hook_list landlock_hooks[] __ro_after_init = {
>   	LSM_HOOK_INIT(socket_bind, hook_socket_bind),
>   	LSM_HOOK_INIT(socket_connect, hook_socket_connect),
> +	LSM_HOOK_INIT(socket_sendmsg, hook_socket_sendmsg),
>   };
>   
>   __init void landlock_add_net_hooks(void)

