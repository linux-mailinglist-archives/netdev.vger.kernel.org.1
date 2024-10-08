Return-Path: <netdev+bounces-133312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C950B995947
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9381F244EB
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7D0215024;
	Tue,  8 Oct 2024 21:30:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2099.outbound.protection.partner.outlook.cn [139.219.146.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714FC215F41;
	Tue,  8 Oct 2024 21:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728423008; cv=fail; b=somZIy31EID8NHM5RKuFU+usFKc4/ce1kztzIvj1YSbrbTdUEf8vY++89HbKEBXaoM2b6Kr5sfk1gE21HS36yTBinzgfqSShTQtl/Gazd6uVlTjg0TehtTWF40TeYT6U/9bpH+4t84rUVEK3QAuLMF2CAlPXOhtduPXHWJ05DZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728423008; c=relaxed/simple;
	bh=WNA5Vi+Wws8szwYywwSUDVbf+/xf6pyHD5DBb+OG+vY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PgdvURus/HdF2Yz7oL6gMm4JF3OIC9sQ1Fa78wCcPiBwH6fCSOojB3VvZyJchcyD0Tr/hHv25I76ldcoLgV97IOY3BzSo/yRUmjLjSnoIfl+d2Q5r+KAmiE9Dr2JoYs0h9J3TX8vnthwkBoBwCn4GKQbIdamfOB0ZfVUfovFeyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from SHXPR01MB0526.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::11) by BJSPR01MB0516.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:10::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 21:30:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktAyFTVGUaJp6vKc8y66S1E/uyCf8Vxdl8mIRoFKw6U6oQs+g33V6IVY4q1K4EK8sBN6dEjuLyv0fKfQz5nnaAPiaXOQIeeaFgMh7DRGLntbWdpm18DkFGnXHzzsczLcPqiKijBNBy0vzOLrBRReWJA7pWNphgmcfKwahDosHY8TyoJ65aixmFqHMQ1IqV/W/glNa0biE5EDjriZvLqS36MgUeLHeY5Yi0szkIcH6NDLVBDmZ67gD8V9WYdxhxoOCCWLKB/nMxigxGODWlRv/68Go9bhifQ5W5BOtLYiud3vpWB9CZP+O9/ywAsXhtLHFZfIj8ksHCzGMiTbB+GL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNA5Vi+Wws8szwYywwSUDVbf+/xf6pyHD5DBb+OG+vY=;
 b=IGPGznEGy7ZQzxCopqFAblyiKYG7s7RabmxZOZU5qyi+cYKsredwUHnDfn/LviWaixsziKhxEO2Aq+IJZIcy2f/JHBCoTHSfPQ0ImCo/BKQBC4bvku0RMaUZVcoIrj0h+3jy2qy7q/lzM0Deyh1q7eXrimHBGGBE0QSVZ9R/N/csIrCvbOossynOq6k4KQSjxxJpvyIMoc2KHeknKEYc/2W+NVC4/Zy28Cl54hUgSWuIVDY0idAm/9RwFhyBcA9Ye4Y3IqA2x9RVl+dkWe9HcatoiH7hQtnFnQUtrD3E8z5Dd4wTn9dqlTUJkL5NT++uCWhOUTSXLyDJX9P9vWEGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0526.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.31; Tue, 8 Oct
 2024 10:22:54 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.8005.031; Tue, 8 Oct 2024 10:22:54 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Serge Semin <fancer.lancer@gmail.com>, Jakub Kicinski <kuba@kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH net-next v2] net: stmmac: dwmac4: Add ip payload error
 statistics
Thread-Index: AQHbEyg0iEwAqHsLX0OP4iFSwMjpobJzf9+AgABNhwCACORZkA==
Date: Tue, 8 Oct 2024 10:22:53 +0000
Message-ID:
 <SHXPR01MB0863DEE88A17DF86B4657F4EE67E2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
	SHXPR01MB0863:EE_|SHXPR01MB0526:EE_|BJSPR01MB0516:EE_
