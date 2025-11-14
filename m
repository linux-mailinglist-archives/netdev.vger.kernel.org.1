Return-Path: <netdev+bounces-238536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F75C5AC30
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6778F353F92
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91D21254B;
	Fri, 14 Nov 2025 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGxgFuGZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE72066F7;
	Fri, 14 Nov 2025 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763079929; cv=fail; b=sPIazJmvUH4Y5GGoL7aWRkgSmere5KedLyAj26ReZzmCsf7EoDWq48iW+aLvQG/VJKq3Wg0qyoMPWFDQJunlX13lFHwUzKtTivGQtX+AgZM36bkajpid1KfN79VCHbuAMs1G9g0PIMYBfYCcPOqq5J+LAfDnu3QKCscAl7CBuVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763079929; c=relaxed/simple;
	bh=gH3meI4BSFgSBXbctCK7mAw8FQDrlfDqNkfkNNBk1K4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r8Z1nLmD7RX3Ybuo+tOmrPl/zKKP/F4PE4zkVzfTBYgLi76etKwJVobmmBOdiQcXmrMW+y7Oecg9dggnm0pPtwnVFX/usFtQ4iv+7buF53D5K6hGqvl7BOpo4ok7ksopTPfh3QA8LT/IWXRs18RHLAuExrx5QqCi/+Elwdu9LfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGxgFuGZ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763079925; x=1794615925;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gH3meI4BSFgSBXbctCK7mAw8FQDrlfDqNkfkNNBk1K4=;
  b=HGxgFuGZHyqlZaYVovr/ANamZFn/xSepVxkqasYcnpbJXWJ8lmXH86Zs
   pRV3z56zrSwhrwmhAUwA7ZNkaWgcy0qe7g1n7L9TXkffGmKG5Vo8JIA7S
   CZbuDkwbwbVMeLXSXg5RJox72GcEz0AGl/MRck/uLZNhIx+eCpfhUi/BV
   jLnQDK5KPmav/obmWshLDrqVsPGQOkpMwdaWq6NdMzzd8CaGRAnjRxWNo
   BW1RXnDUtb7htYyjktpRItG2HG6ikFv7Naq2bxvZBXyJgE0I4a+PIGLLh
   JlsdeSkWQK34yO565zrxqZ6mgYs8mUSgAOC2cdG1pDd3c6KzLMj8j6Gp7
   A==;
