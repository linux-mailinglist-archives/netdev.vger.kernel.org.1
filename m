Return-Path: <netdev+bounces-94468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E918BF90E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41E21F21481
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7E2BB00;
	Wed,  8 May 2024 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZXBFnnWf";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uW6cgXgp"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C80D535B6;
	Wed,  8 May 2024 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715158369; cv=fail; b=GzCfRYQQExvXZKRtb0EgZwsWFh28Zl+jJZZ78iGrdL/tiIkfoPbHCMAkNeSCsw7t1AWc9Xui39xX4sYhYA1X972kV7axxgHKvofyBbMarFGJJPZElldKP4dCVO4kxldpOTv0/D9rBTzzhqbChXYSSKVqmGaJ5LPJljysrXLxkys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715158369; c=relaxed/simple;
	bh=Z09ikeGjoyn/gDQfcMAhl9LaH04DNMd7SgHeQ9mlDeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=laRcspftayG2VI7llgP8Lgly6o94lCjtl98vaDo7sK0F0SiQ64mFAtqhfHzs5UswdFTYMpBJgrVG5xcseJcOp5VdxM719mdRPKK6yFC3shIYbmNBQ7a9mre1pdjNkuP4EQ5VOor/CgSYwyJAHS9S0T7ENT3qZx4clL353dB0MYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZXBFnnWf; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uW6cgXgp; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715158367; x=1746694367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z09ikeGjoyn/gDQfcMAhl9LaH04DNMd7SgHeQ9mlDeM=;
  b=ZXBFnnWfE8yyyBt05APhEHFHIJe8JJMN9oCsecso9ev98L7QxoeU0bmq
   RE7t0xsQRX5zjNNbjr638IdC0VIEdv1opnUgymZhMgvl39AyDOAjJD3SC
   nRMv0E7TiAIau0CkMBnrb6gghcgQ3ThA6/XCMF0ygG68mnPfmvaGW3TBS
   TKz1h4siyEDv+7LUUt/fSNtMk2Wkb8Q3eThBNPYKauBBWMCa/l+pEGN0f
   bNIvVFQdJ+j3Oamdfzq7E1xiea49232eDpxOYkE03yfTA96zkHOR9beSF
   xQMlhu3ZL2SShgKpTRB1ZLzYllo82kucUYUw62SskOgA8e1MHg0e7uZF9
   Q==;
X-CSE-ConnectionGUID: HK79AMu2R7OB5AxA9tf/iw==
X-CSE-MsgGUID: bUxHgEQqQtCOiKrudFlt4g==
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="24123133"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 May 2024 01:52:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 01:52:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 01:52:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C52zvB6Q6drFy6BgY0eCeuYDuzz5XX2x5e5ezpHV34HsNVh+0f6CYXQP+Ss2Y+o3y4eQ74OMYmhF4FgbRXYEhQ6JV0yzFY192vBv3E3jd6aJPW+G0XidBUy3wFSb+Mf9ToVJjw9vckNfd9dzUXcy6aRvVMZJgNjuEYY3UPzVXGqUX9whnqb0ARIpRiJAg9KRBHA2xxLBFuRRL8F2AoWR4lUP7F4G1+nVnDfzHORNt7TnxuXaPLZ9C6F4Xw4bOQegI3BQjYqTpXVUBdocwZ8egcFQmRb6ShYo9XMjEkwhHSHNSSAyUMZnNUVvx8lsUJh9Xw+hAiDJyVYE0FqYX5KnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z09ikeGjoyn/gDQfcMAhl9LaH04DNMd7SgHeQ9mlDeM=;
 b=kq/F+Y8Q7JZOrIoYGcMIhG61P+Nonu7rGIjXwmy8FkRy8i97EPdzlHZ08rAs6VoHpL/ezy6hm57SWihVJXUMAPHkceIprG1+nIJuJEJWvSa3ozCHUbX56osQHCUt7zkNCB9U12nQqWkSMBJdkVfJSqVDycMFR6EkojBlAtVkE7O6Y/ZDQF1G0tAvE+lEVZ9w5ZPZG9r2CGI5w+B4KzfpJpjTBU1k8Q3fSNOOt0NPv4rT8KAE5f2YWnrBU5gp2gTaFn4T63RaWynsjWegp7qBX8C9RTbr6C1JVMWc5JOZRfqKPf2UJsCIkxn+jGD1QQNGOKXM/dd8kombIdOMHrI/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z09ikeGjoyn/gDQfcMAhl9LaH04DNMd7SgHeQ9mlDeM=;
 b=uW6cgXgpOmvA5JClorBBRt1pxr/F7Noul7xyaqDGZNLMB8esq4BW+BmwX0gDHjcF4tKEFWpzngYubvKsLfgTYV2rc/O6yQoVHMroZ5XQRDewoH48MAG9YHhVmLLT9dUq/BfhvqRukzEXKJkIs9zte54G8zHPhVYRJ3Wmro5gZ4GuAlFWIbS8h0dgGzcIxZVNPP/KN5U6OeoCM3ICVLzZ6o6BJ9Z7dEXHBGbUcHP2GCmYTbM/sIfsWnNxINsx5VrMXCLNz69j81MfEdvX+4XUZ5FjpER8N7Od8FUQ/ZxlXyNPapbJqysshHbHDEJLoTvEyDxRhJCC4jRknBljnzYv/A==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by SA1PR11MB7037.namprd11.prod.outlook.com (2603:10b6:806:2ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 08:52:30 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%5]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 08:52:30 +0000
