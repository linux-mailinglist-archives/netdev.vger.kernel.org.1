Return-Path: <netdev+bounces-137417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC19F9A62B2
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65713B2171F
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B67E1E47C3;
	Mon, 21 Oct 2024 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="lUQl7m3N"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228A1E2840
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506284; cv=fail; b=HxrdevX4ta4l7zM3Vou/ytrKEA6LqC/rpMullh+zg/kwlqgpfPE2f7e0t2rvykndUFRWmdk0z7CKbIf7ZE1N0sB5q9ShDk9ax5+NjKRmggYWLpsObOEEJmsyEUP16eZPoV/B8LUFB/IiJco0LT59d/84+4fZrKPx3Tax5xDtCHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506284; c=relaxed/simple;
	bh=A+5WLTVTgKnbJgd5p+xzqrEFTvxsdewGTqgillMnlVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZ9yR9OwsW+IeX8DEf+oGV+vow1cA06wF87t6hsR1kj9Hv4G0fh3Zusp9X/dJNZL2EpvfDhseyiF99lWuQoXhnJzx7rOLtIuuooyCf+ePlpCmLv6x5aCuIpJX8SNf82RAA23k7FLDSLTDBbfecmNvBMq0Po4LIsXFsE1BzEA6w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=lUQl7m3N; arc=fail smtp.client-ip=185.132.181.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id EF7B26C0075;
	Mon, 21 Oct 2024 10:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxuVbmYbiQWHYJjVTcpTdr6Lwf3D6wvTyOJT76750issRqwF/har3E+ENJlZjjgQDMr+oA1qsrZ1am2Zbbj7ZNEwWkWAW6xXw8QxRYqM8h2DPSP8YLR+Sj36OKNraVgw64JFbJT45DJyM0JgX7Asn8Nkprt6z0J/qFg4I6U0K/AoV70JzHhH9hnjIQ9GJCssqk/SaGf7Rtg0iZr5PWlHFQvklfygABceKrGh+1l8ugr36I5bq2CNc2GeV7EYeU1ZsPc0jFAdIQrsoOqIePHKKoyNsqwPZSh7+x3GY0B19YSPCtLlxAzP1PzI0kmiHaYRSbs7h5pYLs9onIOyXRx4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S82OqHsPVGbQfGIM4S/NdJl8U8lhgnpRIP+IpeCwvVw=;
 b=Uu3GDpNPI+RQ+p1wfSCK6y8ZjiNNVxGT4FDhWv3g8uV1x5fYk64tAU2PXnxrUFlyaVGKhf2YNZdcCgfdx1kiNsa0qTXOpCmepw4sB3byIl6Q+J+7hH/0TPQfhudqLsVjfSd1UelrJr89vzDTuoerQBJiKOt5lNN3/vlKTBlC2fgL+A5fdw0Ol9z2ye/rFARJt6UFdsUPKaYh/3b38PaQQkX/Q5XIyygVseYJMb33KUi3bciHDOTIXyxP3LSDNbQuBRSq5fF7HbVLluWMseBHA3hJQUOQXeCqR8ocgeVQwZsah1z/VEbJhLM1rIHtogxM8xJNLaknYc9IzVtarlk0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S82OqHsPVGbQfGIM4S/NdJl8U8lhgnpRIP+IpeCwvVw=;
 b=lUQl7m3Npvre3/inhx6EEhI9fY4NSRt3WuyVJMFA0N0B4AcN/1Bna2PGBh3ZOUjdzw5rUU6ineTExZ7hLS0XNpeWW6uwgQzSCNZ8YLqrMYU2sEXGvYG1h7gw+JFiUzaIrfvEqPRsypuA6mPN54zIcUpd3SJ19ePaDPl5ASWkp88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DU0PR08MB9051.eurprd08.prod.outlook.com (2603:10a6:10:470::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 10:24:33 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:24:33 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v6 2/6] neighbour: Define neigh_for_each_in_bucket
