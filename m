Return-Path: <netdev+bounces-207551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82362B07BF4
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 19:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E3567A3CE9
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 17:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93C42F5C43;
	Wed, 16 Jul 2025 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HvmyXjY0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wn9D9ylk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF742049;
	Wed, 16 Jul 2025 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686816; cv=fail; b=DpWUz7EPZyfum60vZqnQa/LqI6QwIU3K1zNh0GmkKEELxhB9yBwUNlLHSAKSopqLWF9rFTLC/hP5R9znL4+SuzJMdsDHYXI4ZbrpO5B7JHL5vhaRHqh+pbO+LTenNoNJthx7RgeiDYMFbzbtPXVCPBjm8hVwrCiCWFCswcTkFZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686816; c=relaxed/simple;
	bh=C6jEPoLXdZJLZ352uftwwshcyWE6okwu10ZgbBrjP8o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bF5z1ZOvunqxPTVV6z6u3SopTKl5tpzCmLHmDzkRAf2OwAyEayClaE9ViZDZ+bnIsXOeFDViFFFnN0DXIAjw3lMdxA4Gwtfd7f9ImNERtsVioH/EAxnGXwsLdjQ6FLAzbC+fmEkUJQbHZfqf/Q2YXO3Xx6HYip/UWCuLuG+Pu8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HvmyXjY0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wn9D9ylk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GFqv9w028281;
	Wed, 16 Jul 2025 17:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HwkGR1+wMNY2Fj+4mustg+9fjypGJeOtEB67PaMfq84=; b=
	HvmyXjY0KiLvEws4M6xvGw+iOTORRcOznPOzwe7jO+S/SbpztuNUtFfx1HhoxC8g
	hZ2xTuhUOq+9HPV0gpsYjCvwge/tIk05r66KbLghHQ9/3E89a3Feo/2Gt1SGV58t
	ayc/Xwevcfqj8YaWHY6qRRN0mWmv1rMdWrMB1fPj0JkfB6WvHMkKtiA+s7rAb68v
	vV91gCUdwAzMELNjaueHU2TAGwUVNH5Z3X2rLjOm2x8vhlGlcpxDOK2/9pnZf/iS
	lDplpcgN1DrZa24/16lcZKr2DV8VQmz0aayn6Xw06rQFbGlO8q9+3DS+Cblux022
	jL8Rg8Pcb5HSqXGkB5MpsA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf9wxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:26:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GG7B6D040507;
	Wed, 16 Jul 2025 17:26:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bnsp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:26:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nD+cEmN6ayWnIyFwke0xcDKt2yW7cGgAK0fJvdDITQC4VgZpR2YGBpxTh39LA5C0IEFjgEhp06fiYNb+5CxkG00f9OqpDWG8pjVEye2Whbal9biiWgCQzoG9LfWNZ/1HZW5tsk7EGgLTP2a/ajYqvo4bovT7scmp7kUJRcFFGOVG/tlzH4NanhX1kSrSv7XQYiL19jhS4AiYZOdUP1HCNQE0+YB74Hx2mGJ3jC90jyLPubCbrPtHfB8cYVYn+dxDWhJQnHDLBm/lQrd4nJjwAWD0HVY0qzexoVeb+VAOkDk4EzC8zZJRmuP4GNZk03B7N8yL+DYGiU5AL2dMaEtloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwkGR1+wMNY2Fj+4mustg+9fjypGJeOtEB67PaMfq84=;
 b=KSwfwzAEfrOrRR2Q9MQJwQlXeyjatn9CW0W5eehWBuB7M15HtXzoKwTQLtyxeIOGPwkRCjUCS6+niUUCt0RY43Lc0wRUcYbk22bUvA2pOxzIgAKB0L9me3qazI7lwE3xhZyj7JtGvhgylMnwOQFf/UohMiiIPp0ucIwARkI8cS8poylLo5PD6bW9uqe/I9eTcx6i9OOu5SvLdAp/QJN4GfXSC3a4pzJP7Eq8GaMgjEtmgFnH8nBCMkOz5aWMezMKTFMWO8JWEMkptGPbYKq8bqUNmi6SKTtnuHa5tiVNiaMcSLns/BOFOmoFiQj6j7RPFXIcSI6ly2vN9NrSC14AlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwkGR1+wMNY2Fj+4mustg+9fjypGJeOtEB67PaMfq84=;
 b=Wn9D9ylkwylBNaTwtqCRdgZlJ01ouLWzVxW4oiNgsxYQIlRL4z6bXSXg72iuo/v0UF1QxBUzCKTgMknFldPD1ZTw+22m30ioN0jvEaGBsgTBWKEAagwM+42RIG9f5T8zFfVYmuE5IZYfC36+5N8yqeWO6R2g0R7oJWJS72wY+jk=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA2PR10MB4428.namprd10.prod.outlook.com (2603:10b6:806:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 17:26:32 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 17:26:32 +0000
Message-ID: <7333bbb4-daa6-438e-997b-1b966d74f1eb@oracle.com>
Date: Wed, 16 Jul 2025 22:56:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 4/4] Octeontx2-af: Debugfs support for firmware data
To: Hariprasad Kelam <hkelam@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, sgoutham@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, lcherian@marvell.com,
        sbhatta@marvell.com, naveenm@marvell.com, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bbhushan2@marvell.com
