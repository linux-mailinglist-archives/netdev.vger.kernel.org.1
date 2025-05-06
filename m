Return-Path: <netdev+bounces-188450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDB6AACDA5
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 21:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8E31896425
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 19:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A3D24B28;
	Tue,  6 May 2025 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLsc2Qlk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F614381C4;
	Tue,  6 May 2025 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558101; cv=fail; b=UgjAmgRsvGzsXwrciTxubf9F0I9nPl5wazsECZqolrTMKWRWpYvbOgtLzzeXASeOXMjyAiiaEyQTNWNqdUVi5ZwLO38mdhkz6uoLKpNN7r1jY5L1jjATq4BSXnsgKP7u1ZnaLwNiOvtObzAv1JQAvUb8CoIzWuePDCS4+JoFKJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558101; c=relaxed/simple;
	bh=ADNSMDcI4AuXWaMPIVY8sC/udS0LGudV+Crb3sleCRI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XljXsuYHmmgCep257BsL4fjesUOGJobB+OFKFnr5S2Xh0tMzcDIM7t9Siofl2747AxwAa7+bFw7iE4cpnuYvwj0/UBUQuuqBGK3Ef935v/O03iqfJLENP/zgc21n6Oplah6USJ6lTOIuVXL2VkF7LnuYQOP6/y6bzNhAmf5KvW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLsc2Qlk; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746558100; x=1778094100;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ADNSMDcI4AuXWaMPIVY8sC/udS0LGudV+Crb3sleCRI=;
  b=JLsc2QlkCsbmwYSFvfQetx65sygjOyAh320mJjxXqbbGXv1yRoESCqDI
   Rz/UAaGSFmNuLzUtaxuNejrNy510OtVUugzz3gRyojszt8C+SSos/4c+5
   NjQ9sKcAURA6gfgBm4iJnV1ZWOIwQVJSjsdPydLSZEFcJCqMMFlhT9jxM
   aQSv19tDOMrMlDcz2m/t0Dk3QQBT7ht9pR1eiQBmBdO5SwQpm6eeF+YA9
   a0Oqc20axqYrKbGS2S6Dyh5EvvKxUTL02Y7PXwOTLSfjhnvaCzFksRnMG
   wZQZvZ8UrJR16+N56QwujqFOsYKvXGVI8gQHIFYzGBTFrOoCgwtKl4sVi
   Q==;
