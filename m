Return-Path: <netdev+bounces-37592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A157B62FE
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 09:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4DB7D1C20847
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 07:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E35D511;
	Tue,  3 Oct 2023 07:58:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182566AB4
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 07:58:43 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0CBA1;
	Tue,  3 Oct 2023 00:58:42 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id ED0D6871DB;
	Tue,  3 Oct 2023 09:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696319919;
	bh=PZREtQJWDxL5bttOJQAbnHZ654a8M4MmoIbQ/xDy3Iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TE3s7z5FRKu4FUbxpsm1s8vb6rKxK9y8vfwGQPgX/uA+cVT/6Xt113kO/vpEIEjVE
	 2vPph5YAbc46WaoYKMq31URqQxITQn/LHmRJEFSJRpQb9sKzC+EeXCE6lTNPoEBd+5
	 flfOyJMf2tL2YzlgoKQXnfPKkl2ddk1PGyPrHQrtB//7j5z9/loTfQNalM2gOd3x7y
	 MV5gJ03hymWbBe71fYvDbJHQMtRU0lRIrHV+6FjM1evy+dWRs+hg/IxbUeGPZmfa8A
	 gQsOzsx7JWSn3lNXsRKfOssA5WcrnwytspBo0meiXsSG9uJdQPY9Z4/ynljmUr0LCE
	 evV9nbXCYf+Hg==
Date: Tue, 3 Oct 2023 09:58:32 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Woojung Huh <woojung.huh@microchip.com>
Cc: Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
 davem@davemloft.net, Oleksij Rempel <o.rempel@pengutronix.de>, Florian
 Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 0/5] net: dsa: hsr: Enable HSR HW offloading
 for KSZ9477
Message-ID: <20231003095832.4bec4c72@wsk>
In-Reply-To: <20230928124127.379115e6@wsk>
References: <20230922133108.2090612-1-lukma@denx.de>
	<20230926225401.bganxwmtrgkiz2di@skbuf>
	<20230928124127.379115e6@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tWJgJkDKh999.Df3ro_hA.w";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/tWJgJkDKh999.Df3ro_hA.w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir, Andrew, Woojung,

> Hi Vladimir,
>=20
> > On Fri, Sep 22, 2023 at 03:31:03PM +0200, Lukasz Majewski wrote: =20
> > > This patch series provides support for HSR HW offloading in
> > > KSZ9477 switch IC.
> > >=20
> > > To test this feature:
> > > ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision
> > > 45 version 1 ip link set dev lan1 up
> > > ip link set dev lan2 up
> > > ip a add 192.168.0.1/24 dev hsr0
> > > ip link set dev hsr0 up
> > >=20
> > > To remove HSR network device:
> > > ip link del hsr0
> > >=20
> > > To test if one can adjust MAC address:
> > > ip link set lan2 address 00:01:02:AA:BB:CC
> > >=20
> > > It is also possible to create another HSR interface, but it will
> > > only support HSR is software - e.g.
> > > ip link add name hsr1 type hsr slave1 lan3 slave2 lan4 supervision
> > > 45 version 1
> > >=20
> > > Test HW:
> > > Two KSZ9477-EVB boards with HSR ports set to "Port1" and "Port2".
> > >=20
> > > Performance SW used:
> > > nuttcp -S --nofork
> > > nuttcp -vv -T 60 -r 192.168.0.2
> > > nuttcp -vv -T 60 -t 192.168.0.2
> > >=20
> > > Code: v6.6.0-rc2+ Linux net-next repository
> > > SHA1: 5a1b322cb0b7d0d33a2d13462294dc0f46911172
> > >=20
> > > Tested HSR v0 and v1
> > > Results:
> > > With KSZ9477 offloading support added: RX: 100 Mbps TX: 98 Mbps
> > > With no offloading 		       RX: 63 Mbps  TX: 63
> > > Mbps   =20
> >=20
> > Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> >=20
> > Thanks! =20
>=20
> I hope, that it will find its way to net-next soon :-).
>=20

I'm a bit puzzled with this patch series - will it be pulled directly
to net-next [1] or is there any other (KSZ maintainer's?) tree to which
it will be first pulled and then PR will be send to net-next?

Thanks in advance for the clarification.

> Thanks for your help and patience.
>=20

Links:

[1] -
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/log/

>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> lukma@denx.de

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/tWJgJkDKh999.Df3ro_hA.w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUbyagACgkQAR8vZIA0
zr3ZkAgAoj7z6JUowZLbgaiPp3oIGHbaN5ds9j3iAGlC40XKhf5Yr5C4dZGMY0FU
+M2kZMiEae7rvawT6zZNukX1MNA7pFHUqi659ljTDXQQAEqALI/gY7xhga+22DHQ
SdZ9ZsjhugCYjetCNEW0GTfemkE3ETXk8bl0zmf6mM3+z18IKuAgsTAzyOyIEjIx
czeG7kLQ5QcmleSZmHsxuUIMnVx24ede+kGPPmNqoyRODR3PejzMBYDsDc9ctkKY
GT2ILpd2CL75gs4YD8sNpcH+yNiQwfG45aiISn+bjVVpjgrjHyaqeUhhQIXg8bw/
vsJty81gHhL98oly76Ms1X6Jj9YGTA==
=W6Hy
-----END PGP SIGNATURE-----

--Sig_/tWJgJkDKh999.Df3ro_hA.w--

