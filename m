Return-Path: <netdev+bounces-304555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0uJQCca4R2qfeAAAu9opvQ
	(envelope-from <netdev+bounces-304555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:27:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 878F8702D9C
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:27:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KuFErNgA;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304555-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304555-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FB11301485F
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779D03D411A;
	Fri,  3 Jul 2026 13:25:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB453D0924;
	Fri,  3 Jul 2026 13:25:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085137; cv=fail; b=ect/ghHYMfIxAMIiwSD/e6m8ITOmlHvz/bELlqw755lRxYzKfw1ESoegqHpxmCz0JZohQZqAmCIHu9VsAro5Y/mshzCnNjPXxsqLlr/kZbo6oA/0y0oeMMKXb/gsmYhkrgGn/ROPJbLV0+93F5FX61F1O+OlBlYRn82SfMVkvRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085137; c=relaxed/simple;
	bh=ygQwJEWk7scsQ9asdhCRwodLRwYNqgtuYKLgIeSHtCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EIRztgT/YftwtybTjb463ftznSynpdT+3B+bQvWiYHqNfN8nDBxc66sH8CAEN9bwZ5DTxHrdknJiY4rxmeFyFar7qlPgykL+bbHAGPYARy+f8YJFvfuAqDg6tFgSOZs/bAy7snc2KwmO33gZ1kLjhHZx1WSIKVL3WCvMj0YU4GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KuFErNgA; arc=fail smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783085136; x=1814621136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ygQwJEWk7scsQ9asdhCRwodLRwYNqgtuYKLgIeSHtCE=;
  b=KuFErNgASBZACk3TeM04uc3LmJKKxIJrNfSb2+8GL7HeTF4DlcTqA9IE
   bnQ2cCa+J/Wgayl1Sj5rC2IDhyBC7tRHlKCC26WUH9XAn30HwocP2aMsv
   7lrtwWUMp4bAXNlwHGpGkx1gVugqCXEwFQLy0q/ebr0oxeFCgg59lyVrI
   Xy2jY+Swg38k2s8LM5jELbtYCOJtvN4Kf3gVNvJLwbIOchounRmt3UNGM
   R3rudpRpPdy7clvMeafxk81nhP6Jph77hP6sJ3Ye1pI+ceWZP8f62aOwM
   ApQVrgoxi9vdWpV2atG0nWLD3qtEp6fJnCOZeouPO4HHJfCTfNyZrcjQ3
   g==;
X-CSE-ConnectionGUID: Dc4UlUgRQm+aNr4a4Q7B/A==
X-CSE-MsgGUID: Zq7ys0/2R+CPhPf1xj7BMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83931954"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83931954"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:25:35 -0700
X-CSE-ConnectionGUID: eWh81vsRSbKSHDtYCErfzA==
X-CSE-MsgGUID: 9WoO3nHBQFiZpTi884+Olw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="249758106"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:25:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 06:25:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 06:25:34 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.69)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 06:25:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3raJoAlD9Cb8UDT67ODBFbiy7Kv0d6/V4b0MvQBJj/kPwNMz+3VBij0gtFuXhFNKhHcdj96sIFPJuTqGVuoojQAay/bLHfS22ItM5R/qS6euryiw8bPoJOsaNvKPWcjZjGpyk9JvwGA6EP2/U3CVu7ia10UYWjEk6CIQ4LVhd5sb+ye5RT0rXPi6P+JMmAy2rg9vUwvGE2EURdYoNsh0SVcP2Dty9AjR8Qh8Ys1rhY5pF3ZGROAeXxPyeZ5NKC0pB8zFqEmeixRAyU6suW0dXnr6ym2HQLCCmRGXZj0SIAImvV4c+3UGG+TnwncH5fAzJ5smua1pvFb4cAgKHB+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygQwJEWk7scsQ9asdhCRwodLRwYNqgtuYKLgIeSHtCE=;
 b=Vw3tcz5GNUiCl41oH5OcKvgpQ6ocaVU4Si8EL/THaPQ4UsH3QcbDFNr8qty8+3Mh6wNn+1xB5p/6QkTtaO9hiyRR9tR0HIUO2AMfaGhgqHbUs4pPXWUGQSNFTz4j/aEuJNli9oEFWhWviszFBszEVbwhFd88x6bSNHI0A8wiu8qYNOFWAcq0FpoNEOr3mqX9RzQGucJS+RVLrNjzC3ywYldUQZgWYBzlthBKdFNe03FxEnqbgLehacOr5dg00LJJIWARqt7jqeBalZBy/oaHswSpe+HLVO23KtXv92Y1vmstVcjPuG27dp8tVT4XLosBxM6CfRKyibKIaQx1ORpzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by SA1PR11MB8541.namprd11.prod.outlook.com (2603:10b6:806:3a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 13:25:30 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 13:25:30 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Luke Howard <lukeh@padl.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Richard Cochran <richardcochran@gmail.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>
CC: Cedric Jehasse <cedric.jehasse@gmail.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>, "Tyrrell, Kieran" <kieran@sienda.com>, Ryan
 Wilkins <Ryan.Wilkins@telosalliance.com>, Mattias Forsblad
	<mattias.forsblad@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 07/17] net: dsa: mv88e6xxx: Add
 connect_tag_protocol handler
