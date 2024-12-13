Return-Path: <netdev+bounces-151800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4718D9F0EF4
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD6B16C4BE
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE861E1023;
	Fri, 13 Dec 2024 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zo16+Kgr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RnarbDhH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322B1E47A8
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099368; cv=fail; b=Utzzrh9VsXxc54XF/6PSSGeg26c1pnNJMK94x8ajdl3faGWd4AVco1zs3tJphr6WhfOaGGIFIsaxtMDA1PMj6ZvcpGBvxHV68TFl0EYocpu9+Tgo4bUfkrtt2HjmQ1PzNJdA3nNFELyMiOyjvEB5Yl+r7+D9UVkFb2nd/iAeDGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099368; c=relaxed/simple;
	bh=K05z30JbDRUu29wyr3oBOqNg0r3OnwxuGvV3NrbetHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t7oyaMgDfubLBVYGR4qfVptWMf+Ko6ZxKXvGgVWjhAH4qvJLLdSRek1TYM7w382lBsTYMlFfak9EOLQxvEo97eDME+2qyteZ3uhYPsv66bKBYlQKuIMapqXpvpS1+JbR0FLG51wKv4jT2OIAREQNPd2zIN81uCA+ppwPrSnlYxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zo16+Kgr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RnarbDhH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDk01v019505;
	Fri, 13 Dec 2024 14:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8EvhstGgLswTJTTEQUY8IJbxOSgnT35Y1J0Y2Uy/Nc4=; b=
	Zo16+KgreMbbQEg55W1zi9X3MUpnwGLTUcDufm6jRXmSOxaUhnlXTKkavMzw/IWA
	ZfqBxooj1t/vbyehAF96CMKJkwtV7ouwRnnkf74ER+d9lvSQoLGEfiFYwL4tJ3fC
	bHtF6CKygkEyaeIRIJbQG9SdzJqmEcdmHDxVWdT0CYmN8OWQBGZ1OlNU0T2sJux+
	RMk3FiNcHbZT/V93n6PwEJW2/4J1REIJ4lR19C5REoU6AkEeiw39MhlPlwDOKRyz
	S4cOEI6en8j/EfRoVtQKp7ViDQ7QasKxX4SxiQMfOrjDglG8inqKfhOAVuTH/Nnm
	pXjhUdEXSE6UjmGbuqJm1g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedcdk25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:15:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDC2LSn035549;
	Fri, 13 Dec 2024 14:15:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctcsft4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaclJAKI/pffyqAactz6r1QtabG6Po4daDuEFaon4I6LqJzYQ2wvyIrt8n/W/ZTTB0B6LyYw5cYcGN1BF4qtvQyUvOo2cuu3D8nQBYgZjAW9UaQVsQDh6KNu0osA3nC7EybQww2wlLVBE/WAa8MkNJfk0GCv3x5djq4YnOoXLeo6cNwBwnbgsUA/InhRulae/Plohq/mIazEnAH9mC0xme7dW4/u+Q2vjtSMXW0567wVagTTIWcGIZPFjSfUU5n1jFjP3SJkyH3uR3vqfrcalaWZrOz/gCbjgxEmjnV1fRp3q8Fr/p7DKAcngkhOnS0BVnO1qjOW/TM8QbIDpMLH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EvhstGgLswTJTTEQUY8IJbxOSgnT35Y1J0Y2Uy/Nc4=;
 b=VCc5g5QDsI2SkeEQRLscrbX8iG/NaUnrIENunSFJxcTw5XYOaiPKcueBIddu+MO2tmGSAeoVDC4Qh7eTfJRXonAbFzu/jS7woKtyvbqoKEDZU/9l0BtOUTaztd1JfhevOQQ42Zc/1MmGBUM1IW9byxsF63aqmS+zzSZs9WoimeWlvplLDDxtkui7tujKtR8OXGWgOB+tUdF+VRDTBsSZYKSBpviI72dnhh0zLkAV0WJiHJCUSXZwgMbo0lxJro1I5E/sqIJlcru+6vJAHU7eX8zbVd4mD4cmiyr25dnP7C7MzoqjpIhaxwrdqrxKcx0uSigr8L0OGk5UPxX4Mz5CKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EvhstGgLswTJTTEQUY8IJbxOSgnT35Y1J0Y2Uy/Nc4=;
 b=RnarbDhHEmt2tX5JW/7Cvg3Hu8oFIoJGYv1cU/duEG3dUxafXQo8f197eXG0f3sHWEYHTpYU/JqMaqgLWy0gFzA8p5ib3DWTyRYcJ3aaFCBRsz2nsmZYJ1JHRW2Jxi2+mVYwEKeSuL0Cp/r8vMbhsQbBo1bsf5otJHkFcTamIIU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB6004.namprd10.prod.outlook.com (2603:10b6:a03:45d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 14:15:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 14:15:38 +0000
Message-ID: <4f4589a6-b4ed-4a11-a870-c935c29f3771@oracle.com>
Date: Fri, 13 Dec 2024 09:15:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 11/15] socket: Remove kernel socket
 conversion.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
        Matthieu Baerts <matttbe@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        Steve French <sfrench@samba.org>, Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, Jeff Layton <jlayton@kernel.org>
