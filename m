Return-Path: <netdev+bounces-274397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FfsDgkVzmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:04:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD51384E2E
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE590305FA15
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 07:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0607B2E0413;
	Thu,  2 Apr 2026 07:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v+pKyJr5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ginns0Qj"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478D35958;
	Thu,  2 Apr 2026 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113402; cv=none; b=jAonNiW7L5hO1A8dlWg52LD2ALNPOFXreJiPVeBad0Hc8HwXwuZV/m6abaCCReJFaZ+wszesas1soosTzLsu5sha+rm040QfBHVRsa9H7qwiM53Fa7LeyhciwElbLJerROu7dVwxLlQ9BbdvV7jpM/onb4UnFUgGlK4ROLiXT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113402; c=relaxed/simple;
	bh=NPgKlAJa6fM9rj55i5LCX5n3X5ZK1g15EE2zn8d4w/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzCQEYso0KpiX9ElSmRd8mmFMr/T/hOjK91SvrdLdNR388+yddPo51QFxdlWnkM8vf5lk44SKicJuq5yGYHoCP7A2X6Em8jNWSOZ6dIok3M/cwFSkfXGukFPjkGChNduss9Cc49RpsXgqgZdEdK7se2oXw6m4DgdfA6Fp1BaxaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v+pKyJr5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ginns0Qj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 2 Apr 2026 09:03:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775113400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t40wZeCuWVnwzUJhQxO88spnP0YMQ53Htf2Z4u5PKL8=;
	b=v+pKyJr5yqSNL/P0e98/BkB5CZSVO+ZdB9ZajyuzMJNXkL2A25z0UFxl0FlciQxpMcBx8v
	YtCausnlRb6+se84j1eIVuavsBPQW9ADU2tHLewanLfeehKQV3l/TIE3wBtxrKFVJKAEcU
	wGhdd6vbV54Cvu9kdXqTt5nRU2oy9rPOI23z1zxtdacRZM08CsBxfUvnyXpbBFKpPDuOmj
	2azymZksz6RJowTwLkbr2ao9HrwWs1x5jioiUxw+K/7YcxP0sdD3GY/cIfuwCgwAkEY3j9
	eGGkFh+pb9GdyXB4+8QsLZvCxkfRSzYuNZm9ra0RUi89uMWBFL68YrguK6huCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775113400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t40wZeCuWVnwzUJhQxO88spnP0YMQ53Htf2Z4u5PKL8=;
	b=Ginns0QjrOTleComWPH5A4fRRNpHr/vaP7CZKKw6MPZVyAeUlSfmZmS+2EeEdd28nyDKma
	OXxm5kxPQkqFL9Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Vacek <neelx@suse.com>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org,
	spasswolf@web.de, tglx@linutronix.de
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
Message-ID: <20260402070319.vhRd6c-f@linutronix.de>
References: <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
 <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de>
 <20260218073036.AlkNRoAP@linutronix.de>
 <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de>
 <20260226172927.2Ck9wZMw@linutronix.de>
 <20260318103009.2120920-1-neelx@suse.com>
 <20260318111849._MMol8Hr@linutronix.de>
 <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com>
 <20260318145101._iaDDpbE@linutronix.de>
 <CAPjX3FePCKQTaxB6zuo+_V09PZct=utw3vgJUTM_GrZQtv7_TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPjX3FePCKQTaxB6zuo+_V09PZct=utw3vgJUTM_GrZQtv7_TA@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,lists.linux.dev,web.de,linutronix.de];
	TAGGED_FROM(0.00)[bounces-274397-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCD51384E2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-01 18:55:43 [+0200], Daniel Vacek wrote:
> > > > The above was me thinking and does not even compile for !RT. Commit
> > > > b824c3e16c190 ("net: Provide a PREEMPT_RT specific check for
> > > > netdev_queue::_xmit_lock") is what was merged in the end.
> 
> Thinking about it again, wouldn't it be better to have one generic
> solution rather then special-casing for PREEMPT_RT vs. !PREEMPT_RT?

PREEMPT_RT and !PREEMPT_RT is fundamentally different here. The one is
not preemptible and records the CPU of the lock owner to detect a
recursive deadlock.
The other is preemptible, uses a different locking type/ class which
records the lock owner which can be utilised for this purpose.

A generic thing would be to remove this and rely on lockdep. This could
work if it is only a devel thing and never "I setup something and make a
loop" sort of thing.

> --nX

Sebastian

