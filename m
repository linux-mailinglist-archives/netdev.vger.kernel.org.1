Return-Path: <netdev+bounces-210060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE3DB11FCD
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8791CE5031
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4851E833D;
	Fri, 25 Jul 2025 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VpSyw4Bz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KRG78rdn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B4D1C6FF5;
	Fri, 25 Jul 2025 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452476; cv=fail; b=cwDJPHawVh70vGGXslRAddvUJqW9zwxia+kdwahOkZojWFP52+U1hENXe5r6GYfpiNJbVIv0I1vpthIBReei1tHJB0lhl5dICszXQGDZ11pYvsL7pdfTBZqmi9Wd8vOej6JT1umsT97t3DBTjGfiBMb9mGOpNjSX9icEfJ0+2zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452476; c=relaxed/simple;
	bh=N/iWU7ieckn3eVd1YQQL2HlrRZGNduATvMVQB3hCDoI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W25GggYUL2IgS3X/BTTxRL3gI1xK3fB3rjktEzN8dXEHWdEo/QUTgZbRwJFkxQp4mi5KtKgFhXMJ3tB2zwLsP3HLFE15DZ6zAgX16UFacahy+0ETUYyfJ6tBkANuxznx1uHXOuvvz1z2mgspsm/EbHYaYuDFnlTEzKRjof9CYr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VpSyw4Bz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KRG78rdn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PDfsCQ023049;
	Fri, 25 Jul 2025 14:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3x+TxqOBzshQFjByeju9Y4xrkxfzzzoAww01WH/MlPg=; b=
	VpSyw4BzV69pN1D4Ss7k/xR652S7qUjsZAv0apMK9Lqp2qvxzxE7GHREUR0NoZDV
	wBbIcjUxL6jwRVWX3HnkkqQ1wDTbaiIS+GTQ/4Mk9TYEeWd0mWD6VnqgRSwdXdam
	YOg5dy6eOTVIqRa6DAcVnXd9q7u3N85Pa/lnTKmw8shfIxf9ed0NwBGtCig3rS1R
	b4srA4l9qFzkKISvcsUQrohbMB/PoarLzM5+WNfSHJ+CsGBkxPtPGm+T/RVQJSCQ
	MwjC7gFe12bdEOzkn8Fj+6K4xzfULst6SE9fdDhXC5MNjjtnM1i6WIFmBmtUR7oO
	/hBrc7N23Mbz86PllNB+ng==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1k14mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 14:05:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PD8imN010434;
	Fri, 25 Jul 2025 14:05:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801td3nm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 14:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdpVt8lViKBDDyIqFII1bdvszeGDxmPGKlXe3gUAZmilTk1llkMa+4g06Fkx0wSR2MkZsETWDijhOdnYpxXj4teMaPgOljH1vqYWUGdL+duCW3RCaJHwsIh2PaTT3cAR/d5NA7Ue5muba8kdo6CNiM1mGeMSGcF7/VQsnI3diBl3jeCg1JnQXr0N2nu+Pr+ccUtQlJ1pj4BBNxeExYjnzu5GiN+ktOFFQ1vhq3mLV1kc/sNvLq2PST7u1M5UTdJmEfOQKd5lbN56BNOBKRoR/5fXSWuogoADNaCnWex1tmb37U15npe734/PHBAmmJAk6T24gNg/nemxZ0zI0Yc4Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x+TxqOBzshQFjByeju9Y4xrkxfzzzoAww01WH/MlPg=;
 b=Pv4mfHEABfgdv9KqZ7moWcoC1yRYO6tK4411cSasmpKpDTXF/jHay7TcwgB5EMqTU9LGMXYYrtqd7xXOSPZN3w+zpAjbosqfh7q1HUsRdIJwpIUVC7IrCbmdfqB6/4SoKirSEgGiWkRkLAAgrcIT0LMf9KsWzvdYmwL4Bws5zIx9PxNKvqk8YRlhrqv6wJqr41C9ygDQIXrE7Q/CgEiPoRCrdTf7Csk6r7Px4EowfNVvT3+uq5fllnr01sqiYdkFGODo/qj/ixDlMxwdKdX9ETUjxDiIHO0b2ZxkJmG30z6EDZ+rngyzFBaXDB8fqJL6PAny7tBIqC3gRnPFBebABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x+TxqOBzshQFjByeju9Y4xrkxfzzzoAww01WH/MlPg=;
 b=KRG78rdnCDDMmpb572sEA5a7P9J9E+NH1frfE4Oh0bgi9xUnRNbSSyUQs564NI+uFesg1FHiAmlYTyf5xOhBjUFIgkoAWb3/SuDMR68CtDsPcRXEXq3OOVUZKAnOZ+Lwgtens8q5CAqlRNOII+fokAlZ/cIlXx09+Sd/G/4/zo8=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH3PPF5FDE66ECB.namprd10.prod.outlook.com (2603:10b6:518:1::7a6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 14:05:16 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 14:05:16 +0000
Message-ID: <3502ed81-7d97-4a01-806f-5c5ae307b6af@oracle.com>
Date: Fri, 25 Jul 2025 19:34:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 5/5] net: ti: prueth: Adds IEP support for
 PRUETH on AM33x, AM43x and AM57x SOCs
