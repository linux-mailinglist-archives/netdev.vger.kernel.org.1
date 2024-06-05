Return-Path: <netdev+bounces-101061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0010B8FD14E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED6B9B20FC0
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979F31C280;
	Wed,  5 Jun 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBU5WF7B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EEA134B6
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599620; cv=fail; b=I5GX9QQx+p6Jygme56QeCYpEWOhcGkhDGrxeRzybJP9nAmsZV2hrYor0LHsmS6pwk8UkDYNy1W3NElEtnDOJfl6Ug2dLDadrYT7lLCDBVHVPFdcc2jd1m8k8su0lKJHeW0vWDIMMr9VclPPPP/+W92I7VHayrgATlPnxNBXHxYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599620; c=relaxed/simple;
	bh=dgk7mAz6pH3a4ia+DYUTnBT5tvwcpY4kkaCtgZrrjIg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=enpExJR4LXDhb8FPZMs9pam5MLngiffsB4M8jDcYYOaJIzLru5F8daQqbkm+QgjGczZlOh+8bKvRzvw/ye04iK6IAx22bGgT9oO8eBbWU40719b4LBaFOnY5KhAhQux6Q4dFE5OXXHoc+yvdKw57WG/8vOtD+jXzLmeRSWAepys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBU5WF7B; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717599619; x=1749135619;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dgk7mAz6pH3a4ia+DYUTnBT5tvwcpY4kkaCtgZrrjIg=;
  b=lBU5WF7BwfZwmdzv96n1kg/+Ztk8+ce2pIgT7GEzQ5RraL4DFmNM0WG4
   NXAFLg1/ZpkiVhEE2WU9dsw7ADyM6WsFMAkDI9f3kueilXHXwwXkRtJQH
   0eueLL593oyxu7Qo/1ypQ2zWn68uqsoq7m61o82BsowSnSm1qBlq/dWdc
   hNX3bXhmXDIxzzXbcT+DKITQ8IYZ5qB34efY8Q48MeneY0ZOakhWII2bv
   TfPzNTY+m1ANOw64ZPfKEGywerGmqMqjrffKklKvhudWw4cEypDursChW
   Isck0ZfV0pF1F9Y+kbDDrMmc5XEN2sGJBCCNHcleqP9soC/DQsas0J/VB
   Q==;
X-CSE-ConnectionGUID: w3cwZmoDSQO6Ouwk3TzHVA==
X-CSE-MsgGUID: YJe+kwPdQQae1BYeD9xBdQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14333655"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14333655"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:00:18 -0700
X-CSE-ConnectionGUID: ujlTv5waSEeX7WjxpzHBzQ==
X-CSE-MsgGUID: hWYCTvWFSsS+4Cj9vSUJZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37747474"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 08:00:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 08:00:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 08:00:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 08:00:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0WMI3GTpRMaQxx1fu3IiJEiYDLnnm9hkZ3mnQ+9qCbkNpoISdfVsLVFClsKkzwQNjoAMUIObtKmyiH8GXN/F0D05hZWhczsK1CGdMhloLo/2OluJOkSxzSOeryYZSuVYbSbXYxqekJFUOZs+2UfmGfGb9+eYk4CX1z4wFJsjwE3U6aYCEsomquQLUMgyas5+HJvG0zcTKasAFXIuTJFRl89WMWrbxn1DC0zcVJb5EiuT0rxr9GUU/VyRUQ5dhoc0ElQ4CLQ65tZRwGI5WoUwB5TLS107UdD90ZLMplhribm4BdA8TZffbi52qesss0Bm3+lIHUABhwhfGL7Ow5W6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn0OxktiHlqdFa1Lkkf41EJEowJFFbsYCzn3/7dUryo=;
 b=N9jb4MiQ2OvLipCZ8d4pVkeKEriHsnWMroXHXPFxQLcEQ5USbhtSyuLlMkKFs1wlH2FLKAWs+cdcdiDM6JL6psrYZaAedwbZrM7wKx10bdpbhueC9f6sOHI9y6XdJFVaXwFJc1T48aXTeKXT3bQSKekXava+DhZ/bXgXjkKJYypm3jeL3jE4RflGYKxjeSDCFq0yT6mOddaiUJfsyAm7A7ZAH8xuF2U2oZAWBfakESsHEZW0dqVKF8FviZVe4zJBR+cbVYycAqYAa6WwmQotlUv7xhAWgcn1CZ2VMJ+PIeJSb1zxCxYVpErax3VeXVzl2j4K2N++9c8SdmQt/wkarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by DS0PR11MB7878.namprd11.prod.outlook.com (2603:10b6:8:f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Wed, 5 Jun
 2024 15:00:14 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 15:00:14 +0000
Date: Wed, 5 Jun 2024 17:00:02 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
	netdev <netdev@vger.kernel.org>, Wojciech Drewek <wojciech.drewek@intel.com>,
	George Kuruvinakunnel <george.kuruvinakunnel@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net 4/8] i40e: Fix XDP program unloading while removing
 the driver
