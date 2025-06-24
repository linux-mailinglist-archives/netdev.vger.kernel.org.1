Return-Path: <netdev+bounces-200804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E7AE6F4D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CEB17F102
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E6E2D5437;
	Tue, 24 Jun 2025 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYe6gGRO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D2D170826
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792393; cv=fail; b=YgUd8/O3Fcl77xzdSUJmjWr9jFUYEYKtE0s+JJvJzXrL/elGs9zuaNrw9TTbkCqim4CPmv7lgK4s3qhx5rC2cxr2bBQud6tPN07F6zEu++7F6pavguVxYbQ0hQWyBqULwJFkI5wHLagT8oE2VLNPzwF+NXctxjDxjg6sanb4xso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792393; c=relaxed/simple;
	bh=jOaArJg3nVRiW7mQI1foF67hw3TsQZ5Z/zPhlqFgpU8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y86a0ZvtKykuPMVoHCwHfjwwwJnat5CLvSCBsrgKSU9DIemyxv2SbWGrwTXW2ATZzPgRAQOWUpDDlDwHwkXKhT800mPJmC0pq/BDvcbk4KdPBdyY7nIIYbpeRVmRTGl4Dmc5VNbsYHpx6GgTmInlffTSmaG8wYggfQWlEulQGZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYe6gGRO; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750792391; x=1782328391;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jOaArJg3nVRiW7mQI1foF67hw3TsQZ5Z/zPhlqFgpU8=;
  b=UYe6gGROoE2FRbDlE8vOGRojmu+GR/rmJDI+9QoRYFiQfSe/mC1KU8lU
   GjayNZ1IZ6IBsv48jTPsd/FACCCwoQFWRZ9KC0KfV086tMDFKOhjRT3HJ
   thnIhySfMiFiQDXMGAjoyKKAVTvojW4bf2uLAF7Ao2eLX4rglPnv/aMfW
   FnqrYzRKPGvMGorQb09G+kF3h4dfA4kxdy+0yFnqRjkIR5mzCkOvuSDyB
   vd9XqzRNjxd4fyuLQwXkvoy/8dkB25nIUuBcaOXZe4omzXkiNMz8GhbfR
   IB4HMchV0WN0Js+hx3dEfcYqsCzz40UmpCxAy19QxW6Iuvx6VCkN5OSmj
   w==;
X-CSE-ConnectionGUID: dnIsX527RMy9bW1mL9DrHg==
X-CSE-MsgGUID: lzdP+8F1RQ2yR0LfxJPz4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="56853287"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="56853287"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 12:13:10 -0700
X-CSE-ConnectionGUID: APr44QCJT16Z5s8DKTYLDQ==
X-CSE-MsgGUID: WfaqaisdQtyzamc3ljjRvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="152292349"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 12:13:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 12:13:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 12:13:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.44)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 12:13:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1wO3/LZoSPHy+nzwUNNL1frPwKB51qwXSOEaEc7iD/50tSZpXDWlgzOhgxEwCfg8AJBfWf0eFLH7wQqzs+AwCAlbpeHOSFREgGohNwhfLxr+REyyPL54k+7RwMTQmiY+8/GRd0haElm50Rd1ESFcPfCg4dOC94tTown1EfevY6dToR1d3C2+Y+oTSb21Z2JMJ1zjL1eyZpNHVLL3AM7LwnM2lbITRlAMGZatKq17MGx1dLKcVjY6VfJ4HxZY5vm+os2KT9be2vzuFiXcKiJeT1eHQ9ZPm9mk61YeCBzkC1GlGfTLU0Kxe0kFe20NnPTUCXv1NewWEHXdXnGjNMtJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgIMzx3OaKyNLqrPoPmGj7iFlUr5aGrACbYdHse1D3c=;
 b=GEVsz2XQt0c4XNoTPzJMosTxmy7dC+aH5Zc5YModyycpnt3AGuegu5nSU4ajcPZ7+n2G6gFixTdQSVfEEWddJbLiGa0s9WKkPzjuz2T3IHwvlmMjZUcp0MJSincjWTRZaJwWfW2ltaEDZkrMYAM8DScJLD4EW/BPfsZnARkm1Ma8x6wH0xMVJ1KinVCnWeA3TMFR7rDCXdTM8xJVCdvSgYUjAjGnQHag52xd7rEyvMD753Wg/E3RyZb6wObmRbkM3oBAiJ1WtexAw8R+NAax2FSf0k90y1JlbfXQpV3zhWzYHskPAsWy26R+21p/BL9eR4jyHMbgNvnX54xl4ArkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB7491.namprd11.prod.outlook.com (2603:10b6:806:349::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.25; Tue, 24 Jun 2025 19:13:06 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 19:13:06 +0000
Date: Tue, 24 Jun 2025 21:12:59 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<willemdebruijn.kernel@gmail.com>, <ioana.ciornei@nxp.com>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] net: xsk: dpaa2: avoid repeatedly updating the
 global consumer
