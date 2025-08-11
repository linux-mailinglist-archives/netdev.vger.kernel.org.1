Return-Path: <netdev+bounces-212401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F54B1FE89
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 07:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0E4E4E1EB2
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 05:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F51126CE07;
	Mon, 11 Aug 2025 05:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4ajxgK1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5811D52B;
	Mon, 11 Aug 2025 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890054; cv=fail; b=B5g09f9FDuJymOmC54ywYoYvzjYHzoCuvqD0TxP0fOxEO3CDmISuICxsWe0sPR1A4LtGBaKS7oyFl6hBUmqyRiuVrPpPnU1V+wDV2EleNidAMk7yMcO2uKSBso+UP+/79xoeDHL8MfEYHQGXKkG+HacH6YYoiSNL9dtDI1QSQW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890054; c=relaxed/simple;
	bh=yPoSqs/EqZqi3zbPNQ+9UfAUXcyngkR7TIEFFn94Y+Q=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rCFK5lTbyloap2GqJw9neb2aPE4zqqDz8yF7vBUrIrK8FXOsEwfWeLZTzH9OMdBdeMj6mk+eawLZ5IVDP06P5cb0zkuu2g/u7iKmpBuiT2ofoG7uWIcdaOtBQy8mwYmRRZGHsLHkRE77uMRb3lRTIZpKo837U6PofFelLadBP4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4ajxgK1; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754890053; x=1786426053;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=yPoSqs/EqZqi3zbPNQ+9UfAUXcyngkR7TIEFFn94Y+Q=;
  b=R4ajxgK1W3Sg7kEfbvFKCoOfRYLT6+K0Dg2XM/5slk6j3SeJ7iqElW6l
   ATS9scC3m9FdOiMtLLGThqI0+cvtF/HPi+GzIHkmsWMwRuMqEDK1xfGFo
   L9WwEOhDPrx9ymQMlGodhgG7M9tyYLjYjHAQ/fAff10sfN6B80q7N5T6K
   LgenW8JBRDEtU4+9vAL9q6F3c7YrzVcEi2XP1aRxqZ4vp3C/++scdSYzk
   +AVvzP8vwdqaB1M3Spm6zLwE0mKrWBs50mqWfzv6cPN7RXFFLFPBaLUZ0
   PRCpFecsVgLKOfTb/VWqPSUVvPYwhpx37ENKQumFon9FdCQXnvtlvj7s0
   w==;
X-CSE-ConnectionGUID: kKZK3hr0RY6TPqiI7cCZbg==
X-CSE-MsgGUID: pGTLhbbtTOKMHhHMUdRxIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68214005"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68214005"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:27:30 -0700
X-CSE-ConnectionGUID: c+0leOxrRMS6G4DaMw2uLA==
X-CSE-MsgGUID: oNNMHDlGTASpl3gKiZuCwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="170034887"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:27:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 10 Aug 2025 22:27:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 10 Aug 2025 22:27:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.40)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 10 Aug 2025 22:27:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HICnV425oOVUqHiKQZW1IdhqRMGNm4X+LhcYezNq97jbHIrNUq6J5Pfo9GGw44x247MtGrOwebvFKORKjcl3o2Oerlw+iirImvsaOPTvmRRWMunnwzhqOv9iKD48X4LCBow22GWEHIqdhmEKpBkFzXBqTCvXliNWCsULYfzB44BtHYwFu+CjcrQkBVR8F6gFQRR1TFKh7g5B5+/RSHtQJ0l8scHZb0y4fhgABsUY699rG0u0ZxPz/frgX8Z5juSJ8LxRhtgOVc7vGl6P3VGvLFELCq727dqxfr531fiu1mLIPESLKUY/FMf+rUB6MqSkyMHZ8xkmcSvl0WE/r1XLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBu9ilA1BEsAlVlM3B/Jp3txuu+orOdy8BDVS6+jUIk=;
 b=Ix4OtOhp/767qjJ2LaPb7RMSeQchi0Aj6VFrquiq/9bNLFZJUE9CQtNTkkW8Un0Ass98Qjb1/TEC14GzHzsNdghRTfQ4pXuAU5gNxxYesh9WoHpgpy1GlpuUJ/gtVHKXaEhB3XJPKY2Ln06yCnpBiDOHFWkwfvsSAahOsMwpIU7dkKr4q35BUq3og7rRAkKA7RNfztDaf93l3nkReAvQogJVXalB858X2/2mlPWsyT8t/kywzNIbQTcECP8luiQA11vXSz61PwMV1yeRUgaQb5uvhz7acG7g3mYni7NNrP3A62jFJuUtdvXkfk+Tr1Hl+1jGOxslbEkdRtlr3i56Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8384.namprd11.prod.outlook.com (2603:10b6:610:176::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 05:27:23 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 05:27:23 +0000
Date: Mon, 11 Aug 2025 13:27:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Menglong Dong
	<dongml2@chinatelecom.cn>, <rcu@vger.kernel.org>, <netdev@vger.kernel.org>,
	<ltp@lists.linux.it>, <edumazet@google.com>, <kuniyu@google.com>,
	<kraig@google.com>, <ncardwell@google.com>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH net v2] net: ip: order the reuseport socket in __inet_hash
