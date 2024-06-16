Return-Path: <netdev+bounces-103840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CAA909CF7
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 12:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319D81C20910
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C5916D9C9;
	Sun, 16 Jun 2024 10:28:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B97FC0B
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718533720; cv=none; b=PZAnhBqbvgpFKbIfyQqmpnlssBvwabGCKD3qHokMrWg+CxLt0flVKUdmFwt8Pty0SqZ2OF/G3IayAO2uRQ5lZBft/34eqiTXMYFOwaYETIGauidSkcy3kBe7bFiqMA/88kFs4bohDam6h7RIz1Zw6v+vecDmk96Pp/uzqtxioIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718533720; c=relaxed/simple;
	bh=5xDu7kjBCv083a7ymHqcCPEXM/1frXMMXeesebw9J6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=jH5MUC3ghQNGUxFXnLT+NICoHinJoWFsnuE9Lp3SwjfymKHv0tfmViLLuoBY+bjuxy/GUytdDyPkkBZKkL5jxVLscpEc6mTbQVL1EWv0Piy6eaZ+HWSBsG1tESuk8vbA7IGNUYGO23hn73tBu53Siwnr8wh2b6nEz1TvPpImPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-32-FvT-k9JnOOC27og0Aj3Qfw-1; Sun, 16 Jun 2024 11:28:31 +0100
X-MC-Unique: FvT-k9JnOOC27og0Aj3Qfw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 16 Jun
 2024 11:27:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 16 Jun 2024 11:27:52 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Andrew Lunn' <andrew@lunn.ch>
CC: 'Shannon Nelson' <shannon.nelson@amd.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"brett.creeley@amd.com" <brett.creeley@amd.com>, "drivers@pensando.io"
	<drivers@pensando.io>
Subject: RE: [PATCH net-next 7/8] ionic: Use an u16 for rx_copybreak
Thread-Topic: [PATCH net-next 7/8] ionic: Use an u16 for rx_copybreak
Thread-Index: AQHau4sD/nDUY/efCkW3PCGaFvsKj7HJXBawgAA1KgCAAKUs4A==
Date: Sun, 16 Jun 2024 10:27:52 +0000
Message-ID: <610168e14b814c67b2ef63f1a4fb0eca@AcuMS.aculab.com>
References: <20240610230706.34883-1-shannon.nelson@amd.com>
 <20240610230706.34883-8-shannon.nelson@amd.com>
 <1cfefa13c8f34ccca322639a05122d6d@AcuMS.aculab.com>
 <ead82f17-b890-4834-9b18-8c548ed985d5@lunn.ch>
In-Reply-To: <ead82f17-b890-4834-9b18-8c548ed985d5@lunn.ch>
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

From: Andrew Lunn
> Sent: 16 June 2024 02:29
>=20
> > > --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> > > +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> > > @@ -206,7 +206,7 @@ struct ionic_lif {
> > >  =09unsigned int nxqs;
> > >  =09unsigned int ntxq_descs;
> > >  =09unsigned int nrxq_descs;
> > > -=09u32 rx_copybreak;
> > > +=09u16 rx_copybreak;
> > >  =09u64 rxq_features;
> > >  =09u16 rx_mode;
> >
> > There seem to be 6 pad bytes here - why not just use them??
>=20
> Or at least move rx_copybreak next to rx_mode so the compiler can pack
> them together.
>=20
> It would be good to include some output from pahole in the commit
> message to show the goal of this patch has actually been reached.

And then start asking whether the fields are grouped for cache usage at all=
.
And whether the structure itself is allocated by kmalloc() or is nested
in something else.

You might worry about structure holes because they make the structure
larger - but that only matters if the allocator rounds it up to a
bigger size. And that only really matters if you allocate lots of them.

So the dominant part of this change is probably the extra code.

When you add the extra flag as 'uint flag:1' you also generate worse
code that just using a 'u8' - so not worth it unless you need to pack
multiple flags into a word.

Of course, slight re-ordering to avoid holes is usually fine.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


