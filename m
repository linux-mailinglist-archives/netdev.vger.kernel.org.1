Return-Path: <netdev+bounces-31163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656578C056
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F6E28100A
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC0A14AAB;
	Tue, 29 Aug 2023 08:35:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104A720E8
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 08:35:38 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB14A4;
	Tue, 29 Aug 2023 01:35:36 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 54EB5864CF;
	Tue, 29 Aug 2023 10:35:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693298135;
	bh=Y/3fhgFSBjE0l2cmk2fayHU5jH1mOcjDho9/p+0O1kc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=v1cxA6Y9eC2SeW8VEZ9U/flB7t3+FKM6r3suQp8XoQHtjCFCcsge1hPlfAZJFckAN
	 T/tnOYVtbj1wnxZNt4GloRtkIC80Q1ptU5NuKme8Qn49Edow+YWxM9vK8rQrLkZ1uX
	 bX9P5mkWfFTIfjHBlRYN64l2X/HrliTBbrCpK7VppIfWSz1Oc9/qY/2a0vc1TXsnnV
	 RhyP2HjEnpha4On+3LhQRoX9ZCLb7DoD6i1dCJjUYhX31b64eF7MWVWkwewuo/v8qW
	 ZMeFAvNkVlg2WmjZoOgIhwDKY31OdTEH7Y5OWJCfPv7NMvi28Xq5joRMbOuGHn0W26
	 mcXKQaMLVepNQ==
Date: Tue, 29 Aug 2023 10:35:33 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com
Cc: f.fainelli@gmail.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, Woojung.Huh@microchip.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477
 errata (DS80000754C)
Message-ID: <20230829103533.7966f332@wsk>
In-Reply-To: <20230826104910.voaw3ndvs52yoy2v@skbuf>
References: <20230824154827.166274-1-lukma@denx.de>
	<20230824154827.166274-2-lukma@denx.de>
	<BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
	<20230825103911.682b3d70@wsk>
	<862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
	<BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
	<20230826104910.voaw3ndvs52yoy2v@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wy0d42mqFkkroqkdmLa_Us7";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/wy0d42mqFkkroqkdmLa_Us7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Fri, Aug 25, 2023 at 06:48:41PM +0000, Tristram.Ha@microchip.com
> wrote:
> > > > IMHO adding functions to MMD modification would facilitate
> > > > further development (for example LED setup). =20
> > >=20
> > > We already have some KSZ9477 specific initialization done in the
> > > Micrel PHY driver under drivers/net/phy/micrel.c, can we converge
> > > on the PHY driver which has a reasonable amount of infrastructure
> > > for dealing with workarounds, indirect or direct MMD accesses
> > > etc.? =20
> >=20
> > Actually the internal PHY used in the KSZ9897/KSZ9477/KSZ9893
> > switches are special and only used inside those switches.  Putting
> > all the switch related code in Micrel PHY driver does not really
> > help.  When the switch is reset all those PHY registers need to be
> > set again, but the PHY driver only executes those code during PHY
> > initialization.  I do not know if there is a good way to tell the
> > PHY to re-initialize again. =20
>=20
> Suppose there was a method to tell the PHY driver to re-initialize
> itself. What would be the key points in which the DSA switch driver
> would need to trigger that method? Where is the switch reset at
> runtime?

Tristam has explained why adding the internal switch PHY errata to
generic PHY code is not optimal.

If adding MMD generic code is a problem - then I'm fine with just
clearing proper bits with just two indirect writes in the
drivers/net/dsa/microchip/ksz9477.c

I would also prefer to keep the separate ksz9477_errata() function, so
we could add other errata code there.

Just informative - without this patch the KSZ9477-EVB board's network
is useless when the other peer has EEE enabled by default (like almost
all non managed ETH switches).



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/wy0d42mqFkkroqkdmLa_Us7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTtrdUACgkQAR8vZIA0
zr3zHQgAjPpreQVnthLyCK3OHJt7/Wv4eskZUdPniDs2WWDZWTcYeI3lHrwcRJO6
t2nuttwgBsKf9PBdAuEgI5UBHCFfD3ViE2XggDMHUjSdMwkvpT6dVshp8NRDsIKA
3R999zT3T1caWou+GEJ2kKQ1lWVUmybOJyHHqiZV0bT7ghF5JwDYg0PLmIdBiUfp
kYALohsjYisn5mJ/VU9/zHvP9jzH/m+CJit7mD62RmKvQ79Vof9pxZrEfvMylS6r
9xNdI8xFewbSwsKwzrc0BmVr78nLRmoAoBz6IeixInI8xl9Dtki7N6Jt8U0mh1ds
7QuZdyuY98C8aakO53JhHgK9pcF96A==
=Pi6u
-----END PGP SIGNATURE-----

--Sig_/wy0d42mqFkkroqkdmLa_Us7--

