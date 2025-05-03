Return-Path: <netdev+bounces-187598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52245AA7FA8
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 11:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2F29A0BF0
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 09:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B841CEE90;
	Sat,  3 May 2025 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ad5zhHfL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n4oboeGO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C8E2940D;
	Sat,  3 May 2025 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746264743; cv=fail; b=uGZhfwmioczer5eb0LlcTQjMcdXAz3oe01oUtXBz6xDtdTXLbBTLz+nrkYQ6oNJ/ym3a0DtGBMjw7H7c1yz9C6d+co0c3HfgUkYKwkXZ0eLs6JhXHIvsge0c/qFItkj0wkfzvcK+dTfc2s+TIgLuexXRFb7awWinoVw6cCgdZ5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746264743; c=relaxed/simple;
	bh=PfoENLh9fOQF27Md6UPPbYDLp5Dlmohtlq05UdWGob8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TotGE0GJGl2S9txBEd1LRnFTlvOitdejlwX4fRkoiOSTx2ggm15KMmxuUREXGXRJ81LO/rm8Na8adn5H66bTVobSa2tJ/WO2UFWGstTCZBukRJMG9kCFTFnCSor9s392K5TC1nmRGOtpm9GxjuJGUYhWHrR1MY8LfaZlTylrZkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ad5zhHfL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n4oboeGO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5437Y30G010456;
	Sat, 3 May 2025 09:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=I5zyNe+MSjVjYFDF1660WyPY4hTEAuJ3aa8cRmLE9dc=; b=
	Ad5zhHfLLu11N5j272xXvy8DxtzKKWNX1huqm0P0oZf99YOp3jPMN83OgZZp58li
	WjFCD4D1o2yK4CsVPgBg/g2qGKRGKoUnE//lM8Yc3rWOgXGD33AnGtzmT9SGbNnA
	wRxJP/yNfzKQhkdf4lv0oE33V0H8uJ3lt82uDQ3j+tbfQCST8sQXeAhVb7uu/BIz
	155XH7y0qRsiTbmLLuFDC07SaYaTikagm2WmSIsDtduK0Em+2DAq5KOGngPxGFBi
	IvuvQyb5KWOO+R9CkxvnZe/WIBMkiZCs6MwGOFcnZ7rrn2gB7M8gpXv3VRML0IZs
	njvlTz+1+KNJ8U1eAS3CBw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46deu6g3d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 May 2025 09:29:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54374m1v035323;
	Sat, 3 May 2025 09:29:49 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010004.outbound.protection.outlook.com [40.93.20.4])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k66exw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 May 2025 09:29:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrMkDqPYOsc2UVm9kLTZ4WJd9aBirgbnZ9GEHvNa63g68zVVO9TkH9YjjTwen6FY+fSpStE3CsII5MKHZFpGpcrdgK40pQt5GECp7xysimljZgdb8IzUh2QlfXF1JD+I6VtW/+/2DYrxOEdJAX99Ze3NXs8z3qtP8tUlGjrT0jryBxzVNy0nunjC2ZQggKtpE06gkGhtIJFuV71y7Hl4iprSGIqkvZ/KktvjxuYiAIAy/rx+7Kw9uczvNX9S7Ew8wDJIvAoHA1JSV3f8Alu8dCpthsHZwOBdPPA9/4Qo9u7F2qFEEuVQeIgbLnqmW2beuEosMa0Yf29Rn1bGDZHjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5zyNe+MSjVjYFDF1660WyPY4hTEAuJ3aa8cRmLE9dc=;
 b=povNsXNN+u9CJ9ahV5l6vv30bgFxOfsRRXcnpHA/c1P3TpLvlmDN93fgE6o6j5SfHaAddEbEIsIWvrN2C8kBSPaBFXfDaqn/uAMAifYAwMxjhQ31TWI2FXjMmH4TG9DG4upi/9A9FKdutr5Fp/9aH0u9JFPonBjOOBc2c9BMZagPBpBTlFEKVZtbWfsFCXom2GeuNkJN6gnGCD4xBcLfQ3muGDsU2qNHNdAwfKH4RiomgzYPyIoHRbQHYwuRpK8/h4swpPFj5cYtI95Tf4aounx8Osbk5EgosT5l6UDTu7TOzZq3W5pA2YqcvQUq1X6sTS9PMaGfn/ZjM/BcAm5VgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5zyNe+MSjVjYFDF1660WyPY4hTEAuJ3aa8cRmLE9dc=;
 b=n4oboeGOMolYFESBy9NuRrqKCT9ME19ynVC6PynsDpN2jsZ52q8IN4e7cKvLgFWGiZbbXYsQ3pLIGXSGwVAuvooYCJc31LyN8PmeQ0alKJZgwitPD4G3qEa0rr7oShDw29+kxguEDTNamyzFTE+9Z28puNmbfa+cOppCm5GM7rQ=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by MN6PR10MB8191.namprd10.prod.outlook.com (2603:10b6:208:4f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Sat, 3 May
 2025 09:29:46 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Sat, 3 May 2025
 09:29:46 +0000
Message-ID: <868c8163-d776-4ff4-b516-3046c5db0fc0@oracle.com>
Date: Sat, 3 May 2025 14:59:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 05/11] net: ti: prueth: Adds ethtool support
 for ICSSM PRUETH Driver
