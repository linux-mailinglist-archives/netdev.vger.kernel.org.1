Return-Path: <netdev+bounces-305112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P58zBdnMS2rvaQEAu9opvQ
	(envelope-from <netdev+bounces-305112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:42:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E022712BB2
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:42:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=qUDcfDWB;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305112-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305112-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7FB93224BB0
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381563822BF;
	Mon,  6 Jul 2026 15:08:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022100.outbound.protection.outlook.com [52.101.101.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0738239E;
	Mon,  6 Jul 2026 15:07:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350480; cv=fail; b=b8bQhkPpjYV8j7rTJPHkMtOtcUUY8VrLiLbEnrDhHUJSyZY6Sp17FGN5FV9EPs/lRBMpStHX+bXZh+SyxLKPkjFi0O7YsJ2EVSUn4/ZpsdkWzwP/So9Bt7nwkUx8EK0lRHpI0W6gdOMIb7fNJXlUvpsrDnD7KX5pyWUUEv2eaT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350480; c=relaxed/simple;
	bh=vH6yrxhNGbAzB79CvdjkrUb+RHVBCFWUDRjtYirISLg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Y/nnAwOIgqw7kM3E9IJCWQjJcS2i+Y8ylot0iFnRAYmmOvudWZroDopVgQNq2929NCw8IiYEzPyDQu7GYJ/+YF/6Db1D+R/itVuYeCM1ZLMLMvFj6Vm1jtw6n8dOQx4b0eArVIxoUdT8b7Qq+Q6iWv/Q3tHdMl2XLcIENYCeZYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=qUDcfDWB; arc=fail smtp.client-ip=52.101.101.100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I55qDhStFloGb6SvCBdqgFoilX9jylqMvBNpDiRD/2rn8499xAv9gBYcVAl6FRmXuhmOAoDns4W4mb9U4UbcNdR6igZ4zguY9eNTNcSMFNLuJEGoNlNGaMx8YSbJYL51QgSNfZ/ge2zCIWVcJeukQ+vPN6PFBFlKh1Uw9W//k0QVicKurqIAWcxXHDUFuGd/J15hssn/7+gec1smUScXWDLnnwe0GV29VKqr171J+l3b33IFnpkmCkvMzTseWRvCDrXXlje8zqyKV1Bov9IlZkGwLV8A6sj/ZjVKxzrgmXDyak6Y0EQbZ/OswT3doajzHf6HxWYFjckEhyZyqinFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+Na9PCjfUkDE/1JfC26Zhqt/9EdNCNqkADg6EUVrmw=;
 b=Xn8GrxlmAm/xfXqSgq4WvtNJJjwpPC5w8SRja2lFyk2bfdlVjkjNjKLqmBZSiJhG3j4tFrTdRk3W0JxWQ+siico6qOKmk9bFmdNqBtPbRnQegFC/lNraww398CBuu+1qIxmomi+TRXfVbV1oOM4FupHVfz3laF11QDoofhErI9yxAN47EYOg2obKigGrRfz9h2VX5By6qqOMWZnIDvWcxNU6BdSb7Oeg2UlOhdnESqx8pi5gP4Y0SxvTGCSheVlp8n1IGDSMVPdCi4Nm7tO1bpmfG+DkwxacibLGYLROErTj8TZ3MZCdkdzfwoGvR89l5IaaH5iUzpEyBgVc1dfqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+Na9PCjfUkDE/1JfC26Zhqt/9EdNCNqkADg6EUVrmw=;
 b=qUDcfDWBQ0i3zO89HI1+iDYg5A19ukhJKKmWqzu20e1oCV1Wp9X7gtn24e858A4S9XbbHaHhIE9wUYEKP4Hkj84lIckgQ5rowlyGDG3VSsK4T+gG8Q5PSGSQKrt5MR/2h6XyHJCxSOsjS3Nymxx3hmSzzW1poOS4z0XfspmqbfQ=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2198.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 15:07:53 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 15:07:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 16:07:52 +0100
Message-Id: <DJRKZD8LBXXH.MCISM5ZLNVMP@garyguo.net>
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Heiner Kallweit" <hkallweit1@gmail.com>, "Russell
 King" <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: phy: qt2025: Use vertical import
 style
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Andrew Lunn" <andrew@lunn.ch>, "Guru
 Das Srinagesh" <linux@gurudas.dev>
X-Mailer: aerc 0.21.0
References: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
 <20260705-net-vert-imp-v1-2-95a35ddff411@gurudas.dev>
 <d2c1e11e-e616-4b2f-aa17-5eb96f045833@lunn.ch>
In-Reply-To: <d2c1e11e-e616-4b2f-aa17-5eb96f045833@lunn.ch>
X-ClientProxiedBy: LO4P123CA0527.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2198:EE_
X-MS-Office365-Filtering-Correlation-Id: 948b51f7-bfca-4c10-4328-08dedb705a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|10070799003|376014|23010399003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	wavNWDJBg+0kHdjtlHsG2igHCq2NOJT7JgvTGATh1oXK6yPrqwVvlcq5D5UKfoMzLAiOYvADhL2fcvs5nwHJm6L3F2ozaIySPdTtI0DADRMavjmzXI87NcjwN8RXJzanlLxp0G+yUWdBQXzm/kcxAVXiFAoEa/y0kbWH4ykaghxwSUMZGPdzBf8/cHpUMZ27EZvisOiOE+Db0usT3Hz8ZYPNpl4u8tu3pZfxUVLwkdHOpTqwOae+j1W2TcT8n44C1mwy+4qLi7G8D91zQQY+PN60AEKMKwiS/gyBlF578thfMv+4TiU/izrE+lx4zNyfeZYwRhiw49zUrdfo1EPrr3N2SzD46LTk4BR869dwJCZvFec8c5ucg/LgkuDD8xb56HjrQbECZHvnBo1yGxpnnwAb+jQbRLGKpWnIj+pavXMTPy66gkBDKEVbmFsLj9+IGcUOGPlva8tlTpkBOTrpReb7BJ7etP693xg5sKR+9g+5/BgsRu317wpOfRqRXqFF8m/1glh0Igc/S+pKNHbusTwzGHGI5WppaA2hWY8bjkdI22WQXix5cmWLqThwohux9S+0gpRR8y6EVB/bgEfSMeWZ+iqzGZOa1ijtF9/SMXP2nGTWK9swRkbE9MST6M8X3w3LzcrK5kCrj3FyvJjR4ZgeB0wVaOCFDNuOXQzQ/LE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(10070799003)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVBDWm5xWlNlQmRwakJ6djIyR2tUdTJpWm1WMU1adEExdjgzNjVNdmdET1Ry?=
 =?utf-8?B?S1hHOVV0MHdncUJUTjdwdCtnRWpndU0yVVM3Y0owQi9kaklERWhoanFaMjhX?=
 =?utf-8?B?aW4wN1ArZ0M1WjkvR0pSNkdJTjJBUk5leHJHMlBIcTY2RHNEMm1xNS9vNFZ2?=
 =?utf-8?B?ZEJWclBXajdnWHNoVjU2TFo0a2xKcElqMmQrWHNwWE5TM3RXamJma0E0V0Jy?=
 =?utf-8?B?K1k4ajEzQTkvaXdoeEVGOHU3UzFiT0FLQVJYTzU2NW1HNUF3MVRzVkh1d3NN?=
 =?utf-8?B?SnpPQTlmWUVDZzdhV1lHOXgvWnBhS0FzL1BpYVZScHBJTGt4R0RWV25ldkF2?=
 =?utf-8?B?YjU0WlRWaU84cFl4OWNCbTdPR3gzVHJ4VHdoNFJWT2g0UmVyRG5HUjBoeFQ4?=
 =?utf-8?B?RUh5UmMzbWtjZ3ZQcFJLdGtVdGlyc0VVdzFSU3l0NWJmeUV3Q29XZGd1UUll?=
 =?utf-8?B?M1JTR2VneXBZQlB5ZWFWdW1rRStFeWRXRFdWL2JCR3o4SmtsQ1NUWFBtcU0v?=
 =?utf-8?B?bzB3bUx3YUhJalBrelpPWFI0YWw1MDFsVWRkWU1hOE40c20rZjhibFQzMTVI?=
 =?utf-8?B?THdQaFJaQVQ3VitBT3BUUHJYOFY3blBKd0MveUgwbFhUUHliK0ZSRXVPNUJZ?=
 =?utf-8?B?RHYycGpKSWtVd1kzd0lpbXpOK0E2Q0JjMHVyZkVkNnFoMEZlYXdLcVBEUVFv?=
 =?utf-8?B?azFzcXVyejdwbkZGT2JwN2VpNHBqN0ZWTlNBbXh1ZVg4a1U0cmRDVmxTVk1n?=
 =?utf-8?B?Y05NcEtFMy92RjZVam42TE8vTGlkdUFWWXJ5amh2eHNQRDVPNyt2S2Qyemlu?=
 =?utf-8?B?UEtkMHRkVjhwSzBVMzZ3a3g1aC9rR2ZkQUNiQXBhazkxNENWV3VGWGhnTnZM?=
 =?utf-8?B?R045aDNqRFlpb2lKbFBZKzJjSjdwaENCRWhHcTV4alZ1RHEzaUR1UjR1Rm9C?=
 =?utf-8?B?dy9lVE12cFg5WDIwNDhybHFycDBESXZkRFdMY3NJZnFJWVdKMmZ3ZFF5cmFN?=
 =?utf-8?B?bmllNUtHakovTTlCUVo0bXFjelJIcEVXWVN2Y1JScUtRWndpYkhoc01ZWFlH?=
 =?utf-8?B?SUpoWDg4QTFidTU3RmhvbWozNURleVJ3QlZydTBnY3liK2FsdExUVjdERW95?=
 =?utf-8?B?Z3lYS2I3cWp1RDAvQ1o3YnhXVmxZRlprYU5QdW40a29UYXV0Q0QyVXZVT0k2?=
 =?utf-8?B?R1pkR1k1a1NpdzByTG1RNVU2QXRnZnRNaDRqV1V5SCtOVzhNRkp2S1dCdTZF?=
 =?utf-8?B?WmVoNlFEeURLQW5RV0dvanlBVG4vRDhiRWV2RVpRSmFINzhVMjAyNElNRmxB?=
 =?utf-8?B?QWd2dGpnaVgzZVpENUhVNXFFc3ROd2NBNXNkam5NWHRaeEk1ZWUyZjF6SW1o?=
 =?utf-8?B?dTNuSEVkc1JsKzlHZitqVXkxS2tJYU9JcWwzQzFJZ1NDdGhuNDRrelEyWjNU?=
 =?utf-8?B?dXlKamFnQlBITGpHQWRsakxPTUdEblZVQW5VT1lyQ3RoVWJwM0F5ZmFNVzNl?=
 =?utf-8?B?a2lhazhIeWszTE1Nd25RT3V2RTlRSHBpMGlETkpWRzVpblBuWGFKeGRRckJT?=
 =?utf-8?B?VGZhUlV0RWVyOXkxSHM5UTcxNlFlQUhJekJJMXFyV0NtYnBuSVlkMFZyUUlo?=
 =?utf-8?B?NFlRdFBIQ1ptN080ZkhNdlpGcTFZVjB1c1gzTnVtdndManZSRkNweHY2WWJX?=
 =?utf-8?B?aVNiNk16dGQ0QzJWdG1VVlRLa1g3b0graUtVdCtQeWJYSUp5RzhPQ0NjTFNu?=
 =?utf-8?B?KzMxeHl6YlVLZnQrUXFpVnBVM3Rld2pUZkVQQXpXempaWnhYaEZGL08xUVhE?=
 =?utf-8?B?ajhqNjNpUXVBWWFOenN2ekFZWjVpdFVrUGs5dW8xWk13WnV2WnRCczU0T0Vz?=
 =?utf-8?B?bThVNldtSHV3Y0w4a0dQOU9vVWVPTnhMMiszdmFpVW4rZVFaUjNQRmdHeVpN?=
 =?utf-8?B?M3BESnBidmRkcEIyd2lPK2JTYnByL1pqV1ZvOU13UXlzK1lkME53cHVXaXEx?=
 =?utf-8?B?T083R0NHSWZ1SU5URDRtUDZnQnUrNGJHVnJlR2dmK2hwYTUvYnl4UFFsZ0ZJ?=
 =?utf-8?B?dlphaFZITSs2c2xqcERSOS9xczV4eXZOTWEweGZYUGpQbGJHazhGNGRBK1ZC?=
 =?utf-8?B?bXZ4MGxKbEU1U1pFTHV6Qk5oeDJrQ0g0M1hueEROK2NqZnRLR1Z6dW96WEtv?=
 =?utf-8?B?WE5CUWcrbEFtTEJtVVhNK2ZSaTNHcm1yR3ZkUW5VdUFiYXMwTlpXYnBxMzYv?=
 =?utf-8?B?VjJpUU9IeWVHR1hDQ0FuQkR5dGRoSTY0U1RlQjl3czNyS09CaDlxNjNRS3Bz?=
 =?utf-8?B?c1k4bHFGU2JRQW9PZW1HeVdZcFM3VEIzSldyYS81dTg5Qldqc3RQQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 948b51f7-bfca-4c10-4328-08dedb705a65
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 15:07:53.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTnxv43iwRlMq9FctRVirOebaO/uSN4cU5wiihdIvvJebPwVhxxpdUQfG3yf3JF4Jpn9YFfd6ufiSfRV+ADA5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2198
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305112-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:fujita.tomonori@gmail.com,m:tmgross@umich.edu,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ojeda@kernel.org,m:andrew@lunn.ch,m:linux@gurudas.dev,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,umich.edu,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gurudas.dev:email,garyguo.net:from_mime,garyguo.net:dkim,garyguo.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E022712BB2

On Mon Jul 6, 2026 at 2:58 PM BST, Andrew Lunn wrote:
> On Sun, Jul 05, 2026 at 10:38:41PM -0700, Guru Das Srinagesh wrote:
>> Convert `use` imports to vertical layout for better readability and
>> maintainability.
>>=20
>> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
>> ---
>>  drivers/net/phy/qt2025.rs | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
>> index 470d89a0ac00..efde3f909367 100644
>> --- a/drivers/net/phy/qt2025.rs
>> +++ b/drivers/net/phy/qt2025.rs
>> @@ -14,11 +14,17 @@
>>  use kernel::io::poll::read_poll_timeout;
>>  use kernel::net::phy::{
>>      self,
>> -    reg::{Mmd, C45},
>> +    reg::{
>> +        Mmd,
>> +        C45, //
>> +    },
>
> Given the comment this should be sorted in 'ASCIIbetical order',
> isn't this wrong, C comes before M?=20
>
> 	Andrew

This is one of the quirks of rustfmt. Before style edition 2024, if an
identifier is all caps, it sorts it after non-all-caps identifiers. The
motivation was to ensure constants are ordered after types, however for thi=
ngs
like C45 it is actually a type, causing this weirdness.

Miguel, do you think it's worth moving to Rust style edition 2024 before we
switch the lang edition?

Best,
Gary


