Return-Path: <netdev+bounces-208498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEBFB0BD9B
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 09:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A1A177A7F
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 07:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E6C280A5A;
	Mon, 21 Jul 2025 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAz9E3uZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3D224FD
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082741; cv=fail; b=WGuVfVRrMmuidqbPMe5laBjCk0IDl32nOERh47FbtL6wXvQNWOTJg1sE4mCLOoF88pAmF4nP3xbAkKTlAyR2yIIiH5MYv2BWmaqwHt0t5wA7+HLf2UimZ0Qn7cf3bI2+WvvQAkO3NSB3l0WxB/0JNheXZv8fA4WllExQGnQNZL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082741; c=relaxed/simple;
	bh=/ukR/B77iCTGZ0bTfcrkzK10eORAq+IAk6Ex5Y5hpdE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KVgVcEgXy3nuCh1d54iK/zJVVXKUGUCgaPaAuv7p82kyo/NvRuokGBQzm3Qj404MHKjp2Aog5aCqDhfrAqEIcPgc5yFeeTi/EeU4HWNwZ1GqVeZ2yVMZYp+QGe1l1+dqJerTiBiHl+6oWy2U312pd1wE3aCeiFhVvNSxFAkTafE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAz9E3uZ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753082740; x=1784618740;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/ukR/B77iCTGZ0bTfcrkzK10eORAq+IAk6Ex5Y5hpdE=;
  b=PAz9E3uZXA2h3abPrE7PF+qbxkC2dSPwOh7DRhic+IVU1OrhaeJtO1HD
   2b747Sj3tXI/GW6L7bD0BQnSE/VhAsBmiseOoam6rsURd5bGhTBGHdnIq
   13IWhfwtIEF5FnKMVsURDVRkUoiGrLezPD/JK/m+BHXoI585KKaNJRovP
   ZHCxcu9Sd83LKTjfY3es82ovErDBMdT2pMj0BdpMsdtBzbz5cyuCtcfVh
   j6a2e5cnuhEYYskxEzzkHzSGD3S5TmDuOUIH53qyxoGaHIdMwH2nwoEwm
   ERRFJeT+InU8FgywjAL+992zFwiW8pLw8J1cQqEKXn8vynscM1IOqwljQ
   Q==;
X-CSE-ConnectionGUID: +BDNnEoLQHe//Mc4CmC7+Q==
X-CSE-MsgGUID: fM0rz+BFRDm0RmVMP8wyFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="72746071"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="72746071"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 00:25:37 -0700
X-CSE-ConnectionGUID: 9jcz++8zS7C4HiTdj5iyhg==
X-CSE-MsgGUID: U8NlXh9zT/yI6Rjz0vsOIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158423166"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 00:25:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 00:25:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 00:25:36 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 00:25:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgnE79FmpaMaeHorxjIH6fHXRf3y7sgk3JwVB/4MZRtiuSk654ocqrcDdSRMGRk1JJKL3ZYoMtP8zKpco3WcTAj3+qhitiI3vN5X6cCJr0Z5z87tLLa9PSY0wADtbDUhZiEkdlmHFFvn6bV+5rp/FkG/m8l7tk3MkDNgRiM8ETO6YAWjEkSj8lmub6F6v/yK+zlmWQUbMZjuic9CEGfvdo8bBWEogznRXICkphLrLTmMMy11hNCB/kjfnDjjYDk2weAL26/WUIXkqbgeHI34XMXqduDTTZ91WXubm1i5xrVod/gqkTHBZ66AOy3LLJDUR3fWtoNb3UfeWK6PFYWwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcBQPruc94fJMgzBEwIqZGyeN29eJuIrOPRxC4r+DQY=;
 b=jEWK+T38Zl3uDS6wwfo73TpVUKyNo5uLswr4Mg7U9phu1zBc85JfsR3yDvO/DvZT8iRprX7xeBxFamor3HmqYTu2tS2OoU/DV8vPT0LM92t+d4iTEkHFR/gr0WGV5b/GKob5JXFIbYNyNXdH2nORRQkKPgAvsB9Z0HDy6Nyz9ut/FrFH5GAnkQgMdHXJs+3sr5XYxctNg0qqsaafxrnnHKD0PK7IKO1lypOL17z97f6dusui48m9P8VmsuoG+MgAE+7jNv67YgVo5UdGu8EqK4rfnveWtCjqaDz81upHJlB7GWNBQuPS8/RP6CqkdktwowtVKchOBjP/QXz7hOnW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ5PPFED9C9AC99.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::85d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Mon, 21 Jul
 2025 07:25:05 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 07:25:04 +0000
