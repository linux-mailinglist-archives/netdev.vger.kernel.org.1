Return-Path: <netdev+bounces-135290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0091E99D6FD
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 21:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76875B22261
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 19:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113EE1CACF9;
	Mon, 14 Oct 2024 19:04:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A91A76CC
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728932687; cv=none; b=myAl1tbbA8Ckn/LrQkK7uRG2biCUn/K4uY09q6K09NiZSih7O/2Z/sbdEBiAD548b4BL/eu5Ur1r7hcbtV0yslI4G1nZwZ2RGHQG3fo4Jz0RHUXXAVODXIMzlJdRSBCFSlUovwyWZePBsSyK0Qr8A4GSJJ2XijPFIlwG11tYxUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728932687; c=relaxed/simple;
	bh=S346DqSFl7/gcpomNKwVPze4NJfmyem8qncuPJ+JhEw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=H01pZNTOeRGlpQZHAepmRIKi1LiiIAutqQ8eolOnQwvQzKxcWIpr5kp6qonh6WyO4MRbcOCM8OzElHsn4wuhiTBlzkN1EUNB5S6EeeU4nekGycZl+DjhsVgrGqVp6j3pNDC2DpRUyAKjvaCYk9Ajof/48y2hvMzWUBMbc0sVtoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-220-pDP3ThQGNACk57nwVo0TMw-1; Mon, 14 Oct 2024 20:04:35 +0100
X-MC-Unique: pDP3ThQGNACk57nwVo0TMw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 14 Oct
 2024 20:04:34 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 14 Oct 2024 20:04:34 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jacob Keller' <jacob.e.keller@intel.com>, Simon Horman
	<horms@kernel.org>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pawel.chmielewski@intel.com" <pawel.chmielewski@intel.com>,
	"sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
	"pio.raczynski@gmail.com" <pio.raczynski@gmail.com>,
	"konrad.knitter@intel.com" <konrad.knitter@intel.com>,
	"marcin.szycik@intel.com" <marcin.szycik@intel.com>,
	"wojciech.drewek@intel.com" <wojciech.drewek@intel.com>,
	"nex.sw.ncis.nat.hpm.dev@intel.com" <nex.sw.ncis.nat.hpm.dev@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>
Subject: RE: [iwl-next v4 3/8] ice: get rid of num_lan_msix field
Thread-Topic: [iwl-next v4 3/8] ice: get rid of num_lan_msix field
Thread-Index: AQHbHmoCqcXBLFNJnUCdfpROPNqWFbKGmCGQ
Date: Mon, 14 Oct 2024 19:04:34 +0000
Message-ID: <3e015d17e53f4cdd813c88c93b966810@AcuMS.aculab.com>
References: <20240930120402.3468-1-michal.swiatkowski@linux.intel.com>
 <20240930120402.3468-4-michal.swiatkowski@linux.intel.com>
 <20241012151304.GK77519@kernel.org>
 <636e511e-055d-4b7d-8fdb-13e546ff5b90@intel.com>
In-Reply-To: <636e511e-055d-4b7d-8fdb-13e546ff5b90@intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
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

