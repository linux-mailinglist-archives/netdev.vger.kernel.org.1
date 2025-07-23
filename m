Return-Path: <netdev+bounces-209451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A291B0F966
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6146AC58E5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FAA223328;
	Wed, 23 Jul 2025 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgEX6vG5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B701F417B
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292167; cv=fail; b=f8Vr3slF3Em+73ZFGOTsu3eushp60RGqxqLPvHVG6vmPNc0INopM3D5YOM8zdXlOSIflAJ9Blz1R46axN73uZLPQLsyiUdDI5bBl2+UX/xR+DnyeTtohBZWoSdr5YmBlZTAQ+2fzeLtO+b1QOSVWc4q/89eU1SSM6XmbCLvt2+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292167; c=relaxed/simple;
	bh=jnEQD/ULl1b6CDYD6ReCODqXFdJR+Gzd3qiK+GUOlD8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iYqXNJpHmJxehBEOEYa1GWuw4Ryde9DvhwR2odBCPnb2wqFuavYQOLbucs4Wo8DDbrTfnm5s3z4kVZc7T4fWXJz2uH+n6lJf0QygFAxN2ZkOfpT75rkmGy7k5RT3rx14TkTR2p8IAYpNdwO7To0Epqlt9h/KXeAB91dfXwIR2u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgEX6vG5; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753292165; x=1784828165;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jnEQD/ULl1b6CDYD6ReCODqXFdJR+Gzd3qiK+GUOlD8=;
  b=PgEX6vG5eQhGUwSo/j4AlKtb+TxQ786D9oKjhULoxnKM8fODqWJDmDCs
   RwyDBGTojbLoA7bV/1J/8jocYfrqPwGLyGNti9mNcUdVnGFeL61FmkDw5
   L/4SE6zEDtO/MPqdOEumXcrlVhIb9bIUWlVTg3YqdvYolY5sKtG9ebnQx
   u5ZNrCi9nzi3G0wK8HZUt1DXtU61z2UoCOznAuu6GWu8yMpPZdmAgvFbx
   5G8E9EUOw59ekowIR4s/86fXZWxAuBH2EDMt0uDPgXdIvgipVhuaeMtsH
   /3/yQeyv8CA8G3IIxjqIWrFl104nnJTBT1KohEvCcW7TgEI9NP/2IrtiC
   A==;
X-CSE-ConnectionGUID: NybH4KKgRxy8Ai2WBj7jbQ==
X-CSE-MsgGUID: h45av90GTYmtGqgd4exoaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="54681211"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="54681211"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 10:36:05 -0700
X-CSE-ConnectionGUID: kXTKyZVRSi+4zpy5aA9SuA==
X-CSE-MsgGUID: Gf50MMbPSx+1riksoj8Ypg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="158930009"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 10:36:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 10:36:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 10:36:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 10:36:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUjTJVau1jkpVwGSgT0y6rnXNuLpj9GO1LQF6yUQYCpeBuNiX1DAy0p1qWVa7riApwLXU6mxuUgtwbvGQzK0IGZbmLdN3vZyE86GERlZKa0xYFY6nbFByCl4YOF9t+4hvnuhN3GkEvk9YKgn+oWGYaMFb+6txwFZFk9iYMWGlZVFmCvKHCzKcbAlgFnI56jFEmm1KD87RJblMcSs8xYU+t2btPfpEfwlx+ZRxn97AcNTepJwntJhvy5kQYARSxG3pWcexGuhLjLVURV17M8nE57RAdLENxx9zMwF4p/k2F5pYmb2qiurfDboFMv0I2V2fe3FWq4DHhwY0etsQTz47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6w26YiwgX0Cdo8xaXTQfSfz3tlpqgy30aY8CA/1swg=;
 b=qE+GDs6eNyLG9tuNXwY/0SSfGMH4iCCBuVP0tNEzP3lXx51xjUh+yGfZplt7LjHQ0O6qS2VOraTBTm4yAJr2DCtAPVNsnKFjv77XM+NLHDcnWF28+PyOO782HxKd0xQveBbHPZbQ4BGqx181e+6T+5mhuLQULoK2Jmhv1LeVrX25o32jsf+uDSxzbrG+Dvnj14N/ANUsA0DWoyAGq9loPGWknbD8dB0amwtlBHa4q384b1XRB5mSZZ1hA+hAT3YNbbv79W+vECnByq2plGnUUdHzBDe0lrqDu1FFC5Q1SLAjSE+mHST/u2FxRptDNqQgEpP71/B9INALN6cZ3FpDoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.25; Wed, 23 Jul 2025 17:35:21 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%6]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 17:35:20 +0000
