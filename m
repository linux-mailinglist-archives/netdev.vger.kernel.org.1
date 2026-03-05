Return-Path: <netdev+bounces-264184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHsRBggPqWl80wAAu9opvQ
	(envelope-from <netdev+bounces-264184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 06:05:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E44F20AF24
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 06:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29A27301F313
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 05:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FD2266B67;
	Thu,  5 Mar 2026 05:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="UnO2oU7G"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022122.outbound.protection.outlook.com [40.107.75.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF29256C70;
	Thu,  5 Mar 2026 05:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772687109; cv=fail; b=JSojBbFBCNFSYPqaZ6ml/6M80lMqrVio87oIKQ4RJiEMI9C02IQb5bGHaVZF5acIwNBQHManPT06pu+IVvBxHJN8veUap6V3EyK0q/BeqsGXTXu99O5ylJ2641BgoseI2+Qf717V+/kkUmCCbNtWSolmKL3hNTJ+Sn5CTKB4mIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772687109; c=relaxed/simple;
	bh=/sHAhj9wNzRfb5p7/kkVsgqS6rgt06l4ydGbbpiq71o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FXHBdv2QAL9JMu/zoccYcZqZWp0DAQLuz8kotDOlf+d82UrkVC8zH/4ts29FhfaMiCMF1QRkHeKidEcNbOpUHnUeS7/WuxqsKkCpTrSuyMA2wWznrLaR/0qeLs/lVJ1njPDMG/5ceW/MMQZ6/ghL8jigB0KTNXVG9MTtGK+6HTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=UnO2oU7G; arc=fail smtp.client-ip=40.107.75.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHKxExy2xjdZa2YmzLHY2eLT4+E4vHuNg+lNpzezGJZR7CrCnx6Mpj6S4blAi2BTNcBLIPO54up5NgND95d9OdppdA72Pje6yWquHlDlBLsBDUnigCnJDd0KEs2CkFtvNzLzfVMIP+jS9kwpypVtrtyE/bUGsno/5L1x4OxPHIovsvP2X3c36GPIDKQZkIJlDBcO7riFAi/8yPDavTtlq5ryW+RID4GNRGaeRSsEdGA4QtYnP/lIjC+5t3YPu3M0oV8zt+RaxPeioeobJqZqxP9z4V1DXzyhbvjG+MgSgt2dp6A7QKTUIWUZ1VQK1p7Y/HeW4aEMSUao/mFA3rs+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sHAhj9wNzRfb5p7/kkVsgqS6rgt06l4ydGbbpiq71o=;
 b=vPVWAGX2k1UgOGIhupd3AYiFh5wry4svqjLmihBsPQl0Sm5xGPruvFYcAVnV36VfMWlnDvVxns37Cu0OiTM4g7dEd2s/yddZDrXe2CZYThSCoSsSiiTwMeb92XOI+O/lxVOMARn94ebtemISN0Y9fDLrifsnAqnNw+KcmRfjWoHjlqtBxkMCFKwizolywtC9A1X8g3V3wSYFJlv28vULaQhHUwf8g2e1pRThj4zihKl7UTlZM4eaowDmMLiRJV+1+JkXj9iI36k91Hp/JQVMuampOR09tylGgzglgKOryQox3g0KJ8j5y7+z0uZNJ/+IyW0/wiKcRiWi0lR3s+JGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sHAhj9wNzRfb5p7/kkVsgqS6rgt06l4ydGbbpiq71o=;
 b=UnO2oU7GlyE6hYXQzRscMtktfdPnkJqQ/vfWHCRgX9R9ryXUENn0k6xWGkM0idw8yLjSiCtzAvi9EwVtFqS2AsMtfy4r9ItjqjQHiYg9nRwCDv22XR9/2OsTOAjV+6c356cTQec6N4u86icXMP5K46dumpUEAsJn5kjw7ip8EubI8iASTewYPMz6HYuGaD2YQ2kEOBA9igeE0uB/5Z0zgfmaii0WeCUYGej/tMmdZZo9ddXwNhOnjaWfGIWNFriFXW4wQGBZTHxZXc6vqS/iBWecIp5DZABLa2HXd7oY++3gMURa+PSm8J7UTrwszCF7YAwDhKlqz5UOHrCuKakkAw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by KL1PR06MB6865.apcprd06.prod.outlook.com (2603:1096:820:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 05:05:03 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9654.020; Thu, 5 Mar 2026
 05:05:03 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject: [PATCH net-next v6 5/5] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
Thread-Topic: [PATCH net-next v6 5/5] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
Thread-Index: AQHcqi7Gxnd/yfDNn0+qSBvgjkBecbWbib0AgAPdJDA=
Date: Thu, 5 Mar 2026 05:05:03 +0000
Message-ID:
 <SEYPR06MB5134AE0B0042E05E8E58A5239D7DA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-5-68319a4c4110@aspeedtech.com>
 <d38f54b2-4a99-4a54-8403-e4f4a9704386@lunn.ch>
In-Reply-To: <d38f54b2-4a99-4a54-8403-e4f4a9704386@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|KL1PR06MB6865:EE_
x-ms-office365-filtering-correlation-id: 32cfb30e-0d47-44a9-9eae-08de7a74c293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 HqVADbgSL41l8NLdaxa7ZAKt0EMDzL+sHKUWJdd0u4Q31biMhlP8OOEulB+opbQvpEQtt8L/LIZjiQic4EMhc88dsiMMDbzxDlbrDTZkoy4xLUIHpOOfa6W2tn439DrGMv/fOz1sr4zumX/Jjv3k5AqUKBG4WW9oIKShXa9MiyKcOg81g8J+9ppwnmozAVi0YSck67e0yN0UJirL4gFjwgcpWY4RVfRCyOhnVp8cdOP/LFXBBcPSi7V/BDu+P+WbPemtcgHQFEAhDax6cwFTDv7J9iZJctE7Nxe36eaSTvw0Un1Oi+5a6u1ZWyrt4awRDQx2nIRFnOAkZKPMN9TUeUFw9M21M7EazQajRhs67ItM5rINaEaz5S7lNuGzU/8HyxlVSpALOXrZPQe4ad/M8Pd9iQKE87PTcfmlGDwg6ddAPVUoBY9nFYxub9QP+jqrASGvygrU4gTYCSTuIo3qiehLTsTilQ43E0WX8OBZp5LAAruAKy74FZiKOyEChmqCJgU1c34k04gMK1OdCYlK/yTZf9NpANfwy+jIIjo1nea78cEA5nK6aI4GwtNvYJ5E966OTx1+4RwRFjSNptnah8Uv/zJIur7spm5se/kZOvHVo9UqWsrX+ARTA+gbyREOeUOypeI2rTAWzsg0ILMJELyBC1gxHjpTaS6xOv3c4zlzZk1WJhnVMbALKeiqCVrZ3rrlKn6Kv5DUSeXToY8/pFBf1Dg1a6w1WI0vF1NfOrmv5KoTVyhgCq+AczDx1ms4ajZlG1Lk8f8sCfkYREFWKTrdrDJdIL4mH49nRLEh60I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekZLeXhFcjNpZk1sNUZ0UEV4cGkyN3o5Rk9lTlB6RlNFN0lNQkZSZUlzeXBY?=
 =?utf-8?B?VHFjb25hNkI5aDBST000SFcvNjlGN3drL0ZTV2trRGd2WkR0d005YmZnSFdo?=
 =?utf-8?B?dG02OUw0UkRiTUo0Y0J6S3ZRUVlYejJVMnZlTzhvL2l6aW5LVm5mOVhUd0M5?=
 =?utf-8?B?aVJHTU5EYmFnNmlxczRjaTNucHpaR3hveG1MZkxhK0pPNUFhNXJFc1hqQmRV?=
 =?utf-8?B?WGZYeThXQU5BdHoxVWFvTVhqeS8wS0tBWHl2V0IyOTI4S0tqb2FlMlc1OXlv?=
 =?utf-8?B?cWpURlcyc20vazd1QVM3YXEzUHNCbmdqb3dpN0R3Q1NNN3MrL0R0QXlqK09z?=
 =?utf-8?B?K05XcHBLTlFwQmFYYVh6bGxCSzdhRTUxTUNNbkYrb2srZjZKdnJSVFRNTXhX?=
 =?utf-8?B?NzVJczlmVXcyMzVCc0hqdUxOZnNqVzM2M2puQmd5dFREUTJBNk55NXJXaGtU?=
 =?utf-8?B?eDFNcnFqV3M0TlFNeXZEdTVRQnNLa0xyWStPQklGU3pTM1Rra2dsbHdaT2lu?=
 =?utf-8?B?Q3crUXZEUnFZS2RBcmx0OUF1OTZYM1R6Z0ViaEVsU2lKRjhoTFpPTENuOHRK?=
 =?utf-8?B?bEpSYzE2Qi9udkFhMTJhdHRtTVFtUmVUalVZRm82dE8yWjRBNnBBV1pKWWpU?=
 =?utf-8?B?L2VSVG0wa2Job09DcG9DNFF0ZHhTZnV3WTIwUGNWOXQ4bUoyN1hyOUcycE8y?=
 =?utf-8?B?SzRKMlluaS84TlVEcVdrV0NHWlFSV0pZU0lIaHhPVEJWQzNwTFhBb2hPZUVy?=
 =?utf-8?B?amthL05zVWttckFCMVFhRTBoRUtKNFNhN0x6RXhWdmhEZ0JkVm5lYUlSMHFZ?=
 =?utf-8?B?aFNzVXY0MWxMRUozSXJ1M2NmVFk1WlIyRkh3ZDRzRjdTalB1VmE2OE5JTk15?=
 =?utf-8?B?enI2d2dSNVdWRkRZTmc5V2Ezc2QwRDh6VG1TSFpZb3Y1WHRmbjFaVFUxM09u?=
 =?utf-8?B?cFh6V3FMaWYzSVpLWk90MCtiSG9NYjI3bzZXbGhCblhBVUJ4RkFzZXFON1Zx?=
 =?utf-8?B?UWVWV0RlZytxN3dLZ0txNWZCSWgyTFNHb2ZDL0drRktwRUVwdkRndUczWGk4?=
 =?utf-8?B?djFZVC9ndVVoRS9jN0dwVDRpeFl6WVJRVDFlNVE1L0RvRFhSbHZrWHpnV2lO?=
 =?utf-8?B?QVpUemFRN0hxM2srbUJsUnk0YkRkUnJaVFNJd3p1R08wRDBGWlFPWStDeVEv?=
 =?utf-8?B?RWwxUVhvQjV5bUF4TSt2M2NFc3FJSDZBeW1pTDZVY3M4OXF3M3VKWlJQQXd1?=
 =?utf-8?B?ZDdvNWFPSnEvRHorQ1JTL091cUxib2p1c2Vyc05NdFlzenNCSUNJL2FSazdQ?=
 =?utf-8?B?VzdObjBoOExjUmFZZmxoS3hVZ1JZRlNHV3EyeDJWekh4Ri92b3o1aDRXSGZH?=
 =?utf-8?B?LzJTdDBWc244UjBBQ2NPc2tFanhoSkpaNEpQeERUT1h3L3g2Sk1RQWpIMkhE?=
 =?utf-8?B?YkZhSUZHSUNmVng3dC9RUVlqRUxuelJwbHVSdVpZWEdyMnNtcmtLY1VXcWVo?=
 =?utf-8?B?Q1o0a2NSdHdoTmQ0QnA5bUJJdDg0K2NXaS94bG1RN0VHcEZpSEp6VTBCZnRY?=
 =?utf-8?B?U2kwdk45MFFTbnp2Qlg1cTZadkxmY2tUTm5wSnBjSm0yRlBlSDhNRmpFanho?=
 =?utf-8?B?aWVBOE16VW93cm4rZzR2MityZ0JIT3g0UXZ5NzlVNzBuaTVxY1cxem0zRDlh?=
 =?utf-8?B?WTk1eS90QXozeW56dXBaWlBRcUJQSTRpN1A5V2lVTDdxRlo4dU4ybHdjdGk0?=
 =?utf-8?B?TTBpSVFFbitzN1lPK3R6eXFIYzAvN0FCd0hVWFBKWFpyQmcvNXhUUGN6dnVQ?=
 =?utf-8?B?NkZrbTlkM1V6OWJUa3M4LzB1UXYxOXBETFkyNllNRWcxZGlUUkFuZElHTUFk?=
 =?utf-8?B?OW13UnROaTR0YXVzbDZYeDVhWjJhUUxaLzlYYXNyVlRlMi9CUlM5YXB5cXht?=
 =?utf-8?B?bE8xR1NsT0dCSUV1TDNkL0NLRHRoWGdxMlBFd3kvTEdvMUFYZnlzUmF0MmhK?=
 =?utf-8?B?dzN3YlNSOXNpUFV3TzJVRFpsZHNzMDNNMGNtQTVZc2paSEljN2gvNmRHY2dL?=
 =?utf-8?B?R0ZPam52OG9QSW9IRWNTTlRmL0xjZzVoa29ud1R0U3VEaVUyMVlqYTdNeVZP?=
 =?utf-8?B?Sjc3ZS9DSWZWbDBySEIvNk8yWGVKL1lTakV3L0VmSGZyMnRrTERxUSttVVZl?=
 =?utf-8?B?ejVvbGd5NU5RbmNxNjZMcXF1TzZKMzdzNVRWYW50dXYrME4weGVzUUNJZ0hv?=
 =?utf-8?B?Y2hVMlRMbExFTlduaVlpK25KdFQvNVZkaUlUcWRZN0w0OUVDRWZRQzdCU05F?=
 =?utf-8?B?dHgzUDBhVUJEanpLTUxtNVltb0QweU5jS0VFZ1hpdFVmN2hLeWtMdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cfb30e-0d47-44a9-9eae-08de7a74c293
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 05:05:03.2227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcvAO8KbZpvTpVOcAOJBkpKmtxChDg2Ob3jPIYOlaVYugstIB5JO4pqpnfUD8Ccy5tOzRebQzk6d4FdLjoYIHnHyJeUvEl/tb5VQa8AcQl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6865
X-Rspamd-Queue-Id: 6E44F20AF24
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[aspeedtech.com,quarantine];
	R_DKIM_ALLOW(-0.20)[aspeedtech.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264184-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[aspeedtech.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aspeedtech.com:dkim,aspeedtech.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,SEYPR06MB5134.apcprd06.prod.outlook.com:mid,0.0.0.0:email]
X-Rspamd-Action: no action

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHlvciByZXBseS4NCg0KPiBPbiBNb24sIE1hciAw
MiwgMjAyNiBhdCAwNjoyNDozMlBNICswODAwLCBKYWNreSBDaG91IHdyb3RlOg0KPiA+IFRoaXMg
Y2hhbmdlIHNldHMgdGhlIHJ4LWludGVybmFsLWRlbGF5LXBzIGFuZCB0eC1pbnRlcm5hbC1kZWxh
eS1wcw0KPiA+IHByb3BlcnRpZXMgdG8gY29udHJvbCB0aGUgUkdNSUkgc2lnbmFsIGRlbGF5Lg0K
PiA+IFRoZSBwaHktbW9kZSBmb3IgTUFDMOKAk01BQzMgaXMgdXBkYXRlZCB0byAicmdtaWktaWQi
IHRvIGVuYWJsZSBUWC9SWA0KPiA+IGludGVybmFsIGRlbGF5IG9uIHRoZSBQSFkgYW5kIGRpc2Fi
bGUgdGhlIGNvcnJlc3BvbmRpbmcgZGVsYXkgb24gdGhlDQo+ID4gTUFDLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogSmFja3kgQ2hvdSA8amFja3lfY2hvdUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAt
LS0NCj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1hc3QyNjAwLWV2Yi5kdHMg
fCAyMA0KPiA+ICsrKysrKysrKysrKysrKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYXN0MjYwMC1ldmIuZHRzDQo+ID4gYi9hcmNoL2Fy
bS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWFzdDI2MDAtZXZiLmR0cw0KPiA+IGluZGV4IDNmMmNh
OWRhMGJlMi4uYTJhMWMxZGJiODMwIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2FzcGVlZC9hc3BlZWQtYXN0MjYwMC1ldmIuZHRzDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvYXNwZWVkL2FzcGVlZC1hc3QyNjAwLWV2Yi5kdHMNCj4gPiBAQCAtMTIzLDQyICsxMjMsNTQg
QEAgZXRocGh5MzogZXRoZXJuZXQtcGh5QDAgew0KPiA+ICAmbWFjMCB7DQo+ID4gIAlzdGF0dXMg
PSAib2theSI7DQo+ID4NCj4gPiAtCXBoeS1tb2RlID0gInJnbWlpLXJ4aWQiOw0KPiA+ICsJcGh5
LW1vZGUgPSAicmdtaWktaWQiOw0KPiA+ICAJcGh5LWhhbmRsZSA9IDwmZXRocGh5MD47DQo+ID4N
Cj4gPiAgCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gIAlwaW5jdHJsLTAgPSA8JnBp
bmN0cmxfcmdtaWkxX2RlZmF1bHQ+Ow0KPiA+ICsNCj4gPiArCXJ4LWludGVybmFsLWRlbGF5LXBz
ID0gPDA+Ow0KPiA+ICsJdHgtaW50ZXJuYWwtZGVsYXktcHMgPSA8MD47DQo+IA0KPiBJbiB0aGUg
YmluZGluZywgeW91IHNhaWQgdGhlc2UgZGVmYXVsdCB0byAwLiBTbyB5b3UgZG9uJ3QgbmVlZCB0
aGVtLg0KPiANCj4gSXQgaXMgYWxzbyBvZGQgdGhhdCByZ21paS1yeGlkIGJlY29tZXMgcm1naWkt
aWQsIHlldCBib3RoIGRlbGF5cyBhcmUgMD8NCj4gDQo+IFdoYXQgd2FzIHRoZSBib290bG9hZGVy
IGRvaW5nPyBUaGlzIGlzIHdvcnRoIGEgY29tbWVudCBpbiB0aGUgY29tbWl0DQo+IG1lc3NhZ2Vz
Lg0KPiANCg0KQmVmb3JlIHRoaXMgcGF0Y2gsIGFzcGVlZC1hc3QyNjAwLWV2Yi5kdHMgaXMgYW4g
ZXhpc3RlZCBvbGQgZHRzIGluIG1haW5saW5lIGtlcm5lbC4NCkluIHRoaXMgc2VyaWVzLCBmdGdt
YWMxMDAgZm9yIEFTVDI2MDAgd2lsbCBjb25maWd1cmUgdGhlIE1BQyBSR01JSSBpbnRlcm5hbCBk
ZWxheQ0KdmlhIFNDVSByZWdpc3Rlciwgc28gdGhpcyBwYXRjaCBpcyBjaGFuZ2luZyB0aGlzIGR0
cyBhcyBhIE5FVyBkdHMgZm9yIGRyaXZlciB0byBjb25maWd1cmUNClJHTUlJIGRlbGF5IGZyb20g
dGhlIHByb3BlcnRpZXMgb2YgTUFDIG5vZGVzLg0KDQpPbGQgZHRzOiBnZW5lcmFsbHksIGxlYWsg
dHgvcngtaW50ZXJuYWwtZGVsYXktcHMgLT4gQ2FsY3VsYXRlIHRoZSBSR01JSSBkZWxheSB0aGF0
IGlzIGNvbmZpZ3VyZWQNCmZyb20gYm9vdGxvYWRlciBhbmQgZGVjaWRlIHdoZXRoZXIga2VlcCB0
aGUgb3JpZ2luYWwgdmFsdWUNCg0KTmV3IGR0czogSW4gQVNUMjYwMCwgd2UgZXhwZWN0IHRoZSBN
QUMgbm9kZSBpbmNsdWRlcyB0aGUgcngvdHgtaW50ZXJuYWwtZGVsYXktbnMgcHJvcGVydGllcw0K
YW5kIHRoZSBkcml2ZXIgZGlyZWN0bHkgdXNlcyB0aGVzZSBwcm9wZXJ0aWVzIHRvIGNvbmZpZ3Vy
ZSBSR01JSSBkZWxheS4NCg0KV2UgaG9wZSB0aGlzIHNlcmllcyBjYW4ga2VlcCB0aGUgb2xkIGR0
cyB3b3JrcyBmaW5lIGFuZCBwdXNoIHRoZSBuZXcgbWVjaGFuaXNtIGZvciB0aGUNCm5leHQgZ2Vu
ZXJhdGlvbiwgQVNUMjcwMC4gU28sIGluIEFTVDI3MDAsIGlmIHRoZSByeC90eC1pbnRlcm5hbC1k
ZWxheS1wcyBhcmUgWkVSTywgaXQgaXMgDQp1bm5lY2Vzc2FyeSBpbmNsdWRpbmcgdGhlc2UgcHJv
cGVydGllcywgYWNjb3JkaW5nIHRvIHRoZSBiaW5kaW5nIHRoZXNlIGRlZmF1bHQgYXJlIFpFUk8u
DQoNClRoYW5rcywNCkphY2t5DQoNCg==

