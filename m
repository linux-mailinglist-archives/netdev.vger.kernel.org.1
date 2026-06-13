Return-Path: <netdev+bounces-299054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5eJYDxPLLWpukAQAu9opvQ
	(envelope-from <netdev+bounces-299054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:26:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE31E67FC8D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:26:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RhqPuHJ3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299054-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299054-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C46B3001012
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 21:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A757313C9C4;
	Sat, 13 Jun 2026 21:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EA638E8D0;
	Sat, 13 Jun 2026 21:26:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781385990; cv=none; b=OtLRRgbQ/mvb33RIRrmE0A5fsTEs0EEvQbIoZDPGsgnS5UHT7UFpEjhbVXX2QknnTkMctcV4UNpZgZnh3YhcfiG6HtBWXBRB0P7nRYUZxXAeTggjV4kTHLxWjun4US1dYIfCVgWWNfXYOEd2vUwxZBLzK97bM9HppRtAelDrK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781385990; c=relaxed/simple;
	bh=xE71mt+9mA1v5zyPK5rwPFDK2nz5D0/m6ScnpJfLkFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3RtAg0JOWKA6fa+3JzhQ2DV8pLfEVrn926ById8vOm6H3ZVRB+x3nC2Ifiy89AsjZcIlYDVv8RZyrMlavwexTdtIX5hBvRVxN/9MAyuIokG+qbHVJYM4ZnZTLdvnnxR8j5lt7ZUqOA1DL9so0RsUjFuyrOh3mrk0kJ68Z+zZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhqPuHJ3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486A41F000E9;
	Sat, 13 Jun 2026 21:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781385987;
	bh=VcLk9wZzSPmkNBpP+BPuASR8sU38aCEb8uNYSltIbvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RhqPuHJ3YL67qmWatB9TMIK72fMbaxrxIa7BbcT1BD+tbtbGQbbPQVY+HGCGmhW2h
	 AVe8pRPz3Z/+bpTlrv1rXL5faIAib9KOgE/vyuCXrsSoMw8R6xu760c9e7nDPLimEu
	 dl+BRwne2naAyjKAocL+s/eFNPP5hmoajJUQd77v6SlkAmohg5IwMZrWP39CiCO/X3
	 Zt+IMQsiPF3M74pxaXlWYohgzUBARxFg6xIMZfgKxFbXOzhEWDlHib5hjxHJYjmML5
	 CWgF99bZoKeneS/5UjzeZzdvZOoG0jYgUb5ngGIE9qkkL5lMosZlWZRb0fyKo7l6OD
	 SY3wRO90LrMAw==
Date: Sat, 13 Jun 2026 14:26:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 cake@lists.bufferbloat.net (moderated list:CAKE QDISC),
 netdev@vger.kernel.org (open list:TC subsystem),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net v2] net/sched: cake: reject overhead values that
 underflow length
Message-ID: <20260613142626.1b2183eb@kernel.org>
In-Reply-To: <20260609232935.1602659.8545fdb04fbe.cake-overhead-underflow@trailofbits.com>
References: <20260609232935.1602659.8545fdb04fbe.cake-overhead-underflow@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299054-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:toke@toke.dk,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:cake@lists.bufferbloat.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE31E67FC8D

On Tue,  9 Jun 2026 23:29:36 +0000 Samuel Moelius wrote:
> +static const struct netlink_range_validation_signed cake_overhead_range = {
> +	.min = -64,
> +	.max = 256,

Both Sashiko's complain - these values are neither safe nor sufficient.

How was the -64 chosen? It looks suspiciously close the min ethernet
frame length. But in that case (a) FCS doesn't count so 60, and 
(b) even IPv4 TCP packets can be shorter (at qdisc layer) than 64B
leading to underflow...

I see min rate in cake is 64 but I don't see any other meaning of the
64 literal.

Toke, WDYT? Should we use a smaller constant (ETH_HLEN?) or do the
check on the datapath?

Also - small constants fit directly in nla_policy, you don't need
struct netlink_range_validation_signed 
-- 
pw-bot: cr

