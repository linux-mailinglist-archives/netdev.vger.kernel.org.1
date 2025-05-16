Return-Path: <netdev+bounces-190931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8332AB9577
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 07:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A057D18928CD
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 05:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC1A2165F3;
	Fri, 16 May 2025 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gn0jAJDu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jy3vBpSl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019D5481C4;
	Fri, 16 May 2025 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747372929; cv=fail; b=ZmuSVwhWC6VvIqRntt4lyEHV8getXuUjrSnFD2LWlAPBE9IFDDlq/xAH+at32lNMVrBVeP82QqgLjDFwuDT+DPjL9cJE7d5fUZXawHKG5ZyFMpbvGsXPKBxZq5prwuwob2Tw0X0MrCIA+37FLWMS/0IdnjJSFlaaAD0rcgKIQ78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747372929; c=relaxed/simple;
	bh=exMrN42pGm57P40u8jcOcTM3oKivl0CCSJzd8XJQT2o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=APlGlmTK558y2YCMxirjlRJz48o3B27PB/vf6BNBtNNh7vGnKLPrHr3BjlXI8jTXX+nX+z8d+cgp5O/Bwlz5wHUfjv4lryoD6wdsAim9R9kZA7UlO7ea7VLVZ8J4VCdP49D/Qzna1UOn697OxtXVinKPLNxqIbZkxY45ZeKRaT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gn0jAJDu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jy3vBpSl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FLbQWi028800;
	Fri, 16 May 2025 05:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QcdnFFbJ+5ZXVOAfzEp7PQrE1Sx/LxPe5DDnB4ucwLs=; b=
	Gn0jAJDuqowfbBcF4p+KxYjpS9UiDQ7VeZP5yG7KIglnxr47aETFVOfvtlfTi4Tg
	w95aXyWiZY2MfDfjMeEBYQw3g62auHhdBmtIQEJSxuwXoVSUEpTxibBMQoOU7or+
	ikxsapD9n210RKXKNQp0tDCPMwepHyI9ILrLAD3j+FlhhSttHfudBk7qmk04gs8P
	2QfODbt87L5lKYTu6EsNJ47yQ+HYreZUhFOiogOHWSjPVK/iPKe2QR3rqphPsbZO
	AK9G7Ia4D6dngSdr5uh3qR5U/SRCa/PUygropelpewS4/CJ2NF7CYW8HatcA8cT/
	C14vGZXe10+3mKJCQX6IFA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbjrns5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 05:21:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54G4E8Dt026750;
	Fri, 16 May 2025 05:21:41 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013079.outbound.protection.outlook.com [40.93.1.79])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbta6tnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 05:21:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGHknbZBqeA2CxL/jeqhsHRqe/pfuwTflZ4kMBLogrEgygI3+Tv12tfTItS8V6fgr+UdgVGxJuFs7/DKgtFhGSaOBQR9Gb4bq+1Hp6rbZOBNot1eIeQ7y0tdjg8wBX+UJ3fGaRKgjHaral0pHNtb53DVEPC4NnrWwhSIRqbmtYM1gKx8XSP1JXnTuq4tGKKhCVBlRYM+FxYZ+iheaY8ap/vvG6FL3kEYbJOXFPuxAQwOjTCD0OXHbxAk5xLubZeBpsbsxS8JFsPmyVg+t5suJdBNLaLpWG4HzAmdac4rzMGEZhDioB5hbKFIW4PEFH+cF7z2zgga1Na3DlTzeJoBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcdnFFbJ+5ZXVOAfzEp7PQrE1Sx/LxPe5DDnB4ucwLs=;
 b=WIwkE9COBErsGzyZcBUkI9QDSQTg1glvkMJFgxJm/89AHPiczjfPwK0HaLsBjpcZnWiF2JjXhjaiG9FW04slTZVt8Mnl9rSF/sgOL8+pBvIP0xSWd3Ec3i0mlXLckwZYhTG8MMjOZfdN3R/QrIiXftklxfimlbC3S6KxRO5qU3zsV+kyKkZcCk2vaQSfdIe/DeRbAZ2ApVHQ2zr0KZqGzsXXKrkhXutbKC9HewXNXHeAaiFTUosYqHnKBuBPjaf6kdU2zA7jnKIPIO7wSVCr99Dn7uspwEQfQlIA/Xm4ZR3ToQpR7lTc3GljNLSOqvJlfMUq/IFaxyIk+hJD1s2TDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcdnFFbJ+5ZXVOAfzEp7PQrE1Sx/LxPe5DDnB4ucwLs=;
 b=Jy3vBpSlKkejgHjejTnnoiJBYQhoFVgckMKO9GD0fWRVA1Qk2SfeoeyMJx+rG3RlYr1o4S9huieDuD+6yRFJNSpw2VIoCU8qgjlTKgA5U/PU0YgxOJpnIWowz1Djzl6zzTIKZ/Z0W9HUDo+MfJX8oty7ax2Uq3p2p6bJGFCrHCc=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH3PR10MB7863.namprd10.prod.outlook.com (2603:10b6:610:1bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 05:21:38 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Fri, 16 May 2025
 05:21:38 +0000
Message-ID: <b39ee402-c681-4bd3-94a4-e703b63032f1@oracle.com>
Date: Fri, 16 May 2025 10:51:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
To: Tristram.Ha@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Woojung Huh <woojung.huh@microchip.com>,
        Russell King
 <linux@armlinux.org.uk>,
        Vladimir Oltean <olteanv@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250516024123.24910-1-Tristram.Ha@microchip.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250516024123.24910-1-Tristram.Ha@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:4:54::29) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH3PR10MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ab81b3-0ecf-442c-444c-08dd943988ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVlnNHY4bGY2NTN3bG13TGdhcWFWWU9rMW1DVDQ2T2N0UHR0QXc2cG1Qb2c2?=
 =?utf-8?B?blI1TDFxZGI1ZWtaL0grWjdlYUJKNDBjVTBZdkpOM3VySmdlWXE3Zjc0c2dX?=
 =?utf-8?B?WnAxMkh1Z256U3A0Y3VmSy9nR0RrM2IvZEJBMDZaZUtDL2hZcXMzWThkcFlV?=
 =?utf-8?B?cnI0aFZhNDlQTDdDa1NJYlRmWmpTZDlXV3hnR2ZXQlBKbldHaEE1OUtubnp4?=
 =?utf-8?B?YkxtY056TTF1L3dTam1POTN6OWRURkZGLzlzN1hET215QS81c2UrWHVBYlhS?=
 =?utf-8?B?Qy81cE8vU0V2V0FPZlRXS3I0cHFPQlBIc1dZSVNIbmppc0hOSWpDeUxaNkdz?=
 =?utf-8?B?ZzlpMWFxQ3ZHaGR2cXhYaDBIa3cwbnRIUnVyWDFkL0ozcW1ob2twZ1lIdHE5?=
 =?utf-8?B?WFJZaFhwOG8xYVozcWxtSEg5VFhNSFVpNUljNTJ0Z2drazJmMFA5dDZINmpH?=
 =?utf-8?B?RnNZZ0NCNjlQYUJzR2E1cG90VDB1cFJzV1V2b0lBOGJnZlozTUIzd2FveTFw?=
 =?utf-8?B?WHRabDQvNnplbjRKWFI3NnZlTG4zeldBTDBkTmlKRyt3eG55YVRVcnNiWC9z?=
 =?utf-8?B?Q00zOUs5MHNhMjYzMzh5UDgrd0dxdlpDMmdITnIrT2UyMW91NUZjK0hqS0Ry?=
 =?utf-8?B?cjIyRFVNQ3NTbDQyb1hMY2xJMUtOSGJUbVM3NnRmQ1Z1YWFITFd0UmJQRmRN?=
 =?utf-8?B?NlBmOWxzRkxSTHJReXFHWlkyRjkvQU4xWEVTYjRmKzFtaDVOeFZaRnN1Q3Ba?=
 =?utf-8?B?UzNGR1NXU3hHQW56c1Z1K2t6OWVFbjl0c0s4WDZ1ajVlRVlmYk96Nit5VEI5?=
 =?utf-8?B?VlM3bzd5dlB3MkVCK1NHMUhiMVkra09rVVE2V1pUNStpbkY5NVhEZkwrcGtI?=
 =?utf-8?B?b2w3RTEycVFUMU9yK1pSTzlFUS8yS2I4am5pT0dCU0MraTdrYW5UVFhYK2s3?=
 =?utf-8?B?T2luOHpjczJGcDdCUUh3OEU5QitmZHo4bVB4NmpGc3l2Um5OYUF3cnhzRzJm?=
 =?utf-8?B?T2lleHJITWxDZ1FjUlJOMnhhbi9vQzFIUFJ4dWpuMjVXTG5HZzlJdnZUbHkx?=
 =?utf-8?B?S05PUUtNUFY3VkRUNUZCTWdINjBqbkpvMjdzU3lvbGRwM3l5TUE5Wk92cHBh?=
 =?utf-8?B?Y1JuK2JzV3greWFKNmRkakdwd0JwbFppR2VLWjhrKzNnd1pRK05uN0FzNkY5?=
 =?utf-8?B?ZStQb2FxUEhlNG9hbktFY0dBbXNCaFYxcFNqeHc2Q2oyWWsrOVRWRklxcGlt?=
 =?utf-8?B?TnBuQ1lMYmNMZ0pqUlFqc0oxbkVmZkxBNTZhcGoyd1dWWUdOVlhGdWhTLzh6?=
 =?utf-8?B?b1dJbk5POVkxakJ0bjR4cEM2ZTgwa0NDU3JhbFhHeXdxYzJJaG4xZVdnU3R1?=
 =?utf-8?B?QjZ0bHBsWkJQelVPeUhpZVRUY3NxZmpqT1k5OHBPK3pDRlkxVjJTN0U2MlpR?=
 =?utf-8?B?eGtCM1RHczd6WjdYQ0ZEL3VQN0VEY0tGVnpVVlFwVkFLelBxM1RmM1NybURB?=
 =?utf-8?B?QVdnYWxTL1FETGtzQmI5WjdzR1V5Z1BXVnVWbXpxSWlqZmk3YWNkOVlQZHN1?=
 =?utf-8?B?Sm5YSWxNUFliT1gzeVFSWmNSUGNra1pnK1FhczAxRWNRN0hOSnNqM2tPSWNL?=
 =?utf-8?B?VEV0YmZyZEdvbVN4bmR2QzNQeG5GSjJsckxxSlA4RmJXRkxiaVpGbi9STWdp?=
 =?utf-8?B?WlgxZFhpckNid2VHN3N6WSszT0xTNmkzeVRrNFRrbWNESUpCS0pSL2J1TEVC?=
 =?utf-8?B?S0lHWDVtTk82RFYwckw0RlNHWENaaFlWZ20xQmhRV25yVnlkZm1ueVd6R0lh?=
 =?utf-8?B?NCtCY1VvUVc3YkMzYTVFK004Wi9KZldrYno5STcxWGU5RkJmT3hKMWNvcHJl?=
 =?utf-8?B?WVJob3hUa3FxNFNMQjRXSHhWYmtrcEdZZGxzeWxUM0R1SE9qTTY5RkkwaG5F?=
 =?utf-8?Q?7eFg7EaiXCs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTgxdGVzT1RRR3Q2VXd6eGgwVmY1K0tqTDFmdmE0UkNFWW51TlBjd21QUjRp?=
 =?utf-8?B?RHpiT29kMVlrc1A4UU1sNTVjMnovR2FXMTVvL0lZYzd2cmFqZEF5WFdCSGVM?=
 =?utf-8?B?aVRQZGdPMCtKc0tPMXl6cCszUEorRkUvZEdIT1JPOVZMQURTUGhFbmcweGRl?=
 =?utf-8?B?VU5RT3QrZGc5bHdxY2FsR2NoNkNUQ0ZCdVRidTFodzk1RnpjL0RoWkxSVTVQ?=
 =?utf-8?B?enpXQ3JkYmZMbXJra1RXU2RtZnpGS0ZnL1JDZXY5KzgyUWhrcm85T1R5Q1hz?=
 =?utf-8?B?dk1oeERwNFdtQnp0WGx5ZGhTZDJ4ditSVE5Ecm9KTFRWdGM4ZGFJVnNkWlBx?=
 =?utf-8?B?Y1QvRC91ZlNSUlpVUUMzelZOZ0RYZFY0T3dlc2Flb2theGZ6QVV4OW5MaE5N?=
 =?utf-8?B?M25MVnp1R0pqMGZZb1A0bHZOUEJSN3hpbzJONCtaR3BYeGFCbU1CcDVwUHBh?=
 =?utf-8?B?b1JWOWFkVkpWT0xxV1hJQmxXMGRHa2k2OXdFTHlJUVdQTUNaT2EvRDhTczQw?=
 =?utf-8?B?TmYxSWQzUzFSb0dvMlRWWGovbGJCT3RZaFJZMzRRRW4wT3VUVmQ4eG4vcEZX?=
 =?utf-8?B?VnFjSmcyWnd6bXBBM1VJM1R6UUUwcXdJVENNT1g3am8zY2k3NHBaUmVwdFB0?=
 =?utf-8?B?TlpWalZReUpWb29FNkRCYU5mTTBUc3hFQU11QUo5SGZNR004T0w1M2RMK1Fp?=
 =?utf-8?B?UjNJQUxJd2VFMUxkK2czNHBWSklWVFJWbHUrQ0NOVlpLVTM3SWZmYlNDODR5?=
 =?utf-8?B?OXd6N29UQXNpUDk5ZUxpeWh2R1Q3OFR6VGFUZnhxNEFJZmZkT1ZBNlZWQ3NF?=
 =?utf-8?B?ZFFLUUlUcVErai96SEVoaWo4MHhtbVE5eWhFbFArci9jbVN2SXBvWkNlYXNY?=
 =?utf-8?B?WjhpY0hPVkRrbGx5TitkNFdDSHNiYlZZUzc4cVdZK3NPYkVYZXdIajBIVTI0?=
 =?utf-8?B?VzZCa0VyaDhvMG1yTjhxOENpc2xMQkhkcXZlUjM5ZFEyWnQ3T3pnRllRRUdH?=
 =?utf-8?B?ZDNoN1plbnBtNER3OXVVWENDejVDei90b1I4OWxkRVpiUWw5OEFTSEVUNGlF?=
 =?utf-8?B?MS9Zd1NlendvUTRuMXRvUUMvSThmYVppZHpITDJYR21vMmF4a1JmUVpWbDdL?=
 =?utf-8?B?UDM4ZkEzNTZ6V1dGa1ZUcUpxWUJBMDdRYmpoS2dWU2d2QUZWUUo2dFJuMmxZ?=
 =?utf-8?B?djYzSzFkdTM2T2VtMU55RFVoVXUyT3pmaXpYMHdwaGZHQ1lNRzM0RlkwOVMr?=
 =?utf-8?B?U3pwQXhINlJFRWtOOVNDaVBBZU1VYTFDcVc1MDZ3U2w0TWFqWUk5ZkFSKzFx?=
 =?utf-8?B?M3JOMVhxU2dLd3NnN2RCL0h0RndDSTlsZkJqQ2JYMmViWGhtb281cUl4QUR1?=
 =?utf-8?B?dFkvSHV1aWJiSjhWb0k1Tm96R0hxbzJJWmNMdU9MUytNNmFocjIwSHlqWXNM?=
 =?utf-8?B?SGpBcGJzN3lwZkxxZ09NSGVXalVtaEhuUW9UaERydkw0SisweVh2T2pwZFNU?=
 =?utf-8?B?UVpXZ3hJeTFVbWVTb2l3RlY3bEhtTEN2TjhMT21mLzNvT1U2VFVhTS9TWnRZ?=
 =?utf-8?B?ZW1jQS9QbzlwMDB3azR3VjJ1dDBPOGpKS2dGN2lhYVlqTm54VHB6QmpwK2gx?=
 =?utf-8?B?VXJydEZoK0dZTWtnZW4vQzJJWE1UbXcrYzQyNEhOb21SbVRocU1DdHBkSENV?=
 =?utf-8?B?aHp6amNqN1BCSTd4eTV1ZWYvU1krc21iRFZBYmoxeXdCeFNtWDVwVExMVUlp?=
 =?utf-8?B?WXl5b3A2RkYvSUlxc0pZV2NRQTh3UzdraXJGYUNvQjV0enU4aHF1SXJteis0?=
 =?utf-8?B?ODQ1NWsyY1dzZDZSZER5bTE4d3hNOHhpenlZSVRsYW1tbXM4WGRPaXk2OTV2?=
 =?utf-8?B?SDZqRU9pMGVYSmsrQ3BkRFRZbnFxeWxQK3FjV1ExZ1RwWWhkZWRVU0dSRjJD?=
 =?utf-8?B?OVZYQlB3SEkxVGFiUXVlUEY0b0JSbHY3NGVKY0kzVHpNZGZZenBXVE9qUXBG?=
 =?utf-8?B?UjdueUdoQmI3cE1HYkxBRE1KZ1I4NFgveTVmZmJlTFRkendCL2RvdVNxQWFp?=
 =?utf-8?B?RzE2NU9hZFlYeXBYTTRxQ1ZuMkxxbWdjZ1lXd3ZLM21LaU1ndHh4SklSWXVG?=
 =?utf-8?B?MGxoUEE5ZnR5VS94NHBxd01ZcGYvRjgwR0VQakpiQWlUZVQ0QlcrZ3VlaXdH?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LPR0CuYZxb+VFRAxt2u4AA5yvnVX0SFiE4+cC226z5+fq6h/OMD7hLfILs43g6GSGK5QPXIRMMowAsnZ5nEKIITMkQmlIMmNFIGSEx1CPN9pWUlTVQDre94hJl/J2NNSZe5P9DhEb5YogA5RHVAHmcZKYJiIewlCK+RWWAZ/grcoPcZQW04X1iG2wmP1cqNbThPg/yaYNoV2keW/9U4YR+o96o1GZuz81N8GgHMLOVJAch9S/ryr7Wygp3jaGp2EETkm5Laf4U4FWmIP93etKrg2kYqPkTocA0zu56oVDCK7zP1NVtLrXBbwpBSe2F7LTXs/DNpAoOlCZbLlusA2s+Ikr/Daa1zcXppeonJOJuZA1e0c2LKPPYBKkJqM9vs6CdFGnqXDoWM7lrGFqOb4NgBts0v5l8L35EIyzR8md09l5czdYgVPaUBtK7F2xVcqT+AImLkoQ4wgOiIDVH1/3QZTBx8lkDzveyy7ZVY9a9e8AKqnyf1VxNP8ORJzixbIXr4lFBy1uHEdrUnTJPrdYv3TagVw57FeMbGHYeXfL9aaRNYYLNTYK3vac31CfInaWYiPlbTUW5zHub2hVj0/OvHDY/MS8qszG/Q61Q24Y6k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ab81b3-0ecf-442c-444c-08dd943988ad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:21:38.4986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqTSbCbP5eh2p64SSsOVUeREEQWhVn+VvQTVvmqjELuGBF8f+ampibpgK6VobZGCFGZgSv5Lk1QMv9FzfBpeVwhjJImEvfniNzpUzAgBxQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_02,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160048