x-ms-office365-filtering-correlation-id: 400a8f28-37b4-4e60-8e75-08dce7832bb8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|41320700013|7416014|38070700018;
x-microsoft-antispam-message-info:
 rOYPRtdicSIZf8blDsG2hp+L4+o1oDLEEUVFBXeL0noE6zh5PnPMgevXslrciY4zKnA8K8WI+GFCRAEgtRSYPWq/6CR0Z4WThbUxjNn5JAufc8B3tUwuMG9DMOEsB+BiYfXDjHHKuz3G37741ao7VDGmV1fxOYoTCZEaOfDuUKLHTFStJmK6b3kTsA4RyzJ0XaCkiDBrr1o1PYD1HLubXRx40JOHngnYIEFi5zy/YyZCRSXCUpr/PeDmpYPW9/BMraTq8JKeHq/nD03+BbUmlZvyNB0S74w7lNBc9c8PKi+G79J6y/mJF9a/44GOxpeyFayGmqMCGZyp5bmocnu9neZGW9TDWLraqziDJ+uHW4dM8qP+3CocaCL/JQbipZw0Cy7/gdcB2n39UaWeNrYD3CXGgIxoGHZrvM+63MyTrnW+HIAdyVnOiAuovCY1zf9INWoP6frgMkDrUBGN6JE20JT6G8dK4dlIVbGHj43tibakWI405FcB3ZEHkHVmuw0zlEMQgP6T/gKHIMJMfBDugjnvtObJtj/uMZbB/FQmqGW+ppemKQUn0dN0paAQ8ESu5I/iwKojPBM48/ugVd8R8E59gvTQuXmgLygcFXo7Ca8BUOjqnp/Nn5OtBVF9uR2w
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cm5VME9xNVdRdS81VHFoemloejRyWkNIV0lrZC9WdzlmMVhNMUdYMzJGdksx?=
 =?utf-8?B?dkpFMkN2cS9IUGhySmp3cnp2ejlGL1JPTWh2L21VRnR4UjhFdkJLejY3UFZ1?=
 =?utf-8?B?aUZLdjZLMnV2OWhHd3dPdEM3MERic0wveW1xb2REbllhWWJnb1JZcW5VNnhn?=
 =?utf-8?B?ZjUwSnhSUFZzdlM5VGtzRmFmRUcyVi94eGt1bmxQQ0JXZ3JOY2JiMjNoa2RH?=
 =?utf-8?B?SXZOMTNNRUtTMXBycTdJYi8yeDBtdUtWV0laN2JTRTRJek9aWEpEVFUrSll5?=
 =?utf-8?B?TS93NDlHTnhuWFFXelpNSm1mMWdhYWRRNWlVZWhTSFNhTjFWa2EvOEt6NHU0?=
 =?utf-8?B?KzlGUDdTWG1sMXVWUnc0bUhsNkcxVGlZdVFwa2sxZXlDWHl3cmxiNUZxNURw?=
 =?utf-8?B?NVQ2cUpMWitvbzBIdkdVeitUQ0FNS2FrVUV4YTRPYzFyZE9Qb1dINnovZGtW?=
 =?utf-8?B?V0dlN0hCdTRwQ2phSXJvbUwyc2E2bWgwTFBjT1dKUGdQWkpucmFDWGx4aUZ4?=
 =?utf-8?B?bVJybTMyRTRjU3E1L1Fqd0s5UmhIbHo2UStjYzlEOUN3cUFjOGc3VHp0MFhq?=
 =?utf-8?B?ZDNFSVZ0dUtmT1FhMlcvTWZRMWtxOTZIaFVydzlkQzFjRi9MRms1VHRCSHVk?=
 =?utf-8?B?V2JZQm1DaDdOT0svQXRVWFdFMWRDQVEwamsrZThNSHUyRzJGTWxFVW1laDZF?=
 =?utf-8?B?WEhLS3dJSmVMV2ZBRnZ6VzNRRElKWGdDOFBRTTZpaG9ySjlvOERCVjhMTnRl?=
 =?utf-8?B?eFVKMHFQelZBdkQvOUI5YXU0NTRFMEpWakpCampickJsa25hbkk1ekZSUnFJ?=
 =?utf-8?B?dVFNeWhQelJaVGM0UGFVdE5YYm1jM2V0dmlEdWNQRnBoR0NWMXVkR2tocFA0?=
 =?utf-8?B?WnJhVnZFQnZBM29qaG9aUTg4Q1YzTUY0TGJ5Y2JIdGdibWwvaXFXd0tMMWlz?=
 =?utf-8?B?U05rZFBZZm5GRTZXWk9lRDIyaTZXVzhIM1paVUtRRFYxbVNGb0VkaE01VU5h?=
 =?utf-8?B?cVh5NitBREp6UUZaVnNPaThycmpXd3NLb09mUFUxOTk1ZlB2MThPeGs2aXU4?=
 =?utf-8?B?dDN3YmRob0dFRzh0cjlJUUxYRnM3MStxMTRZUlNNMWFtU3gyVE5BcjFOcmFJ?=
 =?utf-8?B?ekR3dEZaWGxvSzZhd1ZINitDL1QzL1BLVE84Nk43RC8vSkJ4SG9mSldlTVBo?=
 =?utf-8?B?QzhBMElPMUdidGp4ZmY2NlRXVC9IV2dHTEppbHFWQlEyQWtQbG9DREh2SUNi?=
 =?utf-8?B?eC85YWhndHR2enFJVzEvMWxUQUwvemExOVoyZ0lpam1nZzZqMlRqL1UxWVBr?=
 =?utf-8?B?MEN2c0swcVJwcFdnT2lhQVBuNmEwYlVYQmdvNWxYTlBmR2hCSEtzcWFZNnoz?=
 =?utf-8?B?UWV1SzVCQXh0MUFRTy9xSy9sem80T1pMN3c0ekFxYzRXRzZidHBqWFZuRWNx?=
 =?utf-8?B?dG5sRHlNdHo1UExRck8vaVRva0FyQmZzSkl1d2VNWENSTDRjdURWWkJEK0w4?=
 =?utf-8?B?bG9TaDNhOG5nbDNzZm5kSzI3S2NRV002VmYzN2QxVmRURmE1aXBvRkhoamtG?=
 =?utf-8?B?ekxUbS9KTVFNbkFqWVZtRHBlcmVaTnNkcWtlWUlNSElsZFJJcmFSZWlQV1pI?=
 =?utf-8?B?MytTeWNlZWtPUDBremo0S3NVMnlmSEoyTHFyeG0rYkFhVCtHVjc2WGhNTkNx?=
 =?utf-8?B?eGdPRFB2WUE1N0M1S0RKb1RySmEzNUJCbnA0b1RKZS9QRmpUOTltbmJZeTBH?=
 =?utf-8?B?R3gxSDVZaFQ3SDdQU3BhcS9TR3BWVjJVOEtvVlFVQ1ZHclF2MTVIVnRCWHpB?=
 =?utf-8?B?dlhBZUpkVlBvVWdYZGNEUVJFKzd4aDM0UTdKWU00dlJEM3hmaCtNWGY0a1hJ?=
 =?utf-8?B?YWI2QTVaUmloSkNvMWxraml6eU9EZUxnZnl3T1NKN2JOdnJrdExVcU14ZUJn?=
 =?utf-8?B?ZzdIQzRVSUhueGorWGNyR2ErcTVMQTQvUUtYK0NaTHIzWmZrT29aV29NTUZn?=
 =?utf-8?B?UThnR29Kd3Y4VkZoRXdRQlYyYlhqTnVUQVhiRytTam02MGlQSGZ4ZmJHU21C?=
 =?utf-8?B?VzNJNGk2MTk0R20xZXQxUk5uZ0IvSUlqUitpSFozc3lSR0JSWEhuZUdtR2lJ?=
 =?utf-8?Q?BEDBzgi/eWr9BREnDKdUC7sp9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 400a8f28-37b4-4e60-8e75-08dce7832bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 10:22:53.9508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SUqyf06oGM3ozxlQVBqV5lia+sXPb3yqaRtMajvikehsOP3MZ7OeUlRXTqz548l9PBhN93ERvifFcJoAmJ5VNq91NtwjcwaUL7pUDFhfgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0526
