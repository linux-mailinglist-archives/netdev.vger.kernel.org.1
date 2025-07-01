Return-Path: <netdev+bounces-202919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB58AEFAC4
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB891C08100
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DA527933A;
	Tue,  1 Jul 2025 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AorgeHqg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361627815C;
	Tue,  1 Jul 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376608; cv=fail; b=OEDkZDM9bcLZ2/WLlkwtGMC6UZ63oCt0ZrYcpqqnUOlqL+eqQhMpRXM06XJZakeykeGLoJcpfqn0jqidtuIZBi5zkeNOzS7Y3TokXGUtSVLBa/Q39hR7qU5m0S6BrpA08zRFEtxnZ+lKCaGSw3eNE3CUQKrX90DjuEXYa7Gehkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376608; c=relaxed/simple;
	bh=TqXdsefEBZtwAH3p6E1nd1tojdipdBNLL+yM+B9ldU0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TKt6PNV+oeG/GIdID5v0/TsPjJ9yEMRvac6oJuAoRCl7nju6gUwf69H18WPbJEXCNVFB4LRD/QRYlTUPoih1lnyHCJJVqXOf5nIHism82TjucHY2hNbmqeuBzg0WrkQIGszfK4U/kM8YdSuo6j64xyIQJZkAEOmXJGdt1pE4ORw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AorgeHqg; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751376607; x=1782912607;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TqXdsefEBZtwAH3p6E1nd1tojdipdBNLL+yM+B9ldU0=;
  b=AorgeHqgFqBYFIax/MNyAkXQlU/0xaHk8vbYqQ11U8L/myFIa6Svum1E
   AWgOWEB85WSZkadi0xPt23pGloUz8Ee82omTsYPhqzFqywfi7WNs2Tn5b
   uHpO5EENKKWEhAONAhUdoGpEQPlnt+ttqmE3C7l3EfiPNFB5yt/eLZGpl
   jTKCN2OXQqVv63+KWOIZC97akqeb743nf4uMcPLIOV4ToTicQ0D9FkE55
   oygqo5/QlZ6GOFi/i44fOHYPpyxaKvbJX4BdL4LM5v0jBOqQoSzZBs+k1
   csp5sF5lpaSt7abNUG71qxY0Wj0yQALORO9LsEj4SsG6LcpV7S5R97rBo
   w==;
X-CSE-ConnectionGUID: FtUaK8TRS/CqCU0iCEkyxQ==
X-CSE-MsgGUID: jQOHEc1HQymHxUMDrto2vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="76189830"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="76189830"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:30:06 -0700
X-CSE-ConnectionGUID: IUEG85p1TjugD2ZJFSABIQ==
X-CSE-MsgGUID: 6+lBN9SvRpyygs4fWhDkxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="159484949"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:30:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 06:30:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 06:30:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 06:30:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJFGz4ICQLx6j4b6q6IxNxCG3uuvkxAsEUsyQ/PJ25z8wPrVnMJcFI4AQeH33vg9amTXXf5ZkAMw6mFCijz4eBIAID1B17TZe+v5qTM5q4qkfAsng0Hq8VjG/WDF8AwjvOszUfBxI1rmsSEalZgt3WgYOLTzg+2Fx/CKqLaadguHWB7j4v4NK8KNqAmzYbXdAWIQ9RsJvqeUTeLu53st7u3oSqssmuis+YP9yvgwRl4UY87i1rRHtg5vIlVzUNasJUcPfOKW27lNtWTEI7qYJsGJb6wntryng5Bc1T5kl7Ne5IC558Fg9yYP2BoTFVceWi491Tg96qRDgwYLYjcNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1fD/CE9MrAG8FR7bY7NXE0D3ta3XODXDtRFHpW3Gr4=;
 b=BcG5ZuBrfVTpz9PZSvPh81dB5EaV8Ag+ZF5QYEW1Dv+m2nawcxMJtgZfyNXbGMQEXptsr4g8ngrVCAG5WzRJac13P2+DhwAT2Mb+/ij5VxPFd3G1QTlnHqwebpfX96+t751N4KIAJo9UKTG9amXpzsMpzMAiyI0zIUaJI9zt6vmPpwD0VbjPkfk7+Y2a3H5CFwe3YBsq9TP+KRhvcFWJRHEltqDELZ/de01HW5UYzoUuQFSv8p29K+wXmbIkx1BXSPvi6ue0v08BPKHrJYtofLC3L8/ktcc2Jq/9vGPoYWlHpwKqCv+UHcwmYiw9HvZWl3I+/aAiq2bW+v8mlUZnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB8829.namprd11.prod.outlook.com (2603:10b6:208:59b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 1 Jul
 2025 13:29:21 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 13:29:21 +0000
Date: Tue, 1 Jul 2025 15:29:14 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Fushuai Wang <wangfushuai@baidu.com>
CC: <ecree.xilinx@gmail.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-net-drivers@amd.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] sfc: siena: eliminate xdp_rxq_info_valid
 using XDP base API
