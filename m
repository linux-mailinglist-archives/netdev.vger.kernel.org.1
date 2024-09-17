Return-Path: <netdev+bounces-128645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5120797AA7B
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 05:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF8FB24615
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C25B1B813;
	Tue, 17 Sep 2024 03:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCJLX994"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644162905;
	Tue, 17 Sep 2024 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726543909; cv=fail; b=A4E0Q7sVcPe2ttEvlzH9tS2WCsmD68x2n35q7qQjTWqHf6s6UZ9KzLea5d/6yFvXZPl68ksNRN5TSv6bTGozQ605qnz/Zt2Q13w3TXY7QMQKkG9K7T8aGeFn32GuyqI/ohY8QB9xM8AJPSf0URxtSPuy/PtQvlz+hgypzcwPuk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726543909; c=relaxed/simple;
	bh=vZR+ZHO4m/LDTLaG7Kb4PO9o0/sKlET9WNSIKZH3/cc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qh+JVxrfScGll5a/fFCl5oC/PUQW3L9vn9SshxlWRRtKYIuoSsNAjpJUa7H+Zh2vexxzvDZJ5mQuf3K5K7G/RB3ZreAcRoMoT3xhctq7w8NeJmhdbHP9HRqbSTQFNm7pl8pkzmuZcEcQ09aVET1Qwdg6i/IJCBmBjbipu2MdIi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCJLX994; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726543907; x=1758079907;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=vZR+ZHO4m/LDTLaG7Kb4PO9o0/sKlET9WNSIKZH3/cc=;
  b=GCJLX994YTIvlOgq9RqYQWL0JLT4ke3y8FbALHvXHzueMgpN8fkPEhmJ
   4J1N5oXLy2y3sag/GDcwYz0u9XQknvs0VrFb9blV7kFCeNNFiQKf1zl7i
   QKu3vTnyFBSzwj9jjHJ2RYcCHZkh8BioK+PtnQ4HUkZOEYZfQlfaPs1wC
   Q8IkSlrY3jjMQFWcVUw5KAVTwMk5f3J8bHwe2ScPYGZlDMWyroQsTsn/k
   FM1J+oIMxKcZ2k04/PsKdIe7069heJoN8d7xCgnFtwvxp2macu8zdY2rc
   I1SZa5MfElCfRQm3DL0ndeYGKapW1ZawGD1UQP5cMgCBg/METejgDYFEC
   w==;
X-CSE-ConnectionGUID: bVXHhzcaT0uHSlXYjnGP5w==
X-CSE-MsgGUID: ZW1Q9wQlQPqqP3qeClmGTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="25588062"
X-IronPort-AV: E=Sophos;i="6.10,234,1719903600"; 
   d="scan'208";a="25588062"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 20:31:46 -0700
