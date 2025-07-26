Return-Path: <netdev+bounces-210265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD53AB1284D
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 02:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D663D5A1697
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85322191499;
	Sat, 26 Jul 2025 00:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abKT9e98"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965A2E3719;
	Sat, 26 Jul 2025 00:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491348; cv=fail; b=cAP8nfYq+kFNPUXs0kHBxFVhOJIOAZx031UXbMkLiepjsWD9pAl/xB0V1PJcgfD3HXjDEj355GU3tGhTigEN7q92Txgg7E8P/k8O7yFftOk+bdOrmnHsjzAn7Jtf/r5jUv5Is7K1Nfb2AL0lzGEj7zHx8bVUZ6L0/Y26jTS7e28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491348; c=relaxed/simple;
	bh=jn6NMxZ6B/Tjv5KFBnxHKqDUUFhdwG+gLVwNUfAuk1Q=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=T7apG3dDm4n/12/zddgkRhTE5mOyL9XxRfb/DNW7KOUBU6CnDZaa7odjke2Tmg2BOb28KCUG+6xwv5G378UOYmUdfTOyfrfCqMjCAghYlyGAxwFUWoO/Fh5VFACGUgByPGFqIu94+Y3cCVWzsGgpMv69Wz0HceEBA6Dw8qqcEJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abKT9e98; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753491346; x=1785027346;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=jn6NMxZ6B/Tjv5KFBnxHKqDUUFhdwG+gLVwNUfAuk1Q=;
  b=abKT9e98zoA81NeuDqm23K2CpUhYTR04gwpg7XKoOdzIENQ32HBiyCFm
   +UJmYRWF1rIujZH4aGkyvVlrX5hXO4GAwLelurev8EhtNhjE7G+UDgzkp
   0uhviSmc0tSyjpp08wHiyNsm61wHkC8QslxktXUecToVF2oJ+mc/o8O/p
   Wivfyod92jBPqziNg/tn5cNVe/u/zysGw4XycHY5St1dPAzC/gYj+7LVz
   uTwLx6STiyYDN90noiSr9Was70N8AesFx6fbha5PqL0YgaByaTvwc26TB
   XhepxCTPMOBv7fdBPrZCNYAV4aKz0l8jHEhvHlTd1jXnWJ7lt+syTd1uS
   Q==;
X-CSE-ConnectionGUID: IpajQ+uhTdqfxSHQ166B8A==
X-CSE-MsgGUID: msLc0gE4Qn6Cf2rpzVbzCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55685171"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55685171"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 17:55:46 -0700
X-CSE-ConnectionGUID: 6AMvl0j6SNK+Xc+AdPeVaw==
X-CSE-MsgGUID: agN4MCwJTX6m9FaBC+Y7Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161702475"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 17:55:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 17:55:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 17:55:45 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.54)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 17:55:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h81oNXN/PGi3fW6uCJ4R0Cv6lebF24lbB43nJ05qH4OoqU/dKTYepenMevL+9Csgi1/inTHL9K4w2Tv/tSEp1tIbZSHU33mP/sBSZKgrbWmOu0G5wWctwW9SZESdrz8EYhM792RUqufmrISOO3hyReBLRBmVVMst2C38xuKwrfbVx/E5zX/hsnCnoSXgjk7nSqR3gCpLMIgh2kWa9teK9/AUMSSBbGK9YUOQTOkRB6tOIZSJ5s1oh+ysIYazvGolRuiJhgQnztm7hvZ3QnSthLoSvJuIa1RZfw7OTQHz2JLPK+itNxIPu2lBjTRd3eAij3KhO86C6t+pD2O+AQgeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPVERaZFEkrWBKiUSRxHI4uZhk7HCy0k5Cldsy9Wjqo=;
 b=sh2s/9ZZBKa+itod4VBtMv/TAN/+RcIH4fNeUo/+OXXZm6uksXj1WTMnpyHWv6gSV9RrqWbkkNMtCCRF3V4BYCwJ7gd36LfTVoxr2CZwLh+F7ylJ7VnBD1aRR+z+uItUCBo5JnilGbHN1N5+lQQfqz1b3NHiLPPw/hLb0+H2vYZTvyMte6I3V9NrC2iDC0qop3ZC41Ps5fvX69Ff0615/PkDPuP1Z3whinUz88lHlJdc+RNkp7kad3HP5DTXZgodUo2lQdlYh21kiJeYUKW6vgl4TFFLv5aXcuylFXqmynjkQUbtameiH4DOEgwLuOoIp+fGUYkiI5lpxVHFX3HPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPF0084F97E3.namprd11.prod.outlook.com (2603:10b6:f:fc02::4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Sat, 26 Jul
 2025 00:55:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Sat, 26 Jul 2025
 00:55:43 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 25 Jul 2025 17:55:41 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Message-ID: <6884278d96724_134cc7100a6@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250624141355.269056-8-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-8-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v17 07/22] sfc: initialize dpa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPF0084F97E3:EE_
