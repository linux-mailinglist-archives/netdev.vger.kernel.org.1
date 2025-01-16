Return-Path: <netdev+bounces-158943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F6A13E15
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A5D3AE5BD
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B67022C9EE;
	Thu, 16 Jan 2025 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4M/pEo0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FD922BACA;
	Thu, 16 Jan 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042282; cv=fail; b=RJgCTVYeIo95/GujQ5U+GFtnl3cZVjsPPp2azu3GVV73UYqvWyxAd/rrkMe9CQ2MKhHR4C4C94U5QIYDg9RRdwanLcnw4H8TL9rNgjFbA1jlGFJIgDyRS18T0G7YKsPtPo1KfB/E8kdaU8eGYaXlkw10OlQgl1R8KjQFCfvY01s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042282; c=relaxed/simple;
	bh=TPiXkzVZYdRC0cGzYAIvhdEtKS3rvTk+VppDiIcILJI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BNExFjncXl0CdbFENpPP46zQrm0bAQCN6oKSfVqM5fiAmn6BcrK9x+9C+3iu+rvpJj0Attoe+U9inVFXf8rOu3sGpI7rg5AggjOX9vbTLxfoqjrYvafz6WrsxENyePU9haQBB+ipPgtLg7Cp/fInK8Y7N8wmOC0GxhivU+v+63U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4M/pEo0; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737042281; x=1768578281;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TPiXkzVZYdRC0cGzYAIvhdEtKS3rvTk+VppDiIcILJI=;
  b=A4M/pEo0WmDrOB6gtVUz9JmJsCUlOFISoKUlJozOvEz15NgP9AfaWejO
   515M/HJfCl9EzSOeN4lVJoRFnXTxtmP56ls299WR93s1tdzi0cAhw1SEP
   REXf6bKjrWbWr8/Xb7vL8wHQZ0/MWigEV2Pq/ibWZ2XBPanoFfj/eL2Ae
   oZNrh7RLPxb33vvcinD9vfRqqcEG0OYcnl3UD3FEsIjIrcJLjKdMs1gQB
   S5atzJjIPT0/yorL6fXipnI9oJZ2w1wRT8UL9DYfe/OPa/EcLYmsdDoKG
   g6Dx/PQAx5lG84agmERl99cfSjUxaqHUZ3bkoltQPwjZ+oolA44S5lTXR
   Q==;
X-CSE-ConnectionGUID: j4ucbDTtSU6tY50n9MYQEA==
X-CSE-MsgGUID: plv4yRsgSgO+JXBRUNB9Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37319235"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="37319235"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:44:40 -0800
X-CSE-ConnectionGUID: 9GbK/vBMQgWxFo+sL8VK9w==
X-CSE-MsgGUID: xzUreInNTEemZMibdBrxVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105381720"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 07:44:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 07:44:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 07:44:39 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 07:44:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SccNvqD3kgPRkdNzJpfSnYdawi1KvyyCRDgYQuF7r5RPYTvyzzoQawGQYXVzFuWCDeZnkLmkGjQEUJ/CCw9qkEfHdLEa14HAhP5Mz8sdHY0pTt2/8+1LOBvnnZbqerwexO21zWM7ElXW3jvh3TRL9P3GCEeJuiaFFJOOLedNkef41APhsYPlQd7f76QIjL6UEQoYK1yuzpdG5C0iGM81bQxys6xxLddSmx1JQ1JRms2wZCsj0Ew8/0OJ+sWElTZxNOxHU/YQuzgCQxq0FrGVzr2oKCqDiB1aad7ptG6NGE23MAmTSvPqlQboVh787ShqRcayHbmoimDMywkiYQMWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cclGa8aK0v9BAMj5EUUtmaBrW3Y0wxJiH8p3mMd2v4U=;
 b=TrGiUwoaKtiSq3TRBU+PKRFsQD08gnWWqFWqn1rCZyXbpo2KPlAbAjCmhKKTM9G5KSL6ToO9Gx+gQaoinjXdYdUQPRmpb4vxJLRQYTipWiQxqVLKnwZ2CE2IoJRlQjAVqzOnnEPxoGk+afyGpmeJUEuoNscwpnPdpUBG3OXskPOFPARYB7IQG9hfpRmLOkaKnSRbxmLlcBHqQl+3QgXUw18Lv/OjNgt55RU3bzHavcnaZVG2xb9DwcZ4NW/OMvw/5hOs4JuBxjXUyrLk4CT9wHy7Vktd7NC+00IdjU+5g9rWBUX3Lfe5bO0nhzcMpjcB2btbT/5NoSSZII2SJoWo8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MW3PR11MB4746.namprd11.prod.outlook.com (2603:10b6:303:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 15:44:15 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%6]) with mapi id 15.20.8335.015; Thu, 16 Jan 2025
 15:44:14 +0000
