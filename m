Return-Path: <netdev+bounces-210923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6674BB157F5
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 05:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9737F18A7531
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 03:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A42CA4E;
	Wed, 30 Jul 2025 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSBcUtQP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6C84C62;
	Wed, 30 Jul 2025 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753847185; cv=fail; b=msAQEmU2nAIoN7vuCzsAvCV7lq3KwqoHIAGTlZUc/rUWMXxJvJzcZWr0nJAuSAjS9JGarmVruqF/mOhQtr5Zfrov2XRz+Xfq7bGmqeXlBGZBiki/yQEzZBqKfSKmk5Pcpq9+y8Y06H1+HwWH0iLj1YMPf6KXAUZBU89vYpj6jTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753847185; c=relaxed/simple;
	bh=fNQQ2t1av8P/NgwoWa8Qjlt0H/fmgK3iFBWkujyA0IY=;
	h=From:Date:To:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ICC68AIRRO2BmwJAw5u0XJZlUTH5QyJZzJeHchDzGoni5JxiAJUmiviKf5NWM4k/DxwF0MUqP9i84l4LCDyylzMy3TTetdav2IKcTexH8X8iSSin3U9H9q/dVhW1DUVlTfmHVHhbY/RjhKfn2jV4KAVihOJ977OA1UsQyxZjc/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSBcUtQP; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753847184; x=1785383184;
  h=from:date:to:message-id:in-reply-to:references:subject:
   content-transfer-encoding:mime-version;
  bh=fNQQ2t1av8P/NgwoWa8Qjlt0H/fmgK3iFBWkujyA0IY=;
  b=eSBcUtQPuO6MU6svJWWTOLnlQ+MMB5QIgGB76eXpkHYSHdqThc28ITf8
   ztQtK0h13/RD+Ak3bS9WYK1vkf4IlKXYJtOZWFyELkoK2xipUxb7Fgp3B
   mtOz++cr8y/CJ0ITalrYvgR+97wqwpm9Uzv8YISTJCzvxziBwkTUbd+ic
   LZZi+xY1W7koEnDK+4d9YDYQ3294SRqbQMEzqxE57FvzCldbi6RPKPQnI
   spG9DML28kIlnj/Ut4VkFb7RXgJyk1Q9e97vccqkP0mJrpP1Q/04GmY6l
   jykK2s468qhyv1ZqfePrpwgDDmo/Y8sKdKSYxQsMvcb1J4KyDWh6RS5sD
   w==;
