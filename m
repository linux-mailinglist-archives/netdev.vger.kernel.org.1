Return-Path: <netdev+bounces-163643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47E3A2B230
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08546188B9EF
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D621A8F95;
	Thu,  6 Feb 2025 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0Mgm1dL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C455D1A840E;
	Thu,  6 Feb 2025 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738869810; cv=fail; b=R55DmVFibHGz8IfG72EYQG91KamiR+pugtTAIu/KTap6vR6rYAIYOMH/6ZZzG83mC/U1VzxfuV5EiAA7G+PK0IM4UqERqin8APNkBowrj5rB+FmcuLsHdaikRZL/1VrPRNKvWqOksbXO3qYAusRZ7WstroQmEUGP/K5QdirBOFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738869810; c=relaxed/simple;
	bh=/3pHwy2zNdP/iR6r56EOYj9CBy0YsSpPx/5XFQ6NZjY=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BH7zOJd5JCz6tNky1utLnaNFckaUWeToX3cDJlfFdHyawG1ruZjLpXxV+KqK6c5iEh1MCxIl35KfMBuNl9VmF5+blvt6TBOzyX6phFNkN/imZfpNSPT+y/rsDkKBBgrYs+wBvwj39JUnkQXyWvoMV8hfMjrvCmYyCaeR2ku5wfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0Mgm1dL; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738869808; x=1770405808;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=/3pHwy2zNdP/iR6r56EOYj9CBy0YsSpPx/5XFQ6NZjY=;
  b=k0Mgm1dL4ZthACqgk8LVf8DO6hFI+KnZBESDXFVYIFNQZs1W08cDFZ4x
   m1PaA4xfcZ/ZQUECrWMofrARxJJuJGaRgx4OxaImDTGVXAfsqj63ICjd+
   muwnm9PoeKxdzu2vab8bk5kYBJO3fVx3ykI13HegUtnA+QJYtqGLuGQVk
   89khIYIsc4XqCohER4H7hOIvBsvE84t5grSBfsoF9uCh/gZjjNVrEWk8g
   x7no2R0vInpvQ5MiPp0YCs2qFKpori5jyU7LTXOYu50DnSPuqdpBgJsHn
   q4Iox9LRgPX+irKdvnHRnaJtkONgij6lyHzqOlzvY/eptDcWeLZt7/KvX
   g==;
X-CSE-ConnectionGUID: 7NDs6aVgRW6qu/DkMf6Mig==
X-CSE-MsgGUID: E0Cf55xHR9eWoQHSAitsyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39399084"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="39399084"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:23:27 -0800
X-CSE-ConnectionGUID: dMFPMJHBSNOAxVrb2jl/pQ==
X-CSE-MsgGUID: SEcnmhwSR/SMdESAO/VmgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111164376"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 11:23:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 11:23:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 11:23:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 11:23:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjNfaMgyNlzRUmscGDK6GxHrQW/zBHRtPCDqcmbrlePOQKlGk0fqH7Shkc1dmmGfXv75mUKYKjOYXOf7iBVGl/cULiSL9gOt9KGKMqSMVtlpjx7fZpkMbg0YH8UFhPmirchoXSSyW36WG33Owsrr5OLTkmzsUR7L2QNHovu4EPrrldVNqtKqx+9qD8od2EgJ9nCZQzbcbxIh34Ol4VLpKOiF2MpHh1CosSqFc21AIteEI7jdkVTX3MZh5wUAXnOlVomHIHahpdz2C8d76EppzvyeH/3SdGneDHDWkFnTaheQH8fKNuK+yjhsEhdwnmVy8umhxPOo+P5B8ZF3HT7eLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT5QUoFHIw/NeuetoMkD8eee6Eh3x5ZTEwUNb8YrQNI=;
 b=GAK/XMNR8U14w1slMGdZvz7wmr3s+hsTEzKATQq+26BWyeQWrpvcSoN7dg8FCbZfaeXkFOMjN9UwqSztKhQ1qSxpyyZo4+arNJrH7EaJ60bSxwbborukPMF90CDCK1t/YAuXnoVn8/RvShg225/1o6areEdryW5F8u5d537/6vqGGHGp1O5L6EZcZKKcXN3rvM7ajRQTrjcEbEIJiLQHIRIUj7SJN64UaoFo9UNELS9EDO11Jk61RMKAXmDmwBlkYEwtABkr4+DjcfZVwqVK6r1BKnlcEbqExoSC0aACf2RJqXCk1jA719K1zwB+3iU2R8vRZU5zLfF4BJuPuZvwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 19:23:10 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8398.020; Thu, 6 Feb 2025
 19:23:10 +0000
