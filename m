Return-Path: <netdev+bounces-119202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F76954B2E
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 15:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971FF28301B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 13:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EF11BC07F;
	Fri, 16 Aug 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="KR64JcVL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD631B8E84;
	Fri, 16 Aug 2024 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815403; cv=fail; b=dp2tVB/2dpXyq4bULEUrb0jHJ5QAOd3b9tia4R6hWj0xtPodGu86T9H+bMb2LcTEc/jubKKkQnUmTMQDftmELX5gjqLZQm2FrJMyo7UhUh19/soLWFffiQ6xIZRuUAMdunLFnudIu3fDHTOJlfjM/WMJ6UG2pRNWyxGXayLEMGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815403; c=relaxed/simple;
	bh=7oN83zL5cxdtWjNmOXy3wMvV+wnPZWW/0HjTfFYZva4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=OI1ujRnw2PQc9OLTTAKSlCAIUV1PuOAdZHIJSj/4tmWEWnFRu6rgmcaYVFQATbWXMXTF2IsEg/1Dy76gRiTHoGmUcjI8NmxRtvVi6u0jl2zxvsgKSrp2s0Ujwvvs1Pz7HZqhTyzcUtCDfk0vOuyKrbOEUG+hTDkrUetyTABKI5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=KR64JcVL reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GDNDOa013531;
	Fri, 16 Aug 2024 06:36:28 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4127khg29u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 06:36:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnmcD/sxHM9h8OxYnRIedi5tiGYHJWzfHjEexVNHm4hOffqBCf99H7newp1PzYVQ8Nx/bW6FTu8WnfNTjnOeiv7vAdABoTUGefQIu8YXuJK6QaHZQH7Ax+5AdzORst94oZOIbm/vmZseg70ypV+BtiFxuMvkwEOimRlJMTkROoas2jScKCteSc8QFK2USgA6aJ1OtkERvsvZeoFEr9YaY2pqmSz6ioL1juM8ZBVxRZdm99oDdGFdUkNDst+Op5Djc4DOhkIT0i/SOUpOKHuCz1JgtIgKVEdO4Nl0c11F8qMnt0OpIPRN5XbQdhorx2s/RICncozi1SbdIPFJKvImqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3iSA85gaA0o05h8Xr365WrTl+9Bmg+mOxegb4lglxM=;
 b=G5mc94OhfEvLftcgmknRMacPRmzarvFUY2rzwQtWV7qRV12K7v5lndADz/BxlEvbefd8i2iAaGh5P61+LPmUgGbDYjzwpdCqEzkgmo7Xo6vfyoYaEljd4Vm+XzyF4mOuR8ZTBNDnLdIonO3GKI5S0RyuSybOyz4Y+nnGgp5/RjJ2LBWPaRs2D0sZD1rFs0LUSw2GEfSOacPCCKkukt6/8BlZgnN83FYCCxP9WcWRosnrWmXmwVE+GZbDU5yFYv8Vkr4P5oBFtr2Osh68t7SzO0deWi0puK7cdDDh2kSlNbCkwfVozdYwvBHyxGqubxKRnZ+PjlZHS/3XGYLlfzot9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3iSA85gaA0o05h8Xr365WrTl+9Bmg+mOxegb4lglxM=;
 b=KR64JcVLkYMg5pjts1HEeMqo0ufeErmqiqIrwaD0LQrDs1qkwEa3Ac8Fgnxi/NiHcJ2Ok2VI0XA2V3COZAX4Q+aj7eEx0TOM7jfvUlRW8JmKIJDQgIDK92uUzyL7ovtL47ZfzjA3yb5gH119hORe0kMoSDdduIIlviMSgAwDzDk=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by CO1PR18MB4650.namprd18.prod.outlook.com (2603:10b6:303:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 13:36:25 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 13:36:25 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v10 00/11] Introduce RVU
 representors
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v10 00/11] Introduce RVU
 representors
Thread-Index: AQHa5z1zsUxqTpm3eEqDP09JQaO5NLIdheiAgAxisDA=
Date: Fri, 16 Aug 2024 13:36:25 +0000
Message-ID:
 <CH0PR18MB43399A157452720075C21D99CD812@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240805131815.7588-1-gakula@marvell.com>
 <ZrTob59KQxzbcKhF@nanopsycho.orion>