From: <Rengarajan.S@microchip.com>
To: <andrew@lunn.ch>
CC: <Bryan.Whitehead@microchip.com>, <davem@davemloft.net>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <edumazet@google.com>,
	<UNGLinuxDriver@microchip.com>, <kuba@kernel.org>
Subject: Re: [PATCH net-next v1] net: microchip: lan743x: Reduce PTP timeout
 on HW failure
Thread-Topic: [PATCH net-next v1] net: microchip: lan743x: Reduce PTP timeout
 on HW failure
Thread-Index: AQHanE48IjDVpWCLoE6R/bGC9BNUe7GLBGKAgAIN7AA=
Date: Wed, 8 May 2024 08:52:30 +0000
Message-ID: <5ee0e9beb684dcf0b19b5c0698deea033cfff588.camel@microchip.com>
References: <20240502050300.38689-1-rengarajan.s@microchip.com>
	 <01145749-30a7-47a3-a5e6-03f4d0ee1264@lunn.ch>
In-Reply-To: <01145749-30a7-47a3-a5e6-03f4d0ee1264@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|SA1PR11MB7037:EE_
x-ms-office365-filtering-correlation-id: f501c0fb-be5c-44ef-8a35-08dc6f3c319e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RkZZdVUrV2dLY3BQV1NRS2dzaFdlMVptVHZUbHZGaFlrU1dTUTdSbVRFM0dk?=
 =?utf-8?B?bzY3TFZmODVmWnRucVpZbE1aS0NaeWRNdmJwQkR6V3RIS2tEZnRYM21IdG9m?=
 =?utf-8?B?Mm52ZTNwVEFIQjdUMGhxaVhiU2hGUVJmOUR1Z3RKRFhpRHVCZDZPaWM3UGts?=
 =?utf-8?B?Mktrand6ZFNpL0ZCQnZyK1ZEWWdEWWpxNHNFZ2hEUmU4RWJTTmZHWXhmT2ZD?=
 =?utf-8?B?TUdRelRvcllXMlpYanlPbFRwTFhkdDlJN3ErbVM0a0RUV1FZalVYNnNhdmNh?=
 =?utf-8?B?Q08vL0RtZjRSU1ZhZWJCZzdiNUVZYVEwWDJZVlhCQ0c5azNzaVNMdVhVMzA0?=
 =?utf-8?B?NnNtUkNJeHRhbWgzM0tWVG1XYVRVMnFabzdIYys2MUp2bVZtZ0pQZXB2NmpQ?=
 =?utf-8?B?UWZFTU1zMGtqYW1RQ202a1dsb2M2RUVQUDdFTzhvZXRXcWtaMXJGak1jU3JP?=
 =?utf-8?B?dXdrbU80Q3g3ZndOa3B0VVc5bGdMK0tUdjI5MFJubDBCVlAwa3FCcXdVR1Vt?=
 =?utf-8?B?RWFqVFNqOVBrZFpLVXpiY0dWbHVEV2dVWXc4TkljUURpSzFRVzFlbS92Uk9z?=
 =?utf-8?B?TTB6dnQyM1BhNDZ6andZUzdQTnd6K2IwU2NPZkJENXhCb3ZLWElsbEg5dE5G?=
 =?utf-8?B?ZWxtYkk0OTFuQkNqL1ZQcUFRejZDVUhRNEdJZjN3K0RsSk1WS0RJT0g0djB6?=
 =?utf-8?B?WC8rV0Zyb0tkY2dmTW50YW1pLys5UGM4NU56VlJKdGZMRC9IdHpYRzd5QXFi?=
 =?utf-8?B?SHdFa283WVpYTDdIZXRkYU43MW1OMEF4anpEVklVWVdDTFhnekhtSlVBUGlm?=
 =?utf-8?B?U3FlL3NpU29GMDVYcVhFQ3hJMWZDM0grV0kyWG5TN0djUCsra0grMHVSd295?=
 =?utf-8?B?TzlpalB3ZEJ3bnQrU2FpM3dCb0kxOXVOWTRqY2UxSVpDU1djR1Y4M2tNRkx3?=
 =?utf-8?B?NmlmekZxZGhQWWgydVN6T3FwTFhtNWxpM0UzNEM4NzdublRCcHl0ellMUEJ2?=
 =?utf-8?B?NE9nWk4rV3ZXUC9VeWY3dTlkSkc5WDdNQzRzN0xhV1Y5bEdKdjlxN2lGYTA3?=
 =?utf-8?B?dlROWTJnVHlQTkMvZnd6MlFuU3ZaUGtxcmxrZEdkVi9sUTJ5dnBjNVJQVUpV?=
 =?utf-8?B?Z1RUNVBNMTFlLy9pSFFtRTR5NmZQSThtejYxNXpLTFhjUUN1c04xZHFpTzZu?=
 =?utf-8?B?bWhwbFQ5VnlWY1FDMmd4cnZHbWRpYkUyeTkvM2tyMzkwUFFpVElnUWd1aitH?=
 =?utf-8?B?eVJ4YVVONjBhSmNRRnNoTHZMNUIxb2tHWnpQWTRNazY5c05VVjM0TVRhb1Mz?=
 =?utf-8?B?ZFZUSUtTT2Naa05SdFdXamJsN3VZYzZ5amIrN0JqbnQzZUNpcDZFdU80NFhx?=
 =?utf-8?B?RDg2M3dFVFhSZlE5ZVdYbUxDS3djTi85NlBndkZUTUxvUm9qNHYwRkJlZVR0?=
 =?utf-8?B?bTh5S0p2TDQ4R0NuMnY5VDJGcUIybmM3a2c0YXF6NUl3SjIwamRycHJVYmdQ?=
 =?utf-8?B?VUtBRjdJUzFZSDNBc0FubkU5S280TkN5MjRKVWFqWWpHamtaZXM0YjZpY0xx?=
 =?utf-8?B?MStXeXM1eGxOL1BZeEcrb1MxV082RjZJcVAvTlRzZ2pNRllwckc5WFcvOWZs?=
 =?utf-8?B?dWZrMW5tTlJDQ2k1d2dUZXQzb2pHK1lxSFdPOXh2UWRZMGJOZGJDLzA5NW16?=
 =?utf-8?B?U0dRaS83Y2VPZUYvUWFiY0dkQzhJNno0MFBSSUNZQ1NSWWwwMzZXdER1dUJ3?=
 =?utf-8?B?ZWVyK0lvQmtWWERPaElXT3Y4b0dDeE1KTnZyVFI5YWYvTktMVlVtZWRsbXpV?=
 =?utf-8?B?c2h6RFYyZlpQdnZxWWEwdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azdteTJFRzZuTFIvZ2Q1M0t6ZXN0WG16ZjlmTElndmFrRkQ1UGUzWm4vU2ZF?=
 =?utf-8?B?T2FKa09iazdyak9CcE9jLytIekp3SWpmM2hoNFJncmNvL2owNXRIbUxJcHdI?=
 =?utf-8?B?ZG51NUlxdFVzYnNoLzBhZUZJa3BOd1R0aGVFKzA1N1FHQm83U3Y5N294bVJL?=
 =?utf-8?B?ZTh1KzBRd01GWmJjN2hYS0w5bGxFcGZUNlZEVkkyeGQyVWZhSUlwMDE5dU1n?=
 =?utf-8?B?enN2Qkk3aTR0SU1QZ2d0eFZDY3J1Wk4xUUp4b2grTzcxSDVOQXNqTCsyWjk2?=
 =?utf-8?B?eWowT0VCY0ZTZmlWZFNQWG83N2V2UmxPWTlrVDV0cHhRa1ZBNVBmWTNISjFu?=
 =?utf-8?B?aWtNV05FUTc4THMwODVBU0lGaC83Q0dYOWVhRkF5L0VMeE8yVi9nZ0k4YmdH?=
 =?utf-8?B?QU9lTXN1QlZwcngzV0FSb0FXNmxBNU1qWjlIam5qcEhqUk1CaUY5dzV3RmpF?=
 =?utf-8?B?TGx2c01pSDBLY1hMYUtzTHZYaWE3djVXMmZWZ3huSElhV2tGaGI3SzYzaFJu?=
 =?utf-8?B?SWkrVFNacTcvaVY3SDFMUmptcEdPMk5JTWtzZGgySHdsS1hkbWRaTUhDUW1q?=
 =?utf-8?B?ZzhGUWUyc0w3UUwxZjJidjVoNkJybFhFNTROZmpJMFhDaXFlMStJd01xMlYz?=
 =?utf-8?B?dXY1KzNjWjd6V2YrRTgrMGxVN0hsWHN5OEJqV0RQdGdOempDa0F4M1F2M0dS?=
 =?utf-8?B?YnFHOEtCdktmV01UK091ZXkzOUlaZ08yWmtmTG55OUk2RG1vMkVvNWQ4VXBx?=
 =?utf-8?B?UWNWTGptOG5oMEprL2xndHJ5RGJsK1hqSDJxdnNDQ2s0R0hqUGFKMk1wWjJX?=
 =?utf-8?B?bC85ZG1ia1JSWU11UE01V1d0ZXcwd0NtWGVIYWpGL2phM2pqQXhJZ3NaT1Yz?=
 =?utf-8?B?RVQ2emFrVDNtZ0dQWlJzNmF1YU8vWExXelVZcDFwckM3NEo0NmVYbEdTODUr?=
 =?utf-8?B?ejJhWFFEb09mSkYwSVZCT1NnOXBnZ245TXJ0dDJjV0NQVXA2ZHNYdDZVQzJW?=
 =?utf-8?B?b3FoS2cwYnRzbDFoRDNpQ210V005NjE3NDFwR2h1ck1Ec3FLOEw4K0lYQmRE?=
 =?utf-8?B?MWdJQnIySC9na1RRUjlTV043cTZHYVNLYTFNQnBBZDVDeWZZNUJvQThzQndO?=
 =?utf-8?B?cFNlSXdsRzZXak13cVFtQSthN0NpNDlaazcwYzlCVGRaNDhoRW9oa0FvUzZM?=
 =?utf-8?B?b0hod0hWVHFkb0VGYUNpcEpDUDY1N1JZenNZWVFzaUdoT2k4UWE4Z0tDeWhm?=
 =?utf-8?B?dnNOT3dVdDJqN0llOUJySUxrMm9xQUpIQ2xWeTZSTjhzK0ltS3BrMTQ1RXUv?=
 =?utf-8?B?ckEwbDNEVytkVng5RGVKYjZKaHIrYjRJV3hHZDJnWUtkejNzN0hHNVA4UkE3?=
 =?utf-8?B?SGdDN0dhRGhUR0xzM0pDencyK1lxRXBObUdPQk1JRmtJalVaSlNQYmFkUDVJ?=
 =?utf-8?B?bXF4MUpUNVVJeGUyWWZqbnhGWGJrcDJoOUhycklud242dDgrWmxDWEMrNC8w?=
 =?utf-8?B?RG9HOHRhQTRtMWw1ekFEL3lFRGxnU2JYWWIrdmhDd21JVis1bG1kcDNidTRl?=
 =?utf-8?B?c2JxY0VNYXVxNVI4V3YxM3BkSS81ckFsMThOS3hLRnlZQXVjU2lqTVZvUC9H?=
 =?utf-8?B?c1hiTHFrUTBIN1lKTEFlRWM1YmtUVjg3enp3SlhiVE9SS3MvanFIMk5xbzh5?=
 =?utf-8?B?alB6RnRZTVZiRkIwQ0s3dGdYOEpjMVhXVU44TDdyRGJxVzlCRmxWQVdXQW5M?=
 =?utf-8?B?eEN6VWlFd2JMd3dwMGRMcm0vdWJQWkVVYTRtMHVDZ3E1TWpEN0M4M01UdWRl?=
 =?utf-8?B?Mm5BMkFHRUk1Ri84cE5KY2NhNzVqRExPbWEwTFJxQzNObnNDRldjcksreDJs?=
 =?utf-8?B?SmZvNWdyNEhaaVBtOUd1S3dCeTRxblBjbHFqd2ptWnEyNkJaQktSMXJpbEkv?=
 =?utf-8?B?SFFtMURFOEF3NkIrV2c1Znd1Yk83d05EWC9aMVZJNDZLQU14S0UyNmpZeFda?=
 =?utf-8?B?aXhBUHFLaWd0bHk4NElqUmF6V0hsYzZmTVkxY250QlZiWGxwOFVaSnRWN0l3?=
 =?utf-8?B?UzhXVHNqWjgxdHZsRnU5S2M4ZWZRSjhVWTIvUk1vSFpFUFlQWmlOMEZLTVZI?=
 =?utf-8?B?Mkh1b0hLK0FVc3huQTA1RXpEd3pPL1M3a0FteGNyR2MzdFlaMkxjTFdtQUg0?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC97FEC4BAE7414DA6221F1FB33DB2EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f501c0fb-be5c-44ef-8a35-08dc6f3c319e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 08:52:30.0686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iKwYaM1qS/QIpVds+nJQZD17Qosl1GG4QlILs1e/lXXRHSmg46IIWncJ8rxbX5jktGW62/jGQpJYznb/CNnHCq5GL0651GCQrXvc0ZSNyWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7037

