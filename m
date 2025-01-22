Return-Path: <netdev+bounces-160303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3BA1931F
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B2C3A5E47
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F26213E76;
	Wed, 22 Jan 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdoFfceK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB28213E6E;
	Wed, 22 Jan 2025 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737554350; cv=fail; b=dNsnkSjq+RmVL8gQ9TQUpTevXYAcZ3u6p3gsXK4SwdOkuDYSli2U2Y7KwvFQADYFgHbkRzDdz7NmbNXtwmVVBrV+XBT/IBaMrJvk+vaVjf4VWR8sIPgrGllscgkLMdrZgp3oZHFEfb2/S1r8a+qr+szF2dVf7fQzLE2OwLv9JN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737554350; c=relaxed/simple;
	bh=KZ7dFn3WVzzDkuDEiCK0WjoDN9f2Q4KpVW7tFvnmSo0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jgBwbZ/BySrGz5uqIMEiGHqm5yEnlQCABH/65AjX0fy8FRz31wChpkPM/3+Que5CeNPnbVS/qnh5lxEv3GVNSBHL4jqGgxA/AZFzhN532CiIaYuh6UeD/SZK9qvRw40UEhZ62z/6Xku2neg6tKD8uUQJaiNVLo1zBcFTqs+Vcn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdoFfceK; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737554349; x=1769090349;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KZ7dFn3WVzzDkuDEiCK0WjoDN9f2Q4KpVW7tFvnmSo0=;
  b=FdoFfceKHJtRwPCqwVSHViP5dj8ij5WDvhAvW9srT/nnYiz/zhZypxDc
   EWMBqMwLl2FpviCtoM/jk5DPH329ck6vSNUz2FryqRVWPwkPt0cE0bDag
   gi3nGIrER20vbbznPU4Ebnaxw80HzEXzAHc2Zjy321a5PIL2yghlxYIxb
   Av2AZWB8wgfky4vjGvLGEbN/1Vm1M9hanX+C/d0y1Ym+90Y/bJGWSgD8C
   vvuljsiXwgVwjneg0wBdXSM3rtlWWnNOpInvRCwn+NVQtAF8sdrwkUBiw
   nK3rS0obTDytQqfpOcJEByq/tlATpmL4Ty1dkgoaArqPMh3ij09bjCV/T
   w==;
X-CSE-ConnectionGUID: vTn6Ta4LQzKq/RD/VXgqtQ==
X-CSE-MsgGUID: z+D1Flz+RX+D21Qc4J0dvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37895197"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="37895197"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 05:58:58 -0800
X-CSE-ConnectionGUID: qaKRNCqgQ4uVCd+hV9cRww==
X-CSE-MsgGUID: mDWOYB7/TFCIGMhoTkx1Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="107673721"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 05:58:56 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 05:58:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 05:58:55 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 05:58:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nE9SjpFVSFWigE901UhSWIZNBq8VJJ28B471N+xh3giUUAqFrx55FpKvy089w5rxs9xSthDzMl3FUd4g0zlYbOW/PbTA6v7aB1UMf3FLscfWkUm3FttFdhqATOfBRw5K4c6yurIVWi/maRyzsSKi8UDzq81AWvKn2nqRnLAga3KjqHms7gVW0/ujSdXekWRymNu5ZfCcUpfX2/4ZTsIfqCem68i7X0wFJy/FPTyHh2HJX/TUnuSSlF7VdAPDe+EjBBm3yyKdHciQf11CqMsZxXGpy4P8MMfNyIor6z1qfG7HuaBsl8piIVqjKSLta4keCXLe76IcrWmlUaJiB1K+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Sh+RDudt5nXolCUbJZb1RvoaiMyBD/IjqX80OTnh54=;
 b=yBwM5qVlvqnzjir77Kpwv7fOHw+Xrj4PKhaT0+gi8zC01JmBN2fQ+SaYbDo1caAieZ4R4iDBTTBMmjJJ+pFsY6Aj+TtiNSfPsel+uD1+IXWkyjzfPmIR0N1/sKLBHmwabTL0SJ3KNDXZJs0ctCp1bkNYwKos9zIOmqMEOq9y/5bU0UWhFYx4F2JnZmIRww7YmXzt1rud+fYVBGJwycsjMH/yKHhRW3rDFgOxwC+skosp6PjTSC7JVLGluUSlyo79WaRnD7KSCuOE5gUqllcvG+Qu884bGUONA5teI9Xmp4xAKP7ZXGR1Z9LVcvp8PASDadtX/zqdqH5wcljm63GvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB8524.namprd11.prod.outlook.com (2603:10b6:806:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 13:58:39 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 13:58:39 +0000
Message-ID: <566b3d82-5e66-4e97-9808-a0e8e212fe67@intel.com>
Date: Wed, 22 Jan 2025 14:58:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v04 1/1] hinic3: module initialization and tx/rx
 logic
