Return-Path: <netdev+bounces-191705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B304ABCD4A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B9C16C5BD
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5B72566DF;
	Tue, 20 May 2025 02:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWj8Glke"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A98A1E492;
	Tue, 20 May 2025 02:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747708751; cv=fail; b=tpQXRLzf/eYqR2kKGUvyj5fume3wBSLla9w55JNoxQ0SCTNfvGnU15qBf+TURSyjr6UUR/c/9fLYhy5qTHAJ4bKT8YKClWpNY1HckhvPGAqpNQ1bFkBHaQKHeFQi1pwXezQxgyJLOMqLVd2fY0kJ2Ouf8GvLuJjQfSKO1PZXk2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747708751; c=relaxed/simple;
	bh=qqqs3/qSIsKik7M6GIsiU/XfsYmiGehSEXCgq5Adljg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ESieFRI+m/nuPexUBkGiU9VL0wtJ8dFrDmtnq/7SWWUkDniXh/PHEpS9dMUgZsYmz4WAqQ0Eaad+iYKDYQjZ/TvybC0hbK5rmUzmtkWKBjc2jtv60tU1BL7t5+qXpWu3czivX9kuiXsE6d5/+Ic7zkZdWc7D1hRqV21N/2b2rNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWj8Glke; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747708750; x=1779244750;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qqqs3/qSIsKik7M6GIsiU/XfsYmiGehSEXCgq5Adljg=;
  b=DWj8GlkeIY+P/lPTPcDRDlDnHuILRnSqNlaaiHNdXk+ZepyyKezxMKvs
   gVy3k2eGLRKoMZ6Ju7eKMuQxx+iq+vw5Ht0jilGvPJXC6abm/no50VjEw
   bkLJrF1xCxifGyfMJ6Urwk4JwcLKvjF6f5fvqGpnlxuzRg9ru0vEu0mGD
   H1SuKlZ0SfI2AFl/PzOk6oawLT6MKr/ItNwgt8dr62tsi/8Q+eAEALNgw
   HgO1Qaz2/MBxED+SHikw3yJWOvSYf/HcggtCuJdX5Jh34zjcQNFTyXi43
   7iCaFie8cy65SNu4m7viHLvfvkpwxVXgSJN8nD6mToEFckzrY6mPJcGGt
   A==;
X-CSE-ConnectionGUID: l4rlFovDTs+7c+f2N05dVA==
X-CSE-MsgGUID: apkQxMWzSE+MQ/maSUol9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49609092"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49609092"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:39:09 -0700
X-CSE-ConnectionGUID: UkfvymVSQgqyAHvlUQJjtA==
X-CSE-MsgGUID: /y0ZKZICSJKQfqOGQpxFsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144668761"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:39:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 19:39:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 19:39:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 19:39:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APAjQqosdEfGPoVfbrhGcALDjggvlHI2ETyrIQ8vRk/H05Gl+6WTxfZyF+M/1hqSpZTeOqSKj+o/Ao3m8fH68jOnPJkmqSv38ABTrfIQM4QWonoZ1WOswJfSXj70ySklX3FSlnW2r0McEi4iqxSsi2V3xXF3XmbrON9g0YwO2ZX0VRMv9MjqFBQsXeVspkpuMKZnujx6kCHNXX2UrWUGlIFnMp0ucEdFWsshpQ8mh+c+l3GKkhwNQ9XhitiUPrdkDMSKhYv5eDMVKEHYmyFMxmWWSKjH3ogbed2A1zbpWoeo0VJ4hLRx2+x6F6O/Ps9tzoFWdOV0Y/XLHCmNgvpfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxH9xVsumUQyfQczYDLxRSqhnux25c45SZcRROXKo3w=;
 b=e28ovuwexTKkHeG8ix5T+O4fqD9/G2PA+SE5OFk+lD6m7Jm2aySGBasyftCCkMLHZhRS4ZPJeulQ/dzvdUqXLpCAsEuYl7z4YFy41cJhvLN74Y5he+KiNAQw2a9oMyTL2Bi38VUoi4PdgCHlFv7wmcgDOClO8ayWcUZrpfw1soSy4H/Y1c2mmK1D80LmOPjASSuMcAlxOOsCmERl//MeHVAvDRpqbO9q8nbvUREq7Z73MixTHVYvyRJzbkFlF5AKE2HokZEqmRjz4wWZffpGkRA8P/89gWiOU/YEFX8xpV2Hi82VRsNURJ/jhCPi9JV0rmFHxRd8lB/mrmGw/GpvQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Tue, 20 May 2025 02:38:24 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:38:24 +0000
Date: Mon, 19 May 2025 19:38:20 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Zhi Wang
	<zhiw@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v16 17/22] cxl/region: Factor out interleave granularity
 setup
