Return-Path: <netdev+bounces-136422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A85BC9A1B45
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9531C216DC
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB76D1C2309;
	Thu, 17 Oct 2024 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="BaCs97nO"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7DE16BE0D
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148705; cv=fail; b=Xv6ffHMZEubgDqa1eHN/bwBzlLELKI4KvGZMfEqTJJVSPEncpegmu97j4zMKgZyPg0mecNCF5IAgkDQb7AnckdGkphLm9KjDRTo9N9dmmYznrbCH0xlZfdqVVfehOLhIFja2vXo8B1teWh6BKzro6lyrLYlxW39NgQWXKlIZFbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148705; c=relaxed/simple;
	bh=sSYg5o9VZ2/hjLM+aTRJ5u1BXsfnpO8WjD4giqqScTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pieNxNQkwxSAnidb5w83WLU8MR/pwhetdFsQVWnKla+UStsf5B+7Onw9lCx5qqMooMhckoN+QkgWIB2TXjL0aGJ+e52In3VCcN9y7N6YQUBsSP+klzqWwxd8wngWdu0uncuwsCcvXxchkofBvMoWs7m5pKJeV21xK2bJIoPUL1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=BaCs97nO; arc=fail smtp.client-ip=185.132.181.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 63DB86C006C;
	Thu, 17 Oct 2024 07:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQKlgm9mgpC8zgW3eV/vdtigWGDoFJaTPeh9nnVG3j3Lb3enjW7F3HrJplRZYJYrzfEdgSa/kC51SsozBq8hMA3EAWsKJtJPdY7ykEQ1nYbz1qH6v4Arw3u83v/UTe5dfQal0kFnzq/kgNShUSCGms6b3LPM20emk1YtyNJaCx9HsS0wdxEsRsULpYzf3pzQq1xv77sccRAU4h3Wdk/9VArx65gpQGk1ZK6Gg0yyuzudW7OhYtYCvieuOynpCpj1Ckx/1eJ87TCE69Z5YP09qaynpxyAOEqcBFKaICEIwxQl4xs9sRKa/G/2q0W8MnmBd3i0pDY2BluYK6ZkIuQJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEuhQli1Jx/cU4u2rkX0ZCwGoxvZXDbLreniCkxzGXs=;
 b=hGJ1CY9TQAr5j4POB8P6vgXKfaKAjrAYRegBXVD2eaOhN51ht/WiqlCzLmRrF6RWfpAxhJcpnd6PiE4fQleThIBEhnWbGqmkJH+vG4YcrKWAfyexTwTg6h7q/6kWOMNO8M9YeyEoqfd6bfoNN1mUsY7UT9ABr+O6ysMN/TN36+QPR5iWLMFjkQrhaG56gsTQnqBOM4WUrmGlnq/PWk0Xl3+hhiX8ZcHpN8xXbQ/BK2SDO/YvtAu3fxzvFVyJXARC1ys72yMEhE6mTqk1XJf+ULlzeUUeMgh1ytiB9FnREqH+0qbiHreUPH6bzPE3xp86LTYFpGKPgL8Nl1jKq6ZvJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEuhQli1Jx/cU4u2rkX0ZCwGoxvZXDbLreniCkxzGXs=;
 b=BaCs97nO1S4arha8856MXwgmxa4LNlUWj8JNRlRU6ZrPJrZvy2Gfq9UBSBlOqVZWPY6CaO5GaPWBQnY/yyNpAJ3M5ws3hQ/QiVP3ptf3cXiqTQHsLfK5Nmy41epsjwmPlqE8uth+Oj6O2I/KHFxrXhvlt7WyY7Czkdqpw7lwRJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM0PR08MB5363.eurprd08.prod.outlook.com (2603:10a6:208:188::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 07:04:58 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 07:04:58 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Subject: [PATCH net-next v5 2/6] Define neigh_for_each
Date: Thu, 17 Oct 2024 07:04:37 +0000
Message-ID: <20241017070445.4013745-3-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017070445.4013745-1-gnaaman@drivenets.com>
References: <20241017070445.4013745-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::29) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM0PR08MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: 1601adc2-3555-49bf-4187-08dcee7a02ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ytCHiGbonooDacC7ORKuTMxw60sUi2m/hwaVDp7BSIzClUUWUJJh95DYrwNj?=
 =?us-ascii?Q?I04+ObpwWd/PsUFqoJVEzbPFeC+iurb3gDTqjAEyhIfAyV0rJ/7lwr/4yHeh?=
 =?us-ascii?Q?zVs/6OXd4wyHoUxGJXOTc0cASD6OwEwC60huir8K693LRq6IF2BG1f6HKWx7?=
 =?us-ascii?Q?PYzCfwBbFPOh7Ezb7HQtIOlp1qvWBuprhPbI0Tc6L4by99H4QFW2BivBep7C?=
 =?us-ascii?Q?qaJKYyL8Jml9huyesj2vQ8nNNFY5ahEN1qMJRq/aL2k9xxPZYBgR18FNAxFQ?=
 =?us-ascii?Q?BRlK5hRlkkRVCrTqJYUuc2B1MrCa2lal+liWekZQXWvwjn1nAbPO8vANd3mb?=
 =?us-ascii?Q?UaQjeKSrQ1h7pSewiOu+HpDpnvtgLuxWzs75SHeCi1scdQ3gyjvZ5A3+YL5x?=
 =?us-ascii?Q?qTReKsDRW77sj/za9QURp+H0eoC9+6gxvqXfrl5zAPlkW52EJUmg0SKSeVov?=
 =?us-ascii?Q?HOtYAuwxT5zr26F38vMo6XGbelgQw+PwAhnlk61Zji/46qEWjsxEcBbvw9ZJ?=
 =?us-ascii?Q?wtmR3NksfXz1eR19OVwpAvytLMCiAIBmb51Hx+HxK386P/u3N2n55NBd2VkJ?=
 =?us-ascii?Q?RcgvetPDLLH8DWfcx28JuAy4m8n398JvsrS8tKR5wtzUQq0CJosL7iLhw3m0?=
 =?us-ascii?Q?Y41bGPeur/XhP5T54egcHypeIdId3Zqsqw9dta7EqP2N8y6SPAppXLLE9tlq?=
 =?us-ascii?Q?1xgyLLULQ0HX2TmYGc0gDSASoTheYVzzHoT/B9HsRrmwH/zEyYo9woij55bl?=
 =?us-ascii?Q?PuN8phcFhuPxXoh8iw/k8+dRLlbBY4fC4cbQL8fT9z6KPJTnaL+oVm+nDvOT?=
 =?us-ascii?Q?S3imuae6OIx+2yJVDfCRIZY9tHjC7hmMLgof0jn09n7FgwE3Lp/Pps0wVt4e?=
 =?us-ascii?Q?dJMd73j38PBISE+SMATa+OlfC40H33QE+5yH81QoI3zeiCJrkJ3eX6pmSI5V?=
 =?us-ascii?Q?rFjfdfDC/+7CSJDDHMrs+trX05f9MlVZHF8B/PT2o6LEQF+wWLCiUHeijDPe?=
 =?us-ascii?Q?Jg4NSX6oxtAft6uZu1l1AyEIKfksYcxi8ExbJYyPxV1unClUe2DQ9eKIGVwp?=
 =?us-ascii?Q?Br3XCwiEleP0xJhlc12+24lDlkQnHV4pAUyYzapDxdncIMsRJR0LD4f8FJSM?=
 =?us-ascii?Q?EXDtXd9kHYmqM81mZuCrvdJR2ttj8Bh3dWFbVDez2XcokM+cCeG6RMVR0Ph/?=
 =?us-ascii?Q?SYEOsuR9EYgWyzrXXpOPED1cw9kG/iS/Ad9In+5crsmDP5trax49cPCCgd46?=
 =?us-ascii?Q?8ZkV/ftBaermOVih20IuBpr/6+Yi06sgBkjt+fDBkQ8ase7StrffDiEaq3Ue?=
 =?us-ascii?Q?0Rkx7UA9qYc5W60qc9bqx325zYvJ0U6k346MGzpVQ2wQvbF1xP5NuTheavlP?=
 =?us-ascii?Q?ySgtKdg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hNHDpm4BcfcG6degMCvUnLJzVKc4cUEE8Pg+OBhKosh3eqbYZhRNwVbagx9r?=
 =?us-ascii?Q?o34oyFV+q/eHnHKKKEv/Sum+kyvLLJMeSeJpjOJKuvMr1bo8kMj3ZvR1bo86?=
 =?us-ascii?Q?eM5t1er8BwgRzYwylTftxgMaRbtLJz7ieXEZFkOhK0N38mMvpgcJM3qh+jGW?=
 =?us-ascii?Q?wv1CSMM3VTg5cc3SdSoV+6qSe18yBSbKH5ugLE526p6h8hxH+gzd3sWjYEiC?=
 =?us-ascii?Q?9pN7bEjK4J+ERAvhQI+qxYH68BzmGRV7Lvi9pLjpAtENc6mtqri+JXTncPcC?=
 =?us-ascii?Q?vzAAXb+b5uNweYW7SfB3eUGexrMTFjLFts4sYNQaKHFMohYnjKrBHXxE0IZS?=
 =?us-ascii?Q?0BuXQ6SPC7+YD3uFrOzexWNtfVH9hvdJiKLLYsIPHSMNGIMQK1ZpjmydfpUz?=
 =?us-ascii?Q?XsFFfgVI/7kFUHRoVISZIojwyzZ12EotBMZ3odhVTuBFZ+hzsy/+84aMi2R2?=
 =?us-ascii?Q?2vQnCeJ1tPSpKDvqKFSyvW16AcxOl0unzeUtg6ZPK9XXMCoGN4kp4mDMxV0H?=
 =?us-ascii?Q?yHbTry+W60jhNJgaaLdYlVBPnUGUXWbbQ91JZLn2PJBPGpPHRihejFAFqZa2?=
 =?us-ascii?Q?HPDNmqyugeTxwR1Hrer8KP8UH8VnO0ux4hBoCspqhlVEpQdLvBnZQL17Seg5?=
 =?us-ascii?Q?Ys5mOD+fRY7PbIrngJFHK4vaD71jL0ouxNcfuzS4xKKd8VgejbICgDKQZcxB?=
 =?us-ascii?Q?vGgNKFxDjRfoRAGONJiUKbGvQEMTw43PbG0AyevFfcGzRo8fvUtB30aZ6ExT?=
 =?us-ascii?Q?m/jSameN2O999j1oaTOYuM/JKq7aPxDjU9kax7EcP6+qviThpc/ioZSs+38c?=
 =?us-ascii?Q?RJ7nriboGFlhh94nX2GLr6sshR5c/qe+FsthR5GxMhTj6RLV84BjwaEXGtaz?=
 =?us-ascii?Q?HPz9jneOuANTep1pIp20Ls5zQpAAgbikdohmxHR+SCT0241xyAR1OqXtJTQe?=
 =?us-ascii?Q?TrT/jeTYo0pktXkp+u4J0BwC4FAngGcVKGUwruO7Yz38UAoqC59Cmn9OZaKJ?=
 =?us-ascii?Q?sr3MhZNPjpsIr2rEDFNUdAJtGOJPtF502XKXU8BvsVDZWCjUCQ53hGV53ILY?=
 =?us-ascii?Q?HOJpmItf7fmPkoY07A5hmmVvBRr1lnUC2HZK1+ZWLabnaMSSS2y9Z6HRDmrX?=
 =?us-ascii?Q?HYiMkg+A7WaGxA4Ume0RJSrqNXKkCciULRpmFG1HGoULp+Tg5MiJWlxLOw6n?=
 =?us-ascii?Q?DNTpNQNOJu+Tib4XDt7oNBgC0HR6DpC3vxTs9SRcCx5Cg0PLCj/Q0wTcUFxt?=
 =?us-ascii?Q?r0dw+9bvMxKfms6OHCtKfnH91XIp652faXsglUqru+7zEJbkVhUFjYyec3n8?=
 =?us-ascii?Q?ShkIeR+CXbkLXEYO4/0LYOHWXxVF59fqUuQ5HT4A0V4ycrsUXWfbQPcBOC0Y?=
 =?us-ascii?Q?7OXypgBLJptQnhUZLGUFWZgot7R7mpmdxS6apsrQko80T+iAEgfrFsw8mrRd?=
 =?us-ascii?Q?aEZR65uTf79quo+ozuIpdZptmlvQx8BQKUvt+whpEJxq3JU+s1cGifeETQJa?=
 =?us-ascii?Q?ube2tFzWIAP5hr7oR9G+Pm75z78kvP5yhXyUrNaHK6jytU1XINRwtGp+khvk?=
 =?us-ascii?Q?xtnx8gg8GUGCsk1gmal33O4esWNa+3hdNT7IgTvo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WrLNpI4vS31MCtH8sXhs6C8y5kQjYRs+V8SR8Umu4i9ASTe42MVZOLcWyxMTlobf1EdUtaJcx286QbDHwJkIJCpyk2ooNPr1+/7miUYamMyXRdpBVWn6K691T2ZdHyBSTH7jijEnpDd1Zbn0qOnLe3hZ2AAcKEdjceiWE2Uly2dCmtmjsx1s90bBApgVBuPmMiUaBZ4tdUzkhP5Lkp1UNXFNQYmG9gpfhJfBw7f2GPS5fWb80+zenUAq3wH7FnaxrwuQDR04k/6koMUl49N3ZC0j1E9z599chjROJxeKXcUWUkBTYZo4xJaJqqkgA2LWLHYyZ1UqIOnV4wsDq9Y21GBWmriyBeZo7axGxDW/B+tEFyX3p4ll/AGv7+QpMxbSNFAopVDNAT5RU68zyk5VzNgM8e4awex52noDLvHpUa7waDEnQpP1ff797FkkiygNWmanMz2xTbh7L3DdwVeNXqMpyDRytGfQyWVFHU26oaPQ4vhoIhISvy8BDo6JdYJLF/YNcYSf7OT1HBVsD3icyUkfzEHa5bQMfU7NByOKlnO1tN8v0onyNSK9+kp75KohAPhqxCqyz2lHNjXnwryP1zSgkqkt3mUuRKHmjBgJesqojXdoOnpnIa7P3p3uCfFv
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1601adc2-3555-49bf-4187-08dcee7a02ed
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:04:58.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrrMQ6AYkcpJlgVqf7lq1j2Oohdmje++RjR++/H3lFU3DY2UAP5DvwlqzBtJSVRhRK4v8VRbvSUP7iqy018GNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5363
X-MDID: 1729148700-HDMhOCGWz_Gt
X-MDID-O:
 eu1;fra;1729148700;HDMhOCGWz_Gt;<gnaaman@drivenets.com>;3e2ef0aab6a0ad8a3f1c1b41b7049f4c
