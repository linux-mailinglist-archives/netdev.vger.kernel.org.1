Return-Path: <netdev+bounces-153454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460229F80E2
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC9616B3EA
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0E216DC15;
	Thu, 19 Dec 2024 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wb5wymGL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF1C1990B7;
	Thu, 19 Dec 2024 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627654; cv=fail; b=LqN3KubFUHEFflAyO8NF+3KRkPaQ6wwQamsIwYSStLATdJoAlbCORgnSm7XxQ1shmaicbW6kN5elfmrClWEdFxBi1XVmH/Ws5wdnG8Eqz4fXjbJYoy2GYQ+WxIWj4njLgmkLsI1uIbeVz0x+RgxSgqmn4nMnt/52HP+mFoPB+uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627654; c=relaxed/simple;
	bh=pt2yCX+SpdVDyj0xqiFM2rTe978DvqhDSRi0xD5/QdA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y+VnOLpmgdpwoxNF58hUW8RJNkOS32sA6EckTjOHnvW1X3GvNkWn4ywgjCAlLoD0dqpUQ8CBGFW0IBXALKXrLrt62H1VeB3nx6PvcvAzoLIys2fKEEsbwaqcqLlQssLk7yG+TE/oL4XnuUtKeKNVkJ3g9znUIb+8yHjIVSevxvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wb5wymGL; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734627652; x=1766163652;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pt2yCX+SpdVDyj0xqiFM2rTe978DvqhDSRi0xD5/QdA=;
  b=Wb5wymGLDTjRINTUrBpWuUSeuhaTIXdxcKr1UWjXiSaNlhDGjMJJAXtQ
   73opGnmzcvqtanovt3atrL2QerAbQj0ARysV7x7G/6t28Y+2P6gFOMIqH
   40jrd0KhQTCzJvp9aK0hPOMPKRu4j5CP01DxOsJlC3bgOlrOhNPsxMm2u
   mbWPKarO7xaEm+/ad0YD8wnM84ktE53Vnx/scf5SrhczgbFzL4gR1QwHD
   +dfMSATHvw9huE12xSWAYPnFoHrno3WXvaMCvAzLEjfHi/IPmfDG/qJtA
   rrxRuRei/K7GqkhwtRbiQxhU3WZ/m+cSTxw2as7FVL7GeqektogZLiMe1
   g==;
X-CSE-ConnectionGUID: gC0MTgpXSj6SzKM5MEBPkw==
X-CSE-MsgGUID: RDQwysTwTGuFKJ41JB6jAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="35369127"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="35369127"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 08:59:56 -0800
X-CSE-ConnectionGUID: g5O2TOhMQY6a4s+ecV7IXg==
X-CSE-MsgGUID: 42i2SLAEQ7qmKVmmnrDrPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="98140903"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 08:59:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 08:59:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 08:59:55 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 08:59:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kc0XAf2cUTj8a8tf8FN5LKJL8xfyUEq/xnj7xLzbFjxPUwyqYdKZcnpZu9JCN9mT/v9p1IAzebL8mcPE4lAMrCeIu8cWRnp5Wsgfv2niZYe2osaqcCKrIPhRhNu6rIXENVfxGCT3sRaC4YG8U3pl5XHNlkeC8hO+a6M9OZ7B9R4gBpdRKv9+6V6JmFXkokeH/N+E364NHCc4CvUW5KtThigOz2akfp04kihbxG5TDDAROr4nhMvYcf+naFzwKESCTtO+ux/CQIzTFuluu9riGAPAFlm2lp+5ym8hmWKChm6EplgDWeuyoqeqIWpkT/FlNsVI635PMU2TJGA/39k62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4H6uHiJ3U/a6b3zw1m8T8CRkOHyoadgsnKC+3CMmvZQ=;
 b=EJfAcJRvBf6zdBEwXqvA/q0wQbkjlSc2912+/z9W8CKZK4xn8uzZWVdB9xWTsKrPdKCYVMlliCgfbpuKeX2UXkWv4nuKQhmGJOzPcf0+vrQwyCGNZ9HNACzMRy3Btc1hGfTd9yUPvKxAGMw5N4cZft60S1sW30HAD4KCu6gaov51an9+VbfWnsMRKQiI/ykzqoihQCWiOYjIntUYeT4GAxbCIt0bb8r0AWUf7r0SqHNTG8iyRwLtNBZs+4CBNQF+dUcsHNs6WPYVrrDoc4YoUOMmmrU1eLKDpOucfku/ouT0JhmDdsWXYuxyiBiruPlHs0MeePZoV0OKURcK+DgdPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CH3PR11MB7770.namprd11.prod.outlook.com (2603:10b6:610:129::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 16:59:36 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 16:59:36 +0000
Date: Thu, 19 Dec 2024 17:59:27 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: MD Danish Anwar <danishanwar@ti.com>
CC: <aleksander.lobakin@intel.com>, <lukma@denx.de>, <m-malladi@ti.com>,
	<diogo.ivo@siemens.com>, <rdunlap@infradead.org>, <schnelle@linux.ibm.com>,
	<vladimir.oltean@nxp.com>, <horms@kernel.org>, <rogerq@kernel.org>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next 1/4] net: ti: Kconfig: Select HSR for ICSSG
 Driver
