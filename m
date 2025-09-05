Return-Path: <netdev+bounces-220353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E91B45877
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 15:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F53D5A8215
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A501CBEAA;
	Fri,  5 Sep 2025 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R53xjVxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5580B19CCEC;
	Fri,  5 Sep 2025 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077691; cv=fail; b=VTdXkpsm3T5rtTCwZI1TrTy/2uDAfFyPmJgjJLe5oPNZrKUii+Hev3i6eDecKMm0R5ENYr4kEovyqYMZmC0+C+DD5Z6oQRf25v2L6K3ZLFwdDeAZ0zGqEpRLWB6GeAb/VHVUHdsEnCed7MKDsZVtfeQaKn5EcLXaXPWYiBqrpmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077691; c=relaxed/simple;
	bh=1X4OOixR/5TQ9SitEefCndzN+8eEFWgVWcpMdm7DQrE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rHnC7tPGnuu0sp9F3K/cq9vD25BUo5SWCVgMv4ecmhcfKnnppLAsDC5C8ETYw5/65tZJVfOmMBFdI+N4awXTvu43dgcOFuvRF9rvNWMlKZLfG81AleSNuH3Ikg6BKhQ+y0X4nw+edTLC0l2iJ8FE6I84HheA0OHPM1n3ari4GLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R53xjVxZ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757077690; x=1788613690;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1X4OOixR/5TQ9SitEefCndzN+8eEFWgVWcpMdm7DQrE=;
  b=R53xjVxZHaI6RGEMHfnB4ui7EoPLd37xmkp7YLCWYZU1FFevUQEqKfmq
   TVBWQ6AIGFy9gtHVOzkMAQJ+0WxZeqg69Z2Orf9ST+R7QzPeU4s3LJLau
   5w2l4NXWNSlRreTJfZT6AKPQjCPYJ8+eMbNNqcKclARokhTDNyH0UxgF1
   ylAU1jIdetpTb8VcBEHDVmRworFoOTTc97QQzeTwDuWbNXX87YxBLlR/D
   N6CAm8Fhs9ouXbwCuR/nEIc+Mx++Nt7dbslHdciFiYQUCnsw9qx2PVCib
   LPlw1v285dIXj15WkA3gfrJwyhFdyXICXTz7QB02A/u7jPHDgeupI8jZ5
   Q==;
X-CSE-ConnectionGUID: Wbio9QnXRIuGWBkXKrmppQ==
X-CSE-MsgGUID: f30nRaUlQt2VBmeVCVORhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82020869"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82020869"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 06:08:09 -0700
X-CSE-ConnectionGUID: 2QGQTb3XRYOnlmzCXWXrLg==
X-CSE-MsgGUID: pqAdck/hSJiuApCM9NEEsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="203088469"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 06:08:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 06:08:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 06:08:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.40)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 06:08:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FphWGaWKXszJqgbHxvbz5fzqE7YL+Zvbo56tdQ6L2F0xV0W+qGFJ+BMmfQzwHRyb8sHgLhLwQd+kydBsM6uwOWP5+x5wzobXQtg8tJHbJFJy4vWt5MUkFis+vyvAwAeFo3oUgKvYZXu6rnIR0MnWUAvinVCBGVgtCtGOLmAl00bIXWfpcKcRravmaCZHhGsuqopzj7U4sPBznUt7mrVW0nhxp/rlNyZ9x3cQkOglVsvBRXekyrdhmTSRK65/2fHw/fHNXQG4pHPkFyIDEGnB17SsgBcmU4HeDE35WNXV5zzzHtFej9yDqYf9zHxUpWW5KOCijLx2fkFx180tUwsrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUZ6F38lpe3ZPc9PWkFs9rn2+Rtfp96Y0/7XXhhP3kY=;
 b=VfArdwIuJScZmi1gEZZR6ZlN6nZ5YQFlgmbxobj4K/zqChxFs+2hNtxbNJsrlsURs9uvi3Rbuxckp5YUYYfODz9uTRUxPYAX6r9sHi6mqBDIPFVh3Gxpk5SXMnwyDN8mMbFx3E6SbtD8D1k20DYSQ1JNyK1aB4xaI4Ajtu7sR9C9CefER1WWsVTvox2/VuFLA6Ls1wIkiD8AIfs3En73yTRzKd51WjBd1EPvCPDQjV+ks308hhyRRbpksJL/R8M4N9Crrn1uwNBuu8g2ZhFOs0Q45LppX60pRXc9R1pDsfKYOH7x+/6qiY++qaADhRJdPQYAXRMEMAEBKeF7sAg6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 13:08:00 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 13:08:00 +0000
