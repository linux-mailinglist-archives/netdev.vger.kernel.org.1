Return-Path: <netdev+bounces-119198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B261954AF0
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 15:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68A31B223E4
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8C1BA863;
	Fri, 16 Aug 2024 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="O5stmLTB";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LrTr3eF1"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B561B198851;
	Fri, 16 Aug 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814499; cv=fail; b=IIMVykjZ/TqAHqYX0lKyG1xD5xIoANpeyuoV5JXmCNIBFfGo3x4o0HW5DnzomAGpPq/ubG4hFGjtc3WyJJx8/UL36AOJ677duXPD8Mznve7dmaPWsZ0Kdy+dlh1DPJYDdPNfZEt1HQzBGUfZ8awUpNWPqLqgYfX8sFBOVHrQObA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814499; c=relaxed/simple;
	bh=HE7rDpPJsVOE/zsA6V+PUXpWkvJnuiju7GWJcmES2kI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dulq05HlxeKJvP49/EOU8j7T9Hu2+Hy6TsgJCoL9ASr6PVH8bD6XcKbVBYPvy7B9Pt3FxyaHI3KtsamSGG+VrCHXZ1X0hkZKEiihm1czb/n/LxoXhYBoixYq+R3W/c0ZJLZp14ybPtlWNJXS0kIIoMCcdccl0nH/J2+P+bxdBbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=O5stmLTB; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LrTr3eF1; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723814495; x=1755350495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HE7rDpPJsVOE/zsA6V+PUXpWkvJnuiju7GWJcmES2kI=;
  b=O5stmLTBFg+nco9wPdInXRbMzRAPlS41wX8zHILvM5OF9B7m7ydv95CM
   yFvsW2iBmbj+CUXnKpoYlFXTBFAZIOnHpdaI9WeoKuwfc10UZj6vbvwqT
   zzGaEa4D43FYVikF8J2yiZdVoWcKrv5s9LXiEuDqPqnT1e2v4wdl2k8hS
   wAbMfrcns1ma6CrBLKtmN1ugo+5+mFJ06xXLp5m5w0DxxdZvdHJhNMFPp
   uiYWVZfjHrvbTAvt3M7FnVbXVggobVajE2ll0JfZr44qLjJsqrwPAnrey
   RROf5c8u/fyozxc/5TmQTEtOY6F4DsGKGSwg5iXJVRw6w1wY8t2zfxvgt
   g==;
X-CSE-ConnectionGUID: VuTtkCbyS5KLJM2bEFgk+A==
X-CSE-MsgGUID: V7T3ebBpRs+YKJW8c/NnxQ==
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="197998182"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2024 06:21:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Aug 2024 06:21:05 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Aug 2024 06:21:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKcswInqEaXboMYoCLFoh7jyoufK5NPKNM/a1u+JImhr6klF5CoD9IvZA8j3MqjgYTFImW0aD8QCnByn6AUwbvjr/7EibNnFa0nPEB8Nr7BrU/AHgSFfWee/dG5MRhR6Mb0Q0VAiDwY2szr/68yDofpWlFkDQZqF3uGtoBukOgFweBENx7diKryu9sx+y9bBBIanCOdejCLYaC4EOYIUVw8Lb2oPy5AoVImRALLlw1lGsAAch2Ukd8+6w8khmFkbAu9WwBYuj5krKtBwIMLCcWqKhuCXhAw7ysmTG06XOBbfjzY4OtMkEapxKT9CWvEVOO+PXSR+l13GyMQXqmdYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE7rDpPJsVOE/zsA6V+PUXpWkvJnuiju7GWJcmES2kI=;
 b=Clg/C0+sZE+HvH9iRk0NTi603PuZddhOqTBqqHfXTTwoYuJH4pb7KR2iOMm+3qNUAcp2ROcKlzWOizAoNAU0Wb+KS+2NoOmNviaG29KnMwVKLm4iiMaUgn7C56hprdNZWhBVcilLLtlzA2uw4o/xDjgKHrRnUcCYG+DApYKL5dIwJpRZsBJ3rRTmy8ZVg0F3RqOloHfKr3xyJ7B9biKVpaNZHU4YTrAADQzl2vNtmQZPn44GJEN82GINtDsRUy7CpYzazyBRH9w5Kdgc/Pa4SU9v+gKVmbukPcXtO4fe7Po/dqzXysBk0nbThngXraJwgOSJVwaH6zqY0gvT1Xij6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE7rDpPJsVOE/zsA6V+PUXpWkvJnuiju7GWJcmES2kI=;
 b=LrTr3eF1LoB6PyCzCrtu3+V6Exu49LXxaAOhxgU4hH7B5Z/MIobaEhA2tCJzoLfA167JTPwVwrMJIIruTX9BYCcYyPpsf5x8G8nE5jmvjzR6bcfUWzCvo6vkzi5IiBwg8Wz2SIMCCVk9fPxIZbaC7H/8+TkFrbGRkXxVgrhNiyEpd2X9LhwB/FJtaQpyAca0pTG9KF1VFP60LYy9V6N4kj/Cf/KT5DzVNjkMW2g1S7FF1Oj8FkVbQCmyUX4R9iMENgkjHzThy1xxGNtfCLRE1SK2aTo0IK/vkxcqi6DVUxXYtpCYJkRVVjk3+HL1kfeVb8bND1bmi8bEbb5WLNe37A==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW3PR11MB4715.namprd11.prod.outlook.com (2603:10b6:303:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 13:21:02 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 13:21:02 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <horms@kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next 5/7] net: phy: microchip_t1s: add support for
 Microchip's LAN867X Rev.C1
Thread-Topic: [PATCH net-next 5/7] net: phy: microchip_t1s: add support for
 Microchip's LAN867X Rev.C1
Thread-Index: AQHa7L5w3HY4X1NmWkqybGgD5y9wbbIoaU4AgAF7fAA=
Date: Fri, 16 Aug 2024 13:21:02 +0000
Message-ID: <3235fb9a-62cf-4f9a-b21e-e0b881c79c43@microchip.com>
References: <20240812134816.380688-1-Parthiban.Veerasooran@microchip.com>
 <20240812134816.380688-6-Parthiban.Veerasooran@microchip.com>
 <20240815144248.GF632411@kernel.org>
In-Reply-To: <20240815144248.GF632411@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW3PR11MB4715:EE_
x-ms-office365-filtering-correlation-id: 0c142533-3312-4452-1210-08dcbdf646da
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TUFSSlh3K0FlSzNVR1RFWThSTUNma3dRSEw4SWxEZ1NlalRWWUd3SlFiZDZz?=
 =?utf-8?B?cWxlNnlMTnNsV2ZjVEtaRDhQR0xwbmtBeXgvc1JuWW9XdWxITnlQUHBlMGxR?=
 =?utf-8?B?L1RDVU9LM2l2YTkycG9EeEQ5RHBZR2lEcmhCQy96bFV0TnN3QUxLWkpKYkhX?=
 =?utf-8?B?OWpBbTB4WE52VFNJZWpCb1ZJSEpXSVR0T1dDV1ZHRmRYWTJpSmo5THhMRTJS?=
 =?utf-8?B?K2FiNUdhRmFyekcvSkNaR1lweitQdlVUNDl6aUMvRlc5TlB6dzk3UWs0L1VK?=
 =?utf-8?B?UHZqNTd4L01OcWJiWG11SUdWTndaNHhhUytkRUNOcll5SjVubXozcU5BT2hZ?=
 =?utf-8?B?QktWSVRPcGF6N3FUK3VWbklmbTh1bkFVbjF2dEduUEtWY2h4VkRpVVgrSFdT?=
 =?utf-8?B?SG9yUUIrV0hIVHdDWklMclQ3L2tvM0k1S2ttSTRHSnFWcG5QaHRJcUU0Vk9l?=
 =?utf-8?B?K29zendudTBaLzJtS2pNRndzaEUyeldtV3JwM3lOR0o5QWdDZnlVNWtJZ3Q0?=
 =?utf-8?B?Y3lBQ0xzbDRHMmVwVEJnY0VLcjVnREkrYjZHZDVMbEhJRmdCYWtDYkE1Um16?=
 =?utf-8?B?WVRCTjV0WTc2azQ3Y0lYVWdVU0laZFdiTWFWSnh2WEJHYUZLQVhqcU1oWHFi?=
 =?utf-8?B?bkw0T0ROcWk2Q0d6QnlRRFZkcUlTVUhTWUdIYk1PR0dWZ2tld3hKaTExOGgy?=
 =?utf-8?B?aEd5NncvK2c2TE1yNnhVMDl2NGJGcTE5dkVaY01NK3FqeGZJWUdJUVBtaVoz?=
 =?utf-8?B?TTdPWVpLN01RMFM5U2diRkhSOWlhdjlPYjk3U1hjOUNKd284U3hoMTlJRmVy?=
 =?utf-8?B?Sm5Edy91RjE5SzdaNE8zY2Z0dmgzQmtiSlJHNTQ3ZFpuT1AvakIvTjRGT04w?=
 =?utf-8?B?RmVMbkZJSHN5dG01MVJIWG8zeWt5QzBtOVZoMXhNd1RERlRaUzEyUXo1eDRC?=
 =?utf-8?B?WDVmMXlOajFQenFZS2ltUGRoQzQ0SENIeUpQRklkZ1FTb1cvTUJYUG1PNXNr?=
 =?utf-8?B?VExLaXhqNGhlREl5MWNyNllxV29tNVlwaTl4OVludjBYblRoT0dZZHVMbldJ?=
 =?utf-8?B?d3pEbU95cDd4Vk94SHN1TFRObmM1QTVQMU1QRTJtTVZEbU9YRm9oQ2RuMEtu?=
 =?utf-8?B?VnJSQkhoRWpNbFYzTzdpM3RTUkt2czRvdkg1cFRIVlVvYjROY3ptcXVuTGZh?=
 =?utf-8?B?Y0Y2RGV2OVVLV1gzWnhSdE1xMmJzbFA4VXNrTzA0Qmh0TTdzeDZmVk5abkk2?=
 =?utf-8?B?U05RK3ZzM21UUzh6d1Q1UXZ0QnVCN3RTTnJGL2huNzIzQ3dpT3k0a2thelBj?=
 =?utf-8?B?cm0rejJLOE5MZTdqNXBQYytQM1RJM08xQk05cHFHMTFzMmVJSkFlWGxlbHZs?=
 =?utf-8?B?QWhFVXM5T2dPNkpUQWdRZlBISmhmV0dLTXlQeE1hVGZzRmlPdXl6QWtBQWtM?=
 =?utf-8?B?Yld6OEZlS2JaVVllSDVwUUlNblBoMkNiR0RSejM2TXpXYVI5WmpzMkRvVnpp?=
 =?utf-8?B?V3JxQS81SThHc3BnejU1QVBYbDYxWU82TlNjWGJvN2JobmdZeENPU2ZPUkZE?=
 =?utf-8?B?SkNqcmlhNHk0VjN6QnQwSEJ2ZUwrczBrY2FMekQxSVNITnRVclZPSXBFdlpQ?=
 =?utf-8?B?MUJXWlhFalV6MU0rNkkyeXBiVDdnY1RkcnRhcDBSc29xa1dUdWxubUtpdlJZ?=
 =?utf-8?B?QVhMKy80K2svcDlwZ01yVUlSaXdwUFVEZjdHTDdvTGF5eWFTSDdQM0pWU1k3?=
 =?utf-8?B?cS9WanRNZC9XNmd5aTVDeVBCeXRaRkNQZThLYkJ3MVBmYnlyWElpN1JneitC?=
 =?utf-8?B?U1dnaHUyZ3YzbUdDeVV0SFlCUzRDUU5Vc3d2MXpFRHhTVWI1WlVsQmo0UGhS?=
 =?utf-8?B?STZVdU9NV2dvSDJRSHV3UElyelU2ZWlNTzJkYmIwNFNhckE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2xlNHRWaE83SVI2UkRKbW1xdC9zU3BrNEdjVHJSM0dPRmxnaGtUUXNjSG5h?=
 =?utf-8?B?OVhpekdINWNJQkpBUjk2THdFdVlOSkJWM005bkJxVnc4SU15bmE5d21zVi8w?=
 =?utf-8?B?N2VXWkZPQzNtK0YycEhEWjVrSHp2NjdoakRvKzBaSmh0TGJ4M1ZaNjBuY0pN?=
 =?utf-8?B?RWRNcnNtWVNSWGw2blRKSUFITUpKaUEyLzN1WXVPRGJWNjF0WTZuWEpRRjVo?=
 =?utf-8?B?bmJ4NTQwMGdoRVdueHlKczE3dGJxZ0xYTW1ETHRGbi9TQTNEaEZqUGZ0bzg5?=
 =?utf-8?B?cWEyZ3RtUDkrUXZHOUEzS2c1bGtzS0FkMHZacTNMQUdPamNlMmVsSEo5dTRm?=
 =?utf-8?B?VUpOeW9GZ2tvVS9Gd3kzVEN6ck5QSWN2WlZpT2lFUTFlVzlWSFpvLytXZmNj?=
 =?utf-8?B?QkNPVlUyVkJ0NkV6S1FHVHpaSUF6bkdSTDZLcTEvVlZyQVBKMHZXVTRUWGNY?=
 =?utf-8?B?ckRnbkRtMjh3MzNUM0Y3cnJyZThZQjc1QzVVZ2lNS3NITndLSk03QnBKclZt?=
 =?utf-8?B?ajVtN3c3S0RGVms2SlJkQWZNWmQ1TkIyNXhpOFhpYldlRmtnRmVyaDBDRlhx?=
 =?utf-8?B?dGtSaGpscHBYQ2R3TzFzQmM0NUlMYjRrb0NWNVVlQ0RhT2s1NnJqSVVBYVZk?=
 =?utf-8?B?aHNwN0FxejA4bFVqc3EyN2RuREU5ZTUwbmVvblFwNnBhY1R1bVVjcXFTcFA0?=
 =?utf-8?B?YUhhYUV4ejNWY0o2a3hmVUxrekxLQkx1Nmc3cnhPd3pRdnZHZGtGampxTGRr?=
 =?utf-8?B?aXRXMTE3Zm05R3o3RXlPMysyMXYydkxGbDFRUHFHdTl5bDJtd252d1YzYWdz?=
 =?utf-8?B?R0FtQ0krK2tqRGVMUGpXZWVFNzlIMWZtbGJibDBuZXZpZ3M0WlZjZ29tZDBC?=
 =?utf-8?B?bmNZRWg3ZllRVk9zZzRyYkJJOUw2UVlVUnVoYW1odGsvTmZBdzNmNkNJbnls?=
 =?utf-8?B?cDBOL1c4dVo5TjYyalNwUitXRFNjWDh2NjR1UW15dXlpdUhOZi9xQlhoZmRO?=
 =?utf-8?B?UnRsK242bThkQjd3aVE2Q3ZOeUkrOU5XU0lmT0s3VzkwK25qRjdUd3BicURk?=
 =?utf-8?B?WTZYSkwxSGhxSGYzUjRBMWU2cGY4RTNPYUNRNEhJK1YwZTkxcjVRWFJwU3pu?=
 =?utf-8?B?U2VtL3Nlb3ZQM0U1clh3K3RwNWU1amtuamUyZjNHczJweUxBbFVua2x0Z0RN?=
 =?utf-8?B?L3lvK0ljY3FNbzhMZXdibFVwbWRPMjVKVVpDb0RMbVphZmVGN3BLNXJXWW83?=
 =?utf-8?B?N29QSnZMWHRrcWdEN3V1ZXdham1tYm4rMEJVWFJXeDhzSEMrQ1ZMOFNHNU1t?=
 =?utf-8?B?MlRUS3c1NEc3cVFLOHlLbXdFK3F6RlIxNkRmQzc4bXYzdFFUOVZPR1htL1Iz?=
 =?utf-8?B?K3VPV3dEZUUrV3FJZjE1Z2ptUVJZeG9rQ014a2FRY2tUaTZtYkFRdDBJMlpj?=
 =?utf-8?B?NzR3OVl4STcvL0lPeFdUWUdMQ0h0bFJMQVlINmdCZW96eG03RHlEaThWQmpz?=
 =?utf-8?B?RlV2WEJrVERKV3ltMnh6U3gxOGErdTNaVHJEbzdDWkQ2bDJpTU04TTRqUjhz?=
 =?utf-8?B?Sm02MWJqL0JJWndtRGJ5QWhsQ21kSmprblQza1o2dDMyYjVocHBQQjhTN1dh?=
 =?utf-8?B?MXNUa1M2OXFEL3JDRTVnQzRiam05bnJmUlcwQjJienB6SnNVY0poRDhkNjlV?=
 =?utf-8?B?MEhWcDJ1MXV5ZG0xcU9vSlNnWEF1VXVQSmdwTyt3TlJkc1JuUXdqb0hYM0dQ?=
 =?utf-8?B?Q0d3Um9rMzh4eEd4VzBHcWZjVUpBUzJuWW00UEl4OEtrZGV2c0RrZEd5eHNo?=
 =?utf-8?B?eEdzNTQ4SVJQUmtwZXVROExqaUZHUjBLTFJYTGpVcCtWRURyRS91QWRCZGhr?=
 =?utf-8?B?TnEwU2RUU3pVc2NwR2ZvQ2ttcUJUWGE0dllRRkUrZkZJK2xVU2VDU2pGUjMv?=
 =?utf-8?B?TXdMeHFkTUVpVTQvYTlPVDR4Tnd0TFpTb3FNQmdWLzRUWndGQnBnYXFFZnFj?=
 =?utf-8?B?MFpCeW11SWkvNysybmFNVHZtUEVtdldLcldnQ2Z3YVZiUWRicjVER1pDMUVm?=
 =?utf-8?B?b25wVmpHM1V3ZjZZdndCSGVvUTJ0NUUxYVlXOWt6eldVY3hrc0c2MktSVzRN?=
 =?utf-8?B?dUxnUGh5YklOL1lrYW00bmNNditIcEFPZ3dKZmVCdkc5OXB1MTdBbmJxQ2pD?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <726F6F6BF2118741BBB59A8F11AEB2D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c142533-3312-4452-1210-08dcbdf646da
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 13:21:02.7798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHLzRaxjWvqRzDiIMz0bKpogx/DnvbMQqcmQZtNS2oPB2FGG1MVq9+0/q5t/Q70p2Avycf2qU2ks+1KYeZK6MlnCrSaFC1YtbRCwHKBm7Vlb62Qh03XKP9/B99O5YzWz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4715

T24gMTUvMDgvMjQgODoxMiBwbSwgU2ltb24gSG9ybWFuIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIE1vbiwgQXVnIDEyLCAyMDI0IGF0IDA3OjE4
OjE0UE0gKzA1MzAsIFBhcnRoaWJhbiBWZWVyYXNvb3JhbiB3cm90ZToNCj4+IFRoaXMgcGF0Y2gg
YWRkcyBzdXBwb3J0IGZvciBMQU44NjcwLzEvMiBSZXYuQzEgYXMgcGVyIHRoZSBsYXRlc3QNCj4+
IGNvbmZpZ3VyYXRpb24gbm90ZSBBTjE2OTkgcmVsZWFzZWQgKFJldmlzaW9uIEUgKERTNjAwMDE2
OTlGIC0gSnVuZSAyMDI0KSkNCj4+IGh0dHBzOi8vd3d3Lm1pY3JvY2hpcC5jb20vZW4tdXMvYXBw
bGljYXRpb24tbm90ZXMvYW4xNjk5DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGFydGhpYmFuIFZl
ZXJhc29vcmFuIDxQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0K
Pj4gICBkcml2ZXJzL25ldC9waHkvS2NvbmZpZyAgICAgICAgIHwgIDIgKy0NCj4+ICAgZHJpdmVy
cy9uZXQvcGh5L21pY3JvY2hpcF90MXMuYyB8IDY4ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9LY29uZmlnIGIvZHJp
dmVycy9uZXQvcGh5L0tjb25maWcNCj4+IGluZGV4IDY4ZGIxNWQ1MjM1NS4uNjNiNDU1NDRjMTkx
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L0tjb25maWcNCj4+ICsrKyBiL2RyaXZl
cnMvbmV0L3BoeS9LY29uZmlnDQo+PiBAQCAtMjgyLDcgKzI4Miw3IEBAIGNvbmZpZyBNSUNSRUxf
UEhZDQo+PiAgIGNvbmZpZyBNSUNST0NISVBfVDFTX1BIWQ0KPj4gICAgICAgIHRyaXN0YXRlICJN
aWNyb2NoaXAgMTBCQVNFLVQxUyBFdGhlcm5ldCBQSFlzIg0KPj4gICAgICAgIGhlbHANCj4+IC0g
ICAgICAgQ3VycmVudGx5IHN1cHBvcnRzIHRoZSBMQU44NjcwLzEvMiBSZXYuQjEgYW5kIExBTjg2
NTAvMSBSZXYuQjAvQjENCj4+ICsgICAgICAgQ3VycmVudGx5IHN1cHBvcnRzIHRoZSBMQU44Njcw
LzEvMiBSZXYuQjEvQzEgYW5kIExBTjg2NTAvMSBSZXYuQjAvQjENCj4+ICAgICAgICAgIEludGVy
bmFsIFBIWXMuDQo+Pg0KPj4gICBjb25maWcgTUlDUk9DSElQX1BIWQ0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDFzLmMgYi9kcml2ZXJzL25ldC9waHkvbWljcm9j
aGlwX3Qxcy5jDQo+PiBpbmRleCBkMGFmMDJhMjVkMDEuLjYyZjVjZTU0OGM2YSAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDFzLmMNCj4+ICsrKyBiL2RyaXZlcnMv
bmV0L3BoeS9taWNyb2NoaXBfdDFzLmMNCj4+IEBAIC0zLDcgKzMsNyBAQA0KPj4gICAgKiBEcml2
ZXIgZm9yIE1pY3JvY2hpcCAxMEJBU0UtVDFTIFBIWXMNCj4+ICAgICoNCj4+ICAgICogU3VwcG9y
dDogTWljcm9jaGlwIFBoeXM6DQo+PiAtICogIGxhbjg2NzAvMS8yIFJldi5CMQ0KPj4gKyAqICBs
YW44NjcwLzEvMiBSZXYuQjEvQzENCj4+ICAgICogIGxhbjg2NTAvMSBSZXYuQjAvQjEgSW50ZXJu
YWwgUEhZcw0KPj4gICAgKi8NCj4+DQo+PiBAQCAtMTIsNiArMTIsNyBAQA0KPj4gICAjaW5jbHVk
ZSA8bGludXgvcGh5Lmg+DQo+Pg0KPj4gICAjZGVmaW5lIFBIWV9JRF9MQU44NjdYX1JFVkIxIDB4
MDAwN0MxNjINCj4+ICsjZGVmaW5lIFBIWV9JRF9MQU44NjdYX1JFVkMxIDB4MDAwN0MxNjQNCj4+
ICAgLyogQm90aCBSZXYuQjAgYW5kIEIxIGNsYXVzZSAyMiBQSFlJRCdzIGFyZSBzYW1lIGR1ZSB0
byBCMSBjaGlwIGxpbWl0YXRpb24gKi8NCj4+ICAgI2RlZmluZSBQSFlfSURfTEFOODY1WF9SRVZC
IDB4MDAwN0MxQjMNCj4+DQo+PiBAQCAtMjQzLDcgKzI0NCw3IEBAIHN0YXRpYyBpbnQgbGFuODY1
eF9yZXZiX2NvbmZpZ19pbml0KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQo+PiAgICAgICAg
ICAgICAgICBpZiAocmV0KQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0K
Pj4NCj4+IC0gICAgICAgICAgICAgaWYgKGkgPT0gMikgew0KPj4gKyAgICAgICAgICAgICBpZiAo
aSA9PSAxKSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IGxhbjg2NXhfc2V0dXBf
Y2ZncGFyYW0ocGh5ZGV2LCBvZmZzZXRzKTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgaWYg
KHJldCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAN
Cj4gSGkgUGFydGhpYmFuLA0KPiANCj4gVGhpcyBwYXRjaCBpcyBhZGRyZXNzaW5nIExBTjg2N1gg
UmV2LkMxIHN1cHBvcnQuDQo+IEJ1dCB0aGUgaHVuayBhYm92ZSBhcHBlYXJzIHRvIHVwZGF0ZSBM
QU44NjVYIFJldi5CMC9CMSBzdXBwb3J0Lg0KPiBJcyB0aGF0IGludGVudGlvbmFsPw0KDQpIaSBT
aW1vbiwNCg0KU29ycnksIHRoZXJlIGlzIGEgbWlzdGFrZSBoZXJlLiBJdCBpcyBzdXBwb3NlZCB0
byBiZSAiaSA9PSAxIiBvbmx5LCBidXQgDQppdCBzaG91bGQgaGF2ZSBiZWVuIGluIHRoZSBiZWxv
dyBwYXRjaCBvbndhcmRzLA0KDQoiW1BBVENIIG5ldC1uZXh0IDIvN10gbmV0OiBwaHk6IG1pY3Jv
Y2hpcF90MXM6IHVwZGF0ZSBuZXcgaW5pdGlhbCANCnNldHRpbmdzIGZvciBMQU44NjVYIFJldi5C
MCINCg0KVGhhbmtzIGZvciBwb2ludGluZyBpdCBvdXQuIFdpbGwgY29ycmVjdCBpdCBpbiB0aGUg
bmV4dCB2ZXJzaW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gLi4uDQoN
Cg==

