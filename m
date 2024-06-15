Return-Path: <netdev+bounces-103815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8129099FE
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 23:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3191F21D1A
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 21:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609601C68E;
	Sat, 15 Jun 2024 21:21:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EECE179A8
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718486469; cv=none; b=ZYwtwUdfEyuGF/aXTNk4R7FGv8fRRLzJhcPgph+ZwEhxM0E890UzHywNh1/ojfBCKbIQ8MOVGBdTQ3fK452RtCYy4ym5f/1wJZ77jj3hC0SKSWnd+v8OSSd1Xt4BDDJLXROHkxIFqTPWABvtHLJe54jq6duzNf+04TayAibjGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718486469; c=relaxed/simple;
	bh=sSdyUbGYfx+mUB6e4EJY+pbTDYsZbR5crjYv4C45xvI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=af4uC3VsW61ClxW20SGrP9bduJDdPqsMYIzdi/zlplXrDzwbaotC4pIrdaQeCKiKnvtFjk/t353fgt/R2ovBAZ4uM8P7+aC3OLOVMMxJnhrmx37HkObJzWwKbP83DggkCrIdeUV/v4P7DWsUImI+lE3IAr9CA5S0YsInG03WyQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-116-e4PTO85oMRyhbYwuP-_vaA-1; Sat, 15 Jun 2024 22:20:53 +0100
X-MC-Unique: e4PTO85oMRyhbYwuP-_vaA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 15 Jun
 2024 22:20:17 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 15 Jun 2024 22:20:17 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Shannon Nelson' <shannon.nelson@amd.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "brett.creeley@amd.com" <brett.creeley@amd.com>, "drivers@pensando.io"
	<drivers@pensando.io>
Subject: RE: [PATCH net-next 7/8] ionic: Use an u16 for rx_copybreak
Thread-Topic: [PATCH net-next 7/8] ionic: Use an u16 for rx_copybreak
Thread-Index: AQHau4sD/nDUY/efCkW3PCGaFvsKj7HJXBaw
Date: Sat, 15 Jun 2024 21:20:17 +0000
Message-ID: <1cfefa13c8f34ccca322639a05122d6d@AcuMS.aculab.com>
References: <20240610230706.34883-1-shannon.nelson@amd.com>
 <20240610230706.34883-8-shannon.nelson@amd.com>
In-Reply-To: <20240610230706.34883-8-shannon.nelson@amd.com>
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

From: Shannon Nelson
> Sent: 11 June 2024 00:07
>=20
> From: Brett Creeley <brett.creeley@amd.com>
>=20
> To make space for other data members on the first cache line reduce
> rx_copybreak from an u32 to u16.  The max Rx buffer size we support
> is (u16)-1 anyway so this makes sense.
>=20
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 10 +++++++++-
>  drivers/net/ethernet/pensando/ionic/ionic_lif.h     |  2 +-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index 91183965a6b7..26acd82cf6bc 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -872,10 +872,18 @@ static int ionic_set_tunable(struct net_device *dev=
,
>  =09=09=09     const void *data)
>  {
>  =09struct ionic_lif *lif =3D netdev_priv(dev);
> +=09u32 rx_copybreak, max_rx_copybreak;
>=20
>  =09switch (tuna->id) {
>  =09case ETHTOOL_RX_COPYBREAK:
> -=09=09lif->rx_copybreak =3D *(u32 *)data;
> +=09=09rx_copybreak =3D *(u32 *)data;
> +=09=09max_rx_copybreak =3D min_t(u32, U16_MAX, IONIC_MAX_BUF_LEN);

I doubt that needs to be min_t() or that you really need the temporary.

> +=09=09if (rx_copybreak > max_rx_copybreak) {
> +=09=09=09netdev_err(dev, "Max supported rx_copybreak size: %u\n",
> +=09=09=09=09   max_rx_copybreak);
> +=09=09=09return -EINVAL;
> +=09=09}
> +=09=09lif->rx_copybreak =3D (u16)rx_copybreak;
>  =09=09break;
>  =09default:
>  =09=09return -EOPNOTSUPP;
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> index 40b28d0b858f..50fda9bdc4b8 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> @@ -206,7 +206,7 @@ struct ionic_lif {
>  =09unsigned int nxqs;
>  =09unsigned int ntxq_descs;
>  =09unsigned int nrxq_descs;
> -=09u32 rx_copybreak;
> +=09u16 rx_copybreak;
>  =09u64 rxq_features;
>  =09u16 rx_mode;

There seem to be 6 pad bytes here - why not just use them??

>  =09u64 hw_features;

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


