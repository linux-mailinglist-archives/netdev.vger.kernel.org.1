Return-Path: <netdev+bounces-136916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DF19A39C8
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD531C220AC
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE681FF7C4;
	Fri, 18 Oct 2024 09:17:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843821FF7B6
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243025; cv=none; b=hNViBtS68P+2NQ/no6JGeuRc25FkbowTZ+mvDNl4imRE9Wpg6OYGJECLHiA/XdCjtVRedk/Fk/pU3yWA/mhdQ3GFhBEp3hSTu2tD4Poc4e1v70nHNEFxgD36vTynyL7de8/aeK1wX9imr+2YbOTOTd6krrI/7ByE4+S9dK2K+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243025; c=relaxed/simple;
	bh=rzkEdXf9tnVWOIhcsEoK9mKCEw0k2o0GdcuNOkBNxmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKVirmr37Stuu/btacOs/ID02G5ivN8Oexhf3sO45Kk6T4WtfIqSW1iCtu6NPzt9wZvLTvg1ah7ggH4R6jUJbm3j+4TuTljqe4NQdWAuFctQZ/IYfUI7aARrNNYKvbBcC+TDS5/stBC4iZuoH1hAxEpkQHgB9UJSZ17qoBa5T38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1j6G-0004by-1v; Fri, 18 Oct 2024 11:16:48 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1j6E-000Bd1-2i;
	Fri, 18 Oct 2024 11:16:46 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7CFAF357AF1;
	Fri, 18 Oct 2024 09:16:46 +0000 (UTC)
Date: Fri, 18 Oct 2024 11:16:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: RE: RE: [PATCH net-next 07/13] net: fec: fec_probe(): update
 quirk: bring IRQs in correct order
Message-ID: <20241018-black-dormouse-of-exercise-f7fed0-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-7-de783bd15e6a@pengutronix.de>
 <PAXPR04MB85103D3E433F3FBE5DDFA15C88472@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241017-affable-impartial-rhino-a422ec-mkl@pengutronix.de>
 <PAXPR04MB8510149D0E8AC39E048941F988472@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241017-manipulative-dove-of-renovation-88d00b-mkl@pengutronix.de>
 <ZxEZR2lmIbX6+xX2@lizhi-Precision-Tower-5810>
 <20241017-rainbow-nifty-gazelle-9acee4-mkl@pengutronix.de>
 <ZxEtpRWsi+QiYsFh@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ozr2uxsly64lqtk"
Content-Disposition: inline
In-Reply-To: <ZxEtpRWsi+QiYsFh@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--5ozr2uxsly64lqtk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.10.2024 11:30:45, Frank Li wrote:
> On Thu, Oct 17, 2024 at 04:21:33PM +0200, Marc Kleine-Budde wrote:
> > On 17.10.2024 10:03:51, Frank Li wrote:
> > > > > > Yes, that is IMHO the correct description of the IP core, but t=
he
> > > > > > i.MX8M/N/Q DTS have the wrong order of IRQs. And for compatibil=
ity
> > > > > > reasons (fixed DTS with old driver) it's IMHO not possible to c=
hange the
> > > > > > DTS.
> > > > > >
> > > > >
> > > > > I don't think it is a correct behavior for old drivers to use new=
 DTBs or new
> > > > > drivers to use old DTBs. Maybe you are correct, Frank also asked =
the same
> > > > > question, let's see how Frank responded.
> > > >
> > > > DTBs should be considered stable ABI.
> > > >
> > >
> > > ABI defined at binding doc.
> > >   interrupt-names:
> > >     oneOf:
> > >       - items:
> > >           - const: int0
> > >       - items:
> > >           - const: int0
> > >           - const: pps
> > >       - items:
> > >           - const: int0
> > >           - const: int1
> > >           - const: int2
> > >       - items:
> > >           - const: int0
> > >           - const: int1
> > >           - const: int2
> > >           - const: pps
> > >
> > > DTB should align binding doc. There are not 'descriptions' at 'interr=
upt',
> > > which should match 'interrupt-names'. So IMX8MP dts have not match AB=
I,
> > > which defined by binding doc. So it is DTS implement wrong.
> >
> > I follow your conclusion. But keep in mind, fixing the DTB would break
> > compatibility. The wrong DTS looks like this:
> >
> > - const: int1
> > - const: int2
> > - const: int0
> > - const: pps
> >
> > Currently we have broken DTS on the i.MX8M* and the
> > FEC_QUIRK_WAKEUP_FROM_INT2 that "fixes" this.
> >
> > This patch uses this quirk to correct the IRQ <-> queue assignment in
> > the driver.
>=20
> This current code
>=20
> for (i =3D 0; i < irq_cnt; i++) {
>                 snprintf(irq_name, sizeof(irq_name), "int%d", i);
>                 irq =3D platform_get_irq_byname_optional(pdev, irq_name);
> 		      ^^^^^^^^^^^^^^^^^^^^^
>=20
> You just need add interrupt-names at imx8mp dts and reorder it to pass
> DTB check.

ACK

>=20
>                 if (irq < 0)
>                         irq =3D platform_get_irq(pdev, i);
>                 if (irq < 0) {
>                         ret =3D irq;
>                         goto failed_irq;
>                 }
>                 ret =3D devm_request_irq(&pdev->dev, irq, fec_enet_interr=
upt,
>                                        0, pdev->name, ndev);
>                 if (ret)
>                         goto failed_irq;
>=20
>                 fep->irq[i] =3D irq;
>         }
>=20
> All irq handle by the same fec_enet_interrupt().  Change dts irq orders
> doesn't broken compatiblity.

I'm sorry, but this is not 100% correct. Changing the _order_ of IRQs
does break compatibility. New DT (with changed IRQ order) with old
driver breaks wakeup functionality.

Have a look at b7cdc9658ac8 ("net: fec: add WoL support for i.MX8MQ"),
but keep in mind the patch description is not 100% correct:

| By default FEC driver treat irq[0] (i.e. int0 described in dt-binding)
| as wakeup interrupt, but this situation changed on i.MX8M serials, SoC
| integration guys mix wakeup interrupt signal into int2 interrupt line.
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This statement is wrong. The SoC integration is correct, the DT is
wrong.

| This patch introduces FEC_QUIRK_WAKEUP_FROM_INT2 to indicate int2 as
| wakeup interrupt for i.MX8MQ.

> "pre-equeue" irq is new features. You can enable this feature only
> when "interrupt-names" exist in future.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5ozr2uxsly64lqtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcSJ3sACgkQKDiiPnot
vG9DXwgAnWJD0+pgpUJwVQfqSiGkWkMe5M6qtIWo09HfS9/N5262P2ixUjv5KrFo
IzsTY4+y4EJquuMsX1nIxJhLIEM+GqN6m+Tan1IH9wNdvvAhAE/GJYDc3imzsKsC
3gATfbC7NZ6kjf/v9/b7mgwelkL6Xogc4aQwvQvTRdVQgIW+BqW2VpGfPHQieW25
henGvWDOBvWUFIQLhQYPzf20bq1VVxekaFHZe+PIr6uf7h/aCr3FVYyiHSVVx2+V
iW4WjZkIQozCNneQ3MHq6u20f94gItt1bFuBqKhrYDSgIe+Tj7Bt1n35dtJoGUQv
jTI3ADivQ7SoRYabV2mXTVhbq3xxTQ==
=SR5D
-----END PGP SIGNATURE-----

--5ozr2uxsly64lqtk--

