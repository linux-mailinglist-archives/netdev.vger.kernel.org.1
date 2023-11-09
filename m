Return-Path: <netdev+bounces-46912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290EF7E70CE
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 18:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CDE1C209E7
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB1D3034F;
	Thu,  9 Nov 2023 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC972241EF
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 17:51:07 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05463845
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:51:06 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-167-qkI4FkjbOTunzZxys49AaA-1; Thu, 09 Nov 2023 17:51:04 +0000
X-MC-Unique: qkI4FkjbOTunzZxys49AaA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 9 Nov
 2023 17:50:56 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 9 Nov 2023 17:50:56 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'David Ahern' <dsahern@kernel.org>, John Ousterhout
	<ouster@cs.stanford.edu>
CC: Stephen Hemminger <stephen@networkplumber.org>, Andrew Lunn
	<andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: Bypass qdiscs?
Thread-Topic: Bypass qdiscs?
Thread-Index: AQHaEmd2okzX54FRkE6OZa244mM/DbByQMKA
Date: Thu, 9 Nov 2023 17:50:56 +0000
Message-ID: <a455bf52cd8b4594be360b1758ba88cd@AcuMS.aculab.com>
References: <CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>
 <29217dab-e00e-4e4c-8d6a-4088d8e79c8e@lunn.ch>
 <CAGXJAmzn0vFtkVT=JQLQuZm6ae+Ms_nOcvebKPC6ARWfM9DwOw@mail.gmail.com>
 <20231105192309.20416ff8@hermes.local>
 <b80374c7-3f5a-4f47-8955-c16d14e7549a@kernel.org>
 <CAGXJAmz+j0y00XLc2YCyfK5aVPD12aDcrNzc58N1fExT6ceoVw@mail.gmail.com>
 <89cd5f11-2c54-4905-b900-b1e06304805f@kernel.org>
In-Reply-To: <89cd5f11-2c54-4905-b900-b1e06304805f@kernel.org>
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

RnJvbTogRGF2aWQgQWhlcm4NCj4gU2VudDogMDggTm92ZW1iZXIgMjAyMyAxNzoxNw0KPiANCj4g
T24gMTEvOC8yMyA5OjUwIEFNLCBKb2huIE91c3RlcmhvdXQgd3JvdGU6DQo+ID4gSGkgRGF2aWQs
DQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLCBidXQgaWYgSSB1bmRlcnN0YW5k
IHRoaXMgY29ycmVjdGx5LCB0aGlzDQo+ID4gd2lsbCBkaXNhYmxlIHFkaXNjcyBmb3IgVENQIGFz
IHdlbGwgYXMgSG9tYTsgSSBzdXNwZWN0IEkgc2hvdWxkbid0IGRvDQo+ID4gdGhhdD8NCj4gPg0K
PiANCj4gQSBtZWFucyB0byBzZXBhcmF0ZSBpc3N1ZXMgLSBpLmUuLCBydW4gSG9tYSB0ZXN0cyB3
aXRob3V0IHFkaXNjIG92ZXJoZWFkDQo+IG9yIGRlbGF5cy4gWW91IGNhbiB3b3JyeSBhYm91dCBo
b3cgdG8gaGFuZGxlIGlmL3doZW4geW91IHN0YXJ0DQo+IHVwc3RyZWFtaW5nIHRoZSBjb2RlLg0K
DQpJc24ndCB0aGUgcWRpc2Mgb3ZlcmhlYWQgcHJldHR5IG1pbmltYWwgbW9zdCBvZiB0aGUgdGlt
ZSBhbnl3YXk/DQpJZiBJIHNlbmQgYSBSQVdfSVAgKGFuZCBwcm9iYWJseSBVRFApIHBhY2tldCB0
aGUgZXRoZXJuZXQgTUFDDQpwYWNrZXQgc2V0dXAgKGV0YykgaXMgbm9ybWFsbHkgZG9uZSBieSBk
aXJlY3QgY2FsbHMgZnJvbSB0aGUNCnByb2Nlc3MgY2FsbGluZyBzZW5kbXNnKCkuDQoNCklmIHR3
byB0aHJlYWRzIGNhbGwgc2VuZG1zZyAob24gZGlmZmVyZW50IHNvY2tldHMpIGF0IHRoZSBzYW1l
DQp0aW1lIHNvbWV0aGluZyBoYXMgdG8gZ2l2ZSBzb21ld2hlcmUuDQpUbyBhdm9pZCBzdGFsbGlu
ZyB0aGUgMm5kIHRocmVhZCwgdGhlIHBhY2tldCBnZXRzIHF1ZXVlZCBhbmQgaXMNCnBpY2tlZCB1
cCBieSB0aGUgZmlyc3QgdGhyZWFkIGJlZm9yZSBpdCByZXR1cm5zLg0KDQpUbyBieXBhc3MgdGhl
IHFkaXNjIHdvdWxkbid0IHlvdSBuZWVkIGEgTUFDIGRyaXZlciB0aGF0IGNhbg0KcHJvY2Vzc2Vz
IG11bHRpcGxlIHRyYW5zbWl0IHNldHVwIHJlcXVlc3RzIGluIHBhcmFsbGVsPw0KSXQgY2FuIGJl
IGRvbmUgZm9yIGEgc2ltcGxlIG1lbW9yeSByaW5nIGJhc2VkIGludGVyZmFjZSAtIGp1c3QNCnVz
ZSBhIGxvY2sgdG8gZ3JhYiB0aGUgcmVxdWlyZWQgc2xvdHMgaW4gdGhlIHRyYW5zbWl0IHJpbmcu
DQpUaGVuIGl0IGRvZXNuJ3QgbWF0dGVyIHdoaWNoIG9yZGVyIHNldHVwcyBjb21wbGV0ZSBpbi4N
CkJ1dCBJIGRvbid0IHRoaW5rIExpbnV4IG1ha2VzIHRoYXQgZWFzeSB0byB3cml0ZS4NCg0KVHJh
bnNtaXQgZmxvdyBjb250cm9sIHdpbGwgYWxzbyByZXF1aXJlIHF1ZXVlaW5nIChvciBkaXNjYXJk
KS4NCklmIEhvbWEgYW5kIFRDUCBhcmUgc2hhcmluZyBhIHBoeXNpY2FsIG5ldHdvcmsgdGhlbiBz
dXJlbHkgdGhlDQpUQ1AgdHJhZmZpYyBjYW4gY2F1c2UgZmxvdyBjb250cm9sIGlzc3VlIGZvciBi
b3RoPw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K


