Return-Path: <netdev+bounces-152658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534869F5132
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064AE188B49A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7913C1465BE;
	Tue, 17 Dec 2024 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NG4k601h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DACA142E77;
	Tue, 17 Dec 2024 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453487; cv=fail; b=HocKA88Do4r9Y48M44T5184YOXD95okI61o8VGYND2OfSZZF7thW2PM5MlszlArLIjzfQlNxKUjbS0nCjva2JVcP3z0NtR2Y07uYoAsVreLkvOfYVEAuqoT2FoiJkSwb5qS3VnFFUuHPrKUBRMwgSqFoHWx/RdTdsSP0X4nWU2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453487; c=relaxed/simple;
	bh=w0640pfs+Y7tcSWjx67+CdAHf0RTDaq3XPflmYiKSWY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HmCBkt8Gq3yuVRLRtD/vwzRvklzrmg2SwL/PfFuVz61SqRLmg3DGPKUT4Xd+qiQW8CeZZVsgfGoJBnRsH0eHDP/f2qCwbxsItdtUUc5l6joTvDc57Pwa6J/iLSlpkHunJDtecXx8FrkJnSv2QlltX6rkVFQ+VEBxUbfq+K5PJzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NG4k601h; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734453486; x=1765989486;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w0640pfs+Y7tcSWjx67+CdAHf0RTDaq3XPflmYiKSWY=;
  b=NG4k601hCrJxLAw1P0LJxGXfLK8xVstlDyKKyLspfMNufebCV2BelikL
   jf1fYJtVabAtgxKiLVIW7MPSQZoIoZl7hvngkUsGPvcM3pd4B57Sl5fKv
   yPOttfWGxkEEC85jQL1Zm6YiJc0OdIbhJUg7HdPjlJ6EnY1Wtw3RAMrux
   KmoV3A9B7zEDJBPkNYtfxeXfnXNQ2cV/3rBLGOf4A0g1cje1UluYMl9aH
   H406n/aEWrpG59sgq7chc/95M31UiD2bcOgog4O1sGe4xKTmMf+P3hJkC
   c/+3j0BKiayQ2hpFTUD2Y9k3GJLk46ttMmuPx+L27YEd89iHSVFyJsg7u
   w==;
X-CSE-ConnectionGUID: bDdtVClpSTevos2YduF4KA==
X-CSE-MsgGUID: diOFt5T/RCOZrNcwKy8/7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45895564"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45895564"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 08:38:05 -0800
X-CSE-ConnectionGUID: s/cXtnaJR0unQWEq56TOEA==
X-CSE-MsgGUID: qUQdstnOTzq3d7iib3ib+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="98165966"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 08:38:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 08:38:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 08:38:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 08:38:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgfTamGZCThRcInIenS1mXhZjdPrkj4UcJhkxvHeWPJB/IbhVdY+vgfKKFHpnThgGtcsna5eTO5QqvuSRhm//SgoGjMjHvR0T2V8l9+dpOda5xelSrIW88DbCvN1lP8uVv2OhfF0/A61GNZRTxo1MUvTCTqZUbP2YKDKBKeJIqVZ9gnvjUA/pMfBj1o/6IX0b1d9aZwqzS9njJ5CznuU9YABerFuQIOoak703yBn00hXbiJZ4Xk1MxKVTuD6H9aRRQEYvHODY7bwzRlcwjYIjOp98mpoef0478DtlgpZrgKYuE92dz7ripfOq6aBxqG2j9Y8wiXt8OpyauImDBawOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2GFCECK3sZTLURt9KFC3JU+TP4Wfh3xssGhE1adxZY=;
 b=a1v8OKuiqp0dThtleMT644W2UQ6uVuhrJAJ5fYFdKvmuMU+UMl5sRcSEibDiM1vwgf7zA5gHuhC0GiIK3a3XQsKTc6d85GZVtXHhXmiBPH6E/DscIEYYa/tHACpl4YT6mpvKgv6/DLRQ0uvY9yVmCfcgB/o5iikg0SmlQ6kpmy9mjJVZOEJWxYPjeFnoQHXTOLjWjUu0eLTCcTClgsjHbjF6ZveNRDxWcVqyYtygk2e17vQpLlfPNQVbB55Exx7ZUVk6/puxe/q071izxZ2s9IIsLry5gzPcu1faxdUTembxKPF3T7uSlnYgRBHRh1Sey478AnkPDDgaObKnf1ukyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA3PR11MB7625.namprd11.prod.outlook.com (2603:10b6:806:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Tue, 17 Dec
 2024 16:37:30 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 16:37:30 +0000
Date: Tue, 17 Dec 2024 17:37:20 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Shinas Rasheed <srasheed@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>, Vimlesh Kumar
	<vimleshk@marvell.com>, "thaller@redhat.com" <thaller@redhat.com>,
	"wizhao@redhat.com" <wizhao@redhat.com>, "kheib@redhat.com"
	<kheib@redhat.com>, "konguyen@redhat.com" <konguyen@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "einstein.xue@synaxg.com"
	<einstein.xue@synaxg.com>, Veerasenareddy Burru <vburru@marvell.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Satananda Burla <sburla@marvell.com>, Abhijit Ayarekar
	<aayarekar@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2 2/4] octeon_ep: remove firmware
 stats fetch in ndo_get_stats64
