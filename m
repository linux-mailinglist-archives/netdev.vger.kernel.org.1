Return-Path: <netdev+bounces-285497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AglIAIB/WmxVwAAu9opvQ
	(envelope-from <netdev+bounces-285497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:15:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E984EF2CB
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14C9D3019100
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A677F33D501;
	Thu,  7 May 2026 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0AteoY1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8151342507;
	Thu,  7 May 2026 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188510; cv=fail; b=H4ZzdOWGX6smwrMxPMogihkEELgYlMJYYwu11Afy2VUhZF6s9GZ5HWjYErqTUF7JN1dsNcGQT3DC2jDrYF5AxBrRjUA0+hSC11+s0o8AERQvERaJyxbcFZ1k6Zrp9446DTi/ZjtgLP023a9MF5WBF6v7G8jM/MrsUoNH1piIbB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188510; c=relaxed/simple;
	bh=aavSHchY0cU89epWi7s4AnS1LWUVXj9XfQcWu3gqRUw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b0L3CMpKkZk1W6RvEOtKs9xpnBK9qpXpuFu7PyUBTc+u1Tn0yV1PwylOMnWTo6uz9dsIoBE40SYOKmSoAFtHp8qDe1tJ41+GS77raYelQL2UGl0k/nr7O+B6b9kZHe2JtgmzXilnB/dzES8IW24xblZSnywsSypMdfsBRkg3s8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0AteoY1; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778188509; x=1809724509;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aavSHchY0cU89epWi7s4AnS1LWUVXj9XfQcWu3gqRUw=;
  b=b0AteoY1q4wW4Htu2iuPB1anmCu49XwZtyTAgJk4swy7QFqNKFuV+7D4
   VWzeg1d+o2UfaIXr3SddLMoA9EASkADwHL3g+oyTcdI60zj3lj9YeLuS9
   rsnAJ7tL8SAhRnoYbor0KJamNgC4XkDr3rR9hMzNPUecAeRau7f8iAdem
   z6fIeIs6gJmdLZFzHfRBe+4v96Y+zxOpa/AMTaUVtibHVdjJXxUkh1bKV
   IGSjX5wRTeu1S9rqe7i0m1RBqh8nHFlIsh8pJOFG/mhs4Az9rLY5G10um
   Nxx7MNLUMsQmVs6xZtobiQFlsYM5TPmLRVKF+ZQZlo/0mumyla/0oRx7a
   Q==;
X-CSE-ConnectionGUID: HineXwDTS4CMyJ4vPYYT+Q==
X-CSE-MsgGUID: 4Qe27zpvTBi8q0wSavxSgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="96720742"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="96720742"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 14:15:08 -0700
X-CSE-ConnectionGUID: DIuRDRH0Qa61+tWs8fesog==
X-CSE-MsgGUID: 5+LN3ZFUT9G1+fS/f8EnBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="236829266"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 14:15:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 14:15:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 14:15:07 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 14:15:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ianBi07RzFHnV6HbU9aXAatXezKUU0z9cecEvP0IOUYlCdRh4fVlbDGkJJ1Is6Z7u4GVp92G9NGJausUOdt5ME2FjPCVEnz4z46FBrg3hJQ2BfihOs3Jyu0BZBDRUALXkNsgGGxCYI2yBE2DOkOs9R030H7GTjqxv99POygJRUVk1pnYlfr09XeVjc7aYxpwQmKHtQo9uXpMWZaeOQSNWTWJnSEPLwlxP3k1raiBcNU6rwsA8XdCyLdH670RuzEO+A78WgZSbwajnYJYb8aPp/RiWf5I1cTgv6MEKpVNpOT2Gw7HnhJ/kOfPXqlwe0XJKUei/7cbItpt7+GyhB/IxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yhc1nU7DhpLHdoieITv7DWNdllogS9t3rgFpwb//SR4=;
 b=ejW2DzW6MJz8oACiOKzrj0kZUbx6IQ1tykDoilNPNywHcLBaFGG/it1rU2gMUrQy/gX+rMB2cseSx6rW3ArSPkBD7Ur34j2lqdF34wj+FdG1ca6GGxasNe2Yj5OaFs3PVtjMd2Xi3uXwyEshkZ8RUZnqXiss2QnWftYQ2OTEy4d9c9saR2PuE2uv8hy1gBIZQ/6jgLqA22Mm0XPmbainOHj0BCmWRFlXpiYw+KAx/DaBFw0BnclDvBZqaFX7wS/2pkCuIjXqpwJsEFRdildUmtynt+gdY38v34MAuHRJQip23Wjdv5BnnhYhPPJ75IQQpFgPxzwSpEiNTUB8bRpWig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by IA0PR11MB7814.namprd11.prod.outlook.com (2603:10b6:208:408::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 21:15:02 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 21:15:02 +0000
Message-ID: <50d567e8-abce-48d4-b1c4-6ac0459382f2@intel.com>
Date: Thu, 7 May 2026 14:14:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/3] gve: skip error logging for retryable
 AdminQ commands
To: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>
CC: <joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <jstultz@google.com>, <tglx@kernel.org>,
	<sboyd@kernel.org>, <willemb@google.com>, <nktgrg@google.com>,
	<jfraker@google.com>, <ziweixiao@google.com>, <maolson@google.com>,
	<jordanrhee@google.com>, <thostet@google.com>, <alok.a.tiwari@oracle.com>,
	<pkaligineedi@google.com>, <horms@kernel.org>, <dwmw2@infradead.org>,
	<yyd@google.com>, <jefrogers@google.com>, <linux-kernel@vger.kernel.org>
References: <20260507211304.3046526-1-hramamurthy@google.com>
 <20260507211304.3046526-2-hramamurthy@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260507211304.3046526-2-hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0315.namprd04.prod.outlook.com
 (2603:10b6:303:82::20) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|IA0PR11MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 1121627c-ab26-4d8b-7316-08deac7db408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|3023799003|18002099003|22082099003|56012099003|20046099003;
X-Microsoft-Antispam-Message-Info: YPkacJFOc3as8VTKIp28OsVTwhRA6ywXNLSLZpbsr/mksD4tFdH3EDVMoVoHNV53roNNX4WRXDKioVb6z6N9TrP9Tm8tefjjmHrFAIExSGwaVeUw6iPot8IHuCI9XyFYv1pnD5ro1SPqP6wld8y+Oby0PGkBXgD4zGsyZm0B73wG6WuKLRAIIhJr4llgl1akXokREite4v7mpAbO39AbvBFRWtqbGhWtCWFaN4eyB7KfDypobuQ051wfB+D3LToQLw9RKHJqQ2DkpcRb1BLm5MUpOLGlclRKXyp5G/ohYZxQK8L5udnIZUZfD93frIRGfFOzMgA+y5kYI3P4ATcyLliB5CxZCPqD6lHnHY0dFFhf6imImTHbXcwpX92/sQfYcH7mXf/lQfndorx2xKIH5Cu9udFbwJ2EY5c6c9EiYnkU2rOArzEfmN3bzBUwB2HZbQBSOaED9qwH+Qpyb3ZNHrCohXB3/V4GS995EMqW/NIsD87Mk/RxP8xm4TdVlDSu0UsDJXnCQurNOQwu6YGsJEYQPwGbUmDgcjUNyCAA8S82ZZc5gpbDx5+KxBADljnbEMDXpa5DSxxd+jjjZrWkcFrEfSEP/HdLdidlPU6VN5M36G4k9ZCA8DE99mKHU4kmsaT+NJ12eoTXcX5QNkR/5NCe/NDwtAi8Ma6569w2E+HD0WkaSEZdkgdlmGQ8iLqi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(3023799003)(18002099003)(22082099003)(56012099003)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9FZGw4MDFRMEVCNGkwc3QxQno1U1RvY1E5ZmlaZmhldmNDV0M3UHh5YXYx?=
 =?utf-8?B?U0tGUkkzanlyaHFERXNqQzhRNEZTRS8vQzlYeFVNTWF2cWxMRmNYQXhPRmRu?=
 =?utf-8?B?MDViaTVDcEdqUlQ5NVdGV1pWQXBqMUNUVTBkcStOSFVjUXo2ZkJmQTV3ekF1?=
 =?utf-8?B?ZlM4YUxzMDMzTE9qcFViTXFGbHN0QTRkNkxpT3lONnRTMU1ZNUFUeHV3MEpH?=
 =?utf-8?B?ZEY0WGM4c0kyMXZHZkMzSStSdVMyUlBMSk1KdzVzMC9KU1NDWXc0WnpkSnB1?=
 =?utf-8?B?V1RWdkozSzJDUlF2S0lBb2YwY2pGVW1QM2lVc3pnVk9vNlNHWXdoMzNXNlVV?=
 =?utf-8?B?MC9MbXpTUDdZcHNITnFia3N5VlVlVE5vM3NscU1xWkc4Qmw1MVd0U0dIdm05?=
 =?utf-8?B?YzhFcURyL2lQQlBrUlV0UUJLVmw5eG40NXZTWHJLUEJHSlN0QnZTRDNVR0Zt?=
 =?utf-8?B?RXdPY2N5ZWI3ZDZBc2RJYWRnUTNvZEMzcjYzdTRpbVdIWWZVTVlqNE40S2wv?=
 =?utf-8?B?NmMzakhMdjlxNjIwTmF0c21XZkdCaXdEREVWQVhNM283TDhnaUZsMlhFUnYv?=
 =?utf-8?B?eHRMVVJHLzN2Vm11U3gvempUU3Y1TXp5SWxtbGlwQjArS1RsVE4zMXd5K2pI?=
 =?utf-8?B?Mk0ybVlvRm1xMjh4YkhOM1laa3dmM1BDVVM3cE1id2ZidFJiM0lOcDdrRHlj?=
 =?utf-8?B?ZlIxQW5WUnArWU9oamJ6MHZwZzdtTDROVnpNM3VVZS81OUs2Y0hUQjJ5aXdV?=
 =?utf-8?B?SUtWdFJLemVGN3FRc3UwRXNZTE1ydU5XRmVVN051eVlSZ2hScGxXZUM0anJJ?=
 =?utf-8?B?MVZIM0k3Y0xIVVZlSk4zZFJZKzF4NUU2eFMzRjRRYnRySXcwS0p3VysycmhX?=
 =?utf-8?B?NU1ndHpuMnRYeHNnV0phQUdGOTcyV211UU5nTFU0cVRXY2dYUzROVXFGRUFo?=
 =?utf-8?B?eks5czFKdUltaHhXQmViRTU3VFc0Ym4zdnBlanlTRHVJNU9UVjY1TTNFcCsy?=
 =?utf-8?B?SVVJNHVnTFp3WThvaXg5eFNGa04zV3JQeWd2N1A2aGZCTkozeGtMNm9pT0J2?=
 =?utf-8?B?UnM5QU9uSnJlMkNMTjBMb2oxOCtqNnl1QnQ0dUdpa1V0TDRldnZWYkdUTzZi?=
 =?utf-8?B?L3BodElzTVc0c0VqUUVkMHpSdHIwWVRQckd4cFlEMERXcXh5cWNvMHpJQkVU?=
 =?utf-8?B?cjNqSnN0dFlycTVzby9mWjREMW1nV1JNUmtLcUhLYm5oaWtBUFk0dm1BMDQy?=
 =?utf-8?B?V2NMdFpxRzhNWFd3eXVTbHBiRWpOd3UxaWxTVVhnTmZzVFR4M05mRTdLaUIv?=
 =?utf-8?B?OUVpRXpPSHc4SmlVWU1YT0FFRldzcnZubGVyR0NrWWxqeE5oN21LV0x6Qjl1?=
 =?utf-8?B?bTVYNTMxdVBIVzVqRXNuUldRb25UdVZRNmMrQTQ3U05GcThVMS9OVElXRS9s?=
 =?utf-8?B?ZUdIWXZnNWRtL1RaZFNLMXYvaHYvdmNHNDN6WVdXQkpjQ2VlTEIzZnVqMWxF?=
 =?utf-8?B?aVR3SFIydlpvQ21oY2Njc0NyYjNXcUgzNW11aHlxSzlBZGQzS1RtOGFvUnV1?=
 =?utf-8?B?QWxoNkllcG1FaWIvZWhJVXlmOHczWmNQNFdoT2FoVVE4anZtTExYRHhRdE1y?=
 =?utf-8?B?bDBGQlpOZWo0cWRDNVRzbnRLRUJ1ejU0RU9MY2VlMU1hZHdaTnE0VEFFNFd6?=
 =?utf-8?B?bTVRREJzbUxBWFVwd2M2U3FRYVMyZlB6ZytTKytjeVVpU3N2anFBeWlJNXUv?=
 =?utf-8?B?SXMyNWJvR1Jhd1ZxSUdCY2xnU2YrZUFYTlFpblh6NTYxb3RwYzdMRTRIeHFy?=
 =?utf-8?B?aDdicmlrQ1d0WHdQdFNWaWpNZldaeSthRjFPdnROaUNCeWpJZVhxL1FXMDZm?=
 =?utf-8?B?MHpOdCtNTVhFeVJYNldDWWhzNWlQYXRjU2x4MW44T1phRTB3TkVoOE02Slp2?=
 =?utf-8?B?OTZaSmpOK1dmVlZEbUZ3OGx0RE8vWE5idW9pbjBoc3piaTg1UnNTcG80OFlP?=
 =?utf-8?B?ZkNXN3RFZ0wvTis1SkJHcUlRZ3k1MlJwamFXdEFnZmZYL1R1cmp6TENJZUZ0?=
 =?utf-8?B?TEE1cEkvenJ1bGYzSTlBenVGZXlHeEtnbWFQMHJPZ2VDMmVnME1YT3RQMmdq?=
 =?utf-8?B?YWpraDhDU0JkRC9IbTJTWlZlK3lwajdwNGNiUWhZeUFGY0ZPdEJCZTkvVXdQ?=
 =?utf-8?B?RjFLNXRIOXJub3JtMXYrVTNHY2dKMmN1R21vOTZ3T01GVVhYVjZ6SUxHbXlU?=
 =?utf-8?B?aHRhdEU0SUp2RWhQbmFHMDVrM3dKMkZFcCtXK3dIc3JGTU9JbnBmZW5HclJW?=
 =?utf-8?B?Z0E3a2hwZG1FYkhTS2txSWNWUVNxTXdaS0RWaUJEK0Ftbmwvb3BGcW96a3ZJ?=
 =?utf-8?Q?pWG1coSksqKSzu+U=3D?=
X-Exchange-RoutingPolicyChecked: PHWqH32ebObYT+7Vd0alEnND8Ybh/b8JlkSC88RU40azn/k518jXQz0EInsigqzbjG4cqOOoKHbbqaZeGVQEyGwqfCeDEnmZZvt3tjUGftA6gDq07Z06qJTlvNBZspNXgzXhmtwKdPb1fAMBrK4/53jgb5bCnlFTFpQiwN3GPhmm6mhBxzBn/dMw94aDw4sSpj7ABAdQMLtBP6/1nX6EKb/7PUayPDTwff96Z+Qp1Wz2PqqUR3LXpICIrNxYs3ybvWJsfWJRq7jxXiboDnLFHdLPOxRRzcU2iCWOqKYNiSUzdTavt4QTM07aY0eJjDerzEyG8YrRjqHVS4ooNaLjpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1121627c-ab26-4d8b-7316-08deac7db408
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 21:15:02.6024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUOADiA11tdd2WefZwccWfIynVqrg8bEwfnhzYoY9lwrCnE62vAMUlyXJFK05wST+H78e1Qt5hN/Aa0TiEVfoH3mByaDVaIzG0IvLdqEmbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7814
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: F2E984EF2CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285497-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 5/7/2026 2:13 PM, Harshitha Ramamurthy wrote:
> From: Jordan Rhee <jordanrhee@google.com>
> 
> AdminQ commands may return -EAGAIN under certain transient conditions.
> These commands are intended to be retried by the driver, so logging
> a formal error to the system log is misleading and creates
> unnecessary noise.
> 
> Modify the logging logic to skip the error message when the result
> is -EAGAIN, and move logging to dev_err_ratelimited() to avoid
> spamming the log.
> 

Excellent!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> Changes in v4:
> - call out change to dev_err_ratelimited() in the commit message (Jacob Keller)
> - remove extra print when adminQ status is GVE_ADMINQ_COMMAND_UNSET (Jacob Keller)
> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c | 27 +++++++++++++++-----
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 08587bf40ed4..a65b14835aa0 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -416,16 +416,10 @@ static bool gve_adminq_wait_for_cmd(struct gve_priv *priv, u32 prod_cnt)
>  
>  static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
>  {
> -	if (status != GVE_ADMINQ_COMMAND_PASSED &&
> -	    status != GVE_ADMINQ_COMMAND_UNSET) {
> -		dev_err(&priv->pdev->dev, "AQ command failed with status %d\n", status);
> -		priv->adminq_cmd_fail++;
> -	}
>  	switch (status) {
>  	case GVE_ADMINQ_COMMAND_PASSED:
>  		return 0;
>  	case GVE_ADMINQ_COMMAND_UNSET:
> -		dev_err(&priv->pdev->dev, "parse_aq_err: err and status both unset, this should not be possible.\n");
>  		return -EINVAL;
>  	case GVE_ADMINQ_COMMAND_ERROR_ABORTED:
>  	case GVE_ADMINQ_COMMAND_ERROR_CANCELLED:
> @@ -455,6 +449,16 @@ static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
>  	}
>  }
>  
> +static bool gve_adminq_is_retryable(enum gve_adminq_opcodes opcode)
> +{
> +	switch (opcode) {
> +	case GVE_ADMINQ_REPORT_NIC_TIMESTAMP:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /* Flushes all AQ commands currently queued and waits for them to complete.
>   * If there are failures, it will return the first error.
>   */
> @@ -482,9 +486,18 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
>  		cmd = &priv->adminq[i & priv->adminq_mask];
>  		status = be32_to_cpu(READ_ONCE(cmd->status));
>  		err = gve_adminq_parse_err(priv, status);
> -		if (err)
> +		if (err) {
> +			enum gve_adminq_opcodes opcode =
> +				be32_to_cpu(READ_ONCE(cmd->opcode));
> +			priv->adminq_cmd_fail++;
> +			if (!gve_adminq_is_retryable(opcode) || err != -EAGAIN)
> +				dev_err_ratelimited(&priv->pdev->dev,
> +						    "AQ command %d failed with status %d\n",
> +						    opcode, status);
> +
>  			// Return the first error if we failed.
>  			return err;
> +		}
>  	}
>  
>  	return 0;


