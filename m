Return-Path: <netdev+bounces-126804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89F4972933
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1671C23DE1
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B44170A15;
	Tue, 10 Sep 2024 06:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+cTVsGW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF541386DF;
	Tue, 10 Sep 2024 06:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948059; cv=fail; b=CWLr4G/0AR4RpweFIxk9MHhHMJYjwQxgmmC+svVjS8DoWlCG2mDccDGLrVqqcyJcfCTITzhqY9qVHtjFl/7gbptdzv4Wef2xI+L/wJn5d9UzE4uL0R+H3bULrTVmM61V4mugl89MJJvjLwA1II+oV9JTZ1qVEirj7va6opn8dTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948059; c=relaxed/simple;
	bh=CkfK0sufK26Df82IgxPjJoyjBkHw58D459sg/+O5Ayk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hfAIySIX35ItnTy+ChjhZpeYD0ZFkjVipzmRzeAOQUTu+THaove0CbpfLLYyswGVpiaS/Hju35wq8sptUpt0jDQDqP91p2pBXsgfVtjKB42mpBcERuTR0J/UU5BMPTxWt3KoClpu0liaxyMHPAxx3j6NsdRCLjU7/i0cgbBcPD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+cTVsGW; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725948058; x=1757484058;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CkfK0sufK26Df82IgxPjJoyjBkHw58D459sg/+O5Ayk=;
  b=E+cTVsGWG35CXI4hNEjGOzlxEKbhsMNfah2WNSFtdXdXn8Y3TWU1ov+i
   oWp22WDkQxbvdZjeuFKf40O37JRXGxIDjLgzmAB5wGySaCA6wDV/gPei5
   utzW1/3Xy7Q+5RzbdRhAXlHXUhZ0LdTKOg4Zzq9nodtECItrn7AtdiapP
   LOFzGfI/9Exm1a8TindJzrUdTiPgKBAhlpYhP5dj6uf35pM0f+42ld6Ct
   VYjs5drg5+uUgw1KuNDJCzI2scFQpI9UYetl9vmjkQDM/QBOcBZPKRXZZ
   MsrcezL2ozaZ+08zr5MK35c3KY9wR30ENRUJnKrnNgapOITnFkifedHdO
   g==;
