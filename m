Return-Path: <netdev+bounces-293850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC+MKXC8HWo/dQkAu9opvQ
	(envelope-from <netdev+bounces-293850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:08:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CE162307F
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 905EE3008285
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C102D2486;
	Mon,  1 Jun 2026 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="YH3Yu4uN"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26BE3DC860
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333569; cv=none; b=Q9DARPF4cll/BhVITWxmMfLMer7vuZDCpJSJD+ojOplN+c05yspkJ3h9j1VfF5/FM3vhYr/XmDbfrNTcs+O4y+5HdEvTCLaWkbwBZo2eVmsWAVEb7eeW3KsuFTyqqemQmLJCajMmfcQmgYifjtR/4d3/hcvWDoTu5xG5akcec3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333569; c=relaxed/simple;
	bh=d3H8W/kllpgV+tjss4asHKkfKZtuqTxvHGvVxXWAXgs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ovAB1q7IT1R1KwhCU/E4He+TqG85kDizvR7/vITBEDzLQ30GSldX7FlCJkEymg4eEUk6+naJuXUd40DH1+cLETEtG1GHny1edtR0gJ06AbRFv06+09lMEyaabEl8GfX0Fg18EOcp0xgMviBxyFnOYtX537LGbsq2wcjha+IYIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=YH3Yu4uN; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780333561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3H8W/kllpgV+tjss4asHKkfKZtuqTxvHGvVxXWAXgs=;
	b=YH3Yu4uN82RhKvyw2XSY3lyuSlMisqinEU6q1eYR5ZKAc25Jfn/zeCp4oVSZB6pyx680zU
	Oeer6imhV991Z8/7SGRUbQR+dVQJDeV1reKoM7cS8+pU6aLPki89hirvKGhD5+ebOZNoDn
	xXI2JJV3wUxVZ48yxNtLQyDDUk80ZhznzkHChgdJuRvCsBkjWD1lxMDbNzolSCawhkG/3b
	n4gYK8BjSXUbldSOwPwl+VdLSrk3b3PXFbEB6UI6w+MC0A7imGtxL9Ud7BSHypNtyjdJUM
	eVI7fMVGRqb7NaATT0kjpoAlXXb1aeKaDN160E78xwR/1a2AsMhkXZDQRwHutg==
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012004.outbound.protection.outlook.com
 [40.93.195.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-59-K2HO0sA8P72uOfarH5y2Rw-1; Mon, 01 Jun 2026 10:03:52 -0700
X-MC-Unique: K2HO0sA8P72uOfarH5y2Rw-1
X-Mimecast-MFC-AGG-ID: K2HO0sA8P72uOfarH5y2Rw_1780333430
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CH2PR02MB6918.namprd02.prod.outlook.com (2603:10b6:610:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 17:03:46 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 17:03:46 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 11/14] net: phy: ncn26000: Support for
 loopback support
Thread-Topic: [PATCH net-next v3 11/14] net: phy: ncn26000: Support for
 loopback support
Thread-Index: AdzvmWh3z2fZMkfqSqmvJbjWwU2cFQBeZp2AADUKyLA=
Date: Mon, 1 Jun 2026 17:03:46 +0000
Message-ID: <CY8PR02MB924995564C2FE17062A775DF83152@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249BCB1ABC4D1923CE3CAAE83162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <22496ce0-6d50-4059-bbd4-980513ad2612@lunn.ch>
In-Reply-To: <22496ce0-6d50-4059-bbd4-980513ad2612@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CH2PR02MB6918:EE_
x-ms-office365-filtering-correlation-id: 9bfd37ad-cc9c-42b6-6a2f-08debfffbe92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099006|4143699003|11063799006|22082099003|18002099003
x-microsoft-antispam-message-info: vzHkopfe0AtM/TgCihOdx5w3lfUuPizO3WTaLcKTOxUh6jrbvQcLfq2mabzlaYUxFndwHWMIM96MKJz1efuP0snWX3lq0Hk6+DBCDFScmYgjC+QX9gxrZ9q+fjF90x3gHAzOfRD4H4wOEau0YDxfHaOSH6RC74n4tyfyMO8JfLCtAf3Hr5SfsJ9vXuvDIPwoMJ4t0K1SSTog9EBcU44Me5olA1YjiEgQ55t70PthIN85RRWGXo179sq61Ap0I18eGAWPoWjIikwwbCPY/+2GCVxWEPrw7wXMFDQSxH3jDhjeplAQKH2lvcKF+bPPRBeax4zZSQBYWV9bCqeBGWHR+/AwMiIm3sqn87xE0xvEwQXmbH6J0c8d6PrBeUl1F/sgIitdLAcCVVDvILtwRs30gmbpRaMoMWRenA0LeNzPc8vrK8dLEaByv9/H7fPo0MD/hF8P65EPmUHfB0rOlRTy+oDxtToSkXfgMj5m2v4XpZXZy4MzBADlwUgH9XZ1DfYumbj1lqPVWbS01WIyxXvCmdnnYJYH4cOJp4zSUitULg4CzYLXe4XtqOz5h4jYjv3F+cbJ2l9K3raYlkLDVCEPNThOwxKHQ/3f/EVYNuOGL9fXs4RHeJEFijbOG5OKj6GauISvMxGXuw9vdQ/0zbWdojjYolZphgorUM5kEX5u+dO3n88YarTkhjc6i2QROqjGfGEE/jmJGJPSXRhuFzszKinQN25f5RLjUi5G5qPKvtnBBRuYhO8PEAobXlJMgxdV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW5sSmdTOU1JeWxUNGQxeVRZL0RVZXAzSHNRZHVRUy9UdlFndkhEd1BXczdz?=
 =?utf-8?B?Nmswb04xRHYwRHcydWJoYllZUitaR1Y4bGdYOVB1WEU2V0ZwRzNPVzU4VDh3?=
 =?utf-8?B?RlNCWXhiNk5HckhuNm9TWElNOWl1RDIrQ2ZFQ1N1NG5vbXhCZDR3TG1WSTZ6?=
 =?utf-8?B?d2lWdDVQUVdBT1RMVm90VzAzNHIybmNSRlF2bUcxTE8zK1BOem8yN1ViS0JE?=
 =?utf-8?B?eTRrcWR4VnhVcHIxVkxGdDIxeWIrTkczbUo0d2lZZWtQOW05VlhRRnRRcTFl?=
 =?utf-8?B?WmhEeVlSK1IwZW1qazNLdmNpakpZUXppemRDNHF4NzBCV0wyQXpMME9TNjdD?=
 =?utf-8?B?MWRET3VVNGpxOHd3cGxYNmtiYk1mZ1JPTitEckVTQzBINXRDOEhuem5iV0xO?=
 =?utf-8?B?Y3V2d09zV2FvQXhvSnFuY050SW9PTGk2dUtyK0dzWk5jUVlsTXhaRmM5TGpN?=
 =?utf-8?B?dUlOT1p2ZDcwV3FLazUyS1lmeEk3SVhXclVXRGE3emNWUFpkWUp1YkxGQmwx?=
 =?utf-8?B?TEhWdy9kMXRNM0UxODhvenFQNVFDTXY4d3NLdkp3S0hGei90UFRvOVRlbENy?=
 =?utf-8?B?a0F5TmpqWW1zUlBZZFc5NS9kWTNyN0E1MThzTDVOV3Jab294VnVueTJwUVh3?=
 =?utf-8?B?ZDdkZG1ISk45TTVxZk5laGxibkdUMkZuODczeUJjV2tPY2RJWUlJRW0vN1dS?=
 =?utf-8?B?eHlxOU9samdDRWVEYW1Ta0lIMXVpYTI4ZGo3NEYyRVEwQVR6dTkrdTkxLzky?=
 =?utf-8?B?K0UyS01TUGRjd2ZTNk00ZWFVcmFwV2FJNW1MT2JDM1JKSXRtTnRyTktnUVdM?=
 =?utf-8?B?eExXZnJnekR2K2V6Sll3NXJWTU1Kb1JZU2NLKytMSGZ5Mk9OVG1IUno2MTZU?=
 =?utf-8?B?WWpjalZ0UWRCNTQ3MGNtRU9XclQrQ09tWVRzcGxTbVpEOVlVOWg4Yy8zTjRP?=
 =?utf-8?B?RXpEUys1amJvNHVJdXN5UzRDZmZudGErL0RUd2c2RlRZZVZpNkt4ZkxLLy9z?=
 =?utf-8?B?TUl3RU5PWVMvSVhONko0TS9PTUtXOTFBbnliR2QzZ0R1dmllU2pVTHFtNU5I?=
 =?utf-8?B?aUpIdGlXSi9SU1RHQ21FSDhGdk82dTYxcGxFVE5INzgremFzd1gxVEY5c1d1?=
 =?utf-8?B?cGFuNExMQWttdHBoN2JnaUJvZnkzWlVwenl4YXZCUHk1MVJ5TXpVSURGSlEz?=
 =?utf-8?B?MncxYmYxaGo4VjlSOHhOeG50bVk2T2ZqeVpRb3hmaENyY0czWFlNYi9TMDd5?=
 =?utf-8?B?ZkQvWCtnOE9yMWxJM2xGN1cyZmdTZmVqWDZSMkhDTW4yRUJwaXNCNWtpT1dM?=
 =?utf-8?B?WlBza0JEeStSUUNUUzFuakpoQk5mK2JCUjIrNkhlYTNOcjFqZVVMQkFYVnpI?=
 =?utf-8?B?S2czUC8xc0RRdUlYRXFWZGRWRDZzVGlTaVpXNWpMUmVXYmNVT2wrOEd1Tkkx?=
 =?utf-8?B?dGNOVUp4L2t1SThUSmM3c3gwTGxOWWpPYk9Ua3hORW5OWGlkSm94L3E0RHBJ?=
 =?utf-8?B?UlYyOUhlZTNOTHBkMkNHRWdkU0ZLSkRZYlR3M1JNODFqYUNxUXZQN3BWZ214?=
 =?utf-8?B?Mzk4K2I0NHo4LzBtcGFEQjhZdy9kV0hsR3NXeVpRY1diWGw3c0VrVnZYb0gx?=
 =?utf-8?B?VWFqMjN5NGVxd294enZndy9TbXhocDhmMVRUVXFyUEtyMkJoKzltdXAreVRv?=
 =?utf-8?B?aEdiU25PTHcwVkxqRGRHcVp6bkJMSTJubTdPUHZ3K3pvTWd3SFREZHVOYnBw?=
 =?utf-8?B?bkl6eTdXODRKcmNUWXpSb3ZiSW01QXp2Q2IzRXdiajRLUDRCcXZUK2JSOEky?=
 =?utf-8?B?ZkJRbEpTa2tmUFV1TUtxaUNxRVRvTXVoOTNnSEo4Y3FtRjdpcGFobUtCdXo1?=
 =?utf-8?B?dlp2Tmh2MFRlZ3VHdnB2RjZhbzR5ck1nazlnODdqS3RMY2E3WmRUN1ZSRlJi?=
 =?utf-8?B?R2YwMDhhcjVVMis1MjlaZ3R5YXV3SUZGVW9kNmE1WFU1L0NBZzJuSUpSazcv?=
 =?utf-8?B?WndTYkdjZ25qd1UxQTBUR254R2dhN1JjSHB6b0NtOXhzMnoyOVJ3UjA5eDlK?=
 =?utf-8?B?dXcvaW1VbDU1TlhBd1JTQklFMkI5ZGRodldYL1Q1VFIrQ1MrMnhmY0MzSmdt?=
 =?utf-8?B?ZWRKbnJ4NGZoYXdHZnVWTGU2bDk4QkhVUEY1WlN6Q2l6UE4rZHhSZlBJUDEy?=
 =?utf-8?B?M1BmNE1sVlNUbkFadTJRNXMrMGkxWXRzS3ZtWE0ranMxK2lMV3h4TFVyZStF?=
 =?utf-8?B?UllQSFFLMGRZQjJta2pvYVlibk9ydkdlK0FkM3plVzE0cTUzY1hyNm41OXB0?=
 =?utf-8?B?ZGVvNnRNSEtzWFllQlpHVlVMSEhGbVEyeUVZUHBDYWpkOXAwM1JNc2U2cjVG?=
 =?utf-8?Q?D22MMvLRUnA1cXZA=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jornj6jGXBhB37n+5oiGJBp9Xhaom8TLETtNCBZ22PjOs36zPMkLOdS2s6vnM2Cxo4ewpH40oJDz2SkXha+oKkGvzFTSSQ47OgqQXT4KiqCZjZ7Jo0/II8jk1fXHcSjMrfFesegerUalVNEI+RXWK2dwDGuST97V+WWQY6iBKlzrHzuqq7kbGspOHgZdEvAPfnINYOfAFxa2H9TqswB0PukfOAjO2EHO5I9QCB0926x54R2nC0nL0UgtGRXXLPEbhsi+zc35vnZd8rV5UZo80PpFb5mo3BiHq/nU2G0fsvr/vePekLVDlPNKJ520dRE4iTaY0BqnnGHJ+hxGAnCczg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfd37ad-cc9c-42b6-6a2f-08debfffbe92
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 17:03:46.7920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SiTN3/gIF7hDKgUZPWWrYHA5wFwi4MgWNzQczTW7G3/if2cnZy6OeurphuccOEs+JEgM02C5pMpkMn6oZbeQEYbDjSdZB63I2rPdTCtT24U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6918
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iwCBjciyzJ_ST0nCEAiNV_Rnf53lHOeRzUA4tgCpHFE_1780333430
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293850-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 20CE162307F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiA+ICtzdGF0aWMgaW50IG5jbjI2MDAwX2xvb3BiYWNrKHN0cnVjdCBwaHlfZGV2aWNlICpwaHlk
ZXYsIGJvb2wgZW5hYmxlLA0KPiA+ICsgaW50IHNwZWVkKQ0KPiA+ICt7DQo+ID4gKyB1MTYgbWFz
ayA9IEJNQ1JfTE9PUEJBQ0s7DQo+ID4gKyB1MTYgY3RsID0gMDsNCj4gPiArDQo+ID4gKyBpZiAo
ZW5hYmxlKQ0KPiA+ICsgY3RsID0gQk1DUl9MT09QQkFDSzsNCj4gPiArIHJldHVybiBwaHlfbW9k
aWZ5KHBoeWRldiwgTUlJX0JNQ1IsIG1hc2ssIGN0bCk7DQo+ID4gK30NCj4gDQo+IGRwODM4Njdf
bG9vcGJhY2soKS4NCj4gDQo+IFRoZXJlIGlzIGFscmVhZHkgZ2VucGh5X2xvb3BiYWNrKCksIHNv
IGl0IHdpbGwgbmVlZCBhIG5hbWUgdG8gaW5kaWNhdGUNCj4gdGhlIHNwZWVkIGRvZXMgbm90IG1h
dHRlciwgYmVjYXVzZSBvbmx5IG9uZSBzcGVlZCBpcyBzdXBwb3J0ZWQgZXRjLg0KDQpBbmRyZXcs
DQoNCkhvdyBhYm91dCBnZW5waHlfbG9vcGJhY2tfZml4ZWRfc3BlZWQuIA0KDQoNCj4gDQo+IEFu
ZHJldw0KDQo=


