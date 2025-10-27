Return-Path: <netdev+bounces-233146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B02C0D11F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 12:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8409919A1658
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5229D2F90EA;
	Mon, 27 Oct 2025 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqY+uhX2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DE82E6CDE;
	Mon, 27 Oct 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563406; cv=fail; b=JZYlnsdC4rq0Ck7Bi4nh+llSjnJrkAo8fc27ZjJSZVfYM8eDf9bEDmV53ovOsb+6DiJMHSwnJYmG3oGmFy8uiWxYfumS//4lZQ0WNk/BCi1PVhUjc+khqkGwmZKkf5EIFxR4+hBYDvnYBIRQXZf1GhDg3gHqXbltB4QUr4LFJ5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563406; c=relaxed/simple;
	bh=qggynSznNfJwxxvIFWt5b0m1ebfUtApgHj+sYAS/SBI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KQzQtX14JU/+IMbJJsT2b433sZgTZm9xEfVo/hGbU4LyoSP5O0UWPAchPBksniqcmA3JCdMRghKt4pTbBXnHzMaglcjAYxvtSkEHl2a9bw2WFptZCmBoChJEMBcE1y89Eb54Pnf3co7QO/0qbp2rxFFxgRuyatPHm3yfgPybevE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqY+uhX2; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761563404; x=1793099404;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qggynSznNfJwxxvIFWt5b0m1ebfUtApgHj+sYAS/SBI=;
  b=IqY+uhX293RmWqVqSg5YzdKbIpIaerpiZyKxf95/XajoqGk7fZQmaB9P
   QkBn8mXi8iwgFEXGbw/b79VC/A0pm6xDQEyZ8dYATsxAu6CVPuelEsXe2
   G0HKXYjFXPYM+RtpRpSBKGJvzegWh1tk5i850KhlCXC1R2TgJlCBRHnhY
   i8yFm1yBo6UeJUeJgsam02yt9CMmn3AujgOVPgNWHiIh9hC7hA+4pacIb
   DIHsxQoLm2mKElRsY37TlDOrCkGp2gldBvx04a8WPOGdCccJLuoz+Yonw
   6sesq/nAyugBzDx1fFBI2yCC573YFi5mRuaGxkS6TfYTzwO+EA2/yGQ0o
   g==;
X-CSE-ConnectionGUID: 5eIGNMDqQoey8DVi1coTDA==
X-CSE-MsgGUID: BqN39RUpRLWldAJU3jck0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66252927"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="66252927"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:10:03 -0700
X-CSE-ConnectionGUID: tszSbmS4T8iR2u++Mzb4lw==
X-CSE-MsgGUID: NbD8kO5XQ4aAdBD3BxAhtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="185775343"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:10:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 04:10:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 04:10:02 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 04:10:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ga1c1v4a+akVKgH/DwyyRRLzv6vZyzhL0Vqw0plUmEZtQT5kpQ0kCAKLIZ9zBIkFeHKOn/oRz/QFFI15BRNbhay/5RCKr+oPxrvKESZy3kpdz9fU5//EOIkm8Ay9hx7AFhnnf1ynPsTGC3DnySea+Lj0saTpp3NJF5wgbkpHeNDT7FCd4Tx6hGG8J65PlzSldfzWPidQDs/kSKQX2JSdo6vLQIwGr1VYOrfiPT/uaZm3B3uOHp8Pw6is0wsyopQbLKS4RfeOcN/ASaqTy9xm54jXF/vfDD++thRpyoPM5Nhxkd/L/hIlm29jjakTYZ67YfzwDCUSQW7Q45W9Hsn8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUWsXyxbDq4LMxa516TirOYL2MUhi0S1Zv16zH5d0Nc=;
 b=jS+odEe2fA4Urx+q4gIHTczpQluAUU/GqXlICseZYwPPMyJsBh+zGdQZF+vnkWbp9YzKH9uN39Oveyu0eUVqRz9CwZvPGxaOX3RSj7wjx4b1gCTTXPbywgE3D9YNmvgYMwts65vPaxQWLodh+U3MI9fEjDXW7Bv45A48eXalMiyfj+zGilmiTqYmFCTSXYSTwUBCfh/x2FEjJRV9p/gCdu/ygtXU3Q8cDOuiJLVqgqpFjhV0NDXETSexLGe+8YIxsxzkO+mFLwGooDKRYG158AQMjMpAf3RBwlz13wzL2iL98tvhtwNUYIvk+/i8eCpY0iqRqYoYj8fOqjUhtedk6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by LV2PR11MB5974.namprd11.prod.outlook.com (2603:10b6:408:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 11:10:00 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 11:10:00 +0000
Message-ID: <fa4487d0-a077-4582-80aa-2deeccee6270@intel.com>
Date: Mon, 27 Oct 2025 12:09:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] libeth: xdp: Disable generic kCFI pass for
 libeth_xdp_tx_xmit_bulk()
