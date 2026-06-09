Return-Path: <netdev+bounces-296995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ON8KFczdJ2qQ3gIAu9opvQ
	(envelope-from <netdev+bounces-296995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:33:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6384765E5DD
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:32:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=Np+dMB3h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296995-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296995-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6248300A59E
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 09:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E39039D6DD;
	Tue,  9 Jun 2026 09:15:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F338F932;
	Tue,  9 Jun 2026 09:15:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996554; cv=fail; b=Ed71AZ+D5RhYAJKmzh3tK9ZWbsK7TNaJeyA3QLQN2VYgYzlXFSM7U24wOoDCUKOHtQGl5ry1Z/MtMfGkd0KFENEVtzLPravs4MVfzVhZuESMz4igYmTPK3ChkDNx02q1C83uzSxCkcEs/xIisQ/VWXABMm3tPxpHGVAXEXunOB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996554; c=relaxed/simple;
	bh=0W5X/R/AY1TanJDEuqw6qovz3WDQD9lK6DEQ+Ad9WoY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HrLAOdyzcJIGGv2ahs01oC/pR7kRPE3NOu/A5l3ZrnUMr7ISGJ2lXQO4n/dVYwitXl31tmiG1WEo8V3x9qW0GxuWOW7/KP3BkMc6IvKXjFS/gTfeUU2Dpx3el6YYO+TiaH9e+8LqedkkyyxPoLt6YIQy4MHAehnszUywB0W8ar0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Np+dMB3h; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTAZgzKfaVZhxNJcYEVLtAqkKg+2MaBonJvL4u6krgnT6YdWjXp18Ju708nVT9a6DzGyM1Wl3A3DxylnT8BgWWpuKN0aAnbMU5k+gSs0MI4IMnybF+y9myXuBPbF316jbFzJK8nez5Zzj2cyCvripr7rhe2pqGkRXSU8/NyXNDjVEgcN2McWEpnOHUVSg1faTuHvTtpBU/pw3AMnckEwUPhD86/k0RAPdk2QeBnmjRpEz5vc73wwjZonk/bupTOKdzlKFiOlgIG+Vy31jd5yTSIuXXGtmTFPju1DNMzCgaorShHUemfM4iOLTDgl2Xwz2FovEBzF4Z9zOTJm9gjrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W5X/R/AY1TanJDEuqw6qovz3WDQD9lK6DEQ+Ad9WoY=;
 b=h0SyTHXx2dlRGeR/KUCpmSQIy5EZArcwaDgkrPeJ7RvjEiTo/HoB2xmnnaeIgEhKI2VsEGz4PaUsb1Z194smyAbEd5IXLm5Q5THzOQ0IdAD3oz3CNyOmHIHTHigMtH5A+zSS+YkH2uxmG58lJ1K8nkxczdO2QvkxpGwO3ekBYl9gS+q8MsqOb7nua5zGyPounEtDqCyYbAVGKuAK4NM7SNdtfXY1h6ibUcnHd8X93vZsH5TaWNTHupaG94faN1sITMurTKBUzJadAb99mQ+/C4bq8HD7a1Jqbh0JiO4dlWaqdcWHL8HKsQsbhb9PSizEcwLM+x0IXrHh79RbzNIijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W5X/R/AY1TanJDEuqw6qovz3WDQD9lK6DEQ+Ad9WoY=;
 b=Np+dMB3h7S1smUJr+E5IgeHEVxtAgQXT2Efx94FT5UVzCg3EcOj2u6oFddnsX20SJGG6J/MpejDrck6j+Rj2aKb26Wv9eT9dmazd+lMoC3DB7bG8t6JGGjPy6BDqi/bz2OV5iPY2oEpZ0RpD5GiZg0vesyWWkF8vDFkn2FIjHGEc5DSNQnMIpYoFeL8Emh7hGPJ+3pAcIqIGFiB6cKQzdB+sURX75Hg+HhgJgkQY/oSHCqpXfKzdYo8oe7C4oPCF/D4LauPnEC4UyQEWdYpe9UBbODM4jj8IQlYUnunO2eGwHMkVW5Mb2oRhnsLzQ0BbHQW1l/ka7HIIIm5kKsDYYw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 09:15:47 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 09:15:47 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Selvamani.Rajagopal@onsemi.com>, <andrew@lunn.ch>, <conor@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <Pier.Beruto@onsemi.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Conor.Dooley@microchip.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Thread-Topic: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Thread-Index:
 AQHc8eDGO4Y2rMyEmEeRgmYw3vsZ4LYrecyAgAAPEwCAAmo7AIAAlNuAgAAUz4CAAAajgIAFcz6AgAAInwCAAd4WAA==
Date: Tue, 9 Jun 2026 09:15:47 +0000
Message-ID: <a02cd86e-a5b8-481c-a07e-7243ee537b24@microchip.com>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
 <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
 <CY8PR02MB9249E607ACBF3A05AB83ABF683102@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260604-swimwear-garnet-3eb092e6fda7@spud>
 <4df9882b-3426-4c36-8048-0c76d0f11c74@lunn.ch>
 <7c68173a-ebff-42cc-8519-95e8365805b5@microchip.com>
 <DM4PR02MB926317F64B5A3827009B66A9831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
In-Reply-To:
 <DM4PR02MB926317F64B5A3827009B66A9831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CH3PR11MB8775:EE_
x-ms-office365-filtering-correlation-id: 2b8233f8-9a8a-479b-34e6-08dec607b127
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|56012099006|4143699003|11063799006|22082099003|6133799003|18002099003;
x-microsoft-antispam-message-info:
 tt9F7Y0EoR2dqKVa0nLNftejSkttkRIVb6cHSOWi5HcQ/+kp6LfIGuUq0OuK6ZCNptgMWc1v3hh/ieY3TsiXeMhFlUckV8TBVA2RVKa4NoTHB5vA7+TJEm4p64ANaGGc2290zvtsGNmSTH0VoRQIRnNjIra+13XI9Yi7q9PDSmy9hhOV2rUbeI0WPc/jCRhfQMbfwSKkJ13x3MGC6NcX8NO2I/lc7C0JvbYT77R1pxDPTS3ji7V+ycdaoM5rXyzmSl1EySsU8g8EMxBnYZafBui58IKnU6RSgdNtzrC1PMvOk3cshFYEBlChrDC/dW1Hji73SNiTsxIDxFqguCVd313ohCekXYbb/rxD88Y6l0t+MPCdB15LtnTAsSMgPZd1aF8oZTRtSWPFhzQS+nHLt7/RGCzIZn4+HYbD8oVDSeIv4SrCeu6menCdBbAO8O4vBGnaNlyQvY4g86I8r3XyWt+/CuicHmuQHtYrC+aEewKLyNZU5meNuw/l5bAI6tyfEsRO7HxU05Eg7uL3mwhmEwJ09xFftpZzXQ/+0ZDwRRIRRrZpHwFNtug9q2ITMKnigk8p4/6wU78q/ql48N7ojUW46l0PyD1H+0U3Fpg8uVNJoncey4KOLiJVwjwb9RY849h4Nz+LnRQUHZEAm/61BLtfdW16qo5SLhv32dtD2ZxDkCy2FvUIW6Z2mAtlPg3oG/qKLd0PnptdleI5tPVjLYyHO6ZjdZUSWQEeN3GEyyOwDbxQ/gs01Tbi/IkTSYFd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjlJeFF0N08wWlRlaFBXdXU5OGZuOENZQW9BL1Fza0swZk9pa3FhcVluZ29h?=
 =?utf-8?B?eWdGaWFmNTM1Sm9SZXdJWktkL0VRZDVpazJDTVNlczh1YmMrRCtmUS9BT3Nu?=
 =?utf-8?B?b0lNT21WeVRTbk9haDNSc2lIOXVJQWF0a1hJNi90Um52OUJQSUwyVzZKMXhU?=
 =?utf-8?B?M1VmZFF2UU9HU1ZyVVY3MWdkKytsdXl4SUlObVZWOUhScVF2M0lCY085dGtt?=
 =?utf-8?B?WHFjeWhuVWFkZW56aXZ6eEUvUGFGRDRkVkt0SmRxWXU4T0lLSjFJd0E2RFdu?=
 =?utf-8?B?QWZTTXMvTDRlUHN3Y1RmQ1d1czdtODVJR1YzanFranlvRkZNaE9wVEt2M2F2?=
 =?utf-8?B?ZDRiZGRPaVd0NjR6ekdLUE5RSFB4RUY2aWNXcE9KcmNPLzBiZ3I5N2lVa25a?=
 =?utf-8?B?d3VrVG9FelBUR1I3cjVNakRpVnlkRWhJTWVjY0lWUEJyUDAxMHNMNTBEZzN1?=
 =?utf-8?B?REdMdmhWR2pLZmpxWFNreUVvai9UdmhSOWlmL1ptWi9zUXpmdWxJclkrWkMy?=
 =?utf-8?B?M1BQV0FSQkFaUTdnNnFpNVFTYzJvVk51QjRvZDluckx6N2dEWjBhQ3g0ZnFO?=
 =?utf-8?B?T3FxL05YclFDdW5BdlFpTXk3MkFxcVZWbnYwZDFxZzQyZ3pGN0xiQy84NkVM?=
 =?utf-8?B?ODBiU0pDSXlobldidEQ5bWl5d3Fod2RPdkUrdkFldGtzdE9sUGNkV1FZOU44?=
 =?utf-8?B?M3JKVFB5NGJtR2JYQ3dzMkVVUVc2cE0xWFNvc0lValU5MkxFYmp6VzNUTW5q?=
 =?utf-8?B?VWliR0s1N0NoZ2lWU1BKdmI5UnJENTBHcVVJaHNwMUZabHdHbnpCc2FSVzZB?=
 =?utf-8?B?YUhoeXdybU9Ha1FPbDF4UFJpenRveFNzZWFNWmJjeXB5VmxiUWIxcUJRaklJ?=
 =?utf-8?B?N084WG4rS0U3cVlueXpFVEN5OG5yQmxwNlNrZDBmSFJvMzlBdmljMmlNK1Jw?=
 =?utf-8?B?eUQ5R2lzOGhQT09JRndNZXdkOXhRNEc0VkNYZXl2R0FreFJkRk1yVTFrQjJY?=
 =?utf-8?B?OGdlaVpUSUptYzFPTDYwRzBWMEVCZnFWY3gzaVgzTHc5eHpMQkxQdzVRWWJt?=
 =?utf-8?B?eXpWSkYyRWEzSnlrS3A1Nkt5VXVmU2pwVzhDNGVlRGIwaUNCb3lacjJBWUZR?=
 =?utf-8?B?RE4yc0M3aVkxZkhJMTVHc3d2eWxGd2hBS2JZcGpYS051djRYeTBBenVPbU5p?=
 =?utf-8?B?akNHRXp2R2hPUkdDTTFGd2JKYjhvS3V4RURGY2lQTExtNGRmdjhTdExPQ3cw?=
 =?utf-8?B?YW45VUk0R3Z0akZNaml4cHdDT1hJNW1YZG16dDQ0MytOaTNoSjZNSmZLdXl4?=
 =?utf-8?B?NXl6NjZYMzJQWkZUMmlGUE1zV3ZUWk80clIvSkNNZTVPY2QxMWFiT2thMWd6?=
 =?utf-8?B?UVU0SkM5dlZlazRNT2VQaktOZG1wSkZFMGdRTURlL3lGREM1aVFpMFdjenN2?=
 =?utf-8?B?SjJ0ckxkVTZjR3dnSzEzbWZ4eW9IMEdlcXZJVEp3UDBQemJ0bVZSSzZPUEdH?=
 =?utf-8?B?TkVWM2xNR1V4T0JpN0JqQlRjNUZxcSt5akVFVGlDU0F0cnBueG9qQkQxa3Az?=
 =?utf-8?B?NWZVT000Mlg3WlVydWxFZWlmNmJLUUs0OVZwbG1jQUdLMnZVeW1wREg1bFBX?=
 =?utf-8?B?MEI2TFZ6WTVVMTgvSGFLM2R6K1Z2SDhnazMwdmlHVTM4Q0NKSFZoM2x1alZr?=
 =?utf-8?B?Z2FYS3VsZTM1bGNLVnZidDZTZzg2UzBSNkZObFZyUE52ODdkNEdlMC9jVDJ6?=
 =?utf-8?B?cjBJc0tyd1JwMStLMVdlUjlhODMzMnZMQjFGRzllVzZ2YmhsVzlwbm10dGYw?=
 =?utf-8?B?Wi9lb1JaeDJHK2szai9qSUZRb0s0NVpTQ2tkM3FYaFhIaVU5NUNQSTVnUDFu?=
 =?utf-8?B?cFB2dkdSQVdPQUtZUGZ5QUNUL3lFczZQMllQWkhtUWJGUjkzRUEzTk10NndJ?=
 =?utf-8?B?cWlnVG13dlErTGs0REtWRU1IbEx0d2llSVlrNUduRnlMa0JXRU9UallBdDJw?=
 =?utf-8?B?emJ5RnRJWS9jemU2ZGxoYWRqY2NVclJNYWVQOGllTVBNWmZHNUZYNVRxSFVZ?=
 =?utf-8?B?SlZ5cVRHMmhiRkZ3cFJtTnUwZFdMZnl2UW5jNWlQYWlJYWFlRUJkMkRaOERY?=
 =?utf-8?B?QkE2cUxRNURZZ0xoZW4xWGF5dVJpa3huZ2l2UUIyVnA0QWlEd200akpoUHpE?=
 =?utf-8?B?Q0FpVUhOYTVUMTlrYVdwMXFFRUFtU3N1dzV4VHlNNzZFV3RMWjMvaFdFVWNO?=
 =?utf-8?B?QWJIY3RMSmtSakFUb1JINnFyazIwVzZ4RkNXYy9zeVZWRldWT1B2M1ZhMmR4?=
 =?utf-8?B?VFovaTliM09jbzVjSjR2bHEwb2hDeWs2Y3B0TjFTcnpqbFJTOVM5UGNkS09Y?=
 =?utf-8?Q?ig0O6ZteuIwAAS3M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89B38A5691A68D469DB1655DA4204FDA@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8233f8-9a8a-479b-34e6-08dec607b127
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 09:15:47.1288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ju2TnYSaeWJu0Leodht6CNYh+z3iTpcXSdRWZpAm5Q/L/X4WpSp+trPL3SPpYSqcupKSOIdoEAE0uQBMPL0OxWiMbHi9O3Wbd5RrKxfg53SO2jV2cKUh/nb+6EKsuClR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8775
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296995-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew@lunn.ch,m:conor@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,microchip.com:dkim,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6384765E5DD

SGkgU2VsdmFtYW5pLA0KDQpPbiAwOC8wNi8yNiAxMDoxNCBhbSwgU2VsdmFtYW5pIFJhamFnb3Bh
bCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gU3Vi
amVjdDogUmU6IFtQQVRDSCBuZXQgdjMgMi8yXSBkdC1iaW5kaW5nczogbmV0OiB1cGRhdGVkIGlu
dGVycnVwdCB0eXBlIHRvIGJlIGFjdGl2ZSBsb3csDQo+PiBsZXZlbCB0cmlnZ2VyZWQNCj4+DQo+
Pg0KPj4gVGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQo+PiBUaGlzIG1l
c3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uDQo+Pg0KPj4gT24gMDQv
MDYvMjYgMTA6MzAgcG0sIEFuZHJldyBMdW5uIHdyb3RlOg0KPj4+DQo+Pj4gVGhhdCBpcyB0aGUg
cHJvYmxlbSB3aXRoIGVkZ2UgaW50ZXJydXB0cyB3aGVuIGxldmVsIHNob3VsZCBiZQ0KPj4+IHVz
ZWQuIFRoZXkgd29yayAlOTkuOSBvZiB0aGUgdGltZSwgc28gbWFueSBkZXZlbG9wZXJzIGRvbid0
IG5vdGljZQ0KPj4+IHRoZXkgaGF2ZSBpdCB3cm9uZy4gQW5kIHRoZW4gb25lIGRheSBpdCBhbGwg
c3RvcHMgYmVjYXVzZSBhbiBpbnRlcnJ1cHQNCj4+PiBnb3QgbG9zdC4NCj4+IEkgYWdyZWUgd2l0
aCB0aGlzIHBvaW50LiBCdXQgc2ltcGx5IGNoYW5naW5nIHRoZSBpbnRlcnJ1cHQgdHlwZSBpbiB0
aGUNCj4+IGV4aXN0aW5nIGxvZ2ljIGlzIG5vdCBzdWZmaWNpZW50LiBMZXZlbOKAkXRyaWdnZXJl
ZCBpbnRlcnJ1cHRzIHJlcXVpcmUNCj4+IGNhcmVmdWwgaGFuZGxpbmcgaW4gdGhlIGRyaXZlciwg
YW5kIHdpdGggdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gSSBhbQ0KPj4gb2JzZXJ2aW5nIGlz
c3VlcyB1bmRlciBzeXN0ZW0gbG9hZCB3aGVuIHVzaW5nIGxldmVs4oCRdHJpZ2dlcmVkIElSUXMs
IGFzDQo+PiBhbHNvIGRpc2N1c3NlZCBpbiBhbm90aGVyIHRocmVhZC4NCj4gDQo+IA0KPiBQYXJ0
aGliYW4sDQo+IA0KPiBJIGFncmVlLiBXaGVuIHdlIGNoYW5nZSB0byBsZXZlbCB0cmlnZ2VyZWQg
aW50ZXJydXB0LCBjdXJyZW50IG1lY2hhbmlzbSB3b24ndCB3b3JrIGFzDQo+IHdlIGFyZSBub3Qg
ZGlzYWJsaW5nIHRoZSBpbnRlcnJ1cHQgd2hlbiB3ZSBoYW5kbGUgdGhlbS4NCj4gDQo+IEkgaGF2
ZSBhIG1vZGlmaWNhdGlvbiByZWFkeSB0aGF0IHVzZXMgdGhyZWFkZWQgSVJRIG1lY2hhbmlzbSwg
d2hpY2ggZGlzYWJsZXMgZnVydGhlciBpbnRlcnJ1cHQgdW50aWwgdGhlDQo+IHRocmVhZCByZXR1
cm5zLih3aXRoIGxldmVsIHRyaWdnZXIgY2hhbmdlcyBvZiBjb3Vyc2UpLiAgTXkgc2ltcGxlIHRl
c3RzIChwaW5nIGFuZCBwdHA0bCkgd29yayBmaW5lIHdpdGggdGhvc2UNCj4gY2hhbmdlcyBJIGFt
IGdvaW5nIHRvIHJ1biBzb21lIGhlYXZ5IHRyYWZmaWMgdGVzdHMuICBJZiBJIGZpbmQgdGhlbSBz
dGFibGUsIEkgd2lsbCBwb3N0IHRoZW0gaW4gbXkgbmV4dCB2MyBzdWJtaXNzaW9uLg0KVGhhbmsg
eW91IGZvciB0aGUgdXBkYXRlLiBJIGhhdmUgYWxzbyBpbXBsZW1lbnRlZCB0aHJlYWRlZCBJUlEg
aGFuZGxpbmcsIA0KYW5kIGl0IHdvcmtzIGZpbmUgb24gbXkgc2lkZSBhcyB3ZWxsLiBTaW5jZSB5
b3UgYXJlIGFscmVhZHkgcGxhbm5pbmcgdG8gDQpwb3N0IHBhdGNoZXMgZm9yIHRoaXMgaW1wbGVt
ZW50YXRpb24gYW5kIGhhdmUgbWVudGlvbmVkIHRoYXQgeW91IHdpbGwgDQppbmNsdWRlIHRoZW0g
aW4geW91ciBuZXh0IHN1Ym1pc3Npb24sIEkgd2lsbCBob2xkIG9mZiBvbiBwb3N0aW5nIG15IA0K
cGF0Y2ggZm9yIG5vdy4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSB3b3VsZCBsaWtlIG1lIHRv
IHNoYXJlIGl0IGZyb20gDQpteSBzaWRlLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0K
PiANCj4+DQo+PiBCZXN0IHJlZ2FyZHMsDQo+PiBQYXJ0aGliYW4gVg0KPj4+DQo+Pj4gQW5kcmV3
DQo+IA0KDQo=

