Return-Path: <netdev+bounces-173874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5539AA5C11A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBE419C07A4
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE27250C11;
	Tue, 11 Mar 2025 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVZBULsG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD91DFE26;
	Tue, 11 Mar 2025 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695773; cv=fail; b=Io2Y2btJVMP6JOn4t1regHpNY8b3lfJoI+YF2hhe9FnQPLQ2JX+e8MG8upkKH8y68s+YreOElJzU0KHUaTB40r1CznYK2tEbLLLTWmMT2Gp6isECy/kMz6XdfqOh7kDHXSDwLJV2vPTUMOVRlK5U7xHBVa3MTgCJtqlxC+R8Cnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695773; c=relaxed/simple;
	bh=29pRQwrzHhphz6RH9MDhKOmEElczOh/0/KqdM3ve9eE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PlvJ2IxUHf0AVApRKDwv1SpNYqtK+5g974MvDTAaWXRL+S9fGw9IIoHkN9L/tcOmnOvmgOjc1cyiCgWlI/YN4yAsHIijSThpEs+WtPXW2HIraaglC2yGCX/8HIm6Xj3tIpZJHkv/biCW+WTbDkPujpHFnRFPGH5XAtfZ37zZZRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVZBULsG; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741695772; x=1773231772;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=29pRQwrzHhphz6RH9MDhKOmEElczOh/0/KqdM3ve9eE=;
  b=IVZBULsG+jvsrF14wiFnxIlw0MF9/SemtxH+STAo2n7Mjf3ivqPFnE1B
   leDp2x3CuFqlwWCws0muDnI8JDbGL4Ks7Xe3vkNENa2q1M5EERGcuA74R
   WDkV07Wu6Ki+AGtOPiUpgsUzsBhbOYICsVO0v1vAx5D/0hMxzCtn4xHtG
   SwqjrRY1RiwwXqcDUs96ZrmE9gCLc1VCKNrh429HJc497YzcrgJTAeRQI
   Tq0/J2+2Rmhfh90HcochiZDO61964cfWT79BRiVFFCIrQi4K4ZNfpAl8+
   dYOOhZQnGBPmj1A3cKereVeXvN8fGu+H6bACYIolIg/LX7hCNXYHLWxq9
   g==;
X-CSE-ConnectionGUID: HKbI+P3OTai63+8wi32+Lg==
X-CSE-MsgGUID: K2cadYEmT2uxaiIWRpJ8Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="54112448"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="54112448"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 05:22:52 -0700
X-CSE-ConnectionGUID: shKI84kkRzeYeLQIZVOPKA==
X-CSE-MsgGUID: G7JEQYBhSMC7UElWFZtptw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="157515780"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 05:22:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 05:22:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 05:22:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 05:22:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjGzVHlpxoMy5FV5wvX6mVZ1p0gSMqlfl0dHZYkkmKw++hVfVT4OtqDle6iaKTJmfOwmcjHoWs2j1SyIQYkq0wj9G+9DY75YujD4z5eFIf2ZQqeL/ayjn9BHiGLobKf6fnujQ+Iu7KAzd4loZJRo47Z7BRYboLEz5pdfYEV2hN7JkdJp000lRRXQaix1OAmmDO3AjMeKW0iWorWloLbHfXl4S8wmnrLID3tA9djcHdUEkYgmxJeG6Q0DRZfVPtBuK0alEQq4mP5IUIWTYU7dKnOxK3Kk4B91zcf9YuF4aFC/4is8qzYqOsh3C8n5Oqev73Z5LW0oKi6pQHyrZSc7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8R/cLR5C+0ZtzqUowBCav2UQQKEL20hJm6J/5GNxzo=;
 b=QUjvWT9XzAW1mnaMtK1jzBBk3s7Rcz+1VuksRH13SHV2/et4gsunClzM6E5jsb+e0PSPvoghkv4iHUR30XTlWyv7C9dYG2JrCDQqoD38XEqEQBK+kfkTp08Wb+P85TRZxahs8MUa2c9l6yob7VVizs10BxjwO2L0wg2r8abEI0aAbiW6gfIBPWHEU0wyDryPz3xWQ4u+fzU8rsAh2EZNbVS6opag41RnEmUJjQ8CD+M5HJ3f5HnbW7tHi0U4NpIFt7S0IUcoXuL9Pu530CsSkfKF6t+e56n4/yrJbsEvgrc5Sbg8ESGhDlDO2S2QrKtFqNBWplKystlSjRlPtwjAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SA1PR11MB7111.namprd11.prod.outlook.com (2603:10b6:806:2b5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 11 Mar 2025 12:22:28 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 12:22:28 +0000
Date: Tue, 11 Mar 2025 13:22:21 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Wei Fang <wei.fang@nxp.com>
CC: <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
	<xiaoning.wang@nxp.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<christophe.leroy@csgroup.eu>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 net-next 02/14] net: enetc: add command BD ring
 support for i.MX95 ENETC
