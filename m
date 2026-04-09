Return-Path: <netdev+bounces-276864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADxUGl5U12kFMggAu9opvQ
	(envelope-from <netdev+bounces-276864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:25:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8753C6FFA
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 841563031AFB
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF2934C815;
	Thu,  9 Apr 2026 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBa23t4c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B562DFF04
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719328; cv=fail; b=kWUOl/zqZNyUh4n0PcyUC45+rEb/ybcG5Kgf4XCdieEGrRDQElODKHFGULc8HsCpeHgBODsOrPVkrTE7dZbQcIS4vL/Pjfg/OLcJYMu6phlZYYUwUV6g269+dt5TbxGdozY3tS8JmJa4Lm4PuioFV7//yepkuG5nyLOSinhNzI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719328; c=relaxed/simple;
	bh=Qy6VuxFcBPEif/4/Ul2PZTxUwRKW2gq+dKKM1xcM8QE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oj8XVi1YinyU3BbrS6I7p8IKogaZVmFuZPaOSpzg2ks62Dq7w+JYn/2JgMMJptd5WyddwSqGH6y6G2zpG6+zNU1w57B6bseLV+Lv0PBpnEZ+h2X58t0fHjMGvkPRB8uEwUSAF/YdQPxTLK7HEbE6xTsqr0V1cDQTNpCEMh/X/5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBa23t4c; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775719328; x=1807255328;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qy6VuxFcBPEif/4/Ul2PZTxUwRKW2gq+dKKM1xcM8QE=;
  b=gBa23t4cGXkTCaa7Nv5uKw81wB1tS6hNVoJgkkCXfoJbq3g6fRr+r58b
   NYvv6bTARFAX3Fvu4t90rMu3+A3mj6mCUWGGAZkDdyWl3xRc+qVAExR6M
   ETSyACmfJkB1UAazUPlTj2yNGnkYtB2jZmUrg/A4XlJsUu4Lk0/jLDcvH
   cWqejcGDkPvfP2Ed+Xnh7RXsKMek7mrwStGbwYX0F2/kdWfJlfQ+sQzcU
   6tBVrIpApvqtxgRxduLD0D2A7qwyh5W9Rb0aNr1VaSNIv4UUUcmxqi7hD
   TS1QZqSsnNwmXIeU9kD1nUYv3UBRayppjCQ8Dif7Qc2SaIrMq2bC+OZtn
   w==;
X-CSE-ConnectionGUID: QrH+JK/DSMGESP9svPBX1Q==
X-CSE-MsgGUID: anZ+ojguRTOM8aFW3UfbTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76595185"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76595185"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:22:01 -0700
X-CSE-ConnectionGUID: HUOsnDSxT++cVbFSaV8Psw==
X-CSE-MsgGUID: kojdOo37Slar13p+9CE1BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="227835791"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:22:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:22:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 00:22:00 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:22:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZNoSOpxvjUk+Ui/llb7GmdFQir8yvRQgLymFZVIbU0gRed0qpGNQRzLCIfhIgs9LJu/RM+IaKfcHXQYbv/QCni6Mfhf0kYc2/Z9jZwJZmEmT3VcogB5AtQIThkojkvQdFBc/Zyx0bUISKbvXebJpGe16fIxaEn7lXwVjMYKa2a6jCqXNJFwHZHZyP7lJxp2tsziO4g4IZ15gLaAx0DgSu5jr7AiqxWI7iOjhrwlD8sSYYxT7V8nhnEx+WAsPXyqXMAiqCOlaLtFlOpQ18W/j0L74ubfccVOBi91lv+MKKc7zkitn+1c4JVxAktrL0LkFOaT72MNKIXZ8aqZ0VwT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NhBSfOizJ5J4syltauzmAdHYrapJrlHsdAO3kU9EBI=;
 b=aFRKYbMbqe3/9b2isX58Zb32RKvRthbxLpyK1yn1sJh3bblyDWWV/worxYZ88T923qSJACbkDEA8Y1qB6lbVXk5WUv/4L/hVu4yCWb+wl6Wu+GtDARNv3dK/jo2WVJbk4ada/dwVzjPmFJCl3+O0vNgdHgUzFb6NI9uyC117CRB/cMsG9xy3aJ/p2O/tKMp7EMWsWkEpavpxQJoJcGNKODrm9u4scDiZpHbt9Y1jHo2v4pU57PHzPyPw0441x5boYpuatRcrEvPr0/BdN2SXQQtwjkHO/N/GDeoSET5V0yyxefwWNO6mDslqHRfLWdEhyjP2BHzyRqTU74WAvpJXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 MN0PR11MB6035.namprd11.prod.outlook.com (2603:10b6:208:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 07:21:56 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 07:21:56 +0000
Message-ID: <e7978696-eff6-4c1f-ab0f-047dccb18b59@intel.com>
Date: Thu, 9 Apr 2026 12:51:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/drm_ras: Add clear-error-counter netlink
 command to drm_ras
To: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>, <rodrigo.vivi@intel.com>, Zack McKevitt
	<zachary.mckevitt@oss.qualcomm.com>, <joonas.lahtinen@linux.intel.com>,
	<aravind.iddamsetty@linux.intel.com>
CC: <anshuman.gupta@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
	<pratik.bari@intel.com>, <joshua.santosh.ranjan@intel.com>,
	<ashwin.kumar.kulkarni@intel.com>, <shubham.kumar@intel.com>,
	<ravi.kishore.koppuravuri@intel.com>, <raag.jadav@intel.com>,
	<anvesh.bakwad@intel.com>, <maarten.lankhorst@linux.intel.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang
	<Hawking.Zhang@amd.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
References: <20260409073318.2909379-4-riana.tauro@intel.com>
 <20260409073318.2909379-5-riana.tauro@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260409073318.2909379-5-riana.tauro@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0095.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::16) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|MN0PR11MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f4f5a6-3db1-4995-2752-08de9608ae5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fbIDZIYy1vbZIi/nErQmi1xCh2cRCYYWiNjngdYIyRGIPme3kiZ89wPDObysl4s49LbREfUTiSpO7fQAzgBXSA2LqaTQf6CFQdD2YAKbO5z9EytmH3EKZEIMByqqYFtPdlwEif9RMFiq1CCaJJcSc8Pm4tbzUZk1JoHJpHYQ35Obe84B2D5Gc0zILR9uh8xfHIc0c65R6uuXYtBWihBUht9IcaJ2mHjlVgp7g7AAxGa4GFJFRJfCO2cDSQN5DWe0NfwIv1vUlMsluvVoYpZFMf8Affo/S/lYfXxI0CYqHkb+YLub6hdl7GJkZ0VUy3x/Yqzk4GuYOGvVhvWt2hxSiqO6nrrtMol7Gb1EFitj1FL2+1ZuNALgTaSz7Rfu5BxyolgrPQblUUh1uycFtiwnu7Z3dUczWMEytJpa3cMsowccSh8WQ2WDamyY1D8NEvBkfjU0yrKwHHqavNTg9QWYLuhdRMm84qZvU/EMgAvGLO5zysuoJfAaYI9jfnfj6qU/jaS03EseuLSSV/043uqdzz2hMnercuRr9xy1rP2uvN2QAZ1ySa0WMiV1I01CanzzW9lWdNiRhS8xwT8cq3F9KHFo/Sn3qg6DDAKvZT/VbN+gthSAU+EA27SZeJLRzTOd5fH9JmuoVKtEpqpMPKApKHHhTXoSCsJ+5hONe5YAqKCts55wFKT5awUJ9Gktn7Ixa6mRAqqsT5OzDQPARC2kt78jg7VT0xz8MUuj72qOxyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlA4THhqeXMrbnN4ZHJwbFJBL2lNaUNlVkNNaEhHbkxtUklPU0RKSmZVL056?=
 =?utf-8?B?RzJEaUdYcjlHM3RjRkRST3NXMkk4dmk2TjE5NnpYaXlzUmZsdGdKRFZCMm51?=
 =?utf-8?B?NVc3Zm94Z25XcXNJaXRIQ0dGbXYrN0lmRW1MdWFnVWZjREdWNjRYUFhPUm5r?=
 =?utf-8?B?SERuTG5zQjhaRWtBSWh5R1V4Z3dIdXNsOWhuSXFQNFJkallJbHB4L1VoTjVn?=
 =?utf-8?B?bHY0eGF0THM3T0dBcFBxSXlDU2pDUlBpYVpTS1A2YzBxcXF2a25lM1R0YXVC?=
 =?utf-8?B?NlVRVml3bFRGQUdEck5pdEs0bll6b2dZTHBSWkFieHVxZnFoQ0ZDcUMycjBz?=
 =?utf-8?B?cDduR3NHdE51SVlBcDZvR0UxUXIyUXBYVkdXemNNb3lrWHdPZ29CdWxKRkNo?=
 =?utf-8?B?WkplbjlKdHI1Tk94dkVtMWxiVnhkN1UybGpQY09PcTJuRlRySElka1dmYjdL?=
 =?utf-8?B?SEJFNStrVVRZZmFVTVFoYUp6ZzB6c3RhbGovZHV3ZWoyMjZjQnU1VGk2TnBk?=
 =?utf-8?B?N1dVM25jZ2xjNHM1dVFyd0hseC9lWFlySlVRTzhoMURVekY0S3VoZ24xbnM4?=
 =?utf-8?B?MTFLb1l2ZzFWK29Wd0t6bnNHL242S1lodU9ieEhaSXdmelhqSUFaQWVGUGJn?=
 =?utf-8?B?c29LMEpBZ05CR0tBY1VjTURuOVR4TWNiNlhpei83YmdHRVlWblBwWlBOT3Ey?=
 =?utf-8?B?UnRKR2EwYSttcktiVEZVcWpJUHdMV2JYdlJzMFp1MDJ4emxlYTVwUWhzRitp?=
 =?utf-8?B?Z21zQVFpNTBaa2ZEa3pNOEgwblpUL0FjeGxqZ3B0S0lTeXBnN2NKa2Nyc3Fy?=
 =?utf-8?B?b0dtWm1iNVpBY2hqTWJNSmNWRXNQYm51YUJBVFpScTZMMkxyb1NONkhMbjV4?=
 =?utf-8?B?N29BQSs1UTg4WjQ2SVNaL0tvKzVtNlllOGU4bm1sWXFFTytYLzFCYzZoODAz?=
 =?utf-8?B?RzhCNldSZ2F2WmU0czlxK3VINTB4UEhoNi9LWjZ4ZEE4dEpJbTJlb2lBeDUw?=
 =?utf-8?B?a1dMbEpXK2oxMUlxVXFKWXNUYkJObTRPMWl1dm1xRGJRWWRpakZyTUdUUk9C?=
 =?utf-8?B?Zy9Ic2d6RmdISkZ2QTVHRDJjUVFYZzZiaXA5NXZDenQxUDZ2YVhnbCswT3lK?=
 =?utf-8?B?NzhmcGdVSmlqV1JMUFFTbFJjeGY5QWx3cURicGxzZlBTbmxWdWJld09aQ2lP?=
 =?utf-8?B?ZDBDS2ZhaE11blVxalM4VzFpd20yb3RQelI4WGRNVi9aUVNFWTlidjFaTXdC?=
 =?utf-8?B?K0lrN05BV2RCMHRYVk52d25ncUcwYTVOL09VU0d1QVptYm44a0Y3RUE2QTdM?=
 =?utf-8?B?dksvOW01Q2VEMkVmZHRCa29EbWdnaWdlM3FZWHhKWEoxUFM0djJFWW9EMEJ4?=
 =?utf-8?B?VkI3ZnFFMXQrUEtOd2R3bHZSZmZqYVBkcUVGWHJMSGs3SjNSUHdDdE5OcUdr?=
 =?utf-8?B?REY5TmI5YVZjNXhWd2JnSUJRSlpYbWRvK25pZUFsQjlUa216QUxTNUs4NVBa?=
 =?utf-8?B?bFVTL2lvejFJWVlOSWZlVzlkY01halltQVNsRHgvdGYvTkFHWXJhbDdtckgv?=
 =?utf-8?B?QjdVL1NBYWt6QUtmcEhoeUdsWEVzMG1YS1oyeU1UNXYrbFMyTVJpSHNnMXZo?=
 =?utf-8?B?MFlCakF5RnNIanNTS0lLbVNwKytJMEEwRkNDM3c3SjJMMjdMSkFtMGprLzJv?=
 =?utf-8?B?VDJxWVFFaExqM0xhQUh0dGZpekM3QWZ6VHB3Ulh0WUUrTE1Gc1NpRVJKaDdX?=
 =?utf-8?B?L05uRVlwOGxZa0c0UVNaa1FLRmc3cWJnZGtyQmErbEdNTU1tUVk5UzR0T0VK?=
 =?utf-8?B?dzBFUkExOFh4UW5YS3l3T00vTmRHbCtwWWt2elVvQWlIU3RjZjY5VFF5WkhX?=
 =?utf-8?B?RFBmbmhtV0thZGNFY2p4eUdIVEgycmFlUUJtVkhQN3FIMUZERzkvV214Tmxr?=
 =?utf-8?B?cXU0S2hBanpwbFZnbzl5MTIreDljOVlzVERQZy9WdnZTWm5wVWZ5TVdIKzB2?=
 =?utf-8?B?REIzWW0xWGwwQ3VRaFpVbEx3UFh5d1pJa3lBWXErV0hGd1p4cUh3QndwYTdX?=
 =?utf-8?B?aDdqM1NMRW9zNE1Td2NCYkh2NUpSQWM5b282YmkvYVpkUnZFcWpIRUFkVzlq?=
 =?utf-8?B?akhUaHlMUjNVWGVXL0dpSjNXcnY5YXFEWVdFOGhXVnVHM0JQc1YxZUtOZUlP?=
 =?utf-8?B?RUlJL1hSbFV5RTlqOU80aCtid05xd1VLQWtKNkNUMTlLWUJNRGg3a1FKN3k2?=
 =?utf-8?B?OHJ5Z0c0Y0t5UWN3Rkg5cldSalJ6UzVaYkU1ZzZNaHMyTUlMeDlid0lBMHlF?=
 =?utf-8?B?TFZmVzc5cDcwNUo4S0dsc2djejc4K0IzcjJUUkI1bTY1S1FrS2xTdz09?=
X-Exchange-RoutingPolicyChecked: Rut2CfhyffSzUIHB5+E2s1a7TPajv/LnHgUqgOpRl+JsXcBdRwLzAM1kx6NCBjTLJURw3j8jMc6V32p/rXnPt89kaT+TyBno5WZMXiLdBFUAsD4KWrUBdLE8G8ABmZ0IepCPautiSbDJcP9uveYrFnMCR17ehEtcskv8ebq7fvPIrGwpmuQxM6Sehp22xfLRyMFnUkS+VbZreM68Iwv5yl3u/Rh/Gik8zN21c/qP/oG2kkU6gmpGpS1EPfBPoAYV+3pcGntzhaUpz+ILg83XYuUEgcxcowCN/3RRpBfc5U7Mfh2vp0xng5hWbBUdo3tHXlv7tku+d8n/YT/lEt4e+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f4f5a6-3db1-4995-2752-08de9608ae5a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 07:21:56.3276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1syx5HkAOwfJGBoSplHqvv4f0XZFqinbx6eiM6Ee+auW9U2mlWWcHAtAqF3FCjYedI5ft9sO/2zivppwSQz4aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6035
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-276864-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,ffwll.ch,gmail.com,linux.intel.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,qualcomm.com:email,amd.com:email,davemloft.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BC8753C6FFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Zack

Could you please take a look at this patch if applicable to your 
usecase. Please let me know if any
changes are required

@Rodrigo This is already reviewed by Jakub and Raag.
If there are no opens, can this be merged via drm_misc

Thanks
Riana

On 4/9/2026 1:03 PM, Riana Tauro wrote:
> Introduce a new 'clear-error-counter' drm_ras command to reset the counter
> value for a specific error counter of a given node.
>
> The command is a 'do' netlink request with 'node-id' and 'error-id'
> as parameters with no response payload.
>
> Usage:
>
> $ sudo ynl --family drm_ras  --do clear-error-counter --json \
> '{"node-id":1, "error-id":1}'
> None
>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Raag Jadav <raag.jadav@intel.com>
> ---
>   Documentation/gpu/drm-ras.rst            |  8 +++++
>   Documentation/netlink/specs/drm_ras.yaml | 13 ++++++-
>   drivers/gpu/drm/drm_ras.c                | 43 +++++++++++++++++++++++-
>   drivers/gpu/drm/drm_ras_nl.c             | 13 +++++++
>   drivers/gpu/drm/drm_ras_nl.h             |  2 ++
>   include/drm/drm_ras.h                    | 11 ++++++
>   include/uapi/drm/drm_ras.h               |  1 +
>   7 files changed, 89 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> index 70b246a78fc8..4636e68f5678 100644
> --- a/Documentation/gpu/drm-ras.rst
> +++ b/Documentation/gpu/drm-ras.rst
> @@ -52,6 +52,8 @@ User space tools can:
>     as a parameter.
>   * Query specific error counter values with the ``get-error-counter`` command, using both
>     ``node-id`` and ``error-id`` as parameters.
> +* Clear specific error counters with the ``clear-error-counter`` command, using both
> +  ``node-id`` and ``error-id`` as parameters.
>   
>   YAML-based Interface
>   --------------------
> @@ -101,3 +103,9 @@ Example: Query an error counter for a given node
>       sudo ynl --family drm_ras --do get-error-counter --json '{"node-id":0, "error-id":1}'
>       {'error-id': 1, 'error-name': 'error_name1', 'error-value': 0}
>   
> +Example: Clear an error counter for a given node
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
> +    None
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index 79af25dac3c5..e113056f8c01 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -99,7 +99,7 @@ operations:
>         flags: [admin-perm]
>         do:
>           request:
> -          attributes:
> +          attributes: &id-attrs
>               - node-id
>               - error-id
>           reply:
> @@ -113,3 +113,14 @@ operations:
>               - node-id
>           reply:
>             attributes: *errorinfo
> +    -
> +      name: clear-error-counter
> +      doc: >-
> +           Clear error counter for a given node.
> +           The request includes the error-id and node-id of the
> +           counter to be cleared.
> +      attribute-set: error-counter-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes: *id-attrs
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index b2fa5ab86d87..d6eab29a1394 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -26,7 +26,7 @@
>    * efficient lookup by ID. Nodes can be registered or unregistered
>    * dynamically at runtime.
>    *
> - * A Generic Netlink family `drm_ras` exposes two main operations to
> + * A Generic Netlink family `drm_ras` exposes the below operations to
>    * userspace:
>    *
>    * 1. LIST_NODES: Dump all currently registered RAS nodes.
> @@ -37,6 +37,10 @@
>    *    Returns all counters of a node if only Node ID is provided or specific
>    *    error counters.
>    *
> + * 3. CLEAR_ERROR_COUNTER: Clear error counter of a given node.
> + *    Userspace must provide Node ID, Error ID.
> + *    Clears specific error counter of a node if supported.
> + *
>    * Node registration:
>    *
>    * - drm_ras_node_register(): Registers a new node and assigns
> @@ -66,6 +70,8 @@
>    *   operation, fetching all counters from a specific node.
>    * - drm_ras_nl_get_error_counter_doit(): Implements the GET_ERROR_COUNTER doit
>    *   operation, fetching a counter value from a specific node.
> + * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
> + *   operation, clearing a counter value from a specific node.
>    */
>   
>   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> @@ -314,6 +320,41 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
>   	return doit_reply_value(info, node_id, error_id);
>   }
>   
> +/**
> + * drm_ras_nl_clear_error_counter_doit() - Clear an error counter of a node
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the node ID and error ID from the netlink attributes and
> + * clears the current value.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> +					struct genl_info *info)
> +{
> +	struct drm_ras_node *node;
> +	u32 node_id, error_id;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node || !node->clear_error_counter)
> +		return -ENOENT;
> +
> +	if (error_id < node->error_counter_range.first ||
> +	    error_id > node->error_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->clear_error_counter(node, error_id);
> +}
> +
>   /**
>    * drm_ras_node_register() - Register a new RAS node
>    * @node: Node structure to register
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index 16803d0c4a44..dea1c1b2494e 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -22,6 +22,12 @@ static const struct nla_policy drm_ras_get_error_counter_dump_nl_policy[DRM_RAS_
>   	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
>   };
>   
> +/* DRM_RAS_CMD_CLEAR_ERROR_COUNTER - do */
> +static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> +};
> +
>   /* Ops table for drm_ras */
>   static const struct genl_split_ops drm_ras_nl_ops[] = {
>   	{
> @@ -43,6 +49,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>   		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>   	},
> +	{
> +		.cmd		= DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> +		.doit		= drm_ras_nl_clear_error_counter_doit,
> +		.policy		= drm_ras_clear_error_counter_nl_policy,
> +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
>   };
>   
>   struct genl_family drm_ras_nl_family __ro_after_init = {
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index 06ccd9342773..a398643572a5 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -18,6 +18,8 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
>   				      struct genl_info *info);
>   int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>   					struct netlink_callback *cb);
> +int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> +					struct genl_info *info);
>   
>   extern struct genl_family drm_ras_nl_family;
>   
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index 5d50209e51db..f2a787bc4f64 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -58,6 +58,17 @@ struct drm_ras_node {
>   	int (*query_error_counter)(struct drm_ras_node *node, u32 error_id,
>   				   const char **name, u32 *val);
>   
> +	/**
> +	 * @clear_error_counter:
> +	 *
> +	 * This callback is used by drm_ras to clear a specific error counter.
> +	 * Driver should implement this callback to support clearing error counters
> +	 * of a node.
> +	 *
> +	 * Returns: 0 on success, negative error code on failure.
> +	 */
> +	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
> +
>   	/** @priv: Driver private data */
>   	void *priv;
>   };
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 5f40fa5b869d..218a3ee86805 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -41,6 +41,7 @@ enum {
>   enum {
>   	DRM_RAS_CMD_LIST_NODES = 1,
>   	DRM_RAS_CMD_GET_ERROR_COUNTER,
> +	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>   
>   	__DRM_RAS_CMD_MAX,
>   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)

