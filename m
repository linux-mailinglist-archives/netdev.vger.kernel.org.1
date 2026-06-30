Return-Path: <netdev+bounces-302930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mpoPGVQ3Q2oHVQoAu9opvQ
	(envelope-from <netdev+bounces-302930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:26:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6846E00CC
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:26:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=S9QU0xqO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302930-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302930-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3E45300E3AA
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EDC38945D;
	Tue, 30 Jun 2026 03:24:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E042A2367DF;
	Tue, 30 Jun 2026 03:24:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789882; cv=fail; b=UUqtmUI7WPjKy8imXsSD47S42A2h7sHb+3NVKCTDK96L4heC2TzNS3R3ZMt7YTolZjrZHpnuyKb0kL0qPJsDt31O0SPpX6xqHyBBJsbSBC01jLpXha9jdONuUo2H1ayikHYNzIJACcttoPwUavy5mhWEOJGVOF3NRHFxgj4k0ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789882; c=relaxed/simple;
	bh=iwdkGBdjXWMZkQ1PqvhzWXHMoWrU/wyti10T0N0go3E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YRGeEpc6ttHO0IAUQ3C7AmsvriWKh+I4MEgdB7ECgITOLF1/jBwmqhjnAvtz0+IilYMZbi/1eaO41VpDz7IRmihUbNB3EItK4MbYtW08n+yQXIASE/jL7B4cIdH6qeDTyudAsURkvC+RHsRcxw/B9MPojJxdIaX9Nn0TMRW/Dko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S9QU0xqO; arc=fail smtp.client-ip=52.101.52.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fiss+yHyb0qMq6oZSvquJxtWkSAL98XYh0j9fvM/pOD+qjEcUn+nLwiNTGkIdaswZm8aHFrhXiG9qQAdIyNEiIiMmP45QlZsHe5Mmb5vMx4+HCqfUcEP4Wd+Q4RF6K5HPBrhMwa4/mq+NEKtxnDkZvtNkiToHTzo2PHOB8wTrayGFyG8Bnw1N2dWvu1kBYBJnq5/ejwkd2s4dr3brd0hmMSf4YrnWpXV4cbnbf5jQtmYfUPps1q3P/3UvAmydSzKXWlQV0E1aH4PmJZNtxhq1MluMDeIxqr4OC2OUeikzgF9/iuLB9VOpAvxoXtG/Gsm2/ENPb2BQjM2sTNL/dqjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwdkGBdjXWMZkQ1PqvhzWXHMoWrU/wyti10T0N0go3E=;
 b=lQ8QYD9VzcTzO/cgQX3H4qRXUidz1bQZrDBeu8k2MM0rwCYP0Nx/bF/0KKnHd2nBuRJb8lhDfaMFsMqTccpHqNiQgpX3x68XUso0bga/eFoNabLeulOXYjJ3JCdKBygL3W91myoxv7qumf5NyIoRiNutpYRDB1OqPgda+gF2G4FyVMKcrX8/81U/Aom/IxXM/dOPDWWy+xEN8dk1WI2AGojOTx4aDzwXgtTD7BdmOjDCyuDAuu0ZuRi9Z1H40uqqos9qAdcQIuRkk8If7TnRxSA8AwDEiE5GKXsutgrl20MlYJ3jbnycVlQvvLC9x2OXygJDi41AqrROwdDYD6ww3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwdkGBdjXWMZkQ1PqvhzWXHMoWrU/wyti10T0N0go3E=;
 b=S9QU0xqO4IklMb+Zzgvx/B+P786PJdo0wnce3fHtZwX0HapqpOYkRk6tB+5W7CCEkk95lxK8NgMKYH0kJAWHRhwq/K/Q3opl5thRDbztvK3qNTtWdfDNT8LUzg0478z40n6imTFl9C7iVshAw7m2zWOOsBhrD0xZ+SxktXU61xK7wMhmIt/SwdWy2IMJ0uQXSlDxq3UrQJf7z7vS9mNzkFFmflWvvgOFkalZls57kq94bM97S+SfZ+zcCxzR4RUfF7L2b7cAdr6bha3/h7Qz94Ro7zh4yi55mStcxDH7GFh5OL0USnTqZ6WF18wX7zef8m0ld55a4P7JUDjwWqEgCQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by IA3PR11MB8918.namprd11.prod.outlook.com (2603:10b6:208:57c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 03:24:38 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.21.0159.013; Tue, 30 Jun 2026
 03:24:37 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Selvamani.Rajagopal@onsemi.com>
CC: <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Conor.Dooley@microchip.com>,
	<devicetree@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Pier.Beruto@onsemi.com>
Subject: Re: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Topic: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Index:
 AQHc+e0XZNEa+AKE3E6e8zsz3KcUMrZAt0IAgAMKGgCABla3gIABk9YAgAAH9ACAA5akgIAALl2AgAACmYCABxCiAA==
Date: Tue, 30 Jun 2026 03:24:37 +0000
Message-ID: <d15eaa01-3312-420f-a34a-d810710e5b12@microchip.com>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
 <20260611-level-trigger-v5-1-4533a9e85ce2@onsemi.com>
 <7c89df6b-32ac-46c8-8400-945879037f2e@microchip.com>
 <CYYPR02MB9828CD98EEEB9B218A940E4483E32@CYYPR02MB9828.namprd02.prod.outlook.com>
 <CYYPR02MB9828A1434E6339A6CFCCA74283EF2@CYYPR02MB9828.namprd02.prod.outlook.com>
 <64f4f30e-a987-4289-b36a-1acc977a6764@microchip.com>
 <CYYPR02MB9828E1167750AEA090EC60CD83EE2@CYYPR02MB9828.namprd02.prod.outlook.com>
 <f127837f-e08f-48e0-a3a9-906e1d61d6bb@microchip.com>
 <CYYPR02MB982836BC273D09FD3BDE623583EC2@CYYPR02MB9828.namprd02.prod.outlook.com>
 <CYYPR02MB98285BD6A2639E0B01AE407183EC2@CYYPR02MB9828.namprd02.prod.outlook.com>
In-Reply-To:
 <CYYPR02MB98285BD6A2639E0B01AE407183EC2@CYYPR02MB9828.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|IA3PR11MB8918:EE_
x-ms-office365-filtering-correlation-id: 09812376-9f07-4079-f846-08ded6571d6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|38070700021|18002099003|22082099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 nGTibxWU7KCLxBtvMgihyJBrdeBtpCA/AbNcdgnPuXHnipwbiVspaVd6QuZhykHo9KLpjTFGuJBXLz89eGo+eQLAvz+u6eTYi/83Al1WBciW/YUUFAl2q3ANuuqXphQ6MTrMta/Vo/Cv4MnklYxXgHWf8IMs87t87UqHf/A2jAkSnJzvaj10/dvF0qP+D3EjYPnv0p6s4a8Lqdw0Jh0VFwI0s2E6NsbdtPIEVWBR7BD0pbXhAMPiPweX9ls0ZbNWUPbgelYmIxsXD2F9H0u1aVKeN4UHKClxr8KbG9G/qOmyXVWxDLhaKK+IHdgFpJTlZO33uJ+ist3C4Flm8z/fhKD75UZW9/VwVZ0DHJZMhOB+pvxdHsCYBJ7oliW3LK6F94hpMBdHZI9wBwjAyElsKaXJaHV7tXnqThig3O/wlP9qnQTH3kFYlp3Ca8Qc2U6byQ9QMTfdal4T+Yjp2DtVKyYwsUdNnO3ERd3gEAST0nMd7V8BmcJG8NkmaEF5nuMBVXO9fdgJKxwXrDJCXOWlh7KA/RiUZmM3iwcTN+OVekhxIu29qMcMRWt1IMUkxaELRWNCjM497i+LShGw1WsxIuCAbm93oozEowbmxDtlCmK9Tpa3kq/ZZi23eZ3PCS5BdSNQM45H9Xtx8dNFsl58HXxqAdsaQ7c4NHwSJ/5s8X4h2+O698kRM1rYY6w318+NbvU5+UJaIPS6IcKcfvUMv6mq6gtpPlgORtkzWUBke8c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlJCd2VvTC9Selp6enpucTc5UEE2aGhHRjN0d2tadExDOTlTWmRxdzZhcFE3?=
 =?utf-8?B?ZE9mNndRUm5OVHEvZEhGVStoLzJIK2V3YXV3MWV1SUMvZjAvNk5lMkwrcysy?=
 =?utf-8?B?SjRONytST1J2MElhUGtjTEl0a1p1MHFZeXFaeE5yS2pvOGNuaHBvQ1QvNHpZ?=
 =?utf-8?B?K2dWREl6eTZSV0N5anIzN2x3YVVBVmVBMWk0OW5sY2pIYlN4V0JPWU9RSStK?=
 =?utf-8?B?WVdEbFJRSGVtTGdUNHhlMFllaHJPVi9KL2JtUFA0M3FERFBIOENpNzVlNGJJ?=
 =?utf-8?B?a0F2RmxTNUdXQ1RTalBkUFVOdDJWV2h6T0hhWU9GVjZwbDI0dmtDTFcwdmda?=
 =?utf-8?B?b1gwanpGUXJYOWNjaHpiVkV6RGFXWmh4aWRjSldpSmMrOWNIVWRIYU05ZllV?=
 =?utf-8?B?OFN3eC9XNGZ1Q0duS3FPMEVKTEg0dWMxUlNuT24vREF4L3Jac1hacVR0dGNu?=
 =?utf-8?B?T1BjZUs5ZXREVzBUbkJLQ2xsbHpvcGV4SlZpQVZieW56QUtTU1RTcXlSUU94?=
 =?utf-8?B?ZWgrUkljcmdKMWE2QzVWOXM0UExTL0pRWmgzMnpOdk5HL1IrMEkrMFVxdFJj?=
 =?utf-8?B?ZlZIUWRwN3drQm1XSWkrVVBUQlNVcGp4a2habmVMaGNjcExnOWhGdHlUaXBw?=
 =?utf-8?B?SUgzbXFSNDI0ZDJLZC96NmhkTktrQXdyck5kN1FUaFllZWZRWjlWeFo0cWVG?=
 =?utf-8?B?Tk1DTVVpR0hzVU95WlBoZ0NiTldBNk51ZDlaa3pONVJUdE1CdkxZSUdxbitz?=
 =?utf-8?B?R25EWlpwRVEyeVA1c0hPYnVub09RcU4rTXl2dHZBWEt2MnQrWFJqSE1VTDBF?=
 =?utf-8?B?ejVIMm83a1p6TkxkdWsrVTMvWGRSU0U2UDk3ZXlpc0RGc2VVbUQvUGR1Qis2?=
 =?utf-8?B?SzZ3K2poMUlDZk5NVjVmNGlSUWI4L0VQTTFzWFlkdjBZSXA4K0M3NFc5V0FO?=
 =?utf-8?B?Q3Q0UkROdjc0VmRtcjBuMDNxRURHQ1J5ZkEyeC9QV2c4eStXbmdaV1NUckZ0?=
 =?utf-8?B?eEhvUWcra3E4TGFid0lTNHcwNm9MVGNBMlpnR3pwWnV5YnpIWC9oS255enp0?=
 =?utf-8?B?dUg1YVE0dTZhdGF2QWNKUEEzaHFxMHJMaUQzWUovcDRKRkFvOXdhMEZ5a1Q2?=
 =?utf-8?B?YlljZWJWK0xObS9ucUlTQ3J5a0FlWS9HWHlacEtkcDR3aGQ4Vmkzck5KVXUz?=
 =?utf-8?B?cXVMa1ZURmJFY0tUekhIaW5hL3dvUGwyNHpOMCtxQzFiME1hNDM2bnBkRGo5?=
 =?utf-8?B?Tkg1QkZxT3U0ZTVqRC9ON0NnckpuVkdtazh6K0dsZ0hGMk9xc0FOTkUzNVpW?=
 =?utf-8?B?KzkvRVVqbHIyYUFyaUlYMzlHaFh2cGszMWFWWHA3Vnp3cEltQXNkQmN4S25u?=
 =?utf-8?B?MjE2bXVvbzRzNWdwOHV3Vkd1Syt6Wnk0T1ZqU3VoSHp1eVpHUGJBQVp1QWRK?=
 =?utf-8?B?TWdvR3I1ME4yWmNjNUlUL2c5SlRFdjhNRGowWVRPWE5aSmc4dmFHWlBzbVRq?=
 =?utf-8?B?YmVqNGVNYlVISnp2R29oa2tRUXZQSDl6dWZlNi9lOUNJeCt6Y3ZQR0JLZFdm?=
 =?utf-8?B?YnpDa2ZVWDBxOTFReVBpc3d4bXJ5VTl0UmxEclRXSDA1YjF1ZkdadjQ4b2hQ?=
 =?utf-8?B?RVlrR0J4QXZCdFhCL3ExeDVVNVl5UGltdUdkK3Fwc3VUZFlWWHJ1OEw5Z2JD?=
 =?utf-8?B?K1VuaGdZUElTcUR1eEhpZ3o4NTNoclRpV0lLa0RsWFNTVjdpZGlsdFkvNURY?=
 =?utf-8?B?bGJUSzdWS0FPZzFML3h1cnRmZTJsZFl0Q3dac0R1QzNIMjBqamtXTWhvOWlm?=
 =?utf-8?B?WW03QXdlbGpLbEo5dTloUG51aHlaZis3UGQ1MURYcG12SG9mQXd5V3FyNlFV?=
 =?utf-8?B?MVJwcW5NWGFqNWpUWHdZYzNGODY1eEc4TjBxanc2N1I5ZE1CWHU0YW05NDNz?=
 =?utf-8?B?dW1wZnF0cXI3WVB2SmtNMzJtc3hwaU43aUhhNlVWdWwvY0hQN29BNnlkZTd1?=
 =?utf-8?B?cGZZUDR6MERLRFo5akd0aTk0dzJ3U05LWklUbjRBOVpsVlVVejJsTUFWUFc3?=
 =?utf-8?B?dU9VMS9GUnEremROM1dKSE9Tcld3Q3BRMjczQkY4U2xUUi9HN3Y1ck1JQ2xJ?=
 =?utf-8?B?Q0p0UWJHalpmY20vTnkrb0dSVGZNVEtNUWtxRkExdjZhcnBWQWFxRFdJZnBk?=
 =?utf-8?B?K0Z2NlZRNjhURjd6M3pQZVZwZTB6a3Y0NzhsOE02TzJLT1NJRzR6Q2taVm8w?=
 =?utf-8?B?cGhESkUxYkZtcmkzSUQ2OTdHeHoxcUJPRnpYZ3lKbjU2NDVMRzJnQWhtTzRQ?=
 =?utf-8?B?Y3VTaS9xazRjR3pTU0RxQ2N4OHlkdXdvV2ozajZUYnh6ZjNzRlAvU25UWmVo?=
 =?utf-8?Q?x190WeLWS372O0PU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2036C218F42F8841ADA51BCA5C5ABB93@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09812376-9f07-4079-f846-08ded6571d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 03:24:37.7114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0306PTD9FDZDrSuklDO9axOYmHB1qnlb9Dis/Kt5fCF/wSv30o1IbGJvy0ZdNin8PqDWzaF0zvGNVMAGYI36MsNXTWi1TqMDCqW0a8nyxbAV2RMzxjWngJHKuJjgoq+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8918
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302930-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:dkim,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD6846E00CC

SGkgU2VsdmFtYW5pLA0KDQpPbiAyNS8wNi8yNiA5OjAxIHBtLCBTZWx2YW1hbmkgUmFqYWdvcGFs
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFBhcnRo
aWJhbiwNCj4gDQo+IExldCBtZSBrbm93IGlmIHlvdSBwcmVmZXIgdXBkYXRpbmcgdGhlIHBhdGNo
c2V0LiBJIGNlcnRhaW5seSBwcmVmZXIgYWRkaW5nIGEgTlVMTCBjaGVjaw0KPiBJbiBvYV90YzZf
dXBkYXRlX3J4X3NrYiBmdW5jdGlvbi4NClNvcnJ5IGZvciB0aGUgZGVsYXllZCByZXNwb25zZS4g
SSBzZWUgeW91IGFscmVhZHkgc2hhcmVkIHRoZSBwYXRjaGVzIGZvciANCnRoZSBmaXhlcy4gVG9k
YXkgSSB3aWxsIHRlc3QgdGhlIGJlbG93IHBhdGNoIHNlcmllcyBhbmQgc2hhcmUgdGhlIA0KZmVl
ZGJhY2sgQVNBUC4NCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L25ldGRl
dmJwZi9wYXRjaC8yMDI2MDYyNi1maXgtcmFjZS1jb25kaXRpb24tYW5kLWNyYXNoLXYyLTEtYjZj
NWMxMGU2MDRmQG9uc2VtaS5jb20vDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0K
PiANCj4+DQo+PiBSb290IGNhdXNlIHNlZW1zIHRvIGJlIHNhbWUuIFdoZW4gb2FfdGM2X3VwZGF0
ZV9yeF9za2IgZnVuY3Rpb24gaXMgY2FsbGVkLCB0YzYtDQo+Pj4gcnhfc2tiDQo+PiBzZWVtcyB0
byBiZSBOVUxMLCB3aGljaCBtYXkgbWVhbiwgY29udHJvbGxlciBzZWVtcyB0byBiZSBub3QgZ2V0
dGluZyBzdGFydA0KPj4NCj4+IEkgaGF2ZSBhIHRoZW9yeS4gTG9vayBhdCBsaW5lICM5MzMuIFdl
IGhhdmUgdGhlIGZvbGxvd2luZyBjb21tZW50LiBJIGFtIHN1cmUgdGhpcyBjb3VsZA0KPj4gYmUg
dHJ1ZQ0KPj4gZm9yIHRoZSBjYWxsIHRvIG9hX3RjNl9wcmNzX3J4X2ZyYW1lX2VuZCBhdCBsaW5l
ICM5MjYgb3Igb2FfdGM2X3ByY3Nfb25nb2luZ19yeF9mcmFtZQ0KPj4gYXQgbGluZSAjOTUwLg0K
Pj4gICAgICAgICAgICAgICAgIC8qIEFmdGVyIHJ4IGJ1ZmZlciBvdmVyZmxvdyBlcnJvciByZWNl
aXZlZCwgdGhlcmUgbWlnaHQgYmUgYQ0KPj4gICAgICAgICAgICAgICAgICAgKiBwb3NzaWJpbGl0
eSBvZiBnZXR0aW5nIGFuIGVuZCB2YWxpZCBvZiBhIHByZXZpb3VzbHkNCj4+ICAgICAgICAgICAg
ICAgICAgICogaW5jb21wbGV0ZSByeCBmcmFtZSBhbG9uZyB3aXRoIHRoZSBuZXcgcnggZnJhbWUg
c3RhcnQgdmFsaWQuDQo+PiAgICAgICAgICAgICAgICAgICAqLw0KPj4NCj4gDQoNCg==

