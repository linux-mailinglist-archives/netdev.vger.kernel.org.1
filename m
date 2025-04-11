Return-Path: <netdev+bounces-181653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C12A85FC6
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36EBD3B5FDB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9D11DE3AD;
	Fri, 11 Apr 2025 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uwj4vEVt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2E2367A9
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379588; cv=fail; b=rlgLG7hHEbG9CRlQCI1/stFsUJ3vbgJShqLR9OK7MRtE51dfhMNnhIlCP0CoWzv3yGHnRqcFvg6/RkQak9t/fQg9WvqAmOrrN0Ub64BUEVbozPPlZWqwTmbF2PBbBX1Cjp2heW3AiiyiLvlKsd7gLa2NXV6RUCi+Bhm7NRsomG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379588; c=relaxed/simple;
	bh=H6poACJD1gMoMWmfrjoftalQu1wgkjdgMQqaNBQYXck=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NHP8r8mtm5zy0Yzbmi0M2X7bGcNMJtjKqvUHr1+i+dqFI0O1gIEXhpIP+KyhbyW4CYzvmfB1IOuYPbUrKewrc7LUVjsXa0Zj+lgFQRzLnEfO6QWu0paLWQlXOwKz2GJLubndILUuuEhP897GfcBcPs0CGJQUgzfepzz0BiJOWzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uwj4vEVt; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744379586; x=1775915586;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H6poACJD1gMoMWmfrjoftalQu1wgkjdgMQqaNBQYXck=;
  b=Uwj4vEVtrZSOaz0x2SzpPIfKHPEFFSUBsFOqyACuVmXn5lm3+mX+muZo
   3xnWnRxnX2VT/VasNV1AELFw151SLaLYXyARorSg9/0GqiXSekcDAAmit
   4X+1IvytZTpSCd/3qcQamsCN6AdnHYU47GlvNIyUoYFlEvBLbnzSILJK/
   Umjh7ov+l9Q+mgXlonYzQQqWSCYM7hsGh4rFESO+MehF6HX4Sb4dUheuE
   YxF4/LHzym1eViQS5BELm9b4PaQ4j95s8EDyzJ2QJ74bzTSzRgtrA6eSt
   1G6/ArPDAJoiCjPunXIKZoXWbtxEn6/YL8jGwdtCPcQSjgH/E9Tp7Psxn
   g==;
X-CSE-ConnectionGUID: VyjVAYqbQMiH4v5tYvaqYw==
X-CSE-MsgGUID: x7g6+HRbRaqg66zsDpBU5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45069791"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="45069791"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 06:53:05 -0700
X-CSE-ConnectionGUID: 2RlZrkjxSPKKSS6paCkvAA==
X-CSE-MsgGUID: NiI+C8fUSeCE4TD7kwLdMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="130180950"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 06:53:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 06:53:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 06:53:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 06:53:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGOEhqFZMhlbDMogSo784B968FS3BKT9kyliauZZRn7Zbm+8cJd+eO8RoecU+OOKyTF2oM6PWODX2pdUsjEEG45bgeR7tOMaVQIvXFVFnJKDNOQIo8YQvDqSba7Ui1N6ah/eFWRFlIPCskxHiia2r9z7K/Z5u+S85B6WYP7ginrmYrNcXV+X0rjhubUq4FnCIpOAlv+495lh/0EMupfw5S4Veyj8BxfkSSAaI9+NKy7XGJqnWufVA1jClqqTYliNjKe/s8j76QjC5dvIEITdfhe2f23AYtAFZfQKg1v7kcEH88zJjB3ovXLiXX9GxTdz9CUizBZZn8E9jHJx3swoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUsPEp57OBSQmS7966JTeke/Yq/ZK1Kb0LSH0CEEh+s=;
 b=DqpLuHvlGsMfQS8C0s7zQGoRNIZ2GANby6ypoztxBSmAnax9MUkpZ19QXhsxFF/r03rtUR0WdEHfP93lQXhnCXqVSSq89MyP2aVbJMsfp9/JPfDTl02RVLv9qDsZIBygv4PJuDpaVyldcspKoRPpm71pi70MToR6ronJ7W9T6aAEBXPzy/N/C0e973eN4LPLVD/NGlDfAsnklvDBYVHGHe1RoTvf2gznBBDzPwfw4ge8MY9WaQ6sR3DF8juKk6WABJEfDBoVy0/sXBnu1iIZr5qq4jFz20tUq44G3rRvM7l9Qwvm2YPpOGnQJKkxJ0ya+RMOaHjZn/G1oPFL3OAOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.31; Fri, 11 Apr 2025 13:52:18 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 13:52:18 +0000
