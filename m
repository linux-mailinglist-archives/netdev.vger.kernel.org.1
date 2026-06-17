Return-Path: <netdev+bounces-300106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 64buGWRsMmrmzgUAu9opvQ
	(envelope-from <netdev+bounces-300106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:44:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 096E769804F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:44:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=HcM3lVM3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300106-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300106-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8212F3064829
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED493A0EA5;
	Wed, 17 Jun 2026 09:43:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF539A06F;
	Wed, 17 Jun 2026 09:43:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689405; cv=fail; b=S4wsr/Ezyy6sxwlcRPSk9fXdXdmaHqVE64NuaLHPq0yFpCvTeRj4stpGqLFjgWJcLFytdob/6uggRzI2JYEZUY3LvhvBEMXVdiPlkH77ciw/Yf2qgTi+vduPBpgPegxUqD/jz+zG3AHL6ixPFS4bKWv8y4yS1B0mhE4GRWemS44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689405; c=relaxed/simple;
	bh=1COQ/sGJzl/4EnEHt1WdKGxdrQjhVpAuEydonsnWpGo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fJsm3uzu6ah5ufJW1wiZNnjUFGa2fR98hLm0JyTWhB89J2gwXH+jF/ouXwqjXFLzjMfUBU07I6owsWxB5+xGgNOyToPXqiK1+cAyg8+Pnc9JKMGp+eH7M2WLoOwSMQ5Ib+7jZMPDL5mcoAGPvXKzvJxXeT2xH2OX3ZvNshFWtYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcM3lVM3; arc=fail smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781689404; x=1813225404;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1COQ/sGJzl/4EnEHt1WdKGxdrQjhVpAuEydonsnWpGo=;
  b=HcM3lVM3xGBj6IDJe6P6ZHjy324Xhifaxlf56RPmGGNeAQYbw++80Ob+
   27ELQxRVoQHKmRjqC7nNWoXEBKe2POT23OBIHVQbQvqm5wkyBlc+AaJlh
   7gy2UhYftZIAcNfISFtusQZHt0Ebm4+OrZGLWRtFg9oPkk3L5qZhv+r7V
   yllMDuClBzmzxj5JAfa1Uom2jTEwZTC217h5R/QRuK9CWCvgjr/eIMOoR
   E4K+05GyOFRX2O16imIxJfZaKFRHgrW6890cpu44OuMJbNiLDtD7y+UXs
   VN66bixRgAp+rD4lYsomTx7OGQa8fNDF/vV9xGjgGUqiTRGkWUmhZzl9o
   Q==;
X-CSE-ConnectionGUID: clF0YM/CRFmTOVzgRKXoAQ==
X-CSE-MsgGUID: IcLNdPE2SB+W9SXox8Jrfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82534208"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82534208"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:43:23 -0700
X-CSE-ConnectionGUID: 347vwwewQVmtgL1W/7auwg==
X-CSE-MsgGUID: 2+FWEcsXQCC4XxKTBtEEXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="252322630"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:43:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 02:43:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 02:43:22 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 02:43:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEnj/0AC7yOPQCv85yAwCri6O4moFsG8m/q2zVvjQKcUVBlBlMsY/bVpMS0uRvrFcw7HyFgYI+VlJicbwRpYIiPbC76YE0fU6mk8gbXjyd0KLQr4Dc2gpBtyaA9+aMHELxCJwPO8NJE0QmnaG318TrnlHauUoZpMnrTK+IfAgK62TkE39ht3Upf2NNVfWeyvj5dB4+8ZqU3ULjJb4RAQzOnsUrYr63cxG7YR+RvnixhEQEIk74Su4eO69guysFVs1FPOOorGL4GuiB+l4QNQGCOaTXONjfAZ+/ybMC2+zqLG3SB4MFwzN6mK0AhVGK8eT1OscAYpL2tl8LnfwiXJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcq3MWvYn4F9lwcFsQZzGLpSgwkPolStj+IysGluTVY=;
 b=HGMOpl17vgRpWYC8/JJ80TwDAzRmKwVy9C1h7cSvNrqv5LbEsM8Y1XhRY/PrVooA9I7aEoAmGAFka9uwtaiDrCldM+vVxKR54kTe/8f1szmet5conbJVK4BPGYb5Ki3hgbUKp+aW8L2hOqhEZ4AuntPRqe6O6TPJ3//F+yQrRz5Z6rCY641IYzZRmAmw/2kXST6GYKIe/XLl3/tTjmv498sOT/dSX1mYBUXkNU5Vcj3jjAjcxxZj3DkYYs5q9BIn4TU3FM4xs/jRVBxmf26WRfqEe+Mb2tQciiX7h81WDd94QQviX2QT7dHHDpNyOTqLnN/SLpYddEJFauxmMPxVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB6118.namprd11.prod.outlook.com (2603:10b6:8:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 09:43:20 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 09:43:20 +0000
Date: Wed, 17 Jun 2026 11:43:14 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Tushar Vyavahare <tushar.vyavahare@intel.com>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>,
	<kernelxing@tencent.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<tirthendu.sarkar@intel.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test
 behavior
Message-ID: <ajJsMj0QMOF5I8qq@boxer>
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
 <CAL+tcoDr0gtCPeGi1yOUtg+ZD2YxEbjAy41LBgG63b8-=CStcw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDr0gtCPeGi1yOUtg+ZD2YxEbjAy41LBgG63b8-=CStcw@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0068.eurprd04.prod.outlook.com
 (2603:10a6:10:232::13) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1ef158-3c19-4b43-1290-08decc54dde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: SHajhrusbnlFwJWvEzpR/eQUDGhbuGjbFMWqe21ApsgEDq7GGiYpSHXaPMlga/HekdzU1O0CASD6uiB9ADLuabf5hC8yDDB6xQJLkznUzJVGLBAD+wO0yCmRUFviF2FLWtbi/Oi54c715aSyvO34/0IVUfEB1PK6MY73jSELYg/OxPQbDUcAPJbeAlCiwarpsVrpARXNqlr1egLxrHoeLQ1JfdU35GLbDMx3ly1C07RTUXTby6c1VSpuGp4v+OXL8jiVs5blgS9ab1EfE9dbrOOm21tzR2/iEnj2f485WRDqiFhRG99ZVudKj8KUg5razwmEclEBlp1ES7ubHpHwDzhFrfXg835a35NRYK/2UP+6eIvMgQ2mKMW9E4427Ygky0IurHqVcb8tWpXora2erAlcU0kZPc3tOccn19Hk32t7CHZokbWFlM+2EjCtT2utNM1K/qKcJdk+I+0XyTCs+zTkFmpicNXc/0VgKTXVgNnVA3BoF7uzbvU02ArtmiTUgP+IgkFrbDUMpvYFzoyAoUujumMznx07YVyLbsWs8KsnVqRUWS6aW69ACQE4Z8V5XZhkW5/pznNOa3dXcO+MMQfADydfKhEVRbjgOvLPKuliOlfos5qkHL5u5PTOGxQ7uO/7Y0bJv69pEj/HR+6yWto/8DH8ls0oBkVhFrZpekWE+eaKum5OugvnuiHrRFUFqxIo6pcTiuFnG9pNDM3zVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1dHdFV2M1AwQzVMVERFSkozQjRRNkpDaVI5a3FqUHFyeVliQTE3bG80Uldr?=
 =?utf-8?B?cXNTdytrR3dwQmhSWEl3aFFIMGZxcnJtZkp0cmNUZFVKREhlQXpBQW5RcGI5?=
 =?utf-8?B?NjQvaEFoY2JLQjdiQkY4QVZCZGZ4cDJDclAwa0gvc0JVSkhQZktXMndlZVNR?=
 =?utf-8?B?UWZ2K0JjR09Kc014T2ZlbVhxeENoK3lRQmhWRmkzZFQveFZyUlVWSVRZR0lp?=
 =?utf-8?B?VnFMcEFqdmJESjBSU2o4ZGMvVlZPSTFwQ3dLODhsR3d2QzUrYWlBNklQMDA1?=
 =?utf-8?B?R1NoY2QwM2llemZ1Q1RJcWZYY2E1ZWFXNmRZblJCMnVUVW1vMmFqUXFFM3JK?=
 =?utf-8?B?ZktKbmdNcXFZYlcrTWoxQWV6SzVFM3Q4TVhrN2JkMlBVUjJ5UVBJQThtdVdp?=
 =?utf-8?B?RUdwUEhvWm5UNUNGUURVL3A4STcyWEJacWJ6eUJDU2hUTXpjZkl6c3pTZkZF?=
 =?utf-8?B?SVdXWXlzVFU4L0oyeS9sc0swU3hXVGw1TU16ZHVrQkx4WjhVc0FaQndiWktL?=
 =?utf-8?B?c09RNmVmTythN0RpVXNHak55OEZRYjVtOXNBNFFsUjl4cEt0WHh1WFdjNUc1?=
 =?utf-8?B?Vyt3czEwMnJOU1Q5c3BObXVSWHBmZ00vajNtTmN0dnE0N0g1SFhndVNRTTVx?=
 =?utf-8?B?MmhPZ0RJaGdzaDVjTy83ekRiQ3BiTmlhRU5WSmF5eTN3bGNhb2FZckFsbXU5?=
 =?utf-8?B?cWp1b2RGOWlKaHVhL3YzWWFXUmJNUWVHYmpJdThOQzg3SE9tWE9VVy82ZmFx?=
 =?utf-8?B?YThLampIOXpvSzB2SjR3d1F5dmtqR3VoYUtvd3JmbEZrYU1hRzZJM3pMNm8v?=
 =?utf-8?B?d3NTVU1JYkZMQTNUeThtcXhDWE1SNE4xNmhtVmZyMUJzanN0TFlMREVaWUlL?=
 =?utf-8?B?NDE0QXRnTVlsTlpKRGpZVmUrcHNJR1RvZkdHYXg0Vy93UFhFQXB0NnJXMkpv?=
 =?utf-8?B?d1JLcUpkdGxNTEFDSVZUa29KQnhwNkgwczF1R2JUandKWmphcE41Nk50MkFv?=
 =?utf-8?B?S05RaDRmK3JydEFpZmhCQWZiZ0NLb1Y5REJFRHhkdGtNTStiVW9sZTdBeUxw?=
 =?utf-8?B?a0cwS3lWMExDMmFwNlFuRVowTHdoM2VJeUFabDg2WWw3VW85dTdXRlp5MVVY?=
 =?utf-8?B?RlJneGJveW8ra0NkQnMwRk14TzFnSVZGTkFISStGT0JWckxBbS91dzZIbVhP?=
 =?utf-8?B?STRIa2UrNjIwTWQ0emdCbHRYczFYaG1TUjJOVkQyMEFJakQ3a2x2UG9wWDBv?=
 =?utf-8?B?N3MzZWhRRnlnTExubFpEZFprTXpReDhGWDhoV0RkeDBLRFF2R1NLY1ZIMk5t?=
 =?utf-8?B?dHRtTHJ1Z3REc1JHd2pRL2hJUmVqeHMvZjhOZGZobHY1Y3QvTm5Gb0xVejRR?=
 =?utf-8?B?bWlqclRadG9KMXVjSVR5Y0lBdndJVFRJNmJPWTJ1dWt0Ly9DQnMwSFFzem5z?=
 =?utf-8?B?Vk9rZ3N2TWJmTW50NjRkdVBpU2d3NnpZektXa0FqMUJ1MU9pV1htbkU3d0tk?=
 =?utf-8?B?MXc5bFNOcnNSeHpOdkhDVndXSFErbEVLWlVDOVh5MURmTk4zWUFtVFZrZHhl?=
 =?utf-8?B?RDFlSWxEZnBxamhiSE55MTh2VS9IV1NxTUFkQzdzWVFrdkhWSys5c0JVOSt4?=
 =?utf-8?B?aFRCRlBTajhVUFNUNGt0ejlOYkhUeHdrNFE2S3QxMEZPSnltdGQ3UE9ySmtV?=
 =?utf-8?B?eWtlTUM2QzNHL3JmNW5EajFmNGVmTXFRUGFzRVZUL1UrYWhxT0F2QXczZnA0?=
 =?utf-8?B?OGJWZjZQaktZT1M0R1JWeUI4U1VKYjZEbkU5MzJqYTVISUd5SC9xQjZZc3VM?=
 =?utf-8?B?NkN3ckNJL3FEZk14aFBVdURoM1hlVGZkbGRDcEVBZjNxaytMN0libVBqV3Zk?=
 =?utf-8?B?S3VUOW4xQnBSalRraW1mSUV4ai9jSVBHTDJVa2VsOWdBRGpuQk1DZjBVTmpF?=
 =?utf-8?B?akhCZk43eUduc3NRcmsrYThMbGw3OXRNVWNlSm5GLzhxY0FkMmpyNm9BdVM5?=
 =?utf-8?B?cGsrMDQ5TWFHTTcxRG9QSGlYOW1KR2MwQWxrQlRaWFJzTDhPYkgzZXRtdkw5?=
 =?utf-8?B?NjVpN0thY1RJQUh6TVR3N3hldVZtSXlGT2VtUnhsRXZIcmhOYnRSb0F0cmxs?=
 =?utf-8?B?OGg5Q0dDQXBYREtMdC96NDZHeFBOZyttcUx2NnUwOE16N1ZlOWVxc1hZNG9t?=
 =?utf-8?B?VGxKZkFLZTYwbXNDWUNqNGpHWG9pWDBCUFFuTEFnVzNvQVVnZHltZG1UbEts?=
 =?utf-8?B?R2hEdng3SXlMUFYvcFdUb2kwYWpreGdraURkeTNpMnU1VStlU2d0dkFXbmtP?=
 =?utf-8?B?QnlBcC8zUVUrOUMraExwVVBTTTlSVVNIbC9aN1ovaVNyTjRtL29Vb0xScVNK?=
 =?utf-8?Q?7epdhqoYtkFFvZuo=3D?=
X-Exchange-RoutingPolicyChecked: jHKfKLmHEjPSMzQUex6RrRu208R89Ck4WoEr157WwrmeZTK8WV0Z1MeCwamXTx4o5PoQtHsRrWjsMcztNbspjxE2CJjYIbv9kbrpEobi2uuoCqudqrVqx4cyNlZvk/MNDL0eg+2qpIG1tc6iYpGTARIJaz4xvCV1RNH7w5q7JI6pdBW3kLFnuQYNk7nAOOF+/L0LyuSJGXJpqzBHX2IX3D/1B9oKaC4rgOKk36S3IyAaoSNtQCPDgEQPtqhenzCmBiBe493Mqd6K8X48fYvFiBhtAkuupiNaO0vARBsAUkE7A0+9hk/89Z3IGzK2dh7m4OEF+1MZNmvX7NqhnMEGnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1ef158-3c19-4b43-1290-08decc54dde6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 09:43:20.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: benmF9nu1opLXeV9tksCXnxrywjT5RuPLCoVUSurAGUuwlxg5+FXUc3KjsQP/UD1h4ITdz7scyw1nSgtAe8lfLy0VfXwxFHtKfN8O4YCCR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6118
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kerneljasonxing@gmail.com,m:tushar.vyavahare@intel.com,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300106-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 096E769804F

On Wed, Jun 17, 2026 at 07:39:06AM +0800, Jason Xing wrote:
> Hi Tushar,
> 
> On Tue, Jun 16, 2026 at 11:50 PM Tushar Vyavahare
> <tushar.vyavahare@intel.com> wrote:
> >
> > This series improves AF_XDP selftests by making timeout handling
> > explicit and fixing sources of non-determinism in xsk timeout tests.
> >
> > Patch 1 introduces test_spec::poll_tmout and removes implicit
> > dependence on RX UMEM setup state for timeout behavior.
> >
> > Patch 2 fixes thread harness sequencing by attaching XDP programs
> > before worker startup, removing signal-based termination, and using
> > barrier synchronization only for dual-thread runs.
> >
> > Patch 3 restores shared_umem after POLL_TXQ_FULL so test-local
> > configuration does not leak into subsequent cases on shared-netdev
> > runs.
> >
> > Together these changes make timeout handling easier to follow and
> > improve selftest stability, especially on real NIC runs.
> 
> net-next is closed, but in the meantime I'll review the series ASAP.
> 
> BTW, another thing about selftests I had in my mind is that are you
> planning to work on this [1]?

This one is on me. I took your changes Jason and aligned ZC batching side
to this behavior, followed by xskxceiver adjustment. I am planning to send
this today EOD, however let's see how badly internal Sashiko will kick my
ass.

> 
> [1]: https://lore.kernel.org/all/20260520004244.55663-1-kerneljasonxing@gmail.com/
> 
> Thanks,
> Jason
> 
> >
> > Tushar Vyavahare (3):
> >   selftests/xsk: make poll timeout mode explicit
> >   selftests/xsk: fix timeout thread harness sequencing
> >   selftests/xsk: restore shared_umem after POLL_TXQ_FULL
> >
> >  .../selftests/bpf/prog_tests/test_xsk.c       | 96 +++++++++++--------
> >  .../selftests/bpf/prog_tests/test_xsk.h       |  2 +
> >  2 files changed, 56 insertions(+), 42 deletions(-)
> >
> > --
> > 2.43.0
> >
> >
> 

