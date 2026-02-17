Return-Path: <netdev+bounces-259106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLEUCZGelGmrFwIAu9opvQ
	(envelope-from <netdev+bounces-259106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:00:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5526114E75F
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D44B5300639A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5A536EABF;
	Tue, 17 Feb 2026 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gful6FzA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YZH9PpvD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C748D36F409;
	Tue, 17 Feb 2026 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347597; cv=fail; b=bRCb9keK59weOrPc7irZ4jbPJ8g485fu/bw9arVelfMi8+G3vsWxYgUf6qZoFgsfSOPVusFO84c5NCinsb8sTYCFOkKPPQK955guhUtpjP6L7s19UwIHkkKdYqu5fEaX3tDN3+u84xjL7zEXwRapWQNiO/4T4zb80GaNXxZbeW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347597; c=relaxed/simple;
	bh=IC2zNNFxPS9YnhqDLNPQLUSENkI+yeYZv/dMma+iCCw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ER3dK+6rSwc/9jEIlNgNCQ5CGp2/KJxa15PrlkjipzjljyZ80OnEFstqzy42T8buyQH3RWFe2HyeuU9i4UVgOESE0fntoLeidFabWJBHoxO08OnNciWcgRVgt4oxaIrJwAcSnLBLmeUTXR8zSFvfIvj3aV6NGe2HevZUxzJVT5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gful6FzA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YZH9PpvD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HGNWBg495512;
	Tue, 17 Feb 2026 16:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RKo86YCdBLVws67zcBaSL9yAp4Z7TiPw5Hnz6ToaTzM=; b=
	gful6FzAh37hUOFE1rXiuZvfDobn6IeEvUdBUAWJueajn7HO19yjS95h5ypuFOph
	q26SwnzdAEP0tol7N4L9RGOxaVq9cKXZJo4W7uEZIwX63+dN14zKSJcgzrI+g80Z
	Fea0yG5ESbTD69T9xuDm3uwAaqRzIgxRJkKTetJHra9fdqKCRedxPSHpOpTa5yOh
	fgm1RGRhLfDZKqtbjOOHIGDtCe/ptfYWQDIBeZFrBuW8sR2Zi+pdikgSN1NV8OAj
	AnDQ748XCQvg1+9jTNJHU7WUP8lQvyWJ6fYNvoxHpyAToXJXvDQcUu20mGeTF1u8
	xi7cATmCA1otdmUwpQwXRg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj6mbxy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 16:59:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61HGDsEe037780;
	Tue, 17 Feb 2026 16:59:43 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012050.outbound.protection.outlook.com [40.107.200.50])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb1yyx35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 16:59:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeltrqwzgL76JVvmKU6KyBn3PuKzyeZdHgV4OyiWf8am7EKwwN+PzCDBTk2V3T+0hKIb+WsFZGZ7knEnSGtgGzQ5634Gx9UR0uhKqbOonDrjIo0zeZZ95KxvHclMnDPckCGnRIwcbLEC9V8aT1ltYBs9VorIiijfNRJJIw9EB5C0XJ0azXrIhNQGOjpLYSHO+cKGTSv9CAwpqUnU+jh3pqf3T4e97F3kDMSPlVF4+wgrszcyGIPa60CQo1qxqW3oRLnHbBrqy89onBkeG3QBwQPtfG/jFewmw04vAck80KL7EB5/KHF0VNuHZ1LokwfYWOn3EZKuYJ0xGLMnItFK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKo86YCdBLVws67zcBaSL9yAp4Z7TiPw5Hnz6ToaTzM=;
 b=Zv+e0jp0ICVJJ3t+ppeksP9CapngFfZlzDOo/3UHpu7L+6etwKOGUEzjm/1g7iDk0SdzYwuYcKJSv66TbEnYkQ5y53Byzo02hNNnHfv4HkNLodWA7QK5dae9D/n+o4rlqG3Lk0a4Av9fkdF6/nhKnUYXdUU3PHqLM7hJh6tMS+aGJVzcFUA5A8zbKyKEfBpX5z2mUuzhOHRj9ww66dYvIegfIPldvJJ24GTb60h1wEQDc3hkJ9Jpo6IhTJeLafki6gDFkJ0qrragU5//Q59E4/09bqH+3pM+F7Qwu8ZfYW8RIRlhAJDSLJaTdo7snof8fGVUe+jR9yhElthIW1uNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKo86YCdBLVws67zcBaSL9yAp4Z7TiPw5Hnz6ToaTzM=;
 b=YZH9PpvDsh2vjpqwiIS+Ppn8b/689Kvhe4zOhoL0uJ2fLsC5CArQBTdf6Vro4DZchZoEBETixyZ5cRKbPRdke52gjusokD1NDtBTR5d04FYRw+cYTqKZVH+GtC+NoUtXv+5ZI/zDjQ2QXEmLLtwd4x5LCQrsShhA8+Vwn0IgCJ4=
