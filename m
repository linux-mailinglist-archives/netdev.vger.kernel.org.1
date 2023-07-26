Return-Path: <netdev+bounces-21414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE707638C0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541E3281A89
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606CD253A3;
	Wed, 26 Jul 2023 14:14:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529719453
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:14:12 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105E84C2C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:13:52 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-92--pzAXh_YOMKisQnYzDwikQ-1; Wed, 26 Jul 2023 15:13:07 +0100
X-MC-Unique: -pzAXh_YOMKisQnYzDwikQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 26 Jul
 2023 15:13:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 26 Jul 2023 15:13:06 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>
CC: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH 2/2] Rescan the hash2 list if the hash chains have got
 cross-linked.
Thread-Topic: [PATCH 2/2] Rescan the hash2 list if the hash chains have got
 cross-linked.
Thread-Index: Adm/uYXsrlBDnyZsQsqXScrMcg4DhwABF66AAAI2u7A=
Date: Wed, 26 Jul 2023 14:13:05 +0000
Message-ID: <fc241086b32944ecae4f467cb5b0c6c7@AcuMS.aculab.com>
References: <fbcaa54791cd44999de5fec7c6cf0b3c@AcuMS.aculab.com>
 <c45337a3d46641dc8c4c66bd49fb55b6@AcuMS.aculab.com>
 <CANn89iKTC29of9bkVKWcLv0W27JFvkub7fuBMeK_J3a3Q-B1Cg@mail.gmail.com>
