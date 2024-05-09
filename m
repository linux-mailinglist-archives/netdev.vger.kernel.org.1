Return-Path: <netdev+bounces-94913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A2F8C1013
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E1828409A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788E314BF90;
	Thu,  9 May 2024 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tjPMtRV7";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XjK8Xo/R"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4A11474DF;
	Thu,  9 May 2024 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715259908; cv=fail; b=VNc/u/FnAndWOcKIbXoE2J36RLnWYJNUvVGVubVamsUF+EbfCwqIMkgkqxXMFkHWHDjx7r/wMXkEeGdlj7F1eoAW02HD0veCOIGNEJ3K+LvHBUOVR60fHCqU4THCceFTALfifbVwmF7AOnsjJ1VhEAvYE6MIdFjogF4MxdtKkng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715259908; c=relaxed/simple;
	bh=9ai78xD0vWvoiE4YsiSWIO23h6G1WQ1tyfVEX4F5TsM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nKH2de1zD+M1ZlYJYU4/zLJJ5aEOwXzNbM7LF+qIN5iqp9IRMJaM0HFUC+Br8yRxShdgYOryfsihPdEfNqL4a6hEeQJ63Oas7ho0U0sIimpkgSmtaDzixJ+Sh+dAss0i60qmLIMZ2CRK1v7GgUqs0WGJkwMaWSVX1k0l/AWbOWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tjPMtRV7; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XjK8Xo/R; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715259906; x=1746795906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9ai78xD0vWvoiE4YsiSWIO23h6G1WQ1tyfVEX4F5TsM=;
  b=tjPMtRV77jZ6Fvj96qaBCw8t4xRTyWjF9GKO7vvNR7Zk9eFmXRuaM7pC
   GwqJgL7mJvhuKN4FX6We9yl57FWgoDzBkX7TyA1z0bnHdvO5+0hqSLjSf
   qhLlWGZcr+mQ6L9L8iGuzAWCzK/YJAh988u7/PiV06L6ZFNU7842PwdVs
   8rfBAjSyufacTIxsCg24x24HOjHGOd6oWIrI3HI7JkAJoS6EoI8naskyR
   jNO5ssY2JtJVCRWT7GmS0oiIsKPdL+g5KYu47g/qharPAzHmlfAkUsk6i
   Q25MJkB+lhZnDslhQqwdf3J1kH+6Rz0ZL+h8OLBj6eMbBQaqTQt0u4ejg
   A==;
