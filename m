Return-Path: <netdev+bounces-127113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7832F97429C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 20:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8D51F277D1
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830AD1A4F16;
	Tue, 10 Sep 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XrIk0t6J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MN3QpkrY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A81C69D;
	Tue, 10 Sep 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994179; cv=fail; b=gmXA5ljcrM1CxNxLJlEbXiup1zW3ZtgO1okBGil933Z8Uublfz99EPlwydpYmvyvpFjEaxkgvMSSEK3e/k8oMjjCcfCaQtHA+0Jxcy20asp+UPx/gV9hmbm5A+jqHmJ07RJxRJg2LDXaFWlAECl6WDKjhgLXST9AdT0KTAYEYfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994179; c=relaxed/simple;
	bh=9cP35fzcyqL0R4u0AhSWuEiG6gC3xEN54NFzhD3ASnA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GJGK7pCjbsViEGAHzBVtrdS4GF1g3pVpcntmYeQSVIyHIEG3MlYTUDOciirgk2/y6+QyVzzxRtZ8FL39PllXZ16CAHDMYBORLsHnoF+mEAQwe8NE8935op7kika0hxABOGzMVt2/9Mihk3CuDPYWVSWraESwVlBqnVYoLbZOpgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XrIk0t6J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MN3QpkrY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AHNZRL016987;
	Tue, 10 Sep 2024 18:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=1ih+QQOgnfI0U/7C1p/B8w9vftxQ3yXZVpoaeLmHeps=; b=
	XrIk0t6J8/yOo+FrHH99FaIXNl7PBrGceU1nT4touQGHiFh5IYt1/n+yx6nL36zm
	/8P6BUjwfl2SgN/EdtmeW75NHMCazsjeRj6mME2OjV3IZwLORp2gAiLDb2Mpdr5D
	ZQElt2zwj/rLmffjFlK4ISdlxAyuPat3qURjQdhB+DCrnOtJPbElAu/mqkB4Pj2H
	tV2fuUEEG5PY3r5OjAscge59AdjL0GQlWnHJX98+tVjFhVa9XJaZLR6aXj2uW1EY
	fRTgwQFwGou9LDKts+E36iyeWeDaEZA4efICieG7akqh9Hc5OWMUGqckAgO/7oNG
	k2dfI6l3XnkocoFJ5pmwDQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrb6eur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 18:49:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48AHH74v032452;
	Tue, 10 Sep 2024 18:49:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9f9f6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 18:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1dh6aKkHhL8IrIa2P/NM5voI7/jXZIqyReRhNt+SlfcOVluiZ2qn4MbRfHXLA6/Nqj8S6d7WVNwYOTiKSx5vTZ8jqHYJ7YS77F/xgXuFDq0W5s4FxeeEywEk2n1LQgCuw8lvQE4iFH45tEBb6I4rDQGCbCEYPtDqb45qvUZyJkdJ3M3QYm7xJHLjAmvl3MXWUyCV7nTl3n4LpeqMmzwIvno9ioTnk1AdO2IIuVcm+bDXh9bz69nXQTi5gPKoD61zv1WqBBP+8EtoyTGy2PQIl4/K/SedcwLi4UpENUdxzxjCkEmMqk2h1U4lGUT9VSGfnXv51Spy10L55SYxMJiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ih+QQOgnfI0U/7C1p/B8w9vftxQ3yXZVpoaeLmHeps=;
 b=BXLxSvj/w5Y/k5o5MzdgdcboJXGpwBMzQOJgoxj/N/QTmC8ka4z7yTdxT703u87A8rjL0GuZt0ka6aoj5uz27bENSfYkKyWLyyxo6Dcbna3nODHJDYSTOVdukQT0xFeNXYtxYvHVXVQJFRI4tr9zrHC5zJ2/oGtmcvmUYhCzTp50moo/e9IN6wmVkDdYDl/6VLFDJkEa+c+MlMFr0MB7Mjl8hpHytiKHkl1RwP8m8n9secNY0CJc0heWYd2EFtIa3vOpPiDXrNypB7VQR8rTG2bTz+SjBX0pFWUa0iY/bBY6uE4eeQNE1qb0PNVm3hTmPQpxwjV+bNJATuYpel8jaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ih+QQOgnfI0U/7C1p/B8w9vftxQ3yXZVpoaeLmHeps=;
 b=MN3QpkrYS2VhuLIwewRaTwxhRp+3xH4isTgSfjtkY0Er1aAZqSlFMpLK/1gsRFTHs+UqyI3SDD7aGQFMFq6HigSOA3QIWtXB4GL2IJYO3j4rrmCQM378ZU5tFjgTMvVzjCw23+O0BkxqbQwxDhQYsVBFDbMcjtxnX/m+7hslGs8=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by SN7PR10MB6363.namprd10.prod.outlook.com (2603:10b6:806:26d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 18:49:23 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Tue, 10 Sep 2024
 18:49:23 +0000
Message-ID: <1cca9939-fe04-4e19-bc14-5e6a9323babd@oracle.com>
Date: Tue, 10 Sep 2024 11:49:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <83913196-1240-45b4-9d7b-6f5dffc528c6@oracle.com>
 <20240910183309.82852-1-kuniyu@amazon.com>
Content-Language: en-US
From: Shoaib Rao <rao.shoaib@oracle.com>
In-Reply-To: <20240910183309.82852-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:a03:54::21) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|SN7PR10MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: b110750f-a34e-4f8e-28a3-08dcd1c9493b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkRvU0E0bThWcG9memVGU0JkbXFGVktqbDF2VFBPZ0dya2VRMjg0ODI5OXZX?=
 =?utf-8?B?amt1a1VpZmVhYTVoYkdFRWRpaFFSdk1VcVd0V3dyajBPeFNmR2ZNcnI4MGxX?=
 =?utf-8?B?N052Tm1OWkhyWFJBa09SLzEwV0J4dS9qckwxSERwNlRmajRzekVGazNBbnND?=
 =?utf-8?B?WUZlWTE0ZnVhR2wvV2NoLy81N2o0U2o1c3M1emRXeHBDcGRnd2hDWTVzaVZm?=
 =?utf-8?B?UFJkRjhpTWhrTUlWMVhvQWdJUy9vd2lRa2F2R3dBZy9aZnEzVElWMVVwekhC?=
 =?utf-8?B?OUVCT2hNQXNDQVFBV1IxMXN5TEg3ZkJ0VTVaTDUvdEtia3B6eVErbWhBak5u?=
 =?utf-8?B?c2dvcFljSTEyWmFjUmNFZ0U1UXZ5VlcvV0JSUnZJMVJVRTFmS05NL1BQdUJF?=
 =?utf-8?B?dldzOHZrNFFabGR1WlF6dEVoRkVGcDh1bk1xNS9OMkdyMHpic3k0eGlhMTJl?=
 =?utf-8?B?WGIrUmFtSDFTOFY4YjZoZ0o4dnJuVlp6dHpmZkM2SW45R1IvRlRyYkxvcy9k?=
 =?utf-8?B?dDdDZnl0eHBTRTVUbDVZY20wMFlOR3FSSVpWV1NYUzdnb3cxVVdmN05XbXFO?=
 =?utf-8?B?N2NXNnNocWVZREdjL1l0ZHkvcmRXZm9KUVk2WmliUUNJU2Jhc21CN09iWUJV?=
 =?utf-8?B?V1VaaXcwYWlWL2dxakpQVHpDQ05qRDNSL3luaUtjNjM1WTlKN0thdzFxY205?=
 =?utf-8?B?M1dsbXg4YUowUTdBMDBDazlDSjhHa2NGOEVlRUJsSVovSktrYnN6UXBMemVl?=
 =?utf-8?B?cTZvR1lDUFp2RnhOaUFlODk4Q0VsTEhaNTZiM29wRUVhWkZPQVBESVFSWU01?=
 =?utf-8?B?NkdhOWhFaTRRdEZhWkFCVUR1VjNrY0ZtMlZldmZtYlNSdWpRU2gxeWZicVY0?=
 =?utf-8?B?ckpCZDliNStSV1d1QUlRUmVJOWlxQ214bmF6cVNXSkZNRGQzZXppdGozNEh3?=
 =?utf-8?B?NHBTamVLK1BFdDRSZWRVZ1ZMaEI0Z1ViZ0M1WTBjbmFvcmczQWk0VDJjVlht?=
 =?utf-8?B?ZVI0ODhvb0NBZEJnSmJYQUFzSksrOG9mVzFBT0FjakhUTks3S1ZZU0txcjZV?=
 =?utf-8?B?dXpZQ0pEb3k5L0FrSW8yaFhuampDL2xKZFh1UlhDaG1wSWxkb3hCVG54M1J2?=
 =?utf-8?B?VjFnNkZkQ1JaMmVDNU1DWm5qdkoxT3h4ZmdEMFNFWXpwVC8xVEhMdmVUNlZU?=
 =?utf-8?B?ME1tWmxad3A3R2tjZ2NvM1E5Tk82cE5MM0VGcUZiWWtRNGV6bVdxQVB3cWQx?=
 =?utf-8?B?ZFUzdk9MdG55ZTRZOWhnWXdtR1UvU3lIbndJV05zSnhObndMbkI3RlUvalZa?=
 =?utf-8?B?WTVOdnp0S3RMc0JaQnZmYWRYMjZsWm14U2duN20vS3JPWlg1aTF3aFlaTlFi?=
 =?utf-8?B?TGdWZ3ZvUkRQV3p5Vzk1RjZ0MnhYdGN6aEloOFVtMGFNeVhRZ2NnTVdUS3I0?=
 =?utf-8?B?aW1xYmVzYXBlM2gyR2hoN05RN3pSalpHQ0x0WkFJcG1pSlFVdFNLNnJxYkVR?=
 =?utf-8?B?ZEZSYzIzUUhYMUR4U0wwSVJpZjBvU3N4N29DdHB1TmN6OUxELzJRd1BySTN3?=
 =?utf-8?B?MUJEL0Z6TzQ4ejBJRjlsNkU3c21hMkROb0g3aXFFeEc4OFI2STE0Unp0Nlph?=
 =?utf-8?B?VVpId3dVNHZVSldiZTBwL1hKWkkzYnVjY1VMSWw1dkRIM0JuL0pJV3JvdWxt?=
 =?utf-8?B?TzBodjc0bjdJbFRlWVUvenI4MjBNSDRwS1FQWm9TRVMzMVp0YzN6RnlNekYy?=
 =?utf-8?B?aUthKzlteU11Y2lwS0tqeExtMWk4Wk5GWmkwd0FvUTdVa0ErMUVmYXZNMGhw?=
 =?utf-8?Q?qMWvnzd5f0auLYPLMvfwRthvioqGUVRbF091c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEF3ajVwVSswQnM0THljNkt1TG1sOE8yU01ZNWU5VTNWRkZOb1hrNHpGbnVM?=
 =?utf-8?B?SVdlcGg0blVrbWRtYVFFczd1RlRXeDBabXJzUVZLQzNGUzBJeElPZThyRWRS?=
 =?utf-8?B?aWtqalpTam9aeStEOXd2ZUk4N3k3b3VEQ0g3UE8vMkNxZERPRDMyY1AweDBS?=
 =?utf-8?B?enFSbnNMTHgxR0IzWnJUVkZEQm90eHExVGZSUVdjNERMc2MxZG9HMXJmYVRI?=
 =?utf-8?B?b09kV1JsWU9JNmtnQzk5c2tMNGxTYmNyZGJGVEh2M1NDVzFYWHJBcnNjMUZh?=
 =?utf-8?B?aFJ6aEkwb1FmdTZ0cUsvVzE0eEl1Vll5U1RSY2JwdngwWEJLa1pxaVdIUjlz?=
 =?utf-8?B?d0U4QTduUEVwVkt0aiszSDJqWEVtVFF3dFh2Uy93amJUZnVuTGJBK1A3elJw?=
 =?utf-8?B?eHJ4UEZPMHEybm5ZazhqT0ZBVE5vaVlMSlRnMG55UWc4OXNPMlhuSzRERnNO?=
 =?utf-8?B?T3Nrbk1DRFVhTlMzTUZZQlVlenNGR0FPYWlZZW5yY3MxbnVPdjRuVFlIQWNC?=
 =?utf-8?B?QmZBZVBOM1YvREFlVVdIMWtKU1RyWmhPQVdlMFVxRzNVQ3BjNXhQb3dsL2JX?=
 =?utf-8?B?U08rOUdZTllPSW1LZFgrRUJCQnBna2xmSjkzM09QVUp2eVpoOHg3Y0ZjWFhY?=
 =?utf-8?B?NFJGenNqeGhtSGhQYjByQXRwY25EcTdBc0FvSktiaUZaYlFNNUFSb3FadThE?=
 =?utf-8?B?WkdvVU5VaEZrVWtuQlJmK2JFelhyYWNRRjZWRXRNSlVzWlYrVkpkYjdFMGxh?=
 =?utf-8?B?UEpoSzNxTjBwTHp2cHRxRVN4VmtabFgwV3JLT1ZITVRvZFhMdW9rYUN0Wk5l?=
 =?utf-8?B?cGNhNTF6Zmc0UC9MZ3VtaVFNcC9ZdlBVeVhOYVRRSmtyK3hDYmVLM1NmeWFX?=
 =?utf-8?B?N0hGbEs2eGhLN0xHYUt1d2tnbjNzNlVxalo3RC9OSk1GemtEM25ZbXZoQXAy?=
 =?utf-8?B?dmxsSE5XQ2RkK0Q1Y0FDLzkyMFVSTkkwbTVsdjE0QTFxTGRpR0VjZFozYVlG?=
 =?utf-8?B?ZDV3VkxDSjlRNWxjSjJadUpHbEQ1SkoxT0UwYUFHTFh0d1BjOXprUlczNDNB?=
 =?utf-8?B?RkN3Qjl0SGJaMVlEMmFCSzZtS3IybXJoMTdIYVJ1V2ZGUysrMzl6Y1U1RWk1?=
 =?utf-8?B?b2N2N2lnamRYbXc3L2pWd3NuOWd4dlpuajViZWRMU1E0UW9WSlV5Mmlwc2s0?=
 =?utf-8?B?WVl6QTd3a0s3SURYNW11VnRpaXVyMDIrbk95eEVxNDdHWjh5aUI5Nmt2OGNJ?=
 =?utf-8?B?WWh3UkdDd3cxbVZWSUg1L3BvQVVyVDdDT3cwelBSN09mMUUwUFNxa0djVXM4?=
 =?utf-8?B?TWdudEdnang3YWF5TEVDY0JOSUdmeUwzcm54UThCODdjalFCMURnNFY3MmhZ?=
 =?utf-8?B?L2laNjMvZGg0S0NMR013ZVljWU1uRlNFVTg0aHJETWNXU21aUllKaWJ3cUdF?=
 =?utf-8?B?dDBURGtYbEEzWUdGbUxQcTZWN0piSU1od2RyakJSVzVIYTNGNGFSTU44UHNi?=
 =?utf-8?B?MEJyckVOUFVlWW5MTW84MVFKUzNOU3pKY2JQZE53SWZZcVJMS1lLS1NmUHVH?=
 =?utf-8?B?eUpwV2RZSWRST25TSG1TcCtrYmRNTmhTNUtKODhSZzF0aGJ1dlg0THZhL0d6?=
 =?utf-8?B?NCtVQzJvOFIzWXRrWDIvK3hQRWNRcUlFMXVSaElYRmNMRm9JRXBFVVRCVkN0?=
 =?utf-8?B?N09UT051T2wrb3o4OUp1TzE4eGVDczA0dTlyRC83V1RERjYySElUT2FsU2JX?=
 =?utf-8?B?bktJLy8vNWx1WUoyNXpDUFFnc2ZRN0VuRkRDbU9RS2V5bVRjQXNkMG1vbEV6?=
 =?utf-8?B?OFkvbVcwZFNIVXVsUEkyeXQxY25tU3Z5V0JQNGhGblp3OHZXNGJLR0JVK1hx?=
 =?utf-8?B?L3RObWh4VG55ZTQ3a3Vtbmw2aVRabXBpYU1YcGJGS29BR2pwczhpNDMvRXly?=
 =?utf-8?B?d3QvSC9VSmk0ODVzQ3RYVlB3R2E5OFBnUjFsODg1V2N2bC9meUtIN2FRUjBx?=
 =?utf-8?B?cDI4R0lFd0RIcGV2eWI1WEVFM2YyUjErN1k5bWhuS2p6UHdQamdnSlVNNFpJ?=
 =?utf-8?B?cENHa2c3S2hwMzBtb2NKN216RlhCVkJ3ODZGTmQwMDN2L09pRlIwNSt4d1ZZ?=
 =?utf-8?B?ZjFCN0dBTDhGOTZSTFlqdmp1d0ZXMUpRdWtZZE9CVjZJcHpKM3J1Rk82Ukl3?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	35N678vWe+fVTjT1JcOarsZwK9qLzDVJCOYPacdsGZouWAgkWufLJpHpP71OWbWu9Jf6S5ICs6J9+Absiu9YA2X2Xq9HKFcHQzOhE9Pxx6F5QfCQPe/hshtpiamRg29f2ogtZilQTiOAGvzsCwXx1hLa1jkFTkg6K1H7vKQTRuVkgmKrmp08mdvBMGApNpkKeQ4Ncq2S5/3TcI7i/riEzcBqsuCtUTKqSmsp5GzRPvei3tKUGBUvLBct0dXHHZNAfk3jEJSwGG5tScWpOf8cDvBC9Qc8lTEIJACY0x9+aK0r4vnyOfqCUSkJwdzbP15BHe/7cmbehh1T021Vcbt8iMlun30HgZvOPD/a+BT8o/lVp+0jtMflgEawPmfVDFV8MLf1m8BOGfBX3bHOz0hHMpvozsv+uZB5pgsVovozJUOJUEEYGJ38if4miVGyPnDVLpP921vYhrwDwsZ50PhuqN/YUa3nVecVaqcDslSvtEpR2YpAw6CRkIDsv9byR1MjVCBb4/3d86Y2urQByKA4SR/vPUY80gCXtmF2gFmzapBiZAqg7AHUHMpRLs6nC/oQZVQyLHZPivxnzYIoC/XQUP95B6qx4BYY9DFMBmSP0DU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b110750f-a34e-4f8e-28a3-08dcd1c9493b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 18:49:22.9619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+4XFFEm10k7IVEQA8Yz+MP/4uaHotjj5MgAfJTHcpZkviJp/ZfgI8Ttr3dtmYCKPr1doYb5b1vFV+jHefke1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_06,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100139