X-Proofpoint-ORIG-GUID: GrAIc89gjHfNJRm7p6k6KLQLYmQRYvkv
X-Proofpoint-GUID: GrAIc89gjHfNJRm7p6k6KLQLYmQRYvkv
X-Authority-Analysis: v=2.4 cv=aYxhnQot c=1 sm=1 tr=0 ts=6826cb66 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=XYAwZIGsAAAA:8 a=gVveEQt4LPd7VXW5NyEA:9 a=QEXdDO2ut3YA:10 a=E8ToXWR_bxluHZ7gmE-Z:22 cc=ntf awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA0OCBTYWx0ZWRfX262uOONccztH 0ZcwzJRQJ55/jaKbKS8MrSmObvDXSAN/L1JmopYOFnDaIUdbXzi7Qm+jAtiUD/7rWYIDaQUyKyy ewtCq9w+pzdC5e3/EIWOBlMsZTmCPSLW1XL7BdNj9GyinckUAC+15KdHJpetltQPbi1ssjclsOe
 MmchL7Kwn92rEIuJaXzDMBPjC7Fj71x8MWJTvTuSKy7Riv+GoAbSWmLCDlCS1a/NLohGjcFGq+U F6AtoRsfN3CWUdoOyROKmmkzb+l0gYyShNoqerySgvLXtXMB2dKiRfEQOm1GnDha14ObKCl6Igi d3N73E+/A8bTSGRcjEfFg1qWFhLXQSjWGN08r5dy2EDG/k6hiWTsgyDwk8RYA+ozItO3GH/H1Mz
 myeBhV9Tjm5NCmQkNzk7bluyespjDLQ8yRH0RWoWzlvACAT/Utv4nz/Przu1CdPF7umeRymZ



