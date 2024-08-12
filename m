Return-Path: <netdev+bounces-117695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE9C94ED4B
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E36B1C20D46
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C0C17B4EC;
	Mon, 12 Aug 2024 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXLRWAuG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F9D16D9AE
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466868; cv=fail; b=Xo/tHu+1WYw4ILM+sYwOMlnCQ7rQtYh5vpY/9EYnuUBsCbemFNxxsNbKv6PMJs2cz/zky1XRZTDiXiJN8G90BlD5+0xGwWsrT4Fs++cKvWp/s/1DwHfeBHilWwLgpUttgEU0zOYRUo1FqQfgVyP4kG8jNMeTW6ipAgV8Ey+HlwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466868; c=relaxed/simple;
	bh=Wq+s9xwpckwpLjlQ/m6GAXpep23abp8ZKMqG/4Y6X8w=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FjxeE9MoAQRaI7undX5OEhGDxAB/45P3sSHo52HwYq66Gx7yUT3VxUXGf8z0CyFXxAM6CvwXHxE0ws3/ncb3scK0ZhTMoZPLLutliGcwrhcqwYLpmno+GljQJ86ZUkNpm/rEGMgT0BchGAWXRQCgLdjcL+6w9hVbK8XrMjFq3AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXLRWAuG; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723466866; x=1755002866;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Wq+s9xwpckwpLjlQ/m6GAXpep23abp8ZKMqG/4Y6X8w=;
  b=jXLRWAuGTArpC2QffC5wB6xgDaWKt3XW9kLwEQgxNlkq1o9Ktp1CKO9v
   M1jQBM9CDXtGAznedgut0LPKY1uwW5YTbAyshGX9rhMNs/XMzq2XertsB
   FV2tKWhXRqUjaRhKNzKLubwvsw1A+r3sZwRx9bNMN1h5/ruSiGrwJTPO7
   BQHyusR0W9L7mqtUc9kT6kTdr3hXXJFKtXXJKMsDaTmN6OqRF53r63hLk
   7QR8Dryj0wZ7ILhnyBW5YgHhDl7nsLmRkcpYGrmrfC5EAAvoMAqxhoRUm
   oRegNiUmo3GASvb/PVfH4TcxJiIdg1K4agCG6VHEaQEVSoji2rZpwCwR6
   A==;