Message-ID: <ZmB9ctqbqSMdl5Qu@localhost.localdomain>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
 <20240528-net-2024-05-28-intel-net-fixes-v1-4-dc8593d2bbc6@intel.com>
 <20240529185428.2fd13cd7@kernel.org>
 <778c9deb-1dc9-4eb6-88d6-eb28a3d0ebbd@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <778c9deb-1dc9-4eb6-88d6-eb28a3d0ebbd@intel.com>
X-ClientProxiedBy: VI1PR04CA0110.eurprd04.prod.outlook.com
 (2603:10a6:803:64::45) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|DS0PR11MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 212b3443-fedb-462c-556d-08dc85703461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?toUzp9dNgvkRV5fgoPcG23ZgzvQsa5MGj1qsTyFRPMQ9IR7gD2egNfDK5tVd?=
 =?us-ascii?Q?3xKA/4Pv+vkfFgMXJPsS8dyYBg68mBtM2VBbODAJK/7g7D0oA1q4+QkwEBPM?=
 =?us-ascii?Q?VFZLCQSj6evV3iCUS+8tZLJKz8+Gu0mNPPwy1Jf76BugbifuIxLehu9ujchA?=
 =?us-ascii?Q?tKDB6jLhIKRDuPEjt1uFmAVIBO+bryAggjJllHYFwRqLEh3tuDl9Iev6qnBr?=
 =?us-ascii?Q?b4ZWrhmLFFbj+bIyd588ME8CShWRkih8cAS497qvFRTuIRbSCTNsM7Vk/xgw?=
 =?us-ascii?Q?qO0rjhsUwJ6auIC/P5cbTMvJdyrv37XqE9bR0cZUQa+LbHKqGMhG0R5sEE6E?=
 =?us-ascii?Q?19HMiibgegsD0KCh4HTTW5dqTDPGibiyFZZ23CH15q/M+YWOCytIHCWlhDyH?=
 =?us-ascii?Q?qCGYFgicJ8ECQOCa6N+UuAWW3AN3LbaZ0vhOCEnh0uxH4kBtz8yAFf54R5EE?=
 =?us-ascii?Q?a17rtRc1TAqzWeA3eZzAujmKU3H15+pIQpdndBUCp5yaX3hJrTCCljdsN80w?=
 =?us-ascii?Q?4pHGv4oPK1coEozwAxkj3UlfLbD8PZq7qB1hZMLgZH3WOsCAY41pdbT1TKCY?=
 =?us-ascii?Q?G6HsiOBEc5qmEBTPxdwGfAYVMH+9eYloZyboQheUKKqcX/UKPQpMVjAg1d8R?=
 =?us-ascii?Q?NpDdU1MfWyf0EMHwM1TReulBpGgb8JUNndZxvycfmt768l/56Y9zyBsa6a/6?=
 =?us-ascii?Q?3+roZkk3RPCOAFozxDFeot0FJa4uNTcqv4Y+iPhRYwhzx6cZPu1M9hgNJ155?=
 =?us-ascii?Q?e8P4j82wxD4WQahA7bWF/5E+D6mdvw/EGvS9AmixcthLFf7fK7UpxcbI9KRa?=
 =?us-ascii?Q?R861OtVJbEir7/8r4+kwA9DrR5bMO8rIXvI2rEEI8eh9lmAtIKLVx4bUGKU1?=
 =?us-ascii?Q?FTUegegtSezLj2ZK7XLHytihZIBruk8ipWr8fx5jm6C1Q7sdEFnhr51SS1lW?=
 =?us-ascii?Q?IffnLwmvZrjh5zagVZoVBqoaQGtDenA1ddgwRbM+zNsJkPSuOiI7A4fNVFCm?=
 =?us-ascii?Q?mYI3f7zLLrKHUtc4bOqhEf1znDMhg16CQ0xu7S9raYLbQ4Awy3Rhf+SQu+CR?=
 =?us-ascii?Q?COG1jxd8HpHgUbkE0YZhYIZxRPgfSYVaJz5x88S8a0fZyj9syYXwJpVP7QjW?=
 =?us-ascii?Q?KTdi/v1auf5xb/iuPR+k2+OdualCq/Qm3e24PfmCewKMwLcxympfYDrjiJ+n?=
 =?us-ascii?Q?R+SAojs9z6rQ0jXI93T5EkpjWqQh9P4Af91hQLeyBQs8yfXqMa3L1aMS9LTW?=
 =?us-ascii?Q?UJkBbAz6d1KgMBh0ZlOuII6O7kb3VOrYfz10+R+rhw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gHnAGtZ8QCItqBaqT9kq8cWFbYMFEt/Yik5YGQufvE1kxtjqjT2nOPCZIhLq?=
 =?us-ascii?Q?2s5pC8rTXds1zuyxl67Ytyl2n8Aw7+arGfXRDVKeDElEWhpP69q+i/R1HIQn?=
 =?us-ascii?Q?BSfyJ4FJnBUewVxSUP4IqVII5ZDwgWxQ8XC6m7x8fwYZ7mJTUbXX45xtyY0w?=
 =?us-ascii?Q?v/OlB130oXDP8W3qh5ljTGV0zmo9P4dzHVkGzN3ScIB8iixn+YMHD7heBNKd?=
 =?us-ascii?Q?Oc6SvkfoXbO9kCQDaQkiSNAhcbz6vLp3AWUf7bfm71IH7wqaHBjq0vvcwZRE?=
 =?us-ascii?Q?mj5aTtC4HMhqsruIuOeb6yDbs0kCzWTVEZWxI80aqCuhm/CCu0Jvv5tfYSPq?=
 =?us-ascii?Q?oQW5EhUnVGRI8hYGvEeboU1WCZduNZhS5aGZ09R2EALkLQhXfDcAvu6ibfI6?=
 =?us-ascii?Q?pAt0Q5ezcWViCR8gtHWR0zQ5brs9RQE8WBhOmpgJG+5RsjhT6fzD1ua4ZqZ/?=
 =?us-ascii?Q?MNWw8cUlSMsbDFEb/QUpjgBOgV9I1IWi7HKiyIwlzL2/Ej2xDTafsPcXYL6w?=
 =?us-ascii?Q?9VgOk+mwfLD1+bnAoeFZXJqpyg0z3jaPcBDBcrzaW1x9/UFUHKhbKH2jl/KS?=
 =?us-ascii?Q?BCGs4NCzXnjriYWCeDUpW2DpOWsiXFq86ACiJC6zn/VkNAyem9fGSdgXeJgk?=
 =?us-ascii?Q?6YOuxyghKDFfuS8s494bo70GBvZEm6MnZSZ4ujuH4dQ/A8rLXVvY+hLzNDiZ?=
 =?us-ascii?Q?Ksv/MYRXRsbIjcnPV9Lh+NC45k20QV06y/C0JjZv/tGIwWuvyfThUWiNZ1a2?=
 =?us-ascii?Q?tgYBv/bQr1qN7ZLShuvjyaSMPA0QEuOPGNLzSwAWuyockqCm7PR8Ge9iEQxu?=
 =?us-ascii?Q?eyHr7X/Pbu/2P6H/Lcb+TmRwE2Cypm0RgVCBYWL19kDElbnz5IQAEYzDbKnp?=
 =?us-ascii?Q?md2EKYGPMRGeD9gpXuyTV7GWI3aGn/Czkik4dG2VuNoMKmp2cfvPhmgNOtR1?=
 =?us-ascii?Q?bQehioWk/GKZSlmutRbAUNY2eHlKwQi9gFg1rMKPTofopIKmTyVDdQCYjyTR?=
 =?us-ascii?Q?tvKrcNtQ53HZYy1m5g9vPcOi7HYW6L5iyqAOESScfxSQGTeLHBH78JrfLrR7?=
 =?us-ascii?Q?p/CE4QyXw3XTwzgKeGUTRaMv9i5oEoUg79IcLmnm/O5AMD4SeI/nXyxdaqu7?=
 =?us-ascii?Q?KUeK6qjnbCTQeAmmLgbv+114foLBaAHqNGuxEG6cjSjKzTy1zPwfTdfZBNTz?=
 =?us-ascii?Q?KDhHw3HQB3n8mRlwVTgUFYL62H73jBIEBGGs2JfSIstVvZoZMNwwj7bfd9f3?=
 =?us-ascii?Q?ry/0TlcIEzt/0l1akIcFxFUaXOQgpDOLSzOBojEJX23heRFrvBAG32e7zMag?=
 =?us-ascii?Q?Q3Z7/1BT53BIQ3yqMSm/3M0rT9zjiXZKn7WPTyDMJRDCEtfs3zyob0x3pDoJ?=
 =?us-ascii?Q?vvG70XFoLtN0mNktuPjj7FO/8u8hFxv3GXzBUdxvYJCFUJ6/XzrxuL6BOuq6?=
 =?us-ascii?Q?nQK+IA79Iw0eNJLF9GIO8iiFpCjybmoIitv2YFS3VFk2DXIh2r5gEYEhSmxf?=
 =?us-ascii?Q?4BP5eVtNvp0WSW2bl1d6FGOKCa1HRtZfnXuP5OwGKyeQX8/seUjU2Lz9FoJ8?=
 =?us-ascii?Q?OxPSBg9H41SQT6AOzvFLXLNEHeCntwIcmKGOToOcSiS/yyCWlhAoK5smUYr9?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 212b3443-fedb-462c-556d-08dc85703461
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:00:14.3500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpD9SgE38k/6PKoM00inC9h+sOHbneBhH9XfR3F1VThl7Ma1cDaMYH0Z+FnSJ04g4fx5mq0Cpud9suzMvzZOLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7878
X-OriginatorOrg: intel.com

