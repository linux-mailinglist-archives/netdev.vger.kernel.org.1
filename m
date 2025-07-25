Return-Path: <netdev+bounces-210031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED58B11EB7
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0B61C2613B
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57202ED151;
	Fri, 25 Jul 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KjckvhT8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139CA2ECE82
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446913; cv=fail; b=FcC3tX0IOvCgbwDzpZ6DV7h0MxI9EYAx42os9JVLjG0OVEJpeXV2hMVVsyS55y5XkvjUOPVMHViRMqqP5Uvebtz9CJ8pnO2lqo095aKh1AHScUunIibMjwN5+V8vz88atMXQY8mpydFDMgbO9cEXF7uXl8MAHxXwYdgsJda0MCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446913; c=relaxed/simple;
	bh=YDIMx4g2ti0PTicLrF6BRtjnskPKjDQZHzPGhPYUwAY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=XeyLmzQUHDjwSPc1H7yS+xLUQg22M7C+u5yiamYwo/QcGmqO5zJZ9H76OO5FvHwVMRM3lDMxKqf/LnlBcNahRwwZDOih+65otgkYNNK4OL0et9hRN3arhrviEd08XCS4izUHbt+X2O5UoHEiTNIyUV6Y60pxse6LioV0O4oQrvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KjckvhT8; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753446912; x=1784982912;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YDIMx4g2ti0PTicLrF6BRtjnskPKjDQZHzPGhPYUwAY=;
  b=KjckvhT8wNcMVllLgj8j8lO7KiIZjQXsOJAgLU/XhpAF4B51gHgoFY8E
   yFHNUh5yzZS5fqnwyw50YqUhGeNjNZl5eEkECVgcHIfKV1vsR7/LndeoR
   a2TyEtDMDfGomsvCjdxHzfJD3CPohDOPjOeHUkWb1kxQmi8J58E4ytjpJ
   TJhUn93ubsrxyhqctJGB2pEpG6T6mabh90kSr9aQaxzvUDwJ/pcqvFXOf
   algdkhYYR1zRH3lQ5Hl7+JbgrpUnW1sM8mrBxIh4u7en7HgTDO4kjVVCv
   vejJ/lHlk811EGUPiLKklekhmjegDWRoHxcEz6F1oOSWS98mjVl0TlSlU
   A==;
