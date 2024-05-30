Return-Path: <netdev+bounces-99577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A7A8D55FC
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033AB1C21674
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124DF182D3C;
	Thu, 30 May 2024 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MGp0YdhA";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hW5tdXRl"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA7913B290;
	Thu, 30 May 2024 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110409; cv=fail; b=URF/CLruW/gM8f5rabX9RX6uyxSCfbiCWVS7Et/lpKJlsM2jgzwfDdvFdh5Nsrk8cY5U/+W6YmM0g6nNffnAhffvU+bNFjPXIh8AdxqW32z0lbITkybeP/2BGRfKLKVJ6uhcvrcGVBUBPSijX2JVjm4jPkauz8zhhv1cJDEa6vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110409; c=relaxed/simple;
	bh=WMniiEq4vQDb7Gpyh3veb7gGRlojiAIIBaTqN6aWobA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=axApWRtp4bZidOiUG1aUUZOXVAoWOV0kExNHtNH93p38kKCcPWcM4keEiCfL8SbW64yqe04rwIH7sIFHqac1EK+Htu9ap2rP4unog8Jg2lDLFFzNtjbc/kZaJ5YxyrYbdTOIB1Dwyegv2B04fmWutFeIufkWXbwu8kGu9Hxzi5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MGp0YdhA; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hW5tdXRl; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717110407; x=1748646407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WMniiEq4vQDb7Gpyh3veb7gGRlojiAIIBaTqN6aWobA=;
  b=MGp0YdhAfbov2IUEcbV3t7GBns2ndvsyVv6s1uNO76IP6LuVnzBI0aBq
   DyE7UOLq6nx0/buAZwdY0zGA1m69JrwAWONviaA4edTmDty/oagPTSg6U
   LAsPgWgn4UAo88+ccpSYH6qoG+4xdQ0d4mGwCLSQkJbin661e148sCcCs
   0jhgvM5LSjRL2v64QsnyiMrBGGGF3/eALmu+FnEA/jNWDSTr5rluiflLc
   7Ly4FkYqjx4iKpQU0eHdMF6NNWhRGW5AVxNwmv5K0INBL4oxspOeN8kKO
   ITnHwBIL+B0Wi4figQ49Na91CkHkA5r+z7Wd60t2q9BKU+eNA+vGQbrXs
   g==;
X-CSE-ConnectionGUID: iFrGGMXqTm+9+amlwqw3iw==
X-CSE-MsgGUID: UyAWelEuTYOqkhCs1Zx6EA==
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="26775900"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2024 16:06:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 May 2024 16:06:39 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 30 May 2024 16:06:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmVuMxG1s+nrg4/epz31/3y7u/u8ZcIDGk6vEg2fn/V+E9sCc40XzBp2TPYKKZBpwhpzhhyi5ndFEZ0AP14JVtsPYtLAeal4jJX0xvgtFXPtPPWwuwytWaQxHmzrNisCvsEXGwdncz3uTg1+lu6V1Dz6m1lLtV6iUz7fZFPHm8jZNLDgPvS6S526/BfThQnc8Y7EdE1XwGYmxNK9T5voprCC7//alg8mpbcWczTg+HjSsOw29pdQsBY93IEHDDMb/AW7ilBSPjj771pEB5PWS7gFLzysqWHYNjca9kGzOte0BQQgZLH7Zb1KQOPvJP7Hkx1rbz+TIw1FBgYQWv174g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMniiEq4vQDb7Gpyh3veb7gGRlojiAIIBaTqN6aWobA=;
 b=nbfs0crHIaulJB9/arnVFb0gf2eIjYx97NEFpPiSHq+eDJDrcitSKrADtYOximB56iC4TL1x5vJV3C8lYerQMQlKvYHDs97pHggC2BOBpgGdO4pqpbNjP9uzt/A2oeroawnYC8EQGqmvroFHiAYhRQxGoogXwMhZJiKlQLDg9xxnS2d7Qhft1XLaExZA39goIVnlaea05JMJTAfjR9NZTFv/PEh4W23N7H2jB1PMmI4orCbTIOwOCqbwf6Eoi+HTVsnkXUd39LOVSytjGsqGjxOBSx6Hve32z4GnCMaxnFUx3ZxbHEwWUrpadjuRceA/iyUmjcXiqy0GVub4eKsH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMniiEq4vQDb7Gpyh3veb7gGRlojiAIIBaTqN6aWobA=;
 b=hW5tdXRl4BSBu3GUHfrbTQOg2xAls608YJI6n5d7DGJMpjZzWWTS4NOTQFYr1hELsPMCupbCfwIlHMbx3L4uUvjbbDkxyrU5zyll6DhMoasYyMJ8Y9Qcz14tpbosa/7MdRxcbDK4saCtSysxqijc2JkfwvY9hIgg7cBJ6UqztlgOTGohOGcpBxudxP4IMkhrql4FKuA/D/GwKlBGZlI6sshbNelSt8LTpFW0hDZR59nPA8scjhubtC/C8s9aTc/waceKx6HF1gmvo5jscZOxBN2MdfeBZXw6+WNqqyxL63QfI3Me47RBOWfdTy/ldbedvor9XC/RLCU4+WNlkR/zdA==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 23:06:37 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%6]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 23:06:37 +0000
