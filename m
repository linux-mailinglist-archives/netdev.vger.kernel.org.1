Return-Path: <netdev+bounces-123730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44769664EF
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628F01F23C5E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB61B2EC0;
	Fri, 30 Aug 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnxEC0hH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770761FCE;
	Fri, 30 Aug 2024 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030293; cv=fail; b=Sqpmeh1DMhviNGW3ib5y+Sltur4zeuhCAHpP+X2q1E0aRZxPXxo6cZ7DVAfnd2gHGbw84cWEESvuSCo5Xl40auTgnLMbFgbJV4n7ugeFOV4VPi4U4QWofZW4R4h9SPBp5Sd2Fr0z0a3+ccUNaZFrOAIhRUYB+v9p3R2Pt/P9GCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030293; c=relaxed/simple;
	bh=QJCOyV/EnbQILguUTj0zgC99zjAgEDbIJ1Qvv1ToMJM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VlYu0jnpWJ6rZ+9cd6vOpUq3DVs9Hn0vXJn6fnKQg0Iri1bzeF+2m0s8e0pWJG97BL9hQAyBgWEV7zGjpDSS64Y1GKBemwtigqrJdwYBOlWFCE8ffnvFDRQE0WipYKTKlT/0XYM9dAnowSuVhkQq4jC9EgKnMpT7qhJV2pu/FUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnxEC0hH; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725030293; x=1756566293;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QJCOyV/EnbQILguUTj0zgC99zjAgEDbIJ1Qvv1ToMJM=;
  b=dnxEC0hHjkN9dmeYy8EvPSpE+lL32NfWgx3HYRBEcPe6R6XBjMEx/r4p
   WzdoRnNH1hNgMaeV6DC+vL+KqZ2YLp9+775WChy+c+g1m32u++reYswUo
   1nE76H00MWtGhQkSNjlQcySHvn4hc23776P3X+iiPpJbnO7dSyB4XvFv8
   6VDGnt/epMqp+zcfABXDotUgBSu167tT4S/EpoIp3KCztrkTRyhZk4EmS
   WbXRYemqw27EhPLEJKyXa6vTaO5R3QxawFQzItl6mRAPpHvOFuR4c9elH
   ViiG9YXXa2vCTvHT0C8SobIZDa12UnthEQvOy+AJwgBezr6YLwoPyb/Yj
   g==;
X-CSE-ConnectionGUID: oinRtpTBQNiPc8SFJqbWyw==
X-CSE-MsgGUID: VSIi/dcvRKatAcSU3uDdmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="27553321"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="27553321"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 08:04:51 -0700
X-CSE-ConnectionGUID: tYtgg7JqSoq0taGl8H+8xQ==
X-CSE-MsgGUID: 2y5lnRR2R4u9xURL7SwXOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="68068808"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 08:04:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 08:04:50 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 08:04:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 08:04:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 08:04:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ih0OApl6bBEwrrlLAlOmJobo5rr8aJHp+fwi5MNhw7FRFy1d1aTgM6pyXsNeX5tBnkwNerzq2rhLuR63E7wN9LLW4yyROxe5+dvAtT3/4bLT5EfDr/UPZoyOHPb0r37uWcYuC1bMzF8XLgkTnKUZ2iTXpLAI9i+0A8p4BqNNV7oA4bHvZIVkOgBCf60aD+mAbwdhW1HTnPoMYvnaMv2cSAtaSm+d7OmJ7SsHPRHVjHTu5WJQ6CfDWTthUfITysx4IyPfCyfJmwKqXzBLsYJUyGCHOF/b+Jzl4GPmHwHkS9IolHj5gxql0fReGRfoQ5xQVCRsyQpfZNdEfGVjxYfvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDeBnbtEXNMZh0Ydu5QrtIXhasBqSWSd5REDEL9t+Ps=;
 b=KP20Ig98dlZHJymz65fIgX4fZETqivwqnEINRUYZtpS6vkFTvSnPbZjsrKvRwSLahKcoORJI2iIKPJG9t1U/ye08zvYH1fDPlbkeXSPjRLtTHjJ2To7sS4Q0mZB7LSdsTfw0TaM+jQcwFuZL16DYLLt+Lb17PVnP+3qJQNJ5kqcEwZ81DgNbGhbFcgZHsSc6ydAWNgcxnj87M+ZurWkPaxEMr86h1JQUIr6bjqPGD+5jmMS3wjxypsrIxbipeMkevoBJXKqklIdo3L35aC7ZlaHH9IgJfjU0/nhdRsBVfGJym831Jaip9bG2Bck1wMzTuvjIpxwGNmtkNa8jcRnjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB7950.namprd11.prod.outlook.com (2603:10b6:8:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 15:04:41 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 30 Aug 2024
 15:04:41 +0000
Message-ID: <c5896f81-5c32-43f0-8641-81fdb4710a4b@intel.com>
Date: Fri, 30 Aug 2024 17:04:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 07/12] net: vxlan: add skb drop reasons to
 vxlan_rcv()
