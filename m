Return-Path: <netdev+bounces-236946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F87C4257D
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 04:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E293A2B97
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 03:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DE0261B65;
	Sat,  8 Nov 2025 03:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bi2jVxTy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81115C8CE
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570937; cv=fail; b=dOZJtHr0DkgtVLErMM6hlI8W+waTDASCA0B0VIJ6cz8IaO0pHlmbKx5zKw5E8girw1ZRRAbHskQOffUpqAXXUlhBPscsQlTeAPP80XoGwgmqQXaYwb1awh5ErcZk+szV+jq7znzvxwmJsH2nfPBySjTohJ0Zd9JiHRllDT4Raz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570937; c=relaxed/simple;
	bh=gGQAD5VKaHItqK4E2DWGTDybxc/8OJn4ZZg9B68vn8w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EjsVciBApkLkQwe9UG27M5Of9sgR+I6miSbHgyo1WqapNGmZpknn+pvaC5kBCMLRnU4Ov6rENzXnUkJQU7CTOapWUZzqWbmmF07EcVuZ086PmsyLa3V1cthBfdXgtHhWkyqCpOIwpDb+F6hH8XiJY1rFUrCJMeHH/Ed2o1u7rRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bi2jVxTy; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762570935; x=1794106935;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gGQAD5VKaHItqK4E2DWGTDybxc/8OJn4ZZg9B68vn8w=;
  b=bi2jVxTyV0Zrf6DeP5BgDCN+Ask1xhBqFi8vTSWNKiQpNtD6my9yx+oo
   ah+bEut400rkXoedkEAHL7VOrBgVTkglOuqlaC+l+jleOrgLmxgdSXUg0
   VvVk6YoJ6+Z6TvKObhKVqHfTLPOzNCcrIDWcst5sPw8vtghYY+4pTlrwX
   5uWkH/PqPbTwlS6q7fxeStQKiaZnU0ZR77aXQJ+z5VwEFFfxSvF5+Kiwv
   l6kBVXV8KiVCNOHv/bGv7iFOfrMzmNFg5mi+L53PUf7SV7crGblBE4/j0
   Nn0s3+d/tlfkd9P/MO9GOXpfojQ3gLeqKvPOPCgSeDtrpgNVwZLJpAM9w
   g==;
X-CSE-ConnectionGUID: U3AI3EhOS+qBvcaKB6BwBw==
X-CSE-MsgGUID: d5VH3D/MSNGPy6Omko0HSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64627912"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64627912"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 19:02:15 -0800
X-CSE-ConnectionGUID: 2w4Ib4ZbRVOnyWO/wdS0JA==
X-CSE-MsgGUID: JXv5QbkESoy4U+pyhvUgeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="188363505"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 19:02:15 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 19:02:14 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 19:02:14 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 19:02:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mttto9Z5K2qTG5coRkLqbTwbodCr+2vSpw1WRZcpiOsJoTHSKdjWJIoc8453tn32YeuBRpq6exFZSvas8rLXVkYSmZcfu1W4EiFT2I5NHXe1RkX0oOe7o5245/5ivsxhqTKsMGE6CDMATNw3zacYqDOF20dvhn3AiC0Y+CItqAV69oyIZ3tlRMLHomTVsX1OC55umNlrPKWTAxNXrxGjYGJkxHiCVHvV7M7B8VyPdTXZiLValypg6XDRQcsTzQ9IMVoU2lNTrqyAytwBDWgqI2qQTSDlHPmk0e/qVfHXHFbuAjwmydymvgXQvEoe8phFZqSC/JbVaGqA24OWQTl7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWA5zyBWrsxbe/sITGo3hZlQXjnD4gOQu4ewEN8BGI8=;
 b=bg3PZE7uNUSGHDiEw35oTUISudmzzeFsSN8n+hazGnUkLXEIRuozXo2q8POSaIITMKFuXLQyCULNml4DEf8IAXtewUITWBp1sosEh6riOnRSQHUSa0mRcVMaDBuwpiXW6lWkEtwXVbqDqQ4j8S8XZjMj+Xj72TP2QfDMYNCo2YFxuD2RSQZels+hjmN/MQ2anQCrcwXU+6p0m+7O4wbscz71FFuonpRF7nGOLAo0J4GVuahVHAoXYnS68Kn6sZtRCXNIwCD21kaMAuRcYGj5BplJKlyx9VGfskMwk09ttdKW3lcOijNgPpq20KvwWyqzSmyn7RJXs3xNn46r6501Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by IA1PR11MB7317.namprd11.prod.outlook.com (2603:10b6:208:427::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 03:02:08 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%6]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 03:02:05 +0000
