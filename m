Return-Path: <netdev+bounces-159519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA1A15AFB
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605B4188C212
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC63C2AD31;
	Sat, 18 Jan 2025 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loR9gNPs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69AD17548;
	Sat, 18 Jan 2025 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737165584; cv=fail; b=a0/UJL4FoUKZF2WuI6tbLAQhVJKDcY4MFWTyOHnpCsOQ0HfFmqAmyJIoaJGAXdjMGpao1adf1GwkPoSJESzgDX+f+AmFnA8nPliAeWiIfJdgv7e1Ijp6Cv3E48XxS0v2IzUubT7/+LRnvlJmq8wMt7FhYvUdrF81x4GPPS2RUCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737165584; c=relaxed/simple;
	bh=w22/pJ+JEaTCSLc36vXwOOlS6daGbolUkTGT+Kb5DTI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AFwln7cuBNq2bc64NZvCTlmtRpyg3iYIpUwgtkfre+WR97gETIGhxGGgKX1UbNpicfkUoNqUd/WHTOToW9pz+mNA2K8GetHvfBm1ZZfw+BFC7gS1wHomYqNzkr0cNn/fDGFJmXFr0x9VBn9ngeAYVWNpQAwBTpAeaQTOB6vvaYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loR9gNPs; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737165583; x=1768701583;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w22/pJ+JEaTCSLc36vXwOOlS6daGbolUkTGT+Kb5DTI=;
  b=loR9gNPs47OyVmJT77TR+aIqqIrJjDWX7aYasxDkeYflRcI60reSEc7t
   5rbhbmco9yAyj+cZaYF0sKfeK3IzTYbDawu5yfdHgIj3Wh+gXRZfdMWK9
   7p7b2Z1rrWpe0dTCZ2XspxzkbXBBda+uXgd1DK9P4IR/prDeqK69QTt2b
   o82e6zIMbyxX2cApGowcDtYaLu232Rwg8Jrp/KVz2+rHpd5h3HJKeH14G
   jaUUTBONq7R08oTus1dPlNS9Az7wTZkC0DKPDWkUDtcsQTEVlU2kLEukJ
   TbfzID375n1YZEqteDt6QWszuC9Grt1+tv9VFTq+qQl2Vq1736LioJ7Xl
   Q==;
X-CSE-ConnectionGUID: sMCf/sIoRZawCahOmBeaiw==
X-CSE-MsgGUID: C7D49O3qRTOpGNrT1DBrUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37728491"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37728491"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 17:59:43 -0800
X-CSE-ConnectionGUID: vLUGv1heQGqtOK3RI7nQwQ==
X-CSE-MsgGUID: YbqfYCGCQF6yKLK+l4zJpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="105926460"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 17:59:41 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 17:59:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 17:59:41 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 17:59:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOIqDNTSrw8ooyhdlRrWZ69vzWSSKYqSqFroxnmHSY4oaX8016Ysj7jato0L3E7CzHRvCSa1SgXDb0hMF6n7xrQmNGA1+taO1A/NOwlh60Qzjxo0z1+U17IoCU8pEZ6d7qNo8eM5LPUe7nIgZ8yNRquY1PRY4XoxuldnEv5BMvF0sCxqRyQoKLw3db8CK2wvcoOGaocVc3QXsF9bgWK1y2O421yDjfYXPPXYPYAt4o3cE44zl5bdu5jzRYP0wffzbYu/bE4eJadDJk0C1Htyd1zSaFReKTbVmt8JeoDUzTuSZjtM4h8t+5UiqkvIKthpFEP6/+zNRd9wwKmKNh1lZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFs/7vWl4isbNhiujK3ISeX3CFa6+X8Z8ev11cJ+4B8=;
 b=qLTDWnPd+JF2TU57NBCcCL09GU+CtpPyQnXGKZE87vt/J3NfllLUebETPbqGuVmIhByKr/SRoNHSuYQqnid/ACARG9+FpyNV6cpJ8VgXVlZJXzR6gXmY/+4nN3HVrx54ombPNI/VXdRLFQGiXaoVaAIdX2MA5VASwCDbIJ52EGEQ7ymjZbkA7VXb3Lmt+bu/uHfh8FmQbzeL8YrSxUrvZfjiZkoWJS2nb2We0/Iceut6Bs2jf2+0HaToIC97npMGBcxMQs2GezOP8ASrsocDJ7/bWr9vzYFEsR9AS8XbQxqXwvQQ5+m1qNcdAGcyNByZu/lZQQ55N8lW++qycWXfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Sat, 18 Jan
 2025 01:58:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 01:58:57 +0000