Date: Thu, 16 Jan 2025 16:44:06 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Shinas Rasheed <srasheed@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
	<thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
	<konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
	Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Abhijit Ayarekar <aayarekar@marvell.com>, "Satananda
 Burla" <sburla@marvell.com>
Subject: Re: [PATCH net v8 1/4] octeon_ep: remove firmware stats fetch in
 ndo_get_stats64
Message-ID: <Z4kpRgHcfWuVfmE6@lzaremba-mobl.ger.corp.intel.com>
References: <20250116083825.2581885-1-srasheed@marvell.com>
 <20250116083825.2581885-2-srasheed@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250116083825.2581885-2-srasheed@marvell.com>
X-ClientProxiedBy: VI1PR08CA0266.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::39) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MW3PR11MB4746:EE_
X-MS-Office365-Filtering-Correlation-Id: db670512-c34a-4630-7e80-08dd3644a13e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qbs1CXiJlelshuXMwCqSqhXmV0Ad4iLw9QSAMifqntTpK7kmcrtsXcA+35dA?=
 =?us-ascii?Q?V2DGTNzx98OwzPaDn5SFPW8+ecaguXwja98yl4Cb8hgokMr7Ayvn5Zn7PXjj?=
 =?us-ascii?Q?Lm5Xo2wgvX0WAXj8VjDc72fC0dmoYxegMkA5/g5S/CgEzHhErFVAl+BSUpgZ?=
 =?us-ascii?Q?vGH/uNNKTZt17uxtXNsHAR2POxZtixFyuN9x2G1QU5xhcQ0tK8CMt8eoqZWc?=
 =?us-ascii?Q?unihYBH7Wxs8HL1By8LisD6PHmcD05nk4GosZnvMPzQr9rHaKwIpY6GfXLGt?=
 =?us-ascii?Q?8YWQ8JRC36VswvuB57qXDFXiL6iI+yaHqlERxxs1NvIrxClyonaZvAjRnNXg?=
 =?us-ascii?Q?iTnKapjSAIU7NelMaW67kAmd+u6eS1kCquPYZH1XvpIf1BAAs0a0CgPnaQkt?=
 =?us-ascii?Q?ldnnEuBg16CztGk/961aSWFEW6OkdxXV6eSXUrZIu5zE/+j6xh57j37N64+o?=
 =?us-ascii?Q?woe14WoNA6ZdP6GVQOU2Bl5/NMSB3FGMTpT5BtDlzgFSfFF7z9bowkhercxG?=
 =?us-ascii?Q?549zbEqulRjG8MtTgpipSyyC8UiSSSVGntuKAOd56PNd7loWn+xaWHrcGlcg?=
 =?us-ascii?Q?DwR9NAWvMhjWieSnX0R+/rV8p6l+bhbo3d6bRbie/rMqfyvCcFmNQquLG0dk?=
 =?us-ascii?Q?djHc+Az3o2vwJM4YYxBx3seFHHsa4xyRwUah68ez3K3lmNBk/ZjydudTbfi2?=
 =?us-ascii?Q?hPcbpgr1mk+5xL3dfyvB3zNLDH91tMYdqzjkGsP7GyAnJSNWkW745VmvNZ9r?=
 =?us-ascii?Q?uEo6oRYJrzr4ChRuNaGf09Ldhhu0Av8DGaa3GDAqG3qXKQI56YDYEmXZpbj+?=
 =?us-ascii?Q?3b2dihke6eASZn1AM0Hp4XogcoQ5KLWTPCRJKKm32l4pFqrIjEvbI/9eUXxg?=
 =?us-ascii?Q?K2UOsKzdiUpkaujRbYJnNeJnuEg3QswSDsBVOPHbU5n9+I59MujTb5HD7kfW?=
 =?us-ascii?Q?zGVcjdBXzoqkSyHoZ7QC32nxrO1tQFYITeJGU+jWEvYL8Ym8iGRJhy8072gR?=
 =?us-ascii?Q?mm4CjR190nF4yvFuRfKgZbt2IDy+0TO7+jIOWzB/YiVIEEJ5ufqbmMQ9wAOC?=
 =?us-ascii?Q?zNS7XL9oVe0YrwbhKGrA84HTfhAvf9b330K0O9NFKcZpOUlPFAWPxdy2a4te?=
 =?us-ascii?Q?GW6SNCduam0zCJdzRpD57v0j+n6f+XxvUc5z/5uj+lzNGmvTkz6USNfTaDIV?=
 =?us-ascii?Q?p+WAJ2PIosUSLaoo6UqZUNuk7dby/TUhpgex+WdZFQY8PL1likm6NMJfgvmT?=
 =?us-ascii?Q?UwBpzaGZQ8wQpS+L37CoP8sZXFgxA6CU7fDdgPiiZ3OrI2O/y9+NI4ztiBAx?=
 =?us-ascii?Q?MpjTFWxRmC4G0eSWBk0+bSmMTqi6VxSCw6Rd377FV2M7SfYYUTrZIvFXh1me?=
 =?us-ascii?Q?DwDcasVwV12xiu3UKbR82aCsMhFAXABpGUL+rfpg3V+eXXka3Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Klyt9TnVlrfa0mr8cXYYB9GsFffSlpbY34any7YjMiMGVzTVghaoBLlrUW/R?=
 =?us-ascii?Q?ccFifa1KwV613IAlP0lREDkAQ0CaR0UsebUOc7HXfNAho4vM1b2LmVEPw0Gl?=
 =?us-ascii?Q?IuFxsccD73idjnmM/4003susQk+xJ+zs9tEy+GML6AaV/EpcX57msXkBftui?=
 =?us-ascii?Q?/rayux4vL4GEbwOMG9ctaHVfsCGpf+5Dbzx1fhaoWIh/8OMNRQ8dIeJYCezY?=
 =?us-ascii?Q?RvxTxpM0KmLqkANxxonnXOZPHxgg55TBFpsDkydevEYae4YmD/nOIIRaLRv1?=
 =?us-ascii?Q?joNa7kTIMzP9MTK2kZCa6AKc4DO8YuzS2sHVLwKBAfSOn/MhAlmdCxOIAAVS?=
 =?us-ascii?Q?d8JCAt8ScQlhkV5IOttCzr02TMq3lsYrvg69kVfJExhG75t3Ulc8qL+xWwJc?=
 =?us-ascii?Q?RlzCxbzP8qhywueb9jz5GTV72FPC4YM18o2y6TGvbpAEm/z6cgfIUAeuRMSC?=
 =?us-ascii?Q?Tal7/ZkOgzivCS1QEXTXVWaqPyDLyeLbzU5Qp+snsEOV0mZACOCE1kyf20jg?=
 =?us-ascii?Q?cFRGQW661qsM59Rzlx7S6dHCwr3SdMdifTb+S/ayq0jbShJNDAAXMScKhaP5?=
 =?us-ascii?Q?kH6dxB1gXHZBtTCMB0zId5n2RIrBWZHNVxhSn2zDi/lAbG0x+HDHfAn/Jm6U?=
 =?us-ascii?Q?CwCQga3elG0JgupGTGs+mo2UyUhOqqPEXgtWc2/zC4JM2D4vsXDdVNL4/FGm?=
 =?us-ascii?Q?1Wbceu41BDZ8qWQUF1lynLtyoqY6LAYGYD4wdEt4h748duGfJWRrfO6Vqeqs?=
 =?us-ascii?Q?anS2zOD61N29vP4/P3xBmt7XZKThWxHe70njigiCUomthDnIibKm8UAVnq8r?=
 =?us-ascii?Q?SJfNOZIYLY8M+d7QPHlrW+NCuThirkhR6diHm8Oz0Af783Vi/ai4l1lyxQXs?=
 =?us-ascii?Q?8z4viJJGqVGne979FTCy/w9CA1kKNWaTvf5YixM00aWJOMCRLc7+B2qwBm0X?=
 =?us-ascii?Q?bNBegEaK4GUnWQ2yLLpDXG7V+bJjMMPKzFxDINqHmh3xUfiZqu+hu3dVhX+w?=
 =?us-ascii?Q?wjTvjzoB2ss0nzUArfXzuz/RNQ8SNFEcoCI79FuQtzajM8ZmHCkLliThwl3U?=
 =?us-ascii?Q?m/6wH7RR5Q9D8pMy+f5e+NnGG91p5McU35ufG3M6SbWs5t3nOjSQKpxB5CUC?=
 =?us-ascii?Q?28wEHd+NQzaD3LqHIYkfApGpHn3NxvpyDV2i0oo9vS+1L1EJbGcsD9mW5mzW?=
 =?us-ascii?Q?teAuinSuDgk0n2CVUDwQTzFsRxtrj9jLGfLSSu6nQ+m2WMmDyv1X/MD+X5RN?=
 =?us-ascii?Q?r/XE/Dt2dqByfVlXc9ezY+NzHca96TP4Oi2RluqlVRA9/Iu9C6wH76JSkKUU?=
 =?us-ascii?Q?4oV7E4dxFi/8ELXmeVK8+HaFi7B5KGO6YG8JbjZS7BKKprFOEW4AuGSIsFv0?=
 =?us-ascii?Q?JAW9o3SAaNJhnHoRM3psBO8+mvHoCW7r4bdnBouKztysoQVgLB3FsraQ7fVf?=
 =?us-ascii?Q?EVoUroZNq5mYxChAr7eI4LHzv80rRGe/5N9DaPmJ5hFSMoJT29kFnazMwtwX?=
 =?us-ascii?Q?BNNI+udyWT61jDgeneQBGDZE62i8mCZLMTFbXI7Gchv8SADMHmVHf0Fm/Iq3?=
 =?us-ascii?Q?9Zsyk1AuFJKEj6krkTri7aqKcmUFEZBWqgD5WEndWz0N8u2mLT0PX13VGHab?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db670512-c34a-4630-7e80-08dd3644a13e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:44:14.8734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iC8o8mLjynAg7xxDCEvCgyldtk34lhlURy1LyKLZ0huQaLlmfuSf7AbkbicfJwWAOXPkKKg4PF7LNdZb1hYBeZWUGOdJvDv0TYcQmiubuaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4746