Date: Mon, 21 Oct 2024 10:20:54 +0000
Message-ID: <20241021102102.2560279-3-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241021102102.2560279-1-gnaaman@drivenets.com>
References: <20241021102102.2560279-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0010.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::18) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DU0PR08MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: d4aa08a3-95c4-40c5-4aa8-08dcf1ba8e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u1oPARCKL9tUK1X+eZdfLV4F3xK3VRdlOvvzKEXuLlgr+4XsGM/FnrDoqoRB?=
 =?us-ascii?Q?UT63/aA1EQ6gOZ9YTTd/HLPiv2J3N7wwrtdtalVMj3U+lDqEvJhhzVnDQ4SF?=
 =?us-ascii?Q?8p/KFQdWaOaU3IXkLsYRV+560jJJTPmB41HXzyZQUcqVKpyKAhqqQdmi+MPw?=
 =?us-ascii?Q?afcqQld5nGxAmuQ2V0RMuV9FEJq2WHT3XbMDE0C8uYLNhsLcr7rwntlBF5f1?=
 =?us-ascii?Q?3CAkunBYpf/iac7BpteFfNnmL6ChSJNswiht9q5Zgs1WlBp4fQGg/iMspRbT?=
 =?us-ascii?Q?98DDP3YH6OldEPRyP/2q6P1hixMT24ABh9zHqlJ2FKP6x91alWRnP3cWu/+B?=
 =?us-ascii?Q?zCYqk4EFW1h92JPI3zr0m8qdtHYK7R9iiFcjAcgS8Ahl2mHqkQtjW1iAYWJI?=
 =?us-ascii?Q?ysQMoTu3J80Rx7Yg/xCaPN1kthvhwofR66lYGB1PTs7Y5uENtWL5sLp0xj0L?=
 =?us-ascii?Q?eQX6Zm0vu6fRkF9UBrxXXDzwvSVbht/E3603qlFrF8ByulKbskdnFZeGLsyV?=
 =?us-ascii?Q?r7Viag5MN1eBZZvPmIz4adux+0zvedHPjMnXerQ0BZNValht5giaSYk8FP7L?=
 =?us-ascii?Q?VQdzcbh81HESxIuphxMvcBl2yG3DQUX5DS6fpCY5tYSVobcPy3b6bqhV9zvI?=
 =?us-ascii?Q?ZSYz3/9LLKl0aijlE37XrXOkXTRooyg5qa9bveJ26xCPmguDa7NG9u9wBGVn?=
 =?us-ascii?Q?5+nIKxvf3UkymKw0/GGWkzXzptqDXD3ValJgtRD/DCsAV+voOw1QO/9AaaEn?=
 =?us-ascii?Q?LxoqAjoRoEi/6CtamNTidkRBuK6VX0d+FHVcuyvv7obO6zZaNMVrsziW4pxm?=
 =?us-ascii?Q?SEXHUmpm2FPl9/OfX3thS477h8Csq7Kg7SIC6STd72xia3skVJOIMg3Fpkm5?=
 =?us-ascii?Q?aMj+1mxqv7z/qwSrMLrEK3knE0JNfd667WWRXK6umj8vRpHqvXJMFSBqRl6Q?=
 =?us-ascii?Q?0wQaL/aoZpDAs9zTgX9L8Y10gpfFJO8rPApZqGKW6wfE/hzan5s/RI6pImCK?=
 =?us-ascii?Q?IogCxiYrFarcKSgpzf8shli20QhHXaHVAV6RR0B8kzhs3DKWZoizoAzAYLoJ?=
 =?us-ascii?Q?6CCipmKUdwustMO4ULg/k/hcP5K47rawTALGpu4ywk0XaokcLVG0CcZNLERI?=
 =?us-ascii?Q?pBKlW9o1QTHBfAYsZ7RL35RyVlMy9AaDWOfsjDRHCqkBuhThud3la+qipknS?=
 =?us-ascii?Q?oY3XvN6qlFMdxmgYZTFarJ57jH3w3WoGhELQqKONzaOXRMjejSz3loZELfuL?=
 =?us-ascii?Q?Qu6wPf10BKUz3bw4mTI8wpaQ8Z9gWblvs/ifGWzUeC4ZyDkJPUkCuVW1QBgJ?=
 =?us-ascii?Q?ySRRvD7emruBDIj/UGnSrlRRDHsSeOSk3FLxMqD9iaDNLdLsE9ZMfjQN9FqP?=
 =?us-ascii?Q?rp+hp+8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DH9ct8UT0snPEyuFSLmNEufSRKYqo0nm/+tTV2MyPG0jAPDKZPy9EZpzvzuY?=
 =?us-ascii?Q?4U3DdjMOtWc2jElprTVVyB/1djNbOwytazBdtGof8vNLVbJclA6FwdPF/B6L?=
 =?us-ascii?Q?+fJz77mhlZotKI6OqA3wb5CYa8avqa+ab++WP0IDUMTlwj4rrJ91Hi6HR5ps?=
 =?us-ascii?Q?b53GbXIq9QA3Eo8qRbg/Irh7VrGIHt20cbfvIrk/mJVo9iadGsty5JzI7/4R?=
 =?us-ascii?Q?BK2o7gblxfjMtDpvKrsPEYwpEdH9t3T1GSqQ2f1eEobOJK1PPJfAwN5uDRvX?=
 =?us-ascii?Q?eMkOfI2fY/9Bwc9fJowkuQkla4w3QyFGf+moZmJ9uIt5RWfSpbCgUcNFzkfw?=
 =?us-ascii?Q?ZUFVBXWTajj9RhuabIDrg1pCRiqNGz1rTGKtCckZ5mYbTtdXibpEk0EHv1I/?=
 =?us-ascii?Q?6+TA9k1FNcNgbTGlTBPHLQuRpXEygME4suzxJ8dNzu3citQS2LgAvyOalFuv?=
 =?us-ascii?Q?jBOE5YuykWqu3hevlmTRsm5Z1pCyifUl5iwPz6hLRhrlpUEeEaEOonDwITrX?=
 =?us-ascii?Q?Hg0OnMnRH1CKyK7uq7fTLYg/OTpRwrDFbr+aYt5gdw6DVKwip16/RLdyxUQK?=
 =?us-ascii?Q?+eJJ7up7VtSJJ5QjktK9J3ZoM95Hp8y9Xo9x0SocIvw6LZRf31Ov5vHUaAwf?=
 =?us-ascii?Q?wdI++kTb3uI7I3tsb3EWDuwtrt94oyO1q2lee1+vTtlaaIYEYvd2VflBPttO?=
 =?us-ascii?Q?ugsUqBbb7HAF0CHjCPLkDLUPMcFaj0AEhZM8OYjDL+IJEkmWsRozZ/672EzV?=
 =?us-ascii?Q?+e7B2fSsvBEehV/dwkJzDFkm3oFKpST6WGTIY5YzmpY3ZvLrfcPl8TgKwsxi?=
 =?us-ascii?Q?0tkVpsxaLVPAhrctUcYgRkmu5L0dpIEyLAlHLDeMfe//Lesmn1Mk+3NTGaSx?=
 =?us-ascii?Q?8X0XfnrBFJ6VGXhN8GxV0Gu6KHogqrViJHsCGbJwYGlIdwG337LrxBGCLwKQ?=
 =?us-ascii?Q?+Fk5PhZzPV/I8Gjw8s/bgqbhjI/N08W6+1Mdu6HK097YmkFWANF4lxm9KX7H?=
 =?us-ascii?Q?hr4pe6wseGtUt0uXnpAu4DOYJm2OJlVipjQpePNjIVWkzX0TiJfQBsS3dgwE?=
 =?us-ascii?Q?AUPQypPACd3U/hY9PYbDjSP6AqXbBp8x2d3rGWxqi6C85c11d/s2hgN9Qp0o?=
 =?us-ascii?Q?sFSQoxeFqPws+iRACYCiZomkg56uDA2/D9QdnbSAyYgWZUMKGYEObad9Ifio?=
 =?us-ascii?Q?bbkI0fa3uSyVm5DtRYuKmrF0LOH0ZvarkM2ZmI+HhzmaRtqJnroiT4IOXhbR?=
 =?us-ascii?Q?IRKhqsLR+3/3gso7t6yNGT1MRaRcP7uu8hv1xudsij3rF/H1r1LHuyqkWIjr?=
 =?us-ascii?Q?tubG/CyYQNBz4gPMjpInb4ZqsqLOGJarNDKQn1mZZ58kIMFt1YjiIodkI6ni?=
 =?us-ascii?Q?OQ5vNOkTzRCYzVfIBS7Kt0a1LLk/WYUWTg2A1VTHsdUxr5ntD0qz11LC55YS?=
 =?us-ascii?Q?VmqOSpCmMZkKIbUwJZ0deAnJ3HRHswLHYYTKHprT141nai/Y0wmVGWtMKP74?=
 =?us-ascii?Q?r1590o8/dISDe6pFJHdAsgYPOj8Q6xx2nt1Xt1lCuasPZ0bcJLBz8uXAydub?=
 =?us-ascii?Q?btSksZbkF52wZgv/jxBQbfAMyjL6J7BuLiLTNyn6LI8l2jYdUqO0WWiUoHVe?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bucDxoom6Z15vcaPfAbIe1Z1dOMpgr37PD6YG+ZhhdSBFh5SIGJi5wRTD97sNb4fyWQDAdirPm4ks4QUOgkbHqR358LnG6t9KrDEdGE4OLbY2hZ7AA1fLoy8K/YGLl9IkBWHFx17zghhyd/7Sxj/tkj+aO/T8LlUZNMpQWxJjuZ68SGg9hzeX4XfvXYIlnx3TUcRTlcDV56mfg+dMhhFwknvAIwq7gjpDrcILtdAAn1rX30Dmpoi1v4reuYiqfmwtLUGTMAuNgp6t0CRWuWUj1Oir4KFkQjLC1BB7zjJguHW6Yt7BjGjga2NrDsDn5EBgTIvrK0K6Uq0B2MjuXcZg8FK2Dps16T2uE+6AZKa5B6InhqiCK7SdeQuEH0OZ/qHggGnNDJyqiZ68im3M5LTT56LwKTj47L/bSKxUmlwtIyU5O2XAY3787kr5ZzsJg2dTmtanuEi3rS3X+A+9v1hR02ipxG+VwXEM6dHJ6nShkVbcWfz5+4NFeaQcoukrQ1cVqmevd35U5ZNioYHj1QfgSAKYluX2RUk6rmiq27fwQwUmLbZ6GJODfXAJYM5mCWcNODJEdUsN8l8FGYcJ7IkXvMDkBPTU1jKxkG+agBxAlrm1HpDJs5oVGT4TR7xtHtR
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4aa08a3-95c4-40c5-4aa8-08dcf1ba8e0c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:24:33.0443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMmG549HmD8X+Q9S0DGLfDKMsztAkD10t1ELA6YD4crH9zcJnErjpyt0QQSYWHu97wYdrgi+NstM4TNHzX048A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9051
X-MDID: 1729506274-pFf_MJ8A2d53
X-MDID-O:
 eu1;fra;1729506274;pFf_MJ8A2d53;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Introduce neigh_for_each_in_bucket in neighbour.h, to help iterate over
the neighbour table more succinctly.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 0402447854c7..69aaacd1419f 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -277,6 +277,10 @@ static inline void *neighbour_priv(const struct neighbour *n)
 
 extern const struct nla_policy nda_policy[];
 
+#define neigh_for_each_in_bucket(pos, head) hlist_for_each_entry(pos, head, hash)
+#define neigh_for_each_in_bucket_safe(pos, tmp, head) \
+	hlist_for_each_entry_safe(pos, tmp, head, hash)
+
 static inline bool neigh_key_eq32(const struct neighbour *n, const void *pkey)
 {
 	return *(const u32 *)n->primary_key == *(const u32 *)pkey;
-- 
2.46.0


