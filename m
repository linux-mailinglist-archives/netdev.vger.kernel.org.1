Return-Path: <netdev+bounces-259309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N3nGcy1lWk/UQIAu9opvQ
	(envelope-from <netdev+bounces-259309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 13:51:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D144B1566D2
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 13:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA55F300FEE8
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 12:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA431B823;
	Wed, 18 Feb 2026 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="jaajD485"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC231B810;
	Wed, 18 Feb 2026 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771419054; cv=none; b=RHsg1jG2Q8cLERrG35xB4MZgb4cfXt0j7l/Tc3a9NEQ2r/k86rJ5b7HBriid5mcNIGWQVxUHOM/ZNCvEc83RFzV1jGTQUwhUoduTZDln7YfXYkd53HFcmLReVQSVuLULMhSbv1pExsrnhQYWPByobhq2obV+YhnQvtW43J+Hi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771419054; c=relaxed/simple;
	bh=oiz0qSzTRSjwO6uBzEFh+1ASJTZei4IaQNol1aJ2eqg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bL3W2TVO8jI0NZEKgHYYrzzXXhRirv9gO7PYNwZK+/gfdRysYFgfTqYDT7s8cduVANIxI/EU1Rk19/mEuxJYIy6SblDubZ3FqHJdaYDeo5mFA+xRDWCTkBOi0ZcYP6s4b7OdVKKyKBZS7yY4fcp1IrjkehJQFbCXVXQVuc6fZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=jaajD485; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771419015; x=1772023815; i=spasswolf@web.de;
	bh=oiz0qSzTRSjwO6uBzEFh+1ASJTZei4IaQNol1aJ2eqg=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jaajD485e2WwPcsjaaiTPbH21QaiAiGCX8Y9GEy+RkDYpLow4QW2M+IaiPKpn7V0
	 bFze/T8RSbErskBrTh63bnUH87IVTFyUZrgQom8L4SLHehTQRus5FBThzvaxYKKMc
	 nBmh35Oyt0vcy/KWDZguAsHd8JJZJtRDAnEvnt7j1FqIwMDh1/6Nd663YOKN9V42B
	 mgr+zasN0OZn5J5Myg0AvvXz8A5IiRgDZJTcwJGG+89rkWRUq9dE0STeypGWfnJsK
	 mb0DwgixgQxGzVc2cce9LVjlzE06dP32TwU68ilfNehC8zch2nAvKmFCpht9aa7Ze
	 3s3K6u0I3/A3taQi2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MODmf-1w7sNi1Dg1-00NprJ; Wed, 18
 Feb 2026 13:50:15 +0100
Message-ID: <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet	 <edumazet@google.com>, netdev@vger.kernel.org, spasswolf@web.de
Date: Wed, 18 Feb 2026 13:50:14 +0100
In-Reply-To: <20260218073036.AlkNRoAP@linutronix.de>
References: <6274de932f4a62c51b424b65fc875ef3cb5ffd60.camel@web.de>
	 <20260216153745.CA3__zRc@linutronix.de>
	 <37d6e27f96afb57c5716798530cb3560d25202e5.camel@web.de>
	 <20260217071952.WCXLGs5-@linutronix.de>
	 <80114792206dc00d0099f00999a209e717debb12.camel@web.de>
	 <20260217095700.SjYjM8RO@linutronix.de>
	 <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
	 <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de>
	 <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
	 <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de>
	 <20260218073036.AlkNRoAP@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tZ3T1+z48acjku+wUM1FS1gvod/HiQcMZJv5r+Bf4hWYiFw97N3
 Q/ZCSYXJdZjuDlg44q6JWl39x+Rny7NsjcozxBL2WZhBfjfhq37LEE3QA/DONNVISYsw1uX
 iAtqE09xfvReRiEiSmgmfKdJ2mNrSp43IUPtbP4Hv+A/HnHmkLEHWCygTIJSDcHocB57fbk
 7N3bMJ8ikjBhEH9jM+ZUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1JPBO3HMeBM=;crzQwpTHIg0aN8ALe1ZzgLdmfQ2
 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
 rYTh6EYo9dc+NEIR6iAQp7nxogxSX4xlm6DjCt
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
	TAGGED_FROM(0.00)[bounces-259309-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: D144B1566D2
X-Rspamd-Action: no action

Am Mittwoch, dem 18.02.2026 um 08:30 +0100 schrieb Sebastian Andrzej Siewi=
or:
> On 2026-02-17 20:10:09 [+0100], Bert Karwatzki wrote:
> >=20
> > I tried to research the original commit which introduced the xmit_lock=
_owner check, but
> > it is present since linux 2.3.6 (released 19990610) (when __dev_queue_=
xmit() was still called dev_queue_xmit()),
> > so I can't tell the original idea behind that check (perhaps recuesion=
 detection ...), so I'm
> > not completely sure if it can be omitted (and just let dev_xmit_recurs=
ion() do the recursion checking).
>=20
> Okay. Thank you. I add it to my list.
>=20
I've thought about it again and I now think the xmit_lock_owner check IS n=
ecessary to
avoid deadlocks on recursion in the non-RT case.

My idea to use get_current()->tgid as lock owner also does not work as int=
errupts are still enabled
and __dev_queue_xmit() can be called from interrupt context. So in a situa=
tion where an interrupt occurs
after the lock has been taken and the interrupt handler calls __dev_queue_=
xmit() on the same CPU a deadlock
would occur.

Bert Karwatzki

