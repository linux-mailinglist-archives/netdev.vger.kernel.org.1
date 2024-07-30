Return-Path: <netdev+bounces-114091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D839940EC3
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D963E1F235BD
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574C31891D6;
	Tue, 30 Jul 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPZG8/cb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC2208DA;
	Tue, 30 Jul 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334591; cv=fail; b=Jz9EpgrocmnInMuv73LsCQj+hhZik9BK5E/NujpCoVx58LbspWri2k/J4vwWj/GY4LsA6eq4LAorkO+jLZ0945ZRP7DrewyuLTTkZUgaYbyEitQRT3XwkFf160A7AheYAtqbedZ98FOdebxn70Bbd8c5eSgUgPx11urmMNOanms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334591; c=relaxed/simple;
	bh=cW22sCdJ+Cr4n8q4VbsGBU69lvUpSQf7sQOrqNpv0K4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iAvu1Aa4BQP73UtQoeN7CDpKPItkPmA+PqcTFG1voHcYHqUQ5MF6GPTJuBaZwkUFWl18rzMkGHTYUDn6x1pk7VkEUeCRvAt4kNUINwlEd6wQYlDV8h2ag0V+BUxsb14NF/5ja0ddZLlVnTrj6Jdmkg/SKRyy4wja+LK+YkN865I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPZG8/cb; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722334589; x=1753870589;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cW22sCdJ+Cr4n8q4VbsGBU69lvUpSQf7sQOrqNpv0K4=;
  b=fPZG8/cbo9m2a08EYn9aSskLmigBZ3+Q7XzO8FNhTWrmOsdhbC6JmgVr
   Mt0Tv6Mq2q5sah/zcplTQNpBRWkjSiXi653UWmbOKLHfusGLE9Sg747Zm
   Feag1NPXE3x0uUS0KcYOplIT5jPsj/Jh3Ghs3XkZORqAhMTSC+RzYIQ4/
   mIjNJkNZJkiJrCg0vKZDGjCLg2FeEPFGpURJATbEjNwgd7WrUHOGBqPK1
   IOQe8vL3t/y+m9aj+sFrLHbN9kkKGptQfOyThSwJiQ1uicV+Wc/Rarap6
   Yc9jgiAR0D5klPDcZI3YVNnx+Gz4Bj3fjtHTEq9sOK1L7wSTKdlYfLwax
   Q==;
X-CSE-ConnectionGUID: VL4733ySQPSGRLD2N+CJew==
X-CSE-MsgGUID: NUfU3919QpiUl4kNUFm85w==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="37613685"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="37613685"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 03:16:27 -0700
X-CSE-ConnectionGUID: LtI+BxiWRmS6fwGFoLojhA==
X-CSE-MsgGUID: JLT4+Sx9R2ef3J9ZMubliw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="85236626"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 03:16:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 03:16:25 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 03:16:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 03:16:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 03:16:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7zl84sS1lx36UHNsJGKZNDPMenuQKCuHq1xDbsFhwQImCmSGXjoLoDBegyDvADVglXRhRFt7/SkRjuaK73Srk7mDnuRqCfvr8UYWPLboAHalP2fFuhj6XUfhPd25My37VrwtsxLJPct2ctTe4/YSzPWEsuYnhJlnG0MFOkuP6yovTXNk0ssv0h9WdZZji3Rf6e40C0syGV3ZMBQkJiLOw4Nc1gi1Rearo7dmyG82+eWFass/u8IEcuQn94QL218gU2ZmfjwVGOlNrpsdOwvdQ7sBx11CiD59jSanc9tVVejfGWzycnbeT5CqVcR7gd/wMARl6keHLST/LcEGoOgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYdab5Hua4KQvOy/zosG7JkjvxiT70iRx9cZU/i2Thw=;
 b=SK9mb3ao0OumLDxVPfeg7SQDxzc5lp8Innx2OqjHNo1Wx8rosICD8u1aQJSibLErg0AexU4htM3LF70eZuluBumBPQ3yq5iPu7FIuBs3496qC4Os0lkFvVm5GxIc6O3luYXLQ3QAiqu0vW1fTgoYd72Hs5JIuc1aiycGGdw9EQlm4rA5TXP0xVZVJUt8EIUyNmX0L3xoVatRRdq2HzUOba+YNw3lKWYWRHJ0PSgeJu9reEyIPMXmW2i1fzg6//O+9iOTAos7use1wmeKQj2pvIAKZe4QNscgk0k9AMplF3wqhUbsYoFMRBgeWm9B+BGvhH1+8HeDdj9QPUCN1RnJ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SJ2PR11MB7576.namprd11.prod.outlook.com (2603:10b6:a03:4c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 10:16:16 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:16:16 +0000
