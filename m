Return-Path: <netdev+bounces-109225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346BC927788
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A071C2312B
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1FC1AED4E;
	Thu,  4 Jul 2024 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGQU2B7C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D191ABC25;
	Thu,  4 Jul 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101421; cv=fail; b=YiRsFzphb9dg9b+cQDRWa99FsXm0h57VdGHXSBCF9lfUup/1uHk96zAcbYb1EkB/MCzmUGCmcLeCsfL3nojZQcA7TVzQ/B/ok4OHOkgSbBMvp0kadptohglQ6DAIjqX6Z2qZUxYet7AcQuPKm5023hQls9qN+e7Ut4oisV3cP20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101421; c=relaxed/simple;
	bh=JGNE+U6tuRkvAHbgisgpVFFULN/hI7MT5lkwPqLYmak=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ki6EBv21Ar/2n3cr4dc2HN6TfvDuUfzxopk3ng4A2+hQf5G6NRnoL587jUdlpiW4CGB5afajnFd/thdyFMi/40767sb/RndPJ16vRy6rLfJggipj25jYjL0Xxnl/FU3SK0WEHD6YUujH+0bb8zx/yYen4txamJ63YeGQl6Dsslw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGQU2B7C; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720101420; x=1751637420;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JGNE+U6tuRkvAHbgisgpVFFULN/hI7MT5lkwPqLYmak=;
  b=eGQU2B7CBY8963oBSXkgFgvvFgOnI0jrCMs9BB5Nvx0toi0cNeZLK1Ge
   MmxOmHkWrSVZSviBPkSCB6buf58EdB35qlQG+50yWIFgS2jWVOrTt0WUZ
   hsmMW5vbmthl2laLLoGHuzDaGm2mxM9+BoN+WEPQmNygTMop0XFbm4TCY
   fbvje9/xbtfujV92ATIShxSS0fqIZ/yNOzK/XX08TYdiDD8MFJFjcOFIM
   raKNg90uVQMjGi1BYl/csA2OA3U2b6vRUC9ztDXEdempU4lEU0mbSxmwT
   q5pn4mihttnx31QhSK5Mb4u5pbh5QnI6dxd/0VnDVPDxWGkblfmDnxLMk
   g==;
X-CSE-ConnectionGUID: dU8qrtSjS0yMLK/mBVYL3Q==
X-CSE-MsgGUID: z3pa/dzlRtKHPxwPnERlmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="34829313"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="34829313"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 06:56:57 -0700
X-CSE-ConnectionGUID: P2Sk7NqgRZWN3C26vKLkqQ==
X-CSE-MsgGUID: +MPXXyVWRjatE5k6nErYBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="47344383"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 06:56:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 06:56:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 06:56:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 06:56:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjfRWEtnrGU1bxXw8Dx3XCDDZmi+7+C6Z9+sVWpkRFOIEdSYCEBCvy4vSPZrGFd6qJm+o0ukvRFmJQMM8GCUhUonoQl5BRllVvbjQ8pPACD7WDglwqBiPq8X2eY20sfKNo6k4he4ajdU1rBg1TfbkzQl3gRNd8vx+KnamGkcu7RG6yinS/PB8KqsukHWbqfjblIGhKOl3hr8vZ7obEQehWo/ovVwb7R3uqY42rcPWP01IeMoOOkTy2EaSPw9ng+L4tOVGIIXOiJMKxzFv+fMlDXptrberDhZMreB+GAQGNqCQaj+bXOox+z6ZfGdcKcT5dJrQqYuTRzlTV5gZlIs7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6r8qRrGW9Y53NLLt/RdvQWPwcsrxOyPShDLmqOj99s=;
 b=U/qBQm0v+kFIblmp2U4RH79t6kcL/rTeOOrEPUbASrJlL9z2VEBUmN1mCoqmclH/fXQQrOyFdXAOx2XMuE3OrB+Jq/J7lFtUkx48yDhl+AOBYatIt62/iByDUBcWpvenElH90fuozh4gf5IPlziy7B1XuO6QuCMbILqOW8bKjK0CDdRTi4G70XWmcxZ8AVMIPIO4ORRd+1cUXi2GFMk+QZq5XD6Gm1ScX1dGPOY3Z+1iUOxFchMZhIS0iHcjvH2RyldQeEEbC4mIy6Dqf3ts1pqra8ReqpQTFYLOeqv3ZaiUrxZpBW6/s6wOr3UTYGRANMCPO/2HFtmUxiJv3B2S8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by SJ0PR11MB6720.namprd11.prod.outlook.com (2603:10b6:a03:479::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Thu, 4 Jul
 2024 13:56:53 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 13:56:53 +0000
Date: Thu, 4 Jul 2024 15:56:41 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Aleksandr Mishin <amishin@t-argos.ru>
CC: Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v2] mlxsw: core_linecards: Fix double memory
 deallocation in case of invalid INI file