To: Menglong Dong <menglong8.dong@gmail.com>
CC: <idosch@nvidia.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <dsahern@kernel.org>,
	<dongml2@chinatelecom.cn>, <amcohen@nvidia.com>, <gnault@redhat.com>,
	<bpoirier@nvidia.com>, <b.galvani@gmail.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-8-dongml2@chinatelecom.cn>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240830020001.79377-8-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0074.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc94c03-dae3-4eb1-7a57-08dcc905133f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0tpaVVsbWVCbHQxYVk3WStZMGFnZFdMZDJySHlucWxMREpKZ1BhOTgvSmhR?=
 =?utf-8?B?MmNCK1BjRE4rR3VEUzV2d3A2SGwzY08xWm9admtkK0NNN3JWUXdNTk55d3pk?=
 =?utf-8?B?NnRBR0NseW5ocDZNUE1VTG1hM05aMTQ0L3p3Wnh4MEM4cXhkQS90WkZaUkZ2?=
 =?utf-8?B?S2VrMlIyOHZsVHRUcGQ4RkhtMDZGd21JZ1BReDBMYVM4Z2crbURWZVVkTTJX?=
 =?utf-8?B?elpYdlpYNTRQdlRwSHpoVkRKNHY5M2J5OHhtS0p0VVQveGhzVk4zaWYzZE15?=
 =?utf-8?B?cXhPRGFlQ0I1enRCeWMzK2JBREdEN2w3cjAxRC95K2pCbzRkSWNiV0kwcEww?=
 =?utf-8?B?MnltUUZDVzFYaloyQVd0S2hhL25NYlBSbXZ5RkZCT3ZDL29tOEV6TzUxa0tN?=
 =?utf-8?B?RHZ5NWpaVUFSR3BVUHhYWnB4bm5KeG5ZTzc4QkVzdFdFc004d3plZVF5eWpo?=
 =?utf-8?B?R011VUh5bEllWFFMMkxicmZsZ0J0R2ZMRHJSZjV6eFI0cElwZkZ3K0xIL3RH?=
 =?utf-8?B?emk2Vm9aODhNUzFhMDRieHRQTy9iTmhYeXIrVmdyOHNvYTV2VDFuSW9FL2VZ?=
 =?utf-8?B?RDJuL1Ayb0NSWjd1MFVDM25IeWZzN09OTjBRdmhPQ2d2RWxjTWN6L25EeGgv?=
 =?utf-8?B?SjB3OEJFcWxrQmd3WUdOSU5uYTA1WUUxU2NmM3B5SUI2cnk4RitJOHlOK1VW?=
 =?utf-8?B?aktkMHpJT1NIMFZQZzhoOEdOVnU1RW5Bbyt3UUZpR1JNRXFLeFh5SXgxeG1U?=
 =?utf-8?B?cmk0YWNFT092YjFYVmR1TlQyNTNINkE3aE1HbzQ2amc5YXN0UG9sVEwya2pO?=
 =?utf-8?B?cDhqSTBIM0xXSHVhTWkwTURhRWllVjJMTmxMd3RxNnlFYlBVbU5TS2NSdFNT?=
 =?utf-8?B?VHN4VGtwYlY3d3A2MFN6K0pOamo2TS8xOEVJdkRYMDJTQUU0MHc5SmZoa1dD?=
 =?utf-8?B?UllmSEh5cEwzVTYxZTRacWlybzA4Mmc0eEJ0NnpzTEZwMU1sK2VTY0lnRTE3?=
 =?utf-8?B?MlJQYksrekxCS0RvTVpvRG5OZDVlTStudHVKVVBEeFVqbUZ3cGhaVjF3bnp0?=
 =?utf-8?B?V1F3Z1RiZER5M2tZOERUQnVpZjFPNjN5VlA3emQ0c2lXa1Z2TWlHTUtuaC9n?=
 =?utf-8?B?cFVvQnN0cGhPSHdpRmpJRVFWNElWMkpQVXJTWlBjZjhuZlROYWRySzZjUWF2?=
 =?utf-8?B?eDRMcmpkS2Q3aHpRUVd5bjg4dlVFOTU3ME1wRXVNcGxvNXNsYzdqc29zNGhX?=
 =?utf-8?B?S1ZOM0Y5YkZpKzl6UTRkWWQ3Z21NNFpwZ0NqaEJyOHFNY1kvc3dkRUFwVEFJ?=
 =?utf-8?B?WDZoL2lqS2VnWWNpMDZGV2V3TjYxY3pBM3UrclpCWUhZN0dZYitrU0V0ZUxs?=
 =?utf-8?B?SHFDdSt2cjZLSEpKc0x4UE1ycnY4YXpoUjFSWS9xWlQ2TjdqcWdKc2IyRVVq?=
 =?utf-8?B?MTdZTldaYno5RS9CNk03N2VhVTZ1SUR6UkhDcmk3akhNQ2t6RHQ3TEVpRWhW?=
 =?utf-8?B?QzlPcTFlSzh4UTFNdEVRc0l0OVp4SERxcnpnVmpmYjBuNHhab201ZXY0WmFr?=
 =?utf-8?B?QnR5dHJweGhNcTUxdDBHcFU4QU9TdDd4WkhtdmY5TjZ4V2gycS9CZzRLY2ND?=
 =?utf-8?B?UmJacXJ0Qjk4Q1ZCRlR4cGMyV2YzVmpnY1NWOXBGWng4Z0xpZkxqTkszdnhT?=
 =?utf-8?B?TEJ2WWlVWGdRdWcxT3JwckU4SHFxTng3TDVPNk1jMFA5eHpqVWd3blFZYVFa?=
 =?utf-8?B?VGtuMmgyUm50dTFlS085ak5sejZoeU1UMFZGdTJJSXNXMkN6YStIYiswbTdI?=
 =?utf-8?B?dHpUdlYxa0xvQ3MrcmdFdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1RBelVkbFZUOGhnVmRmb1Juam1WNnNHQXF5dUpRTktQbDJhekdGSlQ2RUpx?=
 =?utf-8?B?UEtKWHJuOGpVaWp1RDd4eS9BV2I5RzVQM1NnZWpUdmttL2kxVTJYVFVJVEVl?=
 =?utf-8?B?SjNEVlJMenRRVW1HbmpGWGRMYWRKdzd0Z0dseWJvSENCUkJRb2JWWExjNC9R?=
 =?utf-8?B?ZUVWa056VW5tRWNhS3p5L0R3N0c5MFVpWG5xeWRpTFhLUmhJdHpCZmQ0UzRm?=
 =?utf-8?B?N3NpUHZEWENTdnJRbXE4eXd0clphTW55NXV2WEd1VlZxT1lBb3NyeWY4OG5r?=
 =?utf-8?B?SWdvL1NoVDk1WjJXeE1LWUNNeFd1ZDNsUG5LODVQa0Qvb1drK0lRNWR2bDZh?=
 =?utf-8?B?bG5hRy9kOGpTY0FEKzE3cHFaazFjZFowRjh3ME56d09SSngxNnFONHY5ZEtT?=
 =?utf-8?B?NkVkRUR3QmhNcmlHdEE2TERpZ1pFN3lrSjcrc1F6Qmw4UHdzL2FUcWVWRE4y?=
 =?utf-8?B?RlYxS1gzc2JwLzNNTkNJV0kxalRrbjB0WU1vZm9iczJYVFNnd0xVRXk0ckN5?=
 =?utf-8?B?Vy9rMTdNTXYzcEFVTzdYSzRTa05IZjN5bXNRUW1jdEdRWURlK2xudGpGTEJv?=
 =?utf-8?B?UFJ5djN2TTdUdXREZWNuM3Z5ZlZBdnlDZDdzcUN3RTJTbGtiVXgweEh2VDE5?=
 =?utf-8?B?UFp2K2gyRkZXY3dHUmlXVmtjQzF2S0U4WUpqWE9sNmJ3NjdFem9kMlNibjMy?=
 =?utf-8?B?ejYrUTdVYTlsUkNJekR5Y3hxV1F5dVB4MklmdGM1WDl2WmY0YUpaN2FTMjd1?=
 =?utf-8?B?VUVVVlZxblpDcnRNN1FCeEhjVG1qaWg2cU9odGxrMHJIWFNPSHlmMVQ2bDBD?=
 =?utf-8?B?MmdRcGNwdnR2MUxGSmJoNUNUMHM2TWtPMlQySlU3dnNoRVRWbS80TW8xYW54?=
 =?utf-8?B?c0g3MGJKSEJDRGlEQlF6TGw4ZWxnUTBlVkxwY1B3QlcrNXpLdmZsV3pIcHBY?=
 =?utf-8?B?R3g2aU1XT1hVR0RkbFZqMkFoeVJuSHI5MGdUWGl5eGczTWhCVE5BLy9hL1kr?=
 =?utf-8?B?VUNpekptaTZhbmg5cjRBUDJJYVdTTWZIVWFGdHllaE9vTmtzeno2YlVhbmsx?=
 =?utf-8?B?elltTUoyZVlrYlBrV3VybjduZzlJMTRVQlhEa2daZWdzeGNyRDZpRHVBRHV5?=
 =?utf-8?B?YVN5K0plUGY1dTBDUU9wcUxNNE1yMENFcVlDREk0TTdTVWZtTS9YRHkyc3Q1?=
 =?utf-8?B?RGFBY2tSbjgvOERMemFvMjhGTDhVNGhRTnEwVGJ2d2E2K2sxUUFHem1QTkdz?=
 =?utf-8?B?NXE4SWhubjFCMXVmMjdlYVJwTGowbDNJeU1IdjlzeUhvb0VkT1RnZHd0OVRm?=
 =?utf-8?B?YVRzZjVLQUU0QkJmbzJybUhESEZsRlV1dTZGNWlnWS9aVHZKTTBIdlI2WXBC?=
 =?utf-8?B?L04yejNNTzZMQmM3TWZSYURiSTYvVXBNcXpLN21HczNhYzd4Unh3Z3pMTzgz?=
 =?utf-8?B?aWVyNEN1cjYxOGZjUTNzU2V3N1FWcXFqTTg0SE10S2ZUSlNtN2dTMTVHY05q?=
 =?utf-8?B?c0lBZEw4L2ZyT3pwbk81MFZPSVltZFRWQ1N0aGJTcjVwSGN6U0Z3cWZTNG1J?=
 =?utf-8?B?SjV0b3ZqK0wvb2dkcTNvdlozb0dXcUc4L3Z5aXVYMzUxUXRQTGVYMUltUEFC?=
 =?utf-8?B?bWlXbnlqTi9KRCs3M0VaaGJCZ2hQbTBrbjhmWUl1K0Q0TC82OFk4TFhmNlpR?=
 =?utf-8?B?RTVPS2RLQWNTNmZ4OThTS04xdk5TYnYrTGMxblMwNTV3dFlTa1ltNENlN0di?=
 =?utf-8?B?dUtEeVIva2dOYXZtTUNyTHMycEIvVGtSMXJ0N1lqaUl1SUJnVEVoNUlwNzdu?=
 =?utf-8?B?allIT3hIbzdZcHJxY0VCdEpXbDZvT1pBdU5vRWpXbi9JODRpVVY4M0pDdjlR?=
 =?utf-8?B?WEhIRWVhQVdRZlJDanFYbW03cjMyNkprOEJZdFM2b0w5eC91dURJcTh3NDY4?=
 =?utf-8?B?TU9JZTFLL1ZXcURNRVNOckNOeGxYenRSNFJreVh2cExZS3V3WDV1dXdodjIy?=
 =?utf-8?B?VUZabmZtK05HZWdXVTFFLzczSjkrc3Q1c1Q5eGo4dkdZNVBLRXd5Qkt6MVZN?=
 =?utf-8?B?bzA2Qi9mdk1wYk5VemFIWTFEZUJuOHRQR2IwbWhCZDNEakRRYnlKZ2J2NTBw?=
 =?utf-8?B?a0orRndDSlBNcUx1NW8yZzE0dytEV2phMlQ1dzM0UVB0WDQ0ZjJOMk8zeXh5?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc94c03-dae3-4eb1-7a57-08dcc905133f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 15:04:41.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVGx910BdixHeqzSStU0QH3rb3IIaVnJYn/9mh638e6As6wqOAK7m1Vb3qupEZBLhu/b7rKPYRt7YQsuptMS+CVwAuxABneU8koVoaicY0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7950