Message-ID: <Z9Aq/XNEBQoh8X2R@localhost.localdomain>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-3-wei.fang@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311053830.1516523-3-wei.fang@nxp.com>
X-ClientProxiedBy: ZR0P278CA0197.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::8) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SA1PR11MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 564385a0-05cf-49fc-9e00-08dd60976339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I2qQ54Gckdmwhk6ff1yZ27FDAYs7AZhrS+49KVovKQulI8ewQyE0/zic1EcZ?=
 =?us-ascii?Q?+ldMBDs3jK8270077UYMayog4yh8z/0kosvPPo7QQze5qR8BoTL8BSbiazyx?=
 =?us-ascii?Q?q9rSE5Nb2s1jdueuqAauCiEB++3YuD0s2JwkEdNIvlzuZEOvv5O017Hu/iNd?=
 =?us-ascii?Q?NBwuoSYpXbBzb+juXNqC7UMOqFJBorHR7+ljwGf5YcnTb8kE2uoIoHk01tki?=
 =?us-ascii?Q?KYJ4A2RVt3Cmlxcgw8S9apk4Bdncx4fS2SeDbQ3mvGa8TXBYiRX11A73aVjz?=
 =?us-ascii?Q?0akWpuSICPtLGuW+JVI8ca8DqmY+Y+9MT9576DhUDy1TGG0B4RnVtOToh1o1?=
 =?us-ascii?Q?6KNTF+OuAM8wT76yCs+LK655L18KtHY1p/PzJtVg18WXyKxh+xTer/li8fTs?=
 =?us-ascii?Q?IFUx9tT3ccruKHtJFIyfhIQ0gZI+gRYsHVgrrPSeGk9EEbOV+ozw3rc/pCYj?=
 =?us-ascii?Q?fwFfNXor4B9vdtHjuVr33BFb0rkqTd1St09Q1eKlljAX1Y2uPD48AZXuG2ZA?=
 =?us-ascii?Q?pvKZK2LvhhXHJq2x3IqtS2Ka0/hqeNyS8JUW0uOOGx5/ISScxfjTleoTOQsQ?=
 =?us-ascii?Q?N8toFnH3UfjZIoF2zf9mHz7PoeIPyVoukGv4gt+ev02Q1aFtnfLEh03w7Tsu?=
 =?us-ascii?Q?hS1GLu+A5p59yAwPHHgCD6NnhHcrbUD2yosrZItMDvP6PQ7n4+CRiBN1DfeF?=
 =?us-ascii?Q?rjOsYcgCwyxAh2fj+2QXep6Vjow9IfFKrdSDJln1g7wg7ygkhZCrA164Cujf?=
 =?us-ascii?Q?nDWqTdVURmbt/otGuS1hADLf3iANmOsXSHFMeiBKy2jR5BR76H4iJ+GxcoZ7?=
 =?us-ascii?Q?t3wqEksCH36r+C6XFdSP01vLjaHZULJxlQpkl4yEJFay538Q2qQf5VFnueUk?=
 =?us-ascii?Q?6Q7QrTNdUA/QPzC+ZrW4Bx1nbK9zDr2Ll+8U66tCmvQDl5ot/fAxchvHPyZC?=
 =?us-ascii?Q?7fWHHxTVOmgd/VwUJbJDoPjryMji/zr/CKwy59obgKI7Ymh/fznr/Wq5x6zx?=
 =?us-ascii?Q?nahratA/2OOif+vyq1xNvmbPewOsTS0mGVZX5/Cdwl3f3JCal+QfaS9m+rWM?=
 =?us-ascii?Q?F0SlnODjCvrH7jZ7T8VwCSir5tH1NM5lEXtUk7v8Gv+G+pwEq9ONExAE/1PK?=
 =?us-ascii?Q?aC7ngp9DvAjqF9yLPjEC71u5RPZdM7gdniAMk+cfnKyd64f802ZJuC+lMUYS?=
 =?us-ascii?Q?SC4TjKg6rtnXWIItRRugekDuX01briaE89MrhmKyOsenj6VYqT/1ZF7WTAig?=
 =?us-ascii?Q?YbI5SztTslzBVdiZuXBTVl8bi0jcqze9vgewArmDKZilcFI5b8//elbXNj+y?=
 =?us-ascii?Q?6OJvmq6wpMKWeWIbtnV/6Jn71RBa4qkOV1GDLxk5QNjGjkDbHfBk9FEbEsOZ?=
 =?us-ascii?Q?z8dTtZsRhWjI0FDsYhPW3oUiet06?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wjYn+7OkT6J+BroWUOUHlijcXvdvLnPMPjRwi7ZuYxzaSBMSpQc/rZbuxXN5?=
 =?us-ascii?Q?PgYhKcrFcyhu6gQYbtu1iCxdcZzww1PPlwq9sV5xTP9O3hXX2FBQQrJW8VdJ?=
 =?us-ascii?Q?KLGQoPzt7FqBvLn2wy3MSnaaaSALEeO81woSqC4eC61FYR0UcDtZVehnMbaW?=
 =?us-ascii?Q?FMjAgnWIdjP0NRYCLsYIy/0I7tMir3Ckit6SbBrsgXW8giaMN96yhbJZnJbJ?=
 =?us-ascii?Q?fv7EW7UwCvVxA3Dox9VxuhX5ZuR7ds8yyjy70Muw7oGiWppEQC6GRuJF9eyz?=
 =?us-ascii?Q?7Pew8FsMy+oCRYvVfGIsZruNm1srY2lOOS6xer+1PGyZgRyxJnb+KSyO8p+M?=
 =?us-ascii?Q?ErWQM9mZC938TRq8qkP/7u67HJaIvz/EiqHLLrDWOTXjSQ9BnqMc7XJCzeK4?=
 =?us-ascii?Q?jr7+PlloEa+lIXRMy3PmGg4zC8VULErWh6TifJfZtGyd+LD0KvH2yDlly4eH?=
 =?us-ascii?Q?0b3/hKAwe+q5gIesFQPFuo/2idWguEAcQmjC508m58mMv+rxeBFywmKA5qxq?=
 =?us-ascii?Q?cHi96PdJU/xvkHhoquWR1DilHq48jnclWisb97ykusk6NFb6uYX38KWXmRAf?=
 =?us-ascii?Q?HtX1vOKk2p2H3tzyTLjFm7FScFuG759ogOvFJZoe0riSRkoMHB4R41uzx+oy?=
 =?us-ascii?Q?5O4Z+KfOZb92QQSaosy5F8iH+BZ1XhrHbbxbKZk8drbhJvhmpiepgedLpqDg?=
 =?us-ascii?Q?zytq83lJ+eHX27cBnRS0ibGWaiFy9WiKyaWUQB15yhM+/HS8E1omvnCDdFf2?=
 =?us-ascii?Q?a0yizij6+YiCK9vX1nXvubStBCWAnJKAC9X5oRua0f0b6Csvt+XhOdAywNyW?=
 =?us-ascii?Q?xyF1OFxtHketeaxfauILoIdLhT6jN/5KrZ8WPF8Q6PedLh/W9TsJojJZAjzC?=
 =?us-ascii?Q?uNZG6N8NnWUZbnIdqs8K6LPY17R2sa2Gih0ud/wv1azPOGz1gqm2ZmPECmvl?=
 =?us-ascii?Q?iSooK/36Rkp9e8PFJybbc/FJ72F12nifTokgHBHZkd8tlG1eVHgLvXlsDOwO?=
 =?us-ascii?Q?nCOIcUAWD5btngL3N2biJH8Dr9KB376RZ/a6ClX4Aru4NaoUXeW9BS0DLEVl?=
 =?us-ascii?Q?fFJaiTGOsGscmNp+KdFaYovnmb9rPK6tCSEjjUB2XQFztsRyiq1c5jKR+P1U?=
 =?us-ascii?Q?jDAsNrIWR3TNLoIAf4q6AGu1ek2yOjalZyhXzcuad9Uy8CsalwI2aC3LMhV2?=
 =?us-ascii?Q?3+YGnt2WXRnIZVQ5r0OGoJkpUjo+4Xf9+E9FYCXyp/g4ZpjOtVynzZwknlyk?=
 =?us-ascii?Q?NSGXHr6oL1uI/ZQqU+K1BmECAfG/+yEDEZqcElV0tWfMtngGZU1cNQdTKw0N?=
 =?us-ascii?Q?qa317LAED5SB6Bf6q/e0oWUvyNyoLW7DGGx1N3vbFnu17oxXho3+xgXkzws+?=
 =?us-ascii?Q?g2c7Z7aMjacmbcE7Z5wnbbp1Yf/zOX07JQoqqtbVVqbeyi6/5F5PdxU26iBP?=
 =?us-ascii?Q?cxC7DQozoExIo09OufqjXdjIKzQud7q61z7h6sgQ/pH5HpJikWLflo/Nhmlz?=
 =?us-ascii?Q?luyWowcX++Igw18/g5k8H9sHlt6N2VzX5xM3Hqa8Bp64rcXvYjgB/M4Pa3YC?=
 =?us-ascii?Q?9I/rxj4nFZ4cEzaETznkC5XT1IYvBUthlnEmHomuulDc4JIX3M3FlnktHKdk?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 564385a0-05cf-49fc-9e00-08dd60976339
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:22:27.9218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 815tiIBJygD4hiDVVPvhH5f7v8GxiUaL7IGl4KW0GZWPSSuawT6JiNgLAM+/dWgoMoa7T3Cjw/mLa6hbIbnJ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7111
X-OriginatorOrg: intel.com

On Tue, Mar 11, 2025 at 01:38:18PM +0800, Wei Fang wrote:
> The command BD ring is used to configure functionality where the
> underlying resources may be shared between different entities or being
> too large to configure using direct registers (such as lookup tables).
> 
> Because the command BD and table formats of i.MX95 and LS1028A are very
> different, the software processing logic is also different. In order to
> ensure driver compatibility, struct enetc_si_ops is introduced. This
> structure defines some hooks shared by VSI and PSI. Different hardware
> driver will register different hooks, For example, setup_cbdr() is used
> to initialize the command BD ring, and teardown_cbdr() is used to free
> the command BD ring.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

