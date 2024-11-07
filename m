Return-Path: <netdev+bounces-142895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBEE9C0ACB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A462E1F23671
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F39216201;
	Thu,  7 Nov 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="D0W6Skc+"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B2B215F74
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995518; cv=fail; b=mrziubaJjNjbT02f+M8qDGSgk4xzksPBCBQXaqEsac6u0agfbl9jBssNn8DG5+xairxhyyat2gWfML+ieiF8YFe24Rv1hCTeaJ1MMdFJZYXEDi8C8WACdxdaLsl2OPFvHJW2Rejug6WqwCjqqgBd1UXUPB0bujrWcht2fNma90E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995518; c=relaxed/simple;
	bh=CuMP1ckZxLEi35wz4GDGQI+S/Pq/oSNXOgW7/++BY9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z6A3z6Yc++Lcaot8D20o2fonNcjnTx69Z+awvRZEUAi/ZQjGA9EQffpsiQU1dG9foqGSG9rgHOxjkPZqSSH9jXz/EwIx5G3w5d4m5/TrwDdO0qvP8lwwgNa7v6BOQLGy8Woed4CWBOareMtEHV9xJJ4oDeazk03ljNmRiwC479E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=D0W6Skc+; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 85ED3340059;
	Thu,  7 Nov 2024 16:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFBGYO/8W3jwfNdX0JS0hGm8NNAMIYJTckAbfZtwvkypOSRLfVV4yXhLmeb7bw31JXQk/vwL5J9mCkaQAQYSNCY/7jCKqH78Ti5kSU8sIDNh9Pusvd0NsF1nqoUm6il74xNB67zSgwPoNKMwoZSlnrlUzwua8mnYpVuDGYS11gLLeEL9BfzyfXGgZUjnqC2ct6kZqjE2nFaUivQpmejm2KTUFeAsQMBILMykt0rsyRxniEXPl5I4Hl29PJ9pjRcXtOy/0UfT7MeThWEIxO5MglMkHhOHd/zDXg3VwBb1iMFywvP2MadVE30KyhSki31dPOK9ATTMsvFMmgg1ZYTW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iur2WErsI5SQhnOd9ptyx4la21xH7T9pH+p1CPXpfdg=;
 b=ruPe51mv59QvnNc7UM7amAwOhfiwmAt1mo5ben2UjD0/6rrW7W1AVOiGc+XOkiLjkHXpvN6yfx4d5ngLLZg9l5WDjOr+7fswZnNpe7sSpIqUjgviViNWSfK6m7TkaDNdBOK4TOPLieGfaLhH1lBp7UY2qssVjiI5nqlgp0OkQeEWP+DOCm7vIo3xFbPyPplKAfgG1VIjLQuSG3j3aLYzssYkKzw0a7ldPxlu3D7RL06H2LjGKljG9lh3rQFfLvPcYClvxQywij+ekaccT+6Vd33WGcUUvhoztkOw9xgXukgP5DUCj+ORoGUoJSoB8RtX3NljTs8h67qqVPQIgbAbMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iur2WErsI5SQhnOd9ptyx4la21xH7T9pH+p1CPXpfdg=;
 b=D0W6Skc+3M2CiVZ8bnB/s4IjTKcG4AgJmGkLYNvOl7p5P4NkIOs+RaEAnNDxph5MdtwpqRO4UvwE/2LyAF2A+BjJ+iVlP4BHoy4z2oy3BUVliUsyDsuBPkAy54JVZtkVQWOtTuEb/dm+zpMnHH1HQYyAdPcWJ67WuQy42AOijYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS2PR08MB9296.eurprd08.prod.outlook.com (2603:10a6:20b:598::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 16:05:07 +0000
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
Subject: [PATCH net-next v9 4/6] neighbour: Convert iteration to use hlist+macro
Date: Thu,  7 Nov 2024 16:04:41 +0000
Message-Id: <20241107160444.2913124-5-gnaaman@drivenets.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58827e91-cb2e-4a4a-2cde-08dcff45f29d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NL3p3WDrh7qvgMEctFQoyzGBdokM6yiyxz/I6a7hykXvM/krlDqpzxNlzZfo?=
 =?us-ascii?Q?f7pK89nTAzeDgHUoZEs8u3HqSM6SQMhvjpJ8J/1Lw4nFLD0vi/8HJZnmVvt1?=
 =?us-ascii?Q?TzjfxqRqTNm6kMjrGTaPV9/PKsiwMtomn8f6BsH1qGrTGuLtPoPFUhzdG7dJ?=
 =?us-ascii?Q?iW+54wT/4Qx44ehsR9z3gSpAhJ9Rfjdkh+srwa3Ck92Id38JjNKnc1PLKpK7?=
 =?us-ascii?Q?xUpwFrMuOKop2Q8b+oLUa46uollwcFETmkeNk4quK85zJTPxGqAxcxserhEk?=
 =?us-ascii?Q?q6EUz+MDb5WY+ohfjMcFv7y4zhPriHbHLOscSu1NIqUJntZ1aGvI0lKBt2hO?=
 =?us-ascii?Q?Pvp+pqLipqviPox4s9gTFE7hpM3MWR2rqDg/6uBJ1bpDkQ8gngx76jifB9iw?=
 =?us-ascii?Q?4dVaLiQpJKYxxrAA9u7jOE34hwbRaZMSd7RjrG98U/845C90vlUDknsuMG1H?=
 =?us-ascii?Q?1c7zA6hHBNtuTWjrf2T7Xn/f8WETo/FkX9+250So2Q/AgbuhvmuKsurxez65?=
 =?us-ascii?Q?usaDyFEpzhOQ/laoeNQANiuvFIUcK6bIK7DeFAln6VgYkOqhoCo5GoupvulJ?=
 =?us-ascii?Q?9BtSFKLr91x2JbyJb6Auf1hqTsklhvprUuieSY7cWU7ccJHkBgYnLT8l5mBM?=
 =?us-ascii?Q?hg4r+kN7lWYQxLHQuGWGIbqHSlKOYGHmagkl7BUrWOLMPcFoBv2fKE+by2q2?=
 =?us-ascii?Q?cH97rVuq2s/nMovuD/oLjy9ZOLaLBAwc4GLvhYSYGXaYhVANiyw7qFjLEZAR?=
 =?us-ascii?Q?NSkT0YbW62POLBEIX0SMrCxb6LjdWwMsGrSZzwYxgQDa8cDMeeJvmh+XRcP/?=
 =?us-ascii?Q?c3WXYmu2SkFcJMdy8FI0vXrdOEy7/rHKHh1s5WtzgcYzUaUg/OVJGbxPfCQW?=
 =?us-ascii?Q?cpehzS7PbxtE33xH9fVTJkZRxXZ/RAoB6V8suMIhffHqYeJMN5jI9o4J/NDl?=
 =?us-ascii?Q?Xy0hmnGaIIAPAaDb4yDDXVrguSNemeLVvxJ9SN2HNvv34wnhQHpnrvCM7ePy?=
 =?us-ascii?Q?tTwjw5+1rRpQnqoTLeW5JZJce1iXmeRbpejFj2oTF6r1GJjOn3t0D7JyDLtz?=
 =?us-ascii?Q?rYUUtXYYjZZ0Wo7srIiZ6dTVnjpBxVZOR/uwMgAgLKwwJuclqsEwuhHeMXtD?=
 =?us-ascii?Q?4HaZzSJaMx58/kPGyBFBYbHPRpj5EcRGhKX23mvpAyu4LFulA7JK3BW5Zodw?=
 =?us-ascii?Q?LKxtNJIM8R68Jz3ePv4X+GgxJS/Rqowvpih+h4Pv9M2WrxN/vI2t4vsqcq35?=
 =?us-ascii?Q?XWFAOQR0p/fmGmpKOFLlSIITG6ukKKbu7k8NiS2odzmBFIvv9TeziArzrsOH?=
 =?us-ascii?Q?qu4xc3oINKcg8VYOQv3/0DgKX8V9CXqFAu3uphVzoyG7I66c9OIV8HxbUROU?=
 =?us-ascii?Q?SN/XlyI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qQU+uNR7B6gui5me/RfSXJUkN3WchVK6vz89PmpmivxeXppGOtOdyzNp0fbs?=
 =?us-ascii?Q?p6A5ohSRp3GBaVPjHSGV9r0N19DEpT1wtx5Z9YW3z5e6KlaXzmKihg3Rhy8L?=
 =?us-ascii?Q?1AM5qCwafpjVOG2HtkS4ZtQ6D+2CAS/dhyTXXZV7uoGlVikPf7PlAHyX/pdx?=
 =?us-ascii?Q?CMpSpmvWSFcm/OrQg4mqndBYqUXOvP/1DTOmNFUXoKzw/jIim5kRFLCVAvd/?=
 =?us-ascii?Q?MfAHWrQDdJAmjQyeC3xAiFmJMYy9NsYY5bzzsIglZBRAEPYjLbaqo4iHk0/S?=
 =?us-ascii?Q?NpNPkEzLQzgt1XX/hgGhH110pdRLNWiNfQwmtcYkB+1+HAWt3EBQxpZ2wyeS?=
 =?us-ascii?Q?VEd6YD+QQTof2c6TbaqR+YQSNksutbEgNrfaz19i53gp3Y+VZ0qocSUSEDjO?=
 =?us-ascii?Q?+RFRFZNSyKjAkptvnInzAIBdYFeT4n5nyPzTqGBcMUA1n89DKLl3RCHxWu6U?=
 =?us-ascii?Q?UKK0QvBTxZTzlTzCZH2xvdq6ULPTA/oWkuJ15KbMhZvdPi+cXAYsdkoMJO3E?=
 =?us-ascii?Q?v9UrIfBUT1ayTBf9S2Ibh9AxaEKrZI2LyWwV5pSd53bOFQzgr3J+W4zKMfoh?=
 =?us-ascii?Q?sEKZrvmcKHEHvHbkauRiEDtQadA4lUwMJedhOLNaLtmjRcmcopqj3BXQNC/y?=
 =?us-ascii?Q?ZEOlFIw5VKkBuYRUn6wTnjjoonA3XwbVodDL5PPWFMrpMkTN8mmcoWprT2U4?=
 =?us-ascii?Q?EGwcse44RtvZfH21DFPyRVvgas0gqYxKohurBC2qEt+ibmEK+xdmpyr1trUI?=
 =?us-ascii?Q?3GlxcZLhy/MOmDzZIduwUQDejhIsTBDbug2gZoymp2IvekDcPvhPe9/5nGpk?=
 =?us-ascii?Q?yBJtniA7YxfNC+zGGVaZUcraJlho28XbMgsBof57Q85wKurl6uH80BBUsYyh?=
 =?us-ascii?Q?9g+kcKY7FxT7w1c5Eed5aw73ww2ZKUCfjhsnKYodBVC1yKnoZh7rqW+TlGEn?=
 =?us-ascii?Q?h23BSrfoutDL2Q5on7BnN/cm6ZwI4CzJr6451KdKX+Xv6lcqQ3Miv89znk9E?=
 =?us-ascii?Q?P4IUbwbvlF+da9cABTgqoGTf8BxXAWobHadwERDv08B6a3EXpXhNYWG7kYZ5?=
 =?us-ascii?Q?H8UzT32/Vx8d1E1wiMYnzjo7A7ud8XhCQRG08MiU2WVugZ2buRloIWvWbbqi?=
 =?us-ascii?Q?APzqH3l5kXaudo2xOMnnGOSAPSHDAiiLpLPvxcGjTxA7NpUS8JD2PNGU1sUt?=
 =?us-ascii?Q?pJb9CDMP4b8Vj0GxwPZjctLm5utvkmtbsUP2s+UZUwTyKhhuIlUEjCUIS02Z?=
 =?us-ascii?Q?WptU+y/St3ayH2BcwFgLTc5MAgdvd8dukzZ55AhVRQf2VvDagKsLwXypzfiC?=
 =?us-ascii?Q?LGK1RoGLy8Q8r93SVs7zq5Gwl/WIt/Oh1cg1GV6MgSnSNiAQHOtHf4wJlJUW?=
 =?us-ascii?Q?W/MIrlPBM3ABUj8JkHy39M5nEhUi94jR5ddAadC53wcKxX8LLU0AiN4VJx7I?=
 =?us-ascii?Q?5QkTdAttYA0gsR5Fh/bO8YPB7Aj4BRmkfOwWpaaw6VGwUR0r+Y1v/UYIdONp?=
 =?us-ascii?Q?F9twr1v68NW7aipVKa/XDnG0Jet1ZLDOAsdOKhokJl9cliLtK/MiB6vDP0ry?=
 =?us-ascii?Q?TAffo0XQfULgU4/wIgj6QNvwzZO+a6uQQ4AHAJPiKGDm56sIwZ9Cz54Mq5uf?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LhCpKFlQ3YiLTAOGupomzeVPD9ch3k30Af/iN0xUAzODG7XRBv1sBJJZaQqY01mm2z1L8G6qeym2BgIix8/mvgn5qzQoPzBX+y4R6hJ0bqWQPsJFI5oVQ4CvH+77jR8Udndqwt1PqWQhZXdNlyyRpH5FQadCbM9cqd3p1fbvMQ9a+niNfVsuyxc4qMqGerymlPVdrNk7jeq9L03m2cv8Gmt5u0/QhsNGbeeAW5pJlXomYHDVfNM/iLeW/vZNxXLTx5qPDREN1y2Zyi8j00u0+phYJa2HoVCtTcUVA7YQ7kmkly/+usKmhxdEhY3xkDBXGRkyvqhDOTulXc2wUPoXHeHH5QfYO2rfXqchMRoBPsOJVTQ134o8+h0/P2PREKV4CC4zVALViNruceSKrgOYAa8CRlkhIcb4PR57tdv/sB4xRMzrKZfj3BDV9LSnrOama4ds0j2Pq9vqFiuh9f531Ivj6xAZncdSxCAaOXCUkeKJ8JAx9BL712+xWQe5d3dQO6gxUl00b1NovsoAg4WzzQcinjQjtmXE840suZsf7AMFzETTrKkWXBuh24q2WKwoeRv5Oyy/mDBDbrc5vkyA2Dtb5QuSu+iRWH7A0CEyTwkFwZDKrCFrmbqd7U5sUWjE
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58827e91-cb2e-4a4a-2cde-08dcff45f29d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:05:06.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBUmQ0svHVVJxVy/cC1AVBGrKQek27BaNtGVZGAAgAY2tmBljLNOji0sJB4oh+soxC9GvBFUnywPRb9/amMfQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9296
X-MDID: 1730995509-vtkOJQwXHnO2
X-MDID-O:
 eu1;ams;1730995509;vtkOJQwXHnO2;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Remove all usage of the bare neighbour::next pointer,
replacing them with neighbour::hash and its for_each macro.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/neighbour.h |  5 +----
 net/core/neighbour.c    | 47 ++++++++++++++++-------------------------
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 4b9068c5e668..94cf4f8c118f 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -311,12 +311,9 @@ static inline struct neighbour *___neigh_lookup_noref(
 	u32 hash_val;
 
 	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
-	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
-	     n != NULL;
-	     n = rcu_dereference(n->next)) {
+	neigh_for_each_in_bucket_rcu(n, &nht->hash_heads[hash_val])
 		if (n->dev == dev && key_eq(n, pkey))
 			return n;
-	}
 
 	return NULL;
 }
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 3485d6b3ba99..f99354d768c2 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -387,11 +387,11 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 					lockdep_is_held(&tbl->lock));
 
 	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct neighbour *n;
 		struct neighbour __rcu **np = &nht->hash_buckets[i];
