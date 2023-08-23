Return-Path: <netdev+bounces-29948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E16D78554C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 12:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2575281249
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81545AD58;
	Wed, 23 Aug 2023 10:24:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F22A92F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:24:22 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA8F11F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 03:24:20 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-133-Azzw1r6MPOGjmCYghTvM_Q-1; Wed, 23 Aug 2023 11:24:17 +0100
X-MC-Unique: Azzw1r6MPOGjmCYghTvM_Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 23 Aug
 2023 11:24:16 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 23 Aug 2023 11:24:16 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Amritha Nambiar' <amritha.nambiar@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
CC: "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>
Subject: RE: [net-next PATCH v2 0/9] Introduce NAPI queues support
Thread-Topic: [net-next PATCH v2 0/9] Introduce NAPI queues support
Thread-Index: AQHZ1ISk2j15TaiRb0C/b58hOjJm6K/3rqpw
Date: Wed, 23 Aug 2023 10:24:16 +0000
Message-ID: <22603595289e4e86b6d61f0146b2e25d@AcuMS.aculab.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
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

RnJvbTogQW1yaXRoYSBOYW1iaWFyDQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyMiwgMjAyMyAx
MjoyNSBBTQ0KPiANCj4gSW50cm9kdWNlIHN1cHBvcnQgZm9yIGFzc29jaWF0aW5nIE5BUEkgaW5z
dGFuY2VzIHdpdGgNCj4gY29ycmVzcG9uZGluZyBSWCBhbmQgVFggcXVldWUgc2V0LiBBZGQgdGhl
IGNhcGFiaWxpdHkNCj4gdG8gZXhwb3J0IE5BUEkgaW5mb3JtYXRpb24gc3VwcG9ydGVkIGJ5IHRo
ZSBkZXZpY2UuDQo+IEV4dGVuZCB0aGUgbmV0ZGV2X2dlbmwgZ2VuZXJpYyBuZXRsaW5rIGZhbWls
eSBmb3IgbmV0ZGV2DQo+IHdpdGggTkFQSSBkYXRhLiBUaGUgTkFQSSBmaWVsZHMgZXhwb3NlZCBh
cmU6DQo+IC0gTkFQSSBpZA0KPiAtIE5BUEkgZGV2aWNlIGlmaW5kZXgNCj4gLSBxdWV1ZS9xdWV1
ZS1zZXQgKGJvdGggUlggYW5kIFRYKSBhc3NvY2lhdGVkIHdpdGggZWFjaA0KPiAgIE5BUEkgaW5z
dGFuY2UNCj4gLSBJbnRlcnJ1cHQgbnVtYmVyIGFzc29jaWF0ZWQgd2l0aCB0aGUgTkFQSSBpbnN0
YW5jZQ0KPiAtIFBJRCBmb3IgdGhlIE5BUEkgdGhyZWFkDQo+IA0KPiBUaGlzIHNlcmllcyBvbmx5
IHN1cHBvcnRzICdnZXQnIGFiaWxpdHkgZm9yIHJldHJpZXZpbmcNCj4gY2VydGFpbiBOQVBJIGF0
dHJpYnV0ZXMuIFRoZSAnc2V0JyBhYmlsaXR5IGZvciBzZXR0aW5nDQo+IHF1ZXVlW3NdIGFzc29j
aWF0ZWQgd2l0aCBhIE5BUEkgaW5zdGFuY2UgdmlhIG5ldGRldi1nZW5sDQo+IHdpbGwgYmUgc3Vi
bWl0dGVkIGFzIGEgc2VwYXJhdGUgcGF0Y2ggc2VyaWVzLg0KPiANCj4gUHJldmlvdXMgZGlzY3Vz
c2lvbiBhdDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2L2M4NDc2NTMwNjM4YTVm
NDM4MWQ2NGRiMGUwMjRlZDQ5YzJkYjNiMDIuY2FtZWxAZ21haWwuY29tL1QvI20wMDk5OTY1MmE4
DQo+IGI0NzMxZmJkYjdiZjY5OGQyZTM2NjZjNjVhNjBlNw0KDQpOb3Qgb2YgdGhpcyBhbnN3ZXJz
OiB3aGF0IGlzIGl0IGZvcj8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