To: Parvathi Pudi <parvathi@couthit.com>, danishanwar@ti.com,
        rogerq@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
        ssantosh@kernel.org, tony@atomide.com, richardcochran@gmail.com,
        glaroque@baylibre.com, schnelle@linux.ibm.com, m-karicheri2@ti.com,
        s.hauer@pengutronix.de, rdunlap@infradead.org, diogo.ivo@siemens.com,
        basharath@couthit.com, horms@kernel.org, jacob.e.keller@intel.com,
        m-malladi@ti.com, javier.carrasco.cruz@gmail.com, afd@ti.com,
        s-anna@ti.com
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pratheesh@ti.com, prajith@ti.com, vigneshr@ti.com, praneeth@ti.com,
        srk@ti.com, rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com,
        mohan@couthit.com
References: <20250423060707.145166-1-parvathi@couthit.com>
 <20250423072356.146726-6-parvathi@couthit.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250423072356.146726-6-parvathi@couthit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:4:7c::30) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|MN6PR10MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4d33fc-02c6-4f77-b9df-08dd8a250af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2pXNUhPSEU4Ukp2eFoxUDFFa1R6RXhxL1QwK3dicktBNUlnT2tqc2xCUkZI?=
 =?utf-8?B?a2xnUGl2TUEwNXdzSTJHcXBiL0Q3VXpZYXFnK0x1bjExWDRYZ29ETWRZT01q?=
 =?utf-8?B?L3VLQ2tnZDhJbmJzakNiV2lTSGhqMmhmMnFWaVVaUnpUWUp6dWl6U0tGdk9r?=
 =?utf-8?B?UE1rbU9GOVRjcTJ3SWhwbzNtYlgya0tjRkxmUkFYRGE4NFQxT0JaWDBvUHk4?=
 =?utf-8?B?VlEvTzBFN01YODIxSFBHV2Q2dXM4R1I0T1BxalJmMHVtMFE1ZVlwRDVuMW03?=
 =?utf-8?B?aDRjMWJiMkpFeDVmc013cWd1QzFjV2NYc1crNWV4ekJoWjBlY3haQ0VFVjRR?=
 =?utf-8?B?NWY2c0hGL3FGUlluaW5xbjdhNk0xYmNvVGNjRnhvbjhtdmxRM1NaNmxveTRO?=
 =?utf-8?B?N0E3bXN3T0UzZFk4RU9xZG1jRVJpNnFUNWtMNnE1VmVWS1RIdHVnclpSUkQz?=
 =?utf-8?B?NWVLeWZ4Y3hlVlN6SHptNTdldlpIWXdha0JJZThSNmZoK3ZlZ0FLWnNCQ2F6?=
 =?utf-8?B?aGk2VHd3amh1THF2dDRGdXBLcE1SWlZuVHp5d0t3b0VXVkhCeGF6NGRCNHlZ?=
 =?utf-8?B?OXQxMk9Wbmt0U0g1MmIveGVZeklZVHFiVnh6cXcwSTNuYWYvL1M0WTNMaVBv?=
 =?utf-8?B?SzdmU3pqOFRwWkdjR1lhTWlIallqR1NCUGV5dExNMzdNOE5sMVlwRFVnalJo?=
 =?utf-8?B?Z2ZkblhOc0Zxa01TQzJNY1hIUzVCaGcwWmhyOE8vRTdmeDJpbytWa2Eyb0xz?=
 =?utf-8?B?bFMrbmxlbTVvSEExcjhjR1luaU55U0lhbGsyNlBjYWtSVWlWdit1UHdUZTBi?=
 =?utf-8?B?Uk9Rd0NvRWZabkhaY2tIdjYxbjc0WXVHNVV3c0JWSEtPVjdJYlR5S2djMHJN?=
 =?utf-8?B?NGRoWWlDZEI4K2V0RUJ3SHQ0ZHBCaGQvVlVTalAyNjRsTEQ0MjVBV2orMWpy?=
 =?utf-8?B?V1RIZ3NKdFpJa2ZJbUhWMUNjMTc0MzAzdVFFTHpZbDJuOU9xUUhlL2puOFJx?=
 =?utf-8?B?eVdNYzdhWEY2dEhkV2VOSjZNOWpaNit2NFhiNTJwN1huUzBzNTBNK21WTUxj?=
 =?utf-8?B?bVVaZFdzVnRmd3JzeGN0RncvNUlHMWlUbFVXU0JhdCs4U21MRTRVdmNYU0Vr?=
 =?utf-8?B?N0g0NG55YjdrbVM4ZHJMbWlTbHdwVU1NVU92MG04aHpKMW9aMEhDSEtzam9D?=
 =?utf-8?B?V0xFa0ozRnI0SnAvS3g0WlhZQVQrdUprcWEzb3d0dWEyQUgxZGlFZC9LWGdo?=
 =?utf-8?B?Y0RicGdSekh5U1c3Nm9ydnVDNnl3YktYa1BGcFhUNVloUHkzZDZ5ZkpXdTZK?=
 =?utf-8?B?NHFROTJRUmdZcnovWEhmUmtmNnZ0b0RocGZxNEEwS2ZzaHg4ZUFHblJKTTBt?=
 =?utf-8?B?N2tTa1hMQzFxYzlhZVlIeVdYbzR5ejJKNFJQMXplaW9wS3JXL1BlQjBuaTJs?=
 =?utf-8?B?T0pFNnRyWUtWUG9Tc0Z2b21mc01HMmVOK1hMOG9RL1BGYmFXRHFkWFlieUxk?=
 =?utf-8?B?czFUbEtOZEJUWTdCOGpvZ0FHaUNhK3N1QTVMS2NYNW4wYkFUMnlOWUtkeFRv?=
 =?utf-8?B?LzRFaFN5WDhSUDRFMUc3QUtwOVltWU5KYjN3dkZYam5kVjVGOXFpeU1rVFZO?=
 =?utf-8?B?WWk5UGxEYmkwbjZZSVgzNGJVeFhTV0FnRkd2ZjVZdk9CbCtCeHFMbGp3ZmtF?=
 =?utf-8?B?VXNqc1diTm82b2hTWExiYThSTGIvWFBEd1phOWRWNzMrb1RibkFPdzRoSHNo?=
 =?utf-8?B?WVlGNG1UbXFpREl5d2VPY0ZhRURwWjR4UmEvTGdSdW1iOFlIeXdVZEZ5UHNz?=
 =?utf-8?B?NGFiRUlOa2lnY1VXOU9PRTRHQWF3eW1TbzJJTFBINkV2Qm5TcWZWRktvRmhC?=
 =?utf-8?B?NzdYa2xKSE94REc2NWdRN0RrMTk1RzExQnhTYlZ5aGpTZEg4OFNBSmtkbVJm?=
 =?utf-8?B?WkhYZnJhenY4TUZORFExNlUrZFlRYmJzcUZNcnl5QlVuR2VzalpkVjVhRHBQ?=
 =?utf-8?B?SXVzZkNEU3hnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjMybC93QXdISWZsTVJEUW8vbVFGTWM5YWJraVNpYktFVGtldVJESWc2TXRT?=
 =?utf-8?B?K0pwdFFTZzlrY3pkUW9vMHp1VmVHdU90MmFNazFONUZteWVKaHhKa1JxbHJN?=
 =?utf-8?B?enlpemZZQ0NiMWM0eDh0MzFMVnlyVC9reEE2U1d2S0R3L1Q0NkdNdXpvUU5S?=
 =?utf-8?B?L3dJdGRkOG52MGxWdGJxZzdHalJkdHFkQnpzQzFsWUtia3FuRmtERTlhaVIz?=
 =?utf-8?B?TCtKNTRhS3YxR210VXduS2VtTm1uWnZ5TkZDK3gyR1k1ZXVxQmxrbDViT2VR?=
 =?utf-8?B?c0ptZ3JiS3VlM2JGbnQyZG52eWM5OU1LVnFSb0ZwL3p6QkdLWXBOZnkvRHVY?=
 =?utf-8?B?WFV3czdIOW5UaXN1Wmc4ZmQrd2dsTkdNV2RkMEVEaExiTGFqdDhzUC9wMHAz?=
 =?utf-8?B?M1hINkVSTzNNWW9mQ0lvWS85dmZSMWlCa1pYQnhDRGdIdGhXNTZ0YkRwbnhj?=
 =?utf-8?B?UUhQaEhnUXA3SGZyc1J3Z1BvMzhGVEVSd1ZpUlFrb3lVRXBFMFR4SWhSODBz?=
 =?utf-8?B?OU85YWh1TEtWR202UnkyVHJ3RW8vZENkY0JXS3U1ZEc5aFA3Unh2bmVQcFlE?=
 =?utf-8?B?YTZvOElJeUZZSi9oQnpsTnNKb3E1VkJyWEowT0cydnJSUUl1NWUvY2tPemd1?=
 =?utf-8?B?ZXVCeGpRblNScEhFNUM2MVVicnRZOSs2NkZkUVFzc2RaVWppWFlLY3ppVEdN?=
 =?utf-8?B?Q2pxYWhEcmgyWEdseFppZDNyNVNrQjFranl1ZTUwYzNpOXJXdnhXcXRqak1N?=
 =?utf-8?B?Q2RQT1hENXdEODQwNm50Q3RMNkkwZk85OXpGSGNBV0piQW9WeVhGZ2xGRkU5?=
 =?utf-8?B?TGtNRDFmaDVUeU12WmNoMWJHMHRpZE9LYm5PTG9OSGNaOWx2M0I3TFlIM2lE?=
 =?utf-8?B?ZEZvejZFOGpZZlpNbWd5N3IwSklockNnY1dtNkZ2UVl3eXlXWEI5c3I1T1pw?=
 =?utf-8?B?Z0p1SVNWMDJoK3h0MHpyOUdWWVd5UXpHUzBRdVVyUlVBLzY4cWZ6NjRIM2JM?=
 =?utf-8?B?RjZDUGo4SUhkR3pJbDFpQUt2dVROckNkM2xBQ1RPRi9QaEtQMVBoR0svc2NM?=
 =?utf-8?B?MlpCbnZMc0V4UWlNTXVRRnp5alJFRXBWWmxDdWNMcy9xb2ZHZ2RRYUpvUTZo?=
 =?utf-8?B?NFMxb1dHdUo5Q2JMbmxiNUQ4M3lGaUJmazRxeG8vN2ZsaE9taVY3UWxSUEl3?=
 =?utf-8?B?bmV3OGFzL2x2dC9MOHcybEw2SFovSW1JbDZuUDhiSjFod2F5TFRDVStPQmRQ?=
 =?utf-8?B?T2JtQzkyQi82TTY3cUdlelNsWU1pVk5reG1uUUlOOHU1T0lvVlpkUTJ2OXdu?=
 =?utf-8?B?RzN1TUM0YlpyZ3NvVGtINGZkRjhKTUJiRzkvdzVpbXp3RUJJYmd4MURNZ09p?=
 =?utf-8?B?MG5xQWJ6L0hRaEVUOVlHVHNRVmdsRFp3VStLcDZFZHZ1Ukx3RXREYnZ3ZXEr?=
 =?utf-8?B?U2lRM1BWMDdKR3NsUjhxa1VPRUxpa2pZblRNZlRuY3M5Tm1UcmhidXRCb2hk?=
 =?utf-8?B?QWxEZzRER2Z2T0dtZTNydThqVDR0MEgxWTJna1JuRWhWWC9rM1VNT29IV2N5?=
 =?utf-8?B?R05RU09lS1QwVjlZNzdFeTBsVjA2aFVMZnlOWHEwQzhyOU5nWDZHYzZQTDFR?=
 =?utf-8?B?RGNoczdQSTJpaG9ESzRhanRISU1XTk9YMGpHOXNnbk1tWklRZ2JnMXE1RzJj?=
 =?utf-8?B?eUtGaWZyREU5UW5UR2pBWUhTTnpwZFRvSWtpWVBsaEZFNkNXeXFNa09jMjRu?=
 =?utf-8?B?VC9XL0xxdWlCRXBwckkvRGJlL1FlaStmZjNUclFjWDlKYTZ1TER3SE5BZlpl?=
 =?utf-8?B?aTVTMjlYK3AxNXZJWXRYY09FUWhHcU5sTXdSMUlSdGIvemdBaWQxSEphUmh0?=
 =?utf-8?B?VDQ2SzVwdW5VK1V3eTVaQ25maDNWZUhUWisxaWNVcXdNN0pKL3JzL3RxOVVl?=
 =?utf-8?B?YSthS0pxdmdxTXphb0gvekZiSUxReHh6YWhZQXRHZXpRNlJTbXFsNzhiTlhQ?=
 =?utf-8?B?c3VzSnZvUXdIYkloMkVSLzNuZ3hlZWxFZmd0a2dadUFUNzVnT1o1ckp1MFB6?=
 =?utf-8?B?MUFxK2EvSkZuRVFHVml6QTl2dFprRGhsOHdOWi8rdmt4cWZMZ2EzeGxEeENL?=
 =?utf-8?B?S21ZSUREK0xWWk9PcmZpVUNDQ2k4MVhhTnBDdHhoWEV0dm5lQTRqdFNOZ2xv?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cQFECSl+i/URZ4Dk1tH/ThdFB1Iqz2a7Kakvo2EzmwyXWfFtApZEc+I69Cb7sZVpH9PMUov/espX2g5ahYvRo8HfRXKqhsE+a/zv19kkxsgwWqDnb9NYogiIYcRlK4ftCeDW9cqVCxWPgofjaJpYevBGHbAv7sTOPcAU/aNzojh0OEylT/9Lg+luvoXdfqXt707h9TT3LRGxjXkoTP3S+TR3PRmQOQ/2u/6cWta1coFehPvh2Klc50tOKsnjglUhMfi9vfAJgXcZJZGYwzynkNk2dmD8Afqn4/ewihHDsMVcl4+kUKAuZcKU24eGTYwEeD2yIakyVWcYsrIFEZITN+jo+TrWPeBEaKnD5wKXYGJThf8e9RjVwKv0BvV/C5h+ljmMjCL9GvD6qRSFdtuh/S/9/NkAeK0jpJlvi1iE5KZlaseB51xUpHKwLlgEtrpjVvergXJLEpLx4Io4SYZjlahQVYyfVH3HT+WjVxne4HArnlnhxWudSbF/OyoIYa4TFmKfMuYRbVr66QKcOd/6hBaTBDeASjB7W/IIUob1Jd064P+sgd4yX9T5OeLeGNyuuHNhz+WbGeqeVhuhJDFe6ieqm+aNPmNIBblRJC56NHA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4d33fc-02c6-4f77-b9df-08dd8a250af6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2025 09:29:46.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9s6/r/yZYNa/QNotdJxjEraLza1CJDn4sgHN4F/C4Svl0ONndyVeEqSRQU/Yi0IF2IK1RM0w5qlYOesR+jHSitmGEg5E2TYMu+BhPRWcvJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-03_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505030083
