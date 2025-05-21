Return-Path: <netdev+bounces-192447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510FBABFE98
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F733AAC1F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFB07485;
	Wed, 21 May 2025 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hE3QYE3I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6531799F;
	Wed, 21 May 2025 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747861310; cv=fail; b=CP3qizxKru1wpgDmI6UyF+TUXRETJ+4umvKrXDjjPZ/6rEyXo9V5mMLKaDaG3SkVWC1P87m0fGyb/HKrOWx7XgBnfEy1JRU0PsFAfsWKwdAwjVh5kR7uvMjV1MPz3nsB+7ZnZNKURmLCZNog71V98qCA03HPdzna0MHcji5a4a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747861310; c=relaxed/simple;
	bh=X2FGD133ZYfyJyy5uoaS4EzT187/+gOnOQora0d6hbM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nzC4nf6PACXabvma0Mg4M9vKxMmBDLt6JuK3Ypb7qy3Q5nF/5fbGZYQvox/teZpbXcfSZd5Em+0q7Ic+C4elmAjCSMD3OojvXUDC+qkesf5YC3mhkCUqckIjZ4wxPOAropm1A4kp1jAXogJGWFPPbssqRNkRF1RSzM21IrsPswg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hE3QYE3I; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747861309; x=1779397309;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X2FGD133ZYfyJyy5uoaS4EzT187/+gOnOQora0d6hbM=;
  b=hE3QYE3ID1g2cmhW4qOHyESLt/jwff4JsF2TMLcQuyUmQI7iem3KOT9p
   21LwW6PA6dcRdRMbh9iEbLzD3k9IF/aIHxAWvnt1ihYulSZykJcWcb4Bm
   4ZX7Rq+KnIGMMrDn4MB2OvMKG7x0WLlz6Cek5kof3aDLXbwjGOEWZxfU2
   jSjT6/mPb+XIKsJCpo7Ry0ZOYNrEdjuYwkUWRX4ImIfecJEggc57Vz3gj
   arkFwomldami/SKBw3MOUK1kLbwgm+Er1ESNsWHj3+812vMYk1dvgwV3u
   2MPy5F9vA7dDXDuVGJdcU9DI84nbd6w+GGW0C7iEHgv7GxigQ8OOD+cfx
   w==;
