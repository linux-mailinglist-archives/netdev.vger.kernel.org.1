Return-Path: <netdev+bounces-158757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD84A13242
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9BFF1667DF
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E9F142E77;
	Thu, 16 Jan 2025 05:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVyLJ2B7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FF01E505
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737004576; cv=fail; b=buPRydLtlX6u6BibwD2mOjTx/pUUTga7Gw8fvmPX2Srg6/C8uR+VQ6Cj8ddJgNJ6Znt9JJC/FCEQNH7syohkKKktviPQQ3MpFIpZRjfKLjOD1ELqmvWfw+vd986rT+0Uj9BvApsgD/uRneRszXxfmiyB0OpvJiSn+40Wyyxv4ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737004576; c=relaxed/simple;
	bh=HY3YJmr1zl+lC3s5Y20dPOfEnwhV61GwWHM9yM0Kz38=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=s4h1V2okjUK3j6QaqOfmoAH2PFUO7tsEFOTF3Zx7Y8f2snLEmIIPDPUxov2THwZwhvOQwpEDshnnuc9iA2rUwEltG4xyCbP3KkvJUZ++F3jrFignCP3KQ0RKRgQ0kpDXVrz66NX9M5XN6ZG8pkyPD3L0iLTPLELcT/fY8fZCNek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVyLJ2B7; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737004575; x=1768540575;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HY3YJmr1zl+lC3s5Y20dPOfEnwhV61GwWHM9yM0Kz38=;
  b=UVyLJ2B79aK/RZC0SCv7DRzNyfYEJ8J7rU4MqzroDU8Z7yGfNpZG11qs
   8xgoG++Ih6mRshMJKbPbmZ4YV+TPgcjD+Lzi7CIl3S9mNDBSATO0xZzLt
   jNUbu48mXooDs2rp4j/VYHRlE3+WZDZOe1ka8ByemCVlGENvWssRmyFJ4
   caLWjuKKvy4zGAJXOzzaXHKmlPdT3f5T/VsnnNpfqCnVt6RkZR0SgLsvt
   MNSF0hC1swMCJ6uoXa0kKv1YCa92IhgfBG5BclaldZ3d0VYBVEJ/Q8+a1
   auZXr+hNrEZiRscs+pHwrw+Ep6NjtPMYx4rDi+ASx4ohON3AxbIsJ/2Pc
   g==;
X-CSE-ConnectionGUID: /TGceU50QiWolzukjEY0Tg==
X-CSE-MsgGUID: iSWVu7s0TuWFI+BRre5SNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="54913927"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="54913927"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 21:16:06 -0800
X-CSE-ConnectionGUID: DDiCzpVhT0CoJ0h16pzvhg==
X-CSE-MsgGUID: 5jR7RBlgQcuL8oxVZaIKew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106234966"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 21:16:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 21:16:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 21:16:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 21:16:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5FQUoazNXVA20pv5AGvgpox+UzEmnHV22SyTPGeD5sauTPEURY8teErMInCczuqYlaWPsTvuMw3WuotJSBd9eTlr8OtE9c7g55smyuBBK0qbdMyecr19L5JYYa2kHLAKV4+7uyVLfRH+YNfzrN0ur0ICsPb9598OEEIYSEbIvRXhWK4YVFdo0otqK0ZLC+4+GZnb4i7h40inNFFqaTzt49Zw9HAh+cYgV/TZ0kA+VY3YoS4N3bcPw0GjDH+z1VJN/BZnA7gNZqSZFA9Th0jQNCgyK1GezoeF613y1P8fZCU3mfe71AuP+gMJxCLRUrJ3XYex7eTDKpJJ9W/ufuQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxN2aBWxMXEVIsDsgnr3L7gTzFGOHun3amGUgs6pTD8=;
 b=azTCck2yiHI22O1ri4oT/mRCIF8yfkpzNLSymzY9n6nC5nCDst0SXSNIZ04fsUKsfUPMJxoSS++eVunFtgY6XIVVTPD+aOoNpgPSf23sVffuRHKs5K6bSHFYhljK3ssgcqtAwMPMD625F5oCTTX5j05uUjllbCgctYPNhee4bB0MDjIkgP1UIixeMHSbrrZ1Lp1nkBuf6kRgrAB9rcTXNU88k5HN/9ZDdOxJaUNhKBqL1+x1q1y0VURTrWkd3bnUrlklMQGyDJJQZidBAKRJ7TR07+Fz6cHxtLSRqnT5K6Rk2DcFTf7rwfavsUR+q2DwYUf8zkTBx3ONgqgpwrcVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 05:15:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 05:15:29 +0000
