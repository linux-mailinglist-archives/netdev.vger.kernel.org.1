Return-Path: <netdev+bounces-127138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F320974464
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 22:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FE01C24F91
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 20:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD311AAE1C;
	Tue, 10 Sep 2024 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R+I/G/xZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mM5uiro8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74B1AAE0E;
	Tue, 10 Sep 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001843; cv=fail; b=BViJZ7jZLcgF22Ydcc/7TwKpseDktYVq1P1VjRBja/g5alJ7vHMexpYNiiNacOpiLiFAjIWZVEtqpudcT565DTEzWG3nukRva0fzqS/9JJ1YqqOMUMq96Mv2aLHOjJyJL8SFTVA6iBKawmmmm+83RqZ7l/rR/BSozNyyImwE1hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001843; c=relaxed/simple;
	bh=lNF+C0rd0GC1OWXUV08Zc7S6ypBTfA7tterzLTPZJjA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gh/KYQpmiMgqkg8iJGlVdOhzOIXpk/kDUZTWvLi8DM/s3wTagr/xJHCSK21L3ZRBW/Cvsjzcv7b3z3IMWmsuzkk+/6q+q4h53CJCYdHyVHecl2P5xQOkVkNgZoQhLrAy97X/FmuugkET/F4PnlMwHmVcUdE0CUJM0F71cpbRb8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R+I/G/xZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mM5uiro8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AKtbJZ003237;
	Tue, 10 Sep 2024 20:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=pR5Of1dQRmeahIEMby7egUFSwfQbmlUkO65EaF/+t5g=; b=
	R+I/G/xZENr+R8CZbG6B10Vdy8/bjNADiM+C7eEm/OKuaOEutf51FsB59xr6C2Ew
	/+lUM6jFhFCBGfphvlo82+0PD7OSc8SpXDr5eXp/4q0EH3mezPccmsUi1hVkWkFV
	IMBCxb6GCVpm18928ICRvh+RKtUrscSEQbdWTR7LQ/5QqUYAJ2nUcCrK8DjOKqmo
	LJJfuOtHSz+bxs+Lb2mgZ7IzztdeAKpw49Rb/GW5UgFF99Ne7xDA486nuMTHDVe8
	88Fru1FCJYtf0q+3kiUC4BvVdIsCGOXyUMhgwx0g34eeKGd8WjwxAwcTp5P0EOw9
	O7l3gkWEXiSYvSJoe8dnPQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gfctep8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 20:57:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48AJl57j004165;
	Tue, 10 Sep 2024 20:57:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd994x8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 20:57:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugV4PrY/Iyqx+7x/pD3rlASbTwZP0Xty4UPRsAeBlotBGBrX7zDWPvfIwu3/V2qykTKB60/r0xlV3rXzfI7Qi161xtfTfhGJzRxnKg4Jgyh8+oqHSWL8l9uckKDhKZTKAJhGe6PhJV+DLuCedlW9A1w+uZtWlJpyNv3mGNdOPV4M58zRMze4nCULwiLGanf4wZKyKdIjE+GUdq9XUEuGmTGO+jnJBtpcmt6jSH/qxEWzFcQIk5qhL3pRy/WnunMycGzs24jxa+tJKTw8oaPuP5lNRjK4ChdFZx63FI1MF0SMFDViR0QVqgkuCIWLnLvoV2s2AlKJeKnTywJphU2Fcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR5Of1dQRmeahIEMby7egUFSwfQbmlUkO65EaF/+t5g=;
 b=m6FsdTEt1KXO8dc9L6QpXM37aEmvDn0v9RrSx6QByL7i7/3rsj1TN3WziCp9ua/pYDc387wbpQK2G9bqcrjcGP0Di39Vecl187o+0ep70rBZSDLs9T/YOiDrFxjXp32WZZw2PvwMo7Wxg20oJrxs+hLy9ckFKRZoWCxTINUCO07tvtq2OEBWbaiYLelc3+Dl7NGPABsLFHEu2ea+lx+wRtyahDY3ys960OVpyPJvpGtrEPuZZ2p23C7L80od3XV27TNR6akxgUHS/a43FpfKWGdVq2A1PVqJmwnqpub1+D79nbLd+2z7yXCNrcVlThyDoY5AnV8IPg8aDfJnA+peUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR5Of1dQRmeahIEMby7egUFSwfQbmlUkO65EaF/+t5g=;
 b=mM5uiro8aP4muzc/3vAs3pV8hlykXEvjflySazf8u2AyqqTr16EwrfWuUYjZfB9P5P+SJsknvDtrxZclb6cUmJ2lAAkwff7F8QrISrxHJI35KeDEDF+b/dGQzyuoJmet1h51VLjyF6SBp/4G9V2glg8C0IL5+ck17RqSWxDfmfY=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by CH3PR10MB7233.namprd10.prod.outlook.com (2603:10b6:610:121::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Tue, 10 Sep
 2024 20:57:06 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Tue, 10 Sep 2024
 20:57:06 +0000
Message-ID: <58a5f9c2-b179-49d9-b420-67caeff69f8b@oracle.com>
Date: Tue, 10 Sep 2024 13:57:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <1cca9939-fe04-4e19-bc14-5e6a9323babd@oracle.com>
 <20240910194910.90514-1-kuniyu@amazon.com>
Content-Language: en-US
From: Shoaib Rao <rao.shoaib@oracle.com>
In-Reply-To: <20240910194910.90514-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::39) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|CH3PR10MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: b67a5103-8c65-4b51-6c49-08dcd1db210c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVh2aHBrTjMwNVNnSUVYd0RGRjFYd0xmYUU3U3BjZEI0R2xJSWl6L3VpQmFj?=
 =?utf-8?B?anVYWklNTVd0VGFTSTloMEovMnFyRkt5d1J4V1BPaEhNT0R3L3RoaHFRWEhj?=
 =?utf-8?B?dmdKSXVoLy9JaWc0NEFZeGNkeGNzZ29xVlo3UFVVOVdoQWFMcThLUGV3QW9K?=
 =?utf-8?B?VFFQK1RnbGRIMTJTb3VuWG9YSmVMb1dzb3hUaDJMNURRanNzSFMxM3liZTNE?=
 =?utf-8?B?THV1SE50a2grMkoySlNHNmduSDdCbGRXekJHRGdsSzRDWmtjMEl4K2V6Tjhi?=
 =?utf-8?B?UGtCQkdGRE9zRklqT1VNdWNCcHRxZm4xdmpyZVVBMERCcTBQdkVwbjJ0UVZa?=
 =?utf-8?B?Z3hUQWJ2SGFNbk9DOE1ocHgwek1tbzRsZHhZYm1hRWh4cy9UVDZNUjlHVHBX?=
 =?utf-8?B?dzR2RHhvOHF0b2FkUitnOE00UHgwRXhYNlJwTjhJOU1LSlRSVlk2dlptaThB?=
 =?utf-8?B?NlpIY0hIdFllVWQwbWdLakJVcnpSNDdnN3hsQ3NzdXdVS2pkcnJmNXQ2aGht?=
 =?utf-8?B?T0NqczlGVmMwUllmTVVob0E4Nm1ZUGFpRUZCZ1FPenJrQU5udlBBRjd1ZWlI?=
 =?utf-8?B?T1pwNTlrb09ncEx0QlRwYS9wbTFHYWg5RmJzYWRHZStxQkEwblZoWXd1d1c4?=
 =?utf-8?B?ejFWL01LK2I5czQ3YWdqMjZqUWlSSUpmZFpIMEZ5c2dWY1pIRFBJQXFsNEc5?=
 =?utf-8?B?bVNJVjFkN1M3OXZ1aVhYUDA1S3JNOHNLNTEwb2UzbFVPNGxabVZXSmRZVCtR?=
 =?utf-8?B?VmdlYzBNOTBuMFNEV2V5cHNaOXFMdzlRWlRSQWFsZW1WWXdsbC96RnZRTXIr?=
 =?utf-8?B?NzB2RzZZTlpCMVF1aUdyUEZvTE90NnByd2ZCdDBZT3pLeHE4eFl0aWRFdktW?=
 =?utf-8?B?eDZCSDl6eFM2KzV3aDB6cHppYSsxZXhZVVdBWmZlRkN0YVNFRnFHWGFwWTRE?=
 =?utf-8?B?WTBleUpKQ29LT2RkWElVTisrbE5mQXJhM0JIUlNoVWhUVWNZSGwxYTlmeWhl?=
 =?utf-8?B?UEJTRFJHbllTVTFkV0pOOWgvMmlFK3czTUJEdWtpMjNOOGxYWmF0SjgzYmlK?=
 =?utf-8?B?Rjc4TitvZm1vekVKQ3hWalZwMlpMSVRPNC9HT1BSaEt6Sm1SaHVWeEN3elRw?=
 =?utf-8?B?T3Jzd0w2TkU4TUU2MS8wdWdyMldTZUJPTEk3ZzFIS0tPaFByQUdsM1JFcUpo?=
 =?utf-8?B?RVE2UENPREtMdHUxWFZWbDJpck96bVdrYjV4eXZ3N1lJdkJ1dDV0eEd0K3Nh?=
 =?utf-8?B?cHdJc1NnUW13dHpuWnU1MkZPa1RNNUVJUk44SEdWQU0vem1HTlJqd09HaXRU?=
 =?utf-8?B?OW00UzduTGoyRUZiT3c3UjMwYW91bXczdnFMTkR5V1h6K0h6bUZQNElVK0VK?=
 =?utf-8?B?eGdZTXVieHVVUTEwZTIvZUxLeE00YzRmdnRnT2NQbmhMa1dpVGFHbDhwcGVQ?=
 =?utf-8?B?SmVLZEtSL2lSU1o1L01lOXJQcmlpc2Z6cGRGMXlDMlZrMVArUmRpM2g4a2NI?=
 =?utf-8?B?ZklqZXhxR0s3R1JyRkhibWxFMTc3bktVYTVQMi9lM1hPSm5HRGxBTG5qTytI?=
 =?utf-8?B?YVBOcWF1c0xZb1hoQSt2MGVnMEI3aXVjdlZUZEZSWXQ1YTEyNUZON2NqSlFW?=
 =?utf-8?B?azByUSs3elhtQWlGYkJjRWFPYUd0ZHJpM1hPNDVVSnhOdVJFYU5Ra2dDQVNY?=
 =?utf-8?B?WkZsTTdNQ05uSm9mYnRqNkNxS1doc2ltUGJPVlRqclZDWWlXNFVpcVdFcm5v?=
 =?utf-8?B?a2hqaVQ5cVFSOCtWUjFpNWloT0NBK3ZCMG91R2tiNGVsdTVtSEovK2RaUEZD?=
 =?utf-8?Q?nveeLB3jI/vhD0iLm6X1YXiUMZGQskEnDMRxg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3h3REM3YlJ2cTg4eHJyQlNmUWdQcDFlUXZ6RVdVenRYZWZkTWhrUXFuWHRx?=
 =?utf-8?B?QWw1RFJLemFBeVhpdTRYdjdzQVdVTHZ4VnljZmhMc1lyVTFxbGVSSm5VdTdW?=
 =?utf-8?B?Y1NWendHTStJSVZncmlKU2cvbEVqR0Y5QXBOOU1BaEdqdVJ1dXNydVloelV0?=
 =?utf-8?B?TTlxYW11N3lrUG4rNU5zK0JlYklKOWw3Y0JEdlZmVmh0cmpGWU5sQmZSaEZo?=
 =?utf-8?B?Sm5PK0NZdXJINEN1NXViWVg4dE1EdExTN2J4MnYxaXJTSm5pRFUxYWN5T1A5?=
 =?utf-8?B?UGxTMkd6N3Yvc2NrcEZiMUVhK0U4N2NoSXA2eTdQNUpqajN4dXJSdU4rSjNm?=
 =?utf-8?B?SEZFczV5U3JuMkJyS2RaNFdPVmFQWnRRUnU2T3crSWFGUDlyZUs5KzVTcDBX?=
 =?utf-8?B?dlE1UVVDSndvRmJra1I1d0ozQnVyVXZKbkxDSUtESFNYaElpZ25xNkF1Z0tB?=
 =?utf-8?B?S2NoV3dCbTVMLzcrbWxLL1JmZUl1cXFGdTh1Z3lSdjVpUUJoSlJ2am8wMVlw?=
 =?utf-8?B?cGZRcGxLWnAvZ1FVRG5hS0VrUG4rd1poNTZOaU5MNDA3cUxQQnRLRUJ3U1lT?=
 =?utf-8?B?QXRtcFYwOEhiZjZmU1RrOU1tWnpuTzA0VUt3TE9UNElpcm1Td0pTMjhXMWlY?=
 =?utf-8?B?ZGY2U2xDQml4aXJLaTZKQmViLysvamlTclhzU09taVVoQkZYQ0x5NUM5UXl2?=
 =?utf-8?B?YlgvaWNvQ0lrZmMyNjQxZ2tJOUJXYXdmTEdEam4vNzlETVFjaXd3R2NPYk1U?=
 =?utf-8?B?VjJ3eUxIUDlDelRtOVpVVUpTeDJ5U0Y2WU5ZYXFpSjFBSzIvQXRYNXpGcFZh?=
 =?utf-8?B?UVBpeXY4VTViVjNYWVRpVkxkOXpGMWVwRXNCSVJNUGNPZDVXeFFoYlZJQ0d3?=
 =?utf-8?B?TmdxMjE4cFY5azY4cVJLb3d5aENjTS93blNvY1o1cjRVZ052VG5ZT1I1dmNa?=
 =?utf-8?B?dHBNdTFHTVFWUjhWSysyMC9TMGJySE56Z1ljeE5Wc3kwenpOU01XSFFxZzlG?=
 =?utf-8?B?aGVRck5QUStSblFGRmlGbDBPa0xqT3VkVFMyOFJrTEtPRTRDdHlKeXlTcWty?=
 =?utf-8?B?eThsenZwLzhHSjFPYzlVeHQ2RzU4elNlL1NiR0tkMGFWSzJtVGMxcCs5Z2xJ?=
 =?utf-8?B?YVNFU0lmNEI4ejRPaEhHQ0F6anlKOGpBTHMySkJOemgwVTVUUkpxamprQWpx?=
 =?utf-8?B?eHB4cWFRb3hFNVpCK1pFRlB3T0hPWElURi9YYlVrSmdSdUJ3dUhSTVNuUDl3?=
 =?utf-8?B?NlUwSDNmc1lUM0x6TjIvS0tGd291U2c4T2VUQmpkNW5BaFFqbG9Pd2dhc3dp?=
 =?utf-8?B?dm9pVElyK1FWaG5CNmlsOVVDWk1rQXRrQzVLcGxYWTlhUlRPdG9QSTEyamNY?=
 =?utf-8?B?eDhUZ2xOcmVIR0RGdjAwSVFrMW9MSGlDSHdMUFNDdEtjdGJ6a3VzVDZMbmRr?=
 =?utf-8?B?TkdOelRUSm93MXJkcmM4Nlh1SkhON2F6eDUvdzZzZU5LdUxtQU8yRHVzbHRt?=
 =?utf-8?B?eHhJNTA3S2RLNGt4dFA4TjBnVmxvQUsydGdaWEZKZjcwcWo1WTBzaUsrN2Js?=
 =?utf-8?B?RjljZVBVVGNuUVZybVBWQTNLZWx3Z0Q3bGc0NjJwblYyZnlraUdLOStEd3kr?=
 =?utf-8?B?QVlqajkzVzVDWkliSE52cGd3a1BlankzQlp4MXZOUmZuWlBzRlJqNmVTTzNq?=
 =?utf-8?B?cFZLVjF1Nm15QlJYMkFhZ0g2VnhFbU5mTFZ4QVBHQ1lPTVlHZWFEV0VBWmJj?=
 =?utf-8?B?TkxlYmgvRHFTUUxjV1EraVJYWTB2cUw5L2RDWS9vVEtHQUEzTWp5eTRETkMv?=
 =?utf-8?B?ZEpDa3NjUHlDdUVFeFNFeUVidVJ0T3dIbkF3SGFwSXl2RkpoZjVrMGdnOFhF?=
 =?utf-8?B?NUtKMGdacDREdTZxWW16OFJweTc2SkpBZ2pPSG5EYktudGsrcG1STGc2S25o?=
 =?utf-8?B?VTRwUE82bWVyQWNXUnhLQU8rcjZ0WU1hblRpRE1Jd2hPWklxVTUxMGpONGhv?=
 =?utf-8?B?OGl2ZGNTdlN0S3E0dHR3YmlZZ1dla0FHakI1Tmh5TDNsUWp4aTZsK2RqTjhG?=
 =?utf-8?B?aXRGTVBGNDFYSWFhenJLYTQ2UDZ1dy9YUzFIa3lJa0c2c0k5cjZiUklKb2ZI?=
 =?utf-8?B?bmRTY2RFdU1qcVVWeEhPZGpWQ29LclhVQnpVbTZkS20vM25QdTJpN3hPbW12?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YHWYdJcNMFBqmONmLCrh1cbfAj633UZf4zwWUXb/F9QDvEaXzNaz7kSpxaOgz2UquTupVjongsS4ytRAbJyLoJSRgg2TLHMR8HOskEDlA8nUpCffi22RA8+cNuMkED6HOkDrKBW0N0UWVaeTr3OHPEMjRh7dfHvQ/tjBtnWQWxkrJoY+SQClBHcL5sDlrGKHATyea92uHHvjwUAbHLfE5aUvVft1ne3Jue0pfTfM4sC346eMSkOh7jjQaqZjtPm+TfxMjaN1akmnd/QZwzAoC6ItSNSSzO0iZnXqOnGECdduV34RB2oNlQSbPn15SBNvW3cP4/GqJEHf0/lzUig6yW6NdH16AZZIDhqRHrGM3tOXMLBWjcBfEMtxtM2sOLkpLVE1q9RJggu63WEKG0HjHQyFBIuST2ZgGsnydY+RKArkNWbr8QqY/8nysPxzVb76ehQWYchbBRdQYeQH9q1lcDrPpdgFKjFS4YgpatDvVbidG6XkBqnkhG4pppKdI5zviS4F6Dgg1U7TeQZD1GgIApFQfQ/k1VXxug+UNlrUpUJpYj7hXK16mqnL2rTKxROCAfCLaM+Zk3JSYSGXABZ4jqyGsg8x1KHcf5ruzqweRQ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67a5103-8c65-4b51-6c49-08dcd1db210c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 20:57:06.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orZywDvr6CoLmFO2Hcu9MrL8cUqtq66A7e7lKM4clRKNalTCFWSkk4xziEd/nXiu8g3K1oM4nEbgfiDe1+g5OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_08,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100155
