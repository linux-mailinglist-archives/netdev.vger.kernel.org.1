Return-Path: <netdev+bounces-157852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29B4A0C0D8
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3119F7A027C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF511C4617;
	Mon, 13 Jan 2025 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEs523jK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB34B38F91;
	Mon, 13 Jan 2025 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794520; cv=fail; b=gpmiuhIYqijlrh9+3JcFwZMSlJYa51mXfjaeqzmQrpeFxuewc9fEe51zksNtBAaEZ/K89m1SwnlbJJjkZ164G4gPm/Ep+OAf+Td16wvveHBQ1DU55SSYWHPXYziY99QR1Kj8wRXdc/qSR99M8eBvhxR7pTE4eR6FR0ad9QvmmF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794520; c=relaxed/simple;
	bh=Jfyyshxz1LwgbUuo1ucSACTGPiT7R92eUfdS//VGGcg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZddSeEZtHTeJZx38RuRRolRkP4dnw9IIxLDG9dzJ3sYXjNk5A0V0MlVNc05p0sljJk1njIHjStmD4yR5pVKL43kMprIvBEdLc0fWyguMdBScsp/BkEKZUyQzbFL5Uw3l9VGepoQyMXcGMK+9Oaq411ChMkPGgWis3eCJV1XqUtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEs523jK; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736794519; x=1768330519;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Jfyyshxz1LwgbUuo1ucSACTGPiT7R92eUfdS//VGGcg=;
  b=QEs523jKSyVPXMVFI34l/wciiLENiVCrU6AgNuvdTDHBbNnTB/gImv1X
   PNZCvjcOjOCi3DbUoUrhovrpQnnujICbv2bUQ/slgiNQt/vnlQ6Txc/Mc
   FKiUJH+9zqXRLaj4D0/7N7mTG1UFfR06cIUH742CKoMYhhXzFZck52iXR
   8n2AWlIydkmuejq/xuUW2vMndJwdo4s9q/EtS4JErXs6qd3M4EW9WENhD
   tLEdF+IKjptaVOPcWnbhz2FRSzZUejXHYdoNk8DLPJhOHf626Wk0lh1my
   Ti7l0V1dCHjOeg7jE1oYlu+qdGTt6xINpf/XhZQXK/JzOQZfme13kUHw1
   w==;
