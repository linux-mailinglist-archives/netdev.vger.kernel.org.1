Return-Path: <netdev+bounces-31368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610BC78D526
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 12:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095A228136D
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DAE1C16;
	Wed, 30 Aug 2023 10:38:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F54186B
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 10:38:02 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F964B9;
	Wed, 30 Aug 2023 03:38:00 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 145A986516;
	Wed, 30 Aug 2023 12:37:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693391876;
	bh=hYE3Iuq35SjmyNI2S9TSnr9aKGQjsSp3lFWeuO2MdWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sOdHGb6Sv+qU9CN6Y37qk+oc+ewvnjJqA+oCZIeKLtAMkvDf/qnL5jYE/MaCyDZxj
	 6JE7iJ3QmuHdHLoZY0wutm+24BRwOGlKgZBfzU9pVlZu8FaexHl+40KIBx/guOmLs3
	 A4eipVK+mUNLZ4Xx/bgBksQrqIJ2e8cy7SoThz8ttegrzVjl90U5YnZ2GUvZ+RWsS8
	 umLE6Whsf63TLxfKx99glaYr6OuccHc8K/iHVxYDHJ9tzTlqdsHGy95HRhXGRcrgRN
	 6KcayfnnQJCbQ69op0Jlo6fpTxBnaa10ShArJGoR6kq+4Yx6lJmSf+B/W9mCp+IxxT
	 6WpTmVfbKOyWw==
Date: Wed, 30 Aug 2023 12:37:49 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>, Vladimir
 Oltean <olteanv@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, Heiner
 Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230830123749.1486c4b7@wsk>
In-Reply-To: <ZO8QbyKphyTmuv/g@localhost.localdomain>
References: <20230830092119.458330-1-lukma@denx.de>
	<20230830092119.458330-2-lukma@denx.de>
	<ZO8QbyKphyTmuv/g@localhost.localdomain>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6UwQloerGA_x4LyjrlAqcgR";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/6UwQloerGA_x4LyjrlAqcgR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michal,

> On Wed, Aug 30, 2023 at 11:21:19AM +0200, Lukasz Majewski wrote:
> > The KSZ9477 errata points out (in 'Module 4') the link up/down
> > problem when EEE (Energy Efficient Ethernet) is enabled in the
> > device to which the KSZ9477 tries to auto negotiate.
> >=20
> > The suggested workaround is to clear advertisement of EEE for PHYs
> > in this chip driver.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
> Hi,
>=20
> As the net is target you should add fixes tag which the commit that
> your changes is fixing (workarounding :) )
>=20

I'm applying code for vendor's errata.

I will search when it has been modified.

> > ---
> >  drivers/net/phy/micrel.c | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > index 87b090ad2874..469dcd8a5711 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -1418,6 +1418,35 @@ static int ksz9131_get_features(struct
> > phy_device *phydev) return 0;
> >  }
> > =20
> > +static int ksz9477_get_features(struct phy_device *phydev)
> > +{
> > +	__ETHTOOL_DECLARE_LINK_MODE_MASK(zero) =3D { 0, }; =20
> =3D { 0 };

Ok.

>=20
> > +	int ret;
> > +
> > +	ret =3D genphy_read_abilities(phydev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* KSZ9477 Errata DS80000754C
> > +	 *
> > +	 * Module 4: Energy Efficient Ethernet (EEE) feature
> > select must be
> > +	 * manually disabled
> > +	 *   The EEE feature is enabled by default, but it is not
> > fully
> > +	 *   operational. It must be manually disabled through
> > register
> > +	 *   controls. If not disabled, the PHY ports can
> > auto-negotiate
> > +	 *   to enable EEE, and this feature can cause link drops
> > when linked
> > +	 *   to another device supporting EEE.
> > +	 *
> > +	 *   Although, the KSZ9477 MMD register
> > +	 *   (MMD_DEVICE_ID_EEE_ADV.MMD_EEE_ADV) advertise that
> > EEE is
> > +	 *   operational one needs to manualy clear them to follow
> > the chip
> > +	 *   errata.
> > +	 */
> > +	linkmode_and(phydev->supported_eee, phydev->supported,
> > zero); +
> > +	return 0;
> > +}
> > +
> >  #define KSZ8873MLL_GLOBAL_CONTROL_4	0x06
> >  #define KSZ8873MLL_GLOBAL_CONTROL_4_DUPLEX	BIT(6)
> >  #define KSZ8873MLL_GLOBAL_CONTROL_4_SPEED	BIT(4)
> > @@ -4871,7 +4900,7 @@ static struct phy_driver ksphy_driver[] =3D {
> >  	.handle_interrupt =3D kszphy_handle_interrupt,
> >  	.suspend	=3D genphy_suspend,
> >  	.resume		=3D genphy_resume,
> > -	.get_features	=3D ksz9131_get_features,
> > +	.get_features	=3D ksz9477_get_features,
> >  } };
> > =20
> >  module_phy_driver(ksphy_driver);
> > --=20
> > 2.20.1
> >  =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/6UwQloerGA_x4LyjrlAqcgR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTvG/0ACgkQAR8vZIA0
zr0gGwf9EUiMj6gZfEHk7avYYek6xKWiO639iDpzScFODEPF4NquyHx6R17ntdt8
ACW+5cxCR4trZ2KXNiVRQzKSDKIzeI2A13RObn3JWz8LIhUVMycQF+quukl1HmhQ
2vTXoXSsyIbnjz1uE68cgJueDOYA07+Bp/bFUZhH8SJqpr50dPJ+++ght0gR0LyK
KOclIPrlpUo6qujc61KySEzK2mkbfiuiRK2vsFacRJZGflTMMiMlNrvCuMyCUtE0
xczottZBJGcy+o3gXcjz0muc9tD+Fzhdz/5YaLMCoPbIr7+V5KqlXMsr9IxgSjqk
Dn6hnMogz9BHpLLnFIaki6lYJcQQDw==
=Vevx
-----END PGP SIGNATURE-----

--Sig_/6UwQloerGA_x4LyjrlAqcgR--

