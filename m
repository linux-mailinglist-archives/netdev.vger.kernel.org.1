Return-Path: <netdev+bounces-301203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QnVWM3qvOWoiwQcAu9opvQ
	(envelope-from <netdev+bounces-301203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 23:56:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2C96B28B2
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 23:56:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hEw0SkTT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301203-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301203-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7414330134BB
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 21:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7340A3537F7;
	Mon, 22 Jun 2026 21:56:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6A92DC78C
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 21:56:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165367; cv=none; b=MO6sDWD0yQKV8pizxWiV6OXErkTcYSfbhE0O+IHZ4eN8ZgGf2rp3d1A91PRBTIrQGnHhylPmwPPYpeAGyB9Zchx1QytWrd48R1D+RK/zmGOYhqmBVtr4rVEe1u4fdG9gSHPzJn9UXemRQu7VS7sDYYpzHuUPQGN8V52p/ZF34S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165367; c=relaxed/simple;
	bh=MhRnsPauROmUigkS4Ietp3Gci8EbN47PIQDXqtTi5Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/YENSxMpuEegFcPvZ/ODUayPYXexDbWaSxxt1jNcdQzE7yFg/nUaU4CB4EQrLZuqJshCBw8C+efn0+LJcbaox/yciFRSYWjOh+REU79AgyReHF7zBlw0wpWo/Gim8ZLmab2LFlDDQqcNOk+TGw0TuMmflR1yaB9rxfX5ebswQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEw0SkTT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D651F000E9;
	Mon, 22 Jun 2026 21:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782165366;
	bh=fnp4Q8nhNaRHoYvnru7Wu60jtYd7ye9VqRc/LmL8nu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hEw0SkTTBwN8FVegJvFAMYUa+5e7BllR3KAO1P9Bku1InJux2qDu9Y3zt1t7Klmjy
	 +N8PlOZ6/iQtR1VHNME6Cr10z6ja71ezW7tb67Fm5zBCQ9/ZVPLzAZnh6zs0s6Ugu9
	 twpE2ij3OWMjd8F5UgZ+3tHPkndQ4l/hgSvRt2qULBiZUDqHBYwG8WUtOJTzLI5Me/
	 lMvEt5UI1fgDx/EtuZ4tZo6azTy4SIAxRzkh7T8DYrcVS9++EhBZXwliXDZefM2Et7
	 SZht5IxzJHegUFwogjPrk230E4A7Ox1Gsfrydbp4BLH9RJQJ9kUbfqhGI9t5yuCvAB
	 Rd3jcbcqfE5jQ==
Date: Mon, 22 Jun 2026 14:56:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev
 <netdev@vger.kernel.org>, Riana Tauro <riana.tauro@intel.com>
Subject: Re: building ynl afaics requires updating the UAPI headers first
Message-ID: <20260622145604.524949ec@kernel.org>
In-Reply-To: <f88cfe04-c817-4383-866b-530c5bc5bd95@leemhuis.info>
References: <ade91456-2f93-442c-b76c-28bd7157f074@leemhuis.info>
	<20260618170605.0e2e4dd4@kernel.org>
	<cec7685e-df12-4501-b851-9c8f7b8b06cb@leemhuis.info>
	<20260622090534.2af8ae9e@kernel.org>
	<f88cfe04-c817-4383-866b-530c5bc5bd95@leemhuis.info>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301203-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux@leemhuis.info,m:donald.hunter@gmail.com,m:netdev@vger.kernel.org,m:riana.tauro@intel.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C2C96B28B2

On Mon, 22 Jun 2026 18:33:29 +0200 Thorsten Leemhuis wrote:
> On 6/22/26 18:05, Jakub Kicinski wrote:
> > On Fri, 19 Jun 2026 09:28:47 +0200 Thorsten Leemhuis wrote:  
> >> On 6/19/26 02:06, Jakub Kicinski wrote:  
> >>> Can't repro for some reason, but we probably need something like 
> >>> commit 46e9b0224475abc to add the explicit include rule.    
> >>
> >> Thx for the pointer. So I guess you mean something like the below,
> >> which did the trick for me. Will submit this as properly, unless
> >> someone points out something stupid in it.  
>  [...]  
> 
> No, because the funny thing is: now I fail to reproduce it myself. And I
> don't know why, as 24h earlier when you had written "Can't repro for
> some reason" I had once more checked that I could trigger this by
> downgrading Fedora's kernel-headers package to a version from some weeks
> ago. Not sure what changed since then.
> 
> Want me to sent it nevertheless?

Yes, let's get it in place, it can't hurt AFAIU.

