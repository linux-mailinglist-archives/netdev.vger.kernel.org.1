Return-Path: <netdev+bounces-98148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322C88CFBAB
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 10:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13EF1F21D97
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13E160263;
	Mon, 27 May 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MfI30mD1";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AAFit4VZ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4156470;
	Mon, 27 May 2024 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799123; cv=fail; b=NfJ7m/61LWlOAbe/Fj8L4j/GBVSHWySorb5aEK5Rp3Myn51IO+3oF2oDiyQieuUsL/VHiQIbFy36GvH/eI2TRN09kFdXy+SfzpmC4hP5f315cAl75Vh34N7iv00vfAYlkENW01zboqdx8l/ghhJRPoL7hWl6TD7OO+H2Bm2+1wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799123; c=relaxed/simple;
	bh=uLUyk0Ugz6i8TjdN4sGCWCO+5RIuTfZ3bAsXZV1h8uk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iyFuuQyW+FJIMIdTRqCKdKKNNPxAbrPUSkHjciveBGP3TnGhYIC04rbNuMuWY0BoUDawyxo4QyvBFbopOdJlsFex+aUs0rrAUT6xosbGwL+zEyFhku7v+6GE4QeWEMR/MhWbjpkCgUFi4BKVaFkL0ThkDCVn/GvXsg6sLJJmv0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MfI30mD1; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AAFit4VZ; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716799122; x=1748335122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uLUyk0Ugz6i8TjdN4sGCWCO+5RIuTfZ3bAsXZV1h8uk=;
  b=MfI30mD1eRHKEzpEWP5vbuFWQnosNs2UFzz81TjHd9RVQQG7xunkexLP
   VymFB85mNsZjgtjnXezuFgQGr1YdU9zpCuwMxBHQhZKJBIG9GPmPYWjcJ
   VaNQL/KZzDohULuhv2AC0kJFr98XsdpyO664ZGsSw46QEXPP0GyHBS/JS
   B5dr/gPwgSZ9ioj8ei0lC5MC95iqVP1If2sv5jz3LbfahxYmd0XvuV9TR
   QcnHLBs3lboyLxhdp/wYRw55bF+TQvLoe/q6H6K+NYzT+vFAiuqxg2Z/Z
   uN8xLVvdms0EYLgd4IO5pFbVGpE/L1AJwegU2OKXWmlKCbPxJIOuaIqXz
   w==;
