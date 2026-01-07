Return-Path: <netdev+bounces-247848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E77B9CFF35A
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F6063000B5C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA111333439;
	Wed,  7 Jan 2026 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNSIrNwu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06BE32ED20;
	Wed,  7 Jan 2026 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807704; cv=fail; b=NaXz6ge6R2A/W4sgDIEF8oMki9bSZfnEDtFjXJz3op9/1GkVgPm/x7v9AMqzxMLayHwsbPr9cF/YISMcstg6/itzBP5o4kL8vrBnVjnoxTA3hMGA7xOiFAUr6TzfmzbcRG57aF3m9EHEWNyaHouCgG39US+8dTBTEQWh2puKD+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807704; c=relaxed/simple;
	bh=ogyz7WiSNX7HajCY/HeyNdwYR09IBmxaBChHdNZFQQw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T86vyjVTY+LaacckgmY8R1cGSIp4j0Ept/uY5qQv5KAbyU3Wqv08IC/I6OxxKKBgRLrCCYc/u4NduU6qwThDK2jNiXXiiLvWc7b4JOlbDj8SrWtB/qeKJvBi/83wU/IzpCgNyVYLaQX9O/FpTMv9xe0gm6XbNEL6lSLj4bEymu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNSIrNwu; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767807700; x=1799343700;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ogyz7WiSNX7HajCY/HeyNdwYR09IBmxaBChHdNZFQQw=;
  b=XNSIrNwuVhRcPZ2x0o20xzr/MKueaU6YVC3RQUM0inlAumnVlRsI2maC
   KExW5mYuj464w+lUQzEONgn4EA0UPnx8n1+EVEx853LsFR8gncRQh5KP7
   w67/QIeEjmaNMvP9HrJWA1C3GotHEqg27Uio9qJ+OABevLXEh1G6irUfE
   dU3G+7jp/geXGu0txKtoUyV5Syd3S0BOXhzInGvW2XMCfJtM9n0UkhSAN
   mQvtS/x/TSP56VQN1dx51SOGOLRszpP0Hco07CttaYkcbnTSfsJUnFloE
   tS9Wgq9oLEI0H2vjPnfgVWx/5jNSOVS4Tv1ULO1IB6yTIRtfaaYSTecG/
   w==;
X-CSE-ConnectionGUID: 9t3cGk9RRU2r/htC5CaqzA==
X-CSE-MsgGUID: nWhtOJStQQqXKM8ueNa7AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86599720"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="86599720"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 09:41:35 -0800
X-CSE-ConnectionGUID: FjNEIdZZS+eBewT4VOI7Yw==
X-CSE-MsgGUID: FLxPrUvvS6mR8MFIMKqY2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="202107787"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 09:41:36 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 09:41:35 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 09:41:35 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 09:41:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM4qSAq17nXw5WyLai8MZE2grpvpABC4M1tJrV9M/5sKW+/swFMCRNNAFhEtR4XscWcKExKt4E1KgyE9DsNkRxuUonxXO3FqXVU6kGQCdw180BXNk0J3d8vEqPlkNHp1xnk5hFru+CBMj0Vw9tbOQw0IRLIysZx2spTGajL7LxLLT8T2PqszaYEt6BzUSScHdU8lJExmwli/SWUgU+74wT3MmHZwJ8LjlQ7LFt4P2QbAskVqxjFIiCYh7yzFbijHaM0QeqIy6wElw6cET+ueVAbtXGtpwXkFt5/c3vs+Smp30JzWZ8WQaQIt0v7OBNZhlGM7N4j8fD0M7wyrkO7LEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFG6c57FHajR4Vw3LNlEQbm+xALeYyQDRnYuabkPD7s=;
 b=XWH/FWVUQLpMvDWBPD61hmFsLW3cg6EWkU2L6BJ6fQlvWwU6LGmBWNAQcK1yEO27Txldkxr11MVqIBz27DQ+qn/k7T46rPvPMMsS6Ggy4aR2Ey+vm3aQXzVu+eOL8RalNFcHgu5cZZrqF8ajIJVc0/2k6my0R3LjqRNyY6N9ew5j4wUJ07BXGKq7atjq+nZFF5tpuO2OUnJYVoiK+/ToYa9Y+RBX5YhjFf+RrLWds4Z4SCkNg5bLipU/k0/qk/ZJSULzA9oRy9M/8m4yISxJKerhitSuEwEA6o2l4P+yLRZ7NtCt66oe4Fty57/VGGgtcRflL8K7bZqr2uT++L9sSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4538.namprd11.prod.outlook.com (2603:10b6:303:57::12)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:41:28 +0000
