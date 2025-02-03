Return-Path: <netdev+bounces-162263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32919A265B6
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE2A1885666
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F651D5174;
	Mon,  3 Feb 2025 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4bLmNqv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543217BD3
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618397; cv=fail; b=nk1eMZUGkOvzWO2sOuYVgZGpsoANzdYUvGuyBLufYAcqlb1T1656+D+MitulZrG72Jko2u7ctRZHqf7cvuSshN0aBik0FBJ34f7dYgZ5bKUj/a09051XZPCsbx374DK8L7hjfNnZqnAM7hb/3jB3+CWZ40uXlOQfG9UHaye3VGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618397; c=relaxed/simple;
	bh=8r5SEogVqg63tu76mdnBKnJ5QjgO2jpuas1uKPb86kg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qQuJ2hn5bEvvdvWpWYCYXXS8Zp70hZVEOO9lmKur5PVkh6dwHdt88LQlNgYH6fKfQ4u5PqfKw02CLGAnipwJsiFbdT2Pgc8yioWwmw5D+HcOUUdTvkCX6/VlpNmh6g0PczCB7eE1Q+AaQcEskPdySsFVQN79UXYlGJQ1rKiq4Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4bLmNqv; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738618395; x=1770154395;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=8r5SEogVqg63tu76mdnBKnJ5QjgO2jpuas1uKPb86kg=;
  b=b4bLmNqvzZbaBiTvi3esAU6C+Hw+FKMWqZ6tN5fNE8tQf3m9LxokfrRl
   Fby10a2V9082Ys0lyw4kP3m1pxVfC4cdbqmc4b/vCqfrPC6m/3dbxLBKh
   lZrbz6UKQc1G9ZQm8R1Im9oY8PS6NKhJ0haPkQoEYlxJ9BluHl5ziq8XF
   Bo6tf+6TJsge46RaNyaNANRM2pxUIChtp1cUyQub5+YVlriyF+rTxppkV
   u44I3jM5kBuDovDVqgE8rur54rGUtK3sMgn89CzeF6xoB8GQWvYd7dJt3
   RjmwMGs1IeRedLyo/6Qt8qCqf/1PyFgOihnqKjORxRRyPl//gqf/xagPs
   w==;
X-CSE-ConnectionGUID: Mr1j9u3eS5mfk2sjnFhIEw==
X-CSE-MsgGUID: z8pndNFqT3SGZiyDFD2W7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39032209"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="39032209"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 13:33:14 -0800
X-CSE-ConnectionGUID: 3VpY1L33QCyoGPLvHUrWcA==
X-CSE-MsgGUID: Qg7RjolXRKiKVAce1FWTxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="110350754"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Feb 2025 13:33:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Feb 2025 13:33:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Feb 2025 13:33:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Feb 2025 13:33:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe5p2JnOGAsM0iJeKon8wv5X+uR1JBXXWp+b6BR9D6uboIX4I+m92f96ujBqlUYLSM6yqGcHOZ0NH/nw/1B37GWvQnJ9cSIL6K2T8BVbd6jzlDCZ+RhIkwat5UqCOBOOQP1keGy4g89BV6DLIAnynTdvUCW7HOrUlpJKsO2AM2AVLaM7Gs/TPQ8VI1R+hhpAczj2Na1KKZHmpkGxV0dq8BydTfgizAlWl6mV85jvfG1KsUQHjgdFiBUwshiwLpT8VpvGukkOELZq6psQ/5tHqhsB38g7+kBAAInSeh0lYLGuRFJY9MZAiivR57z3IUj/jhS3CACegej9Y1TpvW1QtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdUetqasO4DvEFDhVJtQO5K96kdGVfXD+uMMUs8dHk4=;
 b=vkOSTANEmLjVJYh9r3aFJpf79Qo8PESWKer7NEoP1FP+p701va9h/BWc/rM7iGGXBJ9fajgYmB9bdm+2pzaNNGkdS3Tv0m7KPRbsmwvYQtYTUnhJG4yRPBh4jXznSo+VIMHEl/IzUeAPrsfHc1hRRRj7J3+06GjegpXu8Zn1uZc9MgRx6lIOlbeuqzp5haE+82mAJHakEzpq+HN2IvP7IiH3sPUSfS3umvpbFKmLvi4kWxCbrRsTHq+7W1Bo7uNNABlMibWh7dLDhbBpX78um6tlEVBYvjkLOyaANSxhaKE7xNon1cv1bVJRyodx9Ogj2ZcPow1+0m4chiRcLoRpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by DM6PR11MB4660.namprd11.prod.outlook.com (2603:10b6:5:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:33:09 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f%5]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 21:33:08 +0000