X-PPE-TRUSTED: V=1;DIR=OUT;

Define neigh_for_each in neighbour.h and move old definition
to its only point of usage within the mlxsw driver.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 24 +++++++++++++++++--
 include/net/neighbour.h                       |  4 ++--
 net/core/neighbour.c                          | 22 -----------------
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 800dfb64ec83..de62587c5a63 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3006,6 +3006,26 @@ static void mlxsw_sp_neigh_rif_made_sync_each(struct neighbour *n, void *data)
 		rms->err = -ENOMEM;
 }
 
+static void mlxsw_sp_neigh_for_each(struct neigh_table *tbl,
+				    void *cookie)
+{
+	struct neigh_hash_table *nht;
+	int chain;
+
+	rcu_read_lock();
+	nht = rcu_dereference(tbl->nht);
+
+	read_lock_bh(&tbl->lock); /* avoid resizes */
+	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
+		struct neighbour *n;
+
+		neigh_for_each(n, &nht->hash_heads[chain])
+			mlxsw_sp_neigh_rif_made_sync_each(n, cookie);
+	}
+	read_unlock_bh(&tbl->lock);
+	rcu_read_unlock();
+}
+
 static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
 					struct mlxsw_sp_rif *rif)
 {
@@ -3014,12 +3034,12 @@ static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
 		.rif = rif,
 	};
 
