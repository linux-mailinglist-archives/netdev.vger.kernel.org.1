Return-Path: <netdev+bounces-216046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13759B31B10
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF151D20894
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6338C2FFDDA;
	Fri, 22 Aug 2025 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CYfci+Jg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ALuvZTl/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341830147C;
	Fri, 22 Aug 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871998; cv=fail; b=T46haBDmWuwfV7/lGTtYbaX1MHJiwy3eGXifD8F5QQQ2eqUQRikHxtcGwSxFx7fliaw5cDONaVJcTlYv/MkrDyZccF/AIpD5JY6d0mgVhlq5wOJtGSGZnSrAffPA0oEkHXB8IbjEQKBDIyMh+nIZGEVbRqKhvz3hOokj5oQT9II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871998; c=relaxed/simple;
	bh=BBOHiQwL0ZR3fwu/rJaoHAr+l+HOk3tgTY1yVMreRD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LI9XBd3V3FY/fY9bptnChHvI9V+8tbJkJFyinHg/NJgAttr4fIZlduYjhD4pr0U5KfedMOg31ea717zK45rqeue1TN3GubqYTk7FlA/33U45YLi+7l0GwIWpoKC6YbIICdcK/4nvi5MXlBrRW7UjKg+QMMIDiX3lbpsEsRCOeHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CYfci+Jg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ALuvZTl/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MEBZoN009915;
	Fri, 22 Aug 2025 14:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sU94g50aeZ7TlzLgzbae2ZlV4UspTTzp3/iVKyCoGa0=; b=
	CYfci+Jg5KUmN0k5U1Zf+AFSF1No4cgDyycQH1BV/uVLMJs89kY+hiZfYIlfChp4
	1CnrR6C1gCHLP4we85KlokSWfqNxyQWcxMRCwqGO5Djw+Unhldmq4GrDKvAD0Uz4
	rUxwu5+CnMUynCP5SmUtSS8hHMk0ToGGo77jQv+pBf4eAcXgz+lOUmNgEKHNxtg0
	+uPcx9tjA86ORCKD0+R55oJwlMzXlBTErAWzPnjWdtFfETtyWDtoQ9ebUivUG74b
	LRjb6VsiSTRCWI56kreFx5uPgZBwEoTFRzk6Lbbb1KBflUJYQNdY4wBTD3PT/3+a
	VlZai0C3+BOpkDY5a3pCFA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tr5j5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 14:11:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57MDYKPx007054;
	Fri, 22 Aug 2025 14:11:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3tdygv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 14:11:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqV9/ayF4UUUNSgqlerEtxGPuV2FEl81FIJE0ehzoZW+YfykN0RFo1WZlw8Yx/zrN40cqdb3hZ2RalvDphVrYztKbaVnRcnfLJ11kSSHtIagiwY+DhUIXh0Ug9oPpUojXnG8aJiNgxgGDQas3hVVErR2SFz8WxLhEQSnIrwT5vqcgByZCFGJP3AouQkSZ5uK0h9kO1CJAcbdm3lXxrOfefMPNbpkcqGpNlVp1rhXaVhvvpKsnw5/H/jAKRok9hIJgzvlx3LHOn8SfyD7ORpZ4K7XB58aW850koRWT4AdAOq0c1T4t+3YKYWm/ev6r/W8rAWo6YH6x0nHWcIxHjc7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU94g50aeZ7TlzLgzbae2ZlV4UspTTzp3/iVKyCoGa0=;
 b=xB3UMLKn2YNU1LOgf91AxnybLOeOsijA3M6VRHsAR5TlTUFvz+rfhkE0EBZ5mYmifaiR9LFis10KQ1d75Z9y+lCJdJlmAUHPVTXBvRquCr2crzCQPZyw1IIC/v5Rf3hZuJCU160KGiT/hrosE4ygW3z4bApnWexJmING2sU/KLB+TxUrTZmioY517dDFajy2xlsFu8V7wxguz9cxDeOCc0SKau3PsrgsI8phmBc/rZPPMvj/3VR2H8RqIPZDXy7ff0fyrKdsJngGmLYrIX8cMCNcN0LBWvEgFyq/O2od7/yBo5Ec1z1t5QK4vNdzaLGR1NGRHNOE/RgqOlNfL7ob+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU94g50aeZ7TlzLgzbae2ZlV4UspTTzp3/iVKyCoGa0=;
 b=ALuvZTl/shRoNQ4Mcvs6HIdHjt5z/JKiz4EGq4kGH+s/dVrgc7TtQQ16MGa94xRhQKFN2VofFP0bze2ZqVbyOwrgJ51a9GpF8tJNiRoyWkpGwToxzj7MzlmBp4ZqzkmFIoDS5HY/u9yPuZpTFp3MLYoqegDbcQ3nrjXHy+uWLEU=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by MW6PR10MB7658.namprd10.prod.outlook.com (2603:10b6:303:244::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 14:11:50 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9052.017; Fri, 22 Aug 2025
 14:11:50 +0000
Message-ID: <7e948eb9-2704-433e-9b51-fd83716e37d1@oracle.com>
Date: Fri, 22 Aug 2025 19:41:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] net: ynl: add generated kdoc to UAPI
 headers
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
        Donald Hunter <donald.hunter@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jiri Pirko <jiri@resnulli.us>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Divya.Koppera@microchip.com, Sabrina Dubroca <sd@queasysnail.net>,
        Stanislav Fomichev <sdf@fomichev.me>