In-Reply-To: <ZrTob59KQxzbcKhF@nanopsycho.orion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|CO1PR18MB4650:EE_
x-ms-office365-filtering-correlation-id: 8167f8a5-dd96-407f-39cb-08dcbdf86d04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3gvYTM4bDd0aVpXTlpPelY0NkZKbWNaVXB6Q20rdnVmcnhyZUUxUEIwYUdM?=
 =?utf-8?B?MlFHNXUrVnFiSFpucUNIekpWWEZHdXZkMVA2S2JJOUU2VFNWSDdoaWpPck0z?=
 =?utf-8?B?VFU0d3JLdU1YcjY0aWNvTENQT3Z6Z3VXalFlRVpoSCtRMXVGR1U0QTBxZU83?=
 =?utf-8?B?Zk05OG1rWEFza1JmRzEyb3hOdG5OU3FWWkFiOGxLdGRBdVRNMXBHaS9Jc3RN?=
 =?utf-8?B?UElsL3JkZjZ5R0VQTWZHaHVXN29YZVJ3bjN0Y1FwUVhvL2VadGtyQ1dUQitW?=
 =?utf-8?B?aXZqcXZHeUgrUDloSGFGdDcwRnFhajlTYzhlcHJ0THFRU3M1MFpSbTRWdCtS?=
 =?utf-8?B?bGszUmlBRnFsZ01vY201c0Evd3kyV0pXVGlxUnlPaFI5amRYQm5uZW9Sa0k3?=
 =?utf-8?B?c2J0M2VCWEVFWnEwNUUrS2VpRWg2SStKeGFhV2pZTTl1V2NXanpSYkExSVM5?=
 =?utf-8?B?QnlrOGs5SzF6QzNTeWxpWW1wMFhQL1d3YmpLSDdEWC9hcnV6UjYvaDJnMjR5?=
 =?utf-8?B?c0V5a0VicTJuTll6Mjh6M2xobEt3c0hKUU4zUkk2L1RLNEtwdG5BU0haSytF?=
 =?utf-8?B?a3plQ0xTRjBJMkpSNFIxNFg5Rk5DOWpucVNNZjkzR0hqRndMUm5XR0cxMjJn?=
 =?utf-8?B?dmdLUGd5N1VpL0tRVGdZMzVNVWI2OHVZVGRMK2dFb2c5VDhuSlVlUXdxUXFy?=
 =?utf-8?B?akJTY2l5N2lobCtSNjJlSXZBbENnZW0rTGxqdnRxTHFVandVcXJ5Z0c1VmhY?=
 =?utf-8?B?U2p5UU9mRnAwNGo1VlRvRXFTaUk4UXF3WVdKbmRlNDV2VDdadTViVG5VYktl?=
 =?utf-8?B?bU1xMHFOYXRtUGczRXVzWEg4NG1VWDJ3dHN6NnEyZXNyUTlOUlZBR3lvWnBn?=
 =?utf-8?B?Nm5ONDZTR3BwRWM1RVdKeHM3WGc0YWFqYkRrOWcrTnlsUzZ4MFNZWXBjdUN6?=
 =?utf-8?B?QnRaVVBjdUVnM2tNelA1Vkp6aEFES3JwSFI0ZlBGVno1TlZXUTBIdVZqNGdY?=
 =?utf-8?B?bHNoT3E2ZW9NK1pzM3V2Q3NJRENRRmE5R1VBdithN3pzQm1UTDloajl0cS8x?=
 =?utf-8?B?cFhhWDA3anRpeHN1K3FIaDk0bDJUeHVUWU9CQXdSTjNIN0s3R0lGcHdtRUhn?=
 =?utf-8?B?NkIxV2FDaXc2dVZNdDNYVThrcXdLMEhRT2lCNlNGaGI0eVVlMW5wSFFwc2dT?=
 =?utf-8?B?SEgzOG16Z1RDcThGa3RkUzNzTzBFMTI1M1RROFpaQVdWQVorNmd1SjBGOExO?=
 =?utf-8?B?MzdUOWpNN3cvb1lsalowV09GTTBUYTNSdTluODNudjVyWWRzeFhLQ0xqdHcx?=
 =?utf-8?B?dHN5M09MYkQ0TGdZblN4aTZkVE9Ic2ExamZxY2lSNXhOeEtydElVMjRPZ0NC?=
 =?utf-8?B?U3hiaGR6S0FTWkIyWTNrT3pIczdLaVV5WnVmOTUxWkRtTUxqazdNTCt4RHlv?=
 =?utf-8?B?SGZtN2dkOEFMNkpjY3g5VUZaNnIvMVl4Wk1EYWZZNTFPZjhTM25jVTYycUYy?=
 =?utf-8?B?czhhUSt4TEhVamRBWTlEWjdtbVQyRTNhYlNDQmNFcC9GN2pLOUhibkl1MzRo?=
 =?utf-8?B?OWZ6SW9uNFh2WFo3MWI1UzdaWU0wNVZuSlhsK0pFVTY3UXlvOVFTYmRPOHg2?=
 =?utf-8?B?SCtybTFURC9iYmZjL21kTDgzVzJBTXVKQWFnV1p2a3dieldyemFZVmwxN3dX?=
 =?utf-8?B?TElIcy9YNnByczUyWmI2MEo5OGdvV3NtTlZoSGUrNkkxT1JaaHRZMDhocGJy?=
 =?utf-8?B?eVRpOU10ZGhKdWd3a3krclNLdlRPQUxwYU16bUVqZStOWjhqTjZZSWY0akZQ?=
 =?utf-8?B?R0cwZUxWU004eHZnaC9HTzdwU2VnVU9NZE9VdXpabTR1SmFLWGxsWVJTNW1E?=
 =?utf-8?B?VFdqVVJXRGo2ZUM1cE8yVENvRHNCdndRMjc3WWZ1WXBMWEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SW5JbmlNdFVwSmFZdTFXcmFGVThHbUhIVTltMi9Xd3pSYjhwbEpKdE5uaVZt?=
 =?utf-8?B?Mnluc0tiOXpIQm8yRlZLYVpla0d5S1FtNHlBYlN2WHZpWUk2V0E3am55NnVZ?=
 =?utf-8?B?N0lNTjdXc0lyQkc4VlVEbmVqZkhBdWRmSnhzdmFwUThEYkpTYnhsN25JQTYv?=
 =?utf-8?B?RmRoNVBFU0lSVncxVHJWa2NLcmx1V0k0R29kditXdW56ZWs0VVpQNXE2aU05?=
 =?utf-8?B?SVN0bjIvaklSSmh6SVhZRGRvZTZwbWNndmViRkVmQzY1dWtaK1piMnFYdVBQ?=
 =?utf-8?B?RVBjVk9JT09LbGhsYXA4Sm1BN0ZRaDdsR1ZWT25ZVDZtTnhhdnltVHZSLzZm?=
 =?utf-8?B?RzdoZW0vdWh2U2VUcy9Vd21UWEtRQmhzZ2Y5eG1jNExHdkVZaWpZRjVPc0dQ?=
 =?utf-8?B?Z2xwZjA5b3pkOGRnL0xmK1RVQmdpNFpPWjFYT2ZyenBPZjNFNTVSQjZYaHBQ?=
 =?utf-8?B?TjI1Wi9mL1BQUk1PWWVuQldsM0lqeEtLbE1ZRGx6QWQrWGhQeTJpb25VVEM1?=
 =?utf-8?B?dWJKWnpNS1BvUXNqa1R3dXpOdkpsQzFhdS9MalJkalhpU3hUQ3BodHdLMUZl?=
 =?utf-8?B?SE5sU0lKbzB2amNDaGorVzN1WTg1Q29OcFFQS1gzTzdicEpvaGVqalVVU3Ru?=
 =?utf-8?B?ejZDUGNkWkZPY3VkNU5FcTJSWVdha3o0RlIrSjZWaGZySWhqNFNrMGkxZ3ow?=
 =?utf-8?B?b0hnTytPNmxGaVlnZy9iS3gzcXc3cHI1MkZicXdFR1NSSnNJdlFSL3VCeHlm?=
 =?utf-8?B?elEzZzJ5L0Z6UEI3SEdPbVVtSzNXcVFVbk1IWEp6TnlBWnJ3STdwelMvSmRN?=
 =?utf-8?B?amFkUndsbURCbVBxeGFjLzBVdUJWc2RkTDQ5d05ZWXhxYWJzemZzNUc2ckkr?=
 =?utf-8?B?a2dSRGNnNVViNG5ESTIwQlFQSlNvWFpHYkpla2FJWGtVWjV3RVEyTkdVWHZ1?=
 =?utf-8?B?VnIrV0trb0pFTzJVQnU2Y1I3cHc3TjZpdmRkZllQSjBpNHlBMEFvOTNXbEtD?=
 =?utf-8?B?aE9qbWswaFZLSGdRZzlTa3RNWVRodzQzOG51MWN6bVlNNkVncit4RXdDMmhp?=
 =?utf-8?B?a2FpMjByYUpyMGxWSklSNEFaeW9OMnFQZnc4b1B6QmFuaGZCVnFwNlgrOHBw?=
 =?utf-8?B?OEowWk94dnc2YTQ2cTVaNEJyZG8vNlRZckt3a2FwSXpzRG8zU3hTdGN2K3dH?=
 =?utf-8?B?RWVuQ3YwelhkVng0VTRySktjWCt0WGN1UW9ldHJYVmZQWXdCTnYveEdzZS9w?=
 =?utf-8?B?TFN0TlJIRTFuWWZTVXR1OFZOa1pGSlNoaDJlYnZmUE5sZFhrNmVDRHhXRHNT?=
 =?utf-8?B?SUY3NzNoY2tnblAzaksxNHpvd0RsbzhkOTlMamZCTGlGSGJLdWdDYy9hT1hY?=
 =?utf-8?B?d0xtNE9wb0Q4Z295ejRWL2NIY3pmb21lRm9wZHNmd0hKZ1pxc0NlYlZnaGN3?=
 =?utf-8?B?cEdyVVdCV3g4eTdXdUU4V1hXV0lEWThhZEw0YkZ0cU9RWGVlWHpyOEFEdFVi?=
 =?utf-8?B?NmVkcDBtS2tYVG8xSmxtd09UbkJjUUdtOFE1RFJTSkJCS0hSVXdTSzYraHN5?=
 =?utf-8?B?T2xQcWxySTliZ0k2TGxRZi9KN1hoMXNCY0ZwaGxNQnlYRUFubGx4d1hKc3Nw?=
 =?utf-8?B?SmpLaGFiVFBPc1pOWDZsdFVZQlVkQnpZdGRQd2x2VFhNQU9JVGlZdWdYc2ZY?=
 =?utf-8?B?Q1NCR3NNZ2F1MVJpNXdaYldlL0tabUxNTVRLVU1RY2R0bEI1WmhRMjVZc1Ax?=
 =?utf-8?B?TlhEbmt4cWlMRndBMHgrV1FNcjdxWGxMUXBKLy9YTy95bGs5NW15emRyMHpx?=
 =?utf-8?B?VWRSaHEveUkzWmgxYmtqSEt0SHorZGc0UjJNMGtHR0Mxb0Q0dkNpSHY3dW9E?=
 =?utf-8?B?TWJYUjl4R0NObmZPOEpJTEp4dTIrcWNNdFpWQitLYkxZVzIyMityQWJmNDB5?=
 =?utf-8?B?NURTbUh5WkRaTlVNNmFRL0FBY3pIYnRmWE1lRVpKSEtzTUQ3OEtpNGdwcGpw?=
 =?utf-8?B?MU83NUYvUEZYdVo5YTBjUWgyUWE2dDZvb0ZSdzRTMlRrV0VhU3JqM0I5cGdW?=
 =?utf-8?B?OVVIUytGL1I4cFFrOFFDWjJFOGVPc0Q5MjBQNmVub0RSdXZseTFtOTBRSlgx?=
 =?utf-8?Q?Kvoc=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8167f8a5-dd96-407f-39cb-08dcbdf86d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 13:36:25.7738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5s2FLkjbue4Rq7pZEYMr9Hp+TXax3iuS+UnMWHdtNCK5oH3VxeIMTlUgQLKUTCXfRLIueOA6zpYN8/ZOGhlgJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4650
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: HYp1BAPY7g89SEn0qM5PujEXn_C0ffAx
X-Proofpoint-GUID: HYp1BAPY7g89SEn0qM5PujEXn_C0ffAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_05,2024-08-16_01,2024-05-17_01



