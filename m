Return-Path: <netdev+bounces-109625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784479293AC
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 14:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007881F21B7E
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 12:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD574070;
	Sat,  6 Jul 2024 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL1PmJgB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3584D8BD;
	Sat,  6 Jul 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720270689; cv=none; b=hSOwUyiKV/AR2FXOY1ZN7DEFcDn/zHsOKqD8MVucVcdLwlWXNVSBaL1HUvQoEPZu9sDKeq9HFiaLFxIVaxn/oULxn4waee1FVo+Ajs5rmFjt2C65dD36MZx+4/0LR86cBcGkkZWjq2Lf8191nAdLd8kKMbM/4E/kztGmwYIZZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720270689; c=relaxed/simple;
	bh=4i+n6jLTfRQb5qAWWBPB966ZtbRLERn012w742IXk4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6cf7l6dj5e2T6l1qVnnFa/VJCd8ZGpirmGxWLpqzB7Aw2+WxWC95b7mevrM1WvrWCM3qK9a8hLmHjjl/FkqzLZOzDtIZruWr1kn9BS7b96As9Or9FqjOL2EJhr6F2OpxzUfSZ6XgGxSp4CE0sBRdET+oqqukLlIE9ftK7L3yGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL1PmJgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B385C3277B;
	Sat,  6 Jul 2024 12:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720270688;
	bh=4i+n6jLTfRQb5qAWWBPB966ZtbRLERn012w742IXk4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JL1PmJgBQEE+L1HdW7mi2M0tjGNixcBcuePxq+x3oZLpJfaGQMfoIJO2Q83eBpYzr
	 KPgSohB7RUP5i4ejkTHwddzZdV9jW9Uq6CP7k6+bTVGKi7407HBJ2sLX8VX519Mr60
	 zO8vRBYBv0byZjPb4s3RRltqAZa6/o9k5glB9BkBdhCRTlCzGwORKB1seUqfUoArBC
	 dzkE5GjbCHdnh8uhFU8SL6dWqL0G1rrGJwFpT3Xek8tuAERNsZ2kT8j9CYtUCXFoFb
	 jXP6icGtm/S89mpvAIzLbH7FsGtriEbv7+T6uCClkJ99lCw75I61xLgywpJl+HdQk4
	 9x4A1FEjohzdA==
Date: Sat, 6 Jul 2024 14:58:04 +0200
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
Message-ID: <Zok_XOR7lVtfdhjc@lore-desk>
References: <cover.1720079772.git.lorenzo@kernel.org>
 <18e837f0f9377b68302d42ec9174473046a4a30a.1720079772.git.lorenzo@kernel.org>
 <20240705190644.GB1480790@kernel.org>
 <Zoj_1JWfd_3Yu71t@lore-desk>
 <20240706122754.GD1481495@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="27jVVEXjJPrb9d+/"
Content-Disposition: inline
In-Reply-To: <20240706122754.GD1481495@kernel.org>