X-CSE-ConnectionGUID: mqgf/bfgT6Cm/W/xMyWD7Q==
X-CSE-MsgGUID: hOKHTKGbSZegKCw3ZG9AEQ==
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="257214083"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2024 01:38:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 May 2024 01:38:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 27 May 2024 01:38:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko4dvNrQAq/viBFJVTlooGiOiTpjRmmoBhYl5zLyQywKc+AdK5zs36E+J3N4tp5Y0xdjmhCqMbaUfcTloISh931cF5iu6wtue+20T4DM7+XmyzwzR7Cnd6KxinprijDRTFIc1gjKiGbEQSEdALW7qLYRcoQUoK8mrfVCMqgLblnLaFDfliMr0Sg9pzaOtDuj7Orru0CgWGgo1ky5lxAAKGwmIjd8mHi/SJrF0Mz63ZFjhi0AagTct1q7OjtNiVNGdgo242SJHruUkRF4o/dCTD5dO0IsUF1Cis7GeCRQla8mUs7Pxof+1cWFhRj7xhXkmiBy9VRRaSQzcoy5cN0gew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLUyk0Ugz6i8TjdN4sGCWCO+5RIuTfZ3bAsXZV1h8uk=;
 b=BzOxoVMnR8yfrW4UPdl3zJf60/Oy64NaGG9x+vo0zROsTMbqCPUTTr5jCGcSMbTyWicsSHh/uUYM9rMsz4VSbiA3a2CAc0VmFTLXIyskapPMCUPhEo6X+8uO/hg/RiIfPUrQwRIoxf/sYtgrIi0H4HGznZsPywn8sbvI64jsdLxeFoRIxMDLoVXIuGeZUKvSBLgoOmN9xHsqOAqeAEUF0K0pPFvSmdM3Q9MJiV3qVZKvUee9Yv8anc4qW7YawWz0KFRL80k0OWXJHKaHfGbBvQ9T9HwHyOiurfycqaANXkkKQ0bQL7haQDHfcKpRa6i9fOYc/XcEyCMkrkCPcq4FXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLUyk0Ugz6i8TjdN4sGCWCO+5RIuTfZ3bAsXZV1h8uk=;
 b=AAFit4VZtAkd/9GghWbYpvcb6q0/am3C8/+/VeEKVn7pO2pcA1hrFk9hms/Qb+7xZMMVBUfQ0dzTRzUmhTzYGkdh4tV1Ur4XuFYvGs1tnoiwTPXMdz6KoN9B0qgDUvFZ6jph5wQAOwq9e/9FwxnMNLiCesJgpleL46jjNcEmnkd9+p+jhrA2yB7DnnitpBT0Ot+lfbFuNOQ5GN25o/ZxVn8Bq9tsINUWMm60kUgm0awKdV7alDfI3FDEK7LobChaw01+Lgf5vLzVYUet5P1474wbpZKMzQI9kFU156x1kkjSRnMUsPzr3uNTZ0h4rl2/713PlNz6mL1PFmirubX+gg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH7PR11MB7430.namprd11.prod.outlook.com (2603:10b6:510:274::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 08:38:18 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7587.030; Mon, 27 May 2024
 08:38:18 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <ramon.nordin.rodriguez@ferroamp.se>
CC: <andrew@lunn.ch>, <Pier.Beruto@onsemi.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Topic: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Index: AQHakZAQrurZHAw3l0Wxg+eFKGxGMbF8la2AgAAX2oCAANNtAIAAVU8AgATxiICAAQb4gIAAAoaAgAFdYYCABFWYgIAAWygAgAr+tICAAGnoAIAADcgAgAD6j4CAAq/ggIACWJOAgAuQEgCABBZlgA==
Date: Mon, 27 May 2024 08:38:18 +0000
Message-ID: <ed8acf48-0c9d-4d90-99de-9ab39118a223@microchip.com>
References: <ZjNorUP-sEyMCTG0@builder>
 <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>
 <fd5d0d2a-7562-4fb1-b552-6a11d024da2f@lunn.ch>
 <BY5PR02MB678683EADBC47A29A4F545A59D1C2@BY5PR02MB6786.namprd02.prod.outlook.com>
 <ZkG2Kb_1YsD8T1BF@minibuilder> <708d29de-b54a-40a4-8879-67f6e246f851@lunn.ch>
 <ZkIakC6ixYpRMiUV@minibuilder>
 <6e4207cd-2bd5-4f5b-821f-bc87c1296367@microchip.com>
 <ZkUtx1Pj6alRhYd6@minibuilder>
 <e75d1bbe-0902-4ee9-8fe9-e3b7fc9bf3cb@microchip.com>
 <ZlDYqoMNkb-ZieSZ@minibuilder>
In-Reply-To: <ZlDYqoMNkb-ZieSZ@minibuilder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH7PR11MB7430:EE_
x-ms-office365-filtering-correlation-id: 76fa6245-ff85-4eac-88b3-08dc7e285bc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TW93WE1SeFFKSFN6QURsT3J4UnFJVXhURWRCZUNoM0tvSnk2dkoyVDdMVkRk?=
 =?utf-8?B?Ymh2OVNSSUU0M3FtQ0ZEZUMrWFVMQmxKSmJWYUlMUDdkbzJmRjZIKy9MOWZw?=
 =?utf-8?B?RlRhNWV4SkxJa0RVemFsWmt5LytHV0J2bDI3MW1nOS9FTDBBK1hmOFRJUUJR?=
 =?utf-8?B?VUNaMjZUMTE0V3huYmdRVEJ0c05NTmlVR0gwNGFDWjFkbFJBb1RuaUZYellM?=
 =?utf-8?B?OVVxS20yL21pSEp0RUVkRVpBb25NanlFVEtwUSs3RENoc1VsdkZjWTA5UThZ?=
 =?utf-8?B?TnVWWi9tcjNxVklPVEt4cEEycUM4R3FROTIxRk5oZnFDL3dhZ2FTUUUwazVz?=
 =?utf-8?B?SXVXcFY3NjFNQ0Q5WHBncVE4eXBCZ0VrYW51OWZtei9oOUtYOXJuZTJ1d3BN?=
 =?utf-8?B?dEFYckg5VXRDa3ZZZnpxS055MTJza0JYWXBHUjE1SWtvRmNvSzRvb3UwUjg2?=
 =?utf-8?B?N2FSTHZYSGFSalRzYWJydHYwSE9SOEZEUUtsNm9zT283dHpqR2NKWDgzNmhz?=
 =?utf-8?B?dHdXVXpiWDk2dmZEVXZWVVREazI3U2tMb0QwYVFVc3R3OFRtcFE5TGkwSU92?=
 =?utf-8?B?eFIwT0w4WXVtMHUrNHNrYitmTnZaWXQ4K0xmZk1LYjB0cWtUQldKUWxSNTNm?=
 =?utf-8?B?dTBXbEMwVXhYUlFOU0pkMmVhRmNOV1hUeHpTYVVRcVhSSktwTjRCQkZNVzBu?=
 =?utf-8?B?Y1MxbDN6NThRR2FlejRmTDJPOG1EWHZselFTbjhKNHhmOHd3eGFJdmRhSmF5?=
 =?utf-8?B?TElGWDlLTXJpUzhtSjRSazJMdTcxbmpPWTlzQ044Wk5FbXE4ZDg1eUNVOGFO?=
 =?utf-8?B?U2tuTFdyNDZNK25kTXRBTFhUMlowWXNoSVhORkxLZVB5bDMxLzNuV0RPVlRO?=
 =?utf-8?B?dWE5ZUdLRkREcFQzUFVzWGVDc1I0aDNHTTVoSm5vLzRkMTJPbmZsMTQyb1B6?=
 =?utf-8?B?Vm5pdHJGSnlTN3dFOUp1L2dTdTlIMDR1dWFEM3VmQk1xYU1hT1doUjEwbGh1?=
 =?utf-8?B?cW8vd0cwdUM3dXlyUzhTNDdTYXltZU40MlpqTU1Ka1k5NCtVNHEzK2dlQWpw?=
 =?utf-8?B?UnNTdVZXRm43RGU1YktIVGRSYzlXR25YQ09pTU9henVUZ0ZUbHBEOHJ6QVlv?=
 =?utf-8?B?RVlNLy9nNGNYZ1BXcVdxWklBUVp6NTE4cGpyYTZCdE5vTy9ienJkS1VCVG16?=
 =?utf-8?B?cDBHdVV0VVEwUWJTejVwamxObFRIMHJ2WTF1bEFBN0Fhb3VZT01CRWFudmJJ?=
 =?utf-8?B?RHlPbDVSM2dxbzJ4RFdBYi9WUjBuOWxwYlJML3hJT1JUUDRrNFhsK2xPRVlV?=
 =?utf-8?B?dmM3eHd0THdEUnhDSVVzd2VaOUVvSTczcm4zaTdndFZBTDFrOThvRjBsWTFY?=
 =?utf-8?B?eFNPcHFzUlZKa3hoSWJBbU9nVkpHbWtLSzdmblVmRUZZTU1zTjVLNjdCQ2gr?=
 =?utf-8?B?eGo0WFVCbGpQWVkzTUJSTUZ6QXhnbHRXMmF5dElQcW9iY3FIM1dkbEhqSkEy?=
 =?utf-8?B?SDhvWmgyU2dFemVKbUNhQndvRnZRdUtRVHRnQlJDNC9jMmlHU3ZUK05DSVlC?=
 =?utf-8?B?dkE2SjhNQ21oTTJqa0Z2UjBPQktBK0ZDQ2hMZm0xZ0RmbHBLREx3OTF1K3Rn?=
 =?utf-8?B?SjB3ajZiWjVqbW9FMWI0S2dBWXd5ZzloNlpNbGNxbkJmRExvOTI0Ny9jQyta?=
 =?utf-8?B?R0pIS3NrcVpGNGVEME1jQmJuMWVaanN4ekdrLzlma1lMV1llaE1kbWRncmhP?=
 =?utf-8?Q?kaPlGMkvc5hVNNOSDI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anBoRk5FeWRPaVRmWnV6V3pZV2svNUJTaWxOK2hUQTR6cWVqV0tzNlVjOS9z?=
 =?utf-8?B?K0RKd0N3UmcwNE1pZmZGcy9rT1k2NkMzTkVNUnlGM1pEb0xMcTNzRmdYTjNK?=
 =?utf-8?B?QVg5NnVJajZKT0JwQ0xlVGFEU2EzaCtqamQyRlVocEdSUGlsa3JSS08rS3dT?=
 =?utf-8?B?SWppeGJlamVWT2pPYVVsUGtnM1g5Q3RDRTV6cHpVdXludHNCWHF3Z0ZEMGxS?=
 =?utf-8?B?K1ZSVy9WbE10cTN0VkdmbmMyV3Z4bEQ3bVRmUmJaSG9SbmFHZk56eGtGNnVP?=
 =?utf-8?B?VDJ0T3lNSkxjZm5ad1ZxaWwzZHJlUGhaUFV5dThUcEhWRjJqRlBmRGQyczZs?=
 =?utf-8?B?c0FST3V4bndLVVkvMUJ2OGlPK3k5dE0rdnZIWFd3SVJyZkRnM1dSWUhvRG1K?=
 =?utf-8?B?UjdOdEZpcEJ0NXUvNmpYME5EeldtWEwvTy9HQjVMcEd0dHh5SzFMOWJJRngz?=
 =?utf-8?B?UUlacEZmTUNrNUlyZkQ1a3pkdkRSbE5HdmkyTFlXWDdvUmxUR1UyZ2VEV21G?=
 =?utf-8?B?WFR2WFA2WmJURzcyV081NHZOeFRoM1J4eUVDdGdTV0lzQVp4T0dnNHRGTnNu?=
 =?utf-8?B?Qm1ORld6R1lhaXhTbnhVTmNiQ3RYZW9NMDZSVWt1dTJueE85eHFZdWpONXZp?=
 =?utf-8?B?ajRiUXhMZ2pYTVYxbS8zMG1Sd0gxdldoUUZkd2pIalJVdDV5OXZDNFdKYnBG?=
 =?utf-8?B?SXFORmw0NG9iZVd0aGRQaks5OVd6bXZteEZvMWdWMWZmSnpBNEVEMUk2aFlx?=
 =?utf-8?B?TU1GcHpTY2o5WWQ2cFpaZ3drZlpSTDhYUnZqdUswdGFmVFJnWE1XZy9FU0l1?=
 =?utf-8?B?TllmNXJMRUdWd1pLd2VSc2hMOGpTcTlPMTR4amJGTUFUMVkyNkY2T05xRE40?=
 =?utf-8?B?UGx0SnhYdE5GRGw4MUw0aTk2OE5INGk2VUlMbThoc2JkNWs4eU5zS1FkR3JE?=
 =?utf-8?B?cFdvNDN2aHBWanBRZUxoOUtaajUxUDlwMHJpejJWSmY1RndBL3NITWczKzNU?=
 =?utf-8?B?cTZFcVNObHR2Mk04NXltcXhBdUo5dm5PRVY2c3N1RlpnenU4NGpPZ1hMNkZY?=
 =?utf-8?B?THRtYTRMeE95Ky9UcnVwVGVRUlRMeUdFV1d6R0t4a0pZaFlJOEIwc3RGU2pJ?=
 =?utf-8?B?dkpHOTZlc0lFN2RtVW80S2VZa2t4M2w1d3RCQ2lzQkZLSFhSWEZvRHJZTXF4?=
 =?utf-8?B?NXBiNzhiMk1wRFFoWWZPYWNkUUVpVHlPR0NoRllFS2VBY3RSYUZTaFlBUzRt?=
 =?utf-8?B?d2Z4Wk1LUE1RdE5sSFdPSndFV0R1dHpHTHBZVDBWSm82enhoZ3g4eUpJWWhB?=
 =?utf-8?B?UWNXRE9nWHRtOVJ2VmNTQjNyQ1ZVM3MxRlFCUWpBS01TeGp6Skl6R25vcnJj?=
 =?utf-8?B?SERFcEVjZFp4WFJGTHpYMXVsVjJUZTZiRURPcTlWdys5czhDZzFmRU93QWlS?=
 =?utf-8?B?ZTRPaVRRaGY0OUhOZ0JQZGtsenBxdW0rUGV4RERweDBQV1NVcnl3VGtyVm1y?=
 =?utf-8?B?K2FOS2xiQSs3RHZUbmg3TzlaMm1qZXlkSExIS0UzWnJBRE5aUXZGNXVtNVRR?=
 =?utf-8?B?Rjg2ZUhodVNqbFFSSFhvM3pBWnA5S3RyMVIxbnFnOFVSaTYvQ3NXdU1CK0tK?=
 =?utf-8?B?alNhWWU2OWRjVTVsNXRLbFNOdGM5U3BZUHZmSXdLM1BlMnAxRlIzdG1ydFEz?=
 =?utf-8?B?VlRGK1ViK242WjB6U0o5ZEx4L0kydm5YRFRjalVxdXdpdkw0bnBlc0pOclFD?=
 =?utf-8?B?ZGFuUU9sOWFPVnhxQXY4d3htaDNuYmtkRzFoZXhZNm5tNjhjVUNzUm1vWXlN?=
 =?utf-8?B?Q3B1bTFXOG41dEJXWUhjcmN0bWhwU0FzTnFQUkIycERlNUZNT3dlcGo0Qzdn?=
 =?utf-8?B?TFNKK081MGdtVzk0YXlnaEYzQk0zK2w5SFNqVWMzWmRDVitoOFFQejJwNFdX?=
 =?utf-8?B?L2gydFQ3OStJTFlWZHI2NExHZzRIMjJ5STdmL3NBTXFZV1A1NEh2YVowSHFY?=
 =?utf-8?B?cm14bmo1WHhiOEthWFdPUWJ0QU1aVWpyYWU1V0s4YjQzSFBLbCtodG1nWlVZ?=
 =?utf-8?B?N1Z6RzNoKzNDYkgvWEs2Zk55eWtGYlo2dm9QSnkvTWFadlBvZ3lPK3hoMm03?=
 =?utf-8?B?SzVReUdoN1FZSkpjcndsRHhrYUVNQ1BKenhRbkh2N3VJNmRWNG9QcEtCQkw0?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96DAEA6862003441B43529C00492321B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fa6245-ff85-4eac-88b3-08dc7e285bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 08:38:18.3452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/OrqgpLp0mzhR2ie8EcuUrscRxR4PV8InyHoqmZW0hvCErHQJ60nINfcc1QFEvd11CsaM+N3VF+AbBfOKZ8YhVQzpiG6HWN7cdwS8ueFHRtnQ5eija6YYyr4JCceQBB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7430

SGkgUmFtb24sDQoNCk9uIDI0LzA1LzI0IDExOjQyIHBtLCBSYW3Ds24gTm9yZGluIFJvZHJpZ3Vl
eiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4+Pj4+
IElzIGl0IGRvaW5nIHRoaXMgaW4gYW4gZW5kbGVzcyBjeWNsZT8NCj4+Pj4+DQo+Pj4+PiBFeGFj
dGx5LCBzbyB3aGF0IEknbSBzZWVpbmcgaXMgd2hlbiB0aGUgZHJpdmVyIGxpdmVsb2NrcyB0aGUg
bWFjcGh5IGlzDQo+Pj4+PiBwZXJpb2RpY2FsbHkgcHVsbGluZyB0aGUgaXJxIHBpbiBsb3csIHRo
ZSBkcml2ZXIgY2xlYXJzIHRoZSBpbnRlcnJ1cHQNCj4+Pj4+IGFuZCByZXBlYXQuDQo+Pj4+IElm
IEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHlvdSBhcmUga2VlcCBvbiBnZXR0aW5nIGludGVycnVw
dCB3aXRob3V0DQo+Pj4+IGluZGljYXRpbmcgYW55dGhpbmcgaW4gdGhlIGZvb3Rlcj8uIEFyZSB5
b3UgdXNpbmcgTEFOODY1MCBSZXYuQjAgb3IgQjE/Lg0KPj4+PiBJZiBpdCBpcyBCMCB0aGVuIGNh
biB5b3UgdHJ5IHdpdGggUmV2LkIxIG9uY2U/DQo+Pj4+DQo+IA0KPiBBZnRlciBhIGNvbnNpZGVy
YWJsZSBhbW1vdW50IG9mIGhlYWRzY3JhdGNoaW5nIGl0IHNlZW1zIHRoYXQgZGlzYWJsaW5nIGNv
bGxpc2lvbg0KPiBkZXRlY3Rpb24gb24gdGhlIG1hY3BoeSBpcyB0aGUgb25seSB3YXkgb2YgZ2V0
dGluZyBpdCBzdGFibGUuDQo+IFdoZW4gUExDQSBpcyBlbmFibGVkIGl0J3MgZXhwZWN0ZWQgdGhh
dCBDRCBjYXVzZXMgcHJvYmxlbXMsIHdoZW4gcnVubmluZw0KPiBpbiBDU01BL0NEIG1vZGUgaXQg
d2FzIHVuZXhwZWN0ZWQgKGZvciBtZSBhdCBsZWFzdCkuDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFj
ay4NCj4gDQo+IERpc2FibGluZyBjb2xsaXNpb24gZGV0ZWN0aW9uIHdhcyBkaXNjdXNzZWQgaGVy
ZQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyMzExMjcxMDQwNDUuOTY3MjIt
MS1yYW1vbi5ub3JkaW4ucm9kcmlndWV6QGZlcnJvYW1wLnNlLw0KQXMgeW91IHN0YXJ0ZWQgdGhp
cyB0aHJlYWQgbG9uZyBiYWNrLCBJIHRob3VnaHQgdGhhdCB0aG9zZSBwYXRjaGVzIGFyZSANCmFs
cmVhZHkgaW4gYnV0IG5vdyBJIHVuZGVyc3RhbmQgdGhhdCB0aGV5IGFyZSBub3QuIEluIGFsbCBt
eSB0ZXN0aW5ncyBJIA0KaGF2ZSBteSBDRCBkaXNhYmxlIGZpeCBpbiBteSBQSFkgZHJpdmVyLg0K
PiBpbiBhIHBhdGNoc2V0IHRoYXQgSSBoYXZlbid0IGdvdHRlbiBhcm91bmQgdG8gdGVzdGluZyB0
aHJvdWdoIHByb3Blcmx5DQo+IGFuZCBmaXhpbmcgdXAsIGJ1dCBub3cgaXQncyBkZWZpbmV0bHkg
YSBwcmlvcml0eS4NCj4gDQo+IFJldi5iMCBhbmQgYjEgZ2l2ZXMgc2ltaWxhciByZXN1bHRzIGlu
IHRoaXMgZG9tYWluLCB0aG91Z2ggSSdtIGdldHRpbmcNCj4gbG93ZXIgdGhyb3VnaHB1dCBhbmQg
aXQncyBlYXNpZXIvZmFzdGVyIHRvIGdldCB0aGUgaW50ZXJuYWwgZXJyb3Igc3RhdGUNCj4gb24g
cmV2LmIxLg0KPiANCj4gV2hlbiBDRCBpcyBkaXNhYmxlZCBib3RoIGNoaXAgcmV2cyBzZWVtcyBz
dGFibGUgaW4gYWxsIG9mIG15IHRlc3RpbmcuDQpJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCBk
aXNhYmxpbmcgQ0Qgd2hlbiBQTENBIGVuYWJsZWQgd29ya3MgYXMgDQpleHBlY3RlZCBpbiBib3Ro
IEIwIGFuZCBCMT8gY29ycmVjdCBtZSBpZiBJIGFtIHdyb25nLiBJZiB0aGF0IGlzIHRoZSANCmNh
c2UsIHRoZW4gSSB3b3VsZCByZWNvbW1lbmQgdG8gY29uY2VudHJhdGUgb24gdGhlIGJlbG93IHBh
dGNoIHNldCB0byANCmdldCBpbiB0aGUgbWFpbmxpbmUgZmlyc3QgaW5zdGVhZCBvZiBmb2N1c2lu
ZyBvbiBCMSBwYXRjaGVzIHdoaWNoIGNhbiBiZSANCmRvbmUgYWZ0ZXIgdGhhdC4NCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIzMTEyNzEwNDA0NS45NjcyMi0xLXJhbW9uLm5vcmRp
bi5yb2RyaWd1ZXpAZmVycm9hbXAuc2UvDQo+IA0KPj4+DQo+Pj4gSSdsbCBjaGVjayB0aGUgZm9v
dGVyIGNvbnRlbnQsIHRoYW5rcyBmb3IgdGhlIHRpcCENCj4+Pg0KPj4+IEFsbCB0ZXN0aW5nIGhh
cyBiZWUgZG9uZSB3aXRoIFJldi5CMCwgd2UndmUgbG9jYXRlZCBhIHNldCBvZiBCMSBjaGlwcy4N
Cj4+PiBTbyB3ZSdsbCBnZXQgb24gcmVzb2xkZXJpbmcgYW5kIHJlcnVubmluZyB0aGUgdGVzdCBz
Y2VuYXJpby4NCj4+IFRoYW5rcyBmb3IgdGhlIGNvbnNpZGVyYXRpb24uIEJ1dCBiZSBpbmZvcm1l
ZCB0aGF0IHRoZSBpbnRlcm5hbCBQSFkNCj4+IGluaXRpYWwgc2V0dGluZ3MgYXJlIHVwZGF0ZWQg
Zm9yIHRoZSBSZXYuQjEuIEJ1dCB0aGUgb25lIGZyb20gdGhlDQo+PiBtYWlubGluZSBzdGlsbCBz
dXBwb3J0cyBmb3IgUmV2LkIwLiBTbyB0aGF0IG1pY3JvY2hpcF90MXMuYyB0byBiZQ0KPj4gdXBk
YXRlZCB0byBzdXBwb3J0IFJldi5CMS4NCj4gDQo+IEkgcG9zdGVkIGEgc3VnZ2VzdGlvbiBmb3Ig
aG93IHRvIGJyaW5ndXAgcmV2LmIxDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8y
MDI0MDUyNDE0MDcwNi4zNTk1MzctMS1yYW1vbi5ub3JkaW4ucm9kcmlndWV6QGZlcnJvYW1wLnNl
Lw0KPiANCj4gSSBzaG91bGQgaGF2ZSBwcmVmYWNlZCB0aGUgY292ZXIgbGV0dGVyIHdpdGggJ3Vn
bHkgaGFja3MgYWhlYWQnLg0KPiANCj4+DQo+PiBBbHNvIEkgYW0gaW4gdGFsayB3aXRoIG91ciBk
ZXNpZ24gdGVhbSB0aGF0IHdoZXRoZXIgdGhlIHVwZGF0ZWQgaW5pdGlhbA0KPj4gc2V0dGluZ3Mg
Zm9yIEIxIGFyZSBhbHNvIGFwcGxpY2FibGUgZm9yIEIwLiBJZiBzbywgdGhlbiB3ZSB3aWxsIGhh
dmUNCj4+IG9ubHkgb25lIHVwZGF0ZWQgaW5pdGlhbCBzZXR0aW5nIHdoaWNoIHN1cHBvcnRzIGJv
dGggQjAgYW5kIEIxLg0KPiANCj4gQW55IHVwZGF0ZSBvbiB0aGlzPw0KSSB0aGluaywgSSBoYXZl
IGFuc3dlcmVkIGZvciB0aGlzIGluIGFub3RoZXIgbWFpbC4NCj4gDQo+IEkgd2lsbCBzdWJtaXQg
YSBuZXcgcmV2aXNpb24gb2YgdGhlIGxhbjg2NzAgcmV2YyArIGRpc2FibGUgY29sbGlzaW9uDQo+
IGRldGVjdGlvbiBwYXRoc2V0IHdoZXJlIENEIGlzIGRpc2FibGVkIHJlZ2FyZGxlc3Mgb2Ygb3Bl
cmF0aW5nIG1vZGUuDQpZZXMsIEkgd291bGQgcmVjb21tZW5kIHRvIGRvIGl0Lg0KDQpCZXN0IHJl
Z2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gUg0KPiANCg0K

