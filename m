Return-Path: <netdev+bounces-106234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C35A3915688
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 20:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B47B219A7
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 18:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E1F19FA91;
	Mon, 24 Jun 2024 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Q6iE+hy2";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="RcmxhQOM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B51E4AE;
	Mon, 24 Jun 2024 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254231; cv=fail; b=HWH6zUyFE+QjM4n+2gupl4wFQuiHtpcgmhpreVObchO3nbokPWGkGq2OY8p5EGwC9YOKxaNrrVEQTKY0JwZs378KpkyipOQPQUB/J7LHnX/J0bEx/ectfqEI3lLea8Rtvt4SIwId+2/54qXEXjRLwmcksfAewsDvLwOy2X4Clfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254231; c=relaxed/simple;
	bh=MqJd9edIczD26iZjE0gXcVcZKG6EZ0jHl2oGeZ13KUo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m1bbRnOKkKlTES5HZUKAeYL+pqTClMLvFrUCJHpqGWzEzAiFjgoGVDe/aUPhh5EFUti20lpkBaOAhgtt2IkEzpfgCxWdNgS77pjZMkfzqNUv4CCP++wuS7VqbihRWFwxZSwFb0Oqtw6n1BsJm1PmqwpLQpyDXrPfbbihwR6VVY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Q6iE+hy2; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=RcmxhQOM; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OBZT00027577;
	Mon, 24 Jun 2024 11:36:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=Ek6ZW3Cd8Xhwd
	K2cJ3DNIY53Vg4qkWNdxjVJqL4U/w4=; b=Q6iE+hy2kOLOKz3qz1E1YQ5KxfL9b
	t4Oh+rc1dX1S7Lq4DjbtOyhh6iQHy1Ttl1ocoHdqDkxJE3lLYbVrhoITr+b01NJ4
	aMG5og8K5w4HkVCPh+TKx9+w3ei5PHgQqhubVUHOW3D46zA/hFuEPAigolhN45Tl
	xIntx0wbl6W2Qxx7/7HGfgWeXa4fEui2oU5d3L2Nt4q8FplW8Dmb9qE/UwE/EQQR
	/t5Wc186dVZbytE2QQvVP287NgdQva5vkanqR1pUjDU7auEvB2snmnKe4qV/MeAC
	HjC+7o3ZL+bx2aAeHXB4Dos/LtWqtFvpIBniZveoECesOF0hKVYUyupzQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3ywwpd3xwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 11:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DC+tsZgX0acbnZJPXLvu2hP29KngSV7puMCYvkkCWrNsOdT2bqCMx09zEl+vAyNXGqGx3dcQKzvKYXlATB8wyA/55yy5VPlkN/sNNQuU+n5rlRNXtsfQ9KC5IMSTrKZbUe3TN+hWpODf7JW/r/ZbbXpXBmq28chilLgR1tD9PxVwT8Bf4XX7ZxQDRba3JizVsnCZjIILqq7Tgs4Jb4azGqUfGbAxMrh9fZIFgDcysTJKkajGQp9/BLoEWJwLq+TOieSjKipoXKxh45Wa7jFkeAlh5rz6Q+Und+etKk7cT2yGsjeWM8FN2uCo7SnE8+RJOXYq7Bm6I7XXyRh8Cvj+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ek6ZW3Cd8XhwdK2cJ3DNIY53Vg4qkWNdxjVJqL4U/w4=;
 b=PAJzXJlW7lOWTmdsiOuNNr3jQ0+/holxhR13KyyWYj9/mSUR5Zq6C17csROf2Bshou2Nht5Fl45wTaWnb66OyNl0fMBlHAIcvLi/LB+ui2Ek/0rtd3gnhjU9wMAqPvmFrbrLQcsypaLSRGYUGKlmuytWsv9cnfB5IA0Hr3tSrWYCHAN1kJuD++cAODrZwwHm1AlnzVFNisSuznOWlyXmUrjm7MIv9n3neB5prDRbsDqxWjVU4KGrPeE7TxmV5eIkmKjpFefyjAGTzsMnyHPhWHoX8njOOcPEmEUqgOme2mw26cJoYmGJerlCo/MaC4z1T4jFXrY/v1/rOXPpod+yGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek6ZW3Cd8XhwdK2cJ3DNIY53Vg4qkWNdxjVJqL4U/w4=;
 b=RcmxhQOMtt0o1uKi3yZaqev+Y9BOHfRwAW1Hj7QcKdiF6Sqi+wVba94BKJiopvUItgfvHTC7Y2y89dWgAiY0vA7IEdvuJ2yXrEP2aT6e1TvYxuXD/PE2yaZzRanSzqsBaJU8cMezhVEapexqNIA/uru7kg2rKbozj06Gutntk0FbO7zGAaXnz6bhneG6BXQ91zRTf011QqEKkzB7w18GvMs2GG3gY3InAA2voQgKfNUF1I6fFRaE2tNI1tlb72HRezaQoBXec8bAgPMB67Hh5kANWABjn4hacIE7PFGAdz4iQfM1lflLPsMpnCBC9rZYT+8hbRaCyefKNkmXr3dOyQ==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SJ0PR02MB8499.namprd02.prod.outlook.com
 (2603:10b6:a03:3e7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 18:36:45 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%3]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 18:36:45 +0000
