Return-Path: <netdev+bounces-167125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065CAA38FD7
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4667169BCB
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAC2653;
	Tue, 18 Feb 2025 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgW5ycLh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96861196;
	Tue, 18 Feb 2025 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739837042; cv=fail; b=q6UXFZZSyRZMucO3Tgiwjulp+7G6yh80Pnqp+peq1v5ScO2hlUAi3tjewB3Im7nD939vYoR0mJYhlfgNYxKfsLmv3vKWEzoBLJYrh8aidDOO/1Za0ndZ7PjaICZ3PQfH9iaKSPZiJQtmWrkz69Ca8xAfF7P3r9K8eriAEaXAA6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739837042; c=relaxed/simple;
	bh=2M7XrhuW85xiXNSvxMVJaZCvKRAlDn0NfjMFQIwahm0=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tqEF5rP7hmPYh/zOAZCo0Wdt5kpnZmsqLFgPOHhxI29IGuSh74XVhbhosHT1hldLsQ4VN7RUCF85Vk25DTdIjf/e69Dg58okZ9T+P+OFsXnP2zSvvKvmuixnCD3306CGFd+gKdhv4D8oyDRY6IgkUp9N2uMNc1WbveK3gvTTIHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgW5ycLh; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739837040; x=1771373040;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=2M7XrhuW85xiXNSvxMVJaZCvKRAlDn0NfjMFQIwahm0=;
  b=JgW5ycLhZzgcosaQ1OXsz2vNfSfHFFcf0nVgRgw+1WRu6rodcpqNL7rV
   rZF9VbpWT9ERwlU98ZnxYCZgIzKXZTLKZXd0gKWZ2fE2p9yIUtEHmE2YI
   lftzs0dcYXaQhimMcuH14yO4XHucVCCH52cDxB41MELy0CmxigrNTPfNb
   fddiz9nyJxTpsucUVlDvQ8RBWVsmpZHLJY5F1Oy/bfnkOHULxtkecjSYb
   VSo0Hm58icvscr3fpxoscMH97rcYAE2gL+EEx+oVs56uDrz89o7EpkU/q
   J8W3Y/9qAesvmC8bs3lc5cLDsDv8Q5E0c/LypTtY4aQc5HyyevLlZtomk
   w==;
X-CSE-ConnectionGUID: hZXXmQbKSaqZTCBuJZTxAw==
X-CSE-MsgGUID: e3pOnwn8SR2/r2nyN6NZPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51164424"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="51164424"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 16:04:00 -0800
X-CSE-ConnectionGUID: B8HQ36fxSYaOxWUmJJVzUg==
X-CSE-MsgGUID: nXk+WnoASAKw5QMuYJfWJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145142646"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 16:03:59 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 16:03:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 16:03:59 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 16:03:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9SO+pHaQIPDfS/SoV8mL14IzDMra+9uqFVpGgBGwr9Mx78AAPhiDVgV5Dz73oMguKYNQPMoUeohEYJKW3Kaqz73S3DUy/w+EwxMHe5T74oSJZ7ZFtQw+ZOk4i6NhI8OBR6+OBvo7TeDzCepJK+NqQZFQjNM8r/nQ2x2YV7TjiIi8v7pztybj2JNfOzDykltvr1QDmhs5wmIH1+s/n7pwpoosoeMJVkv6LrKv5AWJmgpquHMCyzAkqD+dcdycKkQQxAFgz6YrCcIY21ISEcmob6i8nTLTauUvOWpsQjRUS/PCbPGEBKIdgJgcURaMNPpv/aiTXs2Noq72X5gWW/WbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PPVnP/RF3em1X96EL4fWlCgl2KIO4RXsZ2jwwAX4sM=;
 b=DNrfdyatmcfKWCsqlwTva14Jz8pSDQQA859WqWUceWigtohfdFCwHt+yjeo0171RQyXjb2OroQrcbNfONjy+8dwgYh4YagU5thDB7nAxLJ8vBHU4NcV670ESjU7rcdAkHHmrZ5A+l8olOjBw3L3llxMlEP1wniSaaQKlmjjqR5A30riNGngZ/m8DCLjgsRFGKJECRFQH4SAiGyKb1AMRfagmBX17sIt4i6XK5QBOmX9PYMhijU6+p3+HOxoV1NAivkQYP/52XSN+yqNFKz59l+1OQFMTndramas00LnmdZ+6kqHXIKEtmNV0w1c/Mr9mLegjPio+XT7BX/bcSPuvAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 18 Feb
 2025 00:03:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 00:03:08 +0000
Date: Mon, 17 Feb 2025 18:03:02 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Ira Weiny
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v10 15/26] sfc: obtain root decoder with enough HPA free
 space
Message-ID: <67b3ce3661a39_23533e294b6@iweiny-mobl.notmuch>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-16-alucerop@amd.com>
 <67a3ea6d8432e_2ee27529434@iweiny-mobl.notmuch>
 <62a03ffc-b461-4097-af03-25d4cdd1388a@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62a03ffc-b461-4097-af03-25d4cdd1388a@amd.com>
X-ClientProxiedBy: MW4PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:303:b9::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA3PR11MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b68056e-a365-496b-2383-08dd4faf9fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qc3ISYBRBLgCzrs4oVnsC/aZeFYFzU0bHdC+g/Bj6ZpCpVvvLPCsYgZIPIWW?=
 =?us-ascii?Q?WG4R4kFQ0CM/W5n6ADbrlQ2HWNbR9asBzZTlZIXgEHmhjmmZB4JA7YylN//w?=
 =?us-ascii?Q?bcQAYlSqYMKgEJJrTnojAP3ZRpAJVzvCw07GBhjByc15V2KtL4Db4zag9IqE?=
 =?us-ascii?Q?So3LoLVoMDWbBrJj4bfsIuCF4OTf506b9iKpazaHkTn4PhofaQaMhG2hnRUV?=
 =?us-ascii?Q?8TudBVs7Q9VvRGM/3yNM3Xs/Y0nplrLn4gQXNeULJGTABHgBB8qPgawDznUp?=
 =?us-ascii?Q?/uBC+jG36heJ50REdBcGwMmPMnL5hvsXOYPDsNBR4REywEinvMyzDRTVcb2I?=
 =?us-ascii?Q?87QfiSt2rbFUP46BAF9gzNeOzIZNfAiUK4O1DX6Ut9YWHk76ORAhh9zbXD6e?=
 =?us-ascii?Q?AsIkTJ2E6/T+JAm7Lz3eEGKZYjJyI8HXtXEK35pEnAPMgf9WsG6z42Ry7kg1?=
 =?us-ascii?Q?c1f/bAB8PZg/mSlFw9yrmuEQW0AlnnMXCtTXDbvS52ZmP0NT0wyoc/0vBfGs?=
 =?us-ascii?Q?ENmLidILFuWnldMIVEO8Z2v0Wdsnad06Gl+8cT55Zo0Iug49jai47uZ2PLb6?=
 =?us-ascii?Q?L7/Ghlll5pT0Y/H/Gv6gaSAmUnyDgbzya5BRSYJAQl2Pz42oAinlH58VSKMm?=
 =?us-ascii?Q?GjJ3sLSU/mhS6HJSJV/O5y6rv7EpcdNdIkIrfjE+xXXtpzEHTRSwyUe0vmTu?=
 =?us-ascii?Q?d2igKPz2KgcRulARxQdfgF9sKsi2iasRrqkFpiOblHCtAjLoVLycog8woWW8?=
 =?us-ascii?Q?aLyy+eamB9NCos/ebbFsx6/XBtxvjAkO7Z3qtVOD5UYFKSgRkNpq3vvR8OmO?=
 =?us-ascii?Q?P0JMgIY4SzbgD2KjTn/VDdHXX+kTVbvhIGfEXoexXtvF9RYtrkB9QQkwrrUW?=
 =?us-ascii?Q?w339fZJePKNWMY+ePd7a9wjyAeaSZUIfVMQdDQ2mmrbrHtNSGp8IAIXMjcJg?=
 =?us-ascii?Q?sfCAkH4gjKW6x4hFgq0xksDlhy9psbZmA3NuwR7qUcoNmvQTtVn4XlU0Qd7Q?=
 =?us-ascii?Q?1bHxe19OX7MaiHBzx1BSRMBfIDyGTRW4uOXIIwYfMowgd0iyJvropcctbCvG?=
 =?us-ascii?Q?PFMIi+8HPXoPn3RbHaK2Knc6FVWxyJ+vf/8S629GurDe7/vE4eN+tbfdicYT?=
 =?us-ascii?Q?6APNcbcDFYeOF2aEf+vNzlC4aQiSOak1cQM41HGQWLQyqsiWkTVbVMiEsI2g?=
 =?us-ascii?Q?owFyK41iZwHmNM33sfemdFq3lur4P9FdVJV4liMl2z+o8kZorBtc3yG7NzhP?=
 =?us-ascii?Q?FZ0UWKGmcyTaeMsP4cfQ251Lp9/cmWdGiBRmWDKVP94HKa+foaogqkQgitbz?=
 =?us-ascii?Q?MKe3Xqysx1Uwh1PgrDH924+mQiP8gr0whRqARoNnG0g18PKf7r28S4B5RgdL?=
 =?us-ascii?Q?I38OfUQRbjr1hdqNW/kv0JrbdjDPOmU9wzn5mZUvBraihbAGWG33jTKQMvRl?=
 =?us-ascii?Q?9UMJyQeJr68=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sozhsEU8wWgdG0RvDlehbCICDV6ScnYBfnyjcDzSyVb9kHSOTab4ZYU2IXmF?=
 =?us-ascii?Q?GNgolnM1S+54tX7InE7az34jwcfNP26o/P2ZriKOe+AA38FVYd0zfqoqmi+B?=
 =?us-ascii?Q?fRJg5u3chqXbiEP5h0bk1nICXAB//6ULpwn78Z6E5GgO5yiQKYAFZLMtcYUD?=
 =?us-ascii?Q?x1Mykh/jOJoB4F2Xo4s6YUVRpdFuN3yDU8VDCAd2CyQLXd1BR33cvY6cJceN?=
 =?us-ascii?Q?OV4wU/FmHGnZojy8NCSopUsVD9252GFdE6fmUIsc4wzRlVSvJ7MkwW1CmRld?=
 =?us-ascii?Q?GgGWQBQ+wD3fR+sbWYyGTSgynR0Rbyr89GTS/Uzg0RMRetef5WsqAYoI66xK?=
 =?us-ascii?Q?ojpN3OYT9dstbM9ce9KCm8KrsPEWs0AcNnWPqszFLJIPpOAIVGkXBsIy9ZS9?=
 =?us-ascii?Q?GTer1Qbtt+6qsArYwYI2Xl3YKibllm0pSRptstMM8lReIMKDY5IHnpUeI5Uf?=
 =?us-ascii?Q?3H3TeVplnVXjiKboCmh4dckmxih27t13L//HsCHuPcUdPqlmEao2mmkXo2jR?=
 =?us-ascii?Q?9SUMUun4QaQbbsJ7PGY7XZCBYE+td2sQD214UWY5+gkeeCgtykfC/dXIqZns?=
 =?us-ascii?Q?QMD9Dut3yixdOj/83q+qfc9YGQOa+YQln5AnyaSxlEFPG6bBk7VwVCot6nv4?=
 =?us-ascii?Q?6b9OsEy2PKV++DnxcHv1YGaVI0SEhqdFjhS8IZgGlasCXqbcqIICPy/8YG3r?=
 =?us-ascii?Q?vk0V/OZl6rCkqZnxGVNQaywuAlOX3hfP3U/VbSjUhlYG/OqzoRNaWj0qmWht?=
 =?us-ascii?Q?VtNLOch9L6Ktvll26oqP1i4Q1g5r/sa0kpRqUIsSAACLNVXwUguMJKRsMhqA?=
 =?us-ascii?Q?kgtJyTBk5ox+Q0wP6b3ACegI1fQUqMVX++PUzIaQH6X2xR5NZmvwhIEdy7W5?=
 =?us-ascii?Q?Kt188hpv+QJQZK5WgyPQfb+AMLDnOQcMfcMcnIqeuI8DGBkeQPiax5L237JT?=
 =?us-ascii?Q?mkYNYloh7rbaJfzlGwsjdMNLRHX9Cbo3Q/KDyVL6J5rnTm9mI9yKe/4TfDOd?=
 =?us-ascii?Q?ZV14PkMJWvNSxfKgq6VdgsRfK8HTfygMYndMHr8ApTUniUbTDQXI7Qb+Xm93?=
 =?us-ascii?Q?hgl62ppp4lzeUDaNx6/5xCFK5flZT/O3p2I+jHyJIlDfNZkEGUHWk0GgNUOS?=
 =?us-ascii?Q?8+pbuC5WBMT4kX3ZoqlEaZer+VyCaOhaOd4w5i/V0L1a09rkikWRuZVqCl1t?=
 =?us-ascii?Q?bjrZRXHLSXcsO7gVFhgqIZ60vB+/7vUCUYVAPhv4KUr2QFtM3WnmzYkae7AV?=
 =?us-ascii?Q?ENY3t9dnbKbbRH4wCHiO4U8hb1vbCjgXBZOEMW9LZOIbur3535fWnDY6G7b7?=
 =?us-ascii?Q?qHVvyNvSzCQ0ZVw2bpcvVb8zA/EFOHTQqPgqs/8gQ5bFs+y/UEJTxKbGJnb4?=
 =?us-ascii?Q?jGAOqA4loHjjBnn95cRFy+RZ8ZwHTSRgdZm/uW8xT0F8k+9yJTdLA5APEHvd?=
 =?us-ascii?Q?Lf2OMhRNnNkZ1jVSLsF5p5CQZUg8oA2rSvyukbq1e+ouETFP0WBp5Sfju1hy?=
 =?us-ascii?Q?rK9BwA4JlxfRGNTdJyybyD/XRR5TToCyIf/4jMFjbHoH2gglkM9YI6UChj+s?=
 =?us-ascii?Q?TzVnJtb9nP/d5GHOTIf2eAMuE3NEUHgPHpvrZOcI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b68056e-a365-496b-2383-08dd4faf9fc9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 00:03:08.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v43Z1T6enAJxGuACxuPMAW/ZwgyppzUSlqL14fDTywbtnm5h2cYMg6nijlr2ezWGn2Q91RQ9ISI8BBmGGsmFDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7527
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 2/5/25 22:47, Ira Weiny wrote:
> > alucerop@ wrote:
> >> From: Alejandro Lucero <alucerop@amd.com>
> > [snip]
> >
> >> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> >> index 774e1cb4b1cb..a9ff84143e5d 100644
> >> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> >> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> >> @@ -25,6 +25,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> >>   	struct pci_dev *pci_dev = efx->pci_dev;
> >>   	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> >>   	DECLARE_BITMAP(found, CXL_MAX_CAPS);
> >> +	resource_size_t max_size;
> >>   	struct mds_info sfc_mds_info;
> >>   	struct efx_cxl *cxl;
> >>   
> >> @@ -102,6 +103,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> >>   		goto err_regs;
> >>   	}
> >>   
> >> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
> >> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
> > Won't the addition of CXL_DECODER_F_TYPE2 cause this to fail?  I'm not
> > seeing CXL_DECODER_F_TYPE2 set on a decoder in any of the patches.  So
> > won't that make the flags check fail?  Why is CXL_DECODER_F_RAM not
> > enough?
> 
> 
> It does not fail. I have tested this and I know other people have had no 
> issue with it.
> 
> It seems the root decoders needs to have specific support for type2, so 
> this is required.

Ah I see what happened.  I got confused thinking this was a new bit
because you defined it in the new .../include/cxl/cxl.h.  But aren't these
bits are already defined in ../drivers/cxl/cxl.h as the decoder bits?

If so, we will need to promote those bit definitions to the common include
file rather than redefine them.

Ira

