Return-Path: <netdev+bounces-212156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A156AB1E779
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BE9163C30
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D194226A08D;
	Fri,  8 Aug 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTEFY6xv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39E325D8F0
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653258; cv=fail; b=Dhcq9jxoMl82u9H5uqZUMyYaBjAqs/YAaZq+lgb7L9pvs22q9n+JowMM64Oexgbj8pjxVLq8j4unGgKPkheDcaCTKGqJ1XVyTRCIJh/cHVsqP1ndLnfEpCf85/d4x8pSJuHmSFbdUy0IR2UUFNASlbtefRPF+/c9QUBOooXbZNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653258; c=relaxed/simple;
	bh=r4Vn5blF6jh607DIRYhrCFXl2zTqv1d/tpWeByxvmfM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D4NpQ9TACXZVWbgXOBUl1Tfdbh1LlY2Olub41H+jdWa0qkVoucYJW+71I+9d3vHfN5Dm2EsN/jOJijInuqTpeAH/ZvtEHS8auP7WOazRLK61ExCZc4lK72RxRTNZWgwme95PtfnB/FCyRBBgnjnWcM+gTYHdtPqaQmkRsugkbc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTEFY6xv; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754653256; x=1786189256;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=r4Vn5blF6jh607DIRYhrCFXl2zTqv1d/tpWeByxvmfM=;
  b=kTEFY6xvFQsRzumhn5YYd4BBQD7Dnx9zExypqwsTxwJy7M+kUxHPeoCu
   EBpWW1qdK7wHzXAWLEmRru7IuSHph7fQxdkm5BW1E9LdfRMQUIIhR3s2S
   5/qbR2Uxv7KnYXC0yoYmXBW4sTZ2BVbQrp4MENrha46SYzRRR/yxkKGfD
   jY2zFoq3+Ox4RfHor0mBMB8y2/NOX3AQ5KmGsYfUDoTmNFJs4sQsDeCFO
   Z19OjzF9h781CyjBpsjWr/Qil3nWj03u33En1rZHcSsn0muBYEncSE97P
   b7gDQ7izSpuXvSVdTyMJnzsiWxdqD75/pfN59Xd6eKus2/5zJURdyLsEP
   Q==;
X-CSE-ConnectionGUID: T8NstvZzR3i+Y5rg5i+JaA==
X-CSE-MsgGUID: KtxB6KitTIepR2333QcuzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="82442936"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="82442936"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 04:40:56 -0700
X-CSE-ConnectionGUID: xZP6yuEkTTG6UFdgVmoAoA==
X-CSE-MsgGUID: w+UquRHkR1ytcESdCjacgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169771737"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 04:40:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 04:40:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 04:40:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.87)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 04:40:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3jZJS7M/uaMQl0v++6Wq8KuqYlcJ1U0hbLi1ndIyeK4WUlkeQ3CFOj3GPT2/f7uWitidIL9JwgMe502y+DX6HpGNJCKbSzIPxjsK1abrqf91tuGf/cW4qmuQ9pvyevhRjE7rNDR3z4ihnAUN5R1g81dLprmHXQh56xDB0qrd2qJG18nn3gpkdYbI+I97XcGfrNpJe03mk7bD9wO0bi05IzMxZeWG0EKpVhs5B9LyAl5JM8dEAxUIFsWTeRWGHxNdluMDEvPMVTRXqMjjVppQ2hZTtTt7IzdQTF2UjG1CJSrbLOw5b8dWBgzSnXBgixqSbuaUapzid3MEBV3aAsWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+RKtHZ0yun/ROIu3EFARC/jL+dywoe7JbtGOISfEXI=;
 b=L2aJQK5yyxpe+qtknSZ2rn/1Y7FYiNlPDfq3rbz5sihb/0soKvWEh50I65kyG8ySXuvLhs4Gp8XAy/QXHX3PzD555z7VpM/Gb6DBVuzJZVWdDEUwqNlnKVgRk2OFgWFRb1cNOCas3uV4etP24v66b/MQqH57bj/baHQAYMtKxd3JzSlx2ZWS+NT6ZMq9klHDiO3paC3Vi2ZAzD1cEAghRm++qP9hgA0kzAxh2Fvq53EUKLUvgDJbyeiNEP12a4a6ujJRGoiCHAGyssZb7RgjzkqHeQ7ncGCJKcsfzSAl+AbwwLNGXMSIflZpz8Jfdhlq26jo0+Nz7PPUC46k5dgs7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SJ5PPFEF71E136E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::85f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 11:40:53 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%3]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 11:40:53 +0000
