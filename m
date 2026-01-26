Return-Path: <netdev+bounces-253595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BcAEtbQd2mxlQEAu9opvQ
	(envelope-from <netdev+bounces-253595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:38:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF248D255
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67743301050B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37C52D6E63;
	Mon, 26 Jan 2026 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYWvE25S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1702D739C
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459871; cv=fail; b=F9PJSKHNtCOJWC+Cxf4CaTVf4EuXbtnGSyzG7uKO7vS2gegcOvXJAX6MAmsA4MwMJ4bonEoMH38JHkGC/J8QOohehVPYfgIc3D4QADwshnUWrFOx7iwhFm/sJ5vwR6OUQwgD6qXTMOOiORlrbBPmQ9Mb6mKIOyT1HTmR4bsMOQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459871; c=relaxed/simple;
	bh=EsKuQ8UcO2t1EHa20NhBFxn724Ab5ebBWRnuvrZGT6s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QaRl7sRZQZeeEr70YwIo1cgDmD7Bbw78mVirVtvFzbgwHLGT/oQ/OHTBcdfXz8ZD7em6dn7sqpJvqPUO9UU2bE+1/fPnHT4TziwKc1K/+u3O4YWjuid9pQ79NlSELQ5ESV3JQbW5QuNnNX/0BfR25teuz4s6pyu9J2KCDSl5hlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYWvE25S; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769459870; x=1800995870;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EsKuQ8UcO2t1EHa20NhBFxn724Ab5ebBWRnuvrZGT6s=;
  b=HYWvE25SXaXOlb0NNjC7z5ysfhursG0mIiy5iM13oY8gIUSlp02ntxX7
   D4T+Av9sazJixAQRfO2130aUcK4k3f7puRXvK4bkdfvzHpzruMX0GOPhV
   41UojAVNIXaxXzAqWj81QwVGmkVSTwAKtFpSsJinzvicjGvMAxj19Lc1I
   CXIVvUIzk5sz8y/oLmcdQrJRk3Pi/dcE2uL7J0RZZmbT/NG56OqrsQLz3
   uDsynFyaRMQ5ZKB6z3LN6nz5DI/ObQdS5drX89IkLw28lD2CsQhINu1im
   DnPN3h6yNCd45e9Vfr+ypXZFy4VZyY8jRBwvgQE15Wk4YviKIlSwEjJyk
   g==;
X-CSE-ConnectionGUID: r9zGS5aISUaJfTFtc4yZXA==
X-CSE-MsgGUID: ohpDJC5nTq6oRtbMoCXZzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="82014026"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="82014026"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 12:37:49 -0800
X-CSE-ConnectionGUID: ONIVZW2EQ/u+emToN2mofg==
X-CSE-MsgGUID: NkbyExjhTYqJfZlD8EsSXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="239032919"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 12:37:49 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 12:37:48 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 12:37:48 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 12:37:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wl4yCpDXQQAAlbggJ66phZOnBOMEZZUbH78R9TyV/rU4KBqF5P1CxvGCbtF0BeBOHDR0RNdttAzJfbsWR0TrQCBoh4kzrhe/MLOhajfpC/dcFbNBd53Lggi+Y0BGI3WMW4i22qckBEypdftjM4N21KT/CA7CUw98JgVwgUU6HLDkjiXtQcuOe47mPvEFsBCJQOuXenyjNCyTyu211b+dIOZKcolPfpmGo10d12AT5cFyD6t+ZvRLONjIeYujYvJuPCiewh2SlzwM0q1SxDWkHtfwjxtgDXDZAzbiz7+jt11r1QzaZn2tZo0cRGaguttpaZEgUqBCRiQbs+uOOka8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9E46ia4WITP27+8H/69W0feMQ1k+4v+KRkf/xHABbo=;
 b=PTOMGMPXxd4aUZ6UFhnmg0uAxqTN7XEB96oQebj/XvcZvkWBXRSi240dXKf6m0ExYVTEvbC2CBXGKvw6IxCJyK0Z+/zvf11l+2TKlm5JZ27wCgtOWr55w/91JCxJWhRb3+xn1WSRlKvqoMDsG4AVgV2hG5y9ly5lB2j0wtvpY83w7QbqWr2bxGqsAnbHkd+xT2iAO3ISXgrX2MreNDCuyo0lM1xquJ2nxTxHsGQJrW2E8uJcpJ2aJDWOkCZ3hBtCIuDDOA7Eg8p/3OMlCeRsJWUj3468N8WQTMD4smSUnbetpwPslY7GDD4mLo0Fp/UFXDXDnLo48iOAmgL4JJEmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB6545.namprd11.prod.outlook.com (2603:10b6:510:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 20:37:41 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%6]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 20:37:41 +0000
Date: Mon, 26 Jan 2026 21:37:35 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH] i40e: add an error handling path in
 i40e_xsk_pool_enable()
