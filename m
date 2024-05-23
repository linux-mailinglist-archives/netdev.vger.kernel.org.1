Return-Path: <netdev+bounces-97728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9898CCEA5
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76677282398
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 08:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31B613CABE;
	Thu, 23 May 2024 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t71GUt1n";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g5TIRV5Y"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A752EAF9;
	Thu, 23 May 2024 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454419; cv=fail; b=DCRFxiIKG8U1XavDTDVX/qMca7Wze3nkBU8er1rVbbwoUAOvrUSCPge+SP/l+FFHREnvh7O+DIIWsgqQQWYI/ArOtEKx13D4c5KbL0Gmxclkjbzj/70dBXwyI+yvqu8n/ho7GUZsvb1c1Bz5iGvgIaZPKiUIdpUVDvxrhXQJ7A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454419; c=relaxed/simple;
	bh=zX8AvOANyhyjOWkEUNVktURABioA7mOn7vVBs1ThNAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sSADFQOEiERWA7LV0XaX+PbYLQvK9bbbScnMTHIt++NiWmFQthhp7ofsybPrGaMdn3+ujVzTdkUBuHeFFsOs20Q8d4OjfNHAGLHGDAiWpBUws6R3fz8MoBoiSJ2YVYJGJcbpQ4/vxxG84kctFkAC4vFqHgkAfe5bSGkSb4VqbaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t71GUt1n; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=g5TIRV5Y; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716454417; x=1747990417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zX8AvOANyhyjOWkEUNVktURABioA7mOn7vVBs1ThNAo=;
  b=t71GUt1nXkP5AwjEFdtxHf07YIiwc2X5fV7DFDPwPK410hQcfjJ1P3ZA
   Imjvll8QjEv2q+/mPmZri9PUfRFzN6eSIvc2oWYvLUZpR9SDuKH5yBDNf
   1UbZsMG3gJInTilqi2WTcwx1y2ek7lSQthwMNeYb+LqRAasEkZD4QukD9
   T5x93lSkAzUVi1lFLLAbLynGl3SL/0n7na4+sSnhGIBigUAiPCG69Kb3Y
   ARKiv0MoJkRufbDtXL8plcjYu4LRK59jxV9dQBgqOn5M3XJwL+eoBieOS
   8iPAMnbG1UPv3m6I8sk7E6qdQNum9SbunNLFhXQ8ZJjsyZ4/zjaSpb0/6
   g==;
X-CSE-ConnectionGUID: Xhh9N9HpTHqvPe5KHjt7HQ==
X-CSE-MsgGUID: bL+vqNtlRneRycSwiGFXCQ==
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="26483343"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2024 01:53:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 01:51:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 23 May 2024 01:51:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7OjnluxpUAJ0wMFcopz9q4TDMzd0i7Ep/R8kbSki+7ALVp1iSfE8KLL4YiuKkThd6yxOh+KQWqjoIRSoxiFqwyVTGr15Gs+Kkx+bFWqehk/d3xu79bthB4yzfQyLMZVyt1Q+PZpl/tfqK+baeSWkl8IRXuePjeCu31QGEcf27x2wzDWvBTVTrCSzVgyVd/kz+yCzhVhlPUcFB0NyPFlCFIhvzgodsr72KIJJT09W5A4xdzE+8R+B2HRvddGRDqRfkydeDvXlxNZ8Ymo3r50TAWV/ozlE7/6VovEW5qby28vGF162M+GpGIseI5N36qIE6eUi0UNUr6FyEwRAOTIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX8AvOANyhyjOWkEUNVktURABioA7mOn7vVBs1ThNAo=;
 b=avhRknYCvlmjVPKK+EyNZOpKGkIJS9oL1HmIyXgRZSG6r8akOMl7l02LELZPtCucXH1SKdp/NzaaTy0xWt9yqncoQJEw/ONQtSaI4unsmIcJEY0GD6A+WrJ+qao5GnCstmrvK2oSA49EBiPNP8P4JoDgVkS4mcutcKP/yUmwSLNUDEzGm9ajqjOJ8fhsVHgGVpoQL1eI0hKhrSNUH2HJSXhPabQikUmaQqrVnDc2d8EuW9612aRVayNcWslslRk7ZtujyYOWUlGk1ndu4knsmrccBuEOgxm/rqeaGl25Wl3Hihn5TUYToDRQGi53+ueyUWpB+bFAmuOS/dEDSeDKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX8AvOANyhyjOWkEUNVktURABioA7mOn7vVBs1ThNAo=;
 b=g5TIRV5Yv6VEr3zLwCHdc4/HYqdXXlo+q/1bLiUeC+hqcHOT/pCzCEOg8KIt7TwLMu3RqPLO6P9TbdudSRdzCTAwxONHoB3qfhdSynnde1AUBKwerJDVrJ+TxfzNJ7vpEfqUK8tR0rVjG6tcIQorL9RSm+rLozS/rXKAueoPxReOTI9h5PRNgdBQ6MAglYo9Ef5wrZjzVbBfKQXsIWZpVi9t3iq4p0xZxs95eoXHNsOl+ehVXtGSfY8opxO4bbemKVRaNeouGGuTEnN0m1/uqU5RdPbg/rhRychmBTUlsdLV50aERAU3GwKDmXxs63JoSLctI7QzG/ht/qruAXoLFQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 08:51:54 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 08:51:54 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <steve.glendinning@shawell.net>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Thread-Topic: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Thread-Index: AQHarFGdKs4gtKjRMUij/lf1SheVtbGjdfUAgAEOQ4A=
