Return-Path: <netdev+bounces-198696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79B7ADD0D7
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7599F162640
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8932E7642;
	Tue, 17 Jun 2025 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dp7IrduI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F55F217651;
	Tue, 17 Jun 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172638; cv=fail; b=BEmuGsLa6Bm9sEeytcHXAls9WPyP5fnPNFriWwNRb70JQs3G+ddAqj3jlOgq5kd9F8uYZKwUG3z14VEkf2W7ITGhrT498ZwwNb3/wakr9MkB6fdqVpinsT554mJs4m2tUnGJKoSlzGNGQzbs+4KW2A8hEjaE0L0rgLEbrLjJz5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172638; c=relaxed/simple;
	bh=Gklj15x+Au01BX6WpdvlSHhaUZdjAu/tlXVzmiuBCQc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kV9Wnpd5rmX3LHQhyNtA8TfaD/dBCQsktF27ec71zIsDgMEeGXyzoYo0PUuu8mWiuEJjZ2LstjqVoXIN0GWIe2/q6gsG0PNmBn7EylXQoqM7FUIVg8S6PtQaCVx9q1oDyn9OnAGd8zLTWkyp+6p26lDCV4a08/eOQ7rgOyQQ4OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dp7IrduI; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750172637; x=1781708637;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gklj15x+Au01BX6WpdvlSHhaUZdjAu/tlXVzmiuBCQc=;
  b=dp7IrduIs5WHeLno/Mpks0lz6EP5/Pqv+tgh5Pz4M1oDopYyot4srO0q
   ln6Jrumt0zbb5Oc9Mla6fv4ViNWNrpmy1UZA1IUwob0nWOfnYr6XY+sqX
   8u5wv7IgkOAsCefOysYyz+EHdM4vKwapxeb4RlfjU+cGc5ejzw/IJjS3r
   VRQ0bNdNJHSJumrboJdhvo7cYTFB7DKb95AUHN6jN+XPuF8gerSzce4fx
   A4jCsbm/gKrJX28VJ2pMJEMEqTajmkUx4zlYrpY4tX3abR+lgDSERwAmf
   Igy7mdxI82jhehvLmEQuslTr12/JfEHwXpUxLp/gMMChIfU20vFFQwR2O
   A==;
X-CSE-ConnectionGUID: WX8Nyh77QdiOnA4/sbEnyw==
X-CSE-MsgGUID: 55w9dw6RT6yMT9/iE5FsrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="56034127"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="56034127"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 08:03:57 -0700
X-CSE-ConnectionGUID: YHgCft78TFCOZLCaTEGDdw==
X-CSE-MsgGUID: x5PA0FFTRte+STvydEr5MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="148728495"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 08:03:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 08:03:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 08:03:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.50)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 08:03:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKX4tL6yucXWb2CVXQAiBAkHqxLP+J5UoXPkyGNOWAx3V6bhQeHYt8Dx+gHd9rqtWxPoCjtCjtasJ76chIbcqDnr5Owd1f3qJR2yMFbKdDraWLS6NbPcabbx2MJrZNIHrlDN9HDvmPX36cmHfs6KbtSaW5Bs1ZSyBDnnzj/Am73oHUkDpnmj3xMsl6cp4RkfFw7M2ReiqeVDpkfXPYPN0Pry9Vmo+VLIM1jUqFfAml9CRChCleFHYz9k5GLFG3Q6slKv9y2bt+vNTby65FqmEyDjp8UA9Jv1PIrh3dmZImxEi8m3+fjrizS+57UVFOQEayWfM5lyf2rUPxy22ZBxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZC/B0iDNSK+ztIwp4bQrakQVqISdqPIIVbLdpvh3Ac=;
 b=nN4i8Gr2IRQxmCZtyyysz6yVxB4VqLa24YRRLHPHtH28XCa5YQqOpXKrh7UrTnHDUVmpYvDYFIEIEq2Xvqjkjpx2hznwlpojN3g5vfXQhmScpw5KDmwUemwdJKxMlFw6YfxGq8bsOHseHF/0j6f5nDIr5XMoD/+VXfCjX3Cha76EO+PhJ9Jhe88x8Tvvmfl9ysLH+Vfc6RE3P+tr4knSxaNliCkZp5sFamFdREqA6a/uicWwzfwLTZ893pZ6Vyn+yG+sKcgEM52z28o/LBLcj9f0QNJhdfwIfmHZYFd+4FAjqlb0fJ389NqYeG5PLRA2qdoPrpCGNLcnYE3KXs0Kdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 15:03:37 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 15:03:37 +0000