References: <20241213092152.14057-1-kuniyu@amazon.com>
 <20241213092152.14057-12-kuniyu@amazon.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241213092152.14057-12-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:610:5a::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ1PR10MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 274b590a-dcc3-474d-9c58-08dd1b809e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1Blc25hRFhiSVVxYU9IcDZsYzA3QmJCQ2hyNUx2ajBsNis4am4zeVpDQjVz?=
 =?utf-8?B?UXZXdFBaUmsvNzdHWVFSQVR4OVI5Q2h0TU9JQ3RrMTF4MW9VSVZxM1lnZXV3?=
 =?utf-8?B?eDFHenpFKzEwR0cwTWxCTk4vUGVtUEliUTVrNHZQdUkyK0hMSkZYZWVHVUMw?=
 =?utf-8?B?MHhPNEpoSmtQTFB3Q1I5d0FRSWc1RDQ3d3NhYmpzbms2bytmOTRaLzZCQnJi?=
 =?utf-8?B?L0pwbS9MVUVRN0cvd2x0bHFUL296bXErbU41SmZuS25JV28xWFZ4cVpKUlJt?=
 =?utf-8?B?dDdpaW9adkh0V3JYbnRmN2MxQ25sNE9INE9JSzVvcXgvUU9OZHcydHdIQm5t?=
 =?utf-8?B?WFcyUkNOOHp5VDhpcWtzMHJmUW9MdjN2ZzR3VHU4by9IZjRSakc0N2pMSEJN?=
 =?utf-8?B?YnpBT1VnYU14VisrMkd4a1hLWVY3Y1lnWTFvZC9RNmJ0aStsNTVhRHNMV0JD?=
 =?utf-8?B?SHFDQ2ZiZ0ZYS3orRXJNdytiYkUyUFhiRy9XS2Y0L3paUzZvTlVKM2NNNlQ1?=
 =?utf-8?B?MUljSTcybE55Rk9yNGtWbHdGTUtXUEhMUkxObU0rNElhTncyQVFWWHUyNXpR?=
 =?utf-8?B?TW8rU3REMkZNd2xreGdMUWJBbWo4dVVuYytwcVhDeGVHMm9qMFZMVExCM1ZQ?=
 =?utf-8?B?cUlHZ1o2akJ6UjAzRXgyc2U4SXAvUnVkT1I5ampWZEZuZjNJTzZmRXNrb0JN?=
 =?utf-8?B?aklRdnNwU1NGVGM2dGhvcjJ2Y2lkTmFONXNJY1IzV215NlpFbFh4RGFZemU4?=
 =?utf-8?B?TzM5ZVpsdy8ramFRL0dxS1o1QTlTZzFJTXAxemp1OWpVOU95VURZa3h1S1Fl?=
 =?utf-8?B?Z0hnQ1R1S1F4Y2FkOFJoaitZVEdPanR3bmFWTSsvU0tJSDdlVXd6VFZWdGpn?=
 =?utf-8?B?OHFnNjQycUd5OTgzVmNIcUR2YkZXR0FZUUlrNkZabTE3WmJ4NXN4ZmtlbDhT?=
 =?utf-8?B?cmRZbWlhelZGcFlGL3RoS3loa3YvcTYySU9aQU1PcGNrZmYxVzY5UVdoMzh0?=
 =?utf-8?B?V0w3VjhPTk5zVTh4SGozK3pJdkRZcjZmamJEdHF1emVLZEl1WlJCLzdaY0k3?=
 =?utf-8?B?eE1JY3RHRVkyVVZBdVJaUUpTNXdUdFlLUFliandPZDVDeHZFS3ppdUxXcEs5?=
 =?utf-8?B?VmRqYllTbnAxODYreDN6N252UzBNZU9ZVUhPcmVwZWtkUVlqbi83S1YvK3F1?=
 =?utf-8?B?T2JQYUQwVFJlbVBoOXcvOTBQQlhmUm1OaTdabkY4NUw0ZU1nbWRTWjMzemRK?=
 =?utf-8?B?RW9ZckhRODd0WmdnZ0I3TWdJWXV5UlRaMklRcHNoUGhlZHFsb0hXUzVFTzBl?=
 =?utf-8?B?UmRvUmJKU1JwRXc4MnlxOXYyK0FTUTM1SW53QmRkVlFZdDR1Rjl0dC9HcDdD?=
 =?utf-8?B?NlM4RFpxNnVvTWcwdkk5WE9HUWZ2ZzBHb2ZZbnV4UFI5OHl2TlM4L2RqMEpG?=
 =?utf-8?B?SkxZTjdicVRVOVpnOXlNditBeWMzb2x5Zk9oQkczYVRIS2trYW93Q2NOVXhn?=
 =?utf-8?B?TS9JV3FHZUxsWDBmZG51QUJBb0dacnFvYUJEQ20xUE9jSVdKSmtsTXZwMEZO?=
 =?utf-8?B?U3JCVGtsL0VJUkRvWDNxSDVjVFpPYTRXcmZ3dmJsOVRCaVdiK20yMGFlY09K?=
 =?utf-8?B?cHR4QTd0T3lZR1Q3eWZVYk9hQmhKVC9CS2lkOG1xcXdIbWsxTlF0QURZZnlY?=
 =?utf-8?B?UVk1MnovV1dCNE5KL1ZidWR5YzNLWlRpbjlZM21zcmV2dEdMY0VWQkRQRHov?=
 =?utf-8?B?NkNuOEtnMUR0TUdEcDh5SXUrQ1QyVnhDRGJzSVNCK2F1TUdCNmNiTDd5WllN?=
 =?utf-8?B?ZXZUTFV6VjVvR1gvTWtZZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGtabk9MVm9CT3NmR0lVRDBEdW83VmVoSDNZLzhrZXlnajRUNFdxRjFRLzBy?=
 =?utf-8?B?NEFPSUxoS3dMd04xeVYvaVZaTXhFcWFZVkJKV2FNeW1jZzJ4RTBFeEJTTTEv?=
 =?utf-8?B?STNVb3BrQmRSQWNSa3lMWCtlUzVTOUtkOTlaYUh2SUE2dkpXcVhKakdhUFRQ?=
 =?utf-8?B?TWJ0ZjhVQW04RDJIWmZjTGFtWUZ5RU94bFByQnluNlpPNHQ5U0t5U1BOZ1dF?=
 =?utf-8?B?WmRIZk94T0l6ZUowUGZwTnEwdjBUSVlmMkxCaHhZeG9JbmZqWnFUa3FMeXBy?=
 =?utf-8?B?aVd5OVJab0RpYjlYVk1qQXZNMEdNS1J1ajRwWWhNa3BQM05IZXNuZk5sdEZv?=
 =?utf-8?B?QnhzeEwwVDNqaDkrZDBzbjIrWkI3QWQyNC93YWZaMldhNkZEQURHSWNTdmds?=
 =?utf-8?B?bStJUlNUR285Z2g2RjVkWnpzTWxEK3ErZ2kzVUdnUVQ2UnZLeEFGS1BGVDhC?=
 =?utf-8?B?ZmlSOTI1K05rT0l4RDhqL3NZcUxVVG4yNmkrWk1ubXdZY0Rwb24rVWpVOVVl?=
 =?utf-8?B?ZlliK2w0WFpqcXIxSXdMYzJEZjcyU25GSkhrL0FwaW1FUjBIQkpvMGxHc3V5?=
 =?utf-8?B?dGNTRkJqU2N5WE5EWUExTGlwUEEzMWFNNE1OUTZHTEpNM3gxM1Vra2xVUXNk?=
 =?utf-8?B?MVVVZzJVZUZiRXJpenZGc3B1NkplOElIaUxFMU9PYjNsVFZ4QTBWV2ZFdjhJ?=
 =?utf-8?B?dE42WW9aUkovOTB6RlRIdlloVkdjdkpBUENqaGZhZVJnUWtqcXhYcEMxNkJx?=
 =?utf-8?B?azN2RG1BTnRpNnJtck4rUG1ONU9SdjZMMlRJbmxXdXNIbEpIK1Z0ZnIrRnZ1?=
 =?utf-8?B?Y2Y3SGpjR1dDbElEQTV4RitwRnRISHNKL1BMQWZoTDNUSXA1RTJTeDJmSEF6?=
 =?utf-8?B?UVQ5ZkUrNFdvWFdoUFF6Y3Y5ZjhuUHJNLytVcmRYanZNYWFuNXU2STcwdzk3?=
 =?utf-8?B?eERqcGxKTVErYkxQc0VBbXlkemhWSjI4QXdnUU1pdUFpUnRiK3VOVDBxb0JL?=
 =?utf-8?B?T1lyNGd0V2JsakZCZlFBcm91aEhHRi9aUXNlQllOREdneVc2Qlc0Y2xBR0Nv?=
 =?utf-8?B?elMzejNPWjVwUVV4V3FiSmVVRTRSazFSKzNobFZHT0NVbTl2ZTBGSmdwYTRE?=
 =?utf-8?B?WmlGTGJCNlRrekJVY3BNTy96WnZ4ZHdBK0ZIckZSNFJSS1IxbTRyK0xJVmM0?=
 =?utf-8?B?RzU5T05pdkpKNm9mSDNibjIxTlhTeEZBdDVKZDRqZHZNSUltY2lCbmUzMTlx?=
 =?utf-8?B?NEJINWppR1ZoV0RubzRaR2VKZ1NwbVRSdnM5bzN2MGp5RFNwNWVYZXFXSHFv?=
 =?utf-8?B?MThYTXBKNDg5dUxGTWM2MTFHbjdCaDNLVkRyWG5lSWIvc29MMjdwVjlFOU16?=
 =?utf-8?B?RExJYWZIMTM0MmNPalVuTXBXYktTZlFrd2VlcXU0ZS9xNXQ3SUhtLzVRWXRD?=
 =?utf-8?B?U0pxVHk0Zk1tSDRaN1NUT25EYkxwUWRNZHZLZVhwWWhmSUhhNEZuNm80ZERQ?=
 =?utf-8?B?bXUrR3JEdXRuaVJJSFROd2tWZWVMcGZJUjdER0ZMRHlRcG4yZUlJS0Z2OWZh?=
 =?utf-8?B?RDV2SEJFR0tKWGF4ellzSmhDbkZEak5vd1hyY1ltazBodmd2aXRHRHRIWlcy?=
 =?utf-8?B?MGtaSG9QVUxmNnFheVZ1K3hMRkpodGdvL09TK1R0c29ZQTk3WjJkYVZjclEv?=
 =?utf-8?B?YXNpcXJQWTRQNXJ2UWpucUJMNHpOR0hJbi9yTjl6ZlRjMERFTUNWNkR3S0o2?=
 =?utf-8?B?eUF0aDFnYkVkcWtkT2JwWVBkdjVCNkNjR1l3YmtQYkFTeUZXeXZ3TlhCcWM4?=
 =?utf-8?B?ZWM1d2p2R01UQkxhV2V0QkRjUXJxdTBQbG1lcU1qdS9vdUQ2dVM0Rk5OcHh3?=
 =?utf-8?B?NHBKSCtlWGFNV2JFMWdXdmFuZWM3UGRRZ2VMNEcvaHlkMVBXb0pSNFd5Zk9B?=
 =?utf-8?B?RzB3TSs0YzhQK1ZCNE1kYzFIMHgyTlJUTDNtN0ZMUnJYZUJvbHpMWGxDV1l2?=
 =?utf-8?B?Z3hxR1hjOW9VVnkwZG5RUnFvb0xaNXB0eFkzcWI4ZVZObTFrTkErc0pQUFVW?=
 =?utf-8?B?dmNScDZvVGNBV2ZSMGVicDFhSSttelBPa0dGblExK1NNTDVUQUVUd0FKK0dQ?=
 =?utf-8?Q?I6HxyUBYOd8fwmPcghbtCet3d?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ej8e+J/vpDR3sMAUAvDBlnovJO1oWThdLq6CiYx2E+2eOeldOTlvvDIf0NPoMJr98CCpRHRdXUzgSmVZColm6fKDPn5b1twttQqQGVUwuAxgR/ESNHzEFwEhb+VdbJYLYysMcFf8MfNynXH11UNOLu/8q27zVpbEXq7ljsflU9brG+0eK9Ohfg7dpTp2MLQCR/fhxitK9cR8cika08WY2fLD9t30emOqmMaefrrnWW3vyftsyqzlzj/Mo9qbD3bXCldKP4vdRrcLl9lYt/DrNGusYBTMqkNA5iXPXTqdN1+fk8Whyq6hNgLkDRP2QF6ZppYTzx9T56r5FdtNBTXxJ9dLmUbC2moKOSUThLunuf1J+o77ozefPBAiNU/zrgJHLco8O0ITSqY/ULoaFQNJBfyvuytT2dZMrsMIFdLN8Vf+HFrm4ADGn8d3h8pV1LZYxrRZFW6ZkEdB7mA++5kZNDCptnanSm5LdIPeHlriT60UNogeiUdZ4Mi0JWPGWycTq7/BgvDgG4euRuVBMrrhBiCHZTUkC6qSxEPlXdvLJL48S1BooDJiuEqs6taZ64D+6ERPdesaUquZOKtaMzFUhgtMkmCrW/ryzIgB6BSHBgQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274b590a-dcc3-474d-9c58-08dd1b809e44
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:15:38.3672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QFrx9/z/8CzOh1mSgJ51MfLQHx/zWIJpreHslfZ8XXJpYt8pkxuBPB9kd6D+EXbE6gmHuxKUQqzzF+lFKdlfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_05,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130101
X-Proofpoint-ORIG-GUID: EvxMTkToCBVL3IR6w1rMRUuScStKaAym
X-Proofpoint-GUID: EvxMTkToCBVL3IR6w1rMRUuScStKaAym

