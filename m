Return-Path: <netdev+bounces-189056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBF2AB0216
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AAD16EAE9
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A20E26280F;
	Thu,  8 May 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/sXA0f3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6102874E8;
	Thu,  8 May 2025 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727354; cv=fail; b=E2a19P4rASb+gL2LQ3FwdS6vpAK51wkfZfpbQNLV2Ulwf+FOaLETjXC3NyoDXrJo/472v8bPHWTviX95cLCyIyPTvqmnPBPAF299BdxqJzuM1Bm88xB50fJfhGt6w/N+2594jV6BuDY5cMvvecj4IC9t5Y0KXlfbOp54VD9NGKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727354; c=relaxed/simple;
	bh=P//o0qM+2wk6fevqKMwjPbmN7Oc2vRRN49MoAXz3LVY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K8a66oQ0ZMzYhb9V73CiazyQ/qzAeVxw0PT0WAjgsfBHFYNgdcEU1RBaB+/ZpJuc2pzLVPuRUnQlGc/umNOYcSJeswyu1NkGwgkQXFPfwgshhHDC/aFavdeUzYyhLPbyvQGzarsbzccEruMYN7HmLWr0vCiN69duzFtuynkbUiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/sXA0f3; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746727352; x=1778263352;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P//o0qM+2wk6fevqKMwjPbmN7Oc2vRRN49MoAXz3LVY=;
  b=A/sXA0f3K1GXzZTXBk16c/XokR2v6di6wBC/wzEcaNIRc1E01sChvKsl
   PX2twGDFcX1mggxafwYhqXDX7oW5a1wW2ReDAxg55GtxJbAoEy/VMv0Id
   o1UgRX6DtH36jsWuoBMUZuN6ctITxHq18G2AP5Tk80ymR9bpuCUKqwWi6
   bI1HfyvI0ba1VPUybmfanjbIXIHj17l7srbd865octvKU4CfAp6hR1VOK
   UQ2j6QXp71V+Lkq4juBmrAo9eS/9HhE/wcPWo19kINQu9EihLCFOQrNE2
   xWflS+d6MEobl+8vnTsqHd9Uoel6HtuYjtnNWN6rlfdP/8Y/DmarqBZmB
   Q==;
X-CSE-ConnectionGUID: HOJO4T7URSWUH9zRlah4jw==
X-CSE-MsgGUID: 3QDxMwElSvWVkG82jW2FFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48444529"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="48444529"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:02:31 -0700
X-CSE-ConnectionGUID: VTlmC8bRQDOQoq+TQeafJQ==
X-CSE-MsgGUID: bWZn1M/4SU+vwHAq/F0ijw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="141492033"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:02:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 11:02:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 11:02:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 11:02:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDlwrH0CFKxwpdLlAF/M4LtrjwcyHSSiGAO/Cp5YoCW0F0Pj6YY7GRyZ9Jci423hIZVGYLNPys81nzgdW3DhKBpLW9nK0Vol0QYnyCvj2/zJXzkwfRhmyg5vDWQVoaUOWSHzEnRv20Ty5/86utpcrltPv5qoYDbuli9rwAbFyG4TQoxkfXfB27mW+hI0EDloBSQcPTEbeRBkPjbqyRQKyf1mt2kNOtfN6skoP8+OuWs+7+geppxIwe97RRhZVEZyxqm6Zw18q67Dw8uIvIFYmfVRetiCItU5w62vVMWAroz+WOhtYlTPJgIsB+OEsFXFuxlzQAwS55nzEA5XMaNRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgNj5Zjt+rNVmWkAEno7AQ/S6gjy3TOaAtz9om0KSmU=;
 b=u1Vp8p2BS/+htUhS9pSiyFwW8veJtTV4+L1iApeqyhTq72cGvjZQfS+MxrMwOyroTGtHrGv4SGA0ynL37UWt88eF6tzV08ZPcTpcndBsrC8Uhlak0DmiJRh26bzBWqMrGZpEqR8uPV1DsRxkZARdqMpopoY6pzTpw+aOQl93W89PcB614EM/lTpb+NguDc7TpdvhJwnpRwETqhChBlkfrIBrJVei+RxufBNELrkdzKm9/pJdY2t1sXEeYR2Ua7kQHxnQXTqJFSgygnL7kyRNem/jrY0b/DKLoyDb9oIyxtgpI+95azs1w29wbOFSd76hIOlYhcs9mPRN+FLZJBPwmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 18:02:09 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 18:02:09 +0000
Date: Thu, 8 May 2025 11:02:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v14 13/22] cxl: define a driver interface for DPA
 allocation