From: Jon Kohler <jon@nutanix.com>
To: Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH v2] enic: add ethtool get_channel support
Date: Mon, 24 Jun 2024 11:49:00 -0700
Message-ID: <20240624184900.3998084-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0031.prod.exchangelabs.com (2603:10b6:a02:80::44)
 To LV8PR02MB10287.namprd02.prod.outlook.com (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|SJ0PR02MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3717e4-aa2e-45aa-eb81-08dc947c9995
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230037|52116011|366013|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ee1ZL39VIfU0FOF9UjVRaUKHmhnFDVvtNo880xZDWFpMHXW1cMWkxGqq02ey?=
 =?us-ascii?Q?yxQEas8K5tRpFWt0D3VLlbINFhs77mxTm3pIDODHgUA9iJi+NAGqGgeHy2dY?=
 =?us-ascii?Q?d/QYLBeQwZRvh2Z1LJTolTSmCguF15MONlY7zqXaBOXUaW/vPbR8dH38oEvl?=
 =?us-ascii?Q?s1CX2ScQJqA3H1jZlJuszNBIMvj6OzsOYohZNVSCsO59brkmuGMRO/ZUR8JW?=
 =?us-ascii?Q?Vjh+RK0VUfgn6wM6zsuHU/DLyXnPkzZRSJOBPCiNO/P+ZfxEEbae3lDkH8XQ?=
 =?us-ascii?Q?3N+gQIed5ZZbVAI50byIHCSSeKMjpzVwuqJsi8BMwQKM9eYmC3j4axI0cZiJ?=
 =?us-ascii?Q?0lkZ8xznk7f5fj7XiFfJ4wTXW6Tacmn6rVZKHXWlyyt2giI1RolWBJU0Sgta?=
 =?us-ascii?Q?ftMVI9cJ8Dowo2SstYXQ/fGmZc8S7mr+2dYndKTLPu+EoApTI/POtd+WYGl+?=
 =?us-ascii?Q?NY/dDPw0N+AFDtcYPRDqgTHrEiR6APhI3kdPetxvTCj4kiR+1UjLBxsDrsui?=
 =?us-ascii?Q?YyrIHejyV8OxZBDLJdva5N11svmYsZAdkcSU1aGAcH1JyWteJFoCnhFK86ZH?=
 =?us-ascii?Q?hTmb2NW4b3uuRpxAFvrJOVXLum5fTgSmOjMzqrXgaLe8oVDuPHC2GTHRDOxR?=
 =?us-ascii?Q?Sd5PCL2YH4mU222mwHJhRWoDmTfh0NN0TfEDmjFjQ91URuH98B/i21Tb8K6Y?=
 =?us-ascii?Q?vEu38fe3vzkVnmCJejHnHyXeAGv5Gknn864Ui2vs3BYbL/evC+1A+ZHFr2S2?=
 =?us-ascii?Q?8jZAxbNGXSUMYYcU6/royncut/1+4owzVA123w3PvoDoO7Y8LWUQsaQ/wdu5?=
 =?us-ascii?Q?KYrfG1wCRZHwrkEJwOsNtXuSnwtmCvDIPmZceq4I8FqLQ4ZSZBto5c5l/BBB?=
 =?us-ascii?Q?ih9x3h/oP0JvTsmO8wyxgQpVoig9Y7QgT+ln3Fts5BKl7ibIGhecdPiI93qm?=
 =?us-ascii?Q?IGr8I1HOK9wAIZO1yuS1YeIkuAq0lPaFE/D987veYwHOu1QmOQMogznUD5Sq?=
 =?us-ascii?Q?ihOAxZRxhzdIRT3DpgBq0w8un2UU4I8q4YdERvxNauZNvT1NVzzm4r66nhQ0?=
 =?us-ascii?Q?MShjnnxpKXVYEC/SuSc+QNzsBUP/4y7qaV18DaZ3/Jf/S9f0PApwuvKsWCC7?=
 =?us-ascii?Q?nBArbkBHt6i5sl8CmGA+UFkwI5MfCRmJdUxbTavk8B7VJvHBS/ohWfYZDPS3?=
 =?us-ascii?Q?m0g8Y8VBpWaEQZ4sBpQCr23slmaEp8/gt2HZeqe7BEpS+xMxw/R8BDCZ62Wd?=
 =?us-ascii?Q?VFL1BCzOdXR+eqgTIaotSaPHH3awDjoY3OZuR03Xd0gyqTRFLevnQtZvau0Z?=
 =?us-ascii?Q?CxvjtCkpz2XpW0bcY+Oy6EwK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(366013)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lbOz2ZxbsK5XXqANMBR24zj+5269M4ySHeDEc/qAKWrk1o+XTZB69g7CW/ii?=
 =?us-ascii?Q?8QX4tIEnjybvK3FecfgOmYAclU5yWR/ZCbzfVxY+Gxnj/x7OQ05KKFfopii4?=
 =?us-ascii?Q?UWCAPF4ctHWduL04ecQOqojygVZrcd7HUJBzsjSVU26Ca2ypk9Z4ssDt3uxj?=
 =?us-ascii?Q?LnouOZiqbvM+qA3utb6OM/2Q4DbvLQAXi3RDhHy5nCF9/Aq7RaVu1VJhSxrm?=
 =?us-ascii?Q?B7ggzHg4D7sgNvI5H7iKmsuthoidWjtfCDvJ2C3arnkpPm6auzy1LUUA3SRH?=
 =?us-ascii?Q?0gV8pWxdGyYLfwCfVQbUkbSN6vhBZbLVKtmS5jZJ+3tfmt329nz4ExSUf4Wf?=
 =?us-ascii?Q?Cq5SoML2EFsu/01pEGcHuKr6mchVnkIug8BQhYB8abEFRBjqmOOPQ0FSBVvP?=
 =?us-ascii?Q?0Sl2vd3FzCpWBmi8sVrLW9V6ne9M265CaGbthopUIcOdHf2RQPYyWCXCty2q?=
 =?us-ascii?Q?meVrrTzUvbDgzBqERX1XSh5KgNzf5LAxTvnrl9fij0cQOtpKBfwmJ8Z9GxN/?=
 =?us-ascii?Q?O/7ed7md+sD3Ova4TE2VIdb05RoY00JYWpFWyvbmzgqkYnuuNYA5/gyWfyLF?=
 =?us-ascii?Q?zkABp3WC11VnRZXBeIw5NX7AVq4/6zw32F2nBkXgHJciDddhoG4XU70DMeTl?=
 =?us-ascii?Q?KqmMiPyL7wboRwwe0TAhvY77JybTZ1hVGkWMv2zB4pfcvLm437vRMiZ6r3Ro?=
 =?us-ascii?Q?4wmF8D08SUsk5FJTF1PeVEWHaTkk0K5eV3hoOuPHKuOhidV+OK9mD6DnGGSt?=
 =?us-ascii?Q?ten/DQldyEAHR5BiSB0vaNy0DWLsIFY3b1YCcdCbhSuF7MJs7+uFgU4+B6XC?=
 =?us-ascii?Q?BUpyO/FsffZzhsT0apbAi6t8Kew/dHZIbbnuJlgFDNWbR29qB5DonooPhdGk?=
 =?us-ascii?Q?8wgC7Ml2jNJbQt8vJRkw4xcFb3bwBCn+3YxMBBo0qTH24HBiuZLnVaw5ZxS1?=
 =?us-ascii?Q?a+R4GVhlSRApWCOjJXI1qjqfUaroVBj45Q7o4YyzQ9idYNsDvuL2hqKMcS23?=
 =?us-ascii?Q?rhmW0469a0flXQU9egusRWJX0weIrpwlc9Z+v/t0Pr4LHnFapGSqSz1kFoDv?=
 =?us-ascii?Q?KhRdQVvAMPPcCeWCAesdETLPJObYExFE1ih1VgrqCIo0hI5U4gWMfwbKPeQS?=
 =?us-ascii?Q?9EjlY8GTGwf0wu7zhuAu6yk1ypvZyqUyqBXje1FaiCGaKMXFvzWrf2jQuaaD?=
 =?us-ascii?Q?iWwBpeq6EmGjOn1d9nmEG9oYvsHNj1MX6Ikdiqqa7wW+6Uo+ixE0X1yahBC4?=
 =?us-ascii?Q?V9MKGKLl09zNGvpRBO4gtP7ZJGbqejcCLfLr7FWdeVgo8Y1TrvXO/Vu+wW0D?=
 =?us-ascii?Q?WYXaLkAGMecRcJrZE0Fw7AV8liBxN9kXhHAtbsGs+cIoW134tiR7gLPoegyO?=
 =?us-ascii?Q?wagxOqJM1Gy8qSmH+fJrY2D+C5AfVHgtZ4DRQ3LVLxpfGhmJyNH+5tLPgdOf?=
 =?us-ascii?Q?OJ7zEZcQs24w3ezSMJlMzmpdgbdb99XuaHwvM6zqndZxuxsHbQJSZO9C1n24?=
 =?us-ascii?Q?ETEeIUTkicBwODDGn0ROmRRb++PRfA9laLi8q26r7QphPTHza2JUcr87PT33?=
 =?us-ascii?Q?UklrrFo9U98tHE6ErdV/Ym7lWrWMRSh8ZfKMSz9KuyKFkLiYfVZm/XPMHuj6?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3717e4-aa2e-45aa-eb81-08dc947c9995
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 18:36:45.4605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDIvuwAFk7uH8C/hEK/1XUpV2Nuk/OOVm6i1i9dIfg/dIU+g5uvYNHqh2/ZI+CQfYaw3aQSWM/6UC9wuTiLUIX2BdAiHATDKByvxWVFTbps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8499
X-Proofpoint-GUID: EUT7a0xKF6bv1ahofNPrfZCUPYyGH53T
X-Proofpoint-ORIG-GUID: EUT7a0xKF6bv1ahofNPrfZCUPYyGH53T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_15,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

Add .get_channel to enic_ethtool_ops to enable basic ethtool -l
support to get the current channel configuration.

Note that the driver does not support dynamically changing queue
configuration, so .set_channel is intentionally unused. Instead, users
should use Cisco's hardware management tools (UCSM/IMC) to modify
virtual interface card configuration out of band.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
v1
- https://lore.kernel.org/netdev/20240618160146.3900470-1-jon@nutanix.com/T/#u
v1 -> v2:
- Addressed comments from Przemek and Jakub
---
 .../net/ethernet/cisco/enic/enic_ethtool.c    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index 241906697019..54f542238b4e 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -608,6 +608,32 @@ static int enic_get_ts_info(struct net_device *netdev,
 	return 0;
 }
 
+static void enic_get_channels(struct net_device *netdev,
+			      struct ethtool_channels *channels)
+{
+	struct enic *enic = netdev_priv(netdev);
+
+	switch (vnic_dev_get_intr_mode(enic->vdev)) {
+	case VNIC_DEV_INTR_MODE_MSIX:
+		channels->max_rx = ENIC_RQ_MAX;
+		channels->max_tx = ENIC_WQ_MAX;
+		channels->rx_count = enic->rq_count;
+		channels->tx_count = enic->wq_count;
+		break;
+	case VNIC_DEV_INTR_MODE_MSI:
+		channels->max_rx = 1;
+		channels->max_tx = 1;
+		channels->rx_count = 1;
+		channels->tx_count = 1;
+		break;
+	case VNIC_DEV_INTR_MODE_INTX:
+		channels->max_combined = 1;
+		channels->combined_count = 1;
+	default:
+		break;
+	}
+}
+
 static const struct ethtool_ops enic_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
@@ -632,6 +658,7 @@ static const struct ethtool_ops enic_ethtool_ops = {
 	.set_rxfh = enic_set_rxfh,
 	.get_link_ksettings = enic_get_ksettings,
 	.get_ts_info = enic_get_ts_info,
+	.get_channels = enic_get_channels,
 };
 
 void enic_set_ethtool_ops(struct net_device *netdev)
-- 
2.43.0


