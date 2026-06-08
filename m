Return-Path: <netdev+bounces-296372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 54WdJkZPJmqsUgIAu9opvQ
	(envelope-from <netdev+bounces-296372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 07:12:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F753652BC8
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 07:12:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=Qq2NzrDk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296372-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296372-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F3E73002D14
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 05:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2301C352024;
	Mon,  8 Jun 2026 05:10:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7859135202C
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 05:10:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895440; cv=none; b=WMYOq3sgbvvFhlJ/G+mjsxisFdv0MLnqDmkMn1pUMlcm4TKJfR+wsTsVtoOixosoOuHRvavDdqbv0YYW2X6RnkiBYkIjauJgqZXPBp4eaR7Xkra23vHaA5X/cYkVMdXJW3VlyQ8B2EP0/LGixgCznw3MW0b1aLkB+U7TGom3qqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895440; c=relaxed/simple;
	bh=yJsrBieusQ2FL94OLFeCVAEGFIXU9Yxu4gATVB/yQZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=do6ieuaFORPEDCzidjqS6S1c/uBY0jFqhUhoR/DGZCwEu6fIo5gyXfVgwZSdkd1rMqFqMcn3KXmXeNgGvVLwFZBycQp8u2ZwnMrQc+YFoU4RdZcXmHaQVNZ/i5Bo2Uv1RhoVemxeMEhY95if69A5mUlke+8lUIsLYmFiigSoRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Qq2NzrDk; arc=none smtp.client-ip=170.10.151.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780895432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJsrBieusQ2FL94OLFeCVAEGFIXU9Yxu4gATVB/yQZA=;
	b=Qq2NzrDkQ2wKRp9ZKvlug8hPbpvV2LgIrpAetrxiKF/NFjB3GQW7SiGniSCw5Suje5D3l1
	IqXhq6IBS24TmPJKDTDXrW4/F9gRVMmgPTonHwhP9kgyuWgwYJk/suJyl72VZq87pO9nRE
	5PtIsnJ1x3qupFeWYCvWuSiq+rXhNN1b8qVY8goqeLcarbcWckBgnfYHMwpKs6LNLd94Nc
	oTUJmSZJOHzZ2tIgtKEbEBZnLM0B98kc1SwSti2xJIeAgrAcfqX6I6rKJJJiX/4ny5Npoi
	IBTt+thWgZcf5ioGZJzEXFwlxCU+aayZaZElcUzRYr+wDzQDNP275b873qJaEA==
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-43-tWJ-tu1VOwq8p0SKLbFsEg-1; Sun,
 07 Jun 2026 22:10:28 -0700
X-MC-Unique: tWJ-tu1VOwq8p0SKLbFsEg-1
X-Mimecast-MFC-AGG-ID: tWJ-tu1VOwq8p0SKLbFsEg_1780895425
Received: from DM4PR02MB9263.namprd02.prod.outlook.com (2603:10b6:8:105::12)
 by SA1PR02MB11363.namprd02.prod.outlook.com (2603:10b6:806:4db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 05:10:24 +0000
Received: from DM4PR02MB9263.namprd02.prod.outlook.com
 ([fe80::cce5:83d:e300:d648]) by DM4PR02MB9263.namprd02.prod.outlook.com
 ([fe80::cce5:83d:e300:d648%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 05:10:23 +0000
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
Thread-Index: AQHc9XdYqyenjPnuP0avpxdMHovoULYyl8UAgAEBGuCAAIWRwA==
Date: Mon, 8 Jun 2026 05:10:23 +0000
Message-ID: <DM4PR02MB9263A6240C8D09E368B6F980831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
 <20260605-s2500-mac-phy-support-v4-16-de0fbc13c6d8@onsemi.com>
 <cf3d6937-1ffa-4d81-8e19-b3f607a7e1d1@infradead.org>
 <CY8PR02MB9249DA24FC3E3292FC2D7628831F2@CY8PR02MB9249.namprd02.prod.outlook.com>
In-Reply-To: <CY8PR02MB9249DA24FC3E3292FC2D7628831F2@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR02MB9263:EE_|SA1PR02MB11363:EE_
x-ms-office365-filtering-correlation-id: 2d2b2a1f-1765-4992-d6a5-08dec51c3ef0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|3023799007|11063799006|4143699003|56012099006|18002099003|22082099003|6133799003|38070700021|921020
x-microsoft-antispam-message-info: F85Q06jdUeGwl/EthvvY5RKERLQ8hzy7cK83zA+i4h7Y4NW2PC4c9pc2QRjkPS7od+7MT27HprADExnydgtEsaGAKMLsf301WWZ5aJeTGQS9BBaYIYeHZhIieP1JjHiVxKtNIzqgeXnimloFjbzO/XarBI2tVbA3IWJXW1bXBWJ6DlVCDDbl8kF5GcSyZahqi8xpbzcSSWhgPQrP+AJtk2F+Y+omgPitqo0xwwE+k/QVDjYFrHnK2kRXcCacA4vSgoht+bQi0WIEFuOeQpOf7mXeCHYgff7bwHmZR48042XiLCt5zs+zdc+eh4EH7H0xeQ36bKc9lOzX7O6/E7vcp5GisWGt5pwa8ZDg27B9frO4hxV1rJJOOVWJjzrMcKMjqIlc00cPvdDsR5eESloo9lv6fHl5ZILLI5YKe2SJVhJTSbaOlrJkBqyjruW119603+miEddF0v3ErRHSChBHOxnpVOapM5dCc1ZRGUrr1q8OVcQaFTqryWOy0dat0eFwyTYNoKnDP6xujRW1ylUqO0A10fvZtPBnj31f3davbaL67zdZQYfz7LWG7FYEDFBjqMiV2aH4N/xjBj2IbkOpFxy5lfdv/B+k/xm9abemA+sjlaCMomvzgtTSc1n9PBozcItGTZ4dRjf59OftzZXrnJa9XrB/z88qzXvbHDGv/IX4gi0fRkgoXNhfXDvHzTQcDJ0Op/NvFKoMvgOB0esXguhqh4j5xIVyPCry3qOsziYB7/wg0ABsrg9uHQ/qksO10g9UXqLCxaJQmTOp0ONx+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR02MB9263.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(3023799007)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003)(38070700021)(921020);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFZacGVPaUdCZWVWNFpna0c1U29wMklPdWt0TDN3dVNCQ1p4emR0UE4vZGR6?=
 =?utf-8?B?NnFNaEdrV0xUZmJkUElFOFNvTUNoMk5MbE1hZVZLLys3R3E2cWhKZTNZU0xF?=
 =?utf-8?B?eENNOFNBYzUvTzZtTE93aTROM3JJLzBXMURZQitsdThUUzg3d0t3bVV5eVQz?=
 =?utf-8?B?N3AzZ1FXVjdsT2JZUER0WmpheC82SGlYV25GYXRNcGIySXNVSklOVWxBTkpi?=
 =?utf-8?B?Zy82M0FGMW5YUEtYcjFacEY2anhZMWlHZWNjYU5uY3BXMndKdy9OUjJUb2pm?=
 =?utf-8?B?eEh1dGhiVGZxK1VJaGdFZ1YvbTlKTWE4QTJLVEpJaExUY1I1cDRRQ3BGU0Ri?=
 =?utf-8?B?SHlqdCtFSTZHaStoZmZ0bllUL1Y4ZGJBYy9hOU9oQTk0VGsvU3Jyb3Y4ajdJ?=
 =?utf-8?B?cE14VThUQkVrUklLVlc3WFJCNG82bVlqVnBMdnFxQlhOQitIcHZ3UTIxSng3?=
 =?utf-8?B?TXJWaFVaMEU5My9pVVpmbUI0RHdWUWlhMUttbllPdmZxTWhKMjFGL1VBMFdi?=
 =?utf-8?B?K2xIV0VjeVZ6b0JCbHJ6UzJJR1lkeWpvZjFzdnlvajVtNlhvUnBlSVBqOVlR?=
 =?utf-8?B?eHZhL1RCVHBweVhUWlVrWjFHQS9TZFBTL3ZzcU9Sc0FRRVhoYUROMUVoVzU4?=
 =?utf-8?B?TWpvM2Uvdjc1eVkxNjZFRjQwaDFhKzJHWGFENFBPSTNBYmJqWktjM1IxRndt?=
 =?utf-8?B?NURhYnduSW9Gb0RkdlR6UzV2WU5jVlFoWGZiV2twTU5nMG1OeXh3VHBoaCtL?=
 =?utf-8?B?RHJGZHJCQkJGS0xvR1R6ZnYzOU5yQzE1RXJlWExKQjZLajJ6cEVSQnVlaWky?=
 =?utf-8?B?bERScDM1ZkFKeFBTcGp3Ykh1U3dwN21kNTg4SEh1bEplVWhhYWIvOW9sL0hy?=
 =?utf-8?B?dGNQZWFDQjg0alBGRm1BaDIxNTNZdmRLbmdNWGFlRUxjdlA5dHh5blVPSE10?=
 =?utf-8?B?Vnp6eEFxd1RaYW1sODFDTmxLcXlKVVFmejdRaDByWGFMNm9oUVViU0dDOWJl?=
 =?utf-8?B?WFl3S3VKdVpjSk13SWNFZDYrY3kyZFpoY2k0Um9yaWhPMkxlSW13aTl1b2NI?=
 =?utf-8?B?WEZWbkRvSzNGd0QyUWh4enVZL1NaNEExS2RIa08wQm1ZUGRaQ09Mbmk4WVVH?=
 =?utf-8?B?dWhQS1I5L0JSOFNRQmxSaVF0RzhiTlo3aW1FYys5emNsd05sdXBrQXR5dXhk?=
 =?utf-8?B?VmtnOERTMWdtTnJFYTB5YnV6bi9JT2ZQTWNuOXZYQ3BFSzU3MlB6Y1ptMnY1?=
 =?utf-8?B?NXJQbHBTcThyaTk5Y2tMZGhYb2R4WU1Nek5MQnNrYUIxMHk1UnMycXVQUGJW?=
 =?utf-8?B?NzNPODdlV2tVVnJRWHRhUHROS2l4SW5DYnowODc0aERHNE0xSzl1Rk81U0t2?=
 =?utf-8?B?eGVaL3ZLZGZOK2t5eDJoazVCR1VJWTR0MDlEaTczMTlQSmRYMktaVXJiUENv?=
 =?utf-8?B?TWtVZTBOSUJ4RWZnSXpMc1pqemlqekVFVEZqVkk1b3NvYW1jdFozUk5PVGlJ?=
 =?utf-8?B?ODNUZzdvNE00MlNFYk9lcXRVSHZjQXdySDRLc3kyUTFhZUh5eTZ0aWtmOEQ4?=
 =?utf-8?B?aXhZWWplWWpVc3pWTFdWLzF1U04wZDIyQkVQZ3Q3cXlBR2NldjFHL2Qyb1NU?=
 =?utf-8?B?ZWg5R20vUE5KeU90RG14S2dLcUw2c1BKR2pVMkVyQkM4SVNYWUxjcktHSGln?=
 =?utf-8?B?TnJKOW5QM3FWWFBFWWV3cC8xTWhhdFBMOFZ3bkx0OVlTbXhTN0o3anFiNTB3?=
 =?utf-8?B?NlR3azEwOUtLUTVyU0o4aHA4Tzk1TFNScFNTdFdQNU94T0FrUFJaeFo4ejN5?=
 =?utf-8?B?S0E1R2lQNUxId1g2TmhJMzZEamxUQm1IVzZBd2xkcHRHMVM0enE1dHdhZW81?=
 =?utf-8?B?OGNQNFhLY1kwc2pCd0IvckJkbFk4U2JSc3d3Z2I0TWxkSndGQ3RHMFVlczRS?=
 =?utf-8?B?dGxrQ0F4ZDNZMzI0Ym1xMEMvcnJRbUV6RmRiQmtINEIxU3lMdWltVnFUOXJ2?=
 =?utf-8?B?R20xbmFucUt3SlQ4c3RWM2YwY1JKbkNlNzNHeE81VmFVa3dYWndwWWpCbmM2?=
 =?utf-8?B?OGNRMTJucVd2NFdrVlZrZ2k5RW9LdVZVcXlzM29NYkk3cFdMUWRmM1lqQ2tm?=
 =?utf-8?B?L3Z2RW5pK1gxZC9kTENoQ25pengzejBoMnM1R3VEb1RvTzhIV3J0aHVYTFV5?=
 =?utf-8?B?bjdNVjg0cy80Y2cxTDRhSUsrOWZ5VlJoRVBsZU5oTi9KY3A0NXkxZEhTMUl4?=
 =?utf-8?B?WHFNTUhtd3FpaWhWZCtKcmx6RVR4RlQxL3NNL1NaNFo0dGl0RXpvQTZrdHg0?=
 =?utf-8?B?b0gvclhaU3ExcUlNOHJDZkxJdHdjR290V3NHaW1LQ0tIa2ZFYXdNdz09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: e2GrwnFvuXYxwdWkPf5F0sP0MyI9ge+z/qWvJ8Al9v0h+aMDeXgZgJjlF1ht4abG5EDzMjCC0nB1rgP1cxq6q8fdJC3jbQPw27oGV/hd3FzTMcGqvn8bLPJ+4pOernFZ0y6+ANi+Pm8yKNmVV3Qn5WO5FlOUIj/jwaJFk7Sn3JHNFf3TLSUT8R41GFO/+4VcfcavUxmTo/oQhUVX605LD3Vj5BCDZ/J0rNklFohD3TtpwBBBL6KF96SNtfE+m8AgThGQ9W8v+FOsbiCgCwm1CNjHGeAuUgBwrdunM2sp0v65SOynyOTU501PK90varL3QC36ZLROEBgbz44ON8RbzA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR02MB9263.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2b2a1f-1765-4992-d6a5-08dec51c3ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 05:10:23.8878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1wWyb8hhW/Sl0pJOsjxsTlPQRTbKYjYkLDNh80VEsfGyBXFl+sCNh/ueIQAlScGOBoV69c8HFogQFUdXaMe/2sMw5s8J0liNT4KID3wETM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB11363
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cXXhIDbucuMNiaLDNRKTpjWCorjmeuprGXvcYlG3KeI_1780895425
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296372-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:from_mime,onsemi.com:dkim,DM4PR02MB9263.namprd02.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F753652BC8

DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggbmV0LW5leHQgdjQgMTYvMTZdIERvY3VtZW50YXRpb246
IG5ldHdvcmtpbmc6IEFkZCB0aW1lc3RhbXANCj4gcmVsYXRlZCBBUElzIHRvIE9BIFRDNiBmcmFt
ZXdvcmsNCj4gDQo+ID4NCj4gPiBIaSwNCj4gPiBUaGVzZSBuZWVkcyBhIGZldyBhZGRpdGlvbmFs
IGJsYW5rIGxpbmVzIHRvIGF2b2lkIGRvY3MgYnVpbGQgd2FybmluZ3M6DQo+IA0KPiBXaWxsIGRv
LiBNeSBiYWQgdGhhdCBJIGRpZG4ndCB2ZXJpZnkgd2l0aCBtYWtlIGh0bWxkb2NzIGFmdGVyIGVk
aXRpbmcgdGhlIGZpbGUuDQo+IA0KPiA+DQo+ID4gRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL29h
LXRjNi1mcmFtZXdvcmsucnN0OjU1NDogV0FSTklORzogRXhwbGljaXQgbWFya3VwIGVuZHMNCj4g
PiB3aXRob3V0IGEgYmxhbmsgbGluZTsgdW5leHBlY3RlZCB1bmluZGVudC4gW2RvY3V0aWxzXQ0K
PiA+IERvY3VtZW50YXRpb24vbmV0d29ya2luZy9vYS10YzYtZnJhbWV3b3JrLnJzdDo1NjE6IFdB
Uk5JTkc6IEV4cGxpY2l0IG1hcmt1cCBlbmRzDQo+ID4gd2l0aG91dCBhIGJsYW5rIGxpbmU7IHVu
ZXhwZWN0ZWQgdW5pbmRlbnQuIFtkb2N1dGlsc10NCj4gPiBEb2N1bWVudGF0aW9uL25ldHdvcmtp
bmcvb2EtdGM2LWZyYW1ld29yay5yc3Q6NTY2OiBXQVJOSU5HOiBFeHBsaWNpdCBtYXJrdXAgZW5k
cw0KPiA+IHdpdGhvdXQgYSBibGFuayBsaW5lOyB1bmV4cGVjdGVkIHVuaW5kZW50LiBbZG9jdXRp
bHNdDQo+ID4gRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL29hLXRjNi1mcmFtZXdvcmsucnN0OjU3
MzogV0FSTklORzogRXhwbGljaXQgbWFya3VwIGVuZHMNCj4gPiB3aXRob3V0IGEgYmxhbmsgbGlu
ZTsgdW5leHBlY3RlZCB1bmluZGVudC4gW2RvY3V0aWxzXQ0KPiA+DQoNClJhbmR5LA0KDQpUaG91
Z2ggSSBmaXhlZCB0aGUgaXNzdWVzIHlvdSBwb2ludGVkIG91dCwgSSBjb3VsZG4ndCByZXByb2R1
Y2UgdGhpcyBpc3N1ZSB3aXRoIGVpdGhlciAibWFrZSBodG1sZG9jcyIgDQpvciB3aXRoICJzcGhp
bngtYnVpbGQiIGNvbW1hbmRzLiANCg0KQW0gSSBtaXNzaW5nIHNvbWV0aGluZyB3aXRoIHJlc3Bl
Y3QgdG8gaG93IGRvY3VtZW50IGdlbmVyYXRpb24vdmVyaWZpY2F0aW9uIGlzIGRvbmU/DQoNCg0K
DQoNCj4gPiBTZWUgYmVsb3cuDQo+ID4NCg0K


