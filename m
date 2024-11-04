Return-Path: <netdev+bounces-141425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 525619BADCF
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF30FB20EB4
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C180B1A4F2F;
	Mon,  4 Nov 2024 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="nqT2bGGW"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A8171E43
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730708062; cv=fail; b=fqCVxzfQXoEg6Z5GKUEvq+J8RZvdqX3LNelBmgwY3DwvJvRd5zSk/iCZzeyeV2IUKDQQ5g0AAB0f1iCvj+jJGZSWZ0InGqtOSigUPN/9a2hJ5E4dJ5Yoq+qNnphmdG6rJr7mAeKY++HJ7uhsPxOGHHFGJJ/bYcvTSsh9i/3pvJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730708062; c=relaxed/simple;
	bh=Mi4oX8KVGyMQ2yxV3V0j7HM77O9X2JqNHARnohdjUkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=khi8qRAIGoqFltPycQwlZjIPpvZ28d+KJ2VTpwbrd4j3brV9ZrG/QLkJK5bIW7R0wd3ALqFAlhGt8PAl0LYcmZfqskfGGZ3XGhLB9PixFuriAd4fymJKo6a+8HO9skQb4MXWpvJITaKKIf0m6JtJBOX93OGzVFyt/N7f7bOdM58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=nqT2bGGW; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8ACBB340D42
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 08:05:07 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 010AB34005A;
	Mon,  4 Nov 2024 08:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baivzAbPQG3GuaoIm+8Xx9xpzm842zyYaMVqfjN1+mxDhc6Jfd+AsK3B8QAPVxxFKWfGpmHG1PLUnVZptiy352jbSj4loFat7BOe2sE/6CjQlVgFWqyYjk9k0PPvr16UReQ3JxvbdJE0gwxc630SYgME9SVy7ziw3NivhlTFkQr9+1QoPj7TXT0QGEHSb6g9Z56X2mj+Wstw2tRktu6/Mb0S0fJGzTC5LJehcaKGz/tMO5dnTBOlJkZihtSOxnmmgYkxke2wZH6UKnG6fatnWGbl2l/d8ENduTzGQBQkNCxUWlkvSej0lT92nlxnjJ81laawf7Ha2pBD4gn4NgY9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67pL6gzSl/wDCe0KWgo09OAC1DwR5gupCZiddtInUdA=;
 b=VQal2YoFZga0diHK4zFguaenJvoPpTux/VQHBnYN8b+xAWUCxEZdgjUSSLFtUsyHrVLsUFrbZeOF9n7HNUAc7B36e1bATymTbNZt/GFIMp+iIouuT6JTVO7CSPhoJrS1FmpK7j/gdiTxrNsVWsqb3rqQ5DO4CqSAEVIQ3TW7Z9ssyiYHEF/iqpUBOKj7X253T2bz9YgYNs7SqclxcG4m8Q/MWMm63cWi0h56lLKqBHOTd1tA9TgxhG7Lod10vLTYFrY0g7pn8NWC4zkFVfiDD3PdJiYN/ZTXFOCsI2A+aEIS5oM5OWsiCXhtpm3SBeJerQaUV+k9yNMwOW4F4zWpRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67pL6gzSl/wDCe0KWgo09OAC1DwR5gupCZiddtInUdA=;
 b=nqT2bGGWBGvesWg2+3TP7H4D9IxvLycwBnYBJWfDvTLlytkNDwih1Hy/WJh/Qz3DgFj70oAeWXsyZw4qJXXIhp7zp4427tWNsSlx/6zuDhoLad+cb2SpUebvmAR8IkvY0Uy/nZzY5BXy3VtAVVjGqOgfUfdjGAcF+iFKf1k+Lhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM8PR08MB5553.eurprd08.prod.outlook.com (2603:10a6:20b:1da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:04:55 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:04:55 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v8 0/6] Improve neigh_flush_dev performance
