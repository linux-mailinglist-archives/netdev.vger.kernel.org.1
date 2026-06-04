Return-Path: <netdev+bounces-295353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qcNIGoqrIWrjKwEAu9opvQ
	(envelope-from <netdev+bounces-295353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:44:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB18B641FDC
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:44:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UeJbxwqN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295353-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295353-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E1DD30B9BDF
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E12481A9E;
	Thu,  4 Jun 2026 16:36:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C2140961E;
	Thu,  4 Jun 2026 16:36:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590981; cv=none; b=hcJCyfMaRqoyRcV2uAqzSdZAkGgThW8XS8mf66GJzXp71gyCv4hRRNHYkI6GWowe/TMRBJzn+7eXyceywwfB+vZLI/N7mEQlM1T790vfpd0dBea45NePwTKrSWApYvr+3kOHgeoigOYPLCbelwFMXgxWz7VXz9drpIvx6gIPW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590981; c=relaxed/simple;
	bh=79767qT4cxoYvoYC9/wCqAKQO0v9jT3L2K/ugsJBoLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i93+sqyzKzq4yQ4fJB2euaTjtJangEXiHl1R+Ih3GsnRDH9afeHe3FuM9vvtXugJCd24O5lMAHUvLuKRnijCmStExprw29HpAkftIj+GzuBGc5oLPSORQaUhva4ISajNAkAMUo0M5fEf4nxv0a/rI4a8AmCWXQhRMuQ/mMWchQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeJbxwqN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F214D1F00893;
	Thu,  4 Jun 2026 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780590980;
	bh=79767qT4cxoYvoYC9/wCqAKQO0v9jT3L2K/ugsJBoLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UeJbxwqNUrMAoASAFTbAhPd7x6kg0LyZyTe09Aq5Fj0mG5kt3Pug43cVhKlgMvG18
	 lmLzxJFIvevDeWXHTE4r3etdwIiTwmzCyrrJ0GpYA3wIw6Fs28liplDRy68UOPzXjJ
	 fEnVWxHoef0dWOPrYsVspsiVpPdjhEIAzFt7O98xOY/njlqugajhLFcac+lThvA0zZ
	 cKGpZD9RV8pa6mpnwNGX73Crg3Ixo1JmCPA28nQbA+HpoTRWi0cY0wfoWH2xfwKC73
	 ONBmOFyzb5I0iwhSRGWeuooZBeumd+cI3H35RrDnE/saQHV8k3xS8K2ErSHOpdTkCJ
	 ZAAR7Um/zNPfA==
Date: Thu, 4 Jun 2026 17:36:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: "Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Message-ID: <20260604-swimwear-garnet-3eb092e6fda7@spud>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
 <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
 <CY8PR02MB9249E607ACBF3A05AB83ABF683102@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dDRoXKzkAjgb7RZm"
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249E607ACBF3A05AB83ABF683102@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295353-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:Parthiban.Veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spud:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB18B641FDC


--dDRoXKzkAjgb7RZm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 03:21:47PM +0000, Selvamani Rajagopal wrote:
> > Subject: Re: [PATCH net v3 2/2] dt-bindings: net: updated interrupt typ=
e to be active low,
> > level triggered
> >=20
> > Hi Conor & Selvamani,

To be clear, my angle here is making sure that the microchip device is
not deviant from the spec. I don't know or care about this hardware in
particular.
I just made the assumption that what was in the example worked, and
wanted clarification that what the example was changed to actually
reflected something else that worked on the hardware in question before
I gave an ack. I'm a dt-binding maintainer, not someone with knowledge
of these devices.

> >=20
> [.]
> > One possible alternative could be to use a threaded IRQ handler with
> > IRQF_ONESHOT, where the IRQ line is disabled until the handler
> > completes, and sleeping is allowed. In that case, we could perform the
> > SPI transfer in the threaded handler to send the data header and
> > deassert the interrupt, while deferring the remaining work to a separate
> > kthread (the current SPI thread). However, I have not yet tried this
> > implementation, so I cannot comment on its behavior or effectiveness
> > without implementing and testing it.
>=20
> I can test this in my setup.
>=20
> >=20
> > I may be missing something here and am trying to clarify my
> > understanding. I am also curious why this issue reproduces on our system
> > but does not appear in Selvamani=E2=80=99s setup with an active=E2=80=
=91low level
> > interrupt configuration. If possible, could you share details of your
> > setup and how the testing is being performed?
>=20
> My setup is similar to yours. We have Raspberry Pi boards (P-4 & Pi-5) co=
nnected
> to our MAC-PHY evaluation board. As you could see in my patch submissions=
,=20
> there are no changes to oa_tc6.c in the way interrupts are handled.
>=20
> >=20
> > Best regards,
> > Parthiban V
> > >
> > >>
> > >> Cheers,
> > >> Conor.
> > >>
> > >>>
>=20

--dDRoXKzkAjgb7RZm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiGpfgAKCRB4tDGHoIJi
0tLdAQDyZP4DBC3h3sB2EKG6Xrs/w0FHmzR69qe7gr1KiN8fnQEAxQq0LUEp574U
u25Oy7xpfeAn/+cFEAMtRdExAl7tzgY=
=xdbe
-----END PGP SIGNATURE-----

--dDRoXKzkAjgb7RZm--

