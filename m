Return-Path: <netdev+bounces-181274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A65A843BA
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9F14472D3
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779C72857CA;
	Thu, 10 Apr 2025 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PieddddI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE428540E;
	Thu, 10 Apr 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289455; cv=fail; b=db7aI9WihQcTmxHbKmd+YgWkctI5YLkuVlun8mnHzX+jwbVxtA8XXKNzix15lwEUEVMVKFxsjJsB9vpRZxIi/PYj7/nFRKS1GEpnDuFNO8lHN3Svl+nR/TpRKHj8TvmpOtT5JU/gJimgJJGPOfjhU07Q/wE0fMDgwlxgSe+cp4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289455; c=relaxed/simple;
	bh=FeUjB4NNexbE79Bv/NbDQJ8eaNQuGfVbdtCf2keShx8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a+wMoxanK6C0Nzo+RK0vZ/mk1bTguNJQ2V1cnVpmYkEoB+uTPEAqFkBldaxxSkemp2sJOdLh0NBjgSPDl/cGVlhG+yg1KZpCHlyRO86+2vqKw526DBPm/begEft9brApo2xOsTj32M5RYWyloLF5o1dhB0Zw+pqjlgVye7vhf1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PieddddI; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744289454; x=1775825454;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FeUjB4NNexbE79Bv/NbDQJ8eaNQuGfVbdtCf2keShx8=;
  b=PieddddIbTHIgaMHFqkB052sr5xYH3qS7t2lwpd2XV1KgKS0H1d8t9L5
   eUT5X+NvFcXkaQO1pE/GQDEsMg5DoPUh15KSIE9vXo/5+gEMq4w8Y/FRJ
   bQEvdBNEb7s7Tg1PAYUA6YT1PyzHF67uD3bzHkNYeK6gYosHDbcULD74h
   ZUKXJ2TTHeY41GcIsuMQyp9fgGXROm8c+ck8mZgFP6eY66vPkldZJC34m
   Ai0q4P01CZvmXAd22TWfGa82yAPPhgsqu5AmjpW+yi8BbbmD9aigdliLe
   AJXVPde6/7wz5Ij1ezZhWOTDNidhHFCEPtOCC0TTtGn7fCWBy5DcqW4al
   g==;
