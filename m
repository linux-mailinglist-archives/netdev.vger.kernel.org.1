Return-Path: <netdev+bounces-62671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5235E8287B1
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 15:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8811F24716
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E51B39AC8;
	Tue,  9 Jan 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="b2dNUIwq"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F239863
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 78EB2876D3;
	Tue,  9 Jan 2024 15:04:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704809061;
	bh=65vmodEbxT37RXPRPcn/ziOGhr5691GdQHIVu11Ip5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b2dNUIwqkLprQJT5Tm+xo9b8L+jl9TY8Hs6bBYlJtFHibbTBB1hTYB0+SEHFR/nVj
	 j3mV+4P1V7R9tDq91Mi+ix/2TEbNvZxq4OD2EbVv+yCEkiqt5FG7Ojw2PIxzbFBrcv
	 nf0XM3zxY4WaFwloVH2x1BtApLH4qsXC3Cjpie8r5v4ZDCU2DP0GovsdixwT2bW7mE
	 vSqiEHcsxRzaafXjBMFM1YlGYP4Rd7BbRNB2x4my8hc/u8MqjLh7b3+KFXSJv6nNMg
	 3+ouh0g1dAH2Rn7JExFygX7tl6CD+2AmKm7qX0peA4n4LU91Wgs1tQDuyvEfr8tni7
	 3NEt1xFgwFK2Q==
Date: Tue, 9 Jan 2024 15:04:14 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Tristram.Ha@microchip.com, Oleksij Rempel
 <o.rempel@pengutronix.de>, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 George McCollister <george.mccollister@gmail.com>
Subject: Re: [net][hsr] Question regarding HSR RedBox functionality
 implementation (preferably on KSZ9477)
Message-ID: <20240109150414.6a402fec@wsk>
In-Reply-To: <20240109125205.u6yc3z4neter24ae@skbuf>
References: <20230928124127.379115e6@wsk>
	<20231003095832.4bec4c72@wsk>
	<20231003104410.dhngn3vvdfdcurga@skbuf>
	<20230922133108.2090612-1-lukma@denx.de>
	<20230926225401.bganxwmtrgkiz2di@skbuf>
	<20230928124127.379115e6@wsk>
	<20231003095832.4bec4c72@wsk>
	<20231003104410.dhngn3vvdfdcurga@skbuf>
	<20240109133234.74c47dcd@wsk>
	<20240109133234.74c47dcd@wsk>
	<20240109125205.u6yc3z4neter24ae@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CX7kIaysj4g35Cj_n0+SIAH";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/CX7kIaysj4g35Cj_n0+SIAH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> Hi Lukasz,
>=20
> On Tue, Jan 09, 2024 at 01:32:34PM +0100, Lukasz Majewski wrote:
> > However, I'm wondering how the mainline Linux kernel could handle
> > HSR RedBox functionality (on document [1], Figure 2. we do have
> > "bridge" - OSI L2).
> >=20
> > To be more interesting - br0 can be created between hsr0 and e.g.
> > lan3. But as expected communication breaks on both directions (to
> > SAN and to HSR ring). =20
>=20
> Yes, I suppose this is how a RedBox should be modeled. In principle
> it's identical to how bridging with LAG ports (bond, team) works -
> either in software or offloaded.=20
> The trouble is that the HSR driver
> seems to only work with the DANH/DANP roles (as also mentioned in
> Documentation/networking/dsa/dsa.rst). I don't remember what doesn't
> work (or if I ever knew at all).

In the newest net-next only PRP_TLV_REDBOX_MAC is defined, which seems
to be REDBOX for DAN P (PRP).

> It might be the address substitution
> from hsr_xmit() that masks the MAC address of the SAN side device?
>=20

This needs to be further investigated.

> > Is there a similar functionality already present in the Linux kernel
> > (so this approach could be reused)?
> >=20
> > My (very rough idea) would be to extend KSZ9477 bridge join
> > functions to check if HSR capable interface is "bridged" and then
> > handle frames in a special way.
> >=20
> > However, I would like to first ask for as much input as possible -
> > to avoid any unnecessary work. =20
>=20
> First I'd figure out why the software data path isn't working, and if
> it can be fixed.=20

+1

> Then, fix that if possible, and add a new selftest to
> tools/testing/selftests/net/forwarding/, that should pass using veth
> interfaces as lower ports.
>=20
> Then, offloading something that has a clear model in software should
> be relatively easy, though you might need to add some logic to DSA.
> This is one place that needs to be edited, there may be others.
>=20
> 	/* dsa_port_pre_hsr_leave is not yet necessary since hsr
> devices cannot
> 	 * meaningfully placed under a bridge yet
> 	 */
>=20

Ok, the LAG approach in /net/dsa/user.c can be used as an example.

Thanks for shedding some light on this issue :-)

> >=20
> > Thanks in advance for help :-)
> >=20
> > Link:
> >=20
> > [1] -
> > https://ww1.microchip.com/downloads/en/Appnotes/AN3474-KSZ9477-High-Ava=
ilability-Seamless-Redundancy-Application-Note-00003474A.pdf
> >=20
> >=20
> > Best regards,
> >=20
> > Lukasz Majewski =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/CX7kIaysj4g35Cj_n0+SIAH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmWdUl4ACgkQAR8vZIA0
zr0Y6AgAqGeco9AMJ7JZdOAI/J9gNSVQ4TYYRZ/Rl6sospR8XcrHwaLfSqsLMxUh
mMiES3RWR9UIGb4bTmE9y6kDmdYpZcCogwx50VFcgpwyQQFwo7gLxGTUkRfu3DmP
taOhG+40I2hPDbYzspw1VqS+gjLG2PNnsKWM+DIFjLiGWMfQ5DBOHM4Yfq1GQJpA
HJIV6qu9tNg3VjYv88HbUc6y5GSWnEfXBr0CmI5LvpSY1oJxjCkweG4sgZd6fWrp
MueJsgS5Qzel7TYYVe+9vX+Rc300JdDKsZ5BX7vSxe5ewb4Yd5VpEozF6ktJYDZN
PWiKSGAH4vj9U0nJxKPKbTbSczxdng==
=F7nT
-----END PGP SIGNATURE-----

--Sig_/CX7kIaysj4g35Cj_n0+SIAH--

