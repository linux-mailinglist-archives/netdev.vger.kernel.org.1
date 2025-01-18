Return-Path: <netdev+bounces-159517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BBDA15AF1
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38F0168DD4
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C274C19BBA;
	Sat, 18 Jan 2025 01:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8OJ5plD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095BF136E;
	Sat, 18 Jan 2025 01:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737165217; cv=fail; b=CWMTxxteT+MmCT5Z2+xvQY1G0tkPDpP5aArIlZDridsl6SIhyeLJgRhyfK1l35dCroq/TH1tN8ZwgDKN1aWUMKHNwsnvrHGqPk7tbpalCPO83TedhfmeBOqP26XcFrOV7WpFji0ggpcdh6FzWi0C0IaKMhl2uNf5KRdIcYRy7p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737165217; c=relaxed/simple;
	bh=IDPPCQOCg5QmhuP5rmSGKAt3YsDitEt1DJrKx+NhnpQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z8HAY1tmVtgI4xkNZ4oS0BzN9Pqbq5sPjr/5TWKeOT5XhQcIE98oGrgSEo7YB7+bIhdzdbsyfSINIBmiJpe70OaOKpP1xF84hXsnK+gzUqx9UDxfCZyhoStHElV1xjkSNTiuIVC/kioHVCviuRRk2uiB6N42MmPmgugm4Y7LuRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8OJ5plD; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737165216; x=1768701216;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IDPPCQOCg5QmhuP5rmSGKAt3YsDitEt1DJrKx+NhnpQ=;
  b=O8OJ5plDjc92m7ma4CxnOzczuW5dwklBGmhlRtAg0dnVDCvVQQuydIWo
   FmNQh5VS+tFQ8abzOAKF8lJu+8kLEEWYhVEPQLwEtnt5JWztkG2Vdc/80
   Z6xN19mYgxhF1jhUWwxtPqScqbE/ueoRxurmSfvM3Zyt+Rjt5+YJsc5uw
   4Thnu3WkqiVFLdgnJVo3GsAZuzsl80EFFnkjJ8ucIReWHlmjg1FQiWmco
   /cajcoUFvaSPKWgRzmaX9lOWoPTcNs71zz/SECp3boG1tpkyzd5Dtpg5A
   Nfb0xpBHqYozuDj0SfLzfoCxIqNgCHJGPaJQnbcQUlu9oyfof77r5s2/0
   A==;