-	neigh_for_each(&arp_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
+	mlxsw_sp_neigh_for_each(&arp_tbl, &rms);
 	if (rms.err)
 		goto err_arp;
 
 #if IS_ENABLED(CONFIG_IPV6)
-	neigh_for_each(&nd_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
+	mlxsw_sp_neigh_for_each(&nd_tbl, &rms);
 #endif
 	if (rms.err)
 		goto err_nd;
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 0402447854c7..37303656ab65 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -277,6 +277,8 @@ static inline void *neighbour_priv(const struct neighbour *n)
 
 extern const struct nla_policy nda_policy[];
 
+#define neigh_for_each(pos, head) hlist_for_each_entry(pos, head, hash)
+
 static inline bool neigh_key_eq32(const struct neighbour *n, const void *pkey)
 {
 	return *(const u32 *)n->primary_key == *(const u32 *)pkey;
@@ -390,8 +392,6 @@ static inline struct net *pneigh_net(const struct pneigh_entry *pneigh)
 }
 
 void neigh_app_ns(struct neighbour *n);
-void neigh_for_each(struct neigh_table *tbl,
-		    void (*cb)(struct neighbour *, void *), void *cookie);
 void __neigh_for_each_release(struct neigh_table *tbl,
 			      int (*cb)(struct neighbour *));
 int neigh_xmit(int fam, struct net_device *, const void *, struct sk_buff *);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 45c8df801dfb..d9c458e6f627 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3120,28 +3120,6 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void *), void *cookie)
-{
-	int chain;
-	struct neigh_hash_table *nht;
-
-	rcu_read_lock();
-	nht = rcu_dereference(tbl->nht);
-
-	read_lock_bh(&tbl->lock); /* avoid resizes */
-	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
-		struct neighbour *n;
-
-		for (n = rcu_dereference(nht->hash_buckets[chain]);
-		     n != NULL;
-		     n = rcu_dereference(n->next))
-			cb(n, cookie);
-	}
-	read_unlock_bh(&tbl->lock);
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL(neigh_for_each);
-
 /* The tbl->lock must be held as a writer and BH disabled. */
 void __neigh_for_each_release(struct neigh_table *tbl,
 			      int (*cb)(struct neighbour *))
-- 
2.46.0


