Return-Path: <netdev+bounces-156109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1746CA04FC2
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F516163077
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2645D146013;
	Wed,  8 Jan 2025 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dA1blTGd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0A13CF9C;
	Wed,  8 Jan 2025 01:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300021; cv=fail; b=Xvqrq65hZWfoZzVksC0vW10u6P9cdU8HRl7YK7DEpBYdbqq1zwr85voggvPUCPpObv07T1FuaS8uYcbXbYfnYv6OYDveaKtTNIhRZK34RmPlHDo161GQi3Ojx0s2fxGnutvxW9jfv7y4DoJ0sHSLO6d6W8Moc77xmDRMp2AaSzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300021; c=relaxed/simple;
	bh=WlKPIokJWqdsUg+Cmz/I4fMg4iyC1auAaYjtrDlnl/Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KuCEAriwJw1OoBWzfuKrIGkcLL6jjRG816sSaWPsCECD3hU0V5L3x3fePNSKte2liMzxodHdFqdBH4kiN82CUqhOjwGMab5TnDzTcaaq8DOHRVVj9RR7qz4WMIbcK+d0kpY5oxhQpLqPwCdqchZU0v1Zljg1C4+Y01t2QUu04Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dA1blTGd; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736300018; x=1767836018;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WlKPIokJWqdsUg+Cmz/I4fMg4iyC1auAaYjtrDlnl/Y=;
  b=dA1blTGdq4gHRq4abgcQQs9erJA7xypH677zTrPGujmCztQQmcg4w0R+
   bize/HO3zEiQChbaQQV5ZJa5+Nhiskm2WvMA0GKab+iDddjn7debRl3mB
   izmwVirfxpesGNhR5PlzvZ3B3D+x14ilU5qDGReo2oeKwcDYnJWqIXCuh
   JxWErS5jD9/lONqjpWhV/PrANwKDYDfj3VTuwUoU1FkF8lWpObUaQsZsB
   jKHDjUyJazSC5S3QfIoy8El1uJ1Ori1+bWfNSdtUU3eiV0onXxsjG3JQr
   bwc0a8+9qCrllMeCJvzmW2JkKbV4gxefsn7+Aow0PL5ghWbyUF8cKtX4u
   A==;