X-Proofpoint-GUID: 68PVbvXV5bAIFZSKb-tuidVGGkIl4--O
X-Proofpoint-ORIG-GUID: 68PVbvXV5bAIFZSKb-tuidVGGkIl4--O



On 9/10/2024 12:49 PM, Kuniyuki Iwashima wrote:
> From: Shoaib Rao <rao.shoaib@oracle.com>
> Date: Tue, 10 Sep 2024 11:49:20 -0700
>> On 9/10/2024 11:33 AM, Kuniyuki Iwashima wrote:
>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>> Date: Tue, 10 Sep 2024 11:16:59 -0700
>>>> On 9/10/2024 10:57 AM, Kuniyuki Iwashima wrote:
>>>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>>>> Date: Tue, 10 Sep 2024 09:55:03 -0700
>>>>>> On 9/9/2024 5:48 PM, Kuniyuki Iwashima wrote:
>>>>>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>>>>>> Date: Mon, 9 Sep 2024 17:29:04 -0700
>>>>>>>> I have some more time investigating the issue. The sequence of packet
>>>>>>>> arrival and consumption definitely points to an issue with OOB handling
>>>>>>>> and I will be submitting a patch for that.
>>>>>>>
>>>>>>> It seems a bit late.
>>>>>>> My patches were applied few minutes before this mail was sent.
>>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/netdev/172592764315.3964840.16480083161244716649.git-patchwork-notify@kernel.org/__;!!ACWV5N9M2RV99hQ!M806VrqNEGFgGXEoWG85msKAdFPXup7RzHy9Kt4q_HOfpPWsjNHn75KyFK3a3jWvOb9EEQuFGOjpqgk$
>>>>>>>
>>>>>>
>>>>>> That is a subpar fix. I am not sure why the maintainers accepted the fix
>>>>>> when it was clear that I was still looking into the issue.
>>>>>
>>>>> Just because it's not a subpar fix and you were slow and wrong,
>>>>> clining to triggering the KASAN splat without thinking much.
>>>>>
>>>>>
>>>>>> Plus the
>>>>>> claim that it fixes the panic is absolutely wrong.
>>>>>
>>>>> The _root_ cause of the splat is mishandling of OOB in manage_oob()
>>>>> which causes UAF later in another recvmsg().
>>>>>
>>>>> Honestly your patch is rather a subpar fix to me, few points:
>>>>>
>>>>>      1. The change conflicts with net-next as we have already removed
>>>>>         the additional unnecessary refcnt for OOB skb that has caused
>>>>>         so many issue reported by syzkaller
>>>>>
>>>>>      2. Removing OOB skb in queue_oob() relies on the unneeded refcnt
>>>>>         but it's not mentioned; if merge was done wrongly, another UAF
>>>>>         will be introduced in recvmsg()
>>>>>
>>>>>      3. Even the removing logic is completely unnecessary if manage_oob()
>>>>>         is changed
>>>>>
>>>>>      4. The scan_again: label is misplaced; two consecutive empty OOB skbs
>>>>>         never exist at the head of recvq
>>>>>
>>>>>      5. ioctl() is not fixed
>>>>>
>>>>>      6. No test added
>>>>>
>>>>>      7. Fixes: tag is bogus
>>>>>
>>>>>      8. Subject lacks target tree and af_unix prefix
>>>>
>>>> If you want to nit pick, nit pick away, Just because the patch email
>>>> lacks proper formatting does not make the patch technically inferior.
>>>
>>> Ironically you just nit picked 8.
>>>
>>>
>>
>> I have no idea what you mean. I am more worried about technical
>> correctness than formatting -- That does not mean formatting is not
>> necessary.
> 
> I started pointing out technical stuff and ended with nit-pick because
> "I am more worried about technical correctness", but you started nit
> picking from the last point.  That's unfortunate.
> 
> 
>>
>>>> My
>>>> fix is a proper fix not a hack. The change in queue_oob is sufficient to
>>>> fix all issues including SIOCATMARK. The fix in manage_oob is just for
>>>> correctness.
>>>
>>> Then, it should be WARN_ON_ONCE() not to confuse future readers.
>>>
>>>
>>>> In your fix I specifically did not like the change made to
>>>> fix SIOCATMARK.
>>>
>>> I don't like that part too, but it's needed to avoid the additional refcnt
>>> that is much worse as syzbot has been demonstrating.
>>>
>>
>> syzbot has nothing to do with doing a proper fix.
> 
> You don't understand my point.  syzbot has been finding many real issues
> that were caused by poor handling of the additional refcount.
> 
> Also, removing it discovered another bug in manage_oob().  That's a enough
> reason to explain why we should remove the unnecessary refcnt.
> 
> 
>> One has to understand
>> the code though to do the fix at the proper location.
> 
> I'm not saying that the patch is correct if it silences syzbot.
> 
> Actually, I said KASAN is handy but you need not rely on it.
> 
> Rather it's you who argued the splat was needed even without trying
> to understand the code.
> 
> I really don't understand why you are saying this to me now.
> 
> 
>>
>>>
>>>>
>>>> What is most worrying is claim to fixing a panic when it can not even
>>>> happen with the bug.
>>>
>>> It's only on your setup.  syzbot and I were able to trigger that with
>>> the bug.
>>>
>>
>> Really, what is so special about my setup that kasan does not like? Can
>> you point me to the exact location where the access is made?
> 
> I don't know, it's your job.
> 
>>
>> I am at least glad that you have backed off your assertion that my
>> change does not fix the ioctl.
> 
> Okay, I was wrong about that, and what about other points, fragile
> refcnt, non-WARN_ON_ONCE(), misplaced label, no test, bogus tag ?
> 
> 
>> I am sure if I keep pressing you, you
>> will back off the panic claim as well.
> 
> I also don't understand what you are saying and why you still can't
> correlate the splat and the sequences of syscalls in the repro.
> 
> 
>> You yourself admitted you did not
>> know why kasan was not panicing, Has anyone else hit the same panic?
>>
>> If you can pin point the exact location where the illegal access is
>> made, please do so and I will accept that I am wrong, other than that I
>> am not interested in this constant back and forth with no technical
>> details just fluff.
> 
> Please read my changelog (and mails) carefully that pin-point the
> exact location and reason where/why the illegal access happens.

