Return-Path: <netdev+bounces-267401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG9uNSXss2mDdQAAu9opvQ
	(envelope-from <netdev+bounces-267401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:51:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C460281C15
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE6DB3151A39
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894A96FC3;
	Fri, 13 Mar 2026 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jP6W9Raa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A337DEB7;
	Fri, 13 Mar 2026 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399011; cv=fail; b=EhpYZlPmPxEafW93/RUVeC0f8LoQWeZwSu266XUxxm4Shw31b48n2qU/2Dsk+TGFfz62BrxlP2J54567n30VKWhGTOQ7nlyt12l+BhWE4uKp60ywlbbBxkdST0TFqgUI6SPecejmy6XjI8Zexz+GM0KkVjQjN1GGdcy6ZRpmOlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399011; c=relaxed/simple;
	bh=ZPHUMSDWPpuDJsPgH9ZNXVnrEy5YI8DmIB1SZd4wufg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F75/FhVYqjQxOWfmWz5Q1j0pBBIkf1m9gwj8ylGj7R51wiSQSTXM6OeHG1ejvqo55IIRwgX0B740MYUpouepMeRSY79N44b5hR3GbR3LAOY7uWm2YkTWNNvBSY/9lc8/3PUiXIztUe4rLzd22hTWVfBt8v9/2FwYjZUXLdWOyn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jP6W9Raa; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773399009; x=1804935009;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZPHUMSDWPpuDJsPgH9ZNXVnrEy5YI8DmIB1SZd4wufg=;
  b=jP6W9RaaQT9C9kBoh4sF2XsJ6t9ru6ikqfHSsPFys+m6cEcqIYJWsUMV
   Ua3k/clJXzRVTojwYHy8EvP7LmDMTfa5pK75tIVwtGgRVmxB541knDuoy
   YkZ1S5bXC5eVeEkVzD8gym32GjdauH+a9h691/194SQQQp3tz0SZ0/57i
   YGe9FTWzo3I5vzUBdeSPZDJ7EijsoIirvWfzy+J4nYCwQ4BFrYVN87D2R
   YkL6oWB7J9q3DuyOJiYRCMh2N6Ru2JH2T2smwCAN7ODnLyGclH7AP2e60
   M2Jo1puQiWehpK7NWLYueruEwXSRj09gvl5uBYkoCQ0ZesSY3CWyFprVl
   w==;
X-CSE-ConnectionGUID: N9PLEFrCSBeUWTag6Xm+kg==
X-CSE-MsgGUID: XWz2PRVLRHmpDgMGgURZXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74204739"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74204739"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 03:50:05 -0700
X-CSE-ConnectionGUID: izD4sh/uSaaRcm7t6tqzAQ==
X-CSE-MsgGUID: TNUGmLUbRS2zy9Flu93nhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="221340581"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 03:50:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 03:50:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 03:50:05 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 03:50:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVngbs8VxPDkw8VOOhPXdWf2prbkoAagOoW5Gbz3Cz1l7gQKkYuFgJKHw0Vt8XPz2I85nlJ6rU7NtW6FvbbtG9wpmAHMjyjo4c7hr+WsE+FzSR2C7IcWFuzjPbhgjfIJHAPlaH5oD+GAttha5yYfasbXr5/lU2N4KPQ9bcFVyCTh/+P2NW2ew0Nhi2Erm3Ivv/2BrHf58QHvS4sY73GW+EL9o6YY+zRrnEbjp/zUdomuWSq0bCrMeJix4zQLU4zThsjicrh4K+2yOcr59SscK8ORQdJIXu0LWibmYXAxWl3mzjkyoygCejSPwmtO++oFbA6PsrpuEdpLeDqfNTIX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61K9e/7tZScWtDEsJWelB62imraGGgOuQ3jDbwFw5uk=;
 b=Otpb9Kf8ZquT5hWyEIfoa0DhhN96qotKUDfAWTU28Vdv/gaCr1qkWxIXK5LlVVly1AzwZLxTymlJ3Rb+k9CtsQQFiqUuRRFC4z7EPlLx8Kb6RSFR44Y2aaO25C3iOoEXmttykDiWRzkga6ZSpgArhVmQ+tcBgNRdEQ6ZMBgvYuOOTXYxdlpOwxqA9JOC+9eNS/VLIHniuy+Y5SvCNJNLw7n3SbnS+Mx7IsSSXEaqL3+AcxkBR4jW2R3wxaRQrZrIOXR5vlrfA9Kwe/ZpDRqnRo8DlShxU1DMxvEnds8fDsHVBgL+SJ/CjoGOXujXbobd7c/y9wFTaN6etQSfot5tgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA0PR11MB7935.namprd11.prod.outlook.com (2603:10b6:208:40e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 10:49:57 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 10:49:57 +0000
Date: Fri, 13 Mar 2026 11:49:50 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Stanislav Fomichev <stfomichev@gmail.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <magnus.karlsson@intel.com>, <pabeni@redhat.com>,
	<horms@kernel.org>
Subject: Re: [PATCH net-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer
 Rx processing
Message-ID: <abPrzvYABPo7iAzq@boxer>
References: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
 <abCUMtO8Trtzs23d@mini-arch>
 <20260312173348.4e70cdec@kernel.org>
 <abPZXXt/xCis3tIg@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abPZXXt/xCis3tIg@boxer>
X-ClientProxiedBy: VIYP296CA0011.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA0PR11MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1a8198-500e-4dce-065e-08de80ee4489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XT+GXF7s5iXlkORPZLX7LACLlpD0W9Ow797+DAbRnU7HNIx5qyo/cTtdMNvXKY6WN33vgFEABomJrT5hsVuIlTzyuzBNtC696XmKQuAhdbqNdokHt2k+DgMhmPB/E/L32Hkv03Xphz00L0h6z8CF32rDXrVmaQF/abmb3B3KFZ/UlgN4pStpyZPcv1DYkkIItDk2jTm8ZuHkSpeKO98InSyP1YZbgyuV6IFLU6CTu+2VahwM/z8WA7KCdGDg1QvYYzdK6pH36OobZc3gwMNdE0jzB+xp+YvIBnCv4cHGS+OwPJL5xREO42HCmLo60EjbAqw2j3FSUYgWCTlwyb3Ce/g34H8DGuzYeGmQQ5VP+zkepHlLgevbS0FGO6pPXKlpzfvLoUF0yBsf0i4kfm8mIEANv3WWCA3Q7LSAdTGY+A3GfuQ/EK1I/jQTPuBScyVDTs9TBThq0qpVkf7/UId6HTDlTNKowwxtHlcKvJlXR5GeueO03YIF7ERCbzu8O5elaN+Yx1pTf5MOCzDuYHJoLxjLQNg4k2BS0DtZ7QxOyPMVGIaYtLX3n0L/Jo6elLIEfg2FPMI8g5lUv53PTe45szsgDjNcLcIXnTWlYCRazD7wo8nbDB4tIfOvK3VBkEYFL4qiBVcT5jJJamGNxfF3EOPKqlNPbaBE7C+0yR7te6UWjFr/64FmZ45zB8l3WCP/jRVut2AyBu7fOFRdFJbUw7wiva8GP7hHwuVtHrutxm4/0OPJX0TmHc7QpA7Dk5Dt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yC1iPOem6MMWKiaPiV3SORVEH6PKa/JdHOe3bXXY7qWyQlU4QtkmwGqGRfTT?=
 =?us-ascii?Q?jl4c/b0OlND30tAoG8QH8ZPrmo74+eecwhPiuHa2i2JGafiN5mIQBHIjf2Fq?=
 =?us-ascii?Q?RssXpYMCFt0tPTkTlxtS14e4TAjURhjypWdemMbWY72Kz5F5gkBsGrusgwJ0?=
 =?us-ascii?Q?Q5vXEBXX0y7p7GhtRZs9W2kjJgt5phKX/b1TZ1ZFUK/fWcyVeTcYQyjrw1AW?=
 =?us-ascii?Q?z8AYVHGisg1IRJn8ZEWR7ITa/m0d4YhBhDtZ21PdSU6sh3+xTZNcXqsPv+mX?=
 =?us-ascii?Q?MvtuH8lPxKiwAvmEe5YzjkRvEy6VEEn2G02q9nz7MgahrORFxx1//NVJ9mJE?=
 =?us-ascii?Q?4jxLvyQn9CpsgLd7tgO0FjLq6+7/L1H7fh0GIzIZhbTfY0MA1AU7wdd9ZcIr?=
 =?us-ascii?Q?k9TyoB2i9GlB3wNyyWVeCqusOyhUosComm+nZ2oQUWz+48sMjf3J+ugUmvJQ?=
 =?us-ascii?Q?AIkHOM3inEb2EolFlASS9S4DLKDw5axQBWshEuZtcVcrF63quFJk0j9r7xHv?=
 =?us-ascii?Q?T6dOJaB8KqpWjhwSibzIt/nF+334x3B4dOiR9iO1bB3VCRqsBNyI+9sciQ15?=
 =?us-ascii?Q?P92pH9a6nIOoADSd3u2eLEmzS53gEeRBatz8b3GHb5OGUz+qiZzQ93psQhOG?=
 =?us-ascii?Q?VOedEYod3GW/b/PwnJWxe61pQtJKJC7w52oBJm+bP7LVqyqv/ZRDYazDtysz?=
 =?us-ascii?Q?9v22bdIVYdGYqG0Ltq9y8UK1tuhWXpigFUTp4ahczusQG12CTFS7X/dgpM4g?=
 =?us-ascii?Q?Mcpka6q2XGXyrz8hT1w0vYckZKfXSx/m/j0nzOm5QOKBA2WWqaA/x4pfbWow?=
 =?us-ascii?Q?XGQncGjjhkp1nCjTTk680IKuTdyJIUrSYzstnVBuj0VH8Bcwfw37k5zdGxQo?=
 =?us-ascii?Q?J+MKElJR9dnkgxqLKEBNF+l2MmB/1L5UAnQLGzkvJmx30SQOupGIZd0/mbnX?=
 =?us-ascii?Q?ZjaOdp3qk4nMTvbpdMesObDtBjYvEEJxkuj8SvxekqhifIwFmKXrkXmPnvVI?=
 =?us-ascii?Q?7wQlgHQYxYQD/f4x7IkNLGHvqNws9epabkYniJSvcVX6HwexpJ3M3J3fDk7x?=
 =?us-ascii?Q?VJ+qdxtoUBlzbcaJykmdWElkhWrsuGlGb3gt9QenT6nce3WYAsKPMkz2II65?=
 =?us-ascii?Q?6BNTd9KJkc6+7zSLxOV6LGfDyPtX7du13mqIVlC4IilDKzuNSSNCtPYuvsGQ?=
 =?us-ascii?Q?k90AfTT743dlz/oOzmOqHqK2VBjK6JwLgchJCc/UF6wN8tPp+hHPIPiEI3S8?=
 =?us-ascii?Q?RjLK+Uwn7Z3TAQGWO6sMGZSdqVl6X1fDMXc3U65oG2VXuhBp5jqAMbciMMrB?=
 =?us-ascii?Q?YCOGqyLJQ6mXzG/CtsV7dA5YUELqL3eADqSf0BUUf0mbHHLHwhxCi7zq7C2d?=
 =?us-ascii?Q?pMInOkZIQvTh/BFsOcAt0Ia7mFyzamrrP28g9ElCJbM4acgPQXpRCUWVKu0s?=
 =?us-ascii?Q?GnAKqS58iePsjV33h9MSXh5WlWF0uIHzri7QrHWOUSu7//C+SFDdnknl3FN7?=
 =?us-ascii?Q?oqcA6RTTsEa2rQYuSmf8eGHbdrzl/Md51gPcQIScKL3WAsO0aBCJG+I0fszu?=
 =?us-ascii?Q?g6UcCPfl9Xl37ZiM51C/j9biE7N8wGw6VGHgJOmpM7pNm+07Iug1NLwIy/s9?=
 =?us-ascii?Q?Gc6YzJcvXEjECEbD2BgVPSDPWdZVCFghlOXtkxeEHTzBbDgYAvu4cezSw/OK?=
 =?us-ascii?Q?BM/9lXeboubJhax/UYKrFA0oK876gqAzxP4fe+fgWi0biLiT4ThbU7LC+pRd?=
 =?us-ascii?Q?/yReSlEPj2sQVgh70OZTu4ZHZM+efrQ=3D?=
X-Exchange-RoutingPolicyChecked: oHRDlgUsKfOar83klgoLTvVFRBkyfQHZZBlVti7Yr89mB/vuXm3b6bUnl+CSxyB6xhWjM7ltGnIX7AUsQgijt/qtqcbMgIjBCY/1QhY6rfaQ8g35cmGM7NGlDppgBrD57uuJSo1B0nWWfGAf63D/f0MNJQsmhq2wAI5nCoHAeyv3s0/l0aLHZqj2U3jwcVISiI2oxJmp+62bV1I9Ig9ZRmuPvNcecjyLauU1kEm7R+NVGYGQE5flrujkF0x8TtWE+ziFf6sZoGNkUqOS+wgW2nJ9U+ZVOtIlJGq5eOz0Lqgo4EZSlVX3ApfMzaUlOww7Z7aA6JptyVEwgP9R+alqYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1a8198-500e-4dce-065e-08de80ee4489
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 10:49:57.4834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aIz5v5UjZGtUw3znZkTYHCaz/S4qqTUeQvNxO4flhUCrWTlunMuYUX/vJ1kGB2X1taSFMgQqGOAXtdGYMA5PSTovfhgy+Z9I6pF4gflQdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7935
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-267401-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6C460281C15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 10:31:09AM +0100, Maciej Fijalkowski wrote:
> On Thu, Mar 12, 2026 at 05:33:48PM -0700, Jakub Kicinski wrote:
> > On Tue, 10 Mar 2026 14:59:14 -0700 Stanislav Fomichev wrote:
> > > (build bot seems to be confused because f620af11c27b went via bpf-next?)
> > 
> > The pre-req is in both trees now. Please repost?
> 
> Will do.

Argh, seems like it's not there. Maybe you meant Nikhil Rao's fixes, but
the pre-req for this patch [0] has been applied to bpf-next, I do not see
it on neither net-next nor net tree.

On bpf-next I see this as f620af11c27b ("xsk: avoid double checking against rx
queue being full").

[0] : https://lore.kernel.org/bpf/20260218150000.301176-1-maciej.fijalkowski@intel.com/

