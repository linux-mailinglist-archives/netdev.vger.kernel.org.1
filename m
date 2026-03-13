Return-Path: <netdev+bounces-267525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIOHODg3tGnTiwAAu9opvQ
	(envelope-from <netdev+bounces-267525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:11:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6120D286BF7
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F216E30F3383
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A613C3424;
	Fri, 13 Mar 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tLtdcqFr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DaXfKOOq"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826993BF68F
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417855; cv=none; b=rZWgOaTGaeQAgDt8UJJ2Ja5as7ruWZAxfaW5zQCCi2BXByoneltLDNuab4jYNVQ7+nLuMGshFFfDJMW4eIWZ3YqaNSi8Gd8X915hlEnZYwYTz5qzhubX9NIXnrlxlk47iC5bjjaMQIxUf4t4W6sRySamo6mixs3+viJjQe6OtKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417855; c=relaxed/simple;
	bh=Os9OGqI/GiFxIcUB3qZkiV6dVPa0/qO3/TQBPFug83M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld1sznf4Pkfmr1Fyi9mePK3Dpwy/H16pnlgYZS+kHtSJEWF+/QNjlSQ+s9OZt1oJnOPMKDJEKwP5vbfdKxt+Me9AN3CmAZRawM5r01sd70xxiCajSBiaCKZxlmWcBYPIzduZ3f988B9UQ3nbr0wFNsEAB8+WP7RHDgiut+jsOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tLtdcqFr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DaXfKOOq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Mar 2026 17:04:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773417851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEWU0/matrOJLsNJxumxawiXdtRPf8QhMsBxFlTC9t8=;
	b=tLtdcqFrbGBPzb9AdoxpM/vjFcvSCEIyw2+LggPcgofMkRknapOygt0ish11NlfJb7yMrT
	QrZP1jZymK1hsK8TQtQnugcCgRsnzzA9hj9+brcF4QUOi9tDaNABn0Q8LnSqY+AA3SE/E3
	PiIMTxIZ//Cfj3oQTFt188QCCnbJqeoIZ9bAEOEL0HA/Fwld7vX29kCH5yE7ZvxRNZts2o
	ilUWdYry2VaAk4DCls4NhaK5OPt00J9u84RJrQ9RdypkNjzzr4aSl3GPwh3odklFboXndL
	fAKrkxan7ZOsZpRdHu1ZW63htMt1fRbkZyF9CVgM0keaL7Oui/3Ro4kxGRAKHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773417851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEWU0/matrOJLsNJxumxawiXdtRPf8QhMsBxFlTC9t8=;
	b=DaXfKOOqTCCvPIwry1iUw3VnFZeHKOtiYLmOE68gral8TFA8oeeFmmHRIsk3bqUbLwpdCq
	63qw0euXRqsr+hCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RFC net-next v2 2/2] af_packet: Add port specific
 handling for HSR
Message-ID: <20260313160410.LEhav8Xz@linutronix.de>
References: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
 <20260309-hsr_ptp-v2-2-798262aad3a4@linutronix.de>
 <willemdebruijn.kernel.3b7b5294c6434@gmail.com>
 <20260310105544.EVXIekwG@linutronix.de>
 <willemdebruijn.kernel.3693c9aa8271@gmail.com>
 <20260312154253.UC-QUPvD@linutronix.de>
 <willemdebruijn.kernel.be379ee17449@gmail.com>
 <20260313092226.SscHp2zQ@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260313092226.SscHp2zQ@linutronix.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267525-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6120D286BF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-13 10:22:28 [+0100], To Willem de Bruijn wrote:
> On 2026-03-12 17:43:36 [-0400], Willem de Bruijn wrote:
> > > Yes, this is RX. If I open packet socket, bind to hsr0, how do I filt=
er
> > > for packets from one of the slaves?
> >=20
> > I was thinking of attaching directly to the slave devices.
>=20
> That could work. Let me see.

Halfway done. What we went down to is:

Send with header    -> eth0/ eth1 + SO_MARK for header + port 1/ 2
Send without header -> hsr0 + SO_MARK 1/2 port 1/ 2=20
RX                  -> listen on eth0/ eth1

Now this compiles and I look into userland and am currently stuck with
the problem that it does not expect "two devices". It is not impossible
but=E2=80=A6

> > > After some thinking and browsing through the packet code:
> > > The hsr stack creates hsrX. If it would create additionally hsrX_A and
> > > hsrX_B in order to be able to send and receive only on the relevant
> > > slave device then I wouldn't need the filters in packet code. That co=
uld
> > > work=E2=80=A6
> >=20
> > That's another option.
>=20
> Okay. Let me add this as plan B then.

At this point I am considering this which would avoid having to use
hsr0+eth1 for one direction depending on whether I have to send with or
without the header. But this might lead to other problems such as ip
address and so on.
=20
The suggested changes to af_packet, that remains a hard no?

Sebastian

