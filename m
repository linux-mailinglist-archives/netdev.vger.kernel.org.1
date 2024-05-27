Return-Path: <netdev+bounces-98153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1BB8CFCE8
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 11:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2077B21903
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 09:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C0813A3FC;
	Mon, 27 May 2024 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NW+LKjiO";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rNCe76sL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9B3B79F;
	Mon, 27 May 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802273; cv=fail; b=Smefk6JF5YLf2a27TEHVvL+SHRY3QlN6BM30d49WeW9O6gSb8lQwNbUzNcXMShoTdFnK/UeSjET8Jo0/8Uby0bjadMUjYGdv9j5gsinsDCMtXZV6K2OIVSDihIBjfKLKg+DeNtjZ3m6q+uZWaRoNinjTpHhc9/j10YmMSwjTP0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802273; c=relaxed/simple;
	bh=aLISxbLmDm0AUVeRKYushkzF8nNbauX88/UePp856Is=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tl6BXXfFjIBh6Hso71S55XrpXNtB+JnZR1y38jJaSX8eGYV9KFkXbkTEftwrvuNisEMrSj22ysQO9Nq+xmAcSQ8R8oczec3zOyJOVu/+l5xwSz6DM6BK87oRnrY5UFB9uwlQ3ihqfuMcUxUAlXO2QP600JeTexwJjA6ysoqgIlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NW+LKjiO; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rNCe76sL; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716802270; x=1748338270;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aLISxbLmDm0AUVeRKYushkzF8nNbauX88/UePp856Is=;
  b=NW+LKjiOyFR+z1lpNq0p40MHi4ejy36rRpq1KZKb8eM4GLLp425VSysO
   rx5VRnb3CF8Ev3wWU9XwXLnW3EhbOOhCc5vO56xEUIntNTcza7lsEylNE
   Mmb5rwaGAnxY7Vxw/NOkMOL2QXDOFDjWiUT1kFqvxpCFKSBihSVHXl23n
   DbEZwznaE4Uoc13NN3HaJ29zHxqbCDUuCtZljA2Pg+F/v6oB0jhXPn6wV
   nMKdftcNU6HC7b92pzu4ODXwhJhPO8z9LzzDOjjuEQq3wbMN1cR8k4zvs
   W3UY64b1dAXnBL8d/2OgnOFE6sg+cMgM1sa/6f3lWPxOSAxJ6rnNqlC60
   g==;
