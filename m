Return-Path: <netdev+bounces-173978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A66A5CBE8
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACD53A55A4
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7211925AF;
	Tue, 11 Mar 2025 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LC8JEulF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A32620EC;
	Tue, 11 Mar 2025 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713475; cv=fail; b=BCPbOOz1f0+7oDt1WKbDLQmlrmBRVhdOuFWHl9Kew4Uu3HqeBWmn5drzbvppEvSKz0/S2zqc3zk8sVkSFvSm0edt8Zx5aLoTiOWPMN3yrKVoHQqlgjt8O3JigvzE/Ir8wX11/mO5a4VCZDW5iX7frIVDBQcjE76gFWJ/RvB0pJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713475; c=relaxed/simple;
	bh=rh1odiuv7mLS6JZEFJhPBe/Gnf1C/DOVWqNnRodDoSk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YD5ioHXvyi2HIitOjqHEopl1szLkuD3BIv8vguvixIqMOfDbZdzn9PDk27i6Cs6iQ/0/JKNfA7oYsY9ry5YcxmO9pNUBP/v16MKAMda5oU0GEheMs8Hq3eAViu84ZaUd0Gpsa0simVzk1f3JZCjLfZaoQv1waWvEjAw5nSkK2jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LC8JEulF; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741713474; x=1773249474;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rh1odiuv7mLS6JZEFJhPBe/Gnf1C/DOVWqNnRodDoSk=;
  b=LC8JEulF8iTZYiXCpi48PRc26Zm/bR2yVEQvTjHnT2Y+H75BnBXhJQnN
   FsbxpyQCIKhqwE9bS6hTrWVKGi7p628A3iKkdUQqtTlzDBvOgDIW95E1S
   uNW9jxfyEhR3vRnIguU0HcK2NBemCoGk/ZvDAaRz9qQF2etdaCQo5BFDb
   iqC9zKZ9BqxvDH3gVHIdGhbWanYVkh2NLRhUfejmZmAmph//R4/0vmXVE
   GGB7eEGq+TbNg97TW9UQL3QOsdTn0PfAc0WvDpukKziaudC99C6cSg7WA
   Nl0zR9dlvW2SUbDaJUw5WwzF25jKLO03vYBkY3lJ7GdmA3SizBiCFIpgb
   Q==;
X-CSE-ConnectionGUID: N/ySZ4zNSgWfHEQ7AtNAXA==
X-CSE-MsgGUID: 5Rv4CSD7SsmDkQJutCSkvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42894102"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="42894102"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:17:33 -0700
X-CSE-ConnectionGUID: bZieyhm4TkKzpS5YbUcdKg==
X-CSE-MsgGUID: GD9Ju+J/TQCjsHINUcpaRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="124557692"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2025 10:17:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Mar 2025 10:17:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 10:17:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 10:17:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvYlx/sNU3g+c71Ntxzh/PTwNe9hoEjkpupefmFFSQkNrOM7+8ops2GqLL1tDwHtgxxoR91ScD4Gkp45peEe0MoWrAwCRwEyweev6gHIXaygBg8ZQxdO/RD/c1xa902blxZ2KQ/c4/XzxLDwCZA94fl6uQhMNvpYH8ASHlVHKdo3vB8DOfRFwGp43lybmm8Fr3LUDG2yDGLVbxqqRaLFpKaLhKHD17vvcK7IPE69G+BKrMTLzs/f2/E6hU6Uk87uYHcFfebER5DtXYfpEcAcanczzASIXDYjiebUFgljO68Gda47x1xifNPZna2jaHBYH7eFrqT/Gs7DfKIc1qBl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ereIeE08ZyTJSDuunFNAAfebMrosSMHDXlpyBiT5/eQ=;
 b=JCBQkPanLo3UcMn9a5sQteS0q8MII9/htyHQ0M9Ajytj4030/6IXn4qHAzmalfNinDBNrYKdfnzjuCBJGb9pD8ykDe19HxX2N3JFJboQnZ1OH9fgCbmuPKKXOvUzDvni6/WTytpEBBB/gR0HM4epeMpqbGYJTIBohAHls+XVBB5dl7e5aBc1IqqwNyvRBb1WmnN1TY3GdeyV6yFCzm5t+MXUf4dcjIUr7HlNiUQ8UV0viVHhVd91SOflhWETMNi/ocpQhjaU8U6b+K06Ykg1FH504moSbaQLOTRBo21cQ3oYYnLoFhJwP5I3YLwX4Fwc10OatUT2dKKtOTgwYEpv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 17:16:47 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 17:16:46 +0000
