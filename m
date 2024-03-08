Return-Path: <netdev+bounces-78624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E785F875EA3
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AF43B22C85
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DA24F1FB;
	Fri,  8 Mar 2024 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="l9WWM2mf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8234EB49
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883444; cv=fail; b=QksqI4rtLAI3JoHZE9XcefavAAlARBT0c84Zwulr3FS7tdhNZl8v9UhFvto/Ym5gyBBCSPsKedch0eBFbDelXY1vRIHxTvpv71X8M4Nxusyd0CRk0Yz8Km/Db0ARssFz9DKOcEx6M2QlqG5KrDbMEVbZ7Xp3CnpxLnjenJOT/os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883444; c=relaxed/simple;
	bh=WDfvPg/4Vo9oZpYC4DFa/NFcrcfbK7GIQthKFdZ2EYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H32y9DcBqnarDIaLrbe0PGfRylxa237i2M9M5fNpiS25ec5V3M3GNM7wqFsmFmOfAYGowinNZOTYVZiwwwkwMjrtDf0lAzlZx4rrZ7fMtBdj++mCHDPNsO3QiZkVLq2r8FehN2qAfr0VgBj6LNaTeugiqFkLXuZu9j9+psBE2Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=l9WWM2mf; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427JDmU0022740;
	Thu, 7 Mar 2024 23:37:06 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wqkj61x6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 23:37:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I34jEKVq+jJ71ihmP7niQWDecxXujrV/K6s/sO1UrUy/S49ETMVlkpFvUUNnhSznG2CFbOW/Dr633Lfw+XxxqE3WvhlBUa4b0A0wCWhAXfsCbaI02m32Av/Ma69nJhE+NZ708xPJYuyT7gw7zh1jOCGIHtCwGMYr16T75RA5vZ/1o0oaGDbiQNdfPGqB+oLcNWsOB8QYXNBe/cUwyAdl1NMnyLVD3ThVEMXE4+tpfJQ0cHyK8te1JR0IM9TlLwYARKX3mhg9DhE5rPFYUy4UZJeHGrt5saNcMfLjyg9LYbjBwnnPtm2By7PasCZohldMdYNxMgmYaN4QDOgeP/HN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDfvPg/4Vo9oZpYC4DFa/NFcrcfbK7GIQthKFdZ2EYE=;
 b=gTqDk79N8miaug8WKKMrp0ffr+CQ2fU9/1lV/fcNDHNTKNq1kLbuZPg+bDnQRAze+PKcxBNUjlPkXvxw7ucE9ZEHF7s8WKrML/WOLLQ26zKwr9A8M12ohOkWQXoeaJdh64OSjOyu66bRL610yIoPxHCYcg+AD+L3ttyj6ManXgSFX2LhvpIByy4889BVtgrigXApSeDiFbU7QFrexAMbZhP/uVbsBdGTwrnDt4tj9+9qeIBoCY5IV1y3lJD6MMJTG9y23Nkr1YOSENCT/EzD17YWaC25jK9BcntZIJZJ1t769su3uWZBRv662Or5bH0gKdJGRs+XM1/I4cyQm9/wdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDfvPg/4Vo9oZpYC4DFa/NFcrcfbK7GIQthKFdZ2EYE=;
 b=l9WWM2mf5pkFpdkZ93BgkYgZXD0eSkfE+8nuF+a1fSOc/gYc/ypPLIaRqoAUUkFzQ3BQU46N5GKD5jWegzgKCknqduEQ2twUuF9CM67rmzoROXF+68KPzB5ewgTNfKD9J1CzE+Q2oo7WUp5VttGyQ+srLuYWuyKekMoCczJReEk=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by PH0PR18MB4972.namprd18.prod.outlook.com (2603:10b6:510:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 07:37:03 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::d8da:f765:b92b:b3a7]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::d8da:f765:b92b:b3a7%3]) with mapi id 15.20.7362.028; Fri, 8 Mar 2024
 07:37:03 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
        Realtek linux nic maintainers
	<nic_swsd@realtek.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net-next] r8169: switch to new function
 phy_support_eee
Thread-Topic: [EXTERNAL] [PATCH net-next] r8169: switch to new function
 phy_support_eee
Thread-Index: AQHacNW5CaTHRn67zEGYHi10R2x4WrEtdC8g
Date: Fri, 8 Mar 2024 07:37:02 +0000
Message-ID: 
 <SJ0PR18MB52166D474EE78BC4E7B6B3E9DB272@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <92462328-5c9b-4d82-9ce4-ea974cda4900@gmail.com>
