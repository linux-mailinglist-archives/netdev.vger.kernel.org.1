Return-Path: <netdev+bounces-257067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHSCNZxehGnS2gMAu9opvQ
	(envelope-from <netdev+bounces-257067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:10:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E317F05E7
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B44E6301D267
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 09:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7A73A9D80;
	Thu,  5 Feb 2026 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bdz1QTb2"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0223921DA;
	Thu,  5 Feb 2026 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281849; cv=fail; b=pP1Aj6XLyJuvope8lkO2Si6wb+jRvGWan+AkpdAyKO2lJucoeX6UOCoKXXMwAinI4Pk6K9kZyX+YMX+pQGNibN+F1Xo/u2JtGbEA2dyALt5/Ub6Cf+6zSGJv5IOcJAUI7Nl81t7kSjGmx2yJZmCCWtSpbVOxGENGYmvzR6OqtHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281849; c=relaxed/simple;
	bh=G6ZGkJqpmTQS70uHCvMhbvefJbWxcTmz2kcEJ44p5F8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kfeBJEREWhF+yEsVcD7/4ezx8FV/2aZwNy2VddyvYoWGtLor9bMBw4l9sBpR4hA4I0/toq3sQFUQvbvrfUWmjQmD1mz3ZlLiRRA1AtcIpkRfBGNpAJ0puAis9E1Pc8mKhJXe9Hpm0QRVFCoLu8s3zK0fMZrtUIxvLC5rDuKhhX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bdz1QTb2; arc=fail smtp.client-ip=52.101.66.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4l6eyzXg4Oog64qB82BzfRd27qTn+FbBIqlfcjb4IAhixhhxBlJye9l+5fGLtR1WgulX21aF4csh36lGqZ8EMu7y6iajxwtFdkTo8JQkKBeCnQzb8jJmNrHBRPuHV4ID7le/4op/pcbjKKAYdg/oqDj0kWRIrJmIrp0O8PrSocJeYiuJCWp2CvmsY9vQnvBk9P1ocjgoCNdhDXVi7AvMPVWtQQAbpXUVV/NJB/sv5PeTJC5sqK6ibu8t9OTVEF2yqupYAJYOF0dUBp8nNySaudJwpHST9CnyDfIo3LZvBDmKUzJFQjASh17/+G43LcEqaxoWTTFxhcKyLqDeXNvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl2dObUQuqpTvcFMGZv8fsGsLk0ruovzjTUL1E9Ff8M=;
 b=gnkK9q+Acx2M3xkVuHCcKvnF9gnWNZuWtWuX2kJnnQMJb9lI/K5ncGJj8kgSfHXXeC8uFwZoUNDOC3evapaYwH4q8A7ZSqrnV3/aJZ8aAhNnF/QAWbj60O+ZsXdRCZZ+ZnJ5K7TS6ZYfqiWD6DK+1gz6CBBUNDXkZS9Du5bMg6ZFc7kC7geVWR8Zhb9q+Hgz/EJ2hZ5Bpcy82Z6rhhMD9EJqv8PQY2wuG4wW3kbEspDhW7htFxQe75rp2wQdb3x4koCvB6UtgNj18cQvRrYtwI01xLhxvdRhzjX1djHU9rSCFzeR0aHkI9PHaXFQbx5L0TaHJpZYokAKBcEop+ax+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tl2dObUQuqpTvcFMGZv8fsGsLk0ruovzjTUL1E9Ff8M=;
 b=Bdz1QTb22Ey1PlZGE8fMJICD2Q1/HW06sNdeAiD/DvL/lapzADMhU0FUzKY6+ZdM25gImAv1HdGULge1YawesUoL1L1AK4/i3xiP4fsQg5vSZdSFQP3cPPJYefVuIK7cUXkc1/IQTG23D2gJt83WpyW8wDu7jEpFt6djVk8eCdof9HqA9AwwGiCMKs36UmzqrXzQ1+c96iwyVa4vErsvQjnk5udEHkf5whcgrCaQ5DBEli/we0DInfIL/fEg3ZmYDpKYLG/Q+lh6srXQ50Y0V2YUUHLynVPlUIzBdyi1l+zHQuPgJx3/p7t966qiOgz0ukGzOA00uesdedLD9tW95Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:57:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:57:25 +0000
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
Subject: [PATCH v7 net-next 14/15] net: fec: improve fec_enet_tx_queue()
Date: Thu,  5 Feb 2026 16:57:41 +0800
Message-Id: <20260205085742.2685134-15-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 72414dae-c683-4683-15b3-08de64949538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fyzJffSDFAKc4kCL1NEcR/FmNnz2QN8zQ42JgH3ymKd6hk1Ta3Ro2uAkYTN6?=
 =?us-ascii?Q?ahZnYxdnApB7AN4oualPoCiATGn3+dRa1Xi5XNYoxpnXaP1qHhAyHVkZFkQM?=
 =?us-ascii?Q?KwRnJNR3TwOvKHRln01WWvX+T0FN7l1qkbqDGYGbCQmrcGLNBXEUR17XlJU/?=
 =?us-ascii?Q?40TiGeK+Mfsij774dzDfMPl7Z14j2wVZXxCzSEfQkZDrkEjI0moHaKT5Lw2I?=
 =?us-ascii?Q?YBDiIedxbvAW9EP4ccLtH6k2LNIto1khaPodQig3zEZkSh+Ss9wq8/91DS3c?=
 =?us-ascii?Q?JFwWB25It8dwcniiQuz/hq10cwlwpg2fSlF8jzeGYh+g9LgxUYpuPYE4riXj?=
 =?us-ascii?Q?XDN+yvyEeGcMLBVhYaRr4xZ4+yAISaCwhOiATvR2mylbgf80S8xb1W35LuJc?=
 =?us-ascii?Q?+TZZiWLs27I8OQlH8fYbXo5IlWJ9J8x3J9YVMx56+5t8nhtkJ2CXDDLdVNSB?=
 =?us-ascii?Q?j+KdGpcPliP17a5GnGD/lIvVPif93frfUGd0mrOK7XFWJ0uK8hmPqtJquORC?=
 =?us-ascii?Q?khQuYX+Mx6nde1tZc0W6kYCvSlvVxWMC/+Fgt1xfst697mqfNMBDuTQwykLo?=
 =?us-ascii?Q?ImMg/dzTi3/pFdfgMPgy/xfQgcOL9MkKjxmmXSBchocptacmXPNes8ZiQBee?=
 =?us-ascii?Q?5c+quvxi1mURK38edNjnun+LmSUz9oUp9NJsk4j8agAdoii7Lhq2NyXIbr5t?=
 =?us-ascii?Q?HpvPTy79LPXtYB3z4fvLdhRS5w0CzaJ8Lt2gI/5JjWAjGOwKy141MjDJxiVM?=
 =?us-ascii?Q?Z9MKuXp5VG8tYASyliGwJINmUTZWKivFyfBCgJ+pCsknt5FGlSnDSmxm5C7v?=
 =?us-ascii?Q?2lwfbhDiX9xCABBVaJ++MLYyn41z11ruMhOuLA2rCtMZtSEoZLf9MmSMD7AR?=
 =?us-ascii?Q?VGBFMdeHLL4b81dp0cDMQUT931lGCUFAGV5RvR04NASgz/25gwMlTlqKmi0Z?=
 =?us-ascii?Q?JTqiIcUzh/1/oZAPXh2uJrMRtPPv/nciur8xe8VEGrw9BTf95zTDeVDdESVj?=
 =?us-ascii?Q?y3qDmBLs4NrHNFJgV/+MgjSWW6N7znX5g2BcBUi1f1VCowTGw1U48x++U/YC?=
 =?us-ascii?Q?BDbz8QmWrrzmeNI2j5msJW/ta2SRzo5HPHgEAIibDChJA6yKU+UEKQxB56zv?=
 =?us-ascii?Q?FC3g82lUVLglEjoGN7CeSNDayjHKSEJ4BWWJYK33HoNCCscWS6enWJ50dUYj?=
 =?us-ascii?Q?WLBPkpo4qk8VU/t4s85iSFMZt13cpPpcZGiB4zsf+cCCO3YhAaL269hHjr7V?=
 =?us-ascii?Q?iNVLi7ZrLwY4+lHZ3syk4QhENs4BsaLornW6v5uvCfZqkCiM/Oh6d6HZCfkn?=
 =?us-ascii?Q?sKJd/bLtrP9lWfv2FL8QTx7cESCCo7zqXC4kwQSEaqAwyam3XoxKDA9JZEUi?=
 =?us-ascii?Q?QH9fUPLOMPC2QmEmEydPbNqF0ONW0bpnj4BDd6JACL/CWVqWyanfTxUpyfU0?=
 =?us-ascii?Q?kh6aRNAgSQ3ZY6zYr3urP/XjmQc+MbNZT+bBA5mgk1TPeKwT/LfI75dwv/Iu?=
 =?us-ascii?Q?mmQbfHeAuBfkgge06eVzdHBsW1xsvKez1eDuiG10t9+aDg87oB975ODnAj6J?=
 =?us-ascii?Q?ZocAXHUrhS4SgOiljhu968UzvNU5pdM2EkukpWCuhUIXZwNnRzcpi92KMaO8?=
 =?us-ascii?Q?O0EXlQe0XnAmSyIA+60S4MQrVY0rWGrC8RgsRcKay5R7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JEgNvSfh0ZYZDldJB16fXbHgWK3Sza9liTxQjQy/KiLkyovB0ykKokp8APMi?=
 =?us-ascii?Q?UAbbgE3gM1D1NUyM2qoX+ubzSpoOUSDBdJ9yIxt6W2WrLGwq+VVL34h5YoQa?=
 =?us-ascii?Q?TdeXcpUYhBAZIr0XnWrWWO7yigC9zTHb6s8XJHbd1BEfvdTWJORjFJWW+cLo?=
 =?us-ascii?Q?L+WL8PQhrKkd741AzIcu0BSwWWoQf4e3N4Xuv/2wqmBXEhg2jG1X35QvgRvw?=
 =?us-ascii?Q?P7JGVmD3f0clEfUb1hPivsdn99Hv/+CeVBd0McoMnkfr+TZRR9D+jV2ajphF?=
 =?us-ascii?Q?t/vpN6Y4ih54FlbL8YCb/gyv93AjFt9o22JN3jA7ssEZgO8yWSRLdCi1giwT?=
 =?us-ascii?Q?KJcVdrHuQgGZOkqocHvKaf4IGy93CWceKPBYkvDPqnwjJV8nj4SMNbostaTi?=
 =?us-ascii?Q?KinXa2VugxcixOnGWtSdlmwujgzH3jpbHjmhCDfiRMqiZkHJnAkRaUPlyscG?=
 =?us-ascii?Q?Y3E/hjaW4LtVLiS3QdXctroGl0juwXnio4EmYpDl6pP7Le52tA7MrEcZApCI?=
 =?us-ascii?Q?Pi+aucBYjzHFVl9kezkJ6PUPL7bqyrlny0JrWPtjf5UDhjeNOzjwfucX8Qkk?=
 =?us-ascii?Q?plaSxYbWf3Q5ArxaO/JMbzrvnVGqoDrjEloDAwc1h1n6rRMIA9M/T5HXqT/M?=
 =?us-ascii?Q?EBwiMXj+5YoBMHiqqcAAWSPjDxaNRcwgG3TZKxiR+saD6UYKxI7A3PkbqYsU?=
 =?us-ascii?Q?B5BuFlo9nP9wVAIerfI/25P5kjQNjrGf/kyqwB7k4dPvYFoZ0qw6Sc9N/8qm?=
 =?us-ascii?Q?Tg42oCJdyoiY1P8+cmhOzr5aRcCrgK9twPOC90Yr618ROgQABScti7JdTRAU?=
 =?us-ascii?Q?OJ7Ev8ou3+3Y4GfVS/FaOe7tyPLAjBbZTo9/NoRo6TW0d4989q7aEw0XyB8P?=
 =?us-ascii?Q?XqMV2X+IgFVuXHRRCkCmrvdkdOsh8XDVNjZCNzTtdx97GohfL3S6/lysbeYw?=
 =?us-ascii?Q?9oe2mzzuoOaeS7nV6vmaovXPJlPFRiB7tnm1iACwd3Or+kIY8lRjrFereCxK?=
 =?us-ascii?Q?4WHX1hMLqhxxDlvgrBSLU8Ven3kxgaW3VsBz0F5srrSuejbQAY0Wur0M+t4w?=
 =?us-ascii?Q?ApwZ5Fbg8xX4YJb093K6oZFhjXZKBkRb3dydDEXU+yxFI+5Js5/6e8tLBR78?=
 =?us-ascii?Q?Z5GpXK8XX45ZM/Nypi59BcpdEZ34zgws0t4bLZo/wp4HTUiYFuvynClp4oz9?=
 =?us-ascii?Q?CcFksDFRb/ZcfCe65K5H9R5/jg66NHxIZ4/yErfY8GLOLPXRrtj4YP9Gf59y?=
 =?us-ascii?Q?HiLr8dfnt+44BscYXe0qJsY5ztbm/uSYKa7muD8g/kv2iq+w339n+LFjD+P5?=
 =?us-ascii?Q?VxeSPRL/sIqTwTEi7dQJbG5nSXDBr80gFuRZp2/C19pBulxzGKHVQJS9Y+ge?=
 =?us-ascii?Q?KmSZ7Zk469du7yWx3W+DW9Vrg80yqhCLLHr8UPI3iYEb0AAVuvw18Px3mO8H?=
 =?us-ascii?Q?Cef3jw+SSYUJuFifhqtAqjIM6drTtrVGLEsOnn7h8WHNUsf+3g5MiQvjJWVB?=
 =?us-ascii?Q?NsCSD0zU7H7/Y48lr7mf41YpVt/4F5aWh6HoYp66AdLdbrYmwe4OpwEatUEB?=
 =?us-ascii?Q?Wkt8Ct8CYzazeQ+NALjUiCxFS07KggX++cXPEJ8c+GJhBJ4pqtqZtpCkcd2+?=
 =?us-ascii?Q?XszzFdVVfPhjhYpUJaqY1D4GXnaEgQZ11G5m5fabKyUeJdNTo6mezEBQA2Ri?=
 =?us-ascii?Q?rCJ1o6iEKV6mV1sXx3wfJ1kAKDW1a2BU41DeiDQxbJrqLV5mlQXVEVthhxrO?=
 =?us-ascii?Q?KGlZxHsTIQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72414dae-c683-4683-15b3-08de64949538
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:57:25.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivMHJbsFu0Y5pl8765lvf0ok0wqBuaW02RpOrqEDz8c0Ufe52l7GXVJAfLPq4VVFoAKgh/W0KxlWecF3cpIVxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-257067-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0E317F05E7
X-Rspamd-Action: no action

To support AF_XDP zero-copy mode in the subsequent patch, the following
adjustments have been made to fec_tx_queue().

1. Change the parameters of fec_tx_queue().
2. Some variables are initialized at the time of declaration, and the
order of local variables is updated to follow the reverse xmas tree
style.
3. Remove the variable xdpf and add the variable tx_buf.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 43 +++++++++--------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8f57040d515a..c8e6a56313f5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1475,27 +1475,18 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
 
-static void
-fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
+static void fec_enet_tx_queue(struct fec_enet_private *fep,
+			      u16 queue, int budget)
 {
-	struct	fec_enet_private *fep;
-	struct xdp_frame *xdpf;
-	struct bufdesc *bdp;
+	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = txq->dirty_tx;
+	int index, frame_len, entries_free;
+	struct fec_tx_buffer *tx_buf;
 	unsigned short status;
-	struct	sk_buff	*skb;
-	struct fec_enet_priv_tx_q *txq;
-	struct netdev_queue *nq;
-	int	index = 0;
-	int	entries_free;
+	struct sk_buff *skb;
 	struct page *page;
-	int frame_len;
-
-	fep = netdev_priv(ndev);
-
-	txq = fep->tx_queue[queue_id];
-	/* get next bdp of dirty_tx */
-	nq = netdev_get_tx_queue(ndev, queue_id);
-	bdp = txq->dirty_tx;
 
 	/* get next bdp of dirty_tx */
 	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
@@ -1508,9 +1499,10 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		tx_buf = &txq->tx_buf[index];
 		frame_len = fec16_to_cpu(bdp->cbd_datlen);
 
-		switch (txq->tx_buf[index].type) {
+		switch (tx_buf->type) {
 		case FEC_TXBUF_T_SKB:
 			if (bdp->cbd_bufaddr &&
 			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
@@ -1519,7 +1511,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 						 frame_len, DMA_TO_DEVICE);
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			skb = txq->tx_buf[index].buf_p;
+			skb = tx_buf->buf_p;
 			if (!skb)
 				goto tx_buf_done;
 
@@ -1550,19 +1542,18 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			if (unlikely(!budget))
 				goto out;
 
-			xdpf = txq->tx_buf[index].buf_p;
 			dma_unmap_single(&fep->pdev->dev,
 					 fec32_to_cpu(bdp->cbd_bufaddr),
 					 frame_len,  DMA_TO_DEVICE);
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			xdp_return_frame_rx_napi(xdpf);
+			xdp_return_frame_rx_napi(tx_buf->buf_p);
 			break;
 		case FEC_TXBUF_T_XDP_TX:
 			if (unlikely(!budget))
 				goto out;
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			page = txq->tx_buf[index].buf_p;
+			page = tx_buf->buf_p;
 			/* The dma_sync_size = 0 as XDP_TX has already synced
 			 * DMA for_device
 			 */
@@ -1599,9 +1590,9 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		txq->tx_buf[index].buf_p = NULL;
+		tx_buf->buf_p = NULL;
 		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
-		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
+		tx_buf->type = FEC_TXBUF_T_SKB;
 
 tx_buf_done:
 		/* Make sure the update to bdp and tx_buf are performed
@@ -1637,7 +1628,7 @@ static void fec_enet_tx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_tx_queues - 1; i >= 0; i--)
-		fec_enet_tx_queue(ndev, i, budget);
+		fec_enet_tx_queue(fep, i, budget);
 }
 
 static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
-- 
2.34.1


