Return-Path: <netdev+bounces-295003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Iq/eL8TUIGoo8QAAu9opvQ
	(envelope-from <netdev+bounces-295003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:28:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BDA63C320
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:28:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=OIoBgn4i;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295003-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295003-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 062AD3017067
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 01:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B38E263C8C;
	Thu,  4 Jun 2026 01:28:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E844919539F
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 01:28:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536513; cv=none; b=ZyX4HCE9jR8AedmE2SVOJiKxlAaAH0QYlsE4LlxE+TBqo9uNM5fbhnhpcCEW9DT9r+eD6A1h91zBnIX4GSJRHXYMhzsDVj7xkUL7AFoqeXikNUf7eM3wcqCC6GfwasrLE7s0GJzH/aZjt3j6/VtH9Uu9ZqP9Rp1pYcT2F45Ekeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536513; c=relaxed/simple;
	bh=jZcHl9ofsXjAPjliIiKHG7gjViAMTJb4hUNs1xuT2w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=du63CJpQFg3O+iAKsb0kN/l4NMaqwLMDbirVM6hlT7Tc8id7rRKy0sJBdcHAlwvfZ5fpgs4D8Dh22RJzKggxDeKxR8aKyWrNUIM1muobJiP/kEHc10kAh6lWuH/4bM5MqXxWzOZ5VjL6SdnUK/I622vu6dTr/i0hvNvUUonyomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=OIoBgn4i; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=V6Y+oz6COzZsGaT88ofmuWoB69bqSB9qg64abED/XMQ=; 
	b=OIoBgn4ir7IweuSu27rA4JMP9DLxA1Fz/193QGwnknE6QDwLyljj5m1YttE9q9YafZSMbrkvgJO
	nkdrVyAoB6kHLzb/s40ecY690BQ/jN76HXxeePuckftWafgy8IJX/5vbAwimLHnL9gGJDGSEG9vPm
	DMN9KXVSliIM5I8uE5TDS6YHPRBxtUodpHIZcrUT22t98WjqfJUt+bwIeR6BR+35lmosXYFwIFlHU
	vxH/lzBd1PsJg2oJX7TLaNFvZEbhx/arIb7qOjpcLoYG6yOEsuMm/r8FflCQtf048ZItFd0HezqAR
	2k+5BqQM/Yh2HSKIOTe8QxpJNEKzMqlpdNiw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wUwsS-002D2S-2L;
	Thu, 04 Jun 2026 09:28:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Jun 2026 09:28:08 +0800
Date: Thu, 4 Jun 2026 09:28:08 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, idosch@nvidia.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, steffen.klassert@secunet.com,
	andrew+netdev@lunn.ch, kuniyu@google.com, jlayton@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: protect egress device access in the output
 path with rcu_read_lock
Message-ID: <aiDUqIC7N1GXtICR@gondor.apana.org.au>
References: <ahveCu-zzFlpeVut@v4bel>
 <20260602154523.GA537996@shredder>
 <ad40bbe0-f79c-4fd9-9670-5dab01a8e57f@kernel.org>
 <aiAk2Q-yNs6It6g4@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiAk2Q-yNs6It6g4@v4bel>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295003-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:imv4bel@gmail.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:andrew+netdev@lunn.ch,m:kuniyu@google.com,m:jlayton@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69BDA63C320

On Wed, Jun 03, 2026 at 09:58:01PM +0900, Hyunwoo Kim wrote:
>
> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index cc35c2fcbbe0..c5ac360da38d 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -594,6 +594,7 @@ int xfrm_output_resume(struct sock *sk, struct sk_buff *skb, int err)
>  {
>  	struct net *net = xs_net(skb_dst(skb)->xfrm);
> 
> +	rcu_read_lock();

xfrm_output_resume is supposed to run with BH off so there is
no need to acquire the RCU lock.

Please also check the other code paths that you chagned to ensure
that they don't already run with BH off.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

