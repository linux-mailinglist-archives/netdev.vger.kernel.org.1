Return-Path: <netdev+bounces-146216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCFC9D24D4
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4499B26F5B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7495E1C6882;
	Tue, 19 Nov 2024 11:28:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A141C57A0
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015730; cv=none; b=KZfNpP1HZb+Cx/rGK/kfLgYmaIlT6w/cxcGIML+/gO09wmw33UpUI1niq6ryvyWRNQSfSvDfZDIsKfbu+Perr4uZzLYZIyN/NZ4YX5uyQWNw3wOuTDsO67GP8ikczlvxt2mwFUryoMwDgebTTmn1+QskAyxkBs9U7DhF2uw7lCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015730; c=relaxed/simple;
	bh=u2UgbMDlfxz8IajgIYyIKTYM4Ptg2lazrBYEpLcTmNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRNNI6JcRnt+F+0E+XHUsYDZh76U8NeGwVTNI9zwJ22TRTcWajnwWlqQx7uvAukZGOuoAuHr/23aUx1fQ1MfccKHkWNVdX+dCnqkJKhhhhMDb+rqo3dlqzKK7j6LQtrUqsUZErbncysd9r6gqcNu9IK8PkY05Ubkqt+Wc/kZ720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDMOx-00037F-BW; Tue, 19 Nov 2024 12:28:11 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDMOv-001YXr-2q;
	Tue, 19 Nov 2024 12:28:09 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7B9E337701F;
	Tue, 19 Nov 2024 11:28:09 +0000 (UTC)
Date: Tue, 19 Nov 2024 12:28:09 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, NXP Linux Team <s32@nxp.com>, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
Message-ID: <20241119-spectral-brave-millipede-9a2bd9-mkl@pengutronix.de>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-4-ciprianmarian.costea@oss.nxp.com>
 <57915ed9-e57e-4ca3-bc31-6405893c937e@wanadoo.fr>
 <bfa5200d-6e56-417d-ac3b-52390398dba2@oss.nxp.com>
 <f84991f7-66c6-4366-9953-b230761b6b7a@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xz7ruru37yb6p5n4"
Content-Disposition: inline
In-Reply-To: <f84991f7-66c6-4366-9953-b230761b6b7a@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--xz7ruru37yb6p5n4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
MIME-Version: 1.0

On 19.11.2024 20:26:26, Vincent Mailhol wrote:
> On 19/11/2024 at 19:01, Ciprian Marian Costea wrote:
> > On 11/19/2024 11:26 AM, Vincent Mailhol wrote:
> >> On 19/11/2024 at 17:10, Ciprian Costea wrote:
>=20
> (...)
>=20
> >>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (priv->devtype_data.quirks & FLEXCAN_QU=
IRK_SECONDARY_MB_IRQ) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D request_irq(priv-=
>irq_secondary_mb,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flexcan_irq, IRQF_SHARED, dev->name, d=
ev);
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto out_free_irq_err;
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>
> >> Is the logic here correct?
> >>
> >> =C2=A0=C2=A0 request_irq(priv->irq_err, flexcan_irq, IRQF_SHARED, dev-=
>name, dev);
> >>
> >> is called only if the device has the FLEXCAN_QUIRK_NR_IRQ_3 quirk.
> >>
> >> So, if the device has the FLEXCAN_QUIRK_SECONDARY_MB_IRQ but not the
> >> FLEXCAN_QUIRK_NR_IRQ_3, you may end up trying to free an irq which was
> >> not initialized.
> >>
> >> Did you confirm if it is safe to call free_irq() on an uninitialized i=
rq?
> >>
> >> (and I can see that currently there is no such device with
> >> FLEXCAN_QUIRK_SECONDARY_MB_IRQ but without FLEXCAN_QUIRK_NR_IRQ_3, but
> >> who knows if such device will be introduced in the future?)
> >>
> >=20
> > Hello Vincent,
> >=20
> > Thanks for your review. Indeed this seems to be an incorrect logic since
> > I do not want to create any dependency between 'FLEXCAN_QUIRK_NR_IRQ_3'
> > and 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ'.
> >=20
> > I will change the impacted section to:
> > =C2=A0=C2=A0=C2=A0=C2=A0if (err) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (priv->devtype_data.quirk=
s & FLEXCAN_QUIRK_NR_IRQ_3)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 out_free_irq_err;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 out_free_irq;
> > =C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> This is better. Alternatively, you could move the check into the label:

+1

>   out_free_irq_err:
>   	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
>   		free_irq(priv->irq_err, dev);
>=20
> But this is not a strong preference, I let you pick the one which you
> prefer.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xz7ruru37yb6p5n4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc8dkYACgkQKDiiPnot
vG/f4Qf5AXfD76d0okPPWmk+uxFI4bon1jkLTc9UwHx3T1B1Uh4qXIOzuv1BKH/f
5BlNZGvPtltOws6yQfeDgZfs06zkaUnFIpQwo9osxsvpegIDA2WQ1ms/LhoDmC0L
CeV5FjB5yDeV0cQfX7iJzJYNtNOWCJaa96M7xw86Sfiu8qJsuDShnG0ZOGiWQGeQ
qN18K8sBSTdEYHfAbHN8AP9QM7GeJm/l0Qth0vNPlOzCk/3ptPy+my5Rah2EHRY4
KcwdlGep/tVJ/9DZ1qEWbp4EhAzsMnqMgTd5MdvvdKXyZS8FQ14h13vRkJOR04wp
tCdMzoQMbBfZLNPRILT72PfPI9VE/A==
=9j7A
-----END PGP SIGNATURE-----

--xz7ruru37yb6p5n4--