Date: Fri, 7 Nov 2025 22:01:57 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	Lukas Wunner <lukas@wunner.de>, Dave Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona.vetter@ffwll.ch>, Aravind Iddamsetty
	<aravind.iddamsetty@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH 0/2] Introduce DRM_RAS using generic netlink for RAS
Message-ID: <aQ6ypQ780i11jzWQ@intel.com>
References: <20250929214415.326414-4-rodrigo.vivi@intel.com>
 <c8caad3b-d7b9-4e0c-8d90-5b2bc576cabf@oss.qualcomm.com>
 <aQylrqUCRkkUYzQl@intel.com>
 <7820644f-078a-4578-a444-5cc4b6844489@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7820644f-078a-4578-a444-5cc4b6844489@oss.qualcomm.com>
X-ClientProxiedBy: BYAPR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::41) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|IA1PR11MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: e18bd5c9-e252-47b1-5318-08de1e7332c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kSmgrUYAfXFC85TfXQBKVKIMZH6+lOOlLzW3xLQBd3u9033DWoWBOBLn/vpS?=
 =?us-ascii?Q?suxAwmwNAbXMA/LIg0nWOSvmu76cFjD7pLYdfA1D8O83WVedoOrwkgZilWAS?=
 =?us-ascii?Q?9GepSYw9QfZ/1ZuxO9qu6QbVM3XhUSiDAOgClOeWjobbqKFN1wYBNZQPYyjr?=
 =?us-ascii?Q?ez6R1ARkHizR3W5H5+fYa7r8tscRx2FBLGKAvIcLc2R6QKyyFefzugoVAITE?=
 =?us-ascii?Q?JDV4gbTGtjYi19DKhw/VBMw5HEgZ7jTRhnQWpfErGc8aN8OnIbgknH1QW33X?=
 =?us-ascii?Q?Yj+YzEF3MRO7cgHXOHg3nTMTOf9GD+ofTFQWX3wMwF2za8vJWiSdDDabkIr9?=
 =?us-ascii?Q?RKvMcxHuzQQ74NpFD73ilIv9WEXojXjcvHgUVZ8lbn/sGkch1u1O5Yeh13rB?=
 =?us-ascii?Q?XH1qRuyVLXQLIxAWw23WHBhLwhR3W9Zya02b6Yjfdb+t2nUqzrY70rOPFxzN?=
 =?us-ascii?Q?w384Yy1fDmXJknN4U+HJTFi3n3NOAjz//JyxaklczIUmeCX9ytH+otq4w2Gx?=
 =?us-ascii?Q?IdikJiDKHbMxpIdBBXIh+PUcKjX+eEchrjv+3rRKFEPS2h0Fh2H1BQZoPkxY?=
 =?us-ascii?Q?jKojjJhx1yGQ48EkJeySHk1UfDoQ2mv4DeMhTjNfkvqCmJupK0ZOg2NbdTNd?=
 =?us-ascii?Q?UU43/vET5dzrngqm1bhNmWqoXFd6zA3WBvXfcY1ac+lx91CBvVoqZevVGXlo?=
 =?us-ascii?Q?YBYorF9qZqsJfthoicPlMpgIXXMuWmSPmiFjtMHzIru4bUKQbxj5w1b+yn6c?=
 =?us-ascii?Q?DLdqsTngJfz6UyppwBUAnYkjd4hsH/Cw5KqkXxz5+PHRwEfk4ue24px/rUpJ?=
 =?us-ascii?Q?xxa962PzBnXSHs5l55f205E/l78jVBbbqlTbdDvIupDT6CHsV2wOPp6TDQfn?=
 =?us-ascii?Q?O8GcC8C1Cov2dXJcETe3U1hKGElfwd9wxVlrVKyTh3VRWm8hlU6Hksx259R/?=
 =?us-ascii?Q?0+OcHFF2GwTdFkM5eNbXn6XQKLEpr5pi8zoCyq1+BLhlBmhY61r6V/BO6q3h?=
 =?us-ascii?Q?/6IOJxrVWbxB3NVBOc2Mze54E1SNB6mBZla+bI7MzBD2NI9lQwMun1mrsV6s?=
 =?us-ascii?Q?Ads2R7RfhoT3scrCfxtXQ7UiJMxaXJUQtFrNXMD2IscmPmQ/ipyTdoTkBTve?=
 =?us-ascii?Q?Gft/sa6z9fjFZVKn8y7OA1NgvBxlLu+VZpN56WKeQ2k9Lk/1MuMqyZCdAzVt?=
 =?us-ascii?Q?M6hpHAw64Krh/Kk7ZTMf/qWe6i/rkjHMFziz2gRCwf6blaXH/lsq7UM41ZcN?=
 =?us-ascii?Q?11QlVTQbbGFCFDqOQVTmfxwqnTGHLelySC2d6wAbHyEN6VgkgyXY47nT23cn?=
 =?us-ascii?Q?mYiCG6PCmuxLCrDItQqqFeKBvXQeSX+fBmPrgKlJEeW4dZtJQpyDSAHjFKQP?=
 =?us-ascii?Q?aXVx7ui5aR3kaAt6cq0cjcbw5dwVteQz4OG/QET8TI6QLlOVy7u/46xYdMuG?=
 =?us-ascii?Q?tEIk4Rl47lJq95lg1dPsD7ydtf95Y2Av?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yy8pRLZO2m3HwZ6DGZ2P8org+BXjI/QE8tPAeWygfXAYQMW8ugT+M6Hm0B4Z?=
 =?us-ascii?Q?MnxKB0IC3hkR0VKO//PlFuu0EuP0mJhwac2n5mW8Ku4xdsFGGVFc6/KUgsB5?=
 =?us-ascii?Q?9D1pHx1Y6Sn2txcZ0j9AUvcnJqt+yuGVuW1c3bx4+AYweFrfr6I8wieydhfj?=
 =?us-ascii?Q?MyyqA9cFvf9QFeO/TeJPU3/1PXyLBjtrSxL6bG0ZjwdIY6B0N8jkTUlqMTk+?=
 =?us-ascii?Q?SQqkquYG5QZIal67Gq4kGMhwze/aAmtYXssIoyuKl+zZYy/Aoqc4t3AgyJoo?=
 =?us-ascii?Q?QZ0uJMS6cBxYO/ZqFUbOScJ5KsyzqmU5R7mBYNqfXTSc1hWY+Ghm/6dLNOBX?=
 =?us-ascii?Q?EfPyjagMASsJp2s1dVmUExXrgUhda6MurSfHrY0umHLrhU0OS4w2DAX3Z2KH?=
 =?us-ascii?Q?A2rTLOY3tJXBOK8kc6Mml1QG+lyvH8CtjXJZhlH9XqYsi68k7Lrzt7XE6dXt?=
 =?us-ascii?Q?dJ/0qp/KA+DvcPO9CalKdtfsGzDT5mOt635VXVB0fUtE6Aj0UJsern3rtjVy?=
 =?us-ascii?Q?9pSV1tgHSiowvpAQqhpt3GqVDCjuchi8RohFO/cBVnNEyDt5hFJVzQeCOqZu?=
 =?us-ascii?Q?0Y9U7SDfQ95WDgx1fnib/x89KRPILNNUULloztkbnMSnoVTPIKeSk1m+Eb3Q?=
 =?us-ascii?Q?L1rj5wXuJYFG9jtTExhxSzcDFzRYLfvJCavZ8nE7nBBS491mt2ZFtKucwKj7?=
 =?us-ascii?Q?dwFLhMk6eR7/A4t0bA1/7jB/uysc2mFCNpvOWR1deXtdYn90/2vrkvc+KV0S?=
 =?us-ascii?Q?dQp9MoeskpOI5/jHv5Uz31vbRsP3V/9dvkfErWNctjAAJTsx8CdDWELF/hh0?=
 =?us-ascii?Q?xcF+HKjY2zOhdQcltfjRdC4pg0tFK+u8V/7qnFDWlz96E7Jc4kPl5VgXfJ8J?=
 =?us-ascii?Q?zcjOnNFuLSODuza9L7nGDDBsBWHxvrZjiq3o05mfvTkbRwwJ5XEMonkrsDYQ?=
 =?us-ascii?Q?I5zOdXuAgwF5a9+Tn7ekmeKTwECNIf42NUvIBycDwP4nuKz45RVYnoAw/bLe?=
 =?us-ascii?Q?6K5CELOfovqf8FGf8P7k7o1ASSm7P2aVK+9pc/5ta8wWreCrk/VuRiNl3kVn?=
 =?us-ascii?Q?njxe2siIi/JZAU4NRJPrTNuSI/as49Dks/o5tbGgvmntWldbtmRL7oAUTFJS?=
 =?us-ascii?Q?39Fc6OPXlfEn9QQJYZJktZpdaLAYqywk+N4LQEG/p2KcaByXHTV00mHjbsqP?=
 =?us-ascii?Q?Xm9fpFP+fAZEg7b9g7uaMjHq+81fgasr5JUbLlh7H0GDrV3kCnY/Hu5pP+H9?=
 =?us-ascii?Q?NPRp90JKjoR0SF+ITtWbxf90m/olK5hoedmGxUqrFMGlZ+V7acoW1xhoY8BM?=
 =?us-ascii?Q?H8u31HUL80juxmI/wP5NGQ6qUx9tD9Av/3rbEkIGlvcoZI9i2MA93AOzfhK6?=
 =?us-ascii?Q?VpcFr38AniIBfunupet7NFHOFw6VztjD8D3MgOkpP2Tp3hMmt809m8E+M4C3?=
 =?us-ascii?Q?mldnhcFYlcJY2j4CxqM9wzeBhAc7sl8vLxk83CX5SC10vlrD7CQd7mLKkL2q?=
 =?us-ascii?Q?bCLW95IL3NV/q4V3NTSL6QQtoc2bTOD/+wQ3C+vWJ4zxLSAac603VR/BWZ5D?=
 =?us-ascii?Q?zL3XIOGG+5D46SXGYH2hhyS+Ypddq7PlI36wVzIF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e18bd5c9-e252-47b1-5318-08de1e7332c9
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 03:02:05.8576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAa/ff/MFUI9z+awD+/9M11/nlKphlpraYWyXihh6Hv4DZJ2ErkX/RlmdOpXXCg9cTHXEI8kO+OCB4v3qqwSBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7317
X-OriginatorOrg: intel.com

