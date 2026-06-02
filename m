Return-Path: <netdev+bounces-294165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ViPMF5HAHmqxUgAAu9opvQ
	(envelope-from <netdev+bounces-294165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:37:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A05F962D988
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:37:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=IWqDXwwI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294165-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294165-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5EEF3003605
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 11:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AC43DA5C8;
	Tue,  2 Jun 2026 11:30:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A47F349CC2
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 11:30:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399838; cv=fail; b=cuC10PFQi5F722sWNAcbw0nL0Xbipmj44DuXa0RxIoYlsxcE3PiXmVDeg1E6uiC4o3c7VAgXgj3bSLeBloXXU6ydWBQsjdrlVFH7RgfOY8Z3Eg4MZUz2FaKI8HLdygJvrGF6LlCJGO4UTE/5XKHosnegp/gYklRXhlzpfvkrXaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399838; c=relaxed/simple;
	bh=OM6YuvbjPeabYlXqxubgOmqW+Kgol0FeZtPGyV6Ui0o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CSOUWBHq3ZN6ndMBFSHu7pNASR3fxOph3TbFUsTXWM1v2BgQs56A5TXdnMiH9ZP7vFPuA9Z9by6hTyam5UDO2+QnGXlQvHa+2Y8/B3t+HusLUaBFcXZ45AZzF5ds5y8aU/JoHYzFCmtbZzV2GYOaC1Bg93D44TMiF6qRrAeZ5gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWqDXwwI; arc=fail smtp.client-ip=198.175.65.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780399834; x=1811935834;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OM6YuvbjPeabYlXqxubgOmqW+Kgol0FeZtPGyV6Ui0o=;
  b=IWqDXwwIZpQGe2Gzozkftcyio/VmVXs7Nu3CwDm6BpC1Spfo1Hc+LeaO
   aR0dA7Uj2k10DwyRPnXusuvaqS3U+gu04J/3UHjbTnJvZXKd74qix4Zfo
   hTHPhWKHQqysImWVr02ej8Ljyied4ix+l9MV/gH+e7y2O6WbGczt8rlPv
   e26Zh23aqn6d6/axNoiEA5x9n4h6gZQEKA9bfJbFTIR47BnP5kyvWyNNR
   DO0rHBYLvsK1Bm4J/mzyRU1uiszXW3ktVX25ewwqE7sBnjfIKlskDuq8R
   ZMW7BlKVg0PQ2PNy7YDLB7/PjM8pFUJAtRaIRyzn7WBCJ8VWLmNj1J3zf
   w==;
X-CSE-ConnectionGUID: K6WFvx2zRS+06dnv/3PcZg==
X-CSE-MsgGUID: ZcZ92wLlRs2r1j3sIgvSxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="84805316"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="84805316"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 04:30:33 -0700
X-CSE-ConnectionGUID: yAnFyb4sRWOQA8AGawLSAA==
X-CSE-MsgGUID: mMwnCBQITNaeAVNtebgDaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="240879818"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 04:30:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 04:30:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 04:30:31 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 04:30:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRiBpm+HKei/hRI+mfvrKrzgetW3+hVtUZ8Ak5EvhQzMQp6ZsEoVkMoXJkow0Mgnjd1LhwNG2JQQwG9/JU+ni5SaxDvza93uqahb6b4r4aD8XPwZAEhT97h9/3T1Z4eW663ljnP+ZNrbZue3kLJErwLsqMKIHXSqGQCmtj6Cm5zqIx7974XAaYdzhnjj6jFqmN60ykc88tVFUH7B+87z1NOcZDCYjMILGsU8ozh7tUyNpqCMJqF/54IRgLbfpARyEsn3hUHGsQKjmkxc3RlHPOv0wlSoaBIJ6YdpCAU3aTTZIv9PUN59BSKT75iPHUeLsqQ0iTczTEMA4QLq+LNF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nxTyxZvwFxHI/J9QZiM73y55/FyiYa8AuXMeuO9R5U=;
 b=ob1pXrRh4b+fU5+oKBiHzudBvJGtNPKJsorhnkKhoWB17bxEc0ttIFdsPYgqDw8qpIfhLNiWYhhzywXoUWdWTXy3Q3BFbvi+9uetpX65/hBcmjVkyftDl5d6Hdqzplq5o44+S9JZBWLJiH0hocJruMm4WSNWVldDZmnyOS953Q3KsVMPqahpBo+1QTVy+8IgF8BsHaaxQDG2pJgyCv9hmxrrQ2ulHLf3/qPm+034Woj2FwLs9CEIeYCZpMmWlGojjimWIK1nM3dAj3PMmXaqAcpEATUE5d2zhXFKyLQT54Z3esOrTYAW5DqN9RtagZ2kzp0jLjVeNc4/mDYOvPCVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH8PR11MB7968.namprd11.prod.outlook.com (2603:10b6:510:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 11:30:27 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 11:30:27 +0000
Date: Tue, 2 Jun 2026 13:30:15 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <netdev@vger.kernel.org>, Mengyuan Lou <mengyuanlou@net-swift.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>, Jacob
 Keller <jacob.e.keller@intel.com>, "Michal Swiatkowski"
	<michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>, Kees
 Cook <kees@kernel.org>, Ingo Molnar <mingo@kernel.org>, Joe Damato
	<joe@dama.to>, Breno Leitao <leitao@debian.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Uwe
 =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Johannes Berg <johannes@sipsolutions.net>,
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH net-next v4 5/5] net: wangxun: implement
 pci_error_handlers ops
Message-ID: <ah6-x9CJHwxh_3Qt@soc-5CG4396X81.clients.intel.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com>
 <20260601072221.2952-6-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601072221.2952-6-jiawenwu@trustnetic.com>
X-ClientProxiedBy: VI1PR04CA0099.eurprd04.prod.outlook.com
 (2603:10a6:803:64::34) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH8PR11MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4d53e4-4369-45f6-7bfd-08dec09a5857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 7iLj4BJtMu18ZICjWO0a6w+M4mR2ETCjzNTzI0uLY7YFHo3INrKBNbM5Zp2csQFaQC7wX1zxsK2RZDmMDZGZJiietHEErr8XSbo21AyXz91YsPdcqbOP22O9mkd9nQ5y5oXqAp0qnDk2MgUpyJGyS1NhIzwiCSFldIFwFxAO9Er07XvhlEN2iZpAGKozbrLqKgc+qG4L97lanlLMHDogFMI7Jc07WQBjN53s+TQgBSFKZEr1MR5U7/rQLqcejyQ8hW0pfAaoy2CWuOOwk0NZPvRtGGOX5L/gUL+XAYuuFq6mi0qYEoOD0ZGFFYSQLhdlityqIakNrcWeixVJIWOCiAtpOTO+YbGatpedIUgejeY1wE4QWtY8kOJu0En4bOHfBdF5Lr3VovYvFc36+2j8Tz/Pz2buvRPIOAWkWC3vq/ZOdyl+3BSpqIk9mgjVMggMEjPYni95siVdsU118UJJuWlngfaPJJFvb6hM+R5wWARbLwvizsFhq/akGiilUe8Z6Vxip6bvAmmdBDwMmOby9EfmbPr90TOlPX+PZ0eZuvx7O1k4zhCqiivsTleyoh5Hp3Sft9KzTqH5RcG61pJee5P2HC32HsNcQxLvPPxeli0y5oOGj4ViZvrcGyjywA1iqT8YO0NNdrAy5hyX1Q+vZV8SNrxV2MoFW5ed0YAra7OrBEbpVyN81HhE0cP5tJ0I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+FYi5KV4O7RlzQV67mByaYB53W90qLMBQj2MVv2sQSh65Z9XxNGoFUVuY3qH?=
 =?us-ascii?Q?w8rvkXuIsbzFtw3aIBsJjm8ftt8nfDn9chnKm3hatHb1DiNMXTJwizu0uj2P?=
 =?us-ascii?Q?P4noSRmlKveRdGRt+zTCJXNL1bSX0ncMKGyypJhE5KugVyivuUrOFXUg9Ytb?=
 =?us-ascii?Q?MSR44RQrE3DNUr1hDouFLKwMVZs+grM5IutTeBi6lFrRCU2oV0POt1LLc/Lw?=
 =?us-ascii?Q?VSXbwKCrjiW/oGXQBhlMUXkgOAFgRA2oMcjBghAspX+YXMP3nxVQ5gKoMXzh?=
 =?us-ascii?Q?wDSyIv7Oja76pJ6Ynb6Fk1oj3VrBPhYPkRBYbqXiFf88i1Nv3rFeZB/P//YK?=
 =?us-ascii?Q?+KVkKX1P5YAepFtDs6eFebFnYUfN26+0bzto+scW20cBVZl01RNQeTKYmziO?=
 =?us-ascii?Q?X2mbJQ4zbP0ZzyWVafrSxwViizxIc3ntbrQJsrJ0nqQ9uplPlpto+8c/6c0y?=
 =?us-ascii?Q?ChHvNB0qAbi0AeANkRnVvEnp+OUg+3BUa6Xa/Ar2zwiu7QoZZTHPWSmCwNKE?=
 =?us-ascii?Q?oTGJkcfLmAcmvP7gWT2C4tsZykyTKyVabCUMWYLo2DiQAK4rxr2Eh9tdOM2K?=
 =?us-ascii?Q?0yE5F5tzUxdis8B0zpd/hNuLYfoEW5biWxn+wUG6iJCGObleDYFYosQK8pSy?=
 =?us-ascii?Q?88XowC5C+tQVGoxEW9UHQoNikp6dbkT3JcYrE0iYuxF9SvDEguDqlO8fAoWo?=
 =?us-ascii?Q?am8+mfsjC3KniJ+mMxy0ltX3RPWWu1PGjSqht4O78mbRsUBrNUSiTPOvZftb?=
 =?us-ascii?Q?CqY42+PuC09lG1jxSrNd6d5Rmi6Tfx/Skp6+pg1I+TXr+PvmswgZr0FFBpsB?=
 =?us-ascii?Q?YoTY7O4/qArRVh8e6pIxZAJaxrggHlkR/QVlU5SvMyfxgpOxDOmdoUl/St7L?=
 =?us-ascii?Q?BLNVZ5WI/IZyEDLKxnUq9FhJbFVjmGhx/sI90ECVE0QPnQzYYUc8KfJCFwzQ?=
 =?us-ascii?Q?pKrNipG6EX9lcI3+iYx1WeQWi7OOkIWoQU1Pf3vPDTeDkQZSRRk4iBMjMPOo?=
 =?us-ascii?Q?FQoFgHTWgLatT+YtgHR41UjkdMBvmgME8kaxVA4EEZNlK4f2g2vwyl/XvvIH?=
 =?us-ascii?Q?jtgtOd2YCEqjyZSqo3KNe6/Dm3uMNrHibsiYNxqd6D0fF2VyV5bbeefhMSMt?=
 =?us-ascii?Q?qQkhC368iXAK9UHKcreogmj2qVSG0kWd0yjGU9mtasOFpq2eXHFKD9XP02H7?=
 =?us-ascii?Q?8k5MebeV8t0QvUZQxH/Xj3cLo+WeM3hL0h6+2WphaHLfLwk/6AjbOBAgPIdi?=
 =?us-ascii?Q?wFBTseA0qnkrp4jkubF6lx+yh62Bx/3lJn6aS8t6eu1uaWk6TH7PTVzPuUCn?=
 =?us-ascii?Q?SU3rJIIVRgWBYdWRSYC/UVsNyqwyLCDyaXNVNdyuUMcC+JalrxwDMWDptPQB?=
 =?us-ascii?Q?1QuOPJCtoteKI/RzeyEgie7csHclE+kUh2u2sSqcvEYYo0Q8uDK5SJ8pYFvt?=
 =?us-ascii?Q?ucFz5N3Err95JNMU/YiNv4SlK1a/sFvUE7ODc1VJ0t5wmAU4yq1yMrGsd3uQ?=
 =?us-ascii?Q?zru07f20hUsnyOpwlDZuwbTt8oX2rLcELZ0aXK1/Kxacdd4wFA33YHt2qR4j?=
 =?us-ascii?Q?+UpZ3yVsjd5RGUodSc8T54qhNL3QUl6vLmA0wxvj7xkT7c2VMzbpZXAkXML7?=
 =?us-ascii?Q?DIQcTld4m8rwsIPLvyYBp5jPDbkrEqpPMAUfIxu5u6CO/Qmawrfgxvaz3eTB?=
 =?us-ascii?Q?AKvnVmUUu0yAv9p6wBFN0yVP3d7CpkjuFzcEzFhlZPJnX08f0owb7EbpY7KO?=
 =?us-ascii?Q?RdIJto0jqIiTQwkHDKg/NRpjZVf0punZVQwkBgBcXEZeKkd/PcpMQXwBQW/Z?=
X-MS-Exchange-AntiSpam-MessageData-1: uMmGWf/Mp9auQ7t0na8gpjq/ZN2IwpAsrnQ=
X-Exchange-RoutingPolicyChecked: BV6sCOtoTDXnJxo1PAsICiLFaDimsllrslzgpa6TpKlheDRio+3RIHzsx2O1oX96hXajnmGvE8AJ9n+dL4QMA90HTBJQEMxLeJmea3d92jxxoJ1WhOyod+fuzQE2B6pneajfxXb5RmVBYQYchPifu+4yg/UkoPnKVLBoaT18cd86lDF9ipNzqRKP/XQJvYFbwIo41Tr6i7DkDBHrBp9QLtDkLZzBorq4e1GkY/JS4fwD/Y1HCG2oAk1txBLNN7QdKKJtcKi1+Rv6qrMJbafd844uV5dlKhVXZHiX8Bsgh2MHvm/sZ7hw3hwPPVYOzBji1/+gS5Mwn9MlAduvfeCUMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4d53e4-4369-45f6-7bfd-08dec09a5857
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 11:30:27.4900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLhO3pgDihoa5Hi75IBDudH+UEHl/4bXELvg2u4cOShIoC4bGIeSvKIvjDNpbCfMeb4V4MGekucyj9SiQYvl37xGcQ5o4e/bRcZNoSYA6Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7968
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-294165-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:mingo@kernel.org,m:joe@dama.to,m:leitao@debian.org,m:aleksandr.loktionov@intel.com,m:u.kleine-koenig@baylibre.com,m:johannes@sipsolutions.net,m:fabio.baltieri@gmail.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,trustnetic.com:email,soc-5CG4396X81.clients.intel.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A05F962D988

On Mon, Jun 01, 2026 at 03:22:21PM +0800, Jiawen Wu wrote:
> Support AER driver to handle the PCIe errors.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_err.c   | 111 ++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_err.h   |   2 +
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 +
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   9 +-
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   8 +-
>  5 files changed, 127 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> index e249cea874be..ae5d14071f3d 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> @@ -4,11 +4,122 @@
>  
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
> +#include <linux/aer.h>
>  
>  #include "wx_type.h"
>  #include "wx_lib.h"
>  #include "wx_err.h"
>  
> +/**
> + * wx_io_error_detected - called when PCI error is detected
> + * @pdev: Pointer to PCI device
> + * @state: The current pci connection state
> + *
> + * Return: pci_ers_result_t.
> + *
> + * This function is called after a PCI bus error affecting
> + * this device has been detected.
> + */
> +static pci_ers_result_t wx_io_error_detected(struct pci_dev *pdev,
> +					     pci_channel_state_t state)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	struct net_device *netdev;
> +
> +	if (!wx)
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	netdev = wx->netdev;
> +	if (!netif_device_present(netdev))
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	if (state == pci_channel_io_perm_failure)
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	rtnl_lock();
> +	netif_device_detach(netdev);

Sashiko says:

 "Calling netif_device_detach() stops new packets from entering the TX queue but
  doesn't wait for currently executing ndo_start_xmit operations to complete,
  which netif_tx_disable() would do."

Device detaching does not grab __netif_tx_lock(), so it does seem like 
netif_device_detach() leaves some race possibilities.

> +
> +	if (netif_running(netdev) && wx->soft_quiesce)
> +		wx->soft_quiesce(wx);
> +
> +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> +		pci_disable_device(pdev);
> +	rtnl_unlock();
> +
> +	/* Request a slot reset. */
> +	return PCI_ERS_RESULT_NEED_RESET;
> +}
> +
> +/**
> + * wx_io_slot_reset - called after the pci bus has been reset.
> + * @pdev: Pointer to PCI device
> + *
> + * Return: pci_ers_result_t.
> + *
> + * Restart the card from scratch, as if from a cold-boot.
> + */
> +static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	pci_ers_result_t result;
> +
> +	if (pci_enable_device_mem(pdev)) {
> +		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
> +		result = PCI_ERS_RESULT_DISCONNECT;
> +	} else {
> +		/* make all memory operations done before clearing the flag */
> +		smp_mb__before_atomic();
> +		clear_bit(WX_STATE_DISABLED, wx->state);
> +		pci_set_master(pdev);
> +		pci_restore_state(pdev);
> +		pci_wake_from_d3(pdev, false);
> +
> +		rtnl_lock();
> +		if (wx->do_reset)
> +			wx->do_reset(wx->netdev, false);
> +		rtnl_unlock();
> +		result = PCI_ERS_RESULT_RECOVERED;
> +	}
> +
> +	pci_aer_clear_nonfatal_status(pdev);
> +
> +	return result;
> +}
> +
> +/**
> + * wx_io_resume - called when traffic can start flowing again.
> + * @pdev: Pointer to PCI device
> + *
> + * This callback is called when the error recovery driver tells us that
> + * its OK to resume normal operation.
> + */
> +static void wx_io_resume(struct pci_dev *pdev)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	struct net_device *netdev;
> +	int err;
> +
> +	netdev = wx->netdev;
> +	rtnl_lock();
> +	if (netif_running(netdev)) {
> +		err = netdev->netdev_ops->ndo_open(netdev);
> +		if (err) {
> +			wx_err(wx, "Failed to open netdev after reset\n");
> +			goto out;
> +		}
> +	}
> +	netif_device_attach(netdev);
> +out:
> +	rtnl_unlock();
> +}
> +
> +const struct pci_error_handlers wx_err_handler = {
> +	.error_detected = wx_io_error_detected,
> +	.slot_reset = wx_io_slot_reset,
> +	.resume = wx_io_resume,
> +};
> +EXPORT_SYMBOL(wx_err_handler);
> +
>  static void wx_pf_reset_subtask(struct wx *wx)
>  {
>  	if (!test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.h b/drivers/net/ethernet/wangxun/libwx/wx_err.h
> index a529bf54eeac..de5d02316230 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.h
> @@ -7,6 +7,8 @@
>  #ifndef _WX_ERR_H_
>  #define _WX_ERR_H_
>  
> +extern const struct pci_error_handlers wx_err_handler;
> +
>  void wx_check_err_subtask(struct wx *wx);
>  int wx_init_err_task(struct wx *wx);
>  void wx_check_tx_hang_subtask(struct wx *wx);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 1b25a52188f7..778e186e4555 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1221,6 +1221,7 @@ enum wx_state {
>  	WX_STATE_PTP_RUNNING,
>  	WX_STATE_PTP_TX_IN_PROGRESS,
>  	WX_STATE_SERVICE_SCHED,
> +	WX_STATE_DISABLED,
>  	WX_STATE_NBITS		/* must be last */
>  };
>  
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 2484d3177034..8e5a708ea809 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -589,7 +589,8 @@ static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
>  	*enable_wake = !!wufc;
>  	wx_control_hw(wx, false);
>  
> -	pci_disable_device(pdev);
> +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> +		pci_disable_device(pdev);
>  }
>  
>  static void ngbe_shutdown(struct pci_dev *pdev)
> @@ -879,6 +880,7 @@ static int ngbe_probe(struct pci_dev *pdev,
>  		goto err_register;
>  
>  	pci_set_drvdata(pdev, wx);
> +	pci_save_state(pdev);
>  
>  	return 0;
>  
> @@ -934,7 +936,8 @@ static void ngbe_remove(struct pci_dev *pdev)
>  	kfree(wx->mac_table);
>  	wx_clear_interrupt_scheme(wx);
>  
> -	pci_disable_device(pdev);
> +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> +		pci_disable_device(pdev);
>  }
>  
>  static int ngbe_suspend(struct pci_dev *pdev, pm_message_t state)
> @@ -961,6 +964,7 @@ static int ngbe_resume(struct pci_dev *pdev)
>  		wx_err(wx, "Cannot enable PCI device from suspend\n");
>  		return err;
>  	}
> +	clear_bit(WX_STATE_DISABLED, wx->state);
>  	pci_set_master(pdev);
>  	device_wakeup_disable(&pdev->dev);
>  
> @@ -985,6 +989,7 @@ static struct pci_driver ngbe_driver = {
>  	.resume   = ngbe_resume,
>  	.shutdown = ngbe_shutdown,
>  	.sriov_configure = wx_pci_sriov_configure,
> +	.err_handler = &wx_err_handler,
>  };
>  
>  module_pci_driver(ngbe_driver);
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index 816aba4a9099..e913e3553ced 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -570,7 +570,8 @@ static void txgbe_dev_shutdown(struct pci_dev *pdev)
>  
>  	wx_control_hw(wx, false);
>  
> -	pci_disable_device(pdev);
> +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> +		pci_disable_device(pdev);
>  }
>  
>  static void txgbe_shutdown(struct pci_dev *pdev)
> @@ -922,6 +923,7 @@ static int txgbe_probe(struct pci_dev *pdev,
>  		goto err_remove_phy;
>  
>  	pci_set_drvdata(pdev, wx);
> +	pci_save_state(pdev);
>  
>  	netif_tx_stop_all_queues(netdev);
>  
> @@ -996,7 +998,8 @@ static void txgbe_remove(struct pci_dev *pdev)
>  	kfree(wx->mac_table);
>  	wx_clear_interrupt_scheme(wx);
>  
> -	pci_disable_device(pdev);
> +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> +		pci_disable_device(pdev);
>  }
>  
>  static struct pci_driver txgbe_driver = {
> @@ -1006,6 +1009,7 @@ static struct pci_driver txgbe_driver = {
>  	.remove   = txgbe_remove,
>  	.shutdown = txgbe_shutdown,
>  	.sriov_configure = wx_pci_sriov_configure,
> +	.err_handler = &wx_err_handler,
>  };
>  
>  module_pci_driver(txgbe_driver);
> -- 
> 2.51.0
> 

