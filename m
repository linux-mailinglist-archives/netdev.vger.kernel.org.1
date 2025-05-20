Return-Path: <netdev+bounces-191710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF999ABCD5C
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919E217B5CB
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666541E492;
	Tue, 20 May 2025 02:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nm9hKqCr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ADC19EEBF;
	Tue, 20 May 2025 02:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747708928; cv=fail; b=OBsAr6UgfforThxcpFX+542tJGOEs1FVS7sZ4pbmfgkuW0JUjmFDV3mAzY2gzMkuHmwO0qwb/ULo8RDUk8+3PWOqe9P9Ga8w51Sh8t8iq+d1DWH02yWI70mUtpbi3MMq3c6CnLpujJkRzq6nAnTNiu8pTJnzLEYG69kzcA0FZ14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747708928; c=relaxed/simple;
	bh=eeX7KXRLVLKv5RkoLDWBWoHQMgry4eL+4bQjBrzy5Cs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A+Y0VRiTZvz3Z/1SKvuVAfS0KK972ST3f4r8crQBM+KMrAACul1g5KRLwPiVl+HIX7kl1ZCdCRekBV0VAvPeIi6vxDlAtSaVWFEP3KgxFB/lordMC9UVQ6KYCHKk8kbZVu6vab/fNGk49azqAtxQIRgVgKMm4wTyQGOMGgyo34I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nm9hKqCr; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747708927; x=1779244927;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eeX7KXRLVLKv5RkoLDWBWoHQMgry4eL+4bQjBrzy5Cs=;
  b=Nm9hKqCrqOVudlzwact8BJFwev0YJDsyPIAKTpuCVuvO5RrtcrCqZS5A
   oEvlk3zjpzcmtYZ1Moryq/2GoGq7BglZ9Mn+dPQp5ZPBvM/JbK4q3yKBq
   pAUzliQ5488qcYK47egjGJoqlOtV6MfKfAD7JHOTRXq5/Pcd+gZ6oyt9H
   1J67BiCLio7dCwZrB3LAybPwUH2O5td7MFW5iUkc2aqdBZxWSwhSm7wkS
   JDbeOTmAZqrHEqjDkfM2R3Tw4J0BNPVuoH1oqgrqDf6aP8XlNynesNmfj
   FWuMN5RTJhgdKUikE4is8vWtsmgNilzVaQ6Dkp40G4c7kzDSWWn6KRvVu
   g==;
X-CSE-ConnectionGUID: hAi5rC/USmCmkfzlX9HeHA==
X-CSE-MsgGUID: EDqhkOkQTlOKf5Y34rB/cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49780627"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49780627"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:42:06 -0700
X-CSE-ConnectionGUID: PkW186enSsaOREs5h/MHgQ==
X-CSE-MsgGUID: dZoW+DAiRYCAgf2+Tnr4jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144417981"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:42:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 19:42:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 19:42:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 19:42:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzXH5svlQjJNN92BXx2wzaH5Wzn5yqc5huGZH155eW+//419712kQU9I1MjGr21D4EXaO7LoLDaSAMyVBeT7dlLlUH8oxz0fdUPfYwdxvxCRsx30uwGXAk15LQJLFJaJMuOJ2bcryIjHNL87K5mCTqoaYwe3EkACBfswzQkrzByvFNoqUgLAbFh31rlzW3f4zlT0Ir00mZLet95auynYb+xnNqXx9T5on76LuyDidHDuIlFkKOruNm9LQMs1FNMLgzaSbK55SXmCCDUbbrZimxteXdLSbP/jhOpKbHVwQz4+8dD65WtKWZzIvEhtSxrek1hAzbgEtUfAuVwwhDflCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDSzX5i74sx476gh87v5zC5Om8AXOjrzeX+BhnVLH2w=;
 b=SHdENq1ILmnbfjq1h1tyGDTuyOhZ3PpoeOeC62C9TUw0jmWayndomp8cL87K74HFTB+QEsqIRDwGXZrX/1gG6Xm5Qg+xUTBqeXqAmxrU5rgbS/I5raHVg4WbU4o76vErUt6Rj5CVNrSwOm5CfQ91Vz4hPcOd+AALQ1/rTf+ehQ+NXWDLtNktXPDfSEMv4fOPzPyITh7NhkRlMdJ2rXJoNiN6FH6Hii9mbdQnT3LKhVVim4xZh3MVK1r9BD3ZIL7gnh1S87WaWqWGf1gwLHFeAjmvdhfyzulTWRUx5WHi7aSwSK4GoK5zLI7vd77WwZcYvTaSMyzP5Y0k0t0UzZ66kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 02:41:34 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:41:34 +0000
