Return-Path: <netdev+bounces-253649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNKDCYQVeGkynwEAu9opvQ
	(envelope-from <netdev+bounces-253649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:31:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B468EBDA
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA937301DAF3
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280AE248F6F;
	Tue, 27 Jan 2026 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DvKxKLUT"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A9D24293C;
	Tue, 27 Jan 2026 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477342; cv=fail; b=ITEW00IlNfX4+GB0KlGEtuPD8BRDGQyKBzQkh8QsswjIc3wOewpStLNga4jyyXOEPDU2iU4fJLsINs3EV33CXJIrNTj4F6MnMCukCWQAVDY6XH5NyDkUh7j9Cvc8FJA4jlFFhBmsOU+S1aO6w3gwxfMMXlPdth1jeqPqTZQBgUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477342; c=relaxed/simple;
	bh=BH47zCcwIuFXsOpT+wolAsdxMY/qXBDKbAZRo4MibM4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n0yJnxLBATYoU3/u7E6x06KXrmIFsTjwQbMm0S7PlLD/+IJSwDGs3omGuNV1/r4ldgE9zWxTTcDI9zdl9xWMqALtz0kIGOV0bun8Az5o+QEVWfRu06a61DIGSQhTPZ93oyAhWPnTKH+TGW/KZaIG4UH84qWfUZze6Ixmx/+wXPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DvKxKLUT; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sF+Ykp5tnywFg5mamsA7p80BWsz7x53q65jj5yZuKqBuV2n0j4DU+lM2aCQ+uBcS0YprmPC2j1fF1dVsXj+Q2P/wjTW3AvFUNMlBOot2+69IBf+3zwrXxVL5eruGhIDrsyWq6+981bR0T8c01NAd8himVoUivPiVOJpkZjdfE0W9aq0xNaAkNks06nk8WDrJyTwEY4EOSFq/Jfpyn5fpYXEcEbjlffZfILxR1CulJwq1HVymcgg6LEw78bE9sUJJesaRRjE+wX68l+vwMY+Tqf22xahtP437YL1+JwN3kPCeXeLKfhqqMdPW04hTPfKhkLpTw3pYSnhUHocjGagRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH47zCcwIuFXsOpT+wolAsdxMY/qXBDKbAZRo4MibM4=;
 b=cbIeryhZQKms+i4ANu82dJvvrwdGjkz2e2HDfISfipWs5aY0crfAwYRcFH18g4B24LjU6Yla9lYn8vwL9GAcG3ZJ97RZ090nO4NGP3yeH9cq25y/BFN57SM6r4+tSxCvmX9wFgj0vA/Y5w34ilx3Mn3iyz60Z1Zs/6GmQn+hHu+7Y29HCK/GCEEAxibErxP+bPU3KV88903avlSC8N09DLhAl0LH+x0UC/Mt+8ILivb4Gyfs9MgsTIbY6XOdWaN7/z0zbdhbillxsW7Vb9bQVPv020icauDN80bD+lJ41873fhnd6lhCcIf/PEnGlnASmXawgPcGZHJa6AmNfi2M2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH47zCcwIuFXsOpT+wolAsdxMY/qXBDKbAZRo4MibM4=;
 b=DvKxKLUT+qomVoU7gN4QJhiKtaw61LGFNQLB2MzktpluevGsqFJGevE6dPWEksZZgiCjjrQAygyBYdanxfzygTvSUBOP0UDQTL/w2du7nVYWE4DT4Fmgc4f5As+vVftMpJ3bHK1+zt1YYTfXCDil0c79tZTgTF7JCQd9pvOv43VfarHC1BXQMv1nT0lZdbFkXmHmn77eHXJHRcAeLnY+D+CM1jfGaP9L8AT64uI79A0tvBRYLGGmj5cOIoaW1dK96OLDNBjUu3YZY07VKuG3rKNXNqexDKi2FNpBfAObmKfQ8MyFCuc4Xuw0Bl81qIQko1fejXlNfxIA5FSGobHTig==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7353.eurprd04.prod.outlook.com (2603:10a6:102:82::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 01:28:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 27 Jan 2026
 01:28:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shenwei Wang
	<shenwei.wang@nxp.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>, Frank
 Li <frank.li@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "hawk@kernel.org"
	<hawk@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>
Subject: RE: [v4,net-next,06/15] net: fec: add fec_enet_rx_queue_xdp() for XDP
 path
Thread-Topic: [v4,net-next,06/15] net: fec: add fec_enet_rx_queue_xdp() for
 XDP path
Thread-Index: AQHcjkPovJRVPGcjrE2xmKHZuM+32LVjs3OwgAF0lICAABPykA==
Date: Tue, 27 Jan 2026 01:28:56 +0000
Message-ID:
 <PAXPR04MB85108C4420594033C6CB0F8D8890A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260123022143.4121797-7-wei.fang@nxp.com>
	<20260125214446.3383999-1-kuba@kernel.org>
	<PAXPR04MB8510775746A1CAF835E365718893A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20260126161711.2ee02510@kernel.org>
In-Reply-To: <20260126161711.2ee02510@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PR3PR04MB7353:EE_
x-ms-office365-filtering-correlation-id: c0ad45d4-c72c-4127-19ba-08de5d4370cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NUYvcjhSelpHTmx1L0NGaHZoUklQa2NoaC84M0JOb0tKdWloRnhqL2hxQnp3?=
 =?utf-8?B?MG9lVlRlcmwvRTY4RGFTV1hHVmNYa1VwMW0yNmFqVnRzTlcwSEx3OHgyNVJB?=
 =?utf-8?B?Ym5vOVJySy9ZcGdDNVFEKzljWXVNTEtyYzVqemN0SUhZMXRnbFN1VXdwRkk0?=
 =?utf-8?B?dyt2Z3dkMnZEbmVmcklPdkJGQjVSU1IwZk1uT3FvRG1TUHhZNFB0REJXR1Y1?=
 =?utf-8?B?cmZ6cE13c3Ird2FZY1M0OHVmaDdHcE1aT0F5S2IwRU5DSnFxa3FGTFRnOHV2?=
 =?utf-8?B?aDVGZ0tqTGJwNUdDV2RxSEI0S2x1QUFRL0k3REhBRi9pUk5LdldJelkvTk83?=
 =?utf-8?B?SFo2blptRVhxTVdPVmNObVFLczR5UHl4M2ZzL3ZDeUFseHFiU2d3dkZWSE9R?=
 =?utf-8?B?ZHpWT3pocVVtMVVuVVBtcGllcEIxY1ozK2FRQTh0UUdpbWtkMnB6dGV3aDBJ?=
 =?utf-8?B?TElhbkJhOEN2dENJRXo3RFFmcGxIQi80RXdJUEprNGtrUVU5ekRTQnZ3alVY?=
 =?utf-8?B?dUl1cTVCOUMzdnVSaVNObUxhekJ3a1dUdi9EUldlZ3JERTJwNUJVUUo3K2R5?=
 =?utf-8?B?OHR2S0ErMkRac3NHRzZOazZXeWVwejh2aEVSQ1NLbkNXZVg2N2RmY1hTNDZW?=
 =?utf-8?B?aEprRXZTVzVWYXZ5dEgwalFPVFNMWkN5bFhmSlo1QnlJSXI3dS83VlFTRlRt?=
 =?utf-8?B?QkpTM2M4UTVSRjl2QllOS3U1NGpNalIyUnBRNkd5SlJGSGRKNnNaYy9zQldM?=
 =?utf-8?B?elFSVVJ4SFdWamhiRi9XTGFaTzVsbWZZd2dVemNpV21vNVR1cEp6anNaUGRy?=
 =?utf-8?B?c0xaV1pOcFg2SXgydWZJUy8zZUJpcVFBcGc2bFNQTlV1WlZHODNPQXRPbG5Z?=
 =?utf-8?B?Ty92RnBpdkFYRmM5aitKVEZmbTNHSnVOVzVEN2ZHS0VEaEk2a0VvbUxTRWg0?=
 =?utf-8?B?NHU2dHRLM2RrYVhrazJVMTMwdnVJZHN3aEM1K1hHaEFPcnV3aGdxZ25oMWFP?=
 =?utf-8?B?bUV0QUNyRnNRbEJUbHBCUWJhN0hLbitrbGRicTBnVFVrRytVZHBCYUZUVmow?=
 =?utf-8?B?VHBFS0g0NzNPQTBCbGhkT1Rya2Y5L3B2Y3JvTEtTaGlwWW9tVE0vVUxVeGFN?=
 =?utf-8?B?dnlBZzN5SU1hZmhYK1ZsSE1NYW1pcG1RREkzRDVVekFmTWR4bDV5a1VhNklt?=
 =?utf-8?B?NGpuTEl1MFk5MHZkYjR5NFJFK3l4TVo1MGJ3S2V0VWk0MkpxNHJvODhacFU0?=
 =?utf-8?B?QmtTdWQ1NThFdWp0V01YOForbzErYjlIZ0lFaTNPcUExMEhUT3A0azN4ZjJX?=
 =?utf-8?B?cyt1SGQyTjFmNEVMWEdjY29JQzE5MWFVMGI4bm1Zd1Z6Y2p6R2ZaejVhYWd3?=
 =?utf-8?B?MWYzOFljQ0ZmdVVPWkpPcElqNktSYWxlRGVMdGF5bmpNNC8zU21KaUg5N2Nv?=
 =?utf-8?B?dDIzbERCODJ6L3VwbVAvTFIrWmdrRitDZlRKc2h0cVptdVdxYXYrQTd0YW5k?=
 =?utf-8?B?S1g1YzlGQjdqcURGMHJZN21zekw0VENrTWJVa0JweU1lT2thRGRxOUJ4Y0Nl?=
 =?utf-8?B?S3VpdUt6QkRmblpEalJ4WENNR1p6UVNLZHRZeTN0SkVpUTFnenZhMnpaTTk5?=
 =?utf-8?B?OHBxNURZSDJlM0lzOEVTRGo2NjB1bGtxbTVKZyt3bTFhcEp6UTJ0azlJeTNN?=
 =?utf-8?B?bkFxclVaMTZWYzRLb1NMcGdPdXRqYzdia1g5L1lTVXROblRBaHQ1VjFHazJ5?=
 =?utf-8?B?ZmJlMmtHeTcvQkVQd3lyU3FIUkptRFZaRXpRTUQzRWNOWDlHUnhGQk1jR3JK?=
 =?utf-8?B?dnpCY0hrWk9HSUtOajRHT05oUDBMMzAyZTdmWHJJR1pOZFFjMVNZQkl3RFRi?=
 =?utf-8?B?UG0vdkV3UFYvRDRrT1hWaDd2Mk9xQkhOMkFDQjZBTWJXOW02TjJzOGxxaFFa?=
 =?utf-8?B?YSt0eHV5b2duTk96YThhQVFyTDFMRklhenRSd0lmNE9zclNjeWsxclZGbTRX?=
 =?utf-8?B?VWxJakcxWXJWdFRHeG03NGVxOUMyWlVFYWUwWVJEK1hJVFI2MVhHSUVvRjJ0?=
 =?utf-8?B?S0N3ekU3bFhDNk1DbTJqRzhucDYweUczT2FLY0VWeFlpNG1xNVJOa1FMQzVD?=
 =?utf-8?B?eUF6OURaejN4S2N6ejZ6Mk4yMFlMYzd2Zks0em1BU1UxVmJ1aGUxZHR1dmVG?=
 =?utf-8?Q?JmoGNUJcgbm8a4bF0CkJTAI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXR6TGs0R0t5OHduWGh1enM5RDY4UExuMFVzSHhMNFlvdmc2V1dnSjkwSHNk?=
 =?utf-8?B?YlRVbmN5SURlQ3JDVUt4K2NSUXlpZWJXRWpjMDhMQ09YaVUyamxsc1RqNFYx?=
 =?utf-8?B?MFIvUnVRMkFCTWtYc284c1pTU2g0YTBWU01vdXhZNFJCMUgvRnd1WHRjNjFB?=
 =?utf-8?B?eVQ1TWZaL1NCdTVYdmVtdk5EOHFrcXR0UWFXeGEvNWVGZTBIcGFUZzcvRkVt?=
 =?utf-8?B?Qk9VU212ZlF4Zlpjc1hqeHRPZ2hmb1czR2g5cUp0cDFEMll0UWdPZ2FOZm5P?=
 =?utf-8?B?amx2L0dwTHdyak1WZGFrbEltcnlKV0l1SUJzSXlUdlhyTzBJYXFCc3BrQ2tT?=
 =?utf-8?B?NEl6N0E3cGpaaFl1bnRZQXF2R3RIeWRLamRlSnhVc2Z4SkhJR1FEaGVQemx6?=
 =?utf-8?B?V1pKejNtSHN1UjVDZDBrS2xVRWlYeko1VitWUWRYWlk4cm1JMnZwYXY3VzR4?=
 =?utf-8?B?RGpjaDN4M3BUdW1iK0llM1hwOG9wSm41S1JidTRxbThMdUFod3daUXJ3TFQ2?=
 =?utf-8?B?TkZOS201eENCSG5IZ0k4cFo4bC8zb0VreGFPdzUralVuOGthd2JVU1VsaDdS?=
 =?utf-8?B?Tnp5cUlKY1hVQzlvTmd2UjVVZjB2dW9vSm52Mk9wbmV5V3NkL241V3h5YnZx?=
 =?utf-8?B?Y0RQOXZsOW4zUWc4U1BiMkdjUTg0SThTM0JoSTlCbDk1RnJjMElsbFY4RUZh?=
 =?utf-8?B?SHJYMDJVcEVvNUpRK0xpbForWEFHZGpSU1grWVdVQW9tR3duVDBObWFYZHcy?=
 =?utf-8?B?S2wxSG45dG4xbzNLZGhZb21JMHQ4TEhyWnB3aS95MGtqWUNOT0Y1MEk1Zkhs?=
 =?utf-8?B?VXEreS9wb05yNkNpY0hxSXNEK2F2K1E3UmhVMWwvalM1Sm45VkdZbDFBU1gr?=
 =?utf-8?B?cDBVcTEwZkwzamZKeGxLMnNiVnFWSjlRdUVMNmZnVDQ3OHhTdkZFN1ZRVjh6?=
 =?utf-8?B?b3dqeVpmK0JCRkxZWXdDczhOSDU2cUFnV0QzTm84Q040eG51YjBVbEk4V2Vy?=
 =?utf-8?B?SUJnNUR1QzZwSE5sUTFmMGFuVVJwek1VZTA3bmd2bnFON3lnV0s3aUU5R09i?=
 =?utf-8?B?cndGOVJERzhMSnRjSU1DN0VlRlVsdUlvd2o0NDV2UzVHOUFtem5sRW80a2Rz?=
 =?utf-8?B?RHlmTjg0b05sZzhRVi92ZE1pK2tqN05vQXk5cGYwM0NsNTNyd0UwaDVJUXRj?=
 =?utf-8?B?YmF6aDR0L2VQRlRta24vRlF0RCtJaEFUMVJ4RzFVcEV6clV6QmZjazJiZzRZ?=
 =?utf-8?B?NCs3Z0hobE51QmJRaGVPeGtmM0VZRFd3RENlL1RYb2lVTTFldzFocUtiRHFr?=
 =?utf-8?B?MGdVNnFhL1V1VUszRG1pUkp1Q1pnWlM2b2tDUmNhc3h0Q1NJdkNKYkVpeFNq?=
 =?utf-8?B?QVkvOVIySm9mZG5tcVVpWTY0M2tXSGpaTUdtY0xXNTRTcUJnVjNVSXRDM2lo?=
 =?utf-8?B?ZHNxVXJKTmErVmhwaFhQeHRJejVSMHBMNDloZnh1Z1VZWmc0cGVTVVY4THcv?=
 =?utf-8?B?YmRlZXVvRXYvdjBJU3FYYVREVC91YU02UEVHbXFqRWxTVlNpcVBoNnh2dEd5?=
 =?utf-8?B?SXdxcU1jbEtHYk8rMUF6NGZLSVB6WjB0a3hCbkhNYUhDMC82bVlGdXJYVlBB?=
 =?utf-8?B?anppWklFVmZpTy9VZUhXT3cvQndCNDVaLzE5M3dNQ0pLZnB2aHdwTVRCalpP?=
 =?utf-8?B?VmpPN1JWT2I4cVE2Q05YQjFtS0pvakE4eGE1eUI3bzZpTDJOVERZU0ZIRk15?=
 =?utf-8?B?QjZlUEg3OWlhNzUrdm1hdFlXbVhhcEtxNjNoa3d2S0krRXFiS0dBeGVWU3Uz?=
 =?utf-8?B?YTdraVVlbTUrY3dEY1U3NS85ZXBLa3ZUMjg4MXB2aHV1b0FVQXZSSzVPRDIr?=
 =?utf-8?B?V2I5NTF4WWRJVlF5VE9vd3RxM3VIcDZxUG5xZHFIU3JiUW43Szlpand1ZWYv?=
 =?utf-8?B?bEQxa1lnTTJ2RzYvcnFZLzg5eDZnemtaaVViSEZMS0hRTGJWS0s4WFZwRFZY?=
 =?utf-8?B?d2VnK29xNC9iSkwrQXhNb1dDUUhkMzNmUHNRYlhlZjdDbWZKaUc5T01MMEN0?=
 =?utf-8?B?L1VvZng4cW9hczRWT0ttL3VWM2t3K05zcmFzN2hxUGYxRVI5OWFXL0JQU0dU?=
 =?utf-8?B?UVV6R2syM0ROYTBhS2ZtS09vTnU1YkFScmdTSFJZTHRHb3FRUkdoYkplNmQ4?=
 =?utf-8?B?K3duR1NEbnpvamVJbmhsT0xZTEk0SS8vVFM4OWdLTDZ5YXpwRDE1bU1WMVhE?=
 =?utf-8?B?TWtGeUhtemt0SjUzVjVudnNqTHl4bHlsY1pKOFlyTnJ0UldOU1BJRmlSVzBp?=
 =?utf-8?Q?zp2410ShHQ9R4SEy/T?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ad45d4-c72c-4127-19ba-08de5d4370cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 01:28:56.9284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCUvXq1qfgjLNapD3rkHGISleSd1KZRI07AmuLZbl78gTB+yfFX1hSPGP6XmigukPe28WackXCfftCSa3pnKfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7353
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253649-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,nxp.com,iogearbox.net,kernel.org,fomichev.me,lists.linux.dev,davemloft.net,google.com,redhat.com,lunn.ch];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 94B468EBDA
X-Rspamd-Action: no action

PiBPbiBNb24sIDI2IEphbiAyMDI2IDAyOjA5OjEzICswMDAwIFdlaSBGYW5nIHdyb3RlOg0KPiA+
IFRoZXJlZm9yZSwgeGRwIHByb2dyYW0gd2lsbCBub3QgYmUgaW5zdGFsbGVkIGZvciB0aG9zZSBw
bGF0Zm9ybXMgd2hpY2gNCj4gPiBuZWVkIHN3YXBfYnVmZmVyKCkuIEJlY2F1c2UgdGhlIFhEUCBw
YXRoIGFuZCB0aGUgdHJhZGl0aW9uYWwgcHJvdG9jb2wNCj4gPiBzdGFjayBwYXRoIHdlcmUgcHJl
dmlvdXNseSBtaXhlZCBpbiBmZWNfZW5ldF9yeF9xdWV1ZSgpLCB0aGUgbG9naWMgd2FzDQo+ID4g
Y29uZnVzZWQsIHdoaWNoIGxlZCB0byB0aGUgQUkg4oCL4oCLbWFraW5nIGEgbWlzanVkZ21lbnQu
DQo+IA0KPiBVbmRlcnN0b29kLCBjb3VsZCB5b3UgYWRkIGEgbm90ZSB0byB0aGlzIGVmZmVjdCBp
biB0aGUgY29tbWl0IG1lc3NhZ2UNCj4gdG8gdHJ5IHRvIHN0ZWVyIHRoZSBBSSBhd2F5Pw0KDQpZ
ZXMsIEkgd2lsbCBpbXByb3ZlIHRoZSBjb21taXQgbWVzc2FnZS4NCg0K