To: Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Simon Horman <horms@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, Sami Tolvanen <samitolvanen@google.com>,
	Russell King <linux@armlinux.org.uk>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
 <20251025-idpf-fix-arm-kcfi-build-error-v1-3-ec57221153ae@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20251025-idpf-fix-arm-kcfi-build-error-v1-3-ec57221153ae@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::14) To DS0PR11MB8081.namprd11.prod.outlook.com
 (2603:10b6:8:15c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|LV2PR11MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b5681a-deef-4bc3-0e10-08de15495e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzZwNGU4WngvUTRMbFJJeEZ0TEdHTnFNblRFZE53MW1USWEyTVVWQ3AxdEZ0?=
 =?utf-8?B?WmxmeUx6VjNRQ0hWVU5JdnRScmFZSExNT1FGUmZXUjJ0bS8zWGlUWWRockdj?=
 =?utf-8?B?T3RpQjYxQjkwNmNFZUVieGoraDNpeWVpS0c0RXFQREZ6REo3ZFV1cDlNbWw5?=
 =?utf-8?B?V1dHWmpRSGxKa3Mzcjh3U0tNQjlUT3hybHo0QzgvMHUyRXhySFRjakJKRWMr?=
 =?utf-8?B?am1UTExFTitVRDdXV2dreTY3T2dTaVhlUGVHRGRWNmpQWlRpUEc4SElKQ3Jh?=
 =?utf-8?B?Yk1ZYUh6azJ0TTJVSHRxc3RxKy96aVBiYVpLY1daWEdMclk3R0l2QXhEY0E2?=
 =?utf-8?B?NlJnVzNicW9YNVphYTYwUnJMYmRLZmpJdWZDUTZQVEtiaDdVZStmZnEzQTdL?=
 =?utf-8?B?aDNQUHFtaVNOWG90S3BIeExPN3BvRXI4eFN2dDY3dEtmemo0RlQwelMyZzh4?=
 =?utf-8?B?OUZuK3dZbk01cmpUckFlRmdRZDM4bE84N1ROM3BCN3BzazFOck9VRE9iRC9x?=
 =?utf-8?B?WGsyWElRalNUSVN3cXhzb3dpWkx3d1o2THNNSXVTVkYyYzM1cEc3dGNKTmFP?=
 =?utf-8?B?VkZGeE1pMUtESzlqYUZVVVorenAxUFRhY3A5Nmxvc0pXeHhUMFZvRzJTVmxq?=
 =?utf-8?B?MlJxWlpUUjZMYnlKS1RaNDR4SDl0OFhtL1RGcFRTbzBRS0ZIK05Lam5hYno5?=
 =?utf-8?B?SExhN2dWcXZTbnEzZ0pvbUErWjQxVGtRVkhQMGdXUjJuVHZhV25wQ3ZBUDZX?=
 =?utf-8?B?UlpWLzNLdU93Q242TEg2TGM2b05UbGxheVVRMUhsVTFmZURYdnBpQzFpWjNT?=
 =?utf-8?B?Q0RlR1VMYUcwT3IxMzBVUmlTWkJSdFBjSUJKVEZocWU1N1JHRWwwYXBuT3Jw?=
 =?utf-8?B?R29Qc3lDWERGUUVUL2c0VlZ5WU1GVDcycGZVRzYvRi9zcm5IR0IzRHZQZ2Qr?=
 =?utf-8?B?aDQ3OG05U2ZyS1VhaVAxYmV4NUJEKzBsY09oaEFzbHdBbjBMN2hhN24vekJZ?=
 =?utf-8?B?NUJvdkwyUGc0ZVdiKzdzUy92OGFUdHI0NS9uNWZFamlDMHV4KzhZS2hGd25j?=
 =?utf-8?B?SHArV0pVb2pOTWJJcmlxOHE1YUlPaW01SXIrWG9JbFo5V3N4VlBsK2YzSEtj?=
 =?utf-8?B?LzNvOTRiWWM3c2YvWTg1Q01KMmFlOUh4Y21ydzllNXp3T3BVYU1hbVlDQjY0?=
 =?utf-8?B?TmZXcy8zQWV0K1g2Z3prcXRuZ0FRc0lFTXAzRFRqT1ovWjdwbCt1ck1lQ1U3?=
 =?utf-8?B?RmlBS2FSQUlmVEFHR0UzSUVRK3VuUE40ME9LWnVUM0h4eWN2MzFuZUtOcVlO?=
 =?utf-8?B?SlgxdDVFSlFxK2pjTDBiRGtlY293UnlEbUMya1VvcVpwcHk0MEg3OVFkdWRB?=
 =?utf-8?B?NzNuZ0l1VmhRNmxNdTBWSmt5TmNSck50WnlUWG9LTVM2U1hvd0lwOSt1NWxC?=
 =?utf-8?B?Q3MvUGt2R1pCQTgxWG9HOThuNWFBZ0pMMVNraWNOVWFhaXpWcGYvRVozZjJW?=
 =?utf-8?B?cldzSzhxTFlFRm9WNElmUDM0WTRBRlRLU2NCV2NuelBVVkRIME9oVFpXSnVP?=
 =?utf-8?B?VUM5WmFvaTkyZDd4RkRiY0w3UUhaeW1VckszaWNRQjNNS2tWdnQyNlArWWJk?=
 =?utf-8?B?NzFSYVlQVkl2Zms0bHFBdm81RGpyQU5uVldEb3pxOE9xclVoY1VJQ1p1QmV0?=
 =?utf-8?B?L2gzR292L2ZubWVHMTZtZVA0NWZLTVAvQ1ZjbFRJY0VaNGhNcjZSYnMxdm5l?=
 =?utf-8?B?SGVLb1VIai9NM2lUMjNtRGJXY0ZDVklvQXBCTmR0ekRiQ0dZUXJqYTJZUkhy?=
 =?utf-8?B?dzBnMHJXSG5wWm9UWDk3c2RMZFc0TWRYUmxhTS9nbEI5T0NhZTV6TDJ5TjZs?=
 =?utf-8?B?cXlhbHhrOFhaN3R1YXJyWGlCckV1N2tjUDhYeC9QdXRObkRSbDFRaEJBZHRR?=
 =?utf-8?Q?EJw+LYZ90+AWui8Up3Lv3M1V7WuPHW0V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFdzdG1NUzhPS0hFdFR3U0dSakFlT1RueU1VaTlnZUZxdTlrVERlTU41R2RQ?=
 =?utf-8?B?UExqTGN2RHhZbDJFeVBWeGc3TW0wWm5UdVFJQ1BKNWg3eldOMFROS2dzNVl4?=
 =?utf-8?B?Nm1SNEM2YTJrdnpXdVdvaWVCRFIrMzRlN2ZZYUxHT0FkTjVwQ0FjZzM3MTVJ?=
 =?utf-8?B?QlFjWFU1N2wrQVhLbTc2bmF1WE5SS3BUeFowZ2t0aGJzQkFYcTNoNlR1cFRv?=
 =?utf-8?B?OEMzWDZqM25YZzhzV1crYnp2bkxHLzBiM2UycWJ1OXdKNWR5bFo5NXI1b3lD?=
 =?utf-8?B?SXJNMjQreTM2eVRYOEpMNnRYemIwMk5NTlFvck9JNmdaZWJvWlRudFRhZzIy?=
 =?utf-8?B?ZUZpcWZ0VmhCR0hFNzZBWGdteERzdjloSGZpUmxTTTNSbXBUN1hhNUtSSjQv?=
 =?utf-8?B?VjR0eEc3d0NOU0lJdWR2M0tIcWsyM2VyNjMwRzZSTUZTN1lscDVzam42RllI?=
 =?utf-8?B?QUh1Nk9PbElMNDlsZnVIWVRLc1dGSTZreXZXeThGMTcrbnU4NzB2dHEvZVVW?=
 =?utf-8?B?NU52dVNrYVZHbFFMai80cE1SZlRackdlZ1ZRTjU5Y1grNVJ5b3I5Zko4Zk5B?=
 =?utf-8?B?dktzT3l6Skxyd3RWdVhRNGVkMnpPU3V5NktON1ZPRHF5WG9lSU1BSXE0OVRB?=
 =?utf-8?B?Y1U0cnFRVXVqTHhJa25rUUhHV3lHOFgyT3ppejRFODU5VVhqaEhHRVQ0WFpN?=
 =?utf-8?B?ZEQvTlFxOVljdE5UWDNweXpVUmpWQjIxTnUrcytxdmNjajdQVThPVW5oRVFa?=
 =?utf-8?B?RWVwaFFnR29xOFJ4VGlEbzdwdEYrT0EvL1pMK0tEZUt6SXlGcUlmSXZtQmxK?=
 =?utf-8?B?RVh3My90N0lCSnBwWUFheGVIMEhJVjFVMVJqN0ZoelR4SUpYWTlDaG0zZTdD?=
 =?utf-8?B?aVJJZ21Qc3YyYnYvK29hVmMrSGRmcUFmTDNTTnNQN2tVNW9PN1pKSU55M25Q?=
 =?utf-8?B?RWlsaS9YSlB5blcwOFZPMldURFd1VDFBbjRFa05GNVhNdU1uWXM3WDdrTFlt?=
 =?utf-8?B?VTYzR3pyL2hoNThTcnN1Z2sxaDFwdVVSU3k0TlF0V290SGsvTEcva2RIQjNU?=
 =?utf-8?B?N241eEJ2RHQ1RlVrbXBBcmhBVG5DNzVtN3A3ZFBON0ZET2JvdFozSFZ4Qllx?=
 =?utf-8?B?K01QYURDOXM2NnBFWDlaQWdvNEJHNVJaS3NXb1c3YUxWUXhDUkNxR0cvRWJt?=
 =?utf-8?B?ZFJHQS81Y2g4YmI2ZmtHTnoyUi95VjR6WmE5eHlQT3dQa1hoa2V2amN2VTJz?=
 =?utf-8?B?M0lnR1llZHRDNVFqZ1QrNmluNWcwQnpWd1BWVThUUXBXT01uVHA3aFUyRE1O?=
 =?utf-8?B?YU1TemcwZlZRbDFkcFo0VjlWenh6RlgwM1ROL05TaXhsd0F2Nlo3bW5aeEdq?=
 =?utf-8?B?cEJFMzRobDhNTUx4a2psazB4STFvOHhnbXE4YzdCV2xuRjFZTkxTaDNKcEZy?=
 =?utf-8?B?dWREdEd2Vit2TzVWdzdUZ0hGNEhDOFd1MkZEQnBjc1FlZ3RDWVlIWDM1ZGFC?=
 =?utf-8?B?VlJhY09zaDVXVE54N1pLK1EwaHd5azhNMXcrZ3QrUmUrcnc1RytDa2VEWmZ4?=
 =?utf-8?B?WWJ5VDdCbEZwUm5qRHljWGF0amZOR1VqaHRrTHE3MVVYYTdibEZnNXlVM1gy?=
 =?utf-8?B?VEc4K1MrcEx6b1dtVmpDcDFxYzlnSC9PZlZIaXovR0x0VW5qZnkxbS9RdnJI?=
 =?utf-8?B?b3VVRUM0anBHcTlRa2pFeXpncEZjeFo2SnpCakozeVcyaXQ2bVcrUlFPTmhw?=
 =?utf-8?B?M1NWekRtTDdvOVJMZklnNXVqeVpwOTE3NjVaVjJZSUpWWGw5dTJybnJrc1V3?=
 =?utf-8?B?TVRjYWlRcU9COGRxaDFqZmxuQ1B3aVRZL016QXlSNDJDZGQ5OXhuNmptVk41?=
 =?utf-8?B?V0hzVGg4Z1ZwQm8zVWNyYmdJalpwOXBwTTdKcE1mNDU4NzFub0dnSzh3YTQ5?=
 =?utf-8?B?cUZrZ3BVL1pwQnRuWjRab2I2WkIxdlpEbjN4U2s1cTVyQW1uTUlrdEpMMjlR?=
 =?utf-8?B?YTNtNDlsbzBlSDBZaGxmWVNFTG1KcEVBc0hGL0pQN1FseG1jZzFZckJlMW12?=
 =?utf-8?B?cXpGcE0rSGwwNFlqQTZRSzgzR2xVVzlKRTF2Q3JrYXg3ZVkrS21LZUdsM0gv?=
 =?utf-8?B?VzJqdXo5Qjltdm9JSCs2UFNrb01nUzJMdFoxSzByQ1FWMmRLaEhURTZTZHdL?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b5681a-deef-4bc3-0e10-08de15495e86
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8081.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 11:10:00.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qde9MTh6BbGzpgsY4PL4AyA3LEEZTHVbTf4ZtQKK3ZC53hyqEfWPEU1U6RLoipQbar3kiVKa1EvpD7quf+MmIpQcEbHiX4IKuvFaOQibDYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5974
X-OriginatorOrg: intel.com

On 10/25/25 22:53, Nathan Chancellor wrote:
> When building drivers/net/ethernet/intel/idpf/xsk.c for ARCH=arm with
> CONFIG_CFI=y using a version of LLVM prior to 22.0.0, there is a
> BUILD_BUG_ON failure:
> 
>    $ cat arch/arm/configs/repro.config
>    CONFIG_BPF_SYSCALL=y
>    CONFIG_CFI=y
>    CONFIG_IDPF=y
>    CONFIG_XDP_SOCKETS=y
> 
>    $ make -skj"$(nproc)" ARCH=arm LLVM=1 clean defconfig repro.config drivers/net/ethernet/intel/idpf/xsk.o
>    In file included from drivers/net/ethernet/intel/idpf/xsk.c:4:
>    include/net/libeth/xsk.h:205:2: error: call to '__compiletime_assert_728' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(tmo == libeth_xsktmo)
>      205 |         BUILD_BUG_ON(!__builtin_constant_p(tmo == libeth_xsktmo));
>          |         ^
>    ...
> 
> libeth_xdp_tx_xmit_bulk() indirectly calls libeth_xsk_xmit_fill_buf()
> but these functions are marked as __always_inline so that the compiler
> can turn these indirect calls into direct ones and see that the tmo
> parameter to __libeth_xsk_xmit_fill_buf_md() is ultimately libeth_xsktmo
> from idpf_xsk_xmit().
> 
> Unfortunately, the generic kCFI pass in LLVM expands the kCFI bundles
> from the indirect calls in libeth_xdp_tx_xmit_bulk() in such a way that
> later optimizations cannot turn these calls into direct ones, making the
> BUILD_BUG_ON fail because it cannot be proved at compile time that tmo
> is libeth_xsktmo.
> 

sorry, but from regular driver developer perspective, just after reading
your commit messages, I'm unable to tell what the fix is about, and from
that follows a bigger issue: how to write code in the future to avoid
such issues (it would be infeasible to always wait for a LLVM specialist
to come up with a fix ;))

