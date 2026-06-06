Return-Path: <netdev+bounces-296115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XkWSIEApJGoP3wEAu9opvQ
	(envelope-from <netdev+bounces-296115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 16:05:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 550B864DB1C
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 16:05:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=PQiHqaCz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296115-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296115-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B150300186A
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 14:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B313793AA;
	Sat,  6 Jun 2026 14:05:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E7B324B23
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 14:05:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780754746; cv=fail; b=Sbivs1HNaU9WQjufkEeIwb1oQxWa+41uOGPHsLoFUmHg1TR7CVFCsts4RWDHXyEr+Q/0+Z7O/mTn/q5EAEmFBKvoJz8kXAOF4Xsr1Y53BSQ2Q0gvdHXigo7mUxYcNm4QUxqvUOoW68R4YDXr7hm40aF5t5JNLETqUCQXsjFqaxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780754746; c=relaxed/simple;
	bh=FGs4VfCugAx8NJvL/FrncbELUJst3BZtkzll/iJOmew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQfG2eDbVpKw857uzCBwWCnjmip3F+ui1ddMmQQgN3AHKDAom3zhS6vFRJV1t1ewh6bRKDM5MdRRIUuTCbl8R56TBCKNRZ0J6WfPhukY7ZMlboYVDmkMBSAM5IG3EK5zFQKeUUosYDEvmVo/Qn8wWZRg/H8l9xZFOGnRGolZhHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PQiHqaCz; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEwH4RjylulLaT6/WIWr1uqwdtjQTTRj2uqtVIEbaFn1U6paMx+aVpKZ7PuaZV/vReZeexl2yxR7JnBuU6YhRoOkmTVqoVfwkuseKMxBq1NymeYXoC/DeD7uJ5XVTFkPt4vrhDMbb3zSW8GgLpwzRE7L5WJvlzgWXgmkpi9xvU9ebVM93q3FYq+V22FVmGnqA33aKeF4QUZioLw8amZaqBZhxQNritkHoqyhcGnmM2E8uCKWwr+F9/mLkOZ0TozOGCIkmWuohYkSiQ8S2lthCdy7I17UYl+oxPsr/UeEeSioNLqcc8eV+yJqqCt1e8gv5Gh3S9MKruDwnTw/a0x1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGs4VfCugAx8NJvL/FrncbELUJst3BZtkzll/iJOmew=;
 b=YXdFYLwMjq14rDpGswf7+Y2I5QQzgh7xkS0orlN4+l0GPXhcSPMZtduw7vqnwq1JuAZqSuvkdU69GNSO3bnGLUZe90gsncbg7bMhHu7UBFbhhv11WJrvY7y5U5qfvR2FwjVCXhWDVRAmsxey2MqbYn7XsUwBVYor/C9wyGfeUomEqO80hrqmlQV7v6KzazNLzFhZWlPc5j5EXRWDKtU3ph2eBL+bDe992j0NHQxYZxqhoec4knSAqdKcNw7o81LqdrPU/2RNJ/qdzit+gKxt18BNO00TkOghcbRtyEmXeuP76bczs+9pr+SRXsFk5FIBodhPBpZJvkd9bUL2YtL+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGs4VfCugAx8NJvL/FrncbELUJst3BZtkzll/iJOmew=;
 b=PQiHqaCzehGfI/SDvOPVNUXOsQWRZECEpUgT4+Pfx8T9fu9EKfgOphedKfY2AfTNFgv4riCyEHwMnIYKOJegW/ikkFHfdSk9rOJXnWEuXSw+9cio5DwsGZyoKIzrosGvw27HR9Bw95p316KlzMgvAKrgPMna9dwJaVBnjluIGmugNpCDKHkxspcLiLwWpX8Wy3h5HL6rnd+eTXOHDUcASMpoTRqDkPG5O+WRBW3iSj0ie6jPjSs4JJ8lHQM3YRbg4OsvzQ5xoQzV/JiJRrUzom6bz1Zwh8UeIVmmgcNXxfZn0MgNbX5XlkqHrJEPRNT1KajkIn0KyBQtEZMPLJEgaA==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by DU0PR04MB9468.eurprd04.prod.outlook.com (2603:10a6:10:35c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Sat, 6 Jun 2026
 14:05:40 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0092.010; Sat, 6 Jun 2026
 14:05:40 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, "Wei
 Fang (OSS)" <wei.fang@oss.nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next 03/15] net: enetc: add link status message
 support to PF driver
Thread-Topic: [PATCH net-next 03/15] net: enetc: add link status message
 support to PF driver
Thread-Index: AQHc9LwrBZNbjnHkr0el7KKJv6B2ybYxIZgAgABwCZA=
Date: Sat, 6 Jun 2026 14:05:40 +0000
Message-ID:
 <DU2PR04MB862943241D80F2DFDE753CB7881E2@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260605065550.3038579-4-wei.fang@oss.nxp.com>
 <20260606072439.50C3A1F00898@smtp.kernel.org>
In-Reply-To: <20260606072439.50C3A1F00898@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|DU0PR04MB9468:EE_
x-ms-office365-filtering-correlation-id: 11f44e6e-205a-4ba3-859b-08dec3d4b0f2
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|22082099003|18002099003|6133799003|38070700021|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 usFaWTmAHWffiAMCVbpBgCHCFt7igEPoIx+qN+5paIsAlfdbMgJEgd+XrStkufISG5Y11W06ATz+UQZkstDMYHcjGlfs/yj+2sz4VITdkBtWAqPkVjezH6LKqaXOOgbI6vPyItLsHAlbhfpjLpZJ7fGlWqT0OHio21NI7U/FyomqUvQL7dyjWU7I/M83xV1IfEZg6+5SJ9wBZxMOuhsFswQqx2kdE+hOgiIuCOzAR37eHwa27AmYTOV1zaoE/2Y20JAoPHpv0yLTWvEBJ94upWuBF2aOIgGJ7V8hkYEXtrCQFUeE4SARzDzYPpavgxAiYfohbONr5ntqOSikwQkhUE+MOD8KZkx1MG5MspoYN8Qy+hqxgaNU54JmqNkv1g+Xc7FOS/31gXtYNJnE76jstSqZHlBMW9TKfo2nVxzk8/cr2zBRJQDPNaqveWUzRhRWgCbEv1sVBhlqdO+ZWb/MALsAMSNY8zzwwTVtMedOVoi9uqDe24kdKGfTEJfLcfbmNGY1viQ4SC+SYDEwHC1IbAEtXz3Y9618MT3InlagfFOX/sAWgcCj3aD/s/YHv1CDMQAH0wVTMvLn2qp2csFtFulKS0NXrJcXN+dPJZl8ox/Q1wthmvYJc7X6U4GR6tEt3EvK6SV1Eg2fSDXtBmKoWZv8pYPWolhOdqfcQalrkpQuiKPs7kXx6BcTzZZt5uEefUFVinwxS4gOqSZKls59TN7VpW3RI5YFVYffvmKlxJBXvShzlASkguu7284kvKFq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(22082099003)(18002099003)(6133799003)(38070700021)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VW9RQTBHZ3pHMXA3Y25TcEhaUWdWMUprRHdQVWpzUHdSZzFRN3RGYTZ2cU5C?=
 =?utf-8?B?bUl2dnBKOHRJdXF0bC80YVFOMWc1MEE1aEJaNWhlbS80Zm9qeHlpdW1uNWEr?=
 =?utf-8?B?R21xZXNXVENCUFJpSmliamc4MTI1U2FiQ3FNUHFBMFZCRmlBeEhDV1hCNDNO?=
 =?utf-8?B?UjJTQlZpRm5SM1ZLR2lTeWhVUGJZQk5RRlp5eitybjNTandIanVaaVJzNzU0?=
 =?utf-8?B?QXBtNGFiZ0NLZStEcFRnSUQ3bkFud1RkTlJGSklPbzBVNXp3SlUwUVRheXo4?=
 =?utf-8?B?RG1TeitDSEwzaElnVnZoUjZDVWVLVXhoZUlwOFNSTjhVUENxNGtUcllCczBs?=
 =?utf-8?B?ekw0S3NRMlJvOUsvVEU0R2s3NDJva0lrSFhVTjY5QlZpVUVPci9IN21qNnlT?=
 =?utf-8?B?UkZ6ZkJ5S0VjY0lMdFZKMnN5S0tsNkJZdHVJSngyMC9kVGVpd3ZsNk5mS3d0?=
 =?utf-8?B?RXlKYXc5TlFpRnRrcm8wZGJWcENJaUJOakFoaTBiQmhzaUJyQUZFNXdFYTFE?=
 =?utf-8?B?SVBCZ0ZxZXJlbGYrd0h1L096b1BoZ2VKcHhzeHJ3SUFTdEZqODFlbCtSMDM2?=
 =?utf-8?B?ZEs5T2x1V0hwekNxc0xldFhUK1h0aklBMlcxc0M0UlFkREcrYnlzZzhKMTJj?=
 =?utf-8?B?OE9waTZOR3poT0dnOVQrLzZXdVFzcDNnTFN1K2tHNzVEd1VpcnZObEZoc1lW?=
 =?utf-8?B?ZXQyRmxlSUxUcC9WY1puOFYwNWpReWI4WWJQVGF2ZEtsV2hqSVJnaVVNc0Rq?=
 =?utf-8?B?RTRvMGdVeVljaCtuTFNaQVZZOVFvN3ZLanBXbm9WcXdOc0thNG9QVXZCbUE3?=
 =?utf-8?B?Y3k0RFY0R05aUTh4dERZa2RoVEVzNUdlRHVJcGJ4Mnd5RUNPZ3F0TU01cXZP?=
 =?utf-8?B?NHROQlc0V28yMG50RHJuVnIvL25SL3NkelAzL1FueFpnT1YzNGxlQnhxeVBa?=
 =?utf-8?B?MkpkSjhSUlZacHAzWS9CaWJlSi93Sy95QmNtVjJrSjN5OGNJU2V4Y3Q4a3RM?=
 =?utf-8?B?a29ETGNyWk5HMGloZ0FtR3VJWUlna1JRZlhiUjU1NHJSMXQ0aHE4SFlWNFRW?=
 =?utf-8?B?Smt1V1FxNG9Ka3QySGM0WWduc1BSWW1oSlRWVlVsbGRUbnRzTUxCZVZYcnFK?=
 =?utf-8?B?UHNad05vcGNuSm13eHJxSXZPTktIMkR1amxHcmljK3k2V3lUOWFwYklwWWF1?=
 =?utf-8?B?blA2MjF6aERaYk15TnhzMlVIK1UrYzJxc3RvUzc1c0JMd2dBZm96NEluNHo0?=
 =?utf-8?B?WldpWitCTnNZMFNDY0x5S1lIKzV0VUFXOSs2dW5mNTZYVHBtM1pvaUtIWHJs?=
 =?utf-8?B?QXo0U0h5UlhiK1dmZElvM1cvbWpERHhlcUUzYjZPcnFpT3lQbktPTTkwQUow?=
 =?utf-8?B?NlJxU0NlRU5QL1dLSEZIYkI2MmlJdDB4RHhxMDhNMDZiNzA1azJOVGhROFli?=
 =?utf-8?B?VlhTQTZZcVE1Sm9ySjhXTjY3U2FVUjVMRHpkbEs4amdQaWlMK1djempWOThS?=
 =?utf-8?B?dXdNWVorc1FLSnA4K21rUE9OUHRteVJHaVZDSXlVcUJ2dklWaGhDcUpMSlhH?=
 =?utf-8?B?Q2MwVW5LdzdIeGU4T2xpOTZHZWFIR3g3LzF5c3QwanU0bEZmNFNhOGhCU3Ey?=
 =?utf-8?B?KzI5MjlIY0picHlPdVRJNUJ2OWREdzJXWkhTZk5nT3lURng5VmZuc3UzNVd0?=
 =?utf-8?B?T1dRUDNwLzF1WVFtbmNLQ04ybC8ralF5MWtJdVpxaFVYOGZhcVBWTktVYWxk?=
 =?utf-8?B?Ylk1b2VZNlpjdENMb1FxVEhsWG43V2w2N3VXdzRqWjNvSjZtc1M5TzJCbWNJ?=
 =?utf-8?B?SGJzRVB3MVNqaXdvaWtXLzJYMVJvTTY3LzJWZ1owcjVIWXh5RE5qUjRlTUxv?=
 =?utf-8?B?YkE3MUp1UnZva1hjUkpKc3MybXM4dmJNUHhLaTRGd1JNRVhjU1hvTVFjaUox?=
 =?utf-8?B?eFMvNG5hdGc4S3Mzd1pkL2pvWVpCK2VYVFkwZHNZNkJCejhWZ1BONi9iODg2?=
 =?utf-8?B?ZU1IMWpjbEZKRTZRdzZXOEZOOWx6NUc5V0U3R09ZNlhWMzB5akRlQlh6ZnhJ?=
 =?utf-8?B?THlQWW5sZzBpYUxuNTJMUFRqYTBVR0NYZWlNUWxXVHNscFowS2lhSVNhUDRD?=
 =?utf-8?B?YnBZdCtveE95VFRjcmtzVjFPL0g1cEhxZkdJOExXcEY5cHlWaXVQWVg0MjJk?=
 =?utf-8?B?ZnNzaHhIQW1MY0VtbGRGcmxBc1kxZkdpRTBCWFZPcVdIT05ycnY0K0NVUFc2?=
 =?utf-8?B?aml6cXA1STA5ZHMwU2VOUUE4M2hMd2FHNjVZaUc1SXJVeEcvZmk2dnp4ZzVE?=
 =?utf-8?Q?oklXoq3s8531Fzu8aD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f44e6e-205a-4ba3-859b-08dec3d4b0f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2026 14:05:40.2123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JAqAhKaEJxX1apEjtmxegi6uv+cz14W4XsjQq1auIjH0Y1YvhDZCtnBUGdcYcbUYanQcpZzSU4n7SfDEn9LkDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9468
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:wei.fang@oss.nxp.com,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296115-lists,netdev=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,DU2PR04MB8629.eurprd04.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 550B864DB1C

PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5l
dGNfcGZfY29tbW9uLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMv
ZW5ldGNfcGZfY29tbW9uLmMNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2Nh
bGUvZW5ldGMvZW5ldGNfcGZfY29tbW9uLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9mcmVlc2NhbGUvZW5ldGMvZW5ldGNfcGZfY29tbW9uLmMNCj4gPiBAQCAtNDU4LDYgKzQ1OCw4
IEBAIGludCBlbmV0Y19pbml0X3NyaW92X3Jlc291cmNlcyhzdHJ1Y3QgZW5ldGNfcGYgKnBmKQ0K
PiA+ICAJZm9yIChpbnQgaSA9IDA7IGkgPCBwZi0+dG90YWxfdmZzOyBpKyspDQo+ID4gIAkJbXV0
ZXhfaW5pdCgmcGYtPnZmX3N0YXRlW2ldLmxvY2spOw0KPiA+DQo+ID4gKwltdXRleF9pbml0KCZw
Zi0+bXNnX2xvY2spOw0KPiA+ICsNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+IA0KPiBbU2V2
ZXJpdHk6IEhpZ2hdDQo+IElmIHRoZSBkZXZpY2UgZG9lcyBub3Qgc3VwcG9ydCBTUi1JT1Ygb3Ig
dG90YWxfdmZzIGlzIDAsDQo+IGVuZXRjX2luaXRfc3Jpb3ZfcmVzb3VyY2VzKCkgcmV0dXJucyBl
YXJseToNCj4gDQo+ICAgICAgICAgcGYtPnRvdGFsX3ZmcyA9IHBjaV9zcmlvdl9nZXRfdG90YWx2
ZnMocGYtPnNpLT5wZGV2KTsNCj4gICAgICAgICBpZiAoIXBmLT50b3RhbF92ZnMpDQo+ICAgICAg
ICAgICAgICAgICByZXR1cm4gMDsNCj4gDQo+IFRoaXMgc2tpcHMgdGhlIG11dGV4X2luaXQoKSBm
b3IgbXNnX2xvY2suDQo+IA0KPiBIb3dldmVyLCB0aGUgcGh5bGluayBjYWxsYmFja3MgZW5ldGM0
X3BsX21hY19saW5rX3VwKCkgYW5kDQo+IGVuZXRjNF9wbF9tYWNfbGlua19kb3duKCkgdW5jb25k
aXRpb25hbGx5IGNhbGwgZW5ldGNfcGZfbm90aWZ5X3ZmX2xpbmtfdXAoKQ0KPiBhbmQgZW5ldGNf
cGZfbm90aWZ5X3ZmX2xpbmtfZG93bigpLg0KPiANCj4gVGhlc2UgZnVuY3Rpb25zIGV2ZW50dWFs
bHkgcmVhY2ggZW5ldGNfcGZfbm90aWZ5X3ZmX2xpbmtfc3RhdHVzKCksIHdoaWNoDQo+IGF0dGVt
cHRzIHRvIGFjcXVpcmUgdGhpcyB1bmluaXRpYWxpemVkIGxvY2s6DQo+IA0KPiBlbmV0Y19wZl9u
b3RpZnlfdmZfbGlua19zdGF0dXMoKQ0KPiAgICAgbXV0ZXhfbG9jaygmcGYtPm1zZ19sb2NrKTsN
Cj4gDQo+IENvdWxkIHRoaXMgY2F1c2UgYSBsb2NrZGVwIHdhcm5pbmcgb3IgYSBjcmFzaCB3aGVu
IHRoZSBkZXZpY2UgbGluayBjb21lcw0KPiB1cCBvciBnb2VzIGRvd24gYW5kIHRvdGFsX3ZmcyBp
cyAwPw0KDQpUaGlzIGlzIGEgYnVnLCB3aWxsIGZpeCBpdCBpbiB2Mi4NCg0KPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjX21zZy5j
DQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjX21zZy5jDQo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjX21zZy5j
DQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjX21z
Zy5jDQo+IFsgLi4uIF0NCj4gPiArc3RhdGljIGludCBlbmV0Y19wZl9zZW5kX21zZyhzdHJ1Y3Qg
ZW5ldGNfcGYgKnBmLCB1MzIgbXNnX2NvZGUsIHUxNg0KPiBtc19tYXNrKQ0KPiA+ICt7DQo+ID4g
KwlzdHJ1Y3QgZW5ldGNfc2kgKnNpID0gcGYtPnNpOw0KPiA+ICsJdTMyIHZhbDsNCj4gPiArDQo+
ID4gKwllbmV0Y193cigmc2ktPmh3LCBFTkVUQ19QU0lNU0dTUiwNCj4gPiArCQkgRklFTERfUFJF
UChQU0lNU0dTUl9NQywgbXNnX2NvZGUpIHwgbXNfbWFzayk7DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IHJlYWRfcG9sbF90aW1lb3V0KGVuZXRjX3JkLCB2YWwsICEodmFsICYgbXNfbWFzayksIDEwMDAs
DQo+ID4gKwkJCQkgMjAwMDAwLCBmYWxzZSwgJnNpLT5odywgRU5FVENfUFNJTVNHU1IpOw0KPiA+
ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBlbmV0Y19tc2dfbm90aWZ5X3ZmX2xpbmtfc3Rh
dHVzKHN0cnVjdCBlbmV0Y19wZiAqcGYsIHUxNg0KPiBtc19tYXNrLA0KPiA+ICsJCQkJCSAgICBi
b29sIGxpbmtfdXApDQo+ID4gK3sNCj4gWyAuLi4gXQ0KPiA+ICsJaWYgKGVuZXRjX3BmX3NlbmRf
bXNnKHBmLCBwZl9tc2csIG1zX21hc2spKQ0KPiA+ICsJCWRldl9lcnJfcmF0ZWxpbWl0ZWQoJnBm
LT5zaS0+cGRldi0+ZGV2LA0KPiA+ICsJCQkJICAgICJQRiBub3RpZmllcyBsaW5rIHN0YXR1cyBm
YWlsZWRcbiIpOw0KPiA+ICt9DQo+IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IElmIGEgVkYgaXMg
bWFsaWNpb3VzLCBjcmFzaGVkLCBvciBpbXByb3Blcmx5IGNvbmZpZ3VyZWQgYW5kIGZhaWxzIHRv
IGNsZWFyDQo+IGl0cyBiaXQgaW4gRU5FVENfUFNJTVNHU1IsIGVuZXRjX3BmX3NlbmRfbXNnKCkg
d2lsbCBibG9jayB0aGUgcGh5bGluayB3b3JrZXINCj4gdGhyZWFkIGZvciBpdHMgbWF4aW11bSAy
MDBtcyBwb2xsaW5nIHRpbWVvdXQuDQo+IA0KPiBCZWNhdXNlIGVuZXRjX21zZ19ub3RpZnlfdmZf
bGlua19zdGF0dXMoKSBvbmx5IGxvZ3MgYW4gZXJyb3IgYW5kIGRvZXMgbm90DQo+IHJlbW92ZSB0
aGUgdW5yZXNwb25zaXZlIFZGIGZyb20gcGYtPmxpbmtfc3RhdHVzX21zX21hc2ssIHdvbid0IGV2
ZXJ5DQo+IHN1YnNlcXVlbnQgbGluayBzdGF0ZSBjaGFuZ2UgYWxzbyBpbmN1ciB0aGlzIDIwMG1z
IHN0YWxsPw0KDQpUaGlzIHByb2JsZW0gaXMgdW5hdm9pZGFibGUuIFdlIGNhbm5vdCBkZXRlcm1p
bmUgd2hldGhlciBWRiBpcyBtYWxpY2lvdXMNCm9yIHNpbXBseSBub3QgcmVzcG9uZGluZyBkdWUg
dG8gYnVzeSBjb25kaXRpb25zLiBSZW1vdmluZyBpdCBmcm9tDQpwZi0+bGlua19zdGF0dXNfbXNf
bWFzayB3aWxsIGNhdXNlIFZGIHRvIG1hbGZ1bmN0aW9uLg0KDQpQbGVhc2UgaWdub3JlIHRoaXMg
d2FybmluZy4NCg0KPiANCj4gQWRkaXRpb25hbGx5LCBhIG1hbGljaW91cyBWRiBjb3VsZCBzcGFt
DQo+IEVORVRDX01TR19SRUdJU1RFUl9MSU5LX0NIQU5HRV9OT1RJRklFUg0KPiBtZXNzYWdlcywg
Zm9yY2luZyB0aGUgUEYgdG8gcmVwZWF0ZWRseSBjYWxsIGVuZXRjX3BmX3NlbmRfbXNnKCkgd2hp
bGUgaG9sZGluZw0KPiBwZi0+bXNnX2xvY2suIENvdWxkIHRoaXMgc3RhbGwgdGhlIHNoYXJlZCBt
c2dfdGFzayB3b3JrcXVldWUgYW5kIHN0YXJ2ZQ0KPiBvdGhlciBWRnM/DQoNCkkgZG9uJ3QgdGhp
bmsgdGhhdCdzIHRoZSBjYXNlLCBzaW5jZSBtc2dfdGFzayBkb2Vzbid0IG9ubHkgaGFuZGxlIG1l
c3NhZ2VzIGZyb20NCm1hbGljaW91cyBWRnMuDQoNCj4gDQo+ID4gQEAgLTM2MSw2ICs0NzEsNyBA
QCBpbnQgZW5ldGNfc3Jpb3ZfY29uZmlndXJlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBpbnQNCj4g
bnVtX3ZmcykNCj4gPiAgCWlmICghbnVtX3Zmcykgew0KPiA+ICAJCXBjaV9kaXNhYmxlX3NyaW92
KHBkZXYpOw0KPiA+ICAJCWVuZXRjX21zZ19wc2lfZnJlZShwZik7DQo+ID4gKwkJcGYtPmxpbmtf
c3RhdHVzX21zX21hc2sgPSAwOw0KPiA+ICAJCXBmLT5udW1fdmZzID0gMDsNCj4gPiAgCX0gZWxz
ZSB7DQo+IA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gV2hlbiBkaXNhYmxpbmcgU1ItSU9WLCBw
Zi0+bGlua19zdGF0dXNfbXNfbWFzayBpcyBjbGVhcmVkIG91dHNpZGUgb2YNCj4gcGYtPm1zZ19s
b2NrIGFuZCBhZnRlciB0aGUgVkZzIGhhdmUgYmVlbiBkaXNhYmxlZCB2aWEgcGNpX2Rpc2FibGVf
c3Jpb3YoKS4NCj4gDQo+IElmIGEgcGh5c2ljYWwgbGluayBzdGF0ZSBjaGFuZ2Ugb2NjdXJzIGNv
bmN1cnJlbnRseSwgY291bGQNCj4gZW5ldGNfcGZfbm90aWZ5X3ZmX2xpbmtfc3RhdHVzKCkgYWNx
dWlyZSB0aGUgbG9jaywgb2JzZXJ2ZSBhIHN0YWxlIG5vbi16ZXJvDQo+IG1zX21hc2ssIGFuZCBh
dHRlbXB0IHRvIG5vdGlmeSBkZXN0cm95ZWQgVkZzPw0KPiANCj4gU2luY2UgdGhlIFZGcyBhcmUg
bm8gbG9uZ2VyIGFjdGl2ZSwgdGhleSB3b3VsZG4ndCBjbGVhciB0aGVpciBiaXRzLCBjYXVzaW5n
DQo+IGVuZXRjX3BmX3NlbmRfbXNnKCkgdG8gaW5ldml0YWJseSB0aW1lb3V0IGFmdGVyIDIwMG1z
LiBTaG91bGQgdGhpcyBtYXNrIGJlDQo+IGNsZWFyZWQgdW5kZXIgdGhlIG1zZ19sb2NrIGJlZm9y
ZSBkaXNhYmxpbmcgU1ItSU9WPw0KDQpJIGRvbid0IHRoaW5rIHRoaXMgbmVlZHMgdG8gYmUgaW1w
cm92ZWQuIEZpcnN0LCB0aGlzIGtpbmQgb2YgcHJvYmxlbSBpcyB2ZXJ5IHJhcmUsDQphbmQgc2Vj
b25kLCB0aGUgdGltZW91dCBpcyBub3JtYWwgYW5kIHdpbGwgbm90IGhhdmUgYSBmdW5jdGlvbmFs
IGltcGFjdC4NCg0KQW5kIHRoZSBwcm9ibGVtIGNvdWxkIG5vdCBiZSBzb2x2ZWQgZXZlbiBiZWZv
cmUgbW92aW5nIHRvDQpwY2lfZGlzYWJsZV9zcmlvdigpLiBCZWNhdXNlIFZGIG1heSBzdGlsbCBz
ZXQgaXRzIG1hc2sgdmlhIG1lc3NhZ2UgZHVyaW5nIHRoZQ0Kd2luZG93IGJldHdlZW4gY2xlYXJp
bmcgdGhlIG1hc2sgYW5kIFZGIGFjdHVhbGx5IGNsb3NpbmcuDQoNCi0tDQpwdy1ib3Q6IGNyDQoN
Cg==

