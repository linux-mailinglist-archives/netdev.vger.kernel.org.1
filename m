Return-Path: <netdev+bounces-41154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF067C9FB2
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 08:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98046280D10
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 06:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3DEEEBC;
	Mon, 16 Oct 2023 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lX29GDtg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14679F1
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:36:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992398E
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 23:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN4upLYv5DvmzE/oExoK789P1GtiNXqRFgiZosKXj6imo2oML+WAqHmzWeYJHskWCgLuvVA27+/T3OxnWTvVrbbSSC5By7Cee9fygl/NdthxctKBOWICJ6quQMCaO1vccSkdhiVtA6FTke/Y5OzP025ZhZnoZ8dv+XzMexJOfOQ6MLqxpbiGihsgSOZWKaR5zaeI2qr44infipb+SuHqmVkXMgZvPPzlSIPg5N0hTq0EIyNFHKhBy083hKyPiaIEFVw5banOIKaY1Alg9RCOsf98Ag3Ilk8mqYOGTat0bvlQlvNt3taaib1CVbQpih308ut5CCq7wuHkm3WJ0EGAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJlzhJ/9Rf1C9oKydiBNt8X5BS0oBH9397w62EMYdxc=;
 b=dfwiAuUDz1LzqW089EbGW9z4OJ36JaeIt40GRLSuAU9oP9IbykgAnIPEcLLDTTSeV6mbIcfRiwxISlMy9MrRhAROciCArlcw7NZqSmrw4p4s3S0JApG1LwLDu/z2fzoVI0oHcPLKqAePHLbRekRQp+Y/DgW82HP67bkIF1wsGB/Ds55G5YG9Sg9taFw92+jpXtpGCq008fFY/gynZlwPAoTh9uuF98ZjekVqeXFaDJkpVbyb/Mb6RN4BNTIYN6sF+DCPaTz8Eaj+pturs4/xppG9qQRxgWAlnRUd9CJj5YcYNPr+iEIfBOTi/yjM9ma/zK6aQtISMQ+0XimKCatpgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJlzhJ/9Rf1C9oKydiBNt8X5BS0oBH9397w62EMYdxc=;
 b=lX29GDtg+460vcrTUZpdC78CVxhl2ob9F58Dzd3Q7O2aOrN2mIAPGUG73ZaKYZtKhfs9GacFun821aqR39zmEKc4GIldgkk/9Lh5qI+vCy3zh4sVkz3ttu/aORHyuG1A/OSSuwpqIC1hjMbn+FWeW05FP2NUa5aehDh6hPvCWo9LyxQoIpfGm/pVT6dNagIgLnbTGzTmxYwIz5PBQO7pTgzLidk2RnsQ8me2GqJhrpCufFapYonHtKbiFFjI0KScE3Hqyk82pslZxbJIf1Y+hSw6IJHrjjV1CBRz7/PI4GT7IOJ2DHVMioH64bfbvsybBox4vl8PfMxOckPxSXWYuw==
