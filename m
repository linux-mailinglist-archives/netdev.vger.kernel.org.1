Return-Path: <netdev+bounces-202917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D87AFAEFAAD
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B197B1887E25
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54060274B53;
	Tue,  1 Jul 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PeAnyCdL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D9274B58;
	Tue,  1 Jul 2025 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376456; cv=fail; b=gJp25mZOnGkqLPhHuh7bJHnQ2rucpoQR9lLan1MPRMLcrOpxUv+OCQU85g9lJUNkVX6bTsJSXhwQ0gNwPmZH6aXi6A9pEehIxfDjvzZt62yjoT/X/xLlvwqqQOkHI4Os3aQ2ZjPN5KwXNqk3u67PxQsJcmbA66sL+FuNfolS38w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376456; c=relaxed/simple;
	bh=Dp47gDSAjg/4MI49IA9g4Vpd9ItEzHH7wHVCO9ARG2A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sVVgBgoYwCPTC0XagUWaA+zHtVRWXcV8Ngdca+jfEqgCt6lha/UD65oOnPmzAHcDP0qU/35C5yHXsGgbMro2b2q80np8+0xARJUWZzcoOdNemZWIee7nJY+knNh7l3x1AZ/fvWFDSuhoV0Wkl1t+uktPYGFTcEwUpdxJVwIZ6Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PeAnyCdL; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751376455; x=1782912455;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Dp47gDSAjg/4MI49IA9g4Vpd9ItEzHH7wHVCO9ARG2A=;
  b=PeAnyCdLZ1mX6oHhsIythXQNShfp99wY1IvveOOalE3MpnS4tbD8f4x1
   8v9G+ZFIDOo+hoOd83p21BA2f7ozXdHypl54d1SEcIBd6evv0U9Mxv+GA
   ropYMs1rr4SFordYc6VVmFFw06O0TAJzMeR9VPkfP8EYsoTPfO1a1WSRT
   YgVZ5oaR/JEZtMxp5LNQ9CF7GN1bSselgPiDoDsmaz8rSLI4x25dYdHax
   0BPXjLwmDtRRuL42QSF9TtHfOyn+701yLjedoGgxf6DUsIN5iMUVHD82e
   w3fWrub8VRzJ8UdEaFvi6fWMIZ3zXGteCTEeIGqFZZ6GOnhVJoiXM6G8D
   Q==;
X-CSE-ConnectionGUID: Fa/ESsrEQMuLPV04T8vn6g==
X-CSE-MsgGUID: PRSvHLuPS4iA+a20qAMIJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="57418528"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="57418528"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:27:34 -0700
X-CSE-ConnectionGUID: r55dBNRyRpGo6GvxerHI2g==
X-CSE-MsgGUID: DXGR7APHQJqWy4QS3Mk1gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153856173"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:27:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 06:27:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 06:27:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.86)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 06:27:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgkpMSCV+JebOwb96Y0wgx9FTpmiosbpl94KCVW6AzrIQ2ayS4yKmBO1aGDw2aWfpHw4FPDoIhrVLPuqurSykM10yF7dWfJLAbTLlk1o6vjijPTqUJ2lBfZ3FlZcGPTdA3gcbF6bXp7/r5QFAs0cAF7ABKQ22bQ/lnLq8ki91pmL3rw6XCKMIPMojkNK0iDvnjUWxsYPATkqjWzVFlhCfuLu+GoXzPdabbJQZIil4KWsS+Xe5YG8qYupIWsvlDulY9Pab/9XZ9tWgn1RiteoIraTsrma9mbBrfTveFJpI7grcWFeDLTOv9PHtOjnsDkG2fjBkzn7kEhSbzvPV/uMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiTr8A39blS97lPEuuKD6wZSYt2hUXmrKYPdFx6Jh8U=;
 b=JvXXFa1+d/flicAvgPuhEux3Ht+XI371y+YkJO7qPM58joUOwL9Q/5G6riO2ablRscJxrHoC/TtkqAKFvbaT4DkIIMqBs9ezBFxN9jTGLKmFL7B++yLW8H/tQTGH5xEecHojV7OK3JxqsuzbjA6Xb3LK6gFPdXcak3AO3L56vaEGyorl7ySf7+rQCU52KVA6QkI3hXnsWf92JZGxD+NYhRnvkLggQ8bGFlNETpouCSnX3/iPuhEeEPNNaTUz/yRy2/xcxHb1O62gNxiTmeys2kj1qBAuCrF3BgG6K5mBKg1gXulvaxCkIoKJ+jsmEq2/7iS4CLGp6xLZ7oVy8+aaqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 13:26:57 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 13:26:57 +0000
