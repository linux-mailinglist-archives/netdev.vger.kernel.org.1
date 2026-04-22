Return-Path: <netdev+bounces-280438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFcjCcDb6GnOQwIAu9opvQ
	(envelope-from <netdev+bounces-280438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:31:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E17447454
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B1D7302D975
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE81E3ED5BB;
	Wed, 22 Apr 2026 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TUvPGgID";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BuRrDxSt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7FA282F35;
	Wed, 22 Apr 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868282; cv=fail; b=Edg9TROkpY/G4YByq+FAtWod+BE06ullxeQjN0VRFUhttY5g4BG3ps6QNms29o6Ncn+2JLMAhPcvqJau29k3ou93+OE6YwZgYdVfXHIzYqZ+YWs8VYREs0yMzQ3Eg5JNgwDaU/z/jIAfE46pE1iJDigcn325HFag8Tf20Es0YQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868282; c=relaxed/simple;
	bh=F1eSxwfArgnaxJgj3wGfOLOqg8zV5zMsBzgI56o7MkU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CdDROMhJNEp2K64B/D2UhsWPiJuVlMC2iPi0QgQ7FjVC7XzShigZu+13DYxEmPYydw52WbOzB04KSa9PKZjyCb7YbK4e4B1QQSnvuATk9q7z1LmqfTL6q+bT/SaRdGb0QcQmJAl1XNk8KWaKdSP5lWIpvf1skt9dZDDtoDLNg5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TUvPGgID; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BuRrDxSt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M8cGBb4137553;
	Wed, 22 Apr 2026 14:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VTfb3yy9gIyzMQsP0bh3WsCj4CVfXyCtuQJDgbyJ8+w=; b=
	TUvPGgID3/CUapYxPgC2Dzs7YzxeMhh0Td4NZAmmeI84xjUL/9KGd59+2rknioih
	ePAkDA2Dkr5wn9tOwLr0LNVPnHiW7A04dHuVmHqmIhwdbptAhMESbAjia916BKX/
	zFw7p1qvkydbosyv2ljmygUxk7b6/OSsZgx3oRK6maUVfsM6urARBi0MrqkNxIxf
	UUzVCmWicMg1VzaKmWG93xSq4KIHdrwhegrFXJa/tbjnPHr6ZGYt4K/0msqmbQ7B
	58iXBWdzg1iCS5EGAlOVAHGVj5PtxZxnhHY1uxCeOjogCVl1gpWeruzs04K0bd6H
	I76eKnpMCMHhCDrhk+WPzA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dpenmhhyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 14:30:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63MEQHCk006408;
	Wed, 22 Apr 2026 14:30:44 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dpjjqak7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 14:30:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIFlNTIlY7kuJmLUhZ8SCI563eWhYwiRh/TV2iRHw7g4QFCIJTeCwYg8VliQ5EGuSra9E40QmIzZ0D9F2KmKUuNHvAYqXkD18Duo/gc2c1LLmlE4KEfG0YsC+CGKT8B9qA+IS/dIn5FAbBlhFbWhJYjQeKviTqR4aqt+oY0WIU1bCRDwVRYDwWYJSNvMxO0JQ4ZwP/Y5L8Em/BYcMLsnFae+VPgPZTeVgphdJz8erk2ebLmD639kOJqevr3bSyHS0jPCsWqnTT9t9jEs4Vx0aK9XAg1IWNSDIaqqSKXBDeRaPXcW4/Gmyvqyin5Uu9vDsacl4IqqO5polp3tq3mYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTfb3yy9gIyzMQsP0bh3WsCj4CVfXyCtuQJDgbyJ8+w=;
 b=BFm03BFLmagztmkB+MqtmWqXTOKPwmt9Rb30QqH9WlNnXe8tLpgxHaReaI2wwxMq4mMi7l+Gui/nfj/XhiDEVtSRsaOhruRTPJ4kqz1RUx7rFgcxl6WpIkyFqQTw/gc2Df7ewatDuGeYqvtaH331kWBuz8642mkJNLsW7vCYeYkAsSzNQw64v0wgOBwXiFzISNIsVaHYeIAnN7LA/Y1CpoxcoK83588NuTl4HnFep6g92Gr3Rmb5qB5YK6wVSyiMKBNtaSXfY6mq9UfUse3upIAo1o3aR2hY2M8TVHuQVi3wvqwAmNY5SC7xNEz1vODe9gD0r3GNMVHK6U5pIkZCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTfb3yy9gIyzMQsP0bh3WsCj4CVfXyCtuQJDgbyJ8+w=;
 b=BuRrDxStL+O4W8aPzj00/v/jG6NU/3+CntlFU1WoffUoVYO0OWaXDJomWjfvNR+4UVVBBOsQHDd8ybluPGrbaAxlBmNAT7phIJv3XkigKKwhJMCyGkq9qbm5GDEzjwmTt49D4FvxLZqoP7nEJvzn/U3WEjCml1F4Rinx5X9CIcM=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by DS0PR10MB6221.namprd10.prod.outlook.com (2603:10b6:8:c1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.31; Wed, 22 Apr 2026 14:30:37 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 14:30:35 +0000
Message-ID: <dc0f3c46-32e0-411d-9e50-498cf9b05505@oracle.com>
Date: Wed, 22 Apr 2026 15:30:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: drop xdping tool
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Cc: ebpf@linuxfoundation.org,
        Bastien Curutchet <bastien.curutchet@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20260417-xdping-v1-1-9b0ce0e7adf8@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260417-xdping-v1-1-9b0ce0e7adf8@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::14) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|DS0PR10MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d1429d-f7de-460f-dce4-08dea07bb714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qztSXoH1WWl1xEyPv8trnf52gn3c5nUvVZJP+GOgJ6CvAzQPyMM+R072Ft5iF0oeXqI9IWFo9zMWxUWKr9ssTOmDUYnoPdmQ0OdOCocOecujdN0uXNEnc+sxjboDzE7celgysqucgqy9UM/hxMVtdSHUmgsHnUuU4J41tciEV4LOSVStZ/xtXvd7yshHDoJV+Q5GvyzmrGiuYH+snk3yCYLCrktDOTSCi1VI5IUCpkQIgVD2DWSmWGfLQ5jS7l03t7kMqfhqV9277U+7HFOC2DYxUZUmXxM/Y+pGXN6Hzyxbwebq4w6IsHovY1ulBOLCxJVREJHitkmWFr1Y3DoYR0nzkGTSdRDlHx14YrTDlNNrj3l3Duw2CFyC01mekJKOFiXP2TsVuJACHOzyKOzlr5/4CFvOPcvSAdtc7XI462Q/j99UtSR/YRPiFHIwy5FzuE6NCmT+oTWjjJMZngGMSnCBSbijfRRiUk11coq+Yib02xOAXjP0794U7SJ0Ra04W5q5QgEHnVwAI52FBtbMCuhecGn0rErSwINsMvr27WeZYt+Mj6jxx/tLoZaxPOok4o8PUdSqFG3yr7+ftd+X/LS/FYVoVHEBwWzO7YpK1NAkqKSi8k7RqKXm4LHiN7C0HHINCagnxdyV+2/An6qJVh4Q73lATaw1f/devGVy8Gdz7xhiqFOs02DHTBUjghS/9au83MZa5Ap8HiECqtAOdGu5VsxqtDQig1+Nhz6UZB3cW0TVq3HgTRXdjy2G0H8MIZiSUS/dpI02V4pvosXSTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1N0TjJUNmV1ajdWVmlhNzVzR2F2M0ZKbkNIUUVXSkVlYkN2Mm9jMVRRTFNZ?=
 =?utf-8?B?U3FHTkx4ejBvK001QkYwb1FBc3pMM3FTMEdQdEVkWmJyY2ZqM3ordlh2VThK?=
 =?utf-8?B?ZW5wUXcrRzlENnpZaWtBNnYvd1ZJT0Z5WU5xNHdaa29xOVQ4bVEwdW8zVjVJ?=
 =?utf-8?B?bDV1dk9ZL1RDODRKQVpUZ0FHV1drVDYvRFZSUmd2VzUvb1pJNTBLaFJuMmVB?=
 =?utf-8?B?WUVZNzE0K2RJS2NCM1dkTlJaQXJvcFVJV2pQVDFxencvVVlXWHQ3TnhndGQz?=
 =?utf-8?B?Q0xKb3FDcCtxZzloM2o2bTVtWkV0cHc0ZmNVaGFoYW9qWEZLRFRFYTdHN0FO?=
 =?utf-8?B?OWxiWGVJSlI4cloxN3dBOWx6MUVBdE4zVnNqVGdsMlY3b2pUQktoRFlENXFI?=
 =?utf-8?B?VkpaMEl3a1ZZQjJXejdzbkNhRURJbzZqQWpNcDlidWNRdHJ1dUtYVUJsUDVN?=
 =?utf-8?B?NTd6NWFKcExjQWxDeE5Fd0t6OHpiUGIwOFMrYjFjNlZMUnAvTG5sOWdUSTkz?=
 =?utf-8?B?dGJYNUtGQS9WSHM5UnBZUHVzU3dLamQ3Zk4xS0s3VmFobmwyQVREeUlmQ1lJ?=
 =?utf-8?B?UXQ0S1J5M1M3OTVQVEx0Nkc1S0xWODROaDF4MU0va0QzclFNUlB2TE41NnJj?=
 =?utf-8?B?NWJmUzU2MFYrMTl5VnBMQVpqTndmSEVJRmgxYWNwRUZ3Q3J5YWpMWHU0ZEdC?=
 =?utf-8?B?QnJ0alJMc0F4WkJqVGhHeGhsNXQwUWUzNXhDSUhISmlCRnZ2L2VpeGMvQ29X?=
 =?utf-8?B?RmtTSHhuTW1FM1RzcUNSUVowWkNVUk1MTm1rWVZ5a2pVeDE1YkNGRk9tajBI?=
 =?utf-8?B?UHh5Zm51Y3N2dm5TelFqUWlvOExoaVFFOXByV2p5by8ycXh1d3RzYzlpS1ZF?=
 =?utf-8?B?M2Zxb1NpNml2dEljRTVoRzhRRWs0YTRtSE9oK0NEVFBtRnFWelp6OHh3M20v?=
 =?utf-8?B?TGRRMG0yYVJoeTVIYmRlNkhKTks3Y3ZGWFpQVXg1bGJ6QjBEYUhoYXJoT0hq?=
 =?utf-8?B?SWwvVmpSdjFTWUxqMzJvQStTaVBIYnRSY05rREtLTjBNSmc0M1lPdVhSTDZQ?=
 =?utf-8?B?bENhdlFlTU9seW9KRWlIYVJlZ3VxWFFNQTBJaThMZHczSG1HeFZObG5yYlNn?=
 =?utf-8?B?Q3hoY2Rjck53a1ZScXZMTG11TW9hclJYRTNXMTRqTmFhZ2U0UjZHcGo5b3Jt?=
 =?utf-8?B?NjFDVWZGUjRLQXZ3eFEwSVF5QzJ1YXFCcEZoYVBsTHJjRlJkV2c5ZmxWTGpF?=
 =?utf-8?B?Mld6eUcvbFY3K01xNTkydWVwYW1ZbnVFbXlDRUFMbDk0RkQ4NUkydjVOYThJ?=
 =?utf-8?B?dURQYnJINERBMlptWmg3M1VqS0FuYzNIT3Bzd3ZqbWZZWm00UEN4YXhVcHFR?=
 =?utf-8?B?OFZrUjU0bmdFcENxaVFNVlVBSVlrbGZTa3lrZDF2NXRwTG5mNG5XUnE5c3dm?=
 =?utf-8?B?S3lGNGFKbXFISFZBRytLdjlENi9CVEdiSS9QMWc1eDhuNzJVVURUaE9FZjNJ?=
 =?utf-8?B?MmVEbFlEZi81Z3JkeFJtVkp6WW05dXUxV1hXR1U3Z1lVcUhsd0FaUkxiRkVO?=
 =?utf-8?B?VnpVUzF3MndidGgxblo5Vm9mSkhtME9Qd0hhMVpZcHlRVjFmN1YyM0VBTk5K?=
 =?utf-8?B?aEVRNGNVcU9BaExLU3ZPNkg2SXlrVTJ5VWpoOHY4Qm5JTWJGZWNLRWZFQlFx?=
 =?utf-8?B?eGJ6SXVtV2NoMkJ2RGNITmN5dzZvWmFndkxzU2h4RUFSRjFqZzNUd2ttM3RX?=
 =?utf-8?B?N2x4MHBKemMyckJmcEYwMkpUdHB3RlN6clNHVUs1MVpyMVM4dlkzVFdqeFpj?=
 =?utf-8?B?LzNpR3BwT2FPZFRBM05SMnRzSzM2WmVyVG85dE9DOUVRTnVEa0JZb3pjVFMz?=
 =?utf-8?B?WXRkMkdPallaUk91aDZCaUdvaVp1V3E1M2ZZL3ZCeDRPU0xzN3FuVzhPTytB?=
 =?utf-8?B?dSswUGYwVklmTFhmSkVheWgvZm93RjM2SHE1WXlyM1ZQczFxUDN6N2N2cXZD?=
 =?utf-8?B?VWt4bmY0ckdVVllzQ01vTmNJWHp6elU5cWN1WEN6TXdiYmJiZWJYSmFtZW4v?=
 =?utf-8?B?MktjT1pZUk41NzRrY290WFkvQk90b3hoNnMxTTJzdW52MncyMGZhVGliNEp2?=
 =?utf-8?B?UGsxbjNlaFZCQVpBLy9YL0lEN2NtL0Zva0M5RTlleXpteUtEa05rc3NFNVVJ?=
 =?utf-8?B?Yy94UmEyaTBhQURLM3hlUnZyMkVvTXh1SXBUWWpneFBKSlNVSmNRUlQwMFpF?=
 =?utf-8?B?aTlNWlhXV1hnL0Z4VnQ1Q0hZUkJYeEpGTzlvWUs4OFE5ZDUwTmlJUEFsYTNK?=
 =?utf-8?B?VW92eDBWaXBOaTBtR2NpUUJLYnYrMW1YT1BQS282U1NHeGlvdHA4UT09?=
X-Exchange-RoutingPolicyChecked:
	BblD35iHRde+vcJFM0ViJjxe9h1JCJwmeV82nSr+8uBoVf8B3uzQdlUA5VxRNTtke7w5lnICrCwp93px3Fumhj/LuPCsxWtg9QfbuRkE3d+oXJmdU67MuYpn2SO8zRPuW6S6KLNYUjHfOLlfwHGBg5yx0nA46C8NLymjE6Crf5ZG5oGUAT9Wiw9Lj/nve0xIXlr86MllMvFDPfvI2nQl6Z+vBoTL7EjEKmdub48ziceWYHDBAyY/4o6mZc/dEumqGWqBUcY3NrqIzuvUZEHAYB6CaBOScCKmAoZPQHhhM6YqhDGyCqJXCwDj91rEZe2rmV3KL6jzrUSsWk8ts3BjQA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SfkI+8iC3VoO/0FSs5gXzBTXkk+L3nFDZI0xkYxWHXXaqyZ1s6ODzemcQn+5ZIUr9pZubClXGBPoz6kMcyHcSJa8Ef0ORfVE8FcEkdfch39QJm8Dxvr9zVbRvBUuC8poDbSY+5kvGs/MDWSW2+ji3seTfKSiZhWw8w/84hXsLgEqH452pmqcXdbXDPD6Eun/YyxL/6M1UGX7CzL0+kO/XSTiYyb+mAWEBxkWi9+QvjARt0rQOhIqkaFY2s3DUNy9OJgZ3ELhXPhWpenMYKw/bZlEP0Zngl5UR0EvdIIWQAHwDCL3Snmw7gN1mdUtBTaaUi3hu/qm7ye1wcK62vLBhp+U+KOHl6POuuZM+0lF6awawO1kD1cQ4zOPEIAhEqxdD4eFBGcYGotWMfTaI/OfFGDsLEoVnTeLH0T64n1fyIyTjYFkX+4mo0KuvM+Ttjcge6ay1vx6nHQCbl+BDqiGt3DWAaUTMqxieqYvuXGyDuDw+gnSVf8r9d1JVZRKXmMr0GSY7JSXF8Uibo0f3M/iNiim/OeIbGl0X6GhEFNEZzOHrhbecqtQUStRzFPyq06Ud0yFVC/m+ncY6QkMEnUbWIusw+ZpjFAOETUeG3S125Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d1429d-f7de-460f-dce4-08dea07bb714
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 14:30:35.8083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhDCN2M4Z8A6AdeFjn88//fwN5ATLm59ga9eA4fzjmAsjnDhmva+BRVlyvJx89yi9CpTXq57dxPXIbhDdGZIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604220140
X-Authority-Analysis: v=2.4 cv=PsSjqQM3 c=1 sm=1 tr=0 ts=69e8db95 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=P-IC7800AAAA:8
 a=yPCof4ZbAAAA:8 a=t87xYJWwnkHo3Geu_Q8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22 cc=ntf awl=host:12291
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE0MCBTYWx0ZWRfX4WAS+R7ux9EL
 UHeYRxmS9+wCLaT6AH7t4t2kT1pJdB0h+9R3YZO9YQQcfUiEvNZV9n5utwDHtS3dUtqj61AfrBo
 j9CRMP99Hf3ikPN+rOUcbmd7IcVbGDioR5Ti9LW9I2XiBIx6oERfLWmdMUgaZlQc2V4PIzNPLcD
 R70DOV47KCvenkQBg9vVDR+kOolcIWx8q0xbmiJ4/DwPfIW5E09ZT6D4nSh2ZmHLFxzcdRwOxP3
 xoTs2CiP8R+8oepzCMv4yYAymc3kLQPHg4TjbOV7AcexCl6K7J/meWePgNum8HDMz/FHSSH3MyL
 YJXfyGKNW8sbRElcahA8v016q52jSKmKF0sAR/zfizghSqtHQARXh1sre0Og0mq84D+m02s4hWq
 i+pVuu256U5uWkqsfJMkOJAgB1bqqoretmwAhlehib71+3671jEnKswBFKLKIB4BAGyLK1zmoFV
 99kbXisB4jHNFLl+TLOYdHxa0gAci304aJAZOe4E=
X-Proofpoint-GUID: YXvcjbI5SKRZueYB_GnEY4Ywv1h79fW2
X-Proofpoint-ORIG-GUID: YXvcjbI5SKRZueYB_GnEY4Ywv1h79fW2
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280438-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,kernel.org,gmail.com,iogearbox.net,linux.dev,davemloft.net,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,oracle.com:email,oracle.com:dkim,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,test_xsk.sh:url,test_kmod.sh:url,test_xdping.sh:url,xsk_prereqs.sh:url,test_doc_build.sh:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alan.maguire@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 89E17447454
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17/04/2026 16:33, Alexis Lothoré (eBPF Foundation) wrote:
> As part of a larger cleanup effort in the bpf selftests directory,
> tests and scripts are either being converted to the test_progs framework
> (so they are executed automatically in bpf CI), or removed if not
> relevant for such integration.
> 
> The test_xdping.sh script (with the associated xdping.c) acts as a RTT
> measurement tool, by attaching two small xdp programs to two interfaces.
> Converting this test to test_progs may not make much sense:
> - RTT measurement does not really fit in the scope of a functional test,
>   this is rather about measuring some performance level.
> - there are other existing tests in test_progs that actively validate
>   XDP features like program attachment, return value processing, packet
>   modification, etc
> 
> Drop test_xdping.sh and the corresponding xdping.c userspace part. Keep
> the ebpf part (xdping_kern.c), as it is used by another test integrated
> in test_progs (btf_dump)
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

as discussed, switching to loading xdp_dummy.bpf.o in prog_tests/btf_dump.c 
would be good too (feel free to retain the Reviewed-by: with that v2 change).

Thanks!

 
> ---
>  tools/testing/selftests/bpf/.gitignore     |   1 -
>  tools/testing/selftests/bpf/Makefile       |   3 -
>  tools/testing/selftests/bpf/test_xdping.sh | 103 ------------
>  tools/testing/selftests/bpf/xdping.c       | 254 -----------------------------
>  4 files changed, 361 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index bfdc5518ecc8..986a6389186b 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -21,7 +21,6 @@ test_lirc_mode2_user
>  flow_dissector_load
>  test_tcpnotify_user
>  test_libbpf
> -xdping
>  test_cpp
>  *.d
>  *.subskel.h
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 78e60040811e..00a986a7d088 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -111,7 +111,6 @@ TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
>  # Order correspond to 'make run_tests' order
>  TEST_PROGS := test_kmod.sh \
>  	test_lirc_mode2.sh \
> -	test_xdping.sh \
>  	test_bpftool_build.sh \
>  	test_doc_build.sh \
>  	test_xsk.sh \
> @@ -134,7 +133,6 @@ TEST_GEN_PROGS_EXTENDED = \
>  	xdp_features \
>  	xdp_hw_metadata \
>  	xdp_synproxy \
> -	xdping \
>  	xskxceiver
>  
>  TEST_GEN_FILES += $(TEST_KMODS) liburandom_read.so urandom_read sign-file uprobe_multi
> @@ -320,7 +318,6 @@ $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELP
>  $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_tag: $(TESTING_HELPERS)
>  $(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
> -$(OUTPUT)/xdping: $(TESTING_HELPERS)
>  $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
>  $(OUTPUT)/test_maps: $(TESTING_HELPERS)
>  $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
> diff --git a/tools/testing/selftests/bpf/test_xdping.sh b/tools/testing/selftests/bpf/test_xdping.sh
> deleted file mode 100755
> index c3d82e0a7378..000000000000
> --- a/tools/testing/selftests/bpf/test_xdping.sh
> +++ /dev/null
> @@ -1,103 +0,0 @@
> -#!/bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -
> -# xdping tests
> -#   Here we setup and teardown configuration required to run
> -#   xdping, exercising its options.
> -#
> -#   Setup is similar to test_tunnel tests but without the tunnel.
> -#
> -# Topology:
> -# ---------
> -#     root namespace   |     tc_ns0 namespace
> -#                      |
> -#      ----------      |     ----------
> -#      |  veth1  | --------- |  veth0  |
> -#      ----------    peer    ----------
> -#
> -# Device Configuration
> -# --------------------
> -# Root namespace with BPF
> -# Device names and addresses:
> -#	veth1 IP: 10.1.1.200
> -#	xdp added to veth1, xdpings originate from here.
> -#
> -# Namespace tc_ns0 with BPF
> -# Device names and addresses:
> -#       veth0 IPv4: 10.1.1.100
> -#	For some tests xdping run in server mode here.
> -#
> -
> -readonly TARGET_IP="10.1.1.100"
> -readonly TARGET_NS="xdp_ns0"
> -
> -readonly LOCAL_IP="10.1.1.200"
> -
> -setup()
> -{
> -	ip netns add $TARGET_NS
> -	ip link add veth0 type veth peer name veth1
> -	ip link set veth0 netns $TARGET_NS
> -	ip netns exec $TARGET_NS ip addr add ${TARGET_IP}/24 dev veth0
> -	ip addr add ${LOCAL_IP}/24 dev veth1
> -	ip netns exec $TARGET_NS ip link set veth0 up
> -	ip link set veth1 up
> -}
> -
> -cleanup()
> -{
> -	set +e
> -	ip netns delete $TARGET_NS 2>/dev/null
> -	ip link del veth1 2>/dev/null
> -	if [[ $server_pid -ne 0 ]]; then
> -		kill -TERM $server_pid
> -	fi
> -}
> -
> -test()
> -{
> -	client_args="$1"
> -	server_args="$2"
> -
> -	echo "Test client args '$client_args'; server args '$server_args'"
> -
> -	server_pid=0
> -	if [[ -n "$server_args" ]]; then
> -		ip netns exec $TARGET_NS ./xdping $server_args &
> -		server_pid=$!
> -		sleep 10
> -	fi
> -	./xdping $client_args $TARGET_IP
> -
> -	if [[ $server_pid -ne 0 ]]; then
> -		kill -TERM $server_pid
> -		server_pid=0
> -	fi
> -
> -	echo "Test client args '$client_args'; server args '$server_args': PASS"
> -}
> -
> -set -e
> -
> -server_pid=0
> -
> -trap cleanup EXIT
> -
> -setup
> -
> -for server_args in "" "-I veth0 -s -S" ; do
> -	# client in skb mode
> -	client_args="-I veth1 -S"
> -	test "$client_args" "$server_args"
> -
> -	# client with count of 10 RTT measurements.
> -	client_args="-I veth1 -S -c 10"
> -	test "$client_args" "$server_args"
> -done
> -
> -# Test drv mode
> -test "-I veth1 -N" "-I veth0 -s -N"
> -test "-I veth1 -N -c 10" "-I veth0 -s -N"
> -
> -echo "OK. All tests passed"
> -exit 0
> diff --git a/tools/testing/selftests/bpf/xdping.c b/tools/testing/selftests/bpf/xdping.c
> deleted file mode 100644
> index 9ed8c796645d..000000000000
> --- a/tools/testing/selftests/bpf/xdping.c
> +++ /dev/null
> @@ -1,254 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/* Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved. */
> -
> -#include <linux/bpf.h>
> -#include <linux/if_link.h>
> -#include <arpa/inet.h>
> -#include <assert.h>
> -#include <errno.h>
> -#include <signal.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <unistd.h>
> -#include <libgen.h>
> -#include <net/if.h>
> -#include <sys/types.h>
> -#include <sys/socket.h>
> -#include <netdb.h>
> -
> -#include "bpf/bpf.h"
> -#include "bpf/libbpf.h"
> -
> -#include "xdping.h"
> -#include "testing_helpers.h"
> -
> -static int ifindex;
> -static __u32 xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
> -
> -static void cleanup(int sig)
> -{
> -	bpf_xdp_detach(ifindex, xdp_flags, NULL);
> -	if (sig)
> -		exit(1);
> -}
> -
> -static int get_stats(int fd, __u16 count, __u32 raddr)
> -{
> -	struct pinginfo pinginfo = { 0 };
> -	char inaddrbuf[INET_ADDRSTRLEN];
> -	struct in_addr inaddr;
> -	__u16 i;
> -
> -	inaddr.s_addr = raddr;
> -
> -	printf("\nXDP RTT data:\n");
> -
> -	if (bpf_map_lookup_elem(fd, &raddr, &pinginfo)) {
> -		perror("bpf_map_lookup elem");
> -		return 1;
> -	}
> -
> -	for (i = 0; i < count; i++) {
> -		if (pinginfo.times[i] == 0)
> -			break;
> -
> -		printf("64 bytes from %s: icmp_seq=%d ttl=64 time=%#.5f ms\n",
> -		       inet_ntop(AF_INET, &inaddr, inaddrbuf,
> -				 sizeof(inaddrbuf)),
> -		       count + i + 1,
> -		       (double)pinginfo.times[i]/1000000);
> -	}
> -
> -	if (i < count) {
> -		fprintf(stderr, "Expected %d samples, got %d.\n", count, i);
> -		return 1;
> -	}
> -
> -	bpf_map_delete_elem(fd, &raddr);
> -
> -	return 0;
> -}
> -
> -static void show_usage(const char *prog)
> -{
> -	fprintf(stderr,
> -		"usage: %s [OPTS] -I interface destination\n\n"
> -		"OPTS:\n"
> -		"    -c count		Stop after sending count requests\n"
> -		"			(default %d, max %d)\n"
> -		"    -I interface	interface name\n"
> -		"    -N			Run in driver mode\n"
> -		"    -s			Server mode\n"
> -		"    -S			Run in skb mode\n",
> -		prog, XDPING_DEFAULT_COUNT, XDPING_MAX_COUNT);
> -}
> -
> -int main(int argc, char **argv)
> -{
> -	__u32 mode_flags = XDP_FLAGS_DRV_MODE | XDP_FLAGS_SKB_MODE;
> -	struct addrinfo *a, hints = { .ai_family = AF_INET };
> -	__u16 count = XDPING_DEFAULT_COUNT;
> -	struct pinginfo pinginfo = { 0 };
> -	const char *optstr = "c:I:NsS";
> -	struct bpf_program *main_prog;
> -	int prog_fd = -1, map_fd = -1;
> -	struct sockaddr_in rin;
> -	struct bpf_object *obj;
> -	struct bpf_map *map;
> -	char *ifname = NULL;
> -	char filename[256];
> -	int opt, ret = 1;
> -	__u32 raddr = 0;
> -	int server = 0;
> -	char cmd[256];
> -
> -	while ((opt = getopt(argc, argv, optstr)) != -1) {
> -		switch (opt) {
> -		case 'c':
> -			count = atoi(optarg);
> -			if (count < 1 || count > XDPING_MAX_COUNT) {
> -				fprintf(stderr,
> -					"min count is 1, max count is %d\n",
> -					XDPING_MAX_COUNT);
> -				return 1;
> -			}
> -			break;
> -		case 'I':
> -			ifname = optarg;
> -			ifindex = if_nametoindex(ifname);
> -			if (!ifindex) {
> -				fprintf(stderr, "Could not get interface %s\n",
> -					ifname);
> -				return 1;
> -			}
> -			break;
> -		case 'N':
> -			xdp_flags |= XDP_FLAGS_DRV_MODE;
> -			break;
> -		case 's':
> -			/* use server program */
> -			server = 1;
> -			break;
> -		case 'S':
> -			xdp_flags |= XDP_FLAGS_SKB_MODE;
> -			break;
> -		default:
> -			show_usage(basename(argv[0]));
> -			return 1;
> -		}
> -	}
> -
> -	if (!ifname) {
> -		show_usage(basename(argv[0]));
> -		return 1;
> -	}
> -	if (!server && optind == argc) {
> -		show_usage(basename(argv[0]));
> -		return 1;
> -	}
> -
> -	if ((xdp_flags & mode_flags) == mode_flags) {
> -		fprintf(stderr, "-N or -S can be specified, not both.\n");
> -		show_usage(basename(argv[0]));
> -		return 1;
> -	}
> -
> -	if (!server) {
> -		/* Only supports IPv4; see hints initialization above. */
> -		if (getaddrinfo(argv[optind], NULL, &hints, &a) || !a) {
> -			fprintf(stderr, "Could not resolve %s\n", argv[optind]);
> -			return 1;
> -		}
> -		memcpy(&rin, a->ai_addr, sizeof(rin));
> -		raddr = rin.sin_addr.s_addr;
> -		freeaddrinfo(a);
> -	}
> -
> -	/* Use libbpf 1.0 API mode */
> -	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
> -
> -	snprintf(filename, sizeof(filename), "%s_kern.bpf.o", argv[0]);
> -
> -	if (bpf_prog_test_load(filename, BPF_PROG_TYPE_XDP, &obj, &prog_fd)) {
> -		fprintf(stderr, "load of %s failed\n", filename);
> -		return 1;
> -	}
> -
> -	main_prog = bpf_object__find_program_by_name(obj,
> -						     server ? "xdping_server" : "xdping_client");
> -	if (main_prog)
> -		prog_fd = bpf_program__fd(main_prog);
> -	if (!main_prog || prog_fd < 0) {
> -		fprintf(stderr, "could not find xdping program");
> -		return 1;
> -	}
> -
> -	map = bpf_object__next_map(obj, NULL);
> -	if (map)
> -		map_fd = bpf_map__fd(map);
> -	if (!map || map_fd < 0) {
> -		fprintf(stderr, "Could not find ping map");
> -		goto done;
> -	}
> -
> -	signal(SIGINT, cleanup);
> -	signal(SIGTERM, cleanup);
> -
> -	printf("Setting up XDP for %s, please wait...\n", ifname);
> -
> -	printf("XDP setup disrupts network connectivity, hit Ctrl+C to quit\n");
> -
> -	if (bpf_xdp_attach(ifindex, prog_fd, xdp_flags, NULL) < 0) {
> -		fprintf(stderr, "Link set xdp fd failed for %s\n", ifname);
> -		goto done;
> -	}
> -
> -	if (server) {
> -		close(prog_fd);
> -		close(map_fd);
> -		printf("Running server on %s; press Ctrl+C to exit...\n",
> -		       ifname);
> -		do { } while (1);
> -	}
> -
> -	/* Start xdping-ing from last regular ping reply, e.g. for a count
> -	 * of 10 ICMP requests, we start xdping-ing using reply with seq number
> -	 * 10.  The reason the last "real" ping RTT is much higher is that
> -	 * the ping program sees the ICMP reply associated with the last
> -	 * XDP-generated packet, so ping doesn't get a reply until XDP is done.
> -	 */
> -	pinginfo.seq = htons(count);
> -	pinginfo.count = count;
> -
> -	if (bpf_map_update_elem(map_fd, &raddr, &pinginfo, BPF_ANY)) {
> -		fprintf(stderr, "could not communicate with BPF map: %s\n",
> -			strerror(errno));
> -		cleanup(0);
> -		goto done;
> -	}
> -
> -	/* We need to wait for XDP setup to complete. */
> -	sleep(10);
> -
> -	snprintf(cmd, sizeof(cmd), "ping -c %d -I %s %s",
> -		 count, ifname, argv[optind]);
> -
> -	printf("\nNormal ping RTT data\n");
> -	printf("[Ignore final RTT; it is distorted by XDP using the reply]\n");
> -
> -	ret = system(cmd);
> -
> -	if (!ret)
> -		ret = get_stats(map_fd, count, raddr);
> -
> -	cleanup(0);
> -
> -done:
> -	if (prog_fd > 0)
> -		close(prog_fd);
> -	if (map_fd > 0)
> -		close(map_fd);
> -
> -	return ret;
> -}
> 
> ---
> base-commit: b7fb68124aa80db90394236a9a4a6add12f4425d
> change-id: 20260417-xdping-5c2ef5a63899
> 
> Best regards,
> --  
> Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> 


