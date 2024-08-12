Return-Path: <netdev+bounces-117736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B8E94EF98
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D3B1C217C8
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA56181B80;
	Mon, 12 Aug 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Zv+TUg22";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wdGc2fHu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241218132A
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473105; cv=fail; b=fGpkZUyamtVyIqrg+j8J32UpGEiXQA0qaMkJs0rcnEUlA8k1NG1ABiDzjKpF9JQQGqN7IAkBx4PkaAEN+xM44kjcbDY4/WIFreQ8ORKI4cD6R90CbRS/PXvBLKvMU43JcGOjuWITC3IXqPCuUxc/TSNRhPejV1BLEFDw2DpvKAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473105; c=relaxed/simple;
	bh=XEztIYWHlncippv6KO1o3IBc9pv84Jpl9NKLyAWEDqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MU7A3t71i9QqDK5wpOchh+pi1zBOvP8su1Bp4nP6GV/nRg33kaaxPReA1JmlIwnG1OZQxA8vcc1TNlfRxq2A5y8IRrY4CRUVcOMooonuYsHCwAgYknZMLkAt+ZEM/LdSpziCDooiZrptzIm0SN9GM4o0gTosVfB7wcsShLUoiME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Zv+TUg22; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wdGc2fHu; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723473104; x=1755009104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XEztIYWHlncippv6KO1o3IBc9pv84Jpl9NKLyAWEDqw=;
  b=Zv+TUg229RtIN5EI3R0eQ2v2bMAa2hzaS8No+bsIfrx1INsjDqv5VAsV
   6ZgVcrBiZOTS8+uBctMcu7IUTjk6lw1JNR7eo/A1bgwHHKhLQ7JuOypgA
   oKObBijgjmMc+Eg9HkzA0oIkrkoJcFTgThUQsV1a3K2jXMWxWsvCPJqJt
   4fYgyg7l4aOj+xa9g7K3omP42P3rKrVeHgQiMsAhQT7fAYJXI7ur10U5b
   nbMOP9m8ojGI6IiBe+8RuYzCC+NLgchLtwZRGwIqVt4Bac+1auYQ4Milt
   JTlutFUrVdjqu2LHyEmaNPa52YnCWiK03oYOGJOo1Drpb4QlxzA3XHse4
   w==;
X-CSE-ConnectionGUID: D8bILPsySpmEkLtsBFK8rg==
X-CSE-MsgGUID: y/0JJzWFSfyizn6qfXiizg==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="261301344"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 07:31:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 07:31:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 07:31:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsKvv7Dk8ttYNvKu4oB4OlW4SuUWKI2cBHlzCeu7tzkWph7kdvc8uJJ/ZqnxLXQzNPSYKyTUPJIfVb9cusq/rRlVFZ/a5OHpnb+wJ01g7YkTgcTepTt+Gyc9w/1PAZwPpjcB2wOrC/unbkmtWQO6Ax3uyGI0jDB5lTSx/aa/N1NZv/CGLsxjFIZKdHt+/hjGPckUfFl5wI6C073Y8Eo8nu582st8K+ZhHfMo47Dsi+ZBgUWnJqalQ0l/qT1+0LqF4G0bCSZrsQj1VBxyQ6a+w7mOfLjhTmtiz8FcauIM65WyLao/BTqhAGS/V2FLWRUqa18rykKgBqZpleE6Lg5mlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEztIYWHlncippv6KO1o3IBc9pv84Jpl9NKLyAWEDqw=;
 b=SS3mxzrHQDGvXPUtpDOBdj2ocNc0pK9sxnEnXGJDabvLXDPYX/1xizTn1ipU8aTpQxUCyNR28HrpD7meuBTaoJs+e9LPn+5RkykS7MRVynl79r7wEdPeJjrq79Xd/GCjZAnl0NyFy+mFn9kYsqjuIzhBM479+hXO/S599yutsb/vub/obsmS8CIdMTQwHk0iSTq0ZiOY6tc+G0QgDwstK99nRC5+Nntv03j5+B6rIh19KKlkUeiK2e+qWevbS0AW3CX18sYd77ADRWQJtb/85FOwfRMS3sYicGeoKRMYW5kTZDBquF/J8LGL5Zs5O0ecBAbazEbVP/DKZFWWItXUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEztIYWHlncippv6KO1o3IBc9pv84Jpl9NKLyAWEDqw=;
 b=wdGc2fHuBKMwFkIj5SYJ0KWegDyUGkSQ2HU44/Ge9qpS+kMgR65lO6o8F8Txb03f8Dk9GJF5kIjXsls5L/6pehAxe/QvCC6irNZNoJpTWtJDr6RbXQoR9ZJIJpONijW8lRit/JRD1QbTo5lY8mhdYSZW4PZoCrvQgl1nXQAuZhurPgO2RuXFWuFFO0MwljwKUXsiN7lTeFchmYUlfWFHdRQgVVswKTmNrgsLIOLRZpS4Xd5mmsSpm5tbpdnvcgaD9sxTnU1LIlun3qcMWKq/QopHPB2wCVpIhd/IN68lXs5YF/YLUrMGL4NNe0ujlA2B2OjJrbIyjx3tuFp0Iw4tRw==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Mon, 12 Aug
 2024 14:31:21 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 14:31:21 +0000