Message-ID: <34b3a581-a64b-4518-8aab-1f7640c74d56@intel.com>
Date: Mon, 3 Feb 2025 14:32:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/5] net: napi: add CPU affinity to
 napi_config
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <andrew+netdev@lunn.ch>,
	<edumazet@google.com>, <kuba@kernel.org>, <horms@kernel.org>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <michael.chan@broadcom.com>,
	<tariqt@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <shayd@nvidia.com>,
	<akpm@linux-foundation.org>, <shayagr@amazon.com>,
	<kalesh-anakkur.purayil@broadcom.com>
References: <20250118003335.155379-1-ahmed.zaki@intel.com>
 <20250118003335.155379-3-ahmed.zaki@intel.com> <Z5KkEF-2NiX4SuB_@LQ3V64L9R2>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <Z5KkEF-2NiX4SuB_@LQ3V64L9R2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:303:8e::21) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|DM6PR11MB4660:EE_
X-MS-Office365-Filtering-Correlation-Id: 615ee88d-ca56-46a2-9616-08dd449a5a41
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFJ1ZWZWL08xQUJYa2hPRkpJQVltUFdGZU1wWUJTcTVBWUdIZGhBTUZmdTIr?=
 =?utf-8?B?ZklJQTNzUVYvSmNhZWNlVS9Kcy96WFdaNVkwRU9Ta2lpZ0J6N3RwdnNocHY2?=
 =?utf-8?B?NFZVSzJPM3IrVFQxN3dGcTh2RzNyS0tnRVg2bEV1WlQwc014bmplZmVjdXlK?=
 =?utf-8?B?eklsMlNGZ1EycUxVcUkrZVJWSzMrUUNMUG9PeGJPSW5JZjk2U0tkOFF6T0s5?=
 =?utf-8?B?d1VlcnA0RXRuZVNnUHU3Q21XaThlekllYldzaVY5QzN3Rk50NUtxZFZ5Sksz?=
 =?utf-8?B?SUt3YU9aM25jeFBERU5aR0paZzBEUHJ4WmZHQXY2YkR1U2ozM1lVbEp0VGN1?=
 =?utf-8?B?NUZQS054eU1Wc3gvdWFpdEhXMmI4NVd1YjQwcEhzL20yT05ENDNvNk9SRUtt?=
 =?utf-8?B?NEZKamRJVzVxdXc3VVJyL0NOL0VWbENrT0w5ZDUxMEcyeGZWK0F1SThGQnNy?=
 =?utf-8?B?TVFJNU9VclFKb1MrL29LdSt4TDFSLzJNY3Nhd0tYVzN4ZU4xQW9qbE1OVWVp?=
 =?utf-8?B?R0ZsdU9LVHNJSTNEWWJNNWd1RHdobC83c1FMZVR1YS9DTE5YWHU3L2RZVXMw?=
 =?utf-8?B?M2hHLzlXbm4zWHd4MXRLMFIyTUN1THhTZ1VqZjJEKzhFZWdMZkt2UEMzUyt5?=
 =?utf-8?B?QkREbDlTZktjSEdUdW1XYk9lcHg5cUx5cUtUMzFaaDZUUVc3RmVXSnN6VXA2?=
 =?utf-8?B?a1hreDFwdEQzU1NOUEhya2FndzlvWnk5cmJQa0pmR0UvZHlHei9OVDJ1dWto?=
 =?utf-8?B?QjJMZTlSeUx1YzcrdDd4VlJhakR5cmptL3BpM0VRK1NWb3pMeUZHRmNVclJH?=
 =?utf-8?B?cDdLV2ZBckxmWVExQWkyVkpqSXp3b2RsS1g0N0cwV2FBaVl0WENUYkQ0NWVN?=
 =?utf-8?B?ZFdSeWNMc0JTVGJQWlpRMy85UWtURHRWdnFCNlhZVzB6Z2d5VC92Q3A2Q2Ew?=
 =?utf-8?B?TkpIK2pSQ1IrTU0rWUdqb1JQZmRBZjRwS05pekFEcU9zVmtSRmM1UU55ZjNX?=
 =?utf-8?B?L0hOUzRqcmhYRDArQkEvUmMyc1VTVW81M29mMWowTEcvaW9oOUh1R3pDTXRT?=
 =?utf-8?B?ZzBSeHV3ZXlZTU9TRmdlb2UwQTRVcm16ckNHaUgvWXNCUy9QeXUrN2tDelN6?=
 =?utf-8?B?eVpuVDRzcTZrREh5b0hNdnUxaC9tbXFLaW5aREt3L3UvQVhkTHp6c0lwVU5L?=
 =?utf-8?B?T0dqZlBsZ1Zib0tiZ3I1OXNqaFNwUjMyK0puUTFzdkQwT3Z1MWd2R3RPRW9n?=
 =?utf-8?B?WjBhbThnUnFKYmdhVGVxamVsbnUvbTFWeC9BRGJPd0RMcUVmbEh4VnFCOFAr?=
 =?utf-8?B?SldxQjcwaURrMTZNQ1hmTy9tYjBnTXFGc2thQlRGTVRsdktaWWsvaGFOdTBE?=
 =?utf-8?B?d0JWYUFIUUhEV2lUOUtWVXU3MEFldWk5U1Z5cS9OQlV2MVVPRzYvYmNaZjhq?=
 =?utf-8?B?ZHhLaXgvRmVyVHlzNUhnVzVYbU0vUENvazRWc2Y5Qjc3SVp1SWd1RFJaMjB1?=
 =?utf-8?B?OGlyUlgvQWhoWnJCVitXaFpBY1ZSalRWTFh0NTZIOThndThPT2QzSnNtRXhE?=
 =?utf-8?B?WEphMUhsZ0RHdE9WUm9xRVpQTEhpejlURUlmLzdZcm9ZaWtIeE1UN1hVNUJ4?=
 =?utf-8?B?eXhrckIxTHlMMzJVMS9JbTBtTUN4ZTJKV1JialJ1Z1d5azNRd1VoWlZ5MlJY?=
 =?utf-8?B?eFVROThFRXRZYmpmbkg3TUZkWWRXRit2NndudjVaWlVvcU50WHVLR0JTSU1M?=
 =?utf-8?B?NVQ4bTVIOXNWcXhydWlrc0k5V2hpblFXSFFXWnh4TXNPYW0vV0RmeVpLdnNr?=
 =?utf-8?B?UTNNT3FtbDEvZ3p4N0pTY1d3RCt1Y2FkWHlkb1RNSERWSGo2bTBURjkrK2Fa?=
 =?utf-8?B?V25jUm1SNzcvYlJvVU5FSm9sNSttWFBDYkkwSGxHbkdhVjMvRHhTQUcxS3ZE?=
 =?utf-8?Q?eHxJ3QEo8lk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3poTDV5STVWSC9QUkR0NzExYmE0Z1JOdERVaXdNekRYMFNENzdvRHk4ZFVF?=
 =?utf-8?B?MER0dXJCdjY2ZllDUDlGQkdSRWI0YW1DRzliMlRrbHRwKzBhTnVHMnpMZE55?=
 =?utf-8?B?a05XeEgyWCtLM08wZmQzTUdzc2hxU0ZxcklWZkFRZzFiUWF1VlpGUGlIbi82?=
 =?utf-8?B?RldsNWhNaGkvTVcxUUFmN3pTbERkQU9Eajg4TmxDdlVSOGJDWHliaFk2TlU0?=
 =?utf-8?B?WWprcExFaHlKTUtyQXRvOGxVdGoxUE9HTzlmZUxqUFltTmRHYmowMUhpcXVP?=
 =?utf-8?B?SmZIa0FPT084eUNkdWxRYmhyUjk3ajJDaDdqS21JcTdpYWpCOUc4Qzl6SWpJ?=
 =?utf-8?B?ZithOVhzVGRxK21xaC8yZEZKdHNBM0Y0cHlmc0VYcm1GbXZFbjh0NEdmN2xZ?=
 =?utf-8?B?SU41ek5SUVJXc2pUVi9rQW15a1djdEE2eEhtd0xSY2k4VDZ3NGhMdmE3SDZz?=
 =?utf-8?B?WGl6dWdGOXUrOWM2c0pndzRWWmEvQ2R6SFBEb20rVC9ybTVNbGtmWjUycVE3?=
 =?utf-8?B?UFQ2ZCtOM0Rrc1BLQU5DUSs0SHJ4K1pSbjFsN0tyTVRsT0ZwNjRiZkZPQ1lM?=
 =?utf-8?B?MkdKVE9DUlhYL0xTT01KMDNERW9hMFpuQ2RIdXJNcnE3V0c1MDN2US9SK3lN?=
 =?utf-8?B?Q2NmOWUwZHpUVUdCWk85VExEUjh5cFBZMHB5Y1RDTEtWNXRQRHVCTnZOT3Ri?=
 =?utf-8?B?SXBZWGlrYnFYakRmV212QVpmZGdYNWUwZE5YeGt5NjEyeU4vK0ZxV00zQ2ZH?=
 =?utf-8?B?cXJManNOdkwzL1dmc25DY3EwK1Y3dTlpQnlSZGh4MDNzdXEwaUFSa1VwM3ls?=
 =?utf-8?B?dUs3Q3lhcTdKdC9HcWNtSndmdjA2TzVsNktsUTM0czZXRElCd0xlZm5qWEZB?=
 =?utf-8?B?R3RSZnlKc1FUZEJNYkhWQ1FqS0FZdVpjTHUycmRjSHJJY1NtcHBkQ2NFYUZl?=
 =?utf-8?B?U3hEQ1VOTG1VM3FFWEhHY01VWUI1WFVlems4YVduNUhKeWlxRGFRMDdTNDVE?=
 =?utf-8?B?U3I2L3Jxb2ZrTnVtZ0Q3enZ5NFdsL09yRkhYcDZ3YkV3bCsxcU5UZUlYOUFh?=
 =?utf-8?B?cjl6Q1JYVG01dVgySUxsR2lGcjQyNjVoUjJiRHpTOUUwdEZXVjlpVkpONUhG?=
 =?utf-8?B?MGFkZFRlZURHbUZCeURDb0lxbHJCK3A4WWw5cTd6bExocGUyMUZvcy91TU04?=
 =?utf-8?B?MitnNjQ3ZTlTL0dIck5LZDlhbVdOS1hCR082aSt4UVg1TXh0b05zSWdaOGxq?=
 =?utf-8?B?QjFJK1NnU0hDM2FmVWJBdzhqWDFyQ0YydURFcC84bWxxMzdhQjF3K1BpQ1Fr?=
 =?utf-8?B?OEpxTElqSFBxeFVndURTWjk5WEt2ZlBRQ3FIYVhvSHRvUmoyam1ibXNDV1dJ?=
 =?utf-8?B?bVpDem1sdkF5L0M5a1NiQVRZWlFIODdUOHRSejVoRGNId0FucGF6Y3FWQk90?=
 =?utf-8?B?SHpJL2NGNDFmNU90MjVLOGxYUE5iWHNEeE9VeFJReXI1ZXBOSTd1WDBTaG1I?=
 =?utf-8?B?VElsRXFnUjBic2pybDVaTlFFNnI5ZDVNL3Z6bURtSVlQWG1UNHAvY240UndQ?=
 =?utf-8?B?c21ycmQzU2pRR1ZCNGMybFZlcWZBUmhpcEdBS0lWZ1R5SWRnS09kUjl4WVFX?=
 =?utf-8?B?ZkJhMThTaStNTXRiN29UMUFTSURxQWlxU0RlMlBzTHhyVVlXVy9lN014Zndk?=
 =?utf-8?B?TUhCUThNbEFGcTlvQll6NHRyZVRKRTlXYUF3RVM1OHJJYTdWZ1RpMldvRlFr?=
 =?utf-8?B?SFBSL1Y4VHpyS1l2S1Vvamk3Qng1L0dmV1ZPWFlPcHYxWUx3MzZqeDJZQ2t0?=
 =?utf-8?B?Z2dwdDJOMng0UTR6RlhIVDVCdG5mQk9sSGdLZm52ZmI3TWFWeksrWGUyNERu?=
 =?utf-8?B?SnlCVS84RktkUmFkNklGV0dJa3ZaREdHTFF5UklxZCtRUkNPYlBsTTFEbXNF?=
 =?utf-8?B?VkovcXF5U0RZQ1pHRTRiUzZrZVVvYmhvSUpubm1SVVE2M2R2NWN1dEppRmVD?=
 =?utf-8?B?czBKcWNUQjRIQ1MzdW1BcnNuZ1o0TUJtRVdjV0xaZlJnSEEzUDNoRXB6emxT?=
 =?utf-8?B?QnhHRkw4bUcwbjFReHVLWGhwQWFIVGg2RUd3MURmSU5EYmRBdlo2UHp4TUhC?=
 =?utf-8?Q?WTNYGhcS9LTm7TsN8QozJKXNn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 615ee88d-ca56-46a2-9616-08dd449a5a41
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:33:08.8806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DD9XtZTRKI8ZBPd1yKEkPVUOJG47qeeKEdsaqkfU14dXxOvp7ZLrRyt1T9iCnhmOVCeIEn0JnrXMEaZX6fe+3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4660
X-OriginatorOrg: intel.com



