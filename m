Return-Path: <netdev+bounces-295535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VtWhHOsiImrXSwEAu9opvQ
	(envelope-from <netdev+bounces-295535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:14:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C65E6444F8
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:14:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=oDmkyogF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295535-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295535-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8920230118CA
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641F429B78F;
	Fri,  5 Jun 2026 01:14:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E227A91D;
	Fri,  5 Jun 2026 01:14:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622054; cv=none; b=BztTgN/Byl+Adb0ETkGk0lmwgQXoQT+4oPtj3RTOk70hAHDYCDfwRnqnR1E31gYCxc9/vKMhaVSBOxUJ55Vdu5foyzNEN3TMHqNuBeygd+bfNc5A+9vfy496+j0Kk/CYJdSbEneZy4CR3r7tvMhn2a05DJTz7bjvD/1BMHdvJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622054; c=relaxed/simple;
	bh=DrfrjKEiOQMi4PdJ4tlqIf5bMHmaoVxpAStGpcKRSzc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=txK6xQkU6sEiyNsXjgcbPlBVgD+HrngSimttoW4tyi4n5TCMvlcmsKsciT0iFCVGsom9XmyM8SMrVFACc7o5nekg53g/jqmd3YBCmbWu8LubAsm6+RYHQ+fc9SLrSLGdvTYiZvpONVcojNePq3tcudRXGL51EybvdOsokkKWpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=oDmkyogF; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 2831C60937;
	Thu,  4 Jun 2026 21:14:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780622051; bh=DrfrjKEiOQMi4PdJ4tlqIf5bMHmaoVxpAStGpcKRSzc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=oDmkyogFljIzJqXnVOl8N6/Z1kZ8rd/mJgU/o0OrOpVUeL8DjCpBOfUpS0pR0IKxn
	 4Ulg+dMVm8mI5d598F3TyKPE9gre0i6QECupfnwYmae7zkb74kYp3+v/7qdWhZPc89
	 8xlnQl18znnEZMBZ7wLva1NbgYrVBqnhxYeB13mFqcaxMbguXpY5KhEMRmPwHDvzUm
	 MWpfb8ssI7lKribphXyl89P+batCi/NwOgz27KyR4RCupNVR+pDPCodmbnjT3niroz
	 ZqCKdTG1QrdOG0NVcWtrpw7xc0wzre/SnHbyl0xpha357iFkxy6EcyVeLj4V2nc6RL
	 Ur4T9AVp8AHbA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for dcb pcp
 app
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <4d6e6d83-af79-4a06-9736-d6d81e705a61@lunn.ch>
Date: Fri, 5 Jun 2026 11:13:55 +1000
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
 cedric.jehasse@luminex.be,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Max Hunter <max@huntershome.org>,
 Kieran Tyrrell <kieran@sienda.com>,
 Nikolay Aleksandrov <razor@blackwall.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B9290FD7-FB84-4FF7-BA30-529484B8A01F@padl.com>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
 <02BDD59A-30A9-46F9-8413-28A867B50CD5@padl.com>
 <v4fqikeec52ginmogfvsfe5gobul2nqspe2ebzpzpja52lxacb@wq2elxqwrucf>
 <E43832AD-0F8A-465F-95E3-2AF5E72FB7B9@padl.com>
 <4d6e6d83-af79-4a06-9736-d6d81e705a61@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.700.81)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295535-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:cedric.jehasse@gmail.com,m:cedric.jehasse@luminex.be,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:razor@blackwall.org,m:andrew@lunn.ch,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,luminex.be,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,huntershome.org,sienda.com,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,padl.com:mid,padl.com:from_mime,padl.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C65E6444F8

Hi Andrew,

> I don't know enough about AVB, so this might not apply here....
>=20
> What does the pure software version of AVB look like? Is there a need
> to configure these parameters? If not, why not? If there is, what API
> is currently used?

Qdisc configuration for AVB is described here [1] albeit with reversed =
numbering of TCs. CBS parameters are usually managed dynamically by SRP =
(in user space), but static configuration as shown in the link would be =
common for automative AVB/TSN.

> Ideally, the user should not need to know if some functionality has
> been accelerated by offloading it to hardware. They just configure it
> using the standard Linux model of the feature.

Absolutely, and that was the model I used when building a SRP daemon, =
which I first tested with the software bridge and some i210s.

One issue is that AVB is typically configured using MQPRIO, which =
configures egress queue mapping. The Marvell switches support ingress =
queue mapping (the subject of this patch), although there is a special =
case for AVB traffic which does allow for egress queue mapping.

The main issue is that inbound frames belonging to AVB TCs that do _not_ =
have a SRP-managed DA must be dropped. This permits those queues=E2=80=99 =
CBS bandwidth to be reserved for AVB streams.Marvell implements this =
with the STATIC_AVB_NRL entry state, combined with an ingress port flag =
that enables the packet filtering.

My patch mapped the Marvell model to the software bridge, i.e. new =
IFLA_BRPORT and MDB flags. However, Nikolay (correctly) points out that =
these are unidiomatic for Linux.

My understanding is that these should likely be managed with tc-flower. =
The SRP daemon would manage tc-flower entries along with the MDB when an =
AVB stream is admitted. Unfortunately, implemetning this in mv88e6xxx =
would be more complicated: it would either require intercepting the =
tc-flower requests and mapping them to native AVB admission control =
(which may be fragile), or adding PCP/DA matching to the TCAM =
implementation (which may not be sufficiently performant, more research =
is needed).

Luke

[1] https://tsn.readthedocs.io/avb.html

