Return-Path: <netdev+bounces-295147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /yTxEHRKIWqOCgEAu9opvQ
	(envelope-from <netdev+bounces-295147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:50:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4DA63EAF1
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:50:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=deUFagc7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295147-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295147-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCA9B3015329
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 09:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE77A3A9D8E;
	Thu,  4 Jun 2026 09:47:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E22773FF;
	Thu,  4 Jun 2026 09:47:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566429; cv=fail; b=roHWLlLJR7kSxXM5mL3g6Rm8PUFfKXeRV45XcXDevYWa4KBUP3GN7/wbmHXroB++rO6DanK8hBpUCiSvccNnXG6WC9tizDCLRrT661zC2XEYyLwmF48z2FMCXgMe+OjZYedhGmP0evJOIgCFMi/DjpP0/dnCa3BB2NQGd2jvs4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566429; c=relaxed/simple;
	bh=flvufuMIUr+3e5Pza9GoljKxVNOhDYVrs94dPM5ZXZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZgACCx473uCTJIlQyt7ro50VjA6MO8M8JAnX+TLXKNo/9GOCgS61TIykky2RUcDiuOD0jjiUfaOglXlw7SbyBxXsRyw+JVAz0nIOaNMA+bpEZjDEieOzLDe6unshh8R/FPbQlSXTDmfpqWTGWwfDC2jjzxNdPYiP/dG2NfrTbIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=deUFagc7; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbhHqFZJCsSau2EGnz4a6515Jc1U7Lsq7FpQh1qtpxkZBwkZja/xyWKyvcx0NeUt5oqUyaydMMUNk2N8ahRKGR3dQVIn0fYgAEPPhqPoD5hm6Vx6m4/fokfR2f4BO31rsf71Ysk35Yw4zReCOt4/aOvZzJ/l0IzMQ/xmqrdyND6+UfJiTJhgSUzSQ0tFEHQ9ljJktfje9CVteq15jtp6EAWrqE8616NN5mpQRTShqvz8Ho5iDcdP49eKvIc3ny7daDLo708EnbRYWj4WrCltkA/vI2nY4vLTcUhnkGd7uGOIN9/h0W6B7SPVGSPqizeQPKSoS4+dP3712E/1ZH/KqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flvufuMIUr+3e5Pza9GoljKxVNOhDYVrs94dPM5ZXZE=;
 b=AJn1eyxthxd6pGd8qyvn1FBkhTnNV8NyWCgIUCMY2DHtOtjasJ2zhYJ008+NCu3ha5YeApqs8PZS4QowwSGduQfrAYoz8zK26pBPbibVbCaOt4pBS2lE6PNnn3YRDTVkSgz3dpi37yNigoPcxcSH16Is2RvELlzrmCvzZ2rcqrTCw5DTtkKAvVXOmM5U85SxldNcVcQCHezRueiToDleBDLV8kn24h+YkyiVXXOC+LQK6LH41pv8cEsSapqUqbgbZKcHqbSfcz8LBibZPDgeNfgaWnFFgTVypH09BCucrBg7nWL+UjlLDRkmW96VyF8SIUejlLxPwj28pr+2IJHvvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flvufuMIUr+3e5Pza9GoljKxVNOhDYVrs94dPM5ZXZE=;
 b=deUFagc7wyq2BitR4DO3BRDZqZ+SzNZHVRjcbfzeczwX+uiPMdVan07ka/M5rcoUPP87SzB9zGiXCQELmwURnjgy2LqTFGkeh2uZzx/Lm/Jjv5Fhi+vdtguOX792PPWc9W4PMmxOkDfTVbvLD2eVhkBPP5LKqEgI3WPX4vewQARFnJgWBfw1PboDP0aENhlFcp9eoLYZr9hHrIefOx9uIjMdCrFAXZ8TV8FSsMe55hirmYNhTGus/tDeRLcxO6DYqwwU3m/iMmyzfj4Q3zOqGscBLf61fgfpvdoeAnhLt2F+BQhAazo2JLDAviVn1h/hFnnCj1qIqe45H5oGnaYPjQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DM6PR03MB5228.namprd03.prod.outlook.com (2603:10b6:5:249::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 09:47:03 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:47:03 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: xgmac2: disable RBUE in default RX interrupt
 mask
Thread-Topic: [PATCH] net: stmmac: xgmac2: disable RBUE in default RX
 interrupt mask
Thread-Index: AQHc7zs59LjZoyL/IEeye5wZsOHR4bYlYYyAgAjBdwCAAAIIAIAACq+A
Date: Thu, 4 Jun 2026 09:47:02 +0000
Message-ID: <f87b9bd6-4269-495f-b3c0-de402aeabbe1@altera.com>
References:
 <20260529071734.27722-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <e10fe18a-a0a0-4c80-8ca6-88d0e0f18559@bootlin.com>
 <6837ed21-196a-48dd-b8b0-0f6691a946d0@altera.com>
 <90716dc8-f10f-4777-9939-829f7e8b84ca@bootlin.com>
In-Reply-To: <90716dc8-f10f-4777-9939-829f7e8b84ca@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|DM6PR03MB5228:EE_
x-ms-office365-filtering-correlation-id: ed60a241-2b55-4d38-bff7-08dec21e3b25
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|4143699003|56012099006|11063799006|22082099003|18002099003|55112099003|38070700021;
x-microsoft-antispam-message-info:
 nKRWthZg9k7WoVzP91K2BioarVnEw7zXD74NsZqoDlAY7yGssFaJusXN8jt0GhfH28Frsl622wfcKl7b3opM8CYWzY2/GuQ24njSkKEN86D9m6XW1qFo2K0dhOpv6IwoPwvljz2BcJzxsuYW9azKw+A7wF6AYH8aQlDh/YGULLyUXFGDtKK8js/Cc9oCH0rzAKv9wwqgXLj7xTJa5T2BpaDs94rDmpfSMqLo8V2ANJbYTPv1IRMXrba+sDhdGZIpeWWNGAKOjst31OE6t7ssmhZXgPlT91OfxLgNybayvhWPu0mTNAKN0Mxk4VYLw2nWK9pU5aHAmhRy3aN0NvRGTJtYfpU4vqxslDQKN0fmvo7NoXIEFthiNC1uOh+dOKFviwLGhplxiqiRXFtIr1tDLXolWcURn0aJE8Ic+8n0qAnPLHDggUNd8txhBPQL//kjmDor0ZDrECiKZVLMseihySZ6b9fdijmNIALFPkx4QSs4g+2l5VhXjx1WrxSKmfVanL5wMOzfdpcGmSXiCA6lHPdKOj83o14x4VeU3MaGEMd3S4R2o9AgtmEkZSzf0XJz6Sboy82CgUo0YbvZtwZjrkehyWAEEYJJg4MP98BhM2QOCyDnhpvJPg4LpHVOkPt4j6JEFtRBecZItZBQeVTKUKL+7kpbLLw6Gh2oXwtWUk0tlvt+PcN0DgoOYcjpVIRsXWDTdU+N9PSxhyIqoQRxYYR+wHi3Melne7QR1NjfdYjvNEp3x7npSaUwS9CxsMXF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnRsUER5dWlLaHpIV01rNkllem8vZDZpSkd6NEozMEdocldBSnYzeENjSFVL?=
 =?utf-8?B?WTNuU3RYeDY2TXNPTVlNMGxLYk4vRXNya1FWZXozbEZ4WVlOV1Ztc0JQTWNU?=
 =?utf-8?B?VGMwNmM0MTE0dll5YnJrV3IzUEVZNDBaaVdpWGRWTkpqMzBqNTJHVVduTUNh?=
 =?utf-8?B?dDVvOXI5OTJTRWRNRGtacGxqS29rZ0I2aFEvdWgyUmRKd3NhZytLYnpYbFVj?=
 =?utf-8?B?NVpmbWtoZXdYTzlHcEJIbWVQMytWeEVLUTc1MmEvLzZLN2x5VFdod1VsdURr?=
 =?utf-8?B?TEJMYTUrVmZjTkxNSVI0MG9EVDhKNS9vNlZid3R3NWZVM0lwZTNMS0txdjhX?=
 =?utf-8?B?SlVET2dGcTJZazR5d2FLQk1mL1VYKzIrdUpDY3ZrUVprYlZDci9OVitqRUxS?=
 =?utf-8?B?bHJncVRoSW1WQVRHaVNHQXJsMXF1b08xQlhmekxPNEpvU2RnSmE0bklqZUUw?=
 =?utf-8?B?Um9SaVlTczFXQ3pxRGRUTGRhUk9jMFdYYk55bnNjVVdJMWNYcy9CQTZ3NmFp?=
 =?utf-8?B?bkMyMm0vSGxPV1R3NnBtdkE0NGVMUnMwSHEza1NhZFdrZmh4TndBWlM4NEhu?=
 =?utf-8?B?UTR2TVhtNlNiT0V0dmlaK1V3Q1c2NHlPQWdEL2ZaMkovVnNtcWxSMDVGZzR0?=
 =?utf-8?B?Q1pFR0ZLN0Rqc3lndjJBWDU2T2E0Z21idlZYcEhhbzZwQmhUL3F6OGpia2lK?=
 =?utf-8?B?TmtUeGMxUXlJb2lYay84VzgwUEZpYStsMGZ3YUVyL1dOVmpJSUtxbE5GSkpp?=
 =?utf-8?B?KzRySjFvMXcvQ1lHVUpwbVlBNXR2dFNPMEtzZEFEOHFPWURFWlpmaGV5cUJq?=
 =?utf-8?B?WE1uS0hSZFF6endpdi9ZWmVMWVRIVzkvc1JlUHBWdmdXZittU0dJbWRWVWND?=
 =?utf-8?B?YWRGd0M2MTcxQUxNYTBsMlAxT2pMZ3BHa1A3L05Cam1JYTVSYVBkNW16amll?=
 =?utf-8?B?R202c1lQT3JHVS9udGtGVk16SytkbnByY2VtT3NnakxabU9LSjhGMEtIeWww?=
 =?utf-8?B?QWtHZ0FEdXZuTlRYa3hoUzhaRVQzTFRGVGhpT3lIb3R4Ti91NjMyTTlUUWo1?=
 =?utf-8?B?ZHNIWjNBdk1MUitaL0s3MW1EcVpGbit4VkxDMWVBb29VQ3Q2U2gzd004K3FV?=
 =?utf-8?B?TVNvcGRBb2NraWVWdDBvRWlWM0xNZ1g4NTJPTGVaZ29PSmJobXljYisybHp3?=
 =?utf-8?B?VDNkQjA2clJRcGR5bk9QcDZmamN3STJkRlQxL1g5NmpGdnNjMDQwNnNWT0Zh?=
 =?utf-8?B?NTBaajY3SnBjR21udjBjc3laVG53YjNjQUp1VUFsNEV6ZTZTZ2NQcytLcEpB?=
 =?utf-8?B?cStiSTdWY1RHdDZzL0wxSXZDUzJGR3lFZTg0eUFaY0F3NStlOG4xb2pDVGlr?=
 =?utf-8?B?b0hmbkNmbXd1WVFzekFVZFFZcVZBU0h3aThnM3VtWjg0QjBtV1gvajV6SWR2?=
 =?utf-8?B?MTUwbUFrenlpQTBaMFl5bURjWGNwci9uczVLTUIxZURtcXpCMGZXZjV0QUFI?=
 =?utf-8?B?QnVYNWhwSmlheHJWSzZKODdmRVgwaDhXbDNSbU51L05VOTR4czFhZEhrWk84?=
 =?utf-8?B?SzlnRHhHZSs5dFYyY2dDR2NQS2h3UTY0NGpqRlJXZEw5bHJXRHJ4dW5Tdnd6?=
 =?utf-8?B?R0NKM2xnVWRBS1kyQzZwRGRZL0dhbDQrZ2tRbTBhWDI1SVA4Y2QvbmU3THZv?=
 =?utf-8?B?aWhTMjBKOGZ0QWp6MHVoclFtcExybGNmK2hobjQ1RkI1L05MSFNES2J5MHVs?=
 =?utf-8?B?V1lMTjExYnNJc3A1K0dzTkhZOThrbW5jd3o5bFRkYXk0dXVOK3JGRWd0UWMy?=
 =?utf-8?B?eEg4OTU1NndTc0F3SFdiUlBhWXN4cGpNNTRzM1hqM09JZXZZOGR2Zms3M001?=
 =?utf-8?B?aHBFTGs4OS9Bc1ErVkR4ekluU0hPcDJQMUVqNXRMQ1g3Rk42Y2kySzROK1Uv?=
 =?utf-8?B?bkdlbGtIUEhzWXZmTDNCYzgxRXA0UWpxMWl3WGRlWHkwbm1UdlVxTGl6dkxQ?=
 =?utf-8?B?QXRFNngyTURXeHV2eHZLOTdHVnkwU29RZ21jdGlqRlRWcEkvUkZPVytjd3d3?=
 =?utf-8?B?SWxsM3RTZVdicHViY2dVeVdMSEFGSlVtemN2NHFhMVdtd3BYM0Q4Zk9scEdC?=
 =?utf-8?B?RjZvczZXSDlLL1RETVJuWW9mNmdKSEFWVlIwa3JyRUt2OWNRUUFuYkc0b3Rs?=
 =?utf-8?B?TzNDWEo1R3l6MTVnZ3ZndldVT1dudFBBTVBtZVRXa3NXYUtHL0YzQ1BtT05o?=
 =?utf-8?B?UDdoVFNZVXRZYUVOZlFWR25JbWFBeEp5c0ZSNlB6V29mNk03RUkweDZpNE9o?=
 =?utf-8?B?dS9obDlxcmI1U2pyRkpxYkY1YzU3OU9vdjR4elRFQkZhU0hPUnV6b2RlMFIw?=
 =?utf-8?Q?seh6vNdGSb36KnZAcnF4ckLyzQkq242yPzfAKttYJiNOa?=
x-ms-exchange-antispam-messagedata-1: rdA3n3SNGhN5EA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF2E82F934783849B36534A155A17056@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed60a241-2b55-4d38-bff7-08dec21e3b25
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 09:47:03.0279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMyzIcQ+tCPVVcYclzvqfvX5x7sAdNnKptnt+LTQlnSqRDILc+KUtTcD4DtCru6+2TWc55UlO8bnt5rIMt+qRC/l17OC/j9KqYSwHXrstStgzwSf2iqWlfziHumH6oUzyN2dhBJD2gVrF94CQEN2bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5228
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-295147-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,synopsys.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:mid,altera.com:from_mime,altera.com:dkim,vger.kernel.org:from_smtp,bootlin.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC4DA63EAF1

T24gNC82LzIwMjYgNTowOCBwbSwgTWF4aW1lIENoZXZhbGxpZXIgd3JvdGU6DQo+IEhpLA0KPiAN
Cj4+PiB0byBub3RlIHRoYXQgaXQnbGwNCj4+PiBub3cgbWFrZSB0aGUgInJ4X2J1Zl91bmF2X2ly
cSIgc3RhdCAodGhhdCB3ZSBjYW4gcXVlcnkgZnJvbSB1c2Vyc3BhY2UpDQo+Pj4gc3R1Y2sgYXQg
MCBub3cuDQo+Pj4NCj4+PiBUaGF0J3MgYSB1c2VyLXZpc2libGUgYmVoYXZpb3VyIGNoYW5nZSwg
Zm9yIGEgc3RhdCB0aGF0IGNhbiBiZSB1c2VmdWwsDQo+Pj4gb25lIGNvdWxkIGNvbnNpZGVyIHRo
YXQgYSB1QVBJIGNoYW5nZS4uLg0KPj4+DQo+Pj4gRG8geW91IGhhdmUgc29tZSBudW1iZXJzIG9u
IHRoZSBwZXJmIGltcGFjdCB5b3Ugc2VlIHdoZW4gYnVmZmVyDQo+Pj4gc3RhcnZhdGlvbiBoaXRz
IHRvIHNlZSB3aGF0IHdlIGFyZSBnYWluaW5nL2xvc2luZyBoZXJlID8NCj4+Pg0KPj4+IE1heGlt
ZQ0KPj4+DQo+PiBIaSBNYXhpbWUsDQo+Pg0KPj4gVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IGFu
ZCBmb3IgcG9pbnRpbmcgb3V0IHRoZSByeF9idWZfdW5hdl9pcnEgY29uY2Vybi4NCj4+DQo+PiBX
ZSBkbyBoYXZlIGludGVycnVwdCBzdG9ybSBkYXRhIHRvIHNoYXJlLiBPbiBBZ2lsZXg1LCB1bmRl
ciBoZWF2eSBSWA0KPj4gcHJlc3N1cmUgd2Ugb2JzZXJ2ZWQ6DQo+Pg0KPj4gVW5kZXIgaGVhdnkg
UlggcHJlc3N1cmUgd2Ugb2JzZXJ2ZWQgZXRoMDptYWMgZmlyaW5nIDEsODIxLDgxMSw1NTUgdGlt
ZXMNCj4+IHZzIDIsNjE4LDYyNyBhY3R1YWwgUlggY29tcGxldGlvbnMgb24gZXRoMDpyeC0wIOKA
lCBhIH42OTV4IHJhdGlvLg0KPiANCj4gT3VjaCBpbmRlZWQuIFRoZSBzdGF0IGl0c2VsZiBoYXMg
dG8gc3RheSwgYnV0IHRoZSBiZWhhdmlvdXIgb2YgdGhhdA0KPiBjb3VudGVyIGlzIGFscmVhZHkg
ZGlmZmVyZW50IGRlcGVuZGluZyBvbiB0aGUgRFdNQUMgY29yZSB2ZXJzaW9uLg0KPiANCj4gSSB0
aGluayB3ZSBjYW4gZ2V0IHRoaXMgcGF0Y2ggaW4sIGJ1dCBwbGVhc2Ugc3RhdGUgaW4gdGhlIGNv
bW1pdCBtZXNzYWdlDQo+IHRoZSBwZXJmb3JtYW5jZSBtZWFzdXJlbWVudHMgeW91J3JlIG1lbnRp
b25pbmcsIGFzIHdlbGwgYXMgdGhlIGZhY3QNCj4gdGhhdCB0aGUgY291bnRlciB3aWxsIG5vdyBh
bHdheXMgc2hvdyBhdCAwIG9uIFhHTUFDMiBkZXZpY2VzLg0KPiANCj4gTWF5YmUgd2UnbGwgZXZl
bnR1YWxseSBuZWVkIHNvbWUgc3dpdGNoIHRvIHRvZ2dsZSB0aGVzZSBjb3VudGVycywgYXMgaXQn
cw0KPiBzb21lIHZhbHVhYmxlIGluZm9ybWF0aW9uIHdoZW4gZGVidWdnaW5nLCBidXQgaGFzIGEg
c2lnbmlmaWNhbnQgaW1wYWN0IG9uDQo+IHNwZWVkcy4NCj4gDQo+IFdpdGggdGhlIGNvbW1pdCBs
b2cgdXBkYXRlcywNCj4gDQo+IFJldmlld2VkLWJ5OiBNYXhpbWUgQ2hldmFsbGllciA8bWF4aW1l
LmNoZXZhbGxpZXJAYm9vdGxpbi5jb20+DQo+IA0KPj4NCj4+IEJSLA0KPj4gTmF6aW0NCj4gDQpI
aSBNYXhpbWUsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXchIENvbW1pdCBtZXNzYWdlIG5vdyB1
cGRhdGVkIGluIHYyDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA2MDQwOTQ1MTIu
MjEyNDMtMS1tdWhhbW1hZC5uYXppbS5hbWlydWwubmF6bGUuYXNtYWRlQGFsdGVyYS5jb20vDQoN
CkJSLA0KTmF6aW0NCg==