Message-ID: <aBzxnPdKuFLTKaM5@aschofie-mobl2.lan>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-14-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250417212926.1343268-14-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR04CA0299.namprd04.prod.outlook.com
 (2603:10b6:303:89::34) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|BL1PR11MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfd00e5-ce2f-45d3-5a1d-08dd8e5a73a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3A2DM/nlIiakeJKem5FT7KUt1UBx38BJIdyEsgHGKm+YYLyjwldYDTFZJJDS?=
 =?us-ascii?Q?j1h44yG2kTKllrQALc811l34ctFVVyT4jWTQfcp53E45Sxt9AJ+ZcYSowFug?=
 =?us-ascii?Q?9NOcm8L/THWoeVGzNHGBuzb1VIzYUH+aEeSrE14pPzYiAnmMsh9Pqeu4+G+j?=
 =?us-ascii?Q?PdTRtBjMXtAlWmXokyYhbH0CBwMOPSI99c1EK8UbVO43TjNFVDiLYW8uRJQg?=
 =?us-ascii?Q?4EaUM0RUe3nEKN0XOxLRHJG25WQGkwP0JhiCuBRefB60M5s1XjF2G9/doXdX?=
 =?us-ascii?Q?eFNbvBq6cL/VUsaJK50uw0VC94EPex39oSjT19rstTbwF3+OPy+de36FqwEc?=
 =?us-ascii?Q?DjUS1MSLT1EnZ2u5BxkQzFNkOUU/RieQzXtb0mkbVPbeeYz8RASi/+czq9B0?=
 =?us-ascii?Q?jUHO6yS7Itu4qEmGbKgDXnAEEM7D0ows3+SG5pIq2lhcITpx0D5i5kkBBi6c?=
 =?us-ascii?Q?lELlUPuBCL0lAlwEARdy6pOi75iKosQYvGPJb8SJx6V5byFSYhPhl8aigQ+F?=
 =?us-ascii?Q?KaSBen8eja8pdQJTJ5BRjaRzWuBC/fgiJqrAzFm7xBk4F7g8DTdksnlW13Hk?=
 =?us-ascii?Q?70VZ0y5F/YBKL+zxFQ0kIbeLcof+Lr8aN7sSiR391FrDzL3sYxWkdpvxjmUP?=
 =?us-ascii?Q?gAKg2mtMeGzC/SAgIBBAcLQiaBtUQ6utkzcL8QAD2Z40kQlucVQT9cTEJYML?=
 =?us-ascii?Q?FHbYHDy0vqfDn2VpOKNYnEg4S5vU499fTsHaVG8bciNewD1P9hi9cJgEEnPl?=
 =?us-ascii?Q?wFdbgeqx1KJV0WhM63vhepkneTwfJRNFVWlZ/GjP7dtSklftGzbBy67jOHJq?=
 =?us-ascii?Q?I2624xlp1ze5qvP+mgerxsuQUEaQR3hizG7cqIzzvJByYyWZCLaGsNBVg+Sm?=
 =?us-ascii?Q?HBKwzmQEf74jbKFh7uUeYAKI+O6J3rqG/FLHGrjnXOUStHHQCwhPY4ADFxN6?=
 =?us-ascii?Q?GvIszxocKlv+R0dR6LtmfL9KMDtMVQDXW0liulq7CaAWrYusPq9osVq7wHAv?=
 =?us-ascii?Q?eQez/th2fcgJf7nH+O+mFDHsXZt6yzpU9iU2/ObWbW43nhcxQtWlYrwHx/RZ?=
 =?us-ascii?Q?Jzp4vjIiUCUdIBZybbweLHb9AUtm+LQLdUEjv/U4M3PYk25qu6xNE9i+OEOT?=
 =?us-ascii?Q?ujrwGD6VMyevRi+0Dt4S9v/Cf/JbQdaYpcsKD8nAtGms8u7+aap4Xyjz6F5+?=
 =?us-ascii?Q?R6V4Yfy8IptSorPMe2Qpqhlr0M1xZQ8fnY9JJkq94qwA1dcYTbJOmlPEhhrb?=
 =?us-ascii?Q?kDLrZczyU9NCv6a2DgB9Sebvybzu5ZnmKLgfWzRr3P84YGzKTYzAZlDGVMtd?=
 =?us-ascii?Q?+9HpKHZC56vCqVYJmge5GA+DzRIL6ZmSd8PZa19i/GL2VlzG7pgJAjryOF8q?=
 =?us-ascii?Q?xFbelAv5ivkzH/NPEvRSc6DmhKQ4lkLOTpgIBF2OC0npLhM19RTCDyYtfTOR?=
 =?us-ascii?Q?hx7aj6beTcM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3KP398nz2Xtz00nmBTM69DOhykscSSipAHWafDH3/2+ptvxC65f04AFeb9sO?=
 =?us-ascii?Q?CRdhHkYkUor3dzLvcS8cW98mrstULYz0WpDqttfIds9XOzN0tgCkBpQL1iTX?=
 =?us-ascii?Q?FHQkKPCKLC98sLQ3KDqPX6EEAwk67zlI+UQMgpdTFPFnU0zElkqxdMw61gQE?=
 =?us-ascii?Q?HVwhcIGmb2VoiCXmdRXCasFOkElYVhENmShNXtMYbZAfm9KAcMu1qyx127Um?=
 =?us-ascii?Q?k/asrwfSJ6L/Ji1EbWbZmenPvdPSUl9yVIwEC+4Tkx7ganbUi6ARZgMqJBeC?=
 =?us-ascii?Q?IyW49DjQy841hGznXIs18JH1XhIWW+HV8XY7gjKvZ6rsvv4xgz5lY+KKjTxc?=
 =?us-ascii?Q?7yMjctZXLlWOWWMop879UpQyU90K6BXhE3H5gDf0Zi19ZD7yoI3iml6upwDq?=
 =?us-ascii?Q?k2LzaWszGDLIzJ1LRdZFW8U8QaArVBVYnMCAVWSV1CZyKGNnFSAIGZ9DkPQe?=
 =?us-ascii?Q?8lJJetAnpJ68kIIPSagEB5EXHnxCayaDgWoJenJbfDOLZDzInvAfB6fQwYQF?=
 =?us-ascii?Q?u9/5mu35pzu0Adz2ZzPj8A+aaIUMAZ7/M1Bimr/zrH/s+iiew1hVf0AH4/aw?=
 =?us-ascii?Q?JDtzJlVSwiv7G8Aafeac2JK9rowRnBWLc/X34C4WeoV9l2f3R0XfbmHoB32a?=
 =?us-ascii?Q?lkaGkt+S28OBiHCt6NHbcbTj2riUzao9auaQQphrpGyflVVFUh/nC9ephySv?=
 =?us-ascii?Q?+u+SBbxw6tA1TVQCH1DdaErEEDcJggb07khH+GopF0LBBbBX6ThaoZWjNCDe?=
 =?us-ascii?Q?uDoH2xRuMzYueNYUJW0kV9qu8X9/D+Su467lYi0Y2Ba2E7D+CfT5C60aPzpz?=
 =?us-ascii?Q?McIujM1r3qA0toYgfVOrY6bKnjXYIo4j6VOHcVIjgGINZSQk1ycuw+7etjCH?=
 =?us-ascii?Q?YBKOyVQ3rIk3AqK10KGfp8kT1EO8KmkbT665qcHY17y6wasc+h/3YaeCKrWU?=
 =?us-ascii?Q?7LQbntIQm1fGMWF0gT9a4vNvVGDdJ8LF2Lk3B6BrvUh6pXLnP5UwUSOGIfvG?=
 =?us-ascii?Q?E1LYxW3wPl93Lmfbj38q9qP4fQbp9G/H7e/mt0UfYWUriP8NhVaxgtv0vF2D?=
 =?us-ascii?Q?sT6tKlr0+onNH9EguHHQxEsrrgMCpMvudmPA6p4V1jUNFfOhSPz5H1aV5NH5?=
 =?us-ascii?Q?J7CGf9V+q5667xv3ZB2qZDhpjRiSy90+H1YkF6bRN3c9MKIXR0TdARd0H6gM?=
 =?us-ascii?Q?SHHlsNAwXx8dgkE/5T3C1cIxbd4tCCkg1SqobLW1IN2JfGPKY2fIgE4YfYVo?=
 =?us-ascii?Q?XyXCkjujXriSjoUgaiSNNhxzVezKDMU03V8c+kb0wZx8t/Oz2S9wv6efAq3P?=
 =?us-ascii?Q?vE7gMmfbyx2I8uLOIcEGMs3n8gMLeC0TpAcsZ6pCCMB/5YGWe9m3FNe6fGsm?=
 =?us-ascii?Q?5+QN4MCHCP8SflQgwVcDSS4LK/Ez6Gxj8j4BoyJ/hsq8Yxv7WG5C43UELtgK?=
 =?us-ascii?Q?JCSuiDiEjDVTouNHt3dyAWz+pD16wPqrtznWZPsDhJ/vtgLDW2E/PlUHE/EE?=
 =?us-ascii?Q?bNTrliPJs2Xe7dDsDRmIczjkPWP9F8Nj6lecUsRDXzXQrSMrW9hxqu+iBjI1?=
 =?us-ascii?Q?hrPWRaB0TNbxJ1PHYoC8TAwm8Ox65gwzAHnn7FO+2iuyqC8jcwse00BD1aKW?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfd00e5-ce2f-45d3-5a1d-08dd8e5a73a9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 18:02:09.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /atdnc2sI99hVj92RA7c9IHPwNJ+kgHzxqBGi+o+ntthE2RF7oQcAtAKewDu7nZwSdKx8r/aV3p2tXj0+4OuAdvElcgrd8CKTxveISwHmro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
X-OriginatorOrg: intel.com

On Thu, Apr 17, 2025 at 10:29:16PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space. Define an API,
> cxl_request_dpa(), that tries to allocate the DPA memory the driver
> requires to operate. The memory requested should not be bigger than the
> max available HPA obtained previously with cxl_get_hpa_freespace.
> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/hdm.c | 77 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  5 +++
>  2 files changed, 82 insertions(+)

snip

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index e9ae7eff2393..c75456dd7404 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -8,6 +8,7 @@
>  #include <linux/cdev.h>
>  #include <linux/node.h>
>  #include <linux/ioport.h>
> +#include <linux/range.h>
>  #include <cxl/mailbox.h>

range.h is not needed here in this patch, nor for the set as whole.
It builds without.


> 

