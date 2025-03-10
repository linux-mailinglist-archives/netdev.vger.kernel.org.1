Return-Path: <netdev+bounces-173534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5521A594FF
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EDB1884C8A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E406622172D;
	Mon, 10 Mar 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEqEelSx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DF413CFB6;
	Mon, 10 Mar 2025 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610753; cv=fail; b=HgcoZKpR2Nzyez8SwyXJk1n/qLzZlYhFcPBYfJFnbKscsaXDgaz6KY8xUlEw9Ky58XlgzIF+74/RJlQHzT+TfjYmyFu3IWC2SK3spa/zJPluSJ0Qwloo9fF1oH13H75h+DyV2B0dkkaAAOnR2xIdSjavfZn37CeOjIZBnyRJiJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610753; c=relaxed/simple;
	bh=JofUWd/9iujSLZZj4lwqSM4iikIXT/i6ueGrDPCPBec=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NNo+pvS4Qo+RCBaSAjgAXy70bi9KQQ5SLGC3aUe7ZBm5mGGXkmmg0fkLhwSvG31IVwT9CwOP0e/jia0OfD4n6SQ9rYGQp5nXJDD+BdNm5ljdcrUWZb4apU9zA37Nra8IiDzO5pUIP/6DFnGp4/Nj08F/7mHUSjDgHENuSAq3bzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEqEelSx; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741610752; x=1773146752;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JofUWd/9iujSLZZj4lwqSM4iikIXT/i6ueGrDPCPBec=;
  b=TEqEelSxkm+VtDWpOf+ktHQKPcSLIyOIs3ppkKIKhzvy50ZO0+OpFu9Y
   XQHaarFX3csw1aVXUi9CzSL+ofqxP6N/8hxSHQf4AOZvBMWwajlJxJ6Pq
   cdi8yDGP9UmNB3TP3Jk87LEPsbr1OFw9yNarNmax5jctndcudpbgnZRoF
   NIt3YI5QOZ+R6lydt7L6HeoBzYmOYO4ttly/lVJwoLKFznHR3NyPnpwdV
   JM/yncmSNZUTlGxY4j6gHmnRutPXaCbZlWvLKW7X6OJJszKIfzdBZ89GG
   W3UcKTrVStQr86th/D79zq3fKsjWi4C8G4/twvlujdflqT8z/EvXPBCrh
   A==;
X-CSE-ConnectionGUID: uiJfCpGyRnel8yKs8VUpog==
X-CSE-MsgGUID: nL3VnU2AT6m8DTDDygQIXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46514237"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="46514237"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 05:45:51 -0700
X-CSE-ConnectionGUID: soKKpF72RUKwPzb2OxkNhQ==
X-CSE-MsgGUID: X/HfDdR1SRCNovkcZP80Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="119994356"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 05:45:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 05:45:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 05:45:49 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 05:45:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfhRo55tdxUOeenEjlwpcrUNabjqfC8M3LFzwxHu3F3/Eciz3oA3zTBjodolqjsqKqSjiBbEbXlT7mdXqN+yWjhZInqa848Uk+3cAGtWrDKmm4SmZRmGoeopCjxDv4DFOHrATKGO/1m8WHVAjrIfmqpXoCjXrgrrBviOAGD7MZJrwDsxr7pfDEx8InLrqkPB5X1dM3+THjJHBDj6gcPQHTd8l5k+zYxdoZ74/rsIXANI+rexdL9KWUWnrNWbMINobkubJfZlIJbW6tMkGjzddnfUSncamTbLev1+8HcqcZeO9xVO7VKQd3zSoZD5ecB7NyHg7lFqxH8+9goK0kGgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4ffl+cDXAQ/pGDL91hV5iJQS0vrOlcT/yhwfmFyqlU=;
 b=KyEooMn/02XwxGbTGO6tK6rw0N16N5JMATahfOPsUw8mGqMoobyusKX5tk4t/COeXQtLcoEvHVnjZMLT5zsLhh+Te4bfhnKoKuvXorrLTGqGL4D0Qsreo5WrFKvVmg4aWCthOpWEeBNtH6sQKpVDA2qwBKheDlFjNENm/hNLxWeIuw+doCVQmt28qZUGXcexY/+tnaX0SGbqupMkQMrIHTOzeYQ91Mnewttq8ifCloozorrNDuKASDGFg2y3i8QS+2aa+Kdh6WvXj0L45kqTrQXt0oqkLJYvlwFKcEnZuk8ytcuchCTBv9NBSyfIlX/bMutY0jKme9M/Bq0oIvIrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SN7PR11MB7465.namprd11.prod.outlook.com (2603:10b6:806:34e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 12:45:47 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 12:45:47 +0000
Date: Mon, 10 Mar 2025 13:45:35 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net] net: ethernet: mediatek: Fix bit field in
 mtk_set_queue_speed()