On 12/13/24 4:21 AM, Kuniyuki Iwashima wrote:
> Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference count
> the netns of kernel sockets."), TCP kernel socket has caused many UAF.
> 
> We have converted such sockets to hold netns refcnt, and we have the
> same pattern in cifs, mptcp, rds, smc, and sunrpc.
> 
> Let's drop the conversion and use sock_create_net() instead.
> 
> The changes for cifs, mptcp, and smc are straightforward.
> 
> For rds, we need to move maybe_get_net() before sock_create_net() and
> sock->ops->accept().
> 
> For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
> call sock_create_kern() for others.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Acked-by: Allison Henderson <allison.henderson@oracle.com>
> ---
> v3: Add missing mutex_unlock in rds_tcp_conn_path_connect().
> v2: Collect Acked-by from MPTCP and RDS maintainers
> 
> Cc: Steve French <sfrench@samba.org>
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: Jan Karcher <jaka@linux.ibm.com>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/smb/client/connect.c | 13 ++-----------
>   net/mptcp/subflow.c     | 10 +---------
>   net/rds/tcp.c           | 14 --------------
>   net/rds/tcp_connect.c   | 21 +++++++++++++++------
>   net/rds/tcp_listen.c    | 14 ++++++++++++--
>   net/smc/af_smc.c        | 21 ++-------------------
>   net/sunrpc/svcsock.c    | 12 ++++++------
>   net/sunrpc/xprtsock.c   | 12 ++++--------
>   8 files changed, 42 insertions(+), 75 deletions(-)
> 
> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index c36c1b4ffe6e..7a67b86c0423 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -3130,22 +3130,13 @@ generic_ip_connect(struct TCP_Server_Info *server)
>   	if (server->ssocket) {
>   		socket = server->ssocket;
>   	} else {
> -		struct net *net = cifs_net_ns(server);
> -		struct sock *sk;
> -
> -		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
> -				      IPPROTO_TCP, &server->ssocket);
> +		rc = sock_create_net(cifs_net_ns(server), sfamily, SOCK_STREAM,
> +				     IPPROTO_TCP, &server->ssocket);
>   		if (rc < 0) {
>   			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
>   			return rc;
>   		}
>   
> -		sk = server->ssocket->sk;
> -		__netns_tracker_free(net, &sk->ns_tracker, false);
> -		sk->sk_net_refcnt = 1;
> -		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> -		sock_inuse_add(net, 1);
> -
>   		/* BB other socket options to set KEEPALIVE, NODELAY? */
>   		cifs_dbg(FYI, "Socket created\n");
>   		socket = server->ssocket;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index fd021cf8286e..e7e8972bdfca 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1755,7 +1755,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
>   	if (unlikely(!sk->sk_socket))
>   		return -EINVAL;
>   
> -	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
> +	err = sock_create_net(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
>   	if (err)
>   		return err;
>   
> @@ -1768,14 +1768,6 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
>   	/* the newly created socket has to be in the same cgroup as its parent */
>   	mptcp_attach_cgroup(sk, sf->sk);
>   
> -	/* kernel sockets do not by default acquire net ref, but TCP timer
> -	 * needs it.
> -	 * Update ns_tracker to current stack trace and refcounted tracker.
> -	 */
> -	__netns_tracker_free(net, &sf->sk->ns_tracker, false);
> -	sf->sk->sk_net_refcnt = 1;
> -	get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
> -	sock_inuse_add(net, 1);
>   	err = tcp_set_ulp(sf->sk, "mptcp");
>   	if (err)
>   		goto err_free;
> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> index 351ac1747224..4509900476f7 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
> @@ -494,21 +494,7 @@ bool rds_tcp_tune(struct socket *sock)
>   
>   	tcp_sock_set_nodelay(sock->sk);
>   	lock_sock(sk);
> -	/* TCP timer functions might access net namespace even after
> -	 * a process which created this net namespace terminated.
> -	 */
> -	if (!sk->sk_net_refcnt) {
> -		if (!maybe_get_net(net)) {
> -			release_sock(sk);
> -			return false;
> -		}
> -		/* Update ns_tracker to current stack trace and refcounted tracker */
> -		__netns_tracker_free(net, &sk->ns_tracker, false);
>   
> -		sk->sk_net_refcnt = 1;
> -		netns_tracker_alloc(net, &sk->ns_tracker, GFP_KERNEL);
> -		sock_inuse_add(net, 1);
> -	}
>   	rtn = net_generic(net, rds_tcp_netid);
>   	if (rtn->sndbuf_size > 0) {
>   		sk->sk_sndbuf = rtn->sndbuf_size;
> diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
> index a0046e99d6df..c9449780f952 100644
> --- a/net/rds/tcp_connect.c
> +++ b/net/rds/tcp_connect.c
> @@ -93,6 +93,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
>   	struct sockaddr_in6 sin6;
>   	struct sockaddr_in sin;
>   	struct sockaddr *addr;
> +	struct net *net;
>   	int addrlen;
>   	bool isv6;
>   	int ret;
> @@ -107,20 +108,28 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
>   
>   	mutex_lock(&tc->t_conn_path_lock);
>   
> +	net = rds_conn_net(conn);
> +
>   	if (rds_conn_path_up(cp)) {
> -		mutex_unlock(&tc->t_conn_path_lock);
> -		return 0;
> +		ret = 0;
> +		goto out;
>   	}
> +
> +	if (!maybe_get_net(net)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>   	if (ipv6_addr_v4mapped(&conn->c_laddr)) {
> -		ret = sock_create_kern(rds_conn_net(conn), PF_INET,
> -				       SOCK_STREAM, IPPROTO_TCP, &sock);
> +		ret = sock_create_net(net, PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
>   		isv6 = false;
>   	} else {
> -		ret = sock_create_kern(rds_conn_net(conn), PF_INET6,
> -				       SOCK_STREAM, IPPROTO_TCP, &sock);
> +		ret = sock_create_net(net, PF_INET6, SOCK_STREAM, IPPROTO_TCP, &sock);
>   		isv6 = true;
>   	}
>   
> +	put_net(net);
> +
>   	if (ret < 0)
>   		goto out;
>   
> diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> index 69aaf03ab93e..440ac9057148 100644
> --- a/net/rds/tcp_listen.c
> +++ b/net/rds/tcp_listen.c
> @@ -101,6 +101,7 @@ int rds_tcp_accept_one(struct socket *sock)
>   	struct rds_connection *conn;
>   	int ret;
>   	struct inet_sock *inet;
> +	struct net *net;
>   	struct rds_tcp_connection *rs_tcp = NULL;
>   	int conn_state;
>   	struct rds_conn_path *cp;
> @@ -108,7 +109,7 @@ int rds_tcp_accept_one(struct socket *sock)
>   	struct proto_accept_arg arg = {
>   		.flags = O_NONBLOCK,
>   		.kern = true,
> -		.hold_net = false,
> +		.hold_net = true,
>   	};
>   #if !IS_ENABLED(CONFIG_IPV6)
>   	struct in6_addr saddr, daddr;
> @@ -118,13 +119,22 @@ int rds_tcp_accept_one(struct socket *sock)
>   	if (!sock) /* module unload or netns delete in progress */
>   		return -ENETUNREACH;
>   
> +	net = sock_net(sock->sk);
> +
> +	if (!maybe_get_net(net))
> +		return -EINVAL;
> +
>   	ret = sock_create_lite(sock->sk->sk_family,
>   			       sock->sk->sk_type, sock->sk->sk_protocol,
>   			       &new_sock);
> -	if (ret)
> +	if (ret) {
> +		put_net(net);
>   		goto out;
> +	}
>   
>   	ret = sock->ops->accept(sock, new_sock, &arg);
> +	put_net(net);
> +
>   	if (ret < 0)
>   		goto out;
>   
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 6e93f188a908..7b0de80b3aca 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -3310,25 +3310,8 @@ static const struct proto_ops smc_sock_ops = {
>   
>   int smc_create_clcsk(struct net *net, struct sock *sk, int family)
>   {
> -	struct smc_sock *smc = smc_sk(sk);
> -	int rc;
> -
> -	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
> -			      &smc->clcsock);
> -	if (rc)
> -		return rc;
> -
> -	/* smc_clcsock_release() does not wait smc->clcsock->sk's
> -	 * destruction;  its sk_state might not be TCP_CLOSE after
> -	 * smc->sk is close()d, and TCP timers can be fired later,
> -	 * which need net ref.
> -	 */
> -	sk = smc->clcsock->sk;
> -	__netns_tracker_free(net, &sk->ns_tracker, false);
> -	sk->sk_net_refcnt = 1;
> -	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> -	sock_inuse_add(net, 1);
> -	return 0;
> +	return sock_create_net(net, family, SOCK_STREAM, IPPROTO_TCP,
> +			       &smc_sk(sk)->clcsock);
>   }
>   
>   static int __smc_create(struct net *net, struct socket *sock, int protocol,
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 9583bad3d150..cde5765f6f81 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1526,7 +1526,10 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
>   		return ERR_PTR(-EINVAL);
>   	}
>   
> -	error = sock_create_kern(net, family, type, protocol, &sock);
> +	if (protocol == IPPROTO_TCP)
> +		error = sock_create_net(net, family, type, protocol, &sock);
> +	else
> +		error = sock_create_kern(net, family, type, protocol, &sock);
>   	if (error < 0)
>   		return ERR_PTR(error);
>   
> @@ -1551,11 +1554,8 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
>   	newlen = error;
>   
>   	if (protocol == IPPROTO_TCP) {
> -		__netns_tracker_free(net, &sock->sk->ns_tracker, false);
> -		sock->sk->sk_net_refcnt = 1;
> -		get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
> -		sock_inuse_add(net, 1);
> -		if ((error = kernel_listen(sock, 64)) < 0)
> +		error = kernel_listen(sock, 64);
> +		if (error < 0)
>   			goto bummer;
>   	}
>   
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index feb1768e8a57..f3e139c30442 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1924,7 +1924,10 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
>   	struct socket *sock;
>   	int err;
>   
> -	err = sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
> +	if (protocol == IPPROTO_TCP)
> +		err = sock_create_net(xprt->xprt_net, family, type, protocol, &sock);
> +	else
> +		err = sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
>   	if (err < 0) {
>   		dprintk("RPC:       can't create %d transport socket (%d).\n",
>   				protocol, -err);
> @@ -1941,13 +1944,6 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
>   		goto out;
>   	}
>   
> -	if (protocol == IPPROTO_TCP) {
> -		__netns_tracker_free(xprt->xprt_net, &sock->sk->ns_tracker, false);
> -		sock->sk->sk_net_refcnt = 1;
> -		get_net_track(xprt->xprt_net, &sock->sk->ns_tracker, GFP_KERNEL);
> -		sock_inuse_add(xprt->xprt_net, 1);
> -	}
> -
>   	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
>   	if (IS_ERR(filp))
>   		return ERR_CAST(filp);

For the svcsock.c hunks:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