Date: Mon,  4 Nov 2024 08:04:28 +0000
Message-ID: <20241104080437.103-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0206.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::13) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM8PR08MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: adf00806-aa36-45e9-f349-08dcfca75e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?31hrK41isj7ZSofYGyVgySf5fkEgne2a2u6m7RD40mv7l1pEg5oQjfyw/lFK?=
 =?us-ascii?Q?YgKDSF5/T2TgRQE0Zz6/8Ol4HtN5fx7H26bWkBWOKVu00Gd/0U4Y8/4QpCvQ?=
 =?us-ascii?Q?mbiPkM7pXKkydrUik+vVafQuHAqcKgtw6TvxZIqmdwGkj5EkUbpCnYOIG/Qn?=
 =?us-ascii?Q?rld9linNa+Oqs/6pKYtMaVF0SMirIGTRDKLdGyQRz+rk4+LQwF52V6947B4f?=
 =?us-ascii?Q?tm0WMNLBy3ocOIqrdfwxqU5Nvkcd7IhtO7FbdAQZIY+mQ4p5lYTkpB72DYLL?=
 =?us-ascii?Q?UpPvT5yEqC5cN6r3lSCG9B7mi3Ch3hWqazuE2sejau7+NQw0ondsABLDDfVL?=
 =?us-ascii?Q?+EN80n7U3RnnTtoxp5Sx3R1Dt2VsvIqLUXHSXXBd38DG8vlJh/ElJ0Lm/i85?=
 =?us-ascii?Q?OY2BjkcpQr5wvAqAOS6gL4JVKcBuRz3lfKjROUP3c4/gjiEiEKJVvV6/p9Ur?=
 =?us-ascii?Q?pSV4ZpFNc7IUkQk2Ukw5kAZczfifADwkfNaUPst+nbXC1epbIXcKXhBlZ0Wj?=
 =?us-ascii?Q?o+AxEYHMFhJFt0iEvrThRM3GxNXK2mbh3AgCEshgZ49KlEFgrapLSr9aO6Pb?=
 =?us-ascii?Q?9LTmLdTGeExP+8MBJza8NLWs8CuXUNsPY/nuN2JA21dFDheLcI76gnNv+32l?=
 =?us-ascii?Q?gzWo4/Nst8btZ/DcNuTPkzl4bC2bHibsLoMYrajRIyHfXwKGegOtDjpekp28?=
 =?us-ascii?Q?mL3ZNJCYa3kWrMLY93t0uAkkPl9ZhIXwyNIU87i9pMQL2yCO9i1LaPFgLx1K?=
 =?us-ascii?Q?xZJK6ACchb+fuko3+Mi9RBcfo4flaPOVwLWTi8PVY6UlAOzD99XAA4ItA6hX?=
 =?us-ascii?Q?qGGTxMlO2AXiqz/2sc3YmBj2J1jZZxwzcVpoLuLCfS8NKssyWjklwAyIlN5x?=
 =?us-ascii?Q?UX+aMEdbsTLqg0zT4zOaJFKx3OFqz6wU/y5HKlAXfatnYzROHtNbD521bkv8?=
 =?us-ascii?Q?dQZeDgnqSnRAnQIqvrUoa8Ao7M7fYXfy73JTmg6QEM9vTTKOY1ol28h9Dwzu?=
 =?us-ascii?Q?QDD7TQPcIa9JVDdF2wUzwKV7pIMwgejcqsyFGoiZwYSNNQ5dUn2RfFLQVrtD?=
 =?us-ascii?Q?vh4Y1Mtf8Eq3XbX4zIQOmIKfsQhPaUsEdUXBk6x2p111DY4piZ4E0X7AD20K?=
 =?us-ascii?Q?ddmvlIPh7q8TbtqIYkjDNWX3hnvpMMxpqzOYhp7paPFuJ9kfH7guJgjPzWCf?=
 =?us-ascii?Q?4W424GTgtF53AQHMjdrZVs1Wir8HAHUtfSHWjaRcTvFIknfYzAq/orXaD2Vh?=
 =?us-ascii?Q?FEk1Ffj2w2rubFRHzRhLjlwPE/ynB1UUXewpoM31Q8QJ0RCgEgV8CMdI1zgP?=
 =?us-ascii?Q?BmK9j2vMO15Gfof4AV+EJC7WtvFmj0Toj6QdA4ejIeAlqI4kh5cM9NdedzEQ?=
 =?us-ascii?Q?MS49ewA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vsFGTpvwvleoXMTAFULkm0NfelOWwNqCGoqeGH3uRToF7kJo63qxb9qx+ibv?=
 =?us-ascii?Q?t24zXWwYLAcydfoccLBfIV/uoPA8gdOkldfMTY15ZBvYJGiPA45hbnr/6XD4?=
 =?us-ascii?Q?vBfy0XJVlNtO900c6rAmIpFBg5XrzyIJuysp7xmLHHHQYJaD6mMSI5ez65Gk?=
 =?us-ascii?Q?W8S8saWWTFHBOH7zm/AYpxrCN4BnBLy3RjrUv+frNw2Ib4L/+X9VTiUlDx5y?=
 =?us-ascii?Q?4fN2Uf8knPGQPyS62uRAPn20Spd0NmdUw/q+mIKKtypGyMk+oGFXkKiVhGQA?=
 =?us-ascii?Q?6iyuYqRnj4OErO6/B/N8AhDMT3zJUIk3CPSDbMCSCyQUPoky/LRzLb+2ZLh0?=
 =?us-ascii?Q?gzn0xUbeVUy1PcjO6QwX2OnnzdEtcHwE8Nt3mhvQJosv2neh6ICCMSLOuyIv?=
 =?us-ascii?Q?LSs33U0t1M4ZZqMQr4pLjZszR2LfF6+rUdqGhy8XBFoEpGMyjc8NU1N5TwyB?=
 =?us-ascii?Q?VC0GbCccRJmRCCLfFvwiIl2Vr22eo/aSSqBQzoUvP6XCskNCgKtT97WRGCZM?=
 =?us-ascii?Q?cvIgxWY+EpDyXuM5qfj7ICifRYL9ijwIqL7TBCVYbRfyEO/r8QHeQQ3OGp/z?=
 =?us-ascii?Q?qDjfSIZ7VpwKrsTVukyx4pXFWNpNib8A5bgHPsGYyVzjlTuar9+SLQzsH6E0?=
 =?us-ascii?Q?NWa3lia3naMuWM9GIdCDXmyCbBxY/627D+wNitYo2nkcibsilOKJhIbCdVCc?=
 =?us-ascii?Q?FI2trT0e53PVFAiTYr9EBURc8vZu4tWw5nbwUSaAGtAcDzqmB0VS/1ZiN1xy?=
 =?us-ascii?Q?+0krC0bu5z9hRoamrQt8SPAyHI1C05O3Wb45JgMlSUpv5QZNn7N/57UkBsYD?=
 =?us-ascii?Q?fnBZvPQLVR2+/IZ1zY2JgrB3CLK6se0eXHZgWUIxLBFmCdtft9byQgMNC0ox?=
 =?us-ascii?Q?rq1B43w+nPwZ+PBpqL6kvwXWKeUGG2NGvhE/nOdG3p+guo8Hs+B/fgVr0VPk?=
 =?us-ascii?Q?MijTgZ+/54rpns+yo0+F8zPw/xya4TV/LBuMIXCCIVwo60hEtyZaOp+FSzo9?=
 =?us-ascii?Q?UCuc4XG0dnW9+vFGvowQfXcULbsLaDrNEY/Nr++jltuc3mDmf/gK72xRqK2R?=
 =?us-ascii?Q?TX8gxA6XI78dJyMyTCKj0kH1lWCG5mm4h/9mRMfBvLd4g6gQRb1rny78aZBM?=
 =?us-ascii?Q?3Rrs6TgQPAFPG1Eett33jFQaimRaAgKZdLYczqy66vjUF1JQ3vNRxRJnT5eC?=
 =?us-ascii?Q?PE/FUaldBgtwkT9nBZw+Dl2IRTeJVpXvzZdA7CP4oiTrh5eqLN69wpPIG/F8?=
 =?us-ascii?Q?rBggFKY4Ou8SwXI5eNpW8vOrYwiUP1CQrbwTyyGYSf6SZMCOng0Z7Jl1vQ1Y?=
 =?us-ascii?Q?mmmzlBVeCTrnxuK60rzNf7264XtdehwH0YVw06eF0AV/nuOZ7AiY162tiYF3?=
 =?us-ascii?Q?qlJAzGnoNfL1k4Dg1ar1wQhxqJIUJJWTnSyVKueEvbwcVvgV2NiXyrAZcfsO?=
 =?us-ascii?Q?45AQQCFWbpE/4e2gNJxPWEDJc2GKa0ql3sJY4si3klCnkJzmFGb7i653EmGo?=
 =?us-ascii?Q?Fr/mfDEclKRuCHcXYwKCEU6uVUwEMdx7oXfwgWglzTv6EIyM2z24D8KZFbW1?=
 =?us-ascii?Q?kA63lt72FR/dqZrRsNSbrvVU4+b7pFtnzO1a/IniLJEeOGGWNC68edNTzzwF?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mR3voaZ3IrHOl5R9gTWk5UM7sEYx7gnjXbJU1/oMkxEAYNGRNVTSodQ6UZm+RI+nM9vnGeYSXatGkkui+2wgWxo+qVjkQNCzsP40kZdpEiyqQbQbqY6T8raFX/IyVsiq7skARGOt3b4rrPF2dodo9y/nwYxeSaPPVtTokG4hkYNSeUqAzNaPfj79epzFX0YR7OrqD1qihQb08Tt1PUBBqcrEABxpqWj77PwPOyRNqlX0pMBzyvQbfo0e3WPYkLpw1xgwU122OvFddAzx4xlbAhO1dO4D/br4krOW/Rtc98vQEpo8xpMs0NZDommEf0VFNoSbvi6NTB1X5vUnO+ScPZCP91V+ipMpFaRYittRJ50mvvcw/IP+f26/K+u8DjejZieBRQ3iyFoQ+F4IXrYYyLRKm3k+HGESJDrMwzW0v/nMgu42MTTE0uZNpvpTte6dSSLpGyTgy24YDHz/8tX6cciphxPD+EUkL/8iCb6HPJCzA6p9vBWmQNou2U8VIhtjQtU8OKHXjS6lBIAhO9flqg5ZaqvHxR2XTJ2dRpP0R0cUxVVf1ZVSbDE3QZdKu9pfMEu7XDKitV0+XbAJJCFtD6HDkGNsATtD8jJV+hwt5wlX8VlgG8bQlByIofv55GlE
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf00806-aa36-45e9-f349-08dcfca75e4d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:04:55.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQ7Mi4L0ixbu2oS0gd4rsAbJgOopF5X+3y9LNNiJ72gMgs//A2pyMHbm+2yatAnz1Efr6xiT5iGwP1zIWmipog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5553
X-MDID: 1730707499-ovxA_e_MMQbA
X-MDID-O:
 eu1;ams;1730707499;ovxA_e_MMQbA;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