X-CSE-ConnectionGUID: sLgZLR7nTHimA4ZPNwabbA==
X-CSE-MsgGUID: FOdijlL5QBiJFOzVqKOjGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="40455861"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="40455861"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 17:33:36 -0800
X-CSE-ConnectionGUID: ZYbXiryWQsCKvoz6m3Ltbw==
X-CSE-MsgGUID: 1vPKXWKNSnSCjGO/vW05fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="103453603"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 17:33:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 17:33:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 17:33:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 17:33:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzUH8GHtbwHB7R+JM1Cc50S8HPBt2/NZFyyxqIVFcS+P48dSnKfqFeWL6+FoDO9TfX8v9oriQCb7ZPww1252tM3MSfpMMTpNQYEScqNvo1Y0CwHtgGv/BQiegaK7BzL3DJih7JLk79KkEmLaO1s2MT7m/9bMqC+njrrQaGmLzqIes0kLWZEnwSeSb4SOu7kF1H1zJxgxKOzp7IvzMY0E03BcXxTr7DmTb7N2a5W/CC3gfLAoYF+cjDBTy1KR4jfEoOHzKUHGGvlAYBRdF+m4xdJsL9ZQFZGuisExIb6Xi80d3s7kfKXVCpStHxUv8Mx9WWD0LRd7M57vJFu4WxAxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUUhP76JxTgifvFoSd1JODSKj2FoP7SzFlq1FkhvRkQ=;
 b=R5hhCOiUrQGFNjFyV/Tbj+uOWOVY9C+VGJmx6PS4eA57mnc2rcwl8s1202CKTL8HeUQdbRRS9huCrfY7cqGkHaUSmxnHB6CWqFKC6C1joO6nfccK4z115OQ9IjNcvckkgohyKwGvdj38xjaQYSeFC3w0sw4sEUvs1UHf5dDi2QsCCb7yVaK/n1u+cu8zWnCARQZXQrTF1eDTh1tSjKvh2zeHmLA8VApbHhkV9z4k5LuN0fbxVc8od9RNxKB9yrCy7L7id+YVGIF1OOErrCYW3F4xrN+P2b6opCbG5cO3X5HPpdLjwgHV7Sh3ehQy4ger03e8/8SGakw6nlJfq48h9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6653.namprd11.prod.outlook.com (2603:10b6:806:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 01:33:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 01:33:33 +0000
Date: Tue, 7 Jan 2025 17:33:30 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Message-ID: <677dd5ea832e6_f58f29444@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:303:8f::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: ceed3bb6-4ab7-455d-aca6-08dd2f8476a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8jz9fic4I8pV0f0EydU7QJGL1/NhNoHncMbQJzJZXnsqO3b7LN4w6qgCsXeN?=
 =?us-ascii?Q?Nmx4PDVXS/nSqR70QRLpbOswu3W4xpP6MPM3Wdtzr7Za8BSMCU5u/40JGS4J?=
 =?us-ascii?Q?uZ4m2qX7Mi1u3wZ8z2YgCFw87R8zViXHOVBj/3mZIMDz55Eeg3S143VJwL/d?=
 =?us-ascii?Q?T5Z67EGRCvogdTKQTSxzhjcVDNOFIKdi7D3l8tcz7DIsa1onNgQGJRM4ySsG?=
 =?us-ascii?Q?FTE6U4095ZClSZQTkqfqOxtjaeiWtzuZjYupGsboRuGgql8zwhwg6rsLRkDv?=
 =?us-ascii?Q?+mlEiSWYmGvpbhdGm+nOWIP+Qd0Wu0pTAaq2fa7ccjDWR3yoNQGEU7ZQHwV2?=
 =?us-ascii?Q?sxqpiW0hzoxANqyLne4qv1bTFbQ+eMi2JDuawbL5JWk8WAs1IWanJRHLwb7L?=
 =?us-ascii?Q?ela1SzK/XIsK7x7T5cyzhwRLLzenIJNwvl1NeXVpij8kRTpTfADbT4CfMLex?=
 =?us-ascii?Q?NTtbTCG581iisha8bOYuOXNIn3K+LTVtas32cp5OJoaxip/eC3mzRmHAWG/f?=
 =?us-ascii?Q?mY/WYU+Y1BBqGEXrQ2QIJ0B3gpYJXoD6rwkeePNQ1DohxcelxhPajLViCYda?=
 =?us-ascii?Q?uqRxPfOyQx1kP3URlLed7bixA9yEHF0F0lEOyUkqd+8YSxTHxwMsazdE1SxD?=
 =?us-ascii?Q?Pqvgz2LEctXdHEKQkQ3JhUfdz2J0VzC0ci/xLNm5CijEdkNlkKbjgx2RKsd5?=
 =?us-ascii?Q?ZYqICLHTT4341yX5+HdvmxqBVgfo0+meAc+tPEvgqjZLRBnLiSKVCKwBIhUA?=
 =?us-ascii?Q?xk4BRO0RNi9xHBNamL3p7P0O1YGI1CPSKvLuacp7pudWCZ9Dsvhqm8p+OrMN?=
 =?us-ascii?Q?IDV/LARNnXGZWH7KIiYJzDMyTiRFA8+eMb/0C+7rLurBoIhl5gu0JOd32JQQ?=
 =?us-ascii?Q?vgrmLBbWZKJQa1eKsWpwIPgaVJyDfKr+Hqg6BQv/CsrUbazm80fqlHbPOj3J?=
 =?us-ascii?Q?AGvRPpwPLTDlsORLKqKroIc+FUamwvW5vykK7tR25OUJy+9+C+gAdsyRQBk6?=
 =?us-ascii?Q?GBKhRnciGkTkE9VxICdNiDPESEC6fEkuZAYYfVjXXQ8hVQ7WyuW0wJ1erbBZ?=
 =?us-ascii?Q?6ci900xpQZCxgX1tjI1oKJFr6vc1/eMqpeg0UU2MPRG2m6226xopIbKZYb11?=
 =?us-ascii?Q?IIXEC7wWw2cU9TJN3fixzYz9U2deIBEk0hogNtwylPLlGC9yBKt9TY6G62FG?=
 =?us-ascii?Q?mVv8ZCx0R7h1zlUhON/WeudBI7mUgNlrWNomO8UwUXws1N0JLuBSc2NUVhEh?=
 =?us-ascii?Q?8KM1OzbYSsfsJmYEuvx++qmRtSFdCqc2TTil5g4ddfXwYL4cN7+0t+nhLHzp?=
 =?us-ascii?Q?hU2O5kQJYw3osoowz/CmsY8Wv8DYACiWvo4izplpfBUMlzDEb+j2OFe7nCSM?=
 =?us-ascii?Q?YQ3kt+LSN9UnSZVip6h3miGyStS2zkOlGSqIi2ZUcarEZ9B425uIjFNo0FJz?=
 =?us-ascii?Q?HeFJXXPzwgX8Gb+1lNZ/L7nCtgFWHtHR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WIO6QolaJbdRXS+zLQ6GAPbUaAFRYyQmELcKdJ0XXbyEYjtFBM+j3AuJCbKa?=
 =?us-ascii?Q?3sIhvbQOY+HO5fZEqMGujw4UohYkf0OOiiRON1sN9tyFvW7fSfx2Soib69Xb?=
 =?us-ascii?Q?jFz/6Qy+Ppi4iVLZStcOX0ehz+8sSuu+5+15PCURNRnCvTgvap6jNjCUu/zJ?=
 =?us-ascii?Q?UMA6PDs7M1M1PmMFjS4f+Z8KYmzI93EzHDG3PMSvPYhGU7X0bxdkwO/15xSO?=
 =?us-ascii?Q?dQjH0k/Uyphd2nuO4Vnz1jpezY38gN9POB92YLeLCuARDxkC+WZsC8ZIklcR?=
 =?us-ascii?Q?FcCsCfpcvqARtuW03U9d54Ts5ONKJw6NJ8TRA7NO+ON1e1qVDCtt8Re7zCQV?=
 =?us-ascii?Q?73rk/2TNWqDgah9Y05+44DozBHTmlJJdGczjIeyMgF9n/egwx3RyximOO1OL?=
 =?us-ascii?Q?k4OAPCFycEzlo95zdwXNY7zDvYE8sxqQ7mkh//pxJfzvndstHIFM57sJbh6J?=
 =?us-ascii?Q?aI2SyRa0yNmsem+8Wy2jwb6Bivpn1+SauZqSLBpDfZsFtZervkO9776NZzSU?=
 =?us-ascii?Q?nG9e60/g8Xj1SWD/QXdIUF2MukbAgaK6aZ4IOjeYfnXmVV0VD8VEPIGBU+dX?=
 =?us-ascii?Q?ZcukvGypQjfnge1BHRgmffdwBow+7eVAz/1KjI5Bv61QVsBfRDr+GGt5D2tJ?=
 =?us-ascii?Q?A/iBKPWolxsrAEktljyqQYfrvP8Xsv8EEc0C+nOIfX3lzXq3q64AJ/6eD8bI?=
 =?us-ascii?Q?aOyjEBTMBcvoDFUSOzcCabAr+5HYorZgPmyu5TEV1ksWnE+wqpbTy8PfhY6J?=
 =?us-ascii?Q?ak7hoMhYrbHWEJGE0YDG7RhXSSXCmcbUUroBo2VGDtOakr1P0iiulUVUBbBV?=
 =?us-ascii?Q?tdnkkWJ6yrwzqstWFUEMi1i06hR8Nvkh3UXKWHNm7506iWrhJInASmtfp+58?=
 =?us-ascii?Q?aq3uMQcwpddEOo82Fb7mr9f2cA3omU2hFW6bvR6S0Aw9TxV2B5Kjy6LKbp5S?=
 =?us-ascii?Q?Mp3jiu7rQITO5p8PmOWU5BuCkD9SR1IJzwvt0YPhYlLeVYjcj9xi/FOQg7mL?=
 =?us-ascii?Q?BxPyfHS12YmMLbC/N1ofcoxYOKI8kq+IbWw/V40fzOa+Sgo2JvoXO4iJAQAD?=
 =?us-ascii?Q?m2XxwxJOB6b5ZUU7qpeogTg84sVKa8FIH0ul/7NZXNZVMjEtfCaco2ddFOIS?=
 =?us-ascii?Q?VjxDdYQkM1OqJj+jA9lghuMmI4XZvgQiaICnKi+gD3q/dh4Ds0pqeUugENsp?=
 =?us-ascii?Q?CZCadg87k6wKFHfP7AXEWuuvLAFIp/5IEdMttQe9usTUEP/bKFlR2H8ZqFNZ?=
 =?us-ascii?Q?lu4s7gSDjqTCHAgCyWHnfZeKsRti3+0R4G9OXc/j4m2y2xzkpnCFCs6Pgck+?=
 =?us-ascii?Q?Dqk8D2DN8O3uBxk++Npivj3qO72ndCuSyTEMUJW9uQQK5HstMWmuyrTs2U1C?=
 =?us-ascii?Q?yaKuXWfXqDbAjeBUsAcBkFKdT65y6DvYc7ncrt9R6+TJSesIl0XG6y1t3qR8?=
 =?us-ascii?Q?wmuKpOlU4Uj/lCykQrowETFXfDT2gStScfuvWt34sLEZK2ck9CrFie+zOlR5?=
 =?us-ascii?Q?Qj4G6Pv8z5S0i6OlEzWtCR5p7yZwDmvG2plmmHbACPLsxs4U//Qnsz4N1HeJ?=
 =?us-ascii?Q?5ep1K2E5t86vXg8CAYmmG4M8yNhO0Buu+mTYnKNtDwy+UL6XVj54KkNOWtGP?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ceed3bb6-4ab7-455d-aca6-08dd2f8476a3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 01:33:33.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy8qYHXQjRPBSOtgBfCWqzgmIw2fC1LQ4wcVAsc2F9uxVyGESLXXV3oM6teDUg0+XoiavEj2skk8CfekHOuF0QRTGw+6TRE6uwzmq+OVrkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6653
X-OriginatorOrg: intel.com

Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
> > From: Alejandro Lucero <alucerop@amd.com>
> > 
> > Differentiate CXL memory expanders (type 3) from CXL device accelerators
> > (type 2) with a new function for initializing cxl_dev_state.
> > 
> > Create accessors to cxl_dev_state to be used by accel drivers.
> > 
> > Based on previous work by Dan Williams [1]
> > 
> > Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Fan Ni <fan.ni@samsung.com>
> 
> This patch causes 

Whoops, forgot to complete this thought. Someting in this series causes:

depmod: ERROR: Cycle detected: ecdh_generic
depmod: ERROR: Cycle detected: tpm
depmod: ERROR: Cycle detected: cxl_mock -> cxl_core -> cxl_mock
depmod: ERROR: Cycle detected: encrypted_keys
depmod: ERROR: Found 2 modules in dependency cycles!

I think the non CXL ones are false likely triggered by the CXL causing
depmod to exit early.

Given cxl-test is unfamiliar territory to many submitters I always offer
to fix up the breakage. I came up with the below incremental patch to
fold in that also addresses my other feedback.

Now the depmod error is something Alison saw too, and while I can also
see it on patch1 if I do:

- apply whole series
- build => see the error
- rollback patch1
- build => see the error

...a subsequent build the error goes away, so I think that transient
behavior is a quirk of how cxl-test is built, but some later patch in
that series makes the failure permanent.

In any event I figured that out after creating the below fixup and
realizing that it does not fix the cxl-test build issue:

-- 8< --
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 548564c770c0..584766d34b05 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1435,7 +1435,7 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
 
-struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
+struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial, u16 dvsec)
 {
 	struct cxl_memdev_state *mds;
 
@@ -1445,11 +1445,9 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	cxl_dev_state_init(&mds->cxlds, dev, CXL_DEVTYPE_CLASSMEM, serial,
+			   dvsec);
 	mutex_init(&mds->event.log_lock);
-	mds->cxlds.dev = dev;
-	mds->cxlds.reg_map.host = dev;
-	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
-	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
 	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
 	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 99f533caae1e..9b8b9b4d1392 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -617,24 +617,18 @@ static void detach_memdev(struct work_struct *work)
 
 static struct lock_class_key cxl_memdev_key;
 
-struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
+void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
+			enum cxl_devtype type, u64 serial, u16 dvsec)
 {
-	struct cxl_dev_state *cxlds;
-
-	cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
-	if (!cxlds)
-		return ERR_PTR(-ENOMEM);
-
 	cxlds->dev = dev;
-	cxlds->type = CXL_DEVTYPE_DEVMEM;
+	cxlds->type = type;
+	cxlds->reg_map.host = dev;
+	cxlds->reg_map.resource = CXL_RESOURCE_NONE;
 
 	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
 	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
 	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
-
-	return cxlds;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, "CXL");
 
 static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 					   const struct file_operations *fops)