Date: Thu, 6 Feb 2025 13:23:01 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Ira Weiny
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v10 09/26] cxl: support device identification without
 mailbox
Message-ID: <67a50c15de8e1_305d76294d2@iweiny-mobl.notmuch>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-10-alucerop@amd.com>
 <67a3dc0071693_2ee275294fc@iweiny-mobl.notmuch>
 <9ce2dc57-ad51-4587-8099-60f568984b84@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9ce2dc57-ad51-4587-8099-60f568984b84@amd.com>
X-ClientProxiedBy: MW4PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:303:84::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 389a706e-97bb-4c8f-c7c5-08dd46e3b174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zU8VHcHv5FM9P0gSnCFuWDgvfnh3r9xmDFPrq/9lHQPHITmHqCkMaVHkXxe7?=
 =?us-ascii?Q?8tyz+0Dr0NoxrakfmDJSPYWvC5WlgXF75EEhvMRHG8Y000JFC/BMDUDtigU9?=
 =?us-ascii?Q?KJntjyt6vIFvh5fAOADcWpiYU0nEQ290bKkDorEnaIzz0CrTJEtr67NUZWry?=
 =?us-ascii?Q?2y5RvpVb6UFeX3imSH+jiHQ6bUvU2Dq9SYmub+yiosaLeYNKiW+UMetYEs4Y?=
 =?us-ascii?Q?E5000JEnNsYzLDDaVtcSeOFYLEu8W7GF9F+K1bFNK077vmtPgZ7qEYLLMA5q?=
 =?us-ascii?Q?9Zg+BxzBPKvjMaTv3eOH2sbSl2zXpaYZhtd0UU0MBbIqthc12nP9V0DNEQgn?=
 =?us-ascii?Q?juMCsr1ZuVGsWB+bmHMkuTzctZDUYqlU8cnnurm8zJcbV+BJ+fQiOYy9Ot4G?=
 =?us-ascii?Q?y52jPU2N+84AnRKaDX3RPu7Kww48nbYCuQ9bKcdWly60xdfEdLkZOTSUXWUX?=
 =?us-ascii?Q?ajCLYP6M3vmgeyxyoHsvUS8VL9v5ObMs0ziFRkWN26BqniRqL/9O1UBGXofu?=
 =?us-ascii?Q?QvOdVyWWZgwQRjqGnVQeJ2q5WwvH08Woah5VwPCSFExC159PE4m/ER25pV2m?=
 =?us-ascii?Q?T8O68L96SmTgnqCbc+uNJcA4gS2fl1P31v31SlKJEx73i8hmTP9U2pZxDfFs?=
 =?us-ascii?Q?7EZh5ff7axsTOi1ZYn3KNOScDeONO/VglL1usLZ9ER/zu2adFSpd3rA8aJjh?=
 =?us-ascii?Q?46HffTXqV8S+ig5B9lksrLapAQu3koFRbu2ZH7Y6QpL4kD0On2F7GTYoiBAC?=
 =?us-ascii?Q?dondYdPoYh879LVlz1G1nCj0CnZh7l4edYgHYuGr0Mj+P03PwbL8qj4WmRsY?=
 =?us-ascii?Q?PuVbOewa+jFICtUMfP9nTrZlnA93YEW+Ausi1/IQb7kp++ixUgujb30uHjzM?=
 =?us-ascii?Q?IVwL326LDrhAfKyImxYPOpbewnlgkj0RwL31512tWCkmRy5KYTmMI+iOLbOc?=
 =?us-ascii?Q?fg80hDcwM8+NCw4g0xF3Fl2Fh7eEtDpz1fqjpclWl6qCKov1uNbfTNz/pgtC?=
 =?us-ascii?Q?bCbLnjB+eRj3fC0wTgqCNnciT+JSzqbo22Y9zGUSFT6ZnbXS1ma4eXX10b6t?=
 =?us-ascii?Q?F8KOzqpCCHOVw4aBcG8KgNE93yxGjiT5D8JywBCKBJffpg4XA6zheaa2N9nw?=
 =?us-ascii?Q?eAoekq5X7PEaY8SNuSvIvOicz5zhZIeKxBhdJ+ZU98VctsU+VhWzVK+jBznX?=
 =?us-ascii?Q?tZt1mQL9lWU5hoVdPL35Zq8YqVgQm1eZaPwqNWzPYxYdEk22F5Gj0degAPkT?=
 =?us-ascii?Q?eK4GBnqQXJbYRrmOuVXM9hh6cRktCldTiZjwBxoTGe8GIElzO268BmNCG0FU?=
 =?us-ascii?Q?KqQbTQJUewaGD+nRQ52e55F8+9wsDX7JOx8OLyS1BL8W7jlabT9wQ6XuqfWs?=
 =?us-ascii?Q?im0738QmKes7GtDSsge75mwx0z84cZ5JxKVRc4CwJCtNNGk5YN26U75afGIN?=
 =?us-ascii?Q?5WSV5QVImEc5ZNFU5yKgpwwwUaW3UVEV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g8Hcyk4GMsGZBTpLq7XIayBlsc73CY1PUUE3e+K+Ywby8RC99y5KhZ6mLpgP?=
 =?us-ascii?Q?F+wnoJtQAxP9/QxqWEdHxR5EkFy5qRZU68U2AVocL/ho/5EgcIPjHNIFSc7x?=
 =?us-ascii?Q?+3YWiQ1wfre7UcNWQZhpQAqehceEid4cCi1hxD0+X5VA3nwusogXzgAGxaqA?=
 =?us-ascii?Q?ZsmhjztJsK14kNjJ4YW2but2tEib3snqGH6fh85V9V3A/G/UIaz3aJvEWYDC?=
 =?us-ascii?Q?e+Q27UZt2pbIG3sALi3kirxpFZieEMUiEmyoyxGTHVi/OkbohW0WgSNa1BCf?=
 =?us-ascii?Q?C+53J7wrYd5Fokv1rtQlwSw9VIZXFCOqxzrpvJQQM6EX0y2ZnKWyVDmY2vv8?=
 =?us-ascii?Q?/J0o7aGWqMhJX1i9pNAny2gOSkCyUL64RRmfAz0dsMbRNeU8KF4gbAsxa1+K?=
 =?us-ascii?Q?me5XpavAcxqwhSLOS+mrqsCOm0HOrMYgm8uNY3OWSwXX4ogX354rT+y5Q8zj?=
 =?us-ascii?Q?pbkGuvkWwuQ062XO87IscienVXa0b4wHUSnriEsBoU58oo9TrGyu3d+4R8Qr?=
 =?us-ascii?Q?7L3Ymb4uod9IXK48Ffb9Dgl2KYGqbhrY+1kDYQIyTgmm8jEOAV3JgLpeELOz?=
 =?us-ascii?Q?8R6hGxFTYIHfkWf0IsDLNAq5vDKP0nAePOAMqoqabX/VO9Ir5+D/DvzGImXK?=
 =?us-ascii?Q?6QqJJT5M4Q62pFBsCwcPgDXk44E4GZLEf/12rEj5nNw+ItWSWXemboNgvmeF?=
 =?us-ascii?Q?9Zq4MJOCm/H224skrnqoO6u2DyQPd+QObtkjCduZCQCBi6YcU/pBzpAFPfeV?=
 =?us-ascii?Q?yZmU2x8XXKH2Ue8iESuoTdXbcw6X6frnhC/N4nSQapuh/Q3S3hvuAFVo7bUl?=
 =?us-ascii?Q?iXiApOKLdzwy/RXZ7/2CdGQv7e7phOEOQw7yRajQzd53DwKXIDiIM8yLd06/?=
 =?us-ascii?Q?LPGnup3mmva7S36FEQoFmTHUodElmW5f7mtqsq9lumzF/Cpd1qkmgBihS0/N?=
 =?us-ascii?Q?ZXIDzeeKhosC11S+0i6k5EUxHo04JvrCCYtoH7fuy1YISmR7yAo64qOZLQn+?=
 =?us-ascii?Q?BIlwwrgnOFOM561Q6w+boNctk9DfIAh2w713UnZKXIF26xHBRIpqn3yA1TB7?=
 =?us-ascii?Q?UgqSgIxD/wqIc8P17bzY5JzPqC/uM2whiPDCFkrYC0yA2tI8rBPkOVDBK5va?=
 =?us-ascii?Q?RW8plDDEsPnhU+cE+UfwLQFtKKmEZ8DMSbtSVorRUS69Mp4i8CGQaRsCuXCx?=
 =?us-ascii?Q?KN/VMH+IQLqlwGXC7tS/Rd/FHraUO9q9vKxUyEMrFOtCjODt8x2IX71uBtep?=
 =?us-ascii?Q?dTwt3y01YKlWYBVkLSMKnBprxYpHVh4W1LUzFZQx7oJpQhwJVtd+67XSCccH?=
 =?us-ascii?Q?51qoeWDdrIOOdRiSWZXe+6w7hiby/2X3cwxeZoJhocG3KZy0fwBY05Burz4y?=
 =?us-ascii?Q?a3Cq2ZR2E2R3Cr0OktmNPu/nOg86aRhW6L9+TbPZxZgqUHM34WDAqOdvo4oi?=
 =?us-ascii?Q?5aUnz4Dzf+FYH3dTOCPWqbq/Oww+nAgA3U47oWg+naXlr1Yr79VcCjTdYRRc?=
 =?us-ascii?Q?XmYXF5qmxdLcz1EXLYUfkLyRnXBuOmTGLtidx/yZLynYO9kvZRLe4W/GICat?=
 =?us-ascii?Q?hGoazM+xang0uNl6fl+uU4vWhiJma0UtLiNDG2w3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 389a706e-97bb-4c8f-c7c5-08dd46e3b174
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 19:23:10.7179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oou3yZRO4Fzzhk6R46ZYqcVsH3bTwNMh4I414upTM4R8K5rDGUreV3n2t4eB2cOA4T4B6TARyX9j3hQuIp7WDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6211
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 2/5/25 21:45, Ira Weiny wrote:
> > alucerop@ wrote:
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> >> memdev state params.
> >>
> >> Allow a Type2 driver to initialize same params using an info struct and
> >> assume partition alignment not required by now.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > This is exactly the type of thing I was hoping to avoid by removing these
> > members from the mds.  There is no reason you should have to fake these
> > values within an mds just to create partitions in the device state.
> 
> 
> Let's be practical here.
> 
> 
> A type2 without a mailbox needs to give that information for building up 
> the DPA partitions. Before it was about dealing with DPA resources from 
> the accel driver, but I do not think an accel driver should handle any 
> partition setup at all.