On Thu, May 30, 2024 at 09:38:04AM -0700, Jacob Keller wrote:
> 
> 
> On 5/29/2024 6:54 PM, Jakub Kicinski wrote:
> > On Tue, 28 May 2024 15:06:07 -0700 Jacob Keller wrote:
> >> +	/* Called from netdev unregister context. Unload the XDP program. */
> >> +	if (vsi->netdev->reg_state == NETREG_UNREGISTERING) {
> >> +		xdp_features_clear_redirect_target(vsi->netdev);
> >> +		old_prog = xchg(&vsi->xdp_prog, NULL);
> >> +		if (old_prog)
> >> +			bpf_prog_put(old_prog);
> >> +
> >> +		return 0;
> >> +	}
> > 
> > This is not great. The netdevice is closed at this stage, why is the xdp
> > setup try to do work if the device is closed even when not
> > unregistering?
> 
> The comment makes this seem like its happening during unregistration. It
> looks like i40e_xdp_setup() is only called from i40e_xdp(), which is if
> xdp->command is XDP_SETUP_PROG
> 
> From the looks of things, ndo_bpf is called both for setup and teardown?

Exactly, ndo_bpf with the command XDP_SETUP_PROG can be called for both
loading and unloading the XDP program. When the XDP program is unloaded,
the callback is simply called with NULL as the pointer to the program.
Also, unloading the XDP program can be initiated not only from the user
space directly, but also from the kernel core.

