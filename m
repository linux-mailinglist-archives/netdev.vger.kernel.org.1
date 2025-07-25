Return-Path: <netdev+bounces-210215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F28B12641
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319AF1C26A6F
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 21:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6C23AB94;
	Fri, 25 Jul 2025 21:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCot1aMV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A0205ABA;
	Fri, 25 Jul 2025 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753480041; cv=fail; b=MiVOvA04BiVGn02jO/nEYhGa3NV8AZVIacvZxRU5GDXLbL9MG3dCsNsq/pRbOSzoEJNdiOzHBF2ZLqAi+EdGlyb2kWfyh6sN0kA0+8I4Bmj1MmLWxmxVIj54rufHqqm4Rok1WSb9t+n8JlIiiFsourGIMcQ+BDuEtMX9MaxK9ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753480041; c=relaxed/simple;
	bh=q2QDY2gjMFFz61lUN3Uhsa+cRu16+Pc6o3plPjFF+CQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ZF/451WUvdvnfBQQoX76+s8SNa6pJiLvU+jKpYPFftaCOAPVqel3ql+qkjX6qS9AB2OaK9tMZEUSBBjm5QSZ6fszHnNDHOf1ZxR+QJwWpjRPOAYHV7K3wlvETiaWlZ7jlZ9J117oAPtzSa+DXIe43biIkF+7aXLuu0tm+SPwE7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCot1aMV; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753480039; x=1785016039;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=q2QDY2gjMFFz61lUN3Uhsa+cRu16+Pc6o3plPjFF+CQ=;
  b=PCot1aMV112qKdbYfC8+0wGFjAAoRqUzHLGL91cZxNZgrmheOAJWl+MS
   2oRYai1vRrMBmv6va8ZKkZJKaIyTrQP3eA8N8Eu1yaUH/c3YiDrcTB+ye
   29sh5nwHDCKCPSiGqTfi+XHE/a6LDdbxv0qsQVbnJNzXOtbv49Zl1+XAS
   bZrzYi/9dkyHHwNjekCRLBwuKoB17SLeBu9HKjuTMHzGfB/lZOIieBzCM
   hRLZdA3GAfQKLzWbBMcb/+WGyH0PDOsLoxQ9eYeKgM5U2uGaUil6+PxJ+
   uQpB25mY8XAPdygP8QOpC7a2tAGvCQIDhOXivACMa0o7RRuOIDd7FrMIS
   A==;
X-CSE-ConnectionGUID: /YFAHH5XQ82aIRkzm71Vow==
X-CSE-MsgGUID: EbgsPzowRRqlJkNlW3Rvrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66518507"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="66518507"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 14:46:58 -0700
X-CSE-ConnectionGUID: tOfazydaRkCd0iWTab/N8A==
X-CSE-MsgGUID: ZYGCOxrbS5WyRni7gpVwIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="165304873"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 14:46:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 14:46:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 14:46:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.53)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 25 Jul 2025 14:46:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvkCfgrdlHo8mvClxDh8zkdhzE+UP8wgDyzOaON5j0h4nZcViSAAE9wB09Zt1MNw6R96Z2I9fb+F70rbnncj3yiRijiZr29n0/myov5xI6EsygVaAQqr4q8q4YNkHzhq1fnaHYTUHMsEBbhVma/nATkv8RqeqUQLLoQ7mR4Z3xK2n5UV5VX6Wa/cmsOPsnMOo0blaH84vVGQnKydQSSoRASpuy7FKDYn91C3WBI5qsYE5OZSxxzcey3QUTtxAwe9AALJ/bVSx5wcu4traMJ/FPMO5AjY8biNckYUirZ9JpBUr0NYbvRCqk8bu455Ux9WzwuywJAII4Aq1VmrIi4u+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yw8dQZwrdf4VaiuPmRrJEnTDX8WjoK6sRz3oZ6ZPRRY=;
 b=K3h8rkEVQzNi+lX7W8prMW0by2meCR1s3t6m6FoQj+5datqBoU9M3oWwGeTjzCLrVlQgEooI+vSMKWnMgOZ0qKAx0755Mx/kdnom1TkCQq2MnXZJ5nw1I+XFjpnFWYJDf7yutCQcBiAY3SIjb0FA3l8NISVMFLn3TSQ68tKTSoLeUg8JYd+M5CmfmzLCKB945SoFhVtLghIWs8MIP8Fz8Ff5pyQNC8bzIrPMvVuYgUmg5fHEqLQW6SVO0tlOmcz7Ibq67Y6d6IUM0O8gW60ZzMxbXi2J1BLzRyvLzWLwFXSMa1/9lO8/yeFQfMUFADc8n8WIzx+S/8p+11VnZzwQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPF195D11F0C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f0c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 21:46:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 21:46:52 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 25 Jul 2025 14:46:50 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>
