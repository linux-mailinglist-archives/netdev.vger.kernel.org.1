Return-Path: <netdev+bounces-271351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELI4GetPw2lGqAQAu9opvQ
	(envelope-from <netdev+bounces-271351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:00:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE4731F009
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48CF93057EA0
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 03:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE09270EDF;
	Wed, 25 Mar 2026 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1V8yxR/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07142CA5A;
	Wed, 25 Mar 2026 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774407601; cv=fail; b=n5fBKsxJLccTrBTx4xx2LkJbJmovAC6zJMrzjfn9d4UFfwxeIdwdqKvDVF68opb+/QBBVZFh41N3qQVpmvfo7GqBYRfDACXK4kJQ+24AhqTw5kUgKYjcWY6yRKd7BHyb7F1qlyfHFoVLalOIUTLN+HbGiuack7m25uFzKGiGlSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774407601; c=relaxed/simple;
	bh=f40wjK5dS7cQWU+W28V2XYYjYuPcDqncDjlAvu5+Ojs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PfqDmQMp1DH4hiZyLorOyn35r1bR5LNm2Mb0ahuA/Ere4gcu3yFZBvz8H5Q1a0npl+pSOVR3LitvppOMLKUvJS7iYXDZIHR9AOgq+RKVACTG/IbWvExHdo/ZNFyBw6+F6T5LG2hA9vXW4H7KLQztqGTlyzqXSXYk3VyXJpEKvZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1V8yxR/; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774407600; x=1805943600;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f40wjK5dS7cQWU+W28V2XYYjYuPcDqncDjlAvu5+Ojs=;
  b=h1V8yxR/kpXbmh5Wxtvu/lNnmlpUDAMnaLPfcCX74a2YUy8WL5XNnaf4
   y5e7fHxn8AcAdvFV9Y0ahD8Y+jaKu8qJL0oY0ElUi1rWKpTdhJh7jGjIj
   tHojhTkbW6FiD8dVnk8GYzYmgX+A7oSfyRiUkl7A764rZLYFNVyLsKH+W
   IJ81nUAujZSB62yXgwqirsTvqpahpQUnNcuc5pN4MdO5BFi1GdHX2MdKB
   JWA+q37y/OW8XL6YhylUphsL0fefepmPK72FZ8s0VcxmSo8BZi8UZRm7N
   /Z9kz03aq/GnWWMnSpSTDPKdgtKeDl1nTwPoXChe70jJMfboQLpTA18HJ
   w==;
X-CSE-ConnectionGUID: A6TnchK4TQaOAnWlXR7j1Q==
X-CSE-MsgGUID: 8OUXOeemQT6obH8fv3DTeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="62988079"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="62988079"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 19:59:59 -0700
X-CSE-ConnectionGUID: zUmr6yW7SfuBJW/ui6opTQ==
X-CSE-MsgGUID: 8b4TIZuWTeOU1GD6e6tIeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="229013830"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 19:59:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 19:59:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 19:59:58 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 19:59:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWlKjenY6WFGGtRLm/hklRCV73b6OwRmpLNAQc0XZt8qCanp+JDollYS8Zq4PmkWOzHu/Ym6FcRbZuZQSM4AghFYErYFenSr9JEW8kKUUr2JSIReA6CRGo2KMbMhx2wUzxA7rl4EZHU53r7263ZTDhn/56NU3H42nUtXOfmwgYzANg5vFVGkq4KPMLAhfKuvG4unwygy2dB49OsuBRUh7m9FhPAoqzDWJHBSGnXrojUc/ah7noDooodQXv6bPQ25Ljh6nX1hPShhDMRjqr1y9NLvvwHcofqzid/ybtdyR+fMmaXQGoIux3AcZv6oYUNw2ek28wr5kkZVbIyTO5gfTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zt54rkTN+vsWJSEDTSnbUFuUMRchbBfms/30qI9eBTI=;
 b=Uu5oLcoGN4QvBYRXaRZyQyZi9kikUWKB/ZR5cIlaCojlj2IGFXebQtsjwjvS5IsY2Dtvw2QacQRsOwVlKJgjrDRfTEXS9+PHwtpiZNzC/aUGxpzlU15Frpx6NL9PLCHxMnf1dgen8JpZlOpt144BHYg3TnhQAZS4lZ/YO8rA7Xrjyp3WfY4fOsx49qSKo7FU8YTs+LNYJybiZBOhy4qSrvKKsvmK80ePSjZjwdGuV0l/HJJpFhujmMPDcyn+oWGmbMdQSL7J93/TyIXyMi7O3AG5Kxy6J01gKxWyVYahanTuY3H+/RSZ9dW1d2ypUMVpOI6QMGJS3XODfYqkR2yzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 25 Mar
 2026 02:59:51 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026%7]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 02:59:51 +0000
