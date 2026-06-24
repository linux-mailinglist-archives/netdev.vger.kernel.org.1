Return-Path: <netdev+bounces-301622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i6VKKrzEO2qGcggAu9opvQ
	(envelope-from <netdev+bounces-301622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:51:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 156466BDD7D
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:51:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=u+3l0513;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301622-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301622-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22CA0301AF66
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E73D2DE70D;
	Wed, 24 Jun 2026 11:49:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56D12BEC23;
	Wed, 24 Jun 2026 11:49:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301773; cv=none; b=gcdvLGWyzUs1Pum9tdo7UNAQ0CgZO8YWggUyNqHlcCmA5TGLL7bKf1ZcIpZH2lWt559hJQuq5omT2U5xmeIwo3A717kbE0xTN6HbCTuafbILKx0iBn0PzXElfoHJjtw3jV3fz0JGnTfO9TfSeJRCNACtOJPIQmcag14c9mPIIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301773; c=relaxed/simple;
	bh=E/ImSLy7jJaMVOaE3RQWylfqWJnVklT0sXN0c/qXP5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDAA1QtGIurfnL0DjaeyHohGdtlxkSzPCW0mqFyDp4Nvrgfqnz9zFh+2HySL1SksypxpU2IPYuIBnVXUoTEKnbSTz/9OE7WCFlUdnZVRmdG8h2o1ZDBs2XpymTdJ942EtTyuA+MCXQQxxPGl3qsWJzp2itI8FU/w8Qe9HQFWrNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=u+3l0513; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Js+56ANKxPxs/46/PFzp/qZpp2mD0OpgfX8pfIomZwQ=; b=u+3l0513/jiVxcbyjkOiqN809G
	2FAxCcySH/27vGu51RIwGdzd7RdgsJzIElKLg5bvVdTYm5QR7ZuKjBe569yP2AMIi8NDorLSrXCjl
	+8EQngoG7F2CYbr6uBNs0PzsaEvGa9M3L/unrNeyXQxmck47zQB5//XBCQVNNSKWassX+h8GXcbom
	NU74uh7PQGCZvPUQD5k+n1KOp0Aho5ASE8t9dsdQQif1MKnvK5F70scLZSG1ntG+48DX0PbLuGVah
	7w2yjr982EGHwzmGmO/raYZ8htGjQmOSy4ovTLsfZepdyc6fOdag4SZtfNmsLJd5cYO1RBg8Il9Nr
	N4iyrrhQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Wu <david.wu@rock-chips.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Yanan He <grumpycat921013@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Yanan He <grumpycat921013@gmail.com>
Subject: Re: [PATCH 4/7] net: stmmac: dwmac-rk: Enable refout clock for RGMII
Date: Wed, 24 Jun 2026 13:49:12 +0200
Message-ID: <4954560.rnE6jSC6OK@diego>
In-Reply-To: <20260624-rv1126-alientek-dlrv1126-v1-4-5aef608a3f64@gmail.com>
References:
 <20260624-rv1126-alientek-dlrv1126-v1-0-5aef608a3f64@gmail.com>
 <20260624-rv1126-alientek-dlrv1126-v1-4-5aef608a3f64@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.wu@rock-chips.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:grumpycat921013@gmail.com,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301622-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[heiko@sntech.de,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,rock-chips.com,gmail.com,foss.st.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[sntech.de:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,diego:mid,vger.kernel.org:from_smtp,sntech.de:dkim,sntech.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 156466BDD7D

Hi,

Am Mittwoch, 24. Juni 2026, 10:44:41 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Yanan He:
> Some Rockchip GMAC integrations use clk_mac_refout as an external PHY
> reference clock even when the MAC is configured for RGMII.
>=20
> RV1126 boards can route CLK_GMAC_ETHERNET_OUT to the external PHY as a
> 25 MHz reference clock. If the driver does not acquire and enable this
> clock in RGMII mode, the common clock framework may disable it as unused
> and the PHY can lose its reference clock.
>=20
> Enable the refout clock handling for RGMII in addition to RMII.

the clock your referencing is not limited to your rv1126 but instead
present on most (all?) Rockchip SoCs.

And it is an input clock for the phy itself, so should be handled there.

See for example
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi#n313
as a reference.


Heiko

> Signed-off-by: Yanan He <grumpycat921013@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net=
/ethernet/stmicro/stmmac/dwmac-rk.c
> index 8d7042e68926..f6fdc0c5b475 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1112,7 +1112,8 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_=
data *plat)
>  	bsp_priv->clk_enabled =3D false;
> =20
>  	bsp_priv->num_clks =3D ARRAY_SIZE(rk_clocks);
> -	if (phy_iface =3D=3D PHY_INTERFACE_MODE_RMII)
> +	if (phy_iface =3D=3D PHY_INTERFACE_MODE_RMII ||
> +	    phy_iface =3D=3D PHY_INTERFACE_MODE_RGMII)
>  		bsp_priv->num_clks +=3D ARRAY_SIZE(rk_rmii_clocks);
> =20
>  	bsp_priv->clks =3D devm_kcalloc(dev, bsp_priv->num_clks,
> @@ -1123,7 +1124,8 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_=
data *plat)
>  	for (i =3D 0; i < ARRAY_SIZE(rk_clocks); i++)
>  		bsp_priv->clks[i].id =3D rk_clocks[i];
> =20
> -	if (phy_iface =3D=3D PHY_INTERFACE_MODE_RMII) {
> +	if (phy_iface =3D=3D PHY_INTERFACE_MODE_RMII ||
> +	    phy_iface =3D=3D PHY_INTERFACE_MODE_RGMII) {
>  		for (j =3D 0; j < ARRAY_SIZE(rk_rmii_clocks); j++)
>  			bsp_priv->clks[i++].id =3D rk_rmii_clocks[j];
>  	}
>=20
>=20





