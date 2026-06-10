Return-Path: <netdev+bounces-297753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IukPNYmQKWqvZgMAu9opvQ
	(envelope-from <netdev+bounces-297753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:27:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0275C66B76A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:27:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WNZdJ5Au;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297753-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297753-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA3513010229
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B01B42EEB7;
	Wed, 10 Jun 2026 16:05:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D144429827
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:05:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107544; cv=none; b=uBygGJKwkJT9kfOpLbQTmc7shwY7bfUhF4YODz735sCZ42rdhpQuHgPDeAuKkYQSLx0FawXobzQxkbVH+Rjege1TKwkvpQSezsN9uG2IHWg5vwW+UjwIc8u9sF+1YlxkOL8siBsX9oi6KHRocx5uoaDaDIIHoMwj4lmHJdrR5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107544; c=relaxed/simple;
	bh=pIxIGKXnf2xj4wKGibCTZI0q+Lkx74Yv3VfCPMZ+WLc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocEJTBbz04bDmPcjTMOhRDJaaxf4dR/zbr//sEOw79Rgw5MiRAxKdw0QQGf5Mci/UvwqqFnRIBAruJXuE+sP8gsEQBqVgxsQFv7ev5B4dlsUK3nrIWQ440UrpIsPkAafq70V/qW5ow5yKF7tNHdAM7u8xIGlHG3C8J0cTTzGN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNZdJ5Au; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D121F00893;
	Wed, 10 Jun 2026 16:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781107541;
	bh=WNtCBJAMs8tQ0/Htd24Ae0GJo4XeiSzKV8VEIuJJlho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WNZdJ5AuzmX/Q94ibRRETw/Ljnr6PMRWv904bCKFKWpq5j+mH5VeEL1DLtrBFEf/9
	 IJkDIr2mznRGDrrfIdKJurGejRM0m8NrOlGhEm8/264vXUuOeLb0rxFOlsNon/bYSG
	 5rE8IB8+NRLC1JWm3zAg0g3rcJQ7ifZ2Fu/mieB1uUIQZXr6ebMV28PhK7Jv8i/t2v
	 kHs8cHLM5PgQlqfi56ajwqgX7xizgls8wV/Uj6D7/Ts36yur1oE9CobIc9oD89LWib
	 gD4JOoFvduk7HxCIBkF2cd8ClcIeOXBv/O/QkdJyduoABSl2Uu/+hzKpK8RMp9zwAN
	 Gsk6r5uydbzGg==
Date: Wed, 10 Jun 2026 09:05:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] ip6_tunnel: annotate data-races around
 t->err_count and t->err_time
Message-ID: <20260610090540.507cd300@kernel.org>
In-Reply-To: <20260609093154.2733956-1-edumazet@google.com>
References: <20260609093154.2733956-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297753-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0275C66B76A

On Tue,  9 Jun 2026 09:31:53 +0000 Eric Dumazet wrote:
> -	if (time_before(jiffies, t->err_time + IP6TUNNEL_ERR_TIMEO))
> -		t->err_count++;
> +	if (time_before(jiffies, READ_ONCE(t->err_time) + IP6TUNNEL_ERR_TIMEO))
> +		WRITE_ONCE(t->err_count, t->err_count + 1);

Sashiko complains about the bare t->err_count read. Is there a reason
you added the temp variable in xmit but not on the error side?

Maybe an extra sentence in the commit message on why the approximate
correctness is okay here would also be good?

>  	else
> -		t->err_count = 1;
> -	t->err_time = jiffies;
> +		WRITE_ONCE(t->err_count, 1);
> +	WRITE_ONCE(t->err_time, jiffies);

