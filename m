Return-Path: <netdev+bounces-18901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C64B6759098
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 10:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EED5281161
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 08:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85873101F4;
	Wed, 19 Jul 2023 08:48:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA5C2E9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 08:48:05 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B17E136
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:48:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-231-2FrdlNlEO-aRlwCr8sDXcg-1; Wed, 19 Jul 2023 09:47:59 +0100
X-MC-Unique: 2FrdlNlEO-aRlwCr8sDXcg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Jul
 2023 09:47:57 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 19 Jul 2023 09:47:57 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Andrew Lunn' <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
CC: Kees Cook <kees@kernel.org>, "justinstitt@google.com"
	<justinstitt@google.com>, Florian Fainelli <f.fainelli@gmail.com>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook
	<keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>
Subject: RE: [PATCH] net: dsa: remove deprecated strncpy
Thread-Topic: [PATCH] net: dsa: remove deprecated strncpy
Thread-Index: AQHZua5uBGaLyFdvXEuDn4GOsjwmUK/Ax0MA
Date: Wed, 19 Jul 2023 08:47:57 +0000
Message-ID: <02afcfd1dc4d4c258c2c5ffbda2688c8@AcuMS.aculab.com>
References: <20230718-net-dsa-strncpy-v1-1-e84664747713@google.com>
 <316E4325-6845-4EFC-AAF8-160622C42144@kernel.org>
 <20230718121116.72267fff@kernel.org>
 <dbfb40d7-502e-40c0-bdaf-1616834b64e4@lunn.ch>
In-Reply-To: <dbfb40d7-502e-40c0-bdaf-1616834b64e4@lunn.ch>
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
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Andrew Lunn
> Sent: 18 July 2023 20:31
...
> Maybe we should actually add another helper:
>=20
> ethtool_name_cpy(u8 **data, unsigned int index, const char *name);
>=20
> Then over the next decade, slowly convert all drivers to it. And then
> eventually replace the u8 with a struct including the length.

Define the structure with the length from the start.
Add a wrapper that allows the length to be absent.
(Either ignoring the length or using 0/infinity to mean no length.)

Then you don't need to visit everywhere twice - just some places.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


