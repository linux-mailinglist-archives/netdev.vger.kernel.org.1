Return-Path: <netdev+bounces-55186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A804809BB5
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 06:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A7C1C20BFA
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 05:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349EF5691;
	Fri,  8 Dec 2023 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OgN9BZo1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A62B1718
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 21:32:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/qXXbLmzY/qx4kxngJusXEnOR48SoAA4GYMGZwCjJKPIrbunAzZtXXb5GD63kc5SrYjOBYrZ4PuI+2e84kUK4CLZBm93QKiNhHwvqOCXGFwAmNV0ZIz3HyAFaey1Su6r5NjCf7FsgTpbU4Di12WfWT3jt2jJYmkNIfNL/nsBboF0SyG/pHo/ilvcQSQ0RLqBclvA8dv2YprwXKmWEGLOC/HQvEWaWG0imBLOAcf8ONiZFME8p6Ww7v2tKUN0Vg7o/wAsxAUI9NghhSjCsY3iQxdwIWcqEr6sYReqDlqnSicK04KgpS4CdWFYZiLDayao93kk6LIac8XoO5FBlllAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3TuUBYzuMimSoLkHBwfQDSmYreBHW8TNLg0w2ChPCE=;
 b=kimZtu1yNToUMe8DGoIL+z7FItgACIvk4LnIQnMuJpQTcTaqkbjDhWkuGTC3uyBygF6VkOMkD30oj63rbhsyKsT5ojGDQ35qmdxe7cXFE8OiWoh/qpjI+SawL82PzxHqiooYYXQdRdR4h0q4Gn5WHmmL8JIF/57oj9/oh7v4X816VdM1MkwFbwXAcZijNWp2NbelvZUntr9DB8QmdcCUfP01ckPffVz5pDoc7PQ0d8Umj7Im1r/8xFhBJVG/cyLyAyMBbF62l0rzRGcGgi4DhrdX0It50QsFvIDp/ulfGu6cqUyN6eP7mFsoLFJ/5lBqAlotW0VI/OSZWIh92pVb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3TuUBYzuMimSoLkHBwfQDSmYreBHW8TNLg0w2ChPCE=;
 b=OgN9BZo1oVNKV8mslUfXGwKPWx4e99AO6qkPM4QlnHVwbkQTAtDiIn967ox9hf2C7omFJuW3hFK1w3G8VZExpS2/BKbZtSqimHUhRNS5l82OzPczTac7PJfFa6GGrIoSEmilOZrdTzTYKCGMSFSklc5GZbwDg2lkZGXw04ClQ2PIWO8E5yxNUJqMXbFs97IilKWfiTMCLkxmqs9zJ/9Kmc9Mnc0pkof8gr6rfIwh9ksm85XhJFCYvZmogOUFMLav2RyQPnJ2AZleJQXhIB3TcBOxFwNLxTJepXwgkcmHLMwZQCf5yBzNY9feuwOnFFVtY+Z0NsCG8/RDz9GygIFF3w==
Received: from IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 05:32:24 +0000
Received: from IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::4d83:9d52:9e4:e732]) by IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::4d83:9d52:9e4:e732%6]) with mapi id 15.20.7046.034; Fri, 8 Dec 2023
 05:32:24 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"saeed@kernel.org" <saeed@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
	<tariqt@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Leon
 Romanovsky <leonro@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [net V2 08/14] net/mlx5e: Check the number of elements before
 walk TC rhashtable
Thread-Topic: [net V2 08/14] net/mlx5e: Check the number of elements before
 walk TC rhashtable
