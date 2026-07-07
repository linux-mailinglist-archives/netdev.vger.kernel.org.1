Return-Path: <netdev+bounces-305542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SwwODbM2TWq9wgEAu9opvQ
	(envelope-from <netdev+bounces-305542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:26:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E88271E43A
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:26:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jYz5AarE;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305542-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305542-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E63A3032059
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227CB43787F;
	Tue,  7 Jul 2026 17:25:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D8A420894;
	Tue,  7 Jul 2026 17:25:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783445140; cv=none; b=sAo0Q+4NoGNxbCvlRieAQuaSnyHfHgqW0KXk1kG9CBwq2OxPxEJjJhxVuFoOwbRbf37qmaw1T5bDS1g9t3okv822bcdQjxXQ95jHiYS6R8IjRLlpAr+6/bu8vI+WmBzAyUc7AjUvtVH9fUqx9yLEpLhzipPEL0Xj0tq2b49XK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783445140; c=relaxed/simple;
	bh=0PKpIuD6vJRnaIdJCs6/SQ6P8y3SKn1CSp6XZpfNvy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaEHnelK+Kkb4/OwmZctSV9unNemkdlq913zJcNei+NIGy3Gja+YmFRVhMZp4TVGlAVirqilPIB2bH87tJg2x5S5rPRyfY0igtGofKPKoDRq8q9IcC4e6ygcJ0/gk00nb1IihB6KVnpQZasI4qzs4ESesQutRGb5kH4TquKwdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYz5AarE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3F71F000E9;
	Tue,  7 Jul 2026 17:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783445138;
	bh=Ko3Nb+RXU6MJsuNe7+a2cyRCM4yevBM5da/8sKBylt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jYz5AarEMkYUGOBOBx7UzPMH6gxRFO+XzAnkL9cdLxEKdkEBB/ozviMFDPMODm5dQ
	 HpT6JPq/CBzbi+h4zAEm0mOcLIUh9R92jV5dtk0pGPqs9sq45qWs/M0kBVf2J2mxR1
	 wSmOWa2JLdkqNh6myBUhoQn6VeboacAhzKBM9s04pjl4SrzGucK4xWrZq5R/8iyx/U
	 CP7ym07YylB2TbWYKBKdnNyECbLOxsc43/8dx/5YZRp7Pci0L09/gMd2x7IreRn+BH
	 55W9Ay5/GRBsEKSQXf9kfOp0BKroSAo+9Zo/ul7vmG+/dSAxH5yup/BpPQapnxlYTw
	 NcRfH6JL+A+6w==
Date: Tue, 7 Jul 2026 18:25:33 +0100
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
Message-ID: <20260707-dove-fretful-e3c8e237f1eb@spud>
References: <20260706112425.3149226-1-jelonek.jonas@gmail.com>
 <20260706112425.3149226-2-jelonek.jonas@gmail.com>
 <20260706-player-handwash-0a3fe95cf5ec@spud>
 <c19e563a-8931-4f31-b05a-ff8def4a5161@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MCgORjQXzeYcS81z"
Content-Disposition: inline
In-Reply-To: <c19e563a-8931-4f31-b05a-ff8def4a5161@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-305542-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[svanheule.net:url,vger.kernel.org:from_smtp,spud:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E88271E43A

--MCgORjQXzeYcS81z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 10:30:00PM +0200, Jonas Jelonek wrote:
> Hi Conor,
>=20
> On 06.07.26 19:35, Conor Dooley wrote:
> > On Mon, Jul 06, 2026 at 11:24:21AM +0000, Jonas Jelonek wrote:
> >> [...]
> >> +
> >> +description: |
> >> +  Microcontroller (MCU) that fronts the PSE hardware on switches using
> >> +  Realtek (RTL8238B, RTL8239, RTL8239C) or Broadcom (BCM59111, BCM591=
21)
> >> +  PSE chips. The MCU exposes a small message-based protocol over eith=
er
> >> +  I2C/SMBus or UART; the actual PSE silicon is not accessed directly.=
 The
> >> +  Realtek and Broadcom variants share this device tree contract but u=
se
> >> +  different protocol opcodes, selected by the compatible.
> >> +
> >> +  The compatible identifies the PSE-MCU protocol dialect, not a speci=
fic
> >> +  part. The device here is the MCU: it presents a stable message prot=
ocol
> >> +  documented by Realtek, with the PSE silicon behind it - Broadcom on
> >> +  older boards, Realtek on newer - detected at runtime and not descri=
bed
> >> +  here. The MCU's own silicon is general-purpose and varies across
> >> +  boards, so the 'realtek' vendor prefix names the protocol front-end
> >> +  (following the google,cros-ec pattern); the '-rtk'/'-brcm' suffix
> >> +  selects the Realtek or Broadcom dialect.
> >> +
> >> +  A single compatible per dialect covers both the I2C/SMBus and UART
> >> +  attachments: the wire protocol is identical across them and the
> >> +  transport is already expressed by the node's parent bus, so it is n=
ot
> >> +  encoded in the compatible. Transport-specific properties differ
> >> +  accordingly - the I2C attachment carries 'reg' (and, for Realtek,
> >> +  'realtek,i2c-protocol'), while the UART attachment carries the seri=
al
> >> +  peripheral properties such as 'current-speed'.
> > I'm not really convinced by the arguments here.
> >
> > If the switch vendors are running different software on their MCUs to
> > the point that they behave differently, then yes it makes sense to have
> > different compatibles.
> >
> > The first thing I don't understand is why realtek is considered the
> > main vendor here? Is it their MCU that broadcom are re-using with some
> > protocol tweaks?
>=20
> The protocol and firmware on the MCU, most likely the whole "solution",
> is from Realtek. The setup is always the same on most Realtek-based
> switches (saying most because a few counterexamples use completely
> different setups, not even Broadcom or Realtek PSE silicon). The host
> interface is always the same (except for I2C vs. SMBus vs. UART, which
> is likely just a config in the MCU firmware). Therefore "realtek," is the
> right prefix for all of these.
>=20
> Broadcom is not really involved here except for their PSE silicon being
> used. Maybe Realtek modeled their MCU host protocol after the one that
> Broadcom PSE silicon uses as host interface, but this is rather guessing.
>=20
> Maybe a historical view might help. Older RTL83xx-based switches with
> PoE shipped with this setup using Broadcom PSE silicon. From what I know,
> at this point Realtek didn't design their own PSE silicon. They used the
> Broadcom silicon, put a MCU as a manager in front of it with their firmwa=
re
> and a host protocol based on what Broadcom PSE itself uses. At some
> point Realtek started to design their own PSE silicon which then was
> used in newer switches instead of Broadcom PSE.

Right, in that case it does make sense to use a realtek prefix, since
the software and mcu solution is all theirs.

> > If it is, then having the vendor as a suffix like wheel reinvention to
> > me, and if the MCU and/or protocol aren't something that broadcom
> > borrowed from realtek then having a realtek vendor prefix is strange
> > altogether. The mention of old boards being broadcom while the protocol
> > is documented by realtek is confusing me.
> >
> > Either way, encoding the vendor without using the vendor prefix seems
> > very odd me to.
>=20
> I'm open for suggestions here. This has been the hardest issue in this
> whole series, to be honest. It basically boils down to differentiating
> these two protocol generations. I cannot say why Realtek did that on
> the transition to their own PSE silicon but vendors doing weird stuff
> shouldn't be surprising and this is the reality now.
>=20
> Is something like "-gen1" and "-gen2" better, with a clear description
> somewhere in the bindings how that maps to actual device setups
> (gen1 =3D older/MCU fronts Broadcom PSE, gen2 =3D newer/MCU fronts
> Realtek PSE)? This would drop Broadcom and the confusion around it
> here. I admit, using a vendor suffix isn't great and still attributes
> Broadcom too much in this context here.
>=20
> > Secondly, the compatibles you do provide seem too generic. Is it really
> > possible for a given board to use smbus AND i2c, or do specific boards
> > only ever use i2c OR smbus (or uart for that matter).
> > I find it more believable that a board would support i2c and uart than
> > supporting both i2c and smbus fwiw.
>=20
> Only one at a time is used, but not combined in any way. All switches
> I've seen so far always have a single management MCU for PoE, not
> multiple. Thus, only a single variant is used. Which variant is used
> likely depends on the board vendor which then tells Realtek "I want your
> PoE solution, I can attach it via (I2C/SMBus/UART)". At least for UART vs.
> I2C/SMBus there are sometimes valid reasons to use UART over the other.
>=20
> There is only a single switch (from Linksys) where the MCU expects raw
> I2C messages. SMBus transaction fail actually. But I don't see the reason
> why Linksys did it that way. The reason can't be that the MCU is attached
> on a bit-banged I2C because another switch uses SMBus transaction on
> a bit-banged I2C.

Reading this, it feels like you "should" have compatibles that uniquely
identify the protocol used. Looking at the devices below, it seems like it
would be possible to use compatibles based on the switches themselves, e.g.
zyxel,xs1930-pse etc. If there are other devices that use the same
protocol, they could fall back to the ones below.

It'd be good to have the net developers weigh in though, as to whether
using compatibles based on the switches is suitable.

> > Can you provide a link to the actual devices somewhere? It is
> > completely non-obvious to me what the binding actually represents.
>=20
> I hope I get your request correctly. Find some links to devices and/or

Ye, this is what I was looking for, thanks.

Conor.

> to my commits wiring that up in actual DTS (WIP, hashes may change).
>=20
> Zyxel XMG1915-10EP (UART with Realtek PSE silicon):
> https://svanheule.net/switches/xmg1915-10ep
> https://github.com/jonasjelonek/openwrt/commit/d173e64730a511e04b68271289=
be23ae4e98a02f
>=20
> Zyxel XS1930-12HP (SMBus with Realtek PSE silicon):
> https://www.zyxel.com/de/de/products/switch/10-12-port-10g-multi-gigabit-=
lite-l3-smart-managed-switch-xs1930-series
> https://github.com/jonasjelonek/openwrt/commit/74339c9a002032fc204b6b1fe0=
7af259d8f51787
>=20
> Zyxel GS1900-10HPv1 (UART with Broadcom PSE silicon):
> https://svanheule.net/switches/gs1900-10hp
>=20
> Linksys LGS328MPC (I2C raw, not SMBus, with Realtek PSE silicon):
> https://support.linksys.com/kb/article/5133-en/
>=20
> (mostly Zyxel devices but that's just the main devices I work with)
>=20
> > Cheers,
> > Conor.
> >
> >
> >> [...]
> >>
>=20
> Best regards,
> Jonas

--MCgORjQXzeYcS81z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak02jQAKCRB4tDGHoIJi
0gNkAQD7nXGhei3VQapDuFS7uX4XCDJxEfKs8Y2aKk+U7Yh2EQEA9Pu1cznFpLhj
LlIFaoMY7YVW7EUNzw7dIQ+BSFwuWQE=
=iU0d
-----END PGP SIGNATURE-----

--MCgORjQXzeYcS81z--

