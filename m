Return-Path: <netdev+bounces-100824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3426A8FC28C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 06:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC64B21A4B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 04:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6CD6A33D;
	Wed,  5 Jun 2024 04:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R30COf0H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D85433A9;
	Wed,  5 Jun 2024 04:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717560322; cv=fail; b=K1+VYnpC0jR7B2HiGGNgJKxWURT8zw/aCPgZy4VaPUk/c/VbOYpPPIlJpKLm2A9Jh9b2EvgHztH02jMQSduiE9h7OmL7Sy9uWskdPUZMJsCgZBoXxvgEVngwgOKews8kkW5x3s5pbV3un3t2rcolb94HcQcPhahDvjfsWOSLsjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717560322; c=relaxed/simple;
	bh=+PeTeHLHc+8AlXhEQnFbLcDJqr0OWX/LrpmxS/h30Vs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uHPsj+ldUVeHMcV1F2DZY0TzQeBvJ4du/uZLdJcx4mC/Ed7GODahxB0GTghQa80zc/C/3AYXcSEFV5540GB3kKqfrABVYVBHspaDS0oac2jYn+9GJdwpq1p8LNhVcy1A/rsrvRo41zZmCyxhj2orCRgF9pty8dfpkI+dBDPHoDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R30COf0H; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717560320; x=1749096320;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+PeTeHLHc+8AlXhEQnFbLcDJqr0OWX/LrpmxS/h30Vs=;
  b=R30COf0HGi2hx+GerRj2JmG1nzqRlOlJw1dO2hxVCeILArQcfMqNREYG
   rtZj/Io5IaEILhTxQDETw3LL/5GzCMN3izMpIASvmJq0U0ivOgLtBRlhr
   xd3+D6nPrHmUTltwCjiFbPAeice1MWgU8XIwKSAChOptdgmj12tGz80lA
   gONoVP8qIj7j7sKkMhdXA/+yc7gNCpimqj36uTe3QVtdAb2fJowe8zKHx
   /WdNJ12uqZxUSWfPFXszfpTJPKim7hotiTYh6CKmJpCueFfaZaLY5uCXn
   /WmhVnH7mAIyrBPPQDOUhHuvsopd+waRTQWhZc0RUZzErP+Gg7+mm7vOi
   A==;
