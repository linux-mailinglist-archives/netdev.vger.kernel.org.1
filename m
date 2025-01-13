Return-Path: <netdev+bounces-157833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9E6A0BFA3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77DB3A5E37
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BA2187553;
	Mon, 13 Jan 2025 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2dcwIcW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D72924025F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792297; cv=fail; b=HRXju+tYV668wUMvKfAECI6jHNLlmKebae/m8z4ZzjMW953aOeT3D1LGFSG+GX5iV8owEGncaCdI5KF9FhPGagc6W3ldHk8zLTyBz2W06QoY8aLGpUM6J0XIn5NdsaXpYBZcPFd+E6AfvcQ0M94IlZk3raqH7UEgPi+C0bzr0qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792297; c=relaxed/simple;
	bh=RICn1cgIHuND6EUp8KFwEMrdeuC0ohbLrkfFPk5yovA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CYnxdjJkOKQSr9MNdxI9cpOJPbi6fkRx5qHYoM3DJI7RTbh0UwL70D2syna6oYo0BzQIT2Odu1UTkmofJJ0DF5Z9SY+M+NMXFV2NtkOREeLa4Weqfz1QdZtbPll/CuW/u0JKXWRETnTti+htlE87xVYnq/6sZ160uFQKW/sL3Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2dcwIcW; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736792297; x=1768328297;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RICn1cgIHuND6EUp8KFwEMrdeuC0ohbLrkfFPk5yovA=;
  b=c2dcwIcWwfBaKRYmZSkh8AyCvj6+pUWALFTxmHRDCTZb3XoQKDI+xsJw
   FjttoKymuqVMzsFTBlxlAbln2KwUBj1ulXtCM4VAJIs1W9Qw27Bkv0D5Y
   MvgXO2xKineew/jgk358Ljr1UQcGphCB08VP/OHjazUtvCm9uJYZprsbn
   cQ3s0jd7pnHScSdw47WKACh9s8IQKx7hY4AeCbzgcEjtzbhIoo2RyoP4l
   K0QTWY19pJ/FcfpflbKD10TOzj5US7AEuOiLlJ7+pZlxZJm01EsvUV4iA
   juT+sB2Tz9U0saw8xWIwko4qE8/O1GW5BH3Mi3nbJtqZTVoUak4CDOb8N
   w==;
