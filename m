Return-Path: <netdev+bounces-301260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EHJAJXAXOmpF1QcAu9opvQ
	(envelope-from <netdev+bounces-301260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 07:19:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F526B4238
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 07:19:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=mrVDMgHQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301260-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301260-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47419302445A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 05:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDCF3A7F7A;
	Tue, 23 Jun 2026 05:19:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F42E3A3E67;
	Tue, 23 Jun 2026 05:19:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191980; cv=fail; b=E8WN+cGtFr4xdrxYCb8D6vbVkz2XZZQD8CmXX2yOYkHkaQQvC8M0QiE4/6zM4nd2qs5EJQVNqZxGznuqtNnbTgOUvRMaKrI/rn4785cNMqEYNhhRWx/fZBa4wjyB2BHkmOtwRanPFMXBmawAyU7CowOfouTF+jalji6Ga4znqFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191980; c=relaxed/simple;
	bh=QT0Z85kCpyYFgaMzWXpfxfqoIrWIgMCEJVInjeLweBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gjcxlw823Be3RvXzpMTJG6QAGiIhQuKLXfPSUFAxOC0ddWg4luF3247r4TXPlAjABkFnfk9+BLdAiNYr6BaL0gz1b1tnKb+pR7MEeH33YCpzoizSrSKppo8yfBKFHdbBHJ+OxlzLCESznrLLpG9tGbpsFIi2njspeMiTJxRQ0UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mrVDMgHQ; arc=fail smtp.client-ip=52.101.52.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJIpp3yQQXUQkm02ogfdhVGgcGp/zZIy03FEUCCSFdbNDckKdaqkGonk/lKPnFsL7BCHDh/OoXFr7WWvJQIgJi654k0+1gyzRkC5aUQ+Tcng3j/p/JAssDSpL10fjBzQjzaI/YkmLXgMcK1vt6BZcm1JsW7/Z6RLP695Qxpdu0X5Z0qKyshfWN3/UW+xHD75sbhdCvkAHBCDEquuXGB7tCvSSJHYb0GwH0KkOMaLoUQqfpShAHCwzU8xz4KlDbGEPS+xZLkj8cDKe29m9+4bSFManu9LbneQ4MZpvJ6b9noedByYLUwU9ppsHTl1K+A3CF0S10oD0kG9NhAuBNNj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT0Z85kCpyYFgaMzWXpfxfqoIrWIgMCEJVInjeLweBw=;
 b=u8RsirJALLIeodvQL3/bESZRUPrwk2uYhiKpSzUMs2F0u3VhpnVyrqoMZLPAngHMiwFTkrJ7ayNHI20vDV7Iu1ch79EHuq/o5O4b4XqaTKCW16h/LM+yi3wkdyjdImZT8Jsnozv99QWfx9VRMjW2lwG7Ib7h1oZF/N++aasuu/hS0wsxJDBNex34EqJDuzEl1KRuVh9zqdrBxQtk5jC/YtKyRrCm4KRWIvECFEksR3uhQyjFC8W3WZg7XJK94Pn6M9/LyxVbRVnnCtlOxQ91oU4RiwQFPJgpQHj0H614VZE2yEXU/1/tizHVAARs6eeaSxSMYUt2IIWUfnbbmkd0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT0Z85kCpyYFgaMzWXpfxfqoIrWIgMCEJVInjeLweBw=;
 b=mrVDMgHQSaMhTVvggRFjmPg1fv1R/DCnvkNpvUWVIcKwY+ViqRMxeYuMcmRANTpTGZlU4rHxLNuh9YcYB98M69nMdd9FbfLpzUeCN4NO/Ev9/5xUe72GZJhGmT9Nhh0LNZH1g5IaXq2Fk4CfaJR0bDbScAxa7uZtrxQ2+sSWuHLwNUQb6dvEHuSHoFrzZZW6KwmuTWIowvGScs4SMpOIxQgAdhSaQGEh8BNBQfCruatA2kbsybfbRF33o7nLEt+xNDJty8kqWMHQk7HWlB8TpIh14W3obXdv/ODa6GpTL0zMAOqUcbbsSPjBJ3FcNY2MOdIU5ucQDuirsA3l/GnqMA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM3PPF90FB92BE6.namprd11.prod.outlook.com (2603:10b6:f:fc00::f38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 05:19:36 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 05:19:36 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Selvamani.Rajagopal@onsemi.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Pier.Beruto@onsemi.com>
CC: <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Conor.Dooley@microchip.com>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Topic: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Index: AQHc+e0XZNEa+AKE3E6e8zsz3KcUMrZAt0IAgAMKGgCABla3gIABk9YA
Date: Tue, 23 Jun 2026 05:19:36 +0000
Message-ID: <64f4f30e-a987-4289-b36a-1acc977a6764@microchip.com>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
 <20260611-level-trigger-v5-1-4533a9e85ce2@onsemi.com>
 <7c89df6b-32ac-46c8-8400-945879037f2e@microchip.com>
 <CYYPR02MB9828CD98EEEB9B218A940E4483E32@CYYPR02MB9828.namprd02.prod.outlook.com>
 <CYYPR02MB9828A1434E6339A6CFCCA74283EF2@CYYPR02MB9828.namprd02.prod.outlook.com>
In-Reply-To:
 <CYYPR02MB9828A1434E6339A6CFCCA74283EF2@CYYPR02MB9828.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM3PPF90FB92BE6:EE_
x-ms-office365-filtering-correlation-id: 6ca8d193-620f-4701-4468-08ded0e70486
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|921020|56012099006|4143699003|11063799006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Fbk49t3PlwAf8uMROGjzfdRmecgCQOn2ePslyD0Fz0Y7v6c9F2DgYZnuNpT/JdXOL15fDs3l3ScYgVBdGGL3ZUhnnUAF78diRJvUnBuMS5wK74mAG9zfbsTVTPR0nkhuJYhKB0ZtDC85gWqKhuhMYjibjB4SKLhaIyfjGLVlWYKt2TJvWUCG08XsP0dL6V3QhdRJXXeTn/6zKh6EElL60ljQQ3IzxUui+MgSY7WUTnRDRMyZ6z8GgJGs6nw2yaFCHGzYMzQMoGul5KLpyelM58kESM2OwrcR29yHIYfFZ8rIbZ5rTKegtVXX5oSXDs1qdyI7tFpbbsY9PNN8YkkO/OC6Fll9ZbeEiRttCImtvMCVZiFcVC4RRvzPDtTzhiq3IH2OG10u47pHwmOoNzDxBjH2la2QxrYbWVspSTBOB7cm8/dxU3EBW0AOOvD7vzZF3jLJ9yKsMqSOW4gxl4sP9/x4bHESOaPhJhssyI+VhPypolhgG0tDLTUH9PObRJrOfhuOuaNTlXP10pEATpbY/bBxpkmaJmHonVc10p//epYPP7SdPC0d8EKzE5UvsgESNvY1jFEjUPUB/9J8DqQ3JpHC0xaTsvFZtZkDPfgcBWnvw1nLaTpne0MYWILE/iH2J/jcyEbWKWhMCaUjLttZP3P+fO1fjAdLGKLGGUo7v3nwmQO5va0QGQ4obpo6JAQZ3N2Lfbz3OlglPldtTvevKmOGnXtrXjOliAj6g3OQ7w/3OH6kDT9zXa7h1JxlZjPh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(921020)(56012099006)(4143699003)(11063799006)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWg2NDREbnkxdFFWY2tnaG5TazJjMFIyaStMbDFiZTNvYU1DeGh5QTV0QkVO?=
 =?utf-8?B?TFZjeitPOW1HbU1yMHB6N1lYWGI1VlpSZU1taEQzVkZaTTNWdWhvVk9ENUsv?=
 =?utf-8?B?Y3VYWXJKRDN3VUtmeG9MNUZSRkY1TTh3K2ZkaGQ5eFhrMXFYMllVVWlVUHVJ?=
 =?utf-8?B?MWZkcTB2bnh0enFEenFUKzQyU0MweXc2OXdSODRNQ1RJd3lkN3BheG42YUpQ?=
 =?utf-8?B?NFdwblpyUTBONVFpTnU3ZkNIUGtBaFpTYWpTdTU5azM3Wm5aNEpjVy94SzM5?=
 =?utf-8?B?U1NSd0dDSDkvVmNxQ0srLytmVXdmRDFTTityN21lTmN2U2RzNkdnS2huajlz?=
 =?utf-8?B?aXR1Nk1rSGZJdCt4b3JvemtZMldlK3hXeElTb2xRZWZWdVI0ZUt6MjVXUmlD?=
 =?utf-8?B?aTlDak9Xa2wrcXQzQzlpNGZLRXRnL1JZV2F5SW9wc1hEZGxTOHJjeStQdUFY?=
 =?utf-8?B?eENBbng0MGlaMFlmbm9nM2ZmQVBzWnlQOEtBOHl4ZVRWR2ZMcCtlbmxKQ0Jz?=
 =?utf-8?B?bXJYQVl6dm1CamlaOHhqVk84WFJvOEQzRUhCb0MyVm1BTWJRWm95aUNEYWRC?=
 =?utf-8?B?b3NXVHhEeTd5L2FLMlF1NHVPMG8waTBjd1lJUXc3NE1SQzRuV1luSTQ0OWs5?=
 =?utf-8?B?RnljaXdnQXBYVkhnNW0rYURjQ3EzUFR2ajNSRmIydlk1L0JSeWovcWhFNmky?=
 =?utf-8?B?T3RXL3l0WXUxdXRYRTRHbU5EYmZwTmhmOVNDVXlRMUFxS0EzRTRHVWhheThI?=
 =?utf-8?B?Z0dacmd1cFlaOXZsKzdiZnZ4WkRIYi9vVEhyUkNUTlRFVW1SQlJJU3VIay9y?=
 =?utf-8?B?bUdlWU1Vazd5TGZGU1U4Z2VTQVAzZ3JkTHhxTHBpa05SR0pJaGNpeE5aTHRI?=
 =?utf-8?B?cGpQaGovTzE1T2pUWjNicGYwUlBmaUxkNjUvN1RCcDFZUW5TMkJhRERJUmRr?=
 =?utf-8?B?bjVXaG4yU1pnZ1YrVkt4bFljRlVnQkgxVFFBbWgrSTNPUS8yaklIeEphL3pG?=
 =?utf-8?B?ODNpNWhMdzY1VmdHUHVSVDV4cHMzc0czd0dBY1Qxd0k0eTkramRHbUxlZmR1?=
 =?utf-8?B?dHVxV2czYndiY3ZtMUwrTVFrdmQ0UUxQNDZ1d05PQ3JldzJZck14a290cmNN?=
 =?utf-8?B?a09EMU1NZTVtWUUxOWtlakpHd1h3MzdYODdqN0VSVU14UUU4SC9IMkVnbWdw?=
 =?utf-8?B?KzU2alBMV2libWpkT3d4NURSeUhaeU1iQ2pLdm5TZXUzbGlkYm94blFxV0xY?=
 =?utf-8?B?cnZGOUgzVjV3ZHkrRjhubU0xQzBTay82RStyZ0M0eGFROTVGYWxkVGZ1dldD?=
 =?utf-8?B?WXdCOWVhYWVmZzNQTlJEemtGVnhOMUtpeTkrV3VDbGlKQ2ROallLTkxSMUE5?=
 =?utf-8?B?aC9zYjQyZ2xZUlYrbGV1Mzg1TlljejZmdGhjYnpOSzcweDBObnE2SUlSd3I0?=
 =?utf-8?B?Szg5SmFrUlp5aklNeDM4elpEZ2dicnk3SWhtZWQ1UFh1aXdCT3VxSXhiVmdX?=
 =?utf-8?B?Ukd6a1BBenFBTVVZSEtPZkNCZmp3SUkwWWJmV2VSci9ETHJXZzAxRFlJb1dr?=
 =?utf-8?B?K3NvZStsUTlhOWdKYy9Hb01JYTd1eld3K0huWXd4T2ZKRkQzU0lNaFdnREhG?=
 =?utf-8?B?SHk1R3JPOTJjQ0xLN001UmZoY3QxTHlqUi9YaFM3YXQ4dnNWeEI2dkdZNjNj?=
 =?utf-8?B?WFlrcVV4UEZWcW5OS2RBK09mTUlCSW9tYWtuQUVmSEgvbTRHenhJeWZUTXEx?=
 =?utf-8?B?VWVsM2FMODcvbUJtVUZJNmtJZ0VOcWhzVzZSVnVIYm1lQStsOE1URmxNUGlN?=
 =?utf-8?B?cXQweExPRGV4OG42aEdoMnpSeVlxNXdwWnVBb0szbWk4Z1lWa3VGVS8vK2NC?=
 =?utf-8?B?MWRlME91RFFhYmNxYXZHTHRqZWFmcXA3ak5GM29Wc3JUMTB0NjdrcDVmZENP?=
 =?utf-8?B?Y0xHZFpUK2tPazBraW1EU2FYQ244SXdGT1Q1azNKNC9nT205NmF5RHRwRlR0?=
 =?utf-8?B?am1MVnpqNTdqUWl4Y1B5UU9ZdE9NaEN2d1B2ampIRE1FVzN1b21wemk3UExG?=
 =?utf-8?B?RU5PSklBT3lZejNpYnBPYlcvYmRKNXdmeGRxTG12YUZYL0ZlLzJENVBHODdw?=
 =?utf-8?B?aXFBWU11OXM2TnkyZTBXalRDWU5UeU1LdWJQMzZRdXhJell5Vkl5WHU3M1pp?=
 =?utf-8?B?Vm9INFFaMTc5VklqUFg3OXJ3YWlCRDNEM1ZOUVRDNkhUUlpoTVJ6V1p2d0Yy?=
 =?utf-8?B?UjRESjdGaFdWVFJ3UzRwRWxOTnRMZ0xXZ0RrSWZFbHg4S0ZMM05MUHhUWmdk?=
 =?utf-8?B?Qm9qQnFLOHVpVkNHSU9xTm90NzFzQUYzdWc1UFVBSDlaZDZuSTRqK3ZMR0RZ?=
 =?utf-8?Q?GDYm6Op5/A4Mnir4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AE262464394234B8944A5DCC4EF85C7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca8d193-620f-4701-4468-08ded0e70486
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 05:19:36.4865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CGs1camN0Xvovyy72JAI3Synymu6dbUSkkU98ACmcHSCZN3bi5dV695GAoNUDVixQFc3HBBGNiCTr8InnJekSTc2tRnzL4IhA/sQSHevtAF/vrTG17uDpi1HiFoLAXR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF90FB92BE6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301260-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,microchip.com:dkim,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51F526B4238

SGkgU2VsdmFtYW5pLA0KDQpPbiAyMi8wNi8yNiAxMDo0NCBhbSwgU2VsdmFtYW5pIFJhamFnb3Bh
bCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4NCj4+
IEFJIHJldmlldyBib3QgU2FzaGlrbyBzdWdnZXN0ZWQgb25lIHBvdGVudGlhbCBpc3N1ZSB3aGVy
ZSBza2IgcG9pbnRlcnMgYXJlbid0IHByb3RlY3RlZC4NCj4+IEJ1dCB0aG9zZQ0KPj4gY29uY2Vy
bnMgYXJlIGluIHRyYW5zbWl0IHBhdGguIFRoaXMgY3Jhc2ggc2VlbXMgdG8gYmUgaW4gcmVjZWl2
ZSBwYXRoLiBJZiB5b3UgdGhpbmsgdGhhdA0KPj4gbWlnaHQgaGVscCwNCj4+IEkgY2FuIGdlbmVy
YXRlIGEgcGF0Y2ggZm9yIHRoYXQuDQo+IA0KPiANCj4gUGFydGhpYmFuLA0KPiANCj4gSSBqdXN0
IHN1Ym1pdHRlZCBhIHBhdGNoIGZvciAibmV0IiB0cmVlLiBJIHdhcyBhYmxlIHRvIHNlZSBvbmUg
Y3Jhc2ggdGhvdWdoLiBDcmFzaCBzaWduYXR1cmUNCj4gd2FzIGRpZmZlcmVudCBmcm9tIHlvdXJz
LiBBcyBJIHJlbWVtYmVyLCB5b3VycyBpcyBOVUxMIHBvaW50ZXIgYWNjZXNzLiBNaW5lIHdhcyBk
dWUgdG8NCj4gdHJ5aW5nIHRvIHBsYWNlIHRoZSBkYXRhIGJleW9uZCB0aGUgImVuZCIgcG9pbnQu
DQo+IA0KPiBBbnl3YXksIGlmIHlvdSBoYXZlIHRpbWUgdG8gc3BhcmUgYW5kIHdhbnQgdG8gdHJ5
IGFuZCBzZWUgaWYgaXQgZml4ZXMgeW91ciBjcmFzaCwgSSB3b3VsZCBhcHByZWNpYXRlDQo+IHRo
ZSBmZWVkYmFjay4uDQo+IA0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qv
bmV0ZGV2YnBmL2xpc3QvP3Nlcmllcz0xMTE0NDk1DQpUaGFuayB5b3UgZm9yIHRoZSB1cGRhdGUs
IGFuZCBJIGFwcHJlY2lhdGUgeW91ciBlZmZvcnRzLg0KDQpJIHdpbGwgZmluZCBzb21lIHRpbWUg
dGhpcyB3ZWVrIHRvIHRlc3QgYW5kIHNoYXJlIG15IGZlZWRiYWNrLiBJbiB0aGUgDQptZWFudGlt
ZSwgd291bGQgaXQgYmUgcG9zc2libGUgZm9yIHlvdSB0byB0ZXN0IHVzaW5nIHR3byBpbnN0YW5j
ZXMgKFRlc3QgDQpDYXNlIDIpPyBJIGRpZCBub3QgZW5jb3VudGVyIG1hbnkgaXNzdWVzIHdoZW4g
dGVzdGluZyB3aXRoIGEgc2luZ2xlIA0KaW5zdGFuY2UuDQoNCkkgYmVsaWV2ZSB0aGF0IHRlc3Rp
bmcgd2l0aCB0d28gaW5zdGFuY2VzIGluY3JlYXNlcyB0aGUgbGlrZWxpaG9vZCBvZiANCnJlcHJv
ZHVjaW5nIHRoZSBpc3N1ZSBpbiB5b3VyIHNldHVwIGFzIHdlbGwuDQoNCkJlc3QgcmVnYXJkcywN
ClBhcnRoaWJhbiBWDQo+IA0KPj4NCj4+IFdoYXQgZG8geW91IHN1Z2dlc3Q/IFNpbmNlIHlvdSBh
cmUgYWJsZSB0byBzZWUgdGhlIGNyYXNoLCB3b3VsZCB5b3UgaGF2ZSB0aW1lIHRvDQo+PiBpbnZl
c3RpZ2F0ZT8NCj4+DQo+PiBTaW5jZXJlbHkNCj4+IFNlbHZhDQoNCg==

