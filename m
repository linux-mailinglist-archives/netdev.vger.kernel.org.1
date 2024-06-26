Return-Path: <netdev+bounces-106707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AAC917548
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 02:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1FF1F21DF9
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 00:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E954E63C8;
	Wed, 26 Jun 2024 00:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="BgI5hVg+";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Jp+orvk2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9F53AD;
	Wed, 26 Jun 2024 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719362499; cv=fail; b=GXF3uIJ+JOc+EvN/oPgRZWoSPqhusKCzaNhbVxVZX5C/HAX4AuKkGdTAIXR7wxaRrMhbOLzE7tOf54wMEMEmZXuthzcX82/2DyAtUjZVAb0byOHDRrjiN9pvUtTF90Rkp3vIOaVj3LGlAqI+s/jJCXdjbqNrtdiyw1dHfLgTIvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719362499; c=relaxed/simple;
	bh=T+tspCVxORZRPpDV4/m0eDdDVbqCogKEUYmnRHp2CzE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kGeyteW03PV6GaBLjJV0mRYRBlb58ilrtGufvqbNbZQ3tAY1aHuwwUvRZVJ4JD3+gLaV5LdM5oCax/V1end58ZE1YGv+OU/ksII65Gn5J2I3y0aiBXUXbTAuxRbhsoexaPjkL95Kr1wB8844tiSSQ3CG6x2UkrPExU6SHRIsGJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=BgI5hVg+; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Jp+orvk2; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PCf4Wb007920;
	Tue, 25 Jun 2024 17:41:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=GxUO7Crv88/9T
	JN2eXU/KkjXzuCitKV06caspmUD0i8=; b=BgI5hVg+O8YCNOFqzr2LcZ6SXNJu+
	Ub31lJ8r/B9c7VAsLfQAyNsBENkt1Q47J6SVdpGtHzZsjjd2YXxlN18gar99hAzv
	3HC9ufWWxB0w+txigPKrUfsyDqnAzmsTxfFK+6N9wSF2y/+fSCPY+Kj7JY5CtCPD
	LVQzMFCktwivJF4EycqZ9/VbZIbFM7qJ1dY5CKBUBkCFWcenyUC9Kv1eQ8+tcdGl
	UoMibxd4rZSKn56E2YD3ggPGl3gMupVO0SLLxGZelx9LhjxFXCZDPmu1eXJ1WcvY
	hiQkERMFceSIMlAO4lhYfsWrFh0JGq2Q3rpsowEzcCsAeB+qUnozJaFeg==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3ywx4x72mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bonf3G2qoNXYGr1VP3EkijxMfbI1HpzfJPtJGKDFeL1Jm59lqYG6J29IYOKKPpi+wH75bcTY5ew5g/QoTMA6rxDb9mvNqwZVSTdwYL7rSlpC/WR7z8tmY/uRxKdMr4EvZsmX3c7/ncKB/9Jhy0KS9SX29zuQVFgnzud2qEfCEydXe3+EZJukYlvpU3wQb71rFrb5omnTyVbde/Ek1gYW7IkUFe3QP7HXXidbpO0ICcNEBpbwRgBmZTBXPW3R/zfOe2gfkIi27V3Rsbc3+n5N4qMrlSf4eIvh37MvMXjwHCO5Xn1DE7ibE1qvcfauoozGJ147b989tG+JH9/VM9YJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxUO7Crv88/9TJN2eXU/KkjXzuCitKV06caspmUD0i8=;
 b=A/6hPPG7N0Gcja+s48Wn5NBtICjoL2AknObsiQNaLCKw6HL79L58o+d/drPPPA5QORlKwSqST9zHk2f6Jtg2eVIS7wrRdpVlGSiLF6OuqqBKrprMtTqJeseDOgCzYFoEEnHP25qla329kOxAXD+ivMDcVE4yJS54jPuR8Gdb068hBGeRRZWIywEGdpFFifGNbHi0WxdEkhL4rqgIPwh5Sm7PcKARF2aZ9znI/lt/n2QEDmdNKbuF1feUZBfVj49CKZTH9hod+lDCYuguUE88PgC1rDyNvIzqfBMUNNTGajAZVagGfq3xlwPcLBfpfdZQ82tAVZnKgS8c+Ruhf2v/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxUO7Crv88/9TJN2eXU/KkjXzuCitKV06caspmUD0i8=;
 b=Jp+orvk2bAQZFTrcjL+0Fy/0O8If/YpGgqsR5NE52kRdPUA75sreJlJCSBsA5FEtwfXkbszP1vAVlaes1INBSA1dpuJZKCCTfMePfL+lPkXS/N5Bo09o+Yj5AumiiFELma25l1k9F+ogJW/5+oHvfV9rSCcVIhEU7oO0mAaUgAN6KOdL4MMQYObR0bWEaArGPtuZnmTTpkAxcM/W9vpz5KMIIznr8ADBnBqgCStBeE29MqPUwN9M6GwWkUXmrN+rI0mBZXpnM36n5YXgvL58T3NcvaEjfCJvLib05ileit/WSZrz6M/yyROURD5a+vRle1SeNcLM9H7avWgk62terg==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SJ2PR02MB9315.namprd02.prod.outlook.com
 (2603:10b6:a03:4cf::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Wed, 26 Jun
 2024 00:41:27 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 00:41:27 +0000
From: Jon Kohler <jon@nutanix.com>
To: Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next v3] enic: add ethtool get_channel support
Date: Tue, 25 Jun 2024 17:53:38 -0700
Message-ID: <20240626005339.649168-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::14) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|SJ2PR02MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1da3d7-2124-4bc3-4ff0-08dc9578b68c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+ea6t6cZdRWFJwzBznEeYrLW6J9Xy3UCWitNAWD2+KmJVAOBzc0OAbjVYodk?=
 =?us-ascii?Q?S6/ntBG5f+ubT6HXr9gwtV09t/hXTGyiH/ATjLNAJ2GIChB3ylE68ei4KA3b?=
 =?us-ascii?Q?Sx89B/DswtyeAjQCG52rh01r6hkMqJwLfTSUSBXo9gbO2jIcWlcmdvP8cCP0?=
 =?us-ascii?Q?xsD6O0DsnP+zEf9h6rhMrbBW3NPytzmq0g1xZewcLFREhRBezwiRkZtpxFq1?=
 =?us-ascii?Q?nJU72HKh+dr7zIvReDZXsmvK7Soa1GpqAia9+7r0TN3/B6y9HVM5ygj8BCFG?=
 =?us-ascii?Q?YpgB0adnZxpn9dXPX1TPtXKHS16Pnd8b5w8omoMWLAG6M3DHFFPcGWnlWAvH?=
 =?us-ascii?Q?PC6od//cfHCrasboFblN43S+Oh4pbjRZgHy0+l28GcA2PTleBbyriusBhU1V?=
 =?us-ascii?Q?nHXu1U9h+n71GZXWtaWlYaVk4hBp8sKH/z9kD4gD50+3d6vDx1F75RO5L7Y1?=
 =?us-ascii?Q?fegE26Pg3TUYFyhe47sPk0EzdTZMc0OjI3WNK/MJzpTYhTUhxKh9dyJloIKD?=
 =?us-ascii?Q?tRHzLvLdF8mUmWbcMIR0jcyGfXmDRbR0fUZlONJKxiKKfbrVjwSThidoTYph?=
 =?us-ascii?Q?lXwc1XNqogseJWoWu4C55b7yV6CFTgl0no2t0yDf4V1HFaobCwoIGOYaZdVD?=
 =?us-ascii?Q?J48NgAb1CPkLOBRp8aVsiQ7SQYN9OAE/2wT1V5Mb3A8cQ/9u/wUjIL3bOV8E?=
 =?us-ascii?Q?qjulaf2Pg16b+uMqWT/4o2CzMkrcLWfw0SMWaMhOTzJqgdXXb4Gmh4MCY3Xw?=
 =?us-ascii?Q?7DHxa0tIasgTPoO/lkr6Ok6DDwG3zN5lng2wxh2gc9TpmetSlQHAawR2uWnB?=
 =?us-ascii?Q?TVtpRPr0TRyEB42PnhUoBUb45Zc2v6mrKJmCmQZrp1zxtqrx71C+8bMxY3C+?=
 =?us-ascii?Q?cP6r3rsnbKLiE/MV0qKRjA4w5i/cWqOXtDu6kp95j6TOdI7rNoN+kro0G87Q?=
 =?us-ascii?Q?7IEhRJ++bzJpr5rFNzQyRRiGLXikez4UXJtA50G8Fel73OV86+ktisstG2rI?=
 =?us-ascii?Q?1cKSxA743MgLjkLuUH435MUTkvUYUn5v06u+ntVrnu/K40Ep92Woeg5caUjJ?=
 =?us-ascii?Q?B94MM+tNBmjv1hh9NRCSAtQJ3KnZXLkWlJmFpMMRRPBoISRysgrtS4kGbeBO?=
 =?us-ascii?Q?izbzxB+ZNpSD9jvMM+AphSU/Vws2pGZtg9eg/L6AXnvO3o5dfMWR/w5Oip5E?=
 =?us-ascii?Q?U8bsjrv67FO9hCrLuCDAy8xliHt5tSij+f0ncptZtRx+bJFnjoSW4gE61sJp?=
 =?us-ascii?Q?uqp4SelBtT78H12wQInSNXAtSbsTHy2sKv4nRTtBEJs9rpEOF/VyZTV24lKF?=
 =?us-ascii?Q?woOHfIfuVlZlJ/oPD877dNjF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?axVNuKF2OyKdAYDiZBMiS0KIx3F8E3cCdKG9vYuoDNVULQprYBBj3LclCPBn?=
 =?us-ascii?Q?MQHtN5Zxww+vyNKL9I7Xrx434DkzaEwCUTGOrOClKzvJN/ULpfO66gNf+l3X?=
 =?us-ascii?Q?rBAZccClQhyN7THEeYQ3rjVXoOZM9UlFCEL2A/AZsgwIBmMSJDO9Vgjg3aKT?=
 =?us-ascii?Q?sZtgR8smfQce1AeknVGAMU5YadqCkPLpZ+tFrkw9HmA5iCCakH+x5iocEHlE?=
 =?us-ascii?Q?tWh56ZBhkC/r1KvbvlEqh0eBf14ROFs1uxyU5oVy68r+791tqs5QB7t1QKJx?=
 =?us-ascii?Q?qRrYBynMOLVaLDHEuYR5EbHcEvqAfkI/fkoVLUrRgqoeqleOukYoJ7zk9LHE?=
 =?us-ascii?Q?bcyp8AWo2BPigWXHEywjX3e43LGBrhxis/RqQHTu8JLxz8qS/131Pa6hsaYO?=
 =?us-ascii?Q?Xl/elixvURA9YpTUUcNhLCiaphT1ptlDpvo59YNdA26W/WGgJBW+0kSnOkjK?=
 =?us-ascii?Q?SFlkqAdm54tfCyYLEnhhHsd6q8ytmnI5RA3qXa7EBOxlVP6Aaqj9Z/4ZOOJC?=
 =?us-ascii?Q?YzeUNLBlfGhNbSeeoN6dY0InPZzUeJLBmPoZjn+7gA69VLlTfihGj1bl1fU3?=
 =?us-ascii?Q?Nurny7LJrOqoyVBOnFAjc0A5yrvvGJ9g//U3ZhnyRGPtHq1OP3b1QDbY4wz7?=
 =?us-ascii?Q?w8tWCPPprmQN0npgqDw0Draw+5pUAI6yFM+hsEFZ0/J65jJnTwTlC8QxpUL0?=
 =?us-ascii?Q?2qQktJC4V/B/1N2nPqoNqP44l+ilzM1o4BIWi4s8lH5ApNdW99ecDeu4qmF2?=
 =?us-ascii?Q?Xf6DGenx+wXETjBCdcR89H8bZH1L5p0+UIbsM7vsURG97vRiLbdKX+t/hlyO?=
 =?us-ascii?Q?wCHPDcFcWMjj7FXQK/MNX7s0NyYMxPZEAa/AzAvz1ScUvQxypxEwviCFw5+Q?=
 =?us-ascii?Q?r2Dda7naxRVePxpclHeH1y4WUymCWny85ywCSyzpX5lvusPPlECRsVhLyPZm?=
 =?us-ascii?Q?/z5Gn+eg6bGdgrCd4wzPgS6flI6N4NqsNyzspijEN2cUxkJrz9Jg6f7ZqcOJ?=
 =?us-ascii?Q?OGtaD1yeM3YhgCt8G9Xa/D9fNtYlQuRNZ/x5H54bmJ0jMWRtx7uOzzMc9RWk?=
 =?us-ascii?Q?+K6CEK6T3qLCd5Vlh7je/tf8NVgRQRnNXEt5ibZxQFXwuWHqMaxdnmPKZCPD?=
 =?us-ascii?Q?ECQt08wM+S9h4oyDUyPBfGpGKZGbxNDWijaKvWGpnh+9tLF44Pl7vRV4U9WT?=
 =?us-ascii?Q?257RKTqmuJt0FIEzV8OJERP5CFjEwi9GaITmg6fDpwsqNWaIl+lx9T+9wgSd?=
 =?us-ascii?Q?PeAwNIIE+bwVdS/dwRItVkN55uu8MIDSCOcYNub4c6mrDGphkfpdEiaxsYQA?=
 =?us-ascii?Q?xZUlHdwacu48X9k8k1iyeu5TEn//Yc+tz7CaCN+O4SZDk5Qnhjw/GDhyfOVd?=
 =?us-ascii?Q?OSfDKFEEw0k6bXJpl+LxY6wXwtVS1loLjQybtwpFHU/wPUFutXpHDg3bqfz3?=
 =?us-ascii?Q?vIsR1AZirHOuSmBRVomKPv8/sCxLnK55HmYfWdpjceEEgAkWufuqPxu9imVH?=
 =?us-ascii?Q?+/SvoHuUR9hxO/apZKvEsl5X0ZmqWffJpPnYrK5QGMrWtdeR2QnfHgcG4c4v?=
 =?us-ascii?Q?VwvQ8iegCl5sXwtrSo3Prv+0PLSAnYGU5l1YeH+Ule90NIOwzzpFr861J+uF?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1da3d7-2124-4bc3-4ff0-08dc9578b68c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 00:41:27.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHHN9w/9eKRlNqZiFGzogMZWsJER2dPR1hrPycxrJxIvvCi8vBmWTeTecAcqnu2Dtc2ShZxix8UiFpfvPgZ6s5GyWRuds+8PILdvGp8y1vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9315