From: <Tristram.Ha@microchip.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Arun.Ramadoss@microchip.com>,
	<andrew@lunn.ch>, <Woojung.Huh@microchip.com>, <vivien.didelot@gmail.com>,
	<f.fainelli@gmail.com>, <olteanv@gmail.com>
Subject: RE: [PATCH net] net: dsa: microchip: fix KSZ9477 set_ageing_time
 function
Thread-Topic: [PATCH net] net: dsa: microchip: fix KSZ9477 set_ageing_time
 function
Thread-Index: AQHasUb1rkH6eHyobE2qyNqLKpuKe7GvgJQAgADoa0A=
Date: Thu, 30 May 2024 23:06:37 +0000
Message-ID: <BYAPR11MB3558F5B1EEAB802476D36F9CECF32@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <1716932192-3555-1-git-send-email-Tristram.Ha@microchip.com>
 <4a467adcdb3ca8e272bd3ae1be54272610aabc9b.camel@redhat.com>
In-Reply-To: <4a467adcdb3ca8e272bd3ae1be54272610aabc9b.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|SN7PR11MB7566:EE_
x-ms-office365-filtering-correlation-id: 1c1c1df5-5913-4096-1e4e-08dc80fd287c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cEhVQ3UyczZYMmpVcGdaYkl0bTNCajJGY2dnVFhvczg3YUNWRDBldnRBK20x?=
 =?utf-8?B?aUNPbzBPbW5XL2FwOU92V1l2ZzNhUE11M1JySEM2SjJmVklNUW1NdTRvVHlm?=
 =?utf-8?B?cXFnSTU2dTFHcTBMVU9ncU5TbDVoTnFkaWZGRCtuNTBRb3ZDMnpLcC80d1I4?=
 =?utf-8?B?a1BxcmJKTzhldDhWOC9IY2FYQkdUWlRrOEZTdGl4Ky9ieFU4UjZKVExmS050?=
 =?utf-8?B?RGJQMDdmbithY0F5VjhsNkIwRG9EUzRnc1lIQ1hEbWlQYzZlY3hqOVFIdDhh?=
 =?utf-8?B?YlpmL080TmJQWlI1dFF6KzhSUnd6dE5BcHMxemt4Y2JwRmM4Y0xQaVhRRGdQ?=
 =?utf-8?B?ZEJLVDkxbVpVVEl5ZDBNWlh6eDRYM2NMdHdMOHRCM2VsbzZ1OTNySXdId1Z1?=
 =?utf-8?B?RFE0b2kvVFkycXljRURQL3NPaFpFc2xrRWZNUUVUVEhrUktEeXRtZnFaN214?=
 =?utf-8?B?K24rQlNvOUhvZzUvQkY4NkZXQktyNFJRSnBicnEzaldwV3ZOemlETm9VSkhG?=
 =?utf-8?B?QURReUwxb0VuTkpiTGtKMTZ6UnBhcDFrOC9udVZaN01yS05yTlFDcXpWbGhw?=
 =?utf-8?B?WXBWR2ZQUFRIdjJHVm5xd0NFUXhPYW1vQ0MzNzIvZW96YU53QmhDaFhpREl5?=
 =?utf-8?B?UE9sSlp4MHpYRnpNV0hPYXRiZTQ2MFhFZzVXdmJIbUduRm9qd3BDQjloR01C?=
 =?utf-8?B?c3poV1F6RkJ6WW5Bb2NzamE5ZDdEWG5pd3Z2aTRISm5USVJQcEpXSkV3N0kz?=
 =?utf-8?B?T1k2c3lUNHhFSWZIOUxHYnQ4QXhEU3lzN01wNHRFZWZ6MVB4SmNoYUhLWTdB?=
 =?utf-8?B?c3hmdlYzMnlQN3FOcmpiRWIxcEdwSllaaE9HbVRjUDBXOU5Wa3hjWXFoVDR6?=
 =?utf-8?B?aCtBd2hBMXZ0RWh4ZjEyaTg0SjhpbnRjdGwvZktJak02QjZrVDE3SDdvN3VK?=
 =?utf-8?B?WFNJdTREb2NPS0tVNWZ4bStKc1NQVW00R2JCR3JVczJuMWZwY0MrclIydDZ1?=
 =?utf-8?B?bDhzU0Vma3FKLzZrU1JiV1M3R0ZVdG1Bakl1MURzNWgvUVMwcnJPV1FSaEln?=
 =?utf-8?B?dm9BK1pnZWtzaEtFT3FBQnM5a1EyTWJNVGd5R1BodEN1cktwMCtJK3J0UThq?=
 =?utf-8?B?cC96OEpsUEhoUGRWZXVFa1lIaHU0S0F1VFNENkx5TWt3NXJITzdrWFU3UXZ5?=
 =?utf-8?B?clc4UVVXeUdhN1diSmV3NEgvY3hzUDkxTVNySC9ZbE9CYThzT2UrMEREMUFj?=
 =?utf-8?B?UG5iN2lET3RBODd3MDVmRnlycUdVU2FZU3l1YTc0YXhZS3NjNDNVN2tOaUpF?=
 =?utf-8?B?UXMrOFEzNVFhM01zZjZQUDdjTis5ZEpBMGl2QTdKa2JQNkJvOUxJTXdhVGo0?=
 =?utf-8?B?Y3VyRnFJbVVsdjlBN1J6eXlOMVRlcHZvMGZCTWJiK0xBaUNOQllac1FvWGtP?=
 =?utf-8?B?Ym1TK2VsZEZqSzk4VGtuRW14MmNSWmhmRTREK05aa1RZUWlLN1AyN0hycmEr?=
 =?utf-8?B?RWRJQndsMmZHU25iSzkvMk5EZkQvaW1kMXVPaStwQmEyNGhKdFMrSTgvZzdp?=
 =?utf-8?B?WDBzb2FlVFIyM1FMRVJJQURHb0UrKy9KeVZzdGwvWDlLYklXZkJHOWZoQnRt?=
 =?utf-8?B?OGxWdmhpY0UvOUxZTTUvS3F2ZWVyV3JuUk11eDF6Q1FzeTcyUTc0S1RVVkZB?=
 =?utf-8?B?WFJqQVVVUHZvSDZGZnNBd0RXOFVQT1BHeDkvM1BMd29OTGp0RVFiaDExMzBR?=
 =?utf-8?B?UHZYRUN6YmJJNEVza1I2K3VRVzFMS0hCeUQvMDRLV1FrNFlHSHVwN3Y1MGZ4?=
 =?utf-8?B?M3NLTzdWTW9wRkkvMHFEQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1FxU3laZnErbFpmT3ZQVWtieW5YK21oVEJDMzFFTlhLQUZMQ3I3cXpEMFhS?=
 =?utf-8?B?MkpDdlhWSGJYdzlCK1ArRzhzRmMzL2hRWEVkMzZiNm1xRmFvNytYVzV5OS9G?=
 =?utf-8?B?c082U1JqZGJ5OXJaY1JDenU3S3QvVVJ1Y2I0NkwxWnV6UXR3WDJTQ2kxWFVl?=
 =?utf-8?B?ZkdyVFk5c3grZTk3R1RQMThZVFN4TEJ0Y2hONXlRdUgwdjVQdTJobzVCNm9U?=
 =?utf-8?B?U29YSFU3SHhCMDhRYk5FeVdYM3huMHczN3RTRVAwU0dIcFN4S0wxNFNkbXlT?=
 =?utf-8?B?WktwajZUZkVXQWt0dkFMUmFUMXlVajZIU2M3eG1sdzVYaDdJQjVQVDMvcWdM?=
 =?utf-8?B?ZGp6LzJ1aURRSWd6UFBFUWdwSXhHeUJFWTViU3VVbmxBRDRtNzdvVXVLT2Y1?=
 =?utf-8?B?YUVvNWJ0UlkyUmpmMlpTRUduNHlRWFNBS3hvQUN6WEZOT0ZaK29DeEpxSjVT?=
 =?utf-8?B?eFZaWDBkMysxbjZsZG1FeUxvTDdPTWd1UzdJY2VBQUdjVkdCV2ZvRkdVMUcz?=
 =?utf-8?B?UDRmK1pMeTFQSHlRTDFJeS9BNUNVVE5NQzkwdU1FRUU1d0ZGdnRNKzIxdVZQ?=
 =?utf-8?B?SFZ6R1FETHJxMWd6em5qbEtIUWloakxRKy9zUTE2bklDdmNXVFNDZE1HL2Qr?=
 =?utf-8?B?azhseGwrWUpVTHlnN0ZjcS9HUmFhMGk1OVFjeHhuRHlJZXJQZ2tjRldQYlJT?=
 =?utf-8?B?cmNTZ1RFdnR4aGNWQmZySWd1R3VQcTFMTGlQTk9QaGNmY3owMG9UN1l1LzI0?=
 =?utf-8?B?WmxpdGJGUVRkQW04VkdXcFNRVzhDSGxvUzVuRDVEbUJQbDFMcFdOY1p3d25X?=
 =?utf-8?B?ajN0Zm5NazVGUmhLNmxhVVBSN3VqMzBjb0NFS0k0dFhiUXpDQkJWT0dpaU1V?=
 =?utf-8?B?ZDc4STlLNmlUZnQ5TUhVNW4xcXVwV1FtNDl5R211OFFmUXNwa0RMY1dhcXQx?=
 =?utf-8?B?VU5rZjhibHhaeHJEajFrZ2ZoRTFrdXVXc0RkeDIvVG1kVXZ4SStVUDNleVNI?=
 =?utf-8?B?dHZiMVdJYW5MSExEblF3MWZRM1I5ay96T1NFZmRrb09XeC9YTWp4SklNTjFD?=
 =?utf-8?B?WkV6anhOblVyRUdJSkRCempBY0dDYjJFaHdLaGNlTERxZVF4UWtaL0Y5bjZq?=
 =?utf-8?B?RVEyM0FwWW40bklaajNiMzlXZ1E1Y1VGbk1SUVBMblFtZ0d0UlNKODJGMUN2?=
 =?utf-8?B?WTNBdFlCUEt6cjErYURwa0QrTm1MT1dEQXNxL0NBYlFYeHpLa2hJOEZxSGlE?=
 =?utf-8?B?eWhuWlQ5QnFrU2lEazc3SStEVy91R1RocFljZHJ3aFVYWUVaNGc4ZmVuZm5B?=
 =?utf-8?B?bjlpL2NYMVp5SFNwOXp2NC9paDZaM09icDl6aHpxMGIxY2gzUmdoam40VktM?=
 =?utf-8?B?THB0QWxGOGRPL2RjMUVkQ0IyVitENk1SVW1JbU1XVXV3NzBxQ2lFMzV6Y1VZ?=
 =?utf-8?B?TzJvVkhIQ3EzRTBTQ0NHdEV3RDV6NnFrbEIybW4xR25ia1NSNStQWmxtUHJo?=
 =?utf-8?B?SVlmNDIxTkZNaDRvcklTYTd1S1NrTVRRZ2xrVjBud2Ywc0E2amhxaGo5bzhh?=
 =?utf-8?B?NUMrRVBXY1pCcE55RDNtY21Vc0JMVTdZMUlWQjdKbzh6RGtsSU1jR1B5VHp6?=
 =?utf-8?B?YklHc0w4NkNmYVRuZEttb0UybmI4ZHdRcVNidUZrKzlEYml2ajNOcTdlZGpN?=
 =?utf-8?B?TVdjUHUrM3MreWs1RHpqVVBjTW4zV3FkQjcwR3hoQVpIUkxSNVozdkV6MThx?=
 =?utf-8?B?TXFXY1NkWlRFUTZqY0JqaE45UW1KTXAzRVdDZ0VrWmNuMnZWL1dnR28reUR6?=
 =?utf-8?B?cXI3Mlo4aVppVVpQTGd2L2xoeGhVM2E0L0dBQndqdUhBMy90WEJPekc4Qkw0?=
 =?utf-8?B?YVhqMmJJRkZuVE9SQzRVbmtRVDhkU1V4aDUvSEQ4UFhjU3V3eC82K2duZDBF?=
 =?utf-8?B?M05JNXljZHhRd0YwQ0RBT3I2Yk9hSnFDRFdHRkxGRjVTamR5dHFRN0wxWXBB?=
 =?utf-8?B?QVZJY2JuZ0NNZEl1SVVPcW1LcjNHS2hJVFJUODVsOUFWTnhOV1VSQU1LWmFa?=
 =?utf-8?B?b040enRTelNkUUFSL2I0cEQzUjl1ckVYV0pQNkIvbWtpVS9wVTBpT1liR3dZ?=
 =?utf-8?Q?cuFkPBJs9VUnPd4uBbZ55t+A5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1c1df5-5913-4096-1e4e-08dc80fd287c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 23:06:37.4046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6atnWcQz9KvZwzw41x6JJ9G8w2nCScoBqLYzUajOFaWfzJUr0QQ/alJcbdRlerrDCv0nBROx7pyfOFoNBuJmKGor1rL2KzKPebmrUyuRyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7566

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldF0gbmV0OiBkc2E6IG1pY3JvY2hpcDogZml4IEtTWjk0
Nzcgc2V0X2FnZWluZ190aW1lIGZ1bmN0aW9uDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250
ZW50DQo+IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgMjAyNC0wNS0yOCBhdCAxNDozNiAtMDcwMCwg
VHJpc3RyYW0uSGFAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBUcmlzdHJhbSBIYSA8
dHJpc3RyYW0uaGFAbWljcm9jaGlwLmNvbT4NCj4gPg0KPiA+IFRoZSBhZ2luZyBjb3VudCBpcyBu
b3QgYSBzaW1wbGUgMTEtYml0IHZhbHVlIGJ1dCBjb21wcmlzZXMgYSAzLWJpdA0KPiA+IG11bHRp
cGxpZXIgYW5kIGFuIDgtYml0IHNlY29uZCBjb3VudC4gIFRoZSBjb2RlIHRyaWVzIHRvIGZpbmQg
YSBzZXQgb2YNCj4gPiB2YWx1ZXMgd2l0aCByZXN1bHQgY2xvc2UgdG8gdGhlIHNwZWNpZnlpbmcg
dmFsdWUuDQo+ID4NCj4gPiBOb3RlIExBTjkzN1ggaGFzIHNpbWlsYXIgb3BlcmF0aW9uIGJ1dCBw
cm92aWRlcyBhbiBvcHRpb24gdG8gdXNlDQo+ID4gbWlsbGlzZWNvbmQgaW5zdGVhZCBvZiBzZWNv
bmQgc28gdGhlcmUgd2lsbCBiZSBhIHNlcGFyYXRlIGZpeCBpbiB0aGUNCj4gPiBmdXR1cmUuDQo+
ID4NCj4gPiBGaXhlczogMmMxMTlkOTk4MmIxICgibmV0OiBkc2E6IG1pY3JvY2hpcDogYWRkIHRo
ZSBzdXBwb3J0IGZvciBzZXRfYWdlaW5nX3RpbWUiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFRyaXN0
cmFtIEhhIDx0cmlzdHJhbS5oYUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L25ldC9kc2EvbWljcm9jaGlwL2tzejk0NzcuYyAgICAgfCA2NCArKysrKysrKysrKysrKysrKysr
KystLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6OTQ3N19yZWcuaCB8ICAx
IC0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejk0
NzcuYw0KPiBiL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6OTQ3Ny5jDQo+ID4gaW5kZXgg
ZjhhZDc4MzNmNWQ5Li4xYWYxMWFlZTMxMTkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQv
ZHNhL21pY3JvY2hpcC9rc3o5NDc3LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9kc2EvbWljcm9j
aGlwL2tzejk0NzcuYw0KPiA+IEBAIC0xMDk5LDI2ICsxMDk5LDcwIEBAIHZvaWQga3N6OTQ3N19n
ZXRfY2FwcyhzdHJ1Y3Qga3N6X2RldmljZSAqZGV2LCBpbnQNCj4gcG9ydCwNCj4gPiAgaW50IGtz
ejk0Nzdfc2V0X2FnZWluZ190aW1lKHN0cnVjdCBrc3pfZGV2aWNlICpkZXYsIHVuc2lnbmVkIGlu
dCBtc2VjcykNCj4gPiAgew0KPiA+ICAgICAgIHUzMiBzZWNzID0gbXNlY3MgLyAxMDAwOw0KPiA+
ICsgICAgIHU4IGZpcnN0LCBsYXN0LCBtdWx0LCBpOw0KPiA+ICsgICAgIGludCBtaW4sIHJldDsN
Cj4gPiArICAgICBpbnQgZGlmZls4XTsNCj4gPiAgICAgICB1OCB2YWx1ZTsNCj4gPiAgICAgICB1
OCBkYXRhOw0KPiA+IC0gICAgIGludCByZXQ7DQo+ID4NCj4gPiAtICAgICB2YWx1ZSA9IEZJRUxE
X0dFVChTV19BR0VfUEVSSU9EXzdfMF9NLCBzZWNzKTsNCj4gPiArICAgICAvKiBUaGUgYWdpbmcg
dGltZXIgY29tcHJpc2VzIGEgMy1iaXQgbXVsdGlwbGllciBhbmQgYW4gOC1iaXQgc2Vjb25kDQo+
ID4gKyAgICAgICogdmFsdWUuICBFaXRoZXIgb2YgdGhlbSBjYW5ub3QgYmUgemVyby4gIFRoZSBt
YXhpbXVtIHRpbWVyIGlzIHRoZW4NCj4gPiArICAgICAgKiA3ICogMjU1ID0gMTc4NS4NCj4gPiAr
ICAgICAgKi8NCj4gPiArICAgICBpZiAoIXNlY3MpDQo+ID4gKyAgICAgICAgICAgICBzZWNzID0g
MTsNCj4gPg0KPiA+IC0gICAgIHJldCA9IGtzel93cml0ZTgoZGV2LCBSRUdfU1dfTFVFX0NUUkxf
MywgdmFsdWUpOw0KPiA+ICsgICAgIHJldCA9IGtzel9yZWFkOChkZXYsIFJFR19TV19MVUVfQ1RS
TF8wLCAmdmFsdWUpOw0KPiA+ICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+ICAgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4gPg0KPiA+IC0gICAgIGRhdGEgPSBGSUVMRF9HRVQoU1dfQUdFX1BFUklP
RF8xMF84X00sIHNlY3MpOw0KPiA+ICsgICAgIC8qIENoZWNrIHdoZXRoZXIgdGhlcmUgaXMgbmVl
ZCB0byB1cGRhdGUgdGhlIG11bHRpcGxpZXIuICovDQo+ID4gKyAgICAgbXVsdCA9IEZJRUxEX0dF
VChTV19BR0VfQ05UX00sIHZhbHVlKTsNCj4gPiArICAgICBpZiAobXVsdCA+IDApIHsNCj4gPiAr
ICAgICAgICAgICAgIC8qIFRyeSB0byB1c2UgdGhlIHNhbWUgbXVsdGlwbGllciBhbHJlYWR5IGlu
IHRoZSByZWdpc3Rlci4gKi8NCj4gPiArICAgICAgICAgICAgIG1pbiA9IHNlY3MgLyBtdWx0Ow0K
PiA+ICsgICAgICAgICAgICAgaWYgKG1pbiA8PSAweGZmICYmIG1pbiAqIG11bHQgPT0gc2VjcykN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGtzel93cml0ZTgoZGV2LCBSRUdfU1df
TFVFX0NUUkxfMywgbWluKTsNCj4gPiArICAgICB9DQo+ID4NCj4gPiAtICAgICByZXQgPSBrc3pf
cmVhZDgoZGV2LCBSRUdfU1dfTFVFX0NUUkxfMCwgJnZhbHVlKTsNCj4gPiAtICAgICBpZiAocmV0
IDwgMCkNCj4gPiAtICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgLyogUmV0dXJu
IGVycm9yIGlmIHRvbyBsYXJnZS4gKi8NCj4gPiArICAgICBpZiAoc2VjcyA+IDcgKiAweGZmKQ0K
PiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsgICAgIC8qIEZp
bmQgb3V0IHdoaWNoIGNvbWJpbmF0aW9uIG9mIG11bHRpcGxpZXIgKiB2YWx1ZSByZXN1bHRzIGlu
IGEgdGltZXINCj4gPiArICAgICAgKiB2YWx1ZSBjbG9zZSB0byB0aGUgc3BlY2lmaWVkIHRpbWVy
IHZhbHVlLg0KPiA+ICsgICAgICAqLw0KPiA+ICsgICAgIGZpcnN0ID0gKHNlY3MgKyAweGZlKSAv
IDB4ZmY7DQo+ID4gKyAgICAgZm9yIChpID0gZmlyc3Q7IGkgPD0gNzsgaSsrKSB7DQo+ID4gKyAg
ICAgICAgICAgICBtaW4gPSBzZWNzIC8gaTsNCj4gPiArICAgICAgICAgICAgIGRpZmZbaV0gPSBz
ZWNzIC0gaSAqIG1pbjsNCj4gPiArICAgICAgICAgICAgIGlmICghZGlmZltpXSkgew0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBpKys7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiA+ICsgICAgICAgICAgICAgfQ0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgbGFz
dCA9IGk7DQo+ID4gKyAgICAgbWluID0gMHhmZjsNCj4gPiArICAgICBmb3IgKGkgPSBsYXN0IC0g
MTsgaSA+PSBmaXJzdDsgaS0tKSB7DQo+ID4gKyAgICAgICAgICAgICBpZiAoZGlmZltpXSA8IG1p
bikgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBkYXRhID0gaTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgbWluID0gZGlmZltpXTsNCj4gPiArICAgICAgICAgICAgIH0NCj4gPiArICAg
ICAgICAgICAgIGlmICghbWluKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4g
PiArICAgICB9DQo+IA0KPiBJcyB0aGUgYWRkaXRpb25hbCBhY2N1cmFjeSB3b3J0aHkgdGhlIGFk
ZGVkIGNvbXBsZXhpdHkgV1JUOg0KPiANCj4gICAgICAgICBtdWx0ID0gRElWX1JPVU5EX1VQKHNl
Y3MsIDB4ZmYpOw0KPiANCj4gPw0KDQpJIGRvIG5vdCBrbm93IG11Y2ggYWNjdXJhY3kgaXMgZXhw
ZWN0ZWQgb2YgdGhpcyBmdW5jdGlvbi4gIEkgZG8gbm90IGtub3cNCndoZXRoZXIgdXNlcnMgY2Fu
IGVhc2lseSBzcGVjaWZ5IHRoZSBhbW91bnQsIGJ1dCB0aGUgZGVmYXVsdCBpcyAzIHNlY29uZHMN
CndoaWNoIGlzIHRoZSBzYW1lIGFzIHRoZSBoYXJkd2FyZSBkZWZhdWx0IHdoZXJlIHRoZSBtdWx0
aXBsaWVyIGlzIDQgYW5kDQp0aGUgY291bnQgaXMgNzUuICBTbyBtb3N0IG9mIHRoZSB0aW1lIHRo
ZSByZXN0IG9mIHRoZSBjb2RlIHdpbGwgbm90IGJlDQpleGVjdXRlZC4NCg0K

