Return-Path: <netdev+bounces-117905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A1F94FC21
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 05:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92D9282C1E
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 03:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A38818EAB;
	Tue, 13 Aug 2024 03:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Kw87Qj6s";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zx4rCEMz"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7A114267;
	Tue, 13 Aug 2024 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723519014; cv=fail; b=OXITnS5Rbl9gbLOE25eNJAAQfkCugiJ0jTCB0kbxN+pGBLMqJFBIMs5HFIO4dlB5XLccnYh6BR0s6A8uB1BcJJwwhESke66psmR6APQ1GzU2/vIbfMIMes3ZYn/VHID7g3dh9u4JQuSJT2wwGrYuOVW2N72X9PjhgrSj6yx3uWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723519014; c=relaxed/simple;
	bh=BS9loVBo/HzJ7IWKa8USzlCCokUqI00L9O/bFufPoCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ahaJERPagtdpJdIQsKyMoZVSjBydG8L5jd9UtzSCWxYsqw7de6INvz+iW8jIDK7IcTjx8esOcec+XyyKyK792HScEozKabWWELU9oTrc8jro3v3OAz7IypcEFGApVA6IHGlXkpFKmDckr9XUqs1uFo6ypmEClR+FmA5XM8unHf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Kw87Qj6s; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zx4rCEMz; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723519011; x=1755055011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BS9loVBo/HzJ7IWKa8USzlCCokUqI00L9O/bFufPoCw=;
  b=Kw87Qj6svUKJgPvott7VJGSYY3aBsG0wFnCSnrjdlQRAedqt6IN1Tf/J
   SxV3FHp7PcOPH/IhJrzxdPzLkdq08XaYhyCxw5X8TllQrB2lx9kBQ1Rg+
   I0rJWp4XDHdnjjeDLVE+AvkLwsXRVitItg8tuwEHxWQyJAQuFqcRPeNS5
   oFaPNkmSzv7+9mspQX+9AlN+kt3Yps2bo7Hq7r3PgOxJNfwvwZSLSI+he
   jKavsHfI1W1nr31yB8VTO9zlZZV6VDcyXh/oQFwUjNfU4LctrOhdLt5rp
   aGS22kcdi/zuZ0ggYktzj29TIHiC5UzqRVTSME5SzObkQJMLsoG9lQFqf
   A==;
X-CSE-ConnectionGUID: Se96P592T0O4lrM1J1uEEw==
X-CSE-MsgGUID: Zn32Om+LTGakKdTPB1PInw==
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="197836812"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 20:16:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 20:16:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 20:16:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p55gbons91H7bz8MeWESc78A0e/iq0YKE4Nxl+YruTsBcTOqzh+bmVm4Ij6gdCEkwOMkSrg1kkwEFy9CKVFqdN+gwQbjfF4H4yaLmP+g8XVnbETYwC5ZyFk/sk5EznGNS6kXRHtQnlHypnnyXQvojYpB4z6U003BEloe1AK2oxXJdGgCk/xM1e4p5ebyfJR0dcyHL2VNAVTdUfzA55/Y3K9fQcMjlOy5J4HVXTq8po0Y7hgqcEfgqCX6IC3i/+KpwFC1sjX8KglKinZMS4WQHR557KTL6f+yWNbiagFvG6yJzgy8N30hwy0NLfk0qZaJ7obJe5lNORB+pqaUN8ZUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BS9loVBo/HzJ7IWKa8USzlCCokUqI00L9O/bFufPoCw=;
 b=e3LPRc811iMYWmoNjXQb37eD226qBSY8B+D4luqTKh7mZYFcUS2ENcH0kSw36qppAa3QBVz0Of+g2BUfa9XLMBb/NcS5TypT3Kgv53sQkwWP5/QXxGQNeecUVxdMlUFPn8B7Ol31weDWtTLZAOyZUEvgVaIcljs6vsX3zFnw3ErI4JYBTkzAmGrlLPCQnHO34gWYnHOUQ58pTck0C3eM/kh2s+Ds/3VFzMvirGgCvfdMhNlDwcf/Q7qt0wuRuhYFKxqtcE+L7cBz9WGlwcrl5DX2fAkm6da4W3b3lKyV11kxTGe0BQz1lBlrXLJF8QjU1oZOqnPJXm1KtOwt+7uG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BS9loVBo/HzJ7IWKa8USzlCCokUqI00L9O/bFufPoCw=;
 b=zx4rCEMzkXEQesivFd/IGTZFInrpclvLSo0VfCRNF5rarJhpf+ptT5ZqFGaThVApyyp9rV1uoSu+PyFV+0vv1KmP2jlRIgLhjivJO0ECeBpm2yl2ZOrARRyC2gQ8qoINZ7kJvU3qjDz+VM3CnV9B/BI2AMtX1vBj8kLgKNJwb1ijoaB0TllfoF4Sboy4OCxGWUX6ei8HS0iyuLF9JIe2VcNo/vl6STt/ulZPzXDgkXs6MpVzhLZQcKTZFqan7UFsEGBU4rqO2HuVn8xN7VOk65ptRUqPNKoe6vp+UJemixEsubcb3pKlg5pcQd3l/TcKUUgeHPE57l/ovbtBowDhfw==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Tue, 13 Aug
 2024 03:16:28 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 03:16:27 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<linux@armlinux.org.uk>, <conor+dt@kernel.org>, <Woojung.Huh@microchip.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <f.fainelli@gmail.com>,
	<kuba@kernel.org>, <vtpieter@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<marex@denx.de>, <edumazet@google.com>, <pabeni@redhat.com>
CC: <pieter.van.trappen@cern.ch>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 5/6] net: dsa: microchip: fix KSZ87xx family
 structure wrt the datasheet
Thread-Topic: [PATCH net-next v5 5/6] net: dsa: microchip: fix KSZ87xx family
 structure wrt the datasheet
Thread-Index: AQHa7My1QsAHifRBBEqy76cs2qbu+LIkhW8A
Date: Tue, 13 Aug 2024 03:16:27 +0000
Message-ID: <1b0f215df4b8cd008e07e682ee9de191b245e186.camel@microchip.com>
References: <20240812153015.653044-1-vtpieter@gmail.com>
	 <20240812153015.653044-6-vtpieter@gmail.com>
In-Reply-To: <20240812153015.653044-6-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SJ2PR11MB8452:EE_
x-ms-office365-filtering-correlation-id: 7f41cfcc-7d7e-4ce6-e20b-08dcbb465210
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VTR4RjhyM1h6ckc1cmo5Rml0SXgvOGZtOElzTXV4Nmc2SXFaWXc2M0MwUC9i?=
 =?utf-8?B?U2pBQmJiNUNSRXhrbjJuQnQ3dXppaXprSlc4S05HSjVqYTlaYUZDV2VwV0NV?=
 =?utf-8?B?eTcycXcyYVN0TklUUHIwZnVLSTQrcTc4Sml6Ti9Db2NHZ2lMWDZ2dldDbjA1?=
 =?utf-8?B?SjVDUHU3UERPbmlvZHBLb1NzWWswb0JoSVNaMmcxSFl6WVVtTzBpSXFmZEp1?=
 =?utf-8?B?WW5TQ1E1UDFXZG1Vb05WdWpoS092UTRHcXpaWFJlNE1EVDJBdW5IUlFkSXNT?=
 =?utf-8?B?MmlHR2xyYTU0cHJjRGt2ZVhmWWRPaUR6T08wK1pDeVlEMEo3cTBjWnVWSXpD?=
 =?utf-8?B?eG9nQlc4d3g4L3JMUTJaSFo0b2lrSlIzZWtnbm1lSUZ0cHAzSWltU3lhU3dY?=
 =?utf-8?B?SENlb2JSRWRBcU5CUUllRW9DbUlPT0d3MzEwa2xOUTlrYy96K2V0Rm1McXVt?=
 =?utf-8?B?bkwvNU5TdUNVTXUxVzBjK09CUERpZDc1dWFJNGpTb3A2N3Rjd1RncW9PeFZ4?=
 =?utf-8?B?OGtDbzd6OEtmVnRKRFplSnBOQ1VYVjdpQ0Q3dFJKbUpJN3hkT0FVdE1Tb3pa?=
 =?utf-8?B?am93cDRNejg3eVBFWlFxTEx3NHBYUGVZQUEwNGJtSUZyZkVYOEhjSHUxRlFs?=
 =?utf-8?B?Wkt3UklCVXVuZ3A2VnVnN0ozSy9UWGpNTzNqaDBseUhBUGR2Z2hmODhya3NZ?=
 =?utf-8?B?SG5WODh6VEVqK1I1OVJ1K0RybHZRdkpVaVBKc3djK3ZMNHk2SGxqYU9NMVZM?=
 =?utf-8?B?SDlwZUVsdVY4ejhycWtUeEgwZnB6TTRyTHhBaXhjZFJWT3dRUUQxNUhPS1NY?=
 =?utf-8?B?L0NjT1Z0all5d0FYaVIrd2U4MzZaN25mdVo3dDBPc1l5dFlsTUxUSXZFYmlT?=
 =?utf-8?B?UWZUK2dxUHNzQkcxN2xzTDJkS1hxT0xjRVZ1b0Y3MnNkL0MxOEEwWXREaE5O?=
 =?utf-8?B?RnY4UTh0RzdOSnBhWGh3UXVQcnY1WnpjMlg4UTVWbStQajhNSkRVTTdydVlX?=
 =?utf-8?B?V01RK3hISzFCcm5OQTk5Sm5teFhCMzFDNzVldlEyYkN0V3VHbUE2cGp2RVVO?=
 =?utf-8?B?WnU5NTFZbC94ZDIrb1JBNmZBbnZsNEpFOU85ejVFN085M1ZNM2NRVFVDUC9p?=
 =?utf-8?B?Y3BmRXVPbW0wQlJXTHhoT0hnQVNmelZjVzVFYUtDU0F1YmdrR1NTNEhDN0d0?=
 =?utf-8?B?NUtGTkpjWDBKbG1RTUcraTRURW1wcmhBbnVXemRiS1BIdHMrUnhPNlhXNHIr?=
 =?utf-8?B?WFZMblA2Wm8yRElzYTVGR0p6REEyUUExNGZPUG1PZ1FmeWo2eXhoUG53dTNU?=
 =?utf-8?B?ckoxVGFGU0x4STFKdSttcWhuMkpHKy9qKzZvc2xzLzNDUkdBRUdvMzVDWmRp?=
 =?utf-8?B?VElWNHFxOUtNUFBRaEhxZTQ3VXNYYkF3SEhoRjRtMUtTeEpReE5DR1RuckRV?=
 =?utf-8?B?UkdoVGUrTk00VTN0Q2NuT1g2WkQzeDRtQWZ3TUxRVU41UlR6RTFlNXo0OTZU?=
 =?utf-8?B?MjA0czVuRDVRUWUveTh6Mnl3cFU0aElsRUx3WlowcitDRlRBSHMxeW5qRXEz?=
 =?utf-8?B?K0pKSFNhcG1hTzVRUXZoYlVFbW53d2lpS0ZibVdCSDJET1FmRmxYSk1sSmJU?=
 =?utf-8?B?NlhYb1NLS2VCTkhBOTFOQlo2V0o2eGY3TUUzNmN2UU9UbEFBNzFvLzBsa2NW?=
 =?utf-8?B?R0FhT2lpT2dTUzhVN3V1MFdBcC8xVXg4Y2tBWUNPRjZLbng5UnkwSU5FZWJn?=
 =?utf-8?B?V01JYzV5Y3ZZbGMxSy9IWWQzUjQ0RVVvanF1c3dwemtvSHdzRy92WnlMNGRK?=
 =?utf-8?B?ZEVUeHI0TFJHOXQ4cFlrd2pjS3NJUDFtb0twUGpseWpkZ1NDVThQWmF0d1R1?=
 =?utf-8?B?aVpVZ1hSQXZXaDdqTHh0Vjk0WEVENU9jdzI3SWpja2Zac3ZUd0VXTTBhWFA1?=
 =?utf-8?Q?75iqwGXiOT4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2czM0ZNVHpubXRHSnpOZDNJUXk4cDlEelc2b1dnbVFFekYzejBFMlFwQ21y?=
 =?utf-8?B?a1N0WWE3WmRIS3hsOTRmNmkxbURvSU40a0R6NmVLSEsxLzNWUmN1bjJOdGtx?=
 =?utf-8?B?c2Y1NENFZ0MzRDJpdXNyTXNyRHcxVGdySWRUb1hZVGNvTVFRNXJqbFZtOEVi?=
 =?utf-8?B?bGo2K1BNSElFNmdWQnJWQlJuckZhNlNBV3NHdjRuNUN4SUNhRDdWNlN5Um5I?=
 =?utf-8?B?bE12ei9DaWwvcDlmQlVuL1NaT2sxTk9YS2lEN0RKMlV6QWVOVnZWYlJwTTdo?=
 =?utf-8?B?cmx0em9leDA1bnVMVFQxUFdLeXJTampDZm9BOFpyYUNCcUpPSG5RUTlYVGFE?=
 =?utf-8?B?SmRTd3l2U1A0T1FUVTIwM2lzZEhOWlg5MXAzeWJsWEg1VDBGMVVXVERKL1Rq?=
 =?utf-8?B?U3BTdjcxamMrWUNpRmhpa2k1Q3BSWUFXeXNkb1Nub0JGMXZrK2wwL0tjdDF5?=
 =?utf-8?B?eUo3cVdXNFBMdU5ENHA0NGFLRHlxcm54RWVJb3BYRzdlbWg4bDNPalJvQjJ6?=
 =?utf-8?B?eThLVFA0anZCMGJ6Y3dzQzV5REVDanlMTFJxTXlucm96YXN3RGxLby9qZHdj?=
 =?utf-8?B?OVpxTU5WV2ZZQlo3aTExMlZzT1ZyYXdXN1cvWkIvV01jQUE1ZGYrcmNuZHpQ?=
 =?utf-8?B?T2pIc2U1K0p0cFFJNFcza2ZKY3Z5UjcxWG9SSVRSbnRIdE1iTEVtVXZFSDZj?=
 =?utf-8?B?dnNjQ2U3T05HaHM4WTFSV3J0MktyeVJvVjREdEV1V0M5MFlUWjlydGlmZ1JX?=
 =?utf-8?B?bGNtSGEvcnBiQnN2TUZIa01YdEhZT284YklmRVJOS2VsVGw3YlI4UVdnRnph?=
 =?utf-8?B?Sm94d1dDblZhSm1BZ2dMcjFHZGppWjFheVJ1SU4vbzZhV3FFdFhDblROSjdQ?=
 =?utf-8?B?b3Zsd3JkTnQ1Q3IzUGJvUnZyZmhLeDlaaXZqTUJtVmp3MVVSKyt0UTdoSkVT?=
 =?utf-8?B?MGJza081ZmMvUUkyYjlBUmt3T0pvNkJsS3BEYXMvVkdLem95aS9kb0xBVnd3?=
 =?utf-8?B?azBUNm1Ib0NTNCtOU3ZWNkZjYmw1Smg1b3BUNFhFVFliSWZoWWtINXlzMFNh?=
 =?utf-8?B?OEF6SUZNREFnNVRXUDZ6WDdBeEQrUGpRd2JtQ2pUcmMrdHZPUFUyWFRxQS9T?=
 =?utf-8?B?b25UazNmYW9DUW1aTXZ4a3lBK0cwOGdDbmU3R3FhVHRGNStUV2FINEtoZUdK?=
 =?utf-8?B?WWRkOTFMZHo3eTkrWDRwcTBLNDZyOTU4M3JjZUxIVVZGN2FMUmJIK3JPd29q?=
 =?utf-8?B?dHExSlQwNzJ2RURjVUxrR2NyWkE3TWs4ZitqSGk5UDhmc2hjek9SZnA2VHpU?=
 =?utf-8?B?QXdUYjQ2ZEFqYmJTTWlVZVZwUjl6TzZ2N0VCcVRYZis2M202b0ltS2xMMUto?=
 =?utf-8?B?ekNrQW4xVVFYd2M2SVRqaXhTK1BMVng3cmZERnA1cG5Wc0htSEZweXlzNURF?=
 =?utf-8?B?Rm5lMHJpcyt5RTM2VFJVdGZjL25jcGNvSWdRbXVwNjk0cnhMdVRVTC9NcmJS?=
 =?utf-8?B?MmIwNDU2L3QxcFNrcCtWVFQ3L2Q5eXp0Y243VEJUcFVYU3hRMDE5RDVwYVUv?=
 =?utf-8?B?ZWlYYjZGYktQdEhQUnEyWEVMME5zOXptaTVzR2Nsb2xhc0ttSVdBWW9MclZR?=
 =?utf-8?B?V3dHdko2di9aekhSYXJKeS92VmNRd0F3dEdHVnpQODZQdXZkUWIxck1OV2Jh?=
 =?utf-8?B?UzJBWXZsRXl0NHpwMElBRllDempNRS94b1pkYTE1QWRES3pwbGdRQUdzYkkw?=
 =?utf-8?B?U0dPTVNKaThQY0tFQ0JpNUhFTU1RbjRKUTdjM1dUcEdNdUoxcndYbG9LUENQ?=
 =?utf-8?B?OUFhSFhIb0ZRNlhtSS9xNFRaeGlXbTZXbFVIQWlRR2RyeERGVEc2RE1NRGo2?=
 =?utf-8?B?bVE0ZFBZZy9TV3NlaVB0d0RWN1ZibTlscE9sdVFkcG02WlV6L0NaY1A3N09H?=
 =?utf-8?B?YjdOWGRMNkN2MUtMOC9ybytYUE9kc3VxQjlNc3plNGZ6dW5zR2x4QmY4ZEhy?=
 =?utf-8?B?K3RiSWRkdEtZbExWbDhwaExvN0d0Q1RYVkEzTkpTNXdwRExzY3YvaUJhNlNu?=
 =?utf-8?B?SXlZMi9Jay9CMHhxRWNXNmJUeVJqa2tqL1lrR2hDckNmMDdTdkVLazlIWUlV?=
 =?utf-8?B?Q05ValNHTlBrUjV0MjJwVDRzZVVzZSs3d3MxMWIvQTNBS0FaWjlsK0kzbUc4?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77013887FF68D741904A0EA073C6E4CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f41cfcc-7d7e-4ce6-e20b-08dcbb465210
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 03:16:27.8137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyq+9waA/sWfGcaE3F1R1FCm4pvsM6pZ9bumJgKMJYx9KnR2xHHiy3ARHqCMipDSJ/Yr1K3okTIcBlVIIMCCzaNpyrV30ftyRt7Bqf9DSBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8452

T24gTW9uLCAyMDI0LTA4LTEyIGF0IDE3OjI5ICswMjAwLCB2dHBpZXRlckBnbWFpbC5jb20gd3Jv
dGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTog
UGlldGVyIFZhbiBUcmFwcGVuIDxwaWV0ZXIudmFuLnRyYXBwZW5AY2Vybi5jaD4NCj4gDQo+IFRo
ZSBLU1o4N3h4IHN3aXRjaGVzIGhhdmUgMzIgc3RhdGljIE1BQyBhZGRyZXNzIHRhYmxlIGVudHJp
ZXMgYW5kIG5vdA0KPiA4LiBUaGlzIGZpeGVzIC1FTk9TUEMgbm9uLWNyaXRpY2FsIGVycm9ycyBm
cm9tIGtzejhfYWRkX3N0YV9tYWMgd2hlbg0KPiBjb25maWd1cmVkIGFzIGEgYnJpZGdlLg0KPiAN
Cj4gQWRkIGEgbmV3IGtzejg3eHhfZGV2X29wcyBzdHJ1Y3R1cmUgdG8gYmUgYWJsZSB0byB1c2Ug
dGhlDQo+IGtzel9yX21pYl9zdGF0NjQgcG9pbnRlciBmb3IgdGhpcyBmYW1pbHk7IHRoaXMgY29y
cmVjdHMgYSB3cm9uZw0KPiBtaWItPmNvdW50ZXJzIGNhc3QgdG8ga3N6ODh4eF9zdGF0c19yYXcu
IFRoaXMgZml4ZXMgaXByb3V0ZTINCj4gc3RhdGlzdGljcy4gUmVuYW1lIGtzejhfZGV2X29wcyBz
dHJ1Y3R1cmUgdG8ga3N6ODh4M19kZXZfb3BzLCBpbiBsaW5lDQo+IHdpdGgga3N6X2lzXyogbmFt
aW5nIGNvbnZlbnRpb25zIGZyb20ga3N6X2NvbW1vbi5oLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
UGlldGVyIFZhbiBUcmFwcGVuIDxwaWV0ZXIudmFuLnRyYXBwZW5AY2Vybi5jaD4NCg0KQWNrZWQt
Ynk6IEFydW4gUmFtYWRvc3MgPGFydW4ucmFtYWRvc3NAbWljcm9jaGlwLmNvbT4NCg0K

