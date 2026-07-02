Return-Path: <netdev+bounces-304223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qZ9oGCN9RmrtXAsAu9opvQ
	(envelope-from <netdev+bounces-304223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 17:00:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C17B86F9252
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 17:00:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=digikod.net header.s=20191114 header.b=sQJF5vlo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304223-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304223-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4C583036E77
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FF8433E7A;
	Thu,  2 Jul 2026 14:59:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F57E433E70;
	Thu,  2 Jul 2026 14:59:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004379; cv=none; b=LGKlOE3aIR5g7q6N0lNFzl95gGs1foEPvMoP3A5/e/76WuuehehDGMYeXaB701ki0uGToH5MAwNsDdGdWjQh1NkWowMgWOkOgEMDKzMhFem3zBoegF+54/c4JBUv+1NUlkGkPm3zgsDDi2o/qAFx+KasbmZmSVn7bjeO3IWZsEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004379; c=relaxed/simple;
	bh=TvpB4ituHUE/4G151rVesx7/g7lIOt8ozx/LciKPu58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ+CGTnIxqvSY1ORJtbtJHwp05B1XC4VETbgQVWAwvIKm9Gsb82HaWtnOth4cAnS5jV96GrZ2UIPSsIqPZeZy2K9mBxSV+SwOOPlf7HDUBf5yR0S5HYXFoIxPK5HpM5X7GzsI+EyHuKSftHxjudw+Ro7cZfybdtxU+uODFmFKAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=sQJF5vlo; arc=none smtp.client-ip=84.16.66.169
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4grg5T6lQHzBlv;
	Thu,  2 Jul 2026 16:59:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1783004365;
	bh=ECl3lQKgr0XzjfmQWRB2AMBbtcwDvjdjFf1tBBQFAtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQJF5vloPdRpu5S6AD1mT6MdQj9YC4wiDk/PWN0anDxVTtUTwDjG2EVkJBEkzjpp1
	 jqphKhh8ZQaTAaCJHJkK+UtJ3k0NWBr9Nc1K6df6bWUA3DSvhQIxkSGrMSabcRIqRb
	 C8z03PgHVhqcpO5z/gPtiWnIOc9Bgyib+qGkj3zI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4grg5S606NzQTK;
	Thu,  2 Jul 2026 16:59:24 +0200 (CEST)
Date: Thu, 2 Jul 2026 16:59:20 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: Bryam Vargas <hexlabsecurity@proton.me>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] landlock: fix TCP Fast Open connection bypass
Message-ID: <20260702.EiNg0kiph4ew@digikod.net>
References: <c21cf4f3-6c21-4170-b578-13c1bfd48b87@buffet.re>
 <20260701214628.33319-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701214628.33319-1-matthieu@buffet.re>
X-Infomaniak-Routing: alpha
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.99 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304223-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,digikod.net:dkim,digikod.net:mid,digikod.net:from_mime,buffet.re:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C17B86F9252

Thanks, applied!

On Wed, Jul 01, 2026 at 11:46:27PM +0200, Matthieu Buffet wrote:
> The documentation of the socket_connect() LSM hook states that it
> controls connecting a socket to a remote address. It has not been the
> case since the addition of TCP Fast Open (RFC 7413) support, which allows
> opening a TCP connection (thus, setting a socket's destination address)
> via the MSG_FASTOPEN flag passed to sendto()/sendmsg()/sendmmsg(). The
> problem then got duplicated into MPTCP.
> 
> Landlock did not take it into account when its TCP support was added,
> leaving a bypass of TCP connect policy.
> 
> Ideally a call to the LSM hook would be added in the fastopen code path,
> in order to fix this generically. But connect() hooks are designed to run
> with the socket locked, unlike sendmsg() hooks.
> 
> Closes: https://github.com/landlock-lsm/linux/issues/41
> Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  security/landlock/net.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index cbff59ec3aba..46c17116fcf4 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -351,6 +351,14 @@ static int hook_socket_sendmsg(struct socket *const sock,
>  	access_mask_t access_request;
>  	int ret = 0;
>  
> +	if ((msg->msg_flags & MSG_FASTOPEN) && address && sk_is_tcp(sock->sk)) {
> +		ret = current_check_access_socket(
> +			sock, address, addrlen, LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +			true);
> +		if (ret != 0)
> +			return ret;
> +	}
> +
>  	if (sk_is_udp(sock->sk))
>  		access_request = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
>  	else
> -- 
> 2.47.3
> 
> 

