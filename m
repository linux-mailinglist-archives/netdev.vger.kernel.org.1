Return-Path: <netdev+bounces-268356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECQhBZOeuGnKggEAu9opvQ
	(envelope-from <netdev+bounces-268356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:21:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4562A23B2
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97BDE300E68E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83D11FF61E;
	Tue, 17 Mar 2026 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LlQw0nm5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nrN0BpHg"
X-Original-To: netdev@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203601ADC97;
	Tue, 17 Mar 2026 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706892; cv=fail; b=CnHanfgWb/fcspH3Iqd9+bv6/inxypM5F0i/DKri4+4OVm6QhuJgZxPq9vcZDQaTLWQ7j1EN4HOiCwGtVdVFKtXi9T3Z5KPussl7Z7RcZIGZVIs7e6WR0dU4jquRBNVPY/0dRUDZ6atNTqvkSqugKkRnGWDTfrJLkxQBTm+Ejnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706892; c=relaxed/simple;
	bh=Q+SYKeuenKemaisG+obG2FxldtoN0qd+n3iQfLZu01E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p5QDp0JLEyyMxNOIhIsNKsu0ciboe0wFRTIc0SeGmioX1bGrv65Hb9QrAw+QLfoxtw0m08qLN39pUuzYbcTFHqXnWRccv82UcVrlmtQVTe+1DHC0K/x2i/oi0CJcyktikP2sVR8TF2ZQ86nCPjFVewl5mPWvztabXrxlNL5wexg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LlQw0nm5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nrN0BpHg; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773706891; x=1805242891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q+SYKeuenKemaisG+obG2FxldtoN0qd+n3iQfLZu01E=;
  b=LlQw0nm5FathseXgVuClrl2o3Ts8Q8Qjdkk6WnINv4NOpmTd8cjaiXs6
   Z3jHC7TY/xJ0+5brfVsDuD5scMEu3+pGHLEC44C3TsxY/dh2LUybdDi17
   MyHlxwjMBffbW2sYamsDz/6NHyPwnou0X+hkxim+EZAl/+e1ZUaNLjNpF
   jIm9ahWBp/UJKOZd3zW+IoGYz5n+8Ewqf96g1vvtMSF02SgYPUdYWv4tH
   kfoEhBvRRhbvgc6piPZxuB9EnP3OriXI8lfEeTNeCAaM3Q+8EascbIRlL
   qXYUr0IHj6OKehOjpG5zIfxe6PIilG/ck6o4VlDpw5kM1Oog4kRTgMcLG
   g==;
X-CSE-ConnectionGUID: uWNgYVKvT9WSc+hFSmNFOA==
X-CSE-MsgGUID: eIXvLuXZR76W2LN++azGJA==
X-IronPort-AV: E=Sophos;i="6.23,124,1770566400"; 
   d="scan'208";a="142229743"
Received: from mail-westusazon11012039.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.39])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2026 08:20:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twUi2hXScrAPFZwK1cWrQHzuzF5hUqvM4NsKaJCzh//fTF7FmxTydaKudK/zvjSynHGlJKVmhVNyzgNvwF4q1RruefNtTc0yVjFgwBkdz/7qt1lDwbRTNGXz08ILdlQXD/mxwSyWxsK76xmW90tpL/85OpbzXimXjZueQk/Wq21rPwAS9H9XEHRiIQVPqWER8sk26UpIq7JYfWEdPyDBDMwuC4FK+AqaHCSGDuOR19GxWSBeREnBgjyKj2fkeqNw2eN2Zox+ZDkKugKugqUgNLoKhDJsGJxlmf978JOWcYr8frjhFd4pFzD6wHgSbWf7yXFUPFOPos8tJfxKjdgmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+SYKeuenKemaisG+obG2FxldtoN0qd+n3iQfLZu01E=;
 b=AXBVcEtTYYQSEO3fmKsDsHECy5B/U8QMJFSORmd/7upjaACpAmwIl2htuvdsq9uZFgwV4jsE4+jED8M8/i3SeBiXVrkyl4MQc7QcxZ21dFcOh++5gwzUS0UFQUOxRuXjSnXLAzt8DIdrSI28qVwKqUwlQvEnUihOfbJeG5x0RYwwScKd48Q3onBPFZuhfIw5Z5IL3ahyUQEaUQ4JjgUqrEe9x2ftDCqF10iw+p4zqv6oQIdOuzRc/7dvKZrrruspYhda27TlzlZoyWCDaZL2RQTonvNmPPyO+xxLIavuvwnqJZ83nyro/gvyGrFeC3++JU2zMONGmY8gZGY/Pp2Dkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+SYKeuenKemaisG+obG2FxldtoN0qd+n3iQfLZu01E=;
 b=nrN0BpHgo2z4hvpyFchrL6mZow3s00/cymhm0VZr1wd1R5uEBSuhyFDCK0qimKheG1B9Mod/6lptjP4d43yb/UZ8UsqGz4z8Fk0Ed0wzD7hw8xuyjzoLgJMeHBL/cHLTGmxAQnLPJEroiSKQVLPrQVXm11Wu/24WMp8X+AbxJdo=
