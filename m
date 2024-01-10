Return-Path: <netdev+bounces-62783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 405928292D2
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 04:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD991F26184
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 03:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9E923DB;
	Wed, 10 Jan 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="l2ORJgWi"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2142.outbound.protection.outlook.com [40.92.62.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7043823D5
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 03:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gx/rRtlARWZk9uEqNCSEE3w8KlJIGWirrp4gvQQo7b16JS/H4skDtCJTldjVigZ5/aeHkik4pEOJhJCZCR+xrbfQQkbEpC/YPwW13wmQ4X3TnziN0hmaG2p6c5T0iSTaZxKXHcpldsyIfjMOQC6sqDJeI5AnLJEGZvQKLbU0f3N6aSQjzDVSkn0/DwYg0yBrbLpy7hCq6GLmzUVU1KDSrGdWyGYe+7WIqFlnV91DqaUqX/12zfu0cH0h5T9fZjj2UyiMT/Q2oKdqv5ATcUqmFh1bc739Yk7HDocy3mhyPC/F/jwX89yB63tmoRLKSqNothl898+2R+frlVphyLYBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2aSULUs4Wz0qsWj2a5fVNhQHZFplDOSOxgwyGUKGzQ=;
 b=OHpOMeFyWZyNJTS8TZwh1Ecld4KdjSINSw5LrMPg71WVQca0Vpy7w+kEVPWmDMh246SczTwx3Hb8L0LzvWJW2G7W9yUbnz8eODqWKRfZNgK8p2iJvoUfnIJBsoaVvtx+WvzA9nOmGnb62/qPRFmhW3Vv44NulPV+dT1LXit5+oTnCplc4kXH9aKR+hYKmv2QtMG69Oqsxoy1u0U3yVwJay+tU4EO8gHlIbjhUBZFJCGOgmT7S6urZDqus1/TdZ5HKqy5fnJLq7VzvyVatkhgpVSGb4Wm76A54UtSDAGnruTMMSitGqgiYfFtP2ZHc4M+ddadIV5PbK+ThOWLPhslWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2aSULUs4Wz0qsWj2a5fVNhQHZFplDOSOxgwyGUKGzQ=;
 b=l2ORJgWiMMI/PWy8Kbs7ONnLUW1tF6+3x7EMNAYs0IKdr+Gqpode7A7D8bdq4ogWcDmHvPZaXzphHdL263o4eFKB5x11p6jirXkgs5vrbGaC8qLSPBr7jEnT8kcSE8oWOCB1QJW7SfgwXJXDPGXpXG5u7I+jy3/axmWF6eapd3uTPQFmJHwqQ+yVDdIZjCnPz6RKj/2DJ0aCKfzVYR2T8r8mJGjvfy0zigP8NDlTbiw/f/rj8mpj+FDjP5DDnqegVwY6yg9eoVa5MhGUmj6+sX6l3bIrTUK5oGXQHYAMuQE0LwrSuV3g6qW8mK2fnFgh+2hXBgYGiSi8ueKOkt5x6Q==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SYYP282MB1391.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.17; Wed, 10 Jan 2024 03:40:19 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd%5]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 03:40:19 +0000
From: Jinjian Song <SongJinJian@hotmail.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, Sergey Ryazanov
	<ryazanov.s.a@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"chandrashekar.devegowda@intel.com" <chandrashekar.devegowda@intel.com>,
	"chiranjeevi.rapolu@linux.intel.com" <chiranjeevi.rapolu@linux.intel.com>,
	"haijun.liu@mediatek.com" <haijun.liu@mediatek.com>,
	"m.chetan.kumar@linux.intel.com" <m.chetan.kumar@linux.intel.com>,
	"ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>,
	"loic.poulain@linaro.org" <loic.poulain@linaro.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.com"
	<linux-kernel@vger.kernel.com>, "vsankar@lenovo.com" <vsankar@lenovo.com>,
	"danielwinkler@google.com" <danielwinkler@google.com>, "nmarupaka@google.com"
	<nmarupaka@google.com>, "joey.zhao@fibocom.com" <joey.zhao@fibocom.com>,
	"liuqf@fibocom.com" <liuqf@fibocom.com>, "felix.yan@fibocom.com"
	<felix.yan@fibocom.com>, Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next v3 2/3] net: wwan: t7xx: Add sysfs attribute for device
 state machine