X-CSE-ConnectionGUID: pyW5FpIiSNeewXnLHwMPTA==
X-CSE-MsgGUID: 7Wm35vkUSPOkPbwdwfg7+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="59554223"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="59554223"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 10:18:15 -0800
X-CSE-ConnectionGUID: AwXI8thwSvuiOXbxr+MQNg==
X-CSE-MsgGUID: ZmAl9I9jReW3+4SQoc0zcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="109491254"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 10:18:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 10:18:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 10:18:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 10:18:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZoT24qWeJq1QlhXf0usY49+V5e3tUAK1xKUVlX2Rt0II+Z1h5jmGgO2IHt64y4GlOKJGFug4jNBZWZp2F/uTEH43FwEUb0vJfLunpeFgYTuvmkRxW6G8U8EgkqL2BlCtwo2po6Ek9Yn2bOYFMILIVeFYjXK34wZOLGqXFkuauBBqAvXvDMX9//rpHtGga1RlAHgCfe7Fh9xbGtYn9dpdP6wNzzJ5sZM0Bi0lTf4ITDWVdpXGmBVJxugfLoofVzsvraBsGCy0Wy28BSYIn4C2a744zpf+plHj/6WbOIa9skzmYEzikbWa03YyBfH/uPJvPZ5grW0aXRBUjlp4fD8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUKesjQ433yxTGj30arUzurjGK5euf6qtz1L2/AS43M=;
 b=swgS9EUSju+OLuEvgJimtFNawFIPlrVIbP39QdgznsIj+/gmfDJTy3LzQwR/NvEowq+pEfyHNzcHE0SLWI+2YIS+T8ZWi+eMSMcwZM0JS/p18iXgRgNxGUot4zdT8Q+koZb76osWDKMXjhHJIXoWBP1HTsnyW0kvU/hItWz0EwM6B6tyI7tuYMPDMZ0QlFmZIAmFSfF+ele2DdA7WQWemSk1AVYQKNeLL6COSc9uqm1lFik3IxKTrK2S9SAB9E1j3qWcAjgrV9UJDF0oHKlIBJ/P+otBuS/5R54wGW3oyWnheZwjIdik00M2vQV70TEU9by6JwVs2VT/3JIs1RCSzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6687.namprd11.prod.outlook.com (2603:10b6:806:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 18:18:07 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 18:18:07 +0000
Message-ID: <a0b535bd-3569-4d36-9752-ec8dcdc23aaf@intel.com>
Date: Mon, 13 Jan 2025 10:18:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/13] ice: use rd32_poll_timeout_atomic in
 ice_read_phy_tstamp_ll_e810
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <anton.nadezhdin@intel.com>,
	<przemyslaw.kitszel@intel.com>, <milena.olech@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <richardcochran@gmail.com>, "Karol
 Kolacinski" <karol.kolacinski@intel.com>, Rinitha S <sx.rinitha@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
 <20250108221753.2055987-9-anthony.l.nguyen@intel.com>
 <20250109182148.398f1cf1@kernel.org>
 <55655440-71b4-49e0-9fc8-d8b1b4f77ab4@intel.com>
 <20250110172536.7165c528@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250110172536.7165c528@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 2373d084-a8ac-4960-b0e3-08dd33fea0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWFrMnQ3WHBZb2l0NDFNMWdUUkUrcnovUld0bC9LS0hYK0FmZDRSMmhOQXpN?=
 =?utf-8?B?bHVTT1RBZzdRSk9rcHpZRS9wWTVEWWRBa0lpaEVIQmVoQ05QMVJGVmgxUmo4?=
 =?utf-8?B?WDcvTklVOEtjR2tKSThFTWpuTzEzcElkUHRzV2Ivc2RNd0hBaGhxWE1RK3ov?=
 =?utf-8?B?QnU0QjdEUk1CVmhVY2tiQnV6YjRWWFIyckNsYnpPMDMvRUxxMm5MbU9MbmNL?=
 =?utf-8?B?dC9aRURkUFZRVzU3bE5XYTBHeVJHeko0dmtrWm1JTkpXT2xjUjhmT29Yc25s?=
 =?utf-8?B?YkJaN1lvamJRZWo4SFNOSDA5dmJQS0FScXVOSktIVTVRVmhPVkZkdlh5S3dC?=
 =?utf-8?B?VXlNZGFEZ3lJYzVKRk1TRkwzMURlOWM1a0UyRTFiUWhDQy9sT01idzRoVUVZ?=
 =?utf-8?B?QzBadVVxZXhHU243MmI3Y2hQQkRkUVVUc0liWnk0YmhuVHdQUEVEK2NNSG5Y?=
 =?utf-8?B?c0lBUkRxUTZId3V6eU9rdTk3M1Y5OGU3cldiOVZVUWxRY3NwUmtSTU44RTRO?=
 =?utf-8?B?TFh6Znl6YmVsV1ZxQzV0S3FzUVczdUNvTGc3RWxyWnB3ZGNzVWNwV0tqQ1RR?=
 =?utf-8?B?VURJTXp4dDlISnBlNWw5N2Y2V0ZvdDA2SjJFU090TzZhcmdwcC9IWW1DWVVH?=
 =?utf-8?B?YndsbDlPaWJHbHJYemlYbG1RNExmQ1crOGlBVDIwTlF3dzRXd2lEaXRsV3BO?=
 =?utf-8?B?V3FjeGxIV2RVRjFLeFZWS2I5aFlVQTJCN0VIZW8rOHIvTng2aFlmaThySnZM?=
 =?utf-8?B?VGV4NWlndm9ndDN5MHBIZ2hzM3Y0SEhVYUR0ak96ZHMyN2lUS0NRcGRCb3Rh?=
 =?utf-8?B?aGl1aU1sM1pMTFpaSnRkaWcvYkt0SnpycFhhU2ZiZWJEaVVrbW1Cckk4bHhI?=
 =?utf-8?B?K1dpVThkUVYwYzY1aXY0dlYxTzJXTGNSYjFPanNLSzJGcGxwN213TlNVZllz?=
 =?utf-8?B?bzRLTE1jcTJXWHR5YnFzWnZlYlBMSzc5VGsyaTdhUk9qUll3K0E1dk5QVGxq?=
 =?utf-8?B?Y2VPT2NxYUxaeGpjcFUzeGFoMlVhU2N1b0Z2VlYvZ2lVTVEvaUwyUWJKYllj?=
 =?utf-8?B?UjVUbTQwMzdzakF2c3d0cWxFUmMrY1JIaWkwN0ZXYlNjMGZyUnVTQVBISEZm?=
 =?utf-8?B?SVArNk8rUlFHUE8xQUhpb1RvNjMzUlBEQjE1WnNVQkRmNnFRTXg4K1hHVStL?=
 =?utf-8?B?cmpDOWRBRHFCRVI0cE00R2pKbi90ZGRVWTFFMFphMk00S0tGYjdUTEc0VHNt?=
 =?utf-8?B?MHNvNnRPeGtDYitFVG5objZVQ0tSdVBJQ214OFJIZVZHVVkrL1gvTTU5TVVB?=
 =?utf-8?B?ZXY1SS9TSStHRTUrNlNFVHhLVyt6S2JoUERiODcxajNuQUx1aFJlM1pOWGpj?=
 =?utf-8?B?ZzV6bTZxWUVLT3Q1a241bFZUd096cTJGK0t0UzlYdkorUHR2RDFwSktuUDlG?=
 =?utf-8?B?cFczRGVQbVZTdnErbWVOa2hiRW84SUlKV1VJQ0N5c2orN0ZRcXZSN2lSZVpl?=
 =?utf-8?B?RGFrblo5RXlLS1hyT2RkUmlibUpQQmt6Z05scTYxYVBaYkFQMjI1Qit0Z25T?=
 =?utf-8?B?WHlpOWM5WnJEUkt0T3UyM2Yxdlk1T0dtQWZreXQzVmhDdUdQbmlhcmw2QmpQ?=
 =?utf-8?B?Q25aY1pRYjBnek93by9VQXJrZ0NQazR0M0JFd29KYWhhUEZqNk4yeFc1WFFJ?=
 =?utf-8?B?OGhubFFacnB1NzlYczE4RHBqUHQvNFB6NjNBWlZsYzU2QzAwTnpYTC9jSGV6?=
 =?utf-8?B?c09qMFB3WlAxQU9Dd0NHbHdLZk9henJ4ODgybFRuaFUvNjVtci91NUhwcFJr?=
 =?utf-8?B?SVRPUy8yaDZlUlAvN21heTI2dVhINm5mdXFjY2lzWmFpcXoxMkVQaUxIaDNX?=
 =?utf-8?Q?KQ1dednKdLTT0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWM4cGNoUUVrcDBWc3gzditpMWt0WktoZE1nQVZzQ0Vsd1BVaE8vcmRNbXEy?=
 =?utf-8?B?b3UxYlpqc0c3ZnNYT2dPSkRxeUJqSzNxS3hvSGlHei9ybk5qMytFV2M1a25N?=
 =?utf-8?B?cUxjb3Y4Y3JQOFZkK0tFc09BamRReGVGOHNBMENVdU9oT2dwK3hEdFVFYXkx?=
 =?utf-8?B?TE9saDBqVTJkTHRpRVVZL2N0TTNBUjdEUWFhdm92RWV5NWphNTU2ZCtDdTV1?=
 =?utf-8?B?M3RqMGxUaVlneE9kQzhuZVhKM3FWRDQxbzdZSjZjRDBlbDVjYzFpeVhJUE1C?=
 =?utf-8?B?STNqNnNYc2xwcjQ5OWttZU5rY245ZVZmV1NpMUVzS2FEQVE0LzBaNXJXRzlK?=
 =?utf-8?B?bEk5cnZCUzZMNS94WHZiZFVPQmFrMW52VFdEWkxvckFnWEVXejQwZjQvN1Mv?=
 =?utf-8?B?NVNMUXBEdzhnRHpjSGtNVmQ1Y2lUNWhQZWFqL0tBVURnOWJEZDArYW9IRm4r?=
 =?utf-8?B?RnN2NkRSMjB6SkwxcVc4dEZFWjF6c2ExS2lNcmRyYXJXUjk0aXBnc0RLSlBs?=
 =?utf-8?B?NjdzUXo2VnBIbWNOTHlIakhKdnhJaFNoYlg3WituTjlhR2tEa0ViVTNvR2ww?=
 =?utf-8?B?QkltWGdiUVBnYjBZcEtqMHBUOVh1Snd0TDZmQnU3OHVkY1V4WVE1WVYrb0lk?=
 =?utf-8?B?ek8xaGo4c3FyTzBDSDdBUldFNEcreGRKNHBReStwczduL243NTVjWlN6b3dv?=
 =?utf-8?B?Rm9mM0hZV0dqY2h2bitOVjdxNVFCMUw5Q0xCT1ArelFzUUFOSTNsOVVpVU5t?=
 =?utf-8?B?V2Vja1VNZFRnZ1d0NURObTNMWEtueDZSRWZnRHB1c25ad1psU1liTHo1V2dJ?=
 =?utf-8?B?cE0wSm1ILzdrVjFwbytiZy9jSnZPdVBVOVJQdFBoRVdiMFR1WUlYUm1jM3FI?=
 =?utf-8?B?cWR6NHFvNnNrT3E4algrbk1May9jdXVCRDN1OTY2SWptTlVwWElDZlYvZ1E5?=
 =?utf-8?B?WThMOWMwSWZxdjY2RW1tTzVhNFVoSGoyWDE0aTBDanhBdGVYb3JXQlQ0ZG01?=
 =?utf-8?B?VGM2cm45Wi9lcHVjYjIzM09xamwvMWhCdjNLSVVmUGVXazRRSUFaOW15N05Y?=
 =?utf-8?B?L1pHQnEyWC9BSlVoTlFDemVhQWxXK25EWXl5cnlsQmFsZWhZWWtOWEJlVUI4?=
 =?utf-8?B?Y2hDcGJxZUhqK1Y5RmVoVlUzNWxEblZqY29LbTFNaWJBVGtzSmZIeDFDckJy?=
 =?utf-8?B?QWo1NW5aQXFpNDJpZ1R5eE5XVzZrUFFiako5aDRSMXUycjRENWFzdXRYTENM?=
 =?utf-8?B?MFhhQllkTXViMmVqTXMrOHNaVFI5N2l5anA1Uk5TQ2E3M1NMK0ZwWUwxZWk2?=
 =?utf-8?B?aHhZaFpnNXRvWDF1ZW5rdDJ2MDV1NENOQTdRK0dwZDdyZG5KakRkMXZwNnJz?=
 =?utf-8?B?RjBnUGlkZjBDWW9QM2E3OVVPYWEzUnhIL0Nnc0lDZXB4ZGRqZk52RkdJVUQ2?=
 =?utf-8?B?cVNzWFdGSGpEL285ZzNFVjBlRzZWMGhtSVRaUHZEZzhBbzByVDlqNGQzTHJ0?=
 =?utf-8?B?STdKeXpyK1N5VHBJZ3lBMHQwTG1YY1JXaG1BdGNUamxaZVNXVEwxb1MzVnQ0?=
 =?utf-8?B?c1pSSjBnRGd2RE5HRnJ0RzB1c3J0Qk51VHZzVm4xam1KQ0JORmhOTVpqTlhG?=
 =?utf-8?B?WGg2clc1azl4eUdnai8zaXJja3VSaGNYbUJKTHpMeUpLRUtMcWRQSUExd01q?=
 =?utf-8?B?YmlCZkZ2NDdBSklLUWRXTTNhY09hV0oxUjZOOTIvV1lHT2UxNTBjSU5hRWxt?=
 =?utf-8?B?UGI5RXFGeDVES1E2NUgyZmp5bWJhY2FPMDZnQU9Hdjg3dW54aFhsZlNaTTU1?=
 =?utf-8?B?L0w0NmhyY0E4VVFYb1l5UVpLdkVDeFJrVk5YZnJja1pJZkxaSUU1NklFMVlG?=
 =?utf-8?B?RFZpSVF1ZG5IUXBlR0tVT0l6cktRTW5NakF1dUpwZ2lmY1BIay9kb0VuaDNK?=
 =?utf-8?B?V0xwd3VFNXJEVTIwUVlubm1hbTQwVlFpd1R0Z3Y5cmNWZ1A1T1Y0cENKa0s5?=
 =?utf-8?B?NzJVa2t2bzNzRmRGUWtaemtYdVFsRmtjWjR2WlZMYzZwWUhTcGZRa2VuNUMx?=
 =?utf-8?B?N0EvME54ZjF3djVzSXNFL3UxNW8reUwwaTMwa1ZsNHdRL00wcFo4akJGQjRa?=
 =?utf-8?Q?hlpadGpmLV/Fg6I3Lf/I1kSZE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2373d084-a8ac-4960-b0e3-08dd33fea0db
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 18:18:07.2021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOVpNDEHWkgeQ+Beb3s0W/isYzmc5o5DSw0rJC7Doq0o/Oes0rWXA+D3iN8nzM+qo2k69qRar25vmua/Se12njYQIuIFiOm3V+kiqh4fjnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6687
X-OriginatorOrg: intel.com