Date: Mon, 19 May 2025 19:41:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 05/22] cxl: Add function for type2 cxl regs setup
Message-ID: <aCvr2jF2bXhzQibl@aschofie-mobl2.lan>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-6-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR05CA0193.namprd05.prod.outlook.com
 (2603:10b6:a03:330::18) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DM4PR11MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 2365e92a-2206-4db0-e024-08dd9747d5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zLejuz521sM0shJlq1LSo7AdW4Lw3M7r+QjQJYjFp+6Ad3r+VvC366m4k6Qs?=
 =?us-ascii?Q?8jWK5irS/nNU8Oa/Ie6YEaEnTie76OGZYELjhbHzSFh6UBG0577NzZOy7JM7?=
 =?us-ascii?Q?lSys8xn4SakHM8tLR0HbTBHFpVhW+rv9Lb9QDtjmZUln2Lf1bHdxCBCfLdJG?=
 =?us-ascii?Q?vHp7vG0iXJJb1BZVpw7yp73NXfMFQgooe6GFYvyNkRCF9Mf/ZVMTTcYIDOa2?=
 =?us-ascii?Q?zqJcvFPy9sdiaNA5y3WIUdDUhWoasuAxEa6skOR/13V870tVZpAoOC1skKVI?=
 =?us-ascii?Q?SS+AVl10bOH+z6zEOTt0Z6EC8pBznz0aFHb5KIV78GU8gegJcGK7OpJVGy8F?=
 =?us-ascii?Q?FqHnyg+Rp7CG2cfMq5tY2LhyfUgj0QhggNgWkuqnE+/tkKoF77wK5ZDmxos8?=
 =?us-ascii?Q?BJ6pHXajLghGpY3XbmyqfgykvIF1ZbdRbEZO503ciX83cpe7L2fAisY8rtud?=
 =?us-ascii?Q?VlG3ML4afUuYPB18YRHNreJlaezKIsrq6mhOkLNbd9aiElszf6zOi5PpcHAB?=
 =?us-ascii?Q?HNAB/M0wEIG8U4kgF/HvgXWFq2nhCQC1VF/cBSzzztzmsZr6vMUeogbgs1O2?=
 =?us-ascii?Q?fFRCGbOuD4qGIV2vIsAo4p6rb0akV1savHlG0D4CgI75D+LiHNjF53TYDzxt?=
 =?us-ascii?Q?ew1ipEn5FpOzBztM3ub1S6t7PIIM6WZzC0cpztJq7yUBvxGOsNP5ZmrjDB4X?=
 =?us-ascii?Q?TPzqia8HcEhe27QfKJNSEBTOXETcXIy4CQ3Rn7zVA1/2Jr7WLQZJ1IqYKV89?=
 =?us-ascii?Q?i6aXETkuRoV43zctOfMn056PZWAEZIDDTEs0ObCFl5eKhAvvNL3XJrNRrnTg?=
 =?us-ascii?Q?25cGeFEQBYzCNrfiEwVAufkJYaotZpydOIjYRblUDJPB7h7pKSBVnC6j6io3?=
 =?us-ascii?Q?y9LalsD6ALYgDU+al5i9MHEzsoRaftlNQvsTAOxxKMU766cX3cB3QbWs/jWQ?=
 =?us-ascii?Q?X5xriEb7cw1bqWKp2yRkDyDH48rbQMhj0icZK/ptEbmsURiPpIHiVbq39XcL?=
 =?us-ascii?Q?XD0Q4iTX6rN1JcC0Vv+utb/IygCcfJv+qpUgUlI1nOWxSpwiAu8k766ABFpt?=
 =?us-ascii?Q?gjhs9C5xGJe8Dzkufa10CpVzdiUKrptCSrEf4K/KsNIOnFOGVXmPpE1dIR8Q?=
 =?us-ascii?Q?hYeuBbYp8hJ+zJ5E4IxpCtem638eBjUZoqlQgP3NXOLhCDIgFWGsHtCiNjWd?=
 =?us-ascii?Q?JbXMHk/iDnDqH8XPq9a98DOA9L94msctH6Jiwh6rQpPGdBm++yMAwERIByHs?=
 =?us-ascii?Q?JTp/KY8Ew25QxJj+tc8LPi+qqfASPmtrtmI7s2REuL59Ax1dNEyoNOhNaKKh?=
 =?us-ascii?Q?ZAGoApDw8CQ3GpRwNlNWeLafV6G65NhhFjtu7skGJk3ke0q/DcXuaxDqZgcJ?=
 =?us-ascii?Q?So7SbhsUBUZYCti+3QswL4+xcS2oYRv1OXC0fKjsYj9i5BUWO5rYKAo0DCog?=
 =?us-ascii?Q?DTNDVKTTr2I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EUndduYk7PPk33HetShNjjkXKI2iZ38TIWn+MAeqC2rqA0hUL157M/ggC6oF?=
 =?us-ascii?Q?CWiL6Thi2Q9JituZ6OK0bDoHbP0eeFejDbuFi3a5cBg6EnWRkZsOjWGShGBB?=
 =?us-ascii?Q?lJ4BfjDQAeCyH/l5V72x2N3+ynqfEgZnLXPP1tFTBe/COyykEy3H7XXjn7yQ?=
 =?us-ascii?Q?eltpQFzlwinJ+CX9j2XDLSxUI2IUBJozK9D3yjPMzLwkhqybqEXhsUScjyvF?=
 =?us-ascii?Q?LAvpfRTh96WpvJru5c0w7cQkogGKjLepLzVPMZeIQsQ+8T1TzeC4hLfPLEIH?=
 =?us-ascii?Q?OJPrBI9iYMN70rWXjvFfpqw7syf8f+JnlXgZmTsDoZLFYqqoODUCEG/U67jn?=
 =?us-ascii?Q?dVgsie0WzoM7NyssmlJDPAEZ2vmaPY/fT53Lfb52C/IZGBmoehPKNaFEtmiq?=
 =?us-ascii?Q?asWMv6ECpnP8CiFaI4boFXlKTlrtAJ0+zWidRYK9rr3dgM++eaH5H9BziPtN?=
 =?us-ascii?Q?kqMnzP1zdqLmP+6H6iR8JWodxRa3a23lIkJVm9Qrly1+UtT8gpjHpMF5jhS5?=
 =?us-ascii?Q?P5TizlShHC5IXT5dJHZfmzcbkRISDELS62LPr8uznHBRrdAVV4cjyfEiS7k/?=
 =?us-ascii?Q?bHKsnzmZyqPYBETCUAFwgO9AIS4GmO/HIM/uMUSwF/z2hguuYpuk06eqMNSo?=
 =?us-ascii?Q?SwWpfXLO9SX/rclTqNFGevqujNtmKnNzNLCovBsqhKPBFvc1FBJsjukZziQn?=
 =?us-ascii?Q?mCU3SBcP8wdqFX77moChTz5khMrVJ8RgH3fUbL7M86PUzHA+rgGCuEL7vPY9?=
 =?us-ascii?Q?1A2nHJfuawzrdNHlfntw7tsl6W2kzpUi2WpP3POANFNhdx8aRtJoV0BNlh6F?=
 =?us-ascii?Q?dwbWflKMJB6QKet6GKVUoobi7nTAOJhAT/lZ7bA32QwJuldCX2JgQXHzsWMc?=
 =?us-ascii?Q?j2rqBwSAElwJen8LHoF50Y+41oATv8mWTefeiZ/qNxjRQ8j8mgh6RYSbsBdo?=
 =?us-ascii?Q?srQtvjw8OleEdLGP1MNkdb2pcnQ91IaVYEdemL9DUl4GBLGxVM6MsyfQVxf3?=
 =?us-ascii?Q?MakhMJ2NIUFQ1y0Ys0aiPwwY37DI1p/xuaHx0Cf2GTGYsW6rpsyapUPxy7rm?=
 =?us-ascii?Q?vw1xUo182fGJRYgsPAfn5/BATQWocDld/PCWztQavNMc+l4SawKZPMeb053o?=
 =?us-ascii?Q?nhcJSg7ESIg0WDxPg1TG0iwTzf6Ek7clTXl/DgJrkv+Mu6NCOlVUTlpSY+D9?=
 =?us-ascii?Q?+f8z7ssMJRsAtInDOOvjJdTf6FOdIHoec+jRdWReadgG0r7amFtPU3BxLorG?=
 =?us-ascii?Q?A6dCfMO1eVSCtrJzImuuvm5hAjn/KrcPpuspAzwwMCwLVzCd82ppD1Z00Ox3?=
 =?us-ascii?Q?GWGKX/gaycsXSMxVvSRGSavg8sLY5NyXSGXzTd9xCpk1+LrNT1jWK+1AJ1hU?=
 =?us-ascii?Q?BDik5HLU+tdtXPrZ+qM2yyLU7quLFZnIv0NWC9PaYev7E6jkYifiWjxlUZoA?=
 =?us-ascii?Q?AguVmruixuQd1A2xIwOrogYJNiq3sxCbCJDu0CnSAPOxSFlIsxQzVONwcf0s?=
 =?us-ascii?Q?6vCQYP7ofBG7jzbl0VaxqmSPf9QcXR9p5yoYMEgVHnXmE3WC+BaqeIRIaaUc?=
 =?us-ascii?Q?uNcWanwyePgzgcUIoKRZIqONfEY74kKKvgVs70JPZPmxcMzr8wZauA5gGcyK?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2365e92a-2206-4db0-e024-08dd9747d5e2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:41:34.5320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryaUroRnStH1HLiz3ORtHxvUo1J9ThbGgUZBUk+2U8qA4Gk5eM/7bOUT4xdKeUbjwo+Htl/aH65HihFE52WR1FhJwagRgBGdpBm08p2CFMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 02:27:26PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device initialising
> cxl_dev_state struct regarding cxl regs setup and mapping.
> 
> Export the capabilities found for checking them against the
> expected ones by the driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

