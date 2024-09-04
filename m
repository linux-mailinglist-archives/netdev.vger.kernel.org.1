Return-Path: <netdev+bounces-125226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F596C57F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EA928839F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D031E0096;
	Wed,  4 Sep 2024 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mdxt9jLx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="emNUK39R"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969E44376;
	Wed,  4 Sep 2024 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471148; cv=fail; b=s3KeqWNSEO/TpKJZt9iVKuO0z0i6ChCnDkz4sddgyCMmbcFPTidP1UC0vDh+g18YONrRAEfg8JXbeEjDsZn0F+52JDKJBHTDWRZL6smZobQbXiOBFXCe0NDk7nQrKoOzQpqAHi31eae69Ut9mq6m0t7VKP9162YnRzp4FkjkGG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471148; c=relaxed/simple;
	bh=UdQbPkWCoCa9naNejmoDJmLSF5mzwffyQiIQvsKKyFk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KeaDR5skWIHAZymQfz0mI8D6ZLtLtP2LI4LuVzdYtZXCtcOhpaFsItDNiCsm/4m34kXajT4D0u2AFJ0J2x4KCPLm1BnJZKq/+Mwj1PYPUsmk8yNjpB2RUUDeIpHNd7ZaP9gRuMN3G7pKKOpc0P2uKrTyRqEk2tjZgPSysJSlBW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mdxt9jLx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=emNUK39R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484GtpIB017521;
	Wed, 4 Sep 2024 17:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=stcKTYd4JsQUJrQerwwFIYelk5cROumF9iPv2PStzsg=; b=
	Mdxt9jLxOaI5wrSlgqvWtkAohn3Bc7VaHZX1/8Z3w/7T3ACklDwWHwbF1/QFY2+R
	z9IGajCooa0ckhuM71k5XZITqWs0TT+yvmpB8cfA+lOJo8GG/MkBC+l5OfTAVkBz
	SRpkbywo7ufAq2sFq74l3gxaz4EPxmwsnzwaWmQ8chfsBtOsAyFG5HOfsu0ACGVR
	6p62DVxijaQJbS+I5S+kXuVBonVEdUkdYBiarq0EQKQPJkbq/TW4DWtG0BkORW2E
	Vb4Nna6XFNmRNuUZnl0eRXd6jGfGzKG8hjEOoeGPVGGMJTy+Xfbl/jo+X+Gg8hjM
	4RZt+xM6fk/47uUTfAAPpQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dr0jvgcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 17:32:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484HMuFI001753;
	Wed, 4 Sep 2024 17:32:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmgpv55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 17:32:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYeLQ9nEmi0z434bRIwi4IdT3QVmLGMQxDwqEPGnb2nv1jfEYU1US1FLH9jUJBMYlmYwYN19b/DWN+EbQV9trbmI7qnqrDDv/tfAAiqNxlTMUe532pYDmSUmHA2P44ErQCVivs7CjbjosthYFXF1Gsx+IFgvfF6J6AE+lLI4S8byKXdb+cJYRinAn2EGx/gHMdEAWjHGqP9unANH2fdQ5i9gct1RC/YdgWEoOIJGjSRL7zG01ateorAZTMWAjIOuMvtAeB3BNHOR6vcLsKSuydcPga2854g7Vl26IgQWzuOFOXL0CDaNUgaRli6Wew5J+SYIi/e2RwH7v+nq6ck+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stcKTYd4JsQUJrQerwwFIYelk5cROumF9iPv2PStzsg=;
 b=pFXBLd6CqoMmdM9LKmONpe4o5fDRJFntnKVURg8IFwmTuNygk0KcpZV8Axbwqzvz85ifjS5HCKWUXzwMPDOYpxY5JCnrkSNRFdZwhhw4Ll8oAm/5KvveMIgGn2a5IjJysvbOMxvLuXXMoHmWE5tZ/Wb2m/CFmJKKRRUSJpKGmnIQNU6Hi2SuUYbOOusS07GW3j3pSurDY8AJZauqW0dClwk14+WM+eeVeN8YQPoXts0Hl1fojjehb7OauHJXMDsUCC4AWIFH6d99ZKA93jS4BP0v5NZxOkUGQn2MncytiCMjW6b3tmkqfUeONb/qZVekHkvXanxy9AW0gEImHfYtcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stcKTYd4JsQUJrQerwwFIYelk5cROumF9iPv2PStzsg=;
 b=emNUK39RKDf7pdybUvHwP+nibCsogydtDjoAhAe1Xhjsnbe9mQS92GvoZXPHr4r8xkbX+k5hCKukisISIEx78bIiMFM9gnWfmsK9HqFtJvl+g8Hj3oajMIaThtxXKFMDpNwCp+n5evm1WAQFJODGL1NEdxNkMsVf2xbabLW+4qM=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by PH0PR10MB4631.namprd10.prod.outlook.com (2603:10b6:510:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 17:32:10 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7918.019; Wed, 4 Sep 2024
 17:32:10 +0000
Message-ID: <f6443f4c-c3ab-478e-ba1d-aedecdcb353f@oracle.com>
Date: Wed, 4 Sep 2024 10:32:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: Eric Dumazet <edumazet@google.com>,
        syzbot <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <00000000000083b05a06214c9ddc@google.com>
 <CANn89iKt9Z7rOecB_6SgcqHOMOqhAen6_+eE0=Sc9873rrqXzg@mail.gmail.com>
Content-Language: en-US
From: Shoaib Rao <rao.shoaib@oracle.com>
In-Reply-To: <CANn89iKt9Z7rOecB_6SgcqHOMOqhAen6_+eE0=Sc9873rrqXzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::29) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|PH0PR10MB4631:EE_
X-MS-Office365-Filtering-Correlation-Id: 840a9402-4d34-4447-0ce5-08dccd078143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1ZXS3o2bStnM3JvSzdRWlhOb1FCOUNPV2djVVZ1ejkzQXcvcjJPVmdGRjNn?=
 =?utf-8?B?RVRVVHZ6dHZMT05TOFQvWCt6QlNraHhjTERZV1NJYm9leWZQUU9BTzhlMlNs?=
 =?utf-8?B?NDliYjRFakUvMkhta1YrWk1LSnVyNDh2cGxPMWFvMStSTzdjRFFsTkkxZnVT?=
 =?utf-8?B?MjlONXpJeDUrdFdEWXZ5MkRaMVhQQzVZbUNGSWZBZFhHVUJHOFJVK2RBUSs2?=
 =?utf-8?B?WWtSd0FLSS9pUGdSVVZranV0K1ZPK1FmNjVDeWFKNUxjRjM0c3R6aXpzRUlC?=
 =?utf-8?B?K21waW1YdGY2THdjRHpoRXpCYkNxQ3ppeHBPWCtldisvWUtPYzEzcjB5eTYv?=
 =?utf-8?B?d296bit1S0lYVlQ4VGsyRmNjSGUvcmdTdzIzMVZmNHAvSXFFQ2ZVMGpycnE5?=
 =?utf-8?B?ZmJjK2FYbkxvRWVGTXg0a1Nxd3h5bXpNdDhSTG9ERWpocFlDTGNoQk11OTFz?=
 =?utf-8?B?UG1CeVlSbWxsWG1XeGg2RmN2aFIwV29xR0p2OWVPbkluN2ZWbUtuemQwcEVa?=
 =?utf-8?B?L0R4cHk2SEQ5Uk9jaHI2dkVlUXVNYzBVTThvekE0b2ZYK0ptdW5WeERHUDQ4?=
 =?utf-8?B?ZVdqemNxSHdnblhJc3NEL09wSE5nYnZEUFlyMTRkTExwdUF6dVVUYVpYSGtJ?=
 =?utf-8?B?V2hCMVd1SmdRcTJLTWo5Ym1RcFEwc1d6UFp0d1VBK2IwN0VXSUpmUlhmT0Ey?=
 =?utf-8?B?ZHFCcXU0dlJoTTFBblo4aXV0VTcxTEZ0R0RLNVZFcHNlTmVwZ2Fycmx3Y2xI?=
 =?utf-8?B?V2xUbEorWWJJTVU4bjBFb1VNN2FFMXJXa0hrVTJsZFhPMk1VVTUwYlYwVlhV?=
 =?utf-8?B?VGN2RW12dlU4NnBEd2o5L3BhMllKVmhpNjBuTHFhdjYyTC9FQXBjYXdmVkYr?=
 =?utf-8?B?dWlaS0tZcXNBNitUcG9nZGtmYWdURUQ0Y0N6dEN5V0lqK3VGVkEzNWVvMnQv?=
 =?utf-8?B?eml4bnZtakRKMy9OditxU3hvRktOTERHQ0c5dFd5SzJvK256d1YxeXMxOUI5?=
 =?utf-8?B?djBQemxhQmhaSUtEc1paVklES1I3QWJMM2t6N2VNUWhhOVFyN3lpYnh1Vlcv?=
 =?utf-8?B?M2FUcC9kbjI5YUorRm42eGcwQWhyZ3hISTA2T1Y5VEVSZTZiOFNCcDJYbTVj?=
 =?utf-8?B?NnNDblE3eFdpYmhtNWdjYXBaZ2loak9kU2ZZN0U2QlRpVVJkams5TVQwd0wy?=
 =?utf-8?B?NU9jT3U2RnFmekd2ZzVsd3ZGRXo3RXRxSWdZeVNJWXljbkhnblR4OURRY2ll?=
 =?utf-8?B?S1R2UCtoanlFS0hzU3oxUmNjNFNYY29URUlUV0ZzSVUrYWdCSFhPNEsvNnhB?=
 =?utf-8?B?NGFNREtOVmhaSFp5QklnZEQ0R2t5YVBPVmF0WWJvVVFML0EvR1RhOFVqMGZj?=
 =?utf-8?B?Mm1udytiUUFtQUtjai9vMW1JQzlqdjFObWc1R3lSYnBrOXVKSHpQZ0pUUlBn?=
 =?utf-8?B?c05UV2NPY21makgvSHhpWm8zTlowaHl5MVFxTGRpZHdWTmJjN2orS1hFTUpl?=
 =?utf-8?B?SllaazhuWjVmZnJuejIrOXJ1VG9UUCtpY1c0dG9wN3NYb214d0ZFQnpJY3RX?=
 =?utf-8?B?cmxURXl0R2t4NDFreGhDU2dzNmV1em1LTS9pejRRWm5KdnBEaDlPUjc1cHhK?=
 =?utf-8?B?d2s1VUg3bkRaTXNldk9Ld1A3c052RDdKU09rWUlscGc3b0QwN0ZNY2NreitK?=
 =?utf-8?B?ZUx4UVAvWWJFSC83dU0yY3Y1a3FVOTJBM3c5eXAzbDVpbXFDckNJcVg2Wmp2?=
 =?utf-8?Q?TdI19xAkwZ6xziPk30=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkQ5UC9HZW5BTHduam9sVkdHeVhBcTFuZjVMWlVnd0xoWi9Ra1R2bUtKVzQr?=
 =?utf-8?B?akhJenRKS2x2a1IxR25nL3Y0WkZqWXBwQmowNkI0VXM3MFNBNVRiS241ZlBK?=
 =?utf-8?B?ZVdIdko2OWNPR3lhMmNPNGhHWElma2hxbVc3SDd0RWNvK2pIM3ZQdHc5YjVn?=
 =?utf-8?B?bUx5QWJXWFFseXM5R2tzcmpsMFh5WnRjSEVGTUJweS9hbnY2VDFqdG9hTTYr?=
 =?utf-8?B?NTNqTEJOL09NM2JQTlVhOWJJcE9icS9aaGxnM2Npb3F5dERBbjdWQ0h6VFBj?=
 =?utf-8?B?cU5pdkpGdWtpbmJPcDBCZ2gyQnljUDdGbkk1UXRieTZHVTRLMlY3WEtpSlRJ?=
 =?utf-8?B?NGM4VWR5UTdxbGVqSmtjSVJsS2pJNHhRSFlyeStVbFBmZlRUMlZPbk9JOVNi?=
 =?utf-8?B?ZVZ5VE5PTDNhVlIreUs5aXYvRkpubVJKOStBcUxtVnZ0SUdqcjdoOHVLaUFK?=
 =?utf-8?B?UzJyQXdrMzRuWW1idFpLUEZ0SEpLVkVIWXBvSmZSa3RvbWxHVCtHUVBNNlQr?=
 =?utf-8?B?ZWR2UEZCUkZxN09hbkhZdnJyZXZIaFFpRHB4MG5PRVg1SllmZXAyS2ZYVEww?=
 =?utf-8?B?cjZuN2lpZFVVMnVGTFdqQzAreWMyaUV2R0ZlV2dvOTBzcEN1N28zOUJTSGZR?=
 =?utf-8?B?QU1Id1lRYVhzNFE5ZnJsTzdBK3Q2S3FGL3VKUGR0Q1c5c0NvZ0pib0lXZks1?=
 =?utf-8?B?eDBmc2Jia2t2MXMrS2xxV3R3S0dEb0JTWENBL2pwbGRHb0NqeWorRTBiTHRH?=
 =?utf-8?B?NE5EbUVRRitKbGFZS1ZiMXg4akJFRDByR1NpU1hENHh6ZHZad3NOVlZPMmYx?=
 =?utf-8?B?cldDUytjV01ucUY1ZkxxTFZ3eDkzNCsvWXVvbzFFWUQyeWRqbktvLzFwYi83?=
 =?utf-8?B?SXJZaEFYaExGUDBYd0lsVzFZamtTUms3RjhwM2JxUVRkS2tpcDBIQ1JKSjBk?=
 =?utf-8?B?QlBzTDhJVm1MTVlPVXh2bUp3b2cwazVZQW0yYVhCcDJqMEFxcnN5Sk8wUTBv?=
 =?utf-8?B?UXpjZHJ1cnhzTHZUK2huemhvMjlqYjRFYjhPUTJtU1F6cE1NLzkxRmxiUTkv?=
 =?utf-8?B?aTFGbnRCUXNGMkVOanJ5dmY1V0w2RjNVQVJ3QUgwaUdCd0JIZ2xYNURXSnNN?=
 =?utf-8?B?VjJDODVzRnhqWmZvbDJHU2pLanJmUXJRQ0NSRzJYaGMzM1RlbElobjBBSDNQ?=
 =?utf-8?B?ZUl2NVZzRS9UTWpaWXBDNFlabWNCdFJ2clpWakVNM3NpZU92VjdNb0JYZCt3?=
 =?utf-8?B?OUNBWVV0NEZXQTEzK0JQM0JMb3RjRnhoQ0YvSmpDWWlhSTZpYmtlWXBjYWxI?=
 =?utf-8?B?K2QzU3NmajVjaG9TaUhOVGpsc1A5cTFGY083Y3QvNlVyRlE0Z0szbk1NZjVr?=
 =?utf-8?B?emYrTWtRVEJhb3JISzVYaVNhUGZGNEZuSmRkM2NGalp5SS9BOTYxTXN0QW9U?=
 =?utf-8?B?QmxLanlkb0hhcDBQYWYyTHRwUG9OQWN3eVRaSnVIY3RYN3J0OWlveFJzVTFD?=
 =?utf-8?B?NGczdWFZVjFkcVRKdGY0WitqK1RNK1ltb1JUVU1EeVBHQXViSHI0Yjlhbzhs?=
 =?utf-8?B?QjFlTzlwcDg4TjJXSW04ODlZMDRYRXowazBmNmlUNWsxYk9tOHhXeGFPazJm?=
 =?utf-8?B?MFR5RFc1OFJNRmZCWGtyZ1ZndTVhS3VnOG41OUFuRmJvTTFMdkVHa3hXeE1p?=
 =?utf-8?B?UEt2NDJCeHRtUWc5OGM3VTA5ZTluR2czVWZvcEhXWU5GM1BqN0dkWDBxR0tG?=
 =?utf-8?B?YlNOKzlFWk9rUUdXOW1wVWRUTEk3RHgwZnRSKzhwZ0Z5UmZadVQxT3FXOURp?=
 =?utf-8?B?QjJGSG85WU12TTVnay80VEdJTEZGdHFldzV1dGpuTUUrcEUzK1d5bEx6bmdn?=
 =?utf-8?B?NVhMRWttSXQ1d2F3U3VGVTU5cmEzYy9OWkwzdDJ1Vmp5a3dVTnBZclN5T2tH?=
 =?utf-8?B?L3crMkVWMUNxOHdBeXlrRHladERZRnBHc1N6TklkYVRWVmw0b3RZS3N6dnBR?=
 =?utf-8?B?dDNOVnJkcU02TDMwUk1PWDRUeWZGbmY3c21id3Ntc2cvbWt4NWNlR2dQTitn?=
 =?utf-8?B?cmZMKzRzSU9QM0tzelpqcjMwVWRHVGpEMHhKQVR5VklQVzNDYi9MR0dIWGFH?=
 =?utf-8?B?VWxpSEtYOWJiNnVKc0RKTG45YWo1ajM4MlE1eGdwQm1SMWRwalZmZ3FQVW10?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1aGkpUNRe4I+epAC88oz1U2GT4S3/vpXku64Wna+xWSqpFjANkjuy3LOf/dtXNlYtvL6zEEWaJgx7edXTrfJu8dcW0PkqvXyHktpXcE/2jgvuQJ8PIyFgo4gXyAiyGUZ4yYcWMDuOqZHvLuSgZwfdWvjUSOwXzbPwvj9cLszv5GiMQ9DXEddxonQhjEIoE4MkhbwZGGOcfroPZiNvS6v9oPAUFsuuiM4hyPfifTgCPKGDXURcWs3vCrtmA6Vrl4l2KMLfyOYaDEoDRy9I68fYsQT2TSLTTvB0UV+AH9gjrneSSQmhoX98Qu0YBIs+rONDa/+AZsxh1bPduINDYUpcfP0nFX1f6BUhNrr4/eMqGAAwRzcA7Xshf0cxA0+FMdpjLG1bVEVaIQYhSkHG5rR7oMClNUJn1V7iftAlcaFLmXAsHXJIhtxTEfw3UQw3EUYUhKpw9fTpYDTgz/QaB3ePQIYkOM8YhCcfahVUEe/u8kIHkFdzxyy3fL9DKsgTWkSz4yQiXoy9Ljy8RO1TScKPtVjJOoBr4rCy2bbBrAWXAXk8jC9pqgs4A1MXIwLvGb/yYyBlI03jHBviDamCyWZ+9tyuZKj2IMV3RtnnHsImqM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840a9402-4d34-4447-0ce5-08dccd078143
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 17:32:09.8943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnKScb3bv7YSP8XFEQFSSGXka93DUgU+GxMgJJ9byeBJerVnrmHK55KyPFJU79hBHlPR4wXWEuH8Q5ne8Y0igw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_15,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040133
X-Proofpoint-GUID: YgJQ8Jkao7xp-zW4UCfOfysB3vAA20bT
X-Proofpoint-ORIG-GUID: YgJQ8Jkao7xp-zW4UCfOfysB3vAA20bT


