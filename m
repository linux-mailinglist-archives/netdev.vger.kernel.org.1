Return-Path: <netdev+bounces-108106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2C391DDB4
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F17F1C21A9D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 11:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E12B13BACC;
	Mon,  1 Jul 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nA9711lL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567571F949;
	Mon,  1 Jul 2024 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832847; cv=fail; b=sBv/8CsxPPnA4AsnR8RXP9uewPujdf7iCTq971n16nCwJQLKs9ErGfgecWJb90g2q7BuQzdJQkmgFgpDG6SiHX+JCJl3xeV5AFcFXl9/isQsomalvkL/OD7SpR0PeYLug7Er/nA0NdWWfx+kXekYtNhGX37yQJQEUEyjhIx33EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832847; c=relaxed/simple;
	bh=29o62XbVDDAYuz8MCfTRnaq2W0uX1zA8QIX/P2ZxWrU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fpHyZJqZnNJ53U2gAUIf4Xr0LPW/DMDD5++pGZi98BBKc7j9jL4qcP5cWo+pi5uAQVgh5e8pHtuj95Q4oyTX8oiRWeNHxrfB86vWwgdWTnRXuF66dFkzwa5L7fb22z/Q6GKtwyRQbJGAlaVphWAy0/VjRpCfiM0bbgjNsy9/434=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nA9711lL; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719832846; x=1751368846;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=29o62XbVDDAYuz8MCfTRnaq2W0uX1zA8QIX/P2ZxWrU=;
  b=nA9711lLOQOgC4dZEzLDfJXaGJv9+ddCcft0tla5JxS04dtODknS4d24
   7rmz72PP5s3VYb23EG0MoMA0mknQ3gSKDY+iQdaJsZoh0nkOyH7JVa5zd
   n5lbun2OE+34Tc0XsK+CPdXptO/FpzsyCIkI2L11vD9s2me8iTMhzf8xp
   plUeeIGeg5TzsCXVGA0trjMoat5FMIuVpKNu+nwgu6sDOMo6e51cOtmhM
   PE8wPrpYdgTtswB+B0ckKo0HnvazU57inwFdj5GTZW3XY9bTKj7bjXfwg
   jTGyIRgfOpkvxQDWsyC4DY6XTboSaiLdHai5OdObc43/5txBWidKxOMm0
   w==;
X-CSE-ConnectionGUID: fv4jP1WeQdO3ZrpUXq83CA==
X-CSE-MsgGUID: ApVRIq6OSkCPI/BCtxgETw==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="34399031"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="34399031"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 04:20:45 -0700
X-CSE-ConnectionGUID: gZnQWsyiS6uMNiRAN6ROGw==
X-CSE-MsgGUID: sQXG9uBpThaRwA4yq/2dqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45384795"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 04:20:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 04:20:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 04:20:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 04:20:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bp//b6qsZXtN+ScUok67TxCaTu2lv+KBdGckRMyi7Cw4D68y7x1d1QhFIkWBEExv8YT3gsbPu8ikSHaV2c2rZOB/+U/hRuMuOmurgxG/mhEF5Oo8UAVL1n/DzNvdg+GyYCWdGRWeqjJnO5FdDm96paR/A8uw3ojD+mcU2ofqYCtezHAQVetHFm5mCl84MsUK2KelPeQf4Vjc7k9CZxZWa9KyUcLEMjKbb0a94J9i6ppj+JFN9DZYYcRqcVCZRtRhTzP5VkUMYNxjIqCiWm2o89DTeiwUW/5QB10yaLZjlTeZJ91u88V+Tor1Gj+f1VkNlRh3Us0bvQtXCdTzehPBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykEQVcQ0je2n6NY4lsyo1OmrJYp5nbCqxDqNPJTXxfI=;
 b=OA6hgOQbpxr2aniKVYCdt8jlPqMyq1xqxSD8A1RKhGgMuAydL5vbv06Ho5iWeQI/YuNHE+2nnOCY4D/i/Ek1slBkY5DLVBlmUVq0uAvYeGtvcFDI2qctLMQelQnHcjbM1dmkgUngVGSNt+VWKdr//dyP5/FRJJx+PYJ8ocVwlHGharSpT4s8A4JyTAwhQujZgXc8tLXuyztihbXM05tnIQpnryDLcvGhBK1LnJvskwlDynEW67Co4shyJcZ5wzjCgvkm/tRVaWnn90b5x136MrvnARh/hgm/TCcvDUvrAhgup/qMq3Fketmji++8Q/MSlh2raLISw5kbAwA9dx+uxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by SA2PR11MB4972.namprd11.prod.outlook.com (2603:10b6:806:fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 11:20:34 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Mon, 1 Jul 2024
 11:20:34 +0000
Date: Mon, 1 Jul 2024 13:20:22 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Adrian Moreno <amorenoz@redhat.com>
CC: <netdev@vger.kernel.org>, <aconole@redhat.com>, <echaudro@redhat.com>,
	<horms@kernel.org>, <i.maximets@ovn.org>, <dev@openvswitch.org>, Ido Schimmel
	<idosch@nvidia.com>, Yotam Gigi <yotam.gi@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v7 01/10] net: psample: add user cookie
