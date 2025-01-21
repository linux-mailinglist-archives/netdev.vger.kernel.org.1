Return-Path: <netdev+bounces-160151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2818DA18880
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 00:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAD116B162
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969E91F78FA;
	Tue, 21 Jan 2025 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZnm/cMJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3483383A2;
	Tue, 21 Jan 2025 23:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737503070; cv=fail; b=bl2dLSfKwyRIVkpzknvx6P1IcKdOAlUmNMeG1e73hJGsxne7DjaV7gr+gyqlKIQyMgMdTd48n3oPHE9kNWwyy67+sGCd0JMuDoUYTaozTg9DbWx6r1kHZZNX8vYE5U3Sg+bpAITz1GZZzep82DWlFq7yZqGQf67ooNguhCpaG5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737503070; c=relaxed/simple;
	bh=0bqx+kmTjqLG7dwQCMZjKfVzZ6znBS8F2OlVJKrf+Ao=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NRhYeThV7iQorp7tdLKs6RLogJ6OQesaERzQ4QFaGvJku0yMw6FVjAfy1+nwzfmIw3IBE3lId+3DChAt/dSLSEESlqX85oYf9HHMYEV5dZ3TPtJmoUZA0mbsh5J7VzkNZwAGvEKGM4ZB4Kb0+zlHvjHSVgXkk/Hj3zeInl+4tqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZnm/cMJ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737503069; x=1769039069;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=0bqx+kmTjqLG7dwQCMZjKfVzZ6znBS8F2OlVJKrf+Ao=;
  b=TZnm/cMJIG6otsWcARRKT6aGKpoBVnOMUGEeHLpCPOoHkz6yr+PoXiRF
   y5sxYaIBPFJAPdJpsMpskvS+bsrSE4Ciy0WclvJ8WUZPPRjMi7d2raHeK
   bVUH37+YIO9fNwnXAomgW9kYO029HuNhpdC7eiO6fUZVKP3HtX+233Ls/
   7ug8lZR7/uOOBXskFkaM+/nQBTV9Efdn7Od8+GJAf7MkmKTaGjSjsajyJ
   gAXbrFMnD0BYQ1fEeJWwD2lZ4iL2Wcyzt0OVQBMGidqQAOCGjt2bHJKJZ
   Wah8ivZzlywCam6m/05VHflqlkrJKDgWSwA3l6DiRJy/csCz9fq9cUwCq
   g==;
X-CSE-ConnectionGUID: gZKFtLwQSaeau33p/MtvmA==
X-CSE-MsgGUID: FtCk8cxzTD60saibITarAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="38108733"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="38108733"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 15:44:28 -0800
X-CSE-ConnectionGUID: pjd88FgjRoaijm26v9UbSw==
X-CSE-MsgGUID: fBd4AowMQW2YUEIOOZJpDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137829072"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2025 15:44:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 15:44:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 15:44:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 15:44:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrFksGiAOUt3tOsl3UZTnts93v5bRJapgmcbKxQlUVp2SNKqWJsGJ+6EAgANd3XIQZ9oPN3bdXkm4rWk3bJVYmiNsg1iEOyRuQIozZnXxgfsXDaaE8GmYQYG4/ZqgGKyBjrmbbLqjR2qfTTX/JTqJcup/rbmdQCdnWzOo8CJOZrKDi607tlFqYOMQQPGqGuVmRbwlLFubq1Hsgqr6A6F1CFxuQaXjj1T8WN6VL0VALj/j1MeOy7hxx9U1CxZRU5TDPAehZRj4AA2hekXEpsLhulWwHuhgWuDbkTKXigIc/qRbkd1K4DFkpZO9L1+nRT4xnlKYPgQzhGwLnbOrypSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4Ix1N9IFAqvgq57NRGvCSAppLYDooB/a3qcATxBWTA=;
 b=pQEPtzxsr5FEMru+Gj4TH7g35XyI8+/EYC9ItTyBrcsFdoBuJwfBjK9uaklJNRiNWTZfaopqsEuDnFYrmOGjxlOR/XYZdPDXUM2jHpO6eNtgk49cbe64WPCJUXQDaNEZbIryhOv0RSloWvEzi+slv9+qpEzJpbAhIB1+b+NLkk0yW+poLQgRmvA/i8Pchc5rzkWC8ZTa2NNp8xJgkXR7BvRZrziaLjLP9AASPR2JYv/QEEWcl3+/f2HGfbEIi2u/N2jg0jatgvLBcPCqNQM7tKI1rQZvQMjWHeCKV86UPvkwco+As6Li6bDtypG+W/vnaJb/g+Yy5jIOBM7kh45ATQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Tue, 21 Jan
 2025 23:44:11 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8356.017; Tue, 21 Jan 2025
 23:44:10 +0000
