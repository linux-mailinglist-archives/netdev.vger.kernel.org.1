Return-Path: <netdev+bounces-55618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA5380BAC8
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 14:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC336B20A63
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECDF8C0A;
	Sun, 10 Dec 2023 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="JgEkCSFT"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2124.outbound.protection.outlook.com [40.107.13.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98276130
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 05:00:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0fivcEMsGPjmdC2t07YjHdcGP0L0KVEzAPzzMvQ+96z+d0tJiiGolxK/J9yfGvKbFY5EGiGrUmrIlh+E3vpVdu+ccr7GuN0stcIfEfPPXb/UgadFuvudSQ1OMX9Z4E1ZtcouyLD4tVikTsBUQm8hR45oaS5ndFReymhWfQqIezAFndWZdpKrzm/fAdxsyxuTU2TC7n2FzThvx63MwtQXbSe4ptyw4cjV0/UnFRr8mkuD2evAGXQ3odm+cfttV42Yeul1RmbD916qL0NY8QIaa8aEov5w++ihyJd+FB2LEmO/3fZgYSemrnZsYO1V5HI2rWFmHR9tBoyiOAVyXMNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBuLWsDr/4mDACtLD2xeVrHU+1vVeFFhEvdErTuPNUg=;
 b=KrrwF3+aGN82pEfXbAui+o9OrM+m2SD5Helb08fZC9UH1e6LJcnUukkK8n0Vv9JP1k49kkHZqkMDORwg9nNWFn6+eIi0e6akzMbBcxLqDTT/34B7loEDz3gfGBNuUpmEUhaesiJEAY9vZBss62Tyma9Idxk0o2L07HEWfdbHQy65qjFo15WRpc3lCA0U2dmMeERrNtHthmcSxyMq9KFfrnB9HxTrk5fa30hyAiSg4KQWJhQy9/sVxOQp5bH76vxzlHYQhZBvSBT32V2S+dDQsspCfhAF07uBiI8e58IfBdvRQLLr2BOaxLZ7g0ArktOolsdePaH8VdCzXeCIcrezTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBuLWsDr/4mDACtLD2xeVrHU+1vVeFFhEvdErTuPNUg=;
 b=JgEkCSFTmTFfXBl6ts2X6BzpVy/Jt88ztdZu8zDLYDbj8AOvyCJEo1stQlrIEHl7L2ydWbQuEKx0SGvtjlSzD2X1lI+MQydn5NLYdjwoblKHDY7CE6JSxaElv2m5ovN7xZUvTjuLp9YidBC/qJpqeVn2rE3tPmpM7lOzCPHXMSA=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AM7PR03MB6513.eurprd03.prod.outlook.com (2603:10a6:20b:1b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Sun, 10 Dec
 2023 13:00:46 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7068.030; Sun, 10 Dec 2023
 13:00:46 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: dsa: realtek: Rewrite RTL8366RB MTU
 handling
Thread-Topic: [PATCH net-next 2/2] net: dsa: realtek: Rewrite RTL8366RB MTU
 handling
Thread-Index: AQHaKvBXBYgn0S55yUy5HKWE1dC9ArCie+cA
Date: Sun, 10 Dec 2023 13:00:46 +0000
Message-ID: <kcqdranbwdvkgrambeg2f7cfxguzodtzgd2yrecu6scau27vzc@o6gxdpxuzotr>
References: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
 <20231209-rtl8366rb-mtu-fix-v1-2-df863e2b2b2a@linaro.org>
In-Reply-To: <20231209-rtl8366rb-mtu-fix-v1-2-df863e2b2b2a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AM7PR03MB6513:EE_
x-ms-office365-filtering-correlation-id: 499f0163-3351-413c-e582-08dbf98006cf
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 j/AqXPl2igMUsD9p1ri2kJ6SXvA+ffQb0xdn0Y+d1JoEeqKbzmiBzoFHstjAWQb+d6siwv1qqgH3IbUJcc8MmBqg0USEjFNpxHtWJJysUGjggx6HYizlTTKlhjJrD6venc7aGPKur9pcChx2l0XPJliu+zpgpKJEKvKDZTVEfbcwDSM53S1BIeerQmVvK6B82pR1NkSCOtdvjycdFfFWdsF+iYXkQA66s9LdfvDrwJvkV13jmZ5YQ2JUM5a6M1IgGfmzowDQ5S0y9VruJcyUeCN5aQOqiYA+YgMKU7F907V9u9M7uMU3Vh+o3sjyOPxlFnP1lIZnVzj3F/qmGb+CeyId1U9y/fldQU8jxg34pS/PMzcVBxCFwTilPoKWloyNqFA4WeHJQSznfvDPPcHg8dpmE30wNydqOg7LEE1z6MkxxafU27+xVF3bvSklVIHgMwVQ5OnZF/WR/l8uo6tNCpT+LrvGwDxm228kxPi+e32QQtfJeNAmAhWK2jVvOrcu3uRNi1JIbs+t2K12bUbX4G4P1eotHFdbZvdMImDm6u7ny7IAHDJ9JBPidCGHaD6hDtiVjanDA3sx/sFbWzBRS/YuuDbGVLWNgkcJAi7dSTUjGQsiYdR7HPneka+TBitJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39840400004)(396003)(136003)(376002)(346002)(451199024)(64100799003)(1800799012)(186009)(9686003)(6512007)(33716001)(6506007)(5660300002)(26005)(85182001)(38070700009)(91956017)(76116006)(6916009)(54906003)(66446008)(66476007)(66556008)(66946007)(64756008)(6486002)(85202003)(66574015)(2906002)(83380400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(122000001)(316002)(38100700002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bElzaU9vWEhUY0hBMTFKM0VMVi8rNFhJWHE4b0ZDSGtOUlZmcTREK3B5eEFq?=
 =?utf-8?B?NWEzOXBnbE1wckxNb1BIc2hJdmpJTmg0Q0lEMmVTa1ZaRGhlU3pWY29jcnkz?=
 =?utf-8?B?cUI2dWh4Z21MTkpjSWtNSGxkV201UkZoUmFQQ3Z5NmZrRENnU0haZzAvUDdl?=
 =?utf-8?B?OFlRY29LQmdhSm10TFpKTHhKb3pPMkZWbE5MTHpPbzNFV0t1N3Nva0tPT3ph?=
 =?utf-8?B?Z21LbndaeE9ucEdWUGpkdVRJKzVnYThwMnVTejM4eEp3SFgxQTg4bEF4dGZy?=
 =?utf-8?B?bmNJTGF0L3J2R1pxTklSNlFucHBmekNwUUM2K1RzQy9BMlFuQlFrZWpkZkEx?=
 =?utf-8?B?eGJ3dUNMRjk3dERiblQ3SDhzd1BaTU92T1lFNFVSbEprQnA4SGIydkpvRmtw?=
 =?utf-8?B?QjlJcWI4QXY0WWo5UDRVcnpHVUZaMXgzQkFXUFoyajMvNWVmZ2VjVE1UL0kw?=
 =?utf-8?B?WEhrVnZOcE1sb1VwRHk2OTExVEtHN2hKdkpUd3BmSlFDcnMyaC9ablZCZUlK?=
 =?utf-8?B?d3JjaXJBUzc0K0s1V2xuc3B5ZmRYaVh5bjkwM1dwN0UxVEhLaXhEMzdaY2lw?=
 =?utf-8?B?dkZTUWI4UkQvUThNRmNkUFl4ak8vMXFLS0NCREhDWEVpL200RS9uMWFPQ2Ru?=
 =?utf-8?B?bXZTaVNnWHl3cVRWQWJ5YmxkNnMrYzFQbnd3dXc0MUFCTUZvNGw5d0Q0NnFk?=
 =?utf-8?B?ZDVyejlCSy92M0lnZE9oOU9Cb3BacTJFbEpXdUw1ZHVzZDFJTFhhazA1Rzg2?=
 =?utf-8?B?OTlQMFU0R3BYMWRsbTN0VzN5bkFlVWU3cE9RVnFjcDVtTjhrUHNrSkloajBm?=
 =?utf-8?B?KzRPeGRPaE90MWtQY3RBVE9hY1hIN1lXLy9pYXBlc0VRb2JZTkxYdk1xU2Vn?=
 =?utf-8?B?UVIyZ1cxOVhyditVS2VVREQvalM4d0x4UkVWY0V6NHdhdmxuenRwai8wWVk5?=
 =?utf-8?B?ZldjWkJBOFJKYkErK0lJNkRZY1FHckN5dWRjNjJCQUNIeFJxSFU1Rm9vNjFi?=
 =?utf-8?B?WmIzLzlTQmI0dkg2eHFFaktSVU85RVpHMkduNEQ0OHRBenhqenYrUHBrdTRT?=
 =?utf-8?B?OEhmRUtjbkFnZm5pMGtNY0hFM1pPT2grUUhOeFNLSXBaeW1QZHVMUVQxSXBK?=
 =?utf-8?B?b25mR0FHaGlzcmRJM0laZVB4NGZSL2x0L09uV1YxNHczOURlNkVmUHRqWnFu?=
 =?utf-8?B?OHhxaDdocVEzbjgxY0p2MlBEWGlVb3JEaTVTY1JjWU9GQzI3RlVpenlLd0E3?=
 =?utf-8?B?cTNNR3Q0Uk9jUDZ3NHBNamhqN1h3bjhSUDV3ZGpXdC9jTExNeTJlSjJYRXJr?=
 =?utf-8?B?d2VZTTErVkVrdmh0cE52dTR4Z0FjbjhTN3Z4TlhLTW9pNVo3RUlwU1E2VjhP?=
 =?utf-8?B?ODFyWmNQRi9OcGd5aGJDaDB2WXVXRGw4enFFNk1aaWRwRVVEMnZ2VUJraGMv?=
 =?utf-8?B?V0hSOEprc1Z1NzhsSkI1enowNS9JY1UyWjZWKzRRVno3WHZmb25EVGR1b1Bv?=
 =?utf-8?B?T3NWaG5SMkJEOG5tRkdhaTlIKzE5czV6WFVCTDlhdVVuSEhtTU5Jc0RRTlcz?=
 =?utf-8?B?aUh5YU1IY3l4NkhPTGk0WmsvRHZhMWd1R1JEcll6YXNZUEtTU0JJRGVvWEhU?=
 =?utf-8?B?Z05MQ3BaRVUrRDdwNTU1VUZrZGREeEQrM015YktyL1hGYmovckc5R0d6VlhG?=
 =?utf-8?B?TGJFRlRHazlGT1M3SCtQV0h5T0ttWmFiWmxVM0lIdWZtVnFzWVhsTFpxbTNO?=
 =?utf-8?B?dVJyZURjby9GYVRHaGdnNVF2L0VKd2c2RGZ3bndZNTFHMDZGRm1WUmVKdGR4?=
 =?utf-8?B?MWtuZjJkTVRKWTBDMm5lUHJGaUh1VnZpVEJOdldCeG42dWJsVUVZdU9lYllB?=
 =?utf-8?B?ZzVMS2N1dDdKOWdFTU4zV2dyZkg2QmZQS2N3UHRrUFlpNTFaS1QzK3oybmJM?=
 =?utf-8?B?M3Arck9EdUFDdFRnQTQzclZRbU1CbnhuVGdnZUxpZ0xVYzZpNm5DRmhLRmtV?=
 =?utf-8?B?MVpJcHBrVkVFVkMxY2x1OHBGT3dFQmE3SXRqYzR6clVSdlVrd2JFU0hmSVMw?=
 =?utf-8?B?WWxDanI3KzFZY1Fjd2ljeHlHQkxrbE14dE5KclhxeUlwMkVRdlc5bDNtdkFR?=
 =?utf-8?Q?+V4Sf8ZMqIu/1cXipsdTCpYQm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F1B74A85478AF4CA235D966DDC16303@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499f0163-3351-413c-e582-08dbf98006cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2023 13:00:46.8180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SombeBimm3USf4sF0OkpItMmsBHdTW6JomxbJxXMSolnHGZUMmih6stfbtO8SE7jd3u4eI7gDMpwTmzOR80B5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6513

T24gU2F0LCBEZWMgMDksIDIwMjMgYXQgMTE6Mzc6MzVQTSArMDEwMCwgTGludXMgV2FsbGVpaiB3
cm90ZToNCj4gVGhlIE1UVSBjYWxsYmFja3MgYXJlIGluIGxheWVyIDEgc2l6ZSwgc28gZm9yIGV4
YW1wbGUgMTUwMA0KPiBieXRlcyBpcyBhIG5vcm1hbCBzZXR0aW5nLiBDYWNoZSB0aGlzIHNpemUs
IGFuZCBvbmx5IGFkZA0KPiB0aGUgbGF5ZXIgMiBmcmFtaW5nIHJpZ2h0IGJlZm9yZSBjaG9vc2lu
ZyB0aGUgc2V0dGluZy4gT24NCj4gdGhlIENQVSBwb3J0IHRoaXMgd2lsbCBob3dldmVyIGluY2x1
ZGUgdGhlIERTQSB0YWcgc2luY2UNCj4gdGhpcyBpcyB0cmFuc21pdHRlZCBmcm9tIHRoZSBwYXJl
bnQgZXRoZXJuZXQgaW50ZXJmYWNlIQ0KPiANCj4gQWRkIHRoZSBsYXllciAyIG92ZXJoZWFkIHN1
Y2ggYXMgZXRoZXJuZXQgYW5kIFZMQU4gZnJhbWluZw0KPiBhbmQgRkNTIGJlZm9yZSBzZWxlY3Rp
bmcgdGhlIHNpemUgaW4gdGhlIHJlZ2lzdGVyLg0KPiANCj4gVGhpcyB3aWxsIG1ha2UgdGhlIGNv
ZGUgZWFzaWVyIHRvIHVuZGVyc3RhbmQuDQo+IA0KPiBUaGUgcnRsODM2NnJiX21heF9tdHUoKSBj
YWxsYmFjayByZXR1cm5zIGEgYm9ndXMgTVRVDQo+IGp1c3Qgc3VidHJhY3RpbmcgdGhlIENQVSB0
YWcsIHdoaWNoIGlzIHRoZSBvbmx5IHRoaW5nDQo+IHdlIHNob3VsZCBOT1Qgc3VidHJhY3QuIFJl
dHVybiB0aGUgY29ycmVjdCBsYXllciAxDQo+IG1heCBNVFUgYWZ0ZXIgcmVtb3ZpbmcgaGVhZGVy
cyBhbmQgY2hlY2tzdW0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc+DQoNClJldmlld2VkLWJ5OiBBbHZpbiDFoGlwcmFnYSA8YWxz
aUBiYW5nLW9sdWZzZW4uZGs+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9kc2EvcmVhbHRlay9y
dGw4MzY2cmIuYyB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9ydGw4MzY2cmIuYyBiL2RyaXZl
cnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgzNjZyYi5jDQo+IGluZGV4IDg4N2FmZDEzOTJjYi4uZTNi
NmE0NzBjYTY3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9ydGw4MzY2
cmIuYw0KPiArKysgYi9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9ydGw4MzY2cmIuYw0KPiBAQCAt
MTUsNiArMTUsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2JpdG9wcy5oPg0KPiAgI2luY2x1ZGUg
PGxpbnV4L2V0aGVyZGV2aWNlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvaWZfYnJpZGdlLmg+DQo+
ICsjaW5jbHVkZSA8bGludXgvaWZfdmxhbi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVw
dC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2lycWRvbWFpbi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L2lycWNoaXAvY2hhaW5lZF9pcnEuaD4NCj4gQEAgLTkyOSwxNSArOTMwLDE5IEBAIHN0YXRpYyBp
bnQgcnRsODM2NnJiX3NldHVwKHN0cnVjdCBkc2Ffc3dpdGNoICpkcykNCj4gIAlpZiAocmV0KQ0K
PiAgCQlyZXR1cm4gcmV0Ow0KPiAgDQo+IC0JLyogU2V0IG1heGltdW0gcGFja2V0IGxlbmd0aCB0
byAxNTM2IGJ5dGVzICovDQo+ICsJLyogU2V0IGRlZmF1bHQgbWF4aW11bSBwYWNrZXQgbGVuZ3Ro
IHRvIDE1MzYgYnl0ZXMgKi8NCj4gIAlyZXQgPSByZWdtYXBfdXBkYXRlX2JpdHMocHJpdi0+bWFw
LCBSVEw4MzY2UkJfU0dDUiwNCj4gIAkJCQkgUlRMODM2NlJCX1NHQ1JfTUFYX0xFTkdUSF9NQVNL
LA0KPiAgCQkJCSBSVEw4MzY2UkJfU0dDUl9NQVhfTEVOR1RIXzE1MzYpOw0KPiAgCWlmIChyZXQp
DQo+ICAJCXJldHVybiByZXQ7DQo+IC0JZm9yIChpID0gMDsgaSA8IFJUTDgzNjZSQl9OVU1fUE9S
VFM7IGkrKykNCj4gLQkJLyogbGF5ZXIgMiBzaXplLCBzZWUgcnRsODM2NnJiX2NoYW5nZV9tdHUo
KSAqLw0KPiAtCQlyYi0+bWF4X210dVtpXSA9IDE1MzI7DQo+ICsJZm9yIChpID0gMDsgaSA8IFJU
TDgzNjZSQl9OVU1fUE9SVFM7IGkrKykgew0KPiArCQlpZiAoaSA9PSBwcml2LT5jcHVfcG9ydCkN
Cj4gKwkJCS8qIENQVSBwb3J0IG5lZWQgdG8gYWxzbyBhY2NlcHQgdGhlIHRhZyAqLw0KPiArCQkJ
cmItPm1heF9tdHVbaV0gPSBFVEhfREFUQV9MRU4gKyBSVEw4MzY2UkJfQ1BVX1RBR19TSVpFOw0K
PiArCQllbHNlDQo+ICsJCQlyYi0+bWF4X210dVtpXSA9IEVUSF9EQVRBX0xFTjsNCj4gKwl9DQo+
ICANCj4gIAkvKiBEaXNhYmxlIGxlYXJuaW5nIGZvciBhbGwgcG9ydHMgKi8NCj4gIAlyZXQgPSBy
ZWdtYXBfd3JpdGUocHJpdi0+bWFwLCBSVEw4MzY2UkJfUE9SVF9MRUFSTkRJU19DVFJMLA0KPiBA
QCAtMTQ0MiwyNCArMTQ0NywyOSBAQCBzdGF0aWMgaW50IHJ0bDgzNjZyYl9jaGFuZ2VfbXR1KHN0
cnVjdCBkc2Ffc3dpdGNoICpkcywgaW50IHBvcnQsIGludCBuZXdfbXR1KQ0KPiAgCS8qIFJvb2Yg
b3V0IHRoZSBNVFUgZm9yIHRoZSBlbnRpcmUgc3dpdGNoIHRvIHRoZSBncmVhdGVzdA0KPiAgCSAq
IGNvbW1vbiBkZW5vbWluYXRvcjogdGhlIGJpZ2dlc3Qgc2V0IGZvciBhbnkgb25lIHBvcnQgd2ls
bA0KPiAgCSAqIGJlIHRoZSBiaWdnZXN0IE1UVSBmb3IgdGhlIHN3aXRjaC4NCj4gLQkgKg0KPiAt
CSAqIFRoZSBmaXJzdCBzZXR0aW5nLCAxNTIyIGJ5dGVzLCBpcyBtYXggSVAgcGFja2V0IDE1MDAg
Ynl0ZXMsDQo+IC0JICogcGx1cyBldGhlcm5ldCBoZWFkZXIsIDE1MTggYnl0ZXMsIHBsdXMgQ1BV
IHRhZywgNCBieXRlcy4NCj4gLQkgKiBUaGlzIGZ1bmN0aW9uIHNob3VsZCBjb25zaWRlciB0aGUg
cGFyYW1ldGVyIGFuIFNEVSwgc28gdGhlDQo+IC0JICogTVRVIHBhc3NlZCBmb3IgdGhpcyBzZXR0
aW5nIGlzIDE1MTggYnl0ZXMuIFRoZSBzYW1lIGxvZ2ljDQo+IC0JICogb2Ygc3VidHJhY3Rpbmcg
dGhlIERTQSB0YWcgb2YgNCBieXRlcyBhcHBseSB0byB0aGUgb3RoZXINCj4gLQkgKiBzZXR0aW5n
cy4NCj4gIAkgKi8NCj4gLQltYXhfbXR1ID0gMTUxODsNCj4gKwltYXhfbXR1ID0gRVRIX0RBVEFf
TEVOOw0KPiAgCWZvciAoaSA9IDA7IGkgPCBSVEw4MzY2UkJfTlVNX1BPUlRTOyBpKyspIHsNCj4g
IAkJaWYgKHJiLT5tYXhfbXR1W2ldID4gbWF4X210dSkNCj4gIAkJCW1heF9tdHUgPSByYi0+bWF4
X210dVtpXTsNCj4gIAl9DQo+IC0JaWYgKG1heF9tdHUgPD0gMTUxOCkNCj4gKw0KPiArCS8qIFRy
YW5zbGF0ZSB0byBsYXllciAyIHNpemUuDQo+ICsJICogQWRkIGV0aGVybmV0IGFuZCAocG9zc2li
bGUpIFZMQU4gaGVhZGVycywgYW5kIGNoZWNrc3VtIHRvIHRoZSBzaXplLg0KPiArCSAqIEZvciBF
VEhfREFUQV9MRU4gKDE1MDAgYnl0ZXMpIHRoaXMgd2lsbCBhZGQgdXAgdG8gMTUyMiBieXRlcy4N
Cj4gKwkgKi8NCj4gKwltYXhfbXR1ICs9IFZMQU5fRVRIX0hMRU47DQo+ICsJbWF4X210dSArPSBF
VEhfRkNTX0xFTjsNCj4gKw0KPiArCWlmIChtYXhfbXR1IDw9IDE1MjIpDQo+ICAJCWxlbiA9IFJU
TDgzNjZSQl9TR0NSX01BWF9MRU5HVEhfMTUyMjsNCj4gLQllbHNlIGlmIChtYXhfbXR1ID4gMTUx
OCAmJiBtYXhfbXR1IDw9IDE1MzIpDQo+ICsJZWxzZSBpZiAobWF4X210dSA+IDE1MjIgJiYgbWF4
X210dSA8PSAxNTM2KQ0KPiArCQkvKiBUaGlzIHdpbGwgYmUgdGhlIG1vc3QgY29tbW9uIGRlZmF1
bHQgaWYgdXNpbmcgVkxBTiBhbmQNCj4gKwkJICogQ1BVIHRhZ2dpbmcgb24gYSBwb3J0IGFzIGJv
dGggVkxBTiBhbmQgQ1BVIHRhZyB3aWxsDQo+ICsJCSAqIHJlc3VsdCBpbiAxNTE4ICsgNCArIDQg
PSAxNTI2IGJ5dGVzLg0KPiArCQkgKi8NCj4gIAkJbGVuID0gUlRMODM2NlJCX1NHQ1JfTUFYX0xF
TkdUSF8xNTM2Ow0KPiAtCWVsc2UgaWYgKG1heF9tdHUgPiAxNTMyICYmIG1heF9tdHUgPD0gMTU0
OCkNCj4gKwllbHNlIGlmIChtYXhfbXR1ID4gMTUzNiAmJiBtYXhfbXR1IDw9IDE1NTIpDQo+ICAJ
CWxlbiA9IFJUTDgzNjZSQl9TR0NSX01BWF9MRU5HVEhfMTU1MjsNCj4gIAllbHNlDQo+ICAJCWxl
biA9IFJUTDgzNjZSQl9TR0NSX01BWF9MRU5HVEhfMTYwMDA7DQo+IEBAIC0xNDcxLDEwICsxNDgx
LDEyIEBAIHN0YXRpYyBpbnQgcnRsODM2NnJiX2NoYW5nZV9tdHUoc3RydWN0IGRzYV9zd2l0Y2gg
KmRzLCBpbnQgcG9ydCwgaW50IG5ld19tdHUpDQo+ICANCj4gIHN0YXRpYyBpbnQgcnRsODM2NnJi
X21heF9tdHUoc3RydWN0IGRzYV9zd2l0Y2ggKmRzLCBpbnQgcG9ydCkNCj4gIHsNCj4gLQkvKiBU
aGUgbWF4IE1UVSBpcyAxNjAwMCBieXRlcywgc28gd2Ugc3VidHJhY3QgdGhlIENQVSB0YWcNCj4g
LQkgKiBhbmQgdGhlIG1heCBwcmVzZW50ZWQgdG8gdGhlIHN5c3RlbSBpcyAxNTk5NiBieXRlcy4N
Cj4gKwkvKiBUaGUgbWF4IE1UVSBpcyAxNjAwMCBieXRlcywgc28gd2Ugc3VidHJhY3QgdGhlIGV0
aGVybmV0DQo+ICsJICogaGVhZGVycyB3aXRoIFZMQU4gYW5kIGNoZWNrc3VtIGFuZCBhcnJpdmUg
YXQNCj4gKwkgKiAxNjAwMCAtIDE4IC0gNCA9IDE1OTc4LiBUaGlzIGRvZXMgbm90IGluY2x1ZGUg
dGhlIENQVSB0YWcNCj4gKwkgKiBzaW5jZSB0aGF0IGlzIGFkZGVkIHRvIHRoZSByZXF1ZXN0ZWQg
TVRVIGJ5IHRoZSBEU0EgZnJhbWV3b3JrLg0KPiAgCSAqLw0KPiAtCXJldHVybiAxNTk5NjsNCj4g
KwlyZXR1cm4gMTYwMDAgLSBWTEFOX0VUSF9ITEVOIC0gRVRIX0ZDU19MRU47DQo+ICB9DQo+ICAN
Cj4gIHN0YXRpYyBpbnQgcnRsODM2NnJiX2dldF92bGFuXzRrKHN0cnVjdCByZWFsdGVrX3ByaXYg
KnByaXYsIHUzMiB2aWQsDQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+