X-OriginatorOrg: intel.com

On Thu, Jan 16, 2025 at 12:38:22AM -0800, Shinas Rasheed wrote:
> The per queue stats are available already and are retrieved
> from register reads during ndo_get_stats64.

Same as for patch 3/4: please update the commit message after reordering.

Otherwise looks good.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> The firmware stats
> fetch call that happens in ndo_get_stats64() is currently not
> required
> 
> The warn log is given below:
> 
> [  123.316837] ------------[ cut here ]------------
> [  123.316840] Voluntary context switch within RCU read-side critical section!
> [  123.316917] pc : rcu_note_context_switch+0x2e4/0x300
> [  123.316919] lr : rcu_note_context_switch+0x2e4/0x300
> [  123.316947] Call trace:
> [  123.316949]  rcu_note_context_switch+0x2e4/0x300
> [  123.316952]  __schedule+0x84/0x584
> [  123.316955]  schedule+0x38/0x90
> [  123.316956]  schedule_timeout+0xa0/0x1d4
> [  123.316959]  octep_send_mbox_req+0x190/0x230 [octeon_ep]
> [  123.316966]  octep_ctrl_net_get_if_stats+0x78/0x100 [octeon_ep]
> [  123.316970]  octep_get_stats64+0xd4/0xf0 [octeon_ep]
> [  123.316975]  dev_get_stats+0x4c/0x114
> [  123.316977]  dev_seq_printf_stats+0x3c/0x11c
> [  123.316980]  dev_seq_show+0x1c/0x40
> [  123.316982]  seq_read_iter+0x3cc/0x4e0
> [  123.316985]  seq_read+0xc8/0x110
> [  123.316987]  proc_reg_read+0x9c/0xec
> [  123.316990]  vfs_read+0xc8/0x2ec
> [  123.316993]  ksys_read+0x70/0x100
> [  123.316995]  __arm64_sys_read+0x20/0x30
> [  123.316997]  invoke_syscall.constprop.0+0x7c/0xd0
> [  123.317000]  do_el0_svc+0xb4/0xd0
> [  123.317002]  el0_svc+0xe8/0x1f4
> [  123.317005]  el0t_64_sync_handler+0x134/0x150
> [  123.317006]  el0t_64_sync+0x17c/0x180
> [  123.317008] ---[ end trace 63399811432ab69b ]---
> 
> Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V8:
>   - Reordered patch
> 
> V7: https://lore.kernel.org/all/20250114125124.2570660-3-srasheed@marvell.com/
>   - No changes
> 
> V6: https://lore.kernel.org/all/20250110122730.2551863-3-srasheed@marvell.com/
>   - Corrected patch to apply properly
> 
> V5: https://lore.kernel.org/all/20250109103221.2544467-3-srasheed@marvell.com/
>   - No changes
> 
> V4: https://lore.kernel.org/all/20250102112246.2494230-3-srasheed@marvell.com/
>   - No changes
> 
> V3: https://lore.kernel.org/all/20241218115111.2407958-3-srasheed@marvell.com/
>   - Added warn log that happened due to rcu_read_lock in commit message
> 
> V2: https://lore.kernel.org/all/20241216075842.2394606-3-srasheed@marvell.com/
>   - No changes
> 
> V1: https://lore.kernel.org/all/20241203072130.2316913-3-srasheed@marvell.com/
> 
>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> index 549436efc204..730aa5632cce 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -995,12 +995,6 @@ static void octep_get_stats64(struct net_device *netdev,
>  	struct octep_device *oct = netdev_priv(netdev);
>  	int q;
>  
> -	if (netif_running(netdev))
> -		octep_ctrl_net_get_if_stats(oct,
> -					    OCTEP_CTRL_NET_INVALID_VFID,
> -					    &oct->iface_rx_stats,
> -					    &oct->iface_tx_stats);
> -
>  	tx_packets = 0;
>  	tx_bytes = 0;
>  	rx_packets = 0;
> @@ -1018,10 +1012,6 @@ static void octep_get_stats64(struct net_device *netdev,
>  	stats->tx_bytes = tx_bytes;
>  	stats->rx_packets = rx_packets;
>  	stats->rx_bytes = rx_bytes;
> -	stats->multicast = oct->iface_rx_stats.mcast_pkts;
> -	stats->rx_errors = oct->iface_rx_stats.err_pkts;
> -	stats->collisions = oct->iface_tx_stats.xscol;
> -	stats->tx_fifo_errors = oct->iface_tx_stats.undflw;
>  }
>  
>  /**
> -- 
> 2.25.1
> 
> 