In-Reply-To: <92462328-5c9b-4d82-9ce4-ea974cda4900@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|PH0PR18MB4972:EE_
x-ms-office365-filtering-correlation-id: e89c05ec-b7dd-4de2-2e83-08dc3f428bf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NSc+88OjltSqAfgY3lLNmSJVRlnGeu7SDWoETUT7l7P4ZfueNpM+aQROUCnvup2kDeWkF/P87azSuHVyH0NXvMoBXg6D9ssnHUXK6d27HE+9n7uq5cZov2Izb8fTgGFB4JAyEHUXXzJh7qHzxCVlZuGmqJN3M0X+1XA260lC8JYprc11dTOQ5Tl9R5UgacR/A0XY73nMrSFU6fjm/pF4iIicZQ2LdcTDNxX90hmgI3OmmUwJYWZv8zhIuHtJnTyJNTHX+4O0yeCE22g3VJDx6k/tgYUFH2fALw2I9WU1wn1nR6shvXgrGr0H39ZAriJ7mzqy0y+fsfJFbpSTK08BePJ9GwZxkdCG5bUVYs3OSrb3TaRzGvSys+bDu1myvWKgAEGlG4EVoL7+GABkt5YdUNN1aU/ZLO44DHKCYuiLW6hI3GmAeDetB9OJfys4d0bWa8CMYjQ4KTRsTcsdFPwSkFMrDhRA9wnAyb1dipMHq9B4SQtbbhofrwI79EG7s1UX8Ffyr86PJV4dRGHsRpKZgIRqWzOWgdXw1r+oIETr2QTTSrQJg1FBQRRQ/ncVoJzGPS+qgIMF9Fi8I3zbFjHocFOsNKZ20XBSYRkmq9zgCZP8Ob9Cvzgdddlaob4uRfdM+9P1EcH50/eUxmRjLmfxqEaxFIQhNl2hCGPXM8db19XeokWQGc7Eyz5Pa/xfuVzzG26YyyinFA9S+ff/u4pDSybXeFutGJok2dI+cbKbVdA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Zml1TDg2Wm5QRzBhZXliekpuZnU4T3NGWTRpSlJkRG95RThxcDVYWkFQZEZQ?=
 =?utf-8?B?NG9SbHhMV0lqMndZdkpnRlhxTThFZWZteFY4RVFodEVaSlZkSS9ORkVvK01j?=
 =?utf-8?B?NW1iQjdPaHZ4K3ZWLysyWmNEeDNHVTI4Rm1Wc3dLSW9jSUhNQnd3QTNEKzFG?=
 =?utf-8?B?WVlURThCNXZ5amo5c1hlU1B6T0VoRGFPdE9ETmVwa0hYY29uUWhER2ZSNlEr?=
 =?utf-8?B?a3VCOU1EZ0IzUVpaYUk1R0JHRnFKd3VsaDEySjZoU2M5TE9qNkhMZy9vaFY5?=
 =?utf-8?B?cXhDdVEzbGhpNGlIWHVLWm5ZcHVWazh4Mkd2alcwdFN4emlUazQzY2J5UVhR?=
 =?utf-8?B?em16VFRyS3JxWEk4Sm95OWYvU0ZVa1UrazArdUlEa2ZMWWx2TzNQOCs2Sm1P?=
 =?utf-8?B?T2szazlOTTZGakEwZkVaSjNVaHJQQTFjZUFsUnZjdlZRNGs2d1ZRbWRpeU9L?=
 =?utf-8?B?bzJkQVZRVGFaaFNqNGE4c3NHUWNSWEs0aXVxQTFERHBrSUovMng2UzJkRHlp?=
 =?utf-8?B?c0U3Z1dIOGEzTk1DV0pJSTFEaEhpSzZIa0dBellKdm84YWg1aW1VK0RvTFB4?=
 =?utf-8?B?b2o1c2JjMkJId09OVjBjbkRIM1RTK2x0OFdwQVI4TGtTcUNBeFRVZG9uTW9R?=
 =?utf-8?B?ajZZTFJBNGM2WEtFUnpZNlRDSm9HS3BxbWdNUUVKMitUczdDTStCelllV3ZC?=
 =?utf-8?B?aDlwcHEwNUF1MDdWQ25tNDMvdjJYbTl3UEdZbUJwUUJRY1AyUTZIUk9LZnJw?=
 =?utf-8?B?ajlTN0RrOFNqcVFYU0kyRTFTdnhTM3U0d3lYa0NGQlJVU2RiM0crRVpscCt0?=
 =?utf-8?B?UzhoKzdwcllKLy9FVEZHb1grK2VOZXY0S2xNaERraFpQeXJ3MDZ2SmVOdzRy?=
 =?utf-8?B?WlBQVFZzVmVqQXJCRExDZy9TRVNuT05taVQzUVkzMWRGUG5XOWt2T0ZENERi?=
 =?utf-8?B?VWduNU52L3QyUWorRjE0K1dTeC8zQXprWTVlL2N2UE5ZZndTamo0SDR5NEQx?=
 =?utf-8?B?NEJBYWowNzJkdXlJbmovWGFpSmhUdXljNXpFc2Q5VVg3b0NnRkZ4UmxRS3Qy?=
 =?utf-8?B?bXZvOHc3M3hydHhSR25ZcnRqbktsWnFKeEJnT1kxS2VOM1U2NGZxSW1JOGJy?=
 =?utf-8?B?bmZqS1lGdzlSdTd3dWkyZmJ4KzE0ZHJOQWV0M0FkdTRqcU43QUFNUDZaMW16?=
 =?utf-8?B?b1R5RVdtTFlCdWpuT1J1YXRsQXlyTzhjbHFoTWN5SXVaMEUySVhtdTFURmhH?=
 =?utf-8?B?Y2JnWmpoeEdlYXJubUlrVk55QXZidld3MEtURjJtMWNNZ0swajd2dVBIa2Za?=
 =?utf-8?B?eEdyZ1ZBNTNKdnpFWkptb0JpQlBYRWlQOFlERklCcVpKWlBVZFZRZVl2Rlpw?=
 =?utf-8?B?OXdCRVVFNXVVTXNSckNoVGFVSTNhR2RHYktEN3VuWEd3NEc2bVNQMm9RaEJ3?=
 =?utf-8?B?VWd1UVpXTzFScm01VE5vSzE5MlBYK0V4T2I0TVFCSVluWWpHMU1hdTdhek9R?=
 =?utf-8?B?ZVF5R2RIaEZEbmplcktFb2ZkalpPZWxOSjJyam9iRStZQWlkMzdJbWwrU2Rt?=
 =?utf-8?B?SE5xcFdxTElZcnlWVGdWR2Y0b21LOEFQYVpBUURCVklHanptWThJTkZRKzNY?=
 =?utf-8?B?QjZ1OEM5ZllVSThNKzFSb01JM1NjbFJDZ3RIclEyWVpWUHZQMVFyb2Jrd0k0?=
 =?utf-8?B?OHIxZFVzTmxMcjdiTWJvbmZOaVBpM0l3QU0xbDdsclZwOFR1NVdRMEk0VE1O?=
 =?utf-8?B?MVpJZGVXUmJMZXNjZTRRUDJkaW5FQWYzQUcvTVNrM1lnK0I4bXpmU0gwZjIv?=
 =?utf-8?B?ODI0YlZ1OVNkMUR5Z25uNjJoZDNGcFV5R1Z0eE5Wcmd1bkJCWWhFQU5aZ29i?=
 =?utf-8?B?MStLS0d5cXlzZENUY2FXRWxUWmZGemU5cWFXSjJzR0x2RmFsbDVmNG5xVndU?=
 =?utf-8?B?VFJnZVNOTjJPNVF5bTJYanZncjBPd2ZCM0VoWVpxTi9wbFplVnZpOUpQVXhU?=
 =?utf-8?B?QXNkVjBQaXZDcFpoQTNLNWpMVmk3cTRjYkNpVTlzdmNiTlhJVUJYQ2xsbnQ2?=
 =?utf-8?B?bVJRME9oSDcyK2hYMVhSaTRzMmlQRnZxRzFJQXV5RUZZVEZVSGQ1NHBxM3VT?=
 =?utf-8?Q?9zqOG1n2y2WrcXfrvTvF875PB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89c05ec-b7dd-4de2-2e83-08dc3f428bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:37:02.7697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zr7hDN5njQdSolKpQqH7Fw2QAiu9F1YB+oGnYN9CNxUP01Bo1sVOnTO2XeO4xrjtjlunWSpM9CuMFy96XYb5YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4972
