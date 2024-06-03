Return-Path: <netdev+bounces-100068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A728D7BFB
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041441C213FF
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 06:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BB6376E6;
	Mon,  3 Jun 2024 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="teDR8j0W";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="6Cf6+8W0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89215631;
	Mon,  3 Jun 2024 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397757; cv=fail; b=OD21vr5GdHFXFCv2WO5lOV8zqHKRD2iFMxkgfaCtnkuyqEq+tjpiWxhIONpPVE2vwIlfUoGMyr2yRFm1/RFAgHM6o4mPoELhHBgwQa9Z9ydKf7iP1r1DNHbrsUS6VHNbvMOoVrR1wr0a0CDkb2MgOo0K13Q5GwNJCZJu3I5KRFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397757; c=relaxed/simple;
	bh=S6UPoJRsDnk3fzJSOS3MJUA3myfHLGTK9Jnxed6KpYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fl4w9LN+f9dTKIglTUaL2m0qEN5ouhHLpLS4S4BGX7stF89KxVucaxKRRXp97+r/L6hGjOCy4GFCiM0sAEHqfKP4Jo/FEFTP29SGXjGn4B2G+F64Z5EPVPJOQiPp0SVna4RVOVDE2HqZOFi2VP8Q2QzBM2xLHZGB9k9fMP02Ckk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=teDR8j0W; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=6Cf6+8W0; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717397754; x=1748933754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S6UPoJRsDnk3fzJSOS3MJUA3myfHLGTK9Jnxed6KpYo=;
  b=teDR8j0W1sWdJ8Ib/OB63Ss7SvDmvcSdH74IKPFX2545XcK0OuDbNMZK
   UaXsQt49eXLv++pD/1fhvFpcF+/N8GGmEAGVJNMJvjTHMXv00OuSPJtXE
   3YY8tZSiGRVeZfnb8BzjpvigsWB5aGZHcPM8koMnWieldVEiNerdmqiLM
   cBhaN2VF3U3FPWMuJwVaAeavhj4ZHB5uc+mnw5AKkg8s50JfTBshx1O2p
   h35MlrIVqDfABBSJ5a16kokZE/wH0ylm5XvJ46UICZqGdzCBz0iFwJO9x
   RuK6dPtTwXdyzlMhbTm6uPTRvqXiEN5HnDxCFvrgp1xnDfNFJNXl24Pcs
   A==;