Date: Fri, 11 Apr 2025 15:52:11 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <dlemoal@kernel.org>, <jdamato@fastly.com>,
	<saikrishnag@marvell.com>, <vadim.fedorenko@linux.dev>,
	<przemyslaw.kitszel@intel.com>, <ecree.xilinx@gmail.com>,
	<rmk+kernel@armlinux.org.uk>, <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next 2/2] net: wangxun: restrict feature flags for
 tunnel packets
Message-ID: <Z/keixoyLzcgEGZu@localhost.localdomain>
References: <20250410074456.321847-1-jiawenwu@trustnetic.com>
 <20250410074456.321847-3-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250410074456.321847-3-jiawenwu@trustnetic.com>
X-ClientProxiedBy: DU6P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::15) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|DS0PR11MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ddbd82d-178c-48f6-7034-08dd790012c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BQPjgiCfmmT2tFdahsX62coE9x7gt/ui5+YUZ48/2xQfHc0zdc9NDHEb7vSC?=
 =?us-ascii?Q?6rs3ZPoeFTLaz1Md5ynybXKBbf/KaRIlilTPDzf5A1/HqRXVUSnp+kUzEOx+?=
 =?us-ascii?Q?nZTMl25NGdsvqRxG7SbkuhmhRufBeR5TpoWzLUTDzYC8TelkhYyIQrS4RUpA?=
 =?us-ascii?Q?rwHNx88Kn3vvJA9qmv8i9q8jrkJTTmJ4C00cGy6zSua/642O3ZoY/RgOjLZO?=
 =?us-ascii?Q?iqKEAPLvuJLLyrDJu4v1C5IAsDa4/kmGb000YMJunjR+ZU4MPLddF/rdBLTG?=
 =?us-ascii?Q?HcuBDyv8CtfDok2X1CQtlzs0A+a6Oe+sw/FNl/wJXDMvqvzUf6A+WCGPlYQO?=
 =?us-ascii?Q?jaSKcwUn9+MAeNf9Y1JcD+iQVk9V8yd82m8MfnbG16dQgsqV2R3xIorOpC3T?=
 =?us-ascii?Q?w3rAqG90hVmJJN4BR30QiAo8u/PEXfTsb0kSYPD2loh3w0/vymU63QD0Zd4M?=
 =?us-ascii?Q?R7iKzpUf79+lDqRPZvm2VP9Qg7fT3qZ+9J6n2tt5w7akbGFqNxSmu7IUzn4w?=
 =?us-ascii?Q?f16o7dRMYpJUrj4qPK9S/TMow/XQr0snrLkW4Swmaenwe2a9Q6EWRlGSics3?=
 =?us-ascii?Q?mx9cS1KqBh1YBqRea292UyKUurWUP3PhqZ9EpbRyCoddKk99fAzUOLPURYop?=
 =?us-ascii?Q?+guGZH7Ij3BOXZer3T94+5YzB761AvmtMO/Fw2dLL/KB9crQVlHDFGaOX82V?=
 =?us-ascii?Q?jHP/xcjaUPdZnpNeAjOVt52Ok0AS7cUXmvNBxChdyhqbf1Mt4Au61Xv8Bp3P?=
 =?us-ascii?Q?I04T9L8CVG0U7Nkg0ITDhjZcQBCdYg1EPKPQSXu9/wO+xnSY4wbewp4UTxNP?=
 =?us-ascii?Q?tcMWDFlrCySft3PZC1qDrH5e0HPbmSkyZXmKPeCdGzUW4XCpxrp9wOS1t8f1?=
 =?us-ascii?Q?MBITeoCRkv5CqL3JD0wYx1z//SYmb3mmUY9gy78x9GsLrVUP1QEUFBRfLj93?=
 =?us-ascii?Q?j49IxK8DYP90Kn6hphgC5lZdByadLVlgEV2agxE7RNALWPMlKy0XdQ4YO87Q?=
 =?us-ascii?Q?YrFjy4HpVvWqETxWYvciBa4sKBW00LrGhHY2oe+0iQm/1tnERbL5tTGesn2v?=
 =?us-ascii?Q?6a5AxFpwwky0awUG7IWR7pDfGBqIyE33OAoh8x4OQG9dw0YbDItOIDquZcC3?=
 =?us-ascii?Q?vMbHvhd0GhGyavCnGHdBTM8SqNs43yDZa9OApb/aZrfGFexXkdseR9OkOWfM?=
 =?us-ascii?Q?4yWIJ5B0N4X729vbqVUXi7GQY9VS69RPRwrORX1XbJi+TLDgwKrLfL3xgs4+?=
 =?us-ascii?Q?FV7Y43/VR6PuhgceP/uZooAq+Jj+Eg7Mm0GNI91P0Ate24pC6M6hxrrreE2K?=
 =?us-ascii?Q?LJy/EXAGbJHG03xm1l7CfsS8dTXWSh7s9Cc384Ca5xNvEed2f+k8/PHFtCEI?=
 =?us-ascii?Q?IHQTMMEFU3vyeabiXrrNgMpmZppPYPdQbyM50dc9uLEH6EsKcheynYxtOx/P?=
 =?us-ascii?Q?vEGAtHcfdV0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OJDC4SGyD1vQGR0QRuMfy7qS54z0yOQ++Q/Ikhgo+6xhd5IlTArxPmUZNZ04?=
 =?us-ascii?Q?KyHkwldu+H3f4n0QHiwsZFyfMY6i8dAZf0M2tSVcdD24I/rh1KoOZTQWWvvL?=
 =?us-ascii?Q?LIszlbYn/hSEo7aSeOSIPQev2F3OJYi1oZmHAEr75NCAoJ7UwDKjbQktW1qK?=
 =?us-ascii?Q?Zd0r8/hIgQWydjC7nzSdApcana9hyCk2QoLER/fZ49xtSQORiS/4a8P3Du/w?=
 =?us-ascii?Q?MnnKP1ce5XxExfd0d+GIwZP+2vtobpTmVKg/ublhYHANAyGXveBrnPyncSC4?=
 =?us-ascii?Q?j2x7PxcwHOy5E/XTWm3A4G214MHNXwSjtlgZRd7tSdjQJi3obdbZnpagIKiW?=
 =?us-ascii?Q?3p1Y13IoBxTWqf3WoaO3zxHOiqmJhB99VLD8axLSqpJYvhv2QHS1CmSzCMvc?=
 =?us-ascii?Q?iIrr7fQwzhS9jKoVi6h2ssuqtaz2rD1yaIuBalZ0lMGyzgELrKh4aZ74nzg2?=
 =?us-ascii?Q?ZEu2LD62ohObz7GEuUlU2fYzciAd+aLfTRR+zUO363nG1+mS/joZCUpI51zg?=
 =?us-ascii?Q?XwMi1sePMLa5V/vN7K5W7ZD8MTUCbUkQsvN2WnbYwvhl3LVJxPDKGbvz2/E1?=
 =?us-ascii?Q?9IF8bnZzEzjss6xwGZnHaEM/SvOVLtD+f0DF4VgAOwnT2NAWfvyA3NQc9yGS?=
 =?us-ascii?Q?OXzKDtn/tznzbzarBTjk9SBL98A6tVdd4IzlbEhwdsbAskdkVtdBL5SpF612?=
 =?us-ascii?Q?fB29xJvAmazxN3ruWNRpTLTF6qrXfZfNJ1tKadSEiFuZ5Pn+Qmax3KF85rTU?=
 =?us-ascii?Q?F1xXw6cVmKF6IbjqiDyF/y6uYbDM4RkYTky+AVcA4HIpJCQpeL1/2i0l9ADw?=
 =?us-ascii?Q?F1PPzlj7JrLIHd5SP3Ec9s+WX33S4I1xRPjTuL71vU/3Daq2C+tPvf4Kyw0K?=
 =?us-ascii?Q?qXRmr/pgmB3RCLeoMaO5M4VGgmao31AUE+KDxUUCMmr6bNTqwOyuvHtTGCkV?=
 =?us-ascii?Q?LBKIZgMtFlXZxBP1oIx4vQJkOdCyHdz2/bXLCEO8/o8tbTnn/i4b0AqaxXiJ?=
 =?us-ascii?Q?q+dguprARD4YjmPGTjapuk2eZqgYfaDOT7iQdm6X0T7KUh2gp9VWfgYZr/NS?=
 =?us-ascii?Q?CgpYlkVFiqwD5d4QWUvwGNf/37XMQBbMleTz5z+ahu3yra2g47kt1JMAAr5W?=
 =?us-ascii?Q?w9QsZD9FYDkF/1AS5iXPHOy37D+/l09ZFjyz1LRWnOf2Sk3CA1NNwnI8fhY2?=
 =?us-ascii?Q?zxAEniL0DgRzTO6sz5b7rYXPxrCumRQUf/AUzL82qFEjx5ubrLSFgOU4lyLJ?=
 =?us-ascii?Q?zLFH/b5/TwC2dVdkRVvV+xRZySZbUMDETEAXDT15N0jGWANMlRZiz44O8lEx?=
 =?us-ascii?Q?7atmaXNSmmF48jSLlEZ+wbJ47Vj4PDUhFNc1eblhmYzFRiBv8Q7lEcah/1B0?=
 =?us-ascii?Q?trVxGqDwUTuFTQENsswOoMe1hPrTOn+Jr9CUwa/Dtt6w5XWS2EzgHny4v/9v?=
 =?us-ascii?Q?2cTaGGB2R0Y5ywhe+RgdmSVxHBC97odsYMnO5FCSdqLkhO+FHKNL0v1uvPws?=
 =?us-ascii?Q?KPEaEa15Yfs2Z46cnznZNnpnIDFlrpNJYiA5Kc7zEOjNblrZFSNs4V6yM4dQ?=
 =?us-ascii?Q?D3blLpUtenS2igW0PMU5mpoxnbeE3PVG9UUT8scGSEMGRsqKpRH4+QLc7+78?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddbd82d-178c-48f6-7034-08dd790012c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 13:52:17.9908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9gVQASMp9OhabNXFLAr6lz0Z5UYoxoEsv4KkG++l5quiv9ST9c6aKvRWxK9vm6g7F9Cnuafa4CsGKj2KfPGcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8020