X-CSE-ConnectionGUID: YoppJY8UQBih6YXK/SJWuA==
X-CSE-MsgGUID: yG8PKUO2TUuKkA54z8YJPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,234,1719903600"; 
   d="scan'208";a="74059854"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 20:31:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 20:31:45 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 20:31:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 20:31:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 20:31:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/YLa9aHgLUtjstrxPFDrf+YyymjR/S5EdwqCz+l9MHtKnIMEf4p/vhR1CNMi2oi8k2CNQfdZ/j8zO2OmNO4QOFn3hykYynj2lwyrE/nhGV6J7klpuwMLQ9MvtwodVNBG8AFPHF+XLcvh/w1LSVwzCNC1pX3U5X3l7MV1/qzD4zkOG0Z9yLLJV5wMTzICtaH0ARaJcLVheGnKWa3w22E7exLwt/OyrK5guc3LbabHHy1zTnb1iTeeUhJfekOalp91ttddtNUoY45CqSbd5q+yHoFPpdFZ0dKGVLI4CmF8rABU+/RiPRN6volMYaMI4O4MWyeVbKEJsydDHycQ7rUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZR+ZHO4m/LDTLaG7Kb4PO9o0/sKlET9WNSIKZH3/cc=;
 b=p400HpAsSVo/U5lUrVejeZua3bkQIRleTLy+UzUtvW+hLOecGEdwZaUcyVpEmvWxd0uObXc7etdU4RxaSX+PZxd3v6C2l11EWfbRYlYs7mrT9NCqBIBSJl72Q0NlxPRasYeCWnSzCeeD2wGspkJ5uV0zcbva2DMvMwB15UDftcz54NwzpRfYDYb6F12PKTcdqirhTfppliKVbe0S3C5zpoS2o+DnIM2djUmIw0lrgG5fNgwTM7RE4bEDCKw0qvV/nvY55Mb2XsmdS/SiCXMQV3HpTnYkfyZTO6kw8vCEb8E1RikEjBTBU/ITuSe2OUUWnSdtBgWhZs0NvD/WTWywfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by LV8PR11MB8746.namprd11.prod.outlook.com (2603:10b6:408:202::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 03:31:42 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 03:31:42 +0000
Message-ID: <601e5516-3ad9-45d7-90ae-635aac14e371@intel.com>
Date: Tue, 17 Sep 2024 11:31:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/20] cxl: indicate probe deferral
To: Alejandro Lucero Palau <alucerop@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-11-alejandro.lucero-palau@amd.com>
 <920a9258-650a-454d-b45d-673b7cfa1e56@intel.com>
 <cfffaf6e-3044-a389-f4e5-6fbd50ecbdd7@amd.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <cfffaf6e-3044-a389-f4e5-6fbd50ecbdd7@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|LV8PR11MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 617c09db-d6fc-4920-dc16-08dcd6c93f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1V1R3FQUDJwQWlYb2pCYXhGQ3lqOFNZZjBod0FISllHOGh6OUl2OHBzOHAz?=
 =?utf-8?B?amUwWGhHd0srRGdaL2RUaXJrVDlGdVJQakZCNit6K2NtaHhubE1WSlZjM3Ur?=
 =?utf-8?B?c1dpSXlNV0t2NWE2NXB6akEyUWY2TFYwRE9KRmk5dnpqd3hlSmpkSUNmakN0?=
 =?utf-8?B?cllrQUtSbFpwUW9Rc0J6V0VtY2Q5eUQ1WU5CQTNMYy9lQVg3ZTJneUlqYjFj?=
 =?utf-8?B?Zm5vWHFadUZLL0hGZUJRN2RpZ0NmWFZkbGtVa2hjV3ZUOHpwekVidFBHTHVQ?=
 =?utf-8?B?OTZkT0RaaVZtd0FlN3R4RXpHVFgzRy8xbnV3dWpkSHhibFR1VENuc1NzeHVY?=
 =?utf-8?B?dXRXSzg0dzI2aTdrbUpjdVdINklhL1lWMjE0L1N5RERWYStRU3I2L3NaM09a?=
 =?utf-8?B?eWNOaHE5UkJGdWV3blY2TEg5V1RlRXVPQ0JCK084V1ZsNDNYWm9PM2dvVWJh?=
 =?utf-8?B?T2R1TFY2T3lZRkpUTXduak9EVmtWZG1wQUVub21EREtHYVFVV1lkclVoYUR4?=
 =?utf-8?B?VDFCMzR5eXlXZXRORzF0VVV0ZWZ5aVVWR3oxTVVIQ0c4a05Zc2FGM3h1UDA4?=
 =?utf-8?B?NFdhcUNVemRqcW8rM1hUOERjajcrRE1ubTg0a2QrUTh1MjJwVTVwVkRtN0xG?=
 =?utf-8?B?OHlZNnBvR1VDODM0MWNXcmhDeGEyLzExSjA3S0FJUFNodUlocUExZjdyQVVX?=
 =?utf-8?B?TDRSYTZmekxtVlBnUy9LaUZKNEx6WFRWRjNPeVVWWUYzM2pNM3FneEhXVFJi?=
 =?utf-8?B?T2RkZkNpKy9iZWZnU2J4VTRDa2NLQmplZjFER3dJN1dKbnd6TEhORjRPbk9Q?=
 =?utf-8?B?bUV6QXduWmM0VWd5elZYZklocVdDM0wxcERpV2lTTU9CenliR0RiMVRKY0xl?=
 =?utf-8?B?dWdOS3k2MXlYa01peEE0ZnU4bHVrWUNIWGt1cE5JcEhXWWlyVER3aFhkMmYy?=
 =?utf-8?B?ZU9mNHVkTE42TXIycTcxcW5lMTFtSWF0Sm94d2xZS2NpVFV2RlpEKzhlTHpr?=
 =?utf-8?B?R3p3ZFViNjdnUEhLUUJnU2JGMXlzUEVvV25ocCs1MEl2cWREY2p1MHN6UFhp?=
 =?utf-8?B?QUNsb3lVeGJOUERLRCt3V3o5LzErMWdFYnQ2bDFzVUFlbFljNm5qSDRoZFZH?=
 =?utf-8?B?ZWVHdy9EdTF0bjdlUzAxYjdBdllHUnJnU0VFL1RJU2QrRThUbjllSng2aC9r?=
 =?utf-8?B?ZkN5Wkw1SGRodzhNVFlOL2lTcG1peW0wQVUzUDdQL0JnRlQ3aXVINDdWK3Rq?=
 =?utf-8?B?bUpLa0dzZzhyN3hiT3J6WFMxVnh2OEdTU3RUVHhVSFl3STMySGdnR1U1WHRZ?=
 =?utf-8?B?U1hXdnIzdE5iU1F0bitvZE1DR2YwZytIMFdydGppQVp4VlZXRnFlWXkzaFN0?=
 =?utf-8?B?aHJmNUpia2VUREhQZCthV3EwbUdnWFZZNHRjM0hIeWNPUTdZQnl2Y2N6dEFQ?=
 =?utf-8?B?N1NSODdIL0cybGVMN3JLRFlpcmFpc3ZReUM2M2E4eVpaajNTL1dHUVVENE83?=
 =?utf-8?B?V2tsUDA1bnVOQlFGMW9rcUJXY0lmdFdTMjArYWs5ZVpyazBwYVNEUHVtNG5Q?=
 =?utf-8?B?bzZRVVhFcHU4dGhWSjFmQ1YxTVd1VXVKeW5uWVRja20zbThMMGhXdVd0N1F3?=
 =?utf-8?B?TEwzUUZXWElSdGZBNVRsSEQwaW5lbmtmOXgvc1F6dk5pOUhXYlUxdm9UWE0z?=
 =?utf-8?B?cUVvNlF5L1NRaENHUm1BbG9DYno1dllJaEZMZ0VKYTJ0a1Q5QTB3QXhYVWY5?=
 =?utf-8?B?SWNWUWthWGNjeWppakZjNnZ1TDBWcW9rM1dtaDkyRVVkT0FQajFGS2ZRbmgr?=
 =?utf-8?B?V2VJSDhuYjVRSVZNcGxScmVaT0dCQjllRGhvdXF2UmxYYVJBQkhueTJPZFBu?=
 =?utf-8?B?Q1QvSjdoUDllUTVBODZsUzMySklGN1k2Y1FUZXE5bE9NQ2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEUvOXNPdzhKSjY0RlNUS2JrSVBCNXJ0SUEyWHRnYllpU2ZuQUg1ODg1TzAx?=
 =?utf-8?B?Qy9IMmFWZENnMFhlN21KYjQ3UWlEQUgvMTZqUmQxcjltZXhyVHpMMVNiNEJx?=
 =?utf-8?B?bFQvazBhWUdIamNJdmhRTnhpSjVJcTlFNkpHMFE5ZlBCV050Ym5tcGh4M0po?=
 =?utf-8?B?WjBwckxqS1Q1UXFxRGZ5TStkZVBweWhjZmprNWVxSVRoYzFmZW9ocjVLaUdV?=
 =?utf-8?B?S0lBeWdEdlRheE1RaHZ4dmlYdGoyMXFlcU5uUDRuSDg2SjhwVmRtdlI0bWFX?=
 =?utf-8?B?Y3lEUVRQeE1WRVJVSWhOV0t4TjhGeFo4Ni9wVmF4SDdRTW5sV2l1anU1QXN6?=
 =?utf-8?B?cEtNb3JYemMxZkJsRVFuamtnakEwOVRBbk5oTnd5S1hOSkhLQjJUYmhpbmtN?=
 =?utf-8?B?MUczWWsyZERtUkVZUThIazNUZHc3QjdqbUlrenMxTmZsMk9JRFg2eVNiTG1O?=
 =?utf-8?B?bWcrbDZ3U2k0bzdyZWI2WHQyRktzd21hSittQnUrdDNoNHFZSGJEMVJGS3Vk?=
 =?utf-8?B?T2FMRlE2Uk9jQm4xUWx0SHRnWStvTEdUR0VQeFhhRUtRSWc1aFRseElrUGRL?=
 =?utf-8?B?YjdqQlVtQ25aUlhSRUkzZm5INEhmRkRmVkQ1alFrMmpkL290TzZjbnBmUHkv?=
 =?utf-8?B?NVBhQmEvaDg3eEdvWlZEc3pmK0plWU0rWSs3dktQcGswS1lBczU3T0VXU1Nl?=
 =?utf-8?B?UkhUMXZhTWM5SkM2R1dSbnhkYWY1R25lZEwxQ1JUelQvbkZ2WDBnOHFQaWdy?=
 =?utf-8?B?VHRkQVpVTkNCWUlya01MUTJDTldaREJKS0ZreWkvbFhGM2RsbkpXTHhrelJE?=
 =?utf-8?B?VmRaTFh6K05FV1k5Z25DYjh4NFRkdVNMSHRlQXl0SG9QYU1hbUo2clBlMUNx?=
 =?utf-8?B?R2xNZklSdkQ3YzR2Y0VsUXR0Z2NyUU5tTXFPQ1pwNVptSHdNdll5Q3NCMmFv?=
 =?utf-8?B?ZXovYTV4YkN2bkd0anNRT0N3bmdQL09UYzV1S0loWXF2Mld3SWsrMEdqeERp?=
 =?utf-8?B?Y1ZkQlIwU24rNjBGdGR6ZFN3TFVTclBjUmc2UzRQUFV0R25lcWRBaUtRa3Vy?=
 =?utf-8?B?M0ZBa3FyODFNRGIxOGc4NmowSWRNNENxU1VBYTFyb09RdW5uc0tHT3czT0xh?=
 =?utf-8?B?eXl5TGlobHFORFQvV2ZaY2V4a3VhYTNSUmY0dXZQcTdEZUY1S1FiQlBZbnRt?=
 =?utf-8?B?dFRtbnJtVURsemMxZVR0VE42UFRmWHd4WTAzVy9PbEJWeWczZktoZkNvelRh?=
 =?utf-8?B?RFpGeUN6c1FsYVo0cVdyYU5rR0QzSGdrcVp4WktjUkk3T2NSdG55UmVwdERi?=
 =?utf-8?B?VW5sai9sNHJsMHBiVk4yMWpIOHIwYytzb0FqVjdCWUVJOXRYeGpBYmVVNDB3?=
 =?utf-8?B?V0JkTGs3TTBNQ2FHemJvOXBmcWtwV3lRUVRuTnlwV0c0TlhlYUVlVzl3MXMv?=
 =?utf-8?B?cUZsa3E3VTFldEhSQU1RZGE1UjFEbmlmVmt6QXRSTkxFNk1HcnFheXNVdzZh?=
 =?utf-8?B?ckNQaE1SazgzWHJ3d3FRVTNwbEhTYUtMTVFNa1FxbisxQTZhbHlCbU11eXZ1?=
 =?utf-8?B?VXhrd1VqR0c0WmgxWnRLVEZqQkZJTnRtNDZFc1RBcjdGdmZTbXlvUEVKVEtC?=
 =?utf-8?B?K1h4TDRsRnlxYm5VTk5VTVp4cUJndjU4dFA0SUhOSk1yVTYwNDN3ZXJtVm54?=
 =?utf-8?B?dXY1bUJhYldBdUhyUFEyNGZ0T0RvdldxUStTcnI4eUUxaC8rZ2I2NXhWVFIv?=
 =?utf-8?B?TXlja1JTelNXU0JDRU1nQ1AyaFg1clc3YWEwbWNHN21uelNiN2lweTBWT1dt?=
 =?utf-8?B?RldrenVQRnNSV1VtQWtvK042ZHYzVUhPMlhzd0xzVk1DTVl4enR1c2dzaEJQ?=
 =?utf-8?B?YVlxODdVaDZjU0pSSlZrQW5LY0JUWXVseFR1Y2o4S1luY1lJQ2t3T25kYnlt?=
 =?utf-8?B?QkJQdXNWb2xmYnFiWUtQSXRrdDB6TEo2OS9RbWFxUXNraUlZdkxBNTg4cmVU?=
 =?utf-8?B?OGdEY1FpSVJZM2NMbU81NVVKWWN1MERIZHRqd0QyS0QraklYL3pVcjBlazlz?=
 =?utf-8?B?cW8xSC94UGIxUDRKWGZUNkdYaXZ6Q1pHQ29LcWM5L1hWcVJOQjNuU0ZyQWl3?=
 =?utf-8?Q?RRjUZvCYQn4Ar+sH4mbic5uhF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 617c09db-d6fc-4920-dc16-08dcd6c93f66
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 03:31:42.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/9z+2tqcH0SQlx5df2EKcbAVctanZUO0nPEzccp0puzeBxoRmKcp2u47ZM86yGYckeffhPSK6vJTC76gZl85Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8746
X-OriginatorOrg: intel.com

