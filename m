Return-Path: <netdev+bounces-147493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A95E9D9DF2
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24574163774
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 19:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8551DE3A3;
	Tue, 26 Nov 2024 19:20:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08C1DE2AA
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648810; cv=none; b=K0WwXFLS9nsFOAZUzVGw0ZTAMgy0wcGntolC6xKMCpWfh6Lgg6NNoF1vOgN7fFny1ygGFi7k6MbIZax+U5J1RUkpmSrsWe6tm7S6Mv/vpDCmqCDoeAnQ/H4/BtcuvXrbiTCjyVava/V34uqhH06u640PuKKirGSkG9kf1/reako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648810; c=relaxed/simple;
	bh=1rfO/dDcUsk9L0huJ8tsODJN4eDkJ6Y9cI/jyNngJ+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=KC2hEoXDk5Jwoc4kuvtHBfWZsfJeDOSQ5BWFulL01Bl2sBZxfnvw4dhBAYmgsMNrZ8QIjn84uM2arU5huQ8QdYIFCahS5sIx3tZsVT0yuMEJ12IJQPXA9eu/NIdFSY6IUgKs79ykKjaicMbN1sHCI+b4CLuE8HmUIS5v+swP/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-192-kfp3vaQpMlqaEBSAx8cs1A-1; Tue, 26 Nov 2024 19:20:00 +0000
X-MC-Unique: kfp3vaQpMlqaEBSAx8cs1A-1
X-Mimecast-MFC-AGG-ID: kfp3vaQpMlqaEBSAx8cs1A
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 26 Nov
 2024 19:19:54 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 26 Nov 2024 19:19:54 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Herbert Xu' <herbert@gondor.apana.org.au>, Kent Overstreet
	<kent.overstreet@linux.dev>
CC: NeilBrown <neilb@suse.de>, Thomas Graf <tgraf@suug.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: rhashtable issue - -EBUSY
Thread-Topic: rhashtable issue - -EBUSY
Thread-Index: AQHbP7e2Pj7ceWvry0iKsQ15fk0dc7LJ78Pw
Date: Tue, 26 Nov 2024 19:19:54 +0000
Message-ID: <bddd44410602480fb57c82b8face23bb@AcuMS.aculab.com>
References: <> <Z0QQnLNJn1jhMErP@gondor.apana.org.au>
 <173257789029.1734440.16216135574521669815@noble.neil.brown.name>
 <yaxjp5k4o37vh2bl2ecuj3qoyz6x3lwau2kf7zevq5v3krcmtu@idoh3wd4zyqu>
 <Z0U4bfbBoooHIZVB@gondor.apana.org.au>
 <t3a3ggvcvnle6dnnmzf3ehlgcxhgpnn2mbpyukjv3g67iqxlah@spqeyovloafo>
 <Z0U9IW12JklBfuBv@gondor.apana.org.au>
 <dhgvxsvugfqrowuypzwizy5psdfm4fy5xveq2fuepqfmhdlv5e@pj5kt4pmansq>
 <Z0VHwWe8x9RrhKGp@gondor.apana.org.au>
In-Reply-To: <Z0VHwWe8x9RrhKGp@gondor.apana.org.au>
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
X-Mimecast-MFC-PROC-ID: ZhWtf03Nw6fF0fe-XnWNvJ1oIf-h6HTNjTcndNrqpQA_1732648799
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Herbert Xu
> Sent: 26 November 2024 04:00
>=20
> On Mon, Nov 25, 2024 at 10:51:04PM -0500, Kent Overstreet wrote:
> >
> > I just meant having a knob that's called "insecure". Why not a knob
> > that selects nonblocking vs. reliable?
>=20
> Because it is *insecure*.  If a hostile actor gains the ability
> to insert into your hash table, then by disabling this defence
> you're giving them the ability to turn your hash table into a
> linked list.
>=20
> So as long as you acknowledge and are willing to undertake this
> risk, I'm happy for you to do that.  But I'm not going to hide
> this under the rug.

There is always the option of some kind of status flag (etc)
so that the user can find out that the hash table is 'sub optimal'
outsize of the insert path.
Not sure how you'd clear it - except by a rehash.

That does pass the buck a bit though.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