Message-ID: <202508110750.a66a4225-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250801090949.129941-1-dongml2@chinatelecom.cn>
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: 335e54ba-a8e7-490c-01be-08ddd897c077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uezoT5X7I/Q8DCKRx/5vn4YJ3eIhOcD3Ft4/77i79zEiu6vgpMCfduLjOeo0?=
 =?us-ascii?Q?ktjCU3F6UI4p4UQYQlSgp8thbNoXs+S8JTe/hPs+ire4yRLfYW9aTFXWlmHt?=
 =?us-ascii?Q?h7zUVJI/Nuhe6a/kPkkSlJpien0Nt7IA3uT+nWpArlybd+0fLDBQbbx6Ciye?=
 =?us-ascii?Q?SsXvh0mr+vgIQsXl9MklK6VPOJWEFBYmz58sJVUDc7MLjBreOBUWXO9p45Kh?=
 =?us-ascii?Q?uHYjmAoSbP9MqQ1flX+IFXz5iLzMuPYvmilCNJ2+P9qpTqF6UTrKv8u6Ckug?=
 =?us-ascii?Q?fMaGd3F/aKpIEqfpd5zLZfhKJy20dw0rgxJ2Pp7iGEHd+CRgDT242GnUm0i9?=
 =?us-ascii?Q?T1K0WIhsGLacfqGQvAGmSAcP66mJ4JPjMZCoxvKF55MBUnGZuJatCoUg6v5z?=
 =?us-ascii?Q?sWXCkbux+w4StQtWHgOC9+K8Uk/6AOj3d1vz1muqPjEPc/l7hCq41BkHzidw?=
 =?us-ascii?Q?e9mx5mSFffqtdhLSov91B3icfKNt0XLI/evvIDVVyntAXpk9ul1Q84aEECU+?=
 =?us-ascii?Q?P7Jn5HkhdrCdr47QMTQglHs2HK9cAicTIz742M3ZTUajnMAqP/tv/KyfqxbJ?=
 =?us-ascii?Q?R1Fbg5JB482KLth9aqtnDhwUJAIvsZVBh2iQqyoO+CQ0QhTBYH1elKVRU6KO?=
 =?us-ascii?Q?rAkrEmcfEeVCRl0JL9YJ91WoYFsNaASmRwivcR8tg1yZoJgyXsplxoZTzKaZ?=
 =?us-ascii?Q?iWa0QdnYNufsLSosVAYovuZ180bQ7Q0Qza4Gxa5dU3lS5I5mwXP9VC6UkEFx?=
 =?us-ascii?Q?yfmOTgmOM6wu6SxjeMkyYNUHhPYPjQlbjSkg8WIQ0uhusi5HXTVj86L+pb3q?=
 =?us-ascii?Q?Ar3dnAnSCPkKrKGOSyFQ15LYVsBFuiB7xZw9Vdp5tit7VKwU3UntR5JlrBJW?=
 =?us-ascii?Q?EzwVPKWeS4GSvl0gKSA3pbKiHeualB6eeNyjWdenV+LFt3VobBOOf2iIyVoA?=
 =?us-ascii?Q?AEXnEpM7uon9loXVUxrbx9+/4cx6TXKjgp1YM2uQOnpQdSX/6MUy9I8w+DMY?=
 =?us-ascii?Q?/p+68lQT2vt6ukqEH9KdowYfescaNax5of5Kry0WRtaV/EShWnZGTNXzAI6t?=
 =?us-ascii?Q?nUlL7IQXFig6kTrHnCtdtA8RqYdLJwMek2BKzaFf2aJSIg1Ts3BNA8o/xhV/?=
 =?us-ascii?Q?zTgS82reyGuAhv05ae/IVEfMXulZGnD2UFIwhh0Bw6z0VxsRsLljvIIn+EO9?=
 =?us-ascii?Q?mkGKQfYtBqRwrkQbIA368uL2kXHBV9LNPh13ywLiekiVXC8K+Nf48Y1xS14N?=
 =?us-ascii?Q?XUTp35ILi1rsppV+DIdRREiwgACn9ijPWxuv9NECdchiWh9249Iz5PZ0agXR?=
 =?us-ascii?Q?D43NL9jLK6DkrNg/3RPLsw/5xGdsO6QyhuOKQymUKQds/URsmUahcjhn7t6x?=
 =?us-ascii?Q?qAI22koJGqGSnTZxzQ0yWco+RrDQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ECbrw1A+KIIlmeeJ8Gv+Nik6aZQdnlS3aQUTpXTXfk/LR1+34fqeS6tpc/op?=
 =?us-ascii?Q?fgkSfTj5WAvWFKkr+FaEJLXMHzf4/4A3t7B5TNqGlTdb42Q0BaZC0I0sASr1?=
 =?us-ascii?Q?qI0kPtolvLLW/yDytT4KOQ9dlFg2WiUOBkM7gT3l4ZHKckySgyqwikSEeMUZ?=
 =?us-ascii?Q?JcmXBVy2r885VGNo8CSrLhVSxBSnandL3pKmjBN6H2Ilmb9nGBExHEYrlPdP?=
 =?us-ascii?Q?4eOfjo48+7GtR0QCgUX1xKVRHKdpVqCO+ibhKSAIbvDw4BqRqEbTIqdNUeP7?=
 =?us-ascii?Q?2wUDQ5zG1kQNAO0TouTxlLQrUCnvxfqj/ZRldRI7L5nt5hcOM299dn9bGMsh?=
 =?us-ascii?Q?zNIQG2ngUNb9NbPaK72FHOsnDLG2cdIZ2BMsizZP0zIkTX3Hdk0+CEbp3zbd?=
 =?us-ascii?Q?ww1fJ8fcHaAvyvu4T8ppAdH0ICyNBKknrrgQrzV/udAj6X9I6e8iys+kblgB?=
 =?us-ascii?Q?dU3IcH5HsiB5KwX7RG2eZEs2Fn/4ThqYfOs7S8tAgHpAV+UvyYZZbnvlPaLj?=
 =?us-ascii?Q?0zxqvg3+J0+502YkQ7AQKk+If8NOU4iANk5R2bNz7V/AjK28lA+6cFAKZwDA?=
 =?us-ascii?Q?hJsXEOJ75sNfVrphNu5S/Qklx2lM1WEI5v0GabM9Xyvw6+bV8HUEumgGinnj?=
 =?us-ascii?Q?tATmNH7WebzMH4Wmkj3xrBJpAJfvtio6cAgi+Tf/Onh5a8rvkTpnjd6zBLRz?=
 =?us-ascii?Q?oqWclCqHSD5XWZn6ANCI8w/8O/d6JXC22n7/wCI1yzOEIUTpAsNOhpbRUy4U?=
 =?us-ascii?Q?y7R88LkbnMVhcDnVjB+cGLh+WwFjzflKLeJAsYPmSiH83vPq7Ix+NRzVRMG4?=
 =?us-ascii?Q?2g/fyOjdr/OggIsIilEbt54xst+hD6rXGxluiHR55fF3O9MnWecVIF5+VSyp?=
 =?us-ascii?Q?L8aKpVVGTzpjWjfpQYKjUum+XAnAfWjInRQIzMUMai1XbNoex28nRoZPyD7A?=
 =?us-ascii?Q?5Ls+43ci7aB+nC6NhS456AH1S0yTl0D58j8DJ06J+/wp7Dwyqj/WH7SXOBT7?=
 =?us-ascii?Q?AV+b//IfQry4OE3aBTMws+J5w3ohQKJ3f4UvluzNkxubsm4MT1P4pp4EoFY9?=
 =?us-ascii?Q?QWGsmpX3hPTgOLgXi7k2msoOBjavlbZ4INmrIryo/SYZ+VsFfiwblgmKlvGP?=
 =?us-ascii?Q?EtxfCn8Slf00PB6IHYPebr9HdficE6MfTDAo8e9DdfQ++VMdHYaGIE5viymU?=
 =?us-ascii?Q?HITLhImGC/twZaJIzbR02Wrc1X4kNne4IN1czZCyDbKu6lvsgyLe+EtwPXGt?=
 =?us-ascii?Q?x+ZeH6/E1mMMOe+fEWEwaoxR1xNIkOLQdXPB+qP5ySeKKUvjsU7lk0oQD2ia?=
 =?us-ascii?Q?pj9tJGObyOb9u098cn+2Ukk6vvXWFXkqv6qV2I32LgJfbhKpWvYA7XseIHKz?=
 =?us-ascii?Q?OZ9OkDIRxp5SvToycmKGDQ3ycHIkdBONX3KNoeUAQw+B/vGbl3ul9SMndkxq?=
 =?us-ascii?Q?FXxOQqDr35l0vksEYDgr/3uxcH1KS/ITM+6kqo9WI3vjJjiR/OqMNofNIEtp?=
 =?us-ascii?Q?oTinnUvXi58bryzFsLD7h0TRBljzcBlCEZJKBUsoGTWMXInSO4T93Wmq2uyy?=
 =?us-ascii?Q?P+BFdeCUSVqY8JoX/jC/f9Uvna/PtRocMDpVAXCZNfuhn4b1tGsmP5Zh2mi6?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 335e54ba-a8e7-490c-01be-08ddd897c077
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 05:27:23.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHoFWuElCN/ePVuIPOWG2eMSIwcAtWPeO12suGI+VMksrgduKJGLdW1emxJ0tsXQQXhtJAITzdl06W4h3nKniQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8384
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in__inet_hash" on:

commit: 859ca60b71ef223e210d3d003a225d9ca70879fd ("[PATCH net v2] net: ip: order the reuseport socket in __inet_hash")
url: https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/net-ip-order-the-reuseport-socket-in-__inet_hash/20250801-171131
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git 01051012887329ea78eaca19b1d2eac4c9f601b5
patch link: https://lore.kernel.org/all/20250801090949.129941-1-dongml2@chinatelecom.cn/
patch subject: [PATCH net v2] net: ip: order the reuseport socket in __inet_hash

in testcase: ltp
version: ltp-x86_64-6505f9e29-1_20250802
with following parameters:

	disk: 1HDD
	fs: ext4
	test: fs_perms_simple



config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508110750.a66a4225-lkp@intel.com


kern :err : [  128.186735] BUG: KASAN: slab-use-after-free in __inet_hash (net/ipv4/inet_hashtables.c:749 net/ipv4/inet_hashtables.c:800) 
kern  :err   : [  128.186868] Read of size 2 at addr ffff8882125c5f10 by task isc-net-0001/3160

kern  :err   : [  128.187050] CPU: 2 UID: 108 PID: 3160 Comm: isc-net-0001 Tainted: G S                  6.16.0-06590-g859ca60b71ef #1 PREEMPT(voluntary)
kern  :err   : [  128.187056] Tainted: [S]=CPU_OUT_OF_SPEC
kern  :err   : [  128.187058] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
kern  :err   : [  128.187060] Call Trace:
kern  :err   : [  128.187063]  <TASK>
kern :err : [  128.187065] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1)) 
kern :err : [  128.187072] print_address_description+0x2c/0x390 
kern :err : [  128.187079] ? __inet_hash (net/ipv4/inet_hashtables.c:749 net/ipv4/inet_hashtables.c:800) 
kern :err : [  128.187084] print_report (mm/kasan/report.c:483) 
kern :err : [  128.187088] ? kasan_addr_to_slab (mm/kasan/common.c:37) 
kern :err : [  128.187092] ? __inet_hash (net/ipv4/inet_hashtables.c:749 net/ipv4/inet_hashtables.c:800) 
kern :err : [  128.187096] kasan_report (mm/kasan/report.c:597) 
kern :err : [  128.187101] ? __inet_hash (net/ipv4/inet_hashtables.c:749 net/ipv4/inet_hashtables.c:800) 
kern :err : [  128.187106] __inet_hash (net/ipv4/inet_hashtables.c:749 net/ipv4/inet_hashtables.c:800) 
kern :err : [  128.187111] inet_csk_listen_start (net/ipv4/inet_connection_sock.c:1356) 
kern :err : [  128.187115] __inet_listen_sk (net/ipv4/af_inet.c:219) 
kern :err : [  128.187120] ? __pfx___inet_listen_sk (net/ipv4/af_inet.c:192) 
kern :err : [  128.187123] ? _raw_spin_lock_bh (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:127 kernel/locking/spinlock.c:178) 
kern :err : [  128.187128] ? __pfx__raw_spin_lock_bh (kernel/locking/spinlock.c:177) 
kern :err : [  128.187134] inet_listen (net/ipv4/af_inet.c:240) 
kern :err : [  128.187138] __sys_listen (include/linux/file.h:62 include/linux/file.h:83 net/socket.c:1918) 
kern :err : [  128.187144] __x64_sys_listen (net/socket.c:1930) 
kern :err : [  128.187148] ? __x64_sys_getsockname (net/socket.c:2145) 
kern :err : [  128.187152] do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
kern :err : [  128.187155] ? do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
kern :err : [  128.187159] ? do_sock_setsockopt (net/socket.c:2313) 
kern :err : [  128.187163] ? __x64_sys_bind (net/socket.c:1892) 
kern :err : [  128.187167] ? do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
kern :err : [  128.187169] ? alloc_fd (fs/file.c:612) 
kern :err : [  128.187174] ? fdget (include/linux/file.h:57 fs/file.c:1176 fs/file.c:1181) 
kern :err : [  128.187178] ? fput (arch/x86/include/asm/atomic64_64.h:79 include/linux/atomic/atomic-arch-fallback.h:2913 include/linux/atomic/atomic-arch-fallback.h:3364 include/linux/atomic/atomic-long.h:698 include/linux/atomic/atomic-instrumented.h:3767 include/linux/file_ref.h:157 fs/file_table.c:544) 
kern :err : [  128.187181] ? __sys_setsockopt (include/linux/file.h:63 include/linux/file.h:83 net/socket.c:2361) 
kern :err : [  128.187185] ? __x64_sys_setsockopt (net/socket.c:2372) 
kern :err : [  128.187188] ? do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
kern :err : [  128.187191] ? __x64_sys_openat (fs/open.c:1461) 
kern :err : [  128.187194] ? __pfx___x64_sys_openat (fs/open.c:1461) 
kern :err : [  128.187198] ? __x64_sys_setsockopt (net/socket.c:2372) 
kern :err : [  128.187201] ? count_memcg_events (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 mm/memcontrol.c:560 mm/memcontrol.c:585 mm/memcontrol.c:564 mm/memcontrol.c:848) 
kern :err : [  128.187206] ? do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
kern :err : [  128.187209] ? handle_mm_fault (mm/memory.c:6272 mm/memory.c:6425) 
kern :err : [  128.187213] ? do_user_addr_fault (arch/x86/include/asm/atomic.h:93 include/linux/atomic/atomic-arch-fallback.h:949 include/linux/atomic/atomic-instrumented.h:401 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/mmap_lock.h:142 include/linux/mmap_lock.h:237 arch/x86/mm/fault.c:1338) 
kern :err : [  128.187218] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:114 arch/x86/mm/fault.c:1484 arch/x86/mm/fault.c:1532) 
kern :err : [  128.187223] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
kern  :err   : [  128.187227] RIP: 0033:0x7fe51b028897
kern :err : [ 128.187231] Code: f0 ff ff 77 06 c3 0f 1f 44 00 00 48 8b 15 61 75 0c 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 b8 32 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 75 0c 00 f7 d8 64 89 01 48
All code
========
   0:	f0 ff                	lock (bad)
   2:	ff 77 06             	push   0x6(%rdi)
   5:	c3                   	ret
   6:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   b:	48 8b 15 61 75 0c 00 	mov    0xc7561(%rip),%rdx        # 0xc7573
  12:	f7 d8                	neg    %eax
  14:	64 89 02             	mov    %eax,%fs:(%rdx)
  17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1c:	c3                   	ret
  1d:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  23:	b8 32 00 00 00       	mov    $0x32,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 39 75 0c 00 	mov    0xc7539(%rip),%rcx        # 0xc7573
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 39 75 0c 00 	mov    0xc7539(%rip),%rcx        # 0xc7549
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
kern  :err   : [  128.187235] RSP: 002b:00007fe5169fe0f8 EFLAGS: 00000217 ORIG_RAX: 0000000000000032
kern  :err   : [  128.187239] RAX: ffffffffffffffda RBX: 00007fe516a1d760 RCX: 00007fe51b028897
kern  :err   : [  128.187241] RDX: 0000000000000002 RSI: 000000000000000a RDI: 000000000000002c
kern  :err   : [  128.187243] RBP: 0000000000000000 R08: 0000000000008000 R09: 00000000ffffffff
kern  :err   : [  128.187245] R10: 00007fe5169fe024 R11: 0000000000000217 R12: 00007fe51bbd1d70
kern  :err   : [  128.187248] R13: 000000000000000a R14: 00007fe5182de000 R15: 00007fe516a1d5d0
kern  :err   : [  128.187252]  </TASK>

