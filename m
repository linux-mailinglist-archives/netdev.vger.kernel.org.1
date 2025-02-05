Return-Path: <netdev+bounces-163269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44684A29BE7
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 22:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940D63A7134
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CFF215040;
	Wed,  5 Feb 2025 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWs2anHg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFDF23CE;
	Wed,  5 Feb 2025 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791258; cv=fail; b=cQLgNYQy+EPgK10cw+GU+JVUvGi4kj21PgQDK/W9M3vmWmUNcKRn1GbNWH1Hyppf6hlc+ruX46Q/BpgPfwkbHBLNixAolbVFRb8dlmUIDCPOw9CE0eTcxvGZoxovE3eJtKUvoDQbSUD7ZJulht+Iy2CPbFb82KKWXXO0F1c9pkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791258; c=relaxed/simple;
	bh=uAvztsHE0FJf3dKVqJGxEeRWDBk74OhALcAkoXoYje8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HaCZ5E/hRL6tytOJLn5veHzdDqY2eMN6X93X3U3ZwBahzubRbjczWrt2sDE1RsAgy7lrtsJBJ4TcuOC5q8CfjrfRrX15YrP9mMC8EkD99zlKJhD8LJBQVnZMePkNkgmFIwTm9TJ9tweKCUEiElGNQjptqgEyQ+zbcb3gMPZfkjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWs2anHg; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738791257; x=1770327257;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uAvztsHE0FJf3dKVqJGxEeRWDBk74OhALcAkoXoYje8=;
  b=CWs2anHgo/sf1ySZc34R4hx2Pi9XVOTQMh3sa0iB0tMCGsl0rIhCagBY
   lt6iZSbEEdyTG5aWt1HXeo2sJmurjNXexnZoJ1IjjzlQk8DHXdn6ZNFBf
   O58LDV4+RwdIRtMBwNNceq8+o0D/lZ1+qX+toJJI8U1ST1J4GURNTSJ+e
   VwziVzgNLy7IWUmK3SgtenbjLkpmz0oFI+1T8lJpA7AE+jnokTTH6VPpk
   SYHeXj1rcLgWkbzZwBzpwaLvF8FP/cXuBxg6hsgv4lcajQc+QIMJt1Qxa
   4rMb4Smm077Ow/+hf0kP7t7orLf5yViAjzUjCdDEY2rnlGYLMPTXncx0M
   Q==;
X-CSE-ConnectionGUID: WqnkHtdBTv6xmp0vYEV3rw==
X-CSE-MsgGUID: wHFTseomSqi0KWEIfsIB0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56795665"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="56795665"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 13:34:07 -0800
X-CSE-ConnectionGUID: +cWs2zUqTDiPHgfhvI+VuQ==
X-CSE-MsgGUID: DXmFLTQgTl2b73QIwf3UOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="110862415"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 13:34:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 13:34:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 13:34:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 13:33:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQDyBz6R3xwZI9dt3aJErbSNDD+Sn3s3zyfP/3MvNhM18WOrAZwvNKHsI6TztS2/UwA0UPeCf8xRac/UjhEpLkDNbsXFnv66bAQuCIdYFo8lqJdr848LdnjDQ4aYkE23ddRLA2Wf6azJcbLjvGpu7/EP9tEYCzSBXPrzSkg61DHFHXbpPOkkQ5kzC3kYzCzrNp5gkMsRwPrFfc5YarLTvbBsWQP3Sk8eAhRnwfRLU+J3vJPyeNZMUbuxWq27SAdmF2DEJIip/Gx0WykDsG8hKB8KLI2bluPmsThu1hIQmoLyNtGy3SNmUjG0kBNwo5MFHhEgxhpkyDr8rkxWkklXlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVtrK0Vo/6y+B4BD+QuYMrgDbISFXJk3G2TmxEI02jc=;
 b=pgbdck+qOyonYlItz/M26WgqBZ/FzKyJdT0d3WTN9p9w9Oek/tRczCm1awrvAiwlo/PM3p6z49f+YqZNKT3czQ/Y59JxuvrAd54ZKY8L2lu4+8/eJNnOyqeU4kaW2kb9x4rQnsF8nYwmamhQuy2s5Oskjhi3KvzWTLsHJ6fkkGLbSAPITVz5Y6w4i2AvTJi4wTN1fZWNnTQn/uj+3HLDjV6MjE/N88ukVdqBAvvVEI3ZRmGvR7F2erVPB/nHSpSjolCfMaPhBdPgc1ZRP15FUvipZPO/AoFVs2+X1BLcFEuerHdA0qHD4qxyCWIq7JBxxTFqMEcjIVZHuF74BrSD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Wed, 5 Feb
 2025 21:33:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8398.020; Wed, 5 Feb 2025
 21:33:41 +0000
