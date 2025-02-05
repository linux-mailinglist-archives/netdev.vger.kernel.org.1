Return-Path: <netdev+bounces-163268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B26A29BE5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 22:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCD5188708F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC76214A92;
	Wed,  5 Feb 2025 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ImBTXvP6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C531FC7FC;
	Wed,  5 Feb 2025 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791164; cv=fail; b=DDTxsea20gh8gr2+CaDU+gOzkeUqpR3WEeo/MLhTTUQyfwAyJH0DnnqSaXCgSsrOuEiwsbIV1yRlVlp6TMro/6/nthnIoCylpmw/V1jhz/gn93XSZW2BS9bIVoOLsiFnLzoHYZ73ffs2NrfO3CaadLuw2yUG3+4PD7q41jEKSFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791164; c=relaxed/simple;
	bh=ExjYCMS0K+MuHkAFzBMkXjuH4M19AUXMEEdYser21tw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s5O2wipIiEC/Kqw7TjlXZwfkJO4K7Wt2o/2R7S2I4fFz+oageNtUeSpVmfWutrxSuY9zJC8LjJRsnxmYCJOS6eh1CSfk6+q+FmXS6mzPVuIcDm5lwB1oli0PYq309tAPAowZHbLJuYeTOooE5k7CHw5U6lrOyh7QtUv+K/x8+DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ImBTXvP6; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738791163; x=1770327163;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ExjYCMS0K+MuHkAFzBMkXjuH4M19AUXMEEdYser21tw=;
  b=ImBTXvP6WI2PQ1xQGAtdSvJnp165w5fs60ZtTRs/6jdW/YFM11ZrM7b0
   LGIh2ftSjMoyxjcvUUfCaQqiv/xbmmjtjZVIuWYpnWPxoRAOUBUDdvE7n
   BepqmYb3sCbC9XtcVYv+Ojg5WENi7OB0tK/BYmgNYrb2XdmpSpIf4bAp2
   RxqdjWiDWdWiB0sUl6Y1kUj/vYlKQuEIbc3DNyQcGj9c6FGWEOKSXHxEp
   fk7teFC+azI1Vq+ld77yIOb2lTw7JVp7Ysoib7LYtxqnBc1l8LqPNeY7T
   J3tT429KcAfjIhRbwSdYGO7hXFO40UmmNgpJAngmX0iLhbCMrJnp8MLoT
   A==;
