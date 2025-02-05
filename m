Return-Path: <netdev+bounces-163271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4455A29C0C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 22:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C341691C9
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B7E215043;
	Wed,  5 Feb 2025 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/aj0Imv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD323CE;
	Wed,  5 Feb 2025 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791738; cv=fail; b=pvq/rARx6pLWC6IggHt8iOvRnIEZnURH1mEwZyJ/emQMZjLejcWQziATYLXho6y21qZ2HPEt0QG4zsQySyML62hT05NbzlTLDhN17LOGCih8he/wLgOk22NOjpD8ZRuqcwp9ZvQvWEE1CiY6f5BhhrdyHmzGoOM3QAzVrWMLris=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791738; c=relaxed/simple;
	bh=N2ouJdywFFYA/7q6E2sK4htLgvWjc9d6ln2kpT7khEI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JcRGHvNYApwYG4YECbH71gIyAZ9oHuNzuAn5PgfDRuk3F1agVNQ7IJYLsTSmwCIVBEv+/YdOgb2rqv4ae0jx5qgPQAQJXFrK09nYVki0IvIXTVH/esdVU4MpikatkWpfwfwKH8xts/dBV8kJ6LBPHBSrKo6Do3ngjlzVIkERxi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/aj0Imv; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738791737; x=1770327737;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N2ouJdywFFYA/7q6E2sK4htLgvWjc9d6ln2kpT7khEI=;
  b=L/aj0ImvW8QpXzuzgYCbGV7w2rrVqhsb8roSiY530/vI+5xfwR+hen5d
   YqHNITv19pGXkZ0bgygAqrG9dk/QIN+BAYi9uDPYZj1j/L9tHT8HVlUE5
   fAw0KUp9ZE/jWJgj6g3d2cHhiEXMUiqwBdtXVtNlO+ir7JJK/m+yK2Bl7
   6SDDgjfFZF16n9Yj1vKTZlC8FxoIN19ZTvJEALUxZDJ0cwt8LG4qHMTh6
   pjhFhaLFajpXlZqHXGJ/TWaoZFvU3iof6ipvhVK2eT33rmhOnQPSlepzq
   koMmknfRPlaeID120wnwHZeijomSUk4PSN2zp1NifcXNe2tkflq2ApBPD
   w==;
X-CSE-ConnectionGUID: PZRQd1U9RuW2g5fL/t+aSQ==
X-CSE-MsgGUID: qVX1iZBlTa6yBi8ZmB1F4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50800495"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50800495"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 13:42:16 -0800
X-CSE-ConnectionGUID: KqH5OfrfQI6yj8l/8yhg5g==
X-CSE-MsgGUID: 4J0iEvZQRXeD4uRHOUN2aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="111544462"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 13:42:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 13:42:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 13:42:15 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 13:42:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZIjfFtWkoFAkgfb8qUU/rRhtPGFmQl9AKs8lT8TbTdO7P4fRwuvqpPJpbCoIQCJuvbYclv/Nk0fKKb1rI085xKxZVARphSN+nksqKrNAybKHPia+/K4WVlQYgPE/XRRO5THgnV4ikA5o/ezXycfbpxz+C7iOr/gTZOxRy2WAwgQuyLnOe+1xiY83CRJ74w8lQ3hsAMS0csSCOyWMNZAiFPH++bN69S9HIre3D1g5ORiHiL+kdQA5FdUwHslXa84PsMQsdXCcXqXwjZRxxOO13lqvKcnK6NUUHkwpZeN8kaPT7lPclYPjsZcwnykdPe6RNOa4XJeoVrcEaQIW+nphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUMW9oD/aTpoLHv2NQ1ayFKRvQS/AVxrVCfdzgjUcWY=;
 b=BEni0EnykJC97LZ4Gqh788QSoBMBzwWzdqWBTpxZn+38tR3EQl4QZ6VqrToM15LY2Lhk2oApv1jxqMO+xuYCHI8DTXs6cJy4Ubo+pYmjMgIinIZ8Tnrpm77/zUfjCDM3p3oQn2I8HqJtzOr314DmQO2R42H2JGRCGrCkL6dSzjMNkNN8iFFLzbrvdAbjnaiar4by6c28tnVTs1/V/33BmWPBAx8DDZ2XZ3AKTlDIsCEc0g4619FQEUeZEomvBGiYvbpx+ILGYc4wCNKF3/C4pyAnKqYhBUn0sy2q/uj+WG8t7JUOgDCbEpl0oS7Y7xcSMMOAW/DdFZyGtSsVLlMkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7872.namprd11.prod.outlook.com (2603:10b6:208:3fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 21:42:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8398.020; Wed, 5 Feb 2025
 21:42:12 +0000
Date: Wed, 5 Feb 2025 15:42:07 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <alucerop@amd.com>, <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v10 07/26] cxl: add support for setting media ready by an
 accel driver
