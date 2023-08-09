Return-Path: <netdev+bounces-25662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C08D7750E2
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 04:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365FC2819AE
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 02:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED91B64E;
	Wed,  9 Aug 2023 02:27:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81CA376
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 02:27:16 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473D01980
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEwRw3pOLA0PZCy91PJg2Gy8qQ7877Gkvz5Xrgkbu8GObD2ikprhH63FQC4wz1z9iUKM6a/HGHvjF7I3/0FLS1ryWKyYIu/iKp9OEHoNB+DQ8r7g2hkoSpCGTy8qGmA5BU3FkjqLzdmEtWlqHVHCDzQgKFkc1wiKvM0ZkBRJovzUpt6i2q/uTcxpQIz/PZ51k2fiEMVN5RHPqpeGkM+PJvHX6/dWS6hE4o8z8o8W9dojr+6g80ACxTXtmzKyCT5Y29QW3soispc7DX0jLyRE3YNpQFbKlQh/6R0xMmkVS+/D1QaR29uCnTLgyTrSGwFSIqNsStcv2kT1oZwjUMyh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa7A3yJV43/zOV/LDooCAJLascHkm7hdJt39P+6Pj8w=;
 b=YdYlqukePiMeE/AT6i85Gv/GWdPsUZY0JQLoWRfhaxlYAMP3yUkvf6BWAUEegCFEIshAeUvwCUDBzQcwzxrnElSXz9HDHDBCEkQCtOmrFJh49eLfIZgBOVH0N5n72wDGyBNyQYXN/PfkUTiaJ+ikGPUyog9DuEVTAprARMYv0YV4MjCs0hEcdbFbIy4t708GIhEEd0a8mB9jMzUEDObpkAL9VfSteydwvT4qHhO0lF2l82nQtWAAS0FQ1KWgrU7zXW94yrdZRqY6qDSwwTSRY/PCFHHELmpF9KWHOkiXs1aZ6q6qPsNE37p5PifZ7UT7raUyt7mZYtxqsdFZc3BPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa7A3yJV43/zOV/LDooCAJLascHkm7hdJt39P+6Pj8w=;
 b=l5TzQKwVAorjIQLvqGbV4cqvH4dUT4y/I3wvF0Bop97Qvz3PEqIlCPySWkHfP9yUUsSW+6nquIwfAihE3nwk6H96BzDb/zWEty6RdIaQ7Snqh07m9aVhZUdhuqUwaGlG5PaEdl8dPX6AY3ZF0FPLTvosgk25RqBa3zCBGPhTfHI=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB9PR04MB9556.eurprd04.prod.outlook.com (2603:10a6:10:304::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 02:27:12 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 02:27:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marek Vasut <marex@denx.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
Subject: RE: [PATCH] net: phy: at803x: Improve hibernation support on start up
Thread-Topic: [PATCH] net: phy: at803x: Improve hibernation support on start
 up
Thread-Index: AQHZxv1ZKz1KraSXKUS2W3fAHhGdoK/gFe9AgACqzgCAAHgJ0A==
Date: Wed, 9 Aug 2023 02:27:12 +0000
Message-ID:
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
In-Reply-To: <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DB9PR04MB9556:EE_
x-ms-office365-filtering-correlation-id: 57b48948-f0bd-45c5-7b85-08db988023c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9M6WEarxjNyqRLhqfgcPEbA6C4TSbgsoc0LOrjdnLR8Hw4nH+b7sM1gh/i2gY4lY0EahzImepwj1vHtluPVyAlooCZePmy+qIrFXDJ+0IHZXtF8+N17a40qMM2DdJNLmDyHmmz7MYKH5YrXr8HP3nlCHZWF3jjGf/+IfCUtd0/0AohnVhHJzLDudBqVuVmBvvzH4ByKem960Jg8+f6Pu8Oyl3WqiSYJU5iA7zWIAtIrmKJIHwbtx08uBOLMorwjo7BhSUCFO857Ii7vPLnm1Mj/HrWukc8gInyJYSCSqiLpuJq+TTuGLWYeehPkU1xo0z1CQtRJBhQXEapks53jHcYGRNZrQFtiPxeEXGcIL/amt4Nnug59CnSg/DLSHeVA3EmABDdqVCSswImtEUaq7fo30Xs9lhuOx94CuoQswzHxWxvHKMYYjgLeiNWZ9cYkoQyZGaE3YvXNnpzkiOT46tk8AmhlwDodU6S9nejd+cE+b6630CnZLnA6T6W+QEThjdKbpHxBVh4MjOkUyiSfGUyEPxogcbFuAqjGFB1bkongByJdZRxlalozx2uJk4ht5yIgVKo0Xctc9JSWy4gPjva+wstZednxUJfdb3BIXZx+2aQRoXJkVkU3dxvihduDQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(1800799006)(186006)(44832011)(38070700005)(52536014)(8676002)(5660300002)(8936002)(7416002)(55016003)(122000001)(38100700002)(2906002)(86362001)(71200400001)(7696005)(110136005)(83380400001)(54906003)(478600001)(33656002)(26005)(6506007)(9686003)(4326008)(41300700001)(316002)(66476007)(64756008)(66946007)(76116006)(66446008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDNMWlhlMmE4THZuODRlbEhadlNoWlhVUUxwZ29ZekRmUEthYjVUSzN4YnZm?=
 =?utf-8?B?ZmFQVGZ2TElWRWJVSld6NUxMem1SSS9LcEs3TlFlRzRDZks0RGsxSks0TGwv?=
 =?utf-8?B?RllNUU9jQ0NzMTVrSUkxU08vN1kycEtyNUtmcEpDU1c1VmV2cE5TZ3ZqYzJq?=
 =?utf-8?B?a1FmRlYwZkljSVlLaFBWUlMwZzBmcXl2UlhNT1VqN1JZREN1Q3k5bGczZ09o?=
 =?utf-8?B?bUZGemN2R3F5MTF5aGl4Y1QwcUtudzJLanFWa1RqbzNJd0wvSzJsR2NkUHZZ?=
 =?utf-8?B?VVk4NkhSeUg3cEhLUmhaWVdmalNVY2tmVUJkM3NNSEdEbzAyMUUyS3NVcUph?=
 =?utf-8?B?eSsydm1PL0tpMmVuUjhQMGhwSk01WlFvb3JRNVJ2UnlBb2ZyYXZYOUFPNzNu?=
 =?utf-8?B?TU1FNGFSMTFxNHhFL00rT1doZW1ZdFNFVzF2YzhId3o1OTI1QXdEU2Y2UG9j?=
 =?utf-8?B?TENNM1g1UG92Y2c4aWU0WGRIL0NGYnlKdGpGcEtnNWhjWnpoUU04SmpQLzN1?=
 =?utf-8?B?SGhDSzRjd1ZDb290eUU2dEh2Ui9CTUh0RXFyZVlzMklRV1VzTzdmMnQ1cHZJ?=
 =?utf-8?B?TzV5czlDWWtRVVVKd3M3VWIwK0JRaW9jZS9oVmNXTWxXVTZUVU41R3pXM3Bz?=
 =?utf-8?B?cEZPZitNTUNrS2lHRE9VdHdqd0FyMGhjK1dMUmg0dmd6aWxHZWNnWklkM054?=
 =?utf-8?B?Nm9zSDlVR3VCRTRUSDhIdjhWQlkxMWlPRFhHdlJBaHd0azM4K3lCRDIwYVQ3?=
 =?utf-8?B?UFl1ODFzbytwWGtabmNISlZVeFRiZjZRUkF1cEJ6ZnVhRE44ZFJtbzk1NlFj?=
 =?utf-8?B?djNva2I5TGVzOXdlV0hZYjdiS3BZWUMxRitCYmE0TFQ5MENsamJPNTBydE5o?=
 =?utf-8?B?OEdYYTFlcTc0TjNCcUVVYWlSeGNZRGtiSkU3b0d4UUJxeWEzY1NiaGU3bUlq?=
 =?utf-8?B?YTFWaFoxbjQ5ZFpIN2RPalMyTGloZHJRWThEdzk2bDU3cmhVTzhDa28vbjJ3?=
 =?utf-8?B?a0JsRDVLMFJ1TENCSUs5dGJQQ05Hajh0dGhBTjYxSmxLZkh4TzRxMTFPMDl2?=
 =?utf-8?B?QURMc1JNK2wzRVF4VDBudVRhK1pGRlFhNngrVHdsVmE5L1VNVEtlMUxDSjZi?=
 =?utf-8?B?cWVtdkc0ZSsxUFNTMFFLZEVSaUtWUnA5cEtwVnd3NDN3Ylhsa3pwNW92TCtR?=
 =?utf-8?B?S2lvclJNaGxZeHp0OS9YV2Z1Z3dqNGtsSjVIVHovai9XUldlNi81MTFVUm1m?=
 =?utf-8?B?ZGxDeW5ybTNMQlE0ZHdtVlFpSUFERUdjTk5nbFl5L2FRckRDYVdnQWtIL01M?=
 =?utf-8?B?KzhhMkNRSUNHaW82eUxJUVRXU3dsV25xVE9RM1hlczJMWFozNVBmRXBxbkNh?=
 =?utf-8?B?cWYzSlNocEZGUGo0OWpKTmszNVNvWjdPbDVJd1h0VWhlVEFtTWRwdEg0RjRa?=
 =?utf-8?B?SytSd1VFdXZDTVkyb3BYQXg0Q2lBSm4xVjdQZHpkVjFubjJ5S2tFUVZhRWxY?=
 =?utf-8?B?YVRrbGRFSHlEK3VybHE4REg5WVhHaVdUYXVnSEJWU1lpZW9yZUd3dGk5dXd3?=
 =?utf-8?B?VS9obnZNVXBmckJBZjI5YitPOUtGTVRHbVVTa1Z4ZlVFQmxRZk1NZkdpRFlw?=
 =?utf-8?B?QzB4NGZPS2pEQVUrdzlicEVBZTVJbHFrL3VBaHJFbUpjNGxoOEQ2OWR2M1U2?=
 =?utf-8?B?L3Z0SHRuYnNyYjFSc21qRzVoY0RpZms3R3hhcm9xS0ZyY2h0L0NJUmthTWxJ?=
 =?utf-8?B?UlVlcTQwaDdxZ1pjQ3BxM04zdjd4VjdXS0tSaEVGNzg4Zm1rV0FFOE5nZ3RN?=
 =?utf-8?B?dlFXMTlQWFd6U0JuTDYzS2t4SGZ0ckJnMjE4NTVHT203YWtUZzI2QUhQK3dV?=
 =?utf-8?B?MUlvNDkzNXJxMjV0eVFYRmFRamljT2VnSm5UVlhiT1A1YXROUm5WTU5vZm41?=
 =?utf-8?B?QTVEMmk5amZEWWE0czNVVXJTSmZPOGNwR1BPNEZ0dEJQRkVaYWU0MFo2SUdG?=
 =?utf-8?B?WlBLZ0dPUGNwKys3d2M5WlV5VUR1cWR4bmhJODV1aldOSFhjRHc1UXU1NmF0?=
 =?utf-8?B?ZzBDNDY3YVpwSVBCekEvUkNycUNuRzcveVhpTHM2K3BteTIwTEN5bWRJT3NZ?=
 =?utf-8?Q?kqZo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b48948-f0bd-45c5-7b85-08db988023c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 02:27:12.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hw56YDSnhVV4TXe81td7XcYR9EG0ufCiapXFDH6yihraitt07q3jAveBfjtA4CdFC1v79AE2AJBJgEdoiBs1Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9556
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiA+PiBUb2dnbGUgaGliZXJuYXRpb24gbW9kZSBPRkYgYW5kIE9OIHRvIHdha2UgdGhlIFBIWSB1
cCBhbmQgbWFrZSBpdA0KPiA+PiBnZW5lcmF0ZSBjbG9jayBvbiBSWF9DTEsgcGluIGZvciBhYm91
dCAxMCBzZWNvbmRzLg0KPiA+PiBUaGVzZSBjbG9jayBhcmUgbmVlZGVkIGR1cmluZyBzdGFydCB1
cCBieSBNQUNzIGxpa2UgRFdNQUMgaW4gTlhQDQo+ID4+IGkuTVg4TSBQbHVzIHRvIHJlbGVhc2Ug
dGhlaXIgRE1BIGZyb20gcmVzZXQuIEFmdGVyIHRoZSBNQUMgaGFzDQo+ID4+IHN0YXJ0ZWQgdXAs
IHRoZSBQSFkgY2FuIGVudGVyIGhpYmVybmF0aW9uIGFuZCBkaXNhYmxlIHRoZSBSWF9DTEsNCj4g
Pj4gY2xvY2ssIHRoaXMgcG9zZXMgbm8gcHJvYmxlbSBmb3IgdGhlIE1BQy4NCj4gPj4NCj4gPj4g
T3JpZ2luYWxseSwgdGhpcyBpc3N1ZSBoYXMgYmVlbiBkZXNjcmliZWQgYnkgTlhQIGluIGNvbW1p
dA0KPiA+PiA5ZWNmMDQwMTZjODcgKCJuZXQ6IHBoeTogYXQ4MDN4OiBhZGQgZGlzYWJsZSBoaWJl
cm5hdGlvbiBtb2RlDQo+ID4+IHN1cHBvcnQiKSBidXQgdGhpcyBhcHByb2FjaCBmdWxseSBkaXNh
YmxlcyB0aGUgaGliZXJuYXRpb24gc3VwcG9ydA0KPiA+PiBhbmQgdGFrZXMgYXdheSBhbnkgcG93
ZXIgc2F2aW5nIGJlbmVmaXQuIFRoaXMgcGF0Y2ggaW5zdGVhZCBtYWtlcyB0aGUNCj4gPj4gUEhZ
IGdlbmVyYXRlIHRoZSBjbG9jayBvbiBzdGFydCB1cCBmb3IgMTAgc2Vjb25kcywgd2hpY2ggc2hv
dWxkIGJlDQo+ID4+IGxvbmcgZW5vdWdoIGZvciB0aGUgRVFvUyBNQUMgdG8gcmVsZWFzZSBETUEg
ZnJvbSByZXNldC4NCj4gPj4NCj4gPj4gQmVmb3JlIHRoaXMgcGF0Y2ggb24gaS5NWDhNIFBsdXMg
Ym9hcmQgd2l0aCBBUjgwMzEgUEhZOg0KPiA+PiAiDQo+ID4+ICQgaWZjb25maWcgZXRoMSB1cA0K
PiA+PiBbICAgMjUuNTc2NzM0XSBpbXgtZHdtYWMgMzBiZjAwMDAuZXRoZXJuZXQgZXRoMTogUmVn
aXN0ZXINCj4gPj4gTUVNX1RZUEVfUEFHRV9QT09MIFJ4US0wDQo+ID4+IFsgICAyNS42NTg5MTZd
IGlteC1kd21hYyAzMGJmMDAwMC5ldGhlcm5ldCBldGgxOiBQSFkgW3N0bW1hYy0xOjAwXQ0KPiA+
PiBkcml2ZXIgW1F1YWxjb21tIEF0aGVyb3MgQVI4MDMxL0FSODAzM10gKGlycT0zOCkNCj4gPj4g
WyAgIDI2LjY3MDI3Nl0gaW14LWR3bWFjIDMwYmYwMDAwLmV0aGVybmV0OiBGYWlsZWQgdG8gcmVz
ZXQgdGhlIGRtYQ0KPiA+PiBbICAgMjYuNjc2MzIyXSBpbXgtZHdtYWMgMzBiZjAwMDAuZXRoZXJu
ZXQgZXRoMTogc3RtbWFjX2h3X3NldHVwOg0KPiA+PiBETUEgZW5naW5lIGluaXRpYWxpemF0aW9u
IGZhaWxlZA0KPiA+PiBbICAgMjYuNjg1MTAzXSBpbXgtZHdtYWMgMzBiZjAwMDAuZXRoZXJuZXQg
ZXRoMTogX19zdG1tYWNfb3BlbjoNCj4gSHcNCj4gPj4gc2V0dXAgZmFpbGVkDQo+ID4+IGlmY29u
ZmlnOiBTSU9DU0lGRkxBR1M6IENvbm5lY3Rpb24gdGltZWQgb3V0ICINCj4gPj4NCj4gPg0KPiA+
IEhhdmUgeW91IHJlcHJvZHVjZWQgdGhpcyBpc3N1ZSBiYXNlZCBvbiB0aGUgdXBzdHJlYW0gbmV0
LW5leHQgb3IgbmV0DQo+IHRyZWU/DQo+IA0KPiBPbiBjdXJyZW50IGxpbnV4LW5leHQgbmV4dC0y
MDIzMDgwOCBzbyA2LjUuMC1yYzUgLiBBcyBmYXIgYXMgSSBjYW4gdGVsbCwNCj4gbmV0LW5leHQg
aXMgbWVyZ2VkIGludG8gdGhpcyB0cmVlIHRvby4NCj4gDQoNCj4gPiBJZiBzbywgY2FuIHRoaXMg
aXNzdWUgYmUgcmVwcm9kdWNlZD8gVGhlIHJlYXNvbiB3aHkgSSBhc2sgdGhpcyBpcw0KPiA+IGJl
Y2F1c2Ugd2hlbiBJIHRyaWVkIHRvIHJlcHJvZHVjZSB0aGlzIHByb2JsZW0gb24gbmV0LW5leHQg
Ni4zLjANCj4gPiB2ZXJzaW9uLCBJIGZvdW5kIHRoYXQgaXQgY291bGQgbm90IGJlIHJlcHJvZHVj
ZWQgKEkgZGlkIG5vdCBkaXNhYmxlDQo+ID4gaGliZXJuYXRpb24gbW9kZSB3aGVuIEkgcmVwcm9k
dWNlZCB0aGlzIGlzc3VlICkuIFNvIEkgZ3Vlc3MgbWF5YmUgb3RoZXINCj4gcGF0Y2hlcyBpbiBl
cW9zIGRyaXZlciBmaXhlZCB0aGUgaXNzdWUuDQo+IA0KPiBUaGlzIGlzIHdoYXQgSSB1c2UgZm9y
IHRlc3Rpbmc6DQo+IA0KPiAtIE1ha2Ugc3VyZSAicWNhLGRpc2FibGUtaGliZXJuYXRpb24tbW9k
ZSIgaXMgTk9UIHByZXNlbnQgaW4gUEhZIERUIG5vZGUNClllcywgSSBkZWxldGVkIHRoaXMgcHJv
cGVydHkgd2hlbiBJIHJlcHJvZHVjZWQgdGhpcyBpc3N1ZS4NCg0KPiAtIEJvb3QgdGhlIG1hY2hp
bmUgd2l0aCBOTyBldGhlcm5ldCBjYWJsZSBwbHVnZ2VkIGludG8gdGhlIGFmZmVjdGVkIHBvcnQN
Cj4gICAgKGkuZS4gdGhlIEVRb1MgcG9ydCksIHRoaXMgaXMgaW1wb3J0YW50DQo+IC0gTWFrZSBz
dXJlIHRoZSBFUW9TIE1BQyBpcyBub3QgYnJvdWdodCB1cCBlLmcuIGJ5IHN5c3RlbWQtbmV0d29y
a2Qgb3INCj4gICAgd2hhdGV2ZXIgb3RoZXIgdG9vbCwgSSB1c2UgYnVzeWJveCBpbml0cmFtZnMg
Zm9yIHRlc3Rpbmcgd2l0aCBwbGFpbg0KPiAgICBzY3JpcHQgYXMgaW5pdCAoaXQgbW91bnRzIHRo
ZSB2YXJpb3VzIGZpbGVzeXN0ZW1zIGFuZCBydW5zIC9iaW4vc2gpDQoNCkl0IGxvb2tzIGxpa2Ug
c29tZXRoaW5nIGhhcyBiZWVuIGNoYW5nZWQgc2luY2UgSSBzdWJtaXR0ZWQgdGhlICJkaXNhYmxl
IGhpYmVybmF0aW9uDQptb2RlICIgcGF0Y2guIEluIHByZXZpb3VzIHRlc3QsIEkgb25seSBuZWVk
IHRvIHVucGx1ZyB0aGUgY2FibGUgYW5kIHRoZW4gdXNlIGlmY29uZmlnDQpjbWQgdG8gZGlzYWJs
ZSB0aGUgaW50ZXJmYWNlLCB3YWl0IG1vcmUgdGhhbiAxMCBzZWNvbmRzLCB0aGVuIHVzZSBpZmNv
bmZpZyBjbWQgdG8NCmVuYWJsZSB0aGUgaW50ZXJmYWNlLg0KDQo+IC0gV2FpdCBsb25nZXIgdGhh
biAxMCBzZWNvbmRzDQo+IC0gSWYgcG9zc2libGUsIG1lYXN1cmUgQVI4MDMxIFBIWSBwaW4gMzMg
UlhfQ0xLLCB3YWl0IGZvciB0aGUgUlhfQ0xLIHRvDQo+ICAgIGJlIHR1cm5lZCBPRkYgYnkgdGhl
IFBIWSAobWVhbnMgUEhZIGVudGVyZWQgaGliZXJuYXRpb24pDQo+IC0gaWZjb25maWcgZXRoTiB1
cCAtLSB0cnkgdG8gYnJpbmcgdXAgdGhlIEVRb1MgTUFDIDxvYnNlcnZlIGZhaWx1cmU+DQo+IA0K
PiBbLi4uXQ0KDQpGb3IgdGhlIHBhdGNoLCBJIHRoaW5rIHlvdXIgYXBwcm9hY2ggaXMgYmV0dGVy
IHRoYW4gbWluZSwgYnV0IEkgaGF2ZSBhIHN1Z2dlc3Rpb24sDQppcyB0aGUgZm9sbG93aW5nIG1v
ZGlmaWNhdGlvbiBtb3JlIGFwcHJvcHJpYXRlPw0KDQotLS0gYS9kcml2ZXJzL25ldC9waHkvYXQ4
MDN4LmMNCisrKyBiL2RyaXZlcnMvbmV0L3BoeS9hdDgwM3guYw0KQEAgLTk5MSwxMiArOTkxLDI4
IEBAIHN0YXRpYyBpbnQgYXQ4MDMxX3BsbF9jb25maWcoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRl
dikNCiBzdGF0aWMgaW50IGF0ODAzeF9oaWJlcm5hdGlvbl9tb2RlX2NvbmZpZyhzdHJ1Y3QgcGh5
X2RldmljZSAqcGh5ZGV2KQ0KIHsNCiAgICAgICAgc3RydWN0IGF0ODAzeF9wcml2ICpwcml2ID0g
cGh5ZGV2LT5wcml2Ow0KKyAgICAgICBpbnQgcmV0Ow0KDQogICAgICAgIC8qIFRoZSBkZWZhdWx0
IGFmdGVyIGhhcmR3YXJlIHJlc2V0IGlzIGhpYmVybmF0aW9uIG1vZGUgZW5hYmxlZC4gQWZ0ZXIN
CiAgICAgICAgICogc29mdHdhcmUgcmVzZXQsIHRoZSB2YWx1ZSBpcyByZXRhaW5lZC4NCiAgICAg
ICAgICovDQotICAgICAgIGlmICghKHByaXYtPmZsYWdzICYgQVQ4MDNYX0RJU0FCTEVfSElCRVJO
QVRJT05fTU9ERSkpDQotICAgICAgICAgICAgICAgcmV0dXJuIDA7DQorICAgICAgIGlmICghKHBy
aXYtPmZsYWdzICYgQVQ4MDNYX0RJU0FCTEVfSElCRVJOQVRJT05fTU9ERSkpIHsNCisgICAgICAg
ICAgICAgICAvKiBUb2dnbGUgaGliZXJuYXRpb24gbW9kZSBPRkYgYW5kIE9OIHRvIHdha2UgdGhl
IFBIWSB1cCBhbmQNCisgICAgICAgICAgICAgICAgKiBtYWtlIGl0IGdlbmVyYXRlIGNsb2NrIG9u
IFJYX0NMSyBwaW4gZm9yIGFib3V0IDEwIHNlY29uZHMuDQorICAgICAgICAgICAgICAgICogVGhl
c2UgY2xvY2sgYXJlIG5lZWRlZCBkdXJpbmcgc3RhcnQgdXAgYnkgTUFDcyBsaWtlIERXTUFDDQor
ICAgICAgICAgICAgICAgICogaW4gTlhQIGkuTVg4TSBQbHVzIHRvIHJlbGVhc2UgdGhlaXIgRE1B
IGZyb20gcmVzZXQuIEFmdGVyDQorICAgICAgICAgICAgICAgICogdGhlIE1BQyBoYXMgc3RhcnRl
ZCB1cCwgdGhlIFBIWSBjYW4gZW50ZXIgaGliZXJuYXRpb24gYW5kDQorICAgICAgICAgICAgICAg
ICogZGlzYWJsZSB0aGUgUlhfQ0xLIGNsb2NrLCB0aGlzIHBvc2VzIG5vIHByb2JsZW0gZm9yIHRo
ZSBNQUMuDQorICAgICAgICAgICAgICAgICovDQorICAgICAgICAgICAgICAgcmV0ID0gYXQ4MDN4
X2RlYnVnX3JlZ19tYXNrKHBoeWRldiwgQVQ4MDNYX0RFQlVHX1JFR19ISUJfQ1RSTCwNCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQVQ4MDNYX0RFQlVHX0hJQl9D
VFJMX1BTX0hJQl9FTiwgMCk7DQorICAgICAgICAgICAgICAgaWYgKHJldCA8IDApDQorICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KKw0KKyAgICAgICAgICAgICAgIHJldHVybiBh
dDgwM3hfZGVidWdfcmVnX21hc2socGh5ZGV2LCBBVDgwM1hfREVCVUdfUkVHX0hJQl9DVFJMLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQVQ4MDNYX0RFQlVH
X0hJQl9DVFJMX1BTX0hJQl9FTiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEFUODAzWF9ERUJVR19ISUJfQ1RSTF9QU19ISUJfRU4pOw0KKyAgICAgICB9DQoN
CiAgICAgICAgcmV0dXJuIGF0ODAzeF9kZWJ1Z19yZWdfbWFzayhwaHlkZXYsIEFUODAzWF9ERUJV
R19SRUdfSElCX0NUUkwsDQo=

