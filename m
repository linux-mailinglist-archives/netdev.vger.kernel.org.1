Return-Path: <netdev+bounces-105596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBA0911ED1
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691A6281EE2
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079F916D4FA;
	Fri, 21 Jun 2024 08:31:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15A18E20
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958666; cv=none; b=lGO3tnYtPeqcrc6XMyQf67b+Z8ykC//LDwFCoYwHFBhqu8xHAfcoLtpY0qqyiCER0wKQcHeO9DQGg7Lm9esWn315uK/lKVvXMlq+WtcQKyMeWPKomc9Wrgdth8ZFH1EOXY89ejgeeRRyp5tz1UmXs5EtMkCKzfYeIn6UkaWfPhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958666; c=relaxed/simple;
	bh=9HB9jO47qBfvaobMoLyouqx97fk8WIHZYuDazEmliqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqnrtnB5IlnSy+9piDeiyOZtSNqRlHAvZqI3u098Md6N7LZVJqoDLTsGQCtwyvn1f/R/Exe1Bzydl50RjBWJl9t/aS+NrfJyXN+fMqOKAE2vJMUMczfTyM55zbwTOsaW+uACTIYfaspaBOkBeQu0iUjx6Y+oJTS1TzCugPX5Gqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZfX-0000GX-0u; Fri, 21 Jun 2024 10:30:51 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZfV-003tol-Uz; Fri, 21 Jun 2024 10:30:50 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AB4312EE56E;
	Fri, 21 Jun 2024 08:30:49 +0000 (UTC)
Date: Fri, 21 Jun 2024 10:30:49 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Thomas Kopp <thomas.kopp@microchip.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] can: hi311x: simplify with
 spi_get_device_match_data()
Message-ID: <20240621-camouflaged-yak-from-vega-6ef4f6-mkl@pengutronix.de>
References: <20240606142424.129709-1-krzysztof.kozlowski@linaro.org>
 <CAMZ6RqKCWzzbd-P7rOMEryd=31pdD_PJJvtQFYcmS+wAf8q+CQ@mail.gmail.com>
 <20240620-imaginary-sepia-gibbon-048a32-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3fzhuwpr2zgg6io2"
Content-Disposition: inline
In-Reply-To: <20240620-imaginary-sepia-gibbon-048a32-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--3fzhuwpr2zgg6io2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.06.2024 14:20:53, Marc Kleine-Budde wrote:
> On 07.06.2024 12:26:13, Vincent MAILHOL wrote:
> > Hi Krzysztof,
> >=20
> > On Thu. 6 Jun. 2024 =C3=A0 23:24, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > Use spi_get_device_match_data() helper to simplify a bit the driver.
> >=20
> > Thanks for this clean up.
> >=20
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > >  drivers/net/can/spi/hi311x.c | 7 +------
> > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311=
x.c
> > > index e1b8533a602e..5d2c80f05611 100644
> > > --- a/drivers/net/can/spi/hi311x.c
> > > +++ b/drivers/net/can/spi/hi311x.c
> > > @@ -830,7 +830,6 @@ static int hi3110_can_probe(struct spi_device *sp=
i)
> > >         struct device *dev =3D &spi->dev;
> > >         struct net_device *net;
> > >         struct hi3110_priv *priv;
> > > -       const void *match;
> > >         struct clk *clk;
> > >         u32 freq;
> > >         int ret;
> > > @@ -874,11 +873,7 @@ static int hi3110_can_probe(struct spi_device *s=
pi)
> > >                 CAN_CTRLMODE_LISTENONLY |
> > >                 CAN_CTRLMODE_BERR_REPORTING;
> > >
> > > -       match =3D device_get_match_data(dev);
> > > -       if (match)
> > > -               priv->model =3D (enum hi3110_model)(uintptr_t)match;
> > > -       else
> > > -               priv->model =3D spi_get_device_id(spi)->driver_data;
> > > +       priv->model =3D (enum hi3110_model)spi_get_device_match_data(=
spi);
> >=20
> > Here, you are dropping the (uintptr_t) cast. Casting a pointer to an
> > enum type can trigger a zealous -Wvoid-pointer-to-enum-cast clang
> > warning, and the (uintptr_t) cast is the defacto standard to silence
> > such warnings, thus the double (enum hi3110_model)(uintptr_t) cast in
> > the initial version.
>=20
> I've re-added the intermediate cast to uintptr_t while applying.

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3fzhuwpr2zgg6io2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ1OjYACgkQKDiiPnot
vG/mvAf/UQfjSS72xhzUs9lqPAYliU4GWM5QC3Mcs01H58Ix9759WcwalU3xHBt1
PjAmmq3Z8ZPKa9RMw/THr4CJNw4FYgxmLSlwqem5YmHAy0PnfkqxwfhH7SNJqmnR
pxzA+0J1RdjEGmRtLeYNDnYFoxSMsxcvRnHtyslizFiwsrt0nMAxRih605msWm8i
E+KsAuObomJAXHB7t57t/64qf0ifsE9K8qlFdLkBEH1z99QyOSqO6uyHOB1X48jd
Czl/yX2QCpq+kyRzX9i+GsZ+YeU0IEjzU1Tm4hSN2HiR4MHcaW0sWFwxAFbeJXsP
zcAs+cO2b/Mk1Q8+fK0ncI0oaf4M4Q==
=PrVV
-----END PGP SIGNATURE-----

--3fzhuwpr2zgg6io2--

