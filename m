Return-Path: <netdev+bounces-19646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67AC75B8EA
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 22:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7266E281007
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C8416423;
	Thu, 20 Jul 2023 20:52:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E01C2FA49
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 20:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81043C433C7;
	Thu, 20 Jul 2023 20:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689886338;
	bh=UxGwxR77oDUi0eZO3nUPcraerqA/TaNQvteyP7A0288=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jX32jpfnzZ3fz04Y2nT0wBDqOu2VwNy5LlfLtzLpbN4M4ZcQHwaut/yV6gL1C+C9J
	 g3Gplo8foH8KVIC1bh/xAVZUon8Zo7+PFTrL5F0S+sXVMAzqy+6MevbywhhVsqB4GT
	 u0ys1gpczpuIPMIPNYJf+F5LQVP+3kLWcTH6foB8+JEFkzgJOWdhbxrZPmoyYbOMJs
	 iYOVr4zVLyVWOxcaUyEfl7NJiSc3ZAsRz7U/S1BKY0gWtWxEotj4DYJLDkcnytR90h
	 5IQNe0Rm6pGKlI4/oP40kvejT01JHLPg9UZNeOZd84ytNlO8mDy2z2x13TnLIYgAbp
	 nFdfzF83GgiJw==
Date: Thu, 20 Jul 2023 22:52:15 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <simon.horman@corigine.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name, john@phrozen.org,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi@redhat.com, daniel@makrotopia.org
Subject: Re: [PATCH net-next] net: ethernet: mtk_ppe: add
 MTK_FOE_ENTRY_V{1,2}_SIZE macros
Message-ID: <ZLmefyZCTwbXtZ/i@lore-desk>
References: <725aa4b427e8ae2384ff1c8a32111fb24ceda231.1689762482.git.lorenzo@kernel.org>
 <ZLl1Le1JiuoC8DIc@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K3AdvKtYZdlY1R1M"
Content-Disposition: inline
In-Reply-To: <ZLl1Le1JiuoC8DIc@corigine.com>


--K3AdvKtYZdlY1R1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jul 19, 2023 at 12:29:49PM +0200, Lorenzo Bianconi wrote:
> > Introduce MTK_FOE_ENTRY_V{1,2}_SIZE macros in order to make more
> > explicit foe_entry size for different chipset revisions.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 10 +++++-----
> >  drivers/net/ethernet/mediatek/mtk_ppe.h     |  3 +++
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/=
ethernet/mediatek/mtk_eth_soc.c
> > index 834c644b67db..7f9e23ddb3c4 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > @@ -4811,7 +4811,7 @@ static const struct mtk_soc_data mt7621_data =3D {
> >  	.required_pctl =3D false,
> >  	.offload_version =3D 1,
> >  	.hash_offset =3D 2,
> > -	.foe_entry_size =3D sizeof(struct mtk_foe_entry) - 16,
> > +	.foe_entry_size =3D MTK_FOE_ENTRY_V1_SIZE,
> >  	.txrx =3D {
> >  		.txd_size =3D sizeof(struct mtk_tx_dma),
> >  		.rxd_size =3D sizeof(struct mtk_rx_dma),
>=20
> ...
>=20
> > @@ -4889,8 +4889,8 @@ static const struct mtk_soc_data mt7981_data =3D {
> >  	.required_pctl =3D false,
> >  	.offload_version =3D 2,
> >  	.hash_offset =3D 4,
> > -	.foe_entry_size =3D sizeof(struct mtk_foe_entry),
> >  	.has_accounting =3D true,
> > +	.foe_entry_size =3D MTK_FOE_ENTRY_V2_SIZE,
> >  	.txrx =3D {
> >  		.txd_size =3D sizeof(struct mtk_tx_dma_v2),
> >  		.rxd_size =3D sizeof(struct mtk_rx_dma_v2),
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.h b/drivers/net/ethe=
rnet/mediatek/mtk_ppe.h
> > index e51de31a52ec..fb6bf58172d9 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_ppe.h
> > +++ b/drivers/net/ethernet/mediatek/mtk_ppe.h
> > @@ -216,6 +216,9 @@ struct mtk_foe_ipv6_6rd {
> >  	struct mtk_foe_mac_info l2;
> >  };
> > =20
> > +#define MTK_FOE_ENTRY_V1_SIZE	80
> > +#define MTK_FOE_ENTRY_V2_SIZE	96
>=20
> Hi Lorenzo,
>=20
> Would it make sense to define these in terms of sizeof(struct mtk_foe_ent=
ry) ?
>=20

Hi Simon,

I was discussing with Felix to have something like:

struct mtk_foe_entry_v1 {
	u32 data[19];
};

struct mtk_foe_entry_v2 {
	u32 data[23];
};

struct mtk_foe_entry {
	u32 ib1;

	union {
		...
		struct mtk_foe_entry_v1 e;
		struct mtk_foe_entry_v2 e2;
	};
};

and then relying on sizeof of struct mtk_foe_entry_v1/mtk_foe_entry_v2
but then we decided to have a simpler approach. What do you think?

Regards,
Lorenzo

> ...

--K3AdvKtYZdlY1R1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZLmefwAKCRA6cBh0uS2t
rG0lAQDv2W76VZ71tQNQyh0SOeRn0GEcmHfDRMAjZE9vkRGnsQD+ND8ptbTHXW8o
LzS3Dx+XQYXE0W2zRy1ooHAWKyxi4AU=
=R2Lr
-----END PGP SIGNATURE-----

--K3AdvKtYZdlY1R1M--