X-CSE-ConnectionGUID: q2NTH+mNRGiYjdxG/8QK5w==
X-CSE-MsgGUID: BkAMRQy4QnGyu6fC6FtqqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24175708"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="24175708"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 23:00:55 -0700
X-CSE-ConnectionGUID: KpTSFPfaRquuwZgJ0fKTEw==
X-CSE-MsgGUID: laCdtSlWTCaQRpL/v43WgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="67659415"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 23:00:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 23:00:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 23:00:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 23:00:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9C6XCfChHYseO6wV1bP6lN8WAX53zqpR+MCchhEOXCSnOcf+uS/PmCfYmofAZiFXnBkzjMii095SOYux0wJ8D/IRXbuJrR1xUkTuWE4+MlNYLjb2gK+DOAWx3hs48anO7zyFrwEf3rmaGcxz8pbSey9Sxn/Cc9HVyCJuic7E/iDHNpTYoJDlRYaPh5cRoDsT7pq1ujqSyf576FMp9/AJTECwzJ0V18udh7tMWZO9gacgVVE1icZp8c6yY28VUoaAgu95X/vm0i52NbLVeRe9+2cUZjPj4frM50j3Bqdf6FXGoSKbczaBqwa7RnfAXpNNqpju1x/wlAHg8ZiQPKXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9yE6PeROqGITXI/GORkpPqCHtZVh1TpFMC62fDj+h4=;
 b=phxj/8cgODNyYLnc6uulfIXdteyhcwkZsCsxCYxIrfmZ1VOL8WbeoZLB2D5/vEw9r1LEMboXOkDsIsf/Edlsyu4DF+aTxtb3qh1k5aq5dbic154b9G0vNzsTFIYeHyKCVZvAPGrweL5YZnJ+QzKtuRQrZKURdWR5ds8IS0C2JJfCsN/SkCkr4lyHvuoZ9gHYm4dIh8Z1iI/QpFpId+ga6RTgSTSfaInXvBovTCeTPLznLZUnpIdyG6smkylDMEqSAcLoY92wpLCzrsudFqIz7UiPBuAf8NTOwbclWZZsq0PhIMJ1Cqiva1NkrLxlbBMvBbjZu/Sa2hyDfhz6mFuDpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by DS7PR11MB6222.namprd11.prod.outlook.com (2603:10b6:8:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Tue, 10 Sep
 2024 06:00:49 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 06:00:49 +0000
Message-ID: <68878cc6-addd-47a8-b6c7-9baa141a8b86@intel.com>
Date: Tue, 10 Sep 2024 14:00:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/20] cxl: add function for type2 cxl regs setup
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-6-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240907081836.5801-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|DS7PR11MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1dfbc9-4763-4e62-a2b1-08dcd15deb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjZrcEJaTFpNVWIvTkZhblUwdmJYUWovY0xIMnlNakdHS3pwSDZacUlBakNG?=
 =?utf-8?B?dEJHYW5yNXRXUE12K0p4RStXUjlXUklWWGNFNVRCUDJBUHZjUXRUTmc3Wlk5?=
 =?utf-8?B?LzVETjZkck1lNEV2T3JkSlBKb3lPbzZOb3BwNEo4TDFXbVJ1ZzFnMG1tYU9W?=
 =?utf-8?B?V0c3NUFzOXhMMnBZeFZBWjlUYlg2dWowZVpIWDNYZDIvbkJlUDVvcjFXRkVo?=
 =?utf-8?B?Vmwwd1JmSGRSNWlnRkl6WmJhMDl5cVRnMHNNb1duWTl0a0hLWE12WDliVGR4?=
 =?utf-8?B?MVE4dHVUZDRHMHgxdUVCMVBqU0E0ZWdDcGR3UkpBaWZMNjlTTmlhSGx3VDJK?=
 =?utf-8?B?MmhXWlVFZVBXYXFtS3ZYd1BHdU9sS0drdkJKdjRPcmZmL2R0dkV3SEpBZXBa?=
 =?utf-8?B?Y2N1am9oSnVMM1NIN1ByOGcwd2lmRXo3dzFIUitkVm5OWFY1QTUyVDQ4SUk4?=
 =?utf-8?B?WlNhQXB1TDE4azU1VHdlSXJnL1NFR29KdFlMMllGSkQwK3pPVEl6VkhXbVR0?=
 =?utf-8?B?dGhJSEErNVVMVDBhMm9EbmZ2Zi85WGhNZlhzWFQxZFRXclB6Yms4Z0NyL094?=
 =?utf-8?B?YTViRHdwVy8xcEV6NjB5SytlaUJCOUpCZlpiMDMvTHlHTzduRDhURUlQVkJo?=
 =?utf-8?B?dm9sMGV6T3dYQndsLzlraUJZWUdWMDIwZ3dkUXlkR3p1Ulg3K2FUU3UySkkv?=
 =?utf-8?B?TzJzUFJmaUpEVkFMY0ZEdkZFR1M1VmFFNEVEcTRyRnBZRTJ3MS9UR1luQjUy?=
 =?utf-8?B?TWZ6YjA2UDJJazdCRk9pcktLcS9BRjJmelB6T0VSU1N4SDlzY0FVcnI3ZEJF?=
 =?utf-8?B?eFN6MUFFRU5taGpBZTFVRlNkVTVyOWlHMzVaWXludGhkRzVKcmRwdGQ5UmZK?=
 =?utf-8?B?ZHRNUm5Ob2ZQc0MweDlseUZQSm5uZFRuRHhhd2NWYjYxZm5EOGVCMmRxYkcy?=
 =?utf-8?B?VWxIYXR6TVFTcVBIWTVQSGJsVHpZMWNBT3ppZmdNZFBGVXRqajJPVmRFQk45?=
 =?utf-8?B?QWgwaHlCcmpXQXp4RGdRM1U0bGcybEZUMzNJK2N4bDE0VFlOV1E1Nm04L01s?=
 =?utf-8?B?bDhtR1p1bURXZDA5S0hHZE1lSTBHSVErNzNyeVR2RlJ1bWhicWVTVURodFhM?=
 =?utf-8?B?ZmpEbTZzR3NIRmVzN29NS0xFUkE3RzliU2l0cDczdjV0WkNXYkJwK3pCNXhX?=
 =?utf-8?B?OUtRNlg0V200eVBiS0p2Y1BOUUFtUjQ0NXZQY3hiY0xzQjYyUDVMR1RPcGJk?=
 =?utf-8?B?UlhteGcrN3A3SG9xMGNaRjZ4REdYbCtvUDdPSXRPZU5rZmI4a1lzcVpXWWZI?=
 =?utf-8?B?blJxTWM1d0dqNGVOK1ZQYkJXTVlURXFQNDRFSmJjZWtZTGJkb2gwb3ozZUZQ?=
 =?utf-8?B?V3lTOWZaS2pEdGN2cmg1ZzJseENJaDZkQjR1NDQ1RkpRK0phOGNQVmdxN01V?=
 =?utf-8?B?Yjh4ZFprNkpiTm14VjFSL2FMaXJ6bHZYWVJjRFJ6NjJwK1UyR2xVNk1PYndH?=
 =?utf-8?B?ai9abFlUQ2QzZjA3RG9WVmpKUnZzQUR6MzVxM1R3d2lHSUlLRmVqVUl2OG5N?=
 =?utf-8?B?aHNDdXNZZkk0OE5pelg5eW5XQ21vRjRzY2E0ZmN0SXAvd3VNN3JGeEhJdEhF?=
 =?utf-8?B?WmFkQ0ErYUs4NUNicDA0ancxK1ZaaXRobzcyTitVNGdYSXY4c0JzRkxFOUtv?=
 =?utf-8?B?M3JTQVJMcXhQOExrVWxEVEllR0J6UUJkdUhFR1hnWVhpUE4wdzhhMm5oRDZJ?=
 =?utf-8?B?bmhuSDRQVlVDU2VlY1dvYU94YjhHRFR3TGlHeGljRUN3T20yNFpDRGxtWFhT?=
 =?utf-8?B?cTJ5Y2xmNERmOVNRdVQ5Zzl1ZTBCMjR1Y0tuaVJKK0R3eXZ4aDUyc3Q1OHNM?=
 =?utf-8?Q?mMswECjfGuO+v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aExqWHlEU293aElidFY0OXhLR0UrRXFick1WV29GTDYycGxsdGJvSlVSYzZr?=
 =?utf-8?B?S3krRWRvRG51WlVlYTJkTFR1WW1MLzFpbDVzbTlUd0s4SXFiS05xOXgzYnFY?=
 =?utf-8?B?SGdEUWRKbXdSYWJiNDVEdnkxY2NFLzdRV3NLVnNCWTgzSGdtSktITjl4YUtG?=
 =?utf-8?B?bVFuZU1ZbFpsZlRFKy81OEUzL3YyOGFQTGtEczA4TFptcGluZ3hLYThmWVdT?=
 =?utf-8?B?S3ZsRWxzWjdmeE4vNEIvc2s3SjgvUDJZcGlBQXEvemM4bi9PbFRtNkNiL050?=
 =?utf-8?B?Mk1FTTQraG15blo2bVFCdW1QMFRzVXY4c0RQQnZmS0toeDFWWjMxOE5Hd0Mv?=
 =?utf-8?B?SXpFckhDdllrSWFOTm5qOXlpRitFS1ZybSs4RWhlOVNTc2dNUjVSSGxoSDUv?=
 =?utf-8?B?ZzludWFiVXdTeXVzR2VXRjlGK2QyTnRmZTJvdGUvZktPSlJXRVZkMVVWbytl?=
 =?utf-8?B?TG9xc1V2RS9EWWFEWlF2Z0cxVFhjY0lBaWJvd1UzelUybUNMT3YvaVlFcU43?=
 =?utf-8?B?Ny9vdXlJYXdENGZNb2g2VUY0SVNWTFlrL1dvQXFMZmZyWkhmMkJLdnh6MUVr?=
 =?utf-8?B?UFVCbUpRdzl1Zmp5OEN3c0FIcEk0cFJLeVdGSnhEWS9wSlJqTW5qU1M4U2kx?=
 =?utf-8?B?ajJrK1dEZ2FZazlwSXpFeEJGb2tFdXRqYmltRWV1SXYwV2lobW1xeGlBLzhp?=
 =?utf-8?B?M1kvalIzMVZjY2tTVWMxTWdDZFdYT1VtM2NwYnF0dk5zcm42OTF6UG1FaWRE?=
 =?utf-8?B?bktiR2w1akNvYWJ3NTdGQ1ZYTVRzd3d3MldKRytld2dxb2ZubjdWajJLdkds?=
 =?utf-8?B?RDVscUMvUEVPL3BuOFlMbGdVUXEzayt0emVDT2hjUkVsdmpVblFnK2hIcEF1?=
 =?utf-8?B?WEFQK2wweUlxeVRTeFNZUXFkRjAwRlVFL1pQTDlPUFVxMU1LWlY2M3dJanBN?=
 =?utf-8?B?U2phMGxrNFBoc3RndC9UUTl5UzUwVi9CZE15SU84MmY3TCtUdUYweVJqZjZT?=
 =?utf-8?B?M0dVT0NEWlVqWnF4S3BXd01NcmxvTkVyT3FTOW9sR0JyM3JETEdpQWQ0WHl2?=
 =?utf-8?B?SE8zUnZsaFJLNXNmQ3JmWEd1UEVvU0NHOGh2QmUzUCtJdU80VzRnMWlxSzlJ?=
 =?utf-8?B?b3h0dVJNY0x2a2dqZUI2WER6aFVUdVBkYkx1cXVtdTE0WXBuSHhseC8wZWhH?=
 =?utf-8?B?NVpNZ0tRL1lTM1BNbmNjeXRzNSt0SmlCdk1GWnhJMlYwL1UzUThFSHppcE85?=
 =?utf-8?B?THc1Z0dpM204YzlXeVJHcTZ0OWNNNzJZRFJaL1piSEpwcXN0VjRveDd3dHgy?=
 =?utf-8?B?WDkxc3RLMi83R2RYRnlYTFA4THZ4L3RGVndwelVZRlNDTTZBZkpOekhHSDQy?=
 =?utf-8?B?dFhDVkZJK2RtV1gwcGJkTEJheDZVQ1MwNU1qMVMzTzRCNGpVK2lPT3YxajJY?=
 =?utf-8?B?UUNCS1FJN3pyWmRhT0FLdkNoLzlrM3pCd2Rkams1VjE0N2pPancvdng4dEFa?=
 =?utf-8?B?ek5VM3IrektBWWc4TngzUW5HNjV2Ly8xS0RQMkxqZmJUQXdxZ0FEZ0Fkc2VD?=
 =?utf-8?B?VWNuMWNMUitpT01nVUtHUXRRVkd5YzlYbEhoOUZHOGYyNzJnYXRSNW92a2tV?=
 =?utf-8?B?UUZJMTFtYy9hKzNNUFNIOVVhVVQwMTVreU5BYjNlTnh3VFRsbTdoVlFzS25j?=
 =?utf-8?B?WERpTG9MV2NmbU9mOHlsSGRYekxidzE0bDNWSUFHbC9qVGkxRTEreFFiem5D?=
 =?utf-8?B?Z0JOUWFxcU1PV3dBcGdjVS9kM1VnaENrM0xHM3M4dlNRTEJ3eXFjbi8rUUQ4?=
 =?utf-8?B?L1VCaEltS2p1MmF2T2hZQk5IcTNyc0hPVW1GU0p2UmQ4ZSthMkN6SFF3UURP?=
 =?utf-8?B?NHZSN0JzZUtkN3JjRWhZUXR5cEdwTi83U3VxQW4xLzArbGp2bjN5VUl2VUQv?=
 =?utf-8?B?UFdKb3hEUEZybnlaQm9aenM1YnZnSDhvY3lsTmlwcGtSZEtjck1tZGlITzBk?=
 =?utf-8?B?aHFua0Jzcy90aGUwazBxbTdsb3B1N09RUENXRGtsdXJNOGNhRDlyNHJGUXh2?=
 =?utf-8?B?cXJkZFVlN05WMWtMY0lZZTBZZUlLdEFWQVJxL01WekVkLzB5cjZtOHE3SzFm?=
 =?utf-8?Q?AdRgjIEtu7URcWkyU0FVQb+f2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1dfbc9-4763-4e62-a2b1-08dcd15deb20
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:00:48.9797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yq3eoJXnQeSZyzsFmislvgnm1rvfUxfjb//aeJvWKrqnFIxS/jxeljGExK/lQXtxSF9wBIKYdJnlHWNR+P5+Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6222
X-OriginatorOrg: intel.com

