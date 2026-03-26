Return-Path: <netdev+bounces-271911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHG2C+blxGnz4gQAu9opvQ
	(envelope-from <netdev+bounces-271911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:53:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A726330A9A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95B7430388A9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED0C34B43F;
	Thu, 26 Mar 2026 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OGd8vzxe"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633A34D4DC;
	Thu, 26 Mar 2026 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511445; cv=fail; b=Ay/aT9NqwlmW9VYqaqSe3wOOk9bbw0dBn+6xaMrXAj31y76ZlxVFpuJHVOAV81yo983LJv2x5N27U6YZ0h1mUa5osfhJM8MsgXWcAOzrl9LEOi35Rv5t5FO8EsyIuXB74kiZrrR5rZNyy+e+fTCFNintcW50cNzpmPxQzUqq58k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511445; c=relaxed/simple;
	bh=BuSLtCCDvqJwF+WxE+TYsSaR+OO2BZrrcqxFDK0+Nm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aZlTVAThrGugjraf33ekjkXQ5IEl2p4LlKBlRzNwRAZt29PLSD6hAFkczn6IlOaSnILpF0I7tZOVq2lq4pJB2n8dzuJrwA4967Bl10uZYBKeip5BOQBBILhyzeDRnqmS0AbFNakG1RPfBsfl0cFx0E2uz2YHytw+TjbCiEUV9IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OGd8vzxe; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYpryEEQDinEvTpbqzzUyEaosOHmyuPqCvBSYIi1Y9IGm8rxDyGE33gYAgUKmfBsAx8id2k+pGV30FPNYQ8bdS/v2dkmVcPiIP9dV1e9oLqfkL6VI7wBpJF3vpt0Zwr9vAU5Pv1dFTKOrHIv3alQ3Y5oy0FnNIm3EpB9H+iKfVMdl0mH+N8FEZpJ7uZgMBFqcsfs2fmzTplR+04t8aZNLZGjD6Z4Srvgzf4L6ElCLw/Mqkv7Ml2I0zvb39RFM1hsFmoopL7eooIzzjY64cp7A8WPHubJtjjnHqSDvIIry0XMdRVB+NQy78tVJ/Qb4NLbLjBZPKSmovKBZWkcBB3JYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiISFXd5g3ogIc3rTnskRQpOZ409Qyf17izqY0oSUqQ=;
 b=Una1b7/rY/slMgGdiXtYWLrA/mnTloVuIVJr9uAKBymGfQNrxkpSmJPl/CZu52AVoKfIh8PmXuNwnc1TWBJKP3ALCrkgDtcKDkcjkO7L/QJO9MIBQvNOXbLtB//W4m0tjLES25SKHL/VgLmG+YAIjsgSNZb+m6eGVSlRudWBuUAMw2ICwAIxV+Q3LPcBLeAnGqBy+5y2rEqtCD7GUEYkX311GNhHACHLm8oR8Xmf7cHrt5re5dgZlTbjESQH9sqc5QS010ysEg1yKVgcuQqx3ubB6NAIwszTi9y5DMOk+rF3zVbl/dQhEi2wBHSVfkbfC94sdAa1v7L0NyjRjDlOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiISFXd5g3ogIc3rTnskRQpOZ409Qyf17izqY0oSUqQ=;
 b=OGd8vzxee+Mv7cLdxJ3NtCV7UfbqsFfeRiPwJqypDObikUvd+7zMsd79DtK321RszBwTblmlDuWiB0/xDjfx6uAS4rzWRDTxGK6nM49rtoKK5uESypdEaOzVpyrHxNUnJq2KvCEOOAQbzKXUm2XUdoY9hWA4QZYmJG5L49CLATT5h1lSpaTcBwGFyEAb9uSBXOAIBlAeyR7VkI8R9cPxkMZDwYGM6TtXleSOZsg4/q8AgiE1STBlPhHn2NW3YV/50/hMQz2cJdjMxNbJsQdWRwMc8gtMoz+GylCUWlCvO70zCBqR2atn+QJwdxiom5B8VSy/kgzb+5bbNUkv6YBlMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AMBPR04MB12282.eurprd04.prod.outlook.com (2603:10a6:20b:720::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Thu, 26 Mar
 2026 07:50:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 07:50:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexandru.marginean@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net 2/2] net: enetc: do not allow VF to configure the RSS key
Date: Thu, 26 Mar 2026 15:52:33 +0800
Message-Id: <20260326075233.3628047-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326075233.3628047-1-wei.fang@nxp.com>
References: <20260326075233.3628047-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AMBPR04MB12282:EE_
X-MS-Office365-Filtering-Correlation-Id: af2ecd3a-e7c2-4445-4841-08de8b0c6071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	zybG2ZC+SOY7WnCSbudCc3lEGDl113ds1rPHhXP4vJGx8IoVDhHwvmXAXv73pqWuZTnIBljblS2izKBewkYw/owVxTx7wjXU4MIt2WJ+IeIBFqvTJ+99vIYJi/PBsoqEIExmKkGKAlh+GBqu0MxxV0di4Vb4srjXpfm9As2webkA1yjKhYA69PJ0Zt736iLcGxAW2jKFLUH2ajwB5MSONW0BYFgwuSCIxMH3VX1uqI5dZokVFpFx/2UB2ZmBCpid8FHdoKZ5MEIwJ3LOpWw7QWhUYCefg3UTkySmsQ54NfuF/28YJ6WWBUaCWzH3f556Wof9lWR9D9dDFhCbzEW/8oeoYVXS0UKJWg3PHt4ZsqW9qYiGco/E8abSlNSwGHwdcmeGnQeer3whkvCzIDXmqNuOvqH2imWed+IMdI1u21DJeyznEjbUxpXLdTIq8gwplGujBLGI9UzRdWZ5W7ZGPp7/SLDJAeQbLJA0dBNovv5o0dkkIIDIG5hAXxfGNcPeJ+0zienSP0O1gExgCzdyR+siDNYYm/LHgbBAlGCC/PWyrQR1AVE41aDXbadPTSvood9bWFe7yYbhV9tlDAUgcqxtBCpeNNEY/ZiI5+90a6vx4x+5w+xCOeoLfSAl4yfVg2WsN4IlUS/llO7ho1KfNifX1jeuK6Jg0Uo7Un5SA+MDIHzPLVX7T7SPUo335zSeImulv7lR0SeUItxKxnJxN7787ONYoIa7PLHEZv4KD0Pp/3HDsC3p9veUx9gTYcr2q2Y/cmkDMyi/ObcmEyrC27hH9YdccD2jngdkR2qohIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sJ//W6S8DFcyGzSg2LovxVWXttS6FSIX1+laC+KV17t90s4Ort2lG3Mhdb6j?=
 =?us-ascii?Q?erW8xpd2WwbvFQbI62HwBbvf1yTLoHtWeFJjM/O3hj++XwuzAFc2G7LKS15K?=
 =?us-ascii?Q?Bxh4U6KeQsY3vznUyyLqejPV8310TNmZnrLTb6/9d8FJDfRV/8H9mDK5xUpz?=
 =?us-ascii?Q?/sm9wo5axeZb5LDW7cpykvRUr0KHmE6GpmmdlwQU7UApR8I2Izzh7njuasT3?=
 =?us-ascii?Q?WY5hhpMXIS1XDvuR2RGewjULnAJj16ZDEgYp4aSV/5I4qUHptlpz3JlD9rbX?=
 =?us-ascii?Q?2Au4WYQgQFaRhY9Y4wYkN045+o5KswGhepf8pRzBEPuejDp9c+8nxF/yeD51?=
 =?us-ascii?Q?OolRG9WnHtU79U3hSocuZm3O6MPllRk/qo97LdeFcTB0YPnwz7rVA06fJPHi?=
 =?us-ascii?Q?K1/+XbsydJ8UonnmzP/hvzB+FCMvIeHXtej5bDfBIuJ1FvKFtAGLmaPOupQi?=
 =?us-ascii?Q?54GbD5M7qNWimDToA64ias5OrO7Mrshi8jA+p0lMFtObCmV1VQxPPkhS7DoP?=
 =?us-ascii?Q?YC0PyYbmfrtxy+Y9IeUIViO/g21L+ziI+4dpzsQPvnahA85JrmgsZ2cHWqEF?=
 =?us-ascii?Q?F1NRar22FImY1EJSwIAHfoTG0ZHa9C37747NyCi2lxx4zbIe49qh75pKvncE?=
 =?us-ascii?Q?Np56RJ47r1cSADOlC5PuV4hT5bRjVGjmS7aQVV+EbaJJtFJoeA6qYm6XY55e?=
 =?us-ascii?Q?9D6i/SqP5crpjm7++xzsl7DV6QCtNN16QJPtTEd0i/f8ZhGq7cVC8gWcmYOY?=
 =?us-ascii?Q?93kcRhe3Iq+Q57Tl97jI0RFM6gAjEv7EzINwD4DAkWNPSm/4ry5Wur7Bwt6b?=
 =?us-ascii?Q?u5+2mF+aM924J1NRxqvmYAzOHwJsUdpPckZaI8WWK++BXVIvaCAXyg9+Ys/6?=
 =?us-ascii?Q?tQXAoJ87G5wP7UGOsbX+K71yiBCpETctriqu2zLehGIIFMPfzxEmMX4c6B50?=
 =?us-ascii?Q?FjSfJa1J83IUgctWnSijI9ERn94E90s2+dokY/Dg32KvTxZBy8CYS5ujJMnm?=
 =?us-ascii?Q?Wlp/OAqGhkjVKVHU+6CxW2y1IMkf4wDjCcsqeoY4hTrzFTBz8ssLRPo07Vkr?=
 =?us-ascii?Q?Gj42SETYCiJuzyVtpCpJzyXRlYiYe8bnSkaJoEuSduo7UqWLitRJh8tpvP21?=
 =?us-ascii?Q?I/BciMIfVaMlEqJ6DaI+cavSWKeedZI5Bx7LySsEXGaM53vvqT3FZr2K0LIS?=
 =?us-ascii?Q?lkGU+I+4LegbH+XYYFQXzNHMOmWsbMiFRASS3li9e//uOBOv1nfOXQtnZAwH?=
 =?us-ascii?Q?bdt2c+WEqLOE0pyQJ87eyUULKzQfKoWCEr0SGmYLwZ6VaCbyOcT3bWidEjjq?=
 =?us-ascii?Q?F6wemelR/uGub2nWSQuCqpbRd81AKjkEZcTVnUwMk3KvRuaeG0nIf9pPzDQt?=
 =?us-ascii?Q?1Jex4f9P0M6BsvchywkAS8cBlCQKcrcI3qx/lXU6bLCKO3OdL1qX4HC6CqYk?=
 =?us-ascii?Q?mVbbwWOmJjCmPKxNi08uFl59D2djGhLbqYsrmPUa8w/vCyTF6m5fIV9CeCdQ?=
 =?us-ascii?Q?6B3+B0f24CN+woTZ89c981sdtklC2BEjr0wGhXXvk09xzeMwKBn+OpzzAhTr?=
 =?us-ascii?Q?/rlkE++xHlWcXeI0Hup0l50l7GtVRSuagznpOG0MQqZmveKzF58UE3vkkaxf?=
 =?us-ascii?Q?yHMIJ8/DoHMoYvbpl5OQOwwTBdF69NYRUqufuvfxDRGPvbhD41k3kp4LTsb9?=
 =?us-ascii?Q?SDIu/qKJbnHHt83iSy+iR6hVFnfbRz40MGmPNI1y8AnybCL/PFR9/LwlT5uY?=
 =?us-ascii?Q?QFHmGDutTg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2ecd3a-e7c2-4445-4841-08de8b0c6071
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:50:40.9991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWheJvJVg9Co8xr8/pD1VCvKRVzdO9k36cZ/T4F9ZDHagC1NvQ4kbhy4FdRkewBbzPi5OBKekoB2vjuxlYq6OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12282
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271911-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 4A726330A9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VFs do not have privilege to configure the RSS key because the registers
are owned by the PF. Currently, if VF attempts to configure the RSS key,
enetc_set_rxfh() simply skips the configuration and does not generate a
warning, which may mislead users into thinking the feature is supported.
To improve this situation, add a check to reject RSS key configuration
on VFs.

Fixes: d382563f541b ("enetc: Add RFS and RSS support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index a393647e6062..7c17acaf7a38 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -800,8 +800,12 @@ static int enetc_set_rxfh(struct net_device *ndev,
 		return -EOPNOTSUPP;
 
 	/* set hash key, if PF */
-	if (rxfh->key && enetc_si_is_pf(si))
+	if (rxfh->key) {
+		if (!enetc_si_is_pf(si))
+			return -EOPNOTSUPP;
+
 		enetc_set_rss_key(si, rxfh->key);
+	}
 
 	/* set RSS table */
 	if (rxfh->indir)
-- 
2.34.1


