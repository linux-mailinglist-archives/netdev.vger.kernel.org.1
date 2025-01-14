Return-Path: <netdev+bounces-158299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEE7A1159F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D0A7A1258
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E9A212F8E;
	Tue, 14 Jan 2025 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zt6hxCNn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B114883C;
	Tue, 14 Jan 2025 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898504; cv=fail; b=R2F09HBBiEAMgCjnwgdbn6XX7+nbxZRggHOjRAe6w8BRek8Tgz1HoMpLVuH/MgsAagmtk1h/zLvEgCCVDsDiptw1d068Z87ZUvnPdD16txxGFhvTxUIb4UgCGztazYaHtizrU/M9QoVaLN4CbfhWhJHGZjcmcm/yCe83v3igMI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898504; c=relaxed/simple;
	bh=KERQIl40EygjBocLA15vcee/B68CQioxy6kWfWDdjb8=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SIxfj9iab3cLcDWssbsYCuqJ22gYFmwkJA2pgbwQAr2fVArzIDSFFMUyYQFQNhIgJMj/wlJL6TbHNsLP698bc2fEgGUNOijJrYeI4jEdkF4Yfh8CX5P3+zqu6ykmghz5CxP84s6RXhYQxG5/H3fX7DHiVg/2XEJYera41805SAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zt6hxCNn; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736898503; x=1768434503;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KERQIl40EygjBocLA15vcee/B68CQioxy6kWfWDdjb8=;
  b=Zt6hxCNneLvXn2Os1MKiaMQTbHgNZ/kUx0W9iQ4XJyEyDfNzEGEco7CS
   mthkzo/IiCOn0cnjcS5rj2OO9SWlDrU7VGU7VBhy/FFLL3OZwbsjU4Ic8
   4tFE3zl7ILIOgoSx6KKdZluDiI7NrS4+625r0/t5Gr1vI/CLdfQ5AItZc
   BndFLHfOPGgkzLcVmqSr6EGyTrR4JXFAfKmOJFJviF1ajjyLgPtp69X2j
   WA8AAbadCR60S+L/+DbPU9lpShl9/ujdISk1Ey3t4rrDuXjD43wLMq/Zj
   yutNc0YK2ePzFkNMxtbCUAN2mtVbyLHmMH2LpIp/J40aok0p7B5lWF2L1
   Q==;
X-CSE-ConnectionGUID: +a/i1KziSqSRwtiKocnD3w==
X-CSE-MsgGUID: fjemsmkjTAO8WXyNb4rj3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40027019"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40027019"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 15:48:22 -0800
X-CSE-ConnectionGUID: yy1xUAc9SvaCDYusA7V4gg==
X-CSE-MsgGUID: I+JLbToCTGu6DIl6VFk0Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="104706263"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 15:48:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 15:48:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 15:48:21 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 15:48:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6NNYh2jKMyfHZ7eN5bBvpH55zeLhJsWNi5oIpldCmRGkaW2pMYFwoZmJ7+7z1kMLzae8j4e+xMwod+iZIcT1jddAFF1VoeRbwBPkQd948x5KXAk2dmgNcRtqdnqlF+0t5MrJibad+/14Lx/f2wyeGPdXlX3Z5eNOKAppARe6Xj+rQJlD4xZASBTeemSxOUtS3R962VC9kL/mk9DIat+9Hashcwk+Im2dQ8GKbY/l7nt+sssRHwth8vROj6LKLw44i9vwFS5i15nPsTqXZgAWtPn7vAbWuLYbKlPFYFHsNI7JAnyIO6R7nCpRO3Ued5rNBWJpLe8zCPKjcP/wLaKYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7tomYM/xnAJhpyZAVDVcARAg0eFr0sbgKUI0zj8bRo=;
 b=aKePrJCFLU5i4nTgW32LvFhLdbfLATXImEwCr/8AvaQ44nVqozKwMphs0jx0c20VK1HWaSV9mqcPyOJX2Ob9xA7FtPHxe6ADC8IDH0KGj+7Fu1MON0GSbUrsU96yTTb1Pbmi7D+AW8WUxSuzrKLpD7XOaZQ819DbzKlRAIo6cZIUspfg5MGfyTrOLq/JuJbJqVT/oUOjyx5yteDutUSqDP/ow6xxFGxqTVdQmr61DQ5U1mg2Vgg+NdnL3Ond4aZo+k6aQsLaPpWZIqVggtxFKKPGpUU7v+1VFYHt0guWYkHRBQn8YMgQlILpjFDB0FEuqjidKXsoicpVUklj/1xbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 23:48:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 23:48:18 +0000