Message-ID: <5c2f124e-3eab-4a24-b801-50c36775e6e4@intel.com>
Date: Tue, 30 Jul 2024 12:16:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: wangxun: use net_prefetch to simplify logic
To: Joe Damato <jdamato@fastly.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou
	<mengyuanlou@net-swift.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Duanqiang Wen
	<duanqiangwen@net-swift.com>
References: <20240729152651.258713-1-jdamato@fastly.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240729152651.258713-1-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SJ2PR11MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: eb307131-3920-4afb-7674-08dcb080a5e5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkVEL3JlQ0h4QVd0cG11K0Z3R2pscGZTd1BraVNodDJCZ2hwMGRuRFN5SSt2?=
 =?utf-8?B?MDdLdUIvTU5pWlREVWg2bjJkQU5QOWlXZUtXQ3hVeGxOZjl1aU94SVdiYUxH?=
 =?utf-8?B?T20rRmY1TXdwNTV3Nmp3Q0w4dUJXeUwweTY0akl4UDJZdDZsZGN1dnNCUDR5?=
 =?utf-8?B?V3Ewc2ZkTk9jYk9RMlJTdEpIZW8vN0FBQTdDRkZYOFBnNGRxc0J2RU9NSGZr?=
 =?utf-8?B?UDBlN3ovVEphOUxKRWtBUjEzQWR5VWVSTG8wWXdYdnJVcUx3NE9iWnZyenht?=
 =?utf-8?B?U3NLMjZoZWFuNC9aekN1THRvTmczZ25yMko4RHhOeTVJTTNUaVhHRnpxek9Q?=
 =?utf-8?B?eHZnd25Cc3dMM2dqTGhmcHJPc01ZdU1HRml4VUlBRjVTckRkNDlIMWEvSlk4?=
 =?utf-8?B?aHhJV1ZoZzhrTXFHUGxWbzBIbmRBa3N3anljb1BXTjBQV2FENmV3VXFBNCt4?=
 =?utf-8?B?WWpLV2F2VmREc0FjSm55VnR1aTc5UDhyeTIxZytYN0ZZYTFtQ2JMLzBkckJQ?=
 =?utf-8?B?UFVpVUVJSFVhdkRROUdiM3ZtRWdQdnJYN2l5NGVoYk9SQWV1ZC9xZDVtYXgv?=
 =?utf-8?B?anVncVhQb1lIQlVOOG9ZemJ4RnBGa0g0MS9VakY4RkZwSGVVS0xYRU9aVHdh?=
 =?utf-8?B?VUtrS2d5cTlleVAyMmRxMWFiQk42eXZRT25PUVhyaERuZCtSUmFXQ3h1ZnhV?=
 =?utf-8?B?RTJ4VnNRU1Z1UHZRYWdtU3Y1dUd6c0JhK0FiNHZTVFh2TnROdnZBK1dxSkxE?=
 =?utf-8?B?V3h1Yi9mcnR3Nk5oNURrQlBEUEZGQ2pMaUVzeStJY1hjT09Mby9PQ29Ibm44?=
 =?utf-8?B?YTkwTkhtVllIVWxDaUN0bkc2ZzdXdWRRTGg2UlA5RVVFR2JuN1NQb1ZnTGFT?=
 =?utf-8?B?R3NJTjJtNG5NSlZhTjQyUHNIalVialVHUXlQVTNibkNzcUkvZ25Od0dzeUgw?=
 =?utf-8?B?L3ErbFNiWmxnQzVVYVlwdGQ3ZVY1amxlUTU1V0hGVWQ2bWlVdm40b0hnMVpY?=
 =?utf-8?B?RjlFU1M3NlhvMDR1T1NwL0h5KzBCQ25oMW9od2UvcUV4R3c5clZiYko5djVH?=
 =?utf-8?B?c3MvSXJ5TE92ZWNQL1ZYUlRERDVjQkdQNjZDUHQ1TFdid0hoV0FTcUYvWVFq?=
 =?utf-8?B?d1VDYlBWY1B0U3VFQjRNU2ZORW53dWt0TkN6dzRyTzZmd3hFRGVHR1g4YUF4?=
 =?utf-8?B?djFiaGpldGRZTHRTMjNKTHc5clNpWTdwYUNyemVhampjdEgxdzE3RWNQbUM1?=
 =?utf-8?B?eTdlcGNSUlphNU1NMjRLMzV6QlUrUXpoNnViTlZ1MjFQb0Zaemdpa3pPWjU3?=
 =?utf-8?B?QlBITy9UUU1MNUZ0TkFOdE5pWFJlRGo4K2dQMnZuTm1oY2twZXM0VmZxTVh4?=
 =?utf-8?B?NDNkWU9nemdERVB4QURHVFZmSE1sTHg5cnAwNkQ1cEZnUStwRS9EOFN5aFla?=
 =?utf-8?B?cUhFMUNnSlY1bVRqQThyeGpVRm83RWZrTXR3OXJXajdHRnpic0ViOHRLS21z?=
 =?utf-8?B?RlVJTnFpaWVSdTJLd3YzSVdEdm5DeC9lZGQ3cytoV01YT2F4bWdwdU4weFl5?=
 =?utf-8?B?ZjNidlpGSW9GNEtKSXhzRUJvT05UNjA3TzlpR0NrUk9MOE1uem5scXRLNHlX?=
 =?utf-8?B?MlJlb2ttSUsxTThtbjh3T1A2SWptcVBiWkltNWNPZHNyangxdjZGb3doQ1gy?=
 =?utf-8?B?S3hXcXpnL0hyUEo2RzgzbHplTDVEbWFhNStlRXFWamh2RXJDa0VEOHpJejJm?=
 =?utf-8?B?c3A3UkgwMEtNS0ZyZFZwaXBTL1F2WjNMNDJwQ2pHU0ZuRERYQTR0T05kT2E3?=
 =?utf-8?B?VzJPTzQzckR0WHVHMy9Cdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHRpcTZMbDUxNENUcndXeGNlcGRKanpYZDVrUkpxMjA5U0dMdm5OSlViL3JJ?=
 =?utf-8?B?VmJaTS81Ry9TbkFud21hc1lkaGxiTXhCTk9acFo3Mk1hNVMvSmdXNG40aWNs?=
 =?utf-8?B?YitIYTkyOWFpakFUeFVFNGF3L3JnZWVleTQwNWxXUFVFVnlrU1lsQXdJNUJ6?=
 =?utf-8?B?cXUxd2FBNHQ0QWtRY0FkUE5mbnFNbzZRa1NHUC8vTjdGZS9hRk5xNExXRUVV?=
 =?utf-8?B?UmhTNmhpZ2loMDAwczBjK0I0KzhOLzE0N3lWRUNnOVVJS3NTRDVyOHdCeFJ0?=
 =?utf-8?B?Y08vMVdkN1NFNUZsNEpSS2N5Y25PRTAzOUcrOFhjQ3FBTHk5aEtrNVJpdWRD?=
 =?utf-8?B?NVZtMFdkZ3oya1JXaXFwQVR3OUdzUTIzUFBlM0JPS0ZjeGhXQWtxWEZtWWVw?=
 =?utf-8?B?c3FNcFp6aUVtdzdoZ25NMU1oZkxBcWxmbXRkTDVKZmRiWXh5U212MFZML3Vh?=
 =?utf-8?B?ajkrZHpDUWNsdWtZUFVnOHBjVyt2Q0N0cHNEVEYwYjBwdmtTREJaZW9ZWlpm?=
 =?utf-8?B?S1BzUHE3aktGeVQwK3ZnRVJvQXg0Y2lCVUNWMEZzMmVTWG5YM1dabFB0aW82?=
 =?utf-8?B?YnJlUmlVUzUrNnZrNHpHRldyQkQya2RKRnJ3emdRMXQ2aXZMSUtIVWpTdUQ5?=
 =?utf-8?B?YjUxYnY2RDhPbG9tN2ZOcGZFN29YOS9PWld4MTZwdFlmUDhwWEh2bHB5U0JW?=
 =?utf-8?B?NUV5ZS80bHB1UUp1TEtRUU9KaWxGRG81QXFaSG52MlIrMzVjaEd4c1Z5R1pD?=
 =?utf-8?B?RGR3RmQ2UnNPOS9XRjA0Umo1L01kaTlUQ1JLTGtXSGcxLzFnakN4OFBEWVZX?=
 =?utf-8?B?Tm9iVXJlNWN4d3B2c20wSU9JU0N5eTVtSFdCaFFzQjhkejdmUmFIZzZnalFN?=
 =?utf-8?B?UEJVbjZ2NWJNTmtLd1RRcEt6M2U0MUN0b2lKK240dFJVNlJEU1B2SjYzeFlk?=
 =?utf-8?B?TW1DKzNJTkdmVHFzdWxsSmE3TlliTXdQNTNSZllrbngxUlhPTjljQTNEY25Z?=
 =?utf-8?B?eldoQkVIaForQ0Nja3dpMUROb2hXT0dvUkhoS1dMcWwxOTdMZzR4YSt3TlAr?=
 =?utf-8?B?KzRDNjZpZTcvNEpkZ1VyQnJTcjdLaTh4c0VINHYzVGxWS1R0MVpOVmVrR1Bh?=
 =?utf-8?B?U1psaGkyenJOOGhybDVNMmdvOStDN0trRlFNdURCclhhWHVZYzAyNlQ4eUVa?=
 =?utf-8?B?eHN4Z3NjOGNYeTRjZWZqWStRa0ZmRjFaTUlKcEJtdVIybWliTHFwMDB2TE9a?=
 =?utf-8?B?MVRXT1FtejFrOWxZVmtobVg2K3Jza0RUV1oxQXlKNHB2d1FraU5Eek9tN2Jh?=
 =?utf-8?B?Z1NTRGVEa3N4S0RBYmowZjYxSXdYTnlUNlRCQXZZc3M0OTJ4bXBOd0xBd2hh?=
 =?utf-8?B?b2l4bHFRSjc2dll0TjBlenM1eUZ4WkFXdXpLR0RBaXlHSkU3VE1IMloxNkJK?=
 =?utf-8?B?L2JYTEtoU2VXbWZSUE9oTFB3WUNZajR3MFZiaXdORFZkRmhHOHZCeW90RGdO?=
 =?utf-8?B?QzRzT0E2cHdTZzZUb2NNMDgzeGtvcmNHQ0s0YlBwakd2aTh5NDk5Y3RRTmh1?=
 =?utf-8?B?KzN5ck5RbzZ0VC9ieUNBZVVMTWJRVHpJQlVVSkxmMTgxejRKdk5pQ2NxS3ZM?=
 =?utf-8?B?dXg0czA3ckpEbWJrS2tZYU9QUXQ1S09kU2dYREdmMVM1SkRBTjd1YUlVbGtP?=
 =?utf-8?B?enZGWVh0UC9ZVDMzZ1lXV2dJRXlGRUZTTjRCcWc4WVZyTExYOE5XbUtaR252?=
 =?utf-8?B?dlIrYWFsUk4wTEpBN0JnOXJQUi83NFNKdHFsN0dIVW51NGZRbDFjZG5YdlB0?=
 =?utf-8?B?OURmQlRXK2JVWDRySmswZUJMVHdkSGRhWEdDUEMxWUtjMW12SmxWc2J2QTBF?=
 =?utf-8?B?SzZXTTRvRjZkYWZDdUlnNks1dDcvaCs2S29kbkZZZkhZR2V6eFNQcUdweHFw?=
 =?utf-8?B?WWRMaGRhUjJUT09teE9xeVU5dmZMMG5RbUlqNi80aDRkQ2tsbHFoZ1kyWU9Y?=
 =?utf-8?B?dkMrN0U3VjRISXpWUlNBK3ZYbW9FYVQrWnJFejViaUVEcG14ZzU1WitmM3hB?=
 =?utf-8?B?Y2F2R0FCUVB3SDd6NzMvUW9DNWxsWXJqSzVLMFphRmoyUVcreTdseGpnZ1JU?=
 =?utf-8?B?dUtOb0Q3QklBdjZTMzN2YWRvUFVITmt6b3FrQ3huTnpXR2VNNjRpQmVrU0tj?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb307131-3920-4afb-7674-08dcb080a5e5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:16:16.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FomMnXex/lA3EHFrWotGjthzuCtlRZbuTh8glufsIWQzo7Kqzl/nPatcQvfUORfVsdI3PubCfzQS7TXOxvZ+Bqvnz8+0Ty6+u0OMKjge1mE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7576
X-OriginatorOrg: intel.com



On 29.07.2024 17:26, Joe Damato wrote:
> Use net_prefetch to remove #ifdef and simplify prefetch logic. This
> follows the pattern introduced in a previous commit f468f21b7af0 ("net:
> Take common prefetch code structure into a function"), which replaced
> the same logic in all existing drivers at that time.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/wangxun/libwx/wx_lib.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 1eecba984f3b..2b3d6586f44a 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -251,10 +251,7 @@ static struct sk_buff *wx_build_skb(struct wx_ring *rx_ring,
>  				  rx_buffer->page_offset;
>  
>  		/* prefetch first cache line of first page */
> -		prefetch(page_addr);
> -#if L1_CACHE_BYTES < 128
> -		prefetch(page_addr + L1_CACHE_BYTES);
> -#endif
> +		net_prefetch(page_addr);
>  
>  		/* allocate a skb to store the frags */
>  		skb = napi_alloc_skb(&rx_ring->q_vector->napi, WX_RXBUFFER_256);