Date: Tue, 11 Mar 2025 18:16:41 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Chen Ni <nichen@iscas.ac.cn>
CC: <manishc@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] qed: remove cast to pointers passed to kfree
Message-ID: <Z9Bv+cjkxlVHsKAd@localhost.localdomain>
References: <20250311070624.1037787-1-nichen@iscas.ac.cn>
 <Z9BuCIqxg5CRzD8w@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z9BuCIqxg5CRzD8w@localhost.localdomain>
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|PH8PR11MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: bfdc8d2f-0913-409b-3390-08dd60c080b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PNLgJfo9sxf73jhvGJFkFHwKQ72sYisp5r0IsOUem7mK7XoOsBv+a3Gq1UVA?=
 =?us-ascii?Q?dim1U3CO38cKs6ERTYJQtPeoqgnUcSKwlPrauUSXore6FjO0yiT5WS7tAdsZ?=
 =?us-ascii?Q?IRUzOzwjtWnXQ98o4FsJ7EtTHUc1GbnN58WqE84Qhrhm6RJqlUp2f4aD2bIo?=
 =?us-ascii?Q?kPqS+J6bvrQ9MWhvYOcMsMeh7Bnq2h+7933ifvDFytRiIeSLDSSHW16pRIpn?=
 =?us-ascii?Q?M8aU7yxLsVlrTHEP/ByhRZO7LAnxE0WlsXHLu8+VGypl2Gj8GxiiQjb3xxgb?=
 =?us-ascii?Q?pQBl8l9o10J1wWyEZf6G45mIleIIH80PG2/cSAl3mCHmHVzQMApMhY56qSGe?=
 =?us-ascii?Q?C4G7ymr56NdjFh49sX/HXEf/sKo0Ek3QhdnCeJnchbhWIbcxECcqyrChvaf3?=
 =?us-ascii?Q?6Y757zAlwa9loEUIU9N2dX8Giob056PXHqRxZJk3/o2YTUCVQRQYigbvL7ex?=
 =?us-ascii?Q?M7PRFje26W+hcG3D/3mDM///eOnB+Bq+ngTb8UK41QAJ+KJcCamLJdHRIvD0?=
 =?us-ascii?Q?w0Y0qaoh15QReir4XAKcE3a26sQoFPaahj73kOASIWOAnbjNXaGXO2LXNEob?=
 =?us-ascii?Q?uTGsahloceltjw9S4kz/9Kb97Zfu2jWsxPuVhCPh2gl4k+pM4MoWOy8gYj1F?=
 =?us-ascii?Q?uIisVv9Hs+QRSPyWbXj66DQsjFKoOrdqZLrnRYojj48yZsuhuU2v4tVV+oip?=
 =?us-ascii?Q?GhFWBnJXFo6+vyupRQHWwlTUrD/qANTXPS2fEUUKfegUWIsgN6KArz9DS0Of?=
 =?us-ascii?Q?tGaJjSs3JI7GLqUh+Usc1V8mnu67kiWJMwLArBXP67V4dqCofw5dbJd6gxiv?=
 =?us-ascii?Q?LvnzBBItMm4gfK05stAdiMEGL44ZR6/HyS0sBuBj7wqf2roJ7Uc3IQV5167g?=
 =?us-ascii?Q?c6lCQMBM/z2Ft1uKlPreTP/h+RjpuTXSZE1Ng6KfeNGSv3zLLeHZuWXz1uk5?=
 =?us-ascii?Q?Injx60j2HjK56p4x+SdtG2wsr6fguOzfD1coM2LBxMn3QmcWjIz45QVn1pvw?=
 =?us-ascii?Q?nmZ1h41cI2H9p1WFNy1rsNswRqTCmKsT0/QFu0VCrFXq6RakRmihDdIroW3f?=
 =?us-ascii?Q?Wfr7ZHQMrX7kHh3edak6U2B7HwV0WRrs8FqbOk8gAFJYzuYMzHQY7/MykO0r?=
 =?us-ascii?Q?avYU8B0YLytQBFjqeCiXp8d6ZufQkX1EY8oXDiHGonEl3Q45cQW1/iCaPF+l?=
 =?us-ascii?Q?0YabNFgdDfYfHXXxY4ViqRMYgfnJGaYURV6tnW8qYMbQQq7tb5JZnsZgfdXU?=
 =?us-ascii?Q?TOI1wPRx2FkWDhCOVHsHvCu4Rpum+SqHH7tVhNapahJXHdV1wSECr7RxZvbX?=
 =?us-ascii?Q?n3VMa6D1Z9I5jFvboCOPA5M5SC7odw5velfP0v+K5M0lhS75wpuOtTtPB1Yv?=
 =?us-ascii?Q?mPQG73Uv9eCYJlhox7UKf8ByNozc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Wig4n3gRKqqx7nCtoxCPNJFuAsG3iM0BTBsqisKu7Nl6kfKX0wIfVXnHNax?=
 =?us-ascii?Q?/OCMIQ62kR8g0V4J+AJSBwvke1Shoen+wB81/tzq+ul3dbNjij0WLdbSauvA?=
 =?us-ascii?Q?G1zL3oGUcWOw3T3Yi1WxGNWfqksPfiHvq7AGcuxa3ajo8/p4+9R5/Wmz6Y8t?=
 =?us-ascii?Q?RtcWUPbcyYSOevue3f50gb26EuK/uzKtlL0yKICORq+Lh/jg5lw+mzoklq0d?=
 =?us-ascii?Q?ae4h2IWY1Vp9EiS0w7Jf9m+h8/XgsrRJmgLnlR9O34lol5EXGaEKckxHCLs5?=
 =?us-ascii?Q?x5sbi2xFHcU2ENIvYvoI1NIQ7FY9yB3iyvVCiYgY+s1WrtwgKKbU6l/QIkNM?=
 =?us-ascii?Q?zhdtU6SJrXX3rdu6rJ9FBm9eSIpQdE0PGBjgqjH7l3tszsux8fOodmPGt+gp?=
 =?us-ascii?Q?mF5JkrCP4sWvWHRJ8ZSNZolFJbE0HwdjkYCiQWtNoLOvOEMfNVA6VCMgQRLG?=
 =?us-ascii?Q?SVpTWGt2iVMxdca0xHuxHB4S9dokclVwE5x3MBoGOHZvqRZpcSnMhr2lPLJa?=
 =?us-ascii?Q?uBCk6RM1sMvU2bM4/GAw3wmRB3Dc1+tjz5MS0ae8pjpz7nltVi19X6asKm7v?=
 =?us-ascii?Q?dHBdhOfXFkbINEjbQMiPzWmCX6BcJhcGAIMjccF7J8izvdXU2H+TITbdk9lq?=
 =?us-ascii?Q?7pdZwfTFRUKiGvV3toH1W6g2d8TbGY4w0ZjOf5HK6ALVA4r+u+qe4xMjnvsI?=
 =?us-ascii?Q?Cwqp7kkQjMK0fiaMNLNv7+2MKVfDyldEuWpXsiqsm30JuvJ1H/IMPEOlthaR?=
 =?us-ascii?Q?rhtywq1aBP0w/P23IlvNomqeX+MgaU0jhJGde7V9S/elv0hU4AfX1jSgIlgl?=
 =?us-ascii?Q?aFHwGNJQhvwlF6Guctu/DsDwmTQkFDPosta2lOo0lK5GHzWkbUf0q2EQKQJX?=
 =?us-ascii?Q?sMbFz6URc4ctj2ufnDru23bKirSQqb1QVU2aJDJVgJ4SEY/JNKoMTLnt0vne?=
 =?us-ascii?Q?TLptGxZmLxs5A7KQp0/cKDDsCjf/vlcMIwXYtu6b5YoZxPj58BoiBxbpxY5Q?=
 =?us-ascii?Q?inABJKLvG/um0mWSzufNlssFHWZtFTLngRNdjLTIzOgY2N8ZI5At74omnKUd?=
 =?us-ascii?Q?Xex1QuUDcDF2T7Cx5kmUcSUcMWSstX9TeywDzRhryoCOyGAi7O5ctj0MJKu2?=
 =?us-ascii?Q?r1O9lGQtkcCjSChP5NYE4DOcbY3QkPHWorunThuHw1LcIFz0b9+RzOjy6qXv?=
 =?us-ascii?Q?5EUZ/zs7ghhh1II3o6WpkZULiu5PdphL23Hol+ktW9g5TK6CIFkShGf+XcUX?=
 =?us-ascii?Q?Ffh6xsUcQyO/01txbCXAJnzdRmXvAFVeMoQxJt4277j3I+4EPeAh/uwOUHn/?=
 =?us-ascii?Q?rE98WSOBvAFd47pdeTgkzUNDb4nwls/F+QhHRHtHnzhDBKR6vEhSSVEhex/5?=
 =?us-ascii?Q?XjZ/H+cVzvIvzlqXfoCC0Lrf9Zb7UXoZBs/s3k4n4HgBf9j9bCIFUx0s3Z8Q?=
 =?us-ascii?Q?/GBFm3OacFKLxYpO/Am3HQ93KXYKCCHJvLJncVNG6oall2PhGbHCXZLAXKtB?=
 =?us-ascii?Q?x1l2vFMw7w9JqKVwoekIc1q+xiWNzZ2vKzxLyVutFAeOBYQdM6BiPdVulvIK?=
 =?us-ascii?Q?wDJ29/rwT5ydjOcQzIyf37iZYmcpV2fIFPJ6bohw2XUfmMuA3RO/6MQsInOe?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdc8d2f-0913-409b-3390-08dd60c080b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 17:16:46.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqVS2ekUwkXSPo17qKQjUgcFdnDxrNPCvZVYLpfxFMBCJ3e7HyjHf/b5+ljLKHQmxOLnmIlET3tVZI4JLsBwGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6779