In this specific case we are handling that last case. Calling ndo_bpf
when reg_state == NETREG_UNREGISTERING is the case when unloading the
XDP program is an immanent part of the netdevice unregistering process.

In such a case we have to unconditionally decrease the reference counter for
the XDP program using bpf_prog_put() call and exit with no error to
assure the consistency between BPF core code and our driver.

> 
> >    7 >-------/* Set or clear a bpf program used in the earliest stages of packet
> >    6 >------- * rx. The prog will have been loaded as BPF_PROG_TYPE_XDP. The callee
> >    5 >------- * is responsible for calling bpf_prog_put on any old progs that are
> >    4 >------- * stored. In case of error, the callee need not release the new prog
> >    3 >------- * reference, but on success it takes ownership and must bpf_prog_put
> >    2 >------- * when it is no longer used.
> >    1 >------- */
> 
> Indeed, dev_xdp_uninstall calls dev_xdp_install in a loop to remove
> programs.
> 
> As far as I can tell, it looks like the .ndo_bpf call is made with a
> program set to NULL during uninstall:
> 
> >    30 static void dev_xdp_uninstall(struct net_device *dev)
> >    29 {
> >    28 >-------struct bpf_xdp_link *link;
> >    27 >-------struct bpf_prog *prog;
> >    26 >-------enum bpf_xdp_mode mode;
> >    25 >-------bpf_op_t bpf_op;
> >    24
> >    23 >-------ASSERT_RTNL();
> >    22
> >    21 >-------for (mode = XDP_MODE_SKB; mode < __MAX_XDP_MODE; mode++) {
> >    20 >------->-------prog = dev_xdp_prog(dev, mode);
> >    19 >------->-------if (!prog)
> >    18 >------->------->-------continue;
> >    17
> >    16 >------->-------bpf_op = dev_xdp_bpf_op(dev, mode);
> >    15 >------->-------if (!bpf_op)
> >    14 >------->------->-------continue;
> >    13
> >    12 >------->-------WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));
> >    11
> 
> Here, dev_xdp_install is called with a prog of NULL
> 
> >    10 >------->-------/* auto-detach link from net device */
> >     9 >------->-------link = dev_xdp_link(dev, mode);
> >     8 >------->-------if (link)
> >     7 >------->------->-------link->dev = NULL;
> >     6 >------->-------else
> >     5 >------->------->-------bpf_prog_put(prog);
> >     4
> >     3 >------->-------dev_xdp_set_link(dev, mode, NULL);
> >     2 >-------}
> >     1 }
> 