>-----Original Message-----
>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, August 8, 2024 9:17 PM
>To: Geethasowjanya Akula <gakula@marvell.com>
>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>Subject: [EXTERNAL] Re: [net-next PATCH v10 00/11] Introduce RVU
>representors
>
>Mon, Aug 05, 2024 at 03:=E2=80=8A18:=E2=80=8A04PM CEST, gakula@=E2=80=8Ama=
rvell.=E2=80=8Acom wrote: >This
>series adds representor support for each rvu devices. >When switchdev mode
>is enabled, representor netdev is registered >for each rvu device. In
>implementation of=20
>Mon, Aug 05, 2024 at 03:18:04PM CEST, gakula@marvell.com wrote:
>>This series adds representor support for each rvu devices.
>>When switchdev mode is enabled, representor netdev is registered for
>>each rvu device. In implementation of representor model, one NIX HW LF
>>with multiple SQ and RQ is reserved, where each RQ and SQ of the LF are
>>mapped to a representor. A loopback channel is reserved to support
>>packet path between representors and VFs.
>>CN10K silicon supports 2 types of MACs, RPM and SDP. This patch set
>>adds representor support for both RPM and SDP MAC interfaces.
>>
>>- Patch 1: Refactors and exports the shared service functions.
>>- Patch 2: Implements basic representor driver.
>>- Patch 3: Add devlink support to create representor netdevs that
>>  can be used to manage VFs.
>>- Patch 4: Implements basec netdev_ndo_ops.
>>- Patch 5: Installs tcam rules to route packets between representor and
>>	   VFs.
>>- Patch 6: Enables fetching VF stats via representor interface
>>- Patch 7: Adds support to sync link state between representors and VFs .
>>- Patch 8: Enables configuring VF MTU via representor netdevs.
>>- Patch 9: Add representors for sdp MAC.
>>- Patch 10: Add devlink port support.
>>
>>
>>Command to create PF/VF representor
>>#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev VF
>>representors are created for each VF when switch mode is set switchdev
>>on representor PCI device
>>
>>#devlink dev
>>pci/0002:01:00.0
>>pci/0002:02:00.0
>>pci/0002:1c:00.0
>
>What are these 3 instances representing? How many PFs do you have? 3?
>How many physical ports you have?
The test setup has 3 PFs one for each physical port.