To: Parvathi Pudi <parvathi@couthit.com>, danishanwar@ti.com,
        rogerq@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        ssantosh@kernel.org, richardcochran@gmail.com, s.hauer@pengutronix.de,
        m-karicheri2@ti.com, glaroque@baylibre.com, afd@ti.com,
        saikrishnag@marvell.com, m-malladi@ti.com, jacob.e.keller@intel.com,
        kory.maincent@bootlin.com, diogo.ivo@siemens.com,
        javier.carrasco.cruz@gmail.com, horms@kernel.org, s-anna@ti.com,
        basharath@couthit.com
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vadim.fedorenko@linux.dev, pratheesh@ti.com, prajith@ti.com,
        vigneshr@ti.com, praneeth@ti.com, srk@ti.com, rogerq@ti.com,
        krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
References: <20250724072535.3062604-1-parvathi@couthit.com>
 <20250724091122.3064350-6-parvathi@couthit.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250724091122.3064350-6-parvathi@couthit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0288.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::16) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH3PPF5FDE66ECB:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d685fdd-264e-4182-2790-08ddcb8447c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjYyTy9PUEJtWEJkRlk5aVRLcEloWFpwM0xSejR2b1o3QXF3WEVhUTUrb0RK?=
 =?utf-8?B?UndwYWRxZCtEZmZXOWw1NE1USlNtc0JFbGZEbVdhUDVqa0FGZUlLVDd4ZFcr?=
 =?utf-8?B?RDlPbWV1TnlEVnFiWXBpUWR3SCs0WnIvWTIyUzJyRkNNSk01K2lGbmw4OTho?=
 =?utf-8?B?SEVudWZINlJ0ZXpvOVNTOFcrQlVLQjVjYVpOeVV2RGE3NGJxdkRMOHMxRnBz?=
 =?utf-8?B?QWg4bW43RENaVkQ4WUtTNTJ0M2p3VmhFNUhkQytVbkRLcVV6cTNreWFFcUps?=
 =?utf-8?B?NlJxRlBwZlNwYnJLZldHNlpUS2RKOUlZTDIwOE9MQ3dTMWYyMm5mbythZ1ln?=
 =?utf-8?B?c0JmNWVwRFBRNVZSamNjZUticnFieVdpMURYRXpPVjVFam1mNWlHTGNvOGZ0?=
 =?utf-8?B?MzdkZHNWVE1OQ1dCTkR5VVlPcTRCTmsvc3FjWnlSWUtDYmVkelFqWCtMUG9T?=
 =?utf-8?B?MzQyZFdtaWtlNk9Db3BnbVlYMTNCMFdCSS9CUWJyY2pUK2pkM0h6NTAvN1Nx?=
 =?utf-8?B?SzBlZ3NFQVFOTFp4cW4wUmxScWVBOTRTZDBzL05UR2xBbS9JTmZMWWNSd2JD?=
 =?utf-8?B?MExTUnNPdWFQeSt4N0xRNnBBMUgyTldsdFMwbFlhS2JBVGVvVDRYa1RlL1VN?=
 =?utf-8?B?dUlQVWRkdTc3cWl3Ty9uaU9pN2ZqTWg3RS9kT2M3eGozVGlUUFk5ME1NWlYw?=
 =?utf-8?B?dXQ5U01sak9yeGlldDh0Slk0djM1ZUZ6WFdnTVRrTk92K1pBWldTRzg0TFhy?=
 =?utf-8?B?NGlsY2RGQjZGNGZoODlkcmMvdXVVNTZHeEtwOXJpeHRrTjZkMmtTN0RWNm9s?=
 =?utf-8?B?QWM2YVE0K0Z4LzlnQjJKcS9ta3dONDYyOXNPSGVIbFVWODI2RXVsb1ZJK2s3?=
 =?utf-8?B?dmVIOEhOcS9GVjl5WUI3eXcvT3dPK3pyZytENTQ1MS9LeDdmNkdQb2U4Y0RW?=
 =?utf-8?B?ckJuQlprNnQ3NExjamJ5NGFWd29LZGZBSlBRWDRuSXY4OGxIQkkwZHVoRHV0?=
 =?utf-8?B?UHgzaGFXVk85Q3VXOFM1U3FCZnE4K3VFVWZ6c2RnWDZ5MStNczFrd3dxM3li?=
 =?utf-8?B?ZzBZdGYrUHAzVjlaK2FVZGtaeENWbjhTQ2VWc1BzMFhTeGliU2FUNzRZdmND?=
 =?utf-8?B?UkNmdFhkbFVKcndDMlVza3FhQkZ4azZDaFYwc3Jyeis3bjlJNXJRa2oveE5I?=
 =?utf-8?B?YTFvam92UHMxa2dsRCtWTjRIUG9MMjFkdUZRWlp6a1lXYmJKQ3F6ZzdXM3JZ?=
 =?utf-8?B?ek9Bc3JVTW1wSjVGRGU0Y1ZNRnVZcXZiRFZucE5BaVNLVmlzZm9RUkh0R0Ft?=
 =?utf-8?B?blpya21xNkk3dVFtR0R6bmwrSlZMVFRkWjJITG14TXFzaVBBRW96OEJqVnlN?=
 =?utf-8?B?aVVjcUZpMmhMbGpZcGZIOTVhQU1nbkpNaEFrZi85S2wrcTluaW9rZkdqTXA1?=
 =?utf-8?B?NldGL0dibFlCemFWQmRWYzNHUEFnVlR6bnlqQWhWVUkyQndPLzFNdlk0dHo5?=
 =?utf-8?B?d2sxeU1rOEpCRE1WdUZCbXJUR3haNlRSMEV1RFVaN05ydnFOOEZSd0VZaUFC?=
 =?utf-8?B?c0IrdVFRSDVqdzN5NTZBTnhOWUJncCtrc2JnN2JTZFRGWm9nQjUyN0NLWGRQ?=
 =?utf-8?B?OUhkQ1RrRGd4MUU3cGRqVkZPb2N2SHVraURudW4va3ZLdyt0MEthWnZMazdC?=
 =?utf-8?B?bEprcWpYcDVVeXd4MDlNMDczTkdtZGxjMDBlcEYwSURIaHVJb1NFbXBPaDZs?=
 =?utf-8?B?Rm5LU0ZieVRRbEphUzRBNm02eHZlVlNXM2lIczgyUzdzcEd3TTR6RzVBNWxB?=
 =?utf-8?B?WFNHTkljc05PMnRLRC9BVndYQWhnbGR6RVo4MWtLS0hNdG9wUDNVUWVRM29U?=
 =?utf-8?B?WFJocFNFZnRvckJSREl5blNaR05RUW91TDd4VGUyTG5LQmZvTGdXNXViUk1P?=
 =?utf-8?B?RXZ0d1BwOFAzZlBvWi9QaG5pVTlIS05JTEo5WlpGZHJzcElWYy80K3cxMS90?=
 =?utf-8?B?b0VCenY5K0d3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTEySkcvSW9JNENyTTUzTmROODJ6U0ZzcVBCRVVqN3VlbkVMNUg2Q2dMSXVP?=
 =?utf-8?B?a3VBNVhtNGthYTkvOElMdGM2NEYwSjdOR0xBUFJ0Z3R5T3JjYzVQL01uTkFy?=
 =?utf-8?B?LzhXSStZZnlTMjNMZUJPL2t6MXBiU0NCQUo4ZWxXWlJuRGhReGtpeTB1MGJM?=
 =?utf-8?B?R3ZtOUV2N2J1Q045RG9Uano4ZTJNWU5lZFdHdDNWZTNOL2xHQVhqdjYxMnNo?=
 =?utf-8?B?bkhSTlJVSk9QVkowUEtRaTltTTNvck1KM1FmeW9sUWUzWWY4bmlwZWs0N2Vj?=
 =?utf-8?B?eUZJTitOaFpYL3BuaVY3anR0VEJEYUtpbGlPVDhodjJMbjBic0NpMG8wZWNV?=
 =?utf-8?B?QTJ5MU15djB5UmJMSVRGbVhWcUR4YUdJcFNVVTB2WkNBaVVIY3h5cnN3UGpn?=
 =?utf-8?B?UklzLzdRVE9SekkxSG1PVkI5WS9UdEVReldtRnlKeGtGMUJOa1ZNc25PRG5j?=
 =?utf-8?B?N2Z0TXFoNHZ6SWpBQy9uYWxsOWFnTGR5eWF0Rm5Eb1psMzRzYzAza0E1akEv?=
 =?utf-8?B?QnNoeTRseDRKdkViOGpCMWh5Q1pYcEhuNDEvMWh5UVdHbENBVDZlY0MzdkYv?=
 =?utf-8?B?VUR4YlhpeDV4NU9pZDJDN2RxUzQ3dDBvaXBsc0hONUlrKzdtZk1DQkVWRVpB?=
 =?utf-8?B?dFVNbVp6YUY0bWo0MXFjV05DVXpuY2dLaXRTdlBPU3lZRHJncUJSSStJVTZw?=
 =?utf-8?B?WEM1d1FGbExHOXI5RUZzaFJNbUxlenk3YzM0RXBNZjBNK08wbzZLakVlVFRC?=
 =?utf-8?B?VmNLV0pQaXViT2F0TkdCNjlGakVUN3kwR09lWmFBMk9kNS9UMWo3bGVSWGdS?=
 =?utf-8?B?MnREQlA5eWFKekFLVjFjUFZ2b3RGQXZIVzJBZUZLQzBIN0NYejczaC9YYWds?=
 =?utf-8?B?RXp3T2JCWTdna2U1aFpFL1pvOFBlOWJKVnQ1MmRPTm1KYWwxRllKZWJLT1pT?=
 =?utf-8?B?dFlBSXRBRk5EN0FBUWJVWGdXanIzdlFzQnROZHlTUWw4NFVpSzEyclJEVzZn?=
 =?utf-8?B?dmJoOEFaOTJmSStXN0VmSFhJbFRGbWdQR2xLQzEzS3ZtTGhlSURINVUwcXg1?=
 =?utf-8?B?S1pLejI3T3pJQUlBNWdkL25rR0hCMWxtdXhMbk11dUwvMGtqK3FvUVFvSGpt?=
 =?utf-8?B?a1RCRDNTazYwR01mdERDTktON1ZTeUwyZUpKL0RGTDVBVGg5eHByWTlrN0Vy?=
 =?utf-8?B?N1psVkJQZW4wa2l2V2dkMEZQQ0s3akpGTXRBYWViRUtodWg5bThBZ21LZHB4?=
 =?utf-8?B?cCtyQ1VFNStJVjNXbXdXUTA2RFdsaWJQVnZqMzRRTVREcjh5QTl2ZVEwaStF?=
 =?utf-8?B?MzBvUzZZU2cyZSt0UFdzVEZvclZDcXh4ZEtHY0RKT0N3WmlGR2RyNitPVWtx?=
 =?utf-8?B?OWRHQXRHUEhHTVlScnZBbFJhVjFHbC9xTlBHNUNydGowL0N6WXdLMHlyY0xN?=
 =?utf-8?B?b1creVNaVm9FZ3I2T1lua28zbEF6aXhMN2pyVVR3M1FXOFVxK0ZOSU9yejNZ?=
 =?utf-8?B?c1V2Y1lCdTl5enRUZW9kQnFDS1BPMGl6eWdZRm1IL2Q2QVJNaGM1SlJqbUJ6?=
 =?utf-8?B?eWdiNW90SHhEQmJ0YStwdW0yLzFTTlcyMyt5WlY5YWtYMkJzQXRvVTF2dk5K?=
 =?utf-8?B?VzVBVFN2MCs0TG56UThxWjNZQVhnTFBocWJxZDlXWjVSUWp5UzNCVkQxZHhl?=
 =?utf-8?B?aGFPbEJtbm1wTzhJZVBIeXpnbmprSUJUUTNuVk41ZHFkYUdKTjFhTnQ2QkFv?=
 =?utf-8?B?WVFncTBoV1BkWVRXbzRWa0wybWUraGo5S2VSVnFzRklCU0x1SGQzdEErSVBq?=
 =?utf-8?B?TERROVU2cGEySVQ2Z05QSThhaitaYjhPZlROL1pZMXkvbjdIbTdpblA1bWhT?=
 =?utf-8?B?SFJzRTBUTWgvcTJLeXoremVwd05WK1dzSGhQbHAzOThFTXN4ZFk5TlRIUkI0?=
 =?utf-8?B?SzFhQW9UWmd6SDkrYnRtWGxFT0xZUy9oRDZzVjFteC9tWlozL1ZrMlh0QjZD?=
 =?utf-8?B?ZmtPSjBabW04dzdGZ2s2Ylc5VU9tRFNvQzBmdkFrWGFuQWxsbzB6Y2ZFTTNZ?=
 =?utf-8?B?NEo0Y0hIcDljVWh1SFJGcUsvNWlzWHdZekR0dHhDbGZReUhsT3JRM0V6Q0dE?=
 =?utf-8?B?dHJSSmg2dHNUeHllZ3BWWm1BR2ppSFNOUjlkZU5wNjU0UnhtOHA2Zy9vZTlU?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mJMJFgQubYmEy365ItH/f5wYGOa2qm5zuOL6mw/5tByCSVrsj/6qC+bFEy1mxB32gPv43tzzP6j2tSbdrp2uJbY7N4zMsekZcncPak1iS33cYAOox5PENE4mL0CnMCfGpdSyIDY0742DGCU7y7TI2D7lrQxFiFps/SItqh/maO5eKvcXsZNtZuCTd3y+qs8QeZQ5VJHRrCxdtt6DDQe1sk6UWxZ+Cf8gKY0EKjm8JWJBAaVfH8rnXT8I/dopolDnLFss1UbVm1MEaANvK1o8rErc0MICEFkMjhC6m2DIU5bcMXOgke7wUvz+FIBvNtdiUoRK+lIDSQa8vtGDkW6ngw5TSEglx+cXm8qNvHntlf8M+fUqWfsBtwlume3URi7YBAtnqx4c9WRyqGlY8Nl3BIWFaqksd0unfZyYDW9FYruGMq+EM9/hD78mp5fJAjW1lsJGYKeBC2INdfu/K5IYiJHTBg7UFsEV5tDw1P+hjXc9miRagFoHY4xLFnTK1d4h9iOYKo2zj5tf6/ha1o8nWh3+WcoRxI2XtR3OGWp+jQx0iO1XUxBm9TQphX8pexNJe5WMGAOwa0I47Gt+wumPWN2pXdK/t09jrQMTbBY8nDk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d685fdd-264e-4182-2790-08ddcb8447c4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 14:05:16.0654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+DtLgp6ddAEGtxPwBCu0odfWxye1lnMmyCfdNXfEL0EGtDuAFbvRkwVXZKFdlqur29vIK5bP6SrYvtRb/gulEy7TXVYtotkshgkHLgBJak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5FDE66ECB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250120
