Return-Path: <netdev+bounces-33545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580479E720
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C58C1C210E5
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35D01EA7B;
	Wed, 13 Sep 2023 11:47:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909A1E526
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A91FC433C7;
	Wed, 13 Sep 2023 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694605672;
	bh=K77F3CEOKIf1niDjbmvFeG6tz2Wj4nd7Y8otxqHBtc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2e8wAmHRy9bIX3dNDyB5uiEeNTp6bHoGVwNm+qLAMDoLQUdMVV3DkeQz4YR/0pyQ
	 meRodZzDItSEFTznEOh+s/1BfuGNcTrONKmPU49wFloCWjmQHwN1ZqNYTYE1Wy65nV
	 NHSu8vWtOSaTraQgDiQslhHs2LR9yRUgKDw5hdgKR6bBNANANbRtuTNH/Inl3xIbsw
	 wHwQZM+GRrdG1WTGZvH1cOswexJRcPcrmKFfTzeJiE1NhqxRGCbvlyec5t+NiTftS4
	 Lj+T/3qc2jyKUY1ALD0DS5PyTPBrcGvTbuVzo3aZcRTXOuzHjVBINh19nig6cBa6/S
	 vy+FFEqPYheLg==
Date: Wed, 13 Sep 2023 13:47:49 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: check
 update_wo_rx_stats in mtk_wed_update_rx_stats()
Message-ID: <ZQGhZcA1e7CjnL+P@lore-desk>
References: <b0d233386e059bccb59f18f69afb79a7806e5ded.1694507226.git.lorenzo@kernel.org>
 <20230913112929.GS401982@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wNBEVYG2QozQ2W8P"
Content-Disposition: inline
In-Reply-To: <20230913112929.GS401982@kernel.org>


--wNBEVYG2QozQ2W8P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Sep 12, 2023 at 10:28:00AM +0200, Lorenzo Bianconi wrote:
> > Check if update_wo_rx_stats function pointer is properly set in
> > mtk_wed_update_rx_stats routine before accessing it.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Hi Lorenzo,

Hi Simon,

>=20
> I'm a little curious about this.
>=20
> Is there a condition where it is not set but accessed,
> which would presumably be a bug that warrants a fixes tag and
> targeting at 'net'?
>=20
> Or can it not occur, in which case this check is perhaps not needed?

nope, so far Wireless Ethernet Dispatches (WED) is supported just by mt7915
that sets update_wo_rx_stats callback. Howerver, I am currently working on =
WED
support for mt7996 where we do not have this callback available at the mome=
nt.

Regards,
Lorenzo

>=20
> Or something else?
>=20
> > ---
> >  drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/=
ethernet/mediatek/mtk_wed_mcu.c
> > index 071ed3dea860..72bcdaed12a9 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
> > @@ -68,6 +68,9 @@ mtk_wed_update_rx_stats(struct mtk_wed_device *wed, s=
truct sk_buff *skb)
> >  	struct mtk_wed_wo_rx_stats *stats;
> >  	int i;
> > =20
> > +	if (!wed->wlan.update_wo_rx_stats)
> > +		return;
> > +
> >  	if (count * sizeof(*stats) > skb->len - sizeof(u32))
> >  		return;
> > =20
> > --=20
> > 2.41.0
> >=20
> >=20

--wNBEVYG2QozQ2W8P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQGhZQAKCRA6cBh0uS2t
rC86AP9zG4nmZ8iAginUD6hwg+cAG7SCfVj8CNGwAn9gLCRrDgD/ZKhZ+s/tgoUj
jm8GyWSl5la/2JnvUcKv69vhiPd1kQ4=
=jiMQ
-----END PGP SIGNATURE-----

--wNBEVYG2QozQ2W8P--

