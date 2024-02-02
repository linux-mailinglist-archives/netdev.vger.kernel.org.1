Return-Path: <netdev+bounces-68507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597468470CA
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6195B2A386
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5271E20F4;
	Fri,  2 Feb 2024 13:02:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261671872
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878979; cv=none; b=sAk4u+xzU7iRFhwSNIwFM6+lDk3ZbSkOCRj4Sg4KL8chRKv2dSmCLE38YrDxcdSATUS6JIua/yrBGoR3sDv4p/V83ThZPGzA99gD+i4eRppFbdiG8AH7kOIG255vhdnqyW308vl2kLiDxxK+tlML8pB/ZlLJTKdwRUrCaBg4DwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878979; c=relaxed/simple;
	bh=zEo6ZjhQQ89W/HijwzXz240ibMlpI+EvKMp0QLbWbng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=KdpsYhZ1qWvxTx+oDpAVJNJ8EfySusJOBK9rJkSmhDo9rvf7QStZtx03fEdOyIeDZa/hAMIBMAlm66IuTtVuYGfrJOJbyKzMy1c8tz2AOz38d7Xtgj1A3QPoR+CFEXZfZJ/bPiQowbaJVfeTqAuLO+NT2kOUyn1eFhfhZueRGPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-256-uvtxM6aSP9uhVnrgjo1V0Q-1; Fri, 02 Feb 2024 13:02:52 +0000
X-MC-Unique: uvtxM6aSP9uhVnrgjo1V0Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 2 Feb
 2024 13:02:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 2 Feb 2024 13:02:32 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Denis Kirjanov' <dkirjanov@suse.de>, 'Stephen Hemminger'
	<stephen@networkplumber.org>, Denis Kirjanov <kirjanov@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iproute2] ifstat: convert sprintf to snprintf
Thread-Topic: [PATCH iproute2] ifstat: convert sprintf to snprintf
Thread-Index: AQHaVGCdMUuLtnf3K0G1n1AQJlh+tLD27kCAgAAOVwCAAAoxQA==
Date: Fri, 2 Feb 2024 13:02:32 +0000
Message-ID: <d2e9ab2c4df04f0e8f12b623366123eb@AcuMS.aculab.com>
References: <20240131124107.1428-1-dkirjanov@suse.de>
 <20240131081418.72770d85@hermes.local>
 <913e0c6bb6114fdfaa74073fc8b6c2ee@AcuMS.aculab.com>
 <5fa65887-1f56-4470-bc99-383fe7e3f47b@suse.de>
In-Reply-To: <5fa65887-1f56-4470-bc99-383fe7e3f47b@suse.de>
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

RnJvbTogRGVuaXMgS2lyamFub3YNCj4gU2VudDogMDIgRmVicnVhcnkgMjAyNCAxMjoyNA0KPiAN
Cj4gT24gMi8yLzI0IDE0OjMyLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogU3RlcGhl
biBIZW1taW5nZXINCj4gPj4gU2VudDogMzEgSmFudWFyeSAyMDI0IDE2OjE0DQo+ID4NCj4gPj4N
Cj4gPj4gT24gV2VkLCAzMSBKYW4gMjAyNCAwNzo0MTowNyAtMDUwMA0KPiA+PiBEZW5pcyBLaXJq
YW5vdiA8a2lyamFub3ZAZ21haWwuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4+IEBAIC04OTMsNyAr
ODkzLDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4gPj4+DQo+ID4+PiAg
CXN1bi5zdW5fZmFtaWx5ID0gQUZfVU5JWDsNCj4gPj4+ICAJc3VuLnN1bl9wYXRoWzBdID0gMDsN
Cj4gPj4+IC0Jc3ByaW50ZihzdW4uc3VuX3BhdGgrMSwgImlmc3RhdCVkIiwgZ2V0dWlkKCkpOw0K
PiA+Pj4gKwlzbnByaW50ZihzdW4uc3VuX3BhdGgrMSwgc2l6ZW9mKHN1bi5zdW5fcGF0aCksICJp
ZnN0YXQlZCIsIGdldHVpZCgpKTsNCj4gPj4NCj4gPj4gSWYgeW91IGFyZSBjaGFuZ2luZyB0aGUg
bGluZSwgcGxlYXNlIGFkZCBzcGFjZXMgYXJvdW5kIHBsdXMgc2lnbg0KPiA+DQo+ID4gSXNuJ3Qg
dGhlIHNpemUgYWxzbyB3cm9uZyAtIG5lZWRzIGEgbWF0Y2hpbmcgJy0gMScuDQo+IA0KPiBJIGRv
bid0IHRoaW5rIGl0J3Mgd3JvbmcsIGl0J3MganVzdCB0aGUgc2l6ZSBvZiB0aGUgdGFyZ2V0IGJ1
ZmZlciB3aGljaCBpcw0KPiBVTklYX1BBVEhfTUFYIGJ5dGVzLg0KDQpCdXQgeW91IGFyZSBzdGFy
dGluZyBvbmUgYnl0ZSBpbi4NClNvLCBpZiB0aGUgc2l6ZSB3ZXJlIDggdGhlICdcMCcgd291bGQg
YmUgd3JpdHRlbiBhZnRlciB0aGUgZW5kLg0KDQpBbHNvLCB0byBhdm9pZCB0aGUgbmV4dCBwYXRj
aCBpbiBhIGZldyB3ZWVrcyBpdCBzaG91bGQgYmUNCmNhbGxpbmcgc2NucHJpbnRmKCkuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=


