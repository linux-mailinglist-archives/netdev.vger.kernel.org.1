Return-Path: <netdev+bounces-151330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30E59EE281
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 10:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B76188B284
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 09:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968E720E707;
	Thu, 12 Dec 2024 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOXrkPE5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D720CCE7
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995184; cv=none; b=fkglmHwexsPYihzGmCF40RoCmiyB3Gv4oetAOZ4FtmJgmyGvoUgyKMEZnOCeOGInmSLWdxlK5/95TLIO0MoVv3Er+aca0joqwpBk65uX49zmvtk+/q21Wi0LQQdIM6HMou1Q6aHSk7TdZdwXxc4vIkonPMWybQTCchauMavXw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995184; c=relaxed/simple;
	bh=iUGVAU4e5lFNJ0P2lalKqxBBvplL/cziTTZ9ZcjocIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8YZeqq9T9/5m2MXG3fD5HJOtqNa/skU8zpLEELQlGLMBrt3Pliz7NPdGCDh5xDvC5p51GRgQBzd5dbhFsFhsM/LGfcnjn+4NZ7ytSVv/zs33MyPl2i/Uh9TNuzhSWkCoqRahAH7/mAxb+y8gLjMymPVE7LHpfZC1kGGoGrZAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOXrkPE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE96C4CED4;
	Thu, 12 Dec 2024 09:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733995184;
	bh=iUGVAU4e5lFNJ0P2lalKqxBBvplL/cziTTZ9ZcjocIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOXrkPE5GpckYdd+nCyk30R2BNFND6ldzp2hDAO7OPw+6ZZ6U4P25RunWFdDr3faQ
	 1KUeVcQ2jaexd1/ghnbsoPOWgUApVhbisiG8J0Nrt+lJ68yIejDud99kg9u3nBK3HG
	 8FeociRqH4HnI2Tv7/J4pjqsRJ8yvEsvfAuodgM0i1MrQxqeXeZV7ETmK+AaDcjJjw
	 syuObn5Pc/rE5f1m6UR6tcOQ3trWsHo09CkLucH0yUA7+lkk23YRAi6shkEeB4L9ZL
	 ThOoNJ1HLP3E72DJpw5BiCaGn3GHbf83LLE86HzBkSSgEPX0wS7dsOdi+TbzJYT5jA
	 gzaIkA1u6vBVA==
Date: Thu, 12 Dec 2024 10:19:41 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <Z1qqrVWV84DBZuCn@lore-desk>
References: <cover.1733930558.git.lorenzo@kernel.org>
 <20241211154109.dvkihluzdouhtamr@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Tv/j4zy2xt/BHBs/"
Content-Disposition: inline
In-Reply-To: <20241211154109.dvkihluzdouhtamr@skbuf>


--Tv/j4zy2xt/BHBs/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,

Hi Vladimir,

>=20
> On Wed, Dec 11, 2024 at 04:31:48PM +0100, Lorenzo Bianconi wrote:
> > Introduce support for ETS and TBF qdisc offload available in the Airoha
> > EN7581 ethernet controller.
> > Some DSA hw switches do not support Qdisc offloading or the mac chip
> > has more fine grained QoS capabilities with respect to the hw switch
> > (e.g. Airoha EN7581 mac chip has more hw QoS and buffering capabilities
> > with respect to the mt7530 switch).=20
> > Introduce ndo_setup_tc_conduit callback in order to allow tc to offload
> > Qdisc policies for the specified DSA user port configuring the hw switch
> > cpu port (mac chip).
>=20
> Can you please make a detailed diagram explaining how is the conduit
> involved in the packet data path for QoS? Offloaded tc on a DSA user
> port is supposed to affect autonomously forwarded traffic too (like the
> Linux bridge).

I guess a typical use case would be the one below where the traffic from the
WAN port is forwarded to a DSA LAN one (e.g. lan0) via netfilter flowtable
offload.

            =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90            =20
            =E2=94=82               BR0               =E2=94=82            =
=20
            =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=
=E2=94=80=E2=94=80=E2=94=98            =20
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=90           =20
=E2=94=82DSA            =E2=94=82        =E2=94=82        =E2=94=82        =
=E2=94=82   =E2=94=82           =20
=E2=94=82               =E2=94=82        =E2=94=82        =E2=94=82        =
=E2=94=82   =E2=94=82           =20
=E2=94=82 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=90      =E2=94=8C=E2=
=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=90   =E2=94=8C=E2=94=80=E2=94=80=E2=
=96=BC=E2=94=80=E2=94=90   =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=
=94=90   =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=90 =E2=94=82  =
     =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=90
=E2=94=82 =E2=94=82CPU=E2=94=82      =E2=94=82LAN0=E2=94=82   =E2=94=82LAN1=
=E2=94=82   =E2=94=82LAN2=E2=94=82   =E2=94=82LAN3=E2=94=82 =E2=94=82      =
 =E2=94=82WAN=E2=94=82
=E2=94=82 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=98      =E2=94=94=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98   =E2=94=94=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=98   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=82  =
     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=98
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98           =20

In this case the mac chip forwards (in hw) the WAN traffic to the DSA switch
via the CPU port. In [0] we have the EN7581 mac chip architecture where we
can assume GDM1 is the CPU port and GDM2 is the WAN port.
The goal of this RFC series is to offload a Qdisc rule (e.g. ETS) on a given
LAN port using the mac chip QoS capabilities instead of creating the QoS
discipline directly in the DSA hw switch:

$tc qdisc replace dev lan0 root handle 1: ets bands 8 strict 2 quanta 1514 =
1514 1514 3528 1514 1514

As described above the reason for this approach would be to rely on the more
fine grained QoS capabilities available on the mac chip with respect to the
hw switch or because the DSA switch does not support QoS offloading.

Regards,
Lorenzo

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D23020f04932701d5c8363e60756f12b43b8ed752

--Tv/j4zy2xt/BHBs/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ1qqrQAKCRA6cBh0uS2t
rMQiAP9CQXoTGBbDoUzsoN2crcTuqAUZdey81BsKhZ6SLYsnMgD8D9bjqcSSy/mi
Q6siFo9ni1K0GzQ0awTDoQoXVZRBMQ8=
=WNB4
-----END PGP SIGNATURE-----

--Tv/j4zy2xt/BHBs/--