Date: Fri, 8 Aug 2025 13:40:47 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <maciej.fijalkowski@intel.com>,
	<aleksander.lobakin@intel.com>, <larysa.zaremba@intel.com>,
	<netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<anthony.l.nguyen@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 3/3] ice: switch to Page Pool
Message-ID: <aJXiP-_ZUfBErhAv@localhost.localdomain>
References: <20250704161859.871152-1-michal.kubiak@intel.com>
 <20250704161859.871152-4-michal.kubiak@intel.com>
 <53c62d9c-f542-4cf3-8aeb-a1263e05acad@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53c62d9c-f542-4cf3-8aeb-a1263e05acad@intel.com>
X-ClientProxiedBy: DUZPR01CA0176.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::12) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SJ5PPFEF71E136E:EE_
X-MS-Office365-Filtering-Correlation-Id: c196e901-fd51-4a6e-7ecd-08ddd6706dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6FJ2353G1CGAZ4CLr1UZvOGWwscqwuDcLr8MWx8QcE2/bn5ZVvEbC2EwwSz+?=
 =?us-ascii?Q?eMrfUh2Ch6iXsDbGksiAOryz7AUgrFFFkSGi4cilzvNyGv3/y6ygjOdNtWjn?=
 =?us-ascii?Q?z+P39LbZX73sI7LdGI+nTol1qMOJ4pMxlnWM0u15hdb40sXOLKmNt5QUJPWW?=
 =?us-ascii?Q?Chf28KZg7/j5MTRSVHS3oQiTGpJCIsm+OeN+f1uxbqffusH91/zdO9H7SCD/?=
 =?us-ascii?Q?3SLc6UOiYDtMbAQDTzzOeFZAGpWUqh0vcdt+Nu1wbSF4pg0sWShuveG2w1ug?=
 =?us-ascii?Q?9TR6q76zuuUL85KnQImbWGRVPHH1UP4gJ7ltF23lEjelpyK7/cRNdiU4o7Zj?=
 =?us-ascii?Q?4dLXboy0fYlt9rHgePgwI5MTw2Gbnf9MStkArYs0/qcr+FJaOhiI5UTlslSf?=
 =?us-ascii?Q?ZsqtexCwSkZSpw+HpdszsGAST7COsO+vHYB4kRUvVVD7xmwg+/sQVVf83thv?=
 =?us-ascii?Q?UDDbd0xdOyvI17Q1m1FRS22si/RE5t9AMb10CU7JRYW8vV7Rz2Mi9Sj6yEZR?=
 =?us-ascii?Q?PoAdfMDTxh3lTXcIlOZrQ2AY6qG0DADfIFdd+vbQb3NDDvwIzDiU/5euzZre?=
 =?us-ascii?Q?+GUOwpFEtslctA4JsIGOwOjHW0EwtIqU6ikRGDmydmeTFqS629lEMbmrIT2b?=
 =?us-ascii?Q?eV2qAlKrXrjJnjPH3T6wHG4Twr5vnU0offvRL6ABCMDksow88ZISWxbZzsY5?=
 =?us-ascii?Q?kEbGpQq9Rj5UZJRRgtC6JQLdorIR7XVMOCiyZGtI/MTWvSkngwuuIhhAxuYy?=
 =?us-ascii?Q?/RapCrbGrnp7zDKcpqTjW7ygOnze9QiiblgVv77qdkhhdqLviDemw2TVgrvT?=
 =?us-ascii?Q?CLeQviPCEZ0ggXr2XIBgImj966BHXXWaGryu25fmfOdngw44Tts29x7Wbr/o?=
 =?us-ascii?Q?XzH/eDTqa3RotnqJhKld3oIKhe/W0I1MEFMreJkEMJ8udvKi5oj02kt9qdf+?=
 =?us-ascii?Q?j4ef8dQepTTUZbNQj/WdzwzOzXx+co+sdnvZlevEaJlG4GmzNuiGftait9G/?=
 =?us-ascii?Q?0EP0Nkp6z611PzvienKBdQALdiSp2C9mJd3FXqM84obzGW3V7YXGe3EESDAO?=
 =?us-ascii?Q?LImJy6orSwANr7eSxJL5FYc7y+4VzF5eqsV2ftAC6wJF1fbTrnCTfP5HbTUl?=
 =?us-ascii?Q?mLMpDOooEIqYAFULNTPLbJeC8m4qtUnQ9hrZzRDdW1NeS/i3aaR6GgpUMvSR?=
 =?us-ascii?Q?4SzNeaTMCCmi2K1i7VmPVSDeuF8DnBQ29OVm6LRqVZ/kSe0KfkbesZb2/S8P?=
 =?us-ascii?Q?8Z1JgssDN4Qe0EjFuxmuOGcMSQWLymyBaJtOfLgtpxrzTrcbfUbQW9XZO/dt?=
 =?us-ascii?Q?NEhLxR4X83yhdS6gp3DqdmufF7wUAtOSMSXEQycoAWKcp1aRWYpvHd3oCVw+?=
 =?us-ascii?Q?k0Uld2Wvfnq88dLJMyAwE9e8Up3M31/p43SERWFrFgodkvHTkw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B6wa2CvFI4nJUnSJpulPD++ic252sI91GHzahltXwrq6fbX//c1SJytIVwoW?=
 =?us-ascii?Q?gvtorjPXD2FPiuzg7SUbIbe20oRWaKyfLG1PSKiXFyGi+5mVsPhYgDq12tvT?=
 =?us-ascii?Q?W+R8MyF+l3DrHlpoIfJw1JssWoJILuUnsUWxasN07Qm5+P11jRjQ1iQyoJHL?=
 =?us-ascii?Q?ykqWisY5upZ9qo5gvQ5c0sOnF3Z62vSZnP0bTQcpaOllmIW/U2mEcYyJpKwv?=
 =?us-ascii?Q?cpKGnfXl3QNmJtoEjWM6atfIMmESjdncg7hIVexOs8t9e8wD+vB0QqnCp+MY?=
 =?us-ascii?Q?2lNA46U/2fSQWIdsDnr38r2pJUnndB1nDD8kne8kn+K59KP15Bd/GIu7eXQv?=
 =?us-ascii?Q?YZ6e4MShPADWeHmz3foobOmDhytBCO1HlcK7qMn7ygyMvswvuW5EXvkInVv4?=
 =?us-ascii?Q?wMC4ZnD8empCvdhp6eO0NEBdl2W5M6GiJXxa6RS2Ut5d5zxX+a+s8JjhAfL9?=
 =?us-ascii?Q?Ctu9xKGXozIiSuT5jbIS1uOZ1MyQfIDLitdNwDLJeBK4n4mBaHSNCza2URiU?=
 =?us-ascii?Q?gwkfy4Z6EKSL4IgZKJUaWaW4+SpUGtXa0q76Vlyr8WETO6HKrNDPLkBQQbWp?=
 =?us-ascii?Q?r3V+YWeZDlCmogTv87oApdhymZi31wVo8ntdPjvtNq8g87pcEdzcat4Cgpsk?=
 =?us-ascii?Q?Qe4Fm272SHu4DqABq+qDdTzhN4vfMpnW1epLO3juuC/IzchfZCLRJWoKgy3w?=
 =?us-ascii?Q?YnB2nZg/PXYr6a++ErWwyfj5qgKtKwDLOLUNI9OivmnDrQjI7tMNZukNfegM?=
 =?us-ascii?Q?42VMfTYYa9RNSFILy8WzCb6GiJKRoN3SPgnTlYJcI43dnoTipU5+N1S4Crai?=
 =?us-ascii?Q?jsVVZcm+84UyEyuRpk1E4tfHzfkMFqeB67jMkZXanjkbTd3nhlSO9ZeNGhRj?=
 =?us-ascii?Q?KnBCgUCY9Z3lBPuMT6G/c1m+A9YndhdG/b5fVfIe61u2i5zvIeDATzCNTX/7?=
 =?us-ascii?Q?UxERWiMNd40H5+zI982N5w3p5bxsilkdOJyeBeKdo/ky2Dd/KjM/ZUJKCezP?=
 =?us-ascii?Q?ZB2SVGbTZhB+s4ZUIfqMj/eVg0lrNahS5xobkQtJvqKDCg0Lt7iBmPAF/eDq?=
 =?us-ascii?Q?EBy3GS8q7siZXaFg+8T2NHrS4/IFNCDWrQszc63d9H487Ppk+ynBPEF81RoI?=
 =?us-ascii?Q?DvGxJJ3tK7tfYkThYPtHyvTJlYkysb0S8RKVDA57tKZq8Ff+VnOA3SBimuly?=
 =?us-ascii?Q?MlnJQwxOiOc2sZnDK+AUu8E9SKQ4Rpu7zCH3sjv/BTiZSbeRej+t8sTa/3cF?=
 =?us-ascii?Q?IAc6PinR2XL0nEchHP+wNX1/EGNReULkAwmAzBw5mCuQHPc6GTMaaE0t6LEB?=
 =?us-ascii?Q?nI5d7AK1PiWjnYRaiC3vLNA2tukHQ05SROsL2iA95siWHXunEK5y3c2+ru2i?=
 =?us-ascii?Q?Pn1trzeTpPMFv9MuyKjYo8vaVJA/NZW5aE2ILjJBPwYwXxiBbfoGFqVIz4gG?=
 =?us-ascii?Q?ZaTWjeL0twCJoUVQf14EADY2+E3BRUr1M5NbSFUyKOHjcV6/HmxM+yCxqUaD?=
 =?us-ascii?Q?7uljW7alBi+47Cq3EEd37+43ZhpTpOYTE98jOlU/FyrnTBO6kOvHLGcDbLY+?=
 =?us-ascii?Q?W9X/es8GiYs+QKLAABuBMoYk8yVQYbWQOfhtWLptz8yP/Am3AY08R3SuFOrf?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c196e901-fd51-4a6e-7ecd-08ddd6706dfe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 11:40:52.9631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XoLb3q00abja16gGahnRAaRJx58wActq/RUbvreONVSN3FR7DvoyOVth1iLgZNRUYThFeLU7ySzM/+HzCN9oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEF71E136E