Date: Tue, 24 Mar 2026 19:59:43 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v24 10/11] cxl: Avoid dax creation for accelerators
Message-ID: <acNPnzDryNIQlTFS@aschofie-mobl2.lan>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-11-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260323113117.2352709-11-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR13CA0236.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1a8eb5-87ca-4de0-188c-08de8a1a954c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|7053199007|56012099003;
X-Microsoft-Antispam-Message-Info: 7Tojja9MJq3qMrE1dd+oKeZJEv73jkfvZyDh7jDg5p1u6hiwmAXG0XR2KGRGzc+Zo+2hI8aJPayO984w0ivDvyRK0ckBDlsXEMg2Ah5qCVe64wYaWqEhkBsEH7hXdZPRlRKbDiPdsLjZ8z/abK+spu17fxW8fS31i2eU7yXBo9FIgi4zFYNa/95fXbnKM0BG9j3pCirQLeslBIKF6dYIKQXrgTcb3kQt0A2pS/7hAKh1utrwHLrVVsa2uv9W/fniKyIPvRyy3vOgC6/hZS2LTVRp8YlLPB7nfK6DZE3XcM01c9Ju/CfTN8V655nbKTyNs6FLyxgLQtL/MVzKXxvM8+7zyVIsQWSPObA0ifRRRWHbGiWm6h3oHcqohOiTcduRCJqsAtWuRTmRlMlElkfkM2GaeA/Z7Jef/ZpwByF3XFMQVlwLva32fbUKtcamSDiK8adoEQQWHo/Q5Y67Pt6krjlvwGhfriR7DO45C0OqH3UAbtYgPgrDMTVDT1jD4ya3UMsFRnJ9AEJ9czmKHagw+qzD2/1giifJ6RaZr0FRENvw/Dwmt4paU+TOWX1LtBrPLLd5Qyfw8EOexf/xv6bOU7yOE8vbKmPwgNyigRFWjJkLYPhJgITDNi1zbFHjzx44hFKOetOEC9/QbVWkyQmb4KoSBPHPvYmFGqyl7xBJFNy+Iry+pe4n8oDRVwSMBNb9iWWrUWbv8tnLjgP8LtmPsiZcIm3lwvO61hwg3yNjt9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(7053199007)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+3tA3tc4/9cct5YOE425wKd1enPC/qouBNTd16jcfWFX/PJtAOWA5cjinvG5?=
 =?us-ascii?Q?1RpgO4jx/up+JMRFp24p/dBwUTwioqYwPyohbUT6nnc7Sqv+OKACjHnhddf1?=
 =?us-ascii?Q?fknlunR0ZqLoocVtaRWx1b7kM2g/01kWkK9z0zLhyIH6Z0PU5IR03jhqHjIH?=
 =?us-ascii?Q?Bq1KSpzHwSV2gFznHoUYnbgIammJx/28NU0FkZGGT+XFZM6uj5Sl9cdBtYM+?=
 =?us-ascii?Q?8rXAIwnr0oKDIHS9d1Zi8f5k7BgQ2zomKCcTMxsCE4XMq5VDFX4l5D0X5q4Q?=
 =?us-ascii?Q?ceEIsbrEtrPDZkFKufWsWOagJMTKOIFBkYXTucSUPptmmr2QB3ivfivCVOxr?=
 =?us-ascii?Q?b41IJE7NqKc08wpoJgvG7HWyr9kASPu7B1ytg1pfKZIsd4bGrOjbQVjPFkCR?=
 =?us-ascii?Q?DKNGAxMDqyc/vhiB9YZDybNGdd/+ZouOCWkDIZZUjCM9rj8KFr+aGO7Fz4gB?=
 =?us-ascii?Q?a89VsjmOubalhEjZHY0qFGocLrBCeshp6x5bfHOjYgeWqbanjaJZjmwUqV+n?=
 =?us-ascii?Q?8GUO5ZDd0HRZomDWrU59AvgTU88Q3N/xxnRCZazYJgi5j8R4z2hYsaUanoci?=
 =?us-ascii?Q?7RtoGlrBaUIBjQbs4DxPTsZtGCPOj6Glb3Xb2CvrtLA7BB2k9+X9cl/crEEI?=
 =?us-ascii?Q?ta/GSgCCsS/SHEIhCDH3VYS/NZkpFzXayknCDMwRUDyNmLMDE/d+Gpxf1X6N?=
 =?us-ascii?Q?YyTimQzD12CgLEznEKliR9Bh6bKKBfW2iMpTRLCwACW6ZQsohKQnnNP4ooWH?=
 =?us-ascii?Q?nkRZvz/nl0hkrSXyQYRU+VNn7T74AGalqJM5ihKJ3U9Zn/3WE/NOlELQMeFJ?=
 =?us-ascii?Q?aIe2AyP59vwyFOv4PdpJ1EL/xocmNHByN3ab4pu5/3E4xQwOYXXTQI2R/y/0?=
 =?us-ascii?Q?o2AqAo1t4hDgTV+I38Y/k/2A6ZIz9w44J0RiMzKfi4wF/tuuRNQ0X7rsKUzB?=
 =?us-ascii?Q?wGind0rO4bxkY8UF5WOxf+v9XYYHU6wFf9S2XXlBkKUaZX470nZ9DKeS+sHC?=
 =?us-ascii?Q?rUHpnU+2eaDPcPK+ovXzl9P9JOMJitMAd+B18e8ka6WernAn6ztOZoEg/UYw?=
 =?us-ascii?Q?7Ua/yfPTRp7KWmN+Kql10I3lzKrLBa31ZEBW1k11Eks8pdmNc+mxrsIFqXnf?=
 =?us-ascii?Q?VW6RD8YUxKNVq7Fj8hKIzMUqHxsVpMrHHs59E2EDOmojhRrWISX5WOJ6z3v6?=
 =?us-ascii?Q?8gNqjAFevOqDtwZB6EderyCUIZ/39yW73MENmNfPSmOZfG/94X8MiiXPgB06?=
 =?us-ascii?Q?JVDVNROn47vRn9dsuysJTnS2Q//9FzbRMrR+7P2DMfaaZxddLU6BjoSTBJN5?=
 =?us-ascii?Q?OGj7vB/6FVR2Jv5xNnofE0Pa6Y4HaYkgTzh8iv/Zes8GbJubFdO7GJSpLci7?=
 =?us-ascii?Q?yRZIYio795p+8sjLhnWHvHz9ikrqq6GN1fXG2rN//gP4n3rbv0/aQU8bJk/E?=
 =?us-ascii?Q?QsCndhN0nlMGK7GoGPSHdVuTaqtCfmv/wHemEQiO5EhadXCaj40rmsDz2LH8?=
 =?us-ascii?Q?HQhKym2w/0TEYB6Pts7o4ULnQeVQ9tYv9Da/XhhRD+k6oY0dP7dVkexSe7Ie?=
 =?us-ascii?Q?vdTk2pEGsxdjOvO2hMYH3HFBo2HfeJVUgkNZ0QM0EqKXvBIzqnPLMEusfu9b?=
 =?us-ascii?Q?OwfTD+IJC7ItUmPSqWXnbCSLt2C7wyiEpAPXzcmGdYO5cPz+0/rff7qJBHL2?=
 =?us-ascii?Q?p51vZ2DGdUswXI3jwIQa36+SdsC7PAHsjg9AGt6/rHviszTY8hlgQLLrTpXL?=
 =?us-ascii?Q?P1WSxRf3/rQ8dKamkWoVJHPRnabirZU=3D?=