X-CSE-ConnectionGUID: m/RQExKfRSOwvVY4+A+rgQ==
X-CSE-MsgGUID: M5b3qow1SWil0z3lqlJSKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="73362551"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="73362551"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 05:35:11 -0700
X-CSE-ConnectionGUID: Ot50CndiSkeY9i/JrPXa9w==
X-CSE-MsgGUID: byi1hb1+R0CN3efCqcGSDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="165068329"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 05:35:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 05:35:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 05:35:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.83) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 25 Jul 2025 05:35:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHdcKuVrSUNhav0xDa69SuIkq0IC/7SlruCmNI3wEx+iVNanF0fBg6pkLYrZ6QWJAo2CmoUcrOq64x4WJr1T9dUyigJhCl6QmXBlcyrETDBB13/fLFY0WyLCzPmBqxIBeUBssDYBXk4twP8pNxSx8iPx37lgwsKbkg4cUdriSuB8Yh2n4U20npYNfk48pDWvW1SDYwFt4DdH+jz12PQqgxdkDp12ZZuAZxINkgNOlrtyVuTA2QVnsoStGxM9c+MlwVzXQyQFhczW3UixPDnLCGoof/9z98tBc0aGw3y+HCgTnc+VS5tWbmTLWCg40JISOinII/AaoyvzElnRRis5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlOQIfsdjkYIg3hqXD5bX3Rjsyh6N9zm5qRng2dCxGM=;
 b=Lt/b8cIK5zs8+yRNFvCMSx5dJ9Kx1V9rh9rkZRNdjXMtN1PgG+wfmyJRH91jx54Y6G5t4M20LodoT0wCrSYDLx/3Q9Q8hh70zyp24XhLTYj86hm/GpyCCACb7Fb9Wq7spzgMJNiqHCwJEKijx4/8PFlBqqDV91yhW8I/BqAZejjy7bqAwy2xoHnUs/2lEDgRiM+PVQgOpSbmz/1TPNuQFX4D+oUw/jbykjvIiA4LkLe7tExKvVRpsvbu1eXbkQuIC98RhGwHrW6ic0HXKJqC4dCh6pbKD5ut3B6HjldzJdsq+5XMFpE7mN+S9wOhHuxgosucTBsAbD/ObwjKlKlAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7147.namprd11.prod.outlook.com (2603:10b6:510:1ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 25 Jul
 2025 12:35:07 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8943.029; Fri, 25 Jul 2025
 12:35:07 +0000
Date: Fri, 25 Jul 2025 20:34:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Carolina Jubran <cjubran@nvidia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [selftest]  236156d80d:
 kernel-selftests.drivers/net/netdevsim.devlink.sh.rate_test.fail
Message-ID: <202507251144.b4d9d40b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1de7e4-1646-48d8-1c76-08ddcb77b021
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HO0c/OnMyUthFsmCsBB5OJg6/IQOPWtmO1/RAR+PcBNTPO2HA6I9462y1qEv?=
 =?us-ascii?Q?fW6p+eaDBlbOGbytqpG/j6ORMDxkl59L1gptZOLu0F1948DWP1J2XQ0JI7cm?=
 =?us-ascii?Q?FVAQEH5id5DYBsMsMlyzTwhFSKa+lxCJ7UHkuTn3N5rG5Fsu38aNSJKEVczY?=
 =?us-ascii?Q?5tmz7n6pxBHU3r2X8PkpNbi+yz8wZQViLGjhvAzNcgnOZ1QWKP15xr1CR8H9?=
 =?us-ascii?Q?it2bDUymNO6PCcQOB/gSt12o3GVccATok5oDxer8fSttVDNZg9QCmnVoa+6h?=
 =?us-ascii?Q?RcOTjggnXZh79KkMYKYgS/+tRafDd7GrbLDg9EYSW2Wq4BahbCO2jex+bdOx?=
 =?us-ascii?Q?H1sOWNAJfzONuPLaYtKNscGbKF/QC6sJPDCbuhJ+dOMcSKAImfIwSmCH4jfk?=
 =?us-ascii?Q?d87xBzGRsNNgB06tuySeFRHf7f3+WIejJo7G6cKXczQnnx2EeUxDWQ2PDqUT?=
 =?us-ascii?Q?16iuQrZWDp/OxPgp945uhVzVk2UVaoWG3dl7pJfSJm4bcdbufJa791SEwn00?=
 =?us-ascii?Q?bFc8kfHiXLdRBG6zKYsO9TvxbWz4ElX6U6HZ8AyLRbUYAk87gRnpk0caQr6R?=
 =?us-ascii?Q?du+GU6n/CqmHQ/3bGkUlQt2+eRWB5nLXrC3T2RdEwOi8/8TD3AquTsTmt8aT?=
 =?us-ascii?Q?gAX5cbOI6+WYqwzpA1JuZwDYGbNG7kRn2ad6yWyxC7HwffZTfneHgBjIikTg?=
 =?us-ascii?Q?ccrmeyx/hTgCPWUMm0vlvY7V9BuoTxn9KAkYIK9AgdFSPJlPbQf66L7MCxln?=
 =?us-ascii?Q?M80/bol60QrL+mtslJkaIKTHEy+W1VZ7PWnsWzvK40i7rRBWstFHdYkLJJpk?=
 =?us-ascii?Q?P0U5xqOwMA4LEx4NJc/o++zKMheX33i7miVRW3cguq8MlMYO6mPzR7GwMoOw?=
 =?us-ascii?Q?brA7iw6+gT5bKOT1QOmRRryHP9Lb9ORW5othnaMw8dCox/aJNx+msV27wx6i?=
 =?us-ascii?Q?uk6IZBVSCDL+cjkicUFiH2s4RwPG7DrnE4Aa/OIJ0gSlevGBJo05AsnHPg1S?=
 =?us-ascii?Q?BmldRDJeqJ+sV0cHfWz3y5x3ka//su7bfxc5EwaFGG+oCQeVruzVNeelLc6F?=
 =?us-ascii?Q?1aIByQ+wQEu9znyI69caO7eRIZXaveWXYdnC1Us3HHPnnWWhJOyum7zq5Ysm?=
 =?us-ascii?Q?/FkK47HYG0GS0d2RkNFCM4xCABxN29JMSpS4WAoDmVAB8rGlVWipaX5T3GBm?=
 =?us-ascii?Q?uiW8HA0IC4V5gCirgLNNp4pEsq0e8wcLA8heVci268/fW1ooKMah6Rilyu8U?=
 =?us-ascii?Q?JpRw6wLr+HffcqnxKIYWK7ZJ0uY9saU0tlNI9u3ZA9ImkE9iiUdsZMo9WM+H?=
 =?us-ascii?Q?s7sL4/ePeRgJXQWidcMQYddvDilZnFSt9xE86ZVatZuQZv5ddqY5OdqcRf/i?=
 =?us-ascii?Q?kFNIMYLpy2Y9BWtPegRxKaAhdEor?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JrFUhTaSoWisnKoUWXYrzYNwvGY5Ed3psNBgmvxbA0xkLtGd8jyQ80CENKcp?=
 =?us-ascii?Q?aRJbxDqyfBPqSS2zr8kzdChSr34W+yLXY6CcO/ChqUf/QJNo8AA1227GradC?=
 =?us-ascii?Q?/HO4yhbOUvCH6H6UnHYHxt334KnKUuxJWCOF6cafPlvl8khsJECmBTVx6QSt?=
 =?us-ascii?Q?1khOLJSwLmHUyD9T2OlEPIT3iIGWbUmUr2tBR1wNg4eKn3A08JFuiUJmEiDG?=
 =?us-ascii?Q?JhPk8ZZAG1bQjoQgH5x/tPW2TmBcOF0bPArXOA1FK0qhEHB+MUL/6wFt4sNI?=
 =?us-ascii?Q?4QXEVzooUmcdqaTlNXv4VbK51v9FzRLuyZGcb84KxXfCEeVxcOFTm+whyVm/?=
 =?us-ascii?Q?dzcqmOYl9EkHibepKrWFXul97ZeKVRFxrHarRPYFSU0dM3BzQWFPZh5V5Zv4?=
 =?us-ascii?Q?zM7oohjVYJsVHxvMO+rRdKfNan8phDtwiTcpvyARFDx+32aWgGwpozZEdecs?=
 =?us-ascii?Q?Vr+1YUWBGT+tcjWAP5aR8QGzPxqUJ6ZV+bC198o900CTyEcENK+2MYdQkZvu?=
 =?us-ascii?Q?QHbFlI3RcxwJ3uGPzFNUP/DmSuVSPrmBAN+PRggw8JLwMflFBr8BosUJusUC?=
 =?us-ascii?Q?RB2B+QGTwMb4kwdks3hHCuoLbWHSm/MwzFTGTfPXBkI+IHS06La1QBvlkBtJ?=
 =?us-ascii?Q?glVYsLVl8AO0oQ+JuICeHr/EvR+Y3pzpYlAl81X2ZXMvC0RcYwOAvuRN5TI4?=
 =?us-ascii?Q?J9+gYcTDcW7jd0cKbAinR8c8XZwm7d5z1/OUJxo11Ib08nrL50fGhEjAzwm3?=
 =?us-ascii?Q?4c37TI6/iW0+qU4RNcKgXd09xlxIgpwLIZIYTYYTBv749HfLNiifsd+0wou+?=
 =?us-ascii?Q?n/8OLIqRCOi55SMaRadOoVtyz3hE8VOT/HfUjbDNCdPBh8BiAqpZ7ba/OyNj?=
 =?us-ascii?Q?/Ep97h9rX30yEz0Ivtdd6i5W/RMCpmwq5VrC+a/RqUn3ugUW7QgY+2WD0iVd?=
 =?us-ascii?Q?/77N6KHihL9UiwaoaR5o1vnUJgywHh4Iw3C/nqqpzkGVIWaWiJpHtYmdaaKi?=
 =?us-ascii?Q?neLqM5WxzfiR2cE9X/VcJqL/xNc4PIJo6HlJopRCHpcluF8EkO24QRLN2lp1?=
 =?us-ascii?Q?DGRFiTUYRnITVTuqYMuSQo97pVZ1tsKoGm6FEtkFqjF04UmOsz0h2B61XxUx?=
 =?us-ascii?Q?EalkQy8r1RIIWLJ5HIyfwQfKoL4pbcOCTFQ8S0BSTIv0wMpXi8fepg+5rInU?=
 =?us-ascii?Q?29V1rkm7t2OTiaOY5pKGHtoueWF+um+vuC/IIO7RYIZrNIBJWEtVbK3rqKGz?=
 =?us-ascii?Q?BwrqQJZ+xZCK8V4CmLIrxwN1Iy25o9zbyGIGP5SSCQ5h7QC8a0KBLzsSvdGq?=
 =?us-ascii?Q?zpOXfzpefNVZxTtdeokePH2zQE9otlQ0OCNmY05V7hmQAh1rGEsc15sJx8YC?=
 =?us-ascii?Q?XyavvzS49rK/ToVci7M7amwy//Oc4yH0zcXdxipk7pCqbtFBXCytyr4zUT77?=
 =?us-ascii?Q?UF0r2UmxnKvzhQ+/2cmYJTS6u8JooqdOeMHM9VxjPXRTcmy/oE+siK3Bttck?=
 =?us-ascii?Q?IM/sR8yf7wJUK3bAy2vWEZ2uafB7H2/82T1HjbWp2V3brR6vBMyZhmKijwiZ?=
 =?us-ascii?Q?v9RCzVROypWEWhng5nUlZcrDtfhFFLdXuyJXKZRxe9g1n48J+21ULYEZpUGD?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1de7e4-1646-48d8-1c76-08ddcb77b021
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:35:07.4166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nnLVQWWh0IdOjaek/LT4V4a3WPywrgdngOmj8uwNYghyNmRkCDGyf+gzu2j9/pCBrlL7LiwMUianZLk1d+cJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7147
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.drivers/net/netdevsim.devlink.sh.rate_test.fail" on:

commit: 236156d80d5efd942fc395a078d6ec6d810c2c40 ("selftest: netdevsim: Add devlink rate tc-bw test")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 97987520025658f30bb787a99ffbd9bbff9ffc9d]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7ff71e6d9239-1_20250215
with following parameters:

	group: drivers