This patchsets improves the performance of neigh_flush_dev.

Currently, the only way to implement it requires traversing
all neighbours known to the kernel, across all network-namespaces.

This means that some flows are slowed down as a function of neigh-scale,
even if the specific link they're handling has little to no neighbours.

In order to solve this, this patchset adds a netdev->neighbours list,
as well as making the original linked-list doubly-, so that it is
possible to unlink neighbours without traversing the hash-bucket to
obtain the previous neighbour.

The original use-case we encountered was mass-deletion of links (12K
VLANs) while there are 50K ARPs and 50K NDPs in the system; though the
slowdowns would also appear when the links are set down.

Changes in v8:

 - Rebase and absorb alloc_pages->kvzalloc changes

Gilad Naaman (6):
  neighbour: Add hlist_node to struct neighbour
  neighbour: Define neigh_for_each_in_bucket
  neighbour: Convert seq_file functions to use hlist
  neighbour: Convert iteration to use hlist+macro
  neighbour: Remove bare neighbour::next pointer
  neighbour: Create netdev->neighbour association

 .../networking/net_cachelines/net_device.rst  |   1 +
 include/linux/netdevice.h                     |   7 +
 include/net/neighbour.h                       |  24 +-
 include/net/neighbour_tables.h                |  12 +
 net/core/neighbour.c                          | 325 ++++++++----------
 net/ipv4/arp.c                                |   2 +-
 6 files changed, 168 insertions(+), 203 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

-- 
2.34.1


