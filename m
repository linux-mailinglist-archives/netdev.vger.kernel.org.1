Return-Path: <netdev+bounces-39719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A527C42F9
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 23:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EBCA1C20BF1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4F43E493;
	Tue, 10 Oct 2023 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1F315B3
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 21:51:30 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5311099
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:51:28 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-78-tcLreq_3OpmKTMFnNuRD3Q-1; Tue, 10 Oct 2023 22:51:25 +0100
X-MC-Unique: tcLreq_3OpmKTMFnNuRD3Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 10 Oct
 2023 22:51:24 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 10 Oct 2023 22:51:24 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'Eric W. Biederman'" <ebiederm@xmission.com>
CC: =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, "David
 Ahern" <dsahern@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Christian Brauner <brauner@kernel.org>
Subject: RE: [RFC PATCH iproute2-next 0/5] Persisting of mount namespaces
 along with network namespaces
Thread-Topic: [RFC PATCH iproute2-next 0/5] Persisting of mount namespaces
 along with network namespaces
Thread-Index: AQHZ+7CCbR3ie7S+G06sCW6DDmmIAbBDir/Q
Date: Tue, 10 Oct 2023 21:51:24 +0000
Message-ID: <1a742a86ff7f4b408506bda4de4a9390@AcuMS.aculab.com>
References: <20231009182753.851551-1-toke@redhat.com>
	<877cnvtu37.fsf@email.froward.int.ebiederm.org>
	<6fc0ae94f5554c6ea320dba1d6fe84aa@AcuMS.aculab.com>
 <87edi2jmsw.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87edi2jmsw.fsf@email.froward.int.ebiederm.org>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogRXJpYyBXLiBCaWVkZXJtYW4NCj4gU2VudDogMTAgT2N0b2JlciAyMDIzIDIwOjMzDQo+
