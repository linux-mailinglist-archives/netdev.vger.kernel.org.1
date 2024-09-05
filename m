Return-Path: <netdev+bounces-125458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A46D96D22D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DFE9B26FC5
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33667194AC7;
	Thu,  5 Sep 2024 08:31:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146227735
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525117; cv=none; b=LyKdCyw+Bn22rU9g4wPANwRDuUDA1My9tzy0wz9/f77ZkbZzZwKSj4XbizhIs4hdXTlbIw0qOEU5y9XVEbQP88Vy+Qvk8TbeikP5+3I9WniJvNF8TRiAiQNZkuJzq6UTtNgMI+UwHl14Jc6HIoPn25T1NYO/4dfvWj2+rB/EE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525117; c=relaxed/simple;
	bh=keIR8EElTZoyCJKMGLRf33PbH/0xT+F5e+jm0fSahlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=kfrfLkB1tMvKTcLrxbxpJVRxcWaZWN8Jpt67MpUkxlYSEurcwpAdTu8CS5awFJr+khbXwrU8Pf1YM/3VBnS9gwpMybXtVsTbETNpvQK8n4yhyDGGPE3Fip4z0O66EjksPLSGVFgIYFbkTRuVMeD4O3ifkV4Qcsj/+jjbAoOsCcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-208-bBR0HpsdP6-OvqFAN2Hggw-1; Thu, 05 Sep 2024 09:31:43 +0100
X-MC-Unique: bBR0HpsdP6-OvqFAN2Hggw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 5 Sep
 2024 09:30:59 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 5 Sep 2024 09:30:59 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Yan Zhen' <yanzhen@vivo.com>, "marcin.s.wojtas@gmail.com"
	<marcin.s.wojtas@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"openkernel.kernel@vivo.com" <openkernel.kernel@vivo.com>, "horms@kernel.org"
	<horms@kernel.org>
Subject: RE: [PATCH net-next v1] net: mvneta: Avoid the misuse of the '_t'
 variants
Thread-Topic: [PATCH net-next v1] net: mvneta: Avoid the misuse of the '_t'
 variants
Thread-Index: AQHa/14Ov5o5FRmGBkKUkiUQCQhZ8bJI3SGw
Date: Thu, 5 Sep 2024 08:30:59 +0000
Message-ID: <d1709ca244ac45cd8a7361d7cbd0ea66@AcuMS.aculab.com>
References: <20240905063645.586354-1-yanzhen@vivo.com>
In-Reply-To: <20240905063645.586354-1-yanzhen@vivo.com>
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
> Sent: 05 September 2024 07:37
>=20
> Type conversions (especially when narrowing down types) can lead to
> unexpected behavior and should be done with extreme caution.
>=20
> In this case if someone tries to set the tx_pending to 65536(0x10000),
> after forcing it to convert to u16, it becomes 0x0000, they will get
> the minimum supported size and not the maximum.
>=20
> Based on previous discussions [1], such behavior may confuse users or eve=
n
> create unexpected errors.
>=20
> [1] https://lore.kernel.org/netdev/d23dfbf563714d7090d163a075ca9a51@AcuMS=
.aculab.com/
>=20
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>

Reviewed-by: david.laight@aculab.com

> ---
>  drivers/net/ethernet/marvell/mvneta.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet=
/marvell/mvneta.c
> index d72b2d5f96db..b41de182cc88 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -4753,8 +4753,8 @@ mvneta_ethtool_set_ringparam(struct net_device *dev=
,
>  =09pp->rx_ring_size =3D ring->rx_pending < MVNETA_MAX_RXD ?
>  =09=09ring->rx_pending : MVNETA_MAX_RXD;
>=20
> -=09pp->tx_ring_size =3D clamp_t(u16, ring->tx_pending,
> -=09=09=09=09   MVNETA_MAX_SKB_DESCS * 2, MVNETA_MAX_TXD);
> +=09pp->tx_ring_size =3D clamp(ring->tx_pending,
> +=09=09=09=09 MVNETA_MAX_SKB_DESCS * 2, MVNETA_MAX_TXD);
>  =09if (pp->tx_ring_size !=3D ring->tx_pending)
>  =09=09netdev_warn(dev, "TX queue size set to %u (requested %u)\n",
>  =09=09=09    pp->tx_ring_size, ring->tx_pending);
> --
> 2.34.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