References: <20250820131023.855661-1-o.rempel@pengutronix.de>
 <20250820131023.855661-3-o.rempel@pengutronix.de>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250820131023.855661-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0253.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::6) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|MW6PR10MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: a2750010-96fa-40e1-0058-08dde185d67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVkxN2h6b2U2Ui9vdS94N0c5QWMzeUFLWmwwNG5TSjRFb0JxS2w0U1Z2Zy8v?=
 =?utf-8?B?eWtVNk10NEZVN0Rpb2l1NTlyMWt3azNUTHR0UFNxcnVZQjdqYWpSa0QwUi9j?=
 =?utf-8?B?WnlSN0tjVDhQUjVGWVdla3pGVTBsUkNoK3VKSFNLVjZiclVsdDQ5emo5VlFy?=
 =?utf-8?B?dXl1YlVOcVovdE1WcC96dXd0MWExUHR5eThsUDdkbTJsR2pTVE1OL3ZMN0Jo?=
 =?utf-8?B?WGw3WS8xRlRXRnVuR1hRZlVrNFQwczBjUjdoOGxJalFCbzFZR2g5dTU1RGxs?=
 =?utf-8?B?TEJWMS85cSsvNWpDQlNXOHp3T0F6SVZuaEovMTd2ZXNKaDZnR2U3ZW1DZnJ5?=
 =?utf-8?B?bTJTTGFiK3MrbmJ5YVpKMWJPd0U3VkE4R05ZWHlJczFnbjBoc283a1FVOFNN?=
 =?utf-8?B?eUh2QjRBZ091WlB2OTFIS3R3Z3lWRUhZWVAxMXdnODJ0dVhJcWtLNDBOcUdH?=
 =?utf-8?B?ZTYrYWh2TVoxVFNKSU8vWStxSHZxbUZnZko4MnBLSzNRemYxMHVzRFFVUVdi?=
 =?utf-8?B?ajBjdXJxZFhkVE9id0lhRTI0OGtMOFlIamxrc25aUGFnUUhTdEdwanBsOFFC?=
 =?utf-8?B?R1JvOE1GejYrak9za2NYZ1FaS3FuQkp5eWMydVErcG93ZHFpQ1plcmI1bWYv?=
 =?utf-8?B?THdrWFc4RHZvTERkZ1BKZVJOWHBhTDcxSnBxNWJGblljYjU0TGRZQ0FTOHlx?=
 =?utf-8?B?RzJPY2xRYXo1SWgvdXhudkYyMFQ3R1BWQ3V1cEZGMmRUZ2FjY1VIVDJyb2t1?=
 =?utf-8?B?Tkh0TFEydncrVzFRSXdSOHVENHJ6bGc2eWxOMTM1b1orVE1ENk9DRzM4bkJn?=
 =?utf-8?B?dEtNd0xLM0YzYTRsUFZRN0VUQXJ4dUhkUk52SGR0bzAwY1kwNVM0TERwSFRx?=
 =?utf-8?B?T29JeUIyV3NhNGVVTjd4aVh6Q2FMcU43ejRDVEJKUXpNU2tGeHpNcE50Vk5x?=
 =?utf-8?B?WFBqRDg0ZFI4bFRjRngxUnJTVTlQNVZHMWpmamJEQlkvZlQ2djV5Zlk5V2N3?=
 =?utf-8?B?M094ZXdsNzBkYS9ZY01TSnA0YUlmTG4yMVdmMmVUamlXMkJGUXNreVJtN3gz?=
 =?utf-8?B?dFNXejRSWkRWbWFmdFNjRmluY2ZxZlo3Wm1JR1g2WXZ6S3FHYVdHa1g4V1BY?=
 =?utf-8?B?akFBM24vU1Q0RlRsT3k5SlZEWG0xVHFzZ1ZCcDBSQ0NmZXFvdVdZRzhEOERJ?=
 =?utf-8?B?K0NOTDhqV2x4R3lWbGxEZVVvdHNBM21CZ3VYSlQvYmRVdnprSGtVdG40UStQ?=
 =?utf-8?B?cWhuUTBmb3hEZG8xUGc0dnd2bDF3VWFuK3dsZ0RHdVhIRTFCeDRqWUhMWFp6?=
 =?utf-8?B?TS9GeWRJRzM5Vk94ajVGd0l5ZFB2dkxNZHRZR0ZKWWpHcldxcDJGVW8xYUtS?=
 =?utf-8?B?dy9wT1ROZFFKK0ZVUlVaZGhERjRFNWYvT2FSWFkvN3g0dTJJK0dBeTRpU0pJ?=
 =?utf-8?B?SE9GVGVFblRTeDR5R09lZjdlbXZHQ09STmJsckN1Q2IwSGprNmRDTC9razBl?=
 =?utf-8?B?L2FySWFXQ2oyUzlHUGRkNnNhSW1PaklTSFN1REhEY2lwbS9jcGt0ZGdkbktB?=
 =?utf-8?B?d3l4QmJXTUp2cEFOS0pSdWNrZlhLMVVUTWZEc2t5Q3B6cHpzeVEwT3oxYmVV?=
 =?utf-8?B?UFl0RmhLSCt2U21pV1FPV250c3o1V3ZwcXVqNjZHbWdteXVZUnRjNWR4MVJD?=
 =?utf-8?B?M2NvZ29YbXRtQVlCOUtISjYxWGZhWG9acnBPSUQ3KzJZeGFRNG9CZEY4ZGtU?=
 =?utf-8?B?RjE5d0Z2N0hoRlh6WmtjcEZVaTRWWnFML3UwWEZmNEwzMm9CeGpQUnZGMVda?=
 =?utf-8?B?aE80UURUanFRd3NFMWI1T0VsRVlCYk15aE40c2l0K0FVT2NSM0prR3EyKzA3?=
 =?utf-8?B?dzBUSGRjOS9nRUtxbHUxUU9YOGgwczBrWW9SbWVQWXVqSHpHdmVPdjh6d2VO?=
 =?utf-8?B?MnlwS3pKQUpRUjVxOEU1M1ExQnZHNjdxNXk5S2pSSXNKNDEvdlcyU1BIMldl?=
 =?utf-8?B?T2Zab0psb1BBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGdCOWJsck1HOWFia0oyejFhZ0o5eTZYTWZFUWdMVGdSd0NSU2FLSWZHWDF0?=
 =?utf-8?B?MXBDYThZaGtEclRQZy91MTVWNjlBQ1hDYklUQmZnS3J2czBQS3BsSzZzaG9P?=
 =?utf-8?B?S0VVRFVGV2tqakhCS0hRS3N6ZHRVR3kyc21UdXFFbVkwMWkwckF6di9VVGdn?=
 =?utf-8?B?SXE5dmVuQXRGNnNUTExMQ2pRelE1VGYyL0daVElheTRWVjZBRFZuSm00ckgv?=
 =?utf-8?B?aW5GVm9GTVRUU1psVFhBUUhZK2tNbzFjdldRYWdvOFM2OXpDaTRnczNKaW5X?=
 =?utf-8?B?VkRRMTJSQmF5S3JsTmFkaUZ3UzlCd2UvSXMrVS9jdTk4dmNGbkl4ZkRWR0U3?=
 =?utf-8?B?ZFpsSWFmbmFqa3RRaEt6clcyUjE1Z0EyRUtGK2ZnOXZXMXZZc1E1eEFDREUr?=
 =?utf-8?B?Q1I2eVpJU2tlc1BSaWxEUEl4N1lyMWhSQlBJd3FwWXM4dlJjb01oY09zQUNU?=
 =?utf-8?B?cEdYekEzTjNnMXhhUkFwTWFxTlFhL0orell0YW9HdkxmTSt0SUFDWXVITjUw?=
 =?utf-8?B?QUMvajNDWXMvdHpyR2cyVWx6Sms4UXhieGt5VGJXL1dqcG9kYSt2cXEzakg2?=
 =?utf-8?B?bThJS1JwRkhDMTloN214eHFtd1h1VTAwb1AyVlUzTFppR3NpZGwvSk43Z2pU?=
 =?utf-8?B?UDk5dGJKeXhyL1ErQzJqVjhVTzY5dWlEb1VRRjE3L0x0QnIyekd2NzNGeWx1?=
 =?utf-8?B?cVBFSnQrNE1VWG55L0RZV1dSVVVWcWxEUUJvT3hEZ05CRGNpYXk5UE5mY2RP?=
 =?utf-8?B?NWVIOXBRUlJlMlBWVmRrWTNtQUVZMlVvdnU3amptb2taa0Y5MDVyT1F3MGNL?=
 =?utf-8?B?NnJFNWJSMHZPdDFYdGhZdWk2bE5Da2E4azVLZXhJb3JhN3Q0bkpmby9JWXNs?=
 =?utf-8?B?RGI4a0orUFl1c3lHTldWTXVsbWFpbWI0cVFQNURjMm9xSG0zMHFyWW16TElC?=
 =?utf-8?B?ajFKdWFUYnp5ZUhoQ3lGRzgrbWN3cldtZHo0bUVuQ0N4dDJaUDNvdnJNVUN5?=
 =?utf-8?B?eVkyZjVNOW1MbTlqOHpFOVdqaDRacHZBYWIwR3lRclZUUGQ3Q3dqUTJqdW5E?=
 =?utf-8?B?L21CSnBKaEV3bFdOTVB1STR3WWwzV2dWRFpxNlllU2lBK1IzRDVHUWJ4aDNK?=
 =?utf-8?B?RkthUkRFVkJOZEVubDlJT3RtQ3V3MkJ0OXI3OGhTWC90emhVdGZJWkQ3U1Ew?=
 =?utf-8?B?ZUtQdFR3N0R4RHJWTEpqT2pBWGI1Q2FMTWNkc1A5L0R6NmQ2M2wvZmllS0kw?=
 =?utf-8?B?ZUNlQkVsVkF6YzBEWU5QOHZEYktidnliV0pZWkF4MzJHVU9UNUZSYWZDdWlq?=
 =?utf-8?B?ZTBvNnJSaEF6dDliNWhZV21NODRnNnlPVUVZUmZaTlJlcXdsYllleFJFeUN4?=
 =?utf-8?B?eW9aeVZaenBZNW5McU5qeW4zUDhZMEdNay8xZHpnTElWRm5IYzZjdkRqNERU?=
 =?utf-8?B?UE5RQ1cyb0xGRFR0dHVSY1ZrTGFGY21QMjBLSHR4bXhaMVgwYUhNZElCTDBx?=
 =?utf-8?B?RkRoNGtibnRrVForYkhvSXltTHZ5L3loYkdhYjJLRFpJTUVoaGJzZ2g0cTVO?=
 =?utf-8?B?c1VMMXBqT25qNG4vcDQrQkUzb0w1UCtRNmptSEtaK21kMzk5a1RxZE9USGFB?=
 =?utf-8?B?TFJqTGJPMjFDMnNTeTNoeWpmYzR0MG5ibWxwaGQvNFN1UENZYXVscHN5cXk4?=
 =?utf-8?B?MGRNbHB2WjQ1L00rM2p1bkY1OFhWRnBnTEhiTGorS2tyQ1dhTGF3UFlCQTZ1?=
 =?utf-8?B?VVFiUEd1RWNmUXZiQnMwV0REQUVrY3VnNGtYcjd5SUpSRk8xOTcrb0EwaTZZ?=
 =?utf-8?B?dTRFS3ZybXJ3T2hCdDBMazN1aUY5YWk3UFd4SWVBS1VsQzFrUkZHY2U3aWxl?=
 =?utf-8?B?TGhqOG15MzU3V05FcXZYcXZ3ais2Ui9SdXl1V3c2V0ZLTm80dVdxZEZvY01V?=
 =?utf-8?B?MzlxdTNTREpFSjdZN3pqU0tzbEoyWUN2Zmd2NFFZT2NqdmFwb2tyanNQQTdM?=
 =?utf-8?B?MmZ1UUd6RlYxT0VKajJsNldPaHZlTUs4V2N2MzJwczBzd2JXRG9PaW83VmxJ?=
 =?utf-8?B?RHJwaFdQbUs5RVFKUjFhcDhCeGZMN1pWMXlvN0hNWEFkc0ZGVXZtdUcyNHN6?=
 =?utf-8?Q?RhSXrjX5DfyKLYb/NO0KGO2qo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h27123gBjY6HC89LGk08JlNX2HIjLzoe9VCKEvJ/ZwRvP2mG068gV2lmqRuigM8MRr5I2vO0vfawNxn1wtUOKegdJoP5I08hYLIds6+r5nrplIMstnVmoEkcjgJbRmfxG5LiAv/oQCV58fy2/ap315Ia0HzNGLwiLcJdntPpbThVTzZBKTdnsb/gR8qH2Cu21biL3WiKGs13oWkYGOnIdEEjLJ5V/qQX0uDuUb2gJZPEJZE+sYah/cwG3j1XmaIzyrBNExj8zNlNiB6P5rCxg8M7GemXk6o8DqMnow3nCZADJp4uTPkZBfQylWF/rINaurhVvT7eYSBDaucX2XoWzer+6bOBNBLOenU1mPw/uZ39fI9yjlgAjcNTLqr+NNMUWtIcv1ieJcPJL+kDEy2uX8XKD2nJwPuDDfY7OvCrFRybsyxLzFROEnATrlTaNAPNE6M5GxoByMEaXuOVatRN4n4jQwxdAhv32/sjRCUNLa9kYo6Zh7IMrXiq4uwgVh9Q6/XRxP2fTlyw9MlN1Zv3rNy3BUWP9EAV/FXzfiKhmSIDyC4zLKcg0467Qr6cRwnf1Edv2wZWS+R5pzGQl4UuUMkME70LLPGiKzTksusyODA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2750010-96fa-40e1-0058-08dde185d67b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:11:50.4133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+7kW3u3uaHC/kQXLBJC1J3g6REkxInrF0RwypPfqzU8EqwyHDYTQzIqlapRloRVPhj6xN2mHsAcwRxFducX9bmE/xdtpMrZSn4T9GecYVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508220126
