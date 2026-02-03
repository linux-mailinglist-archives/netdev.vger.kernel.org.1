Return-Path: <netdev+bounces-256267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKhmFG/mgWl0LwMAu9opvQ
	(envelope-from <netdev+bounces-256267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:13:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA2BD8DBF
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B14BD30C4BA1
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 12:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5579C33D6EB;
	Tue,  3 Feb 2026 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hjGIxiwM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dlxj3Vks"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4E933D507
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120498; cv=none; b=NX4G0VuppfoXOUGbVZ3cOr0bQoMSnYpk9Opn1V2pAxkaLHeU9/OLBfTOuxtipOMo8PCsAcojFOGpwRGgpHjL5sjvlrejEds330CpYdT9iYj0hXYjEwpE33pZTkotgApozYG9qVlNK3isv09SjvhBfpOl1f47cl5fXZB9RvyVzxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120498; c=relaxed/simple;
	bh=8bSysvQh9zNKGwuLq+TYG/kdhuPi5MrukSfdlgYfzPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGI9fkVb9x5/tYkKZI4AVfWBhxCCDc28KEDKAHxMo6tL2+wfHP713QsljI0OV6ja4FcZm7qYuLUDZdxQN41GPe3qOFarpYdxVUNjb/Ry+FP33QMDhNuaX8sPHAGprdJ3kdezYnK+bo8hcsQj60yGv1GC5iH25E4B3pWx9vAT7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hjGIxiwM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dlxj3Vks; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 3 Feb 2026 13:08:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770120495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XEZipE0D329CXpQUVmd9S2ilaIWX19xXCTc10NTNPfU=;
	b=hjGIxiwM8+o/k8ZARcLamjk/DPyxeGOBns80cWDjWLRiWPPbsGuMOMm0NmrJ0N6fAPFaag
	lPPNwqK6RPk5PVxOz/0B/ana2DnDzyVTkGTgTAnwkBCu0o5RTU+hdaXXQMwJdo5wPRuy6L
	qnst5GIa2FxnL7BMWnlZ8lqPDmnqOjJWXekJcAaoKbXmXsOr2jJDDq6T+OvWbJgFRjZ2dZ
	Qo+W79hKBNRMjcyhOqDiKebU5IkwU+RdXesJL4IRI8AX68SomXLraTTgCgvKxBSlXrfgGF
	Y1MJOI5YkvnfAsFZzhxkRZYgU1Nl+DvoySc4eJ5dQmT7Iq5HlrP2LeyQq8H0wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770120495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XEZipE0D329CXpQUVmd9S2ilaIWX19xXCTc10NTNPfU=;
	b=Dlxj3Vks/hoEDOOYITUZ/hSUgtc3yDEZFxRZzNDMJCwH+lTZlw03Tm+wry8Ssz40ktuuNh
	qUIFSwlCd3y+v1AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net,
	Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH net-next v2 6/9] hsr: Implement more robust duplicate
 discard for HSR
Message-ID: <20260203120813.hSgDgi4e@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <07b90a435ed7d3450c1949e3a21910916d8538de.1769093335.git.fmaurer@redhat.com>
 <20260129144348.CIs44m-d@linutronix.de>
 <aXuIAFJ_m6gMUFFO@thinkpad>
 <aXugXpSajp6jzG1o@thinkpad>
 <aXyJTzwJ3x34B-xR@thinkpad>
 <20260202175311.m2Qu8pEp@linutronix.de>
 <aYHg08WMQyQKmgZO@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aYHg08WMQyQKmgZO@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256267-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,smile.fr];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: CCA2BD8DBF
X-Rspamd-Action: no action

On 2026-02-03 12:49:39 [+0100], Felix Maurer wrote:
> I think the duplicates can occur on RedBoxes if they are used to couple
> the HSR ring and another redundant network (either with a PRP network
> through HSR-PRP mode or with an HSR network through HSR-HSR mode, which
> we both don't implement at the moment). In both cases, two RedBoxes are
> used to maintain redundancy and both independently inject a frame they
> receive into the HSR ring (see Figure 12 and 16 in the IEC
> 62439-3:2021). But it's also the RedBoxes that would remove the
> duplicates, so we would be aware that we should discard duplicates on
> port A and B.
>=20
> However, I'm not sure if these are the only cases where duplicates are
> to be expected in the ring and I don't want to prematurely make the
> decision to just forward everything within the ring.

I would have to study the spec first to understand how PRP, HSR mix
works with the redbox before I can give a statement. But yeah=E2=80=A6

> > If you track duplicates for A and B in a single "bitmap" then this would
> > mode X.
>=20
> I think I didn't understand this clearly and I mixed this up in some of
> my replies, so just to make sure; there are two ideas:
> 1) Track port A and B together, i.e., don't forward the
>    counter-duplicate, i.e., Mode X (which is optional to implement).
> 2) Don't track duplicates for port A or B at all. We consider duplicates
>    in the ring as a failure of another node.
>=20
> We don't consider 1), i.e., Mode X, at the moment. We are only
> discussing idea 2), right?

correct.

> > I nag here a bit because you allocate 16 + (128 / 8) * 4 * 64 =3D 4112
> > bytes for this bitmap per node. That is a bit over 4kib. Then adding and
> > removing sequences got a bit more expensive. Anyway. There is table
> > F.19+ specifying HSR tests and don't find "forwarding duplicate over
> > port A". So lets keep it.
>=20
> I totally understand that. It's quite some memory for each node and I'm
> very much in for reducing that. But I'd suggest that, for now, we follow
> what we had before and what the standard explicitly asks, which is to
> track (and discard) duplicates on port A and B as well. I'm not sure if
> we should diverge from the standard in one of the few points where it is
> explicit. If I understand your last sentence correctly, you're okay with
> that as well?

Yes. Because you reworked the duplicate-detect algorithm and I would
like to keep the "unrelated" details (tracking A, B, =E2=80=A6) as it was s=
o if
it serious regressions get reported we can easily pin point it. So we
replace just one thing and both multiples. At the expense that more
memory is now consumed but this is fine I hope.
So this might be for the future.

> Thanks,
>    Felix

Sebastian

