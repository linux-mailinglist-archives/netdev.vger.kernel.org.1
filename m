Return-Path: <netdev+bounces-191711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CCAABCD5D
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35FD189CE18
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507082566F4;
	Tue, 20 May 2025 02:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAjgvoJg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50532566E7;
	Tue, 20 May 2025 02:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747708930; cv=fail; b=NrmQTE45KyP/ODDiLb/FEpan5gE5enaT4RtJqkN3xvZaz2X5tC4DJvqiEl6nj1bGwzqk9sr067UXFIyWI8/HQNk3E6XVdqYpPtosMf4l5cRaSXBJCc0jsrdsNvuEb84vNMmEt+rU5vhACorEOekaNsScyKEP7ckDwmn4Vlmrl7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747708930; c=relaxed/simple;
	bh=PAACu9aDZwtW+MNpTfApgGkKii/ZDBKBCtQ8mufbvyc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LYuh6Dlc3tn4zK0pGZeN6VoqAXCaqY4+T3QTorDcUnJk3UkO/FdBuNeowXNKnUYgc78ogMosP8B7I9XshwnJApCehrTww+RCUjk4ovhyldecvkL6YyKHKI3pv9NN+gdcoU2VqDsKPB80aSIhKQH+l2/gobtI79YAJhmSXo//1T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAjgvoJg; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747708929; x=1779244929;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PAACu9aDZwtW+MNpTfApgGkKii/ZDBKBCtQ8mufbvyc=;
  b=PAjgvoJgbi5Hp+0RliLthgRlpPaqG8J/BsR3LIG4WI2hKGYzxA2/bE+M
   yBkmYIq+KRS/xW0hxKwjrwBmFZ4tFkK6Ol4s/784QkHdp3maNpk58GoKd
   lOxkIz/ljwCyb41CcXFkYCZLKQauCZJ8xsnR8X4cVy9QPwSWZjNb140xe
   ftJb4pB18MmgSA98DcyB0BGXndh+ameUxe6tLYjTZZfiq0N4teQxZolMv
   VqhPcT/m29NOb5yLC0Sd4Y6cVan2lgpogKiI9HEpo+k7kX3+WOmsMQHtL
   cqs2wWvItMzuXy37ixyYeyUvW8/wbxrA66ntuBdUrTAPDJ6PyyUXYxWZl
   w==;
X-CSE-ConnectionGUID: uMytlUjrQlyqwCIY4sqD5w==
X-CSE-MsgGUID: OnUllX3tR5GV9omkNyT2xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="67179718"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="67179718"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:42:08 -0700
X-CSE-ConnectionGUID: tNTEvu8XQ2yK42k2nbO6sg==
X-CSE-MsgGUID: ALCSudIqRXC9PIVA4fPDdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="176668197"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:42:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 19:42:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 19:42:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 19:42:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vty6ofJW3P5djZSRYu3SPAzoYUAkhCxU9Haca69kq5W7fMFiYybUgwM1dBK43QGUj6svVE+PzE/t+YiT/IvBkhqEgJE8wgcbuKS+0WEvTUhlzjJT9HNsB3UTG8jtjHoWo1PeN/HkIpgP3UzYTlux77QfDsCTM3l7qIPiZT/86Et4L+6hzKbU0DBmU0ZxoX3cR1Zb71bkFTGwsZuGwQCc1zDxUjHuAo3TpBJ6qd+1+vpaeHOpj3As3as4QDHu9haPkrCRmUd0niEC16PP0QUPPejKybrNbOaL0zoCJz+eVpRpibFSPr9xgLsxEwz7PfD+8/1AaMFsM+6pLG6ZvmCEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4k7an3Rr941w1dHX+Szj45JzBEXOrPj8dHHCKd38BqA=;
 b=BtoDDwtcDabpKAjjAx3pobBKzdXTTrCW0plbqJFTKyBMxr3wK+gGUKfTfUSxn91bwRpNI3wZTCRSAXqkqzO6L1bRoNbloKUY19d9Nj8TMCO+6MPD0PEQ4dxCk+lgAzwkBRXVAxZYrYkes4HBBGbEnx7bBfMyZw96hgAadDlS32NSxkezKgMhUgKZYUuPt3p0/KNtA70wlW0JdCU9JgjWY02evyiTqzbyCQQVJ6XGZyx9hlXYmutIa41MHNdJlRhpHY8bJBHtJl15twU+vh06lMivZt2yCxm1+z2vnyIZlEaMI1G0Gp+EaOD5EsmVysgM7aIfdSSqojU/12PimKb11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 02:42:02 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:42:02 +0000
