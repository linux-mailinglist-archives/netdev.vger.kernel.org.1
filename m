Return-Path: <netdev+bounces-135789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D98E199F394
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4218EB20BA4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEE11F4FBB;
	Tue, 15 Oct 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="lparX1mQ"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BCE1F9EA5
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011596; cv=fail; b=JJH1SXqpKlkzfPn58IvLq7tveOK7iffl8YQW///JjbcljiGtY+OKVKTfFx/OYtTPBk1PuZcLP+0ZyC9kjNu+NLwLNqsWxtzMUxyQCbVo4hx4sGoJJZaEa2HwH/JppHt/kapuZYUj15CmEmFe2NG6qYpN6JFyC8SgKJu+/ymocAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011596; c=relaxed/simple;
	bh=i+pMkxN1KqyAnoh1DUu0wgK4Zq7pKRwaXA1pRHVPbGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BSltgYsDfKAkwVGnDtenztK3k7HN0NKU6R+fBE2I+xWpaxPwBkg9bu2RIiYm8hgFNL6GuVFfSEyGcq3+U9sWT0xJ4vDzl3B0XXGeN77vHWZxzxTKrDbuDKLs/aEPUrKkDQ+jt00/dtP+sAeL3vpO45jQfUpapdsMmEpnV/lW7og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=lparX1mQ; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 75414480058;
	Tue, 15 Oct 2024 16:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5mdsQUpRiDpe+iT173oEr4MqIiklFSXees49rqAX08E6Cp3Nbol+JB8GSIbyEZkCH1q1DPtJiXEoZpSs+m/9xSgk/IU8pT+9CKgUipqH0RBGYTMuir/A0me9xhdbaffOd+hhRMLjWJvYes30+oAMvdpPb6/pwjQO8nsDYuZ/zBacOGWeRHCs0cjRdp6n69joBNYqqHAbEJDq9ogNsKEposD+C8prs7xOV5fa5xrR4iuEhohA4kMSNIoYbXlDOqbItOUZsQwPi4H4wWs0w/CukMAjRilZZ9z8gnIbmlxJ8v4XM8UHyX1lPwDzHtUTBfI40s8hnQIRbPro3+o5P8rmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2w68Frqn5CmZVxMYA8yP84xvbUNkoXIyBSn5v34jX4=;
 b=HcNCg0x2vnM78l5U8BkIG5HYRbtZhWxlNPmUDrhaWjLSWY7voY1b+zGXunsm35rCGL5AAMSzoizaONnPmrm8+vnst6sid4hq1qiLTqYeU2ZkT3E4pkvx+gjSREGbQN5q1LE68QF+Tq0nWZpjfGcu4ZfuVkh1MHnWMv3h2XyyJD2AFcMQutgLDIDWy4T0jiaaidi6GzBoVwtykC4ad+yMgTiHWK+f2T3sBKLYNsOJdS2F3rSxsRlp5nrguDWJv1JKKnhEATpjcBkkbfoMDt1OOtZiuCt3otCYP03oiuIuev8Pn96YBDDd+wbI/Cth8yLkhUlOTI0wF5HnSo58G+cnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2w68Frqn5CmZVxMYA8yP84xvbUNkoXIyBSn5v34jX4=;
 b=lparX1mQV8Y26kUzMM3pI9+L+YL0mVtAZGiO/0yDk6AVVQjTWgAkCTfzZhww6sXcHPOWL6FYWYCcTSRpy5ImCxnzSev94hiYb7OYcRICysWZQzNMGS68rMx0dUSz27dsXu+tP/pXxrza+d5KEASLRtdhCdMbzAKhVzhWDjbRwFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS8PR08MB8249.eurprd08.prod.outlook.com (2603:10a6:20b:53f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:59:45 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:59:45 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v4 4/6] Convert neighbour iteration to use hlist+macro