RnJvbTogSmFjb2IgS2VsbGVyDQo+IFNlbnQ6IDE0IE9jdG9iZXIgMjAyNCAxOTo1MQ0KPiANCj4g
T24gMTAvMTIvMjAyNCA4OjEzIEFNLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+ID4gKyBEYXZpZCBM
YWlnaHQNCj4gPg0KPiA+IE9uIE1vbiwgU2VwIDMwLCAyMDI0IGF0IDAyOjAzOjU3UE0gKzAyMDAs
IE1pY2hhbCBTd2lhdGtvd3NraSB3cm90ZToNCj4gPj4gUmVtb3ZlIHRoZSBmaWVsZCB0byBhbGxv
dyBoYXZpbmcgbW9yZSBxdWV1ZXMgdGhhbiBNU0ktWCBvbiBWU0kuIEFzDQo+ID4+IGRlZmF1bHQg
dGhlIG51bWJlciB3aWxsIGJlIHRoZSBzYW1lLCBidXQgaWYgdGhlcmUgd29uJ3QgYmUgbW9yZSBN
U0ktWA0KPiA+PiBhdmFpbGFibGUgVlNJIGNhbiBydW4gd2l0aCBhdCBsZWFzdCBvbmUgTVNJLVgu
DQo+ID4+DQo+ID4+IFJldmlld2VkLWJ5OiBXb2pjaWVjaCBEcmV3ZWsgPHdvamNpZWNoLmRyZXdl
a0BpbnRlbC5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhbCBTd2lhdGtvd3NraSA8bWlj
aGFsLnN3aWF0a293c2tpQGxpbnV4LmludGVsLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlLmggICAgICAgICB8ICAxIC0NCj4gPj4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfYmFzZS5jICAgIHwgMTAgKysrLS0tLS0NCj4g
Pj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZXRodG9vbC5jIHwgIDggKysr
LS0tDQo+ID4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2lycS5jICAgICB8
IDExICsrKy0tLS0tLQ0KPiA+PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9s
aWIuYyAgICAgfCAyNiArKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+PiAgNSBmaWxlcyBjaGFuZ2Vk
LCAyNyBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2UuaCBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2ljZS9pY2UuaA0KPiA+PiBpbmRleCBjZjgyNGQwNDFkNWEuLjFlMjNhZWMy
NjM0ZiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2lj
ZS5oDQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2UuaA0KPiA+
PiBAQCAtNjIyLDcgKzYyMiw2IEBAIHN0cnVjdCBpY2VfcGYgew0KPiA+PiAgCXUxNiBtYXhfcGZf
dHhxczsJLyogVG90YWwgVHggcXVldWVzIFBGIHdpZGUgKi8NCj4gPj4gIAl1MTYgbWF4X3BmX3J4
cXM7CS8qIFRvdGFsIFJ4IHF1ZXVlcyBQRiB3aWRlICovDQo+ID4+ICAJc3RydWN0IGljZV9wZl9t
c2l4IG1zaXg7DQo+ID4+IC0JdTE2IG51bV9sYW5fbXNpeDsJLyogVG90YWwgTVNJWCB2ZWN0b3Jz
IGZvciBiYXNlIGRyaXZlciAqLw0KPiA+PiAgCXUxNiBudW1fbGFuX3R4OwkJLyogbnVtIExBTiBU
eCBxdWV1ZXMgc2V0dXAgKi8NCj4gPj4gIAl1MTYgbnVtX2xhbl9yeDsJCS8qIG51bSBMQU4gUngg
cXVldWVzIHNldHVwICovDQo+ID4+ICAJdTE2IG5leHRfdnNpOwkJLyogTmV4dCBmcmVlIHNsb3Qg
aW4gcGYtPnZzaVtdIC0gMC1iYXNlZCEgKi8NCj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2V0aHRvb2wuYw0KPiBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZXRodG9vbC5jDQo+ID4+IGluZGV4
IDg1YTNiMjMyNmU3Yi4uZTVjNTZlYzhiYmRhIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2V0aHRvb2wuYw0KPiA+PiArKysgYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2V0aHRvb2wuYw0KPiA+PiBAQCAtMzgxMSw4ICszODEx
LDggQEAgaWNlX2dldF90c19pbmZvKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHN0cnVjdCBrZXJu
ZWxfZXRodG9vbF90c19pbmZvICppbmZvKQ0KPiA+PiAgICovDQo+ID4+ICBzdGF0aWMgaW50IGlj
ZV9nZXRfbWF4X3R4cShzdHJ1Y3QgaWNlX3BmICpwZikNCj4gPj4gIHsNCj4gPj4gLQlyZXR1cm4g
bWluMyhwZi0+bnVtX2xhbl9tc2l4LCAodTE2KW51bV9vbmxpbmVfY3B1cygpLA0KPiA+PiAtCQkg
ICAgKHUxNilwZi0+aHcuZnVuY19jYXBzLmNvbW1vbl9jYXAubnVtX3R4cSk7DQo+ID4+ICsJcmV0
dXJuIG1pbl90KHUxNiwgbnVtX29ubGluZV9jcHVzKCksDQo+ID4+ICsJCSAgICAgcGYtPmh3LmZ1
bmNfY2Fwcy5jb21tb25fY2FwLm51bV90eHEpOw0KPiA+DQo+ID4gSXQgaXMgdW5jbGVhciB3aHkg
bWluX3QoKSBpcyB1c2VkIGhlcmUgb3IgZWxzZXdoZXJlIGluIHRoaXMgcGF0Y2gNCj4gPiBpbnN0
ZWFkIG9mIG1pbigpIGFzIGl0IHNlZW1zIHRoYXQgYWxsIHRoZSBlbnRpdGllcyBiZWluZyBjb21w
YXJlZA0KPiA+IGFyZSB1bnNpZ25lZC4gQXJlIHlvdSBjb25jZXJuZWQgYWJvdXQgb3ZlcmZsb3dp
bmcgdTE2PyBJZiBzbywgcGVyaGFwcw0KPiA+IGNsYW1wLCBvciBzb21lIGVycm9yIGhhbmRsaW5n
LCBpcyBhIGJldHRlciBhcHByb2FjaC4NCj4gPg0KPiA+IEkgYW0gY29uY2VybmVkIHRoYXQgdGhl
IGNhc3RpbmcgdGhhdCBtaW5fdCgpIGJyaW5ncyB3aWxsIGhpZGUNCj4gPiBhbnkgcHJvYmxlbXMg
dGhhdCBtYXkgZXhpc3QuDQo+ID4NCj4gWWEsIEkgdGhpbmsgbWluIG1ha2VzIG1vcmUgc2Vuc2Uu
IG1pbl90IHdhcyBsaWtlbHkgc2VsZWN0ZWQgb3V0IG9mIGhhYml0DQo+IG9yIGxvb2tpbmcgYXQg
b3RoZXIgZXhhbXBsZXMgaW4gdGhlIGRyaXZlci4NCg0KTXkgJ3Nwb3QgcGF0Y2hlcyB0aGF0IHVz
ZSBtaW5fdCgpJyBmYWlsZWQgdG8gc3BvdCB0aGF0IG9uZS4NCg0KQnV0IGl0IGlzIGp1c3QgcGxh
aW4gd3JvbmcgLSBhbmQgYWx3YXlzIHdhcy4NCllvdSB3YW50IGEgcmVzdWx0IHRoYXQgaXMgMTZi
aXRzLCBjYXN0aW5nIHRoZSBpbnB1dHMgaXMgd3JvbmcuDQpDb25zaWRlciBhIHN5c3RlbSB3aXRo
IDY0ayBjcHVzIQ0KDQpQcmV0dHkgbXVjaCBhbGwgdGhlIG1pbl90KCkgdGhhdCBzcGVjaWZ5IHU4
IG9yIHUxNiBhcmUgbGlrZWx5IHRvDQpiZSBhY3R1YWxseSBicm9rZW4uDQpNb3N0IG9mIHRoZSBy
ZXN0IHNwZWNpZnkgdTMyIG9yIHU2NCBpbiBvcmRlciB0byBjb21wYXJlICh1c3VhbGx5KQ0KdW5z
aWduZWQgdmFsdWVzIG9mIGRpZmZlcmVudCBzaXplcy4NCkJ1dCBJIGZvdW5kIHNvbWUgdGhhdCBt
aWdodCBiZSB1c2luZyAnbG9uZycgb24gNjRiaXQgdmFsdWVzDQpvbiAzMmJpdCAoYW5kIGFzIGRp
c2sgc2VjdG9yIG51bWJlcnMhKS4NCg0KSW4gdGhlIGN1cnJlbnQgbWluKCkgYmxlYXRzLCB0aGUg
Y29kZSBpcyBhbG1vc3QgY2VydGFpbmx5IGF3cnkuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