Thread-Topic: [net-next v3 2/3] net: wwan: t7xx: Add sysfs attribute for
 device state machine
Thread-Index: AdpDcEaBe6BJaNPtT3SqD/9EEzm2rw==
Date: Wed, 10 Jan 2024 03:40:18 +0000
Message-ID:
 <MEYP282MB269796C1FA2468CBD7DF3B17BB692@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [DMDie02j6eTS2dgePavkJCUPzC2IKIrS]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2697:EE_|SYYP282MB1391:EE_
x-ms-office365-filtering-correlation-id: bf13bfc2-de16-4f45-92b3-08dc118ddddb
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 T4auRnsUuiUthW4rGn5OAkE7teZvxHVhd/dlR4WDsheW7gvaDj/UQ3qptGRx4AXJL3ZZkuJ6tznUTcx5GsyfwgYIMQrYGTKLooPctCMi5qp9zX8grz3ByEiM6tl87/nMBVLfcX5HDRvSZF0qbH9Y/GN07FiSXi1KG4uWTykffc31Nz1h0A6jJsEJx8mHHyxVdR15luLKANKQQdJfnGn+yuG7W744ZKE8I6XrxF5yWeNg+1reORjbNYn656tYfjPKXAA6zzqYfcAAsF5BipFybup+mFBdc7/ulqRiH8l9cWcC+lzPa/0RBZ182WfW/kqUTk2NShTEHhq1EoLdJIuv6hm11ngj0Z/PN59cw/BEooFcybRbrtaq9Amj2pKj+QzJudfkfzZf02dzh6GH4R4UgTQ2iH/Z3lAiV4VupNBMs8pQoy4TD6HIjkSKkIkCMYHsEG14LIMfLoSZoaC3efXy5SRDupwGE5akZ7e6l+8Bv1Vj6bVWQM+6bhp1hyWgLBRcqYO3tlpJHP7xBMsnwSJzseE0zVBmP7hv8q+iJijdtcktbFRz+vd4odQUVvGu5I6zRtAnJvonmsK9aoOTtlB9Ck54ZngCrYaOcZifAYR9kGY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0NKUTc5VzhlYzVXRnhZNmpqNmxDcVduK2JMZzd5L1N5QXZKUkpsTCt6eWVT?=
 =?utf-8?B?ODJ6ditpVFFVeEZVL1FSRkxRYTJrMHphTmwyNjN5WmY4Vnp6Q1ZoRGNjNnNI?=
 =?utf-8?B?VzcrN1czdUdtcVhwc3FnbTVRODZVT3VMaHFnMmpaZEp1VnV6dkhPcmRldGRJ?=
 =?utf-8?B?OTNhMUJmRjdiMm9aMjFDVmxoUVRDMU5LSkFENkR0aWlmY3VRY0ZKSnI0enlY?=
 =?utf-8?B?WXlFU0VoZkNOSkZIMDdJblVFWG9FL3ZYUU9xRjg2SjRRVGU3MnFUWWx2YURG?=
 =?utf-8?B?SjdNTXFqb2VkS2kzWVdvSUNtU0kwcGtHVmZyN2lKNmxrOGpaTkJnRXRkOEww?=
 =?utf-8?B?S3Zjc2ZVVXpNdk4zOGU0VkFHbWorVmh5Qk1LbGdQa0hNZnJoRmVhKzQwM1Er?=
 =?utf-8?B?aHY5QkFyTXc1c2d6M0hCUlRqaCs5UjdtemQwaGVpZEtwV1pJY0Z5ZERUTEJr?=
 =?utf-8?B?NWpXRk9lSE1Ea1JxV0pzNGVlTzVaMHpSQ1NMVzUzblc5Nld4M2FpRUhwV2sy?=
 =?utf-8?B?bERBZ0ZqNlhLVDFiRzNuc1c2ZWs3MGFFTkhOL2lSRnF2OTlLMTM4bGM0TVZK?=
 =?utf-8?B?WXozeHJST0ZaaWd2NVF4MnByMkQvMGZXTk9ZanhkbGxudGg5UlF4ZGNETVdx?=
 =?utf-8?B?ZlRsZ0YvZFg1N1NuTGdDaHA2M0dub0ZaZXo4cWxLS1VlOHRNNUhLUGxudXJJ?=
 =?utf-8?B?VUpOby9hcmdqS1ZaTGcvSmZCY081WTQ2MVhQN1V4WkZTVVZZRTV4UjRzKzRU?=
 =?utf-8?B?NkJ5ZlpGUk4zai9Fem1TZVVSMnpqMm1UeVJkK2dKenk4Q1BpdEZPNDA3MnJ4?=
 =?utf-8?B?cHZKaGFKWlpaZ3F5WERTOFNtbGtCRVJCVnE3bUhQa3h1N2lQdzF5bWw4Qm9K?=
 =?utf-8?B?UVBya1Q1NU9GdFNkRWpoaVZyNnh1QmxGKzBuV2N2eTRjVC9lNCtGTG9OVTZI?=
 =?utf-8?B?ZmdKejR1M29IdEFyS3VEMEh5cTRvQWFseSt0ZlJ0NVBsKytwdUlYZlJoc3BR?=
 =?utf-8?B?RFhIb2tSTUFCc0FyUGYyc1hKYTQ1Rzg4bVdBcWdjaGMvTnE0Z1BjK3pQVHJq?=
 =?utf-8?B?OHNmSlVadDFSVlQ3dDdTd0ZGcmJtaU5Na09lU01DL3g2UlZMNk5PQmZGVmpU?=
 =?utf-8?B?Tm1sampONDZQdGZCMFZqc1BwblM3cUQ5bkwwbjlwK0x0QVdzdUtWNG92SlJh?=
 =?utf-8?B?N291VjdVOFJQS0drekFhMzRlai9WVHFZaENabjY1bHF6M0NPWmpEOXM2UzRR?=
 =?utf-8?B?cVZOOUh4TjNVajZQMXhqNVBmUDBhem9ZS0dvRkNoRVF1UUQvYWtqWkZGOWkw?=
 =?utf-8?B?bjZKMW1FVmp0Z3VrN1ZWWjRHaUhkd21CUWZtUForN2NIL1EyK3BvOVFERE9G?=
 =?utf-8?B?T2ZYeS8wNHJPUXNaU2xuSU12TEpBNDRsbDdWQi90RUJCUk1vTjhNa3FGNnhq?=
 =?utf-8?B?ZldiUytzOVNIcjdwQWpMUVlQWFZ1UzRoNFJSc2tkbGNUR242S0psRkdoUGk3?=
 =?utf-8?B?NzgyaE40djlRTjZTbkVySmdiUVNqQ3FKS3dOZUROQm5wR0tqKzZJUjhpbUFr?=
 =?utf-8?B?M01Yb1M4S05NTFg1dEtYWDhEMk9GRDFYWC9vTmtzRStQcWMxeFNiSnBPd3la?=
 =?utf-8?B?QU1tR1NkOG5yODJZOE1yQWVOMVBLVWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bf13bfc2-de16-4f45-92b3-08dc118ddddb
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 03:40:18.9940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB1391

