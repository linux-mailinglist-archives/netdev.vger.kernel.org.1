Return-Path: <netdev+bounces-124015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9598A9675F5
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 12:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253D81F2127E
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 10:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F2515FA7B;
	Sun,  1 Sep 2024 10:53:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85531419A9
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725188014; cv=none; b=XiadWlGxiVmdQHxchZwfNWmfgxI5bJWcTHJsRpDHcehIfO/L8g5G+EZsiQmoWrggmkIvYWucK+nXPNv0JUQjJzzTOFu6c8xt4a8Wd+048eJ5FaPUMMEI1NE9y9mKpvoGbxP66B9hhT8RZSzb7P5906aUOKStDzFcRfMLMOon1XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725188014; c=relaxed/simple;
	bh=7pEGnYA5JzjWaqiWySwcORA8GhR4vtPpk/TuMIf8yH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=tqBX1e9VXMNYJe+uWDcT0hiBHT82+rAIYXloBcToEiZ1BCcv8jXQefbGRGtwBvqU4oxw+Ba79+V9rcWld6zV/CtXB+UXqlFjqhWHPDgqoICt7zIjTn129Gymg4/eolwuhHY4VvS6rcGhMWJ3hoil8/6tWLPagal986ovdYx0+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-172-VAP0I1YNMyeSluF6sMA7cw-1; Sun, 01 Sep 2024 11:53:27 +0100
X-MC-Unique: VAP0I1YNMyeSluF6sMA7cw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 1 Sep
 2024 11:52:39 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 1 Sep 2024 11:52:39 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Yan Zhen' <yanzhen@vivo.com>, "marcin.s.wojtas@gmail.com"
	<marcin.s.wojtas@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: RE: [PATCH net-next v3] net: mvneta: Use min macro
Thread-Topic: [PATCH net-next v3] net: mvneta: Use min macro
Thread-Index: AQHa+niVvLIu7d7EQ0KehbNKS9tSRLJCwu7Q
Date: Sun, 1 Sep 2024 10:52:38 +0000
Message-ID: <d23dfbf563714d7090d163a075ca9a51@AcuMS.aculab.com>
References: <20240830010423.3454810-1-yanzhen@vivo.com>
In-Reply-To: <20240830010423.3454810-1-yanzhen@vivo.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Yan Zhen
> Sent: 30 August 2024 02:04
> To: marcin.s.wojtas@gmail.com; davem@davemloft.net; edumazet@google.com; =
kuba@kernel.org;
>=20
> Using the real macro is usually more intuitive and readable,
> When the original file is guaranteed to contain the minmax.h header file
> and compile correctly.
>=20
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>=20
> Changes in v3:
> - Rewrite the subject.
>=20
>  drivers/net/ethernet/marvell/mvneta.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet=
/marvell/mvneta.c
> index d72b2d5f96db..08d277165f40 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -4750,8 +4750,7 @@ mvneta_ethtool_set_ringparam(struct net_device *dev=
,
>=20
>  =09if ((ring->rx_pending =3D=3D 0) || (ring->tx_pending =3D=3D 0))
>  =09=09return -EINVAL;
> -=09pp->rx_ring_size =3D ring->rx_pending < MVNETA_MAX_RXD ?
> -=09=09ring->rx_pending : MVNETA_MAX_RXD;
> +=09pp->rx_ring_size =3D umin(ring->rx_pending, MVNETA_MAX_RXD);

Why did you use umin() instead of min() ?

>=20
>  =09pp->tx_ring_size =3D clamp_t(u16, ring->tx_pending,
>  =09=09=09=09   MVNETA_MAX_SKB_DESCS * 2, MVNETA_MAX_TXD);

Hmmm how about a patch to fix the bug in that line?
A typical example of the complete misuse of the '_t' variants.
The fact that the LHS is u16 doesn't mean that it is anyway
correct to cast the RHS value to u16.
In this case if someone tries to set the ring size to 64k they'll
get the minimum supported size and not the maximum.

=09David

> --
> 2.34.1
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