X-CSE-ConnectionGUID: 2v2V3P4ZR7We3QymE8qTew==
X-CSE-MsgGUID: KCHr8r5vQKuET/ZE17jQLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="11912247"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="11912247"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 21:05:19 -0700
X-CSE-ConnectionGUID: BNE+L1VmQZaKwse8p6sSvA==
X-CSE-MsgGUID: CQ5g283VQi2167mYCT42EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="68270762"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 21:05:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 21:05:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 21:05:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 21:05:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvNk9UiVigBMzs+2DbsGDhlOj5rjNVRaW5YRUoRgi/5RU9+hEsa6hxrJq9Sj3eFpetxb+sbUN7hZhih0oAoqffsblGgHNfeZWkh+uqpo/+HAy8uAt5ZbeI+B1mwQLQraUhC6nOBMo1Ap7Fiua/ZNqkalSzCVuxJAAkQCEhu4QNgSK5rENom4B+0DILIoohTvsM/SYeAlRcjf+am7q5ElQdNshRPK9BL/PFPlWhlS/cXJ7mFmxcLooPIWSk/n/UEWlLW+rTwiaAR6WYjQk+h1fsxEWxEF/uhcjqD2A5DxbqSfYTFNtaVXa1CADSuFcGgwJRe/jvsWnBAplXPmeN5QMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3GlzQoO/093D5XqYNOjpRh8+VgQWDLuWwXjQVnLKrA=;
 b=ZOXHY9QG18q5ocSU/HTa0Bi/oaEwc9T4EJymBimbJ5RLnpd1NxkcpID7Z4UJViDzmeKR5hZJ7oIVXY4dOjI7c8XdyV67/eyVKbgv/TcbR+74Mg12p5z5UgrY8hYObh4FXeTx96z1RtZ8wJ11SNUnzLpsODzIK/5uqF4UaDflYg/1HnD5/8F0b0qkUIpYmNY77V+HVyX1bdhAL6hX0ce0jgWioeeVPwgcS66cXjdLMGjyFx8IDEP+7VzHPXblXTdFd+V4avTjH9CyHoN6AMLPu+IjjRTEgbqQsI3mLBlKs3bMFUcSjJOMQ5cE7ldHIjSqI9h9ac8vFlviH9B/v6/o1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH0PR11MB8214.namprd11.prod.outlook.com (2603:10b6:610:18e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 04:05:15 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7633.018; Wed, 5 Jun 2024
 04:05:15 +0000
Message-ID: <6a5afc74-ecc4-4818-b425-47d843e25735@intel.com>
Date: Wed, 5 Jun 2024 06:05:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethtool: fix the error condition in
 ethtool_get_phy_stats_ethtool()
To: Su Hui <suhui@nfschina.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <nathan@kernel.org>,
	<ndesaulniers@google.com>, <morbo@google.com>, <justinstitt@google.com>
CC: <andrew@lunn.ch>, <ahmed.zaki@intel.com>, <hkallweit1@gmail.com>,
	<justin.chen@broadcom.com>, <jdamato@fastly.com>,
	<gerhard@engleder-embedded.com>, <d-tatianin@yandex-team.ru>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, <kernel-janitors@vger.kernel.org>
References: <20240605034742.921751-1-suhui@nfschina.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240605034742.921751-1-suhui@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH0PR11MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b62539-4ffb-4f16-63f9-08dc8514b427
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2hOZ3JtdCttMHBPS2pZTHAwWjFBdTl3aCs0NHpXZFVybVUxaUk3MUI5MTgv?=
 =?utf-8?B?LzF3dUIrOHhCVXpkbUFXNkpiZDZrUTZjdzBwTmJESFNsQUYybjN2Qm5ydHpL?=
 =?utf-8?B?UEY5aGJ0cHN3NkZCL084QWViditvNk14ajlDZGt4V3VoMFVnR3UwVVM2enBW?=
 =?utf-8?B?VktMaElIZ2FlQ1N4Uko2ejZMTFdvUlljMHdlQUdjbFl4Q095bC81Mm9ZRGFS?=
 =?utf-8?B?cTZVVFhJcml1N0YwWElycksvbFlCRWNETXRLOWdrb21rOTc0OEJZVlNCQzEr?=
 =?utf-8?B?elpQRUduRVNPeFpXMWZ2VG40K050MXBZWHJwaXR1cVA1U1B6aDVmWUdSQWVP?=
 =?utf-8?B?VmJNb2xwQStKSGRiQjgvWjkvbk50eHFwVlJielgybi80b3cxb2ovTHdGRGRt?=
 =?utf-8?B?NjMwNy9SOXZ6QzB4OU1veTZPQ09JZ2Y1K2x0V0c2WjBUb0xFNlFBWjgvNHZD?=
 =?utf-8?B?bVNReVkyU3NkZjVDRkVNa2J0Ti96ZDZTYjJSRWtmVHNkZ1JJYytPMnNoQUZp?=
 =?utf-8?B?Smg2aWJ3VjBtMFoxUGhEdk1RRlprWEYrNXpmcXVHMHVtU3ZncC9kNlVjamxz?=
 =?utf-8?B?aWdSODJJYW9SOEIreFFaamZFTFdxamFNU3c5Z0JQVTVRWVVreXdESTh2YnQ4?=
 =?utf-8?B?dmRVOGtCd1dNZ3RXNHJzbFpteVZlYTc4VTloUklDRldub0d5a1NxRmxJbUxm?=
 =?utf-8?B?andhcVVkZXlZU1lSWE1kdktlMVQzYXFFT0hTZTJPYWRTVEJNU0Y2dnF5ZjA5?=
 =?utf-8?B?NE9lWE9wdnR5aWdGM2k2cFh6K3o0L1FKU2tmWDFXM2dBNFRUYTNudUtyc0FT?=
 =?utf-8?B?Z21sOFJqeEViMDBWMERsZG5WL1d6bjdkMmVva2lQN2FhTE81UldFTWJ3OFpz?=
 =?utf-8?B?RU56M0NLRDB0OGQ5TnYyY1l4ODV5RS9YTmQ1dDFiNUUvU0VlNkJFbjN5NFV6?=
 =?utf-8?B?TUtKbi81OCtjTlFYYTZzQVdaMUFVWkdjVjVaWmxRMEgyZU9aZVFVOVhyZ29u?=
 =?utf-8?B?cTZ6UUIyWm5tdXdmc05NU0tJbDVNTEw1UVdJRFM1Z0I3N0VHQk12VzJiSmNP?=
 =?utf-8?B?UGdKTEVEZWZOZElTMXRQRkxNeUR0SnVLdmErU25pY2NmcyttLy9udVN5OTJp?=
 =?utf-8?B?UXFQUmM3NVh3aE1IMis5ZUJKVmhZVFBlUEUrUVlLc0ViT2hqRFA2ZGZjQVJs?=
 =?utf-8?B?RGdmUGI2N1VkSzNvdFJBUHZ1WXk2dWZldkhxL3NvQjZpRlV6V0NzcmE0NCs2?=
 =?utf-8?B?V0o0Vk5lRjgvSHZBT3pxS2QvalA2YlBTS1A0ekhJWUZDQ0JVYkoxcEtLTW9t?=
 =?utf-8?B?Mm96S2NLZXQxTEVCb0hVSE9hc05qV2Y0NGNTMmdsRmxDNW9iMFZSNEZOQUhQ?=
 =?utf-8?B?WGxyZkgvblNwYXlNemZpbitpSyt6ejRGbkg3bXpxa2NFWU9QRlE5N0h4TTNn?=
 =?utf-8?B?WDZaZVZiOHdPdW5MMVowa3dtdkk2c0F0RzRwRjFJb08wME85WDZCZThoQTds?=
 =?utf-8?B?eVVQM3pjL3hMYmZYS2VMd3R1N1R1eVczZWUrQitIR2M3L3U1VlY2SHppMDEw?=
 =?utf-8?B?UWh0cTIrRXQrTlBtUEJxZFo3cjZiRTJpbDhSdlhsRGdVa1VpZCsvMDZibXZJ?=
 =?utf-8?B?L3IvamdyVFZGOElad1JFbEJrbzM1ZGJiMm4xRVBBcmtxYklsZzNYaFlKdUlB?=
 =?utf-8?B?azJ0aXNqOXZnWVE1WS9sZXhaWE9sOGQ2cS9HZFYzM0FKNHJpWmtGbW13PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnVSL1FUZk5uR014NXdKeGE1V3F6ZWprcVVia25ld09QbE9LV3Erbm1pTjlR?=
 =?utf-8?B?a2ZUVk5SSUZ4T25DS3BLNVRWVDR2QmtrWWk4T0tNYWhBenpZWEF2MzlRN0l4?=
 =?utf-8?B?ZUtXc2V5VVcvZVFyTTlWWFFqUEI2UEFOWXNMeHVPRVlVdzFlaEp5ZFZ6OFZh?=
 =?utf-8?B?ZzNyR1FTNnI1V0RvVGZaaGxoQ2VsSmRkTjFzOFJTcWozbW15WFozWTNoZENj?=
 =?utf-8?B?WWVFaEhEb1Y5UGtFZ3d4eGh6aldQamNrTmFXNFlxeGw0dVRibHVUYitFdlhS?=
 =?utf-8?B?V2YxaWNMZXVNNlBRajFtR2VtUWErOHhpaVBaRnBuVjVWckdSZjlDcE5NcG82?=
 =?utf-8?B?WFRQaDdJWDJKYURvR0lOTmdqU3k0N2cvWjVvVWZZdytXQXJWRVhnWGZnQ0FZ?=
 =?utf-8?B?Y2ZZSHZJRHRpc0NqelpBYlN2eEZCNG83Wi9sWUdHb3hJckJKQ3JXdUFkRDg0?=
 =?utf-8?B?U1BLZkwvcS90QlRxd3Z4NEVVT2RrNExJSUlFVlhTanUwSVNGNUcrczlDNmJj?=
 =?utf-8?B?QjV4aVBtQmpSNmJieUt6anhvUEZYeStKQnhYMWlKOGMxa3QxdzlyR2IvSXFW?=
 =?utf-8?B?dHpReXJwRSs2S0pKQWxUT3JVc0tKSzFNR3drQklkY040eDVQWkFmVzJUc3d3?=
 =?utf-8?B?RXFUeXpNVnFVbTVQSEtpVU1nam1HL3pERHFZY3V3K2FDOThLNFBFRWJlUWxj?=
 =?utf-8?B?UUtVV2ZKNHFEdVZlVVJyY3FrcVo1Z1NNWkpXWHVEZ2VlYURsY3lKdVk0ME44?=
 =?utf-8?B?QVlVUnpsU1RhbGFNZzg1Q0h0bmlGbUxBc0ROV3NtWjlwcG54aER1aGJ6S3Bs?=
 =?utf-8?B?azRnV2VQRmllNklvODFXRE81a2JTaEJiNWFLSlNzUHVFd3I2M1JxVDJUaFRT?=
 =?utf-8?B?S0dSYTFkVXZNd25jN1JXL2twQXYxcVg5ZzhGREdJbUhjMW5SRWsvUWxWeFdQ?=
 =?utf-8?B?YnQ4K2pNejFJRG94NU5venppOWVKdmxKNWZVMFBhdWcxeHlQTndDd3JOV2Rj?=
 =?utf-8?B?OWpTbWc1TVordmZCb0d3NjEyUXljYjVkNDFJTXFFbTF2L0g2bHlmdkgyUUg0?=
 =?utf-8?B?SVhaZTFpaWhZUDk5d0tQaXFjc3l5a1c4OG52VUlzYXVtZVZlSURod3g2OUZl?=
 =?utf-8?B?U01NOGJ3V2xseDFxU2lkSXN3cUJsejVDbW9hNWFad25LL1hkODZJNnNVMFBn?=
 =?utf-8?B?ayttM0F3dXNRZm9UMVZZMDNCOEI5VFJmQ0pJU2dnWTc0cWNkTnVjWXQxQS9X?=
 =?utf-8?B?czNDZWsvRGRFeVppcHUxUkZvMlduQ25rZzJwaXFlMVd2aEVBMmdjbUdIQWNF?=
 =?utf-8?B?eGFrYjNTWFF2cmg3TklkT0VrdGlQV0NOaTNiTmY2SkZFN0g0c2pyTnZGUWtM?=
 =?utf-8?B?MU11K21GVE1kRzdYOVUxaUFVVVNtR1duOXRiYlN1V2Q5U3poMW9BcGl0L1du?=
 =?utf-8?B?ckxjWWkrajV0aFVwTXJ5SVhYRHhOMkxLelFEaFd6dmZjT0s5a01EVWhXZG9o?=
 =?utf-8?B?Y3VONTN1QVRXZUNkZ0FBWHBQRzhOS3dwZGVnV1dUN0tWYTd2aVlGWjhvRE1Y?=
 =?utf-8?B?cmVucERCMTN3MzZVYlNhNDI5WXRvT1d2MlpGQWNYQ1VreXJxdHJyM3JGTzJL?=
 =?utf-8?B?d0JFTG9MbGVEWTZ4bEw1dE9zaWs4eENvQW1JK3dOaEJRV1BxSEVMK1lnSlNR?=
 =?utf-8?B?RCtucVl2ckxlSm41enc4SldnUS9vcWUxNWxGYmtvQ1JweVBFUW9rc2I3M3Ar?=
 =?utf-8?B?VmpCVVJIK2E0bHNjdUpMbWJheUtZaFJ4WjN0M28vbmV4V1h4WUIyQnpqKy9N?=
 =?utf-8?B?NE05MlVDOThxUXA5dllmZ2FwVi9YNW5jOTUySzd3akJNTUdNT0FaTng1VzR2?=
 =?utf-8?B?Zm9hNmdsYkd3U2NxaHdicWpOd3pNOWVrWVJqNXV2TXk2V1hiZG5MdlAyZHFR?=
 =?utf-8?B?YzBncXlwaWlvQ3JGT2VDM3V0dkJZR1FyU0VPMUpqTnlxR0gzc0NoZDVIQW4v?=
 =?utf-8?B?ZCtCbXppTC9BNGVaQ1E4TkR0c1hNMHpEZ0kwdnVXb3c1NzcwZHdRdkczbWpZ?=
 =?utf-8?B?UTZFL016dFZmUWNsZzY0dm5ZQmY3dFNXWHJwM3B1N0hGUVFjSHlRbXJQUlZz?=
 =?utf-8?B?cVFMNWk5bEtVek1rVk92R0xEYkFqSERuUXl1aWJ2WUFCZlRlSnZxdzl0QUxP?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b62539-4ffb-4f16-63f9-08dc8514b427
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 04:05:14.9909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYSGF+Zy0qiEJLvWYb7eKU90Yqz6SeWPIu61/x/p73rMh0pSvoVPTTMt05Sn51vQvwl0IACHsDLvoyD2W8uJbQJL1/j3MMMXP5Z/1GhH2RY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8214
X-OriginatorOrg: intel.com

On 6/5/24 05:47, Su Hui wrote:
> Clang static checker (scan-build) warning:
> net/ethtool/ioctl.c:line 2233, column 2
> Called function pointer is null (null dereference).
> 
> Return '-EOPNOTSUPP' when 'ops->get_ethtool_phy_stats' is NULL to fix
> this typo error.
> 
> Fixes: 201ed315f967 ("net/ethtool/ioctl: split ethtool_get_phy_stats into multiple helpers")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>   net/ethtool/ioctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 5a55270aa86e..e645d751a5e8 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -2220,7 +2220,7 @@ static int ethtool_get_phy_stats_ethtool(struct net_device *dev,
>   	const struct ethtool_ops *ops = dev->ethtool_ops;
>   	int n_stats, ret;
>   
> -	if (!ops || !ops->get_sset_count || ops->get_ethtool_phy_stats)
> +	if (!ops || !ops->get_sset_count || !ops->get_ethtool_phy_stats)
>   		return -EOPNOTSUPP;
>   
>   	n_stats = ops->get_sset_count(dev, ETH_SS_PHY_STATS);

Thank you,
both the change and provided Fixes tag are correct.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