X-CSE-ConnectionGUID: 0xk53wOKRzSYBnVr5eQAgA==
X-CSE-MsgGUID: 2Vni6gLSTluTzIHh9G7sQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21381947"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="21381947"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 05:47:42 -0700
X-CSE-ConnectionGUID: FtPFVtk8Q06nj6qIfwHiOg==
X-CSE-MsgGUID: mVV40GtSR3uKknX5/AGs/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="95773054"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 05:47:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 05:47:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 05:47:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 05:47:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 05:47:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOPG053QQqUW9muaauQVY68qz4P7VYKK1Oevq0qCUzVra1aPKx84PrFBYY20re4u98jeBbRhAnIOWwQ8htF6sJ+X6hqWc9ZqxwjPBBJlScZaEKbQC3qU3GaXfojQjWcAlPLHi3AwC1zsqIyVO0VTFT9eyn0IwhfOD0MoipgBDmDaeRu6D1RFerZ4Iv5fF5YN/DEzLu/beLJceBp4NeKVqySdo0/qwHdx8yt5ZiD8/CZd8NDil3EfFgCavRJaORuuNK53X4NtVtOYV/jQT75UHmUL5xfadHOhJFkpBgSUHbQjS4Z7np9dlbHV0UIMARAumKjhtWtzR36LJiaWp9tHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4i9S8XfIIv/HhhJLvIkNnnuLBj4HXJHR1SOgwo0qTc=;
 b=d+lQBQD0lZowgPd7VU0FFFKRDJn76DDwbqrk8up72ZdiGhHwfXSK2n5gd6xSngJgsu0t4rn0H2sJfno4zYEJk4Z/944MtV/Y1ZYeACw9MQu88JZwNr+UyzTAw66B/hLao9qt+iqaiE0uwEqC4SdSbj/CZQ5nThabJLXI7QTm5LpD0jWaOq/llj3MzcnI+MFj10zFgB4o+yfJpYN/16tMkC13k+d6Fuf56lh3AKThRJoW/MhNmQK3oehOHO/+PkNm10a4kZeEiel1Gabl3cli4W/EbXbuU8IzzNz6U3Dmadu0/wkm9wUl8YDjImHU7APlVvgOO9JidnKK+szSWESsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS7PR11MB7906.namprd11.prod.outlook.com (2603:10b6:8:ec::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.27; Mon, 12 Aug 2024 12:47:38 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 12:47:38 +0000
Date: Mon, 12 Aug 2024 14:47:26 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Jan Tluka <jtluka@redhat.com>, Jirka Hladky
	<jhladky@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, "Pucha Himasekhar
 Reddy" <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net] igb: cope with large MAX_SKB_FRAGS.
Message-ID: <ZroEXqTmTN7dABWY@boxer>
References: <20240806221533.3360049-1-anthony.l.nguyen@intel.com>
 <ZrOcMAhE2RAWL8HB@boxer>
 <ZrUMZy/oxdu7m6F5@boxer>
 <ZrYIlDqUc9obiyt9@calimero.vinschen.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZrYIlDqUc9obiyt9@calimero.vinschen.de>
X-ClientProxiedBy: MI1P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS7PR11MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a694d6-e67c-471b-018a-08dcbaccf248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hopRb5WXPRDMU7cWILhikXY9iGlqLx5vCZ8aGdPqyBSTxsRyxikANNmISKWe?=
 =?us-ascii?Q?lXqEJO0s/+Dz2Eo51+ghnvQ4Iff+Dz3Lrld5ymhJfs3pNXKTt7k02ZF/rMal?=
 =?us-ascii?Q?6Lf59+uT6rbusodnnlKUCCWTRLlX6ITaY93UqDkj686kHQJjzAtd6nMbZ6oN?=
 =?us-ascii?Q?C6YZOBL8Md7uo/IjTURmYhRbFXqwUibhagiN3qMcYhuaDbaEQsOwnfnEnpCr?=
 =?us-ascii?Q?AxdtCOHDeCp2A6JTYhHlBmU2S36Hfw3AeVIsEAjwvzRpjxSlTXlQrOYwa9JF?=
 =?us-ascii?Q?ZJu6y4uUoX40nYPsDmN/46z89dh41cIgYCndHUHXZN5zch06ITjRJpo8gk/P?=
 =?us-ascii?Q?mceynN+7nZlTpLYVI5kwEwYWpxT6ga5L4NaKrmBTBMp5r5arTnRyNG0Xymjt?=
 =?us-ascii?Q?U9nNkIONJTKbLRZcVPClVRW3RdDKEYJ6WNCFG0WsbPr6AH6ppVgyPtPEDwJn?=
 =?us-ascii?Q?GPoJX3PNDNKGHk+vYyycYJyPuD7QAlujb4/UO88grxAer/knujYPCdOFxFsX?=
 =?us-ascii?Q?6TxCihWSeOKiIigwW15194QKIcQqWgMW/2Dsm5LzUgKEPVF9VpsWILTUuJUO?=
 =?us-ascii?Q?GzNKBMrUXO+51eqWiZCVCN9txz0+mGi/S/ufCiwpTZHk2MY3r+4Ufw0gEgrc?=
 =?us-ascii?Q?LNVO8cPF99SXievVseWV+UUvQDEY2KL2ejR37Wv0ODsaIzCDvF3wpUW22lZK?=
 =?us-ascii?Q?WDuZZ/fzQ5dMOOgS0r2XLy7pQUhJSj2xA6HeilpUpD0z7I0KcQg0S5iMwU3+?=
 =?us-ascii?Q?gftPC9+g5gi1Uqxn7A+oNg/PWS8nonKoSSST6NLwtQRxm+tzzSP2SHS0GzGy?=
 =?us-ascii?Q?vlBYXABOzj38ZpcF/nBr2jXS8Kllg+AvUyMktz54d9jVwGJ8ic/LrRonhRfF?=
 =?us-ascii?Q?OmdE6PwyS8lNHlukOmoPGmRybBfT2PWYHZC473oqCoLGUJCAKMXGyEvjccC6?=
 =?us-ascii?Q?eoK2a7jlTLAILNVzUWHUhoi/kwH6b6EyWj6ntiRCSZu7pE1GFFFYrdj1s7Zf?=
 =?us-ascii?Q?f1qX9yk67YG7nykuFpLfH0Y/ZLeaAxOH9tWXrViJq4mIWO8IwjYQlHMIVJJ5?=
 =?us-ascii?Q?jW9WoeGFruXe5OALZeGXetAhG0cNv9cIijum9gkW8+eAvOHW4jV6n4ANTUEj?=
 =?us-ascii?Q?CbfdIy7u3NXNlEHPmY/ne2Wq/gt/nDo4nnmpsAj2bjvuHL3zhYpwu9mo2riQ?=
 =?us-ascii?Q?wUjO5nOF/ymsNEfan/m2hK4XyTVKNy8bry4kBuh0sbK7mWPSBwGYZGcjZsJc?=
 =?us-ascii?Q?0z0cpBa229pjYFugP98MWoKeddbVOA0prdNvNaJzYWK/doaqj/DPX4lXQiKy?=
 =?us-ascii?Q?MUwaUV6gissqXDY/LySJZYgrjRse8/KRaNnKQnscOjXqS13k0AaydEnn5CN/?=
 =?us-ascii?Q?6BWH+PFDbctk2jjEv219yttZ2JUS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?02Ww87xAPW1bqQGw6I5xbvKa+IGiGYKxsG3UW5dgJ2SuCH8/09DQm/Vvhkbt?=
 =?us-ascii?Q?w9OgjaqXDmdF+XVudf5nfHIFsPTWqfZNEDms59UhLlEi7DW9an7442piX5lO?=
 =?us-ascii?Q?Mjtw1/ormvx0eGXUaDFAHdxr/ETLmJz3O4exmmxn50BOvKlN5NN8RTp2Vdd5?=
 =?us-ascii?Q?XjkASK0dSCzY0FWT0ZfjD4yaiZgIFR0fv8pjpwFGU+FxgkTzWTRLfUdQ64E7?=
 =?us-ascii?Q?8izUrOI9szpL+nwKeSTN+VRg3eTT5wk78A3zIlfy5UOrmdAk5WUZfNXbFI1W?=
 =?us-ascii?Q?wSXDm9tCgSsoaaFMm69c3x2Zki1X9yRbF5MRVOTtVbEUlIf2typyXjWr2nqZ?=
 =?us-ascii?Q?sf8BAFnq6Bu7W3FG3dZanM6kd6Hmi0b6/CZL8yBd7nEDUW6ipoKln5xKv29x?=
 =?us-ascii?Q?JuZUTT6ngIfP41FRBgxxufqOvjROafJH6hLCJgrIuEYNX2504sq/tThZP7uQ?=
 =?us-ascii?Q?2FCKwOXY43e/IfnqLaxLq97uzgfnng/0cmTEcrEvxw9QpZbYJrNCGxPAzVpg?=
 =?us-ascii?Q?t/16xVTvHZFr25BTuMNmPs/ptzmo6QunhSwXCSWAzhKzEueU0rFpSEfn8XfP?=
 =?us-ascii?Q?5+uQ1dD1aPTcWI6T3FjnL0gK8rjYWzb9p1Pn3/9fwxpW3ww6dwb5IkjKalZr?=
 =?us-ascii?Q?w0AF49QcmnsHxC/tyrMUcj/EiFeLc/ZlN2dpIN0D87wmAU/pZ3a3Xg0IVxx6?=
 =?us-ascii?Q?OpXUKBtMnHf+u2/YtE04aB4YW2ABSM4pNXm+RUV08pRi2jUBclQ9BNtWQbdv?=
 =?us-ascii?Q?cj+mODJHzZsI2gI8qAi3zCmaSqg3jnY9VEk5eNCd480e+kAGRmoN2iqQ6NUp?=
 =?us-ascii?Q?o3sXqgW/IrA8BodsBZMnxiNeTZlvvH0vei0J2WtAGPO3Iraq7fJvcE3Iv67J?=
 =?us-ascii?Q?AhIRykDuIHbtMVQKb1dTKHEBLdwKT2onmkgSe59Ii54PAEFl5V7UQy9h6tJc?=
 =?us-ascii?Q?Jkft5mWlvYSUJZmhwdDgGp0Bz1FoqTdkhRcfkV+Lac8sxXYf+rBB3IeuiLAE?=
 =?us-ascii?Q?fnMCfG7FVrUobWn4UD7pRHafuXfsytM4GBoCcKpFxg4jfNo8X/sbvVpAiAZg?=
 =?us-ascii?Q?Aq6gY+Xz7Q9kg+69/kjXggv3nbQCJB4TSmw46h42ZmnA9aJnkpglGkGiofX9?=
 =?us-ascii?Q?9WBxvEkz1khfujPAPgyxMwK8z/+ZqTvsFLWtIKKd6aTW4oxgnqF+9zkEVTxY?=
 =?us-ascii?Q?xzm2ZdrxbbgxcNeLI6CFH9EWfQ42OSI3AJR0s5DjIBixiKD4igqYzi2geYcy?=
 =?us-ascii?Q?4KfW+H6p8BIUYpoAt2W3RzP0TmzPqRnkQL+Tf8c7zYusARt/ppcPHiYRVwLM?=
 =?us-ascii?Q?7urY7M/D1Ce5WWhJRgNugkY7rzEkP0wCB4SXK9BEwrEtEG0ic8tcgLj61qZ8?=
 =?us-ascii?Q?vrRigoX2lcn14R54ucIlv8PMwAMvpOeCZsUEsvW2STrLsTVA9rhshsdH4arb?=
 =?us-ascii?Q?hO4l4dqsfFINluNOEkkG3tYhr8eJTff08a3N7U/eiAmzvbU2N3i5Cph7Nqdq?=
 =?us-ascii?Q?SkSOfgfk5GIxAEPXsLOwLc1vOcWGXK3+gMzSdcz3fjKoBa3ZIMGHg6dCfPKv?=
 =?us-ascii?Q?n1Tiu4cW8k3ENutlpQMm+z7nZnczVwlOxhN1YALBsfcqCkMyRLcI8a/dMQB4?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a694d6-e67c-471b-018a-08dcbaccf248
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 12:47:38.1906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWu7pTc0MNvKMHg7noEa7fS0TS6sqIvXOmX53FXJzdfe+iMePLaiwsszV79TOHNrwWn3seyZMG0TaHQYX4nWxe27gk/Cwp5J40NZFtMbnSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7906
X-OriginatorOrg: intel.com

On Fri, Aug 09, 2024 at 02:16:20PM +0200, Corinna Vinschen wrote:
> On Aug  8 20:20, Maciej Fijalkowski wrote:
> > On Wed, Aug 07, 2024 at 06:09:20PM +0200, Maciej Fijalkowski wrote:
> > > On Tue, Aug 06, 2024 at 03:15:31PM -0700, Tony Nguyen wrote:
> > > > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > > > index 11be39f435f3..232d6cb836a9 100644
> > > > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > > > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > > > @@ -4808,6 +4808,7 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
> > > >  
> > > >  #if (PAGE_SIZE < 8192)
> > > >  	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
> > > > +	    SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2) ||
> > > 
> > > We should address IGB_2K_TOO_SMALL_WITH_PADDING for this case. I'll think
> > > about it tomorrow.
> > 
> > Actually from what I currently understand IGB_2K_TOO_SMALL_WITH_PADDING
> > will give us 'true' for case you are addressing so we could reuse it here?
> 
> Well, IGB_2K_TOO_SMALL_WITH_PADDING is a constant expression evaluated
> at build time.  The SKB_HEAD_ALIGN expression is dynamically computed,
> basically depending on the MTU.
> 
> IGB_2K_TOO_SMALL_WITH_PADDING switches from false to true with
> MAX_SKB_FRAGS set to 22 or more.
> 
> So with MAX_SKB_FRAGS set to 17, IGB_2K_TOO_SMALL_WITH_PADDING is false,
> while the SKB_HEAD_ALIGN expression is true for MTUs >= 1703.

MTU >= 1703 will trigger the current adapter->max_frame_size >
IGB_MAX_FRAME_BUILD_SKB statement.

> 
> With MAX_SKB_FRAGS set to 45, IGB_2K_TOO_SMALL_WITH_PADDING is true,
> the SKB_HEAD_ALIGN expression is true for MTUs >= 1255.
> 
> Given that, IGB_2K_TOO_SMALL_WITH_PADDING might be the more careful
> check.  Do you want me to send a v2?

Using IGB_2K_TOO_SMALL_WITH_PADDING here aligns it with igb_skb_pad() when
computing headroom, so if you don't mind maybe it will be cleaner to reuse
it?

> 
> 
> Thanks,
> Corinna
> 

