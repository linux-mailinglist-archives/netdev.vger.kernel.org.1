Return-Path: <netdev+bounces-108893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23499262C0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B448B1C218B3
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33A617B501;
	Wed,  3 Jul 2024 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Je0RIQZt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088BD17B507;
	Wed,  3 Jul 2024 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015240; cv=fail; b=bG+I2XTE3h2xwvcjaRz45/Fi3qt2Ri3BznUkodDm4GAC+itu0eW1O9WGEnHaddKuhOaypXBnLbPO9iSKW7ExWdZ48Jm/By5f69y6n3GjkswT0//1Zu7QseoMxwcI71h3GlTY9RhwPJJ4uSVUUI46O5nnAtvkMFlsTET6xDtv4WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015240; c=relaxed/simple;
	bh=FNdN6gaVB7+Caaq2tf9olLc22fqD5ZPjThdBF8j6ehE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PmQFOSMVfuGVsvi/zGxty27vv7ZnTSSetqkf1wV27+Ntj/hs8MlbMdo2v+4v3PxU6nvDDBv9uV3o7fvOidG5mcaib9oPetjZyMZ4xsmlH0m1QREQfoDvmn8F/5h4yutawo0U0H62OAu+N0LaXDKMPcC3Ba4NevOxv/RN4DMpox4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Je0RIQZt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720015239; x=1751551239;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FNdN6gaVB7+Caaq2tf9olLc22fqD5ZPjThdBF8j6ehE=;
  b=Je0RIQZtl8eH68f3JKSAPG/O8g9IzUzU2TRZsrXoW98NbiuXlZqOIjBm
   sm70syKZGQbYZLudWwdbGuNYYh52pkraG2MIqsZI1VaQt58PLAO6iAI/j
   akbRjf3NZLpqfWWS2B3vprHBnBH9G2lxYxwDZ00taPnjKssBhqChwExC/
   BTJAbY00ngW/A0uIz/kV0ut4Gu7sh5+qkjEMjYiUzORh+pw1vgcu//JCx
   HwkIqRg0h+sqCxJyZVYvQG9Y6QSOmVyNE0QE/Spqd6wdIwkqt/U6FuSZQ
   MNcxgA/wHOMgHyBcNhX+e1NOQYjOrgu/JOxhxFBFS9Fee/GFfkuYvyQI1
   g==;
X-CSE-ConnectionGUID: 5EIPX3GrQ+aKJHF94dlvIg==
X-CSE-MsgGUID: pa7Pm5GgQ/+YDw2xqG0pEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="34785235"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="34785235"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:00:38 -0700
X-CSE-ConnectionGUID: 01F3VDXbSu2wMRsuLl3T/Q==
X-CSE-MsgGUID: ZJAU13XsRNOyRPxlTNkfKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="76999386"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 07:00:38 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 07:00:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 07:00:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 07:00:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKqkjM0LcUFd14Wo8XX0+nH6++AjCNEkDahNkE7Nk6+Xq1uqK1u9i/fI0jfPSMIze5aCBOEik6sBtUl7O/SvCISvb9maqgAdQ7016oA9iLDiNLFHtMHH/bb6QtAhxICCJkG5tgYMqayoqF1ZziyoyMb4YKbOM83UHM/Z6KnP9PveQXe9ieeTE42LtQUWnpMMDJsrfcJyrMKW7/PsloofB3orbTnWs8YKlLYRFKyN99X2RLUBDNSp46zoAsaqu33vvjX6viqUYAmQdzqFVTXf9hMIHt25ffdT+dRhTcZ9/hIXGnMMMRcbZoES6Ml/cpYMDEHbn6kZtnAf1GWROgiRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/XLr3BjaDxVxUCXLWfwZi8WuNICYN0wwCxTs0TxSow=;
 b=V52m66s9uSdfx8U9rGhYQfLS8U8Bk5OiGdgHJFcQCIU1FYBgdmm8lj6Xy6L9dkycq3u8h9+sLghoJiRHJaDVi/wy80wqNLrBYGQYkR5jq13fDaZvfLFli1coFKv4Fr9N/BhuT4hH5mpFC9jLAzN+VKBzMLuQToV1GuC3uPFPU+IpsyoDx4BdjSDGA+tBhR2uWg2YVwaPd0muFmavarThMoUrDI1dkuuw+JEwUTU6oLpmjeYJ97rXiWviOHIxSfGgdhblxN1GatfqYTcNbWdUXsCSIj/k7iZMIPJCtyWfN0QleRlXpkWGUXOxCzx/1WfPY7gdDl7IhjjVwmtMACFb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 14:00:31 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Wed, 3 Jul 2024
 14:00:31 +0000
