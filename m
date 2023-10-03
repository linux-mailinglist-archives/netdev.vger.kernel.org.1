Return-Path: <netdev+bounces-37708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEA17B6B29
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D8C2A1C20777
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D872E654;
	Tue,  3 Oct 2023 14:15:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8662AB3A
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 14:15:44 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142DAB0;
	Tue,  3 Oct 2023 07:15:42 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3C32C86E23;
	Tue,  3 Oct 2023 16:15:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696342539;
	bh=b8vXyCH/t0Phi+cqyih6SrFxJCTaRsrcH2AD1rrCm7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vZ9My/W94LqMNkO+WaZWdB4GY63LLQLOGrjQLc+0IKDWRdkl5TlcmiwBKyU4wxF1K
	 TeuUlAGVOOMeSJ4+d+jKDC+VZIgZ4b2pNKVKrVEbCGn9BJGCTeR0KXRhn8Tr2qIVgl
	 Zc4g2twcWwf9CqlhOE+X0h4QWOCJ4dLmBW5dVgSzGUOAALar12ijcJACPR8PVFGkR2
	 nymZcXR80mu3auZj7IbEJtkGnZKLKwFK0fi1lyFC1+8t6bm9KK1wXpZkQ3jAey7CiT
	 PPcrxiVVCvgGP3VBny64hdfbrtIrVNDo55g3gR4nZGh0hpskVKfsYeyqCXSj9aVFks
	 RUh/VEZuGWXGg==
Date: Tue, 3 Oct 2023 16:15:30 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Woojung Huh <woojung.huh@microchip.com>, Tristram.Ha@microchip.com, Eric
 Dumazet <edumazet@google.com>, davem@davemloft.net, Oleksij Rempel
 <o.rempel@pengutronix.de>, Florian Fainelli <f.fainelli@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 0/5] net: dsa: hsr: Enable HSR HW offloading
 for KSZ9477
Message-ID: <20231003161530.462dcc48@wsk>
In-Reply-To: <20231003064213.4886626f@kernel.org>
References: <20230922133108.2090612-1-lukma@denx.de>
	<20230926225401.bganxwmtrgkiz2di@skbuf>
	<20230928124127.379115e6@wsk>
	<20231003095832.4bec4c72@wsk>
	<20231003104410.dhngn3vvdfdcurga@skbuf>
	<20231003145106.3cd5a19f@wsk>
	<20231003064213.4886626f@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IeG0tTzUv6tXyyNoPLD0IVo";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/IeG0tTzUv6tXyyNoPLD0IVo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Oct 2023 06:42:13 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 3 Oct 2023 14:51:06 +0200 Lukasz Majewski wrote:
> > I've just noticed that there is a WARNING:
> > https://patchwork.kernel.org/project/netdevbpf/patch/20230922133108.209=
0612-6-lukma@denx.de/
> >=20
> > but then on the newest kernel checkpatch.pl is silent:
> > ./scripts/checkpatch.pl
> > 0005-net-dsa-microchip-Enable-HSR-offloading-for-KSZ9477.patch
> > total: 0 errors, 0 warnings, 0 checks, 277 lines checked
> >=20
> > 0005-net-dsa-microchip-Enable-HSR-offloading-for-KSZ9477.patch has
> > no obvious style problems and is ready for submission.
> >=20
> > Does the checkpatch for patchwork differs in any way from mainline?
> > =20
>=20
> We run:
>=20
> checkpatch with --strict --max-line-length=3D80
>=20
> https://github.com/kuba-moo/nipa/blob/master/tests/patch/checkpatch/check=
patch.sh
>=20
> The "multiple new lines" warning on patch 2 looks legit, no?

Indeed - the:

'--strict --max-line-length=3D80'

makes the difference...

If I may ask - why it is added? Or to ask in other way - why the
"vanila" checkpatch is not enough for net-dev ?


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/IeG0tTzUv6tXyyNoPLD0IVo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUcIgIACgkQAR8vZIA0
zr1GBQf+PWCSC3QPDpwiT/dpPM+kFxaZl8GAWNdgvEejq+wdA93HBZEqbo31Wvc8
rFrUWCmBnC4WcReobj+knb+4kNAPxfMMwGkRq71skHnma2dDIwJuWVDLQt2LOpKd
BL967/ail9sVJDKqB3bbrWiXn4UWgnn/vYdJKTE4D1zQlVnQS6+1S6cZrEMuGE+q
FRab5bN4/SSGEIOGcrgo7jD6XcV75sGRi1ZaQw/kDF7/Ioc4hhxxDxo3aLQV7t3Q
6Wu2FjiUjzlM2wqhx73bbyMjBUoq3CQ6szDTZHMiUzJ/weUOpdRgZkawy46xX/9n
B7cRSahymM/X3jK80qwZOI+fbpncnQ==
=UMin
-----END PGP SIGNATURE-----

--Sig_/IeG0tTzUv6tXyyNoPLD0IVo--