Below example is for the device pci/0002:1c:00.0.
>
>
>>
>>#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
>>
>># ip link show
>>	eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>mode
>>DEFAULT group default qlen 1000 link/ether 7e:58:2d:b6:97:51 brd
>>ff:ff:ff:ff:ff:ff
>
>What is this eth0? Why isn't it connected to any devlink port?
>
>>	r0p1v0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>mode DEFAULT group default qlen 1000 link/ether 7e:5a:66:ea:fe:d6 brd
>ff:ff:ff:ff:ff:ff
>>	r1p1v1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>mode DEFAULT group default qlen 1000 link/ether de:29:be:10:9e:bf brd
>ff:ff:ff:ff:ff:ff
>>	r2p1v2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>mode DEFAULT group default qlen 1000 link/ether 4a:12:c7:a2:66:ad brd
>ff:ff:ff:ff:ff:ff
>>	r3p1v3: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>mode
>>DEFAULT group default qlen 1000 link/ether c2:b8:a8:0e:73:fd brd
>>ff:ff:ff:ff:ff:ff
>>
>>
>>~# devlink port
>>pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf controller 0
>>pfnum 1 vfnum 0 external false splittable false
>>pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf controller 0
>>pfnum 1 vfnum 1 external false splittable false
>>pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf controller 0
>>pfnum 1 vfnum 2 external false splittable false
>>pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf controller 0
>>pfnum 1 vfnum 3 external false splittable false
>
>You are missing physical port devlink instance here? Where is it?
pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf controller 0 pfnum=
 1 vfnum 0 external false splittable false
