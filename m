Return-Path: <netdev+bounces-31916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4839679164A
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 13:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B581C20481
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 11:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164603D8B;
	Mon,  4 Sep 2023 11:40:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6B01FAC
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 11:40:04 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681F2A2;
	Mon,  4 Sep 2023 04:40:03 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id F2B40864F9;
	Mon,  4 Sep 2023 13:40:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693827601;
	bh=LVLC6vNAP9AFsMMQ5pVYjwCKTc10aCA9ewaLSRYW9KI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WYdLlyR1mhWy30L5BsH0npIBTW1NEV1CDg1/UTOaoxIpY30nr1XbM8Df9lABrv2Zr
	 wZUuZhe0AsBpmHJzq1ihr02ribD5cEtA6Q3shbCFxsV/QfAfFMBN0GBN/RHOipZy+B
	 27qxp4SVyd2Shv6SzBPXEdqpWyCf5PJ5DNx7j6ZOjQ6yijBvUm7PBwHwQBUxJPxb8Z
	 QEu3wT+BcqsHbhGym1J1saz9Y14eBleKT7l0ZVjI7Jy3Ex6vFFbKOzCrl7n4FChQw2
	 MsCkl+dNG3ufFNo7kTONpWCD8uGcfe2zwO7gpIiRSr7ZeiQayxAgMInHqrPuH/akr1
	 Uy+9UlMx9deEw==
Date: Mon, 4 Sep 2023 13:39:53 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net, Paolo Abeni
 <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>, Vladimir
 Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com, Florian Fainelli
 <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 UNGLinuxDriver@microchip.com, George McCollister
 <george.mccollister@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] net: dsa: hsr: Enable in KSZ9477 switch HW HSR
 offloading
Message-ID: <20230904133953.180f9b6b@wsk>
In-Reply-To: <35a99c33-7a22-4a49-84ef-6e73b9e6cabd@lunn.ch>
References: <20230831111827.548118-1-lukma@denx.de>
	<20230831111827.548118-4-lukma@denx.de>
	<35a99c33-7a22-4a49-84ef-6e73b9e6cabd@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GjCqFc1UL8o0jIV+veTKRgU";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/GjCqFc1UL8o0jIV+veTKRgU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > +int ksz9477_hsr_join(struct dsa_switch *ds, int port, struct
> > net_device *hsr,
> > +		     struct dsa_port *partner)
> > +{
> > +	struct ksz_device *dev =3D ds->priv;
> > +	struct net_device *slave;
> > +	u8 i, data;
> > +	int ret;
> > +
> > +	/* Program which ports shall support HSR */
> > +	dev->hsr_ports =3D BIT(port) | BIT(partner->index);
> > +	ksz_write32(dev, REG_HSR_PORT_MAP__4, dev->hsr_ports);
> > +
> > +	/* Enable discarding of received HSR frames */
> > +	ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);
> > +	data |=3D HSR_DUPLICATE_DISCARD;
> > +	data &=3D ~HSR_NODE_UNICAST;
> > +	ksz_write8(dev, REG_HSR_ALU_CTRL_0__1, data);
> > +
> > +	/* Self MAC address filtering for HSR frames to avoid
> > +	 * traverse of the HSR ring more than once.
> > +	 *
> > +	 * The HSR port (i.e. hsr0) MAC address is used.
> > +	 */
> > +	if (!is_valid_ether_addr(hsr->dev_addr)) {
> > +		dev_err(dev->dev,
> > +			"Set valid MAC address to %s for HSR
> > operation!",
> > +			hsr->name);
> > +		return -EINVAL;
> > +	} =20
>=20
> This seems like something which should be done at a higher level, not
> per driver. Please check if there is an existing test, and if not, add
> one in the HSR core.

Yes, your are right. This is caught earlier in the net stack code.

Especially, I was afraid, that one can use:
local-mac-address =3D [00 00 00 00 00 00]

but in this case is caught as well.

I will remove this check. Thanks for pointing this out.

>=20
>     Andrew




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/GjCqFc1UL8o0jIV+veTKRgU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmT1wgkACgkQAR8vZIA0
zr1LoQgA5m+HzObub2+Zt0jGTnocq2LFTobxBplhb18UzvpV2LKEHtWH3LpmVYK0
gD6m+Ydg8Kjl+q2eavc9swk4BNzxp/SzyP3lNvtwM5BzoYVfYSp/J1oWvsd6FpeP
GxBiAD6lXHmCUU5rzTHPdP56+417rNeGEU9XIQnUcDdoXhSmy/Mw8LWObg/rVZsw
bvajJuVSVSC+5Rfl69mtM87XLfq8UFTy5FdnlpxrwrldtOivIJR1HQYDflqIaAQP
ccb/hgXBIaE98V1N5EoIncdTe6GIw4znCYPS50UPbsR/693KJ8C2g5OtgTzxlbfJ
dBY3PVF4Q9RaphOAwGjStGGLqwsp7Q==
=hAHl
-----END PGP SIGNATURE-----

--Sig_/GjCqFc1UL8o0jIV+veTKRgU--

