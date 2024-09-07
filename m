Return-Path: <netdev+bounces-126202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0B2970013
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 07:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB61284A17
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 05:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7D53EA71;
	Sat,  7 Sep 2024 05:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WVfk5lm0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YkilX4m7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FD2249EB;
	Sat,  7 Sep 2024 05:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685607; cv=fail; b=UEnNxhbMozspIw/5E8P0mwvXTsLLRsimpLux9RWp3+UX1/pFwoiLoG6XI88KaDUjbSY9GZQWmVRCyxshuGrEZqYMQD7Lks4/SLNRA36FoeTcSH7NmP4puPjNVyqzUzDxhNDrh8w4v9Jm6+5XgTsNDjMa4KbDQYpBq4BxmV0+IZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685607; c=relaxed/simple;
	bh=NgJu/Domw92wkoGvNUy2XHkeAVTxS7e2KdofigLVvfM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NbyFqpVCVtkIpiiJUXL78H1wFrYDcTfM25nmK/36fcpIImcRGSDrF/zDx5hyX57VJtaT6wG3omlmXFOEDd4E8+RbsYIs0+dNP88bMm2/BdO53r5oWcchKAOsYJXTm6tIcALrDd9o8nF4aaPSYMNfKi0mDZ7j9fjf4sjSE66MtHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WVfk5lm0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YkilX4m7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4874iULI031329;
	Sat, 7 Sep 2024 05:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=1u2lawO5XHl16WESt/WmQCFkGtdyzz8i9EC4IwfBnF4=; b=
	WVfk5lm0q64Ue3vMGs0YAaTpvNufzSaVp/Q+YUl2p+NMCcdHrCKLcZ6wk0wFdIvP
	B5LlJ/G3LN3TTcIpPGihYHP2Za/5mxnE50/79EOpcpduwFgABrzxJrjTnALKdtkV
	2C5/2NOe70+APuGRnbr3TYAjtRt//9VssTeeBFzGdgVF0RteBGH7X6d8O6wxPKel
	gWPr3QR+BoCwgIZ/HYO1Gm7uZt58yuRKbBXl6l6byVSeKdr1gW/p5zKjyHb16guD
	lM5DRynMdpThjeN79O4geJRm5v5vaJbuQhyTUn1c+41RSEJ+qEb91O2HBc12JK9o
	r0Ejfw1BajreElSf/bGrpQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gd8cr3ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 05:06:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4871Y3oB032386;
	Sat, 7 Sep 2024 05:06:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9btv09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 05:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKlSl01eKgLOTJ3/lb8+yL0YDsbnHn9lszaPsqk0s+gCJXSLcf12hgxUy14imafXr0KoA5ahXUop9INTnQoTjm25XoCyyGN91Md28mhFl7PjzPokCRqb8a7YNL04lEng/KO1bpDtLS0mdZG4DzOlc44J2nBPGnjiXp4Hp70VNZeUuwDCuFuuzTJ1SVx4Yt9u6GekkKzVZcNV7cO6TUtg7Nrc9lBYiQJrntMF2nIbvGJib9FT+n9gVQfglfKaztRxOyzlSjbsrhgFgGiWw5IXRAc26m+hg35VmyGNvq0nTrS/la+5Bq6J8mPuqD1biZ3Fdb7AZe852vE2O+imZyirlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1u2lawO5XHl16WESt/WmQCFkGtdyzz8i9EC4IwfBnF4=;
 b=vML2elPc3Depzfu6D8ndN9HgFxDhE97oAclMwqZ+bDm8w7S8OcVCzxdZpTLMwKT3V1z5STIRyna8n3ZSV5IDRYeixG/dq/qMTk+LnrnfH18rrDQqXjlUSMOx3HpzwOWOsxm8+olCzob1SsmPllS0ojKrFQh9M37sx/0ECyw/W3uwqCfvJAXwb9OJeK7b3FKe7hyKZ+B18cEhRHikDT2YgygmHsV5gin2CJeGCOMl6Pj0rtyBN7EfyPf9OXg3Q5JR4ZrCuxeQh8zq8AVU8LeH81eL6QMvfTkIYTsVM2/kQH+GrbMsj5yRX7E6rmhDVlByN6iRZDpF+DaXMzeT/ao3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u2lawO5XHl16WESt/WmQCFkGtdyzz8i9EC4IwfBnF4=;
 b=YkilX4m76lBYyb/I/QIXzT4ecjRU1RbTgQLsRFGJgOzV0GJnoOcWhLhNaCX5B5WDfUnexqmcb4yd57TeBJk9Dk3ax6YxuUaatyThsbpRL9Uxf3iVAozIDJiAjyTqJkw6WxsYWBuV1y/EY6jLQZXY43BXcuiJdO36tcUXCVyUnhY=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by PH7PR10MB6530.namprd10.prod.outlook.com (2603:10b6:510:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Sat, 7 Sep
 2024 05:06:29 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Sat, 7 Sep 2024
 05:06:29 +0000
Message-ID: <2abf390b-91ff-4f37-a54d-0ceac3e0ee61@oracle.com>
Date: Fri, 6 Sep 2024 22:06:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
From: Shoaib Rao <rao.shoaib@oracle.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <e500b808-d0a6-4517-a4ae-c5c31f466115@oracle.com>
 <20240905203525.26121-1-kuniyu@amazon.com>
 <19ce4e18-f1e0-44c4-b006-83001eb6ae24@oracle.com>
 <CANn89iK0F6W2CGCAz5HWWSzpLzV_iMvJYz0=qp3ZyrpDhjws2Q@mail.gmail.com>
 <c45d66d7-64fc-4fa8-8c38-ab2e9ca65635@oracle.com>
Content-Language: en-US
In-Reply-To: <c45d66d7-64fc-4fa8-8c38-ab2e9ca65635@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::17) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|PH7PR10MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8ca915-9a88-4b46-1805-08dccefad4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3dtK1VuV2NNcWlSNktweWw2SmJqMUdRdXE0WFdKQy9ZU1FkQk41dTBnR09T?=
 =?utf-8?B?a0NUbnNGWmpoUExOQ3dDM2ZYYnp4d1Q5QlpDTU1XRlFPVGk1ZzgrZ2ZNaWRN?=
 =?utf-8?B?a0dhZ0gyMStHZVp0eTJsbW1tb0tXcklmc2VKaGtNalJ0b0dHc3o5QmRsNzNn?=
 =?utf-8?B?UldFakVOVHhob25nTmx4dHpmSlNlNTZTemdhYnY2ODY4enpKMkp6L1VHQTBj?=
 =?utf-8?B?Y0VvTzI3QkZRdXc2eTFRTGdkUnBtSjZpT2JRZkI4VHhRNC90VjEvOStiZkVF?=
 =?utf-8?B?c1ZrMUtZYmF6by8rZStOUGR4d1J1Tk0rK1VXc001Q0dsOS9IYitFcFoyeUI2?=
 =?utf-8?B?STRRNENjNUJQN2tsSGxmWkFHajlkZDlYb1FpRFphdHN2SHV5Qm5oT2E5Vm1o?=
 =?utf-8?B?VGdoUUtsYWlBcjB5UHpybFlSTXZrR1JWTERNT1lQaXBJbk9saUx2VENDTlFN?=
 =?utf-8?B?WjZuRnM2K3RhNEZCTExqN1RhdnQvTmphME92WXJ1QjBvd1R2b0dVelBBSThm?=
 =?utf-8?B?dXFDWVlJdmtoc2FXM29wS01QL2VOd3c5MTJwNlhmSnYzTEdqdDA3NnVBZ2Jw?=
 =?utf-8?B?WmRtRnhmNW13cE5nNS92UmYyV2NyRzZ3OFNYTGNYSEliZDlyclRtRk10TEFx?=
 =?utf-8?B?dXhWUGlSRGtsVDhvZnNSeWg3QnhnemY4TW9CYmhuY3J1WkRsdWVNQ1UxMGN5?=
 =?utf-8?B?NksybUpibTUrVXJSZmNLRVhXeDJyUEdlYXQ2ZzdwSVROMFQxTDc2STRacmVy?=
 =?utf-8?B?WlpaNVBkU1pSZWE2WUh5Qnl4cWlUcUZJOFBTdncxZFVtUC9WY2hnVTNLZnFE?=
 =?utf-8?B?WGdHZVdJY0NjY2lndVJuZmIzRjVrL3BWL3hSTi80YTJkc2pBdjlmZGEwWHVu?=
 =?utf-8?B?clNZSVYrbzNWVUQ3dUZES0xiT1BIQytRTUM4eFdpTDFRNUlPemZBMUplQnp1?=
 =?utf-8?B?UXhZWnExbmVRQjZCS0tPQ3hVd3VhdzhLc2c0djFGOFZrMlpsUnlXallCRE5H?=
 =?utf-8?B?YUJtVC9Yb1p3VjdOQmc5cGlJMlE3Z3pST2NRbXpJelQ4ZTVFQy9kNWcvZDl2?=
 =?utf-8?B?NWVlWEZGSEFzYWNVaWd2YTcxem5weFZWL2hvWFYxZFhOa09icTN4ZUovWHFI?=
 =?utf-8?B?azRsRnRvSzd3VGRBSGhmUUdHTkY3cU5iNGxQeDQxRkZJdnBHOTVvRnVtQy93?=
 =?utf-8?B?dUFDMFNwWmJ6OGVWajZGbWFucFpVZzBEdUNQZDRWc3prSStQTjhZUkJiZXIx?=
 =?utf-8?B?Q2FTZUJXMjg3YWE1cktSMkFXU0wzbEhiSXNBOWpVUHFBTStYNE1lSFRHTWEx?=
 =?utf-8?B?cjV2YWFoTW9CMVlYSERGckJJZzM2WHUxdzZuMU1Oa0JRQkZ1eVZCRTVOay8z?=
 =?utf-8?B?UzhiL2ZoYklCNSt4dDlUSEU0MTk3dCt6emtsZ3AyRDZ3SDRXQmNjNDNPdWNu?=
 =?utf-8?B?ZS9lYkMxVmY1SWgycXVoK0J2Q00zM3BrTkdML3VMMWlTSFlwYm11eFgwWERj?=
 =?utf-8?B?a0hmeW1zY09rWmM0YUFxV2tTeXNPWGhTMkpQQjZBNStGencyMmZtS1VBY3NC?=
 =?utf-8?B?T3dqdi8zYkhlV3BWUkNEd1hobXpvNFhDUTB6NkhjVnE3azR2NENRelVwNEZq?=
 =?utf-8?B?UjlHNHVsUDZmMkJuZzIwVm5vWHIvRDB0aCtRNGNycU1QMHFuUlplVXJ5UHVX?=
 =?utf-8?B?YWYwWCtPTWxtZ1FRMEN5MFh3S0hMWDZVOTJ0cmRSVE1YYk5ld00vbjRGRVg5?=
 =?utf-8?B?MkszY3ZzcVRQTmxreThWcVZORitNbnFBNzhscmQvUDlPc2dRMFhDdkp1RXBB?=
 =?utf-8?Q?DEpY4fi/0zIHYN6cWCC1XfMb66a7pfvUbScUY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDlSOG4zT3daZzlEeVA2QTNmWFZrNWV1NjhyZ2taT0xHSmtGYUxTTzNUTCsr?=
 =?utf-8?B?ZWZLZzZoQlh5T0orV0RxYmpPU1dxN1ZaMVBON2lUalhBeHloNlgxSHdsSENy?=
 =?utf-8?B?QWdqNzF1YUx3dVNQQXdQd1NTVnNqeCtYYW9CMnNIbTFLZ1JHM1g0MzFRc2tS?=
 =?utf-8?B?L2ZyYi9ETnpCUlh4bWZiQVZheWRLYUg4dEVaaW9QTkt6SU1BM1ZZUE1PMWtw?=
 =?utf-8?B?RlVkT3NjeE9MdlhuNW1xaFllNHNhakRoakJ0L3UxKzUyZHIrM3ppYkxtQWpn?=
 =?utf-8?B?Qmp1ZkhFSWt2WWpOanBTamkrancvU0hXY1JBV3h5YmI2Q0NKNnN5ZEQ3S0ZG?=
 =?utf-8?B?bXBLV3hwa29BTTNMVVdLV1l2SnFHTGZaZGhYSmJ1L2dxWkJCZ28xWEpMRGR6?=
 =?utf-8?B?b2V2WFJRQU85TmFrVkVCOUt2TDhuRk5qZUtDb0hPMEJWdnh6eEdscFg5bjFO?=
 =?utf-8?B?WjhYQnEzd3kyUnVLbXAvYktoajZvVW5BczE0ZWkxUTJWTHR2dXI4bjB1WGJa?=
 =?utf-8?B?a1dwR2ZOdndMM01hZStXRW5rLzlmOTJXR1NLeUd1R3V2K1FGTlNYU29IanZm?=
 =?utf-8?B?NlVwZHlhUUtTWlpyeUwyeEdINjQ2L0JrVHNSL1pUejFkNFVhRGM2eG1walpC?=
 =?utf-8?B?bUFqakdCQTlzTXJ4ekwzeTFQNVpxY0REM2hYTXFFa05MSHRXaURGNTdKY1Bl?=
 =?utf-8?B?NmNrREFsUkoyRGZQM2NxZ2s2M1pWemx6c3R2WEw1WDdYUWNYMVN5N3FDdUhC?=
 =?utf-8?B?L0FxKzFSZ1ROei9uSWp5RkRnai92SjU1ZXJhVkNTQ0diMVI4ZXhlM2tzNEU1?=
 =?utf-8?B?ZlVKbFZTd2x1MGR3ZGRET1VFMDZmcy82RjcrQThOQ3hvcmpJMU56WVhGZjNL?=
 =?utf-8?B?dThMZVdLUWs5UDRoYmZIb05XSVZnUlNZVFVSWWgrQzE2K0NETGN5dXZ5eEJW?=
 =?utf-8?B?YlF0bU8vRHUzVVRWZWluQVR3VnNXTjFhK0IwTnEvcm5iOUhOSmpBVU54SGpR?=
 =?utf-8?B?U3BzY2ZkMi9iM2pCTk9NM1pDcUtWMldTRmp1KzByUG04OWdDUnljaE83Umhr?=
 =?utf-8?B?d0d6ME1BdGZuVnRkZkI3bUpZRHpsQlplRDFtei9SanJRbzNCQU50cHY1cDBr?=
 =?utf-8?B?NUJ4VXB0cnJmanlBdXEwbzJZSEtQb2J5MDRPZ0ZWbEcrb0J2dnFUcmVTNUhO?=
 =?utf-8?B?YnJ0WVBDbXZMS2xIVXgrUEpMRnorRzNxTjdwR3NOK3BiNHZnZlg5T0dlNGNv?=
 =?utf-8?B?di9RUHhWMXExakpBT1BSdStKL29GRTBqVEcxSktGRlhCd21YVUhPUUxzbUhS?=
 =?utf-8?B?S1JKUTZBNFRqM090NVA1bXVocEU1NmREQU9mV1RxeDk5VjFhRDRUSFNhWDBI?=
 =?utf-8?B?cytIOHZIdzZPWmtJclVOTXVYT3Fxc1h4T0VNWkxyR05wQ3U1MGxCVnUxdTdn?=
 =?utf-8?B?WnB3T0pXU3Y0Y0FvOXJ4MXVFaDZkYys1YitjbExnZVRGWU5iQmJhTENXM01Q?=
 =?utf-8?B?cERzVmFwUC83NkdjOHBGb3dITytvMEU3TUp1WHFVa3BhT2lOZ1R4OXd1amR2?=
 =?utf-8?B?MXM5Qzl2YjBEQ1V1SUFsMUJqUjc0THJmMlhJZ25tTGUvTEJCYm9TK0crMGFt?=
 =?utf-8?B?aWkvTDNsbFZHMDBhbG42WjlsWnBTS0FYTG00eXVGemx5Lyt2UzFxanFydUNp?=
 =?utf-8?B?dERlZzBvdndmOGFwUDJoV1BORWJ0U3R5bTZLRWwvYVVOODlLK1AzT0t6dUtx?=
 =?utf-8?B?eTNONXdxemJlSFJ5UGFienNvS3dBQUU3c3ZmOXlLSjJKS0J5bVVGMGZHZFNQ?=
 =?utf-8?B?RjIxRzNTblg3Ri94L2IrN1lOMTZRRTdQZnZFTGtERWtoNk1WZ1loU0p1NmZl?=
 =?utf-8?B?WXZqVjFrZ3RZY0hSRzFZMDBIYmt0YU4wemJWSDhvRWNyRSt3Sm5tUlNiVkl0?=
 =?utf-8?B?eGd2ZnlRNzZkNVBWZVlWK0ZOdEhtTytuN1F4bURQWUFWR1FuTyt1SnRPU090?=
 =?utf-8?B?enZkS0MrNEw2bk43M3p1OElsclZuY0dQTm9OS2daT0dxLys4MlJqUmRDazZH?=
 =?utf-8?B?TEoxMUloamh2OW5tRExVamRYTWRaR1IwS2NUcWdMVStXT0ZZWEx1N05mUG81?=
 =?utf-8?B?aVRPbkFoT1VpUzVMcE1FdHhDYytuY0RVVUpVZmt4a0xmNEtISk56WXM3ZFF5?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TyHRqZOrq/14W7cwS0HehUI3TMlsIaDYFoaP23OZnwIHxJ/PaaP/0QRwIrCDUjEBLUZT2zOPw1Zvzd9PrzdvX/f4FADtvDGcC9mRgbgVehLCw3zYEwhS3B9k4N7s84wsM7n6E9UDAUkPNk0B47Ul3Mk6AqEG2D4pQlrm7rJo/hunsJyK/FjsUOBAlUM4/4ZL5fk9bZ6MMCQlbFwYCnpzg2L02d+4G5+LpcJkglhORd61Rx9/Lsbo7567oKkKp5mPJ5M0w9EYesn1yViLxgaGo38nOixexvjvYYY+Re79b/SqKs1xOMNNTtlFU+ZPXW68jRPt/aeF5u+8dXgBDulmEksMIRkrV3ijcQuDXwqmzMDdUB5aPY7GxQguiFfiVWatRmCy7owg17zdXmcNQZ/cpN8NWuLKYAE2KeRDkzHdSvSSpzEzTM56ThW4mtjh7cGSQe5UunmRMfeHXfP/cf0oSW4EXsDjiZbBq1ZgpzlKXA7xgppufD95B8snpLbgJp+S4hUMFcqGfGLp7PJub+koB/f/80EpIGpqyDO7rN4z1ZZsVlSZoDF49XALm+HvY89mL6b/BvtXkJ7WLQB8xkpM3idKkC1lIeRDnYejM3+E4NI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8ca915-9a88-4b46-1805-08dccefad4f5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 05:06:29.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXwOo22cIONJMcAYY2K+tNIQVs5EtNtdMDw2dM3+8Y6rez+M+UWzJOIwOkCYaYhqHc1Pno+mK6DKWwHQzHTmxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409070035
