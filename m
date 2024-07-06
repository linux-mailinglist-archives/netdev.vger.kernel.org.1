Return-Path: <netdev+bounces-109609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5910D9291CF
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 10:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0721F21D5E
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 08:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F85831758;
	Sat,  6 Jul 2024 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtSa2tiw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713D1CAB3;
	Sat,  6 Jul 2024 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254425; cv=none; b=iDSk/1sj3TgMemFVzubRYD3pAxxYtn6STEHC55V+spVFjZL3E8trbs4rmbvvkNrlL1AeaUXra5JAeDwF7fuGV6ITaQNQlHEZ+wJ5h1Gn0UhLdQRCkEUtgf/Wy6lUiL9qxG6JvzDRJfnVvdL4A8a+60rRYeDUj17tBRUR1N+VOSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254425; c=relaxed/simple;
	bh=M6+fHN1AEi9CB+3l+2Srv46yNUZTmn7y+xxi7u1G4fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdy2oJO3gpDa9QyrMrnNGmk4A1N3hJu97hfP5Bq9F4SDeV2X/UAFQf1cSc7qlvLV2VuSinq4k/ThVRvIkoAw4H23gzjAKOZf3r9P+TYT+P83GUQh/dWbYogVqmCSrtzxjHcrzPIg47AMkCOzXyJ6Zx9voiVdUxrfGphjzitJXU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtSa2tiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA44C2BD10;
	Sat,  6 Jul 2024 08:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720254424;
	bh=M6+fHN1AEi9CB+3l+2Srv46yNUZTmn7y+xxi7u1G4fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtSa2tiwPeLWfiiIsg5HO6kEApmqDf3Q5LNMTeQIzzUV6rWjD70ZZ6e1rvgb+RY5Q
	 niHiq85LuDrpq4A3z0qPMMIjrtYivhNz61ofRNPu8WlOiKjkJfs3oihkeJ8V/hFPar
	 hQpX+KKBkHzy0Xb9g7UZBPcATlaNAu5Q8do54op5KLSfsBjTbVt0iIWGocBOGuMxk1
	 hNyYNgqGx4C3Cw2MP0KSzpbl/IulpkaYUN+ra1hY43X3Att0xp/wuQ4kLJ6mUfrcx0
	 BbMMHX9KzTjUj83nnj5ZeJvtvQ3jb0nMm/jHWFlJk4SDnlUMEyiKmpxPJQWQeaz41N
	 9rqqetqYjDmxg==
Date: Sat, 6 Jul 2024 10:27:00 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de
Subject: Re: [PATCH v5 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <Zoj_1JWfd_3Yu71t@lore-desk>
References: <cover.1720079772.git.lorenzo@kernel.org>
 <18e837f0f9377b68302d42ec9174473046a4a30a.1720079772.git.lorenzo@kernel.org>
 <20240705190644.GB1480790@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e9Qd3RQOvsLYnCSp"
Content-Disposition: inline
In-Reply-To: <20240705190644.GB1480790@kernel.org>


--e9Qd3RQOvsLYnCSp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jul 04, 2024 at 10:08:11AM +0200, Lorenzo Bianconi wrote:
> > Add airoha_eth driver in order to introduce ethernet support for
> > Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> > en7581-evb networking architecture is composed by airoha_eth as mac
> > controller (cpu port) and a mt7530 dsa based switch.
> > EN7581 mac controller is mainly composed by Frame Engine (FE) and
> > QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> > functionalities are supported now) while QDMA is used for DMA operation
> > and QOS functionalities between mac layer and the dsa switch (hw QoS is
> > not available yet and it will be added in the future).
> > Currently only hw lan features are available, hw wan will be added with
> > subsequent patches.
> >=20
> > Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> ...
>=20
> > +static const char * const airoha_ethtool_stats_name[] =3D {
> > +	"tx_eth_pkt_cnt",
> > +	"tx_eth_byte_cnt",
> > +	"tx_ok_pkt_cnt",
> > +	"tx_ok_byte_cnt",
> > +	"tx_eth_drop_cnt",
> > +	"tx_eth_bc_cnt",
> > +	"tx_eth_mc_cnt",
> > +	"tx_eth_lt64_cnt",
> > +	"tx_eth_eq64_cnt",
> > +	"tx_eth_65_127_cnt",
> > +	"tx_eth_128_255_cnt",
> > +	"tx_eth_256_511_cnt",
> > +	"tx_eth_512_1023_cnt",
> > +	"tx_eth_1024_1518_cnt",
> > +	"tx_eth_gt1518_cnt",
> > +	"rx_eth_pkt_cnt",
> > +	"rx_eth_byte_cnt",
> > +	"rx_ok_pkt_cnt",
> > +	"rx_ok_byte_cnt",
> > +	"rx_eth_drop_cnt",
> > +	"rx_eth_bc_cnt",
> > +	"rx_eth_mc_cnt",
> > +	"rx_eth_crc_drop_cnt",
> > +	"rx_eth_frag_cnt",
> > +	"rx_eth_jabber_cnt",
> > +	"rx_eth_lt64_cnt",
> > +	"rx_eth_eq64_cnt",
> > +	"rx_eth_65_127_cnt",
> > +	"rx_eth_128_255_cnt",
> > +	"rx_eth_256_511_cnt",
> > +	"rx_eth_512_1023_cnt",
> > +	"rx_eth_1024_1518_cnt",
> > +	"rx_eth_gt1518_cnt",
> > +};
>=20
> Hi Lorenzo,
>=20
> Sorry for not noticing this earlier.

Hi Simon,

no worries :)

> It seems to me that some of the stats above could
> use standard stats, which is preferred.

Please correct me if I am wrong but it seems quite a common approach to have
same stats in both .ndo_get_stats64() and .get_ethtool_stats():
- https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/mediat=
ek/mtk_eth_soc.c#L212
- https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/marvel=
l/mvneta.c#L435
- https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/intel/=
i40e/i40e_ethtool.c#L243
- https://github.com/torvalds/linux/blob/master/net/mac80211/ethtool.c#L52
- ...

Do you mean I should just report common stats (e.g. tx_packets or tx_bytes)=
 in
=2Endo_get_stats64()? Or it is fine to just add .ndo_get_stats64() callback=
 (not
supported at the moment)?

>=20
> Basically, my understanding is that one should:
> 1. Implement .ndo_get_stats64
>    (that seems relevant here)
> 2. As appropriate implement ethtool_stats non-extended stats operations
>    (perhaps not relevant here)

Can you please provide me a pointer for it?

Regards,
Lorenzo

> 3. Then implement get_ethtool_stats for what is left over
>=20
> ...

--e9Qd3RQOvsLYnCSp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZoj/1AAKCRA6cBh0uS2t
rMz9AP9MzbgdWOnzGFjTORujUuSSV71mqFBBnS1lDWiHLuAtMwD/SH5Wf6ceA5AJ
N9DYzOkkdoLeTRnlQD1UoFKyLsYeiA4=
=F08X
-----END PGP SIGNATURE-----

--e9Qd3RQOvsLYnCSp--

