Return-Path: <netdev+bounces-188424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC553AACCED
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64983A47A1
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F879225A47;
	Tue,  6 May 2025 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErKqzxRq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262D1917D0
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746555367; cv=fail; b=ZIcljtZ/Fe5hvAj+Bul38BPRs7HHfXmoKESLkpxzuQE0xB4cP0A8konHJ6gyQv6ioiyYAL0fAxsPpRSdmLxn3YFZiNpz0DYZgwtdIUpqYHh229qFEq9nQ7iJeK9LR1REPZoq1ZDvLRoQKBWqlSgW+z5PMZD36ldtLHiMjOUQlpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746555367; c=relaxed/simple;
	bh=t7PsYHnCTe622+Ml0NIEJW9VwQ5adm969VA9U1Lp6gU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b60VroSQO8ZAz2F/jILyWxC3xiOLxA8vGdyMTP5rcGExxfJnrs3ZxXOBRL2U4PiJn0xDHDl7xicPn5IDokrMXfVcEJi7j9Lv2PxAIm4Y0kmCYu8aWBVZmi0fBXcxEeJqFE8t1To4q7LLNwuKFrSZi1HKe0stk+J4SSu/ZF/5nxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ErKqzxRq; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746555365; x=1778091365;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t7PsYHnCTe622+Ml0NIEJW9VwQ5adm969VA9U1Lp6gU=;
  b=ErKqzxRqE8QxJX2tV5rkPpYiYkLAo26Cx9uwIjlbx1JbFMfUdtgeu4oF
   EegID0QUZPf0WSDA02+9xccsJyOFqsbcty1J53H48CwLYiDQusCHywLzg
   44wklAHYboDY1vql6DKJ39VN5QCBeTdbEE4ZpbGXu5dWVV55OV0fC3Azi
   XBgt0Ve6abIKKDFWZre5B65I8ORLQUz7XOc8MSaMaxGxIa+RqZIuq4axq
   cmxE/ud8wfQxtOrF3oqvC+7fbkxhdQM29xEYUCOEDQ1A9Jug6abCsZO0L
   hLyZ1vWZlLPAVxuTbFB71A6XcrH55tHnTpldnqwHwERMnIQMkHPgX7SMm
   Q==;
