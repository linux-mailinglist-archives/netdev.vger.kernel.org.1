Return-Path: <netdev+bounces-294288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vS1qHMIEH2qAdQAAu9opvQ
	(envelope-from <netdev+bounces-294288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:28:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B67DA630326
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:28:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aM2XaVl8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294288-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294288-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C158B30087A2
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 16:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91526342C80;
	Tue,  2 Jun 2026 16:21:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974DB305673
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 16:21:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417277; cv=none; b=q/d9GUKEUEsqWtaO5/+xZRW/CxPBJwDDjKrtucyXM4PzOwP/jsf78LSLNbh4qkAEr22vCugFgoxhq7hjYcJdjIs6ONJhiO7A6je2O4ct6Cnsn1vWOPQ115pBK5fYCFsOR+cFYasQA86CbuDVNhotYnTRLcphVGM27006JG/+uE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417277; c=relaxed/simple;
	bh=3XmOuVzjG4i0X7Sc+gigjpnTOKIXUJhzLpLQ8tGlh+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJ02E8ZcUO9//8KeIJ+GX9nFHyhFU6dYsHgKxUuS3HApX6nns9bT4n7jqDEjFvxSxXI6I/th6HhAn3hn+HYKTXfMLSmku4MYhnE5+IVTdEtZqyGIV57hCKBiGAkM1xfCvH/h0h5N4F5c9IeeQ2tqwC20OP5Anbc/kHm3WCIPUXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM2XaVl8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59371F00893;
	Tue,  2 Jun 2026 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417276;
	bh=4cJtSeQcH/I3n7LDlQ/jliefRrCv7gGBu4Oj0DjdTiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aM2XaVl8a9hTQEOQqFj2JllZdScOXbWQ1xfUpeLmo3YQnAf8mEoVIVcjPfscGKYqx
	 rnwqmJmUNKd163aN/2QIIE/1nDu24Z++WSfOGbSEKEc4q+IwHIQXNvM2b0R7NN21F7
	 zHlbhYCJG28xZFTN0Lc++W8xxa6mxxY47Kq5cfkcetR40oAUZjS91knBw2/u8zUPGP
	 So3NntW1mzpzlq9qTOHbSwWyhPKdgfbob/AjTJ1r+qsvzT+SrkEZpLPQmSZ+1L6mGT
	 /8ZnFHVzQUt+dnrMwXMZhEWKLVg6qhRkmI1JEh15AYd9Dl1s9OXFltgKDX4OxY5wt/
	 gT/r6hm5804fw==
Date: Tue, 2 Jun 2026 09:21:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 stephen@networkplumber.org, kuni1840@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v4 net-next 5/5] geneve: Introduce IFLA_GENEVE_LOCAL and
 IFLA_GENEVE_LOCAL6.
Message-ID: <20260602092115.67f813e6@kernel.org>
In-Reply-To: <CAAVpQUD23owCGnbX0nxGgOGfjwr7At1sYncimrs6Sab6=rZ8yg@mail.gmail.com>
References: <20260528005658.1756248-6-kuniyu@google.com>
	<20260602023402.1647750-1-kuba@kernel.org>
	<CAAVpQUD23owCGnbX0nxGgOGfjwr7At1sYncimrs6Sab6=rZ8yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294288-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,networkplumber.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:stephen@networkplumber.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B67DA630326

On Mon, 1 Jun 2026 20:25:24 -0700 Kuniyuki Iwashima wrote:
> > Does this emit IFLA_GENEVE_LOCAL or IFLA_GENEVE_LOCAL6 on every
> > non-collect_md device, including legacy devices created without any
> > local address?
> >
> > cfg->dualstack is only set true for collect_md devices, so for any
> > device where the user never specified a local address, info->key.u.ipv4.src
> > is 0 (or info->key.u.ipv6.src is ::) but the attribute is still emitted.
> > This would change the visible output of ip -d link show and netlink
> > dumps for existing GENEVE devices, adding a synthetic local 0.0.0.0 or
> > local :: that was not present before.
> >
> > Would gating this on a non-zero source address (or tracking whether the
> > user explicitly set LOCAL) avoid the dump-output change for unaffected
> > devices?  
> 
> Honestly I don't have strong preference on this.
> 
> New iproute2 will show 0.0.0.0 or :: even for devices created without
> the attribute indeed, but I guess it's almost always the case that
> the dump command shows every attribute when we add a new one...?

IDK if there's any strong reason one way or the other, but my
understanding was that we try to only dump back the optional
attributes which were actually set by the user.

Whether we follow that here or not is less important, but I think
the bot makes a legitimate point. If we default to dumping zeros
even if user never set the addr - we should allow user echoing back
already set values in changelink.

IOW the ask is not to rebind but to compare the addr to current one 
in changelink.

