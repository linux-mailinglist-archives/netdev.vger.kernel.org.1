Return-Path: <netdev+bounces-118116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C37DA950922
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471691F25904
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50161A01DB;
	Tue, 13 Aug 2024 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zyRPsCuE";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="6cBQuBJ3"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D419D886;
	Tue, 13 Aug 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562986; cv=fail; b=oHZM+wtjpyQGnBp5ZGDF7Nr/bU47QiqIU/RZK0BrlCISqcQNrqvbs7Vd4re5y201JMYZJMYHZn2D1heRhfgxLisbFS84nz6Oq1hUC1FKcLTPN9MLepW7Pfht6zGGiwCmya+43qcq0pzIKQBqF7k+1NEKaY/iACP/apg45t9VMvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562986; c=relaxed/simple;
	bh=dWcfnobS1uOX+wn0x0YCTQHxr4wt37B8qHCQgo/yzdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iAjrfy7BrWA8wTdF2D1xvlXnOKsvuEE6/bmnQFN9TMpltiWFXcVGLQgrpot4b3kadc4bLYqgo+QsjynJgYOOCcW38Cxjcbjb7cGhJSfARkDVL0KOvEBl9SY8NXZaNTy1D+zaIPn8rRyXThfmjzjbTBmmoeSWXNWSAd9m79JbFoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zyRPsCuE; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=6cBQuBJ3; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723562984; x=1755098984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dWcfnobS1uOX+wn0x0YCTQHxr4wt37B8qHCQgo/yzdg=;
  b=zyRPsCuE+56f6NdPAMvlCw69mpOlmkJiCsLK9db9CvSorOq6+uodR6fp
   ePWlkQ7K060k0YQpADjqRYuPAQ67H16jYc+tFgU76omyJTsPLUZLag5/6
   zc1JIQ+/IJAl8Qy0lNbAcw4fiKLhHVs7bt8dDrJMMdhFVCbxAGaDO2LGZ
   QKGu9g5eA+YyiVuNNw2Um2CYXAZ9OhObv6/4/jMXlMj/a6+CsXaZ+LgKM
   eRSj0YMSmlucIoAlrdpnZRCqu2gyX3PIZa+dKxYosqLiPL15Gti0bMOu/
   g8pvZD7ZsYvOkqKVG3/kSDwOuC07wDS2ppnVMTb69W88wO4nO01YorS5q
   A==;
X-CSE-ConnectionGUID: oLwLdNHdRACF84guHmXO4g==
X-CSE-MsgGUID: wDuGK7rKTdWnMFRGooee9g==
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="33359358"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 08:29:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Aug 2024 08:29:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Aug 2024 08:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOHxDvXs0HNAmhufb4DT7elaFGPj7jc87hGMP4nQWOypN/MhSNDjA5M/seuQDQz1iSYfhrCjDvTfDlQCpgW0a7AEKzXz2rBHNn1tEb13RTu2835sSf3fPACAfE+yTMWgDLoTeYUGjE5cZAdIWDuJ8QKEF5S2LHD76kloKO8ATrrwYYXncdTo0Pkv/3jkQwvYhwymhncT1l4GKzKrkuGDJZo4W6Zn5rTYk9Vqx6T7v+QpyqGNueIjl87l3ot52xjffciZSbm5CRXcHCu4egxR2JTipIU5/rt7xow91ZqU1eSUi7fF58d5u0/Zx2/onqdBS+Gaqnxz+D82U+zz5/esOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWcfnobS1uOX+wn0x0YCTQHxr4wt37B8qHCQgo/yzdg=;
 b=pdwR/tX0LA98O8Q2A+7bzHdgdn6ZV8QwUtMjt2Fxz5IuGM3AWYrIUhJFx3mmuIL4RhzQCx3NFlaoBlgGcY34zPdU84aKfb787IJiFZyisxTyeoM+6E4fy7PWW4SXV70iAXvIPf8ssNwZtBnGYPxjP/SVht6wUBS900ZMMfk6DTEhSBWKD0NNSjupEOMm+Q3kxsJ5f8eoZ4Z7YQW8K161xbJRxTVlH67rsnzmeVifQ+a/Q7sJBFJn+neClJs6ejh/rK3Fm8pExDpSfUPDJhpxg1EqwaCs9cIQ4TOiDR6xTHl/VI1m9X+UHm0J/mIYnRCItHxvV6YECZbCEJjWaIIXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWcfnobS1uOX+wn0x0YCTQHxr4wt37B8qHCQgo/yzdg=;
 b=6cBQuBJ3+5vJkWsrnJE3nWv7XbE/SD4jua3zpNExvmDzxIusSyZr0slGtw9oWkYVThTz+AZ+zjuCQU18XAuANmRfKEK82lFrvGJ7qDQo1cq+M5hlsGyVG1VfInmjBpfgU/S6UUwewKAQgm9rJk5KRu10eZ1hPrcqPivEsB/SgX10YPX1MsatrwAL9lLEsONBjMKdQvbKH9luxjfMyJMnWb7ffbUzZ8rFMjoRpZ1AT4nJH3JOrqs0RSNjcBYv5e5lWymyH30x8Bsopv96jRPEAw1A98KhvfRxZEU2glMvb7TyAW+IUxATkO7KOBuTEnK5YZCubHFPqAv8HTfc15d+HA==