Date: Mon, 21 Jul 2025 09:24:52 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, <intel-wired-lan@lists.osuosl.org>, netdev
	<netdev@vger.kernel.org>
Subject: Re: ixgbe driver stops sending normal data when using xsk
Message-ID: <aH3rRHm8rQ35MqMd@soc-5CG4396X81.clients.intel.com>
References: <CAL+tcoCTHTptwmok9vhp7GEwQgMhNsBJxT3PStJDeVOLR_-Q3g@mail.gmail.com>
 <aHohbwWCF0ccpmtj@soc-5CG4396X81.clients.intel.com>
 <CAL+tcoCJ9ghWVQ1afD_WJmx-3n+80Th7jPw-N-k9Z6ZjJErSkw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCJ9ghWVQ1afD_WJmx-3n+80Th7jPw-N-k9Z6ZjJErSkw@mail.gmail.com>
X-ClientProxiedBy: WA0P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::12) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ5PPFED9C9AC99:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bdb44eb-eeb4-4930-8a7d-08ddc827b660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QStRL2hZdDhsZFRDWHoyeEpZUlQ1RFN1ZlZZcklOWDhYL2d0SFJodDluUkRs?=
 =?utf-8?B?cklJaThnamVibUpGZE4xTFJyRGpKMFpVUXp0MGJ0ZlpHWmt0U1ZwN0JONTIz?=
 =?utf-8?B?ako0WlpGK2V3ekVpTHA1M3FLcDlBRmNVVUFXRlhwemhCYmhQWm05VG1OMkJy?=
 =?utf-8?B?YlNDYm04Q0tRU3VjVHYvbjdlUFBZb3VURWs1WHAyaHJ1NnJVdDN5WSt4cTZO?=
 =?utf-8?B?WE9TZW9CNjE0Tk1ibnRXNk91Wmx5WHFwUXlZYnNCTlA1N25wR2hYRm9kZkcz?=
 =?utf-8?B?QjRXaG0vRzQvWFNDVE9VMXVOTHAxK3MzWThFQWQ4SUNIMHl5bnVHZFB4YnBV?=
 =?utf-8?B?VXl4aEUrWjJBamhFa1VFR1MxbU01M0wrY0VHSnA5bUltZTZjRlZjelRkVXkr?=
 =?utf-8?B?bXg0LzBXWjJZWFIxVVFyT3Awb3FyNnpaWnVGc3Y0dW5OcElOZmJoZHB6ZU9s?=
 =?utf-8?B?SW5rUjZ0Uys3STZaTTJ0TmFsR1kwTUQyYWJLQ3I4Ti9VZWN5Nk1SSVdhems5?=
 =?utf-8?B?RWU5SnE0N1JwVHU0RTJUQW12djBJK1hwNlEvOFpURHJnajBNVi80OTdNM3A4?=
 =?utf-8?B?eUtYb3RkZWJSWWFrNTVqdHZYWkZVWFB0TDRnMXpDRkpFa0k0Q2RTN1MybzUr?=
 =?utf-8?B?MFRla3BBZjFGVm95R2VrdDdWV2IzWno5M1RtRk9vVzN5NmYwOUpUTHNHUVVi?=
 =?utf-8?B?Y1hmaUFRS1UzeUJaK0dHVk9uUnZnTHJJbUthWjYwZXJlQzVnZ3ltdFJ5UU9u?=
 =?utf-8?B?NGZObFVqaHZXUzZCcmtPR21GU3Q3NWIyWmZKREpLMUd1b0IxSHRpejUrWEtC?=
 =?utf-8?B?RjJTdUFyVDJyMXdkWE8vWlFZekkvOGsyMXBYMWVETTRnM1UxMys1bjB3NytO?=
 =?utf-8?B?VlNGQ09iK1l2dGp1aituaUtZMGp0S2YxbC9lK3dSMFFOVmpvR09yN2FCQlNP?=
 =?utf-8?B?UUlVVk50OXpVVVNXRnpMMnpvdG1ITDlnbGRkUnIrd3VnSGppSzg3MmIrY2Vx?=
 =?utf-8?B?NkhOK2VwOGs3bG5TVWIwTGJlT3E5YnJJbTQwRklRMVMwRmZaZFNHcE9GTk1h?=
 =?utf-8?B?UU9JekRONHpTdEhDNWVDTjNBWWlieWI5U081WHd2QllaV3MvVDJpaDRGcng4?=
 =?utf-8?B?a0xiRFFHYjUxQ2pyOWpvWkpORitGempNU0REQmU1NHRlY2xOWUEzYmQ2U3Q0?=
 =?utf-8?B?bi91eUczUzhBYzNPYjZiWDNKdXFNRE5Kam5XZmFGeU9hRGc3OWUvQnlKWFZo?=
 =?utf-8?B?WEE4dlRZYmd5OTJ1aFdUN1J2dXVZb01IU3hoNVJlMG5SNGwrYkxRK3dzeFZs?=
 =?utf-8?B?bzMwOVNOVmdQSDNNNXl5KzduNTVxQ0pHSFlBbzlGajh3TDZIYjBwWGJBaFNY?=
 =?utf-8?B?QU1IUHhTMlZsVmxRNXQvaU9UZDJIS1UvNWRiY3dnUVpLRDY2eUtpZ0RDS3li?=
 =?utf-8?B?bEcvSzRyWVhwVG5BMXVuMlJ6RVhiV0MzRm0zOFdUelR5YUpGTU14cU9lRUZP?=
 =?utf-8?B?VXVhWXF0THZnM3hDZEZHalJ4bVg2V20wYjlEcnRJWmZTYmdieTVqSnZSMmVS?=
 =?utf-8?B?aGZUK3RmL1g3UmVaMkJmS3hBdEIxa1ludnkxT3FLU2ZDcGdVK3BmZW5sRDVM?=
 =?utf-8?B?S3p2cXBUS3NMbWFZZDNoOXpJRjFpZWZINHhsSFlEK3BPZ1VZdmNvTElFYk9V?=
 =?utf-8?B?SEgwZElLNW5KQnIwNUgxdzFYRHZjQ01HWjQwa0kxQnl6UUVvM0taQ1ZhMlY5?=
 =?utf-8?B?N3F4VWhQb2hmVGRHVjg5K3RvK3AzeFZwbjYzNW5IMmp3Z3dDZWVHd2dCYzZs?=
 =?utf-8?B?UmJ4VXhOY0FrMHVSZG1tMDdXUVZJMkN4UktEYWNvZGFBVWNiVjNVM3gwaFpX?=
 =?utf-8?B?OERPK25jL05uTHFCdmd5ZFhYVEdtekYydVRKVHdWUndnMVJVUkxxcUN0Umpy?=
 =?utf-8?Q?WDizwMjdgzY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTk1R1dzQkUxcW1meFp6R1VvY0gyOEFTay9DS0drelNCd1VUcFdxSHJsT21O?=
 =?utf-8?B?YWFYSVZia3pDaHNjYzQ3eXJES2RuNnVPWFliTFJCMktxNDRGQmhPSC9jTUhy?=
 =?utf-8?B?UzV5c2o5RGNZYlArbE1IUmFIWlFCZm9ObmZ4QXdxeWd3ZmZpTWlaWDAzQ0tG?=
 =?utf-8?B?MTNRQldJQUljU3pxWks1VFJRZmxYWitEaE5QVUJMaVJ6OUZkdkFCYk1aSkZQ?=
 =?utf-8?B?dFVWRjhGM2o0MkVpdEFwd0hHeVdyNzFCNEloZHArUy81RFBxOGIxa3ZxMUNV?=
 =?utf-8?B?VE96QUdkNUp2cWNWNGlCMGlKYXVsV3JwanBQRCt3elJaZGxVMXcvWjdZWGhH?=
 =?utf-8?B?YUpVM1RGTDhlNkdnV0lhSGZacjFSSDgrMFhlL25rNU1QMnliT29VNlVVMXJW?=
 =?utf-8?B?cTBpSHV1NzVMaGt1b1hwM0NjL2xieG9yMVNFWFZLT0lXajV0L3grQnliZFZp?=
 =?utf-8?B?L1pMd09RUVhGQWdxYnRpQ1lCalZoSFJwelI3TWExV09LMEJ5clNkek5nV2hR?=
 =?utf-8?B?SHVXcHRsVG9ET09Md29hYWZwcTJtVzNtWkpCQk5KaGZxQi9HM3FaZEpZVFhX?=
 =?utf-8?B?NUdEZk1uK2IxMFpVOWFJUTFaU243UjBsVWYxaGN2VGVQSlA0UytDVU5rY0lX?=
 =?utf-8?B?dXBRMjQ1c0UxMzRIeWFNaHhrcklNeTdFdWJEbUx4ZW02VzVPK3RudTdaRFJ5?=
 =?utf-8?B?ak9jWmRZSitqYXRqNk9BbTRxb2ZKblRjR3drb2pTRjJKMnJjTkpZQzJ2YWg2?=
 =?utf-8?B?emhEc1EvNnJ3c1JKNVMxbFJTVUZNSC9sRnJDNHJnQStyeVV5SnZtS0FGZklN?=
 =?utf-8?B?VVZoZEFNcVlBTTRmMEtaUHNZZ2hBZ1RxVjNYZHVTRjUxY20ramRIeTBWWFV0?=
 =?utf-8?B?RW5IWmpYYVVVd2JpbllDSjdCd0U0Ni9jcFFwRXRDTFpWUHVMUDBNWHhTbitS?=
 =?utf-8?B?STdaYUpveC9uVkEzMVRmdGxBRW5DZkUycXNpMDlSVmhROHNGYnlhWU5QcjRX?=
 =?utf-8?B?NnMza3dMQWNCc1I1SjJXNUNBUzlwamtCVWZITGkrbVg0bWpnd3BqVFpiclJi?=
 =?utf-8?B?RXErUVVPcHNsQW9rVkxGU2NmWDhoUC84Z0tWZE4rbTNzSkZRaGtsWEFsT09U?=
 =?utf-8?B?Um9idW9ObmRMMjJ6U2hOSnRIRWplR0Z4RHFZL0kyUlkvRVlKVEI0VUloWTc3?=
 =?utf-8?B?YmlqaDRUVm5TVktJNllWNjNvNzhySEtyMm9LYVJiQXFCRUV5cTFTeC9EQXJT?=
 =?utf-8?B?eFB0OFpiSjJWNDlGKzlZTlRDaHcvdlhBNlNIQ1NoOXZTQzhOa2JPSHlzSzZU?=
 =?utf-8?B?cVkxVGh1SDBBWEhMRTBXbFlqdm5tWVhkS0NPR2RYWTM3UGJSU0Urd3M5Nkxk?=
 =?utf-8?B?bi9GYzAwdDBjTHV5UHNRcEhBbFJ4OGxiR0FrUXF1QjQxa292aW5ZaHZrRE9D?=
 =?utf-8?B?UGdXYW9aT1llbUxhQThudlVDS291dXhFTEllOUJMY0pWbW1XT1BIT3RkbU04?=
 =?utf-8?B?Vk0yZmI0cm9uU0hMdkI0b3o3V09kQTFvRDEzVStGaU1GdWFDOUQ1ZVRSckdp?=
 =?utf-8?B?eG9TSVJKT2VMbkk4Z1FVaFk3SlE0Z3czc1ZoNm1HTnVyc29CVkVyRVYwYlgy?=
 =?utf-8?B?dWhNMXJsZkJtNUJwNm5kUjV1UmEyRlVPTXBOcFJUaDRoMjVPU3MveHI0SEhC?=
 =?utf-8?B?d1VoK2tKczF2YloydHdyM1QydmI5MVBxTnY5NXp6R0MrbmN5dmFjNGU1YmRi?=
 =?utf-8?B?b1hOZmYxMWQ3bDJQeldFWDhRNE5ZS20yV2tvMGRGRXBjdWRhV1NPaUg1SDA0?=
 =?utf-8?B?VER3MGxmUlBVRWVndFhoV2NyR2lKZnVTMkpTZmlWUHphWkNlZ2IwWnY0VmxZ?=
 =?utf-8?B?aDZ3bGMzVmZPaGlCWE1NVzRBMFBpdHYyaVFmbUlqZE4xU1JHdzJXWG4wYUxD?=
 =?utf-8?B?dVlTbmtHNTQ3VnJ6K0F2NFBDL0NGU3dhZXNOdXJhZ0R1TVFydnhsR1dGc2Vp?=
 =?utf-8?B?c0FjZExiWm43SGxIWkdxelJnbFlrMC9CbGJTN3RYNkdUdUo0eWRWbGxSeEtG?=
 =?utf-8?B?RFdKQm1qRDlVSFRmeXVuNUlteVh2Mm9vS2tiSXRURGh6dkZsQTFmM2ZYUFoy?=
 =?utf-8?B?VS9lQ01RS0I4QkM5N3VXU3JnbURPaEdkSm5WNmROcU12amhvSTlrV2lndU9E?=
 =?utf-8?B?Q1BzVU1Vck56OEEyVWI1Qlk1Vi9jWjc5WlN5US8ybXU1MUZTYWMzOTVVUTE0?=
 =?utf-8?B?a2RINW81ckFaUmw1WkhOZ29OcDB3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdb44eb-eeb4-4930-8a7d-08ddc827b660
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 07:25:04.7907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dY+0dVHkuaUttooD/SzzsNthN18mNUjhWUdEXa/wLf2U9QTrWwC1LddAtecbYVoEDBPBJcX06IRq6glMsXvSIa8waUgmCFsQMmAEMqanGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFED9C9AC99
X-OriginatorOrg: intel.com

