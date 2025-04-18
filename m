Return-Path: <netdev+bounces-184087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F6DA93487
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 10:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273C93AAF03
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839FB2505AC;
	Fri, 18 Apr 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLdzQ/OL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92041DFFD
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744964249; cv=fail; b=VZHjMmC23A2SEDi05JWvucaDt963p+4N9kSfjtJOQF/b55yb9lyWOVmZLMs5gH7B/L2fv43/1ulq5HWPSJU1XL9A5Mm7vSDF5+p6mOcl7/CKJVkEBt2JKfq1QUdXuiq6ZaCC166hi2EzTePS7NgrXt0lm/VDN7Tc5ccpaKDxjvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744964249; c=relaxed/simple;
	bh=mBQwRVlopaZFgF/1TCSNlBgnFM9OtNuPaQWTGOzHr1Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=P4NyEKODkXN5s+3rDpIk3NJJ+k+e2G+Zx8IJoG49Qov4vu9vrV8NoJAaEY/3740DGE5mjKqLSIGCOceb7JVbEFsAXQI8BklvzmzEfQxO4VdSpFMgu1J8AAJRRu0u0AycfeHtBlXF9n0YIEjg9foC9nu1ocBUg8aS5iO3KJ3KKM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLdzQ/OL; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744964248; x=1776500248;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mBQwRVlopaZFgF/1TCSNlBgnFM9OtNuPaQWTGOzHr1Y=;
  b=FLdzQ/OLHZIaVUEAKwbOFsSSG468V2GWVFBbCuH1ZYKDH7zGzY2fQsct
   bIajjAnrx/S9ecgztxP2fqAbjFBFlhHTHDIRQpXjGUvtBwGu+J1jgxkjT
   YFAdV1RQPATEA7MjPf5lCTWJNYmlZdtoopXK8VN/VQSRqJ3szoVKEkMy2
   PovDM5w6jMfpP4qjbQfLCkULGf+EQraBInbnxVdzlR7WZiO2mC6uVJX+p
   RQweyWu/TxhlI1ckW0I6LeeBwqQdEQa6n7Ay4XEFBqadGCheKe7T2Jedk
   PcyN7H1KN8CdLXA4V7ASMpYLH37HDW4TkhJ0w516PRKfExDRB6gtbxapo
   A==;
