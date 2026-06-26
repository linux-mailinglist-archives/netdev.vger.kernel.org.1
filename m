Return-Path: <netdev+bounces-302272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZgwjJR3tPmo3NAkAu9opvQ
	(envelope-from <netdev+bounces-302272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 23:20:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAE26D0389
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 23:20:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=digikod.net header.s=20191114 header.b=FU5QH7ox;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302272-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302272-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7122F3045EC1
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 21:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F30C3A2E33;
	Fri, 26 Jun 2026 21:20:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5AA3BB10E
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 21:20:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782508814; cv=none; b=bauL7B5D2Yn4fiCQU8T0L1XpmbpWO07A+hiGn6VtsOJf7/vJtcrU/1glfKH0liTSrrH7A6oC8pT4qnvYFp6Hkn0XIgMj97yie8d7tSnx5mZi2sQYQSLBp73sdY3Y+woPhtKCmSWrF7lO9Cdc5K+aCFU47LQoOwvmDHy2vxxt8ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782508814; c=relaxed/simple;
	bh=30k/EqGAorSVjoOSk9ip3EDqNZjX6yjL8m37IxBctxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkqrC1SY5yGJSgMzi2llPG8AFzBAychrOuONXA4fQhQsBJrSZQZ+np64svemJyCPjQqAVh6f2n8ZRfXAHVFAu3efP/tCY5T+pbt2gKF9XCnhGUwQ2m0sRnznXCusQ4zOYZNsFfwuEo0ZZ+Eq2ldwkw8eDTgD19pxtYMa7Foh8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FU5QH7ox; arc=none smtp.client-ip=185.125.25.14
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gn7qT0X5kzrKB;
	Fri, 26 Jun 2026 23:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1782508804;
	bh=c0NaLpnIYrB3GZw7BCcXSauBvaVEunE3KzxssDSer20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FU5QH7oxPHL+JAAcaCHPYySWN7Rlxx2weRfaPRLH/u6TS1+DEBA4ivpaL0At0526Y
	 57Sn3kl+GValSBMYNWiuxvcmmVeTTihyPNNb7d6rFJRESfTcxJZwb1ZxIBnURFETwH
	 TjEu7O7pHL4dfH7V2T5OYS8sE///Eo2F93jI4DSE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gn7qS2MKnz5G1;
	Fri, 26 Jun 2026 23:20:04 +0200 (CEST)
Date: Fri, 26 Jun 2026 23:19:58 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: Bryam Vargas <hexlabsecurity@proton.me>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] selftests/landlock: Add test for TCP fast open
Message-ID: <20260626.Ahk8pe9boong@digikod.net>
References: <20260617.eemahv8ui7Ee@digikod.net>
 <20260617180526.15627-1-matthieu@buffet.re>
 <20260617180526.15627-3-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617180526.15627-3-matthieu@buffet.re>
