Return-Path: <netdev+bounces-97154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2068C98B4
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 07:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1C61F21564
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 05:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368B12B93;
	Mon, 20 May 2024 05:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HS+yLusH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EB6DDA3;
	Mon, 20 May 2024 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716181539; cv=fail; b=qyT1Sg3PRFHMqcCrXcoilNcLkpiHHwp7RMDix/niYso115nknk+N6W3uFEj/z6sWbGwWQ/aj0AH2JQDPCO9jwDq5cOHx6S44fkl9nEW+hUz1ZAzTrApYtrkH3q0t7EZ67DrEsOgl1pbFA355tZhpZJnM40kJhyt5nn34f+F0uQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716181539; c=relaxed/simple;
	bh=fJFyQeaT5lcbj/OdCosinOjQt4CPNEU4Orf1/zS47YI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fW+DLf4jVVhuidVDF7IQ097DPno/eBMcCdu1ycDkxsgluklFXo83Y/CGq1rH866UEu4uhe+eAsxv0sNxeEZkrHZhPR03tnolfVMei4Ty+gryCHoq+EdOrYW6R84udE//0B2YaGyOf/6sPvOE6DiJErQbmtOQ9nbKuIDw44YO8zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HS+yLusH; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716181538; x=1747717538;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=fJFyQeaT5lcbj/OdCosinOjQt4CPNEU4Orf1/zS47YI=;
  b=HS+yLusHSyQaRMofntZZzj799+TkwFbGo+Nml0dXCWIgFSS8HBCf98ee
   JFat5s9i7T8q3fN5Vv0j8Yq7RRDprFAo5pCZK40qqLx+gsPTh4Lw/cCYD
   TO03rTbGo9R59ZO3Wdwm5OP8nkEmAp5kDsDtS2HPOyCQp+s1qQCTtVj35
   W/qMw+6BufIHs3r1I27Yfzlr024xsH5ugAkH0knTHIuwpT5leC9nuGodn
   u0hFsU58XoeDYGWcVqjukDWwz3XfFXkIAle7cQdKDivN4tNug3J7gbuCo
   XjsIf9QlxHER5tz8VAMo5sQDfSqMJAiC7dpNef9RtLAddL6sKhQKDr5rU
   A==;
X-CSE-ConnectionGUID: bBqAnFggRx+LiQnq71E8qA==
X-CSE-MsgGUID: 4ZnUa9UqRBqIMCowMKE/cQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="11599845"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="11599845"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 22:05:38 -0700
X-CSE-ConnectionGUID: T888Zro3Qi+YXVztCQrNkg==
X-CSE-MsgGUID: Z9mLgt76TsWUwm/KW3VLvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="33016421"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 22:05:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 22:05:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 22:05:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 19 May 2024 22:05:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtdYHiioPT3IogRffvJpv7xoa+3P1BJx5oGI7LFNahDvOa+9ZLEL/OK7b4J9jszyP30myFXBinInqRjP7fnb3SAGFCZbjdaCSEnAxqtbEGrrDf/j+9PkVD4iSqXRQpG+Z4iQ7zMv2L/BLVQ8/MZ5z6rh1QrNmHV2P8fCpe++wtPnRlzRSvebGSKicR/Qg6dG9b53qr0mSW4c79/ifkgOUxgF7X5P69hCMszzNNDJVAMF8QQE/YYSnRJQsM5qgBhC57uYCuZ1q2h1rwv5//sR6LJlLgpbyjsxvHFDIaMIvnwuIw01F2CYsva88ESWYodYN06/JgERHLPZykmh+MJrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHrJsIS9W3pW/ZsIvfhFmAG5cWOEc5QNhluvT5xBwCo=;
 b=OFc8MBCJ9WKrOU3wcwido5dg+03otxlCq5rAILSrgh9ng3DY5yI1lGcJn3ELknYmaEBeDsI7CK5DO7tNO+cr0CwTUvnGcq5kjqp0vpoaKzaK3UYl4dRt+8XALfq3ITJ7hypfSA0hMrfBIebvSE0MKaNjc3o+cChoEtfbwuXdwQDRFow/LNgT6vkSH3xyineGnebg6xgSjKq+3WXjWfWoKWz6amrwIGfv9TdDme6I5Zy9Rxhx3vSYzNbZ7qPb+fD8z5Ra0ZOl7tri4KfA9mY+hrSRUVTUKF3+2Ra3YhFuCNa3ManrqA5sOS48L6LmLDdFB51sCwWhIXuwPwNyEgIKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7123.namprd11.prod.outlook.com (2603:10b6:510:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 05:05:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 05:05:34 +0000
Date: Mon, 20 May 2024 13:05:23 +0800
From: kernel test robot <oliver.sang@intel.com>
To: <shiming.cheng@mediatek.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Lena Wang
	<lena.wang@mediatek.com>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <edumazet@google.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
	<shiming.cheng@mediatek.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH net] net: drop pulled SKB_GSO_FRAGLIST skb