X-CSE-ConnectionGUID: 0QOnsZ4ITzCye4LvspAywA==
X-CSE-MsgGUID: jThUJhvFRYOvhuJqKaPpsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="56761642"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="56761642"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:17:27 -0700
X-CSE-ConnectionGUID: +YJZ/1lWS6WPpg9vF1iv6g==
X-CSE-MsgGUID: IjFkExm2QQKl8M1QB+ZieA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="131364115"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:17:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 01:17:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 18 Apr 2025 01:17:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 18 Apr 2025 01:17:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NF03yq+XazjBpA2FFKTQhDrKgOQriFJeyhUSSmb5mSirHNjIw1bBUXHpfe7oQWRGFzUQdbF5r+Uc3At8hF2qPfiWTXWQyLtvkur6tPbrGVXtULjLjpp91nh0Q5OtUjvK6VVSScVrHUHSimmbFRiUh1tgnkfXStV3Uc3BWCOJUNAL4EXf1JrAWDedDxU2ax0sw/SS+wP3/Gkt99waLWDSHhLy84HFtZk2zrpzb/kKPRmE70Uba8cRVt626dU3wLvAFhmZ6u4UK9t8I0BX+6PmipzrbhWX1WNY1dH/FiVYFa9zGah3ougBvUoshzoaOvzIPXu4N0erfctbFxg3hwhYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6rDwLnICRtBzItWwNiRX5TpER5QUtHhIi2QhM/hds4=;
 b=E/7ShpUTgF9DNGpVJi7janMwjpgchnFvMEMD+er9sR+1MzMI9AEksE7ZQ9JvVORCXA9iTHdPa+jTn50dWXTuUYdw8wPgWK6WRl5rkTyjS/TMJTsVoYnXE9u39wrz9SKE/kndKZiEEcmSJB05/G8Ead+OA1KTmla6e+IE3TIXy4WQxxHd896VY4CrzVU9njJGt+vHK/+P4PvotxNopaFRDpSNNH8dTT8KrLfKn972mpILOhbQRmR0u0/o0xgYNq3375i0EuRXwaUVVweKhRmP3DhR9K8VASFh7DVUikXMj75Qrbxz4McJgurrF8vNk47qCGpBZCGSIqn3lAs15XOe8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH3PPF3ECB6A513.namprd11.prod.outlook.com (2603:10b6:518:1::d19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Fri, 18 Apr
 2025 08:17:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8632.035; Fri, 18 Apr 2025
 08:17:00 +0000
Date: Fri, 18 Apr 2025 16:16:51 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [net]  fed176bf31:
 KASAN:maybe_wild-memory-access_in_range[#-#]
Message-ID: <202504181511.1c3f23e4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH3PPF3ECB6A513:EE_
X-MS-Office365-Filtering-Correlation-Id: 357d0b0b-990e-4184-04d4-08dd7e5164c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HIsCIzbsjis3SXZf0yx7lkxDqNIn04cXdjmS+qkKosm9gQqoFIFQ9AFPkEFl?=
 =?us-ascii?Q?V7sJR+YRW0nu6l9oKFVT0jAvlEgc568ZeoK5YCSt0vtOmCi0WlDMbvxgIMVK?=
 =?us-ascii?Q?UQ5gSL7ng6bn5ZqmzSVgHr7nEpYo7HXRXuHdBofMJL4gXzRy+jqkJFnJWsPb?=
 =?us-ascii?Q?iuMEV4I0eUh1H8Zk50+czH6xW9QwSvaQR/QDC/65yD7zrn6Niy21xWQN+ytZ?=
 =?us-ascii?Q?zlkoMsyF2P9UrO8vHTg1Qj0dtpFpBDNfPthgqPlVhsFd91p2wnuC7Mey14Er?=
 =?us-ascii?Q?hsDOlP2Cy5yKWYkLWAlAIW4xZCB8sf5h2zO02pcBfCvygsotLmUroJ5vM1pQ?=
 =?us-ascii?Q?MLPgEyPEOyVuwOjz2yTjNf0NgN7BteqcMw4E2k6PVcxy0snfNagT1blLbcfh?=
 =?us-ascii?Q?OqL4wPfkxMs2bdL4PPdlXmuYOmKfdTmDwsV8bamIvYEFy1uI5WEKv02QMqsR?=
 =?us-ascii?Q?lxgJ0pXQh6a5SMVtynZfkTmYyM317EYBbGyi4xQkQ4mTIxcd4eISS9v1fP4V?=
 =?us-ascii?Q?3RPP1xJK/zCbPAQ+TRGBw3TCWzjlB1XJk8d8qGwPIq9g9SAIXOETSaCnFbyh?=
 =?us-ascii?Q?/smRBX6Ma/l3Iy2csRvARPGTQhOHcqomBaCKJbWiFIV6EDVKZP660wCYbIoy?=
 =?us-ascii?Q?DOK8SOMeLSPulS6K00kUUEooQHj5ZzxqzRgv4Po7kq5BfOfZMqWGMjP0Z/Ls?=
 =?us-ascii?Q?mQyMOiBeKeJ/i9S8CuEhjFes5V0N4dHSOZ49sPK0QvfdLeV4GZTMSE2hLUps?=
 =?us-ascii?Q?AOjdewFc3mlw4t29N3inZyxSC1jmqUppZ/OlImuYHmf7Y4t5C318iCipsjQt?=
 =?us-ascii?Q?/8zpwRaZ4r8M2BsVZDHcJ3bsWMOFEvd03JRnZMzsYkPGIwAyqEjw3M4fPo8u?=
 =?us-ascii?Q?1Hb4ztzJG9RwsaViAzo+dX2sKRjRpsB2QIW3oZSNT+h4butzUW9P0hn/wjK1?=
 =?us-ascii?Q?2Wm6/X55fr/RmdTwyffIKaAtMi7px1BYY2Us0UkbJUMs7/pKz1Tpgx3ro6I4?=
 =?us-ascii?Q?HxJb0pHYYxDm8aarbx3nWERqlQYpinc0Sj7Ikh/uzbYAaxNGv2KXelb9x8h7?=
 =?us-ascii?Q?nl3807OIV7703PlkZzftjnX0kbInNz/VNOLNV4riVfwFn5IwnXJd+WRZIwgQ?=
 =?us-ascii?Q?5+1bfSPP12NdGkp+egMuuMqF7glkf2cjXl1fQlicE9hCT/jdozKkVYCuAxRG?=
 =?us-ascii?Q?a4ITs1M2MKa3ukv+kLpOpQdPX4xhHnWjOVsYJ/O0P+t61olMvgz+O+/qJzU8?=
 =?us-ascii?Q?bys42aRdEjWRS+22hgn4ICdK+PTKSRh6SZj7MLgE8aumPqEBNq/OsashwQK6?=
 =?us-ascii?Q?M0KQq6NCXMNxGOUlzrbNOLqvtNuEKk9eQfR/TPHRKk6aYTp9EqObnL3aus8Z?=
 =?us-ascii?Q?+Bf9IXClrFnCl7XlMrSp9mcWTdJE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2pM7kS31sPr8n5m5+18x/cnuxQepyTobbZAMX7QFlm1/ROQcffXWW1Bh39DW?=
 =?us-ascii?Q?CF+XONPMQVh+RjT0P99nJyEWRvgXYuBeLYa61bSR6lwlEKweAB+Y/6VC79xM?=
 =?us-ascii?Q?EIR0op1waItaRTuxgv0d8wEl9k+U4x937lXFNFqSevNJOwUeui0Az99cm+Gn?=
 =?us-ascii?Q?AyolyQe7pxzLfCK6IkIBpzjMOvpGUSz4/9rTUD8uET18tUmD7mCKPlCj2QOe?=
 =?us-ascii?Q?gscKYQbhrJscWD6JdGbro4VtBQF5UCMakA7N/ptDAMAGoZOb7mUTPTEm0/lh?=
 =?us-ascii?Q?DNGc8AqpOs2tH7rszb+Vqc/4GzZtedddJrNf4uh698ynfOdxd84IG1pK+jDM?=
 =?us-ascii?Q?dyESnfYud3DgW9/d0T7Wuyq2Ow7gfuY4zT6wG9NzN2edMKncMT6xUcVwWFfK?=
 =?us-ascii?Q?r7NlPK8jFSC3qNclOk7vM1a7jM2NFOImhv1jzVNevbTTT+FS4BLc+QsoplE/?=
 =?us-ascii?Q?kCy3KiGopXofJpaOvyHy9nCLTUtR0rLJgaaUr+cBEjTHpcz5C0fQidLipETl?=
 =?us-ascii?Q?e2lSSYMFRckC9r+YFlAobJGb8jeTIY01S+myqEnMsTrjSJlJjmfBUKp9bZLM?=
 =?us-ascii?Q?q9C0/lIgqg2HHREK53pidkEPGPXv4OrbJX5pkoAcnECSsL7caLcMC6YsR/nT?=
 =?us-ascii?Q?3Y1FmHyeigCk9CcyZFm9un8aIAcPb+Q2Oe/DbS2cX1+18T1sE1ee5vDC3ouO?=
 =?us-ascii?Q?xAR1B/pGUl6BYMADw4cr688VadKs1OB6sU+INpsaLIEvtS2nFU7LMM4MlRo2?=
 =?us-ascii?Q?CCtnznKuYk3cudZ++7GVKMTuOijxz6iv1Pn2RZ6lfH2y8ZOohP3pttpNDjNw?=
 =?us-ascii?Q?bdJTAqPJdPsXJLKccLSalA3w1hkAIzyHoX2tkQIvgKCoDi1gX6AFmv31eget?=
 =?us-ascii?Q?W6XsLcDiC6alpQxatLB4yiZDGigrAF4OYI4mGcYFqdYqsxQytMvHlcpSIV7z?=
 =?us-ascii?Q?5nQnlELpOhfUWLldZmLSk+lPQ7m3AIBHOz9b1z68wgVh8j218RVhHN3uPhm6?=
 =?us-ascii?Q?1XYpy7KdXzy9ZgWaZoJ8kb3rMGUDLeWKENMgeZnxzeRkt5dhylsRZhA4stXh?=
 =?us-ascii?Q?M1aGcdtrjtuV7YqqyjvZpkx1eFiXv/6a+cMIvd7aQnvJVcEzYhSJrYs4nVk2?=
 =?us-ascii?Q?u6mK82q3Dn7hlV89Woj6mQBqlDNzWy1DGLZskkBT546sQzhzM/cgQ7FVhUtV?=
 =?us-ascii?Q?2JrfRMJqZfNkBTutZZUHl2x3zBvFmPkvhpFvLWkb+CQY2+KpAE1Nyq/Nj59l?=
 =?us-ascii?Q?LL+cC+ikkdbV4JSHN/U5VT6UZch4ektWgf5PhQp7CVVYLZvQzoUsFPa3nTBu?=
 =?us-ascii?Q?uYlgvyFQkeoUJ64+XGMR+/aslZ11btIAMD1IHkwaCDat4S9nTgmKNv67SROf?=
 =?us-ascii?Q?qKLMZPqouMJEtgedQ8KjFH8tl1GOGjXolMa0ElHcUUSKXfLHwJrWw1BfDV5z?=
 =?us-ascii?Q?N/jWOQzWpvynY17DbgdNsiDgfGSEMzdRc0zZRfcga7Ax6GC2jPDRg7+xVhqF?=
 =?us-ascii?Q?Xc8nkVdOvIWv73PQhWqD+Z5WofcxQdJPWJJEWXAQogIFtFQfvutoFACKmxib?=
 =?us-ascii?Q?NLhws5tlwL9uU+EEMvdK8AH9Zay7gAoqDBIieZ2ERvF+sm0xJ3nQEH08dh/h?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 357d0b0b-990e-4184-04d4-08dd7e5164c4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 08:17:00.5528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8jspJ1bnMeJkQX7fJLxHvDgF/OkxvS6TzExZFkZncL4SGU5hZAJW+DnWrzzrGqS4ycmseF4ClH7iiYkianAJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3ECB6A513
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "KASAN:maybe_wild-memory-access_in_range[#-#]" on:

commit: fed176bf3143362ac9935e3964949ab6a5c3286b ("net: Add ops_undo_single for module load/unload.")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 5b37f7bfff3b1582c34be8fb23968b226db71ebd]

in testcase: boot

config: x86_64-randconfig-102-20250415
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202504181511.1c3f23e4-lkp@intel.com


[   26.592836][    T1]     audit=0
[   26.593311][    T1]     riscv_isa_fallback=1
[   26.685729][    T1] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
[   26.694368][    T1] systemd[1]: Failed to find module 'autofs4'
[   26.766891][    T1] NET: Registered PF_INET6 protocol family
[   26.767880][    T1] Oops: general protection fault, probably for non-canonical address 0xf999959999999999: 0000 [#1] KASAN
[   26.769508][    T1] KASAN: maybe wild-memory-access in range [0xccccccccccccccc8-0xcccccccccccccccf]
[   26.770938][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.15.0-rc1-00261-gfed176bf3143 #1 PREEMPT(full)
[ 26.772418][ T1] RIP: 0010:__list_add_valid_or_report (kbuild/obj/consumer/x86_64-randconfig-102-20250415/lib/list_debug.c:32) 
[ 26.773329][ T1] Code: df 4c 89 f2 48 c1 ea 03 80 3c 02 00 0f 85 1a 01 00 00 49 39 74 24 08 75 65 48 b8 00 00 00 00 00 fc ff df 48 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 e3 00 00 00 4c 39 26 0f 85 83 00 00 00 49 39 f5
All code
========
   0:	df 4c 89 f2          	fisttps -0xe(%rcx,%rcx,4)
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   c:	0f 85 1a 01 00 00    	jne    0x12c
  12:	49 39 74 24 08       	cmp    %rsi,0x8(%r12)
  17:	75 65                	jne    0x7e
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df 
  23:	48 89 f2             	mov    %rsi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	0f 85 e3 00 00 00    	jne    0x117
  34:	4c 39 26             	cmp    %r12,(%rsi)
  37:	0f 85 83 00 00 00    	jne    0xc0
  3d:	49 39 f5             	cmp    %rsi,%r13

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 e3 00 00 00    	jne    0xed
   a:	4c 39 26             	cmp    %r12,(%rsi)
   d:	0f 85 83 00 00 00    	jne    0x96
  13:	49 39 f5             	cmp    %rsi,%r13
[   26.776069][    T1] RSP: 0000:ffff8881012979e0 EFLAGS: 00210a07
[   26.776934][    T1] RAX: dffffc0000000000 RBX: ffffffffa0202dc0 RCX: 0000000000000000
[   26.778058][    T1] RDX: 1999999999999999 RSI: cccccccccccccccc RDI: ffffffffa0202dc0
[   26.779187][    T1] RBP: ffff888101297a00 R08: 0000000000000001 R09: fffffbfff0c0ab25
[   26.780302][    T1] R10: ffffffff8605592f R11: ffffffff86055988 R12: ffffffff86471700
[   26.781417][    T1] R13: ffffffffa0202dc0 R14: ffffffff86471708 R15: cccccccccccccccc
[   26.782534][    T1] FS:  0000000000000000(0000) GS:0000000000000000(0063) knlGS:00000000f7251840
[   26.783797][    T1] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   26.784724][    T1] CR2: 00000000f7227f36 CR3: 0000000154a21000 CR4: 00000000000406b0
[   26.785840][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   26.786972][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   26.788088][    T1] Call Trace:
[   26.788562][    T1]  <TASK>
[ 26.788987][ T1] register_pernet_operations (kbuild/obj/consumer/x86_64-randconfig-102-20250415/include/linux/list.h:150 (discriminator 5) kbuild/obj/consumer/x86_64-randconfig-102-20250415/include/linux/list.h:183 (discriminator 5) kbuild/obj/consumer/x86_64-randconfig-102-20250415/net/core/net_namespace.c:1296 (discriminator 5) kbuild/obj/consumer/x86_64-randconfig-102-20250415/net/core/net_namespace.c:1340 (discriminator 5)) 
[ 26.789801][ T1] register_pernet_subsys (kbuild/obj/consumer/x86_64-randconfig-102-20250415/net/core/net_namespace.c:1382) 
[ 26.790538][ T1] inet6_init (kbuild/obj/consumer/x86_64-randconfig-102-20250415/net/ipv6/af_inet6.c:594) ipv6 
[ 26.791327][ T1] ? __SCT__tp_func_fib6_table_lookup (kbuild/obj/consumer/x86_64-randconfig-102-20250415/net/ipv6/af_inet6.c:768) ipv6 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250418/202504181511.1c3f23e4-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


