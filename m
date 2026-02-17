Return-Path: <netdev+bounces-259136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KEXDyW9lGnHHQIAu9opvQ
	(envelope-from <netdev+bounces-259136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 20:10:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDD614F85A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 20:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B16D1301C885
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E30376BC5;
	Tue, 17 Feb 2026 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="g47Y+GJ9"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19205376479;
	Tue, 17 Feb 2026 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355419; cv=none; b=l1kid+fDCoz2l8UdwwS1VlMTDMesKKQDBWH2jVT6eSrI/yYX+fXntqIDAIVhlI5Pssd9wGkkF29XlQ5YJz+jxW5N3AXsnLX1xSGT/8ygMl1513SDEK/kPNqiPpQfD3/FbypvSZ6lx33Kg9mVANTLeqjqCxW8p8uSeuhvzeF4XsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355419; c=relaxed/simple;
	bh=DMn/X7JPswdvwAiJ2ERGw9zPJHYpHR48YfR2ORbVBP4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KBPhrtxRYdP2gSUI0V75zzNDnhxc05XntauOu0Tuvz81bc7AndpL5KysZaymC+GxVeJkqdR3vbMNparPm4g9dho1YXOcpdvN3soTbuSzpLFQuQgEwe5NKuwEm/do682H0u9lS0qtju0oxTMt0BD8I25+sImTl9w96yKxCoxjWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=g47Y+GJ9; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771355410; x=1771960210; i=spasswolf@web.de;
	bh=qEo1QUIhsY/2hiGa0MmuFnBvt3ENvi9iPRJmOUY9wvs=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g47Y+GJ990Cn4Hh8XxrB7nbCB2jnWuFtcxXl7GOb8Kk0N1NwPORiKFG+aZgXZ48C
	 C5uuddYtuAkGuao6M0xR5OpwNJ25Qr8dmLB0OJ6OZsHYMY+JSIW5US7zl4r0tfJdL
	 bKs2A28b9mwBADHCUBbNSntxDroxrC4GShG5PEGUvP9OW0LOD4tydL25yp9Ezvkef
	 LlBXLkkFU1wpXHr0GcVbpBh1iT5EypN4acMsToYczewfg4OOe0FCdXqPwv0MY5V/C
	 tep5E2OWTWGZDZywZwvnjCdxch6BuDd8VnRkeyUnrT/7V6QneBU7BXVSwd3hvs1zt
	 0NaqQ3MOqt++fhrF3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6bCu-1vgkKy06n8-00vuTP; Tue, 17
 Feb 2026 20:10:10 +0100
Message-ID: <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet	 <edumazet@google.com>, netdev@vger.kernel.org, spasswolf@web.de
Date: Tue, 17 Feb 2026 20:10:09 +0100
In-Reply-To: <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
References: <20260216134333.412332-1-spasswolf@web.de>
					 <6274de932f4a62c51b424b65fc875ef3cb5ffd60.camel@web.de>
					 <20260216153745.CA3__zRc@linutronix.de>
					 <37d6e27f96afb57c5716798530cb3560d25202e5.camel@web.de>
					 <20260217071952.WCXLGs5-@linutronix.de>
					 <80114792206dc00d0099f00999a209e717debb12.camel@web.de>
					 <20260217095700.SjYjM8RO@linutronix.de>
				 <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
		 <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de>
	 <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ThjVOqZOmCM6EwwQLEnrLz/nEge+b2GX1xngioYyKmBupKveycB
 R9Hm1ZI84Zi5Heccz4TSjjSMGtnMAq2lxUBkbWGRib2MW2tw6eAy0yGSuTtfjFd9gF6Dz6s
 3qaa7cfKXmfxYuL1G3QWgNlYQEvwARbdQi2mf0eGNPiC3e4Pjf+uG0ZZNYbhSUg7gUPc7B2
 WY+5fZXQjtmq40yrfmBEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X95hhxOfSvI=;FIB3c9uaRcpeH19dWPQ1ehEKOuG
 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
 izFGrflbY6eZtNdgA1KjwDRV2b7xLEDgEuVKNZ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259136-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,lists.linux.dev,kernel.org,google.com,web.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spasswolf@web.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[web.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFDD614F85A
X-Rspamd-Action: no action

Am Dienstag, dem 17.02.2026 um 17:52 +0100 schrieb Bert Karwatzki:
> Am Dienstag, dem 17.02.2026 um 12:24 +0100 schrieb Bert Karwatzki:
> > Am Dienstag, dem 17.02.2026 um 11:42 +0100 schrieb Bert Karwatzki:
> > >=20
> > > I just wondered if we can completely skip the
> > >=20
> > > 	if (READ_ONCE(txq->xmit_lock_owner) !=3D cpu) {
> > > 		[...]
> > > 	} else=C2=A0
> > > 	{
> > > 		/* "Recursion" alert */
> > > 	}
> > > =20
> > > check, as the synchronization will we provided by HARD_TX_{LOCK,UNLO=
CK}.
> > >=20
> >=20
> > I thought about that again, and it seems like a bad idea as (in the no=
n-preempt) case
> > other threads trying to access the queue would wait for the spinlock t=
o be freed, perhaps
> > one can just change the code like this:
>=20
> My argument above seems wrong: In the non-preempt case we cannot have an=
other thread accessing the txq
> from the same CPU if the lock is taken (it is not preemptible) and for o=
ther threads
> accessing the txq from different CPUs the check (txq->xmit_lock_owner !=
=3D cpu) would succeed
> and they would try the spinlock anyway, So this would not speak against =
killing the lock owner
> check. As for the recursion detection, perhaps dev_xmit_recursion() is e=
nough?

I tried to research the original commit which introduced the xmit_lock_own=
er check, but
it is present since linux 2.3.6 (released 19990610) (when __dev_queue_xmit=
() was still called dev_queue_xmit()),
so I can't tell the original idea behind that check (perhaps recuesion det=
ection ...), so I'm
not completely sure if it can be omitted (and just let dev_xmit_recursion(=
) do the recursion checking).

Bert Karwatzki