X-CSE-ConnectionGUID: NqNpd8CbSZKuA6Eii+8kKA==
X-CSE-MsgGUID: xGNUA2t7RReu2+yWjU8i6w==
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="191640020"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2024 06:05:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 06:04:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 06:04:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFIQlRUIGpIFIfAvNJP472XEMkA1/5q6ZuCUyiqSMDGtQ6/c01SGna7g97crlfJBpH94qkyAvwz+S8irMYRYZ8AeUAcqfbk0e2gWYiFIYqbcoKL8NbBouEnFvoTsrdNAvg5iq+f7z9QxIHBkskrFo2kWA+7k1ZQi3/5BuXd2QDR0j3JACHEIzTMXC95NEwhLVVJ0rr3T2YETvIwQoX6mn3ga3QyH+DXkoA7d9RYsw7/HcSHljjY/wyKqvHuCXNha5G0LArzwEfHz/8BgQXn7UmaDakMnXSmkPTNezcdhhYrL98P66GfL6jNeZ+SFdYqWwqx2V7YUGWD8VvFT9uAr9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ai78xD0vWvoiE4YsiSWIO23h6G1WQ1tyfVEX4F5TsM=;
 b=WSxxeb/rLWW4uhUtNkw7tboDJi2/D+zLVKlNcsmL+IDMhmnW3daaMMnengpIbGel1F2lcQkka6lGyT81tBpKEEtlR4i8aMjx2fhcJ090l5OZtv3I2E5ngMkf7Y8vMSQkObRRZI0qu0opJQ4fCzq+2+BtWsWulBGQ0X3Ep25z3YnCQcMIqfZtOgEVwNA42Xm7D26ZV2nk+DeckQZW7659ndDys97DyJmAPfUzZf1D52LPxgL9FV+egHUWS/lLJphZgSeU+ezsTHrkBBGYo5i/YzAOf/UFhJWvVh8/nlGPuEST8Xq8g1k855P3NPcGiIKUbLvbB47TdGo8vo2N0lUkyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ai78xD0vWvoiE4YsiSWIO23h6G1WQ1tyfVEX4F5TsM=;
 b=XjK8Xo/RJZh58CZaLuuF2dZDiE39E6YvZLVZHfFsL3bEVA6G/0xz7kUxJydC8yPM7otvflmSwCRET28jczv3Y6EN7uK4LcP6WDssMBKCMeOCo/mdXZ8L+P57eZ0+b9QVn/9zFn5UsjrXwMwHHMV5ksVfzql9/leGoU+uRsmc1ZZXnYy3JR4gG8cAif3WlLtPVk0v2yeId9MwsdK0jA6JO7XILnNIYvGqMGjLQlYcm/05DsF6Yh956xrsCvUlSXn3eTk+R2N1IsOif9jVGRqRfqs819eIruUkSJO/p+/E+Aw8Mnd+P92BcFTeMMV+s1DiU0KCPCjJwRs6DOAwkI1RcA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by IA0PR11MB7403.namprd11.prod.outlook.com (2603:10b6:208:431::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 13:04:52 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 13:04:52 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Topic: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: AQHakY/2Zb5TFJZ12UCHjfgce9+PGrF0voeAgAA2YoCAGHimAIAAQu0AgAFPUYA=
Date: Thu, 9 May 2024 13:04:52 +0000
Message-ID: <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <5f73edc0-1a25-4d03-be21-5b1aa9e933b2@lunn.ch>
 <32160a96-c031-4e5a-bf32-fd5d4dee727e@lunn.ch>
 <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>
 <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
In-Reply-To: <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|IA0PR11MB7403:EE_
x-ms-office365-filtering-correlation-id: 2ab92102-b8df-431c-9c2a-08dc70289d8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?d01PQjdna2RwajNXRkYxRFd0QmI3c3JFOFdHbURiVEZWcGRVVEZlbXhOcnVv?=
 =?utf-8?B?WGZhL0ZiTi96Y0tYOWlrYVN0bW5xYUhTTVpSczcveXV3UlU1RjhuMWhidGt6?=
 =?utf-8?B?aFBXNHJjNlJWbk9aVjlLUjdBME5CblpQWVhaM3VpYW81dEcvVFFEZ3FPRUow?=
 =?utf-8?B?Tm94YXhPdXdrMlpBRXd6ODd3Qy9rU3NwWklqSEo0bXRHL2xtUUM3ajB2Rnls?=
 =?utf-8?B?TlljelRvbE1jWmduL0NVT1YwSWE0VmJGVTRhb2h2N3FxeWZxWU1HQzBEQ2Mr?=
 =?utf-8?B?ZEp0OFNPY2xsVGNYcHZFTTE5djZPZHJYNEJ0YnRHbk9nV2NPK3pSNmw3TFcv?=
 =?utf-8?B?NXM3bEFCTjJWa2Y1Ykg5REFFeUhVYkpFVnhxM0FaVlZJcTZyUTl4dXBsVmJF?=
 =?utf-8?B?ZWRUZGxPa0RGYnFUK0NPNmoxdnJ1NEhCK2FjRkJNNG1PQ0dnL1ROTFVDc1VE?=
 =?utf-8?B?YVNSOERsVFJYWllVQ2lKeUw1R011cEQ3S3ZmbXNtZmZYaW5DaHpmVHVpVWpW?=
 =?utf-8?B?bU9JODF6U01aaXY0SjJDZmZLaElLTkRsaTUxWGY1MGNNZk9MWWhIdEl4eWta?=
 =?utf-8?B?YU1DV3pnSFY5Mys5TWwzVitxc2xLQ25mSUZsL0tMNXpKTmdqM1B2Y1ZYWXh3?=
 =?utf-8?B?MUpIVnJPdVRXaXJrUFRTSVpPcFkveGIveENFQnlVL0E0ZjQ2ckFRNGlFbVkz?=
 =?utf-8?B?VU4zcVhNWUNzRlY5dFEvZFlyS3IrZk9qdUhRbVVYRGFkNlFGdE5VVUp4N0Ux?=
 =?utf-8?B?eDdJc0kybFU1eHVGbXBybTMvY0NiVXlET2tHdUJ5cW9YcWVvVCtoMTJHSmdY?=
 =?utf-8?B?M3pnb09KNHN1Sjl0L0ozZ043eTRrT2pJa2hUakhwMVpEUnhRTEc1OVc0T3FI?=
 =?utf-8?B?YUJZcTlRSEhadnllaHRVNlhCTnhDZ0pNQVpQZlRBZkV6emJWSzVONTZ1ME5X?=
 =?utf-8?B?TThRVklTMDRJYi8zL3kzSk52blhUbk5GSDBqdmU3dVFsZnJjZmhBUFBsS0VW?=
 =?utf-8?B?aHp3NUFSckh2czNoYUgrTktHdThHVXYrSWNmUksrWHZXdktqVmNCeUtCTHVo?=
 =?utf-8?B?TnJJZURwM1ZMU3NiYmlFSm1ZbWJqQ3VoK3B6OE4ySDY0UXAzZUFqV3o4TnVq?=
 =?utf-8?B?NnNHaFBSRGM2bi9nWVhFRXFVZ0E5SkcydkhCSXIyREp1RkRXeWZGMy9ObmxB?=
 =?utf-8?B?dzR5Q3ZZeVgzeEFLaDI3YTBsL3N3OVVoTURJdVZaSHZGc05KZUptV2h6ekxZ?=
 =?utf-8?B?eGQ3UDZKd1JpZEpnemU4bVR0dGxxOUl1TCtScDh1VXJFTEZ2ZTRTRjFoV0tx?=
 =?utf-8?B?MktIUk5RNlU3cWlZN1R0UUsvSjdPK3lPdlY3bzQ4TUtBTHZuYmJjNGhSUmoz?=
 =?utf-8?B?RzBlUU8zSDhKRWtwL251b1hxeno4anVQb00rVjRrM01jSnZPWEh0THkyQkk4?=
 =?utf-8?B?VjhXT0VxYW1odDEvazRQVWxRZ1JXMDl4T3BpM1RHUzAwTkNxVjAwUGZXa3Qw?=
 =?utf-8?B?OWU1M3A1eFJoM1RzNHdSK3dvdDlIbHphTGh1UVVET2JjR0gzRXgrd2pYZWli?=
 =?utf-8?B?UXlnMktJVFVtdHBvTkx0anVQSHlCdUVvVER4T2pNSElud0UrU2I5YWNPVnBr?=
 =?utf-8?B?dHJBRHFMYkVKK2hNN1VpcVZVdFJxcngzU0t5OVNRN3hkNloxcmxzbTlNZzU4?=
 =?utf-8?B?VVNZSSsrMnlXRUdoQzI1UlBRWUtvZVVYcU50WTN0WEk1QjBJQUJBWjI4SDJy?=
 =?utf-8?B?L21Fd0dDVUhDNE15d2Z4b0o4cENVVmZPT2lEUDROY2U2RkFiUWtjdW8zK0E1?=
 =?utf-8?B?YmZ6Wk04WVd2YktrQmMxdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlVkNy9oN3RLOTV5MjBRWXZjWE9VY3ZVMjlwTStJSzd3b01oclNXenRiS0NG?=
 =?utf-8?B?L0F0MHBBcG9zS3Q1V01DTW9EZWwwQjNjWnJKbXV6SkxNSkx5cXBwclZ1Mkp2?=
 =?utf-8?B?TjdnbGdTOEpGbHlzVUsxK1hEL3orbkMvZ3M4d2oxaUo2MWJIL1VqcTY1bUoz?=
 =?utf-8?B?TGIwMXp5SU9TNktZbzZNaVRjdmNsV05zaHVkc2FyTlVicXRyVEUzYnZxK1c0?=
 =?utf-8?B?NC8wQUxWSEJSVXF1cHJ4V2NXWVY4ZWk2bGxrZmxtMDZFSE9aQVQ1WXBYeVRa?=
 =?utf-8?B?bndBZ3l6enA4MVV4c0J3bTNNOG1Idm40M1lHS2VsYVlZQVJReFgrYnkrcEd0?=
 =?utf-8?B?RjQ4MEtwN2ZjbFo5VHFKbGJ6L2JDWlhFV3NTWXZKWFB1Z1pqRUxocWdCeFd0?=
 =?utf-8?B?QXBOdjdSeTRSUjV0NHVrdm84czNPb3VITkR6amZXYW1OUDVJQXpINFd2RFJF?=
 =?utf-8?B?bUtQVWQ3RStaQUt0U1dmWGwrTDJwSDB0RU0vNGJPVkJYQVNKUm41M1BoS21t?=
 =?utf-8?B?UlZSUCtNREVUSGJkS2JFU1ZFL3RmMXl4WkNDUXNEZE1BamUveUVKRWZ4QkFI?=
 =?utf-8?B?Qmp4TjVaR1JCWE9UVjNIaytEd0lLdStNTmhvVFJyT3VqSjNCQms1OW1rSTNX?=
 =?utf-8?B?ODBVSDFjdE1aTW51RzNoR3JkMjY2VmdnQVRvazJ5ZmtKUzRTOVRkam4xQVRW?=
 =?utf-8?B?enpub3cySDZMMjJZQTNiNjRCZ0hmT2NjbHZaK1hPd2xmOHg5Rk50L2Z4YW9V?=
 =?utf-8?B?VFRFWlFlcWJWOE9xRUhvSTJvSlpwaFpYM3hKem9jRW5uY2FVd1pBUkdFeXgz?=
 =?utf-8?B?UkRnc0VWQnhTV3VuN2kzNGVpV1h4aDZ1R2ROU2tTVFRzeTFCeEFEOGJHcXpu?=
 =?utf-8?B?MThjZ29NR2ppOE9kbnV6R05WdDlLbUI1MDh4VCsvSnBpYWtHZE84Qzl1UVph?=
 =?utf-8?B?aDE0UFU5Q1pFY2xBNDUxL0xqQ3l1ek9uT2lueW1Sd0hscUhZVjFGVW51V1ha?=
 =?utf-8?B?M1FXdzM0c3hVSlhpZ01TajVkL0E3SjVQbnJoUlBwQWVnT25LZzNkQ1ZVL1Bo?=
 =?utf-8?B?UUVSbnpQWUFIbHVXbEluZ2NJRk5HcHkrclNIRjQ3SU9kVnVFQSs3cTZ0L3Y1?=
 =?utf-8?B?V1R2cWlRT1lBQm5zbXgxUW1Wa014L3NaVGRBYlJtRDgyY1J1NEVucGJmN1Ni?=
 =?utf-8?B?bHh1d1M0aTFUREdmTHlZUVBQaWJCVVl1dnRMYkhRZGdsVlN2SzhPNTRNcVdP?=
 =?utf-8?B?azcrTEJEMzFXMXBxMUxjb0xoUUd4WGtKOTlQYTJwVnA1OXdtVXRVZWw3QldO?=
 =?utf-8?B?ZHY5MU5oUkdkODUyeTBtYkUvTjVublMvRXltZUZOcHhPR0Y0VFB3T0ZTZUlU?=
 =?utf-8?B?Tk5tZmh3WEFuRzZFeHhmNzQ0Z1VHUndlRUxndGNIRk52VlBqM3Zzd0tUWUg0?=
 =?utf-8?B?SEVKeEdSdHZWREdiVnBsUTVYMW4vS2RSWnJFUS9CeGpFUkMvZHRBWkM5dzNS?=
 =?utf-8?B?RXF4VUhxLzdaVXE0Q3RNZXhFYS9oc1JCcXRZa0Q1bzFldlhSLzZjbXRFaG44?=
 =?utf-8?B?M3RMdUp5WUNMRlF4bHQ4T2FQOHNyZmRpR2s1UzM0VzJYa3BXNzZ4YjB6d2hr?=
 =?utf-8?B?ZUZVYjZaVi9tTi9EZjJzL05UMXdra0QrVGJxQzFtUS9MSjdDYnZlSXd0b2Uv?=
 =?utf-8?B?RThDNEZkd0dyS3Z3b1ZxNGJKejFlb1B1bjVlWVhWL2NxMWt0dFZPMDNoOWhn?=
 =?utf-8?B?Q0NPMGVVTGpwNnJZTVlKMGowVTFMNE9pcjRkVGhpcVNnbk8rR0dIODZzM0Vh?=
 =?utf-8?B?OE9JMk5KT2hZS3NpQTViSkNWRFNTbERFYjFoOFZSS3lieTlQTmlnRjhpalg1?=
 =?utf-8?B?a0kyMkxKWFN5TEtpL0J6VUladkY2cEwrT250eVJzdENNdW41RU9USEZRdTA2?=
 =?utf-8?B?Z1lZL3VmRkVoaU1oOUFFY1RHQzVYRkVUSGVZRnZ3OGl3Y21DOE1MRkFsV083?=
 =?utf-8?B?U0tLeWs3TTNFZkVnZmd0MHBFd2pLOGNiUGU1K2k0Y255OE1BR2pDZEhSbko2?=
 =?utf-8?B?emN6YWpKYmtWRDd6em9iUVJCMnJ0TkZMdThmOE01aUVMeFNmSFV1OWRIbEY1?=
 =?utf-8?B?YTRiVG5oT1RSTzZYNHpCMUp4ZzV3NmFhZTB1YWp2OUdzd2JBKzVUdEJBYUNH?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <985594FB61BD104AAA0322974F21C004@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab92102-b8df-431c-9c2a-08dc70289d8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 13:04:52.3800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5CsKFy3ZTyOuEflNigKzPSwKbPEmoLhBqx8Q2dfUAdXwqL8aYpPreYjkHg8sWxi7JHYZbf76w0OBkEHI7DHtcdeXx12wyZMdaeilDWP8UAv+kLs4GkJKbWvVHRwX3xR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7403

SGkgQW5kcmV3LA0KDQpPbiAwOC8wNS8yNCAxMDozNCBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+IFllcy4gSSB0cmllZCB0
aGlzIHRlc3QuIEl0IHdvcmtzIGFzIGV4cGVjdGVkLg0KPiANCj4+ICAgICBFYWNoIExBTjg2NTEg
cmVjZWl2ZWQgYXBwcm94aW1hdGVseSAzTWJwcyB3aXRoIGxvdCBvZiAiUmVjZWl2ZSBidWZmZXIN
Cj4+IG92ZXJmbG93IGVycm9yIi4gSSB0aGluayBpdCBpcyBleHBlY3RlZCBhcyB0aGUgc2luZ2xl
IFNQSSBtYXN0ZXIgaGFzIHRvDQo+PiBzZXJ2ZSBib3RoIExBTjg2NTEgYXQgdGhlIHNhbWUgdGlt
ZSBhbmQgYm90aCBMQU44NjUxIHdpbGwgYmUgcmVjZWl2aW5nDQo+PiAxME1icHMgb24gZWFjaC4N
Cj4gDQo+IFRoYW5rcyBmb3IgdGVzdGluZyB0aGlzLg0KPiANCj4gVGhpcyBhbHNvIHNob3dzIHRo
ZSAiUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3IiIG5lZWRzIHRvIGdvIGF3YXkuDQo+IEVp
dGhlciB3ZSBkb24ndCBjYXJlIGF0IGFsbCwgYW5kIHNob3VsZCBub3QgZW5hYmxlIHRoZSBpbnRl
cnJ1cHQsIG9yDQo+IHdlIGRvIGNhcmUgYW5kIHNob3VsZCBpbmNyZW1lbnQgYSBjb3VudGVyLg0K
VGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLiBJIHRoaW5rLCBJIHdvdWxkIGdvIGZvciB5b3VyIDJu
ZCBwcm9wb3NhbCANCmJlY2F1c2UgaGF2aW5nICJSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJv
ciIgZW5hYmxlZCB3aWxsIGluZGljYXRlIHRoZSANCmNhdXNlIG9mIHRoZSBwb29yIHBlcmZvcm1h
bmNlLg0KDQpBbHJlYWR5IHdlIGhhdmUsDQp0YzYtPm5ldGRldi0+c3RhdHMucnhfZHJvcHBlZCsr
Ow0KdG8gaW5jcmVtZW50IHRoZSByeCBkcm9wcGVkIGNvdW50ZXIgaW4gY2FzZSBvZiByZWNlaXZl
IGJ1ZmZlciBvdmVyZmxvdy4NCg0KTWF5IGJlIHdlIGNhbiByZW1vdmUgdGhlIHByaW50LA0KbmV0
X2Vycl9yYXRlbGltaXRlZCgiJXM6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yXG4iLCAN
CnRjNi0+bmV0ZGV2LT5uYW1lKTsNCmFzIGl0IG1pZ2h0IGxlYWQgdG8gYWRkaXRpb25hbCBwb29y
IHBlcmZvcm1hbmNlIGJ5IGFkZGluZyBzb21lIGRlbGF5Lg0KDQpDb3VsZCB5b3UgcGxlYXNlIHBy
b3ZpZGUgeW91ciBvcGluaW9uIG9uIHRoaXM/DQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBW
DQo+IA0KPiAgICAgICAgICBBbmRyZXcNCj4gDQoNCg==

