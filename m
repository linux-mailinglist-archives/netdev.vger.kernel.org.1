Return-Path: <netdev+bounces-100069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86968D7C01
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FD91C21741
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 06:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE493D549;
	Mon,  3 Jun 2024 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bsEcLafx";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PZV3+RrV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70233631;
	Mon,  3 Jun 2024 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397766; cv=fail; b=VoKewSb199AhoaAJiZ2I+ZJEtsOJ43GYwWnFSiYDxAJaf28wPYkbtMFlz4R8WEUmes5l1LO8BdlQ1EDd0PQF+6+Q9QTqofT8RurmIF9O9m/i0kVoqBbp30yNJRBc1pXFBtNGMRRs4r53lAegidCAje4q9QsGpfLdjdIfbM4XRdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397766; c=relaxed/simple;
	bh=O86h+R4cZdxhiTQH9HgQ/qKfCzKmk25FrOL8TuAxkiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JU6GqP0k9hXxYSOp6arVo7xK2G67qAZcfuJpLZg2yxRn2QF+kF3VGTBScLMbGhcX67wcWlLie+1TkUfw8IlVPLQ104tA+YnYFX65f2jTipxoPPGv4MiYhz+wopjmF0R7MCfIRa+K4q+5qwM5X5Osn9NXisBstubIQPzRsWZElmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bsEcLafx; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PZV3+RrV; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717397764; x=1748933764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O86h+R4cZdxhiTQH9HgQ/qKfCzKmk25FrOL8TuAxkiE=;
  b=bsEcLafxnpm3Q9o3z3Vvm1c/1dNZe1VFaWPRGwauOxOn6Vr0fqL02t0f
   wlq+hDk9ldKMRxJXd7QOyJhtiTaXq/ctduZkuv5fdQOZBuM0ZBS91izRA
   AVZyHn55em/jGkPw8FvhB+Ks+S6Ly/irt2II+SNcXvowLJ0PUKFgn65YG
   bxGpCJi+TPZYHXKTUWTrYDhWhEp0LPIWAZt9WLc3jgmDMVAxCPs7/Ioa7
   FsLDqLWeaINAD2OPO46STLXPPbFLeLqCU/a8jusEGXkHxWxMmgW97F6Ar
   wgye6RUh0qR9hb/qKwawJGRLa8aqTppCOOt70dCWxEqrPaNbXzsFaxtYQ
   g==;
