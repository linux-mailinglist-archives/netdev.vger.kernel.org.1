Return-Path: <netdev+bounces-85370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE0389A799
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 01:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC957B229B7
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 23:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CDE364DC;
	Fri,  5 Apr 2024 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XgZUSf94";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UlbLUUmg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10894C74
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712359751; cv=fail; b=e/3FkWQLcJmMc9TrtuIbK+Sve99FELZS/VTIgByd8dqaa9c1a6rDgR4wCCxwgmKBenxJOhr5ULriHoTMX/UFckm5J8sn8NCqOwaimg7l/6rb1CTR28feegiQLE4i/kTBx1vipe5sWIfvDr8rsCgAnC9UfsaOm6LiXidQIM5inFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712359751; c=relaxed/simple;
	bh=jdfuKj2AZ3LQM/y4eM/aUEH0NeXjfwPs+b33zdTx6xs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fjbm6cyyduik9pD7FX+QeF7mELwz8okkShjrBz4x4aChdIMqu7beP3R7/V5pjy0NTOF8zjLV6Yu2H4K+KtCUZfFBNRA7RxrHyUzmsc3m9RkDEslq3+3UeBkuSjrJcOL+n+PCuXmjDcpxlQ7hh67N8RvwKvUEFtqeTGGj9qg3twE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XgZUSf94; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UlbLUUmg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435LXKkr030428;
	Fri, 5 Apr 2024 23:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=JLGK2ttszB554Rwyu8RYH2Q55EAj9G43Gz8XopGpRN8=;
 b=XgZUSf94HncyZ6oEp48xb9rmMZ/hWEdkyHKlpCiGbsO0KbGj1D5RLze1GEUrbkxIsZ8X
 xAQ2KLOkuGX+5bR4+YKsR4QqVpq8xE2LaD+grSYzKcyzEOpQfZCDlg3GZ4Uj86SfE9dv
 1cA2UpqqkW4Crjhkx+0JxXEVrcnvQb8ltBkCXN77zGuDTLZnv4poibGrxp6u1+4Lg027
 dbHOKm7r0xeSQCwaZ6jRtoGP+/rv4HpnifMWn28jQw+LJkYxSdeyhFYKXghDuh3wA6+L
 UItgBuSc7lmjtVVgT9JMNqnqE56rT8+50nEcM79Jvvckh67FauytZKgjJUhPUHtLJi58 CA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9emtmja5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 23:28:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435LLlig009275;
	Fri, 5 Apr 2024 23:28:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emnpux2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 23:28:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPfBoex1V+pbcxpzKshzWD2Enw17fjuvt6KI8pA5rw3wXA49KBIkvcIY58vvvF+gL3LRWzOgSisT7q+O0BtX/jWAc9o64T1MLPAXskUz7ck/OX+v1yWVvKx4MePZyO3umHtcXV74326aTfW5durruH42NuFquJZ9I1KGX4opEl/TYiJlKHUnenZTa8cL0NpCR2ZHD4VcP96EUJh4807M64wWCwVvhKQ8Pp0O8ZE9Jxg3pDSXXwSxdXaa9g4kCHfklwRUS5csYIT1kB20t3VWGI2lTRBFia40v4X5CrodA9dEllIwtxm+nKc+slxsJS/3VRVivpctphWgrtaXTO04Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLGK2ttszB554Rwyu8RYH2Q55EAj9G43Gz8XopGpRN8=;
 b=MlBIh7jyPG3291ugW9OjaeRW4aT+L7aXGhDoitAqfFKwVEdVoewiM+mX8d+LwrcqJc/1OjC/XEWyZtKdjz+AJnv5hDTLCEW+mnscp5XwB4CHBhmpHmEOaD6B6+eWrlSBvgkR9wnYQPpH6wQuXaCfC3LLkimq5sZal7L19smRMEV/tAjnRnUh2BVmTxeo41+0oMtjZjED0VgR9aHq9YUgGS/Lpbhb0p5ofpVY4g4ebj/bRjNeXDxuOrQZPabCqmq3LMktiLIE9DtpCYKduyYWSlNc3u2p3BuLFPUkcfPqZtJxlckfEfq2jfLpSWI0gBusPtIVW8B1pDM3veiwJBuVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLGK2ttszB554Rwyu8RYH2Q55EAj9G43Gz8XopGpRN8=;
 b=UlbLUUmgXKTqZQUo6oTLIU7CIX++vYwN8BE6sxGC34sNNqVb4P2Sf4AzM6zft/u9LoNonJ5H0CTVvlmfn4O2h8jcKJPACRm5XXLgKZZg5vVtO3Fdd5yLbUo0WISMcM8se/+rdfnVOgE0AcvaL6ejLspQpN4Yd1B31VSPVhDsEZs=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by DS0PR10MB6917.namprd10.prod.outlook.com (2603:10b6:8:134::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 23:28:54 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::40af:fb74:10b1:1300]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::40af:fb74:10b1:1300%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 23:28:54 +0000
