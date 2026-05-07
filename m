Return-Path: <netdev+bounces-285149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B3sG7ck/GnxLwAAu9opvQ
	(envelope-from <netdev+bounces-285149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 07:35:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 655724E321A
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 07:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3824B30028C1
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 05:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B64131E837;
	Thu,  7 May 2026 05:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="NbP7qxyT"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472F30C631;
	Thu,  7 May 2026 05:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778132146; cv=fail; b=B5pBh6QDFOcY8BS8Prct3oBZuFxrNkKLE7hz6FpZmHh09QW6uwH/bSQbqk/90V42O5Zqo5v1rhzBi2C4BdbxfQfMb9F5isniyaOc4ucW5E4IeJKT7DRBsgh3dmXmi6pK+5/ZCvQhwPr3XYlXcJjmIrRglnZJ5xHnwOCsbAtpgeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778132146; c=relaxed/simple;
	bh=EHlfiDhPJNiDgi0ay/EYGtjfBGjHUiUIyx6/iw+hZSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P/hld2dM1xLlQutEFK2L8xzm/5cp+P0bzC2mK/ZI9UulU+RmL8356qaKjR1FvDWeq8/kIeUyI1RoztkAV2Mwua/w9TvFkuOJc7Tq/2B+/uOsmeDoWEdFluxsr0YIljAxJdciJ1OZV3gB6XPIIByJyxo6Q7a7ppRH0NqTHdpLveA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=NbP7qxyT; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMiMD6ez83kbYPnAehJ7scV6QdbytxBRTorulgSicUq31U0sg/bRB/rWOJ0oGHPzEm8qhm0JOVhkZEfw07tFOusDEfw/+Qxre6siJT6phkSkXuPEz2JEZD7LCKp7HB3xzEbLbKutC3q9RuBs1bLMlMG2G00yj7PSCff8KnZE9XNfM5TGW+hUPuHvRF010jMUccuOHTEZyg5fzQoFR3B8FJmcd4mj6WHQiIy4olZSohsKZm5oyqxFJwUuj52bKTOTcJg9JSrbaBLoUt1A1WkN4CTphffLVlV79LYGpsvVUA3SBlPVvXMXnNlQWEDbPNoFg+oydpVBLfeV/cx1qzIRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHlfiDhPJNiDgi0ay/EYGtjfBGjHUiUIyx6/iw+hZSE=;
 b=Z3qYTO8xedIYCpSgmCrMxjlrgp+KzUqhirsOGxqG1Mqx69B3IvonBRa+0maaUkFwlQsiwToDxPGX4lmpv/ZBeJvJ65WqRhW7CVGON3ofDSTuD3QM3fN7RHLspa3axOS2MmVJ8E1eC/6bbARkc4KI4b7llEy8XpfhnL+MJc6yGwN+Nnswn9mwBmyXQCrM/5qXANPya0+3qRomxSdmkEiwl69Y11HTDM3AYpX3GMoMV3vgUrSF95IjFcSP82Y7jaBReLrRsomqaa/1ANKkMWqFp3B3kNkYvfsC5ETKVXBIpFFD9LaFmS/5BFevjjYtU+D1VedNgpJlyrrSEdOvbOEYwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHlfiDhPJNiDgi0ay/EYGtjfBGjHUiUIyx6/iw+hZSE=;
 b=NbP7qxyTDUCMsD7+JaMn0ZdU5CUguuUgXIPdcKUFpkAsa0sb7o6Z8c/oaRX3cCveIv6aAdcp+YQkLCaX6F1VJyStbxOcwuqFIJ/s8EJ2YvbTQi/Q4gZ/RVEzQKztKAHNugUEWy39tG+03tx0qX9S3RT9s9r4CCfv5xY8lRPP1WxczpR684jd50h1pca/77t6IxsSyBR+sb0TxiE64XyBYVqU/JsW8XIe8mqR8oyv3WUYlYQYLpYiLrgmBCyXKLAfXpn7ELkRw8w6ODr7wpePQ5cLaSN1lUsSA9T3AVMA5fP+YHy7X9P1Ictut289oJthHgDe6PDJ9PDqBDFytHQMHg==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SA6PR03MB7976.namprd03.prod.outlook.com (2603:10b6:806:432::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 05:35:40 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 05:35:40 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: stmmac: Add support for TX/RX channel
 interrupt
Thread-Topic: [PATCH net-next v3] net: stmmac: Add support for TX/RX channel
 interrupt
Thread-Index: AQHc3PwXTrAY/TsVzUeRgZ+hrAgumLYB0myAgAA6SIA=
Date: Thu, 7 May 2026 05:35:40 +0000
Message-ID: <80f72cf1-9271-4a74-a147-ff425acbd486@altera.com>
References:
 <20260506020018.25014-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260506190703.5937aea9@kernel.org>
In-Reply-To: <20260506190703.5937aea9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|SA6PR03MB7976:EE_
x-ms-office365-filtering-correlation-id: f4c5ca07-4828-4adc-3b69-08deabfa79ba
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|55112099003|38070700021;
x-microsoft-antispam-message-info:
 DDbTN4DUjFNhEZIMUvb98bslqxfdGNaLwdQKpVCpiLCkm2OY6AgxKqJOay/TpBUurkmOgrgyPo6aQLqmvZOfI6+09erSMaHL9lgJ9Vc/0uUmKw2t2LXNVo6AekMuRS8SfiWVwAoWKUGUAItQDllzdjMFezTiCrggQIiJS8UG7tmcDg3O1S3Eu1UXceQOmn/8oWYT3NY+NnrLPfkhFrgr7uKTE+AO6mwF8zxlr439YLg2QzJdCaNfmMNhu5O4kYV4m3THhD3UeKWgV7JVy4pLV00FqZIHsSGa5iq1xNw964LnOTbAMxZmyXC/NLzzYBIfGdCeRaYnIuxo6mlXLXao7xjj0LcanVlCG+OepSbz0/LnuVdepwqAPlpGRFWb3q31XcYIqoF9deeILFJCl7JQOapan8bs2aiXM4kBIWZoAdjbYOrrRDWD594FnXS3UztL0oxdfnuSSAbG86n+wejKoq+w+FtMNmWkzJYc2u90g1tOte+MLlPzZoO9dkFXNGVjRjIU+G+RD63M3nBtdNqLdkd14Kf+0McIr1RysYcaXbw97wBqKN3tgJa/WMp+M05pb7gd1gGhb9ZTbQwt9MW3RGte3Caa9sckU4M7EQWflSFKJm1IrSc5r9X3f15KkkjS1XCdJ7JsPMtOSk97CN5QZ4Z7AO8gPXs+VLTEjdPKGw5FjSX3W128F6YBkVfk3cSrXbicFGtQwp7ofT1MUyj2V9nLGVMsjRo+xe/WOKabxSQesvqKF8B+XHT6hA0ha966
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEgydjhXR2JBNGpxNzd3S2ZNcC9zVWZVQUxEOGtqNEZFNFdtTHVBNmVKZjBO?=
 =?utf-8?B?YnA5bmdNWlk1MDZ3VjFZcm5Hdy9Pc1NFZE80N2J5Wmx1MU51VUdxb01iLzdT?=
 =?utf-8?B?eGt4RTlxUTJnaDQyV2wrR0dCVmFBa0o5SU1uMnZGTlVyQzhsWlZQUXVYWHlm?=
 =?utf-8?B?SFBmakRxemJ5b0V5dFdYb3BCT1hwQkcxM3dxTEJNdW9yVEZNZFFVc2JPOVBO?=
 =?utf-8?B?R0srZWkzT2dmaFVzWDlnM0ZjKy96bVllbUdnbDZhbEd2NzF2a3NOSHpKZlJZ?=
 =?utf-8?B?Y2NVZUJpK2psN051MmdBMWwrTEg2bDY4d1dZSzJLRGU5OTNtZk9laEsrSjZo?=
 =?utf-8?B?ays1T0U1bERPRTlLK3NuMFY0OWtnTGlwbVltNk5ZeWdUTE5LTXh6cVV6eko4?=
 =?utf-8?B?ZE5KcjFhbVo0N2plZFIvVnBxQzBoaVJlRVZSUXB1b3U5NWxGSXE2ZThHbjVO?=
 =?utf-8?B?ZUlnc05tcHV3YkFLVlZEMno3RlViajhLcEhGZ09sTjArdTRva1hHcFRCUjNk?=
 =?utf-8?B?S1RxZTcrS01wbVRSMzI3V1RwSFI3SWRvNEpkVXREVDdGRFVrdDVmd1VNOEcv?=
 =?utf-8?B?ZUxZaVoxc1FyRkJrWnNxYXFoR005T0hGdHBSbkdZOUVzNlJ3QnlQUmJ6Mjds?=
 =?utf-8?B?YkxTSm9aZGVYa3B2OWtJdUdTcGdrRzZ1VEpXM2c2MGpYc3V6YXUyNzFrak55?=
 =?utf-8?B?MFB2VFA5T2VtOGZ4N3VCUmlGOEdWMDBOc1B5Y1Z5aWdVbTRtdzV2aUJpcjNT?=
 =?utf-8?B?YXFVL3lwaDYyeERRSitCTUhOWEJOK2RZMUMrd0s1UmcvSWd3K0JWN21iQk1B?=
 =?utf-8?B?UklNYnNyNVUwSjFQcDVqdlZkRHZrbm96eW5ZVTNUaWE0OVFQOEhtbkxYam9k?=
 =?utf-8?B?NjNTSmx2UU9vM2I2aklGL29UMXFUTmZNV29HQnZiTDFhaTRHNmpVSm8wcXUw?=
 =?utf-8?B?bnNac3pKc0NrdnB0V05WeDlRSE9IRzB4ay9VS0Zrb1ZtVTBTMDBaMGsxU0k2?=
 =?utf-8?B?cWR4eVVaUXRPUS9oMTBNMFlRMUIvOW00TmxaMEEwS1FLMms5N29CQ1ppSlZE?=
 =?utf-8?B?SDZzVXhGbHFseDN6SjhTSmtYZDROL25wQjV1TlNjNHYzaHpRYzMrbEVxQ1NQ?=
 =?utf-8?B?Vkl1aDhxcTQ1aHdsR0xkU1hqY3FJRmp3UnM4bEtHUGtndytITUEveXFDQzR3?=
 =?utf-8?B?S2VYWW1BT1k5R0p3dllEUmVjKzJkSFdHMXdtUkNHdUlLKzB6eUUzZXM2Mndv?=
 =?utf-8?B?NXI2dVVKcnNnOFNIRE5wWlpYOHhSemRXOGRMQW5LdVVYQUVZL0dQSnZPWUI3?=
 =?utf-8?B?VjlrRXd6MmU1MkltWVJ0bVZ4VmZoL2JLRnBnMXlJQnE5ZlJBWmdwMFl1UTEz?=
 =?utf-8?B?UERpWGhsTGJ5eWV2OXoxTVhzK2RBeE4zYXh5NFY3VkhrVUc3T1oxWEthR0F4?=
 =?utf-8?B?cU92cmJUakl4R1cxTkhja3VUK3JTQXFOVGw5Q005MWNabFBmUWdVZmtmRE53?=
 =?utf-8?B?UHVKeW0xOGVqckNSZzYzMzhsWHM1L05GSmUxWndaUXFUTHpNRC9qaFVVTzJK?=
 =?utf-8?B?aEdzNEg1NXVReERHejlQS0V1bm9oWWhIb2FnWm1lVEFEZHgwa3UvS0JFNFpW?=
 =?utf-8?B?dGoxVVBsREVIQlljeEwyUitHUUQ3N3pmS05yN1krb0MzcmFiakRGbUNUOHor?=
 =?utf-8?B?ZzY4Y0RkY1duQkZDcFIyQ1g1Q2VLSm11SW5sQzE2Y2JsRE9HR3kzRlk3MlRQ?=
 =?utf-8?B?ei9FVFlPd1JTeEdTR3crcE9FbnJkc29haTlMUFRxeWdkdFpoN2JGakZkdDlu?=
 =?utf-8?B?SWNXcUxka0hQQjlTTS9IcXZOQU83RDhxUEV4NUVIUzNrUU5abStrL2xieGJH?=
 =?utf-8?B?S2xzd2xOeGoxM1M2YzdRTW5Ba2txVU9ZREVneDFMS1ZMQUthR2ZlZS82ckhQ?=
 =?utf-8?B?elBFQU1PTjcvM0xWM0RhZEZZTnpqR3o3TVN2VUo0Y0o0VWREaWN2Znp3aWJY?=
 =?utf-8?B?THN4R091bWxZaVp1QndKVjlmb1ptbDRzelRNbzZVdDBaS0lPRXU5YnBiTkFi?=
 =?utf-8?B?WDVqdUQyTk5UUlpvdnhXRkIycU40ZUhEekpDek1SNDU2WGlHZEVDUEVLVG9h?=
 =?utf-8?B?VU15K2xwYnFraXRXeUZrRFJZOUZwNERWbzRwb1A1RXRQcldnWHpLWHBVUTA3?=
 =?utf-8?B?dmlKbk1NNXMxQi9PL1ZXK1ZrVXZGcG9iRGdMc2poSnYvV3plLzRMSEI3Z0Y5?=
 =?utf-8?B?WHZDZlFzeVplZzRYTmdDOE13amtJTk16YWp1QkdSMzJ6Z0JaQ1VhRzUyQlRk?=
 =?utf-8?B?c2paWlJQUWRNWmk0dm44dWVkZ1dFMU5QTWYvcTBNK3lnSGQxVzUwVDFEV0I4?=
 =?utf-8?Q?up4sGKnSB344HLW5RuJze/jf+Kyl+pt6/p/KxFy3D1Wc1?=
x-ms-exchange-antispam-messagedata-1: QOwRffIkxLABPLnwL0nkvrgLdtF2DbkpzUI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A63AC1D3AE2A91499B5873517B25411B@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c5ca07-4828-4adc-3b69-08deabfa79ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 05:35:40.5509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YNpuUo9rLlKCrkSlk0brUDjwD17rYxz6WLnNrd1kGi/dmVRA400/c6EKeOVA6ajU0z6Kmv3iui/u+7oxH4/M+dMb8fLNUJSP2Tu+GYaVtYNy3tWkqefARf739JC1j3m3I346gypKVMUWJ/bn6yNjIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7976
X-Rspamd-Queue-Id: 655724E321A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-285149-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,altera.com:email,altera.com:mid,altera.com:dkim]
X-Rspamd-Action: no action

T24gNy81LzIwMjYgMTA6MDcgYW0sIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiBPbiBUdWUsICA1
IE1heSAyMDI2IDE5OjAwOjE4IC0wNzAwDQo+IG11aGFtbWFkLm5hemltLmFtaXJ1bC5uYXpsZS5h
c21hZGVAYWx0ZXJhLmNvbSB3cm90ZToNCj4+IC0gQWRkIG5ldC1uZXh0IHRyZWUgcHJlZml4IHRv
IHN1YmplY3QgbGluZS4NCj4+IC0gRml4IHZhcmlhYmxlIGRlY2xhcmF0aW9ucyB0byBmb2xsb3cg
UmV2ZXJzZSBDaHJpc3RtYXMgVHJlZSBvcmRlci4NCj4gDQo+IFRoaXMgcGF0Y2ggZG9lcyBub3Qg
YXBwbHkgdG8gbmV0LW5leHQsIHBsZWFzZSByZWJhc2UgYW5kIHJlcG9zdC4NCnNvcnJ5LCBJIG92
ZXJsb29rIHRoaXMgZW1haWwsIHdpbGwgcmVwb3N0IGFnYWluLiBUaGFua3MgSmFrdWIhDQo=

