Return-Path: <netdev+bounces-183488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE03EA90CED
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D879F4601DC
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E13A225766;
	Wed, 16 Apr 2025 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3gh7yuc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066F189915;
	Wed, 16 Apr 2025 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834608; cv=fail; b=pQM3FLIf5BO5h90GrOZjuxrepOU1E5ggWvAmHiSD3xgvNQijUen89X1mRbk7WD2Lw+Xa2fnrpW+nC1SPG8wNHuIDtGS7BQxl5ee8SzMIvKcrjSwSfCNUoYTwfcAHwSgZsoxBs7Cgbdc62F0/LvdkN3/tvYIJWVLV0wjglOnAVxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834608; c=relaxed/simple;
	bh=KqMd4xwsKVc8QB5PXRFfA0D39qRMDGIufq9uyBIxB0A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JY3Bxdr+3cdyClM3CJxpLO/V2mcE9KwlCuTfR34Qm1Jf/opBJW2TOSQyBn0W3wFYFlCQaBlhkj9qOfH54fWbxs97YHq8VKVbka725QzDfpBOb8UkqEUUrJHuM8Evu6Q0rYnDLSBxFYlBQoBkZN70CV3oWlcGp3dqt5b+zoSk4Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3gh7yuc; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744834607; x=1776370607;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=KqMd4xwsKVc8QB5PXRFfA0D39qRMDGIufq9uyBIxB0A=;
  b=l3gh7yucfQJ2yrlRhq9T9hC9P6k+yohIhUCFONlMZ6Xfm3Eron2LB0em
   zRe65Le1EUk7QOBSm+6Sj/jfGueKMn1SjcvTTbjaDIEy40zKmyDRv+ETm
   Hfwt6BKtHoyynRMKZMivnc4WiXuO9ZwL4jWBIrzhqF8DrZ7tZsX+Ye9/S
   eV0s2yQWSTUVADzEOigPg1TxAV9/KttmfYb1EasLN2Ho5BWvoUi2rIlCo
   5Uhzi+8aNPqCYSe+MsS88A4Dz2CAvmUiZZR+8sgm+2siaoY7qsWLhj4/T
   ZHIXeqOlQgR18UXrtFXVZaqsU7TVqwyxnJBePCvOR9KGKXcOpL5lV808U
   A==;