X-Infomaniak-Routing: alpha
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.03 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.62)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302272-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	FORGED_RECIPIENTS(0.00)[m:matthieu@buffet.re,m:hexlabsecurity@proton.me,m:gnoack@google.com,m:linux-security-module@vger.kernel.org,m:ivanov.mikhail1@huawei-partners.com,m:paul@paul-moore.com,m:edumazet@google.com,m:ncardwell@google.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[digikod.net];
	FORGED_SENDER(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[buffet.re:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAAE26D0389

On Wed, Jun 17, 2026 at 08:05:24PM +0200, Matthieu Buffet wrote:
> Enforce that TCP Fast Open is controlled by
> LANDLOCK_ACCESS_NET_CONNECT_TCP. Semantics of connect() and
> sendmsg(MSG_FASTOPEN) should be identical from Landlock's perspective.
> Also enforce error code consistency, since UDP sockets ignore
> the MSG_FASTOPEN flag while Unix sockets reject it.
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  tools/testing/selftests/landlock/net_test.c | 155 ++++++++++++++++++++
>  1 file changed, 155 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index 0c256e7c8675..177ed28e70f6 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -258,6 +258,64 @@ static int connect_variant(const int sock_fd,
>  	return connect_variant_addrlen(sock_fd, srv, get_addrlen(srv, false));
>  }
>  
> +static int sendto_variant_addrlen(const int sock_fd,
> +				  const struct service_fixture *const srv,
> +				  const socklen_t addrlen, void *buf,
> +				  size_t len, size_t flags)
> +{
> +	const struct sockaddr *dst = NULL;
> +	ssize_t ret;
> +
> +	/*
> +        * We never want our processes to be killed by SIGPIPE: we check return
> +        * codes and errno, so that we have actual error messages.
> +        */

There are some extra spaces above.

> +	flags |= MSG_NOSIGNAL;
> +
> +	if (srv != NULL) {

Just `if (srv) {`

> +		switch (srv->protocol.domain) {
> +		case AF_UNSPEC:
> +		case AF_INET:
> +			dst = (const struct sockaddr *)&srv->ipv4_addr;
> +			break;
> +
> +		case AF_INET6:
> +			dst = (const struct sockaddr *)&srv->ipv6_addr;
> +			break;
> +
> +		case AF_UNIX:
> +			dst = (const struct sockaddr *)&srv->unix_addr;
> +			break;
> +
> +		default:
> +			errno = EAFNOSUPPORT;
> +			return -errno;
> +		}
> +	}
> +
> +	ret = sendto(sock_fd, buf, len, flags, dst, addrlen);
> +	if (ret < 0)
> +		return -errno;
> +
> +	/* errno is not set in cases of partial writes. */
> +	if (ret != len)
> +		return -EINTR;
> +
> +	return 0;
> +}
> +
> +static int sendto_variant(const int sock_fd,
> +			  const struct service_fixture *const srv, void *buf,
> +			  size_t len, size_t flags)
> +{
> +	socklen_t addrlen = 0;
> +
> +	if (srv != NULL)

ditto

> +		addrlen = get_addrlen(srv, false);
> +
> +	return sendto_variant_addrlen(sock_fd, srv, addrlen, buf, len, flags);
> +}
> +
>  FIXTURE(protocol)
>  {
>  	struct service_fixture srv0, srv1, srv2, unspec_any0, unspec_srv0;
> @@ -950,6 +1008,103 @@ TEST_F(protocol, connect_unspec)
>  	EXPECT_EQ(0, close(bind_fd));
>  }
>  
> +TEST_F(protocol, tcp_fastopen)
> +{
> +	const bool restricted = variant->sandbox == TCP_SANDBOX &&
> +				variant->prot.type == SOCK_STREAM &&
> +				(variant->prot.protocol == IPPROTO_TCP ||
> +				 variant->prot.protocol == IPPROTO_IP) &&
> +				(variant->prot.domain == AF_INET ||
> +				 variant->prot.domain == AF_INET6);
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +	};
> +	int bind_fd, client_fd, status;
> +	char buf;
> +	pid_t child;
> +
> +	bind_fd = socket_variant(&self->srv0);
> +	ASSERT_LE(0, bind_fd);
> +	EXPECT_EQ(0, bind_variant(bind_fd, &self->srv0));
> +	if (self->srv0.protocol.type == SOCK_STREAM)
> +		EXPECT_EQ(0, listen(bind_fd, backlog));
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		int connect_fd, ret;
> +
> +		/* Closes listening socket for the child. */
> +		EXPECT_EQ(0, close(bind_fd));
> +
> +		connect_fd = socket_variant(&self->srv0);
> +		ASSERT_LE(0, connect_fd);
> +
> +		if (variant->sandbox == TCP_SANDBOX) {
> +			const int ruleset_fd = landlock_create_ruleset(
> +				&ruleset_attr, sizeof(ruleset_attr), 0);
> +			ASSERT_LE(0, ruleset_fd);
> +
> +			enforce_ruleset(_metadata, ruleset_fd);
> +			EXPECT_EQ(0, close(ruleset_fd));
> +		}
> +
> +		/* Fast Open with no address. */
> +		ret = sendto_variant(connect_fd, NULL, NULL, 0, MSG_FASTOPEN);


> +		if (self->srv0.protocol.domain == AF_UNIX) {
> +			ASSERT_EQ(-ENOTCONN, ret);
> +		} else if (self->srv0.protocol.type == SOCK_DGRAM) {
> +			ASSERT_EQ(-EDESTADDRREQ, ret);
> +		} else {
> +			ASSERT_EQ(-EINVAL, ret);
> +		}
> +
> +		/* Fast Open to a denied address. */
> +		ret = sendto_variant(connect_fd, &self->srv0, "A", 1,
> +				     MSG_FASTOPEN);
> +		if (restricted) {
> +			ASSERT_EQ(-EACCES, ret);
> +		} else if (self->srv0.protocol.domain == AF_UNIX &&
> +			   self->srv0.protocol.type == SOCK_STREAM) {
> +			ASSERT_EQ(-EOPNOTSUPP, ret);
> +		} else {
> +			ASSERT_EQ(0, ret);
> +		}

All these ret checks should be done with EXPECT_EQ because they don't
block the test itself and we can get more info by checking more after
that.

> +
> +		EXPECT_EQ(0, close(connect_fd));
> +		_exit(_metadata->exit_code);
> +		return;
> +	}
> +
> +	client_fd = bind_fd;
> +	if (!restricted && self->srv0.protocol.type == SOCK_STREAM &&
> +	    self->srv0.protocol.domain != AF_UNIX) {
> +		client_fd = accept(bind_fd, NULL, 0);
> +		ASSERT_LE(0, client_fd);
> +	}
> +
> +	if (restricted) {
> +		EXPECT_EQ(-1, read(client_fd, &buf, 1));
> +		EXPECT_EQ(ENOTCONN, errno);
> +	} else if (self->srv0.protocol.domain == AF_UNIX &&
> +		   self->srv0.protocol.type == SOCK_STREAM) {
> +		EXPECT_EQ(-1, read(client_fd, &buf, 1));
> +		EXPECT_EQ(EINVAL, errno);
> +	} else {
> +		EXPECT_EQ(1, read(client_fd, &buf, 1));
> +		EXPECT_EQ('A', buf);
> +	}
> +
> +	EXPECT_EQ(child, waitpid(child, &status, 0));
> +	EXPECT_EQ(1, WIFEXITED(status));
> +	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
> +
> +	if (client_fd != bind_fd)
> +		EXPECT_LE(0, close(client_fd));
> +
> +	EXPECT_EQ(0, close(bind_fd));
> +}
> +
>  FIXTURE(ipv4)
>  {
>  	struct service_fixture srv0, srv1;
> -- 
> 2.47.3
> 
> 

