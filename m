Return-Path: <netdev+bounces-294770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hKQBFxs7IGrJywAAu9opvQ
	(envelope-from <netdev+bounces-294770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:32:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C14638A04
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:32:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=IcfW1KCQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294770-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294770-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 032B030A3B73
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF3C3AB5B8;
	Wed,  3 Jun 2026 14:23:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02A4397E6A;
	Wed,  3 Jun 2026 14:23:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496603; cv=fail; b=tlN7CXnHSDlPrq81GSqlcQXEqKwmprRqxgYkbQKLdWDWnJB3KR4MDLcgxowyNNcv8Dry6VZ8GIGDpkBTq3OLZNqZy38TbpqiXYAP8E/9sL9yUDTyrYY5Vrm1a+xWK82aK72gmtuN59Z8xymTnJv/HOeFk13LCNJJoBSO34KdEsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496603; c=relaxed/simple;
	bh=KPZBndQ50b3UJbrzpbFX0VCHAouavGYOhuqH2vgE344=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fXToFRPnyGKAaV5/ZERUfewLoGSHmnOfJ13a8Md3gW8IIyptS2TfuLkUtLWptPfOvqe95apfmLN7AWTpeMAMySVna2WgT5eIKv9pjxFlRPgtNCup8RXdHjw+4lWSyomC2/Emocmer34y/8n1iP5uKQ0KAh3pQXpUU6244tZB8Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcfW1KCQ; arc=fail smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780496602; x=1812032602;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KPZBndQ50b3UJbrzpbFX0VCHAouavGYOhuqH2vgE344=;
  b=IcfW1KCQGaq2kfRisujJrxKLFzMralzpXXC9LEUXb0sGcEHNQpis6Tbl
   C8h7DGmQJvgBS4yvAoRXSBViN0KYvz3J2YlOG5ZIXpz+tF2pITU/Z2CPQ
   57wQ8e+MoNy7ADqnZ/c1InBobTygiulFR9Mml8zkxjVo+Sy7YEJKCmM3s
   6W7LAwx5p0Kko1tBleMlqoaQFk6UGyTFnVSR9jdNPSxCmvqJzoAVyU6nv
   5U6MCHU4ED9zHzVbsRgVXvoBtRJDyLC5bHalHSAwg+s7bASb9bN1RiX2D
   sXtKg3BWPxuWZM8Zt08cgtQIvPV/+THcfehfJ1zTqijU6q+9qgn84u+ix
   A==;
X-CSE-ConnectionGUID: gYmNcYuWTVSrICJ0t5QP5w==
X-CSE-MsgGUID: 0XZp9D8JRH+riTTk6duSZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91989684"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="91989684"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:23:21 -0700
X-CSE-ConnectionGUID: aSOQ9gPpSF281LTtzogqZA==
X-CSE-MsgGUID: K021e1xMRLGaCMbahQ5hHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="240074155"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:23:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:23:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 07:23:20 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APi8AFo0FkaL8Tn0QaNa3GqtXuGW0fEHVBFPDR9a0+m7TwigBxna50saXkwX+kViJpBQw9gewhgxMMERKFEmrWKP7qTEOOYABzIhzbZCbaaZCA32a64bYqRRfvcTHsf+/WrDeNEEA5nuJ9fqfs3YhCzyR3XZ9n0u3cEtg9+13IhijB3oDYuvQ5dvPKpOUQTB+Lv8lYJ2eWOPPgaR50irzINQuPdOYzU4cDI9advcucgxG/nAxpzoJXV5oYsKLTk/vZw/bCqgDidc70Ylqs8wll0F0ucHbuJkZrypSB+gWNVOqe0U8NrlcS4H5OcgJmMc3ORcs103Av/Xt4MnXLxF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpyvHoNNQzbhndnGzenraf8iEcpc0s6WfkZd298sYrA=;
 b=eSWiSKlWR2VezwEQqmuNFv3jiF3DjL6UDnm2Of1pftN1Iv21NFKGLwE/YRs5f/MpYo7msRvVJ/LyhJE3JsPzG3dqov/x5cVnMpTh7umOu6ZU1F9NACOGhiKQQtLOPSO/AmNyFg6/3EMgUO5/KiSwyN0f9SlbuydPYH2pnukCllqkSqiSC46Dq40scZ9pYrImj95FibAsTP5iTaTpEkh+mZCDiZp2Y5xc05IKvdZ5ELSOGm7VWnkWDAb91EB52Z4CBPiv7gAg5wow+f07RCzWgqLQf1AZ+CoSyTI+IFs/lTzKr0NLrfEMvbydXD70CcdHlvThT3hWCgYe/ACw7n8bKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH3PPFA3FE8A23F.namprd11.prod.outlook.com (2603:10b6:518:1::d3f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:23:15 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:23:15 +0000
Date: Wed, 3 Jun 2026 16:23:04 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Raczynski <j.raczynski@samsung.com>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
	<linux-kernel@vger.kernel.org>, <k.domagalski@samsung.com>,
	<k.tegowski@samsung.com>, <cs0617.lee@samsung.com>
Subject: Re: [PATCH net-next v2 2/3] net/stmmac/dwxgmac: Extend MTL/DMA
 support to 16 queues
Message-ID: <aiA4yIUI2mBxXHri@soc-5CG4396X81.clients.intel.com>
References: <20260601162537.553512-1-j.raczynski@samsung.com>
 <CGME20260601162618eucas1p14be36902c4948647448160da08aaebc5@eucas1p1.samsung.com>
 <20260601162537.553512-3-j.raczynski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601162537.553512-3-j.raczynski@samsung.com>
X-ClientProxiedBy: WA2PEPF000008AA.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::659) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH3PPFA3FE8A23F:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ab822a-239f-4724-da60-08dec17ba663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xDgU8/VgY/MdI/wgV9c4dfxGUQvcRZ6mYngsZ+0xpyhv8/5oHbB3nMJAlj7l+s93wVLiTTFj40u80kySrMZDDqpqjrigH4pPrcloaa484EJ7GAPTV7Tg8yyGTbzWwRWFMK7bXwKUmfz8L9u8NNMhDAU6ge3ZgIyJC07rO8M+K7VvUN8fKyb/R3aY/Ce//vhXFHQR7Xt5kdLPXlfWUdUwGyOCjeMIuZtCIf1C6oL+ty0YprlYoNXltXUyS2wsxG5y3k296Vm9VkbzzZdIL04gbagH1cvc5d3eZDqrUe6lBrzsMWx/1u3t3dJvy3uyayJ5ebrDwAeTFfR/RJ3ufDv/F11n/AP/K34ZqQLB31PrIXfQMIU1VsmqoOwJD2H0OlTtdsm2mdX25/OoMAPvX+W24gZMnoKa14IIriSWkYeAlcCE98dBqDtmmaxx8wIA33IHLVFs4b4ILXiLjsMorKB+gI9z/iLCkcsymkOypJAP4royuovgqgv1JmueGnbVNZf6mpiBo8Xby9qf69RKBtst2atR9VxDjm+AzeLxJHhmsgt1kWM740Z3GFfiVVRzGhIUgOdkhnO2O1ESk1/pEp8YeoLVas4G/BRVqvOxaWQ8+Z3oAJQB1UqCM5A3TWA8NbrzQrjs4ISl2vtcvpQmA4AcPEsDO9l+3mJHYQefVtB9GvUlVo0jy+0fwuSoPzYZlYI2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RFdp+4i12QtAlsHX0tOkvH7+q/YAcZC/2waqde8sRHvVp8p1gQsuJRLIXQf4?=
 =?us-ascii?Q?FEM1SDl/0ALzxGzkVeIy9Xd0P/GY0MJ/Rjgefpzgm0QEm8BlO1NI/7LtI++A?=
 =?us-ascii?Q?cx0rxbEimSP1q1qeEPW4Tue1n6Qwk8yToPV6ONXBmT9WLmFP+23Jd8x94Y4w?=
 =?us-ascii?Q?bIwyjGrVZWMBM/cie6g6qQ6RDvN8IUrk7VTsa5fVcL0Ztv/o81EHCCaivn6h?=
 =?us-ascii?Q?LKAaX3JKZhqT04xAV243p2QZntyPfdlcKBwxH8u6WHIakf/XPppEs6cN07H4?=
 =?us-ascii?Q?sF98Y2Kd3F9gESon9+vDyd5LWoip2lp8qVmufsWW0sQpBiGCMsjMUoxf5XG/?=
 =?us-ascii?Q?T/xmvXLhWC35dd33Ovvv4xkXIFVYm3eyjelTrAuXX1dTNN7EPd+3dXbx7en7?=
 =?us-ascii?Q?Ueof+HizaSEZ0J7SujOoxW3lqVVQn7aMRyfEmtM9TQY809lTEP8+gkxISkC1?=
 =?us-ascii?Q?TirJCxYIH+TLpjwhcX1csCoRSl83k/bkHXYx1s9mmK278Ky7jfahfGRY49NL?=
 =?us-ascii?Q?kz424q6wNoL2QKuOQH1d0QkjvGGlUSMKOpdFa1b0xhMoMlH+59Vvf71s0US9?=
 =?us-ascii?Q?/M5ZsNfOSFHWzCziVLEoxGLE3kyYDgAkMT4lAdbhAyRFpT74GNQJIohF0oRq?=
 =?us-ascii?Q?Unk0mRv8JO5zoDGBL1ad8UyNK7Gs8jxDR1QWFxLhDs9mkbveQLWxfo9lFNGb?=
 =?us-ascii?Q?0TuFPgOMHCSInCUJf9lTlg4B9XSEkN027loVAA1qAet1nx2QGv6beJvgNk/g?=
 =?us-ascii?Q?F2zBmLOb0IeiE5pjUaNSoGAzPMG3Ag8IOXHExnvKaU8EjcjYOtfcR/1NmnQu?=
 =?us-ascii?Q?pMenjbddiqX9FHbQL646SQn0iNl+ob5dqUWDyYv0mu12XzEnkDMG+6ZYvP/C?=
 =?us-ascii?Q?ZS6ej9ePjqDDfsyxd7t2gyRdigjqnKv88ldMVJheyqzQ1LSWXG+etYweQLuG?=
 =?us-ascii?Q?Dy4+gN8rbRYa6oXCr4JXToOa7R+fuMZkqCir4or9zOrvGQPYUoVgsTcbFpQE?=
 =?us-ascii?Q?qlvGVS1Wu971OmdmKCJAhXbhib6q11ogDTIoQazAO6IhZokJIoAOS7JcLO+C?=
 =?us-ascii?Q?yWtfnyqkg3cD6KSJzjspdejnm926/OIlB8WXit/lWo7aiH9qmaUz0loCFJDa?=
 =?us-ascii?Q?0B8QYm15FPY/J3Z5aVsYwMUejoSBBdXj4XeU6fhZNq+M4EPpe/WjNTrZxJi7?=
 =?us-ascii?Q?WgHkJZ9DVwhHPfTRhtZkafx34hAzuN22t5/x1JdCZxJAfIh7eXtmAVwHyby9?=
 =?us-ascii?Q?Urg9nCXvMrDi9cxRPPXubDPKVNFn/Yy+yphpKQHEdocuSx7RG8iUI/WwTUjq?=
 =?us-ascii?Q?UrVO48M6akxXIAIIU423xemQnV1V9wTNI4VSkjbgJt4CX06hYs0HaBlAueCZ?=
 =?us-ascii?Q?SHQu3l4oBUIDvwPCo3H6A36e8rF8W5BUFcpYV9X+ZH7Jy/rIyMXXpkf4G44N?=
 =?us-ascii?Q?vidP3mPzrvH7+lCFA932Ku95cRJn7FSOSXgUoMIElJ9gtS36Ifx4fx8L0xVi?=
 =?us-ascii?Q?1ilRSoZiFu6Su5LbY/D34VcR7drvLJFcCxwQR0xORgQMSA5WqedBCzjaAwCl?=
 =?us-ascii?Q?X84HCkP3v2F1kUqWcdwvI8GxIzAztxnqn+drKi9szWQgjIQ1QP1hMEAQm6TO?=
 =?us-ascii?Q?y22kSO8QxEIV/sJnkQACuvf/4KPwmBdSxXyu17c6HujKicAkk4b8+04xEMeb?=
 =?us-ascii?Q?B3o2KAeBoj62vnhA7iDcw+cNuFahbCCYNFDzM6yASPgeBZKhrApt0Js6gmno?=
 =?us-ascii?Q?yog0aTHY5iaQf+qJC2lS3wEO19mrUcJ/YC3QSe0lmIT84/jHzyEXiOwFdIIs?=
X-MS-Exchange-AntiSpam-MessageData-1: 6GwDNNW2OJrYdlKhmtkTP8+YZFi4QBo82x0=
X-Exchange-RoutingPolicyChecked: N0kd63DRnRh2Z7PeyPrhX5kmoNyw7u4ruGCIY3YCf5ekmmTxE3glvNDws34QEpuLpzsuTRr51vkswU8sKSEidNYlA1e4dX0nVvVwrj6ecmoCQXPRIJYPv9dMndJ17KnWSINe4PsCidGtZ0SipQmaG9Bb861mC9+bkmAfEyqkOzBJ73dCnLd5HhcEUUjk/YLAOrstJYekwXIqyPDS7RmqM/K7mwaHIUB3XGzmqk8UkvkZULNucm9eNHAQvKxDOzDlVG8ivp45/PCPrLJs41MBVkc40LBA4DyGkpuxnYov1f0gqn0xDQBNuW5DlqK8NUl7DK93KhOVp/hceZlS4Ilt0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ab822a-239f-4724-da60-08dec17ba663
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:23:15.2364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cmhK8C0KBm/GFg10jtxLvSvw5YK0wnOgR9jNmVE1Z7BabkaijN0SXX8XIhXcTSPJEVKyBdAeuQ1bwcfnzzXfeB6tLGO1B07+3tcrUnCFCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFA3FE8A23F
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-294770-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:j.raczynski@samsung.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-kernel@vger.kernel.org,m:k.domagalski@samsung.com,m:k.tegowski@samsung.com,m:cs0617.lee@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,samsung.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:from_mime,intel.com:email,soc-5CG4396X81.clients.intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56C14638A04

On Mon, Jun 01, 2026 at 06:25:36PM +0200, Jakub Raczynski wrote:
> New datasheets for XGMAC (3.20a and 3.40a, depending on product) support up to
> 16 MTL/DMA queues. Before we increase max amount through macro,
> prepare dwxgmac functions to handle that.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> 
> Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
> Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 23 +++++++++++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 51943705a2b0..bd333afe7e1b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -257,6 +257,8 @@
>  #define XGMAC_MTL_INT_STATUS		0x00001020
>  #define XGMAC_MTL_RXQ_DMA_MAP0		0x00001030
>  #define XGMAC_MTL_RXQ_DMA_MAP1		0x00001034
> +#define XGMAC_MTL_RXQ_DMA_MAP2		0x00001038
> +#define XGMAC_MTL_RXQ_DMA_MAP3		0x0000103c
>  #define XGMAC_QxMDMACH(x)		GENMASK((x) * 8 + 7, (x) * 8)
>  #define XGMAC_QxMDMACH_SHIFT(x)		((x) * 8)
>  #define XGMAC_QDDMACH			BIT(7)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index dbedf31bb2ab..4aba62680938 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -278,12 +278,31 @@ static void dwxgmac2_set_mtl_tx_queue_weight(struct stmmac_priv *priv,
>  static void dwxgmac2_map_mtl_to_dma(struct mac_device_info *hw, u32 queue,
>  				    u32 chan)
>  {
> +	struct net_device *ndev = hw->priv_data->dev;
>  	void __iomem *ioaddr = hw->pcsr;
>  	u32 value, reg;
>  
> -	reg = (queue < 4) ? XGMAC_MTL_RXQ_DMA_MAP0 : XGMAC_MTL_RXQ_DMA_MAP1;
> -	if (queue >= 4)
> +	switch (queue) {
> +	case 0 ... 3:
> +		reg = XGMAC_MTL_RXQ_DMA_MAP0;
> +		break;
> +	case 4 ... 7:
> +		reg = XGMAC_MTL_RXQ_DMA_MAP1;
>  		queue -= 4;
> +		break;
> +	case 8 ... 11:
> +		reg = XGMAC_MTL_RXQ_DMA_MAP2;
> +		queue -= 8;
> +		break;
> +	case 12 ... 15:
> +		reg = XGMAC_MTL_RXQ_DMA_MAP3;
> +		queue -= 12;
> +		break;
> +	default:
> +		netdev_err(ndev, "%s: Incorrect queue mapping %d\n",
> +			   __func__, queue);
> +		return;
> +	}
>  
>  	value = readl(ioaddr + reg);
>  	value &= ~XGMAC_QxMDMACH(queue);
> -- 
> 2.34.1
> 
> 

