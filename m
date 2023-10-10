Return-Path: <netdev+bounces-39471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D07BF646
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE310281A98
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 08:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA29DF44;
	Tue, 10 Oct 2023 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9DF6119
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 08:42:40 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C6DBA
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 01:42:36 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-146-VGK_azFWMvGKG-U3WrIf9A-1; Tue, 10 Oct 2023 09:42:34 +0100
X-MC-Unique: VGK_azFWMvGKG-U3WrIf9A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 10 Oct
 2023 09:42:33 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 10 Oct 2023 09:42:33 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'Eric W. Biederman'" <ebiederm@xmission.com>,
	=?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
CC: David Ahern <dsahern@gmail.com>, Stephen Hemminger
	<stephen@networkplumber.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Christian Brauner <brauner@kernel.org>
Subject: RE: [RFC PATCH iproute2-next 0/5] Persisting of mount namespaces
 along with network namespaces
Thread-Topic: [RFC PATCH iproute2-next 0/5] Persisting of mount namespaces
 along with network namespaces
Thread-Index: AQHZ+u/SbR3ie7S+G06sCW6DDmmIAbBCss7Q
Date: Tue, 10 Oct 2023 08:42:32 +0000
Message-ID: <6fc0ae94f5554c6ea320dba1d6fe84aa@AcuMS.aculab.com>
References: <20231009182753.851551-1-toke@redhat.com>
 <877cnvtu37.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <877cnvtu37.fsf@email.froward.int.ebiederm.org>
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

RnJvbTogRXJpYyBXLiBCaWVkZXJtYW4NCj4gU2VudDogMDkgT2N0b2JlciAyMDIzIDIxOjMzDQo+
IA0KPiBUb2tlIEjDuGlsYW5kLUrDuHJnZW5zZW4gPHRva2VAcmVkaGF0LmNvbT4gd3JpdGVzOg0K
PiANCj4gPiBUaGUgJ2lwIG5ldG5zJyBjb21tYW5kIGlzIHVzZWQgZm9yIHNldHRpbmcgdXAgbmV0
d29yayBuYW1lc3BhY2VzIHdpdGggcGVyc2lzdGVudA0KPiA+IG5hbWVkIHJlZmVyZW5jZXMsIGFu
ZCBpcyBpbnRlZ3JhdGVkIGludG8gdmFyaW91cyBvdGhlciBjb21tYW5kcyBvZiBpcHJvdXRlMiB2
aWENCj4gPiB0aGUgLW4gc3dpdGNoLg0KPiA+DQo+ID4gVGhpcyBpcyB1c2VmdWwgYm90aCBmb3Ig
dGVzdGluZyBzZXR1cHMgYW5kIGZvciBzaW1wbGUgc2NyaXB0LWJhc2VkIG5hbWVzcGFjaW5nDQo+
ID4gYnV0IGhhcyBvbmUgZHJhd2JhY2s6IHRoZSBsYWNrIG9mIHBlcnNpc3RlbnQgbW91bnRzIGlu
c2lkZSB0aGUgc3Bhd25lZA0KPiA+IG5hbWVzcGFjZS4gVGhpcyBpcyBwYXJ0aWN1bGFybHkgYXBw
YXJlbnQgd2hlbiB3b3JraW5nIHdpdGggQlBGIHByb2dyYW1zIHRoYXQgdXNlDQo+ID4gcGlubmlu
ZyB0byBicGZmczogYnkgZGVmYXVsdCBubyBicGZmcyBpcyBhdmFpbGFibGUgaW5zaWRlIGEgbmFt
ZXNwYWNlLCBhbmQNCj4gPiBldmVuIGlmIG1vdW50aW5nIG9uZSwgdGhhdCBmcyBkaXNhcHBlYXJz
IGFzIHNvb24gYXMgdGhlIGNhbGxpbmcNCj4gPiBjb21tYW5kIGV4aXRzLg0KPiANCj4gSXQgd291
bGQgYmUgZW50aXJlbHkgcmVhc29uYWJsZSB0byBjb3B5IG1vdW50cyBsaWtlIC9zeXMvZnMvYnBm
IGZyb20gdGhlDQo+IG9yaWdpbmFsIG1vdW50IG5hbWVzcGFjZSBpbnRvIHRoZSB0ZW1wb3Jhcnkg
bW91bnQgbmFtZXNwYWNlIHVzZWQgYnkNCj4gImlwIG5ldG5zIi4NCj4gDQo+IEkgd291bGQgY2Fs
bCBpdCBhIGJ1ZyB0aGF0ICJpcCBuZXRucyIgZG9lc24ndCBkbyB0aGF0IGFscmVhZHkuDQo+IA0K
PiBJIHN1c3BlY3QgdGhhdCAiaXAgbmV0bnMiIGRvZXMgY29weSB0aGUgbW91bnRzIGZyb20gdGhl
IG9sZCBzeXNmcyBvbnRvDQo+IHRoZSBuZXcgc3lzZnMgaXMgeW91ciBlbnRpcmUgcHJvYmxlbS4N
Cg0KV2hlbiBJIHdhcyBnZXR0aW5nIGEgcHJvZ3JhbSB0byBydW4gaW4gbXVsdGlwbGUgbmV0d29y
ayBuYW1lc3BhY2VzDQooaGFzIHNvY2tldHMgaW4gMiBuYW1lc3BhY2VzKSBJIHJhdGhlciBleHBl
Y3RlZCB0aGF0IG5ldG5zKG5ldF9uc19mZCwwKQ0Kd291bGQgJ21hZ2ljYWxseScgY2hhbmdlIC9w
cm9jL25ldCB0byByZWZlciB0byB0aGUgbmV3IG5hbWVzcGFjZS4NCkkgdGhpbmsgdGhhdCBjb3Vs
ZCBiZSBkb25lIGluIHRoZSBjb2RlIHRoYXQgZm9sbG93cyB0aGUgL3Byb2MvbmV0DQptb3VudHBv
aW50IC0gSUlSQyBzb21ldGhpbmcgc2ltaWxhciBpcyBkb25lIGZvciAvcHJvYy9zZWxmLg0KDQpI
b3dldmVyIHRoYXQgd291bGQgbmVlZCBmbGFncyB0byBib3RoIHNldG5zKCkgYW5kICdpcCBuZXRu
cyBleGVjJw0Kc2luY2UgcHJvZ3JhbXMgd2lsbCByZWx5IG9uIHRoZSBleGlzdGluZyBiZWhhdmlv
dXIuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=