Date: Thu, 16 Jan 2025 13:15:21 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Breno Leitao <leitao@debian.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Tejun Heo <tj@kernel.org>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [rhashtable]  e1d3422c95:
 xfstests.generic.417.fail
Message-ID: <202501161047.39c960cb-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 921787cf-adb0-4ed2-e6b8-08dd35eccb6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kYTJnbekINes/iRyz7F2JpVZS6qDFTPSuuElWUOjTCbyOUi0NpF/uRPVZciY?=
 =?us-ascii?Q?0ETrqYo1CiHx++mKh+p1wzkdPmrJXDh5ha0s5fV48uOt5/8I3J1JvcMMp9vg?=
 =?us-ascii?Q?B9pzb4UCeM2FjLsuyGDghZkbeH2IaeDH3SuNfXrhv+MOHGiuqxfucu6u/1qJ?=
 =?us-ascii?Q?njz5f6I7pDBefSoz5YA+blRw2CAL3qZcPUqaCcDCbhOX6scS0kHkriBKK8Bw?=
 =?us-ascii?Q?aOtapFgbQ0RoqLi11yn+br/nozSOgZJDqjv1qvMZ60cETvjfvdCZmaARJotY?=
 =?us-ascii?Q?2wotpfgmFHHtcA5I09nkq1dX+GFIIyPTKB3qmt5akteVB27nU7hKP32xYCgr?=
 =?us-ascii?Q?Blj9QkUGkIPpkrH4/UNs2YKEP03NGoGEUQn6ofHN4SiCFo7wFqeuMTy+e9UO?=
 =?us-ascii?Q?zjqI4vKEu0cqyIjWNClJ27Dgj2lm8OrpjPjiyp3/m0oO5ACkmtqX4xm+tCKX?=
 =?us-ascii?Q?D53PtitfaUHWNnZcIQVUceIZoKX2XfljxdQmt6pSDOnZxjjZBp8lb/fwQ3UG?=
 =?us-ascii?Q?h+ePw2IR0VA2i0Vv9v+uy2O1Ybsl+LLtnAttiqOO9Nc4DVPBkSTC1Ltu9MRh?=
 =?us-ascii?Q?lXU/ttQY50FAKQ3P46WpYae7i1/FeeefMHKxynUoQX6ELHHdfAQPmEKOkzuN?=
 =?us-ascii?Q?NqQxOGb/5zYD+V6SyjRfIm8XoyJcpj4KDrCFDcWUicB8qD9QPzojSJSYqh3R?=
 =?us-ascii?Q?lociDKr+r7/vacf+707WzpC27pbr4iwY3A0PlgvzsKHQ8d5PX1ZVENvtxDk6?=
 =?us-ascii?Q?isUNHKrvMUpv2L5XiKYe9kL7/6WkLVh7VVDtmKdYGSA3+zyy2kwV/sMXzPzy?=
 =?us-ascii?Q?tibx3rpoMDcwm4oLVrJN7wMVECawPWfFAbx2djO+A4Jge0P+IiNV/vXMcmcA?=
 =?us-ascii?Q?ulRLYJZUJ3u9PwzCslgXe+i6GgJnVwNjsxkJjDNCtKkiKL+dM6vimum2tRx6?=
 =?us-ascii?Q?/hYYMWhHa3KPhiodCS6skTVyedmqrFL8tU5V3AIRQ92JOX2zVT8OlPdma2r3?=
 =?us-ascii?Q?xAqAZcTEZtceA9/c9Khhn8hczV1J1oelurm8xVKvFOYKHRLeyKwxjhASJ9cV?=
 =?us-ascii?Q?KjlQAQ8KiZCMbcmVKzcpUOPMwsLD4nUkM7fvQvtG5KIJWCBDr89nWHejiYjq?=
 =?us-ascii?Q?Nk/4daXvebL1y2nRU/ZTOQnk73pIlMB0yzS3pIOgyQk2vP7wwVvbMPhX/yEh?=
 =?us-ascii?Q?D7qy9z9tI67yUBAqUJcZRijFSQxFFn5FbXfOxdZZ+1U4OapTYIxK9ojcvhfj?=
 =?us-ascii?Q?3T5+NVQ7+6RoMrG3lUxUoOkDvs/LPKq5Iu2Ph6+DpaHJIrFpN+935YaJdRNp?=
 =?us-ascii?Q?MNpeCVaM/KD3dch6wmvdMkHfbYVXtcd/UTwuAsmMQULVMQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7QNVukvrtNCIGdfzjmKjp/ByzzNzCVD9m9+XjtQhzOlcZkfCg2JEBecunMzh?=
 =?us-ascii?Q?2Wq8hQ8aJXyDjuaiqqICDW8sx4qi+UeloLWU3dZSrg8zPEw5cggIVkgQtlbo?=
 =?us-ascii?Q?bB9BT7ioBc4Psnb96UFx5uba7NZZ1PUEwcW3ftoMf34DwYlSRNhfJycbQJsV?=
 =?us-ascii?Q?AySmLqh2JC5KEk+1+LQ8aWnmd8nU5MgsMuFfbnQ2IbeCCoJ2T9QGIUAFHbLW?=
 =?us-ascii?Q?qVvUBDT00DdPBuJtruMEK+h2uZJ7hvzUG+wDq0Jejf2gqePWwspq15wrDgrY?=
 =?us-ascii?Q?LaPM0Mw1o0cYsHWx0UCgO4vRdyhwckuytT+62QvywHv+nX7XF5mYmgDZ4Hnv?=
 =?us-ascii?Q?/KhOfDwAhGIFAG3rPeQfc/duE2rCciAkB514Ja39On1boqwgckFnTV3IHh9s?=
 =?us-ascii?Q?RV0NiBkaMu3xy2PXRMyGkVd7ejEurDwILRS3j3p/wRFgDLBfUJGIRGE043TF?=
 =?us-ascii?Q?IHOexsehyganHteavLfji/uxpugVUJMfunnjUzXanItX7dJdEVmpYFt/z20c?=
 =?us-ascii?Q?UJ6tKmkyLmuF950fk5mTaneUyj8TR4bQifc5pw8Xy6Pfhrlvl5XsTwxZbgWs?=
 =?us-ascii?Q?ILW28XogvJPOPCM0W5O81ibcuqGWkSmn6aP9ebECcpfeWdODTyx3SoSGGg0x?=
 =?us-ascii?Q?T+DzH6B7+N7gKBQmiz23eiv/00rr3ax8kQsaC00mgEbQdExHMMqxj3tJ1XlD?=
 =?us-ascii?Q?qVxjDxa4zHpkYs89vS0fQQvBfhyOqL3vlqbhDxSewwT5ub89KiaVnQLfPWo6?=
 =?us-ascii?Q?e2/W+uuwC4HUj3LM3RNe2HIsjsGMwaXokh1aqNIn3HWyF72qo9ewMMtM/bnc?=
 =?us-ascii?Q?GLjzG0P3/1bLbIqLBiUvQNoAxKZOH4pbeShdOdjpr9RX9caN0I6wjxSywJiy?=
 =?us-ascii?Q?4jX/dZZoGR5T9QuSp8JLpt+MnftH6QZ0mfbBWQyW1N5379ti+uyy8a065Vv7?=
 =?us-ascii?Q?Knt6TkNfqUvVWVR0f9fkIiaikRgVQdjSI1efsXy8zBpmkKREEoXx/T1rXfmg?=
 =?us-ascii?Q?bJ0PhIuhIWAnYEsg34G2GofVjEOGgc4LmC4Ndg9ujHW8aTnpJyDoSolS/ndJ?=
 =?us-ascii?Q?R0pMWUe9/9BpJTHoYlutU3pFUJKki9hmNq3dx52ZNv/RlQ/wKWVYmqgQVE5h?=
 =?us-ascii?Q?wf2ayh8Q2nFtvzPNqJfTMGI88fZUC2MzWQgq0FxO7Duh4ZMpR7U2AAc+UJTJ?=
 =?us-ascii?Q?qOPdaAQth3Sg+VhwzuCZW4RsmNKQZq05y820IY4BBjknFSK/p/eQkmLwtpuz?=
 =?us-ascii?Q?+7dRzSB2mtZ4bb8Y6wDr6mpSaoHwLHY7ymuxGMyZzlmugVAxcP5MfGMhrSOE?=
 =?us-ascii?Q?ZQ7fAMadzFycPikjPMURvDZyCtVaiceUNW4d389KWVB9WBLJXjaDlulWX7/D?=
 =?us-ascii?Q?tu6u2tIQ0CUmE2ca7DyecGaCFs7/0zfYS0b8A3WBYXA1ZXaHNCQ4PTV/EbpD?=
 =?us-ascii?Q?QorQj4RMrxXVdn1Mc4gdFQwDtVCMshodBy1nAc5pMNSi7t9imLsA5edjRisJ?=
 =?us-ascii?Q?zChQaLuWlMcGaKnvo61SF/w+gapoiTa7jJzkr1O8KFcCag3qkdi6J5+hB9eF?=
 =?us-ascii?Q?Mz768SMeQMJ96JcLrQ29LgLU9lyjlhVEn/V4TzfdsyBzgqgiQLoODbfMTAV6?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 921787cf-adb0-4ed2-e6b8-08dd35eccb6d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 05:15:29.8953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncvN0YmFjI7PFaxYuW+S55o6e5HDD/Tsa30+mAbsQBFn6XeQIIiAgaHJ/0gAFjbQfvcQLyC/bFxTiEEzT66YXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