Date: Tue, 1 Jul 2025 15:26:48 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Fushuai Wang <wangfushuai@baidu.com>
CC: <ecree.xilinx@gmail.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-net-drivers@amd.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] sfc: eliminate xdp_rxq_info_valid using XDP
 base API
Message-ID: <aGPiGHGjtWAgXxRG@soc-5CG4396X81.clients.intel.com>
References: <20250628051016.51022-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250628051016.51022-1-wangfushuai@baidu.com>
X-ClientProxiedBy: WA2P291CA0035.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::11) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 01676770-b969-4c65-9f58-08ddb8a2f3e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VsreHAtm4Mso72r65WYouQkrJ41CRAVN2UZH3WSCEud2WdL+VRvDE2puq8HW?=
 =?us-ascii?Q?ZrkWasy2D805PVGxYkPT4kukspNV3kcUO/TkPsILQjY1sE8Ueto3+XkHrtUM?=
 =?us-ascii?Q?x/qmgg09XoAg/DQ6QJ+5q0HSOXtxYUYU00anlYsRjBB2d2eqCAB/dfOg7E3L?=
 =?us-ascii?Q?9TRYyB/SiaK1AUp7smoD5rNI1pZtGt0Vyl0Q8Ea+8TqUs6wnlWzaB3x2Sgah?=
 =?us-ascii?Q?AolstrMBuZlhykM8Xq1JCLKhmz7cTBaQDf5EcJevavfR/VyPleGLzMmbbcUG?=
 =?us-ascii?Q?QHczmOZCP12KWrqXPufqsDy3ipmxew4LVggm5Xnbe2MZbbqkshfztWB6yYnT?=
 =?us-ascii?Q?jqsE42O8H9Pyvnu2V8ja0nodtMp95jwEGvzQESci+fqwiZu3jZNek6J0C8Su?=
 =?us-ascii?Q?TzGR64AISr9fOyhrDaICHssp5B7VVWyFh/nAjVgF4rX9vYhiA/yHErVh7fFA?=
 =?us-ascii?Q?o6zibuwjQs1tCQpMMcaRhYzEYNpgOPoamFo02qoyxKc+luVYvpuMDTYtLldd?=
 =?us-ascii?Q?rLBwMQ9zKfmS7KEhYS5kt8DKj/uoT5rq0GH9yAzc8CCMIWCbECI5Z4jGuYI0?=
 =?us-ascii?Q?u0mIteXRhotQdz64WrMZZOvk5b0gXx1CWTE0kDV51TLwX5cSlZn6Q1iWc8bq?=
 =?us-ascii?Q?q3lWwKpExf1d70M8QILldRfQjvx03J2lBxyjMBB2sYioXgoP/k0/XzeG8ijP?=
 =?us-ascii?Q?Ft81n/Uf+94FvGLvy3tbycqtNgy32jbZy21IQPRHpvScxf46kb3FuF7YHPpf?=
 =?us-ascii?Q?6pNyGMb1afrxM8rydYZ0fhJLnkQt1QaBEeNXEcdbLQE4FVEPSN0lZiW8qDJ2?=
 =?us-ascii?Q?zn8OQva2Q5MsJ8ZjyRFo3qIL+rUrseTwVCKTJnf6C3jw1OSKZzgXgK2AI0mp?=
 =?us-ascii?Q?ycL0N3lOQZlwmtGmSLbj1/rrKSFVcbYi0L3Av0rn6tuqrV4vsUyU/tiKPFC1?=
 =?us-ascii?Q?LWkSTJx0mwczbmx9soVPDKS2w2LRk+UTH1R8JJJwOYX4V4ftLCo3anqH/zzZ?=
 =?us-ascii?Q?4k4DLc38Y8xdSS/w3SEWsRj9xd6tIReDiniqc+dZNn741ldbpw+sHS8Xq64+?=
 =?us-ascii?Q?PVQ0v5iK1lWHq1WD8O5qV3SkZR1yoSnvIwib5Q/bk3zN0ONZrwEr10lGQqrl?=
 =?us-ascii?Q?NlTpxw8ziLpRt8kQP3PV5lE/zDr1zM2p5zwnLMsEk5N4mJ4WN9AhvpHPf+Zr?=
 =?us-ascii?Q?Vu2HEBvI7jJBjzSEkr1JjX0zQ0xEu+clvW45P99e0OpDgEVIC6I0snikpwzd?=
 =?us-ascii?Q?7rwE9DVE/m7blRUbSv1iZQZICeBGWmvNNeYgGEwtNF6NCW0xpSSRhUAPUzLr?=
 =?us-ascii?Q?NcLbnDOyJOagsxFRROtTZLARo/n2jT+8HrWqXPNORffpsWaCXjeEKf4PUD55?=
 =?us-ascii?Q?+v+2L1AP0QXUQ/s/6ko1g2fwIZzY9UZIfZDfSDNwiO/LaeJ4GimXgBv/9eay?=
 =?us-ascii?Q?aICCwxLKn3I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R7lFThIZm78TrlcjbeelV2U7Mah8jkVpQBu2xvgeQSE4rUxvhvrQPLKqQvJu?=
 =?us-ascii?Q?8OBdUezuXvnzPAIr1HhUGk6Klmri92XJ5Qd/M6Bz9njNDwYSHrF1wcMScQXN?=
 =?us-ascii?Q?CfhKBUbhwGYvW4MyCSVm/VqcQbz8qneulBHhM5HmvlX1T1bi8JduUpKNTR2o?=
 =?us-ascii?Q?SK5D/xRMmCHLoDFMtw7yLFwiMXh2lFBHWXlS1bvG3J3V0PMEMd8qL7rIRf4u?=
 =?us-ascii?Q?8dBOrTh2MDYBBRNMYg7T88CYsFSN2zo77hW8ePmPTJjDAbXyyjhAEaBHMN6s?=
 =?us-ascii?Q?LK0wx0oNFkDrm3r0FP+sKT2o9+7RMf6dTF7qaeKUXODKhsPYoZg3SRcrRQcY?=
 =?us-ascii?Q?RAN/P1LLJOkYy6rI58+2bvsmoJzl8lNDgfQ5A5WKZy8NSr6iAGcKBIpsuNLq?=
 =?us-ascii?Q?jIokQ0bUCxULLAxetxWuxwWSXHA2YBOS6FQ9QClNJodv7aFDO38BIfyciPum?=
 =?us-ascii?Q?qi+/G967TWyAgpns0RWz6s8TAqPBc8zxas2x1aJk5PJSkwMVsCBJZSmNlw6o?=
 =?us-ascii?Q?7pyw0r45QSubCyxlusC/ouyFHeD/+RUaiYZMrOAoZ9v8f8nAYvwxD/BkRG2S?=
 =?us-ascii?Q?4+YeF5adn8rUeoutqhJUdOaa2+EFgFDaFb6N7OW/h5+JnVejBqoR5zPWfiO0?=
 =?us-ascii?Q?01h3cEEOiK4JN8RiGjtTegVgVxyn5E9OoA6x17MAE3QRQhvMl5kkGAdAAQZE?=
 =?us-ascii?Q?pPPApN7Hbk5gCngzQ0zwG9SNQaz2QD8pxMrXNrFaZ4nbLcJ5064QsyMnTLhL?=
 =?us-ascii?Q?dK+8pgRfsC/J0aRqHeXg+XXvLmccb5Bv1Rj8YzDhr5ywy+ZIB89te/PU2YKh?=
 =?us-ascii?Q?JG8cebtRQbIuI3lCabER5/3SeJIVzvvp0oVS66Q0wn8Owqx2SB2BBW+LakGj?=
 =?us-ascii?Q?6Q/19gx1gbRoCPGPVk3hsdbsc0wMQc4B/HSneAX7ntzbGtZkQjIJ6qkCqaRQ?=
 =?us-ascii?Q?t5Hf1NOx0BH/WfJke+GCTxCuoY0csNFSBLy1KRTdE2ittV4Vspl5Xt33cviN?=
 =?us-ascii?Q?uHONcjAFHrVuwwrPtCHONw77iZk8Zx0zi1qJrxTznCaxNwfGs0oq6Lf3qTfZ?=
 =?us-ascii?Q?/j/RuYbBqLe5a8xRV6wA9uRA6VinS5EePydrXM3+hzUfyhdr/EO8E+t+iITI?=
 =?us-ascii?Q?lT7wbTSNG7ytJnUc034FSS3IymTGm0lmZfoAb/W2s7AmWfCLQpUCnI+X7qkA?=
 =?us-ascii?Q?7k1P5cwndM3kxAq9PARU3t5H6OeL58vg47HENZuSMeZM/h8+OcNyfhjemqgE?=
 =?us-ascii?Q?k7wvXyL3T5bUx5cDal4CVaqyIAl9vyGdCclq9kyXbjity2RuP9eDp6aHmXu+?=
 =?us-ascii?Q?u75tbEYVQONZYuT4oFPjKBhrFtD4F2BsLxBdBA8IgHfq8J0axcOChf0qZvSF?=
 =?us-ascii?Q?yWoj6ChDYYQIA1dOl9/COCUyYJaaQ9CVW/LlwZzFkFo7YDXimxOdRViQzfjD?=
 =?us-ascii?Q?UosmVeDt79xh786in8XsnbzYutnFgpLUNjF2uEn8S0SlYLOa7rfHVI7iSFNO?=
 =?us-ascii?Q?7XOZ7vzLvX7AvLnQfmRB+PHQYkTx1mL0FdlmykywxCygtsLU1axqEWQHiOeI?=
 =?us-ascii?Q?tYbtqRCON+ORKKVVAjKS77ScAWYGnnFJRpLVUSC48ipkZrLgn9RPu7GpB4EB?=
 =?us-ascii?Q?YpRroj7xOnOwGtsv4V4uMk1wrTW9DVHkYRQ2hzQBrtpnLdguIimkVL+ck/Oy?=
 =?us-ascii?Q?65biBQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01676770-b969-4c65-9f58-08ddb8a2f3e5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:26:57.4927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2kv7QN8jhIX2gyV/G7AEqMYISfrJAEJCbN1paCQK6cWzJAz9V6KZs4aUiVlFhgBtUcpYMJfLwXVQgOhxSXEGlU0fFAtDNW8FBy5hf9lHe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7309