Message-ID: <aXfQjwrtvx+UdeB2@boxer>
References: <20260125140423.2077845-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260125140423.2077845-1-lihaoxiang@isrc.iscas.ac.cn>
X-ClientProxiedBy: DB9PR05CA0011.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 53735ac4-19db-4b23-9b82-08de5d1ac06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uiFrLAgBcVJ1i/u2o0ELmo/UhjwuHuWWloBmgFHN0y0b4afe9Z1UKvqexm9U?=
 =?us-ascii?Q?/7gXuyc2GVRQ2taFeNrix02WaaO8vhgJm4Kq7R34A0NmMIfQSsivakafw++5?=
 =?us-ascii?Q?hcrxM2frvoxK37TSQ2eMQDxvFOSaCVSn5df2xBUzAN8H8SW1so1/tgT1IqEF?=
 =?us-ascii?Q?x/p5Wca3tNptI/5dUIVB4JiUy0Sq1R5dl9vRm0Mbvvzez+gWI47cBygEI1ju?=
 =?us-ascii?Q?trloPPsoU1OrtolSreUTMef4bcx4GYcs1bCHKTnvFg9GkUeGu0E5rxJdA1nv?=
 =?us-ascii?Q?fbwUVlcQ7CpgR08Z6Y2jhhWt3U/u3FHGhGnxeruXanzjsk3B/6KCGGOMvLdB?=
 =?us-ascii?Q?SioJTBirQazBVXjhc9TsAoRfMzc0h22rervrNvqSZR5pkcoviHe/bZB38F+B?=
 =?us-ascii?Q?hw7p63woy4CUo8JSzUuGMwLWixSCx8i7DWor9gODNTspWNn4155VlN543HEL?=
 =?us-ascii?Q?5B93d/kKAZHvt8kDEuIL/wHs83i9Wdl1DwYceK6rDhp748qbHsnk6EdbbZkl?=
 =?us-ascii?Q?+ED2ywMv23cwiuLgpJkhTD1aDKA8u6zksTpul5bjhnO03QdSVBjafwSOJ5L9?=
 =?us-ascii?Q?jU0zW6L8uT0JOIVHGIuHyzuQdUx/DBOP5feANetnGJdAuVcQ7efqUxdpgOyr?=
 =?us-ascii?Q?fHQeG9e+stYIxl/EcOfpuN29FO9uxONzeMy9ktHRccvN3vdSe6DjdjEErf4E?=
 =?us-ascii?Q?soPCd+Iwja3HzwTDgxnbQ+chdmoTApCzfK4SOoiPc5DrvgAEt3av/Z+fcvMk?=
 =?us-ascii?Q?Kj6jz1tL942fkz8tbxzw6FuMxpG5wTaPIf4eSK4wBbEDvbAGOQQt/Tst99r4?=
 =?us-ascii?Q?wMUPKjzB76pB25CL7KxU60rO93pPR5qZLw4Zml44bfU0y8p8SuZOAcb1bD00?=
 =?us-ascii?Q?tUvqWPw8MeGwoh2lEBghLjvA37ZPrVkqWOMXZ1lh09RX4UEM5Ho5nKkAGnmD?=
 =?us-ascii?Q?3fZ6aEs8P+vLs9xImnLPuWflGdgGQhjOJ0yqSjd1UewnrUI7lejtg/huo8JU?=
 =?us-ascii?Q?AZN2uRi/bJWTtzy6MCo8PfGEUDal1eaFR6d0kz6CjqM4bVhZ/+nfcYhEvO+p?=
 =?us-ascii?Q?jxijsSAkyMDSypTmDuJZEqW70pzUMBchvRREMZ8H2054Lpn0GN6EOfnIl/QK?=
 =?us-ascii?Q?hMzpQgDus5dJsndMbmlxOAG69z4yEN2RZZrcnSxAHA7ke+m6FJpf7Mkptvf+?=
 =?us-ascii?Q?crMmwcM9niYDenq63qesCdSaAhsQrZ2Ni2q6iu2SrE1HIQ+QWAhazzJ/qHS/?=
 =?us-ascii?Q?VeJmQ+3InyelPuo1roxU2oUhTMGaBWwYLnphcKoZPW6mYaTaKPH71mWNuK8g?=
 =?us-ascii?Q?GtODfhzlAKM+3jYU0IBwyLfSpW5cu0dHp0iq3yRy4YDwaGTrJ4lfewbjIlBY?=
 =?us-ascii?Q?cJadiGeEVfClt0lVPYpiTGbSTTZrodUCXzG3p4MMGnIE0D/ZzdCVgoZmDL4A?=
 =?us-ascii?Q?HqV33rRe1oKnb3cZENue1nfgEfQPxC9TACnVMADcR2RUJOa21tkwB6XwmzDS?=
 =?us-ascii?Q?TY9XploQ3JkvrQATgUAA4O/qHmE5OvY03xg3tm2YqYHQkAcbQY3B6h4S1O/W?=
 =?us-ascii?Q?zPFkhwSANRxYefjJQ/s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N1llqWc58JOOzAtDMhg3oYGT/qfRG5VUfAr4Qehkw2zPl6HAgWVStgk3otjg?=
 =?us-ascii?Q?y6kgSqxqemThxHJ7JBN5YW5qIL27peWNOgpfgmSKDvllOcqPVhWyRw/6dU96?=
 =?us-ascii?Q?ytiWhDIn4oCvK7JkWWxnHtO6tOHoDGqypwO0ws1mj/VUvF0amzdZJd1zF5AZ?=
 =?us-ascii?Q?TyLSNcc1n5UQxUOog0YEoK3NFNEzD/Hk95+XmTVZpujDNTXPnJaaIOEIQQOi?=
 =?us-ascii?Q?2fw51pNSDZfgBErgjR5d/11ecKyg5lWIhCqWcaeKNnS6m6tFhcADphNed36b?=
 =?us-ascii?Q?/+q2a4WYQeLoWgPD/HlpHLiIoCXERjyRikzvvJxL5AMABP6iqr6Y4QQqBYXE?=
 =?us-ascii?Q?jnv6PugTDfD5oHccBak7RrruajzBTbccxoSlG3g/IO8NHHjbPjXo/XAIe2Mn?=
 =?us-ascii?Q?sYcbdSHzeZ0z0s7kXWC0+nbeKV2ycu6eFyjK29uHH14eKb0otLjmABVleydq?=
 =?us-ascii?Q?5EtNY7BGBNNExRkRLDbm32KUjkpPM3FQzNg6OdfAvPdbaZ6pTYrEukapRsZR?=
 =?us-ascii?Q?xgmuM4DOgVwfTECAgwW8WB59o55f74WdTD5xVPMwU1V9XowJk7rOGiLRo3ba?=
 =?us-ascii?Q?PS1nIgtJamw+FBlFsGCm0LQ01s7zDIyA6P0zGpzkuYffNQ5wVXs7Jr62JZWm?=
 =?us-ascii?Q?8QAxv49LfKy+BeXe1ZNaAkUbeiMpfzuFpwHA1/+NWzr+Y8mU11QYB6SFgJ9q?=
 =?us-ascii?Q?gIpg5Mdp/JtsAOF25wn7tHsHkzctXhYLg53NXfqek5+lLPuhQP3e+2TyCqwm?=
 =?us-ascii?Q?Lv8/G2qv0+npVQKx0Sqs/kroWjmfu2NgYZLi/SAZCDE+aIE2sxer4HAT23FW?=
 =?us-ascii?Q?7liWYKNIzBxzkZZHrTkutNwK7oIux3m2FXy8Wy1g0NVMPgX1vsvJ1sI06fGi?=
 =?us-ascii?Q?i18bcUDyz13eyhHf3bfzeYfu4+oALqVQijS4BuQRT4EaD+FS/idekVnf0xQc?=
 =?us-ascii?Q?ietHraP2/7kTtx82sVxB3TfKL33mO23fxbjdutYW4+Wwq5KxTNKy8zj/OMlm?=
 =?us-ascii?Q?7nJ5r0pg2aRaDu+l8gN82s3mPCTwb/z2H+LmmxezAf+qkxouNiQT/7ti8LtP?=
 =?us-ascii?Q?zBQnkzuxjtZvcJehXxYvfQzAplX/AvWPM2hDSPArf3WTp38caOONiDp9lAgx?=
 =?us-ascii?Q?unhTcBmmMZ+SoupnqXfM7707oNogntjdE+DScsr5FUK1iihHegBaM+oRIQth?=
 =?us-ascii?Q?mFQfRZSctPYmfYVOxA4uSQCAT6L8f4YWL3QNwuorBVNcxA4UDfyHS6yu0fjr?=
 =?us-ascii?Q?avQTBlrDTmbhSppA73jYid3iBbIyOUHbPDtpH8AThe3FE9dPFxkYQ0zJLFIm?=
 =?us-ascii?Q?nRrHW4wKbU9Ce7jVv390CM2YTeCyJskI4K7MdFVYMSQ8FM2fn0OBUoRw6/+V?=
 =?us-ascii?Q?/8GW0PzUp++wo3/lwQ0ZrRY/zi2GjGzNLNjZxB5/k8we2al3Z5VSGh/b1bUa?=
 =?us-ascii?Q?EzM4IGkDD0PWL5RTscGRdP5s0FCL+bQpbRaY0Nrsn64CzNAVZIhAQXJdiGHd?=
 =?us-ascii?Q?Gp4hPiIjNjDRZ1KciL3XhoChBSr0N0G9iTsteQEe+C6AxQzCk29Qxo8HGn3f?=
 =?us-ascii?Q?IYX3b4bFJQMgwHZ7+PbkUqZ9rdRhEEblHj9d/9tgcVJ0EhXHG/nVM9f8Bjjn?=
 =?us-ascii?Q?ztAuN55T0WUugRhztxZPueXcPev1ncPiCMrygx0FB/vALv4DGTjSgl9ufdwv?=
 =?us-ascii?Q?WSbq3S4PgKF25jCSd5hgAHegfzSg9x6WIyNbTHZP087RPbAaGGC2Zd1Neldn?=
 =?us-ascii?Q?vsy0aK7rP4D5WPIKMf0N4CnMrVOtF7s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53735ac4-19db-4b23-9b82-08de5d1ac06d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:37:41.3557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2/RnWuLLC4yYvsxzbBvPg89DPeJlDpVWbYkYCyYTFpa4vD12y8Tjjrugxd1NkYlcIUdnu1S0vp3voKh0GmmvPZm2ZQnPMUuQJtIc+Ee0oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6545
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253595-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9AF248D255
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 10:04:23PM +0800, Haoxiang Li wrote:
> In i40e_xsk_pool_enable(), the memory allocated by
> xsk_pool_dma_map() should be released if some error
> occurs. Add an error handling path to do so.
> 
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..92b853a75b28 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -108,23 +108,27 @@ static int i40e_xsk_pool_enable(struct i40e_vsi *vsi,
>  	if (if_running) {
>  		err = i40e_queue_pair_disable(vsi, qid);
>  		if (err)
> -			return err;
> +			goto unmap;
>  
>  		err = i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], true);
>  		if (err)
> -			return err;
> +			goto unmap;
>  
>  		err = i40e_queue_pair_enable(vsi, qid);
>  		if (err)
> -			return err;
> +			goto unmap;
>  
>  		/* Kick start the NAPI context so that receiving will start */
>  		err = i40e_xsk_wakeup(vsi->netdev, qid, XDP_WAKEUP_RX);
>  		if (err)
> -			return err;
> +			goto unmap;
>  	}
>  
>  	return 0;
> +
> +unmap:
> +	xsk_pool_dma_unmap(pool, I40E_RX_DMA_ATTR);

Hi Haoxiang,

this will leave queues in a limbo state if you fail before qp enable.
It would be better to call i40e_xsk_pool_disable() which will do the dma
unmap internally.

> +	return err;
>  }
>  
>  /**
> -- 
> 2.25.1
> 
> 

