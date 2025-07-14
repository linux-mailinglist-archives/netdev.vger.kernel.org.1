Return-Path: <netdev+bounces-206661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA724B03ED6
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2549B3B01E0
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 12:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5A248F76;
	Mon, 14 Jul 2025 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="oXR2wLLh"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022107.outbound.protection.outlook.com [52.101.126.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E2248886;
	Mon, 14 Jul 2025 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496633; cv=fail; b=JtIDxKY55YeZ1ovumKc7PRRavw9POcyfFtSydsjJ+LWs4wjmptVtAA6OPt7beVoydXurJJvavHptcNF2CR6lzfHZFFlcALQQQQ62VA7eQxEF0xJ/oe6hWQVqFusDUb2Xk/iYP9VUECNPyg5h05YexfsfgXPQ1SyEasn9lHSJb1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496633; c=relaxed/simple;
	bh=D1KsO/AvLJnZYROxPjwF18b/yn19s7+A9JW/E15OocU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G4r9eRDHgItYJpk/Ob1/OFcm7RX1oEihVe2Vbvfu8QqEtEqW7ppYvG4TaQ3Tm+Tg9sE8a/KieaYZITsGMBpSFqF7KZPgbBl9a60Z2v/Md7Wx58D+6gssrBOair9GaeXmpvW0SRdwr6QeybMig25hhHAvDjX6d6O5I15fdx5Sh38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=oXR2wLLh; arc=fail smtp.client-ip=52.101.126.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgxtnsOkcI3TzpaiEm7i3dPuJF0b0lwHznKN7//goHPgQXJd9ztypLblFMxsUBi05x/Bz/DmiFLRaVpfn41rdd7AqOlOLVKtkYomWrL0ILCWXtPgw0T8u0WhRVosdPXUWiQFxdmQs5KFkQb38Fx/rx5asB6h/kwflrXZOIUOXKjeOoy/synf05mCgwisy1sXB1uQMleec+hKLjQVKTynpWqvjAXuvAWD4bY5gSdMJodWUK6mO5UdRSxhIQQ2ot1WA9UmsbHSFID6TUGn39GiYBBUmFyF0vv1lhb5IkJ9ZnEq2GvIAGy/fi/oiwXnIgnuqKvonP+s3oxCmHOLCJdRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1KsO/AvLJnZYROxPjwF18b/yn19s7+A9JW/E15OocU=;
 b=OGNpUzpbeurvVHBOS/ug/NNfiwXzM8ZtYMiej9XrmW0bPjbFDN5d9OUuQIMYd7ZqxvuGu0RTsaKqPmXKRuvMKU5lW90g42BpRLIrwLchZ9BXGmeMetLx8XoIYdmt6CpspEC0/KXHtVXddHmlrWzk3BHBnB5bbnB//Z/ftusihg6LPx0gT/qHTlUgsUinDH3lukfexIhObfy9Nu1A3d+tbVhViml4pr7glFv2hyxewavJ4TtMiO+CQ5vYVVZcmf7hRApU1zI6YrV21R3Ru4pBJtQ820IP3SJSOWDrs9AWVgMOMG/mn4W39Qs6qNkaUKRVGqaFa97E3z1Nckip2ZK2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1KsO/AvLJnZYROxPjwF18b/yn19s7+A9JW/E15OocU=;
 b=oXR2wLLhYGAL1KczQQwJcOteFDrrWdHWfeXzRv5mSZUHOHG36TvjLkyDdWfDxXnxnuK+Gq9WJ7pAt0TeWuCVyZoQFkyz3lmMALiDRtfy0ckMaeeB73T/BF4s3nEO2vybMjPjhzBoj59DbQHt2fdwfas4wTXoexv4koTkPP0/xwA2785W8JbotVc5SFubEfNyFj8R2aS8S94Ph1NAjSF7VsXUjIQMtM2xYNpdgSLhCH6fZkte/kVQgEP4fApQwzXU0G6sPo7vHPl3cpRFaVuUQhxS0enuJ01m4sLyEcliUiYa9z7Vlzxv+nJPJQfwDzbs1hb7HQI/y+ueyhoqQ6Z2gQ==
Received: from SEZPR06MB5763.apcprd06.prod.outlook.com (2603:1096:101:ab::9)
 by SEYPR06MB6521.apcprd06.prod.outlook.com (2603:1096:101:16c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Mon, 14 Jul
 2025 12:37:04 +0000
Received: from SEZPR06MB5763.apcprd06.prod.outlook.com
 ([fe80::ba6c:3fc5:c2b5:ee71]) by SEZPR06MB5763.apcprd06.prod.outlook.com
 ([fe80::ba6c:3fc5:c2b5:ee71%4]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 12:37:04 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, "matt@codeconstruct.com.au"
	<matt@codeconstruct.com.au>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
CC: Khang D Nguyen <khangng@amperemail.onmicrosoft.com>
Subject: RE: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
Thread-Topic: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
Thread-Index: AQHb9Igk7vn3xpIukEauwkU1/K0+nrQxUL6AgAACe7A=
Date: Mon, 14 Jul 2025 12:37:03 +0000
Message-ID:
 <SEZPR06MB57635C8B59C4B0C6053BC1C99054A@SEZPR06MB5763.apcprd06.prod.outlook.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
 <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
In-Reply-To:
 <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5763:EE_|SEYPR06MB6521:EE_
x-ms-office365-filtering-correlation-id: 549e7e72-2901-4926-ec5a-08ddc2d32323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|42112799006|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVhlM1VSWGpnNEFLdUFuNXhpVUhyT1dlSVBYa21xMFoxTlJpTjBqMXlhUTlo?=
 =?utf-8?B?R000Y3ZEUklwV2FEZy9sYnZFaVpZNGkzaTZnSUZqbWdabTdvaTRZaWwwWDM3?=
 =?utf-8?B?QWxYNTE0WXFzanljaE9OTS9xYUdkZEdIeTlkeXFIQnZ3NytEb0prOWtKZFMx?=
 =?utf-8?B?blZxNTBJZDA5K05PVUd5OGNTOWNHT0JuTCt5cmNjLzVWbjhjbWcwNTgxei9K?=
 =?utf-8?B?ekpadkdUeWcrRHUyb1dXRzQrdnhseW1zamUvRi8yWVNlWnk3ZzdXa0Fnck5v?=
 =?utf-8?B?d2k1QThMeityR2VxZDkxZ0poTnhDbld3enFydnN0Z0EvM3Q2cmpnM1gxRGlO?=
 =?utf-8?B?WFpZN1U2amtXQWNPNEZaNDF2RkM2Q010NkZXV3ZMUUV2cFRFUHNVWitrWjhO?=
 =?utf-8?B?eWxxVEJoQVZQZDJDZDhrUXBoWjBVUFFlc2dCeENscWpMVVVkUmcva3FUN0ZR?=
 =?utf-8?B?UG1KUVBFQzVmdEEwSWt5NlZBbzRqOTM2dHNCTDlZbk5tRkhYSGhEa1QyaWhE?=
 =?utf-8?B?bUlHaVhqaUVzZUV2WWhqSVA4N1k3TTVNd3lMdzJKWDN5ckFBd1lZNzdRU0lF?=
 =?utf-8?B?MlBNWVpxNm1tTDZWZVVubCtsZHQzbHZjNENrekRTdVJYeEJ6NkhSNHdjUGln?=
 =?utf-8?B?SlFNcE5NbGJJd3VScjcyY1hvdFlBajZobzU0a3QybktLTE9QK0hTZktGVFpD?=
 =?utf-8?B?Zm1kRDU3NkJjNzZtaGw3WFozN204eUo1dmxMTUJJTG1GQUVLcWRCMzVBRTls?=
 =?utf-8?B?dVNKWnZTMXJJVWNKSmd2NElzNUVIQWJ1aGIyNWpSRWQ3QkltZ2U4NkFXOEtU?=
 =?utf-8?B?WWJKT1FpcG90eXV5ZXVkbzRzZWRSRWdlaExsem1xSmpqbXViQlJWU0VpNHYy?=
 =?utf-8?B?eUxZVksyRER3UUpUUXBRNWw5bnhrcGtQV0pDRllabDhOM090MkdTY1VoQ0pk?=
 =?utf-8?B?OHFXQ3lXWnFVQUVYc0JURHJ1OVJJWEFhMVZweHRRRUxIZGx2WDcybVRSWFpv?=
 =?utf-8?B?d0xNZEpTOVFoMzMrSFRsY2kwM0JHTkpKZmFkR3U5azJXRU0xUkFpRHJIU3k5?=
 =?utf-8?B?NTNRRk83OWl0b3lJOExNaG16amMzRUVYQVVOZkRQN3dqNGtWU3FtOGZYSGtp?=
 =?utf-8?B?eG1tQzJxN0ExS0VRcDk4MVIyNnhWWVNlVWJMZyt3RFZlakpuUEpsWW5wTFl5?=
 =?utf-8?B?NVJGdVJWRHdkU01SdUJBcFp5dkhiMXVmczh0UWtQUTYrbk5JQXd6Q2l6V3F0?=
 =?utf-8?B?cTZQaEhjM2szc2VHRURDZzY0d0FZQ29td1I0c3RZTE1uYm5FVnBXTFR0bkJw?=
 =?utf-8?B?elBIbXZXdmZqbkZyZ2Q0SDdCRFkxT3R6T1l2ZnRWcnlBL1hYc2hyaVFHb3BV?=
 =?utf-8?B?NlpzeTFSYXhJVk04ei9IREJaSWxGK1J1aVNDU2ZrY0pxRys1a2t3c2VQcGtB?=
 =?utf-8?B?Ti9ITStEZ05GRWJDbjUwbzMzZnI5c1ZqVmpBbmVWRExDUjZtY3VVUm5teUdD?=
 =?utf-8?B?SUN3ZjgvcWR2aW9vbVF3OE5JdDQ3MGRZTGtzREdwUnJvRW1IeDRZOHJtNm1W?=
 =?utf-8?B?bk9ZNTlCS1Rjc041UlZDcC9IUjJFUzhEUWpVNHM5TFR3WkZId1NDUGVCSytO?=
 =?utf-8?B?cEYvTnBVaHhBV1N6dXBBREN1Wmxjb25TTG1kQTBFdHJhN3dXdzAvVm94d2w0?=
 =?utf-8?B?RmRzYmtBZGlZM2ZWcmllc29RVGhTR0FaMnUyN2xXZDZWNDB0SXVjbThCUDdp?=
 =?utf-8?B?ZW9Ldnh3dEJDdURscDdqL281Z2hNRDRCZzVMNFNTSzZGUXhCWi9uMjc4ODNN?=
 =?utf-8?B?M3ljblVSd3VWYTBpYnJKNWlMemZIa3BrY0VydWQxQlZsZ1AxbWliQ01YREFS?=
 =?utf-8?B?ejE2SU94clJCOEhTeW9aV3A2QWRWTjYvUlpoMi96aDFCQzM5WUR1S3lKVk9Z?=
 =?utf-8?B?TWdTRmtDR2pYZDdSTkh3SFBUa05VQnZUMEpvVEFKaUJsWFNIL0pUSWFrVDA1?=
 =?utf-8?Q?kTZ6FXo2OAsIR9A8cybargiQvRao54=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5763.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(42112799006)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aTM4bHQ0Y0N2NmIzUXhNd0RuUE4vL1IvNU95KzQ2UzFINDdWQUdMQnNtK3o0?=
 =?utf-8?B?YkFTYkhoSnJqVDlkam9QbGVteVhPYVRmcm1FbUd4YWcwUHlCa1RHMERZWE5L?=
 =?utf-8?B?NmFHbVhCdENxajBmb1JIK1QzeFppZWtnaFVhN2NSYVBHQjVIeWpONjQ3Unlu?=
 =?utf-8?B?RjZSL2EzMzlQeG9neUZySlhXQnRnQWw4R1c0dTZ6bkVWcnhjd2ZIMVZLKy9Y?=
 =?utf-8?B?c2ZSL2NvdzhmM3E0YXZwbEsyZFdhRUdJZU5oWEtHSWRKZGllakhvMXA5SFRM?=
 =?utf-8?B?ODYxMWQyQzIxRy9Fdm5uUlk1SVZJeE5DN0lWVlhEbWV5MDFlNGNyTC9XWHZn?=
 =?utf-8?B?bmVPWXZmZFY3NWpFUkVtUkQ5SjB1NlhGWnRSZzZBcTUzWWNrVWpoZkEwTXpE?=
 =?utf-8?B?amJ4WGIvT1VzL3NvdjFlYVBuZHlTSDlCM05yQzRGcjA5ell0NkdDTnlTZ3k2?=
 =?utf-8?B?dEFxcW5rWHVwOXdGeTdYcWRBeWpva2VCZ3hqMmFQSUlBcjRIbzNsVndRb01w?=
 =?utf-8?B?RUVtMVhqT3JFbkxUd0FxZ0NPSmN6ZXZ3YTlHSEgwaG9aKzYvdFFRU1FNbVhN?=
 =?utf-8?B?Y3JRTXNHbFdTLzRHbVdWL0llYW9abWx3bEd0R3h0cnZBeWhLVFJ1TVVuV2pi?=
 =?utf-8?B?Y3dGSU9CTXRnd2M3b09DQStqZFBjaXhxQ3Vnek9nY1p0dVNwdHhCNDh5b3Vi?=
 =?utf-8?B?WGxMQ1NoaVBja280TzQvNGZBUTBlYm5lTVdBVTdyaFc2V21oMW9ZWFZDaW45?=
 =?utf-8?B?VlAydlpJYTBtZ1l3Nk1yUVdWS3B3SSt2a1NFT1NualVtOEVrWGQ2MzNSTWFD?=
 =?utf-8?B?UElVbE1NYUdDVWU3aUl5UWt4cXVGZ21MWVhHcjNlNmg3dytWaTZuN3V0NjlK?=
 =?utf-8?B?cU5VRFV2cjRFcmhTekx0V3ZneXF3UWZ1bE1iQUVZSkNGT005VXZFS2xOUWtj?=
 =?utf-8?B?bGZUMDZiRDVIaitsU1hmamtwdmF6S3BqdmNwRVVoeGoxTElrcFNjT3dRWVlS?=
 =?utf-8?B?YlVsak5rZ2VoOE5iMlRhUnRtZVhLa0ZhVi83MUt0QTVYNExtUlMxeFVxYU1s?=
 =?utf-8?B?S24wcnB2Nnp0SjVDRFI0VjdwTGxUdzVpdmdGZTh2dmd6VDdJOW50am81RkIy?=
 =?utf-8?B?Rmo1MTZLdEJObk1hUXFUQ3dFWFoyL1lub2YzQ0hSSmtSVk9VOW9mQW5tWjdF?=
 =?utf-8?B?VHpRazF3ZGViN2Z4NzRUYXljMEt0bHdYWDFqcWRXd0pxMmY0MEZEb0xvT3dI?=
 =?utf-8?B?UkgyU1E5TGF6cTJXdjV5dmd6TFRwM3ZvNWdoNGRxaHdFc2hIQ0M5ZUVpSDJy?=
 =?utf-8?B?cHJ6M3hySEQzaVdGL2t4QWkvQXc1MEFkSjVFQVRUdmJvU091cDdTY1ZxcTQ1?=
 =?utf-8?B?L1Y1OFRDcmJPSmhVQXU5TmNaRFlqM0VMdzNlZjIzUnJpbnhlVTBwWVcyQ1Bs?=
 =?utf-8?B?bEp4TCtjdms4ZnlZNHlyTjFoMGVUWjN1NDNqejJiT3QyKzZOWm12OXo4RXlS?=
 =?utf-8?B?N3F0Y2JPWEFBUnRxRGl1UGdBem1HNWF2VE9XVnAvcXJJbTZCcThrcFl0VVFr?=
 =?utf-8?B?ZUxOM0t2aDdRa21Zd21DSTAvV1NhUVdCdStLNHBqWHVpQ2JhWkpUQTBCbnhE?=
 =?utf-8?B?OTV2K1Y2YjdmejVVQUx4am5VSWdPWjFwdkdzc1hROC9mRlh0eU5Sc0M1dDE2?=
 =?utf-8?B?SEd1TVY1QlNkWlVsUFlpN0VGeXE1T3BXa3Zzb3NmenF0dHZSdzlwMUZmZCsy?=
 =?utf-8?B?TVJrcVhQWExqYVBldE1FMWJMQnpnQnh5WGFZc2djU2d5N2tWM29nLzdPcmVZ?=
 =?utf-8?B?RzFsNVIvaWpLQ0dRcTRoQUxCMENqWGNCMC9nWS9zcE1kUUdteG02NDBOMzNT?=
 =?utf-8?B?aE85ZVRwTG4xdERnUWN4WHZRZTJQVnFmMFo3UGk5VFl1L1NNWnRNY2dQTXlF?=
 =?utf-8?B?ZzR4dm1LZG5nZkRab0NDWHpodDJXSGZjelU1WUM4RE93dVp2TWcyd0YwazlN?=
 =?utf-8?B?YmpDdEIvbEoxNlkrZTRhQk5LeUtWNkFDdFZLdTh5QUl1aDdEOUpjVVlpalNV?=
 =?utf-8?B?N2FmU2MzWkRFV09KVSs5REN2dzk5WXplc0xIcHhxQmtNYWsyZktPODJNMWM2?=
 =?utf-8?Q?K2e9dc+RPZmrYWy8EL3Q1zsQY?=
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
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5763.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549e7e72-2901-4926-ec5a-08ddc2d32323
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 12:37:03.9891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dvGqLdzymB9AqSQlbpN+8oMjwbDRu6sdswg5EewMMY645KzXmXisi9owA0ZC2JLZEpQYE+ZxMf8ezgcoWeL3AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6521

SGkgSmVyZW15LA0KQXBwcmVjaWF0ZSBmb3IgdGhlIGZlZWRiYWNrISBQbGVhc2UgY2hlY2sgaW5s
aW5lIGJlbG93Lg0KDQo+SGkgWUgsDQo+DQo+WytDQyBLaGFuZ10NCj4NCj5JIGhhdmUgc29tZSBv
dmVyYWxsIHF1ZXN0aW9ucyBiZWZvcmUgd2UgZ2V0IGludG8gYSBmdWxsIHJldmlldyBvZiB0aGUg
c2VyaWVzLA0KPmlubGluZSBiZWxvdy4NCj4NCj4+IEFkZCBhbiBpbXBsZW1lbnRhdGlvbiBmb3Ig
RE1URiBEU1AwMjM4IE1DVFAgUENJZSBWRE0gdHJhbnNwb3J0IHNwZWMuDQo+Pg0KPj4gSW50cm9k
dWNlIHN0cnVjdCBtY3RwX3BjaWVfdmRtX2RldiB0byByZXByZXNlbnQgZWFjaCBQQ0llIFZETQ0K
Pj4gaW50ZXJmYWNlIGFuZCBpdHMgc2VuZC9yZWNlaXZlIG9wZXJhdGlvbnMuICBSZWdpc3RlciBh
IG5ldF9kZXZpY2Ugd2l0aA0KPj4gdGhlIE1DVFAgY29yZSBzbyBwYWNrZXRzIHRyYXZlcnNlIHRo
ZSBzdGFuZGFyZCBuZXR3b3JraW5nIHNvY2tldCBBUEkuDQo+Pg0KPj4gQmVjYXVzZSB0aGVyZSBp
cyBubyBnZW5lcmljIFBDSWUgVkRNIGJ1cyBmcmFtZXdvcmsgaW4tdHJlZSwgdGhpcw0KPj4gZHJp
dmVyIHByb3ZpZGVzIGEgdHJhbnNwb3J0IGludGVyZmFjZSBmb3IgbG93ZXIgbGF5ZXJzIHRvIGlt
cGxlbWVudA0KPj4gdmVuZG9yLXNwZWNpZmljIHJlYWQvd3JpdGUgY2FsbGJhY2tzLg0KPg0KPkRv
IHdlIHJlYWxseSBuZWVkIGFuIGFic3RyYWN0aW9uIGZvciBNQ1RQIFZETSBkcml2ZXJzPyBIb3cg
bWFueSBhcmUgeW91DQo+ZXhwZWN0aW5nPyBDYW4geW91IHBvaW50IHVzIHRvIGEgY2xpZW50IG9m
IHRoZSBWRE0gYWJzdHJhY3Rpb24/DQo+DQo+VGhlcmUgaXMgc29tZSB2YWx1ZSBpbiBrZWVwaW5n
IGNvbnNpc3RlbmN5IGZvciB0aGUgTUNUUCBsbGFkZHIgZm9ybWF0cyBhY3Jvc3MNCj5QQ0llIHRy
YW5zcG9ydHMsIGJ1dCBJJ20gbm90IGNvbnZpbmNlZCB3ZSBuZWVkIGEgd2hvbGUgYWJzdHJhY3Rp
b24gbGF5ZXIgZm9yDQo+dGhpcy4NCj4NCldlIHBsYW4gdG8gZm9sbG93IGV4aXN0aW5nIHVwc3Ry
ZWFtIE1DVFAgdHJhbnNwb3J0c+KAlHN1Y2ggYXMgScKyQywgScKzQywgYW5kIFVTQuKAlGJ5IGFi
c3RyYWN0aW5nIHRoZSBoYXJkd2FyZS1zcGVjaWZpYyBkZXRhaWxzIGludG8gYSBjb21tb24gaW50
ZXJmYWNlIGFuZCBmb2N1cyBvbiB0aGUgdHJhbnNwb3J0IGJpbmRpbmcgcHJvdG9jb2wgaW4gdGhp
cyBwYXRjaC4gVGhpcyBkcml2ZXIgaGFzIGJlZW4gdGVzdGVkIGJ5IG91ciBBU1QyNjAwIGFuZCBB
U1QyNzAwIE1DVFAgZHJpdmVyLg0KDQo+PiBUWCBwYXRoIHVzZXMgYSBkZWRpY2F0ZWQga2VybmVs
IHRocmVhZCBhbmQgcHRyX3Jpbmc6IHNrYnMgcXVldWVkIGJ5DQo+PiB0aGUgTUNUUCBzdGFjayBh
cmUgZW5xdWV1ZWQgb24gdGhlIHJpbmcgYW5kIHByb2Nlc3NlZCBpbi10aHJlYWQgY29udGV4dC4N
Cj4NCj5JcyB0aGlzIHNvbWVob3cgbW9yZSBzdWl0YWJsZSB0aGFuIHRoZSBleGlzdGluZyBuZXRk
ZXYgcXVldWVzPw0KPg0KT3VyIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gaGFzIHR3byBvcGVyYXRp
b25zIHRoYXQgdGFrZSB0aW1lOg0KMSkgQ29uZmlndXJlIHRoZSBQQ0llIFZETSByb3V0aW5nIHR5
cGUgYXMgRFNQMDIzOCByZXF1ZXN0ZWQgaWYgd2UgYXJlIHNlbmRpbmcgY2VydGFpbiBjdHJsIG1l
c3NhZ2UgY29tbWFuZCBjb2RlcyBsaWtlIERpc2NvdmVyeSBOb3RpZnkgcmVxdWVzdCBvciBFbmRw
b2ludCBEaXNjb3ZlcnkgcmVzcG9uc2UuDQoyKSBVcGRhdGUgdGhlIEJERi9FSUQgcm91dGluZyB0
YWJsZS4NCg0KU2luY2UgdGhlIG5ldGRldiBUWCBxdWV1ZSBjYWxsLXN0YWNrIHNob3VsZCBiZSBl
eGVjdXRlZCBxdWlja2x5LCB3ZSBvZmZsb2FkIHRoZXNlIGl0ZW1zIHRvIGEgZGVkaWNhdGVkIGtl
cm5lbCB0aHJlYWQgYW5kIHVzZSBwdHJfcmluZyB0byBwcm9jZXNzIHBhY2tldHMgaW4gYmF0Y2hl
cy4NCg0KPj4gK3N0cnVjdCBtY3RwX3BjaWVfdmRtX3JvdXRlX2luZm8gew0KPj4gKyAgICAgICB1
OCBlaWQ7DQo+PiArICAgICAgIHU4IGRpcnR5Ow0KPj4gKyAgICAgICB1MTYgYmRmX2FkZHI7DQo+
PiArICAgICAgIHN0cnVjdCBobGlzdF9ub2RlIGhub2RlOw0KPj4gK307DQo+DQo+V2h5IGFyZSB5
b3Uga2VlcGluZyB5b3VyIG93biByb3V0aW5nIHRhYmxlIGluIHRoZSB0cmFuc3BvcnQgZHJpdmVy
PyBXZSBhbHJlYWR5DQo+aGF2ZSB0aGUgcm91dGUgYW5kIG5laWdoYm91ciB0YWJsZXMgaW4gdGhl
IE1DVFAgY29yZSBjb2RlLg0KPg0KPllvdXIgYXNzdW1wdGlvbiB0aGF0IHlvdSBjYW4gaW50ZXJj
ZXB0IE1DVFAgY29udHJvbCBtZXNzYWdlcyB0byBrZWVwIGENCj5zZXBhcmF0ZSByb3V0aW5nIHRh
YmxlIHdpbGwgbm90IHdvcmsuDQo+DQpXZSBtYWludGFpbiBhIHJvdXRpbmcgdGFibGUgaW4gdGhl
IHRyYW5zcG9ydCBkcml2ZXIgdG8gcmVjb3JkIHRoZSBtYXBwaW5nIGJldHdlZW4gQkRGcyBhbmQg
RUlEcywgYXMgdGhlIEJERiBpcyBvbmx5IHByZXNlbnQgaW4gdGhlIFBDSWUgVkRNIGhlYWRlciBv
ZiByZWNlaXZlZCBFbmRwb2ludCBEaXNjb3ZlcnkgUmVzcG9uc2VzLiBUaGlzIGluZm9ybWF0aW9u
IGlzIG5vdCBmb3J3YXJkZWQgdG8gdGhlIE1DVFAgY29yZSBpbiB0aGUgTUNUUCBwYXlsb2FkLiBX
ZSB1cGRhdGUgdGhlIHRhYmxlIHdpdGggdGhpcyBtYXBwaW5nIGJlZm9yZSBmb3J3YXJkaW5nIHRo
ZSBNQ1RQIG1lc3NhZ2UgdG8gdGhlIGNvcmUuDQoNCkFkZGl0aW9uYWxseSwgaWYgdGhlIE1DVFAg
QnVzIE93bmVyIG9wZXJhdGVzIGluIEVuZHBvaW50IChFUCkgcm9sZSBvbiB0aGUgUENJZSBidXMs
IGl0IGNhbm5vdCBvYnRhaW4gdGhlIHBoeXNpY2FsIGFkZHJlc3NlcyBvZiBvdGhlciBkZXZpY2Vz
IGZyb20gdGhlIFBDSWUgYnVzLiBUaGVyZWZvcmUsIHJlY29yZGluZyB0aGUgcGh5c2ljYWwgYWRk
cmVzcyBpbiB0aGUgdHJhbnNwb3J0IGRyaXZlciBtYXkgYmUsIGluIG91ciB2aWV3LCBhIHByYWN0
aWNhbCBzb2x1dGlvbiB0byB0aGlzIGxpbWl0YXRpb24uDQoNCj4+ICtzdGF0aWMgdm9pZCBtY3Rw
X3BjaWVfdmRtX25ldF9zZXR1cChzdHJ1Y3QgbmV0X2RldmljZSAqbmRldikgew0KPj4gKyAgICAg
ICBuZGV2LT50eXBlID0gQVJQSFJEX01DVFA7DQo+PiArDQo+PiArICAgICAgIG5kZXYtPm10dSA9
IE1DVFBfUENJRV9WRE1fTUlOX01UVTsNCj4+ICsgICAgICAgbmRldi0+bWluX210dSA9IE1DVFBf
UENJRV9WRE1fTUlOX01UVTsNCj4+ICsgICAgICAgbmRldi0+bWF4X210dSA9IE1DVFBfUENJRV9W
RE1fTUFYX01UVTsNCj4+ICsgICAgICAgbmRldi0+dHhfcXVldWVfbGVuID0NCj5NQ1RQX1BDSUVf
VkRNX05FVF9ERVZfVFhfUVVFVUVfTEVOOw0KPj4gKyAgICAgICBuZGV2LT5hZGRyX2xlbiA9IDI7
IC8vUENJZSBiZGYgaXMgMiBieXRlcw0KPg0KPk9uZSBvZiB0aGUgY3JpdGljYWwgdGhpbmdzIHRv
IGdldCByaWdodCBpcyB0aGUgbGxhZGRyIGZvcm1hdCBmb3IgUENJZSBWRE0gZGV2aWNlcywNCj5h
cyBpdCB3aWxsIGJlIHZpc2libGUgdG8gdXNlcnNwYWNlLiBXaGlsZSB0aGUgUENJZSBiL2QvZm4g
ZGF0YSBpcyBpbmRlZWQgdHdvIGJ5dGVzLA0KPnRoZSBNQ1RQIGFkZHJlc3NpbmcgZm9ybWF0IGZv
ciBWRE0gZGF0YSBpcyBub3QgZW50aXJlbHkgcmVwcmVzZW50YWJsZSBpbiB0d28NCj5ieXRlczog
d2UgYWxzbyBoYXZlIHRoZSByb3V0aW5nIHR5cGUgdG8gZW5jb2RlLiBEU1AwMjM4IHJlcXVpcmVz
IHVzIHRvIHVzZQ0KPlJvdXRlIHRvIFJvb3QgQ29tcGxleCBhbmQgQnJvYWRjYXN0IGZyb20gUm9v
dCBDb21wbGV4IGZvciBjZXJ0YWluIG1lc3NhZ2VzLA0KPnNvIHdlIG5lZWQgc29tZSB3YXkgdG8g
cmVwcmVzZW50IHRoYXQgaW4geW91ciBwcm9wb3NlZCBsbGFkZHIgZm9ybWF0Lg0KPg0KPkZvciB0
aGlzIHJlYXNvbiwgeW91IG1heSB3YW50IHRvIGVuY29kZSB0aGlzIGFzIFt0eXBlLCBiZGZuXSBk
YXRhLg0KPg0KPkFsc28sIGluIGZsaXQgbW9kZSwgd2UgYWxzbyBoYXZlIHRoZSBzZWdtZW50IGJ5
dGUgdG8gZW5jb2RlLg0KPg0KQWdyZWVkLiBJbiBvdXIgaW1wbGVtZW50LCB3ZSBhbHdheXMgZmls
bCBpbiB0aGUgIlJvdXRlIEJ5IElEIiB0eXBlIHdoZW4gY29yZSBhc2tzIHVzIHRvIGNyZWF0ZSB0
aGUgaGVhZGVyLCBzaW5jZSB3ZSBkb24ndCBrbm93IHRoZSBjb3JyZWN0IHR5cGUgdG8gZmlsbCBh
dCB0aGF0IHRpbWUuICBBbmQgbGF0ZXIgd2UgdXBkYXRlIHRoZSBSb3V0ZSB0eXBlIGJhc2VkIG9u
IHRoZSBjdHJsIG1lc3NhZ2UgY29kZSB3aGVuIGRvaW5nIFRYLiBJIHRoaW5rIGl0IHdvdWxkIGJl
IG5pY2UgaWYgd2UgY2FuIGhhdmUgYSB1bmlmb3JtZWQgYWRkcmVzcyBmb3JtYXQgdG8gZ2V0IHRo
ZSBhY3R1YWwgUm91dGUgdHlwZSBieSBwYXNzZWQtaW4gbGxhZGRyIHdoZW4gY3JlYXRpbmcgdGhl
IGhlYWRlci4NCg0KPkNoZWVycywNCj4NCj4NCj5KZXJlbXkNCioqKioqKioqKioqKiogRW1haWwg
Q29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioqKg0K5YWN6LKs6IGy5piO
Og0K5pys5L+h5Lu2KOaIluWFtumZhOS7tinlj6/og73ljIXlkKvmqZ/lr4bos4foqIrvvIzkuKbl
j5fms5Xlvovkv53orbfjgILlpoIg5Y+w56uv6Z2e5oyH5a6a5LmL5pS25Lu26ICF77yM6KuL5Lul
6Zu75a2Q6YO15Lu26YCa55+l5pys6Zu75a2Q6YO15Lu25LmL55m86YCB6ICFLCDkuKboq4vnq4vl
jbPliKrpmaTmnKzpm7vlrZDpg7Xku7blj4rlhbbpmYTku7blkozpirfmr4DmiYDmnInopIfljbDk
u7bjgILorJ3orJ3mgqjnmoTlkIjkvZwhDQrkv6HpqYrnp5HmioDku6XoqqDkv6HmraPnm7Tljp/l
iYfmsLjnuozntpPnh5/kvIHmpa3vvIzkuKblt7Llp5TnlLHnrKzkuInmlrnlhazmraPllq7kvY3l
i6Tmpa3nnL7kv6Hlj4rkv6HpqYrnp5HmioDnjajnq4vokaPkuovkvobnrqHnkIbljL/lkI3oiInl
oLHns7vntbHvvIzlpoLlkITlgIvliKnlrrPpl5zkv4LkurrnrYnmnInnmbznj77ku7vkvZXpgZXm
s5Xlj4rpgZXlj43lhazlj7jlvp7mpa3pgZPlvrfjgIHpgZXlj43ms5Xku6Tms5Xopo/lj4rlsIjm
pa3mupbliYfjgIHkuqbmiJbpnLjlh4zlj4rpgZXlj43mgKfliKXlubPnrYnkuYvmg4XkuovvvIzo
q4vnm7TmjqXpgI/pgY7ku6XkuIvlj6/pgbjmk4fljL/lkI3kuYvoiInloLHns7vntbHoiInloLHv
vIzlho3mrKHmhJ/orJ3mgqjljZTliqnkv6HpqYrmjIHnuozpgoHlkJHmsLjnuozntpPnh5/jgILk
v6HpqYrnp5HmioDoiInloLHntrLnq5npgKPntZDvvJpodHRwczovL3NlY3VyZS5jb25kdWN0d2F0
Y2guY29tL2FzcGVlZHRlY2gvDQoNCkRJU0NMQUlNRVI6DQpUaGlzIG1lc3NhZ2UgKGFuZCBhbnkg
YXR0YWNobWVudHMpIG1heSBjb250YWluIGxlZ2FsbHkgcHJpdmlsZWdlZCBhbmQvb3Igb3RoZXIg
Y29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCBpdCBpbiBlcnJv
ciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5IGUtbWFpbCBhbmQgaW1tZWRpYXRl
bHkgZGVsZXRlIHRoZSBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyB3aXRob3V0IGNvcHlpbmcg
b3IgZGlzY2xvc2luZyB0aGUgY29udGVudHMuIFRoYW5rIHlvdS4NCkFTUEVFRCBUZWNobm9sb2d5
IGlzIGNvbW1pdHRlZCB0byBzdXN0YWluYWJsZSBidXNpbmVzcyBwcmFjdGljZXMgYmFzZWQgb24g
aW50ZWdyaXR5IGFuZCBob25lc3R5IHByaW5jaXBsZXMuIEluIG9yZGVyIHRvIGVuc3VyZSB0aGF0
IGFsbCBpbmZvcm1hdGlvbiBjYW4gYmUgb3Blbmx5IGFuZCB0cmFuc3BhcmVudGx5IGNvbW11bmlj
YXRlZCwgYSB0aGlyZC1wYXJ0eSBpbmRlcGVuZGVudCBvcmdhbml6YXRpb24sIERlbG9pdHRlIGFu
ZCBBU1BFRUQgVGVjaG5vbG9neSdzIGluZGVwZW5kZW50IGRpcmVjdG9ycywgaGF2ZSBiZWVuIGVu
dHJ1c3RlZCB0byBtYW5hZ2UgdGhlIGFub255bW91cyByZXBvcnRpbmcgc3lzdGVtLiBJZiBhbnkg
c3Rha2Vob2xkZXJzIGRpc2NvdmVyIGFueSBpbGxlZ2FsIGFjdGl2aXRpZXMsIHZpb2xhdGlvbnMg
b2YgdGhlIGNvbXBhbnkncyBwcm9mZXNzaW9uYWwgZXRoaWNzLCBpbmZyaW5nZW1lbnRzIG9mIGxh
d3MgYW5kIHJlZ3VsYXRpb25zLCBvciBpbmNpZGVudHMgb2YgYnVsbHlpbmcgYW5kIGdlbmRlciBp
bmVxdWFsaXR5LCBwbGVhc2UgZGlyZWN0bHkgcmVwb3J0IHRocm91Z2ggdGhlIGFub255bW91cyBy
ZXBvcnRpbmcgc3lzdGVtIHByb3ZpZGVkIGJlbG93LiBXZSB0aGFuayB5b3UgZm9yIHlvdXIgYXNz
aXN0YW5jZSBpbiBoZWxwaW5nIEFTUEVFRCBUZWNobm9sb2d5IGNvbnRpbnVlIGl0cyBqb3VybmV5
IHRvd2FyZHMgc3VzdGFpbmFibGUgb3BlcmF0aW9uczogaHR0cHM6Ly9zZWN1cmUuY29uZHVjdHdh
dGNoLmNvbS9hc3BlZWR0ZWNoLw0K