References: <20250716164158.1537269-1-hkelam@marvell.com>
 <20250716164158.1537269-5-hkelam@marvell.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250716164158.1537269-5-hkelam@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::9) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA2PR10MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: c39ebebb-5f69-412e-3469-08ddc48de80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHZ1K1R1aUpjM1pNNjZVT0lmUWR6NjFodXlva2YvS0ZWMlRnSnp0NXBCeTlk?=
 =?utf-8?B?d09lTEUvSHNqMGpRRjk0L1FNMGtqS1pHR3pPWjllVWluRGUzY05RTmFpejRD?=
 =?utf-8?B?cFN6WGNmNm9oRlowYmF6OUVVcHFBSVFFcnFqN2I2RGRNS3VGbXlzeGRWZ3Fz?=
 =?utf-8?B?d2JidGRLR1lPQS9ycUh3dGl4N0RlaUE3WGtaSXByWDZIa0V0TWhwUkJMVTFZ?=
 =?utf-8?B?NVk1MlZJZjZ2MGhhN09JOFR0QkVzSHA1WjFZRGVmemhPa0hBRWJ3dTZrbGNO?=
 =?utf-8?B?N2prYkNockFkT2F5MDNGRFo4ay9IckdZNks2bElQRGhUUVRVbmVibUdDSU9l?=
 =?utf-8?B?SVBhSTRKSkd0dy9GUWFlVnRNTjIzbmQ3TnFyOERTLzFWUXdVcmxETGcvZ2gv?=
 =?utf-8?B?bGQwM1dyUlFVWFByR3lQTFlxaGF5cmRBOVV0eUNFSEZzMGFzNVUyRkxHR0U5?=
 =?utf-8?B?bmkybVNhS3dyUmdsREszTkRKaXdIeUdGcVRkR1lkZXhqN1FCM2ZPcHdsQS9u?=
 =?utf-8?B?dUlLODE0R0p2ZURlKzRqTm9OSDF3MXFQZnZnWjJUZys1VTRhTmhxNFlmeHNY?=
 =?utf-8?B?QU8rWlNnSUN6VkZzc0FaR0JsK0Fqd003Z1UwZjZlT0xSTG1EMUFNOW1aWEJ5?=
 =?utf-8?B?d2hUWTBDWnV1ZWh2b1RoZGl4REdwVTBMb1NDWlRpdlA3YjRMZGU0YjhDUjh0?=
 =?utf-8?B?eVZlMXV3RXlKL09OZ016djd5MnQzUjNHOFlpM3ExTG5TTWNkWXY1T3BvdWNR?=
 =?utf-8?B?Unc2Tm03ejU4Wnc1UEQra3pVM0RlanRIOUlMcmpMR0dsRWRTTGdSL1NFR21r?=
 =?utf-8?B?SGRaSFhKN2FPYkE4d0tseG9temRUeWxNcmtKK08wMER1VHRaZjR2U1c3Wmtp?=
 =?utf-8?B?SVJnQnVUeVJmNjJzRnVoRTk1a1IwMEJycGdnUjJyYnBxMW5zTnVjVFhjdjQr?=
 =?utf-8?B?UkdWTFhWcDJ1ajczSmVBb1VKNkZKUnFlVmlVL0tBcUdISGE2eEdmbWFEODBJ?=
 =?utf-8?B?c2Z6dDNVbWVrUUszZU1IUEh0UTkwOW5lYUQ3OFdkdjM0bFdXVkt2T1MxN3dh?=
 =?utf-8?B?VnAvelE4c1IrN2NCMFRoeU1NK1NkekxQNzQ1NVJzTXlPck80RmtRWERPOGxm?=
 =?utf-8?B?TWllR1oyRjNDNGdRV3NiWjh4VmJmckZKTkU4QnNzOVpIYjVpSnhFc0ZTR0Vy?=
 =?utf-8?B?U3dGUENacHVybmZzRkh4YXhwNnRFT293bk5tQ2NaWVlaZkRPRjNqTUgyTnFx?=
 =?utf-8?B?TWNNNXhYeU9qaFV6WTdmVy8wOG41TnZpQ2NrV25WdmRrYUphVFc1NXNlL3dM?=
 =?utf-8?B?VjRjQzVBNENwVnk1UmhBTkJ0WkFyUW1HZVRKdGtxQTNjMjVPMkdZOEo3L3NO?=
 =?utf-8?B?UzdEOUdUVWwyenFQM2YxYUFuV2NKQzJpMzhKTzZ3a21RZGZVdzV3ZjJpdlhT?=
 =?utf-8?B?RmltOUtOQ3ZuaDdvWHRWUXFLOTloZUl1YnNodHJOMXdOcHZmR0NSbU9TS0ZH?=
 =?utf-8?B?djlNWTJRWW1VbDd5YW9ORmFwVWYxa3Y0ekhFQkNZTUgrYVplMjEwWC8zMnUv?=
 =?utf-8?B?MWtaQWxUQm5lS2tLV1J4ajVZTHZ1eEQwckV0bVVsTlRpV1hrNE0vVkxuZkE0?=
 =?utf-8?B?YXV2N0p2RCtzb3Z0ejdNaGUrV3hFc0EzRzRjZ1BJZlYzVEV1ZjUzMGpodUU3?=
 =?utf-8?B?RitCdDlkcjEyeDVTV2dWYW1lOFVuczVBOWR6YXJUa3lxVlo0OXUzQ1NhUXRq?=
 =?utf-8?B?dkpCTXY5a3FONXJZNEtjWFpLRXdWTFJJVGppdGl4MGdXbFVDN2lEMWxadmd6?=
 =?utf-8?B?K2ZYRE5YT1RydVVIS1lkaHc2Z3grQlcwZFp2WWNTdXRrN1RIUDA1UmNzcVlJ?=
 =?utf-8?B?WDYyVitOeDYzeTRZUzRTaHh2bEJJSVRpcGFsMjBwZUdkR0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWlRTmFQWm50Uk9PK2xqbmRSK0FqeThwVFlzU2ZyMzdTTisrdHB5ZlkxMzAv?=
 =?utf-8?B?OE0xaE1JL0w2cVB2K3JaTkxZdGlETU8wZXhVNWwxZXpsOUJDOXdvd0N4Y0s0?=
 =?utf-8?B?RzlLc0tlcVNGbzJvT3lYMjczR3J5QVk5RFBOVlVpNWpWbUFPUUhlN0lySjY2?=
 =?utf-8?B?cnZ4SFJZM1FiRFBSSHlBQUU2alRGTG5WU3VQZTZmdTdRZ05TMDBTZVNIa0ta?=
 =?utf-8?B?Snh4OWRob3h0VEEwL2FWbEcrdzFmMXJidkZBUlRoeHA3MlpIQ2JHMHhNTVNH?=
 =?utf-8?B?a3B0T1oxZy93TzgrVUxKdjJqdTVIcU0vazVjeUZ6MURaeE5wSnhBbUYzNHpB?=
 =?utf-8?B?N2IvTkFOS3oxUlg5d2NQc1ZmQjNrakpmWjljZDBIVElLbkpoL1creUNlZlAz?=
 =?utf-8?B?WXpjdDR5VFB2QXVjZEhhMy8vYU1uV3dRcFp5bjBwZU9GYkpoMmxSZVdSNjVS?=
 =?utf-8?B?bVpxczJZK0FtSFNtcDhqcmFnSHVPc2tKUm1FNWhlVWk4d0hjVm1LblVNbUNj?=
 =?utf-8?B?S3hVTEcxVEpXOFFnamFvdFZBa1o0cm1QWnd0OG9tdW0wZnBnQ2FWN0RkY2Qx?=
 =?utf-8?B?WHBnNHdZdEpQSlp3Y0NZaC9EcHhuTWxEYVhZc3QzbFV6U0JsNVZWcnlYTFRh?=
 =?utf-8?B?MkpPanpGUkgvb3pBMm94QmU3UGFab2RBVTh6dDRUTEFMcitqV2xkbU0vTklY?=
 =?utf-8?B?RFJ3elNuL0xPMnVsbWZqVnpYczhmd21ESWp1V0ZSRDRVbVNSQzROMEloQ1dw?=
 =?utf-8?B?NnZjeVE2UjR3NTBlS1ZHVFM5bHVlUWRKcG5oNzk2SmRmT0p5Z0crNzhZYWx0?=
 =?utf-8?B?MnJtUnB2QUJyL2RzNGlHdzJFbGlrNzI0czM4V2IxTjNGajV5c0toeS9wQURT?=
 =?utf-8?B?bUlxYUh6VjNGSTdld0xwemhpMHNDdm1HOEFzbHgzcWRkZDhUaTJmS0o0c2hV?=
 =?utf-8?B?QVZJc3ppT1JZeDQ0WXZ6T24zL2dmWGt2QjRxbkFSczdOT1VoZW1NV2NlbmRx?=
 =?utf-8?B?QmlsYmh3ME5YWUhwaGo4YjFLT0szOUh5ZnRSeE1TOGZSYi9wWnZnby83anBM?=
 =?utf-8?B?UVc0bUZ0cHlVWWplYjE2dDJUSnFtcHhPc212K2dRUjdIVUJackE3aVFDT3FJ?=
 =?utf-8?B?dWl0cW9nSTFCVXNLbjZ2WkR2RVBvSy9uR1RhWDIwcWl1aHZFL3NKQmcvazVS?=
 =?utf-8?B?a3BVSERwM3NEMXhOQXVscUs2TnV6VlhQVHR0TXVJTE5IQXZDZjVuQzkzY0xr?=
 =?utf-8?B?SFlDNGhOTE1hYnVRNHp1VkFwNFFmb3lhK08xWUpnMjBnbmRocWFHakRVYnlP?=
 =?utf-8?B?dGFrUzNKMkgvd0VXaFoya1ZRUTczSHZmNlk3a1lXT0x3OVQwZlBhVXNIOWdW?=
 =?utf-8?B?a2NCYkxESktjbUpGNE91dHBUNFFYaEc2STdoaFd1TVNSVFBjS2lLK3o2VDZ2?=
 =?utf-8?B?UnFoQTZNZW5KWTJUZDhFM3JBYlVUWXZ3QUdUUlkzYTlHUWFxaHNFbW03RmVm?=
 =?utf-8?B?d0VNbzFWZG9YWlo2VUdjb2NlY0NDTnhIZEhWSGVQNDNjaEZLNHRRZ0NDWjlp?=
 =?utf-8?B?cnVFUlc1em1rT1BTTkZQQlFpazY2REhZMlBBWDFkcmkzazRTNzlNS0orMkdV?=
 =?utf-8?B?OWcrbFREdHh4MTk1aVNCaTlXTHltRFczZkEwM1BULytGQWl4WHprc1JjYVVh?=
 =?utf-8?B?TytWUjgrbHd1N0RZeTN3MStvZDNHWGl6Z3g5Wk1zTlNJd3VIRFhQVkw0Qjkw?=
 =?utf-8?B?SUZOK0s1RlVOa0dSQmc0L3JvamVDQllsM1RaSXJ1SzhVUkdILzBYM0pvLzZo?=
 =?utf-8?B?QVpUSGVVdHR4V0pXNnVWTFdkRlBUZzRFcnVLM2VWWTdlSW95b0VlQUl2a2gy?=
 =?utf-8?B?STBoRmdLTEpLdlRaWUVoeGhFY1dBbzR6eEN4TWRhUTVjbVZCemFCQlpqUXNQ?=
 =?utf-8?B?eE1kaVlhZS95cy9pQVpIWUJ4UUl0WnBvUG8rSFZpeXpMay83OXdJMmxoM2Rp?=
 =?utf-8?B?WW4rdjFIS3FIajM5SkszT2lKRGs5RWdFN0NFQlRmM2hSY0lzQ3Q0RkdYR1BU?=
 =?utf-8?B?NTI3WFRDQ010U0tMTkJZbVpiUmxqUlp1NnRtd3FTU055bkxkMjJQOU5hSEYv?=
 =?utf-8?B?RzI5RG9PcWZpNEliekFWeE9hZUc3SnVyTUxNd21zRjdINTJrVm1BOU5Uaklw?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YVFJf/Sszh5tKxaWt+VSbutMFp3pe9cU3P00W8U/UmPN+OYurEc17TZ1len9I0MMLo45uo8kWuMSyeff6rANeAtZQSJsjSnDW40s41yceNc0BmFhGdnVdQ+NpR1DBGF5ktzy/V2naaJDCtgNHpv2qRo3CAtuLTlrPdMbkGFgI38pX8nIEi4LKgzcMX3TXp2Gb2b4BVO57wkGD3Z6zziP/vT0S0ce/N3iAVgJqdO07DXo/eOADlaQyZuxxrAtQLJMloRUOFXu20grC9kyReVF79YeibCM/iynlPmzizfpcYy1XUJ8YlfXN67mF0Q8uUWlv0QVTA5w7c0+cQAKH2a3oLVml0jcyrT5zPnEafxpTQDQYcsfnl1ATzibeEF2Io2fOwh/V12hjrG8Qu0Lt2E9tF0FNgg2vaYCDeP81qWVQjA57mOVFRJgqUvnBrcj8WU4eABuaB7Of8fbfVctIuVWAP0ML3WhCkCj7aRA/ar9Mmv9xvsajAhTjUQdKffd96KL0GmlSX1Spxzj9hranm1qWRMDJBb+TWeRckOmGytWgViPLBrDvJDbej0rd7HkOxnIvVtKZAl5lrWN1UR2xNgaCvTXZsU7VQx5YchMg0p7s1U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39ebebb-5f69-412e-3469-08ddc48de80f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:26:32.3061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5L9FzVw/cl5vAX0dVvMOXD3nWfQ5rNtjH6gMxYtBIV3tFSSoHWPH5Y+88ukfSgR6nT00cwn4WhCJ/sqcQCasudGqKrMVllEtYiUvtRTYSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160157
