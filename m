Return-Path: <netdev+bounces-152127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFE69F2C94
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD16165ECD
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C921FFC55;
	Mon, 16 Dec 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UE9HR7ak";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x07Ckm4y"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE7D2E628;
	Mon, 16 Dec 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339981; cv=fail; b=jcnmBTiWQ7iYT/AV1e48lBcUS3CnJIDDQ+EZJ5ReQZOKHB7T0e+llc3heJ+Q1JOm8jjA37wjayuvQSsV3jzGowYV+M9IfBBVtMq6JyX8CQE7Er6cwSF+7eUr/jyJ/aHtjbcX2EeqRdZ/BVuFGEJfwByJE916ZopmFkXktr9nAmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339981; c=relaxed/simple;
	bh=L5yJ3MkN5JpVfYvRQaS2e3WNOIzLLIO6CxgV+K6frxU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R3k0U2os6yn07Hwbxc+VjErZ2XvRU/JBTJgEtInGB8bY6pKmuXUShyGu+jB2fw3wlF6iyGQAEAID6zGxUBcPUoS6vDV2It6ntK7fnhc4psI3D/D9pirfEs8Rm2DxAHAZ9J5zQ5DnbTcJHPuNQg3bXxi+AnizUTpUY51IOs4q/eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UE9HR7ak; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x07Ckm4y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG6awtA012229;
	Mon, 16 Dec 2024 09:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=m7+kfOUyHU8Q4uLc64BsYxf2XAmOjm82gh4zlWwJN6k=; b=
	UE9HR7aktNunMreSUuPxDO15ix5gv5M+KtAJgiJETGDlmJTZwjz7+m76i0OEv+18
	vApIqWq459nNHkSrcJziajZvgyMmIGkVU4ACAkxUFyLOm2aTVPf4wLM80f85obcJ
	LtPH24AjWXYlcum5Kuuwi5B0R3w3EROQtD7P4nXzx3mbJc/FY9+gHoiXqXiXjD7h
	Fo5SMfribBclT00Vtg9Qnjag+bBxQz0HVFqQUMdtemM03KSJCEPaZftCnQBMAwro
	+hiHcEQ35k1TOcKG5iQd9+jT44hkF+7nnMfcY8G/90jxoFoqtXPoPDwJjM6erUSD
	cwh8JAM4hJhEDGrFRfzmxQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0t2aqyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:06:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG77kx4006390;
	Mon, 16 Dec 2024 09:06:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7s24j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:06:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fa9e02AszzadtKuWo26aIS81WagDYMmMuQcRhT2mCNwYkIlu1flr8B4iPXICPN3bh6UHMcStvRvI9TvDY/sgCBGoqMZXZzFEbsKngc7Tz7PtMXfXdBxlo66RmFkE4KKATyh3xe9neIGb2XcSzjHPXl4tVFGbJpeLziGuvNz+5loUVlVeG02utCo+Zi3AxskZINC5KfvXHMQsIxoxtFkyX4cl4XudFOFhWG5CTZQsF4kjh/z9n9LaF2sdF2rWukdeGTOfUOyEDVMxqCVeYJd0J8wX2HkFHqXNmJtuP/VeRPLE3JgSPaprXccYCFPPKDrB7OujDUNAM/5TSMwUmBa2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7+kfOUyHU8Q4uLc64BsYxf2XAmOjm82gh4zlWwJN6k=;
 b=kO7h5pn2UGe6IRuNHqWyALecAAFc0Y4KXWcyeiPKM1wTD7lBxDPm2el+/TxNmSU0UMNjLysMJodFS92J8XWpmBrMvfkAXMsedlCumC8dHYYxm5xaTqIQPN951fGAnhjRvSl9/ubP6G6JVgZA6sU5RkxQc07IS3LI0ujK6dHxZ1J51h+40H3hpUo2uuQXqnTLRgCQ6oaSR70k5JMJE9ySJF6uQaB8fJaj3KK0uMAYyRSYtRfOSZ33r4W3lyk2tnwHxErlj3wdLH/3JChZHixjDTtaZZyg3WCqhvVHX3Cluq35GJbgJdgVOsKHbOndpzeZrLq714vZo4lYMbSDREWjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7+kfOUyHU8Q4uLc64BsYxf2XAmOjm82gh4zlWwJN6k=;
 b=x07Ckm4yroymFDC/5DnYP4K8xyTNWojSAPzNog5ga3g5+RYkdZzxS5veog4LhvSL/95fBOW4ThRyIAG8YamWW7omasePBEoPNdgMKmn660Ejw/jZjbERt2NkORacPXOQu+gZGohQSXY9i2qTb9PiMfnE1ACU4ZqTke1fdWyWOF0=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by CH0PR10MB7500.namprd10.prod.outlook.com (2603:10b6:610:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 09:06:01 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 09:06:01 +0000
Message-ID: <b97b401b-e318-412b-8344-a856c6e10eca@oracle.com>
Date: Mon, 16 Dec 2024 14:35:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 1/2] octeontx2-pf: fix netdev memory leak in
 rvu_rep_create()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep
 <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241216070516.4036749-1-harshit.m.mogalapalli@oracle.com>
 <74d65f76-5e3a-44b6-b857-42b6c8cf7789@intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <74d65f76-5e3a-44b6-b857-42b6c8cf7789@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|CH0PR10MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e12ec4-27e1-423e-267c-08dd1db0dca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TW1yRWhtYVVVdXkzWEVieHdwdkErOVhIR0NXMTZzRENwcXVvcnlNY3lRK1Q5?=
 =?utf-8?B?WkR5bFo1OTdWZW5KTndyajVxOEszQW5uNnB5Y3plT0ljeG54QTRXazZwKzRO?=
 =?utf-8?B?NTBsM2cwZEFXZ05EeTV5R0FkQ3RmQXhuTmdxTHRqN1BxY2NOR0tIZmllSjgy?=
 =?utf-8?B?eldSOTE3UE9GcjZ3NmZ4NGJsU1NTaGhyeC9HL21JLytqUkFvaE1XZEhqbTRP?=
 =?utf-8?B?K1dZclNJbit3TmV6cUowL0h3ckdmTHZGMzA2NjZIZWJYNGRGQ0ZNWEtyd1Y5?=
 =?utf-8?B?em1iOERyQXVCYVN5cjcxVlpCOW5NVHFyTko0YlliZU9hMUtRK1R0MWl5RWc2?=
 =?utf-8?B?bUlxbXcyTmJlamx3SUt1aHhJQTRjZXZPN0IvYzBwVEJSYjcySFhZVVdqS3Vl?=
 =?utf-8?B?cVRvZzRvVmE3Yi81L2xQQ1NCbG9pVlZCUFdodk9FbDZCSGwyZzhLNDlMc3pj?=
 =?utf-8?B?MUhPK3VIL1h6UXNYazRTd2p1OFA4bHdWR2tIY1RBdnh2RnVldkt6YWhjOUZM?=
 =?utf-8?B?RHRDS3VHWnNxbFpZSjlrZ1hPdlJscFlXR3JxdloyMnoxdmNkYmZNOUM2Nk1l?=
 =?utf-8?B?NmF6V2lESlJqSEcvbVBuVWdnNFRkVzJWMGg4WVd1K3gwbHZCSnMwdzhINmM5?=
 =?utf-8?B?dnh1SEV1Z25CZ2Zwb3RCYzN2SlQ2OWk3ZUdxWWxNMFZyOEZna0dzYjJnT05G?=
 =?utf-8?B?d0U0bVZWNERaMkJNQ2dyUHliSkQveEdqWCs1WWZmV1I3RS83aDRET0dYZDVM?=
 =?utf-8?B?bzcrVkU2c2NPcGpUUXhqRTBxWE8zQk1aT1VZSnhIaGl1RjJENThKQ1YxaEFP?=
 =?utf-8?B?YTRzbmh6RVFMcm5qVCtCU2Evb2pPRmUwWjZSWUxnbUwrdjJzcWNtSmlad28v?=
 =?utf-8?B?cDgrL2lpbURmRENaNWJKazJaQ2ZPNkd0d1BhMWQwWlRBMVdrbmNSTkcyNld3?=
 =?utf-8?B?Z2J5U2tHS08wMXc4WjdzMGRsYWlrUDJ1djJleC9CVnpZU3RrTmN2RXYvUzJQ?=
 =?utf-8?B?WnJaK0ZqS3kva2dvaU9lS1RocHN2aXNMRVllWlZPRmNSa09uU0RMTWUwcUI5?=
 =?utf-8?B?OXV0dVpjeTU5ckxnSmxUUzEwWjNCS3RoWWE3TUxheW9QWEJ4K1JFZ0g4S2Yr?=
 =?utf-8?B?Q2UzTnRXWDA5TTFpai9tSm5EcWJOVDBONVIzV0NzY3VhUEZtTDhPVG1GNEdG?=
 =?utf-8?B?Z3RpNkhOM2ljcnJzdzFXVkJ6QnlzWXVlK0E0enpQR3RsYjJSMXZ2ckQ0SXlO?=
 =?utf-8?B?akx0WFNNN2RRcXBtR3V2WXJRM1pNVlZRcHVQNVhGdGV4eWRYcEl3SmhYU2l6?=
 =?utf-8?B?VUVwcGpWQllEajJId3A3SXlxbUZxWWcwNStRbld2SGxWeGVUSmdTU2YzUFpa?=
 =?utf-8?B?VGUzd1hpbjY3SzdUK0hNT3RWQVU5eVFoVU9WYUEraDJHazk1Z0JyOWdjM1pi?=
 =?utf-8?B?NE1kbG1Vbm1VK090eDMyeWJvUTR2aGIxZFhkVmRwMzZ3a1diUE1qYks4SHpM?=
 =?utf-8?B?TUtEcGl0SnUyTjd4WGlMMkZxdTNhYUJLK1IwVFppZjhYdWMvdXpnaUM5Z1Rx?=
 =?utf-8?B?NTBlb29GM3MyMGwrcHhKNzQvU1I1S25PNlZGVlVNK3oxK3pNdGJ1bFFmRVFa?=
 =?utf-8?B?UE1yb0dyNEhKQ1BhTFZLK0Fza2hpOGxTSHhUbWVXV3RVOTd4ODVPUXdlU2Q2?=
 =?utf-8?B?N25RekZxV3RYZjVYR1ZFZTBIU1plN1drMWxDZi9LbUJicTFaK3JWTWdPZkN1?=
 =?utf-8?B?b0xsREY1eHlXMjhJWFdWUUx3R0QxZjhVbTc4SklCVWduanlrZnRYUGZRNGtI?=
 =?utf-8?B?SE0xckswYnBqZkUzTEQvSzQ3RzBXemc4eEJTRnltNGVyRDVOMEJ2aUNUUnZX?=
 =?utf-8?Q?hl7gqYfI56cYu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0c1Sk9QUFZsbEZVcWxhOWhnUko4Tm9UUFhSekRnVElHN1JWVDRLRlNSdkY5?=
 =?utf-8?B?cVpFaVVCeHVCa1BFdDM2d0JHZW1tWmZYTDMyOCt3cUhneXhkMnFzb3gySElY?=
 =?utf-8?B?QzNKYWJlTDZkSkZFSjBTZjV0WkwwRFA3QnpZRzlwTFJhalFtbVAvVHVPVi9L?=
 =?utf-8?B?Z05ObG9IR0tvT2dFZStQbjBVOE45TVRQemJEOHVELzY4OG9ZS2tqL3k2VmtT?=
 =?utf-8?B?Mzhacno0cndrNjZWcGw3UnN4L3pQME1MQnQ1cExQNlZJTWV2YUtnNkZOUWVm?=
 =?utf-8?B?RjlqZFpNSVBpQ1JMUi9lcEt4SGo1VDB3SW1oYmVpZTZpbjhrTVAxWFR5bzhQ?=
 =?utf-8?B?dnNab0FiWTlQZ0VKUDlpTzljL01YRVJwN3pyS3ZwN2UvUFhZeHRWOTdZRE1B?=
 =?utf-8?B?UnZCT2Y4Umk2enhBWVBTOE1CMW13UFJ4eUFsQWIxVzE2amxrV01zYUdmalN4?=
 =?utf-8?B?NS9ZdERkUHV4c1VDZUF5RytSaEhpdkpvSW84Y3VtZURJaXdSb3N3VHVieUs5?=
 =?utf-8?B?NHBpYzVUTTFMSmhKNks1KzFjWjkwN2huZytubmVNVTRDRmVPQVNNTytlOHNT?=
 =?utf-8?B?WCt6NitFQ1prR3lFTXJSczVKSTM0Tkh4M0VreUNqWUw3NG9Od1RXS0gxV3Bz?=
 =?utf-8?B?YkpwL2VvRnJVaXhVUHVrNjhROGFNL2kvQnFndTA5dSttWkFRK2FNVXNucllS?=
 =?utf-8?B?VGZKTVVabG9wRFdFb2xrTmM1dmJLay9IZEhMcWxDUGFyZHhja3JJVGlrYVNE?=
 =?utf-8?B?aVN6VXBxRlJ5YTh2TFkxdFRQa2pwejlZZGNxQU00cXJuQ3JjckJHSUY5RFR0?=
 =?utf-8?B?clo2RmxBektLT0hweVdTZldrRUg3MnhEUHFsNUlPZkl3Ny9zMFVvR1AxWk83?=
 =?utf-8?B?ejNXWU8wbmJpUExEaWhmYitGb3paM0k0ekE1WkN5QzJsSmNUWnVEZkUvM01k?=
 =?utf-8?B?RlVYc081Mjlib051d2R4ZFBYSWpRK2hhZi8yQkUza3pWWHhjTURmYzJhOEl2?=
 =?utf-8?B?dDR2UkszVVVoemU1N21tTVY0T0tscmc3UjB0dmNFUWxRSmVuRFBVbVBhQ1E3?=
 =?utf-8?B?WUVjR3hneTVmQ0dMb0pNVW81aGRBUUdjWXoza2MwZlNpWHNXUFM1ZUl4VC9U?=
 =?utf-8?B?U24xcFR0MmJSSzdyeFpOY29HTzhSdXhBVmpFUlJKNHdxUHZ4UkV0N0VlMlU2?=
 =?utf-8?B?Z0UraENZcTZIWlQzQlZnWUN1M2xZTlNrK2c1dTZnekNQZER6Zk5NYmF1ZXUr?=
 =?utf-8?B?NEFTVGZlRVVLYVZDRFVSSnJ4ZHhFK0g4dG9OY1BlVXdGYS8vRXgzRVNhQjJp?=
 =?utf-8?B?V0hNYmtCZWUwZjh5OU9PZURBV2NyWGdzcnpnQ1NkMFRzM0dZUUFJdE1nRVNY?=
 =?utf-8?B?ZXI2cysvUmFaVFFzNGlVTExRNVZ0dlh3UXFZL0Uwa1lCZVByOXErOVdWWS9J?=
 =?utf-8?B?bytIUktieWMvdkNGZ1ZzbDZYUmthZ1UrKzhlYzRLL0ZnNGlLSmFDbG9FR3pV?=
 =?utf-8?B?QkliN0tRSGhKYmR0REFTaU5zNjhiVkkyOGRpREUzS243V0kvRW1lMUZBcmtO?=
 =?utf-8?B?V0ZGbkNtTFB5NDFmL2pRR0pyUWhZTkloUzkwZmZiMk5PeEs1cnlENWRnK2ph?=
 =?utf-8?B?VUFZbnVKcTZmWCtWekxIK2ppSUFQeHYrcWNsWXhuM2dBRGpYbTczN0srRHdI?=
 =?utf-8?B?YVRnd3dOby9Zb0RQaHZvZWRrS0VFV0hSTk9MUEpjN2NybVpZRE1hdHRMcjFp?=
 =?utf-8?B?Ris2MXc4bmRFV1VUeWphajF2ODErdGZ4eWpFaWluZ2QvbGZ0bjNGbnZmY2xT?=
 =?utf-8?B?enUxYUk2QWRvZVhhdExQeDkvQ2ZjdWF4SEMyOWgyZ2lmNURtL1dXWklTSHo5?=
 =?utf-8?B?a3MzbVJTaWtEOVQ2bUpza25hV2Y5SU9EcXF5Wi9CY1RlZFp5aEplMVdudDg1?=
 =?utf-8?B?MzNHQXpNSlhQMXA1cisvNG5Ydk1vRTNKRFhJQlF1eVdVaUVMd2xjWFVvMFB2?=
 =?utf-8?B?MGdsRzA3Q0d1QlFIVVpmYkNnRE90QlkwQUFDTHVhbFBiSmhXZjN0V0ZIU2du?=
 =?utf-8?B?VG53ZjYxajk4ZE9NbTVEUzNOUm9YbThUa2ZpKzdSL3JZQm01eXpya2F3SWNk?=
 =?utf-8?B?VFp5Ti9uS3N4K0JqUmJ6eFZGQmlhVFVTR1c1TmlxKzdFZmI4bjY5OHhSa0Ev?=
 =?utf-8?Q?a0IxnKup4+O4g5SaxP6t3fM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z0ngvbSC1UByIi0TUvbnE3BfRy1uTkBO+TigfkwMaPDxvvV7zEHTdENEE8ZIFADhNpnVsWt/2++8+Naz8wavho/6MXI5RER6ER/95lsJbLZwnkOkpWnfnBU8LnNlgd8/vYegFe+NDQiDP2QSqalxFkS5qS8he0lo9pTKuhAzFnWaK80GkkE7lwttbjtwDYhcPx+z+CgG2d9gQBTtSiCg4MZXK5SDbpTd+BZ5U88AGVy18miqdu7gWyH+0ox0iFP1CwjZKAU3n/If1Dx357FbI+2etfZQtcrRt3thhGfM+YViXwUxisbmyFTGuZkU09Skv8EfZrQt+azEHbP3DYJ8jUYF9SB2i87Gw1kxL0w+lnbFiRHU1sAoYVuK5DwRyGnSGPoV6V77Ny4XzEKDYiRUiTFz7NyyjfSukvvXBWcyeQCQlg7YhdPSqwdD2mUQXZJPn1DiHx/FwvZjyaMx0dJmEmCVQpez3Rzavu0/GJUf5eTk5VzBszCvWwWQh9iIIOGqVQyPhjxRfotTPiFHYFZ2r81mNzm1GcBcwZHFB3poK680+zrr0k2HQDUqKaJVAvJjhS7mXtZrKYKxrG59Spo1efv4G2f1RggAc0fKqJrcJk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e12ec4-27e1-423e-267c-08dd1db0dca3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:06:01.3038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W50/WoACgld56xhzNEmWXKITuvRRCGXCYVEQhsHRfzyB5RvGPfLQ7Nt9t8inHBTVV1s/CIqE3ZXxVIqvzPZ3vJvXRYCU9S0OJcY7wIoCNHzo06w9fMt+BChjmQ6MUmTI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7500
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_03,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160075
X-Proofpoint-ORIG-GUID: XdUdInUfnFZ67OsiZ9QhL72mtnFHJslN
X-Proofpoint-GUID: XdUdInUfnFZ67OsiZ9QhL72mtnFHJslN

Hi,

On 16/12/24 13:39, Przemek Kitszel wrote:
> On 12/16/24 08:05, Harshit Mogalapalli wrote:
>> When rvu_rep_devlink_port_register() fails, free_netdev(ndev) for this
>> incomplete iteration before going to "exit:" label.
>>
>> Fixes: 3937b7308d4f ("octeontx2-pf: Create representor netdev")
> 

Thanks for the review.
> I would say that you are fixing:
> Fixes: 9ed0343f561e ("octeontx2-pf: Add devlink port support")
> 
Oh right, thank you for catching that. Will fix in V2.
> this is also a -net material

So while sending a V2 I will include [PATCH net-next], that sounds good ?

Thanks,
Harshit