X-OriginatorOrg: intel.com

On Sat, Jun 28, 2025 at 01:10:16PM +0800, Fushuai Wang wrote:
> Commit eb9a36be7f3e ("sfc: perform XDP processing on received packets")
> use xdp_rxq_info_valid to track failures of xdp_rxq_info_reg().
> However, this driver-maintained state becomes redundant since the XDP
> framework already provides xdp_rxq_info_is_reg() for checking registration
> status.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  drivers/net/ethernet/sfc/net_driver.h | 2 --
>  drivers/net/ethernet/sfc/rx_common.c  | 6 +-----
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index 5c0f306fb019..b98c259f672d 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -404,7 +404,6 @@ struct efx_rx_page_state {
>   * @old_rx_packets: Value of @rx_packets as of last efx_init_rx_queue()
>   * @old_rx_bytes: Value of @rx_bytes as of last efx_init_rx_queue()
>   * @xdp_rxq_info: XDP specific RX queue information.
> - * @xdp_rxq_info_valid: Is xdp_rxq_info valid data?.
>   */
>  struct efx_rx_queue {
>  	struct efx_nic *efx;
> @@ -443,7 +442,6 @@ struct efx_rx_queue {
>  	unsigned long old_rx_packets;
>  	unsigned long old_rx_bytes;
>  	struct xdp_rxq_info xdp_rxq_info;
> -	bool xdp_rxq_info_valid;
>  };
>  
>  enum efx_sync_events_state {
> diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
> index f4f75299dfa9..5306f4c44be4 100644
> --- a/drivers/net/ethernet/sfc/rx_common.c
> +++ b/drivers/net/ethernet/sfc/rx_common.c
> @@ -269,8 +269,6 @@ void efx_init_rx_queue(struct efx_rx_queue *rx_queue)
>  			  "Failure to initialise XDP queue information rc=%d\n",
>  			  rc);
>  		efx->xdp_rxq_info_failed = true;
> -	} else {
> -		rx_queue->xdp_rxq_info_valid = true;
>  	}
>  
>  	/* Set up RX descriptor ring */
> @@ -302,10 +300,8 @@ void efx_fini_rx_queue(struct efx_rx_queue *rx_queue)
>  
>  	efx_fini_rx_recycle_ring(rx_queue);
>  
> -	if (rx_queue->xdp_rxq_info_valid)
> +	if (xdp_rxq_info_is_reg(&rx_queue->xdp_rxq_info))
>  		xdp_rxq_info_unreg(&rx_queue->xdp_rxq_info);
> -
> -	rx_queue->xdp_rxq_info_valid = false;
>  }
>  
>  void efx_remove_rx_queue(struct efx_rx_queue *rx_queue)
> -- 
> 2.36.1
> 
> 

