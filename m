Return-Path: <netdev+bounces-285400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJWWEIq0/GmOSwAAu9opvQ
	(envelope-from <netdev+bounces-285400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:49:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A21F44EB5CD
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A960930D92A0
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF5C44A725;
	Thu,  7 May 2026 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mXlN08fK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Q/atyUA"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607344B660
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168632; cv=none; b=Iae6YXMin/ldFwJ6USazH0mXZ7AGsa6QavawGaFrxIA9W2bkvTCHjga1/vnroYMkij5wdBe/NiCLrXEkUBwQdhzvKu9uIzMpB7f+yGHVknzNbo4MItSoKmoqUNlRLA6qz/GuKnLbd5y8DK2+TemqfNudaSPRlqFY8oBO6UpUvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168632; c=relaxed/simple;
	bh=P7Sn+Fs+ZZC/HbmNZYh4z691QWsLzskGeA1htl76TDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPCnbptkz52WHPmrrUAGcrn1EuBDYZupm+zOurQLdKiQuwgBaMbEGoEmNRURDrSbRfrFNnM9keeBkycsUG4cu1YiPIkNW9CWM+eCMWhBC1DiuVVmLdekdFy5R9OVTEI4ivd796hpNNW14GafgAkON9fwqukTkK+MjFFtQQ8ymew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mXlN08fK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Q/atyUA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 7 May 2026 17:43:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778168629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYDv2Kjb6ZzSh7a0vF2vmIuJFZvf3kVZ5O9qkmo+ZZ8=;
	b=mXlN08fKhc9xYgLlLi1xsuLpZFC/XlV3yuVOAGdQK9vdapea3ZDQVlPdIfF8W22i20QkhG
	X+1fzFYESLvVqgytm4OK3r8VrxX9rpKxA8Fcp8VfJV+eAqBLNnLejWY6lF9TUqAlOum6OG
	wnyW9YyP2UeOI0wXnAysZ7U8hyuiyG21rVW4tWQIIwLMMOIOSEc07C/n2MHk/CqRcVX6Jl
	2pWDk3z45EfR43N8FerMk7SLa1zYY9kAjMP9RazK1XUd1O7dw1ecYGrhYa41K6JAhSRBL5
	WTfC0EbNmQ3LtAucN6zs2FqJdDJvDz0WRKuE7amJSKJ5yEXTcttzWFgJd3vIfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778168629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYDv2Kjb6ZzSh7a0vF2vmIuJFZvf3kVZ5O9qkmo+ZZ8=;
	b=4Q/atyUANbQvqd4vLpxvnCx6wIEfAT0sUQ+Wl1J1iIikU/ey06JTp7Xv4Jw4g//JvWQ88z
	AKwqEM4G9gleYhCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH RFC net-next v3] hsr: Allow to send a specific port and
 with HSR header
Message-ID: <20260507154347.gC3JsJnO@linutronix.de>
References: <20260429-hsr_ptp-v3-1-afbf8f200f48@linutronix.de>
 <willemdebruijn.kernel.31592d82701e5@gmail.com>
 <20260504085911.nLZLRjPF@linutronix.de>
 <willemdebruijn.kernel.22897601ad5fe@gmail.com>
 <20260505095216.T02Z4R1T@linutronix.de>
 <willemdebruijn.kernel.8d257bcbe351@gmail.com>
 <20260506070928.hr8uavhJ@linutronix.de>
 <willemdebruijn.kernel.b7832f991167@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.b7832f991167@gmail.com>
X-Rspamd-Queue-Id: A21F44EB5CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285400-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,ti.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 2026-05-06 09:20:41 [-0400], Willem de Bruijn wrote:
> > No, I parse the header. As far as I can tell this set based on the
> > header bits from data passed to af_packet. Even if I could change this
> > to something else, these 16bit should better not collide with anything
> > else so I think used the eth-type and expecting nobody sending a PTP
> > packet is good.
> 
> Is that more fragile than a specific protocol? And introduces that
> dependency on mirroring the Ethernet format. But your call.
> 
> Ethernet does have requirements on MAC address format, so a layout
> that corresponds to an invalid address could be a signal.

perfect. Thank you.

Sebastian