X-CSE-ConnectionGUID: 8Mf1nO/LRE2onV+srz9+oA==
X-CSE-MsgGUID: 733Tcd3rTb2UjfgTl5a4gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="73726701"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="73726701"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 20:46:24 -0700
X-CSE-ConnectionGUID: 6Yv/WrS0Sca9tsNIPgcaqg==
X-CSE-MsgGUID: ByM/VFeTSeG5z/r5TTBmWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162597790"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 20:46:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 20:46:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 29 Jul 2025 20:46:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 20:46:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzXGUPJMaioyyZ2+jTAuc5azgenkqsUGjImDr7Y+w0GF2mCZTLMiYUab7dUFH+HdMhWlCiEabXcf7R0yATW4CQRtk1lxHX9uC5DnjnV4tR5+O6RVrpDULvLPrcFigfNeCjj0CS+yBpvYY59/LX4KQtw+QCaPgLLi94/Zv702O9Zknb7P/Zr/aam0XUVaEhro8iLg3Pu2hHH3wsIj/gQQDGVV5B+JU2WgwruQxJg6VvmMzYvVVPVpS+qObHxCP4I+TaoBwZ7MTlMXK+6R5TcuT0o0Rjlz4oUb4cEJ1KHZocHRTrxFUHEvqh+oOskfWTvhN+NurUd1IIq+mSBKbt3P9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNQQ2t1av8P/NgwoWa8Qjlt0H/fmgK3iFBWkujyA0IY=;
 b=Z45uac8nXw8Z6vqAmSNxRpAt23HDlzIKSQIiGeu6hAxaN4CRExD217s+ulQ9zIZCZOnaZqOI1KxUyXbxX+Auj1eL03nRalRWpL9jqD/VE5cV/lPMD3QY/2qt+f1rZHZcYV5Pqb8NVM7p5fcUP7XmnaJLhg8uXwRt+gAhXR3qsvW+mPRP9DqsEk0tVl6i3y/OvSJ9oyVi6945H3Sb+CGOl3p+gWA/eakP1u3dDh5kC5abEOtbnNd+PKG/6TYCc4f1fkaFu/wjiGBAGmQZvYY7pef3uVV/fv7+AL9sMlLCBbGk2HyXqRJiYsnPTOo/EIZU/82zh9w0ODc1CPF17fOQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8446.namprd11.prod.outlook.com (2603:10b6:806:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 03:46:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 03:46:20 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 29 Jul 2025 20:46:18 -0700
To: <dan.j.williams@intel.com>, Alejandro Lucero Palau <alucerop@amd.com>,
	Dave Jiang <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
Message-ID: <6889958acca0f_55f09100b2@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6887b72724173_11968100cb@dwillia2-mobl4.notmuch>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-11-alejandro.lucero-palau@amd.com>
 <30d7f613-4089-4e64-893a-83ebf2e319c1@intel.com>
 <a548d317-887f-4b95-a911-4178eee92f0f@amd.com>
 <6887b72724173_11968100cb@dwillia2-mobl4.notmuch>
Subject: Re: [PATCH v17 10/22] cx/memdev: Indicate probe deferral
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0060.namprd08.prod.outlook.com
 (2603:10b6:a03:117::37) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: d97896d1-8363-493c-db1c-08ddcf1ba5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUs0b25JWDZGOUJQVWdSQWdpVlNrc1BRWll0cnJybnpHMGRZTzl5RURRQ2U1?=
 =?utf-8?B?WExYRytVS2QxbHY1ZmVuYTgzdGczejBqRVNmT2YwdXd5SUpWL3VHTi9SVVNR?=
 =?utf-8?B?MTRVRk1UenZMRzF2NUlYODRvUHZidEQ4RzlKZTNLK1A4dnZHWkhQTkNsSWJH?=
 =?utf-8?B?VzRXdXFqcUxvZTRkNGxacWZjS0hob1E5am0rZXhVOXZ4ODlQcjIrSGxxdHla?=
 =?utf-8?B?dEpscXY3dDByaEFONXBNUWxVMXNKMWw4QlFzcFFOUXdCcTE0ZnBpSHRmM0Ix?=
 =?utf-8?B?YjE0Sm5xRlV0b2lIR1d3Sk5Bc2RZdWtqcUdnUE1FU3NGYjV6bXMycGFhZkN5?=
 =?utf-8?B?QUFYTEU1WDJMYWtRZlU4eVF2THFTdGJzMEI0U09RVm5BTElQU1VqaCsvcVZN?=
 =?utf-8?B?bkpJek5QbkVJOVV4SVNhNCtQOGJKa3ZiTWRFMm5sT0pGQTRqNWZTWFF4d1dJ?=
 =?utf-8?B?MnQwKzJQS25rQzRqRWxWeGhTMHFyL2ZRQkhueSs3NHlqT1QzeEFaRU56U0V4?=
 =?utf-8?B?azZRSlQ5VnVxUlFNeVJwbXNCZFBhbURVWDhlR0E0bWhmNlFQNTNKWFBIbkJr?=
 =?utf-8?B?WWd3cnFYeWZCY0pUUmJaRmVZbk5Pb0FsMVBOOC9uL1R4RDFIUCtuZDRPVTc2?=
 =?utf-8?B?cUZXcGp2Z2JHT0JKdmlCVXJlQTJQaHR2d0FTMmNSRDgxRVRkWjNJaTFxL3dx?=
 =?utf-8?B?NnZ5UURRbTY2QXJyZGRQWFJNSjM1TFFQMHVMci9ianIxeFd6ZmtnYklLNlNZ?=
 =?utf-8?B?SGYvWEtPYjhWaDk4NHJ2WnBFTUtIWWVLTlkxd3NzV29kOEg2RmJlMm5sbUFO?=
 =?utf-8?B?bEtlb0VLUmJGM3Y1UTJMT3ZXZk9ya0dhenNoSTgvUEdvcXFTQWFTQjBjMFBI?=
 =?utf-8?B?VkwzVjJMUUpFY0Q0T0NWSi9uaUhTTkZ0RFBZcFV5RHJGcitZSjREbVhpQWtL?=
 =?utf-8?B?TkFGNkxIdVlRNmh4U2dRak9NZXhuRWFJS0YzZEpiZ3c0YVlBUlErSzBwYmFN?=
 =?utf-8?B?Z2MwNFF3eEFKT09zTFBZYUFQNG50N2pPY0pkZmtJYkV2ZkU1cENTT1JsMUpk?=
 =?utf-8?B?OUk4SlRqNDBjWFpNTTM5cjMzMldxTzJsMVN6eG10VzAxMTdKQStIMkNDUHR4?=
 =?utf-8?B?NU5PQ1o0KzhPT1dtcytaeTVSVTZBYmFQS0hGWGo2YndIc2VUQU9sR3puRkgw?=
 =?utf-8?B?dmxmc05UM0ZnYXVIRjFnbUE0YnFiVHBOY2k0azVDNU5sUWdBWG5tOXdRRWh0?=
 =?utf-8?B?bmRoTkJvRS9tdlR4QXpPa3Q0UHBBT0RtZmVQeVVMMFhWTnpyZHBOUEQ4VGds?=
 =?utf-8?B?Zm0xQ0dvWjBGNituMTRyQU8yRVRtRHFmQ3NzYXB5dmsxcnczb0FSbVJCOUV5?=
 =?utf-8?B?Y0ZvSWloc21GR0wxRUc4WFp4aUdySVFLMDBiZDhINEdvdEx3ZnNpR2I2OVhr?=
 =?utf-8?B?L0ZuSHFLSC94YVBqMy9WRnZvcCtoc09aMDJaakJONysvSDRZYnBYcHdsV3Ns?=
 =?utf-8?B?MTEwd2V2d0twNkd5cUc1M3NQQ05WeGZZNXpaVVkrc29ueXAzemJodEQwTzBj?=
 =?utf-8?B?UC93WXBYR1oyUjdnYjZ1Z25jejBoTTNOandhTVZHd0JTMFdqS21jUGpDS0lT?=
 =?utf-8?B?cURTTzFDZEhsRFloa2thNis0Wi9zMVlMN1ZwUkV3K3JRbkRQdW9NLzFQMXk2?=
 =?utf-8?B?OUNXTU9uaWF5UDNEaUplV1pNYnJDRDBVaU5aU3NZeVg5aXVqeEtQWlo0bC85?=
 =?utf-8?B?Y2FvN3NSOWtOTlBUWWU2SWpsUW1zYW5FT2Y1KytPOHlOa2hDL3lVS090dUNQ?=
 =?utf-8?B?YzZmYzZJYnhIallJUTJudHIza0labTJmR3Y1bmMwYkw4MUxoTzlicmVvbDZi?=
 =?utf-8?B?dngwU2Nqc1BNQno2d2g0azRYUWgxTHVHWHJPYmZodDd6OExTWjc1bWQvWFQ5?=
 =?utf-8?B?cUg1UkR5LzIwTjFUVFBwOEU1RkxVV2xzd2RCRUh4Sm1DL2ozRlZBR25lem9y?=
 =?utf-8?B?THozd1M3NXBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UStwTTgra2lNbkZFblhKaCtKMWRsWDQyYTJ6U2dheEZwWlp2bDVObnB4WGw1?=
 =?utf-8?B?VHdObjVpNHRnckNqSG9kamZJY2NFTHpwUlNmTVhYSVpIcUZtcnRzOFE5Smti?=
 =?utf-8?B?K05EbUVyVDhMcjZXY2ZHckJWZWhWZS9PU2xRcWNXV2JsQTVmK2pvZjNlYUp3?=
 =?utf-8?B?QnkxSzdDeHRZTWM4T3pQcU0xbHR5c2lLUkNHcVlKL29NYmNLVEJzYUxPaWdx?=
 =?utf-8?B?N3o1Vmk3aHlISElUUmQybVA4KzZQc0wvZktxbExwVG85OFZBN0F0eHlISGo4?=
 =?utf-8?B?RlVLeXNMT05CR0lqenR5VDhUaHlqUVFFTkh4Zk1ja3BCMVVCUWNpNXZVRUpK?=
 =?utf-8?B?blI1ZWtvcEoyaW5udXppTVhLbjdHd3dCRGFGY1lZZW82RlhsV0sxOFZjL0Zl?=
 =?utf-8?B?VkxPeVMzNldFYjh3anZXNStFTjhmdi9YaVRzb0lFZVVZeGNXSW5YZytZYU1h?=
 =?utf-8?B?REp3VzBSV1crN1JPTU5wNkZ0dmhLUzU4NWVnREtjMWpyL1dNbnkyYzF4SXFj?=
 =?utf-8?B?UVBQak5OUWFERFl2MDk1QUFSdmlVZ1BhK3gva3hsL0FhTFg1TWZGaTRxNit5?=
 =?utf-8?B?UVhuZFB3cndrNTcrc1UwTHNrbmp5d3ZmM0wxR3Y5MERZMlloSEUwdUhoLytK?=
 =?utf-8?B?b3c5elFXWk13Ym1BY2t0RXFPa2Y5NDRLZ1lUenAyZk9VVE1naDJhT2MvQkhB?=
 =?utf-8?B?djZxc3VHMGMrQzFFRTl3eTlTelIwNW9oa0JqODBTM2FxdnpZRzF6UzM1WjVp?=
 =?utf-8?B?Qk5xNFU3d1p6YURsL1hYQVJnRHlkaFJtM1ViN0VlNHNka0htVHVkeWloblRX?=
 =?utf-8?B?QjJmNHFGYlNvZWRxSEZsU05rU1UyTlRUb3BvTTFPR01WeWNhdjBkRkhvMmJt?=
 =?utf-8?B?aVFrcU5NY0drZTFmTDdDamU2UnRWZHhqZGJWVmpUbmhRa3o2Ny9DSmdLT0JG?=
 =?utf-8?B?MHRUR0ZCZXQyZDJiSUpHVTh2RkpySjhiSkR3TGdMdnZ2Z1ZsVk9vZERSM2xU?=
 =?utf-8?B?Q2xSaDJsTlNpejhFSVNPZUoxaXlDL2VuQUZic1JhVkY1ZEdSejhYSHlvS0Nk?=
 =?utf-8?B?UGRyTVlxL0NUUk93SXBYRmVyR1U4d3MvVGJleExYWElrRW1NM1dqQnNoVEdV?=
 =?utf-8?B?eURLbGJZTmdoamFjWmF2T0pSR0dtM3VDcjY5aS9PTzBJOWc0ZCtLNmQxaWIx?=
 =?utf-8?B?cHVNK2VnM25PRzQ5MVN3a2x1eW15ZzhJK2o5bUJuNHRnenFLMk02UXJYNVg2?=
 =?utf-8?B?ZlJidkw2bDBMN3hkejBhQmpqYTQxeVFOdWtDYUduZHdHVE1TbVNjSHNGN1h1?=
 =?utf-8?B?VGVIdy9LTTd2MDJpbmw1TUFjK0hyQ1lxRHAvZFQxdzk1Wm5Kc2Y3WlZTOEkw?=
 =?utf-8?B?aDRWdVZuOGRFQkdGa2FlcUNWdTVGdS94NGpUbFJUWHQ1dUVwUWNLVWJEbVF3?=
 =?utf-8?B?dDIxRXc0dldtazA5eWxQa0YwZzB1aWdIcnIzRkptKzZodW9Ma084Tm5iZW9F?=
 =?utf-8?B?K0RGTXZMK3FxSGxLc0pSTnJUQWpHRjVwMElCdmEwSmdWUFRtM0JhUHNqL21R?=
 =?utf-8?B?V3hQZnhiR2l1cFY5SWcrYkk5LzhnNEtERXp6cFBETGtPOGhPallwQURxNGcx?=
 =?utf-8?B?dmVzUGZ4N0VyNFFtbDRVQk1meEpZTUhEcFFlcUloYkt4emIwZUwxU0F1elBG?=
 =?utf-8?B?cXlxbHBsSndQSGY0VzM5KzArR0hHQi9DUkZHNUNEVEdiemx3UGw1Q0MyMGlh?=
 =?utf-8?B?Qlk5Qm1paHdJcWU5Vmk0Vlg5Y3F4NFAxdlRNR3RzSkhablp2VTJNZ2NmUmF1?=
 =?utf-8?B?YWhQOE9hWi9vUWJwTlZTVFVxSkgvNG4wa3FtckJsNDZLbGYyK0hTSzFVckJM?=
 =?utf-8?B?cmM3RU1TSlRzY3JrQTdOM25pMHhJanhJdkVNK0huZkxwZXFXWkNuaE5tOWtK?=
 =?utf-8?B?VXpWYWw0RFg5UWZPUkxqZ3R2MmNxNG5nYnNuVjNrd0hJNmE1TmZvTFNEMWNG?=
 =?utf-8?B?OWdzTVg2R04raFRZT2Q1WS8rN3M2Z2RHQmx4OWkxMnI5TjZNamh6c1lmUHFt?=
 =?utf-8?B?MTFnOHpGWU1GOXJLanI4cGUrUzQ5Mm8yYXI0emZIV0dtZzZWWGtSM1k2aXNX?=
 =?utf-8?B?RW5HMkUvMWNsaXQrTmJlV2NaOGpnYURkenlYRXBIOHVhUDEyNGZpMzI4ZmRN?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d97896d1-8363-493c-db1c-08ddcf1ba5b0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 03:46:20.8921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeMaKIQOVHFbd4eFn5BJk8Jr8Tajn5BcvEPeUqYtueS9R7nkP1q+qcaaPkubyKYYxMJGRniNkR2lPzZKkiBi8+kj3mgCSTsmtO8E8edH/oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8446
X-OriginatorOrg: intel.com

dan.j.williams@ wrote:
[..]
> Meanwhile, I am going to rework devm_cxl_add_memdev() to make it report
> when CXL port arrival is deferred, permanently failed, or successful.

Here is a branch with my work-in-progress thoughts on fixing some of
these module load ordering problems and obviating the need for
cxl_acquire_endpoint():

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.18/cxl-probe-order

Feel free to steal from that branch and take code upstream with my
Co-developed-by. The main missing piece is integration with Terry's
"pdev->is_cxl" enabling to know when it is worth waiting for CXL
scanning and when to fallback to PCIe only.