kern  :err   : [  128.192052] Allocated by task 2436:
kern :warn : [  128.192126] kasan_save_stack (mm/kasan/common.c:48) 
kern :warn : [  128.192209] kasan_save_track (arch/x86/include/asm/current.h:25 mm/kasan/common.c:60 mm/kasan/common.c:69) 
kern :warn : [  128.192289] __kasan_slab_alloc (mm/kasan/common.c:319 mm/kasan/common.c:345) 
kern :warn : [  128.192373] kmem_cache_alloc_noprof (mm/slub.c:4148 mm/slub.c:4197 mm/slub.c:4204) 
kern :warn : [  128.192466] sk_prot_alloc (net/core/sock.c:2233 (discriminator 2)) 
kern :warn : [  128.192545] sk_alloc (net/core/sock.c:2295) 
kern :warn : [  128.192615] inet_create (net/ipv4/af_inet.c:1733 (discriminator 2)) 
kern :warn : [  128.192717] __sock_create (net/socket.c:1590) 
kern :warn : [  128.192796] __sys_socket (net/socket.c:1686 net/socket.c:1669 net/socket.c:1731) 
kern :warn : [  128.192874] __x64_sys_socket (net/socket.c:1743) 
kern :warn : [  128.192956] do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
kern :warn : [  128.193034] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 