Received: from SA3PR11MB8047.namprd11.prod.outlook.com (2603:10b6:806:2fc::22)
 by DS7PR11MB6223.namprd11.prod.outlook.com (2603:10b6:8:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32; Tue, 13 Aug
 2024 15:29:31 +0000
Received: from SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::a585:a441:db24:b547]) by SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::a585:a441:db24:b547%5]) with mapi id 15.20.7828.030; Tue, 13 Aug 2024
 15:29:31 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<conor+dt@kernel.org>, <Woojung.Huh@microchip.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
	<vtpieter@gmail.com>, <UNGLinuxDriver@microchip.com>, <marex@denx.de>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <pieter.van.trappen@cern.ch>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 6/6] net: dsa: microchip: fix tag_ksz egress
 mask for KSZ8795 family
Thread-Topic: [PATCH net-next v6 6/6] net: dsa: microchip: fix tag_ksz egress
 mask for KSZ8795 family
Thread-Index: AQHa7Y07F5aRuxremUSM9SH5X8+JsbIlUMEA
Date: Tue, 13 Aug 2024 15:29:31 +0000
Message-ID: <44ba6d0c221a4426ceae4fd61f77166bdc346f73.camel@microchip.com>
References: <20240813142750.772781-1-vtpieter@gmail.com>
	 <20240813142750.772781-7-vtpieter@gmail.com>
