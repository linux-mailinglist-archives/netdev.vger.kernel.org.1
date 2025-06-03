Return-Path: <netdev+bounces-194788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F05ACC769
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 15:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139C418944CF
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6997522A1D5;
	Tue,  3 Jun 2025 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xv4GZ9QM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB442745E;
	Tue,  3 Jun 2025 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956313; cv=fail; b=VvDmYzpvhf4nzaN5EAZzzhG64aTLc5GikVTK8ZgG7ZhKznRcUyFg9RjqSmQSLfisYeRSb0xkZeni/64N+TlVO+ksXmGJRkxRT23/dnYYT+JH1Dxli9EPsQWvtrjkEIk9yIsYzkhEonHQWbu+7I/GtpWZo5uCNEL4UDhfO2WaqVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956313; c=relaxed/simple;
	bh=U+PWpTXbB5XxUahrehY0xkIPPH0M/edHxnWIWll+04U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cQjjKV2bC/y7M28Op0eJKw9VPO2/dlHDo4SmsjP4yZbKFvUAkBukxB8aDRz1edbi5cjdPDxuIm9Y2FfrIj2mPhUjzSLuC4X027hR47XsdQZIIZcgZwSId3mwaMlRy5JGcuofNq7jggBGw7uHyQukeHp88N+WU5miGwuiRndxbj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xv4GZ9QM; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748956311; x=1780492311;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U+PWpTXbB5XxUahrehY0xkIPPH0M/edHxnWIWll+04U=;
  b=Xv4GZ9QMlXki2bLzdB2e2+XMhGRgo7OT7FtTn70nfZ7Ha16VI4CMAYqb
   RO6sj6Zm4eyot2RWZhvqwZAX5cOZhYg32ohDnczXnSFVUFRrXnmzSyFj0
   SvlL7LNvA/BBZfORTGXtF13oT2drdMvNBwrcG/7Zttxz4Sy9oZKf0tCXH
   7OwBN1FMkHRYG7+pIKrIESXd+m3cQMoEm/qf7PtL8MC7isLsbcwVATDoR
   D/SJzwzFRHUJnPjYytrH5SHRf0g9SNL06Chg9ZUK5ZrqasO33HLfew37r
   OHHnWF5UrnzxtLU249y40LJfcmJw0B94QLxQCOznCdr+CWwVyze1DVVNi
   Q==;
X-CSE-ConnectionGUID: 0ftOQYjQTWmbcU28E123iQ==
X-CSE-MsgGUID: oSRXgmnXTGKNEDeJneUDgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="61613565"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="61613565"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 06:11:41 -0700
X-CSE-ConnectionGUID: CTfvmYNcTEeVNeOCBngZcg==
X-CSE-MsgGUID: 6ak5yn25TOeU1B4Tv4l4/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="150140320"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 06:11:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 06:11:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 06:11:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.41)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 06:11:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3tDX5+EZaqsubYIdUv+EnkwUFeEnsFQ+d/94fWjpsHVAPVQ6Xog14QUNW6on996XftyE2NFmIHqcnoSVs/6EVzRYO85uDcxWSZV9tjN2xfefcQlkk1wmYdeD0AXDxNxHeyIoq3ZU3LTd24TsnYxsmYFpOKt5MzXtk3fuVVaI6nYEUbjP8uRwkeDPk5ElLmGEBReqP2mADNL5VrB8r/Jn59hlnWSW+45j3tVKgwl1k0cXyrTId6/YVByAwAYShr/rwdGcGNXFiB+l1DkIbly7rF8GWCWrshCDym0jJdR87XgVJy+YYxn7HdN4tGSoTcMdKDrzD15yAJw3b64zEn0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aS6dA1P85cnUueYfE0+nbaBz4SI2LGReqsGRMLJPqno=;
 b=a3oVSgHQd+xhNyK+O6TiFm+d+ekkB6Nf9ZfYIm5+0/gOKpnGzUcxMeOlzqd1DHB28h80qSit+mehpNslHe9HSNAEBdaUSbjiWbNSMFkW/QCx3GYtz+iu5pmyzfD7yw5CVgg+Wat2viMhVOozKTq3GqzlLRtFU7OY0L1B3++LbTyMBvXmYMs6fXdxBcNGsPwXoajegJqcDHZd54z6rzy0KubFq9HxPZfXpsMlQD6eIiAKXKeAw6nFOasesiGzxGHJ494cjxrOuAcATby2K88PHvR6+Zz19Eka1rirFFC3GmJBNSVdPepDHIsc/6GXw0wYtfqIFvuPNxNRfiH1ZfEFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA3PR11MB9349.namprd11.prod.outlook.com (2603:10b6:208:571::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 13:10:56 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%6]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 13:10:56 +0000