kern  :err   : [  128.193176] Freed by task 0:
kern :warn : [  128.193240] kasan_save_stack (mm/kasan/common.c:48) 
kern :warn : [  128.193321] kasan_save_track (arch/x86/include/asm/current.h:25 mm/kasan/common.c:60 mm/kasan/common.c:69) 
kern :warn : [  128.193401] kasan_save_free_info (mm/kasan/generic.c:579) 
kern :warn : [  128.193487] __kasan_slab_free (mm/kasan/common.c:271) 
kern :warn : [  128.193569] slab_free_after_rcu_debug (mm/slub.c:4693) 
kern :warn : [  128.193663] rcu_do_batch (arch/x86/include/asm/preempt.h:27 kernel/rcu/tree.c:2583) 
kern :warn : [  128.193740] rcu_core (kernel/rcu/tree.c:2834) 
kern :warn : [  128.193812] handle_softirqs (arch/x86/include/asm/jump_label.h:36 include/trace/events/irq.h:142 kernel/softirq.c:580) 
kern :warn : [  128.193894] __irq_exit_rcu (kernel/softirq.c:614 kernel/softirq.c:453 kernel/softirq.c:680) 
kern :warn : [  128.193977] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1050 arch/x86/kernel/apic/apic.c:1050) 
kern :warn : [  128.194074] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:574) 