Date: Wed, 23 Jul 2025 19:35:07 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <alexanderduyck@fb.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
	<jdamato@fastly.com>, <sdf@fomichev.me>, <aleksander.lobakin@intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>
Subject: Re: [PATCH net-next 5/9] eth: fbnic: Add XDP pass, drop, abort
 support
Message-ID: <aIEdS6fnblUEuYf5@boxer>
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
 <20250723145926.4120434-6-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250723145926.4120434-6-mohsin.bashr@gmail.com>
X-ClientProxiedBy: LO4P265CA0225.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: f48cc706-3212-4838-37bd-08ddca0f4bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GsPKM7+/LwQSVnFh5EPEyulBjgjT/xSO5jGokKnK5P4dp3AZaorbgKZsbu3F?=
 =?us-ascii?Q?5ZvzvY4L6/5yjVt7itPpyZ3L/TA/hjW8kqJThoc7tSmxEGiREJo17jC9VFKL?=
 =?us-ascii?Q?SULnGbeDxnMcVUyTjg8/PKShNrOHyi/CwBl8w31qmuLZI6rdVJHLLycOgCzC?=
 =?us-ascii?Q?T46dUPzVwS7yQpCCbpzB/crOvys9OdXkqD/yvHy+PU8dWRzqMrmwqU05FSl4?=
 =?us-ascii?Q?aVZbqyvQ9dpCJhlE45ySQSydwSJvqY6e5rW4LJozrgy8+I7kj/OIUer+OP4T?=
 =?us-ascii?Q?M3mzZh7zbfpOmKsIar0cMsmp897DAJlD8xIypVjmDLxcmnvi4/RjV+s2fxoY?=
 =?us-ascii?Q?z4bO8xe8gxflMc2/7qA2OgbqEoMr1dkFbFbLUJKXHz7XuJOq9TDh2H5/plOw?=
 =?us-ascii?Q?bLk6dNq+2TPc1pdDpGQ2d/asMe2gN5MwFzDPDPAz9QT3eYmG9cGwQ1Wn7eZn?=
 =?us-ascii?Q?I3vXKzMg3centEFC6pgjMEMbmb26M3toxFY+5kcfk/B/DfKly5+MtwSNWmlo?=
 =?us-ascii?Q?CsC1bbW+5Dl9gqxT6FiOKAZQv6lo2kZ2TJjSiyufnygDOtSfiF1Z1E3auKxD?=
 =?us-ascii?Q?J9i0hb/KfKb8X2JeFH4ItrurJjRL6kvLTPtaxg2b9YCdrg5O+NvKblz+UQSF?=
 =?us-ascii?Q?DbAMN2Kcr5m3WRR8eXxx3lQtQEuwRuWukjspXI756VXarFk/XzvJeE/Op1O2?=
 =?us-ascii?Q?XyUSl9SPd7O1k8fbIvpKo9pyV3kO9vkPLbc0qjd6d5Z8pb76VrSGPa/Xxfr3?=
 =?us-ascii?Q?PPzWN8VWnRrM/pMVbhPt1SHKdwjqRO2ID7V5zMj8PkvRnPwPlnl9GrtIBDME?=
 =?us-ascii?Q?DkrbDoh9gee5VYZVsgSnVPaRbsplDWmgrraM0s/tFN0JQz5xjetktQnwI35M?=
 =?us-ascii?Q?am95Q2nE49lJZZ6x54u0IPTR0awNmdPoM+EcKd3TfMWKNDDgelzVJMfKBpnC?=
 =?us-ascii?Q?4w7P87OEQ/wWIlzftrFPqH7fIVd9pod+xBhBoWwluvIHYMheFRQ7eqxieaXm?=
 =?us-ascii?Q?ZHN5PDNRdcYMkWgJGvlUrTulkcagUK6poxC9z6NO0dsbpE0LfQssQvbKm3iE?=
 =?us-ascii?Q?ezNmqZ/shnayPRxuf8g+r/IGT6pI0FL1+eoLMzGRqXkGtK4q1shIG1HmOChb?=
 =?us-ascii?Q?ZpY0tmOpDKUlsoEb6Ien4wm7UQZQAQuBK+66Mkow2VsC867rCn4Vw9UwUbZq?=
 =?us-ascii?Q?6Us8u0t5qTe0pubNMJ/+2i0d3kSCpBgoHls4FMADg7isc1T46SLYPLi9DDpM?=
 =?us-ascii?Q?pqqdcm4Bi9oNbkyRTlUIb7d8CkY3l7RqwpJYsvomuzACgKoj4G15XpCR76or?=
 =?us-ascii?Q?wIhMPudGQKXHnO0y/nWnZHvALjBo2a68IRNkSlf+k2rPgjpG0CDOzeH9PUDz?=
 =?us-ascii?Q?gxxiOPhSuLnZ1tcsf4yr7sMEcD1ng6Aus6H28t16Qlc4+vl9xBZ37WZmgb9X?=
 =?us-ascii?Q?2NOJ3r8G/+4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qx7oXWwCOui35G2VujOZeZszDjsuTe+0VYmc+JO2vVBO2GY3bP+PD+WlfyPd?=
 =?us-ascii?Q?kr1dw1Votgo3SmRn8Dxw8u3NeLnq/JKE04qGU+quQV7rPrY+p/FDt2d0dMLK?=
 =?us-ascii?Q?IQT7unrr+UV/kexJrGDQI/sXXX3nze36gx0tDpTJl5gsjXu7EvP+iMWfgRsq?=
 =?us-ascii?Q?1dWa6lz9uAqY6/irQ/c8AFXpZrZZP8pd5UMBhBb2nr5pCrYvgxkmFaVjC4yo?=
 =?us-ascii?Q?MkegEKUMHb9O8PHzxeAJKiRNSvdYR8Dt7shjviGNJFZZlX+/xdhOsW4c9HRy?=
 =?us-ascii?Q?0jP2oGwYYtXg5PuxdyKZp05izTOt/WZ2aZKypaawyROc9Hklp60butxmt9Um?=
 =?us-ascii?Q?kI/8i1CxBODNMBGCbD+UYdL/5ftbnDKuPCOtb0jg8Rd8FW7kdL0dfvZhDHNb?=
 =?us-ascii?Q?iKkoEclOXB04/srXHy2zt7/+88QugGGvHsdRjePG5UHh1bYeqerARRltI4aB?=
 =?us-ascii?Q?pyqjKVFL9+Y5RPmzAIcSrpGrKMPCoWa6CmfNRr3Sc16FIbrMx0towCpefr5h?=
 =?us-ascii?Q?+REfjXKePYAzDtr/kSrY8smAYKJSDDbNxqsGjZt2IdDOIGnxRAIhPCaXXbO8?=
 =?us-ascii?Q?CO8BZJ7fGbrOYdYB+vGPhE2vVMAg84KMliZodship//JAsfE8L2zzYNqCSQK?=
 =?us-ascii?Q?fZskGrYN9KYD3xbLGmdg56jn6Wyag2cH1QCz/MtTQzpshDRsZTdqGOicIXYv?=
 =?us-ascii?Q?FmgaMkMa0NILEdHO1NOUnlDlDYL4lyzBRWqJQBdH8r4i7FmbsZ456ho+yTy4?=
 =?us-ascii?Q?GpDSWVTIFI8Kn0/pZjI0UWvStL5B4FzVVoFT+ou9/GfE8Fl194Xopg/rpdK9?=
 =?us-ascii?Q?+CNN41PBI7+FHLppSZZ5l836uzaJVhvLNm+ljRUsyJAbwteilUA0hIEbXhDB?=
 =?us-ascii?Q?dBGGVHoDm0lAs3ZNe4fl/M0S6TzCE8pvzY03MZyqF+mJcOQ2weeuqq42eqKn?=
 =?us-ascii?Q?TfeE3QdnlXZtaqVV3iceLbE4qIi9o9I+/SGs5gdezJA1I4112VFze5XVqMeU?=
 =?us-ascii?Q?8GTIHXIj8LMKNHHQvNzWw8wkMGuelwQtemIw/GBnYXybjw5eWFMFjKF+wiJX?=
 =?us-ascii?Q?QskHW9wn620vh7+p91i7+ekLBINvF0KS+yAx5QRt6A/dEtleAhjjWntByRtL?=
 =?us-ascii?Q?b3G3FvJb2JBr2wIyOSWETTHuVHdv/yJwgNUev0FKZ8cX/qY1QPwQQPz2NrCi?=
 =?us-ascii?Q?E8pmI9AL3IbtrxglzhUt8VjkeuWfTCds+8zdiP94D+GSUITES13Le740NEf/?=
 =?us-ascii?Q?yNZ4JujIpWzBOQ3C5rB4Zv2TWRd3wxP6AuiGKFo4MoJU4FrhcqqT5BfnECyD?=
 =?us-ascii?Q?dWOQ5dxTZDB0eSw/lfGRFO9HrvEAHf2aWnZ06JVTbXuxdiPntGhipxyPlPVR?=
 =?us-ascii?Q?Sv06o4Kxugv292LBB3jlcjHSI5IssnjCsOgntcB+eg/yJ7BPnt3XzAexrI40?=
 =?us-ascii?Q?pBe1fAYhu8tuO7hi0armJqTqEUBCq7gmSKpO888bveIGqin+E9VRYG5buxMu?=
 =?us-ascii?Q?5kBjuQ26YygQmYsAbYRowKPh21C908i0BP2e2cn7ou/u2ujfkFLfgj7Hoxln?=
 =?us-ascii?Q?l0UdSG6jVSOzuS6mzG3LKMFF0DGNNIoPVTzcfsAbLBua1gLrloOpp8QHj6Uu?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f48cc706-3212-4838-37bd-08ddca0f4bd7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:35:20.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOlJVTa1vj6Yb/h3ayAJo7FzQ1iP/dkAngwPy2kd6DiB4sWbAguraSGrPrMmNc4S1aZokslEYLSihsf7hREccjep0PTSamYLiycqfSvZ7W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5819
