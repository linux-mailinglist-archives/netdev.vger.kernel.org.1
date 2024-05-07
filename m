Return-Path: <netdev+bounces-94154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2472F8BE6E9
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88BEDB235D8
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70412161308;
	Tue,  7 May 2024 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EFuEYpe5";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PFpb3d3N"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F6916130B;
	Tue,  7 May 2024 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094300; cv=fail; b=LuXE/vLTCtWlW0d1YJRgvlfpZM7kN/C/4PV/MntjBrR3Gb38OUtgIUWu3M1adn96VpG2+tVoqmluOoBTV/PMkRjA7VCRy4HaHAg/yq+rmvpoAuCZWQI9BPaKGKuDEeWEON/JFTprzpaKSea0qaYdrzz3UkJKZ0x6rUJH7pgF9Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094300; c=relaxed/simple;
	bh=tFgiFx1A3exh7w6qK3Xiydd8CDQ6EN7lhS+XoWiOP4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OpHRPTvRCqgYi2WGummQBICt47k9H3CyWZtMmq4J5onkQp8gFM96XDraLucJaOmfcEco3jNgzEIoOG4NiebDAFLB/agq3SPoDOFiLKulutPgG8ABg0nM5SWfKHbdpnb9ToS7lOxa8F0nEtFLAxu6a6mAxF+xyxojzXjIsbOy280=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EFuEYpe5; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PFpb3d3N; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715094298; x=1746630298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tFgiFx1A3exh7w6qK3Xiydd8CDQ6EN7lhS+XoWiOP4Q=;
  b=EFuEYpe56w1KBH2ukLR5RVSb7hJccEwD9w5oClIb+1V1ikwV525YioEK
   sMc5Z7HyXk06hOPRnkMn/9bVKAfhKArAKaJS3f8TWYTm+hDy+eRsu0u8E
   nL9XER4kCx+NIN1A7mTt2TQ+Waj8iCa8EB5Jejz5CWFfW3PP4xxPighjS
   JgHR+jMIW4MIGvAlLN4Fjc5/y5xBx/Ezc6mjOiXu/GvRS/fwMWraHv629
   daihwVvLNO4UIlxIcZJImvyOQTi1Sm++5f3lTsCTr2nDIMpvSr01v1PYN
   Vvz13rWPd2zyQoyGpgIy44yn3y753UWsRxVWpEkajpBYSpCCTST0NhDFx
   A==;