X-OriginatorOrg: intel.com


hi, Breno Leitao,

FYI. we noticed this commit is in linux-next/master. now we noticed some
xfstests tests failed randomly while pass on parent.

xfstests.generic.417 seems have higher rate to fail.
we also noticed a "Corruption of in-memory data" while running this case.

f916e44487f56df4 e1d3422c95f003eba241c176adf
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     kmsg.XFS(sda4):Corruption_of_in-memory_data(#)detected_at_xfs_fs_reserve_ag_blocks[xfs](fs/xfs/xfs_fsops.c:#).Shutting_down_filesystem
           :6           67%           4:6     xfstests.generic.044.fail
           :6           50%           3:6     xfstests.generic.046.fail
           :6           33%           2:6     xfstests.generic.049.fail
           :6          100%           6:6     xfstests.generic.417.fail
           :6           17%           1:6     xfstests.generic.530.fail


if you want us to test some patch to fix/debug, please let us know. thanks!


Hello,

kernel test robot noticed "xfstests.generic.417.fail" on:

commit: e1d3422c95f003eba241c176adfe593c33e8a8f6 ("rhashtable: Fix potential deadlock by moving schedule_work outside lock")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master e7bb221a638962d487231ac45a6699fb9bb8f9fa]

in testcase: xfstests
version: xfstests-x86_64-8467552f-1_20241215
with following parameters:

	disk: 4HDD
	fs: xfs
	test: generic-scratch-shutdown-metadata-journaling



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501161047.39c960cb-lkp@intel.com

