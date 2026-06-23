Return-Path: <netdev+bounces-301259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7I1NOVAXOmpA1QcAu9opvQ
	(envelope-from <netdev+bounces-301259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 07:19:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9546B422A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 07:19:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=DnrhH5qD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301259-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301259-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27591300861A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 05:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE5F3A3E67;
	Tue, 23 Jun 2026 05:19:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EEE30D3E7;
	Tue, 23 Jun 2026 05:19:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191946; cv=fail; b=aflOrCv2u/ku9IOeMzp1AvpDDdnIsfG74OHK2EwfjUy80fOnXZgXHmQFWRSMKnZUkVT5IetwlUOlG6blBoBwP/OzhqIzGurt0nCKEMCRRAt5LPMrz+poFU5se6oDv3Ge1duSm4prejBGqvVoAQmoHJ/+/+yC3kThrn5B5Ew8pkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191946; c=relaxed/simple;
	bh=QT0Z85kCpyYFgaMzWXpfxfqoIrWIgMCEJVInjeLweBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MUGZUO0P5Ng+fXlBU+HLbKm/Usi92o04ZGRKBSM3eKNml9Xvx6W3iKzBr+3heCESmV+pMCiy4mfavnybgcpxqNI+QTwPXLr8FbfJ5GIe5BXqbcUZ/xg2YJpbg5ARpzNwm96j4rE3+o9cgC9G28FXAmtTbezlsXg5XJyR53xls/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DnrhH5qD; arc=fail smtp.client-ip=52.101.48.45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJED7HBUBp4ibH+xbDnMv4xBi97VRDXY3jdtSkN/OjpoyT9hbK5cy/6j+JQQvyJqmOoex0T3+vC0nASZWqhObLh1RzL8dqosL/HMWX+Yza2m9/LV36aK9eupQKtcKv1cY109sPscIYZVwULlLHrnKvwXDDi+3sFBIHgOGSNodGEvUPAGUbNs4nxGEJyazc5Tc2Hz99OLndGUJsunNX5X1agRYark4S2YicpDo9Yc1k7qNng1pJxs94FNu1P4WCkTeH/9ux3Vq2AD+C7rs2Qe1cUzegz3uU5FK9+Z0bwjMidE2ZPZARs51QrMJZbNQeTfCD6ypMaOZ7YyAMFo4BDjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT0Z85kCpyYFgaMzWXpfxfqoIrWIgMCEJVInjeLweBw=;
 b=ob/A4QcZq7XfQ8skE77H0FE1AgXXHYAApX8uHSMrpdhU1P9Tge1SO9vkIazE8HtDnYUHMZB9FF0lwCR/7mrepuG7r1lvXDiRxAwOKtYUFME3i3GjMNj55GE1g23UHNwOAzJyvT7Mmiwk1AtasaBuWu6WeCz4GMwdkEDWzvpC9/V3+u0pJ12+qONfMj+3PJDUP9GRPBLLoHYqBtDafqreuJ1iGJG1LJ+8HnbEys3k/rhhjzyssnFfx0frQSgDz5wJ3yZO4RyzONT0lSIO8sYUt/LQK629uoiqABDDv9qhnsHJbJ3WEISu+febi7o0EcKnvYuXcA+FtI5xmqpJNdeKRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT0Z85kCpyYFgaMzWXpfxfqoIrWIgMCEJVInjeLweBw=;
 b=DnrhH5qDZYmk0wuIqo9PX7VLRqkBAg5u3oW5jkkRb2IxUy0261F00RY2NQoYUBVqTmOc27RqM/ahsNxgG9wjW6YwuinPSMeYE2FhZVu0PI3uA+QWeIoK38RDUJ4eFMU2mnCEbWgXCqE7ef0CdgZ2xkycirbPgfrXYlvA545AippSjRbaXqXlimrH74rDgvDpGV9BNIQ37rBQcwNZkRMyo6zuH3DAf3LjHKopLBlYIk8xCCOZMde/m5nf/hjNcm8a4/rWI2NbDzWJ4urJVsDS17EJDJANw6EhX6nAfnG2P2q7d6/TyPbzppl10tj89bTJomNx5ycBLpvIltcq/sZQBg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM3PPF90FB92BE6.namprd11.prod.outlook.com (2603:10b6:f:fc00::f38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 05:19:01 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 05:19:01 +0000
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
Thread-Index: AQHc+e0XZNEa+AKE3E6e8zsz3KcUMrZAt0IAgAMKGgCABla3gIABk6sA
Date: Tue, 23 Jun 2026 05:19:01 +0000
Message-ID: <69cf36f0-fc8a-477c-8b0e-217bb5be9e22@microchip.com>
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
x-ms-office365-filtering-correlation-id: a5c3a6f2-4646-425c-f998-08ded0e6ef6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|921020|56012099006|4143699003|11063799006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 F2H8Vcs1CEll6Aiq7FWjhy6qZ5Zx791+qXaA+HpfjWeges2Tv8sZAFvnGWcOvpNVG5qIUx/S+IdY0cmo1LcjnG+94HV6mNbn0ODISbIf+lt3NlbSTHJPlIT6o9tgzwirRLr88XeUUiB18yRYVWgMqJiifhzjUjlCIGRh43fqGa8AXmKOe3xD49sZHTkebtoPeBXLyksHaf3IvUF18QDfEo/AaRE0f8yzktb5FNon7UQuHLlY9QC7M6Rwx5IOIr3LBEPKSMxh3J6XqG0yZhMWx/z33h1bnItEv6VNVjR3wmLz1l15D8r/HZT+VwqJf8gYU5gihaD7zQx7hnIKtConSllh6D4ctK7rB89+BxqrFg6SKJhNowCa2JTQmeGZIYsf9kAKtD+ToL6i6CiebddPgpZK5KjrBPepdNV31/Ag65TI8j7HH/89YNywUIamwmJtL+/sfuGrsAeySALC9KssfUqh7n1S3xKU1SiB42W938xG2vCv9TnqMM+7WbBR4Q+GkxzW+TnXLRkyOW1VAvCkAMpFkldmxTm1Lhu0UZFcOdSBCSoGmhPsuHdudlLKrSAx/5A9WodE63DmbVAr9tqAl03o+K0+SEu7AMwbwxU0Kd5dbEMINigdSbmCYeiw2Cqhpk52jiNBAZDiBdEvC/OSg+RlKAKxyzB2o7yubdJWeqo88Lc5oXJqYCofNCKN9PW6TDxIk/t9YxxJyt5Bjnz8MEcnmwmD1u8cJp/IdN3YkaHtcp3lHhLVK6g9MrIBSfcg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(921020)(56012099006)(4143699003)(11063799006)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUxFS1JORmlTeWNFWjYwMGY0bWxVZHd1NlBsdm9YV2hVVFJVdS9ldWVzRk90?=
 =?utf-8?B?ZU5ScUpQdU1sRmYyWHJraUcxWllQN1V2eG9wcUlIQ0NsUkxnbGtwZW52STFF?=
 =?utf-8?B?Z1ZYa05seXJwSEJndFg3TDd1TCt3d0tpa09YL2xXTGR5NzhJaXNGK2tRK016?=
 =?utf-8?B?M0V2Q29DVG52a2J5d0Fvekdyb2NGV2ZCeDdvK3hORGZtWGQ3UGJ6THlpczVE?=
 =?utf-8?B?dEZBQy84RDFqVUhoSlJlMThUeVJCZ2tQU1Nya1orQzBTWG0wMHdyNm53bHhz?=
 =?utf-8?B?NVJ1SndnNGJ6VTBqKzM4STh6UFUyT3N6RTUzdWllTDU1QzVsc0FqaFpxMzFM?=
 =?utf-8?B?N3NWVlFNaWhrdlNGaUFoQmFiR2dEK3VmYzN2SlJyRzhyLzNkSG05N3pHeDF0?=
 =?utf-8?B?WXdiUUF4alg5a3h5TG5DTkJsVHZtdlFaOE4vK2Q1dUhQYmVlcGhVbmZPUytp?=
 =?utf-8?B?ZExtQjJ6S3ZkOG12VGt2Q3B2dzNQQ1dFbWFWVGFTTnJ2dzB4aGN1emJmaTZW?=
 =?utf-8?B?L2lqSjVieFZGeTU2cDhUL0VxRkdUNmdRWXN5S1ZKTGJhRDJ4QjZNSTRpTEsr?=
 =?utf-8?B?RDhOSmsvY0FOSFhsQ1drbDhxbWxoV2QxRUpEd0Q0RW9OTmlkdU9zMlAwU1JN?=
 =?utf-8?B?YmovSXpDQjI0TVBVcWVKMFNXY3c4RHAzUGczUk1FZlZ4NWRoZGEzL1p4bFFV?=
 =?utf-8?B?WVNOaTg4YS9YU0JDdVEwQ1Y2V1hGcjVWVGpDTHN1dStBU1E3czZQQ1FwRGNM?=
 =?utf-8?B?bWwrby9SdUVrZDZPa1NUamJXMVdIYXRPdkhpa0N0MW01Ui9jdkJ0bi9ONW15?=
 =?utf-8?B?Z2F6dDRIc0lpNy9hZ1pyM0NHQlJsaFdYQzlpNFdaNndRK3JIRTFmdmVhYUp0?=
 =?utf-8?B?Skcwd3paclJUWG02emczaWRGd0FCbUZrNlJpK1JrOCtRZzZHTkI5RzdtdVVi?=
 =?utf-8?B?cEQ1eDVKWHlBRjRoZFR4Ui9DZlpoclJudnhtOVloNHV3VHFQWFFyNUpSNUN2?=
 =?utf-8?B?SnE5SHo0ZisySHlreEx6c2lvMm1xZTk3dVkweUZ3ZVl0Zk12bURmMjlCazdt?=
 =?utf-8?B?MmZFY1lxKzFsRS9EeTNMNEtEZC80TWJnQXlUT2hJTkpVSURLbWEvL0d2dDhW?=
 =?utf-8?B?M2hocHlHeE1ESEFncUlNNXc1K1ppc2gxTVFUZEtlMmJTd3MwcHhOb0FTd2NJ?=
 =?utf-8?B?c0RTaUdkY3lrdVBXT1M3ZmlXSHFSSm1mN0xaU283NjRPd2p5aEJCM1NiUGhM?=
 =?utf-8?B?OGhwZ283LytocXZCMkhMRnpnT2ROc2c2MGxYK1IzZXNYc0FqOVA3TUVHMm1x?=
 =?utf-8?B?Skc1c3NEL3NVYm5vSWRmZjBlRVd0NzlQbVI4YWRPeHA3eVFkbGFTNzdxR1NU?=
 =?utf-8?B?c2J2UDhCbDduKzJzcUhOd01RSllXZFJGTnQ5QVM0WnVvNGpVWHZZbFJvYkx6?=
 =?utf-8?B?dkNCUlNLenE0U0xSSDdmd3p0NG5tSGdKWksrRC85SUdmNW1HYWFNN3BSaHUx?=
 =?utf-8?B?bHVLTEt3M2hKekNrOEJ5UlgxWlBKS0xZdG9TRFNrSmVaZGhaNnNhbjBPWUs2?=
 =?utf-8?B?VlMxOS9MVDRBNkJkNnBMUXVsZW9TUGs1MDRERktmT1FpYlVEM0hpb0NZd3M3?=
 =?utf-8?B?NnpjaC9xdlViZ0dwL3BLelZvcmdCejVOS2FXN0RPSUFuZy96dnFDcndpQkU4?=
 =?utf-8?B?c3BYNUVzRGExaFFhQit1UlU1TlFIL1JPSkV6Qjl2eFFZTG1FZTlUaWR2Y1J3?=
 =?utf-8?B?QW9GMmtuSEsvUmhFUTZKZEVkNnVGUnFJVjQrTFcySmFVN1JFOVRLTmMrZVpH?=
 =?utf-8?B?WlJDdVNDOUhnVmYzWCtyeVhDTEl3Z1FMdG15cnVhOEZFdmM3RldMZjNNblJw?=
 =?utf-8?B?dXZBMks3WkJ6eXhUNW00ZmFsdCtEcjNWa1JyOXBZOXhmd1ZBWkR2NDZzZDJV?=
 =?utf-8?B?aEd2K0FIbnE2VFU0NnNUeVVaYjVxZGRQYjlUaGROellaYUE2dndSTmx6THVO?=
 =?utf-8?B?Qlh0ZzR3K0tHWnQxVkpKMG1UMzlFbXNoaXZzbCs3Wm9yTU1PekVuN1o5VUVG?=
 =?utf-8?B?L0V1cVY3Y0h0S2Z1TUxveEE1dEZQUTh2Uyswd1RlaVdqdlNROWQzbjF0SUlz?=
 =?utf-8?B?WWx4dVJPK3dJRWdteVp2OHlYREpqMU5CQXJYeGRXeGlsTXVoOWxmNXQwTTRn?=
 =?utf-8?B?WDMwKzR5RXVpaUpQVjhXc0tremp1a1UvODVteit0dXhlQmJOa3hFRGwyakZx?=
 =?utf-8?B?Qy9FOUVGMHVvR2l3bGloUzd6NnE1ekJUTkk2UG52MWlIM0toWmFMcGNDbmZK?=
 =?utf-8?B?VnRpU1RNN1FvRVJCaWRnZTg5R3NTMXlnbmhMK0xybmZqNHdYUHc3b1J0T2FE?=
 =?utf-8?Q?lLuTkS9XL1ATORBU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <811029BF958FEE459B40B76271379924@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c3a6f2-4646-425c-f998-08ded0e6ef6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 05:19:01.0759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/RAXLtJjT6/uC95gF7/5LHGdYfGUILmRlhhwYeSVNU+cF/BjEn5D0EyvOYOnYM7gYz+3ApalUUBJt8dlZyvojg9cJRSaAPvDV+stJduEGlF4bK5hZ5/O6RYBDe8n1rF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF90FB92BE6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301259-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,microchip.com:dkim,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B9546B422A

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

