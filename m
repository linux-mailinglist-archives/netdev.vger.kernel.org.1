Return-Path: <netdev+bounces-31060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556E78B2DD
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 16:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EAF61C2090B
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FFA12B7F;
	Mon, 28 Aug 2023 14:21:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954E411C9D
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 14:21:49 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A98C7
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 07:21:47 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-23-Ur2H8oLXMxOL1_aeirkIUQ-1; Mon, 28 Aug 2023 15:21:44 +0100
X-MC-Unique: Ur2H8oLXMxOL1_aeirkIUQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 28 Aug
 2023 15:21:47 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 28 Aug 2023 15:21:47 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, syzbot
	<syzkaller@googlegroups.com>
Subject: RE: [PATCH net] net: read sk->sk_family once in sk_mc_loop()
Thread-Topic: [PATCH net] net: read sk->sk_family once in sk_mc_loop()
Thread-Index: AQHZ2aMmJlfTQL2lpUaAJU3/1YiPO6//wQ5g
Date: Mon, 28 Aug 2023 14:21:47 +0000
Message-ID: <0cc17b1240c94bc2b44364e67afb838e@AcuMS.aculab.com>
References: <20230828113055.2685471-1-edumazet@google.com>
In-Reply-To: <20230828113055.2685471-1-edumazet@google.com>
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
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDI4IEF1Z3VzdCAyMDIzIDEyOjMxDQo+IA0KPiBz
eXpib3QgaXMgcGxheWluZyB3aXRoIElQVjZfQUREUkZPUk0gcXVpdGUgYSBsb3QgdGhlc2UgZGF5
cywNCj4gYW5kIG1hbmFnZWQgdG8gaGl0IHRoZSBXQVJOX09OX09OQ0UoMSkgaW4gc2tfbWNfbG9v
cCgpDQo+IA0KPiBXZSBoYXZlIG1hbnkgbW9yZSBzaW1pbGFyIGlzc3VlcyB0byBmaXguDQoNCklz
IGl0IHdvcnRoIHJldmlzaXRpbmcgdGhlIHVzZSBvZiB2b2xhdGlsZT8NCklmIGFsbCBhY2Nlc3Nl
cyB0byBhIGZpZWxkIGhhdmUgdG8gYmUgbWFya2VkIFJFQURfT05DRSgpDQphbmQgV1JJVEVfT05D
RSgpIHRoZW4gaXNuJ3QgdGhhdCBqdXN0ICd2b2xhdGlsZSc/DQoNCklJUkMgUkVBRF9PTkNFKCkg
KHdlbGwgQUNDRVNTX09OQ0UoKSkgd2FzIG9yaWdpbmFsbHkgb25seQ0KdXNlZCB0byBzdG9wIHRo
ZSBjb21waWxlciByZS1yZWFkaW5nIGEgdmFsdWUuDQpUaGUgY3VycmVudCBjb2RlIGFsc28gd29y
cmllcyBhYm91dCB0aGUgY29tcGlsZXIgZ2VuZXJhdGluZw0Kbm9uLWF0b21pYyByZWFkL3dyaXRl
IChldmVuIHRvIGEgMzJiaXQgd29yZCkuDQpTbyB0eXBpY2FsbHkgYWxsIHJlZmVyZW5jZXMgZW5k
IHVwIGJlaW5nIGFubm90YXRlZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