Date: Tue, 15 Oct 2024 16:59:24 +0000
Message-ID: <20241015165929.3203216-5-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241015165929.3203216-1-gnaaman@drivenets.com>
References: <20241015165929.3203216-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::23) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS8PR08MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: bc086242-b336-4992-e6e1-08dced3ac528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Vvy4SdeEtQWLAJd3K3XnJDscDSz7dY8fskz8mkLlhwafc6lovlLbcaZqWL+?=
 =?us-ascii?Q?zjqmCwmi1bzrAplEo9hxuQ5dv16Xckniu5QfSNyLNgnJ7CMV+2H+akcPsG7X?=
 =?us-ascii?Q?k04hrP8iZ5K7934aLqlC6P3Ez75x0Nw4wdvrskSMo6MlYu4/W4aVJerznvyl?=
 =?us-ascii?Q?C3VHjNxVdlm24ARCycLBPX5nq1aNinfY3+flUC7Aa7G7jqWHB39s0LwwukzT?=
 =?us-ascii?Q?gBXvqp29tcROM056CI8/8g97wSoIMblrZ5Q+l4PuIvtXiUTfdJ58tr5lSQ1O?=
 =?us-ascii?Q?3rojCmoc4R0nYHetbUyrcutWpY05nli3nsogSSJIYSY5IDDdGkobn2Zcf/6b?=
 =?us-ascii?Q?eVPFlWa2SIOtciLhRqtv+1+GlvLlpfXhyEZv0yI1SZAmnWFwD/4HILBxBxlv?=
 =?us-ascii?Q?ve1kKNIPgJnKpN8V58l+GZWxl6WRLdgyuIwTCGDRLs3+j6hqx0IDzdTqzYCO?=
 =?us-ascii?Q?WfPpOyoEWD3z/1Cj9Tmo4JortHKr/zSG7LJLHhYwhzbid01sIWU64c05u2+f?=
 =?us-ascii?Q?UnHWXNnJ6x+ArIem+w2sBkmEYP9BD/cb9IlBnefs6/1oyJ6RqZe6m9F7lL7J?=
 =?us-ascii?Q?uS/L4HsgdDr2mMecvr642byw130wNMx8Pw8qyQSFkkS6JE2WT4WjkWuo1AOW?=
 =?us-ascii?Q?NlVMKKNWk1I8UMapZv2Ow0pfOfZAzfiTYEn4m+wLKcFBRIHa3ffxOhXDVKel?=
 =?us-ascii?Q?AiTz0Dxhbhoh2ImAwjVzWQEsLu7Fr9cQRWFTxEkqN17k1CO7FqhqYlEHXJet?=
 =?us-ascii?Q?QgdSgSscRr3ipbyC51nHZhAbNMEbj0vH6sD1Deb9xLujSRHDS1rE9nuENV5D?=
 =?us-ascii?Q?AI7GFiSsvTz4hvSVtC/m95aNMktsqb6Vjv1qobDF73Ypw6zA/d2ugIp0Xotv?=
 =?us-ascii?Q?WpYMLYgAFSNWAU02F9/K1JUE8SXY38BDXg+FZJqZTSXLRQVtJr9l1qWZ4Wrd?=
 =?us-ascii?Q?AYNlPTA3rlpVqjWYgkssyloIkGHJpviilc63Wpnqkej9U0fAduBOI08ASAHb?=
 =?us-ascii?Q?wjr6yHsMl0El1sekg2d2wOoUf07xn1p2syalxo1uGl3/sexhT1dCSoKW32wS?=
 =?us-ascii?Q?tEmr0KA8Jm+f11XYtkvFUDk09zR2WOiI1jpSwfBGCCbNCcmsZKmwl4CB9fKA?=
 =?us-ascii?Q?Ph2+db0VbQoBR5u1rW+GrBFeqqNiA6DDYrT5r87Vdio6gI5RifJK1a8f9Lo8?=
 =?us-ascii?Q?HujU88EosGPvFekhW6IYAajjwPSt2DbYdSdLWlQdaMsrdAgro+Y8q+p+EUBE?=
 =?us-ascii?Q?Y55EG70DVFVmRSO91SeXoJkWytgA0ORA13tUM9icOB+mZlWSL0qAxjNKMes/?=
 =?us-ascii?Q?wIRlVsgTy7mKFjb7wC7pGGbsUNQAEak9tfQGa3RUmz9Wgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZUoib/CEhs4jXnsxgqbdsq0H8JTPX1IoRTUswHIRTd/NyhYDNaiurx8Zf7pi?=
 =?us-ascii?Q?DNyStRksL+NerCSqYPhzNWMSNxiRXVXy3/o22FBVUfZkUqWPOjUp/1qXvMbZ?=
 =?us-ascii?Q?m95/fXY5uPzpkGoWK3tt0y/PS5Wqw96DcarO+q/EmyHFy86PA9rg4dYKDtpP?=
 =?us-ascii?Q?JiX7BcvSLkl77jfZzW2YyAxoAmGb84FeQGJKZijLqsHRUHLmnSI/R1cBGszq?=
 =?us-ascii?Q?dqU35YJeiBFKgW6WPovOXn/GoJTzp23dGTwcmNYhDa2J8CiL8bianKtZN6Fj?=
 =?us-ascii?Q?hIrHGFbQyhZmUaeUzYoPFBLLfHpA3tTPdc5H1soSJBlyxHzEbsFsf7/Oj2XM?=
 =?us-ascii?Q?iCX/4VXwVrGKkld/ZJZYLoFaQu4bxJ6dWGQODqdZmK4Svd5AXtF+STYZr8DO?=
 =?us-ascii?Q?2IEajPR7UMvz8TJT4Bsz702HDsmXuJANE7ixP2b6kp3Et+8UMWah3yHoj+0E?=
 =?us-ascii?Q?t7pV4KNIGRwvr/Hawbu5sNNA3NEEHe2aSc501JiQVFI1G36MeJorun2Im1qP?=
 =?us-ascii?Q?V5Lwsr9Ny7FxcqVqCkTLtkNVVm9vkw4oIFsNamNToJrfnYWtvXvDsafAy+FQ?=
 =?us-ascii?Q?7xAtXuOSjT818EyBWlKll5fI+YhpDmGVlE58HQWumhIP9+1Mww2GWi/232x+?=
 =?us-ascii?Q?ntvF3LAXPKVUW9hSTNaOcOoXaxuoomJi98+eyODNw1KlQn+Lr0wWzFwBGB8q?=
 =?us-ascii?Q?cmkEio3j72D04sX61nZxGbOpyDzPr34/3PA3bK3n+MFASdq9wgNGVjKMCGbd?=
 =?us-ascii?Q?rgw1fIDcaGZFfHi742dDiDV7Nbtst6oJV1ivmtboads3Tc48nRTmL+jvolKl?=
 =?us-ascii?Q?VZJZ4e2Blft7dT32W6XQGwnihmBNyBJ0ikiOJBLttgfbqpsLfiGvSLTRhNWU?=
 =?us-ascii?Q?VQD0cu32qkvaPw8oaf7CgKbTAsdxChMMh7/r6TgrFfpxpO2lwvz3Gt5gH94m?=
 =?us-ascii?Q?8V9zflz/M+paRU9n7/1Y9IcPYhl4TKkGIBnvFl2qLxN0rSyYTqn/Na6IMAIM?=
 =?us-ascii?Q?w0OIo0oVwR5YNpY6p7Xspdy2WcYE8bb044/CcP6Nd+MoyWQU2UAiiNBcCD/S?=
 =?us-ascii?Q?cbeHnCxn2wTtMOU05kezqS2NzUm0fTiFAD7zVZzSnJLhFY81r9geZ2eiY+vj?=
 =?us-ascii?Q?et+2UK6FRb8oweK+jz423LwrLoFAaGftqk1+TtKGU990UkrhTAGraHAyZl70?=
 =?us-ascii?Q?vNkifHGdN6Ma+zAyXuwcfwMI2+vCFaGIM9pa6HML6emXZjI0fjcpQQIvOMVV?=
 =?us-ascii?Q?47kzGhYBILCu4gMjpmc4xpUY3gbv+lZxI0FAm50qUFQlmicYaMSxHjMr4pDV?=
 =?us-ascii?Q?SWjx+1h9JoApgbi37KauP1y7r2vY8WMya30RckrnsvecNAH24SzoZu5vdSBJ?=
 =?us-ascii?Q?+4BocqS4ERmvmpuXSQWN/CERK6d6LOU1Jx8rpMU5bOarAdOMB2jFu9Eikx2E?=
 =?us-ascii?Q?WANUid0hcNgO3yCc0RutnbcgOLvkK46scviQT6caX0bDxjWZsWaYct/FxTWt?=
 =?us-ascii?Q?WkH8M8M8URbljOR09YpGNOupwRr1Gp19HphTpDfCkOf1MCk2+56GPj1eY87N?=
 =?us-ascii?Q?847P2FS3G6RUK2p3voLSVamnS01UwQvE3R8XokR28qrALefpKo8f5m7nQi5Y?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JDjLSCMFxrvxGatQ6XwpDtcGwR8c1RRXbacNlznF66lPHxBCuzM+MsCEb92hGPRisr9lDDeL8ZUUlXb51R6isCVTiVCF1NcixmbuF1Sux2Tv8HKWoBQRfMYWkMuJQPxPda6fSnzkzY++gLOWlHLKnrZSt1xp80USJPwnUWpcUDcYTPw9dYYCfA9sgQtYKMS4bblIfX9/62hI1pelw+HoGYYkqHu5tPT6uv47xdA0oauSgPJLpPhhgQKNmT6jaQ2HcS06v6IT3t8Ev7cXveTIZS99WmBeaMBRgL+9VRn2bkMppzzPUj9ZH3rhO68Uzvt4/0PbDK2GJlKHOse+Z7ACPPKUJLvDHol3csqQVuGsJtQjJ0ynzWfmVZSNOOI/fLLs/HBZaJN45gDdKftjDMMZFUaGJ6K5PgvP1K3zLJNTRlD1CytGBdjiyKG5tYoFDxg2lxew+PIqF/PBL1ZMAO28hOsiZTVQobctkO88/vPS9364sFzXsPGnzLADp4D0sXn0IwOh/bTgWAYXawq48y7683rryZiRuq1j7mAtIh1H0zPD2PCfgFfSMYcVau7JZoyj+NGshd13wyzc0VYQqu9PpSEyWy7piUbpxZcvNs8Cy86L/PBUoGKR1/RQkFCkxnKd
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc086242-b336-4992-e6e1-08dced3ac528
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:59:45.2618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7z5Oaut/yCmR7IRBrwaInPoX+X5dFI/28fGNnBXcUHZA0VjoolRfFqspsQ5yLyk81WyUjOFswjDw6tV1qq1Yig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8249
X-MDID: 1729011587-xRkNbYue6_Gh
X-MDID-O:
 eu1;ams;1729011587;xRkNbYue6_Gh;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Remove all usage of the bare neighbour::next pointer,
