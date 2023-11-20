Return-Path: <netdev+bounces-49183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51707F10EE
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10D6B21682
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF48485;
	Mon, 20 Nov 2023 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9JKPpKs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAC79FE
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A925DC433C7;
	Mon, 20 Nov 2023 10:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700477750;
	bh=JNOXOdMOojAeZTWbU9byZOU6PtaixYj9Wh0/k1bc3mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a9JKPpKsvo/0/BW56ePSrrLHa0p5i/Ru9Zkn8gVbkwN6cA1scm7rRbvoN08W1Amrh
	 kN58pGCpIWvIWOnPfPUzY+Bpw+oAnk+ouW8Aoh6bdr8dF7SmKoLHHFSo/+pPWIzUKb
	 g5oR40me2x63tv8TpYM6cIMOeaXYME6hGghY+R7vu55Qa8URACng7cONXhiHs6UzwG
	 xZ923MXAeAcDuHwIUcOgtHkrAWwip6zm5ZXYzUckxo7zE6cJefRrHXhctXUuQSaVk/
	 hjaudb+9GZv3ICtMX+eoxAGpmBmOj9Yt3ynFhidQ5HIGh4x20ZKVyh0t/NXsTtWis5
	 5MmW+y5hNuG3A==
Date: Mon, 20 Nov 2023 11:55:46 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Toshiaki Makita <toshiaki.makita1@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH net] veth: fix ethtool statistical errors
Message-ID: <ZVs7MthVYdIBq9lz@lore-desk>
References: <20231116114150.48639-1-huangjie.albert@bytedance.com>
 <ZVcxmwm/DRTB8QwO@lore-desk>
 <CABKxMyPMboVYs01KfPEdxPbx-LT88Qe1pcDMaT0NiNWhA-5emg@mail.gmail.com>
 <ZVssMWXZYxM0eKiY@lore-desk>
 <CABKxMyPNYS=6BHhaMDOSSMu8F0C5jkoa5Tck1dE6QnLa6--6UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hhq9HwkAJFZbaTuH"
Content-Disposition: inline
In-Reply-To: <CABKxMyPNYS=6BHhaMDOSSMu8F0C5jkoa5Tck1dE6QnLa6--6UQ@mail.gmail.com>


--hhq9HwkAJFZbaTuH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=B8=80 17:52=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=
=8817=E6=97=A5=E5=91=A8=E4=BA=94 17:26=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > > if peer->real_num_rx_queues > 1, the ethtool -s command for
> > > > > veth network device will display some error statistical values.
> > > > > The value of tx_idx is reset with each iteration, so even if
> > > > > peer->real_num_rx_queues is greater than 1, the value of tx_idx
> > > > > will remain constant. This results in incorrect statistical value=
s.
> > > > > To fix this issue, assign the value of pp_idx to tx_idx.
> > > > >
> > > > > Fixes: 5fe6e56776ba ("veth: rely on peer veth_rq for ndo_xdp_xmit=
 accounting")
> > > > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > > > ---
> > > > >  drivers/net/veth.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > > > > index 0deefd1573cf..3a8e3fc5eeb5 100644
> > > > > --- a/drivers/net/veth.c
> > > > > +++ b/drivers/net/veth.c
> > > > > @@ -225,7 +225,7 @@ static void veth_get_ethtool_stats(struct net=
_device *dev,
> > > > >       for (i =3D 0; i < peer->real_num_rx_queues; i++) {
> > > > >               const struct veth_rq_stats *rq_stats =3D &rcv_priv-=
>rq[i].stats;
> > > > >               const void *base =3D (void *)&rq_stats->vs;
> > > > > -             unsigned int start, tx_idx =3D idx;
> > > > > +             unsigned int start, tx_idx =3D pp_idx;
> > > > >               size_t offset;
> > > > >
> > > > >               tx_idx +=3D (i % dev->real_num_tx_queues) * VETH_TQ=
_STATS_LEN;
> > > > > --
> > > > > 2.20.1
> > > > >
> > > >
> > > > Hi Albert,
> > > >
> > > > Can you please provide more details about the issue you are facing?
> > > > In particular, what is the number of configured tx and rx queues fo=
r both
> > > > peers?
> > >
> > > Hi, Lorenzo
> > > I found this because I wanted to add more echo information in ethttoo=
l=EF=BC=88for veth,
> > > but I found that the information was incorrect. That's why I paid
> > > attention here.
> >
> > ack. Could you please share the veth pair tx/rx queue configuration?
> >
>=20
> dev: tx --->4.  rx--->4
> peer: tx--->1 rx---->1
>=20
> Could the following code still be problematic? pp_idx not updated correct=
ly.
> page_pool_stats:
> veth_get_page_pool_stats(dev, &data[pp_idx]);

Thx for pointing this out. This part is a bit tricky but I think I can see =
the
issue now. Since we have just one peer rx queue, when we run ndo_xdp_xmit
pointer on dev, we will squash all dev xmit queues on the single peer rx one
(where we do do the accounting) [0].
The issue is ethtool will display all dev xmit queues so we need to set pp_=
idx
properly in veth_get_ethtool_stats().
Can you please take a look to the patch below?

Regards,
Lorenzo

[0] https://github.com/LorenzoBianconi/net-next/blob/master/drivers/net/vet=
h.c#L417

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 9980517ed8b0..8607eb8cf458 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -236,8 +236,8 @@ static void veth_get_ethtool_stats(struct net_device *d=
ev,
 				data[tx_idx + j] +=3D *(u64 *)(base + offset);
 			}
 		} while (u64_stats_fetch_retry(&rq_stats->syncp, start));
-		pp_idx =3D tx_idx + VETH_TQ_STATS_LEN;
 	}
+	pp_idx =3D idx + dev->real_num_tx_queues * VETH_TQ_STATS_LEN;
=20
 page_pool_stats:
 	veth_get_page_pool_stats(dev, &data[pp_idx]);

>=20
> BR
> Albert
>=20
> > Rergards,
> > Lorenzo
> >
> > >
> > > > tx_idx is the index of the current (local) tx queue and it must res=
tart from
> > > > idx in each iteration otherwise we will have an issue when
> > > > peer->real_num_rx_queues is greater than dev->real_num_tx_queues.
> > > >
> > > OK. I don't know if this is a known issue.
> > >
> > > BR
> > > Albert
> > >
> > >
> > > > Regards,
> > > > Lorenzo

--hhq9HwkAJFZbaTuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZVs7MgAKCRA6cBh0uS2t
rLj+AP9vMII6nwXW7ZJdM5Pl3vPFbXaHYgnoCiPxk2vp0r8g3AEAxtnUvbbKUYtH
TksmG8p8EEEdw92st5fryqBiqa53HAM=
=Dba7
-----END PGP SIGNATURE-----

--hhq9HwkAJFZbaTuH--

