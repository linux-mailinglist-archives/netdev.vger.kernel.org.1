Return-Path: <netdev+bounces-73907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C7885F3C4
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2399D1F23728
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 09:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DAC37152;
	Thu, 22 Feb 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZC9SRlMM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v1e9xHal"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600536B02
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592483; cv=fail; b=kf6u2USoXiZLZ67zOJ4994eBThiSLBhey74K3KCpI/iLbkRzNXO2um7czsXexAS4Y+lp7m0Dte7k93rKTcXBKgXtlAYKS3+SeUaTHlbnazsN8bip5ez+EWO5j6vvAJ0hWTUd4HFytZm5Cvuskzx7ZYuU9N+LFDVh5DGYZzkisuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592483; c=relaxed/simple;
	bh=JL7szRo990WP5/u9EpglTb13VSED1efbEF52ZG0VPvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/7+qNVNef74/qAAU901nH62dt2JaXPPK3ZioTKQ1YKFbkKj4gyWtCaTdThrTJ5WlnnBiDjEkOAqLYMtS9EDkATOUm/y37VMBSmTPtjEoyEWjmK/K41aZAWvE5RgDnrNHyN52q6HJL+Ncv2e+74z3viovdd14A0iBbdbljKrYoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZC9SRlMM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v1e9xHal; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41M3T0Gb012732;
	Thu, 22 Feb 2024 09:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=qD30rdJPiiZK7dnYQcoEX1CiruFiCjHqrbu+rJOkFGk=;
 b=ZC9SRlMMeU90WcnACqwLuFHlA22lnGycUO3x+P3VwPE2TGV9RkBVhmRpo3//Diysj/I3
 q0CY1yCBj4APfL5ql+PRCHFLRErH6sn2JB0Qcw96u397fkwfgP9m+oMwDVFPmxaJgzyr
 R60BkDn5H4jVsgQHLCkzrY9W9A8vUoJne6dYrLPPPUjl4x8b8wV4soDop94TkM0ETMUf
 3VeSx1Mq5zvP+GLS2VgQ508ClUSsWTPZde1XpNW+5PvwBRQK76wKrn2Am9jzlgJu9zeh
 OfSZZ0m2AWVGqGJZOANZkPySKS1EvIA6KV83adge31D6Mb65nOQQuMuFqVFKhhBu9u+m LA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd2c4hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 09:01:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41M90eN3006583;
	Thu, 22 Feb 2024 09:01:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8ahvdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 09:01:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W19Iczv0IcAAZWju2Vj3Z9j77wwvfiBE9zU888YgSBmCsGEy5M/G4mMg3JVx5K0YNvZcsgODRYnaucxlZ/srC47GYJYCI9CPAeKqkXbACzYetn6thkiySDMAZH6I/m1XZ9JGv8dCNMbWbPEIi9PrzXje0+KilOSGzyJpBGXyIN0xCDVem5sioG12dTQmAA9P5c2rpVcEUejrWLhff3+atRbFoJO7osM4oTaT3Ns9NhQYFuLOdw5wz+G4OdOBTYmU0ulVgNobm2ccMeaBFBNQzZ7V9JueC6+de+nkCgDscWQSJXtkf8X4mowkoCdYrcQ4uC21LliC13Kj3Z67IBaqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD30rdJPiiZK7dnYQcoEX1CiruFiCjHqrbu+rJOkFGk=;
 b=Q40WsKKejdTvPzos0MPIXR23WjhfeSnP1bSulm4vK9taqobrslPxehueLNvBGg+eiuVJN0KXbmhTIe1KDnKW4oorxzKGmnO2Z5e2CEjDwiQJaOviVVugtHFC+uKqvm9KbImm37QOVv9Z+3YJ9beilNU8v9gn3IsZFrp98Dsz5t9tkJ21uPkaHbL7YEsQvc4NnvZX0ry/tnEg8oYiQABh50+pAriEIu+hL2AcUCgYVD4nsCD4elg0dl5N7poXbgTPstrb9UJTBFhSI+V/cjwyc21pyte9c5mOR+DQ7wwccOf5A6bFPuwBV7l8l4ts4ykHK2K3FqL+q0LGZeX150UN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD30rdJPiiZK7dnYQcoEX1CiruFiCjHqrbu+rJOkFGk=;
 b=v1e9xHalTMsP0l1jR/rli2OCT7/X+0kBoG0FJ7CTsLY3XSM0qd2po9iPMxgn1viBiMhqnz8s36fOMQfVEZ7KOo0Dmn5R0tKIh3YmewzuiAz4GO3ibXF9IyGbDyqkxC5UBjseyvqzi+lwAA806iFYKcxX93bBrKe1ehn0K+lbHr0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7279.namprd10.prod.outlook.com (2603:10b6:8:e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 22 Feb
 2024 09:01:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 09:01:09 +0000
From: John Garry <john.g.garry@oracle.com>
To: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        masahiroy@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 3/3] staging: octeon: Don't bother filling in ethtool driver version
Date: Thu, 22 Feb 2024 09:00:42 +0000
Message-Id: <20240222090042.12609-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240222090042.12609-1-john.g.garry@oracle.com>
References: <20240222090042.12609-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:180::44) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 331016e0-db6c-4ef2-3870-08dc3384cfa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mRbaxhAWwPY+aPBxrjMhFm/F7v4f5MvcxvvI6JEsHT4Kb3FhC5H5JOWhcc92IlTzd/xuol14+3/mK2te2e6lcYZkM71ckhCKDP1F9DkYXrLn0NoWQZw2DBeh0443FOZZsVXbwxPhMbUi+df4io/jzqw7dfLpJLn6P4i2MlIJnW/7q5BmRuUgiZS/CsPZUmw7l/wAN9orRHEgWT93FUlN2cJacz8r8gLQ1qjKJ88CAsdUOAR0uAKW2BNOyhRQ5+Zugb0QuNRNBlT8Kb1iBvC9dRCAB07jAWIbwung3A5cKTPRJtuPD4yjbA8DJUhQqbPWOz3QDtRXe8miL8zXmwriBTvHKDxmjck2D1sra4+nLn5YiU7AY14WUuqsoc0FjNEfxvkQQ1l/LmfJxkGps7cqX51DvRbRljfIzCVL0/P+ZoMB4NbRr30mnLoWo7wBv8dYzmU9K8dgHUq2wAcAUTz73O8KTyGLJscb2ZS/Nrvn8lgWCciIoGGIvdwNyDJj8AlT20xUVQsDITpWblXFyvxjFpikw0fkSYwr+KBDn0sceec=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zLAZ6eZTeP/aLjBf8JpjGrbofsqZ0dC4ibHqsBPHMkXV+d5kFObXV8C4saqD?=
 =?us-ascii?Q?YFLov4UJnT4DoqBk7XVPk/I6m+gR8oGwUY0JlAPsrOofkbdSl7h7VMjb8N5s?=
 =?us-ascii?Q?1lGoppkfTG411m9d1jeeTd9BF/KvQmWLsB8jnlDnMtOdKZTiy8ggFtZODYQp?=
 =?us-ascii?Q?AO1e+KXRuaXWLaBsyo+4ted6jzb7c5ymtGUQd6IdBzNjxQrocKoP63SoIY1h?=
 =?us-ascii?Q?6VoZG/K2uFbn0Y7keLV4qJ/x+xT14P+Q6DvIRZmJO+yfFJ+eidiMFJl1+Nn5?=
 =?us-ascii?Q?59nVLRhJ1/A5gBufKnYLmVSJUYJkeFzIrTjCNuLHMCzNc6kfZL3PO7s+lxte?=
 =?us-ascii?Q?GhVd9B1AFJUEwsMKJzihcqHMvlePB4cf3bvAWLKAPtAy6S4xtSofBAZssOVv?=
 =?us-ascii?Q?iq8zKljmT6Jv38JhOYW0IUdByOjsQRH6gUX+InzqEYywNOVNTHM8S1DcIEvm?=
 =?us-ascii?Q?xy6mFt3RlcAHE/LKr1WG5siBEf/EfQXKJBp8u3dqXvPrQYLI2dXxBXUiXj7v?=
 =?us-ascii?Q?htLb2VgWtyzwjxrvktDRYUzXqH9+M8Q3q7XGI7G1yZr3d2nb7RfdQ6LNWRx1?=
 =?us-ascii?Q?d/Amv5QxPv8iLkO9IUgEDuYcwwlwZRfQNtV1+ms2iwPQhyYAMaQXuWhMCInT?=
 =?us-ascii?Q?XMou20bYLizxx5lFIA5s7tv3srsHtgmnmcqIblbqw4krI6hrezDQSRer2dCq?=
 =?us-ascii?Q?N7jMI+ZSPXcPmVflP67O1vk9utA9PpoMIMlUXlDtGu5QvuFasuMd0zQSjBfN?=
 =?us-ascii?Q?g9y9ARpUu4k2nmf2yoUSLpjQ2S+Pi01IQMnnMvO7UarcrK1INaIztpVHvpgP?=
 =?us-ascii?Q?Q0+n4ohvJj3O+hfBk5Tn5l/vUYJLzN63XzQENM8GW629vXk3ldJfStoV3l2Y?=
 =?us-ascii?Q?vxGXTUV2OmsoIuV8awpniLQnU8H2rgsMo4bhEO8Yzsg++6Lttu2BuYlmVXPG?=
 =?us-ascii?Q?ix8fAdEZg4X249iEVrbfjDFFibUIZfE2sI7huxySpp9BZuNfnsdlc1mx358V?=
 =?us-ascii?Q?y1dtWRDn04EXWDGCr5QKoiAgIVfESaGpo4BJYiplNU/aAPK7zRXyIPQmdcDk?=
 =?us-ascii?Q?C8ruihr+pES+htyte4SbUSYswH9Ps8hQjYhoZxNFLaz3bkdojlVpD+2mslzO?=
 =?us-ascii?Q?bAQEtHXfD7KPYOPMB56VhIS6dGWyhIlkckeMIPjURyfYmjFz6Lvk7/BuNlE6?=
 =?us-ascii?Q?ry4R1l2zQPEwRcrLg/xFkkA30VVbN1Rr4Vo3HvFuspURmheOGtyyKyHx8Jda?=
 =?us-ascii?Q?fTmWny7xV7lq7wvZMflsn0jRo4vUVRAva8kBV4AUABM4x6eqD6KsrOXiXJjo?=
 =?us-ascii?Q?mjEnSp/JWp8Q1sOGcxIl/Lp1Kt2xuN889PiZzLWrCup2zsn+gXLpOQOiWe46?=
 =?us-ascii?Q?6f8cn2VqenN4+yayk1Z+PTsrtcAyXWgCZ0CC/Repkzby8tW/aqGS2HR23uE8?=
 =?us-ascii?Q?MIbbtSqit2Kz0OiI03TFEYjiX0l5Dno9Xhkfkk3YDBV7qOFs6qSXEGjUSExi?=
 =?us-ascii?Q?aGeA7IQhq9TYunsticOU9IwHaQ7g9zWYKUPQfU9YGTwI21/3go8r3PoT3HoS?=
 =?us-ascii?Q?ik6dcLek5hcoLeSBWqPK/sSThbhyMIu41k3JmhYCTx0rbLqot+uOLbTkeCef?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	p2mSaDGBkSF+udrNJ1Fjd5bNADt4fMtnk2WroTYL/minj7Oe+21hNQ2AjMWR0DjevHOJJ+JjO1ldLr5pQVik5279DcRhz4M9I9a422Kar+I0Av+kXtlVXPjsW0pnT2JC++Vm1p0i+eR+YoHiaajzn7EAeuv7oQudR9MJwL90o5KOa/azrHW1NOz28XfgSuoEbWUrFh3M8QKU+j8y19+PTDcbzFYAcmg6pTljLP8PW3x4HN4e8TLe8KAgnGG5jIdOA6uS+3fV8zgt4vnsTYwqn8WG2Cia9LiCJIBanWu7qSEAWA+jNN7M2CWKHvIrTZIB6T9FVC8mb7sRqqewDCTnLUFwuMYI4HVhnn5YSrccQ2FGcT1SRkyFZy9TZvrTbyKsnpYljlucMY0100hfZWIGMsQXxYZsbI1Ai0m9HD6z6+0H8W/5amtvDIyJawj81FgN5hjHkP20yXR6Nm6LyZKm/xHjbiQVQ8xArDKEq2u6x524qg6gvk1umh3R7i9PkCuJS4t/OaZrOXOd+P5kpVcL1TCwG30N+urKJca4cpDZBvuYS+wDfZJh+jdr/oiETQh8/D5OeQ1EYg5DahD/BfOmFNbzuxNUhBrbo0J5k6aAsMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331016e0-db6c-4ef2-3870-08dc3384cfa4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 09:01:09.2879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCqXbNEewWK871I8/JmM27m7Sudb4PaaV5RTckeM/q45jtVZHe6PmqYxS+Ek2DpgUdFIf8M8q25arotx8G4fIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_06,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220071
X-Proofpoint-GUID: Fk5CTugf1i1I8LcocfNwQVJp3ycP4wa3
X-Proofpoint-ORIG-GUID: Fk5CTugf1i1I8LcocfNwQVJp3ycP4wa3

The version is same as the default, so don't bother filling it in.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/staging/octeon/ethernet-mdio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
index b3049108edc4..211423059e30 100644
--- a/drivers/staging/octeon/ethernet-mdio.c
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -10,7 +10,6 @@
 #include <linux/phy.h>
 #include <linux/ratelimit.h>
 #include <linux/of_mdio.h>
-#include <generated/utsrelease.h>
 #include <net/dst.h>
 
 #include "octeon-ethernet.h"
@@ -22,7 +21,6 @@ static void cvm_oct_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
 {
 	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
-	strscpy(info->version, UTS_RELEASE, sizeof(info->version));
 	strscpy(info->bus_info, "Builtin", sizeof(info->bus_info));
 }
 
-- 
2.31.1


