Return-Path: <netdev+bounces-257063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGXhHtZchGmn2gMAu9opvQ
	(envelope-from <netdev+bounces-257063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:03:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 239B7F03C9
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D61A3051EFC
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823083A4F26;
	Thu,  5 Feb 2026 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="moSCj/J5"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011054.outbound.protection.outlook.com [40.107.130.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0533E3A1E95;
	Thu,  5 Feb 2026 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281829; cv=fail; b=CWRPnN1X8U3xPFTnQhDdkjBQ1H6OwnH5dvtjmyuZ5Ua9JEC4xNJT4Z5OlJ8tFtOc3isBN8t/14TpvVUM57JhOfLownMuzj1sf134f/r0EwJE+RP3e0BhQHt1aIOMgTvRsfT6WZ9DGwRZooJCJqAsiiSoc+O0zDP9dnM1IZjiHs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281829; c=relaxed/simple;
	bh=WhawLjvHshSyQFTCk9pZvNSLBjvSFl3JuPBWu9e8XlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NU32/v3jMoe8AoWQi6GFyzWtq/MHsyN2H8YVpCBOqb8NoXuUq9eC9+sfLdkfxpD7XGwnuETWrCuvjGqedzLnKEjCmc3SRg/l14zh/kye+qPxvcKlDowYXe17zqXD6XrR8wZAoGowIjLCGN2ImOoQlCQuXzhyXM5+iMZ9MYaf35A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=moSCj/J5; arc=fail smtp.client-ip=40.107.130.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dre+rBWFusZjXzxcVTD9qrvn4XcOg7vVZo9NCxKJFTXf6rTRMm4Z6PfN5a4PIUGBNTwjHQyWoijOHTX5kmRHnjSOi4YhZAJF1oMhw3Skj06MPbrFk0bTyZ7Vun10Z2EWNVfEybCiRvq+3F0KOtubt88S48kKHhgBCHKiUS9cNfCEzt5rpHTUfz57e/0lWYvZKx6rDTblBnG6LVH8NhC8ebgOL2tyF/+XkTeQ99EsxxAYXsHAGFDyS65eLcauNLunhfsi6ytU9BLkppX89rh8G4NCVx7KnHaygfU3AJmHb/JVGdwKltgvIOey7V1XT70NLJ5DzYqDZdhXlR8a0NT8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnHdc52lWB5AtPJz2IiG7w0eEKT7WK7rI9hv2lkYUdk=;
 b=Floyq+iF9B/++BBpYYWZVsftGKCNYbdnKWivh8+0wICcJB2iKHkgsEw9lVJpi4PYN64+uZ4ZqsAWpRUUf2VoXbtGo/HP0+84BZuCp83ylRqVned0kSzbzZk0k+xbdWF7ujckshihwOzHv0JCTNUzZSsc9Nmq3YU1eqpNEhz+t6XTeT7nmMgD/1n7NCn4rAIAy3lFBUtNF2v0Bf4XNbrNSaPfvOjc7YKO/B3/OXQA3zNarXOPw2pgmMGjrGakKFRG3QE44AtEuthM7Ym1ANLLNQMfGKdVMPvWwjUCtuapOHOJ8FpTXFmX95Re3mZ0t1Df6rkcl6FpWfPgVCUC3XsVKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnHdc52lWB5AtPJz2IiG7w0eEKT7WK7rI9hv2lkYUdk=;
 b=moSCj/J5eyF5KZLGllXjKNhwORNGqBgxF1ZGYkYNGvU25fNrlgYKCE1oypgN45XiLr6PSIT/6+gxkuQsKD8s2934KPUYLaAh3RaMfi72zDy520wDVDhmIikvdPTSwg3HbgHeTDEHew6AGOmVMs4nzZoje+/gongc1Vt7T4iCADQU4hHtrNXlwWhvyz1sZDLt80GK3gIpTuoLe9XJjxJHStIzaEZ5HlnHwdbQVvUEN6HwHcaLqgNIa5LRi7EjZtOGMiduwchTis5vulqEomvzCINtKe/AVcI2R9HuTA2gLDyRWlFsx5pMjxG+gwG0FE2blSzOZVzCsn4+l1nrjxhFAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:57:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:57:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v7 net-next 10/15] net: fec: use switch statement to check the type of tx_buf
Date: Thu,  5 Feb 2026 16:57:37 +0800
Message-Id: <20260205085742.2685134-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205085742.2685134-1-wei.fang@nxp.com>
References: <20260205085742.2685134-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAWPR04MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b269b1-9832-4792-0220-08de64948975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MGS4gsxt3meLkV5JY6PyULD9oO+saLBnU50vyElBq8abkv3blnHrVDYKMrKK?=
 =?us-ascii?Q?Jgu2KqfXoE1qJmPS5avcIMurA2zF6EuwQTJkgtB3PiNnkJz7AQmkXIDs8vHa?=
 =?us-ascii?Q?VqR5WDpn2lO2mVwauT347Q+1rao8gbWv66aFXfbjXThuOoAa8Oa4XZFZyV78?=
 =?us-ascii?Q?khb5lW/e9CKak0g2jxUNPKhVGdng+eboB5yyEW0upNZWTyH1Lkb/0v5oYrkT?=
 =?us-ascii?Q?yNdgvdE9agLyKAEJyJm8+jXWiaoS5RuZ9NLkKRXYFQnKud8+WnzwWT5AKSjM?=
 =?us-ascii?Q?smezroorDceL8WJKb5gAEm0tunCkR0Yhj2lHd7CVi3Fq1QYiY790sGsx8rDg?=
 =?us-ascii?Q?Zs7ZqypLkYaMVwbDmaycEnxyvfFla4oO0Z4aJVV065UiRyGlUHpOxUww9SH+?=
 =?us-ascii?Q?YcBXJFSWwFwUfwWOPFdeFhnSJc7VQ3UM0raF/Scu8Yn7N5hGB1RuNf1LL0JL?=
 =?us-ascii?Q?Ibpsi1lgDfdRIzWrFNthNcqcnMm+SbJE8b/eMYiKlvto8khuNrMvnNWc/Qn/?=
 =?us-ascii?Q?R467Gm+umGrfu9hm+z1kagSxAcZL0s95XYmj12o/vqYBKZ1I/tJ/ZZ5sCcJh?=
 =?us-ascii?Q?xDjyd88anpfEKzCC3aH5tPJeX4l4coreI3JGkHWHz+eDXcQLWiOyWH52a6Ne?=
 =?us-ascii?Q?VI6bAwfiksssjrB6I8GHKyanJvothvmpfjmVw0g6bTQ6TRt4aTnYkVF/HnLd?=
 =?us-ascii?Q?LUvBI54QhTIim24NSt0ukVcmrRQCReRtT/67eEGirD36UwlAF2TaQ2Vemv4m?=
 =?us-ascii?Q?bNoBD1lEHr/P0NhtMsKLXSqaJkOGib8iCbQWrfmcmvLAnAPdGfm1+w2MEQIL?=
 =?us-ascii?Q?hoBe6crV8AbUUtGagKuoBi9k8At22ZboAn6Jizo7UrzvYPr6RkNV/0GlksFf?=
 =?us-ascii?Q?Os2H10PcTLeiS3+bN/mk9gCt3p1JR7Qu1X/bSVXiSW1y0KdvT8ia4qXRZG3C?=
 =?us-ascii?Q?x0DZHGejtQqw/XxmlIneLRN7M8s5DgPxMrhvapm8d2TkVw/yms+2Yuz5m0Tc?=
 =?us-ascii?Q?NyytOCw8712v+WZhtx2AGlpPZ6ApfrjOKzIAavLzSISFdDt+AKZJEMGVKvHR?=
 =?us-ascii?Q?iyDxraE8nYounivW723eP1819eCGEAFFumlUWRov40StQPvli/tPLv8aiUOj?=
 =?us-ascii?Q?mzR9542KH6wrb9VBA8PrxrppYJymn0hMdWq6FW4xsPFb8R5s+e0U4zh4MXQ1?=
 =?us-ascii?Q?A2OolfSlTJ7Cfjt58zb+QqgH2NKB156tQgbisQTD+RIeQzVD+bI/XPJda5ul?=
 =?us-ascii?Q?cR/ihHAXS38A1P8kg7HrUoESxuIWDKLqqFXUtPE+ySKoZ/tjs+x7yye1bHAq?=
 =?us-ascii?Q?ZwyuPU7xCKSYEEy5TQJ478y4PBrSpXYEDh23PQV6GVNY91l1IyJbhjPAMWWH?=
 =?us-ascii?Q?RG6uKt4aCTmp7owJBnK8fBbxPtWRth69ayk4RjJ3CFClEVBOFWcbryEUPpYP?=
 =?us-ascii?Q?lmUHz39ISRmCIiY+g8IMoAph3Gvi8OzEXMzFMNYRI1esFpNbb8E7wSTdANGe?=
 =?us-ascii?Q?efhwf8whuHjDfLrjkfs5+B1frnjvD57CuTgRM/OR55YJSZ64cD8oNPeIm1x5?=
 =?us-ascii?Q?UWWJFl1SdwAdcP/VSZ2ll9kNfopZAayAln1PWItH/Z5Lb98tgiiWNEvr6cOb?=
 =?us-ascii?Q?Qp0NSA1J/eKtBxdqUU22rlc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BNNc/hhcjgG69C9PRQw5sKz0HrhMfIR5cfN4uv+aZQ3nQCinMVdYJHlG07R1?=
 =?us-ascii?Q?oy8ZAOEq/pnctC8ACCZFIVAVRH7PaWyaBmB6bGEECeMfzn+GN2n2FLNacW6r?=
 =?us-ascii?Q?yJuZbO0eYa40kANXJOMhjeU+kk5swtoCgOY1oLQ88N+ssXp0Q80IWH8xm2dC?=
 =?us-ascii?Q?Xc8s1rOq4i2YgehZo7C2noBYCLGxZDQOYOZLnN7o78Z7D/yi2+rvyWCxJ6U1?=
 =?us-ascii?Q?ovfs1Vs0YnCW9q06NKkZFVBbP7VEVByTB/tyyjefKkgeyY0Apsmy8KUDlwEN?=
 =?us-ascii?Q?0Eb5/ciq2OPMNVbCI88qw3+U8BaxWYeKfCWi49a3jNTPpS8vqXXZ34fZIQ1z?=
 =?us-ascii?Q?dMFa8j+49+CiOzzhwxWr3NfK+S+j/+EwcbcV2CjypZxrPqpEG+iz21o6WQbO?=
 =?us-ascii?Q?n/gRHBHCHInoQhOpwtsf4xCz3XRdroNKbzkyB3NYS5RoZnqi0fuhBMeNuRfT?=
 =?us-ascii?Q?fKIB+OwyhgCMnGGIYiV72NrJgY/5oy94jlAq4PHFOzP1itaX+DQphkc4FVYi?=
 =?us-ascii?Q?Z7W0R244eQo+WBR6UEjMe9t2oTreD6GNQnwe9HbXxQp0CiPaZhqeXVk5YHAx?=
 =?us-ascii?Q?kF+l0ZqkexIg70JaZz3I57rGd6NKcCv0QhY1lh0Uk/M4VmnBaCWlhWmaAIiK?=
 =?us-ascii?Q?eHubUYzCYRxMKrbzeFI0aMFCURbtp/N7w0jZEqps3NuxLtYU/iONy0LkMaCA?=
 =?us-ascii?Q?jGrIDvOeHmFc3Z/3n9bG9rYHj370iBwlfKgzYqKNwp7BbGKaAJt9NG/T/cCM?=
 =?us-ascii?Q?D1UL++4s81ZoRTAMuzwZQH1BJXYR9pgNqxkZYNwWG35RuzfOZKsnw052nVek?=
 =?us-ascii?Q?K9qzSsCWvJ3UHypQiBoBeCsBp8wYhhAlC8ZdKIvBaEWLBVP6NYwD7iTmV2c3?=
 =?us-ascii?Q?hAGqNZJhrX7CiFmaGNrHIXdbAwAfsk748hpXe6fokPJjWQbmy7jWGTjVKq3o?=
 =?us-ascii?Q?z5ZmXxiz9TJ+c8efi9qtBjns/p477Kws7O1KrYpykZNYJzLhdeFs41nSS3h7?=
 =?us-ascii?Q?3OEUWECDLo85ElTQzGGBYRKf8zlOD3Nd27wsCdkvT1vR0UlZwN0aH1r67mxd?=
 =?us-ascii?Q?VPGG5+QLr6izPWGfiYKubcThGQ45cWMQ9vmT1yv3hG7lXCeeBs3ok8GHe+Uo?=
 =?us-ascii?Q?CKHdIsI4n3bqOC/C5jIoIIrcnEQH56w9XA8S7APmfa2aUfzJdfIF9Y/UwGH4?=
 =?us-ascii?Q?F2QNV4g7jJTnWRbpGnJgxY+ecMQZDbVa/VCyYdsdXIXzWVXJccxFzsaHdolZ?=
 =?us-ascii?Q?hY5mVGlc+nfuGmb93N4vxWcDV0b9dcXExzN1qbbtXHP7XsRUFRtb76zD/eTa?=
 =?us-ascii?Q?va4vXDpo3vahXp5h5c/K2i637PNEiRuPm+eE7VA2G5kHftXlgfWjDfKnCUwO?=
 =?us-ascii?Q?Lp49cxYCrmwAf/U4h99EOkcFQXNbPGSjMjKNsO8cctkjwq3MrqoAqj8Zcyvq?=
 =?us-ascii?Q?oXJauZ/z4ZTAxQwN13jsWxLNMZfE2n1UPEZP9KQ7qyB5gdTSilMl9pXCbDiX?=
 =?us-ascii?Q?p5qE5imrpMAN5sYDTuKwvdl1O6+qCthGibtzQbzIGugTYAaoaFdPXP7c0ER3?=
 =?us-ascii?Q?rDLs1KbNY7DuB1HKXYsbAfKSXQJw4f4JRcht9MTuQkRRtXhVq0iuLr7LRBIW?=
 =?us-ascii?Q?RIrBx3gq3Q+sXvU7tzZypt7nZ0j0SfVX7C42LEQFw4KvBZ2Qxa8ihNIelpBN?=
 =?us-ascii?Q?D6he5Ucghw9NfpTo1PqsaMy4KDFjEKnJNhCOJ6VtiL54y1/AcmpPjXI3a3ih?=
 =?us-ascii?Q?DdLh0oSO9w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b269b1-9832-4792-0220-08de64948975
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:57:06.0101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rAxHXSvn/pzCH+Y8iHONIYVeP3lfz3YQA9XKpiGUB7Xrc77dIdWmtHe3OjoYuYQoCsBfPt4pLhF8dSqdMzzbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-257063-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 239B7F03C9
X-Rspamd-Action: no action

The tx_buf has three types: FEC_TXBUF_T_SKB, FEC_TXBUF_T_XDP_NDO and
FEC_TXBUF_T_XDP_TX. Currently, the driver uses 'if...else...' statements
to check the type and perform the corresponding processing. This is very
detrimental to future expansion. To support AF_XDP zero-copy mode, two
new types will be added in the future, continuing to use 'if...else...'
would be a very bad coding style. So the 'if...else...' statements in
the current driver are replaced with switch statements.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 134 ++++++++++++----------
 1 file changed, 73 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1b4ce004ae46..80fcac0f342f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1023,9 +1023,13 @@ static void fec_enet_bd_init(struct net_device *dev)
 		txq->bd.cur = bdp;
 
 		for (i = 0; i < txq->bd.ring_size; i++) {
+			struct page *page;
+
 			/* Initialize the BD for every fragment in the page. */
 			bdp->cbd_sc = cpu_to_fec16(0);
-			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+
+			switch (txq->tx_buf[i].type) {
+			case FEC_TXBUF_T_SKB:
 				if (bdp->cbd_bufaddr &&
 				    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
 					dma_unmap_single(&fep->pdev->dev,
@@ -1033,18 +1037,21 @@ static void fec_enet_bd_init(struct net_device *dev)
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
 				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
-			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				break;
+			case FEC_TXBUF_T_XDP_NDO:
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
 						 fec16_to_cpu(bdp->cbd_datlen),
 						 DMA_TO_DEVICE);
-
 				xdp_return_frame(txq->tx_buf[i].buf_p);
-			} else {
-				struct page *page = txq->tx_buf[i].buf_p;
-
+				break;
+			case FEC_TXBUF_T_XDP_TX:
+				page = txq->tx_buf[i].buf_p;
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
+				break;
+			default:
+				break;
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1510,39 +1517,69 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		frame_len = fec16_to_cpu(bdp->cbd_datlen);
 
-		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			skb = txq->tx_buf[index].buf_p;
+		switch (txq->tx_buf[index].type) {
+		case FEC_TXBUF_T_SKB:
 			if (bdp->cbd_bufaddr &&
 			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
+						 frame_len, DMA_TO_DEVICE);
+
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			skb = txq->tx_buf[index].buf_p;
 			if (!skb)
 				goto tx_buf_done;
-		} else {
+
+			frame_len = skb->len;
+
+			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
+			 * are to time stamp the packet, so we still need to check time
+			 * stamping enabled flag.
+			 */
+			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
+				     fep->hwts_tx_en) && fep->bufdesc_ex) {
+				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+				struct skb_shared_hwtstamps shhwtstamps;
+
+				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
+				skb_tstamp_tx(skb, &shhwtstamps);
+			}
+
+			/* Free the sk buffer associated with this last transmit */
+			napi_consume_skb(skb, budget);
+			break;
+		case FEC_TXBUF_T_XDP_NDO:
 			/* Tx processing cannot call any XDP (or page pool) APIs if
 			 * the "budget" is 0. Because NAPI is called with budget of
 			 * 0 (such as netpoll) indicates we may be in an IRQ context,
 			 * however, we can't use the page pool from IRQ context.
 			 */
 			if (unlikely(!budget))
-				break;
+				goto out;
 
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-				xdpf = txq->tx_buf[index].buf_p;
-				dma_unmap_single(&fep->pdev->dev,
-						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
-			} else {
-				page = txq->tx_buf[index].buf_p;
-			}
+			xdpf = txq->tx_buf[index].buf_p;
+			dma_unmap_single(&fep->pdev->dev,
+					 fec32_to_cpu(bdp->cbd_bufaddr),
+					 frame_len,  DMA_TO_DEVICE);
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			xdp_return_frame_rx_napi(xdpf);
+			break;
+		case FEC_TXBUF_T_XDP_TX:
+			if (unlikely(!budget))
+				goto out;
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			frame_len = fec16_to_cpu(bdp->cbd_datlen);
+			page = txq->tx_buf[index].buf_p;
+			/* The dma_sync_size = 0 as XDP_TX has already synced
+			 * DMA for_device
+			 */
+			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
+					   0, true);
+			break;
+		default:
+			break;
 		}
 
 		/* Check for errors. */
@@ -1562,11 +1599,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				ndev->stats.tx_carrier_errors++;
 		} else {
 			ndev->stats.tx_packets++;
-
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB)
-				ndev->stats.tx_bytes += skb->len;
-			else
-				ndev->stats.tx_bytes += frame_len;
+			ndev->stats.tx_bytes += frame_len;
 		}
 
 		/* Deferred means some collisions occurred during transmit,
@@ -1575,30 +1608,6 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
-			 * are to time stamp the packet, so we still need to check time
-			 * stamping enabled flag.
-			 */
-			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
-				     fep->hwts_tx_en) && fep->bufdesc_ex) {
-				struct skb_shared_hwtstamps shhwtstamps;
-				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-
-				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
-				skb_tstamp_tx(skb, &shhwtstamps);
-			}
-
-			/* Free the sk buffer associated with this last transmit */
-			napi_consume_skb(skb, budget);
-		} else if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-			xdp_return_frame_rx_napi(xdpf);
-		} else { /* recycle pages of XDP_TX frames */
-			/* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
-			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
-					   0, true);
-		}
-
 		txq->tx_buf[index].buf_p = NULL;
 		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
 		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
@@ -1622,6 +1631,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		}
 	}
 
+out:
+
 	/* ERR006358: Keep the transmitter going */
 	if (bdp != txq->bd.cur &&
 	    readl(txq->bd.reg_desc_active) == 0)
@@ -3415,6 +3426,7 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	unsigned int i;
 	struct fec_enet_priv_tx_q *txq;
 	struct fec_enet_priv_rx_q *rxq;
+	struct page *page;
 	unsigned int q;
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
@@ -3438,20 +3450,20 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 			kfree(txq->tx_bounce[i]);
 			txq->tx_bounce[i] = NULL;
 
-			if (!txq->tx_buf[i].buf_p) {
-				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
-				continue;
-			}
-
-			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+			switch (txq->tx_buf[i].type) {
+			case FEC_TXBUF_T_SKB:
 				dev_kfree_skb(txq->tx_buf[i].buf_p);
-			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				break;
+			case FEC_TXBUF_T_XDP_NDO:
 				xdp_return_frame(txq->tx_buf[i].buf_p);
-			} else {
-				struct page *page = txq->tx_buf[i].buf_p;
-
+				break;
+			case FEC_TXBUF_T_XDP_TX:
+				page = txq->tx_buf[i].buf_p;
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
+				break;
+			default:
+				break;
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
-- 
2.34.1