X-Proofpoint-GUID: OuZSFyYCoD6TJyKhoboZyVJrHY07BVmn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAzMDA4MiBTYWx0ZWRfX8vrOR6uIxLIc 5yUsAV7f2e8NcgBah7Fq+nRyP8dy7jcjgryo6JK+QSHOx4kzMqf1kcVuBHZUBtGkN6IQD1CmueW LeyhwFmAOx9+xvuveNkfqLBVgxIic0JHrzLdjxNYZOl5ETe24AZdt1r/Hg+tspaN9OwVazDiESv
 tvEKZmfH3gMrnu0/9Kk3QSiBRZqeU6scm53pmAvzzDwbexOxsoIGqRlFfCqjg8HzhrcuLzWbpwp msDdT40Ae5nVaze02iqF3SKJ+szwQ0TQgMSlSVttH/clzI4JOg6yxWBdgrU+2Q5aK7IGpnffLjo nZSbfvraAsLk7+6Yugha3G7wPEy6XDyjJjmH4we5uII/kzhUBJYYva7U8UxRTA1qfERpJAzo+zT
 KMgNWMFf3ZI8lYEHAJKDjKGvjn2MyLRoPRJyxNz4FZqCsEMI8LR79e8o+EAG5/2appxQHKtB
X-Proofpoint-ORIG-GUID: OuZSFyYCoD6TJyKhoboZyVJrHY07BVmn
X-Authority-Analysis: v=2.4 cv=CIcqXQrD c=1 sm=1 tr=0 ts=6815e20e b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=sozttTNsAAAA:8 a=EcxQipIutFa8zc1G2lcA:9 a=QEXdDO2ut3YA:10