This is the explanation in the email:

 >
 > No it did not work. As soon as KASAN detected read after free it should
 > have paniced as it did in the report and I have been running the
 > syzbot's C program in a continuous loop. I would like to reproduce the
 > issue before we can accept the fix -- If that is alright with you. I
 > will try your new test case later and report back. Thanks for the patch
 > though.

The commit Message:

syzbot reported use-after-free in unix_stream_recv_urg(). [0]

The scenario is

   1. send(MSG_OOB)
   2. recv(MSG_OOB)
      -> The consumed OOB remains in recv queue
   3. send(MSG_OOB)
   4. recv()
      -> manage_oob() returns the next skb of the consumed OOB
      -> This is also OOB, but unix_sk(sk)->oob_skb is not cleared
   5. recv(MSG_OOB)
      -> unix_sk(sk)->oob_skb is used but already freed

The recent commit 8594d9b85c07 ("af_unix: Don't call skb_get() for OOB
skb.") uncovered the issue.

If the OOB skb is consumed and the next skb is peeked in manage_oob(),
we still need to check if the skb is OOB.

Let's do so by falling back to the following checks in manage_oob()
and add the test case in selftest.

Note that we need to add a similar check for SIOCATMARK.

And this

* [PATCH v1 net-next] af_unix: Don't call skb_get() for OOB skb.
@ 2024-08-16 23:39 Kuniyuki Iwashima
   2024-08-20 23:00 ` patchwork-bot+netdevbpf
   0 siblings, 1 reply; 2+ messages in thread
From: Kuniyuki Iwashima @ 2024-08-16 23:39 UTC (permalink / raw)
   To: David S. Miller, Eric Dumazet, Jakub Kicinski, Paolo Abeni
   Cc: Kuniyuki Iwashima, Kuniyuki Iwashima, netdev

Since introduced, OOB skb holds an additional reference count with no
special reason and caused many issues.

Also, kfree_skb() and consume_skb() are used to decrement the count,
which is confusing.

Let's drop the unnecessary skb_get() in queue_oob() and corresponding
kfree_skb(), consume_skb(), and skb_unref().

Now unix_sk(sk)->oob_skb is just a pointer to skb in the receive queue,
so special handing is no longer needed in GC.


And more:

The splat is handy, you may want to check the returned value of recvfrom()
with KASAN on and off and then focus on the root cause.  When UAF happens,
the real bug always happens before that.

FWIW, I was able to see the splat on my setup and it disappeared with
my patch.  Also, syzbot has already tested the equivalent change.
https://urldefense.com/v3/__https://lore.kernel.org/netdev/00000000000064fbcb06215a7bbc@google.com/__;!!ACWV5N9M2RV99hQ!MiZQCdyNumVmB3YeKfZxVbJFPsouXDCN7ie5DBfjBiurJib1D7k4bO_Jg1cAie9KIkAgXezFUaGOFhg$

None of this points to where the skb is "dereferenced" The test case 
added will never panic the kernel.

In the organizations that I have worked with, just because a change 
stops a panic does not mean the issue is fixed. You have to explicitly 
show where and how. That is what i am asking, Yes there is a bug, but it 
will not cause the panic, so if you are just high and might engiineer, 
show where and how?
> 
> This will be the last mail from me in this thread.  I don't want to
> waste time on someone who doesn't read mails.
Yes please don't if you do not have anything technical to say, all your 
comments are "smart comments". This email thread would end if you could 
just say, here is line XXXX where the skb is de referenced, but you have 
not because you have no idea.

BTTW Your comment about holding the extra refcnt without any reason just 
shows that you DO NOT understand the code. And the confusion to refcnts 
has been caused by your changes, I am concerned your changes have broken 
the code.

I am willing to accept that I may be wrong but only if I am shown the 
location of de-reference. Please do not respond if you can not point to 
the exact location.

Shoaib