X-Proofpoint-GUID: zmranHEL0gkzxPo54Nl_3fOt8MQk4hXP
X-Authority-Analysis: v=2.4 cv=LYE86ifi c=1 sm=1 tr=0 ts=68838f21 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=sozttTNsAAAA:8 a=uMrLXzhIAAAA:8 a=aO1CQIxOwdWCwQYJ1lwA:9 a=QEXdDO2ut3YA:10
 a=jlbCQfFxfIo9zxDJvpnn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEyMSBTYWx0ZWRfX1msvy+fYHzZQ
 aZh+8g5AMHhcrM5gdGUSieFgbCcca1XdiD9W4JNWJ+VClLkZilmt8dMKRUFkdrv8LfoEUzOny6f
 uJ6C0gvYwytkTKKaKTwKBUuViwghR5SiVvpeoRT0LnPQrq3R1vWjnl5V3Yvsz0kiZ9pbbmpVOqB
 qZjRn743arJtaglVFChdOqKH8jsZ4q4TW9aT15e8nRLuiT6QDOpZmfHjC4k8CaCH7ZPlOMXY2vs
 TNTeK03bT8LNtvHuZ8z2GJt02ED/wrbBhNUaECN0CdP0QZ9h6OZvd3TgXzzeXjrag5OrSsx4dXl
 ljO3Squ9636PNFTXD0qxg/4EouWn9tDGb0OO49CcEArMz74moRx6iIsDwskNG+STqQZA6R7lT2J
 xJ3n04IRB7KRYGcTO4Kvfm7ykC2MZioZq/5EjKAWa8A6ZyCATIySq1l4vmlLfmU06wl72I3D
