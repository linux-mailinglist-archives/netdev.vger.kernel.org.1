Return-Path: <netdev+bounces-132271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299B99125E
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAF61C22EFF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC16D1ADFF9;
	Fri,  4 Oct 2024 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4a31lXF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEEC1AE018
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081383; cv=fail; b=YfinvOAR4oCHyIwCKmK4LKfijUf8rqOiT+c8ieBOJ7nD+/MKlPz7yTR+jXR+aeOOEW8g49Xj6+zO5+xC7aV41BzpjX0kryEXOwTsiXKsIoNW6DjcHS7FACiVEvBCGuevHUPlQGOj4ikUd7dDUlGCpJPEGr10m0MWO8rKNgL9/UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081383; c=relaxed/simple;
	bh=rv5eRb4kDKlpCxpzUxP+U6weBG+ppxR0KHK8XCn+CXc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EX8BQC8wnsEgEkvTPdO5A2VaQ5GWjsVX3qoDDEOtYFXz54mgYWah+tIf5eIlR/dCBYGK40GYiLdUwinYxZ5uibVberIoN+alWPOY3liYJydSH5+K80dHa/8rfZ+UYd8kh38u+i3DHvQ27GkQViTgwRP3ND4jtkAGEa2U0v0ieuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4a31lXF; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728081382; x=1759617382;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rv5eRb4kDKlpCxpzUxP+U6weBG+ppxR0KHK8XCn+CXc=;
  b=R4a31lXFYQRVzNhrq++k20N+NqEr54lMYMebc/wsuJCq7DDEH/U6pwn7
   skUrk+1q5gTZnxbxEntTxrORsiornsa2vzTQVaD+QbJqdMr7Z0iSt/Je3
   iF5iG7ag0h3Vj2eGW3mcFAfFilOjBHxgxSzqnogJSW/BHMcC9RTzi3+iy
   Mc8yEcWClrsUF6Jx4n6N2MrdhgXlHSJ36dyYVbe3U5+QxzaZQkogUxjEg
   NlcAvJBRjFuz07vOgrpIEU4q8VoGuJBma/GrcXyCyjSaUPt5i2Jf7vcfp
   56QNYP7IKbGa2rAYaekfj1NR+WIQkc+MR3Gl/cgm8f4+yUB5lUxh8rQA2
   Q==;
X-CSE-ConnectionGUID: prYpxOI1RVSQmIq1ecY2Hw==
X-CSE-MsgGUID: EmXLP5NLS06bvdJaHEa51Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="14938234"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="14938234"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 15:36:21 -0700
X-CSE-ConnectionGUID: D/RLY9+ATd2b/sdphtb1aA==
X-CSE-MsgGUID: 0SOIy4BFRaayChCs7I7fWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="74428522"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 15:36:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:36:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 15:36:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 15:36:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeCWpkMMUZGqwyfVedqiixfsXRzMQmteCWDEWZxub2Yj9EL0cnAslRc+IAYcxL3Yb9IoPUJbSePCCvKz8dyqmwKnmYT7VADyZCp2QivTPqELjtZoE4WZNamL3fpZz5tQ/mmIAaUc2HF4y8z7ipjeK3OHP245IozKxtPuRI/rlUL3cvM4/5e/WbHxcQa4RdBqRaaHy24edx/gteyZKbx/gJFxv8Gp/fSJJMlvzGiuTJnvBJRQ46APu5ye/3sBA5Rb4Vbzc6UWZXgxN2mXkg6bfSnqLaQ3Zv/l/9nUD/vXjQq009NJbKWv+sLFvgdFpzYj+TZ0SGz+5j4uQQ8hRxCFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VwcaRYkQvIm8MbIQXGniNkQ9nleWxAEy/Gp9dZnHcA=;
 b=e4vyfYPCs4xdGnPeB4IzXZ6r0fj+92ELRYjZjxtjnWNGRhxX+az3t9tebj5wcIL/pKKJtQHdX4CHU2ibhiUZ+09bbpDpmS+sDD47Plxr/CXk7QEYrImlKS0outJznlQujnQ6bbg4FmfWGMX1+L/vixEICpSusy5iPmDGbQA9RrVej46rdh8oCO4XAUnovKmqazVJZ9T1V6kbnLvoHaHBRB1r4JfOB6bfpJDsJyB1ZbBBz5ZuWRAB9HfklsRdr4DNUX8MCk5PkuZkeFuL/RHx2kttS3DXY8uBz+P1vj5JPvkqJOOjtthDU8YesKAZoNNVsCwo4O/Y1154JkcPXo7YkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 22:36:16 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 22:36:15 +0000
