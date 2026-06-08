Return-Path: <netdev+bounces-296375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UZptOTdRJmohUwIAu9opvQ
	(envelope-from <netdev+bounces-296375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 07:20:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A119652CA1
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 07:20:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=Yh4ownvX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296375-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296375-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9519E300C81A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 05:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95116374178;
	Mon,  8 Jun 2026 05:19:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A5C371D19
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 05:19:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895968; cv=none; b=sM/r617XTyAglYtWWbQJWFrv3iw37D3eMJm0cGVzeVkK2mTbpNPHiLztZmsbKh/ykWkd6CSsShjkAjMoh+b5i92GiDcbdmiesFvbFA9CDgofE1I27Dt64oQI9zGRYQ9ZVqMieUSK3Ppjip4G4YE8mFmwF6C1r3OwI5R1ChNiPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895968; c=relaxed/simple;
	bh=jCuwD3L+UGLhoo+rOweV6Jhoe0yvuz2rrXEI9p2ZUHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=pnR2ypJ2HmijlrsNAHuthkoCtnvndUcdCT7G4IFXIhQhiluuZoAuMURL2jwCKnpwECVKo681Kw/qHXXTuPdrz5XHZiLmrMgctQc/J+HuwduiN697zQl0LaCz4Dhkv3W0qfSHr0RKpNebAPJBA9t2Mx4X/UqI3O3bpB4JtDno4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Yh4ownvX; arc=none smtp.client-ip=170.10.151.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780895967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCuwD3L+UGLhoo+rOweV6Jhoe0yvuz2rrXEI9p2ZUHk=;
	b=Yh4ownvXsd2FR8opMF2NSzDqnEk8Hr6zaaI/t8odn/OEVlaUZwUTF5X/uq5zs9E8U7/ecm
	suOYmkZ3z2m5MAKAZCLUGXQ03YNGCRY2EPL6lP7FOvs59kY6EZmW9/8PWE7MJUi2RiaM92
	jrMQhgJWz9fc+NgU78Ug6JpePMDekGUiropT9XZ1LDB0U5lRBsQfBAWodo10E5ASP1Xz4M
	Xci+PC5M3njzzCEev7MkM7iiAauXytZ/pOJ0gcQln24UbX3RFIpdgGp7OL1wlM2qZlix4C
	u5KkfFynO0nTceTUZrez6J0zeeJ+Rgy+MUb2oyNPhfvU4CFDmwdZ/TJeG1bUCA==
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-19-80Cshg8JNRCiDFGEn5QSxQ-1; Sun,
 07 Jun 2026 22:19:24 -0700
X-MC-Unique: 80Cshg8JNRCiDFGEn5QSxQ-1
X-Mimecast-MFC-AGG-ID: 80Cshg8JNRCiDFGEn5QSxQ_1780895961
Received: from DM4PR02MB9263.namprd02.prod.outlook.com (2603:10b6:8:105::12)
 by BL3PR02MB8001.namprd02.prod.outlook.com (2603:10b6:208:358::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 05:19:19 +0000
Received: from DM4PR02MB9263.namprd02.prod.outlook.com
 ([fe80::cce5:83d:e300:d648]) by DM4PR02MB9263.namprd02.prod.outlook.com
 ([fe80::cce5:83d:e300:d648%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 05:19:19 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Randy Dunlap <rdunlap@infradead.org>, Andrew Lunn <andrew@lunn.ch>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Richard Cochran
	<richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jerry Ray
	<jerry.ray@microchip.com>
Subject: RE: [PATCH net-next v4 16/16] Documentation: networking: Add
 timestamp related APIs to OA TC6 framework
Thread-Topic: [PATCH net-next v4 16/16] Documentation: networking: Add
 timestamp related APIs to OA TC6 framework
Thread-Index: AQHc9XdYqyenjPnuP0avpxdMHovoULYyl8UAgAEBGuCAAIWRwIAAAtWg
Date: Mon, 8 Jun 2026 05:19:19 +0000
Message-ID: <DM4PR02MB926359E157836590EF0B91A2831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
 <20260605-s2500-mac-phy-support-v4-16-de0fbc13c6d8@onsemi.com>
 <cf3d6937-1ffa-4d81-8e19-b3f607a7e1d1@infradead.org>
 <CY8PR02MB9249DA24FC3E3292FC2D7628831F2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <DM4PR02MB9263A6240C8D09E368B6F980831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
In-Reply-To: <DM4PR02MB9263A6240C8D09E368B6F980831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR02MB9263:EE_|BL3PR02MB8001:EE_
x-ms-office365-filtering-correlation-id: 93682136-362d-44a9-2aac-08dec51d7e14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|6133799003|38070700021|921020|4143699003|11063799006|56012099006|3023799007
x-microsoft-antispam-message-info: EqHL1PR1VoS/ua5fMkqLen3HqG4pf8uLtxUAdwlnw3nBYvP259jWA/WSqTYqOqJf+h+1zkM4OfYcCldAHOGWIJ/Skxe7EVH+34Ad7XE6hQTP8csuWZg2e6ctZrsrwv5UpnbbzPbbpnJwvhi6KOm6tuP40DeJeYo1fl59FXn4a1+QIMJFmX2hCia1ni5VocDHL9Sh6/7jIjwuSIq2oi5bs4IfAmIwh3YoG74l4QhCXBfhyTwgRMgAS/EZoAFd/uSzlDX6q54qpmwGGrUrM6m1pvnkpAuGpgWw0mN6/TDILSz/MkqA6bi2aTArjO3memCxK0n7dKZ8eCGUIAjifgFdwqhrymTt1At1agZnfP/nfXEZhUJH6O0qi1u86D2D3z4b0enntl1hl3wlBtbioOJ1ZTfNIIG9VwbN5dQKvpz1jYn5XbcFPMpQReqEV+lHLmFv13SE0hqLRwyT6gMp8YgaA0ugnuChS6GStwizBDW65cMitde/R171iYNxruf7N+JR0/bL/p+GxikEr2GwqgkbXjsljj1caaYdj+A9QN/xnHf+dD6aIly+muRfB0xbFG39B/wPjEg9Ih0Ya2i+jY4fKV1ly+ryY1wQm+VQAwjD7Y+yBsYzXdxfIYk7Hvetw+k4lHLW47PqhVP+ViG2dE2pJrI12d6Bvt6gq+udv9y1B+ISTq5gCvhoUL6NpzhCm2ui2g1CCNK6sxQL/mc5/di9RJp6G3i5/yD0w/rTSiPV6/eGJzzNLmx3MfCTguegY2mRo32T7514s0EFb61VwWTpqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR02MB9263.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(6133799003)(38070700021)(921020)(4143699003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWVtdWpVSVEwSVZtZ1NaMjhXL2wyUnJNcVFnaVU3RHdHS0lOT1FoQ2sxbHUz?=
 =?utf-8?B?YkoxakNIWXVFZXFSMllSY0tJVTFvWEc2cHZEQ1N4Q2dJa1hWdEVZRFdTcnJI?=
 =?utf-8?B?QzJXYkhzMVBzL1lVMlpXbFBqOXVaT012cXlBei9ZUXVpQXhMYWkvTzlZYkZO?=
 =?utf-8?B?ZkFJRTdhaldrcmxiM2toVmFqN3V0di9JdEFQZUwxOUpvSC9ZaWxpd2hWY0V2?=
 =?utf-8?B?VlRuY29JWWwwT2dZNEtBL2lONFlQM0hITWZNWUFlamtYSmVQM04za0NicW1v?=
 =?utf-8?B?QWZPWnpBdHJCSDNHS2h3b2NhK2xKNnhwNi9nOTBKYitENTFGbVF0aFhXdkt2?=
 =?utf-8?B?KytDRGhSNUxFMjRaNy96ZnJrNE1MRXJZWG5wWG5sYjZ3TGtIdHptT1NLc05U?=
 =?utf-8?B?Zmp3TVhMeEJ3bVdhZUVnV0lRazBNTnczYTNwbUpwZEU2RG96TWdGVnFSZ1Yz?=
 =?utf-8?B?cTNmZ2Y0V1R6Z0NxSDEzSXRvTlgrM1N0QlhBWFg4WU5wYUFCMGxBbWtQWDVT?=
 =?utf-8?B?VjZwb3FsZFJGV2RQUWpwbUhicllkcUp2YVJ5cTlZUy9zajhONVVyTkwwcU5o?=
 =?utf-8?B?UGo3QmFlTUJ4cDBDeTJvOUo4bU40aWxFalljdk00MDZEbEVGNHhlZ244VDBX?=
 =?utf-8?B?T2N2UUo1U29jZ1ZRQXNXU2VOUW50VVliM2ZGNkprSStPamNxQms3eFA3UjY4?=
 =?utf-8?B?ZERBVVZrY1pMY3M0OGF4WEdVRnMzUE1iZmc2OXh4c1R6VUdqS2RPMEdrT2Vl?=
 =?utf-8?B?N0hNSVlRc2hhQjFab1ZrazZQM0hKS2hMTWtiYnZzUW1yd1JxV2E1K3czQmNi?=
 =?utf-8?B?eCtUckY1WFNzQ0FEQWdHZ0NKYUNKUWJRMkFONi9KaStJbVZjNU1maUtaMGEv?=
 =?utf-8?B?NWlqUlorZ1JOZGxzQXhxM0ZIc0E2aDNTSkxPY0dLS1Qzd1Z6ZDI0UWtLU2E3?=
 =?utf-8?B?M1BQUDR1UmNMMXNqbVpsZlRtRnZNeE9ZK1hyT2NzZ0NreU1aNWo1MkFIWG41?=
 =?utf-8?B?K0tGNXBjZmpkZ3hweksyNnpxQ3BrRnpjeDlLSkJzVU5raFBwL255dU1DZTRG?=
 =?utf-8?B?NmZab2tESXpBV1hLa0FTaURIV1N2S0RLMGFHdTc3YlNMYWU2cUthVWVnTlFD?=
 =?utf-8?B?UWRxTFpEc3V4c0ZpK3Rwa21ac2Fkd3pZMVNodGZSY2w5dWtINk1ubWpzNWtG?=
 =?utf-8?B?TUtZakdtVXlia25hWjB6akVBdnNyNnFLZHJkUFlyRmZLTDNsSm9wZjZSTE5U?=
 =?utf-8?B?dTBkdVBWREQ3ekRlbWIrU0RuNHZwdTkvN2hBNjJYRkVPSTdSZnhGVGx5THph?=
 =?utf-8?B?ZDFlVW01SjR3Sm90NTc1dEhNSmFkZi9pbGNHckhTMHRjd1k0R0twSTlkZktu?=
 =?utf-8?B?b0lxdWo4V3ZVb2ZCclFFamV6N1RIWXdMV1JHak5IS0FVRDVSM3lXU0UzeSt5?=
 =?utf-8?B?TjJOb0xLOU9CUzR1aFdBbys3OFI4bm5rS3JnOUxoSVBLbWQ3R01VUThuVnkv?=
 =?utf-8?B?OTZUSWM2VzZhOGdVeVdUSmIwWFlqdmcwcWtYTEwxUDhJektlVmtWeHR5YnE1?=
 =?utf-8?B?cm1wVHFKNlBxRFQ4WFdnM1lNTlhnVThoa1JqanVBZmtjbmhPUlVPNlQ5Zlpp?=
 =?utf-8?B?eS9qanRYbFNiSEx5QU44VmVNbEY3RG1hckdjSEczeDlrWm96U0lYNlYvSlJu?=
 =?utf-8?B?ZlVwbTFsSVJUWVR2djJqbzdSdlQzaCtJTEx4T0ErN3dXdlNtMFpBY1kyQ1Yy?=
 =?utf-8?B?cElFQy95RFN1TWFpYjBTL3VpZWhLSXFnOVRVYUg1ZHdPOStGZUMva3ppZHJP?=
 =?utf-8?B?UnBZL1JETTNLejM1eWJGNnRjUlpSY0EzQVYxRzBaZTZCdUtDTHZzY2hxTnUr?=
 =?utf-8?B?Z1pUcXg2ZzJleTl5S0VVVkNHRDBtVDlzdmFKOUVnNjEvNkJNSFdoaml2QkVx?=
 =?utf-8?B?SExINDlMTzZHU3dRZlZ6aThoekFLV3o4UzlPNHYvdE1kdkRzUm95N1dtNWR0?=
 =?utf-8?B?YXdVTWovaDA3eU5oN3BYSzVQa09VdHdYZVZhQldaNWFLMFBsL2VFMjRIOHRL?=
 =?utf-8?B?UnNZMDlib1QrQjI0b0pibE1PM1ZaTHBjT3pRbGpVMFhtS1VrZ01tZjlxZW5N?=
 =?utf-8?B?Wk5WVmM4T2t4bTF0cmE3OE9lVlRBRjNxR2xJenBEZUZPVXI1UlNCcFVPQTFV?=
 =?utf-8?B?dGZLT1NvUHBwTnA2QVlocTZ4NVA0bi96WEJ3bFRZSSt1bzJ0bDU1NTdSYldj?=
 =?utf-8?B?SmlKQVdKUlRESDFXaDFuWUZ5cXFTanRLVFhvcXI0OHhEZXN6RmUwdTJjMmg4?=
 =?utf-8?B?VUd5ajdFczBDL0RlUVVtaHpTOUVVc2dTeXgwc2dBdWY3RkRTamRra21KenJ6?=
 =?utf-8?Q?ZzTtJyGBkGsuvjRc=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lS9U4Dzv2xIVF2w7gAsbVCFizefFSpwoxCyjHTHlXfQ5ioUgnDs26GtULm5ofGkNhv/qZOK78aNgc6oaSeem3r6qAFqP/13IJHmwuWRpElHyVEzNzqXAolGr2srpRHnsRvH5YWp5DdeIYOmSsP/zEntHarzHiReq5HSnj+0jeUniT9ioJB9MwoSTitbkH721neqnxXiPd7EEwFST9lRNDgT/In4ht2JYYcACEzAzxW2FPSTUP8QSgPuIg1eZB8bBhRKt/TXhwkIyFO2tgEHhwBP2n/7V9QMdfhVJPu3ZhYxkadV2QvHAGClDnLJaINTe7Wswgl9059A/NXO/jdHP1g==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR02MB9263.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93682136-362d-44a9-2aac-08dec51d7e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 05:19:19.2787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+83gN+Z+fnhj6CW2GiXBM7mtldiv+FrZBRcaXx0qZv1b6tJOjRF/hUytLB7qBP4aKXdqjyVSqeRHxL8BZIbUoiI5YhBKIUqU8kbP2EhZRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8001
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6-KwMrqfiZOQSU6-W5ga-E0fTGH3y65oyIwhJciyDmI_1780895961
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296375-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rdunlap@infradead.org,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[infradead.org,lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,DM4PR02MB9263.namprd02.prod.outlook.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A119652CA1

PiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggbmV0LW5leHQgdjQgMTYvMTZdIERvY3VtZW50YXRpb246
IG5ldHdvcmtpbmc6IEFkZCB0aW1lc3RhbXANCj4gPiByZWxhdGVkIEFQSXMgdG8gT0EgVEM2IGZy
YW1ld29yaw0KPiA+DQo+ID4gPg0KPiA+ID4gRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL29hLXRj
Ni1mcmFtZXdvcmsucnN0OjU1NDogV0FSTklORzogRXhwbGljaXQgbWFya3VwDQo+IGVuZHMNCj4g
DQo+IFJhbmR5LA0KPiANCj4gVGhvdWdoIEkgZml4ZWQgdGhlIGlzc3VlcyB5b3UgcG9pbnRlZCBv
dXQsIEkgY291bGRuJ3QgcmVwcm9kdWNlIHRoaXMgaXNzdWUgd2l0aCBlaXRoZXINCj4gIm1ha2Ug
aHRtbGRvY3MiDQo+IG9yIHdpdGggInNwaGlueC1idWlsZCIgY29tbWFuZHMuDQo+IA0KPiBBbSBJ
IG1pc3Npbmcgc29tZXRoaW5nIHdpdGggcmVzcGVjdCB0byBob3cgZG9jdW1lbnQgZ2VuZXJhdGlv
bi92ZXJpZmljYXRpb24gaXMgZG9uZT8NCj4gDQoNCg0KSSBzZWUgdGhlIGVycm9yIG5vdy4gSSBk
b24ndCBrbm93IHdoeSBJIGRpZG4ndCBzZWUgZWFybGllci4gU29ycnkgZm9yIGFza2luZyB0b28g
c29vbi4NCg0KDQo+IA0KPiANCj4gDQo+ID4gPiBTZWUgYmVsb3cuDQo+ID4gPg0KDQo=


