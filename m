Return-Path: <netdev+bounces-142894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 186DE9C0ACC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2C0B2330D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A761215F58;
	Thu,  7 Nov 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="nKB1qf2v"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8C215F75
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995518; cv=fail; b=jRQ76vESuWmthDF26B2LL3uEsWlOteMED23dHot5af5fOabeeMSCnrE4NjXtsWZHfSuszKN7ZrFolcstwkzAeK88DtfCsjsgzXYDpwTX6q2yZusKQvWCQM6LIBhFMsnRAMzdD5oenTlgkEMQz0ZJJf4JVux6RBV2O/74Z5P5DHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995518; c=relaxed/simple;
	bh=M4YJlLQ6s4afoIkJFodK+n+5JONI3jyyzq7xXMostLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i+/i8j6q3vrXv48kacK2pzmDusYm1kXULAvQAaHmKeg86lpaHBNum+nhEAMs/SPXDTYDuasL6Hf38yRQLQYPKDNdBtiq9DkAGO+IWRFxT+rAOtdPTeMmmUNO4udk1/yZSHT2L8Hh+87prUPgYdz8M80vTeRGE3NAAuDmr72sX9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=nKB1qf2v; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id DA7D6340063;
	Thu,  7 Nov 2024 16:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5ZKNLE3bHYEaFywsnt12chJg+xIxEJiLVjdqxZnmKtP3tISba+zu5d0Qc7uRqkkMQfh+J4tdmh2vjrSzmCh2JKT9lDMW+sNdZCejMcjLJ7ErkIOITzcyxepFbUoD/7D6e+JuuSZxsQGE1GkfQxEnTaIWd1beNFJL9Pv9FlkjF+7iVn+7PzZK3pohWocDH1BMkLdRWmPY3ZluCS/HBBBbVXsfPEg2/4M3pn/Wpht3m6CBXLEcos9+Ojx00gvUOu/m9sy8eLsbUw+HTU9tkQQLzXlAn1/AcqIYqgoovPOkqY/6KMaN6JCKmGIt5aEDpIj9YfS//Tk1cCFRGDjEpANrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEx5IR1Qry9GTB/i3m8Ac+3lw1zAtE/1MPQW2Wj8ACc=;
 b=AHkHaEQFSvH2a4bpbmwSN2/mtVC0HKKgF3eNGJOsjrp3z4wlND+NdZEoQ8gRhzbMCD7lymxtXnDu0O4WUDiBVNtSqdDbk1zKJ2y5rMfxo9qfovpQHAERCqN4FF2Vn/hODHJd437S8jGRkHL/8FJ9XydnOl4KZ1cpx8GGYug+u59Fzd2hR9d9a1YDCrjluD4veDe6RQNimvtyaTmeAlQYl1hfxMsjVY8SnvbBVVpAS2XvcmIT7vDYRAYkXtUygaEEEv54V95AJCG/J/v800F+TdDOC0LadKf1NgDtSICQSc3TJDU9dq68LgwskxJaTemL/+pQw7+ulEv4Yfr2G98X5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEx5IR1Qry9GTB/i3m8Ac+3lw1zAtE/1MPQW2Wj8ACc=;
 b=nKB1qf2vh3Fe0RXTl/96J4bBpI+rlNJsTD+IJczJ0AxjzytLuIpZM8PkoUa0+ulN/6JKRYKjxDLkInfy8Zk389dnxPmFk9tUDrZhYBFfcq82lKqfW4wisY2NH7HXcKUkPzgXj/tgnQ6edi2ej+dLwawy51anlYAG1qU/rG5/eB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS2PR08MB9296.eurprd08.prod.outlook.com (2603:10a6:20b:598::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 16:05:06 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:05:06 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v9 3/6] neighbour: Convert seq_file functions to use hlist