X-CSE-ConnectionGUID: OYrTHuw5Tj2kO3niDO0iaQ==
X-CSE-MsgGUID: FEYHG27hQgu1xGQikOsl3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43300417"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="43300417"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 13:32:42 -0800
X-CSE-ConnectionGUID: SeQnbIeCT9WZlKmafv5zNQ==
X-CSE-MsgGUID: hAJAGSWUSkiF2hwKVCZmpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141907015"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 13:32:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 13:32:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 13:32:41 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 13:32:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCVepJqJB2SAfvO0TXIKxTOufT5OrBh5Xf94QWQBMuqfMm6u31kHumb7dRumO51K6ESzmgVgR1kKEI9Ih+eeX7hJUUavxWYKBNkutRqavLiY2LrVkUXr3J+NEaF+61Eimw/1bXuUNSWcwq6hEJp/N8fWiyqSJiXsqUE8D+c7O0y7o0DCz1SNLNN6U8CQdv/s4syqwQNmWIrnMEbGsYRqWbg5rPw0u6es0qI+MyPUw0A/+/4QvAI3XUWOU2Kd1REBxIAwLheafd6YVZP+EDs21a02Byphck6CisEqKBA6gYIWiOBGUZHFHUhEKlDhitmS+9ub8A96Gnvha5FwFC8Kug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzgrZZUBsF1sX+8BViCMjdFb6vgUvPXSh8FkkEQovOM=;
 b=Vou9m7vSNTkqQ9+2uacFIo5wVzziThmiPYGQ5oUi9Vz1BtPC38tHfD8xsX6PxwEbxvLe3yZHQXZm9BD2VTMLswafoLCGnXYsRfMeWtVBYv7HYHqcmuEBiD3IC8I06YXT79IrHEr6h0UGlLgcb7gsp6d3l4tXAecibpBs0Dy8e1V5B1ST1Sa2Xnjq21vRlaMq2kyv133bdi8S8GXuosEmbajbUpdXGB52WnutBeSQgM2mnlylSnN4H05zudSRW7svRQTxTqJ0/KUWNQ6CLQYnLMne2BOidtjrDBDN/z5AyBRhVtHDh3dPq6wT037FE3h7c6QTqu/iedU5jN3zYUyfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7265.namprd11.prod.outlook.com (2603:10b6:930:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 21:32:08 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8398.020; Wed, 5 Feb 2025
 21:32:08 +0000
Date: Wed, 5 Feb 2025 15:31:59 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <alucerop@amd.com>, <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v10 06/26] sfc: use cxl api for regs setup and checking
Message-ID: <67a3d8cfaafd_2ee275294cb@iweiny-mobl.notmuch>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-7-alucerop@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-7-alucerop@amd.com>
X-ClientProxiedBy: MW4PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:303:87::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cce5c2-0578-4f9c-4587-08dd462c8b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4qd2n/vPP6ULeb0fQb25CLuAu9xpkGNktqvNZrDTVsKGg9RXPOa5sCkl9cdL?=
 =?us-ascii?Q?85cxDbJH8urgDYFDe2Ux6LyEuhlvrNJjHwttRtJlB9zFD41s9OMgnKwMGfNm?=
 =?us-ascii?Q?ReozdCjwqebmy0VM3mVo043Imd9Mfibeaud1WRjuUJLhRJwO/nqhw3miUAVT?=
 =?us-ascii?Q?dTEmiL8WQMdwYoZFdCV37rB7hPxjVkv3azTWRKyMHAMkWqMHixgi9raELz57?=
 =?us-ascii?Q?Wm9YBmRrm9WYyTfnlcnXSVp1BlZUuLenU2LTNL+d2D2JTuyc9UgAE6iX7bxH?=
 =?us-ascii?Q?cKm+yA2gIhq2+Tob9z4yvxbDt48quadlNV19qtXNxsh+UXuCpEy/eiV6ATdD?=
 =?us-ascii?Q?ob262zmpMYPfOb6/nE7MdWjcDZZczQ5G37mxIkLuIFgO1iaLs3XwHE+HYTyk?=
 =?us-ascii?Q?Lb3SHtLi9/L2VmsNbk3mptLtxLLKfA6yTr3BTxQxOMPGcQhTbi3DtFuizu1j?=
 =?us-ascii?Q?pyIei02LbI39aFxYtkYG2ixePS6AfjONaVtTTvPb75yRjFnHX1SPuvXVRlDa?=
 =?us-ascii?Q?QO07pRGmTs1n9VBeDYL/7NLtEY68L2C30w4xBh59y1IeurCJ7jp2BepME+BA?=
 =?us-ascii?Q?OnWUhSxvq4evTbFMNNr7pXsDMldeK4XA8FC0u2Y42NL8bUjrEqRO4VIhn0ei?=
 =?us-ascii?Q?7rHKk2exKBpUlKMRMQKNi8qrTb7LUNDG00Y/zGpL0ekw11kYLuXTQQl5fH4k?=
 =?us-ascii?Q?2fgQjN5v4Jlo/0LUgmJVghWROavK+HqitKjPFkKTX+zg/KnqT2sC4qUkJPNR?=
 =?us-ascii?Q?pX2zJkLMSw6TV5gD21xGBwMky+VQW9e2Ak4XvTsRS2GtYlgOQkPtVq76PIsw?=
 =?us-ascii?Q?Ca2i5DMkG1iDlzfMul8dOOVWhSmwxr0VNFBvZYulG/xPSyEmL3WB6Ap78vyw?=
 =?us-ascii?Q?X+wWLEO3eOf20ts5vUNixhVHtqI0jBeJDw3cGWzeMAnjhZzJ62UW5NGxkcUu?=
 =?us-ascii?Q?LAHNZHs+nI1hywCnKgTAInhzgEnfDNeVG/FYpBriqfWez0qoXmpwmlUUePfa?=
 =?us-ascii?Q?E8JxI8hVVl4ZZoZMg1JzQPxd6m1PII0ihHLWxSy/iSheZ34fhVxkYDVANmyh?=
 =?us-ascii?Q?/Dtx6SjV//yl+0FEllIMEM+0LWbV8xYktFa8Yy6vbqK9fa+oN7gnwJng6hAq?=
 =?us-ascii?Q?kSNlvC4r01+X8EFf/+t8mK0QBr2qOwKmMxoMkPm0DHCy3b2Z78g8jm351Joh?=
 =?us-ascii?Q?PD865ydcFEoBREXR3S0hTB1DrR7ROAUgy4e8ChBA8K29HJlb1hs/6QPVQ0IQ?=
 =?us-ascii?Q?04GCDTUZQbPA5gSwLlWkZIYo3JSFQLcu/ZZ4gSHTNEuNJNH41Z1AnwaYBSJf?=
 =?us-ascii?Q?XrXuKo5gKpmVErUVKWQ29sF5tPG5U6jpIYEXCBfhZzsK1tMcYj9UdJMGvL67?=
 =?us-ascii?Q?WGn0XNC1wPaKtFv4Zv3TpSGNGnWZ9Y3PTkB42GPZT4q/8kdiZfSRcpIGXHym?=
 =?us-ascii?Q?vSoupUNHIxc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8k5zxZjYo3WJEWu065n4BeqIZ6VRwH3rPh+OFkL6NBr1zv4108iGiJX6iHJB?=
 =?us-ascii?Q?U9XErvdfJZb5NAVDgm0Cbg/Z6pva7zgrLF652azfTMmCWiCtGXFA4XNtiQPw?=
 =?us-ascii?Q?yAhzUNVcO0a70jvIRzN8/g05i97BX402jZaaU4t63GhH3X2Lf5k6styEUkfL?=
 =?us-ascii?Q?GPJmAr+bUS703/PWZR2NsLEglMX994D6LHlXmRTjY6UTNpaxaE33zmdv3YS5?=
 =?us-ascii?Q?0Xe8FQ7A85P3JlzlE2Kx5Jnfbt8pLL22xsMk2ehLbnXi/OT/C+v8TE0vL3Pu?=
 =?us-ascii?Q?o2vTXpeuuL1WbBKO6p1NZcVTfwJ7hVUSf2NkjAub1twYn+O8NqckqOjpMggn?=
 =?us-ascii?Q?KcpFYLDu9lOb1QFYgDCQQF8sxrxoFRtUmOIj1AtU+YyPUc/kUblz2/BBEr8w?=
 =?us-ascii?Q?5SaE6xB7bVerrllKDMOlp7b4hENhEJjAJ0CDRdmu0l6/ebluK8Lt6E11HRuV?=
 =?us-ascii?Q?4t4xYhM/GBq1geQ0yDkbCmcGh02Wr/21cYIw3kjeEz3aNXZmMREmrMkWaEhW?=
 =?us-ascii?Q?g1QDNAkZhhC3lxxs90F7JCHJhP+VV1LBFbeQSD11U68A1hPkaXu8SsUz1ad9?=
 =?us-ascii?Q?gaHrwBtunLic3tr/iEow0e+FCadNrkAZHwDfhZIuBzZRC8jftNrXQSQO8fyB?=
 =?us-ascii?Q?0H+i49y2G5m5DDulPhA1jiClWq8pUUpwB+avz6mnPb500Ojqe8CHTzPFFZDu?=
 =?us-ascii?Q?qk9WegmHy45qa9X79LgCWsbQ+2BXCEdmiqRoAvBXWsdUP1mby2GYXVScY//Y?=
 =?us-ascii?Q?r5bLiytDSFTQIrbDumUh6Ss3EsrdgWYPWdaGgum83pTmsNpS2ZC5unwQJpjx?=
 =?us-ascii?Q?R0TCQOTFKZZEO+yn0B6oCku4KEAsTAi8gP0Hu0yW7cQu9A9Zs2sqv5vqWeHK?=
 =?us-ascii?Q?1/nX2D02cYdLsTw711KsEfA9EwAFgbYbNT0p+s6GfFuIUB/JMlJHX6iUGWjD?=
 =?us-ascii?Q?KOBUhHmu65HJAbwCRGPs42K0htKfziF5dwGybGykbBSUi5h0CoIO/ODeRFF3?=
 =?us-ascii?Q?kaSUVibDdcT6sqcvebdLaZtdlYaCRvpobPeC9i8rGu6JuiOqXbudtgGif2ox?=
 =?us-ascii?Q?SdbmRoYx8q6ulsiBdJEOBnZ6lgoR+zOR1omalF0WYgjPbJdrI2foeQvAKd7P?=
 =?us-ascii?Q?Hh0SZtr7tuBalB4Mz7rN+oEwpO5yTBQI/MV4QhoDeFJ50wUC7AKibgJTTV/n?=
 =?us-ascii?Q?Ha782zFMpOwYTQpQrKWah2q8EnlxwTFxJmBHLoi5sPlzHEbLMf6PJeN6vJzy?=
 =?us-ascii?Q?0jiRcftewuPlhzvMf3wKf0g232fh6+g9rRpHSF1EBjcduZp8DZt54FFB33vD?=
 =?us-ascii?Q?cwywGyyAezRNCBoYkI6FYRLsDesT4YNJFSHxXRnl9Me7iKYaiKSx+PDSKOrA?=
 =?us-ascii?Q?IoXfFqOvisNugCr0uGuAW/wZtO76aPjUvb062Q0oPs/g9gSWNBs3rQlhHaQJ?=
 =?us-ascii?Q?XKt9injbnBwmBDUTIzBJOjbPY0dXmvTDsfM/4NY0HRLR4Eq+kpfQCxvld2It?=
 =?us-ascii?Q?apvpe9RkzGAKq/HUO7/9C2sH+TUCDO9R7S3f+LQFaPk+O8gt2EH5ywjvTgA3?=
 =?us-ascii?Q?cqGXrlzCWf9WtMOoT7fjYanEvM/sFNAqie5Jeeg/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cce5c2-0578-4f9c-4587-08dd462c8b0a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:32:08.3990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GW4fFcQs1Ftbe2tbxsMIrSaDVr0vVDzXo9JEuJO3RU+BHv4Bfv3IHa1rPo0qx9f6MhPk+8phDwff3ZXLEkgP3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7265
