Return-Path: <netdev+bounces-94156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF3A8BE745
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7061F22222
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B7416192D;
	Tue,  7 May 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2e/pfKj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D95160787;
	Tue,  7 May 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095229; cv=fail; b=uvu/BHrp5iw57ZvyxFy6Y8UP2S13Kw4ADDl9ZrE7eMQlrIT5piRt167sNphwvUb6OAYSsqS95beKIP6LwHTOeNKKz+ci1XP8PtDqGELWMtSPoZZ+kgRzV7POzi+tyGZCeVoZX6GIvzsDfc4+YK6fT+8dOF9X7gfSYNsX6ioeT8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095229; c=relaxed/simple;
	bh=WgWIFsOprI6NKq4suNOwjZtfZR8wAnV4Y9fX+XxhEdU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=roYRcZ9ucdjFWW9nLfpe7G+MGkx5B/okedL3ZBGOxOaJuZStL2raZSdMm77mTqXT2FXXYpbjd9NFW2aTULfd2oWx4MV0Fi3XOv3nfPqVHPqfy5ueOXtDuthBIgHqCXhOaUAEXPjSSsFF2TKMxGWBJgR8IjKM+6ak04kIItHDimU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2e/pfKj; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715095227; x=1746631227;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WgWIFsOprI6NKq4suNOwjZtfZR8wAnV4Y9fX+XxhEdU=;
  b=P2e/pfKj2EF+XhXCxax0jdSDptelJPl60YmAjJICRfq8gGxs6ihKsP+u
   3g68u4T5mB2r2lk/S0P7xeEitLAy7Vs+Yk81JEXIsLLH0GHeXltrlbnDJ
   EL4mv0lVjtb231LSaEsMghM47hSWtk4CsgWwQ6vtUbzzHLNN/OjlwIJ6m
   vBn8mDa5x5hzxzjqb1eOug6DjJG8EQbw8Z0MpxkkAoV6lyxQ1zhXC9ntJ
   gtVAkoqFDsUSd9lg0uVyYGP5Iph0jgQjryzGBVqfef6wJ1i9Glqn06LyW
   EB7WWtaMVwiHoyUb3WoWmKp3igu3QzO9vBjxLhVhvHe24vjjgaR8gAeqD
   Q==;
X-CSE-ConnectionGUID: jdVPJGElTMqTk0s3iispRw==
X-CSE-MsgGUID: 1NiixP8qRgOj/6s3XHcAFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11411604"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="11411604"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 08:20:26 -0700
X-CSE-ConnectionGUID: Iu9VFX6MS8qv+6DU8ZlL/A==
X-CSE-MsgGUID: vdfQnKrBRMKbMFouc5zKhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="28537513"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 08:20:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 08:20:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 08:20:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 08:20:25 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 08:20:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwpgdfjYQEWSEupQsfq83QHbrMnpN9bqNOt7Xt9uMN0vkQODOgU2ARm5J28YbqKBVb1KVU/RW3btijBDHz80v2KtsXhyzDCov0sbeidO23OQX6R3p3fQYecK57eMF6t4lX3Di/0FHX0K2HDLdGvwz2gJw3jQYGbSQjpUkfHWkkUrVFukBO1TqBitPvcaoLYn5WZrrZ3ml2oNxbYjHzE5CNUhLgZSAPcI2IVVLr/zfZw1IxWmFNkfoaqoVlgtyZbgliZ7Q4Wj0A6nDn9uWIX9SY8SPnUNPvjdeP+yXdl7yhjfh1FBgXFsdfAEzHBC0AEK3qihcaeSm1LdyBAHHbox0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7ZytfFiehPgqhejVtBE1m251od3P1Jr1Z/85dXmPRc=;
 b=dT2zA6w0ZDmhwKydlDlcS1k47bEsR4dipk5wqSV/MjCWj6z4DEGPT9szNhTZGTnKQw0Zi+cEMqLVdp1G+J1s1mb2frfijtjEXwEQnCqBaVOjNd8A+kVmLZ2aURB+H1NCUb8kOu3TSAFjIXQvssl43dqAygCBUeYXjXg87S5cA7XEG1RWKalGLHAEYa6h0Er2pWWE3x4sEY2HNSlTsd3yPdt3rVk3sdJdGrkk+kdDBizrg3bdgo7akYJQMyTJRlBcDdN9qx6BrAO4e+j1gn/ALf5kngGSYPewsVrkJu26s7cqSvf2ouQ+M2SbR3jP71wRnkEBpqrly53f1IbRtBBe9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 15:20:22 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:20:22 +0000
