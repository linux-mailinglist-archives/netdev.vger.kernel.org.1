Return-Path: <netdev+bounces-33808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B607A03C7
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84EBCB20B36
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 12:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDEB219F8;
	Thu, 14 Sep 2023 12:27:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E99C208BD
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 12:27:00 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F751FC9;
	Thu, 14 Sep 2023 05:26:59 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9EE0686940;
	Thu, 14 Sep 2023 14:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1694694417;
	bh=9yMBj5KY/e+XMXKyNzGlyIzV435Q72xExT8MkWMqc6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mhkqX4DNrLGXMgAWLTrfp/QH9eJFVG0Y8RuLR7+Q74YyZezl2JH2FKBm4lv1a7Lek
	 jvTMBAgnS/QmNwm4l2VW/0xSNbpaYNIlhr0K1ym+EwH/Vc1ZVRXQvDG1MWzTBt6ZDb
	 MStMX5wU26MCIicLM+s2Tq+0HfEoO6Pcsdv05PO52+PsUk3vyrrYIHWnnJ/lf9vH/s
	 Olk39+7BC370jKu3tM7REnkWJiRma1bXHUDTZSK69w4qmnt5pmTLxf8uv7181g+nOw
	 PRPrQp1Fa1XdjElvO20l77QqpaBjXoLEuir4W38xnPuFlpAxAdZtk43GHF8fgfQYJC
	 uguVev92HIzPA==
Date: Thu, 14 Sep 2023 14:26:50 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
 davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Kristian Overskeid <koverskeid@gmail.com>, Matthieu
 Baerts <matthieu.baerts@tessares.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andreas Oetken <ennoerlangen@gmail.com>
Subject: Re: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames
 decoding
Message-ID: <20230914142650.6ea1a52f@wsk>
In-Reply-To: <20230913163227.ysmJocR0@linutronix.de>
References: <20230825153111.228768-1-lukma@denx.de>
	<20230905080614.ImjTS6iw@linutronix.de>
	<20230905115512.3ac6649c@wsk>
	<20230911165708.0bc32e3c@wsk>
	<20230911150144.cG1ZHTCC@linutronix.de>
	<20230912101828.06cb403d@wsk>
	<20230913163227.ysmJocR0@linutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UkUwe2guQLDYQdd3_.qhV1S";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/UkUwe2guQLDYQdd3_.qhV1S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sebastian Andrzej,

> On 2023-09-12 10:18:28 [+0200], Lukasz Majewski wrote:
> > Hi Sebastian, =20
> Hi Lukasz,
>=20
> > Ok. No problem. Thanks for the information. =20
>=20
> So what happens if you try this:
>=20
> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> index b77f1189d19d1..6d14d935ee828 100644
> --- a/net/hsr/hsr_framereg.c
> +++ b/net/hsr/hsr_framereg.c
> @@ -288,13 +288,13 @@ void hsr_handle_sup_frame(struct hsr_frame_info
> *frame)=20
>  	/* And leave the HSR tag. */
>  	if (ethhdr->h_proto =3D=3D htons(ETH_P_HSR)) {
> -		pull_size =3D sizeof(struct ethhdr);
> +		pull_size =3D sizeof(struct hsr_tag);
>  		skb_pull(skb, pull_size);
>  		total_pull_size +=3D pull_size;
>  	}
> =20
>  	/* And leave the HSR sup tag. */
> -	pull_size =3D sizeof(struct hsr_tag);
> +	pull_size =3D sizeof(struct hsr_sup_tag);
>  	skb_pull(skb, pull_size);
>  	total_pull_size +=3D pull_size;
> =20
>=20
> Sebastian

Yes, this fixes this issue (caused by: SHA1: eafaa88b3eb7f).
Such solution has also been pointed out earlier by Tristram.

I will prepare v2 of this patch.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/UkUwe2guQLDYQdd3_.qhV1S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUC/AoACgkQAR8vZIA0
zr2QaQgA2lvqLjFeE2J9upAK/wAy3K5y9XdsDU00g/c+orFYDISTsCS+0WCk3hq5
JhYFya+FRU2sBzxVtP2R1MhIfbjnr/Efbpu//jpzoGz1iyic8u9DisgH4h1yLTv8
0zMqTlJ4se+peBTDvgI9eg3YiQdOOi8HAKbMCd8Vxlouf3NWh4v50hgji0eXaZGA
uiwPIJzR7qdYsYlAdslEPqyukY/V51OFpNzVOvW+5StM0Y73v+/NALsPPUyJ2MgW
yRMXauS8Pc2Uab7Bgz2c91pjvcfovV9iXPjWedQK6ZFxO4lhZ1FvFNg3voy1Whtm
IatbaoNbwzpA2ywmy1BTX8JJWnXRYQ==
=LUEH
-----END PGP SIGNATURE-----

--Sig_/UkUwe2guQLDYQdd3_.qhV1S--