From: <Arun.Ramadoss@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>, <netdev@vger.kernel.org>
CC: <Tristram.Ha@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<hkallweit1@gmail.com>, <Woojung.Huh@microchip.com>, <kuba@kernel.org>,
	<horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next] net: dsa: microchip: ksz9477: unwrap URL in
 comment
Thread-Topic: [PATCH net-next] net: dsa: microchip: ksz9477: unwrap URL in
 comment
Thread-Index: AQHa7LVcjOdd2+MNTE+sTcukzDPn2rIjr9wA
Date: Mon, 12 Aug 2024 14:31:21 +0000
Message-ID: <c932bdddee219290197150cc6e0d7d2fe030cfc9.camel@microchip.com>
References: <20240812124346.597702-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240812124346.597702-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|PH7PR11MB6451:EE_
x-ms-office365-filtering-correlation-id: 73b35a72-09bf-4164-482c-08dcbadb6f84
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cnpPY2ZNYjhWWGxtZUNSWHNZOStGbklzTG5wY0NoTFBLRHp1NURFMG5TWVJB?=
 =?utf-8?B?dnlVWFRwVkl2dS9hYTVPTnhweG5hMGk1aC9PVDdNcnNRWVdoeFlpaWExaEhi?=
 =?utf-8?B?TlBlSS9NdkwzbWYzaE5Ub2plNzlOb2NqeVA3NTdUOTc1WmdsZkRsUEpxVGRx?=
 =?utf-8?B?MW5rdlZra3R5Sk5JQ2h3Rk1lMXFSTGN6T0pmWms3NjF2aGFLaFlUOG9xcjVk?=
 =?utf-8?B?SXh6UzY5QVdRdXRWRldLY21oWithdWluMENMS252YWF6MWRPTkNRa2c1QlU0?=
 =?utf-8?B?NFFjRTZ5TUQySWpUVFBhL2s4MkFkMjgxWXhKcW1RZXE0TGphY2I1QUdVbzMr?=
 =?utf-8?B?a2pwby9MLzFZdG56SzMreXZuU3FWVmdVUGtLODdIS1VvYzk2TmhsdHQ4Ym9E?=
 =?utf-8?B?c1R6OFI1d2t4d3l3UVJtQUVQdDY1QU0zUUF4a29UK1FPU0hWd043WUk2bVhQ?=
 =?utf-8?B?VGx5M0xmanBYMlZxcEdvMFg4VWZGdWVqUVVXM2I1M1lxSzFBRlVGMnNKZUpG?=
 =?utf-8?B?TURsTEtiZGxmeS9haldHUDFGeFMzWDhic1BWYWhPcVhDNnhLQkxKUnc1Mi9m?=
 =?utf-8?B?eWpGSEdmY2RZdFd0UlFaY2l6UFlwcUJVeWhIcWRXcGxhTXpVL1c1QnFwZGpa?=
 =?utf-8?B?V1JKVG5CNkpscVRRYkZ4Vm1pWXJ4Rkx6d1g2Q3VwZm53RktUWmtoVFBZemhH?=
 =?utf-8?B?RmI4clV4S2pyQXVGMVVTbEtXQ1BOYjhLWmk0ZnUxOGVtc0VUM1pkRmJrY1Fa?=
 =?utf-8?B?bGpkWmFsakt0WjVVVEhIbWpjSkp2YU1ES0VGY2VXYy9XZUdjZE8reWlFN2tU?=
 =?utf-8?B?YXhCaFhJZ2Zpd3YxQU5jVHRIZDJrV3A5cWNjNjkyeEk4ZGxuTExkTi8vZTBG?=
 =?utf-8?B?NS9ZVTl0aXIrTE0zT2FybEloK0xsVUhYdzJ1K1dsWURReVRIK0lQQUloQU5W?=
 =?utf-8?B?ZnFDbjhFdmVFZUZnVE5HYkJpdHE2RjZacnRxaGRwQTRBd0RnZFZPTGlHMEE1?=
 =?utf-8?B?eFpqb1M3aE5FVUYvUWZkVnQ4bkZuVmViZnlHdkJpNmc3OXQ2bDlaR1ZBYkRC?=
 =?utf-8?B?NlFtTkxYbzlBOEprUFZKVFBHZ00yQ1QvekQycUhnaHQwVzRickUxTmFuT1BC?=
 =?utf-8?B?TzZNYklia3JhYzBoL2RZdkhlVkhNWDFCZFllZ2oxbkZlZzBrVDN2aGtWa2xT?=
 =?utf-8?B?NktVZlVJNll6VkV3WDJqMWw5ak9nL0cvNXlVSWZTcDRDMVhySmJ4a0NOZlIv?=
 =?utf-8?B?dmFTWFY1c3VVNmZnRDN5eEs2VWlLdys2bFltTy9uSUxUdmVTY1lIa2VyV05G?=
 =?utf-8?B?T2pnTFQ0Ykk1WVQwS2kzeHg1Q1hqN3liMEkzUHprTWJsZEQxT3NLYWttUkY1?=
 =?utf-8?B?dWxmNlFhcjFwYWJxY0RXOUM4c3pGdmxYRkhZWVZORjVCRlZ5V1RIcTFFaU54?=
 =?utf-8?B?R2N2enNTcmwzWlVIVDE0MSswOFpTSHZjQTlwcW5HNmRETDRSZVhXNlFOejlX?=
 =?utf-8?B?NEdXMTZha1hPMTRBU29mbmhycy9xTjNnT1IvY0pOTHRzNnh0UzdzSDRXNFZV?=
 =?utf-8?B?M3hlTkttR2s4S3VRZVQwRFBBRm1yMG1QdVZjbDNtOU9mMkZGWUpKcithR043?=
 =?utf-8?B?bHNGcjNiWGVnUURlUzhzaG1NUWFyN2ZDUGEvck1rL0JUTFRESFNJWS9hdWtv?=
 =?utf-8?B?MnBienE0R0I0UW0zalVYN292TThybVE0U2drNEVsM1Vaa3p4WXhCWmFkbm1J?=
 =?utf-8?B?NGxYdzlmaUhEWU5DanJCdmw2VDBGVmVSZ0ZJOSsrMjJEVVo0VnBMQXFia3h4?=
 =?utf-8?B?bGNOd1dCMXFKL0FYZlVyYnlYNDcvdEMyaU8wdjdIZkdzTncxRnQzVWUxdk5Z?=
 =?utf-8?B?TW1Tdm9YVXBabDRjZnRrV2EyYWpuaG8ydkdMMUZpeHpBa3c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUZOODZYREJqOVcySVBFeEw0ejQ1VHpLaE5WTUpDK3B6bkM1M05JblVQQ01Z?=
 =?utf-8?B?V1RUUHIvbC9xbko0Nm5nbThKeTN6Rjkra0dZYTdkQWtzTlBBY2hkN2picUJK?=
 =?utf-8?B?enFhVFdzbGwybGYwODRqSE0xZXoxMy81TDR3aU5vYUgzTWtTMS9PbnpoU3Rh?=
 =?utf-8?B?dENkT1hXS09EZWNjREN4S2x0NXhsdnFpOUVPTFo3alozK0lOOG5RWkYzUU5T?=
 =?utf-8?B?eUVQV09wTXRucHRFQ0w2TUtSNFlMaGUxMURuQUs2ZFpnKzkwRUVraVd1MWcw?=
 =?utf-8?B?WUl2R0FONlk5U25JSkdEb3B1TG4yOXljNENMWkdRVC82UFR0clVzNmZPbGZt?=
 =?utf-8?B?Y3JGSWJSSDJGeGJkWnhLcEhXNEdSWC9obnZZZURCajRWSElZcHhoZUF4Z2k3?=
 =?utf-8?B?RWh6QytzdHpLbnpRM1ZsQ1ZZRHVXL2pkQWZiNy9OWWhNcUhaOGwwQWhGSWR0?=
 =?utf-8?B?ZDIraXcxTmNVR0ZDcC9ENFVSaWF5U1gvUS85OWZhdUsvUk9OTldueWxHNVJ5?=
 =?utf-8?B?eTJnRkRmS0huMWZkVTVWUWgwM1VRdDhjeWNHbTJNMXBPT3JnUkVFa2tNL0Yr?=
 =?utf-8?B?elZBcUVHaXhXVktNUFN0NmNLZzJsd0VCV1AxbFQwZzZRd3lrcWVGWWlqUkZP?=
 =?utf-8?B?dEFURmIrdWFFU3RCaHFwL3cvMkg0eE9jWVdIVW00VDNUTnpIZWp3eUZGQ09I?=
 =?utf-8?B?bTQ5bGc2eitsM0ZEMU5Uck1CS0ZaOXpjM0xmMzI5TTNBaHlwREdheGNvWkpa?=
 =?utf-8?B?ZVk3aWpwU0ROV1RTb3Z4U2ZyQjlialQwQWJsanNWY01nMkpSY0dpU2Z1dml3?=
 =?utf-8?B?L2NOVjhidjk0SXZhckRzYjA5M0hFVllVUWs1clE0YlBUczd3a2RDN0NGZVdl?=
 =?utf-8?B?VjJ5SmcyNWlpYUFrNGwrWnlUeENDWkU5VXpJMDVKVmVodlR4VndJVmxjbEVJ?=
 =?utf-8?B?OVllWUR6cHo4TXl2emNhT2JoTU56Mnd5cWE4S1V5d3R4aHZndXlzLzR1LzQ1?=
 =?utf-8?B?QUo5eU1qSm1JYXNScStqLzAwbndFZVl3RG9Icko2dWIwcnBYN0szRndTOWNB?=
 =?utf-8?B?cVd4SGpQdUxMOGpFMlVSWTVnUTNLczlnUTc2TDdpMnlJNTJ1L3ZMSGVMcDNS?=
 =?utf-8?B?bG1kUTVDblUvekY5QmZIcFJDL0R4Vm9odWR0c0crU0dHZmpYbUpJczJrbDZI?=
 =?utf-8?B?em13dFNrZ1pscDI5RlJDVkVYODZiUVFQYzl4M1owLzBBWVJ1MlBkc2NRcWF3?=
 =?utf-8?B?UXJHcGFTSS9UNW8vMVN2Y1kvdmQ4UmVVUyswRktZMzlpOXdCa1lZdEN2TkRR?=
 =?utf-8?B?b3NBdDNXS0Q5cTNoRU8xYUtvSFZYcXlRWk40WkNZaXNEYzNLZ1JDWlFLV2lo?=
 =?utf-8?B?MVdFVWVJQW1UNUlBR3NRVXUxZ0p4N0VOaWIvcHhBOEtSTFFGNTJxK1BlYVE4?=
 =?utf-8?B?Q1BaMHBYMjhUZjRUd3QrS0ViYnpueDZNZ0R2UDhxSy9LdnVqNTYvQlQ1SVV1?=
 =?utf-8?B?eVU2a0dPSnBMbFZlaElsUzRJNlY2QTBrT0NPVmxmNEszdlBDK2I0YnIrMGZX?=
 =?utf-8?B?WmVETkZadEpaZTA2ci9CNVJrVGJZNE9zNXB5L3J6TE5SMm5zM2tkTnF4WmRT?=
 =?utf-8?B?YWlIMC9rMGl4dkhXKzBUaVNxTHNwUFpVMWFteVpUMytEOERPRS9HV1V4VldR?=
 =?utf-8?B?R0tONHhOVU5tTW1oWDlGUDlMQVlvcEszOTdRcWN3K2hJamI5amFnTWxPZ3Y2?=
 =?utf-8?B?eC9DVmh4TFhGc1NCc1BFclFMSFN2MTczY0RmaXNrZnJUV0JMSGNZZlp5emtt?=
 =?utf-8?B?anVndlNGL1YyQlUyY2YySXV5VFZ1M3JlSmtUWWR4NnZNLy9mcHVVZFdMM2dx?=
 =?utf-8?B?OUJ6SnFqU01palNwNU9FNkxkaGRVTGY5dERvYkg5dnplTDljSlNGOE1QcGRG?=
 =?utf-8?B?T0pBUXVkQzhXVVUxY3lML1NRS1FpVkRsMEhOTlBQY0NYam9ibVN6N1NIN3I0?=
 =?utf-8?B?a1hMSGNMMnErS0xhdm5uRzk4WFhhbEt5ZDJzNnRaNXBJUm5CV0orMEllUExI?=
 =?utf-8?B?K1VkRk4rWUR4NENPSWVEbUpVMGdJbGR5S084enF2UzNSRWNZLzgwQk9LWEJt?=
 =?utf-8?B?WTJpNFFmRFQrTWlCZW1xby8wYUloZkEvdTRTdE5pMW1nN3JBTHlyL0MwN21v?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E2C71EC7DA7CE4F82F3F15EED15619C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b35a72-09bf-4164-482c-08dcbadb6f84
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 14:31:21.0689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNE5L4oZobNNbzdtOtoTE7eHMsGK5PmdJF8nsKVISeXVGQmK02gCXbQyFrJHd2DMX7jTstCtS603pxWE+F4H7qlX7Vqej4SGJh/RpM4DJZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6451

T24gTW9uLCAyMDI0LTA4LTEyIGF0IDEyOjQzICswMDAwLCBFbmd1ZXJyYW5kIGRlIFJpYmF1Y291
cnQgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4g
S2VlcCB0aGUgVVJMIGluIGEgc2luZ2xlIGxpbmUgZm9yIGVhc2llciBjb3B5LXBhc3RpbmcuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbmd1ZXJyYW5kIGRlIFJpYmF1Y291cnQgPA0KPiBlbmd1ZXJy
YW5kLmRlLXJpYmF1Y291cnRAc2F2b2lyZmFpcmVsaW51eC5jb20+DQo+IFJldmlld2VkLWJ5OiBB
bmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQoNCkFja2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxh
cnVuLnJhbWFkb3NzQG1pY3JvY2hpcC5jb20+DQoNCg==

