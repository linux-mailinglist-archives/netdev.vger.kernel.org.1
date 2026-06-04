Return-Path: <netdev+bounces-295268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y845NFmHIWqzIAEAu9opvQ
	(envelope-from <netdev+bounces-295268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:10:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB5A640B27
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:10:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=PRDVeNsg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295268-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295268-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 633FC3076A61
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8914747F2C6;
	Thu,  4 Jun 2026 14:00:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A97480354;
	Thu,  4 Jun 2026 14:00:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581610; cv=none; b=FJBVKVqGuVZLIss+x/Uog07gI1lqUt7jUKR3+ugLD7XTDW/hBa5nT3PRRNyZQ0K09rBcoOxgwAxAoCxC63SKnwMN/+nFMwe11R9Kp43wmBFyL/V7pl1u8l0zu8e0pC72SCEP2X3r4UO34ybjjY1w4wor4vB8HPf/dzndzmuYGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581610; c=relaxed/simple;
	bh=8MMB8bFJ8LNC1D+1B0HLn2eXpH4+sY71iCNWI8FmUiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+1NkKXWkHPDaWrTJ1TxbgDYsVSIDwZWiLemqLwnr0bJPmT6DneYOSIdJHJIPwZdX8ggHaw24ww4jI1IAqjtvGKoCQANjkqxFtQao3V7Qnh2paH/S8I+EePoDJbooUNSDkY4ISKa6IoZgfRd8v1fcu4+80+AUxJMQtQ/C72M6HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=PRDVeNsg; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nRBXMkQp51i7rSpx936ZuKTdmIEGW7cKA2P/HWYWFKw=; b=PRDVeNsggkUUq/F72LhcBMaGvL
	JSOS40/4rE0eWpZqQ5IVcWAK/BQ/43IQ9h44uKlqZQxC1LbeCa0CdjSE2/nwIx/FOTvwTZaN+pjgR
	PMIda75u6ERrSw/l52txx7HkXVMqJrw4pAI9+uWXybSfwZgPlU9KOH/8zdo+5uixESfJB1FQDqUB7
	ZktNd2UnIWlL1I6GQsJmMH9DU0U4EaEw/UdxpTkxvT+lfy0F8m66AuZE8pUxwJeAn/IlgRJ1iVJEw
	sXwwpLEkc4s83lmn3a4O6nAnadI9sdPWNJ2YX2CuVy7dhMHQTYg6zkz3utzd4KwK6j0GHTAZFFiBq
	81+GNDDw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wV8bs-004Z6A-10;
	Thu, 04 Jun 2026 13:59:49 +0000
Date: Thu, 4 Jun 2026 06:59:43 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/3] netconsole: Fix reported problems
Message-ID: <aiF-SG6mhZBt2jaF@gmail.com>
References: <20260602-netcons_fix_before_move-v2-0-eca3f8a8b1a3@debian.org>
 <20260604130622.GB3920875@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604130622.GB3920875@horms.kernel.org>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295268-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DB5A640B27

On Thu, Jun 04, 2026 at 02:06:22PM +0100, Simon Horman wrote:
> On Tue, Jun 02, 2026 at 07:26:56AM -0700, Breno Leitao wrote:
> > These are some of the issues that LLM reported to netconsole, and they
> > are being addressed here before big refactors.
> >
> > I was doing some big refactors, and got some "pre-existent-issues"
> > during LLM review of the refactor, that make them hard to guarantee that
> > refactor is not introducing any bug, so, let's clean these pre-existent
> > bugs first, and then submit the refactor.
> >
> > The issues fixed in this patchset were reported during the review of
> > https://lore.kernel.org/all/20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org/
> >
> > Not all of them got fixed, but, those that were easy to reason about.
> >
> > Why net-next and not 'net' tree.
> >
> > Most of the functions that are being fixed here moved from netpoll to
> > netconsole, thus, fixing this on net will cause merge conflicts from
> > 'net' to 'net-next', thus I decided to fix it on 'net-next', given we
> > are on 7.1-rc6 already. Sorry if that is not the right approach.
> >
> > Changed from v1:
> >   * Change it from 'net' to 'net-next'.
>
> Hi Breno,
>
> There is AI-generated review of this patch-set available on both
> https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
>
> I would appreciate it if you could look over that with a view
> to addressing any issues that directly effect this patch-set.

Ack. While most of the reported issues are pre-existing are being fixed,
there is one genuine regression: invoking WARN_ON_ONCE() in a potential
NMI context is problematic since it may trigger panic_on_warn.

I will send a revised version.

Thanks,
--breno

--
pw-bot: cr

