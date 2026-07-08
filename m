Return-Path: <netdev+bounces-305903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vX8WGlqBTmo9OAIAu9opvQ
	(envelope-from <netdev+bounces-305903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:56:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB48728F39
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:56:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lwOZDHhF;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305903-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305903-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7391300B1DE
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 16:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D373F12C8;
	Wed,  8 Jul 2026 16:56:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD4370AE0;
	Wed,  8 Jul 2026 16:56:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529782; cv=none; b=rG8iEX4j9Bsytd75/vEI80crKKRWsHpeIy1kCHteYxLTGOveHJ6m2TobFt5pWWuX4p5LKYvODpXOu+qKVS25zXcFpvnAFyJksXQLODuZBy7nm3Gf4mo+PzqvGkhg9cT4tB70/aT72NzONWMPz0Tt9QroH9q7AKZ1W9ooxBEntLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529782; c=relaxed/simple;
	bh=noniq48uyme1ndn7+boWnmBCWZtb2rUs87YKHFxsKVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG00MpIk3S9smDgZkp0ctzQSjrxZx5G6iDi6WYR+aj54zzgg0oqUoZkFA7/Gv4h9RJS/Oglj88lOjBiYuyIBKxOyRwgfZh8A7HsiW5Qo+HPuu5tAk2VSTk8K6ZGNK/geTW0ZfA9A3Xvugmy9U0Y7XxcImyQQbO7ujNEdoTMX5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwOZDHhF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE1A1F000E9;
	Wed,  8 Jul 2026 16:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783529781;
	bh=noniq48uyme1ndn7+boWnmBCWZtb2rUs87YKHFxsKVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lwOZDHhFW70q9GXQoGm2w2/I//SGcLmwE+CZAEmFJeK4PR7q5WUGSY1MD0hpvsYaD
	 zZsM1sxrCt3GYzei7lCKeJ19o1q9jHviK/aJh2+eqn6ownSMspMUyFcFTp+ir41gqF
	 PT3zWVEyJadHuECJMV5RzM0GkcnlpviWyEjY26NL1EUTSTHFUxk71DsAqmQpIyxGEu
	 j3eKnjCR8pQdDAnqisPnQXuoYepruJxa7oxjobGzEA9jVS8hjo2XacdM1GkVqMbVvp
	 M9Emd+9XddR7on8UNt32ZgCtPny1kH8bmgMYwYHDkywLhucK3c+TkL2+0c6+9JZAii
	 SvItTOIac9oZw==
Date: Wed, 8 Jul 2026 17:56:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v5 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek/Broadcom PSE MCU
Message-ID: <20260708-lyrically-footrest-10963a12145f@spud>
References: <20260706112425.3149226-1-jelonek.jonas@gmail.com>
 <20260706112425.3149226-2-jelonek.jonas@gmail.com>
 <20260706-player-handwash-0a3fe95cf5ec@spud>
 <c19e563a-8931-4f31-b05a-ff8def4a5161@gmail.com>
 <20260707-dove-fretful-e3c8e237f1eb@spud>
 <2afc9c9a-eacc-46ca-b965-4cabee8f7094@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s7oTVYavLC/W9h5Y"
Content-Disposition: inline
In-Reply-To: <2afc9c9a-eacc-46ca-b965-4cabee8f7094@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jelonek.jonas@gmail.com,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonekjonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305903-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AB48728F39

--s7oTVYavLC/W9h5Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 10:50:21PM +0200, Jonas Jelonek wrote:
> Hi Conor,
>=20
> On 07.07.26 19:25, Conor Dooley wrote:
> > On Mon, Jul 06, 2026 at 10:30:00PM +0200, Jonas Jelonek wrote:
> >> [...]
> >> The protocol and firmware on the MCU, most likely the whole "solution",
> >> is from Realtek. The setup is always the same on most Realtek-based
> >> switches (saying most because a few counterexamples use completely
> >> different setups, not even Broadcom or Realtek PSE silicon). The host
> >> interface is always the same (except for I2C vs. SMBus vs. UART, which
> >> is likely just a config in the MCU firmware). Therefore "realtek," is =
the
> >> right prefix for all of these.
> >>
> >> Broadcom is not really involved here except for their PSE silicon being
> >> used. Maybe Realtek modeled their MCU host protocol after the one that
> >> Broadcom PSE silicon uses as host interface, but this is rather guessi=
ng.
> >>
> >> Maybe a historical view might help. Older RTL83xx-based switches with
> >> PoE shipped with this setup using Broadcom PSE silicon. From what I kn=
ow,
> >> at this point Realtek didn't design their own PSE silicon. They used t=
he
> >> Broadcom silicon, put a MCU as a manager in front of it with their fir=
mware
> >> and a host protocol based on what Broadcom PSE itself uses. At some
> >> point Realtek started to design their own PSE silicon which then was
> >> used in newer switches instead of Broadcom PSE.
> > Right, in that case it does make sense to use a realtek prefix, since
> > the software and mcu solution is all theirs.
> >
> >> [...]
> >> Only one at a time is used, but not combined in any way. All switches
> >> I've seen so far always have a single management MCU for PoE, not
> >> multiple. Thus, only a single variant is used. Which variant is used
> >> likely depends on the board vendor which then tells Realtek "I want yo=
ur
> >> PoE solution, I can attach it via (I2C/SMBus/UART)". At least for UART=
 vs.
> >> I2C/SMBus there are sometimes valid reasons to use UART over the other.
> >>
> >> There is only a single switch (from Linksys) where the MCU expects raw
> >> I2C messages. SMBus transaction fail actually. But I don't see the rea=
son
> >> why Linksys did it that way. The reason can't be that the MCU is attac=
hed
> >> on a bit-banged I2C because another switch uses SMBus transaction on
> >> a bit-banged I2C.
> > Reading this, it feels like you "should" have compatibles that uniquely
> > identify the protocol used.=20
>=20
> Ok, I hope I put this together correctly. A concrete proposal:
>=20
> "realtek,pse-mcu-gen1"=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Protocol Gen 1, UART)
> "realtek,pse-mcu-gen1-smbus"=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Pr=
otocol Gen 1, SMBus)
> "realtek,pse-mcu-gen2"=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Protocol Gen 2, UART)
> "realtek,pse-mcu-gen2-i2c"=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (Protocol Gen 2, raw I2C)
> "realtek,pse-mcu-gen2-smbus"=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Pr=
otocol Gen 2, SMBus)
>=20
> This uniquely identifies the protocol used: first generation and second
> generation. As Rob mentioned before [1], this also pulls in the raw I2C
> vs. SMBus framing in contrast to having it in a property. The framing
> suffix appears only on I2C attachments because it doesn't apply to
> UART transport, and this is given by the parent serial@ node.
>=20
> Though I'm still open for suggestions regarding the protocol
> identification if "-gen1"/"-gen2" is not acceptable.

