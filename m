Return-Path: <netdev+bounces-113499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E5093ED29
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 08:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4AD1F217C4
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 06:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F64184A31;
	Mon, 29 Jul 2024 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mdR6cxpl";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="G9L/El+I"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E7983CD9;
	Mon, 29 Jul 2024 06:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233231; cv=fail; b=aoyXGY9mf1V3jqSGfeyLGXwQ62TyS4ULKwjIWSkSMQsGnLhQEvV4dJ2m47zUTElSekfYSWApe8QbPr1qcD6PfsSzLPEt1h2XU2pfrpeUAqEsfj/L/Db8EmofbnAz5sEsSmwsIijwqaz3CbZUR9g6C3FAB0w4jCBVZ0DFMPnkfbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233231; c=relaxed/simple;
	bh=NONmiVnsCZb0zBpwb8+eyFRyd8ZXAM/qNgY5FIpMC+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JG8w9Oz4m9CjUt0oUFgO4gyTpf6frjjJ+IwOV95lBZFoIhxz981wqfhr02akU7OhO1v8IAjpB2qSJF58aTXZjh+UXTQh5ZUwV0E8e1qkVrMAjM809i75Y66f7MB1Y2xXUmyPPk2PEaofd4/8oL6dZiOyWoLnTqCvlsfpzv1nPZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mdR6cxpl; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=G9L/El+I; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722233229; x=1753769229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NONmiVnsCZb0zBpwb8+eyFRyd8ZXAM/qNgY5FIpMC+Q=;
  b=mdR6cxplfnEMwD62jPv0bVPBcu25GUX5fKnVyPR2YqUN7+qvVJnB6z6n
   xQYMk9LNlsAsew2bJmz0m7kOv03SqKXv9zKr7mydHkJinGj54ZnyVh8bi
   T5xk0A6bfGVH61U2wuDXXvJur/5tAOqNpMOpXTWJpTgR5Ci5y4ru5JRQS
   8L9SjhOpqCHjsEcP5VH89r2+/oWOjHqjTjNw9QRG017WQEhl6OuAfr24D
   Jmi/AilaRLphlDO20hHuXOzDSzB2iB8VFGMa3Jdeh3IyW1LvFRz8SA19Q
   bQPI9scosAwivKgdFTeloI5ETNmZQ4pCwkiMjQJI6VYeWBOxJqi8noO+e
   g==;