Date: Mon, 19 May 2025 19:41:58 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 04/22] cxl: Move register/capability check to driver
Message-ID: <aCvr9nK0aASdZLfq@aschofie-mobl2.lan>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-5-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BYAPR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:40::40) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DM4PR11MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 61bc8c6a-ece6-4f99-2bf8-08dd9747e6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zAVGZL/on2EbDlWy3qUdZ+Ij1WbpbGsLzaWK/nBgqCy8jd3K4aQZlW6H/rfR?=
 =?us-ascii?Q?dk1psv3Gm/sIpqtjYbsVsfDKW39m92tEC36GihS4rQIwOlzhnt12JZheMV6v?=
 =?us-ascii?Q?YZKp8BSOAWKOec6VWT7V817pVyEOnftGlxedJKWfiUtlt/bOn29JTCnvam+q?=
 =?us-ascii?Q?gDf0ukZ05TE8vFj9MqKjq2S6b16Swa1KijMdbPtPjCmoUAvwvtwZSWX47/Mv?=
 =?us-ascii?Q?D2geP5I4CMfJGhobGgQ6Ua6TD7MEl8TgwDhZ5SDjEDJ/ubL3Aqo86LWvO9x/?=
 =?us-ascii?Q?jaU1KuA6jryd/SFjhL9Zcl8ppT/KLZ3zgz8KXXFA6LsTu7UhiOQvh61r4Qd5?=
 =?us-ascii?Q?UikZ4zZRCjvhyU4DmAAYHrG418bYMO53D2TTuq0efHVGAQjnraJv3aE+aQ39?=
 =?us-ascii?Q?vjmyTKoPeLvRBsYHuAdraEE/NjP2R3nbzNk4VW+4Q4i93NcAwJnHlNPV1fDz?=
 =?us-ascii?Q?vMvIBg/uCz9do7CFo6rpVfyFN+WkILY4YifBB2SLeBqA7aCsFZjSIJyuAXqr?=
 =?us-ascii?Q?ytHfIJH/EX2O4004KmV82xRsxuht4VlFKdzLfGOooXaq/rEA9Rf/KQkTQT0b?=
 =?us-ascii?Q?yK8xh8zfyLy/Pw5dWt7bff/chN7ptO/dxeA6ZRUMuw0mzq7jn49AXCjD1TPt?=
 =?us-ascii?Q?+wOqahTM+UiXMLKyIx77lShmC5L+5gl/WMrEi5tMt+Lg4NayPjyLT5B/wzdw?=
 =?us-ascii?Q?NXi0LFy0EG4oRnSRX1j0VsGsBNJNa/aMdlWw8iU/LNt0+xfZbsPdMg6rHfUx?=
 =?us-ascii?Q?7eEC0KjEwHp6P24nrFSMGhSj8CHEBg5bTtLV7JusObFJLwVwAVFuCkvKmly+?=
 =?us-ascii?Q?coAFu0+Eii/J+y24kwAhpXFzu9aqFrVkG0uOfQilA0fdTbbbILrurPoQX6i1?=
 =?us-ascii?Q?5uPopv8jW3tCwgLrBi6wPzOeXV5otWq8+dkfv7VWPLCg04APTDmtr8hNbog+?=
 =?us-ascii?Q?o7C5RQdAZkw9KPJedPS9iw8L8iF5hCibR+2/enATAPOCMudzJgsldXnkcjCg?=
 =?us-ascii?Q?zQvuyEq1zjcDgeuClbefJdpIHfFs0PkPFM5iiunc7z2UTHUyfvsL77Ux2IyT?=
 =?us-ascii?Q?e9VgyAFuFIiq6cQD3n4MNNuSUz4PwUAzM49iY/wCMmT645X0h32gIjlDhJ3H?=
 =?us-ascii?Q?QXAdliAMp9YmeZ8r/W4P+lwGxXNCjKxZXEruoYbFP+vDxO8A4jbhrKrJgccR?=
 =?us-ascii?Q?+r/idK0fNVnc8yaoSt+EoNS15MUJOrxvvLIgoYKkkg1aH7l50f8s3LY5G8tB?=
 =?us-ascii?Q?ooVIO3GE9rZiYdFJlEZjsTcyIaK/eW8AWQwzJTkaVmw1lWg3K5htx/a7gn6g?=
 =?us-ascii?Q?gQ4NUqO+XFAX1Ok6d4iCWDsXB1RixD9CnVedoNiqdMVgF0XXXx3h09IauJeQ?=
 =?us-ascii?Q?tbcGhPSg9XH+o4ZQbXV72YdllTx5xfk0pHLMcBT4RLBcIkam6/U5OAnjsNza?=
 =?us-ascii?Q?38S5cmdLG3c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pIGTtD0G+vZaKsSE9N5EKxQj1eW8AGFA9hGHhT8VzM1fdpyycDW8dRTGonZ+?=
 =?us-ascii?Q?tSNT+iYTjfnnVI8TC7U0htIN4VwHhiScqtOXwC8nxALl/Y27ZnKboTqY1ULk?=
 =?us-ascii?Q?kVsihyDzz+LXPGKiciW9oEzoVTfm4kYnf0bDyXmA7O0e8M7esSb6kHarQhc0?=
 =?us-ascii?Q?PPQlaA5ogLwb/N9J1Rw90h/KCsIgGm6ydvZpEsRmXnr+k3JkckfYpSPjkVU/?=
 =?us-ascii?Q?kCCWGqrG7LIhF0tv4pgn8WxXbEgzE9d88lLW/zZNku8TmC9k2UKoemp0Z7TP?=
 =?us-ascii?Q?9Py9I6nmYiMgAsoRHJoJGsFwQ7/u7TCf4cPZHlx7AYvJ8GcODpgGwCBq3ekn?=
 =?us-ascii?Q?Sbohe/g3t4j0lFRXqlVaC7iDl3byPzkjwAGQbCzmqNmDM+Xf+cSOdYWT5yzG?=
 =?us-ascii?Q?stAPQKsRB/4HTyvoCaFoh7OWTU45ebS/VY0iLGq+X0hRdT+REH78Caci5Hxz?=
 =?us-ascii?Q?AZghEk9gwiyv5Y+ng06MaaU92M94B7/IXmCff52Z3NDtl7vVV2h/AH1jBAv/?=
 =?us-ascii?Q?rvykR0sYJ0UOqfb5E4uxdnj5Tuv6iaqE6PUgQdImmJXrSDZT49hdetGwNPTj?=
 =?us-ascii?Q?yXbjIvZKjhpHEMumh8wvInvFbvYUMbnO9Br0cZGi0+bXBLFBaov7vUhwzezc?=
 =?us-ascii?Q?fo9baPoAZP74cFkTD4GZtZmDzuLT9FI3xPa7BtQ9LTNhZKMhrK5acvWHTYkB?=
 =?us-ascii?Q?dfIB3VlBFCoG5FGywrz+VKR6y/Jvf1vtjht67A81x7poCYYZNvb64HExSDO8?=
 =?us-ascii?Q?+qk2E3I7EyuIGXafpuqVV93K7e+qPMOBiwL5RqwwOaQKoDnFhTt/ahyn34rg?=
 =?us-ascii?Q?Mc12tj1K1dy7DV8iZoZPjZtrARFCBDMQzCwMwvexq/CJetbRhEHt3AKlradQ?=
 =?us-ascii?Q?b4BywWwHcOv7cgZBYAvXLfH6mooR5nAokXkjdq0zWSadVSe6GNrtHHkBZuAf?=
 =?us-ascii?Q?jw6QfzJZ+D7w39HqvpMvvyPPKpYEWJ4mHc3ZUFJRZ+CxvQnaVy19E8LZZuG/?=
 =?us-ascii?Q?l79ViBchau0CzJKx+LCFbpG/lD5Vekl1Ay5k77BWqGkYOKJFfDJRsdwbmWDt?=
 =?us-ascii?Q?qRJTI9s2WG+JPhqbzjjO26eYqyCXliZZBtJnO6S8f/w/1ctdW2wj4Txjam9H?=
 =?us-ascii?Q?9w3tE68JFroZ4I2wTuCeFeXZcWqBT3W+YjYsQ4GuP+08PetrOqCszhaELD4J?=
 =?us-ascii?Q?gA4QNToLNVrwHZI6U/Vf0OHxq7Has/71qAGfeUhyai9FyB+xWpurkrB1YFIJ?=
 =?us-ascii?Q?SGUQ1L5aZ0e/Y+zvTGqsGbBZG1KOkFFygmPxp1KtPLLpuvMYM1n/ugKRFfo1?=
 =?us-ascii?Q?doYUGLVttKcAc2gQIHxM84PYHNfwOhcfEKZ4lmMr0pdkmrhzLOYgfzea/AWP?=
 =?us-ascii?Q?SouXcxNUWsvyp9gw53MZ8BfO2w5nsyHcqqwcYWQruwft8aHaCcdZxUSVdYTm?=
 =?us-ascii?Q?fjcfFsEYzvX16u/DykWzZFHdJZsI1qPSL2b0RwpkYMF4iPJ0tbRdlRIzqjZf?=
 =?us-ascii?Q?PNjJm5zDxug1ewRJnglzTUjF0Qg7B3X6nGN6XHoAoTnUkCWiJwEGj+igqYjg?=
 =?us-ascii?Q?qYx3sJrLshG/jfRl/AQc8B+K5pdGSWPbKUd0WElbLDD+H6oHtk2bJB4fN3ea?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bc8c6a-ece6-4f99-2bf8-08dd9747e6a2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:42:02.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8IFtmxpU7gcZtiUlwxGllLXd3pNPMeO3qGhpQ8zBKQX6i1aBkVz+ns1ZqAYjK4s2ScCyp0OcySJvBbX2EaRBkL3Nu+NI4higMMh8T7R1ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 02:27:25PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 has some mandatory capabilities which are optional for Type2.
> 
> In order to support same register/capability discovery code for both
> types, avoid any assumption about what capabilities should be there, and
> export the capabilities found for the caller doing the capabilities
> check based on the expected ones.
> 
> Add a function for facilitating the report of capabilities missing the
> expected ones.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

