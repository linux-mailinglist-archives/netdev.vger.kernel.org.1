Return-Path: <netdev+bounces-172704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD79BA55C2D
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74B53AA7F1
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC15D42069;
	Fri,  7 Mar 2025 00:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="iwmd/f2p"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BFF1E868;
	Fri,  7 Mar 2025 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308558; cv=pass; b=p2BW/yxj6UfPgIdsBPI4shgIZlaa3kCYT6CqkepLjnGxKRNr26xiT9cqTAV/W2vpauEV1hOG0K9J1pRNYGqe9HBewspXoLVM0YlanBX0HCFgLhjf6hcpls1YbPxlq6CwoFfNSRZhMgI73Xi38Vy8aPLkgaZ86omHQLJp+p0/V0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308558; c=relaxed/simple;
	bh=42U7Af1ep8K7CCAvElua7xVh8s6FrBQQIRLNKzy77Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH01ZQSMLQzmSR/EH+t3PTdohNwjzVuTN7iHWzmDGU3F0Ur04lxw+fxAcL6AFApdUy/loEF2fkVo/c/GhFwvxqSiXMp4esIQ7oo9cF54x7FzZanMo/ScRciN/5HgN9w+AFHKxov9p77Pitw6U7YATLgxpVja3ElBT0vkVWAiOuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=iwmd/f2p; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741308510; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fDBTJhinHdTlSpSH3MYpzEfEF6DFRAiHWSWw5JfeoHmjLxG7vVW6DxYj1F5mehhAH6VUa+v6uSuUIvxHCDzfzdmBJM9I9hbT5ZZHBl5AgsTdiiCVPCrL5Ez2VMyg1NcnS8UL9oUt42V0j+JiN71Gw+4uN8xhhFY4KFISFRymoio=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741308510; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h8rRhlaMIsLXodKw1Q1H9pitBk0/63QeWI3gE5xZArE=; 
	b=Jk/bUElkg2chwiMbrAOCtLc1UTwkUgR5f0CWK0bRUL0d9Zti0XPJMwQi1iHsXxODILH1zu/JA/wg1yvKWSN6CNC4gVNrG7spyHmwao7oZwrvRMhxEVimbPfmoiLgUW7N9T/Niixy5lpLpaZgMtOfKxbSk49YmVLoNHjnIKasR90=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741308510;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=h8rRhlaMIsLXodKw1Q1H9pitBk0/63QeWI3gE5xZArE=;
	b=iwmd/f2pIkqdP0YMHqbjz1g5Q7sh+sb2H3vrbiiGX4rWy0+2dXYeKzC7X3pqrcKY
	a/Jmie4G7MYI/1hkaz/uafpW98wzeXDMrfYf3NnxxpGORNujntMGGAQ4C5KXvsurwZL
	jV5YGtpNXrBNc5Cfet1/HMgaDgha/wh9uS6O5Ti4=
Received: by mx.zohomail.com with SMTPS id 1741308507900364.38915076979447;
	Thu, 6 Mar 2025 16:48:27 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 89085180CAC; Fri, 07 Mar 2025 01:48:22 +0100 (CET)
Date: Fri, 7 Mar 2025 01:48:22 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, David Wu <david.wu@rock-chips.com>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for
 RK3588
Message-ID: <7pzama5c5u2voshlkougczic3mnqn4ezotdaqyflcjtb6k7myh@6biehccwcizx>
References: <20250306203858.1677595-1-jonas@kwiboo.se>
 <20250306203858.1677595-4-jonas@kwiboo.se>
 <8323ba9aba1155004bcd201b4fd7b2fa@manjaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ki57npegzizchtuo"
Content-Disposition: inline
In-Reply-To: <8323ba9aba1155004bcd201b4fd7b2fa@manjaro.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/241.192.19
X-ZohoMailClient: External


--ki57npegzizchtuo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for
 RK3588
MIME-Version: 1.0

Hi,