X-CSE-ConnectionGUID: I5YNQ0lmRYeyK7R0rY5zWw==
X-CSE-MsgGUID: RjdP4CUhSF+ra8A/dp9UVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47504403"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47504403"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:16:02 -0700
X-CSE-ConnectionGUID: c9jvbMiESCyXxNMNQ41C/w==
X-CSE-MsgGUID: +D+shwyOT2+ObY0LBugj1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140887477"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:16:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:16:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:16:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erglP+QIpdonwbBpD1pBD2ArMje3ukI3miQLanerqlZ6tvdVGMgaHeXH77ha2+vlBiUGMSvFSXwEg3qxk0OYKhfBKkj9xEcwDC/qtWdO5XoI1aODezkqNXZyXQ0zMXrYFd04BR1TrwznBo3ThrFMClqyAFohbb00xdeQt37d536YZr1wLmYPaF9cKmfErHmLPh1Nn16rXvxE2RuoCm6dt3q/oDI6UupOhSyiRRtV5Il1XLypQY8IpLrrfJsWnTTcUDBQb743vQ90yYo/MxqOpHk1m4m/zF0+v5urshBcRR0NHvwnS/rvO4e0D760b3DMGePNop/eXy8L2hdYQ0qesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ow9HgOvTnx34p9wqnsdZYFGFb9MJAVbEnQbslIwUyw=;
 b=CQnjLtHAcSWm+MvFP4RrwRNflqy1uKZQacXc9gYACpJRKcOKpbI97RDvatrBHuPuzuDSsmZrUa6lkeSFox35ZjMhaRmTly03e9pxZnjyPALTRwE5Sk+pKEG0QrpyI9eCArww0vD1UXboJK3W8cJqaAmQyqTGc9tLdVwZ6MbTWYLlEwM7iF8HRlcfZ+MV/gy3+7nSRc9/BRVnkzCyP8p5X9xwUUpGO6k9mpIBGsCHFMpAUhXIM4upJT7fQ/0xTFGHjatVSRbWfG3SdmNr6x3WwCF9OAKjj8rDDCb4SwQHXc5bJx/M7lc4H0RB+0aRlUUAkhgN2nT0pWCAd3h8bYIMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6943.namprd11.prod.outlook.com (2603:10b6:806:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 6 May
 2025 18:15:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:15:40 +0000
Message-ID: <84a6eaff-dad0-4f69-9a6a-0649c9b3f7a6@intel.com>
Date: Tue, 6 May 2025 11:15:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ibmveth: Refactored veth_pool_store for
 better maintainability
To: Dave Marquardt <davemarq@linux.ibm.com>, <netdev@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>
References: <20250506160004.328347-1-davemarq@linux.ibm.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250506160004.328347-1-davemarq@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:303:b5::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: fa995b36-a08f-45df-a047-08dd8cca01f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlNiNU41UE16alV1WThxSVlENTdOKzBFY1pTd3Z5a3QvT2d5dFQ2bVRJK2Mw?=
 =?utf-8?B?bmx4MHhSREJ6bUlMQ2g4TkQzY2lyYXQ2RDc0SHBtbVhUS1FvOG1mNmd2Tjg2?=
 =?utf-8?B?SFBxV3dxelZpT05wZGVVczg0c0tmYnJ1NkhYakQyOFFnTXpZKzlkUjNCYU5E?=
 =?utf-8?B?SWVpTUxPSW1ZODFhVnRTSHVqOWdiLzExMkRLbGRBdU9jYWY1ckoxcmFZMlVX?=
 =?utf-8?B?dUtlMGlMZ09uU1AxWk56SnZQVGNURHdZYXJISURYZ1QySjB3dVV2eEIramE3?=
 =?utf-8?B?aTlveVoyNkFlY0Q1YnR1cy9ZMVBQdWIyYmtSQS9ZRjZwSE9adVZxY0tvR1pL?=
 =?utf-8?B?V0kxWjZzdDJ1UCtIMW9LNEdHV2plYVpIMm9NNy9MeEY5b3AyNEQxV0dBc0sv?=
 =?utf-8?B?MERvdmU2YzNPQlAzRlY5aUgvMkVNQytPYVlZMTE0TjlFV0ZNTW9xRG03ZHRw?=
 =?utf-8?B?L3Q4NEN2dmdyZDk3SUdzRDJhbVBXN1lMamZ4QzgxZ083QWZnMXMzR3BxNnYy?=
 =?utf-8?B?TDVrdjgrVENwc3dQdWJsdHVoaXg4WWQ4UFlyUTRQajlkcmV0ODVjcDVsSFI5?=
 =?utf-8?B?RG5vdmZqK05EZ1d3YmQ1RGtGdjNHTGpicjdoZzh5TDJ1ZjZhYjQ2dEFSS1N1?=
 =?utf-8?B?OGF4MVJ0aHFwNWhGUWVQSmpvNDlwMTJ3Tk5kUHpmWWNCUXdUTlZteGVpdWJx?=
 =?utf-8?B?NDBtSHQyZERBYmFJeHBzbUdWZkpuSWNYZ2RoVW4ycHJqWnlzaGNiRjF0WnBH?=
 =?utf-8?B?T0pQc3NROHNvQWh6ZFRqNFo0RjJ1MTk0QVJqUS9vU3VFbUFWaTUyWU1TK09W?=
 =?utf-8?B?dVI3cjRBQm84Q2tWZ2hZMUpvV1hrK296OXlIbzgvNWZ2L3BDREk2V3dBQTJr?=
 =?utf-8?B?LzRrQjJoYW9rKzByekNNT1FWRUhIazVtYytSKzdXbFR5SmFnZE9ZVEs4YTJr?=
 =?utf-8?B?TzlsNS9ONElsZFhrWWUwa1NUZnMwSm1NYys1M1R1RGdvbDVkckZEdDJoS09w?=
 =?utf-8?B?bTlFM3luMUpjNkp0VEVYZUliVmdDUjdCQ2l2eEtuTE1GZ0FKR2RCNzlYWlA4?=
 =?utf-8?B?aHZQdlQwczBjaXpEREVGZnRaYUNSYzhxYU9GbWwvSjl0RUx2ekpRSHhHSEJ4?=
 =?utf-8?B?WEZ6WEFKRnhCRGhuTm1GYnpLNHN5ZWZrNXRWV1FjNFliZWppeDZaSy8zL1hi?=
 =?utf-8?B?aEpVOWxFQVpicjIzNEs4Z0t4c0paTXlUeGFCbS9qLzZMb3J0cEVjUSsreDZy?=
 =?utf-8?B?Qmx1UkxPMDlNbGw2WFpKS0V6a3lKN2IreHRhU1lCNlRrOXNQaTVrVlZKWHc1?=
 =?utf-8?B?WjVTa1lWNGVJL2RRM2FTOEdNeklZZEh6WlovMlcrWm8xTUpQWHdmY2h6M0ZB?=
 =?utf-8?B?UXAxZElvTEJtWHZ5a21iMk5BLzZHRXVGTHpiclJxK2cwdFovcUJrWVUwWFo2?=
 =?utf-8?B?bm8rd2tCeUdJV3lOaU5wL0FEUVZ6WWh6RzZRQTBWa3lZeXNROFpQWktNUnZD?=
 =?utf-8?B?emJ1VXp2dTMrQzJWSC9QeU1na25nVFNDWlpuNkgxdlQ2RDNvNFp1bjdsWUNi?=
 =?utf-8?B?Q0U4ZnRNMWtBekFjMm8yTVBUKzNMUkFPUytBUWthMFN0UldHK2xaVG1KWXZi?=
 =?utf-8?B?TDlaQXJHQ09xS1YwcmkvQkNwOWhKKzFPQnNBcnMyNUZQZnRaUTROR2dUQXFw?=
 =?utf-8?B?U2t1S2kyRmpCUDJ2VnJSK1VDMlhqdFBraDBDNkhsNmZCdWpsSm93cDg1cEFB?=
 =?utf-8?B?a3RQM1Y4cG1nUDFqZU5BRGt5ZVhESlNqMFBHdWRCMFpXaFlwNlZnazAxcmpI?=
 =?utf-8?B?c3lENVpGSiszS0FxY2Y2aERSSnY1bFV0SWFhN3F2U3lad01tb25zd3ZQMkxN?=
 =?utf-8?B?L0doOWRGNXFOVWd6ZmJ2ZVpIZ25EK3ZXeEJXYTZxSnd3eDE5L1pTSEhSdkFh?=
 =?utf-8?Q?4tUjeQ5xnzc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjViYjR0TjNuRC9TVlBqTmtVZTA0MC95VzhZdFFRNDFBemc3QW5pZlRKSk9Z?=
 =?utf-8?B?RFAvbmMvQTMwL1FzdWoxc21zeDlHOFZWeGF3cnpFUkpvV1JreStaS3QxUHVE?=
 =?utf-8?B?ak91T1ZTMFUxRFZuT1lkUTRJdElEeGhZN1oyNFdPQUozWDBBcnR3VUFCamRY?=
 =?utf-8?B?QjBGZ3FXc2l1WDUwam5kQ2VMUGpmdjRTakc4V2thd0pGMExFVjlRcHQ2ZTBC?=
 =?utf-8?B?am9yaXV5OXh3bDV1OUpla2xrcUFFMEJ6SkNXY2JZVXVJOWNiZUdCczN6Wi9B?=
 =?utf-8?B?T3BFSkZtZGNIWmxVZ09URkt5cVB6NERnbkRpeGp3bWpvOU5pM2FyU1Rhb2dR?=
 =?utf-8?B?dWprR0RLRkhLWGhTNnlhN1pPRmkxY0krdDRvdUFkbkVQR1RFWjBhL3U5S2R2?=
 =?utf-8?B?eGtKcW03WEJ5ZzVwS0ZaUmxDMkRSa0FJS2RZaHhybDh4Y3JtSjhuZittZ0tP?=
 =?utf-8?B?VkZJUjdOeUprOFZ4ak9OcjRIUW9RdVVnYjlBdFhZTW9XNEJDUWIxTWhMZ3hv?=
 =?utf-8?B?RExPSEgvc2JQc1MvaGIzT3R5U0phdHRKaThxWGQwQ3ROcVMwMkYxQnpVVTFu?=
 =?utf-8?B?MTVTODRGbHpyeW5oVkZRZ3lwK0gyVWVwNHVXdjFabjYyeit6SlZ6SDloOVVZ?=
 =?utf-8?B?TjJGZUE5dFFHcjR2dDM3bnBnYWl3ekJTNU5yZ1RWSUV4RnltRmt3R3lpbmpG?=
 =?utf-8?B?RUtlaE9WbzVEYUlzaW1DNTlvKzBWVVI5TlB3YmJ0ZGdKeWsxaWNlVnRodURO?=
 =?utf-8?B?Y0tQeExIbjV6MFljMmo5TXF6clBNTmxacWcxOHlqSWFoVm9nbm9ZMmU0N1Fy?=
 =?utf-8?B?NVhzQ0NuanBYMHI5ajh3UlJLbCtVWHZBSEJvVEtMdDlFclRzT2NzUDNsNmth?=
 =?utf-8?B?OXVJV0daZ1lINWFtaWNhR3kxKy9wVm03VXJnaG1PQkpKNy9TRDVkUDVadXNa?=
 =?utf-8?B?NnNlVjhBTEFNN0J0OGVMZUJpOFJ6b1c4MjFpR2xZQUMrWjFHNmN4NTljMDFH?=
 =?utf-8?B?aEJ1bDJya3krT2JXajhPcHJsV0xsV2xhMXNzaTNDVnlhWUtWS2ZqQjQ3aVNp?=
 =?utf-8?B?WGJpYlVFR3lFanlxUVlRYUVWaHA2bzBtMDNKc05mUEc0OWV2MXpUSTN4MTdq?=
 =?utf-8?B?bE9tYk85UnZtWkdWdEg3dk9sNitOYVVTWWE3RHg3K1AwT0x4VlJueWZVTVNV?=
 =?utf-8?B?ZFRrWEtEeHR3bkl3cjgyOTVkZjlDSkl2eE5hRHZ4YTc2eEN5dGR1SDUvdFBw?=
 =?utf-8?B?VFFicWxUYmdZSEVFYiszOUE3MldaTWdPcW1FOUltM1BTZkVJU2dkV1FHaEti?=
 =?utf-8?B?MXByYmxjTnlIb3BzTjhaOUdTZm9Gbk5uZjlRbFF1MDM5SmhnL2pYYjZQNWFR?=
 =?utf-8?B?bnozWmo4bUtLblF1NTVpSVVGelFIbFRSUjcxeWtxMVNBZFdTbHEvOVlNTGlw?=
 =?utf-8?B?NmM2cDhIWHdhQlF2UU1mV0JiajR6NzNlRjZZN3ArdmJzazVrUktONTg3R1lW?=
 =?utf-8?B?bFNwR0M1aDZNSmlkQ3VobUtwUklQYk9aeFVzZFNnd1JFNmlmdHhTYzVKYy9W?=
 =?utf-8?B?VFoxS2pwQ2NOS1dlOGV4ZVZUMU8rSUlzZFVxdGRRbURjdDhlR2ZNSUxuQmw5?=
 =?utf-8?B?NUowZFpaZkIyYVlXU01ZTm5SZVJ1M3BLVnBmU2VhZkNHeGFsZitsRFR6VWVG?=
 =?utf-8?B?VjZsQkpSOUVHZ2l2QW5NY1hiT0hJN3k5ZFh2Zlh2TDZQWW5BRlA0SFczRFF2?=
 =?utf-8?B?djBDOXYzbS9EOTZOUmVmRENmenZuNFZLZlJlOEhJaUZvWWU4b0x4cVAzWVR0?=
 =?utf-8?B?bDJjbGZ4QkNUaHRlQlpCeFgrMWtWWUpwcDdERU1qU3ZtYXV4V1NoVlMwSStX?=
 =?utf-8?B?eTBOVWp3alArOC9Td3pLUlJjQ0lIbDY0eERmQTVDYkZNSzZubk8xL0pvQm1M?=
 =?utf-8?B?WEd2QkpyS3BqSHVHS1h3L0gxZDRPUnZuQ3NacU4yMnpxaUNTNGZlSWdTNGE1?=
 =?utf-8?B?TXRQOVpkTUJNWnJLMmZrKzRmVDhBZEQ3dlkwTHk3WWRCYmIvVitOd2JjMU52?=
 =?utf-8?B?OXN6S2V4ckVHWGgya3JVWFFQWEhtbnhhcnNTQjdkUG5nMGVaZEZpZWExbjZl?=
 =?utf-8?B?SlErU0MxK3BTTnRjc3JTYmliLzlMK0JIeEM1VlQzM3VmYWpreUpJUkk1Z3V2?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa995b36-a08f-45df-a047-08dd8cca01f4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:15:40.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Iy/WLJfWd4ALuTaZmSDNYjhqxAZz96BaZZnrwtNPh8vfyzjmGnj+M7x4tELrwf3FFJKcf3XlICNQSBsauZXAjKxAqlPtx/wMUiJdTSNMhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6943
X-OriginatorOrg: intel.com



On 5/6/2025 9:00 AM, Dave Marquardt wrote:
> Make veth_pool_store detect requested pool changes, close device if
> necessary, update pool, and reopen device.
> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
> ---
The diff itself is quite ugly, but the end result was much easier to follow.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