replacing them with neighbour::hash and its for_each macro.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |  7 +++----
 net/core/neighbour.c    | 29 +++++++++++------------------
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 7dc0d4d6a4a8..c0c35a15d2ad 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -279,6 +279,8 @@ static inline void *neighbour_priv(const struct neighbour *n)
 extern const struct nla_policy nda_policy[];
 
 #define neigh_for_each(pos, head) hlist_for_each_entry(pos, head, hash)
+#define neigh_for_each_safe(pos, tmp, head) hlist_for_each_entry_safe(pos, tmp, head, hash)
+
 #define neigh_hlist_entry(n) hlist_entry_safe(n, struct neighbour, hash)
 #define neigh_first_rcu(bucket) \
 	neigh_hlist_entry(rcu_dereference(hlist_first_rcu(bucket)))
@@ -312,12 +314,9 @@ static inline struct neighbour *___neigh_lookup_noref(
 	u32 hash_val;
 
 	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
-	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
-	     n != NULL;
-	     n = rcu_dereference(n->next)) {
+	neigh_for_each(n, &nht->hash_heads[hash_val])
 		if (n->dev == dev && key_eq(n, pkey))
 			return n;
-	}
 
 	return NULL;
 }
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 4bdf7649ca57..cca524a55c97 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -391,8 +391,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 		struct neighbour *n;
 		struct neighbour __rcu **np = &nht->hash_buckets[i];
 