On 23-04-2025 12:53, Parvathi Pudi wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Changes for enabling ethtool support for the newly added PRU Ethernet
> interfaces. Extends the support for statistics collection from PRU internal
> memory and displays it in the user space. Along with statistics,
> enable/disable of features, configuring link speed etc.are now supported.

etc.are -> etc. are

> 
> The firmware running on PRU maintains statistics in internal data memory.
> When requested ethtool collects all the statistics for the specified
> interface and displays it in the user space.
> 

> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -4,7 +4,7 @@
>   #
>   
[clip]
> +}
> +
> +static void icssm_emac_get_regs(struct net_device *ndev,
> +				struct ethtool_regs *regs, void *p)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
> +
> +	regs->version = PRUETH_REG_DUMP_GET_VER(prueth);
> +}
> +
> +static const struct ethtool_rmon_hist_range icssm_emac_rmon_ranges[] = {
> +	{    0,   64},
> +	{   65,  127},
> +	{  128,  255},
> +	{  256,  511},
> +	{  512,  1023},
> +	{ 1024,  EMAC_MAX_PKTLEN},
> +	{}
> +};
> +
> +static void
> +icssm_emac_get_rmon_stats(struct net_device *ndev,
> +			  struct ethtool_rmon_stats *rmon_stats,
> +			  const struct ethtool_rmon_hist_range **ranges)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct port_statistics pstats;
> +
> +	*ranges = icssm_emac_rmon_ranges;
> +	icssm_emac_get_stats(emac, &pstats);
> +
> +	rmon_stats->undersize_pkts = pstats.rx_undersized_frames;
> +	rmon_stats->oversize_pkts  = pstats.rx_oversized_frames;