Date: Tue, 3 Jun 2025 15:10:44 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>, Simon Horman
	<horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>, Romain Gantois
	<romain.gantois@bootlin.com>, Jijie Shao <shaojijie@huawei.com>
Subject: Re: [PATCH net] net: phy: phy_caps: Don't skip better duplex macth
 on non-exact match
Message-ID: <aD70VBO4EZEUgLOW@soc-5CG4396X81.clients.intel.com>
References: <20250603083541.248315-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250603083541.248315-1-maxime.chevallier@bootlin.com>
X-ClientProxiedBy: VI1P195CA0077.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::30) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA3PR11MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: fc98151c-2805-4eaf-d3d0-08dda2a0133b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ix3WoANyb7gyrFI/lbpFy2aQK8n2hxJaZgQW7JmpUNlhY/2K7l7XsldL/93/?=
 =?us-ascii?Q?oKtfTl0+lQKzOQ0lIvIgWQED9BKhazy20+AIij1+3DVfCHqhsoMrqjeKoCub?=
 =?us-ascii?Q?+bny2xq/dMTDIPwZ9HiMfvv2t1XpRls5T5hCk/GnxDE2nQUzfVsj/fCg23Tf?=
 =?us-ascii?Q?Xgl/3/u7oExbxPxlr3n7YZ91962Cc8Ft4gQK30mqpyWLB9QwyhTksS9fz5PP?=
 =?us-ascii?Q?6yKkfqHTvWiqbiBymwPNA57RxHlZEx4lwkgeJY/rA8F81aCRC17LDwUyAm3y?=
 =?us-ascii?Q?paIJSeu92dHhuhErlZO5S+si98fFZNAIAuaEOTOsCjGMiVcID0pRALK4jTaa?=
 =?us-ascii?Q?JxYrp8e+ihPdmSvthLHRo3DKeadkifVKK5BkqdOCAnGHI0DSaA2BadBjeACs?=
 =?us-ascii?Q?9KN3O1jBu3TDnCiFb+EY7z2H6LvEhzLkea0kocJiSahyUJAieoPuR+XV+BHA?=
 =?us-ascii?Q?RG/vT7/+Xja9zwLdQOP+bqpHioa9W+cSloynournSMtU3iWmXwL4seK8pn2V?=
 =?us-ascii?Q?joiDuf4mr+Hsr9NqVnyiB7jGG8LijBPRplVlKAu5klnIAhjS/xlEf56/3/b6?=
 =?us-ascii?Q?6O9+a//1hcyVEAO3fgsp4CvHvvrL0GhZRSjOQYHv7+CgBQDn6r1cdiyNgeJj?=
 =?us-ascii?Q?kUVr8i1sH59/1FQIlvcBykur54JE/e3HT0dmfGPSFVvWE3FbR54fOuPtOSrg?=
 =?us-ascii?Q?xxH71jN+McxZ5gAqx3lBO1J4/LYmZZ64p8Q0dkLB6Kf0juEGXyXeqsrUk9d/?=
 =?us-ascii?Q?NU2QQ4qwGaKrDn4OQRgJJXrjdzrDetlyAugFjQjN1UZCrw/MHoFpDY5h/eLQ?=
 =?us-ascii?Q?lws/+ncRiPwGU7esBWmIa2UWXl+7STY8YcrSklvzn3gMRTz9XtPYEFKsvdnK?=
 =?us-ascii?Q?O0HFOOlHprP53hNK/VXb2Pn90NSFnXzGLhuyiq3PIS0Albsn1FYegYc/TYqF?=
 =?us-ascii?Q?C2rgg7Ca6jGTyM17JjKRl7zxDypNWjNeKXADL6TGVdZCUbSG1ieNeomU8XBq?=
 =?us-ascii?Q?0zEAeNya2zP0nO01CAe4jqi5In/jJJCuJOqLt/ERVXyjswJfs4YOa23Q2mSz?=
 =?us-ascii?Q?K7Aznen7oow6KC3RzbabaphqvmoJxnpcf1Ok5uyLdtRFqg6ndiYmZYfZ3Jak?=
 =?us-ascii?Q?rHah+llYXL6jdALQpXx/lgCtWWqIcZIRqc6r9h5UkjPt9oE0iav54dKYU6bo?=
 =?us-ascii?Q?DVfSOP43gX74yvn0Z9Lh3Sy5mGosik3VCtUcAfQKaryLu7CXvxyOsZyQ1o7l?=
 =?us-ascii?Q?QJET9cUAAuY+3qEac4rhnwt2U4y7LbTdDCK3dJ1M8d+svnnlphJ1kEGMZGOi?=
 =?us-ascii?Q?LcgklhzUGAg7OpuzieDSshRMlwqZG513GXNlYigJ6zF691pE55TIksFByKqD?=
 =?us-ascii?Q?oxjaqbMC9SbkN8CdL0QW3inM4Ezt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a4eS6gD+7RWs1bgiXCP1mgwGxBL741U3o4s5lt0fdZeDJYkaAOAWLTawRTDv?=
 =?us-ascii?Q?5aakL4kp6j2EJwYrze6VqZLdTbrwy+8gxzwhdj2LXJVEYqXRjBdZbJWNhmFv?=
 =?us-ascii?Q?5QYSPOSxeJTu3nFFiGOER98576KCVoEv2Zp8478JkrSgT30sWtWHELS4c5ze?=
 =?us-ascii?Q?t02ntlqTNx1fQh9yhDvW1UqMjioX6SeaKkZp/ptCLCZuKW81jcu7XgQq/gA2?=
 =?us-ascii?Q?GGZBI35BMkz1imUPMJ2pF3N/1FHxUgQuzkjQmpzhDJpTi8sLu+YJ50QhkWkw?=
 =?us-ascii?Q?1+JY/xOp6dGzBfITgEdYuUbPQSGaBuOR2fWBmN1qr5fsw1dyIujDQESz6wm3?=
 =?us-ascii?Q?Yhkg25gz1nm6uVAW3UPZSISN26r4MuBv5J+gl7YcrCj11zN1AojtAZMCynm6?=
 =?us-ascii?Q?nukumpEvhZ4UwuX9aURC1YE1tmKIpnUMPjMH+jBx89STVmNW7+lrlmFLbPsz?=
 =?us-ascii?Q?WE3WLCmpX86wc5YV9pzm4D85XaEi+pnTxX7/KKkmBlHBdrLp+yQc08br4X9O?=
 =?us-ascii?Q?w12ZD1oOVficnHU0AR1cWF+GGlJ3OZAaXVFXuG9jI+0c5PfrvlHdNWxWboXw?=
 =?us-ascii?Q?9gjnYD28rX+Tlye4+WPAvRpXeo6oflIY2qR6kx4AwwUBmjTpXXIAU+qfufXl?=
 =?us-ascii?Q?LvAJlqxlgtmoqvhfvR0rx263O3ABG6HCMSWijwQE6NURmeZMUK/3c7Cyb5Yf?=
 =?us-ascii?Q?45/O6dOr+ifJiPo3Bfb5DI/ARKkc/otroJh+KxWfWYHKvt72c9lZSs0faPNg?=
 =?us-ascii?Q?JZUArvViWpVL78dwWlU4KPQ8FB3L08L31p5Jth/VmS/XweN5pCQP2ujs0/Bu?=
 =?us-ascii?Q?tV8BApCXniS4eOjmzU7WmAYI8P5oYiGGe9B+nGjhp44zWHCMd7+bht1Pim6B?=
 =?us-ascii?Q?0xRtMJPFKBlOmgQcklComkadZ8r0Vz4iOSGkYvv1fBMLxrLlcCewAhKWkev0?=
 =?us-ascii?Q?jM1FKySorydiJF7h3wVI8o5HvvMXoUiszT3uzx5RvOJIoPQ0+Lr5ApH0rb66?=
 =?us-ascii?Q?aTpHCkKjCaghISUcIHS97CCInrgLV5PW61EzS04P919u6NncAIaJJG6nZ3FY?=
 =?us-ascii?Q?NrC5uruGU+6QjZqe4TrrbkiOsvkMkPj/Fhcb52zJUOa9DLy7Ueiix3FPFyMW?=
 =?us-ascii?Q?0cbonBNULc3cNlrStovYwbjE1bcll9YftV6FwzggLJ1dcMPDt9i+gGYqeZEy?=
 =?us-ascii?Q?mS8wosqtqoBSDt8WaLGT7FytUp6PQH86xORbNjKiLIrT53jUl7zzvtDkvTgw?=
 =?us-ascii?Q?d6gSVc+HBIqBagmWizN0/ZDg9JkBEWGse25kYPspxfX119KzWbxcPcLzC5MJ?=
 =?us-ascii?Q?wzCmHzQ+MRbmKYXzWBAFDl7UtkHBap+NUYTR4lrR2PHX+U7uzSWHjJ4HF23E?=
 =?us-ascii?Q?vtlKAH3mycWBXcwkp4VMVRPemB1IYt+mcQIuKMUeDXKj1vU5M1zn5zByCgR0?=
 =?us-ascii?Q?H2gxKVPlq29s11llr3UGyCjwv3crRyx/f9Auol82mDILS14oO81ku4hGFTnu?=
 =?us-ascii?Q?zkHfLiD/8WC8cKg+YHwPijqyvGTbRuUN/F4a8MRIw6seyjtTJubcpHQdI4NT?=
 =?us-ascii?Q?2JUmZIm9wnO72CZTTNL2Dj4mlK6LAOzwP0Nej84yG+6xCOJApsxt1g6kfbgD?=
 =?us-ascii?Q?A247AR7IsgfDt5jTjzAbyN/d4YLEJaAh1M1Ku/S4WLHPpnBXtaqs1lFQLfbG?=
 =?us-ascii?Q?hfDl5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc98151c-2805-4eaf-d3d0-08dda2a0133b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 13:10:56.1985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53/uyZzmWL9pz/MLkEtu+4UIHWdgIB9q4BAynF12nyjy7bQWEmVcVrApLvHiDjwoiX4JyY3OkoGtGePMFQAsE7/7KNbOsyn42K8cctvoCXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9349