On 9/4/2024 8:32 AM, Eric Dumazet wrote:
> On Wed, Sep 4, 2024 at 5:13 PM syzbot
> <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    fbdaffe41adc Merge branch 'am-qt2025-phy-rust'
>> git tree:       net-next
>> console+strace: https://urldefense.com/v3/__https://syzkaller.appspot.com/x/log.txt?x=13d7c44d980000__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmCinyPp6_w$
>> kernel config:  https://urldefense.com/v3/__https://syzkaller.appspot.com/x/.config?x=996585887acdadb3__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmChXq35SIA$
>> dashboard link: https://urldefense.com/v3/__https://syzkaller.appspot.com/bug?extid=8811381d455e3e9ec788__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmCgeHsuB4Q$
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://urldefense.com/v3/__https://syzkaller.appspot.com/x/repro.syz?x=14b395db980000__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmChfSXV14A$
>> C reproducer:   https://urldefense.com/v3/__https://syzkaller.appspot.com/x/repro.c?x=16d3fc53980000__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmChGWZhDug$
>>
>> Downloadable assets:
>> disk image: https://urldefense.com/v3/__https://storage.googleapis.com/syzbot-assets/feaa1b13b490/disk-fbdaffe4.raw.xz__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmChjbj6XGw$
>> vmlinux: https://urldefense.com/v3/__https://storage.googleapis.com/syzbot-assets/8e5dccd0377a/vmlinux-fbdaffe4.xz__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmChlarTUfA$
>> kernel image: https://urldefense.com/v3/__https://storage.googleapis.com/syzbot-assets/75151f74f4c9/bzImage-fbdaffe4.xz__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmCgl9hRVww$
>>
>> Bisection is inconclusive: the first bad commit could be any of:
>>
>> 06ab21c3cb6e dt-bindings: net: mediatek,net: add top-level constraints
>> 70d16e13368c dt-bindings: net: renesas,etheravb: add top-level constraints
>>
>> bisection log:  https://urldefense.com/v3/__https://syzkaller.appspot.com/x/bisect.txt?x=11d42e63980000__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmCjDvB9Flg$
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com
>>
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in unix_stream_read_actor+0xa6/0xb0 net/unix/af_unix.c:2959
>> Read of size 4 at addr ffff8880326abcc4 by task syz-executor178/5235
>>
>> CPU: 0 UID: 0 PID: 5235 Comm: syz-executor178 Not tainted 6.11.0-rc5-syzkaller-00742-gfbdaffe41adc #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
>> Call Trace:
>>   <TASK>
>>   __dump_stack lib/dump_stack.c:93 [inline]
>>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>>   print_address_description mm/kasan/report.c:377 [inline]
>>   print_report+0x169/0x550 mm/kasan/report.c:488
>>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>>   unix_stream_read_actor+0xa6/0xb0 net/unix/af_unix.c:2959
>>   unix_stream_recv_urg+0x1df/0x320 net/unix/af_unix.c:2640
>>   unix_stream_read_generic+0x2456/0x2520 net/unix/af_unix.c:2778
>>   unix_stream_recvmsg+0x22b/0x2c0 net/unix/af_unix.c:2996
>>   sock_recvmsg_nosec net/socket.c:1046 [inline]
>>   sock_recvmsg+0x22f/0x280 net/socket.c:1068
>>   ____sys_recvmsg+0x1db/0x470 net/socket.c:2816
>>   ___sys_recvmsg net/socket.c:2858 [inline]
>>   __sys_recvmsg+0x2f0/0x3e0 net/socket.c:2888
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f5360d6b4e9
>> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007fff29b3a458 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
>> RAX: ffffffffffffffda RBX: 00007fff29b3a638 RCX: 00007f5360d6b4e9
>> RDX: 0000000000002001 RSI: 0000000020000640 RDI: 0000000000000003
>> RBP: 00007f5360dde610 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
>> R13: 00007fff29b3a628 R14: 0000000000000001 R15: 0000000000000001
>>   </TASK>
>>
>> Allocated by task 5235:
>>   kasan_save_stack mm/kasan/common.c:47 [inline]
>>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>>   unpoison_slab_object mm/kasan/common.c:312 [inline]
>>   __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
>>   kasan_slab_alloc include/linux/kasan.h:201 [inline]
>>   slab_post_alloc_hook mm/slub.c:3988 [inline]
>>   slab_alloc_node mm/slub.c:4037 [inline]
>>   kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4080
>>   __alloc_skb+0x1c3/0x440 net/core/skbuff.c:667
>>   alloc_skb include/linux/skbuff.h:1320 [inline]
>>   alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6528
>>   sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2815
>>   sock_alloc_send_skb include/net/sock.h:1778 [inline]
>>   queue_oob+0x108/0x680 net/unix/af_unix.c:2198
>>   unix_stream_sendmsg+0xd24/0xf80 net/unix/af_unix.c:2351
>>   sock_sendmsg_nosec net/socket.c:730 [inline]
>>   __sock_sendmsg+0x221/0x270 net/socket.c:745
>>   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
>>   ___sys_sendmsg net/socket.c:2651 [inline]
>>   __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> Freed by task 5235:
>>   kasan_save_stack mm/kasan/common.c:47 [inline]
>>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>>   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>>   poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>>   __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>>   kasan_slab_free include/linux/kasan.h:184 [inline]
>>   slab_free_hook mm/slub.c:2252 [inline]
>>   slab_free mm/slub.c:4473 [inline]
>>   kmem_cache_free+0x145/0x350 mm/slub.c:4548
>>   unix_stream_read_generic+0x1ef6/0x2520 net/unix/af_unix.c:2917
>>   unix_stream_recvmsg+0x22b/0x2c0 net/unix/af_unix.c:2996
>>   sock_recvmsg_nosec net/socket.c:1046 [inline]
>>   sock_recvmsg+0x22f/0x280 net/socket.c:1068
>>   __sys_recvfrom+0x256/0x3e0 net/socket.c:2255
>>   __do_sys_recvfrom net/socket.c:2273 [inline]
>>   __se_sys_recvfrom net/socket.c:2269 [inline]
>>   __x64_sys_recvfrom+0xde/0x100 net/socket.c:2269
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> The buggy address belongs to the object at ffff8880326abc80
>>   which belongs to the cache skbuff_head_cache of size 240
>> The buggy address is located 68 bytes inside of
>>   freed 240-byte region [ffff8880326abc80, ffff8880326abd70)
>>
>> The buggy address belongs to the physical page:
>> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x326ab
>> ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
>> page_type: 0xfdffffff(slab)
>> raw: 00fff00000000000 ffff88801eaee780 ffffea0000b7dc80 dead000000000003
>> raw: 0000000000000000 00000000800c000c 00000001fdffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>> page_owner tracks the page as allocated
>> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4686, tgid 4686 (udevadm), ts 32357469485, free_ts 28829011109
>>   set_page_owner include/linux/page_owner.h:32 [inline]
>>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
>>   prep_new_page mm/page_alloc.c:1501 [inline]
>>   get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
>>   __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
>>   __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>>   alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>>   alloc_slab_page+0x5f/0x120 mm/slub.c:2321
>>   allocate_slab+0x5a/0x2f0 mm/slub.c:2484
>>   new_slab mm/slub.c:2537 [inline]
>>   ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
>>   __slab_alloc+0x58/0xa0 mm/slub.c:3813
>>   __slab_alloc_node mm/slub.c:3866 [inline]
>>   slab_alloc_node mm/slub.c:4025 [inline]
>>   kmem_cache_alloc_node_noprof+0x1fe/0x320 mm/slub.c:4080
>>   __alloc_skb+0x1c3/0x440 net/core/skbuff.c:667
>>   alloc_skb include/linux/skbuff.h:1320 [inline]
>>   alloc_uevent_skb+0x74/0x230 lib/kobject_uevent.c:289
>>   uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
>>   kobject_uevent_net_broadcast+0x2fd/0x580 lib/kobject_uevent.c:410
>>   kobject_uevent_env+0x57d/0x8e0 lib/kobject_uevent.c:608
>>   kobject_synth_uevent+0x4ef/0xae0 lib/kobject_uevent.c:207
>>   uevent_store+0x4b/0x70 drivers/base/bus.c:633
>>   kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
>>   new_sync_write fs/read_write.c:497 [inline]
>>   vfs_write+0xa72/0xc90 fs/read_write.c:590
>> page last free pid 1 tgid 1 stack trace:
>>   reset_page_owner include/linux/page_owner.h:25 [inline]
>>   free_pages_prepare mm/page_alloc.c:1094 [inline]
>>   free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
>>   kasan_depopulate_vmalloc_pte+0x74/0x90 mm/kasan/shadow.c:408
>>   apply_to_pte_range mm/memory.c:2797 [inline]
>>   apply_to_pmd_range mm/memory.c:2841 [inline]
>>   apply_to_pud_range mm/memory.c:2877 [inline]
>>   apply_to_p4d_range mm/memory.c:2913 [inline]
>>   __apply_to_page_range+0x8a8/0xe50 mm/memory.c:2947
>>   kasan_release_vmalloc+0x9a/0xb0 mm/kasan/shadow.c:525
>>   purge_vmap_node+0x3e3/0x770 mm/vmalloc.c:2208
>>   __purge_vmap_area_lazy+0x708/0xae0 mm/vmalloc.c:2290
>>   _vm_unmap_aliases+0x79d/0x840 mm/vmalloc.c:2885
>>   change_page_attr_set_clr+0x2fe/0xdb0 arch/x86/mm/pat/set_memory.c:1881
>>   change_page_attr_set arch/x86/mm/pat/set_memory.c:1922 [inline]
>>   set_memory_nx+0xf2/0x130 arch/x86/mm/pat/set_memory.c:2110
>>   free_init_pages arch/x86/mm/init.c:924 [inline]
>>   free_kernel_image_pages arch/x86/mm/init.c:943 [inline]
>>   free_initmem+0x79/0x110 arch/x86/mm/init.c:970
>>   kernel_init+0x31/0x2b0 init/main.c:1476
>>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>
>> Memory state around the buggy address:
>>   ffff8880326abb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>   ffff8880326abc00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>>> ffff8880326abc80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                                             ^
>>   ffff8880326abd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
>>   ffff8880326abd80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>> ==================================================================
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://urldefense.com/v3/__https://goo.gl/tpsmEJ__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmCj0yiM5oA$  for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://urldefense.com/v3/__https://goo.gl/tpsmEJ*status__;Iw!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmCglGrElYg$  for how to communicate with syzbot.
>> For information about bisection process see: https://urldefense.com/v3/__https://goo.gl/tpsmEJ*bisection__;Iw!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmChS6eLfFw$
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
>
> Another af_unix OOB issue.
>
> Rao can you take a look ?
>
> Thanks.

Sure I will take a look.

Shoaib