Received: from CO1PR04MB8300.namprd04.prod.outlook.com (2603:10b6:303:157::22)
 by CH3PR04MB8952.namprd04.prod.outlook.com (2603:10b6:610:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 00:19:58 +0000
Received: from CO1PR04MB8300.namprd04.prod.outlook.com
 ([fe80::a603:6dfb:1d4b:b36a]) by CO1PR04MB8300.namprd04.prod.outlook.com
 ([fe80::a603:6dfb:1d4b:b36a%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 00:20:06 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "corbet@lwn.net" <corbet@lwn.net>, Alistair Francis
	<Alistair.Francis@wdc.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "horms@kernel.org"
	<horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Thread-Topic: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Thread-Index: AQHcr4k7hso1zcbGlUqlU5NbBiJDT7WseAsAgAVwjIA=
Date: Tue, 17 Mar 2026 00:20:06 +0000
Message-ID: <df3dbdba5f8fb87c83ef088092491a843f264a9b.camel@wdc.com>
References: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
	 <20260309054837.2299732-3-wilfred.opensource@gmail.com>
	 <abQOGm6BqAE5eEln@krikkit>
In-Reply-To: <abQOGm6BqAE5eEln@krikkit>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR04MB8300:EE_|CH3PR04MB8952:EE_
x-ms-office365-filtering-correlation-id: c037a804-b081-4264-7f1e-08de83baf103
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 BXOzOvsDDX4uAsHjrEKowQKde0wP8jOiZw6DclEXynrqNhXvmMEYArMLk9R/eqUotKmV1slRKBZpyUydVd3ooqGK+KZM9qo8gmdPDMrJG8CQMsdNm2sYo5s/62xi5kP4xPiN1236F3GixSV0i4vpIgn0EwwMhDqefmv01esWSP2AcA0gs/tSaBfMWYfB2QMXy9pZC/Dtsw8352aA1dP7M3YL9biBmf4LW+2MLVlmYVCf4FW22j0jyFJsjkiuz6Z/5wf9aEcAWUM17SnaZKFLqe26MeZYWkHpjfABAn2YX0UQ0LjEyUcbEiCVTtOlmek4vScjM1OAgOqe4IhDwhbAn+Q57JNUBVXk1sLjcOtiTXoEsJlPTWzKJrNLiDBCeuJ5iFZCLqcb4dmM7vnVH7PoArw7bNHhdtLyYdZiebb0ol7tRmAHqulDYlIyjhvRLwbbGsaxDG87RD9BaMY+Ni0QXfty4JPNcSLPqw7S4wiYel2WetY0jjRY3S2zw2s7ieh/qhJEy4sU7pqqEkk3NtzYSABXcPmJuD/28n1GFAlzZVwr9JISDcf6I0tc0jmWUxWF9kGR/WNvOwLQTJoJFjCypStHdUJUiXHdShrYdcpdQZTQGC02h8IPHxbpUQvpuQ37Dzb3oRJXI4hQrJ+HyDfG8ZdEaFRYxEZz2toxTgtdGJNDShNHGH/F+QMEMGN1rxxgAO4zvEaqkxcU2AgXdRtERBDlNAga7Ua4pMdit3/HrdaRm2TKM/ol6+RRJ/yRWUUG20ynXgzySFDZFS6OwsTKiVH2yvt5tjg2w/pNSwmoqRo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR04MB8300.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDBXZXVIYVlyc2tVRFNDc2IvY0Q3TjlaOHJPZ1REdzVYendpMTJ3YnNGd3Av?=
 =?utf-8?B?NExmRW5tNHB1SThyZWFQcVlxU21TK1pLWkEzS1Q0d0FnT0JtdnB5TlM4Mkhj?=
 =?utf-8?B?NFUxcG4wYjFsNXQycVdKZkR3RFpVV1hGbVBvZWlqa1hRUUZSb2FtL2lSb2Vu?=
 =?utf-8?B?bFpMWHAvMVFRRjBrTEJ1ZjRYUFdmZkdnZlJlRWNzTlR0TElSKyszVmlQenRT?=
 =?utf-8?B?eHRhU05IQWpDcW9uM2RWTUJEY1ZlTXhuSUN1UFJLVCtoYUltM2RZUW9WSkdK?=
 =?utf-8?B?UEVTY1VVNkdrdWoyMGlQbUVxUG1WdzExZFVzOHgzK0hGRTlyNkRhS3M5SjdX?=
 =?utf-8?B?VHZXemR0SFRtRjkxT3IySm0xdVhRUWVmZEVzRnU4SzlWRUpyenFmLzN5WTA3?=
 =?utf-8?B?Mkp1NCtndzBINkk5MFFNWW96OHhVdjJOUkZxTnVZUjV3QzgxeE55b3hjeTVN?=
 =?utf-8?B?NStXN3JzOHNBWi9FeXNnZDlaN0Yzak5sUHc3OE5veDRiMWlCYnVBcjBtOWZt?=
 =?utf-8?B?R2FFK2x5bmc0SWFRcFdTT2VWQzloMWdzalV6T29ORTlIOCsyY01ueGpXU2hS?=
 =?utf-8?B?ak5lVElDZW5qNUM4RXJBd3JXRXBrcWRjOVVwcjlPK3R2MmM2YVBDckxTam5G?=
 =?utf-8?B?c3o4VmtNTWljMnFTWU4wLzlFOWdjVUZWN0lENXc3YWtMZzdlbXVHTWlHRnM2?=
 =?utf-8?B?OUZQTk5VTUJEcmszTnMybTJQZ2dNNkVYSmFSaTZtR3hxcmpkK0t2VzJzQ0VG?=
 =?utf-8?B?L0taV1J1T2I0MGZzMU5nME9vdVZIWUQ4MThKSXFyL21RMW1XSm9rYUM3UlE1?=
 =?utf-8?B?enZnaVN6UTgzRnZMeVlkajAwQ2pFUTA5aTI3WW91Z09XclZZVHZPam8zWGJS?=
 =?utf-8?B?cjM5dGthZDVKZGhEOWtxTytuamp5UXV6MCt6TXV5SFdsVXAxbkpiSElaaThY?=
 =?utf-8?B?dW11RTV4Z09OUGJMcDVkQlpnR3hPTk5LRHlDR1U0RmozMGlrNVJydjZ3akJj?=
 =?utf-8?B?Zm5xOHZrQkE0WUUzbGVwSkdJVUs1MWs2L1NpdGlpVmVYZDd0SHlQTy9ydFJH?=
 =?utf-8?B?d2RjZDQ4TVRqS0R3cGxxQ0hRWnNMM0ZTbE5TN2dVR3VaZEJKTVJGeGwwU2ZH?=
 =?utf-8?B?dUpKVEJxcUU4b2dkMkZ2aExVNHRabG9CYWs4c3VSUkFjYjhmbXZGUlFBbkpH?=
 =?utf-8?B?WlI1MERHR0lpYlRndUh2d1FMZ2YwS2NOb2pYZE9ZSlpVNTVpOThQV2tEUFk0?=
 =?utf-8?B?UG9BY0RwU0tlUXQ5WThWTVpIOXg2Rnl5THRoclVOWUphZm1qZGhEV2ZROEpD?=
 =?utf-8?B?eFdwTU1KbG9nV3Uyc2tKWmNIRTJ3enY3V3Z0OTY3enROMDdjVzJGdFhQQ2xK?=
 =?utf-8?B?Y05MYjk0Z2JxbXFFUFd3RnQ4NXJJa1RHazJNdXljWVo1cG9USUlKWWpURUNj?=
 =?utf-8?B?dkNoZ2p6OEVRZndCVXVxOGxKK2JLblBsQUxRRC9vc3ZydERiV0Y4Yng5MmVC?=
 =?utf-8?B?Ukd2SllpdkxpOUkrZEV0YzNKNmhvbGVYemdzeDBkV214VFIwemNPWU1vS0Yx?=
 =?utf-8?B?VDVXbjdpdnFmYmlzMmFGVFd1ZSt6bGZTVUF3ODl0cExnRmhaQS9YcW9JTFdy?=
 =?utf-8?B?YXY0U29CV2dkdzh5NWdlZUtsRmhKWnpLNGpONjk0bk5pSVN5SnpWOFgzdGJD?=
 =?utf-8?B?cVVVc2ExNlRaUlI5TTJrWVQvWkFYUm54MHY3S2VkSi9iejB0UGowNFR3dTB0?=
 =?utf-8?B?Y2prQm1TbG1ZRUpUOTEyOUFseXIzbExyQm5RZTlOMGI3RnJRaDNGZEZzenlV?=
 =?utf-8?B?dk1lWXlEdjdJQjlBSDRuakxMNEZyNEIwNStISGtLR09VTGY5NGRjTFNaZ3Zm?=
 =?utf-8?B?S3hiVG1BWHVNNVBSRm84ejRpQkYwY2dKZkpuc1pqN2w4YjBIT0VrMmtTNWkw?=
 =?utf-8?B?ZzRuWXREVTNDcEtETHczT3BkUDA4WGJuQXNhTWJQNU1Ubm82MDk0VS9DRnZ6?=
 =?utf-8?B?cGNDcHZKSWUrRlZqT0hnMFMwMUVTR3lmTndxM2l6SVhoMlp0ZzFWaXhmZEdT?=
 =?utf-8?B?b0Q3Yi9lZ0MyM2FsUHdwcjlEajB0S3E1UjAzZkVzTzZPanB5ZWhKSjQ1VG1Y?=
 =?utf-8?B?a3k2ck03d2QyZGNiQzAydFQxMlBJeWt3TUNEZisyejBuSlpOUU9ZOVZtS2dY?=
 =?utf-8?B?U0VIbmQ5RUt0VHRLMytYdXR4UGxZWnE4YWdDQjBmSXUzdjU5cVpWUWEyd0JR?=
 =?utf-8?B?OHMzaVk0N01VT21rSFZ2cFN5cFBENzlLaGp2eUk4VklQRXBXdjZ4a1hWTWxH?=
 =?utf-8?B?dVV0VTQzU3dCU0QzcllEWUorcnBINUxhQU9NWGNlc3luS2QzeGJOTUl5ZWVv?=
 =?utf-8?Q?kkZ6fRQXfe9ESsWY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F5A6C07A16C7D4D8FAB3D8B10F9878F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	bYHEQhSlv0OOVtoYZ73VEeLbZJKHlS/4cfg+zDjaniwwwIVl8z0/oIJIQ89nYy5MJ7rd8hg+L1e9zNqYTzWKULBmUHSKAEnXlQt0WA1MFydUz0VC+VDG/1ydfA9DHbL+NJZcSsNdeuckWPppJhR4Kj1boaCdzxHOmXKxR0SB1VZ39LB17PhMJZ8/5rK3zCzKNeFNZanfCxTkzRK0W1/KOShust10igx1pUsd0DAuF1rXTbyGWzCaPojbB2RDGk7CY+GiJYMmpbeZzHX+sZpuSz1iUt/BcKOeYcPe/SjrFcTf5NVB8UJxE7JCsmd5HcPuqHLsIInAt/fYLjsj+3Dw4Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xy3xxWiHZhu43BC1fT7P1Rdciols19+ewf9cuhpyXmBKiS/J6rKnLSD9Ih30R1j2oldL/eWfqSHvGKWC+8g+LKcQMSefe6msfb3tRMjdXCMo3Zx3WT3CHpZwjKPcCjwcMGKZl1ddz80m45+Lac0vgxrmUOA0S11XsCNC0glS1x0IIlrvC4kWKvGoJOZ/bWFJbmdZEsP/AhLk4f775Hrpo7QOHov2Dv2BTSUXYTu3VrZ2zVY7drTae9gnmM/cKPuhhlIwB7qnqszWfwBljNpRUWkBuwpdy9JIZIJ56lmxMym1md/YZ20alMBmQtZM2y09d6LwQtFxw8B6XLg27gKQgWgUHyyI5ZXczx/LkPGFnqeU1qUb1CRd1HnDrDP9ffcBxOTyYBH2DsJ11Qtk0Y8nlU2XTZGy62PZMo2FNQC+XBs15esGUw9rQ8Xj84pby2fKGEIO4X7DUjxQOlVRhHb5ANJN3m4dbl2UU6cA7bovOWnrJwUwQrr0hVjFFL5+bAN7qRYwfkZcEEx4bvIeSveBRdo5cxOcgYuwAAykBScqszp+LzIohSHfPdQkj3esIUUSHwAiE20mMc7I5yYQMTb4pvMurYgxq1DGyZWGoj/ASlUqi1rPUTgbA0KrsJWsnpuW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR04MB8300.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c037a804-b081-4264-7f1e-08de83baf103
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 00:20:06.3517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A6m63JiphV1hAUTX0VMfbqHsxss/LiT3LvvEjkezHCcjPFVEefmgt4vFrGdgOLBQEq8vsoNKHTpeLn6CNacZaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8952
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-268356-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lwn.net,wdc.com,davemloft.net,vger.kernel.org,gmail.com,kernel.org,linuxfoundation.org,google.com,redhat.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C4562A23B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCAyMDI2LTAzLTEzIGF0IDE0OjE2ICswMTAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjYtMDMtMDksIDE1OjQ4OjM2ICsxMDAwLCBXaWxmcmVkIE1hbGxhd2Egd3JvdGU6DQo+
ID4gRnJvbTogV2lsZnJlZCBNYWxsYXdhIDx3aWxmcmVkLm1hbGxhd2FAd2RjLmNvbT4NCj4gPiAN
Cj4gPiBDdXJyZW50bHksIGZvciBUTFMgMS4zLCBrdGxzIGRvZXMgbm90IHN1cHBvcnQgcmVjb3Jk
IHplcm8gcGFkZGluZw0KPiA+IFsxXS4NCj4gPiBSZWNvcmQgemVybyBwYWRkaW5nIGlzIHVzZWQg
dG8gYWxsb3cgdGhlIHNlbmRlciB0byBoaWRlIHRoZSBzaXplIG9mDQo+ID4gdGhlDQo+ID4gdHJh
ZmZpYyBwYXR0ZXJucyBmcm9tIGFuIG9ic2VydmVyLiBUTFMgaXMgc3VzY2VwdGlibGUgdG8gYSB2
YXJpZXR5DQo+ID4gb2YgdHJhZmZpYw0KPiA+IGFuYWx5c2lzIGF0dGFja3MgYmFzZWQgb24gb2Jz
ZXJ2aW5nIHRoZSBsZW5ndGggYW5kIHRpbWluZyBvZg0KPiA+IGVuY3J5cHRlZA0KPiA+IHBhY2tl
dHMgWzJdLiBVcGNvbWluZyBXZXN0ZXJuIERpZ2l0YWwgTlZNZS1UQ1AgaGFyZHdhcmUgY29udHJv
bGxlcnMNCj4gPiBpbXBsZW1lbnQgVExTIDEuMy4gV2hpY2ggZnJvbSBhIHNlY3VyaXR5IHBlcnNw
ZWN0aXZlLCBjYW4gYmVuZWZpdA0KPiA+IGZyb20gaGF2aW5nDQo+ID4gcmVjb3JkIHplcm8gcGFk
ZGluZyBlbmFibGVkIHRvIG1pdGlnYXRlIGFnYWluc3QgdHJhZmZpYyBhbmFseXNpcw0KPiA+IGF0
dGFja3MgWzJdLg0KPiA+IA0KPiA+IFRodXMsIGZvciBUWCwgYWRkIHN1cHBvcnQgdG8gYXBwZW5k
aW5nIGEgcmFuZG9taXplZCBudW1iZXIgb2YgemVybw0KPiA+IHBhZGRpbmcNCj4gPiBieXRlcyB0
byBlbmQtb2YtcmVjb3JkIChFT1IpIHJlY29yZHMgdGhhdCBhcmUgbm90IGZ1bGwuIFRoZSBudW1i
ZXINCj4gPiBvZiB6ZXJvDQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgdGhlIHJpZ2h0IGJl
aGF2aW9yLiBJIGV4cGVjdCB0aGF0IGEgdXNlciB0aGF0DQo+IGVuYWJsZXMgemVyby1wYWRkaW5n
IHdvdWxkIHdhbnQgX2V2ZXJ5XyByZWNvcmQgdGhleSBzZW5kIHRvIGJlDQo+IHBhZGRlZCwNCj4g
YW5kIHRoZWlyIHBheWxvYWQgaXMgZ29pbmcgdG8gYmUgc3BsaXQgaW50byBob3dldmVyIG1hbnkg
cmVjb3JkcyB0aGF0DQo+IHJlcXVpcmVzLiBUaGlzIGNvdWxkIG1lYW4gdGhhdCBkYXRhIHRoYXQg
d291bGQganVzdCBmaXQgaW4gYSByZWNvcmQNCj4gd2lsbCBnZXQgc3BsaXQgaW50byBvbmUgZnVs
bCArIG9uZSB2ZXJ5IHNtYWxsIHJlY29yZC4NCj4gDQo+IEFzIGl0IGlzLCBpZiBJIHJlcGVhdGVk
bHkgY2FsbCBzZW5kIHdpdGggTVNHX01PUkUgdG8gbGV0IGt0bHMgY2h1bmsNCj4gdGhpcyBmb3Ig
bWUsIHplcm8tcGFkZGluZyBoYXMgbm8gZWZmZWN0LiBUaGF0IGRvZXNuJ3Qgc2VlbSByaWdodC4N
Cj4gDQo+IERvZXMgdGhhdCBtYWtlIHNlbnNlPw0KPiANCg0KaG1tIGl0IGRvZXMuLi4gYnV0IGFs
c28sIEkgYW0gbm90IHN1cmUgaWYgY2h1bmtpbmcgcmVjb3JkcyBzb2xlbHkgdG8NCmludHJvZHVj
ZSB6ZXJvIHBhZGRpbmcgaXMgYSBnb29kIGlkZWEgZWl0aGVyPyBpcyB0aGUgYWRkZWQgb3Zlcmhl
YWQNCndvcnRoIGl0PyBGb3IgZXhhbXBsZSwgdGhlIE5WTWUgVENQL1RMUyB1c2VjYXNlLCBJIHRo
aW5rIHRoaXMgd291bGQNCnNsb3cgdGhpbmdzIGRvd24gbm90aWNlYWJseS4gVGhlIGN1cnJlbnQg
YXBwcm9hY2ggaXMgbWVhbnQgdG8gYmUgYQ0KYmFsYW5jZSBiZXR3ZWVuIHNvbWUgb2YgdGhlIHNl
Y3VyaXR5IGJlbmVmaXRzIGFuZCBwZXJmb3JtYW5jZS4NCg0KQnV0IGFzIHlvdSBtZW50aW9uZWQs
IHdlIGNhbiBpbnRyb2R1Y2UgYSBmaXhlZCBzaXplIG9wdGlvbiwgc3VjaCB0aGF0DQphbGwgb3V0
Z29pbmcgcmVjb3JkcyBhcmUgcGFkZGVkIHRvIHRoZSBtYXggcmVjb3JkIHNpemUuIFdoaWNoIHNo
b3VsZA0KYWRkcmVzcyBzZWN1cml0eSBjb25jZXJuIHRoZSBhYm92ZSAoPykgLi4uIGF0IHRoZSBj
b3N0IG9mIHBlcmZvcm1hbmNlLA0KdGhpcyBwcm92aWRlcyBhIHN0cm9uZ2VyIHBhZGRpbmcgcG9s
aWN5LCBhbmQgd291bGQga2VlcCB0aGUgbG9naWMgcXVpdGUNCnNpbXBsZT8NCg0KRm9yIGNvbnRl
eHQsIHRlc3Rpbmcgd2l0aCBOVk1lIFRDUCBUTFMgd2Ugc2F3IGEgfjUwJSByZWR1Y3Rpb24gaW4N
CnBlcmZvcm1hbmNlICg0SyBXcml0ZSBJT1BzKSB3aGVuIHBhZGRpbmcgYWxsIG91dGdvaW5nIHJl
Y29yZHMgdG8gdGhlDQptYXhpbXVtIHJlY29yZCBzaXplIGxpbWl0LiANCg0KPiA+IHBhZGRpbmcg
Ynl0ZXMgdG8gYXBwZW5kIGlzIGRldGVybWluZWQgYnkgdGhlIHJlbWFpbmluZyByZWNvcmQgcm9v
bQ0KPiA+IGFuZCB0aGUNCj4gPiB1c2VyIHNwZWNpZmllZCB1cHBlciBib3VuZCAobWluaW11bSBv
ZiB0aGUgdHdvKS4gVGhhdCBpcw0KPiA+IHJhbmQoWzAsIG1pbihyZWNvcmRfcm9vbSwgdXBwZXJf
Ym91bmQpXSkuDQo+ID4gDQo+ID4gRm9yIFRMUyAxLjMsIHplcm8gcGFkZGluZyBpcyBhZGRlZCBh
ZnRlciB0aGUgY29udGVudCB0eXBlIGJ5dGUsIGFzDQo+ID4gc3VjaCwNCj4gPiBpZiB0aGUgcmVj
b3JkIGluIGNvbnRleHQgbWVldHMgdGhlIGFib3ZlIGNvbmRpdGlvbnMgZm9yIHplcm8NCj4gPiBw
YWRkaW5nLA0KPiA+IGF0dGFjaCBhIHplcm8gcGFkZGluZyBidWZmZXIgdG8gdGhlIGNvbnRlbnQg
dHlwZSBieXRlIGJlZm9yZSBhDQo+ID4gcmVjb3JkIGlzDQo+ID4gZW5jcnlwdGVkLiBUaGUgcGFk
ZGluZyBidWZmZXIgaXMgZnJlZWQgd2hlbiB0aGUgcmVjb3JkIGlzIGZyZWVkLg0KPiA+IA0KPiA+
IEJ5IGRlZmF1bHQsIHJlY29yZCB6ZXJvIHBhZGRpbmcgaXMgZGlzYWJsZWQsIGFuZCB1c2Vyc3Bh
Y2UgbWF5DQo+ID4gZW5hYmxlIGl0DQo+ID4gYnkgdXNpbmcgdGhlIHNldHNvY2tvcHQgVExTX1RY
X1JBTkRPTV9QQUQgb3B0aW9uLg0KPiA+IA0KPiA+IFsxXSBodHRwczovL2RhdGF0cmFja2VyLmll
dGYub3JnL2RvYy9odG1sL3JmYzg0NDYjc2VjdGlvbi01LjRsDQo+IA0KPiBuaXQ6IHRoZXJlJ3Mg
YSBzdHJheSAnbCcgYXQgdGhlIGVuZCBvZiB0aGF0IGxpbmsgKGFuZCBvdGhlcg0KPiByZWZlcmVu
Y2VzDQo+IHRvIHRoYXQgc2VjdGlvbiBpbiB5b3VyIGNvbW1pdCBtZXNzYWdlcyB3aXRoaW4gdGhl
IHNlcmllcykNCj4gDQoNCm9vcHMhIG1pc3NlZCB0aGF0Li4uIHRoYW5rcyENCg0KPiANCj4gPiBA
QCAtMTAzMyw2ICsxMDU1LDggQEAgc3RhdGljIGludCB0bHNfc3dfc2VuZG1zZ19sb2NrZWQoc3Ry
dWN0IHNvY2sNCj4gPiAqc2ssIHN0cnVjdCBtc2doZHIgKm1zZywNCj4gPiDCoAl1bnNpZ25lZCBj
aGFyIHJlY29yZF90eXBlID0gVExTX1JFQ09SRF9UWVBFX0RBVEE7DQo+ID4gwqAJYm9vbCBpc19r
dmVjID0gaW92X2l0ZXJfaXNfa3ZlYygmbXNnLT5tc2dfaXRlcik7DQo+ID4gwqAJYm9vbCBlb3Ig
PSAhKG1zZy0+bXNnX2ZsYWdzICYgTVNHX01PUkUpOw0KPiA+ICsJYm9vbCB0bHNfMTMgPSAocHJv
dC0+dmVyc2lvbiA9PSBUTFNfMV8zX1ZFUlNJT04pOw0KPiA+ICsJYm9vbCByZWNfemVyb19wYWQg
PSBlb3IgJiYgdGxzXzEzICYmIHRsc19jdHgtDQo+ID4gPnR4X3JlY29yZF96ZXJvX3BhZDsNCj4g
DQo+IFRodXMgaGVyZSwgcmVjX3plcm9fcGFkIHdvdWxkIHNpbXBseSBiZSB0bHNfY3R4LT50eF9y
ZWNvcmRfemVyb19wYWQNCj4gKHRoZSB0bHNfMTMgY2hlY2sgc2hvdWxkIGJlIHJlZHVuZGFudCBJ
IHRoaW5rPykuDQoNCkFoIHllcywgaXQgaXMgY2hlY2tlZCBpbiB0aGUgc2V0c29ja29wdCgpIQ0K
DQoNCldpbGZyZWQNCg==