remove extra ' ' before =

> +
> +	rmon_stats->hist[0] = pstats.tx64byte;
> +	rmon_stats->hist[1] = pstats.tx65_127byte;
> +	rmon_stats->hist[2] = pstats.tx128_255byte;
> +	rmon_stats->hist[3] = pstats.tx256_511byte;
> +	rmon_stats->hist[4] = pstats.tx512_1023byte;
> +
> +	rmon_stats->hist_tx[0] = pstats.rx64byte;
> +	rmon_stats->hist_tx[1] = pstats.rx65_127byte;
> +	rmon_stats->hist_tx[2] = pstats.rx128_255byte;
> +	rmon_stats->hist_tx[3] = pstats.rx256_511byte;
> +	rmon_stats->hist_tx[4] = pstats.rx1024byte;
> +}
> +
> +static void
> +icssm_emac_get_eth_mac_stats(struct net_device *ndev,
> +			     struct ethtool_eth_mac_stats *mac_stats)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct port_statistics pstats;
> +
> +	icssm_emac_get_stats(emac, &pstats);
> +
> +	mac_stats->LateCollisions = pstats.late_coll;
> +	mac_stats->SingleCollisionFrames = pstats.single_coll;
> +	mac_stats->MultipleCollisionFrames = pstats.multi_coll;
> +}
> +
> +/* Ethtool support for EMAC adapter */
> +const struct ethtool_ops emac_ethtool_ops = {
> +	.get_drvinfo = icssm_emac_get_drvinfo,
> +	.get_link_ksettings = phy_ethtool_get_link_ksettings,
> +	.set_link_ksettings = phy_ethtool_set_link_ksettings,
> +	.get_link = ethtool_op_get_link,
> +	.get_sset_count = icssm_emac_get_sset_count,
> +	.get_strings = icssm_emac_get_strings,
> +	.get_ethtool_stats = icssm_emac_get_ethtool_stats,
> +	.get_regs = icssm_emac_get_regs,
> +	.get_rmon_stats = icssm_emac_get_rmon_stats,
> +	.get_eth_mac_stats = icssm_emac_get_eth_mac_stats,
> +};
> +EXPORT_SYMBOL_GPL(emac_ethtool_ops);
> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> index 7aae12383ad3..b37991b04dd1 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> @@ -901,6 +901,8 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
>   
>   	icssm_prueth_emac_config(emac);
>   
> +	icssm_emac_set_stats(emac, &emac->stats);
> +
>   	ret = icssm_emac_set_boot_pru(emac, ndev);
>   	if (ret)
>   		return ret;
> @@ -952,6 +954,8 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
>   	/* stop the PRU */
>   	rproc_shutdown(emac->pru);
>   
> +	icssm_emac_get_stats(emac, &emac->stats);
> +
>   	/* free rx interrupts */
>   	free_irq(emac->rx_irq, ndev);
>   
> @@ -1045,10 +1049,39 @@ static enum netdev_tx icssm_emac_ndo_start_xmit(struct sk_buff *skb,
>   	return ret;
>   }
>   
> +/**
> + * icssm_emac_ndo_get_stats64 - EMAC get statistics function
> + * @ndev: The EMAC network adapter
> + * @stats: rtnl_link_stats structure
> + *
> + * Called when system wants to get statistics from the device.
> + *
> + */
> +static void icssm_emac_ndo_get_stats64(struct net_device *ndev,
> +				       struct rtnl_link_stats64 *stats)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct port_statistics pstats;
> +
> +	icssm_emac_get_stats(emac, &pstats);
> +
> +	stats->rx_packets = ndev->stats.rx_packets;
> +	stats->rx_bytes   = ndev->stats.rx_bytes;
> +	stats->tx_packets = ndev->stats.tx_packets;
> +	stats->tx_bytes   = ndev->stats.tx_bytes;
> +	stats->tx_errors  = ndev->stats.tx_errors;
> +	stats->tx_dropped = ndev->stats.tx_dropped;
> +	stats->multicast  = pstats.rx_mcast;
> +
> +	stats->rx_over_errors   = ndev->stats.rx_over_errors;
> +	stats->rx_length_errors = ndev->stats.rx_length_errors;