In-Reply-To: <20240813142750.772781-7-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8047:EE_|DS7PR11MB6223:EE_
x-ms-office365-filtering-correlation-id: 579b808b-2de5-450d-3c8f-08dcbbacba74
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R3RRUkVQTmoxMlZpVEljazFEZ3kvWTlrdy82VGNUYWt4VnhWbmc5emFJSVY3?=
 =?utf-8?B?aHNQOTJ0TGErYnJqS1A0SUNmblZJTEc5SXdHcDd0d2taQmVYV2NOUFA2S0hK?=
 =?utf-8?B?N0hmSG1Xb0lJZUtMTHNSUEJ1bWNsQ0FvV1UrL3MwN1B3bE00d3BuR2F2aWVY?=
 =?utf-8?B?VDRGamFzS3ppVEt1NVRxZXA0eGxxNzNSL3F0d0VORmx6WjQwRThVRTVtN3h4?=
 =?utf-8?B?YmFtcEh4dmFzZXNYQ285Z21ZUUNEcHZrL08rdzBHTDFwNk0xc0VkdStwSm54?=
 =?utf-8?B?eFQ5Rm50K0pvaVdqT1U5Z0xMOSt1MGlabDRDU2FIa2hkcE1sam5VbGhlUkoz?=
 =?utf-8?B?a1dzRm1EQllrNEIzd3U2VlExOVcwVkNSNFIrd1VmRHFoTVh5SmIzRCs4djhI?=
 =?utf-8?B?Q1pPQkJuZS83QjhZcStaSDd5NDU1RFJ6dE4zZlJDYjlFTnNWKzBoU092cHh1?=
 =?utf-8?B?Wk1TSDMwYU1CSVFOb0NlQlAxekNaSzdmbzNJaVpFZ0haMGxuWk5kOWJtcmUr?=
 =?utf-8?B?Rm1pa3JXT2hxSm92WkY1aHY0akJWa2VCNHo3cEhHTStUZFAxRjdlZENGYzBu?=
 =?utf-8?B?L1RWMXdxS1hNL3FsNXdsMkc4Sm5NaVFJTGpZWGJKYVU2Q3NGUCtyUWpSMTd0?=
 =?utf-8?B?ZDNaeTRJei8vR2Y5SlhuVXJtZENrUUZ4RzJ1aVJlMVIwY0hRRmhnamRjdDlN?=
 =?utf-8?B?dUlWNWxtZkhjV0t1Tlo3bzZOZm0yaHRFSG1DZVRmQTR6Uk9mZlpOWE9Sa2lG?=
 =?utf-8?B?RXVpaElkLzRWWnFGQnBCcFFvOGk4WjViY1hOZVc3NHUrdGRsRXhVQWM1YTVN?=
 =?utf-8?B?dEV5YS8rSkdUU3Foc2FQcVJZaUQ1U0xUbThuWXFmMnIxdm5aWjNDQk1XNThG?=
 =?utf-8?B?V3VXVTUyQlNRWFJGV21KSTh3RzdWRXJTQ1pYUWJsSVNlZ0g5Qk8zejFPbUow?=
 =?utf-8?B?cWdWMCtZZ2I3c2xsYm42M2swdk9YcDFRWDE1Q2RoUnBVY040ekxNQXpadG9t?=
 =?utf-8?B?bDE4TVpJcjg2Vk5vMzdJU1ZjanhGRjdiVUdNN2p2dnZXakFHdjE1U2doZzN2?=
 =?utf-8?B?ek1qNDlVZ2lXUnp1bXVqSjYwUngzNGRZTWxUa3VxMUhEOGpxUjN0cUxBYWNO?=
 =?utf-8?B?VXpRNkxVNzZNSnVtVXFoRkllUU5SUk9hRnkvRllWZGE3dlJ2R1I3b2tZTkJN?=
 =?utf-8?B?RFBaZ1RtQWhUU1FXVG5aL3RuMVRqcFFqVzAxdXlLTEFTMWg2WjJ3KzNlK2gx?=
 =?utf-8?B?Y1pTby9PZjdLVXo4WGhUM3hMUE1kR0pkc1Brd1NEeU94RS9pQUFmcFcyTTZI?=
 =?utf-8?B?M2hMTkZ1bmVWTnBjYmNZcjFvOW1TSlIySmZjbyt0QVEyQ2VFYVNjelhvMWJW?=
 =?utf-8?B?dG5JVlZSeWZQclFTRUpwVHd2TStsdXQ2ZFJGNUhwaXBhUGFxMVgxdkg1MzJq?=
 =?utf-8?B?TnJLeHZuelBuYk1iV3ZrWE0rVUpJSzNSMzFOamVpaFJ3WWhrbEMyUDNMNjhW?=
 =?utf-8?B?WFRkWWwwNTRVMFZtVE0vNTBTTnA0eDFTdHFsMXRtSGYzcmhLd00vc1BxYXpS?=
 =?utf-8?B?V1FmSU5NNnFBZ3JTaDNDSG94MmJ3YUZQbEVLNzJYdzk3ajZFMXgwR2dJNzBs?=
 =?utf-8?B?WjhBYTllR0Nxayt0VGhuSmo0V3htekFHcU1HOGxEVEMrd2FTTWpINWd5a3V6?=
 =?utf-8?B?WlU0MVdkWTNSU0NJaTEvajE5MVkxbGlOd3FPSEVPS2NFSFk2V3VQZXRvYXdG?=
 =?utf-8?B?Q25MdkhFQVlJWUdTaXRENXlUME1ieW1YT0JVcHN0dWZRUmtCZlNNTWh0Y0N0?=
 =?utf-8?B?N1g0NGNqWTNlV3FIMjVRK2pod0kxSFRJQ3hXcldkQXNYaDhsQkNBckpiN1lk?=
 =?utf-8?B?TDVtL2NiU3AvSU1pcmhEMWdtaXhQQ0diMlFYblRLMEt4OFlJbnhDWXRqc3Fa?=
 =?utf-8?Q?OJ1Jj/8CXw8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHJNZWF4UzlQalFYaVJlbmR6QnBtN3JPcC8ybjJEcVpSS0RwckxPMGZVL25V?=
 =?utf-8?B?NmdtWWpHSVZybXk1NVVoektSVWpSOTRjVzJHdHlwTHVadFlTSlpPTHc0MVZW?=
 =?utf-8?B?RVI5MTRyQmdsc3dNNXFyY2VUNy9CMWpXVTIyNUxRc0EwbUplL3RpOG5TOHlC?=
 =?utf-8?B?M0VzZjZOR3hUNDkyY0MyTFhCOUdRSm9vQzV2VmtyZ3dRRzJ3S2ljUXI0WkVN?=
 =?utf-8?B?dFhTazh6dnM0b1EzTjBYNXN2KzRvZTN0SkMvNFU4TVpPK2FEUVZrY0R2Rkx0?=
 =?utf-8?B?T1FkTUFQSlJPeVlIZVY5REh1b09mNXlXMXJxRTJMUXVuZkVwVEdWOFNWUVdQ?=
 =?utf-8?B?UHRsYlhvR3JhQ1k5VVhsWUx3eXVxKzF4UEVXVmZsMUw3dVBrR2I2b2pVem51?=
 =?utf-8?B?bU5XVkErRmJoMkZMQUE2bXJzR3llVVNxMkhaTTFCNGVYYjQzNDQ2ZkNnVjU3?=
 =?utf-8?B?dnRKdEIzZjJRWXRBVEJWZ0JkNnA0NktwS3hIUjBtNTh4QS8xZU1vZ2dxZ1c2?=
 =?utf-8?B?SjJQQkExQUhLR0FDT2ZUdDNkSkpSbVZFcE95YXdtRXN3b3JabmhML3NSWlJj?=
 =?utf-8?B?cHgwUnFxOEN1ZXNzL3VRNElIK2dTWFpTb2tRd2pZUlhaTERXcGxoWEJWZjd0?=
 =?utf-8?B?WlJoL0FUV054eklrWWRyL29FS0s5Mi9pNC9kYkEyVTF4QldvM1pKS290RDJz?=
 =?utf-8?B?dTdaWFcwS3VMc1JRK28vWmdoemZoOW5EYXJkZmpFRzQ4bUNjSTd2V2VIVGJS?=
 =?utf-8?B?SFJVMFpLTHRkS0dvSlE0OUdORGJsTUxYT0lGRnhPR3liSXdpNXA4ejY3bk4z?=
 =?utf-8?B?ZXgvQUdFM0sxcnJONnhua3J0ZnVOMUIwanhUbU5sQ0lLL3ZwUU44ZFA3Nm80?=
 =?utf-8?B?OG1sMEE1eitYS3Q2R21zU3REdFQ2L3lrek9tQy9kWWt5RVVVaHdCNVpQdmcy?=
 =?utf-8?B?N01JSTZ3REpieEVxdGVITUFieUh0OHNsRmpJazBKWXdzcHN1VjBvamxlVW9q?=
 =?utf-8?B?eTFDYjAxQkhyd2hCVmg2Y003eEdYbWRtU25rM0Z1MHhIU2VQdnBBOTVVNnR2?=
 =?utf-8?B?anRzeUtyYjFHUk9pdTZnM0lISS9ycnFBeERnM0s2ckNDay82T1pCeXlkaXh4?=
 =?utf-8?B?dDhsdi9qbnNYSUc2bTJhazlKc1JPRzBkL25ROXVrQkE2bzhiTWZmb2l4akJW?=
 =?utf-8?B?UHdJaGZQVXUzTkRwbCtmODBDL0pVb0tpeHNTTTRQQ1MvUW9uc2x5VjdFMlFF?=
 =?utf-8?B?dGtjVWR1akplVEFkSGZHUklFdGNhTkVIWWlEYUVBYXRBWGR3ck55NGxrUWpY?=
 =?utf-8?B?SEhacVpIekxLczlNSXFxL3FEYXdnemhPZTRWd0hsWGl0Z1FBSmZ5TCtsQnps?=
 =?utf-8?B?eDFzYzlkRmpZOTZCeUFjVVRhMmJDY1BlZXdmWFY5MlBvK0E0SG9OYkNpTzQ1?=
 =?utf-8?B?VHVMa3ovOWtEMThLS3pQMTJENFBjdWo0MHNlMVA0a2NYaUFHL2lsWGxoUWZ5?=
 =?utf-8?B?aGhpZEh6R2hnRGZodkZpaGQ0T0dVc2xEQnRRL1M2T3FwSlV5R2RWeS9yY3Q3?=
 =?utf-8?B?b0h3UGtvY3Q1ZmE0ZHVkR28vK3EyM1NlNlNpWlhLRGE0c05QazY0bzQzS1dj?=
 =?utf-8?B?V0M3bDhBVnlQTUpxZFk1d0t0Y0VrR0VFMkl3U0pWTU9iTytRZjZDZFh1b0t4?=
 =?utf-8?B?eEI0T3JUMmd3QXpCY2QydFN5Wnd5VW1JNFZPMjFNbVl0emI2dDJSczNwV0gw?=
 =?utf-8?B?OXFXTHdTcWljNmd2NEYvNENRS2FWM1U4RnZmc1BoWEtPb1BLVE1CUDBzNEFM?=
 =?utf-8?B?cW1SQUZNeU5xNElJY1IxbUtyZjdGR3NmcUp1d1QvckIrelN2dS80SXNNaENv?=
 =?utf-8?B?NDQ3ZXNpL2dCMWt0dlFFeGFkS2FsTWxsdktjRUc3K2N1c3hpV1M0SXNrbTln?=
 =?utf-8?B?YXYwZGhxbTVlRUV5Q2V0aVFJUDhrK3RYTjJnajV5TWNVMVFQZm8vMWFwS0do?=
 =?utf-8?B?Qy96aDJFOWdXT2ZzN0lxemJKSUhaVzE1OWFubmk3Rmt2cEltVE5JTnZDUGND?=
 =?utf-8?B?WGl5bDhjR1BIYk84bXVBZ0FZQUVVL3FFaG05eklHNmhLd25rUzZlbDZzSUU0?=
 =?utf-8?B?dHpDVnZCWk5lWExnSVVYNFNoRVduWHRWRzYrc0ZTN3lnalNKcklLcWFseTVp?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01049853E3A5B94B958B1E617AE372DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579b808b-2de5-450d-3c8f-08dcbbacba74
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 15:29:31.6088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmPZ4CdQkeT9uUoS3DCUjWYqIQ4uqJu3+yl/MU97+9Fgskctcmy51369EPEoFpA2f6D97HdhWc3CQINbpBCOOQOue/g6THNubehzSWh1gQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6223