On Fri, Nov 07, 2025 at 01:20:03PM -0700, Zack McKevitt wrote:
> 
> 
> On 11/6/2025 6:42 AM, Rodrigo Vivi wrote:
> > > 
> > > > Also, it is worth to mention that we have a in-tree pyynl/cli.py tool that entirely
> > > > exercises this new API, hence I hope this can be the reference code for the uAPI
> > > > usage, while we continue with the plan of introducing IGT tests and tools for this
> > > > and adjusting the internal vendor tools to open with open source developments and
> > > > changing them to support these flows.
> > > 
> > > I think it would be nice to see some accompanying userspace code that makes
> > > use of this implementation to have as a reference if at all possible.
> > 
> > We have some folks working on the userspace tools, but I just realized that
> > perhaps we don't even need that and we could perhaps only using the
> > kernel-tools/ynl as official drm-ras consumer?
> > 
> > $ sudo ynl --family drm_ras --dump list-nodes
> > [{'device-name': '00:02.0',
> >    'node-id': 0,
> >    'node-name': 'non-fatal',
> >    'node-type': 'error-counter'},
> >   {'device-name': '00:02.0',
> >    'node-id': 1,
> >    'node-name': 'correctable',
> >   'node-type': 'error-counter'}]
> > 
> > thoughts?
> > 
> 
> I think this is probably ok for demonstrating this patch's functionality,
> but some userspace code would be helpful as a reference for applications
> that might want to integrate this directly instead of relying on CLI tools.

It makes sense. So let's continue to have some IGT tool for this.

> 
> > > 
> > > As a side note, I will be on vacation for a couple of weeks as of this
> > > weekend and my response time will be affected.
> > 
> > Thank you,
> > Please let me know if you have further thoughts here, or if you see any blocker
> > or an ack to move forward with this path.
> > 
> > Thanks,
> > Rodrigo.
> > 
> 
> No further thoughts on the patch contents, I think it looks good. I see that
> Jakub posted some TODOs while I was away, so I assume there will be another
> iteration that I will take a look at if/when that comes in.

Yes, but the changes in the error counter is not that big, just some better iteration,
small fixes and a fixed driver API regarding the error ID and error string.

> 
> > > 
> > > Thanks,
> > > 
> > > Zack