X-OriginatorOrg: starfivetech.com

DQoNCj4gDQo+IEhpIEpha3ViDQo+IA0KPiBPbiBXZWQsIE9jdCAwMiwgMjAyNCBhdCAwNjo1ODow
MUFNIEdNVCwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+ID4gT24gTW9uLCAzMCBTZXAgMjAyNCAx
OTowMjowNSArMDgwMCBNaW5kYSBDaGVuIHdyb3RlOg0KPiA+ID4gQWRkIGR3bWFjNCBpcCBwYXls
b2FkIGVycm9yIHN0YXRpc3RpY3MsIGFuZCByZW5hbWUgZGlzY3JpcHRlciBiaXQNCj4gPiA+IG1h
Y3JvDQo+ID4NCj4gPiBkZXNjcmlwdG9yDQo+ID4gICAgICAgICBeDQo+ID4NCj4gPiA+IGJlY2F1
c2UgbGF0ZXN0IHZlcnNpb24gZGVzY3JpcHRvciBJUENFIGJpdCBjbGFpbXMgaXAgY2hlY2tzdW0g
ZXJyb3INCj4gPiA+IG9yDQo+ID4gPiBsNCBzZWdtZW50IGxlbmd0aCBlcnJvci4NCj4gPg0KPiAN
Ckkgd2lsbCBtb2RpZnkgdGhpcy4NCg0KPiA+IFdoYXQgaXMgYW4gTDQgc2VnbWVudCBsZW5ndGgg
ZXJyb3Igb24gUng/DQo+ID4gU2VlbXMgdG8gbWUgdGhhdCByZXVzaW5nIGlwX3BheWxvYWRfZXJy
IGhlcmUgd2lsbCBiZSBjb25mdXNpbmcNCj4gDQo+IEZyb20gdGhlIGN1cnJlbnQgImlwX3BheWxv
YWRfZXJyIiBmaWVsZCBzZW1hbnRpY3MsIE1pbmRhIGlzIGNvcnJlY3QgdG8gdXNlIGl0IGZvcg0K
PiB0aGUgUnggSVAtcGF5bG9hZCBlcnJvciBzdGF0aXN0aWNzLiBIZXJlIGlzIHRoZSBkZWZpbml0
aW9uIG9mIHRoZSBJUENFIGZsYWcgKHBhcnQgb2YNCj4gdGhlIFJERVM0IGRlc2NyaXB0b3IgZmll
bGQpIGNpdGVkIGZyb20gdGhlIFN5bm9wc3lzIERXIFFvUyBFdGggdjUgSFctbWFudWFsOg0KPiAN
Cj4gQml0ICBOYW1lICBEZXNjcmlwdGlvbg0KPiAgNyAgIElQQ0UgIElQIFBheWxvYWQgRXJyb3IN
Cj4gICAgICAgICAgICBXaGVuIHRoaXMgYml0IGlzIHNldCwgaXQgaW5kaWNhdGVzIGVpdGhlciBv
ZiB0aGUgZm9sbG93aW5nOg0KPiAgICAgICAgICAgIOKWoCBUaGUgMTYtYml0IElQIHBheWxvYWQg
Y2hlY2tzdW0gKHRoYXQgaXMsIHRoZSBUQ1AsIFVEUCwgb3IgSUNNUA0KPiBjaGVja3N1bSkgY2Fs
Y3VsYXRlZCBieSB0aGUNCj4gICAgICAgICAgICAgIE1BQyBkb2VzIG5vdCBtYXRjaCB0aGUgY29y
cmVzcG9uZGluZyBjaGVja3N1bSBmaWVsZCBpbiB0aGUNCj4gcmVjZWl2ZWQgc2VnbWVudC4NCj4g
ICAgICAgICAgICDilqAgVGhlIFRDUCwgVURQLCBvciBJQ01QIHNlZ21lbnQgbGVuZ3RoIGRvZXMg
bm90IG1hdGNoIHRoZQ0KPiBwYXlsb2FkIGxlbmd0aCB2YWx1ZSBpbiB0aGUgSVAgSGVhZGVyDQo+
ICAgICAgICAgICAgICBmaWVsZC4NCj4gICAgICAgICAgICDilqAgVGhlIFRDUCwgVURQLCBvciBJ
Q01QIHNlZ21lbnQgbGVuZ3RoIGlzIGxlc3MgdGhhbiBtaW5pbXVtDQo+IGFsbG93ZWQgc2VnbWVu
dCBsZW5ndGggZm9yIFRDUCwNCj4gICAgICAgICAgICAgIFVEUCwgb3IgSUNNUC4NCj4gDQogVGhh
bmtzIGZvciBhZGRpbmcgZGVzY3JpcHRpb24uLiBJIHdpbGwgYWRkIHRoZSB0aGlzIHRvIGNvbW1p
dCBtZXNzYWdlLg0KDQoNCg==

