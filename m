Return-Path: <netdev+bounces-268375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJibLqqsuGkdhgEAu9opvQ
	(envelope-from <netdev+bounces-268375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:21:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 325C02A282F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 398C6300A11A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F830C608;
	Tue, 17 Mar 2026 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ea4Gm1T+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="glUstqX2"
X-Original-To: netdev@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867361FC7;
	Tue, 17 Mar 2026 01:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773710500; cv=fail; b=loZ0o67RYjxOx5K+OuhGInG300692cHMWEBwDMyXVkGZIwEUbqwTHfmyK9IGE2HAQIaGnyjto81u3KRcjHGJLnG0Jca1/eAMj8D6daCnUGTA7Ftu0pouUmPsjW28oqHWTKwv9FOVLMojTgcIc2BxVbfoq4t2NQAUmfj9hMYCmHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773710500; c=relaxed/simple;
	bh=K2clCkSd86d+9ilA80otC4yDCRSdSaVnvv5L1LsgJ/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pgJNDA2uhY/wI7L9DFtQ8Uip2Eb6dWBaCmoSDRYLlUtGBETj3SVKhAUukDxMxZDCt4qtsDLKxDJlNIeu1RuwyIGTybN3vxS/blN+qNZ805UOgdVtxo/yHXVrjNk4xaU63eiRTelid2JasrsIHIhaj7VPBp2NXAyaYFQIzNpXPXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ea4Gm1T+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=glUstqX2; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773710499; x=1805246499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K2clCkSd86d+9ilA80otC4yDCRSdSaVnvv5L1LsgJ/U=;
  b=Ea4Gm1T+PLOPUTi5t8ncQv0e1TxyivvgfmQTGk0F55XHJFCgnUM9PwGr
   zANlC5FMzAElDn2bBmKKlWySA83djkq/hMqNXjgOlIJJE956+60pWpOoF
   S2G2hSs9I6FokRCIZveee1UAoZtAwMWjoJqkPgifD4QKHmkxrQd8G8urH
   z9+EBIslAlj/VyjbXjab7mFwg1DdCGRCbEw6JPqwCUUlra95jLdMqj3+G
   brU+HukCiK0w0uJVTm9+kLJ/f23ThMop9+QBmdSK+TO0dxtLBgkanQoXq
   Nya0w33NmRNEuD3IoyGa8z3CvYdwyz+SmNsAnpoEXazDq0N4kOrMBfxTy
   g==;
X-CSE-ConnectionGUID: UL9yWB2ERvmdbrIvIujW+g==
X-CSE-MsgGUID: 4d7gPRnKRxyLMbV4EqzJ1w==
X-IronPort-AV: E=Sophos;i="6.23,124,1770566400"; 
   d="scan'208";a="143781741"
Received: from mail-centralusazon11010047.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.47])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2026 09:21:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIQNLTqVRhwHPm2/jUPAz3Me86C9nCEyGZH4WABh69ogy9xbavcsvX+RPvgpihaAXCn0e9zft5Uai9Jx3INgGDfyH80o+OQMG4C0DMXG8JezTFC9LEOhcIqO5jeycDZTN679P7s7nPsgQ7KzFTurEIbUku7pzBOUtwT3XJXnvynJUe/gqGJxx4GDVoN8mOarW0ZX2k8jbp1bb9p7/E52aM3+gyikiY2EDhjjl3assLHhGQXJQ27P28UxP9aAdfx6L2cZf7JfCh8szSTOgqLqdWxmfquCidbAuxfJhA8u01Lo0D7pkZATvl7euxSkGDkTtPSf9G5FeaP3dBAFPHFAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2clCkSd86d+9ilA80otC4yDCRSdSaVnvv5L1LsgJ/U=;
 b=IUfeYIfQ0la75P1fVq+otlftX4zd2fTdCtblk32XQNaDYKGWjS6tVMSTg2AgRrduF4AeBPfQlM06wGVBiSF5SQe7MU9vFgiMOXO2HMWlJMtNG3KihjArlcE9AkS0sffETQ4YGjaHQysNekKeo9yHHPNu2C5+mf3HF0q0Wmjkl+VlALy2jnczQvdPD1Fg6LV0DiCos3A5mSPrzq2L9+i550dnMovLsCd2+AC31CoJhysgJVtlecv2AuDyzS7FSB4tPHtT7Y19QXnsKGPViNPLQ2uvb7ATC7mgQzg6Qeb4NLdPIKb0Ria+njYOmjxkvGeDvZ9HBkMsrPmH05Gkdq1HKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2clCkSd86d+9ilA80otC4yDCRSdSaVnvv5L1LsgJ/U=;
 b=glUstqX2/WBO/JcASxTFfQGzPiSeXUhW7OpkBr8ZsqgG6k7C6S66FTQxWPXDENxEjwuEPeqEKiFtsWKWcWLEgTdxJUqbyKV1Ep2P70Tf03Z0fvKtLtV0+mUl745lMODaH/DB3gw+Wlm1/z5tyMVqnU5WvlUcZjNM9H1zfxGyyb8=
