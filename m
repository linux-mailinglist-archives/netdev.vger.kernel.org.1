Return-Path: <netdev+bounces-157855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A89A0C0EF
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 177C67A124B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F59C1C5D6C;
	Mon, 13 Jan 2025 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5G+k0LB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3921114885D
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794856; cv=fail; b=C4NSNrRDS1wofhQ4mIvBUv5HqKOLpAXZ37gVZT8HxAHMDwfLRsWdtR2mnRhx6LhxhshVWth6ad0jeULK8PsVE2OR8FrCcKdzRAVJKTx1XR87YjvYwddEfXGvTD40SWHXCOpYFBhExwh6z3Nkav1GEh5akXVZ5E2mt2fKkqmtz80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794856; c=relaxed/simple;
	bh=DtvECfx6P8VHMWoV/kPWPELGA0yCirySrC3kPTkjvzA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fJeNrs2b9OMa2gnjBk0pqt+4wVwhDpjWCcK6WLS5YDUira+21VIh2fiVdNQcoJ5fopustO+1S+vIRm5j0TpBoLZj0U+sETd3ugiExDIGtts+9OR/ppdH53gRXbODfSQfI6aHASDUwFwKL1/1SpMeX3I6kDPLt/kgmQW32dSQXSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5G+k0LB; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736794854; x=1768330854;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DtvECfx6P8VHMWoV/kPWPELGA0yCirySrC3kPTkjvzA=;
  b=K5G+k0LB+6VcbXnRF8OIHlgzClmBf1oeNs9kw3pP6g0YWWF8mXxW++tC
   pCj6s7/Rl6UEYz+z0GpZBSG6TSHpXtPN5vIEL6KHiX2mwBvZnqHhQJhsi
   MHpd4ZqCRCRiR9R3WR3GP0uPMtIQvy3t1LOwavO6IKOX4rQkl7T6YgFlQ
   6o5f/MyUKCF5Bpj4tm+Q+ajZ8rZJgPUFFBMUUs5EbdMRtgmCjHOmZ78Re
   g2doOPJlCAuBx3kP6FgFYdC9ncET9Er7PxXNzF3gsPfS/ZFsMopqtRxmn
   eTed5y7ChD8cLPgA/S8AXJnIKx5Mc+pdIXtNiEbZPJDbmnijZTbny1kdS
   A==;
X-CSE-ConnectionGUID: 6JxLCMR/Q2OkxrI3CQ7Y5A==
X-CSE-MsgGUID: I8i9V/yeSEqjnDb9WlGUog==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40750869"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="40750869"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 11:00:52 -0800
X-CSE-ConnectionGUID: jBEUF5+OTte7BN5r+epeqQ==
X-CSE-MsgGUID: h6rMGAktQo274kuh8tS+TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="109502407"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 11:00:48 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 11:00:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 11:00:46 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 11:00:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JR+ZDWh4ZVzGLdxPO2tQvtm0G7lg4yUuza0wzvDQKFl1dBn7aTsGL7daEvZwRVYvKcLpFDV8qOfbzDCf1I4jhVw17gJPD3DSCoQA7AwEN6q0DLh4XYjAQT2ZkE6y4BGl3xSHYgENYq13OvZWy5wPfBUtirLlPLSEhch4rUkcnepbcTOMWO6HEZQ4D+EYAv7Qe8lU7ugWY7HphT5jsfgw96URyh6dY9SF+iNn6TOgtiBxk6iRIFTa0I+ADLISdafXi4X16YPYlRqjynxI17HW/MBJ4Aau0tGkToxELio73AhL06ULpbI69k9+izsgcKK3ZgAB3zyZ5c3KY9k48X1m2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh6oP82KjM96I85LUq8Z1jQc6chzwvHTi5nhFkkPmqY=;
 b=v2a+pyPloenpQtJtcnHcQPLygQloRpXnrQMKWJhPRAtlxxjbAY3VMKxJXMV0JjCPowzsIuCtBM4H5gnwxWB5q8ctPXkYnzBdvmmlrtcAP9H1PQ/Y0zrA+cTGZHkDWzGRzbhJyT7/dbLJ6TWlwXrT1pJu3cCqsPW0AmwJROve4/8gdWlK870LKsRNDffIr9nr/ysZmpUh+PVOp96DWUpQ55kFqFEIyf/rrlmf9Awtplnuf4SU2I7fejniiwnLIpFcJJnjYUrVUxaKSavR06DV+3OKK5LMBIeEEFpHm6XBIwbJIDmaSiPbmfpJJvoHLWmeE8VLEgj2tz6rXzF5zhW8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 19:00:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 19:00:43 +0000