X-Proofpoint-ORIG-GUID: zmranHEL0gkzxPo54Nl_3fOt8MQk4hXP



On 7/24/2025 2:40 PM, Parvathi Pudi wrote:
> Added API hooks for IEP module (legacy 32-bit model) to support
> timestamping requests from application.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> ---
>   drivers/net/ethernet/ti/icssg/icss_iep.c      | 103 ++++++++++++++++++
>   drivers/net/ethernet/ti/icssm/icssm_prueth.c  |  72 +++++++++++-
>   drivers/net/ethernet/ti/icssm/icssm_prueth.h  |   2 +
>   .../net/ethernet/ti/icssm/icssm_prueth_ptp.h  |  85 +++++++++++++++
>   4 files changed, 260 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_ptp.h
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
> index 2a1c43316f46..59aca63e2fe5 100644
> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
> @@ -968,11 +968,114 @@ static const struct icss_iep_plat_data am654_icss_iep_plat_data = {
>   	.config = &am654_icss_iep_regmap_config,
>   };
>   
> +static const struct icss_iep_plat_data am57xx_icss_iep_plat_data = {
> +	.flags = ICSS_IEP_64BIT_COUNTER_SUPPORT |
> +		 ICSS_IEP_SLOW_COMPEN_REG_SUPPORT,
> +	.reg_offs = {
> +		[ICSS_IEP_GLOBAL_CFG_REG] = 0x00,
> +		[ICSS_IEP_COMPEN_REG] = 0x08,
> +		[ICSS_IEP_SLOW_COMPEN_REG] = 0x0C,

using both uppercase and lowercase hex

> +		[ICSS_IEP_COUNT_REG0] = 0x10,
> +		[ICSS_IEP_COUNT_REG1] = 0x14,
> +		[ICSS_IEP_CAPTURE_CFG_REG] = 0x18,
> +		[ICSS_IEP_CAPTURE_STAT_REG] = 0x1c,
> +
> +		[ICSS_IEP_CAP6_RISE_REG0] = 0x50,
> +		[ICSS_IEP_CAP6_RISE_REG1] = 0x54,
> +
> +		[ICSS_IEP_CAP7_RISE_REG0] = 0x60,
> +		[ICSS_IEP_CAP7_RISE_REG1] = 0x64,
> +
> +		[ICSS_IEP_CMP_CFG_REG] = 0x70,
> +		[ICSS_IEP_CMP_STAT_REG] = 0x74,
> +		[ICSS_IEP_CMP0_REG0] = 0x78,
> +		[ICSS_IEP_CMP0_REG1] = 0x7c,
> +		[ICSS_IEP_CMP1_REG0] = 0x80,
> +		[ICSS_IEP_CMP1_REG1] = 0x84,
> +
> +		[ICSS_IEP_CMP8_REG0] = 0xc0,
> +		[ICSS_IEP_CMP8_REG1] = 0xc4,
> +		[ICSS_IEP_SYNC_CTRL_REG] = 0x180,
> +		[ICSS_IEP_SYNC0_STAT_REG] = 0x188,
> +		[ICSS_IEP_SYNC1_STAT_REG] = 0x18c,
> +		[ICSS_IEP_SYNC_PWIDTH_REG] = 0x190,
> +		[ICSS_IEP_SYNC0_PERIOD_REG] = 0x194,
> +		[ICSS_IEP_SYNC1_DELAY_REG] = 0x198,
> +		[ICSS_IEP_SYNC_START_REG] = 0x19c,
> +	},
> +	.config = &am654_icss_iep_regmap_config,
> +};
> +
> +static bool am335x_icss_iep_valid_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case ICSS_IEP_GLOBAL_CFG_REG ... ICSS_IEP_CAPTURE_STAT_REG:
> +	case ICSS_IEP_CAP6_RISE_REG0:
> +	case ICSS_IEP_CMP_CFG_REG ... ICSS_IEP_CMP0_REG0:
> +	case ICSS_IEP_CMP8_REG0 ... ICSS_IEP_SYNC_START_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +
> +	return false;