On Thu, Mar 06, 2025 at 10:33:23PM +0100, Dragan Simic wrote:
> Hello Jonas,
>=20
> On 2025-03-06 21:38, Jonas Karlman wrote:
> > Support for Rockchip RK3588 GMAC was added without use of the
> > DELAY_ENABLE macro to assist with enable/disable use of MAC rx/tx delay.
> >=20
> > Change to use a variant of the DELAY_ENABLE macro to help disable MAC
> > delay when RGMII_ID/RXID/TXID is used.
> >=20
> > Fixes: 2f2b60a0ec28 ("net: ethernet: stmmac: dwmac-rk: Add gmac
> > support for rk3588")
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > index 37eb86e4e325..79db81d68afd 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > @@ -91,6 +91,10 @@ struct rk_priv_data {
> >  	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) |
> > \
> >  	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
> >=20
> > +#define DELAY_ENABLE_BY_ID(soc, tx, rx, id) \
> > +	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE(id) :
> > soc##_GMAC_TXCLK_DLY_DISABLE(id)) | \
> > +	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE(id) :
> > soc##_GMAC_RXCLK_DLY_DISABLE(id)))
> > +
> >  #define PX30_GRF_GMAC_CON1		0x0904
> >=20
> >  /* PX30_GRF_GMAC_CON1 */
> > @@ -1322,8 +1326,7 @@ static void rk3588_set_to_rgmii(struct
> > rk_priv_data *bsp_priv,
> >  		     RK3588_GMAC_CLK_RGMII_MODE(id));
> >=20
> >  	regmap_write(bsp_priv->grf, RK3588_GRF_GMAC_CON7,
> > -		     RK3588_GMAC_RXCLK_DLY_ENABLE(id) |
> > -		     RK3588_GMAC_TXCLK_DLY_ENABLE(id));
> > +		     DELAY_ENABLE_BY_ID(RK3588, tx_delay, rx_delay, id));
> >=20
> >  	regmap_write(bsp_priv->grf, offset_con,
> >  		     RK3588_GMAC_CLK_RX_DL_CFG(rx_delay) |
>=20
> Thanks for this patch...  It's looking good to me, and good job
> spotting this issue!  Please, free to include:
>=20
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--ki57npegzizchtuo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfKQlIACgkQ2O7X88g7
+pqmUQ/+Pwe2OzjCoW17WKQbluD9itbsu6/qTK/72qQxcnuYYRWGr7jwxff62Xas
0ocMSrO7kTdcbgVUXF9oeURevU/kv0xvLaUK98zXfXAU3nDVDdZJcp9MHQV2e2lZ
U7SQkX+/SG5QWMJlQnj7ds73kZfSHBhXW5smWDt+r84OMSLOyWf1PgASH/WhP1MP
VMlp78mMl34DUh8cIKWywg0SlGeEETPd2QJgrLDQDBc4oYz2MMbNDU1+NkVc+bmb
30kGT/MbjUc/KfGwTK2P8l2JO8N3MuV16+0GLAU+CcGJyoMYPQEbz3lv+WW1ZDa5
hNAgydbYtgjqxJPtlJs2ywrF6aZeIcHSapMGDAuzqNkrauMVYNE0x1C40KTcrbT8
JEurU9KVGqiazUrNcFsrlqLBCSDok17GmJIsRXcaxIHiRVHkeEFawGUNCj71IX9A
MTPnOauFJmc4EDf8qwnEAQeLlWzahjsvt4eAHJHczr5Qjje4x4Gei6X49crQmkWb
Kmb0WlwJv1tNMRaluwCLHXSunGQd39WRJ9Ujl/JDpwwyi7xSBZikK2aLS9vtSW99
UzIAbnWaAT1qO90FqXjlnDcU1KZHR7GJjAMxz23KXRKAOdT+rViZ268aKTRf23HM
5pFgSMuptSxKMkBdUa/+SCYSo3+BRKI9M1xOoVWHlrqq4ZpCxQU=
=L1gX
-----END PGP SIGNATURE-----

--ki57npegzizchtuo--