Message-ID: <Z87e75UV0Qc4oY64@localhost.localdomain>
References: <eaab1b7b-b33b-458b-a89a-81391bd2e6e8@stanley.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eaab1b7b-b33b-458b-a89a-81391bd2e6e8@stanley.mountain>
X-ClientProxiedBy: ZR2P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::11) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SN7PR11MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: df2c29aa-4ba5-4838-bd2b-08dd5fd17a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sBt0UWL7ZLHGhVvJ3GwopTWNeX9B2RvVxJhvnRCI1OV9BQubSAj+zCzeIHFV?=
 =?us-ascii?Q?9U8ckC23DZkPya72rN5yr/uM7UX8Is9lEzVWvVAEouVO27K/tS/1IbwVopql?=
 =?us-ascii?Q?jMqX9p9KgSxKz2aOR5O4liXAIFIFYmYVWLt2ncImGjx7/E3UOF4jB7cjVXz4?=
 =?us-ascii?Q?VpL3FQMUEMV74kjabEenMB7j6mITkQX0jQpi5XMswwPLbvTliyZZBKYV8o2u?=
 =?us-ascii?Q?USYDfuuqkNXU8DQAHXLWMY0fVMq3ZA5iYIsSa7AZ+xLj4NkhpL2tjVf/pIuL?=
 =?us-ascii?Q?TNM5TWlzQn5Rv7UrXwehdr/yohQ0s3xH4a/mh4XnqKESJxfD23+68/59rrYw?=
 =?us-ascii?Q?7dhmDt5pUvqj53lhpgxHXXUpxzmUVpl3nl5HIsENYC872rPA2ntFfD1zZq9D?=
 =?us-ascii?Q?0nrLM0HdQkblJ6o9y5GBHEbQEplZNFcpLV1ICGUxi8ljQWMJCuCqKkexwUo3?=
 =?us-ascii?Q?mHB+vcHNOZaMZK/rk/oqT5QsC2Lb6sVGFu1DlCDH7nR6aQqfjVM9QFUOsrN8?=
 =?us-ascii?Q?Y3xDF3/z9E2x5wQeh3BLAtck0vM3eHYl90lMK6j/2W22jEdjjfAgoN8TjdQk?=
 =?us-ascii?Q?XLuo4m6oiRFdx+eNf4EXS30/w+mfe+GGKXl91MwWKokkwcpMr9MZXT1pg2oU?=
 =?us-ascii?Q?rqR7t33jlCTbwNNhc9fjyZjKNWOXWg1vJ2Hk6+zze67oidirZe6dvue0mmxb?=
 =?us-ascii?Q?+EAD3Rdnw1dYtqxTwdVYq/N1BGpr9KGbd6qwp/v6kdcbyBYgAuNbt1PyKbgb?=
 =?us-ascii?Q?zje/f/Id3bhVqBszndN8m0CPOsaqEMHoy4xfajvbwEO9lKXceDnnewMw0vSr?=
 =?us-ascii?Q?OYJ1UBcldl35ZtTf7YwY5XEPuW6HxN7FgP6dQpVnQVFhtUNZSg9B4Ws64SXK?=
 =?us-ascii?Q?AtTPVuveCQ/DXIpFWJU5ERX04vwQXEphHsRMsTXkG7eTLnz9wm5H75lXmMTP?=
 =?us-ascii?Q?HPbcTtZoNvd0GrfKci3T7ZLThk2cYE8qypIVP+wRmATWV1oskX8iuFNu6cjA?=
 =?us-ascii?Q?Cg9ZLLTwf8WXkod+qLSf6TggZb1ITGTMQv8KAI8Ev0KmIB8x2CFGGL/9iitj?=
 =?us-ascii?Q?WdW73kvHKj/zaplafXBJ4R4EjsOi3+rWqFRPzQzFK8m0X4v0Y67nNWzO1Dko?=
 =?us-ascii?Q?fxaQxyb2bWnQli3XajHsqOONvm3NJSD1sZmdEZb6PddJShli3UJ53lElh766?=
 =?us-ascii?Q?AmjLv5Zo8/b2w9omT97xyobjRzJRSji041+Ag69MabC0hOf0L50vOO8/E9Ju?=
 =?us-ascii?Q?EolVFoYdsTwi4S2H6HTJHxOhLpKcqLLTEXaHDefOM1wN1xTq2bVTfw2u5Hgn?=
 =?us-ascii?Q?H+NBqPg5Wpz3exI5QyJIerW0qlg5/rlxxA3m0niztidJswpTLCoAJrEF1nlB?=
 =?us-ascii?Q?1FtgwyFMPEB6m5vWTppx0IP2Zd6T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NZiBIAWExI01lhNQCNrfoSM2srrw6Qa0oZi+2mZ3NN2VV0w6LpL7bdKUoqKl?=
 =?us-ascii?Q?e6xFk/vCd2b6P0oAPMo0AwfezUiNm3Kx2XqUI03FNYn35upUv9fOJ6UDvZod?=
 =?us-ascii?Q?lCBzV7IRXZHW21jsG0mRS3S+Hd0u/4U7/1RxMmVbr78miuMOd3ZvnO5Fl1sw?=
 =?us-ascii?Q?QrkK+VE3J+VYQaVX/O9OTone8Aca/WLvAcqEC+7xiOkbsqiKuwUXr/Pj2ei8?=
 =?us-ascii?Q?ey5ht4D+CLLJKNdoLs+8jeuHaT1qtNlkO5JlOZd2YzdRGVzBLfwB9oxf/her?=
 =?us-ascii?Q?37IJRbWEJOBUEh23u93EyeWfHmsO6bNzuTagvpkHZ34F5S1MuCdrKr3gJEr+?=
 =?us-ascii?Q?GhJWELLCiv8ENFK2LHHqi6kMJifNnjAGZ/x2K/p46DUceDRRgYm4H+ofd98N?=
 =?us-ascii?Q?4ycc+zzmSkjsa0giGyu1sL9uQ1gezOZ2eRSsc/AcJtXVVPUs8nloXoqBZ3ix?=
 =?us-ascii?Q?KfpCqmc6oZocfpUBEX3/hDP6nsCMSVJ23nFpFE98ZjfaR05uz4+0L3/Xjmck?=
 =?us-ascii?Q?Q9IZC6XIryj0erNqEytOddxPaQgmg1M4HLYzOLvHzQmw+7qZ+FCeH1cBldHl?=
 =?us-ascii?Q?aakuYw200aDJaoFYOGvQT9XWmQzdyBWp7gG45g1GIIrjzsfl6adWBBlkcWLx?=
 =?us-ascii?Q?4hCJf/YMFeNMLm62nCKsCJXxM9BNiQ1JjsnQFuULjpscZAbYunyOSEvmzEm7?=
 =?us-ascii?Q?dWEy/GEPF9dxQxETgW/0ZxYmGDVosLipWjcjyKhs+t2+KhK3ICDAC/zb7gFg?=
 =?us-ascii?Q?5wcyNlp3j6sT2LFI/kQ0BtYqycbUn3pZJ24XaXCGrFmRFZaq7SxhozYh17ML?=
 =?us-ascii?Q?zYIOE2KWVDLx2a7jtNGIh7YHnwoO7Pw8O+7HMnRBhA9dFirq32R/4cCSkcg6?=
 =?us-ascii?Q?WL6WvF1FWk8qgC0ffIvBWX0+bwTb3aMP8K8Afao+B9WPTcDjMeaFj2EsMMMY?=
 =?us-ascii?Q?QJoAG7e5qbtW7Wd07K0qGVxI2tGqN8BZs1rsFGcDgN42PyUqHlE+rwV631Dc?=
 =?us-ascii?Q?xVgQoH6GYYdAUnJEBekXIr1cfQuCqw9vv6iP5mZJeukWElMRomiqf/poatp4?=
 =?us-ascii?Q?alWNzTdHqa7zKELfrTHCQSpIDB4E12QqOa24VvwvatwmvnXSVg5UHNrqkIET?=
 =?us-ascii?Q?arHvpxfnEOUn9CnZP069I7kJOSLqKZ42Ic3mwDobSj91MLcD2BF/F1DmKK/x?=
 =?us-ascii?Q?drFMhrBEOGZKqiVO3pr1D1fi3LBIJE6dgQy536rMiEA6Tiv8dAlWAn+VY42b?=
 =?us-ascii?Q?24/isQRDrVSWv2yCXb8tlpcLLwjhHULF4YoJ5kPt4ttWyVDZjf6ZThIFMw4i?=
 =?us-ascii?Q?zhMZsx8ByygjrQ8k0wVYqhOO3IINTyRG/92a8Urwd/u1dBjdHoMiQhWZ+w1b?=
 =?us-ascii?Q?6dePAjlbTKoLyPr5ZBM2Tfi68LmWlkp0ghfxluAfowSORmwTU3KZW/ymzArw?=
 =?us-ascii?Q?E1DUMflX5V/b+/VQ9X99Jq8938Y5DmGhTMQOGS4Xf8bs3hCKJG6Xb6UJDTxy?=
 =?us-ascii?Q?jx1sUeP42oy8wc4RTHVYLwwDrLzl6SIZrjoLBfopMYzAh4dktoOhrT33kPkN?=
 =?us-ascii?Q?sgJDx0ZcnnomX1TxPuYQBB9t7mvaozYo+PBETdgo4XGaBz+NdLLLyQIurVcr?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df2c29aa-4ba5-4838-bd2b-08dd5fd17a99
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 12:45:46.9234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZ8JvhP73eL+nm1JfqQYsqk49lQ2/SJI+dQtdzs+HJGS3o7kzQKNwYNMv3DtHoCsRhLs2MhWay7cBH0bWQKiow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7465
X-OriginatorOrg: intel.com

On Mon, Mar 10, 2025 at 01:48:27PM +0300, Dan Carpenter wrote:
> This was supposed to set "FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1)"
> but there was typo and the | operation was missing and which turned
> it into a no-op.
> 
> Fixes: f63959c7eec3 ("net: ethernet: mtk_eth_soc: implement multi-queue support for per-port queues")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> From static analysis, not tested.
> 
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 922330b3f4d7..9efef0e860da 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -757,7 +757,7 @@ static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
>  		case SPEED_100:
>  			val |= MTK_QTX_SCH_MAX_RATE_EN |
>  			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 1) |
> -			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5);
> +			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5) |
>  			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1);
>  			break;
>  		case SPEED_1000:


There's a similar bug a few lines above (line #737):

	case SPEED_100:
		val |= MTK_QTX_SCH_MAX_RATE_EN |
		       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 103) |
		       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 3);
		       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1);
		break;

I think it would be reasonable to fix that too in the same patch.

Thanks,
Michal

> -- 
> 2.47.2
> 
> 