Date: Tue, 14 Jan 2025 15:48:16 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Message-ID: <6786f7bff1389_20f329429@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
 <58981468-ca67-0bb4-86b9-5cb2c3678737@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58981468-ca67-0bb4-86b9-5cb2c3678737@amd.com>
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 30744a4a-710f-4f64-ae81-08dd34f5ebc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?w2IobwtaXGgUljCPZQzVfuBl45ne7xjBNp9TDuv2ePilDFAjKR7Cck2CQR?=
 =?iso-8859-1?Q?NOUsQh+Q4BsL2T2jcT0pV7+mWi/wuFhpXPIdtk+EkqYgd+vr6HlsnyP4jy?=
 =?iso-8859-1?Q?xcVvfWfIF4dTSJzMI3y9i+mx39qnBICBvYGFEsw2KXElahdsjLZUeJpErq?=
 =?iso-8859-1?Q?AZHh3eWIZ/Zbpy3u93I4KGDZAI/saER9/nS07Cmg6F+yEd4U+euUaqSVSp?=
 =?iso-8859-1?Q?/a+GlNuLgCbOtk4dwv5pC+dug1se1MKGEFiiigNqR3eDKYpdKw8ksi6MGo?=
 =?iso-8859-1?Q?yjH9EWpINe7VF1vNOHT2jgp71zt26G3f0qVkvBUHuc5sexv6WORMjb25rj?=
 =?iso-8859-1?Q?Fij7Vxh49XgbK/S30wYx5yG5THetkLj9itJf/aYSXwqfTm61buJ4oiRNoo?=
 =?iso-8859-1?Q?FFSuxi5yvGYXQmrdg+Gy75GZoPSEOGZBeE3gO3zgprOxW5/JfG59PSeFBY?=
 =?iso-8859-1?Q?M5A2voB9+jv6xFsEBr58pEmKlMdJTTYaznWzhwXBHoJk4K/z/zbzVoUVRL?=
 =?iso-8859-1?Q?R5Tc0wK1R7YD35+QooGBGBdeeqJjnFrBZKfBNC1YcfZVJeh3Fj1yvWXnRM?=
 =?iso-8859-1?Q?zmykrcm2/sp02PnbbWetJTSrJIi2tbMNwcdwY0mdySEBPrDYIEvVlBwUli?=
 =?iso-8859-1?Q?foHaDIGO0S8wocRH+8um/7AemvoGQ1/imwPIbpqYsCpDpLjpT1UzxNhMTV?=
 =?iso-8859-1?Q?H9dX8lMbe0DcBcfMFfty9qGj6WznfzOIz7/thXzRkSW9xZIA/Up+jRTXhL?=
 =?iso-8859-1?Q?iqWICrUFH5sD77FHNeP9JRoN2CeZxJkOQBxyhjNghnY+4c9L7a6vBf29MM?=
 =?iso-8859-1?Q?dkrn1GFdPNMgikTvpZ2mP9ZOt8JSS1INnGqalnegLJ92ORbm6Ke9LjIBU0?=
 =?iso-8859-1?Q?3rc00s2j5y1P2SZMMFh/Vjjix4FDMy7zZbah0F/gHkU7DPihNM2yvup0Rm?=
 =?iso-8859-1?Q?og7PqGGyttqsp7HW9NWcljKnBAWHiCM6KC2Z6Dh3lLtU3uzA1OSTTl54Pz?=
 =?iso-8859-1?Q?OMD3Kz05MnS3vA1JA2aGqc9XvYBqrqOojusO6CO04BpNIEkkW5ZnDmp0uw?=
 =?iso-8859-1?Q?aeobAAQOArtI0jfsgYfLM0R0mWcaplrnxT5eLmbJyfnN1Ovakp49t1kPSK?=
 =?iso-8859-1?Q?JIQT+cKQyZRWTe+zaaUupQiWpWzpyk0K4i/yMvovo9+IhnPN93jK7ubwKn?=
 =?iso-8859-1?Q?fS8xHmdv5JzXP+IzAhWisFc/Ui/KgSd1OuCjoOdJCItoa55WJegdlnl0bB?=
 =?iso-8859-1?Q?WTVQseX+sneI54O1cJ8IH1r4oijz/EXm8UITfABxgvQUA009ZJVN+FLwtJ?=
 =?iso-8859-1?Q?A9qMu41eOcmn0B5KKq6VmaAoqjckD39aBVXbw6u9HyLjTMO7ELySq44JWG?=
 =?iso-8859-1?Q?smjymvx8w4T176eJtVn40o731D8Io0fiLkoQLYWTwngG4xDBKcEhKg2Run?=
 =?iso-8859-1?Q?EHPInLwEGi0giuTsp8hWPVBKdRfWCIgEB2FKHjEgKgjlYIxWPY+eCCgrmv?=
 =?iso-8859-1?Q?skkL/6+RWcS97au8V+//U4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0m2+7EJrV9AF8MAuIcu3S0+LmkTL37DtTUI7Ffp+mY1ajXIfRKZF2/FIwR?=
 =?iso-8859-1?Q?TS8lX1SL1Wbm43P2x7052pfGAvtUp2ih/gzVTclxWj8jyyXSOm5Fj7ghIk?=
 =?iso-8859-1?Q?h185ytDFsGvMrnxTMSkyldR3DKcqgJz96FJ7wPvutb+TSaJW68EIXk5NQ9?=
 =?iso-8859-1?Q?v4dE0tox60GX2Qc68f028DEOGoyC6VFKoGMq6jGDsWlGPkhhfis5TeaQl0?=
 =?iso-8859-1?Q?UqaFgSZOhHOqTdsBLS0JF5xJo/N13KcsCKAR/d76sjjoqmKeKysbTvknS9?=
 =?iso-8859-1?Q?xL9cgs1Pl6BqOwpqG584C0cTxVrvFaHCIeHB82NqHIgNaYPjXIg4lP5VrS?=
 =?iso-8859-1?Q?hwFIpYb+BsAn6K7Of1L00D8eyDPz8YptwCP1k2V8R3Cm/ypFxf69yVkWEV?=
 =?iso-8859-1?Q?d5T4bELc9QFcH+fPjX0e0aG6ulrLdpxFqCKtBPJi1FIGjbsrBBYhVkTl6P?=
 =?iso-8859-1?Q?IBUlqeiout5soDG/x7CUr2TouGfcZMfiYUnQ2QenjZ8uUXzHoIvXIurIZT?=
 =?iso-8859-1?Q?RQW+arLlQlfk+WBsMs2HYhvs+MF+O8zaXt5aSirvijW/AW/1r3i381TvUs?=
 =?iso-8859-1?Q?kHAPN2Kas8hiAxyRjsyNNzNtmOqRLU0lOTGCHB7LkdB1GbVch6mQlS+tvv?=
 =?iso-8859-1?Q?ulYvlBgmH9NdNRzHvx+WUIShUk0z81svV9Mi/UtkT+Tkbc1ljatSSbf00y?=
 =?iso-8859-1?Q?E08m7+USyNYath2AmkVh/tSy8H/iH8AHlRyxydx1ZCmquwqxJz4u1TqBw2?=
 =?iso-8859-1?Q?Q5me77c4Fn4fmkdwX/t63xYrf50L0ovpUWxMlY2Wi2AZCgFu0HGIx5Fswj?=
 =?iso-8859-1?Q?UlCCUQL7/3JBzB5iXB3o6FplMTjc2PC8ByhMTf6f4+GQaoHabH9yTlUuHR?=
 =?iso-8859-1?Q?qtn73B6YxTyXB6TUhmQekfU082KUUcYJQ8/0vfyTsMvyhdJl4dgX5jZJdA?=
 =?iso-8859-1?Q?JzClEg/4uKgkfhmtQ2mxs4ABrZVICa3HVDAOrcXyIft1+fWLYtA3SLmOFH?=
 =?iso-8859-1?Q?tjfkZULyE37zqLrsuBPngcTPxO2JGp1euL/SFsi0m9f+aDBxYL+y08dsip?=
 =?iso-8859-1?Q?w/30I7JFiQ3ZrebyWatcBeTcFyW44cghXMSiboDbR5v8zNTzF7BuzlMJjK?=
 =?iso-8859-1?Q?WhiOG9n1th2MrjFwMYes2j9BZ7SDtBJAGo4J6//ly+qF3+cZiYWKeTfiXo?=
 =?iso-8859-1?Q?twakZmwtKu9aatMqb9UoJDCqEGKP3zODov2986irDV+eFnVa67bP7yenR3?=
 =?iso-8859-1?Q?u5NqbyQGy0BpS40EjliLj/avRyUxZRvDH02swV6yy7eLP5jhIvDVs9RXug?=
 =?iso-8859-1?Q?vx7Is6C/JeA7Gpb2j5mpX2Cqj5EJIUVYR9mn4OmugNcxk6h1bdsXhfKXd6?=
 =?iso-8859-1?Q?dy7A11edMgBMgEkysftSVu+AnpTSIZGcZ4CCEtLNdV+M2KAQ1wHw26A1IZ?=
 =?iso-8859-1?Q?4pW+GFBEBq0T3s2uwatpib1/Aeat7wGGbCa/sQ+La/VbFPu0KkiFionnwU?=
 =?iso-8859-1?Q?XPCYN/zcbwDo5CJJmc3tPZT9ai/n6HsR1lzt9chmUDg7argwug0+uCtFkw?=
 =?iso-8859-1?Q?w4tg1+7QLzZnoQNquwXoMghyXXhcfRgl2IbnttQUEOdMC+JkmoABcH/YrT?=
 =?iso-8859-1?Q?0gFQyjdJJ08fbMPKbidws6T1hy2o+zJQV/IY0N7+h4J8SpkUldESm7gw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30744a4a-710f-4f64-ae81-08dd34f5ebc2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:48:18.4883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tq8xfquVz/N8/FRZFXMJ4qyb5M6n/E9u9OOil4NkDs/Bw5AVLNtfz1yLZfX8nrZhX9J9s0Kxxep7mjNzlbSBGGtnNgIX2TIzpqvZxOamHX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/7/25 23:42, Dan Williams wrote:
> > alejandro.lucero-palau@ wrote:
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> >> (type 2) with a new function for initializing cxl_dev_state.
> >>
> >> Create accessors to cxl_dev_state to be used by accel drivers.
> >>
> >> Based on previous work by Dan Williams [1]
> >>
> >> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> >> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> > This patch causes
> >> ---
> >>   drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
> >>   drivers/cxl/core/pci.c    |  1 +
> >>   drivers/cxl/cxlpci.h      | 16 ------------
> >>   drivers/cxl/pci.c         | 13 +++++++---
> >>   include/cxl/cxl.h         | 21 ++++++++++++++++
> >>   include/cxl/pci.h         | 23 ++++++++++++++++++
> >>   6 files changed, 105 insertions(+), 20 deletions(-)
> >>   create mode 100644 include/cxl/cxl.h
> >>   create mode 100644 include/cxl/pci.h
> >>
> >> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> >> index ae3dfcbe8938..99f533caae1e 100644
> >> --- a/drivers/cxl/core/memdev.c
> >> +++ b/drivers/cxl/core/memdev.c
> >> @@ -7,6 +7,7 @@
> >>   #include <linux/slab.h>
> >>   #include <linux/idr.h>
> >>   #include <linux/pci.h>
> >> +#include <cxl/cxl.h>
> >>   #include <cxlmem.h>
> >>   #include "trace.h"
> >>   #include "core.h"
> >> @@ -616,6 +617,25 @@ static void detach_memdev(struct work_struct *work)
> >>   
> >>   static struct lock_class_key cxl_memdev_key;
> >>   
> >> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> > Lets just call this cxl_dev_state_create and have cxl_memdev_state use
> > it internally for the truly common init functionality.
> >
> > Move the cxlds->type setting to a passed in parameter as that appears to
> > be the only common init piece that needs to change to make this usable
> > by cxl_memdev_state_create().
> >
> > That would also fix the missing initialization of these values the
> > cxl_memdev_state_create() currently handles:
> >
> >          mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> >          mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
> >          mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
> >
> 
> Ok. It makes sense.
> 
> 
> >> +{
> >> +	struct cxl_dev_state *cxlds;
> >> +
> >> +	cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
> >> +	if (!cxlds)
> >> +		return ERR_PTR(-ENOMEM);
> >> +
> >> +	cxlds->dev = dev;
> >> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
> >> +
> >> +	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
> >> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
> >> +	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
> >> +
> >> +	return cxlds;
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, "CXL");
> > So, this is the only new function I would expect in this patch based on
> > the changelog...
> >
> >> +
> >>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
> >>   					   const struct file_operations *fops)
> >>   {
> >> @@ -693,6 +713,37 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
> >>   	return 0;
> >>   }
> >>   
> >> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
> >> +{
> >> +	cxlds->cxl_dvsec = dvsec;
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, "CXL");
> >> +
> >> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
> >> +{
> >> +	cxlds->serial = serial;
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_set_serial, "CXL");
> > What are these doing in this patch? Why are new exports needed for such
> > trivial functions? If they are common values to move to init time I would
> > just make them common argument to cxl_dev_state_create().
> 
> 
> I was told to merge those simple changes in this one instead of 
> additional patches.
> 
> And I have no problem dropping them and use extra  args.
> 
> I'll do so it v10.
> 
> 
> >> +
> >> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> > Additionally, why does this take a 'struct resource' rather than a 'struct resource *'?
> 
> 
> The driver does not need the resource but for this initialization, so it 
> is a locally allocated resource which will not exist later on.
> 
> It is a small struct so I guess your concern is not with the stack, 
> maybe about security. If it is due to some rule to avoid it which I'm 
> not familiar with, it has gone undetected through a lot of eyes ...

