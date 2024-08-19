Return-Path: <netdev+bounces-119564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800B8956405
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 08:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085E92810D6
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 06:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C699D156230;
	Mon, 19 Aug 2024 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="npErCREf";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Dpwi5P68"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD417C77;
	Mon, 19 Aug 2024 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724050468; cv=fail; b=GgLDGwQKr3USC0qAquhqmc1LpJ4BlxneGOg34yzRWcskrkNNIb3o9xg5OGAyZBQ0k6w8WN/jUP/9W/uQAMPWHX6MOyYr2wv63eL4hcIBbA6r4D31D87U4ho2Z0W1RFb1fuuXOVwsndtln7anxxqFPo0c0J5NL4fT/B8fIXzdnYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724050468; c=relaxed/simple;
	bh=g4C/REX+0m8kCo0e83utDvYyTsrDiwj1DOFRkY0eRx8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FpULDw6y5WMGaOUO8V8PKtYcf3fR2OYNCczsFJqdevSl48E4cNuWF+gzz5m0a3nsf+qtLKoeqkbjltii6M/kGyA2WkvQSuqPgu9BZPu7NFfxQwgeWOXkmWXRv9q7OPc2phZtICWoMg68K+8EEbVukTeduUuTDf/83cj6uxOJ87Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=npErCREf; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Dpwi5P68; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724050465; x=1755586465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g4C/REX+0m8kCo0e83utDvYyTsrDiwj1DOFRkY0eRx8=;
  b=npErCREf4FmgRL7hy8O8Z3H1TQGB4svjQxrTycZ+rBMNKNzd5SGxpeQw
   89VENE2jy4sHWbjNSBCMZPxpgfR3eLHbol323uR467YNGurz20SkzPdtq
   IlVJUgMsX4dFYpPCAb0PFc9iAEh3UkTIXs06gwmgwVJZ4uBzz/dBAPWW2
   PvPzCsHTJsb7e17dcxvKFdpZ9DqHyL23AjcTd1/KF+9cKVnrXkVgLMWhS
   0BViUb59q9PYD4hmxBtK4M2vBP52UkNtsaGwvpnSPy8LEiSp3hN1fOQa+
   IfiRc/ASEWznMHexLk6I1WcdJK8/wlgD1pr1AD3PLFL7LefRm+mJ/Xa0n
   Q==;