X-CSE-ConnectionGUID: PprREEr8QUuduJ4u5ObJkA==
X-CSE-MsgGUID: OXpVJ5vmSwaJ8DQLsTRdhA==
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="26379109"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2024 02:31:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 May 2024 02:30:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 27 May 2024 02:30:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWl1Vq5052gv/x/QwZIgPgQRhgpEUud3bB79DB3EasTjga6a1bCiBz7ZmRM0w0XPzYTQCxXxVQj9wuY65oqwnJ0UKtP9OUDL53isK7mRpwgKaEitX3Arzp15EWOfCQ6m4ILb6ki/yenKWD6/m/pkyv06azWcVGgLhrZZUrL6Wq38mlhjZx/IEJp7Y8B0eZ7A6q2TIzK7wExEzHKoE0i21dINiP5VSeQwtY7V330Vr1rtMGOe8YjUEADK4p0w1SCnd49ObSj9I5+MJ7/mky2n05gQp5gLfGDjAA1HLp/BnHBaKOTLFYrLIu5PJXKcTDmfu0PIEpEOGq8t++Lzd+Xh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLISxbLmDm0AUVeRKYushkzF8nNbauX88/UePp856Is=;
 b=iwbdfuEwmf09nL66U+oKEfaM59FapQKxRbjq0I9dAThjm7aRJQLtzH7Xl1SFlprykrfRKDtiG2HXgZyn3h+cacSn0VnaG0vhAtzB25UN9Z8K2FwKTn5KGMppPjHeNrN2AUf3RBQFOHq6wA3qLehn/kBu7vNH1Go41k1vIc3vrp/B73qK9YeJWslTjiyAjvyzO0NALOh/fDCKrqUZIsdEos8/x9reij4oJe6kRbUeR49LT8rCklzcTXN3rOTw6EYbvH1SGEhP21fdJb6oVenPapYovoL7JkRs3AuQhUIXk9PnZto+KQybsl8wZkS4mOkBnU80Q6IzxcZDpg02SbTcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLISxbLmDm0AUVeRKYushkzF8nNbauX88/UePp856Is=;
 b=rNCe76sLVy2dyIBuLWlOLpiOR2DSe3TrJKte2SGTvewNhc+dftJ8v3SyGWJMiu1ZFsidw5FvdN+gP4BNnEUSG3VX/ELort5Cp4yQBbTtnfG+RsT8odbwCElvXh4OfCPIXjWnOzYmOhRMo+B0p288VqryMMGb0JLU76Ts3aBaNCNdu/p9BsarabUIszR2uESIdBTVDjrbvDRK5Q2otTCiib3pnqALieX07zfeG63Rk4GErLNg3PLCVG89sjUQBpC8R1ka3aL7u7tWbsllYueaWmaeVh8zvw5zL+KvFbizb4jhfwKFwluQQ1MLv5/debgvkIea1eOBY52PUxYQRfcKDA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW6PR11MB8439.namprd11.prod.outlook.com (2603:10b6:303:23e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.31; Mon, 27 May
 2024 09:30:40 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7587.030; Mon, 27 May 2024
 09:30:40 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <Pier.Beruto@onsemi.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
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
Thread-Index: AQHakZAQrurZHAw3l0Wxg+eFKGxGMbF8la2AgAAX2oCAANNtAIAAVU8AgATxiICAAQb4gIAAAoaAgAFdYYCABFWYgIAAWygAgAr+tICAAGnoAIAADcgAgAD6j4CAAq/ggIACWJOAgAuQEgCAAAVKgIAEH7yA
Date: Mon, 27 May 2024 09:30:40 +0000
Message-ID: <63268a9c-6dc2-43fe-83c2-46c6e617247d@microchip.com>
References: <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>
 <fd5d0d2a-7562-4fb1-b552-6a11d024da2f@lunn.ch>
 <BY5PR02MB678683EADBC47A29A4F545A59D1C2@BY5PR02MB6786.namprd02.prod.outlook.com>
 <ZkG2Kb_1YsD8T1BF@minibuilder> <708d29de-b54a-40a4-8879-67f6e246f851@lunn.ch>
 <ZkIakC6ixYpRMiUV@minibuilder>
 <6e4207cd-2bd5-4f5b-821f-bc87c1296367@microchip.com>
 <ZkUtx1Pj6alRhYd6@minibuilder>
 <e75d1bbe-0902-4ee9-8fe9-e3b7fc9bf3cb@microchip.com>
 <ZlDYqoMNkb-ZieSZ@minibuilder> <7aaff08b-a770-4d93-b691-e89b4c40625e@lunn.ch>
In-Reply-To: <7aaff08b-a770-4d93-b691-e89b4c40625e@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW6PR11MB8439:EE_
x-ms-office365-filtering-correlation-id: 5b86f3bc-3578-446e-a1d6-08dc7e2fac92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bm1qc0hnMHJoVnJxNlYwTmhMN1pPN2cyanZqMVd2RXVmWHRLU21jMHNoZmVw?=
 =?utf-8?B?WEI3K1A5TzNBMUNjV2l2c0Y1S0prTlVkUi8wVWRwYlN1VzRCcDRkMlVVdXQ2?=
 =?utf-8?B?UnNxKzROa2VGcy9uVXI5V1RqVXpSYlJvQ1NTbXRPYUR1T0VPbWkvZGlDNFcv?=
 =?utf-8?B?ekhYblRCcjlOYXp4R1VYY2M2S0krMklJSFRINXdIQi9POHRDYW9IZlBNT1Zs?=
 =?utf-8?B?aXNCSzlJdUR6WGM4U01YUWNNSHNUNGxxdTA5L3NWR0N3ZUg4REljSHlTcTlL?=
 =?utf-8?B?MFZEcnZpSDV2d2lyVmN5cFdpemZNS3doemljY20wUXBYNWhZLzlJSWxNQWk1?=
 =?utf-8?B?Q0wzaDVTYnJvai91bXQ0VlRPV0RxK1RFd2ZjbHlBOW1FNENBekV3RWF4dG9o?=
 =?utf-8?B?S0Foa0hOR2F4Q2JrRmQvdjk3aWpzZXlTdGhJNnozT3ZYbjhEWUlnUWRQY1or?=
 =?utf-8?B?Y1ZsbS9URzJqSHZMTlNKa1JhNW94SExiYjN0VTVyY3U2MDBSUUFwUUEwUGpX?=
 =?utf-8?B?NmxOQ3MvMndGbTNHcVJqc3ZxeWQxNXBvT0wxMVp1U2lmdzhwbjVadjZtT042?=
 =?utf-8?B?NG0zVnMwaHo4NkZqanZxZm5CUEdYNk9RUnZSNmRKVGpuODl3azFTeTU0ZXQ1?=
 =?utf-8?B?T3FuVy9ESlJkNnZYRGhUd3NyeGJHRldCRTdzWHMrZWtrSjdMc2N5RlBDWEZT?=
 =?utf-8?B?a3dRV1BUWTdjWDdTUEZPa1BRV3B4YnpFNXA5VGZnVzhPRWFwWlBUVFVuaHNK?=
 =?utf-8?B?eWdVZVNZcSt6Vmd5YVgwYTBYa2huZCtpUHVaWWI0M0g3aFVRODJjbnhoR3JX?=
 =?utf-8?B?R1ZVbnhiSzJaKzlUS1pEaTkralE2SDVjK1Q5dEVaWDQycktQUy9NbytWMGpq?=
 =?utf-8?B?aGF5Q3N1U0JLais5SitIMGIzc01jdXUzQUtoRjZ6WEVhYTZnTWsreFUzMS9Z?=
 =?utf-8?B?aWpmbm81YTFNU2d5aUpEbWNJMzV5V1F2Y0FCdzdLSUdQUmlqbmdJQkVWZDAw?=
 =?utf-8?B?ajg3M2wzWWpiL1oxRmF4MWxzVkxKaEtvNHJTc3JFQXlHV3g1N0VrRVVNV3ZG?=
 =?utf-8?B?M2c4SlpqQlJVMTRXZ0NXR0dkTWo4ZVFoTzlhc2Fma0FZMWNxU3BPa2swSWN1?=
 =?utf-8?B?bkEzQ091SWJ1Q2l0ZzZiUXd0YmVrL2lTU2ZQWEhUbDRRVzRlRnErRCszTW5x?=
 =?utf-8?B?RS84Q3d5SUdZZXdIVlFlZWl6TzFPSzNHOEpMMlJZQTJlQTdJeTJzbk1MT2xU?=
 =?utf-8?B?bjVBU2V0L0tKV3MxNjlwSmx6L3MxRlJXUThlQ0tZTWNlUmpqSEx4SDZwOVFF?=
 =?utf-8?B?YlUyY1BqZG1BNXp6Qng0WE1qWlM4V3VxUkZkR1ltNjhFSjBGN0xpc1puZHJi?=
 =?utf-8?B?VG5UK1lWLzl0Y3hRVHBrcnZTaHhTL2NxTXVlZDdHNEhrMlFwRWVYZFNNMUMv?=
 =?utf-8?B?VlBISXBmSXRGbVB0TDlqMFZzMlZ3eWRsRnNvVDlVZGxoOGQyZlhqcWxnTWFj?=
 =?utf-8?B?RWovVVVueGpHaFE5SGxHMzdtNXdMaklzY3hMcGRHY0JFZWlrSk9NRXhwUVZ2?=
 =?utf-8?B?UllNR3RSbUVmRTMxSHlTdzJleUJHanFwVjlDV29ML1lDS1VlcFExcHM0ZjB3?=
 =?utf-8?B?aU90SlZuRXBNSDNKU01SVGFwZExJZ3hFVWRHa2poVjBIWmxMUFUwS3VJTG15?=
 =?utf-8?B?WmRjdHk1VnV6NGFKa2JLTEJKZWY0eWFqRnh3LzNmRnFsREtBYlRyMVc4YnJ3?=
 =?utf-8?Q?1RloODFfAhbhyHSBCQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmhPSkpYaGZKb2UvN0xodjJlZ3lwOVZ6WnVGVXRtOWtQRzdrdHNqYnVFYkh2?=
 =?utf-8?B?clFLdVR5YXc1aER5UGhGTU1yaU9ZLysrWE8yWnB4N2JyWUM2dS84Z05UQjNN?=
 =?utf-8?B?cmFkOGhPcHZ2OVFPdVBuVEZrSHNDaGpUZTRXNk9WY1NVOC9xYTIxWHVFNFlM?=
 =?utf-8?B?aWVaR3pOSHJiY252bGMrTjkyWXN1cEJ1Ullac1Nnc0NzVnB0UldUZEZFdWI3?=
 =?utf-8?B?YUU2aWZBUEJIa1ZDa09odnRlVm8vZThyMTdlZzVTTXMxMFlnNjhDZGVCTWhl?=
 =?utf-8?B?N25XZVpaVC94Vy90cktEK1RvdVlFMlpLSzQwUzJjWlJsSGE4aUtwMXo0Z1hN?=
 =?utf-8?B?MEZVSzhIWlBDQTV6dlVhK3dLOXVwRDl3V3NSMFEwekJLT2JUUTY4NS9iYVhv?=
 =?utf-8?B?QTA5YTRCbE9JWnZCbGRaT3dFajZKV3c5Y0NPbzBlUVZpdXlTclpZK2JnSDhn?=
 =?utf-8?B?Qmg0MElQYkJQWU9OMkErbkV1Wm0xNUtmcGtpRWdqNnVzTEtFZmRaTlI3WjNE?=
 =?utf-8?B?TkZBOTk2OXlONU5ldnlCQnRPUGRBbGdXSEYxbnowSWpRc2FqVkhtYzhjcGlj?=
 =?utf-8?B?UVFJWnZmbDdhZEpKeXZwb1h5UDlqR0JPVCt0N3BxZVVCTVB2aXRkTHkrS1c2?=
 =?utf-8?B?MVFtQzlLeE5YVnU2bTR2a09NczF1U3M5eHBkbENLMlFjSGczVDVxc0dxaDBn?=
 =?utf-8?B?KzRmOWs4cDBrR0h1NDZXZWdtY2lsUkplM2drdFI1eXRkZVMwbTNka2hPQW5F?=
 =?utf-8?B?SjNTcnBUWDMwQ2czT3RLL0Qxb0FybURCbGJrSWFNZUZKNGFtQ1c0TzY0NWdW?=
 =?utf-8?B?a0xYRmtZOENkdVY5N2VqZzJ0bXNnSS9BQWFydWxEUm9tVGt1YnVKRXV1c0VS?=
 =?utf-8?B?Z1ZobjNzRzdlNlJSdnlsa0NVZFVXWTVXSVI0MGNseFIxSVVRbTlzcm5zUGJX?=
 =?utf-8?B?SmlRbitkQnBVZ25vTW1IaW9QeTJtTEt1Y0p4dnJPbEZhaUFqQnM2UEhLSmFY?=
 =?utf-8?B?ZUxNY2hGSTUvVGF5aHVnc3FJNEhLNUJoZU1CUGpwL0tiMDR0SlVxTHRvSTZw?=
 =?utf-8?B?Z24zaUwzempUVlVsSUpJVHVIWmtrWEQzQVh1OEg0U3FKVDBEelFORlpFbEFW?=
 =?utf-8?B?d2F2Q29pMkJ0Q2JLK0h0MnZZYmE1Q1VWeTE2b2xDei9xTlZmUFFxV2VmZjVV?=
 =?utf-8?B?ZVNXaUR6U25IL05GZWFRWGlBaFNVQjF4b1BpSzAwNm9wenN5TjZRSWg4M0ZS?=
 =?utf-8?B?QlFVRVFFRDh3THFjT2Fwdk1kUHhmYm52LzlCZlhWNEZBRXZaUGVLWURPNm9F?=
 =?utf-8?B?Uk10bXZWUHdERWFkNWREeE1lUlZxUkNVc0tDNUc5NC8yNU5qaTl4aE1NVGZX?=
 =?utf-8?B?VTd6bnE5aFdHS2M4bVE1N1BGeStFVEpQOWFaeWExeVM2S1VwY21ONjgwN1Vj?=
 =?utf-8?B?REVySnFyMUdTR056K2ZTNTlGSEdJanhiL210T0xXUC9LZ3NSK1d5WTZUVlNv?=
 =?utf-8?B?NFNUdWVMb0NmUWM0bkVadXgyT0tXdGpqZDNtd3psSm5hQmdrOUV1a3BHRTVR?=
 =?utf-8?B?cHh1VzY4RVNsNFR6NEEveHROYTl3cjZMNkgwbnRXd3Z3OU5wV05zS09uQ3RI?=
 =?utf-8?B?RVBMZEdteng1dU5KZm1uc1RKSnlVSkdGY2pqMW5IK3I4VklEdklMTkJrd1RH?=
 =?utf-8?B?S2pENlloMGpmOFExZnFHMHBrVU1zcVlkTWg3c2owSzVqRTBydHp6VUZhWHVp?=
 =?utf-8?B?djI3NEV0N2piRkwwNnBjK2crWjNKOTFSQUp2ZVFUS3RVSTlHbytDQm92YnNQ?=
 =?utf-8?B?bS9mSCtDRXIrQkpXMnVNcitpRzBGdkliUlJuK0xtOEhWODY4S1hvN2hMODdq?=
 =?utf-8?B?ekR2TjcvTVViNi9pRHZyRVJYWU1PMnhWK1VFR2hMOWQ5cm9LNkZUR3QwNnVF?=
 =?utf-8?B?RGxITUVHVENYVm8vekVWL0Q0RmpXblhvZEFJV1RWcHVBWDh6RVBCa0ZtekRn?=
 =?utf-8?B?emVORklFa0s3Q2FOZVgwb0VqdEVnbFF4dUoxNmxnUldnZCs3NnBaWU9ub0o5?=
 =?utf-8?B?bmhhRlZnUzRBTFJSWHlyMkh4V3hpS2o0d3dkRG14TGJVdy9PbTFweDIvU3No?=
 =?utf-8?B?aDRCNzhHa2RBZ2VjTW4vZWNvTFJrRzI2U3lmbThoWW5QZk9yVlAwQXR5MnZm?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DE8FAAD57D32C498809E729D39B1D9C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b86f3bc-3578-446e-a1d6-08dc7e2fac92
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 09:30:40.3424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpBKYFwQErV3xFDWr6Pkd49k4A0bMng+OBLl48Cj7Q1fWQ1ID1UrXZsWqSwhYDglAKRnkAYJwpkUyRMErYk6Cdb+eWaBCqBYVWr2qWSBFw2kUDAiu/R8FTGWM8/PtA00
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8439

SGkgQW5kcmV3LA0KDQpPbiAyNS8wNS8yNCAxMjowMSBhbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+IEFmdGVyIGEgY29uc2lk
ZXJhYmxlIGFtbW91bnQgb2YgaGVhZHNjcmF0Y2hpbmcgaXQgc2VlbXMgdGhhdCBkaXNhYmxpbmcg
Y29sbGlzaW9uDQo+PiBkZXRlY3Rpb24gb24gdGhlIG1hY3BoeSBpcyB0aGUgb25seSB3YXkgb2Yg
Z2V0dGluZyBpdCBzdGFibGUuDQo+PiBXaGVuIFBMQ0EgaXMgZW5hYmxlZCBpdCdzIGV4cGVjdGVk
IHRoYXQgQ0QgY2F1c2VzIHByb2JsZW1zLCB3aGVuIHJ1bm5pbmcNCj4+IGluIENTTUEvQ0QgbW9k
ZSBpdCB3YXMgdW5leHBlY3RlZCAoZm9yIG1lIGF0IGxlYXN0KS4NCj4gDQo+IE5vdyB3ZSBhcmUg
YmFjayB0bywgd2h5IGlzIHlvdXIgc3lzdGVtIGRpZmZlcmVudD8gV2hhdCBpcyB0cmlnZ2VyaW5n
IGENCj4gY29sbGlzaW9uIGZvciB5b3UsIGJ1dCBub3QgUGFydGhpYmFuPw0KSSBhbSB1c2luZyBQ
SFkgZHJpdmVyIHdoaWNoIGhhcyAiRGlzYWJsZSBDRCBpZiBQTENBIGlzIGVuYWJsZWQiIGZpeC4g
DQpQcm9iYWJseSB0aGF0IGNvdWxkIGJlIHRoZSByZWFzb24gdGhhdCB3aHkgSSBhbSBub3QgcnVu
bmluZyBpbnRvIHRoZXNlIA0KaXNzdWVzLg0KPiANCj4gVGhlcmUgaXMgbm90aGluZyBpbiB0aGUg
c3RhbmRhcmQgYWJvdXQgcmVwb3J0aW5nIGEgY29sbGlzaW9uLiBTbyB0aGlzDQo+IGlzIGEgTWlj
cm9jaGlwIGV4dGVuc2lvbj8gU28gdGhlIGZyYW1ld29yayBpcyBub3QgZG9pbmcgYW55dGhpbmcg
d2hlbg0KPiBpdCBoYXBwZW5zLCB3aGljaCB3aWxsIGV4cGxhaW4gd2h5IGl0IGJlY29tZXMgYSBz
dG9ybS4uLi4gVW50aWwgd2UgZG8NCj4gaGF2ZSBhIG1lY2hhbmlzbSB0byBoYW5kbGUgdmVuZG9y
IHNwZWNpZmljIGludGVycnVwdHMsIHRoZSBmcmFtZSB3b3JrDQo+IHNob3VsZCBkaXNhYmxlIHRo
ZW0gYWxsLCB0byBhdm9pZCB0aGlzIHN0b3JtLg0KIklFRUUgMTBCQVNFLVQxUyBJbXBsZW1lbnRh
dGlvbiBTcGVjaWZpY2F0aW9uIiBmcm9tIE9QRU4gQWxsaWFuY2UgZG9lcyANCnNwZWNpZnkgdGhp
cyBpbiB0aGUgc2VjdGlvbiAiNS4yIENvbGxpc2lvbiBEZXRlY3Rpb24gKENEKSAvIEhhbmRsaW5n
IiANCmZvciB0aGUgQXV0b21vdGl2ZSBlbnZpcm9ubWVudCBzdXBwb3J0Lg0KDQpodHRwczovL29w
ZW5zaWcub3JnL3dwLWNvbnRlbnQvdXBsb2Fkcy8yMDIzLzEyLzIwMjMwMjE1XzEwQkFTRS1UMVNf
c3lzdGVtX2ltcGxlbWVudGF0aW9uX1YxXzAucGRmDQoNClRoZSBhdXRvbW90aXZlIEVNQyBpbW11
bml0eSByZXF1aXJlbWVudHMgZXhjZWVkcyB0aGUgYWxpZW4gY3Jvc3N0YWxrIA0Kbm9pc2UgbGV2
ZWxzIGRlZmluZWQgaW4gSUVFRSA4MDIuM2NnVE0tMjAxOSBbMV0uIFRoZXJlZm9yZSwgaW4gc3Vj
aCANCmVudmlyb25tZW50IHRoZSBDRCBtZWNoYW5pc20gb2YgdGhlIFBIWSBtYXkgbm90IGJlIGFi
bGUgdG8gZGlzdGluZ3Vpc2ggDQpub2lzZSBmcm9tIGNvbGxpc2lvbnMsIGxpbWl0aW5nIHRoZSBh
Y2hpZXZhYmxlIGxldmVsIG9mIGltbXVuaXR5Lg0KPiANCj4gRG9lcyB0aGUgZGF0YXNoZWV0IGRv
Y3VtZW50IHdoYXQgdG8gZG8gb24gYSBjb2xsaXNpb24/IEhvdyBhcmUgeW91DQo+IHN1cHBvc2Vk
IHRvIGNsZWFyIHRoZSBjb25kaXRpb24/DQoiOC41IFBMQ0EgQ29sbGlzaW9uIERldGVjdGlvbiIg
c2VjdGlvbiBpbiB0aGUgTEFOODY1MC8xIGRhdGFzaGVldCANCmRlc2NyaWJlcyB0aGUgaW1wb3J0
YW5jZSBvZiBkaXNhYmxpbmcgY29sbGlzaW9uIGRldGVjdGlvbiBpbiBjYXNlIG9mIA0KUExDQSBt
b2RlIGVuYWJsZWQuDQoNCldoZW4gbm9kZXMgaW4gYSBtaXhpbmcgc2VnbWVudCBhcmUgcHJvcGVy
bHkgY29uZmlndXJlZCBmb3IgUExDQSANCm9wZXJhdGlvbiB0aGVyZSB3aWxsIGJlIG5vIHBoeXNp
Y2FsIGNvbGxpc2lvbnMuIEhvd2V2ZXIsIHVuZGVyIGNlcnRhaW4gDQpjb25kaXRpb25zLCBpbmNs
dWRpbmcgbWl4aW5nIHNlZ21lbnRzIHdpdGggc2lnbmlmaWNhbnQgaW5oZXJlbnQgbm9pc2UgDQpk
dWUgdG8gcmVmbGVjdGlvbnMsIGFuZCBzeXN0ZW1zIHVuZGVyIGhpZ2ggZWxlY3Ryb21hZ25ldGlj
IHN0cmVzcywgZmFsc2UgDQpjb2xsaXNpb25zIG1heSBiZSBkZXRlY3RlZC4gVGhlIGZhbHNlIGRl
dGVjdGlvbiBvZiBsYXRlIGNvbGxpc2lvbnMgd2lsbCANCnJlc3VsdCBpbiB0aGUgdHJhbnNtaXR0
aW5nIG5vZGUgZHJvcHBpbmcgdGhlIHBhY2tldC4gQXMgcGFja2V0cyBhcmUgDQp0eXBpY2FsbHkg
cmVjZWl2ZWQgY29ycmVjdGx5IGluIHRoZXNlIGNvbmRpdGlvbnMsIGl0IGlzIHJlY29tbWVuZGVk
IHRvIA0KZGlzYWJsZSBjb2xsaXNpb24gZGV0ZWN0aW9uIGF0IGFueSB0aW1lIHRoYXQgUExDQSBp
cyBlbmFibGVkIGFuZCBhY3RpdmUuIA0KQ29sbGlzaW9uIGRldGVjdGlvbiBpcyBkaXNhYmxlZCBi
eSB3cml0aW5nIGEgemVybyB0byB0aGUgQ29sbGlzaW9uIA0KRGV0ZWN0IEVuYWJsZSAoQ0RFTikg
Yml0IGluIHRoZSBDb2xsaXNpb24gRGV0ZWN0b3IgQ29udHJvbCAwIChDRENUTDApIA0KcmVnaXN0
ZXIuDQoNCmh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURvY3VtZW50cy9k
b2N1bWVudHMvQUlTL1Byb2R1Y3REb2N1bWVudHMvRGF0YVNoZWV0cy9MQU44NjUwLTEtRGF0YS1T
aGVldC02MDAwMTczNC5wZGYNCg0KSG9wZSB0aGlzIGNsYXJpZmllcy4NCg0KQmVzdCByZWdhcmRz
LA0KUGFydGhpYmFuIFYNCj4gDQo+ICAgICAgICAgQW5kcmV3DQoNCg==