X-Proofpoint-ORIG-GUID: AbPH-mC9Wc3ZKrj_Z7cEhQgc8PEbHvV-
X-Proofpoint-GUID: AbPH-mC9Wc3ZKrj_Z7cEhQgc8PEbHvV-



On 9/10/2024 11:33 AM, Kuniyuki Iwashima wrote:
> From: Shoaib Rao <rao.shoaib@oracle.com>
> Date: Tue, 10 Sep 2024 11:16:59 -0700
>> On 9/10/2024 10:57 AM, Kuniyuki Iwashima wrote:
>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>> Date: Tue, 10 Sep 2024 09:55:03 -0700
>>>> On 9/9/2024 5:48 PM, Kuniyuki Iwashima wrote:
>>>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>>>> Date: Mon, 9 Sep 2024 17:29:04 -0700
>>>>>> I have some more time investigating the issue. The sequence of packet
>>>>>> arrival and consumption definitely points to an issue with OOB handling
>>>>>> and I will be submitting a patch for that.
>>>>>
>>>>> It seems a bit late.
>>>>> My patches were applied few minutes before this mail was sent.
>>>>> https://urldefense.com/v3/__https://lore.kernel.org/netdev/172592764315.3964840.16480083161244716649.git-patchwork-notify@kernel.org/__;!!ACWV5N9M2RV99hQ!M806VrqNEGFgGXEoWG85msKAdFPXup7RzHy9Kt4q_HOfpPWsjNHn75KyFK3a3jWvOb9EEQuFGOjpqgk$
>>>>>
>>>>
>>>> That is a subpar fix. I am not sure why the maintainers accepted the fix
>>>> when it was clear that I was still looking into the issue.
>>>
>>> Just because it's not a subpar fix and you were slow and wrong,
>>> clining to triggering the KASAN splat without thinking much.
>>>
>>>
>>>> Plus the
>>>> claim that it fixes the panic is absolutely wrong.
>>>
>>> The _root_ cause of the splat is mishandling of OOB in manage_oob()
>>> which causes UAF later in another recvmsg().
>>>
>>> Honestly your patch is rather a subpar fix to me, few points:
>>>
>>>     1. The change conflicts with net-next as we have already removed
>>>        the additional unnecessary refcnt for OOB skb that has caused
>>>        so many issue reported by syzkaller
>>>
>>>     2. Removing OOB skb in queue_oob() relies on the unneeded refcnt
>>>        but it's not mentioned; if merge was done wrongly, another UAF
>>>        will be introduced in recvmsg()
>>>
>>>     3. Even the removing logic is completely unnecessary if manage_oob()
>>>        is changed
>>>
>>>     4. The scan_again: label is misplaced; two consecutive empty OOB skbs
>>>        never exist at the head of recvq
>>>
>>>     5. ioctl() is not fixed
>>>
>>>     6. No test added
>>>
>>>     7. Fixes: tag is bogus
>>>
>>>     8. Subject lacks target tree and af_unix prefix
>>
>> If you want to nit pick, nit pick away, Just because the patch email
>> lacks proper formatting does not make the patch technically inferior.
> 
> Ironically you just nit picked 8.
> 
> 