Message-ID: <472044aa-4427-40f0-9b9a-bce75d5c8aac@oracle.com>
Date: Fri, 5 Apr 2024 16:28:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] af_unix: Clear stale u->oob_skb.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
        syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com
References: <ae5def68-6cc0-4cfe-a031-fefb103e854c@oracle.com>
 <20240405230129.7543-1-kuniyu@amazon.com>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <20240405230129.7543-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::42) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|DS0PR10MB6917:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	exbeoTMW72YTj8kPaZKrn/Lz830KYAMx7r6KYaZNb3Ub3/8niUtM64UDQze6wGqpWUhyEQ5wP43O7qRTSsJLCEtVli5AkgBNbUIZwjKNggOVZfmFQOMf5pUzXpcxf0fAiXykuTeLN+jefg8a35en5WrlaIQY7OY2yZeaqRbnkJMmR6SAZasnTjUMwqqax+pgwL4l/kkh4uFKsWF4Z8n9570BfnUn08ZBJi06QNAecTYxDujOHs8g4yveWXgpJ/prrKUxMnkqLbHsYVntafYPl78etvCDJkqJo0jDlxagUk+O6czTrps/tqmRJY4cDuJKL8EyKKZTzlTut8C/1gYKcKKmZFwdp71DBtVQZcynSmfVevcq1dOP05l43l/3rwGzx4GTg6FPcFBPnMDVXNhdmdLt/JT0d4tCicOp2ibRm6gg7Rdat0lkQa20VE6pTaZCM3MS7hiW8vOJ8pwiAWxV2/beCmFWfCEILEeNGi/4Omkpz68BzRC6gGtK97IQv/m3hK42GIFSn+iEuvSw6xVl94OGwNAbYBbPgACzMDtVKZ6fyUkP2NssAo0CWFnvlwPvTqX3UioUYYje0BAK2jzbdWIXK66dWHYKAxxB3JYKfJjjJNLdTj/HkPD1rakPrK6hxLBstchDoLBhP+rZUJ0LdYxC11+GHF4vAj5ko3PhI/4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVR4L3F1VXBoaDhyMlVLN3ZrK0VWM3lXK3FrdkpJSW10ZVFzdk5KOHdOUkYr?=
 =?utf-8?B?TUVjSUd3NThqWUZtNDlNd21PMG1XZTlVazEvRVdHd3R1TGw1Q2d3N2EvOTdx?=
 =?utf-8?B?UVhnRTQvbjNoWWV0QksxU2pzNjRRa2tKUXVLc0t6dVpRTEo0YzRjNjBwSlFW?=
 =?utf-8?B?WEh1VFZxam1ZcVlaWEE0UTlUN3NvUGYyMUVZWWQ1bzRFTVlJcFFya1V6d2FV?=
 =?utf-8?B?djRkdUFLVEZ6RFRmNzZnb3pkcXpXczVRQWgvbFpvWFF1T1A3V3dhRkduVU5i?=
 =?utf-8?B?RVgrbFNOOVlDc1JlMDZJbWRRYzlhQUlIMHBqc2l4SmNmdzhPTXJmeGFtOWVp?=
 =?utf-8?B?ZjFSZUpoczNEYmxyTVJDdUFoQi8xaWZldUF6TGozWGkyNDZHV3BrQ1ZLOHhm?=
 =?utf-8?B?SmNBSXA4MmVTK3YyU0FmRThVNDJRMGJxQTRpaVRUN1JjWFZBSnM2ekxSWUtV?=
 =?utf-8?B?dXpDbjQ1S09vSVhzL2Nac2VoRFhyYitLcmpZU25WUkFQL1krUnE3SHFmblp3?=
 =?utf-8?B?UHp2QVZ0MldhajZRdk5KSk92RjlXMy9HUjQvU3VsWVBtZW9QSHhteVUwRmlo?=
 =?utf-8?B?QVNqUDN4LzJGUU9IZEtPa2xQTUdTaENaK2MrOEsxTFBOQ010QjFTVTBndEIx?=
 =?utf-8?B?NzBDamcwNHB3elhBT3h4QVVhNWpVSks1TXJWU044ZEhVQXRTU1FneFRCTktW?=
 =?utf-8?B?VmpMTFZEeUlvcFlCVXVINWRZY0VEMDlSMzRtMW1qeWdZQVhUS0dTS01PZ3d2?=
 =?utf-8?B?d3RlNXpzdWJFcm5IWFpTdjhqSmp3S2dycCtsVmJWLzU2c3N3UGVPY0g4NkI5?=
 =?utf-8?B?VXNRbWEzcGp0cWRrcExQdTBDclBPamIwSFFhTjR4eFJpSVhFY2hRdXhqRXBV?=
 =?utf-8?B?WERiT05UV2k3UkI4UGdxaEt2R2s3VHE5akVJMmM3endtOHVHUUdoeHJKRWlL?=
 =?utf-8?B?NjNmNDUxUEFneTUzMGV3WERtZVhUMUpuUXZZSEZDdGw1ekZ2T1YrVC9UZGg4?=
 =?utf-8?B?VVRwaVhCajhiL3pIaXVsYWg0WHJOMmlUei9BdUJLanVYRWpGR2trMHAyREdI?=
 =?utf-8?B?K0tESHd6N2xlRGxMa3Q5eVREOXlHaWVwdE0ydnNRUHFyU1lsdXJCdjBhZWxr?=
 =?utf-8?B?YzRpWDQ5eUxOY0V0bU16THVTTGpnZ2hURnR6ZGRPSkQwZzlveFRNVktrZThW?=
 =?utf-8?B?RWNGaG81KzZpNExyRDJQdWQ0a0VwKy9NVHIwUFZWQUNBanVldHZVYmtKQ1lG?=
 =?utf-8?B?M0dyNmdySHZxZWVLSXczaXBoU3FvOUtwMkJzTzRwRlpVeXp3WG9xQzRPZGJ6?=
 =?utf-8?B?RE5nUVd6dVNzeEZrQXRhWFRXNVd5QTgzVFlFNnNxSXZSZUY1U1VwdHFuNXhX?=
 =?utf-8?B?WkJCeVJNejY0dkhpdGlOQ01JNlRoYm5hMTFVbFQ5dHdKV2xpS0lIWkdNYzAy?=
 =?utf-8?B?czFSOUdvbFJPSkVzblpoOEx1UlVZQStXZk9OeXVpUFd4cU5qQmlTaW9NTy93?=
 =?utf-8?B?ZEwxck41V1B4UmhKY3BsT2xyYWUySUc3U05QekF3d00wYjl1SmRKWkhXY20w?=
 =?utf-8?B?RkZlanZBOFVBSWorQ3dLRTI0SnJWODNKVzEyN2p0UnErY1BUUnVlbFZOL1Zk?=
 =?utf-8?B?dmhsWS93eS9qY2pWcGpzR0ZLVldvRGhwMnZGWjhHQnRsQnpONXQwOXpFTzBJ?=
 =?utf-8?B?Wm5saGJIN0cvYVdBcG01Q1FXSWd2K21WaHhETnVvMDZacXpXWHhFVjdqY2tZ?=
 =?utf-8?B?eEZrcjNEYlB5UmtHUFp5N2dhRWpBYk0xOWRpYVBKVmtHczIyYUpReXVRdTkx?=
 =?utf-8?B?TndaUnBwb3I5eFE3Qnp1ZlpTN3NJWWNYaTJvU0VqMGp5c0VlOElvZy9hVlA5?=
 =?utf-8?B?c0thWmgzalFOcHVqcnhMMzBqc1VRdDdQb28vTUdiMWREQVFTUmtMUFFnT2JT?=
 =?utf-8?B?bi9La0VkbmljbFhodFEvcVgwRXdISmlvSjV6REVsK0RwNmlzKytkTm1JdFpU?=
 =?utf-8?B?cGVPRm84Nis5MlhtZHhQRkFkaEFBL2JTUWJBN2lqWW8xNzRQalF0UEdFUENU?=
 =?utf-8?B?anlRYU1yNnFqdWRkS2xzajBTa2VkMllNMkhrR2M0a1NkUlA4M0tRLzZGSjVT?=
 =?utf-8?Q?xAKqw7xH/VIXF+nKfTosPCdVj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	S4yrRQZ8bQzxXHqL2AJuLAER2riXBSti5AE75gBXKa+XyyVqgNpXLeWXdJ7qFg8zNa6xkJPnqEZ43orB/1LQtimBUg9LpQc5dt0yTE1MDM3JfFyW/ZElO1WrVr/b4T2/hoVdBcqkQYrgegiSwtYuHxQ8tJCtFd8fcllMUHoCqZIytAax5jyjH1NfAc84Cx0Cu7exDR5Bm7fmWg9DFzvTe0uqhRE/QbH9/VvKrUxLThVgr6J3PcHZ8LUPKDjJlMCjh2nMAxMrqB3/szGX1/UATKtu8NqW/hYdEzJwmdpxKHgkQJ0WA3a5Xrlo2crPD6vKnlwFK1JvyJHJVZVsyREy/8d+m6lTyfaeGLHYtM87t6PeEwQfZP8S+ow9cH/nFM2oeepOb07PcMosDvrbWFcqmIg/ejjklDnHaZ0met1+fvIlRX2zdY0Rw2lyxAuv0KzAz59+8cCFKlCpFRMZ6ilBbpW93+Zd8fR+uleLHyMOCxRiqduWpszP5lcj7Ge9v6F1IEjn13TV15p8MaB88X43yfDcesAiyBt8GeaO88qE1Gic0BdXLDyLoUsR5ZrsqkmrHoa3CVOSqNfcTACFKW+NVkh4okMpr3/fT1y1K5pCEKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61e0b77-70bb-4459-9097-08dc55c828a4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 23:28:54.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdGEmCalL3mRidGR+DMipqHbumk2QCuYkuztE502h1sHTucjBAEEU6u43sG71ng4jPdWN6p/IkaeU+ydbItntA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_28,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050169