X-OriginatorOrg: intel.com

alucerop@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 

I'm still going through the series to better understand the over all arch
you need.  But I did find a couple of minor issues so I'll make those
comments straight off.

[snip]

> @@ -46,9 +50,37 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmds);
>  	}
>  
> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
> +	set_bit(CXL_DEV_CAP_HDM, expected);
> +	set_bit(CXL_DEV_CAP_HDM, expected);

Why set HDM x2?

> +	set_bit(CXL_DEV_CAP_RAS, expected);
> +
> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlmds, found);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL accel setup regs failed");
> +		goto err_regs;
> +	}
> +
> +	/*
> +	 * Checking mandatory caps are there as, at least, a subset of those
> +	 * found.
> +	 */
> +	if (!bitmap_subset(expected, found, CXL_MAX_CAPS)) {
> +		pci_err(pci_dev,
> +			"CXL device capabilities found(%pb) not as expected(%pb)",
> +			found, expected);
> +		rc = -EIO;
> +		goto err_regs;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> +
> +err_regs:
> +	kfree(probe_data->cxl);

Is this freeing what you want here?  AFAICS probe_data->cxl is not set
until after the checks work.

I think this is best handled by using __free() on cxl and no_free_ptr()
when setting probe_data?

Ira

> +	return rc;
> +
>  }
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
> -- 
> 2.17.1
> 
> 



