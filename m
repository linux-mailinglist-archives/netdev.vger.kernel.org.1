Return-Path: <netdev+bounces-258663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPOkN7xyj2nqQwEAu9opvQ
	(envelope-from <netdev+bounces-258663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 19:51:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7690F13905F
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 19:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA363300A306
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B2927A904;
	Fri, 13 Feb 2026 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NKvHBc68";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OEIeTzQF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C062356A4;
	Fri, 13 Feb 2026 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771008698; cv=fail; b=HZh0p6LDBawgWHPAlc85EzUHHBzr0Ccpf+1/rzvxcV/RdRvYg/V6KICnWNZ/W/ALxloDqskesIxpKQRL6D8Vkq3mYyX7s2tHKYuFSENpApY9u07JD/lpa1UOPP3raWMtbAkD/Yy8rNc7qS2mcSDKSGPTTo5/ADXPNba0dLYaQeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771008698; c=relaxed/simple;
	bh=uMHBIzgweL7SqVJ2ILr7hwmvdZ1TXpfh3JWhEEkPpYg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RlrHHhcU0CQQil0jGCG4CnZTcPdCEq3UoN1T0CStfuzvzFF2mk8HAadOKsHS4m4vgiUqt7oSWpwTLSb8JjJKEvB+HF3QVZiqI0tDc6nO3EAHkpkX23Ywfcfw6xBCOlFYf3vrgEPp0cwdW09R+cEWyA/znGa3vvgDXxI0sBVQfk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NKvHBc68; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OEIeTzQF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DDbJfY2579034;
	Fri, 13 Feb 2026 18:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VBX8nHBWYcgM+r8Es/bAq/z3/qkJx4pQSd9XbVjN0nk=; b=
	NKvHBc688FUs0D7gY3EJgLj55k/qELjImfkwi75REHJ1EYr8tS3w8opDnfKTkb0Q
	T6Jj4kuwcU3olEAk28eDwGvukzZ3UNYb5dYjVbMG9+JQXhZDrdqbAkHmw2Nmdoc2
	W7ZRdH2uYKjlrxdtwbefkjAIPs+OYP4nzwhd6q6PzwQidzXCkm4+8K5CLXt7M91m
	wdzDjKhH8pdPfuaE/3877j/JZi72iZU36ekyTaeeQR6m2yxJ7xmUTW0fhyCWvsMP
	jd70b7PWWpbM/EfveItYrGJqiIB+ZUd9cKmpPNu0IW/vsePcTtC77XtpzM01vTJp
	zpBGIQAki0Bd7rSVvKsCSA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c88fv5r4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 18:51:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61DI4rjI013231;
	Fri, 13 Feb 2026 18:51:21 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c8273pwvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 18:51:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwWkmL1lVjX4HAnd6TgacGWK7b80SqSyfQETobp6HJiWrN+00S8sb1l43CcZKgIzlN0et5IyuCPkoyNFkXyCEwVhYfMIjfHx1qjBQNFkiG24EF+rKtxCdKynEp/zqk6ZhtbQhwoR5Mctce4fZbELlRRl1qi5bbHMrIXC8F72uMWyzQybb6ZmzDGn036X9/zLhs4iDfpFHeG8AxKV6oDWVIe3bDK65RqGXT30gjHCHfXtZnB016VSWOYi4zHnGBLZqcxGRjmZ9Zwk0TeLGqXj+V5kxIArNIHSzdnNB6lXvcQ/wZaDhNWCBNwlilrVNJHRti2JMtA1/qEvs6fN/N1HXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBX8nHBWYcgM+r8Es/bAq/z3/qkJx4pQSd9XbVjN0nk=;
 b=sw0z8C6Qiy3kQp2X/dgy5yKm9Ib6jpRFc4deUyq1t8rpk4Oa1/vop6LX1d6S0E7dpikA1uWcW9gIHNYRhq89ziH0X1TUfEquEkeccck3VSlVoL0oOTCMm9kToN/KvJGX9m+NB3NmqyyDHAku6zR+iNxELmuStsjS9BouYLsl7YKptlfd8Lw/ybj/mVVTV9UUink/x6yZ2jXrSBWkGqMRDInLaz5GrTz19T7qXQm/AfDA8F29eFD5WrAlkP08zFsDHBCgRmSz1NKYq7ZFa9IoGrKQX+pAsQq4UWr8YBIoqOioRXZETnK8M0ur/k5HfQXbCJL4pucJe150WZy2t6w+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBX8nHBWYcgM+r8Es/bAq/z3/qkJx4pQSd9XbVjN0nk=;
 b=OEIeTzQFj7edsA0NIDtL1t6VGcHBo6oUskdSaCGXstJNR4XCwT2bbiBvKa4ESPIGmSjsX2BjgUghqIV6YSYZp0zi91G4yOJI57zC3QHsifj7IdtJ67olfa6nCDjM9sW4ctRYG64lWI4OXwEjT/7hKGeuy871X/wxgoeSiW827OY=
Received: from IA1PR10MB6050.namprd10.prod.outlook.com (2603:10b6:208:38a::16)
 by MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 18:51:19 +0000
Received: from IA1PR10MB6050.namprd10.prod.outlook.com
 ([fe80::645a:f184:3a35:ef9f]) by IA1PR10MB6050.namprd10.prod.outlook.com
 ([fe80::645a:f184:3a35:ef9f%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 18:51:19 +0000
Message-ID: <50e88063-14fb-4912-a65d-172a85def1ee@oracle.com>
Date: Fri, 13 Feb 2026 10:51:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] possible deadlock in inet6_getname
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>,
        syzbot <syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <698f15e6.a70a0220.2c38d7.00c1.GAE@google.com>
 <CANn89i+mVCLW2g1+tnbK8k9E0AkEuX7AZ+2LbO1_s2L=Gxaaeg@mail.gmail.com>
From: Gerd Rausch <gerd.rausch@oracle.com>
In-Reply-To: <CANn89i+mVCLW2g1+tnbK8k9E0AkEuX7AZ+2LbO1_s2L=Gxaaeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:180::34) To IA1PR10MB6050.namprd10.prod.outlook.com
 (2603:10b6:208:38a::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB6050:EE_|MN2PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: ae938631-0c13-4955-bf87-08de6b30df35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWJNTU15MjhoblhtUVBUQ1ZHRFMxbkdDaGdEdEhHUUNaSjZvWnZDelJMcU9K?=
 =?utf-8?B?cGZzb0c2UVZqejhabWFyWUNCU2d3N25YeUV3dE8rdmJZN3Yvazk1OE5FbFB6?=
 =?utf-8?B?dStQV2dyNHRlUUU3bDlNclpwUE44YXI0TUlzWXpNRTczMVgySFN1TzFIUHNH?=
 =?utf-8?B?ZlY0aFkxbTRSUzJQbEdzNzZoQUo3TDdrQkFpQndrd0pYYnlJUklLaTlINlJJ?=
 =?utf-8?B?bVpQb29NcmdIWUdtWkQxdXVHaVRtQW1XZG9LZFNoRHc2UU9FNTBwczN4MWsv?=
 =?utf-8?B?ZllKT2JnczRheWdzZmJXL2ZjSWpyRlhDRFl5VW9HSmdpTWpMS1E5bDRkYUt5?=
 =?utf-8?B?R1h4KzFJMHdMVzFwUjRzdXZldGp1SElGbnFWUUhmbHpEY0ZWVklhZVZpOFNT?=
 =?utf-8?B?eVJpQVlEVzMrNU1IY0tsamQxSklNZUFyRjFsLzZXQVVjamhpMW9yczR2d2tq?=
 =?utf-8?B?UlUrUVFpeUxraUJQVTlIRDNsaUpiZFhRaTdrck9Sb0JTUk45SEpRVU43UEVi?=
 =?utf-8?B?KzZRT1J0ZDVDK1FSM3Vka1p5S28zYjdvVlIvVFBFK1ZubUU1WDlQRXhXK0JY?=
 =?utf-8?B?QktIOEEzbzhFbUlYSmMwSmFHVHNIT0pUN0hHUk1tVzJZQmprWWg5NEg2VjBN?=
 =?utf-8?B?M241SE94aEVtQjM0bi9zVENEeXpteGhHQy9McjEwVkFxb3VHSVh4ZDVsWllV?=
 =?utf-8?B?Yzl4VDZOSmtiMlM1YmJJV1ZTOTIxMEJDeHQ1VVVwUktGU3Y0bWxMVm1IZzFT?=
 =?utf-8?B?YnNhK1ByZUpnYnRBa2FPQndmVHpIdEk4MWlmbHZrZlZsVHlIeFBza3lBZFVC?=
 =?utf-8?B?dzZ3VysySDhPYUNxdTFVUkZtVHU2TkREWVltTFFlc3FVOTFHM0xRYld2M2NC?=
 =?utf-8?B?YjZZZm85RCtrQzdRZE4vSWswNERveklDLzN4YnBJK2M4TURiM25DU1lVendU?=
 =?utf-8?B?VnpoaW5BZ1FBdlJlK0NqUUJCL2xJOGJ4UFZ1MFlkWHhXQXhkandmTzcrVGYw?=
 =?utf-8?B?bUNobDhQdEhWSkY0c2d0YW9oVlhpamhDTkpzQ3Jpem5jWnpkNHJKU2N5bklD?=
 =?utf-8?B?MHJ2d2FlSmg0elAxdVJtdjcvOGszTDhXWExsQVhWRjRLM0pqeTU4UVZ1TFFN?=
 =?utf-8?B?TWpwUmoxY01RbGpzZ1lveHVlWjZ4c2hTVUZWd25mV3BWVDNCRmw4blJCbjFr?=
 =?utf-8?B?Z3pJOVJwU2gzUDhFUFlMTUVoU040VjQzUlpDTzAvdFU3N3ZzSmFxMW1zdk4v?=
 =?utf-8?B?RDdUUGIyVDA1VGhCN2FRT243SVVocktKdlg4VXlxbEZTbUQ4aGxldDB2cGVM?=
 =?utf-8?B?anZsY2ZweHRrWTVjTSthMG1vQXIwazBwQ2drQTNvd0xxRGx3K3pJelNhUUtJ?=
 =?utf-8?B?cm5XbElEOTBKdnl3R2Jhc0dxbGlIdW9hVy8xRjVUSGUxVGZUZ3ZhRkQvMWgy?=
 =?utf-8?B?WUlNRXk3R2hGOEU1SFM4Z0xBRXBSL05hdUlqNEhkOWRVK1pJYTF0cWhsaWRw?=
 =?utf-8?B?SnVxYUdSbmRzTnlBaXFXL0JCNnptNWcwMHdsTS9hbnRuY3hXT3NDVlcva21x?=
 =?utf-8?B?NWM0RFhLVDNlZ1Fzb2xPQll2VHg4eGs3bU50Q3RLdktLUWZSTWxkVDhTd1Q5?=
 =?utf-8?B?RUdzdHNZREU5ZWhhTkpEZ3NkSXhkVmo3b08vcHZpaTNPT0xPQ25qRGtrM1Nl?=
 =?utf-8?B?T1pzM3QwVzFjK2daM1NrQnphVjkxSi9wd3hGNjUrQUU4ZVF4aTBsUmV1Tjlt?=
 =?utf-8?B?OUR3cnlMa2hyb0Z1TmtLQlRiTit0b2liOWh4dnRxRCt1RGhrTWd2MitTeFJP?=
 =?utf-8?B?NkJJL05MQ25EK0hhLzVHQzRaREJyWWJHUFEzdnRqNWpQTkZIVVJiNzVSZjVD?=
 =?utf-8?B?QVpBeVFleW1VUCt5KzJyTFNmVDcxZ1p5UndFeXIrZFh3bmFjMFYwSmxGRWUx?=
 =?utf-8?B?RnZjWG1XSkx4S0NETmd5QXp5TWRNK1lSL2Q2N0w1TmhwOTZ6TG82NUtSTml1?=
 =?utf-8?B?TG1MUFhDM1dPZzdnR3VZLzlqNG9sRktaMzdyRCtrOFVKL01nR3N0dnJQaFFo?=
 =?utf-8?B?RXo2enR0SFo5bmNhZXNJM2ZUdWQrZzI0UDZkejN3S0xvVWVmakRuc1VONHJE?=
 =?utf-8?Q?dae8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB6050.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGdnWjVoajc5Sy84bm1BQkxQZnprVDcvVng2Y0dnNWRFVStqUW10bE1JS1Rw?=
 =?utf-8?B?eUdYMTd6VUp2U1Y2a29iMVBIdWN0TVhBT1NLQ3lEQWRBNnU4N0s2Ykt3R01L?=
 =?utf-8?B?Zk5UTEpkek5qRmJDS1Jrc1lKcVE4M1VHa215aU5wVnpncWpXWWtWSzV4TDlS?=
 =?utf-8?B?U1QvRktYdU1ER3h2N2Y3THEvcjBVTFVhbkI1RmpGVTdmYU1SVXNiR3lLa3dY?=
 =?utf-8?B?V2N3ZnBvUEtHd2hEd0lhMWR1amVlcm1ab2ZYYldyS09DKzhWYXhjYXBqTFdr?=
 =?utf-8?B?Y1RlSDJ3KytBY2J1aDZuZUJMaWJtd3RkdENZUU1BdUZwbnh4LzNoVFV0R3J4?=
 =?utf-8?B?NTJTK1lxaUJBUDV1SU9NQ1U0N0lDTndQWFRsSEZqZXVnU1RKUDNzWGZNRUZE?=
 =?utf-8?B?Rlhha2pSM1pHdXlrTVJyckpZdkN0Q3BmcXo0dXQyWkdUWHZaVGVPU1NLOEdm?=
 =?utf-8?B?WndJb0R3aXlqU0dwU09iN1pFU0poUE1raDJpNVVrNXZsL1NOVjdjbTRnckxO?=
 =?utf-8?B?eFMvNmlVOGNXc1UxRTQ3cnYzYXBOdDREK1JmL2RqbUcxVTRhS2d4THMvU1pF?=
 =?utf-8?B?WGd6Q3oxMW8yaS91V3ozNjlmcjFPeThNR1MvT0pRV2JvM2JJTlRPZWMzUGlE?=
 =?utf-8?B?Zmp2Z2JrenlGMGlRNG5VWTg3Nm4vS0Q3WWhjQ21pdk1zQ0ZEMjdpbjJYeEl2?=
 =?utf-8?B?RGNtbjdYL1VaeHovVDA2Zm1hWlFEa1ZiVUtBbEpKYmJFazBCRUV6K0pGRFBn?=
 =?utf-8?B?L25VSFFmR25qME5WcmRwSStqcVFBMENOSXU3cFJBN2JXdUhQQ1R4TlJnUktJ?=
 =?utf-8?B?L0c1bTRzNFRwUmt2b2V5clo5TEFTMWV6ZjRYTTdkUGwyUHAwNU8xazdTL1Fl?=
 =?utf-8?B?eHVqT09aMEk0aS9aNDdaVVhVVlA2YmVMWXVwU0dwdlo1VjU2QldWOWdHVSsx?=
 =?utf-8?B?aUtTVlVXRWtvVVNTanh4cE82YVFpZjBtS0tpMjdpYzFZNzFRdUFwcGQxTHZj?=
 =?utf-8?B?NldCRExIUXAyallKM3Z0M2FZV3ZMZGJmenhXUUxoVUVENjBYd01QR3gvVTY5?=
 =?utf-8?B?TG9uaTNKcXZ6WE9jTUVGOHNyQ2RtdHgyZy9uZVhHazRjQXlmRjFTeHF4RWtx?=
 =?utf-8?B?elM2WHdwdHd4N3JRR2hQMCtaZmpMQ3Jld3V4OHpDcll0TTJBUVIxczlCWFg1?=
 =?utf-8?B?OGhkNUk0ci85bW9EM3lHdjUxMnpTMHpXMTlSamZKMkZWUHVJOVJCcVRnUmRS?=
 =?utf-8?B?S1hVQXJwZW9ITjJFT1ZoY1pBby9wR3pRZit6dHVOWFFFTEhYS0JKWWFNbkd3?=
 =?utf-8?B?dkVleDk1c05FRmdCT1BkN056K0VudUx2aW0zTDcvV0ZEWXZpOENEejNlOXpU?=
 =?utf-8?B?Zkwza0xPRGY3OWF4cWhXeGp6ckswU1R0WDVBZDFCZm5wZXIvWDNaMXhSYll0?=
 =?utf-8?B?cnp1K3FjZjB6T2JZMFpoekpLRzZFaXRSRHVxdUdPVVdNZld2V2wvQTdCbWp5?=
 =?utf-8?B?U1psNWtKRUhSTFc1Z01tZnVNWHJGNG1QZ3Q2NFhsd1FoKzQzQ3A5cURUSngr?=
 =?utf-8?B?OTVWaitzQWpIWEc1aUJ3VXVURFl0TlpUYi8vOGE2dHlSVlRMMTNYWEtaSDRk?=
 =?utf-8?B?WWQyUzZBRldtcHg4MVMvZURJOTlreHFFbThHcG1uenVCY1gwUFU1U0pTWXZV?=
 =?utf-8?B?bit6TGhuNk81d2dONC9DdW1zRDNOUVUrc2t5czZHSlVhV0VSQjcxT1BBZkQz?=
 =?utf-8?B?VStmeXNwUE12VFdoTVJuY2UySFlueml3Sk0ybndGM0ZGWGNpZ2kxTmMxS0pP?=
 =?utf-8?B?QUdDUlZUd0g4Wk83NFhTK2FzcTZRU3FES1kwN0ZBU3BkdkRYUlBHakZNajJk?=
 =?utf-8?B?Z3FNM2N2MEsyTUlNUjNmNWZHVlVwQm5WRTJEUmVJYjdDd3RRdk9BVUhXUFY5?=
 =?utf-8?B?Wi9MV2tZV2p6VTNuNmFlT1RsNzRZUytYYTh3T1F3dDI3eFo5QlJVRFpFRGdZ?=
 =?utf-8?B?UDljazdYbllvVUdZeW4yWVBSdTVyOTByays0NmxMcVdxRDUvU0pUbWxPYjla?=
 =?utf-8?B?c0tvQ2t1cktjbUlZbUlDRDJDakhlYjJZazNqMHVEZ3cwRGlhU0dqa1FkU2ZX?=
 =?utf-8?B?UmlBQUFMZ0xKbDdEQ3JOYzdhcjRxcGVvQW1saXFvb2VObVFqVFdWK3ppUEE1?=
 =?utf-8?B?dDQ3WGxIS21FdmtQZkJxa0wvb1NlQlRIQWVjbnptMUhaekp6YlNKa3paNTRJ?=
 =?utf-8?B?eFBsdHduS0prTHFIWGd1clZObkJjaVRXSDNqTWF1VXFEZWRtM1RMRytiUXo0?=
 =?utf-8?B?M054SUtsanBsNW92akcxR2ZzdDVsVlROWXVSbjRoWHAzWmY0bUJmdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XWSDg0tdQQw23uu/Ils7OFrm6ACpDINzoYWFzg5S910nvLyH7LqgE39OXwPqDNNysLSsTzyWv+KcmaTHialV8FfaA6U94ZamoDiWDb1dgjSHSRwYgKgCad64VV0hfU5vEXFO4Ov9gI2s/s2U0JJp46iwRT4csoQBj/RMQQOptAgQP0GLNz7QzV8SBUoT8KruZI3t78arfk+hrmZtmnajW8DNeBfXcEsWFz77nyrxQz4D5NXwXLEi4CYqpQddSeHI/ai3oH0K596fOIS0r7Gqh86hj7dA3pB16bQOR3paQZeSzyPkPx3SvYKFYzWghuO61wiTOZebSpdHhwlKJAlQnHNbeRVq2RS6eCE9PDmpdEDtMoOQ704ik7AP0Qq8F0K5dWc6hzDacpZqP07HMrMQ6iadidqgpoclheMS5Mv1VVxRrh18OBl+fsJtc4kHb37FtpmFlqXQ+y4hQwmCErp/z3YyIiJlT2cvR4VtMD/ET+bvtlt5WpS2HzwmAQn2sNv9EkxksOzoF+ynewKS9XB1ssyLWtKzBHIbpNqOWNJznaJ6KscFOcicoBR10g6drFgmnvZhybcKTtbYTVwAYDZ/c3Y3BotnIqJo5+XNmLLVAkk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae938631-0c13-4955-bf87-08de6b30df35
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6050.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 18:51:18.2570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5fQ/8qn9K/z7Dy8MXUz+b+iI8faKmZkOrA+TSigiEuvwQihaUyPqB0lWvta34O0j+NEFOYcddaQGUe4BtrTlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602130145
X-Proofpoint-ORIG-GUID: AL8-hmiO7pF8pCz9NiTUNMTK0PSJtq24
X-Authority-Analysis: v=2.4 cv=Qchrf8bv c=1 sm=1 tr=0 ts=698f72ab b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=hSkVLCK3AAAA:8
 a=yPCof4ZbAAAA:8 a=WGkrJWcK1gWZz9fcVq0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cQPPKAXgyycSBL8etih5:22 cc=ntf awl=host:13697
X-Proofpoint-GUID: AL8-hmiO7pF8pCz9NiTUNMTK0PSJtq24
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDE0NSBTYWx0ZWRfX3czxum17gfof
 VCistCGHZiSQySmU+dQYKdChxdSLHDe4vbKmc9mLfzV9jSnzurnKs9xFU0oPdKQ3T2E5tRsZTo/
 XzGXrm5xZD+Agx82ufd/Z9EF1QDNlE24O8rWpAdBdNVWyJvoYp3hgC3/laFI4HbA7y0NQVorURf
 7mDv6kIf1qpTAb6lyAsIKbcnUkSJENaz4BvV/f9p68KX6ritG4TQW2+PnbARwc0SR9MYaHMUCck
 tFDNF7V7oPXeDbVmgCsMGeCf5/iv7cV/RgktYgtNogm/XxnkaXhy9u0hAv9MJVedZLrzcQrq2vc
 LoEFia2nn8xevl0rzlifgpa0t9x4TjhdDhXn8C9GoghK1ueId12t7gkuREtxhtSTW0bC6K1teg/
 euVo16AJx6s/qPpHJe0YFi0r1PYNPbDgyJxvbSgGpey4rMJV/dDrfLpj8Qf5Hp7/onlK77UDr5u
 H17h4hcDROGWQ+QgiHVouA3cPjZVQJVzJS5uwuEI=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258663-lists,netdev=lfdr.de];
	SUBJECT_HAS_QUESTION(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerd.rausch@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:mid,oracle.com:dkim,oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5efae91f60932839f0a5];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7690F13905F
X-Rspamd-Action: no action

Hi,

On 2026-02-13 09:26, Eric Dumazet wrote:
> On Fri, Feb 13, 2026 at 1:15 PM syzbot
> <syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com> wrote:
>>
>>
[...]
>> ============================================
>> WARNING: possible recursive locking detected
>> syzkaller #0 Not tainted
>> --------------------------------------------
>> kworker/u8:6/2985 is trying to acquire lock:
>> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
>> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
>>
>> but task is already holding lock:
>> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
>> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sock_set_cork+0x2c/0x2e0 net/ipv4/tcp.c:3694
>>
[...]
>>   lock_sock_nested+0x48/0x100 net/core/sock.c:3780
>>   lock_sock include/net/sock.h:1709 [inline]
>>   inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
>>   rds_tcp_get_peer_sport net/rds/tcp_listen.c:70 [inline]
>>   rds_tcp_conn_slots_available+0x288/0x470 net/rds/tcp_listen.c:149
>>   rds_recv_hs_exthdrs+0x60f/0x7c0 net/rds/recv.c:265
>>   rds_recv_incoming+0x9f6/0x12d0 net/rds/recv.c:389
>>   rds_tcp_data_recv+0x7f1/0xa40 net/rds/tcp_recv.c:243
>>   __tcp_read_sock+0x196/0x970 net/ipv4/tcp.c:1702
>>   rds_tcp_read_sock net/rds/tcp_recv.c:277 [inline]
>>   rds_tcp_data_ready+0x369/0x950 net/rds/tcp_recv.c:331
>>   tcp_rcv_established+0x19e9/0x2670 net/ipv4/tcp_input.c:6675
>>   tcp_v6_do_rcv+0x8eb/0x1ba0 net/ipv6/tcp_ipv6.c:1609
>>   sk_backlog_rcv include/net/sock.h:1185 [inline]
>>   __release_sock+0x1b8/0x3a0 net/core/sock.c:3213
> 
[...]
> Gerd, please take a look, thanks.
> 
> commit 9d27a0fb122f19b6d01d02f4b4f429ca28811ace
> Author: Gerd Rausch <gerd.rausch@oracle.com>
> Date:   Mon Feb 2 22:57:23 2026 -0700
> 
>      net/rds: Trigger rds_send_ping() more than once

Syzbot is right:

inet_getname() acquires a lock_sock() that was already held
as __release_sock() is about to give it up, but before
doing so, handles the backlog receives & callbacks.

Just need to figure out a way to obtain the peer's port number,
without ending up in such a recursive lock scenario.

Thanks for forwarding this,

   Gerd