-		while ((n = rcu_dereference_protected(*np,
-					lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each(n, &nht->hash_heads[i]) {
 			if (dev && n->dev != dev) {
 				np = &n->next;
 				continue;
@@ -427,6 +426,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 					n->nud_state = NUD_NONE;
 				neigh_dbg(2, "neigh %p is stray\n", n);
 			}
+			np = &n->next;
 			write_unlock(&n->lock);
 			neigh_cleanup_and_release(n);
 		}
@@ -614,11 +614,9 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 
 	for (i = 0; i < (1 << old_nht->hash_shift); i++) {
 		struct neighbour *n, *next;
+		struct hlist_node *tmp;
 
-		for (n = rcu_dereference_protected(old_nht->hash_buckets[i],
-						   lockdep_is_held(&tbl->lock));
-		     n != NULL;
-		     n = next) {
+		neigh_for_each_safe(n, tmp, &old_nht->hash_heads[i]) {
 			hash = tbl->hash(n->primary_key, n->dev,
 					 new_nht->hash_rnd);
 
@@ -719,11 +717,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		goto out_tbl_unlock;
 	}
 
-	for (n1 = rcu_dereference_protected(nht->hash_buckets[hash_val],
-					    lockdep_is_held(&tbl->lock));
-	     n1 != NULL;
-	     n1 = rcu_dereference_protected(n1->next,
-			lockdep_is_held(&tbl->lock))) {
+	neigh_for_each(n1, &nht->hash_heads[hash_val]) {
 		if (dev == n1->dev && !memcmp(n1->primary_key, n->primary_key, key_len)) {
 			if (want_ref)
 				neigh_hold(n1);
@@ -976,6 +970,7 @@ static void neigh_periodic_work(struct work_struct *work)
 {
 	struct neigh_table *tbl = container_of(work, struct neigh_table, gc_work.work);
 	struct neighbour *n;
+	struct hlist_node *tmp;
 	struct neighbour __rcu **np;
 	unsigned int i;
 	struct neigh_hash_table *nht;
@@ -1005,8 +1000,7 @@ static void neigh_periodic_work(struct work_struct *work)
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
 		np = &nht->hash_buckets[i];
 
-		while ((n = rcu_dereference_protected(*np,
-				lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_safe(n, tmp, &nht->hash_heads[i]) {
 			unsigned int state;
 
 			write_lock(&n->lock);
@@ -2756,9 +2750,8 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	for (h = s_h; h < (1 << nht->hash_shift); h++) {
 		if (h > s_h)
 			s_idx = 0;
-		for (n = rcu_dereference(nht->hash_buckets[h]), idx = 0;
-		     n != NULL;
-		     n = rcu_dereference(n->next)) {
+		idx = 0;
+		neigh_for_each(n, &nht->hash_heads[h]) {
 			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
@@ -3124,11 +3117,11 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 					lockdep_is_held(&tbl->lock));
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
 		struct neighbour *n;
+		struct hlist_node *tmp;
 		struct neighbour __rcu **np;
 
 		np = &nht->hash_buckets[chain];
-		while ((n = rcu_dereference_protected(*np,
-					lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_safe(n, tmp, &nht->hash_heads[chain]) {
 			int release;
 
 			write_lock(&n->lock);
-- 
2.46.0