This is for the PF.

Below is the example on a setup with one PF before  3VFs are created.

#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev

# ip link show
	eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
DEFAULT group default qlen 1000 link/ether 7e:58:2d:b6:97:51 brd ff:ff:ff:f=
f:ff:ff
r0p1v0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
mode DEFAULT group default qlen 1000 link/ether 7e:5a:66:ea:fe:d6 brd ff:ff=
:ff:ff:ff:ff
r1p1v1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
mode DEFAULT group default qlen 1000 link/ether de:29:be:10:9e:bf brd
ff:ff:ff:ff:ff:ff
r2p1v2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
mode DEFAULT group default qlen 1000 link/ether 4a:12:c7:a2:66:ad brd ff:ff=
:ff:ff:ff:ff
r3p1v3: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
DEFAULT group default qlen 1000 link/ether c2:b8:a8:0e:73:fd brd ff:ff:ff:f=
f:ff:ff

Above shows the PF physical port and 4 representors(1 for PF and 3 for VFs).
# devlink port
pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf controller  0 pfnu=
m 1 vfnum 0 external false splittable false
pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf controller 0 pfnum=
 1 vfnum 1 external false splittable false
pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf controller 0 pfnum=
 1 vfnum 2 external false splittable false
pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf controller 0 pfnum=
 1 vfnum 3 external false splittable false