Message-ID: <aGPiqlNRMBsQQCgt@soc-5CG4396X81.clients.intel.com>
References: <20250628051033.51133-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250628051033.51133-1-wangfushuai@baidu.com>
X-ClientProxiedBy: VI1P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::29) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA1PR11MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 336bb0d7-a094-4c6b-6091-08ddb8a349a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bwi/XScWawx1+F6L9xwm6Dquo9hpv0LO79nl4fq66mhFct9UWxNyAo/S+AxV?=
 =?us-ascii?Q?oKomca1QOgJmkZC/XBe1F5CLZfyBc23en+LzF0swPUQ2WpvFk54H7k29D8Ir?=
 =?us-ascii?Q?fY/HRs3/QtN8esUd2aw0asNephuare46VYP+XhFtpH4dvmhFChvdS79mG0c4?=
 =?us-ascii?Q?mrxzuZXuibc+xRzcs1YCKKw9sow1DsOCpKn0Oem7bymhSlL3V6PDjvOhMO77?=
 =?us-ascii?Q?tjP37uwMd68mpor+W5T6t/SC8KNVLUo5by3MqqnctN1/ga81HDAIircQHv4g?=
 =?us-ascii?Q?9jcmNtqzkamN/Pixj1C80xiossMrxxxKFpnz24E99WGoN3u4TEWSZ6yDTbcM?=
 =?us-ascii?Q?9til0PgNFpeRcHOVarJrjmoFIZzhYOiJZyB9/xfNnFzl6CNcofBbkSiAiumn?=
 =?us-ascii?Q?8ip1ObI8Os38y+pP2d1OWeImlTgHtkZRilNFXmTWG98F/zSJ8GS8x9frRxlo?=
 =?us-ascii?Q?i/S23gCuesMukvWaE6hEhhYSceevOyerN2hDvvi8T92LNmoKZ2+LhzoVtPga?=
 =?us-ascii?Q?Rw/OQk6xURE5B68jAfV4YRb8RgVTSzHCP3oDRxhs+0VZMnai885aXqxZ+VYm?=
 =?us-ascii?Q?3O398AjnDu71ejzkRHWBfT7TzIvP/f19YQG+pCALJwFvCjmlKITmkx84mkde?=
 =?us-ascii?Q?G7Idg/OBhv+f3XxclivzgRHSr/liRkkTJKzas+poc1crCzP5WWS7QU+ocV06?=
 =?us-ascii?Q?35oCBgodPIeLiyy/dsGVvl846SISp0VNaPQB3UA6mPpj3QpH0Q3bFGXamdE6?=
 =?us-ascii?Q?srkBquzVo1pJ9gjCDdzVjtMCzwDdxdN+PB+NMf6Ir68x5pQJZbiPQmI5vaGp?=
 =?us-ascii?Q?MpwmWvYPLbHja4z7NwtNWqdRQpdfIp7wBz6vhnxwgQTmXBgnSXWfSJtx+rM+?=
 =?us-ascii?Q?vj7Vcnqdmvfh49hhW8hyCnjBPD1Ns7xCYuyEHuyg9WZqwnudxjU2uMt3kt2E?=
 =?us-ascii?Q?NyqCk0/cS9rkZwYvxtHxb8wF6iTP4fMsPxehZj2IE0p5byJdRAnrny2sz3qo?=
 =?us-ascii?Q?k9LkAnbwPc7EJdO6p6B8/eYEAeBqdKokfiJAfDUxUBMpQbQrJWaE/GMnJBwh?=
 =?us-ascii?Q?8yOERs5oAF24GGfgsnf96ly3k0Bui+wKXI4oqwv858r+Ip89aOsQ5wI0HIPq?=
 =?us-ascii?Q?HTMbU8Vtutzf2r6ITbRUagt52tjptZ4hHhRGLnw35fD9K9geaGR2B3/a6a8J?=
 =?us-ascii?Q?F+Rqvhthm8qsGr35aPuOvG8JG4SuQIczeJOKb5qfO6dg5Q6WAXeCWlWmx6hg?=
 =?us-ascii?Q?5akAdMq50YXd6gqqkLKt3ISa8E/NhAkC6NzfvyvcFqbEr5/MLvuIGLmR4AG0?=
 =?us-ascii?Q?KILSoeJUeuiNPfhWdihr+m6OA4r5sjKahA5SXRKtD+4Vo5cPIKHeaSp1TxxD?=
 =?us-ascii?Q?TuA2zWWrvD1647tHuqlNoxQBqwDGOcvQrVb/MH4x+qj/aW9rajgah6AqQ2ll?=
 =?us-ascii?Q?4+JWbyH9NdQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oNSH9w+p//pIRIaMjao5E0Z6hKytu9k9a8dOfiHCrNUd5Qom+j1X3oSycCLW?=
 =?us-ascii?Q?qyY6TkFxizltHAaClHP/U+Mtfl4leTbP024eSCIhMnbVa0YkHnDW3x765YDl?=
 =?us-ascii?Q?J6XP6HoS4AO85WSOq1eQwS9FMo9NK/oyo9gzihhKc5FpYfqqtLwaR2rmAFUc?=
 =?us-ascii?Q?bUZAbH/OqkRFXwYuSSuI9g5C2KeAdZKvc6NiYHGsbcUQxaRPpPvdBiKvKCnT?=
 =?us-ascii?Q?826iTAgMbaE7S5WjcFkUdhuhUV3+m0QhERYjpVVej3RzdEjWACJoIgMvE4d9?=
 =?us-ascii?Q?z6L9Ki8cHQ6RLl0ySpG8LrE0cLXG6hWeCna4x+8R1qjYISMjS1bDKwBu1W9d?=
 =?us-ascii?Q?Zru/CKC9ht6bt7VE0lAIrIKDKki08sGxD49Up/I+P7FT6sP2cse2JkSyw4bg?=
 =?us-ascii?Q?6UXd8GsKX2OKss9f5HFby2QxJ0xqHueUdaJEsD5b735ZKMWMA+gt4UoKTHSO?=
 =?us-ascii?Q?xXwbUHnWcjKfVudihHVfU7JSOryoXN+NW00zyDHnjrxc0xGl586YG9KQ9Ljn?=
 =?us-ascii?Q?5pWI+uBUqdEba5jMxxNtDfwDPyyKhSc4l96rH+cm7bveaoaqKpmknioLIWI5?=
 =?us-ascii?Q?ElZLx52P70A4DbP8FDIFt6xihYpL5gDZrwlJbnkAa/O7wiQSnw4IkpgGUonQ?=
 =?us-ascii?Q?VFjy+Evz2PGrTpiOvZS2dMJCYUIP8QDhNAO5HCF3OhPSUqclkWF40fQ9MzhG?=
 =?us-ascii?Q?SRO+PqoGxGUREV4YunmzAFbrIpADIs7rI5K5yyJElJ5Os1VhEk5TN4I/KxFO?=
 =?us-ascii?Q?XmPmzN8nGdZzFm8kuH+Ij+DugymZtPvjSE2GnRwzWQQoqBldD/LaAQQCZ5za?=
 =?us-ascii?Q?ECeLO0nQRkVlsXmxUoUYCaIkMZ4r/cgLcdxNPnLQlA9K14flLSv6UNLxoYaK?=
 =?us-ascii?Q?jGec5saj0Wlt58Ew84eyL0FjyexlgRq2P4P58RXG2zKXAscsbZ3b54o9F20+?=
 =?us-ascii?Q?R4vWLvPq8b5cL6t/uzQkl8Q5gLmTYJ37vMhXkEzToEBtEzgm248fj21BbK5p?=
 =?us-ascii?Q?eBnynhMyMa5cGmOAwU//h0FUrsrJwtbPmw/J8JHNq40/w4dbgdq611MeH8yK?=
 =?us-ascii?Q?Dg1rCbNJ1sdrOItgSqDGSJS+F1NpkF5YoJquQ3PKcsvcMDiTqbSz42sd2rQJ?=
 =?us-ascii?Q?SUytzP4MgOaoeTyLeY5U6w9C4nTrQb8scL5PSMKAdUFqmaw+1y6qmz1njfXW?=
 =?us-ascii?Q?n+AyM1/QfxZ4yyHNqfacbUGx2I0sKAXubujcTMom7b8sYmnGLaQKONbCXOZN?=
 =?us-ascii?Q?VFHf3tRDSNdJHZF0ZDQJi2hAKUU1vGqALitPbGA4sRjjU+IWQ1Juewxbvl/c?=
 =?us-ascii?Q?wXiHGmme5tNFRO8tt5BXTb0P1Q2awXEsU51SiB819tDQjKprqvv7umupyxE6?=
 =?us-ascii?Q?jjClSOmA7jIeJqHk4LVFTkLydfvOS070hgyrsPOJYZwIDhjrLgFWW0UD5oqj?=
 =?us-ascii?Q?IJW9FlrpfZHC5fqtb08qptvVrIVpyztuwZsFiLr7DvhEnyswO7T1l9gAlggc?=
 =?us-ascii?Q?GINIUSx19poFe+xmK6vt9S6OPApM0Vat3GWOt+Z7OvST1uG/t4FqHVB4KBZp?=
 =?us-ascii?Q?4vOeWX/HYFiOkA8GGCKvPOAbomzxv/VwHqr/uo7STOsqcaHWbK4LmzQRheNV?=
 =?us-ascii?Q?GQge/hoQTY1kwrdq5Pm8WXihUPDlJgyx4+FXleuI7SvzZnceUJCW/DWmqIZU?=
 =?us-ascii?Q?PhkJug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 336bb0d7-a094-4c6b-6091-08ddb8a349a0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:29:21.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULmzOn3vxl3fP+0uaxXrmdulyP1P614AW180JCSguOe+/pLqgX3T7TLHgXyk5q1m3nNm59Y3LGdBZIW9MsYxC8Ccn9w9FXUfaPfexA6dCR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8829
