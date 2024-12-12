Return-Path: <netdev+bounces-151452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131E79EF413
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB44228D59B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AFD223E60;
	Thu, 12 Dec 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPa/VqaS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0A62153DD
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022991; cv=none; b=lRrdP/gyLZqpUpQN6/qKV0U3bG9KFTnC9UvOrWeCGwmIa0j9PBL+Lh2gl0iebcamtbhktn2Vap13/RhEzw7GHhmR0BR6Tj/rqfQWzIs8gldyZ8BiMHGicPYG3LQwvbBeddraJvBdTOKKzeG4JMWYEbvlTQ4di2uUWGfgi2iwP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022991; c=relaxed/simple;
	bh=ToREWe4352M/z5GPHP7r8yDcvtRtOz+lPIMoKFtlTb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GE5nULMLuvSmSv7zYBFxa1NZBrGIGzYgxlFc+7Ryr7kXIX06o5HiFYUGziE07axKwzZkvWHrNOGAB0Jt3E9ScPiGu5ysPwOGoL89+6Y3InOhdEtR2SYWO5FPEULNRachUGWxDqzChle8AEK18mqXNXeihJ0wEYEB3cIajM5qmgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPa/VqaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA01C4CECE;
	Thu, 12 Dec 2024 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734022991;
	bh=ToREWe4352M/z5GPHP7r8yDcvtRtOz+lPIMoKFtlTb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MPa/VqaSv61QtIxKlmN5WdbfzdyJFPWs0aqpD4eNUf0Qxmlz8WCa7B7Fgjoq4DMTQ
	 8BxSNBFYsfhcZc0lBKJh5tV5XDJh0adH4rzKnyRJ63qN2Qlh3Jz0+tEWjS1LjbKRc3
	 gbnBGIWCh+ruReR39MLT+IyqWBgXuU4cVt2TW+O/nRcecH56gfrf4uQMSXWRPrSHM0
	 XU4II48dmQzGA7HayQl94u+atPT+LKzrO35aRhW7OzixlQbMZEVZ01H4bqjZWqJkEe
	 5rC//BIhNgrF3EZhjJBOwH9YHnsU820iR1euhbyilwN4zvTPV57eWBhnTR2xzwQnhY
	 1fLz2PFSkEyhQ==
Date: Thu, 12 Dec 2024 18:03:08 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <Z1sXTPeekJ5See_u@lore-desk>
References: <cover.1733930558.git.lorenzo@kernel.org>
 <20241211154109.dvkihluzdouhtamr@skbuf>
 <Z1qqrVWV84DBZuCn@lore-desk>
 <20241212150613.zhi3vbxuwsc3blui@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sB+GTkuP0EXgsnZH"
Content-Disposition: inline
In-Reply-To: <20241212150613.zhi3vbxuwsc3blui@skbuf>


--sB+GTkuP0EXgsnZH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Dec 12, Vladimir Oltean wrote:
> On Thu, Dec 12, 2024 at 10:19:41AM +0100, Lorenzo Bianconi wrote:
> > > Hi Lorenzo,
> >=20
> > Hi Vladimir,
> >=20
> > >=20
> > > On Wed, Dec 11, 2024 at 04:31:48PM +0100, Lorenzo Bianconi wrote:
> > > > Introduce support for ETS and TBF qdisc offload available in the Ai=
roha
> > > > EN7581 ethernet controller.
> > > > Some DSA hw switches do not support Qdisc offloading or the mac chip
> > > > has more fine grained QoS capabilities with respect to the hw switch
> > > > (e.g. Airoha EN7581 mac chip has more hw QoS and buffering capabili=
ties
> > > > with respect to the mt7530 switch).=20
> > > > Introduce ndo_setup_tc_conduit callback in order to allow tc to off=
load
> > > > Qdisc policies for the specified DSA user port configuring the hw s=
witch
> > > > cpu port (mac chip).
> > >=20
> > > Can you please make a detailed diagram explaining how is the conduit
> > > involved in the packet data path for QoS? Offloaded tc on a DSA user
> > > port is supposed to affect autonomously forwarded traffic too (like t=
he
> > > Linux bridge).
> >=20
> > I guess a typical use case would be the one below where the traffic fro=
m the
> > WAN port is forwarded to a DSA LAN one (e.g. lan0) via netfilter flowta=
ble
> > offload.
> >=20
> >             =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90            =20
> >             =E2=94=82               BR0               =E2=94=82        =
    =20
> >             =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=AC=E2=94=80=E2=94=80=E2=94=98            =20
> > =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=90           =
=20
> > =E2=94=82DSA            =E2=94=82        =E2=94=82        =E2=94=82    =
    =E2=94=82   =E2=94=82           =20
> > =E2=94=82               =E2=94=82        =E2=94=82        =E2=94=82    =
    =E2=94=82   =E2=94=82           =20
> > =E2=94=82 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=90      =E2=94=8C=
=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=90   =E2=94=8C=E2=94=80=E2=94=80=
=E2=96=BC=E2=94=80=E2=94=90   =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=
=E2=94=90   =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=90 =E2=94=
=82       =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> > =E2=94=82 =E2=94=82CPU=E2=94=82      =E2=94=82LAN0=E2=94=82   =E2=94=82=
LAN1=E2=94=82   =E2=94=82LAN2=E2=94=82   =E2=94=82LAN3=E2=94=82 =E2=94=82  =
     =E2=94=82WAN=E2=94=82
> > =E2=94=82 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=98      =E2=94=94=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98   =E2=94=94=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=98   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=
=82       =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> > =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98           =
=20
> >=20
> > In this case the mac chip forwards (in hw) the WAN traffic to the DSA s=
witch
> > via the CPU port. In [0] we have the EN7581 mac chip architecture where=
 we
> > can assume GDM1 is the CPU port and GDM2 is the WAN port.
> > The goal of this RFC series is to offload a Qdisc rule (e.g. ETS) on a =
given
> > LAN port using the mac chip QoS capabilities instead of creating the QoS
> > discipline directly in the DSA hw switch:
> >=20
> > $tc qdisc replace dev lan0 root handle 1: ets bands 8 strict 2 quanta 1=
514 1514 1514 3528 1514 1514
> >=20
> > As described above the reason for this approach would be to rely on the=
 more
> > fine grained QoS capabilities available on the mac chip with respect to=
 the
> > hw switch or because the DSA switch does not support QoS offloading.
> >=20
> > Regards,
> > Lorenzo
> >=20
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D23020f04932701d5c8363e60756f12b43b8ed752
>=20
> Explain "the mac chip forwards (in hw) the WAN traffic to the DSA switch
> via the CPU port". How many packets does airoha_dev_select_queue() see?
> All of them, or only the first of a flow? What operations does the
> offload consist of?

I am referring to the netfilter flowtable offload where the kernel receives
just the 3-way handshake of a TCP connection and then the traffic is fully
offloaded (the hw receives a flower rule to route the traffic between
interfaces applying NAT mangling if requested). Re-thinking about it,
I guess it is better to post flowtable support first and then continue
the discussion about QoS offloading, what do you think?

Regards,
Lorenzo

--sB+GTkuP0EXgsnZH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ1sXTAAKCRA6cBh0uS2t
rK7yAQDKkWSmMnRY1Y45RFqPYGqs1he0Eu0S8a5KMFyT8LN6aAEAmmrlmDlpvvBE
6GPUtdM8dyZnsC8GM0rgihJcNXPt5AE=
=iyn0
-----END PGP SIGNATURE-----

--sB+GTkuP0EXgsnZH--