Date: Fri, 17 Jan 2025 17:58:54 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 09/27] sfc: request cxl ram resource
Message-ID: <678b0adea8dfe_20fa294c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-10-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241230214445.27602-10-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR04CA0205.namprd04.prod.outlook.com
 (2603:10b6:303:86::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 5166de77-a488-4490-e45a-08dd3763ab39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zWHSucqLWrRpGjGWcQVor60zwJ4A3yhpDuxjZfkEVP0SPuoI2be55leSEqiF?=
 =?us-ascii?Q?N4xuqk16mQ6/HeJN8eWx+Ccwzs0BMdp0BePbRuIcfB6qWmh3zuPV6gCVpSg+?=
 =?us-ascii?Q?gCHLUMcTvp70M1c58QG3F8WQodTZov1Fy9QVXmxqMz5gcf4uoxKhaBcIBdpq?=
 =?us-ascii?Q?vD0UfRStchvvnbNBfzkZU9NbiLqDiHZCWR+pJz85G8BQoOGqsG5/6qm84Lz0?=
 =?us-ascii?Q?c2nWvjEnqgWlAzZFkI7QCDET31Wpb3Dh9xSILkySPLoloTrx/Yn014fxC7XG?=
 =?us-ascii?Q?DUjXB67gpCttz1qZ1v8DwpJ3TP+isPR8aJFzoIQ/yKJT38ZV8hBk6ITA4L+/?=
 =?us-ascii?Q?4Sh4SP3prthgaadaqnFxRooZVAg6CLhZ3ssFmarxwyMXmjFrQPeY8Nh2/Az9?=
 =?us-ascii?Q?/9u4hXgAkbilFcpA03YP0C3OdZkM4WOItj8vFTdfb+76onLHLbY+8hm/QWIT?=
 =?us-ascii?Q?LeKtg3UhXGngIGQ+393R358b6RewAAHp7dWNKB6s1s6s6TGheO1Z4jU2qINc?=
 =?us-ascii?Q?PE575+WWYdLBi9FGkM+MpYWSw/E6dPABY/rB1Yk2nKIScrOiHDslQJ8mWTPj?=
 =?us-ascii?Q?sTT/MUtyJ90LB1IeuSvyLkytWEem3/EGnGp3dJ5/tk3MtwTM+uSrwzUCEr3L?=
 =?us-ascii?Q?VoZ1QOTFEtuaGmprS0LeDE6OxBnu9BNLpOJ7caatuEbO1xcOBtPPM9q2qxSl?=
 =?us-ascii?Q?ykbMPRvbejLlpPu/EcBMWa+Zxqf1gCWNYhYrlpAl4vpU3DwhpuWpRPRHbYbe?=
 =?us-ascii?Q?49C4IhhHo6sCQIaQpGznzWecX7BwREHVIgFRy/CscIG/IBMqmrFrWiW1vCrC?=
 =?us-ascii?Q?y8V7XS5fZs9BFAshw7yl2pDDWjtldQeyvnqPIC/394NAbzR/ErvcAQgBlHFH?=
 =?us-ascii?Q?FjAdGZt9lDJgi+QHBc5dE/d7Hgc0IBX9hfg0kJLM0SZigqXokm4yUKRwMEBD?=
 =?us-ascii?Q?ajP8DCpQfnylxPqlYz7S8MT+ZfpyD0OZAbExY/7QnLDEp2+PYbStwM6QkAvo?=
 =?us-ascii?Q?w8EbMH2SVHbzkAHZRg2WohZ5NDfpxngEdbEtl/d6+doewzO16+Sf54QfPZ5o?=
 =?us-ascii?Q?288GxkhXF7wmeSaiLtvucwgCWx6GpygkvmkOYi6cPVR98NYN1zs1Db0zwvBX?=
 =?us-ascii?Q?pJ9aUCYeMBapFKh/T/NQ11SwXwUKNF0+MQpHVQ4yTKXU1xoTwms5N8kWTJ9X?=
 =?us-ascii?Q?k67lg8TUg7FdotuJ0f4uNZITrC7gxSDSHgYwuGzsZMnxl7TE5ugpx2LYkluu?=
 =?us-ascii?Q?mJY7eVSrana5Y1RVZ0lhvy5zb8HodTmTeHJc4MeqHxmM7i4NcQmzXUoR/IRq?=
 =?us-ascii?Q?qkTHsiwl4Iv0wijQnd+VOzo92feG/pAazAjgwDrDqPNla2xIlnyPlCaMK5Ln?=
 =?us-ascii?Q?tflcgGGQh5GahDzm2Vond1R7hNN1SWXWQKnI547R/KENELtajAhK3RZ8tpI2?=
 =?us-ascii?Q?a1Gcsx1Eq/U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oUZOy/2ZgjcO9/w2IAQVScOAW74yJV6NJBxNxxwTCLEfXKnlDNYZJaMxk5eG?=
 =?us-ascii?Q?n+F1rZI9iPU30mRQyv1NcOTvF168MvgZLvnjJO7/88Jpa0cvQWgMOSi1ax/6?=
 =?us-ascii?Q?LnWIYR1+bWAmfqoeiHBaeNNFsZFi5DbxAXOzh2iVAZgAZElexNODYZP3onYd?=
 =?us-ascii?Q?enTu6iwHzY99hHcLYFdfz3G8BwEux/tofQU5OazNi9Mq6T7CWpU5GbRTbjlM?=
 =?us-ascii?Q?9ZjQoAf3bGCEuAYImLq6b8iSb8lx/3ArPjY1hCeV1b8gmFrNjrFbFtyS2yhg?=
 =?us-ascii?Q?N1uBrAivBxo+CA416rlRskjs6MlQkcxJyoM/4LhVhkAcw0+WBIKIZ4vXJx90?=
 =?us-ascii?Q?wY/asrf1TB9K1r1t6jTUQUmTLSeUS5OSMlAXwfJ0AmXBsPsF3cpVEbwOeKz8?=
 =?us-ascii?Q?Ly6X8f7PPKRqmkoLcbsGy92uIEHL5EzAcmZFCxXL8BHCoPq3k0u7MhZg2xZn?=
 =?us-ascii?Q?EC/Ex1h9pyOhyNRNXihl+eKLBqgDSnY+8mfAOWNsBsvRSHUAbDryC8h6fdlS?=
 =?us-ascii?Q?tAIvF2m/qHI5nd4hRDVc3Tvn23etWXL51tmbTxRiYI8gyODC5N1Z2EqJif9J?=
 =?us-ascii?Q?R37NeKMrFwE0aaPHHUIiklXF4gKK0CsrIg/c15OUbpTsAes3ZnP1ePlpR/wp?=
 =?us-ascii?Q?XOa3bRaguN19756oZC1m1G+UmQPFizxWuVJF2bxqXsSoWjc1fiY3+5IfvtQf?=
 =?us-ascii?Q?LZhOPdobdpQU7zPVIazI7GYJ3PWPmIEEANiTo4F9Z097ssw+H5EubkinjEnq?=
 =?us-ascii?Q?2aq7uHpnxCoppvLIHISqFNCnEY6L1leuhj0HzpwdghsjcUfx+SQ5arYFxUKb?=
 =?us-ascii?Q?ckXhqsczy4gkdOfFUNe9PnAAKTB3k0CQTQpio5/4C8UMqRBEUknAQEcJjKVw?=
 =?us-ascii?Q?t8ew/vy+e0lEKiTSOx1dgx4ngEMY5VBmskSO7OAdHiFvWJi55on4qql9pDmr?=
 =?us-ascii?Q?8zsKTT/WTZpbIe+hj/GHiEC7Dg+Dx7Hn+i1qNSAlq4wQtWe0bnmnxAGchXKt?=
 =?us-ascii?Q?qpCEfbVom3JKLxSsnxuXT0xxNVvcQB3Iobd9Iz+IXPOJKKZb8GRbXurBvJeb?=
 =?us-ascii?Q?BGqGA3wM4C0Bd8DKwZ+PbfzBtYLpw+3K74YMbY/fgwzAI3+9wZiYh5ak5MW6?=
 =?us-ascii?Q?rIGLVPKsIYCcuZ15pj9ghGqJTWUzcxYeEV4MxacGtw6Cv8bxszXQcht8xSID?=
 =?us-ascii?Q?lwosNpZ2OzpTbWsZAD547zyL5e0L1GuKwo/kCNayZf6mceIyfqjzeHeB7Qjr?=
 =?us-ascii?Q?JLCBVBXq7rKOx0kpU4KoHFxVPq1QD8kOVpBNKAhIBWhBTF5CqjHg+t02uskB?=
 =?us-ascii?Q?E/5t4Ngfr04QUVSvpLMOM/6pjRrG8uh+/XhjGCVM+dAYhYGMEPeCQwTwrSp3?=
 =?us-ascii?Q?2eAd9wMVXpbdExd7ut9v7N5lA065/ey5W/UwNQoXpOzQ0jDDRZOscb7RZzPz?=
 =?us-ascii?Q?FXB8r5f9Tk04dd29OdCiJALKlR6zowfiJkmq5gurt3WzdCjpmKp9CF47uYBY?=
 =?us-ascii?Q?BejlYE19Ezlvmb68/CLA+7RUwfc6HlRMCf6FHdKV2n4V5X6ZThQJe1U5J7I1?=
 =?us-ascii?Q?6jp4ubvmm7gCQlYY74Xa/NSMI141lcepvgXtYi3ZQdSBAbKvWvSI5IyMNh+1?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5166de77-a488-4490-e45a-08dd3763ab39
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 01:58:57.1587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0Dl/XKfHrWpSPiutMpgGlFYokP9aGjwNN+Js+qxIKVeKkkRxIcXGE7fjexCaG0CR968gnZUQnHEpAfNdkKXQ5yRjttKP47fcWkuLCEkkpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4545
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl accessor for obtaining the ram resource the device advertises.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 29368d010adc..2031f08ee689 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -85,6 +85,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err_resource_set;
>  	}
>  
> +	rc = cxl_request_resource(cxl->cxlds, CXL_RES_RAM);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL request resource failed");
> +		goto err_resource_set;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -99,6 +105,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
>  	if (probe_data->cxl) {
> +		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);

Given that the DPA layout is a static property of 'struct cxl_dev_state'
once set there is no need to release it. Notice how there is no release
in the memdev case either. The 'release' is freeing @cxlds.

Now, any DPA reservations from that partition need to be released, but
those releases are with respect to cxl_dpa_{alloc,free}().