Message-ID: <5eaeb35e-2740-4b47-ae42-75eadb6f0be5@intel.com>
Date: Tue, 7 May 2024 17:20:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 net 1/7] net: hns3: using user configure after hardware
 reset
Content-Language: en-US
To: Jijie Shao <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jiri@resnulli.us>,
	<horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240507134224.2646246-1-shaojijie@huawei.com>
 <20240507134224.2646246-2-shaojijie@huawei.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240507134224.2646246-2-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:303:6b::27) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e05bfe-33ca-4f09-7237-08dc6ea936a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1lqaFJjUFo4Q1A1MW5SS3ZTQmNQS0pLNHRJTWtKRCttdCszbVNSTE9vemo3?=
 =?utf-8?B?cEMzNkUzaW42NVlyRlM5ZklySmpYNGdOVWU0dFkxeExnZkNCZ2pneExIT1lR?=
 =?utf-8?B?Y3VMLzZmeHB6bEVmcVZ6emQrZEphcmhxUC9qWE9yRnUxaS9nY2RtZjFVMndO?=
 =?utf-8?B?cEkwZ2s2Z0FvQWNOd0lLcVkzUDlXZVJsbzllWFBUQWVCRG02VkVPV0hHZjBC?=
 =?utf-8?B?YmlnYW5BYnVLNUlSWnpWQkp3TzZGYkZoTkVlZStBbHIva2FjeVFwQ3BNUlYz?=
 =?utf-8?B?UzhxdmNOUnNJdnVRT0ZHTFlPWHd2b2kzOWFndG80Vk95VXV3YlptNEk2RnVv?=
 =?utf-8?B?SXZTVlE3Mkx1d0NGMGx2azA2d3o0eWJjOFRIM1FLdFVlZ2h5QWw4NjRlMEFs?=
 =?utf-8?B?a21vVHM5anJoRzcwYmt4b2l3cG44enFsV214bmE3RFU4SzhKZXAxalZzZXpX?=
 =?utf-8?B?WWdBbWxVZ3hEd3R6MUhsaHRXelg0VzZpa2QxR0lESC93Y2h6TmpoeXhuMU1r?=
 =?utf-8?B?TzFyL29SVzRSNnVvVzdFNFFCWkpCVTFvRTNFMkFTdG1jZXliamZ1Y3JHVmNO?=
 =?utf-8?B?YXBra2lha21ibzcvUGpaSW1NZnNsNXFUYittdG95czNrZHpQMzdmZmdwWldP?=
 =?utf-8?B?MS9tcTBkNjhiWGVRRHR1d25IeWZQNjJMRlBTeFpSdWlZR2VpWnFXK0hDVU5J?=
 =?utf-8?B?M3E0b0dXc3FOWUJZZDVPOUdvdXJmRzVpMHYwYjlTaCtOVzFnTTBGZVlEd25D?=
 =?utf-8?B?MkNuVWVkSXRJU0hROXBRZTc0bElXM0N1RTZHS2RMSDRlQmhLS3llcElXSWVX?=
 =?utf-8?B?RmhHbGFrd2ZKaGJwWk8xKy8rYllmQTNEOXVrUnpza2ZjZ0dWTmJwbTBTVXZ2?=
 =?utf-8?B?ZWFxdkt1VEtmMkhtQ0lPQlBwbERzcWpHcGRETTZHc2hLbzZYKzFtMmVvVnMx?=
 =?utf-8?B?VS9ZeHVZcVdCLzBoSTZrOWhKVnBQZ0FIUk1hczBPcUVmQm1Sb0MyRnhuakhB?=
 =?utf-8?B?NmpXZms0bjA0eVVid1RISCtiU3Iydy9HNmo0bEl5aFRLZklVYlNRR0oxVzVG?=
 =?utf-8?B?dHIrV3NYSFMvZW5yK0s3ZnJnRDBPYXhoclIvVWxKNU5USjIvenozNTJIellW?=
 =?utf-8?B?MGNkVzVjV2NFVm4zeDgrVUYrd3lCQVZUMEFaN2lPK2dBVnVxTkpOUEpFQjQv?=
 =?utf-8?B?NWRVNzVQdGxVaU0vYmxBcndEdnlTYldoZkM2RU45ZXJGUi9sLytWWWFhb3VT?=
 =?utf-8?B?bllKVzBqdTBGT0NmeUJUN2VOckdKQkNnVEdVYVppdCtjejdGOEJGcXhGUXZQ?=
 =?utf-8?B?TnJIL2lGWTFSYWlwS1YvL2FpeHBOdGNPREJHU2hiSzByMHc3QlY3WHpPcStY?=
 =?utf-8?B?dTE0OVllTkZUV1NKZ1JhRUlLM0cwdi9XL1BHSEEzYTRLdFFUMlBOTjQ4UWtL?=
 =?utf-8?B?dWhDVUNOaHNMUncxOWtrZEhlSS9UMVdjbVhNN2ZEUzFQT3JKRUViclI5cThF?=
 =?utf-8?B?Wi9mUU9wRzFqNVBZdlUvWlU5MldFYXowTFNrdzl5QUFBOElQeElTQ2RRUVhL?=
 =?utf-8?B?amlUWVh1SkQ3V1l2VjNzSmJuVWRIeDNPc0x4VDN5UHBaQS9uYjg4Nlc3bjRH?=
 =?utf-8?B?VEd0L210QmFONTVmSHJUNTJUSlU1WEZtMFljYkw2QjNyR3RYem13NmlSNytB?=
 =?utf-8?B?WjlWVjkzNkJHRG1ianhoWXhBN3pnc1NiMnk3YXUyMVVZcEp5M0NJVmh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlowSUdzTm90SXBWQnNVM1dBWTY1amVROXFQSDZRTlJIbUJQMzdRTGRlTWMy?=
 =?utf-8?B?S2ZsMWQ5dFdzUHd3RSt3Mzd2MVplTGZPd3B5RUtMS2N1eE8zOU1wUmdHRThH?=
 =?utf-8?B?YmZtUmc2eURENndQS213ZU11R2ozZGJtbmkvQkFhc3llK3JlSUVrS3hzdTRu?=
 =?utf-8?B?cXNMTm92YjVlQVIrZkNKVDhpOGlic0V6MDFsenRsdEZiaHNpYUl4QVJwVE92?=
 =?utf-8?B?RGMyNGRSUVhWNkEwNlYyd1NmWUpXZVcvMmh5OWhZUlVCVlJvajJOenFNYUJl?=
 =?utf-8?B?MVJ4TE5qL0ZYUVBJdDFyZE5EelE1QnRqNWU1SjZKTnA2cVB4UlhXN2F1d0Qr?=
 =?utf-8?B?OVRjbGRsbURVTFdtZXcxZEVQT29MS3p4YVBmekJOWS9yVDR6ZktKNHFOQVJD?=
 =?utf-8?B?cHg2MnpRbUNtYmcvMDhNQzNrL1IzY1dNcjNHT2hzN3l2S1NMS3VkWlAyRTBC?=
 =?utf-8?B?Y3Y4TGxHc3hiRDJ3UEJZZnlFS2lPTDlmd0N0OHA5SEpaSnVPc3U3V3pQLzFZ?=
 =?utf-8?B?WG9ZTXpWV3A4eWFFeStreTRlVDNmNER4QjVMblNpcVNRbDE3aDZvcTJkSjZu?=
 =?utf-8?B?aEZuSk43ZVdBYmZNVGJQY3dNcFdtY2lFUEhxZG1TR0swZFFJOUlUS2hGVWwz?=
 =?utf-8?B?Tk5hTmJUUWJEN1JIalNkeWtzUmpGa2prL2lRK2JRSTIvejZsUEh0RVhQYXA4?=
 =?utf-8?B?YzZDa3F2dVJhRnJiMmVTYVRIODk1NVAxUnR0UUVHanFKMFp4Z1pMUnNuYnlE?=
 =?utf-8?B?S3hKWWR0ZkZpYmhxaVFIdldjNHZWTlNuZWpMRTM1MGFpWEVPaWtUUDAreGZS?=
 =?utf-8?B?K1FxNE5iNkFreVNpRTlSYzRzNEN1My9OU1JDS3B1amp2MzJ3SWNhZlprYWwr?=
 =?utf-8?B?UE43MDA2dStoQmRVNDJFT2c5VTdTNk1FcEFrRy9NNFZhY3ZSQlM5MWR0STIx?=
 =?utf-8?B?WWd5T0gzeWZkcFQ2YUoxZ0FWSG80Wlc1QlpnZ1pSbUJQRGYzbCsxT0k2dUxZ?=
 =?utf-8?B?NDBLTzdZRTRzU3VrZ2x0c25rL21BSUhMVk04NndIMkVORXNRRVZHbWJ2Ykw5?=
 =?utf-8?B?dTlDcXNNY2l3MUNaWmdEVy9ESDZKTjhrdDJuTU56QjkwY3NuUnBFQSsxaVdr?=
 =?utf-8?B?MWt1RUsrd3pJdExkaXNEN00xWmpBM0ZBYkMzSWpkR2M5akdrd1Z0eDFsWHh1?=
 =?utf-8?B?N1NrZXZUN0ZBK0czY0J4QW1GL0xMa1JSelFoY01Qdm95TC8rTTVPSktFSmNG?=
 =?utf-8?B?SXg0Z281Z01SV094QmFlZGtOL2p0WlFGMWJCR1gzT2s5UGdNaW5MZzVzNUo3?=
 =?utf-8?B?RUxLcTEwYnpMOHNkZjF5cUV2WTJORGZNTVFXN3pheS9nUTlCeVBVQVNCREpO?=
 =?utf-8?B?UnR4ZGMzQXhzR0JxMjluOU5BemhadkEvYkVUZ3BzMzBHNjI1WmVuY1FwM3hy?=
 =?utf-8?B?QnFoL29ZYVBud3dLTjB0cy8xaTB3V0hPU0l3eFRaWTJWektRUGlrT2MzeHBp?=
 =?utf-8?B?clhVNzRGb3ZTSnNVRXo0dklSRlRhVy9XTXlrSGYzL1R5NVZoYmhJZlhEeDVT?=
 =?utf-8?B?MUhlcERTZVo0c2gwLzFzUzFia3cxOXFIRk1UbVh6d1U2a0NKMit3ZC9DN1R0?=
 =?utf-8?B?TklTRldualJET0NjMStoaC94RFIzWWVSNUZMcUFkSFNuSmdRT3ViSGJ2WWxm?=
 =?utf-8?B?TlU4VFdkQUlVOWFiU0xGN1RxSHFyOExNYzhWa2hQcXdzNjVIOFE0SzJKWUgy?=
 =?utf-8?B?bGV0NHNLQ3FDWEE1b05lTStxRURnUXhFN0w5OTl4RDBBdzE3Zjl0WW0xUVJv?=
 =?utf-8?B?eUNoaWd3NDY0UmN5c2hBUnF1bzM1OUVEQVkzLzB5Tmovb2VhcHNoRjBiYjYz?=
 =?utf-8?B?am5HMlNkQmNtV0RRaEFMY212bUZxR210c1ZHS1BoRmhOQ3cwQTBKZWpXRXdT?=
 =?utf-8?B?SDV3d1VTODFvbEQyNDdqSVNocGNuaFh4ekZ4ay9mYlk1TzFvWGhVRi9nMFlo?=
 =?utf-8?B?Z2FZTlFXZzdGNVVZNnlHaUdaNEFST043LytPWHVOalpxTEIyeVJzYVFJY21w?=
 =?utf-8?B?bndxRlgwdDh0UjRnU0F4Z2J3RHlUVTMrd3RpQ25GMFMvc3RhQ2Y1MEdLeU5S?=
 =?utf-8?B?dXU0TmVsZkc5dnZKMUZKN1ZPcS9WVWUyREFRMEhScXJ3SFhHRmx5ZDZVaGNz?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e05bfe-33ca-4f09-7237-08dc6ea936a2
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:20:22.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89nCVFZs3XtnvRswh0e/DzoeG10i0NvO0bW5tjutr51nDhuSwbALlXQ0s3uVoVGz+n7gTbXv7SoSnPTXaYoXDUyJ6GK3e8v275rU40cNn9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7177
X-OriginatorOrg: intel.com

