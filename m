Return-Path: <netdev+bounces-131617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0D998F0AC
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA891F21493
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94B919C56A;
	Thu,  3 Oct 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdwul2Qj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0356915887C;
	Thu,  3 Oct 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962958; cv=fail; b=fx2mO18snTibrtYQ2xpFs9fwDdminnw4lFJ/q066Nv3pFYaN9F6ShdlqLo+Ks7uWQRXEH2Ck10ZxKOz2E4QneZKwDzGYqtjmSgZeIjPJwYJifdsy/+zqYdCulpQuuWmDfxH9YRN/SIZaqtKUVh/imP/Zs2O8eHC99UtkO28gYEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962958; c=relaxed/simple;
	bh=YKPN28sPQNjJBx0iGfXkXo97ChXE9u95Zzkh4bDs90I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oRh155HGY5qpRUJoE1Z0RF4x0IyGN0uEmKGJpp88i6S/SsI7Lh5ehy+LJSGJYwekXJs7z3/Ja282gDqpmQa42+B0EhuMlONCmOEGHQl1hcfCTwXZt9dIpVVLHMwOczKpa7ID9OGFAMy28HBtF9+zuo5A8Gh1F+zLXizMxZP0Ias=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdwul2Qj; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727962957; x=1759498957;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YKPN28sPQNjJBx0iGfXkXo97ChXE9u95Zzkh4bDs90I=;
  b=fdwul2QjrWV5AWNrDMYr6QF+A1TGkut1wwzVC3m6N7I0kj4IZyrtThR0
   4AcCJO4OhS/a6KlsQbs7Qg1kScMnFhFS0laiVHWkqQMh8IFyDWD1Hw7sg
   p5vtlBLs0SmrjUUjNWgfDswCS0eCKS426NLvbsas9Buop1RE+txmAKNAl
   MMLsadJshnMf2enDzssWeUCYhc2mTcOYf0beOg6aO4sOuh6brPWTZD3vz
   m/vImT4Y8nkCksDtkfGoxojBjA6cBzqb7UD0FYoyi+VmJh8CX0fJP3C63
   6SDCKKNeDu7t6c835Xr96JVVWWM7IgL/3opTwRnBBxUCZC+4/8DEvSmpo
   g==;
X-CSE-ConnectionGUID: WK3athXwSH2Ml0p2YxoaLw==
X-CSE-MsgGUID: z6u92v5rS9aS0f4LropD8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="38515595"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="38515595"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 06:42:34 -0700
X-CSE-ConnectionGUID: rF0dF0kkSl+hDO04XsNWAw==
X-CSE-MsgGUID: MT2WBKQNRXyR6Nc+TKunBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="75144191"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 06:42:31 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 06:42:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 06:42:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 06:42:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zyucsfb3b60lmnDwaERgZlohs82vuAwXf02Ct99gOKMeDZlHlKAaj7v9ogySHyD7HKP7o8sJAM36G0LcBOtAeniSI0k6ac5IGH6TFrPSWSDA925jmiilsCOORhu9FkSOgkkLbQeGlFHyiKuvd1FS3a8ZA84BCijGjD3Q5DfCUlrwM5GCJuhzyBu/kKfzvMWPZMQrK/8i3obQ1ozUNGBoXUIaoH41RZGOMaHPOurAynv7nc/Pvy+gGMCTjr9M6ApBNxg+qjurQgga3AK5yf5bz2sy7hNmLRKTgtfYrAyqewAfEPFjGiQEMDP1dWI7FHwawiwkntiFCx0KGnDbWkcmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLPQHBZ+Ur0sGASkVgmKRDiUPZlI7YL4E9hinrG4RbI=;
 b=HurnbspCkGJc58x7CvGRdmttVt7QtRWb9kLBA/sJzf6vgtLGqSnlSeYGNmoaxs3ybPHcsGcE62lq+vACNlkdACQkp8BYmFmi8s0XslePDHHSK4x/EYrUiqGLrN5rWsYXI/wnurs2OFsyL2Mk0kps0TlL9uJpLvz73ON0lkoF2DBw3skDaKeDBYg7uMRygUkRFTcaE4//9CsO8aPTXADj17Tx5fXJu4sSh7lOl3kyDnj1KXOwHdKLEgyb1CjFo9G1Y0Q271gNIfwrdYln4OiAQOFW0KCN6cDpE0Ad24znLc4ctuEsyDxl8iG3jVHl4prkWAYqmACunP5//w68n7DIgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA3PR11MB7980.namprd11.prod.outlook.com (2603:10b6:806:2fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 13:42:26 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 13:42:26 +0000