Message-ID: <Z2RQ7xj6IwPXsqHO@lzaremba-mobl.ger.corp.intel.com>
References: <20241216100044.577489-1-danishanwar@ti.com>
 <20241216100044.577489-2-danishanwar@ti.com>
 <Z2L/hwH5pgBV9pSB@lzaremba-mobl.ger.corp.intel.com>
 <c6254178-6e2a-47e1-ac16-22af5affc8ca@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c6254178-6e2a-47e1-ac16-22af5affc8ca@ti.com>
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CH3PR11MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: bb96b2de-5a1d-48aa-64a6-08dd204e84cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ecwwO4qlcrDJ0AtoQbDl+jobBhXwfDP/8E1CWs5EJR9vTASJ4BVy+1guenuN?=
 =?us-ascii?Q?qzdFl4dYFq3Ea/pRSAdQ5L5Iw8nTBgNj5iLU+sdGy4L67fJ/N4jYjkvd6UVL?=
 =?us-ascii?Q?z/O4Fv3KwE4EgOWvesUL5usGjCVnHbu/Ri5Bg+i05eCREXFKQB8hNOPDqLrC?=
 =?us-ascii?Q?tMCqxrqETQ3BG1WEGr2H6nfeebYSd+HOlJYe7UJmfsZOT/FpFqDzVNVjAVwC?=
 =?us-ascii?Q?yk+dyGL4tV5rQX6mmW6aaCIlj0JLk39y0ZVBQh+5gnYllHK7Qn7AFIh60D3R?=
 =?us-ascii?Q?0sfUvbUW1PXUVpc/fwHKJAnWsW3gBYdPEDFrvpLAQlBEMO88i7L+IOHVA7wO?=
 =?us-ascii?Q?oEBpH6Pv5VDe16wjQDepo+I/xEo460IiJeEvfS8aEk3M3cfC+HcckhF3+VB+?=
 =?us-ascii?Q?cpyqukTEkUZA/fk2JZ6/bbBZtpWAdBrYV7XSWVbmkTPmTVYHPEJb9LRs21Tz?=
 =?us-ascii?Q?CW5XWRGGQ/1hN+92cjMsedx2D7LiFT46QihKXP8ocb3s18oahkeKuMAkkW4V?=
 =?us-ascii?Q?2t4EWG6CMH8yycxn9zy7U8abZzQRLHSVqSc4qncOv3lFwOjxsiUIDl85fF5m?=
 =?us-ascii?Q?T79a4z0TgICNRggdI1m6jcJTaHE2PGGEGqQ9gex1a0fk9XZ6gHE7k5yjfKjC?=
 =?us-ascii?Q?nmcB0OvQHMM5kRq3e0nbU+20J0L3Io3BQHFzT8i33DJl0HETM64TIIOaXUXP?=
 =?us-ascii?Q?sVx3NvLEjmSqDRrm5obJQvMGLPAu4xcyHce+hyle8MyA1csWtqho+qh2EO1z?=
 =?us-ascii?Q?tGaPRhBE8+imF1Me1NfehAOSsy9K+yDbtdPJ7b6Js7TbZygAGa0KBVp+dd2G?=
 =?us-ascii?Q?HMCicGaFNsZr8EcF7xuP3qEY2f+/bBo1CueW1kXRZiWiDHY9E0/++NVtVjTk?=
 =?us-ascii?Q?9l0ZHGy+vhQQVMtsuueCfNJEYMDCG3lbu7tIJ11d8zpwdR+TqS3zgciiQ18y?=
 =?us-ascii?Q?1Ih1vDkKd6lwpnw37Wron8KRBH6CLEGb/qaeTjzxkpjoVkp9TvFgMb89cTxl?=
 =?us-ascii?Q?7h3gRGYZ8fMPTS1HH7d1SOrF8M7/Ip8Dfe4+qpkU5BGSGJ6477EiE/bFsnIi?=
 =?us-ascii?Q?C6VGqz2ZC7TLMaw6GmckZnqbOAiIgn25vQ2LMEVb4mG9edkqYDlzVn8FDgvD?=
 =?us-ascii?Q?FH27OnkZYuKkWqO4wWiyKzediGibeABeS4MsMfP/Ut9OJJWB27sCTmk07sYO?=
 =?us-ascii?Q?82EWaRz+H7ga6Odu4oRa/4KzQEJcOUZeBiYE67xhg/+EUSdRGtVdqCG/hgVW?=
 =?us-ascii?Q?N7xD0PKrDlJfir90ARxGYwB7ckGdrLYrDFJ3feeXO6MFwteiSrqIHQImOhpb?=
 =?us-ascii?Q?6WxVPGHUyfLOQ474C+/6aqxj3ETMkLm7eh+DssLUzoRNNjURkipiBeBDenI1?=
 =?us-ascii?Q?lls46czcoqgD/YTHsJFkQS6i85Gz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pPDQ9jVLtpFuFRQoRn9d6mXS7R3y6/VoBAZ5uMdTzYeEytjAQghU8033CiYb?=
 =?us-ascii?Q?U0S9fFM+GuAQH+3THQ17hhcFYSJfB7vU3uBauVCrjrE/jXVVQeerDM95fqWo?=
 =?us-ascii?Q?vrceh8/MVK1oICdrHSpj1CzrOhDUnWllm8ydeKMsTdJv9p1uANbs4ZDcHTnB?=
 =?us-ascii?Q?fy51aeJ3Sadb+/9qiNLVnL8AMseeNkgwqTFXCwZ6iXCMzOKJKMQ8xTFppR36?=
 =?us-ascii?Q?XOYLagJkdMfgfttOSqrL5vhXvUyfgJ08kIEfm1avAudRkGLEjuapdNsk+x3i?=
 =?us-ascii?Q?wCNydSljaOaJ/aIAf516EHqDEpK9MdXAo7HZ2lVG41Sm35jcJX5PiDd9NfDi?=
 =?us-ascii?Q?+uGMH5efwjbKvbhCnd0/prwXJoEMMVjUFJ7u5BWoukUtF3fnZzi83fNtJXll?=
 =?us-ascii?Q?lTW9tC7jmxcBTXgPH1EZs/1tmSaM6Rzvf+tRAh2b4urwcQLtLA5Es7O6qQ+m?=
 =?us-ascii?Q?hScJ0hFm7K+QEZOCYOiMM+L6HBH70az+UWi5j3V+0uxKHJqLRDTnXG7J6dlx?=
 =?us-ascii?Q?aRbuViqXWGTTS+zch8h15ri7T+ZEBt/wg6QjyFHbl9lzT6C3fWLjydMt/ynK?=
 =?us-ascii?Q?sRMVAKVUm7m2alqYKVC/jFKB0hcvgDf7/dHyWihNNJrV2AB3xD0yqWtEXDba?=
 =?us-ascii?Q?fvqfCFn6VGNtGyuac+dApNivAawgDGOI/qwsnPWzFPZ/tCh5E0Ns79RcTrsn?=
 =?us-ascii?Q?NBjRzJHEwtCrXC2Y4oU6uQjR1vgGu9KCgBIA9JNhF05YYQ8CI7b9ZmQr42cU?=
 =?us-ascii?Q?Q/A5OF8jaAYG6BNy2+6P/Owz5M+lbECNx3nYIdUbGGtJJp0BuJUeNm2Q7/D3?=
 =?us-ascii?Q?2BZB5TiNIwomXAVxTFN9FOceN+elilf7jTkm7EkzzKylYRf/U4cHduX3lPlr?=
 =?us-ascii?Q?T5Raej3m7iXY9gBXeQqeDWM9gYE20FQZQtDd1fUOY3vYRk2s8JM0RIVLcPGw?=
 =?us-ascii?Q?JrS9v6tKgkl9I4bkNnjUNiVvdZI7WKdLj643rVySettFJR3GIy0TXHDSuLG7?=
 =?us-ascii?Q?QgNNdLl+k2DybScCpg/RKvXrfQNZH4xVaUEWYeY0JSzzm+hnxvAT2HB2kPor?=
 =?us-ascii?Q?QVRyoFjLCsuNhYEj3SiolUcgHF+H4M7ghoUUi7kRqtCwu+LrHILkLsh4U8Rh?=
 =?us-ascii?Q?HQCsRODo3mF300X2h+vESPa8pUk6TKVzRgbw+VkdLpJTXGEYW2vnHnygnT26?=
 =?us-ascii?Q?khB+wmzyV+HWPCYcqvi9KYu5MqYJZiiq4gstUv36D4kit5GoR9vTzrhN88S5?=
 =?us-ascii?Q?INi/kB8H2GAxeJWo1QtZagkMGw+DV9I4whfDnqaLWsP03W+jR8QWi6Jnxemj?=
 =?us-ascii?Q?3Y+tvhvrTXhDAEtJFgDOXFGK930Tc0KzgjYDuBw5TVNioDwsSvKA9DKIhDPt?=
 =?us-ascii?Q?ZlI4mbHEU4iDGfhYlcB+XLCK7EaqGOd+5ASPfeYjAUy+QQVXbOx5fqu3lxGL?=
 =?us-ascii?Q?BOSuf2ij1+CyxDVxKHs9llW4htvK6IbiicfVaBwjEJwl8y1io70QJ5veQpfN?=
 =?us-ascii?Q?NhPAAS8J1BidpLxEf6RbvPxGxpgLkfIHXBcgcRhtl+r5SXzq4BovQTc60TTU?=
 =?us-ascii?Q?QE78zQK8oluAH4cmu6vZOEAjzajrSUFzSRIVH7Qrd0hZytwlAYU4OtK0+zOS?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb96b2de-5a1d-48aa-64a6-08dd204e84cf
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 16:59:36.5463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aba97y6W11g3rBLm+zIn178g56dVUDTQU1RN5DGax4NSlQaoPFVvTK54Jm1L2Tg92TfaIBCLOC90VU0WjGT5plffBtM0pRwnvVww72sexaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7770
X-OriginatorOrg: intel.com

On Thu, Dec 19, 2024 at 10:36:57AM +0530, MD Danish Anwar wrote:
> 
> 
> On 18/12/24 10:29 pm, Larysa Zaremba wrote:
> > On Mon, Dec 16, 2024 at 03:30:41PM +0530, MD Danish Anwar wrote:
> >> HSR offloading is supported by ICSSG driver. Select the symbol HSR for
> >> TI_ICSSG_PRUETH. Also select NET_SWITCHDEV instead of depending on it to
> >> remove recursive dependency.
> >>
> > 
> > 2 things:
> > 1) The explanation from the cover should have been included in the commit 
> >    message.
> 
> I wanted to keep the commit message brief so I provided the actual
> errors in cover letter. I will add the logs here as well.
>

Commit message has to be as verbose as needed to provide enough context for 
whoever needs to explore the code history later.
 
> > 2) Why not `depends on HSR`?
> 
> Adding `depends on HSR` in `config TI_ICSSG_PRUETH` is not setting HSR.
> I have tried below scenarios and only one of them work.
> 
> 1) depends on NET_SWITCHDEV
>    depends on HSR
> 
> 	HSR doesn't get set in .config - `# CONFIG_HSR is not set`. Even the
> CONFIG_TI_ICSSG_PRUETH also gets unset although this is set to =m in
> defconfig. But keeping both as `depends on` makes CONFIG_TI_ICSSG_PRUETH
> disabled.