Date: Wed, 5 Feb 2025 15:33:37 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <alucerop@amd.com>, <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v10 03/26] cxl: move pci generic code
Message-ID: <67a3d931816f_2ee27529462@iweiny-mobl.notmuch>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-4-alucerop@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-4-alucerop@amd.com>
X-ClientProxiedBy: MW4PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:303:b8::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a471d1d-7fd0-4653-eca3-08dd462cc2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5YcbGnQ93mEIUnXPnkmKbftq3pzIFaWz9JBNwBaIMSRinVCkD/oIhA2bDAg6?=
 =?us-ascii?Q?4wgUpL3qifEEgJoLvB8Zqxu4xRVwdp8paRVhwevTpBUMUxSg5+I0GsPePnpD?=
 =?us-ascii?Q?+gsbysXr00vAgdFFd1gUVEYLDXpSt2gJbYOc3A+dW3KBcU4x6aJK0z8fUjQQ?=
 =?us-ascii?Q?0N6jkFy7q3SBJOyLg4eost0HF8fOXufn1jYngc/MvAMb0IA04BlrEt4ad5VI?=
 =?us-ascii?Q?pJvBVWDRUa9O+4CuYxpWpifr7B25QNcUFRAsgW7lOgqej0C7Oc1K5/Dr2UGb?=
 =?us-ascii?Q?wj2sWr+AqfEYveqBlt6xRbWe8LXRFp+/SGmOfBmTOdDb6xijEwqAzGFWDMnU?=
 =?us-ascii?Q?eEnKdvOkkOIHGgRQjwEKjzmd+Z36n0ZQu43endDvF+9aVQfjovxo7ctdXzbe?=
 =?us-ascii?Q?x01niRkBSWBalRvIzE0BpK6se5CPnbdB1iD6FKk0+A3xKsYHyL/iqiaZ2KQR?=
 =?us-ascii?Q?ANZ3fbYQ4zNNrwI1fzcOJyzKUXmyeQgU4r9UlQ2EErCVy3AhLWR7lhWYW6xa?=
 =?us-ascii?Q?/MtSTkAu7cZOUxB8poign7ZhlAqO/JMfHS+85iDxXQlHZz0w8CEtdP37NyDE?=
 =?us-ascii?Q?v9Bzj3tZZ2jc8sKcQRIRvnt4SC3tMUdXxA3bsjpzwcg2KD3qOn1eqP2qs16s?=
 =?us-ascii?Q?5rT6+29h+AFEclnxckXQnwdPRRX366RawLuli8pryoh2ycrSpjJZbzkiKdqo?=
 =?us-ascii?Q?U0R9I2MiTtXqFrxAlO/7cRhlPCdRkO4j81U4Xit+Egr/LN+2CBvy4uXk2QbU?=
 =?us-ascii?Q?v4vJH1XLvfs3SIeeelycl7P+jdiRyWK0fraqiYdrXmUCT8eibicSqMUk3s1g?=
 =?us-ascii?Q?3kid0cOKr8RO1PSI0ogQeCsiO8itytTLAbn6hB6Zx4rJ+XlvDLJQJ0+bR2OB?=
 =?us-ascii?Q?O8hhs/fqEBw+pQNke8NsubBEeSnY2kK6Y/B4iXA3lw371/e1CNdWgOpgY/KE?=
 =?us-ascii?Q?1M3TqpXYMD94mJ36QMmsqLPb7zbjnpMTGoOoGw0wADxWDiPeb9ESoxlRRyRc?=
 =?us-ascii?Q?uteG4CU5vXmC+bhbREZePRGKhGmkm5Vwbsxs1JQHmbqCcoqEKuUDxY427oG9?=
 =?us-ascii?Q?VCcDRj9hxVlMNpS+2rPpXCdWmQJ40QHOIzmo7dURX+ppXeoTYJD7iFVOV29U?=
 =?us-ascii?Q?w21Zt3wDnvkIuEkz1tlI+0ry4fLEyQOJn1IiUmBcRB7lleIr3QHlrU4g3TjR?=
 =?us-ascii?Q?MZ4p8QxIiuG5ebyeF5ACirTZKWN/rPh2hHBC9dNujjqve5b+FV9JHeUgC9lw?=
 =?us-ascii?Q?rnLCHGVrqNZQwiBQAD2bde+pPZy74xq9Ewb53+NhEDXMjO8AmYaZKSloWBMk?=
 =?us-ascii?Q?TgDriGN+zviUkkc6bqFhckfDT3drMgJtUuVcFDmykDsnrYjwD45xJCciU9rY?=
 =?us-ascii?Q?/LPUHMjrSmxyrp5BmXmbYsdrWBcMMOmgRoPVAQKarVs/FVIMpi0q0WZDQG2v?=
 =?us-ascii?Q?RTmyd83WUeQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3EbHbn9nfosztyLj44fF3JmjgsLJckQQ4s8hOCg6kewp9XAR9EbGLRCjjZRo?=
 =?us-ascii?Q?Y/MjlByBVuCSbZLswuLYdIsDbR0SxsSHPt2Y9F4k7rfKSlRFCwGT9VUcbSF3?=
 =?us-ascii?Q?ukBUmiB18ZsE87rngrFn1YiXzsxYeuvvSSqr4q9sw9LmQDo0gfpUglf/JrWV?=
 =?us-ascii?Q?vZF7OrspoSNvOpiG682xtTg+7kZRurMvTVajU0Z1P6n6hwAlT9jXEv97BqRS?=
 =?us-ascii?Q?ERpGkJZmVkjmirJmGeJfwJX0xHcOowsxoMFTPCepgjIyRmaRq6HQ5mYTUV19?=
 =?us-ascii?Q?Vb4Xo1P33wNqwELvnamlfNg0ntCCPsDFGNp/NUVpKQG5AM3luJbz0/mdn/Bn?=
 =?us-ascii?Q?MLonGxPJr4HH0Kz8IkHpwVCyyKLt/8rZOlOazNmroP32J40RXqdcAYPNk41U?=
 =?us-ascii?Q?k4XqyoHC+QEWLIYfJpbycpiMpXUpJOieu2cEaOp3UvvtddXG8wTN/5wubivr?=
 =?us-ascii?Q?efk54VINQx0HcMzkVoewJ+3OkLOaendQ1S8e4evb7muZH3F/IhWnWJVnSvVt?=
 =?us-ascii?Q?K81HwDpsurIvchahLEjCrZ/INB5wRJ7hgqNfNtNGLdW0mfJZVlx7xWmtEzpu?=
 =?us-ascii?Q?3PKGWIk9LV5LWKcKqLgPnnkz4X5hh2JjE0B3rv/KST2T+Crr6tCdHLsqvKFg?=
 =?us-ascii?Q?ybMypEm2cQ8PUWcJxYjsnBUmGOxY4mP3UT6/ofI4/gOBaI1U5y8/fTZBcYXu?=
 =?us-ascii?Q?6szc+l2wm+flVkgBnDlQNelBKOeTSCu4h0erQZaQssO83c+ss/4tkx+nwQJc?=
 =?us-ascii?Q?tetT2QhyvzjwAbu6R7d0ZJ0RilhzN4P7uuvvaj3Zf06iPtCwIQqBUhT9C4Ge?=
 =?us-ascii?Q?cav3QbcxLTlHNbXc8veDQ44BLltuX/7wExv+Uh6buI2m61Irl0RsgdgLEdYY?=
 =?us-ascii?Q?xVJLsOMBEacYogfA6ip6UMXXsMEcm51ab6xlrO4OwcB/CESpFLT5+StrIHxz?=
 =?us-ascii?Q?PdnBd8PpIbnrPJTe02WvnyVPaq0DM9H7RWKQ9iTtsA8hCJjb0WZCiB6iQcA+?=
 =?us-ascii?Q?qDGYAqABXmypMtXfD0lpfsnQz1NziQ6Zr6+aLDaomZnpDEXd5TG55pLBGfLT?=
 =?us-ascii?Q?/PyZoHmvQn5WqN3RSnsNAbeVR7IJg/C33oGG6HnEziriu/w/3gzcn7MHFMKb?=
 =?us-ascii?Q?Homm1oBeVL5lqUZvZWqZy0i95NDRTo49fy6EwLgfH0DvaSXYpoetZr2PZ5Iz?=
 =?us-ascii?Q?261VjaOmWDGnLME0kqOfp2R6VJBmkymqPDSSqFcc5q2FRyKhoqK7KOVvCfxc?=
 =?us-ascii?Q?IgpoQuYuAvBvtpCu3DJmJiM53/b7jFJtWQwX2A5WODzExREiBp8Zt5mN6/g6?=
 =?us-ascii?Q?v2XuCs/svV1aEHEdbup4jBOelDmFXCe+yr+osYowzyVm0TNfO7coyZxeHfCR?=
 =?us-ascii?Q?rdHi3o+y13tfsUBR6W4NAY/gMyh0yil0Eunt/Xer4cA/rx47OWFeh26lZPpv?=
 =?us-ascii?Q?KchAy81NZ6IG9I6vJaoYDOFsVRlzNJB7aO8AH3zsoI/oP3Q5vj7aWIhF9/t/?=
 =?us-ascii?Q?3xIOkqHqx8w78Qv9Y9Vvx0xHiwUjjp+5ta5A8fxEPNtcMS9gPfZijCxk8Dcm?=
 =?us-ascii?Q?ALnzh5hsgeSfgErqf/dzUvvd2Dr8oSXADHRc7y96?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a471d1d-7fd0-4653-eca3-08dd462cc2b4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:33:41.6921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEqBPKJ6oe7HR8VR2pVUot0r91dS0bxqpZuUgkiToaV9lZZJe8WwEiCAfkKQmBma7Qwc0R50rKJLVGhUHy4Rmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5145
X-OriginatorOrg: intel.com

alucerop@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>

[snip]

> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> index ad63560caa2c..e6178aa341b2 100644
> --- a/include/cxl/pci.h
> +++ b/include/cxl/pci.h
> @@ -1,8 +1,21 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  
> -#ifndef __CXL_ACCEL_PCI_H
> -#define __CXL_ACCEL_PCI_H
> +#ifndef __LINUX_CXL_PCI_H
> +#define __LINUX_CXL_PCI_H

Nit: I'd just use __LINUX_CXL_PCI_H in the previous patch.

Ira

[snip]