X-OriginatorOrg: intel.com

On Thu, Apr 10, 2025 at 03:44:56PM +0800, Jiawen Wu wrote:
> Implement ndo_features_check to restrict Tx checksum offload flags, since
> there are some inner layer length and protocols unsupported.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 27 +++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  3 +++
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
>  4 files changed, 32 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 59d904f23764..a1f9d2287fdc 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -2998,6 +2998,33 @@ netdev_features_t wx_fix_features(struct net_device *netdev,
>  }
>  EXPORT_SYMBOL(wx_fix_features);
>  
> +#define WX_MAX_TUNNEL_HDR_LEN	80
> +netdev_features_t wx_features_check(struct sk_buff *skb,
> +				    struct net_device *netdev,
> +				    netdev_features_t features)
> +{
> +	struct wx *wx = netdev_priv(netdev);
> +
> +	if (!skb->encapsulation)
> +		return features;
> +
> +	if (wx->mac.type == wx_mac_em)
> +		return features & ~NETIF_F_CSUM_MASK;
> +
> +	if (unlikely(skb_inner_mac_header(skb) - skb_transport_header(skb) >
> +		     WX_MAX_TUNNEL_HDR_LEN))
> +		return features & ~NETIF_F_CSUM_MASK;
> +
> +	if (skb->inner_protocol_type == ENCAP_TYPE_ETHER &&
> +	    skb->inner_protocol != htons(ETH_P_IP) &&
> +	    skb->inner_protocol != htons(ETH_P_IPV6) &&
> +	    skb->inner_protocol != htons(ETH_P_TEB))
> +		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
> +
> +	return features;
> +}
> +EXPORT_SYMBOL(wx_features_check);
> +
>  void wx_set_ring(struct wx *wx, u32 new_tx_count,
>  		 u32 new_rx_count, struct wx_ring *temp_ring)
>  {
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
> index fdeb0c315b75..919f49999308 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
> @@ -33,6 +33,9 @@ void wx_get_stats64(struct net_device *netdev,
>  int wx_set_features(struct net_device *netdev, netdev_features_t features);
>  netdev_features_t wx_fix_features(struct net_device *netdev,
>  				  netdev_features_t features);
> +netdev_features_t wx_features_check(struct sk_buff *skb,
> +				    struct net_device *netdev,
> +				    netdev_features_t features);
>  void wx_set_ring(struct wx *wx, u32 new_tx_count,
>  		 u32 new_rx_count, struct wx_ring *temp_ring);
>  
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index fd102078f5c9..82e27b9cfc9c 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -587,6 +587,7 @@ static const struct net_device_ops ngbe_netdev_ops = {
>  	.ndo_set_rx_mode        = wx_set_rx_mode,
>  	.ndo_set_features       = wx_set_features,
>  	.ndo_fix_features       = wx_fix_features,
> +	.ndo_features_check     = wx_features_check,
>  	.ndo_validate_addr      = eth_validate_addr,
>  	.ndo_set_mac_address    = wx_set_mac,
>  	.ndo_get_stats64        = wx_get_stats64,
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index c984745504b4..0c5d0914e830 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -656,6 +656,7 @@ static const struct net_device_ops txgbe_netdev_ops = {
>  	.ndo_set_rx_mode        = wx_set_rx_mode,
>  	.ndo_set_features       = wx_set_features,
>  	.ndo_fix_features       = wx_fix_features,
> +	.ndo_features_check     = wx_features_check,
>  	.ndo_validate_addr      = eth_validate_addr,
>  	.ndo_set_mac_address    = wx_set_mac,
>  	.ndo_get_stats64        = wx_get_stats64,
> -- 
> 2.27.0
> 
> 

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