On 5/7/24 15:42, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> When a reset occurring, it's supposed to recover user's configuration.
> Currently, the port info(speed, duplex and autoneg) is stored in hclge_mac
> and will be scheduled updated. Consider the case that reset was happened
> consecutively. During the first reset, the port info is configured with
> a temporary value cause the PHY is reset and looking for best link config.
> Second reset start and use pervious configuration which is not the user's.

nit: for future submissions please run your commit messages through
spellchecker

> The specific process is as follows:
> 
> +------+               +----+                +----+
> | USER |               | PF |                | HW |
> +---+--+               +-+--+                +-+--+
>      |  ethtool --reset   |                     |
>      +------------------->|    reset command    |
>      |  ethtool --reset   +-------------------->|
>      +------------------->|                     +---+
>      |                    +---+                 |   |
>      |                    |   |reset currently  |   | HW RESET
>      |                    |   |and wait to do   |   |
>      |                    |<--+                 |   |
>      |                    | send pervious cfg   |<--+
>      |                    | (1000M FULL AN_ON)  |
>      |                    +-------------------->|
>      |                    | read cfg(time task) |
>      |                    | (10M HALF AN_OFF)   +---+
>      |                    |<--------------------+   | cfg take effect
>      |                    |    reset command    |<--+
>      |                    +-------------------->|
>      |                    |                     +---+
>      |                    | send pervious cfg   |   | HW RESET
>      |                    | (10M HALF AN_OFF)   |<--+
>      |                    +-------------------->|
>      |                    | read cfg(time task) |
>      |                    |  (10M HALF AN_OFF)  +---+
>      |                    |<--------------------+   | cfg take effect
>      |                    |                     |   |
>      |                    | read cfg(time task) |<--+
>      |                    |  (10M HALF AN_OFF)  |
>      |                    |<--------------------+
>      |                    |                     |
>      v                    v                     v
> 
> To avoid aboved situation, this patch introduced req_speed, req_duplex,
> req_autoneg to store user's configuration and it only be used after
> hardware reset and to recover user's configuration
> 
> Fixes: f5f2b3e4dcc0 ("net: hns3: add support for imp-controlled PHYs")
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>   .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 15 +++++++++------
>   .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h   |  3 +++
>   2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index ff6a2ed23ddb..8043f1795dc7 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -1537,6 +1537,9 @@ static int hclge_configure(struct hclge_dev *hdev)
>   			cfg.default_speed, ret);
>   		return ret;
>   	}
> +	hdev->hw.mac.req_speed = hdev->hw.mac.speed;
> +	hdev->hw.mac.req_autoneg = AUTONEG_ENABLE;
> +	hdev->hw.mac.req_duplex = DUPLEX_FULL;
>   
>   	hclge_parse_link_mode(hdev, cfg.speed_ability);
>   
> @@ -3342,9 +3345,9 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
>   		return ret;
>   	}
>   
> -	hdev->hw.mac.autoneg = cmd->base.autoneg;
> -	hdev->hw.mac.speed = cmd->base.speed;
> -	hdev->hw.mac.duplex = cmd->base.duplex;
> +	hdev->hw.mac.req_autoneg = cmd->base.autoneg;
> +	hdev->hw.mac.req_speed = cmd->base.speed;
> +	hdev->hw.mac.req_duplex = cmd->base.duplex;
>   	linkmode_copy(hdev->hw.mac.advertising, cmd->link_modes.advertising);
>   
>   	return 0;
> @@ -3377,9 +3380,9 @@ static int hclge_tp_port_init(struct hclge_dev *hdev)
>   	if (!hnae3_dev_phy_imp_supported(hdev))
>   		return 0;
>   
> -	cmd.base.autoneg = hdev->hw.mac.autoneg;
> -	cmd.base.speed = hdev->hw.mac.speed;
> -	cmd.base.duplex = hdev->hw.mac.duplex;
> +	cmd.base.autoneg = hdev->hw.mac.req_autoneg;
> +	cmd.base.speed = hdev->hw.mac.req_speed;
> +	cmd.base.duplex = hdev->hw.mac.req_duplex;
>   	linkmode_copy(cmd.link_modes.advertising, hdev->hw.mac.advertising);
>   
>   	return hclge_set_phy_link_ksettings(&hdev->vport->nic, &cmd);
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
> index e821dd2f1528..e3c69be8256f 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
> @@ -279,11 +279,14 @@ struct hclge_mac {
>   	u8 media_type;	/* port media type, e.g. fibre/copper/backplane */
>   	u8 mac_addr[ETH_ALEN];
>   	u8 autoneg;
> +	u8 req_autoneg;
>   	u8 duplex;
> +	u8 req_duplex;
>   	u8 support_autoneg;
>   	u8 speed_type;	/* 0: sfp speed, 1: active speed */
>   	u8 lane_num;
>   	u32 speed;
> +	u32 req_speed;
>   	u32 max_speed;
>   	u32 speed_ability; /* speed ability supported by current media */
>   	u32 module_type; /* sub media type, e.g. kr/cr/sr/lr */

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

