Return-Path: <netdev+bounces-190662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FEFAB8294
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E432A189CB0E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7A1297A70;
	Thu, 15 May 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6iPMvWg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFADE297A45;
	Thu, 15 May 2025 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301302; cv=fail; b=H+CYyWTKqXHNeqqmBzhsRjovTlD8Yx5UD7bOF9ROS4VAn8IeK3k2jmZ2J3HWpQ+wo3SPQSS7BRZFu2FULS565Fc6M00wRGTSBPrVarXbR3vqz6dUMSoxGxkPI6hiIwOlAiwIIO/jCGZK3GStwlZc6uOYFpd1kkj/3fDroT1skXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301302; c=relaxed/simple;
	bh=6Ybjo+MXRPZf5b+6HgSj9OlOsTOuX/wOl6pUb2YMHTc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TFdQa9GqaV5vsjsAxGvw8GwMJrLFkLrhs/feqWH3qXw47q5Rjm6K7/gq4aQPkECde2YB+ZYWT+tX2vk/BB0cqrhTBiUggYVPi7RhSBeyCnJ+zYgFO41dSI81Pzp0Q4ILSi0/mr3QFMImFI8l2awTVPxeWeMd6OB+emZO0krjMAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6iPMvWg; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747301301; x=1778837301;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Ybjo+MXRPZf5b+6HgSj9OlOsTOuX/wOl6pUb2YMHTc=;
  b=Y6iPMvWgSl3a4WvA+7NrGMfoh1VrH+OesspP5re0vfhmKI8GmmMXv/Kw
   MjybvvqqDTgJRXbrlJKb75cLhgiz596kSqZ57ClY4PIpWNRkb43f5CDpN
   xLsPZ0xJvj2ZwV21/b1LgIBBGVVeetvM6mY2s1BSlbM6BLjWdQQ+qjCEx
   Jci/o6klBYSy1LTYlFNtx1IwS6FJVKUawE8WpAlo112lUTLbAmduah1YZ
   Qb1VZvTkj31zbPzGvhzIxjxH+z3QLez3azFwepXUvl84JAUCvKgd0325f
   0oJNxF3HIbgFIc/ktVxQmQCTTVmQ1pD3hzQO8UFpyrSdsV47mRauTK7fw
   w==;