Received: from BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 06:36:18 +0000
Received: from BL1PR12MB5922.namprd12.prod.outlook.com
 ([fe80::7ac4:7661:d912:94d4]) by BL1PR12MB5922.namprd12.prod.outlook.com
 ([fe80::7ac4:7661:d912:94d4%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 06:36:18 +0000
From: Amit Cohen <amcohen@nvidia.com>
To: "dsahern@gmail.com" <dsahern@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "razor@blackwall.org" <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: RE: [PATCH iproute2] bridge: fdb: add an error print for unknown
 command
Thread-Topic: [PATCH iproute2] bridge: fdb: add an error print for unknown
 command
Thread-Index: AQHZ+2BLG+odwiI6VkCtD1QVbhA1orBHBnmAgAT3ePA=
Date: Mon, 16 Oct 2023 06:36:18 +0000
Message-ID:
 <BL1PR12MB5922484EDA55CD9363B0D673CBD7A@BL1PR12MB5922.namprd12.prod.outlook.com>
References: <20231010095750.2975206-1-amcohen@nvidia.com>
 <169716482325.8025.6745747640034207795.git-patchwork-notify@kernel.org>
In-Reply-To:
 <169716482325.8025.6745747640034207795.git-patchwork-notify@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5922:EE_|DS0PR12MB8019:EE_
x-ms-office365-filtering-correlation-id: d2c27607-9cb1-4b4a-65fe-08dbce12342d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Z7Irk/i7yeI5DTeLBEOZ435FA+pFJGQ/SwU+qk63GL8ygtqAMIW5AKQpAenB0Ajwvck5LQEht+/Vdc6utTdA/vvztvxzl+0Vp/msiJtusrB0dvOskCFm2M/sVpPs2Od+nYqNLG2+YbSKDZBIjk4d2MtzQf1pT/61iq8cb2OgGpJc0r0fxDTGCVecxWYUGlt3L/X5RVH98avGKsq/bnypg4TCTuGBOYLjBWAnLdp4gPhOKDlh2bZtYqde4o6hzkQTtlxZ/Yj6xk/iFnkk0Yu0VRrqh/AnRgySPV63LCNEvB9gKNdID9N2B12IkdHIAv6HOcLGQUDyRWAEGbyzcvwxa6muDUMUcH6XLBQ45vJsUMMim8Hfj1/YV/PpYGx9ejzDVAyQrE/B+ERLuGpXCxvGvtqv3LP7CyDUtLSuXOoGEA2KVdWD0CnnX05+rXKab8nNiOXTtHP8Zwp1M3EeAmVNlgAp73sjdbz7oyVdYf6DHe/daudBmqONyGn40k66UwWTp0ju4krZzm97vLBVp4sgQ6DqhB1v/mml2hWByhk7VpWl1pGpW02vkLuSunFbxNeSQTJyQb0FCZK5abhd9gHFhxElo9gnbioM1JEdD8Gnz491DOhU+YOO/1BtAjJO88WOVZG6xh4hx9VZwCpiiQ4L6BvsXJpqHRltRxQrEG40wxA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5922.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(86362001)(33656002)(55016003)(2906002)(478600001)(7696005)(9686003)(71200400001)(41300700001)(5660300002)(966005)(53546011)(6506007)(38070700005)(122000001)(38100700002)(107886003)(26005)(76116006)(66946007)(66556008)(66446008)(64756008)(54906003)(66476007)(52536014)(6916009)(316002)(8936002)(8676002)(4326008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlRTNFFyMHVKN0VvR25HSkYvZlpTc05DeFB2NDhrRDlDL05CUUp3ajd6Y0xa?=
 =?utf-8?B?SGpCZGxoa0FyNjFLNXp6MlNDdFo5eE1oZmZKQ21nTktyWVZXNnRZK1RvbHhV?=
 =?utf-8?B?blNNeGhLQ3V4aThLM1orekx5cUNTSm5ZM25BTGkreHVxYjJQQUpSb25VVWZa?=
 =?utf-8?B?ditCV3NnZHJXY3M1Z255TUxkUnBOTmIwcUduSGJzRmdmdUxFQzJSeWNnRmNB?=
 =?utf-8?B?bklJeSs2MmlGOGw1OXNURlFqNHZ0UEtTVzdqZk9pa0FCWU5Lc3hZZHRJd1Zz?=
 =?utf-8?B?dWFDMnVtY2NQZjdtbVVXcXp0QWF4UHQvR2NSU2hhR0lVZnN0SmhUYjc3Qjkx?=
 =?utf-8?B?UEI2OWsyUWNLRFZLOFNPYkxkcThtTUh3V29PMmlFSjhiaFZXSGl6aFFBSHpD?=
 =?utf-8?B?VFRKbmZiZ1d2bTE5UFhLMGtYcHp6V2czWmIvWC94OHB2UDdkK0JBRGhQMEhU?=
 =?utf-8?B?bU5FbzNIelpoUHNoT202MFd6YjRpTTdXR3NTNG1RdFIxWnZZVlRiS05FS3px?=
 =?utf-8?B?ZUVyT1ZTcEdSWFRySHdQeklwKzREaWFEUHhUbHdINDRnSUlyMkUreWZueHNh?=
 =?utf-8?B?UUVZb00rd1VkQVBLOENiZzlsTGNzOVRvRzkxdHJOLzZ2UTRPQjIvTnBNb0Vk?=
 =?utf-8?B?QVgxa21nRHBjVlFacUtnaXU2eVpnSnVYam84aDhKVDIydWJURlc4czgvQVFu?=
 =?utf-8?B?YzluWk9BZjZHSk5aeHE2U2wydWF3NnhBaHlSdXFSMk9ER2djWHY1NlZzTkVC?=
 =?utf-8?B?VWZUSDBzMit1VEhoRXZmTVg4amhnd1RRQ0wzcndiRkU0ZW9keVRMVTBIa2xQ?=
 =?utf-8?B?ZmxUL2xPYm5uc2dKNTFGVkR4c21qcWJ0ditkbVp0d3gvZXYxWm5GdllUd3k4?=
 =?utf-8?B?a1FwSkFteXVYSmZYNm84dUd4MXFLcmxFVmRCaXFLVHJ4RU8rYVFPV2ptZUlT?=
 =?utf-8?B?bytiQkhCdE1WSm9ETi9IZjV3dGhNOTlqL004YWpnM0F5RU9WNjBYeldWTndY?=
 =?utf-8?B?UmNxSHA5M0ZjNTNCUWI3eUhCeFRLdEI0K21GeTh4MERNVmJMM1R1MWFlY2hp?=
 =?utf-8?B?ZjRua2JXMVhvYjNKdXdmbXVXaFpHczJhbzVGQmZuYTFkcXV0V0hnejBaY0Ew?=
 =?utf-8?B?SDhPOG81MHYwdXZNRGZnU0FFWGpzY3pMeHVlc2hyOHpHUjE2K2VBclExc0pU?=
 =?utf-8?B?T0R2RmlNYmZnT0RreVRLQ3c5NjZUSHYzZ2pFMndTelUxbExKQnNDODduazFv?=
 =?utf-8?B?TlhPNWpyMTVucDRlcTZmV2JscHlpbmE3azRzUEYwRVg0cDFlbFIwSzh1ZUh0?=
 =?utf-8?B?NWdzU1pjck5tQVlyK3lQbUdKbzM2aVJ0VjNJWXE4UGRlVkhiakFEbFZZNGs0?=
 =?utf-8?B?TTE2c1YyU2RtSVI3OHZZdXQ4Y3BPeDBKRTZ2ajd3QmFQQjBNcjFDWXpxZkdK?=
 =?utf-8?B?Ky8xa3FSYWNPeFNjR0ZlSm1jdUEzcjA0aHlRbS9taTA2ODRNaURDWGV2dDhD?=
 =?utf-8?B?TjQ4WmN4QXRhU3RBTVJURU4vaDR5N2lIQzhoeVRUWUlPTFArYUNNQ004YkQ0?=
 =?utf-8?B?bmRGUERkYm10b1NwdlhLcTRFTWRORnR5NFdGVzkxWlFqbGFHb3JsZExubnBr?=
 =?utf-8?B?QlpqNXdHbjJVRVlNK2dsbm5GVzRFeFJuTFYwRnA3dG5mdHBHRllLT3l5Y0o0?=
 =?utf-8?B?YUpzTElSTHJsWjVIdTJaQXJIaVlkR04vNUN5Z2ludDlSbFdnWlg5V1MwRlNP?=
 =?utf-8?B?RW5UeHNHT3BXOGhXZGkzYjY3SWNrT3VzL293ekZhUzVSeTVmS05MV3IvclJa?=
 =?utf-8?B?VVRGdC9aMW5BWFdpUkFmUnB2TW14cXUwbi9EUStOV2tsTFJReXBxZC9jdUV6?=
 =?utf-8?B?b0hSaWxIWlhkV200bXZpOExpbUZqZERUWnRXVzY2R3poZnRNS0JlNDBRZ2gz?=
 =?utf-8?B?b29EVjhBVFJxVEptMEVCcFl2K2ZPMFVVRkhVNFdhci9JcVY5eUplOS94U1ZT?=
 =?utf-8?B?R1RveWk3T0tQeDRMQUZqMVl1M2x4YWVXMnlJMmVrTzNTRTFnWjJ2MmM1aGwx?=
 =?utf-8?B?U2ZHRmlHS0lMaE5CeklsV0I4UHZvY05mVHV6MXYzamVrU3gxK0dMOUEybVNk?=
 =?utf-8?Q?lBxAZUmSk6bL99G8geH0RmZ2b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5922.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c27607-9cb1-4b4a-65fe-08dbce12342d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 06:36:18.3169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTVveBaxrGC13tg1qa4WHsemXLMCRh87XlKxbG9lhCLflr+7i05ajn7KKJJfrcmDB+MAoWh0j+0s66c897W56Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBwYXRjaHdvcmstYm90K25ldGRl
dmJwZkBrZXJuZWwub3JnIDxwYXRjaHdvcmstDQo+IGJvdCtuZXRkZXZicGZAa2VybmVsLm9yZz4N
Cj4gU2VudDogRnJpZGF5LCAxMyBPY3RvYmVyIDIwMjMgNTo0MA0KPiBUbzogQW1pdCBDb2hlbiA8
YW1jb2hlbkBudmlkaWEuY29tPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbWx4c3cg
PG1seHN3QG52aWRpYS5jb20+Ow0KPiBkc2FoZXJuQGdtYWlsLmNvbTsgc3RlcGhlbkBuZXR3b3Jr
cGx1bWJlci5vcmc7IHJhem9yQGJsYWNrd2FsbC5vcmc7DQo+IFJvb3BhIFByYWJodSA8cm9vcGFA
bnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBpcHJvdXRlMl0gYnJpZGdlOiBmZGI6
IGFkZCBhbiBlcnJvciBwcmludCBmb3IgdW5rbm93bg0KPiBjb21tYW5kDQo+IA0KPiBIZWxsbzoN
Cj4gDQo+IFRoaXMgcGF0Y2ggd2FzIGFwcGxpZWQgdG8gaXByb3V0ZTIvaXByb3V0ZTIuZ2l0ICht
YWluKQ0KPiBieSBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+
Og0KPiANCj4gT24gVHVlLCAxMCBPY3QgMjAyMyAxMjo1Nzo1MCArMDMwMCB5b3Ugd3JvdGU6DQo+
ID4gQ29tbWl0IDZlMWNhNDg5YzVhMiAoImJyaWRnZTogZmRiOiBhZGQgbmV3IGZsdXNoIGNvbW1h
bmQiKSBhZGRlZA0KPiBzdXBwb3J0DQo+ID4gZm9yICJicmlkZ2UgZmRiIGZsdXNoIiBjb21tYW5k
LiBUaGlzIGNvbW1pdCBkaWQgbm90IGhhbmRsZSB1bnN1cHBvcnRlZA0KPiA+IGtleXdvcmRzLCB0
aGV5IGFyZSBqdXN0IGlnbm9yZWQuDQo+ID4NCj4gPiBBZGQgYW4gZXJyb3IgcHJpbnQgdG8gbm90
aWZ5IHRoZSB1c2VyIHdoZW4gYSBrZXl3b3JkIHdoaWNoIGlzIG5vdCBzdXBwb3J0ZWQNCj4gPiBp
cyB1c2VkLiBUaGUga2VybmVsIHdpbGwgYmUgZXh0ZW5kZWQgdG8gc3VwcG9ydCBmbHVzaCB3aXRo
IFZYTEFOIGRldmljZSwNCj4gPiBzbyBuZXcgYXR0cmlidXRlcyB3aWxsIGJlIHN1cHBvcnRlZCAo
ZS5nLiwgdm5pLCBwb3J0KS4gV2hlbiBpcHJvdXRlLTIgZG9lcw0KPiA+IG5vdCB3YXJuIGZvciB1
bnN1cHBvcnRlZCBrZXl3b3JkLCB1c2VyIG1pZ2h0IHRoaW5rIHRoYXQgdGhlIGZsdXNoDQo+IGNv
bW1hbmQNCj4gPiB3b3JrcywgYWx0aG91Z2ggdGhlIGlwcm91dGUtMiB2ZXJzaW9uIGlzIHRvbyBv
bGQgYW5kIGl0IGRvZXMgbm90IHNlbmQgVlhMQU4NCj4gPiBhdHRyaWJ1dGVzIHRvIHRoZSBrZXJu
ZWwuDQo+ID4NCj4gPiBbLi4uXQ0KPiANCj4gSGVyZSBpcyB0aGUgc3VtbWFyeSB3aXRoIGxpbmtz
Og0KPiAgIC0gW2lwcm91dGUyXSBicmlkZ2U6IGZkYjogYWRkIGFuIGVycm9yIHByaW50IGZvciB1
bmtub3duIGNvbW1hbmQNCj4gDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9uZXR3
b3JrL2lwcm91dGUyL2lwcm91dGUyLmdpdC9jb21taXQvP2lkPWYNCj4gMTE2MGEwZjZiYjMNCj4g
DQo+IFlvdSBhcmUgYXdlc29tZSwgdGhhbmsgeW91IQ0KPiAtLQ0KPiBEZWV0LWRvb3QtZG90LCBJ
IGFtIGEgYm90Lg0KPiBodHRwczovL2tvcmcuZG9jcy5rZXJuZWwub3JnL3BhdGNod29yay9wd2Jv
dC5odG1sDQo+IA0KDQpIaSBEYXZpZCwNCkNhbiB5b3UgcGxlYXNlIG1lcmdlIGl0IHRvIGlwcm91
dGUyLW5leHQ/DQpJIHdhbnQgdG8gc2VuZCBwYXRjaC1zZXQgdG8gZXh0ZW5kICJmbHVzaCIgY29t
bWFuZC4NCg0KVGhhbmtzLA0KQW1pdA0KDQo=