IA0KPiBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBBQ1VMQUIuQ09NPiB3cml0ZXM6DQo+IA0K
PiA+IEZyb206IEVyaWMgVy4gQmllZGVybWFuDQo+ID4+IFNlbnQ6IDA5IE9jdG9iZXIgMjAyMyAy
MTozMw0KPiA+Pg0KLi4uDQo+ID4gV2hlbiBJIHdhcyBnZXR0aW5nIGEgcHJvZ3JhbSB0byBydW4g
aW4gbXVsdGlwbGUgbmV0d29yayBuYW1lc3BhY2VzDQo+ID4gKGhhcyBzb2NrZXRzIGluIDIgbmFt
ZXNwYWNlcykgSSByYXRoZXIgZXhwZWN0ZWQgdGhhdCBuZXRucyhuZXRfbnNfZmQsMCkNCj4gPiB3
b3VsZCAnbWFnaWNhbGx5JyBjaGFuZ2UgL3Byb2MvbmV0IHRvIHJlZmVyIHRvIHRoZSBuZXcgbmFt
ZXNwYWNlLg0KPiA+IEkgdGhpbmsgdGhhdCBjb3VsZCBiZSBkb25lIGluIHRoZSBjb2RlIHRoYXQg
Zm9sbG93cyB0aGUgL3Byb2MvbmV0DQo+ID4gbW91bnRwb2ludCAtIElJUkMgc29tZXRoaW5nIHNp
bWlsYXIgaXMgZG9uZSBmb3IgL3Byb2Mvc2VsZi4NCj4gDQo+IC9wcm9jL3NlbGYvbmV0IGRvZXMg
Zm9sbG93IHlvdXIgY3VycmVudCBuZXR3b3JrIG5hbWVzcGFjZSBsYXN0IEkgbG9va2VkLg0KPiAN
Cj4gT2YgY291cnNlIGlmIHlvdSBhcmUgdGhyZWFkZWQgeW91IG1heSBuZWVkIHRvIGxvb2sgYXQN
Cj4gL3Byb2MvdGhyZWFkLXNlbGYvbmV0IGFzIHlvdXIgbmV0d29yayBuYW1lc3BhY2UgaXMgcGVy
IHRocmVhZC4NCg0KWWVzLCBJIHJlbWVtYmVyIHRoYXQgbm93LCBhbmQgL3Byb2MvbmV0IGlzIHRo
ZSB3cm9uZyBzeW1saW5rLg0KDQoNCj4gSXQgaXMgYWxzbyBxdWl0ZSBldmlsLiAgVGhlIHByb2Js
ZW0gaXMgdGhhdCBoYXZpbmcgZGlmZmVyZW50IGVudHJpZXMNCj4gY2FjaGVkIHVuZGVyIHRoZSBz
YW1lIG5hbWUgaXMgYSBtYWpvciBtZXNzLiAgRXZlciBzaW5jZSBJIG1hZGUgdGhhdA0KPiBtaXN0
YWtlIEkgaGF2ZSBiZWVuIGFpbWluZyBhdCBkZXNpZ25zIHRoYXQgZG9uJ3QgZmlnaHQgdGhlIGRj
YWNoZS4NCj4gDQo+IEV2ZW4gaW4gdGhhdCBjYXNlIEkgdGhpbmsgSSBsaW1pdGVkIGl0IHRvIGp1
c3QgYSBlbnRyeSB3aGVyZQ0KPiB1Z2xpbmVzcyBoYXBwZW5zLg0KDQpJdCBpcyBuaWNlIGZyb20g
YSB1c2VyIHBvaW50IG9mIHZpZXcuLi4NCg0KSSdkIGd1ZXNzIGEgJ21hZ2ljIHN5bWxpbmsnIHRo
YXQgcG9pbnRzIG9mZiBzb21ld2hlcmUgZml4ZWQNCndvdWxkIGJlIGEgbGl0dGxlIGNsZWFuZXIu
DQoNCj4gPiBIb3dldmVyIHRoYXQgd291bGQgbmVlZCBmbGFncyB0byBib3RoIHNldG5zKCkgYW5k
ICdpcCBuZXRucyBleGVjJw0KPiA+IHNpbmNlIHByb2dyYW1zIHdpbGwgcmVseSBvbiB0aGUgZXhp
c3RpbmcgYmVoYXZpb3VyLg0KPiANCj4gWW91IG1pZ2h0IHdhbnQgdG8gbG9vayBhZ2Fpbi4NCg0K
VGhlIHByb2JsZW0gd2FzIHdpdGggL3N5cy9jbGFzcy9uZXQNCg0KSSBlbmRlZCB1cCBkb2luZzoN
CglpcCBuZXRucyBleGVjIGZ1YmFyIHByb2dyYW0gYXJncyAzPC9zeXMvY2xhc3MvbmV0DQoNClNv
IHRoYXQgb3BlbigiL3N5cy9jbGFzcy9uZXQveHh4Iikgd2FzIGluc2lkZSB0aGUgZnViYXIgbmFt
ZXNwYWNlDQphbmQgb3BlbmF0KDMsICJ4eHgiKSB3YXMgaW4gdGhlIGRlZmF1bHQgbmFtZXNwYWNl
Lg0KDQpCdXQgSSB0aGluazoNCj4gT24gImlwIG5ldG5zIGFkZCBOQU1FIg0KPiAtIGNyZWF0ZSB0
aGUgbmV0d29yayBuYW1lc3BhY2UgYW5kIG1vdW50IGl0IGF0IC9ydW4vbmV0bnMvTkFNRQ0KPiAt
IG1vdW50IHRoZSBhcHByb3ByaWF0ZSBzeXNmcyBhdCAvcnVuL25ldG5zLW1vdW50cy9OQU1FL3N5
cw0KPiAtIG1vdW50IHRoZSBhcHByb3ByaWF0ZSBicGZmcyBhdCAvcnVuL25ldG5zLW1vdW50cy9O
QU1FL3N5cy9mcy9icGYNCg0Kd291bGQgbWFrZSBpdCBwb3NzaWJsZSBmb3IgYSBwcm9ncmFtIHRv
IHJlYWQgKGVnKQ0KL3N5cy9jbGFzcy9uZXQvaW50ZXJmYWNlL3NwZWVkIGZvciBpbnRlcmZhY2Vz
IGluIG11bHRpcGxlDQpuZXR3b3JrIG5hbWVzcGFjZXMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


