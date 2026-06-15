Return-Path: <netdev+bounces-299534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 66yeHAkmMGqmOwUAu9opvQ
	(envelope-from <netdev+bounces-299534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:19:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1F668842D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:19:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="C1/hHUJO";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299534-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299534-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA666303AF9C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80D4409602;
	Mon, 15 Jun 2026 16:19:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03B5409124;
	Mon, 15 Jun 2026 16:19:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540351; cv=none; b=OXc4ddW3Jr2xTjj4ByigJig30Jv94rww4LnRQw7uqeOk2AhXbj4tKBBbnddf0BBMc7A7/6qJx+Q0VP+3yGuO0a8c9MipcICwdcEFOEAOkOtqaduPcjysO1Ky5oRUotA4//wT7s1pv9D55q5QkV3r0t0l9ex+lSqrcRod/o2Tcw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540351; c=relaxed/simple;
	bh=jntwFKaHDJlCsM+KlNmjUGhdfYUHTXLwvp5aO0ZLZR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zp0EQEYfe/DHS80D1Q+7zKqrjo9/zeTtzYr+/FZWGXWTQSokf+DtC7QnOJNgHBztH+eoEBPLuwG2zfQLcSI8WCJiVX9owb+T0SRxTEEL9cN2m1JHmh5WAlF0EfV6Jkjf5s1iwJTN5a7HGRfm+0nb+Hm9jH1D8uS4UE4MSPo7mQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1/hHUJO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A371F000E9;
	Mon, 15 Jun 2026 16:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540350;
	bh=0DsLxYAcK9o6T2BXzYuXKF8hIfKyhiYsUxUJ8qJ4wGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C1/hHUJOD7oUAg5viE5twi8PnfCwMkqavwUHjoG/OqFoFKP9z6ibzfhxp+97dy2z/
	 HIqFKfZtB9gQ9RCU9nwYqEK4cTkVvefqX8xYNJkrsvGeTK5yihlCuuYT/p19t2uziU
	 6fqvCnR5zisPbkJMOVy1f39YTBx+AvoDGlbQj9OBDsJz/10LNm1l7gJLo+6q+FTO3R
	 Gdl8oFmVG5cedUf81AHauETH7qJIAahzPN298KjR54wBkOYVjkDuvFDibYrE0jkd23
	 zCIB+H6hYS03FcUz8UCoIKCMEIammwXrMiDw8RA+KMSJ4vwDgIlV22qAA+kBs7uWzB
	 fRrzIEC3nFC6w==
Date: Mon, 15 Jun 2026 09:19:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 johannes@sipsolutions.net, corbet@lwn.net, skhan@linuxfoundation.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: exclude driver and netdevsim bugs
Message-ID: <20260615091909.78ad2b03@kernel.org>
In-Reply-To: <20260615091436.GP327369@unreal>
References: <20260603162943.2406080-1-kuba@kernel.org>
	<20260615091436.GP327369@unreal>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299534-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:johannes@sipsolutions.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:workflows@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC1F668842D

On Mon, 15 Jun 2026 12:14:36 +0300 Leon Romanovsky wrote:
> > +Unless explicitly excluded all bug fixes should be targeting the ``net``
> > +tree and contain an appropriate Fixes tag.
> > +
> > +Obvious exclusions:
> > +
> > + - fixes for bugs which only exist in ``net-next`` should target ``net-next``
> > +   (please still include the Fixes tag in the commit message)
> > + - bugs which cannot be reached, e.g. in code paths not executed given
> > +   current in-tree callers
> > + - fixes for compiler warnings and typos  
> 
> If you decide to resubmit this patch, could you please remove "fixes for
> compiler warnings" from the exclusion list?
> 
> It is quite frustrating to receive a compiler warning originating from a
> different subsystem after the merge window, knowing it will not be
> addressed until the next merge window (around eight weeks later).

Agreed, FWIW, but not planning to resubmit.
I think people misunderstood that I'm __documenting what I already do__
rather than trying to have a discussion :/

