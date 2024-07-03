Return-Path: <netdev+bounces-108955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB4E926587
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822AD283F8E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02411180A94;
	Wed,  3 Jul 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvMZkxvW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA117C7C;
	Wed,  3 Jul 2024 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022678; cv=fail; b=tFzxYeuYmOf45sFESdEYrg8u9QEk/NFJXCQOaJ1vgRbkA5Kltmus7ikduBx8q4zAqR7qqF7hXdu6jwkTqVnc0rqOVwFWnRtwocHzdEfDfizTx3VNgpoIM96lskbG+FgTPIy0uPxb0/ia+E7qHwVyPwytcuYAjzkrqyWG6DSMd4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022678; c=relaxed/simple;
	bh=YUFwPeAa8YBdGdS0wuh79lEAJ2tWmL9H0vDhqk2TTI4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nWLvpfsF7BiM8tK4bJ3THQ193A61ZcJ1wkiDiKFpDRCnkwBxv04PrTdnIyXtlE0BC2PhLEdmzooXwSfpkOjiZh3WeqTBHi3HpJgwR13I8tXznLfdjEHDF7Jpfv4zPg5EuPCByLmcsjs85acjFqhtUR/oQnsSZ644eAtFCEBHqIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvMZkxvW; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720022677; x=1751558677;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YUFwPeAa8YBdGdS0wuh79lEAJ2tWmL9H0vDhqk2TTI4=;
  b=LvMZkxvWKS9Jwu3k/c3WWCqlhMXrWvsdlAX1xFgmex+TFhnL8Siyvhn8
   1bMb5Qp8Zv6tjo/q0BNAhzCmDSLlFwvgN+WNa64SuYi5Pnipc2uslWgwk
   6p8mANIkY+Olmeiy6Asek7BlUZje2PIDRw4ZaYFwtV5fTIXWNWQyvcUzF
   dT5+zQEHhjyO5nAQFsaPvf2e+FOBLsXcP/vV/y0ytut6RN3fselWRhGlS
   rNz6EST1gtYcgXTXbwu71zEg2u1t1w4W+R5TUz1VJfGmhP8kt5X/NsXIL
   rnN745KK1nsEct0XJODiWu3wKHBsuoTqrDJoGgCbKcr/LrMrPM+BzdqVD
   Q==;
X-CSE-ConnectionGUID: 4HYo0xlNSzGZ2oOCILP0uw==
X-CSE-MsgGUID: 9BB3gR8+SYqwe5G/WNUNbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17473819"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17473819"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 09:04:36 -0700
X-CSE-ConnectionGUID: Y2p0K31CSsGu2BPJOaAtGw==
X-CSE-MsgGUID: 4OqnEnlcRm6oFQvqpvk/Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="77033883"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 09:04:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 09:04:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 09:04:35 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 09:04:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP56/xs/ozUhdUfMAW32GrCIiFY2egEfz0utQhKySkLhDsf/76LGlzfhS2P5KdDbqgxTZT+oO+ryaDBbi+81LFcR4Hv2xjCh9P77p0bQDVdyJubHmOiXHaVlbqU/Yj4GQURCAKMo6OKvpVovqyoccO6wPMf2+KWzRS5kP3yP4OWFVjqrrXR35yexoi0GyX3kqU2Utc7iOh+TZhsexi6OerFStLTPyAjnq57G4FdYAZV4VzcdghTtM9fZxQGj0y2E+pgOYcXmzdqGkdCkDZkW0jgqYpsr4VgL5wzdPbJ5nwVG8FGzYx443EmdM44SKGeSC3ZYdUl/OlnaCVuQr0ct3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxjvJi5+UC7ZKdLWfX/1mg8v1xjIXSgiDF+/HnKVWqY=;
 b=Mc8q3Fwgy45oQPIl7PEkqYu0IIQd8DGrbG7tm6hyNLI5kuBvXfzvQh5HtKBMqtqgigBH9Qm5qyYHX12Id3UL+VmDMuLG+ZzeoNsSS6QdCNXEEceW6CG7syCMtlEt/TsPpMRE4joP0MRmwwrrTqbPLSQod58A3Y0+VRsTPfjzli68D8cbg2Rjv4CaRoe/LK5GITHdnWVVYO5gA8CZE0y/Yj8V9FMXmqnH5F47nCtva17/hjPfbYBbanRJKYLN0t13stvH6+2NCdwD43n83kNkt8WWbuPm/CeVkA6P99NN2ZBhgyi8KOlpEbUvEu4aux6In+zPIUq84zWx8Sa4jZpkjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Wed, 3 Jul
 2024 16:04:32 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Wed, 3 Jul 2024
 16:04:32 +0000
