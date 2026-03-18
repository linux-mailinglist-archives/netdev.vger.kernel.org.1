Return-Path: <netdev+bounces-268930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKa0KZxrumnRWQIAu9opvQ
	(envelope-from <netdev+bounces-268930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:08:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 239F62B8AC2
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB1A5300DF6A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5904437C908;
	Wed, 18 Mar 2026 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qmzFEg83";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kc0Pml5m"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2893333440
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824801; cv=fail; b=shUEuuxwDuCax7kYDFS8yjICwlvj4lUu5hZNPTws14jF2TAAQIilzlmhI/vMTijlL7b+9KAu1YVRe2jSfPVS4zpo32vfbvMY2ccEzByCESds/hg56O2xcwXPgAoFfhacYixnyMT/S4br12DDigKEH1ScG8ky7amv9EPHfh4W2uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824801; c=relaxed/simple;
	bh=VTcY8veLdHwXlspmUZoddWiaaeRdrougrML77xbfH40=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZY4HRwupQK8r1gAWCaVLepNPBZZDqV6U/j3lsXZ8T4M9DOJdh+4rWtPRr6tZAoa7fUs828gaxDdpBhl+gJkTds60o8N33q3T5htN/a97TmgCR1Rt37Lhpbe+LMPrGQ/bGPcEmdypWWrmJLCm1KWuYQm2HFg6IwxKcp8rVU344KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qmzFEg83; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kc0Pml5m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I2MxKN2167114;
	Wed, 18 Mar 2026 09:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cfEN3OdjGOu96WpNfBO8n7mmx97Yvq/bOYf5nbCbYvQ=; b=
	qmzFEg83fQKmsFI7kLT2undhKHrkissTloMKDamQaPQYyoqdTOzX7E82qsLBq2Ak
	r4cfWMnmIcR7LxZyARFgNO256a04WoaWnOFbaXtMIJHETuIlZ5xD/brumMn0HYcr
	etb8AkNsFYW2tad+sG+l1/0Rt2H7d95nis+8wp2n4tP9XlUUE4MOYvXFpxM7IcTV
	X+5aYdM0vekreP4Zn2rUQcR3hCnRZexpD+Kk1aWnJmqr6pvznlcnvXasKTS2W30f
	V3o3LDO8gZQjzlzCYrLx1+IW99QxK6zREdIJsrCyUhIDdJIkrKvVr5WnZGV3tCtB
	8Mqpv3iKSS/mNBKTWiGe1A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx3b5kkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 09:06:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62I8k3xd003544;
	Wed, 18 Mar 2026 09:06:31 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4bbffb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 09:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXJAOoZ8XmC9i1xxeMKwZA8Nbg4X8vD4d4wxELFOxjoyeehksZaTRbw1QHj3arj7LRksdvJRsQoVe11R7/pD2xkeBdDrRSE1tqkmGr4URjbt1Kqax6X174SXXVNPnNlgL0XkR5hfOPflXfnxLAOZr8YBQEHA0CEQ0XpDiLSxAOF+fCQIP5U2JLTXxaxuumfuvwO5nBn9UNeFqmdcBJgAlCUWnrVLDoRxeC4BT2P12eTuRRLEOHpyOr4SESX6ewkwmiz8Zq14DE40z3ltZHThLO0u9+XyTp4ko+ylDNJyVNLf0nCM/qKTkqmp41dIKLNtFNzt/tU7tX+xfo3dIlfPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfEN3OdjGOu96WpNfBO8n7mmx97Yvq/bOYf5nbCbYvQ=;
 b=pOm7Ap01Aaci7yZZyEwn+5G9nwDQxy8F4DWkSAdpRl4OVySCn6QwLMROlXjJz6WyYpeni9nC2YNaW3bTLrlxJ6QCXb2zrASkK+lWA3g3Tjau4FP+6tQQYaQedhyAFTSl8cZAZsMWZ6OJHXU1/wmofDXGQapVsgRXYRSGkYPc1LXQh4lwNuzGZjWayLeZbki6/v5WjyjXs6agNgVkEPrtrnhR729tQUqBOXqhopIV10nNH2oJdfQ2ygijJl46KremvfHE1vuJLt2o2bW9tIHe20GYujhaOAL3r4LKyVQXv3JdoHJKlGjgj8qQt/Eewl75yqbnwCElNBlfrsHlPEtBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfEN3OdjGOu96WpNfBO8n7mmx97Yvq/bOYf5nbCbYvQ=;
 b=Kc0Pml5miLYr88DKSYJboYFhlXLon3m1q5aYkZvXzscW85y9DoBaSnE7KiPD/iEjeCG+W7vc16YB0rP6H7Jxg4rqu99aXaf7Dosfo/jEeCM2Yie42HwK0DQAZWh5fW6hgTPJRVzIO3qqAWwHmr40MdjfhWAIzc9hwLWNJP8ICqo=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by BLAPR10MB4929.namprd10.prod.outlook.com (2603:10b6:208:324::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 09:06:27 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 09:06:27 +0000
Message-ID: <9b8a050e-47b4-48c2-b6e0-ccf202611bae@oracle.com>
Date: Wed, 18 Mar 2026 14:36:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool] cmis: Fix incorrect LSB field used for wavelength
 tolerance
To: Danielle Ratson <danieller@nvidia.com>,
        "kuba@kernel.org"
 <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mkubecek@suse.cz" <mkubecek@suse.cz>
Cc: "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>
References: <20260318083401.375458-1-alok.a.tiwari@oracle.com>
 <DM6PR12MB451699CF526A71A2B2AD4619D84EA@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <DM6PR12MB451699CF526A71A2B2AD4619D84EA@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|BLAPR10MB4929:EE_
X-MS-Office365-Filtering-Correlation-Id: 42dcd7a6-f1bd-4207-94df-08de84cda2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CZqU4vDdK5VpKG0qWiwP+UZAi88ziWgfT4OaC+K41fkaWImeChzhjUtd3yvORhV/rKrVMLeba7ZZbUX2A+SkNSoqF5y3cRBlxBRumQxlDBoktEbuVOV4f11IOfsHYibEP7DBt0QTDzvgBDtOA8cHC7lelebxGdcX0fMpTRYi0O8Duyv7S6+oXgnMKg3VfrUH0hiVFmW/6Z2NkyQgo5U6gWgeiMqlYZmH0w+GOA577N7bOeN545NOnOrzrfs8o3Pl4QAd7AjNYz9CSKnVG/7efLJIoYG/B/Sih+gud5L+ZowxsiTuDxERQwbFTF4Vi8wCKMRcBdFcWm3y/zyzRBli3LJqzG+vWhoKeBEVV8TMlB52fPhoNZp40xv8rWNFy+YTeySfzCK+UGFxZ7SPo/dLGfkeEHefqHlTKGPUSnmoAv21P9JpjsgYVgaulIj4B1gufAm6ZtxNz8uPGCx22MPs13mYNcS9YNlmhvd3eOEy5xTTMCE4C6gl190d2Asw+S+fPAtGjEZfFBQHv6ZDXr+d7Djfiag5IakLK2DeujxAoBa+YC6H+g/HPGdBjyuGEJk4VolcrxjnpNyEZ8X+7eTYAWBftmUvgy7js8lNt5f8KN118Fr6R4SnAhZnaIG+pHJSMTWCe+HoknIchj1C4mvDwiVFz77E+Xutd9tVk5jsa9RAFKzx0KqYyzjUjqBhI1dLPQAuZRJu0v5Fdmv9RaARXdelG4FAOtat2WtNVvq8WKw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkRqcEo0Y3FYeHZRQm4zVXVvRi9yeW1CZ2FsSU5UZ0hYb2RIT2NYUUp0QkhS?=
 =?utf-8?B?WkF3bDlta0tXV3A2eTA2ZGpxNjhXeS9wM2RZSGtRSUsrNkJvUzM4UkZ4NDgw?=
 =?utf-8?B?NDF4bE1lT3ZaYTJ2djRrZDhseXFJNGkvR3VHZ1A0b3hKbWdTN1dBcFBVTjZK?=
 =?utf-8?B?MStsdTNSZ3BocnBwYVZyUXhHVTZzTkdpSk9OUUljbmZEUTdyUlBSYzI1WFo1?=
 =?utf-8?B?aTNsc3RselFudkZNTjl4SjlvUmQvTEZLMmVPbXlNRytGSHptSXQ5WGxXMExF?=
 =?utf-8?B?TWU3a3U1dm5DUTBXZGY2MHZZVm4wNFZMNWJNOGdJRkttTlV3dGZoZ0NyUng0?=
 =?utf-8?B?eld5VFNhZmFBVDdnRWMrSEtBUjlmc1NnSFZiQlcwK1hlOEFvbW5RRnRhSWRB?=
 =?utf-8?B?eFZRSG9pY3dkbVVGWGpQbmNnWGlEcElFZzRSTXNjR1ZEWmYwZzIwb3lKdDky?=
 =?utf-8?B?WE9ETmxpQ0FRdUJ3MkdIcU52VnZmb0hTa1MyUS9hUk12dlp1RG16WXhMazFV?=
 =?utf-8?B?bVczcllSbzhTYnpRZERjdW9KNFFuQkQ1cDhTWVltblYra1c1TG4xNmdNZU5G?=
 =?utf-8?B?ckMwWWMzNURRczF2L1QxN1lRbEttSVNmMkhoeFZocVMvNGh1bkpLZzR2UnZD?=
 =?utf-8?B?N1k3eWJDV3hnUEt5UXRCSGpOTVNtdFYyRm4wME4yV2F5cU5KbDVzVjZtZkdr?=
 =?utf-8?B?cEQrdkM0Wk9XaU1mMk11UDh0aHcza3diSUdYeGs3UGVxN0tvYU96LzliK1Ey?=
 =?utf-8?B?cUd1KzVTZlEzZXBheVRZeXlIeWlpWEVvNnpkRGlqNXpsSmNxVlhTbkMzaFo5?=
 =?utf-8?B?TEV3U2QxQmtoamxsQWorR0dpdXpJenIrcEFoQnV1TFI0YkdiZTBjTWQrVHFi?=
 =?utf-8?B?VGE2UjFjMEZaVzVhY004UUdhdDVpRExDTFAybU1LNWkvd1Z1Y0hCamR3cTdo?=
 =?utf-8?B?Y1J6TWs3eW9MUnRiUXdXSHhSU0FTaGQycGVIR3NvRlZvRnFUbFAvcStVeWFK?=
 =?utf-8?B?L1FsaGREaS82OGwxeEFic1B2MEM5OWRFV1gvaDRQaHhyTHBzb3VRQXROdjNh?=
 =?utf-8?B?bHFNRUt5UVlKV1UvVndmUE1kTFVLd2lua3VYemRHem8yL1JkSk4vNmJRZkpZ?=
 =?utf-8?B?OVFnV2FyR1czanhaMlNiUzcxSktHZmVkalZmSGo1Mk9ISFJkejFWeVJHbmpy?=
 =?utf-8?B?dEdSYm0xdXQ1UGtkTXlKbnZLdlQyY0pXWXYvaW9sZnZCZXhEN1lsSnVLVlNT?=
 =?utf-8?B?d3ozdWpmeDBabXg5cmxONTdpSDNvaUJDM1djNElDOWxDSGQ5ZjVMM2h3RW5v?=
 =?utf-8?B?U2EzNld3WUxlTEVMcWRhYlU0Sm44VFdmRGpMRGhIUXlYdXBMT0Q1SVFVcUFL?=
 =?utf-8?B?bEEwdisyUG5Pd1RsK0FGbDBKd2lseDJ6WFo3azVFWm1IalY3ZkorVnY4Kzkz?=
 =?utf-8?B?SFV6WVB5bUROMWpreDQ2dXlIK3AvRFRwbkdOWDlrRG1TRnQwVVQ2d1p0TGpZ?=
 =?utf-8?B?MVZiUCtPRHQ3ZU5EUlNiRnBNVmtSQ0hCUTc0a0ZmMlNZdTFnYWwwdUhZK1VQ?=
 =?utf-8?B?NWkxN0YwVEFBUitIbVNjUHUrQ1NpaHJ1dmxJK0hCNFBTNDIxSUtwUGdma2dF?=
 =?utf-8?B?U2pNdUQ5dmZ0amt3TUpQQis2TU1RZkJZaU9zZ3BZWEU5OXV2Sk5TOTBVa2Zs?=
 =?utf-8?B?TE9KTEcvNnBQWGhMdXY0TFNrU2U5YXBxNVQwYS9EeXpBYmhSYWFyWTJCWmlh?=
 =?utf-8?B?WTlUandyNDZwckN1aFRDTmNpOVFWTGpZMVMvRzhRcU9FdTZiM1M4WTB2Mkcr?=
 =?utf-8?B?WkFNZnBVUHVMck9IVVh0T20yM1RGWEx5b3NnTFhCTWl2VGNuVmdBdlJQUGs4?=
 =?utf-8?B?SnR0a2I3K2xLOER0eVc5aTJHQjRtUkI3aFJiUmdwZFRMaU9hSTFwZjJKQnJz?=
 =?utf-8?B?d3ZnVmRFcC93OWtPQ2xKN3NURi8zZGdFcjdwTEY1NDRyamZlTnhBWXVxWnpj?=
 =?utf-8?B?NnFBY1B3Y01oS2p4ZkEzcm9rL1Q0SzJkeFJGaS9Ra0xnQWU2Y1pqNTkyTDZG?=
 =?utf-8?B?OXVpdGNaamJ6bUhraVcvdU9ENDNkV1NJejZrYmJMTGZhUEZYa0F0N1NaNFB3?=
 =?utf-8?B?Q2FsTU9KYUJibHBoSnZ3ZTY5Tmx0Q1pkaVNoakxCdlZsVGJxSHBzWWVSbUk2?=
 =?utf-8?B?S08zUklGK0tUa1NlbEFhRnZwTlZ2dG5MUE55Wkdjd1AyRlFuTjdvdytSNzd1?=
 =?utf-8?B?Z3NTMlBPbnRnbE15bEtVQWV4bHNEZ1k3WVpGM3FpN2pPS0dMMlRaOWRyaUQy?=
 =?utf-8?B?SDJMS1ZleEpRV0x6NDFDNEFRZmR1aThxbnpPTEJqOTMzR0FuMnBBN2dtSklF?=
 =?utf-8?Q?Vl/aUuUDkbSEuzcM=3D?=
X-Exchange-RoutingPolicyChecked:
	RHOpeBxFq5gD5ZH4SSXX/9cpQsRuzFPkNc/7u1rR9BqUlPElXCey3i35MnlkgRcM9poakJv0OZKRUeI4VK7VvXI7pDJxMXLAz1elkb2c3emRhOhzVVbM3dMCQ/bWkq1rG4EPHZgehHGOuTubockpOEpVMZL1cRjbhdJ/OlHRMiAs3oDw4Tpbels4SzfhoA/CGFEcqylAXPzVu0boHXc73bWpNt5MMrNrt3+ZOMhHQ9xLiGjIE6olh5xQkentG+wrwLSaQtZfwXJTjJt02XryrdqNYODeIJ7v8B1YP2BYbk6YjXs2VOh9EmPuVi/K5gyT48jmQGw/4XB+kqvgFpTfbw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5LAka63JoPz3irNm6wuNVIt+tU9XL9rxx9Z5oItcv9/j2RKVa4S+GNbdgczOS6p/mANoxEZ5UNzuuuNELxQb5q9192w8cFM1/Eu4/dmy5CVDO5lXirtLsy8C1gueCSbfMTR983p8H2j+ehIp8BsWTtf817emPCsAX2iw1Hl1md1VeOKtif9dqVtC7fQ6nG8DsrT3Xo3EVsImzbaA6Zd5tNHO7NAGO92d0HnafCmDJy7zShyAmH+FY6hv2PxpmaYFdmJPUzMHmuiTCgOYez5db456KS4/oHjuUgpF57G8nNHglRvhV+g9eYm4RUZpyvpRFmYvE4rXlfRbLwsecCVTda2XNoTb4t9Y+N8TeQSy1oj49vusEJiLynNO9mSyp/5dps43dSLhe5Q/VkmyzZHANY0p6dzKDIAh4bhBFwOTpnvZz7qUHJQi223TRSE/zoeEpP4/L1qw/iKEc4nFOnsUudVv2rErZGsQPotrMT7l64g80sGP0tyswHG5M3ST0znHcHXA7VZpjHidCIy5cya8fON8cCSG1v1FLM0zRlUFBNKpVGpMn0hCTWxGRFaqGZpqU7FsarUtspjInZAu4YEi2hSKJW7NMzZa1bSpH3VkbcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dcd7a6-f1bd-4207-94df-08de84cda2a9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:06:27.1265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8g4tnEOcDZhEk2bfi70ci3ccoH/vChq7BO2ThM5N4xIqviOX1vY2fU0iQytyJXUbnBD287mK+o9PqesHqRz+KxLzyuiO9TzDjsxkEGkukg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4929
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603180076
X-Proofpoint-GUID: GIUpnVjZbd8ViIsYPpy2JuZsZf-uYUGp
X-Proofpoint-ORIG-GUID: GIUpnVjZbd8ViIsYPpy2JuZsZf-uYUGp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA3NSBTYWx0ZWRfX4iJy3oz6OyLM
 97ZyfBwniLUGcrQEInmNxLKb8LPXdlBAXWFVrkXwghfR+Opwn45Ws3XAEXVCQE7Xn4Z4Tq3/jfr
 pws8mMw4Ku+riXiXIfG6tjs24hreaJ3hgyUhhgQcRz5QVPmpf3hULwwKdcgYzbw5ctV+iD13fFN
 0AMNvgQnKAR9UTPzzEjDe+4g8dMRrKqbFQKtjq3rQHuJIHaRyDDFB8vR/OUSkpC97m2Br3/7sCe
 0CVLos02c3DCf6YVpD5gxgCyxQD7JKRvkuc11kl0nhyPtL86o67SqmIcWCYaEo7c6cthhQvyPfq
 m1wOlYpG5mQ8ApTtySU3cFX4NGthLLOo1yKR4jDNrHOFA8G3rHwrStcc0VOp9jPtlVwO3BzNNew
 PHYzqSJsYkLrLwUNoyw1naTozGRlljbvMZER/W5DkQNa7fIQrqFVN7TpmsomAy1EdnKqSvwRPRs
 OmsEjLPwKRXiAYrj0ow==
X-Authority-Analysis: v=2.4 cv=IN4PywvG c=1 sm=1 tr=0 ts=69ba6b18 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8
 a=XAhSphBTiVTIRidoOeUA:9 a=QEXdDO2ut3YA:10
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268930-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 239F62B8AC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/18/2026 2:26 PM, Danielle Ratson wrote:
>> Use CMIS_NOM_WAVELENGTH_LSB -> CMIS_WAVELENGTH_TOL_LSB.
>>
>> Fixes: 3448a2f73e77 ("cmis: Add JSON output handling to --module-info in CMIS
>> modules")
>> Signed-off-by: Alok Tiwari<alok.a.tiwari@oracle.com>
>> ---
>>   cmis.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/cmis.c b/cmis.c
>> index 305814c..345ce1c 100644
>> --- a/cmis.c
>> +++ b/cmis.c
>> @@ -276,7 +276,7 @@ static void cmis_show_mit_compliance(const struct
>> cmis_memory_map *map)
>>   				       "nm");
>>   		module_print_any_float("Laser wavelength tolerance",
>>   				       (((map-
>>> page_01h[CMIS_WAVELENGTH_TOL_MSB] << 8) |
>> -				        map-
>>> page_01h[CMIS_NOM_WAVELENGTH_LSB]) * 0.05),
>> +				        map-
>>> page_01h[CMIS_WAVELENGTH_TOL_LSB]) * 0.05),
>>   				       "nm");
> Hi, thanks for noticing this!
> But actually the original code was:
> 
> printf("\t%-41s : %.3lfnm\n", "Laser wavelength tolerance",
>             (((map->page_01h[CMIS_WAVELENGTH_TOL_MSB] << 8) |
>             map->page_01h[CMIS_WAVELENGTH_TOL_LSB]) * 0.005));
> 
> So maybe use the original way instead, and multiply by 0.005?

Thanks, Danielle.
Ah yes, it needs to match the original code (.005).

Thanks,
Alok