To: Gur Stavi <gur.stavi@huawei.com>
CC: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
	<guoxin09@huawei.com>, <helgaas@kernel.org>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <sumang@marvell.com>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>
References: <3bc8a815-96c3-46cd-ae87-b46b61648bca@intel.com>
 <20250122070752.3966233-1-gur.stavi@huawei.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250122070752.3966233-1-gur.stavi@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: e4797fcb-b6df-460f-cf4c-08dd3aecdf81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnBFdVRkRVg0SHFYbWtmQ1c5NTVJQyt5Uit1Mm9QeDh4QitOVWcySjZXc2dU?=
 =?utf-8?B?THVwRlVsWHovQkJWN01JKzFBbDlkSUlmVG9ESXRYMzhQY1JoZkh0d3Y3bFQ1?=
 =?utf-8?B?d2NTcFE2a3haREc2cXc2cFM0MzVtQUJWOTZYeXdKU2JnNDFCNGZLblBuUEEw?=
 =?utf-8?B?S0pjQ0JxdWN3bTRQM0NtaG13V2dVdExkbm05QXFiejQzaXcyWlRaTGg3Y3k4?=
 =?utf-8?B?aVphcGdETnBlK29oUDJJS3BVcklzWUgyRTdxV21vWUN3aDZNbWNCejk1YTVm?=
 =?utf-8?B?OW9UaUZiM3paSzB0YUt3Wjk1amR1b1hqZityRXRKd2IyMUh4MC9EaEJ0bkM3?=
 =?utf-8?B?dWVtKzZuSldicUViUlNxcVE4OER5NkZOaE9nZWdkaGRsMmNrQTBUMjFwTGY3?=
 =?utf-8?B?TjJISW9KZW9CV1V1bTlxR0oxS29sQlFEQVJjNEtRTGZ3NnJIRTB1aHJ5V01x?=
 =?utf-8?B?STIvbkRZeGFJWVBmOC9XT3E0Vm1abkYybVlhdDhpN1p4LytXRmEzcDJESFZn?=
 =?utf-8?B?aU5YM2oyV2p6RkRGUmUrZGdsa2JFYmJuRFUxamRDU29rclY5d0tLTUNOYzky?=
 =?utf-8?B?elRhbWZMWFd1QkxCZUlTZml4TWZFakUyQ01TZzkvRy9QMEZpSnA3ZEcrKzE3?=
 =?utf-8?B?ZXRxTTd4U3ZVOE4vN2tOTmJkbDc4OFZQWFNSWEN5TWl6aEl2dTVlVEt1TExa?=
 =?utf-8?B?NDMwMlJnNkwxV3IwYzFpRllhVG1pcEtEMXZLbnZqWFROSjZpZzgzYWFENlQ5?=
 =?utf-8?B?N1JoMnY4M3hqVzJOKzhZckdNdXpYbGR3V1MrTDdvcXYwTUEvWGFsQURYalJi?=
 =?utf-8?B?UkxuRTF4S05tYnhXS2FqeEc1QXh3Nm1uNmVHa015RGJLWmNuVWxEMk96bDhL?=
 =?utf-8?B?M2FobktiTGF1cWJNS09jLzRjYWxPQ2RiMzNpS2xuNm9JVHFaYUpYeU8xODhB?=
 =?utf-8?B?d1poTWhrWDg0dzFPTy9veC9UdHJ6ZitPZE5Xak1FaUpMMlJYWUlWTnVlWXl3?=
 =?utf-8?B?ZUcvdThoTVdqVFVZeWw2dEZra2pYWTdIYVMzODJGQjJrYUJzbW1lNGcrRXRk?=
 =?utf-8?B?R3JPNTIyLys0YTBIUTV5dFc2UDNWbG1laGNHVWtZaU1pdnZqZDJTK29pUjd2?=
 =?utf-8?B?MjdUUHc2NjhSblVRbjJRNWt5TGU2djVQM2dXcEFiSmU2YzM3VzJWalRBVUE3?=
 =?utf-8?B?dVR1M3FJbE0vSEdTRTZqN3JwcUVzUmZGUTFDQ2FPNkNZUU1FM2t1WnUrUUJV?=
 =?utf-8?B?b013aml1VFZhdDJtamtEUzlrVjB5QXRsKzh2QlJCTHhhc241SHhHVEU2Vlli?=
 =?utf-8?B?Z01vUFo4Nm1GOXlsdGt5TlVUQVAvZjJ0ZXcwUXJWUUdjSmVBbEJtNmQ3MDVC?=
 =?utf-8?B?Y2hINTJmTmhFWFlKQk9CR0RjVlRqMXhsS0NDNkE5akVPbkRPVEIyYTJTK09p?=
 =?utf-8?B?Y0lqNXBxQUEvQmpqR1BnWVdhQzMrUlRQVitXL0M1TVNVSW9ENytIdzNvVE9p?=
 =?utf-8?B?VnpIUzFGWHRJTVpWakdwOG5PSEhZMnNYeGNZcWl2eFBhY0F3a1BFVkVwQ2ha?=
 =?utf-8?B?dUdydHhoTlY1bVZjaUJLWldzVU9FSFlqSVZnT3N0RUJkL0hhMEtLU1MxcENq?=
 =?utf-8?B?RkhsbWY3UkVNUFdjYVppaFV0d1A5YkpFSkdlS1R1S0xNc2FFbm5DVStPcVpj?=
 =?utf-8?B?c0pjK3YzcjZTMXlOSHNTWjhscHhSbDB4YlFkek83NXNkN3grWjRGZFRCMGU2?=
 =?utf-8?B?SzBZeHZsK2FjTU9zaUs2U3gyYzVCQlNOVkdwSkIybEdxOFZ0NHNIQ2xFQXNq?=
 =?utf-8?B?WjFOTXlGTDJENUxrd3ErQVN2VGUyTDBDOURqSi9ZKzFFQ0o3cWtSR211cng1?=
 =?utf-8?Q?sCiKY20Qm/JL/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnJLaFlETm9kbjh1aXd5SHF4MXhaSEpkMTA0ZTRBV2l6NGxDenlaekJ1NnZa?=
 =?utf-8?B?dzRhU1hIR0t1RVZvWEVmTk9yblB5cVZuVk5BWG9lUHZWVFpNUzRDb2FGZFky?=
 =?utf-8?B?UjZwNE5FZXNBc0xScm1wUkxwVHhmKzdMYTlZU0NiM2pYZWNoLy9nbEdjYlJC?=
 =?utf-8?B?eU1RdXg5S3Q1WC81K0QxOVdtcWZNYkdLSDRwdnJFWTZsVXZiWXhxamREaXhR?=
 =?utf-8?B?MGRONXpTVTdPWFEwTjdXcElOZHZsMlBlR2NtVTk5OG9Vb2ZyOEFUU2ZWazRJ?=
 =?utf-8?B?UEQ4eEdIS2xIY1kvQURRNEw2dS9CZHZKRkZCMi8vVG5ZbFF6ZWZ2RUNHdDdB?=
 =?utf-8?B?N201Y3JVZ05OUFBtbzREQnpuREZybmNoZHM4OXUzZDN3aEU0T09mZkludVNa?=
 =?utf-8?B?WGEvazByajhqU2hHNDZjc2d5UHVVWG9XRkt6NkU1VUxMTTgzVE80SVcxOTEz?=
 =?utf-8?B?ZHI4UXJkcm95L0I3RHkxWXlGQThiT2hyT0xkWHErdGFlS3lwRnN5TXBJOEFm?=
 =?utf-8?B?bGFRWW5SRUs2NGMrcEJIL083SVV6ZmdQSk1BRXk4VWxuOHE4bUI4RUUyTE5M?=
 =?utf-8?B?MTZPVFJnYzVybG5UaDZUWUlpb1FnSk10ZHcrQ3RmWkFRVFRGS3NJRk5Qc3Vi?=
 =?utf-8?B?cU5XaWhsa2ZGanFVbDlDK3ljOU5JekRqMHN6UGxNNWlxTFp4VFZBWU9Ubkxv?=
 =?utf-8?B?MGYxdUs2VkNSQzJ1ek0rKzBkQW9kU1JPbGRNYm5ROUw1L3ZabW5oRWxzN0pH?=
 =?utf-8?B?QkZpSFNuajhsbk5naTFIQ2pnaHJiTVBMYXF1dGFwVitXSEFGamM4UUx6MW9N?=
 =?utf-8?B?bUpNQjJOS0dMOStVOXVtV2p3RFk4VW5Hb0J0dWZxL29TczZIQ0ZLWWVqazhM?=
 =?utf-8?B?VjMvb3FWSHZHY3AwL3hER1dHVXBxcWMyUmFITFltL2pKNGZGZnlrZ1FWa3Rl?=
 =?utf-8?B?ZWdZaHJsK2hhMG9WWnYzci9Zd2p0NGNRVm9rRkVieEk0Mmxib3ZiYkY1Y0VP?=
 =?utf-8?B?MEpsalFveDBGZll3a2pZTzdWRE4zeXFMOG91c2dwVnl4TTNFb08xZmNkcUxu?=
 =?utf-8?B?VzBUMjBTWlYzSFJIZW9yMTVCQlNUM1RnMHE5TUZ2ZUs2YktnYkErdjRVR0pH?=
 =?utf-8?B?T1NhV3JPcFBwUVN3RlVZNDFrQ1k0Tm9scExndEdkYmVZeSt6L2dLa0FKenkw?=
 =?utf-8?B?a3F3MWRPcEw0SHVNc1pHT01Oc29KSjFCdkhjVjV5NXYxUlNySFRpdWlCbHRB?=
 =?utf-8?B?V1hKcHMvMkx5enpYcElHK2V3UWU2UkUwcU80WDY3WHN2OXEwUWw3Lzk2dlVa?=
 =?utf-8?B?bDJ0OHlXa3FCVjFGcWdHUEE4UkFkZzJpMTdRd0poWXNzN0pKR3VEblZnZVZa?=
 =?utf-8?B?U0tqSHFsVmcxZEtKMHJFV0cvY3dEN1RQQTh4eUdZc1RJTmxITC9TL0NrYWQv?=
 =?utf-8?B?L2JnNzMwbzUrVnJ4VVdOTHFZai9nUzAvSURVMURLQ1hXR0pvbnczM0NBM1hS?=
 =?utf-8?B?djNJY3o4eWxEcGxxK0NEN3kyQXkxbU9nbEE4c1NiT0M0RGxtTTAwUEREK0I0?=
 =?utf-8?B?UDZjckYyV1paOW01NWRGdWJKVGZiRWVTcjBCUHJHM1Vjd2EyVFNzTCs3cDRl?=
 =?utf-8?B?T2lMcUN4NjhLRU1EK0hZejBSbk5Wd3pZcHQ3eW93bDhvUiszSldZbEZjdGpz?=
 =?utf-8?B?QWZUOTYvNFUzOHlWY1c1NmU0NFdaV3lCQXRsVlpDQXpSRVA1T3orSXgzcmVt?=
 =?utf-8?B?L25FTEZWaVgrNmdqSHVLUlkvTmRpZi9pSHlreFJ5MGRBMjFCckRmeS9VWjRZ?=
 =?utf-8?B?LzdVOU1ETmRuYmZIeTZMdWl6SUVjWXgwYkNOY1BoL0UyUHg5WUhWRjFyaGg0?=
 =?utf-8?B?T0U4N3NrY1VmUUVaVUhrdmJFbUJ2YUlWSHlITmR6OVdrMzk0UmdtR1Q2RGZL?=
 =?utf-8?B?SVpJQWNvQW5GOUJJaFNKQWRBcTV5Sy9PYXRWbGtWTFBpMVFKVEh2dTFNbUtX?=
 =?utf-8?B?KzlGdWNUZG9BYng3ZUFVVklOQVJUeU9uSTF2Q3JSQkxNT2JPOUlHc1pQYmlE?=
 =?utf-8?B?VFVNSjBYR1pjWHNFaGJFOUdsc1VpalRSQ0dYN2JLYnpWS0toZWhiUXRVNnNt?=
 =?utf-8?B?ekdtM0ZPcEQ0dFZLQ0NPd28xZTRpYUZNR2JvcmNYK3BMMkFXMHdTV0Z1cGht?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4797fcb-b6df-460f-cf4c-08dd3aecdf81
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 13:58:39.4992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJF3DAYES+kcq4UUGmTG0gKnYGz0ARc1NfVBa6eG7icrGfUkOPRhtPZpavPAK1asp05x7a7Sw9utoeKrerZutwdvu1yuUUa49o6bl56GkjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8524
X-OriginatorOrg: intel.com

On 1/22/25 08:07, Gur Stavi wrote:
>>> Auxiliary driver registration.
>>> Net device_ops registration but open/stop are empty stubs.
>>> tx/rx logic.
>>
>> Take care for spelling: Tx/Rx; HW (just below).
> 
> Please elaborate. Spelling of what?

In all code comments and commit messages the acronyms and abbreviations
have their proper spelling, like "Tx", "Rx", "HW', "SW", "ID".

of course lowercase names are still allowed for variables/fields

> 
>>
>>>
>>> All major data structures of the driver are fully introduced with the
>>> code that uses them but without their initialization code that requires
>>> management interface with the hw.