X-OriginatorOrg: intel.com

On Tue, Jun 03, 2025 at 10:35:40AM +0200, Maxime Chevallier wrote:
> When performing a non-exact phy_caps lookup, we are looking for a
> supported mode that matches as closely as possible the passed speed/duplex.
> 
> Blamed patch broke that logic by returning a match too early in case
> the caller asks for half-duplex, as a full-duplex linkmode may match
> first, and returned as a non-exact match without even trying to mach on
> half-duplex modes.
> 
> Reported-by: Jijie Shao <shaojijie@huawei.com>
> Closes: https://lore.kernel.org/netdev/20250603102500.4ec743cf@fedora/T/#m22ed60ca635c67dc7d9cbb47e8995b2beb5c1576
> Fixes: fc81e257d19f ("net: phy: phy_caps: Allow looking-up link caps based on speed and duplex")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  drivers/net/phy/phy_caps.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
> index 703321689726..d80f6a37edf1 100644
> --- a/drivers/net/phy/phy_caps.c
> +++ b/drivers/net/phy/phy_caps.c
> @@ -195,7 +195,7 @@ const struct link_capabilities *
>  phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
>  		bool exact)
>  {
> -	const struct link_capabilities *lcap, *last = NULL;
> +	const struct link_capabilities *lcap, *match = NULL, *last = NULL;
>  
>  	for_each_link_caps_desc_speed(lcap) {
>  		if (linkmode_intersects(lcap->linkmodes, supported)) {
> @@ -204,16 +204,19 @@ phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
>  			if (lcap->speed == speed && lcap->duplex == duplex) {
>  				return lcap;
>  			} else if (!exact) {
> -				if (lcap->speed <= speed)
> -					return lcap;
> +				if (!match && lcap->speed <= speed)
> +					match = lcap;
> +
> +				if (lcap->speed < speed)
> +					break;
>  			}
>  		}
>  	}
>  
> -	if (!exact)
> -		return last;
> +	if (!match && !exact)
> +		match = last;
>  
> -	return NULL;
> +	return match;
>  }
>  EXPORT_SYMBOL_GPL(phy_caps_lookup);
>  
> -- 
> 2.49.0
> 
> 