On 9/16/2024 4:24 PM, Alejandro Lucero Palau wrote:
>
> On 9/10/24 07:37, Li, Ming4 wrote:
>> On 9/7/2024 4:18 PM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> The first stop for a CXL accelerator driver that wants to establish new
>>> CXL.mem regions is to register a 'struct cxl_memdev. That kicks off
>>> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
>>> topology up to the root.
>>>
>>> If the root driver has not attached yet the expectation is that the
>>> driver waits until that link is established. The common cxl_pci_driver
>>> has reason to keep the 'struct cxl_memdev' device attached to the bus
>>> until the root driver attaches. An accelerator may want to instead defer
>>> probing until CXL resources can be acquired.
>>>
>>> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
>>> accelerator driver probing should be deferred vs failed. Provide that
>>> indication via a new cxl_acquire_endpoint() API that can retrieve the
>>> probe status of the memdev.
>>>
>>> Based on https://lore.kernel.org/linux-cxl/168592155270.1948938.11536845108449547920.stgit@dwillia2-xfh.jf.intel.com/
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>   drivers/cxl/core/memdev.c | 67 +++++++++++++++++++++++++++++++++++++++
>>>   drivers/cxl/core/port.c   |  2 +-
>>>   drivers/cxl/mem.c         |  4 ++-
>>>   include/linux/cxl/cxl.h   |  2 ++
>>>   4 files changed, 73 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index 5f8418620b70..d4406cf3ed32 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>> @@ -5,6 +5,7 @@
>>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>>   #include <linux/firmware.h>
>>>   #include <linux/device.h>
>>> +#include <linux/delay.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/idr.h>
>>>   #include <linux/pci.h>
>>> @@ -23,6 +24,8 @@ static DECLARE_RWSEM(cxl_memdev_rwsem);
>>>   static int cxl_mem_major;
>>>   static DEFINE_IDA(cxl_memdev_ida);
>>>   +static unsigned short endpoint_ready_timeout = HZ;
>>> +
>>>   static void cxl_memdev_release(struct device *dev)
>>>   {
>>>       struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>> @@ -1163,6 +1166,70 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>>>   +/*
>>> + * Try to get a locked reference on a memdev's CXL port topology
>>> + * connection. Be careful to observe when cxl_mem_probe() has deposited
>>> + * a probe deferral awaiting the arrival of the CXL root driver.
>>> + */
>>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
>>> +{
>>> +    struct cxl_port *endpoint;
>>> +    unsigned long timeout;
>>> +    int rc = -ENXIO;
>>> +
>>> +    /*
>>> +     * A memdev creation triggers ports creation through the kernel
>>> +     * device object model. An endpoint port could not be created yet
>>> +     * but coming. Wait here for a gentle space of time for ensuring
>>> +     * and endpoint port not there is due to some error and not because
>>> +     * the race described.
>>> +     *
>>> +     * Note this is a similar case this function is implemented for, but
>>> +     * instead of the race with the root port, this is against its own
>>> +     * endpoint port.
>>> +     */
>>> +    timeout = jiffies + endpoint_ready_timeout;
>>> +    do {
>>> +        device_lock(&cxlmd->dev);
>>> +        endpoint = cxlmd->endpoint;
>>> +        if (endpoint)
>>> +            break;
>>> +        device_unlock(&cxlmd->dev);
>>> +        if (msleep_interruptible(100)) {
>>> +            device_lock(&cxlmd->dev);
>>> +            break;
>> Can exit directly. not need to hold the lock of cxlmd->dev then break.
>
>
> Not sure if it is safe to do device_unlock twice, but even if so, it looks better to my eyes to get the lock or if not to add another error path.
>
why device_unlock will be called twice? directly return the value of rc like below if the sleep is interrupted.

    if (msleep_interruptible(100))

            return ERR_PTR(rc);


>
>
>>
>>> +        }
>>> +    } while (!time_after(jiffies, timeout));

Another issue I noticed is that above loop will not hold the device lock if timeout happened(without msleep interrupted), but below "goto err" will call device_unlock() for the device.

I think below 'if (!endpoint)' can also return the value of rc. Combine above changes, I think the code should be:

    do {

        ......

        if (msleep_interruptible(100))

                break;

    } while (!time_after(jiffies, timeout));

    if (!endpoint)

                return ERR_PTR(rc);


Does it make more sense?


>>> +
>>> +    if (!endpoint)
>>> +        goto err;
>>> +
>>> +    if (IS_ERR(endpoint)) {
>>> +        rc = PTR_ERR(endpoint);
>>> +        goto err;
>>> +    }
>>> +
>>> +    device_lock(&endpoint->dev);
>>> +    if (!endpoint->dev.driver)
>>> +        goto err_endpoint;
>>> +
>>> +    return endpoint;
>>> +
>>> +err_endpoint:
>>> +    device_unlock(&endpoint->dev);
>>> +err:
>>> +    device_unlock(&cxlmd->dev);
>>> +    return ERR_PTR(rc);
>>> +}
>>> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
>>> +
>>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>>> +{
>>> +    device_unlock(&endpoint->dev);
>>> +    device_unlock(&cxlmd->dev);
>>> +}
>>> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
>>> +
>>>   static void sanitize_teardown_notifier(void *data)
>>>   {
>>>       struct cxl_memdev_state *mds = data;
>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>> index 39b20ddd0296..ca2c993faa9c 100644
>>> --- a/drivers/cxl/core/port.c
>>> +++ b/drivers/cxl/core/port.c
>>> @@ -1554,7 +1554,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>>            */
>>>           dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>>>               dev_name(dport_dev));
>>> -        return -ENXIO;
>>> +        return -EPROBE_DEFER;
>>>       }
>>>         parent_port = find_cxl_port(dparent, &parent_dport);
>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>> index 5c7ad230bccb..56fd7a100c2f 100644
>>> --- a/drivers/cxl/mem.c
>>> +++ b/drivers/cxl/mem.c
>>> @@ -145,8 +145,10 @@ static int cxl_mem_probe(struct device *dev)
>>>           return rc;
>>>         rc = devm_cxl_enumerate_ports(cxlmd);
>>> -    if (rc)
>>> +    if (rc) {
>>> +        cxlmd->endpoint = ERR_PTR(rc);
>>>           return rc;
>>> +    }
>>>         parent_port = cxl_mem_find_port(cxlmd, &dport);
>>>       if (!parent_port) {
>>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>>> index fc0859f841dc..7e4580fb8659 100644
>>> --- a/include/linux/cxl/cxl.h
>>> +++ b/include/linux/cxl/cxl.h
>>> @@ -57,4 +57,6 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>>   void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>>>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>>                          struct cxl_dev_state *cxlds);
>>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
>>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>>>   #endif
>>