On 1/10/2025 5:25 PM, Jakub Kicinski wrote:
> On Fri, 10 Jan 2025 16:50:44 -0800 Jacob Keller wrote:
>> On 1/9/2025 6:21 PM, Jakub Kicinski wrote:
>>> On Wed,  8 Jan 2025 14:17:45 -0800 Tony Nguyen wrote:  
>>>> --- a/drivers/net/ethernet/intel/ice/ice_osdep.h
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_osdep.h
>>>> @@ -26,6 +26,9 @@
>>>>  
>>>>  #define rd32_poll_timeout(a, addr, val, cond, delay_us, timeout_us) \
>>>>  	read_poll_timeout(rd32, val, cond, delay_us, timeout_us, false, a, addr)
>>>> +#define rd32_poll_timeout_atomic(a, addr, val, cond, delay_us, timeout_us) \
>>>> +	read_poll_timeout_atomic(rd32, val, cond, delay_us, timeout_us, false, \
>>>> +				 a, addr)  
>>>
>>> Could you deprecate the use of the osdep header? At the very least don't
>>> add new stuff here. Back in the day "no OS abstraction layers" was 
>>> a pretty hard and fast rule. I don't hear it as much these days, but 
>>> I think it's still valid since this just obfuscates the code for all
>>> readers outside your team.  
>>
>> I assume you are referring to the abstractions in general (rd32,
>> rd32_poll_timeout, etc) and not simply the name of the header (osdep.h)?
> 
> I presume the two are causally interlinked.
> 

