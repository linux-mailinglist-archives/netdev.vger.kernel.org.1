Return-Path: <netdev+bounces-133453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E76FC995F5B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C8D1C212D9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 06:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2FC136341;
	Wed,  9 Oct 2024 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVfo55ti"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14F54A3F
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728453807; cv=fail; b=efFN7tykfWldI0/laZHrb64Kz4Tzeb0FRGEsdWDRy1oo/gpIx44Nn7Mv246pacZGmVgvjT2mRj5ZosrRPWdQD60+1Nbl3TP3+HSfFbWMZEbjdX3HB8gqTBM0Mryen1INl4KAM/HZaouujkdCS6EuP+jIikLVsvIFqfT5kFd4Sec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728453807; c=relaxed/simple;
	bh=VjCqg2LpEf5wTMA+ovlthSFKx8M9ToIXJZmj35qvdkw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AGlwYIMB7EaVcu1+N6JBdJYXNQ9EjtiXTTOPCO1Loz/dPcTDm87kgp79UgRUGMaos6yutIWsLC0ZmfxEAXtBKKxxjD4Zx0Rv18+X6B6lX/oNeJzGEbj2HvH3s1SfX0XpH6UBEZi/zYNAzuCixB951yEOVFlDHcKvvi5xuIxui3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVfo55ti; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728453806; x=1759989806;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=VjCqg2LpEf5wTMA+ovlthSFKx8M9ToIXJZmj35qvdkw=;
  b=hVfo55tiP4SrNbRaaqf7cGvmFI1QT9pvCxXKcznYShs66Xl1D5HDybpM
   CpdVszVgcos9Ibvyi5cQCOkTuMjQbtv6lhyCFY9Fm4G4KPv5/TLEMdlFQ
   boJ3KrtBHCfX8+TslFmYd4uKUtTbGaNpcfTzjTsGr4X4hSupRwrs+ydyt
   MbXuG9ZL2NPiO2R65qpf/UdVxGp7KwWkUfmlJjSAaPJhMoVCZca0v1Zvb
   D1aY0OZJMLWReYLcMoAzN6/Zrc2ebOmZt2P3+ONJd2aCCD1mhSVPD2Isp
   h7fajKcywy0H+p0dSZAvSTlNaYWcYGPaN55gXZSBtelRAlFSs7/EGTVvg
   A==;