Message-ID: <6883fb4a46aff_134cc7100be@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250624141355.269056-2-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-2-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v17 01/22] cxl: Add type2 device basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPF195D11F0C:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f80a32-641b-4238-2d55-08ddcbc4c42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cm1NMnlhQmZqaW54SjdScS9XRmF0NEdCN1oyODh2bnBmQkRwTnRTUWNONS9l?=
 =?utf-8?B?Y2pBcHNjYU1OSEQ3ekpLaXJIOFVkNFJRNFRwaWd0eXpXK1E1TGhrbW1ETHk4?=
 =?utf-8?B?SjdlV1BRazkrNEh5N2FIT252M3o2b01xMUdGZmtXdkh0Qytsb1lISi9hdHBM?=
 =?utf-8?B?U0YwRytIU0ZXekhCWUdpaUxpSHhyQmx4V2hHTEtrY2YvM3RqOG1hR2dqcEVj?=
 =?utf-8?B?clNaRTFyYmZBMWMzRGpDQjJacGR4T2Y2OGtGN2s1eXdFOHRPd1M0SlczM3Bp?=
 =?utf-8?B?NE9OUXVBcDB5dGt1eXR0Nnh5ZlZpUlpyZjRNY3I1K1VwOWZXaVlXajZrQXpi?=
 =?utf-8?B?cEpIaytqaHJjYVlCT3MrbG5yakcvWHlFblhBazE4eVdrbHZrZW5jT2MxWnBL?=
 =?utf-8?B?QTNSUTVqWkJLbkNweHBWOWdxd3FYN3UzN2NPQy9hWTNqektrTjhEOVdIZUxj?=
 =?utf-8?B?UW9zTUJ3Skw1d1lqOVVUdi83WkRtNUx6azRiVUNwMERVTE9OYmFwNTFHY2Fj?=
 =?utf-8?B?eWloL1gva25DRG1NS0ZUNVFZaHJEV09JWmNPNThDS3pMYmNVTHNSR3lyWHBn?=
 =?utf-8?B?dEVNTXN1TzdmcG1UREJvNlFyNG8raVZ3WVB2Z3NBS0dJbGE2bGVtYVo0Mi9R?=
 =?utf-8?B?RGo3a0xRVUpJMUtueTRFczVRalYyNDMwQWtDcndxb2NJV0tMcTBjNzlUU0M4?=
 =?utf-8?B?cUlEVmlGVzZXbWZoTDV6WmJGUm15MWtXcUtzZ05QVnhveWdic2szcjdRd3N3?=
 =?utf-8?B?aVU5NVNUWElFUHU2VmNicEIwQVhHNmVsaWJTU2JpbndoTlZxTm1CNTB4UEtp?=
 =?utf-8?B?ZEsyN2NCZ3hRYkRZL0t6R2piRklSdEJET3p2WTBBY3UwTWNTaGxERi9QbWVY?=
 =?utf-8?B?Y0hBcWVWMUpPM1NDckxWNmkzamF5ZEdYeVNEbTZLMDZZSTFldDh2K05lclgz?=
 =?utf-8?B?c0xPVWhvdjh5amdmWFJNeW1zeElpVGlUcjNvZlVSVmVlMFpBdWtZd3FEM09O?=
 =?utf-8?B?OHZTVSttVThyaGpuQ29zaG94UHpuY2Jub3grdkE1L2JibEVUbDRFQTFZT1lp?=
 =?utf-8?B?UTRWV2JaL1ZQYUhOcFByV1JHelM1anowWEhQWU8rVTEyaHUvay9XdWVVVXNY?=
 =?utf-8?B?ZXYxcURCZ2RGcE9iRXJjV3ZBTXh0Lzl0NUlyU04rZlQ1VG5sZGR2UlFHWXo1?=
 =?utf-8?B?cnZuRFBVQkpUTU5sRGFub3ExVGtKWUZvS1MxaEozRmxwN1FaVFJNVmRwR1F3?=
 =?utf-8?B?d3h5TXBQN0NvK2F4SWptSXZ1NVdqRnhzU3RuNWxlQTZLUlhDZVM0b3FKSzla?=
 =?utf-8?B?SGJva2pRWHIzNGwvc3dMdUZOUENCdi9aMnUxWDc0dEtqTk4wWjRhWDU1bktC?=
 =?utf-8?B?c0VEaGkzUm9yUS9ublEyYmtHWUJUWFI2NUdpUGRNb0FXT3RnVjR2dmd1R01D?=
 =?utf-8?B?R04vckk4djNVRjkxODQ2b29NL2ZYNG4wZ0RrN3ZYZVc0V2hYSWwxbDBYM1h3?=
 =?utf-8?B?RGFkWno0ZVdwdGhFNC9PLzNtNzVJWHVlM3lnRzFPZ0NocFNNdGpDcWx5dmRi?=
 =?utf-8?B?YmRucWx0N3AveHNoUDZOWTFSZlpHaU02R2hISUhKVmlHeTIzVzlnbUVHZU9I?=
 =?utf-8?B?c2Y2V2F6VkRGY1ZLVU00ZnkvKzZBMEZWVld0U1ArVWVQOE1JNzhVTk1OZHJG?=
 =?utf-8?B?VHJpTW9Ba2ZyR2NWME9WRmEyazlWcTZrRTlSblZVRjgyT0dUd3Z4dFpnYjlE?=
 =?utf-8?B?K3BnTFdMZEFUemZLT250R0FTTVpNNXI0YVZnOFZXWmJ2MGFBNDZKNHNxbi9n?=
 =?utf-8?B?a21hL1BvOVJkaTNBYnpVQnBKWUhQVjhIajdZYWg3MU1xQmtRVWpEVHJ5VlRI?=
 =?utf-8?B?WGV3cE5jYVVrSm04ejF3V2pyMStyQ0hic2tvS0ZNSHNQeFVSQTVyR1Q3RzEx?=
 =?utf-8?B?UGlwNlZVUkNsSWd5ZDlvSmwwdUlzTXEyRE1GV2JCeFlxSU0yRjhxZ2FTUEI2?=
 =?utf-8?B?d05EejEzVEtRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2wzWjY2cmYwc1NTTkFQNDFWVEVnRlE2TWZPUTBKbkNvdXRsaVcxRkNUVlZU?=
 =?utf-8?B?NGxUekNRRlg0eUpsd1JpSGtsNzBzS1cxOVJUa1ZTWm16V1BzS0xvWHNGclhj?=
 =?utf-8?B?VEVKWjFFNmwrTjdRNjFtVUV6MWw1c2N4V2YySUdqd3RiRWRNWkQ5bHdnYTQ4?=
 =?utf-8?B?cW1MRjJkY2txb1E0RjFDNE1QNzhzMUFtQ3hDdU5GN0k4SURMWGZ4RzdBaWcy?=
 =?utf-8?B?WUVTbGg1b2lSWmE5elZiNHVEYjBmdFNjdUZJdTVQWStIUm5CWElMK2owYUlx?=
 =?utf-8?B?cm1UYUpUVzdYbGN3eTBydHlYc3lZbTgxcUI1eCtsQnJhVTFidmZ1Vmx2WkJE?=
 =?utf-8?B?MTlmZkdFQ21HeG1nYXVqVWNzNnM1OFVUMW9tbStKYWphNjAvNlZBUUk1a3Ex?=
 =?utf-8?B?RSsrNXhVWEE1d2RVWlFEd0lBRC91SWVrZS9sWk9Zc0hVcGZRdmxsTkdVOGtr?=
 =?utf-8?B?S25aQzRZRGJIWUlTbEhaTmR6RE51Tm9UczZxdXp6bURYQVh2SEozUzZVcWNq?=
 =?utf-8?B?MXJOeW1WenpuWjhKdkZJRnRrR0tSSVRtY1dIbnFKMVNmSGJ2b1lQSDF3SGRm?=
 =?utf-8?B?SnB4UHVtdjJ0dklrQzEwZEI5d0RMUXVGaDV1ZFFjZG1rQnBGdDNGdDZaR3NG?=
 =?utf-8?B?QVplR1dXdFQ1akxwaERrTjlrUmxBZS9BMmtTZytqbzBQN1VSNit0dmhBSGRq?=
 =?utf-8?B?WXRhMXZWSWhkWm5OeG5LSGEvakxaOEIyZEl4Wm9DMWlSc3RtdGoyZFNzNFZi?=
 =?utf-8?B?VGZmMnZRN250eFJpdTkwZXRBV2p0SEYwR2FSQ01DTnN5YWhtdmlnMmtwSGhC?=
 =?utf-8?B?NHhHbGF3ZlhsZUQ2dUYrblhPMGVabHlSWDE5ajBVWjBudjZCT2Z6a3l3SGxr?=
 =?utf-8?B?bUtJNWVvZWEzOW93TnVQY0NCRCt3Qys4d3VZa3BTVlRnQVU0SStSVjJCSk1u?=
 =?utf-8?B?NThoRDBCSVgrQzJ1Z0tXcXRTL0FNcDA3REZwSFF5L1dvc3dWL01zajZlYk9P?=
 =?utf-8?B?eXo4TC93SFYxaDl3VHRLbHRSNmxJZ1dXZGtQZ0FCdTN1ek9qS2Z2SHFRWDMv?=
 =?utf-8?B?b3hHWHB2WVdUZWhFUmlSMk1ZTWRHaXd3M3dRd1FjSkI0V01nWWJ4eGp5U0xI?=
 =?utf-8?B?Y2tSTzkySTd3eDQ4R1JKTjZGbUNMM0hTMm5Kc0MzanZCd3piemtnSE5aYTRx?=
 =?utf-8?B?Z09GVW94NldvYXlGVE1LbGV6TXJkeUhGY0xKM3BQYlZvdXpIZUQyaTZ6blFi?=
 =?utf-8?B?cnNsWUhOV042amZqLzhaaWpWNnJDTHNhak5PVmt6Y1hrVDEwS0t4ZzI1bkh0?=
 =?utf-8?B?RTNIVS95NjJ1YmVRUERqQi9XYWxvR2ZOZy9LQis4Skt2emViRlYxK0gvc2J2?=
 =?utf-8?B?U28xK1AvN05zT0dpVnJxSllFS2hxRDh2bklKY0tIMTkrbHREZ0JmM0tVbmdt?=
 =?utf-8?B?cGRQR2pRRzMxcVZNaGJ6NS9QcDF1Kys1RFd3UFR6YmJReTVLS2ErdWMwU25P?=
 =?utf-8?B?NkgrNjlzVGFIcE5YT2c1Vm5pYk5kTDJSbDJWa3NqY0ZsOE1ITWk4MWc4SkU3?=
 =?utf-8?B?MGE3a3JMSWk3ODNueS9RN0VtenNGVkQ5eGlLMnRiaTlKZllXemJ3bWJTY1FC?=
 =?utf-8?B?NUdnN3lLMkg4UG5MeS9TejZPWkVxVVE5QkFpamgrZlp0a2JlNmFFM2MrVlJB?=
 =?utf-8?B?Sm5ZeUNlamRvZ1FHZ0pUcmpGZU5DdkxObms5MU4xVU5GNkw5TXg0ZERVdFdQ?=
 =?utf-8?B?OG1WanlCRlU1TGdsNjd5ZUkxc0lRclU3cDNWQmVnc2dxMGN5dzVCSHQ3S3FF?=
 =?utf-8?B?VmhaeVgwY2U1NUc2eXkxN3Y4ZHpvckhVV3E1RDJYekZMcDI5NGZwQm02MGgr?=
 =?utf-8?B?M2dRZGpBaFNQdG9SRlNwaWE2aE1aNnN4Nm5JendEVElqbWNscVh3R0JxM2kz?=
 =?utf-8?B?cTFubUg3YWJuQnlDSDlmQUlSTTQvVHI4Y2FlVVU5aXVZMWJuZ2hqZ01uNy9h?=
 =?utf-8?B?MVBGZlpVRURDcmdqY1NIZ0NQVDFhY3lMV3ZkZVU5YWJCSWlYZ0kvM2FWaFV5?=
 =?utf-8?B?akhkZUNJcjVPY2M2RjdWbHVsNHNIOWJqT1k3cHV0TlU4eFAxYlFwVndDMW1M?=
 =?utf-8?B?dFNjWUZoMzdPUUtxWnJjTFdYeHVBak4zNmtrOEdpTjZWbVh2OWZZRlVRdVJP?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f80a32-641b-4238-2d55-08ddcbc4c42d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 21:46:52.3509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwNw87E4loHRdVEZsI0Kni5DYjPLOe9lnUPlVt2J+/jXfRxBXyfRZqpvSPvUoNXTGkc15jb1+un2wo7aPTklZuELaqmUGPrltaUkwssA1pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF195D11F0C
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state and a macro
> for helping accel drivers to embed cxl_dev_state inside a private
> struct.
> 
> Move structs to include/cxl as the size of the accel driver private
> struct embedding cxl_dev_state needs to know the size of this struct.
> 
> Use same new initialization with the type3 pci driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/mbox.c      |  12 +-
>  drivers/cxl/core/memdev.c    |  32 +++++
>  drivers/cxl/core/pci.c       |   1 +
>  drivers/cxl/core/regs.c      |   1 +
>  drivers/cxl/cxl.h            |  97 +--------------
>  drivers/cxl/cxlmem.h         |  85 +------------
>  drivers/cxl/cxlpci.h         |  21 ----
>  drivers/cxl/pci.c            |  17 +--
>  include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
>  include/cxl/pci.h            |  23 ++++
>  tools/testing/cxl/test/mem.c |   3 +-
>  11 files changed, 303 insertions(+), 215 deletions(-)
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h