was the tricky case to call __always_inline func from another that was
marked the same? Would it be also the case if one of the functions would
not be marked with __always_inline attribute, but still end up inlined?

what would be the cost of the alternative naive solution, to always add
__nocfi_generic to functions marked __always_inline?
(technically you would redefine __always_inline to have also
__nocfi_generic for the config combinations that require that)

sorry for my ignorance of not reading any of the attached URLs

> Disable the generic kCFI pass for libeth_xdp_tx_xmit_bulk() to ensure
> these indirect calls can always be turned into direct calls to avoid
> this error.
> 
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2124
> Fixes: 9705d6552f58 ("idpf: implement Rx path for AF_XDP")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   include/net/libeth/xdp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
> index bc3507edd589..898723ab62e8 100644
> --- a/include/net/libeth/xdp.h
> +++ b/include/net/libeth/xdp.h
> @@ -513,7 +513,7 @@ struct libeth_xdp_tx_desc {
>    * can't fail, but can send less frames if there's no enough free descriptors
>    * available. The actual free space is returned by @prep from the driver.
>    */
> -static __always_inline u32
> +static __always_inline __nocfi_generic u32
>   libeth_xdp_tx_xmit_bulk(const struct libeth_xdp_tx_frame *bulk, void *xdpsq,
>   			u32 n, bool unroll, u64 priv,
>   			u32 (*prep)(void *xdpsq, struct libeth_xdpsq *sq),
> 


