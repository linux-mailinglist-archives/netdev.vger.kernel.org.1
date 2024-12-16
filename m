Return-Path: <netdev+bounces-152248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1D99F3362
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AF51884E4A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D60E206263;
	Mon, 16 Dec 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eh3W57+t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15B1E493;
	Mon, 16 Dec 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360092; cv=fail; b=XOKmtoqmk5ZT75bnxvSr8+rTpjBiFKbUvza4jQ0KvgEVngrpTrpoZNQPAOpCxyHhV6MR7F6NE4qmgx7dKcT8IGI96WGHvs4go7AW0Wg8VKhymTnF7h8Zm316CCRsjjHy/oJmYaO25PBhoMPJYjEuvdE9WLYQ+ra8G0Ximzs//Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360092; c=relaxed/simple;
	bh=XUX1gb2bIIwdDGE73r1JPe6C0royt6fXxpeaIOwqtjQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bzsgD2W3n9u7eTRIGSRRc3nV9+OtevEcXakQ+LxgGrLv15+q4EiO/MZFeJ4fxs7bb2WPcBFg1kKTn2i7kxkYw7KJrxecMj6SLBI28DtvOGXbWPU06/eIbvf6JWb1SV4xAvxEv5CkQw4xFuCX/MsHeJwcv6gigkb35T9UsLbmCyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eh3W57+t; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734360091; x=1765896091;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XUX1gb2bIIwdDGE73r1JPe6C0royt6fXxpeaIOwqtjQ=;
  b=eh3W57+tTlw+Qnd3HarQsNMX5dZvuGEBZcB+8bgFfV1txepFHkj/vElP
   6zo5LsZ8qvplk6cpUr3DYUijzrP6mZBfKl40Hef02Qul5ojSvw9C1/y+A
   DLPG5oxY9AQjc98OAMY02Ynl7/7zcK/RK8b6l7dZdXWlIot8ZEHuQ1NqV
   YB2TWsVsBFzKyjVDULwconyhvs6azDY7bI4/LDmBAFXsEgCI+/h84nYin
   mXn+uzcInWtyNhDEhnlAA2mMlovgrFe4//TTpH82+lOkDbjvO4MzUiP3G
   dqIsNs3ZViKHoY6kWaRY2FCOjc5K0XRSHyydzhoBS4xHFAukBdI+rm9Wd
   A==;
