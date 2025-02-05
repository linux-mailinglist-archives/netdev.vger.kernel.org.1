Return-Path: <netdev+bounces-163241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E4A29A9D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6E73A1F2F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3992B20CCD8;
	Wed,  5 Feb 2025 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXVOVRhA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B1204092;
	Wed,  5 Feb 2025 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785958; cv=fail; b=cBFhnYMnDdlzZI2syBY4yZ6h6g99l/4fg9cqgV2paH9azyieOM3WqttuC/xHodR4XedO0zd44raa64df0GswVtzyIOfrr7hwT6kmZENOhISGTNIE6qsJ1N828rHDNhSdAt0y4GrvrWUlnZF43IkeS3tbzRiWrdlgjA1btFvIWQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785958; c=relaxed/simple;
	bh=WB7xko/o4mynrZSljw8QrzVO8kuPHfujiLEEMocqiMQ=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bBuQGwKtUbvoBIo8hK4VkpAGt+mipaLKpbA/nSsb26W4ZAcyPiq9oYhWRTbNGpZdlDnH71TPwbUEf8nU5poYP9EpqQjNyE8NQ61RoXpfE4MjC+O46iY7BEOb2rO5ryjoVM144wWkAvYBs/aT/CYhNW/1mcxNIz1vHQv0wAa7oAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXVOVRhA; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738785956; x=1770321956;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=WB7xko/o4mynrZSljw8QrzVO8kuPHfujiLEEMocqiMQ=;
  b=YXVOVRhAxJ/3W2H4M3anBIg3X6F56w/2osR5S/+kROBbGhUjxQx18Pe2
   SdJZIOI/4EhzezU1cpAg043pwmXfZTJGaBzOYsf43kOPCPmONJM3v1lGX
   P4or3pSgtgF3XAo2tZeM1w+ck5QBZz3jctuPRv/s7o9NQ9LLsMBhZwsUd
   sAICMLwpT2gL1mN0e2iL/1Md8hAsaZqqmPBZm9WhyWmVSidZrWenvDnEX
   3aBBzK5svV16Jw0/M5RGkyrZeFk3Lv90C08AzWsD2q6dOgHFiFIaTzNBH
   MUt93yannSay2rTwMkA/CNh0El9ROxIsiAbtHyaoqnLYcfgzfYD5let73
   A==;