On 2025-01-23 1:18 p.m., Joe Damato wrote:

Sorry for the late reply. I was pulled into other stuff and next was 
closed anyway.

> On Fri, Jan 17, 2025 at 05:33:32PM -0700, Ahmed Zaki wrote:
>> A common task for most drivers is to remember the user-set CPU affinity
>> to its IRQs. On each netdev reset, the driver should re-assign the
>> user's settings to the IRQs.
>>
>> Add CPU affinity mask to napi_config. To delegate the CPU affinity
>> management to the core, drivers must:
>>   1 - set the new netdev flag "irq_affinity_auto":
>>                                         netif_enable_irq_affinity(netdev)
>>   2 - create the napi with persistent config:
>>                                         netif_napi_add_config()
>>   3 - bind an IRQ to the napi instance: netif_napi_set_irq()
>>
>> the core will then make sure to use re-assign affinity to the napi's
>> IRQ.
>>
>> The default IRQ mask is set to one cpu starting from the closest NUMA.
> 
> Maybe the above is helpful to add to
> Documentation/networking/napi.rst ?
> 
>> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
>> ---
>>   include/linux/netdevice.h | 14 ++++++++++-
>>   net/core/dev.c            | 51 +++++++++++++++++++++++++++++----------
>>   2 files changed, 51 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 98259f19c627..d576e5c91c43 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -351,6 +351,7 @@ struct napi_config {
>>   	u64 gro_flush_timeout;
>>   	u64 irq_suspend_timeout;
>>   	u32 defer_hard_irqs;
>> +	cpumask_t affinity_mask;
>>   	unsigned int napi_id;
>>   };
>>   
>> @@ -393,8 +394,8 @@ struct napi_struct {
>>   	struct list_head	dev_list;
>>   	struct hlist_node	napi_hash_node;
>>   	int			irq;
>> -#ifdef CONFIG_RFS_ACCEL
>>   	struct irq_affinity_notify notify;
>> +#ifdef CONFIG_RFS_ACCEL
>>   	int			napi_rmap_idx;
>>   #endif
>>   	int			index;
>> @@ -1991,6 +1992,11 @@ enum netdev_reg_state {
>>    *
>>    *	@threaded:	napi threaded mode is enabled
>>    *
>> + *	@irq_affinity_auto: driver wants the core to manage the IRQ affinity.
>> + *			    Set by netif_enable_irq_affinity(), then driver must
>> + *			    create persistent napi by netif_napi_add_config()
>> + *			    and finally bind napi to IRQ (netif_napi_set_irq).
>> + *
>>    *	@rx_cpu_rmap_auto: driver wants the core to manage the ARFS rmap.
>>    *	                   Set by calling netif_enable_cpu_rmap().
>>    *
>> @@ -2401,6 +2407,7 @@ struct net_device {
>>   	struct lock_class_key	*qdisc_tx_busylock;
>>   	bool			proto_down;
>>   	bool			threaded;
>> +	bool			irq_affinity_auto;
>>   	bool			rx_cpu_rmap_auto;
>>   
>>   	/* priv_flags_slow, ungrouped to save space */
>> @@ -2653,6 +2660,11 @@ static inline void netdev_set_ml_priv(struct net_device *dev,
>>   	dev->ml_priv_type = type;
>>   }
>>   
>> +static inline void netif_enable_irq_affinity(struct net_device *dev)
>> +{
>> +	dev->irq_affinity_auto = true;
>> +}
> 
> I'll have to look at the patches which use the above function, but
> the first thing that came to mind when I saw this was does the above
> need a WRITE_ONCE ?
> 

Why?

> The reads below seem to be protected by a lock; I haven't yet looked
> at the other patches so maybe the write is also protected by
> netdev->lock ?

All functions are protected by netdev_lock/unlock. Except notifier 
callback (netif_napi_irq_notify) which is protected by the fact that all 
napis are disabled (so IRQ notifier is removed by cancel_work_sync) 
before the napis are deleted.

Other nits are OK IMO and will be fixed in the next version.

Thanks.

