Return-Path: <netdev+bounces-256265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PrYM3zigWmDLQMAu9opvQ
	(envelope-from <netdev+bounces-256265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:56:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEB3D8AD0
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C38CC303EA85
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 11:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A41833A9CE;
	Tue,  3 Feb 2026 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LQPrU3ue";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v4JrSI8q"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3325922339
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119731; cv=none; b=uhmdeYj8D36pP06mmtyNL9wEH8cAdGy4r0LnbPzTEiT/JTx+m98hXu49BOa77hjdQ3NLF4Lz7DIteNyxDSkJShtsIwMovNpB+8M6XRsoPx4s0tRLj0yXa/OHMfY0jAextXgVQOstzBF7tPgdubl14qKaToEwjRWyTxLOKd28l40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119731; c=relaxed/simple;
	bh=E0f8GZmgUOwhueSTLBy64V/CX5KZBYbahNfn1Aqq1Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDMXvq/W+CrNfvVtv1R7yNhVnGBHAuDA/yjfuExfmXdgrWMwgJzuVUJDb+D/NPdaBUfD4G8z/NUdLNffBRDZQ5S7H/1l/pxyHRz+0fe/wtFgx73yXYBITy4G7DVmBgO7ZTrgQbRCxclUWpXhtJAJ1u5woTLLZu6NUNzNCUX0Bv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LQPrU3ue; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v4JrSI8q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 3 Feb 2026 12:55:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770119728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WbqZLNIxIt2CZnVuK8LUNRYPAW4wNCJs3/3Ex9GgdW8=;
	b=LQPrU3uejySgWxK/qxfuEF/pFBaVSArzDhibQDpsMFb4htKRTIIsc+lln9Dboc0U9m+PGC
	5R+0fxa8qNE/vU5w8/bolDVSqibCOcu9cgVfCZvPOjTU94xALMLooZeKaXei2OhF5CvpDA
	Ea2su6hq+E/BtS7xMhgM1WvdbYmXLLJxqR7QbuxImYKV1lwVnV+Fw2FxiawfzF3J7eIacH
	h8hc2iw3/eNuhKhEla66DTiCtRZoUtpZn2V/iSoSfuIL/BQV8UpWM7AgYWU3cd1tcrigdA
	CvDhhZtvDXF3+mzJb+dHQQzn0+1iilqpVoW4D3QLupKpaVu4cAsNaPsYHL5oWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770119728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WbqZLNIxIt2CZnVuK8LUNRYPAW4wNCJs3/3Ex9GgdW8=;
	b=v4JrSI8qZb0NhpzC2QvKc92c/+t0ZR3h425f+VUuWzJMj6jBooYHtOQOboOJOdOHUvpW96
	7QnvVJoJs+lrVYDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 1/9] selftests: hsr: Add ping test for PRP
Message-ID: <20260203115526._PRE3nvY@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <b54f9225ae39d0d4bd9c8c1b0b98fe47fb7211eb.1769093335.git.fmaurer@redhat.com>
 <20260129110500.l2jOMEYp@linutronix.de>
 <aXthMlr6Hpas1LBt@thinkpad>
 <20260129152149.dKwN1yGM@linutronix.de>
 <aXucj8L-cBUVIYHX@thinkpad>
 <aYCPsDZeJvCrJYRH@thinkpad>
 <20260202155510.C1zpsxnk@linutronix.de>
 <aYHJ9KHdiBEGfjwA@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aYHJ9KHdiBEGfjwA@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256265-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CEB3D8AD0
X-Rspamd-Action: no action

On 2026-02-03 11:12:36 [+0100], Felix Maurer wrote:
> On Mon, Feb 02, 2026 at 04:55:10PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-02-02 12:51:12 [+0100], Felix Maurer wrote:
> > > > Hm, I am not sure? For PRP, it's an explicit requirement to use the=
 same
> > > > MAC addresses for both ports. For HSR, I think the standard is less
> > > > clear about the MAC addresses. And at least our code seems to assume
> > > > that there could be different MACs on the two interfaces of a node?=
 But
> > > > yes, the node merging addresses this.
> > >
> > > I'm still not 100% certain, but I agree that the standard reads more
> > > like the MAC addresses should be the same for the two HSR ports. At t=
he
> > > moment, the kernel and the test assumes that they can/should be
> > > different. Therefore, I think we should fix this across the board in
> > > another patchset if we agree that's the right thing to do.
> >
> > I would suggest to do so. This could serve as bad example and my PTP
> > userland patches expect the same MAC on both ports. So ;)
>=20
> I'll put it on my list for another patchset :)
> But this of course brings up how the MAC addresses should be handled on
> the HSR interfaces in general. At the moment, for HSR we copy the MAC of
> portA to master. For PRP, the MAC of portA is copied to master and
> portB.
>=20
> If the MACs should be the same for both ports of an HSR interface,
> should we set them when creating the HSR interface, similarly to PRP?
We do this?

> And does it make sense to copy from portA (feels somewhat arbitrary to
> me) or would it be cleaner to copy from master to portA and portB?

I do
| ip link set $portA down
| ip link set $portB down
| ip link set dev $portA address $mac
| ip link set dev $portB address $mac
| ip link add name $if type hsr slave1 $portA slave2 $portB supervision 45 =
version 1

and then up, up, up to get up the three interfaces functional. $mac is
the MAC $portA.

On the other hand it shouldn't matter because while adding the HSR tag,
the MAC of the hsr interface should be taken but somehow I observed that
packets, which originate on the $portB interface have the MAC address of
this interface. So I did this and forgot about it later=E2=80=A6
But then hardware offloading might behave different if it considers the
address of the interface so it might required to set the MAC address.

I am uncertain what the best practice would be here.
Forcing the MAC of portA to portB could be done at setup phase by the
stack but would require that the interface is down=E2=80=A6

> Thanks,
>    Felix

Sebastian