X-CSE-ConnectionGUID: pAbMMlj0R5KBLRtk7cP49A==
X-CSE-MsgGUID: K+FeiCyuSQmRfly3Glstlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="67275672"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="67275672"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:01:48 -0700
X-CSE-ConnectionGUID: 2sc1GNN0RMGuZQgmMAQ3jw==
X-CSE-MsgGUID: dQUdPlAvTFqCQ0p2zjXaNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140671578"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:01:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 14:01:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 14:01:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 14:01:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEiGtvVGquRmziRa3K5hJ72GKcFLLSiwcrHI1+C1kKNYysg1vaf8+ofSMye58f3++Rxx5igYw4gM7MbwkxLyArhCdxNhbhOnl91At8S1WodLWTNuWF9e52Mdex5DlV7jEeOvZpBMK4lkmX2sLdi8d4Tow0VuwmKcgXC9Tig0+15zwweBfFZWr+mswfz0wiRikZySqrlbe299/075sBcq+lxA4KgQwHxnQk5+hqZl7WU7jRu26lzfqBe/LRad6MGI/NEQKMAE7cR9Ba/1tCHtvKXWWH6CRI88AGRuAChUKW9eAdQSbDMy+Iyfqbddp4Jh2weZOBcJPLDF5D9XVKictg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AB1VWVKLUYj3RJqwwh5saU6lRkV7sGLImvpIfKmRbw=;
 b=IR0PAq+NwFqW20NzsREMF8QkuotUPuk13dk5mcY2fcJKd7D6dahX1EVWyrghN0wiJziAj+kF7E6gSJ6NuT/5CXJOh+IcwqXtfW3vHuFVPO2fn2T7yHp5Pj5xPdv3vucMDctMSYp8iN/7jFH6hEY7HGR5ddm5rOSjVJTogU8Shnhoab/8Z1wfmTS7T1axwe5Mgi4Rus6aDyYn07cFkkUAjuuaWGcuSqf1LICXn5PbwGWplqQqqF2xiQj86WK090i4OGXa0QZEEw/HK6tNVc38i5cbHPVyaRpjuPtbCGaFqIYZnFfuiY8KQ6Fzah+4XbgIgZLd11iqmyE3SrulePozhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7126.namprd11.prod.outlook.com (2603:10b6:303:222::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 21:01:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 21:01:41 +0000
Date: Wed, 21 May 2025 14:01:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 20/22] sfc: create cxl region
Message-ID: <682e3f3343977_1626e100b0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-21-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-21-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 8820bffa-2d15-4901-ce46-08dd98aaaf9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qnd3utOzo+pbjiba06Pbf4y+sFRYWgWml9othsC2x4pC7aEriHDAD7NLeRRK?=
 =?us-ascii?Q?W/QH2/pZ6Fce51AXxPo6CQge/A7AtbPMEvdpLd3yvZWqupwe/fj6cJoJ7uwk?=
 =?us-ascii?Q?M1o36uztK0pNiF/0SijYl7Ah/KqV3efKkmHuPNC83OBPiTg3nfpylqzvcwZT?=
 =?us-ascii?Q?81I6vrn4zTX1gfrpN5CKpAJjo/xTSNzxCONvcSaSigNB/1X3dtmjPSihFFkV?=
 =?us-ascii?Q?c54n6ZHe7CRQfrkNbcthaSYmYRL+ATfyrNXf8ghTmD5W6LWY0YkFx0e/+zf6?=
 =?us-ascii?Q?YbIfElQy1SwsBVPK3tJZlAQlvEYXXPnmkhjEpcNjTr2RnL1q+0HNQUQ5zLxX?=
 =?us-ascii?Q?ZqCPRIdUwy86VCwj5lxAjfUQyM1krTNCArOqS8XxiVtrPWJ8pve3A8YcMETE?=
 =?us-ascii?Q?Fxkx0lWS9gqZNHVKcukruSnSMRQkw/Nqtd4RDeBCtEtdsUBxRvBlADDJI9Da?=
 =?us-ascii?Q?Zxwl3+PLJiLgLIY52EcBE3WKaF9d1pxUkPrWB0EX+32uvYr8pZFL3OHdsiPJ?=
 =?us-ascii?Q?THiPghAzXh4NDipmZNz7oS0eD4PgPOypxO6j7P52DyAWkEGHft511nZJg4eG?=
 =?us-ascii?Q?CIYiLvgfO2GJRtqGYXqkXbRIZB7PfCjG/A1ETStzDJTPlxX6CC837djWEAgp?=
 =?us-ascii?Q?lwF/rmnmaTF87FhnX5Oxt8crmezdyYVwR722KDvDsN1fz6L7NmgH8rqehWFi?=
 =?us-ascii?Q?M1WT1WMalBfXDLwCsT+pGwAD6OgQpGw3QR58n7GcjlECVsBMSw2MSX2vjzDx?=
 =?us-ascii?Q?PsHFzDFu8OStnkcByj0jXlDRkuz2Sdlb7eDopYUsrzrAH6rv7/UdCl0dGeca?=
 =?us-ascii?Q?tt61zUTXJMpv3E/Cq8KQiY/n5qAYncwHbuF84Vx8MsZGsu99wd+FznbeznhS?=
 =?us-ascii?Q?Z+yOyUe5Q4YzM0cWwospEp6lMd3Q5c0qxm5+vp3eIss0ZYgdPmby0JKmMm9U?=
 =?us-ascii?Q?wA7lN2FhFkhc0IoiIwOWrsKYgs5EGdcO7x6dCNe/sU2Cd2Z/b9GpH6IvRe9n?=
 =?us-ascii?Q?O1FPbs+pdviS2h+m0howLhyiAopEWBb8A/g4CjJR22doUCDzIItxazSliDNo?=
 =?us-ascii?Q?Z7oY3oUYbE1GlqbgrZR822+aA3Cx83aQNhm7SWMHk1h98M/rTs2EXOnr71SB?=
 =?us-ascii?Q?ud6kuZTl8TcqfEOEYlEoDiWU4Eb1Paq92/9bmgMd9KEcSGdT25Dn+IreroKO?=
 =?us-ascii?Q?Gxa99bPDr003tnyhiPEzEUEp+kewPAQS/+nfKB7dpZPPkY8iaeCeDIRWwF7A?=
 =?us-ascii?Q?moUOUQd43iIj49ir52RW3inMYCt3DT+9zA2X2rbYEoyW1kgCASODMjLAbjuF?=
 =?us-ascii?Q?yQF6dGGKodP9NFXV3cg0VgATcPiTqR6M52CZepulw8b30snkdlxwwnOHP2QQ?=
 =?us-ascii?Q?vZj+LC9ZHIqXoWxeff4O4RH7zw5RWoJDjE6lbe9ZfvvyFnmXysA5ufoq1wbY?=
 =?us-ascii?Q?UUU6dFMJzTpntFMF9GfuqBMkF2Plf5ViUrbDTMa6KJq6oz9gdmYAHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bf6U3HxTc+pu+hj7AjYPCfcEVvCQZgP5qprJ1dDGkBzF9LnA1qXxAgTNsKRd?=
 =?us-ascii?Q?rWwZZUL3iWO6DJrpfISjfxWXl20pG1UcYTL/s9jQOcejjlEqEqYVl0DIh3Lc?=
 =?us-ascii?Q?p0XNrUy6Pw45/+JrlE/9BJxXp7yB5UyB1VLHNYfjzKdffsaoT18vqKorwXoj?=
 =?us-ascii?Q?j19jr7S0O6aAhusTJwkT6x44bLIYlhyes0tHhOxFIIDh9ozFC+sU5LTqKKx9?=
 =?us-ascii?Q?eSiXenTflWJeu3SkH7v6Jrxu+uOQ5QKc5r7P2RS/4/iAubrNCx5KVX4gRNs8?=
 =?us-ascii?Q?y55FWlEmvWj3NKLkJ9Xff7m8e8qZn0oUvEz6MKhtOpB6thwrZzt624LRRfif?=
 =?us-ascii?Q?uW4tkn/PGQ2pVSH1dUGDZiBnn0zF1BQ7TNuwMZdZNsTF9AVLnSFcWA4sMb2y?=
 =?us-ascii?Q?YcrBf0WgPGUx0GfVK6N3RO2eo+qbQopV9Eod6EeGzPN91JRfjz5Ccj+HHWv4?=
 =?us-ascii?Q?gfB+XBn3r12U6Ra0CBNRDGgQ8N9WwX3cRDIpxlHBdY6pJRU6a6CPvGgGa07g?=
 =?us-ascii?Q?gHRBF/c5l9qjLLslZ9V2M5VZSa2UEXtfvJs/mrQqQEq+vjv4rkot5ENfIEGv?=
 =?us-ascii?Q?uonmcZGjHrP1UGzt93sVHSKDyfJ5D1RQOkFfUhTy5ZL8FbAvnjqepzSUeAkd?=
 =?us-ascii?Q?Q8a+C/amXikZUMCu70N0fMXAi79ZzVMCQr1Hk8siMKIZty3cAyBsNI3m2fv0?=
 =?us-ascii?Q?Ikn1xIa/SOdr6ZFudazA7AzWzqej2YN3kZG6pi71vUojO8ymy11lbA08rllw?=
 =?us-ascii?Q?ZKJwa1x4lcueBJOp7IuAaWFcSzJm7+UpSr0ghOy3fGxwoQs4UNXmu0g8yJvE?=
 =?us-ascii?Q?5v4biPs/9i1U9Z/33hi5/C81o3Slt74oBsUzKEx3FF2HvMebL1hhPHEVu0Qi?=
 =?us-ascii?Q?6MekYlQNL/qrHGsCPHH1reyZK1KYCjnky/v4+6btgF/kAnzGeWMkw2NWF3QR?=
 =?us-ascii?Q?pADxiJxKR4fA5BoA8vKxW8AkkAFn0uiO7IFFZ2gECxPDdLuHIIKvgcu8Xeit?=
 =?us-ascii?Q?vp6q4qsBOS96sPgiET0x6vUi67TeTHWyg/0Xx7ruxOP8BmXG3L1UzmPp/fQm?=
 =?us-ascii?Q?7N7n8NeA/+4/OemN8oFVf3kTT/Qt0hSiIqEn35ZDbZZ2qrahuuk2uguoQ9si?=
 =?us-ascii?Q?A9ozsj6dn0eI+ApxtGl/sot4E9WbxoRujHAKMcfBAV423/YYIgXuzAyyX6fI?=
 =?us-ascii?Q?MWb3lz55bsvGxdyOgUiGbSrJ/f517GfOCmrWBmpzfOQWGisMoUjhXqXehMkX?=
 =?us-ascii?Q?kIuIjfCqACBG2V1kb3GXgXEMMJdOPvsmPFeykmcAt5rnkLCIPq/InffBnrW2?=
 =?us-ascii?Q?2eptAJkDlMqvdfdx1+qmAw4AHxGNvwjQMlDWLc+Afl6JXcis3IyMEbuRciq/?=
 =?us-ascii?Q?vU30l4Jc1OL2FxlO1qcROVffpiEmZFUZaYl2tjht5f/M2I0BxE4V9GrKFT8t?=
 =?us-ascii?Q?OE1YtkNhUjIp8obh3hcUlCkOaAgl1PBcLcvEFr+RQAUZkQYfAVpCerwGqdul?=
 =?us-ascii?Q?Zh0SJ1/2i95K4L5QnPBZSfwn4c3lcWBMCzV6sbOFXTmtCPN4fAxcCDFe4LSc?=
 =?us-ascii?Q?C3panJfqgdl1VcE/8rjgsRXVvHkc1GYnZ/3z2oUHgs8Ncj4ltNjBup9VoDf/?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8820bffa-2d15-4901-ce46-08dd98aaaf9d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 21:01:41.6759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ts4/VRMIh8S265H1qaRvJmfJdXNkv3c2EdYlZ/PCiZggsyoSbR6rL9z2jqAq6Wf9KqgWrdiwPNbmEVq9beJ7bsC2ST2hR1fvxSCbaRwMnvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7126
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for creating a region using the endpoint decoder related to
> a DPA range specifying no DAX device should be created.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 20db9aa382ec..960293a04ed3 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -110,10 +110,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto sfc_put_decoder;
>  	}
>  
> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled, 1, true);
> +	if (IS_ERR(cxl->efx_region)) {
> +		pci_err(pci_dev, "CXL accel create region failed");
> +		rc = PTR_ERR(cxl->efx_region);
> +		goto err_region;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
>  
> +err_region:
> +	cxl_dpa_free(cxl->cxled);
>  sfc_put_decoder:
>  	cxl_put_root_decoder(cxl->cxlrd);
>  	return rc;
> @@ -122,6 +131,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
>  	if (probe_data->cxl) {
> +		cxl_accel_region_detach(probe_data->cxl->cxled);

Here is more late magic hoping that cxl_accel_region_detach() can
actually find something useful to do at this point. I notice that this
series has dropped the cxl_acquire_endpoint() proposal which at least
guaranteed a consistent state of the world throughout this whole
process.

Did I miss the discussion where that approach was abandoned?

The idea would be that at setup time you do:

add_memdev()
acquire_endpoint()
register_hdm_error_handlers()
get_hpa()
get_dpa()
create_region()
release_endpoint()

...where that new register_hdm_error_handlers() is what coordinates
cleaning up everything the type-2 driver cares about upon the memdev
being detached from the CXL topology.

Then your efx_cxl_exit() is automatically handled by:

del_memdev()

...which includes detaching the memdev from the cxl topology.

>  		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_put_root_decoder(probe_data->cxl->cxlrd);

Otherwise, these long held references are not buying you anything but
the ability to determine "whoops, should have let go of these
resources a long time ago, everything I needed for cleanup is now in a
defunct state".