X-Exchange-RoutingPolicyChecked: IF1WBCpq/dKP3Qm0NCrSk5WZup8W4BpmtfOMHVZsOHzf29TYMqdqLRA4v3jQmT0TswAWO7B89+0j3JBbO6N9JSaQpPRvuF4GgSWu5eXkOXmUQ+jdxOMPAUcTJbOFED6FLCWGcoubRxHc1Yws+MVpknhCxAm1a5u15qRuNq017eiTh4sV4yVIlWdA4aPW53kRJijnE6GbV0rxYBZTl0wct4GFCLObyxDC/qrlREjJmmCkXBeDU6e1aYYt4KJO2KgXRbDjp+Y9aYLg4n5o2paDMwEAg/jfOieWCkJLqpaiSqH03EkLQp4j75XWbD76FR2xH4Kq9em6w3sQgqNDNjF8NQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1a8eb5-87ca-4de0-188c-08de8a1a954c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:59:51.3502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pxe5N9ACtoXURiDhcpGlWMeJ3V0Fc50PDE9RyERc5aoRJ5FVT3UC6w7o7FPHBQIQvBcu6TjkE075k4imEymKWmvp472y9vu0hx1L4OcTcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271351-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,amd.com:email,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aschofie-mobl2.lan:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5BE4731F009
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:31:16AM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses.

Hi Alejandro,

I'm wondering if we're skipping too much, or perhaps just needs
a clarifying comment?

Commit message says 'Avoid dax creation...', that's specific.

Commit log says 'should not be available to other uses', that's less specific

follow me ...

> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/region.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8bb53a095290..2f9bdb4f1f4f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4263,6 +4263,13 @@ static int cxl_region_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
> +	 * Skip device-dax registration.
> +	 */
> +	if (cxlr->type == CXL_DECODER_DEVMEM)
> +		return 0;
> +

And above says 'Skip device-dax' specific again, and is indeed skipped.

This escape is not surgically placed at the point where dax is added.
We are skipping a few other things before dax registration actually
happens. Why skip memory notifiers, shutdown_notifiers, poison setup?


>  	/*
>  	 * From this point on any path that changes the region's state away from
>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> -- 
> 2.34.1
> 
> 

