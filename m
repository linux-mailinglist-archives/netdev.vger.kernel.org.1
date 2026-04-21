Return-Path: <netdev+bounces-280007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PAYHn4G52nT2wEAu9opvQ
	(envelope-from <netdev+bounces-280007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:09:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E77436596
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 511B8301681A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 05:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909F119E992;
	Tue, 21 Apr 2026 05:03:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2109.outbound.protection.partner.outlook.cn [139.219.146.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01784039;
	Tue, 21 Apr 2026 05:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776747782; cv=fail; b=DLYIglEudTKt7JHQ0XemWXRmHPgDyGNzNwulekUzoBA9GILN58ca37o8Sr3WfGEBkTsSMptYA2RWnJw3C73nQvlIwrTGRlnna3ZsAqDbFVzLHnIHtASmVoUoxuhfLtxjGEf9i42Fos8GGqJ/ePzmHdD8toXl6sJrBkuYeJbD8Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776747782; c=relaxed/simple;
	bh=Zu4rf9iErfXUTPnbkhk0bLu2bnuCORTTuHAok7jqTXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EaZ2XECD9HRaUQlJM/Npbh+8TR8xIZyHOF5pwmIJeYShWkp28OwQ3YHAwPIoh/8s4EIj3K1Ijvm+Q8VwNf/d0xcboy3kdiK5mwpbVH+UCef66wOSW3QkOtL6YnMnBJSMneD5no+v5IlljunVj3Vb2aV7LR7uZnekN+6DvDc1PVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsB7lln57Iu+bBBsHBI2zTX2CwkZsAgkcAvoJgDk9JKAheE3GcbUvHgOXHIhsd1nNnN2TTHyhZYV7f/D+z3dr1Uy8SM1D59dgsdE9k645hbOKp8JVUkm9tGB45z9F0fN/VyqiR4B2+PkVZt9tgZSA+kZeMrHb8UbTUu5fu8unz3Z+KUKUIfwkLXnQLU+y54prTS5numU4EB9Lg66vrjPrb24tOyzrwogZPHwG6TPv/PNYZtWvGm1dgbIl23tz717FNy0LIuehYL8lFAnUt6kPe05kWAsL/5mBPI1AidMn8LuN3D7uWOztIVB4X6O7w58fDQt+hvCLsOFfSqZuZ70eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zu4rf9iErfXUTPnbkhk0bLu2bnuCORTTuHAok7jqTXc=;
 b=PoE9OnxVIuxG/scRdZ4NFkyPCwEJ1fB6xJS7bPWr5GMTCEfuAMlKD/3N/rzX/Snp6v3au4g53asDAmGnj3TGLZLUNtZzwtBapgO+bqehqSZHhzQXPSaeFp2exlxHt29wGR/bmzi611FhJ8hb6eP56dXD1mRJZ3SKy4AfpWxERM9YiJGfavViaQWKadPYQN6Sk+EJYnEKIlKlIoC32rJW1sVUCqL6AaCJzByG4gyTYKwBgoLPSHwv12EY8Yd97idK4RTQ1DZ04iUu2qabNpzxEry4RuThhiBztPChQr3IrnwbhUQ5yIANN7Hr1IbbXEiyB+SjmEHO00Tt3vBfD+YCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0760.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Tue, 21 Apr
 2026 03:30:40 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9769.046; Tue, 21 Apr 2026 03:30:39 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [net-next v2 2/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 JHB100 support
Thread-Topic: [net-next v2 2/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 JHB100 support
Thread-Index: AQHczhRDrTa9KD3ikECgLqCpAIFxfLXoGfAAgADIWXA=
Date: Tue, 21 Apr 2026 03:30:39 +0000
Message-ID:
 <BJXPR01MB08555231BFE4AB38415CDEE8E62C2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20260417024523.107786-1-minda.chen@starfivetech.com>
 <20260417024523.107786-3-minda.chen@starfivetech.com>
 <20260420-messy-elite-panther-a7ffbc@quoll>
In-Reply-To: <20260420-messy-elite-panther-a7ffbc@quoll>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0760:EE_
x-ms-office365-filtering-correlation-id: ff97e938-2239-48a6-c8ac-08de9f565c63
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 0n49nmay0DgNEKAEQGgCBG2H/JeMv6DVoGzls+lG1zAQIuov+gIyaUdQunYFDnpBx1RglhIjKLRcHQ6fYhsagUbx6YH5uhhhqpDLt2eciWiPqMiuqHwVSDmrK6jiT72PMu4vntpADpdxP3oBDZpSnPJEWUiyrd8KhXqzH/nuZgJb4ULoDGvIlLLFf7NjZKKHKY8+LUSoHH7Q9WOWyOpEvBDtcANd1vqu0WohTTASfK+Uoejpogs0Hj+uC/OlJAHJiUfXyMP5i78fMc1MNgCPR2AL9iKHpADe6RfPv09OmVLXKWZqJpAId2sBOf5cKF7r6TeE4/3rfg2eTzqD3Z2d2/C1moKF5Xv2YbIQLcYRl2dKGSAuoCDXajNzeuX97UKmrshoSZqBNBsf6sO8Xw98uFaXWVs4RDpdAt2BOMuEILl+ZC+XwnwwLe0r4y4fEJ5OKKa9gvvtkqn0NSVO2I62aqQeHvzfxpFuWWbzDbc4NqP04971DvtFp+vV2SQ5oCxlGMLW+jN+iWChH+uBKdjwNyNWCrHCYFW3wgxyDi3/wjpLSY+Cwmphvong50V62yScMyL6PW7N7Ap1SquiNbxk7y6mwL6z6+gbWEmZNYjeh9Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHhudEphN2IxdDZtMTVlalJheDRpQUxRVzVwWm5MRVhXS1Nwa29MblRtc0Fi?=
 =?utf-8?B?QTRHUUErUCtBZktsOU1FSlY4MkIyUEUrOFpYVTVBcTFaZDNVbk4rM1VBREdi?=
 =?utf-8?B?NGF4T2lndW5COW9qNjBncHM5d09qc3EybVJRazJKc0RuRFo2N1NiR3lnSkFZ?=
 =?utf-8?B?aFJkaXhLVmxBTEI0dG5xaWxRaWRUbUI4UkFDT1hWS3hSeHcvLy9yNG8xQlJY?=
 =?utf-8?B?ODZGVFZXSWd3V1BqYjFkN0tSZVhJS3orTi9kZjdWanNXQXpWMVVmc3gyTkx5?=
 =?utf-8?B?MHNOQmwwL2pYemhjUlhqV1VpNVlMRENIdE1tZWo4YnZMZitLeU1pcWxwenhH?=
 =?utf-8?B?bCtOT3MwakNDelNmSWt4NkNKS253eWZ6ZGs3RGNqL0NPSWVCcU1YK1dyZ0Vr?=
 =?utf-8?B?VFp5M3g2NlNFR2lSNXByQ2RaTzdYVlY3dzkrQ040Ri8yK25JN2tDY3VPZ3dV?=
 =?utf-8?B?Qmp6WnR6S1BDaE4wNXpkOTFqOHplWFJWQXVLbkJxZUNZOHN5S01wbENYWWJs?=
 =?utf-8?B?amVxNDQvc3loekNjUkNvRENzQ0N5c0dSOGhDdXVZSlF2S0hCNHFTbVdQbXl0?=
 =?utf-8?B?TlBoSVhrc1pTN0lLdzFIeXlxQkJkNTBTMG1leW9ZNWVzTzBiMEJ4NXVtZy8r?=
 =?utf-8?B?Um5YTW1WVFRoMm83NlJSVUVyNzdHdTZEM3duVzI5MiszdHNNSEZ2V3ZHUFFP?=
 =?utf-8?B?bWVKb04yT2FxSUZVYlR3dHpQcStaNGRhTnJPYktKS21aWG1BR0pUYjFreWZ5?=
 =?utf-8?B?VlhaTzVZVUZOWUU2OEYvTVRiRFJ4elZEQzBmRy81UlFDL3B5ZFhLN2xjdm5h?=
 =?utf-8?B?bEdOZFA2TjdudWRXak0wWXJoTk5pZVFMS1YzWGhYZm1wTThTYWphZVRhQXlN?=
 =?utf-8?B?L2hRd2JaOWJVZm5RK0tPdDNyTjU2dmora2kvV2ZIUTR0dUtlbzJtcStPNE1F?=
 =?utf-8?B?c1M3S1cwRGtpeDBkSHFhMDcyS09kN3doMDRxazUxSWpBWDZLWmxKbnN6Zkdv?=
 =?utf-8?B?T2FWWDNWeC9XZXVYT0IxK0I0cEphaXZRS2RZTTVlU2syMzdvcXN6djVIRFpT?=
 =?utf-8?B?N3BIVGtoZDdJcVV5YzVkRXJqak9JVkxUOXhibEtuNGxxbStJWkFQeWc4SDBF?=
 =?utf-8?B?dnFFTjl3Uno5a2hPZWI5ZjBvWFdacFZaMkJsNllKSll5WUZvb1E2SjBDR09x?=
 =?utf-8?B?Z0s0clpGNlMya09VSmU1dnhabjV5VFA3bnVVQ0c2d25SVDkwQXVRanZXeERw?=
 =?utf-8?B?YzJDZHQvWkVxbmc3TVV5dkliZ0NJTVpHTWhWSzRtL0RiOGFHTmRjZmg0QzNK?=
 =?utf-8?B?RXRJNWpKRXVZMmZFU0Nza1U4eVF0TjBNcUNob01yZExBRE5FcGpwNUhtekFq?=
 =?utf-8?B?T1BxcUpkR0gyQkhnMEJRTXRUNkoxbTFJTC82Tzd2ajV1dWVjMHN1b3c4UlJy?=
 =?utf-8?B?TU12SDlNazNpa0pYa2F5NjRYK2owT214TXRWeHlFUUlONGNDdDlHbFlKUWo2?=
 =?utf-8?B?azV2emJneVRYQzliK0hvS2kxU0RaU1d4Y1FyODZpbG1JVlRiTGNrdGFXMUR4?=
 =?utf-8?B?cU9IMEwzZVVZOWY3cnBtVHBsaHpubmVtTGZkU2hhRDB3S1hXL1U4cmMxcGc2?=
 =?utf-8?B?K1lkMFlEZmwrL0g0VUV5UW5DcjFJQ2k5Q3ZBMU5SbGhKS1hpUUFjM24zZ2FQ?=
 =?utf-8?B?N21JeDRYdzh3bm1FbzRIcWN5ZTdnVUZrTk5wVVZpN1hkWmswSjBtc1dZQkNQ?=
 =?utf-8?B?S3NXa2pBZnhoT2RDaTRSeEgwczUxYTY0NjBRdDQxRW8xaE1UTDdOaVFoeDVW?=
 =?utf-8?B?L1RnVWt1NGZDa20zcldJNmxNN2hOTzFFTjJzVGNJeDZib2pnVHdOU0s1S1Nk?=
 =?utf-8?B?WUEyYVNLbWxLT1Evd2xnUFo4UFluU3hJYUw2TkhNRkw1ZkduSHhZNXpERE04?=
 =?utf-8?B?OGZ4SjNpa244NHNFMTkrREF0Yzh3ZjBWRk94R1V4bXE3NUZyUWlTdzhxYXM1?=
 =?utf-8?B?U1F5QVQ4WDVSWjA2d0gwNkl0YlVyNDBFTjJzSXZrWEY2ZkZRc1VNcW8yd2g2?=
 =?utf-8?B?QkFvZWllbzdaNlpKOU9sR1BNUVo5dzFFLzk2Qk1IMjZPWXdDcU9oU2dsNXR6?=
 =?utf-8?B?R05hZFRMbTdPSHZxSWxDcis5S2FIdDFpNWNLMFdJWW02ZDE5WWJkb2FOZGxa?=
 =?utf-8?B?V2hSUWRlU1NVVmRza2JselBXSkcrSkNaMG5zMG1uVEFBVGlwOFo1RDU5bklN?=
 =?utf-8?B?ZHQxZWY0MnhVVUVrTWk0NW5GWHdqSE5yS3oweGhWV2ZnVFZQcTBkKyt1Z0tZ?=
 =?utf-8?B?VVJFL2NrVHZLOXNPWkFSeHZYMnFQaE5qYWp1U3pqREdzUlozL3FaQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: ff97e938-2239-48a6-c8ac-08de9f565c63
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 03:30:39.8820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ts0Rp/27/yAYNjTE1x/jTEByfPurzyNACVpOX29KFsiw/FHUgq092MTztQI+labzuo4GvjrK01AxkJl2B3UQpb11N9gwpK2XLuqhv5iDWpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0760
X-Spamd-Result: default: False [4.64 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-280007-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.798];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,11b80000:email]
X-Rspamd-Queue-Id: E3E77436596
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gDQo+IE9uIEZyaSwgQXByIDE3LCAyMDI2IGF0IDEwOjQ1OjIwQU0gKzA4MDAsIE1pbmRh
IENoZW4gd3JvdGU6DQo+ID4gQWRkIFN0YXJGaXZlIEpIQjEwMCBkd21hYyBzdXBwb3J0IGFuZCBj
b21wYXRpYmxlLg0KPiA+IFRoZSBKSEIxMDAgZHdtYWMgc2hhcmVzIHRoZSBzYW1lIGRyaXZlciBj
b2RlIGFzIHRoZSBKSDcxMTAgZHdtYWMsDQo+IA0KPiBQbGVhc2UgZGVzY3JpYmUgdGhlIGhhcmR3
YXJlIG9yIHByb2dyYW1taW5nIGludGVyZmFjZSwgbm90IGRyaXZlciBjb2RlLg0KPiANCj4gPiB3
aGljaCBjb250YWlucyAyIFNHTUlJIGludGVyZmFjZXMsIDEgUkdNSUkvUk1JSSBpbnRlcmZhY2Ug
YW5kDQo+ID4gMSBSTUlJIGludGVyZmFjZS4NCj4gPiBKSEIxMDAgZHdtYWMgaGFzIG9ubHkgb25l
IHJlc2V0IHNpZ25hbCBhbmQgb25lIG1haW4gaW50ZXJydXB0IGxpbmUuDQo+IA0KPiANCj4gRHJv
cCBhbGwgYmVsb3csIG5vdCByZWxldmFudC4NCj4gDQo+ID4NCj4gPiBQbGVhc2UgcmVmZXIgdG8g
YmVsb3c6DQo+ID4NCj4gPiBKSEIxMDA6IHJlc2V0LW5hbWVzID0gInN0bW1hY2V0aCI7DQo+ID4N
Cj4gPiBFeGFtcGxlIHVzYWdlIG9mIEpIQjEwMCBpbiB0aGUgZGV2aWNlIHRyZWU6DQo+ID4NCj4g
PiBnbWFjMDogZXRoZXJuZXRAMTFiODAwMDAgew0KPiA+ICAgICAgICAgY29tcGF0aWJsZSA9ICJz
dGFyZml2ZSxqaGIxMDAtZHdtYWMiLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICJzbnBzLGR3
bWFjLTUuMjAiOw0KPiA+ICAgICAgICAgaW50ZXJydXB0cyA9IDwyMjU+Ow0KPiA+ICAgICAgICAg
aW50ZXJydXB0LW5hbWVzID0gIm1hY2lycSI7DQo+ID4gICAgICAgICAuLi4NCj4gPiB9Ow0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogTWluZGEgQ2hlbiA8bWluZGEuY2hlbkBzdGFyZml2ZXRlY2gu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvc25wcyxkd21h
Yy55YW1sICAgfCAgMSArDQo+ID4gIC4uLi9iaW5kaW5ncy9uZXQvc3RhcmZpdmUsamg3MTEwLWR3
bWFjLnlhbWwgICB8IDIzICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAyNCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9zbnBzLGR3bWFjLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvc25wcyxkd21hYy55YW1sDQo+ID4gaW5kZXggMzhi
YzM0ZGM0ZjA5Li44NWNkMzI1MmU4YjEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9zbnBzLGR3bWFjLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3NucHMsZHdtYWMueWFtbA0KPiA+IEBAIC0x
MTUsNiArMTE1LDcgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgICAtIHNvcGhnbyxzZzIwNDQt
ZHdtYWMNCj4gPiAgICAgICAgICAtIHN0YXJmaXZlLGpoNzEwMC1kd21hYw0KPiA+ICAgICAgICAg
IC0gc3RhcmZpdmUsamg3MTEwLWR3bWFjDQo+ID4gKyAgICAgICAgLSBzdGFyZml2ZSxqaGIxMDAt
ZHdtYWMNCj4gPiAgICAgICAgICAtIHRlc2xhLGZzZC1ldGhxb3MNCj4gPiAgICAgICAgICAtIHRo
ZWFkLHRoMTUyMC1nbWFjDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3N0YXJmaXZlLGpoNzExMC1kd21hYy55YW1sDQo+ID4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3N0YXJmaXZlLGpoNzExMC1k
d21hYy55YW1sDQo+ID4gaW5kZXggMGQxOTYyOTgwZjU3Li5lZGMyNDZhNzFjZTMgMTAwNjQ0DQo+
ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9zdGFyZml2ZSxq
aDcxMTAtZHdtYWMueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9uZXQvc3RhcmZpdmUsamg3MTEwLWR3bWFjLnlhbWwNCj4gPiBAQCAtMTgsNiArMTgsNyBA
QCBzZWxlY3Q6DQo+ID4gICAgICAgICAgZW51bToNCj4gPiAgICAgICAgICAgIC0gc3RhcmZpdmUs
amg3MTAwLWR3bWFjDQo+ID4gICAgICAgICAgICAtIHN0YXJmaXZlLGpoNzExMC1kd21hYw0KPiA+
ICsgICAgICAgICAgLSBzdGFyZml2ZSxqaGIxMDAtZHdtYWMNCj4gPiAgICByZXF1aXJlZDoNCj4g
PiAgICAgIC0gY29tcGF0aWJsZQ0KPiA+DQo+ID4gQEAgLTMwLDYgKzMxLDkgQEAgcHJvcGVydGll
czoNCj4gPiAgICAgICAgLSBpdGVtczoNCj4gPiAgICAgICAgICAgIC0gY29uc3Q6IHN0YXJmaXZl
LGpoNzExMC1kd21hYw0KPiA+ICAgICAgICAgICAgLSBjb25zdDogc25wcyxkd21hYy01LjIwDQo+
ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBzdGFyZml2ZSxqaGIx
MDAtZHdtYWMNCj4gDQo+IFNvIHRoYXQncyBhbiBlbnVtIGluIHByZXZpb3VzICJpdGVtcyIgbGlz
dC4uLi4gYnV0IHlvdXIgY29tbWl0IG1zZyBzYWlkIHlvdXINCj4gZGV2aWNlcyBhcmUgY29tcGF0
aWJsZSwgc28gY29uZnVzaW5nLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
R290IGl0IC4gSSB3aWxsIGNvcnJlY3QgdGhlIGNvbW1pdCBtZXNzYWdlcy4gVGhhbmtzIA0K