X-CSE-ConnectionGUID: KM/mqgEvQUeFmV7nKnB7YQ==
X-CSE-MsgGUID: suqszezISXiX4jMsygg7rQ==
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="26159054"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 May 2024 08:04:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 08:04:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 08:04:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h16vFJsO9RhrWlTQK5mR1pDEv21xSLles2Yp0DxPQFzamjqN/XJgqFAwChn8zugV+NbJLrWxsKDC/vKEUPFjIEffmrGBQeuKiYZNkZr1Ks+23uzUfTCpYyJzlyRpJSWwieB8uffeOiEvJxTuyF2Hr74ro/XE9tMgzWiClDn7iynYfgGlQASKJpK0kZAEMaKIUFBAifONE0mJ2kIUcrDCdXAbx37XifYlvc1KIyYIAmOocQfFd6wS7lT3TkzD6ZgEAt9d3+NrXBJC8XBQ36QyV2Bt7qsm09gVK/i4p39awHGVhPa1o+86ZIihcNLf4GLNdfpvli8OZZLln0q6M76jtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFgiFx1A3exh7w6qK3Xiydd8CDQ6EN7lhS+XoWiOP4Q=;
 b=Ngpr9TJ25dxkV4badiN+VXt7vzTya808vIhAWOaUxVHOaBt7svCX2cCbbzzwerBDu+9x6LKaIYbYVgV+KpprJsIa+wgEDrZgsb6QMaYbdCixm/eIqO1faB7QJNtWt5lyW3BlS/lw8VTe6dtrBJdvQD23vVTZadPJVi59aSwk3TutMmf0N8NhIMkrhxEZ9ygp31JX17M21Bcy2LlaxOBVA+8n9hthwQosmbSiCET42FiLz4ARlXRL6TYIb/EDkGbRw2CJR2tu/7PA7W+hJpfE4Xlvcq7dw+kJuKbZeWEectyfn1/v/twZvpb3fadRxOmeMvaPJ02bahg4Ou/jfH96EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFgiFx1A3exh7w6qK3Xiydd8CDQ6EN7lhS+XoWiOP4Q=;
 b=PFpb3d3NptMUbnYIuJV9MX37XUgQ1sEixudLqe6f0v7zQNF/GxMLAcKxRRt64VdXDNzmkLewC+XcVk4ZUhl1+AqjguQvBYIYKQ7befXiLILKiHU0r3fNCACjepgsuGXqUMQLCoTg12D0l5E2wHNyMytHiBVJuZE/5MrxHhcSPM4yjvWypQPfl5Ihb6hiXjnHOQIcxqKZAmnsiNvXsVJ54JL6JGM3XcEmU3ibotCrzOX+7OHk2tISts9VO/1/N0bIxlTH+UIomSq5W5jcjONLs3344Yg8CAdl32ZOZn6MQEBamyQ1bOXgOKdWZSJYJ8hjWFskEw8OWiDBa6vFpbv9Dg==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by CO1PR11MB4884.namprd11.prod.outlook.com (2603:10b6:303:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 15:04:18 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:04:17 +0000
From: <Woojung.Huh@microchip.com>
To: <o.rempel@pengutronix.de>
CC: <davem@davemloft.net>, <andrew@lunn.ch>, <edumazet@google.com>,
	<f.fainelli@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<olteanv@gmail.com>, <Arun.Ramadoss@microchip.com>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <dsahern@kernel.org>, <horms@kernel.org>,
	<willemb@google.com>, <san@skov.dk>
Subject: RE: [PATCH net-next v7 02/12] net: dsa: microchip: add IPV
 information support
Thread-Topic: [PATCH net-next v7 02/12] net: dsa: microchip: add IPV
 information support
Thread-Index: AQHanVvYOrS/w3MF/UCWVV5PJclUi7GKpGpQgACRbwCAAK4qoA==
Date: Tue, 7 May 2024 15:04:17 +0000
Message-ID: <BL0PR11MB29130F8A2E9D28BC032995A0E7E42@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240503131351.1969097-1-o.rempel@pengutronix.de>
 <20240503131351.1969097-3-o.rempel@pengutronix.de>
 <BL0PR11MB29131C40E4B39B119F9891C2E71C2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <ZjmwEPS0BM0QJUc5@pengutronix.de>
In-Reply-To: <ZjmwEPS0BM0QJUc5@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|CO1PR11MB4884:EE_
x-ms-office365-filtering-correlation-id: 17c9741f-1708-4e64-39cc-08dc6ea6f77d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MktoOFI0TnNMOGxyZkNmZFo4ZXYva2xLeTBqMjViNHdIa0VBbWxKREIzNk9Q?=
 =?utf-8?B?Q0tyQ1lNSXIydGJTUEdEa1ZSK295Z2VIUHo1Z1FPa0VtcExXWXcybXpXQ094?=
 =?utf-8?B?elJObVFsdzRMbzc3UlBxQUVVeG5OZ3U5cVRZaFFBck9xRmp6VTEzOFRkaUV3?=
 =?utf-8?B?eVc2aFdKcHM2ZXRnRWk5MWlCZ2hvUExWVUdoL29QdCtkWkpuN2doQWlDSi9v?=
 =?utf-8?B?NTRINUtQNm0xdEFxdUM3MFRwc3NXWGErRVBnckYvU0JtNm5wUzdPSVROOTBh?=
 =?utf-8?B?RGJSZDd2TkkwZFZEZklpc2NxTStYQlh6bVlJSmRkbVFqTnoyaU43L2paL3l0?=
 =?utf-8?B?Tk5scCtsd3B5M0FDbmM0MG80REt0cE1xSEFQNGZxbkc1Ym1EZm11TWswNEpT?=
 =?utf-8?B?OUQrV3RDZk0rV3FLYnZxMW5jVUZ5eUpENDdJbExVcFJVL3hESXdaQk9hWWYy?=
 =?utf-8?B?Mld1OVZnOXA1cjFMR1dHRHppRUZZdzNLSGpNTHVxZFVNUUs4enZ5RklVNEhU?=
 =?utf-8?B?a2F3S3crRSsrWkpUeWt2bEZ2NGtyT0RUQitlRmU2RzRBdjlQbnJZRVBCeGNT?=
 =?utf-8?B?SWU0Z1Q5M0J6T0NyOU5XN2NLTVVGbk5WSzFPSm9lbHN1eUpsN002bDVueVgy?=
 =?utf-8?B?Zmx4aGVEM1NJdzVlS1k0SCs4Y2R5VUtSc3paMmdmeElHRGk3d1VvRzMxTzd6?=
 =?utf-8?B?SHlvUzRJbWZ4am1tUW8vajduMnhILzNISy9kNHZoQTNFdGJuQkw5ZTgzZkJB?=
 =?utf-8?B?OHZqWm43TUZuOTBpWUdoQytJVGJaaUlwY01IRUx3MVJPY3hURmhIVWdVRzA3?=
 =?utf-8?B?OWJqOWU5ZjVGNDI5K3hGUnFTVmE0dUozdjdDWjV6Vnk1aUdQUFZoOXc5cktV?=
 =?utf-8?B?MU55b3c5dTRMRTV3eElHL21vbVppbUFpcWVQNnQxakpIUG1oWEpIdHI5c2NV?=
 =?utf-8?B?bExXM1NTcjhiT2UvWTFCSzdJNEovZzc5K1FXa1krUlJTNnc0OVJrb0dBU0tC?=
 =?utf-8?B?d0Z3S3BnTTlPNUxpZGRkd3Y5TDJBVHdGUUZRNno3ZEVoQ1ltd2VLdGtvUUVM?=
 =?utf-8?B?M3Y4eFEyWFBjNHE5ZW9Iak5OZDEyekpBM2lmS0hJK3BSWUdnR1QrQW42T3JC?=
 =?utf-8?B?QUFBOEhMN0Z6eWtHa2NZVjgvZzBFMlRka0ZJb1RiNXJFQzZyOE0zOE85Q0wz?=
 =?utf-8?B?MUFDUTVkN00zVi9odmlRU01ycTkzRjZXWGlxY3BYbEFQQVJ0V3JCODNvOW05?=
 =?utf-8?B?VkZsQW54TVdoeGJjVlZVQXhCNklCcWMybno5ZUtTMGxtRWtNY0xPR0JjYjNv?=
 =?utf-8?B?WFZDeEFOcFIyR1hIcUpVdnVScXhoelVKK01Qd0RodjNaRmlYRUVjUEJlL2NJ?=
 =?utf-8?B?TFVLRzBjYjBsSnBzd0dRRWdQMFdGVlVqeDE0RnVRY0FmbGkvaEczWlRpdEZG?=
 =?utf-8?B?R0U3eXFaOVZXSmNCckU1KzFjUGR4WVFWamszVXlhNEZ2d0xyOTJDOGJpN2Ix?=
 =?utf-8?B?T1EzdUVDa1Z5bkk0MDlDaFdMc2Q4TzdvVzJweG8wcTJZd0dqSVJ4Tjk0UE95?=
 =?utf-8?B?bWlLSzdxbXFXaDJRcTlOeHY3WlR5V1J5MGRyc3JUVHlaMXhIVlA5aWNsSlQ5?=
 =?utf-8?B?eURSNkxzZlI3ekE4b1BLT0VPNStmSzh5NnFFVkR6UDdUZ3FSRTdWWEZXS2o3?=
 =?utf-8?B?eDhlK3ZBcmRuQzNHcXVzWTNYN2daVVdYSys3SnJWSmF6ZmZYT3QzVVZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXYxOHBrdmdLWXZFd3I4K01BUGxyNkgrNnJ1Z1dHbVltcisrcTZ2aGZ4dGVk?=
 =?utf-8?B?WkJWOWFOZURGNTRJQkRFVmk2a0tVL3RyY1pnT3laeDFqcXJ0NjVVWGxLc1pF?=
 =?utf-8?B?SXVKdktWdUwxT2EvcEYxTTRibE9VaGhKTXJhN1BmQTExTU9XVzhLQmtubWVq?=
 =?utf-8?B?MUhqc3FVcEpCb1R1SkVPSVFZNXcyMzR3dFF0cjdzakc3VWs0d1pxL2dhL2hh?=
 =?utf-8?B?Y2JLOUpHdkNMVVhlT0h5TzZYbzlWUTFvRDE0YTM5WUNvWHorYUJzTThteFc4?=
 =?utf-8?B?TXVrUVZ1KzRZOEdReFc1Zkg3Si9zYmNIT0ZGeHVwK3NwYkd3d1Y5RG84S2Jt?=
 =?utf-8?B?VWpxRXk2Z1d1WkN6ZTJDaFlBMGdUZURvWEZMME9pTTNheEF5YndUbWF3aTFq?=
 =?utf-8?B?L0VyWDhOWFNZVjBITEoxTWpxU3JGSGJtbDBIT29tMGFBdkQ2VDRwOExSWFV6?=
 =?utf-8?B?YUEvTXhGZTZueGhHUCtvSEFFcmVmdVhmQ2tReEw5MlVuR2hkWEJtU0MxZlQ2?=
 =?utf-8?B?Q3FqMlB0SmJLaWF5VS9WSmkreG1LdTZZcjcxMTNWNkVOWWF1SnIvTzR5OUY0?=
 =?utf-8?B?SUgyNHh5WFNXZ1l2NjJSSXB4NVlFRkdGQkVkTVIxVVJWeWJKQkxUTnZPLzdW?=
 =?utf-8?B?b3B1ejdtYUMxZDVwa3F0bVhCT0tWZjRDM05lMFBXRGlnc1BlOFhaVWNYclky?=
 =?utf-8?B?VklHdGZqanFCNHRGNEk1bW95VDY0WnFxNDUxc2FOdXdqVTFrOGJYNnpvMmph?=
 =?utf-8?B?U2Z3Rks5S2VKUnhJQndxUktmcHhjb2ZhTG5IWjlISzkvSGdnMFp2bzhPOXAx?=
 =?utf-8?B?TDBvTVhFZk5TL2Erd1VzOWp3Y2EzallqcHRQQ1ZYVitPZkh3cWdNcEpEL1Zi?=
 =?utf-8?B?Yk96VEVwYzZoY1Q2UEtFckNTanJZVW1mdFcvR2Vsa3NLYWQ1ekhWaE5xWFlX?=
 =?utf-8?B?eG9QS2FlZVVXdGRwTVZNSDg5N0U3QnJNaU9ac21uSTFpOFhDdmNkVWphTnhh?=
 =?utf-8?B?RXMyV2NMeFVKVnplQklHc2pNUWVmMTUrZFJwbzhWY2dqWjY5cVpJNEpUaFdJ?=
 =?utf-8?B?VUFsQVRYS0t6Wmsxa3RkM2pyRFExTUlBbW1qWUdCRWJPaXhlZUhoSldRWXZT?=
 =?utf-8?B?L2JZQ1ZMKzBvcWVkWFpzYmZBa1crUXZQZjVZN0pIaXVYc1hEeGtyWktORE9B?=
 =?utf-8?B?V0dqeHZjbE5IbzM0Skl2cmlYeUlXazVOV3d5RkNjWlo2TFh3MEF2WGJTbVJ0?=
 =?utf-8?B?cmxmZUk3TFNHbkE0MUtYNG1lSGZodmRYUXhQWUdIakFQOEFnZG52elNPYXRS?=
 =?utf-8?B?RU1wb0xMbEdvMUFTV09sbjNJZGdDQkNmWnRUa0JjMUxpeC9PbnJ3QWg1V0Ja?=
 =?utf-8?B?YWh4SlpSVEZTT0JTNnNic1JNNzV3U1FqZlpBTEwwNmo2UDROMUZDN0NrWWEx?=
 =?utf-8?B?Z28wMURlMDlSSGhWQThTT3p2cG1Hd3BZeWFncVpQMXZrMmJ2cXM4SHljQm9s?=
 =?utf-8?B?QXFNVXBxenVuSWxQUVNHUG9mVWt5a0ZFZDhTTVpwRXB4WVFOTFQ5bXNDcWh3?=
 =?utf-8?B?K290aDc1WE9rVElvRzU1T0pDT2VIR0ZJRjFvTTEvbjZ0ZkVjUWxPcU0zRnlO?=
 =?utf-8?B?SWE5WEdBdUhaTXdRY0g0SzFOU0E0Q0xVT0lyVHpjcXlMa2QxRFBndTd1ZE1y?=
 =?utf-8?B?ejRqOGtVbjJrR2RUZDRFRGIxTlZCcVpWQlo1cFdlOHRFa0R1TVVZbDFWTTRk?=
 =?utf-8?B?ZGdyWG12R3BPQ29XZCtRMEI4bTZVcjBjT3pJaXVGazlPeWhVY0Z0UThjem5B?=
 =?utf-8?B?Um5FczROd2hzc0c5Z2FHSVZqMFFZV29naW1XZ3lMT2xBTmZTdXFwUHpRajha?=
 =?utf-8?B?MEJWZDRHRkJjV1Y1a0VXejUrT25MSDNDN2FsZkltb3RtSWxwZnZIaVlxZjZs?=
 =?utf-8?B?Q1ExbVAwTUg1OXFVR3NFNHA2ZlJBTDkyNnR0Y3BtbC9OdzFSWGdnWDFyWU1U?=
 =?utf-8?B?bTBiMTV0V21YMDdzVjFaQ3B4UmNmeVlpeitlVzlYNlhxeUtuVGxsR0wwUW5E?=
 =?utf-8?B?aDBMOW8vSUt4Q3pyb21yM0Q3K3Fod3ZWY1dzVnliekhJL25GaGM0Q25SVDJI?=
 =?utf-8?Q?d0l7Q9VbiQl/OrSKA3trvjcJe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c9741f-1708-4e64-39cc-08dc6ea6f77d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 15:04:17.5138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gW+ROnZbPjwdujrfU4qMqRCCv6yYOnA0Lw0eYYrwJBn3C2jcAiRD98BvtOQAZ8LbgmQkq5BHf+03xxyfKEs1YKhf+pOXBpLQaWq4ImzAMWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4884

SGkgT2xla3NpaiwNCg0KPiBIaSBXb29qdW5nLA0KPiANCj4gT24gTW9uLCBNYXkgMDYsIDIwMjQg
YXQgMDg6NDM6NDhQTSArMDAwMCwgV29vanVuZy5IdWhAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4g
PiBIaSBPbGVrc2lqLA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgcGF0Y2ggYW5kIHNvcnJ5IGFi
b3V0IGxhdGUgY29tbWVudCBvbiB0aGlzLg0KPiA+DQo+ID4gSSBoYXZlIGEgY29tbWVudCBvbiB0
aGUgbmFtZSBvZiBJUFYgKEludGVybmFsIFByaW9yaXR5IFZhbHVlKQ0KPiA+IElQViBpcyBhZGRl
ZCBhbmQgdXNlZCB0ZXJtIGluIDgwMi4xUWNpIFBTRlANCj4gPiAoaHR0cHM6Ly9pZWVleHBsb3Jl
LmllZWUub3JnL2RvY3VtZW50LzgwNjQyMjEpIGFuZCwgbWVyZ2VkIGludG8gODAyLjFRDQo+IChm
cm9tIDgwMi4xUS0yMDE4KQ0KPiA+IGZvciBhbm90aGVyIGZ1bmN0aW9ucy4NCj4gPg0KPiA+IEV2
ZW4gaXQgZG9lcyBzaW1pbGFyIG9wZXJhdGlvbiBob2xkaW5nIHRlbXBvcmFsIHByaW9yaXR5IHZh
bHVlIGludGVybmFsbHkNCj4gKGFzIGl0IGlzIG5hbWVkKSwNCj4gPiBiZWNhdXNlIEtTWiBkYXRh
c2hlZXQgZG9lc24ndCB1c2UgdGhlIHRlcm0gb2YgSVBWIChJbnRlcm5hbCBQcmlvcml0eSBWYWx1
ZSkNCj4gYW5kDQo+ID4gYXZvaWRpbmcgYW55IGNvbmZ1c2lvbiBsYXRlciB3aGVuIFBTRlAgaXMg
aW4gdGhlIExpbnV4IHdvcmxkLA0KPiA+IEkgd291bGQgbGlrZSB0byByZWNvbW1lbmQgYSBkaWZm
ZXJlbnQgbmFtZSBzdWNoIGFzIElQTSAoSW50ZXJuYWwgUHJpb3JpdHkNCj4gTWFwcGluZykgdGhh
biBJUFYuDQo+ID4NCj4gPiBIb3cgZG8geW91IHRoaW5rPw0KPiANCj4gT2suDQo+IA0KPiBEbyBJ
UFYgaW4gTEFOOTM3MiBkYXRhc2hlZXQgbWVhbnMsIElQViA4MDIuMVFjaSBQU0ZQIG9yIElQTT8N
Cj4gDQoNCklQViBpbiBMQU45MzcyIGlzIDgwMi4xUWNpIFBTRlAuIEl0IGhhcyBUU04gZmVhdHVy
ZXMgaW5jbHVkaW5nIDgwMi4xUWNpLg0KDQpUaGFua3MuDQpXb29qdW5nDQo=