X-OriginatorOrg: intel.com

On Mon, Jul 07, 2025 at 03:58:37PM -0700, Jacob Keller wrote:
> 
> 
> On 7/4/2025 9:18 AM, Michal Kubiak wrote:
> > @@ -1075,16 +780,17 @@ void ice_clean_ctrl_rx_irq(struct ice_rx_ring *rx_ring)
> >  static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)

[...]

> > @@ -1144,27 +841,35 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
> >  		if (ice_is_non_eop(rx_ring, rx_desc))
> >  			continue;
> >  
> > -		ice_get_pgcnts(rx_ring);
> >  		xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);
> >  		if (xdp_verdict == ICE_XDP_PASS)
> >  			goto construct_skb;
> > -		total_rx_bytes += xdp_get_buff_len(xdp);
> > -		total_rx_pkts++;
> >  
> > -		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
> > +		if (xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR))
> > +			xdp_xmit |= xdp_verdict;
> > +		total_rx_bytes += xdp_get_buff_len(&xdp->base);
> > +		total_rx_pkts++;
> >  
> > +		xdp->data = NULL;
> > +		rx_ring->first_desc = ntc;
> > +		rx_ring->nr_frags = 0;
> >  		continue;
> >  construct_skb:
> > -		skb = ice_build_skb(rx_ring, xdp);
> > +		skb = xdp_build_skb_from_buff(&xdp->base);
> > +
> >  		/* exit if we failed to retrieve a buffer */
> >  		if (!skb) {
> >  			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
> 
> This is not your fault, but we've been incorrectly incrementing
> alloc_page_failed here instead of alloc_buf_failed.
> 

Sure. It's a good idea to fix it while we're rewriting the Rx path.
Will be addressed in v2.

> >  			xdp_verdict = ICE_XDP_CONSUMED;
> 
> xdp_verdict is no longer used, so I don't think we need to modify it
> further here. It was previously being used as part of the call to
> ice_put_rx_mbuf.
> 

You're right. I'll remove it in v2.

> > +			xdp->data = NULL;
> > +			rx_ring->first_desc = ntc;
> > +			rx_ring->nr_frags = 0;
> > +			break;
> >  		}
> > -		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
> >  
> > -		if (!skb)
> > -			break;
> > +		xdp->data = NULL;
> > +		rx_ring->first_desc = ntc;
> > +		rx_ring->nr_frags = 0;
> >  
> 
> The failure case for !skb does the same as this, so would it make sense
> to move this block up to before !skb and just check the skb pointer
> afterwards?
> 

Yeah. Together with Olek we re-organized the logic here, so in v2 it
should be simplified.

> >  		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
> >  		if (unlikely(ice_test_staterr(rx_desc->wb.status_error0


Thanks,
Michal

