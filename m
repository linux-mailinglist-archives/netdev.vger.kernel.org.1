Return-Path: <netdev+bounces-98146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCA18CFB2D
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 10:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F3E1F214AA
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 08:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3D4503C;
	Mon, 27 May 2024 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QcHuoQ6r";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BU/bGJg2"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795823EA72;
	Mon, 27 May 2024 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798102; cv=fail; b=q3+gyolGjr90OlfeahNw88hr07qCH3IIihUOqBGNiUnE/vWwjoXP46XubHHsu4XisZ2ENe9qIGz3dGLnZ/IIYSHArYYFJGxTLx5VsnG82BdmhbG/VGTFq1mm0r+y0Jxx24j/c5u61eAFZYe+nyvSl4uHVx+TZnjFqHA/A2EEFCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798102; c=relaxed/simple;
	bh=kKl8LrK7QOOQiJViXeYYyz3gYZx3IhCOf6SHW8LiQEk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H+faSC1wtnGJsL1BrkXd47lRzADs7ulZgNsyHhOhaRG9LOHvD+h5kCwxs3hOc1bMrOQX+428nRAC/K1XUXAtQ6YiLm5epx4rPrvVmu6wzug88uP0GMp4g9ZzkG0oC4jZV870cqGI2vIS91S+Ua0f74AokbCo/UHix34RudERwjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QcHuoQ6r; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BU/bGJg2; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716798100; x=1748334100;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=kKl8LrK7QOOQiJViXeYYyz3gYZx3IhCOf6SHW8LiQEk=;
  b=QcHuoQ6rnAbs2O63cgUDp0BFVEYJ6JnFW5Q5wAR5EWd5eDk3fdkcwUbr
   F55Enk8eZVXl3q3s2KfbLXrzUFZ3utxK9H/de6M39qL5qF6N36J2O3OPl
   hTGCGBC/EmyC0FsUxm+7t9miFA6hTsC/vp4H8fbB5WN4qdQ2uoHoLUL20
   7sARPHocPEFypd9fUGz0pX73cEFnYAR2891fcwv6if1wZkG0xlhQjpzt/
   EFG2gqG5NJIAW5VfOekjbJYr+lp3OHLb+vT6sMJnh0MvT+tSnTMc6djN0
   r8EE5yHt5WGq05EOweDIM4Ub4M/ReCSuLM6dPkH8t+d5TBpa0N+hPV2pV
   g==;