X-CSE-ConnectionGUID: 5wJwbAOcS9Giweq6F9+23Q==
X-CSE-MsgGUID: Wn4yWiunTfeEQe3RijIkRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37233506"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="37233506"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 10:55:13 -0800
X-CSE-ConnectionGUID: gHhwrvmoT4KYPzhzVroNiQ==
X-CSE-MsgGUID: Bvwhy16/TGWU1qeD9y0aOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109703713"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 10:55:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 10:55:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 10:55:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 10:55:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmiKPF0URXCqV423cNM7/eUe1+Z5w9jJasofj930q/sIdct/4tfPVsZsmbXoDx4UDP3J+J8J06eJDuvYW1w6FvF0qCzTw8jGJjF88IfLFL/yEjUoil9IT9RHEFQCOywSlzQOTV4oWqgCHwgHVSAUZiz27il/zElnio2UYxktnmHb1q2dVPb81EvKz/JHQE5kmoHj0lAJ05+mYdH3k6GvHg2qguc5qiBXOUcAop6+cPBL0B/pDnPx5Xnm6M7MEl01UiD5BxLGK6dyBSiLWsQJ2YJ+9n2hu4cHpudFXtc3KAYJpms2Fmrf+FUMJdysr8Lxpvi9SLg/8yHqk6T5jOQTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS+gRLDrYrQKo7bB2s5v176DySJv5KDz20Vp3q8/Ytc=;
 b=ofhn+DVT5P0/9H6XwEZ47XPEKDRqGdfx708xVCbJ2evnayu+1TAyQT95kp7Mx7+En5dR/rVinxmKOYSO7zdRQUGiY94vussyaQzTTo4dsrk8/q1q9eOOWBAkxN28eM2HHv8BbkCQOaGLxBeIZlmnEpBzWFlg9s4HwomN5xwr0pn2z21rJ26dU0UyfxelM/kwqPhvUsovJOe69Z7+fCyPMiN6WwyOzoj6B+nykI5ayzrdX23jie6Ab8ViUNDzpaSA63sggxbjzxgiseU31IIa6YsqXZbHUemc6pkqwSU0rGla1Z4flZNLwTD6EhU/wsaoQjxZQ2tfgtWAT19JmoL6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6750.namprd11.prod.outlook.com (2603:10b6:806:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 18:55:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 18:55:10 +0000
Message-ID: <3c48a608-b2d9-4210-9718-1518a758abbb@intel.com>
Date: Mon, 13 Jan 2025 10:55:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] net: fec: handle page_pool_dev_alloc_pages error
To: Kevin Groeneveld <kgroeneveld@lenbrook.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250113154846.1765414-1-kgroeneveld@lenbrook.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250113154846.1765414-1-kgroeneveld@lenbrook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d833d78-2126-4635-9c5c-08dd3403ce45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVVnVHFzUzVJMk5tT0ZJbDd0T0JpQzkxSGpIZ1NWSVBmZVk2UEdVeE84ZENs?=
 =?utf-8?B?TEVaWnRPYmljZ1ZFbWN6U3JlbXgxSHFLc0FNdlV3Y0ZVUjlBcHVZMnJFK3JS?=
 =?utf-8?B?M3RZL2dDVnpncUFrWDN2ZjVQTlBLSC95RjVlV1F1QmdEUDI5Q1pUb3NUdEk3?=
 =?utf-8?B?eTJaUE5BNWwxdG9iWFNEdFU4MEJvQjU1QVZnbTA0SHJXS29nTVVxSzFYbzFp?=
 =?utf-8?B?c2IyTytSNEtQY3NwbUFiZi8xcGdBbnl4TWtDOWs4Q0EwalZBQ2J3RE13WWJN?=
 =?utf-8?B?U29XOFpLY0ZjamtNclFwVnZhMTVlRzV5VEl4dzR2cnl1cFRzQUxkaElxSlNT?=
 =?utf-8?B?OFFraE83SWJVNm9zZmxRNVBLZXVqa1VTVFkyU2RYYzNoQkF0Qjd1ZDl5V2Zn?=
 =?utf-8?B?dVNSb0dkQXVEZ3ZwQUtDdHlOclV2V3FrMVliUyt3U0NxMnlpcCsvTmJlYlBU?=
 =?utf-8?B?d1Y3RW9UU1MzVit6ZldMOFdWaEpDbDZ0NFp5emFxZWxsWWQ4WmhRSy9NMkhX?=
 =?utf-8?B?VHRBTUNpWm0vVWxmWitBU2c0eFhFRWREM3JnUWMwTUVjMDI0Q3JLNXZuSTJ0?=
 =?utf-8?B?QkVvdlJNREhHZktjcmprRGZXMS9PbytCd1VlWXAxYXYvWm5jcnl5ajVpNGJL?=
 =?utf-8?B?THJSTG50RndPTHRoWW90T0wvTDZPWUhFcllNelRVVVpSVy9jL3BKOWo2NlNq?=
 =?utf-8?B?bjZobzF6YWRhN1p5dytueDNzWHlHSnFEeGZiRTk3c09ObUlKY01vaWQ0angz?=
 =?utf-8?B?SSt1b0Y4ZWhOWm83RnZZUE9mZ3VWR2NIOFNxSmN3bk9jU3lmK3kvVmtvUWEv?=
 =?utf-8?B?eXZYY2plNUo4YysrRHdTVi9BRklOZ0V1ZjJ2RWg3UHA5NTJhemtjc2FBblM1?=
 =?utf-8?B?S0I0YTRvREk2bVNTcVFrMXBqRmZ3bUdrVHhESHNkT1R0ZXpxK2ZCWFVZRHNC?=
 =?utf-8?B?eGxzN1g4c3hubGg3cVNFaVYxVGJubWdEK09hZDZJYmszMm04dDJHOUUvV0dK?=
 =?utf-8?B?YzJTSUh3clF4WHFpenlZNnVpaEVnWThpc2UyM1MyTlpZK1pnTlFEeEZweUVw?=
 =?utf-8?B?dlpVRnNKQi9DOHp6RjJOL0F6UThqMm1uYml2b0RlZmdoaEJtZkYwZmgzL1ZX?=
 =?utf-8?B?dHNTNmdrc05NbmpGSmw4SnlkSFFpRkZYKyt0ZS9GQjU3K0JFZzAweUdxcmVs?=
 =?utf-8?B?bFdJenhwc3daZ1pJYzNVSWtuTnVsS2xSaXNHd0szZEZxM0VUQk1VbmtjZXpw?=
 =?utf-8?B?b3ZBbU9EczVWTTZLRXJ2aDBuRDhBcnhEUzYzUWFlNCtnRHJncTFJZDFjb2dn?=
 =?utf-8?B?dzFHVEZ1ckNCS0oybzF2M240VkhSUTBEREFhZ3F2OU1EbEl4US9nS0psOVJW?=
 =?utf-8?B?Z2hhbE5HVURjRDY5TjBJMUVNRlZueXhNUFYwV1J2L0lEZHNVNXBLQ2lwZmdz?=
 =?utf-8?B?aVloS21xUU01cXZtNFV6UlQ2SDFWNmJ3a09aUUErMjM2QXh4Si9MbG5EY3ZG?=
 =?utf-8?B?ekgwY0ExbjlzMEdBS1ZoOTNUU0hyUmc1MTY3aitTWnNkWjBwZEszRFNzMmJW?=
 =?utf-8?B?LzRvUU8yc1hsQkVyM2pXSmY5VW9iaWF4d2JKZTNzZHFsOVc0QnFkT3RYY0to?=
 =?utf-8?B?K3F2R2JZMlRGUFhQV3N2R2ppUFR3dk0rWlRJV05Vc0RZZXVOTkY3eUZ0TVhM?=
 =?utf-8?B?b2JCUXVUcXdBTFdPRnN3QTZFNWhPRlY4MWVkQVVRUHYrdjVVVFUvZGZLQWxz?=
 =?utf-8?B?TmN5Q0djU1JZempzc0d2ZTFhbnQ2VVRMa1h6K0wzd0YvSERPOTJWM2dnd0ZB?=
 =?utf-8?B?QVVpNklKZUtQQmYvMjE1aG1tUGdzeU9id2grWWxIWE9YZlhFay9CSHEwRENj?=
 =?utf-8?B?NnFrcUdENVlLNTRxMXVPUVE5VmU2bGZrZHFqaTE4dmdJUlNuYnJpbGZMYVV3?=
 =?utf-8?Q?oJBP0QQAe7Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cktDc2ZSd0pwOElXQUZnNHdFaG9UQkNGWm10UnltZG9XNWNyaE5ENGFzVzhi?=
 =?utf-8?B?NExsRjVQVG9GQkNNTEovNXV4NEIyQzFNYU9xOUQvK215WjhwMDExSUZsZFhB?=
 =?utf-8?B?UDlOOVFoVjVIZENJcWZVZUdiOXdHSlJwQ2lNcUR1UHdoTTB6Nk1Ibm1tQldW?=
 =?utf-8?B?TGVlOVRIVDdnVS91SURuNlJoYjhORjVld09lUVlKM0gwc3FoT0FxS2kvNVAr?=
 =?utf-8?B?VmV4QmNleFFZQzVrU1ExaWNlaDFaVURSTVc5TVFaTzdkd2ZFaFJoM1FHRVZ6?=
 =?utf-8?B?VEc4UTRHcGxwL3VXcWNpUmRXZ3d3MUdTY1BvMDRDaEZTZ1JGay9jS21NUUxV?=
 =?utf-8?B?TndrblNMTnMwampMd3l3bnBMdjFmaE1OaVA0UE5oL1Fkbk1UMkVGUmJFUzhr?=
 =?utf-8?B?RUVJME1GSFZCWnRndmwranUzbDRQRmVyWnd4azJhMEJML3dlVTVVNkh2TElT?=
 =?utf-8?B?ZkM1ak9WSzNUa0NqRU9ueWNxSDY0a2gwUVF4eFpCNlVuRHc2OFpyT0luaUdJ?=
 =?utf-8?B?LzdqSGJJejVLNkZFdVFwOTJQM1FuaGRpOE5RR3hlZzdXbFkzNTVYRlJUNzZM?=
 =?utf-8?B?cjdUZlJLeWhidThEOFcxTGMwVkVZbGVVdkhBc3R2M2VRRUZXSDl1T25xRlBn?=
 =?utf-8?B?Uk5aNnBNQnczSldEQW1USGRHbXVuRlR3R29haEJKMGdFZXlVd0o3QXltU1dR?=
 =?utf-8?B?d0V1RlhVczlmRWp0bzdYb3BKWWJKd0FXM1BTTTZpeisyWHduUzZlTXVVdzhx?=
 =?utf-8?B?OURXcGhTbENPNkJZTDdjZHNyU1ExWmtaUWNncnBSVWlpbi9PeXo4Q3UyYzM0?=
 =?utf-8?B?bytXcFJGcjU5QXhOZEtlcTEvbFBpbHArY1lIKzl5R3d2NFRFaXhMVFRuRUNq?=
 =?utf-8?B?RG9xSjdEbmpsZkJiYTg2U1ZEcGJ0S3BLMWZYNjRHZjI1U2hOeVBGU3k3SXJv?=
 =?utf-8?B?cW1vNFo0TGVMRTJWSEFWSXpHTTJDdXhBRWJsMWJFVFk5KzBnK1BJUFZHTjcv?=
 =?utf-8?B?ZFlUbmlRd2VoVlh6RUZRYnI5Y2FmY2NseXlNckdtNHgrdWdVU3JQREhhSmpQ?=
 =?utf-8?B?ZUpldmhOb2twNnhqc29yZzZjNEh1WlFpZVpiM3p2TmIyUkZqTHp1ZFgzeXZP?=
 =?utf-8?B?T3lUbzAwbFlpK3NQVzJQS3VvSUVSVWFrTHpLZVVMTWFnOTE3dXI2TmpPMW54?=
 =?utf-8?B?Mkk5aVFhNDFSbVRObWFGQ090UjlmQU9QVGRiemN0eGFGNko5YndUNkNLa3pZ?=
 =?utf-8?B?TS9vRlVLeTJNOFp5bzlwR2RuaEFzMUp6M09Ebk16cjhEc3hvZEQ4L3NKcnZN?=
 =?utf-8?B?QUVZNGZham96aGNJSnVKdVB2ZWhMbDBhM2FqT2pwUlUwazhySVNBTWM3VWht?=
 =?utf-8?B?dkZaUG9XZ1JQenk3bXZ4ZS9IeWNhQklJbEZITUtMNHRlTlB6VlhMN2JjQkJR?=
 =?utf-8?B?ODk4K3RjNGtOYk5EMnNGZmVXMzA3U0pWeEZEb2hjOGhnUCtDM3NVaG1sRHZV?=
 =?utf-8?B?NDRtdTROTi94d2R0ZWcxSFFBaGpqMndxTTJTdHROcmVYaE9GcWVkWFFISWVl?=
 =?utf-8?B?ODcyNjE2ZExkVlBpVzlMdzk4WklsZjhZSUdPNXp2cE5tWnVMaVEyS3oySDE5?=
 =?utf-8?B?bGFmVUR1d05YOXk2SFh3OHVESDJTV1ZCSjVlYVovOU5RQnN2WU4zZlJ6bXB5?=
 =?utf-8?B?MjRrTUthUmpxTU9udjFvbE5XckJlL1lYK01NTHBJVWx5MGVkeFJwTjJnS0VN?=
 =?utf-8?B?UGJRbTQ1UitFck9ZV3ovVHBpNXY0dmYzdDNQcFA3clB4ZlNaVm5pZDBJTFN2?=
 =?utf-8?B?Y2hxY21zckoyeFo3REpNT0I2WlY0bzhLUENLZks0MXJXdDROUkZYOWU4d3pk?=
 =?utf-8?B?NVFaNE5yK2lWRUE0aFJ2ZHhRYjVzV2JEMU1WYi9nWU43YXhOSk5tMkY3VXh5?=
 =?utf-8?B?Ry84UWJZUTdjVXN3Mzd6ME9pd0lFUWhYTU4rdWd4MTdyUGczYjN1eVExZita?=
 =?utf-8?B?MkZZdS9ITFVZWFV5VElpUlViaW1RR0VPSEtvSklVZC95Qks3NjEwdi9WNFR0?=
 =?utf-8?B?MVd0OUZxaEd2a0hDRUhkWHIxTzlLdFRUUzB3ZDZNaENidzg4ZzdFNzYzckdk?=
 =?utf-8?Q?TrwhqQM0gZk2RpjlWm8PEEMBN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d833d78-2126-4635-9c5c-08dd3403ce45
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 18:55:10.7858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lG3AkYFDezt6e9O3ZsJkDFuU/m8fBszsNIZOirBVUzV1aFxmP9RsFFHBS/h2Y0CjwGX5v51EGjSOF8X+nOnxAO4yb2iX3MQU/9OdbqAm48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6750
X-OriginatorOrg: intel.com



On 1/13/2025 7:48 AM, Kevin Groeneveld wrote:
> The fec_enet_update_cbd function calls page_pool_dev_alloc_pages but did
> not handle the case when it returned NULL. There was a WARN_ON(!new_page)
> but it would still proceed to use the NULL pointer and then crash.
> 
> This case does seem somewhat rare but when the system is under memory
> pressure it can happen. One case where I can duplicate this with some
> frequency is when writing over a smbd share to a SATA HDD attached to an
> imx6q.
> 
> Setting /proc/sys/vm/min_free_kbytes to higher values also seems to solve
> the problem for my test case. But it still seems wrong that the fec driver
> ignores the memory allocation error and can crash.
> 
> This commit handles the allocation error by dropping the current packet.
> 
> Fixes: 95698ff6177b5 ("net: fec: using page pool to manage RX buffers")
> Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