X-Proofpoint-GUID: 8YBcWTcuibX9xYuIacTpKc-cbEqWBSMW
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=6877e0cc b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=hMOJt8txAAAA:8 a=KifXzYK7MrYMamNZ028A:9 a=QEXdDO2ut3YA:10 a=VB-UQLohyrnngkzD1eWn:22 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: 8YBcWTcuibX9xYuIacTpKc-cbEqWBSMW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1NyBTYWx0ZWRfX0XWRw6fAEqvH gYk4Gd6xoRSfFv8B9tH+AKXbmQqUHmi6Aq+yC9IEjgvuhgsb3kM1h4mUusVnc8u0gA/krhLwCpC 96X1PZ8j7bbKP3QyETf5fZU8l1E+lKYlXR2o0FTSmEuOKTwPchRxfB774JCGF4+VUxFaxD5phdq
 LKRc/HfJ3lwagkOeYc9yY2PR7i4/KaT2iVXvpGj/xJLrPZNBcu+jGum8p9YmUnONZZZNl+B3hiX unaLhqdgakdDy+MAPvL1QPmi+gEOcalx9i7jNU6CfSIm//V5shOJjRk/uOb8BNhIlrmuP6xuFz0 /gCl9zrq28OOhweq5lZeY1r6hFXqXmrZ/9+CA3GGYG1ojwrMJiCeNuOaRN5L+f6Rfv8YaPZsCAW
 UiFam4dyq2kY0QrCgAh6Pjke4ge6ZZSNpBGDJJQeUUdWgCvW1bXxnTwUD7rclgU2gV0DHlWp



On 7/16/2025 10:11 PM, Hariprasad Kelam wrote:
> +	seq_puts(s, "\n\t\tSDP CHANNEL INFORMATION\n");
> +	seq_puts(s, "\t\t=======================\n");
> +	seq_printf(s, "\t\tValid \t\t\t :%x\n", fwdata->channel_data.valid);
> +	seq_printf(s, "\t\tNode ID \t\t :%x\n", fwdata->channel_data.info.node_id);
> +	seq_printf(s, "\t\tNumner of VFs  \t\t :%x\n", fwdata->channel_data.info.max_vfs);

typo Numner -> Number

> +	seq_printf(s, "\t\tNumber of PF-Rings \t :%x\n", fwdata->channel_data.info.num_pf_rings);
> +	seq_printf(s, "\t\tPF SRN \t\t\t :%x\n", fwdata->channel_data.info.pf_srn);
> +	seq_puts(s, "\n");


Thanks,
Alok