Received: from SA1PR04MB8303.namprd04.prod.outlook.com (2603:10b6:806:1e4::17)
 by PH0PR04MB7605.namprd04.prod.outlook.com (2603:10b6:510:57::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 17 Mar
 2026 01:21:25 +0000
Received: from SA1PR04MB8303.namprd04.prod.outlook.com
 ([fe80::8719:e407:70e:f9e1]) by SA1PR04MB8303.namprd04.prod.outlook.com
 ([fe80::8719:e407:70e:f9e1%6]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 01:21:12 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sd@queasysnail.net"
	<sd@queasysnail.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Alistair Francis <Alistair.Francis@wdc.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Thread-Topic: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Thread-Index: AQHcr4k7hso1zcbGlUqlU5NbBiJDT7WseAsAgAGpkICAA9A1AIAAAviAgAAE4YA=
Date: Tue, 17 Mar 2026 01:21:12 +0000
Message-ID: <8f29d43fc1fd7e6feec4c24131eb2c0292a8c0fd.camel@wdc.com>
References: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
		<20260309054837.2299732-3-wilfred.opensource@gmail.com>
		<abQOGm6BqAE5eEln@krikkit>	<20260314073919.2f92b966@kernel.org>
		<9e9f6eb89ba95e9fbb764e2807420e98b566bf37.camel@wdc.com>
	 <20260316180355.37d45785@kernel.org>
In-Reply-To: <20260316180355.37d45785@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB8303:EE_|PH0PR04MB7605:EE_
x-ms-office365-filtering-correlation-id: 909f0f4c-6d82-410b-92d4-08de83c379f3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 e8/K/cWDkU2t+gAiGrdcJPe+PTBGQrXSt1AdY4M+UcNJlInCLvY5U5o0ykzNC6xEvnFeptMCvdI6k+pEdg65LUMW5ZHCTUDB1/5ddZgF+XQq529kls2B//LsLDwXnrkoj5jBCW1tU7yD8fBxbCDUti4xS0kyWkJmDiW1Lg5HRMvXkN0zQbvaEwHErTg1x3Vl/oogyjIE+zwLnx+GoGKygZQzP2D5rJCCywTsO0FSOzaKstLHduvatdMeZi53JD16zVdpkR22Nd8R7ulcHxQDkI3Obu4ZVoFHsld8NGUxq8WGohxDB9gRSnWpa4vZdrV6Jbgfz9phbKFzbMwQjIHwP/MWWNXw6Rue/yuxh0pjRwKdtHZhomToMJBCyRoWSgN0aFP3DZHR/L5XI4J6GY0fhcAODzT9FAr0Fz7IrgFCiBI7qO5K0rer8ZT8LUw22B6NY+//x+xPtU7e/VLho+n+jhNkun6EsTG6x7y8tgCN6rcD2zlvpfStxBGwT0VeXabaa48zirX3g/bgvxMmZVaHU+1gpGgGT7jHpgrNT9jonjfKMwvFkDJPzwFAnu9pPjP7ZuWmB0h7g0Vuj5WR5JzMJag4z3rAydzF8GIDDFTQcJuPr02JCBTZO/fadF/NkSMsmuoiPbIpy9LRFFInadpYoGjsSFsIWn2IDdelnM79NiVh3Atili9GDrfibHMQmSaGhsqj/wduyTCDj78FpQOaF59ifQo3PrKmXNM8UV2ig7Q8VbBdSofcykYeq1jxhxSv0aoig2T3pQ004CfOV+VVyO2HwN9sKjxysIg9QMOSCtk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB8303.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWlPVUNwZlVYSEF0aFV3V0h2Q25QNzRiSTQ2alk1RTFJQ1F1b2JXWGkyempv?=
 =?utf-8?B?SXJPSENrYnZ2TGFYREhLRFhHWkJGQTNucU1FSHg1R2V3RzhnN3NGMlpUa3li?=
 =?utf-8?B?WTRySGhKZER1U09yV1dKb09Xd0NCUytzblRwblIwU1hPbDlWMXUzNVZ3bWt1?=
 =?utf-8?B?enBVWWFTWGhOWGV1U2VoRXVueWFXd1NaQXYzTnRCa3Avcm9oMXFFbUtUYldF?=
 =?utf-8?B?dUJKR0pFQi9BaFBEQVdSSGo1U0lOUDRjUnQrdmJvMlI1d3dSYW5QZi95Mlp5?=
 =?utf-8?B?MTRJKzRBdnA2dHh2ajIvb002ZHRKYWdIVVFxZ3lNWUdZZkxaWmJJOWVva1o5?=
 =?utf-8?B?c01jTWxCaFZFYnpGREtNZnB0VEJFbXQ5bUREL0Fobkx5REdES2tNUnpYS3Fh?=
 =?utf-8?B?M0JETHZUdzF4Q2VwV0FtVFFhUy9LRDBTRDBjb0t0bjUza2YvQUFwOFEwOG04?=
 =?utf-8?B?eFhPbmtLQTZhVUdXV2hhYmkzSW9pcVlMazJuWGpHLzZSa0F3bHNRTFVTRW1K?=
 =?utf-8?B?SEI0a0pXdlpxR2dWTkRSSjQ5ZUhGeDFtVzV3amdMTmJQenlndEpCaWI0Z2FL?=
 =?utf-8?B?d0tQK0Jla2FWZ0JBMFRRdVI1bG1TdFR0aWJvenNWalRmVEpBdjd5Nmc1SGZV?=
 =?utf-8?B?SWFwT05NRmRmTDU0Uk1RTyt3Rjl4WXR6c1BvMHFiMk1YRjdVc1E4UGFGS08z?=
 =?utf-8?B?OTQrQmo0VjBXRWpQMEo1RHJKN21OYkx6MnFRVXd4SXNyZ3hqTk5UMnppcTIy?=
 =?utf-8?B?Y1lQaFI0Z3pQRjd5dlk0S0krUTEvL3h2VjQ3VkRma0YyaHpKR3lTMkI5Uksx?=
 =?utf-8?B?cnFudzUzNDNPbG9lZFN5YmNRQ1ZiZU1taDRwMk1SR1Y3Y0RZNXFoM3NHa1Vj?=
 =?utf-8?B?WW11R0IwSFEvQkRwN0FCRklTOElTVWhPOVh2eVRwcTh3aFJ5dlY2c1RQdk1C?=
 =?utf-8?B?aUtEYXpJaUpVRVpuZUNVYzVJbFVRZW9STXQrZHJVazBsWTVBUmlrdGJxQmNF?=
 =?utf-8?B?U05FZDFjNmlZdFRVaVN6dnFHK0NxSlpsNU95eHNBL25DUWhTR0MyNjJVTGF0?=
 =?utf-8?B?ZnZNMXgralhkRGVNNjE5VlIxVCsxcUYzdFA2WmkvbEkzTmtvYVRvdVEwQXNo?=
 =?utf-8?B?ZkVtNGplZUM2b2tMNGY2SGZBQk5zdXJhMjVIN1ZRZ3pJcllSR01xU2t2bEtN?=
 =?utf-8?B?YXZVK051ZFBJTEV6WkwxRnJCVXVNaVpnL09LQmwzemVxcDZQVVZIYVN2TlZh?=
 =?utf-8?B?WWV4b2NCQzBvMTlONXB2TmtQenBlVU9pbWFSZDVzdXhKajloWnBYbGZVNDI3?=
 =?utf-8?B?QTZabWJyd0xNb1RILy9TemlrVFNkYm1rY2JJRFl0ZzNsNTlwenlrb0YrMjB0?=
 =?utf-8?B?azloVnk4UE13YzZGdlhRQjFLMDUwS1BySEhVUXNjUlZpZElEWmpuSWxWVDlX?=
 =?utf-8?B?Wks3Z2lxSjNTNTBLU1V6YWFIVE9KaDlMWTYrclJ1Y0Y3UklVWFJYOU9OYVJn?=
 =?utf-8?B?VGZqRUlqWHBpcEFObXlIR0FLUTdSWk9IQnp2UmVySzdGOGpOS3FMbmJld2hP?=
 =?utf-8?B?V0V3bWV4UVdDU05FQmdwQVB4YkFoMEdRK1V2M2NkRjI0Z2ttTnpOT28weXMw?=
 =?utf-8?B?bTduKy90S243YlhHSllLVFZZd0hJY3Y5SGQwYklzRkZNOUVwKzhYWGtOMlZ2?=
 =?utf-8?B?VmhacDcvcVpXS0o4NlRvcWgyaENyL2hkcnZUODVGcTN6MURsTzFyTVlYejQv?=
 =?utf-8?B?WS9zNTRCRE9ZS0syWHpqOS9QWUxSUUhMMzlSQ2kvOHM3cmRxNTRjcUllMlF2?=
 =?utf-8?B?TEdtZkMyWEdpa3M1d2NybmR5bjFkcURwb2NhOUxZbTROajE1dmNPZUtydHZJ?=
 =?utf-8?B?VVNrUTd2WXZSUU5zNFVMYUs1aURvamFoTFl2ZDBkYmxDWjg4bE9XV2Z4b2hE?=
 =?utf-8?B?RVpZOTRrd2hSWUdlSGVzeEt4MjFLODZYVE8yQVd1RDlQL0dHYnB3R2lzODha?=
 =?utf-8?B?WWVDd09nR253NUhFb3NLZXIyRldUN0ZpMElpLzgvRHpueW1tMk1OWTJIK2Fu?=
 =?utf-8?B?ajZnZWlOQW5SZTYvYXl1bVkwMHpiRHd4ZzQ5QTRaZndEZ1JZejhzb1J2Z0la?=
 =?utf-8?B?dkxCTVN0b1ZOZ1NCWVI4MVpwVmljckIzZTdsV25EcDZJa3RMWnFxNTVtY1FV?=
 =?utf-8?B?NmZzNlZJb3RxbDErc3ZUUGJaelRjZG9iK0F0OHhpSklSSGNtT0VpRFRQUEll?=
 =?utf-8?B?a0Fhd09KNXpGUUp2UTRjVGV3T1h1SVZ5N2xNYXZweFNKSm5PSklsZjZYWjVP?=
 =?utf-8?B?Um9pTmtESW9TMU1UYkFFWmE4bWhuTnVjZnJ5T2xrQW9YYVJUdmljUnVmaXpz?=
 =?utf-8?Q?HQh3KPx4uC5cr/i4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <909A3C86BCDB3244B2764D8BC74FFBD3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Nf3gYhFBwqeKXP1y6t2PnBdZQ2uo0DeSa02zJcOtO1ddmPSjMMgoJK1Vbqysw5vk+MjZz36hehzTc5a6Co3bYBaNvHtwPttYKV9Y2nY+C3YjY20pP9E4wZrYNGH+xKjOb2i/tDU5zc4mGC0Cyfby5S6OKXwKkbY6MV6iUbgCYxXW2tz3ECLj400nVMNweQzf8iDsOwMTUlRqRDytPkL7ULGRD2YgvBDkH1SscJ/gSGQupUsSDzd6vbIBIkiEWwMkBTQrcz5KhQcWYM6ZYmtX1EsJSqOBv5yg1rXrxKRPweniS+SdAucYtgAtCG36Ps+4numsuuvECprW7lAUK4sVDg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2gRgpkZsXh7D0PwW9igg9+bQA4YfI1m4H/c27W+I8Z3uZYjKs71aa6FNOkAyySNTdEXwHdAMR5hrOmMT0NguD9hrUHU2W6pC7pre06t+eFBNCFreLfpekYw53y/EpwGQWaQQLHzjItO77XG7TOCNSwwaMcDCkapjAsfxNqZ8mHoMYXnZ/FoD5KENJVEn1OtYDJse7Rd+UVLRq4LyS7rFfHqUomyqLrkbIIfNfC4CRhZNZVq4onw9TGZB42eR//ISSdt0imDazmx/qG9Qz3r+WfyTlTYyI1ZD/Fe/U7yc1Rvu3AGOiJoVwWGgPRHwhScX3Knu2hU7nJgAb8QfFpnuwQP62UNiQ5egDTfGZkW/Gw8l/pJ1UiHku/yEGU3v70/LsRBWXGk2JRKWlDBX39igKQS/Ym3HpZNtS4GlUEI4g3B+LpKXjWJFHt9FGGKUoA8wgvXHJgKdb7WTmtPLH+C+bBVt0OABOPVx0liW80JFnQxTq0hcwVWBZXrUNlesbePpPBuxshddEj/l27J340sE7dnxR6ytKrHE/TZhFIgoCy8BzLj8k43zi2waMjGPI3O8Vc1PiD+gPW6DcrXgA8aFITjor0zm+7eqi9yP0zyjwymG1S3zM/t1m9ABVTnFMRfs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB8303.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909f0f4c-6d82-410b-92d4-08de83c379f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 01:21:12.0621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTu6xScUIlsG65Fg6JxmEbyV6uFhZ1LbxGFiKAIqBzaAhLbx6ZFzAxasE/C4pdT+AY3bBEy4tOmcUcvFnVGXCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7605
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-268375-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lwn.net,kernel.org,davemloft.net,vger.kernel.org,gmail.com,queasysnail.net,wdc.com,redhat.com,linuxfoundation.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[wilfred.mallawa@wdc.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:dkim,wdc.com:mid,ietf.org:url,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 325C02A282F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMDI2LTAzLTE2IGF0IDE4OjAzIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVHVlLCAxNyBNYXIgMjAyNiAwMDo1MzowNyArMDAwMCBXaWxmcmVkIE1hbGxhd2Egd3Jv
dGU6DQo+ID4gPiBPciBtYXliZSB5b3UgY291bGQgcmVmZXIgdG8gZXhpc3RpbmcgaW1wbGVtZW50
YXRpb25zIG9mIHRoaXMNCj4gPiA+IGZlYXR1cmUNCj4gPiA+IGluIHVzZXIgc3BhY2UgbGlicz8g
VGhlIHBhZGRpbmcgZmVhdHVyZSBzZWVtcyBzbGlnaHRseSBuZWJ1bG91cywgDQo+ID4gPiBJIHdh
c24ndCBhd2FyZSBvZiBhbnlvbmUgYWN0dWFsbHkgdXNpbmcgaXQuIE1heWJlIEkgc2hvdWxkIGFz
ay4uLg0KPiA+ID4gYXJlIHlvdSBhY3R1YWxseSBwbGFubmluZyB0byB1c2UgaXQsIG9yIGFyZSB5
b3UgY2hlY2tpbmcgYSBib3g/wqAgDQo+ID4gDQo+ID4gRm9yIHVwY29taW5nIFdEIGhhcmR3YXJl
LCB3ZSB3ZXJlIHBsYW5uaW5nIG9uIGluZm9ybWluZyB1c2VycyB0bw0KPiA+IHVzZQ0KPiA+IHRo
aXMgZmVhdHVyZSBpZiBhbiBleHRyYSBsYXllciBvZiBzZWN1cml0eSBjYW4gYmVuZWZpdCB0aGVp
cg0KPiA+IHBhcnRpY3VsYXINCj4gPiBjb25maWd1cmF0aW9uLiBCdXQgdG8gYW5zd2VyIHlvdXIg
cXVlc3Rpb24sIEkgdGhpbmsgdGhpcyBmYWxscyBtb3JlDQo+ID4gaW50byB0aGUgImNoZWNraW5n
IGEgYm94Ii4uLg0KPiA+IA0KPiA+IEknbSBoYXBweSB0byBkcm9wIHRoaXMgc2VyaWVzIGlmIHRo
ZXJlJ3Mgbm90IG11Y2ggYWRkZWQgdmFsdWUgZnJvbQ0KPiA+IGhhdmluZyB0aGlzIGFzIGFuIGF2
YWlsYWJsZSBvcHRpb24gZm9yIHVzZXJzLg0KPiANCj4gSSdtIG5vdCBtdWNoIG9mIGEgc2VjdXJp
dHkgcGVyc29uLCBhbmQgbWF5YmUgU2FicmluYSB3aWxsIGRpc2FncmVlDQo+IGJ1dCBJIGZlZWwg
bGlrZSBpdCdzIGdvaW5nIHRvIGJlIGhhcmQgZm9yIHVzIHRvIGRlc2lnbiB0aGlzIGZlYXR1cmUN
Cj4gaW4gYSBzZW5zaWJsZSB3YXkgaWYgd2UgZG9uJ3Qga25vdyBhdCBsZWFzdCBvbmUgcG90ZW50
aWFsIGF0dGFjayA6Uw0KDQpUcmFmZmljIGFuYWx5c2lzIGlzIHRoZSBhdHRhY2sgdmVjdG9yIHdl
IGFyZSB0cnlpbmcgdG8gbWl0aWdhdGUgYWdhaW5zdA0Kd2l0aCB6ZXJvIHBhZGRpbmcsIHdoaWNo
IFRMUyBpcyBzdXNjZXB0aWJsZSB0byBbMV0uIEkgdGhpbmsgdGhlIGhhcmQNCnBhcnQgaXMgZGVj
aWRpbmcgdGhlIHBhZGRpbmcgcG9saWN5IGFuZCBiYWxhbmNpbmcgaXQgc3VjaCB0aGF0IHdlIGhh
dmUNCnNlbnNpYmxlIHBlcmZvcm1hbmNlLg0KDQpUaGlzIHNlcmllcyBhZGRzIHJhbmRvbSBwYWRk
aW5nIHRvIHJlY29yZHMgd2l0aCByb29tLCBhIHN0cm9uZ2VyIHBvbGljeQ0KSSB0aGluayB3b3Vs
ZCBiZSB0byBwYWQgYWxsIHJlY29yZHMgdG8gbWF4IHJlY29yZCBzaXplIGxlbmd0aC4gQnV0IHRo
YXQNCmFkZHMgYSBtdWNoIGhpZ2hlciBwZXJmb3JtYW5jZSBvdmVyaGVhZC4gRm9yIGNvbnRleHQs
IHdoZW4gdGVzdGluZyBOVk1lDQpUQ1ArVExTIHdpdGggNEsgd3JpdGVzIHdpdGggYSByZWNvcmQg
c2l6ZSBsaW1pdCBvZiA0aywgd2Ugb2JzZXJ2ZWQgYQ0KNTAlIHJlZHVjdGlvbiBpbiBJT1BzIG9u
IHRoZSBmaXhlZCBtYXggcmVjb3JkIHBhZCBwb2xpY3kgYXMgb3Bwb3NlZCB0bw0KdGhlIHJhbmRv
bSBwYWRkaW5nIHBvbGljeSBmcm9tIHRoaXMgc2VyaWVzLg0KDQpXaWxmcmVkDQoNClsxXSBodHRw
czovL2RhdGF0cmFja2VyLmlldGYub3JnL2RvYy9odG1sL3JmYzg0NDYjYXBwZW5kaXgtRS4zDQo=