Message-ID: <ZoKQ9m9QXy8yIvhh@localhost.localdomain>
References: <20240630195740.1469727-1-amorenoz@redhat.com>
 <20240630195740.1469727-2-amorenoz@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240630195740.1469727-2-amorenoz@redhat.com>
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|SA2PR11MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: f869445e-058b-4968-54ed-08dc99bfd361
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S5jSW8+3TmXDlJicuroED2JE3OFlc6JKzyfCvkuRnuMhq60z2Vn7RZK3oqhM?=
 =?us-ascii?Q?YxhKQE8KoI463iUkitzV+gpNjzrld/2bzWGON9IaV697+AiS1S6ONtIGkbX2?=
 =?us-ascii?Q?6HkWZU/Ur//HYS6XOj4I/4b6vz3G4PJlQh/yjTQq/pHgBJGKgLB63jX3Yncx?=
 =?us-ascii?Q?sCNBq+zvDcf6PhwJgnsN8IPmQRAJsL6XB1OHZsv+WU4hSZzZVPOhEk1aOU1j?=
 =?us-ascii?Q?QW3TmYy3OapYZLinx3MPG+pv5Vj1C0bBHKoPcVc8JeCYQ7psbKpvRpWBEaxb?=
 =?us-ascii?Q?Vl4/QUtSIquTZwFX3NWOW/q8roReqlkbjIGvKp1DFsP5/MbfEsuk4ZWkS79v?=
 =?us-ascii?Q?KMMeQrTWAp7JdPpghr//39mWjTeyrRqBLg1K4ByfwHYr8gYdlbmMArjhvZPR?=
 =?us-ascii?Q?XpTSDAx+D3nxSbiKnAd4OCb4f7e9rmj46ZgoibjZSxFMYrQAHi7FiDDCOCdM?=
 =?us-ascii?Q?7+xQOn/DaOTwZlbgzpxP1jHD3PYBlObRFhWRbiYoLWXWCXZizaBsIv5RO7RU?=
 =?us-ascii?Q?zCqxOuizHdk0WJqe4RobmFIVY5c2CM71FMf4+u6NbcEfnGYi41LFwUYq/083?=
 =?us-ascii?Q?aztv/D543cMTe6kXhwxMJSj7A2GUC3OEh53CKjECHW6rlx2TUnOmPSkL89kg?=
 =?us-ascii?Q?dvTg0N2PHXOgtfu2ILm2peWROtAq1DrMKzrjdvICKWFsvgy76W1hy0gvq07j?=
 =?us-ascii?Q?XdgZBbvc4K8d7+OHX1CNsLP6Sc2PoGIioJHkFP1hkWE1w7o8F4Fbn8ge2Mmx?=
 =?us-ascii?Q?d45K7bYFfELz5BRe43TtJxc0YPD/RLDEjGTBe1NBP0yNbK1U20pTZmEeOyGP?=
 =?us-ascii?Q?u70QU+d/aWAiZIYAYJR7jStGlXopGv5zcgGeKXZ8hyfbvz0QT1IgfzyubZfj?=
 =?us-ascii?Q?EyCDuKiB8woszR6N6ElEgD6DVCO38RIB7QEFXB+Las+Ek6+4xsHqQMrEUFhl?=
 =?us-ascii?Q?xQp4nXQlJKUOS8tTCG1bIemg0bJeT/suh72jqVx2K+T8mxdAhBJMse9yXr+9?=
 =?us-ascii?Q?n3bzvojIDAQpecOnIt+BqCgL+LhUQfz5EiCeJ5FVhiaipY6yBS6t0kBTj+JJ?=
 =?us-ascii?Q?3NF/H/jhWjeKiM54s+GzOWVy4a6H4yFFY9MSYy0xMQzj7Z4b7d5yKq1J1sD5?=
 =?us-ascii?Q?QlgkBgcLfwI096a1lAQThC7s5AXIdPeZcw+J8FHcQ1IH43S0LBDzRTjTkHyO?=
 =?us-ascii?Q?6e0hf7+eQiRNjaLAp1njiNlz4cNxlCxKDtCUYYcR0caRTL4hJ92iPjnOJrl1?=
 =?us-ascii?Q?mQqZ7Rg0O06uI/zdc2Yd1dxVh81t8S8OQG4RpnaGefDba7tbqGjUn/RhtZN0?=
 =?us-ascii?Q?OX5lE4hchOK/8vO6u4Sua0MxzKXUm2cmVCgFQyCuq9G6LQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wnxE7PqPWtrJq35EFwXQPCjjSlAvQoghNZZ8fU3wWkZ78SPAyNKkwod54OSc?=
 =?us-ascii?Q?k/0nDzRfzARdYQCDaasedqx+nNFc2HW4qOycmKKj/g7jGtRRKlEeW/zz0AEr?=
 =?us-ascii?Q?SKQoIP6iazeOCqKJZKPWN3oxm08iOsDoAVKL218tIkrY1gXj6QQRq97zASnc?=
 =?us-ascii?Q?Z/x0RW3vM1oyXAJgJVWv7oBVxaUu2tcYUrtKlSNU0U0UZfZ2ZibD2QZQPqOF?=
 =?us-ascii?Q?jKcZNl3NOFHp2gGOetxOhKbiymLE3PpdA0DoMhiXZgvJrvFLDwn8/E9h1S+I?=
 =?us-ascii?Q?QIG6m8bpXc076BFGFh4ySjiQJ0jipTN3W4GJFbfuQ/hUucDUaiYqKBV9QnR2?=
 =?us-ascii?Q?uQnw4IA0rcheW2nmtUkoblRZ7v+MADFgd8AViMc16BVgkMrDeWGNgRwCklbG?=
 =?us-ascii?Q?we6TpTcnOMBe/TEacUPy+qu2LJrbzYEDki/lvuuVXBp4L6XB8YP6JVdQu+VU?=
 =?us-ascii?Q?eulm4vedpZap8NxvaUKv0tNq+tT0QYbxfhqOokT+9UDGwr1R1xXyM+7yETJN?=
 =?us-ascii?Q?1wivQ+lbPMwQGKExMbqFtQzcavj5kInjw8sSk4tvvvEw8bgZeVY0P6NoyJhe?=
 =?us-ascii?Q?gGD4d/qnzGg2jCBddyBqu6Pf7xiLEt3DN0EXUKqG0q+EU4id1kOEcH7vcXw/?=
 =?us-ascii?Q?qVb8DnVHSgKGVFuBOt0U3RXnBuAFHDN/rvdVTgYP7wYtSsHvuytnbteuNDY9?=
 =?us-ascii?Q?FD19y0vH3G40XQN8sUe9YpuxB4Uh5kkkw4jXSXweHo1F/LzdYNCMB6futhSO?=
 =?us-ascii?Q?bs0kuPfwQiMLgO83hG0MHCfLH2RlXApev9Pv5NApqjoty69nDbdAjKe0oP9r?=
 =?us-ascii?Q?7fycSbQbTfGiz3h6OKAeTOEfQQ+aXhMJrJxUssa+AS4JBp+zmyHmV4uvPF1b?=
 =?us-ascii?Q?o8fGWP0TXlIVEIAFp/Gj+Qn8YetiHVaisCaUir4c8vlvkE/SouQuLH9feGzi?=
 =?us-ascii?Q?bYbe8wMswxDSk9oyozkhkRry+wGqbEWfLuX5VkBTok3UOrful3kAidTu86HK?=
 =?us-ascii?Q?ZoflfOruKbMupYDE0qCxx8McX42eWXqJozuAj3aOBmxYYWNKuSFXxhhCX99b?=
 =?us-ascii?Q?k5IYuQgBCsgLvoJv9WeQuufzMR4Q4yQ7dTiK17uMWMsVCedrNf3MRBpscO1q?=
 =?us-ascii?Q?OW2tatxLwy1nLMCymuoNEVzGAQi0axTc0FIyvQyE7reX/HHMe5jTJJU8oFaH?=
 =?us-ascii?Q?CfFX4cIWu0bs2R7x9nQViqwhSQtWZvkqgnNFBL1nHcasCJAPNt3Uq7MLdxy/?=
 =?us-ascii?Q?tjz7Q7H3GNdap2BRxbXUHaNLQvDUZSl/D3i5iS3AM4d0E3RKPbTi3r7y+3T+?=
 =?us-ascii?Q?uXhw0s2/wVrzmGn4nFJIcZ0QPn5qwC9+LTQaUj54TavdInwmcAKWRs0ypSHx?=
 =?us-ascii?Q?6N7XTnj8wHszhX4ugneoPlqV/IOKPmGVvA4lDAhIwzyniOJuPj2awwFWOUHu?=
 =?us-ascii?Q?+OC5kJDN18gE6zlIaLyad/lwMoKXC8O5EdVG8utvD5XvoCC/rJ2KhiaVy2v3?=
 =?us-ascii?Q?uJkPKZ4eItcYk/2e/hi0StRMyCOOKyI5wE2bWeFr4cw7AUG5uqfVP1Kdje1F?=
 =?us-ascii?Q?yCbDQhyfhnwpnRmavdq9766FrjgDAb84OLT7Bq8INFRLM0gFdK8NyaeDMyMK?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f869445e-058b-4968-54ed-08dc99bfd361
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 11:20:34.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jluwf3hl99FfvR1nV34k8ZPdHqCjrNAF33R4OMG1GxSYZX/rhXW3bFe12B74dl+3pi/AHKsMl/IpWq8X0pKeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4972
X-OriginatorOrg: intel.com

On Sun, Jun 30, 2024 at 09:57:22PM +0200, Adrian Moreno wrote:
> Add a user cookie to the sample metadata so that sample emitters can
> provide more contextual information to samples.
> 
> If present, send the user cookie in a new attribute:
> PSAMPLE_ATTR_USER_COOKIE.
> 
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
> 

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

