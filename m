Return-Path: <netdev+bounces-34548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6437A496B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 14:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA53E281E8B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085B51CAB2;
	Mon, 18 Sep 2023 12:18:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97DF14AA2;
	Mon, 18 Sep 2023 12:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1522FC433C8;
	Mon, 18 Sep 2023 12:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695039481;
	bh=m9DbiuYGQsroUWLQblr7CsaQDo+/wfuOspyhyKz0qyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixfkDgtCQsm1qsYVqsBxRnfw76vgvheO6lwjFgfn6yxbF1012FTJgSRtZNnZm9HtZ
	 4m5ZtvRHN9RGP1wKU7Hn1MXf24+TdVfzsIjeOTMTEExl9Fa0vOXItABeWuxQ9u24mi
	 agRFmL0GEnQFdbR/pseV8rfJPLy+NoUqV6ssEfWZKA3cFDIHctiWLHv7lhuJeJnFQE
	 FHIrFg4UOzp52+93c1JZGyVcgGxybgyuDCxzAZ/BliNVDAGeVu/Cvs1P3l4Ws+snKi
	 7j3hgHBSMatEGojj76inqNh04Xdsb+CgGVApVD6JS7+aPytlTNtmhPjNFSyYcmbkeZ
	 dEtHAChXA7kxQ==
Date: Mon, 18 Sep 2023 14:17:58 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-mediatek@lists.infradead.org,
	sujuan.chen@mediatek.com, horms@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 09/17] net: ethernet: mtk_wed: fix
 EXT_INT_STATUS_RX_FBUF definitions for MT7986 SoC
Message-ID: <ZQg/9ku0S+g5WF0O@lore-desk>
References: <cover.1695032290.git.lorenzo@kernel.org>
 <ebde071cc3cc9c35b00366c41912ee2f25e5282d.1695032291.git.lorenzo@kernel.org>
 <ZQg2AxAIxkadOiIr@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3XwjkoR69/2cL2MM"
Content-Disposition: inline
In-Reply-To: <ZQg2AxAIxkadOiIr@makrotopia.org>


--3XwjkoR69/2cL2MM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Sep 18, 2023 at 12:29:11PM +0200, Lorenzo Bianconi wrote:
> > Fix MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH and
> > MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH definitions for MT7986 (MT7986 is
> > the only SoC to use them).
>=20
> Afaik this applies also to MT7981 which is very similar to MT7986.

ack, fine. Can you please test it out when you have some free cycles?
I do not have a MT7981 device for testing.

Regards,
Lorenzo

>=20
> >=20
> > Fixes: de84a090d99a ("net: ethernet: mtk_eth_wed: add wed support for m=
t7986 chipset")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/mediatek/mtk_wed_regs.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/mediatek/mtk_wed_regs.h b/drivers/net=
/ethernet/mediatek/mtk_wed_regs.h
> > index 47ea69feb3b2..f87ab9b8a590 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_wed_regs.h
> > +++ b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
> > @@ -64,8 +64,8 @@ struct mtk_wdma_desc {
> >  #define MTK_WED_EXT_INT_STATUS_TKID_TITO_INVALID	BIT(4)
> >  #define MTK_WED_EXT_INT_STATUS_TX_FBUF_LO_TH		BIT(8)
> >  #define MTK_WED_EXT_INT_STATUS_TX_FBUF_HI_TH		BIT(9)
> > -#define MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH		BIT(12)
> > -#define MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH		BIT(13)
> > +#define MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH		BIT(10) /* wed v2 */
> > +#define MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH		BIT(11) /* wed v2 */
> >  #define MTK_WED_EXT_INT_STATUS_RX_DRV_R_RESP_ERR	BIT(16)
> >  #define MTK_WED_EXT_INT_STATUS_RX_DRV_W_RESP_ERR	BIT(17)
> >  #define MTK_WED_EXT_INT_STATUS_RX_DRV_COHERENT		BIT(18)
> > --=20
> > 2.41.0
> >=20
> >=20

--3XwjkoR69/2cL2MM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQg/9QAKCRA6cBh0uS2t
rMYuAPwLlBwabmv9CBuoMVQSW6yos/0jwMwqx2hC30mstqMXugD/SkmJjYrTRWsA
7Wg219Zkui+ubUI3KZoNdXylN5X8FAw=
=C28k
-----END PGP SIGNATURE-----

--3XwjkoR69/2cL2MM--

