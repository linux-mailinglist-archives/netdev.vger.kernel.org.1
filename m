Return-Path: <netdev+bounces-300319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OFJLGKuFM2p8DAYAu9opvQ
	(envelope-from <netdev+bounces-300319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:44:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA70869DBA6
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:44:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Se2LDCcr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300319-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300319-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F136E300BD4E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 05:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94703290DB;
	Thu, 18 Jun 2026 05:44:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A891FE47B
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 05:44:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781761445; cv=fail; b=iO3Uzdr9aUsn0vlG6GX2mGu/jhfNCUDPL2y6nyfK1hVYbZmjtbw/pkFZODkvdxW706l9jrVw/HQpX4lnLx1tDjY/6lCcNKJQyiglZL/FWu93gNKKNH641tgNd9d2oAnZWcg7Opw5AV44yv4ldR2y5jmZixOqD1xXsGoqE9bT2DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781761445; c=relaxed/simple;
	bh=e0U+qplhfW7x99BNgAvrH7W7sMJ/pgnEYJffax58QGQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X6k9TKubCCgBCj+CmCDHCXLAIWvYoG8PN1xyvXyY70i7QT+29syojP1EPMT6xWE269LOh4r4leMPrxeiEr4erGlkIBihK7KRszXKo6zn3utRKPF4XNNm4HfxYJWOtAOdvGzO0Fal1U1HsFpaE88prbegdoRkvbcPVd7aAfyoL3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Se2LDCcr; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781761443; x=1813297443;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e0U+qplhfW7x99BNgAvrH7W7sMJ/pgnEYJffax58QGQ=;
  b=Se2LDCcrm8OcFc0b0+Q+yTLIJ3hpmfoKzpY2qJ1BTJr+AeHG+BvZ/GWh
   YFbOObDOGFgpynYEk0lAKSGbq8pFlHcf8Mymy8xhBLz3ZBsVMgpfReax3
   zbBeoTwvLQFcDS0GNHZyptrNpR4wRj8vDaeOgPRMQ2vg9enrSUzZqNKqz
   R6PDpbmBAJKA3YJm6fnmfj4vnSDHGpBX5WG+DStCMvz6Fs8vrmBnYKKOl
   +uhCeq0uo3FH2JdaRzUm6NKlEUXJW7P9OcGJNLq4RGBNKLLhMwj4e2Jkz
   n5HVfjhO8f9kNJ+PLai7FkutTVzxwf/Lt+93uTK4yh8BycIu4vOoJkLmD
   g==;
X-CSE-ConnectionGUID: Xoer4/lwSpWxWfjE8X2GRw==
X-CSE-MsgGUID: DRSppC2bQC2UqkO8IQOepA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="70103522"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="70103522"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 22:44:03 -0700
X-CSE-ConnectionGUID: xXSIWMUWQwWchvBTQJTv6w==
X-CSE-MsgGUID: Eqx+bwuITTqBd9Jdf2bP6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="247381047"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 22:43:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 22:43:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 22:43:37 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 22:43:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9lQiB9SsW/K3iwRspB7wy6jXQFpRJr9wD0mwzd3pf3MwuzHXxZMsrTw/Y6ONBtfjvq4o8bwalv5fcnTwqEICNC4jmtHLIjNTA0dfZIud1f9zrLObJMIJn7vQNJPnvAlXYbUJECvpVKnfmGWN6bNvTNTv8Yma00hlbPSEqFO564Eo+WqijMjf4CcWGZgfU1cyUqi3MvstFWZS/H7KKHfs58s5yJTfoE0fRr2ChZk8NYh/GMCGD+o51UexaQnRRAWUrux7lUE+Aav5cOMQP0gtNGAlz9XWlpfxKLN04VJ4m009cmzhY/yapXy+nxV13kOd9iUAg3MDc26HwPfTN6T7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRnV9+vZMhQ4PEpatE6EPBqX/3Atpnl3dK4/X1I87cM=;
 b=N1gvkTNIVypPHbC9z4Do9QprLxlzmxpDJasBNNhZ7Vj+clVd5IkKC6Dvsfgf7XV32sg3CqZyL/WpDTQUKNGKs82D9xGj7Kq6wVEifiL4cldEnTlxj3QDdTFg2vLonsYjJHoAXiJrjxAGsaoYWM47Sg4mYY/tosJC8aorGhn/m5BE1NYP0B8yLdl4Os7lXxWWUGFJggmMFysIPB4rumVwz76MFx8RS+i90xQQQVvq8SfqIapFHNvYgQIrcTQiHShzxmnOnG4QR85DdQm5p3gC59erwtQ1Ec0wB6LerVrDK7TxvkdR9w2NEaEJiGUJ3i+T/YCjUBqvZyU7WOaOL4PBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CH0PR11MB5233.namprd11.prod.outlook.com (2603:10b6:610:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 05:43:35 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 05:43:35 +0000
Date: Thu, 18 Jun 2026 13:43:29 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Danielle Ratson <danieller@nvidia.com>
CC: "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, "lkp@intel.com"
	<lkp@intel.com>, Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [selftests]  a3f88d89f6:
 kernel-selftests-bpf.net.test_bridge_neigh_suppress.sh.arping.fail
Message-ID: <ajOFgSdzLFqNwdCl@xsang-OptiPlex-9020>
References: <202606110955.8f29025d-lkp@intel.com>
 <MN2PR12MB4517EDE21D4DA962A55CF1ECD81B2@MN2PR12MB4517.namprd12.prod.outlook.com>
 <ai/3+f7LJp6pyLJi@xsang-OptiPlex-9020>
 <SJ2PR12MB9008502979A1D3566074A273D8E42@SJ2PR12MB9008.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ2PR12MB9008502979A1D3566074A273D8E42@SJ2PR12MB9008.namprd12.prod.outlook.com>
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CH0PR11MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0530d8-1935-4438-60ee-08deccfc89fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: tEKnf9gsU3JV6hDhNJLTDrrYkmiZBuQpRRi8jWCDsxuJ7kEs6Akct5qBCqEVsnd/m9sXoK8iBrK3AmBUrn3VMqUr2RJfJWNqA0ik3DSoehTn2ElrqVLnaPrUWByQRe9evwfP8i6UB0wPisufCsvEJfJb8DUWENrd5FXBbRekb3HCKTgmIopLK1B0wJo4n7vEjwVNFYRWNMFEl/jOeKz4XxLbQ67ZelqKQgYoLlOGex2AYV1ZkeJ4endjrI5dBr6+mD/SXRGn0klcaOdicwda2QBhoEaSpY0c25lmEwapsqgJTktosOnqySWmmU3A0iQR+kighLQ6mN2pet1sP8ZwryjwvFaf6Za729nWFXnxgvdR1QEqNPdyLB+3BptKJHnd5g51NLJTDb1WfOUtjXfDy4Iel1Z3co0doX5TDjSdzcogogWiKvJOiKSyz35E4ZtsCusaazErApx+KBc6H5zzx4p+whU/VsctVwQ4RoQdPNYSCTTiz6u1M5mxa8EHaJzIBJOnX4muVK0S37Xj89k1WdENJ53y8e0a5hGpuBq+Rh3rlc9uBDpvKvrA+7ACBi5gqlfREslYYFjphoKR1PKYLNfPDsy7yU/kJQJcxKsliSE9LtrikCMXAyZMkPIN8Q7Z/y3VyKGQ+uQyUNfQwYRbC6skLCniGJisSYkfTiFJBZwXAKBU/ucHAMJwpG2YVmdz4nw9CCwG7y51jP020XorSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/XS2uSQDum7lx2vR4ZKL7YiNSCIXsH4RPf68TTyw/kYxlNy7dxPfroJjSbgV?=
 =?us-ascii?Q?jx+DAP+idXo5CwTepvXrM50Z6mwH+XUr1MlE+HaiLHsfXpGII1S/H6lRv1c2?=
 =?us-ascii?Q?LArB23jw1YNGiLvYs1Oiolr3CVLIkQfG13lfe30YMpORxIkjlkQwFEnAmwdp?=
 =?us-ascii?Q?wLLT+KiGugIE1msotaq0v0C9oVRmv2DXBqqoB0V/gRab4+/5EEXU97iUytgh?=
 =?us-ascii?Q?j3sUoBWv7fncMEQ4lTTCxQIoQkJpEKN2UUNC3BHvlKNHRXXUD10yLd9rmMYr?=
 =?us-ascii?Q?eLogigQ4zAGtpqOiUBEJyMM/ti38VXYbgy5pnWf/e+Dp7DaySZd5Ul0TVG5z?=
 =?us-ascii?Q?Et4jKIZpxoWL/pcEE6JgkhXTDKbYbXN2e8jIqrMC1AKEYHvZnG1e6uOWh8ud?=
 =?us-ascii?Q?9hj3SbqzIKZNkEJY/OgGIxMBFNXN1wX/3mOiyO3NBiQUF3rajrLpKVfoLzt7?=
 =?us-ascii?Q?9fUUkCsWYf0oDd1qDTyoUPHJRZaP0oLP3bKjhNObF3WdhMJU3WTxxKjMnbih?=
 =?us-ascii?Q?YMXJt2isJhOU+eyoLySyNDcu1pRUO/LbF5bF/lV6yy1yw9kztLaxPgiqbhAX?=
 =?us-ascii?Q?PX6n0KA3qQFGLdtro/WTtMn6PLDtJJIzo/qDvFU2aIabKYsv2u1FaGpi+S3j?=
 =?us-ascii?Q?4jmlrxBwu5a2kzL50LD8lhGgTF9hnGMwFAb+iojHfmQntN6luGJMPm79+25f?=
 =?us-ascii?Q?XF8hIsvW3AzWfRxDp3lJ3r2xf/Wa1iMtnUGt9T+V6o0rQUTDAdMZ54R6Maf4?=
 =?us-ascii?Q?Epjfp6ZZloDlNFTS2OwOo+BGgCdrKpmvqUYwmmwIfAgh0U1WaCwuFzGUIMIZ?=
 =?us-ascii?Q?xLHwmp55H6eNQpnI4//V29/8D/giEKj2/xeVO86pVpqtDQ0AXjjJGAKMGbGw?=
 =?us-ascii?Q?0eH/ETEaeYoxYiRAAfBkzQZpEvP58gGjyku3Wb5+GTJTwgceDkbXuGP2tUTK?=
 =?us-ascii?Q?kSPHAYVziKKKIOGXtnvHD/qPIlc2wvcW8rNauCWIxzKgnllFzLsEftuThmf5?=
 =?us-ascii?Q?P3BFYIH7cM2kx+1MtxP197Y1Tj9BxS9OsxnH9Id6jOChzwSyrVOn1FPn9MKc?=
 =?us-ascii?Q?0U72zMtShISuXMFvz1jViZenAhxOmgcSQFv08l9rYA6Am1Oc5L9ZEe5Pbo9U?=
 =?us-ascii?Q?inSFPSrRImD6ls3xx+IWhkjjCxFo390OTxPf9nCym9dpg66xitZYB6NvI6eH?=
 =?us-ascii?Q?dH5iyqTyGZpu3Rwl6RUBNodBjn4p9l5khNIK8QxpamtxhNXVQ0HWsV6f3Vd/?=
 =?us-ascii?Q?ACYrNDZv1pGA/lC0/D7OT2jEnUV+lVXHqwjTyxEZhDSmHRQIVWFhJfiByhSW?=
 =?us-ascii?Q?mTcWEm+fv98yPUsiWky0P6+d6cIp9Lf78aYM7JAT2cKf8CqTDGNw/gi/82mX?=
 =?us-ascii?Q?BVBAe5kWMNIlTVe+hH8iDyLk4kS/7rSGTF3Nql6fndlTSGhP+Su/Wz9QvjN9?=
 =?us-ascii?Q?32WP1WgS92++DglTKa5TsjTF46tA5fU/iwjvU2BWvyxjBkzOjlGQR7a6dWB5?=
 =?us-ascii?Q?pObd+EhL/rXGdVo0jYS70vJTney3bSpoRkfO4ZodLpmqFsK/+SpFcV/1ONSf?=
 =?us-ascii?Q?QeVgugYQtTr2eQRNBorDrWCYACaqxvsEJGZtcCVcKt0Ekm4del8GSvwPn3kR?=
 =?us-ascii?Q?qDduYA5PsJxFJoaH2botSoF+5trAfzbWMWfaGSm6FveOEiD7PyatsNPUbzHv?=
 =?us-ascii?Q?gnBGqs/BhfgAEyfNtaKqKx1O5PpQy8ObrPBPMNQk9SGXZvy+JdvrC/dJwDxY?=
 =?us-ascii?Q?iUggQ7A8Jw=3D=3D?=
X-Exchange-RoutingPolicyChecked: DDOK/I5WpcA+qcQ1Z4fkcGWsikE173sO0nNPZVta77f52Kh8Y4RannS5IGy6NasVib0/Yy0RCEYGHr5zagoueXQa7tVuWc+sIa1D3iCj4AWHJEaOHFieOZGFqlhnCWoZukTx/tOVpWcXcPh/2a7pAKSljSY/2FzWatDJ+6ghRbjysdHd6PgqIOV2kR5MQsqyYAPXDj6NieTOBB5nmKksC+Nbto7saarb8pszCeMN2/TX3toJRGVVqGnw2fx55L3IbROSosRh5GE66f01PEXDP6qLW4tFkJ22w9BkH87TLV2XQRSSGMXLpqtVf6E3Q7KLxqnG4Kh3BY9U7J5Nb1RcGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0530d8-1935-4438-60ee-08deccfc89fc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:43:35.3359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cju+TLqvq/qolO81UfUQztF39vx4VMdE8qHudkpIi3TDJh2huYvHnPT4Lealy+YV8scIXxLwwhaQwfjWfxeJNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5233
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300319-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:danieller@nvidia.com,m:oe-lkp@lists.linux.dev,m:lkp@intel.com,m:kuba@kernel.org,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:oliver.sang@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,01.org:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,habets.se:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA70869DBA6

hi, Danielle,

On Wed, Jun 17, 2026 at 07:29:48AM +0000, Danielle Ratson wrote:
> Hi Oliver,
> 
> Thank you for confirming the arping version. ARPing 2.25 by Thomas Habets has incompatible semantics for several flags that the test relies on (-D, b, -U, -A). 
> So, the failures are a tool version issue rather than a kernel regression.
> 
> This is not limited to the new commit- looking at the 56 failures in the added log, the other arping-based test cases that existed before commit a3f88d89f698 are also failing, which confirms the root cause.
> 
> The same assumption (iputils arping) is made by other net selftests as well:
> test_vxlan_nh.sh, forwarding/vxlan_asymmetric.sh, and arp_ndisc_untracked_subnets.sh all use iputils-specific flags.
> 
> There are two options to address this on your end:
> 
> 1. Install iputils-arping and ensure it takes precedence over ARPing 2.25 in PATH. Running "arping -V" should then show "iputils".

thanks a lot for information and guildance! we will defintely to install
iputils-arping.

> 2. If that is not feasible, I can send a fix that adds an iputils version check to test_bridge_neigh_suppress.sh, causing it to SKIP cleanly when iputils arping is not present:
> 
> if ! arping -V 2>&1 | grep -q "iputils"; then
>      echo "SKIP: Test requires iputils arping"
>      exit $ksft_skip
> fi
> 
> This will result in a SKIP rather than a FAIL for your environment.

no need to do fix for our env IMHO. this kernel test robot's purpose is to
bisect the regression and report the fbc to linux kernel community to help
developers to improve kernel code quality. we need to enable as many test
cases as possible for this purpose. so we will try above #1 option :)

thanks a lot!


> 
> Thanks,
> Danielle
> 
> > -----Original Message-----
> > From: Oliver Sang <oliver.sang@intel.com>
> > Sent: Monday, 15 June 2026 16:03
> > To: Danielle Ratson <danieller@nvidia.com>
> > Cc: oe-lkp@lists.linux.dev; lkp@intel.com; Jakub Kicinski <kuba@kernel.org>;
> > Nikolay Aleksandrov <razor@blackwall.org>; netdev@vger.kernel.org;
> > oliver.sang@intel.com
> > Subject: Re: [linux-next:master] [selftests] a3f88d89f6: kernel-selftests-
> > bpf.net.test_bridge_neigh_suppress.sh.arping.fail
> > 
> > hi, Danielle,
> > 
> > On Thu, Jun 11, 2026 at 11:44:39AM +0000, Danielle Ratson wrote:
> > > Hi Oliver,
> > >
> > > Thank you for the report.
> > >
> > > The failures appear to be caused by an arping tool version mismatch.
> > > The test was written assuming iputils arping semantics, but not all
> > distributions ship that version. Different arping implementations have
> > incompatible behavior for the flags used throughout
> > test_bridge_neigh_suppress.sh.
> > >
> > > Looking at the added log, the 56 failures are not limited to the
> > neigh_suppress_arp_probe section.
> > > The other arping-based test cases in the file are also affected, which is
> > consistent with a tool version issue rather than a kernel regression.
> > >
> > > To confirm the root cause on your end, please share the results for running
> > the below:
> > > $ arping -V
> > > $ ./test_bridge_neigh_suppress.sh -t neigh_suppress_arp -v
> > 
> > sorry for late.
> > 
> > our tests run in a auto framework, I had to add some code to print above
> > information, but so far, it just generates below output.
> > before we try further, want to seek your advice if these information are
> > enough?
> > 
> > KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-
> > 9.4-bpf-a3f88d89f698743a8cd91fb43f997e2d292a168d
> > ### arping -V
> > arping: option requires an argument -- 'V'
> > ARPing 2.25, by Thomas Habets <thomas@habets.se>
> > usage: arping [ -0aAbdDeFpPqrRuUvzZ ] [ -w <sec> ] [ -W <sec> ] [ -S <host/ip>
> > ]
> >               [ -T <host/ip ] [ -s <MAC> ] [ -t <MAC> ] [ -c <count> ]
> >               [ -C <count> ] [ -i <interface> ] [ -m <type> ] [ -g <group> ]
> >               [ -V <vlan> ] [ -Q <priority> ] <host/ip/MAC | -B> For complete usage
> > info, use --help or check the manpage.
> > ### ./test_bridge_neigh_suppress.sh -t neigh_suppress_arp -v
> >                                                 <-------- seems there is no output here
> > Per-port ARP suppression - VLAN 10              <-------- seems already start the
> > tests
> > ----------------------------------
> > COMMAND: tc -n sw1-U1mYwE qdisc replace dev vx0 clsact
> > 
> > 
> > >
> > > Thanks,
> > > Danielle
> > >
> > > > -----Original Message-----
> > > > From: kernel test robot <oliver.sang@intel.com>
> > > > Sent: Thursday, 11 June 2026 10:23
> > > > To: Danielle Ratson <danieller@nvidia.com>
> > > > Cc: oe-lkp@lists.linux.dev; lkp@intel.com; Jakub Kicinski
> > > > <kuba@kernel.org>; Nikolay Aleksandrov <razor@blackwall.org>;
> > > > netdev@vger.kernel.org; oliver.sang@intel.com
> > > > Subject: [linux-next:master] [selftests] a3f88d89f6:
> > > > kernel-selftests- bpf.net.test_bridge_neigh_suppress.sh.arping.fail
> > > >
> > > >
> > > > hi, Danielle Ratson,
> > > >
> > > > for new added tests, we still found some failures in our tests, not
> > > > sure if any dependencies we missed? thanks
> > > >
> > > >
> > > > Hello,
> > > >
> > > > kernel test robot noticed "kernel-selftests-
> > > > bpf.net.test_bridge_neigh_suppress.sh.arping.fail" on:
> > > >
> > > > commit: a3f88d89f698743a8cd91fb43f997e2d292a168d ("selftests: net:
> > > > Add tests for ARP probe and DAD NS handling")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
> > > > master
> > > >
> > > > in testcase: kernel-selftests-bpf
> > > > version:
> > > > with following parameters:
> > > >
> > > > 	group: net
> > > >
> > > >
> > > > config: x86_64-rhel-9.4-bpf
> > > > compiler: gcc-14
> > > > test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake)
> > > > with 32G memory
> > > >
> > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > >
> > > >
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new
> > > > version of the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > | Closes:
> > > > | https://lore.kernel.org/oe-lkp/202606110955.8f29025d-lkp@intel.com
> > > >
> > > >
> > > > # timeout set to 3600
> > > > # selftests: net: test_bridge_neigh_suppress.sh #
> > > >
> > > > [...]
> > > >
> > > > #
> > > > # Per-port ARP probe suppression
> > > > # ------------------------------
> > > > # TEST: ARP probe suppression                                         [FAIL]
> > > > # TEST: "neigh_suppress" is on                                        [ OK ]
> > > > # TEST: ARP probe suppression                                         [FAIL]
> > > > # TEST: FDB and neighbor entry installation                           [ OK ]
> > > > # TEST: arping                                                        [FAIL]
> > > > # TEST: ARP probe suppression                                         [FAIL]
> > > > # TEST: neighbor removal                                              [ OK ]
> > > > # TEST: ARP probe suppression                                         [FAIL]
> > > > # TEST: "neigh_suppress" is off                                       [ OK ]
> > > > # TEST: ARP probe suppression                                         [FAIL]
> > > > #
> > > > # Per-port DAD NS suppression
> > > > # ---------------------------
> > > > # TEST: DAD NS suppression                                            [ OK ]
> > > > # TEST: "neigh_suppress" is on                                        [ OK ]
> > > > # TEST: DAD NS suppression                                            [ OK ]
> > > > # TEST: FDB and neighbor entry installation                           [ OK ]
> > > > # TEST: DAD NS suppression                                            [ OK ]
> > > > # TEST: DAD NS proxy NA reply                                         [ OK ]
> > > > # TEST: neighbor removal                                              [ OK ]
> > > > # TEST: DAD NS suppression                                            [ OK ]
> > > > # TEST: "neigh_suppress" is off                                       [ OK ]
> > > > # TEST: DAD NS suppression                                            [ OK ]
> > > > #
> > > > # Tests passed: 124
> > > > # Tests failed:  56
> > > > not ok 110 selftests: net: test_bridge_neigh_suppress.sh # exit=1
> > > >
> > > >
> > > >
> > > > The kernel config and materials to reproduce are available at:
> > > > https://download.01.org/0day-
> > > > ci/archive/20260611/202606110955.8f29025d-lkp@intel.com
> > > >
> > > >
> > > >
> > > > --
> > > > 0-DAY CI Kernel Test Service
> > > > https://github.com/intel/lkp-tests/wiki
> > >

