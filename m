Return-Path: <netdev+bounces-185648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F16A9B329
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F51661BF
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B149727C150;
	Thu, 24 Apr 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjBEy+CM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCC91B4227
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510266; cv=fail; b=o07yUVya8r1sWE/T6y1pblaRa2eM24YcmY8smQvlYogA1NcTjEYYBbiSXqZYMJWRcV+jaEGV1uZrx1lku2EvboIZf5cWKOewU3Ot0oS7TBGUoK3YwuGO9/1pHsyC4DrqA0M6aLg/sbDQgUisb+UZn4jtL7hwnPsfFGudw32FxoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510266; c=relaxed/simple;
	bh=1VDuGgPlVLDw5Bgp+SDN3swHcPgRsCUEv6B/GX2GkBY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uPgaKP4yOt+OgcoA8/skn5T1FVa/datHy58tL8zRLTDtUF4n50PFZAtRM3hahr5DBXh3LXg+aJWMjlEkgFM7/9gExMnODrJl1ND2DrMVawNCD2yfxVY+sDJEvd/uugjebDwyBn5SGPXQECbAbTDqyBM/u02cBxhfL4Q4TN+N9as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjBEy+CM; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745510265; x=1777046265;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1VDuGgPlVLDw5Bgp+SDN3swHcPgRsCUEv6B/GX2GkBY=;
  b=MjBEy+CM/74d0ixcvRMnbgJGOQ7w3ndrjH50tAe/BaErxoyreH7ZPmfp
   tFGTRNM6JxRTlryrwcECI4acOeeM3qn2+EkXlvh47vlhyrWwBhKJvnPlO
   xyLN+d4WUMnTKRegqyr9eIoXpgyBkR8LW1j1r3Y4M2tdk7myoqQQzs46A
   yHEIVZHOwcOQ9mkE9636uCn1ZF7K+qASAZtJUKPH7PmwFWt5ZGoWB1CrN
   wNo4QioD+K4nBqkmbMRW3pmEIxgsULPrQRYhBjI2UQsqrK6T/aJsYRg/S
   if2SATrXVTzXxZafGfX0oLUeid/XJak3YlT8iXdoigRzPIoL2o+fJCMmY
   g==;