Date: Tue, 21 Jan 2025 15:44:07 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v9 15/27] cxl: define a driver interface for HPA free
 space enumeration
Message-ID: <67903147bc715_20fa2942e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-16-alejandro.lucero-palau@amd.com>
 <678b19bdc3d8d_20fa2944e@dwillia2-xfh.jf.intel.com.notmuch>
 <80dca432-6308-26f5-99c3-47dd15858259@amd.com>
 <d71fd820-5dd8-0010-226e-f8f6b224de1d@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d71fd820-5dd8-0010-226e-f8f6b224de1d@amd.com>
X-ClientProxiedBy: MW4PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:303:b8::8) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|IA1PR11MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: 0872835d-af3e-4296-9bfd-08dd3a7580e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i8XWiiO+hasAzYz/HXWg7FcMfi4JjbixSYM5ULCImMH2axsJyjOZDjodWt0l?=
 =?us-ascii?Q?2U4sQPT34MlfHjxXRY1vtsHgTmh1N+ax4PY+OEoFeLWEQN/i2nELZGLuNuhy?=
 =?us-ascii?Q?y/4ZUn1KpOO1fM9yxk28v0PWRnBDv84zEeqmCQbKmt6v9goKGu8luqjZHgN/?=
 =?us-ascii?Q?tAvCsw9UhE0WrD2Fk/VP0RXGrN0jsdS1AbanzF956eo67xAz3Jkapt3/e5hE?=
 =?us-ascii?Q?rrZ8j3fmOeGoe4M8sTTqBSxVyZZpefj5rVPZf0qVU3s2+4/bMmqGjiGI2N8n?=
 =?us-ascii?Q?TbkFB0yj0fxbRqvZOTg5aMpAYkBtgf9noYWG1rzcyDT7l3U2ucCAvK1vj/Lt?=
 =?us-ascii?Q?+c1gwsz+apntDjLdgVsvX1zo97D2+7nQVzh/uEGksJLfQAhuoNFVwsJI4t4w?=
 =?us-ascii?Q?eHfA5hFQMlfE5ePWnyQt0/gQfQJpjRUH1dXtEPq3GRIhwCQ5O1xpW1gI2awz?=
 =?us-ascii?Q?8CGANNUTebNCT2KIhT9mzZKV4yfYSHrmHkMOcELfHf28zIap4iS3uQzE50p/?=
 =?us-ascii?Q?2xHMIPEo/SKZBWT15sXtV2BoNaAHAYRltFcUDcCuMYcphmk8/5Co/9scArcZ?=
 =?us-ascii?Q?h4WoVB41EvKD1SiAga/C3hTkJBqM6elIJp09EuVySCGj748WK+mKRrmw7mjj?=
 =?us-ascii?Q?oGpSeq7EC1C5vwjQWThig9QM6j+QDQZzgDs93Wpv9hzGs9lrynuC/6BRD/nG?=
 =?us-ascii?Q?CcjMD6/Ya7XfZuu9k7i9uQztMznWvzqa4qZkllUjIOJxVpuZepv8vBGV5hbX?=
 =?us-ascii?Q?Z07FtJnpgIsaO9MlPj0GtsDS3VUhw+lqxvfbTayIgignXPaColSHLWWP0tcw?=
 =?us-ascii?Q?xiOEpsNc6MY7toMF4t/x+BC30S+PwQwLzrjxHKo1DGq0/P9cM+GJHZ635yYg?=
 =?us-ascii?Q?8tHFDqSpAiFD8Ob/vqawKAL9KMisfT4tuKymbNKpUsUoSFaXEXziwezLMXiU?=
 =?us-ascii?Q?3fDNcvCRD0TdbaM/GhUUu5a3fi5lg/+1yokYMdKZPkVB7so/VFnPbeqpgI2U?=
 =?us-ascii?Q?9tkVfxb/JCrmwDARZbQkhURKgOQA7b7jjhJ8uqt7UhTSIomEbAf+xSrqsVZ/?=
 =?us-ascii?Q?2XMRExesj0mzN8ngfFgLWIdWztoQye4AnlF4OF7HAfykeLCuQ3cX27LE7kC6?=
 =?us-ascii?Q?pX8YAKP6KhYSuYM03I0TEFADkU2FZ5ys2pSl64V/Z1eoFJkAP779ZVbk5HWz?=
 =?us-ascii?Q?JZIevM4pw9WF8sWrD4O0VTfpPr1o3/1pnTTDRq1CkLBvlmPy88V/VMFsE+xG?=
 =?us-ascii?Q?rTrkuHtY1bfA9tC2P3fxK3+YMLIs08E5t4FcNyyokPEYrDEIzuvWPZ1imoxA?=
 =?us-ascii?Q?ZAM25AyeMUE+Beg4Tw5vFLoWmCKD6MVFaCCVeClHvT13bQInGzYhjemLYJOI?=
 =?us-ascii?Q?GmWN3UsRxF3S44SaEjL0sDNkRwXF5ACBCM4ivFZtUVmnPGU31HXWZQMSGFoT?=
 =?us-ascii?Q?2o92fohMIvs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t6bzP1xzx099m3AYamU9qwJbmdO5gyfbPNT8uaNG29U4xOoCM9QZQ1XhZRPI?=
 =?us-ascii?Q?abaEPCcNntPSOg6c5jcIwrqqamGk4RVnOq99PP4UksxKkCiufBRv2D2TtFjf?=
 =?us-ascii?Q?ePpgIZNenKuTLzUcHkpyIkv8wMzf0QuQ4Yt/a2Na9oFRWaYHMvnB17O265wR?=
 =?us-ascii?Q?Gxu5TaKKpAG/0MFTAFtN8BOZU6xpr0aZE3VoB26whuObg3/TUAo2rAec7yU0?=
 =?us-ascii?Q?jkoQ1xm661mkDwiPOPVzQhN2d3xzpt8UYAUGNQd+zm67Zyo7G34iio4/r0L4?=
 =?us-ascii?Q?lwjQzTO96396N4302XWVoFNWWq6oiq45EiNsClt9dbIhhCVqnSQnidReY0zx?=
 =?us-ascii?Q?yVPR8Ulc1zx+9M+YjQWJdN4OvwPL1Fk3fQJ4lkTqT6/MwhVyMn9tO8t9QBq4?=
 =?us-ascii?Q?0fpkozDiR4/H4VjUtt4SMar2YNKpbhC5jfDXPPJCxXSlXfeBmXDRoWbd3htm?=
 =?us-ascii?Q?2iIv3qC8Fdov0USHblKv8ahzrGwXLM5HMUK19CI/GejY70TBHufRDy4Pja7O?=
 =?us-ascii?Q?7USGIeb7Fcv7sZMrynqwh53uo+bC/G5ap5WRDeHVobmJBnyWbmeekZIWn2IX?=
 =?us-ascii?Q?micLEg1HQ1KiIVQ7MgC2yLNCyV8YIThCOjPo2J0DMi1EdQov6yVaJzufeWex?=
 =?us-ascii?Q?4Qc77/DPIXRQL1w7fzNIxgMMQNOqz86dAQVPf5KWiGRdn2WWIOHnuGPwRjIl?=
 =?us-ascii?Q?q9WnqRjt6pl7oCB7mE2DG6xoQOCIBUGrT5o9PVwH7raJCwflbFV80FzLhHzE?=
 =?us-ascii?Q?/Gp6b4WEIBrcApQP5jZy00fz/atdllsBIT/QqBQ2LUUGvQSt1xZeThSKKjhC?=
 =?us-ascii?Q?VYt0UIgoemLmOyRkQxUorYvjXLlD7Zc7MS7HdaV6trYl7JWOvcRc6o9BPxb8?=
 =?us-ascii?Q?0UkfcJSDQ6F2I1CuQXVIF1s01H1XEYAU0crTz3WmPJMtM2UAAhhoq3inwGEY?=
 =?us-ascii?Q?3Ds6APO0aJE+qDbslE6crzyi+DGJZOLXmhP1juhvyx8omj6hdQhsfQP1fwT/?=
 =?us-ascii?Q?1EGkwYHJ/M76QmuO5acPv+oOPW3qMUvTvDrWjWcmd577BZbXQ9nFhzL4x1jS?=
 =?us-ascii?Q?MJNPWYfkmq+aPbutayZv/FIFPE3OCe11t37gjRaK/Kcy7VQRbE9M9HZLO+lp?=
 =?us-ascii?Q?z1cPE+jMvaARHUg6O9Jssf3VLlOa6xPUWhB5BtBQi+VYfv8PJwv9Xmffxh6n?=
 =?us-ascii?Q?KfgK85CC7Zzp1ZY4PpaRjGlLod2jLGwRRnq19RN5o1jAJYTEr+YjGvehLILF?=
 =?us-ascii?Q?JEpT1Y2c61yeWrhbJI65WMvFlKHjlMlFVBED5a3ZWSiPckWi6W0Jn13wSCY5?=
 =?us-ascii?Q?4o54YOp2tavolI9+S+Cfd3fRHNi+JGFeJ4Ud0upIWPw/6V/e5t3qbM4ll10R?=
 =?us-ascii?Q?yVtxPhTkGgFK9lwDaCOB+8tHbpyoXAVSitkQ4aHVxcuflo+A+7lQq16lQT3D?=
 =?us-ascii?Q?cmhZ2KfKayNtFm5wR4ZJ3OJ8OEAdfg/JnksZGXlMpzlOL5aOhT5T9bpTcGSB?=
 =?us-ascii?Q?qF3W0/s+xmHy8ITXZdEb+8NzfHH62DhBfJFvbCZEXlhpt/lwfXLUt0Vy1vYB?=
 =?us-ascii?Q?IXdrurBM3Y+yOS93wN+7vefz++7/wWRRJ3hMlbki0PzunCnk4eVNJNxFIBkD?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0872835d-af3e-4296-9bfd-08dd3a7580e6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 23:44:10.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZvWw1zBbvI1bm72Q50ef5yN0KkbIuE/yxBR7IMpJD5y5NM7UBai9mkSxVUQaQ8BGEWzehhyB3L3u1qGtOA+22ZRc3GVbr4PoMv9aaPUw9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6097
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> >> So, I am not sure this code path has ever been tested as lockdep should
> >> complain about the double acquisition.
> >
> >
> > Oddly enough, it has been tested with two different drivers and with 
> > the kernel configuring lockdep.
> >
> > It is worth to investigate ...
> >
> 
> Confirmed the double lock is not an issue. Maybe the code hidden in 
> those macros is checking if the current caller is the same one that the 
> current owner of the lock. I will check that or investigate further.