X-CSE-ConnectionGUID: tadobUyGSqCy6V6uAoV9Tw==
X-CSE-MsgGUID: sXd2kOiZSOai0Dir6VlFhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="58881263"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="58881263"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:01:39 -0700
X-CSE-ConnectionGUID: 8AHydgVAS7+vxGDVhxHUwA==
X-CSE-MsgGUID: YBPaeBz1RxWbQyHOGHgJSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="136664724"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:01:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 12:01:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 12:01:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 12:00:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmXtcPla3ZbtADBEleuKaEKAS+1MCwLrX5252qcbUDVh1Tm44Ka72nkK5Z/x5y1bz5TL+MaSV5BeP9ZaXl4YnwU2llu5vw1EaJRF3YnTvJnsYNwNlKQ+opskHFjlZ9wYs3YojUQCNUBF4dQfj7XraOz0mrVduQee7qqtQa1RgcS9hm2xoVV9t5hqWsGsjw46rd0/ZB5j6HPgxTy3qQ9KtouYS7fpnd8V6w12z917pE3Su6dAjzmnpZIX3FbikU+5xSRtjLnqoyuaANaeeVeGTWz6Gj6bVxsbEv0aY1ew8eNgrjAz8Irbj0yUl1idQ18bCycZ8kI36htoWdoXpFT56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKWa1cvUymd5PHg9sQL5y6lE7kJD0QeckhDH49cduKY=;
 b=Fqz6bSTceDWkk60bvVSqNhQ3YG8r/MRgRsDgN0wth7kbvkmiDyPAUA8Z4562Z5foOJ6/0onW0k6lR/1C9vOTwUz27GHF5GSVkz/nzn4LVgEJCNZxsa4FZHfEZxZP647HPHDYo3MKNVs5vHaCh3i+Ob3o7GDHwBBdrBRZT1nQbUDSVBW0ux09mBI9KhxrmL/PSk95OUO39w/grdxezg7vTrS8gAB4kf0/kNQ0QBaaYZBS80mi+8C/6MLadFy+O6hdcnByqgoMzl9FJBg1nYpIFi6VNjMZGAdNkVTS/NSCJZdzG7xdNIoh6QXevxAA5f9FneW3HXR/yOLHZ4f621LNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM6PR11MB4756.namprd11.prod.outlook.com (2603:10b6:5:2a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 6 May
 2025 19:00:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 19:00:13 +0000
Message-ID: <24a121fd-aa4d-43db-8c8c-477bca99a7ae@intel.com>
Date: Tue, 6 May 2025 12:00:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tun: expose queue utilization stats via ethtool
To: Andrew Lunn <andrew@lunn.ch>, Alexander Shalimov
	<alex-shalimov@yandex-team.ru>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
References: <20250506154117.10651-1-alex-shalimov@yandex-team.ru>
 <c02e519b-8b7d-414c-b602-5575c9382101@lunn.ch>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <c02e519b-8b7d-414c-b602-5575c9382101@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0110.namprd04.prod.outlook.com
 (2603:10b6:303:83::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM6PR11MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e3bb1c-9271-4bc7-89c7-08dd8cd03b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVdBL1JuRzg1emdETE1zaTNGZllIQk9jVXlFVEJqdFBxZWFiRjc2ZC9tSGtp?=
 =?utf-8?B?alFsUDZ6Rmd3RlJBY0JPQUE3dHFLMm1EcHlHMzBzZWt3Y3lFZVVNSFQxQ0pz?=
 =?utf-8?B?VjFCTnBGNDlIWVY1U0E3U0xJanJTUDhkWHRZdnloTGF2TlBNRVplTFBHOEYx?=
 =?utf-8?B?bllZRGd2ZnJzaTZjYWtvVUFYRVNXV1VjZC9BYXd4eUhpSCtDYjR5ZXV6OWNP?=
 =?utf-8?B?RmZKQmlFaDBkWHZVenJVQVA0MVovcmJqZGRkSTFYUVdybm8zd1JaK3hmWUo0?=
 =?utf-8?B?cGF1V3NxRmp0bGIyd0xFc0plNHppNGsrazBoc3ZCWDdYNG1xd1c5aTFtbUZu?=
 =?utf-8?B?cjVxQkJ2YlBoMng0S200NHFXMk1lTVpXU0lIK2c1aFRRY3FuZHk5bGl3WTg1?=
 =?utf-8?B?anhuOEtybE1uM2ZEQStuRWI4L29IbTlXMWFhNkFOZ2oxbTA4RXJEN2c5TW5X?=
 =?utf-8?B?Wmx1OTdJZ2lLVHlyaVR1cWZtNWZlaTVTcWo4a0VHbURWbmJuNWNSTTR2enJ1?=
 =?utf-8?B?ZFdRVFZ6WitML3VuUGZXVCtuVlJVVy80STkvcDgyUmFiVVg2S0RYTzUvbXdM?=
 =?utf-8?B?YzBvN2JjeGljYWNFZlF0V1Rpdk1ueG90MkRvYUF4RTRoSitydXpna2FEZzVi?=
 =?utf-8?B?cUp6dmtHMENSVXQ5VzhCTmlhYXZpR3hsaG9salk5N1NIMDI5NEdnVGQxSHRD?=
 =?utf-8?B?WjR1YTdmbVJnblQzUk9yVUkyUkZsQ0s0anBDY1VRdk8vN0hkSTIyR3pRbGp5?=
 =?utf-8?B?YWxQclV1ZWk5dkRET0lSaTlyT3pjU0dCWTdSVGtxTzJzTk9MM2hxVlpoZUwx?=
 =?utf-8?B?dENyRmhpUEdhcE9iWTkvSWgzaXFKc1BpU3A5LzIycmxWSG4waDNQSkQ3eDh0?=
 =?utf-8?B?eHVaQWxRNGhLVjArLzN6NklxSXk4RzliNm5iNVhwZkR4eUFHV2RBWGRScFpH?=
 =?utf-8?B?V2xxMXowLy9SYVY2Q1M1cWNRMDRKdldvQ0lRZWljdTNScUFBUDZNUnAxbXFL?=
 =?utf-8?B?ODNoeCsxVlBMZThmWkNTZUg3N1VnYnVKb2pjWnllWkJBbW1xZUxrcy9Tdm1x?=
 =?utf-8?B?cTFKYzVOeWsyOG1TNHdEVW9valBhK3dULy9uZGY2ejRqTWhYekdyYXVncEVS?=
 =?utf-8?B?WG5vQjV1Sm5zWFBzV2hRdHVCTFgwZHpJbERNbUZRREtqdWUySDN5RFBCUmtx?=
 =?utf-8?B?OCtSNG5sUFRZaFlvd2pqOU9GRDZXejFVR3JYWlYvMmhNYlFrMm9RREFLRnRP?=
 =?utf-8?B?UkZVSDEvei9nNml2b2JtVHp2UjdQaWwyQ2hGZXN6OHpuRkdoL3RKSTBqdzlo?=
 =?utf-8?B?WlBnZTdZcDRaQVdwOXhzMXIzYVJwNWEyVllKV0JIeC9qbFlNVC9vSlgzeDF4?=
 =?utf-8?B?WnVPQ3B0NndUbFRhTCtEanZnaTN4VzBRRDUram5LVU5Td0pBQ1hsejNPM2lw?=
 =?utf-8?B?eXJMZlpmNnlwWmdxTGd1Z2kzOVhrc0xObUcvamFNbVVYYk1LRzIzbVI3Q3dk?=
 =?utf-8?B?K3BudHVaR0ZrRlhSY3Rja0RoMXA1eXJzbi9Pbk1GZ0RoaDY3em4vS3M3Rnp4?=
 =?utf-8?B?a0RNRHhuWjRVUjJyQ1JLZ0pLVmFtTGlIMzE2anNXSU5OZ0ROZ1cyWXJuN3p2?=
 =?utf-8?B?Y3M4VHRvcGNaNTNhZS83WmRQdzFlaU5MRDNGRVNzSHMyZUV3OFFKQjY4L05F?=
 =?utf-8?B?Sm9qN09PdHRaQ280anVhVkNFQ1ZaaGM0SlJUeS8zVzhZWHcxcEVkT1hVajBE?=
 =?utf-8?B?K3Foc3JhUHdqNlJDcDVuSmw3OU50WHpNYVBwaU1BR1NBaHNoVysyaWVBeVNo?=
 =?utf-8?B?Zm5uS2Q5TE1IY1EydEhIbHh2YWVBRHVQNExnRHdqYlY0TWNFVkFoc0JxdmVu?=
 =?utf-8?B?YmdDa2Q1bmVVSzl1bGwyMlZzU0tlWjRscTE2VUhlNzI2cXI1cWVacTRtYTk5?=
 =?utf-8?Q?6Np+KtmSe4I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXlVdUxNTlNHanU2S0g5TklEbkFiSnZkZ1cza3BlcG1YbDM2bTA2bHlsaXBP?=
 =?utf-8?B?Q1lQWTlHR2tuaTR2M1cwQlVxa0hDQ09kOEQ0SkcrWElFMjdiWDNmNkwwNE1Y?=
 =?utf-8?B?bXJrcHN3WGRqLzd2cm1PTDNwdHlIRXpxbGhIczMvZ256UXI0b0ZoVDc5Z2xC?=
 =?utf-8?B?YjkvUzRiYlc4aGROUmdOeWorSjdoK1BOdFpGemtiWXVVR2NzYk1oQ0lDajNW?=
 =?utf-8?B?aUhYTFJFeXg0c2o0YS9hVmR3YkZwbkNNWmhFcm01MTYwK1JpMUx5dDNvVzVO?=
 =?utf-8?B?UG5nT1R0RmJrUTB4MDhzMkZ1dlFrN0JjZVJjYXpVTDQ1NVBKRW82bllheENr?=
 =?utf-8?B?VzdWYmphdGdNVUtFVWZVMzEzaHB2Wm03SC9tRDUyNnQrWVVRc1h4RG81YjdG?=
 =?utf-8?B?V25uWkFlQjJpSzUyMXVwSSs4V1doWkZnVTdwd01DenJXK1IzYnhyZ1pjT2E5?=
 =?utf-8?B?YlRWdVcxbkZzM1FVT0FoQmlLODBZWmt4QUs0S3VHZFZqUCtlR0ZuMDRyTDVl?=
 =?utf-8?B?NnlZMHl2UlhRcS9Rd0hWckREcGtDbXMwRnpmVDUwaEkwdlJyVGR4OCtDL0Na?=
 =?utf-8?B?Rm8wSlBLanEzdjNpZ3pWV2VXbjhDdXlIZTRDZjBaS0RKWWVxeDUyOHNtbUhk?=
 =?utf-8?B?ZGNleXRTZnQ0QS9YQjBlcHVXYm5PS1FZSndjNE1oenY3NWNHY1lvZFh3RUpL?=
 =?utf-8?B?R1VvQXp0OXVEVllydllVRDZmaFN1T0gxa2xBYnVXcS9JNlhzb1hkVWpCaENi?=
 =?utf-8?B?OGNuWEFyWWxmdG5PbjN2NDVucDIvbGh6YzlQSWdPeVpkNDVZRjJqdjdBbmJy?=
 =?utf-8?B?ZzhQaGRJVjhlVXp3VXJrbitXQ051OUk3aExObUtiMStReGZFSVZnMXBtYnRG?=
 =?utf-8?B?dTBQYXRKMTdqVTNWNXMwNGR0MFZGNjN4VTRNY1MvdWFmaE5aTmwzUHpNTVFT?=
 =?utf-8?B?aEhwUU03MktRdlplbnk1dGJRZ2lIN1BFN2pSdjFBWm95ZjJWS20xQTZGNjFt?=
 =?utf-8?B?aDIxaTd2c0NlMm1scW1wbmNZTFM1SFRSVnFBVDd2VzNhM3lUb2FyWW9TM3Jo?=
 =?utf-8?B?V0pOL1V6NGs1VGdwRnZYOFFYR2tnTUhuUllZMGpVWEpZT3VVc1ZHQXV6aFZ6?=
 =?utf-8?B?ZmJJT3NNc3Vab0VzY0U5My8rOVhyb2E1bGdneXlTTDV1cUFITXIxL1JyYzdO?=
 =?utf-8?B?YVg0aWgrcXJ3YjN1Q0NIMklJTFRLMUkzMFkxS3dnUlJpOGg1dWJZN09rZUVi?=
 =?utf-8?B?RGJMR1hUVmZhRTFPOEdZbVpOd3FTZ3l2NVVzSnFlTUhnNFE1MnE2UTUxY0R4?=
 =?utf-8?B?MG1JZnFZZk5pNVBmSUovdkZxQUJIY0I5VmdOZGRLMkZORWQ4cStBdjM2K3N0?=
 =?utf-8?B?NFNTd0FBQ0tVUkhaQW5DZ003R2F5djc4YlZOK2ZycGFlNlM5WWtzL09nams3?=
 =?utf-8?B?elZoR2Z3Y2EzaHVPWlBtak9WZ296aHhROENSNGZWWUlmSWVreHZ4dGhNTnAw?=
 =?utf-8?B?SnVWWC9uM0hNOTBzMlVVNVZQTUQyWnZDMmMzcFREc2JTZEVLWnJTTDNWOXdv?=
 =?utf-8?B?d3hDUlZkZGVnSkViTDM2dGp0SFpaUGphb0o0R1l5ZWxsUkV6eVVxS2lYUk9j?=
 =?utf-8?B?Y3RkcnliQXA1NWY1TjJGQTBuV3FHRmZOdVpWSWF4c2dUandRQjZ4cTlDV3hr?=
 =?utf-8?B?ckpydDBxT3BDVlVJdWQvcndCcDZDamd2V1hOdXV2MzNibHZ0b2JaSWxjdk51?=
 =?utf-8?B?OWpDQXBvZ1lDREcwdFBZZ0xUNmVHTUNlanBULzAzYUhMYUdpMlJHVHJsbFdx?=
 =?utf-8?B?ZktzSXptMERBaFF1MXRZV3ltRmZaVDg5bGU3aXN1dXZsazFiQ3BuQWNYWnZo?=
 =?utf-8?B?N25kRTFzNVArczFFZ2JrUzhxa2VHR2tFK3Q3QndYZmhiaVNYSGlMUjN0MGcw?=
 =?utf-8?B?MDVlWi9YSnN0QmxrNlp2aEhzVUZRSkM4dDNPbnNqS2pmV1JrcGljek9sS0lk?=
 =?utf-8?B?c1M2TTNkL0xMV0dRdThFN3cvMlo2R3d3MS9IZkxUTlNUUXd0cUsweS9SZ3lu?=
 =?utf-8?B?TUpMZDU1UFpaaENiV3pjeWVCUWFQVGNXalFENDFYSG84TmhzZC8zR1VOVFJy?=
 =?utf-8?B?VjVLMFpjVUVJQVJZQVVyeGJQMzlwTzBKRnhZUWRldlp6OVVUNE9pd1ViSVRW?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e3bb1c-9271-4bc7-89c7-08dd8cd03b9f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 19:00:13.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJQRoiQ9/bZmmvogyMubKwclRfrzskluS9j+L7lmlhQPURuimq58OFGPJfsuayDabkJwerr610HJfjTm7MQ2mrMtLH5b0Fo9r4uW1vJlSK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4756
X-OriginatorOrg: intel.com



On 5/6/2025 9:07 AM, Andrew Lunn wrote:
> On Tue, May 06, 2025 at 06:41:17PM +0300, Alexander Shalimov wrote:
>> This patch exposes per-queue utilization statistics via ethtool -S,
>> allowing on-demand inspection of queue fill levels. Utilization metrics are
>> captured at the time of the ethtool invocation, providing a snapshot useful
>> for correlation with guest and host behavior.
> 
> This does not fit the usual statistics pattern, which are simple
> incremental counters. Are there any other drivers doing anything like
> this?
I don't recall ever seeing anything like this. If there are, I feel it
is a mistake regardless, and we shouldn't repeat it without good reason.

+1 to looking at another option for reporting.