DQo+T24gMS84LzIwMjQgMTozNyBQTSwgU2VyZ2V5IFJ5YXphbm92IHdyb3RlOg0KPj4gDQo+PiBP
biAyOC4xMi4yMDIzIDExOjQ0LCBKaW5qaWFuIFNvbmcgd3JvdGU6DQo+PiANCj4+IFtza2lwcGVk
XQ0KPj4gDQo+Pj4gK8KgwqDCoMKgIHN3aXRjaCAobW9kZSkgew0KPj4+ICvCoMKgwqDCoCBjYXNl
IFQ3WFhfUkVBRFk6DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gc3ByaW50
ZihidWYsICJUN1hYX01PREVNX1JFQURZXG4iKTsNCj4+PiArwqDCoMKgwqAgY2FzZSBUN1hYX1JF
U0VUOg0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHNwcmludGYoYnVmLCAi
VDdYWF9NT0RFTV9SRVNFVFxuIik7DQo+Pj4gK8KgwqDCoMKgIGNhc2UgVDdYWF9GQVNUQk9PVF9E
TF9TV0lUQ0hJTkc6DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gc3ByaW50
ZihidWYsIA0KPj4+ICsiVDdYWF9NT0RFTV9GQVNUQk9PVF9ETF9TV0lUQ0hJTkdcbiIpOw0KPj4+
ICvCoMKgwqDCoCBjYXNlIFQ3WFhfRkFTVEJPT1RfRExfTU9ERToNCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiBzcHJpbnRmKGJ1ZiwgIlQ3WFhfTU9ERU1fRkFTVEJPT1RfRExf
TU9ERVxuIik7DQo+Pj4gK8KgwqDCoMKgIGNhc2UgVDdYWF9GQVNUQk9PVF9EVU1QX01PREU6DQo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gc3ByaW50ZihidWYsICJUN1hYX01P
REVNX0ZBU1RCT09UX0RVTVBfTU9ERVxuIik7DQo+Pj4gK8KgwqDCoMKgIGRlZmF1bHQ6DQo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gc3ByaW50ZihidWYsICJUN1hYX1VOS05P
V05cbiIpOw0KPj4gDQo+PiBPdXQgb2YgY3VyaW9zaXR5LCB3aGF0IHRoZSBwdXJwb3NlIG9mIHRo
aXMgY29tbW9uIHByZWZpeCAiVDdYWF9NT0RFTV8iPw0KPj4gRG8geW91IGhhdmUgYSBwbGFuIHRv
IHN1cHBvcnQgbW9yZSB0aGVuIFQ3eHggbW9kZW1zPw0KPj4gDQo+PiBBbmQgQlRXLCBjYW4gd2Ug
dXNlIGEgbGlnaHRlciBtZXRob2Qgb2Ygc3RyaW5nIGNvcHlpbmcgbGlrZSBzdHJuY3B5KCk/DQoN
Cj5BIHF1aWNrIG5vdGUgZnJvbSB0aGUgc2lkZWxpbmVzOiBiZXR0ZXIgd291bGQgYmUgc3Ryc2Nw
eSgpIFNlZSBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL2Rl
cHJlY2F0ZWQuaHRtbCNzdHJuY3B5LW9uLW51bC10ZXJtaW5hdGVkLXN0cmluZ3MNCg0KPnNsbg0K
DQpJIHdpbGwgcmVtb3ZlIHRoZSBjb21tb24gcHJlZml4ICJUN1hYX01PREVNXyIgd2hpY2ggdXNp
bmcgb25seSBmb3IgVDdYWCBtb2RlbXMuDQpUaGFua3MsIGdvdCBpdCwgbGV0IG1lIGRvIHRoYXQg
dXNpbmcgc3Ryc2NweSgpIGluc3RlYWQgb2Ygc3ByaW50ZigpLg0KDQpBbmQgQlRXLCBzaG91bGQg
c3dpdGNoIGNhc2Ugc3RydWN0dXJlIGJlIGFkanVzdGVkIGxpa2UgZm9sbG93Og0Kc3RhdGljIGNv
bnN0IGNoYXIqIG1vZGVzW10gPSB7DQoJW1Q3WFhfUkVBRFldID0gIlJFQURZICIsDQoJW1Q3WFhf
UkVTRVRdID0gIlJFU0VUIiwNCgkuLi4NCn0NCg0KdDd4eF9tb2RlX3Nob3coKSB7DQoJLi4uDQoJ
Lyptb2RlID0gVDdYWF9SRUFEWTsqLw0KCXJldHVybiBzdHJzY3B5KGJ1ZmYsIG1vZGVzW21vZGVd
LCBzaXplb2YobW9kZXNbbW9kZV0pKTsNCn0NCg0KQmVzdCBSZWdhcmRzLA0KSmluamlhbg0KIA0K