X-OriginatorOrg: intel.com

On Wed, Jul 23, 2025 at 07:59:22AM -0700, Mohsin Bashir wrote:
> Add basic support for attaching an XDP program to the device and support
> for PASS/DROP/ABORT actions.
> In fbnic, buffers are always mapped as DMA_BIDIRECTIONAL.
> 
> Testing:
> 
> Hook a simple XDP program that passes all the packets destined for a
> specific port
> 
> iperf3 -c 192.168.1.10 -P 5 -p 12345
> Connecting to host 192.168.1.10, port 12345
> [  5] local 192.168.1.9 port 46702 connected to 192.168.1.10 port 12345
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [SUM]   1.00-2.00   sec  3.86 GBytes  33.2 Gbits/sec    0
> 
> XDP_DROP:
> Hook an XDP program that drops packets destined for a specific port
> 
>  iperf3 -c 192.168.1.10 -P 5 -p 12345
> ^C- - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [SUM]   0.00-0.00   sec  0.00 Bytes  0.00 bits/sec    0       sender
> [SUM]   0.00-0.00   sec  0.00 Bytes  0.00 bits/sec            receiver
> iperf3: interrupt - the client has terminated
> 
> XDP with HDS:
> 
> - Validate XDP attachment failure when HDS is low
>    ~] ethtool -G eth0 hds-thresh 512
>    ~] sudo ip link set eth0 xdpdrv obj xdp_pass_12345.o sec xdp
>    ~] Error: fbnic: MTU too high, or HDS threshold is too low for single
>       buffer XDP.
> 
> - Validate successful XDP attachment when HDS threshold is appropriate
>   ~] ethtool -G eth0 hds-thresh 1536
>   ~] sudo ip link set eth0 xdpdrv obj xdp_pass_12345.o sec xdp
> 
> - Validate when the XDP program is attached, changing HDS thresh to a
>   lower value fails
>   ~] ethtool -G eth0 hds-thresh 512
>   ~] netlink error: fbnic: Use higher HDS threshold or multi-buf capable
>      program
> 
> - Validate HDS thresh does not matter when xdp frags support is
>   available
>   ~] ethtool -G eth0 hds-thresh 512
>   ~] sudo ip link set eth0 xdpdrv obj xdp_pass_mb_12345.o sec xdp.frags
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 11 +++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 35 +++++++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  5 +
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 95 +++++++++++++++++--
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  1 +
>  5 files changed, 140 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index 84a0db9f1be0..d7b9eb267ead 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -329,6 +329,17 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>  		return -EINVAL;
>  	}
>  
> +	/* If an XDP program is attached, we should check for potential frame
> +	 * splitting. If the new HDS threshold can cause splitting, we should
> +	 * only allow if the attached XDP program can handle frags.
> +	 */
> +	if (fbnic_check_split_frames(fbn->xdp_prog, netdev->mtu,
> +				     kernel_ring->hds_thresh)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Use higher HDS threshold or multi-buf capable program");
> +		return -EINVAL;
> +	}
> +
>  	if (!netif_running(netdev)) {
>  		fbnic_set_rings(fbn, ring, kernel_ring);
>  		return 0;
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index d039e1c7a0d5..0621b89cbf3d 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -504,6 +504,40 @@ static void fbnic_get_stats64(struct net_device *dev,
>  	}
>  }
>  
> +bool fbnic_check_split_frames(struct bpf_prog *prog, unsigned int mtu,
> +			      u32 hds_thresh)
> +{
> +	if (!prog)
> +		return false;
> +
> +	if (prog->aux->xdp_has_frags)
> +		return false;
> +
> +	return mtu + ETH_HLEN > hds_thresh;
> +}
> +
> +static int fbnic_bpf(struct net_device *netdev, struct netdev_bpf *bpf)
> +{
> +	struct bpf_prog *prog = bpf->prog, *prev_prog;
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +
> +	if (bpf->command != XDP_SETUP_PROG)
> +		return -EINVAL;
> +
> +	if (fbnic_check_split_frames(prog, netdev->mtu,
> +				     fbn->hds_thresh)) {
> +		NL_SET_ERR_MSG_MOD(bpf->extack,
> +				   "MTU too high, or HDS threshold is too low for single buffer XDP");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	prev_prog = xchg(&fbn->xdp_prog, prog);
> +	if (prev_prog)
> +		bpf_prog_put(prev_prog);
> +
> +	return 0;
> +}
> +
>  static const struct net_device_ops fbnic_netdev_ops = {
>  	.ndo_open		= fbnic_open,
>  	.ndo_stop		= fbnic_stop,
> @@ -513,6 +547,7 @@ static const struct net_device_ops fbnic_netdev_ops = {
>  	.ndo_set_mac_address	= fbnic_set_mac,
>  	.ndo_set_rx_mode	= fbnic_set_rx_mode,
>  	.ndo_get_stats64	= fbnic_get_stats64,
> +	.ndo_bpf		= fbnic_bpf,
>  	.ndo_hwtstamp_get	= fbnic_hwtstamp_get,
>  	.ndo_hwtstamp_set	= fbnic_hwtstamp_set,
>  };
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> index 04c5c7ed6c3a..bfa79ea910d8 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> @@ -18,6 +18,8 @@
>  #define FBNIC_TUN_GSO_FEATURES		NETIF_F_GSO_IPXIP6
>  
>  struct fbnic_net {
> +	struct bpf_prog *xdp_prog;
> +
>  	struct fbnic_ring *tx[FBNIC_MAX_TXQS];
>  	struct fbnic_ring *rx[FBNIC_MAX_RXQS];
>  
> @@ -104,4 +106,7 @@ int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
>  int fbnic_phylink_get_fecparam(struct net_device *netdev,
>  			       struct ethtool_fecparam *fecparam);
>  int fbnic_phylink_init(struct net_device *netdev);
> +
> +bool fbnic_check_split_frames(struct bpf_prog *prog,
> +			      unsigned int mtu, u32 hds_threshold);
>  #endif /* _FBNIC_NETDEV_H_ */
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index 71af7b9d5bcd..486c14e83ad5 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -2,17 +2,26 @@
>  /* Copyright (c) Meta Platforms, Inc. and affiliates. */
>  
>  #include <linux/bitfield.h>
> +#include <linux/bpf.h>
> +#include <linux/bpf_trace.h>
>  #include <linux/iopoll.h>
>  #include <linux/pci.h>
>  #include <net/netdev_queues.h>
>  #include <net/page_pool/helpers.h>
>  #include <net/tcp.h>
> +#include <net/xdp.h>
>  
>  #include "fbnic.h"
>  #include "fbnic_csr.h"
>  #include "fbnic_netdev.h"
>  #include "fbnic_txrx.h"
>  
> +enum {
> +	FBNIC_XDP_PASS = 0,
> +	FBNIC_XDP_CONSUME,
> +	FBNIC_XDP_LEN_ERR,
> +};
> +
>  enum {
>  	FBNIC_XMIT_CB_TS	= 0x01,
>  };
> @@ -877,7 +886,7 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
>  
>  	headroom = hdr_pg_off - hdr_pg_start + FBNIC_RX_PAD;
>  	frame_sz = hdr_pg_end - hdr_pg_start;
> -	xdp_init_buff(&pkt->buff, frame_sz, NULL);
> +	xdp_init_buff(&pkt->buff, frame_sz, &qt->xdp_rxq);
>  	hdr_pg_start += (FBNIC_RCD_AL_BUFF_FRAG_MASK & rcd) *
>  			FBNIC_BD_FRAG_SIZE;
>  
> @@ -966,6 +975,38 @@ static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
>  	return skb;
>  }
>  
> +static struct sk_buff *fbnic_run_xdp(struct fbnic_napi_vector *nv,
> +				     struct fbnic_pkt_buff *pkt)
> +{
> +	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
> +	struct bpf_prog *xdp_prog;
> +	int act;
> +
> +	xdp_prog = READ_ONCE(fbn->xdp_prog);
> +	if (!xdp_prog)
> +		goto xdp_pass;

Hi Mohsin,

I thought we were past the times when we read prog pointer per each
processed packet and agreed on reading the pointer once per napi loop?

> +
> +	if (xdp_buff_has_frags(&pkt->buff) && !xdp_prog->aux->xdp_has_frags)
> +		return ERR_PTR(-FBNIC_XDP_LEN_ERR);

when can this happen and couldn't you catch this within ndo_bpf? i suppose
it's related to hds setup.

> +
> +	act = bpf_prog_run_xdp(xdp_prog, &pkt->buff);
> +	switch (act) {
> +	case XDP_PASS:
> +xdp_pass:
> +		return fbnic_build_skb(nv, pkt);
> +	default:
> +		bpf_warn_invalid_xdp_action(nv->napi.dev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_ABORTED:
> +		trace_xdp_exception(nv->napi.dev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_DROP:
> +		break;
> +	}
> +
> +	return ERR_PTR(-FBNIC_XDP_CONSUME);
> +}
> +
>  static enum pkt_hash_types fbnic_skb_hash_type(u64 rcd)
>  {
>  	return (FBNIC_RCD_META_L4_TYPE_MASK & rcd) ? PKT_HASH_TYPE_L4 :
> @@ -1064,7 +1105,7 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
>  			if (unlikely(pkt->add_frag_failed))
>  				skb = NULL;
>  			else if (likely(!fbnic_rcd_metadata_err(rcd)))
> -				skb = fbnic_build_skb(nv, pkt);
> +				skb = fbnic_run_xdp(nv, pkt);
>  
>  			/* Populate skb and invalidate XDP */
>  			if (!IS_ERR_OR_NULL(skb)) {
> @@ -1250,6 +1291,7 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
>  	}
>  
>  	for (j = 0; j < nv->rxt_count; j++, i++) {
> +		xdp_rxq_info_unreg(&nv->qt[i].xdp_rxq);
>  		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub0);
>  		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub1);
>  		fbnic_remove_rx_ring(fbn, &nv->qt[i].cmpl);
> @@ -1422,6 +1464,11 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
>  		fbnic_ring_init(&qt->cmpl, db, rxq_idx, FBNIC_RING_F_STATS);
>  		fbn->rx[rxq_idx] = &qt->cmpl;
>  
> +		err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, rxq_idx,
> +				       nv->napi.napi_id);
> +		if (err)
> +			goto free_ring_cur_qt;
> +
>  		/* Update Rx queue index */
>  		rxt_count--;
>  		rxq_idx += v_count;
> @@ -1432,6 +1479,25 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
>  
>  	return 0;
>  
> +	while (rxt_count < nv->rxt_count) {
> +		qt--;
> +
> +		xdp_rxq_info_unreg(&qt->xdp_rxq);
> +free_ring_cur_qt:
> +		fbnic_remove_rx_ring(fbn, &qt->sub0);
> +		fbnic_remove_rx_ring(fbn, &qt->sub1);
> +		fbnic_remove_rx_ring(fbn, &qt->cmpl);
> +		rxt_count++;
> +	}
> +	while (txt_count < nv->txt_count) {
> +		qt--;
> +
> +		fbnic_remove_tx_ring(fbn, &qt->sub0);
> +		fbnic_remove_tx_ring(fbn, &qt->cmpl);
> +
> +		txt_count++;
> +	}
> +	fbnic_napi_free_irq(fbd, nv);
>  pp_destroy:
>  	page_pool_destroy(nv->page_pool);
>  napi_del:
> @@ -1708,8 +1774,10 @@ static void fbnic_free_nv_resources(struct fbnic_net *fbn,
>  	for (i = 0; i < nv->txt_count; i++)
>  		fbnic_free_qt_resources(fbn, &nv->qt[i]);
>  
> -	for (j = 0; j < nv->rxt_count; j++, i++)
> +	for (j = 0; j < nv->rxt_count; j++, i++) {
>  		fbnic_free_qt_resources(fbn, &nv->qt[i]);
> +		xdp_rxq_info_unreg_mem_model(&nv->qt[i].xdp_rxq);
> +	}
>  }
>  
>  static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
> @@ -1721,19 +1789,32 @@ static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
>  	for (i = 0; i < nv->txt_count; i++) {
>  		err = fbnic_alloc_tx_qt_resources(fbn, &nv->qt[i]);
>  		if (err)
> -			goto free_resources;
> +			goto free_qt_resources;
>  	}
>  
>  	/* Allocate Rx Resources */
>  	for (j = 0; j < nv->rxt_count; j++, i++) {
> +		/* Register XDP memory model for completion queue */
> +		err = xdp_reg_mem_model(&nv->qt[i].xdp_rxq.mem,
> +					MEM_TYPE_PAGE_POOL,
> +					nv->page_pool);
> +		if (err)
> +			goto xdp_unreg_mem_model;
> +
>  		err = fbnic_alloc_rx_qt_resources(fbn, &nv->qt[i]);
>  		if (err)
> -			goto free_resources;
> +			goto xdp_unreg_cur_model;
>  	}
>  
>  	return 0;
>  
> -free_resources:
> +xdp_unreg_mem_model:
> +	while (j-- && i--) {
> +		fbnic_free_qt_resources(fbn, &nv->qt[i]);
> +xdp_unreg_cur_model:
> +		xdp_rxq_info_unreg_mem_model(&nv->qt[i].xdp_rxq);
> +	}
> +free_qt_resources:
>  	while (i--)
>  		fbnic_free_qt_resources(fbn, &nv->qt[i]);
>  	return err;
> @@ -2025,7 +2106,7 @@ void fbnic_flush(struct fbnic_net *fbn)
>  			memset(qt->cmpl.desc, 0, qt->cmpl.size);
>  
>  			fbnic_put_pkt_buff(nv, qt->cmpl.pkt, 0);
> -			qt->cmpl.pkt->buff.data_hard_start = NULL;
> +			memset(qt->cmpl.pkt, 0, sizeof(struct fbnic_pkt_buff));
>  		}
>  	}
>  }
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
> index be34962c465e..0fefd1f00196 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
> @@ -129,6 +129,7 @@ struct fbnic_ring {
>  
>  struct fbnic_q_triad {
>  	struct fbnic_ring sub0, sub1, cmpl;
> +	struct xdp_rxq_info xdp_rxq;
>  };
>  
>  struct fbnic_napi_vector {
> -- 
> 2.47.1
> 
> 

