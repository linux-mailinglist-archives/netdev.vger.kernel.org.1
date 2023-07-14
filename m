Return-Path: <netdev+bounces-17974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7A2753E94
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 17:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DAF1C213CC
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CE514264;
	Fri, 14 Jul 2023 15:15:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B72EEA8
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 15:15:16 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECD92702
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:15:15 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-214-z_aTFH2eN_WdpUgF54RWmQ-1; Fri, 14 Jul 2023 16:15:12 +0100
X-MC-Unique: z_aTFH2eN_WdpUgF54RWmQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 14 Jul
 2023 16:15:11 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 14 Jul 2023 16:15:11 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Matthieu Baerts' <matthieu.baerts@tessares.net>, Pedro Tammela
	<pctammela@mojatatu.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
CC: netdev <netdev@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>,
	Davide Caratti <dcaratti@redhat.com>
Subject: RE: TC: selftests: current timeout (45s) is too low
Thread-Topic: TC: selftests: current timeout (45s) is too low
Thread-Index: AQHZtM83quqHPH8zFEOonSp0IzsmHq+5YaIw
Date: Fri, 14 Jul 2023 15:15:11 +0000
Message-ID: <ca8565fbbd614c8489c38761db2959de@AcuMS.aculab.com>
References: <0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net>
 <2cf3499b-03dc-4680-91f6-507ba7047b96@mojatatu.com>
 <3acc88b6-a42d-c054-9dae-8aae22348a3e@tessares.net>
In-Reply-To: <3acc88b6-a42d-c054-9dae-8aae22348a3e@tessares.net>
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
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogTWF0dGhpZXUgQmFlcnRzDQo+IFNlbnQ6IDEyIEp1bHkgMjAyMyAxNTo0Mw0KPiANCj4g
SGkgUGVkcm8sDQo+IA0KPiBPbiAxMi8wNy8yMDIzIDE1OjQzLCBQZWRybyBUYW1tZWxhIHdyb3Rl
Og0KPiA+IEkgaGF2ZSBiZWVuIGludm9sdmVkIGluIHRkYyBmb3IgYSB3aGlsZSBub3csIGhlcmUg
YXJlIG15IGNvbW1lbnRzLg0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5IQ0KPiANCj4g
PiBPbiAxMi8wNy8yMDIzIDA2OjQ3LCBNYXR0aGlldSBCYWVydHMgd3JvdGU6DQo+ID4+IEhpIEph
bWFsLCBDb25nLCBKaXJpLA0KPiA+Pg0KPiA+PiBXaGVuIGxvb2tpbmcgZm9yIHNvbWV0aGluZyBl
bHNlIFsxXSBpbiBMS0ZUIHJlcG9ydHMgWzJdLCBJIG5vdGljZWQgdGhhdA0KPiA+PiB0aGUgVEMg
c2VsZnRlc3QgZW5kZWQgd2l0aCBhIHRpbWVvdXQgZXJyb3I6DQo+ID4+DQo+ID4+IMKgwqAgbm90
IG9rIDEgc2VsZnRlc3RzOiB0Yy10ZXN0aW5nOiB0ZGMuc2ggIyBUSU1FT1VUIDQ1IHNlY29uZHMN
Ci4uLg0KPiA+PiBJJ20gc2VuZGluZyB0aGlzIGVtYWlsIGluc3RlYWQgb2YgYSBwYXRjaCBiZWNh
dXNlIEkgZG9uJ3Qga25vdyB3aGljaA0KPiA+PiB2YWx1ZSBtYWtlcyBzZW5zZS4gSSBndWVzcyB5
b3Uga25vdyBob3cgbG9uZyB0aGUgdGVzdHMgY2FuIHRha2UgaW4gYQ0KPiA+PiAodmVyeSkgc2xv
dyBlbnZpcm9ubWVudCBhbmQgeW91IG1pZ2h0IHdhbnQgdG8gYXZvaWQgdGhpcyB0aW1lb3V0IGVy
cm9yLg0KPiA+DQo+ID4gSSBiZWxpZXZlIGEgdGltZW91dCBiZXR3ZWVuIDUtMTAgdG8gbWludXRl
cyBzaG91bGQgY292ZXIgdGhlIGVudGlyZSBzdWl0ZQ0KPiANCj4gVGhhbmsgeW91IGZvciB5b3Vy
IGZlZWRiYWNrLg0KPiBJZiB3ZSB3YW50IHRvIGJlIG9uIHRoZSBzYWZlIHNpZGUsIEkgZ3Vlc3Mg
aXQgaXMgYmV0dGVyIHRvIHB1dCAxMA0KPiBtaW51dGVzIG9yIGV2ZW4gMTUsIG5vPw0KDQpJcyBp
dCBwb3NzaWJsZSB0byB1c2UgdGhlIHRpbWUgdGFrZW4gZm9yIGFuIGluaXRpYWwgdGVzdA0KdG8g
c2NhbGUgdGhlIHRpbWVvdXQgZm9yIGFsbCB0aGUgdGVzdHM/DQoNClRoZW4geW91IGNvdWxkIGhh
dmUgYSA0NXNlY29uZCB0aW1lb3V0IG9uIGEgZmFzdCBzeXN0ZW0gYW5kDQphIG11Y2ggbG9uZ2Vy
IHRpbWVvdXQgb24gYSBzbG93IG9uZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