Message-ID: <ZoaqGQUzKp4LInsS@localhost.localdomain>
References: <20240703203251.8871-1-amishin@t-argos.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240703203251.8871-1-amishin@t-argos.ru>
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|SJ0PR11MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: fa580138-57ff-4207-a6af-08dc9c3128d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ICB3v0bL3HEacXhc8Qn5qen0y1LDXxG9IVz3oiRWxB84RPCOuXeHiZ0abASp?=
 =?us-ascii?Q?aKQqeke0B8iyZ53mGMt5RKt0Xqfy0I8yIXt3kInoVkBxhp06gduFEA1/c/5r?=
 =?us-ascii?Q?4YW13dMotIg5BIVx8/xk0xN1SNddcmklGCiz8+i5kpXJ4uN61K5gY/vxqNpj?=
 =?us-ascii?Q?z6sLO9r2rwIJHakeOuP3NH/oPxuGrOe1tl1e3s1bQpCUhl5vXmLaX6B1x7jg?=
 =?us-ascii?Q?IgAN9NDWI+vOTROlkVq2yShh8/GQka1YQS2NWi1WQu+VjowIRBuKXzgRSAiJ?=
 =?us-ascii?Q?M8svnyy1LrktWonxhXX8VxSIz2mOvTf073GFMNZ5Td1F4c6Yemjwr607xQf+?=
 =?us-ascii?Q?iIB2+DHTiYMNj0wMz+MKKX4b52/xndx4+qeIUDgCez2Y+trMSw0scOFORXwB?=
 =?us-ascii?Q?OyAVoQu6c0advR9g8VyP10/BMLoNP96/jGZ308MsEqCD6h/88CgN6vRJrWZ8?=
 =?us-ascii?Q?jsVOgdAXP9DgzUnZErrQ/alg9KxHeiHtiNYCimGC//t+I9TIwnkxLJqTWIlF?=
 =?us-ascii?Q?mEE3VFDaksm0tmSzQqRCrEB7KVc1Ui1OPJ3JPM17SXBZDzIaX7vuP3FKF42n?=
 =?us-ascii?Q?3xSZAvQLz8XCFD+6nhrAGcczB9CsYxFHdHKLL/jlGR3UHD60vcjgpLFW7qvM?=
 =?us-ascii?Q?Gy5QHy4+wLvJEbp9cA0aXYP8VJoXNKVWiDl9DxgjQifOVst1fz5mxicOgwGc?=
 =?us-ascii?Q?6FFEY+Sd1e++ok+iXgY/1KSETbdwwq7IhgavDCEIZ01UN0NJvbFLkb6xOBtB?=
 =?us-ascii?Q?KFJ5RVX6tnHR7sg5BhoO93Y+UOssXlUkk+1SRSRSdz4jjcGUA/3XcoBewy39?=
 =?us-ascii?Q?2icJ3GbpLiYY5HrSg8i6e+HrblHsOUHfscLrNwfEypyAz+wyUipmfpbXO1it?=
 =?us-ascii?Q?i0ZrbtaLS1DqRDvNap5ggWVJj7b8TwHQ3haJ/aNX84odFX9JiYZPwAyUAcNY?=
 =?us-ascii?Q?JOV3vKF2wTgiqGW4qHF/ssS+sj8th3/m6wqN6+AgyRXEfy3J0xrFNMaL3KKy?=
 =?us-ascii?Q?qMriBi18dgmFLG3/4P7wPJFJTHd3Qh49Px4o7cVCWxeJtgltv7k1LBiXo152?=
 =?us-ascii?Q?fcZ5fYwgaRh+tYySRJGcXUc9z8DWGDCo535r5M7iNWy2Egrxsi/BYVHN5q2T?=
 =?us-ascii?Q?tqHal4VynFEnH87Mo6yfvp7mesjxYs0qhnVh/gYAIXJrmWKbvbJRU3qCBW9B?=
 =?us-ascii?Q?JM5TzxUIUtdniIviGJi87+g6btd3W6sEI+8tdQNwaSlOUCm6Y5gp0vn+WEzo?=
 =?us-ascii?Q?Ik6fr/feXQx+Tj3ydZQO08kuF3hAf9Qbvf3oczL4UIcGquQSu3c9ZgMYwkrW?=
 =?us-ascii?Q?7IJAqBwox6QiQxPB202Zt5w6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6L9Dp0PVEIV7iQ6igIg5V1nPtxIasi3JaivPCUiGFkX6MavO/jtQBjftAZD+?=
 =?us-ascii?Q?DjvyXmIQor8HEwK3sAbANV+KzkeCcK5+dSgUzFweRONtbxUEzubMcU+ma9vu?=
 =?us-ascii?Q?t67tgKBfF42gol3sjdY32h8u+TvGtfSNqXaFvlFvzp9M82R4WGecah9xwX7X?=
 =?us-ascii?Q?OoheNK9pJhOs9+DkRvI7P20U4+fj8/nLknnZP+72rCclQbrQkbyJJLrADyAF?=
 =?us-ascii?Q?GPoNc9B2MsrPmUZpkN19crVA0QCmkMhYgT9zT9ehjRyIAZ0FwIuj40RIG7zn?=
 =?us-ascii?Q?YKt7tS1MDdt96HafQEWqPn8OOQ1d0rZ1H1FzBxhBaZGzrQCoVUeMztRHlWjt?=
 =?us-ascii?Q?fHn49c/b1B4TFeOVzzM3KWPWZKCbnyoBfrNMUAIQAHGI9tiYH8c1gtaqNGVu?=
 =?us-ascii?Q?39dnTP4wIXWoUvQtGf01TbSnQqeys1oQTPb//FV02/xnCT+Upye6WA+3pJkr?=
 =?us-ascii?Q?hqPnsFhv7Yrq1H6WZ/coVJ+nCBAkaE0nVOcDwLe0mUEIR0Na2GJ/NRxElHGa?=
 =?us-ascii?Q?HvVGf7D0ySMQ7hokGRegSaFtwAjdSXmfBdgnaPR6q70vFQYq0FcRd5nubKJe?=
 =?us-ascii?Q?2vpNrxPu3RfQVG3rbZ/u9jQxvZ1uEUtBjGB+EuqK2ajmTb02sR09mCXG0L9V?=
 =?us-ascii?Q?Ibu367Aq9sKgzgLnUsJOkrw5ddtwKy0zCFzXFu6YkEaQqY8KwvH6rDH6yuLR?=
 =?us-ascii?Q?sZM111MH0S2q8jyZMNM3gueRtuts8cymI5bClRjCsKZa4cSj4n6kWANeR84A?=
 =?us-ascii?Q?ZoYP+GLCHH7AB7Rh90u//45Aj6I4eTCWYutUM58wJBdGtwWCr6v0KAsJxUVD?=
 =?us-ascii?Q?jbCeHHLhKIY505MQno9TEuUodL0pDbwv5S8Ac6n81UvitIxOyV8Fzx1T0NbA?=
 =?us-ascii?Q?GdHK5cAMqz3ZrI+HTVgT5UdVX5VczUFA5UvLBk4B2ImJM2ZPKqtzeR3bdCso?=
 =?us-ascii?Q?xtM3kYp2UqCeK+ismRm/ouhlqsY3HRHqGwDXgzYS3S768KB9y2B3qC/u6R1A?=
 =?us-ascii?Q?lMyyejp9md8+TuV1b3cJhQ2HaYzSv9T+UrkC5tkGkOSMKrtvH3O++GudKqPs?=
 =?us-ascii?Q?wclzGrrObloQTpK5S2aTOoM2qYkBCsxQdDCOw7aICA/4HE0uO4kdGLCtmYp2?=
 =?us-ascii?Q?y/wl1uuvV23xiYRHckq9Jwr58LSoYKoa1DFceBJHhluIorWldys+wLw36Olx?=
 =?us-ascii?Q?fuP4AMy6CnVeQ5LuH5N+jcRR/1jxQMnW+v2Bai8LavA+w5Di/bnjUAvfXrAD?=
 =?us-ascii?Q?7rWmgM/sZvjXjv781g0wxFpVa9J1M//dRHtjc85YM2IuPV4UUtBXtSjny/WR?=
 =?us-ascii?Q?Q4lUGepdqdavi3AvxkDCZg9CeKgxjPm/hDzYpgBOO9QRe+UQBjS3vwflVe4r?=
 =?us-ascii?Q?XSy5oBEJGeI9gN7q6TV94RVXGKCTtlwO3xFm8vj6P0gLbwWHcl0PLuUFtsGM?=
 =?us-ascii?Q?DjXXlUmJLbQbmdIaKvE/JCbAxJy2X+75zApUHM7e3nDCxzf7puS5qtyXzyWc?=
 =?us-ascii?Q?t5Y6+TgXwp0TlyZb9c571j6nkKCjjo0dSsZBhFgcrD06YHtfZe/mptxsx6SQ?=
 =?us-ascii?Q?Obh7qIj4Y7bR2mNjjORbtesu3EKIu5uGkIQ7NRfOy1s+i/0MfBZwQeVCcIoN?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa580138-57ff-4207-a6af-08dc9c3128d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 13:56:53.3243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPHqCczxHnZTjC1Wu9Y6lg4674jcXoIZUg08s8TPPf+laXVa4SFeaQNdKIp0VGNfUhdPoGXDBnWKu5RlUvBiKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6720