>
>>
>>
>>-----------
>>v1-v2:
>> -Fixed build warnings.
>> -Address review comments provided by "Kalesh Anakkur Purayil".
>>
>>v2-v3:
>> - Used extack for error messages.
>> - As suggested reworked commit messages.
>> - Fixed sparse warning.
>>
>>v3-v4:
>> - Patch 2 & 3: Fixed coccinelle reported warnings.
>> - Patch 10: Added devlink port support.
>
>
>When someone reviews your patchset at some version, you put him to cc list
>from that point. Why didn't you put me to cc list?
>
>
>>
>>v4-v5:
>>  - Patch 3: Removed devm_* usage in rvu_rep_create()
>>  - Patch 3: Fixed build warnings.
>>
>>v5-v6:
>>  - Addressed review comments provided by "Simon Horman".
>>  - Added review tag.
>>
>>v6-v7:
>>  - Rebased on top net-next branch.
>>
>>v7-v8:
>>   - Implmented offload stats ndo.
>>   - Added documentation.
>>
>>v8-v9:
>>   - Updated the documentation.
>>
>>v9-v10:
>>  - Fixed build warning w.r.t documentation.
>>
>>Geetha sowjanya (11):
>>  octeontx2-pf: Refactoring RVU driver
>>  octeontx2-pf: RVU representor driver
>>  octeontx2-pf: Create representor netdev
>>  octeontx2-pf: Add basic net_device_ops
>>  octeontx2-af: Add packet path between representor and VF
>>  octeontx2-pf: Get VF stats via representor
>>  octeontx2-pf: Add support to sync link state between representor and
>>    VFs
>>  octeontx2-pf: Configure VF mtu via representor
>>  octeontx2-pf: Add representors for sdp MAC
>>  octeontx2-pf: Add devlink port support
>>  octeontx2-pf: Implement offload stats ndo for representors
>>
>> .../ethernet/marvell/octeontx2.rst            |  85 ++
>> .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
>> .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
>> .../ethernet/marvell/octeontx2/af/common.h    |   2 +
>> .../net/ethernet/marvell/octeontx2/af/mbox.h  |  74 ++
>> .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
>> .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
>> .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
>> .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
>> .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
>> .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  81 +-
>> .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
>> .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
>> .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 464 +++++++++++
>> .../marvell/octeontx2/af/rvu_struct.h         |  26 +
>> .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
>> .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
>> .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
>> .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
>> .../marvell/octeontx2/nic/otx2_common.c       |  58 +-
>> .../marvell/octeontx2/nic/otx2_common.h       |  84 +-
>> .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++
>> .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 +++++---
>> .../marvell/octeontx2/nic/otx2_txrx.c         |  38 +-
>> .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
>> .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  19 +-
>> .../net/ethernet/marvell/octeontx2/nic/rep.c  | 725 ++++++++++++++++++
>> .../net/ethernet/marvell/octeontx2/nic/rep.h  |  53 ++
>> 28 files changed, 1962 insertions(+), 227 deletions(-) create mode
>> 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
>> create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>> create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>>
>>--
>>2.25.1
>>
>>