@@ -713,37 +707,6 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
-{
-	cxlds->cxl_dvsec = dvsec;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, "CXL");
-
-void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
-{
-	cxlds->serial = serial;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_set_serial, "CXL");
-
-int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
-		     enum cxl_resource type)
-{
-	switch (type) {
-	case CXL_RES_DPA:
-		cxlds->dpa_res = res;
-		return 0;
-	case CXL_RES_RAM:
-		cxlds->ram_res = res;
-		return 0;
-	case CXL_RES_PMEM:
-		cxlds->pmem_res = res;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_set_resource, "CXL");
-
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb..1e4b64b8f35a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -4,6 +4,7 @@
 #define __CXL_MEM_H__
 #include <uapi/linux/cxl_mem.h>
 #include <linux/pci.h>
+#include <cxl/cxl.h>
 #include <linux/cdev.h>
 #include <linux/uuid.h>
 #include <linux/node.h>
@@ -380,20 +381,6 @@ struct cxl_security_state {
 	struct kernfs_node *sanitize_node;
 };
 
-/*
- * enum cxl_devtype - delineate type-2 from a generic type-3 device
- * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
- *			 HDM-DB, no requirement that this device implements a
- *			 mailbox, or other memory-device-standard manageability
- *			 flows.
- * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
- *			   HDM-H and class-mandatory memory device registers
- */
-enum cxl_devtype {
-	CXL_DEVTYPE_DEVMEM,
-	CXL_DEVTYPE_CLASSMEM,
-};
-
 /**
  * struct cxl_dpa_perf - DPA performance property entry
  * @dpa_range: range for DPA address
@@ -411,9 +398,9 @@ struct cxl_dpa_perf {
 /**
  * struct cxl_dev_state - The driver device state
  *
- * cxl_dev_state represents the CXL driver/device state.  It provides an
- * interface to mailbox commands as well as some cached data about the device.
- * Currently only memory devices are represented.
+ * cxl_dev_state represents the minimal data about a CXL device to allow
+ * the CXL core to manage common initialization of generic CXL and HDM capabilities of
+ * memory expanders and accelerators with device-memory
  *
  * @dev: The device associated with this CXL state
  * @cxlmd: The device representing the CXL.mem capabilities of @dev
@@ -426,7 +413,7 @@ struct cxl_dpa_perf {
  * @pmem_res: Active Persistent memory capacity configuration
  * @ram_res: Active Volatile memory capacity configuration
  * @serial: PCIe Device Serial Number
- * @type: Generic Memory Class device or Vendor Specific Memory device
+ * @type: Generic Memory Class device or an accelerator with CXL.mem
  * @cxl_mbox: CXL mailbox context
  */
 struct cxl_dev_state {
@@ -819,7 +806,8 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
 int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
-struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
+struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
+						 u16 dvsec);
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 36098e2b4235..b51e47fd28b3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -922,21 +922,19 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 	pci_set_master(pdev);
 
-	mds = cxl_memdev_state_create(&pdev->dev);
-	if (IS_ERR(mds))
-		return PTR_ERR(mds);
-	cxlds = &mds->cxlds;
-	pci_set_drvdata(pdev, cxlds);
-
-	cxlds->rcd = is_cxl_restricted(pdev);
-	cxl_set_serial(cxlds, pci_get_dsn(pdev));
 	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
 					  CXL_DVSEC_PCIE_DEVICE);
 	if (!dvsec)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present, skip CXL.mem init\n");
 