X-Proofpoint-GUID: coH6ZRDmmoYTReBQq2IRifbad2E2vT_8
X-Proofpoint-ORIG-GUID: coH6ZRDmmoYTReBQq2IRifbad2E2vT_8



On 4/5/24 16:01, Kuniyuki Iwashima wrote:
> From: Rao Shoaib <rao.shoaib@oracle.com>
> Date: Fri, 5 Apr 2024 15:43:26 -0700
> [...]
>>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>>> index 5b41e2321209..d032eb5fa6df 100644
>>> --- a/net/unix/af_unix.c
>>> +++ b/net/unix/af_unix.c
>>> @@ -2665,7 +2665,9 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>>>   				}
>>>   			} else if (!(flags & MSG_PEEK)) {
>>>   				skb_unlink(skb, &sk->sk_receive_queue);
>>> -				consume_skb(skb);
>>> +				WRITE_ONCE(u->oob_skb, NULL);
>>> +				if (!WARN_ON_ONCE(skb_unref(skb)))
>>> +					kfree_skb(skb);
>>>   				skb = skb_peek(&sk->sk_receive_queue);
>>>   			}
>>>   		}
>>
>> Isn't  consume_skb doing the same thing() ? .
> 
> Only if you disable CONFIG_TRACEPOINTS, otherwise each function
> uses different tracepoints, trace_consume_skb() vs trace_kfree_skb().
> 
> Here, we clearly drop the skb that's not received by user, so
> kfree_skb() should be used.

I won't get into the semantics of freed or consumed. So fine go with it. 
However if I was tracing I would just trace kfree_skb.
> 
> 
>> The only action needed is to clear out u->oob_skb -- No?
> 
> Also, queue_oob() now calls skb_get() and holds another refcnt,
> so skb_unref() is needed.

A quick look, does not show me that the proposed fix does anything 
different wrt to the refcnt. consume_skb() also calls skb_unref() and 
kfree_skb().

I am fine with this.

Reviewed-by: Rao shoaib <rao.shoaib@oracle.com>

Shoaib


> 
> BTW, do you know if MSG_OOB is actually used in production ?
> I don't know any real user other than syzbot.
> 
> P.S.
> Please send mail in plain text format as mailing list drops HTML.