On Sat, Jul 19, 2025 at 01:26:18PM +0800, Jason Xing wrote:
> On Fri, Jul 18, 2025 at 6:27 PM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
> >
> > On Wed, Jul 16, 2025 at 11:41:42AM +0800, Jason Xing wrote:
> > > Hi all,
> > >
> > > I'm currently faced with one tough issue caused by zero copy mode in
> > > xsk with ixgbe driver loaded. The case is that if we use xdpsock to
> > > send descs, nearly at the same time normal packets from other tx
> > > queues cannot be transmitted/completed at all.
> > >
> > > Here is how I try:
> > > 1. run iperf or ping to see if the transmission is successful.
> > > 2. then run "timeout 5 ./xdpsock -i enp2s0f0 -t  -z -s 64"
> > >
> > > You will obviously find the whole machine loses connection. It can
> > > only recover as soon as the xdpsock is stopped due to timeout.
> > >
> > > I tried a lot and then traced down to this line in ixgbe driver:
> > > ixgbe_clean_tx_irq()
> > >     -> if (!(eop_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
> > >             break;
> > > The above line always 'breaks' the sending process.
> > >
> > > I also managed to make the external ixgbe 6.15 work and it turned out
> > > to be the same issue as before.
> > >
> > > I have no idea on how to analyze further in this driver. Could someone
> > > point out a direction that I can take? Is it a known issue?
> > >
> > > Thanks,
> > > Jason
> > >
> >
> > I was able to reproduce the described behaviour, xdpsock does break the IP
> > communication. However, in my case this was not because of ixgbe not being able
> > to send, but because of queue 0 RX packets being dropped, which is the indended
> > outcome in xdpsock, even in Tx only mode.
> 
> Thanks for your feedback. It would be great if you could elaborate
> more on this. How did you spot that it's queue 0 that causes the
> problem?

If you do not specify -q parameter, xdpsock loads on the queue pair 0.

> Why is xdpsock breaking IP communication intended?

Because when a packet arrives on the AF_XDP-managed queue (0 in this case), the 
default xdpsock XDP program provided by libxdp returns XDP_REDIRECT even in 
tx-only mode, XDP_PASS for all other queues (1-39). XDP_REDIRECT results in a 
packet leaving the kernel network stack, it is now managed by the AF_XDP 
userspace program. I think it is possible to modify libxdp to return XDP_PASS 
when the socket is tx-only.

> 
> When you try i40e, you will find the connection behaves normally. Ping
> can work as usual. As I depicted before, with ixgbe driver, ping even
> doesn't work at all.

I think this is due to RSS configuration, ping packets on i40e go to another 
queue.

> 
> iperf is the one that I should not list... Because I find iperf always
> doesn't work with either of them loaded.
> 
> >
> > When I run `tcpdump -nn -e -p -i <ifname>` on the link partner, I see that the
> > ixgbe host spams ARP packets just fine.
> 
> Interesting. I managed to see the same phenomenon.
> 
> I debugged the ixgbe and saw the following code breaks the whole
> sending process:
> ixgbe_clean_tx_irq()
>      -> if (!(eop_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
>              break;
> 
> Do you have any idea why?
>

This line checks if HW has already sent the packet, so the driver can reclaim 
resources. If the packet has not yet been sent, there is nothing for driver to 
do but wait.

> >
> > When debugging low-level stuff such as XDP, I advise you to send packets at the
> > lower level, e.g. with scapy's sendp().
> >
> > In case you have a different problem, please provide lspci card description and
> > some truncated output of the commands that you are running and the resulting
> > dmesg.
> 
> I'm not that sure if they are the same.
> 
> One of ixgbe machines that I manipulate looks like this:
> # lspci -vv | grep -i ether
> 02:00.0 Ethernet controller: Intel Corporation Ethernet Controller
> 10-Gigabit X540-AT2 (rev 01)
> 02:00.1 Ethernet controller: Intel Corporation Ethernet Controller
> 10-Gigabit X540-AT2 (rev 01)
>

Some device-specific quirks on older cards sometimes result in bad XDP 
behaviour, but are usually visible in dmesg.

> # dmesg -T|grep -i ixgbe
> [Fri Jul 18 16:20:29 2025] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
> [Fri Jul 18 16:20:29 2025] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> [Fri Jul 18 16:20:29 2025] ixgbe 0000:02:00.0: Multiqueue Enabled: Rx
> Queue count = 48, Tx Queue count = 48 XDP Queue count = 0
> [Fri Jul 18 16:20:29 2025] ixgbe 0000:02:00.0: 32.000 Gb/s available
> PCIe bandwidth (5.0 GT/s PCIe x8 link)
> [Fri Jul 18 16:20:29 2025] ixgbe 0000:02:00.0: MAC: 3, PHY: 0, PBA No:
> 000000-000
> [Fri Jul 18 16:20:29 2025] ixgbe 0000:02:00.0: f0:98:38:1a:5d:4e
> [Fri Jul 18 16:20:29 2025] ixgbe 0000:02:00.0: Intel(R) 10 Gigabit
> Network Connection
> [Fri Jul 18 16:20:30 2025] ixgbe 0000:02:00.1: Multiqueue Enabled: Rx
> Queue count = 48, Tx Queue count = 48 XDP Queue count = 0
> [Fri Jul 18 16:20:30 2025] ixgbe 0000:02:00.1: 32.000 Gb/s available
> PCIe bandwidth (5.0 GT/s PCIe x8 link)
> [Fri Jul 18 16:20:30 2025] ixgbe 0000:02:00.1: MAC: 3, PHY: 0, PBA No:
> 000000-000
> [Fri Jul 18 16:20:30 2025] ixgbe 0000:02:00.1: f0:98:38:1a:5d:4f
> [Fri Jul 18 16:20:30 2025] ixgbe 0000:02:00.1: Intel(R) 10 Gigabit
> Network Connection
> [Fri Jul 18 16:20:30 2025] ixgbe 0000:02:00.0 enp2s0f0np0: renamed from eth0
> [Fri Jul 18 16:20:30 2025] ixgbe 0000:02:00.1 enp2s0f1np1: renamed from eth1
> [Fri Jul 18 16:20:38 2025] ixgbe 0000:02:00.0: registered PHC device
> on enp2s0f0np0
> [Fri Jul 18 16:20:38 2025] ixgbe 0000:02:00.0 enp2s0f0np0: NIC Link is
> Up 1 Gbps, Flow Control: None
> [Fri Jul 18 16:20:38 2025] ixgbe 0000:02:00.1: registered PHC device
> on enp2s0f1np1
> [Sat Jul 19 13:11:30 2025] ixgbe 0000:02:00.0: removed PHC on enp2s0f0np0
> [Sat Jul 19 13:11:31 2025] ixgbe 0000:02:00.0: Multiqueue Enabled: Rx
> Queue count = 48, Tx Queue count = 48 XDP Queue count = 48
> [Sat Jul 19 13:11:31 2025] ixgbe 0000:02:00.0: registered PHC device
> on enp2s0f0np0
> [Sat Jul 19 13:11:31 2025] ixgbe 0000:02:00.0 enp2s0f0np0: NIC Link is
> Up 1 Gbps, Flow Control: None
> [Sat Jul 19 13:11:34 2025] ixgbe 0000:02:00.0: removed PHC on enp2s0f0np0
> [Sat Jul 19 13:11:34 2025] ixgbe 0000:02:00.0: Multiqueue Enabled: Rx
> Queue count = 48, Tx Queue count = 48 XDP Queue count = 0
> [Sat Jul 19 13:11:35 2025] ixgbe 0000:02:00.0: registered PHC device
> on enp2s0f0np0
> [Sat Jul 19 13:11:35 2025] ixgbe 0000:02:00.0 enp2s0f0np0: NIC Link is
> Up 1 Gbps, Flow Control: None
> 
> reproduce process:
> 1. timeout 3 ./xdpsock -i enp2s0f0np0 -t  -z -s 64
> 2. ping <another IP address>
> 
> Thanks,
> Jason