2025-01-06 13:32:03 export TEST_DIR=/fs/sda1
2025-01-06 13:32:03 export TEST_DEV=/dev/sda1
2025-01-06 13:32:03 export FSTYP=xfs
2025-01-06 13:32:03 export SCRATCH_MNT=/fs/scratch
2025-01-06 13:32:03 mkdir /fs/scratch -p
2025-01-06 13:32:03 export SCRATCH_DEV=/dev/sda4
2025-01-06 13:32:03 export SCRATCH_LOGDEV=/dev/sda2
2025-01-06 13:32:03 sed "s:^:generic/:" //lkp/benchmarks/xfstests/tests/generic-scratch-shutdown-metadata-journaling
2025-01-06 13:32:03 ./check generic/042 generic/043 generic/044 generic/045 generic/046 generic/047 generic/048 generic/049 generic/051 generic/052 generic/054 generic/055 generic/388 generic/392 generic/417 generic/468 generic/505 generic/506 generic/507 generic/508 generic/530
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 lkp-skl-d03 6.13.0-rc2-00035-ge1d3422c95f0 #1 SMP PREEMPT_DYNAMIC Fri Jan  3 20:52:01 CST 2025
MKFS_OPTIONS  -- -f /dev/sda4
MOUNT_OPTIONS -- /dev/sda4 /fs/scratch

