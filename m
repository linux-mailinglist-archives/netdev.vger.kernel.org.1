Return-Path: <netdev+bounces-259108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGt9NeehlGlcGAIAu9opvQ
	(envelope-from <netdev+bounces-259108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:14:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6EF14E8A5
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DCBB300F5E0
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE23536F406;
	Tue, 17 Feb 2026 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jb3OkCsA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HdJukifB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B18936D50B;
	Tue, 17 Feb 2026 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771348434; cv=fail; b=Ihv/UZ/KGqGgofIyHukKx8ZxPevgK+Vo34XejQP36Tqs6HRDtRb0zuzHSCfI43tKuz/8G73sq3Pj+MMRcMGZalPPU0LBLIEXd1iiipSE3dxtHmpVrOr6sSnVs/Oshi6GXDt3qIYGBH9CuMR8Q83GNUX8tpYVXjWnpnGyzlAbyUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771348434; c=relaxed/simple;
	bh=hUiz9zZUuH8gepJDSG2xXZjM6Lq/qLfvWyOGCiayO1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u+tzpYY/i2wd2ww/UXJ26ADuACOlCrbh7To77sbV/PAVvrUEcFyRNGFX5TP1rfPkJelzapw23HwDBxna7pUpB17y24eUMo5Y5uASivZaKWyDKR0Vk9K1KVDNpZeRybTzIyX+VEwKxlRt4WLRkU8jK5Qf5dPVEXmVL31ArBDz3/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jb3OkCsA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HdJukifB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HGNQLA3789052;
	Tue, 17 Feb 2026 17:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UMMxMM6uod3XvdM2CFjFGyzY8WPKMvwIH2xt2h2970E=; b=
	Jb3OkCsAsw5foMHdJEsG95hlEoFkYAqhQ1zgtavl46X3iubBnm/zxQlkHUsFAPCR
	lecASUJwbrCSw728tdn7BNciC/cacv2rXwVo67RjVvRQwK2OBQmYYdvRGdKSvtFZ
	Uzy2WXAmYbLg2XfaRckD5wMw6HG7JfRkqKNt3er5j0ann0S07LrA/0U55usIEnOc
	GatS/yXD2qEIn1M7vk5ywiIzLhi0SBIhFoSeqfb/GwLe3jHQLCaJCss2UQeyNU2W
	PMmmQhi3clH7SFFFSfYrqC/sWBWSYyjX7AG+yuZ42L0dMgVMhxhh4X1ofqfC3yg0
	MPv+CjTQE/wBfhO4q/FHkA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj5r4216-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 17:13:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61HGDpFf005405;
	Tue, 17 Feb 2026 17:13:42 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb22rmnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 17:13:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/bbo57t9rFaaKRBMEdsAAX14JUtZ5DcQcGMBRtOjLblMfyL0Pc3649Klbm8KLjmqPzv+pfALLhGHjV6XhUJJ4BeoGef8QH+IQiCK5dU5l+lnL54zPT+9xJIVuW5bCg2TLjx9e8QQab8X/IueP/E5iFONHRtfsKmlg4AYBOTL4gp+bFNxNAgMeJHPNPTDc1hOWOf1XheBFrmyrVVMSjvikEyDHAdGIlyTtsRfDaS1SwV3uOBM3igLz+VyHOLABE9OG3uOq6KUNULIDdoZhM22IaC1eDfu382YMskRl9wSTGcUR2cUnjvxjAydIHai/vjRc305HPoZxUoYKjqw2wC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMMxMM6uod3XvdM2CFjFGyzY8WPKMvwIH2xt2h2970E=;
 b=EbNyevcNQYY1O3a8zn0JvacjLdxP/iv2MVxLxqCxTBvQ9DDqLzFUxlya8HvpWxGkynZnfOWv5hU8Ew2erxbrmJGjbNjB50Gf2pS9nSGJfox5thTIscph8bsJdmQh/1mx+MUOc6vVAswD5yMJq661n/oED7m0shc5OKvE6oz7X2XRttNVy2a1b+O2Auyzq5ndo2aQscs5ZkmPsyG8K9rH3cnAzbLf6Sf6vA9QEALgsAHr6DE0G7NHiwmBs6pUmWihr1eei9xrZZ0pcSLlnzsCaxSvS54GAT28RJpPOH5rtMpLaOThqHXnag6Sdu0XIwvmC79EkwvsslshWIqwodppxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMMxMM6uod3XvdM2CFjFGyzY8WPKMvwIH2xt2h2970E=;
 b=HdJukifBVx3PeaKSeCU7ca9f3X9oJ8qjqY11eWrMlCW0BqB/qs/aL/ztMsAcP8mWUo/3/PtCQXc/nbjLLmqFblRRYLfqpCfsjILZzYybHNS2qCcW5IqwaVyBbx1ypdXzDvRsrcSZwdhZhOZTRKAQMcb/Gtlt5od4rzoS7UPzf60=
Received: from IA1PR10MB6050.namprd10.prod.outlook.com (2603:10b6:208:38a::16)
 by PH0PR10MB4534.namprd10.prod.outlook.com (2603:10b6:510:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 17:13:34 +0000
Received: from IA1PR10MB6050.namprd10.prod.outlook.com
 ([fe80::645a:f184:3a35:ef9f]) by IA1PR10MB6050.namprd10.prod.outlook.com
 ([fe80::645a:f184:3a35:ef9f%4]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 17:13:34 +0000
Message-ID: <4cd4099b-328d-45eb-990d-793df79cd639@oracle.com>
Date: Tue, 17 Feb 2026 09:13:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] possible deadlock in inet6_getname
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>,
        Eric Dumazet <edumazet@google.com>,
        syzbot <syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <698f15e6.a70a0220.2c38d7.00c1.GAE@google.com>
 <CANn89i+mVCLW2g1+tnbK8k9E0AkEuX7AZ+2LbO1_s2L=Gxaaeg@mail.gmail.com>
 <50e88063-14fb-4912-a65d-172a85def1ee@oracle.com>
 <c57f2565-a6b2-45dd-8307-871a02ae1a7a@suse.de>
 <db06aa20-ca31-4b66-9a53-e4305974d1f5@oracle.com>
 <1c5ce96c-3b01-44e0-8dc9-5c54e504cb95@suse.de>
From: Gerd Rausch <gerd.rausch@oracle.com>
In-Reply-To: <1c5ce96c-3b01-44e0-8dc9-5c54e504cb95@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To IA1PR10MB6050.namprd10.prod.outlook.com
 (2603:10b6:208:38a::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB6050:EE_|PH0PR10MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c55ded-7045-4950-ecfe-08de6e47e1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVc2WlVGUENXeHdhaHFCUmd4M2thL3AxMVlzcUUxaTNkM3ZSU05HT1NOWUFK?=
 =?utf-8?B?UkZxU1RhZlZSRTZHMmhUVm5HK2RjOG85eG1oY3R4Q0l5dWxweVFlVktPemlJ?=
 =?utf-8?B?blhtWlpNb2ZQMGF1cHBmTXVZeXJxc0FUUGtjSTBhMWIyaFZNTGk5V2FoZkU0?=
 =?utf-8?B?YWJMVFRmeE5yNWVzOFJQOVpPL1J4ekpvYXhHcVdWdWVWN3MvaDdYNDRVVGFn?=
 =?utf-8?B?UHE5U3U4c0xPOTVzbnVIQUZmeDYvNmpKaHRacHlUSHF5U2hWa2FQR0d5Vlhv?=
 =?utf-8?B?cUU3VkdBMC8rdlFqLzV3dWx6TTNJOFp5NnhpRHNTeVVGbXVnTS96VHBVaTdu?=
 =?utf-8?B?MktiMXlKWWlSaDI2V2svckp1QXJxcmpicHhuWmRWUEtibzBNZ0hTUnhkbjk5?=
 =?utf-8?B?SlBLUXlPeFVVeDV2elYrVTlxUnRtK1VwOEdZRmw2R0dLQU92amxXVmxMYWEy?=
 =?utf-8?B?blFMUUFVQzY5cXZRZ1lMMUpSRU5UNFNMQVJycWxXKzlQdlJBK0QwYkNMV2ZF?=
 =?utf-8?B?aGZpNEJjRW1oT3hqMmRVOUhVRnpSakdPNXJIaEpuUUo5NmprVDRFcVpvSklw?=
 =?utf-8?B?VGY2K21MYm1od200M0RkYi9VRFdIK3dJZVIxQXBHaXc2UEFGbFFydlZPbll6?=
 =?utf-8?B?cUJHdHJSdlM0Mlh6VThyeE5yYi9sazRWUFpjV1RFL3BsTXdmOWgzWm5BRTBs?=
 =?utf-8?B?OEJzN0pFR3pxOTVjWTZYV05NOFBBTU9UamNWZENZRTZnOVE0MkNBd3czVTky?=
 =?utf-8?B?Q0hyZ2ltamhieUxWK3ljeFhFUFlQSWtBeWdEbTRBWnNyTVZKcTJmczEwU1Zo?=
 =?utf-8?B?OWpaR2d4NEkwbDdNMVBvS3B2bitEdHdEQytEUitFY3lFZnVZRmt4UmZyUDFV?=
 =?utf-8?B?QUZELzNlNXVxK2l3ZHdqV041Skltd05VdW05eXJvZnN6Mm1CRzVYL1UrcHV3?=
 =?utf-8?B?VzhycmczSGpZTUpOcmVoQjlJTlVZM1BWN0htS1ZaUE5tVU9sOExVRTVKYUxY?=
 =?utf-8?B?WGVHSDdwUU9qbHZPakFMWXpwYU5yclhMRjNmOVl6ZER0NmxKM21mOFplMkZj?=
 =?utf-8?B?a05CWTNlQXpEWnE0NlU2ZFdWbWd0VHJZZElBT1hvQ2JiNkRlN1dEQWVkSnNo?=
 =?utf-8?B?anpkWnlLOXdkdWYyVVZyYVZya0FibUp1eExZT3FJNTZRNGgyem55Q0ZxTjM1?=
 =?utf-8?B?UUszcWJYck9FWGxxRWVEYUI5UXZUTUxlNG12Y1ZoQmd6VEZnTmM2bmozVG9w?=
 =?utf-8?B?Nlc1dm1zMkhXZHlUbjlnTElvNWZueStUNEJMNWdHYkduRWtIM0Z4dTVKbU5z?=
 =?utf-8?B?NlVDU0xpNUFML1o1aTNRQjNtSEFXcXZRRi9BM0NOcFhhYWJNaE5SZjZOazQ2?=
 =?utf-8?B?M1VJcGd1Wms4L1FRNkNUMXJiMHF1YktianlJYnNKYXg2SE10ZUVnampoTzJK?=
 =?utf-8?B?WXBFNkxNS0h1Ym1GVXVxUTIzRWRDNGRuWW92MEdBZjYvWC82RWMwUG81ck9m?=
 =?utf-8?B?WEVucWZZVFdRb1VKaWpLdUxSUHNSWDkrV3M1MVkremNCc1BFWXRocm0wU2l0?=
 =?utf-8?B?R3YrZjF1TlZyaWZoNGhxWm04T2FGZE1FQWpqMmkvV2ZQdXhUUkFoSS9KUnlZ?=
 =?utf-8?B?LzJvbitUdGZRSUo0dDQ3K3IxVWt3dGdJOWV6MmpYOW1ZbFZVaG9pRkMvdVdG?=
 =?utf-8?B?Y3lCSlZVQVhSZmg1SzlNQnFibnhpK2UvdElCREk1RWRWM3FZc1NBUE4xT3BO?=
 =?utf-8?B?NnNaYUNOTWZ3RTFsckxKS1VQSysvM200ay9oU09wQTh5VGF2MkhtTGphZVRv?=
 =?utf-8?B?czhSTnVzQW9KVVl4b291OTNHTTh5N09LT1VTdEtHUE9ZN0hza253dHZldldZ?=
 =?utf-8?B?bmhsd2ZUanVWK3lDSjlQK2Z4WXhXWldudXZHVmwvN2FhbXZ3MlgramlGbCto?=
 =?utf-8?B?ZGV1NmtpSjdvd0IzQjNZbzNVK2UxTVlWeG1kQk9SWWFLSVBJOVp3Y2JqR2E0?=
 =?utf-8?B?bzhGMW1OM1dOai96TE5KSWhnWXdLUEhuYk5FemQzL1NoeHpaV2dqREZMYWt4?=
 =?utf-8?B?NHJJeWxMc2phOWMwN2hXL0p5Z1BCUkV6a3JFZ0VFTWVkbHIvNEt6aWpsdkdy?=
 =?utf-8?Q?/pbU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB6050.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2h0cmFqUmJhTkl0TURLczB0TjQ2eFh6b1ltN3haYnh2czAvZ24wcG1meXAw?=
 =?utf-8?B?cjJzNmxKZ3cxSGtLUmVCUTdLbkdNalErckNRRE9oM0NqeXJmbTZIRVRZVXZP?=
 =?utf-8?B?elJJTTZaRTZCOEYxV0FqbTZPNnJkbitkRXlSMVNPZDdKUmxUTW5xd1RPK0VC?=
 =?utf-8?B?WU9kVmJKcGNZQUl5V3NQSVJJbXZZWWNGUjFwaUZrWHRtRGgzTldIc040cWln?=
 =?utf-8?B?aGlJaVZJRkdjY25uYzdrVWJuMlhuZTlOdDh0SUhmanJ4RVUwVU5NdXRMbHlS?=
 =?utf-8?B?WlNWcU94K2lWU0tDd3lDN3M3QXMzYm5vbmplSGZVTEZMemUwZXFXNDZTQjdv?=
 =?utf-8?B?MDJPbEdrL1BvWHhZMm9SdTYyRjdlTVFHWmJHU1pucXJWaVBLdmhsb0Vicmhr?=
 =?utf-8?B?UTNES0g5d2lZOVdZdktXekEwRnZWZlFrU2haTFMya0FjYWFmTE1wZ0IvZytz?=
 =?utf-8?B?c3Nqc2I3MWZWaGVPM2hPMDkzenUvYnl3NmYxUlNWRHc0aWxVRDdrN0t0dTlI?=
 =?utf-8?B?QzZCWUZXbkVRcTFhbkluTjUvWnBWOGpHcndsQkl5OHJ2OW1YTGlvREsxSUdH?=
 =?utf-8?B?R3YxMTN2OGYvdytiaDhLa2tvblVDRjZvYk1Md0dkK0tLaHFEMllxaHhteENU?=
 =?utf-8?B?T2RQRmhLVmNpLzdsaXoyQTY1eUlSbkg1VUg5aEpoZm5oZVZ3cEt3cHZmdHBF?=
 =?utf-8?B?SDJ2RGEzcFYwdEMrbkNKbFJPOTFUU0Z1Z3dHZlNsbk5PSUJLSnp5N05jcnN1?=
 =?utf-8?B?K3BUOW54cHZETkxOeXZURmlLeXk0N0h4V0R3VGlLVzZBd0dWOHNINWpVOURk?=
 =?utf-8?B?a05NR0VmaDlEdHU4UFZCYTFOVS9iZ1VCc2dSUDBZK2pLa0FUbjBtQXE1M2JZ?=
 =?utf-8?B?S0VrZUJEWUxnWDRudmlUck1kczY4Zm1JV2FzeVM5MjFmMnUvQjRlVURRUE4z?=
 =?utf-8?B?cm5mYmF0aGtsVy8wRnZvTlBwYWtxckRBQ2dUaVNNZVlBT2dHTkxCQWQxVjFL?=
 =?utf-8?B?a0xjU3NrYnZyclpic2ZjM1haK3pzZHVBalpBTmJNaFZYNFZyTytpYUYrTnYy?=
 =?utf-8?B?dGtoUXZPUWl2b1dlUUlSVWNlcWdKSWJOMy92eFZxZURKb3l1MEx3RjNMZlp2?=
 =?utf-8?B?OFRKR1h4RHZIdDFuRnVLZDdLR0NYUXhZa1I4bURDd09kb2VRa0RacEV1T25z?=
 =?utf-8?B?MjNEWXJxYnJzVlRyTlB3S1NUQXVDanpvakIvQlpBV2prcnovdkZaa1dLTndF?=
 =?utf-8?B?VGloUWZLNzliYXpBbjMyeVcrSEhxMGxLd3VWcVdmYUNIRkk0UXQ1U3RUNWVN?=
 =?utf-8?B?OXpqTElBY01uakd6RmVCRjZQYkNtOTVSZU01Q29sWmwyVEsvMXFvbTJjNXFq?=
 =?utf-8?B?NUU4WFYxUHFNZFBmR1RRMXNtYU9BUTNwWVkySHF1UDFDaXpwb3BRRy91TTNK?=
 =?utf-8?B?QWQyK1liamF0RW5xM3VDdHpoMU9GQzdYNjY0WG4yOWZHKzh2TFplUHI0RG56?=
 =?utf-8?B?TmpOTWh0QnF6M2RWcW81c3UyZE5IUzhMZmZmYXQycitkL1lmakRyNkJjVHox?=
 =?utf-8?B?K1J0aFdpSThLVnl1SjJBR3d1RGxjNU1rRXBiOXVnVjVvUkpEbmVyVTI3dXAw?=
 =?utf-8?B?ZTBFRmFiMS81ejNrMDc0ZTJkYVRnMEF6OVpCVkFBT0xqUVRjY3ZnRS83UHFq?=
 =?utf-8?B?UDd4Y3hXeTBrLzNER0o2c241Qkt5VTh0ZFJoTGRlKzNkQWUwZXdhcjZZMGxG?=
 =?utf-8?B?TG93QjBFUzIyUGdhdEoxcURteXNxNHlrVm5nY1MzY0NvSHQ4NmZwNDVIdno1?=
 =?utf-8?B?V0MzTzVDaEZ6OFpHOVJXaW9jREJqcFNOOTNGMFlBY0taUjltMStsemU2bldS?=
 =?utf-8?B?TTdRRWJUOHBubGoxaXhvVWlrUlNMVUlLTlZpZTFRVFkzMVhBbE1xZlg5S3Fu?=
 =?utf-8?B?Wk1mUk5kbFVaSE9XMUh1N1dMc29XaEsyamdTNjBna09CMTQ5NHFDcUpJS0Js?=
 =?utf-8?B?OVNrYjRDWjZ3eFA5MmNXZlh5bTJnNzhLZUdFQXZGanVaMEV2VE9NQVJkL3ZK?=
 =?utf-8?B?Y3I5VjhxS2s3eS9SaGd4aEp2UDk1SDZjQ21wbjVhUEQ3VDBNWkV1VDRqVjUy?=
 =?utf-8?B?ZHhSNU0wUjU3OWtVOTBuT0o2dzA5MFVObm93VjhlT2YvUjVycVFzK2tVQWQv?=
 =?utf-8?B?RW9NM3FpQStyem1PWjA3WFczMkdmQWFxZmpPLzRJTWlVNVA4WmF4eTV5ai9W?=
 =?utf-8?B?UFNEVEZWMGpiTy9nN3l1a04zYWlSSzdaNmJ1TEMwREY5eTlXRHBJZDNvU1R1?=
 =?utf-8?B?WC94SEZPaDNMZGZCaUIwRWlubDFmUERkM1FxY1poWDZheFB5Z1J3dz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dLiPcJW54THlrHGr6zefsGkciQi1EQRSTjIn6rn2oVZe+pNqHt8Lfzd1TN2VGiTWGIu1rVH60F11Buhg3hGrej/X2z+0LNLt/sQvAgQAizEl5vX35ixvJIrjgWAd4AhPi/Po8ZdgVc3g404w7Wty597VQ7aoQEbB6mFKiZlhba7U925nh9sU43NHKuahxbeeFCtUil16prjYz0jIacLG4BEActv3mjd6TjA4u5zxacEN6YNkSUwtoqK3upxUmlpOMm0MP5UAi5ImyAh1pAt0juPh2cmdJIT2CVaxsR7rOI2sArkJ7Ob8wgogq/32OTkLfCpf1m6EIrPn4dU2gF2xE9CGU6e3FdLynH9Hu08AmKW93YSxABtHHLleHKbDt4Kh1BWQBLO9+yyVXB6gApgCyMnRlPaUJE94nVAGuuOElD0GR9eFtpGJmY2Ny5ffxQGP9k1sVX6MklWUAxK8o4iIUB2IROWXosPpC7p8yZi+rf+VIVhDgM47n3joZ8flQu9++c7vuURxHpS7Kwsngfcer4qR4VqXB13VKZIlZlJbEA8BGBwlimKaw6sY1FVOP6iJB2ytlsGOXPfvdgMfWTBgoLpgDnG3pe+Q1hGTyXFicO0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c55ded-7045-4950-ecfe-08de6e47e1c6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6050.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:13:34.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22auhSOiBxDCxyyNyfY35dEnXXIxK6dWBRlDwpwtcFgmN5+SfqroRprM/raH1FrVjVl2bJwc9vda+BCzrl+dIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4534
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602170140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE0MCBTYWx0ZWRfX0UVGqMsdR7Pm
 EbcG6i2Ga92NFU3GIrCTiujGZQDyK4mSnc6aHup/Z6hwR64PCaV6JJ1Ng+qFsX9G9BfWWeN07Yr
 mW0LOjItZDPmLEoYvaUeEjCpgeLxC6h08HnkbNXHzQ5y8SeiOg5iqOhm2mR/ADbycvBxZskHzIx
 E5yEG69AcFWfiWLlVlRexn8y9olZrQ+pJwM97wPx0L0Q4xjNcbuH1ly2SpurBKmCQXIOKz3Q3V4
 GtGHeDx1M/Te4624Enj1LJKe85o0Zx+94zY50adr0Otmmkom791xcOBKrBsPCoLckHur3cAj3ze
 /gwquIECceCU0TWB/aG1NcFev51/3rscx0zTHjddqEuuA9yZFDdrHJ7lmVGtjgOhRvUmvMNKbvm
 p+ZxOa3Nt4B3/j2cqX44sy9idoB93OjLsI3gVkssbGe8nnXMSA3JLgGe8of1TzbEP54thgVKrqy
 ghBiGNkcB7AoB8zZobQ==
X-Authority-Analysis: v=2.4 cv=Saz6t/Ru c=1 sm=1 tr=0 ts=6994a1c6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=fLm-sxVCmBHJfiO06YgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YYuTFHdL4uqQp11OZEKkAx38B2gEd0yi
X-Proofpoint-ORIG-GUID: YYuTFHdL4uqQp11OZEKkAx38B2gEd0yi
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259108-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerd.rausch@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5efae91f60932839f0a5];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5A6EF14E8A5
X-Rspamd-Action: no action

Hi,

On 2026-02-17 09:03, Fernando Fernandez Mancera wrote:
>> rds_tcp_conn_slots_available() can also be called from rds_conn_shutdown(),
>> where no "rds_tcp.ko" backend specific lock is held.
>>
> 
> 
> AFAICS, from rds_conn_shutdown() path rds_tcp_conn_slots_available() is called with fan-out argument as false. Therefore, no need to get the peer source port.
> 
> I think that should be fine.
> 

True, but IMHO subtle and error-prone.

If someone were to change the code to pass in "fan_out == true"
from a context not already holding a socket lock,
would they remember to change rds_tcp_conn_slots_available()
to acquire that lock?

Thanks,

   Gerd