Date: Wed, 3 Jul 2024 18:04:20 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Christian Eggers <ceggers@arri.de>
CC: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Juergen Beisert
	<jbe@pengutronix.de>, Stefan Roese <sr@denx.de>, Juergen Borleis
	<kernel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] dsa: lan9303: Fix mapping between DSA port
 number and PHY address
Message-ID: <ZoV2hNiGvHnDfIcU@localhost.localdomain>
References: <20240703145718.19951-1-ceggers@arri.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240703145718.19951-1-ceggers@arri.de>
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|PH0PR11MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e1a9f9-9b90-429b-261e-08dc9b79d3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JR739rokZADa2F0WkcAN1A5T4UwLP2kcXKS8R551883wcuT03zBJ5s5KkcL5?=
 =?us-ascii?Q?BEkS9pVglfQdB9B4UOD6Ctx2HjQKLeB4pT3zRBw/yVb6pvm/Q7DeiYTFp6IB?=
 =?us-ascii?Q?E1X99GZfjJ/Gln1k/t+k+QeXXNQF0pDir4tDhId6Czxdp3ke4WY67wFrvNhZ?=
 =?us-ascii?Q?az1yLpaTUT/NyOnhmLprDN7Z7+xDlcoZuMTHqgh7TDYCLTJadCTzkLSpeRqo?=
 =?us-ascii?Q?Bp/VUljwAfGt7tIro97pFOhdmYypoG0zCbZ3djmXqfl4yH3FzkXeGdWlIbC8?=
 =?us-ascii?Q?22rEfMnF43SpkatYV2uUfdYCIpNmBtDXPzT/jOWNoRYVQKVrFfqnsf6GPBCd?=
 =?us-ascii?Q?08SHRnIEYtts4z1nge4tD9HfbUFsngOgrll5D2jVpXPRNcDc+FMdFfm6BPCc?=
 =?us-ascii?Q?KAHGi4Bw6CpNKvPqeAV8OeaiFcVpJXta+0Zw5ZvRHn38pQmLKr0HNobSOcFi?=
 =?us-ascii?Q?0pjzJU187ED3cf9MZy/ZP4DRkE1/Xa48duZGCU8Ix7YLrqJCgToHqiFg/G2H?=
 =?us-ascii?Q?Yjup7Yg/mRTVB4JaTFRDwT3IGOBgiOMljU9bGbtLuJ3FHBHgwdHUdsyXIuGy?=
 =?us-ascii?Q?wkzichmrs18UZZ4xDRjcTedbT81VYPMujVGs3qKezzrvNd4NaeFTQH+uIBhH?=
 =?us-ascii?Q?e9TNORSg9mndCwx08aNTNVgFsireg/LgfBamBN2XPNmNPH+5yNw+GPgFL6wi?=
 =?us-ascii?Q?kJLxAS491hTvv/nBDZmOcSe6byrxVZ8CN4mycy3ulrLsNHXKirIkfWf/sqOF?=
 =?us-ascii?Q?3bGJ1MBqKy8W7ZJp2+OEEAZh7gxSBt3n1gYSb1OiXgCLvwcjU+yKKkuqrG8u?=
 =?us-ascii?Q?j0cE/YoHucprSysAiS7CPf4kpE0aCv7dG6pWyTNkiJEh2R/lmQFX31M3cm0B?=
 =?us-ascii?Q?ZvSZ//sl3L9Sn2tXyKnfuVgD+5V1ZfnyrzFSQgRFVZs32bVaugG3bElJLVnE?=
 =?us-ascii?Q?xI+/t2zrjTLqvDIS2JDtXQEwJ3oqlsbBW/1M35B/yv1Nqcox42xVDTIyoB5G?=
 =?us-ascii?Q?ewp2KT/avcr5XDc4R03FYjoNuvcCAhbFZhWSgf0VRfMQE1PI9gKV1JCfxcQ9?=
 =?us-ascii?Q?OCkreqrcnd5/U6Pvn9ARosnvMF+ybR/NPnTENJhM7RNyFkNN1viAAe8pd53n?=
 =?us-ascii?Q?bra5miF43ThlkekRGJGGAL/XMijcY9s8YovdUttiO2wUvI5t0JBbugj7T/um?=
 =?us-ascii?Q?kJ28s0HPGB/dsmpI2XO4A+vZlfiNnAVlZ9sXp070pgwXQB6T2xIAQfM/YxT2?=
 =?us-ascii?Q?riAIf4CtRnI0T0mDf9KxmDeajs7Xr4vgPMTxe6aX93dFWT3jw2EdwPy3rLFF?=
 =?us-ascii?Q?hN8YdZUXDXfFumAYqdxZtV9PqoprY7LeAsPX8iA6/F9KDQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p3/gblXGTDNIrin2awyylKLF/be2dOb+hS3/lQ8G689XDwYCdXaEmztLMo+B?=
 =?us-ascii?Q?KmQslaLOhE9epK+0f0UoHzGuTFYprmPKJuN9wOvFZ8wbUWEcyTHTuqndtDqL?=
 =?us-ascii?Q?f1j/u1MnHhpVtViJ40vNzkmunJQNUrZ99g3e7yocAeOH/jnnDNEc5U0v99th?=
 =?us-ascii?Q?CtrnzMKGHVq+NQ5vvLcm+lnyT3HZbUFv2ZJ56OlT7IR/nWLezcDAbGuLJtnE?=
 =?us-ascii?Q?pSrK6KklIU95kDAU3HIzRwgqkB6X+kIgRWLT+Eiii/C+lWe7EHsKanXfzw2e?=
 =?us-ascii?Q?H83GFbXchMagRrR41uiuP0/UFomS5YeDJuidzE6DLfHJrtCLNXJMVdkNY4Ep?=
 =?us-ascii?Q?qF+SF1nJrqkA27zSuN4GSyPs8D/UndGedm/rf0gtV7kBQ1BjOJ+5SndcU8Fu?=
 =?us-ascii?Q?k28KJgwYv9dcJ42Evacjvz+01a9NR0ds9zvqRfEvWlbGwWb1N8wCo2DdpBkh?=
 =?us-ascii?Q?OXyf4AH4xRAYfvcG3UvtWX8EbcHkHhfWyMxvIMV2iBmM0MjxuNi3cE8Hz61R?=
 =?us-ascii?Q?TCntMFh87XmIccTmtIMe+Ryc3feCFdBIUe+je9P+XcVmQEr3zjA4uRvKG6te?=
 =?us-ascii?Q?Vt6WX8KCQoc33oeXhVC+kzCm+OzHsLIIDVB15OiDx4oV/cyjJgxmOtrHAXVt?=
 =?us-ascii?Q?WG/FVLBXli29ffd6j8rusNauWeO0yIt7MjiSPU5F5D7G8unrYjjc/0/FI0u0?=
 =?us-ascii?Q?abqslYAhsBW68ymz+5X207CHrvMuSykftsOB6VIrYL9TXBvLK++upBmd0+40?=
 =?us-ascii?Q?/T3uPqraL5RfVvroKp/0O+tccz0nlCtF6T8Ec3MjtVpilWuMNf+4gQzQXYW9?=
 =?us-ascii?Q?6YKF/2IOJjX5FTl/PUIIqez1aVloqt86nQFoa0hM/0XXYTLILWcm/BD/PAtn?=
 =?us-ascii?Q?Te1Za8YdionrDJpF0itpNh3y1xga80tbOe9W7GpvaGyb6dFRyk+IYcdocGBp?=
 =?us-ascii?Q?IlytziZscDM9sK+DvnryHrwQg6LaZgOBBTFHSbLizaBKD96B1pKRfNU0e958?=
 =?us-ascii?Q?F+bgWWUkY1UVGYoYj6V3C+zndD5UNIdun7ysd7GmmsSFeu9iS0wDHqrf/LeE?=
 =?us-ascii?Q?LtgaLhGFLxUhejXZHKj120B8d5LaZaKfD+nlWtXIV+3J5/pyMJNM3Dzp1kV/?=
 =?us-ascii?Q?4hf2kcRzr73NpAzQebRCiGfSD+KT0j35ilEgYtXslDcTh2imo2K5J0A4Fupu?=
 =?us-ascii?Q?lI4fl0TXmcW2PMT0lbjuYHbvxZym9V6qVFq/yFdTujs6RrMs0RviwvbkQrqL?=
 =?us-ascii?Q?Xx6SmSehtR9rjkvzkIjVmSIxWNZOZrlnBZHkQqeC3MMTZFj9TbPpRJhG8VMX?=
 =?us-ascii?Q?RYbpm+cPT+jkfWD/0QVBZ4S1mcgF01VkKA6Go7EjW3DP7sShYKix5DbM7yeM?=
 =?us-ascii?Q?cQDRe6yM24zIcIBjsuBVX0zGSVM/LytsDYyeHA8uX7+TUTA6no4i3rQr1YOU?=
 =?us-ascii?Q?9EAk652H3Rsr4T6v6YoJGuFps+yn9qEQvih4TsTNK5f/hUdJYNooauu6uJMC?=
 =?us-ascii?Q?xL0AI1MeccZzpNfW5dFLgCOwtMYgu4AxQMvqsAU/kKSZFvSRlaJRf6G9mglx?=
 =?us-ascii?Q?PQ0TMZ8B3a/pPeq42TPHPvJylYeLGUmBw6hIAYFI4UN+taW4HI9A/SRhTsHL?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e1a9f9-9b90-429b-261e-08dc9b79d3b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 16:04:32.6246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlAcdSlIN1KZqQ+cIy37hsN2NWONs5Z8ff6pmxTAImZUNL9Gsv2Rdlm1qtZupJuav79H0VHs4z4jAvLrvsx/1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472
