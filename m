Return-Path: <netdev+bounces-136106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895969A0570
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8D5B213A4
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5A1205E3B;
	Wed, 16 Oct 2024 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="e5F5aW/G"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A168418C340
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070769; cv=fail; b=Hr8j2Zr1KTGB5sdeR8I67UZfJyTedHeg0SVvGXJ46iw/lOh3EB1wNPDm0jIgT7hk0cKsOHPDRSkJuSGh6eer6mibsjLUoPH3lPLdcAVRJyQu9fJ1c4EYZfdvH54KPSm80bwe/fETwAB4GJdqxx4cX0ebYyJcrSa2ELimbN1nvz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070769; c=relaxed/simple;
	bh=Fp7exEldtENF5Kx4wZ6ZaKi/EvTsaxuCNHx0r2BgBq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YkaJFp/SJWemXlrlKRcNg+3+gGCfsXOmEjpLx3kkV1V8XWDncUnbzd4ivMruBszgc8Hnf97hSYcx6I+L2HMyqijUhBd0tVgu4bgZbZTQy43pkHqShCAlXNEMIQ3s0WL/ngPcY/1s8reYmm1K8/DCv8NxOpqiOtBNJAq4bwJft8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=e5F5aW/G; arc=fail smtp.client-ip=185.132.181.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0096F3419D5
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:18:49 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02lp2238.outbound.protection.outlook.com [104.47.11.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 67D83C0051;
	Wed, 16 Oct 2024 09:18:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uT6f4bf86EUSFcrWlRY33d66OX5SVoAl/Ta+sHxaRUAVdGNMzmcZpTSxPX6FTDUD2/MxfFchtM53CIX60fHWmZR+RnOA6YIsg4oWT/GeKSIwG8YBQS0I+I26Bm0yGUiHnoYrCG7doXnEHkqj6ywdRz78YEgkIRdsyr31A3zkoLOMoM/RC+jhUqv3wHlX4Yf+xmRnRR/uGRKz//LTbGO5m2wzmXJjQzB8yJeDN1TR2CVHq3oGfkREo2xtbUPwSYjpPiPK6xBU+8wgOuXu/Ex8m+sq0BZaSRO+ijSDw8kqLkOD1kpDAJwgFY8769nfgusYDU9GWoqH4SaNoS9CQ+BS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyX6MllQ30bi+cNX+CISXaalIs/mnqGvXACgTvdeppQ=;
 b=aAOfl+Wc5xSLUSIfcgGc9xBnRpjLj19oUqESZk++UnxIwxEM12MjAlxAJNYYsI1WdNrVNcKXrdmfXBZuS4QzXR66n5FxYFdwbUtlQlh+bQwy3mEtCN++/TaIVxW43ckVRyAxDi0UTC9DAkvC/+z47xcECb+boHTSkws0uh8odLvTJgLP90dqV9F7YABqfnKJwXRyHzXWY9QpU8vYaRkf2lT11NjA+zuAWCKp/7wnCgKDRk23e4ZtkOiCoqBvZ6omp+mQPZx/HZnO7Gs4O0/F7KWT131GUjTsKxjZyP1WfZQcb6fMpsM+wXfKHHDGU/sOSTj5D3JB2UyeEOvHvgussg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyX6MllQ30bi+cNX+CISXaalIs/mnqGvXACgTvdeppQ=;
 b=e5F5aW/GI2XMUWrmjFUTbbsRSTd+QeHYyYKo0vyHZKM4Yn8kArwu7YfhYCFH82e2lK6Yr/cNfvDMxHw7koRZqlM/B3iIf88KQ4NSLaBQBhGgwgCxqCCtWoLb3zELMhIjyl25c/8kPTpKSJmr1VL3iaFBskN2EE6oaE3Q/K7C2Jg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by PAXPR08MB6590.eurprd08.prod.outlook.com (2603:10a6:102:152::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 09:18:38 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 09:18:38 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: kuniyu@amazon.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gnaaman@drivenets.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v4 4/6] Convert neighbour iteration to use hlist+macro
Date: Wed, 16 Oct 2024 09:18:30 +0000
Message-ID: <20241016091830.3507504-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241015233851.68607-1-kuniyu@amazon.com>
References: <20241015233851.68607-1-kuniyu@amazon.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0271.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::6) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|PAXPR08MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: b1cd0262-5e5c-4eda-c35a-08dcedc384a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z6dgnc0YMO3I8XmP+QKEFgrrfmreWWojZSUuJfRSDtSEYcP/wpOUWEBUwj5S?=
 =?us-ascii?Q?XdgNTa+vx9LYmxeti644C1nxAJyuZIbPB2FLnYuTo04Th90qbbQEQum4AHa2?=
 =?us-ascii?Q?FHklC3Skj09zxUnmYGgP4cR5svtl0WG1daRtGB0JeEqH77Co9lnTpqXU9tEQ?=
 =?us-ascii?Q?Ptgt20ljChD6A65yorXDaM37AR6GN6J5Ab5jHdkiZUYPKhAcJf6mWzxeG41n?=
 =?us-ascii?Q?EYlkB4prVXQtfySTGL+lZBu8hSXhEjOvIjsYDiMSax5KHm3mS3Xza4LszR7M?=
 =?us-ascii?Q?kHqrU+J9vIluvu7tLcxpeMnHEsp9X7X34tENYkfrCyEuLSgM2Ed1G8nfO+Vv?=
 =?us-ascii?Q?WTbM+RSj8KmaK6/btKuRG2441BGiooyIEUqWNBgoviHJN/5nmiyVzPcA9vkD?=
 =?us-ascii?Q?aYWBJodztfeHX0raxskKYpOKmiUWRojgcdKOU6HqzI99p49DDLTW90opPRCD?=
 =?us-ascii?Q?tTZKDgXVMcF+dycWBJ6+Yt2YKDmu5wapTV+YWfv1jZo8QzWo55NPhovKnMG/?=
 =?us-ascii?Q?hDy+OzMeruMVZaGcJ27W+zam1VyNkZv3/pivgo/cGsL7O27Obws6NWwCr23W?=
 =?us-ascii?Q?vbbg9+IE+AIndV6gdbPTklNdyqMegOE8lNK5/mihB+TPpsF1vuhvkwN8yhC8?=
 =?us-ascii?Q?Va33rkew45mKxbTaP/3ujIHPVpKVxv+oko9WazWSjB1GpAMvK0PZ/3URDqsl?=
 =?us-ascii?Q?oGSieF+cPPRbpanGNrstnWusTnqX5RIpLVPgMka3xMkyrFTorLhJzFxRoLE6?=
 =?us-ascii?Q?3M+1JWbkcgPR0Lis2OSXq+QzxGitlQFwVwtrgYY5wikIz4HiFQfGlgMpPL4i?=
 =?us-ascii?Q?RRR7VfVQogFhwGiZ3dGvSlb1orUDO3aGhlmOPxIjmoa/k64JY/wSo4/ZHIK3?=
 =?us-ascii?Q?11eVxxUyeltWtVPZiyegpx5CfTWy7CJ1Jz+HIlSp8kUa2QMqrlybfzCGrNFs?=
 =?us-ascii?Q?Tua0tcRu+T4xbwCNvZY3IK2KWDq/zpYax89kgyYns1Yuu632RmUUCrRMTVWa?=
 =?us-ascii?Q?yun9eBvfjuWGChwCzGSXoN0hghGfnk3z527vrecNJ//2sgmaHM6x4+QxP3WN?=
 =?us-ascii?Q?xBYy90mQAel5YAXinIEHOErTMwivWlGcchKQ4cRSBXw8QCWVnDhwpSr4qn81?=
 =?us-ascii?Q?krU+0XTSNrtb16LVHYGluMcCrj5rb+5xkDNzo6/CF2WnaUJYbOmybgAc5wSL?=
 =?us-ascii?Q?7GyU9/6ofqxkrWUlD473mYXM4c4AZWmaMRtfwgodQYfaLEuoih97LMTisd4Q?=
 =?us-ascii?Q?j5DwaT3/igSXpigT2coPYPQFFqKNW7aF0sG5oLQwYQKisBjjsVvSyHb0hJOT?=
 =?us-ascii?Q?vy6vlwTZVwxONrC+rSDntvovguv9kukFSeHI23RH4yxBpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9RBpuU34cNRPXJ1n11+bxQLaPRtgA5zZtLMKLOkrllNPX8Nu2kkJqD896syY?=
 =?us-ascii?Q?PzVDiYE+3Shhi3Tajq96lWCbodQJJDVQ776eaN6ZAdS0SypJYFcelH/9ayOY?=
 =?us-ascii?Q?sdZ6bgh2aK1RUgA9upgF53udfrC1gqbXdDihXTB/d2oUPvXqVJt2ZHxN9LQ+?=
 =?us-ascii?Q?j9bMhA4d1vPwjYY4fMCcHl1M79cP/JEPKzHrPNippWg5yxyUKfQBVheFGTYe?=
 =?us-ascii?Q?6hbfnbRPBFrSwiQnlLGpsZ7VfZeFUr3bB+97r60btrtyRWb3VJxlbBfxT0U9?=
 =?us-ascii?Q?gtQKB8E92fKl3/MbIck8OD9UyQtrhATLgypPesrQgWA0xawAhkLA7b/Or6VU?=
 =?us-ascii?Q?iD7sPXbm+jpeYcPPCE2oScOSof2d05aEjZfVt9qm4/eTYjuHouY9WXlCt3ZB?=
 =?us-ascii?Q?fGi83VKcV5COe6s8D4biALxsaJnxtljt8d+bdppGVox2P3Rkhij3XrRrol5B?=
 =?us-ascii?Q?v30ao852q93O/coAQPCb6fzLKxiXJLbNQqhobYcrY8OIRIBgJMitJqK5VhyL?=
 =?us-ascii?Q?YxLD0Yrx7/2UTHQU3esWpcHtyGfk9CxVUIQVxT3IOdJMIc1lMrfLBhWj0Ite?=
 =?us-ascii?Q?/q6Cuaxs+HYCNxTP3lpfCugDE5EW5c2ldIazIrL8siQebbu0iNM32hQwny/s?=
 =?us-ascii?Q?xsJxJZsykqKrTSbNDg5wX5spZ9t41jdi92HPZRLcRZlqzIV/EbwmCveWBCLw?=
 =?us-ascii?Q?OxzJnONpVvqR6KjpmzfOECHnY6baUbzCAf6bXdr2zD75HCWgxB+ARDXWgh45?=
 =?us-ascii?Q?Yg1Xr9D+jBJ9avHT5+N4ykGozzVUbn+3/lo2tQ7lL7D8tYeGFhn6emIUXKas?=
 =?us-ascii?Q?WwxgMwRDu0IDocYJ62hSExHweAbTAzgrWVEptfZqBz1BsGcJ99VvY4dHOzRp?=
 =?us-ascii?Q?BQC6gVNTmY6/tI/Y7Ntl6UGla8f+KJyIXxkzZ8f4wEIQRGeJFsQhkCEjrn0m?=
 =?us-ascii?Q?SNsMHeeFvIiQueRDVHAFWRb0oRTPKCpGgPDX0AImImXPKyAWynB5B5nkKLkV?=
 =?us-ascii?Q?whNQ+VEbr2dwO+/5eHqSAwSaAaNKgqhM2Y/JJBdjPY4hziJbaTTIf+rJwL1Z?=
 =?us-ascii?Q?OXJNxk1dBssmTLqUbgT/5KujdYNZ4i3aGPcxHQkIE4+Uo63NBixHzG1fUdKL?=
 =?us-ascii?Q?YBxW47vXPF3tCxmHJ9WU1fz0EwNqaF/f6++R+pNA0/iJkReMpVEKVI6wOCk/?=
 =?us-ascii?Q?FaCaNL9GZFl/EmtazXP1/Z0aGUX/1rxHpeEznBlFMDN3qNnbdtOgxlfUTNRp?=
 =?us-ascii?Q?L02g2vw/qNaHMzs/HkPuYOzUFdeUZuUBZIgDeTykzmcJMsIVv6rfZaD6RVMp?=
 =?us-ascii?Q?KaoZa9fXEO1/SH1lWQR/Udc4pmwcdDefv4UvUyqWQmBmIlqbW/C6ENcnsfLq?=
 =?us-ascii?Q?Qf2D0aDTAjoI2/vZ1Fp5OyxNGcqEuGALdKReYNn4bIa4m97zCNzdrbtmc/2e?=
 =?us-ascii?Q?tXTGp6BJKghvlEyVuLF+CSeuIZBlrGHLkziiJv8UmkiSdA4+qWdsjNqGw63a?=
 =?us-ascii?Q?yD80pmA2tulj4GZKEitdILlLVMZN4SiLWlhaZ+0lqxhjLxTrKZJMqAnnCsux?=
 =?us-ascii?Q?pGzKvJjrNp9Mz+HBTA2TbNoBOHOq8gJUfamQR2RG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	id4EH1FkxiC8Umh7vln8kL2erP7oyIwnrZCrQAicZZz5JG38kdWhM/P7DobexiN0wUsyBBHxrHPVD51NN75iNgYORXX2rJI0WLNHCWhNvDxkEDrIKIXLyQ9hdNx+kDUrz/29wUuqaGsW5Lp/Mem8hmbwby91880Wej0GP9iQQYBMA9Bykc/R3f5PyWkaJVpG/xCunBFrveUPJlGAl9zKg7a8ySq+4gVU1q4rxJGI1vUC+eTERK5zrr6y8HruXvY12+dwYStjWcW9Gu03IdVm8QKFycBx+eg5FPXWiKaDVHpPoa8lzV6/8MbgseEQuVDhmu8S1AsCp7vsxyF6n5b8fausBtZqiPcyuWUPzhQUqilaMIg6ZauWqTqR75MjxO3OXzAr3JYU2f7Cn6EttGjrF5KQKYH9gTgv7NfJEzMEiQw8uIygOf9lnmBLSPP3zKywrnPKb8gBbKejjyGl2codSo1IwSjVsi82BKAC/XqpHck+5X3A2l5JaGCPRb6Mxiu59rACIAVX2w0oVPrupFicidr16a4RNyXBWnnEfsUwaQRE5XNLxSW/su5/iflhPwzAv7cTBIoeto41t+3ZJ3Gic/8NaxGLaYYOVYZ6iwBsqR8uRCIQAnsWnFoUg497k3J+
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cd0262-5e5c-4eda-c35a-08dcedc384a5
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 09:18:38.2046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1ykHoJGX6fHHH/YTCWfs/mZR5pC/nON2mlehfPu627i0XTXYOUtmdYl0655MZObXpDiaGfPD48AM5PZpW7m0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6590
X-MDID: 1729070321-lJuVqy3_rjsj
X-MDID-O:
 eu1;fra;1729070321;lJuVqy3_rjsj;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;


> > @@ -427,6 +426,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
> >  					n->nud_state = NUD_NONE;
> >  				neigh_dbg(2, "neigh %p is stray\n", n);
> >  			}
> > +			np = &n->next;
> >  			write_unlock(&n->lock);
> >  			neigh_cleanup_and_release(n);
> >  		}
> 
> Is this chunk necessary ?

Apologies, you're right.

I mixed up skipping with regular loop maintnance,
and thought I need to compensate for removing the original loop logic.
Obviously wrong in retrospect.