Message-ID: <b5be0b7d-35e4-43ca-85f6-fa17c139edba@intel.com>
Date: Fri, 5 Sep 2025 15:07:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/5] dpll: zl3073x: Add support for devlink
 flash
To: Ivan Vecera <ivecera@redhat.com>
CC: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Michal Schmidt <mschmidt@redhat.com>, "Petr
 Oros" <poros@redhat.com>
References: <20250903100900.8470-1-ivecera@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250903100900.8470-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::23) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ0PR11MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9dcfc3-92f2-4862-5089-08ddec7d3d5d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnJ2MUZoajF0UWw1SFZEemJLbkxtckNQSmpSWkQ2QUlNZjRMVjFUdkFkd1Z1?=
 =?utf-8?B?VUhVSUJpcXQ0azJ0aERnQi9yY2lUNThVZzdRY2dTSnF4cmYySjZBbGpwQ2xN?=
 =?utf-8?B?dENsdWM1OGgxTExDdk9YeStvTVA2ZUNySVd4czFyVnZ0OUR1QTdma3hTQ0RL?=
 =?utf-8?B?amtpajc0RlpPQ3YveUdWZVhxU25meEpiRS92ZmRieEN0UHUyWlloS28zTDJG?=
 =?utf-8?B?LzRTRkM2Y0g0NXRwRlFIdWNCbTlBYUVsTTA3ckZPMlR0dFh3WCtOYkE3b1gr?=
 =?utf-8?B?Uy9wQUVld0QrUHhUdnNUTTFnWStkbE5ubTkrYStNeGJzRDB0MTJkZE9XRHk4?=
 =?utf-8?B?RFgzeUNVbFhkSDZMT2J5OHFzQmpTMlJxVHRubFg2UURXWW9XMTJNTTJ4ci81?=
 =?utf-8?B?REQvVlE5NzAxYjgxcFIxdXBZU0doWEV6U0F6eVFGOHE3bEdIVzZZd1BTc1pG?=
 =?utf-8?B?emVtWEt6bnU2cU9LT2xZbGhlUzExcmIvNkFTSnp5OEEwZk5FaGM2WDdPdSt6?=
 =?utf-8?B?OTV3SWh1WjdlQk9PNXJqS3Q0OFdZcnF4QmgrQmhzWlpPSmNhNCtSYnduUDZN?=
 =?utf-8?B?Ym9ucXFlMlJNZUJzSzJBQ0REaFpKT2hBMEN4R1RrdEhoTlRWM3Vha1FmUG1X?=
 =?utf-8?B?Tmwwcno0NktBY0NIbThuQ1ZaK2l1bXUrcG45b2ZCL3JPdG1NODZYOGRrdDM3?=
 =?utf-8?B?UUtLSER3SkpsMzFSckdpWnBLODNDQkNZdXMycmJwMXJnVkQvZVlMRm5Gdm9s?=
 =?utf-8?B?VjNpaUhZYzVRZG51NXhHTjB5SzZsRmgxQk1YRTRyNlpUUVNyeFJDV2JhYkxP?=
 =?utf-8?B?Ujg5UE0yUFMxVFdTcGdhaDByT09mUFJoN1NzeGowWkh2MEJKK1NuNW5Wc2lN?=
 =?utf-8?B?OFhYOGorQVd2SkNOWndCbFpQdWpDd1dmUXhVUmZ6U3EyNytJa25aUEZIcmw3?=
 =?utf-8?B?VE9RYlFrcnhCdm1vMXd2YWpjc3hNTHgxbDBLOGlXblc2YW0vdkdVUCsxMHk4?=
 =?utf-8?B?aFk2bGpTU1FUS1pNSGM4alJ0MnNxcHdmdFRrSldMck96eDU2dS80MWxiMWRY?=
 =?utf-8?B?eklEQ1JMcWFsNzMxTVkwT3M1YllaT0tROXFGcXNLQU5HV3lVS1UvSUkzTW8v?=
 =?utf-8?B?ellhQi9ER01ReS9VNTBGSGtwZ1RtOWV0MEtDZU00cVE4QVlXdkF4T2lzZGFW?=
 =?utf-8?B?QTNmWm1lL0FvVksyc2NiQVdNamh4VGxESm5LK2lDN3U4NU5kWng1dmdFa1NW?=
 =?utf-8?B?TlVTa2daRGVDYlA3Mm10V1o1RnZqVHJLa082dThGSVNEVnVYbW9wdGZtQXRt?=
 =?utf-8?B?TmVEUWZqZ21DK0pPaU40eHoweVdFNWtQUTN4bVFORW5YSGhQVXkrOEtOYS85?=
 =?utf-8?B?UzFZZXM5Vkh2VlZuNzZXS0Vnc3d4NTFPL2h1SU8yWHQ0bEs1UlgvNVdhYUN2?=
 =?utf-8?B?VHJYZFcyaHJuUjZmZ3JVYVFsTG1BSS9UODZIcStGdnVUMmV4OG96L0JVNUdC?=
 =?utf-8?B?aDBlVy85aG0vTHNIT28rVmV0aUlZWmU1QU5pTVBEeTNvSlpKWVB5RkRjcnJH?=
 =?utf-8?B?NFRkL3pMOWNrZzZKK3BUZjNvRUdiRktxanJUN2ZYNGt5dUpWUHphNHZpSm9u?=
 =?utf-8?B?NHh3ay9QeXFJdlZoZEc2Z2x0UWpwcEpndTl1ZVlYTDVYZEd4L3FLOVh1Lzdv?=
 =?utf-8?B?MTlsTVRnRVV6cnhQQ1oyR3ZCVVg0MmF3S0ttSm9VczJuTFRzejQzcEZlTm1D?=
 =?utf-8?B?K0FjK1lBY2FzUFgwaDJjY0pZbGVMQStrTEEyZ2dBRVhkWkxJSkZpMGs3eUQx?=
 =?utf-8?B?N2VtSVlLWE45NzJQa3hvcHZ4VGxuUngzNERod1NieDRKY3dzQmJONjNUaTBt?=
 =?utf-8?B?R3lvVEJ1WlBBZFZJVEMrYlZ5MkFQYW5GTmxnazFhMHZhQW1oUmY3NStMWnpT?=
 =?utf-8?Q?a85/HPooKXY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnlsMkhWN1lhWC9iY29KRS8yWkhPaXB1cDNRdm5wYXhOS2s5RkhsRzBRQkdI?=
 =?utf-8?B?WmhrbFVuczZnVFpTNkxPMGFzUXR2R2JQR3ozTFVJQTZZTThEVVZUZ2FaeVNI?=
 =?utf-8?B?STMvbyt4enpnUm9JekVEOFllTFBKZFE5NWtkZC94OWgya1ZmS2tUZ2w1V0p4?=
 =?utf-8?B?UFJYbjhqckZ1SFNNSjJwWm1MdUllc3Y3TkxGZUdWL1RlcUY1b296NFMzbllV?=
 =?utf-8?B?WC9QQTUxSkxxTVRJWGRpd1c4SnN1ZytqOHVZb2tiZWdZRWpKTXBLVzFQekxS?=
 =?utf-8?B?aURTNWhkK0M1V2o2UHQvSUVxTGVONDR1bXBabUtoQ3Z3TVNVcWFVU3Fmb1J5?=
 =?utf-8?B?dCt0THJwaW9WZnVBZmx6enV1dTVuUVVlejBjVlRKakV6WVdaV1VoSGdjUDVu?=
 =?utf-8?B?bHF4NE5WTDhVY003Y056Uzg3VTlHNkNxNzZOQU43NWxpbHhiS2hEaHJYUDVP?=
 =?utf-8?B?UkFsaGVNYjUzSzhyR0llaHg1ako2ZjdEYWNNSWE4SmZZdmVZZ2JEdE5WWENh?=
 =?utf-8?B?UG9QVEE2T2V1R0liWGJ0OU9nenVVZmc4eEZObDRJMzAvYUVyNUcxTE1ZSG4z?=
 =?utf-8?B?cU8wamNMSjJWT2h2S1dJQXZheThzTDFKeitkSEpJK212OGhVT3kzZFRpWDQx?=
 =?utf-8?B?citPKzgwNXVZNHVqWmEveVU2N1Bsa3ZWS3B5VXo4WmkxSlBMOXNWSWhCdjQ3?=
 =?utf-8?B?VU55QmRKUjlLUTJ0WkVIblc1MEJPb3FsMmkrWlBLb3RnSWo5ZTkvZlhOOUMw?=
 =?utf-8?B?QUhxMjBuT2Z0TlphWVlEY0d1eDVOVWVoWnR1U3JQMWlPMHV0QmlaOGZVbmVn?=
 =?utf-8?B?SDFDbXc1L1VtK0J6bmpicU1iejV5eDlGWmFtTDFWekhYOGRlL2psS0JZdTU4?=
 =?utf-8?B?MHFPNUtpQnc0TWR0KzNUdFY1Q2Q0MU93aVJlbGJzdmRWS01JQVNQaW1lRDFM?=
 =?utf-8?B?Nk94UUlmSmxvZmVMNFZZTUJwMWtwY1o1ZlNaOEhNeVlrUDN2b1hHSUorUGsv?=
 =?utf-8?B?bzVZU0pkQ0FjMWZBY3FRSmF2OWt6L0xmZjdIVjhGYmJmTEEzT214VnhINGZ1?=
 =?utf-8?B?c21QVGExMGR0VzlqWk0rTk9LTXZKQlRDYnphVnpSOUk4WlFDUXNuSXVhWGtn?=
 =?utf-8?B?ZEptd2dmakNHb3Rwa21UVXcrbUJtN3MwUUROWVM4TFZiV2tPNnFUaEVudTVP?=
 =?utf-8?B?WVR0eS9qU2JCemxleUd0MFVOUVZUN2IwQVlTUHZLemVyZlV1cmdsYnJmR2Mz?=
 =?utf-8?B?bFAySDRGYUsxa2V4UVd5SkpYNEVrT2pZS2dtMDMyYmMzZVBIYm45NU00RTFE?=
 =?utf-8?B?bHc3OS9oWnB1UXF1ak1sMlptS1dKeTZCWXlUUkZLZVRBQ21EZm1ld2JlZ2sz?=
 =?utf-8?B?cW5qekNxRXNNbEMvd0t0OVBwKzhTYmcxVm5ORzlGK2ZaaXorSFJuaEJQbFpU?=
 =?utf-8?B?RURXZGlnNE5iS01JTndDSkVHWWZoUVNwTGdyZUNzcHBkK0pPcWQyb040dDY4?=
 =?utf-8?B?aXRpMWJqMGZVR1BGNllud0FzbXlKbC91QlJSdEtEWDJyOHIwc0l0Tjg4NElm?=
 =?utf-8?B?Z2Y4OVB2YTBsZW9wZG1wOHAxYmt1Uzl4QmkvSmtRd2VhSUVGMktLRndDYTZE?=
 =?utf-8?B?Q2JsSVBJcjRZWkR4aWlkTHp5dC9NNitSd3JSRUQwbDZLYTZDRDNEcUFLdjdH?=
 =?utf-8?B?QTIwOFdpdFZKdk9qR0Rtd2R2OTBsazd0aWVoYjZ6endsdDVwRGdld055RXN4?=
 =?utf-8?B?ZjBsZGxKc0pFMGNVOXNDcFlpNjA4dXJGMXVOWU1nR0tXaVlENkpza3pkZXpi?=
 =?utf-8?B?K1BBQVo2bm9MN2lZV2dFcHRuWHF4WjZKWUNjYVVUQWNXL0EvblV6QVhoWUlE?=
 =?utf-8?B?QWJXOVdQWEZYUzloRnVRM3o3MjJtMkQzM2k1UEFpSFJsZlRBaWszLzVEY0R4?=
 =?utf-8?B?TDNLY3k2V2hyTDlIVHNTM3JicnowaTR6Sm5ERkEwZ29CdG1QSEpjMHZ4U0My?=
 =?utf-8?B?RzhkTG9rYW9nQ2xteTg0TnNpcGU0SkFBbFBXN2ZWTnUwaVEyd05XRVVvL0Mr?=
 =?utf-8?B?ZFZjbGxUTWxHSkx2eTRvelg4cXZjZnhrdG00QzBwWm1Oa2tycnV5blhrdmhN?=
 =?utf-8?B?TFJJRHZlTjhFd1ZJZFJGdDdoUDByN2FaVXFwYm9jYVhiaVJORm9ueGNncHQw?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9dcfc3-92f2-4862-5089-08ddec7d3d5d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 13:08:00.2864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSku0w/oBl5zQdvYIb+A+baDJqw+WacyrF3h2WmqtabTo+VCdN1maLeMyvKwmlXT2LOIH/gJ3wsHxBt9FAVMx4nYyIpaU8XLQhpRnawKyRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5120