T24gVHVlLCAyMDI0LTA1LTA3IGF0IDAzOjMzICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIE1heSAw
MiwgMjAyNCBhdCAxMDozMzowMEFNICswNTMwLCBSZW5nYXJhamFuIFMgd3JvdGU6DQo+ID4gVGhl
IFBUUF9DTURfQ1RMIGlzIGEgc2VsZiBjbGVhcmluZyByZWdpc3RlciB3aGljaCBjb250cm9scyB0
aGUgUFRQDQo+ID4gY2xvY2sNCj4gPiB2YWx1ZXMuIEluIHRoZSBjdXJyZW50IGltcGxlbWVudGF0
aW9uIGRyaXZlciB3YWl0cyBmb3IgYSBkdXJhdGlvbg0KPiA+IG9mIDIwDQo+ID4gc2VjIGluIGNh
c2Ugb2YgSFcgZmFpbHVyZSB0byBjbGVhciB0aGUgUFRQX0NNRF9DVEwgcmVnaXN0ZXIgYml0Lg0K
PiA+IFRoaXMNCj4gPiB0aW1lb3V0IG9mIDIwIHNlYyBpcyB2ZXJ5IGxvbmcgdG8gcmVjb2duaXpl
IGEgSFcgZmFpbHVyZSwgYXMgaXQgaXMNCj4gPiB0eXBpY2FsbHkgY2xlYXJlZCBpbiBvbmUgY2xv
Y2soPDE2bnMpLiBIZW5jZSByZWR1Y2luZyB0aGUgdGltZW91dA0KPiA+IHRvIDEgc2VjDQo+ID4g
d291bGQgYmUgc3VmZmljaWVudCB0byBjb25jbHVkZSBpZiB0aGVyZSBpcyBhbnkgSFcgZmFpbHVy
ZQ0KPiA+IG9ic2VydmVkLiBUaGUNCj4gPiB1c2xlZXBfcmFuZ2Ugd2lsbCBzbGVlcCBzb21ld2hl
cmUgYmV0d2VlbiAxIG1zZWMgdG8gMjAgbXNlYyBmb3INCj4gPiBlYWNoDQo+ID4gaXRlcmF0aW9u
LiBCeSBzZXR0aW5nIHRoZSBQVFBfQ01EX0NUTF9USU1FT1VUX0NOVCB0byA1MCB0aGUgbWF4DQo+
ID4gdGltZW91dA0KPiA+IGlzIGV4dGVuZGVkIHRvIDEgc2VjLg0KPiANCj4gVGhpcyBwYXRjaCBo
YXMgYWxyZWFkeSBiZWVuIG1lcmdlZCwgc28gdGhpcyBpcyBqdXN0IGZvciBteQ0KPiBjdXJpb3Np
dHkuIFRoZSBoYXJkd2FyZSBpcyBkZWFkLiBEb2VzIGl0IHJlYWxseSBtYXR0ZXIgaWYgd2Ugd2Fp
dCAxcw0KPiBvciAyMCBzZWNvbmRzLiBJdCBpcyBzdGlsbCBkZWFkPyBUaGlzIGlzIGEgdm9pZCBm
dW5jdGlvbi4gT3RoZXIgdGhhbg0KPiByZXBvcnRpbmcgdGhhdCB0aGUgaGFyZHdhcmUgaXMgZGVh
ZCwgbm90aGluZyBpcyBkb25lLiBTbyB0aGlzIGNoYW5nZQ0KPiBzZWVtcyBwb2ludGxlc3M/DQo+
IA0KPiDCoMKgwqDCoMKgwqDCoCBBbmRyZXcNCg0KSGkgQW5kcmV3LCBiYXNlZCBvbiB0aGUgY3Vz
dG9tZXIgZXhwZXJpZW5jZSB0aGV5IGZlbHQgdGhhdCB0aGVyZSBtaWdodA0KYmUgY2FzZXMgd2hl
cmUgdGhlIDIwLXNlYyBkZWxheSBjYW4gY2F1c2UgdGhlIGlzc3VlKHJlcG9ydGluZyB0aGUgSFcg
dG8NCmJlIGRlYWQpLiBGb3IgYm9hcmRzIHdpdGggZGVmZWN0cy9mYWlsdXJlIG9uIGZldyBvY2Nh
c2lvbnMgaXQgd2FzIGZvdW5kDQp0aGF0IHJlc2V0dGluZyB0aGUgY2hpcCBjYW4gbGVhZCB0byBz
dWNjZXNzZnVsIHJlc29sdXRpb247IGhvd2V2ZXIsDQpzaW5jZSB3ZSBuZWVkIHRvIHdhaXQgZm9y
IDIwIHNlYyBmb3IgY2hpcCByZXNldCwgd2UgZm91bmQgdGhhdCByZWR1Y2luZw0KdGhlIHRpbWVv
dXQgdG8gMSBzZWMgd291bGQgYmUgb3B0aW1hbC4NCg==