Thread-Topic: [PATCH net-next 07/17] net: dsa: mv88e6xxx: Add
 connect_tag_protocol handler
Thread-Index: AQHdCsFV+q+LmZprMU2FEdgwdVHhlrZbyR/w
Date: Fri, 3 Jul 2026 13:25:30 +0000
Message-ID: <PH0PR11MB59022A4F7246216914A57429F0F42@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
 <20260703-net-next-mv88e6xxx-rmu-v1-7-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-7-991a27d78bca@padl.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|SA1PR11MB8541:EE_
x-ms-office365-filtering-correlation-id: 5266dfe3-df69-4d2b-4946-08ded9068d8b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|3023799007|38070700021|56012099006|11063799006|4143699003|921020;
x-microsoft-antispam-message-info: YoRk/XuhW+mVKtRpGKiRYRZ0jVPPZGTb8BHXWkFVHxMvdesfNP9+OH8qZ4mYACY1CZyI0CvEV/hD3QxXhmDuruGJRtKS7o8Wi5gEfa/NT1YSo/YRJOyJcFypvNOvtnWVJ5ArXJiuQopRzyLO60iwzD8urXDWiPCPhesvqpgkoPdFSSUky4pU6IZ7CnPVAx90NbctgwHctsP+++6x3kVHIptkhKxcYw+OHA9ReUatNo3d4L9MOyPxXAOnXOH7DWI6Ch6DTyPox52hXn5KXiDRvqfdQ8KsIoqAkgvGNAxRxzqa5mc1kLh4z70vxX91XmxKfK9uC9wbU1qt83GH4cHwCGsn1f6dmDMjKj/Fx+1kbjBQMatB6cSdfg2j+82N3zp3+mxD1/+MkgjLh1gcbn9SQNWrWIHB+lvMwR5PQA808Wv0oESvvugqDtjRNRRDi2ZPvjE6DxuJ2feLZV//NuudxJFvgPQp+/NI37vySVjPqom/R2W+yvkjdsuXb2fAwomoEQ6oNSU+XsRi4hrnj06TypbybY+S0OREyaVhWiRSK8qN331EcZ5EMrTBkfM8TXiaSHREZ1FIJOkKHRcQyKU6RbozwZ/w+tlM1wtOZrP1+Nh6dXwgsYSfQhj211Ifwq/RQateJIBj9MxO3sM+81b/CTSyGh9/gRILWjVvyFZnEjlLDWVbE9mY/EcjPtlhrd3eT7FlGa47hOcyrbRWt7RJR2bpWwrVeXF40rEFuQ+k+T8DTX22oyj3JlMy2Ut2/dsz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(3023799007)(38070700021)(56012099006)(11063799006)(4143699003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFc0NWYwbGtMT0o1dTM0aE5sQSt1NXc0S0ZSL3ZmbkwvYnlzY1FqK3hIYzdw?=
 =?utf-8?B?QmhTWGJPNWZkZmNCUFhzSkk0SXRIakFEOGF4TmVzcXpCRTgrMEE4R25KZU1I?=
 =?utf-8?B?NWFyM2o3VEhYRTRvb1VBZDliTVc2bDNhNWduc3gxSWtRaG1mRUYvVmxCdmRk?=
 =?utf-8?B?ajBVVzlZYWwwZ2xQcGFnMndiTXM2bjVvUDFWOHJROXFRbkFFVFVNbko4N1Rv?=
 =?utf-8?B?MlhrMmovUHVpNXFycHpWTy92RW90UWVQMzJmSWNJOUVvcTMyYzNTWlR6YXNq?=
 =?utf-8?B?b3BkWWQvbFBxME5LOXJYRTRXOUFHc2F5N0ZwbzNXSnZBMU5MTktScEhCc0JU?=
 =?utf-8?B?UjVScWw5NVpIVlRjaHg3VXhSdXBQbjdZd3A2MXhZK3ZJTVN3T0JUaHdqYnBV?=
 =?utf-8?B?QmlCWHpycEVLOExJa0pOSFFmY1R1RW9QUnR2MXZaRWljVWREd2Z2ZDlJWWVN?=
 =?utf-8?B?RkdNWEEzVTlmWXZCV1VodGFIVkEwNFVmYjVJV0pOc2ljQlNicDJMcDMraFc1?=
 =?utf-8?B?Q0gwenpZR1JFVG9NTTR5MHpvYTRMek9ja2oweDJZdEF4TndDZGs4Z2NKZ0tn?=
 =?utf-8?B?SEx4SElxUndUa1dpSCtRL1VtS1YyUWdiN1BUZ1lwQVYvbXl6OS90YlFEcTda?=
 =?utf-8?B?M1JrZTVoUXdOZ2NOUzBiUy9WQ0wvbStabHFlbnJhTUg3TVZRNnpjVVk3UzVX?=
 =?utf-8?B?aDA1RVIrMDVWVDBGUG1XSVBFVWtuNnM1ZWg3UVFVbmEwa0RLOTREVHdVZStT?=
 =?utf-8?B?ZnVGV1h1NkttVUJFZ0dLSDRRVXdhYkNFMm55QVFlQzY5SWZwUm00ZkR1d0tF?=
 =?utf-8?B?TkpXb1BzYmlXT0pnU2dDbUN6YWY1WDhnbmZxNC9tY3JwdGY1dFhDTjF0NWRU?=
 =?utf-8?B?MzNqT0xVQkNjMmtlVEo2Wk1wdU5MTDVLTTdwaXBFWGpCaXhSZXFNSWRzZC8w?=
 =?utf-8?B?Q2RoWU1Ed1ZPNjY0eEpydFd4ZUE4enZ5TDV4Wit4TVlQa2MwQWZ4dlNjdVBS?=
 =?utf-8?B?andPV2Y0UTZ0U0srQTdUSGF5STdBZ3pHRWlFc1EvaWhTMXMxSTR1bHRvUlQ0?=
 =?utf-8?B?M0xnOGVkb2h0RHFUWVBXcm1zajV1NHdmY2w5UmxIRkczK0w3S0pQMlhqY0dP?=
 =?utf-8?B?b2o2ZWw4NUJoZmpXNXpqTEZuNExYdGc3czl1SDBTQzJ1akJ6WWZJT1RFeVh5?=
 =?utf-8?B?ekZEM0RyTDNXZURhRHlCeWhtWUZYQitBS3lzU2Q3aGpkaFlEeElMc2RBanZG?=
 =?utf-8?B?WExxcUFwV2R4NU5LOXNVQ2RBRUFWQW0wdVNROWlza1hRYmZXU0k2aTlCRTh3?=
 =?utf-8?B?TWJ3ZFRQNGFmL0ZMOEVHTG1VRWdkVjRleXlHcWdWelpxQU44M1pod2tJTjNC?=
 =?utf-8?B?dDdOUktoU3kxenJwRjhsUlpZY2h0R0xsdUVUa1FKNDRJSzBlYUhkbWZxQ3Iw?=
 =?utf-8?B?M2pJa1RFb3NqcXZ2OVM3MEpQQ3gyWGF6QjNwSkxTeUxWS0lyTkJxRnNDNXQw?=
 =?utf-8?B?QTJaYzJrdzI5bitoWWl4VE5qczRCTDViejloYUM1c21VbVpNbzJoYlYvSk1C?=
 =?utf-8?B?TzlYYTcyT3JrQ3RFMC85NXVhYkZDTndlNFlnVGV4dVF2THhVYzVNWk05Z044?=
 =?utf-8?B?MHMxd3ZnelhlRk5nNVVkOE9GUk5ITGJXZCtlREF3ejllL21IV1dSV09uek05?=
 =?utf-8?B?MmE1VnVMajFOTlYyQWlIUHFiNHh0WHM0Mksra3FDM0hBUUgrZHRBWkpCelFB?=
 =?utf-8?B?T2JHVzgwWTlPTmJ5RUp5ckF4cG5vd0hLY1BuQjhzYzV2aS9oT2dsRzliTkx0?=
 =?utf-8?B?S0VRbEFqUjFWdXYxMnVUdFlZR0g2NUhYYXNTbHlhbDduR1FyNGNwVk5hbEVW?=
 =?utf-8?B?clR0cU54aHBrRy92bFBQY2Yxek8xT2x6anovR3JxSnV2UGVPWjBqSUpMcjBM?=
 =?utf-8?B?dGd3a2lwWms4TXdLU1VpV24xMzMvT3JmUUphbWV4V2h4bSs1M3ZLNnBxdnRn?=
 =?utf-8?B?ZkwrZUsrRExxbTF2WExRbnIyeGJoRU12ZkcwYnplNUVnOU1MQnZZNDJBcERs?=
 =?utf-8?B?OHYzaE41TVNUcldNN2VhVStVTTFjRGZJOEtSUWwzbHl1SzU5bjVLdGpiYStn?=
 =?utf-8?B?dXFYemo0Nm0zUWhDemlwYXl3YmpwWFNkZVJ0VUJsQVlJOGRDMEpnK2FXY0wz?=
 =?utf-8?B?ZWYvWnozQ3ZINzd2RnZiQ1pxd2tCR0hscGpJYVlRWEl0REY2VDdMRklzaTRG?=
 =?utf-8?B?YTdLTFF5UXZOWHorbkMzV09sRVhMeXdzNG9lMWk2M3kzR3JTUFpiaW04YWh1?=
 =?utf-8?B?a1NWSGhnZml2eXk5aDNOUk9oWnAxajdGOXFGNUF5Wnl4MGdpeG13QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mNZ2BGnx1G7dTYGMz3Gt+wHpmeoyPFdaR5gUV2mw1YF8o1YvGQ+LSc9cKfJLif63CNWVwsHY7oR3pTPcnsX8jn5vk6ELvBPge3PBFHAOn1DbdjsIwrTHHWMskq1BY//CnbGj+a8AX/n0g7G402Kfbf+u9yn/OrvKOlTC9i20r/DBd2lZXPF0iWFhBovsowBw1Hc5RUkd+kt0RQ5Iiw0PZEsVimf4ZASxbNCe92UpQRY2xLZVy54p75mt2GvQla+UBRDzYQydeUp/8SAUyFKkIxb2VaQxfr/uZxebADVZ4zPnnBOvUY+dJxuxfmmn2q6s084+ftbIGi19PqsP5NJ89w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5266dfe3-df69-4d2b-4946-08ded9068d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 13:25:30.0629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: snPEudz26QWMuCi+U528vmH4sUlirU7gcbldKDVwfXOCeUtSspyKPh71YnkXP53Qv7zs4Ql9r9ifU3F/+HtkYWWs1DO+NCleFqxJ4vYYSHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8541
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304555-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:f.fainelli@gmail.com,m:cedric.jehasse@gmail.com,m:mh@rme-audio.de,m:max@huntershome.org,m:kieran@sienda.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[padl.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:email,PH0PR11MB5902.namprd11.prod.outlook.com:mid,vger.kernel.org:from_smtp,lunn.ch:email,intel.com:from_mime,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,rme-audio.de,huntershome.org,sienda.com,telosalliance.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 878F8702D9C

RnJvbTogTHVrZSBIb3dhcmQgPGx1a2VoQHBhZGwuY29tPiANClNlbnQ6IEZyaWRheSwgSnVseSAz
LCAyMDI2IDk6NDcgQU0NCg0KPkZyb206IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCj4N
Cj5XaGVuIHRoZSB0YWdnaW5nIHByb3RvY29sIGhhbmRsZXIgaXMgYXR0YWNoZWQgdG8gdGhlIERT
QSBkcml2ZXIsIGl0DQo+Y2FuIHZhbGlkYXRlIGl0IGlzIGEgc3VwcG9ydGVkIHRhZ2dpbmcgcHJv
dG9jb2wuIEl0IGNhbiBhbHNvIHNldHVwDQo+ZGF0YSBzaGFyZWQgYmV0d2VlbiB0aGUgdGFnZ2Vy
IGFuZCB0aGUgc3dpdGNoIGRyaXZlci4gRW5zdXJlIGEgTWF2ZWxsDQoNCnMvTWF2ZWxsL01hcnZl
bGwgPw0KDQo+RFNBIHRhZ2dlciBpcyBiZWluZyBjb25uZWN0ZWQsIGFuZCBzZXR1cCB0aGUgaGFu
ZGxlciBmcm9tIFJNVSBpbiB0aGUNCj5zaGFyZWQgZGF0YS4gQXQgdGhpcyBwb2ludCwgdGhlIGhh
bmRsZXIgaXMganVzdCBhbiBlbXB0eSBzdHViLCBidXQNCj5sYXRlciBwYXRjaGVzIHdpbGwgYWRk
IHRoZSBuZWVkZWQgZnVuY3Rpb25hbGl0eS4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTHVu
biA8YW5kcmV3QGx1bm4uY2g+DQo+LS0tDQo+IGRyaXZlcnMvbmV0L2RzYS9tdjg4ZTZ4eHgvY2hp
cC5jIHwgMTggKysrKysrKysrKysrKysrKysrDQo+IGRyaXZlcnMvbmV0L2RzYS9tdjg4ZTZ4eHgv
cm11LmMgIHwgIDYgKysrKysrDQo+IGRyaXZlcnMvbmV0L2RzYS9tdjg4ZTZ4eHgvcm11LmggIHwg
IDMgKysrDQo+IDMgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQ0KPg0KPmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9kc2EvbXY4OGU2eHh4L2NoaXAuYyBiL2RyaXZlcnMvbmV0L2RzYS9t
djg4ZTZ4eHgvY2hpcC5jDQo+aW5kZXggNzJjOTNjYjg0YjdlMS4uZmUwZDBlYjhmMDgxMyAxMDA2
NDQNCj4tLS0gYS9kcml2ZXJzL25ldC9kc2EvbXY4OGU2eHh4L2NoaXAuYw0KPisrKyBiL2RyaXZl
cnMvbmV0L2RzYS9tdjg4ZTZ4eHgvY2hpcC5jDQo+QEAgLTcxODMsNiArNzE4MywyMyBAQCBzdGF0
aWMgaW50IG12ODhlNnh4eF9jcm9zc2NoaXBfbGFnX2xlYXZlKHN0cnVjdCBkc2Ffc3dpdGNoICpk
cywgaW50IHN3X2luZGV4LA0KPiAJcmV0dXJuIGVycl9zeW5jID8gOiBlcnJfcHZ0Ow0KPiB9DQo+
IA0KPitzdGF0aWMgaW50IG12ODhlNnh4eF9jb25uZWN0X3RhZ19wcm90b2NvbChzdHJ1Y3QgZHNh
X3N3aXRjaCAqZHMsDQo+KwkJCQkJICBlbnVtIGRzYV90YWdfcHJvdG9jb2wgcHJvdG8pDQo+K3sN
Cj4rCXN0cnVjdCBkc2FfdGFnZ2VyX2RhdGEgKnRhZ2dlcl9kYXRhID0gZHMtPnRhZ2dlcl9kYXRh
Ow0KPisNCj4rCXN3aXRjaCAocHJvdG8pIHsNCj4rCWNhc2UgRFNBX1RBR19QUk9UT19EU0E6DQo+
KwljYXNlIERTQV9UQUdfUFJPVE9fRURTQToNCj4rCQl0YWdnZXJfZGF0YS0+cm11X2ZyYW1lMnJl
ZyA9IG12ODhlNnh4eF9ybXVfZnJhbWUycmVnX2hhbmRsZXI7DQo+KwkJYnJlYWs7DQo+KwlkZWZh
dWx0Og0KPisJCXJldHVybiAtRVBST1RPTk9TVVBQT1JUOw0KPisJfQ0KDQpkbyB3ZSByZWFsbHkg
bmVlZCB0byB1c2Ugc3dpdGNoIGZvciAwLzEgY2FzZXM/DQoNCj4rDQo+KwlyZXR1cm4gMDsNCj4r
fQ0KPisNCg==