+		struct hlist_node *tmp;
+		struct neighbour *n;
 
-		while ((n = rcu_dereference_protected(*np,
-					lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
 			if (dev && n->dev != dev) {
 				np = &n->next;
 				continue;
@@ -587,18 +587,14 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 		return old_nht;
 
 	for (i = 0; i < (1 << old_nht->hash_shift); i++) {
-		struct neighbour *n, *next;
+		struct hlist_node *tmp;
+		struct neighbour *n;
 
-		for (n = rcu_dereference_protected(old_nht->hash_buckets[i],
-						   lockdep_is_held(&tbl->lock));
-		     n != NULL;
-		     n = next) {
+		neigh_for_each_in_bucket_safe(n, tmp, &old_nht->hash_heads[i]) {
 			hash = tbl->hash(n->primary_key, n->dev,
 					 new_nht->hash_rnd);
 
 			hash >>= (32 - new_nht->hash_shift);
-			next = rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock));
 
 			rcu_assign_pointer(n->next,
 					   rcu_dereference_protected(
@@ -693,11 +689,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		goto out_tbl_unlock;
 	}
 
-	for (n1 = rcu_dereference_protected(nht->hash_buckets[hash_val],
-					    lockdep_is_held(&tbl->lock));
-	     n1 != NULL;
-	     n1 = rcu_dereference_protected(n1->next,
-			lockdep_is_held(&tbl->lock))) {
+	neigh_for_each_in_bucket(n1, &nht->hash_heads[hash_val]) {
 		if (dev == n1->dev && !memcmp(n1->primary_key, n->primary_key, key_len)) {
 			if (want_ref)
 				neigh_hold(n1);
@@ -949,10 +941,11 @@ static void neigh_connect(struct neighbour *neigh)
 static void neigh_periodic_work(struct work_struct *work)
 {
 	struct neigh_table *tbl = container_of(work, struct neigh_table, gc_work.work);
-	struct neighbour *n;
+	struct neigh_hash_table *nht;
 	struct neighbour __rcu **np;
+	struct hlist_node *tmp;
+	struct neighbour *n;
 	unsigned int i;
-	struct neigh_hash_table *nht;
 
 	NEIGH_CACHE_STAT_INC(tbl, periodic_gc_runs);
 
@@ -979,8 +972,7 @@ static void neigh_periodic_work(struct work_struct *work)
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
 		np = &nht->hash_buckets[i];
 
-		while ((n = rcu_dereference_protected(*np,
-				lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
 			unsigned int state;
 
 			write_lock(&n->lock);
@@ -2730,9 +2722,8 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	for (h = s_h; h < (1 << nht->hash_shift); h++) {
 		if (h > s_h)
 			s_idx = 0;
-		for (n = rcu_dereference(nht->hash_buckets[h]), idx = 0;
-		     n != NULL;
-		     n = rcu_dereference(n->next)) {
+		idx = 0;
+		neigh_for_each_in_bucket_rcu(n, &nht->hash_heads[h]) {
 			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
@@ -3099,9 +3090,7 @@ void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
 		struct neighbour *n;
 
-		for (n = rcu_dereference(nht->hash_buckets[chain]);
-		     n != NULL;
-		     n = rcu_dereference(n->next))
+		neigh_for_each_in_bucket(n, &nht->hash_heads[chain])
 			cb(n, cookie);
 	}
 	read_unlock_bh(&tbl->lock);
@@ -3113,18 +3102,18 @@ EXPORT_SYMBOL(neigh_for_each);
 void __neigh_for_each_release(struct neigh_table *tbl,
 			      int (*cb)(struct neighbour *))
 {
-	int chain;
 	struct neigh_hash_table *nht;
+	int chain;
 
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
-		struct neighbour *n;
 		struct neighbour __rcu **np;
+		struct hlist_node *tmp;
+		struct neighbour *n;
 
 		np = &nht->hash_buckets[chain];
-		while ((n = rcu_dereference_protected(*np,
-					lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[chain]) {
 			int release;
 
 			write_lock(&n->lock);
-- 
2.34.1