X-CSE-ConnectionGUID: QiWe1uBkTIOEWUEG/7Y6JA==
X-CSE-MsgGUID: wRJzzvLURGSfcCA/3dVXgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45230331"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45230331"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 06:41:30 -0800
X-CSE-ConnectionGUID: YcYTG278RQqvW4WB2YMcBQ==
X-CSE-MsgGUID: tyURAmRgQn+60ZrnqLHRdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120467122"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 06:41:29 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 06:41:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 06:41:28 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 06:41:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmrO7x4bYVM0v9dUNRlziXmzsEgPSjv6mqbdoledawFWbIbZg1TNbmmfcy0gXQ/TvbYhfkQlgxLpEOPkS8tmjaJcy7j1MclQ44mzvIGqHEOCLencMP4XwAAZNBmd5wMnQuxhzOMfnD38rQQrZaakurpV2pNkq+rregy02A4fswkwzKUPif2i+Pk801VNH0+ooykNn6TDLOliMdcx3JCIp8Kv6rtyt4ncXy4Ueqb+d8g55wTo5vGsdupEODbGVp7Fawm5nh41bLis0XloUjCybyuRYcIaJLgu/bptIPDIT1g812BjG7TGQ+S7BcwS4m4Dpg/VCxbnVYQcszHNYW73Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxOonumIb+c8HAXS8RB7r7YbKx35JQzUwQn6W3MS5Tk=;
 b=HcHavbfO7gvlwmPj0BSlCoE+XHhZAq8Yfm93C7N9y8/wez9ko0PvxfRlzAGpyjSGUcHb5pmWm4AinihnmoSTLqckt7p2hihV/bdMxat0F/ZKHbE1axZWsb21QdQ5BSLJygtBs5YptytVqLe5gYhMWJ1pskzeCaukfSeW08Y4ag/MDRia91HOXlxUDTfsgoKEdNyIP+MdxXGGPjXfmtcbnUhjg6f+e7ype+Bx8VODXPl/Y/AJdB2IbfnRDFio6RvrEctk6dkNcjOTT2/LcOS0psxDo99K55BKRY+FvIXGw2GyFQ/RMBIJoHsBdhsKzBDJGc4oAFNZ3/G8qkXi+vWoGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by LV8PR11MB8769.namprd11.prod.outlook.com (2603:10b6:408:204::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 14:41:11 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:41:11 +0000
Date: Mon, 16 Dec 2024 15:40:59 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Shinas Rasheed <srasheed@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
	<thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
	<konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
	Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Satananda Burla <sburla@marvell.com>, Abhijit Ayarekar
	<aayarekar@marvell.com>
Subject: Re: [PATCH net v2 2/4] octeon_ep: remove firmware stats fetch in
 ndo_get_stats64
Message-ID: <Z2A7+7dzyNDAgsmj@lzaremba-mobl.ger.corp.intel.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-3-srasheed@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241216075842.2394606-3-srasheed@marvell.com>
X-ClientProxiedBy: VI1PR09CA0175.eurprd09.prod.outlook.com
 (2603:10a6:800:120::29) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|LV8PR11MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b14e46e-aca8-4eac-b40b-08dd1ddfaf0e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7GlelJUMUECH/8XXrW4L7DfuiTasb5sGei2dIXqgDPGfA25UoluXG0CAlF3W?=
 =?us-ascii?Q?sqM3bTVW4jRaYYOwM2oybDwJpEvC+myWJ65uvmEHEoRG5Z+BwDKov/e5iO7S?=
 =?us-ascii?Q?wg54E1CMf0CerSTK6wrbGxjU9s8aUOhOjNwh3BwBQcHDeJL+brYWVJ8WOmgc?=
 =?us-ascii?Q?XN/d3JmQij9t+w5HwgKwfnI+tQw0Nm7RJi4Bj/hy6PRfLZz6Q17bcAj5QqNZ?=
 =?us-ascii?Q?ga3cbs5xt8c4zmRUeph3vNH8aHIXIOzjL7GWOPLJ1TAuDC9q5CPjevJkVo4G?=
 =?us-ascii?Q?IXpcRPZqGHkpslmL711Z3AA60beLhYRshPt0h1PSRDkgL1//zkJSDTFAetLu?=
 =?us-ascii?Q?Ezhbkd1TiDUvtVqLMglBm5JEcXR8kvtN2krDDtmiiHa3rSkFuJzqllRx9Pbw?=
 =?us-ascii?Q?/gsfF5KTCvlWnD6NZzmLHHlT17yxDGTfZagU83f6pHwzwECRF+cwGUOo21br?=
 =?us-ascii?Q?r3ngO04CHKLCtjQVvsP09rTKZL2RLn05qM/RE7dN7JWRU1xDHb21TJFcQ2tC?=
 =?us-ascii?Q?EDS6xybnKbj9XwHehpKb5+wMASg2lEbXutlXkMrRrp7S3RTUNW32rCKyYjxd?=
 =?us-ascii?Q?nL8+qWlTGT4rQkGlWBvKPOS78W0qPSSEZezLb+GBNE+EgdGYyPg8aFuNDx2T?=
 =?us-ascii?Q?RH6b5NsNFvepYTX9DFjL185xVBt1pWVsVqDPNlBEzP/9O9X/ffTegC4FWHYk?=
 =?us-ascii?Q?ERLy0Svahtq8DGs85Hh3Bo9/f1AyYrq34AiF/JFL6A91qoACrmrpgyIrU2Er?=
 =?us-ascii?Q?7eKwPpXq596iFDRbdZp77S8NVXuNbBuslqh5zfjytZcrExvrSvoMGm5iNPKz?=
 =?us-ascii?Q?Pq7/+bZM4B2p45tTrNBmc4Kn+QbdHNRi/+Kv9A9ucNLLeu/HtYzSvKAB3GjS?=
 =?us-ascii?Q?k+Lc805E/8qBoASXZbgIvYm3X2CoMWrnmyQT9RBJ9aU3UwSvAH2M7g4C0TUV?=
 =?us-ascii?Q?av9LSx3eHK60Z470lNpWJMNR+EXcLAjXT3zzKK2Y5yiIQTCvtodTPcnqAtqK?=
 =?us-ascii?Q?uJwFfd2H2mCI5W8AUBfAO6C9RByjzhop2bDAeV8bVCM/5D/yt81vTXxNiFMP?=
 =?us-ascii?Q?7NPH7gY/I0NxV+gzmzCWQqeDazgchkedWt23As6FUkGd5Z72lqpuYpChxSZd?=
 =?us-ascii?Q?hj3OrSasPp2mIBIjqHa+a/9VdAi4dnGJB/2JNqTvenJw4pp6oSIQqbrG9lZz?=
 =?us-ascii?Q?dpdWuFZOkRuGLrVxk9IsP/XWmlmbv/O+gcRMR/ThvDJ3Iik4XjNjcaLZjrvj?=
 =?us-ascii?Q?XoUx+V7rCZsDwbW4FYIVP0qE5uqKKjHhw9kYW3ws2bTymB3qqijAhnCOMW1U?=
 =?us-ascii?Q?fNBv+maOtlpUJ9kCwHm/wP0tP1zeVzfk0x1gjZzkQmGc5k500T2IK4I0YKTY?=
 =?us-ascii?Q?lzP2YRwE+U4sgbb2RbRuBJXwB/Mz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dBqLgJEp5R5rwrAQ6jkGFzI5AQ2EnxOKctmQHRTGQPfjgCZgA2j19SKUNagr?=
 =?us-ascii?Q?jJ4Hzto9p8XGKJUCjbrn6GRsDwz/0ha/g+ZAhp3/zHBQXGKwp5IXtePmx7LV?=
 =?us-ascii?Q?4TwHtFv2ynnN9sUTcij85hvAI5TcbWo5SmWOYL8LpLUnOy2pxDHmqyGMw0xG?=
 =?us-ascii?Q?/SxsBBSNjFFGit3S04hdYVNdH/o5KwJ2TbXWJYelw6SMmY4Bl7v0IL902rc6?=
 =?us-ascii?Q?/ychj5GZ6F9vQVEUFNGErDMJnIFRg7wJx+r66+jGKt+HMRlkhg9R0sFgHffc?=
 =?us-ascii?Q?FL36wAHS13TvennEuW1KnmLqv+jaAjuZVenM+WZa/qXsp7hUsRm3K2RLkHfE?=
 =?us-ascii?Q?toQL0MFpCOU2UhZZdOqAHk7XgjcQ90cQSt7Rznh6qnt+XuPKi3PyhFiKMN4a?=
 =?us-ascii?Q?0VJG+lUABJ1kYXzfKQbpxe8rCCR+lxPTXA3LKWHvGpi323DwxMAEIAB+Se/x?=
 =?us-ascii?Q?MM8377m0ktiYAgoMMy06KoTdgc90O+XDk4iQQgAemhlPa1Lcda07+1DJJHow?=
 =?us-ascii?Q?tt2DIYSNsvi6Lk8/zD96eNnD9UiuPBmxvSU1kH9xrDbBoLDtvi9Q1io9Pw1z?=
 =?us-ascii?Q?IhMeTXbJ0siRUF65MJDg4ilIyDgrXLYhnrK6WEfqUzTdjbHhNAlfeXO7dMT9?=
 =?us-ascii?Q?mqPoAChM5bgv/RV44I/XhIb+6JP1ls6GAzbkKvCdS0J2qbJiQJRz26hHu1zx?=
 =?us-ascii?Q?JFx/NBpH+A7IyAkJ7KVqXsMloDbSrsH8jpT8Aw3wAtlVFwTPkgJLEq9jLutY?=
 =?us-ascii?Q?zBscPaWCgHhC4HKkZC4qceiXJAlfzMbwAz/4A2q+JpVLeeMU74VIj9Pcx5fY?=
 =?us-ascii?Q?u5kNS/JHROD5R65WBTnzNgnrUbbLHo4wKnvgW/P+8gvZrMe5vEkuMjIbYjsF?=
 =?us-ascii?Q?pXe5cCh42oCKY+Vcm6RbJ4PT7mDes2SZbOaoUHqFLzywca9+wqcf0iwij5jR?=
 =?us-ascii?Q?Ef2KKwplWfmL8jZ4ARXOmqKmHg5K1UaCCeSo4hjbL89mWisxLFTkkfUfiiT0?=
 =?us-ascii?Q?Us8w8r5krzK+D9NcyLtCC2F2poLWWlfgkdpHEPMnrscMO9lntBizklaT4vCI?=
 =?us-ascii?Q?dWF1G/J75XZiPswn5zDk2n6RpBqbRRJUHrxvb5JDDZzUM81IppLRe6XnXAr1?=
 =?us-ascii?Q?lCYJYpNqjhrYurfln28HGKGcp3pQh4wY45DI+xKFP46BvGLcXHyKSngzTusd?=
 =?us-ascii?Q?a/Yb/VKqQxnKtsurQaU2cOT0k+/BMaBb61OQYs7BqLhc6xrmiNZf05/WBW8+?=
 =?us-ascii?Q?RBQhPJDb/M7HxqrRGgguscHdVgsbu4nhzQXCiFTJqGoOkEtEyasDl1spq0QE?=
 =?us-ascii?Q?hmGapSQ3vF5NgLb9DQbI6mYfNepd9axOtdKrNFfcv5yqkvZHLQYjyaLa6dCc?=
 =?us-ascii?Q?7X0HADkEPM/QPvzwZYYrfBn5FPPOjMAZI2+xbygUuXdlxvAnha1oD8WIpAN4?=
 =?us-ascii?Q?8CbpayM1yHji+Z4adiGzP8Vemyiz1PCFa2PqjQAGL9bhmTpIq45C8aGC44kv?=
 =?us-ascii?Q?GdmkX24JjDUUVH3R758FxOxw3MNKwNV36CdTJsblEQUx+942YnRPdKq/A4vE?=
 =?us-ascii?Q?WhNxXIJG0hYkXeVB8KrIh+cYVUnyxdu/f5Pl7gas+XQ3pMYHQDcI9UsyJZRg?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b14e46e-aca8-4eac-b40b-08dd1ddfaf0e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:41:10.9639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEcCONEf3XXnaTqWmYrZ2Fbe6eOoL6n/FvYgs4/3T5qECMe5gwFCg+xQFSGFTNtuIR38ApfPwpGMx+IzQUStfaOWIBOgdvibH+/U02ZpsFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8769
X-OriginatorOrg: intel.com

On Sun, Dec 15, 2024 at 11:58:40PM -0800, Shinas Rasheed wrote:
> The per queue stats are available already and are retrieved
> from register reads during ndo_get_stats64. The firmware stats
> fetch call that happens in ndo_get_stats64() is currently not
> required
> 
> Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V2:
>   - No changes
> 
> V1: https://lore.kernel.org/all/20241203072130.2316913-3-srasheed@marvell.com/
> 
>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> index 941bbaaa67b5..6400d6008097 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -996,12 +996,6 @@ static void octep_get_stats64(struct net_device *netdev,
>  	struct octep_device *oct = netdev_priv(netdev);
>  	int q;
>  
> -	if (netif_running(netdev))
> -		octep_ctrl_net_get_if_stats(oct,
> -					    OCTEP_CTRL_NET_INVALID_VFID,
> -					    &oct->iface_rx_stats,
> -					    &oct->iface_tx_stats);
> -
>  	tx_packets = 0;
>  	tx_bytes = 0;
>  	rx_packets = 0;
> @@ -1019,10 +1013,6 @@ static void octep_get_stats64(struct net_device *netdev,
>  	stats->tx_bytes = tx_bytes;
>  	stats->rx_packets = rx_packets;
>  	stats->rx_bytes = rx_bytes;
> -	stats->multicast = oct->iface_rx_stats.mcast_pkts;
> -	stats->rx_errors = oct->iface_rx_stats.err_pkts;
> -	stats->collisions = oct->iface_tx_stats.xscol;
> -	stats->tx_fifo_errors = oct->iface_tx_stats.undflw;

I do not see, how it is a fix to remove some fields from stats. If this is a 
cleanup, it should not go to the stable tree.

>  }
>  
>  /**
> -- 
> 2.25.1
> 
> 