X-CSE-ConnectionGUID: nCdi+Cq8SdaoPRsvZdT2gg==
X-CSE-MsgGUID: k+jM8C5tRGmKtjCYtMMnnw==
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="30601924"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Aug 2024 23:54:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Aug 2024 23:53:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Aug 2024 23:53:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHr0Hfi6nnqPjmn7pS/sJh1AYyLkN9awvCtyyHRqcHnSc1r2pSsDT+GnqKsiTvkFBTOGFdNWrbgnQl+hx9b4jwOdVk2JHPYz0jCBvK0ed5OhfOY4cstWl6XQtFbZEwI/A7cEDl5QdUIsv2cxKPgtRV0XN99ahIK/TuBj8ZQ8vFgxaY6N6xqz6zKEI/A4IEFMDTHMEDZ9fdOfg9cxqR53fptTR03qFsTSKQFFqm3vVxuRIY0a5kUpoMA1fIbr/1jkPEuQdyzXh4gHeNagGS5kDrVhyHo0+Qmn2jdrob77+B/JcxXJZiO1bVLNZXZpyO6UeCW2gyyIx+ZaNU6wEHHLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4C/REX+0m8kCo0e83utDvYyTsrDiwj1DOFRkY0eRx8=;
 b=sD15O0Tyg6EesW/qU2ILcG8yVSqxP5mEk3FfukmQVuxmUiGPkZbzGh89JZrUNN43/3VG2PkQEnv0u5PnQqTS9TWCYc/eaAxPck50bMAuGcieAqZQn+WcucKeoxxsoGqP9snCt5FF//ExZwuiyQAqT5DrNPXnu4fNHmCjhAT3AL+uyTG/j34w1ZhgJrcFYFcCYO1uwyaBYk6i6OUo9WUXKth++MVW07bjOUNURgRWlaG4HbxRhPtehmv+yBtQ42ICBhACVgFROs5d8rFe/bK6a50nDEBY3pD2CnO1GUxcvUKOcZeAZ2MkSpibf6oM01Q3kgXEihsNLgqegUKZpdC+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4C/REX+0m8kCo0e83utDvYyTsrDiwj1DOFRkY0eRx8=;
 b=Dpwi5P68jZgl/9pMeUYNcMoYQVvayPAeEHo/G1NzZYnJbzsTaYi8XLJzk0uRlvwsKsP8UzTQZnSs8ZVtBHZVYx9rL3b4JK7/bPapTefehgjd7G1MWrIeYmUFKbMYg1+LsuXJ+n8fqKh+hao7eH9CqtoDTJLZgzdlSa1ijyOpSaJ7gcj1onsEKtBwSBVfT00EC+dy8QPmLF1HKj5b0VEQNI2ZzFTmNCCoVemCovJChq+vJVYR8reI2xP7VvuaB8lSvFmYmKrXYUlQw6476j6qrxNjFJOTrrgXVukHDTfDpxNv8Rd8JxsAmSOYVWdoqhv3kZafUwoPkW+ADhAJVd2wzQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by IA1PR11MB7176.namprd11.prod.outlook.com (2603:10b6:208:418::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 06:53:52 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 06:53:52 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <masahiroy@kernel.org>, <alexanderduyck@fb.com>,
	<krzk+dt@kernel.org>, <robh@kernel.org>, <rdunlap@infradead.org>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>
Subject: Re: [PATCH net-next v6 10/14] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Thread-Topic: [PATCH net-next v6 10/14] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Thread-Index: AQHa7KKPrhiVuFptV0eS+tbagLmoKLIqIq+AgAQNJIA=
Date: Mon, 19 Aug 2024 06:53:51 +0000
Message-ID: <1cd98213-9111-4100-a8fa-15bb8292cbb5@microchip.com>
References: <20240812102611.489550-1-Parthiban.Veerasooran@microchip.com>
 <20240812102611.489550-11-Parthiban.Veerasooran@microchip.com>
 <20240816100147.0ed4acb6@kernel.org>
In-Reply-To: <20240816100147.0ed4acb6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|IA1PR11MB7176:EE_
x-ms-office365-filtering-correlation-id: 62460a73-9073-4ad6-aa8b-08dcc01baf76
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZUxzZmZMVkkyVERRdlE1SldlUzh4MEZnQlY5VUVGQlFPdmpkeHlMRW1rUTBw?=
 =?utf-8?B?WHFKMkt1V3dVRVFEWitPWDVuTkJzbVNPNDk5c0Y4dU9nclpNNndQNjFjS3Za?=
 =?utf-8?B?cVhRQm9zVGRlZXk5WncxekdIM05XQXBoVmRtNDQzUVExYm83Q2d5LzNPWVRG?=
 =?utf-8?B?ZmhkNGRoQXlMZ2VSbnhVcHBibzd6RG5oZGhMZjA3bE0vTm1DMXFINFZtQnZi?=
 =?utf-8?B?RVBzZXFWK1RwbjZtVHF4WkVDYUtYQkl5bXh2WkM3eU5jelBIT0tCb2VKKzF4?=
 =?utf-8?B?KzNXVmVVcUhlcHRQYUdSS2tGY1A2S3JCL05teVJQTVczTitWaE1ubUtDcndw?=
 =?utf-8?B?L0JnclJya0J2THlkMVY3UTJxVEhqREw0QUt5OUJNUG41NzEwQXl4eUNqSElZ?=
 =?utf-8?B?WVpieUFxMndjdllZME1Zc0FYQnJ5cmNSTGFNUHNMaEd0eHZwTkY2bUo0YUFu?=
 =?utf-8?B?M3RtbDRZL1pqVmNvWjhhQjNrd3gwOTA4TkFiWFlFMGxGdEJnSjZxek5yWEFt?=
 =?utf-8?B?cEZqTWl3dVZhN1NGSEt3TlJTQXdNMGZyUktFMDZLYTlTWGJCOC90WEwxZVRk?=
 =?utf-8?B?SjUxbkI4RmZxTzduajFveE5UWWUrb2N0RCtsdVRHZTNJMnE0UjNPcHV4d1B5?=
 =?utf-8?B?YnBqQ3Fjc3E5NnJHeUF1bEpiWklCcmZ5T0RVUXJ3VWZTaktvK2NkZUVxd1pU?=
 =?utf-8?B?UUlrYnhzLzluV05zRHZXai9tckZ6ZHBNTFJxc01wYlI3MkE0VGFFT2owa2ZB?=
 =?utf-8?B?VjAybDJKUVo4eE5xQ0lEdG9qSEhlbmVoa0VsVnJmQ1RDK3puYUlNd0xYQVcz?=
 =?utf-8?B?dEJYeXQ3RWFPaUE2L09iUmx6S3BJRDZwWG14WWdmd1Z6eFhCZEVDbFBqd014?=
 =?utf-8?B?SlNJN0tUelpYTVI5MnFoNEJhQWJTZ0MzM1RtdVRvMTdGV0xBZGVOdUhsbkgv?=
 =?utf-8?B?NVpJWW82VTdpZUtXYWVhS2lScCtUbzRFVFBnby95c3gwWFVaQktaYzlscjR3?=
 =?utf-8?B?Z3QrOFFXVFZ3S2ZCQzV3Zkd1Y2xoUmViUGVCamhqM0xhZ1Q4WXlUUEJhMU1l?=
 =?utf-8?B?YlZuZnFqbEs1cm9tblVUZDRhQWtESmVDMmw4cVRFMklpcVBzVENFa2dmanJG?=
 =?utf-8?B?YU1ZYngxWkdnNG5FN3QwNDJ6V0xlZmdBVnZLb04wYXEwc01EakNUekhYcWlY?=
 =?utf-8?B?ZDNqK0labFphUWRWZnZNN2FQTXo3d3R5a01Mb2lxT2NTZm5DWkFFVk1nVk41?=
 =?utf-8?B?MkZWaDRsY1ZwY1ZFb1RvSzhwaVZ3Mm5yR2c0OUhVTEFWSFNRKzIvdkNiNm9M?=
 =?utf-8?B?UkhiVzc1RGF2MEtpYUd6Slk3VTZIL3dLeTd5MXp3YjFnWTZvT0hOMXBnNHZU?=
 =?utf-8?B?dFZpU05hcWlVRWpJVFdid0RLcTE1dmxBYXg4WmNqZ3V4c1EyeUc4SXh6TFRp?=
 =?utf-8?B?ZW1tZDF5K2Q5di8wMFhYQ09mYjR6QlFxbHZMQ3EyMko3eXR6MUMza3F3OHRQ?=
 =?utf-8?B?Q2tWYXVBNVJrc1lqbjBpVkJlbVdSS0RrVjg2N1ljOUJDclR6VmJJS29SUUR6?=
 =?utf-8?B?YWtlVGFMUVNXUjdLUGFZeEsxK01pZGUvaTdGYkNJMW8zOW05NktHMzh5eUY2?=
 =?utf-8?B?azBTSllXZlRpaDJyQURBN0VDWlNFaWhPM2dlVFBUZ0NEMVNDcGxsZWZwOHNX?=
 =?utf-8?B?djBkdmpjM0YrMUt5ejhFKzkvNmpMcDNGRTFhWUdpbnhjeWRwc21FMUM5MXY5?=
 =?utf-8?B?bTdxZTVjZjMzV3V3WTJaOC8rMGFnQkVzVEZueXRiQ3VOZW85andIeklHS2Fr?=
 =?utf-8?Q?Aq5yNh/NtuqdQSYjN7PiBz1vycfUja+mNyhi4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTd5QzVSN2VMaEFGbG5kY0pZYXF1ajhVL1NaZm5vcis2ZXR4RkxpRWV2aDds?=
 =?utf-8?B?YXlIZ0VzTUZXY1NPVnB1dUFZR2c4dmlBSXowV2M1TmIvZmVWUks2RWdzblBl?=
 =?utf-8?B?cERQaFBmR3dadTJjMGh3aUpUR2ZQQ25IWHpaNGRQZ1E4ZmV5ckFaNEgvZ0M5?=
 =?utf-8?B?azZNUjZnNUZFK0Vnc3hqKzVnMHJLN0FWMWtaaEM1anUwUmxxU1Bta04wWkls?=
 =?utf-8?B?dnIvdmh4NTBjNldRK3pvYVJKZktjWXROZmZuSXdnVHB1dWRVTnphS0ZDYkxi?=
 =?utf-8?B?OHQ0TDRQWlVyOEZINERJb0JWa0dseDVkTFp0SHhuRmdvYzh2cjJmVHpaNzhX?=
 =?utf-8?B?eEhjaTcrbFZuWnBqemJyQWcxTUJmcHBuQk5Qa2Uxbjlib2NVSzBNZU1WRk9k?=
 =?utf-8?B?eWl6R1c2ekNSSSs3bXNlcW9vVWpBd1NHeFN5OUVOMEJzMDBzTWFuZ3F6VXhO?=
 =?utf-8?B?NUNGZDdGUElyKzVtS3IzZUtkenJjTWF5SFFxZGFyZk9XQ3BpVC9peVJEUkd1?=
 =?utf-8?B?VVpWeDEycTZPQUtHVjlZV1VuYjNZVUtIeTN3dXE3MVA1eWk4a1BOWTd0REZU?=
 =?utf-8?B?VW5JNy81Z3pkQkJIZ1RoVkVCUjJkY1VsVHNyTWMrOGcrMWVTWnRoQzJoVU8y?=
 =?utf-8?B?T2szbGk3Q2EyN2JOem9NUVpQSW5nT3k3ajFxb29sa1FVUTltSWF0WU85Wm1i?=
 =?utf-8?B?N1E2Z0FhaTFjQnI4SUE4YW1IVklqOWdRd1BQeHBFSXR2QUo2ZGo0allnb3d1?=
 =?utf-8?B?S3J1QU5mZGF3N2hDQ0N4WERDRXY0Y3JveW4xUmtOV21sck1hajJKUmcrUUx4?=
 =?utf-8?B?ZGlYcGRnbXlsRUtxL0tZZ1VsU0QyeWZwS0NTZjFTN0VZK1NEa1ZyVFBEUldR?=
 =?utf-8?B?VmhrRFF0aVZMbzNscnREUVkzdld4d2ZQQWFtWUltWXZtYTdCS2RnMVRrSEdm?=
 =?utf-8?B?Y0F1djhDY01sdWZjUTVqNkwvZGQ3RjQwOXJTQnQ1Y2ZMN2JuTUtoUVVvV29F?=
 =?utf-8?B?ZEg5VnlvVmpSOWdLTElZekVBbGQzdHZISy93aFFEbWZZOTRCTUNoUFkxemZI?=
 =?utf-8?B?WHExN0ZRdmpadzJuV3ZoT0YwL044M2ZJT0l0SDhtek1maHpkKzBaK1NKVU1B?=
 =?utf-8?B?MGh5dXJtMEhOOXhCejIzaVdJYTBvbXhwOXIxcDhoM2FoVStrWUN4K2cvVDlS?=
 =?utf-8?B?ZUJEdmMvc2hDd05VUlpMUG9XeFMrSzYzdmFocHJYMmVCWldiMHM5RWVqaUFX?=
 =?utf-8?B?cU1TRkMraUZOWTAvcDF0NVRFamxpakxxczdPUWhQdE91QWFOMDJ3WTZFQ201?=
 =?utf-8?B?Z25NVEFPYlVER0x3NGVxMkRLQnFGV1ZuSE9sTWd2a1dyQjNZczcxckFVYXZK?=
 =?utf-8?B?MmU5cFE3RTZzeEZBNUMxZXV1RHU3QmROVzIrZkE0Y2hXM0VrRDFmWGRvZldk?=
 =?utf-8?B?R0VzTzBFU0N2Z1VjYWo4Y3h6eXFqMlNhbmlkWEV6MVh2K1NmY2VlUERZNmE1?=
 =?utf-8?B?Q0loWEJYU3FIRmx2VU1EODhnSk1GZk01cnQ1cExvUUZJWktvYmZ5K1RYUnRt?=
 =?utf-8?B?U1VSbWZxRGFIMEJsT3liclVFZVRWeUV5UTduVVVkVng2S2xRNVlVSUx3MHNx?=
 =?utf-8?B?MG1xZ1lJdENjSmhsbC9yNGtOMm5VU0RyYWczSnlSNGZnT3IzWjVzUitZYXpJ?=
 =?utf-8?B?djRSaEVlaTkrc2lQMnZmUXd5MGhyR2FHOFZ0K2YzcVRBYW0rcHVPTUJINVRD?=
 =?utf-8?B?Vm5ueTZoVlFIUzNRNXZRby8zL1pTUnNOa3o0YmhZd2diRW40amM2dW5IejU4?=
 =?utf-8?B?aE52NDg5dFR4NDlicXhXYkJGMWJEcTlXL2ZaNVloUVBGUy9BUkIrLytnR2pF?=
 =?utf-8?B?NC9rVzhLd2lQWDNmSWRreUZLWW1YUktKeUpkN2x5Y0JVeDBTaHJPbkdseWpz?=
 =?utf-8?B?VlJ1VUxnK0Faako3UnFJWFNVanBKS2laaHJLbTVPelpHME9Ub1cyR2U4OGNI?=
 =?utf-8?B?Y1BTV1gwekpiNUdreUswaDlIdkVKbVdUaXl1VzRuOW5CcHQxVUtSN0tKVGZ2?=
 =?utf-8?B?eXZNT3hsd1JxV3ZtNlJ1dmlGZHVSUmtxVHFHc0V3bEE3ZVk2VlBNVjE2ait0?=
 =?utf-8?B?WXdpemVVNXplbU1aUDBVWHQrVzRiZE1XdjlMenZSQ0NpclNBL3FxNFRVNGxZ?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1963687F85CE5745AC864C479131709E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62460a73-9073-4ad6-aa8b-08dcc01baf76
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 06:53:51.9576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/k46TZn7/V7yJwVHemh1AaN83RTcqD6a4Ojlg2pGjGSNzVbbnX5JhTokMIoWX+FvpkKNzlr7OYf6rL8MV1NsSpyZw/nQGyRx0AELlrg0AmRf7a/WMJk+napdgVJ10uk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7176

SGkgSmFrdWIsDQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaGVzLg0KDQpPbiAxNi8w
OC8yNCAxMDozMSBwbSwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gTW9uLCAxMiBBdWcgMjAyNCAxNTo1NjowNyArMDUz
MCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+PiArICAgICBpZiAobmV0aWZfcngodGM2
LT5yeF9za2IpID09IE5FVF9SWF9EUk9QKQ0KPj4gKyAgICAgICAgICAgICB0YzYtPm5ldGRldi0+
c3RhdHMucnhfZHJvcHBlZCsrOw0KPiANCj4gVGhpcyBpcyBhIGJpdCB1bnVzdWFsLiBJZiB0aGUg
Y29yZSBkZWNpZGVzIHRvIGRyb3AgdGhlIHBhY2tldCBpdCB3aWxsDQo+IGNvdW50IHRoZSBkcm9w
IHRvd2FyZHMgdGhlIGFwcHJvcHJpYXRlIHN0YXRpc3RpYy4gVGhlIGRyaXZlcnMgZ2VuZXJhbGx5
DQo+IG9ubHkgY291bnQgdGhlaXIgb3duIGRyb3BzLCBhbmQgY2FsbCBuZXRpZl9yeCgpIHdpdGhv
dXQgY2hlY2tpbmcgdGhlDQo+IHJldHVybiB2YWx1ZS4NClRoZSBmaXJzdCB2ZXJzaW9uIG9mIHRo
aXMgcGF0Y2ggc2VyaWVzIGRpZG4ndCBoYXZlIHRoaXMgY2hlY2suIFRoZXJlIHdhcyANCmEgY29t
bWVudCBpbiB0aGUgMXN0IHZlcnNpb24gdG8gY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBhbmQgdXBk
YXRlIHRoZSANCnN0YXRpc3RpY3MuDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMzc1
ZmE5YjQtMGZiOC04ZDRiLThjYjUtZDhhOTI0MGQ4ZjE2QGh1YXdlaS5jb20vDQoNClRoYXQgd2Fz
IHRoZSByZWFzb24gd2h5IGl0IHdhcyBpbnRyb2R1Y2VkIGluIHRoZSB2MiBvZiB0aGUgcGF0Y2gg
c2VyaWVzIA0KaXRzZWxmLiBJdCBzZWVtcywgc29tZWhvdyBpdCBnb3QgZXNjYXBlZCBmcm9tIHlv
dXIgUkFEQVIgZnJvbSB2MiB0byB2NSANCjpELiBTb3JyeSwgc29tZWhvdyBJIGFsc28gbWlzc2Vk
IHRvIGNoZWNrIGl0IGluIHRoZSBuZXRkZXYgY29yZS4gTm93IEkgDQp1bmRlcnN0YW5kIHRoYXQg
dGhlIHJ4IGRyb3AgaGFuZGxlZCBpbiB0aGUgY29yZSBpdHNlbGYgaW4gdGhlIGJlbG93IGxpbmsg
DQp1c2luZyB0aGUgZnVuY3Rpb24gImRldl9jb3JlX3N0YXRzX3J4X2Ryb3BwZWRfaW5jKHNrYi0+
ZGV2KSIuDQoNCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9u
ZXQvY29yZS9kZXYuYyNMNDg5NA0KDQpJcyBteSB1bmRlcnN0YW5kaW5nIGNvcnJlY3Q/IGlmIHNv
IHRoZW4gSSB3aWxsIHJlbW92ZSB0aGlzIGNoZWNrIGluIHRoZSANCm5leHQgdmVyc2lvbi4NCg0K
QmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCg0KDQo=