Thread-Index: AQHaJ0I5aiq/5vZ05EqFfN2IMDL+wbCe1NqAgAAMdwA=
Date: Fri, 8 Dec 2023 05:32:23 +0000
Message-ID: <842845cbeb1187fc91b013077104fcce0c94dfc6.camel@nvidia.com>
References: <ZXKf8f/hjw1K6Qyp@gondor.apana.org.au>
In-Reply-To: <ZXKf8f/hjw1K6Qyp@gondor.apana.org.au>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6235:EE_|DS0PR12MB9399:EE_
x-ms-office365-filtering-correlation-id: 6f3ab681-bb68-4c76-0b72-08dbf7af0ea9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fjMp265jrqlTs8idZWevSeZ0udy6t3rbHEfUKwT6JjxeBarmmVcyCjXzr3dPOZ3uZFuD2TMHfnhOTwC9zXQpIikFNUkVQ/oNHfpv8D00Gfuj80W8+Q344schyMBfvAf8QkbxZKZakOYYW/0rSkGcnJLCpZRlUssxHX/plILOLspwX33wlDZieVvuy5Lvt+c8JTReOUtc/r7UWfdc7/0iNQ7zoJyUfSzR19QKdqEZrFsHPwGMWLpjqsqqEnftxpz5S0/dQngthT4pr/C0C2kRuDSN0NrwJyauToC5SoL45q14MnBHgfBmJVdJIZp0aDpsbXNR0bx4LBnH5dnLVzuYY/7zAVhgeNmvQkFl1IFeQ+BOh/GiLHnmXU+rJ/jl5KrDPk8Qh3O5bCU1pwUYb2cLjGde9jVJGwfiyoEf+Im1iJoCUu60lZ60O4NLsiolywvnL1sylletOT6GTygYsxfhuV/qwB6bMm17YXBoqs2qmberTGVnp0TegfY7VLYXoEK4kuITzZc80RA9uNfEdUHHdluK5qtXOiF6vB3hNwXPOUYPEDHRprzHtIjXIaQ67m8TLBcgykQ7SNAe5uDMMUG2ZxmGKcFGtb2A7hS74qkrVPvzOoXru8jbDUKI0qG6ZSFq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6235.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(122000001)(71200400001)(6506007)(478600001)(38100700002)(6512007)(5660300002)(26005)(83380400001)(2616005)(4744005)(2906002)(8676002)(8936002)(4326008)(86362001)(41300700001)(66946007)(38070700009)(110136005)(64756008)(66476007)(66446008)(54906003)(76116006)(91956017)(316002)(66556008)(36756003)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFBEQWFUTE9TZjVKVDd2OFhlWUFndm5UajhDOUZaY1JlVEFEc3N4Vkp2S3Jj?=
 =?utf-8?B?QXhoeVp0a2VnTklkSXF1dzcyanVCMGhMSE4wSFowQ2IwelRJdTlUckY5cEJt?=
 =?utf-8?B?RUhIZ1ZjdFgyQWZrSXJPS09TeFFXdzhjL3NiOC8rcko5ZlZreTVLdG1kMThM?=
 =?utf-8?B?M09JVWVJR0RSNTkrV0syM2Z1VzVoMk5TWEtzSFdhZ0VvWHhoWUNUcXp0TXNY?=
 =?utf-8?B?MmhtRkFYUlRvYm9iTmdTSG05bTV3ZFNmNkVscllIOHQ2TDgwSGVZOVpBVmFY?=
 =?utf-8?B?eVRta254aG9JK3ZuVEJlZmk5OGxCVDdFNVQ2VG41RG1pZjNodmZieDlGV3VP?=
 =?utf-8?B?ek8yeUEvdEg5TXRIMmZQY0pOeHQ5SDZBaVlLUU11WEVTaTd6VnJhYThtdHIy?=
 =?utf-8?B?ZmVFaStsSUIvbmU3TW85Nk1EaHVnR0dkZGdMTWlBeUJtWFpKMHF6OFFlRm1q?=
 =?utf-8?B?bUZLd3F4WjMrY0JOeWtqUG9ZKzN1N21OMmZ3Z2hGcElQZ2R3MFYvOVduRXlV?=
 =?utf-8?B?eGQ5MlNQTEF5OVJKdU13dWpBeWg0S3R6eG50UTlDeW5oMlpldmkwVWs1dXY2?=
 =?utf-8?B?VSttNlllcGVGdlN0THZ1L2l2SnJzM2R2NWZkWVdVMnE4bnphTjd4VndHYXIx?=
 =?utf-8?B?QjJRY3VnNDU3OCt6cndkZmRKMHU5alJ2VnFIdjQ0VXl1REpGbncxVDFSb2ZF?=
 =?utf-8?B?NGVFRzhUZ0EzQktSNVZ1aUJobU5qVHVtcW91NS9TUm9FeHpGYzhaV2FuanRk?=
 =?utf-8?B?NzIwcXZQazBRTGk2bG9rTnFNQ0hIUjQrbGUySzRyOGNhWEgwalJIQU9hMFRl?=
 =?utf-8?B?eWlBOGZScjJ1SkZva1ZnOVNoL3ZiTS9WM2VhZW9zTlBuODBDc04xNXRHS2ZD?=
 =?utf-8?B?Y1BWT0kyZWVrdkdzL0lWT21zVWlwWnRGcnNjblpvMjk2aU9FOWpUTDRFNm9n?=
 =?utf-8?B?NUdUckI2WmZuM1hKZXFUejE4a0drYkNKVWM0YXV5Y3JOeGNFTFI0bW5FQzUv?=
 =?utf-8?B?Tlh6RVptYS9QTVJIejIvaTRCY1pqRnB0bEU1OTdOQzE3Q1FJbHlxOU10cU96?=
 =?utf-8?B?Slp1ZEczRWZDOXRxN2svT1BMSWJ3UE1oQ1IyWi9rZC9TK1NoTzBGc1hTQm50?=
 =?utf-8?B?VDUwb1pCRk1Pd3BLSldtMGNRc0NGSU0rd2wyTmtuZHZDazhmYUNxQ1FlNDB5?=
 =?utf-8?B?cWNySFZDVFV1SUNKenE4V3BEMFpObzhhdHRDNGVKUmNaNE5HYmcwQnBoRm83?=
 =?utf-8?B?eGlNRXREeWVVMzlUYlBoQXpYOTVJNXByN0pneFNKdFlCbnBWTmhlK3M1bVpL?=
 =?utf-8?B?MFN4bWlJUHNvVTRLK2lEZVhEaWt1czBUWVc0SjA3ZXFpMkxvUDZxL2hQejY2?=
 =?utf-8?B?bUw5Rk0vS0p5bi93Nnl0d1BzamVZS3BlekVIeVhEQlF1anBjYzZSeEZ5eVBC?=
 =?utf-8?B?ckJBa3dIUjQrQVdGaTlyWEg1ZUoyNXV6dWVDUldiQ2dUZk0yMTFoYkRFYzFI?=
 =?utf-8?B?QVlVYlhUTDZvK3o3UlUxZGdzckQzTFQxK21vTXNTNEl4SFIrS0xpMkhwOW9Y?=
 =?utf-8?B?bWlvMEVacHBUMnhQVnFHSHozaGpnOXFNUjlyamhWU3loaFRmalRYaHRmcWUv?=
 =?utf-8?B?cUExdFAyNWJ6dTd0VTUvQlVUQ1RLVHZsc1Fwb2pxVXgreVVoZjVhMU1PU1Bm?=
 =?utf-8?B?aU40dEdPa2dpM1prSUxGOGNDUTZxY3FhczRJNWh3dmJLU2RCckE5Vkd6YkFi?=
 =?utf-8?B?S2lVZHFPaVU0azNTSjFpL29mVW1Wd21aWlluNDNsYmJuSEdhM2pUeDU4RGdJ?=
 =?utf-8?B?N2UwZzNoTzl2LzlDTHMxT2FqazJ4Q1FxdExvYko5cHkrd1JQQm0zcDR6QWMx?=
 =?utf-8?B?N2VCbzNHV0VmdUtFaHZ6U0NpZjJVV2E5dzdCYk5jTzFiQlJpQWg2SU9VTkNU?=
 =?utf-8?B?ZVl1RnBMaHdxUFdjODNJc2dUR1ZqaTQrUExsaUVPeW9JOTk3SHpqYkl6MDVE?=
 =?utf-8?B?MmN2THJZUlBLZ21xemFjM3FBMFdJTFhqUnVjaFBsNmF0UzhKRGE3RGp4T01m?=
 =?utf-8?B?U0VBYzRkRlBxVVBRVk00dGx2Q25BaHdZck0xZXBNeVBHejNnMmZYT25WOTBa?=
 =?utf-8?Q?U+BboQ50Ub1E1hN7eWEOAeePR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C33C52616D80604DB6D2A022F31455B9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3ab681-bb68-4c76-0b72-08dbf7af0ea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 05:32:24.0146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kF1fWxsmmlMjwYZpUPd4FO0R+pNmQjN3H0oFPgR5A5jFEzTL4HnTpTidG1u9qBFFssKNNUkt9F1AP1M3cyho8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399

