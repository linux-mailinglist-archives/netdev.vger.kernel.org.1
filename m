Return-Path: <netdev+bounces-151453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C609EF433
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C02281CE6
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D66222D4B;
	Thu, 12 Dec 2024 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR4jMgCF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B6176AA1
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023080; cv=none; b=Fbgq0TNtTV8Qj/aQWjJQfrkBkVdmQwXJkhUPwj76eU8QAxn8edGbPDg/CZPrih+hcErn9O1R1nD6Q/OH9PAHt9GGDTX8ucjitsy23eywh9Ng7LCcuFED7HaAS7gM3bRVj1SnmsyxCeqcitPr93cr6Kv9VFe7AY69xmD+6c7Q9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023080; c=relaxed/simple;
	bh=DT792Ij2WAaBVTfzTATX6erZdGiiVPj0/Aw4QkGStTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHJj1ZZMQc7gqK3rV41VnCmkp8vMYHLYn8t8WqJq8XTA/8ZrVYU6tGG31uhrJq9fTv1Kp5c7x3wufo4IHRNX+dSbKYn6ger+AZWpV5f2ajXGpTgpFCjFPVkvn53rXSRsMMRuh5AOyJXWuD56Fyvdt47L2nswPxO6MTVUbYlu+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR4jMgCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE72C4CECE;
	Thu, 12 Dec 2024 17:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734023080;
	bh=DT792Ij2WAaBVTfzTATX6erZdGiiVPj0/Aw4QkGStTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UR4jMgCF6haI4ZEi3OfpesVZ3KLFifj9skwyjYXpGwJMvKockv+Fe05p1QmkL7KGv
	 MhS9chLgh6KnldpYxn/l2Sh3JTdrO57hsD/YZzTZ4RlU6p3gI8xQAdBwheN2mw4q/H
	 P6Lx1Y2GpNbQ1WMVF3v1cEVFYO1SRMotXyg6xFbKqrQQrP289q+rXHY41JK4JvPexJ
	 ER082SB0WFuk0GHxx7BAQeCQz4He3fsTK4Ulx8MUyr/TDrrh+1jZLclvPlnrV/Sbn/
	 uVi9NTRfiPmqIAH51N6eOr0ubEoryKI/w2bJ4VpQ/RT5vlKTce+FuJhhnqE1s3f+C+
	 62vQszH9V7IeQ==
Date: Thu, 12 Dec 2024 18:04:37 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 4/5] net: airoha: Add sched ETS offload support
Message-ID: <Z1sXpWH8MMNlVVMr@lore-desk>
References: <cover.1733930558.git.lorenzo@kernel.org>
 <b4d34136f5ef0d43e2727c2bf833adb41216cdc1.1733930558.git.lorenzo@kernel.org>
 <CAKa-r6shd3+2zgeEzVVJR7fKWdpjKv1YJxS3z+y7QWqDf8zDZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5lgxgD//6AJ2DkE7"
Content-Disposition: inline
In-Reply-To: <CAKa-r6shd3+2zgeEzVVJR7fKWdpjKv1YJxS3z+y7QWqDf8zDZQ@mail.gmail.com>


--5lgxgD//6AJ2DkE7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Dec 12, Davide Caratti wrote:
> hi Lorenzo,
>=20
> On Wed, Dec 11, 2024 at 4:32=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:
> >
> > Introduce support for ETS qdisc offload available in the Airoha EN7581
> > ethernet controller. Add the capability to configure hw ETS Qdisc for
> > the specified DSA user port via the QDMA block available in the mac chip
> > (QDMA block is connected to the DSA switch cpu port).
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/mediatek/airoha_eth.c | 155 ++++++++++++++++++++-
> >  1 file changed, 154 insertions(+), 1 deletion(-)
> >
> [...]
>=20
> > +static int airoha_qdma_set_tx_ets_sched(struct airoha_gdm_port *port,
> > +                                       int channel,
> > +                                       struct tc_ets_qopt_offload *opt)
> > +{
> > +       struct tc_ets_qopt_offload_replace_params *p =3D &opt->replace_=
params;
> > +       enum tx_sched_mode mode =3D TC_SCH_SP;
> > +       u16 w[AIROHA_NUM_QOS_QUEUES] =3D {};
> > +       int i, nstrict =3D 0;
> > +
> > +       if (p->bands !=3D AIROHA_NUM_QOS_QUEUES)
> > +               return -EINVAL;
>=20
> maybe this condition can be relaxed to '<'  if priomap is parsed ? (see b=
elow)

ack, I guess we can relax a bit this condition.

>=20
> > +
> > +       for (i =3D 0; i < p->bands; i++) {
> > +               if (!p->quanta[i])
> > +                       nstrict++;
> > +       }
> > +
> > +       /* this configuration is not supported by the hw */
> > +       if (nstrict =3D=3D AIROHA_NUM_QOS_QUEUES - 1)
> > +               return -EINVAL;
> > +
> > +       for (i =3D 0; i < p->bands - nstrict; i++)
> > +               w[i] =3D p->weights[nstrict + i];
> > +
> > +       if (!nstrict)
> > +               mode =3D TC_SCH_WRR8;
> > +       else if (nstrict < AIROHA_NUM_QOS_QUEUES - 1)
> > +               mode =3D nstrict + 1;
> > +
> > +       return airoha_qdma_set_chan_tx_sched(port, channel, mode, w,
> > +                                            ARRAY_SIZE(w));
>=20
> it seems that SP queues have a fixed, non-programmable priority in
> hardware (e.g., queue 7 is served prior to queue 6) If this is the
> case, you probably have to ensure that 'priomap' maps correctly
> skb->priority to one of the SP queues, like done in [1].

ack, I will take a look.

Regards,
Lorenzo

>=20
> thanks,
> --=20
> davide
>=20
> [1] https://elixir.bootlin.com/linux/v6.12.4/source/drivers/net/ethernet/=
microchip/lan966x/lan966x_ets.c#L41
>=20

--5lgxgD//6AJ2DkE7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ1sXpQAKCRA6cBh0uS2t
rCubAQDE3VJFcnjXdz0J7uykptxG3Jeb+naJPfKlVNgCP8jC3wEAn9nF1enQjY8C
aA5jzlKDmuDGktCrvWpjKZoL1FMl6g8=
=vsq5
-----END PGP SIGNATURE-----

--5lgxgD//6AJ2DkE7--

