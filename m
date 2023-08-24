Return-Path: <netdev+bounces-30270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB80786AC2
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 10:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A1F1C20DB7
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95661CA7B;
	Thu, 24 Aug 2023 08:53:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821AA24544
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:53:46 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F651994
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 01:53:32 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-21-1nU0YSAiNYCfvxfcnnRqsg-1; Thu, 24 Aug 2023 09:53:29 +0100
X-MC-Unique: 1nU0YSAiNYCfvxfcnnRqsg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 24 Aug
 2023 09:53:25 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 24 Aug 2023 09:53:25 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mahmoud Matook' <mahmoudmatook.mm@gmail.com>
CC: 'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>
Subject: RE: [PATCH 1/2] selftests: Provide local define of min() and max()
Thread-Topic: [PATCH 1/2] selftests: Provide local define of min() and max()
Thread-Index: AQHZ03nFpJJs9cS/jEaiicM+CY14+6/0t4aQgAGcP4CAABL1kIAB05OAgADtwiA=
Date: Thu, 24 Aug 2023 08:53:25 +0000
Message-ID: <956ab0e63b8340669c31d2452830b7f3@AcuMS.aculab.com>
References: <20230819195005.99387-1-mahmoudmatook.mm@gmail.com>
 <20230819195005.99387-2-mahmoudmatook.mm@gmail.com>
 <64e22df53d1e6_3580162945b@willemb.c.googlers.com.notmuch>
 <7e8c2597c71647f38cd4672cbef53a66@AcuMS.aculab.com>
 <CAF=yD-+6cWTiDgpsu=hUV+OvzDFRaT2ZUmtQo9qTrCB9i-+7ng@mail.gmail.com>
 <d33fbb24119c4d09864e79ea9dfbb881@AcuMS.aculab.com>
 <20230823193545.nrzlbsa32hm4os4k@mmaatuq-HP-Laptop-15-dy2xxx>
In-Reply-To: <20230823193545.nrzlbsa32hm4os4k@mmaatuq-HP-Laptop-15-dy2xxx>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Mahmoud Matook
> Sent: Wednesday, August 23, 2023 8:36 PM
...
> I tried to use the relaxed version provided in the shared patchset link
> besides not able to use is_constexpr(), I'm not able to use
> __UNIQUE_ID() also. It's definded inside include/linux/compiler-gcc.h
> and it uses another macro __PASTE() which is defined inside
> include/linux/compiler_types.h.
> not sure what to do next
>
> - bring those macros definitions to able to use the relaxed version.
> - if the most important point for min/max defines inside selftests is to
>   avoid multiple evaluation is the below version acceptable?
>
>   #define min(x, y) ({ \
>     typeof(x) _x =3D (x); \
>     typeof(y) _y =3D (y); \
>     _x < _y ? _x : _y; \
> })
>=20
> #define max(x, y) ({ \
>     typeof(x) _x =3D (x); \
>     typeof(y) _y =3D (y); \
>     _x > _y ? _x : _y; \
> })

Those are a reasonable pair.

If you want a signed-ness check the:
=09_Static_assert(is_signed_type(typeof(a)) =3D=3D is_signed_type(typeof(b)=
), "min/max signednesss")
check should just drop into the above.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