I 100% totally agree!  However, the dev state is where those partitions are
managed.  Not the memdev state.

> Mainly because there is code now doing that in 
> the cxl core which can be used for accel drivers without requiring too 
> much effort. You can see what the sfc driver does now, and it is 
> equivalent to the current pci driver. An accel driver with a device 
> supporting a mailbox will do exactly the same than the pci driver.
> 

I agree that the effort you made in these patches was not huge.  Changing the
types around and defining mds_info is not hard.  But the final result is odd
and does not fix a couple of the issues Dan had with the core architecture.
First of which is the carrying of initialization values in the memdev
state:[1]

[1]

	> @@ -473,7 +488,9 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
	>   * @dcd_cmds: List of DCD commands implemented by memory device
	>   * @enabled_cmds: Hardware commands found enabled in CEL.
	>   * @exclusive_cmds: Commands that are kernel-internal only
	> - * @total_bytes: sum of all possible capacities
	> + * @total_bytes: length of all possible capacities
	> + * @static_bytes: length of possible static RAM and PMEM partitions
	> + * @dynamic_bytes: length of possible DC partitions (DC Regions)
	>   * @volatile_only_bytes: hard volatile capacity
	>   * @persistent_only_bytes: hard persistent capacity
	
	I have regrets that cxl_memdev_state permanently carries runtime
	storage for init time variables, lets not continue down that path
	with DCD enabling.

	-- https://lore.kernel.org/all/67871f05cd767_20f32947f@dwillia2-xfh.jf.intel.com.notmuch/