I have no idea what you mean. I am more worried about technical 
correctness than formatting -- That does not mean formatting is not 
necessary.

>> My
>> fix is a proper fix not a hack. The change in queue_oob is sufficient to
>> fix all issues including SIOCATMARK. The fix in manage_oob is just for
>> correctness.
> 
> Then, it should be WARN_ON_ONCE() not to confuse future readers.
> 
> 
>> In your fix I specifically did not like the change made to
>> fix SIOCATMARK.
> 
> I don't like that part too, but it's needed to avoid the additional refcnt
> that is much worse as syzbot has been demonstrating.
> 

syzbot has nothing to do with doing a proper fix. One has to understand 
the code though to do the fix at the proper location.

> 
>>
>> What is most worrying is claim to fixing a panic when it can not even
>> happen with the bug.
> 
> It's only on your setup.  syzbot and I were able to trigger that with
> the bug.
> 

Really, what is so special about my setup that kasan does not like? Can 
you point me to the exact location where the access is made?

I am at least glad that you have backed off your assertion that my 
change does not fix the ioctl. I am sure if I keep pressing you, you 
will back off the panic claim as well. You yourself admitted you did not 
know why kasan was not panicing, Has anyone else hit the same panic?

If you can pin point the exact location where the illegal access is 
made, please do so and I will accept that I am wrong, other than that I 
am not interested in this constant back and forth with no technical 
details just fluff.

Shoaib

> 
>> Please note I am not pushing that my patch be
>> accepted, I have done what I am suppose to do, it is upto the
>> maintainers to decide what is best for the code.