I do not understand your problem with this option, CONFIG_HSR is a visible 
option that you can enable manually only then you will be able to successfully 
set CONFIG_TI_ICSSG_PRUETH to m/y, this is how the relation with NET_SWITCHDEV 
currently works.

Just 'depends on' is still a preferred way for me, as there is not a single 
driver that does 'select NET_SWITCHDEV'

> 
> 2) select NET_SWITCHDEV
>    depends on HSR
> 
> 	HSR doesn't get set in .config - `# CONFIG_HSR is not set`. Even the
> CONFIG_TI_ICSSG_PRUETH also gets unset although this is set to =m in
> defconfig. But keeping both as `depends on` makes CONFIG_TI_ICSSG_PRUETH
> disabled.
> 
> 3) depends on NET_SWITCHDEV
>    select HSR
> 	
> 	Results in recursive dependency
> 
> error: recursive dependency detected!
> 	symbol NET_DSA depends on HSR
> 	symbol HSR is selected by TI_ICSSG_PRUETH
> 	symbol TI_ICSSG_PRUETH depends on NET_SWITCHDEV
> 	symbol NET_SWITCHDEV is selected by NET_DSA
> For a resolution refer to Documentation/kbuild/kconfig-language.rst
> subsection "Kconfig recursive dependency limitations"
> 
> make[2]: *** [scripts/kconfig/Makefile:95: defconfig] Error 1
> make[1]: *** [/home/danish/workspace/net-next/Makefile:733: defconfig]
> Error 2
> make: *** [Makefile:251: __sub-make] Error 2
> 
> 4) select NET_SWITCHDEV
>    select HSR
> 
> 	HSR is set as `m` along with `CONFIG_TI_ICSSG_PRUETH`
> 
> CONFIG_HSR=m
> CONFIG_NET_SWITCHDEV=y
> CONFIG_TI_ICSSG_PRUETH=m
> 
> #4 is the only secnario where HSR gets built. That's why I sent the
> patch with `select NET_SWITCHDEV` and `select HSR`
> 
> >  
> >> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >> ---
> >>  drivers/net/ethernet/ti/Kconfig | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> >> index 0d5a862cd78a..ad366abfa746 100644
> >> --- a/drivers/net/ethernet/ti/Kconfig
> >> +++ b/drivers/net/ethernet/ti/Kconfig
> >> @@ -187,8 +187,9 @@ config TI_ICSSG_PRUETH
> >>  	select PHYLIB
> >>  	select TI_ICSS_IEP
> >>  	select TI_K3_CPPI_DESC_POOL
> >> +	select NET_SWITCHDEV
> >> +	select HSR
> >>  	depends on PRU_REMOTEPROC
> >> -	depends on NET_SWITCHDEV
> >>  	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
> >>  	depends on PTP_1588_CLOCK_OPTIONAL
> >>  	help
> >> -- 
> >> 2.34.1
> >>
> >>
> 
> -- 
> Thanks and Regards,
> Danish