X-CSE-ConnectionGUID: v9jHMUBUQjKKlVMdXyStYA==
X-CSE-MsgGUID: 0UW1seX0QYuMpXLFaXEeTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47289823"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47289823"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:57:44 -0700
X-CSE-ConnectionGUID: 9+Q0QGLPTGKhS5mR2FKteA==
X-CSE-MsgGUID: k56YsNY/SXOoS270yXPXEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="137457090"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:57:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:57:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:57:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:57:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zg9b/Oh4BaTda/rb8Og+xOV1JRDWLT5C4Xo4f5pEYk3tK5BH98CNc58gHOJi7cqBVwJWFjpXWWA7qd7Ibk5Z95fUGU+ZdUklRibxVZVYaK49BzYCr/rAoWPVxJPSsV7WqickaOTBAiDwGaJkgWCdTPsrMutsbdmN1BdQT7xNTN6p8ZiSW1Gkc/yyecIyQKakR1tgxdtOt/TkxkqvYYOtYXAiV24xEQzA+Gew1Q0uYGu9LNzSWHuObdYkBToEB32OJP3AbUpq85mQB+xFcgDb9kJ+DWToYrW7OikTivvkh1nifMPj3atC6kkzga1/4LWTSk+QiWiQzDE5PcSKTJJrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYB7maX4JoyRDgwbjJ3T125RNo75YtDzR1rakmX/XtA=;
 b=D9SVgjjHziT+RkYZ/y8srR+LoQUI/ul0/IaeZr5mF59df0n/fX3q5d/uk2UJxvvlmDyi1Mc2XKumZ0nabdf9ncjhlEBt+8qHLhgh6imy8fHuEAE83w80+S0c2G4yYa7TpD3jeHwFAHzZNt0vySvIeMLNg3inY9ULs0U4YPzGUEUCYi1SOq/7RqJXZxmyc72iqVx4FU0fGyOYswxuEmVTuOp5vsaJmw65hbM7zoXrQoLi4snRcEdWzjNFDDWJ6dhKpswE1WWLM/WgMD22zYlyzEgzVTWofaYxLbHQu4X3aSQhHzGryWurqYQxsJNGmW5pqAWf8ngEKY/bAz7riwCzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by MW3PR11MB4586.namprd11.prod.outlook.com (2603:10b6:303:5e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 15:57:38 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8655.025; Thu, 24 Apr 2025
 15:57:38 +0000
Message-ID: <4edcea4f-4e0f-4b07-8c7e-e2116ea8f207@intel.com>
Date: Thu, 24 Apr 2025 08:57:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/12] tools: ynl-gen: array-nest: support binary
 array with exact-len
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<sdf@fomichev.me>
References: <20250424021207.1167791-1-kuba@kernel.org>
 <20250424021207.1167791-11-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250424021207.1167791-11-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:303:8e::28) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|MW3PR11MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a893376-be1e-4d48-7917-08dd8348bc5a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OS9IRTJjLzVQcldyMDhodEFhdnozSzNUNUs0cUVYUGI0VGt0SjBCcHdoaUt2?=
 =?utf-8?B?N3FyMXpxUlNqYVFPUW5GWEZhd0RWMlN0MWp5WUtUZUlheUFEWnZmWGdVOHZY?=
 =?utf-8?B?d08yK2NNY3BLVHZhRytQK1oyQUJVYzhxQ2hjRnJWdkNyOGM2V05rTnZ4cWN5?=
 =?utf-8?B?N0tnY0FVRStCMGEyeDM5QTA2cTYrSXh2aTlMNUZ5NnhaTDRWN3kxeUphZFdI?=
 =?utf-8?B?U1YzMXJKMTFsbWZvdmU0aHE1RE91SnJmVHZpOHFsbDFEQUsxUU5uS2hSY2VV?=
 =?utf-8?B?NW12RTJOaXlySjVZWWV1WWczWjVjM1ZGNzZtbDVZc290bW1wbjZ0Snp3eHF3?=
 =?utf-8?B?TmFCZk1aaUJQL0xuYWVCV1ovRHdCOFpDTlBiS0dhcDY0eVpSbm0yY3FHYVhl?=
 =?utf-8?B?ODNBTkVSdEpLSDFjYmN2NTI2a2FxeHhzOFNrcXpaM2dKZ0tnL0ViYWJuK2tW?=
 =?utf-8?B?VVIrUWExcWdHd002NUszUlg4R3BRS242K1NNcHo4RzdnNlVHTloyNHZCbThN?=
 =?utf-8?B?U3lNSUdVb2pMVXR5eXhjRExhN05VcnBMMC84UHlFckhMY2gzM2xVUG5Balhn?=
 =?utf-8?B?eHVNSGhDM1pxZnZIVFpYb1RZdnlVeGx1bk5uaUNBU1BnUTF2R25zdWJBRDc4?=
 =?utf-8?B?NE1xNHd3RU9CaXJ6VUtNR1JaUWN2S0dpUy95NjdlZlAvQ29YYVA3bjlYZnhS?=
 =?utf-8?B?cTFHeEc4NENnckVKa2FiMXFaQU1DZ01CNnUrTHU3clpZV284dDhxenZqL2Yx?=
 =?utf-8?B?Y0t2d1hCUTBLQUJtRTVtb1hsTHdDVlVPd0d4WmJ3ank1a1JGWWp3WWg2SHd5?=
 =?utf-8?B?SjU0MjYwRjh4L3lDTTdsTHFweDlpWk9ycEdBbVlxYUs0QTlNaUkwYklyZytB?=
 =?utf-8?B?SDhQUjRkQWsvaVpWRmF3UFd1L3ZWNEUvaXhxRC9QN0pLZ1ZTNzhBQVJnMy80?=
 =?utf-8?B?ZmF4K1NBVEhnU1Z3L0R0T3Q5SXdwT1JPNkdvb3o3Tk5oMEl2R09WTElER1pz?=
 =?utf-8?B?L0FvaGJ2SjZKUGdZVllhelVWaXUxTzdxMUI1YmZ1Vm9iNE5tN0MvUklNZ0Zp?=
 =?utf-8?B?UFFBbVhWeGVzK0d0T0JKaFBFbzBMU3ppWUR1bTE4dTNXME5WUHpOcDJrMU5r?=
 =?utf-8?B?cTBSQ0hvRXUxTDVIajN1ZmF2TzZ4REllbzRvNDBpQmhhMmhLRVJ5UDQ2elhO?=
 =?utf-8?B?SHl4Q2pjMVArZmVYZU1OdEJhTkZsU1ZDRFdCcnJtMzlSY0Q0Z0F5S24zOWpX?=
 =?utf-8?B?Wis3NDVNZTdxSm9aVGc4ZzBxbGVDRGVFbHUvMjZDb05WYTNkci9maUgxYjZh?=
 =?utf-8?B?dmNLL1RxaWdsWWc5MGJvTGx3clR3Q21TY0FPMFhValNKa1Q2eU5BL1V4NHVn?=
 =?utf-8?B?VkpMWFBTZm5yekw0UDRnaVR0MlVYM3BCSzk0U2NpQ2U2empueThjUU1nVjIw?=
 =?utf-8?B?QWwxK0tzR0VNUVBVTnJDOUpQWEI3bDh4UzR5Ty8rcXRiandWaFJLcUJicy9G?=
 =?utf-8?B?VmMxVllhTEZWd3ErUmZ6YnFQYmtmd1YvcUd0YmtXMWNteFltaURxUmZZeGNX?=
 =?utf-8?B?dkJRcGJlSHhROU5UcVJrbUxhcHNGcDNwd040cUhYMWVET0FocGtVUWJTcGFa?=
 =?utf-8?B?MVBTY0xSbVIzaU9YS0lYbGlVNzZmbEVlbHEwQm5BSTZnell0OUg3NVhzL3FQ?=
 =?utf-8?B?Tzd0ZjAxbmR3MHNhMDIyRllwUmxpemg4c0xIVHErWXVkZWpjb3FxZmlheUt3?=
 =?utf-8?B?VGZnUE1XZWlteHEvVW1pQU1BUldrR2RLcDZLWXhURVZKMWtwVEhoK01vc1FK?=
 =?utf-8?B?MDZlSUt4MG9xMmp4VjZVN3lWTXBtdzBKaHFkTEZLK0RQQ3NrQTVqaXpGZEFx?=
 =?utf-8?B?YWM4a1N3bVNnNW9yRS9ZSEFNTlRQWTR6Y2dpL3BnYXJhUk9iL0hQck1ld2lu?=
 =?utf-8?Q?Wrfx8fH6ezc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0tNekRxK3Ntc1ZMRStPcVJSa3Z2YXdTeTZHL2hhS0svZlVrMjVGVTg5SGdu?=
 =?utf-8?B?TnhkbFRGOHVZcmlGZm1aWnJVeW9LR05rbXI0dzRIOFpUMWlkZTBVYnprTVZU?=
 =?utf-8?B?V2EzUmVGNGJsOTNYSHBESFBHclJtZ2ZKajJHM3BVKzdRTUl2T2EzRnl3YUZw?=
 =?utf-8?B?bnlCWnNvNkEzcE05cW43VEg3dk1JWDBFZWppNHlLSVlpRkN6dlhYY05qWllr?=
 =?utf-8?B?Nnd5WVFQcEJEZVErR0N5dVhRQmkzeW5DSGRKTWFuMVlSdDdZWVdRNWlmVlpX?=
 =?utf-8?B?ckt4bVRDeFpDSE9IVkFHUzBGNnlxWEVWUUQ4V3V4a3lKVk1GR2pxd2w1aTBJ?=
 =?utf-8?B?enpqS0xxRlN4RDNNRjl3c1N5V296emVkbmovRjgwcnNmMURIVitjcTJrTXNZ?=
 =?utf-8?B?UkpzbEJXNmxNU1NpY3dLd0NMY25YWnJaVDN5QWdMU2hadTl2RndscXNORlQ1?=
 =?utf-8?B?WWJLaUYvWW5tRTF5cnF5WjFpWUdnYTM4MjdJSHVCcndGdUdMYnNvcFkyZVdW?=
 =?utf-8?B?NjZuYXoxWFNpR1p4eTZSeWdVMlpsUDU2aUNQaHdNSjgvbkx0WjFwS1BzUHdU?=
 =?utf-8?B?eTlpcW01a1JtdTlXb3NxYUtTS3ZsYjdlcnByS0xmTEUrL2YvZmxrRUFiaWxS?=
 =?utf-8?B?OUR0U0VYWENHR3FFNW56MHFOb2NRYXEzQk51VUFFd0ljN2xEWHlUUVRMdHJL?=
 =?utf-8?B?bTZHbFlHN2c3VnduNFFkd3Y1K05ydFlkNjROU1VSR1NsNTFocTA0RzdMbFFl?=
 =?utf-8?B?TGEwUElLZmFzTmlndHMxcFVkNi9hZHlhZE5QczlDa3ZhWk9CbzJRS1ZZcWx3?=
 =?utf-8?B?aTllNmNXTzhLajl3cHhpSGNJVklFVmxscFJiWExhWG5CMDhTRllqUzhybU0v?=
 =?utf-8?B?YWVtNHFRWFZ2c1M5bi9mK084RmxBVTJFQ2xVTnVxTDhza0ZjbG84aktYT3p3?=
 =?utf-8?B?SytXNlVTb1c4Sk1mWWk5SVFRNFZEV216UGM1VWk0MDRtODlZbVFxWHZjV3Jk?=
 =?utf-8?B?ZGMrSXZZUDJiN1NXb2dTTU9NTS9xTWZGUTVMRlVxMlJMVjhuOThjVWNJTmlr?=
 =?utf-8?B?RGdGQXhvei9ZanVCY00xcW9uZVJTZHhYTTFBYU5ZUzJEeWMrNkRudE1xTVJ0?=
 =?utf-8?B?UGFwbzhyT3NBcmNSa0FMRE9sZXdUUWkwVDB6R1gwUzk3UHNtZC9KT2Z5Vk9i?=
 =?utf-8?B?ZHdKY3grOFpraEZhUy9pSjYrazV0UStjTUpaTWpRdjBRK3o2TVBicWYwSks4?=
 =?utf-8?B?bC9iZWVRam1FMVlDS2hUV05UUkx5WUNhS2gvS3VlWkRCdXhUdFdUWURKb3V4?=
 =?utf-8?B?cnFVQmdLZGtPdmxnWnI0YXBVSVVJcHJqRWZkTGNUUHovMG91U3hnbjVHdVdk?=
 =?utf-8?B?RTV2U2dWRGx4SDV5Y3RGUUtnUVpqYlRIZ3I1aWg3ckEvTXNwd0NDeDRZWkFN?=
 =?utf-8?B?Y2dvcFBzb3g3U1N1TEc5c0tOOVd3ZkFRWFl3VXJLV0R2VldhWUhjUkNiamRD?=
 =?utf-8?B?TlRXQmhCMTNsNEUrOE5xaEZpMm9lRksydkRZaHZibTdPSVVROHZLeUlSeG4z?=
 =?utf-8?B?RGJES2UwNW10ZFV1VFFHWkQ0NTFmS0lmcXJsQkZTZ1Yvb2k4K3ZEY2htbXcx?=
 =?utf-8?B?Zy9qVFN2KzVscW9sd2xxRDJaQ2I1dmpQZC80bVlSWXloaWNBZjRJelBqUDRa?=
 =?utf-8?B?Y3Y4QklVVjhTdzRoQTk4eWxvbGNxcFhFWDdLU2IybmRhK2s5eE4rakREUUtF?=
 =?utf-8?B?MHYwUE1lN2t2d2ZLZ0hkL1c3NTBqMlUwUkF6bXlRN1BOcDF5UlRER1V3OFZu?=
 =?utf-8?B?WGdHVEd5ZE5lVHNuTm9jNVByUlVOSlFDTStXTFVObGdMZlpVV2JuOUwxTElX?=
 =?utf-8?B?U29TYVFSUFpsTHE5clN6cXByN3B1Y3B1SEx5Qnd6TytlR2pCMW01cTlIb2p6?=
 =?utf-8?B?dWVhM3pvbXd4dU5idG45RzZ1eWNBOVZYYnpFaTZQdmprM0huRk51SzdQdjEw?=
 =?utf-8?B?QVlJRzFVUi8vT292VW45VzcvZDBMRXVEeXZxekxxVlpHaUxXUFpheHpVMHUy?=
 =?utf-8?B?UmpNbitXQ0xMdUExRlZFaUFEM3FWbDI5Yk1tTko2YitLQ0VUSm9iL05NTTZC?=
 =?utf-8?B?YjdCQmlnSkVVcjMreGZadCt2YlduNFBib0xiTXpkamJoamd6RCtYd0JKNmVy?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a893376-be1e-4d48-7917-08dd8348bc5a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:57:38.0156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LXaBLbIOH4oWqXtxqCvgT8UJAUO1pz+kp+ttxu8b8dVXTLIz5WPIks6FyyN5fsCtggNhfwkjzhPxIdOO/+s8zNwjth1PQxMwU7FseSwk4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4586
X-OriginatorOrg: intel.com



On 4/23/2025 7:12 PM, Jakub Kicinski wrote:
> IPv6 addresses are expressed as binary arrays since we don't have u128.
> Since they are not variable length, however, they are relatively
> easy to represent as an array of known size.
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