X-CSE-ConnectionGUID: wbAyRkRgQ4GCOb82HcAkYg==
X-CSE-MsgGUID: sHmWCHloRr2rSdq8u0I8TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="48478693"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="48478693"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 02:28:18 -0700
X-CSE-ConnectionGUID: I+3tKmxPRMuGHN3K5TorTw==
X-CSE-MsgGUID: KqIYbrVARGmJ2SIUK4DI0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138196400"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 02:28:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 02:28:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 02:28:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 02:28:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wk0AOYZoAw/sD2A3vI3YyJq606iz5b0CBoQiGglEIQb34D+Ua6UqDkP/eHCtLDrrz+k4VvOnn8Qbc2f21KmBP5CslHPhX7qEvpu/TjOTF/AWxpftJjlGt+RdJsaH6dTK8yPTXNME20YvFU8PICiu+eT+6WmEn+f8l14p0j+4zmtKcBUaOMciHFSt+3tHfUYCakptnco9PDdAcpLHEJKpqp+WwikWlI+s6KVGJLpYrMInK2Fqo8Au1XNGglK0/nKw8vSoOtYbinnYfn/yXCrUJojCUvmgJCuFnUdYw/gATma4oVu1qwuisbhC7jc2LvZ6L43Pw5gIOpTl9Z7khAJodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8oV/4SgjcQvHdB+Y2TJ5+I9DECPvgkP/ut6Iev6BHQ=;
 b=KMnSoWGPKi18Ztj87aVtusTXyaNcSfk2qngZIpETLd/IvtSN7Rq7BKYr+yU+ZmiOg1fWUa8tQIrsFX2bCI6ibJtumObH4xJpC0TwCDj0WI/OxYNiED4cPIpcBByW49fiX2J5hJK5H9wHmdBifWpSChzSWK4djQYXWI1+i3CE/DXyGhUQzj6B+kxannVW394B1AfF7L8urMPZwgXEOojE4dqw11CddtUfbn475cC9ysEVyYUgBm+OVrLV4u0/gr8wVbhbfxDH2o0WTJ4clG1ygVP0PGHueH/zvBoJ5Sa88DhTmbgbxP34BiEyRZV+bp+GfXpt/Y9KUw3wHpiLaYOCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB8256.namprd11.prod.outlook.com (2603:10b6:806:253::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 09:27:28 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 09:27:28 +0000
Message-ID: <9dd26263-54d9-4abb-bb46-d3cb089a9c21@intel.com>
Date: Thu, 15 May 2025 11:27:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ixgbe/ipsec: use memzero_explicit() for stack SA structs
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>, Zilin Guan
	<zilin@seu.edu.cn>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>, <jianhao.xu@seu.edu.cn>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
References: <170f287e-23b1-468b-9b59-08680de1ecf1@linux.intel.com>
 <20250513133152.4071482-1-zilin@seu.edu.cn>
 <a5274434-83db-4fa7-b52d-a0ca8dd16a68@linux.intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <a5274434-83db-4fa7-b52d-a0ca8dd16a68@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0185.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 407a5e00-4f26-445e-861c-08dd9392b5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjVRc2YrT2laR3dYNmI3d1VSWGdVVmZYMUtwWllrRkl4TDJhMkE4ZUVIRGR6?=
 =?utf-8?B?TEN4ajI2eEpLeEs3T3NDdTdvbEtVdEVDNk92ckptMnlVWVRLeFRoa2lPWXZi?=
 =?utf-8?B?bHhnODQ4RVJEVy9Db1VTVFkrLzNONitWUlpVaUZXUExTSFU0K05OVEFqeDlE?=
 =?utf-8?B?WWQvR2cvVTNodWh3NzZ6dnFmMVhrNWdiOERPNVRhNzVBSUZMcll0NlVLUnRB?=
 =?utf-8?B?SEZMdnE3Sk0zWks4cHZBVyt6OHNyTjUzNCtOMTZqZkFLWklENnEyQWVyUGJQ?=
 =?utf-8?B?d2pyVHE3dGF1ZTg2SjE2dGN4d0lYbXI3c1VpRDJBRWxwQ2lwcE8xdlE3MjFQ?=
 =?utf-8?B?cjlQRCtmRUIwZzgxRFAwS3h5SElHTkM2dXhseWNwS0NyR3IrZHpRR2ozNXAy?=
 =?utf-8?B?RG1CdVg1SHgvTzE5WFdWZkxsTVRqWFhUNnlOK2RMYVZnOGxWQVpPQWhqLzlx?=
 =?utf-8?B?ZFYxWC81SkQ0dUpuS0pweXQ4SHhCeVZtNTRlRmU1My9ESGc5UG8weHlHdVRv?=
 =?utf-8?B?Nk5MTnE2bEpLRm5PdGR6c0ZYTFptQy9uSmZCbFFDZmFSTkN1dUdlcWpmM0Jh?=
 =?utf-8?B?b3Z6Y21JUThodmhIZkhTVXVxb0JyVDk4T3Bnbk4rUnVTTEc5cEdDdm4xWXQy?=
 =?utf-8?B?SkNKdUJ3RWlybVliSmVnN2krcWVCU3JvYS94aURQSmNTOTMyaEMydXZ2Nzc4?=
 =?utf-8?B?d3RicHFmT0tCQ3BMQmFkNHc0TXlBdUcwTkdvaEJSMUVxaTRjNWRJQ2Zic04x?=
 =?utf-8?B?OUd1K2Q3aVFGMFg1eTA0NitLQnI2djE5aGxPZXpZcUdSbWl1MWhxa3gwY0JZ?=
 =?utf-8?B?a1I3R2dzZW1uLy9FZ2NzM0Y1OGV3aW13NGtGbGpZWHQyRXdQZ2pPMVlFSFNv?=
 =?utf-8?B?RTk4YXNTMlBEWXZjT05lQTV1Tjc1ZS84L1NKdWFmM0IzUm1Za1EvRFBtMFdF?=
 =?utf-8?B?dFBCOGtmYnMrU1dHQXVYS3pvTjVqdUdCNnUvL09LZXVTUDZwUzAyclE0WVB3?=
 =?utf-8?B?SVVmQzErWEhIZmQvVis2RXNNNVVqRE0vNmJpT2dNTDA5c2NoTzlFVUQvNlRL?=
 =?utf-8?B?czcyL2ozaDNZWmJ3ZXphendId3hvWklueW9NRWQvOGZ1TDk0ZFlxTHVURCs3?=
 =?utf-8?B?LzBGTUZVanBwUUVUVmxSc0pmU3U1UUViUHYzTHJuazNwUkVJNWdiUllXNzM1?=
 =?utf-8?B?Sm9xZzZESkpka1pTM1dvV0ZNZU9MYkE0d0pkU0xaaFhUTndxaDZrZHNMWCtu?=
 =?utf-8?B?MGFPUHdFY1VMdnErSUN5SDRMQWJvZ21qczRiV2NrWWZYR09GcmU1N2w4cEhm?=
 =?utf-8?B?bWRYOVVNSzM2R091dHMrVW9CK2Q1TXRkaWwrTEZSVmVjSkZrbHpqMTBIektV?=
 =?utf-8?B?ejhTaStoTnRSVG0vU2E2REZVVVhCMVNxK2JsL1l4WVlRY2NTY2JFTG1SVnk5?=
 =?utf-8?B?LzNNU0h0ZWFzL2ZkaGZKYWw1U1lzcnRzUS84emMvQzhXVy9oakJqdys0SCtF?=
 =?utf-8?B?OHhGdG82ZThwVDdQc2pOVFU1eHh4Y29Eb3JvQ2c4cGtyOTB3SkN5UzRZMlg4?=
 =?utf-8?B?cjYvMllLRjdydzlINEkzUXQ5UTdOZFRYc0NUWVFiNENlc1V3elpEc25OaVpU?=
 =?utf-8?B?U3hOVkZNN25idXpwMjFBQmVOR2RRSUtKWXdQZlcxWjJxQWp5ZXRyNlJWZEor?=
 =?utf-8?B?b1BNdzFJTWI3R1MwS2NWeFAxM1NIRUxkWmhxN05pSCtiSC80SVNLb2xoY3hC?=
 =?utf-8?B?S2dPUGthMHBmM1FRQzZialgyZFpQandjcVlwZ01XcHhKNFZqZFMwZUZJU2hJ?=
 =?utf-8?B?dnFnYzZQU29NNktaMnlkMTBmM05lVXNYeW0zYUVtWU1pYmFWSmZEZkYrNnFp?=
 =?utf-8?B?STJQQSt6V3lOeWlNeUlFVWxpUHhsSXluZjJmVUd4WnlnbXhodldPSU01eVVY?=
 =?utf-8?Q?Nz/n/E67+zA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTJRQ2hMMVdRZFJLUDZWa042TTZCbjBXYXVtajJxZGsrakZTaFFrMkpmVXhJ?=
 =?utf-8?B?dlFSQ00vQ2k1OFoxWXlETk41ZGt6R3Q4YStnZDFpVk9LSTBDcnIxNW9Manpx?=
 =?utf-8?B?eHFBQ0JqL3lXM1IvSU5kRkFtWktMbDZkalpyRFZxNHVMcDE1ZktKckcvc0RK?=
 =?utf-8?B?dkNDcGd5ekhlRjl0aE9uSUFhQy9RajcxZGtjRmV0b1U5My9DenlmUXYvdUZV?=
 =?utf-8?B?WEozQmVSaE9CN0tVOXdrYTRtQkpnVXBnK3F0YVYrQ2FGK0pFNXFuQlUvOTV5?=
 =?utf-8?B?dHFzR0NiUlMxQVRUZWZqdmsram4wbzdNS3ZLWTJBVkJpempZUkxCaHl6c24z?=
 =?utf-8?B?a25xaW5wMy9jWm03ZlNhaVBCb01vYWhmSCtReWpqd2NRc3U0YmFDZktoZUhN?=
 =?utf-8?B?aWNWbzFLT0tSV3hrbndhVE5WSjlRU2xyK0YwTTExdHpMTXNwTTNNNGt6bDd6?=
 =?utf-8?B?blhCTEUzYWNsRmFEYnBnUjR4YUZFNDBmeHZnSFE3bHhaaU5rNzYxMmM2Y2FE?=
 =?utf-8?B?SVVGVGR2ZWJYQ0V2Y3VvMGpMcHowK3E3M2k2cHJPTHIyQUlmRTMwc0ZWVVhC?=
 =?utf-8?B?SEdiTG9jaUJnclQzT2c4QUVYYmhSU1lSWmIwdEp3OVA5WFQxWGUvcmdjSGNN?=
 =?utf-8?B?RXJzSTNNeGNpaisxWEhsRDVFblFPaEFqOUl0cEt1USt5a0tUaitZb2lNczZC?=
 =?utf-8?B?aTBmd2k3WTVwWXA0UlgwU1hFZjlyT3U1U3ZsajFqNlMydmwyMW9qTStmenN2?=
 =?utf-8?B?dnVGakJtK3lwY3dLUFp2d2cvVER4aVhNaE4vNWJaanMvQTNUWFRma0g1Qmh1?=
 =?utf-8?B?YUFWSG1HcitWSkgxdDlsNFk4MEVqNU9mUzN6aGRFelFrY2hYeWU0Z3hvTVE1?=
 =?utf-8?B?ekNxYjA3WXRBYzQxRTZndzBTdHdhc2FZOGtBOUd3VkFydUowelg3amdadkxO?=
 =?utf-8?B?MXc3TjlYK3EwNmIvTmFYb1JxZzdKb0k5L05ZY2dzTXJ0RkIwbzVXck82ektm?=
 =?utf-8?B?aW0rdWdLdUJmc0ppcWdPanFIU3Jrc1o4d2RCUzlhTmF5cDJUa2o4OGJFZGlk?=
 =?utf-8?B?RllUUUFndlN1SW1mTlFPU0h2eEF6dVA4aDdMZDRtL0dKakk1UldNOHI5NUt1?=
 =?utf-8?B?Uk5wVU9nRGM0NGJsSm9tcWc3ckxSSHpMeXgvU1RlYXdaRy9pTW1ENEgxQTFB?=
 =?utf-8?B?eW1QRkFaSm9LSWh2b0JDZ1c3L25LWElPYUlNZmRQVUFLNXdsaVdHNk5YWEpV?=
 =?utf-8?B?T0EyZXYxcWt5L3M3N2NZK0pUeThMT1NtcmhYWVhvaUdIbjcrekh4VTdZS01v?=
 =?utf-8?B?T3VVcmcyNVZBMmRmL1lFa1I5WnFBQTNpWUt5dENVYWtwbHAvRkxmampFUENl?=
 =?utf-8?B?ZG1lcjF1dUhNQWJJYTZxZ1R6Um9wZTJyRTVGYWxYQjJudlRPUk1SdHBOemtH?=
 =?utf-8?B?cXZNUTI1eWRFSjE0ZUZUSnpQL0lkZnJWT3pRV0hTa0RxZ21oaUlBYzFqWlJk?=
 =?utf-8?B?cFpCNGlzRWRxQkNiTExXQVMwWjVGSTNtd0o0RGMvK0NhL3hkcEhjeWpPQndH?=
 =?utf-8?B?TE1KS3VNQjU2Y0lTV3pwQkV1c2VEdUlDZmpKNmFlSzlIWENRYU5QK05nWHJ5?=
 =?utf-8?B?NVJXZ2tTdHpTcGFUYWdjWVlCdnJEa2dkVkFobktlZENhSXhzRmhsc2paZDNt?=
 =?utf-8?B?UDVzclV2K2ppK1lQMWUrdzF6OFpKOFdJVWdNL0RiUjNTR25FOHR1amRraGMx?=
 =?utf-8?B?N0hYemdHTnZBWklWVWxZanBqWnFnM3VERHVOTW9CVGNmQm5VOXV4SFZJbjJB?=
 =?utf-8?B?cmt1a1czaVI4UnBhbmNqYUs0Wmt0S3ZmZmNtWk1tU3BiNFpEazJ4N2lTaFlF?=
 =?utf-8?B?a0ZpQTBVNkIrcldqTHdtT3FjbHVZR1hYdDdHUXNDeC9IcnErNm5OQ3BxSnUw?=
 =?utf-8?B?d2VZSXNUcnBzK2VOUTFxMUJTSFRkS1hqZ2NDQXlUazN3WE1Rclg0M0Rsc0NI?=
 =?utf-8?B?WnJRL3FYeEdnSXoxZ2lHd3UyTjVjbk82Y05IY3BsRlJPQlY5Vks5dXFydlVT?=
 =?utf-8?B?MzZwbGJhL1NDVUZscURjRWhuWVZYOFJ0bEdCYi9mTGhTMDQ5djlTWHh5UGQz?=
 =?utf-8?B?eCtHaEpaNldJVHltd2hWUDQzSXZpR0ZLTmJSMUtoR0ZSVkxpOW9JOHAyNHB5?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 407a5e00-4f26-445e-861c-08dd9392b5a3
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 09:27:28.0636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zajp4mz9pK5CVDDxnzHuRDAs44aA54y4/pUN4tPcLnWS+4xeCQNDiIsRSzGhHAd0raXtzxb5Md4/I8yQ9HVbEA7Kbzyg3kObpauN/lB/dzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8256
X-OriginatorOrg: intel.com

On 5/13/25 15:54, Dawid Osuchowski wrote:
> On 2025-05-13 3:31 PM, Zilin Guan wrote:
>> If this change is required, should I submit it as a new standalone patch,
>> or include it in a v2 of the existing patch series?
> 
> I think you could include it with the v2, as it touches the same stack 
> SA structs (if you decide to reuse memzero_explicit() on them).
> 
the general rule is to memzero_explicit() memory that was holding secure
content
--
to have full picture: it is fine to memset() such storage prior to use,
it is also fine to combine related changes in one commit/one series

re stated purpose of the patch:
I see @rsa cleaned in just one exit point of ixgbe_ipsec_add_sa(),
instead of all of them, so v2 seems warranted

