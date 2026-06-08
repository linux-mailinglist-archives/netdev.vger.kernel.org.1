Return-Path: <netdev+bounces-296728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NQDiAKcxJ2q3tAIAu9opvQ
	(envelope-from <netdev+bounces-296728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:18:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE1365AA31
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:18:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mkZJmE9A;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296728-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296728-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F083F304F409
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DCB3630B2;
	Mon,  8 Jun 2026 21:18:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140AB3FFD;
	Mon,  8 Jun 2026 21:18:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953505; cv=none; b=jBjRNiekDJI2Yxf8xHRStlCaR6mpWfC8F12QPmAky8tccRPFVr+cAtIrGTdWqw56HWb+9dtf9fjRb6AadlC79b0mBvfkQMz5sNboJ4sZZtoo3eoe9F2U9ytDK6a1kDpveVBvLUpZOQhi+TCvGDKCAGrLz7Eync4X40E6FPAtkDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953505; c=relaxed/simple;
	bh=CZjoD4QvDN7W36wtYhp7UlURyWnZwVeuTmGnAX24PCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/yQGvaGglVnjdPDg3jM4vZsysdEoq2jgUjYqaCNHtiaYIoHozQbbtWtBvGz4cChzWbZriXJkilYEQBwoB78pa7ZZE2teft4MQbiUUKwDLsfMYcql+qzQh3u2KjzDU0GvqW/Di+/T4PUutxlqq+KZk0l0Zl6GvP7+ruxssmWuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkZJmE9A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A891F00893;
	Mon,  8 Jun 2026 21:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780953504;
	bh=q9KITn8LY97lVyq/2NQ6V2vh7bnTXO5W7Y55FYYzJX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mkZJmE9Ai4YMmUro3blrF9H76to56BVEp05lyC04thonNjs6CkIDP4+bKahnUSmjQ
	 BMRYtsjsR3W7VbAdiqrzxl65F+Lt+H0sNbhAwnlELm/s0OGAlQyQxHF8x9OBr2xWYe
	 bPSii+QZGlmWeUu1v0hKgV8ASfRR0AOGEIuFbfrUwtp9eowm97FSLXNEVHuufNuIlE
	 eE2oazZTJqaxeHLy5xfYVBcY+KZ70MvalKgBNEXHN4kRZtJA/bYifLoZKI38lHh/dm
	 FP4PKwUAuRnkqcRPwIGhVidL0VZM2+cQAz9bpK4KJkqcEzy0mKENz2w/FtjNRPXQYz
	 MqqFgv61Z6EDA==
Date: Mon, 8 Jun 2026 14:18:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jay
 Vosburgh <jv@jvosburgh.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] drivers/net/bonding: User strscpy() to copy
 device name
Message-ID: <20260608141822.780fb5c5@kernel.org>
In-Reply-To: <20260608220710.7499931d@pumpkin>
References: <20260606202633.5018-13-david.laight.linux@gmail.com>
	<20260608132311.0fb69fed@kernel.org>
	<20260608220710.7499931d@pumpkin>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296728-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:jv@jvosburgh.net,m:pabeni@redhat.com,m:davidlaightlinux@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DE1365AA31

On Mon, 8 Jun 2026 22:07:10 +0100 David Laight wrote:
> On Mon, 8 Jun 2026 13:23:11 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Sat,  6 Jun 2026 21:26:07 +0100 david.laight.linux@gmail.com wrote:  
> > > From: David Laight <david.laight.linux@gmail.com>    
> > 
> > Could you be so very kind to read the automated message you received
> > when you posted this?  
> 
> Looks like I managed to send two patches for files in the same directory
> that contained equivalent fixes.
> 
> I think I should be able to merge the patch emails into one and send
> as a single V2 patch that contains both changes.

Not what I asked you.

You seem to be following the ML yet you excreted a bunch of incorrectly
formatted and likely useless patches. Read the email. Start with one
or two submissions at a time.