Message-ID: <67a3db2f253ed_2ee27529470@iweiny-mobl.notmuch>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-8-alucerop@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-8-alucerop@amd.com>
X-ClientProxiedBy: MW4PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:303:8c::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb32a9f-7d75-49a4-c770-08dd462df2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iMymOglRCjWRxRhTOdUTpaDtrgph/IGon8s787vNKGj96EkFwh0qDOI5OLco?=
 =?us-ascii?Q?QusLw74Ffd98XyFGCWmHt53ijvUJqfJDxMZ52XhV/5ajdN8SdmgfB3t0jPtC?=
 =?us-ascii?Q?QoNa/t+4kQrZcpPPsKQd1wj9U3oEproDaHHbwq4umuyiH/NX9D4R+3I6wiM+?=
 =?us-ascii?Q?Bf3Iqag46oZcX300WDRtSNKOPY5HM+xy4UTBLXVgydr3vKCnp5l7wimugLoG?=
 =?us-ascii?Q?2gkZnTSEPv9sh8OjzuT4O/6gzI3+bwN05e1LmG1EDw/h8kGClh6Tro8HENl6?=
 =?us-ascii?Q?GZgt2TH+Gtvh8MgKA2P+T42IcThaHd+rz7xs/5vrkeL4r7h+8wAeNYWPSBNa?=
 =?us-ascii?Q?EqIkZqgSzfphrfwcLThVFPtGCkUDk5oD3XxYbBkgzqplP45NMgqtO9aYG1kB?=
 =?us-ascii?Q?KKgclXPrnw3t/qUlaesa0g365/m9GufvEUEdMWuyekxK3AvxdioTvsHfz1Yw?=
 =?us-ascii?Q?OtG4kBra3ZIsdwkNxK/hQcOEb0lszr0u/aRj2AhlbRr31cfRgVF60lzwNpDZ?=
 =?us-ascii?Q?F3Fy1NpJF0yZoIFrgaQ5p99arnKfB5UBsBAf4PEI4pI5Qut9uBOeAMTpt85+?=
 =?us-ascii?Q?HjTb02glvw/K1B0GMGap/4kO84+8VWcvmmpA2z3B75Wl+fENy9DzlPtb6yd0?=
 =?us-ascii?Q?VXr+WJ5JRL6VYuCkrPDFVEo7pb5Taen2xNZ1ni84vrOlrtEQtZAHvUnDgvRz?=
 =?us-ascii?Q?XWKXPfOeNtTUJ+43kBo2yJ4ekUq4QTil1G9KUuuDsOWTvc+VfEKzhMcNUMzM?=
 =?us-ascii?Q?Po6LkGE1NgnYRjhaWuPwavJ9y2c3wuFsKQYS3IR44xHiGdW63rs8IHo8SPj4?=
 =?us-ascii?Q?wXGBcWTvun/L/PUFXpXXfkIqbOfuXla2XNLJfsUmaJaQ21q/R4r4hhNmYEPx?=
 =?us-ascii?Q?OYku9Eh93rN+JXFzfbmOHhJsiSsyIjsjWGpYmStXByL4ySH5MD1PxtszBcvV?=
 =?us-ascii?Q?Kx9qQUbJZf3RCyldmyswc+XCH92MwBuYVjfXyLY8GyRy9/k0vD8BFLU8k4Ji?=
 =?us-ascii?Q?nEJjPsek5vZEzerU43AVF8fr3iI+LOVHkPnMMntpCa20Y0/bZbQeWnOyBU+O?=
 =?us-ascii?Q?GDlzyAuDOt6opscxUwV0xEhYuf07PWPHoHY9mYsWLEgZMvtx9iNQRlujWzIv?=
 =?us-ascii?Q?f3klLPTSXiuEpPG9Tjb/W++gzyobvNvOotBKtx15KZAGw2g9jxzDazy0vCct?=
 =?us-ascii?Q?qYFG6dZGqzIW5enSaclKPteAwhKP87BS5wWyAQ8XdgeL6aQuRsNFM2IyH7NN?=
 =?us-ascii?Q?IlkPbsmASChVrYsAk5/9ap5+2lL8wSjkEPhr7Huc4FNa9oTHWwddgKoc3YpS?=
 =?us-ascii?Q?qEUK484dGpfEmkeNX8oRXgjaFbH3IuWuHDn7JsohhTN9EAw/EHGxOgRc2v3j?=
 =?us-ascii?Q?0WCldNnfSPbh8t+AMsvAGAE9XdkmsfD7q+BZPJM14F2rIqf9napXFW6ORD0u?=
 =?us-ascii?Q?5JV3aYTQeKc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nye5S1zFgXu697hxNxnxlmkIFm51O6mMOK3uMw7pIgetvoSj7ddsf3rObhCe?=
 =?us-ascii?Q?E4F7WZhnUWkchiMeH2baGZa9vFusyLxi3P6PN5RcUGqod3HMHuBVEAWGq5e/?=
 =?us-ascii?Q?yPEsKqDteSaqUhjxnDHDuJKK/GS/59RPj7iHm6UpMiBn5FNYU2hGpAd4Bm9i?=
 =?us-ascii?Q?JHcTxLKRjoxUVRDf9SZWwJgbSb/nhCSxW3QP6IU6TdJjTxgU1hp5ewhUX+vG?=
 =?us-ascii?Q?x2kAxr7h2n5pwvJzxOp46FZOVkihySuE9PXLggfy3ueG1AVL2ndlYuGd26NP?=
 =?us-ascii?Q?qvlql7gWXORVcvDA3oeWTEwpGnKNMseVfo2RoCqCr6fmTczoaE8UBYsDi/nT?=
 =?us-ascii?Q?izgk4v0apOJMio43YEOvRR3SXmneWO9BmENsRk9GSvwnoTaWnEb62Mh5XdFn?=
 =?us-ascii?Q?mxLUrbSxbmuPZVq9cC4Awb+qoO53T0Qv0dY/ux14UpZzrctvqR7c3Gqd+Uw2?=
 =?us-ascii?Q?pfLkVlb9w0HITToaY6SktPfdeSCr4NvYr3Rv8tWrHGKEGLz2wvF2XFzN5qdW?=
 =?us-ascii?Q?N6aWzooJY6LEeGs70vLcaW6D1Ox+RS9hWsK62vH54QX4o67poUlME+1WUkr6?=
 =?us-ascii?Q?a0RW9KoMOH0gfrJPEabLYbDj2o6bk0ed6DrGl6y9VCSlZxvO6j7KEVWl1CxE?=
 =?us-ascii?Q?kSgIUDK+LtieoOQCvsA9YLdES7/h28jSBrGC7PYTdTLFXs/UMQZEzHSspYDa?=
 =?us-ascii?Q?85abRkYgtU82JpSTinzH5XJecfGUrAyJ7nkXqD0oUiRJyEHHxD8wIqScxFJm?=
 =?us-ascii?Q?CFyaA77VQ6ikp0GEiDFr/Aiq8N0Z8+44e8DQzAAqUhjFs2AMwK/Msr2YyWcX?=
 =?us-ascii?Q?q07MDhxN3rL9qVlfjhChJqw9KJprd+hvf4hlGgCETiIz/L1EITJySw5D5PuT?=
 =?us-ascii?Q?Mnwltbv/BZwK33PcnrQ0Ii/cc5y8rXkiRFy4V5OsNuyO/qdqB4Va5Eg+DFF/?=
 =?us-ascii?Q?MPx+zJzit9fucYrPP5y0o+GVF/8rgAZwYjU9Wyxa59rkv28LzaqBqLbLb35E?=
 =?us-ascii?Q?1S6qd7p1Wq7+tgRYty7kQbXDgBY4VkS2/lqe4cMCdK3ASAISa3DaLABHbPKe?=
 =?us-ascii?Q?glf4oimF3Eu6Kp0LCGOHK0cA0VNadOV7brqBGPwm49qodTNgkoEBUPKkSbk1?=
 =?us-ascii?Q?Sv7If1UEKf5Yo8z9UAN4AnatMr8XXjQEjtsabWWHHFjqt5s4Mn4S1KU7oYiO?=
 =?us-ascii?Q?xRaLGiB+24XbZLJe8GD1AFpW1s9/SdQHEfxbpmfJ+3Sls+2Q3yydrEflXTF4?=
 =?us-ascii?Q?VURNdaVGOz2rAHrXiSxI5sSHts4YC32dq2ivJOeGRj1TxDbNFef4USWjzJdg?=
 =?us-ascii?Q?iFm1zaMh+npD8XFdmSB1rH5fF8Wa2Po2oKR/gauMcCmuAXi+O1nnZRKaO8Bn?=
 =?us-ascii?Q?AlAMw9nJxHmS+R5tPwUGwP4iiF+yQq6tmxYr+0XaxjjycxZwLmJ32IvxBVR+?=
 =?us-ascii?Q?DllRrZso8BiQfm9bsiqBXlwPF89TUx2raLZrBxsQZJ2kQL0xThbZn8myUXsK?=
 =?us-ascii?Q?lWysmAu40T1I7nbhmsJr9yhY+AuQXTBIxD1Q2izvOrMfeoOUtIs8FEoBcp6O?=
 =?us-ascii?Q?MeO9j9uWYT/nb9UdAYvpQXMH5+/8MT1cyrrHauAb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb32a9f-7d75-49a4-c770-08dd462df2fb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:42:12.5265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYYFMFqiqcwiO6uFkt7zPLjNZUNZyQycYWDOmhi0bqqvnoSAXKaDwm7UZXiDnafhW6/GwLoZe+AsqfkoY0/hjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7872
X-OriginatorOrg: intel.com

alucerop@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>

[snip]

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 08705c39721d..4461cababf6a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -177,8 +177,9 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
>   * Wait up to @media_ready_timeout for the device to report memory
>   * active.
>   */
> -int cxl_await_media_ready(struct cxl_dev_state *cxlds)
> +int cxl_await_media_ready(struct cxl_memdev_state *cxlmds)
>  {
> +	struct cxl_dev_state *cxlds = &cxlmds->cxlds;

I feel like I have missed something where suddenly cxl_memdev_state is the
primary carrier of the CXL state for accelerators.  Here, like in a
previous patch, you simply turn mds into cxlds?

>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	int d = cxlds->cxl_dvsec;
>  	int rc, i, hdm_count;
> @@ -211,6 +212,14 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
>  
> +void cxl_set_media_ready(struct cxl_memdev_state *cxlmds)
> +{
> +	struct cxl_dev_state *cxlds = &cxlmds->cxlds;

And here same thing here?

Ira

[snip]