X-Proofpoint-ORIG-GUID: RFN-ij9qsSlwCYPRy071CnOVmUnJXLKK
X-Proofpoint-GUID: RFN-ij9qsSlwCYPRy071CnOVmUnJXLKK


On 9/6/2024 9:48 AM, Shoaib Rao wrote:
>
> On 9/6/2024 5:37 AM, Eric Dumazet wrote:
>> On Thu, Sep 5, 2024 at 10:48 PM Shoaib Rao <rao.shoaib@oracle.com> 
>> wrote:
>>>
>>> On 9/5/2024 1:35 PM, Kuniyuki Iwashima wrote:
>>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>>> Date: Thu, 5 Sep 2024 13:15:18 -0700
>>>>> On 9/5/2024 12:46 PM, Kuniyuki Iwashima wrote:
>>>>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>>>>> Date: Thu, 5 Sep 2024 00:35:35 -0700
>>>>>>> Hi All,
>>>>>>>
>>>>>>> I am not able to reproduce the issue. I have run the C program 
>>>>>>> at least
>>>>>>> 100 times in a loop. In the I do get an EFAULT, not sure if that is
>>>>>>> intentional or not but no panic. Should I be doing something
>>>>>>> differently? The kernel version I am using is
>>>>>>> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.
>>>>>> The -EFAULT is the bug meaning that we were trying to read an 
>>>>>> consumed skb.
>>>>>>
>>>>>> But the first bug is in recvfrom() that shouldn't be able to read 
>>>>>> OOB skb
>>>>>> without MSG_OOB, which doesn't clear unix_sk(sk)->oob_skb, and later
>>>>>> something bad happens.
>>>>>>
>>>>>>      socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
>>>>>>      sendmsg(4, {msg_name=NULL, msg_namelen=0, 
>>>>>> msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, 
>>>>>> msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT) = 1
>>>>>>      recvmsg(3, {msg_name=NULL, msg_namelen=0, msg_iov=NULL, 
>>>>>> msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, 
>>>>>> MSG_OOB|MSG_WAITFORONE) = 1
>>>>>>      sendmsg(4, {msg_name=NULL, msg_namelen=0, 
>>>>>> msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, 
>>>>>> msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE) = 1
>>>>>>> recvfrom(3, "\21", 125, MSG_DONTROUTE|MSG_TRUNC|MSG_DONTWAIT, 
>>>>>>> NULL, NULL) = 1
>>>>>>      recvmsg(3, {msg_namelen=0}, MSG_OOB|MSG_ERRQUEUE) = -1 
>>>>>> EFAULT (Bad address)
>>>>>>
>>>>>> I posted a fix officially:
>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/netdev/20240905193240.17565-5-kuniyu@amazon.com/__;!!ACWV5N9M2RV99hQ!IJeFvLdaXIRN2ABsMFVaKOEjI3oZb2kUr6ld6ZRJCPAVum4vuyyYwUP6_5ZH9mGZiJDn6vrbxBAOqYI$ 
>>>>>>
>>>>> Thanks that is great. Isn't EFAULT,  normally indicative of an issue
>>>>> with the user provided address of the buffer, not the kernel buffer.
>>>> Normally, it's used when copy_to_user() or copy_from_user() or
>>>> something similar failed.
>>>>
>>>> But this time, if you turn KASAN off, you'll see the last recvmsg()
>>>> returns 1-byte garbage instead of -EFAULT, so actually KASAN worked
>>>> on your host, I guess.
>>> No it did not work. As soon as KASAN detected read after free it should
>>> have paniced as it did in the report and I have been running the
>>> syzbot's C program in a continuous loop. I would like to reproduce the
>>> issue before we can accept the fix -- If that is alright with you. I
>>> will try your new test case later and report back. Thanks for the patch
>>> though.
>> KASAN does not panic unless you request it.
>>
>> Documentation/dev-tools/kasan.rst
>>
>> KASAN is affected by the generic ``panic_on_warn`` command line 
>> parameter.
>> When it is enabled, KASAN panics the kernel after printing a bug report.
>>
>> By default, KASAN prints a bug report only for the first invalid 
>> memory access.
>> With ``kasan_multi_shot``, KASAN prints a report on every invalid 
>> access. This
>> effectively disables ``panic_on_warn`` for KASAN reports.
>>
>> Alternatively, independent of ``panic_on_warn``, the ``kasan.fault=`` 
>> boot
>> parameter can be used to control panic and reporting behaviour:
>>
>> - ``kasan.fault=report``, ``=panic``, or ``=panic_on_write`` controls 
>> whether
>>    to only print a KASAN report, panic the kernel, or panic the 
>> kernel on
>>    invalid writes only (default: ``report``). The panic happens even if
>>    ``kasan_multi_shot`` is enabled. Note that when using asynchronous 
>> mode of
>>    Hardware Tag-Based KASAN, ``kasan.fault=panic_on_write`` always 
>> panics on
>>    asynchronously checked accesses (including reads).
>
> Hi Eric,
>
> Thanks for the update. I forgot to mention that I I did set 
> /proc/sys/kernel/panic_on_warn to 1. I ran the program over night in 
> two separate windows, there are no reports and no panic. I first try 
> to reproduce the issue, because if I can not, how can I be sure that I 
> have fixed that bug? I may find another issue and fix it but not the 
> one that I was trying to. Please be assured that I am not done, I 
> continue to investigate the issue.
>
> If someone has a way of reproducing the failure please kindly let me 
> know.
>
> Kind regards,
>
> Shoaib
>
I have tried reproducing using the newly added tests but no luck. I will 
keep trying but if there is another occurrence please let me know. I am 
using an AMD system but that should not have any impact.

Shoaib

[root@turbo-2 af_unix]# git diff msg_oob.c
diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c 
b/tools/testing/selftests/net/af_unix/msg_oob.c
index 535eb2c3d7d1..5fedb55adcf2 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -525,6 +525,30 @@ TEST_F(msg_oob, ex_oob_drop_2)
       }
  }
+TEST_F(msg_oob, ex_oob_oob)
+{
+       sendpair("x", 1, MSG_OOB);
+       epollpair(true);
+       siocatmarkpair(true);
+
+       recvpair("x", 1, 1, MSG_OOB);
+       epollpair(false);
+       siocatmarkpair(true);
+
+       sendpair("y", 1, MSG_OOB);
+       epollpair(true);
+       siocatmarkpair(true);
+
+       recvpair("", -EAGAIN, 1, 0);
+       epollpair(false);
+       siocatmarkpair(false);
+
+       recvpair("", -EINVAL, 1, MSG_OOB);
+       epollpair(false);
+       siocatmarkpair(false);
+}
+
+
  TEST_F(msg_oob, ex_oob_ahead_break)
  {
       sendpair("hello", 5, MSG_OOB);

[root@turbo-2 af_unix]# rm msg_oob
rm: remove regular file 'msg_oob'? y
[root@turbo-2 af_unix]# make msg_oob
gcc -isystem 
/home/rshoaib/debug_pnic/linux/tools/testing/selftests/../../../usr/include 
-D_GNU_SOURCE=     msg_oob.c   -o msg_oob

root@turbo-2 af_unix]# echo 1 > /proc/sys/kernel/panic_on_warn

./msg_oob
TAP version 13
1..40
# Starting 40 tests from 2 test cases.
#  RUN           msg_oob.no_peek.non_oob ...
#            OK  msg_oob.no_peek.non_oob
ok 1 msg_oob.no_peek.non_oob
#  RUN           msg_oob.no_peek.oob ...
#            OK  msg_oob.no_peek.oob
ok 2 msg_oob.no_peek.oob
#  RUN           msg_oob.no_peek.oob_drop ...
#            OK  msg_oob.no_peek.oob_drop
ok 3 msg_oob.no_peek.oob_drop
#  RUN           msg_oob.no_peek.oob_ahead ...
#            OK  msg_oob.no_peek.oob_ahead
ok 4 msg_oob.no_peek.oob_ahead
#  RUN           msg_oob.no_peek.oob_break ...
#            OK  msg_oob.no_peek.oob_break
ok 5 msg_oob.no_peek.oob_break
#  RUN           msg_oob.no_peek.oob_ahead_break ...
#            OK  msg_oob.no_peek.oob_ahead_break
ok 6 msg_oob.no_peek.oob_ahead_break
#  RUN           msg_oob.no_peek.oob_break_drop ...
#            OK  msg_oob.no_peek.oob_break_drop
ok 7 msg_oob.no_peek.oob_break_drop
#  RUN           msg_oob.no_peek.ex_oob_break ...
#            OK  msg_oob.no_peek.ex_oob_break
ok 8 msg_oob.no_peek.ex_oob_break
#  RUN           msg_oob.no_peek.ex_oob_drop ...
# msg_oob.c:242:ex_oob_drop:AF_UNIX :x
# msg_oob.c:243:ex_oob_drop:TCP     :Resource temporarily unavailable
# msg_oob.c:242:ex_oob_drop:AF_UNIX :y
# msg_oob.c:243:ex_oob_drop:TCP     :Invalid argument
#            OK  msg_oob.no_peek.ex_oob_drop
ok 9 msg_oob.no_peek.ex_oob_drop
#  RUN           msg_oob.no_peek.ex_oob_drop_2 ...
# msg_oob.c:242:ex_oob_drop_2:AF_UNIX :x
# msg_oob.c:243:ex_oob_drop_2:TCP     :Resource temporarily unavailable
#            OK  msg_oob.no_peek.ex_oob_drop_2
ok 10 msg_oob.no_peek.ex_oob_drop_2
#  RUN           msg_oob.no_peek.ex_oob_oob ...
# msg_oob.c:305:ex_oob_oob:Expected answ[0] (0) == oob_head (1)
# ex_oob_oob: Test terminated by assertion
#          FAIL  msg_oob.no_peek.ex_oob_oob
<...>
ok 38 msg_oob.peek.inline_ex_oob_no_drop
#  RUN           msg_oob.peek.inline_ex_oob_drop ...
# msg_oob.c:267:inline_ex_oob_drop:AF_UNIX :x
# msg_oob.c:268:inline_ex_oob_drop:TCP     :y
# msg_oob.c:267:inline_ex_oob_drop:AF_UNIX :x
# msg_oob.c:268:inline_ex_oob_drop:TCP     :y
# msg_oob.c:242:inline_ex_oob_drop:AF_UNIX :y
# msg_oob.c:243:inline_ex_oob_drop:TCP     :Resource temporarily unavailable
# msg_oob.c:242:inline_ex_oob_drop:AF_UNIX :y
# msg_oob.c:243:inline_ex_oob_drop:TCP     :Resource temporarily unavailable
#            OK  msg_oob.peek.inline_ex_oob_drop
ok 39 msg_oob.peek.inline_ex_oob_drop
#  RUN           msg_oob.peek.inline_ex_oob_siocatmark ...
#            OK  msg_oob.peek.inline_ex_oob_siocatmark
ok 40 msg_oob.peek.inline_ex_oob_siocatmark
# FAILED: 38 / 40 tests passed.
# Totals: pass:38 fail:2 xfail:0 xpass:0 skip:0 error:0

[root@turbo-2 af_unix]# uname -r
6.11.0-rao-rc6-gc763c4339688-dirty

[root@turbo-2 af_unix]# journalctl -r | grep -i kasan
Sep  6 21:15:25 turbo-2 kernel: kasan: KernelAddressSanitizer initialized