Received: from IA1PR10MB6050.namprd10.prod.outlook.com (2603:10b6:208:38a::16)
 by PH0PR10MB7026.namprd10.prod.outlook.com (2603:10b6:510:289::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 16:59:36 +0000
Received: from IA1PR10MB6050.namprd10.prod.outlook.com
 ([fe80::645a:f184:3a35:ef9f]) by IA1PR10MB6050.namprd10.prod.outlook.com
 ([fe80::645a:f184:3a35:ef9f%4]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 16:59:36 +0000
Message-ID: <db06aa20-ca31-4b66-9a53-e4305974d1f5@oracle.com>
Date: Tue, 17 Feb 2026 08:59:33 -0800
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
From: Gerd Rausch <gerd.rausch@oracle.com>
In-Reply-To: <c57f2565-a6b2-45dd-8307-871a02ae1a7a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To IA1PR10MB6050.namprd10.prod.outlook.com
 (2603:10b6:208:38a::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB6050:EE_|PH0PR10MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: b67ec688-10eb-432c-7667-08de6e45ee56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVlTbmpiaG5jTXB4NXlpaExqMVR5dFd0MlpvT3FpZHhkVFFuSEV2UGRzMVJP?=
 =?utf-8?B?M28yM25LcWlLRkI3UjZRSlBBOW95UXdiaEpwbkh3eDVta2RIYzJTQlVZNkxT?=
 =?utf-8?B?ZjZkdi8yTmhRMHkvMXVib3VWYkdsbDFIUVZ2WTJ2L0hMTEdBWjJEcE0rNDV2?=
 =?utf-8?B?ODM1aXJ0eUFtV2JBeUNyNjJIcXNRTkNJZjRZSW85VU1JWDVEOGRhYkl6S25j?=
 =?utf-8?B?V3h5WnpxZ290NnNwY1ZSNXMySTR1eFZSVG13Z05QMWZYd3BJSWJzOXFuQVg1?=
 =?utf-8?B?TzlHRUJqbXZNVFUwVmJQUCtBRkNqNVFyUGlZYVlrTVJxRmZ6MkFuc3VVMDlK?=
 =?utf-8?B?bExJTEpDcUl4UXJ6dVBnRjZnU28yTndFQmdhemtVdVNwUW1qMnpyNEg0cFQ3?=
 =?utf-8?B?cXY2djg1L0VzRm1EcldENm5WbDVwa2RIMzVyZWN0dXVrMG9DRVU4SlZTUGVZ?=
 =?utf-8?B?Nmp3VEtsbUNwaC9UWTdMQmJvZFhIVGFaUENoSTlXNUFSclFPcXc5ajFocDht?=
 =?utf-8?B?bzFzYTQzTGs1UnMwMXJyK2M3ck1GbTJjNDNCSTJEdUtIMWcvT1crSTZZc3BL?=
 =?utf-8?B?YnRKQW95aFY1NHNSQ01pQzhvSENUSDc3WWpEckxKeDFXMzNBaFhyRG1iYU1n?=
 =?utf-8?B?ZVk2MUhqbUEwejZibnA1VzJUK3dxY2YxU2hYUWRHZytiNjVHVXdwSkkyVnQ4?=
 =?utf-8?B?VXplL2ZzOEtCWCt0OHMxdVdwRmNodFM1MmlYK1JGZEtzcTc5VlFGaC91ZUkr?=
 =?utf-8?B?TW50b1V0ZjJLUWJPeDlrOW5FRms0SGRFUnFveE80SE1VT01tZklVSGtoVldx?=
 =?utf-8?B?Z1puUVc0V0xLaE91NHhtK0JDaVRRZnVWVTY1ano5WVVSdFRDL0lvOUNuYmZC?=
 =?utf-8?B?dmlUdUIzVkREdTVWUFB0SUhLVFVrN29NUHhTUEpPSFozNU4wRTMvSXVVdUZL?=
 =?utf-8?B?Tzhpc29vWUdaeUVFTVZ6cVBNb0ZpenYrbFhaM1pJbTZBei9rQkhyWDBOVWtn?=
 =?utf-8?B?dnZ0bDNqSXlLVjlOK3o2Nmw3bjZnT09HUEE0elAzaSs3RzNmdzB1ZG5wNkYr?=
 =?utf-8?B?N2FyT1d5d2ZnK2RaTzl5SjArUUxocWdmdmdadWpwU2ptWnJIWC9ydzlmY1JI?=
 =?utf-8?B?V0tYSktCby9oWXRJWStvUE5HV1RLR3J4QWZXVDVERWhWUnQ1M2I1UVJGeXRl?=
 =?utf-8?B?OVNnMW5iRm1INTJrRCtSZWJFZExQajdjT1kyVVFWa3R2cEdDc0FuelVhUDJq?=
 =?utf-8?B?ZSt0KzRYTWprbUI5RysremdUaWdybEtiTHdJdEZ5eXpQbFJ4MW1FclljK0xJ?=
 =?utf-8?B?aU0rdFh1TmlYTnZqemc5M3YrVDY3NmZmbVVncEVwZ3NVNzVGY0p5R3Y3SW5u?=
 =?utf-8?B?dno1bjJOekcxajk4SWRQMFN2d3NwcWNYZnJaU0dvdGZBVEJ1YTQrRkpwWXAy?=
 =?utf-8?B?MTBTMXJ4UGRTdVBVbDYwNGl0eEhhMW1pQkVzWTJhNEN4YWhHVzliLzZEY1c1?=
 =?utf-8?B?OU9Qc3hVQnBCbC9rTWpaejBmR1I2MGFjK1U3T2lqWjBsYzNDVWsyWjRuWjdi?=
 =?utf-8?B?cmVBeEZpZlhocmRMT000bFozTVdSOXMvTjdwcHo4SkJ3SlNYdTFCTDNWdHNS?=
 =?utf-8?B?ZjNLRjlHR0tHRk1iVmx3WlZWRmU1OVBSRHpucWhGdkRKQVdBdWEvL1ZTRzIx?=
 =?utf-8?B?MUY5ZHAvSUNyREZaWVdTNW1mT3NpYkk1aWRaQ1kxRFNNcU1lcW5RcXJuZEMw?=
 =?utf-8?B?UkozWU5DcWdEMERJeDVzSHIzMk9VVGE3VC9xd0RXdWdTL3JUbDNUMVNoM01X?=
 =?utf-8?B?QVFXL1RtcGNDemtiWENYbTE0YXM3MzR3d2MzZ0R6VmUwK0k3SlN4TEFPS0dS?=
 =?utf-8?B?QXF2Z1BUVUlxYzRkSXVPWHNEZWdsakltb2FmbUJpclVEYndxRk5taXRPdUdw?=
 =?utf-8?B?eEsrRlJYamlnOHp5SnVidWNrZmhOWDFrL3B4OCs5SzVaRGl4QjZsRUZ4VVpW?=
 =?utf-8?B?WStwL3BhQ2pDV2FPazNjQmJacVlWRjk2eDZUTUVpMmk3SlhXQktwQTFJWFQ1?=
 =?utf-8?B?ZFp5UHpLR2wwVHZDZ01EWmIzQVNEdUFTQTF4OWFEZnZoM1E4NVZyaU5vclVO?=
 =?utf-8?Q?bp0Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB6050.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkptU2xuRndlVnBOc1l2NmlWNnNNeXFsTFdQTTE1VUhoQ1dBUGI4Q2tub1N0?=
 =?utf-8?B?Z214dEZ2RGkvbXc3K0xhd04za0c0YVY3TmMyajNISmlKTWIxZ3RoWDU2amkx?=
 =?utf-8?B?eHUvcUpTMFdrdFkvWjFNZXRWUkJqQXlDeEV4em5STURlL2t3bmRDWXFCUCtm?=
 =?utf-8?B?eDFQUjlZOVhubWRvcFE4dlFLYy9UZVdkQTdZNzgvSnJTQ2d6ZHJ0dHo0NTFj?=
 =?utf-8?B?ZVRoVHJTUXMwdzBQTjZSU2p1NTdlemUyMUYyeGoxZHI1b2FGMU52SFVtQSti?=
 =?utf-8?B?RTErNEEweG8rc3hzZUNEVmwraDUyeFFTTW5NRWVIWE9mSy95RmRpZzM5Ly9G?=
 =?utf-8?B?aERJQjdsbTEvbTUzckM4V1JYREZjTXBmOVhIS3pLL2cxTEdpTy8xMDdnSHdm?=
 =?utf-8?B?SnpRTzN4ajM0VklKMmJvMThiSlVjbVhybkYwNmVnT1dWMzcwTnVST2Y0NEQ5?=
 =?utf-8?B?NnluanVhdlpsQ1ltQ1VtQktuaFJHOTVYTDRjR08rUHVsOUhQK2hZSHZTdDFR?=
 =?utf-8?B?RTZXRUIxcS92NlIxOFpVL1BzRmltU2hnK1RMeFlHaG9TRWg1cVRyeStiOWF6?=
 =?utf-8?B?a1dKbXYyY1VsQS9BYmZkNzRrMEEyV1RCUWovOHhVcHhZaFdhMmp0U1FieDV4?=
 =?utf-8?B?Zjd3ajZsZ1hRT3piWldyQkFCVU15SktoT2p1Z1VwSDd4TWtCV1FVbWpHUEFy?=
 =?utf-8?B?Q01PUnczM2pIVXlGNWsyQUVwMzRmNzlWWEV3MGloampMbUNxVEFTV0dKVDNH?=
 =?utf-8?B?bEovSmF5K1E1UDRmMU81V01nQ0dZeEtJVmNtTVQzL2tJbUdqVWw3UlAzWWth?=
 =?utf-8?B?TEZ2MlNod1kwVi9wRGJ0YTFYYmN1TjF1RzA2T3BGOWpUNVdRSnZJOTNUZnBi?=
 =?utf-8?B?a0l5MlZoY1ErWTFwazYrTnIyZ00wOTMvWnlrdlRzTHV5d2Q3NCtmby9pUzk2?=
 =?utf-8?B?ZVVsc1VicnE0SC9hVU5oTWlTWUwyZjZuRGxDNitqWDhqOFBYRFZnd1BYVEhu?=
 =?utf-8?B?d0Y1UUQ2WTkrR1M3Y0Q5cUMrckt3S2wzamtKRDB3SFFIT3pPeks5YVE3VVlt?=
 =?utf-8?B?T0dET0tibFZPNW9reFB5V3pnN3NBYzF1UEc3NUtPV1M2V3RIQmN4ZnZHQ20v?=
 =?utf-8?B?ZXNDeVpRb3hIUFhqVUYrNnQ2VmZhSmlDYXZKWlhNc3N0Q2R2NC9mQWwva29o?=
 =?utf-8?B?TVQyTy9ZT05KZnl6WVJnbzQxcWV6bjIvL2R6T3RlWXlaNzZGdW5QdXBnSmlz?=
 =?utf-8?B?NXM5SnpQQ0VMVnVTdHRNQms4WUYzOGF2UktKT0twOEdHVmJmWWdYVWoyZGRC?=
 =?utf-8?B?ckNXQWQ3VHppNzd1R01MVENQamI0cmxzUURsT0Z5ZjFUOEErd1V2YmtWaFNO?=
 =?utf-8?B?Y1ZZcFBCZUZ2SERJd1NIWWpuQ1RjRFdJaXZSeEdnRUN2dUxLTHZjV3dJMDRQ?=
 =?utf-8?B?bnlmckhhZjNlN0hSczZEaW9OZkptcHlyZFlRdTdZeTBkdndIMzJpMDI0Y05k?=
 =?utf-8?B?azF0MWVuRnpCYU9Hc3E4K2t6NFNzdW5UZFM1aUl3K1lXN1I0NG4yVk5SaEh3?=
 =?utf-8?B?SmdHT2lMOU1PSXczVURDZXdPSUZyRUhjY29CL3RkRlRWYXVqV2lmdWpPZDhV?=
 =?utf-8?B?dFdRZXpTcm5TTEFZbzNZZm1wUUVNczdLTG1NZWF1S1BqTHo3ZjEyUXEwQzNI?=
 =?utf-8?B?UnA0RDV5eE5TbGlCanFxK0Z3dUN4eGJqSGsrci8yUlhLbEQ2c0dpZy9IMEM3?=
 =?utf-8?B?MThqVGFqS1NmNzlCcnF3dFZaOXRFOFR6QVpFV1o3YzdvcTJvUmptT3pZbmYy?=
 =?utf-8?B?TW5jRDE0dnpsaGsxZHpDdENOTUkvOUk4bFZNQmJWMzlKN1owK1hLdDFFejVM?=
 =?utf-8?B?NjN5bkE1MktocVJ5TUZWQ291TURSY3g0dFF1SFpBeUxIWFQ5VHpCSFZJUUsw?=
 =?utf-8?B?ZFRmK2xmSXF1SEJ6d291MGVlMEdwTTc0REZiWmpGU0dVVDJEeFhiUVVZUnpQ?=
 =?utf-8?B?VTVBQU9tOTNkYllGOTdKZkJNc2VrMDJSdFM5Qk4wTTd3T1g3UGxLU05JeXRW?=
 =?utf-8?B?STVYUW1JNnVZbndiNGp3c0lpTlNoWG9xZjA0djN5cUZLNEZYUlhTVlRkbXR0?=
 =?utf-8?B?TEYvaGNFY3BVeVhVWFF0QURBSFVVdDN4SlRKdUZlMHdobzZkYThBd0hQdDVt?=
 =?utf-8?B?VStWbWFtS2YwSFlybDlLWkF2bkVvT01lZ09QZHFnZ2RhNnpNNnBvazE2Nm9i?=
 =?utf-8?B?YzdGVlBObzZneTFycUpyanB4TWhOQ0NINlU2Q0tiWTBpTSsxY1k2WFZReGdn?=
 =?utf-8?B?cEVxcFlWWncxdVZFaDhiTGx5M1NRSDJxSnkvYTg4SVRoVFduNmdSdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ABp0B8ALnK6f90lucuAJX4r0yEL0XybjFmh483Cr+kCvrxN41Xqyz5dBWkJeuS5RGVHOLhPCsM78MIHdtbSLuyOWabdgg3WVD1G61+nSLoc7mY1BVSMbhN0puz7zLGA0SFHbaKUiDtvCXXK9gwMLAcha3p5ZadFWBXD9YjgUBRO6K7cVB6PWU/jZFJJuLhmdHhk7gd/3LViGHjZ4m8aLW5dLSlQOlX1h+UiCP9Y1pYhEWDUENtpBvfEEZaEym6asrx0LNPie2YTC2X+ZVpcuvsMlRX2y8KC+ndT5jqyo/R8vX9MW5Ffuti7ZRUKbFGhg7iqGZspwijaYQS5hzGPwhZ1047SjhhEyGgoQHsGl47xaTbXB4eSAuJiSX0+21e4XroRRTredO84ILbWKSfUpA4QFTpL3MDlhKctxV+KDr3DL1XeAqAqCBS0ytfNRFoYsS3PiG9tnS2ouVYwe8INyBMow+OnGLuxiImLulmlptCuqfK0pLq1nMbJZ9ZtUiavfWhaiW4y6n2Ke6XLWp6ndEB2I8XYOrm/P5JV5TPH0CzwrPffVO8FvZClW6j3F2zwa8IL6rr8D4HJz5uS3j2DLSvLKmSczwhNwbSAKOt8xyGs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67ec688-10eb-432c-7667-08de6e45ee56
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6050.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 16:59:36.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZYrvLZGp/Ua5H8s54LRwwEQ5JDXFZMUvrY2LsJYY4omT2gbA4sFVVu+YRH9CBR9rgV6VIbMMGyF4YdUVFYQSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602170138
X-Proofpoint-GUID: 9BcwbDC9JXRmIlpiIv6Qaz8cj-krOATG
X-Proofpoint-ORIG-GUID: 9BcwbDC9JXRmIlpiIv6Qaz8cj-krOATG
X-Authority-Analysis: v=2.4 cv=JO82csKb c=1 sm=1 tr=0 ts=69949e80 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=1bToNNPuCCefk2lS86wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEzOCBTYWx0ZWRfX32uAUTb00t2p
 cgvWoFmuphjeb7exxrdQQx5Ih03AFM7vAqfAlcVzKXYRQ/ls5jAPiMU5h8MWFjI0oSNg+TgNedp
 9ZsYZjYshOStPnMPCoZQr5jpx+B+pNHT+mW+BGAoU5KGlpg+Eu20IMVR3AWoBgggNSn5S5vBTfW
 8fx3HCHDfj6Ujz/1F9mtgDAt0vBiBPqQEvR8euzLXZmxuFeKPkF11hlH6uu9STKBPWhO+mJeSpd
 ZWnR/jpnFVaZBTdgZ5HkSmgNQ4ewsljVow5MfI5pQSv2VL6k0wpKs01UM9iL7eOAxTDseFzUsvO
 aSu9mCwr3timzB3WlC09eQ5KnWD8gxGuvx5epzJPig1x7roYSHoUgRr2MTmyBUfqLh+37Brh1JM
 dM3YbPGD5GqISEVJ43I/zAIMnUiQ4loBxuwaOJNn99Fe+w7t4ncKu8ddbln8+dLljM+7wKlh8Dw
 r8LUbhH1mi8SUCmmosA==
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
	TAGGED_FROM(0.00)[bounces-259106-lists,netdev=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[9];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5efae91f60932839f0a5];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 5526114E75F
X-Rspamd-Action: no action

Hi,

On 2026-02-14 10:25, Fernando Fernandez Mancera wrote:
> --- a/net/rds/tcp_listen.c
> +++ b/net/rds/tcp_listen.c
> @@ -59,30 +59,12 @@ void rds_tcp_keepalive(struct socket *sock)
>   static int
>   rds_tcp_get_peer_sport(struct socket *sock)
>   {
> -    union {
[...]
> -    } else {
> -        sport = -1;
> -    }
> +    struct sock *sk = sock->sk;
> +
> +    if (!sk)
> +        return -1;
> 
> -    return sport;
> +    return ntohs(inet_sk(sk)->inet_dport);
>   }
> 
> It would be safe from rds_tcp_accept_one() path as the new_sock has a reference count of 1 and no other component should be to release it.
> 
> In rds_tcp_conn_slots_available() path, fan-out can be only performed from receive path, AFAIU if data is being processed from the socket we should always be holding a lock.
> 
> If these premises are not correct, we can always make this conditional. But getting rid of the kernel_getpeername() call is performance-wise too.
> 

rds_tcp_conn_slots_available() can also be called from rds_conn_shutdown(),
where no "rds_tcp.ko" backend specific lock is held.

This is very solvable though.

Worst case, we can distinguish between the paths where a lock_sock()
is already held from those that don't.

> I am testing this against the syzbot report/reproducer.
> 

Thanks,

   Gerd