In-Reply-To: <CANn89iKTC29of9bkVKWcLv0W27JFvkub7fuBMeK_J3a3Q-B1Cg@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDI2IEp1bHkgMjAyMyAxNDozNw0KPiANCj4gT24g
V2VkLCBKdWwgMjYsIDIwMjMgYXQgMjowNuKAr1BNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gdWRwX2xpYl9yZWhhc2goKSBjYW4gZ2V0IGNh
bGxlZCBhdCBhbnkgdGltZSBhbmQgd2lsbCBtb3ZlIGENCj4gPiBzb2NrZXQgdG8gYSBkaWZmZXJl
bnQgaGFzaDIgY2hhaW4uDQo+ID4gVGhpcyBjYW4gY2F1c2UgdWRwNF9saWJfbG9va3VwMigpIChw
cm9jZXNzaW5nIGluY29taW5nIFVEUCkgdG8NCj4gPiBmYWlsIHRvIGZpbmQgYSBzb2NrZXQgYW5k
IGFuIElDTVAgcG9ydCB1bnJlYWNoYWJsZSBiZSBzZW50Lg0KPiA+DQo+ID4gUHJpb3IgdG8gY2Ew
NjVkMGNmODBmYSB0aGUgbG9va3VwIHVzZWQgJ2hsaXN0X251bGxzJyBhbmQgY2hlY2tlZA0KPiA+
IHRoYXQgdGhlICdlbmQgaWYgbGlzdCcgbWFya2VyIHdhcyBvbiB0aGUgY29ycmVjdCBsaXN0Lg0K
PiA+DQo+ID4gUmF0aGVyIHRoYW4gcmUtaW5zdGF0ZSB0aGUgJ251bGxzJyBsaXN0IGp1c3QgY2hl
Y2sgdGhhdCB0aGUgZmluYWwNCj4gPiBzb2NrZXQgaXMgb24gdGhlIGNvcnJlY3QgbGlzdC4NCj4g
Pg0KPiA+IFRoZSBjcm9zcy1saW5raW5nIGNhbiBkZWZpbml0ZWx5IGhhcHBlbiAoc2VlIGVhcmxp
ZXIgaXNzdWVzIHdpdGgNCj4gPiBpdCBsb29waW5nIGZvcmV2ZXIgYmVjYXVzZSBnY2MgY2FjaGVk
IHRoZSBsaXN0IGhlYWQpLg0KPiA+DQo+ID4gRml4ZXM6IGNhMDY1ZDBjZjgwZmEgKCJ1ZHA6IG5v
IGxvbmdlciB1c2UgU0xBQl9ERVNUUk9ZX0JZX1JDVSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogRGF2
aWQgTGFpZ2h0IDxkYXZpZC5sYWlnaHRAYWN1bGFiLmNvbT4NCj4gPiAtLS0NCj4gDQo+IEhpIERh
dmlkLCB0aGFua3MgYSBsb3QgZm9yIHRoZSBpbnZlc3RpZ2F0aW9ucy4NCj4gDQo+IEkgZG8gbm90
IHRoaW5rIHRoaXMgaXMgdGhlIHByb3BlciBmaXguDQo+IA0KPiBVRFAgcmVoYXNoIGhhcyBhbHdh
eXMgYmVlbiBidWdneSwgYmVjYXVzZSB3ZSBsYWNrIGFuIHJjdSBncmFjZSBwZXJpb2QNCj4gYmV0
d2VlbiB0aGUgcmVtb3ZhbCBvZiB0aGUgc29ja2V0DQo+IGZyb20gdGhlIG9sZCBoYXNoIGJ1Y2tl
dCB0byB0aGUgbmV3IG9uZS4NCj4gDQo+IFdlIG5lZWQgdG8gc3R1ZmYgYSBzeW5jaHJvbml6ZV9y
Y3UoKSBzb21ld2hlcmUgaW4gdWRwX2xpYl9yZWhhc2goKSwNCj4gYW5kIHRoYXQgbWlnaHQgbm90
IGJlIGVhc3kgWzFdDQo+IGFuZCBtaWdodCBhZGQgdW5leHBlY3RlZCBsYXRlbmN5IHRvIHNvbWUg
cmVhbCB0aW1lIGFwcGxpY2F0aW9ucy4NCj4gKFsxXSA6IE5vdCBzdXJlIGlmIHdlIGFyZSBhbGxv
d2VkIHRvIHNsZWVwIGluIHVkcF9saWJfcmVoYXNoKCkpDQoNCkknbSBhbHNvIG5vdCBzdXJlIHRo
YXQgdGhlIGNhbGxlcnMgd291bGQgYWx3YXlzIGxpa2UgdGhlIHBvdGVudGlhbGx5DQpsb25nIHJj
dSBzbGVlcC4NCg0KPiBBbHNvIG5vdGUgdGhhdCBhZGRpbmcgYSBzeW5jaHJvbml6ZV9yY3UoKSB3
b3VsZCBtZWFuIHRoZSBzb2NrZXQgd291bGQNCj4gbm90IGJlIGZvdW5kIGFueXdheSBieSBzb21l
IGluY29taW5nIHBhY2tldHMuDQo+IA0KPiBJIHRoaW5rIHRoYXQgcmVoYXNoIGlzIHRyaWNreSB0
byBpbXBsZW1lbnQgaWYgeW91IGV4cGVjdCB0aGF0IGFsbA0KPiBpbmNvbWluZyBwYWNrZXRzIG11
c3QgZmluZCB0aGUgc29ja2V0LCB3aGVyZXZlciBpdCBpcyBsb2NhdGVkLg0KDQpJIHRob3VnaHQg
YWJvdXQgc29tZXRoaW5nIGxpa2UgdGhlIGNoZWNrcyBkb25lIGZvciByZWFkaW5nDQptdWx0aS13
b3JkIGNvdW50ZXJzLg0KU29tZXRoaW5nIGxpa2UgcmVxdWlyaW5nIHRoZSB1cGRhdGVyIHRvIGlu
Y3JlbWVudCBhIGNvdW50IG9uDQplbnRyeSBhbmQgZXhpdCBhbmQgaGF2ZSB0aGUgcmVhZGVyIHJl
c2NhbiB3aXRoIHRoZSBsb2NrIGhlbGQNCmlmIHRoZSBjb3VudCBpcyBvZGQgb3IgY2hhbmdlcy4N
Cg0KVGhlIHByb2JsZW0gaXMgdGhhdCBhIHNpbmdsZSAncG9ydCB1bnJlYWNoYWJsZScgY2FuIGJl
IHRyZWF0ZWQNCmFzIGEgZmF0YWwgZXJyb3IgYnkgdGhlIHJlY2VpdmluZyBhcHBsaWNhdGlvbi4N
ClNvIHlvdSByZWFsbHkgZG9uJ3Qgd2FudCB0byBiZSBzZW5kaW5nIHRoZW0uDQoNCj4gDQo+IA0K
PiA+ICBuZXQvaXB2NC91ZHAuYyB8IDE0ICsrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxNCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvdWRw
LmMgYi9uZXQvaXB2NC91ZHAuYw0KPiA+IGluZGV4IGFkNjRkNmM0Y2Q5OS4uZWQ5MmJhNzYxMGIw
IDEwMDY0NA0KPiA+IC0tLSBhL25ldC9pcHY0L3VkcC5jDQo+ID4gKysrIGIvbmV0L2lwdjQvdWRw
LmMNCj4gPiBAQCAtNDQzLDYgKzQ0Myw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc29jayAqdWRwNF9saWJf
bG9va3VwMihzdHJ1Y3QgbmV0ICpuZXQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBza19idWZmICpza2IpDQo+ID4gIHsNCj4gPiAgICAgICAgIHVuc2ln
bmVkIGludCBoYXNoMiwgc2xvdDI7DQo+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgaGFzaDJfcmVz
Y2FuOw0KPiA+ICAgICAgICAgc3RydWN0IHVkcF9oc2xvdCAqaHNsb3QyOw0KPiA+ICAgICAgICAg
c3RydWN0IHNvY2sgKnNrLCAqcmVzdWx0Ow0KPiA+ICAgICAgICAgaW50IHNjb3JlLCBiYWRuZXNz
Ow0KPiA+IEBAIC00NTEsOSArNDUyLDEyIEBAIHN0YXRpYyBzdHJ1Y3Qgc29jayAqdWRwNF9saWJf
bG9va3VwMihzdHJ1Y3QgbmV0ICpuZXQsDQo+ID4gICAgICAgICBzbG90MiA9IGhhc2gyICYgdWRw
dGFibGUtPm1hc2s7DQo+ID4gICAgICAgICBoc2xvdDIgPSAmdWRwdGFibGUtPmhhc2gyW3Nsb3Qy
XTsNCj4gPg0KPiA+ICtyZXNjYW46DQo+ID4gKyAgICAgICBoYXNoMl9yZXNjYW4gPSBoYXNoMjsN
Cj4gPiAgICAgICAgIHJlc3VsdCA9IE5VTEw7DQo+ID4gICAgICAgICBiYWRuZXNzID0gMDsNCj4g
PiAgICAgICAgIHVkcF9wb3J0YWRkcl9mb3JfZWFjaF9lbnRyeV9yY3Uoc2ssICZoc2xvdDItPmhl
YWQpIHsNCj4gPiArICAgICAgICAgICAgICAgaGFzaDJfcmVzY2FuID0gdWRwX3NrKHNrKS0+dWRw
X3BvcnRhZGRyX2hhc2g7DQo+ID4gICAgICAgICAgICAgICAgIHNjb3JlID0gY29tcHV0ZV9zY29y
ZShzaywgbmV0LCBzYWRkciwgc3BvcnQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBkYWRkciwgaG51bSwgZGlmLCBzZGlmKTsNCj4gPiAgICAgICAgICAgICAgICAg
aWYgKHNjb3JlID4gYmFkbmVzcykgew0KPiA+IEBAIC00NjcsNiArNDcxLDE2IEBAIHN0YXRpYyBz
dHJ1Y3Qgc29jayAqdWRwNF9saWJfbG9va3VwMihzdHJ1Y3QgbmV0ICpuZXQsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgYmFkbmVzcyA9IHNjb3JlOw0KPiA+ICAgICAgICAgICAgICAgICB9
DQo+ID4gICAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgLyogdWRwIHNvY2tldHMgY2FuIGdl
dCBtb3ZlZCB0byBhIGRpZmZlcmVudCBoYXNoIGNoYWluLg0KPiA+ICsgICAgICAgICogSWYgdGhl
IGNoYWlucyBoYXZlIGdvdCBjcm9zc2VkIHRoZW4gcmVzY2FuLg0KPiA+ICsgICAgICAgICovDQo+
ID4gKyAgICAgICBpZiAoKGhhc2gyX3Jlc2NhbiAmIHVkcHRhYmxlLT5tYXNrKSAhPSBzbG90Mikg
ew0KPiANCj4gVGhpcyBpcyBvbmx5IGdvaW5nIHRvIGNhdGNoIG9uZSBvZiB0aGUgcG9zc2libGUg
Y2FzZXMuDQo+IA0KPiBJZiB3ZSByZWFsbHkgd2FudCB0byBhZGQgZXh0cmEgY2hlY2tzIGluIHRo
aXMgZmFzdCBwYXRoLCB3ZSB3b3VsZCBoYXZlDQo+IHRvIGNoZWNrIGFsbCBmb3VuZCBzb2NrZXRz
LA0KPiBub3Qgb25seSB0aGUgbGFzdCBvbmUuDQoNCkkgZGlkIHRoaW5rIGFib3V0IHRoYXQuDQpC
ZWluZyBoaXQgYnkgYSBzaW5nbGUgcmVoYXNoIGlzIHZlcnkgdW5saWtlbHkuDQpCZWluZyBoaXQg
YnkgdHdvIHRoYXQgYWxzbyBwdXQgeW91IGJhY2sgb250byB0aGUgb3JpZ2luYWwNCmNoYWluIHJl
YWxseSBpc24ndCBnb2luZyB0byBoYXBwZW4uDQoNClB1dHRpbmcgdGhlIGNoZWNrIGluc2lkZSB0
aGUgbG9vcCB3b3VsZCBzYXZlIHRoZSB0ZXN0IHdoZW4gdGhlDQpoYXNoIGxpc3QgaXMgZW1wdHkg
LSBwcm9iYWJseSBjb21tb24gZm9yIHRoZSBmaXJzdCBsb29rdXAuDQoNClRoZSBjb2RlIGluIGNv
bXB1dGVfc2NvcmUoKSBpcyBwcmV0dHkgaG9ycmlkIHNvIG1heWJlIGl0DQp3b3VsZG4ndCByZWFs
bHkgYmUgbm90aWNlYWJsZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


