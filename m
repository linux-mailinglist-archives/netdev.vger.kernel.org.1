Return-Path: <netdev+bounces-178370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE19A76C4E
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A356B16B66F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC29D214810;
	Mon, 31 Mar 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="terbX22X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60052135DE
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743440178; cv=none; b=g5tqXURxh/1esgUBAUXdBgKlTFHap0U4jLMTeJPA6GW3Ce1UrfZJIrHpKKv2x/kD5MG6cFeNRMVxXd6+nGx5jNvntFYDbt3NKYKNXq41DEXfwPpvurczke1drhDTunrP0Vku49+JTglYSM83T42IusxmvG4SJo2tqkhPw00DmUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743440178; c=relaxed/simple;
	bh=RZ7ydlQ9XRAWxzYa5+iA1hQqe+NZFUE7I2l0BCYJgCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzSFBCuwTTOHfsbcG2+uKrlv8nBltXFtOqgExxDmFpYSYnUi1DAInWh3xhEpgmbf2T4kL5R/3EwJu64iS8G7z4rqs6864YnMrchQh38I0dLqZ30uBUKs7tdG381YjHWRALsJbBf9zpS1K0YYnlR3SOE6PFj5BwfOTmJKa8LaPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=terbX22X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADC5C4CEE3;
	Mon, 31 Mar 2025 16:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743440178;
	bh=RZ7ydlQ9XRAWxzYa5+iA1hQqe+NZFUE7I2l0BCYJgCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=terbX22XrdWsmwWJcCJsBDj96OmRLwPQatsCyXk1qHgBE6Txepzq0rO1Lx89VgXEm
	 TRMu4Zqw9868jJB2dCSfP5UC4T43DuAqaBq0TwPnLapSe4yWAWi98f/OBWb+6moLQm
	 7quxX76j24MJeVyz0LYs1jQM+9l91Hch+GXORhc9BhLUq2PyF7uAz68ttWqZka/SAU
	 iFSyH4YAZwOh7wdvamYbmTDG1XqQASi2nDwB3vy12pGunM72DKNC70qLtoTbb/Pg/k
	 tosUcwA+DlGb7uAqLmoDqaQbnmEdizGatyP8nM2H/NxITRLtuAtxEYmeqfDD2zG5HS
	 Z2r/nlam5hehQ==
Date: Mon, 31 Mar 2025 18:56:15 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v3] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
Message-ID: <Z-rJL6oFZa5jpjlo@lore-desk>
References: <20250331-airoha-validate-egress-gdm-port-v3-1-c14e6ba9733a@kernel.org>
 <20250331162841.GD185681@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WLQ37arbkRhRFFOB"
Content-Disposition: inline
In-Reply-To: <20250331162841.GD185681@horms.kernel.org>


--WLQ37arbkRhRFFOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Mar 31, 2025 at 12:14:09PM +0200, Lorenzo Bianconi wrote:
> > Device pointer in airoha_ppe_foe_entry_prepare routine is not strictly
> > necessary a device allocated by airoha_eth driver since it is an egress
>=20
> nit: I think it would be clearer if "necessary" was dropped from the line
>      above.

ack, I will fix it in v4.

>=20
> > device and the flowtable can contain even wlan, pppoe or vlan devices.
> > E.g:
> >=20
> > flowtable ft {
> >         hook ingress priority filter
> >         devices =3D { eth1, lan1, lan2, lan3, lan4, wlan0 }
> >         flags offload                               ^
> >                                                     |
> >                      "not allocated by airoha_eth" --
> > }
> >=20
> > In this case airoha_get_dsa_port() will just return the original device
> > pointer and we can't assume netdev priv pointer points to an
> > airoha_gdm_port struct.
> > Fix the issue validating egress gdm port in airoha_ppe_foe_entry_prepare
> > routine before accessing net_device priv pointer.
> >=20
> > Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes in v3:
> > - Rebase on top of net tree
> > - Fix commit log
> > - Link to v2: https://lore.kernel.org/r/20250315-airoha-flowtable-null-=
ptr-fix-v2-1-94b923d30234@kernel.org
> >=20
> > Changes in v2:
> > - Avoid checking netdev_priv pointer since it is always not NULL
> > - Link to v1: https://lore.kernel.org/r/20250312-airoha-flowtable-null-=
ptr-fix-v1-1-6363fab884d0@kernel.org
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c | 13 +++++++++++++
> >  drivers/net/ethernet/airoha/airoha_eth.h |  3 +++
> >  drivers/net/ethernet/airoha/airoha_ppe.c | 10 ++++++++--
> >  3 files changed, 24 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index c0a642568ac115ea9df6fbaf7133627a4405a36c..bf9c882e9c8b087dbf5e907=
636547a0117d1b96a 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -2454,6 +2454,19 @@ static void airoha_metadata_dst_free(struct airo=
ha_gdm_port *port)
> >  	}
> >  }
> > =20
> > +int airoha_is_valid_gdm_port(struct airoha_eth *eth,
> > +			     struct airoha_gdm_port *port)
>=20
> nit: given the name of the function, perhaps returning a bool is more
>      appropriate.

ack, I will fix it in v4.

Regards,
Lorenzo

>=20
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> > +		if (eth->ports[i] =3D=3D port)
> > +			return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
>=20
> ...

--WLQ37arbkRhRFFOB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ+rJLwAKCRA6cBh0uS2t
rBLSAP9UEa4AlC0xp38CK2U7eV98AhByHX1GfKqwttBsg5mJQAEAvkLibzEGjviY
QH1WrF5Qi0JosMaranAOU2y7FBUcGwc=
=51Xz
-----END PGP SIGNATURE-----

--WLQ37arbkRhRFFOB--

