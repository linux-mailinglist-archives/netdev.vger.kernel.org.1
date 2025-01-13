Return-Path: <netdev+bounces-157856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD62A0C101
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E84D3A3101
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17DE1C5799;
	Mon, 13 Jan 2025 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUtSqLwK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67751C54B2
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795275; cv=fail; b=Y9G2TTL+/zcDpd1vDEs1ux8bTsSkhWF7/LtRUGFqif9OjDpaHvjO4GtTGOhqrmF2z7rpAF9hrxiNA2C8U9BQemimoMBFPUYbzNGckyuOTSLvK+3dX4k8vB6GCQf5RJbup4/o8iCA8DSIMYghY0TSZn8jtHhWzZdLR1eKqT4p/ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795275; c=relaxed/simple;
	bh=ntDdmK4GLozihUZQHlwAEBSNNbUWp4kdG0fj3g4xWwM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=st/ZDLppued6acqb+w90FktZBHxMvkmjqJGsFKjkHHUXsb5o1w/Cfy66707dPKBMdOLL/g+gonO+xupzaLg/+bOTGPRImyYmVmh2YsbuiUbKRogXh/KtKGr6nsRBv1efXOFAHNyRhOVhHNZF7VScn3tOululQM7vch1g+UZNdBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUtSqLwK; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736795274; x=1768331274;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ntDdmK4GLozihUZQHlwAEBSNNbUWp4kdG0fj3g4xWwM=;
  b=fUtSqLwKUuL8S4wPIuwAm3wuDlRlYFbg4IWeI+6pC4Qpd0cJ7uqgonoa
   kcBxx71prh842mgbRaIfX/PpJ9KLGMqKUMbNgnFIpKw3jbMjMCfQ9XxQe
   xNyrOP70Vqq3W/O1JmtPpZoRJHhGQqnlKGEyP+ZJH+qnFpglCoN7ZKm2c
   Kx2paIkwULYfKvcsbzZbQWLWZ0d+R6amSpK+tgnk3hgQDhab5mihxUAiR
   ZPdpJOoEK6GVEKIco/rYL3I1DfS5EztKywCZVbwoeVqtkM2QyIDGpTPcR
   VUFSo8uqe9m6mbUKxSYmM5aEhx6gQJbSGR9j9QQkZHUn8QTcWKr2AbCmD
   Q==;
X-CSE-ConnectionGUID: PQNvr2HLTy+OVk8yP4+QoA==
X-CSE-MsgGUID: 7DrOZjQGRtGroA/zINyyKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48456103"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="48456103"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 11:07:53 -0800
X-CSE-ConnectionGUID: E5gQD5hvTQq9UQOXDqMBGA==
X-CSE-MsgGUID: 3vYJ3JJoRomtQR8A2NCm9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="104531365"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 11:07:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 11:07:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 11:07:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 11:07:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOmLnnQacgH0cBjyVPyaVk7PnIly1IuUVEiPM7lU5+/RsuudVYDmzv0GRJrtPbniponzE2LP8YEFhAmO5s8YJs3BlBaBXNGtPnTuCoysFI/rT8UU0amewX7fKxN7zMJOXdtowKHDW9/v5r0gpJjjWhrAB8OXyrhNW5Xa5N6VI5R+3b1r3v//4PMMPxd8Z8tePGf328FapOTDA5DtAHEs1C3YdPNq1qVW0j/K+5aA0o4KBWObDoevYrapd6V0/olF+eJouZjWE052nnB+Q8H6oept0/SKxb/UXMi4WEoFXb5BvRdGwFhx0u+ddhkB0uZD1yvS0dNfZyiAfjQVj7bDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jgmxz/lMbkKgJaq1mLjlbPUvWqRqc/ReLZh3oIKS0w=;
 b=cPKKt8/LFrwNU+4VHNV6dycBwBlab2KFvkWAyHHcO7nFyxm5W3mwC/ejGEVsRgUoh3QdJyuPY7wwrZZ3lilNcQQxEpJ5z+FF2P3xTHMivol5Zrb4AtIMvAb+k/b3TqiRW2tsMmrFW+OolqZPI531cZr/kwdmUuDvIV50uwAUjd8mZiRrlwdlMD/zfmb1yBIu9UVhWenZIZUx803An7nA1dDnqia6Lgj9zKxUDj5JPVVNX104u4HdNfe5PQbu6UQpilCkEq2CnlHnmpkxcFlQihJVQk1HfSoSgIT0/uyGizSU1ucnin5M1tExtrPNG/UHvYXWW9c20VlND7pXOzCedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 19:07:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 19:07:05 +0000