T24gVHVlLCAyMDI0LTA4LTEzIGF0IDE2OjI3ICswMjAwLCB2dHBpZXRlckBnbWFpbC5jb20gd3Jv
dGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTog
UGlldGVyIFZhbiBUcmFwcGVuIDxwaWV0ZXIudmFuLnRyYXBwZW5AY2Vybi5jaD4NCj4gDQo+IEZp
eCB0aGUgdGFnX2tzeiBlZ3Jlc3MgbWFzayBmb3IgRFNBX1RBR19QUk9UT19LU1o4Nzk1LCB0aGUg
cG9ydCBpcw0KPiBlbmNvZGVkIGluIHRoZSB0d28gYW5kIG5vdCB0aHJlZSBMU0IuIFRoaXMgZml4
IGlzIGZvciBjb21wbGV0ZW5lc3MsDQo+IGZvciBleGFtcGxlIHRoZSBidWcgZG9lc24ndCBtYW5p
ZmVzdCBpdHNlbGYgb24gdGhlIEtTWjg3OTQgYmVjYXVzZQ0KPiBiaXQNCj4gMiBzZWVtcyB0byBi
ZSBhbHdheXMgemVyby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBpZXRlciBWYW4gVHJhcHBlbiA8
cGlldGVyLnZhbi50cmFwcGVuQGNlcm4uY2g+DQoNCkFja2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxh
cnVuLnJhbWFkb3NzQG1pY3JvY2hpcC5jb20+DQoNCg==