Message-ID: <52b5257b-6f49-48bf-b91b-b0f85e45d717@intel.com>
Date: Mon, 13 Jan 2025 11:00:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/8] net/mlx5: Clear port select structure when fail
 to create
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Mark Zhang
	<markzhang@nvidia.com>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
 <20250113154055.1927008-5-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250113154055.1927008-5-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 092d5145-fe60-42b5-6418-08dd340494d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnVySFRIY1U3c25hY2dGaUFXRWNVVGlzY1VhdmZrYjRxZXJtUUJZTVRLOXNo?=
 =?utf-8?B?Z0JpSmlOY0hXTkNMaEJLSm9ac2FZY3djcC9MZkpoM1lpT0EvTEluVGh0cVg2?=
 =?utf-8?B?Y0p1UE84YWdWc21TcjJoRFRBWUt5K3J3Ymg3SjVoTGZ0Q0xvNTF2TDVOSmp0?=
 =?utf-8?B?ZXdsVCs2RGhHaCtkVWJsdWlYUnI5SHNwSGF4WCszMzI5cnlJUlBtaUJZbGpr?=
 =?utf-8?B?dmQrcmNxTnZWd2s1R08vR1lTSGJVZ3BlYWZTeTBJZTYyZFBTSGxNVFZGUU9C?=
 =?utf-8?B?YnFvUDdQOXk4ZHAxTVZxeUNkT1hRQmQ0bWRTR0s3UGFmTUt2OTV2VjRuY1Mx?=
 =?utf-8?B?amlPSys3WSt4cVBRK0JkRkZrdzBrOFVyd3hROXlnSWppbXNSZ21QMnd2L0Ro?=
 =?utf-8?B?ajdPMzJmVEpOd0JLSGpNN05aTE90QTl1aVNpK2llSGtiQTlSRHNiUWpRTXEy?=
 =?utf-8?B?L1FweXBWaUY2S0F1bjJoYno4WjVOWmhWVWIxZ3ZxWHFONmQvYUw2ZklGZk0w?=
 =?utf-8?B?N2pqUmFWMGZHTHRZaWdKT1U2c0pjSzNZU2JyUG0zT2FBUFpDaHVEaTNPNXcv?=
 =?utf-8?B?YlZwdlFzZDQ3WTljQkJTYmg5ZzdIK0VlN0JXbmJIZ2xSVnE0OXAzTW1MY2NY?=
 =?utf-8?B?Q09tK0ZqQkVCQVQvL0VLQkMraUpVVnM2R3ZicHowS3hKMG5wSWJBM0owL1Y4?=
 =?utf-8?B?cFJRNVZpWDl6NmprME9GMUtOc1BZZXJUR0RKb3J3dmlwN2RIOUNQc3grZzlr?=
 =?utf-8?B?ejRpZ0RYTFZESTkxTjlVZDB3THl0eVEwcXhHNGREODhvTWZCN1BBSmVpZk5E?=
 =?utf-8?B?OXMxQnBtbnFKT0NaSXk1eWR1MHdjVi90WnczSUU1YTV4YkFRYmpZYjROOW9L?=
 =?utf-8?B?T0JBK2R3SUhjOFV2VEwyMmxsdGY5ZUVBYkswRWI3OTYxc1BmY3RQdXBXa2lW?=
 =?utf-8?B?S3RMRW5VZ1NRWFZZV05CVzJDNmtKS0xaeTVqTG1tS1locklUS3NMeDVUZnJM?=
 =?utf-8?B?RkhWRzByUk16U0RZRTdKZU1mdWllb3BFQzdBT0R0aDFVMUxnTW4vd2VNZ2Rn?=
 =?utf-8?B?czdrVlQ2ZXRFT0ZMREg4amFBMTFIMVk0UzZBY0t0S1F2ODE5cGRMZTdEemU1?=
 =?utf-8?B?dkU0Rjl6QTdkdEZoa0YwQkxXUEpuNmJpWDU4U2dHQWZhbnFLSkpacTlMMDJm?=
 =?utf-8?B?Y1BPWHpyL1BUbnI0YU80NkFSS0cxY0VDck84KzE0ajVaTzI5Ukh4cXBycldr?=
 =?utf-8?B?TksyMldYUUFqd0l6UHBqTW9rUnQ1Y3NNTGhEZUlJSWx3OUtySEdTN3I1eFVo?=
 =?utf-8?B?cEI2SUtTNExQTmtpQjZ2enNaSkhNeWxUSStMc2d2Mitiam9WLzBoTHF6UXNs?=
 =?utf-8?B?Y0svaUZBME1jbVJ2V1dOOHFMVWloV3oxb0xFM2lKMUNmanhNWVVJMDM0Wmox?=
 =?utf-8?B?M2k5Y21KK3hCV1g2Y2k0S3RSVEVlUjhDRnFUckJwWDQzOUhEdjZQSVc1bjF2?=
 =?utf-8?B?UERNWU93UVdMaGhoOGhKUllmVUY1c3UrTDlubFptaTNqVkFveENJampPQlNO?=
 =?utf-8?B?SVBoVloyR1F5SEk2a3ZFQ0o0ZXpmalVFK3Q5TDlEaUJxZGIwT2UxWVZPZ0Fw?=
 =?utf-8?B?L1hWN2Q2aUVMYWFCUGQvSmgxT1pCL040QW81c0V2QkhxR2lvYnk4d3c3QTdF?=
 =?utf-8?B?OStjWUVFODBqeXFQTUlEYzI4YmM4Q0Evd3lhd3J5VUtOd3VodzAwMVRqc2tZ?=
 =?utf-8?B?OU5HTzVsQlVkK1g2d1ozMUJBTWpVNTBRMC90OUdHVTY5THFGWGNqSjZxMllw?=
 =?utf-8?B?YjFLMXNyRVJmUnhiMndrS0pjZG1ZSUovTWxnYzdaWm1lY2Nuc1FPMG1TUTBm?=
 =?utf-8?Q?oKUK6pZhesZYH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkNTVytSMzA5dGFmRVl3c3Voc2JRWE1OcVp2YU5aNUtyMjBPdmFMYXk4VTRv?=
 =?utf-8?B?ZXZ6b1FuWXhvTHhmRGdUN3ZaSExndFpPdkJZWjcyOUFsSVRodTNrZzg4S1VP?=
 =?utf-8?B?L0t1c1ExYk4wcC85dUFSWnd4TjNMSVJoY2xOMGlSd2JHWnJxdllIRFFaeGVX?=
 =?utf-8?B?bjZyY2pFbFA1ZlFneDhhd0t4MS9PTWptS1AzT3YyTFZsUnFnMk9TdkorVWpt?=
 =?utf-8?B?Yzl4QUxzZ1d5YWw2VEg4R0lPcGNUTE9heFFWU1pqRzZSUlhRdmg2KzY1S2xI?=
 =?utf-8?B?cGsvaitadXB4NllFaFd1eG1SMEVZb0hIRnhaaDdCTTlmeXBWMFZacStCcjVr?=
 =?utf-8?B?REE4Zm5hUjdtRHQ0OCtXVThQcncrOU5USlFVdnJHMFJRY1Z0d2Z3bytTek9z?=
 =?utf-8?B?U0Z4a0hjMEdxbXRCZmVvSk15R1ZkcTY0UEV2SENFUVRKZzJ6L2g2Q01CMFdh?=
 =?utf-8?B?SmpTVitoUGlxWW9RaEk5N04xa05oYWkxeS9ROW1FZjlUUnM0L0V5cVdKc2g4?=
 =?utf-8?B?K29Ha01FZ3k4L3pTelo4OFJmY05pMS9uaW1LOS9ia1p1NjMzTTUzWFVOWEIv?=
 =?utf-8?B?bmxSbnAybVR0eHBpTFBUOVVrZFNsRkY1Z2J4cWFMOXFiT1dwZWZTNWMweUhk?=
 =?utf-8?B?Ty9UR2IrMjF5MnF5dWZqY1RHWnpxckZZR08wMlVvbnY5MmdBWHl5NWFGdVRy?=
 =?utf-8?B?Tmo3V01sQnl6bHVlMVA4SDMycEo0cit3Rm1WMlZhak9pM1NHSEw2QWN6azE5?=
 =?utf-8?B?Snd2dmZYczJ2dFQxYy9QcnV4dVp0RHl4UVRydytzNWFBbGV0V2l5bnEwcTZQ?=
 =?utf-8?B?bHNSbDgwVGYvSm1wYWVNRHBYakIxK1JDR2xGYU56a2tyb0M1cDVBWmkxYUlT?=
 =?utf-8?B?bjRpWDFNN25QUjVwdmQ1MWRxbGVabnZKb3FyT3NLWmpzV21aRDFOZHhMQ24z?=
 =?utf-8?B?ZnBuY2l2aGZRUmRzc1FXb1BEcGtsT0RZYWNTNUxqN3AvdnlrdkxBTEZCL1p5?=
 =?utf-8?B?TGdETlByNHh2Z0tVUndMbWFWV09UaDdnMTNjTktPdFczRWFCbncwd3NMTTlw?=
 =?utf-8?B?Rkk1MlhhVnljN1BvUFEwS2hhWTFmazRWdlAzS2ZjdFJ1WWNvK1RSOWFZOW5O?=
 =?utf-8?B?a3ZqR01Mb2NVOTU0cTU1b3FPaVhKclRJOG1yaklRTFpOQy9QWm1wZHpEVWd3?=
 =?utf-8?B?eHp2WDdvRzBIeEF5dFBOZ1BYMlZhek56N3B5Vis1V0ZPRC9SVk1zbDdxRk9v?=
 =?utf-8?B?aUdza1hrbVdLeFNKaVQyVHFWRWlBZi9aNWxrYXEzS1MxbHB1eFhvTTB5TzZX?=
 =?utf-8?B?VjhlUE9OV1dpdDNvSWUwQzdzRlorSkFZV3pDWTNkcTYrUUU0OVA3WUFwaVpC?=
 =?utf-8?B?MVZhSG0rbGFIbnRmR1RzK0RhVzJrNnRyU3JMbkhmdThBb3l0cTI1eEFKaWp0?=
 =?utf-8?B?VUdmRTlZRWdOc3JtVlBGQjRBRUVJTjdhU0xKbTFsRDI3aVJDWnJiZVA3MGNJ?=
 =?utf-8?B?VEx1MDZ4T3cxRUtBRmUvcVNWcVpZcjNLeHFORThiZ1ZWcGR6UDdzM2V1VTVS?=
 =?utf-8?B?K1oxK1NvQ2E0WFhNMXJrUERHc0grRmtOT2pLd0MxT1hFRWJvWEZvUFpQd2Mr?=
 =?utf-8?B?TkpDd1ordVNSdXZIaXQ5a0NzbUpxZ3BvWXpidDZWZUwwemh3Q0NFUk1semxV?=
 =?utf-8?B?ckpBRHh1c2pWbTgrcWhhVnhOUThTZlM4T3cycVB3Q0RqSitCWkxSRUJ5OU1S?=
 =?utf-8?B?M1RPRXZBTk4ydWFoSm1qSUpsQ0s0aFZaYjQ3Sks1M2F3d3hJQ2JaL1VLYUZ5?=
 =?utf-8?B?UlJpMkIwd1A2Zkd4Njd1UE1oR1EzcVR2Y0ZsOUdnV2J5bFJGYUJCSWU0RW1L?=
 =?utf-8?B?Qk9vMVIrdHEyOWJzdi85UDBQQzZPTVdSVEI1UHpZcnhnM3kyYUc2djdUN2hx?=
 =?utf-8?B?SHVNT0FqUmx3KzVEYTBYVUZCb2QramZWampRakY5dnRJdzZTNzkyUlpWWGF5?=
 =?utf-8?B?dnlaTFVnZDRCR3Y4YW4xOWJhRVV2U2wxZVAxQjE4YXIzWlFsWGFaODl5aDdm?=
 =?utf-8?B?ZGFKaXhzUmk5V0VrSVp4M25tYnR4NlJINXI5enBObjZRYnMyZllzSzNVNmRv?=
 =?utf-8?Q?ZzLyGDL/lCts/naXJCt3aorEJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 092d5145-fe60-42b5-6418-08dd340494d6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:00:43.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJcpAu5+4mRL2+HfrV3gUDJCW46yfpO6CuFHxNmKm+t25+5OcRK51N/wN6uZOgG/bGvqQmw5I/RDVX4X8jHdGPbFq1FfaisfIzWVNGdXNrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7378