X-CSE-ConnectionGUID: qpCVOky8TKau0UHmAigcSA==
X-CSE-MsgGUID: P+lxPQSRRu+SxFc/Ns+bWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="68894489"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="68894489"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 13:16:46 -0700
X-CSE-ConnectionGUID: mHZIinQjS4K/kluWd/unAA==
X-CSE-MsgGUID: MX4A9FtmS/yaCkQnC8xDPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="130348967"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 13:16:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 13:16:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 13:16:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 13:16:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DymU005K5+ubdoipy4X4/QZZJjx6UyDJgV8C7StuyaYGSbzQOKkbRuYYazxfn1DYFbKKmYx2dY4fZ0gcrfWdREhEZwJ8J1BABC3NoFCzg3S8DPi6/vBGX1gEqnEEZeOr+WsqOGXZg76nqsofidC4PqLtbN2yHnqNKr+eG27MAGPh96EPrxjyWLEcBQArV8l1E9p4wG9ZiClmebFtRRnoIZrlb5mIxPNOyX7HDyBWfqqILgnpkzLszynk+yjG6JEYe9d2hRUKOl0t+NG9L1zIEfG9XvN2T5ixtUIcCtXbuUozdHKrFzac2IEuuCGwMCcQS63ffEu7eOHhKxlHqvkuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc4cYOMVGuQt4QY8Inwov8PW/cMyCRM8cqq/E7Sk+YU=;
 b=nnNYb6Zf+JsWBIs+zbnLHLqZvMON46sbnLo4meMoYl3fxx+V/NSz1VelnJboIprTvv1Dh1N7WTxNZI04PhclWFUiu/+RQphkVRk7ik9FVDdB+TOZuLkXKgBvA8wbBUh4+3v9ChT91q+7ChPEaZ/ac0b0JD4zq5iSD5IBnwZYydG83hE9pFtDjq8o8fR629fcodELPSJ9UGstn6rY9ofOhc2tUG93KyGJYSFog9hUlVn039ZQfdMW+UrYJC9legSzJ/AQ0WJ6aOdbUZGoUbVdl+LNL5Ur6nWSxzJB/L2vAa9LFSZP7gmVfBZuL6wp48DiG0ScKKK9SL7AKjZXa4N9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV8PR11MB8461.namprd11.prod.outlook.com (2603:10b6:408:1e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Wed, 16 Apr
 2025 20:16:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 20:16:38 +0000
Message-ID: <e61e6355-6782-4b78-a085-3a616c0afa23@intel.com>
Date: Wed, 16 Apr 2025 13:16:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 4/4] pds_core: make wait_context part of q_info
To: Shannon Nelson <shannon.nelson@amd.com>, <andrew+netdev@lunn.ch>,
	<brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.swiatkowski@linux.intel.com>,
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20250415232931.59693-1-shannon.nelson@amd.com>
 <20250415232931.59693-5-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250415232931.59693-5-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:303:6b::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV8PR11MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: f5326cc7-d559-4045-ae76-08dd7d239816
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDVScjJZS09Mb1JYOElKaUd3SWdFWmRpUE5TdmtvZHlKVjlGMGFhQk1Yc01r?=
 =?utf-8?B?YTJQTjNmL0pKQStCV2RqMnZENURDS3VVNHkzclFLTURCMmJMaHNJSmFBZHk2?=
 =?utf-8?B?c3BMU05oVkMxMnBUa1pLWGUydHd6VjBpUWw4UDhMekRzTXVGdGEzN0ZHU0Rl?=
 =?utf-8?B?Wll4RkNKRU4wY3dVY0UwUk52SkU4VXFVOVhvMm4yeFo2MGtuYVRabXRWcFRK?=
 =?utf-8?B?WGFISS82bHdtWlZPaUF1R1FPSk5YQTJpWDJGcXR5MjVKeGc5UXNQSERWRDF5?=
 =?utf-8?B?cDBEYTlHejBtdG5MazQ1V0RwbzJxczNLYXg4eGVjbUh6VXB3ckkybmR5QWN0?=
 =?utf-8?B?QWVIM3kwVlpwL1ZvUEV6TUtzM0dOcUV1T1BuSTFwR0JWbml6aTlLWWVGdmNY?=
 =?utf-8?B?ZUwxc1hqTUloOGk3YXVQeUdGTkF1N1ZkUmxHdzFYdWhVM0twZVNMVHNZVjZp?=
 =?utf-8?B?UmJyWE00cDVyVnd4RURMV3ZMVGkrN0Z4d3ZvVy8xQ1RXenpSVFhaSUZUNCtU?=
 =?utf-8?B?cCtVR2dLSUxDRkdCWDBVY0tkV3R5SC9WRkQwd1ZkaElHazRPbFNlYVJqZ25l?=
 =?utf-8?B?c0FhbXN0amJyYzF2ZjRRVVpFdWJmSzNrZ3hDampoRWdoZm1VRHlUWFBYN2tz?=
 =?utf-8?B?eHh0MGlQbGxwcjlNNGFwZGQ5SmdZWGtieGpacFNKMEp1dVpXemFJcURQTlNK?=
 =?utf-8?B?QjduMzFQV1ZTbys3QlVHSmhvcWZYQVI3R20xLzhHODM5Qy92VWJLbmlYeEJV?=
 =?utf-8?B?ek05ZkRtajVadUdLMEZuQUVnRThUOWRDbDRSSldyNWlsWnI5OFJ4bTBXaHFP?=
 =?utf-8?B?TTY2M1g1Y0hwK3F4NEx6eTVXL1FUT3V3VW5MSUxqc2NWS0RtRW1tblovbm9Q?=
 =?utf-8?B?NE1WQlFCZzVIY3RwM0tibGpsc3FSckVaakFrY2s4K1hhUUtvWjJINWJTSDRU?=
 =?utf-8?B?akJVTUVKVExhYW1EdTc5SnQ5empjVW13cEtmS2dSWVlDQ1dNOG8yZ25GZmlZ?=
 =?utf-8?B?SWFKSDk2YUNhSEZZMSt0TjBna0dIVVN4MmQ0clY1YkFNOWhvaGs3VnRRNlJl?=
 =?utf-8?B?eHY5NG1QK2pQenlUanA2dmhkRG81STNScE82VERkK2xreFFwRTJRY1YrOEVi?=
 =?utf-8?B?MGVock5vV3lrWk9NdlBnZ0xmdk95SjI3bWRkWWVJZ0w5T2RKTlh1Z3d2MXZL?=
 =?utf-8?B?RWlsaUZFWkNCdDdXT3Y5dXI3Q1JFZzNRSWVKbHoxQ1lQNXFRUnkwSUlZVVps?=
 =?utf-8?B?ay91QUt0ZjlueGFJMTkybkVvYnRNNDVLV0tUT0d3b2oybWJTVXFja3pybEVq?=
 =?utf-8?B?SGl1amdJNE9YUnBKR2ZDV0VGcVFHYjZZandNL25ia2lDRTNJcEV1Y05xN3Jk?=
 =?utf-8?B?YWJUKzFPU3ovQWZoYmFRbVg5dFkvSXR0M0VES1ZUMngwempvYnNyWVgwdFVQ?=
 =?utf-8?B?QWUzYUZkVDltS1dqc0NmRWZsUlRYS3ZQZDFlNDA3Z0x4LzhrTHBBaTI4eElQ?=
 =?utf-8?B?RVhSbmQ4ME9zVVU3aFovUFV5MlRmM3gxRVpNT1RRQ0RlYXdrT1ptNG95Mll1?=
 =?utf-8?B?TnhBWFJYYzhpV0FNcHp6M290OHdmSG9YakN5ODlsOXRTNHNSaHJmWWtteEFW?=
 =?utf-8?B?V0w4SkFkMlBlQXdCZmZFUTRHSjAvSVh2UzU1cFRnS0R6YUE4RHhSNllJdm0v?=
 =?utf-8?B?THV1MC81R2FpVW90Q2pQdUQvd2Nvc3Z1Tlk3a3dndlIyRGVtRHp2WTRYU2Z5?=
 =?utf-8?B?OVAzOHlGcElaTDhnbU5SNjVyNGd2NmtQMUJQVi9sWHNHdnpuOEJDSC9vOXZG?=
 =?utf-8?B?SVpLdkJOSTlRVGhYdCtEcTVrNWxtQkRlVVpYMitvTmdmeXhlTm8rVGFURDIw?=
 =?utf-8?B?VVZrdDV2R2JKcTVXTGlvOGhIVDNPb2ZBRnRFSCtOY2kwQjZLTDh1YXFxazJZ?=
 =?utf-8?B?M2pqOEg2UWU3c1FERGNNNmV3bEU2elNQbjhQRkxyb2VJOGlnb011VEJ1blJV?=
 =?utf-8?B?NmJ6RWMyajZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1UyTVpsZFlXRW9RSklqb3hRd1RxT1JxUHYvU05NeldNMEZzMUlwaExzQzBS?=
 =?utf-8?B?M24vQjIrdU51QU5vN2I1WVFHNURpdzJPUGZGb1I4ZGZVQ0I2S0VHcGY3UU0y?=
 =?utf-8?B?U0loaVExcXRJcTl1bkVtQlJqZGhvcVJHbW5kazZjdHJoTDZPY0JVMy9tampY?=
 =?utf-8?B?bFYvQ201TXI2R29weW82cHYycFBvRUw3SGhDZ1JHU1BnanNMOFlaVCthWmhS?=
 =?utf-8?B?NVJGYkJ5WVVoWVIwY2ZXdFVuaGRhTmpUdjgwcVc4TjhOM2tQeFdCL212VGhT?=
 =?utf-8?B?VExUZ0RINytYanFxcVpvWjRnVlZoYTFEaUoxSi9naXArUTdxVTd4U21uaDE0?=
 =?utf-8?B?Ly9ITTFBTFFWaW9OeGtBczZ0amxwcnhaTzFjSWE3STVlR1Mxd2d3Uk12YjN2?=
 =?utf-8?B?eDNDZE5rZG1Dbi8yNHN4ZFJtbndERWFUczZ4anRQUFVhSGo1eVhGeVBsTUhH?=
 =?utf-8?B?S1c1NHZ0U3VUTXE2OUVuOVAzdzczdHdqcjJpSnIzUGhQZXBOanArRjV5blBz?=
 =?utf-8?B?SUl5ZUpIbzV1cEpqcE5sVDNJWTBncVY5a2NSaEw2RlYwemFTM29HUmkwM29p?=
 =?utf-8?B?LzNhbkhRbnhobXlXcGZpMWxHa25pS0tCeHlEVDZFSlNVemh4OXB0YWY3QjBJ?=
 =?utf-8?B?UGhSelR6Q3k2N2tVNFpSYWVpb3VmdHVBMkpweGw5R0Z1V3JhWkVBZmpZOFV6?=
 =?utf-8?B?TVlHbEZCRFdERk1DbndQYUZnckZXZXAwbkxJTXhrR0EwL0FYRG9aMDBLbnIv?=
 =?utf-8?B?SzlzUnYvMGxhRHZTSm1nejNZbkFGVTk2TllvTmlvcTRwOElHczFYcEZzVnRR?=
 =?utf-8?B?dWd6bTdaNzVOTmVyZHN0OUxaSjFjTWMwdDFoUHVmUFpoWEZDOXNhL0JhR2FY?=
 =?utf-8?B?SndXTmgxUzFKZ0syeERzdThxeUVQbXRUeVg1Wko4aTVSRHljekNIRWRoUlZR?=
 =?utf-8?B?bFE2dnQ3VW4wbTlaMjNZTHYwdTFiVFRGY3pkb0tqVW1tMW5oTFFpUG1uUlFP?=
 =?utf-8?B?VEZMK0IvZkJNa0ZBVzJHWTh6SVMvbnc1N1NPVWNtbGc2bThaN29LMXN0c2tp?=
 =?utf-8?B?VHVndTlRV1FvNHlobXN1eW5rWkZnZUdERDR3U3hxQ3NXVEc2ZnJVZy96MWpt?=
 =?utf-8?B?U3UwaEJlN1ZyNFZuMmNmUCt0cmg4dFlnNXF0am40b0czMnVXOGVGRnBEeUVY?=
 =?utf-8?B?cnNUUEp1OWZudWlLenhiTVRnZ3BTSHFIU2hiaTQyeXZQM0lIS29jQ3pCeXVL?=
 =?utf-8?B?d0ZRUDdaTk11Mm5PMmJHMFd2R3phNHhNSDZVRzRvVUhVVHRHWHNvM0N2N3NM?=
 =?utf-8?B?QVB5RDJqeHRXQUtuT24wRTMyL3UzNHVuSWJjbHRSTlNsNHU3UVFNTy8yWHVm?=
 =?utf-8?B?T3Q2WWZuaUFERThDZGFhZHF0ekFuT0xDeG4xWThiY2prbkhUNld5VFhaeVVJ?=
 =?utf-8?B?UC85NnRMc0xOWldnem5QUEgxS2JTWlFPc0hnaFJvVzdYMXlyd3BWeGNGdnV6?=
 =?utf-8?B?RTdxbVBEclhkVUNCbWtQUW43N1FHVjJyTGtOekVTenhWcjhxNlFQQ3MxVnRI?=
 =?utf-8?B?RkFTbWc1Q1JCdnVySXVOeldZMHVZVFBoWE94dGRVZXB6MUswblBJa0ZRYjNU?=
 =?utf-8?B?ejlKUm16MnN0dy9zSktlQ1ZZVHY4aDdKTG42SW1sQ052QXhPb3RzZHpoVFRL?=
 =?utf-8?B?Q090SzFZVmdWYmI4Q2lIUk43Z3pDdUk3TDBWT1FsZzQxSVhOSmxDUHhsQ0RX?=
 =?utf-8?B?WFZha0xDb2JES0ZSNWVkcXQ2RGdOa3Yxc2UvNll4K01xNVBVeHJRUVJMa2Mw?=
 =?utf-8?B?WEEzOURFd1lCOEE0cmdTa0RlQ01LSTc5Qk9iMkhMSjA0NkpKY3Jxc1JSSExO?=
 =?utf-8?B?d05od1FlSHpabnR3UE5hK1l3MUpIMC9oeFlhTmpVMllId0xUNEd0Q1M5OGkr?=
 =?utf-8?B?TDZKVWRQVVN4czI5SnF1WnVKeGZRa09Jckd1anVUKzZaRFpJTERwaFJ3dm94?=
 =?utf-8?B?VHFPYU9lcEVNY1V6SUdkSUdTTHhPV244YVJ5bE5saGNQaHFPNmlkeGIrSml0?=
 =?utf-8?B?ODhRQU1NeWZTOWxoK29KWXpibHRPWUVYMGp5eWVRYWlYSTM0NHl6UE85cFBz?=
 =?utf-8?B?dnh5Lyt2Nk5Wd0Q2MzBPTTlPL3ltWHdnYTNkbWxIRGRHL0I3YkJnZWpoWXRN?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5326cc7-d559-4045-ae76-08dd7d239816
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 20:16:38.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIN4v9wRzqfMWbbhxwfOmsxvkq9pl0GpxiY9oX2VQWQbXPmerVEuykDL8iE3gTCekyk5iDdQIcKkjA9JmVf7jRmAqPRTsiC8UBXHKFfDhxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8461
X-OriginatorOrg: intel.com



On 4/15/2025 4:29 PM, Shannon Nelson wrote:
> Make the wait_context a full part of the q_info struct rather
> than a stack variable that goes away after pdsc_adminq_post()
> is done so that the context is still available after the wait
> loop has given up.
> 
> There was a case where a slow development firmware caused
> the adminq request to time out, but then later the FW finally
> finished the request and sent the interrupt.  The handler tried
> to complete_all() the completion context that had been created
> on the stack in pdsc_adminq_post() but no longer existed.
> This caused bad pointer usage, kernel crashes, and much wailing
> and gnashing of teeth.

Ugh, I can imagine that was hard to track down..

> 
> Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
Yea, this approach seems a bit cleaner overall too!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