X-MS-Office365-Filtering-Correlation-Id: d8dcd527-abad-42ed-154b-08ddcbdf261a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1hZR3RGdEpoUUwvZkR2ZkJRbnU1TjVwUnoxQmFLZGNzRUpaUEpBUkRMQkJ3?=
 =?utf-8?B?dXdxOVhtd2lya2hHNDdadlpzdlpVUlZJN3dJSmxmcWlKRnFsUWFYVHRjRnEr?=
 =?utf-8?B?YlhGdi8zR2ppZ29xODNJczQwK2c2SjlSTmtiY3FMdG1rQmZQeVZrbFhncGI3?=
 =?utf-8?B?MVVpTWU2Z2c5aGtDRXNQeExBaXNVdmV6eUdRa2dzdk43azU2V251ZzlpRXln?=
 =?utf-8?B?Z1VzT2RIcWY5RTFKZHlacXdJa1BpR2NvRTlCZ2dmMThBcHRaM2dlRzliZ0JO?=
 =?utf-8?B?RFpWYVV5SkVzcG1zdUVBMVRvcXRnUmdpQURJa2J1UkRtNE9oYUYwU3U1TlVV?=
 =?utf-8?B?WFFRTzMrN1VyMzN1QXlDRmFDS09qN3JNTzk5empIZk44d3hoZUV1OTlnbk1r?=
 =?utf-8?B?eHljRlBYYWhWZmhZY2lBOUkrc0JTZ0dNc3E4YTdLVWxhSXVidVpYZ3pIYTcw?=
 =?utf-8?B?L3BYR0pKVmZHVTh0RDNKOXR5dWtHNGxiTzdmY0ZPNTlialFITDhMZ1NlR0ZM?=
 =?utf-8?B?YTYySENybWhFN0FKdXpMZThKNVVaTTY2VS9sVGM2aUpLSm1CYTNlNTdkT3Z2?=
 =?utf-8?B?RW5SWGJNYVoveFloUEtsODZrL05SK1RPbVVCSy9QTlh3bDdxcXNuRnZvK1VP?=
 =?utf-8?B?RlNrV09DMHpISUNSQW94S3dxd1FsNHBSUFRwTXRhL3hQK3IyNlh3cDJRYTdx?=
 =?utf-8?B?WnhUZzAyaHBXaWtBNVl6bmF5NHdQUzZ5anRjOWhybGpteHlFa2xoVHNWek5X?=
 =?utf-8?B?QzBVUTI5K1RqR3dHUkhtTmd3aHpJdVN4RnkxWWhqb2QwTlF3UXk3dXdTTlU3?=
 =?utf-8?B?RVF1a202RWtwKzB3OHFjTUxXSUhVQTZKRXVhek5CV3N4Y2pIQlNBdFJ1OEJD?=
 =?utf-8?B?cDZWcnVjbWZ2Qkc0a2p6T2VzN2JPNE5hcVBsZEZZdjY4SmxUeHpucU1OdXpG?=
 =?utf-8?B?REkvM0o2SDcwMzNZU0ZHZEd0UzlWVXhyaWFkb3NvMlRqRFFoUGxJWGZUYVgx?=
 =?utf-8?B?ai84VkpYMVRaMWlZMks3SmhBQWtCU3pLN1BkZXZGdXQyY0xnOCs2d3NEQ1ZT?=
 =?utf-8?B?SDMvL2kwWWt1L0Ntd2NHd0taZUFQdW8rM082SXUrRUU3ZmRJVVlmTHQzbUoy?=
 =?utf-8?B?c2RFdjBjYXFuclIrd2FpY1c0MFhwb21ndXdyZmprb1cvaFJIU0FnaVpNQnpS?=
 =?utf-8?B?emJmV0owWUpnWGhVQXBXcUZFZG9YemZoNmdlVVMwYUpneGkxU0ozM2ZhU3l0?=
 =?utf-8?B?QWtjUm96UGZ4cVRsM09xdXFXeml4UTBKMDVLaTcrV21NN1F1QUhGWGFUeE5j?=
 =?utf-8?B?b0ltUGNQTW9UWjU5bVRJdWZ0YjJIYWtibWhPbFZKN1JtUWpHaTdROGxMNlFz?=
 =?utf-8?B?OG9URHV3MHFSN3lxQlNndk9jNGpISFNkZXZQUWVUTlEvb29yZW1pQTFoSzFs?=
 =?utf-8?B?Z2RZNTE3M1ByeFY2SmVCckNYMlN3bk94aGtHcHU1VVc3MW4rUzJNenNSV2pq?=
 =?utf-8?B?SEJONlMwMWQzNEZydWU3WFdpazhGdWJodDBKWnFtcFM4NUlLYlRaVmtGWTZN?=
 =?utf-8?B?U2RUWDlrcjVYK3I5TytvK0lybnZXUXBaOSs2SWJqczJvay80QVNDZHk5U1pi?=
 =?utf-8?B?M1A5S3Z0dlU2SjErVlVBWm16ZzhEV0o3MU8xMGRTNFhTbHo4WHc3MlB6bSsv?=
 =?utf-8?B?WGw2NW11cTNzdTIyUVpXcHhTYjdlRDY3U1E3WWdXSERkUXdWS2lCN1hCYU41?=
 =?utf-8?B?ZXlNL1B0VXJvNUNwTStjREk1Vml4OWhkdm9iUGFBV3pPM3ErZ3lFTFlOVHFa?=
 =?utf-8?B?cDB1MkMxZzBJYVFxcUsvellicGJ3Qk5abzZ6bVhjR1JRYmhzWi9qWmk1TE1i?=
 =?utf-8?B?cDgvUUlsRUk2dmI4bmE3bnVGSUhXRmFFTGV0bDJyQ2ZsYlhDSHVOYzRPdlVx?=
 =?utf-8?B?a295TmcvTFZTMDVQb0w0R2JJMlJoWlZoczZRa3Q1RnFkU0NVLy9SQ2JsdkZw?=
 =?utf-8?B?TklZdFgyYmtBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDM2OTQvNFc1dXh6REhZcTlsdmRUSVN6RE9abE10Rm5VYlBJZERpYWlUbDha?=
 =?utf-8?B?RXEvL282R3ZYOUU0UXNzMnJSVVNGSEVTOTVtelNGRXZyK1JmaC9HMTUxelhV?=
 =?utf-8?B?czdHckVyK2hrcmk3RDdYN01tSFQ0L29DZkZxdFMwa1NYNHBNcXlUYWZDWkR4?=
 =?utf-8?B?aGFQUlo0VjJOZmNQYWJMWlFtZElTRHJhS1dCdytudEw0dkFrc3MwWUlhRDNI?=
 =?utf-8?B?VXNuVkZmMERpU2xKSmZaVUFraHU5ektMVmFlL2pnWVU2aG5WVlJVaWM2L0xZ?=
 =?utf-8?B?c2gwa3pXcHZRYkFpUTdweVUwZVlpeDBBQTdoZmVJcDFpMVUxeTUxUGJYMUVk?=
 =?utf-8?B?QVVqTUV6bUI4ZEhNZ3R3VGdNMU8wVThwRjBxeXR3U1cxY1lIRjNJK3VVclR3?=
 =?utf-8?B?WUdXc0d4cU4razVNK3FQUktQWFlYR3J3NW5ZcW1ZS09aeXZLd0l6Z3h0L3Rk?=
 =?utf-8?B?RkNMU2xpNkRjY3FuSkNWOEZ0dnpFcHVkQkgwbnlMU2ZCTG40Y1NwYU9nbUtk?=
 =?utf-8?B?K3dEL2dHZ0FoRnM1WUJHclRhS3JxTTBwei9uN1NNSU5TQUY0WU1mcy84eGZo?=
 =?utf-8?B?MWx0RFEwdGZDc3BmR2E2MUlxUEJjK2FUWmJPSWNFU1lYREhkMldQblhIMzB3?=
 =?utf-8?B?NEVFRVNFZkIzK3NCeFV0UUJxTTFtR3VQV0tndVRLd0FQN0F1cVJTbXpxcGY5?=
 =?utf-8?B?emF3b21oSnRZVGwwckxxRWwyOVhYWitMMDVFYmhpL1JPRjVDUUkwOWE5TzFm?=
 =?utf-8?B?QnhXc2N2Y2d0a0FGaDcxcUxQcTFjQXVZbWtUeWFMbG9EQXhnajIrakpUMlF4?=
 =?utf-8?B?WmZ4SEpucjA3T2NtVUdCdXFqK1lmL1NQRzQ5MUVNSFgweFd5M3lUWmZCNThN?=
 =?utf-8?B?d29pdURCenoyU2YzZWFFZkxtQUdlWldUK01rU25UOWUwblVXaC9IU2NmZ25t?=
 =?utf-8?B?T1hsVnJQdkRaRHgwbVcwbUdJcjRWS3QzWU8yYldMcnU1R3MwZHlvVGV1bjlC?=
 =?utf-8?B?OHZEaTVNdmlSRTV5eFhxVUdmQkh3OU82OVZiSWVvaDl6WmZ1cHV6cXRqVXVL?=
 =?utf-8?B?cEhaNGdURU5QbEcwVW9zUWJydE5DZERQQmV2V3FuWlhzLzh6TThxWWprd0Vi?=
 =?utf-8?B?TjVUOWZLejlReU14NVhtMkliMi9WOEJ0ZStaOU9SMWdrcDFqN1BhWG9lUVJP?=
 =?utf-8?B?ZmhNd2tudUNxeFVPODJ6Z0lhQk9neUZ3QWpucE1lTWZ3WHhyN3QvVXpaZTh3?=
 =?utf-8?B?Q1k2dFMrUFdnaExGclJsT1dwcWN5MkxqUVNxamVuRXdJdlA3MjlqbHZETXQ0?=
 =?utf-8?B?MUpOY3RQRmx1WGwrT0RNd1FDQ3JaSkdTcGJUeHV2RHdGS2JmeEFnZ1k1V2tt?=
 =?utf-8?B?R3Q2aWpqWkhkdDNNWkJmb0F3OW5pK1FqU0tIZWpiMk4wVTFsS0hxcTJnVUtN?=
 =?utf-8?B?d1ZzcHFEUkxhdVF2SThSSWZQUTRPbGN6OXJWKzdWMmlObFhMOWpUcUpwU2ow?=
 =?utf-8?B?VURTUThzdE1ZNmZQaUN2TUNxREFmdzhYdy81djJtYUs3WnNQRW1EWTRKb2Yv?=
 =?utf-8?B?MHdtRVVwbjNlTjgxZ0tDcjRwaFRBN2tIVEFGai9sZkpDZ05FVmJULzZKdnJ3?=
 =?utf-8?B?dTZlYjRjZXRRdHUzdjJGNkhTNDNKWXhORHRzN0syNEZ2bkxaYlV1V092VklM?=
 =?utf-8?B?eFVXUDd2VUI4blRLaXpoRUtUQXp3ZFllOGNSbVg1MllQZ1cwTG5zdVljeEJ5?=
 =?utf-8?B?T0xvampiRkdiZlZLcG9OUDhWSy9rQTA1SmVvT1BscEFFR2xaaG0zQUQ4aHBw?=
 =?utf-8?B?MDVMYmlGZGR0QVd0NGg0YmFQSTBqd1FkZFNSRHU5OWhlN1R4bzJIRDhuQ0tR?=
 =?utf-8?B?bzN0M2xQRGhIVmhVL2lYa3N0QkpOenRMWjRyUnUvdHk5K1B1Q21tYzdmOEla?=
 =?utf-8?B?ZmZaM1BOcm4vcmtmRUhWSGlpNU1jcFpBc1hYUFRkNDIxK1h6UzhiSTVqcmRG?=
 =?utf-8?B?dlFlNWNuWlBwWlF2eFVOVXJOcTFDODh4cWZWcExYbmRGQUkyajJncVVuZDNj?=
 =?utf-8?B?U0ZWcWxJdnNRR1VRWWFWMSt6QjdoMGRCd1M1WVlxQmRlNHMwVk9rZDdPTW94?=
 =?utf-8?B?eTc0L3RiaDNxWnp2RVpueFg1OEIzK3lOS2x1bFZYV2V0Sk5QOWtaWEo3M0VI?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dcd527-abad-42ed-154b-08ddcbdf261a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 00:55:43.5468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nt0Pgz0zMIuTc5FdsyL8GRAdwMhrgu+1lZvlAKK4Dizb7Da26Fcq6sler5OS4aE2tM5A7XJK17XoJ1gyYoIWeBc+5pcZLfWVM45pJfMgT/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0084F97E3
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use hardcoded values for initializing dpa as there is no mbox available.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index ea02eb82b73c..5d68ee4e818d 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -77,6 +77,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	 */
>  	cxl->cxlds.media_ready = true;
>  
> +	cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE);
> +

Yes, definitely squash this with the last patch and you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