On 9/7/2024 4:18 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> Create a new function for a type2 device initialising
> cxl_dev_state struct regarding cxl regs setup and mapping.
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c             | 30 ++++++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.c |  6 ++++++
>  include/linux/cxl/cxl.h            |  2 ++
>  3 files changed, 38 insertions(+)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index bf57f081ef8f..9afcdd643866 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1142,6 +1142,36 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
>  
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_register_map map;
> +	int rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				&cxlds->capabilities);
> +	if (!rc) {
> +		rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxlds->reg_map, &cxlds->capabilities);
> +	if (rc)
> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> +
> +	if (cxlds->capabilities & BIT(CXL_CM_CAP_CAP_ID_RAS)) {
> +		rc = cxl_map_component_regs(&cxlds->reg_map,
> +					    &cxlds->regs.component,
> +					    BIT(CXL_CM_CAP_CAP_ID_RAS));
> +		if (rc)
> +			dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
> +

I thought this function should be implemented in efx driver, just like what cxl_pci driver does, because I think it is not a generic setup flow for all CXL type-2 devices.


>  bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>  			u32 *current_caps)
>  {
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index bba36cbbab22..fee143e94c1f 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -66,6 +66,12 @@ int efx_cxl_init(struct efx_nic *efx)
>  		goto err;
>  	}
>  
> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL accel setup regs failed");
> +		goto err;
> +	}
> +
>  	return 0;
>  err:
>  	kfree(cxl->cxlds);
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index 4a57bf60403d..f2dcba6cdc22 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -5,6 +5,7 @@
>  #define __CXL_H
>  
>  #include <linux/device.h>
> +#include <linux/pci.h>
>  
>  enum cxl_resource {
>  	CXL_ACCEL_RES_DPA,
> @@ -50,4 +51,5 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  		     enum cxl_resource);
>  bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>  			u32 *current_caps);
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  #endif



