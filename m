Return-Path: <netdev+bounces-29658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2988F7844AE
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FDB1C208C2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F281CA17;
	Tue, 22 Aug 2023 14:48:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889BB1C2BE
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 14:48:15 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EE9198
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:48:13 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-67-D5qlW6B2MLuti1GsDH0uYA-1; Tue, 22 Aug 2023 15:48:10 +0100
X-MC-Unique: D5qlW6B2MLuti1GsDH0uYA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 22 Aug
 2023 15:48:09 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 22 Aug 2023 15:48:09 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>
CC: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>,
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
Thread-Index: AQHZ03nFpJJs9cS/jEaiicM+CY14+6/0t4aQgAGcP4CAABL1kA==
Date: Tue, 22 Aug 2023 14:48:08 +0000
Message-ID: <d33fbb24119c4d09864e79ea9dfbb881@AcuMS.aculab.com>
References: <20230819195005.99387-1-mahmoudmatook.mm@gmail.com>
 <20230819195005.99387-2-mahmoudmatook.mm@gmail.com>
 <64e22df53d1e6_3580162945b@willemb.c.googlers.com.notmuch>
 <7e8c2597c71647f38cd4672cbef53a66@AcuMS.aculab.com>
 <CAF=yD-+6cWTiDgpsu=hUV+OvzDFRaT2ZUmtQo9qTrCB9i-+7ng@mail.gmail.com>
In-Reply-To: <CAF=yD-+6cWTiDgpsu=hUV+OvzDFRaT2ZUmtQo9qTrCB9i-+7ng@mail.gmail.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Li4uDQo+ID4gVGhhdCB0eXBlY2hlY2soKSBpcyBob3JyaWQuDQo+ID4gSXQgbWF5IHdlbGwgaGF2
ZSBjYXVzZWQgbW9yZSBidWdzIGR1ZSB0byBpbmNvcnJlY3QgY2FzdHMgdGhhdA0KPiA+IGl0IGFj
dHVhbGx5IGRldGVjdGVkLg0KPiA+DQo+ID4gSSdkIHN1Z2dlc3QgdGhlIHZlcnNpb24gdGhhdCBq
dXN0IGF2b2lkcyBtdWx0aXBsZSBldmFsdWF0aW9ucy4NCj4gPiBPciBqdXN0IGVycm9yIHNpZ25l
ZCB2IHVuc2lnbmVkIGNvbXBhcmlzb25zLg0KPiA+IFNlZSAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsL2I0Y2U5ZGFkNzQ4ZTQ4OWY5MzE0YTJkYzk1NjE1MDMzQEFjdU1TLmFjdWxhYi5jb20v
DQo+ID4gZm9yIGFuIGV4YW1wbGUgcGF0Y2ggc2V0Lg0KPiANCj4gSW50ZXJlc3RpbmcsIHRoYW5r
cy4gVGhhdCBpcyBhbHNvIHNpbXBsZXIuDQo+IA0KPiBBbHNvLCB0aGUgZXhpc3RpbmcgcGF0Y2gg
aXMgbm8gd29yc2UgdGhhbiB0aGUgb3BlbiBjb2RlZCBjb2RlIHRvZGF5LA0KPiBzbyBldmVuIHdp
dGhvdXQgY29kZSB0byBhdm9pZCBtdWx0aXBsZSBldmFsdWF0aW9ucywgSSBndWVzcyBpdCdzIG9r
YXkNCj4gdG8gbWVyZ2UuDQo+IA0KPiBUaGUgY29jY2luZWxsZSB3YXJuaW5ncyBhcmUgYXJndWFi
bHkgZmFsc2UgcG9zaXRpdmVzLCB1c2luZyBjaGVja3MgZm9yDQo+IGtlcm5lbCBjb2RlLCBidXQg
YmVpbmcgcnVuIGFnYWluc3QgdXNlcnNwYWNlIGNvZGUgdGhhdCBoYXMgbm8gYWNjZXNzDQo+IHRv
IHRob3NlIGhlbHBlcnMuIEJ1dCBmaW5lIHRvIHNpbGVuY2UgdGhlbS4NCg0KWW91IGNhbid0IHVz
ZSBpc19jb25zdGV4cHIoKSB1bmxlc3MgJ3NpemVvZiAqKHZvaWQgKiknIGlzIHZhbGlkLg0KQW5k
IGJ1aWx0aW5fY29uc3RhbnQoKSBpc24ndCBnb29kIGVub3VnaCBmb3IgYnVpbHRpbl9jaG9vc2Vf
ZXhwcigpLg0KDQpUaGF0IG1pZ2h0IGJlIG9rIGZvciBzZWxmdGVzdHMgYW5kIHRvb2xzLCBidXQg
bm90IGZvciBnZW5lcmFsdXNlcnNwYWNlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