X-OriginatorOrg: intel.com

On Wed, Jul 03, 2024 at 04:57:17PM +0200, Christian Eggers wrote:
> The 'phy' parameter supplied to lan9303_phy_read/_write was sometimes a
> DSA port number and sometimes a PHY address. This isn't a problem as
> long as they are equal.  But if the external phy_addr_sel_strap pin is
> wired to 'high', the PHY addresses change from 0-1-2 to 1-2-3 (CPU,
> slave0, slave1).  In this case, lan9303_phy_read/_write must translate
> between DSA port numbers and the corresponding PHY address.
> 
> Fixes: a1292595e006 ("net: dsa: add new DSA switch driver for the SMSC-LAN9303")
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
>  drivers/net/dsa/lan9303-core.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
> index 02f07b870f10..268949939636 100644
> --- a/drivers/net/dsa/lan9303-core.c
> +++ b/drivers/net/dsa/lan9303-core.c
> @@ -1047,31 +1047,31 @@ static int lan9303_get_sset_count(struct dsa_switch *ds, int port, int sset)
>  	return ARRAY_SIZE(lan9303_mib);
>  }
>  
> -static int lan9303_phy_read(struct dsa_switch *ds, int phy, int regnum)
> +static int lan9303_phy_read(struct dsa_switch *ds, int port, int regnum)
>  {
>  	struct lan9303 *chip = ds->priv;
>  	int phy_base = chip->phy_addr_base;
>  
> -	if (phy == phy_base)
> +	if (port == 0)
>  		return lan9303_virt_phy_reg_read(chip, regnum);
> -	if (phy > phy_base + 2)
> +	if (port > 2)
>  		return -ENODEV;
>  
> -	return chip->ops->phy_read(chip, phy, regnum);
> +	return chip->ops->phy_read(chip, phy_base + port, regnum);
>  }
>  
> -static int lan9303_phy_write(struct dsa_switch *ds, int phy, int regnum,
> +static int lan9303_phy_write(struct dsa_switch *ds, int port, int regnum,
>  			     u16 val)
>  {
>  	struct lan9303 *chip = ds->priv;
>  	int phy_base = chip->phy_addr_base;
>  
> -	if (phy == phy_base)
> +	if (port == 0)
>  		return lan9303_virt_phy_reg_write(chip, regnum, val);
> -	if (phy > phy_base + 2)
> +	if (port > 2)
>  		return -ENODEV;
>  
> -	return chip->ops->phy_write(chip, phy, regnum, val);
> +	return chip->ops->phy_write(chip, phy_base + port, regnum, val);
>  }
>  
>  static int lan9303_port_enable(struct dsa_switch *ds, int port,
> @@ -1099,7 +1099,7 @@ static void lan9303_port_disable(struct dsa_switch *ds, int port)
>  	vlan_vid_del(dsa_port_to_conduit(dp), htons(ETH_P_8021Q), port);
>  
>  	lan9303_disable_processing_port(chip, port);
> -	lan9303_phy_write(ds, chip->phy_addr_base + port, MII_BMCR, BMCR_PDOWN);
> +	lan9303_phy_write(ds, port, MII_BMCR, BMCR_PDOWN);
>  }
>  
>  static int lan9303_port_bridge_join(struct dsa_switch *ds, int port,
> @@ -1374,8 +1374,6 @@ static const struct dsa_switch_ops lan9303_switch_ops = {
>  
>  static int lan9303_register_switch(struct lan9303 *chip)
>  {
> -	int base;
> -
>  	chip->ds = devm_kzalloc(chip->dev, sizeof(*chip->ds), GFP_KERNEL);
>  	if (!chip->ds)
>  		return -ENOMEM;
> @@ -1385,8 +1383,7 @@ static int lan9303_register_switch(struct lan9303 *chip)
>  	chip->ds->priv = chip;
>  	chip->ds->ops = &lan9303_switch_ops;
>  	chip->ds->phylink_mac_ops = &lan9303_phylink_mac_ops;
> -	base = chip->phy_addr_base;
> -	chip->ds->phys_mii_mask = GENMASK(LAN9303_NUM_PORTS - 1 + base, base);
> +	chip->ds->phys_mii_mask = GENMASK(LAN9303_NUM_PORTS - 1, 0);
>  
>  	return dsa_register_switch(chip->ds);
>  }
> -- 
> 2.43.0
> 
> 

The patch looks OK.

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