Received: from MW3PR11MB4538.namprd11.prod.outlook.com
 ([fe80::f956:64f0:b829:1166]) by MW3PR11MB4538.namprd11.prod.outlook.com
 ([fe80::f956:64f0:b829:1166%3]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 17:41:27 +0000
Message-ID: <9cee39b6-edf5-4db2-8f0c-4550fa84b5b7@intel.com>
Date: Wed, 7 Jan 2026 09:41:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 1/5] idpf: skip getting/setting ring
 params if vport is NULL during HW reset
To: Li Li <boolli@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Decotigny
	<decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, "Sridhar
 Samudrala" <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>
References: <20260107010503.2242163-1-boolli@google.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20260107010503.2242163-1-boolli@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:303:8c::19) To MW3PR11MB4538.namprd11.prod.outlook.com
 (2603:10b6:303:57::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4538:EE_|MW3PR11MB4683:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6d3f26-60a6-4948-6ed2-08de4e13fc4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enFzRkxLYzJSdDB0cS9lQ2FqRDhiVFc1UzQ1NjhlbDVuakFEN1l0TnhqZGFj?=
 =?utf-8?B?MCtXeXFoS04vWEV4R1AwVWVuOHFrbDRWZVIyZmp0K2p0T3BKMHNkdVNlZDFa?=
 =?utf-8?B?cnN0US9XUVBXaDlRWW5oelZGbkJQcFYvcDIrclV1WXhZdHY4NytsSnl6WGkx?=
 =?utf-8?B?bVlva1NDbWRyZkovb0pzL3pSTWhLMElQWU1DenBFZ2l1T1ZNL3UrejQrR0hz?=
 =?utf-8?B?M0ZOcUJxUjJVUDFSenkxd2pTOFZDWnZTWlZmNHFzK2x3RXB4enNkT3ZyYmxP?=
 =?utf-8?B?MGhSQXB3NTlZeVpybEVUb0hsbVZPZWZIWVBUS1pMS0dqcXpwemRUd1JLU1lp?=
 =?utf-8?B?bTJWWFdKc1BSVFBZOFpTYk1EM3RrUkxOWDdjL1g0SGZOVkl6MFJOZC8rSUth?=
 =?utf-8?B?M20yWjVnV2tGSWd1eHhtQi8xcXFsUmxGeGQrTjI3OWYzbys2RHBRT0o4dHVR?=
 =?utf-8?B?UWNCdDFRRnFKUzY4dlRpR0VTUzhpYktRRDNyWFdJQVJCNTlZMEJMOHE0WnBj?=
 =?utf-8?B?aFZZZUwzVkhidU1jWE1DU3dMOFZlM1ZCOEpTV1Q2cmdMY296bUpnbnAvN3Yz?=
 =?utf-8?B?OFFabVV0TXZMZ0FWMU01SmErcHB0THB6empQVGVCMGxIVEVydnhGY3o0bmF0?=
 =?utf-8?B?N2w3a0MxWjJTZXBKdnJkMkdOYTc5TEVKT3ZHOUJQTFc5RHRvcWdYMnN2ODhD?=
 =?utf-8?B?WlRoaEFMU2NyRHpnYzhWWk1lQUNWaUwyZ29PbXp3MWp4SlJCZlpHUzZmQ29x?=
 =?utf-8?B?QzRBd0k0ek05cFRCNnJoQzJjVmNwbnZnZU9Ec29Ma3pXbXUxOCthS3FMcWJB?=
 =?utf-8?B?K0grdnhXNmdlNlRpV0sxTUFEOVdUNmE5R0pSRy8rSTRTSlEybk01K3BzMjhk?=
 =?utf-8?B?TEd2WEZmWDFRU0ZMSVFuNUJPMGV3UGs5V3JuM0FaVTRzZ2hjY2hiOEkwcUgv?=
 =?utf-8?B?Tlc5L29qSmVIa3dmOXlVdzExQWRHQlhBSnJRcXdtR0F5T3N2b0ZGd0xwd3cv?=
 =?utf-8?B?TGtpSHc1SjBHSURick1PQjNtUmx4SmovK3puZ1RyMmZSaVMzQTVEUEFHT0ly?=
 =?utf-8?B?aFlkS1B3NkNjWHVrOFhtUkZzeXJPRnZaUzNhekM1ZVM2QzdqMFB0YjdwZ005?=
 =?utf-8?B?VW5LZjZVRThabFhtem5MM29FeXZYQXlMMm5aRmJsdjh4RGtnWkZ0cllmbk1x?=
 =?utf-8?B?cllnb1kxZUxYUW5aM1NLSjE0ditlWkNUZERldjdDUGgyUjR2ZFgreUdDM0RM?=
 =?utf-8?B?em9NWnVqMDBUYlJEdWg3cVZxcm1RWFp6L0lwZG96QzRtSmpVakV2bHhpbGx1?=
 =?utf-8?B?Wk9mcE9JZlA4V0M0M2NHdUJpSm43T1lhd0VET21GWlczVU1ha1JUb3RMVlNZ?=
 =?utf-8?B?RXF5OFRQcml0dWFlNUJORUtORnNOM2FyOGhudlJtNUVLK2VSTzIzMHE1bnNC?=
 =?utf-8?B?V1JsN1VCV3ZZSnVLTUNFWlF2MVM2UVNVZ0NwL2pFMjQySmF0bkxJc2pISzdw?=
 =?utf-8?B?UG9sZHQ2NWJUSVI0VGxUOE52bjZNa2ZtTkptUm5FZEFLL0J0eXo3Rk5ET3Ri?=
 =?utf-8?B?bGd3Y1lHQ2FET3NtYnVhK0FsQXR4ay85YlpSVnRnVWVZQnRYZDgvVkNpZUdk?=
 =?utf-8?B?WE5PZFVwbmpKazVZSmdPU3lBRmh4Z2FlcFJkZ3RIWmozU3lNTjdXazdhVUo3?=
 =?utf-8?B?b01JaFp1Sm1GWDZLUkUwVCtTVHJ6ek5aUExmYndWOHFxNml0MEpvUHNrYnlC?=
 =?utf-8?B?ZGdkOXgvd0hBUnRwckN1ZU1mcnpzeDRsVnlkaFhwMHFhVWFoZnhKV3liRWdx?=
 =?utf-8?B?bkt0dmt4c25CTmVuVWFKMzkzcnFuMVZJcmE4SWJMcytZUnJ0dUE2L1BXU09M?=
 =?utf-8?B?c003clFwcHlVRzN0MExIQ2lhZnBlSzV6WDdMZGlsNFZGdEFRWkRiYVJUcEVK?=
 =?utf-8?B?cjZHTWl5eHJqZWFtWEZuWHlYWUx2VWpqdm9UQzhWZFdOZTNvT3BmNytwSHBC?=
 =?utf-8?B?ZkZjL3I4L29RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4538.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?citOc2hpL3RxQlFBS3lTWHovQWFWOHMxdUVkWWowSlo2R01yWHRqcmhwbWVp?=
 =?utf-8?B?YnlPWDFZMWJMV21xQzhTdHNVZ2FCdVQrN2hhRWpZd1JySWljSzlKcVRwV01q?=
 =?utf-8?B?S0NvbGpBOE8zdUhqQ0VSd2xITE5aNmpxVHV6TzhzNVRsOU5rT0t4b2xmS3Vp?=
 =?utf-8?B?YXVBOHFDZ0JXN0VKaVpXYm9uUU1hOTk5b25scTIxclk2OTMxNjJUK3BOODMv?=
 =?utf-8?B?T1kyZDllVlVGRmNJY1k0eUtMS1h5OEdIbm1qbTkvU1ZuaGV0OWNzTHNURUFR?=
 =?utf-8?B?ZUNacTVWeUhOV0IrNzVsNzVZdFpueTVFMEZRSzM2YUdFWUtkNm5Kb2xTYnZn?=
 =?utf-8?B?UnBqZ0Vsd3J6SGRJRWdzejhMUDRSb2NzeCtSZjNycTEyU1J5WGxLc0lUSTNP?=
 =?utf-8?B?a242UWNMVk1ZS2RtQkRxdTZhbXhTYkFyeWpyWGZYRmIxbU1iVzVlV2xNaGtM?=
 =?utf-8?B?UVE2VnVVZTFqMFdpd3IvcVJxM2ErWGRuV2IxYXVyZ3ozbU9EOG4rNWdoaE50?=
 =?utf-8?B?NnBVQWNOZDFEa3l3VXYrempCaVhIOUxWMHpzeDI2dTB2YS9rdkxJQlY3N0d2?=
 =?utf-8?B?Y1Radk5YVGxaZzJ6bWdTbFVmdU84TnRSMGE1bTZHV1B2NVFaekFGbDhSSFVY?=
 =?utf-8?B?Z2JJTmtFcUZTM3U5Rm9YUjJDeS9OQU0wbUhaYXV2cnNYU054QXNTV0d1aGg5?=
 =?utf-8?B?Z0RqeXN1NkRkb1Q4ZmJRaWp2dmUxN1dYNldZSkpYdWxIVTlrTWVLWjZzUExF?=
 =?utf-8?B?UlBuZ0NVMzJ6OS9nZVNqUlp1VTk1eENLMEJLUjlzb1B3bUpRMFc0QVZGNkw0?=
 =?utf-8?B?WkhOcFI4elhQVHRHcTl5cXBjMEZIUjhmNkM3LzN3c3JML2ZJSjRwWllMZUw3?=
 =?utf-8?B?VGN1OHZmbElPSVdOMVZ0c3B3bmRaQzBuRGJ1QVVCbWlOYkJFcGMzMUpqcWlC?=
 =?utf-8?B?bVhUNUFzS0FZb3ZOM2Q5OTkrSzdoM2FuZVJqSG95M1hRM2RiUGFheGt3QXFK?=
 =?utf-8?B?bHI2eUZvMHBRY1M4MmVHSWZ3WlZJbEFVOFplaW42RWNaV1FxeDhZVTBlNDV0?=
 =?utf-8?B?emlPYlZIYm5FK21kaGdEeEw1dkRYTXFMcHIySnVBV2djMVMwTG9YUXpTcjV6?=
 =?utf-8?B?WElJUzhVNVRKamhERTFXTmdpZTJub0FUQVJrVXpDU2JqMjBZUm9hSTFJQzFz?=
 =?utf-8?B?VFNRcWhkVi9pY0VZR0d2U2ZHeDJJS05ud1orT0VPaFNZQS8wMml4RVh6ells?=
 =?utf-8?B?cmN2WFlsZU55UlNPU1Y3UEpuRHJ1ZU5iYmh2ZVVoMFNlYVY0NHhjMG80MUpS?=
 =?utf-8?B?MTZSa3JXMEdYYXQ2RHcrUlVaN3JZNmlFQzFRSkVQNGUyejQ4Q0NrQkc5ZjI2?=
 =?utf-8?B?NzFlVEY0L0RiMktkNTZMRlVCWHJvNjdNbDltZk5PSlVGV2tVbE9HYTdzamw1?=
 =?utf-8?B?QmVXejI5WE1GSnhuTzE4blpNQmlVNlNaYXFyNC9nMy84L2pieURHUlJpOTEy?=
 =?utf-8?B?aHJZdUIvcTczZXp3WnliU3NHWjlSMjZTUzZ5UzBCVU8yTnNvWGl4ck9sVHhj?=
 =?utf-8?B?bzR1RFBUY1FjeFJsS0pOaFQwWGdkRGU2dy9jWGp4L3pFZmpLWmZPSWszWElL?=
 =?utf-8?B?T2dqK0w0T0REMUZyWjAzd0FTSHByNTFtYlBwSDZueXgzSzhudzRka1pzWjFy?=
 =?utf-8?B?MzJlMW0vdXFDb29keXRxU0pxcXhVZXdtU09xUDE2MmFwMHkvWDJpd2VYdktP?=
 =?utf-8?B?d0pHYVFQTVJ6K1ZRM0lVTExRSHRUeFJyK1JuUzJlQzZiSXA4TUlhWFBpQzg2?=
 =?utf-8?B?TGVLbFRyazFFc1dXZGRWakxhQ1J2REpyNWFkMzlKUVdBckR5TEk2S3plOVp1?=
 =?utf-8?B?WVNZR3JLZmxqbmdxNTkyU1VEL1QxY0RQUlRocU13K0p2RDJ5Z2FxSXFPZlRl?=
 =?utf-8?B?S3hLUUdZMjQxOTFPZnNZclhhNENvOVFwM2RyNDh0ZCtsRzErcE9iZkxBUnNN?=
 =?utf-8?B?ZVJWVlJtcHFCMG1RVzZGR1BJbVZMZmtZQm9rZlVwUk0zeWE2REVXNlNibG5k?=
 =?utf-8?B?bEZxeHVyNENXdk80NC9EU0VSM3AyUlBlTXl2dDloUWtXWmNZTDAwVXZtSG9L?=
 =?utf-8?B?NFRhRGtuR3NzeFR3RVlMbTg0R3RmM2QreXAxZk1zVG9SU3JVeVJtMVY2VkU3?=
 =?utf-8?B?ZEVmbW9yQXp5NDNYbDduVGpRUVJiNG4vY1BXVy9PK2NXRW44RExpY05ETWxI?=
 =?utf-8?B?TDlzM3VHdC81bHZFUTluQ2lNNDUyaUxWMlZOT3RoMmJQUjFnVlRFUCthaVJU?=
 =?utf-8?B?YURXc1dva3Zjd2Y3SktBekJEY3Nsbmo5QWFJRWJDQ2h5dzlzTjBFVG5OQmdD?=
 =?utf-8?Q?liHSc6cx9ihQ5r5A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6d3f26-60a6-4948-6ed2-08de4e13fc4a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4538.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:41:27.8737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XptmPNgJzZrfOiyjgr6Sd+Qgc3a43rgnsRR9Qfp+m7faULpeDHzF1BCLPusPX9xCjLDKPpz/tvX6qU0r5TrBaAcEgu2iHlRK6japmNOf1P0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
X-OriginatorOrg: intel.com



On 1/6/2026 5:04 PM, Li Li via Intel-wired-lan wrote:
> When an idpf HW reset is triggered, it clears the vport but does
> not clear the netdev held by vport:
> 
>      // In idpf_vport_dealloc() called by idpf_init_hard_reset(),
>      // idpf_init_hard_reset() sets IDPF_HR_RESET_IN_PROG, so
>      // idpf_decfg_netdev() doesn't get called.
>      if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
>          idpf_decfg_netdev(vport);
>      // idpf_decfg_netdev() would clear netdev but it isn't called:
>      unregister_netdev(vport->netdev);
>      free_netdev(vport->netdev);
>      vport->netdev = NULL;
>      // Later in idpf_init_hard_reset(), the vport is cleared:
>      kfree(adapter->vports);
>      adapter->vports = NULL;
> 
> During an idpf HW reset, when "ethtool -g/-G" is called on the netdev,
> the vport associated with the netdev is NULL, and so a kernel panic
> would happen:
> 
> [  513.185327] BUG: kernel NULL pointer dereference, address: 0000000000000038
> ...
> [  513.232756] RIP: 0010:idpf_get_ringparam+0x45/0x80
> 
> This can be reproduced reliably by injecting a TX timeout to cause
> an idpf HW reset, and injecting a virtchnl error to cause the HW
> reset to fail and retry, while calling "ethtool -g/-G" on the netdev
> at the same time.

I have posted series that resolves these issues in the reset path by
reshuffling the flow a bit and adding netif_device_detach/attach to
make sure the netdevs are better protected in the middle of a reset:
https://lore.kernel.org/intel-wired-lan/20251121001218.4565-1-emil.s.tantilov@intel.com/

If you are still seeing issues with the above applied, let me know and I
can take a look.

> 
> With this patch applied, we see the following error but no kernel
> panics anymore:
> 
> [  476.323630] idpf 0000:05:00.0 eth1: failed to get ring params due to no vport in netdev
> 
> Signed-off-by: Li Li <boolli@google.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> index d5711be0b8e69..6a4b630b786c2 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> @@ -639,6 +638,10 @@ static void idpf_get_ringparam(struct net_device *netdev,
>   
>   	idpf_vport_ctrl_lock(netdev);
>   	vport = idpf_netdev_to_vport(netdev);
> +	if (!vport) {

We used to have these all over the place, but the code was changed to
rely on idpf_vport_ctrl_lock() for the protection of the vport state.
Still some issues remain with the error paths (hence the series above),
but in general we don't want to resort to vport NULL checks and rather
fix the reset flows to rely on cleaner logic and locks.

Thanks,
Emil

> +		netdev_err(netdev, "failed to get ring params due to no vport in netdev\n");
> +		goto unlock;
> +	}
>   
>   	ring->rx_max_pending = IDPF_MAX_RXQ_DESC;
>   	ring->tx_max_pending = IDPF_MAX_TXQ_DESC;
> @@ -647,6 +651,7 @@ static void idpf_get_ringparam(struct net_device *netdev,
>   
>   	kring->tcp_data_split = idpf_vport_get_hsplit(vport);
>   
> +unlock:
>   	idpf_vport_ctrl_unlock(netdev);
>   }
>   
> @@ -673,6 +674,11 @@ static int idpf_set_ringparam(struct net_device *netdev,
>   
>   	idpf_vport_ctrl_lock(netdev);
>   	vport = idpf_netdev_to_vport(netdev);
> +	if (!vport) {
> +		netdev_err(netdev, "ring params not changed due to no vport in netdev\n");
> +		err = -EFAULT;
> +		goto unlock_mutex;
> +	}
>   
>   	idx = vport->idx;
>   