T24gRnJpLCAyMDIzLTEyLTA4IGF0IDEyOjQ3ICswODAwLCBIZXJiZXJ0IFh1IHdyb3RlOg0KPiBT
YWVlZCBNYWhhbWVlZCA8c2FlZWRAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gRnJvbTogSmlhbmJv
IExpdSA8amlhbmJvbEBudmlkaWEuY29tPg0KPiA+IA0KPiA+IEFmdGVyIElQU2VjIFRYIHRhYmxl
cyBhcmUgZGVzdHJveWVkLCB0aGUgZmxvdyBydWxlcyBpbiBUQw0KPiA+IHJoYXNodGFibGUsDQo+
ID4gd2hpY2ggaGF2ZSB0aGUgZGVzdGluYXRpb24gdG8gSVBTZWMsIGFyZSByZXN0b3JlZCB0byB0
aGUgb3JpZ2luYWwNCj4gPiBvbmUsIHRoZSB1cGxpbmsuDQo+ID4gDQo+ID4gSG93ZXZlciwgd2hl
biB0aGUgZGV2aWNlIGlzIGluIHN3aXRjaGRldiBtb2RlIGFuZCB1bmxvYWQgZHJpdmVyDQo+ID4g
d2l0aA0KPiA+IElQU2VjIHJ1bGVzIGNvbmZpZ3VyZWQsIFRDIHJoYXNodGFibGUgY2xlYW51cCBp
cyBkb25lIGJlZm9yZSBJUFNlYw0KPiA+IGNsZWFudXAsIHdoaWNoIG1lYW5zIHRjX2h0LT50Ymwg
aXMgYWxyZWFkeSBmcmVlZCB3aGVuIHdhbGtpbmcgVEMNCj4gPiByaGFzaHRhYmxlLCBpbiBvcmRl
ciB0byByZXN0b3JlIHRoZSBkZXN0aW5hdGlvbi4gU28gYWRkIHRoZQ0KPiA+IGNoZWNraW5nDQo+
ID4gYmVmb3JlIHdhbGtpbmcgdG8gYXZvaWQgdW5leHBlY3RlZCBiZWhhdmlvci4NCj4gDQo+IEkn
bSBjb25mdXNlZC7CoCBJZiB0aGUgcmhhc2h0YWJsZSBoYXMgYWxyZWFkeSBiZWVuIGZyZWVkLCB0
aGVuDQo+IHN1cmVseSB5b3UgY2FuJ3QgZXZlbiByZWFkIG5lbGVtcz8NCj4gDQpJIHRoaW5rIHdl
IGNhbiBhcyByaGFzaHRhYmxlIHN0cnVjdCwgbm90IGl0cyBwb2ludGVyIGlzIGRlY2xhcmVkIGlu
DQpycHJpdiwgYW5kIHJwcml2IGlzIG5vdCBmcmVlZC4NCkFueXdheSwgdGhpcyBwYXRjaCB3YXMg
ZHJvcHBlZCBpbiBWMy4NCg0KVGhhbmtzIQ0KSmlhbmJvDQoNCj4gDQo+IENoZWVycywNCg0K