X-CSE-ConnectionGUID: 6aS8UBuJRbu4WyzCqa4fXw==
X-CSE-MsgGUID: UtvhpV3iRKaWC1IEmTKujg==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="32594727"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 23:07:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jul 2024 23:06:50 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jul 2024 23:06:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ML9Y5deMEumNIJoi+9fSIjBodwWrJXrfCFy5Y7YKK+gBuFoqxTYkhqEzgfUdG3y/ARnDmRJOHfa7J6HtOV1sV0p51VnfRAkPZi8PGv+/dVIoi+6bHmeGMRtJEEYDUwJcNDBTPjLECjX/O/5kJUQXp1AviNthRww8qVAyIZchETvPxrq/XHJHx7MITMauO1CUT6WeR4K58PoUse/90y+nt0lYwPtY/lK0tK9l/vD59j2OSK7DHIRSLmP00PWcfH013ITvR3v3vETPX7NxFrAtLyGZDEo8yJaZp87Hl/qzXaDdPxh4pZTXv/HRUr3U1pT7IZ1PGYGcfDKDRikz9ZvHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NONmiVnsCZb0zBpwb8+eyFRyd8ZXAM/qNgY5FIpMC+Q=;
 b=IQFms36sadAxKnRvsbc3whEUjaO2W3e92uKYzLmxieaRj+RFPuwvr0V7OHpXJAFTykucdssfhhXINs8ysqoO0JtzKgUYVOfV6RjJKPsikAsTkkVUL3H0gc+fZe/hhMc5wJnycBRbfpfJXMEDPt1kZEE/rvbloHmzcL/XAXZhCEaRuIpM01fSgnQ+Df/nbEmfBu5v/70WpcrNmgRErzScX758Kx7+9cono8OtETvIBA7rEfDZJHnp7w42S+NHr69CTdsucmvcZfaa1TkMDXx2Y6spVsD9ZqbB7BSRVTnNc88fKwxgXFoy1CB2Aey8DsOcbVTmbYb/f8c4BvVgL6k0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NONmiVnsCZb0zBpwb8+eyFRyd8ZXAM/qNgY5FIpMC+Q=;
 b=G9L/El+I2CF767WnvX7DoOycENsE4zNdaxa6Vok13HxuH6H/cx73QaKqkI4FbnhFKecg5LTpv9Keu/TaGIO9WiXYodGEGZ2U9+7n6zadkGjwwugStio9E0pUWhUb3hUboNk73pwfKq5sb8tmmymfRenR1O0hSIM/omU/ZW0t9YJQqziN8z0yrJ1sum8olSkkBIZfY/gkrdKoVBO+VEr99cV9Z33Fk8hpeRzwUcM90TAeoW+HtuHyVtNzNsNyUfZ0ylp4cF38i92eQ3M+xy524gDEPP1jL2jSet09PNz5ClOeHQzzsWOBC+xOBFNg3HK0ynmDp+r2hAgyIhqaT8ahdg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CO1PR11MB5170.namprd11.prod.outlook.com (2603:10b6:303:91::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 06:06:47 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7784.017; Mon, 29 Jul 2024
 06:06:47 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <horms@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>, <linux@bigler.io>
Subject: Re: [PATCH net-next v5 00/14] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Topic: [PATCH net-next v5 00/14] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: AQHa31jFXlKWMWGDGUa0Oj8yXMC/k7IJMfyAgAKL+YCAAX6NgA==
Date: Mon, 29 Jul 2024 06:06:46 +0000
Message-ID: <e3486269-d0b0-41fd-8090-3e7f6022f3ac@microchip.com>
References: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>
 <20240726162451.GR97837@kernel.org> <20240728071821.GC1625564@kernel.org>
In-Reply-To: <20240728071821.GC1625564@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CO1PR11MB5170:EE_
x-ms-office365-filtering-correlation-id: 9e14de29-f711-4c6e-5d64-08dcaf94a0f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eEdLenlDL3ZUeWhVTW82MnkrcmY2TTgvbWIvWFZHZ25uVUtpUDVXcUxUNW4x?=
 =?utf-8?B?bjJSZWFZckhISWNtY3dKaEdaQjVmZnVFa2Z4NzdBRS9pM3VmN2dXeTJEcXZR?=
 =?utf-8?B?U3dnOWJzMUl0aGU4SjJmd2JFQWxwWnhzbmJlOFRHK00vUldNa0huM2FFcDJu?=
 =?utf-8?B?LzhvNG12ZThua2N5a0IwM2pXYnp0S2F6RGJRSDBPMTdsMG5rUWQrTENSMUkv?=
 =?utf-8?B?SXNqN1NTM3BHd0FYUHJ6cEUyR3JsZjdxU0RPUTN6Qnl0M3RQa1dUNFR5TGhi?=
 =?utf-8?B?RXBUQjlmV0FLRWZSckwxQzlnWmYrNnU1c3c1UmxTRFE4cUJKcklPdEd2K0ZK?=
 =?utf-8?B?QWdCT3poRmNUa3FvWHpONW1rSThuc2l3Rk5RV0NhY0FDZmhwaXJBU2MxQ2ZD?=
 =?utf-8?B?Q0pJZ3RIWjIrUDRKOXMzSXQvNEc2V01XenZiQm15R2FpMEttaUFhT3E1VGJD?=
 =?utf-8?B?R0NnaFBSMXR6ZUNFaUQzN1FMM2ZUamF3KzJqaWJZZTJiZ2dDUERUalg4ejY3?=
 =?utf-8?B?eEJUWDJySFNWOEQ4V3hHSGI0emhwdlhJMDh0RkxIb1hDNkJlbkZyaDJhZUFV?=
 =?utf-8?B?V3A5T1hlMExqalF5MVl4cTNZelIxR05QdzBxYkZESThwUzZ0eXZhdGppNnYy?=
 =?utf-8?B?cjVpbmZUTHpuZThMaWV1YVhHZFhaRjVEbCt4dUVBMlMycnZiU2R5U25mcFpP?=
 =?utf-8?B?ek1tdWw0eXBvRzBMU0NhMGVleittb1lIZnE4ZnBFZWNHNVFYR0VPdTFMc3Nw?=
 =?utf-8?B?MzEwTjBwZUczeWFKTXZYMTRUODVxSlpNZmNENDJ0VllRTlh3a0NzVlRVcjhi?=
 =?utf-8?B?QS81dGE2T0h6VG9pL1lTeTBYYnI1QzY1cmFvOXdMTW82QUFUUTBFNVZLVk41?=
 =?utf-8?B?YlgraVFkamVoMnpRVXh2MUR3Y3AyUDNGbklsUmptL0JJazhxMVNxL2R6OWx0?=
 =?utf-8?B?RjhGS0lqUk5SWmFlUDY5bkQxZ0NWdXdtdy9Ec1RXSlBVdTFlV1dEbGlSRGEw?=
 =?utf-8?B?TVpXZ0Z1bExHUWkwMEtucUhjTTZzeThVVXZ0OVV5dzdhbHFDTWFJNi9hTzND?=
 =?utf-8?B?ZE9WNFoybDVLQ3ZjcStOTlFuSmpjTTViaDZOQm9UaThvWXQ2YnFzUkJ1eXdk?=
 =?utf-8?B?Y3Rocll3K1RadllVaW5lVnpSNHBMTkpQeEpVMC9rNHpMWGU1U2laazI5TSt6?=
 =?utf-8?B?UlpJY1hlOXhQa2dNcloyWE51TE1xcy8vVjVOVTJWSUNFT2VBVGZGSU9mczIw?=
 =?utf-8?B?SXltMVJNQVhHbG80WHVaYVpjcXpSV1hwazJrb3BBMXJiVzBCRlpiRzZ0UFIw?=
 =?utf-8?B?TWFkWGRPSkhyZmxEZzV2MnBRTjdHNmRxRlYvNGhENUlEWTkrVll6UzVtdVF1?=
 =?utf-8?B?TDJYbDROTDZCSVFsZEhWZnNrNGhOd0hvVkh1UzZTbE5VNFA0NXQ5VkttNTBs?=
 =?utf-8?B?SDJjcmIvYnlicHBrbm9pWGhVaVlUb0dmM0pTcCtiMnNlMEl6Z2JtV3JHaHY4?=
 =?utf-8?B?WDJrMlhZQ29EckdGZWlyUkpJVjhuLzhLSzBXbkVsQnlaQVIzWUNnV1dZZTRZ?=
 =?utf-8?B?M2dYUDJGQmM3VngwemplWTJrQU4vVDZHa2xjQzZBQk5BQXZrdnZWSU1TK2tT?=
 =?utf-8?B?UzhWbVVWOGJXZU9WYXNQUW13QjN5WmNUNmlsUTFWUnA5MDFTV0c5VzVqSFB2?=
 =?utf-8?B?YldmbjcycHZoNWNYOHdMcmxwcHQ4Q3dHV1ZIVkdpbTBVNUQxZ24vNnRtVEM1?=
 =?utf-8?B?T3plR2FqRm1OeXlkcjJ1OXQ4RXhCYng0SUNCUjFQNGhYTGhrTENjdHhocTZQ?=
 =?utf-8?Q?/Dyf7xe9/8fKuHcsWxnE7KJxNTNmkLuIUvBro=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFM0ZS9ZUlNTMWdiSUV6RzBPNEYwQzBqbXBUbnp6aVVlMUJGUjIwZXFVQXpT?=
 =?utf-8?B?dWd6MU8vNVQzOW80RGEzODF1ZFpRUDkzQTFCb2R4Z1RSNlh5K3l0TGhQNGlt?=
 =?utf-8?B?d0lSUGN0dnZ5UEpqUG5rc3VmUnlVdUlRUnQxQXdUS2Z5UWd0UnlWVGx4U25z?=
 =?utf-8?B?MjhIamFmUVZJazNnOHZFck1YRnliRC9rTzJvNXFMMU1mZHhCekNDZG53MVpE?=
 =?utf-8?B?Nml4c0pEN3FzRi96Q1U0djJSRTlHWDJhdi9iNkg2Y1IxTjJ6ZGdoR054Tisw?=
 =?utf-8?B?Rkl1MGVBRnh0OTNRMlJTM0JQSHVnNXhPY3AyRTM0KzIyNkR0QjRvQ2JvcnV6?=
 =?utf-8?B?LzZyRlROL2FveVdLcU1pRW1PWHN6L0ZWczhLYU1MdmZxcGd4TmVRb3N5bzBq?=
 =?utf-8?B?dEJPVFIvN3hFeWtuYk11Q0ZacFQxaUxwTlo4VnNBY2JQOVVkWXZ4d1UxaUJm?=
 =?utf-8?B?dXFDaGdhVnlaVERHYkZETStEcUNTczNWSHpUTnUzM21Od0hJN1E4NnQvZ0tB?=
 =?utf-8?B?M2o1ZmE2SVBNM3I3QVNLMVZSYm5pelgxb0s3WjhhTjl1L3g3emdob3BSbjA3?=
 =?utf-8?B?cTRxaHEvQ1RQa0NoVy9LQXVVMnV0NXZsWmJNMkVvV29hWnBXQThHbkt0NDUw?=
 =?utf-8?B?VFVSU1lNaUJ6K0pHcEczUzYzcmlya01GYzRIWlJhTTJURHFWUEtJWGZiOWM0?=
 =?utf-8?B?ZFZ0eWJmcXZyTDdrMXowVVVBRGFtSGZ0RUt4aG9GcnpxaWN5RDNQQndnTXhK?=
 =?utf-8?B?MDJpb2hYVXdmc3MxaWtwamJxd1YvbDZoclJNSmZwaVI2ZW02V01zaU5ZeDYw?=
 =?utf-8?B?bG13MDl1Z2ZRUGJnVmpqaExjbENlNXc3MWtuYTZzZ0UxRXhnOG1OcjAxTi9k?=
 =?utf-8?B?akxsZVZDVzFvdzFkOG9STHhKVnRXVHIrV0Z1OHh4NWZCUUtjZk1kMFZnazlk?=
 =?utf-8?B?dnhxQ2hhbDhEY2puWmVXeUVMOEEycUlkd0pxTFpMUVdpS29VNEpHQlRJQmdM?=
 =?utf-8?B?VkREeEpLeVV4dHJaVEV5bGlxQW5NVzk4cHVPYUFUU0orK29lYVI3V3JhN041?=
 =?utf-8?B?dndjbHgzSnJ3V21TQ3cyU1RFNHhMVElCcUY2U2poRStJYVkybUYrVG8xTXVE?=
 =?utf-8?B?MUZvMjFsR1BlMldMbU1pTkpkYWlYRE5KTXEzT25WbGw4YnRXYnB6QWNOVlox?=
 =?utf-8?B?UEN1ampBR0RkcStuM2dZVVhYOERXaTlSRlo4LzlwbXNMT0VnK2FXcHBsVmF4?=
 =?utf-8?B?ZCtYZXo0TXlEdURYQ3I2bE91REs2dFl2WnFBZTBJNkhJVDlUK09tK1dRMW9q?=
 =?utf-8?B?Tm5BRVppVlNUY2tJQVhXeUU5OVRhdndROW9LSG1LTTJrZ2owTTlpbXZBT1hu?=
 =?utf-8?B?Y2puYzFZMkNOTFhvTXhvVUErcVNqcW1nYmtuVDJXcDQyNjMzMVhSUHRzdkIx?=
 =?utf-8?B?YWlvc0gwUHB5WExUMmQyZDZETE5MckpISFhOMEhIZ3VzS1ZEaTNpTW1qZ1Qw?=
 =?utf-8?B?ajRqazBlNEtpTjdrWitqOFFrRXpETVkxQjNpbkw3Um5Oc1grVmdDTWNvTVpx?=
 =?utf-8?B?QmhYajAzWGpSS2ZvbHF1ZlEreWtWS2VyZ2RPQmJ6ejhtc0h2Rld2UjV6QjFZ?=
 =?utf-8?B?UXk5ZmY1SlZvYUNpRklQeXB4blAxM2JBQ1dsM0JWWXRXNWE2MzVNRGpzc1Ny?=
 =?utf-8?B?U0ZiaVhWVkpmV1NCVFNXTlpYdUIwdVRSZXh6Ymd1bmNFRXUzM09id24zNDVM?=
 =?utf-8?B?aEI1elhyVGs5Z1FXeTJlTFQxb2E3RklqRnNJQ3E0SFRPRnhtc1B2VFZjUkdo?=
 =?utf-8?B?ODZ6MXhFMlFQR0dWTjB0QzM0NG9vcDIzekVhV1dvQXcxL2llZjQvNWpsdG1Q?=
 =?utf-8?B?SUdKWnJUSFovUEJDMzhjN2JkeEVIR0JhV2Zac1F2QWdvQW1hNFgwMDRsTm4w?=
 =?utf-8?B?bDkwMTRDRDZZeEZ1MDB2SUdITmhFUXgyRUQxN3ZqMTVnb3I2VE5JY2I2L2hx?=
 =?utf-8?B?aTk3NTl3Y2UyME5YTTQrUWo2RlBuRzN3a2ZxcFkraVJVcnJrM0NCd0FMaEhP?=
 =?utf-8?B?TzVvNml3NnVmL3Y0VllPaUExUHlzRmJvcFFKazRMMWJDQ1hhbEkvazdMeWdV?=
 =?utf-8?B?R2Z3N2lldWhiMGtMOGxOUUI5US92NGV4ZVFoOGVORDhnZ1VkRWZFRFcveUJp?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <877D63F4F06965498817C02B09726841@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e14de29-f711-4c6e-5d64-08dcaf94a0f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 06:06:46.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wafIg5u6/5oehWfJoNPpuo+79bXb7TLP4qPMOYBE4AlMn+cO50p7Dv7Ct6TTZnqqRtH8498TYic+lyj9AsgOMOVvOy4ksAW5RAdKZQynog42+0cIxtykuOQoQhTZfHmL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5170

SGkgU2ltb24sDQoNCk9uIDI4LzA3LzI0IDEyOjQ4IHBtLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gRnJpLCBKdWwgMjYs
IDIwMjQgYXQgMDU6MjQ6NTFQTSArMDEwMCwgU2ltb24gSG9ybWFuIHdyb3RlOg0KPj4gT24gRnJp
LCBKdWwgMjYsIDIwMjQgYXQgMDY6MDg6NTNQTSArMDUzMCwgUGFydGhpYmFuIFZlZXJhc29vcmFu
IHdyb3RlOg0KPj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGNvbnRhaW4gdGhlIGJlbG93IHVwZGF0ZXMs
DQo+Pj4gLSBBZGRzIHN1cHBvcnQgZm9yIE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQxeCBNQUNQSFkg
U2VyaWFsIEludGVyZmFjZSBpbiB0aGUNCj4+PiAgICBuZXQvZXRoZXJuZXQvb2FfdGM2LmMuDQo+
Pj4gICAgTGluayB0byB0aGUgc3BlYzoNCj4+PiAgICAtLS0tLS0tLS0tLS0tLS0tLQ0KPj4+ICAg
IGh0dHBzOi8vb3BlbnNpZy5vcmcvZG93bmxvYWQvZG9jdW1lbnQvT1BFTl9BbGxpYW5jZV8xMEJB
U0VUMXhfTUFDLVBIWV9TZXJpYWxfSW50ZXJmYWNlX1YxLjEucGRmDQo+Pj4NCj4+PiAtIEFkZHMg
ZHJpdmVyIHN1cHBvcnQgZm9yIE1pY3JvY2hpcCBMQU44NjUwLzEgUmV2LkIxIDEwQkFTRS1UMVMg
TUFDUEhZDQo+Pj4gICAgRXRoZXJuZXQgZHJpdmVyIGluIHRoZSBuZXQvZXRoZXJuZXQvbWljcm9j
aGlwL2xhbjg2NXgvbGFuODY1eC5jLg0KPj4+ICAgIExpbmsgdG8gdGhlIHByb2R1Y3Q6DQo+Pj4g
ICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+PiAgICBodHRwczovL3d3dy5taWNyb2NoaXAuY29t
L2VuLXVzL3Byb2R1Y3QvbGFuODY1MA0KPj4NCj4+IC4uLg0KPj4NCj4+IFRoaXMgaXMgbm90IGEg
cmV2aWV3IG9mIHRoaXMgcGF0Y2hzZXQsIGJ1dCB0byBzZXQgZXhwZWN0YXRpb25zOg0KPj4NCj4+
ICMjIEZvcm0gbGV0dGVyIC0gbmV0LW5leHQtY2xvc2VkDQo+Pg0KPj4gKEFkYXB0ZWQgZnJvbSB0
ZXh0IGJ5IEpha3ViKQ0KPj4NCj4+IFRoZSBtZXJnZSB3aW5kb3cgZm9yIHY2LjExIGhhcyBiZWd1
biBhbmQgdGhlcmVmb3JlIG5ldC1uZXh0IGlzIGNsb3NlZA0KPj4gZm9yIG5ldyBkcml2ZXJzLCBm
ZWF0dXJlcywgY29kZSByZWZhY3RvcmluZyBhbmQgb3B0aW1pemF0aW9ucy4NCj4+IFdlIGFyZSBj
dXJyZW50bHkgYWNjZXB0aW5nIGJ1ZyBmaXhlcyBvbmx5Lg0KPj4NCj4+IFBsZWFzZSByZXBvc3Qg
d2hlbiBuZXQtbmV4dCByZW9wZW5zIGFmdGVyIDE1dGggSnVseS4NCj4gDQo+IFNvcnJ5LCBJJ20g
bm90IHN1cmUgd2h5IEkgd3JvdGUgdGhlIDE1dGgsIEkgbWVhbnQgdGhlIDI5dGguDQpZZXMsIEkg
Y2hlY2tlZCBpdC4gSXQgaXMgc3VwcG9zZWQgdG8gYmUgMjl0aC4NCg0KQmVzdCByZWdhcmRzLA0K
UGFydGhpYmFuIFYNCj4gDQo+PiBSRkMgcGF0Y2hlcyBzZW50IGZvciByZXZpZXcgb25seSBhcmUg
d2VsY29tZSBhdCBhbnkgdGltZS4NCj4+DQo+PiBTZWU6IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcv
ZG9jL2h0bWwvbmV4dC9wcm9jZXNzL21haW50YWluZXItbmV0ZGV2Lmh0bWwjZGV2ZWxvcG1lbnQt
Y3ljbGUNCj4+IC0tDQo+PiBwdy1ib3Q6IGRlZmVyDQo+Pg0KPiANCg0K

