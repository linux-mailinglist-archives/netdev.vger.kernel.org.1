Return-Path: <netdev+bounces-295953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TTZhFNciI2owjQEAu9opvQ
	(envelope-from <netdev+bounces-295953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 21:26:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D6164AED5
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 21:26:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=CoDGtcee;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295953-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295953-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E73983009F0D
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 19:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB314071E8;
	Fri,  5 Jun 2026 19:23:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7E4071C9
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 19:23:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687399; cv=none; b=LTRLvXlLdfb9uQupwZKnoYBAogx0AWnX2QwljlcLFGKjJCBpm/WI8B3WLfuIby0lC3jc29WW9AlvhegJILJ4AasdpaihU/PXJzyQ5jXaZ0VPl+BDSE3A/DqT4VAYEh0/TWICl2FUWoSoDYxwYhPtF4Hu4knppPZ4IgsexBmJ/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687399; c=relaxed/simple;
	bh=0tSUzHTzrKY+5caF2k1r3Xa1YexII1eK6VGJt+3BoZ0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=esIPy3VdsrRtQ22FvJWmBGXFm/B2itID9khrVASYzjZvX3Z+rYDuGeNtBvF1PVRBwCZTy7GAFxNBkD+kUP6Ex+0x6IP2EoNCFAHOsX+YMvlJNBMf9NJ7g1TmALvsR7lx8uE+6yYPOh7nm6V5gwzvykPQx4fUwaXay5Clm+afhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=CoDGtcee; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780687397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tSUzHTzrKY+5caF2k1r3Xa1YexII1eK6VGJt+3BoZ0=;
	b=CoDGtceeEkARGhQdxNwA+ghh1Vx18jM3vIcBYgIfkijJsIoQOCjgGKkAA0nLZ3E00rBxMW
	eZiHEx2XMiVvgUGLtywqUIffEQFQ0sxLosR9zftqx/+jv6DCDjpXHyvYb/YzcyJw5HmVZ3
	UyC8tUXyPl/2Jf8Si+cppwM8aKbwyhkA/+Ls57SLPzkaReKrd+EV9eXvUi/WWDHcNuwH88
	3kh0lLlkeCdQ0QKtAdU4a+jk0gPEH01UjKNe4lLjyhCF3wJTI9SE0UWE2BeQ3Am98uUNFB
	P+ODj17z0PKPT1zKFy9Yz8M/5YKohiZBxaSmZfWwUJ4wNSIsdkb7DkZ18cGbuw==
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-16-bi9J8ABsPIq7g9t91elN4A-1; Fri,
 05 Jun 2026 12:23:13 -0700
X-MC-Unique: bi9J8ABsPIq7g9t91elN4A-1
X-Mimecast-MFC-AGG-ID: bi9J8ABsPIq7g9t91elN4A_1780687389
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DM6PR02MB6747.namprd02.prod.outlook.com (2603:10b6:5:220::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 5 Jun 2026
 19:23:07 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 19:23:07 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Jerry.Ray@microchip.com" <Jerry.Ray@microchip.com>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>, "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size
 in RX frame
Thread-Topic: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size
 in RX frame
Thread-Index: AdzvmRIV9Yc6XZqaQq2ja4j42ca11AFgD4jQAAHDuaA=
Date: Fri, 5 Jun 2026 19:23:06 +0000
Message-ID: <CY8PR02MB924905780DDC814D61D281FD83112@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <CH3PR11MB7723AA90B2FEDDCE9F70041CEF112@CH3PR11MB7723.namprd11.prod.outlook.com>
In-Reply-To: <CH3PR11MB7723AA90B2FEDDCE9F70041CEF112@CH3PR11MB7723.namprd11.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DM6PR02MB6747:EE_
x-ms-office365-filtering-correlation-id: 0a8e51c2-b982-4515-414a-08dec337df4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|921020|56012099006|4143699003|11063799006|38070700021
x-microsoft-antispam-message-info: COm+Qg9wTVASJpctHULEhSdLKRlSpwSRW9zAx/C68LBN3D1I6DH9mwuNCREVHsOPdewQXv7q4D2yhT+zxnEo5qyob5ps68pXyOhLD+TS9IvwlZZj9mVuCAT2yXhFdoLXPuxoldF/sfJNTJKmhb6a45E/O/xKVppP6Kmcnc72aG6fLZr9YWu+QGkWv1ydbKdYiUcIk48OlYswymO+8U6XMNB7JYA7NqBXEAYlWHk1u3rpBe992Ad04vJvSWgRuq0LB3pSuiivExnjCQfM/JLqxj/yu7gzdNWF0f5nK3nobKTwWfAiATGQCGZGbVrwmLHyYioH1sWtTByruQ3M4LwYcvk0rQElQ+1xZspqEYzIFw0urEEapHEVLVRBGWNZ1AEkEW11oA80ZEwgRXaQw8807T7p5UvUf/bYCnq93WM7TdUdm1YS/9L2BtEmeS+YTqYKqBZxLhbAZbNVLgTFuQ72MfLGY78gL+3lYKGZtJ3mX1ILfuOjDlkHWBEDzKITjcOcRdXutqtgG5M7W5dlleq66QQrIkwCiaw9pZWM4rUA/TY25iY3TRL8UUW+uWmdror55KcDMaOkvqiLUjvd3bJ3tBR+2GqRV+ja1uW/oVv5WGqnPe8Gqi8kj6AG5FN3EAI4zJ6bdR78WMs5xzSDpw66T36v2iGTXTZC1Mes/u7OEwbcfaGtPVA6r9lQyvuUDTdkFzRSkjiq6pOtH4sLw7xjrv+O++ZVXb2m7J/awNdWhMs/GR1NdwgiKNXGrDf8SCCsJhiVh8uAve6+ki7/OLqzlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(921020)(56012099006)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUpFVndPelZHcGpuY2hiVk8yY2Eya0xhcWdmc054ak5PSjh2bmlwYnB0T1N5?=
 =?utf-8?B?M2tvOEdPV2I3YnZzWjNOYXZ6OXhOQ01TS1dvNWNIenpsOXBQYjcwbzAzaDBK?=
 =?utf-8?B?dGxhUU1yaVJldlgzNTNtOTFYc0pSZVVkVEpDcGo4MWpZMjNuV0FHcGNlVUc5?=
 =?utf-8?B?dTc2STlleXlMVUh5b2g2L2VnYjdOTFpLeTNmUHJrZFlrdzRQS0hxaWNpS004?=
 =?utf-8?B?YS9pTWVIY24vS2dic2NFUERaSlNRcjFNY1VmODFSb2cvQVgzQzBFa1M1ZGJs?=
 =?utf-8?B?eUpwd0h4TTgxOHBXV3dHamlyNXJCTHE5Vkl6S1dESGtiam9iMjNpVTJRK2ZP?=
 =?utf-8?B?TTltaTVOV25XdCtzM215cElXMGp5TXFBdXVDV0IySmFlMlhTWGFPYkFsU3lG?=
 =?utf-8?B?dWxRRnVBNFB2c3VIdUJRRllvNng5SHMvZDYwdnVKRkljMnZhbmZZSnJGWmty?=
 =?utf-8?B?ajh2enMwejFqek82djdSZEFINTBmM20yUE81bk4ydmgzR05vTGM2MW1xSGN2?=
 =?utf-8?B?MmwwY091S0hTY3JLQzhSS3U0L1hzL0R6N3BNYmZRVE9pSFM4SUhjUkd4TU1B?=
 =?utf-8?B?VmN3UG55S2pPUXN3MTYzWFBNUGJMR0JGcUREVytzbFBSV0k4ZEVZU0lLWjN5?=
 =?utf-8?B?Y3BHQVFtWFF3UW9USjVYanZLYk01OVRLaFE2K05hcDN3b2tnU3pFNTN6UDFl?=
 =?utf-8?B?TkYrYUk5L2NhcEU4MTc2L3JkSE5rbTVLeG44bWh2WTZUMHJ3U09pdEU2aS90?=
 =?utf-8?B?OVNwbWNadFZOYnhCK25HUk1ub3Z3Mk9NOEhvb0pkV2s0TGp6MG5yb2d5MW1S?=
 =?utf-8?B?aC95bkdWaXRjblAzOFB2dkI1NFFvN0pXQk96ZXdRMUJ2c0c1RmZ0NjNXTVRO?=
 =?utf-8?B?OFdoZ3Mvanlva0p4Y1RNdURrMUd4dVNOYkU1S2RjaVpQenFBOVRxcFVrdExx?=
 =?utf-8?B?NVM4MEVobG5kZ2E5WXA4OFplS1ZFd0pkcWdLejZEeXFlOFhVeE13SlFlazg3?=
 =?utf-8?B?NkNLTEIxdEcrRnU0UVFPdENtR1NaNVJZbHhGSkdPSjlZNzRkZW9hUU1RNU5k?=
 =?utf-8?B?akVWTFlVL2NMRG1BSC9kVW00VWlWMS80UjNxMmZHQ2EyL2U0VlVkQVJ0aFhE?=
 =?utf-8?B?YXlzN3BlYUwxcjM0TWpxc3lCT3hXUXEvUUdiYkN0L3IxVzd6QVUxelcvWHZi?=
 =?utf-8?B?ZVVtRnVBWHJoU1VhWGxVdzNjblp5MTlkeFNyOElJYWthYzcxdC9MZnVZcnFy?=
 =?utf-8?B?QVlCOFVpTnlPS2hvNjJYUVMxLy9sYWVOYzVZK0NTMjRvdkFzbmFleU9SN3BG?=
 =?utf-8?B?eVFZWU8yMGpaWFJyNEdicmRzM0NVaFJmY3cxN2lEQnJIRi8vbE5Ob1I4Slln?=
 =?utf-8?B?K281Q2Nnb20vYTV2TEQrTitidHNwdVZZOFhXYUJhTUZKNTI5VWQ1QUY0MXgw?=
 =?utf-8?B?cFBpN1pTWkViZVlQRlBMbFEvTU1VdUNYU1FNNUhCVHhMaDYweG5ObWhQcXNU?=
 =?utf-8?B?VFY0b0ZzdXo1TFhhNU9TNDFBc1NCWi9DWDkrcVI5S3BOa21RaS9td1l5NE55?=
 =?utf-8?B?TWRuTVowbTJCb0ZUUmN3K3h1bXBsWEpVbzg0V21kN1R5Ykh3TzVOQ0V1dWVh?=
 =?utf-8?B?QzR1YVZESDJQQ3ppZUg5cWNnU2NzQzV2eFlwclpCSDZEZlZzVlpsVy9keGFj?=
 =?utf-8?B?Kzl4SHJGMnJHRmJ1WjhuMDdSRW9RNmF0ZGQwT2tiSmo3QXFJNGRFaVBSNVpJ?=
 =?utf-8?B?TmYwczh5eng1b25zblZnVDRpRWxYNUk2UHRQSnBWQXYxc2owSGRVRVZ0V3BO?=
 =?utf-8?B?dXpZeDVNUG5NR0xJUnlPOGxieTBMRmFhSUExY1JrYlc4eERaMTdNSWNSMVNQ?=
 =?utf-8?B?R25TU3Z2eUU1M1htTUwyWVEram0wbmVUcWtIOHJmUWdKL1o1bTEzYnlGa2Rw?=
 =?utf-8?B?aXdOTkNmYjhmTERqdnhBMU1KSG1UUHV0cFVxajdVREVpOEdBNE80aGdjQW40?=
 =?utf-8?B?eVB1UlFFVzZ2ZkJIOFRLcDNvMW1keEV6dTMwbzl6VUZYYU14emV6M1Fmb1Rs?=
 =?utf-8?B?Z1orbHkyemxleEZHSWFiQzlobk5GZmFDVWx2STYxelNheGlLSWk0aFJia3M0?=
 =?utf-8?B?ZkJwUHQ4YXVGRzE0b2F5ZThPQXBpeTdxMWh6NHFIV1VaTWVQd3VUM3NXSS9S?=
 =?utf-8?B?MHVobDllMnhzdnVKQm1oZzBvRUZ6WFE0U3lVUFBad3BXemVBOENab2QyTzg4?=
 =?utf-8?B?YVpwRHlJQjZrcklaclp4WFk3dWt4aHAzeVNhQk9WbHIvQWdQOXBwd2JnaWJC?=
 =?utf-8?B?Nzl5R1lSQTVPNzVxNXZKb3RCUHByalFsSlErUlBzOWQreDM5RURzKzZrVTNP?=
 =?utf-8?Q?1GJo8DNcaMp6AmmE=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: anqeQSpAItnJZYTn9miE1oQwwxaCwFUp2eAfaewXyxFk6mdC85Y0UVz8flqjfG38XnRCb5NIyi0UXCQlH4gcAdWBhwvEt8bUUzwKRq3QCdx8FeS80zUt4IJO81lzsTpIIDECapUIedDaoyOpWxiFhock+bItVVIhtRhDSwqh1Lpp4jTxDe/gAp2kkhAaN4Wk10URVgp7K+5h+TnT4/Qz41uMBqyzPSJvJ96zpI31fdQEQWkLiame8ccKN+6N0VT+C+i30snJE2bKus4uuFEGd5xdKhZgNSlYNiD9t8PFVF3y4TMR/2NWTBh7t8C5yxyMcWuFfR8trzbkp77pSLGPPw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8e51c2-b982-4515-414a-08dec337df4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 19:23:06.9734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikPMKvqyEaGal65nYT7CPWv9CMwMjqcJ2p/vkz/c4Sn9wVnddexepVX/s7IlNQeNEuw/13EbMxzkUkEqKMA3aLpOmlgUanCKaiAbbbFYsaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6747
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zfuOpav-Yy_EBmEcRv9Qj6BSO4qRk4QNCXX2nsk1mnA_1780687389
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295953-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Jerry.Ray@microchip.com,m:Pier.Beruto@onsemi.com,m:Parthiban.Veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6D6164AED5

PiANCj4gSGkgUmFqYWdvcGFsLA0KPiANCj4gVGhhbmtzIC0gY29uZmlybWVkOiB3aXRoIHBhdGNo
IDA4IGFwcGxpZWQsIGxhbjg2NXgganVzdCBuZWVkcyB0aGUgRkNTDQo+IGhhbmRsaW5nLCBhbmQg
czI1MDAgZ2V0cyBpdCB2aWEgaHdfZmVhdHVyZXMgfD0gTkVUSUZfRl9SWEZDUy4NCj4gDQo+IFR3
byB0aGluZ3MgdGhvdWdoOg0KPiAoMSkgSSBoYWQgZHJvcHBlZCBwYXRjaCAwOCBpbiBteSB0cmVl
LCBoZW5jZSB0aGUgc2VwYXJhdGUgc3RyaXAgcGF0Y2guDQo+ICgyKSBQYXRjaCAwOCB1c2VzIE5F
VElGX0ZfUlhGQ1MgaW52ZXJ0ZWQgZnJvbSBpdHMga2VybmVsIG1lYW5pbmcNCj4gKCJhcHBlbmQg
RkNTIik6IGl0IHN0cmlwcyB3aGVuIHRoZSBiaXQgaXMgaW4gaHdfZmVhdHVyZXMgYW5kIGNoZWNr
cw0KPiBod19mZWF0dXJlcyByYXRoZXIgdGhhbiBkZXYtPmZlYXR1cmVzLCBzbyBldGh0b29sIC1L
IHJ4LWZjcyBvbiBuZXZlcg0KPiBhY3R1YWxseSBkZWxpdmVycyB0aGUgRkNTLCBhbmQgYSBjb25z
dW1lciBtdXN0IGFkdmVydGlzZSBhIGRlYnVnIGZlYXR1cmUNCj4gdG8gZ2V0IGRlZmF1bHQgYmVo
YXZpb3IuIFRoZSBtYWlubGluZSBpZGlvbSAocjgxNjksIHJ0YXNlLCA4MTM5dG9vLCBtbHg0KQ0K
PiBpcyBpZiAoIShkZXYtPmZlYXR1cmVzICYgTkVUSUZfRl9SWEZDUykpIHN0cmlwOw0KPiB3aXRo
IGh3X2ZlYXR1cmVzIHw9IE5FVElGX0ZfUlhGQ1MgdG8gYWxsb3cgdG9nZ2xpbmcuIFNpbmNlIGV2
ZXJ5IE9BIFRDNg0KPiBkZXZpY2UgZGVsaXZlcnMgdGhlIEZDUywgSSdkIHN1Z2dlc3QgdGhlIGZy
YW1ld29yayBzdHJpcCB1bmNvbmRpdGlvbmFsbHkNCj4gYnkgZGVmYXVsdCB1c2luZyB0aGF0IGlk
aW9tIChwYXRjaCBhdHRhY2hlZCksIHJhdGhlciB0aGFuIGdhdGluZyBvbiBhDQo+IHBlci12ZW5k
b3Igb3B0LWluLg0KPiANCj4gUGxlYXNlIGNvbnNpZGVyLg0KDQoNClllcy4gT2YgY291cnNlLiBJ
IHdpbGwgbWFrZSB0aG9zZSBjaGFuZ2VzIGJlZm9yZSBzdWJtaXR0aW5nIHY0LiBXZSB3YW50IHRo
ZSBmbGFnDQp0byBiZSB1c2VkIGNvbnNpc3RlbnRseS4gDQoNCg0KDQo=