Message-ID: <ee18ca51-fe6a-456b-9466-39e81d484e66@intel.com>
Date: Mon, 13 Jan 2025 11:07:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 6/8] net/mlx5e: Properly match IPsec subnet addresses
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
 <20250113154055.1927008-7-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250113154055.1927008-7-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 127c5f62-2917-493d-7ebd-08dd34057825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vnc2ZHZ6UDhyQzVWcVpEbi9BRlMvenZCR3o3V29jeC83MENyYWNjQ2xkU3Bq?=
 =?utf-8?B?bmdQYlp2SlUvajRjM2RBSHErM1J6S1liTXl6RTVBUUhpYkNyNW81YllTby9D?=
 =?utf-8?B?UjROS2hCdmhBTUFFRmUrY3FDQ3NnVE54dUdGWHhQaWhOYWtFTE93SUNWSlBJ?=
 =?utf-8?B?cDNoYnlhZ25vbVJzWS9meWIzSHZxdUd3eFpSSEEvWGE1eWpLRDlmek81WG5K?=
 =?utf-8?B?cllQcHpoNzIxS2ptYlVBR1hJZlNXa2xhRmJXcFJYZ2J3Y3BRY3ZsMGVjQSs4?=
 =?utf-8?B?UUU3czduUTZORnRqRHVydm0zNFFZYVhDYnZITTNuVlVlOXdNRVo1bXFQcm16?=
 =?utf-8?B?OXdXWWVWM0wxYkFpSEIzUm5lV0pLVXUzM1hlbzc2UlIrRG5qS0hLTGd3NXNV?=
 =?utf-8?B?Tmw4WWVQUm9iWVJKckkvU2pzeFpBWkh3dDBrSjlGdERVSzdaazA5UEhFcndY?=
 =?utf-8?B?Q2FCVTFWMEFUU3NFSk5MRFpRamlxNFVDRWEvMW9JMkFBWVFEWDVNbDVXQ1Vx?=
 =?utf-8?B?TUdURnBXQ1NvOGdRbmZIWVcrNVBTcWNRMDJOWVZLSDJZNTNaUnNMamlIb3FI?=
 =?utf-8?B?RVF5Uis3WStYV3hCbm1LZjJyQ09CQjA0M0dwSU42VGI3ZVFWM2pIbEdXKzly?=
 =?utf-8?B?bytvdmlVTllqc1ZnRURxRThZbCtmOG1pY05FNm9JcFdXTmllUUhna3djYlJJ?=
 =?utf-8?B?Ykk5bUZHU2xHTXdrQ2VyV3lvUXMrYWtPZ3cyN1NteEdIUFZyTFJqcHRJM1NC?=
 =?utf-8?B?RFBJVS9SWTNIdXRYY0xDNUl6MEFxQXBFekV2U3E3YUlFK0k2Z2lTZ1ZzUE9k?=
 =?utf-8?B?Tmc1Qkg0VjIrakxaR0taYTBjWUMwSlY5OGJ0dEJWeGhBUU1xaExCaEVjREtG?=
 =?utf-8?B?TFB1cEhLVTU2bllnZzdzWmpsUVZjTnRwSTFReVI5bjkxcnJUb1B2UVJ6YTh4?=
 =?utf-8?B?U1Z0WTk2VXh4eEVaQUVXZXp3SVZxQ2FBRVRUd21sV25nYmJZcDdIVmk5eW10?=
 =?utf-8?B?eXlEanl0VW8xZkdxY09wUEFBUDUwdFJjdlRmbDJ3TDZFNnkyVyt3Z0hhd2tB?=
 =?utf-8?B?M0k1SnNaWGppSGhQc0kyaDRBNmZJM3l1SXlPT1h2ZTZDdjhNNnV0TS9Udk9L?=
 =?utf-8?B?ZVlJbXY4NU9GWEM2MGZqb2dHdXBQWkJpK1RUZHpBU3Jsc3kvZEtRQXhnNG9s?=
 =?utf-8?B?N2crdHBWa2ZiNVd3aGp1VHB4U1hIdlFVVG1TZUJTTUFxTnpGbG5hVTREbEkz?=
 =?utf-8?B?MlJ1eGY2YTRSUTl6Y3V4M1ZWU01EV0dpQVJ3ZWNXUWVJaEliSUlnMWY0YkJC?=
 =?utf-8?B?K1ZNNlhRdm1tYnJOWjcvSnJYd09RdDBxR09laE0zbzNSd2JCRnJrYVBwbUhF?=
 =?utf-8?B?YmZab1pRTzlPYTlvWStLbWNpaWFmRC9RQU9MeGQ1TTZyV0l3Y1hCWnhxSTdx?=
 =?utf-8?B?T0J0cHVTT3Nhck5uWkRCaFZNKzQ4Umlsa00xWmg0b2czS0hxT1Z4MGxINlVF?=
 =?utf-8?B?RzV0akFMeXVHZWVqUEkweGpQTE5Kck4vSUhIWXJ6ODdGbEozTEtiV1phQUFI?=
 =?utf-8?B?d2xpSXB5bFpPRGJWL0dERHk1a1JWTTJ5M2paOU5mWGFzWXZkVHlieG53aFZU?=
 =?utf-8?B?dFd6b2ZyK2N1U1FzcFNQZDQ2RFQrVldDZDNIR3FBZ0pqYWVQNGhlNS9nSEw3?=
 =?utf-8?B?Slg1UTRNTE9NQ2lpeGN0enpTc2Z6RGlMY0piZzhRV1M5TGdRcVNSSVlUZE1t?=
 =?utf-8?B?eVVaS3ZXcHI5U1Y4SnRNQVNkODBEZGFpVkhVUllwbHBBZ0xMdEQxYmhlRFJR?=
 =?utf-8?B?MXhXaDRoY2xuQTR6WFkxdDU4L1NWaks3M3hqTkU4WmNCekJGeFVIa3VnS1Vt?=
 =?utf-8?Q?rRC3D+khNTvRB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0RQN0Qzamt4UWJPVG51TllnZGZPL3lpRXV2ME5BSnJOTStQRWlQZTdLLzM3?=
 =?utf-8?B?OUNueGdvbm85Zi9oS2hQSTA1bjB3b0lYZ0hFNExOSU0wNXJYSEpSZWJ2Y1ox?=
 =?utf-8?B?SkMwOWR2OUNEQVVUK3V5eWxERnpPSTNqUTd2TTZkU200cDNDWm9iMXRqbkR1?=
 =?utf-8?B?QzlkWm5iSTFHaVFVQk03Z3NzZFZWLzhXajNkWjZoaWRaM0ttTjRIU1c3WXQ5?=
 =?utf-8?B?YTJ2TUIyWjJQUnNnOWorMENFVW92R3IvVDk3MHZ2VnNQeEw0d3F3dHJUU09R?=
 =?utf-8?B?TGEyQ05SVkx6ZTN5RGJIUGdlc0g5cmpFSWNSYzhLdlFVdnlUK2FYeHpxSFFJ?=
 =?utf-8?B?Tm9kaVFEWVMyWCtzZG41K2hlenZUY3V5VFBFRXhjTzJUcnRHQlpZRzFJL1BR?=
 =?utf-8?B?T0F5TkVLTGZhcFdaU2JZNWlyWHlRaFArRmtuRE1YaDJpTFB2RGJLb0VmSVZG?=
 =?utf-8?B?WHFiUkRaUXBpMFkxSzRrU1hneHNrKzhoREN6SXFFQjVmRmxvaENiNWxNN3dY?=
 =?utf-8?B?NG8wK3RteUZMKy9QOWFHZU4xNkpudUNIZUozVlZJVEJvVjExNHlYUWQvU2U0?=
 =?utf-8?B?dG9hKzRoOUM0WWtLdkgwNkMyM2RlUVJtUFRqZ2x2b080ejlrTDNJdHlDVlp5?=
 =?utf-8?B?YTRLVGk2dFZxZHp3eVFTUk9FQnlYeFlyWkRlRTYycUNySUdKaUl6YTBEZkNJ?=
 =?utf-8?B?MnZCSXdudEpDM0xKbjZEMlRyd3ZLc2pETzVNT2IvOHAzZC9FNEt2MnpRMDMy?=
 =?utf-8?B?L0dXR3dUdyt6Z0hUUGl2MWlDZ0VEdWpqa1hXR2RoNmlFTjRHM3h1T29peDY3?=
 =?utf-8?B?RFUwYVk3emRKVEUyMDJLS1ovLzVnZzM1c2tDQ2k2cEJEN2dobHZtN21yaWhn?=
 =?utf-8?B?QkNDZmpQdllmRERMNUVBK2Y2UW1YeVRoYVZoNXduRGF2Uk1CZE9qU2VjSlRV?=
 =?utf-8?B?RUFubFdIRXQ1bmZzaUZqVHJqaUJTWW5qYzVwQXRrZ0xRelJJdWRnN3c1VTFM?=
 =?utf-8?B?L0pGcDJtY1lZaHFyR2NRRVhTbFNadTNIM2lCUjdOVFIySU9ZWnJYb3R3ZWhz?=
 =?utf-8?B?cjBzSVpoN0d6eGVsQ2o5UytpdllhWE04VjNTdWVoRnpMSFJkYkR3MU1pRkFn?=
 =?utf-8?B?YXo4QmhTdkUxUUhZL2Q0MURWbWFzWmZRQUJ2OVZQcmpiVVlPOXh2R2VyMG5i?=
 =?utf-8?B?clpJNGhlVjNVMmdQUzZycUhzWExiQzE4SWxPaDl1K0JTWXZwd0ZMcVVyMnJT?=
 =?utf-8?B?eTBoSmxSQlFhb3A4d3dpRU4rdkpMNVRVVGpOSWhwUGtCaGp5Qml1ZDcyei9k?=
 =?utf-8?B?QkIyc3BvZWZuMStpS2gwSDJac0ozNWN3UEF3OUZZZmY4RkxXSjRMajQvdzRr?=
 =?utf-8?B?K0QvaVdoQktNUGZ2UmpQbFlLTFV6M3hEOTRDVmRpakZqSVZEMC85RXBLWGlL?=
 =?utf-8?B?MDNtUnRqWGFwTGxiY0h1eFViaFVoNWZLWjBkN0xQa1FybGJINTR6SGRLYzd6?=
 =?utf-8?B?eHlkOUVqWVVCSnUrNUFpOXJNamVtVm5hV2pqRXhVMVVSOTRvUVlFU3RoT2JO?=
 =?utf-8?B?QzB6L1IyWW5CdDlBcVJCUnF5emtRVUMzZzVCSzBYSkZLRkIrTWxLU0RjQUhT?=
 =?utf-8?B?eW1wYWQ5N3JZYVlLZFlnVjB3N1lzUEYxNmExMUlQa3lrVUZnQ3VXZ09OZytU?=
 =?utf-8?B?OUxKUzRSZjZNdkxnQzlBb0M0YTBuQmhUdkQvTHh6OFVxeTQ5NnJCOE0yRDAr?=
 =?utf-8?B?b3JnOG5tUVhiWUY3QTQyTjNRcmNkYTNrWFpKRDlNMVBBS3ByZnprNTgvNmRj?=
 =?utf-8?B?OGJxZFIzR2pyZytrOHlEVHExeWxWV1hsbEJmYWpKc0dxWFM0WGlQY28zT1dW?=
 =?utf-8?B?QWZDcnpEM0hlZURnQytnTXloUU55T2dRRHVNbDd0azN5aXRzbU9nV2dyU3h3?=
 =?utf-8?B?bXlQUzJ5VlhEdEw0MXNtOXlhblMwRkF6VStQOWFKb0xyVlZMYzk1YTUyNnQw?=
 =?utf-8?B?R01ZYVgvQUhtbHpEUTBwM2xOTFl4QXEvQVZIUG9paFNPRmd0VHlsVUJRbU43?=
 =?utf-8?B?bGdabGhxTndlR3hVZmcxSk9MQWpiRXVRSEU1YU1hTW1ESFRhZWtXUkZPWmc5?=
 =?utf-8?Q?BsQYkgv4NKn4C4tz9LWe34mol?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 127c5f62-2917-493d-7ebd-08dd34057825
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:07:05.3560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pobEARlG+0XiZ6ZtHIc80TWXrjkEYjjkW21QnXsDUFXURfFhlR6EAjb2qmWChoHXHT4B0asnEVB5BcbBQ6vzs+OpKNr31spyYFx67s4X9Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6455
X-OriginatorOrg: intel.com



On 1/13/2025 7:40 AM, Tariq Toukan wrote:
> +static void addr4_to_mask(__be32 *addr, __be32 *mask)
> +{
> +	int i;
> +
> +	*mask = 0;
> +	for (i = 0; i < 4; i++)
> +		*mask |= ((*addr >> 8 * i) & 0xFF) ? (0xFF << 8 * i) : 0;
> +}
> +

I'm surprised this isn't already a common helper function.

