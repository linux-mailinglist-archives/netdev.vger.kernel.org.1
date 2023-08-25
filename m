Return-Path: <netdev+bounces-30622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA3578838D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 11:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F15281706
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 09:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45EAC8CB;
	Fri, 25 Aug 2023 09:32:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5327C2D6
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 09:32:09 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228241FD4
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 02:32:06 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-2-CWXtiu9VOBa0HfxzC4PXkQ-1; Fri, 25 Aug 2023 10:32:04 +0100
X-MC-Unique: CWXtiu9VOBa0HfxzC4PXkQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 25 Aug
 2023 10:32:02 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 25 Aug 2023 10:32:02 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mahmoud Maatuq' <mahmoudmatook.mm@gmail.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "edumazet@google.com" <edumazet@google.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"wad@chromium.org" <wad@chromium.org>, "luto@amacapital.net"
	<luto@amacapital.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>
Subject: RE: [PATCH v2 2/2] selftests/net: replace ternary operator with
 min()/max()
Thread-Topic: [PATCH v2 2/2] selftests/net: replace ternary operator with
 min()/max()
Thread-Index: AQHZ1slDuEzSfgmyIkyLho9d3Y2q6K/6vr1A
Date: Fri, 25 Aug 2023 09:32:02 +0000
Message-ID: <dd7b956916e044b181e7ccd1823f14ec@AcuMS.aculab.com>
References: <20230824202415.131824-1-mahmoudmatook.mm@gmail.com>
 <20230824202415.131824-2-mahmoudmatook.mm@gmail.com>
In-Reply-To: <20230824202415.131824-2-mahmoudmatook.mm@gmail.com>
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
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Mahmoud Maatuq
> Sent: 24 August 2023 21:24
....
>  =09=09tdeliver =3D glob_tstart + ts->delay_us * 1000;
> -=09=09tdeliver_max =3D tdeliver_max > tdeliver ?
> -=09=09=09       tdeliver_max : tdeliver;
> +=09=09tdeliver_max =3D max(tdeliver_max, tdeliver);

That was spectacularly horrid...
What is wrong with using:
=09if (tdeliver > tdeliver_max)
=09=09tdeliver_max =3D tdeliver;
That is pretty obviously calculating the upper bound.
Even the version with max() needs extra parsing by the human reader.

(The only issue is whether it reads better with the if condition
reversed.)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