Date: Wed, 3 Jul 2024 16:00:22 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Woojung
 Huh" <woojung.huh@microchip.com>, Arun Ramadoss
	<arun.ramadoss@microchip.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Yuiko Oshino
	<yuiko.oshino@microchip.com>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v1 1/2] net: phy: microchip: lan87xx: reinit PHY
 after cable test
Message-ID: <ZoVZdp8fTOLXuYQe@localhost.localdomain>
References: <20240703132801.623218-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240703132801.623218-1-o.rempel@pengutronix.de>
X-ClientProxiedBy: MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::16) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|PH7PR11MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 4229cfea-383b-4187-7bf4-08dc9b688042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0+7hTQoEDUlbaa/lN9Lldqz/0H9u3NKECEHO4TrG2U0h/Oy9AfYCBts9SKoE?=
 =?us-ascii?Q?6l0HRvCun2rct+3e1U00KW+aR87cBi2erV0CQl/sRrCudjECKP3lCfz49yZO?=
 =?us-ascii?Q?kpGqe7eRsg6haIZt4v9i0rxxJ3N8EpVoV7PecxqI31cG0r3jcjHZIb9CoAbZ?=
 =?us-ascii?Q?uQ0PZzyFwR8shLE9nb9DP1tZW48CjqTuqkabEI9SGcnvxXYgf0txMYfOPXhu?=
 =?us-ascii?Q?8x78q8sYHOIje/UpUOKO8x+X1VefnwEGRrlhifkSF7mjetysXhcVkwNFrEGt?=
 =?us-ascii?Q?FUuYTZOphW6O6n5FHH/3OqVEZUwIjobuhFoTBWA5WVgU5aQcVrXSOWhQe+Oq?=
 =?us-ascii?Q?ebcMsSa2zxd9kXl3rwWppP1LWCGc9eRaRqSPiVBgxu4IQ3vosAdp6DjqXU+P?=
 =?us-ascii?Q?OK3wt/t4QTLZv6Du3rEConT1+rcrmqFsGTu4tmUPt9OWhI8RTI4/bs5kgcej?=
 =?us-ascii?Q?JtkEXp2oMMrzc5DDEQUbbxLVcTOvZ1AgNZP+xGOU8vXzwZeaNHhbtNHaLRk1?=
 =?us-ascii?Q?pyB62wdjSevaYIELJG7/o4Er3T04W3XDlHEXnrh1OzqniBWoLyTyE9XK5FKN?=
 =?us-ascii?Q?afmXGMTcicYWB4R56Qxa73LLY9fWzTPRxbRK/RsdAqj+2Xyftn57xQ6rZXVx?=
 =?us-ascii?Q?N0Cfgck/NtsfoJDrm4qx/DNBV7clfOLWkd961kAe9mGzQnLdvIJHaq/7l9tk?=
 =?us-ascii?Q?x09He0M0S+LOtwkuH8hMurw1N87ZjVFfASWVtFCmmvnJ0nTqsktYAXpbWlnt?=
 =?us-ascii?Q?IDYz4HERw4XRLMGdtJaOxGx1iTEttL0FpYbz/YxKFKYXe7pT+FnDbz2yaiGn?=
 =?us-ascii?Q?fIWkHzBcVXG+HmgYVBpyRoZf+UPdILGEUFT3aatiJ28mU93AvX3i5a9KOSjX?=
 =?us-ascii?Q?NBHXBwGv3ZrC3EZ/hymVCeLoFRBuBiSSdFGfUhZOPuo3+6P3qwkWKZ6VCg+k?=
 =?us-ascii?Q?bkjqi+m0gF2/EUa0nRsbTLKYXZIcEWHKkQqUiojgpsFDph2ayfi9ng/ww/xE?=
 =?us-ascii?Q?Jg9rMfTpiDlwF//tCpTuogcXbr43w8opbTxKDQY3OMpuxKY8OzPDJlJOTztB?=
 =?us-ascii?Q?HIJyu3dOBxvVh7hEOCO1f6idyCs85jte4Cr/dcaxSU6e4WX+7zBz0CzK9ghv?=
 =?us-ascii?Q?MvqfC4hCMiKUJQk5fFBi9QDb6Y4fRpsxqUPLraC7avDXEB9SWcKmshCBYaxk?=
 =?us-ascii?Q?ZAjxAzH8kAtp/1xOsiFBlUeqQIHiwiY3wVZonywKdZE7rHSFzsVjBn/12TbU?=
 =?us-ascii?Q?BjFeJKou7s5o2ElEELo3eFqIUQQL7F/DZvIx+e/Idk6Eeg176n+SN+UYtU77?=
 =?us-ascii?Q?z5uoVpb4px8SH6HjiJDZUZg4IdiNwJ7GgBYuvHeyF6aNOw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eHmsZAktWBwbe/ih0VehfIJSCmdO87eKx+HE9U2Lkcg+0cs5lg0MHxiBbr68?=
 =?us-ascii?Q?M2o7K+nXddLpAe8wVwsGCtdCtY2IUKjzkBhdD1AYOWi6jWYB5JyxtaxM3mqz?=
 =?us-ascii?Q?aCtTP4wox9xWNbKIkXlAEHAufatAv7GQGcotyFgMygi2aIaPg4+Ahg0zL0lD?=
 =?us-ascii?Q?EWjsf6zSWRSgMEzMHsKqVOW+DORkexdB7mRwK3kir+x2qLdG6X3lM22D6Est?=
 =?us-ascii?Q?A94+vGBAkdU4mKLlAZk92jBr/BzTfcwE5bixUOiCnqaDSvm/8Ldw8OXHpUJm?=
 =?us-ascii?Q?gYEc58ZqVq34zV8efzDTAPcWPzcMXXNv7+L3f5TLQT56oke0Im3wWWQuzzkH?=
 =?us-ascii?Q?D7byyf6PGxVNRUY8Y/xfKRgLURiUm8/ojEYr4tGLfAXkaUQ6ypR8EI1iL8Zn?=
 =?us-ascii?Q?cNk8GkeCos0ZhB4ogtrySeUefb+LU7BES7CTQgXTRRx34m0Sjy5UDFIg10G8?=
 =?us-ascii?Q?F9ehqrvJzil7Ig0Wc5SA/qca1KtjbmTYWt+mEkVi3gvm5ozumAhOtwU+gskZ?=
 =?us-ascii?Q?QosAkEHPY8Uw9mPvDoHaxOLX25F6Ssm8CMkVLOQUFIHsGleXyRTMXR3RWi1K?=
 =?us-ascii?Q?DPHdgJjG1Eo2zCbEcFNFux1yhDrdreUoIB57E4QTYBO0j6d9Bp7AVC5gij1U?=
 =?us-ascii?Q?55YG81ImtF1F8pqKHwUEnYr95r52PyaJnDFZelKoxysF/CMc53QKYQ1VpM5C?=
 =?us-ascii?Q?/f2DzIiMxtxioavC4hzTV+R+zZrYwIj6pax8MrIbV5dZPtVSTgZ8SruEZGvA?=
 =?us-ascii?Q?lrpTuvnIM721l7XfGhHtSKa2CeHIYmkp55ndxgOWGKLlFhAMhNCO9jY6Ebxc?=
 =?us-ascii?Q?f+RNdBmAfNOT2NPsfT4vVJjGM7ZBQS5f+jy7+T0hMzf/m7rFk8y2xpZC/ESL?=
 =?us-ascii?Q?m5UKHY4SCHAi0yHGT0IgVgDqj26KoYgwh2W7+Yp/se7Hnayb0W8HmUwxaGJr?=
 =?us-ascii?Q?40lGbi2eI+bzDZzAh2mPAELmIBmsXxLE6qKpv8cjwvtTzhRavRH1SxFI8HS4?=
 =?us-ascii?Q?YxMdbHbcnIx+eKN25OuwdXL4KQIvy1vwVfQCFV5jaEg0wbfqBCUMmKKRT/Fs?=
 =?us-ascii?Q?OqefBQNxk9nhJm50VoxiVhPw52VxkGm77iYD+xOuvvIM82nRu/dj6nNCl5Xj?=
 =?us-ascii?Q?FXeRc058M4gxaSe0QDv1hO85OuSer9Z+yGf+uVsHTpheY4rgBmGfSsIneb8h?=
 =?us-ascii?Q?cnFLC8s7AADl1/ZfgYPaRmn8vMxzY2Uz30qgVMFcofKqX2m8VxEVvT5CvFK6?=
 =?us-ascii?Q?mZlGaDN6yzf1ytUJ0LAFJs66fFh1HxfGUgUIsj+piOWEDkwhOtkjGfTFVwAq?=
 =?us-ascii?Q?tiDitQlS3RHxhl/f+93hhlXMTOhjLFXT2r0vI2PDClk/0kKvfYUesMXj4j4E?=
 =?us-ascii?Q?W5PwcZ9npjjWSgFOP8CvPmLpfazfPnvXTS/K8yfRFCy4M/BpX4ACX3EtZi2I?=
 =?us-ascii?Q?4KP4707nUjVmF7Klio7N/Ik/f/zSp4BPwf2BDk7Sw4srS+yw+Hep0Zx4vmU5?=
 =?us-ascii?Q?3ssp5mS0RIRB66ohh/dG0dGLFo5zMcc1Ci2mN4TB9eAjJignZKSHyjKcHJBM?=
 =?us-ascii?Q?OGqVR7WePCjXhBJSspcSia8E/lvzG+eFuCbddviZ6FhUEY1U//qNtqimHhie?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4229cfea-383b-4187-7bf4-08dc9b688042
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:00:31.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uF7EjZWf5aOD1L4MGpLT5ZeaxukwtEYLCOuDtKDLUNha5jk9TFD57rT2pgQUzTXmYlLyYV7TgwzOTUegKdMQrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6932
X-OriginatorOrg: intel.com

On Wed, Jul 03, 2024 at 03:28:00PM +0200, Oleksij Rempel wrote:
> Reinit PHY after cable test, otherwise link can't be established on
> tested port. This issue is reproducible on LAN9372 switches with
> integrated 100BaseT1 PHYs.
> 
> Fixes: 788050256c411 ("net: phy: microchip_t1: add cable test support for lan87xx phy")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/microchip_t1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
> index a838b61cd844b..a35528497a576 100644
> --- a/drivers/net/phy/microchip_t1.c
> +++ b/drivers/net/phy/microchip_t1.c
> @@ -748,7 +748,7 @@ static int lan87xx_cable_test_report(struct phy_device *phydev)
>  	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
>  				lan87xx_cable_test_report_trans(detect));
>  
> -	return 0;
> +	return phy_init_hw(phydev);
>  }
>  
>  static int lan87xx_cable_test_get_status(struct phy_device *phydev,
> -- 
> 2.39.2
> 
>

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