Thanks for the updates.

Now, I notice this drops some objects out of the existing documentation
given some kdoc moves out of drivers/cxl/. The patch below fixes that
up, but then uncovers some other Documentation build problems:

$ make -j14 htmldocs SPHINXDIRS="driver-api/cxl/"
make[3]: Nothing to be done for 'html'.
Using alabaster theme
source directory: driver-api/cxl
./include/cxl/cxl.h:24: warning: Enum value 'CXL_DEVTYPE_DEVMEM' not described in enum 'cxl_devtype'
./include/cxl/cxl.h:24: warning: Enum value 'CXL_DEVTYPE_CLASSMEM' not described in enum 'cxl_devtype'
./include/cxl/cxl.h:225: warning: expecting prototype for cxl_dev_state_create(). Prototype was for devm_cxl_dev_state_create() instead

Note, this file was renamed in v6.16 to theory-of-operation.rst,
git-apply can usually figure that out.

cxlpci.h is not currently referenced in the documentation build since it
has not kdoc, so no need for a new include/cxl/pci.h entry, but
something to look out for if a later patch adds some kdoc.

-- 8< --
diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index d732c42526df..ddaee57b80d0 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -344,6 +344,9 @@ CXL Core
 .. kernel-doc:: drivers/cxl/cxl.h
    :doc: cxl objects
 
+.. kernel-doc:: include/cxl/cxl.h
+   :internal:
+
 .. kernel-doc:: drivers/cxl/cxl.h
    :internal:

