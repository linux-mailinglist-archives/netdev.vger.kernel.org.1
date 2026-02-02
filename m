Return-Path: <netdev+bounces-255693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGPQL8oHgGkq1wIAu9opvQ
	(envelope-from <netdev+bounces-255693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 03:11:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6C3C7D8F
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 03:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5087B300463E
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 02:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BFA1FE46D;
	Mon,  2 Feb 2026 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lKLIDHWr"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EBB199252
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769998279; cv=fail; b=qFQlTp/UdMnxx07EQRF2x4jwIbUvRPqvaOB2pzsG0tSsiEkQ0Lv9grlfjXd4pKXVadFHfT2d0/shvYvYDvFzllJ/omwUEJs0DbCORnwdsUNtFg+xZiSmBq5D1J1Hk93sDLY5VSQkg/R0v06/xC5eHn74EwoFWIGJF+mKsgjZS/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769998279; c=relaxed/simple;
	bh=Y8iaoIDZUVTqZlo7HpvC5BCCg8i50S6jsG95qxTcbio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rg58NVIGWJg/ELs9991+oFWpkrQwn6arH9X/evPqqn6ngpIvjl5TjZHE+c+hPL56EDuz3IXse30ePeNangzwmxsuuK5Tw5RI8+jWxd4E1828Pfqj3XXLS0sA3A3jzNpu42Ykf1uf2u623cyBDLofr/Dr7HoYhHhOTXnl1xe5Hcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lKLIDHWr; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSGehvBxvsPQife+eyZJqg8GOlQwYkuXmpX82erI63gKqt9gKSzO2yAfBTeNwdX2ZbtsAi74pVvTYzgNHG1G0AMSbAYjFEtNpUoIRtqA3yefenxTEmaPeWVYXerJtCO+EHnOW0A8appIlsMKF0/7iWTimGNbDDsV42rwC1zIg9+NXvWXkIoKqvHwqHh2o6psz2bKZNUHic2uUJhiOquvKdHoTAI+9DH9QZ/tSUbJj9HDfKrpTjVzbE6kpDT39Go6T05uEBVQnWytnc3lPDm3qtYV4b9syv7qtQPq6qT+5kjejMQfoeknWWozTe4wxq0RFxFj1v/P31LpT5DasNEbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8iaoIDZUVTqZlo7HpvC5BCCg8i50S6jsG95qxTcbio=;
 b=Xc+I8uF08++q+XR8xPXscoX2YMSB4uPjPNDCe+gJs4BVvAJJykTGFgyspTpW6OeTruuKysAO3roYuAxSrr/Rcg8Ri8TlyEE8llG8xPZ+rpVd0EcmaIcs5J2HcK0Izlp+G+R7vwhloZ37jQyioNiHM3k8PR64pPqFmjc6kEBgBg8fv3sHW6B89fWpEJxkDmLU+Wv1fBs2l+hY9MwPcllmSNxI7pPlmYnTChEapJLz6VeV4xhKxrzPRVvVDlIngu62/vL1xLUsQJqw1Fu1mAebEWt8tTM4LT65P/IIbGtiJO7ZYTWr8gsgKsSGm6jcpegtsPrBfV3FdJwscvgYiW/vGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8iaoIDZUVTqZlo7HpvC5BCCg8i50S6jsG95qxTcbio=;
 b=lKLIDHWrLZjB7+SYCHr0Hanltwzs8q5bKJU8IYI7/8ChlMxiyuvL6AWZiyUdSslz9bRhC5yN2nVy6gSbk0N+iAQQWZ1W2kN2kS/4T2syEcVc6LqyFLi4XSf+OsthUPJgCIfUh6d/Tz5nGvr9Jyuq8RWTNjuHhMLG5J3/g2qUxkaOtr3I7B4KoqVfn5UvKSeMJr5fAWQvHQYuqIt6AyFglUCOHHbLymsPN0jH/QXpHbv6ty5CyTJIsNqtFY7q4CGl4NwkG/Qit47WzU8E5M+s5TrWwAGEqTH0EASnzZTBrg+/zwmiPodI5qIkUf/mZhoI22bS28HRXkM73dWr2ie73A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10601.eurprd04.prod.outlook.com (2603:10a6:102:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Mon, 2 Feb
 2026 02:11:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Mon, 2 Feb 2026
 02:11:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net 3/4] net: enetc: Convert 16-bit register writes to
 32-bit for ENETC v4
Thread-Topic: [PATCH net 3/4] net: enetc: Convert 16-bit register writes to
 32-bit for ENETC v4
Thread-Index: AQHckfI4RFsZl9HQJU6wxMaW+sF/WbVurnoQ
Date: Mon, 2 Feb 2026 02:11:14 +0000
Message-ID:
 <PAXPR04MB851034F76470F39CC69634D8889AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260130141035.272471-1-claudiu.manoil@nxp.com>
 <20260130141035.272471-4-claudiu.manoil@nxp.com>
In-Reply-To: <20260130141035.272471-4-claudiu.manoil@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10601:EE_
x-ms-office365-filtering-correlation-id: 1780bdee-0714-47bb-89bf-08de620057a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXhQWGRDYThlcUh1YjBhdTJIekdKU2t4d1lVRWdVaW1xellQd0s5WUJVN0or?=
 =?utf-8?B?N053bW9wSDJHNUxzTjBmY01YUUVlb1FnZXdlVWNLZHR1SkV3OUtJVnVsYUNw?=
 =?utf-8?B?ci9XeW03SjhsSTRmRzJVMFEvdEE4cFVQZEx0WFFmRkVZQVBxRDZLLytMYVpN?=
 =?utf-8?B?YVNmd0xjWUVRT3JSRHdGUmtBT3NtSS9YUEoyeXZ3bDA0RzRLajR0bjJDa2Zz?=
 =?utf-8?B?bWI1QUlFRUtGMzdka0pVVnVZNUlxdnJIUDBUNExFcEZ0UVRZaHVFOG1sbW84?=
 =?utf-8?B?SDRFYTNvVFFtTzZ1VDg2T0kwa28xR0F3VDQyUTRPZ3NiUng5bjZKcDZyY2VU?=
 =?utf-8?B?V1NNa3VObWpjSkFlRXYvbzdmaUdSbmNMQXZZNDJYbDlsVkZwYU8xS1ptTjVh?=
 =?utf-8?B?c2pzeUswbFluUFdGYW12N09PeHFtYjhqQzRmWkRXcmlqMjlTbXJ2NUVPOW1S?=
 =?utf-8?B?bE12SXkxS3hCcFIxTkZidU9vRmtORUVmeFVWcnNaSlBtOE0vQmpWQisxSTF4?=
 =?utf-8?B?KzVqV2psYnYwS2Mvc04vTmt5YVhRVG5lTWV6cWVwZlhrdnhJU0tsMml6Y1dQ?=
 =?utf-8?B?ajhCcDZVci9GaHVPZkp1MHY3b1F4N3NTd3BPTm1QZlp2dmxCbHFZN0gwZkdw?=
 =?utf-8?B?RnkzVVhLNzQrMW9sNXJoSGsrRVd3WHhPRldrdGt4MVRQc3dUdDltcG5oUUJ6?=
 =?utf-8?B?T2FScCtPV0srdkJCL2lueHl0V1lFalVHT2E0K2N2Mko4dTlLQW80SnFZbC9C?=
 =?utf-8?B?VjBVTkIxZmZjZktPbkRPZ2xudWZiZElwcE9JV0pwbDVrN2pPUkVETFBuTEk4?=
 =?utf-8?B?YTJ6Mm5jS25ZZkhYamh2Um5iR2cvQXhIdXg1Q1htRzVvbDNnbjdNdDZKRHNV?=
 =?utf-8?B?Tzg2bllkZ0RQdi9FWUhoUFphNXJWSk1nL0YyMjhGMG11djRlYXJocS9TRDl0?=
 =?utf-8?B?akRpREw5Tm42MEk2c1g0TnBYcnBsUGpjZFB6UXhhTmZJSkF6VWxkSUFNMCtN?=
 =?utf-8?B?RE9RTEVjazVKeU5zeTJqMHlZYWVoKzM4YUlHbjlMNVJTVjFMUnQ4VjFhaDd5?=
 =?utf-8?B?U09MelRwUndTcnFMN2VFNndXM3I0dU80bnpLSW9HQUVpZXBYb3RLU3dJK0Z2?=
 =?utf-8?B?TzUyclNHWmhvbG0rMGk2VjBCQVQwczRjQjRzSkhUV2lwV0RWV2Q5MFhxekJk?=
 =?utf-8?B?TzV0STgxcmZtUmZNZHk4blRZZFF4c252RUswOFZBVGt1TFN4cWNqRE5HdzVz?=
 =?utf-8?B?aDRoUUNZY3ZlZ1p4L09EWkRzTGVNbmk5R1I4YVBQaDN5RHNRemgraWkvYzBM?=
 =?utf-8?B?bXlsZS96bWNOUi9LMjROUVhYVjltbTRpc1AzaHZHTUt6L1BsVW96ZDI1UE9K?=
 =?utf-8?B?Vk5ZMEFFTVp0VFlQdnJEYWVUdlM3Z1piaW9mNnNJVUcwcEZKTllSbU03eGU4?=
 =?utf-8?B?VmdWTzJZcjNxclpCOUZYczNaOUxLYjdsbWpvWmgybXhWLzViNkdrbnBDZERw?=
 =?utf-8?B?RVg3bDNYSFRma3UvdTlqZWoxOGhBL2hFVzZQSnIyWWdIUFJnYUJwOStJaWtD?=
 =?utf-8?B?aERxcHpob2hpWXJvTHd6YnJhRDROVHd1K0Y2RkhTMVpkOHlSOTIvWEcxUGVX?=
 =?utf-8?B?K1BPVzFiQnJ5YTRqRTJ0TWpHNmtFciszR0ppNTh3bFU0Q2ZhWFhCVllxelZN?=
 =?utf-8?B?YTNYeXFGY0N1TzJ1QWFpdERjYUlwN0czUnl4ODVzVWRBb1BVMmRyVGlKKzRa?=
 =?utf-8?B?V2FBR3NPTFFKY2swek5LUXp4VGswb0k5ZTBlUnNzbUYyTVhnS2pBYlV1Tm13?=
 =?utf-8?B?dUJicXAxRVhUNkdabDJzZ09BczhxT2MybzZkWTlZeThCSC9pSkpyUFJMa2o1?=
 =?utf-8?B?U1d3bFhHM0QwdEpaWU82UUhNbVJJcVltTGdCV2p6U1pzWnBVeU1xdERvRlJS?=
 =?utf-8?B?bDJLYUpHKzYvaXNiQUVuZnc1Ymt0dDVUaWJnRlhsSTlrbnVyUHNRSk1hU1ZX?=
 =?utf-8?B?MzlUWG5ta2hDZmVsWmxqTTZPWCthMXBzUmxEY01TelQ1UUtWeStzRDhoTExD?=
 =?utf-8?B?VXRXY1I2bXdUeU9qd3crUU9ZeFFnZ2VEL0tPR1hOMEdsUmhmWHNDdEI3M21n?=
 =?utf-8?B?akFYSFcrWUFOMURaYkpDb3hQTlZtaVhzNGtOMlJVU2lra1hnRWRuNnRRSUto?=
 =?utf-8?Q?dSLuluUg+qpXIwPSreAKSjk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3pYUkxXSDgxUGZhdFIrMnQ3eXl6S3orQytab0hwa2xXSWVvMDlWLzM0TVhk?=
 =?utf-8?B?QVpJaGpUUHA2c3lGcHhUM292WnNvTHY4aENWb1NWKzB5Q2FWVnNjYWx5L0Fr?=
 =?utf-8?B?NDRyR0MrUFhWdldvNXVGUWNnNlkxQ1hRRFBtYy85bCtUZmIvUU9ZYnd5ZmJP?=
 =?utf-8?B?RDZsdk02Kzh1MEV4WXcxaWxYZ1g5Q0NFNldldnZ5aDZkejNOQ2ZuZmRWMU5n?=
 =?utf-8?B?c3g4bThORWEzWWJFSTVWdFJ2ZjVYY2xOcHZTUEw2VjBZWk9kSDFqQXZPQXE1?=
 =?utf-8?B?c1lzbWVRZjMxSjZCblQ3RFhBb2JwQVE5Q0NGd1lFVHM2ZnVzN085bk8xd3Ar?=
 =?utf-8?B?clJxdnp2amZ1UU1vbXBySTI1Vm02Z3cyZTVBWWhaMjBiWE5abWtRazAxdHhJ?=
 =?utf-8?B?c3pNM2h3OTE1QUN1ZTk4cWhWQXJLVi9vOEtHNmJoSmlpQWdnUUV5UnZGMGZO?=
 =?utf-8?B?dzFvRHcxcVNBbnFVd0g4dlowV1VtN2xGeWc3SjhNSExXVHEzYURVa3FLTW1i?=
 =?utf-8?B?ZGxsZWdBM2pTdW5ESFdKd1RoUVNKeDdsdjM4dUlmdGFPRWJmZVBIdG9UbFVi?=
 =?utf-8?B?L1ZCYjZadjJYVk5uZXhpMjdpdnQxMkEwemZyelNiVGdkVDViZG5oM2oxUmVL?=
 =?utf-8?B?Vkx2UjBMR1pZYTlCV2trYis2aUtzaWlYWDExemRoRDMzMDhsMFRTYmptMUpV?=
 =?utf-8?B?NGNVV0c3RE1Wb1o1SzloK2djNDRUaHFhTzBEZmxZU1pzamViTXlkVHB4UWRJ?=
 =?utf-8?B?ZTBnTXN0K3ZYMVBHT1NjN2RVSjdCNVlSZitnRys5RnAwbmhUbk5sRmU0cjZp?=
 =?utf-8?B?ZWdnV3E2RW9zTkpWUUJVcGh2dFhodzlSc2FnQkhmUWFWcm5oalB4dCtyYVRW?=
 =?utf-8?B?TFVnUVh4RTJLNi8zUUxITFR4d1VOODdKN1NvWDR6VngyRDF0RGt2MzZhb3Fk?=
 =?utf-8?B?VUoyOXlHa0lwVWdwT1lJZ2l1V2pGeGdQd1BJTnExSFlyMlVRbE10NVlTRHN6?=
 =?utf-8?B?UHhnYmc4S0Q2Y01CaTU4SDNMV0cvUW51Y3ZTK2JpQUZkWnl6MnRKaTlkSnNS?=
 =?utf-8?B?cS80VWNZci9CYmpXQ2ZLbEpEL2ZiVnN0SDVjQkpkZHRkUnh4ZU44Q1VERkJy?=
 =?utf-8?B?c1FBbjQwa2NYQTFva0xOQXJBa0xTZGFPTUFDOFZqM29MbGttOHJLblZZYS9a?=
 =?utf-8?B?SGQ5UmFvc1BpV0Z2eVd2RndaWWhWUE44YWZhYjY4TjZtWUJxajRBZHJTUENM?=
 =?utf-8?B?YTVOT0hGMDNLVnIrNTUyMFl3ZWpyVC9qZklOUUhXTXdDNlAxSE1nMVJRajRt?=
 =?utf-8?B?WlZQRXFhanJGdXkxM3hqSWV3a0ZzenVCOFh4bVN5dndBM2hyUXdsN3VBVDYr?=
 =?utf-8?B?V01yOXRJWU4xUXpzRXZNeTRTZTVKYzhsL0Vza0ZsMDZBd3dZL2pBa1BLWTQy?=
 =?utf-8?B?elZYb2h3UGJueXJkSVVKRVhJTjVvN2Qra1NMajFHSTZ5NmlCK1lQaHU1UTE3?=
 =?utf-8?B?U0RvVllCN3pOTnF0NnQ0ZGlUV0t5S0FrNytjeGx3UGxkV1h1WVlKblRWZVVi?=
 =?utf-8?B?bDB6MnVWeDhXQ1JnRXF2ZGF4TkY4eFMzdEdtR2hXTWZaQ3RGaCtZdmZVYzQx?=
 =?utf-8?B?QmVZSklMcmdiSnpjOVQvZU1iMFZvb2loSUZ2ejVHVkJ5MzNFTlAwWTJBSlFa?=
 =?utf-8?B?M3hJYm8vNmdNSkY2MFdGb3I2cGp5WENRbzBxdWU3Ty9tYm51TURYQTYwSGd6?=
 =?utf-8?B?QlJpVHlXNSttMFowaVR2cWFFaXhXb0NJeTJlOTRxKzJieS9jWUF4d296RGha?=
 =?utf-8?B?dWtnS1AzREFhcjR1eTlJMTJic1Qzc0tCWEovRzFrTkREVjYyVEkzNU9hVHRk?=
 =?utf-8?B?NVBscFZSVGJYa0VLU3Njck5xTU5ERFNlZlJVSFk0dXh5RUo3eHpzaVA0UGlh?=
 =?utf-8?B?cHZvbkNzcXVCeEx4TlJBK0VGa0k2OG94dVVsanZ3SFJwUWdmTHhEUUdZcXh5?=
 =?utf-8?B?RHlyRjJSaDhnaHJBMG8wYzh4TWZEZ1Vqb28xZURPQ1dHM0hIQTRsdjdNSVhr?=
 =?utf-8?B?YnNONlZrSWx5RHVPM1U5SUp6VG5zZjluSDhkM24vTkhtRGY1VDJhWmJNcXNE?=
 =?utf-8?B?RU1NQlRzZ1lubUpKVUcxazBDaXAzMlAzNGtHcyt0NnRRY1ZiMkord3JkRFlG?=
 =?utf-8?B?aXM4MjNONzIvbHR6akNnYlNXYUgyMW5DcmxBVW1QTVo2dVhOUSs5dks0dk1j?=
 =?utf-8?B?czVhWE52VWwwbmgrdVZNWlluaC9UQ1V2OG14VDFjVzJKbDl2MVBpUVJNQmVJ?=
 =?utf-8?Q?5xJdW/32lzLjvSnkXT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1780bdee-0714-47bb-89bf-08de620057a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 02:11:14.2627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHrlhvQXNhO1XCsI13GRHJge+PrggE4FWNC46eHwrfs6Fsress96EeAaaVqMk9JICWUz7QZMzaVvxTHg5q6Ozw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10601
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255693-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C6C3C7D8F
X-Rspamd-Action: no action

PiBGb3IgRU5FVEMgdjQsIHdoaWNoIGlzIGludGVncmF0ZWQgaW50byBtb3JlIGNvbXBsZXggU29D
cyAoY29tcGFyZWQgdG8gdjEpLA0KPiAxNuKAkWJpdCByZWdpc3RlciB3cml0ZXMgYXJlIGJsb2Nr
ZWQgaW4gdGhlIFNvQyBpbnRlcmNvbm5lY3Qgb24gc29tZSBjaGlwcy4NCj4gDQo+IFRvIGJlIGZh
aXIsIGl0IGlzIG5vdCByZWNvbW1lbmRlZCB0byBhY2Nlc3MgMzLigJFiaXQgcmVnaXN0ZXJzIG9m
IHRoaXMgSVANCj4gdXNpbmcgbG93ZXLigJF3aWR0aCBhY2Nlc3NvcnMgKGkuZS4gMTbigJFiaXQp
LCBhbmQgdGhlIG9ubHkgZXhjZXB0aW9uIHRvDQo+IHRoaXMgcnVsZSB3YXMgaW50cm9kdWNlZCBi
eSBtZSBpbiB0aGUgaW5pdGlhbCBFTkVUQyB2MSBkcml2ZXIgZm9yIHRoZQ0KPiBQTUFSMSByZWdp
c3Rlciwgd2hpY2ggaG9sZHMgdGhlIGxvd2VyIDE2IGJpdHMgb2YgdGhlIHByaW1hcnkgTUFDIGFk
ZHJlc3MNCj4gb2YgYW4gU0kuIE1lYW53aGlsZSwgdGhpcyBleGNlcHRpb24gaGFzIGJlZW4gcmVw
bGljYXRlZCBmb3IgdjQgYXMgd2VsbC4NCj4gDQo+IFNpbmNlIExTMTAyOCAodGhlIG9ubHkgU29D
IHdpdGggRU5FVEMgdjEpIGlzIG5vdCBhZmZlY3RlZCBieSB0aGlzIGlzc3VlLA0KPiB0aGUgY3Vy
cmVudCBwYXRjaCBmaXhlcyB0aGUgMTbigJFiaXQgd3JpdGVzIHRvIFBNQVIxIHN0YXJ0aW5nIHdp
dGggRU5FVEMNCj4gdjQuDQo+IA0KPiBGaXhlczogOTkxMDBkMGQ5OTIyICgibmV0OiBlbmV0Yzog
YWRkIHByZWxpbWluYXJ5IHN1cHBvcnQgZm9yIGkuTVg5NSBFTkVUQw0KPiBQRiIpDQo+IFNpZ25l
ZC1vZmYtYnk6IENsYXVkaXUgTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0YzRfcGYuYyB8IDQg
KystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMv
ZW5ldGM0X3BmLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5l
dGM0X3BmLmMNCj4gaW5kZXggNDk4MzQ2ZGQ5OTZhLi5jMDg1OWQyMDBhMmMgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0YzRfcGYuYw0KPiAr
KysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGM0X3BmLmMNCj4g
QEAgLTU5LDEwICs1OSwxMCBAQCBzdGF0aWMgdm9pZCBlbmV0YzRfcGZfc2V0X3NpX3ByaW1hcnlf
bWFjKHN0cnVjdA0KPiBlbmV0Y19odyAqaHcsIGludCBzaSwNCj4gDQo+ICAJaWYgKHNpICE9IDAp
IHsNCj4gIAkJX19yYXdfd3JpdGVsKHVwcGVyLCBody0+cG9ydCArIEVORVRDNF9QU0lQTUFSMChz
aSkpOw0KPiAtCQlfX3Jhd193cml0ZXcobG93ZXIsIGh3LT5wb3J0ICsgRU5FVEM0X1BTSVBNQVIx
KHNpKSk7DQo+ICsJCV9fcmF3X3dyaXRlbChsb3dlciwgaHctPnBvcnQgKyBFTkVUQzRfUFNJUE1B
UjEoc2kpKTsNCj4gIAl9IGVsc2Ugew0KPiAgCQlfX3Jhd193cml0ZWwodXBwZXIsIGh3LT5wb3J0
ICsgRU5FVEM0X1BNQVIwKTsNCj4gLQkJX19yYXdfd3JpdGV3KGxvd2VyLCBody0+cG9ydCArIEVO
RVRDNF9QTUFSMSk7DQo+ICsJCV9fcmF3X3dyaXRlbChsb3dlciwgaHctPnBvcnQgKyBFTkVUQzRf
UE1BUjEpOw0KPiAgCX0NCj4gIH0NCj4gDQo+IC0tDQo+IDIuMzQuMQ0KDQpSZXZpZXdlZC1ieTog
V2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQoNCg==