X-CSE-ConnectionGUID: oUy7A9t4R3mOFNF4pVKlDA==
X-CSE-MsgGUID: FXFdBhVHTbiaiZ0hVZzuXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37774423"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="37774423"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 17:53:34 -0800
X-CSE-ConnectionGUID: yZiYiX0lSHGajGjnjII+EQ==
X-CSE-MsgGUID: gvUrTHolQFy6HnT+tYzvrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111073039"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 17:53:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 17:53:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 17:53:32 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 17:53:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6QiRQ3ITzyAGh1gBFEjrWtGorcJsRtxce0hWKPKqgsIMUpyC9jvMICYUZy0qp6FA7kPVC0hu2VDacYev9CvIbgnlcfdGqteXXe4YZLVYD41C+hT4clMb9cLqCYkzHfVUmy9d3u8k0512Lgh7rqz8s+RnB0A01YLQXjNYzaX5kLaNu6MnQWqKyjju0TuiczmhotvNU37Gs2qF63EWmM7zLQAIHr1cDIQ21FZfYvZbUF9PozFNoxnnjpM44RPPZSnJEcBWS/H53HCNJwhmVgLMcjlomcFg5vzLxdxfIR9Zr6UNk1KV7NfQpk5t5Z+RFiwRDnYl3/e7NDsF4StMfUpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaL9sBE9dtSRnJCCR3cl3s6ZPGzgmn5psoEmwrTZGjA=;
 b=augaMuU2hLln29Od4FiYkwRUqwrhKAKqqn/B1ddqoF/mCeZO7H7DNNCG/HTcQ/yEaIdgFkl5q7FLOZqLzajWrKtnSFsgSO1j4+qAHJ3MFcwGqH3iJRhw5JFgQKHA+fFtwalSPTZw2qxUAhnefxT6kQ62JYW17dHunF/Cw2c7POrVQrcGY+5cAXm6IAeXrtnGiIrmtL6z2rQ3ae/BARHWyJNHmhZGG/vOnJ8mMYr2SrUcKocbCwPxQaaU/cob7txMqd39erS17psqjVUSYpcaLyG7dN8cBWGXE91reb/3RIzXZwPIwbhIUhORoNnf1uuEImL+X8lvVYJLd+rAMYKYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7612.namprd11.prod.outlook.com (2603:10b6:806:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Sat, 18 Jan
 2025 01:53:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 01:53:30 +0000
Date: Fri, 17 Jan 2025 17:53:27 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 07/27] sfc: use cxl api for regs setup and checking
Message-ID: <678b0997a360c_20fa294f8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-8-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241230214445.27602-8-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:303:8c::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 6809149d-3e99-492c-52f8-08dd3762e838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0vLcwa7WjzCgU3moce1HkBq06J6qLBF6ih4usBg3EDNTtT8LBQ3MZHV7+KtX?=
 =?us-ascii?Q?edlVCb7qWjye5ANn5N6QUeHBixpuumdNYlRZgytSreXCoGlOmEOBFd0bnu/2?=
 =?us-ascii?Q?lh7EHYBhf2WIttBOdmGL046DEXYho4HcWPWGvuvXnmGoCRHGKevqenMfqu/y?=
 =?us-ascii?Q?LRTQFGHogBMqWLNBtuaj4Y9B6vSSVtyzeapRll3D6aRWD+wkGW4QbIfi1gOG?=
 =?us-ascii?Q?up3OckKMFgj+cTJv4Z+WN2vA3ZaKBCYoxThnkN5rDNqD2BkNkJKwOJ4pWFCm?=
 =?us-ascii?Q?fTN3LFG9p6QhYMJe8MLqI8VVZplIJ6OxJlGFipLR2LpcVodeOckgHBpf94QL?=
 =?us-ascii?Q?kfQRmb7eNloh9oD5cb+8n6ohcb7RiZNyy1fQnQUIvZ6YFbuc7e+GOgRw0Prn?=
 =?us-ascii?Q?3J8pmdt5YqVNTrOX/AD/0lY96QlNp55zbvWp/q2DXyOXAN/8yCgPxS/H+36o?=
 =?us-ascii?Q?wpfeyP72ybfYm2AfzqQK9KK7ua1DY1wVmj/N68ieMyK2gacbuovYKLr+YH3E?=
 =?us-ascii?Q?1kjdUxol/28pAY2V4ncBubX8+SEoRjhhW75LxTKxLt5m+oBx7TT9QVUpED3a?=
 =?us-ascii?Q?0C4yeBeAl17eJSYblb3RH5VdsbG5udUWl3gVU4zJkxFPI8anyhu1JMrlDMBb?=
 =?us-ascii?Q?ABJnCxJBS19WmNySsQHqRVYVGreWZcgnNlJk0kgDx9zFELkUleeR1EeCgsa9?=
 =?us-ascii?Q?PVqqq+7K23vcEz0T7DCQBGdGJX8ECNEtpDm3MAWz1thmaxH0qsgtNtT/xgAd?=
 =?us-ascii?Q?2bw44lnslPHOpJi6oo/IHp9KFQ73bwngrteJE5iXtnh5gL1hRtI8P/a9wFIt?=
 =?us-ascii?Q?UusPdQgRxW5tONpWe/ldHyJLq1yvL9Sw7Xae5+eaiPzqcdweAxy8+sABiuWB?=
 =?us-ascii?Q?CCCmfGL3vpYMMJpG2CjGVXIqCwuB8qfB1LvV7FlrmI3Z010BMTQPycyc/49N?=
 =?us-ascii?Q?J0jQZ4232nV1lFSLZVZf4JsCiiYbY+sDWTVxSsQQWYhxVq1QdyckS4HZQPkA?=
 =?us-ascii?Q?IEN2VoWB3WEIfuI/AJznIZQyv0Yvi8YLtsfUEm3EWAUkVeXNHzfLAdGWFAMf?=
 =?us-ascii?Q?O6mx15fGKzIyuKTaRkJtEeTrFh2kW7JAGpjppF5jXk3H3o5qtxcX4OOGplry?=
 =?us-ascii?Q?pnWBDX6v4eOrE8PNXbV4BpFIiROjGZABc306r9rR9DERXFtsfYzS5jRoryBr?=
 =?us-ascii?Q?+fT1BW6GqbX5c23lAWxAm+o4AqCYpdrDbmaFQWAPwr6GBgaBk+t5A4RFc8Xw?=
 =?us-ascii?Q?wMqiryy9llmUdrli2UVB9DqCkSAajOrrF0q8H4ipZ/JTLPgprDeBAARIsW0U?=
 =?us-ascii?Q?vWPSCyfGCa5oxmdgwsrJ1dFEfFmc8bTetFphYNvL5j4FSs9/hCrt4nzXAT2p?=
 =?us-ascii?Q?MohsNRlyWGwV8nKPK3rW4IuriWCn3dV563aUgd3c23sGVEEBQ6H8yzzkxtgg?=
 =?us-ascii?Q?VA4B7vhY838=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBRzmJHaAeggZr3Bezp0YHv873tVHupt9kOelw2M+eIQEaEuy2PCya0hdjUZ?=
 =?us-ascii?Q?gDxvlEJ71XApToYOJ2QP+KDZNqz3cB97QaP4kr4aVWR+UsgJEvfQnXQtc0Qt?=
 =?us-ascii?Q?S6Kk20Kwumxzvnj9oGT7QmXQpvVQDjRBPTJolE/nzTnfG0eCemmj4dTmbHCr?=
 =?us-ascii?Q?v1tehAKIuUBPy8bV3GSPNEczvwp2b7yLiJ8TZkI81vH4tGf49aXvvubgfECP?=
 =?us-ascii?Q?IYJ8N7LhmQ5BnGoW4C6Ti/eoFTq6guq4rjTkOZGOboLtPG1JXaaNzc1Nn5J7?=
 =?us-ascii?Q?XlUPojbEj+/8wHdPWwNZxanbHWj6gTsgMmtUbuhdBNtDoDgJYbeWpErDiEkB?=
 =?us-ascii?Q?+oTrytvPR+qa+sZgWL3x2V+dfxGZ2f7B+vpv1F3ITE4X+7EBqGPLlIO3e8e1?=
 =?us-ascii?Q?FO7rITiVTR71TzRHmKpwj22hHBjT2u3b9kKivxZGPY66gmkLQZ95dB/8LGXn?=
 =?us-ascii?Q?8QmwU+JEp51/0eIeDsvV8BVLxG9sSk/I2kazXQLYohO5XKJUmnxCba/ItZFL?=
 =?us-ascii?Q?Akj/U7PFRE7H0D7DE9kmrW0KWn3hAlcjcnGgn95pCBdQ/2weihlEKgbbVe5q?=
 =?us-ascii?Q?pltupUdZ33Wc7eQIgTl1kS5JynNWO4SW57IR2E7CE6/hQAeQ/qiw9JhYOyZT?=
 =?us-ascii?Q?0hwS/5Cr6xGTZeEbGRqDaLZ0wrW+kDHAgvRi3tcu8DqFHxrupSbvD/u+sUXu?=
 =?us-ascii?Q?8jYkbYpY1nP8LJRmCFszOi2Jyl7LfUPes57pBazo0+Q5wPrZ9lpfokIoXZp2?=
 =?us-ascii?Q?gokTj+ZPjpNonAlN8jFuaOTSizQ4+/lDpjRY5c6VvmRPgSE5mSelXK0D9hio?=
 =?us-ascii?Q?wSwKq3VqUJwn86n+uDaatW1vjrxypmQ25bZvhEI3/LMKnGBTjBU0ibhC4xYv?=
 =?us-ascii?Q?JQqvhA8jXqe+LgZhXIiFNKqHqh1XByh9POJZp3KGuRaOHj15PROCi1Lt+Uj1?=
 =?us-ascii?Q?48GncH2CGVpnG91ngaR5aRMysnj6b8tXRfWBrzxuIuNMrtIVe4WM8s66a3tO?=
 =?us-ascii?Q?CdFu+EuyeJi/a00ve+Pzm+wXE/DAIuTPqkX9uYtmP1N2v6EgFZgcdQH+9IiZ?=
 =?us-ascii?Q?9x5Zwci+bEjK2q3J0a2Ea+2++mVisaLfSREj2xsyAfk9fMqc06VPJVlu5XGl?=
 =?us-ascii?Q?1AhjNp0MP0v8kf+d9sEZeMFrrsfNXdvjxsAquBBI1z6nBCuqN/UDWAlSMK1A?=
 =?us-ascii?Q?dmlimTfORivAj2WMuGdmEH1mYpRy5stxg9R9TXmJSGKP0AfmI/54dHN3qvxH?=
 =?us-ascii?Q?gGdzwYDV//7JE8nfqRTlkAF8uGA8Wq/Fo/AJ6tEax14mVpdCgHJCOzJ+hiq6?=
 =?us-ascii?Q?//jfiWp34R8EfGd993VI1h77Vi5pL5PZ6Km+EJmmwbJDuKhZWLUmYfI4xilr?=
 =?us-ascii?Q?NGtJDZqXFlAgDT7LkB4D8ztodiF0C9uwsefzWn7OfQVfTsEF9XtfvznQ7ynZ?=
 =?us-ascii?Q?VW5Ysei0pWzhlJmeXb6onpjDO760uBbnZdwGeKtx4EpMXasI39ji/3mepJ8x?=
 =?us-ascii?Q?N1fb+OXDUyt+YuwgGm4M9YcpRwJgUig3YEcUtCEOTtdSvhnzu0o5vTQIbksY?=
 =?us-ascii?Q?gugIc3JiPegU2Xo6x3Ev7j6vhbsmZBfpsCiqNqOgP1rT3msYItJrhTWwU8nx?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6809149d-3e99-492c-52f8-08dd3762e838
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 01:53:29.9854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VzGYqDq8BaYDboVqY43c09XP/YybOCE6m2yYU5XNYPT5UzHbAIMvBwGdvDDAeYQGbDYYHyMCnwQnZIR7D8VL6bQ68a/x55jes/UXhNA1hQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7612
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl code for registers discovery and mapping.
> 
> Validate capabilities found based on those registers against expected
> capabilities.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Zhi Wang <zhi@nvidia.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 12c9d50cbb26..29368d010adc 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -22,6 +22,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct efx_cxl *cxl;
>  	struct resource res;
>  	u16 dvsec;
> @@ -64,6 +66,25 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err_resource_set;
>  	}
>  
> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL accel setup regs failed");
> +		goto err_resource_set;
> +	}
> +
> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
> +	set_bit(CXL_DEV_CAP_HDM, expected);
> +	set_bit(CXL_DEV_CAP_HDM, expected);
> +	set_bit(CXL_DEV_CAP_RAS, expected);
> +
> +	if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
> +		pci_err(pci_dev,
> +			"CXL device capabilities found(%pb) not as expected(%pb)",
> +			found, expected);
> +		rc = -EIO;
> +		goto err_resource_set;
> +	}
> +

Walk the existing valid bits in the reg maps. If you want to do this
with bitmaps you can convert reg_map valid bits into a bitmap locally,
but that redundant infrastructure can be left out of the core.