remove extra ' ' before =

> +}
> +
>   static const struct net_device_ops emac_netdev_ops = {
>   	.ndo_open = icssm_emac_ndo_open,
>   	.ndo_stop = icssm_emac_ndo_stop,
>   	.ndo_start_xmit = icssm_emac_ndo_start_xmit,
> +	.ndo_get_stats64 = icssm_emac_ndo_get_stats64,
>   };
>   
>   /* get emac_port corresponding to eth_node name */
> @@ -1177,6 +1210,7 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
>   	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
>   
>   	ndev->netdev_ops = &emac_netdev_ops;
> +	ndev->ethtool_ops = &emac_ethtool_ops;
>   
>   	return 0;
>   free:
> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
> index 3c70dc9c4be0..39ceed0e2d15 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
> @@ -27,6 +27,12 @@
>   #define EMAC_MAX_FRM_SUPPORT (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN + \
>   			      ICSSM_LRE_TAG_SIZE)
>   
> +#define PRUETH_REG_DUMP_VER		1
> +
> +/* Encoding: 32-16: Reserved, 16-8: Reg dump version, 8-0: Ethertype  */

remove extra ' ' after Ethertype

> +#define PRUETH_REG_DUMP_GET_VER(x)	((PRUETH_REG_DUMP_VER << 8) | \
> +					 ((x)->eth_type))
> +
>   /* PRU Ethernet Type - Ethernet functionality (protocol
>    * implemented) provided by the PRU firmware being loaded.
>    */
> @@ -108,6 +114,119 @@ struct prueth_packet_info {
>   	bool timestamp;
>   };

Thanks,
Alok

