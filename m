Return-Path: <netdev+bounces-290918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGFlF4/GEGoLdgYAu9opvQ
	(envelope-from <netdev+bounces-290918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:11:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B566E5BA440
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5102730125D3
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 21:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A75E35A385;
	Fri, 22 May 2026 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1Ktj+xl/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD627AC31
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484267; cv=none; b=j/UKlQc7w51M/Bc2Khyw3BWW0Ypxc3QcC5cWb1nqZFwhBgU1a5nL1dha4P3pDY68zSXHLWR2v478lh2+dlpRZzuwde7Kn8bw1xoOXqCmyQBpiQ3kkXMCgXno69krlK8clTz+BUJZFq41uBCKhOTilrm/mAEieI8d+koWkVFzuIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484267; c=relaxed/simple;
	bh=06HJRSrrUMzj7DL8RB8Ye1eXAEUrNCre6d9ye2wUcpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqyd2tWqp1J7aljCRU8SwqnWsRgpyfJooN090+yK3lN7lZnHg6FH1x8TPmdYu24u0Y/zVDT/tz/Ar359jPkV++xrJ/NPUSLVOSgFCfZXRo3SSU7TrUku1pipJRZ+4rHD9wAU6iIyMOobLbkMuKnqfKJ0i/HcPHtXklIk4Gn8+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1Ktj+xl/; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gMdH45TSBz87P;
	Fri, 22 May 2026 23:10:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779484256;
	bh=vpUyp6y8XSLwq9yCGVBTPnQHDjNH3wqxIcnZsgeppeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1Ktj+xl/yykYj/fFkvKVEUrCd7y2PfIBuaA/hp19qCeaoK53pjyjzjHFMgbHgNw3N
	 CsGknSbeiYMktDmQbTt/vY9ANDfDUMQ5Lh7lN3UTkYevCg0VD3/PyA+6iveT7ogJqG
	 vhNiPRj66Lb7+a5N/vGFoYGTQmhBqoYO9f8ChgL0=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gMdH365QBzLxd;
	Fri, 22 May 2026 23:10:55 +0200 (CEST)
Date: Fri, 22 May 2026 23:10:53 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>, netdev@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v4 3/7] landlock: Add UDP send access control
Message-ID: <20260522.Shi4UuKeH6ch@digikod.net>
References: <20260502124306.3975990-1-matthieu@buffet.re>
 <20260502124306.3975990-4-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260502124306.3975990-4-matthieu@buffet.re>
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-0.95 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	TAGGED_FROM(0.00)[bounces-290918-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,audit_net.family:url,buffet.re:email]
X-Rspamd-Queue-Id: B566E5BA440
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 02, 2026 at 02:43:02PM +0200, Matthieu Buffet wrote:
> Add the second half of LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP: control the
> ability to specify an explicit destination when sending a datagram, to
> override any remote peer set on a UDP socket (in sendto(), sendmsg(), and
> sendmmsg()). It will make the right useful for clients which want to
> send datagrams while specifying a destination address each time.
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  include/uapi/linux/landlock.h |  4 ++
>  security/landlock/net.c       | 70 ++++++++++++++++++++++++++++++++---
>  2 files changed, 68 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 22c8cc63f30e..b147223efc97 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -396,6 +396,10 @@ struct landlock_net_port_attr {
>   *   - or grant %LANDLOCK_ACCESS_NET_BIND_UDP on a specific port, and
>   *     call :manpage:`bind(2)` on that port before trying to
>   *     :manpage:`connect(2)` or send datagrams.
> + *
> + * .. note:: Sending datagrams to an ``AF_UNSPEC`` destination address
> + *   family is not supported for IPv6 UDP sockets: you will need to use a
> + *   ``NULL`` address instead.
>   */
>  /* clang-format off */
>  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index 045881f81295..8a53aebdb8c6 100644
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
>  	__be16 port;
>  	struct layer_access_masks layer_masks = {};
> @@ -69,7 +70,8 @@ static int current_check_access_socket(struct socket *const sock,
>  	switch (address->sa_family) {
>  	case AF_UNSPEC:
>  		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> -		    access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
> +		    (access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP &&
> +		     connecting)) {
>  			/*
>  			 * Connecting to an address with AF_UNSPEC dissolves
>  			 * the remote association while retaining the socket
> @@ -82,6 +84,35 @@ static int current_check_access_socket(struct socket *const sock,
>  			 * inconsistencies and return -EINVAL if needed.
>  			 */
>  			return 0;
> +		} else if (access_request ==
> +			   LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
> +			if (sock->sk->__sk_common.skc_family == AF_INET6) {
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

I sent this patch and I just merged it in my tree:
https://lore.kernel.org/all/20260406143717.1815792-11-mic@digikod.net/

Günther, could you please take a look at this patch too?

For consistency, we need to add `audit_net.sk = sock->sk;` here.

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
> @@ -124,7 +155,10 @@ static int current_check_access_socket(struct socket *const sock,
>  		} else {
>  			WARN_ON_ONCE(1);
>  		}
> -		/* Only for bind(AF_UNSPEC+INADDR_ANY) on IPv4 socket. */
> +		/*
> +		 * For bind(AF_UNSPEC+INADDR_ANY) on IPv4 socket and
> +		 * for sending to AF_UNSPEC addresses on IPv4 socket.
> +		 */
>  		fallthrough;
>  	case AF_INET: {
>  		const struct sockaddr_in *addr4;
> @@ -257,7 +291,7 @@ static int current_check_autobind_udp_socket(struct socket *const sock)
>  
>  	return current_check_access_socket(sock, (struct sockaddr *)&port0,
>  					   sizeof(port0),
> -					   LANDLOCK_ACCESS_NET_BIND_UDP);
> +					   LANDLOCK_ACCESS_NET_BIND_UDP, false);
>  }
>  
>  static int hook_socket_bind(struct socket *const sock,
> @@ -273,7 +307,7 @@ static int hook_socket_bind(struct socket *const sock,
>  		return 0;
>  
>  	return current_check_access_socket(sock, address, addrlen,
> -					   access_request);
> +					   access_request, false);
>  }
>  
>  static int hook_socket_connect(struct socket *const sock,
> @@ -291,7 +325,7 @@ static int hook_socket_connect(struct socket *const sock,
>  		return 0;
>  
>  	ret = current_check_access_socket(sock, address, addrlen,
> -					  access_request);
> +					  access_request, true);
>  
>  	if (ret == 0 && sk_is_udp(sock->sk))
>  		ret = current_check_autobind_udp_socket(sock);
> @@ -299,9 +333,33 @@ static int hook_socket_connect(struct socket *const sock,
>  	return ret;
>  }
>  
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
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(socket_bind, hook_socket_bind),
>  	LSM_HOOK_INIT(socket_connect, hook_socket_connect),
> +	LSM_HOOK_INIT(socket_sendmsg, hook_socket_sendmsg),
>  };
>  
>  __init void landlock_add_net_hooks(void)
> -- 
> 2.39.5
> 