Message-ID: <a2358981-289b-4fee-854b-ca6e9fd8b2e6@intel.com>
Date: Thu, 3 Oct 2024 15:42:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cleanup: adjust scoped_guard() to avoid potential
 warning
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <amadeuszx.slawinski@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	Markus Elfring <Markus.Elfring@web.de>, Kees Cook <kees@kernel.org>, "Dan
 Carpenter" <dan.carpenter@linaro.org>, Peter Zijlstra <peterz@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
 <Zv6VccBLviQ2ug6h@google.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <Zv6VccBLviQ2ug6h@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::7) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA3PR11MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df35093-cb63-4e46-5569-08dce3b13779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0JNSC9MZmpmV2NSci9CM1k5a3Y4UXJ1YXk5Z3R0ZlkyeElBMVdIbHFRWTd1?=
 =?utf-8?B?aW9JR0NVd1lmNnMxOVk0WCtEN3FOeXN5OUp3emdPNnc1eW50bFRpVE9LTmFY?=
 =?utf-8?B?aUwycnd5L1NKRHlKTVoxSUdrNFdHYkpqcmg0ZytERDRTR0Rzc2Rsdy8rQWhQ?=
 =?utf-8?B?NWFMd3FkMHlFVzZsVno1WE1DOUtPL0o5bUZwRVhGbkFmOE9uM0xRVE8yZkRn?=
 =?utf-8?B?VS81UmlnU3BsYnJMSk9DZ1RWM0tWaGFDOElTUDBwU2hORE9HSEpQL2RZeUpZ?=
 =?utf-8?B?UW1yNFAwa2MvZHVoL21JT2hpT1hXQ3kyV1VuSlk3NzF4VTd0QW11bHhxREJT?=
 =?utf-8?B?a0Q2d3dEcG9ueTVaNytCYXd1UlpmcVBmNHlXVWlDZEtXZzhrK3lEUHlVY0N3?=
 =?utf-8?B?YWh2bkFnWVJkZkhLajFoT2M3RXhFRzFDYVZucklXWjVnTWZNUGV1L1RHWjVq?=
 =?utf-8?B?VDY0MHNRN0MxVmpGVHVQakRGcXpCckQyUGtLZUcyd2NYbEtvT2xHdE90aVEr?=
 =?utf-8?B?VThSVVF6dXJRaXIvYXNIY1MrUGhrbWJlTFhZTHgyUFdHaEhtSHQrckFLNWly?=
 =?utf-8?B?bytLa2hHZkp1bmRCV3VhdDFDSjFzdWE0ZkkyUW1yOTI0QTdmUFY4WGE3c3Bk?=
 =?utf-8?B?WnQzY0lYWHVFdGpCQ0dneVArKzZSVS94UkhUQVRNajIxT0c0SGxNZEkxK2Vt?=
 =?utf-8?B?SlRBUHFNQVZtcWFtR2R0UjJaRmUrZnhuWW1UZGlXU1FPQWlsSHM1dSsvSm5y?=
 =?utf-8?B?Z1pKMmZRVjd0VVNMNTI2aHB5WnlmL0psUHJwU2VBeDBJdFVDTlpkU1ZxTlhh?=
 =?utf-8?B?Z0IzYlpabDh4c1RGVEcxa0FEWk1kWnE2T1RDOW02RTJSZFFvcnlLVUxoMjR2?=
 =?utf-8?B?d25PRzc5SDBETitrdzkyRkxpaVhZUGJoV0ZQakl4dnVmdk43S3U0Y3FmQXZY?=
 =?utf-8?B?TTM4SGt6YWNqb0NCZGppOUNNSEVObC91THI1QjE3ME9ScXoxSmlqU1VTc1pS?=
 =?utf-8?B?anEyMnIwK2R4MzNLeFUweWxMNVBQTlhScjJhRlR4WHlOeGdOTGVjb2Z5SG9P?=
 =?utf-8?B?OG5nVnBKSWUxUDBweldwMm92SDh0ODR6b2lBSWlrSTJPcjZSQUJlYkF6WTF6?=
 =?utf-8?B?cWxEckZXa3Q2SllQdW9GY1lQeTJpc1htY2RaTG81ZnRWRHJaMGlxWUpGdWJK?=
 =?utf-8?B?WmtreTZ5bEV1bW5veXVCdE4rd0FBd3Z3aUF1TmdGaVFoZFYrRGM0VXZxTnF3?=
 =?utf-8?B?cTgxL2tzWFZMeXc0Ti9scUtzVys5Y0NUdE9Jd1grN3VQVk01U1k5NnBLeEd2?=
 =?utf-8?B?WXRGdEFpeXVVRUZBdVovaTY4VjMyR1lVd3FCMjBEMjVmS1hGM1dnYzZUc2tE?=
 =?utf-8?B?YUROZFRNa1FYUWVMZWkwTGJNcUdRai85WklMNWNvQnVEcnRla2Eya2E0VEhu?=
 =?utf-8?B?dXMxYVV4NnhvcWpOeFoyTmw3bWlNWTVPVU0rWjVtU21ESG9oVW90KzBPYm1B?=
 =?utf-8?B?K1lTazZQRzFpa1Nia1AyejkxWldoTXVEOFpucW13SHhEVXRXVm9FNnZITjNk?=
 =?utf-8?B?ZS9WNTRsR0h1bGx1Y0dQd21jdE8zRGNpZWFqb0cxdURLVU4yNGpOUVltZDVQ?=
 =?utf-8?B?Z3JLTWp6c0dheWFTSVZoN2N3dGwxS1BRVllDWk5PRDJkbi84dmsrZ3Nxc1cv?=
 =?utf-8?B?R1BScHR4REhBQUszZFZuZVRjMGlNYVM1cEExR1NiYXJkQ3NHaUlVbEFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2RSU3Rvc0lVd0VGUmFKUGkrZERuWXorS1JHK1dtbnVDV0pMb3gzSWViTGJa?=
 =?utf-8?B?NEllVnNMUkJrOEQvVFB1NVlid0gyNkRrNll2bGpwb1RSOWJMeVBPV0l2bjdF?=
 =?utf-8?B?amJ4cUFSS3llOWFHcytQK3hTME42YWxObXVqRjNYN21EcW90YTlsSXJoajdy?=
 =?utf-8?B?eDBSMTB5N1pxYTJvOUNCYVpwKzgreWtvOHJhWlFJTjE3bllSbkVwN0dHUWZH?=
 =?utf-8?B?SFg4QW1pY1RVc2FGMVdhWnJ1VDRWMHMxVGdIcW5Ec3lZYWJ4UjdyelByajAw?=
 =?utf-8?B?QkZZaDBTRlJvOXhLaWRUakxtUGlpRVJ6RTZneCtpLzRYOTBlMXRkWVJPQm9G?=
 =?utf-8?B?Mk1nRWtWVWl0WGRwN0lBNlpQY05DZkZNeVR0cS8zZ2pzRVdTT2lZRzdhMjBJ?=
 =?utf-8?B?MUpxRERKS0c1cVZNTXFYNENJZGlRTlpxTnYwUjZjelFZUXQxYVg4Q2xvT3ZX?=
 =?utf-8?B?OVhKOFdjWFN6RXRLa28vOU5ieXhjdnh1ckxFSHlHU3lZeDJhZTVJMjVTTnU4?=
 =?utf-8?B?Rmd3Nkp3R3V6em1OMVl5RUFHSis0V0RkSTlZTm9wTUkrWHJTUHV4M1NpS3kw?=
 =?utf-8?B?VmtvRU0xNjIySEd6Ukd0UllPMDF4SHpmTEtWa0l4dndjNTdpdVZVQ0l1U0c1?=
 =?utf-8?B?S3hSVXFyRXZJY0tBTFR3MHEzUDZnMUkrcFpQeHR3UXpzbVhWWlhIVEhsOHNp?=
 =?utf-8?B?WmRBdXplVVF3YkVlZTRGekxrdVV0VlRndEFlNWdidXdQbU81QTh4TVN5NjBv?=
 =?utf-8?B?Z1RadmlJUUZLOXFnNVhkQThycFVpWmg5ZWlwWmY5NitmdmlNckJ0NGl4WmJU?=
 =?utf-8?B?T0gyVHhzcHNMM1JBd2ZYZ2pOZHJxUWJNZHNQTkt1dDNEV21IT3FNMHcvcG1P?=
 =?utf-8?B?bmo3NlJBNVpXUmJuZlRSUUN6aS96RzhCbTlIbk9EbFY3RHV2YVpYL1VXbW1a?=
 =?utf-8?B?cVp0UTBrdi80OHlHV1A1NDZDTlZKM1B0djEzT2p3UHc5RTdsV0JJYmtSWVdU?=
 =?utf-8?B?L0ZJTzNEbWh6QkZ1S3NNSThyUWFmNXV5UzFmRVdBenFEUkF3L0k0UEcvWmFz?=
 =?utf-8?B?VzhSZ2RIUnlhM3EyWHZuMkV0RVNUTENQSWhNQUxsM0w0K3pXZGcyRHd6UE95?=
 =?utf-8?B?OEo0ekVaLzRITm5FK3hKekhLdThiQ1pvbjBUNlp3RmYzc0pNUityQy9NNHpP?=
 =?utf-8?B?d0RGT3cxcGE3TmRWYjlYa3ZDTVlQS0NLYU9nVU5iamVKQ0NhSDZYWnBoR25o?=
 =?utf-8?B?SG1HM1JMNGJRZEVsc20rbVVzUHgxdzZsNGhLazltRjVzalIzVGgzMTlpMCtR?=
 =?utf-8?B?S3YwaU5tT2QxKytxbTBBbUhxQzRuMVRlYWx4ODZxRHhnUWJjTjF6bUxwRDZQ?=
 =?utf-8?B?R0ZXUm5VeWd5N2t5SDlpS1RuMFdhZHhzSFNaUDVRV3h1eWR3RWN2RTlsb3pV?=
 =?utf-8?B?SWhTcldsK3k0MWZRRzJLejdlZUpPcXBwQUxRNHpkWmtSSSsvU3VlYmI4RmNM?=
 =?utf-8?B?RWI3V3Evei82VFNSeEJjdGhVVkxMMUVPLzR0VUtTV1VjcWpSdG0rYjV5S2cw?=
 =?utf-8?B?bEMrTzRsQU1zRnJqUTZ6VzBRR3VRcEZpRHpVRXRVQ05qMFRPcFEveldSdWNI?=
 =?utf-8?B?bG50QnRvYXZFbEw5ZlNGUFRJd0hiZ29rN1Z4N2ludi84cE1sTkF4YU1DcTNC?=
 =?utf-8?B?TG43Z2RZRDF6Vi9ZanBjYnZhREkxWUVQenhYeGlGWUFRdHFRRlBZZWtMTmkz?=
 =?utf-8?B?QS9rVkVuV2RRK0dhNFcrNUFOZGJpbnA4dzFKZ0NaWSt2cTNjRjdWTC9xMTFz?=
 =?utf-8?B?eDA1bVc0MVpnVnRrWTQ2WVRjaG56T0M3Unhma1l1VzJjdERvQU5BTzRNNktw?=
 =?utf-8?B?U2lOR0hvZ09YOUFjY2hDc3dBSERZNGRFZWpPV1BnYkMyRjI2aGZrM0I3Y3B5?=
 =?utf-8?B?T3NTR1VuUnk2UzZ0bHR1R0xSdWs0MFhaUWZtTUVGUDZVYnlYVHN1TXN5SnVQ?=
 =?utf-8?B?RTFVZDE1eXpUYVNUZmFIdjlNMWtvNDRGSEZ6REp2NUhnK25sY3FjTmk1eUpm?=
 =?utf-8?B?cXFLc1FvK0QvSWo5YUV2bk03blNDdGgvZk9ScnlCbCtZaTZ1VDFDaGhReEZt?=
 =?utf-8?B?ZFBuaDU3eUx5KzBFcjBraGt2bmtJcjkxVUp1N0Q3dk9xaGFPbzhhTnNNeUZB?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df35093-cb63-4e46-5569-08dce3b13779
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 13:42:26.1057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHaorulSv1w5R74WPV7d2NEm9VPLs6mgvSitVIaK5T7m7+xdJj5bhR86m9+qdxFXucTifswSPtOUpmPM9jSyMMFsikiDK7eTcN87K913BjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7980
X-OriginatorOrg: intel.com

On 10/3/24 15:00, Dmitry Torokhov wrote:
> Hi Przemek,
> 
> On Thu, Oct 03, 2024 at 01:39:06PM +0200, Przemek Kitszel wrote:
>> @@ -167,14 +172,25 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>>   	CLASS(_name, __UNIQUE_ID(guard))
>>   
>>   #define __guard_ptr(_name) class_##_name##_lock_ptr
>> +#define __is_cond_ptr(_name) class_##_name##_is_conditional
>> +
>> +#define __scoped_guard_labeled(_label, _name, args...)			\
>> +	for (CLASS(_name, scope)(args);					\
>> +	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
> 
> It would be great if you added the comment that "!__is_cond_ptr(_name)"
> condition ensures that the compiler does not believe that it is possible
> to skip the loop body because it does not realize that
> "__guard_ptr(_name)(&scope)" will never return 0 for unconditional
> locks. You have the explanation in the patch description, but I think it
> is worth to reiterate here as well.

thanks, I will add an in-code comment; sometimes it's easy to loose
outside perspective if you spend too much time on one piece

> 
>> +		     ({ goto _label; }))				\
>> +		if (0)							\
>> +		_label:							\
>> +			break;						\
>> +		else
>> +
> 
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Thanks.
> 