X-CSE-ConnectionGUID: CJqDa3AoS46jIPXayrmSJA==
X-CSE-MsgGUID: jVroervDSvCnzUzXfw3c4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="63350342"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="63350342"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 05:50:53 -0700
X-CSE-ConnectionGUID: WslnrgQuTZijKNEQf6s7qg==
X-CSE-MsgGUID: VDW8McMXQeWQG7nP5H7/CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="134073349"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 05:50:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 05:50:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 05:50:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 05:50:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i41G0wtp8eMiAl5xJ8e5AfW6s09Os/sQbSgEC3QV6qUjKUiMxfwpH5PRT8v/Tl5XeEOnXZM2XlSYsCjvo6CwzLsmVEFC6Y/N6sQAyZmgm0MR7N89wFjtQQRkcrLxIn31TAn5Jk8LBRCyGWGwwBBfW6ldXx/wZt30UP84uZS1/eKc1fge6hPXdLTnrKEHiP2zArhGUz6QKX8tI7jZLApaRjxesYzinHaDtr7l+/lxBatX74BjMA0JUMxanQ6cFP6X0dl+voqENMfsQIa86EFBlcLYbAuafIZetWutX0xuQMJV2LVezSd1Km3T401hQ/Dv3t0XM3nejInij4emjQ1gQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgBTtR0nky4Ckuph8y2fKHu4k/pTxrcOAb0AqX7WccU=;
 b=tM3VuolDqrACDX98IIlKTNbDkaJyCQQfx1ff7C+ZgLyyWONBOtvDQTLQtCx7gL5QfgYgD/UeNdkkOUWAjQzQbeZgCpTse+u/nCyjNNY5PqcCd1mIjY3u3qI11uUtyjtsvLwrpSQTJVfDKtAptM9awrxJZ3vq4ejk6QLz7C9LE9hgDjeVN8CblNEboigiLSuiyeCoorHBiAIs3WvhD6zqYC572hBFjzTwJ+L9kV9CHxhoN2d2vXTQJGS80FRN/qqxqapxqP/ZJGaZP2zvn6C+rer5ZAd8iJUxaCWrg799Ymw4jhfsHGmZeM6qw0wr0P+FtGlIDPTIaw7kTbW8GVbF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA0PR11MB7839.namprd11.prod.outlook.com (2603:10b6:208:408::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 12:50:35 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8632.024; Thu, 10 Apr 2025
 12:50:35 +0000
Date: Thu, 10 Apr 2025 14:50:25 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: e.kubanski <e.kubanski@partner.samsung.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<bjorn@kernel.org>, <magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>
Subject: Re: [PATCH] xsk: Fix offset calculation in unaligned mode
Message-ID: <Z/e+kei/tJfDkjN4@boxer>
References: <CGME20250409131930eucas1p22b304bf5924a9b3bc43a442d738ebef3@eucas1p2.samsung.com>
 <20250409131913.65179-1-e.kubanski@partner.samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250409131913.65179-1-e.kubanski@partner.samsung.com>
X-ClientProxiedBy: DUZPR01CA0349.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA0PR11MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5fae3a-3240-48b6-9164-08dd782e4954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WI7q1mdJdGfJDf+vfTpPyjDCoQzFIsnWfLQnZCICQkUAq4WgRuVj470uCbNS?=
 =?us-ascii?Q?TzOsd5WDvZh650GmI61CmJZ01iEaUyV/7QGcy3QYFhdf59LM/+P+pz7nZ9GX?=
 =?us-ascii?Q?gEqISVXehvxsW1BULIsMxaPixh6bh9HL8kdM7hHwn5xqmkOda4b+RQFxAAGu?=
 =?us-ascii?Q?QuQFdSbZ6PFgH31CMgz3cDmJ8Pq4s7VewuCuh2+wCN05JGbzLs6XIepRl146?=
 =?us-ascii?Q?DWxwzDwednmnWpnqDAsH2rIXmxWzWXl5aCRSCTkjD/iwYshwIeNI/IBT3KrF?=
 =?us-ascii?Q?oS4A4BpzAkcy9H6+fEIVgjU7quu6RObENhW9Y4YjbYbJ/CXiInR58zAWp6mN?=
 =?us-ascii?Q?61eKkTmRek7FJhktjwxqALcTHskE0FmOkk9rVQxXYT+xmdLARJy9+ROyVaKi?=
 =?us-ascii?Q?KCu+UlBgp7DHCkGWdC3CEwa2zvYc1S/AdN2iy/cFqnIDMH6QajqZtTf5KJ3V?=
 =?us-ascii?Q?SGSu84EGSkpxcgWLqeOQ+TeSdxqWT1L9JH+2t830IUtpdSOev9BaIvg0zRM3?=
 =?us-ascii?Q?KYAS5R1uhsHj1TXmDVFdytqwZeAlA/LaDKhDTuvw4oOMdoOblNwH2PAIU/OR?=
 =?us-ascii?Q?NlbiQ2dnSW1fZCPh0DfFBca+WkfE4l0K75k+QusZvkiuP25PTmqX8MTDKR2P?=
 =?us-ascii?Q?Vq7HSSXnnEGDvjyBQgDbk1df7l2deZqIb/Hi06E+kA2NqtP0dN9GCHRwfqQH?=
 =?us-ascii?Q?R7jYvVcL3OaqDmrSOorwxSugYJfCnCv+MckyxzwSwltLb2Ng27WTnCQqseXb?=
 =?us-ascii?Q?7PXAfFRSWD2BlG0ygxB6WJ35xoOidgiBnP51i6cZVEDy9C0Kbjqp5DjPpysr?=
 =?us-ascii?Q?E973AI6UYchX7Ykjq6r3gv+gHYFXy44b68FS+ygsdSDkYXLftBYfyoWa6Mc4?=
 =?us-ascii?Q?kwVXETN5/3oikcsWfM8/AY6ocVZsEl755kaeUYyZQ39iZMKUCw6KaNRJeYfT?=
 =?us-ascii?Q?hm9/ovSqjfK6zojOYuNyWLK6gjH5cAVYDpPUA7bJZ1PpaHAGKadWl415PGQO?=
 =?us-ascii?Q?sg7KRnkNhbfrhmTcc7SntnifdQ3++LmsgXPzz3TvOHnOWkL8AkyoOakGT2/4?=
 =?us-ascii?Q?zn4ZXkz1ysQZWucEfcln7+m9b6FlktVHkYZUPEtIin7g8ewpur3Lr6iJi4GQ?=
 =?us-ascii?Q?svJ0UIgSmcPd2M8wYGq+bLZAGngMgZaO3V5kIhcOkPtWsO9ZaQwRORFEJVfd?=
 =?us-ascii?Q?WUXJE/u/njFxioieujqVmBO5YsOkqin5lChWeam+D6CVlib36RUXFj1cZe29?=
 =?us-ascii?Q?nBWqLbhwbSDFah0RB01qhZ+eYU0ELQ+aBKJi2/uW31b5gHBSGLR+i9cHbgO2?=
 =?us-ascii?Q?FUGOH6+oBLeDEwRrlkxoA30JXENL/KIrPsXxZAqvcSpXQqRq9C0UX+uhNY2E?=
 =?us-ascii?Q?BaHsgPSiGiq6LYyBBUZK+LMPbn+n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KajKygBLVzlovgF7I3IGAn1dISfOGsObotwU4Fc7SSx/WXYlbDRERERvRwVB?=
 =?us-ascii?Q?YbwNgqqDNn9WLHnrg7fsPGHB/430aI70JgJsL76hx1aY63EsNpcfQlEGVtij?=
 =?us-ascii?Q?4s9P7m3wXl/E7NoZn+YsXhL31/nr3quPwPOJQAfl3xAd/cFgRUKKZqG6cvk4?=
 =?us-ascii?Q?62O3R65A4ONjIUyIeLLBgGUu1B5k+vbpPm40vosGOT0cGYlEzY2zCHRkiyAw?=
 =?us-ascii?Q?p0w6mA8aUf9E4TrPKVwAZt6gDgzNW7xJxql8hVMDJfK93t064BEJyDrpLZTi?=
 =?us-ascii?Q?3kIpz3nsDPiQI4QVanHVVT41jOK/GZ+scOBea92R+SKB+lKXwm3atCXXJF1H?=
 =?us-ascii?Q?41W5shs8A+EGURLYhpqJ8qdFQcw8xDhuA73mzSB0JHGcnlsrRnU3CHjeiRVZ?=
 =?us-ascii?Q?8XfrZIF40cNebAP/jLcAZyXeD8vnKTUbnIWZQcsajzo051vYD55HP2rbHMxH?=
 =?us-ascii?Q?39wOPrTGs8JhJ22VIwUnkA1oxRDHY0FUXaHyR8UVsxhsh8D9I4BmcxeuIS1m?=
 =?us-ascii?Q?byXB6y9HgJhIVJd0Ayvq01Bn28CekcDUC0xt0+MFsreIat/KRsgBZCBaSS3I?=
 =?us-ascii?Q?CNxrJ7Zrjlx5wOWFn+EQXMPg0a5G2sKFXAh3rDeKCKkxzBEMiNcV/2RUS7DC?=
 =?us-ascii?Q?Pr7yBLyW1OIfQ0r5yYAeDr8Q1jWc9Z0SvkyGDCKRQoWNDvu4DrOAX7BAndpv?=
 =?us-ascii?Q?o4AmxfAsgIlgMGYI/ZJ2GAEpKJJ57m6E8nlS1Fjoo3lOvW5rI0jES5sirntb?=
 =?us-ascii?Q?jyXsUQcw6Fbd6i1Qiv3nV7rUzDR+Ghf+W9YGoqLdWwD2eWb9mZEzgZHnbabe?=
 =?us-ascii?Q?6IHSY1oRXTGTyfVa506bte3XYFijRoSTtj4QWCj2tQR4YhKLbfjJ2D1wq7uo?=
 =?us-ascii?Q?zx9UBW0BbwAsSh0qOyaRZ8LurONUzvBqESqkqE+QJvoYbPt3Ke+8Rh1kI7GW?=
 =?us-ascii?Q?V26HGP3SMgJ6m8erAL8YWOqRbBfMo1BM/CXSdtttNSqrbnUJkLa11h3Ljwnh?=
 =?us-ascii?Q?a1AoMhcPL8342QAMzp2BJcqMPrgFgfsDrKHIVTRnHKqUPjh7VgnfgxOIjFIw?=
 =?us-ascii?Q?A7j3QPL4egyjAX6tapOh1GGLPZK4KPdcF/02aFrjCyru0EU6/94+eA8rmoV0?=
 =?us-ascii?Q?iYAJ3zkI4eWuVJElCQmu+MTK4Ph07kbWFTRWuk8UZve5r6KO8Vd9al4/GBoX?=
 =?us-ascii?Q?xpCadhhTJfK3YNMBjdZ9+zfHsIsmhgTx70kP7DbLUq0idnOTr4A+qs+xFeQH?=
 =?us-ascii?Q?t8ELzHCMTFI5u1SMXRX6aHlAuEDnVm/P6JKNLUrHyvezLvr9edaHa4fsO5WV?=
 =?us-ascii?Q?GVrGL0bS1WVRegwChcgDhZLMmLMlgXhHbJgwlS+MxDq91PB5qQ6B5N9bPzHG?=
 =?us-ascii?Q?f2mw13RYOCuRQkbsHHuHjBMz5vwWJ9Cgp11dh2BrHzCtX/a6cXom1jfXf+i7?=
 =?us-ascii?Q?ZyyhCVmPPfYS6wamIElsbzT6DoEyVmRrxsQpgrVgzGteWR9dO3Y/XGTi5e8h?=
 =?us-ascii?Q?4vZ1VSHdbcgc3qoKYwmZzcV2AkkiyMhMTZ4J3s36vD4Us1wZEkG9ojkpFYaZ?=
 =?us-ascii?Q?uZ0HNr+QhButc63Ao3kJyJv3eE4NmmLPzPniye/WM//sebxnP8zAEhGitVmf?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5fae3a-3240-48b6-9164-08dd782e4954
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 12:50:35.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEE2oathi2SQZQhRyH0GshrmLhEuEedSXP4oOdY+H2rBytehKUZZJgrO1C9c1HwY7FJnTs4nGdf74oCPo3CRWvkU4toZMcDdma7YCBwdR2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7839
X-OriginatorOrg: intel.com

On Wed, Apr 09, 2025 at 03:19:13PM +0200, e.kubanski wrote:
> Offset calculation in unaligned mode didn't
> match previous behaviour.
> 
> Unaligned mode should pass offset only in
> upper 16 bits, lower 48 bits should pass
> only specific chunk location in umem.
> 
> pool->headroom was duplicated into offset
> and address of the umem chunk.

Thanks! Same what Magnus commented, you need to target the patch to bpf
tree and provide a fixes tag. Here's the format that we expect:

Fixes: bea14124bacb ("xsk: Get rid of xdp_buff_xsk::orig_addr")

and it actually is the blamed commit for this fix, so just paste it to
commit message.

Also, we prefer to use imperative mood in commit descriptions. Go through
https://docs.kernel.org/process/submitting-patches.html.

> 
> Signed-off-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> ---
>  include/net/xsk_buff_pool.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 7f0a75d6563d..b3699a848844 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -232,8 +232,8 @@ static inline u64 xp_get_handle(struct xdp_buff_xsk *xskb,
>  		return orig_addr;
>  
>  	offset = xskb->xdp.data - xskb->xdp.data_hard_start;
> -	orig_addr -= offset;
>  	offset += pool->headroom;
> +	orig_addr -= offset;
>  	return orig_addr + (offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT);
>  }
>  
> -- 
> 2.34.1
> 