X-CSE-ConnectionGUID: HQnruRV5S8S269V4Qtnn/w==
X-CSE-MsgGUID: AIUtPk1XRAuCuO1usqO6wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65102051"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65102051"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 16:25:24 -0800
X-CSE-ConnectionGUID: 7v3hBmrgRMeXIkMZee3IBA==
X-CSE-MsgGUID: Rgiyz8sGSrCdd5morz7KSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="189831839"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 16:25:24 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 16:25:23 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 16:25:23 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 16:25:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1g3ln5Gxj9CC/RndlMK2AAzf0HUFq+jUPdUP+jzYobXnnmtBX2pnPQ3ttL0JxAXaU3YWGYqZodqi1GyKpFld0zlybqDsIrgB/iOASW0tqzB0U4hrAnSC8pBhQqxVGrCyPed6EsMvFQzNqHbv1Nbxsv76PxPmBhmSO1hjfybWw5z9b1a4OIEnn0wisUSCG3X1P8O795uQ2r23GvVUtuUB/yAHSLYMWLFBPVQQnvyQzZM4zXQ1W96lT1+qtssCpzrZGmMhMJrUGNX+dV/vWKBvD6JETwUlVlDz+7Q3WTrmXzHmz8b1nBCP8KS0DbyPj4OuJrCCQfagyyKnKyLbGZP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOpmsSicw9Nr+KRFJ96PVcLgqeiT7Ji76eXmKzITtp4=;
 b=QkH19fzlg0dQYTMjPxSl6o8fGiBit+0aOTBxLORJxurkAEZi65XyI9cNyZdjGYnBALJ2t/YDPm3srof515g6RZb/zemnpuQL6z+2rernoZLEtPsFdr8m3JpmVuIMf5sua9cr6iuO8XL9WTGD5KAuDbXpcH8/uUIt6hGop3uQA1+OhkkDyJqx3msdArW+FBFsewLwNsgJMZMxA/dbcLnD8rfABcDil0f7PoLsXJo1pCrGm1epFlGQU/8hzZGT6kARN1yXURXEanFM0xZr3/eIywxHcZjo8iwIP7tu8je3BkjNKbHdufVqD2n1wPk5lCTESIUFwNK/GnlD/pzCfMcEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB7139.namprd11.prod.outlook.com (2603:10b6:806:2a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 00:25:21 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 00:25:20 +0000
Date: Thu, 13 Nov 2025 16:25:11 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v20 06/22] cxl: Move pci generic code
Message-ID: <aRZ25zHGGDyhqUlS@aschofie-mobl2.lan>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-7-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251110153657.2706192-7-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 926d4e69-1342-4ef5-5569-08de23144b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qIiTJSvZh9Bn4YR9hrR/79zsXUrnO8sE+Mjdk/b/66Xiz47CzjfpdUEOOaHe?=
 =?us-ascii?Q?rAlo5/5NRtdmhsqst7qZFatVmI6bAiZJTdjKp2EyRaOc7cqo1mmxzl6zJvEU?=
 =?us-ascii?Q?76L6le02UKDWAGjGs1jFj0o1mS5tWf9AMUnq7fui6q83y3yrlOoizt86uCFX?=
 =?us-ascii?Q?U05VEewBMmX28PvQHc7KqcIGeLLxKOx76OfRGMzXGkhRnBrIy3a1taCG90u8?=
 =?us-ascii?Q?toT0kdnG+7jlmfmNGdl6k27qP/JUdjGpxzkdDDyqqUWHITsN2180Xk+OJReJ?=
 =?us-ascii?Q?AHwZ0r0cBNbjohW0y1l5GAmosdiCTEW2ncIjlq+vzjasZOpvUzBWw0t5AFYs?=
 =?us-ascii?Q?BIGTTN1I4lmZzWn1RVBzagHeCIiuxafcJV7yIllSqfA5gGAXQm3f475hA74t?=
 =?us-ascii?Q?fRHi+PveCgQ8F4kSJgwvrsgGbMch7RvP5UEbmHgEhi0nauLyDnLNs7WX5hbe?=
 =?us-ascii?Q?D1kYEKAxq/GUPjY68bA7W5f6EismLiyUtG7pCq8x6TPkkZuBPepwDjvJbLsf?=
 =?us-ascii?Q?FoxZPCEg4Ouit+sUw3U5QXGqx2IcbIsC2kaamzCX8lgzqkincQZVka+0NA5/?=
 =?us-ascii?Q?YxTD9OdYthebWcte5+NQ0aIX5A+IOmR1oEyhVhLvbTQXd63PnhOohemTInXO?=
 =?us-ascii?Q?9F5oOtpXWb5dHvxCxdZ4YRio5/7cEmU3GtyUYMDwPr7vE5UmIWN1f/Crn9h5?=
 =?us-ascii?Q?VE6mjMb04JmEW0C3az7yCHrqNO+6YXpP6PJk/W6ZgKNs7+QJAFP4BM0HeZp5?=
 =?us-ascii?Q?5qbD3P7QWfM87JvYEXme5amQ6noZaY++JM0Yf4Pyza3YaFsFke7DF7C3rr5n?=
 =?us-ascii?Q?4yVLRwOYNh9zT/44vSuIQ1Q4/b8KboOZ72HanOjThGiFBPUVff629ipYA7ue?=
 =?us-ascii?Q?jbb1+1/PaH2MgxLDkHBvSHAC1TDUYABxHsep5SlMvQ10t9KLvkSjnHF0zlpK?=
 =?us-ascii?Q?hWf50URYXJzT0woNEiyEcXs/+Ley9he8eQp7AzA2mHyWaoLR7ph+5h8/5Zc9?=
 =?us-ascii?Q?8n2GvnnKjavhwvwmW4ZGEdYTFj4+fSDe2qG7BgmL/7MWpV5WQjeH609ew3h5?=
 =?us-ascii?Q?Br9b0ZZLKpReea+UxeTHj3XxH4uMLUtn5ISf1NjjoqwZyca++diTX4SDVQZM?=
 =?us-ascii?Q?xKmgP8QEF1qSqnEhGj4DlanYLmAQdwywl7AGWisM4DLrTKCOf+W3iefGgEwO?=
 =?us-ascii?Q?xUPLL6cawWjppzmlU1IUrnQKgAzqyE8TnJF1KnzngrieIHuDH89M4lrM5v3l?=
 =?us-ascii?Q?rEzP/MNJjIGLovrNf1xWnKxsPZPqcFK3L9bN5Iw+dkSZGGSbiLBM6JbMuPk6?=
 =?us-ascii?Q?tK7I5IOxUpz6jbg7Fj2VeNOFOtv7UDQWSrXcahYRx//XZph/Ks3PD9MrAlqp?=
 =?us-ascii?Q?hMq6ijfTY6HD5jYm7j4SGDlhISkNmL7Zxm87xfESKAnMuODlkUZb8q/xCkvJ?=
 =?us-ascii?Q?9nWsmPfSHZT/9jnY9YhSWxbkm7aFUBk0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iahNMeJtNvEf5OTubHK6oMbGTvfOnLBTgDtBLWDuFe2/QnxJ+dgMXee1JIGp?=
 =?us-ascii?Q?d/anOJjBKA3Zifyfr3LGTjWjw9OPf17vK1uvti6RAhcSRQOv3GbvxCusEshw?=
 =?us-ascii?Q?onKTd4jcJN033zuD263oIpUrPH/bBWB2xgC7BXS+11CYIbKm1h1RBNKKHBUi?=
 =?us-ascii?Q?T4eU7CyqUWuRaH8jVo1RJ00rOIYygON9iEECMIawvSsNtz83M4f8TPLRbseR?=
 =?us-ascii?Q?lg8NIQONvPJv8obtsaYPfBK9dagoJYDZANWoW13Lo8vsesNnJr28GzyB6KGi?=
 =?us-ascii?Q?EX2EjZyJP16mtZGP0rnPgSEq9mTvYLvNW7EXWPL3gJO8iz/OKb73jU0O0Y9u?=
 =?us-ascii?Q?Aw3KIiyVxslWW1633UTZJ7s3McTH/RN1Y9N7KtN0LX4UsR/inxrfcbehYMiZ?=
 =?us-ascii?Q?DXgcBwSUszWBAFpgB0mkFm4wqVFhAuuDCuzjC54XOYfUwpgNrD+0QX2zPRLo?=
 =?us-ascii?Q?/CrKJoxwjdhQU39LIShlFm7jIyMAhqf0xMzHvQ/64vdC7SvrL1RK/st75uWr?=
 =?us-ascii?Q?uzCxmZzmcW6AdDa30XwGx5uIOyKDx3vzBgqn9D8Htk01fWOtSLxVpVWbavkx?=
 =?us-ascii?Q?8K4uYMMlQJWBDzMweurNCmO4MHvWrSx+GHFO4kSvMP/0UiHD9shMzpBAjPGo?=
 =?us-ascii?Q?CNl4T+HO79V7qa7NCOckv0hVZv0s8eGRYjL5XZ5Y4JdWsZBg3IWQNXqNUa3E?=
 =?us-ascii?Q?MjdygokSSdhHOqr8mNmMcBfmTrbSSp9OS3c9kd2k8OlDbp5oVYq/ovW+xncP?=
 =?us-ascii?Q?0mEGkQiRA4Gff3oflUu34RYQkG5j5f5HGqEU9/dPrVkz6cBwuciaCaGBFRsp?=
 =?us-ascii?Q?Hetz560PSes/gaH0TeGRXtRs14q5LvyOtdo8qSuU66XBWzRkm1fWO3kZ1Plo?=
 =?us-ascii?Q?72+8qGiTIMYamJXguDWj3tqsQyOS4IdZe4ospv0Q5j3JefkMijrSNTt9sykn?=
 =?us-ascii?Q?nWudRJyJVJtActPtOWyVsDmlhYs72hCQLTykBqZdp+Pp3f0X4z2kyWu3BuyX?=
 =?us-ascii?Q?yF+vYkkPv/KBzDEOpPNLqKMJmpuzLh+lZI+pG9bnSkZyjQcB+wvlwv0wnd2c?=
 =?us-ascii?Q?PpG4pD+T8KmZE2+tp1LU8WFRRd5OhjdLPUV3OPJsllg48qn8wJxpx5L+LxbL?=
 =?us-ascii?Q?9TCdgPnUPY4m0KV4J06/Eko79OfVzXzDrOwnIbR46X0PFsW8sO7AxsTDhlCJ?=
 =?us-ascii?Q?TrlrYJg2oVaQSbkHEg0bCjUXfL9WZkHcDeoh7A+4HNZrDKFQVaxwocHIADhu?=
 =?us-ascii?Q?RWEswp7fjuXLo54Tu5M0+M5ev1Rc4CPquLr79ii4na3eQLWXSprvZU6K6XsC?=
 =?us-ascii?Q?ZkFrFuHAIHRcRW/YuOnvsrc57Hyl1NAqivY0gDcz4nF4a2D5wJ82KHqC9+s/?=
 =?us-ascii?Q?l57hTpL7nhIz+hqq9xYpgtUXOGosESK32F97ayZgxGS5kqzwwWpOiCLM7ZBS?=
 =?us-ascii?Q?hC8IEG0L3NE6lk4XIdjmfvCN3ixn1xe1yh/INRfBMtswPoHJdfar9SzE0yCv?=
 =?us-ascii?Q?WCqkA2lHfyCsuOrq9X9q+b7zUQ0om12KhGnc0AnfCq2uElkF8bRMawdLbTv+?=
 =?us-ascii?Q?vidUk4L7/V7c9p6lj70CYVyXuUqTJtBYp5a9VJLCamZZ/Rc3WCUeicayq8sc?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 926d4e69-1342-4ef5-5569-08de23144b79
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:25:20.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2wcSrq+bsaMJWTFJAKDB6QAavvciNzn/vicNNEiKUSHa6vJfKYaItUK6H07TKYyWsDZ/HO7PTSyBTM/33iY1iyUILy7hNT1BhKgieFOLC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7139
X-OriginatorOrg: intel.com

