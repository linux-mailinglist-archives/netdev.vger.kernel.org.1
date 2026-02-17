Return-Path: <netdev+bounces-259112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GTQNoKllGnTGAIAu9opvQ
	(envelope-from <netdev+bounces-259112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:29:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4201B14E9BA
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970743042B75
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7468836E49E;
	Tue, 17 Feb 2026 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DfdhoLgp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nwg+ujqV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30AF36F420;
	Tue, 17 Feb 2026 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349326; cv=fail; b=u4RH8pCo73IgwYnrtTLeFkHGhLKUHcTMWdF13HZFJw124NN+OJfq9sXpUh9SnpwHL1P7fgoLP7VWc4vbM4LT88x45JdnKc8sqM3FNGkRXN9MNEq7b1zetnFxgNas0I2vPYI+ubDxx+73XoXNsFW6pUKLUmcGo3Yi1zsnyy/rMD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349326; c=relaxed/simple;
	bh=qIGGJ5Mpto3gBvXIgx2zGfIDCJ9oPzXQ2EuWx5A937o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ORk5P6Jf8ysweCBrVZo+z+kqjf8FSKzahOtDb0D5OE84PbIn1H7ArCSVBj3GsTpZRCaPyejZDepSlNGYj9Gsp/MKIZVs9629G84/KQX2qv4BPbeqOEmqla7321FPknXKY3PsW17930rT1D+9C9SK8cpggSl99rwhEHahwVi9uPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DfdhoLgp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nwg+ujqV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HGNXdK251288;
	Tue, 17 Feb 2026 17:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mMx1HvOGiLJbZJf2/HLGbAVhwg72JpnWd6Yh2fhDM5M=; b=
	DfdhoLgpNc21ntlL6QZFrLMmwl/nnqLmFFitCT9uqUpTngMPiDRC4Ly6Q9d9gDEb
	1PoqmxVA3/AX5meb2X1WhwkZpS06VR1hZvfWcFS2NhwV3485ElMyl+ZnGGNoZhEh
	r1oX2tynEMXGDA5YAog8ky0arvlVHEsuW5ADCjxrpO7WMJYK+YzosWSUgvxMNGLN
	O4vI2i3bu59h75jhaE+98Cxf2Gc1E2ytGJCf+S6CraS7hIEI3hDwQPcZVicyK3OI
	dnhCNh3lU11fdp4Dt6JmwGXqdqVhTj428ZqjUpGwivXKnHG3bYriNWv21RJ2Ryuh
	Vw+K7vwyaYDXxiA/kQkaTw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0wm200-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 17:28:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61HGDokJ005346;
	Tue, 17 Feb 2026 17:28:33 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb22scfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 17:28:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qd3ayZ5TtVl6aN2E7CYBwbenbHxIKfz0aa9qZQ9svO3zi574ntkegwJymAntubwvBMQYcb9ffN9zOsor+AOu190vyJ6BUuhotLobKNRRR0jqMNfKZTXHUPM5+VSwyLn5cPasqvCSl/F0WL47USEA09m4cYuXo0kolnWMuyZ9lxtDqSIYZkc3XpyCs94+hSJW6H7kmtAnN+kZwufjMz4fmuD1C6KBxIE9Op4sIQzWAab/hGFsOU+ljZh/UAhZ0xxApPcWmMKmSjOjog4mx9xP4XaN3GMtvEWG5f4INqMxhWKZkwuH50D7OeAPwtpeKLzt8GGsRwR6yw98jWZUeAeqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMx1HvOGiLJbZJf2/HLGbAVhwg72JpnWd6Yh2fhDM5M=;
 b=fM86neqPgQThuYxg2w35KAyeNdnZ0BmlKBRzrH13+Xpd8Zk0uuHAE8OHATTU9JUp6R/ZXy7Vb1ErCn+Ir5YwDN0ymL8cIyLRDJZj65Ma4PeVPK13Teh/zAPSeyEHoB73yC/Db0iexSfcAeG8Bpz5Ug3I7RR17tBKiCxabCljpPrQwaAN0Zl7OWdfdPxJQstCnLQfr++B0Vd+UDqQwWxj1+p5dJQmQYCw1kGyNjF6EamJ9ObwyAO+txkaDnN0MacsIkCAdhx/k+JtElOzIPLH5j4TLnIozCMR5JX+mPM8PwYqMxE6JBYEevIVd8BMJRInHwwGzCL7M44bZd3NJIUluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMx1HvOGiLJbZJf2/HLGbAVhwg72JpnWd6Yh2fhDM5M=;
 b=nwg+ujqVCgsuDWeohDGENBOZNTY3JU2rhvb5F8PoE1Tb2VjhU9eDC7tBLGwJ/DrnZj+CC/z4tXdCgLJGU9YzWJgSV6x/4rT4KkM8jC1+l4I56Dq1IWxp1c4Je+6mc8+PrqwSr0MAQit6wvF2gmL0fBo1xcBLnpUOLKfcdml1UCA=
Received: from IA1PR10MB6050.namprd10.prod.outlook.com (2603:10b6:208:38a::16)
 by SN4PR10MB5605.namprd10.prod.outlook.com (2603:10b6:806:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 17:28:27 +0000
Received: from IA1PR10MB6050.namprd10.prod.outlook.com
 ([fe80::645a:f184:3a35:ef9f]) by IA1PR10MB6050.namprd10.prod.outlook.com
 ([fe80::645a:f184:3a35:ef9f%4]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 17:28:25 +0000
Message-ID: <4acdfdf8-a69c-4020-8a8c-2edccd482a6b@oracle.com>
Date: Tue, 17 Feb 2026 09:28:22 -0800
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
 <4cd4099b-328d-45eb-990d-793df79cd639@oracle.com>
 <2677c7cb-efb7-4f19-8000-4ed127f33847@suse.de>
From: Gerd Rausch <gerd.rausch@oracle.com>
In-Reply-To: <2677c7cb-efb7-4f19-8000-4ed127f33847@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::18) To IA1PR10MB6050.namprd10.prod.outlook.com
 (2603:10b6:208:38a::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB6050:EE_|SN4PR10MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4a0909-e6c6-4392-04ad-08de6e49f4a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVZTQ3VMMDR3cHhFbU5VSDBpcUltcysxR291aWNNU3pUUHdibVJRNUlhVm5X?=
 =?utf-8?B?WlBWNVJQOXJwdkxxQmhwa2FQMitKM21HNmFKR0ppV1Z5OW9KbmpOTVJDWW5K?=
 =?utf-8?B?RGRBL1NDcytxNW1RMHlaLzdsbHAwY2JsbHZUbHRSYVFqbUcxVmpUUTdDZzVB?=
 =?utf-8?B?Y2JHU3J1UG5GSk5mai9YZ1NlbCtGa0NDbWg1VE5NL1E1M2tzS2JqQ1doMnJF?=
 =?utf-8?B?TEZ2Z0pjVjBmM08vejFUMnkzS3hENk1ZMzhrdDlVOTh1dkhSL0VlS29wak5I?=
 =?utf-8?B?RHlxOU1qbkYybVl3MnB1TlQyelduUlQ2eGgwWGRNUEh0NXZvSmt1SnRCcVNm?=
 =?utf-8?B?NURVZGxIZ2lzU1d5cEN0L1M4OVVnd2NwblJVTnVpK0pkcG5OWW9NU21TdHJr?=
 =?utf-8?B?TWlVRkJCeU85WFhnUUR4Unp2OXV5b3VzT0ZHZE1sK3AxQjVDd3QrSWd0b2Fl?=
 =?utf-8?B?Q1RzcWFoTHhXMnp4ZGxaTjZacTRJU3VoT2R5MnZaTGJBUzBVNThMZ1FpdURj?=
 =?utf-8?B?UytwMUlqNGx4WEZ4LzcvWC9nMDRnVkZVK0QyRHBmMTViY0JPN2h4NjJjYWQ3?=
 =?utf-8?B?YkMrQkdUM0ZtckFucmZmUmJyKy9ieXVaWTBidWI1UDVQVC9oVXByblBKT0w1?=
 =?utf-8?B?bGM1bkNwaTJaSEl2L1RWcExvWmtoWnBhNlBaSTREZlBoWHBUK244alBDQk5Q?=
 =?utf-8?B?S0NDSFZQL2JrSmpvM1VuT252b3ZBNkxOWXQzR2RGN0VmMndUVVlhR3dKQUtz?=
 =?utf-8?B?b2hmTVpyZ0hTSDRmSWViZldkZGdYWlBIL2VBSWdlaFRWY2c5VGlsSGJsZHJE?=
 =?utf-8?B?VnBNK3Q1MGRsRjZlMm5SbnlNcEwvWTdIb1RwWXlUQzNlTmlNWlpnS1pMTThv?=
 =?utf-8?B?TUhPVmhGODBBSW55dzJQWTdQSlp3YkE0b09ZUzk1U3oyRnprMDlJTlhMem5v?=
 =?utf-8?B?cDAvT21NSWZOa1VwckZBUG9wdmRuVDFRZ2wwSzJ1VG94NXFEKzVlS0pTVkh1?=
 =?utf-8?B?VXp6b0NFMmRPcDQ4dHgvdVdmWXMySHBuK1RyOGJqVFBsbXBDWU93U0VBTUlC?=
 =?utf-8?B?R2s2VDV6OTJHeURkdndEWWdBSjJtVCtwd0ZGZW42a2wzbERwUTVSbEdlZkRq?=
 =?utf-8?B?RUNxQ1hCQTZPTkU3REgrNDg4TGNxdlFsdkY0cGhYSFN3blFFVXJvMUo3Mm81?=
 =?utf-8?B?MzdiZkllQ0daMUhEQ04zK0l6VDZ4bXY3bDArcnZVMVVmeVFlNm1MMFNXY3Zk?=
 =?utf-8?B?K0traG9xV3c4N2UzbW9MeHljOFBhOGdLQUE2cTZRYTNiMjJXRzZMeVlUNDVH?=
 =?utf-8?B?MG5jaVFCUVlxa3dISmVLMFJzanArdE45K3JXQjZNQ2dTYUhCQkE1VUMxNXFK?=
 =?utf-8?B?MUZSWmdqTldSbkw2aC95eTdCUGt5UGpFd1FvbDVsVGxFY3FqZjU0TDV4UndR?=
 =?utf-8?B?d2NlaVBpNzU3dnVVT01aUTYxblhkTEFmQXBOeU1QNmwwNUNaSi9wZ3k0TmV0?=
 =?utf-8?B?cnQreW5NRXRWWHNoZXczZmprSnNEU0VZMDBlTnRMd1JxNDJDTXMyVjZuelZ5?=
 =?utf-8?B?cjVLTnN4L1hQcmU1TS9NSUpCYnQxRGsyYS9KdG5WTkhURE81Z3V5VldqV2Vn?=
 =?utf-8?B?NEpOMG96dWFGTElMSzd6ZDY5cVB5NTVST2RJVk5hZk5jVlhTaFVYNWhweXBj?=
 =?utf-8?B?cm80NFNudzRlaVBIOHJzWFMrWUZHL0dkOE5RTTU5ckNicDByU1NWR2JaME03?=
 =?utf-8?B?ZkN2V090YmhkdmxlMG5GemdmL0FjZ2pFOHc4ZUx1b3NpWG44U1kwMEk5MGZT?=
 =?utf-8?B?RDhaWU5EYTYyOWV3SVk2bmpxU0JnOVhxSkNZbUd5cEtpZlQ0YzhvZlRSQWZh?=
 =?utf-8?B?QW1HMitONlFwZlhhdDhEQ0F6SjRlUUhGdkVJMm10VS9kK1dhV2VmV2padG5x?=
 =?utf-8?B?V1daOVBUYWt0a0w4ZzYvSmNLcmZKbkRvaDRtUU8wT1NjdFVQRmxGc256b0pT?=
 =?utf-8?B?WFVhNVlpQkFIOFdmWXE0ZytlMTltSHBzYkhJb2pHVU1YK2ErTTNobW1uZ3Z1?=
 =?utf-8?B?Q0VueGtKMzZVOUJuUVovbHh6bVhYUXNkSFQ4NzdGc2g1cEQzazZQWU5Saktt?=
 =?utf-8?Q?pXC0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB6050.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yy9LRDJ3R1Qzem5UREMrQ2NlZm9HMm5nazR5V09Rd2VDZUNjMnNkM3VNN1cr?=
 =?utf-8?B?Q3hMc1ovOFRJenc2N05JM0xIanJIejRtanE1Z3A1YjdvS3B4V0UwQzl2STgr?=
 =?utf-8?B?dS9jRk9LdlY3em1TNXRZbkhEcWs2aTIxZXhqMzJoVFJhOXpLRkd2UXU2bkFh?=
 =?utf-8?B?QjdPRjhaQ2crODc2RW9aVUl6YklJSS9KazFma2lUb2VIWDgxTmp6UFFCRlFB?=
 =?utf-8?B?RkVsUzdRRmRtcUlUMlJhSXhWQzJPRWdPZjlTcDBqTFl6SWJQSmc0RjB1dHBK?=
 =?utf-8?B?TThIWDlVRzhyUEc0anJCRisvOFNQbDJIa20rWGxTa1VKUDZhcUhHbnJoUEtD?=
 =?utf-8?B?YkQ3Smt2ekptZ3p2WDFwTzl1a1lONmhIcWlhM1ZxRWRhOGZneHA1MG1qSU9l?=
 =?utf-8?B?OXRUTzZJd3djc0dpNXlLYzFVck5hZkoxM01mVXVBc0dJbkJQWkR0TGdtbFlj?=
 =?utf-8?B?bDdDU2xQUDRYMEh6eHRuS2xRQVNhbmZjOGFqRjhURk1qc3lMeTI0MnJIVmJo?=
 =?utf-8?B?cDl2ZVJTV3VaaHBTcTA2cUNJOGtoaitralcycFlsSGJYUHg2dW8xN3ZsL1cv?=
 =?utf-8?B?SkV0QkJ6Z0MyTzY1SE9RQXVQYVBhVkhKcFpYbWNOcVNKay9wTGxyR3JqM3Fn?=
 =?utf-8?B?T2VabGlqWnh1RTNHbjRLSmRvd0RMSlFoWkZ5VFVsZkJQRko3ZU1pa0hZNlpq?=
 =?utf-8?B?RW1UOVJ6NlBRMVV3UDI3djZ3dmQ3N1JNbm91WE1LU0d1a0VaUWVCL2tmREpP?=
 =?utf-8?B?aFJFYVVOOTg3SU45QUx0UVE0SU1ybG51bnBUbi9MbnpaQ3Mwc3dieFV4dTNW?=
 =?utf-8?B?bkZnb1VuRnovRXRZK3l1N3IxZkdsbXFGd0N0N3Jzc01Ba2ZaV3FXVkVMeHNB?=
 =?utf-8?B?cmZNN2pnRy9SdkVHTWFxU2JQdVZCU2JQcjZEL1hmME1raHY0OUNaVGw0R2xu?=
 =?utf-8?B?cE5STHpSVFhyamRuZjdWT0hTUk9IdHQ4eFhtUFN1UWoxK1B1MjVNZ1BaT3Mw?=
 =?utf-8?B?WFE4Skp3bWczQ2EzUnVQSVRET1hUUE5GZFJEUWtDM1MvRnhISnNCaGNidENR?=
 =?utf-8?B?dVpjRXUzdm82aXAvMEtrOXFXbjhVK3B3U1BXdVRCVndMTVB2ZGpVTVVKd09P?=
 =?utf-8?B?cEtmdEE0U0ZMYjZ0aUt4M3ZIU2JuU0dHZk5WVjJaM3lGak5mbmJmRkE5VU1O?=
 =?utf-8?B?Ri9udWx5U2NxSEJUelZlV05qTjhvYk1RaTZER21Yc1ZWOUlqUnhBVzZudzd0?=
 =?utf-8?B?WXpkckdxdXM2OThoeWlaWTRtS2QzdXFmZUFjWnA0dG56VkJqSmY4TFNGTkU0?=
 =?utf-8?B?WWZNak1lTEROaCs3SStpZjV6WnVEc2ZkVUx0ZVN1Y0NKcWE2ZzQ3YWo3b1o4?=
 =?utf-8?B?WGdRV2N5aFRjQ2txb3o2bUs3SVFwdmR4alNZVDFla3pyVWFIL2NvRHVQNGY5?=
 =?utf-8?B?NCs4OTYvNUZyYzNGUDlXa1Y5VVBIYUkwb3MzdTlHNll3aTdNajhKS3gwMEM3?=
 =?utf-8?B?YnE4bDRFRzVYRDFEYlFvZWVncHR5L1VKRUJ5ZkJYaVZzVlJMcEVWdHBsY1I5?=
 =?utf-8?B?SnBzbjlGa0I4QU5vS1NseUhPeVJtU0ZLODl5U0JxKzZQVlB6WUpUSFlvVmZC?=
 =?utf-8?B?SW1aNnNlYVdVMHhZRURTNnlURmRoMVZlSDIxQkJBNzJhZEw4anRnbmJDcStx?=
 =?utf-8?B?Ykk3V2pBWm1KbXR4T1VIRmUwUVdwcWVhRS9GQXM2ZGp2OU9wT3ROZ29BZHN0?=
 =?utf-8?B?aWlZeVRTQlBBc1kyb0JyZk55OUFjWTZGYmp3MDNPMTJwV3dYRStFamZXbnZz?=
 =?utf-8?B?d0RBOGFMeWdnd2lBSTNSV2l1cjhRYzdXUXFyQTkwY3B1NkpsbmhQMERuNWxV?=
 =?utf-8?B?TUplbXI4b1UyVUx3b3JVeS9aM3JlUmlLcTFCVlJEZVo3NlRSYUxhZmN5ejdV?=
 =?utf-8?B?YVI2ek5EcjdKNnMyYXFwME1yQVJHRXpieDJBSVJYSGpJS1RVQ3NXSlR3SFhH?=
 =?utf-8?B?SHdhUFpHL252OHdMZWdEYlo1aDg1K3dqUzdYZ3V1NFU3aCtsL2pKUDd2QnRl?=
 =?utf-8?B?MnFaYkY2UCtvVnFYeVVwbXhRR202QWFEOXprTXNkWDZHcGNUaVBaMnRKZ21o?=
 =?utf-8?B?WENxL3hQbEdhOEZnUlY0Y1VwTzdnY0xob0orR0xveU43YVE0M1E1VkpVTCtB?=
 =?utf-8?B?dlZsM3lTeE83SEROdXdpbEZ4ZStYellGNTRsUGpkYm5vcVEzQWRoY0JTem9v?=
 =?utf-8?B?Q0ozaEMySUpxOXBZYWtoOGRQOHFGQStPWUhvdmgrYUIrUDZqUm5GTDMrWStD?=
 =?utf-8?B?bUtMbDY1VEdvdTNsNWdpdWVwM1pmNTBqL1ZKTVBSeVU0TEYrRE1Xdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yG0XAx77X2Hv/TdHH8aXjSicdmEwRduUbie0zsfFMzeIRiIOOOdijB2SNbkV7yt8Stk/VfhvMnqSLwL2gyi+g8MwK0Ck/qrqwf54m3Y33ybGpNQ1GuD6UzCZhCAr6u7zG4Q7sQaWelCDgpMBcc2hpYtwu1CX9516Z15w9xeF7lFgT9sObELZ4nTeZpRH/69Qf1TiFprhyzdbW2A2o4riY7p1J9WgQM6Poklf9DvFcbb27TvQztXAbfhUAynQwr19QgR67luj3HwupGPpW7hPESAtwUGgVOkjuMp3y5umCSH9mwBG5SQBc2QbsmseG66Gubj8jNjYu+68gzuRxAuOVjhdv8ePqen7e7K/h96RqgVm++qcxf96r4DpKC/wJt7JLy55v8F5dHu/CZ8r4CwiUjquGPe0YXHb8sVPnFGm7+Klzlb9egCRZ5RVNx67iicXgzVsFV0RleMbwpasbYO/Hx/B6aYbz2RAPMJ7N/kaPiqoJVwrlV3Xt49JK6q0DDREZNH7o1VDAClrTEm62/+5KCJOT0vBho3QlPdSxzGPAOi+CGTDRyobSiuznnjnbmQ9nPnw3zqJfF0WH5a0VDwtyEl5CxaT0L/5+xmiANrwHNU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4a0909-e6c6-4392-04ad-08de6e49f4a2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6050.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:28:25.0756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYKbJ5g/ghQKgpUjdwCFpvcAileQl4zCOaKc7SzoODxjNAyOawBmny0zn6uCQE6RTcOdOG8kpaLQfiFqfT4EWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602170142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE0MiBTYWx0ZWRfX5JdzREYl1zsO
 V2AOyPjXxr63fHllROxEyZppepvUGQRfQJ3M2lreu29Y1K3wwwHTqMafZEg524PkvJKf8uGZSWs
 qPdWC7FlT2as79Nxljv83H1XmBFlrfj7G63V2gXWcunuahjQKf7N3y+4C70KTD5Q9nWBWzfedtW
 SSAydPcxqcTLksqAlEa0xa7MfCToR86lTe7m3XMA1mAZiMwK5kiWDxaHHjGhr+oejY/Yh5/tE2Z
 2oQUzEHrcOAYyRf2FP2NtANKd4X1Gix+rcR9vYBgtAucWLYk3IYva748Lk4xy1nE/J5/E95aOen
 0DYxZnZ2eRpDOUYv2+78uP3k0Dz57PQ3d6am82KT9WOXN2bP3+p+Tu3h4ABKzPt7fnYHRU8Pipx
 krSYi1vJ5xcuZl2Ff9MoEOUlVCO+j5Vl/FK4t9CUOTpRJyRkhiVl+WY8snBe8SR3MT/qd+fbQDz
 2bbiksaWKgznNj+leMQ==
X-Authority-Analysis: v=2.4 cv=ZMfaWH7b c=1 sm=1 tr=0 ts=6994a542 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=8INAk3Zth1LZzj6clxwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: o5UeNsjmvjgBiOJtmJ0FuH2quEWHo2Tt
X-Proofpoint-GUID: o5UeNsjmvjgBiOJtmJ0FuH2quEWHo2Tt
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259112-lists,netdev=lfdr.de];
	SUBJECT_HAS_QUESTION(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5efae91f60932839f0a5];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4201B14E9BA
X-Rspamd-Action: no action

On 2026-02-17 09:19, Fernando Fernandez Mancera wrote:
> On 2/17/26 6:13 PM, Gerd Rausch wrote:
>> If someone were to change the code to pass in "fan_out == true"
>> from a context not already holding a socket lock,
>> would they remember to change rds_tcp_conn_slots_available()
>> to acquire that lock?
>>
> 
> Usually kernel requires the developer to understand when do they need to acquire a lock or not.
> Anyway, what would you suggest? To check whether we have acquired the lock or not and do it conditionally?> 

Something along those lines.

Either a "_locked" version of "conn_slots_available" function pointer,
a parameter, or a check.

What you suggested is fine though for the immediate syzbot need.

Thanks,

   Gerd