config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507251144.b4d9d40b-lkp@intel.com


# timeout set to 600
# selftests: drivers/net/netdevsim: devlink.sh
# Preparing to flash
# Flashing
# Flash select
# Flashing done
# [fw.mgmt] Preparing to flash
# [fw.mgmt] Flashing
# [fw.mgmt] Flash select
# [fw.mgmt] Flashing done
# 
# Preparing to flash
# Flashing
# Flash select
# Flashing done
# 
# Preparing to flash
# Flashing
# Flash select
# Flashing done
# 
# TEST: fw flash test                                                 [ OK ]
# TEST: params test                                                   [ OK ]
# TEST: regions test                                                  [ OK ]
# Error: netdevsim: User setup the reload to fail for testing purposes.
# kernel answers: Invalid argument
# Error: netdevsim: User forbid the reload for testing purposes.
# kernel answers: Operation not supported
# TEST: reload test                                                   [ OK ]
# TEST: netns reload test                                             [ OK ]
# Error: netdevsim: Exceeded number of supported fib entries.
# Error: netdevsim: Exceeded number of supported fib entries.
# kernel answers: Operation not permitted
# TEST: resource test                                                 [ OK ]
# TEST: dev_info test                                                 [ OK ]
# TEST: empty reporter test                                           [ OK ]
# kernel answers: Success
# kernel answers: Success
# ./devlink.sh: line 508: echo: write error: Invalid argument
# Error: netdevsim: User setup the recover to fail for testing purposes.
# kernel answers: Invalid argument
# kernel answers: Success
# TEST: dummy reporter test                                           [ OK ]
# Unknown option "tc-bw"
# Unknown option "tc-bw"
# Unknown option "tc-bw"
# Unknown option "tc-bw"
# Unknown option "tc-bw"
# TEST: rate test                                                     [FAIL]
# 	Unexpected tc-bw value for tc6: 0 != 60
not ok 1 selftests: drivers/net/netdevsim: devlink.sh # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250725/202507251144.b4d9d40b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


