Return-Path: <netdev+bounces-104750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7740790E43C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F6F1F25652
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 07:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222A3763F1;
	Wed, 19 Jun 2024 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgmz0kaE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DCA7406B;
	Wed, 19 Jun 2024 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781599; cv=none; b=PQ1SoTk0kTVqJewV43uRBkj6V+5buqd99MxozlmVN0jvBZjYdtlakD22ybsPt+E6zZH7ouuisACF1gv5Vudkin0rSehaDaVcFcUUN5r2wPdubUjm+Xag5wyGK2qDeq3kBtzgq3RSXo96pFwBBEyn06BlwAZxZvLr8wOSaRA/kuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781599; c=relaxed/simple;
	bh=uvAP8y0qFZ/aHw0g4eIrWcQaH8P8vN+nnewkUnmZmDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8GculfUFM7b6toepXydj7TUSf2bBhCmah1xoJGKHAGexR6UXdF9AP2qv4a9lqJHAj0HyLXHvM9taKGOMkqilBPqSor28199M9EZ+pV29UoZ3gaY3Feh0arvaWwNA00iLWUGmESPTcklcR5iOquzmu3xiAYGw6gNJYXnShh7y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgmz0kaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE8DC2BBFC;
	Wed, 19 Jun 2024 07:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718781598;
	bh=uvAP8y0qFZ/aHw0g4eIrWcQaH8P8vN+nnewkUnmZmDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cgmz0kaEeOZuEssLsDyMfcaN0ptcozzDrcsnfWcgf3wYAKNsVFBx5ZDNpThkTv2KA
	 b7jiEVbZhMUj6mDw2w9PLcAWj7Ca7XNSkk3X1sbkO0On6eIs5lGepUf94wkGRHFPUc
	 UA+LykfhiCEMmzOEouz8JalKkzCKjULNZfQ2P/kXz2TbWIH6pLqrCldKRBR3B9HZt8
	 7u2pj0kE18Ug1gtRon8tLCUsFbleALWH97X/2HsbCk94JMrABH9MwzMyYvCc1A+hXf
	 XgBbIWyqELBZExF2gi28wKvclW67DpOiRvb4x8Zch/EZgknVFYVYSDJI/z9ayJXLxR
	 gLH8F11aOmVpQ==
Date: Wed, 19 Jun 2024 09:19:54 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, linux-clk@vger.kernel.org,
	rkannoth@marvell.com, sgoutham@marvell.com
Subject: Re: [PATCH v2 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <ZnKGmhVOPV-W2LWA@lore-desk>
References: <cover.1718696209.git.lorenzo@kernel.org>
 <f146a6f58492394a77f7d159f3c650a268fbe489.1718696209.git.lorenzo@kernel.org>
 <64b3c847-8674-4fdd-bbe6-8ea22410aa19@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t1JdaXAETMxshABh"
Content-Disposition: inline
In-Reply-To: <64b3c847-8674-4fdd-bbe6-8ea22410aa19@lunn.ch>


--t1JdaXAETMxshABh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +static void airoha_fe_maccr_init(struct airoha_eth *eth)
> > +{
>=20
> ...
>=20
> > +	airoha_fe_wr(eth, REG_FE_VIP_PATN(11), 0xc057); /* PPP->IPv6CP (0xc05=
7) */
>=20
> include/uapi/linux/ppp_defs.h
> #define PPP_IPV6CP      0x8057  /* IPv6 Control Protocol */
>=20
> Are these the same thing? Why is there one bit difference?

ack, I guess there is a typo here.

>=20
>=20
> > +	airoha_fe_wr(eth, REG_FE_VIP_PATN(17), 0x1ae0);
> > +	airoha_fe_wr(eth, REG_FE_VIP_EN(17),
> > +		     PATN_FCPU_EN_MASK | PATN_SP_EN_MASK |
> > +		     FIELD_PREP(PATN_TYPE_MASK, 3) | PATN_EN_MASK);
> > +
> > +	airoha_fe_wr(eth, REG_FE_VIP_PATN(18), 0x1ae00000);
> > +	airoha_fe_wr(eth, REG_FE_VIP_EN(18),
> > +		     PATN_FCPU_EN_MASK | PATN_DP_EN_MASK |
> > +		     FIELD_PREP(PATN_TYPE_MASK, 3) | PATN_EN_MASK);
>=20
> > +	airoha_fe_wr(eth, REG_FE_VIP_PATN(22), 0xaaaa);
>=20
> Please add a comment what these match.

ack, I will look into them.

>=20
> > +static int airoha_dev_change_mtu(struct net_device *dev, int new_mtu)
> > +{
> > +	dev->mtu =3D new_mtu;
> > +
> > +	return 0;
> > +}
> > +
>=20
> I don't think this is needed. Look at __dev_set_mtu().

ack, I will get rid of it in v3.

Regards,
Lorenzo

>=20
>     Andrew
>=20
> ---
> pw-bot: cr

--t1JdaXAETMxshABh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZnKGmgAKCRA6cBh0uS2t
rIRCAP9rbZZTIY9xE3nb018VxcdNZuvz5KU6xukpk2vKwOwztQD/fI0rjlWwYxHQ
kdo/7s1J7RCqUM5RlC+1sqpISnZ9KQU=
=0xov
-----END PGP SIGNATURE-----

--t1JdaXAETMxshABh--