Message-ID: <Z2GowEuPU0nILAoW@lzaremba-mobl.ger.corp.intel.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-3-srasheed@marvell.com>
 <Z2A7+7dzyNDAgsmj@lzaremba-mobl.ger.corp.intel.com>
 <BY3PR18MB4721878201E1B93AFB29367EC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BY3PR18MB4721878201E1B93AFB29367EC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
X-ClientProxiedBy: VI1PR0102CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::46) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA3PR11MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: c02d229d-fe25-4fee-b6b3-08dd1eb9194b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QcZ9drmJtWzt7ZsWVXP1YHoXWntkUUtkA7A5RQa5iSJXzWbhdJme5cE1QWp0?=
 =?us-ascii?Q?8Iov2Gn9ulzDKGf0QUhcWQnXocU5uJEoYsPo9qYe6hIEND+3WHTV/GUM/Y03?=
 =?us-ascii?Q?UqLCCUpr/HBbZN82Grw1FRY78RHqfcoCA4b9Bng7nEwOZkTMNf042g+J00vY?=
 =?us-ascii?Q?4nyU1crgPALG59rJqx/4erQZrP6Wve7GLmuqjvdTHCohc9UvVIAF2RkdmASo?=
 =?us-ascii?Q?BTm1zb5PC9/qTUck0oEWBYN0QzGm+ow+ATbCJXpsLCHObTev4MZmvRicl6S4?=
 =?us-ascii?Q?0lhPy+9wSBOeu3gAypGl3Jebldcs0V53BW1JKN8gpCIAEkpNMeLsoupEj+f9?=
 =?us-ascii?Q?+suYPuC5F3bCDKvIABxIhwc0sq1UlSS4lZ/4qsC08jWRrBnv9vP54aR+hXMF?=
 =?us-ascii?Q?S/8PMUKfou2KU3hzStZypQxY3H+iI6qlYy451VXubQ3kvpOfOvv+KDklnC4F?=
 =?us-ascii?Q?AY0+49JOOyYUIPSem1H0DfwHNVCLsVmNELufNfxUJ3iY1vtd6iSClnMq+rKW?=
 =?us-ascii?Q?3Xmdbq+If7RozWTv7TsW5PE1W9bXnwSb6XWQMc0mrSsYi5BZ3WbMBQOSdC07?=
 =?us-ascii?Q?EL86Ahwf/p7Qb2jdinDuBOBmqaQaJkjWCwVXXM502Pd1OdOLvpjOkQ3t9l6z?=
 =?us-ascii?Q?LwapVbKoh8D05rW2mQMRrQ4a2JGQ/D9QmdJ9YM09zQtewS1TQqUqp9nUzNAL?=
 =?us-ascii?Q?lPGE0TRmxHrMSSDsAX5dRNfxCsDDiAMlVVPEmclKkNJ25UNx1FEK/rUr8Bpr?=
 =?us-ascii?Q?WO2JnYH9dbCO9BP2vClW0KktmLr33HbEUCKQ/GXAp+TqgWrcbTCOhRQR+HH8?=
 =?us-ascii?Q?5pHQB57kMW8BnXamab9PEP+nSW+tbRyW8u98g40kMfKeka3aNY7L1eSUpgvk?=
 =?us-ascii?Q?3sqsamY92NXDBSe58Tjkj8pC6U4KBWRmQBX3OnXskJiOtvnDb67iNKXlO0Gg?=
 =?us-ascii?Q?UpV6RFhZMaCExintQwu7ydP9yHkNtPJPABHPSHDGs94K2RLYmK3gEfk4f3cd?=
 =?us-ascii?Q?mEraxL3nyVH4mHneh6OAT31qRjfEhysFDCv91Ee0ZnSr688cCru+cqHNP+b9?=
 =?us-ascii?Q?3ZLRgjNk2BW8NP8C+MlqDgbDq5qvXksZv4xQG3U9LwTrXl404DO6vIlTdEre?=
 =?us-ascii?Q?kewTMKJTzqKtNbZnH9dct4hMebx9R84cimmVt44e+Hg+HUbXAgrCrnt2Cghs?=
 =?us-ascii?Q?4KGWBQ31etwd33zbUOmPV7wEOAffNUKlGIJWqH8Sv59FsQlVjRnHswDdGlyG?=
 =?us-ascii?Q?vFAuNPuB1G/TaQ4gl7vWSYuh0MbpQJjCp/nvT9fnq3IY0NpZzhbq2hVY0eCT?=
 =?us-ascii?Q?i1DcSeuOrSKrReaJxP8hJIdVAe3fnMa6Od4RlJGjEQFNtCJzUZmQR+iNCK/X?=
 =?us-ascii?Q?ct6cGC29KecKvYDQc8X/GkxQAqYl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ab6/8TZ3kyBByl83bZk0KMo2E0IfxlNR+AmvPA6oY/t637QbWy3R2iO32jSR?=
 =?us-ascii?Q?v/MhQIzFihycpbpZNmLqeYuCOLUTz49mU7Q0zyAuPn0ObpGId8iRAGyFaCwD?=
 =?us-ascii?Q?pR/s7++aI5ukOnVR3G73xPgB2B5lf8EMAFFqDaa4OrQGrC73BEnp6e+fm3vS?=
 =?us-ascii?Q?oFWWuvrQw19f53c+nfpGie7C0gvAJX2zv6rFa6YzaZM/98VKPJmGMNL6m1NT?=
 =?us-ascii?Q?P1KfLvWJIecf0YMnMdJ3bpao6jiETzNU305f9Yg+WUfQEedl3E8UsPnIGihE?=
 =?us-ascii?Q?kTK1L+CkY7bEJ9QaYu3p0k9PoyTZ3wsNK7pXzkDo5ou5LX0+2Vp8ut1sntPN?=
 =?us-ascii?Q?fUkDLcfrn4vxmMTrRWXLkJ7Sg7gmHyTsFnEnADyFYQdHWhcayk7ydEaUdbvp?=
 =?us-ascii?Q?Q4ifDoLUMr8qq5pu5scsY2OfHGrXNBbPpmTMUkoVKOraSxbd16kD5qbGnur0?=
 =?us-ascii?Q?rUuv8DaxtsStuZbTQoGqmkp4FEqOp1ZkpojMSr4vDbE/jOuHfUAJsB6MGjV3?=
 =?us-ascii?Q?gQWWDCmSNHCBndqM4NMjYpe2u+jInGLGLyXt+Bys9bfEKoU/UvYX4T5/Dt9v?=
 =?us-ascii?Q?mPuNri9rvdCYf96xy+MoIbV9sf++wlybqfoAqaRRY++ULVsHeQyMLQE3lVqK?=
 =?us-ascii?Q?bVxrkC+CC/+TssBH5GX6kANQbUXtgkZwFpfiJO/wKKwa6AxDjtAuICYMP2dP?=
 =?us-ascii?Q?QSsmjYQ4E7ucE88KnLhlTYB7kqbu7amU4o25ORBAxvVlCx3flsRi/asyQl51?=
 =?us-ascii?Q?OVAhnfqhFvzKGNwVh9kDSrh8IwCXhwT1stDEJKPkw5dbb1kRndAFzFOZHoeq?=
 =?us-ascii?Q?WeSt3Z4RMkRLQxBUrOA12N3vHFDwN+R7wKKmHS4zeR9frI5eNTgta7qWC/JI?=
 =?us-ascii?Q?kFAQFTp+E8xuPdPjpTGzBPLlekYDcYbPuiz9fAkSapWm61ydtmig627FXtkD?=
 =?us-ascii?Q?6aBcdn/bGwgvFKaA3vLW2+NoxbbmM9xy/XdPtCtEvkmN/HC4NAoL6OCd2UuD?=
 =?us-ascii?Q?hsrejW8DFoBdMjZX30sFQAS3MnQHLfcGedPDTTdbDuWP2qGepKpV53i55Qwz?=
 =?us-ascii?Q?XC8JHgkIQEiaUPi+ncUEL/yUP8lWirkL8VQZTfE4lhYcvuraumUD+T5hEwY1?=
 =?us-ascii?Q?1vjphBG7lcit/GaLNSRSP6yflEyBozTnt6657+ocV4/1qw8r9qdOGrK8eHIE?=
 =?us-ascii?Q?8Mz/6LHmLSPqWR8OFNTdx0oLpglC4DsxS0ws6ZaTZmz+Y68A3H0efjZ3BRai?=
 =?us-ascii?Q?k/9sWvFvPNOGXDIBUveh7X2GONGim9vSVJf6lSNFX7uRW5VLCcKXkqQ8zYQr?=
 =?us-ascii?Q?9tHFG1c1qHWh+d6XBXu/92Ja0Ogd0G2C0+5+zvko6Borv5VluxXmNQLVdkQ+?=
 =?us-ascii?Q?yYtgiDiAIBU65ViZ0yO4rKT/zh4GAZRCrXcLvtu8mU0atlmztbxsbfsWlq3G?=
 =?us-ascii?Q?cVTwMz/mQj+8G4smySmTe3fLtjtAGPN6oe8YgLwtPdfXVGuY+NlJQPmptqNp?=
 =?us-ascii?Q?r72i3HFEiwn5VCTPrWhAE27PYx/cipIru9h8QDX3sFqeIwHCNODRo5edIQx6?=
 =?us-ascii?Q?4dIjLvsGv1NRmYQFKaaaicw1vlFNYRF7SshVhtmwHcey5T29jf7sRjBaV0Cq?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c02d229d-fe25-4fee-b6b3-08dd1eb9194b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 16:37:30.0271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFi4PmafUCXCs7TlZ0UILIzrJyyYB+C4rJ5iIsrmihQEtj1+zy3pOftqK2/KMor7gqcxmEunW4kaGp3dkFkwzH55SEsj5fn1Zr496itFmrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7625