kern  :err   : [  128.194217] Last potentially related work creation:
kern :warn : [  128.194312] kasan_save_stack (mm/kasan/common.c:48) 
kern :warn : [  128.194393] kasan_record_aux_stack (mm/kasan/generic.c:548) 
kern :warn : [  128.194481] kmem_cache_free (mm/slub.c:2344 mm/slub.c:4643 mm/slub.c:4745) 
kern :warn : [  128.194563] __sk_destruct (net/core/sock.c:2279 net/core/sock.c:2373) 
kern :warn : [  128.194642] rcu_do_batch (arch/x86/include/asm/preempt.h:27 kernel/rcu/tree.c:2583) 
kern :warn : [  128.194719] rcu_core (kernel/rcu/tree.c:2834) 
kern :warn : [  128.194791] handle_softirqs (arch/x86/include/asm/jump_label.h:36 include/trace/events/irq.h:142 kernel/softirq.c:580) 
kern :warn : [  128.194873] __irq_exit_rcu (kernel/softirq.c:614 kernel/softirq.c:453 kernel/softirq.c:680) 
kern :warn : [  128.194955] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1050 arch/x86/kernel/apic/apic.c:1050) 
kern :warn : [  128.195052] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:574) 

kern  :err   : [  128.195194] Second to last potentially related work creation:
kern :warn : [  128.195303] kasan_save_stack (mm/kasan/common.c:48) 
kern :warn : [  128.195383] kasan_record_aux_stack (mm/kasan/generic.c:548) 
kern :warn : [  128.195472] __call_rcu_common+0xc8/0x980 
kern :warn : [  128.195571] inet_release (net/ipv4/af_inet.c:436) 
kern :warn : [  128.195648] __sock_release (net/socket.c:650) 
kern :warn : [  128.195727] sock_close (net/socket.c:1441) 
kern :warn : [  128.195799] __fput (fs/file_table.c:468) 
kern :warn : [  128.195869] fput_close_sync (fs/file_table.c:571) 
kern :warn : [  128.195951] __x64_sys_close (fs/open.c:1590 fs/open.c:1572 fs/open.c:1572) 
kern :warn : [  128.196032] do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
kern :warn : [  128.196109] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 

kern  :err   : [  128.196250] The buggy address belongs to the object at ffff8882125c5f00
which belongs to the cache TCP of size 2304
kern  :err   : [  128.196468] The buggy address is located 16 bytes inside of
freed 2304-byte region [ffff8882125c5f00, ffff8882125c6800)

kern  :err   : [  128.196733] The buggy address belongs to the physical page:
kern  :warn  : [  128.196839] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8882125c5580 pfn:0x2125c0
kern  :warn  : [  128.197008] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
kern  :warn  : [  128.197148] memcg:ffff888217e99e01
kern  :warn  : [  128.197221] anon flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
kern  :warn  : [  128.197358] page_type: f5(slab)
kern  :warn  : [  128.197429] raw: 0017ffffc0000040 ffff88810221c640 0000000000000000 0000000000000001


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250811/202508110750.a66a4225-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