X-Proofpoint-GUID: h03eVTTuZEr7jvJFJIRdQTJLficfy4fY
X-Authority-Analysis: v=2.4 cv=FY1uBJ+6 c=1 sm=1 tr=0 ts=68a87aac cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=ZIbSgqPA_jG_WTyO348A:9
 a=QEXdDO2ut3YA:10 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: h03eVTTuZEr7jvJFJIRdQTJLficfy4fY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX0kUb12QatRgz
 CtBLBBdZvz4A8a8kKvIbcEf/V0UzBs019oGDD23nSvAqetcJ8Y3bUEtkEsa4hCniR4xp9tfFkL8
 w85sCEMrmyjDjS6if/RHOpkLRgfObEMRjgHGZt/5D59zwcCHyf5gUQZhq8nd4qIg8Z8N+IPVn32
 enqj71wZ84/r9WZCk5dCoVSMwypSjezpzxp+8NatyR3D3ddmnpYYV9VRPMn51KqQPBg4cXCJ8Yv
 TOmT4EuUc++Zqjy3dn4Q2v62r6BVVUsW/AUJdx4qPdg2oun3yrHoXpQEXfNwLsvBkpWSgv4dzgO
 dfY42TDJoToJbHVxu8pZZlSKrOYxYzSPhcAAlzd6FdN3IUz58QL0jTvGvoXGZ+TTmu73L2YfK7L
 zQ58zZgfPgKNA1YiAd3Agpb1ln6Qkw==