Redundant code after default return

> +}
> +
[clip]
>   
> @@ -1434,12 +1490,19 @@ static int icssm_prueth_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> +	prueth->iep = icss_iep_get(np);
> +	if (IS_ERR(prueth->iep)) {
> +		ret = PTR_ERR(prueth->iep);
> +		dev_err(dev, "unable to get IEP\n");
> +		goto netdev_exit;
> +	}
> +
>   	/* register the network devices */
>   	if (eth0_node) {
>   		ret = register_netdev(prueth->emac[PRUETH_MAC0]->ndev);
>   		if (ret) {
>   			dev_err(dev, "can't register netdev for port MII0");
> -			goto netdev_exit;
> +			goto iep_put;
>   		}
>   
>   		prueth->registered_netdevs[PRUETH_MAC0] =
> @@ -1473,6 +1536,9 @@ static int icssm_prueth_probe(struct platform_device *pdev)
>   		unregister_netdev(prueth->registered_netdevs[i]);
>   	}
>   
> +iep_put:
> +	icss_iep_put(prueth->iep);

prueth->iep = NULL; avoid potential use-after-free

> +
>   netdev_exit:
>   	for (i = 0; i < PRUETH_NUM_MACS; i++) {
>   		eth_node = prueth->eth_node[i];
> @@ -1541,6 +1607,8 @@ static void icssm_prueth_remove(struct platform_device *pdev)
>   						 &prueth->mem[i]);
>   	}
>   
> +	icss_iep_put(prueth->iep);
> +
>   	pruss_put(prueth->pruss);
>   

Thanks,
Alok

