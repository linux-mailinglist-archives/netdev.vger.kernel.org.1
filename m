Return-Path: <netdev+bounces-160148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE7DA18859
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 00:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BEC188A20F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8042C1F8AF3;
	Tue, 21 Jan 2025 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lr+R8wg1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAB91F8EF5;
	Tue, 21 Jan 2025 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737501777; cv=fail; b=WFj6prmxIzcM7ijy1G7+55Ck1yVdpHiLw7Xz75felxTeaZ6O/tJHGUom5y1TMdrAnkwJACPDvZAEoRHFqwge73ZObiqFpWgdGBVM4zK7R941sx2RLRRGSNCOOmVy8PI2adZ5H7DcXNp7tO7ESv/Q9BxQe146uxyAlU7kCygObsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737501777; c=relaxed/simple;
	bh=V/ezv+BOjyQhr+Qphqn6b+khC6SVkmit0TCZWOYctAI=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SJErp4toULiQ/IOtmMVPYqob7pRdum3FfPvegGG+NlQspeJbLkLvjcLQg8yuj8rBW36/Q3RTtZ3GzkIpVfDOOY3mj3LKneK7Uu5zGpiITAvNN9qaMq0t0Qnk8kAc9yoheSIqRa5oOMvtea70o8U4BeeAJY55SeP7K0AXrJJiUpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lr+R8wg1; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737501775; x=1769037775;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=V/ezv+BOjyQhr+Qphqn6b+khC6SVkmit0TCZWOYctAI=;
  b=Lr+R8wg18n5JdajYlL2a3GavWKYhba9nqLyB7PmWWHMHyQ5Asl7Yywxl
   ZkErJHL9dQhm2JBmEMoxeQUhrtpR0u8NAsGy94mVR+ItwPKdvJDJovpd5
   GqBsB8tpBEZXdhJld4MiDK/8SslNMtPjne5p/viO7TPWnwMJgOTvDfcOe
   jTzBHFv7wUhDBHoIrYnDdgY+5VmE2Ep0rv42qmHiOW0+paOqynj/1ka4W
   5B6C1Bysrv4BraFx6B6WL6GqDgiwajR8VkrJxNLsvnJT6oW5oqz6750UV
   +ykPmkr2mzs0FnKOISYld6Pees/93NqK6f44LZusZa50v3Z/F9EPsZoOv
   A==;
X-CSE-ConnectionGUID: EWVoiQyiSdW3ciko9GGcSQ==
X-CSE-MsgGUID: X3G3La/HTwa8p5cDs3BrMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37966814"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="37966814"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 15:22:55 -0800
X-CSE-ConnectionGUID: pMAEVNcdRvGEqdBtYCGysg==
X-CSE-MsgGUID: 4CrpyBIjS16kZXAANDDWiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="111947899"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2025 15:22:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 15:22:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 15:22:54 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 15:22:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0/S1HdNWRTWLcZIHN+1a+mL7U3x7Fopp4eaa1vmtic3Iob7i3fnM3c3rCVt1JWk74SsChAfGqdRjmcNPqbwgHvavhQfYpQGs4udYLsY/wSIF6WnU7dgsqc1rXtlUvWzOzRvWYhMp8EYM0l3qqT8q9j4SAY0+5XTx1uwS+zL3P81KKC/IUWqR+AFygndaU9F+B2S4qGBejppkgPHFOYcatoXIzAS7VA5EsgTG7EMFP9RWNGqiQXxerPbJB5ozDO7LKcv6S0yB/xXLi+FWXtRNQDGHuGLwSqiV59URiLaN2g9lKXi16vEZ/CRMNvlPxLF0a5hLIrgw7zXZS/lp/j6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYRanQCT2lY0iFwRugWalYfEe0WpJxOwfxll1/60WaE=;
 b=VC8dYs0BDIZDLVmpcj9SHrKQrW0LZoyMO+N1Fhi5sEh3uB2n097F+IQJ+/D0wUHbATOxsr9RQmCZJCoNvXXeJ8gdJmqr298hYm3Wurev2iITiJeooDf4RLwxns2BkEQ1pUykXJmV30d5KjKJqAUlAR3SsrVwS2sDZsi3axBTHaqmU9+mXlc37PfChZeOytWrxt7YLo+76Su10uudePyW49pbHnwUu73Dg9QEsvZs5wHkCf76DGs+kGfRiCO6pACMlpQ3pyO+V+YwZf0LD0DvloGCzd/wb+vA1CVtK9iR0o20GL8g4Z5uHLCfNLQj9JQ9LXDxeFBkdNFdNJvjxDCosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Tue, 21 Jan
 2025 23:22:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 23:22:36 +0000