On Mon, Nov 10, 2025 at 03:36:41PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci.c implements the functionality for a Type3 device
> initialization.

Hi Alejandro,

I'v been looking at Terry's set and the cxl-test build circular
dependencies. I think this patch may be 'stale', at least in
the comments, maybe in the wrapped function it removes.

> 
> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> exported and shared with CXL Type2 device initialization.

Terry moves the whole file cxl/pci.c to cxl/core/pci_drv.c.
That is reflected in what you actually do below, but not in this
comment.

> 
> Fix cxl mock tests affected by the code move, deleting a function which
> indeed was not being used since commit 733b57f262b0("cxl/pci: Early
> setup RCH dport component registers from RCRB").

This I'm having trouble figuring out. I see __wrap_cxl_rcd_component_reg_phys()
deleted below. Why is that OK? The func it wraps is still in use below, ie it's
one you move from core/pci_drv.c to core/pci.c.

For my benefit, what is the intended difference between what will be
in core/pci.c and core/pci_drv.c ?

--Alison

> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/core.h       |  3 ++
>  drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
>  drivers/cxl/core/pci_drv.c    | 70 -----------------------------------
>  drivers/cxl/core/regs.c       |  1 -
>  drivers/cxl/cxl.h             |  2 -
>  drivers/cxl/cxlpci.h          | 13 +++++++
>  tools/testing/cxl/Kbuild      |  1 -
>  tools/testing/cxl/test/mock.c | 17 ---------
>  8 files changed, 78 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index a7a0838c8f23..2b2d3af0b5ec 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -232,4 +232,7 @@ static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
>  static inline int cxl_pci_driver_init(void) { return 0; }
>  static inline void cxl_pci_driver_exit(void) { }
>  #endif
> +
> +resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
> +					   struct cxl_dport *dport);
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a66f7a84b5c8..566d57ba0579 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -775,6 +775,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
>  
> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> +				  struct cxl_register_map *map,
> +				  struct cxl_dport *dport)
> +{
> +	resource_size_t component_reg_phys;
> +
> +	*map = (struct cxl_register_map) {
> +		.host = &pdev->dev,
> +		.resource = CXL_RESOURCE_NONE,
> +	};
> +
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return -EPROBE_DEFER;
> +
> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return -ENXIO;
> +
> +	map->resource = component_reg_phys;
> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> +
> +	return 0;
> +}
> +
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +			      struct cxl_register_map *map)
> +{
> +	int rc;
> +
> +	rc = cxl_find_regblock(pdev, type, map);
> +
> +	/*
> +	 * If the Register Locator DVSEC does not exist, check if it
> +	 * is an RCH and try to extract the Component Registers from
> +	 * an RCRB.
> +	 */
> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
> +		struct cxl_dport *dport;
> +		struct cxl_port *port __free(put_cxl_port) =
> +			cxl_pci_find_port(pdev, &dport);
> +		if (!port)
> +			return -EPROBE_DEFER;
> +
> +		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
> +		if (rc)
> +			return rc;
> +
> +		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
> +		if (rc)
> +			return rc;
> +
> +	} else if (rc) {
> +		return rc;
> +	}
> +
> +	return cxl_setup_regs(map);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
> +
>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  {
>  	int speed, bw;
> diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/core/pci_drv.c
> index 18ed819d847d..a35e746e6303 100644
> --- a/drivers/cxl/core/pci_drv.c
> +++ b/drivers/cxl/core/pci_drv.c
> @@ -467,76 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  	return 0;
>  }
>  
> -/*
> - * Assume that any RCIEP that emits the CXL memory expander class code
> - * is an RCD
> - */
> -static bool is_cxl_restricted(struct pci_dev *pdev)
> -{
> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> -}
> -
> -static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> -				  struct cxl_register_map *map,
> -				  struct cxl_dport *dport)
> -{
> -	resource_size_t component_reg_phys;
> -
> -	*map = (struct cxl_register_map) {
> -		.host = &pdev->dev,
> -		.resource = CXL_RESOURCE_NONE,
> -	};
> -
> -	struct cxl_port *port __free(put_cxl_port) =
> -		cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return -EPROBE_DEFER;
> -
> -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> -	if (component_reg_phys == CXL_RESOURCE_NONE)
> -		return -ENXIO;
> -
> -	map->resource = component_reg_phys;
> -	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> -	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> -
> -	return 0;
> -}
> -
> -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -			      struct cxl_register_map *map)
> -{
> -	int rc;
> -
> -	rc = cxl_find_regblock(pdev, type, map);
> -
> -	/*
> -	 * If the Register Locator DVSEC does not exist, check if it
> -	 * is an RCH and try to extract the Component Registers from
> -	 * an RCRB.
> -	 */
> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
> -		struct cxl_dport *dport;
> -		struct cxl_port *port __free(put_cxl_port) =
> -			cxl_pci_find_port(pdev, &dport);
> -		if (!port)
> -			return -EPROBE_DEFER;
> -
> -		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
> -		if (rc)
> -			return rc;
> -
> -		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
> -		if (rc)
> -			return rc;
> -
> -	} else if (rc) {
> -		return rc;
> -	}
> -
> -	return cxl_setup_regs(map);
> -}
> -
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index fb70ffbba72d..fc7fbd4f39d2 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -641,4 +641,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  		return CXL_RESOURCE_NONE;
>  	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1517250b0ec2..536c9d99e0e6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -222,8 +222,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		      struct cxl_register_map *map);
>  int cxl_setup_regs(struct cxl_register_map *map);
>  struct cxl_dport;
> -resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
> -					   struct cxl_dport *dport);
>  int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 3526e6d75f79..24aba9ff6d2e 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -74,6 +74,17 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>  	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
>  }
>  
> +/*
> + * Assume that the caller has already validated that @pdev has CXL
> + * capabilities, any RCiEP with CXL capabilities is treated as a
> + * Restricted CXL Device (RCD) and finds upstream port and endpoint
> + * registers in a Root Complex Register Block (RCRB).
> + */
> +static inline bool is_cxl_restricted(struct pci_dev *pdev)
> +{
> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> +}
> +
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  void read_cdat_data(struct cxl_port *port);
> @@ -89,4 +100,6 @@ static inline void cxl_uport_init_ras_reporting(struct cxl_port *port,
>  						struct device *host) { }
>  #endif
>  
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index d8b8272ef87b..d422c81cefa3 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -7,7 +7,6 @@ ldflags-y += --wrap=nvdimm_bus_register
>  ldflags-y += --wrap=devm_cxl_port_enumerate_dports
>  ldflags-y += --wrap=cxl_await_media_ready
>  ldflags-y += --wrap=devm_cxl_add_rch_dport
> -ldflags-y += --wrap=cxl_rcd_component_reg_phys
>  ldflags-y += --wrap=cxl_endpoint_parse_cdat
>  ldflags-y += --wrap=cxl_dport_init_ras_reporting
>  ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 995269a75cbd..92fd5c69bef3 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -226,23 +226,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
>  
> -resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
> -						  struct cxl_dport *dport)
> -{
> -	int index;
> -	resource_size_t component_reg_phys;
> -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> -
> -	if (ops && ops->is_mock_port(dev))
> -		component_reg_phys = CXL_RESOURCE_NONE;
> -	else
> -		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
> -	put_cxl_mock_ops(index);
> -
> -	return component_reg_phys;
> -}
> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
> -
>  void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  {
>  	int index;
> -- 
> 2.34.1
> 

