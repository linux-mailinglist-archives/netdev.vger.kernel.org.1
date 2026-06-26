Return-Path: <netdev+bounces-302234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XNAhFHSrPmoMKAkAu9opvQ
	(envelope-from <netdev+bounces-302234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:40:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 939206CF2EC
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:40:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GY9TLwMy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302234-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302234-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFDB0313CF52
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C13FC5CF;
	Fri, 26 Jun 2026 16:32:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B83FC5A7;
	Fri, 26 Jun 2026 16:32:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491577; cv=none; b=a708+akEdUCDxpIzQocam8ylWUwJR6lkAsSTbrbOgU6utI+e/CXfMX6iGAI3B6S7APhitEvuKoDGWFXYbe2sYxCrtPBgT8RlL73wRHW09M+stZ0mTGC6KxzR/9RynoK5BSLHNUZFz41BDIz5imV6/KDbwuyECSMUwJX/xsi97yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491577; c=relaxed/simple;
	bh=tG6J2GY+4jXTir/Fox0Z0bwsDCMHan1veiHDMjutll8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9PKW7HpokfOkcfIFdg3kIjxL3QWiGutwSADRgIvXVH8fbhHnmG3QIGllg+ABlt199bFq8DgnRmmq8ZIp5YHJSwxhqpP7BVgaXBkNhG/KHMZS6DEFNH5dtcqPraJkCUmyMBI6QmrJNBVxmUsa8b/rDEJgxi3nVkOjyrcbV0II9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY9TLwMy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB5C1F000E9;
	Fri, 26 Jun 2026 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782491576;
	bh=7s3t+HgFUoid2HXcYb60+6re4RXT2/C56sdjNS8djm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GY9TLwMyro/2WA0H9oXIsm3mscusHmvezbIXGXWhgkLKQK4EcdlHgc91WmtZCiOPl
	 V9k7kQ6iZs9+c5iTtRC66YvCdBF89ifHBy58rnny+YvTVGCg2XQhLM3eqWHGeh0y74
	 3Ut4ZKdDhlhL7P8MikZ4Vt1ObGon2RqVStPd8zMPfDEb5v+6RmbEgIpPxsHxYceVRw
	 madmhuNkZC+OC11CpCntxKCU9XhBLyItA5D9lWLzDC2KRMIVInT1sUBFZKMLhIIIRo
	 25j/qUzX5JxxzoMGapW6YL4MT3KT2FNy1UeY6Mk4hfFf6VquLT1AGYAMT8cEpMeMrQ
	 /kywlUh8OKy2w==
Date: Fri, 26 Jun 2026 09:32:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima	 <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca	 <sd@queasysnail.net>, Hannes Reinecke <hare@suse.de>,
 Geliang Tang	 <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Gang Yan	 <yangang@kylinos.cn>, Zqiang
 <qiang.zhang@linux.dev>
Subject: Re: [RFC net-next 00/17] MPTCP KTLS support
Message-ID: <20260626093254.19ee6485@kernel.org>
In-Reply-To: <a0358bb3aa8e2d45bd1e74851416728c3f08ddff.camel@kernel.org>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
	<20260622090059.5d1813dd@kernel.org>
	<a0358bb3aa8e2d45bd1e74851416728c3f08ddff.camel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302234-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:geliang@kernel.org,m:matttbe@kernel.org,m:martineau@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:hare@suse.de,m:tanggeliang@kylinos.cn,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:yangang@kylinos.cn,m:qiang.zhang@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,queasysnail.net,suse.de,kylinos.cn,vger.kernel.org,lists.linux.dev,linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 939206CF2EC

On Fri, 26 Jun 2026 15:56:53 +0800 Geliang Tang wrote:
> On Mon, 2026-06-22 at 09:00 -0700, Jakub Kicinski wrote:
> > On Mon, 22 Jun 2026 18:43:20 +0800 Geliang Tang wrote:  
> > > Subject: [RFC net-next 00/17] MPTCP KTLS support  
> > 
> > Please no. We have a ton of unfixed bugs and may have to revert some
> > of
> > the features we dropped back in. I'd prefer to avoid large new bug
> > surfaces until we reach an LTS release.  
> 
> Sure, I can wait. During this time, I'll go over the implementation
> more carefully to make sure there are no issues on the MPTCP side.

The two things that I'd be most interested in understanding better are
1) perf impact on all the pointer chasing and indirect calls you're
   adding
2) what's your plan on implementing HW offload? I understand that _you_
   may not care, but if you follow the ML you'll discover that sooner
   or later some well meaning person will slop code such support.
   We have pretty solid (by kernel standards) documentation for the
   offload. Please read if you haven't already. And then you should
   hopefully realize the huge issue with the layering you chose...