X-CSE-ConnectionGUID: dR/wkEPmQxKdPrIE7xJAkg==
X-CSE-MsgGUID: S4TzrUUCRMGWF9oOUK2htw==
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="257212899"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2024 01:21:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 May 2024 01:21:04 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 27 May 2024 01:21:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5JZOnymRn1+Z9zDcAy3Ekn7RkPEJ5AYIQgbn809Y6K9cntqVy8C7S5h3q2N1ss3MzofrfcWWjmPCXiBv2lPe0GRu68rKv/3Yv/qxJgwpuVIpb/HMrU3AJQ/FddsmAi6rgqS3qT2+Q8IyjvsbSsL3GwTMM6Kmt4UduDTA+iT31lTDGkUeNINGZ5zADBHONcvMSmpdThVsFkIVTZNOL8k380piOJ1iIK+R1PeZEvWwAlSlkCwg+JGKqEQy2LMISCLnFCsVbCPNIvArJCq5lJ1+9iUgyQPSi8+tXNTSaw2WRZBxsIEpjbDoqXaQNe+g8I9T4JkNV3eFjYrpirUVT1+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKl8LrK7QOOQiJViXeYYyz3gYZx3IhCOf6SHW8LiQEk=;
 b=iVZigRwbGnu35IDu6Ad8a7o5Q49G1uOkNp9YoJxq+yhoXdym21f+45vJ7hd7Tt1nDwnqIGpA5oz6p2hXDzRabf5lYVKQNFFyhfN5YXpz/u8sCYdnySTRYxwIyaEHAxgLFVepDnO5I2SsVPLj40S9mgIjvQybuUgI+fFOmzg8n534NPNNPJBsRBCTzVkiC3AWo1PEvIX57lL5AxwBcBY9jJNvN2NGjaNHvryQehScsU1KguPseHfn/cQoWY61laTKIz4Xizd5m13ZYoBIBF307V6s9hQiWRNAUbbGCVFI8pPvcRsW5qmubusGKTFBKfGe2OYNLqy4VpvVY20LrB8Zqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKl8LrK7QOOQiJViXeYYyz3gYZx3IhCOf6SHW8LiQEk=;
 b=BU/bGJg2asjCOKc5w/VG3Ae7WsE1Miv45836jiZlb3ESLJHBoPpDpCLfRlH7iFt4qtBLNvFBoKRnIGWQQ6VZpxEIsJKf4xbF+rYBAlQFLvJowfYumf5pPznJ2r/A+/Y+dfBy+4ZWeJtVCg7ZnD628lQoL9CwDxrhdbRk3VxqnLTrdYT4jlRJUzf8UvVjj1aPe4dwZRN0aW8vMHTHgDnW8pD89rMvBKrzxnczwEGtu9POpMDme9BhFEqTNdpFKY4jRrJfeZOji9eITvFS0PLkAoTy1zR162x+0deez3y3P0cbSvHAFx6oS93KclwkPYVnn9RuzaJ5VNQX4Zp909uFSw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 08:21:01 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7587.030; Mon, 27 May 2024
 08:21:00 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <ramon.nordin.rodriguez@ferroamp.se>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 0/1] phy: microchip_t1s: lan865x rev.b1 support