> For avoiding the mds fields the weight should not be on the accel 
> driver.

I agree.  So why would you want to use the mds fields at all?

I proposed a helper function to create cxl_dpa_info [cxl_add_partition] and Dan
proposed a function to create the partitions from cxl_dpa_info
[cxl_dpa_setup].[2]

[2]

   void cxl_add_partition(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
   int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)

	-- https://lore.kernel.org/all/20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com/

What more do you need?

> This patch adds a way for giving the required (and little) info 
> to the core for building the partitions.

The second issue with your patch set is in the addition of struct mds_info.
This has the same issue which Dan objected to about creating a temporary
variable[3] but this is worse than my proposal in that your set continues to
carry the initialization state around in the memdev forever.

[3]

	The crux of the concern for me is less about the role of
	cxl_mem_get_partition_info() and more about the introduction of a new
	'struct cxl_mem_dev_info' in/out parameter which is similar in function
	to 'struct cxl_dpa_info'. If you can find a way to avoid another level
	of indirection or otherwise consolidate all these steps into a straight
	line routine that does "all the DPA enumeration" things.

	-- https://lore.kernel.org/all/67a28921ca0b5_2d2c29434@dwillia2-xfh.jf.intel.com.notmuch/


Note to Dan.  I think doing 'all the DPA enumeration' things is the issue
here.  DCD further complicates this because it adds an additional DPA
discovery mechanism.  In summary we have:

	1) Identify Memory Device (existing)
	2) Hard coded values (Alejandro's type 2 set)
	3) Get dynamic capacity configuration (DCD set)

It is conceivable that a device might want to do some random combination of
those.  But the combinations we have in front of us are:

	A) 1 only
	B) 2 only
	C) 1 & 3

I'm not sure it is worth having a single call which attempts to enumerate the
dpa info.  I'll explore having a call which does A & C for mailbox supported
devices.  But B was specifically in my mind when I came up with the
cxl_add_partition() call.  And I felt using it in A and C would work just
fine.

> So if you or Dan suggest this 
> is wrong and the accel driver should deal with the intrinsics of DPA 
> partitions, I will fight against it :-)

I don't want an accel driver to deal with the intrinsics of the DPA
partitions at all!  But it should be able to specify the size parameters
separate from creating dummy memdev state objects with values it does not
care about.

> 
> I'm quite happy with the DPA partition work,

As am I.  I'm just trying to go a step further so it fits a bit cleaner
when DCD comes along.  I do apologize for the delay and churn in your set.
That was not my intention.  But I thought the alterations of the memdev
state were a good clean up.

> with the result of current 
> v10 being simpler and cleaner. But it is time to get the patchsets 
> depending on that cleaning work going forward.

Agreed.

If Dan likes what you have here I will adjust the DCD work.

Ira