Message-ID: <aCvrHCC2nNpdO-A5@aschofie-mobl2.lan>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-18-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-18-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR13CA0121.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::6) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS0PR11MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: dc67c938-1bba-4756-fdeb-08dd974764b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zNEvl+yQFbpgPczrJm0Zof1mkWee38wJtqwzKQO4HcvENtkQMU/6lyqf7tml?=
 =?us-ascii?Q?2d2lHdnDLJ2Owv1W9TxbbvfgBhtZ0a4WY4ZzJOZaNf8RfSYtLDeJr6PMQOJ/?=
 =?us-ascii?Q?treifR2djc7zcC8VtdlDgFHbI0UimCDvLfxhVaHckh9F9tIfMA1e6TUIzTen?=
 =?us-ascii?Q?Z/46X/5sG+P3o9YjKdGXtPKDF5XHUqnYphHEx9GDFcIWCSZANozq/PxrhcHa?=
 =?us-ascii?Q?MvmxuqYXDPT2O4suB6V1XUlFwI7ntyVILrcrF/2ZeTZgkBBMZmyX6jTPPEMU?=
 =?us-ascii?Q?nYwyVGh18H6sUrDU2AFQConsPTVbXAH/Q59cjVUnWXg0FFbG2yxYkcT3szPo?=
 =?us-ascii?Q?V5jaq6Adxv4K81kHyO8qp3vMolOrmY7fzTbwTFMbeLefDN472Ll98NcCWSu2?=
 =?us-ascii?Q?uo18m8nS9a5v9zk8Cf17BnaxfGa0J0nxWn4NDRYpAqtHhUYhvcq+zyEpSuKw?=
 =?us-ascii?Q?gpRSZ7DF5fPKg03K4y0jGh+m0CAjOjFshhJRRrwagLr5IqPN8APekc2AWPkq?=
 =?us-ascii?Q?wk5OlAT5+qhe4szwaHpWh9MHkdJgpi42fXshG1V0N570Q3ndqV4EyhCoTLyg?=
 =?us-ascii?Q?9CUjCic0djMkVJvX/whCbWjEfMRSpjtbv2Zpral8APiGsc6//ZYkZk8BbQRs?=
 =?us-ascii?Q?oV8vntIuJ0ozaYB97o5L8oiIry6mR3y3OE1e2zTZ1ZQkTxW1qKGCrdkjDSH4?=
 =?us-ascii?Q?hVjGQAsMCfKmTewrUbqy2xfY+Xs2zfdhVkt2PA2tGBLOAm1A1gvhSGLpze30?=
 =?us-ascii?Q?Q5lC3ySVguVPDiN4dvl6UISD5PGouZLIpvi9fjXUUa1QUwMADYjfmEc9Smn7?=
 =?us-ascii?Q?PUGP9B8r+fh/OuEPzKAGHoz2l099kVMkCgF2b+0IjDuRcmIo04KhvG+JwemO?=
 =?us-ascii?Q?w6mRuKWv+1Ix0IMOgqA945LoJW1NP9+7ilfakkrAlpOqwEgCS7+QPnHRf49w?=
 =?us-ascii?Q?cOcob7dbpHgKc260b4Og0y8dWz2fOb+STGrddNiAcFuCU/IvnTS8Sga8i8EI?=
 =?us-ascii?Q?9qJFswCz1u4NSvz2QgaCWu0s3rieNADcFIRCuW82RAf4TuqPGjy6jfdjRhwE?=
 =?us-ascii?Q?mHeU5EtJZ/bgG3LasRXxQfsRHJUxMiYi0TV2PrXBIgOCT9LgfB2TPmtAnmN7?=
 =?us-ascii?Q?3vF1GC4jvGNQ4A28x4cJfbOyFNDT/ftlzXunJAvjz2jS69ePrwfaYuPmlDKX?=
 =?us-ascii?Q?Vbw+HKr7Z654FHdRVM154zZNTXazY70otZd9RFq6+iz4czxsFRU/vJngY0UD?=
 =?us-ascii?Q?zC7HH05KR7ix+2oFssJlBjul3Y/jNpJQ+W6fdVYc8G8k6HiIKKn3TSG5OV3N?=
 =?us-ascii?Q?H4F8ag63U1hJB6Zh4SOal6eZd1zGmcXvpnQrObEy/i2kP/XjI/dpg0IOAGAk?=
 =?us-ascii?Q?yMHXMpGfhMd7RdO+vENy7eisM5r2VylNx2gu5HT6K4ZfiTmWDZW4jDljMHYh?=
 =?us-ascii?Q?yCIz2uHFL5Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kY21nBMJDa1jSMuhefWEPBF+4c9XQPKJlL/ot9IMn+zB/8YtNVigh4fVk9kE?=
 =?us-ascii?Q?qESVYP6gw2A0taNyVahjgAZH5LZGAcIjMV7fZuUAiZquqLMjhMoBaekQ0sPA?=
 =?us-ascii?Q?5TKh6TEQR4OmINhU58RyewUQPZ5JcoKyfTYyGo8oNbki+yA4Ovviux2DCbDW?=
 =?us-ascii?Q?3XHYrVSgGebmeVaSlmQCQGZhe8+fzNzqJu/v4mwkagKhzgz8CYdhWFdTBPKf?=
 =?us-ascii?Q?R6tW3xV/1nJGwhqZoNvfOp11L3j+Aa4BijhSFfkygF+qgH4FTL99LplDzEcF?=
 =?us-ascii?Q?JQsvAEeI2J+3TH0gb3Q/PQ/jTS4G+dhrIjGvutr8rqEmoAr5pEa1O5ObAJO9?=
 =?us-ascii?Q?EHbdviwaf6MD9YgTKfepBVu7HxWcDG8hzPArAWkJMfl00dGKKkvD2OBHe8mu?=
 =?us-ascii?Q?HjeNVhyPo0DkbvBQSD0tc2vbI5IMUt7T8q3hfcwhH2CgNe7CX5ORuE2SjLn6?=
 =?us-ascii?Q?IaPNDA7AS38wDHqMvkA0tZmmBtwa9r4eLAO72UIb+tgABgLU8TlIgcidL+ch?=
 =?us-ascii?Q?HcJZbHMBZoQx9GGIAwWENichDaNQkcmMuuJxPjNMBaiE4dhJqqFjxfm+vzA8?=
 =?us-ascii?Q?7Zan253rn5m75aj+L92D5KdLhf60doJqXKni5bIp2bcQ9R7n035Sr6nUTvm1?=
 =?us-ascii?Q?RrzVlm8fVAxQDFEQUKBKpeAD++mf7lf8g+x2H9copK16l2f9o92UMsJeg4eE?=
 =?us-ascii?Q?tDjZo5/Gv3Hj/4fD7BskeUGuhxHqJDOQbSkEnLrrVYOHLQHDjc03Y8jZ1dwh?=
 =?us-ascii?Q?6H9ltfX0xcUZ2TRpbbvVcznqjtiBcwhiuKS0PHiyoqY3Icj0EgPUSc7rLN4a?=
 =?us-ascii?Q?G8q3N5bqeshfs37L45/tt3zlbKVq4JLwtnoGPiTcLQQBUSiypY3VrlTw1Gcq?=
 =?us-ascii?Q?Vcg/bUOXelzZF7W0lzbt8ANDrt2xHS22syWcRNrGxy6eR+JwVboe0ThrECfQ?=
 =?us-ascii?Q?cf1AhZ92OQ6TLlSO79G41RpTmimLVazei48fbBDyTvJIu6z3NyVIEB8gv5Uy?=
 =?us-ascii?Q?YayY/0u7do7d689SXkNUthA6ZqjtTugnw/P5BRthgg8LSLWac20hamVe22dX?=
 =?us-ascii?Q?fJqk0Gf6JdJ4W5pJEvFlJJruLOFKEM1lv8+iYVslZCbsuFnbm4VX9N1b6fOl?=
 =?us-ascii?Q?Xw4cXlTW9NS39ZRL4QPvYUAJAz2AIpME3Xk5+O3mS+jc7jZ6pKxWYWtJpgPQ?=
 =?us-ascii?Q?V11Nm8Zq2CEPXsP3QnofxCyD9QFdB67V5ZqNS7tw0ps2y7uuoooA51k1P9XU?=
 =?us-ascii?Q?4u+cEKKSzUizWC/2r/QQjP/JalkDn3GrNJjIxnB/Zs8oqxB1mwdi9pIVrrNz?=
 =?us-ascii?Q?Phvxz3iMXZUYkkbpXRL5LHydYo3CNamlD7VcTqAGSQwuR3WH1NXbTgnJUkyr?=
 =?us-ascii?Q?AnJfvpF6xkX1yU0Azz8KX0REMyoIj+9e0tyFvSlTI83eIdRQFTIyUhSVfFh9?=
 =?us-ascii?Q?pdWiBehEM89JFw/zmnGDPWzgWX+muOmK2f+j3Bg4NAZgu0yoTuNqzU1qD2WZ?=
 =?us-ascii?Q?vdeVpjCAgJKr3of1dDqriyUO0qCTeQIg3kRKqAfpFepC9K1dvNmOYJnGXsz9?=
 =?us-ascii?Q?EfRKi0gmSCV+NAFizJXkW1W53Dj/E4tl5BnG8wqmJyhMnPNAE+zdWHCO9iOb?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc67c938-1bba-4756-fdeb-08dd974764b1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:38:24.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeGrVRGzK0dF22yJ4lvW3qOS+4v/PhMIKo27feMvRr0zt3FdqwWpqICFLNwFkV9/i8Lpm1/rx6WGz8xIiE0wQzmNQkdf5V51HrxfPUDsZX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 02:27:38PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation based on Type3 devices is triggered from user space
> allowing memory combination through interleaving.
> 
> In preparation for kernel driven region creation, that is Type2 drivers
> triggering region creation backed with its advertised CXL memory, factor
> out a common helper from the user-sysfs region setup forinterleave
> granularity.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