X-OriginatorOrg: intel.com

On 9/3/25 12:08, Ivan Vecera wrote:
> Add functionality for accessing device hardware registers, loading
> firmware bundles, and accessing the device's internal flash memory,
> and use it to implement the devlink flash functionality.
> 
> Patch breakdown:
> Patch1: helpers to access hardware registers
> Patch2: low level functions to access flash memory
> Patch3: support to load firmware bundles
> Patch4: refactoring device initialization and helper functions
>          for stopping and resuming device normal operation
> Patch5: devlink .flash_update callback implementation
> 
> Changes:
> v4:
> * fixed issues reported by Jakub (see patches' changelogs)
> v3:
> * fixed issues reported by Przemek (see patches' changelogs)

in general you should carry tags added in previous revisions,
especially if there were no big/opposing/controversial changes
anyway, for the series:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> v2:
> * fixed several warnings found by patchwork bot
> * added includes into new .c files
> * fixed typos
> * fixed uninitialized variable
> 
> Ivan Vecera (5):
>    dpll: zl3073x: Add functions to access hardware registers
>    dpll: zl3073x: Add low-level flash functions
>    dpll: zl3073x: Add firmware loading functionality

overflow prevention added here looks good

>    dpll: zl3073x: Refactor DPLL initialization
>    dpll: zl3073x: Implement devlink flash callback
> 
>   Documentation/networking/devlink/zl3073x.rst |  14 +
>   drivers/dpll/zl3073x/Makefile                |   2 +-
>   drivers/dpll/zl3073x/core.c                  | 362 +++++++---
>   drivers/dpll/zl3073x/core.h                  |  33 +
>   drivers/dpll/zl3073x/devlink.c               | 154 ++++-
>   drivers/dpll/zl3073x/devlink.h               |   3 +
>   drivers/dpll/zl3073x/flash.c                 | 674 +++++++++++++++++++
>   drivers/dpll/zl3073x/flash.h                 |  29 +
>   drivers/dpll/zl3073x/fw.c                    | 419 ++++++++++++
>   drivers/dpll/zl3073x/fw.h                    |  52 ++
>   drivers/dpll/zl3073x/regs.h                  |  51 ++
>   11 files changed, 1702 insertions(+), 91 deletions(-)
>   create mode 100644 drivers/dpll/zl3073x/flash.c
>   create mode 100644 drivers/dpll/zl3073x/flash.h
>   create mode 100644 drivers/dpll/zl3073x/fw.c
>   create mode 100644 drivers/dpll/zl3073x/fw.h
> 