generic/042        19s
generic/043        25s
generic/044       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/044.out.bad)
    --- tests/generic/044.out	2024-12-15 06:14:52.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/044.out.bad	2025-01-06 13:33:27.348535522 +0000
    @@ -1 +1,5 @@
     QA output created by 044
    +mount: /fs/scratch: mount(2) system call failed: Argument list too long.
    +       dmesg(1) may have more information after failed mount system call.
    +mount /dev/sda4 /fs/scratch failed
    +(see /lkp/benchmarks/xfstests/results//generic/044.full for details)
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/044.out /lkp/benchmarks/xfstests/results//generic/044.out.bad'  to see the entire diff)
generic/045        68s
generic/046        55s
generic/047        72s
generic/048        100s
generic/049       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/049.out.bad)
    --- tests/generic/049.out	2024-12-15 06:14:52.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/049.out.bad	2025-01-06 13:38:37.515464142 +0000
    @@ -1 +1,5 @@
     QA output created by 049
    +mount: /fs/scratch: mount(2) system call failed: Argument list too long.
    +       dmesg(1) may have more information after failed mount system call.
    +mount /dev/sda4 /fs/scratch failed
    +(see /lkp/benchmarks/xfstests/results//generic/049.full for details)
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/049.out /lkp/benchmarks/xfstests/results//generic/049.out.bad'  to see the entire diff)
generic/051        80s
generic/052        4s
generic/054        67s
generic/055        47s
generic/388        85s
generic/392        10s
generic/417       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/417.out.bad)
    --- tests/generic/417.out	2024-12-15 06:14:52.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/417.out.bad	2025-01-06 13:43:36.466161468 +0000
    @@ -2,12 +2,7 @@
     mount dirty orphans rw, then unmount
     open and unlink 200 files with EAs
     godown
    -check fs consistency
    -mount dirty orphans ro, then unmount
    -open and unlink 200 files with EAs
    -godown
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/417.out /lkp/benchmarks/xfstests/results//generic/417.out.bad'  to see the entire diff)
generic/468        8s
generic/505        5s
generic/506        5s
generic/507        10s
generic/508        6s
generic/530       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/530.out.bad)
    --- tests/generic/530.out	2024-12-15 06:14:52.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/530.out.bad	2025-01-06 13:44:32.483499358 +0000
    @@ -1,2 +1,6 @@
     QA output created by 530
     silence is golden
    +mount: /fs/scratch: mount(2) system call failed: Argument list too long.
    +       dmesg(1) may have more information after failed mount system call.
    +mount /dev/sda4 /fs/scratch failed
    +(see /lkp/benchmarks/xfstests/results//generic/530.full for details)
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/530.out /lkp/benchmarks/xfstests/results//generic/530.out.bad'  to see the entire diff)
Ran: generic/042 generic/043 generic/044 generic/045 generic/046 generic/047 generic/048 generic/049 generic/051 generic/052 generic/054 generic/055 generic/388 generic/392 generic/417 generic/468 generic/505 generic/506 generic/507 generic/508 generic/530
Failures: generic/044 generic/049 generic/417 generic/530
Failed 4 of 21 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250116/202501161047.39c960cb-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