--27jVVEXjJPrb9d+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, Jul 06, 2024 at 10:27:00AM +0200, Lorenzo Bianconi wrote:
> > > On Thu, Jul 04, 2024 at 10:08:11AM +0200, Lorenzo Bianconi wrote:
> > > > Add airoha_eth driver in order to introduce ethernet support for
> > > > Airoha EN7581 SoC available on EN7581 development board (en7581-evb=
).
> > > > en7581-evb networking architecture is composed by airoha_eth as mac
> > > > controller (cpu port) and a mt7530 dsa based switch.
> > > > EN7581 mac controller is mainly composed by Frame Engine (FE) and
> > > > QoS-DMA (QDMA) modules. FE is used for traffic offloading (just bas=
ic
> > > > functionalities are supported now) while QDMA is used for DMA opera=
tion
> > > > and QOS functionalities between mac layer and the dsa switch (hw Qo=
S is
> > > > not available yet and it will be added in the future).
> > > > Currently only hw lan features are available, hw wan will be added =
with
> > > > subsequent patches.
> > > >=20
> > > > Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > >=20
> > > ...
> > >=20
> > > > +static const char * const airoha_ethtool_stats_name[] =3D {
> > > > +	"tx_eth_pkt_cnt",
> > > > +	"tx_eth_byte_cnt",
> > > > +	"tx_ok_pkt_cnt",
> > > > +	"tx_ok_byte_cnt",
> > > > +	"tx_eth_drop_cnt",
> > > > +	"tx_eth_bc_cnt",
> > > > +	"tx_eth_mc_cnt",
> > > > +	"tx_eth_lt64_cnt",
> > > > +	"tx_eth_eq64_cnt",
> > > > +	"tx_eth_65_127_cnt",
> > > > +	"tx_eth_128_255_cnt",
> > > > +	"tx_eth_256_511_cnt",
> > > > +	"tx_eth_512_1023_cnt",
> > > > +	"tx_eth_1024_1518_cnt",
> > > > +	"tx_eth_gt1518_cnt",
> > > > +	"rx_eth_pkt_cnt",
> > > > +	"rx_eth_byte_cnt",
> > > > +	"rx_ok_pkt_cnt",
> > > > +	"rx_ok_byte_cnt",
> > > > +	"rx_eth_drop_cnt",
> > > > +	"rx_eth_bc_cnt",
> > > > +	"rx_eth_mc_cnt",
> > > > +	"rx_eth_crc_drop_cnt",
> > > > +	"rx_eth_frag_cnt",
> > > > +	"rx_eth_jabber_cnt",
> > > > +	"rx_eth_lt64_cnt",
> > > > +	"rx_eth_eq64_cnt",
> > > > +	"rx_eth_65_127_cnt",
> > > > +	"rx_eth_128_255_cnt",
> > > > +	"rx_eth_256_511_cnt",
> > > > +	"rx_eth_512_1023_cnt",
> > > > +	"rx_eth_1024_1518_cnt",
> > > > +	"rx_eth_gt1518_cnt",
> > > > +};
> > >=20
> > > Hi Lorenzo,
> > >=20
> > > Sorry for not noticing this earlier.
> >=20
> > Hi Simon,
> >=20
> > no worries :)
> >=20
> > > It seems to me that some of the stats above could
> > > use standard stats, which is preferred.
> >=20
> > Please correct me if I am wrong but it seems quite a common approach to=
 have
> > same stats in both .ndo_get_stats64() and .get_ethtool_stats():
> > - https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/me=
diatek/mtk_eth_soc.c#L212
> > - https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/ma=
rvell/mvneta.c#L435
> > - https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/in=
tel/i40e/i40e_ethtool.c#L243
> > - https://github.com/torvalds/linux/blob/master/net/mac80211/ethtool.c#=
L52
> > - ...
> >=20
> > Do you mean I should just report common stats (e.g. tx_packets or tx_by=
tes) in
> > .ndo_get_stats64()? Or it is fine to just add .ndo_get_stats64() callba=
ck (not
> > supported at the moment)?
>=20
> The first option: It is my understanding that it preferred to only
> report common stats via ndo_get_stats64.
>=20
>   "Please limit stats you report in ethtool -S to just the stats for which
>    proper interfaces don't exist. Don't duplicate what's already reported
>    via rtase_get_stats64(), also take a look at what can be reported via
>    various *_stats members of struct ethtool_ops."
>=20
>    - Re: [PATCH net-next v18 10/13] rtase: Implement ethtool function
>      by Jakub Kicinski
>      https://lore.kernel.org/netdev/20240509204047.149e226e@kernel.org/

ack, thx for the clarification. I will move common stats in ndo_get_stats64=
()
in v6.

Regards,
Lorenzo

>=20
> > > Basically, my understanding is that one should:
> > > 1. Implement .ndo_get_stats64
> > >    (that seems relevant here)
> > > 2. As appropriate implement ethtool_stats non-extended stats operatio=
ns
> > >    (perhaps not relevant here)
> >=20
> > Can you please provide me a pointer for it?
>=20
> Sorry, that was not at all clear.
> I meant, as per the quote above, *_stats members of struct ethtool_ops,
> other than those that implement extended ops.
> e.g. get_rmon_stats.
>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > > 3. Then implement get_ethtool_stats for what is left over
> > >=20
> > > ...
>=20
>=20

--27jVVEXjJPrb9d+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZok/XAAKCRA6cBh0uS2t
rJsvAQDWPekAHROreseCbMT+1YpFHd0F30QgDgH1589HPspJ1QEAhbBE4UYjpZkr
oldsh7UQ+AykBLlnzqmMoEmvhnuvrA8=
=KxMj
-----END PGP SIGNATURE-----

--27jVVEXjJPrb9d+/--