Thread-Topic: [PATCH net 0/1] phy: microchip_t1s: lan865x rev.b1 support
Thread-Index: AQHarePdJZh+m0FZZ0WCxjUHsxgGEbGqwcqA
Date: Mon, 27 May 2024 08:21:00 +0000
Message-ID: <bd854003-2b8b-41a8-923a-1b87d6213180@microchip.com>
References: <20240524140706.359537-1-ramon.nordin.rodriguez@ferroamp.se>
In-Reply-To: <20240524140706.359537-1-ramon.nordin.rodriguez@ferroamp.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SA2PR11MB5193:EE_
x-ms-office365-filtering-correlation-id: 0a001389-7ef6-41f3-a15f-08dc7e25f135
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?bGFYb21zc3pUY2dyb1BFOEZIQks3NEVDVEhyT1JSUHp6bzVXeVVGOTVXVkNY?=
 =?utf-8?B?Q2NIYXhpNjhabEQwRThCWVIwN09Vb0MzZE42bDFNcGtJTU9tWWl1eUJTN0h1?=
 =?utf-8?B?ekd4azY0bXNXMXVwc0JaVlVCUVR6UHo3UTY3U2plaVdoMWFIcnI5VXlrdW1k?=
 =?utf-8?B?NEJ0b3lYS2F1NFN4SGJYdHp5dGtMV1dqTjRxOWp0bEpJNldQUTBVN2NjOTRJ?=
 =?utf-8?B?TU42OTZJbTVwRGcya3cyeEhqcHMyVHVRcjYyMnlUU090cms3M1hPcHRaM3NR?=
 =?utf-8?B?dXFrL1hCYXhIN1g2NWJKdU1IT3o1ejRiVDhEalFldGIxeXBIY2hkbHdDSHlP?=
 =?utf-8?B?V01lYmZYdjZFTlgzWEg1cEtnUmxWL2tocWNsWVpKMHFNL3gwMXhsSjhDK3J6?=
 =?utf-8?B?cGJUOVdJeEJtVlJpTHczUEd0U1h3VGM4d3FJM3JoYnlJUE5JSHArWVl0a0tW?=
 =?utf-8?B?R3dNRSsvbDVqQWU0Z3NPRzd5QmZ0TVdacitqTk9BdzJ2STJQTDUyWUZpbDYw?=
 =?utf-8?B?SWtJbWV3b2NaT1gyckpkUkFRMllFNGpJK1M5Nk1wblFMYVFaUHVkMmRHZzRM?=
 =?utf-8?B?RktPS1lINGhlR0s5bGFmYzlsd010TURKMDY0Z0ZwRUtHZ3hYejBLQjVIU0ZV?=
 =?utf-8?B?UERNcnRjbHkzVHhSQlQ3YXJLY2dsYmxtOHZNR2RZV3ppNUcyRy9id1Y0eE1T?=
 =?utf-8?B?QlIxeUtqUGZrRTZuNUdDd3Z6QWxzVmhmYm5VaVdqSkNxT2JiUFhBRnB5UXhU?=
 =?utf-8?B?Z01YdU9rU3NTdW5hSXNteFJzSGJnRTVnWjNIU3ZyRE4vUDgxZ0h4M3BmYnJT?=
 =?utf-8?B?Z2hpT2h0K0tmVVFGczlnSG1pUWRCN2UvUmUvY2NmMG9kOTlhN3kvNnRYakZF?=
 =?utf-8?B?Y2k5aVVhdnYrVDBDajhhYlZ6N09OdVBNK0FORHZGTFdFUTB5eUNqMWI1QytV?=
 =?utf-8?B?UlRmcXFDVThnSG1OSGJoVU54ckF2bUpJRytNeDhsUlVidHhubzlBT2gzb2dN?=
 =?utf-8?B?VG43c3g1anFPZ1NlMVgrTDYrRnFTN3NkYXBOWmc1VkNuYkJmYVp1Z2RxNE9W?=
 =?utf-8?B?R1hZZW5tR09oQzR0RldCOWU5ZTcyTzN3bFJOaU1pdUZHS3Z0aE84cHp5dHMz?=
 =?utf-8?B?Vk5hMEhZWVNUNjJDR1BqVkE4UDVMcFIwcEIySmZqUWdmakNxWThYYzM3ZnYw?=
 =?utf-8?B?VkRaWXhYTzZTTUYrMC9JMTMreFI1STRIYmVzOVAwbEpDVTRyY0pOT3NpVC8y?=
 =?utf-8?B?S3dscG1zMFhsYWpINE1yZ2R3NHJJdHo4YlF0YnhoRWFpQUlWcGN5ZzMxOHJ2?=
 =?utf-8?B?Z3NPU3VXMFNHQTVnU2d3bS9Zem5tbGtKS3JNY0F6QUY0b2syR1R3ZUZzNTJz?=
 =?utf-8?B?UFY1aXY0RzZoUEVzNXFtTFZrQ21uVC9LUVRnTWxCbGxCWWhhM1JNOCswTnA2?=
 =?utf-8?B?TnZGd2VOdVhwdTE0Y3liUEdPbzNrRTI1M3ZMUzZqR3p4eFZXRlV0UEtHM0dr?=
 =?utf-8?B?SFpibkhmT2ZqV2VaelRabndXc1N4bWxuQkJnL3h0UmFCRkZiQjB0MGxkV2k2?=
 =?utf-8?B?U3FUdkdsamtBNFNXS0ttcUN2ODVya0hpZWlJV3BVbWFKTVBYdGliMm9GQ3pM?=
 =?utf-8?B?VXV5aGVla2dqSEJlZWJzejBLVlR5V2lRdzFJeXhZdnMwbUJCQjM0UmJEbVpE?=
 =?utf-8?B?RDZRVi9nb0tLQ1pwOHJjQ003eXhvVDdkZ1BIZWhtYzRkd3F0S2I0NHpNNU1p?=
 =?utf-8?Q?JpQWvl41GoXKkOMC9Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGNOY3dQajRodDB0U0dDV0RqQ1hvYXl2T09keUwwYWNuREtEK08wcERiSFRT?=
 =?utf-8?B?cllWc01uSVh6VmxVWXZ3LzdiWXB0eFBvV1VSYVo4NHN2dktRaWRMeVY0QWlR?=
 =?utf-8?B?aHR5d0lQcTFGYXN2Z2NaeUVXTEdianBuazF5R0paU1pHVGRCLytxUmFkTEhD?=
 =?utf-8?B?YTQ4QXI1RDh5aEFxZUkzTm4rdWpzU0EvRFBMTUxhaVRNUG5acTRnNVBuTzJK?=
 =?utf-8?B?emt1eEJkc01DQllsdm5JeDlMYnBXSjI4cW9Ec2Y4SFhKcmVHUGZMYnVwbUo3?=
 =?utf-8?B?UE5pMHFpaklqQ2wzRXpKdmEyeHNxa0dTcS9CVG45THFZQ3lOMnRqLzVWMXJ0?=
 =?utf-8?B?YlRWMDFNY29EaS9pZnNhWENpM0k1YXN5bUV1V1pneFI3STJ1MFVMbHFKVnRW?=
 =?utf-8?B?eVIwWndJbTlXaHh1YzUxMnhyTFl1eXlEV2F0d2hEVUFVVTIwTTJnM0l3VXly?=
 =?utf-8?B?N3RnU2pzTXYwMEo4ZDBIL1o4UXd4bDY0V3NHUTRVWTdQS0duMVhDY0ZQYW9E?=
 =?utf-8?B?dmlzN0JaUlB1N2l5TWhmUGlCQ3Vxc2puQnY4Q0I0S1B5ODMwTEtJTWdvVGZn?=
 =?utf-8?B?UXlab2pwdElYQms0QVVPcG1oOG9ITUFiUmxaT1VnVmJCWEhvWnltbzFuNXU5?=
 =?utf-8?B?MWNQTC83UzVnaVF5cFMyWGFxR20vRzFYN3VkZTF2U29obytQTzNmVEZlRmc5?=
 =?utf-8?B?SnB0K2NxSUlJczZyWWkvbDFLallzaTVHZWNJUVk5cjlKNUs3ZHgzVHJ3R3JY?=
 =?utf-8?B?UVJGL2EvS0RqVmZ3WnJCVkUzYWJCNU5lL1JqMGlzVlByVG12cTlkN3gyTHZq?=
 =?utf-8?B?SnMvWEtMYzNtT21rQ1dVaitMZTlVSWxkR09zQXZjd0JHRUI3QVRHREZGdU52?=
 =?utf-8?B?QWJWU0t2bW1HWW5LbTU5OTNuYkp4YmdmRjZQTVkrRmVndDFzWnBvMFJEaHd5?=
 =?utf-8?B?bkhKOVZRVllSZHUrK01uQlZ2NjBPS1pWU3dWUmZVTENSV0JFNENvdDdKT1dw?=
 =?utf-8?B?eVNTWXZCdkREdTlzZkFHVUpNK3FwaW5rM0huSUU2Q09YMzI5UElVQkp6Smpl?=
 =?utf-8?B?ODRVUEdZaG5senRGalZUbS9aNFlOUm9zNmdhaUpTQ0hLMDBrT2F1eGI5R2Fp?=
 =?utf-8?B?YU9Db3Z6NDhmcFJRZ2R0ZHBPWmZtdGZuL083SSt2QTRkNEJwOTFPYzRvV1RE?=
 =?utf-8?B?dXpITVB5aFpLMlBzUHZIUTVxMEd4TnNscjBINE1hUks4eDN3M09RRnFvOWdX?=
 =?utf-8?B?TmlXaG8zZ29iTjZmZ1ZTMHRMTWttUWNPYVVHQ3RtSkg4YVJrYWlxelBuaXBS?=
 =?utf-8?B?ek1hQm0rV3Yvb0RZeWFhS25KajJtMk9WcGFLRWJncGViZTZjNHhQdzhYS3FO?=
 =?utf-8?B?ZHlXZVIvQmp6SFlZVlVBUXJQZm96ZUZweFJjRlNLMDJvazA5WVdYcDRNY09P?=
 =?utf-8?B?bm11MjVUYmkyM3hVRjErMEZjTUk0dDQvaXk3RVpEcldtbWdzUFEzQ1lwbXRR?=
 =?utf-8?B?Mk9UU3laNEhpaDdEUzEwUXRIb25QNFJOdkhMSjJnejhiMTNqVmxnQ01xcXg4?=
 =?utf-8?B?Z0dVS2k2ampnQnZjb295VGpncHJPLytBV1hPMW5xdGdza1RxVlE4ajdaZUVY?=
 =?utf-8?B?SjlOKzQ5WU9kV0k1aHZpdlBPWVpxRTIyaEVZaTBRRHcxWE4yQU5zMk5SSEM5?=
 =?utf-8?B?TWYyMzJ2WGtEYjRhbDF2MjNqM1VGRXBMY2tkUnVzMG1yeHNyWGNsbjBENk96?=
 =?utf-8?B?K3FpalVDVHJLeVVtUnZMZ2dHbWJ4VjZNM3NQRGNLdnBFaS84K2dVeXM2ZjBU?=
 =?utf-8?B?R0V4Vll2bGViNEN5SjhQRGJvVnIrWlFiZi9ReGR5emZkeXRYSkdGNkduT3hX?=
 =?utf-8?B?WWdDMGlyZlZTeEpSbURnbXV4c2Nua0JiVDJtcG9ENHlyVDZISlpJNllVZyty?=
 =?utf-8?B?MkNxajVJQTVxU2t1QTVldFZGcDg2dzNMNG9OOVEwenUxNEJ3UkxoQ3dpRU4v?=
 =?utf-8?B?Wml0OHd6T09jTnMxTHR3NEhJcmF2YStoeXorR0tlcVlsZEE3VW9OckxmbXVr?=
 =?utf-8?B?QWVpMHp4c2t1S0E2Rm9OazBZTHJCcHpJc3cvV25TWEtPZEhkUHlXc2M1TUQw?=
 =?utf-8?B?Vmp5VDBvTUIzU1luUFRRcGlRUTBzaC9HRkx0WDB4TTNTek5nRG5XUlpZekcr?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <390E31B7D9757F4EBB4214507E57F115@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a001389-7ef6-41f3-a15f-08dc7e25f135
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 08:21:00.4852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xcE9SbWxCSNCpoh+2h1vFeVPp1/RqGx+H+qH/QlCZ0N+rToUue4bYQCDKu65sNTvgfmHQgVoTpeCAmYjFYJbPl55jwVx+zGDcNn4fnflA65XRQVXzLscxFIdMMJVn7mb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5193

SGkgUmFtb24sDQoNCk9uIDI0LzA1LzI0IDc6MzcgcG0sIFJhbcOzbiBOb3JkaW4gUm9kcmlndWV6
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpLA0K
PiBMZXQgbWUgZmlyc3QgcHJlcGVuZCB0aGlzIHN1Ym1pc3Npb24gd2l0aCA0IHBvaW50czoNCj4g
DQo+ICogdGhpcyBpcyBub3QgaW4gYSBtZXJnZS1yZWFkeSBzdGF0ZQ0KPiAqIHNvbWUgY29kZSBo
YXMgYmVlbiBjb3BpZWQgZnJvbSB0aGUgb25nb2luZyBvYV90YzYgd29yayBieSBQYXJ0aGliYW4N
Cj4gKiB0aGlzIGhhcyB0byBpbnRlcm9wIHdpdGggY29kZSBub3QgeWV0IG1lcmdlZCAob2FfdGM2
KQ0KPiAqIE1pY3JvY2hpcCBpcyBsb29raW5nIGludG8gaWYgcmV2LmIwIGNhbiB1c2UgdGhlIHJl
di5iMSBpbml0IHByb2NlZHVyZQ0KSSB3aWxsIHRyeSB0byBnZXQgdGhlIGluZm8gb24gdGhpcyBh
cyBzb29uIGFzIHBvc3NpYmxlLiBJIGhhdmUgYXNrZWQgZm9yIA0KaXQgdG8gYXZvaWQgdGhlIGJl
bG93IGNvbXBsaWNhdGlvbnMgb25seS4gSSBkb24ndCB3YW50IHRvIHByb2NlZWQgd2l0aCANCnRo
ZXNlIHBhdGNoZXMgdW50aWwgZ2V0dGluZyBhIGNsYXJpdHkgdG8gYXZvaWQgdW5uZWNlc3Nhcnkg
Y29uZnVzaW9ucy4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+IFRoZSBvbmdv
aW5nIHdvcmsgYnkgUGFydGhpYmFuIFZlZXJhc29vcmFuIGlzIHByb2JhYmx5IGdvbm5hIGdldCBh
dCBsZWFzdA0KPiBvbmUgbW9yZSByZXZpc2lvbg0KPiAoaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bmV0ZGV2LzIwMjQwNDE4MTI1NjQ4LjM3MjUyNi0xLVBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNy
b2NoaXAuY29tLykNCj4gDQo+IEknbSBwdWJsaXNoaW5nIHRoaXMgZWFybHkgYXMgaXQgY291bGQg
YmVuZWZpdCBzb21lIG9mIHRoZSBkaXNjdXNzaW9ucyBpbg0KPiB0aGUgb2FfdGM2IHRocmVhZHMs
IGFzIHdlbGwgYXMgZ2l2aW5nIG90aGVyIGRldnMgdGhlIHBvc3NpYmlsaXR5DQo+IG1hc3NhZ2lu
ZyB0aGluZ3MgdG8gYSBzdGF0ZSB3aGVyZSB0aGV5IGNhbiB1c2UgdGhlIHJldi5iMSBjaGlwIChy
ZXYuYjANCj4gaXMgZW9sKS4NCj4gQW5kIEkgbmVlZCBmZWVkYmFjayBvbiBob3cgdG8gd3JhcCB0
aGlzIHVwLg0KPiANCj4gRmFyIGFzIEkgY2FuIHRlbGwgdGhlIHBoeS1kcml2ZXIgY2Fubm90IGFj
Y2VzcyBzb21lIG9mIHRoZSByZWdzIG5lY2Vzc2FyeQ0KPiBmb3IgcHJvYmluZyB0aGUgaGFyZHdh
cmUgYW5kIHBlcmZvcm1pbmcgdGhlIGluaXQvZml4dXAgd2l0aG91dCBnb2luZw0KPiBvdmVyIHRo
ZSBzcGkgaW50ZXJmYWNlLg0KPiBUaGUgTU1EQ1RSTCByZWdpc3RlciAodXNlZCB3aXRoIGluZGly
ZWN0IGFjY2VzcykgY2FuIGFkZHJlc3MNCj4gDQo+ICogUE1BIC0gbW1zIDMNCj4gKiBQQ1MgLSBt
bXMgMg0KPiAqIFZlbmRvciBzcGVjaWZpYyAvIFBMQ0EgLSBtbXMgNA0KPiANCj4gVGhpcyBkcml2
ZXIgbmVlZHMgdG8gYWNjZXNzIG1tcyAobWVtb3J5IG1hcCBzZWxlZWN0b3IpDQo+ICogbWFjIHJl
Z2lzdGVycyAtIG1tcyAxLA0KPiAqIHZlbmRvciBzcGVjaWZpYyAvIFBMQ0EgLSBtbXMgNA0KPiAq
IHZlbmNvciBzcGVjaWZpYyAtIG1tcyAxMA0KPiANCj4gRmFyIGFzIEkgY2FuIHRlbGwsIG1tcyAx
IGFuZCAxMCBhcmUgb25seSBhY2Nlc3NpYmxlIHZpYSBzcGkuIEluIHRoZQ0KPiBvYV90YzYgcGF0
Y2hlcyB0aGlzIGlzIGVuYWJsZWQgYnkgdGhlIG9hX3RjNiBmcmFtZXdvcmsgYnkgcG9wdWxhdGlu
ZyB0aGUNCj4gbWRpb2J1cy0+cmVhZC93cml0ZV9jNDUgZnVuY3MuDQo+IA0KPiBJbiBvcmRlciB0
byBhY2Nlc3MgYW55IG1tcyBJIG5lZWRlZCBJIGFkZGVkIHRoZSBmb2xsb3dpbmcgY2hhbmdlIGlu
IHRoZQ0KPiBvYV90YzYuYyBtb2R1bGUNCj4gDQo+IHN0YXRpYyBpbnQgb2FfdGM2X2dldF9waHlf
YzQ1X21tcyhpbnQgZGV2bnVtKQ0KPiAgIHsNCj4gKyAgICAgICBpZihkZXZudW0gJiBCSVQoMzEp
KQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIGRldm51bSAmIEdFTk1BU0soMzAsIDApOw0KPiAN
Cj4gV2hpY2ggY29ycmVzcG9uZHMgdG8gdGhlICdtbXMgfCBCSVQoMzEpJyBzbmlwcGV0cyBpbiB0
aGlzIGNvbW1pdCwgdGhpcw0KPiBpcyByZWFsbHkgbm90IGhvdyB0aGluZ3Mgc2hvdWxkIGJlIGhh
bmRsZWQsIGFuZCBJIG5lZWQgaW5wdXQgb24gaG93IHRvDQo+IHByb2NlZWQgaGVyZS4NCj4gDQo+
IEhlcmUgd2UgZ2V0IGludG8gYSB3ZWlyZCBzcG90LCB0aGlzIGRyaXZlciB3aWxsIG5lZWQgY2hh
bmdlcyBpbiB0aGUNCj4gb2FfdGM2IHN1Ym1pc3Npb24sIGJ1dCBpdCdzIHdlaXJkIHRvIHN1Ym1p
dCBzdXBwb3J0IGZvciB5ZXQgYW5vdGhlciBwaHkNCj4gd2l0aCB0aGF0IHBhdGNoc2V0IChpbiBt
eSBvcGluaW9uKS4NCj4gDQo+IFRoaXMgaGFzIGJlZW4gdGVzdGVkIHdpdGggYSBsYW44NjUwIHJl
di5iMSBjaGlwIG9uIG9uZSBlbmQgYW5kIGEgbGFuODY3MA0KPiB1c2IgZXZhbCBib2FyZCBvbiB0
aGUgb3RoZXIgZW5kLiBQZXJmb3JtYW5jZSBpcyByYXRoZXIgbGFja2luZywgdGhlDQo+IHJldi5i
MCByZWFjaGVzIGNsb3NlIHRvIHRoZSAxME1iaXQvcyBsaW1pdCwgYnV0IGIuMSBvbmx5IGdldHMg
YWJvdXQNCj4gfjRNYml0L3MsIHdpdGggdGhlIHNhbWUgcmVzdWx0cyB3aGVuIFBMQ0EgZW5hYmxl
ZCBvciBkaXNhYmxlZC4NCj4gDQo+IEkgc3VnZ2VzdCB0aGF0IHRoaXMgcGF0Y2ggaXMgbGVmdCB0
byBicmV3IHVudGlsIHRoZSBvYV90YzYgY2hhbmdlcyBhcmUNCj4gYWNjZXB0ZWQsIGF0IHdoaWNo
IHRpbWUgdGhpcyBpcyBmaXhlZCB1cC4NCj4gDQo+IFJhbcOzbiBOb3JkaW4gUm9kcmlndWV6ICgx
KToNCj4gICAgbmV0OiBwaHk6IG1pY3JvY2hpcF90MXM6IGVuYWJsZSBsYW44NjV4IHJldmIxDQo+
IA0KPiAgIGRyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDFzLmMgfCAxODkgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTY2IGluc2VydGlvbnMo
KyksIDIzIGRlbGV0aW9ucygtKQ0KPiANCj4gLS0NCj4gMi40My4wDQo+IA0KDQo=