X-Proofpoint-ORIG-GUID: aNNU4qGrbS2302d23Ysgx280hxdkr83i
X-Proofpoint-GUID: aNNU4qGrbS2302d23Ysgx280hxdkr83i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_19,2024-06-25_01,2024-05-17_01
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
- https://lore.kernel.org/netdev/20240618160146.3900470-1-jon@nutanix.com/T/
v1 -> v2:
- https://lore.kernel.org/netdev/20240624184900.3998084-1-jon@nutanix.com/T/
- Addressed comments from Przemek and Jakub
- Reviewed-by tag for Sai Krishna
v2 -> v3:
- Addressed comment from Jakub to combine MSI and INTX cases
---
 .../net/ethernet/cisco/enic/enic_ethtool.c    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index 241906697019..b4825f2ceed7 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -608,6 +608,27 @@ static int enic_get_ts_info(struct net_device *netdev,
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
@@ -632,6 +653,7 @@ static const struct ethtool_ops enic_ethtool_ops = {
 	.set_rxfh = enic_set_rxfh,
 	.get_link_ksettings = enic_get_ksettings,
 	.get_ts_info = enic_get_ts_info,
+	.get_channels = enic_get_channels,
 };
 
 void enic_set_ethtool_ops(struct net_device *netdev)
-- 
2.43.0


