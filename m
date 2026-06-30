Return-Path: <netdev+bounces-303409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jdgcLNFWRGqgtAoAu9opvQ
	(envelope-from <netdev+bounces-303409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:52:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A06E8BA7
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:52:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kyrlOBEq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303409-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303409-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC4AA303131E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 23:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D583733B6F4;
	Tue, 30 Jun 2026 23:52:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE21A6814;
	Tue, 30 Jun 2026 23:52:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863566; cv=none; b=QHkbjEPuW0PiqRSbPcMV/4dtHlpQoCw7YC0mdiUDOnHLwwWoK5gc3IMNraNWvZIXgApEhkI1LNW0F6xkHFJkkuczyKwjQ2iUr43GIKwHtghc0DQVcKwMUhOCml9tNoEQuAD9xazmoTprjjnwA06g0VOivmal+yDDaTo7wjddoa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863566; c=relaxed/simple;
	bh=rkP3Iu5ETNBIKzC54DcdCretEF4qZJ6zZVa0uPFK++k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/njptGvPB6iW9YPWJEhGtvaZtmLV5rXIw3JsWjSU+jPBW4OND/z7sSFUpeIfP+r1hcg+kLx1SrzXdadjBE2jpuL7r6WmxggTkF3HeuL3ivEZpzfRJzjLl6rH6DSIyhitzctXZGNPLo3f9NAKQ4ixt805GbhZbrUga8X6dG1bsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyrlOBEq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6F91F000E9;
	Tue, 30 Jun 2026 23:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863565;
	bh=w0yqxgU9HaMgyNbW9EmsTuYU2h7mMvbqClBCdd4eL/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kyrlOBEqACTrTFDv617Vk+oEQrM6oIMb3mbK1DOYwrRYMwywnHqKhG7e7dk0qAdng
	 U7mP0sfTZe4UdigM3uzpV3D6r7Ak1L7WtgxOdej6LEG/3sNFfmF7ux1r+5vOHgMbHQ
	 aUoeah0cQjktd8csrlkvgp8maX8KLkZQb724Of0OSJhNoaqspDa4pZCrnpTu1LpUyp
	 J8iXFNThSE+FC8c2L69Mxf5CaUKI2ZeOIdm+yEmHlMox8L8T7SIKgsng76JehHb3ul
	 77FyTUsQiRU6gwXgh4QNf8Li54bqvLiCZu+bJnqbB/GmARjffOLM2VPKC/QTw5tjZh
	 LoXOfD3DUujvQ==
Date: Tue, 30 Jun 2026 16:52:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, Jordan Rhee
 <jordanrhee@google.com>, Shuhao Tan <tanshuhao@google.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, Samiullah Khawaja
 <skhawaja@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v1 0/2] Reuse threaded NAPI kthread across
 napi_del()/napi_add().
Message-ID: <20260630165244.35545bd6@kernel.org>
In-Reply-To: <CAHS8izOc7OPrspPfo-6eAwPscQzk6ZzHQd10MFrRvzuPXU9WjA@mail.gmail.com>
References: <20260629192029.4013794-1-tanshuhao@google.com>
	<20260629162619.55297244@kernel.org>
	<CAABY+HEcNnh+ATyA_JMg4LnVpP=egprTTi4UXxV9CfW2+71z+g@mail.gmail.com>
	<20260629181955.00e63b61@kernel.org>
	<CAHS8izNeoJiLyoyiPgzmX5CGcyivYqBpVxOcFnoxeOX_zzFd4Q@mail.gmail.com>
	<20260630160555.3736f900@kernel.org>
	<CAHS8izOc7OPrspPfo-6eAwPscQzk6ZzHQd10MFrRvzuPXU9WjA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303409-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:almasrymina@google.com,m:hramamurthy@google.com,m:jordanrhee@google.com,m:tanshuhao@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:shuah@kernel.org,m:skhawaja@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F09A06E8BA7

On Tue, 30 Jun 2026 16:41:44 -0700 Mina Almasry wrote:
> > Can y'all not open a pidfs fd for the NAPI thread? You'll get a
> > notification when the existing kthread dies?  
> 
> Let me take a look, but I think we need a notification when the
> kthread is back up to reconfigure it. I guess if we're trying very
> hard not to touch the current code we can always monitor the running
> napi kthreads and their affinity and work around it like that.

To be clear -- I don't mind making changes. My first reaction was
to suggest adding Netlink notifications for when NAPIs are created /
removed. That's the standard Netlink way of letting the user space
do what's needed without adding kernel complexity. Then I remembered
pidfs can probably already do it.

The kernel threads for NAPI, and the state transitions are already
quite hairy. Plus keeping the threads for potentially dead NAPIs
around... IDK, just doesn't feel very clean.