It's not about security its about the semantic of how does an
accelerator initialize the DPA address space of a device, and can it do
it in a generic way that can be shared across acclerators,
pre-HDM-decoder expander devices, post HDM-decoder expanders, and
new-fangled DCD capable expanders.

> >> +		     enum cxl_resource type)
> >> +{
> >> +	switch (type) {
> >> +	case CXL_RES_DPA:
> >> +		cxlds->dpa_res = res;
> >> +		return 0;
> >> +	case CXL_RES_RAM:
> >> +		cxlds->ram_res = res;
> >> +		return 0;
> >> +	case CXL_RES_PMEM:
> >> +		cxlds->pmem_res = res;
> >> +		return 0;
> > This appears to misunderstand the relationship between these resources.
> > dpa_res is the overall device internal DPA address space resource tree.
> > ram_res and pmem_res are shortcuts to get to the volatile and pmem
> > partitions of the dpa space. I can imagine it would ever be desirable to
> > trust the caller to fully initialize all the values of the resource,
> > especially 'parent', 'sibling', and 'child' which should only be touched
> > under the resource lock in the common case.
> 
> 
> No, I'm aware of this, but also I think there is a need for setting them 
> independently, and the reason behind this code.
> 
> Maybe you have in mind some complex devices requiring another approach 
> for this set up.

DPA space layout initialization is a common operation so I am looking
for a way for expanders and accelerators to stay unified on shared
library code for the similar semantics.

Let me see if I can draft something that also considers what the DCD
code is trying to do.