Date: Thu, 23 May 2024 08:51:54 +0000
Message-ID: <f41c1acd-642a-4449-a03c-1ba699bd8441@microchip.com>
References: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>
 <9c19e0a1-b65c-416a-833c-1a4c3b63fa2f@lunn.ch>
In-Reply-To: <9c19e0a1-b65c-416a-833c-1a4c3b63fa2f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW4PR11MB6738:EE_
x-ms-office365-filtering-correlation-id: 124964e9-c76d-4cfd-15df-08dc7b05988d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?OWkvWmQ2Nm13WjljdldTVjl3RW1UVE10azFsOGNqaFYydWw4UVhiTnJ6c1Fp?=
 =?utf-8?B?Y1NQVXBDWGdhaFJRRVhlc1hqRHlNUERTQTRSb0w1V3hkY25EOWs3QnhUaGVQ?=
 =?utf-8?B?MFJqNE0yV3VDMVg1V0s4YzRZWmFvWithNmxzaytlaUs3UWc2SFdRUWR6cWdi?=
 =?utf-8?B?UFlubE5yMGtFVmMyYnRKQmNYUGJ5UUNzQ2txWEhhV2ZTSVdoYTkyZGhGWDZm?=
 =?utf-8?B?c1N2QWxjRXhRSmMzUVNCYkIxVVRjQUpJcC9Vc3RXKzdob0hZbW5sWndHajlU?=
 =?utf-8?B?NlZLL2FtYmVSSEhoZCs5dWJrdnEwUG9ZRUhOQk14SHN0djRMa0xjOUFPY0FR?=
 =?utf-8?B?SGk4VVpVUXE3TlNPaUdzQVlVaXRRT1VDVnBteFBaaTkrQ3NMWXZ3NHdlK3dG?=
 =?utf-8?B?OGhKNFNyUkhKZEcxKzBTMUoxaEZOck5ybXVUdFk0cXpuOHJjQ05KMUFMZkk4?=
 =?utf-8?B?NHhzTHp4WTNUZXJ0c0hmQ3JqOGZBWFRNRmVrTnZXdEV5ZmV6Y25QQUwyZndY?=
 =?utf-8?B?UklMcllWMzNTRUtLY2VpSVdKMEhqaWdlUnNoenBpVFBoSDZZUVc5MUVFL3pX?=
 =?utf-8?B?dFl6cW9uaHBwSXdtaVBRemlRTmNHT2M4TFhjc0ZpUjR6R0d0elVqR2Fjcysy?=
 =?utf-8?B?ZVI1UVVxbGx1ZXptT2lENS8rQkwrV2c3cEtQMGFaVnBsbE5tcHAvU2x3TkJH?=
 =?utf-8?B?ZnZuWjkvb3I0NDRHYk9jRE5uRHdkdE9neE5BcGJJbXczZVVsTmtydDRTTDE5?=
 =?utf-8?B?TXNvNFArbUpMNlhmc0JGNmJjWnlnSWk3NklsMG1LV0RMelNKYVFZUE01SUVm?=
 =?utf-8?B?bzVRbHhnMVcvNWhLaGJNTXRSQ0l2d01sMFRraW9QYVNjQUoxdkRzbTl0Ylhj?=
 =?utf-8?B?Y2hFaWY1Mk5pL0lzRUpwY0YwWkNUWk04NTRHOWZRUnl6MytydjRjakliK0hi?=
 =?utf-8?B?MlJtNEhiRHBsdElqdGxZWnM2Wk5mK0xWcGMyY2FXVU5XMW1PU2FVRnlVOFpB?=
 =?utf-8?B?bmJtNmhwdE84WWx0WllBeEN4WHJCMzNxMHExT01hNXFDOVFYblZCTldCL05S?=
 =?utf-8?B?STl6dW5zWGIwM3c3NkprV05YRXNQS1lCQ3J3bXFUeFdkVHNPU3VEamF4QVZ4?=
 =?utf-8?B?eitFcmhqSW5xU3ZHc09mTGtIc3k0SlBVQ2x3c2xhdXBwb2JCZmVaUFYvZ0VC?=
 =?utf-8?B?dWpHaEdRcWhId1JTOEdaVTRRbnJYckZLelJjYjRSS1JCWEgrSndIOHFyTXQ1?=
 =?utf-8?B?VjhxbVc5eFkyTGZVYlZubUFWT2REenJNcFcyeFBIYjQ4V01XcHFMMGxuNEZH?=
 =?utf-8?B?ZlI2RjlPQU5IT1plZS81RFJ1L3p4WjJVZkNWL2xNL2d6cUEyYys5c2xOMTRy?=
 =?utf-8?B?ckU2WTF0U21QTWpDaTFpUjZkZWxCSFBZVDV6eG1vOVFqNWQ5elBpbDFXL0dG?=
 =?utf-8?B?M2wvS3hPbGE0V0pOajlyMkRDWmpxNXhFVnB5SkRza01NNFU1UmJ6V1hJK3d3?=
 =?utf-8?B?Mm1vOER4UE5QWjhDU2FhNEs5dXR5S20vVjVydW5vZDNTTk9MRFRyRUtHQ0l2?=
 =?utf-8?B?N0JIWmFLZ0xJUmF5elZaTXcrTnRrbHB5ZGNUa0pHaU4zdGxOUzJ4VUJLUHl4?=
 =?utf-8?B?NlZLMlYyQ3FKQzJPbHNFd3ZzUmF0YkpjQzQ1bjFZMHpWSk03KzJRZlYrYnE2?=
 =?utf-8?B?SHRtdWdFdDRsanBLZTFmVmhPbW5sa1FtbjQyRFlJdGlkSGN3UHA4V1d1N0Vu?=
 =?utf-8?B?Tm9xRkI1bTBXS1dFSVJGVmdwMmlza0R6ckVwK00rVlB0dWFiT1lVMUY5TEw1?=
 =?utf-8?B?cFQxZWZJUEtJVjV4NnA4Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEpCVDQyVnN3NUJGNFY3dTFMTUVIc1NVVWhnSVFmcmR4QVhWSDFzYmMwazhq?=
 =?utf-8?B?S1EzMDFyc2tBVjM0Z1UvcGk3ZHVxbkxROTFFd0U4ZVRuMVpPMVhobzM3aXhN?=
 =?utf-8?B?N1VFbUlnbGF6VzNCejBjNnhnRkxiU0c5NHRyQ1JKb2s4KzRCdWZwMWIybmo1?=
 =?utf-8?B?R3g5SHZPYU0yVzR2SnNOeHJqQkRCbzRQVXkwVEsyY2pzdEl0MEM3Zkg4OFZ2?=
 =?utf-8?B?UWQvR2ttR0hNU2s1T1Rab2pTemdmOGpRcUMwSlFYTVRQNU9BUjFoNlFQTXV1?=
 =?utf-8?B?ZzdNL1E4MEJSd1VwVXZNWjB0dFlpRm1CS3E4MVpab3RwSFRNYVpTSm1NZ2pB?=
 =?utf-8?B?UkwxeWlpZEFqeUNHdUtSMUZrZWltUm4yTHZKLzcrakZrU1h0UEdIdGJBOU41?=
 =?utf-8?B?eGtKSkc3aGlGNkNiUWpOVWpGcUJGaG1BdE5lblNCVUlnQTFSU3ZrczB1TjMr?=
 =?utf-8?B?UjdjTjBmRklqa25hWjFUT05IOHNONktzcmhIaHYraVF0VW5wZTdSSHduQzFn?=
 =?utf-8?B?ZTJ4Q3pYK0o0anZuUVE1SVFGNC8vaWJGVUJtU0hiZFY3aFpEdU9wZ1B5RldG?=
 =?utf-8?B?RUxiK25TWmt3NEdudEVUYkM2QWk0Q3FPOVVBT2RjYXdYeHJZTUNjclBvdU1X?=
 =?utf-8?B?Z2hLNlZJdnVCVjArMm1OMGJqT2NwS0VqMnBQcDYzdS93SHV3SjNFVWtKTGVn?=
 =?utf-8?B?WDlnNlY2WUFGRDNQNWtaR2RJTmhTOTVZUnI2Q1dtZHBXb2tzelliTS9JRmlS?=
 =?utf-8?B?TlVNTXdYT1AwR2lTSlR2b0NNSUVEUFZSY3VoTnIrSXFtMHdsWStHejNXeDVY?=
 =?utf-8?B?bGVDL3J5dFh3RzdLS2xabFhseXVuWTdaNWhNWi9YUUhCcktTRXlLVklSZkJl?=
 =?utf-8?B?REx6S1NUU3M5azlRSURHdUpjd3NvUFl6c2FOaWYrUERoVHp1eVRPUjdNQ1l5?=
 =?utf-8?B?RVVXMCtjOEZNSUZnbDcvclhWV3dCa1ZjOFllWnR0MEFoUW1IclJmNExHT2J6?=
 =?utf-8?B?Qlk0emJETVdheFgvOHAyUFMraWpQcmtua29LRk1qQUN1Y0VFM3lkRklOamtE?=
 =?utf-8?B?WS9kbWl3SVVNNVhBb0hHODEvVmh0aVZVRzFwWVA2bG0yWHV0aUVzTjNualJi?=
 =?utf-8?B?b21WeDZwc3k2Zjd0OHhUUmZpdjNLRTZFbkY0QXRUNHRLRDFtbjBBRHVBbzR0?=
 =?utf-8?B?OXRlRTh0OU5PS3RvdXJIbXg0UkJoVXMzN2gwRzNnbTl2NGhRRVRnTldVV1NU?=
 =?utf-8?B?cXord29Ea2ZIS2kxVkRjaURFRlNjTUFIVGpyaVdpekY0bkxUSlJsdTlmUFB0?=
 =?utf-8?B?MmgxTUlqMGNpVGs5eTVnbHJ4NHA1V0dPMkFPRG5BMUx1bHRISERXeDJrQ1Vs?=
 =?utf-8?B?SkRLYTFLSnNXUFo2VllDZkJVbWpYYWNMVi8vSHRlcUtBNlVjL2ZJSEVxYklI?=
 =?utf-8?B?MU1yYWNCZ3BwNEFFd2pGaWFZdVVadFN3VjFhNmpOa1JWR0VJTWFoUUJ5MlYr?=
 =?utf-8?B?dEFQRUtvVFhOWW44QisyMDlQeUJhYlF2N2oxY2NGTTdLQU5oU1Z2cGM2eDk1?=
 =?utf-8?B?YXE2SEdnTEZhd2tnaFJsYXFENG55SEN5czl0cXF6ZW5vazlnZitOY1pldldU?=
 =?utf-8?B?TlkxdHlQYndQM1piSjZvZHBTRFIyb09yMUtVU09zcmZqZjdUNW9NQWxRQWNL?=
 =?utf-8?B?VEJVNEFGV2t0RElTZmVoZk1tczQzekoxQXNObkhVUE9vM2U5S29kVC9GK0Vv?=
 =?utf-8?B?cHcvN2pwNXFqZmFWR3ZZbkNxY2RYd3BOZ3FoQ1lLQ2FKUFZqdGliNWR4ajNP?=
 =?utf-8?B?bHNMNkRUSzErMUh2QytxNEdnZUVpdTZEdjVKZisxMGEwNzJVV1VyRmtQK0Fo?=
 =?utf-8?B?djZ0dzQrbjBCVFBndzBLaFBsamNLcVBkS0NrdUR3R2xOQ0Uva2lUNWIxK0xB?=
 =?utf-8?B?SmgxOStmb2pvOFpRc1dNSTEvbWRna014ZU0vVHA0N09Qd3hGTDBZTllxWFBs?=
 =?utf-8?B?aFh6R3lGblNtNzVHM2ZnRGFVekhjQXp0b09KUzFzN2RBMjllVkRXUGF6bmsy?=
 =?utf-8?B?eWlXTG1weks1U25Pb1pDVGs2UEtiRjFiRTBFWk5OL3FZTHAzcWJ3eFVhTXRH?=
 =?utf-8?B?d2VsYUpreXJIRHRhbVhGVzIxUmEraEo2RzAxZTdmZm1ZMzAxd1lMV2xtMk5h?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0957732B25F35942A983001FAB6A752E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124964e9-c76d-4cfd-15df-08dc7b05988d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 08:51:54.3922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ursJ8nYncrCvK+ZccUxcvjJExc6K62P6iHo1DyOGFfw7aOLG+tTkaFC8/Ywlo8hUqOjOfiZuW220XI1kcSJd/iTqvS5twVsu4nWXGNDk4LMSisEiDQe5I3r1Z1YnIJI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6738