X-OriginatorOrg: intel.com

From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 30 Aug 2024 09:59:56 +0800

> Introduce skb drop reasons to the function vxlan_rcv(). Following new
> vxlan drop reasons are added:
> 
>   VXLAN_DROP_INVALID_HDR
>   VXLAN_DROP_VNI_NOT_FOUND
> 
> And Following core skb drop reason is added:

"the following", lowercase + "the".

> 
>   SKB_DROP_REASON_IP_TUNNEL_ECN
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

[...]

> @@ -23,6 +25,14 @@ enum vxlan_drop_reason {
>  	 * one pointing to a nexthop
>  	 */
>  	VXLAN_DROP_ENTRY_EXISTS,
> +	/**
> +	 * @VXLAN_DROP_INVALID_HDR: the vxlan header is invalid, such as:

Same as before, "VXLAN" in uppercase I'd say.

> +	 * 1) the reserved fields are not zero
> +	 * 2) the "I" flag is not set
> +	 */
> +	VXLAN_DROP_INVALID_HDR,
> +	/** @VXLAN_DROP_VNI_NOT_FOUND: no vxlan device found for the vni */

^

> +	VXLAN_DROP_VNI_NOT_FOUND,
>  };

[...]

>  	if (!raw_proto) {
> -		if (!vxlan_set_mac(vxlan, vs, skb, vni))
> +		reason = vxlan_set_mac(vxlan, vs, skb, vni);
> +		if (reason)
>  			goto drop;

This piece must go in the previous patch, see my comment there.

[...]

> @@ -1814,8 +1830,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  	return 0;
>  
>  drop:
> +	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;

Is this possible that @reason will be 0 (NOT_DROPPED_YET) here? At the
beginning of the function, it's not initialized, then each error path
sets it to a specific value. In most paths, you check for it being != 0
as a sign of error, so I doubt it can be 0 here.

>  	/* Consume bad packet */
> -	kfree_skb(skb);
> +	kfree_skb_reason(skb, reason);
>  	return 0;
>  }

Thanks,
Olek

