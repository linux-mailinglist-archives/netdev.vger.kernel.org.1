Return-Path: <netdev+bounces-128818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B88E97BCD5
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 15:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D25128246A
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1858D50285;
	Wed, 18 Sep 2024 13:12:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24081CD3F
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665155; cv=none; b=OKHCwjc+/sq6qLT7Rq+oZNhZE83P18XYsXtrqWnJvvcf8Wyof/PXBfJiHEx5v3MJpPMSAsViW8V8Dz40GZ9MwZJpgLrq7BGK6yqfAmekvG6oNvd5L/mnocQMNfXWn3TjkIWRcpTqElsXObzWSzVAVlTzkekHv+ajRWhF5Iu6Zx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665155; c=relaxed/simple;
	bh=tunpz202ryRshnykQTs5D/aZFsaJWqyTT5H4vmcgzcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=cgZiWDC0M6/5kmV0nGQyVJpP4bkgqjHlzP1TY/ZeZOVM4zlxjYeRXIlOYUOm9nsfbiPGYvL2znboqAFt1dJm6UB/guJ+dtrMXzIoqnDdks6gvHKDif2ZLEkP/P40fq1cn+JNSUM8guITR9u06ogcFqpLU50SzIw9p9LgRlspTbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-180-Ds7bbznFMQW56CDHqMjHyA-1; Wed, 18 Sep 2024 14:12:21 +0100
X-MC-Unique: Ds7bbznFMQW56CDHqMjHyA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 18 Sep
 2024 14:11:34 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 18 Sep 2024 14:11:34 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Qianqiang Liu' <qianqiang.liu@163.com>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: check the return value of the copy_from_sockptr
Thread-Topic: [PATCH] net: check the return value of the copy_from_sockptr
Thread-Index: AQHbBAhJHAon3Y91Ykei5SQsRxWlnLJdjjBQ
Date: Wed, 18 Sep 2024 13:11:34 +0000
Message-ID: <0858b2bde3f54c9da0f655a09bab7dab@AcuMS.aculab.com>
References: <20240911050435.53156-1-qianqiang.liu@163.com>
In-Reply-To: <20240911050435.53156-1-qianqiang.liu@163.com>
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

From: Qianqiang Liu
> Sent: 11 September 2024 06:05
>=20
> We must check the return value of the copy_from_sockptr. Otherwise, it
> may cause some weird issues.

Actually there is no point doing the copy for optlen in absolutely every fu=
nction.
'optlen' can be passed as a kernel address and any user copy done by the ca=
ller.
Someone should have spotted that before sockptr_t was used for optlen.

The wrapper code can then also do a correct check for (optlen >=3D 0) which=
 has
been pretty much broken in most protocols for ~ever.
(I wonder if any (important) userspace relies on a negative optlen
being treated as 4.)

It might mean that the final 'copy_to_user' are done in the opposite
order so that an kernel side side effects aren't reversed if the length
can't be copied out - but I suspect that doesn't matter and the paths
are likely to be untested and buggy.

I have toyed with making the getsockopt() functions return a +ve length
or -ve error - but there are a few strange places that need to update
the length and return an error.

=09David

>=20
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>  net/socket.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/socket.c b/net/socket.c
> index 0a2bd22ec105..6b9a414d01d5 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2370,8 +2370,11 @@ int do_sock_getsockopt(struct socket *sock, bool c=
ompat, int level,
>  =09if (err)
>  =09=09return err;
>=20
> -=09if (!compat)
> -=09=09copy_from_sockptr(&max_optlen, optlen, sizeof(int));
> +=09if (!compat) {
> +=09=09err =3D copy_from_sockptr(&max_optlen, optlen, sizeof(int));
> +=09=09if (err)
> +=09=09=09return -EFAULT;
> +=09}
>=20
>  =09ops =3D READ_ONCE(sock->ops);
>  =09if (level =3D=3D SOL_SOCKET) {
> --
> 2.39.2
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