X-OriginatorOrg: intel.com

On Tue, Mar 11, 2025 at 06:08:24PM +0100, Michal Kubiak wrote:
> On Tue, Mar 11, 2025 at 03:06:24PM +0800, Chen Ni wrote:
> > Remove unnecessary casts to pointer types passed to kfree.
> > Issue detected by coccinelle:
> > @@
> > type t1;
> > expression *e;
> > @@
> > 
> > -kfree((t1 *)e);
> > +kfree(e);
> > 
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > ---
> >  drivers/net/ethernet/qlogic/qed/qed_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
> > index f915c423fe70..886061d7351a 100644
> > --- a/drivers/net/ethernet/qlogic/qed/qed_main.c
> > +++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
> > @@ -454,7 +454,7 @@ int qed_fill_dev_info(struct qed_dev *cdev,
> >  
> >  static void qed_free_cdev(struct qed_dev *cdev)
> >  {
> > -	kfree((void *)cdev);
> > +	kfree(cdev);
> >  }
> >  
> >  static struct qed_dev *qed_alloc_cdev(struct pci_dev *pdev)
> > -- 
> > 2.25.1
> > 
> > 
> 
> 
> LGTM.
> 
> Thanks,
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> 

I'm sorry I missed that the patch is addressed to "net-next".
It rather looks like as a candidate for the "net" tree.

Please resend it to the "net" tree with an appropriate "Fixes" tag.

My apologies for the noise.

Thanks,
Michal