On 8/20/2025 6:40 PM, Oleksij Rempel wrote:
> Run the ynl regeneration script to apply the kdoc generation
> support added in the previous commit.
> 
> This updates the generated UAPI headers for dpll, ethtool, team,
> net_shaper, netdev, and ovpn with documentation parsed from their
> respective YAML specifications.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   include/uapi/linux/dpll.h                     |  30 ++++
>   .../uapi/linux/ethtool_netlink_generated.h    |  29 +++
>   include/uapi/linux/if_team.h                  |  11 ++
>   include/uapi/linux/net_shaper.h               |  50 ++++++
>   include/uapi/linux/netdev.h                   | 165 ++++++++++++++++++
>   include/uapi/linux/ovpn.h                     |  62 +++++++
>   tools/include/uapi/linux/netdev.h             | 165 ++++++++++++++++++
>   7 files changed, 512 insertions(+)
> 
> diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
> index 37b438ce8efc..23a4e3598650 100644
> --- a/include/uapi/linux/dpll.h
> +++ b/include/uapi/linux/dpll.h
> @@ -203,6 +203,18 @@ enum dpll_feature_state {
>   	DPLL_FEATURE_STATE_ENABLE,
>   };
>   
> +/**
> + * enum dpll_dpll
> + * @DPLL_A_CLOCK_QUALITY_LEVEL: Level of quality of a clock device. This mainly
> + *   applies when the dpll lock-status is DPLL_LOCK_STATUS_HOLDOVER. This could
> + *   be put to message multiple times to indicate possible parallel quality
> + *   levels (e.g. one specified by ITU option 1 and another one specified by
> + *   option 2).
> + * @DPLL_A_PHASE_OFFSET_MONITOR: Receive or request state of phase offset
> + *   monitor feature. If enabled, dpll device shall monitor and notify all
> + *   currently available inputs for changes of their phase offset against the
> + *   dpll device.
> + */
>   enum dpll_a {
>   	DPLL_A_ID = 1,
>   	DPLL_A_MODULE_NAME,
> @@ -221,6 +233,24 @@ enum dpll_a {
>   	DPLL_A_MAX = (__DPLL_A_MAX - 1)
>   };
>   
> +/**
> + * enum dpll_pin
> + * @DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET: The FFO (Fractional Frequency
> + *   Offset) between the RX and TX symbol rate on the media associated with the
> + *   pin: (rx_frequency-tx_frequency)/rx_frequency Value is in PPM (parts per

spacing for clarity (rx_frequency - tx_frequency) / rx_frequency

> + *   million). This may be implemented for example for pin of type
> + *   PIN_TYPE_SYNCE_ETH_PORT.
> + * @DPLL_A_PIN_ESYNC_FREQUENCY: Frequency of Embedded SYNC signal. If provided,
> + *   the pin is configured with a SYNC signal embedded into its base clock
> + *   frequency.
> + * @DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED: If provided a pin is capable of
> + *   embedding a SYNC signal (within given range) into its base frequency
> + *   signal.
> + * @DPLL_A_PIN_ESYNC_PULSE: A ratio of high to low state of a SYNC signal pulse
> + *   embedded into base clock frequency. Value is in percents.

should be "percent"

> + * @DPLL_A_PIN_REFERENCE_SYNC: Capable pin provides list of pins that can be
> + *   bound to create a reference-sync pin pair.
> + */
[clip]
> +/**
> + * enum ovpn_keyconf
> + * @OVPN_A_KEYCONF_PEER_ID: The unique ID of the peer in the device context. To
> + *   be used to identify peers during key operations
> + * @OVPN_A_KEYCONF_SLOT: The slot where the key should be stored
> + * @OVPN_A_KEYCONF_KEY_ID: The unique ID of the key in the peer context. Used
> + *   to fetch the correct key upon decryption
> + * @OVPN_A_KEYCONF_CIPHER_ALG: The cipher to be used when communicating with
> + *   the peer
> + * @OVPN_A_KEYCONF_ENCRYPT_DIR: Key material for encrypt direction
> + * @OVPN_A_KEYCONF_DECRYPT_DIR: Key material for decrypt direction
> + */
>   enum {
>   	OVPN_A_KEYCONF_PEER_ID = 1,
>   	OVPN_A_KEYCONF_SLOT,
> @@ -71,6 +120,12 @@ enum {
>   	OVPN_A_KEYCONF_MAX = (__OVPN_A_KEYCONF_MAX - 1)
>   };
>   
> +/**
> + * enum ovpn_keydir
> + * @OVPN_A_KEYDIR_CIPHER_KEY: The actual key to be used by the cipher
> + * @OVPN_A_KEYDIR_NONCE_TAIL: Random nonce to be concatenated to the packet ID,
> + *   in order to obtain the actual cipher IV
> + */
>   enum {
>   	OVPN_A_KEYDIR_CIPHER_KEY = 1,
>   	OVPN_A_KEYDIR_NONCE_TAIL,
> @@ -79,6 +134,13 @@ enum {
>   	OVPN_A_KEYDIR_MAX = (__OVPN_A_KEYDIR_MAX - 1)
>   };
>   
> +/**
> + * enum ovpn_ovpn
> + * @OVPN_A_IFINDEX: Index of the ovpn interface to operate on
> + * @OVPN_A_PEER: The peer object containing the attributed of interest for the

typo attributed -> attributes

> + *   specific operation
> + * @OVPN_A_KEYCONF: Peer specific cipher configuration
> + */
>   enum {
>   	OVPN_A_IFINDEX = 1,
>   	OVPN_A_PEER,
> diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
> index 48eb49aa03d4..4d5169fc798d 100644
> --- a/tools/include/uapi/linux/netdev.h
> +++ b/tools/include/uapi/linux/netdev.h
> @@ -82,6 +82,16 @@ enum netdev_napi_threaded {
>   	NETDEV_NAPI_THREADED_ENABLED,
>   };
>   
[clip]
> +/**
> + * enum netdev_qstats - Get device statistics, scoped to a device or a queue.
> + *   These statistics extend (and partially duplicate) statistics available in
> + *   struct rtnl_link_stats64. Value of the `scope` attribute determines how
> + *   statistics are aggregated. When aggregated for the entire device the
> + *   statistics represent the total number of events since last explicit reset
> + *   of the device (i.e. not a reconfiguration like changing queue count). When
> + *   reported per-queue, however, the statistics may not add up to the total
> + *   number of events, will only be reported for currently active objects, and
> + *   will likely report the number of events since last reconfiguration.
> + * @NETDEV_A_QSTATS_IFINDEX: ifindex of the netdevice to which stats belong.
> + * @NETDEV_A_QSTATS_QUEUE_TYPE: Queue type as rx, tx, for queue-id.
> + * @NETDEV_A_QSTATS_QUEUE_ID: Queue ID, if stats are scoped to a single queue
> + *   instance.
> + * @NETDEV_A_QSTATS_SCOPE: What object type should be used to iterate over the
> + *   stats.
> + * @NETDEV_A_QSTATS_RX_PACKETS: Number of wire packets successfully received
> + *   and passed to the stack. For drivers supporting XDP, XDP is considered the
> + *   first layer of the stack, so packets consumed by XDP are still counted
> + *   here.
> + * @NETDEV_A_QSTATS_RX_BYTES: Successfully received bytes, see `rx-packets`.
> + * @NETDEV_A_QSTATS_TX_PACKETS: Number of wire packets successfully sent.
> + *   Packet is considered to be successfully sent once it is in device memory
> + *   (usually this means the device has issued a DMA completion for the
> + *   packet).
> + * @NETDEV_A_QSTATS_TX_BYTES: Successfully sent bytes, see `tx-packets`.
> + * @NETDEV_A_QSTATS_RX_ALLOC_FAIL: Number of times skb or buffer allocation
> + *   failed on the Rx datapath. Allocation failure may, or may not result in a
> + *   packet drop, depending on driver implementation and whether system
> + *   recovers quickly.
> + * @NETDEV_A_QSTATS_RX_HW_DROPS: Number of all packets which entered the
> + *   device, but never left it, including but not limited to: packets dropped
> + *   due to lack of buffer space, processing errors, explicit or implicit
> + *   policies and packet filters.
> + * @NETDEV_A_QSTATS_RX_HW_DROP_OVERRUNS: Number of packets dropped due to
> + *   transient lack of resources, such as buffer space, host descriptors etc.
> + * @NETDEV_A_QSTATS_RX_CSUM_COMPLETE: Number of packets that were marked as
> + *   CHECKSUM_COMPLETE.
> + * @NETDEV_A_QSTATS_RX_CSUM_UNNECESSARY: Number of packets that were marked as
> + *   CHECKSUM_UNNECESSARY.
> + * @NETDEV_A_QSTATS_RX_CSUM_NONE: Number of packets that were not checksummed
> + *   by device.
> + * @NETDEV_A_QSTATS_RX_CSUM_BAD: Number of packets with bad checksum. The
> + *   packets are not discarded, but still delivered to the stack.
> + * @NETDEV_A_QSTATS_RX_HW_GRO_PACKETS: Number of packets that were coalesced
> + *   from smaller packets by the device. Counts only packets coalesced with the
> + *   HW-GRO netdevice feature, LRO-coalesced packets are not counted.
> + * @NETDEV_A_QSTATS_RX_HW_GRO_BYTES: See `rx-hw-gro-packets`.
> + * @NETDEV_A_QSTATS_RX_HW_GRO_WIRE_PACKETS: Number of packets that were
> + *   coalesced to bigger packetss with the HW-GRO netdevice feature.

packetss -> packets

> + *   LRO-coalesced packets are not counted.
> + * @NETDEV_A_QSTATS_RX_HW_GRO_WIRE_BYTES: See `rx-hw-gro-wire-packets`.
> + * @NETDEV_A_QSTATS_RX_HW_DROP_RATELIMITS: Number of the packets dropped by the
> + *   device due to the received packets bitrate exceeding the device rate

Thanks,
Alok

