Return-Path: <netdev+bounces-98051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA6E8CEC8A
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 00:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9269A281A4D
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 22:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E941272A3;
	Fri, 24 May 2024 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="JoTSNfDg";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="DJujDXxX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00183b01.pphosted.com (mx0a-00183b01.pphosted.com [67.231.149.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F194A01;
	Fri, 24 May 2024 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716591428; cv=fail; b=U/I+q85885Kjy+7clc69e9Y8y5mtfePDJLus4wWzpgsgPxJmBU+k0HudWxzYETYGksluSIHvFD+PRQniviGyzDAXk6lvCYXcmMBelcRjcKLZv/rEzN9SjIdZMYgqn6OrFrrA+1nOEatWIiUF/2iGEM4NMLopuWvW3XgXwN05NqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716591428; c=relaxed/simple;
	bh=VrYj4DaK577NpMqZ7e3yA7xSOoLmY9kV3O9hmRNVzJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=foXK0HwgZlDKHiayOVGHDgslPZs85ro2cWf6XOlMKaDXLJ/VtEna+AwmTfK6DN+WC6a7UjKN+XTBYBmWWNty/kz4h9ZbvB/aZ0GKs2jWaJF7Mu2R7G7bfBkTHouAZT8pFL0WEPeEZFjvLVBHhoXrwspaK7dO4RSV3bhEilabQpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=JoTSNfDg; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=DJujDXxX; arc=fail smtp.client-ip=67.231.149.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
	by m0059812.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 44O75TR7008275;
	Fri, 24 May 2024 14:52:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pphosted-onsemi; bh=VrYj4DaK577NpMqZ7e3yA7xSOoLmY9kV3O9hmRNVzJQ=; b=
	JoTSNfDgRzjQECeo1sEJXD8OAYAQAAljPEmX0nJOZrXXtmpQLS29rH6An737lKtV
	oS3HDfR/ZMev3ZDuFrVtcecD3L7uZ3EEUdGaJGE9GSJNARMT2Fm6rAbkQ3xXMoz6
	QF4rqdpuY0/uZEo8G4YqzXqSK+uZHcz/f3Vt+bGIqy7i/14hGx8nbZItwGxlsARz
	+cGkncG+BltJihE6UoBc0q5kP7mF8rTdX4lVGGBcyMwExl38SBsATdmHqPTLYEgZ
	WtDKfN9SXowaqidCGmW53WZ2Q6UXrTzmeL4nd8EUQNX6wJ1thR/0Olixi5KwVVfP
	sMawPdcBwx+3FQ2kSuY8iw==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by m0059812.ppops.net (PPS) with ESMTPS id 3yaa9stxjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 14:52:25 -0600 (MDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqqtgMnZNYmJ3bTaDD4fvaV9oiy9brkiUmLJT0PlAtCeTSincVFZ9oYjneM7YQglQplPJRqx3Jz7gUIbL8rkE7WxlB1OdK5ehyUv0xTePLc/ssn50ItifWD+ndRJ5JAAvVhWiOEfKdWCRLm0XUQUqjIny2gCZDOgSvLqLWjGK1NRwZQ5Pinl2Qewuc8zuQBJZ6BRUS8iwbNB+G3NhcdHhXz4JK8TojQlwf0g7fSMWWrgNSDvDM1w34/156fLA0VmL3KBSBPqwtM8HPZ24Dv03GcQpN3TwjX8r860001EMt5zG4FvkHIgzla4ObZLQ//nzpbzTA45k117FWgwzyFn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrYj4DaK577NpMqZ7e3yA7xSOoLmY9kV3O9hmRNVzJQ=;
 b=VpUikCLu/Qmg6dNAjO0lfQV/m+WdQmhmUgk/7T2WE4E0S1yXmrzBdvXP4bapdAGCy9jTkpsnawhMV8DZMxFf5aod4rah//jJx5tKpEJzyLn2/leMK/2n3fW6dnUb7FomvLwivyehhJ1/8f0Fa0LFLX048T4w2tizumjp3k8b/Y9CP5cpgiC5nfqEKoHLkbDxg9XaXnPdNGi3H1/yWorII5Wdls0WsbYN88XBnaYtz3uQYYFC6VZXLfBEWa5tqBi7+eKbzaAUTQ89j4HQzVdRe/fd2VRvFa6BOStDosyCPQtv8jludIdc72RZaS7mXp4quX8bT4W+CxuzxWGVSJaDDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrYj4DaK577NpMqZ7e3yA7xSOoLmY9kV3O9hmRNVzJQ=;
 b=DJujDXxXzls0PthZ9CMl3RDKxF4w6ih9WFDXXVoHtK5m99sG0UkSJREKEWc/3M/WDGsK4p1cj4DKpznGGhfOEDeTrag95v9gv8k5w4hwBBN0BAxW+iUdJ7NNiaWC0vb+eoR3jFf1PD6c3gogs7GWwou50meNW/LsS+xiLiexABQ=
Received: from BYAPR02MB5958.namprd02.prod.outlook.com (2603:10b6:a03:125::18)
 by SJ0PR02MB8547.namprd02.prod.outlook.com (2603:10b6:a03:3fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 20:52:23 +0000
Received: from BYAPR02MB5958.namprd02.prod.outlook.com
 ([fe80::9050:b9f2:336c:edaa]) by BYAPR02MB5958.namprd02.prod.outlook.com
 ([fe80::9050:b9f2:336c:edaa%3]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 20:52:23 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "Horatiu.Vultur@microchip.com"
	<Horatiu.Vultur@microchip.com>,
        "ruanjinjie@huawei.com"
	<ruanjinjie@huawei.com>,
        "Steen.Hegelund@microchip.com"
	<Steen.Hegelund@microchip.com>,
        "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        "Thorsten.Kummermehr@microchip.com"
	<Thorsten.Kummermehr@microchip.com>,
        Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>,
        "Nicolas.Ferre@microchip.com"
	<Nicolas.Ferre@microchip.com>,
        "benjamin.bigler@bernformulastudent.ch"
	<benjamin.bigler@bernformulastudent.ch>
Subject: RE: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Topic: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: 
 AQHakZAzTzY8uLDqjU+aLRkJ24TPX7F0voeAgAA2YYCAGHiwAIAAQuMAgAFPWgCAAH78AIAA9q2AgBaZtCA=
Date: Fri, 24 May 2024 20:52:22 +0000
Message-ID: 
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <5f73edc0-1a25-4d03-be21-5b1aa9e933b2@lunn.ch>
 <32160a96-c031-4e5a-bf32-fd5d4dee727e@lunn.ch>
 <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>
 <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
 <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
In-Reply-To: <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5958:EE_|SJ0PR02MB8547:EE_
x-ms-office365-filtering-correlation-id: 48a6513b-4aed-4139-c9c3-08dc7c33692e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UE5EY1FVaHljVXZwaitZNnFlOVNTc3lhdTlUV1BEOW1VNVRhbzFKZTMvdU9G?=
 =?utf-8?B?TFlMNnVSWStnL09ReGU4Ynp3ZlA5TWZEL0ZjQ0dVWlNvRUJUc0hHS0NuaS84?=
 =?utf-8?B?SGRZQUg3TlByN1RUTldMMmIzeW1DdWpjV3dpVTZraXltcDhwUUF4VlNQWDE2?=
 =?utf-8?B?UkNpZHM0VllmdVBOU2FWdWRRYUljTFRhR0FnM0NPT3JZRllITnlLcXhsY3BI?=
 =?utf-8?B?OFhyWnBEK3VvWHhlMmI3NWE2aWlOUStHNXBrak5zSXRyTkh2UkVpdXZHSUlG?=
 =?utf-8?B?eEhoL2VONm1xYm9iNG1iai9kMEJuOUovdlBpb20yT0F3aGpWM2dIYW1vdDJj?=
 =?utf-8?B?SzNHT1VPamVMRFovSnlQRkZHbk1zR0JVOUN3ZFJnSFF5Z09LeFYvSEJBZFFM?=
 =?utf-8?B?dXJQVUtDcUk5MWZ4N0Z6YUdhQWJXUVl6VWVNbnJEa003UDUyU1I4MFB1MXVQ?=
 =?utf-8?B?VkFrN0ppU29heVF2SkxBMDZTRTdCSlZORkVBUUl6QjMvRzlWcVRuNXI2Vkw2?=
 =?utf-8?B?ak1hd01RZno3bUV0aHFZM1lPaGpmRUwyNmM4a0YwZko1UUorZHZnSUNlWHJX?=
 =?utf-8?B?cDJBOW9LdHJIZmZqZTFNNVdqSW9iSkc2UEJwUnpEV0NlNHhEMmVjKy9CdGF5?=
 =?utf-8?B?MU81MmcwUjhmOWh3M3d0b1pOY0VCRTJQQ2dLa1hGTnpNcXFMWWhtUjRsK2E4?=
 =?utf-8?B?dm9xVzE4cXc5aE5pQ20zL05ZVEtxSXlkK0JBdHQwYU9YYUEwRzdEaThlUVlM?=
 =?utf-8?B?QURkU0pRUllhKzBZTHJVZi9RZ1BaZi9ma3JydXZicFJ3SU01YXAzbndOU2tV?=
 =?utf-8?B?TS9YS28rMkVPcmp4bWhBaVJuWU1rNHVuR0l3dmtBYzI2VzBlY3JoYUJWcTN1?=
 =?utf-8?B?MitrcGpHemMyK3h2RVBRYU9oa3ZNWG5DQVNsbTRWRWpSNm4waDd6Q0ZFMlJP?=
 =?utf-8?B?Qk55RXk1RVdqQ0orNW9DZWRBeDhQdzBCb1U0dWtDVnhxWHB0M0hiMGNoSktQ?=
 =?utf-8?B?aFRJb3UvM2gxb252VUFnM3Y1SUpZNGN5eXd4cW9vTjJ2cUlMRUdsTk44bWg0?=
 =?utf-8?B?N2hZT3lTbVA5MmlUWVg5L1VhRU4vM055VkFLZkllRDlkUERMbDZEQ1dBRzMz?=
 =?utf-8?B?WWk1T09pYlNoTUNMVFFuYjE2V3hhVTBKcFBsdXJnL2sxdXZSYXN2SnBvN0dj?=
 =?utf-8?B?aDlKcHVxeEpuRXNnWEhNeFJxbTlDa0kwMUtzK1Rmc0FzRUFLU2gwN09aS0sv?=
 =?utf-8?B?eSs3YUQvWk5mVDhpQithc3FDSDQrM1VQNXV4cHBYbVhxYU1BYjYwYnRxSVpi?=
 =?utf-8?B?S1k3Rk1jSVM4SnhzZ09WdTBueEJVa0hhdWpZRGhHVTdTN1VuUUZOZEU2WEF1?=
 =?utf-8?B?VnpzeWhVWWlFQmk4aWRnWnRqWXBqRVZreWxlc3lzOUh5N2xJaXFRTkxxMk13?=
 =?utf-8?B?RkZ4SjUyWGJnK2hTTUpqTCtqcFNCTDVocVJVTDNhY01CcjZoQTZPS2hoOUUw?=
 =?utf-8?B?M1JoRmlnS1BQNDY1dnR5RkwwYXpBOUZMMDBNcWFyUHVsRU44MmJCa0RyS2VZ?=
 =?utf-8?B?RmpVOXBjQW1WM0puS2JUV1BnZjRaWFVQUURITyt1SXplakkyU0xBU04wSXF3?=
 =?utf-8?B?VjZyanpFNGl3UzBTQnRDckVQYmliWjhkZ2EyK2lrMGVrUCtBMThRbjB5OXBU?=
 =?utf-8?B?MDVma3g4OXFHbnBkUlQ1VGdzNXBadmxBcU9WbDcxcStQNEp5dDdSVktmbFdz?=
 =?utf-8?B?YmdtTEpOZTZjdVNadllxL1lxRndNRUFnNDhtNFlXeU0zdWJsckxxamFFRHRD?=
 =?utf-8?B?aTJrRXBHR005WWNTRDB2Zz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5958.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aVRIYnA0bXJKOFdjZTFZR045bEFUb3d1MndmbFZhQzdpL1Z4eitGTEtDVmtu?=
 =?utf-8?B?TjREc0xtUnFkTFhuTkZBMTMzaGpqcEk1enR6VDdPcnFpQTRndHpmb1ZUMmgz?=
 =?utf-8?B?cXErbmtqRVhYWGhXUXMyaWVEYU5hVmtnaXNjaUxLY21qVldsOVd4ZENxUGEw?=
 =?utf-8?B?V2E1OE1ydG5BdDBhUWp3emZNd2hmdmlTMUZlc05XalkzUW5PaHd0ZWV6WXRT?=
 =?utf-8?B?UmRRSWNjNGFvM0hqTXNWQllHYU5ka0dYakYzQVJuODUyejdpcnE5RVI2ajdB?=
 =?utf-8?B?U0srKzFVN2JVSHYrWlQwbnhKaGhiUkNpSis1ZWpqUmUzSlcyb0FuTDNjb2dt?=
 =?utf-8?B?RE8rNEUwSk1zS2x3SWVwRC9KeGZGaG1EdDNod2FHZzViZzVrdlZOYzJ0OEgz?=
 =?utf-8?B?V21ZSFBvRlMrNzZMNWFFV3U5a2JNZno1ZWlTV3dTNmhubVBXMElJT3ZZUVE3?=
 =?utf-8?B?Tk8wWExTNlNPWXlPM3hqTEJONE5XVEl1eGdRYURrVGRhOVFmWjQ4QmtLS3FZ?=
 =?utf-8?B?L09xMTNwSSt2RTcyd0xKWmVtb3VPL2xqNElqeDlRNTJqb1RLRFRnMnlnT1BT?=
 =?utf-8?B?NHRYbnhSWTFpYTZIUnBBdnVBNnpTeVQ0QUJRcjdCYmlZcmRXcVFBVWc1VUFz?=
 =?utf-8?B?cTJ1bkVwTGtGKytGQnE1ZWtPUTEvNHhYU0M1K2g2dGFzbmFERFVaZ00zcGFQ?=
 =?utf-8?B?SUlzQmdyaFV4QlBTRktGZHlLQjU1ek9QMHV4QldydmlDRUFrVUVSSklhZG4r?=
 =?utf-8?B?REViWlR5Q25EU1cyeE4wcWhUaHF0aCtEYXBrcVEzQjFXWktjNFpPMGZpYTVx?=
 =?utf-8?B?RHp0WE0vUkcyVnZVWUlwQ0ducmhVb0JrZXVRcmlFNHk1MFhOZ1JCU0RBT21Y?=
 =?utf-8?B?eWZFdFJrVnVYOU9tWTRUV2JWdU5GMEc1MnBXV3BaOXhZd3k5WDAyUCtaL2Rv?=
 =?utf-8?B?Vm5TQmlOaFl6WTd3V3FvTjgvV1VCVFpsQUY3VWpUbStBd1FuOGxBUSt2a2Vq?=
 =?utf-8?B?d3lqN2VZdUYxWWlrMW01eTd1YXVzUExXazNnOHlDWHBrdnlTZUp5dDcxd3Vr?=
 =?utf-8?B?K0Yrb0hRU1JLRFNMb3d3aVo2eDFaSkNoeEs0VE9mTG5hdDEwSDBWc0FZZUtp?=
 =?utf-8?B?d3AyazlWejc4SjdDR3V0eU1kUi9LR2FyaGhqdHhDNk53dnN0bTlmdDEwdUlu?=
 =?utf-8?B?OWtPdmp0Z0xRdG9ZUytwaTV4a3VLN0hMNUZSZ2FyR0QwdUNJZ29WbFhPTkF5?=
 =?utf-8?B?WFRSTVNDQVpib05EUkV3dlBXQ29saEpiOFhjdXRtUW1OU3FXTlRhZkY1YmlX?=
 =?utf-8?B?dFlOS3Q3em9YYzZac25CWDVBQW1EZEZTVlhmRXUrVlo2QlFxS0hhMnUvd29v?=
 =?utf-8?B?aDBIM3N3bklLTGNQeGRnRHk1SlF0SGhHc0JrcndZd0NCSG5QZ2k0ckpqY2h4?=
 =?utf-8?B?dktUM0pDbWVudEErZFdHZ0RPb0V5bWVmb2d1REY4a01Ud0EyS0ZFWUVKdjF6?=
 =?utf-8?B?aHpIMTFlRDdqbkZuZTZ3T2VnTk0zL29tUEFzdXlCa1NRSGhqZDdPSWcvNlF5?=
 =?utf-8?B?dTk3alVZeDdDMWNHUkUzU1FaenJsV3QzSytwcTQ2VzMyNDFDUzFKVUpPY1c1?=
 =?utf-8?B?WmVzNWtrd0IvUVkxdVNIcStzdkk1VnlCTVZlUURNRFV2dmhJc2tzb3NaSjJ4?=
 =?utf-8?B?MzRzQWRLWTNqY3FYSVJVUE9MNlpVSnpwaVgxQjM2TlZJUVVYaXVJTm1vUXU1?=
 =?utf-8?B?L3JSUzlrVlVSemlTQ3lPc1pzSzZTOGRQMTdxUU5GVXlKUHpwQVZNS1pCTVk2?=
 =?utf-8?B?NkhydEdXK2RPZ3ZZRlhvWEtmOWNFN09OdWtPSXkwT1oxd2c0ekg1WHlWN2I4?=
 =?utf-8?B?akdXWUFEL1JyMW5aS21tNFdGdi9YZEtFb1QrcnllUHlBWVVWeGsvc2hZbVBh?=
 =?utf-8?B?bUhvb3FoTUxuOVF2MFJUamttZ2pSR0dkTy9QR3Y0azc4TlViVnJOcFk2bnUz?=
 =?utf-8?B?c1UvUWdqalI0RGVnNEg2S2REQkdBQzRCRGMydVV6V1RTV2VQMGxuUHlBL1Nu?=
 =?utf-8?B?TURTNStPRmdtTHFwOG1RWE5RZXhVZWlhNEpqbnYyRGl1d3lFaktyWktQSnBZ?=
 =?utf-8?B?Y2oyQWpMc0lhQUszMVRSQUhxRDNJaFFMbU9zaGt2aU1WUFNGWWtvWVJ5bk95?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5958.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a6513b-4aed-4139-c9c3-08dc7c33692e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 20:52:22.9170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwmIOkaSnhYs01eW2P+/QI8B7OZVEHFxxc6l5pfojI50J+gKYEygLZXFvc8SJ5nHMcTb6CzlfqLS5GJ1aek9l0kip++ysQoigdbryqlEZWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8547
X-Proofpoint-GUID: 1tiqI6_CKLURukxKtiEJeMMvO_4sU6tW
X-Proofpoint-ORIG-GUID: 1tiqI6_CKLURukxKtiEJeMMvO_4sU6tW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_07,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405240150

QW5kcmV3L1BhcnRoaWJhbiwNCg0KU29ycnkgSSBjb3VsZG4ndCBnZXQgYmFjayBlYXJsaWVyIG9u
IHRoaXMgc3ViamVjdCBhcyBJIGp1c3QgaGFkIHRvIHRpbWUgcmV2aWV3IHRoZSBvcmdhbml6YXRp
b24gb2YgdGhlIGNvZGUgd2l0aCByZXNwZWN0IHRvIG91ciBkZXZpY2UuIA0KSSBoYXZlIGEgcHJv
cG9zYWwgZm9yIHRoZSB3YXkgTURJTyBBUElzIGFyZSBpbXBsZW1lbnRlZCBpbiBjb21tb24gY29k
ZSAob2FfdGM2LmMpLg0KDQpBdCBwcmVzZW50LCBtaWlfYnVzIHN0cnVjdHVyZSBpcyBpbiBjb21t
b24gY29kZSB3aXRob3V0IGFueSB2aXNpYmlsaXR5IHRvIHZlbmRvciBzcGVjaWZpYyBjb2RlLiBU
aG91Z2ggdGhpcyBpcyBhIGdvb2QgZGVzaWduIHRvIGdldCBjb25zaXN0ZW50DQpiZWhhdmlvciBi
ZXR3ZWVuIGRpZmZlcmVudCB2ZW5kb3JzLCB3ZSBjYW4ndCBjdXN0b21pemUgdGhlIGZ1bmN0aW9u
cyBzdG9yZWQgaW4gIHJlYWQsIHdyaXRlLCByZWFkX2M0NSwgYW5kIHdyaXRlX2M0NSBmdW5jdGlv
biBwb2ludGVycy4NCg0KSW4gb3VyIE1ESU8gZnVuY3Rpb25zLCB3ZSBkbyBjZXJ0YWluIHRoaW5n
cyBiYXNlZCBvbiBQSFkgSUQsIGFsc28gb3VyIGRyaXZlciBkZWFsIHdpdGggdmVuZG9yIHNwZWNp
ZmljIHJlZ2lzdGVyLCBNTVMgMTIgKHJlZmVyIFRhYmxlIDYgaW4gc2VjdGlvbiA5LjENCk9wZW4g
QWxsaWFuY2UgTUFDLVBIWSBTZXJpYWwgaW50ZXJmYWNlIHNwZWNpZmljYXRpb24gZG9jdW1lbnQu
KQ0KDQpJIGhvcGUgaXQgaXMgbm90IHVuY29tbW9uIHRvIGV4cGVjdCB0aGUgYWJpbGl0eSB0byBp
bXBsZW1lbnQgdmVuZG9yIHNwZWNpZmljIG1kaW8gcmVhZC93cml0ZS4gQXQgcHJlc2VudCwgdGhl
cmUgaXMgbm8gYWx0ZXJuYXRpdmUNCnRvIGZ1bmN0aW9ucyBsaWtlIG9hX3RjNl9tZGlvYnVzX3Jl
YWQsIG9hX3RjNl9tZGlvYnVzX3dyaXRlLCBvYV90YzZfbWRpb2J1c19yZWFkX2M0NSwgYW5kIG9h
X3RjNl9tZGlvYnVzX3dyaXRlX2M0NS4NCg0KSSBhbSBzdXJlIHdlIGNhbiByZXNvbHZlIHRoaXMg
aXNzdWUgaW4gbWFueSB3YXlzLiAgT25lIHdheSBpcyB0byBwcm92aWRlIGEgcHVibGljIGZ1bmN0
aW9uIHRvIHBvcHVsYXRlIG1paV9idXMgcG9pbnRlciAodGM2LT5tZGlvYnVzDQppbiB0aGUgY29k
ZSkgZnJvbSB0aGUgdmVuZG9yIGRyaXZlciwgb3IgcHJvdmlkZSBhIHdheSB0aGUgcGFzcyB3aGVu
IHdlIGNhbGwgb2FfdGM2X2luaXQuDQoNClZlbmRvcnMgd2hvIGRvbid0IHJlcXVpcmUgc3VjaCBj
dXN0b21pemF0aW9uIGNhbiB1c2UgZXhpc3RpbmcgZnVuY3Rpb25hbGl0eS4gVGhvc2Ugd2hvIHJl
cXVpcmUgY3VzdG9taXphdGlvbiwgY2FuIGhhdmUgZXh0cmEgY29kZQ0KYmVmb3JlIGNhbGxpbmcg
dGhpcyBzdGFuZGFyZCBNRElPIGZ1bmN0aW9ucy4NCg0KU2luY2VyZWx5DQpTZWx2YQ0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBt
aWNyb2NoaXAuY29tDQo+IDxQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbT4NCj4g
U2VudDogRnJpZGF5LCBNYXkgMTAsIDIwMjQgNDoyMiBBTQ0KPiBUbzogYW5kcmV3QGx1bm4uY2gN
Cj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2Vy
bmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGhvcm1zQGtlcm5lbC5vcmc7IHNhZWVkbUBu
dmlkaWEuY29tOw0KPiBhbnRob255Lmwubmd1eWVuQGludGVsLmNvbTsgbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0
OyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlz
enRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IEhvcmF0aXUuVnVsdHVyQG1pY3JvY2hpcC5jb207
IHJ1YW5qaW5qaWVAaHVhd2VpLmNvbTsNCj4gU3RlZW4uSGVnZWx1bmRAbWljcm9jaGlwLmNvbTsg
dmxhZGltaXIub2x0ZWFuQG54cC5jb207DQo+IFVOR0xpbnV4RHJpdmVyQG1pY3JvY2hpcC5jb207
DQo+IFRob3JzdGVuLkt1bW1lcm1laHJAbWljcm9jaGlwLmNvbTsgUGllcmdpb3JnaW8gQmVydXRv
DQo+IDxQaWVyLkJlcnV0b0BvbnNlbWkuY29tPjsgU2VsdmFtYW5pIFJhamFnb3BhbA0KPiA8U2Vs
dmFtYW5pLlJhamFnb3BhbEBvbnNlbWkuY29tPjsgTmljb2xhcy5GZXJyZUBtaWNyb2NoaXAuY29t
Ow0KPiBiZW5qYW1pbi5iaWdsZXJAYmVybmZvcm11bGFzdHVkZW50LmNoDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggbmV0LW5leHQgdjQgMDAvMTJdIEFkZCBzdXBwb3J0IGZvciBPUEVOIEFsbGlhbmNl
DQo+IDEwQkFTRS1UMXggTUFDUEhZIFNlcmlhbCBJbnRlcmZhY2UNCj4gDQo+IFtFeHRlcm5hbCBF
bWFpbF06IFRoaXMgZW1haWwgYXJyaXZlZCBmcm9tIGFuIGV4dGVybmFsIHNvdXJjZSAtIFBsZWFz
ZQ0KPiBleGVyY2lzZSBjYXV0aW9uIHdoZW4gb3BlbmluZyBhbnkgYXR0YWNobWVudHMgb3IgY2xp
Y2tpbmcgb24gbGlua3MuDQo+IA0KPiBIaSBBbmRyZXcsDQo+IA0KPiBPbiAxMC8wNS8yNCAyOjA5
IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4gPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUNCj4gPg0KPiA+IE9uIFRodSwgTWF5IDA5LCAyMDI0IGF0IDAxOjA0OjUyUE0gKzAw
MDAsDQo+IFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiA+PiBI
aSBBbmRyZXcsDQo+ID4+DQo+ID4+IE9uIDA4LzA1LzI0IDEwOjM0IHBtLCBBbmRyZXcgTHVubiB3
cm90ZToNCj4gPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiA+Pj4N
Cj4gPj4+PiBZZXMuIEkgdHJpZWQgdGhpcyB0ZXN0LiBJdCB3b3JrcyBhcyBleHBlY3RlZC4NCj4g
Pj4+DQo+ID4+Pj4gICAgICBFYWNoIExBTjg2NTEgcmVjZWl2ZWQgYXBwcm94aW1hdGVseSAzTWJw
cyB3aXRoIGxvdCBvZg0KPiAiUmVjZWl2ZSBidWZmZXINCj4gPj4+PiBvdmVyZmxvdyBlcnJvciIu
IEkgdGhpbmsgaXQgaXMgZXhwZWN0ZWQgYXMgdGhlIHNpbmdsZSBTUEkgbWFzdGVyIGhhcyB0bw0K
PiA+Pj4+IHNlcnZlIGJvdGggTEFOODY1MSBhdCB0aGUgc2FtZSB0aW1lIGFuZCBib3RoIExBTjg2
NTEgd2lsbCBiZQ0KPiByZWNlaXZpbmcNCj4gPj4+PiAxME1icHMgb24gZWFjaC4NCj4gPj4+DQo+
ID4+PiBUaGFua3MgZm9yIHRlc3RpbmcgdGhpcy4NCj4gPj4+DQo+ID4+PiBUaGlzIGFsc28gc2hv
d3MgdGhlICJSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvciIgbmVlZHMgdG8gZ28NCj4gYXdh
eS4NCj4gPj4+IEVpdGhlciB3ZSBkb24ndCBjYXJlIGF0IGFsbCwgYW5kIHNob3VsZCBub3QgZW5h
YmxlIHRoZSBpbnRlcnJ1cHQsIG9yDQo+ID4+PiB3ZSBkbyBjYXJlIGFuZCBzaG91bGQgaW5jcmVt
ZW50IGEgY291bnRlci4NCj4gPj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLiBJIHRoaW5rLCBJ
IHdvdWxkIGdvIGZvciB5b3VyIDJuZCBwcm9wb3NhbA0KPiA+PiBiZWNhdXNlIGhhdmluZyAiUmVj
ZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3IiIGVuYWJsZWQgd2lsbCBpbmRpY2F0ZQ0KPiB0aGUN
Cj4gPj4gY2F1c2Ugb2YgdGhlIHBvb3IgcGVyZm9ybWFuY2UuDQo+ID4+DQo+ID4+IEFscmVhZHkg
d2UgaGF2ZSwNCj4gPj4gdGM2LT5uZXRkZXYtPnN0YXRzLnJ4X2Ryb3BwZWQrKzsNCj4gPj4gdG8g
aW5jcmVtZW50IHRoZSByeCBkcm9wcGVkIGNvdW50ZXIgaW4gY2FzZSBvZiByZWNlaXZlIGJ1ZmZl
cg0KPiBvdmVyZmxvdy4NCj4gPj4NCj4gPj4gTWF5IGJlIHdlIGNhbiByZW1vdmUgdGhlIHByaW50
LA0KPiA+PiBuZXRfZXJyX3JhdGVsaW1pdGVkKCIlczogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cg
ZXJyb3JcbiIsDQo+ID4+IHRjNi0+bmV0ZGV2LT5uYW1lKTsNCj4gPj4gYXMgaXQgbWlnaHQgbGVh
ZCB0byBhZGRpdGlvbmFsIHBvb3IgcGVyZm9ybWFuY2UgYnkgYWRkaW5nIHNvbWUNCj4gZGVsYXku
DQo+ID4+DQo+ID4+IENvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSB5b3VyIG9waW5pb24gb24gdGhp
cz8NCj4gPg0KPiA+IFRoaXMgaXMgeW91ciBjb2RlLiBJZGVhbGx5IHlvdSBzaG91bGQgZGVjaWRl
LiBJIHdpbGwgb25seSBhZGQgcmV2aWV3DQo+ID4gY29tbWVudHMgaWYgaSB0aGluayBpdCBpcyB3
cm9uZy4gQW55IGNhbiBkZWNpZGUgYmV0d2VlbiBhbnkgY29ycmVjdA0KPiA+IG9wdGlvbi4NCj4g
U3VyZSwgdGhhbmtzIGZvciB5b3VyIGFkdmljZS4gTGV0IG1lIHN0aWNrIHdpdGggdGhlIGFib3Zl
IHByb3Bvc2FsIHVudGlsDQo+IEkgZ2V0IGFueSBvdGhlcnMgb3Bpbmlvbi4NCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gUGFydGhpYmFuIFYNCj4gPg0KPiA+ICAgICAgICAgIEFuZHJldw0KPiA+DQoN
Cg==