SGkgQW5kcmV3LA0KDQpPbiAyMi8wNS8yNCAxMDoxNCBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gV2VkLCBNYXkgMjIs
IDIwMjQgYXQgMDc6Mzg6MTdQTSArMDUzMCwgUGFydGhpYmFuIFZlZXJhc29vcmFuIHdyb3RlOg0K
Pj4gQnkgZGVmYXVsdCwgTEFOOTUwMEEgY29uZmlndXJlcyB0aGUgZXh0ZXJuYWwgTEVEcyB0byB0
aGUgYmVsb3cgZnVuY3Rpb24uDQo+PiBuU1BEX0xFRCAtPiBTcGVlZCBJbmRpY2F0b3INCj4+IG5M
TktBX0xFRCAtPiBMaW5rIGFuZCBBY3Rpdml0eSBJbmRpY2F0b3INCj4+IG5GRFhfTEVEIC0+IEZ1
bGwgRHVwbGV4IExpbmsgSW5kaWNhdG9yDQo+Pg0KPj4gQnV0LCBFVkItTEFOODY3MC1VU0IgdXNl
cyB0aGUgYmVsb3cgZXh0ZXJuYWwgTEVEcyBmdW5jdGlvbiB3aGljaCBjYW4gYmUNCj4+IGVuYWJs
ZWQgYnkgd3JpdGluZyAxIHRvIHRoZSBMRUQgU2VsZWN0IChMRURfU0VMKSBiaXQgaW4gdGhlIExB
Tjk1MDBBLg0KPj4gblNQRF9MRUQgLT4gU3BlZWQgSW5kaWNhdG9yDQo+PiBuTE5LQV9MRUQgLT4g
TGluayBJbmRpY2F0b3INCj4+IG5GRFhfTEVEIC0+IEFjdGl2aXR5IEluZGljYXRvcg0KPiANCj4g
V2hhdCBlbHNlIGNhbiB0aGUgTEVEcyBpbmRpY2F0ZT8NClRoZXJlIGlzIG5vIG90aGVyIGluZGlj
YXRpb25zLg0KPiANCj4+ICsgICAgIC8qIFNldCBMRUQgU2VsZWN0IChMRURfU0VMKSBiaXQgZm9y
IHRoZSBleHRlcm5hbCBMRUQgcGlucyBmdW5jdGlvbmFsaXR5DQo+PiArICAgICAgKiBpbiB0aGUg
TWljcm9jaGlwJ3MgRVZCLUxBTjg2NzAtVVNCIDEwQkFTRS1UMVMgRXRoZXJuZXQgZGV2aWNlIHdo
aWNoDQo+IA0KPiBJcyB0aGlzIGEgZnVuY3Rpb24gb2YgdGhlIFVTQiBkb25nbGU/IE9yIGEgZnVu
Y3Rpb24gb2YgdGhlIFBIWT8NCkl0IGlzIHRoZSBmdW5jdGlvbiBvZiBVU0IgZG9uZ2xlLg0KDQpT
b3JyeSBBbmRyZXcsIEkgYW0gbm90IGdvaW5nIHRvIHByb2NlZWQgZnVydGhlciB3aXRoIHRoaXMg
cGF0Y2ggYXMgDQpXb29qdW5nIHBvaW50ZWQgb3V0IEVFUFJPTSBhcHByb2FjaCBjYW4gYmUgdXNl
ZCBpbnN0ZWFkIG9mIHVwZGF0aW5nIHRoZSANCmRyaXZlci4gSSB0cmllZCB0aGF0IGFzIHdlbGwu
IFNvIHBsZWFzZSBkaXNjYXJkIHRoaXMgcGF0Y2guIEJ1dCB0aGUgDQpFRVBST00gYXBwcm9hY2gg
bWVudGlvbmVkIGJ5IFdvb2p1bmcgaXMgbmVlZGVkIGEgZml4IGluIHRoZSBkcml2ZXIgdG8gDQp3
b3JrIHByb3Blcmx5LiBJIHdpbGwgc2VuZCBvdXQgdGhhdCBmaXggcGF0Y2ggc2VwYXJhdGVseS4g
UGxlYXNlIHJldmlldyBpdC4NCg0KVGhhbmtzIGZvciB5b3VyIHVuZGVyc3RhbmRpbmcuDQoNCkJl
c3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgICAgICBBbmRyZXcNCg0K

