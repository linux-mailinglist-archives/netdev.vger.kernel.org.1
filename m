Return-Path: <netdev+bounces-221602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E237CB511E7
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC44563631
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF2D311C1B;
	Wed, 10 Sep 2025 08:57:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C1311952;
	Wed, 10 Sep 2025 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494649; cv=none; b=i8r8Fh8G8EjGgINfte6THCrMQM8JM12nB5OZI0wAfFXivfJVoQ0thxgLxLrcQDWoKnn8SF/Y9Bh61XG6EQh1QP+AgydPU8AQum0woeynEio1cXx/0eX/90p2sDUXAk5nTbsh7X9ED5NP5N44IOWRhYMhVpoRJsqCGFqs18JC3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494649; c=relaxed/simple;
	bh=UyTKr/gRlDYEGxckMgklqxwcPAl9u7MPrPxBjUXQOW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cn0AOIEwZb4xvhsHu/BeNy5zLh4ne8/LO2mAwn2gbcuAWad5kIJGdBnw5nA0G6OOJRGNPMoK9qOe8JjDP8HCFal+76/bp4tSHxxFhxFKObzVoBW7R0x2P4lYJPjgceIba/MAEPgbQMVrUDKLTtWsnZkyo28KDAmEiCJ53fA2/Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.98.2)
	(envelope-from <joerg@jo-so.de>)
	id 1uwG5X-00000006hFm-0ZHo;
	Wed, 10 Sep 2025 10:21:59 +0200
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98.2)
	(envelope-from <joerg@jo-so.de>)
	id 1uwG5W-00000000Okw-2Jme;
	Wed, 10 Sep 2025 10:21:58 +0200
Date: Wed, 10 Sep 2025 10:21:58 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: Yibo Dong <dong100@mucse.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "Anwar, Md Danish" <a0501179@ti.com>, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com, 
	lorenzo@kernel.org, geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com, 
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org, 
	gustavoars@kernel.org, rdunlap@infradead.org, vadim.fedorenko@linux.dev, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v11 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <vfarjsi3uf55kb5uj25stnjriemyvra7gomxmtik3jowsp24n5@k44vc2gdmyaf>
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-5-dong100@mucse.com>
 <68fc2f5c-2cbd-41f6-a814-5134ba06b4b5@ti.com>
 <20250909135822.2ac833fc@kernel.org>
 <00A30C785FE598BA+20250910060821.GB1832711@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ave2a22qe2b7h3wz"
Content-Disposition: inline
In-Reply-To: <00A30C785FE598BA+20250910060821.GB1832711@nic-Precision-5820-Tower>


--ave2a22qe2b7h3wz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v11 4/5] net: rnpgbe: Add basic mbx_fw support
MIME-Version: 1.0

Yibo Dong schrieb am Mi 10. Sep, 14:08 (+0800):
> On Tue, Sep 09, 2025 at 01:58:22PM -0700, Jakub Kicinski wrote:
> > On Tue, 9 Sep 2025 19:59:11 +0530 Anwar, Md Danish wrote:
> > > > +int mucse_mbx_sync_fw(struct mucse_hw *hw)
> > > > +{
> > > > +	int try_cnt =3D 3;
> > > > +	int err;
> > > > +
> > > > +	do {
> > > > +		err =3D mucse_mbx_get_info(hw);
> > > > +		if (err =3D=3D -ETIMEDOUT)
> > > > +			continue;
> > > > +		break;
> > > > +	} while (try_cnt--);
> > > > +
> > > > +	return err;
> > > > +} =20
> > >=20
> > > There's a logical issue in the code. The loop structure attempts to
> > > retry on ETIMEDOUT errors, but the unconditional break statement after
> > > the if-check will always exit the loop after the first attempt,
> > > regardless of the error. The do-while loop will never actually retry
> > > because the break statement is placed outside of the if condition that
> > > checks for timeout errors.
> >=20
>=20
> What is expected is 'retry on ETIMEDOUT' and 'no retry others'.=20
> https://lore.kernel.org/netdev/a066746c-2f12-4e70-b63a-7996392a9132@lunn.=
ch/
>=20
> > The other way around. continue; in a do {} while () look does *not*
> > evaluate the condition. So this can loop forever.
> >=20
>=20
> Maybe I can update like this ?
>=20
> int mucse_mbx_sync_fw(struct mucse_hw *hw)
> {
> 	int try_cnt =3D 3;
> 	int err;
>=20
> 	do {
> 		err =3D mucse_mbx_get_info(hw);
> 		if (err !=3D -ETIMEDOUT)
> 			break;
> 		/* only retry with ETIMEDOUT, others just return */
> 	} while (try_cnt--);
>=20
> 	return err;
> } =20

How about something like this?

int mucse_mbx_sync_fw(struct mucse_hw *hw)
{
	for (int try =3D 3; try; --try) {
		int err =3D mucse_mbx_get_info(hw);
		if (err !=3D -ETIMEDOUT)
			return err;
	}

	return ETIMEDOUT;
}


My 2cent.

Regards J=C3=B6rg

--=20
=E2=80=9EEs wurden und werden zu viele sprachlose B=C3=BCcher gedruckt, nac=
h deren
schon fl=C3=BCchtiger Lekt=C3=BCre man all die B=C3=A4ume um Vergebung bitt=
en m=C3=B6chte,
die f=C3=BCr den Schund ihr Leben lassen mussten.=E2=80=9C (Michael J=C3=BC=
rgs,
                      Seichtgebiete =E2=80=93 Warum wir hemmungslos verbl=
=C3=B6den)

--ave2a22qe2b7h3wz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCaME1JAAKCRB9LJoj0a6j
dWHfAP9MpwXSbDkmn0L3EBxXklRTyGo9dD4BVrhkdXrXtYNrXgD/f0quVJJNn+Zo
2d4EZ+ulmakNhpMKJUdjDi8P1IHNG6c=
=3Gfd
-----END PGP SIGNATURE-----

--ave2a22qe2b7h3wz--