Message-ID: <72c15af0-001e-4479-8644-0f25cf9723f7@intel.com>
Date: Fri, 4 Oct 2024 15:36:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 2/7] sfc: implement basic per-queue stats
To: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>
References: <cover.1727703521.git.ecree.xilinx@gmail.com>
 <f9c5d5c041f4fe8ab63d3ee558d01e0d79645837.1727703521.git.ecree.xilinx@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <f9c5d5c041f4fe8ab63d3ee558d01e0d79645837.1727703521.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:254::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4719:EE_
X-MS-Office365-Filtering-Correlation-Id: c44e5877-4386-4687-c963-08dce4c4f4eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azgxWDRoOURVWVBmQkMxQzN2R2xFQjJDTmJXM2pheDRKanZjZWVHR09POWg1?=
 =?utf-8?B?L0NhVmZFTUNaRHF6cFdyd1RBZmxmekdPdTNFNks0QUNZTTRKTGFrVlBmNXpF?=
 =?utf-8?B?YVpRMGNydjJRVWpuZ3lVcVZrOUpSZDVvSkF4OVhaMjhBTzIzaTlValpuT0py?=
 =?utf-8?B?NGZST3QrMndhRDNmc3hPbm1BRSsvREp0VVh6WDFvampsQllCUHhGSWZUMFg1?=
 =?utf-8?B?V0NRRVRoUlp2OTFsNkszbVcvMGdXMVFpTDBYb0tGRE9tNHJnU2dVQ1NhQTZw?=
 =?utf-8?B?RG9DUVlUTGN3MUJjazZya1VWdjZJNGYzV1YySUc3bTV1UmNMWFRrOUtiTHNC?=
 =?utf-8?B?QlVtNjlqYkh2ZHlwTTUzUFFHK3hzaEdLOTFrK3RaU2RrWXd3VklZYmFYb1ZV?=
 =?utf-8?B?Z1V4K3dzN2dMSXVtZHk4SWRNWmREY0U1YkNFMlc3eW55L01QQ2ozTzcxbmg3?=
 =?utf-8?B?UDlRY0k5eVZwUFpYZGZWSlByT1BkVzFJbDRvUUNWbG12T25lZUhGOVpxQm53?=
 =?utf-8?B?REtUNUdQWkVXRitDK255QnE0SlRRYXFFaStTT3RjR0VSaEJsWkRVTnpTSis5?=
 =?utf-8?B?TGRsN1RYWm5YTWNUWFo4QXhCR1U2WFBPZDJKaFk3K0FaRk1aWnNlajZtUjJK?=
 =?utf-8?B?a0FDSEtrUWlEZlNxeG5yK2hzU1dGMDdhbmgvcjdBcWxDbGt5TWpnUzNPcXNh?=
 =?utf-8?B?bUxGUGx4Vm1nVVRLNlRiNTE0SVZYTmVNRnVndDZZdDQranNaRk9ZdWR5emox?=
 =?utf-8?B?MlFOTUZhV3ZzUXhpY1NLUnZ3aHhRRTZITGdBU3dhOURVMmRYdXVjeHJzaU81?=
 =?utf-8?B?eEZwZllRbGJVb0VtNFZ0cTBJUDljM0VwQTFDQklQSnhEWjBWNDg3NEUwcGdE?=
 =?utf-8?B?cGc5QytRQ1J2Rm4vZjJBdGduQWliNVI3dWp0dVJ2NmpleVpYM1ZjalJ3NnZl?=
 =?utf-8?B?dytXcDhtOFJ4M1oybGx5RjhERjVtamFIM1pRN3JjTXVGdGxya0w1dk5wcE9U?=
 =?utf-8?B?MXVEMWN1SXdvekhwYlF3UU5vamRXc0JLZTg0cCsvNUEyb2Fnbnc2ODBlRTc0?=
 =?utf-8?B?b1pjMml6eUJCOVVYOXFqREZVK1U2RGFsZzNEdXhUUE9DZGdvbnQ0dnZiSkVl?=
 =?utf-8?B?UG1JZ1g5WCtjTmZJRXhaUEp4cG1yT3R6WFNEUlRlZ1N0UVhTZVg2KzNqR2Ux?=
 =?utf-8?B?Rk9SWUFEdzF6UlMyK0VPeWhvZFMrQlplTFllbi9nSkxtMHY5YVI3WkRDQml6?=
 =?utf-8?B?ZnU4Y3VGenRaOStSMW40ay9QOXc2KzBwQndkRm52NnhCZ3lSUXkyclRiaEgw?=
 =?utf-8?B?Mi91OW1jbjNUSVc4T1hySzV1NmJ6MDJ6QVVidnJsaWt4dEhVRHYyWUZLaUx6?=
 =?utf-8?B?ak1NZC9aTWtGaGwwOEJmUDdtalpyMnJXRHZKSnFnZ3ZEOWJub2JpRXVmWXFF?=
 =?utf-8?B?U0JNRVk1WDlyL1N2eFkyZFVxeFhlTUt1T1h2NmtnYVB6VVBJZ29aR0lWVVRa?=
 =?utf-8?B?d2JNVlpuVG4zY25LTkx1Wm16UC9XalFnMlB1c0RTQ3Irc0tOQmszZ0dra3dN?=
 =?utf-8?B?am1Vb0Z2WlFFdDYxaW1jSkRzbEdWaHo5aS8vanNkWXdvaWpkYXltangwWkJi?=
 =?utf-8?B?ZWlYZWlRTElwTElMUWxnVnB4bHU0TGJjWG5uMmdFdDdpbC9UNmlvV0ozdXY5?=
 =?utf-8?B?REd6YVZGWmNEbmxGUjBXS1AycGtKaktXZlk2SzkreXBOLzNwNDVodFlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0g5b0ZiR1lRV1pyRWVhUnB3R2RJUzVjeFlxc2c3UHd4UjB2QVIvOU5hTW5j?=
 =?utf-8?B?VUg5RFpVaXd1T3hMK0RHcnErRHF1eXdGU3UvbkVZaTdEdUxpc1VCdC9vcTVv?=
 =?utf-8?B?ZDRNV0dNUWpxcW0rM1h1UW52MGZDdUkyazl4TGhaRWlRaXlnaG1TYkNWQllS?=
 =?utf-8?B?V2FHV3NuT3FwWnBQZVJmem16Z0d2TGg2dllYZVBkY1h1YnJJc0RoRm9idFFa?=
 =?utf-8?B?cHhGZGF2M0tlR1dybEZTSmJVbzBvcjBVeDQ0WU12YmYyU2VxM3JMbU82Q3hp?=
 =?utf-8?B?WjJyOEpYSnBGbWxOMWtNcFVsNTZVUExLQmp3WmRRNlNmQVhiQTUraDRlUjBR?=
 =?utf-8?B?ZlBDV3doRkxmMG5xSTdJQzdPZnRLMmZCNVJzYnlBdUZ4NlNvYzJ5TEV6dFlq?=
 =?utf-8?B?Q2J5Mm5iR1gzSXVhbXlhRHhpajgyNlVCVW5mL1c4NDFoZEdtTDgxMlVmUkNB?=
 =?utf-8?B?MG56M0NmeFVTODU0djF6YTFjeHVYSjlUQllkU1BMZEFvOTJnSGhNUjdOSExz?=
 =?utf-8?B?R2YxR3dRaEZ0azFZbEV1WkpxS1ZXRWhSb0prOWh2V0VhSGpFbGdtT1I3blkz?=
 =?utf-8?B?bitKNU0ralkySUFjZVVINGpVTTd1Mk5pbFF2alg3ZG9QYzFTbkcrTVpqYmdI?=
 =?utf-8?B?WEZ1Tm1ROTFJNDJJTlNETDd6b3kvVmtJNkF6Z2RkM2tBTjNEWVpPcy8wYmlC?=
 =?utf-8?B?MCtuQWtwOG42Qkd0aWo0Y0VnZG9sTU9RWDBvR1QxSFpoVWhkcm5ybVA0dStW?=
 =?utf-8?B?MVBNdElxK05XdDZLTWJNYlRIakVJSFV1TDg0V3NmVFIrY0F4cllDNG5wQ2ps?=
 =?utf-8?B?RlZqQXpoZjNPdkpsdG1jMEloZkovSVJSTnFraXVkZHl1Ulh5VUQ2NnREeXdE?=
 =?utf-8?B?anN1YTRxNnUzckcrYTZORElocGFhcU9BS0VTZFNHSE9lUmE1UkVzc2NJYlJa?=
 =?utf-8?B?bVMvMGdXN2gyUTNMQ0doMnFvaUlwUXRWNWxNQjJrRGhuTWxUbE9WKzFwbFJI?=
 =?utf-8?B?c2tNeWVXaU5VWkVOWmJ5M1lzRUlBaGNOWmVFbDZaSnZBY256Mk9tNW94Q2hS?=
 =?utf-8?B?WWlxdE5jbFlURS9uOWZyRnlyT2JYbU9rRXB5ZUxOQlQ2NVVLbVNwRkZsK1lk?=
 =?utf-8?B?S2tGTFAwc2ZFSVo4TXdyblRZZW8rc2dlUWdnM3htUHorTGhMWXhxWGh5K05l?=
 =?utf-8?B?UnJyaDVsOU1XNkUwUmZKSGNDVTlkSnJOZG9kem9kOXZFZjEwcG1oQmNtZmlW?=
 =?utf-8?B?WDRwcXFNOWw1N1pMN3ZiM2lVMFczTUhLZk5lalhNRGl0aU4vallqdDZheVNm?=
 =?utf-8?B?YUNsNDBrWDhvOE0vb2lTUHZKL2dCNlN6SVdEbHZLNDU5dzRrNTFaWDNMQ2Vq?=
 =?utf-8?B?UzYwcXF1UjZuOE1tWW1IVzhBUFV1ZFRkUThTTkRYTmRnM1BFTU1HSXBTRkVi?=
 =?utf-8?B?T1dUV1RGbjI0b1hvZGpQUVdsZ0RzY2pwRzNqcVpNSU1TNWJPSkFFNjJ0R2hv?=
 =?utf-8?B?RGVsYkgwNk40QlhoV1drWUZLa005R0lnMnFPNWQzMWtlcDVpYkFsbFpJOUJ5?=
 =?utf-8?B?cUVXQnJISk15NXp2SnNXV0RPMVJOVzczSDFieCtvc2ZRdVVxNlFwOS8wOWt3?=
 =?utf-8?B?cklnUGFxWlFrU1ovMUhKWmpIb1pmdmpHaHpVaGJZbDBoNDVieTNhMHdHS2h4?=
 =?utf-8?B?aXNwSUVMczZLWE5SVVd2QmtWZ1Z6OEN6N1BNWVFjdWQ1Q25ZdmwzcS9oSjlG?=
 =?utf-8?B?OVp6OG9BakY0ZDFSMHRFS3prYXB0TUlYM2pBR05lSy8yUTVxUExYazFzMDRr?=
 =?utf-8?B?UmhYZy9EVytncU5pOGoyU0Z6VUt6QWlva2ZCOTdDWStKdVFvRjZoMVdPVGdD?=
 =?utf-8?B?VHlBenVPK3c3WitXOGN6Q3BCamlkOU52dm5vaDZtV2JGRmJKZi8zN2pweUE5?=
 =?utf-8?B?WFR0Z1dITkRZTWtZQ1c4SFB4aXJqZG1UMTQ5OVFOVFcwTnJUbGdyeVJCSW5Z?=
 =?utf-8?B?RkliTjJSdURHaHlFUVpBZkM1d3ZIN0Q0UVJ0b0N2Q2pXQ3hqVURXUnI4aHcz?=
 =?utf-8?B?RFVTZGdyakxEZ09TLysraVk2N2MvZ1JYdlorWms3WFZiYkdRL25yVzhIK1VQ?=
 =?utf-8?B?ZytOVUNCbXV2Ryt4YlFESDk3N0Z2azlzUGwxbUlZeVBFemVpRlludWkrZWRW?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c44e5877-4386-4687-c963-08dce4c4f4eb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 22:36:15.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fO8QKIeJoQSbv/RdtzSC2U+Dt5SGPoM5/08fA0i+wA/KgRZoZsKBRbUP+S5FK9dd/WIExlfGh1n0pOSH2TAlOcKM8t8v2k+cmsUbqiOjUtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4719
X-OriginatorOrg: intel.com



On 9/30/2024 6:52 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Just RX and TX packet counts and TX bytes for now.  We do not
>  have per-queue RX byte counts, which causes us to fail
>  stats.pkt_byte_sum selftest with "Drivers should always report
>  basic keys" error.
> Per-queue counts are since the last time the queue was inited
>  (typically by efx_start_datapath(), on ifup or reconfiguration);
>  device-wide total (efx_get_base_stats()) is since driver probe.
>  This is not the same lifetime as rtnl_link_stats64, which uses
>  firmware stats which count since FW (re)booted; this can cause a
>  "Qstats are lower" or "RTNL stats are lower" failure in
>  stats.pkt_byte_sum selftest.
> Move the increment of rx_queue->rx_packets to match the semantics
>  specified for netdev per-queue stats, i.e. just before handing
>  the packet to XDP (if present) or the netstack (through GRO).
>  This will affect the existing ethtool -S output which also
>  reports these counters.
> XDP TX packets are not yet counted into base_stats.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