X-OriginatorOrg: intel.com

On Wed, Jul 03, 2024 at 11:32:51PM +0300, Aleksandr Mishin wrote:
> In case of invalid INI file mlxsw_linecard_types_init() deallocates memory
> but doesn't reset pointer to NULL and returns 0. In case of any error
> occurred after mlxsw_linecard_types_init() call, mlxsw_linecards_init()
> calls mlxsw_linecard_types_fini() which performs memory deallocation again.
> 
> Add pointer reset to NULL.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: b217127e5e4e ("mlxsw: core_linecards: Add line card objects and implement provisioning")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> v2:
>   - fix few typos in comment as suggested by Przemek and Ido
>   - add Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>     (https://lore.kernel.org/all/c631fc5e-1cc6-467a-963a-69ef03c20f40@intel.com/)
>   - add Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>     (https://lore.kernel.org/all/ZoWJzqaRJKjtTlNO@shredder.mtl.com/)
> v1: https://lore.kernel.org/all/20240702103352.15315-1-amishin@t-argos.ru/
> 
>  drivers/net/ethernet/mellanox/mlxsw/core_linecards.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c b/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c
> index 025e0db983fe..b032d5a4b3b8 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c
> @@ -1484,6 +1484,7 @@ static int mlxsw_linecard_types_init(struct mlxsw_core *mlxsw_core,
>  	vfree(types_info->data);
>  err_data_alloc:
>  	kfree(types_info);
> +	linecards->types_info = NULL;
>  	return err;
>  }
>  
> -- 
> 2.30.2
> 

It looks like all the typos pointed out in v1 have been fixed.
Thanks,

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