X-OriginatorOrg: intel.com

On Sat, Jun 28, 2025 at 01:10:33PM +0800, Fushuai Wang wrote:
> Commit d48523cb88e0 ("sfc: Copy shared files needed for Siena (part 2)")
> use xdp_rxq_info_valid to track failures of xdp_rxq_info_reg().
> However, this driver-maintained state becomes redundant since the XDP
> framework already provides xdp_rxq_info_is_reg() for checking registration
> status.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>


You could have sent those patches in a single patchset, but the patches 
themselves are fine.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  drivers/net/ethernet/sfc/siena/net_driver.h | 2 --
>  drivers/net/ethernet/sfc/siena/rx_common.c  | 6 +-----
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/siena/net_driver.h b/drivers/net/ethernet/sfc/siena/net_driver.h
> index 2be3bad3c993..4cf556782133 100644
> --- a/drivers/net/ethernet/sfc/siena/net_driver.h
> +++ b/drivers/net/ethernet/sfc/siena/net_driver.h
> @@ -384,7 +384,6 @@ struct efx_rx_page_state {
>   * @recycle_count: RX buffer recycle counter.
>   * @slow_fill: Timer used to defer efx_nic_generate_fill_event().
>   * @xdp_rxq_info: XDP specific RX queue information.
> - * @xdp_rxq_info_valid: Is xdp_rxq_info valid data?.
>   */
>  struct efx_rx_queue {
>  	struct efx_nic *efx;
> @@ -417,7 +416,6 @@ struct efx_rx_queue {
>  	/* Statistics to supplement MAC stats */
>  	unsigned long rx_packets;
>  	struct xdp_rxq_info xdp_rxq_info;
> -	bool xdp_rxq_info_valid;
>  };
>  
>  enum efx_sync_events_state {
> diff --git a/drivers/net/ethernet/sfc/siena/rx_common.c b/drivers/net/ethernet/sfc/siena/rx_common.c
> index 98d27174015d..4ae09505e417 100644
> --- a/drivers/net/ethernet/sfc/siena/rx_common.c
> +++ b/drivers/net/ethernet/sfc/siena/rx_common.c
> @@ -268,8 +268,6 @@ void efx_siena_init_rx_queue(struct efx_rx_queue *rx_queue)
>  			  "Failure to initialise XDP queue information rc=%d\n",
>  			  rc);
>  		efx->xdp_rxq_info_failed = true;
> -	} else {
> -		rx_queue->xdp_rxq_info_valid = true;
>  	}
>  
>  	/* Set up RX descriptor ring */
> @@ -299,10 +297,8 @@ void efx_siena_fini_rx_queue(struct efx_rx_queue *rx_queue)
>  
>  	efx_fini_rx_recycle_ring(rx_queue);
>  
> -	if (rx_queue->xdp_rxq_info_valid)
> +	if (xdp_rxq_info_is_reg(&rx_queue->xdp_rxq_info))
>  		xdp_rxq_info_unreg(&rx_queue->xdp_rxq_info);
> -
> -	rx_queue->xdp_rxq_info_valid = false;
>  }
>  
>  void efx_siena_remove_rx_queue(struct efx_rx_queue *rx_queue)
> -- 
> 2.36.1
> 
> 