X-OriginatorOrg: intel.com

On Mon, Dec 16, 2024 at 06:31:05PM +0000, Shinas Rasheed wrote:
> Hi Larysa,
> 
> 
> > On Sun, Dec 15, 2024 at 11:58:40PM -0800, Shinas Rasheed wrote:
> > > The per queue stats are available already and are retrieved
> > > from register reads during ndo_get_stats64. The firmware stats
> > > fetch call that happens in ndo_get_stats64() is currently not
> > > required
> > >
> > > Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
> > > Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> > > @@ -1019,10 +1013,6 @@ static void octep_get_stats64(struct net_device
> > *netdev,
> > >  	stats->tx_bytes = tx_bytes;
> > >  	stats->rx_packets = rx_packets;
> > >  	stats->rx_bytes = rx_bytes;
> > > -	stats->multicast = oct->iface_rx_stats.mcast_pkts;
> > > -	stats->rx_errors = oct->iface_rx_stats.err_pkts;
> > > -	stats->collisions = oct->iface_tx_stats.xscol;
> > > -	stats->tx_fifo_errors = oct->iface_tx_stats.undflw;
> > 
> > I do not see, how it is a fix to remove some fields from stats. If this is a
> > cleanup, it should not go to the stable tree.
> > 
> > >  }
> > >
> 
> The fix part of this patch is to remove the call to firmware to retrieve stats, which could block and cause rcu read lock warnings.
> The fields that are retrieved by this stats call can be neglected for use cases concerning the DPU, and the necessary stats are already
> read from per queue hardware stats registers. Hence, why the code is removed.
>

Please, provide the warinings in question in the commit message, this is an 
important context for anyone that would need to look through code history. 