Message-ID: <676127e8-80e4-4374-b791-488b6c53da70@intel.com>
Date: Tue, 17 Jun 2025 17:03:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove Shannon Nelson from MAINTAINERS file
To: Shannon Nelson <shannon.nelson@amd.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <brett.creeley@amd.com>
References: <20250616224437.56581-1-shannon.nelson@amd.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250616224437.56581-1-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::33) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fba0c8-84b8-44e2-982a-08ddadb0233f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTlsaS9vRXNRK1hvRjVHVWN3TkJUaXhLK1dqYllzOGhhb3BKNlIzZTVtMnBT?=
 =?utf-8?B?UjVwdHV2RUtTWTJveGczL3BrVE0yRFRMWW53UWhaek9QMnhrOVNkN3pPV1Yw?=
 =?utf-8?B?U1gvd2VyZW10ZG5wQTBESUlyQ0VKN1ZJVU0xcEJkRDVBbmZuQ3lmNm93NW1x?=
 =?utf-8?B?VkMreTV3S280U0xPeDhQcmlwQklISi9wd01ndHR1K25CRXhUM1kvQnlxNjJ2?=
 =?utf-8?B?YnBzQjlBUDNpTlk1L083bnZQK3lSVHVwT2ZES212b0VKdkZEYzRDMExVMGxS?=
 =?utf-8?B?aTBrQ3VRSmxXQTFRMkVheVdVWFgvRzFrcjFuQ3ZuVXdNVXZ5amZBNzd1bVR2?=
 =?utf-8?B?QXlicjBnWTNwc2h2SkNGOWZOWUVwZDQ4UGt6SDJQVmRzTko4ZGZYRDA2bXdC?=
 =?utf-8?B?UldmSlI3MDNUY1ZqMVlYZGNYL1FjRzFyVWIySklSVlJKZ0E3cElLTXBhNzg1?=
 =?utf-8?B?bVd6YnU2VkFFa2JwS3ZMZUcwN1hlM0txRWRUUVZoWmZ5SEY3Qm55WE9jSUlz?=
 =?utf-8?B?d0UweXVFa2gvejM3TFl0WVZkTlp2cld1VXdHeHh2bVdJUEltQlExck10bElu?=
 =?utf-8?B?QTk4OHhoVmRJVG9vcmxMTkJNSWl5T0R4N21NS01LdVkvSVBmNnl5d3VvemFy?=
 =?utf-8?B?RW9hc3RGLzMzbkJSS0Y3SzIzNTg3YTliRkdBbWpnQTIxVTluWGlrb2RXSEZu?=
 =?utf-8?B?ZWZrN3hNS1FHL2tHcDVENkkxUmN2dHV0Z1Rrc2lrL3dNbUFkZ0lwYVZPaVhp?=
 =?utf-8?B?aEJxbUlpQUx3bEtITlJGQjdNTEd3WHVNangxN3lHMllIK2JZS0lRZk1rbEhh?=
 =?utf-8?B?YlVtUXJQQUdRV0tKZEFZbEtwRlBsZUpvaXNwQldBb1lRVnZDVmRhWE55MWVF?=
 =?utf-8?B?eEgyRHo2aEhZdk9DQnlFc0pBdE83QnR3V1R2eXA3amRmMXZSdVRHcERpMmZk?=
 =?utf-8?B?QWNFN2V5eS9GejMwb0ozNmFtaVJ5cEZEUlUvK0szb1lmdjdiVDVYcHprcDc1?=
 =?utf-8?B?ZVdxQWNiOGs1UTJyMzhxWE1uNTlQQ2UvQzc0cWFmQU9KTmQwNWNGOVJrdlh3?=
 =?utf-8?B?OWNZL1FBcjVmbnhIeE4wRFNYdWxPcVNHZkwvV3laY2dqb0FadU5xczhMM2gv?=
 =?utf-8?B?RVY0V3VVWnM1c29aSEMva3kySTFOZ3I4WE1UNXo1UDQzRUJVU1lVSWRvSVZa?=
 =?utf-8?B?aEpLL2VKcEU3ZExUZzdNdmhxVE9JR2ZWT2JORDR6dWl3QUpuZU42RFBrS3ls?=
 =?utf-8?B?ekkzMjdiaDVRQ2dGRExVTEt3TXRKSlQ5eHdMK1k5WTQ2a0ZGVSs0ZDR2bDRq?=
 =?utf-8?B?TENTODIwQWtSWVJOU0VsLzhSeE9WYlBSaWNMcDNKN3RwazNoUU1waGtHMnpY?=
 =?utf-8?B?K0IrNUpiZXhqUGUrTElHWGFzUVFIcUR1NnZzQlhZN0R1MzZTUW1GcWhsYXBT?=
 =?utf-8?B?Y0hmVlpKM3MzZi9ZQ2RxZTZpb21WSFIwd0hKL01kaEQ4S0xBZGpaVzhDZVV1?=
 =?utf-8?B?SDkxOTRrSXpMR0dCZ3ZoYWpkSnBVR1FJazNCL29ZcnlMdE95N01DTXFqdmN2?=
 =?utf-8?B?UkJQNGlkSVc4azZsTTgvL1BkNTdmbk02emtZUG9xUXF0RlgxTGFGTGR1eDEr?=
 =?utf-8?B?K2ZMQ3lxaDF2MWdKQTgyc2pGcDlZNHJVUk5ETUp6Znlpd1c4Q0NwUlZrci9Q?=
 =?utf-8?B?Z29jb3Q3dlhrZFFBSm5KSk5yWHl3dlNaQVNRQkhPc0JjWm1jUUpLMEI3MXRv?=
 =?utf-8?B?NlFoaFRIeXRsUkpTazhFajhUME1md21PblZhSkJtbEU4aVA0WWpRRFZwWGtN?=
 =?utf-8?B?MWRYSkp4KytsV2ZON3ZSQVczQjNYVUFiRHJ2VHlBa2YwSXZaTytQSUlBckV3?=
 =?utf-8?B?SUNjVVdKOWxmcUIycnNaWTZObTlwM0M2N1BMcE40UVlLTGtlU1VzdDlCWFlD?=
 =?utf-8?Q?FgNMNLBBaOQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHlnMTdqY29qZDh1QXNSbHVQRUJhakFLRmZkc1RKNUZJY1ZJODdOcFFKbENX?=
 =?utf-8?B?TGd0QVRReGtaRkRyK3ppZkxCc0d6SXkwS3FiZm9WeEYxUFJqZzRQTFhOeFhz?=
 =?utf-8?B?cHdwaGlSL3lYWkd3dmRHRmFaMm5iMG9wSUw0NlJFL2I0Y1gzaGZoZUxyV3ov?=
 =?utf-8?B?T0tid3MzN2w2SmVNWCtOOGZCbFdWWWJBN0gzbE5RU2VBdzd0ODhMWVk2TXdY?=
 =?utf-8?B?dkhnM3FSdlpFbnpoZ21qRTlIUVRFeHpjdzVuZ3NxWldsSko3dTdPZGtOVzBE?=
 =?utf-8?B?eDdBNnF6T3FXRUJHWFl3SWY3c3ZDb3pON3ZOZWxjcnhnQkpvNy9tYzJzVkhX?=
 =?utf-8?B?blpKcWw4ZUNmWkQ2WkdIZVpDa2U5TDg2bGg3alUrRUpWam5rc2JhYm5OOERK?=
 =?utf-8?B?dCtUZEljMGgxUUQxakJQcnRmNDR6dFVMQXYxUWZIb2Z1dXJtcHlUSXdETVVL?=
 =?utf-8?B?S2x4U1FsWFNDZjMwb2lva0prcUs3MnA5THZiOUV6b2VZUDc3NExEdzhEVlVB?=
 =?utf-8?B?RExuVndhZ2lmcVZjbFhUNy9zaXNSb1lLa3AzZ2N6cmhvdC93WGRvcnU1Vlgz?=
 =?utf-8?B?N3VBcENsTzdmaUJjMlJkZnRybjN2LzhxU3FJVzV0WWFmdHJKUUFlREsvMjFr?=
 =?utf-8?B?NTlxTUROODhMcFJFUDllZnIyMnV1UDRJUklzby9hN1dIbEhxVUJMVndHcGo5?=
 =?utf-8?B?T2ZuUHd1RTg4QzZCc0psaEN0MkZvZUszUGxDRFNsR25Wc0pGVlAxWW1kTUJQ?=
 =?utf-8?B?RGxlb201a0FpdWlqcTZCUmNuNjFtN0RxY3NuR2V5dlREV0hic0V2dXliUTRK?=
 =?utf-8?B?MEkxMVQ5TXZnNXV3WkFZQy90Y29EVCtOQXByd3JubVlrTVhheXJSMW5wVEhx?=
 =?utf-8?B?NktFcHc4a0VPWGZtaS9qRklrVUY0NVVSakxhd2hxQnB1K3NnL2NSTFREMDRZ?=
 =?utf-8?B?U3pFMUhiSXYwaklaNzVOclNURHVoOEJDVmVPdHQ3SkRDSHV4d01hWVZKTDhV?=
 =?utf-8?B?bFF6MlczZXZUVS9KK21YTE05UFQzL2d2WFdNWmxFQk5ILzgvOUtmOW5VVGlB?=
 =?utf-8?B?Y3hmaVJCcUxiSHp3QjVRUndacHBIb2piamE2ZTlQbUpiQlE0ZnNSclZ0dXdH?=
 =?utf-8?B?VlNGTnZPdlQzM3FBWUdRMjdTdTlFdHdaTjJxaTlBOHgybjlRZitFc0FZZGtl?=
 =?utf-8?B?UVZSYTNkSFpkZXdmek5PY09lc3g3M0lJd1QvQTBqRkpvZmhRV3hzcnBtVzlo?=
 =?utf-8?B?TjNjZ2xYSS8wdmgwWVltNDJrRDhCUG9YR1hSYWZ3T3phaFBYZkhNZXlsTWRG?=
 =?utf-8?B?bUZVVmt0ai9UMTZ0cW1HZzZ0aW9YNTVMZXZaOFJIWDIzZzBOZU1YNjZHVllL?=
 =?utf-8?B?WVRwNzd3d3NnSm9KRlBycld0OU40V3J5aUFYTENYUjIzdm1SSzkzSG91b2tM?=
 =?utf-8?B?KzBMdmNzVWNiQ21vS1RNOTBlMUxOZERaL3JrcTBXUGN1b25aV1hPakdmK1R3?=
 =?utf-8?B?OTZJRzFhUDFUNlFBRXM2Y2g3bXYvSlNUejE5cjlpWnF2Q0JXdDBZUjE2cURE?=
 =?utf-8?B?SFM0dm1HN01VUFREMU5OdEdPNGVGOUZ1ZkxCbVdSVlNPckZ1SnFGQkpwM1Zk?=
 =?utf-8?B?aVAxM2g2SWVhMEJKWWtzMlkyd2U3c2dBTFlDcEhVSElHSDFjSXhJckpWUVFL?=
 =?utf-8?B?RXFaczA4dVFnd25zQmtNTlBmUmxVM0VBdFVRQjhWelJXeEEwT3VON3BvUlJM?=
 =?utf-8?B?RWo1dXVZUzZGSjBLY2IwWU9BdnMwZWN2SlEvd0N5cXdaT2MwdHBEb1QvZUQ1?=
 =?utf-8?B?OStSWW5Zb0dhSHRiYmg1R0cxN2tzU1dQelRCcEtUb2JvKzBaLy9wTzNSSFJQ?=
 =?utf-8?B?Z3JndDB1bDdZZ1A1dTJMOVdRMmZ3T0YvdUpzS2VaS09DNkNrY2hvNkI0SWx6?=
 =?utf-8?B?L2huUzZITmpna1IyMllGT1hJWlVvRjhjd253OE40cDVRUW9yNUtzV0VtSHpL?=
 =?utf-8?B?NHFYb0hRSnpCMUt4Mm8yWVpQWGQvNjM2V3hPQTZGc2wrRUp1VGdKUDk2NEZ3?=
 =?utf-8?B?S2kydUVtcDc4L1JRNHROcE5XeWRCUFhIUk5qaDhkNlp1anJPbVB6RFNKT1cx?=
 =?utf-8?B?QnB2bGYrQll0QkRaOTEzcWlTMUVOTDVNS1MvVExxa0RiYktYRWhQMnk0eVIr?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fba0c8-84b8-44e2-982a-08ddadb0233f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 15:03:37.5482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZaonulK+80gqZ5Dyc4Vi5dQzW9AkMCEGwNUTSIhAMwkxspGwz9jDvpYma/RoTruClB/ooE3xDbjFIDPwl96lMCXIKjR2Yi1UxiM7APDJzBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4872
X-OriginatorOrg: intel.com

From: Shannon Nelson <shannon.nelson@amd.com>
Date: Mon, 16 Jun 2025 15:44:37 -0700

> Brett Creeley is taking ownership of AMD/Pensando drivers while I wander
> off into the sunset with my retirement this month.  I'll still keep an
> eye out on a few topics for awhile, and maybe do some free-lance work in
> the future.

Didn't you think of moving yourself to CREDITS like a true veteran?

> 
> Meanwhile, thank you all for the fun and support and the many learning
> opportunities :-).
> 
> Special thanks go to DaveM for merging my first patch long ago, the big
> ionic patchset a few years ago, and my last patchset last week.
> 
> Cheers,
> sln
> 
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Thanks,
Olek