Date: Tue, 21 Jan 2025 15:22:34 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v9 14/27] sfc: create type2 cxl memdev
Message-ID: <67902c3a2da7d_20fa294a4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-15-alejandro.lucero-palau@amd.com>
 <678b14cf84ccf_20fa294f4@dwillia2-xfh.jf.intel.com.notmuch>
 <56186794-e514-e606-8a3e-1b73bdee7bae@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <56186794-e514-e606-8a3e-1b73bdee7bae@amd.com>
X-ClientProxiedBy: MW4PR04CA0300.namprd04.prod.outlook.com
 (2603:10b6:303:89::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: b11f4765-de21-46de-0a7f-08dd3a727dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EYSKpwGLZXNqalSlDG41CIypiOr4hfYhbURZ9lPDwC47/BENEbqG+oIyB07Q?=
 =?us-ascii?Q?NW8yUA/0+VDrno/6Vm/1DE9jt5tSkK1rSDDemwRrKRpGw3oEzSQYgzja+hkn?=
 =?us-ascii?Q?3ubRLnR5yoptDPbpkIyHUvJ/0F85hOm+Ts7zfBOwIUoK6qn4LTG6TfRkROBf?=
 =?us-ascii?Q?RFJ5xI73aTYrYFr7DQ0I6Vdt82CiWOL0i6fTTwoJMGOTCatZEIFvP1BmWOH8?=
 =?us-ascii?Q?1ew97SmDr+JuYOCGT0Z10MDF5zFOf3iWs5rG6c1/nBBRtf7iAE0gO3jG1joV?=
 =?us-ascii?Q?7I+T7XYDwansbhj6lAwVl3GjjYwWBQ8Ow9+DqLdjCR9nOPDsPbQyPrmx4FeD?=
 =?us-ascii?Q?vUhM2OeBiRqeKL8Eu3n8/PPackAUYXfSFKgQ4I11sA/HLkmAKyY9eTkn6tfj?=
 =?us-ascii?Q?eDW24T6gxjMTNmQIFfObeE9ZimNZR2NONEAd3YmxvY5QHaifjTUucIomhEN0?=
 =?us-ascii?Q?7EWBZsgke2O9mZMt2+tVetrJgne0Vm/TDF+lHeUI7VtNTVBwoo0zYCy42HdH?=
 =?us-ascii?Q?DTIbyOv/RiYo2XX5UeLCk586h1kJIli8DcX5yQ2jA539nv4bzZ8UYWrekDzw?=
 =?us-ascii?Q?OzLRGPE/6yYEnQr/3GVS/OA7UZHHWzlKz551nF6omgpsVZPATa/zaCvePsbq?=
 =?us-ascii?Q?N2/h8S7mr1yfaghLFm+QcXUQlZvBKmJHKMzwSL3hvpehDoHD9vm2EAZgKkF9?=
 =?us-ascii?Q?X0gjhCR0p2oHGO3d2uyZ+ViCOhr/hYxbTQnSDjj7XJiDD2KJqoLBhUQFh5/z?=
 =?us-ascii?Q?TBmjxGKGxpDkouqtgUQ84hj4Ch/e6oZ5b88/4ByR7NP9wwBQSVqd30RWKqJi?=
 =?us-ascii?Q?/qz+1RysmOsqFEvkYjWg019U1q2c75IU7R1XBFoi7kIUcuNceYd7i9L88Sqg?=
 =?us-ascii?Q?WcP3m19Y9GKGA4gpZ0TlN3A8enwKKGT6+LhaAposfLtm2nLhcwPGeiVASs+z?=
 =?us-ascii?Q?i+Mg9Zi2eZTqpK/5ErWgiiHQgB3YaoKAyTZp9BRCnxpaK2hT9KoMKIgXwfGC?=
 =?us-ascii?Q?E+2qOyYwSPVZyCLYqH/8Jdgg0VfMjxc+9SUC02ntOt5EFSfi2EfoZPiDCEJm?=
 =?us-ascii?Q?YKBwzoEjn1/LOedrFnHoDy/YwP07pNpSW8fBPM32QBVsbJp6fCjIVKRxEdXw?=
 =?us-ascii?Q?c1kY09puyxMJQbSusZP8scoZJPXhgbCACc10uC/IhVEnnfe1rcTgrD4H+Zd4?=
 =?us-ascii?Q?2hPr/VUZTXKlEyXF5f1bgMq4VJqCwILZk2Z3UsbLeiW4BJ5ewU2ijaDG99mH?=
 =?us-ascii?Q?RsjlpcsWMq2Ay2+9VTKT5pu1XjgBL9zxpPv1G23HIZqUGZTyZv/luSe8dX0k?=
 =?us-ascii?Q?57hMU1fZvnsR7e1fM0dGq515a8/0naA9q3F2lrZ02ZW/O+golVIhSg+Vhy9V?=
 =?us-ascii?Q?qlWYxx5V9yQyzJpTLqgf2tmOcdQQIJmRfoCgC/7V5NE7tUPZZc/LwZH7GW+6?=
 =?us-ascii?Q?ALLgpXeglgw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7N4+xyQZohE4479zU14ztlk6ULK1XQ0NcRqYHbM5D9Qb6ySkSqEjKN0JKYDb?=
 =?us-ascii?Q?k0gOoIwD+xH1goSQCp2WIR54f8bkl/aHUW4ZDYZL+BpSbv/OujjfYVinGDxm?=
 =?us-ascii?Q?UBWpRna2RRWqlJvgskejz0M+Y+SqlC4skRUGNYXwpnoP3xQ4LdvohrP+Cb4h?=
 =?us-ascii?Q?V9+E/Asfh+sGWK1+JxtvXSuyUGt1KlvF1+iCFCuGfINjA+STwNceVgynsili?=
 =?us-ascii?Q?CIINnSkdvBQbzNjoHtI5ykV3/5tUpP/7cmfeL2YNVzPNzVLMmJhZPURCeBXr?=
 =?us-ascii?Q?l/2ZJVFBNPu2PQ4UXSlQUgJi16dg2okRo3mOPh2Xc1qr587Gyn2havmmnSQ4?=
 =?us-ascii?Q?hZTgJEk2IPrXPITj3VtfUOuiGPh0hV0aIHbS8OoxZTbddMMBDvR8Au7CuNyC?=
 =?us-ascii?Q?HhJVMV+FAbOCXQYoJVAAkupjR8rdzTHLiXWS5tO8jzCsr8Rj0YQn9yo7rHDW?=
 =?us-ascii?Q?bOYv147tnABdzuap+g66xQUbN7an/sMA7XRfH+jqGbfRCvSxmtKXG7XtF/79?=
 =?us-ascii?Q?RCKYluQg/Hio3L3tR7Y3G7MTPp4kVALyHcYuHcnbdwbvV61v32cjGRzYBxyG?=
 =?us-ascii?Q?cTJ4s/1az+4qrBwtq8IRDYflqGLTQhkZcPlwxrt6Bf2GTJzLk6yVH9lDSryg?=
 =?us-ascii?Q?xmMo/PPxxbc0SgGChKz4/oLgH7l3j2tHBGQkbhubLxZsmkcpH8SxB1iKHhwA?=
 =?us-ascii?Q?6sY+Qwv7cJIDhaaI2QpuMsO8KE5vZKjUUlmR6qTjx02Kj9uWR1WkL6z0QgHL?=
 =?us-ascii?Q?qJuHjxTHCT6HxQFDmvlO/qPNUffIAPUw6dPMxvbIj6w1jJ7ARrDFlFm3jVS9?=
 =?us-ascii?Q?gqgbHP4+u0Liuyneg4fY8svqvjyciY9ULkukh8l8eQtUemyG2YQVUX4WSUz0?=
 =?us-ascii?Q?x/oMjy/l4kdOqM+WpCzY4Cg+IxUr9G/DT+o1+UxLMME+E3L4GmBB3A97XV7B?=
 =?us-ascii?Q?luBG2WibInnSTUE3V/hzBvqmqXH9GLSsK0YQT32//+Zmpx85i55zE3K8xp2V?=
 =?us-ascii?Q?xZfU+qST3g1xBxbtdJZuWxxWN/Ot1NiVN1vwbynvaOIGY/pG3zySZIjGz5s3?=
 =?us-ascii?Q?sW3Ic03AHuDAfyLIrz0bI+VGMbkB96/hltWxJLno/KPeo2QjGm4/Z5yzwuzz?=
 =?us-ascii?Q?hxkVFGIZvg3j4jX9j+VdyhqliFT0JuhWrnNZrM9VgyQoKUb/RUrvB3oLzyvU?=
 =?us-ascii?Q?eTu8CAUrrUJLOlvNJiZrR3cx0rYlkbXa+8HE12pVTJvjkS4mFWCTSO8osaas?=
 =?us-ascii?Q?ijqOQoFsdTrXeq3FKX9j5OdQHuE0QLCvqmXJcPBtyGLRxdRK6PNmiiSL3Cd1?=
 =?us-ascii?Q?NdiKLZb6bbeKsHPLHcO55Rs3lTCIlK+J3bGNTbQ/RU3YzQ96Mu4ku3l8tPML?=
 =?us-ascii?Q?IYVAIyQ+OwnKCkEz7/mNKjjh7zoHgJxUZIbdUVCAG3fTJwJkxf3NBf4KyXPp?=
 =?us-ascii?Q?WvUi0VJKRtV7RrWFEN78L0tjvCg6cKUPkgbV+trUleDHItTWCmpLC1bX/J9j?=
 =?us-ascii?Q?GsCGcjojvv2wZ5tjT7XlTynr7T+GAxcuTsjrqoZVMZqT5mqgql2YAj+jX5mx?=
 =?us-ascii?Q?evSZ9J/WIPkhVmXb2Vis5eucFSq4bHsG606sjpfGjOIh2L8uzb2K0IS282/t?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b11f4765-de21-46de-0a7f-08dd3a727dc9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 23:22:36.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lqe/toltPBqokFFqVkcvSUXOjxhJsuF02uKvwpHth1Gi6OyJeXcxS3u14t/+/BNBz5w8gZJfoW+frYw8pCUbOobQjctYq91YJMuxIkTbWiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/18/25 02:41, Dan Williams wrote:
> > alejandro.lucero-palau@ wrote:
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Use cxl API for creating a cxl memory device using the type2
> >> cxl_dev_state struct.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> >> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> >> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> ---
> >>   drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> >> index 911f29b91bd3..f4bf137fd878 100644
> >> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> >> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> >> @@ -96,10 +96,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> >>   	 */
> >>   	cxl_set_media_ready(cxl->cxlds);
> > It is unfortunate the media_ready is just being used as an
> > offline/online flag for memdevs. I would be open to just switching to
> > typical device online/offline semantics and drop the "media_ready" flag.
> 
> 
> Not sure I understand the semantics here. Note our device, as the 
> related register being optional, has no way for asking the HW about this 
> (by CXL means), mainly because it is not necessary. I guess this 
> hardware state is there because it can be needed, but again, not sure I 
> understand media-ready vs memory online.

The ->media_ready flag gates capacity discovery for memory expanders
(no impact to accelerators) *and* it gates whether cxl_mem_probe() even
attempts to talk to the device.

The concern is that it should be removed from 'struct cxl_dev_state' if
it cannot have common meaning across all CXL.mem capable devices. One
way to remove it from 'struct cxl_dev_state' while still preserving the
memory expander use case is to notice that ->media_ready is effectively
identical to the 'struct device' @offline flag.

For now, just have the accelerator driver set ->media_ready and we can
work on cleaning up that direct 'struct cxl_dev_state' touch later.

> >> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
> >> +	if (IS_ERR(cxl->cxlmd)) {
> >> +		pci_err(pci_dev, "CXL accel memdev creation failed");
> >> +		rc = PTR_ERR(cxl->cxlmd);
> >> +		goto err_memdev;
> >> +	}
> >> +
> >>   	probe_data->cxl = cxl;
> >>   
> >>   	return 0;
> >>   
> >> +err_memdev:
> >> +	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
> >>   err_resource_set:
> >>   	kfree(cxl->cxlds);
> > In general a function should not mix devm and goto as that is a recipe
> > for bugs.
> >
> > The bug I see here is that devm_cxl_add_memdev() runs the teardown flow
> > *after* efx_pci_probe() returns an error code. That happens in
> > device_unbind_cleanup(), but when it goes to cleanup endpoint decoders
> > and anything else that might reference @cxlds it crashes because @cxlds
> > is long gone.
> >
> > So if you use devm_cxl_add_memdev() then cxlds must be devm allocated as
> > well to make sure it gets freed in the proper reverse order.
> 
> That is true and I think it is easy to fix, even with your changes for 
> patch 1.

Yes, just add a devm_cxl_del_memdev() export for now that can be used
unwind CXL core objects without requiring the driver to switch to devm
more broadly.

