Return-Path: <netdev+bounces-33767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E4D79FFA3
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 11:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF7CB20A54
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 09:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDCA224EB;
	Thu, 14 Sep 2023 09:06:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE9224C4
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 09:06:47 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1C5F1FE0
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 02:06:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-252-oVJiQy4pMkOK69oh5CjVkA-1; Thu, 14 Sep 2023 10:06:29 +0100
X-MC-Unique: oVJiQy4pMkOK69oh5CjVkA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 14 Sep
 2023 10:06:25 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 14 Sep 2023 10:06:25 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'David Howells' <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "Christian
 Brauner" <christian@brauner.io>, Matthew Wilcox <willy@infradead.org>, "Jeff
 Layton" <jlayton@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 05/13] iov: Move iterator functions to a header file
Thread-Topic: [PATCH v4 05/13] iov: Move iterator functions to a header file
Thread-Index: AQHZ5mNctrIi+SmkLEm1sOlIj5L+5rAaBNNA
Date: Thu, 14 Sep 2023 09:06:25 +0000
Message-ID: <445a78b0ff3047fea20d3c8058a5ff6a@AcuMS.aculab.com>
References: <20230913165648.2570623-1-dhowells@redhat.com>
 <20230913165648.2570623-6-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-6-dhowells@redhat.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
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

From: David Howells
> Sent: 13 September 2023 17:57
>=20
> Move the iterator functions to a header file so that other operations tha=
t
> need to scan over an iterator can be added.  For instance, the rbd driver
> could use this to scan a buffer to see if it is all zeros and libceph cou=
ld
> use this to generate a crc.

These all look a bit big for being more generally inlined.

I know you want to avoid the indirect call in the normal cases,
but maybe it would be ok for other uses?

=09=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