Date: Thu,  7 Nov 2024 16:04:40 +0000
Message-Id: <20241107160444.2913124-4-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107160444.2913124-1-gnaaman@drivenets.com>
References: <20241107160444.2913124-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::13) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS2PR08MB9296:EE_
X-MS-Office365-Filtering-Correlation-Id: fb154ee9-88c5-4086-8ce0-08dcff45f20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/tH6fsq7ktwOnIqdILnAPiIlh8ruo4H27Wt3CYbdBd64JZC5/RKfcw9ptyUF?=
 =?us-ascii?Q?4gG0PTF3a1fRowEyjaq4X/4vSJUq2Rmx/Ey+ngUUOaIS+WtvFbodrQizE04h?=
 =?us-ascii?Q?M37NmUQFeHTrfvFLcIbXpNQ4+QgKlzC9FNoxwsshKH1QVAz4AXlof00W0Yi4?=
 =?us-ascii?Q?nkqNIa5OHeVCDW71ZnHsaYaEYC6My9LM/Jm4Yk3giGuPSmjipTl6s5XrPO6y?=
 =?us-ascii?Q?HnoDKZQ3PBw9MyPONA7+51XnmF+ZwDmluceczfYOEqTk0Yfs6+iNyuZ2zJ6R?=
 =?us-ascii?Q?6t6vI8kB5+04h9zn0MjOREaSeAGAPNMbsgFlFE3BcGt0MZcdSx3ndpycbsJ4?=
 =?us-ascii?Q?4qXf4kqsZp4D15LWv1PFHpNnWm+Q9ROuY3cFD4DbTzGIzpW1O8cLfxnyY/lu?=
 =?us-ascii?Q?KFW/QScRcSdqTY+RrdedPEVGpkMiUr6mr/x2YiBzSpgNySd+35cOczGSAB1s?=
 =?us-ascii?Q?xVqcRHUTtJhxw1ODukhDBztLaC0IlA0uZGXbzOG2u1/dxkXEbxmVFf2/nKSp?=
 =?us-ascii?Q?XGcIrIYP8C7vPlJSBotFgbTpyMdrmOPdYplrGk8olJsFqyD0NxxqPQO+8wsm?=
 =?us-ascii?Q?fpVDcW0obtNFeM78fPs//4krJmrYzd/9oyXl7OttoukukTR2W0iy+ng9cnXc?=
 =?us-ascii?Q?ckPC8a1F2a6WgA7NnXJ+Eg2GS6EWvZ6rJWnZZcNzatLruFnMdrDNBCeQ2GGv?=
 =?us-ascii?Q?Qq8ArNljEHGkviG6yUVywrKz+aA2Lg378VEFKwlpxPfCAvqyti97LERJHivd?=
 =?us-ascii?Q?uvZh1JKdquFqsNYUfSjufKACm4Ki78yGVgFfHsKw7EHfiukCue+uSkTUHSSY?=
 =?us-ascii?Q?sz7T1aLYUEWqvG9zM/v8hXiXB6Asf/6BAqlsaRje6rOSC1t/fBL0Cxb/39fb?=
 =?us-ascii?Q?+RYrJQ2vdQbc7ZkSF0NY+u3pnotoxnt+/yvgXpCd/HXbgJNHGSSaYQqcsZHh?=
 =?us-ascii?Q?3HmFNSz79zY3Pritw02cgCjssM7cBlcwB+BWTupFCz8TdGvpaNXICCMxP6D6?=
 =?us-ascii?Q?Lte5zE1GgASuOl6SOtTngrMplN5KmzLW8C3xGKOMTDFYqxc4Yn4cpUjxkTCB?=
 =?us-ascii?Q?SvpTtEXHijBFXtQw+rVGfnu25TJTC02AJN006PuLCwwVGFMRHn3bt2s4LZwp?=
 =?us-ascii?Q?wdLsTDCCfSK9DAOlHaFTnNlUWinWRJc1JFVpC3TIdlR5VvY0nqqMS3+CNJ+G?=
 =?us-ascii?Q?1k23ikaRlGS3RR5fa0eO7+ZVXnjFPBnBmGfBvJTLjjW7tBxe0z+w7t2qsSDj?=
 =?us-ascii?Q?q73zfOdtRiUGmvTqUcw3YBW3uoZaRJVnNCnFpjM9YhQ8B2Vmm3WBgKTmB0Ug?=
 =?us-ascii?Q?uqL0+YOb2J9vsXo2gptx6JZ2A8Ai/qCoGSgmDXECh2n3u4HuwfaUh5qSZdSa?=
 =?us-ascii?Q?3sphMrs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S3yqMVb5VFgzI4NgAD9p1tlpPDzl1auWgXqjsLu0qeALOsZf5DJV4dsXSXhV?=
 =?us-ascii?Q?zyJgOX+qyjpfW2pCZw5fkA+Nuu5FrVAdYPosF+htfFpojbKwQbBMBwbLjiWV?=
 =?us-ascii?Q?akz4O0+l7l2PYpNJSRixZEbI08o3I85ZD4Y9SOL5TrO4IrCfQRPn5piruIlP?=
 =?us-ascii?Q?F2BFKvZ9TbeSNUy2GeeNd8RqLeOM0FoUgr4vbRqUVNkMFGwt7b5QkKyTDD6Y?=
 =?us-ascii?Q?JmfNThfsmlobBH3S0ECaCNJQcDPWJ41FVFxdKwkkbdyM48cT9Liwn8IAoMnY?=
 =?us-ascii?Q?QR45oDN+/sqTdaFqkHduF3kAxE8365nc4POsOcLbhyQXQkj5Gs9EkG9ADKnh?=
 =?us-ascii?Q?g6FjUQnnTZcYuKjgMNzVXk45Vek9fcZjmuMweEz3mSUSI1CyIjQU7v6ceFvf?=
 =?us-ascii?Q?Ra7uNZk/AVpzoPJFqOPW3uZ2IoM57csFC7OgD1sKaROb/gZyHUEsh+IL6PiH?=
 =?us-ascii?Q?KF9nJ9cdae0rKXkQByNkafhV902uFct7LtloqshrqDSq9Dzt0yNk4m9K/5fZ?=
 =?us-ascii?Q?CprkUaVCC4ePD/lBHmjzOnBFxJHTdEKPycEqRmOVbKidXoed2EbejXDyidU8?=
 =?us-ascii?Q?vIa77wFnIAywRi/WvDHFBo8TRpgdDDoeKXmwwwI+0JcAzxAIv+dDurTAeblx?=
 =?us-ascii?Q?lidplo3sF2HnDsQzOaPU0tF6jryZV0mqEz8OeXuArErqZnRPaxsGueGMOBP5?=
 =?us-ascii?Q?dbVc9hFtm4CnoETA7ZN1Jymq+oeAdltV81HfnGoeKnFvpMKYMDL0zWocjlNG?=
 =?us-ascii?Q?8U+fia2Cs7emO+ZyOM9hleTh0D0Kk8l/n7lZFaGjBPfgOSkE90oJSgRFfnEb?=
 =?us-ascii?Q?6bzlwQJGUg7XWD/r+k8mF8yKV4jYGC9hFhgLUYunqRYIb/298wG7sC31sW+H?=
 =?us-ascii?Q?5WZJLtRHCDryXbK1l30YUiWimethfTVRgK7BjNcVjBHTzfikqfQ6dJj0uKVw?=
 =?us-ascii?Q?Qv/EdX4h6Zc/vKRmgLPwmVrOPNoYfc9dd+NN1UTPVX9ccHp3l+Ckt/eYqaPi?=
 =?us-ascii?Q?/IWn1d7VwtDLJ6zj5owwyOkPI+NZRZ2rgiUTFJRZzQitEnmW17iOSVgNpAVI?=
 =?us-ascii?Q?ZI1X53ZceDbVwKhVPWfDq6tte5GLyYI1mTmQWgTLlP0u3c2L28Mv5RPwg/Zt?=
 =?us-ascii?Q?LE4y1+jTbGgHTK9Rm3213EswhDHBAoqJDtAlCSYrKrn4seLs/MrgYD4RfOtt?=
 =?us-ascii?Q?STYE6IDwzlO16neY5bh11yPBD+/o2aS3k45xv6TDFSQNn1HRXxppSE9Gnm2w?=
 =?us-ascii?Q?R2aO6P2bs2nJ1LP5IdnkY87H+plJDleSMQ+Ykt+HSHHEI+iqGKrFl8ugcH1/?=
 =?us-ascii?Q?zCMS3Wya3t5Ce2uMa2Ku1CNvVtM8o1GGoirXIMJhvGqd6b0HN/xnrFyHqkJb?=
 =?us-ascii?Q?ZFArMDzqti/QXS2D++YC2iDj9YAOJ7inZowD4d+3HkTuEdpk/+G32bhZLcsk?=
 =?us-ascii?Q?8BWnNYnR/8jHpe8Yns8Jb58nCKcgyIV5f2EQkJ3b+RWb499M7f9Bxn2asGge?=
 =?us-ascii?Q?CoCSH+0S9fYLuLlC5+GwzOOx4e+e9l+4noCqXxBHvEaPBfr1sVAisswI3Tw0?=
 =?us-ascii?Q?AnJvfr+GN83RS07g1Iy37AxQ7HKVXoOXzEDyhRUjpXoroMIXY8gEONZNANQE?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M/gXIxZDQET0zT0mYHRkeKdtOQlTAgxSNTXRizGE8n6JLSclXW2avEDL9m2EliA/Me3W+LiXPw2PiTjI6p41osJqTeLSIXXnu879RyzYBtRHFTzGpuVwqPjPwsLcTWjNtMoNF7olPxMQF1Jqn+uy5jzXLlB/CyKgSp72LSmwftv5niHunXWLteYomFZEYdaPPK3ydwiUmi0h8B3mbhAC7QbjRIeMqFW6GsBDftCLCXbf84JmH898taY30Nxc2VJtn80SrwVE6X/SEaV/6pps8scldNKL0cC+EZLZzbaTICTpUPynMaQ+q/7JDQPQqL91jntBTods1IejuRPG1DbQ8YkHuwNCqU2vbEjB8Br/jItPXRP8slSHMuHnBsutQElR5s5ABfTFUys75v8UlyehEDjAuUHtJtvC8o7A60a/8cX1YWvuMrHlX2HDSvpoKv7hwkI2VEwcsLLbMrjhDk9vpovxJv34wpmZBQrYEsxrgH7q2+ereC9BldrrEsV5s5UKkIe/p0O5CKb15pVsjfOQlTjvLluwMKRa6KS9MM/cMWzKc+4fPhV2JegHZefG2axHPcJgB8YLFDGqTaHVTYWiUGpJn9tDK3pC9wiRmoDboeOCOlSv17NQpLJSwj63XI4M
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb154ee9-88c5-4086-8ce0-08dcff45f20e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:05:06.0063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+95Wtjjgg25M6FJy9UNxCHcgkXy0RAl99XjNWnBKcj3pHNH9kinQKGFXJwApi4coSIvBxX9MMEgLaXduK8Z9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9296
X-MDID: 1730995508-yyAElx5cG39c
X-MDID-O:
 eu1;ams;1730995508;yyAElx5cG39c;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Convert seq_file-related neighbour functionality to use neighbour::hash