Message-ID: <202405201037.5e36a83-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240428143010.18719-1-shiming.cheng@mediatek.com>
X-ClientProxiedBy: KL1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:820:d::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 600d43b8-91f6-4e19-8eaa-08dc788a7aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xwky2FpFku56u7MQpr8fkzc5xofTHMU7HQhTOY2xKBSoIqI2HSb1rmFRYv76?=
 =?us-ascii?Q?bCue+VLgs6eXh/MWSd8k5ZGAnN2JUrc6AR4QB6o/G0zvIIwCHEycPIZcB/xh?=
 =?us-ascii?Q?lRGNzAROWaWsllWdprOO15VX7d9wZIUAzA9YbV8XsCnDiZuz88RkZcvUXszk?=
 =?us-ascii?Q?TT1RqFeojtVP3UXqdsq+vevmpF/ouOAHGe/fZgSfY6TxCiPrl7v1LKsWJDrd?=
 =?us-ascii?Q?isB+7bckN8hchRyxnjmF4UcjEJRH6tlsKXUiFyejdxGYYueq1lbVnjw1oq8Z?=
 =?us-ascii?Q?zt3YWD127MLQTfqp+eSNc8J2FdJpSYs7j8cNvhaLIXv1ldSCW/44WNS7Z5dp?=
 =?us-ascii?Q?0km/QobFy5kbDowyY7XUQS3r21A6SFAqbj4qOsTAK2EDFQtYSuRxK/kW6aNZ?=
 =?us-ascii?Q?HG2JfOl7BVdAuttDJXbgp1pJ9k7Mj9IaoYEhyxj6hXJuO0GSdaOeJforEa1n?=
 =?us-ascii?Q?muvs1qiAaHpdF9msqKrPZYrLmVA3ahyax+6VYzx5k9OD/6W3zH50GqqnJWX9?=
 =?us-ascii?Q?TSEpl2EADAnRjdJqH0Vi1csxjfd2lHD9ITMCuj01d/VYth674Kzqp/mdZKsF?=
 =?us-ascii?Q?2jvO3y6GQwJaj9X7zoyfKR1QiI2YjO9AB3eu4seE5LT/izMtq5gLZbAm1Lgt?=
 =?us-ascii?Q?dRDsluiQ1nkU6RBSFe3JvdAacSLJOkXvzgk5WdPUKCZ/jT8xzobeRCDAFesz?=
 =?us-ascii?Q?RIGEFdkGO7sAxVmCl/IViKuYMLLuzqVXsyOfpX+PZL+CQ+fneHdd3hM42uXl?=
 =?us-ascii?Q?J6H8iSVg0gBXEMQm7ryxcWeBAKcdT7lUpgK4QsYroAlgcjZKBmk32AGUybYt?=
 =?us-ascii?Q?U/rVDjtODHeO4Lzb9hS4nhE6LDVMG64SD1f3BvVG/G/DtVhoLEHXnPosxkkE?=
 =?us-ascii?Q?BvAySUlTE8zLvWR1G2+RI3iboJDW61EXGAPuUUwLdu9BraBxNXDjPK3VCBqI?=
 =?us-ascii?Q?DhPCaQHC2OXMoqJ5+45/VXIFwixH7v1EMv9xovvQ7ONOQF1SyBvgIWwBHDg9?=
 =?us-ascii?Q?vWu0bioyteGooahgzWojL71XKG4F/ZEz6peddUHk2gpbo8QA0l7APwRp9A01?=
 =?us-ascii?Q?pTMjehXE7zxgm8apmBN1EWjLGK7AUElxbvfXl3fZRwSjmhWQQR/jKC4TOE+K?=
 =?us-ascii?Q?PMnb/ktkqoc6Pl/w+LbyHrOadw8IYPDOKcItWpNr3AUoqBq+DuvoVxckxa/D?=
 =?us-ascii?Q?JeR50afwlGZ2v4kQkQ5QNfghzgAiaOiFMSwXT9ZQ/tNNFk5AOmuZzeUkck8?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?chPeGLbGJvt+dT4YLg8LXJ45uapH0aIwc+L3nyvfX+0IvN5dSmOkwtOrsAq2?=
 =?us-ascii?Q?0x4aGjAappxvjCromuzHYypQMvO/rbShbdAgbWsa7z3wa/oqvSEz3pLP2NHx?=
 =?us-ascii?Q?RXTVkd9Coa8bi6G04En1MlBJnvGXdHrShIzOdD2chUeNG2+viZv+NxNoJy8n?=
 =?us-ascii?Q?0yMc8xVsaSUBmqXeoGupuH+hdxWBxc3RBu80FDIb1GGD+qN8XXfk8QqUi4CQ?=
 =?us-ascii?Q?m6zKABnAtHXq0L8xXnTid8u+TVm4YIpCCxHXfIUeg5S8BGsnqA+o6wamb93r?=
 =?us-ascii?Q?aIGTLb8+603Yr9EywptSSrlJKEd5FftJ+WGGxqTS20Sq8+YJJsAcNpwXfJjQ?=
 =?us-ascii?Q?wSPM2Q7Hv3w+aM5gkCCT3XKeZrO4cnnWJXv2uHDOeWtuBlIQ1COXYqo2RkoT?=
 =?us-ascii?Q?LVIwoHQVIEMjMI+1MmsQOSiRXKD5QfG4KkUtmlvg4Rgj4srba7P9mgLCcHH8?=
 =?us-ascii?Q?QeQWlS0U/3SeDzX/qZstSLL8aMigLMNFC3LVtt1nmN5TQi/tq/ixGB+1dEjM?=
 =?us-ascii?Q?4qMDjo8478lH37HBjjNuX8vSPEKg93e6CwVRhs1riWEnTD7HXuU8jI0NsxZu?=
 =?us-ascii?Q?jJAKWndK5XJ8Fi71vG7FEAfM5q1BimJ4IbV3fyqG8HU/YvQX3MVie0Toqtxf?=
 =?us-ascii?Q?3NuwXZ+ilz0rGqoBzWsJOVByyUX2MIT11rHtpwP6t/PaWkTXy+dePceXsFbq?=
 =?us-ascii?Q?YhxQfvDGpZ1Q7NBLnHdYwk4ISOuWjjFBtJgPFshl+37ECFN6SaoYhPFlCDoD?=
 =?us-ascii?Q?+Z3a0tCMni+b2G50XA3saAlKFStSDe7ewqKlTgb3iFfSDNbBbvL4nQ28Qb1p?=
 =?us-ascii?Q?AJwUVTGL7YKiIqWO0fmWsorDvjyRmifr91M8F6UBuaxV0KwgOfeiT6dMoYN9?=
 =?us-ascii?Q?3RVktlSHknjwC5kasM11P1HP++ouIaTUOJAywtmm5xJ5P/4ya3/EQHBstVka?=
 =?us-ascii?Q?6zPzPoLl85APNiVMXjbZwj2JYcVB/MNHyGEVJiWXiIk72CAaxaa1fCJnezMh?=
 =?us-ascii?Q?nDt/KZGdHLTFL7Tq5nW4P67zulHWjEpMp7Lvz09agOAPpG4SajD3tGY0MOE+?=
 =?us-ascii?Q?Lrag8ctSYABOIYV4C3iC3q7WXCMn5IQuExcfYHhMFKa6rfMb9oA73ZgPNFD6?=
 =?us-ascii?Q?+KVrYlwIFSypUMI8Gs6uUXGY32KsxOoI5HdADOvKm/hye+6WhFni0toO0ZQ9?=
 =?us-ascii?Q?u+Q3aa9ibYr0ZySOsyEOsb1VhfZF9UrAIwWDW9pa4mZicZ2L+1NGgxqp8sS7?=
 =?us-ascii?Q?1bB1FwMXqsYjsIyDnJaGImDmNtv6vo4361HBh9mH/UElHP0zA4iq3d0JY+yk?=
 =?us-ascii?Q?VpJtYXlg9Qdbs9wvMgJjQURL6Tth9sJxBS8yHMBU+aUqbRbkiweZI+U3e+sI?=
 =?us-ascii?Q?DUGnheFXAq0eM6Ss8zFxiWeHXmiCEtm9CFyqa2h6tCqZ3El4zgvoN9AVfv3n?=
 =?us-ascii?Q?9Hdxb0MCZX+F4Me3WnePJOn/wBL3PJQjmwHs8sLBuKyDFbDS2ALx10HFYd2H?=
 =?us-ascii?Q?g74d0w4kIhSNszr9QepwSiKOHjYM/hBCleIfsAM8yxpVvq9VxpF6jwU3DdhR?=
 =?us-ascii?Q?lLntRRI0biO/9Ummi1lUBWE6wm6+8wpdXLLNaei5iVKMOdnJ3/1AFhvy8s5G?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 600d43b8-91f6-4e19-8eaa-08dc788a7aa2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 05:05:34.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6AUPaGw375aRlZSaMSUO9q7U0WH4IFwXbwlAjYXLA7k7OHx8kECM93UTfBE1eOg5b9WDvhXK9DCqZ5iPPHLhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7123
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.net.udpgro_fwd.sh.fail" on:

commit: 7ed67c5ee988b506bd05e115e9e8299bccbabffd ("[PATCH net] net: drop pulled SKB_GSO_FRAGLIST skb")
url: https://github.com/intel-lab-lkp/linux/commits/shiming-cheng-mediatek-com/net-drop-pulled-SKB_GSO_FRAGLIST-skb/20240430-133823
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git ba1cb99b559e3b12db8b65ca9ff03358ea318064
patch link: https://lore.kernel.org/all/20240428143010.18719-1-shiming.cheng@mediatek.com/
patch subject: [PATCH net] net: drop pulled SKB_GSO_FRAGLIST skb

in testcase: kernel-selftests
version: kernel-selftests-x86_64-977d51cf-1_20240508
with following parameters:

	group: net



compiler: gcc-13
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405201037.5e36a83-oliver.sang@intel.com



# timeout set to 3600
# selftests: net: udpgro_fwd.sh
# IPv4
# No GRO                                   ok
# GRO frag list                           ./udpgso_bench_rx: wrong packet number! got 0, expected 10
# 
#  fail client exit code 0, server 1
# GRO fwd                                  ok
# UDP fwd perf                            udp tx:   1488 MB/s    25250 calls/s  25250 msg/s
# udp rx:      1 MB/s     1280 calls/s
# udp tx:   1501 MB/s    25471 calls/s  25471 msg/s
# udp rx:      1 MB/s     1280 calls/s
# udp tx:   1512 MB/s    25656 calls/s  25656 msg/s
# udp rx:      1 MB/s     1380 calls/s
# UDP GRO fwd perf                        udp rx:    337 MB/s   272896 calls/s
# udp tx:   2183 MB/s    37033 calls/s  37033 msg/s
# udp rx:    376 MB/s   304320 calls/s
# udp tx:   2162 MB/s    36675 calls/s  36675 msg/s
# udp rx:    402 MB/s   325376 calls/s
# udp tx:   2167 MB/s    36758 calls/s  36758 msg/s
# GRO frag list over UDP tunnel            ok
# GRO fwd over UDP tunnel                  ok
# IPv6
# No GRO                                   ok
# GRO frag list                           ./udpgso_bench_rx: wrong packet number! got 0, expected 10
# 
#  fail client exit code 0, server 1
# GRO fwd                                  ok
# UDP fwd perf                            udp rx:     37 MB/s    30033 calls/s
# udp tx:   2220 MB/s    37661 calls/s  37661 msg/s
# udp rx:     99 MB/s    80141 calls/s
# udp tx:   2179 MB/s    36973 calls/s  36973 msg/s
# udp tx:   2161 MB/s    36654 calls/s  36654 msg/s
# udp rx:    104 MB/s    84775 calls/s
# UDP GRO fwd perf                        udp rx:    162 MB/s   131584 calls/s
# udp tx:   2113 MB/s    35848 calls/s  35848 msg/s
# udp rx:    263 MB/s   213370 calls/s
# udp tx:   2097 MB/s    35574 calls/s  35574 msg/s
# udp rx:    217 MB/s   175616 calls/s
# udp tx:   2107 MB/s    35748 calls/s  35748 msg/s
# GRO frag list over UDP tunnel            ok
# GRO fwd over UDP tunnel                  ok
not ok 53 selftests: net: udpgro_fwd.sh # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240520/202405201037.5e36a83-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