X-Proofpoint-GUID: _31dCu-BWXi7hQFQKlYyTrbt6u3OkT-u
X-Proofpoint-ORIG-GUID: _31dCu-BWXi7hQFQKlYyTrbt6u3OkT-u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_06,2024-03-06_01,2023-05-22_02

SGkgSGVpbmVyLA0KDQpUbyBtZSBpdCBsb29rcyBsaWtlIGJvdGggcGF0Y2hlcywgDQpyODE2OTog
c3dpdGNoIHRvIG5ldyBmdW5jdGlvbiBwaHlfc3VwcG9ydF9lZWUgYW5kIG5ldDogcGh5OiBzaW1w
bGlmeSBhIGNoZWNrIGluIHBoeV9jaGVja19saW5rX3N0YXR1cyBpcyByZWxhdGVkIGFuZCBjYW4g
YmUgcHVzaGVkIGFzIGEgc2VyaWVzLiBUaGlzIHdpbGwgbWFrZSBjaGFuZ2UgbW9yZSBoYXJtb25p
Yy4gQmVjYXVzZSwgeW91IGFyZSBtb3Zpbmcgc2V0dGluZyBvZiBlbmFibGVfdHhfbHBpIGluIG9u
ZSBwYXRjaCBhbmQgcmVtb3ZpbmcgZnJvbSB0aGUgb3RoZXIgb25lLg0KDQpSZWdhcmRzLA0KU3Vt
YW4NCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSGVpbmVyIEthbGx3ZWl0
IDxoa2FsbHdlaXQxQGdtYWlsLmNvbT4NCj5TZW50OiBGcmlkYXksIE1hcmNoIDgsIDIwMjQgMjo1
MyBBTQ0KPlRvOiBSZWFsdGVrIGxpbnV4IG5pYyBtYWludGFpbmVycyA8bmljX3N3c2RAcmVhbHRl
ay5jb20+OyBQYW9sbyBBYmVuaQ0KPjxwYWJlbmlAcmVkaGF0LmNvbT47IEpha3ViIEtpY2luc2tp
IDxrdWJhQGtlcm5lbC5vcmc+OyBEYXZpZCBNaWxsZXINCj48ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47
IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCj5DYzogbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZw0KPlN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIG5ldC1uZXh0XSByODE2OTogc3dp
dGNoIHRvIG5ldyBmdW5jdGlvbg0KPnBoeV9zdXBwb3J0X2VlZQ0KPlN3aXRjaCB0byBuZXcgZnVu
Y3Rpb24gcGh5X3N1cHBvcnRfZWVlLiBUaGlzIGFsbG93cyB0byBzaW1wbGlmeSB0aGUgY29kZQ0K
PmJlY2F1c2UgZGF0YS0+dHhfbHBpX2VuYWJsZWQgaXMgbm93IHBvcHVsYXRlZCBieSBwaHlfZXRo
dG9vbF9nZXRfZWVlKCkuDQo+DQo+U2lnbmVkLW9mZi1ieTogSGVpbmVyIEthbGx3ZWl0IDxoa2Fs
bHdlaXQxQGdtYWlsLmNvbT4NCj4tLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9y
ODE2OV9tYWluLmMgfCAzICstLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIg
ZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0
ZWsvcjgxNjlfbWFpbi5jDQo+Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21h
aW4uYw0KPmluZGV4IDBkMmNiYjMyYy4uNWM4NzlhNWM4IDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+KysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj5AQCAtMjA3OSw3ICsyMDc5LDYgQEAgc3RhdGlj
IGludCBydGw4MTY5X2dldF9lZWUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwNCj5zdHJ1Y3QgZXRo
dG9vbF9rZWVlICpkYXRhKQ0KPiAJCXJldHVybiByZXQ7DQo+DQo+IAlkYXRhLT50eF9scGlfdGlt
ZXIgPSByODE2OV9nZXRfdHhfbHBpX3RpbWVyX3VzKHRwKTsNCj4tCWRhdGEtPnR4X2xwaV9lbmFi
bGVkID0gZGF0YS0+dHhfbHBpX3RpbWVyID8gZGF0YS0+ZWVlX2VuYWJsZWQgOg0KPmZhbHNlOw0K
Pg0KPiAJcmV0dXJuIDA7DQo+IH0NCj5AQCAtNTE3NCw3ICs1MTczLDcgQEAgc3RhdGljIGludCBy
ODE2OV9tZGlvX3JlZ2lzdGVyKHN0cnVjdA0KPnJ0bDgxNjlfcHJpdmF0ZSAqdHApDQo+DQo+IAl0
cC0+cGh5ZGV2LT5tYWNfbWFuYWdlZF9wbSA9IHRydWU7DQo+IAlpZiAocnRsX3N1cHBvcnRzX2Vl
ZSh0cCkpDQo+LQkJcGh5X2FkdmVydGlzZV9lZWVfYWxsKHRwLT5waHlkZXYpOw0KPisJCXBoeV9z
dXBwb3J0X2VlZSh0cC0+cGh5ZGV2KTsNCj4gCXBoeV9zdXBwb3J0X2FzeW1fcGF1c2UodHAtPnBo
eWRldik7DQo+DQo+IAkvKiBQSFkgd2lsbCBiZSB3b2tlbiB1cCBpbiBydGxfb3BlbigpICovDQo+
LS0NCj4yLjQ0LjANCj4NCg0K