X-CSE-ConnectionGUID: 6ktl4qhDRYO6TVpD0Yx5Xg==
X-CSE-MsgGUID: tmBrtWD1Se+BANFqHa4NFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39530242"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="39530242"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 12:05:56 -0800
X-CSE-ConnectionGUID: fI4zvnlyTBG/1ZIjOTB8jQ==
X-CSE-MsgGUID: 7nFzJuNmTrGHzIHSGEpuvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111896409"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 12:05:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 12:05:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 12:05:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 12:05:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NX2cHoTvXE7c1OOjsNIovT/E/IbZlU9CqZsUhH7Y9CbXJrFnLAvHUoM85utWCHIeFVvu5NRhdWI7sZB3fFy5eNd9/gdhPjMZbMu6obGhmZ8AErbb2m29WB/4L2/S3mFgpR+O62tWODRZc1mVIXCCshjk9s0wWqdL6Z7o/RZl+oMYOQBLQQ6shVy/jFIhj6SkkIZw7JPxWbc4dpjGRds7nqHC6yYWzz7KcHN3VGNR1H2RztdUIyEFcllXh+xE+uVW65e7X5sBv7tEa2p4e9fN7aWHYfZVeWVm2ASvnWbTQx5NonU0bkhaOFS1bI5dwkJJBIpgFBng89eSH6Ir8Nbakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITcWmWNoo9fI2dVAxlEabIMOXFQCx4Dj3zM9ICcMJJw=;
 b=BiBuVbjfHkIzRDbfvOU7yHnFg4NgZ8K1plGSLgeUwlvoXEMCx1vCbC+0Shu1TMX3ES+FDCXTyl1hObb1MJLRpvwLepWk42g7Hq3BOErc8yet5yCWY1AQaPuez6WnJPHt5qs+7HPEe/gjvx6HgOyDNaMoHDyYB9515gTp/FQiyKd4sWswMVlKdTrQbb2SNHiYkVzcCfYgK+KBrycnJXZYR+QiCfbbjKTg62dukrh6CHVV4MIIgF/iYndEceBM4kjBZGspwI4mkEo3p8/fa03/pU/trzP8c2dd/vCJ98DuCWo90HYxa95INLrplRfNL5dUIK/rvhGzk9kelmLFQwAoGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7377.namprd11.prod.outlook.com (2603:10b6:208:433::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 20:05:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 20:05:52 +0000
Date: Wed, 5 Feb 2025 12:05:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Alejandro Lucero Palau
	<alucerop@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Message-ID: <67a3c49e1a6ef_2d2c29487@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
 <677dd5ea832e6_f58f29444@dwillia2-xfh.jf.intel.com.notmuch>
 <c3812ef0-dd17-a6f5-432a-93d98aff70b7@amd.com>
 <92e3b256-b660-5074-f3aa-c8ab158fcb8b@amd.com>
 <6786eab3a124c_20f3294f4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6786eab3a124c_20f3294f4@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:303:8e::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: d118511a-8fe6-41e6-95ee-08dd46207e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R7GNJVJQbGuP2TP6g5wtH6+3z3VKWZxAHdnJys1D28tOs0V5XwcxFN/LWO8F?=
 =?us-ascii?Q?OEbLfN138UbLplv7TBRQYZrmSkfa9CUAxoPyxg6Z3IKfoD85TUBgm8slWJWv?=
 =?us-ascii?Q?xZdBurXWjtj+yS5IQDWDkgx28PzUdp2/TshpzEHcSZBtpGAOu02gjjLA/LLX?=
 =?us-ascii?Q?TE8wF5pT1vfFZe2AZ8KLACuROQ3/eLBuAgJKVEROmWmYMoPP9wTb8v40bKQW?=
 =?us-ascii?Q?oGkEPGwKAMTAisaI6FFiUzxOw73bAifNRz4xLeRlAFWBvPXnYY1Y7UfwdxEu?=
 =?us-ascii?Q?7AopK9EIvmBViWZBMG4xwbBn2Gq0gie6iVS72uzRyXGa1TqMMY0pN7jJMhxg?=
 =?us-ascii?Q?lURDF1bjbqgzab6u4lhoiT04G8zDjlGGvu2Cn83nXI+VrGdRyFxhqJkJMX44?=
 =?us-ascii?Q?7TPPJOQuISloyPkn/VbaEMXcdsSCPnpcB/flIfhe/KvMHZ3BDTwzyMCh4xsq?=
 =?us-ascii?Q?e5sekwrKZVEyspPP+m5rByuJcAwf2sSaqIM1n50aIWriI4RC+dL6keeetDI2?=
 =?us-ascii?Q?c1lvG8duoAHN/wRzTNX0E2e8G4hErR0KV8cSDXZvNEyxL2FPzZFzthIak6Hy?=
 =?us-ascii?Q?qGXzySAhhyxlQkVduYhpfqCiHkpp/G2VG7WD5q8z/k3r+W5ENqAAyUC9vNDY?=
 =?us-ascii?Q?K94Lo9big9tXkDFiMEXHDGpIGXIPKyP5u9PgNxkN4BN92TYd0hAW/SN+VM3l?=
 =?us-ascii?Q?1f7w1tO2guvMlXi78ey6w5HbWyRR+Kirox4AXilbBdpJ1jc1Tf0/wFPegd8z?=
 =?us-ascii?Q?+qk96oG5peMW1bhhZvMC7LYlt7jOLQJCND17Lz4os0FfIAVkyc4Vge7JPuZP?=
 =?us-ascii?Q?CmwFvIVBkdWmOHFxYwVBFVYUSjpE+Uj5FHBhkDG5xeTIg2BIOBnV/WwRnUiF?=
 =?us-ascii?Q?6jtyV8llZbuYQbEo9slmm6Vqbm1QydWbkjv0VjlBpwsZ93Nm1c9ATZTP2uL2?=
 =?us-ascii?Q?Ny9QGRV8jwyLekRH2BXevFIIgF7oKvVIEBVpyczvgJK+Pf3DKv3n7GA90Jmd?=
 =?us-ascii?Q?9wbdidq4WtXIt+2hustPjETiHfpkixMuNw+zILjWCIHr9BhRiS/uQlM3Id9l?=
 =?us-ascii?Q?hKsdu2xVV6kLaRDrPpV6dB87zJRVd3UoxLU8e7LOZeq6j0m2IjgVRK1+Sald?=
 =?us-ascii?Q?sYFMNEJzDKFFvZnRB+yNsR0DkmKqHegZwx2NAhKrdcTSQaLyEaiCkQ5fkqUv?=
 =?us-ascii?Q?bUFUeZ/kUvQXBTN0cDEaj/AHW39C0lomnkbSyra5bhxZ08vPx6E6Su7xNNxp?=
 =?us-ascii?Q?fZhEHYRksFW9PHpCJ0027IIa8o+gT/9DQpBSJ8pGsmXv12fTFBdEIL7MTguk?=
 =?us-ascii?Q?EEWPczItAIW5mIwAFd0dvYh78Nn+eoVr2nZIT8O+ZmPgxjii4HI72K0wS+zx?=
 =?us-ascii?Q?ExxHCaS4U7CRy4tf7Fp3MDHh8ovO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c/ZIVNHWXPm+FOIWFmlpIrAEd0W1BS4VisB7wgdx7Dtcr1pp++HGKcncdR6x?=
 =?us-ascii?Q?9/iTB9WpHswIsvxGmYTseo6tIyQAueafEqUpjedx20xFX6Gx+FXVPHOjoStR?=
 =?us-ascii?Q?QambcznJykceBtQC8A2Bo8JlUl5hdrctqS1sxjws6NVG5cV1k82nkGIvBLPB?=
 =?us-ascii?Q?exfkjyV956AcLVi7brCSazAD+kJO7CgHO2+ri60QI2KKtA0ioo4hqy0h9IZE?=
 =?us-ascii?Q?/Ye6KJIcuBD/b/EhYDS1m+Ut/izH6i7WfnFP4BGKlQqB78yW7as0jyRLXGZb?=
 =?us-ascii?Q?yz7SS4FcX/WWEn7LP0lRG1jGfMZRDuf8ALhSqUfSlJhMWxTb7asZy6nIGg6C?=
 =?us-ascii?Q?VO8H1YRLYa9gpAPeDDHJpe3t6X0Ufkr8PDv4S6ljcz8SctBcjyAIITfqfbmn?=
 =?us-ascii?Q?ZKbos50BGSZqnHRpKIaKEYLBpWtVRehZHUAE8t9AVayVKwGmr4uc2r2fpT94?=
 =?us-ascii?Q?KkOSXagS8es0orl0awcrcYuyN7guQZTHSkHMC8jf1Fh22Yq1BQBpCpGoY0Z/?=
 =?us-ascii?Q?Is+eBrVM1MB0RMbwSOk2RKRUYzps7IGSR1JXVfHVk5MVAYDMnlU6zfBlUYG4?=
 =?us-ascii?Q?w8Erf0jb1b2gqi0QzU8IuyTlK3a8e4GMgERYVwjUwgpdXTGDBa9QRF73nVMw?=
 =?us-ascii?Q?O0oiyj6h5U344V6HlXx7a8k6uvJHecS4xH92DeXq1bleTHcM60sDnIF0mx0K?=
 =?us-ascii?Q?CrHucYtkeS3KzJZ/qimmx2hApCz1cLDqNlM7nBJrtGrknVZ7Uzffn6eg8k7E?=
 =?us-ascii?Q?+VpineZT6Tyw90klSMUCtA4dkvk0baY74ATPzZi+IuB6dMP1kAV/lJxp/f5s?=
 =?us-ascii?Q?ouBr1pX/f5n6A6zQfbT5TN3ZhN17/OSX1dlUHNN1k+bPhco+bzXgZ0ltraNQ?=
 =?us-ascii?Q?1TAbOge9S/u9R4UpqkmAD+Lr80yczTuJYpjCYdfftNZUHxqrnLElpwYtGOOJ?=
 =?us-ascii?Q?bq+ciTkpDEm5QVbpefKUYfyPMCoFr+pX0pMtbcZpRz6tt8QmSKHLxD5fSRRk?=
 =?us-ascii?Q?MS5FMO96mOHmFWwwEWWC4v/NzRG4daKKXkAb9D3AkCR6dQY9QwITZKCOuG9g?=
 =?us-ascii?Q?X7p0wN8CS6saRkR33VtBGeYEkHCEUjYB2xjTg4cGfSfe3QfDibrt3ASH1GBP?=
 =?us-ascii?Q?3SonGU8gcIIazjeAYTBead4gnLbtP5Zu/Z8JQl8P0up7UnuhHK/1dIFsOOhg?=
 =?us-ascii?Q?r9E8TMvhG48Utmutu3Caz33ip9ByuHW11+VxTgQyj8FSRXk1W6/hVg5VEi0A?=
 =?us-ascii?Q?tEYradm/WdC4MAtJ3J9FX0hF9oJoCZQNdSy7dkj0pyrcrSjDdbH3ETbbhNZC?=
 =?us-ascii?Q?e8AoV3FnBrsP8K9KJL85aJpYVfdnJbIFqozN9u5Ju16+66gvi5UGZCNeJPox?=
 =?us-ascii?Q?DnfA6pHos15hfqxTvyxHyvaIuL7zSaTRQo0Hq+Zfn8purCgAKg1Q6SpwsVGi?=
 =?us-ascii?Q?Lhw9Z7axAH/Lca7YrXpwx3GHgK7/XzHvw335k/3pRs0ol/HHyWvt6yiy8FU5?=
 =?us-ascii?Q?7ZtvG2HEeR8wnJ8EGNwCDQt//f7ViQhtOu/6yEWLdPhtT5uYkqvnalaUNzKS?=
 =?us-ascii?Q?HUwhC5ZUE3M80nBSjfaMot+laYr0JmAk2wV5bgtEHKzC46XodI63YEdWCjQ0?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d118511a-8fe6-41e6-95ee-08dd46207e2e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 20:05:52.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVIoLrQlPbbPUNqU8qw1S1f3roU0LvqMkC78o/dYluT8E6IUcHjdPtXLERPxifHYmuYSLi7hSh+ilD/jNBwu8tA9A08S3lBiOYs0SPIyh5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7377
X-OriginatorOrg: intel.com

Dan Williams wrote:
[..]
> I think there is a benefit from a driver being able to do someting like:
> 
> struct my_cxl_accelerator_context {
>     ...
>     struct cxl_dev_state cxlds;
>     ...
> };
> 
> Even if the rule is that direct consumption of 'struct cxl_dev_state'
> outside of the cxl core is unwanted.
> 
> C does not make this easy, so it is either make the definition of
> 'struct cxl_dev_state' public to CXL accelerator drivers so that they
> know the size, or add an allocation API that takes in the extra size
> that accelerator needs to allocate the core CXL context.

Jason has a novel approach to this problem of defining an allocation
interface that lets the caller register a caller provided data structure
that wraps a core internal object. Have a look at fwctl_alloc_device()
for inspiration:

http://lore.kernel.org/1-v3-960f17f90f17+516-fwctl_jgg@nvidia.com