-	cxl_set_dvsec(cxlds, dvsec);
+	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
+	if (IS_ERR(mds))
+		return PTR_ERR(mds);
+	cxlds = &mds->cxlds;
+	pci_set_drvdata(pdev, cxlds);
+
+	cxlds->rcd = is_cxl_restricted(pdev);
 
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index aa4480d49e48..9db4fb6d2c74 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -4,21 +4,25 @@
 #ifndef __CXL_H
 #define __CXL_H
 
-#include <linux/ioport.h>
+#include <linux/types.h>
 
-enum cxl_resource {
-	CXL_RES_DPA,
-	CXL_RES_RAM,
-	CXL_RES_PMEM,
+/*
+ * enum cxl_devtype - delineate type-2 from a generic type-3 device
+ * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
+ *			 HDM-DB, no requirement that this device implements a
+ *			 mailbox, or other memory-device-standard manageability
+ *			 flows.
+ * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
+ *			   HDM-H and class-mandatory memory device registers
+ */
+enum cxl_devtype {
+	CXL_DEVTYPE_DEVMEM,
+	CXL_DEVTYPE_CLASSMEM,
 };
 
 struct cxl_dev_state;
 struct device;
 
-struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
-
-void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
-void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
-int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
-		     enum cxl_resource);
+void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
+			enum cxl_devtype type, u64 serial, u16 dvsec);
 #endif
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 347c1e7b37bd..24cac1cc30f9 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1500,7 +1500,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	mds = cxl_memdev_state_create(dev);
+	mds = cxl_memdev_state_create(dev, pdev->id, 0);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 
@@ -1516,7 +1516,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
 	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
 
-	cxlds->serial = pdev->id;
 	if (is_rcd(pdev))
 		cxlds->rcd = true;
 