I confirm. The current design of netdevice unregistering algorithm
includes checking (in a loop) if the netdevice has any XDP program
attached and forces unloading that program because it won't be used
anymore on that device.

> I think the semantics are confusing here.
> 
> Basically, the issue is this function needs to remove the XDP properly
> when called by the netdev unregister flow but has a check against adding
> a new program if its called during remove...

The check for __I40E_IN_REMOVE has been introduced by the commit
6533e558c650 ("i40e: Fix reset path while removing the driver").
Similar checks have been added in other callbacks. I believe the
intention was to fix some synchronization issues by exiting from callbacks
or reset immediately if the driver is being removed.
Unfortunately, although it could work for other callbacks, we cannot do that
in ndo_bpf because we need to leave kernel structures and ref counters
consistent.
I decided to keep the check for IN_REMOVE because I believe it covers
the case when NETREG_UNREGISTERING flag is not set yet but we started to
destroy our internal data structures.

> 
> I think this is confusing and could be improved by refactoring how the
> i40e flow works. If the passed-in prog is NULL, its a request to remove.
> If its otherwise, its a request to add a new program (possibly replacing
> an existing one?).
> 
> I think we ought to just be checking NULL and not needing to bother with
> the netdev_unregister state at all here?

I am afraid checking for NULL won't be enough here.
Normally, when ndo_bpf is called from the user space application, that
callback can be called with NULL too (when the user just wants to unload
the XDP program). In such a case, apart from calling bpf_prog_put(), we
have to rebuild our internal data structures (queues, pointers, counters
etc.) to restore the i40e driver working back in normal mode (with no
XDP program).
My intention of adding the check for NETREG_REGISTERING was to implement
a quick handler for unloading the XDP program from the netdev
unregistering context only, when our internal data structures are
already destroyed but we need to leave kernel's ref counters in a
consistent state.

> 
> Hopefully Michal can chime in with a better understanding.

Thanks,
Michal