Message-ID: <aFr4uy54zgtgXmTq@boxer>
References: <20250623120159.68374-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250623120159.68374-1-kerneljasonxing@gmail.com>
X-ClientProxiedBy: WA0P291CA0009.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::9)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: c468a066-1437-4e1e-17c6-08ddb3532624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iWk+SvJAj8+ScaSGbomzF17pRG8c8GapF7taGULbVpOp1ye5j/l1/k/5WpMX?=
 =?us-ascii?Q?2tGOawrgK5fBm+2/rW9gPg4xoI3jRAM6mReTD8XeHxWvcEqP0O/X6PnXeEJJ?=
 =?us-ascii?Q?UAfW2vkdRiJk5RrxUvqqmDpStGO+xTPRYGhFyZA7g51CfxqyFIAquA9ozInP?=
 =?us-ascii?Q?TuTQtBvVVgRqNne5alh+hYRG1wqo0TY2SrD84kQtysRIOYHyl8FteAbO5+3z?=
 =?us-ascii?Q?OP3+Xu6aY9CVNUCDlibEqYMhMDnRXaB5NOlOmCi5xgrpZ9dD6W8E3xOQL0zA?=
 =?us-ascii?Q?e5+XnDgWfyLBelz84agWxsBUHzad1wxWLvaTXBo4u6+gD26ELqStk84T/daR?=
 =?us-ascii?Q?T8VfpLH967nwrdkrh3tWd5SpVxAJZgBEouPLaG6fBObrN1BlMbQFGG67317c?=
 =?us-ascii?Q?TC8efAZ1zQ+hFz34DN5cnfg50GQ924MqcaLFxB7ZyiOcesTRowLHEdidYwcM?=
 =?us-ascii?Q?SbPtbjGucrvseBAB9MhHaL8EFGWYRCktXQt7B/BoblHZKqD4YVg6KwmDOpVG?=
 =?us-ascii?Q?/mKbxkeM6JKiVc6fZZPLy4MPRUCPyNRVeZ8Z8ppSJb2Yoy3iwLlqLbRIw4hG?=
 =?us-ascii?Q?/5m3n4Dh0QcbWJKxY34au1PC0dZxT5JxoxapS+BBUK6csVH2k/sEnHaRFcy8?=
 =?us-ascii?Q?9HEp49wMrvjFKJb0IYM79upHsoY9mtWrgtVmvFpIGPf07ySQ8Pzk5AheAAxm?=
 =?us-ascii?Q?aQ7MO0INDQ4oXw8kRLDdsLh2n7tQfmXIO1Qnu6k5qg1AotTFg+Y6dh/tiZmF?=
 =?us-ascii?Q?FVJwOAVeThnOJk5ZEhAloSl9Vqg/BektotQPqT9K0mw98eNVYGNV2Mxr1vbK?=
 =?us-ascii?Q?h9zbiDmYfV8EBWAl7AceyRcHv6EUQYakbyooEADSTmBqTmZoB0otZLmzGWnY?=
 =?us-ascii?Q?gdkpwgHdTweAzcR/AWL6VhB8aUeu9wEiKk8Y0WEvpqG5JZaTi3auVySTyrmd?=
 =?us-ascii?Q?xSvwLVVavaaOQGCVBvYdA06lfjPlv9vYub0qPQiQaHnmwY1h58l8lkbiZPU2?=
 =?us-ascii?Q?icYaRJcf+7YwnXr82PlSH9ITGwxMgngIkL1ea4OVx2Ph8ntXP2ehgBHpbw4l?=
 =?us-ascii?Q?c06mgc3ic9xazBJJvBsbH/0jYOYDh2tsKRyqHxhzJRj69f3wWI21JMNWIdMg?=
 =?us-ascii?Q?6KE60Lbt8IlA5D61Kxsm+y2oxzr5zEZ/oal0+rNy5DOwZq3WLRuuNdaLVWQH?=
 =?us-ascii?Q?UqMLMbCALvg54oE9v7uhx9rTDwuUrO2ji5LApNC4wTr/a8zx6qFZg4w8u3pU?=
 =?us-ascii?Q?6MRiTWQzHcadb9TKkzkOCFGtuUgg6YizkWaruqdkVUOhTfW8QsP1vLdZ1anu?=
 =?us-ascii?Q?0vNzgsZd7OPkX9pcAMzXOQB8/NvtxpKm5tM0HbBQLvA+O3Ln4vjuBa/GsW7P?=
 =?us-ascii?Q?Z/8Oonf5VIEgiyA8U6e29/V5GitLamVg5K/4iVyLocC+cfyMNEB4s1eJ6FlI?=
 =?us-ascii?Q?+Fdiv6KveC8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pB9BP1VbylulrhI8M7DtKm64SgilXko6I7bjSTFG0u8FDQtKeK3l9iaiSxMi?=
 =?us-ascii?Q?tw3c1G6WUeAl+S900ewSBOVIrwdapFVGQaQvFMk3vHRvMQcalXfzCw2NVf9A?=
 =?us-ascii?Q?Do93pLhxMwsU0TLWhvFU9GsGh33uSubdwgE+5Dfl5uqQTT5sG6yXNKFaob6Q?=
 =?us-ascii?Q?1Sj6AAok4sdz/H1+Q9k/hsmNpYwchCN3vpQGnCo5skpH47cYrIfEEVnCIrq6?=
 =?us-ascii?Q?ciL8hWEToLXjsaL28AfNNR7oZeN2wgxrlfoXHWoatRAp2DiSxCBK9mBCsOUR?=
 =?us-ascii?Q?EVVbMqWWQg3kSuYzPmRVppCX8pdywKAQJPk1x1GforiKKXfgZLzBQ97sUXOc?=
 =?us-ascii?Q?f1bJZAiclHZFEayEysxc8ILvZWvTLZsAr+KKlsSOAcTxukoOywHSvfiaJ1o6?=
 =?us-ascii?Q?f5fdaAEYUcl32fGEqlpAdyTrRuW0hjIzbUIOFE0IducxFKEs7SNH9/JsQxTr?=
 =?us-ascii?Q?PPwkLOcm4mw60X+t7ZvR8WnlHFCzyxOudkCAoWRF5tuuQYdFctl34kQN/EaS?=
 =?us-ascii?Q?7UM79xVDIEdRJn9h3wQioSNxGSDiI79yVgYlMqybSg4AVu0I5ajqhVhB4oZq?=
 =?us-ascii?Q?1hovQ9T29d0FW+ZC7pn1WpzEC0g7gtGU/xc+lzbBYKk/LERtkTVydKnHrR8v?=
 =?us-ascii?Q?B4SOCMauCNp2Xu2msBQR5AETiBZiyhyd23rvweND4VwcduNIvkgiegj1SYrz?=
 =?us-ascii?Q?632ViMlvjHzVzOG6kED6xYYR+WTKPdcU/mD/HKbzH6ucVoILAfH7/OkvOFhU?=
 =?us-ascii?Q?dgemQAOsxl49OJq38iK2PSP3sZmpcdjVwF8USqXNBX7G5jRgDpXnf2jRTjHh?=
 =?us-ascii?Q?UOWicCETaKggTABtCUqvORvo+74LNdBIrX9V659a6ApfQTz+zzQXSIWk8MMo?=
 =?us-ascii?Q?In54HrkjONnATG5dkhYPdUkxuu7sL6HqO1FSTK0p/fpVCN/J2v3hhrQ1lLHf?=
 =?us-ascii?Q?K7n5Fqxki30SCq1pXR0Tybgm4gdyN8FnuVDe2r8qmdWYwF28gNKTV0Lz6MCq?=
 =?us-ascii?Q?nIbhZ4jAvijyLJieJ8tC2rxcFMeI58QkQhL/8h4wNQRsDEpDeKmOc4BqCUHJ?=
 =?us-ascii?Q?badppqFsMe7b6Z8ZoQo35UF0ShqJBIv7xUc3xu2xZIHyrkW7+KkxKiUdpwhD?=
 =?us-ascii?Q?Wskc+U/9kJZCxcwldrJIPzeab4DhRoS1RHEQrXg6Sx/3B5la4Vr3j1x01Ukt?=
 =?us-ascii?Q?nheAMjjRgkKpdC90iB0KvOk7fHl2UUOrDQPvB3/7D97WM+CHPIm+89xsLUxf?=
 =?us-ascii?Q?IcmovD1V+SS3vIQnBsh2MJBhF5sR1RstOUYjKzZUAjApvqkh/bEQPpWkZ9Xf?=
 =?us-ascii?Q?pNW7A1c57oOIRplMVA+vlmx2oczTAr/Ds56yPSSQRW7vKHx2G4WSRN2vx/Aj?=
 =?us-ascii?Q?PaQHQ2Hd38FpO/dYeleQ5RqEVzkzHTd6k5tFRCrsgdTdiJ//2vKq4ccyjZuj?=
 =?us-ascii?Q?BRTKKxcBeF5hsmdq+YQbfKbPhCzlF/QUKOYkzZl0mc4j3DpZYwychNy+Z6KP?=
 =?us-ascii?Q?ZItXVl37NtHuMpkEIU1O1ATRPy6gx/UcpF0G0yditdftWeS8zMN5Tg5ApwN9?=
 =?us-ascii?Q?08S+807xGZk5UIl7VNyrKKvq2B/yi5NvIMQb/yekvVGHmNqs2EPwXTotvN82?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c468a066-1437-4e1e-17c6-08ddb3532624
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 19:13:06.1946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jZ9X+sY6dl4fQ2WS6GrHjByiGA1KZT4fFfdy13MHW54IPDIMwZBYc8U2eZ7d87ATSOiHI21ocLuCQvsupmSL7yBtIjSwss0zrQNI6rZ4HY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7491
X-OriginatorOrg: intel.com

On Mon, Jun 23, 2025 at 08:01:59PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch avoids another update of the consumer at the end of
> dpaa2_xsk_tx().
> 
> In the zero copy xmit path, two versions (batched and non-batched)
> regarding how the consumer of tx ring changes are implemented in
> xsk_tx_peek_release_desc_batch() that eventually updates the local
> consumer to the global consumer in either of the following call trace:
> 1) batched mode:
>    xsk_tx_peek_release_desc_batch()
>        __xskq_cons_release()
> 2) non-batched mode:
>    xsk_tx_peek_release_desc_batch()
>        xsk_tx_peek_release_fallback()
>            xsk_tx_release()
> 
> As we can see, dpaa2_xsk_tx() doesn't need to call extra release function
> to handle the sync of consumer itself.

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c
> index a466c2379146..4b0ae7d9af92 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c
> @@ -448,7 +448,5 @@ bool dpaa2_xsk_tx(struct dpaa2_eth_priv *priv,
>  		percpu_stats->tx_errors++;
>  	}
>  
> -	xsk_tx_release(ch->xsk_pool);
> -
>  	return total_enqueued == budget;
>  }
> -- 
> 2.43.5
> 