X-CSE-ConnectionGUID: uj2khGWHT/WC9BsU25snCA==
X-CSE-MsgGUID: xOyZSKZDSEKZam+oBH+kKw==
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="27504343"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2024 23:55:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 2 Jun 2024 23:55:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 2 Jun 2024 23:55:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7nTbkWBlUgsLKMnKiExOn3ZvnKDzuL2WmcksB04pIw4fta+bNPo/ItRAs0j9ljcVRQXWSBFXyX8OCLC5BH2q/XVbdPEfG7yqANWckbbj0IaOiwMMuICiHJn+x7zuhOJvjgLjKFvifc4gYIDZCxEcka5mAOFcxDyjF4ir8TgV38DPo/sTyLFolAgcUtvhq5cGpzUZgSUdqFVkj/s/1tsEOphXWj1eMW5gBgtkbgS2hqX2S8VH1apFFK8EEkmPZfd3G1OK0xGL96JfrehzKcPCFE4HQitsSV+lfQF9xLRZtdG/fdvdzmqRBC5QGBME68e/1D6sU1a8lDVRKNO0luAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O86h+R4cZdxhiTQH9HgQ/qKfCzKmk25FrOL8TuAxkiE=;
 b=FkKzeGKjG9oa0/zfIwEdq0KYnnDUD1/soi27UgaM9rrc5B658hjd9aDCtvXJPCU9xMVrvIccYXrG2ooUvRIXrtikDvHb4xqwUXZ4J7RcHZc0g19VGxILC9HKBPvNsPylVUDLupmn5isB2VUTs2hf6BVYVGGoi54+81wgCpAHZ7Ir9WB8QogS6/KaAEPEENjbcecakWjNw0G/P8og2De3D/OmruEsrKFElT8WIUVS2mL/xeBtxUh35btUDJVHIAf8z2SRlQSRTHJ3rDYdYiSolKK7okFaANfU5TotptHKb25R9HSrfz0kkwIe9l75UrPj6BZJ0zsKrHh6CWxqyVO+zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O86h+R4cZdxhiTQH9HgQ/qKfCzKmk25FrOL8TuAxkiE=;
 b=PZV3+RrVq9Bar76P/4kH6XNfH1rOVM/72H/J682UrRaUtsCEwcciVMXVWKdV5zV0SYaIFQBMgUcRlgRW4fWnFumYACHr8djYiz4v/YNnXpgz+lza5dHxv5QlefGx5YiDqa0TSCjVZCIjuYHr4j85p+CHqMN/EY9cLqZdKbDg+nhgbQclQmJoxfEn71gPQX1Ft+U3THm91JkH6x2gzwPdZYyz/GmDAY+B9ROtelIJ9J2CVgnTGluXGvIzN9CZdomGqAb2DV/cklk6vgxYfX2CYkf2YzgeA9lG3blCdq5i1p56oFUqlmqW7gHlrm8YE/Rk95UBjauBRAXFaPiV5arRLw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CH0PR11MB5235.namprd11.prod.outlook.com (2603:10b6:610:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 06:55:26 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7587.030; Mon, 3 Jun 2024
 06:55:25 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>, <Viliam.Vozar@onsemi.com>,
	<Arndt.Schuebel@onsemi.com>
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Topic: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: AQHakY/2Zb5TFJZ12UCHjfgce9+PGrF0voeAgAA2YoCAGHimAIAAQu0AgAFPUYCAAH8FAIAA9qQAgBaf9gCAAAnAAIAABQ8AgAACngCACKHOAIABvDEAgAAGjwCABFd7gA==
Date: Mon, 3 Jun 2024 06:55:25 +0000
Message-ID: <49c4ced9-0429-4730-b0d2-1f679415a53c@microchip.com>
References: <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
 <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
 <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
 <39a62649-813a-426c-a2a6-4991e66de36e@microchip.com>
 <585d7709-bcee-4a0e-9879-612bf798ed45@lunn.ch>
In-Reply-To: <585d7709-bcee-4a0e-9879-612bf798ed45@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CH0PR11MB5235:EE_
x-ms-office365-filtering-correlation-id: 6acc483e-e8f7-4a72-3c72-08dc839a25a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VHQ4THY5WVFocXBnMXRQeitRZlB5SVFwbzk4SWlzY2Jnd2lNcWF0RUtsMHlm?=
 =?utf-8?B?c1YrZmFOaVZhRzUzMmNwemJYTUR2T09qejlVYmY2QWlzUmxtbmMrdlRzSEpo?=
 =?utf-8?B?UGRaRXVvU3ZUcDQ0d3Q5eFRhWTZRTUpKcEs3R3Q4eTViOWIzc0drcWFjcFdo?=
 =?utf-8?B?RzQxSS9hQXNSNW5uSW12a0NIMjI2Z0xFZStkbUFkdmZidHBUODB0eWs1R3BX?=
 =?utf-8?B?dWNlWnpSRFFRTkRSWXZpaXRzaEVyS2xoSUtXR1VDMjlieU5JWTBFRGRTSEw4?=
 =?utf-8?B?NzRpMlJFWE44M3VYWnJaN1RJRmxndUFjSzRLQ1pMeTBMdEpLMEE1NklqV3VC?=
 =?utf-8?B?ZmRVRS9wUTRFSERkdXBQUEkzeUR0UFp0Y3Mvd3lOQUM4dmhMbytpTi9IeEJ0?=
 =?utf-8?B?ODdBSWxGdWdTTU1qSVZnN0RGTTFhQUVuc3VvY0dCM0pkM2MxYVNhYnpMUVFj?=
 =?utf-8?B?WmoxQVVFNi9hemZWTjEvckd1TndUVHFmUXlhQXMxUVdHaWlXUFl2SFJqYlcy?=
 =?utf-8?B?M3NaV003R1YxMnlXZlZrQkt3WmcrRDJ0amtuWFZlL3lvNnMvVUE5eklaZ2Iv?=
 =?utf-8?B?ZUcvYU5Ec3AvOWlEZWhwOU5YRHhHWENFVzlUcTRROVM1NU85c1huSUxFNkxU?=
 =?utf-8?B?MGtkVDJIMzJsbGxBL3d3dy9WN1dyYTg1bzhqdCs5S2wvNDdGcEZ1WlBTa0RG?=
 =?utf-8?B?ZUV4WkJqcCtRNmJxSFJNdW94SXNqcnN0T2dXY2MxSmZUREw4Rk1MTGlzU3NE?=
 =?utf-8?B?NnRuZ0JOUVFBR0xUSWttbGN5VThheXJZWWFOZDlmYVhIaXlremJyaGZNTi9m?=
 =?utf-8?B?LzMycDU1VFNyTzZXU2Q5N3JoOXJOd3o2ZVk1K2Z2a2NTWHhpNms0UjZZNVY2?=
 =?utf-8?B?UDB3N2hQVGN2ci9KU1BycVB5UFROcmpxd1FTNW01c0RzUW44SVRkRDNwV3B3?=
 =?utf-8?B?TzRLUjdjUnk0YzVIYURnTmIvOHgxMDVkK0xUY3V5OVNmb1M5QklYNHhtUDF5?=
 =?utf-8?B?cDhTOWxGRHBia2hzV1lFc2taVGlZSkRKcnVpczA4cFc5WGlBTmd1aFNKeU5n?=
 =?utf-8?B?U0lCSksyS3JGeEFpcExRQlJ5cStZQVFMYUNKbXNWVU56UlpKbVRmVkNteVBz?=
 =?utf-8?B?T0dMMFYzV2N1WFkrcmh5bUVUNWdoQ2FudnIzeEh4UFdHeUhlYkxFNzJNTit5?=
 =?utf-8?B?KzYyTWdScHRKYTNBRnFOanVCNDlFT2Qza3ovVkxOS2QzZDEwVWNwazRrT2Zx?=
 =?utf-8?B?WFh2d1dQYjlmelRxdm4wVzFzOXhZK24vcGwvUnNFK0Y1b1lHaHRneWhGbnJV?=
 =?utf-8?B?blovWHdROVU4UzN5K1lzL3hrR0VvMHVOK1YzdkNtdm5CV2VpeHo4Z2V0Z3Yw?=
 =?utf-8?B?WGdBSDMydjBGWk5oQ1VwMnJBMGdESHJUcGVQdnFWb0V2Q0gxcEVqbUIrMk5P?=
 =?utf-8?B?ZkJIUVh5cmcvRDkraStZS1EwZ0tja1hFR2ZmTjhZczBpRzZGbnhpa2h2Tnl6?=
 =?utf-8?B?L2QwVS95b3NBaGVKUkxBeUFvWkR6T1lWSlgxZHNjM2JsSU9lRUZvMUZWY3FI?=
 =?utf-8?B?RksyMGJKMDVUaG01U002eHJWaTErN2lkWWhDeWlFWENuY09qcjF5MFlici83?=
 =?utf-8?B?VTA3azlWUEJaMmN1YUo2YUNKNWxUQjdXM0kyOGFQYzZ2S2xhZGhuS3ZoSDk1?=
 =?utf-8?B?cjdqUlBJVFczT3JZNHVFb2JTa0loSmp4disxZENqRnFvak1kMFpIL01xYWFN?=
 =?utf-8?B?b0JTMzkwT1h3OXhybjBZdVVvZzcyU3ZzOUtHcHI4bTcxNnBxZXdDc1dzZlUr?=
 =?utf-8?B?T0wzQjI1bVNZVzBZMVdmQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TG9UWjZIQzQ4UXNTTHZ2L2h4UHNOVzJiWFBjZG9Vc3N4QmlzZThVL0Q2amFB?=
 =?utf-8?B?WCtJdGpxMk9hbjVwbmR0ako1ZnRTZ001S2xVSlhUa24wQU5XWkNKTXkyczcy?=
 =?utf-8?B?Q0VlSExicENOSFhKYm0vVXdiVVBJUDl5WDExOGZ5UUdqN0RNQWVpTUNBWjhM?=
 =?utf-8?B?bU5iUGl3SXA0RDl2dlZFaW5TQVM3b2NlQzRvNVJBUlpnTHg3VWYzb0xseVAz?=
 =?utf-8?B?Y1kyL0VxUk1UTGVQdWhnajAxbU5GVlEzVExNUVR3ZEo0WUxIcC9DUFRWdi9x?=
 =?utf-8?B?Mms1WTZRdTJoQ3BudmxQZW9RSGF3cjdOVjNPNnMrT21WVnQ1bWNMR3hVRlBP?=
 =?utf-8?B?cVFwaTJ5c045TklrMlpzQVNkL0hOVHJucUh3TUhwUVIwV0d2THEyeUVHa0t3?=
 =?utf-8?B?enVSUVl0UFA3aHBLazV1VHdTQU5OL1AwMTBKcmd2a3lNbWRuaTYxcytCRGNr?=
 =?utf-8?B?ODBISEdWRG5QUnpkNk81a2lhTFQwRTc0RFgzYnFESnZ6M2lOZUZOdXFCK0M3?=
 =?utf-8?B?S2c2S1lSN2wwRURwQW9kL1ZuZUY1TEZ2N3cwQjFYSDRLOG1zM0E2QUZnSFo4?=
 =?utf-8?B?cEtGNlNTaTl2eCtXOTZnRURUaEp1Z1VtaEZJNGoyTTJGamN2Vi9WbWhXN3ZK?=
 =?utf-8?B?bkFuN3NUSEx6cGZseXhQd2tWWnQ0b3RYeUlTZXlRRTZ0Z0VKOGsyOEFOSnZ0?=
 =?utf-8?B?OWhHbGNmVExZU0xQSWJuRFl2N09GckFYdklRZXNzbUlySEdSU0FaQkRybmsv?=
 =?utf-8?B?Q2ozdVhPYk84eFJ1WVJMcUJsa3JJOVlJV2lvVUpIN2NTMS9ucm5yRW5NMWFs?=
 =?utf-8?B?MXlqVzZOWTdDL1VSM01sWkQzU1p3ZCtCSWQ1UndJWDdIWDEyMlc2TE1RRTFI?=
 =?utf-8?B?d0ZEOXBhRTR6S00rU0lCSi9URVV4eVBIK2RWLzN4Y2N0NDdFYnQ5Z1hVak96?=
 =?utf-8?B?R1BBejlXK1NlU05uT1N1Y09xNEVKbGdtVi9qT0EvR0dqaUR2VEkyU2QybkZU?=
 =?utf-8?B?VVZGazQ1OTY3Nit3V1pwN0M0MXFyU0RkWkdpSkkrR20xa2ZjakZuOE4vWElN?=
 =?utf-8?B?OVNpajZOZVpmeFd2TVQzcmxwV2lKMVlONTVlWU9xTUtKdEpxR0NFdFlTK3NM?=
 =?utf-8?B?TC8rY0IzNVFxNHRXaEEweWtMbzkwcytRL0paeEZFTUx3UkR0eDYvNUxHR2Rs?=
 =?utf-8?B?eWREWnFqVHFtQ3JId2lvN3Q5Ry8wVmNGNFZvTnA1VEttWkozN2RKc1VnWlVm?=
 =?utf-8?B?WkpxRVBUeXlCbkxXQUNzeS9US09zbldlR1lxazNicEJKTHkwMHFPTk05OERS?=
 =?utf-8?B?MTJabnAvbXlubUFDVjFEZ29UY1o2c0JpbFJCWmJCZGI1WWUzRHpGbXEyQStG?=
 =?utf-8?B?bnloVlFzVU9JcUVJcFBJaEI4d0Zyd3hDaGh1bEV2R3REeHZpM2lUU2lmRW1G?=
 =?utf-8?B?c1dselZ0eFozZEpES25XbGorRDlKTG1ueWp0QWZxdkFZQzEwZklCZU9weTBD?=
 =?utf-8?B?YzRzTGNZYVQvdkI3b1R1SnNMMFdzbkdHcUU3aks4NERKSHJFbGhJT0txT3FH?=
 =?utf-8?B?Y2tia1g5K0xkc0tmNGoxSlhxa3owdGJSWjFnNWZ5M1dlczYwR0I2cDdSMHZF?=
 =?utf-8?B?YllGbGJnODlWVDgzUkFBa3dmem5rTDJWQU5sbVpwSHpKSlJwTDBJck1HUklT?=
 =?utf-8?B?amJpSGhGL3lxenMwL21vYWJ3KzJ5c2NOcGhzZHI0VU4zekgzd2FFb0pnUnlp?=
 =?utf-8?B?eWlsYVl0ZVpNVEE3Zk1FNlV2cHRVNGtYRHMzRTdabVBSVFJvdEhXcHBxbE1J?=
 =?utf-8?B?TE5wN3h1SzEwMHVIemQ3ckZrNDF6S0ZRWUh1dEFZRmVrZHNyclk2cnpxTS9Y?=
 =?utf-8?B?Qnhua3NyQlptQlBOdVR0WURkeXdHZDFzTXhpdjRieDArN25uLzZ5K094UVMr?=
 =?utf-8?B?enNOb0w1bE1GYW1UdDdKQTZ0cGc5dTBrVHh5NXQ0dmRGWjBINCt3RjAzelh0?=
 =?utf-8?B?VGU4c1JmVGVmRFBhMEI2UEc1TThsNVBRci9WdElOYlFMUGpFSitOcjQxcnhj?=
 =?utf-8?B?TzR2Qlo4MEpjek1YQlVtS0tmSHVXK0h2OWdQWFRTY2NKUk94bFIxbzlwUXRK?=
 =?utf-8?B?ZG96RVhRdTkyZjd5SEFhTm5mQWZoSmFNYW5SdVlJcW9vMGdDb1dzb2tScThL?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BEA1347F082494FBB3DB556C2D65478@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acc483e-e8f7-4a72-3c72-08dc839a25a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 06:55:25.8605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dahbS+p5nwJIrRn7HEcaw27+9XM7imKluiwCi0oHu5hVFX/zKqR7KUnbeiKkUwCpqJxHPxLTBwYydIuG9hpmYzvb6tuBIE+NrHa2NqPVzDFBsPFlYBf9E6Ns6+eC8bOH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5235

SGkgQW5kcmV3LA0KDQpPbiAzMS8wNS8yNCA2OjA3IHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gU28gSSB3b3VsZCByZXF1
ZXN0IGFsbCBvZiB5b3UgdG8gZ2l2ZSB5b3VyIGNvbW1lbnRzIG9uIHRoZSBleGlzdGluZw0KPj4g
aW1wbGVtZW50YXRpb24gaW4gdGhlIHBhdGNoIHNlcmllcyB0byBpbXByb3ZlIGJldHRlci4gT25j
ZSB0aGlzIHZlcnNpb24NCj4+IGlzIG1haW5saW5lZCB3ZSB3aWxsIGRpc2N1c3MgZnVydGhlciB0
byBpbXBsZW1lbnQgZnVydGhlciBmZWF0dXJlcw0KPj4gc3VwcG9ydGVkLiBJIGZlZWwgdGhlIGN1
cnJlbnQgZGlzY3Vzc2lvbiBkb2Vzbid0IGhhdmUgYW55IGltcGFjdCBvbiB0aGUNCj4+IGV4aXN0
aW5nIGltcGxlbWVudGF0aW9uIHdoaWNoIHN1cHBvcnRzIGJhc2ljIDEwQmFzZS1UMVMgRXRoZXJu
ZXQNCj4+IGNvbW11bmljYXRpb24uDQo+IA0KPiBBZ3JlZWQuIExldHMgZm9jdXMgb24gd2hhdCB3
ZSBoYXZlIG5vdy4NCkdyZWF0LiBUaGFua3MgZm9yIHlvdXIgb3BpbmlvbiBvbiB0aGlzLg0KPiAN
Cj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L25ldGRldmJwZi9wYXRjaC8y
MDI0MDQxODEyNTY0OC4zNzI1MjYtMi1QYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNv
bS8NCj4gDQo+IFZlcnNpb24gNCBmYWlsZWQgdG8gYXBwbHkuIFNvIHdlIGFyZSBtaXNzaW5nIGFs
bCB0aGUgQ0kgdGVzdHMuIFdlIG5lZWQNCj4gYSB2NSB3aGljaCBjbGVhbmx5IGFwcGxpZXMgdG8g
bmV0LW5leHQgaW4gb3JkZXIgZm9yIHRob3NlIHRlc3RzIHRvDQo+IHJ1bi4NClN1cmUgSSB3aWxs
IHN0YXJ0IHByZXBhcmluZyB0aGUgdjUgbm93Lg0KPiANCj4gSSB0aGluayB3ZSBzaG91bGQgZGlz
YWJsZSB2ZW5kb3IgaW50ZXJydXB0cyBieSBkZWZhdWx0LCBzaW5jZSB3ZQ0KPiBjdXJyZW50bHkg
aGF2ZSBubyB3YXkgdG8gaGFuZGxlIHRoZW0uDQpPSywgSSB3aWxsIHJlbW92ZSB0aGUgcGF0Y2gg
d2hpY2ggZW5hYmxlcyB0aGUgaW50ZXJydXB0cy4NCj4gDQo+IEkgaGFkIGEgcXVpY2sgbG9vayBh
dCB0aGUgY29tbWVudHMgb24gdGhlIHBhdGNoZXMuIEkgZG9uJ3QgdGhpbmsgd2UNCj4gaGF2ZSBh
bnkgb3RoZXIgYmlnIGlzc3VlcyBub3QgYWdyZWVkIG9uLiBTbyBwbGVhc2UgcG9zdCBhIHY1IHdp
dGggdGhlbQ0KPiBhbGwgYWRkcmVzc2VkIGFuZCB3ZSB3aWxsIHNlZSB3aGF0IHRoZSBDSSBzYXlz
Lg0KU3VyZSwgdGhhbmtzIGZvciB0aGUgY29uZmlybWF0aW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpQ
YXJ0aGliYW4gVg0KPiANCj4gUGllcmdpb3JnaW8sIGlmIHlvdSBoYXZlIGFueSByZWFsIHByb2Js
ZW1zIGdldHRpbmcgYmFzaWMgc3VwcG9ydCBmb3INCj4geW91ciBkZXZpY2Ugd29ya2luZyB3aXRo
IHRoaXMgZnJhbWV3b3JrLCBub3cgd291bGQgYmUgYSBnb29kIHRpbWUgdG8NCj4gcmFpc2UgdGhl
IHByb2JsZW1zLg0KPiANCj4gICAgICAgICAgQW5kcmV3DQoNCg==