and the related for_each macro.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/neighbour.c | 104 ++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 56 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 5552e6b05c82..3485d6b3ba99 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3193,43 +3193,53 @@ EXPORT_SYMBOL(neigh_xmit);
 
 #ifdef CONFIG_PROC_FS
 
-static struct neighbour *neigh_get_first(struct seq_file *seq)
+static struct neighbour *neigh_get_valid(struct seq_file *seq,
+					 struct neighbour *n,
+					 loff_t *pos)
 {
 	struct neigh_seq_state *state = seq->private;
 	struct net *net = seq_file_net(seq);
+
+	if (!net_eq(dev_net(n->dev), net))
+		return NULL;
+
+	if (state->neigh_sub_iter) {
+		loff_t fakep = 0;
+		void *v;
+
+		v = state->neigh_sub_iter(state, n, pos ? pos : &fakep);
+		if (!v)
+			return NULL;
+		if (pos)
+			return v;
+	}
+
+	if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
+		return n;
+
+	if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
+		return n;
+
+	return NULL;
+}
+
+static struct neighbour *neigh_get_first(struct seq_file *seq)
+{
+	struct neigh_seq_state *state = seq->private;
 	struct neigh_hash_table *nht = state->nht;
-	struct neighbour *n = NULL;
-	int bucket;
+	struct neighbour *n, *tmp;
 
 	state->flags &= ~NEIGH_SEQ_IS_PNEIGH;
-	for (bucket = 0; bucket < (1 << nht->hash_shift); bucket++) {
-		n = rcu_dereference(nht->hash_buckets[bucket]);
-
-		while (n) {
-			if (!net_eq(dev_net(n->dev), net))
-				goto next;
-			if (state->neigh_sub_iter) {
-				loff_t fakep = 0;
-				void *v;
 
-				v = state->neigh_sub_iter(state, n, &fakep);
-				if (!v)
-					goto next;
-			}
-			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
-				break;
-			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
-				break;
-next:
-			n = rcu_dereference(n->next);
+	while (++state->bucket < (1 << nht->hash_shift)) {
+		neigh_for_each_in_bucket(n, &nht->hash_heads[state->bucket]) {
+			tmp = neigh_get_valid(seq, n, NULL);
+			if (tmp)
+				return tmp;
 		}
-
-		if (n)
-			break;
 	}
-	state->bucket = bucket;
 
-	return n;
+	return NULL;
 }
 
 static struct neighbour *neigh_get_next(struct seq_file *seq,
@@ -3237,46 +3247,28 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 					loff_t *pos)
 {
 	struct neigh_seq_state *state = seq->private;
-	struct net *net = seq_file_net(seq);
-	struct neigh_hash_table *nht = state->nht;
+	struct neighbour *tmp;
 
 	if (state->neigh_sub_iter) {
 		void *v = state->neigh_sub_iter(state, n, pos);
+
 		if (v)
 			return n;
 	}
-	n = rcu_dereference(n->next);
-
-	while (1) {
-		while (n) {
-			if (!net_eq(dev_net(n->dev), net))
-				goto next;
-			if (state->neigh_sub_iter) {
-				void *v = state->neigh_sub_iter(state, n, pos);
-				if (v)
-					return n;
-				goto next;
-			}
-			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
-				break;
 
-			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
-				break;
-next:
-			n = rcu_dereference(n->next);
+	hlist_for_each_entry_continue(n, hash) {
+		tmp = neigh_get_valid(seq, n, pos);
+		if (tmp) {
+			n = tmp;
+			goto out;
 		}
-
-		if (n)
-			break;
-
-		if (++state->bucket >= (1 << nht->hash_shift))
-			break;
-
-		n = rcu_dereference(nht->hash_buckets[state->bucket]);
 	}
 
+	n = neigh_get_first(seq);
+out:
 	if (n && pos)
 		--(*pos);
+
 	return n;
 }
 
@@ -3379,7 +3371,7 @@ void *neigh_seq_start(struct seq_file *seq, loff_t *pos, struct neigh_table *tbl
 	struct neigh_seq_state *state = seq->private;
 
 	state->tbl = tbl;
-	state->bucket = 0;
+	state->bucket = -1;
 	state->flags = (neigh_seq_flags & ~NEIGH_SEQ_IS_PNEIGH);
 
 	rcu_read_lock();
-- 
2.34.1