X-OriginatorOrg: intel.com



On 1/13/2025 7:40 AM, Tariq Toukan wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> Clear the port select structure on error so no stale values left after
> definers are destroyed. That's because the mlx5_lag_destroy_definers()
> always try to destroy all lag definers in the tt_map, so in the flow
> below lag definers get double-destroyed and cause kernel crash:
> 
>   mlx5_lag_port_sel_create()
>     mlx5_lag_create_definers()
>       mlx5_lag_create_definer()     <- Failed on tt 1
>         mlx5_lag_destroy_definers() <- definers[tt=0] gets destroyed
>   mlx5_lag_port_sel_create()
>     mlx5_lag_create_definers()
>       mlx5_lag_create_definer()     <- Failed on tt 0
>         mlx5_lag_destroy_definers() <- definers[tt=0] gets double-destroyed
> 
>  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
>  Mem abort info:
>    ESR = 0x0000000096000005
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x05: level 1 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  user pgtable: 64k pages, 48-bit VAs, pgdp=0000000112ce2e00
>  [0000000000000008] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
>  Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>  Modules linked in: iptable_raw bonding ip_gre ip6_gre gre ip6_tunnel tunnel6 geneve ip6_udp_tunnel udp_tunnel ipip tunnel4 ip_tunnel rdma_ucm(OE) rdma_cm(OE) iw_cm(OE) ib_ipoib(OE) ib_cm(OE) ib_umad(OE) mlx5_ib(OE) ib_uverbs(OE) mlx5_fwctl(OE) fwctl(OE) mlx5_core(OE) mlxdevm(OE) ib_core(OE) mlxfw(OE) memtrack(OE) mlx_compat(OE) openvswitch nsh nf_conncount psample xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter bridge stp llc netconsole overlay efi_pstore sch_fq_codel zram ip_tables crct10dif_ce qemu_fw_cfg fuse ipv6 crc_ccitt [last unloaded: mlx_compat(OE)]
>   CPU: 3 UID: 0 PID: 217 Comm: kworker/u53:2 Tainted: G           OE      6.11.0+ #2
>   Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>   Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>   Workqueue: mlx5_lag mlx5_do_bond_work [mlx5_core]
>   pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : mlx5_del_flow_rules+0x24/0x2c0 [mlx5_core]
>   lr : mlx5_lag_destroy_definer+0x54/0x100 [mlx5_core]
>   sp : ffff800085fafb00
>   x29: ffff800085fafb00 x28: ffff0000da0c8000 x27: 0000000000000000
>   x26: ffff0000da0c8000 x25: ffff0000da0c8000 x24: ffff0000da0c8000
>   x23: ffff0000c31f81a0 x22: 0400000000000000 x21: ffff0000da0c8000
>   x20: 0000000000000000 x19: 0000000000000001 x18: 0000000000000000
>   x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffff8b0c9350
>   x14: 0000000000000000 x13: ffff800081390d18 x12: ffff800081dc3cc0
>   x11: 0000000000000001 x10: 0000000000000b10 x9 : ffff80007ab7304c
>   x8 : ffff0000d00711f0 x7 : 0000000000000004 x6 : 0000000000000190
>   x5 : ffff00027edb3010 x4 : 0000000000000000 x3 : 0000000000000000
>   x2 : ffff0000d39b8000 x1 : ffff0000d39b8000 x0 : 0400000000000000
>   Call trace:
>    mlx5_del_flow_rules+0x24/0x2c0 [mlx5_core]
>    mlx5_lag_destroy_definer+0x54/0x100 [mlx5_core]
>    mlx5_lag_destroy_definers+0xa0/0x108 [mlx5_core]
>    mlx5_lag_port_sel_create+0x2d4/0x6f8 [mlx5_core]
>    mlx5_activate_lag+0x60c/0x6f8 [mlx5_core]
>    mlx5_do_bond_work+0x284/0x5c8 [mlx5_core]
>    process_one_work+0x170/0x3e0
>    worker_thread+0x2d8/0x3e0
>    kthread+0x11c/0x128
>    ret_from_fork+0x10/0x20
>   Code: a9025bf5 aa0003f6 a90363f7 f90023f9 (f9400400)
>   ---[ end trace 0000000000000000 ]---
> 


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Fixes: dc48516ec7d3 ("net/mlx5: Lag, add support to create definers for LAG")
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
> index ab2717012b79..39e80704b1c4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
> @@ -530,7 +530,7 @@ int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
>  	set_tt_map(port_sel, hash_type);
>  	err = mlx5_lag_create_definers(ldev, hash_type, ports);
>  	if (err)
> -		return err;
> +		goto clear_port_sel;
>  
>  	if (port_sel->tunnel) {
>  		err = mlx5_lag_create_inner_ttc_table(ldev);
> @@ -549,6 +549,8 @@ int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
>  		mlx5_destroy_ttc_table(port_sel->inner.ttc);
>  destroy_definers:
>  	mlx5_lag_destroy_definers(ldev);
> +clear_port_sel:
> +	memset(port_sel, 0, sizeof(*port_sel));
>  	return err;
>  }
>  