Quite. But I also don't want to simply rename the file, or start putting
the same problematic code under a different name.

>> I do agree that the layering with the intent to create an OS abstraction
>> is not preferred and that its been pushed back against for years. We
>> have been working to move away from OS abstractions, including several
>> refactors to the ice driver. Use of "rd32_poll_timeout" is in fact one
>> of these refactors: there's no reason to re-implement read polling when
>> its provided by the kernel.
>>
>> However, I also think there is some value in shorthands for commonly
>> used idioms like "readl(hw->hw_addr + reg_offset)" which make the intent
>> more legible at least to me.
>>
>> These rd32_* implementations are built in line with the readl* variants
>> in <linux/iopoll.h>
>>
>> I suppose it is more frustrating for someone on the opposite side who
>> must content with each drivers variation of a register access macro. We
>> could rip the rd32-etc out entirely and replace them with readl and
>> friends directly... But that again feels like a lot of churn.
> 
> Right, too late for that.
> 
>> My goal with these macros was to make it easier for ice developers to
>> use the read_poll_timeout bits within the existing framework, with an
>> attempt to minimize the thrash to existing code.
>>
>> Glancing through driver/net/ethernet, it appears many drivers to use a
>> straight readl, while others use a rapper like sbus_readl, gem_readl,
>> Intel's rd32, etc.
> 
> Ack, and short hands make sense. But both rd32_poll_timeout_atomic and
> the exiting rd32_poll_timeout have a single user.

The intention with introducing these is to help make it easier for other
developers to use poll_timeout and friends throughout the driver.
There's only one user now, but my intention had been that we'd see more
as it becomes more known and is easier to use.