This seems reasonable enough.

> > Looking at the devices below, it seems like it
> > would be possible to use compatibles based on the switches themselves, =
e.g.
> > zyxel,xs1930-pse etc. If there are other devices that use the same
> > protocol, they could fall back to the ones below.
> >
> > It'd be good to have the net developers weigh in though, as to whether
> > using compatibles based on the switches is suitable.
>=20
> I'd lean against, but happy to defer to you and the net maintainers. The
> node describes the MCU with its Realtek firmware =E2=80=94 the firmware/p=
rotocol
> defines the device. Everything that differs between instances on the
> controller level would be captured by the compatibles proposed above, so
> a board compatible would encode nothing there the gen+framing string
> doesn't.
>=20
> Observed variation lives on another level. For instance, some boards have
> heterogeneous per-port caps (e.g. 16 ports at 60W, 8 ports at 30W). This
> is clearly something that should be expressed per-pse-pi, not in a
> switch-specific compatible.
>=20
> It would also be an exception to the other PSE-PD bindings. They describe
> controllers used across many switches too, yet none encode the

The difference is those cases (for what few pse-psd bindings there are)
the compatibles correspond to individual devices. Here you have
compatibles you're going to use to cover multiple devices (with device
corresponding to a combination of mcu/firmware/hardware behind the mcu).
That lack of a 1:1 mapping is why I'm asking for something different from
you than you see with the existing pse-pd devices. The switch the device
is integrated on seems to be the only thing that reasonably makes sense
to use.


> switch/enclosure. Board-specific compatibles might still be added later in
> case a device really has a variation or quirk that genuinely needs its own
> compatible.

And in doing so, have to retrofit that compatible to all devicetrees
that use it. This is one of the reasons that we generally demand
device-specific compatibles.

You could add switch-specific compatibles that fall back to the ones you
provide above, with the driver only using the ones above unless
something crops up in the future?

Cheers,
Conor.

--s7oTVYavLC/W9h5Y
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak6BLwAKCRB4tDGHoIJi
0p3oAP9U4yfUL13XX9ITrEINjdXL06ft2DC/2A6DWUPEWttgcQEAjjYHmqp8c3s/
MjMvX2e0llrBewajTkPxcGh/RK73bgs=
=hLWj
-----END PGP SIGNATURE-----

--s7oTVYavLC/W9h5Y--