X-CSE-ConnectionGUID: vwYDfCPoSvmeNXaW9NtFqA==
X-CSE-MsgGUID: DdGY/p3OSDKTrVFvVA5baQ==
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="29246043"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2024 23:55:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 2 Jun 2024 23:55:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 2 Jun 2024 23:55:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWcRnTlsZqszbMKZF9X0b9Z7Ild8GAcizZ1QjMz/W6tkSyR5wx4MyF2uHDcJMIuAXWscU9lQOHpYcLtLCre2U4fkYSJd848AUdQlNSFPKJzMJwyiEpIu8Q7aBCltTIsQVj/7YT3A1tMcDlaESWv7423ybvRU3qrr8Tapf8sZ7WqT4mgjMe2fPCv/gbV1d1AxjUhhaUqarZXBQeLBIWyyRz6Tzh1K09vkoatH/fNcOHhx7LhDFn8sJVuN8Ub7qq9OWgjxDnwQ6kw36Tzag4/tCEJqsCSLKr2si9WAhxu4enTt+YX8LAlgRFrjBI6YsSBLvbzCEPNVLhTcX8PWA+GcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6UPoJRsDnk3fzJSOS3MJUA3myfHLGTK9Jnxed6KpYo=;
 b=lDvE54efUv8GbddyR/TCMrgBP4GY9nybnq5BHPyhleWkH3BBQflsi+9ce/KAxsrusY3rrkjdJM39F2pdGTTYzDxJCpqJE6m0g6X84xYF1Z7Uq7zqbj0pyn9pNLuf1aV0SzsNtC9FFfFZp6uuxqLfiXUe+JuMZImcYe44ym/atnwRbtfhB+ZJtc6akNYcAD6p68dUZJmN8ZI4kiF1P13HUQf4AMc7geck21xH7n+mpoATlCD//U/jeJfS5ah4UZBs9aIuJIFhos9gd5RovVb9SoWJjeZKg3LIUZWAGRG0tdBsgEncMYBzKVR2Ohzc3sBtaAFoFwjMKTHHndEFspvsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6UPoJRsDnk3fzJSOS3MJUA3myfHLGTK9Jnxed6KpYo=;
 b=6Cf6+8W0sj41gIp1EohIOaumnYpQcFr13UwQE+nbq9+bLsUV4Fi8qQgDGR+XlO1APujlIohncJ8vZKYGr+/Gm6MpUwLzYgV2hdbxyTFYv3PzhDOn0j7fsgTrYy2nOuZx1ztnH+Ekff2uHGu4GwDvWIDZU9nNpr2O1YMAcVqBiW2pVt7duoavamNycJcJiIgJR54Xne+lsqvT5lIBEt3nMDeqVysVCayMoJf6/uFyl5+bAyk18CFF3e/+jZjXVMrXb8jSGR/NXfOfeLq+NH2COxRpWoNyrf5LIYjpEA7YyVk16Bi9bn28BP6bO4mLvyx6I7wVmHuRBqIPYrLHCb0eJg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CH0PR11MB5235.namprd11.prod.outlook.com (2603:10b6:610:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 06:55:40 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7587.030; Mon, 3 Jun 2024
 06:55:40 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Pier.Beruto@onsemi.com>, <andrew@lunn.ch>
CC: <Selvamani.Rajagopal@onsemi.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
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
Thread-Index: AQHakY/2Zb5TFJZ12UCHjfgce9+PGrF0voeAgAA2YoCAGHimAIAAQu0AgAFPUYCAAH8FAIAA9qQAgBaf9gCAAAnAAIAABQ8AgAACngCACKHOAIABvDEAgAAGjwCAACuXgIAEK/YA
Date: Mon, 3 Jun 2024 06:55:40 +0000
Message-ID: <cbe5043b-5bb5-4b9f-ac09-5c767ceced36@microchip.com>
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
 <BY5PR02MB6786649AEE8D66E4472BB9679DFC2@BY5PR02MB6786.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB6786649AEE8D66E4472BB9679DFC2@BY5PR02MB6786.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CH0PR11MB5235:EE_
x-ms-office365-filtering-correlation-id: 64c13f3b-4ce8-4050-9358-08dc839a2e87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QlF2L3M2QUx3VVZaMmZsL3gwV3FSUHB1NnlVUERRNExYbU1QRnpaaVV4djNM?=
 =?utf-8?B?YldaODFPYkVxSGwrU1BnNUVPckRHV2ZsRE1wU1BGRFROVk04R2pKdWNzSXJ0?=
 =?utf-8?B?YkU1OU1JVWRJTUhQWW12S2k4bGQ0RE5RcnBUMGYrOVNMQTgvd29VRWozQTVY?=
 =?utf-8?B?T1lmcDl2TmpGOHp0dGFzaElIdHBaV3JWSEZzbFdFOXFwTWN3ZVRTSFJkd3B0?=
 =?utf-8?B?UHVJT2dhdjRGOVRjZkRCOERSQXp5WGNIdWRCYi8zYU5wcWk3S2xWYkRIRkVD?=
 =?utf-8?B?SlgxTXlLMWl5dFQvS1NuRGdkcW10Wkg4YTJEVlhnNG1FRnJsM2UyZ2kxandC?=
 =?utf-8?B?VVNldEg5cCtvMHpTSnBTamxXTzBnb085dmVZaURsY0V3eGdCR2VCUlNqajk1?=
 =?utf-8?B?LzJWdFNtZ3c5RnU4dUUxL0NUcS9qTkc0UnhMaCtvVmRCTFZ5RzF1UG41Y05s?=
 =?utf-8?B?MHdnUVBWMGtQNUx2bFhWVXBvV0dUTnIrV1pES2pFdEM0KzFTMmttMExKT2ds?=
 =?utf-8?B?TDR2M0c0SEt4alRnVE5EdmJqQkk4NENBd1pnUlUvSDY3bHNwaWRJMmt2TGR3?=
 =?utf-8?B?czh6TkN5OFh5MkF5WUVGUTdsUXoxdFlvaElIa1NUWEg3cTc3RTUvVDQ4czVF?=
 =?utf-8?B?bkd5U0h0T3RPSTJhcFZ2WVBKQmFFemkwaU8wMDRyU0dEeDVIN3MybWVtbjI4?=
 =?utf-8?B?ZXFDSUpVZm9VVnhHMVdVT0RnbnltaXNJemUycVp1YncrOFBwbW9UUDhKSHBW?=
 =?utf-8?B?Q1Qrd3p6SFZkVnJKMERuVkU3VXZIQ3hsL0p6T1BJU20zT1hSZEt1eXFwbkdn?=
 =?utf-8?B?Zmk2L0I1V0lvcUNHbFFoZVhsNmJ6bEVtcTFSUmlBb2grTmxydGFDWFRtQmY5?=
 =?utf-8?B?UnVzWkNQMTdDOHkveVp0ZXIwMys1QjBPYldmVVhDNW02Y0lLVUQwUHo2MUlR?=
 =?utf-8?B?dm9kbEhTbGNtb1I5THdEaEFCd1JBMk1vdzh1NGFsOEFzSUFtMy9QeUhwVlRr?=
 =?utf-8?B?aXBncFEwdnVvSGFOejlhWGkzaVFpQlpVSGxlcTlBajdWZTY2ZUU2WitLbGpJ?=
 =?utf-8?B?dGpYZzlWdlBtKzBMemZPbThWbStNM3lRYnJENEdKclNjVnljZk82WUMraVZ3?=
 =?utf-8?B?RUk5YkRwS1ZKNmVuQzFBUXFlZFBmd0dBYXhDTEVMLytyd3lzTlgybTdMN0Vh?=
 =?utf-8?B?blVPTEN3YUhDQmhkcExMZmNGR1lPMG10NDBZQzVWbThzSEtLaXZMNUxhYzJ6?=
 =?utf-8?B?bEN0ZzdmUERnaktHR2J0WGJ2aS9BQXV3NmlOYjFVZ2hUNVh3b25idHk3RGxo?=
 =?utf-8?B?TjlzZUdha3M2cmtxbW9xRXQ2VGJXRU5qMHQzVlFIeHVscHQ2WFcvbzZ0L1h2?=
 =?utf-8?B?SWlPWGNIbnIzSmFvbnNTME1BTElTZzlSbXVmaGFMbGlKVjk4YUdIejNFRWNi?=
 =?utf-8?B?ZWVQY2RjckRWQzQ5enJnTkliWGhwMTNvRk0yTnlWOUpXaTZUekdOVDdZSDgz?=
 =?utf-8?B?cVlQb2Vaa241WHo2a2xqbmJxUUdqNGZ4UTEySlZQc3ZFODVNcjJnR2Y3WHpv?=
 =?utf-8?B?dGs1SDNzWDBXaEdHRWw5em5lcWdjd0owZDByRkRGREtVUkhjTUI4QWwzMkhS?=
 =?utf-8?B?RWFyaExLQzJXM0JaQ2JYdTkzRDZJdUZZajhqSlZkUnU4d2pSNFNKSXNMc3JK?=
 =?utf-8?B?aC9vWTZMOXlnTEpOMTQ1TU9mWW5sSkFRaGhYRitBNWFNdkxRSUZRU1hsWTZv?=
 =?utf-8?B?eHZFd2xZM1hReDB4Yk5xUVRrVUxVd0tiR2JweUN0NzFDQzRQb0kxRXFxeFdG?=
 =?utf-8?B?dm5WdEtWdmpZOHVLdmFkdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG5Pc05tZ1Bvd3h5aHY2T2hZejF2Y3dpMnFGMmV2eHFIY2Z2NGNlYnVKd2dr?=
 =?utf-8?B?RkZpcko5VVJMZnVrZUpTL0dSVFJGYTBsRzNjSjlHNmdPd1cwbTZIbWZIVW9n?=
 =?utf-8?B?b2UyY2NMank0STgrcDBFdmZibmV0MnZxbGQ3dUI4VzZPSmV0dk96VUp3c0E5?=
 =?utf-8?B?Y3JOcnkwcEo1dDZ3b2VpRU96U2tHcEY5YmtrOExZbzFaR2pLUElJdEtaUTNJ?=
 =?utf-8?B?dm03dk1oaDdWSnpIclB2TGNjaU9EWVNlZVNZaWwrdS9DZVRWMllpSklYc3lK?=
 =?utf-8?B?TnFPd2h2ZTJUYklEWUZ5cnpuN1lWSDZuWnowQW8xaE83WlhPSFdackJWS3Ey?=
 =?utf-8?B?dUZHaVJvbWV1Vk9UNmtvRm1vRmNSRjNUSkF4MG5JbTJ1dlhqMmZtL1dHYTZG?=
 =?utf-8?B?SzBnZjhWNWhrc2MrYm51ZzJEQVdNS0x3RlNiaHRnalRLS3RyZXdEWGN2MXZR?=
 =?utf-8?B?aFpKS0ZCNWt4UFZISUg3L1Y3dmN6dTdnbXI3b0F4Zm5rNHE0TDBrcTBGeEJV?=
 =?utf-8?B?YUsxYzZPRk5OcFhMNmlBclFIaFlzcjdTajZ6L0hBSUJSL3l4aW9ickxNVkRO?=
 =?utf-8?B?Wmc0M0dSUVJzOFdLUDFuSjFncFJMcytldVJLS0dmY2NTRnJxNC9EdzRxNWtn?=
 =?utf-8?B?bXA5WVpPYWpwck1Dd1ZuU1liZHdEWHY3alVVZmNQbHpCTGhXT1RwTmZDdklm?=
 =?utf-8?B?eFN5dXo3L08zdk05MEhUdG5qeDhXMXdoQU1obVdmZUxVR3hIdGVnYnQ1YW1T?=
 =?utf-8?B?RHNudkF1UTdlcVJRTllFQ09DVW16LzRSZEhFSEpSTGIzNG1ZWW9xYlhrUUJB?=
 =?utf-8?B?b2V0S2I3TTRvZ1hwZlBSYXNpaGowNFppVlQyRlRmeHZxSE9mbmlMTHhkTTBi?=
 =?utf-8?B?QWxuL0IrNHdDTVB3UUpMeGFQY2pad29CLzFHaVhVTnhkeGVkeVpDL1cxSFlT?=
 =?utf-8?B?dkdTV3BKMXJETEtYLyttV2cvaHN4UkFrWkNFZ2UzKzJoL2V3d3NLSU9RUGdF?=
 =?utf-8?B?WnhNdExBc2hEdkFVenZ5NDFiOENUWDAweXJ4M2JKTjVoOHRCSTQ4OVNMenha?=
 =?utf-8?B?ZDdQaDVzZVF2dDVDZmJhbEJiL0MxR0dqYXhQZzFnTDJpdi9xMW5ETGtBQ0VV?=
 =?utf-8?B?S2JUSXJzVVhiTUpOeW1qcExDNUdCQmRoWWNaN2U4SlJ1TWlEZG8yWDNMMHhz?=
 =?utf-8?B?ckl4SHo2WTVvTFNDMC9kZW4xYTlVQys3TEN3R1N6d1UxMnZnVTk4ZUxWK05U?=
 =?utf-8?B?MjNzOFJzUTFEOWVPWnNNZ1EzdlFjL1hOWXgzSDZqOUZoUGx2cklzUFBnbUx6?=
 =?utf-8?B?TFVSOG9FdnE4M25hOHFCZGhlVHYwU0RHSCtzNDNQWkcxWkZyckRCTFUrZkFz?=
 =?utf-8?B?QjlNcDRhcStPQ0JUWXRPSWJrbzNZYWRPYThlTkdUc0lNZ1JycjhTS0dLeXdx?=
 =?utf-8?B?L2VUK1hDMlZ1bU5VR2UrWHhDY3Z5c2o2bzE3QzI1cTAwblYyeEtZVk1VZml6?=
 =?utf-8?B?bkhvTjdLZHNDTzlzL1Exd2QvUWNPVlcxU3Q2QnBJT0NCeVBSazdmV1NJUUpq?=
 =?utf-8?B?QjZjN2dDRXNaOU1DY3hmK3NUdnllZHpwUUR1V1N2NnAxeFVESVpBaWRvb2kr?=
 =?utf-8?B?SFhCM3Uyb1phalZVRkJ3K2ZqdE1yRzc0UmNMM3hmaHIyeXFQNTJLMloraVd4?=
 =?utf-8?B?WE9XdTcxMXM5K0RlSElvS0tkVDdlRGF6OUJyVURnWDdveGRNMWJQYmQ5bzJ3?=
 =?utf-8?B?SGQ0VEF5MGpyT0E3S3F6ck51WmVWU2N1TFg0TDE2b1N3cXg5Z1o2RFc0MmF6?=
 =?utf-8?B?eG83Kyt0M2dyL1VEK0hDYmdTa01UTksyVS9zOG5xQjRuVlpZL3NMWTdVRVAr?=
 =?utf-8?B?ZDI3cENGa05OUXVvSzgyN2Z5ODZWTFA2M3EvT2NITEJoTVRnK1dVU1RtRitD?=
 =?utf-8?B?eUh6THY1aUpFeHhBVlhrbzRYWnV6Y1ZKemgrQk9KK1hPNTJ1RDB5TlloYlIw?=
 =?utf-8?B?MnFYUnhUMXFwMFp5ZHJ4K2Jpd0prN1FOcVNrTXFPdEtMUWoxbC8vdzQvQmRz?=
 =?utf-8?B?R1NVbVRRYmZwanAxdFl1TTNtMEpJSFdNMkQ1SkYzeFdOSmkrVXlzT3FjdkFZ?=
 =?utf-8?B?UEdabEhSMFlpSHJKTHlzbnZmZCtPTXdaWjZuSWx2V0dRaEE1Z2RIclp6b1J4?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC1732E9D5C1C949BB3C860C3F417224@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c13f3b-4ce8-4050-9358-08dc839a2e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 06:55:40.7994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5tmSxz8Kd+UaIqNqu+NsLdThLVwlkFBg+Js9raHdNxbVCT1/WUxrCBEJT/JJlzfo78mg35QvspqvCJkIgsHGtozBq+inQqfu/QIqaQyDPTKqkpyVNlTEf0AouoAosuG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5235

SGkgUGllcmdpb3JnaW8sDQoNCk9uIDMxLzA1LzI0IDg6NDMgcG0sIFBpZXJnaW9yZ2lvIEJlcnV0
byB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBB
bmRyZXcsDQo+IFdlJ3JlIGN1cnJlbnRseSB3b3JraW5nIG9uIHJlLWZhY3RvcmluZyBvdXIgZHJp
dmVyIG9udG8gdGhlIGZyYW1ld29yay4NCj4gSSB3aWxsIG1ha2Ugc3VyZSB3ZSBjYW4gZ2l2ZSB5
b3UgYSBmZWVkYmFjayBBU0FQLg0KPiANCj4gV2UncmUgYWxzbyB0cnlpbmcgdG8gYXNzZXMgdGhl
IHBlcmZvcm1hbmNlIGRpZmZlcmVuY2UgYmV0d2VlbiB3aGF0IHdlIGhhdmUgbm93IGFuZCB3aGF0
IHdlIGNhbiBhY2hpZXZlIGFmdGVyIHJlLWZhY3Rvcm5nLg0KVGhhdCdzIGNvb2wuIEFzIEFuZHJl
dyBjb21tZW50ZWQgaW4gdGhlIG90aGVyIGVtYWlsLCBsZXQgbWUga25vdyB0aGUgDQpmZWVkYmFj
ayBpZiB5b3UgaGF2ZSBhbnkgdG8gYmUgYWRkcmVzc2VkIGluIHRoZSB2NSBwYXRjaCBzZXJpZXMg
dG8gDQpzdXBwb3J0IHRoZSBiYXNpYyBjb21tdW5pY2F0aW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpQ
YXJ0aGliYW4gVg0KPiANCj4gVGhhbmtzLA0KPiBQaWVyZ2lvcmdpbw0KPiANCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0K
PiBTZW50OiAzMSBNYXksIDIwMjQgMTQ6MzcNCj4gVG86IFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBt
aWNyb2NoaXAuY29tDQo+IENjOiBQaWVyZ2lvcmdpbyBCZXJ1dG8gPFBpZXIuQmVydXRvQG9uc2Vt
aS5jb20+OyBTZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5j
b20+OyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5l
bC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBob3Jtc0BrZXJuZWwub3JnOyBzYWVlZG1AbnZpZGlh
LmNvbTsgYW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb207IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0OyBsaW51eC1kb2NA
dmdlci5rZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2kr
ZHRAbGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IEhvcmF0aXUuVnVsdHVyQG1pY3JvY2hpcC5jb207IHJ1YW5qaW5qaWVAaHVhd2VpLmNv
bTsgU3RlZW4uSGVnZWx1bmRAbWljcm9jaGlwLmNvbTsgdmxhZGltaXIub2x0ZWFuQG54cC5jb207
IFVOR0xpbnV4RHJpdmVyQG1pY3JvY2hpcC5jb207IFRob3JzdGVuLkt1bW1lcm1laHJAbWljcm9j
aGlwLmNvbTsgTmljb2xhcy5GZXJyZUBtaWNyb2NoaXAuY29tOyBiZW5qYW1pbi5iaWdsZXJAYmVy
bmZvcm11bGFzdHVkZW50LmNoOyBWaWxpYW0gVm96YXIgPFZpbGlhbS5Wb3phckBvbnNlbWkuY29t
PjsgQXJuZHQgU2NodWViZWwgPEFybmR0LlNjaHVlYmVsQG9uc2VtaS5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjQgMDAvMTJdIEFkZCBzdXBwb3J0IGZvciBPUEVOIEFsbGlh
bmNlIDEwQkFTRS1UMXggTUFDUEhZIFNlcmlhbCBJbnRlcmZhY2UNCj4gDQo+IFtFeHRlcm5hbCBF
bWFpbF06IFRoaXMgZW1haWwgYXJyaXZlZCBmcm9tIGFuIGV4dGVybmFsIHNvdXJjZSAtIFBsZWFz
ZSBleGVyY2lzZSBjYXV0aW9uIHdoZW4gb3BlbmluZyBhbnkgYXR0YWNobWVudHMgb3IgY2xpY2tp
bmcgb24gbGlua3MuDQo+IA0KPj4gU28gSSB3b3VsZCByZXF1ZXN0IGFsbCBvZiB5b3UgdG8gZ2l2
ZSB5b3VyIGNvbW1lbnRzIG9uIHRoZSBleGlzdGluZw0KPj4gaW1wbGVtZW50YXRpb24gaW4gdGhl
IHBhdGNoIHNlcmllcyB0byBpbXByb3ZlIGJldHRlci4gT25jZSB0aGlzDQo+PiB2ZXJzaW9uIGlz
IG1haW5saW5lZCB3ZSB3aWxsIGRpc2N1c3MgZnVydGhlciB0byBpbXBsZW1lbnQgZnVydGhlcg0K
Pj4gZmVhdHVyZXMgc3VwcG9ydGVkLiBJIGZlZWwgdGhlIGN1cnJlbnQgZGlzY3Vzc2lvbiBkb2Vz
bid0IGhhdmUgYW55DQo+PiBpbXBhY3Qgb24gdGhlIGV4aXN0aW5nIGltcGxlbWVudGF0aW9uIHdo
aWNoIHN1cHBvcnRzIGJhc2ljIDEwQmFzZS1UMVMNCj4+IEV0aGVybmV0IGNvbW11bmljYXRpb24u
DQo+IA0KPiBBZ3JlZWQuIExldHMgZm9jdXMgb24gd2hhdCB3ZSBoYXZlIG5vdy4NCj4gDQo+IGh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3By
b2plY3QvbmV0ZGV2YnBmL3BhdGNoLzIwMjQwNDE4MTI1NjQ4LjM3MjUyNi0yLVBhcnRoaWJhbi5W
ZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tL19fOyEhS2tWdWJXdyFuOVFPSUE3MnNLQTl6NzJVRm9n
SGVCUm5BOEhzZTlnbUlxek52MjdmN1RjLTRkWUgxS0FfX0RmTVNtbG4tdUJvdE8tYm53M1BDMnFY
YmZSbiQNCj4gDQo+IFZlcnNpb24gNCBmYWlsZWQgdG8gYXBwbHkuIFNvIHdlIGFyZSBtaXNzaW5n
IGFsbCB0aGUgQ0kgdGVzdHMuIFdlIG5lZWQgYSB2NSB3aGljaCBjbGVhbmx5IGFwcGxpZXMgdG8g
bmV0LW5leHQgaW4gb3JkZXIgZm9yIHRob3NlIHRlc3RzIHRvIHJ1bi4NCj4gDQo+IEkgdGhpbmsg
d2Ugc2hvdWxkIGRpc2FibGUgdmVuZG9yIGludGVycnVwdHMgYnkgZGVmYXVsdCwgc2luY2Ugd2Ug
Y3VycmVudGx5IGhhdmUgbm8gd2F5IHRvIGhhbmRsZSB0aGVtLg0KPiANCj4gSSBoYWQgYSBxdWlj
ayBsb29rIGF0IHRoZSBjb21tZW50cyBvbiB0aGUgcGF0Y2hlcy4gSSBkb24ndCB0aGluayB3ZSBo
YXZlIGFueSBvdGhlciBiaWcgaXNzdWVzIG5vdCBhZ3JlZWQgb24uIFNvIHBsZWFzZSBwb3N0IGEg
djUgd2l0aCB0aGVtIGFsbCBhZGRyZXNzZWQgYW5kIHdlIHdpbGwgc2VlIHdoYXQgdGhlIENJIHNh
eXMuDQo+IA0KPiBQaWVyZ2lvcmdpbywgaWYgeW91IGhhdmUgYW55IHJlYWwgcHJvYmxlbXMgZ2V0
dGluZyBiYXNpYyBzdXBwb3J0IGZvciB5b3VyIGRldmljZSB3b3JraW5nIHdpdGggdGhpcyBmcmFt
ZXdvcmssIG5vdyB3b3VsZCBiZSBhIGdvb2QgdGltZSB0byByYWlzZSB0aGUgcHJvYmxlbXMuDQo+
IA0KPiAgICAgICAgICBBbmRyZXcNCg0K

