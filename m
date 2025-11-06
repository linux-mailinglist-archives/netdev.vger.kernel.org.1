Return-Path: <netdev+bounces-236457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2507C3C7B5
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D13A8505560
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1637C34D4E4;
	Thu,  6 Nov 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NcEVCUdR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UmDz16/Z"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016834A78B;
	Thu,  6 Nov 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446433; cv=fail; b=K/GpXC8hrPce7n1vb3znNzg5kg/OOTfT3w5Bz60FD8FqqluaEb+OHL/2w2aN4Qyqfe7GY6DFGIT9N7B72GvvJoHcPp2ySiVwLLJnELn1d/4vO04G2Ijt0wnRF2xpSWE8M3csBSwp/HWiojg4aGSm97IGlrpn+/SMTJEJ+002vIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446433; c=relaxed/simple;
	bh=hAYIaLFExyVzSHk0vkVxbQZ3wK9xtC/UobrrwfJSoQ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l8wfzivJiwc3+rgxrDcokScM8ICeZoW/99qsl5cKxUDHED6rD+9I+GSgebeUsvjZ09dnT/9ie9VNa4ziqGbrFHutDvZ2lyzD+EaJjDh3F6Ch27jrbQOpLUFERUQyvNAM5P0ZdoSQh6fSi4GLAiP75164rnntKmIOF35tmVDO2II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NcEVCUdR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UmDz16/Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6CPwqR030120;
	Thu, 6 Nov 2025 16:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7DYinZrOz1qqGfDOJiXHeE9L7p7zfETzd2sxxjg2/G4=; b=
	NcEVCUdRkYuQpjKKMgQc189tPa36eaw9U7FuVLJzybOiz5ADq5uWsfLxL3cDwDxK
	0ylB5AjhLICA80wW5klRTqTvPK66OiWABiFNmyK4UWkLaZj/1raIIVN82UzcIpCJ
	haKtSDXzJemyOsbECuAbWLtjV2TDBG1WcgejuGWMHPECJatLl8Id4a+fyuC5my40
	Ec5WB7oFYoqm1rSe8xoen1AlOvfYHqfeZLbFdcN+wRJxAySZnmIOjJOszU0NUN1o
	BH3ciMFY0Mj3+dq8fMn34m2Lehgh2l/Km7McX5vR/lkxnkkN0LLYLkPj/0RZ3VYe
	WqkjfSciyNVVoaVF45Z9fw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8anjjd3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 16:26:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6FXPcY023163;
	Thu, 6 Nov 2025 16:26:55 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ng61wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 16:26:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sS68G4/WjScAuFLSr84meevGHM09/to+6PlYCJtFdzFeCo8DAs65x1vUM5qe6Ofa833+jaDzDlCHJzMjMFAqBvRKTHcMqxPHmz+i+WRA6xNOSyPne49nl1aEC7TeWexpr2N7ZS9bPqx4hA32WkG1SnpVR/93JTchL9nfU5/p/474SWX6Mwa9CFFOYgle4aYauSCXynGsP8URyCeR0cukuDUpV15DKRZp23ugpe4zHOp51vSrq+dn8f7Hl0ksDP+ngM3S1gYyP4jB3+MkSvAurdPDre4GWMN5HsnvfyyD5dKQzwHk5rb0hJCG6OJne0N7kqOKf0EdkAqcj29qdEdlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DYinZrOz1qqGfDOJiXHeE9L7p7zfETzd2sxxjg2/G4=;
 b=oVMDRJ52OrUHbKBbi47t4BzVldrs9YQY2YgvtMvM05MKtVCiAJh2nqVgQLEsBPJShsQVjpjFBPIeliq2+493GVawbeysl1lTjKYY3cda1fOrkjejlEsVjssxeWpbaEwD1lduwHZOyI5QcSQ/y6Yl4SCPRGFzDx0cI8rz/tBh+5T0ycWFgPw8wDx48II5N3B5HPCo/gA/pwAyONPYJwKOGHWZC5+K0FY5/zU4bmxP5Fcoc8XKvGnQfwN0i/dXMFhA/ftdSo3QZ3cATa4Z07QCN0QT9bhZ4L4O8dcppp4Y4Ka/HpcDlH7SLl075aImaeAzlzqbtt2APgxU5H0UUak2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DYinZrOz1qqGfDOJiXHeE9L7p7zfETzd2sxxjg2/G4=;
 b=UmDz16/ZKka8nfDbPXTVbJ2NYGkwX2vj59xfGcSgiXIwPukH4OZp2ovHKnC29Fy7BntilyfMqOKFksJsOa81zCwrIWyLJ9qscNJ8REi4sUpMSnrZITgVA9FvCVE6Dh4lZn7LVGJoq1pyoNAhp+ufuDlWxyVv2jPBAcyMkXAaxWg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6345.namprd10.prod.outlook.com (2603:10b6:303:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 16:26:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Thu, 6 Nov 2025
 16:26:52 +0000
Message-ID: <65a697a7-afb9-4f7d-a211-edfc18b19b9e@oracle.com>
Date: Thu, 6 Nov 2025 11:26:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/handshake: Fix memory leak in tls_handshake_accept()
To: Zilin Guan <zilin@seu.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org,
        kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20251106144511.3859535-1-zilin@seu.edu.cn>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251106144511.3859535-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:610:5a::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 9426552a-8f60-4efc-02bc-08de1d514b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFgvdmwwTERXRytEUUd2dURxdHBXTm4yRS9xMTg0SFJGOU14ZWRYb1JEUUpY?=
 =?utf-8?B?K3VONE56OFVQczUyekhHQUZqbDZ0eVFva1pGYjd1T3N5cnBKd2xMcGxINU9w?=
 =?utf-8?B?djJ4c0tFK3U1TEVpbnJOaWtDSzBTazJGYTRUN0ZVNXQ5eWNYaXlpTDVhdFQw?=
 =?utf-8?B?ajd5UEdrUzBabnZLcnBhLzBaM2QvNzQ3eUg3Tm42Vk9naUZyRktYVXRaWkp0?=
 =?utf-8?B?d3dSVUlyb0c1cXljc0s1VXh6K3hVUytWRnNVOVA0NEJqSTdZZjJFMHZmT3VP?=
 =?utf-8?B?RDFkOTFwellQcDBRTDJ6YldZd015TGlGTWgxM0dGbkh4ak9xNXM5WVlsTjY3?=
 =?utf-8?B?ZVhrYmFKNjZZSVVLUE53WHBnM000c2JBekJqbFc4Ym1uWFkxWUdISHEvODhJ?=
 =?utf-8?B?WWRvOEFlLzYzejdOTmZaNVIydStDNlFIRkd4Y1haY2wycHRZL2tCVkU2VVUw?=
 =?utf-8?B?enNLdFpiajRyNzNEL1JReEIzWE40Z2pYUk9xSGpWYVcwbG91N25xRCtsWTBU?=
 =?utf-8?B?aHcxYnA5QnU1R3hnRDdXQVhaOTFOZnBNUmp0UXJYWUxwYkg4TThIN1I2T1lD?=
 =?utf-8?B?QzFuWWgrbS9rN3FiL0hWbHZSdkxhRUsyQmlobDZSV1ozYXlQNGw0OThEakFt?=
 =?utf-8?B?aGFweXFTMzFETEFIRGxLSlBPRzhqVU81d3N6c0lBRmNTQWg2MEY1OXBsRXQv?=
 =?utf-8?B?SkhFaEFvbDB0dFZneHQ5Zk9GWWU2SFYya1orbFlCTkc5MnNyN1hnQXI4WitT?=
 =?utf-8?B?eDYyYmdQTUREM3hPejFKVWJOcnkxWkhDbEdNWFRDTkVhc0VhbTRvdmRIajlh?=
 =?utf-8?B?OCtvNlNxYU5jVTRoOXAra0svZkl2NjluZGtPR3B2QkV2UFpob0dCVk94Ykdp?=
 =?utf-8?B?UTdqaEgwRDlIdmp6ZytsbE5hSlNOVkE2YitMOFFwcDd5SU9XUm5kY0xhdHRp?=
 =?utf-8?B?SFUrVURJR1pVL1pxSmFVRU1kRk1vTXNHQ01Qa09Ec0wzeTV2bDIyMTlxSDdC?=
 =?utf-8?B?dS9kTVZMdzVvcmUvUG5QR2g4UHR5S2RoZEhqZFRrcE5pUGhJaFd1emF6aHps?=
 =?utf-8?B?Q2hVZWk5RUtvZjZTakJJTTlINUx3SUZEWlB1UlZGQTJOdjNuN2I4NmRldFFi?=
 =?utf-8?B?cjVqc3k4aEVFTGRFYzhJYlBEUE5uNFE2NStNVWN5alNYeW9pNHhhSW9PcnFT?=
 =?utf-8?B?c1o4eDNXeHlWbWRYNE5kNWZrTXdubVFiN3lzeHdtUWd1ajZpaFd5czBWc1Fj?=
 =?utf-8?B?cFl0STJSdVluRGJBVHlnQ0JFWHRUZS8zN0trSnBTS2pKeUJUOXF0Y3hjV0lP?=
 =?utf-8?B?bitpOWdVckJwZ0w4Nmg1S2Q5ZDk1NnRDRXJUeEcyS2p6eFQycS9WRVdDNXJN?=
 =?utf-8?B?UWQzT2M2Z2xQN01sb2IrYTVQanJCUDRlK3k3UzBxT04zVjErTS9Cb3NHR2V6?=
 =?utf-8?B?cm0zcVM4elZjalRvQWF0dW9oY3E2QTk1b0hMc3pCdUpVSFpCb2cyeE83RU1W?=
 =?utf-8?B?djRqUVdqZkR2V3F4ZmQ4SU0vdUI0NXpMN0hHL2ExWnJYVUtSSURxS1k4cU1S?=
 =?utf-8?B?YTh6QUVldGdaS25GRGxjOW00Q1M4Q0oxb2ZHZ2lSUmhxRVBISUJLYUdYclFE?=
 =?utf-8?B?QnA0UzRFc0lyVElwZDg1ZUt2YmQ2Mmo4bVdGRVk3blIwYlRXUzcwbFRHZVN2?=
 =?utf-8?B?d1ptNnNwajEySlEvMXZQZ0ovZlc1NlRwb0xyZ0paRHJRT2xHQkIvNFZZL25S?=
 =?utf-8?B?Y1U2NVZOMU5va280aDEyL3p1a2RxUHhNaUcrckRtV2VFMkQ0Vk9XM2hNYjUz?=
 =?utf-8?B?U2tkUm1ER1hQNG5jMjJYRURwUVhENnJNdjNHcDhqc0diL3BpS2pKMlA2aXRI?=
 =?utf-8?B?Ym1KdG5lQTFuRE9RWURTRDF6UXZ2UGdDYUZNbkVuNUFVblZiQkt4alRkT1VH?=
 =?utf-8?Q?Zk/3bDNxP+B4i3da/znbVfGF098+hU+f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3d4NnQ3dXlqM0xGRjJwcUtpUVQvUTVuZ09Fb1N6bXZEa29FV3ZGMjV5Si90?=
 =?utf-8?B?VXVSSkZrNndtUzJ0RHRyYlNQekJsZ2RFZ1I2bXRMTXcrSE5oenAxMFV2YWc2?=
 =?utf-8?B?NXlwOEhhUG0wWTFvVEZoSlg3Mm5sK2RIRVNpT0ladTBmRGRmRW9pOVhTUzk0?=
 =?utf-8?B?V01HSTJkWXRESUpJOXJySkY1cm0vTzZ4SWdUSDJDczE5elEvS3dXVnlsOW5X?=
 =?utf-8?B?TE5tSHBCYXkvWnNxZ2lsaXJWdGgyQmpPd3d4WU02dDhNdWpWQzBTWW9lbjJC?=
 =?utf-8?B?Q0EzeVR0SkJ0Q1BIbmNSVGhVc25JQzZVUTRaVXFIYjREdFF3akJkTDMzSU1m?=
 =?utf-8?B?TGVEWDJtSHZJSDlZM0p4M3RIaEduM0l4NjU5Y3NDWjV6d1hHb2ZWcXRIclRZ?=
 =?utf-8?B?elJySDlGU25sVVpmZk1jcEU2bTVRR0VLTVMzNXQzYzR4Ukl0ejk1STU0UTZC?=
 =?utf-8?B?OUxKVHExWU1PWVRsVm0rUTBIbGJ2M25aRndNK21zSzJpN1prSzQ2Ull0VU9D?=
 =?utf-8?B?TDJnMDZFWEtnb05oeFFhYnJLcE45L0p6Z0FvTmJ0azFLRjdONFJYLzNlb1JY?=
 =?utf-8?B?TEY4L0JMQ2FjREEzeTd4bVlmaHZndTFzbnV2MjYzaG9rakt5eUVRbTlIb20z?=
 =?utf-8?B?eGZrLzBZK1BXUUhIdzgwOSs1cno0aDVYRnR0bHl1Tmt4WHpVUGZkaEJ4bHhp?=
 =?utf-8?B?UEhxM1d1QWVpV0MyM1BiRTdyK1EzdStYR1M4aUtHRzk1d0FTVE1STDkyaXl5?=
 =?utf-8?B?Rys5QXlCNDNoMlhoYTlWd2ZOOXd1RzlBbVVhbGVPcWZYdEtkNW9kVTdITzgw?=
 =?utf-8?B?NFFqYzZucDFoZ09HYmlUbkV1TVYxR3pRMzhyVC85cndaT2gycmtINlZnWmhu?=
 =?utf-8?B?QVU5MGhhejZacTNIZVA4aElMZHREam9TNW5VTG9yYi9tb3g2bTlScjZ6MjlX?=
 =?utf-8?B?ekEzMXRCeEFtMFBqT2RFeDNOdExKZUh0NEE1VlhBTmZ3SE9hS3dtUnVqdzVU?=
 =?utf-8?B?RHhMOUJTRlE5UkVHcUFMdVRGb0dVWnlRajE0RkRybWFkNmRWNHRQSi95cnN0?=
 =?utf-8?B?R1haY01GNFVRcG1ic082S3Rtc3dCOGRUSEZIUDhqU00zVm1xK3VBUkNrbzNm?=
 =?utf-8?B?a3pTdTVsVUw1d21tblJpMjBRTGJlOURWWnJzdnh2WUZMdXNhcHJBc0FDd2lm?=
 =?utf-8?B?b2FRaDhOZU1BenNSZFRBZ0JtY2ZDd1BPRHYwUU5FWXloblhBRUVMcHE1aXVR?=
 =?utf-8?B?L2NuOGtnQlVJYXU5a3VhbmVTQjFaK2Yvc1UxZk8xUW9LdXVuT0h4UkhVdDNU?=
 =?utf-8?B?RS9TL3J4ZkFxRkwvaXUrY1ZuLzdsNW1lVGxkUEc5YUtOdUNKejZTb0FQRGpp?=
 =?utf-8?B?TExPbFJBRWQ4bWxkSmFzVjBOUWVYeVAyRDZEakcxaDFSeURZR1JERFdMUXR5?=
 =?utf-8?B?RzJPU0JWQlFEZXR3NERIcGxuZFZ1Q2NiYTkxUTdKb0ZpenRTeCt1UjJDZTF5?=
 =?utf-8?B?Q3FMUnNvem10OEVQbUtTY0UyZEpxakJzSFhucytiN0ppcmN3d0g0Y1Vwb21a?=
 =?utf-8?B?SHJUSENJdGNoa3F0d05qMnFSYUJHWVdaZTUyWFdsVVVCKzZMRTJSMVhmSEp3?=
 =?utf-8?B?K2NXc05HdjZTZE5aMDY2a2hsekZQSGhYMXpndjlHMVhWSmd6c1JnVW96dGhP?=
 =?utf-8?B?bHZ4R3NGM1N3THpyaXJQZkhwTmQ3TUlRQkJuTXJ0MUE2TU81WlJzWHYyam5E?=
 =?utf-8?B?UTBUemZ1QzhobVI4V3dpNjdKT01NclVUOUpwcllxN1Z6WTVHY0RXbmFnL3JU?=
 =?utf-8?B?TzdOQjVCSG9QZGNSRTFPQW43QVJ6RDgzazN5b0MwRFJwWUQxbkl4cGt3Zmxk?=
 =?utf-8?B?anlZclVPMld0TXdqNkdXWkowdXRadFZlejR1VFRkN0NhRUVsT2Fub3R0YzY1?=
 =?utf-8?B?cnFoZjgxT1dCbFVSTTZCTFlJVDZYQ2lKdDhwb1pTZm1TaFpjV0JUamFSVmVO?=
 =?utf-8?B?VXIwelhpWnNXRXI2VVlMOTF1ZG5UeEVzallVV2hpU2pCS2hSZGxVSXF1TGVa?=
 =?utf-8?B?NThGR0R5OUx6UUloT3dYWCtMK2hyNFJadVJZWnhTNGc4UmsvNForMlZuNlQx?=
 =?utf-8?Q?XyALE+Krx+If5GsBh30HYZHh5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dKhSxq5YGnNoqQOUf8hxBj+fcHe90lIKh8kvlvcl9n6CUjrY5PUW+zUCw3hCFk0/OHI+wwAQsv6QnEGl1UZ1ixxFwgIRpcDyWhiTl1X3hoR6FmXTr52z5+U0OLqGXFSupJBPx1lCc2sEkigxeaMXP/QXnCyfbCcAu8Ey1R6o6enQWZc54uG/QIbdNke0MYG66d2BKXVzPqs+ZMmC+iz6QG3iZj+mNbEFqx/Yug3XG5amHCdsp/8vwBA7Lyp/d8BAM9J9+nZZgsRkvoMGHKmo5dWUIzhp0ZKauBAZaxrkyay1J6si08DyAO33M9HpX/epvPGhwEcOXLqYL6HGrreGS2kFJH2ibuJmuQ/Y54HSExa1buAZaK0kIh2jCSG2ThylPPj5uVOfq6v6Ikp6P0U6EYxdCin6PHbUTkM3XaLUM7FXZPbxdACcRMWL54i4h1K+keffH0HxEyCwFMszdKBFqtjx4U7nVC0T9jlLPPj5gWDMG7UW7GOoel7+oL0OmjfH+H1viPVdzJZZROPObHDaZLFVkxYg/pnv9Blt2XNfMn5VnCdHDlgd9gPaacWFrDpzSuL8tGRksDOuSuKsgFRTeHc5QgCJUOr5KdfYOG9W3DU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9426552a-8f60-4efc-02bc-08de1d514b1d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:26:52.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfXWmVoleog9JOW0jRr+fDSW6uaF+HkJ+tEkgVwGpNqzv9Q8ydCLOi3gNTUhJz+JgEJa2udnKZrRFx6dTNoYBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511060131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX2gj4Rr3L9urk
 PrBRrMW0iXUbQgynq4EsVZrGtSKoCKsP6zlyRaoyrsX2A0V6DkIHfwruLWMOr9FVyxiybJcTSi4
 Jx+17HkhrtZuAncP9E0wPSPntTb/rFmy++vppx7z5DiJkZm6+RXaZhEw0eOKwph0hYUgUgwMCjj
 GsEkuaineIpUeIOF/hza1UnsrgRt+XNesL8jcZQyk3vpL4IUKM5KXy7fsu5TXR04jllcJuT1kIp
 qWkLXuAFNhVYpB5/i6vsBBixEcuqd3AfP9ZfUvwJwNCcX2x6VA1rG9B+/TCCdh+db5CTkvo39Xf
 edZrwH2yYcagVqQBosTw6D9GfQCi0i9ZdVChvOqwzc2WRXO7naJAJ9bAIefWIpHFV16c6uycppt
 FyFcf/ZEe+3N+1TzezzMDdKjYoMah73ZVhKGdLwKzE2nqiVNH6s=
X-Authority-Analysis: v=2.4 cv=dfqNHHXe c=1 sm=1 tr=0 ts=690ccc4f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=evjf5L8LlLbPhPqioeQA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12123
X-Proofpoint-GUID: PugV0jCdE2Wy9i1ntykpTzCQN__zLjFk
X-Proofpoint-ORIG-GUID: PugV0jCdE2Wy9i1ntykpTzCQN__zLjFk

On 11/6/25 9:45 AM, Zilin Guan wrote:
> In tls_handshake_accept(), a netlink message is allocated using
> genlmsg_new(). In the error handling path, genlmsg_cancel() is called
> to cancel the message construction, but the message itself is not freed.
> This leads to a memory leak.
> 
> Fix this by calling nlmsg_free() in the error path after genlmsg_cancel()
> to release the allocated memory.
> 
> Fixes: 2fd5532044a89 ("net/handshake: Add a kernel API for requesting a TLSv1.3 handshake")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  net/handshake/tlshd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> index 081093dfd553..8f9532a15f43 100644
> --- a/net/handshake/tlshd.c
> +++ b/net/handshake/tlshd.c
> @@ -259,6 +259,7 @@ static int tls_handshake_accept(struct handshake_req *req,
>  
>  out_cancel:
>  	genlmsg_cancel(msg, hdr);
> +	nlmsg_free(msg);
>  out:
>  	return ret;
>  }

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