Are you sure?

This splat:

 ============================================
 WARNING: possible recursive locking detected
 6.13.0-rc2+ #68 Tainted: G           OE     
 --------------------------------------------
 cat/1212 is trying to acquire lock:
 ffffffffc0591cf0 (cxl_region_rwsem){++++}-{4:4}, at: decoders_committed_show+0x2a/0x90 [cxl_core]
 
 but task is already holding lock:
 ffffffffc0591cf0 (cxl_region_rwsem){++++}-{4:4}, at: decoders_committed_show+0x1e/0x90 [cxl_core]
 
 other info that might help us debug this:
  Possible unsafe locking scenario:
 
        CPU0
        ----
   lock(cxl_region_rwsem);
   lock(cxl_region_rwsem);
 
  *** DEADLOCK ***


...results from this change:

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 72950f631d49..9ebe9d46422b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -560,9 +560,11 @@ static ssize_t decoders_committed_show(struct device *dev,
        struct cxl_port *port = to_cxl_port(dev);
        int rc;
 
+       down_read(&cxl_region_rwsem);
        down_read(&cxl_region_rwsem);
        rc = sysfs_emit(buf, "%d\n", cxl_num_decoders_committed(port));
        up_read(&cxl_region_rwsem);
+       up_read(&cxl_region_rwsem);
 
        return rc;
 }

...and "cat /sys/bus/cxl/devices/port*/decoders_committed".