On 16-05-2025 08:11, Tristram.Ha@microchip.com wrote:
> +static int ksz9477_pcs_write(struct mii_bus *bus, int phy, int mmd, int reg,
> +			     u16 val)
> +{
> +	struct ksz_device *dev = bus->priv;
> +	int port = ksz_get_sgmii_port(dev);
> +
> +	if (mmd == MDIO_MMD_VEND2) {
> +		struct ksz_port *p = &dev->ports[port];
> +
> +		if (reg == MMD_SR_MII_AUTO_NEG_CTRL) {
> +			u16 sgmii_mode = SR_MII_PCS_SGMII << SR_MII_PCS_MODE_S;
> +
> +			/* Need these bits for 1000BASE-X mode to work with
> +			 * AN on.
> +			 */
> +			if (!(val & sgmii_mode))
> +				val |= SR_MII_SGMII_LINK_UP |
> +				       SR_MII_TX_CFG_PHY_MASTER;
> +
> +			/* SGMII interrupt in the port cannot be masked, so
> +			 * make sure interrupt is not enabled as it is not
> +			 * handled.
> +			 */
> +			val &= ~SR_MII_AUTO_NEG_COMPLETE_INTR;
> +		} else if (reg == MII_BMCR) {
> +			/* The MII_ADVERTISE register needs to write once
> +			 * before doing auto-negotiation for the correct
> +			 * config_word to be sent out after reset.
> +			 */
> +			if ((val & BMCR_ANENABLE) && !p->sgmii_adv_write) {
> +				u16 adv;
> +
> +				/* The SGMII port cannot disable flow contrl

typo contrl -> control

> +				 * so it is better to just advertise symmetric
> +				 * pause.
> +				 */
> +				port_sgmii_r(dev, port, mmd, MII_ADVERTISE,
> +					     &adv);
> +				adv |= ADVERTISE_1000XPAUSE;
> +				adv &= ~ADVERTISE_1000XPSE_ASYM;
> +				port_sgmii_w(dev, port, mmd, MII_ADVERTISE,
> +					     adv);
> +				p->sgmii_adv_write = 1;
> +			} else if (val & BMCR_RESET) {
> +				p->sgmii_adv_write = 0;
> +			}
> +		} else if (reg == MII_ADVERTISE) {
> +			/* XPCS driver writes to this register so there is no
> +			 * need to update it for the errata.
> +			 */
> +			p->sgmii_adv_write = 1;
> +		}
> +	}
> +	port_sgmii_w(dev, port, mmd, reg, val);

a '\n' before return, Apply in other relevant locations as well.

> +	return 0;
> +}


Thanks,
Alok


