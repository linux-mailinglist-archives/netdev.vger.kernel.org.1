Return-Path: <netdev+bounces-298644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wPybIz8ALGpdJQQAu9opvQ
	(envelope-from <netdev+bounces-298644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:49:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E13496797BB
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:49:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=183AEF2P;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298644-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298644-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E67B344CA8E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A0B3E0C46;
	Fri, 12 Jun 2026 12:43:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B33D3D3482;
	Fri, 12 Jun 2026 12:43:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268211; cv=fail; b=XHKcs/thXi4jWQxS07R2EnwvjMzz2NlI5C1exM3ENCV7ViSQfJeJwb/5sVNtG0nC2pSRZ9jzuCnV/JN4yPB1mCbhqWYaxq7sP7UvRVV5HKBcUu2vSHeba5D2gXxzSyRBWtn7vATyf9vwG80WDQBRLmkpJZdurFCsrc7PlTnlC8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268211; c=relaxed/simple;
	bh=fa3m/UCHh7+ZyUQZsRTbPeDvRSb0iSWsGOyN/MgTWTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qB4EXGuQz7Oz0ZqnPS0/lhFFNukeQF/0uvkDFiv1mr23JL+owIod8jQNKjNJbnmcAMb4dK+mDqPX+4zUUBrnTb+4yDViC9T9+RFyUp+N314vqOI4h/UAnjAbAKulm1+1AifxMsp4JHf6RNKeBL/wvRAWn8LcsT451p4nl77DFas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=183AEF2P; arc=fail smtp.client-ip=40.107.209.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiokLJ+GUBPpR4UYjrWVNpR4RUogtNyWPUDyqaSZF/ovmSGzP3f3attsHSbr+HYDHksI/0HfQY7q6RliP1skYl2Z1la9KiKOqCyt80o+HwC9RLekKeBzKqQL4BhwM7Giw7jDr0znW8xjioSX6eNouiuEDfsi7WcZPirmj2ZsIJ9aiRSbZPZ3g7aDXpyUjJG2Bu/IRerx52VJTvvWcnjIBFt+eameHr0qE1UfTI1XQqJTcYiuwMOgF3i2eLbQFDI3hMYo1hOfPAPWdsSZkPl/H2+Gv9L8RVRMdEIULitUnRNaieJ6Mk49NHfEIvzGhWWhvy1Ia9as2BjE0al0HQCc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fa3m/UCHh7+ZyUQZsRTbPeDvRSb0iSWsGOyN/MgTWTQ=;
 b=B9NNLmbGFPPVGmOu3HBLVEK8aDgCugrh7DLF/ygcTmd6YCMjlHolVkQ9iFrVPk1FL0x//vuTx56O7OnDu3UT4BlvSsJKArQU8lIkFECN1qcUJY32IaLOaF/Z9Gj4OfajO8+apu/+t/YofTA6Qh0Ov7Sd7oWwjy3n+koZnWhLYUc6n7my/PVStQQehNOuN+yGYUvB03lTKJ1P78a8mjzy2iDDCAZ96NF1Q70obaA4th+RdFa9DX8PYRvwUkA99CbocdwOtsOoVoQkobsJXM/gsu+ng9L2dimUXZw9fz4myZTlHdp7oOatnRbNHibmjqu+pyMXuiuJ5BTCntpX7bomaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa3m/UCHh7+ZyUQZsRTbPeDvRSb0iSWsGOyN/MgTWTQ=;
 b=183AEF2Pol+zFSvFYfbvX4F1MtTEDC3ZCfA+Cs5aMTP58cCOGruBBKVmRMVAr4ePEKXfJPPqvjzhRXLHbW3M+VARPeJY+oSJShycEuy0YoIXOOaQWn5kMm+fJ3Flh3U7g83nwilnPC3vPWM+emjxIWD/0QGwegLGdymkgv2DV6K+3T+SeLALDxkakQxwfQFWPgWeiS+xrhiJn/uMg36wf09jN+OBUuoDsat6o45zBmEMQLQrWFrGvUC/sfy/TdohZbapnAu8H8cWcPx/ggr6c7yLrBmL5HmEEZfLFdDAD4co5ipJo1MeT1YfJK5Svrzk4DBKM+uiqXXj8eN1I0WlJA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CY8PR11MB7362.namprd11.prod.outlook.com (2603:10b6:930:85::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 12:43:25 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.21.0092.010; Fri, 12 Jun 2026
 12:43:25 +0000
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
 AQHc8eDGO4Y2rMyEmEeRgmYw3vsZ4LYrecyAgAAPEwCAAmo7AIAAlNuAgAAUz4CAAAajgIAFcz6AgAAInwCAAd4WAIAAa50AgABI+YCAAq8HgIAAFswAgAB/p4CAAPbzgA==
Date: Fri, 12 Jun 2026 12:43:25 +0000
Message-ID: <5f1d65ec-e1f6-41e1-8dec-5b20cf9f6ed1@microchip.com>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
 <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
 <CY8PR02MB9249E607ACBF3A05AB83ABF683102@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260604-swimwear-garnet-3eb092e6fda7@spud>
 <4df9882b-3426-4c36-8048-0c76d0f11c74@lunn.ch>
 <7c68173a-ebff-42cc-8519-95e8365805b5@microchip.com>
 <DM4PR02MB926317F64B5A3827009B66A9831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
 <a02cd86e-a5b8-481c-a07e-7243ee537b24@microchip.com>
 <CY8PR02MB9249EC4F3896121911D0FF3C831D2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <CY8PR02MB9249B913E28E285EB46EC59C831D2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <56e6c9ea-2e2a-406d-b7d0-ec484e3170e6@microchip.com>
 <CY8PR02MB92498B8CC2E0A3B50908C510831B2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <CYYPR02MB98285C570F545729D3ECFB35831B2@CYYPR02MB9828.namprd02.prod.outlook.com>
In-Reply-To:
 <CYYPR02MB98285C570F545729D3ECFB35831B2@CYYPR02MB9828.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CY8PR11MB7362:EE_
x-ms-office365-filtering-correlation-id: 377ac14e-c97c-485f-21e1-08dec8803222
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|56012099006|11063799006|4143699003|6133799003|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info:
 N7l3IOhbvxwZzK+AG89AJQugYeRX4Nnp7n6ZtzPuepH2QylGh8EPmEhItuPqCuhWyShRiqTaCnF6a151SXTLsZB909Zs3jjC/Cmkr1or8MR5JxicAZHGlsL835eCsUle6+qidefLXhF4+ewJgnqack3pQA19UZnjydn3Z/pOVujFPw15N7t6GqULQ8f87yskfOk+oHc4kxUGZnV+KoqlCl6RoEjuG3QPnaex+T4ZGMVnaHCGJkvsjCZxBg+RXlYR6u8gVL7Sd3znlWe28yQmaOsJrx5aJ6BScjFJWApGEiPfaMwQQnuaFCqyFyLRBHQWtpXy7vVdD5vbECa+Wc2lLVSJleKGZ/hw5ycmz0o0lmXbopg1HEguuegjsxNZMXWlBA7gau+J6OOlhjKYQaHGnOc2hcBy3snuZgyG77deqrkfofKcZOvKnrQSNfh7xIojniBQ7hZRPjXvn4s+1VEogeZUy5ojqKQQxjR6J87Rk8snF7c8FTcPn1G2LUGrhrkEPN/yBeNtHHu1VB1eXgbH8F/09Q4LWp7l5hKyGYjzXkdm3CfKaqnk1ZclAzuA5dWBS7QTttT+57AAxwqFQ3KybJeTktRi7LoYyFQBvWluqP92Jvu0Q4/LVhxPZtSQKPWOp6NDG+KaMYCNWXxx27MMjazw7yDwASGlCF7+Di9dJUBkTqUpDCLWrG5Bs7ReCCdRq4l5vSiP1IPGBQk9hIbaDQ4kLavjSKIcEWqN5irmXDHlEn2dh7q9MJbIX3A1x+7N
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QndrM0w2eXR6VW5ETUhoa1ZaNEg1cWRuNjJmVUxsbEtGY2hyWVlqSnRsRExW?=
 =?utf-8?B?SzlMQU5ybm9EUWhya0s4NkEwZnRUNnVuNlZiNThmMk1IV1N3QzBCTjdqT0s5?=
 =?utf-8?B?RzA3WTFPR2RIa1EwMFhlSFlWQjl5RWtiODNtV0YyV0JvWWRERkNXSlIreWFY?=
 =?utf-8?B?dmtjWGNoYUpuSll0WnZUaFBPQUZGZWpNOFJ0ZHB5V3hkYXk2L1lTRDRUZnZJ?=
 =?utf-8?B?OUNFUkJ2YktybWhNajU5WGw5RE1qdVhhSWdJQVViQnJQZU8yN3c3dFBVNVBR?=
 =?utf-8?B?R2phZE16am9hLzYrL0lQeHQyTEV1bUtobiszZUFHRmFqa0NkZGdOMGptbm5Z?=
 =?utf-8?B?UXdSQzQvaUtaT1VXbW1JUm8rMytWNHZLZVA5YU5wMG5JS2JJazl2dTlKTWQx?=
 =?utf-8?B?VGN2NWZ2amFWVDQramNiY0pmaUJNOE1kZmMvd2tyWGJBaisxSld1UzRVbW5a?=
 =?utf-8?B?dmpQZC8xU3FXQ1c2RjVjNTlSVzh0Y29UeVc1UzZWSmRBcStST3lQOTR1cC90?=
 =?utf-8?B?eW5yeEY3RHcyZ0Z4Tk15RzY0VjZDZUVxVENCbDR1R2dseFRtWW1TbkhLckEr?=
 =?utf-8?B?Z3pZaVZ1SzdLV3NWSnVIR2VHT0NhZFEwN1FtL0tXcG5HRzB4QmZXcWRlUEZ5?=
 =?utf-8?B?YTA5Q1pmYWhQVEE2dTY4L1lPUHhOUmo3WTdUNjNtWFp3YjVUYi9lQkd6QzM1?=
 =?utf-8?B?Q2VmdGRiWlZYU0h4L24xbE9NcFB1NFl2alExOEdaT2pEaVcvdmY0d0tFS2t0?=
 =?utf-8?B?VVBVUFQxMzFVc09CVTVFeWhOUnVEaitObFQ3bUJqR2hmSjBaTVdtL2d2RmRD?=
 =?utf-8?B?Tm5hamM3TVpVQUdIN1JPZ3RiOUIzVUU2SU9LNGpuOVNQRWdZeWI1d0tvUm8y?=
 =?utf-8?B?aHVIeVR1R1pCejZtcmhMTndwSXQvV3BQSEoreUh1NlYwWnpCR2t6SjYxMGVW?=
 =?utf-8?B?NjhhdENQRmJZR2RBSWdFVlNaTmlkdWVyanoyWjViQXdBYk5qa2dZQ1kyRkhV?=
 =?utf-8?B?dlVPenlSS2JxcW1ERDRFQUh6bW9NTmw0Q3l1TDYvNFVOV3kwTVhYRWl6cUtC?=
 =?utf-8?B?c0ZvODFMTElnYy9iRDZSUW5zMjJPY3BqZS9TTjNtVXlvN1NJNUJZQ0xiWVZM?=
 =?utf-8?B?VUs2RVFMeEdTMHlncVQ1dldDdDQ4STB1ZGhEeVh1UEZQT0psK3JxVE5TdHBi?=
 =?utf-8?B?b1dvT0N1eGF2MFN5UVN6VjhTNm9UUEtiNVV0RkRONExRaFhKY2l1c3VWVFk2?=
 =?utf-8?B?Qk5TWDVwVDNlU3h0U2lNNkd1dG5EVmtsd0tlYUNVL0NCbnhsUVBqZllCTnFm?=
 =?utf-8?B?bmZSNUhad2sxTjRrR0FhbHpuelBVNlR1UlVaVWE2Tm5BY1duUnFHcnBjZjhY?=
 =?utf-8?B?SkF2anFQWG8vdm1YRldpbU9FR2RnOXpEYTFQQzNOSm9JYlp0ZWdrWklMSWJO?=
 =?utf-8?B?SUp3UW11Y0tQZHhVcDRvV0pPZG9rMkdpQ2JUSlo4OUpacEJXeGZNeWw5ZHdK?=
 =?utf-8?B?NTBKMnNFdXB1a1FGMkFTYThEV0NSSlI2Ynl4cE1tN3dHU2UzTkp3RUNuRU14?=
 =?utf-8?B?cndsWis4ZVhnelViYThpcStJV2dOUVVVazVOTklDNjdLUytUb1U3bTlEaTlz?=
 =?utf-8?B?Y0xET0l4NzlTZVpTeHVQTktEdVd2ek5sZ3F0dXRHQitqMXFhTzFuWCtCRERv?=
 =?utf-8?B?TFVUM3I1SmJ5L0FEWDlyMkErMmQ4eWwvcjcvY0lZY2J0QmJYRk1OV1NRTFQw?=
 =?utf-8?B?ZmdkazdVUytzZGtWbFJxdmlGZW54dGdvVFh5WVlYekEva0U0YnhtemVVcTNG?=
 =?utf-8?B?VjQ5ZzRlVkZFWkNpenhPR1NraXFkb2IzU2swRW1sZFJtZlI1eUk1K1FkU2gx?=
 =?utf-8?B?MXhlYkluZDJSSGFldEExLzc2MFBVcVdiV3RzdmlHNkNLR0xxa3BGUzEzakdm?=
 =?utf-8?B?THRHKzdCMFVzN3E5K2tZNzkvYVBaZWNub3ZyK0tmVWVQVW1YdjE2NWloNW5n?=
 =?utf-8?B?QU14VGk3QVlXS2llcUFXa0pMWnc0NjlwT2ttd3V1VUZkbVRaaW9MYW9wVDlr?=
 =?utf-8?B?QlhRcUx2YkhUcjg1YlpucVV0eGcvcVhMbzUvODZuVU1ocXpsNWx6UVFob3Zo?=
 =?utf-8?B?bGwrTFBoamhDRzBtY2ZINzlrOVV5UE8xMmQyTFFldkJHT21YTENwL1BJN0JK?=
 =?utf-8?B?Lys3Zm9NRzNQYWxRKzMzT0Y1VGNsT2E2cUJoTGFjN3dmVndRQ3B4c0c1MDdl?=
 =?utf-8?B?cEVYZWhJU0tQK0ZPOTFYTTdQaEJHSkJpTDM2UVRpN21EZ293QWF4bGxYMTVV?=
 =?utf-8?B?M2JsUFdjaHB0Sk9kKzgxVkF3YWlPcmRhTkNiRFBpUzk1V1pObG5LSjdSZkxu?=
 =?utf-8?Q?ATrj7y/LFvq50WEE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8DA644B9E6A4A499716FF1939249C19@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 377ac14e-c97c-485f-21e1-08dec8803222
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 12:43:25.5614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iq2adh6QSIZxjZ8rtkdWbvdU3GczQ4khmpchK9Dlq1dQkI1M/Ug+1ebQhQdanYvnWDe3EBCCWborYBwgR8UpAe9AjYqBsVBPdgrf5iVe/+GY3ObHWM2SSPFI10PpCHBx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7362
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew@lunn.ch,m:conor@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298644-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:mid,microchip.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E13496797BB

SGkgU2VsdmFtYW5pLA0KDQpPbiAxMi8wNi8yNiAzOjI5IGFtLCBTZWx2YW1hbmkgUmFqYWdvcGFs
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+PiBTdWJq
ZWN0OiBSRTogW1BBVENIIG5ldCB2MyAyLzJdIGR0LWJpbmRpbmdzOiBuZXQ6IHVwZGF0ZWQgaW50
ZXJydXB0IHR5cGUgdG8gYmUgYWN0aXZlIGxvdywgbGV2ZWwgdHJpZ2dlcmVkDQo+Pg0KPj4+DQo+
Pj4gT24gMTAvMDYvMjYgMTozMiBhbSwgU2VsdmFtYW5pIFJhamFnb3BhbCB3cm90ZToNCj4+Pg0K
Pj4+IFRoYW5rIHlvdSBmb3IgdGhlIHVwZGF0ZS4gSSB3aWxsIHRlc3QgeW91ciB2NCBzdWJtaXNz
aW9uIGFuZCBzaGFyZSB0aGUNCj4+PiBmZWVkYmFjayBhcyBzb29uIGFzIHBvc3NpYmxlLg0KPj4N
Cj4+IFBhcnRoaWJhbiwNCj4+DQo+PiBJIHRoaW5rIGl0IGlzIGJldHRlciB0byB3YWl0IGZvciB2
NSB0byB0ZXN0LiB2NCBmYWlsZWQgaW4gQUkgY29kZSByZXZpZXcuIEl0IHJhaXNlZCBzb21lDQo+
PiBpbXBvcnRhbnQgcmFjZSBjb25kaXRpb25zIHJlbGF0ZWQNCj4+IHF1ZXN0aW9ucy4gSSBoYXZl
IHNvbWUgbW9yZSBjaGFuZ2VzIHRvIGFkZHJlc3MgdGhvc2UuIFdpbGwgc3VibWl0IHY1IHNvb24u
IFlvdSB3aWxsDQo+PiBoYXZlIGl0IGJ5IE1vbmRheSwgaWYgbm90IHRvZGF5Lg0KPj4NCj4gDQo+
IA0KPiBJIGp1c3Qgc3VibWl0dGVkIHY1LiBQbGVhc2UgdmVyaWZ5IHdoZW4geW91IGhhdmUgdGlt
ZSwgdW5sZXNzIHlvdSB3YW50IHRvDQo+IHdhaXQgZm9yIEFJIGNvZGUgcmV2aWV3IHRvIGJlIGRv
bmUsIHdoaWNoIGlzIGZpbmUgdG9vLg0KPiANCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L25ldGRldmJwZi9saXN0Lz9zZXJpZXM9MTExMDMwOQ0KVGhhbmsgeW91IGZvciB0
aGUgdXBkYXRlLiBJIHdpbGwgdHJ5IHRvIHRlc3QgaXQgYXQgdGhlIGVhcmxpZXN0Lg0KDQpCZXN0
IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gDQo+Pj4NCj4+PiBCZXN0IHJlZ2FyZHMsDQo+
Pj4gUGFydGhpYmFuIFYNCj4+Pj4NCj4gDQoNCg==