X-CSE-ConnectionGUID: ifiJzLxmTi6CxNT5Jj98pw==
X-CSE-MsgGUID: 66sJs9CbSHu6V+4SnOvfIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27675668"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="27675668"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 23:03:26 -0700
X-CSE-ConnectionGUID: fhFsBxHOSIGsaZcQpeJG5w==
X-CSE-MsgGUID: b3e7nCF8Sme2zoE31j2FPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76562237"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 23:03:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 23:03:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 23:03:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 23:03:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 23:03:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfc4bZKASNX3gmgLBsrjVAHt7IGJpzfX0z0ZizFRI2nHL6mfu+HpftdKF8aFCbf9TkDD155Y9RserHe6ajus2r1bTn3i5lMyPoVYuH0Q3PvYcbeAOk7LOjdx3gOZgnON/JdwrhtaqITutFXUWIPFAjbj4c1fDlqqEacFIayhh3SZuvfdbhgM+w+6h0d5P7p589CgLRtmYo/fQ82KHp5Ba5+ipVTC3Ha6tk+H1s59KOLPgTl48IN4/6BlDCJi2xEIpsjLQzSu1ckkKUEc4NN7H6Xbx8/MK2lLfHgCTiRFfwtgUtIufNli//HE6N3Ys/ZuvI42qqSYhoRyo+r8jRSSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mv3can6Dh6Bm5hVVcKwUaGfWZNYNS10tEyR/+6MnqzE=;
 b=nhn2/1a3lD8K5mXnlQNgVPvXwEHM5Y2gVDE6Eo7/wxfiAjrvnDD5AIQkMrcRakaRIrykJq/0+c+31vmzsSXUpLmhRLOgo6NLBMMwVh0BFt24PiN15j4ApHaBPKeAkSnp0chkuyY84lxufjKaS9eJ6iXCXt7rOnh44pfVJCxjYiHzho6+IBgrtoQ7zYp8ALQefi/KLK0qCwmdI2KkcjaqX4u7LGGjTf4UBFdafTs56TidWNSRoZZVX6EafFEBxeLVMcAN4Eca+CdKbCuoD+89m3fk/FRKE12IlNRDmFQ0jkc6xESM2y2rtiKMNAIh6BRmGmzxVhNZfe6ADbOkFkXjng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB6352.namprd11.prod.outlook.com (2603:10b6:8:cb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Wed, 9 Oct 2024 06:03:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 06:03:20 +0000
Date: Wed, 9 Oct 2024 14:03:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Gilad Naaman <gnaaman@drivenets.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Gilad
 Naaman" <gnaaman@drivenets.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH net-next v2 2/2] Create netdev->neighbour association
Message-ID: <202410091223.b011d2e6-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241006064747.201773-3-gnaaman@drivenets.com>
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: db1f792a-5c7b-4dfa-5c56-08dce828137d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rr5QKkbo1QvJZzD3H1jrTDhn1//d6+W1vlcDAAi9kW7dVq3ADxzs9HwgqXll?=
 =?us-ascii?Q?a7MMoRJpy+cCmmPqkLl965d9U3iyT20RuK9UjGRLE83lbbi0toyEarIUf5Cr?=
 =?us-ascii?Q?fjx13YhJem13KPppPLrV/ckCmhUSW+G9eJm60UIGsbRwVUiaObaAfg/HTldK?=
 =?us-ascii?Q?vo7oaMcV2+CE310CYZJS2RzmB9Z/7aCvUs9cqe6hKWOzOm4hLK7fcQWvUfso?=
 =?us-ascii?Q?WL06/ivMXPxYvWBztQWvsajlUJPF2SG4J+dCd3azGv+geFc30Z7cWj3alNgs?=
 =?us-ascii?Q?9NoF57XlIFrBuSuC6Y4aQQxOQpBXb1ZEEhhemFJXip9sIZWlssa2h3E+z3XW?=
 =?us-ascii?Q?sbczgbsVpFFQ2e3os6f0kJO3PYBvWJUR2h8LAdaOOA2vzFGA+WE7Sar5/UOl?=
 =?us-ascii?Q?iFujcgugBWgrF9QPhWADccKAAcidubwvYfXgsz5w729eK+7Hz60C7xkiqUy5?=
 =?us-ascii?Q?FkpIJQfSJUkUCyG9gxo36/tQn0pfeSLAtwY9ZGxXEwnQWXgRtBpv0Zf7LbrE?=
 =?us-ascii?Q?LHNEooCKgiR6FnW38cfVQp5lC5r+O4p5+auHkoarmMyLkJEU2IZb2Jg8Kj8U?=
 =?us-ascii?Q?V5H9O31lBKVh+KXYnKVPKFDeKTxbTM+6lud8Rl+40p1A8wlNfhxgJIQhNP0N?=
 =?us-ascii?Q?MKRfbDvPaMPt3c05k8X+4OmnIdzW/DHuzu+bpYveF6nzYvG4R2M2IN4rNlah?=
 =?us-ascii?Q?SwyXFOVfMEdqoWLbmct/7iGb7/rJbt4qnwGFFFM5lULwtOxgmC77sLtTDScc?=
 =?us-ascii?Q?JZsVrHZW4nruwPdRXRV7Z1NGIlg5yvz8k/sGB3Je9Xfcdl8A/qBLGfTCZihD?=
 =?us-ascii?Q?vKAs6ks7npCpESufU+2zfEhfc0WfsquP5OWpZkqsjli/9xHT/yCoRl59B8uT?=
 =?us-ascii?Q?7EobOjcltLSFnptAJAuXNXKfZ4KmUOZS3Q/WpVzuGNCZX17Wu7hfKU8fJEvI?=
 =?us-ascii?Q?hQOf+WuT47qw0tOhgvfAWIphTd2DDO2NsQuK5IDGQy59bf2E+cpNNAUQSoqc?=
 =?us-ascii?Q?+tQUQpY+MwBSv4Kalr+c+Nt6fNfv8IRb/Y3OWpka8xk5TP/zcVuE3I4CKDjv?=
 =?us-ascii?Q?/QSxfO+ovofjR3Q1VAXN15HKjfkCoCkROTI6oObI2IjBPC998lKRcgfZ9Kad?=
 =?us-ascii?Q?0/XaKjXeQsG8e6b9HwCDFgtek0Oir4HdCY0PhVQAU2eralXkOOev2c4tyi2D?=
 =?us-ascii?Q?Rc8VWKdpeSr31RzjJHFuylHlRTn75/CJhZNyZJOVuEyht7tIrkMIabzCf73g?=
 =?us-ascii?Q?CDQTiKzs6fbr1P0wak48edwV4jWLvX9aWdI0zcyvvQIu7vgJZ9YmTcOPmqfu?=
 =?us-ascii?Q?AqU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s63KSp/7IPETPOfmedlLnC9PeJSjFqrZychAqt3jGkaL/Di5XJ7WKdJIbFXL?=
 =?us-ascii?Q?2KiZBaIzqR1RmGVEFpokhyNTJhlOTCUm5dFvN4U2+QgAx3XhSTpDCvt4v1E3?=
 =?us-ascii?Q?0ct4oqY+v1Wyg4b7aZoYtpSDvxlQh13oTiB0HAO38eduPDgt5EINME7ZKNBu?=
 =?us-ascii?Q?jBiR7S1wpwijbR2YiRmyzjASYkvpvRX7OrZJjSIOi2CTRE32nm6LUFnoQe+e?=
 =?us-ascii?Q?Egb9YnImUL9w8B/DZDebivFP2LRnZYA9yTV6HXAJ8PxwFY0PbdBepXVDZyeg?=
 =?us-ascii?Q?vkeIgB7pmzIUIeW0o/3eEq07sZzQTMxd67osV0mVQoRk7G0JTfHO0GDdgdSu?=
 =?us-ascii?Q?7BhM+r0fNFBdxT2uv/ZJ9WO0sBi4CiJBHPM2uw+tW4dtT1MUHZQga0CfP/dq?=
 =?us-ascii?Q?4OPOqqknw2+O0Ftx3DlavePEz9ZKPAQvqoziaJaHrXSUPoLGs82aYspoeb1Z?=
 =?us-ascii?Q?7BcFiXg7wcEq31qyQD1MIZsBkiQ5KYyktLk6u/nQfqil6PMj3XMloSQF9Xo0?=
 =?us-ascii?Q?TuY6KFf/UCMoq6vEuTYRoVKXRGfrYpihdOv/KLQEL74h0ItX7Ijg81RtOgGW?=
 =?us-ascii?Q?NxDxe0RrsEcIMkrGX5gw2Qkq/0PN7q9ZSnaciU2uILTRVcIC8hmM6c65glMi?=
 =?us-ascii?Q?Sbm7wHmUwl8WC6rnoUXZikVlVftBd/6wVCUDe4aW9HFTm0g1supj+ZYzcjxt?=
 =?us-ascii?Q?0f6j0o2RTZ88ktMjZ1lGZlR1mq9H4JxvteWzaW+LvO7xzGRC9s9IMu6ZKHaU?=
 =?us-ascii?Q?WAmmSXuRIRkBsEHxEWnI5c7mmyaZUgNVDzTVmkqf0d1nmehHA8mRPhamNwlF?=
 =?us-ascii?Q?B6JiZVOegnxPvX8xEXXKzt1sYs8lccHKhYSOdl+rkkPm2QDChgHc3EfH5OPH?=
 =?us-ascii?Q?QyGlaNdWbznkt496VXUUCTA/oRn6gelKhaG3TVvPzu7MgA6Wb5HhmRp1APTO?=
 =?us-ascii?Q?MuMoqFSHJWLarnv0/6l8IMCWEpEsAatQqigmZkLqgrs9uj8kJ51xeQhzVCpF?=
 =?us-ascii?Q?OYTZly4YL82W6KcwJxXLBUY6HIFIIpot+U4m5WPBQ1tic6OF7BFU9/eJybU9?=
 =?us-ascii?Q?Nl2FAuAHWpRvZh2HL5AcA7GJo9sn8KzIR1zBVIkvLhGZSL+uro2mkzSz7IVm?=
 =?us-ascii?Q?+wjiLuy5fDLie8ddQkFxoLBae4jRZO9cunbbc8+6Fy+hKGuiEeAwrNX9iDSt?=
 =?us-ascii?Q?tzL5wgqyGlKF5KaBbeWDSvFt/LlOjP/lBcy4LNPCkGWYmejg/351ADr7jPhX?=
 =?us-ascii?Q?jLGH9tS738oy6V+EZePNJfOTRf8k8xW43Z5UWET+0n0q5COYYnpleNlwdnqJ?=
 =?us-ascii?Q?Ns5lNnBw8w+SFBIOM7IQ8dayTe/1sb3Y7mSq6vCsJmV0knaCxwrDARHO+SWP?=
 =?us-ascii?Q?ypSUVBLhzgsevxAqNDZQjNbgqYvIwaewxbPIUt3JGNToIqof/068eYYnoWcm?=
 =?us-ascii?Q?VCiO7wf2fewOj0YyP7+26XFp5ytlkU/wxwS7U8lmyNjWsMbInMXohsQn1qjM?=
 =?us-ascii?Q?aZJCr9osMxM9GJ3i65Efi1WNNFs7m1Wyo6OdU0Q8bI1TmJyUohveisXo+hqx?=
 =?us-ascii?Q?aGNeyjd2ED7y6UAyj4Yuvsoaf0x8OzDNx/y1OC4+ljHqgZpJxPjgJMBJ7sMh?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db1f792a-5c7b-4dfa-5c56-08dce828137d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:03:20.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC0FPDzHp3N3HxzhaunmKrtEn6fuUSdlC8yry1M8Jigw8R46j4jR5NFj/RpFeU+r+QUZk0z7UP58AIX5hlpN4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6352
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: a64ba5de5ee501e1027b1b3bc0cf3a80047cfa05 ("[PATCH net-next v2 2/2] Create netdev->neighbour association")
url: https://github.com/intel-lab-lkp/linux/commits/Gilad-Naaman/Convert-neighbour-table-to-use-hlist/20241006-145017
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 8f602276d3902642fdc3429b548d73c745446601
patch link: https://lore.kernel.org/all/20241006064747.201773-3-gnaaman@drivenets.com/
patch subject: [PATCH net-next v2 2/2] Create netdev->neighbour association

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: trivial



compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------------------+------------+------------+
|                                                               | febd2a80c4 | a64ba5de5e |
+---------------------------------------------------------------+------------+------------+
| WARNING:suspicious_RCU_usage                                  | 0          | 6          |
| net/core/neighbour.c:#suspicious_rcu_dereference_check()usage | 0          | 6          |
+---------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410091223.b011d2e6-lkp@intel.com


[    7.752029][    T1] WARNING: suspicious RCU usage
[    7.752608][    T1] 6.12.0-rc1-00351-ga64ba5de5ee5 #1 Not tainted
[    7.753375][    T1] -----------------------------
[    7.753944][    T1] net/core/neighbour.c:427 suspicious rcu_dereference_check() usage!
[    7.754874][    T1]
[    7.754874][    T1] other info that might help us debug this:
[    7.754874][    T1]
[    7.756040][    T1]
[    7.756040][    T1] rcu_scheduler_active = 2, debug_locks = 1
[    7.756973][    T1] 3 locks held by swapper/1:
[ 7.757526][ T1] #0: 4271c954 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock (net/core/rtnetlink.c:80) 
[ 7.758448][ T1] #1: 4272abf8 ((inetaddr_chain).rwsem){++++}-{3:3}, at: blocking_notifier_call_chain (kernel/notifier.c:388 kernel/notifier.c:376) 
[ 7.759702][ T1] #2: 4272a180 (&tbl->lock){+...}-{2:2}, at: __neigh_ifdown+0x1d/0x108 
[    7.760778][    T1]
[    7.760778][    T1] stack backtrace:
[    7.761508][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.12.0-rc1-00351-ga64ba5de5ee5 #1
[    7.762586][    T1] Call Trace:
[ 7.762968][ T1] ? dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1)) 
[ 7.763512][ T1] ? dump_stack (lib/dump_stack.c:130) 
[ 7.764002][ T1] ? lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822) 
[ 7.764645][ T1] ? neigh_flush_dev (net/core/neighbour.c:427 (discriminator 9)) 
[ 7.765201][ T1] ? _raw_write_lock_bh (kernel/locking/spinlock.c:335) 
[ 7.765587][ T1] ? __neigh_ifdown+0x29/0x108 
[ 7.765993][ T1] ? neigh_ifdown (net/core/neighbour.c:488) 
[ 7.766325][ T1] ? arp_ifdown (net/ipv4/arp.c:1363) 
[ 7.766647][ T1] ? fib_inetaddr_event (net/ipv4/fib_frontend.c:1430 net/ipv4/fib_frontend.c:1454) 
[ 7.767026][ T1] ? notifier_call_chain (kernel/notifier.c:95) 
[ 7.767414][ T1] ? blocking_notifier_call_chain (kernel/notifier.c:388 kernel/notifier.c:376) 
[ 7.767858][ T1] ? __inet_del_ifa (net/ipv4/devinet.c:447) 
[ 7.768226][ T1] ? devinet_ioctl (net/ipv4/devinet.c:1253) 
[ 7.768589][ T1] ? ic_setup_if (net/ipv4/ipconfig.c:382) 
[ 7.768934][ T1] ? ip_auto_config (net/ipv4/ipconfig.c:1652) 
[ 7.769343][ T1] ? root_nfs_parse_addr (net/ipv4/ipconfig.c:1477) 
[ 7.769729][ T1] ? do_one_initcall (init/main.c:1269) 
[ 7.770099][ T1] ? do_initcalls (init/main.c:1330 init/main.c:1347) 
[ 7.770446][ T1] ? rest_init (init/main.c:1461) 
[ 7.770779][ T1] ? kernel_init_freeable (init/main.c:1584) 
[ 7.771175][ T1] ? kernel_init (init/main.c:1471) 
[ 7.771514][ T1] ? ret_from_fork (arch/x86/kernel/process.c:153) 
[ 7.771860][ T1] ? rest_init (init/main.c:1461) 
[ 7.772192][ T1] ? ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 7.772563][ T1] ? entry_INT80_32 (arch/x86/entry/entry_32.S:941) 



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241009/202410091223.b011d2e6-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


