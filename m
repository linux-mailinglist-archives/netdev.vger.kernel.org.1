Return-Path: <netdev+bounces-135436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB0499DEE0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9B7283ED1
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 06:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE08E18B468;
	Tue, 15 Oct 2024 06:57:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2135.outbound.protection.partner.outlook.cn [139.219.146.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F0B172BCE;
	Tue, 15 Oct 2024 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975466; cv=fail; b=fH8gQJG4Sirrk4keTjnUUcG5zECf6Cz/UNznu4Yr3Bpfcztc1kI8iej8B/JAmyi1bauhNJzTzdiQx5D5Dt4f7iAbDWcT+F8/le/7voGomH6b9dZ353xkACHj4KiXho99nOV39vqeARYRsfAb039/0GYPyQh+sEKmAmnHtvfoZos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975466; c=relaxed/simple;
	bh=wk6SGhY4UmcdxHBJVsuUKsiA1y5Qq17/sbM+OHGJ0Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gaNbR3Lkm97xDMWSjnNZmIqUVD8Owo+UxZH2oaMykB2McrRt/397jydz9zie4zxdQTEDexThaFyO+p2d+j528OIXZkylTaZH6j5HpOzCxcgJ5xDTvPp4bGe0aigy+Mv8EabMZgLeFqA+rtc7h9owCvopggrs0yi+E8BGduMWvtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boeOsfXMFu7dWcX8200DOucDx3scG0y0UXprSgzy2WIo8pfRofQdTlGkYmON9uRLsXf5Hrqelo7mvp9KRla64uz0oeRuYyk5mLFzr7oeBXsC5T68cva+prrClOR16gqht8MiSt9XcQovYz/Ev7l8kdxfmHb3oo19QDJ6ARELgBsKucWm6KrLFx1++qowS2fk+zcvCcbDO2wLc5LgkzMT/er3F4/04EpO1BviLkBG03ub++wcYh1wWGW5HZFUlhf9mk+eZx1CWeHTmf4qeO7GYVaKGnNUzlNUDfGjkjy9o2R+9ZGHbNbfe+YSTq8XcVIv3hZvjyivyaxGxlGVVrLXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu1wR6/gadFVIawqgqTcWO7etypJ28rrk8ErHDg/jiE=;
 b=bXOuBU/+ubV4j7Q8fW37KFSqybNxqER6XpU/UyNYiPXI/xDXPP4kRedRcXMJW6Y9Sbhiv1mU6uU+j361wwgAE11qSmMysIe+tynP5AEciA+PEdtLZlIZBoxIvbWCnZeL9BBEi3f1cMZnLqcZ2giSDDT4RYVhhSGstrMPJKgbZWvyhiqtdAFmPj0hbwwAerFC4eyOdJXR8Tu6jJENstNk0k8uIfU02b1LNYRzqfFwY87/zxVfLTATWTBJCabMDY43TR8cqAVe1uCWHHMQ5a0ClhXEw8upR6YPC6ZJFtcWvQFt0x+R7FMaxSSGc1Jp2xKK4FTRisn0/whCY1K1mmRa7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1075.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Tue, 15 Oct
 2024 06:57:35 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8048.013; Tue, 15 Oct 2024 06:57:35 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmai.com
Subject: [PATCH net-next 0/4] net: stmmac: dwmac4: Fixes and improvements
Date: Tue, 15 Oct 2024 14:57:04 +0800
Message-ID: <20241015065708.3465151-1-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB1075:EE_
X-MS-Office365-Filtering-Correlation-Id: 877cecb0-e763-4037-bfa7-08dcece6a5ef
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	78YuDZYLT5yFpfp1xqx7JFQ1f13M02O/q2I5sSsrFn0IrX8D3oo41Pue0tPp6jGe9wTQTdQqPbOg3QYVY0Aq22uLmHholZ5PlwtMoY+QNDUchNRbu9z17T4FTsVweJVtxO8z7VkNb2rWr0yZNldp4C+PSVe6/Un0lC5NhxKBVgBf6wz0UxiaC+azejv22QWPta3bjntH9zV2kcMiDu+LMZOdVyeaqtKmfY67UgeScY65MQ/xjegds2SaxZAVZ/wzkVeZ0Qdws3tfTaRWh1hrtGrGX8ECoc1P5eblm2ilZ+1CbVY6bSbsAu4mu2Ca93vTNnAh0NO2+5g20qTrytyYic6+nQ4WF3/6nCLNAs74lAERkfbw4E/gj8tcVOJSfbsjofqwFOW2Rmd31lxT76bnNaqBOy4l0ebLceuVbkHACSM1WcFxk/k+hmlpjvjGCBRRfK1aIGtCCf8JaiIEKQMPOuP7V5y79hIhzg4EUp60G0lzdOugFpt/8FKApFZ38DZJgJ4Ofl1Pwc0YBCnujQREOu916EDE7J0+H38zJQCxLNxSlrOWWlOjNh1gKvXaS4BchctsuUntOgB3dTB+bZRYI3u9sMTPzrIKNknhAX6/nwBKm8DlT9DrkJz0cH9ErdyR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4CNbJZsvSqrmNa1ZLyhUZFwoU71N/OtIjsvBbAPORemUHtz1kOvc7UsbmQlk?=
 =?us-ascii?Q?tmZSHnBKWoHJsBiH5kCVZtzE3aoQaodKYLhK/3Sik4foTpuwcQVwbd4FGVVG?=
 =?us-ascii?Q?jMe2xydQucuVQ3VPr4CFr3AgJM2hQJeG1IgGR0zX2/hbKgVmH1cf8wCuI/QL?=
 =?us-ascii?Q?Y2bMJK06KcFCKMpF0HCY0FbodwwGcco3l8O/tKa1COcyuAbtB6KlsytbmXDU?=
 =?us-ascii?Q?uSk9GTu25tzpgTtKkXryOtVh4dGzEMa4tEop+GS4m3FjB3gT6+FBjF/e5Hl0?=
 =?us-ascii?Q?hpDZ35lDjWdz9MCU5NRhw2GEq29yYLcS8qxtrj+rrGVLQFhc6k/8F0zW9dZa?=
 =?us-ascii?Q?pvd4iGHibUV64GHvEfVtmJ/3R1bRw2GVbH5rvgTEhZMhxiKpvyNH8ijpcuCP?=
 =?us-ascii?Q?G3H1Km8a33UQ/YaEZLdt1jLBTE51BVJipScmtenMj+BeODzjAar96l+9QiPK?=
 =?us-ascii?Q?WMrSrTO1w6KnFrbEfQraqAxXsMWLNCynjNm0h+4hJUX73BQd8CWdoMsm9z5K?=
 =?us-ascii?Q?FVii0hbBV50LnsK1FE2OzJIGFRILwG6hDhh4XMOm0zNHzXlaqCdNOMjNGLnz?=
 =?us-ascii?Q?vzgM/r+Z9YSIJM3T4e0TOOU5tFvcP4hf2xMeEaNOm4Bup3GOZYpXWet+C6aT?=
 =?us-ascii?Q?eYYnwKKAprupW+ue3Ef8qF2eNfyHg/CVnyfLqpCvk5gOKJiJ+5X61mLmBlUC?=
 =?us-ascii?Q?bODyaMhy4OBTE3GiCoe0GMMCqweHm/e4iqByDoLr592z+Tah3znWR+TCKGSX?=
 =?us-ascii?Q?ejkooqEvpXpJZIWU74QD/4l536oCECS0En9fA2VI6TqFe9r9jO00BNcm/WmI?=
 =?us-ascii?Q?Q8WqiYg+MYWtAZdR0YccYvj8+8F7DJJCgN3qGJ+FImvC8/G3eD6cvwxSDmCY?=
 =?us-ascii?Q?txnXl/dpBK7n5AwoMs5yEfqlpH35dYOm9DTbzPlCoxbufXVpC0r0A1/i3QNJ?=
 =?us-ascii?Q?BkQ4s0qRFQ6ayyMbqE8rw+D1/TGT/LhU9Xxir71GqZj1YPMYiZv57nIiKXcj?=
 =?us-ascii?Q?7C0ZbwTx9J1D60O6JPu47hnFMhHdLRgK31AuH8kA9gujCpZV2RW6+U3qjr5G?=
 =?us-ascii?Q?vp6MvPIjH/StVRCa9umryfc3s9/i/ENJGbzzK31T6bmxmMBzJ0hZjAMY83hw?=
 =?us-ascii?Q?+GRizfrRTjOpGxTMStAaJ0YHxQ/l9QYgaINu3R4oUAlk4BWb9rzBwKdUsmq7?=
 =?us-ascii?Q?C3p4huc7PAgcKKRtTmkEsFtUKLsXVeXcA3ubp8Elqb0S3+mTyWqzOC2wHV0H?=
 =?us-ascii?Q?vl3O8VcCbRD5Xs5Oh1Vzi2Bm6oshzuW8R9tA8upTFFbn2aiNXnvH2ZZ+7Jgf?=
 =?us-ascii?Q?P53nSzZ/0GI4sdXA4K1+fElvSOY26M7xcZldV8cXvsnW4Okh5wCnpiZ/q9s7?=
 =?us-ascii?Q?1pmNBCj2Yg5fx+Rt33H4ZeIWU/1gIGDwmKsfMnncAjbaLPon79oaD1Sk6JEh?=
 =?us-ascii?Q?jFNv54SQM9+2q+PPeCQVnOUSfFw0zw6LdPrDlBmQii4s0xq2kuA64/Cr93BE?=
 =?us-ascii?Q?LpmXa0SA51ucAoOFp1UqRZKxtfoxHVCXcqi5hT6jGYAlacoGZmqbLDtnlBwN?=
 =?us-ascii?Q?iMXShUzr3rTkWS7d8YTAibVQTwWKmzEFHGklpwoYnKi4sE0jWlwPqVAsIvRZ?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877cecb0-e763-4037-bfa7-08dcece6a5ef
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 06:57:35.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8C7q7avlCTBSET9deB/3dDokPoRE69M6C5/LibKyRgDjIU4Ha7rlUUg6MLuGXqXIwZVqDb9CCt4Ns+K8VW8dfs1PJ83b1TfkaHjoyVh1o/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1075

The first three patches fix bugs in the dwmac4 driver, while the fourth
patch adds register dump for the upper 32-bit DMA addresses.

Ley Foon Tan (4):
  net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC mask and shift macros
  net: stmmac: dwmac4: Fix the MTL_OP_MODE_*_MASK operation
  net: stmmac: dwmac4: Receive Watchdog Timeout is not in abnormal
    interrupt summary
  net: stmmac: dwmac4: Dump the DMA high address registers

 drivers/net/ethernet/stmicro/stmmac/dwmac4.h     |  4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 12 ++++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h |  2 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c |  6 ++++--
 4 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.34.1


