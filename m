Return-Path: <netdev+bounces-257060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D55DlVchGmn2gMAu9opvQ
	(envelope-from <netdev+bounces-257060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:01:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C4EF0343
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C700F301DB87
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AE239E6D9;
	Thu,  5 Feb 2026 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fHPb4zHJ"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011014.outbound.protection.outlook.com [40.107.130.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9AE39C636;
	Thu,  5 Feb 2026 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281814; cv=fail; b=TdDnGPcjS9iguk05EMZB6NE4E08/G8pPSPAnwMjUg+vEbb52BOvPxHTdFR+DzokrROzqqnKNj/B/QNvUYbT2ESTH6RZrvGkr2Pabl9FIXCaAKWr5WHPIW9J6mmNa3t+ldNYuJeDyJ6IXXG/k6syp/adNvkvxMXNQMyMJdWldL3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281814; c=relaxed/simple;
	bh=d4+snV5eqvnO3LqZOp+7lhV//NRbNecek3tRFCjWdjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rTBkMJWRl7r8iBo0tSlZ5HftVDUVGBIv0DvnupeTTmhO4OjtSCO9Ae1yDLia/i0NPTJHTyz/9eUx9dQPTjoRnIO939TDaoVPi1ur8m8MgZCyLYOrQ9mjuDcFS/mTlb+YeM+BASP1BAd2xVvpkAe/bd2Et8sRRiVp7lQ7xbOQ8kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fHPb4zHJ; arc=fail smtp.client-ip=40.107.130.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glPNKZAaDI91oapCX8jpJk822ZeEKGv+gW6CWffToZKjitJVftd7wD6EDvzIE6V3DdFEr5hOUzAN8UdrpgXsT9N3Yf86+KEPnuSoMWQX7VIFMqRVA7wy3xQdfFGVf1QnzEKF51f96C7Ck+/iTHIC5OoftG/Zqn1OHRtvnH1MZlwvDRuNaOSWxd5Pt6zTc+boh43PjvRWGOYYXHFa7Ez3ANmsnn9zCo7FfVfLoQ4KFzgq1KnU3D/g6bg4g9urHf7ddJ7Klh0Aqa7Wm20k1vGiXFH3oh0ykkyyjN2aJn0iwV3dlZwm0IJGsKO4AuDkKk1N+vesX4pDfJyLDkcjrAx1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=349jY+K/tI2A/pe3oAgVruO9tvQ8HQa2gOBSPvZBbN8=;
 b=CwyR54SC3MmekBZqe/kTXBEPVVGq7p/JSfRmtRHbCCSGwVh26epeds3ijg6/K7Sk8T0a8AzjOdW4hx9IznOdTX5uX82ST28LiIEPq5RECCBkAjKhGTX0CYtPPIQFH2HrSQ+vAO5wu7YqWNOI8S2aUjp3haY5hvFNwPi6PXzblT+2oz5pBEMsYWQ/lXt3bgKZis6fDKS+BWFw/MOl8AuKu5Bgh2v/n6nNn36brbtZc0JIq3a04rUv94WEHWKqIj9bAAhem2dTEcv43N1mZhjK8UqAmyMpn+ClL71O89uIEe8KrULTaid+RM2fO+ZkMWDt5QIpWYVmwqStxf5JKVssTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=349jY+K/tI2A/pe3oAgVruO9tvQ8HQa2gOBSPvZBbN8=;
 b=fHPb4zHJbW0I3b4TM6QlBIoYZsAgO9/cLwWwR2ra13Hwz6Y865sqi/k1g/YWvTks4zy1ypDsVUwU+NIV0CpQZu89wT418QSUtLn6HTJn8h9LccaxsZbAh6s7ODXvK95zFtj4bS4qkn2PNoq4LBO3W7Pqo+S2rbQYKB/xR9y0Q/pnwNiuTDOvMpuYvrRIncYdYbHz/9Z56MEhpHrIKugEaer1b2P9LbBaamL/IU/d8O6djQBkLP3vPdYlY9Om9aVDpPo57F5Rj/vDHD04Fsc15moU4wDlDfMZoUCeOtekY/XgQ/BmBK/jy1QzzTJWUSD/RGLrjq6pUmCzyXsCxoVlOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:56:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:56:51 +0000
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
Subject: [PATCH v7 net-next 07/15] net: fec: add tx_qid parameter to fec_enet_xdp_tx_xmit()
Date: Thu,  5 Feb 2026 16:57:34 +0800
Message-Id: <20260205085742.2685134-8-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10604:EE_
X-MS-Office365-Filtering-Correlation-Id: a608742f-4d1b-4be5-2b95-08de64948090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q/z/R7qRa5VQwKAGQtXMCX0Cx9/47rOZ91FCNu0D7I/o0fwQPR0wUuKw0DBQ?=
 =?us-ascii?Q?u4Vadp0KdTC21ddmL4N12GltnZMSOSHWdF6pUsnj3SU6a+/ZArF2Bz7evMrq?=
 =?us-ascii?Q?b8nqpDikTY9g0DhXE0LwocpWM/C6wKt8uw4/GmnVYKulSwoXiPpCW8858x8d?=
 =?us-ascii?Q?3DB+3QLXIicam8vpSKbctUZOqxlleWEjbdNCoWT8yTUGlW644Olk20DnKQyH?=
 =?us-ascii?Q?5c0SZbNkondCRmoPLtq/cs2X2gWsFTAmbBNDsakT8UuIRLlFK7191xPEKp65?=
 =?us-ascii?Q?BUem3hAt3CarpJ/67T6Ffx3HYj02fNmTwYmuI1inR++HpsOhxl6/5aUzMTTb?=
 =?us-ascii?Q?eQjLPI3DdLThHdCJrqodSIVa6Zjy58/xLCs2WnPRazyZHVG7gbRt8wLRysq2?=
 =?us-ascii?Q?aeTC6cD9xM8bLSUV1FiiKKUMeEZtinCB5l2UsmJn9DadL5nK6oJO65pXnAaC?=
 =?us-ascii?Q?7sU6xTAonRmC335CpJ6h2dPv+hRhS7BZ/KaFho9yB24JqfZZhMcPCy1wG3b7?=
 =?us-ascii?Q?SCWmau6vbNmjpWxu/74yv3qbuyvqL4JInufcprTPRyFC7zMCbAT5oR6LTxEl?=
 =?us-ascii?Q?6u20mktalkRO/WWQlI4Z7BnpDLS/u6EbW6/whovY1IVWctB7c3YSwh8yr9zw?=
 =?us-ascii?Q?HGb1bnOagWJe2Y7LtUF6vFqKzMEwv1v/BNRVA97Pgz0jG00sbUfIEltggLsb?=
 =?us-ascii?Q?XGWnyrGxGxeI8bojfeL4gIjh2XNTmb+pgf7YgnHlx+mYUq7LXjkAhK4coz4R?=
 =?us-ascii?Q?h2qsvSE22EXC1b7aWzakWo4HREaoe3RtGZH05+L2hLnyOsYjsog7/hgQD5LP?=
 =?us-ascii?Q?R2m6sGANUND+k/cLaF9YGoT+958dYa9WavkJSZ6pvTo1LEz2lwH7q97nVtDG?=
 =?us-ascii?Q?g0m0E2Z0B5rEw41hEzB7/mTAXBDuSbkJFdd8Y0H6F7LWxvN+kzooyMlS/C+o?=
 =?us-ascii?Q?XP/CS0gIJHQqg1MZLTGjisvus3vIINvHof4pdoGkABceVdnhr1siMzEId+3S?=
 =?us-ascii?Q?r/F0iMC5xeZy8FrU/+fyWctbnkc7sPR3ZQq5u5OO11BqyoNjDArISSfvfPpH?=
 =?us-ascii?Q?5OblLKvWy1XQy5kA0XnC5uoKRAbciesUOwd/ARlw6JMmry1DleXcXEIrTjLs?=
 =?us-ascii?Q?7X41l85MSEY+GcuaDQjndzsOTHnEYyQtO1zWtvX1vxAOJNZ4DOdUBRamxWX3?=
 =?us-ascii?Q?WWqqnNby0hJbbfNmcv39gSsUmbbBqW3XSejAqB9CPRG+FmwCvuo8K2n4nnqz?=
 =?us-ascii?Q?FffkV1iilXtzqv5VFjV587r8Bqj/YIUps+VaJy/Iwkfy+X/PGZeXa8M9awvF?=
 =?us-ascii?Q?5Zv5B5tYaum7rBhQZsf31TtNLvSKpBKhcJsNKRTV+BwKD14TAAn90Ht9sPfy?=
 =?us-ascii?Q?LvuEn1RZkdrWHbdbE/3hdzF2a3nwcjBxB3UZgmg+WArf1+T+O8rvELUPiopF?=
 =?us-ascii?Q?dGgNqoZb81W7epFijHUFJmrgHcA/0NftjXMAQmle27sKnhCzhhTvvCUlhjOI?=
 =?us-ascii?Q?NFaAixVzBpg1KirQe++WLWC4QZiwTXtH2U/pXRo974uprsk627pcUSKn8foZ?=
 =?us-ascii?Q?f+w52+pZbTakgrdyOIPeNMkavhhqfEfd1VcMLPqkpznoqNJIorbKGjNN/e3K?=
 =?us-ascii?Q?kzrUL1WAI4yFFWgAjMTK+s4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1UqvhuHQ7Eav1ygWeaEwz9htB/IZ55xsF2XfUAD72jxkNi6FY9uAZUjZYBjF?=
 =?us-ascii?Q?isbdvyNMREWatIO/FytXea55KruN16SzdFJIvg2Wd7sYg4m2BkmTjw4dHHYt?=
 =?us-ascii?Q?nv6EqEdtNuZN6Nn7kd0aZlFqN6d15RbEVmPgCQAe8jiBLG0vxe0BlxutJfWZ?=
 =?us-ascii?Q?NAMq0SGgQUwcIkT2cyrdFa8e7Mwzg8xaObu3BSpSd2Sx/tl42K690uIRLP7Q?=
 =?us-ascii?Q?1mNIlEiqcBhilyuL05pH2jnN44HFznSB3BtW63r8ixNWii9QjQeWSO4x5odh?=
 =?us-ascii?Q?IijdRbndNjsAH0ZNDhCLrg7pkWXjmstONhrz6CqEkp184M4quU3Vn3V+Mgn6?=
 =?us-ascii?Q?FgUB0cdvjen6cp74H6O9Wb6m9Wz8kYN3rHT3i2sNQ8h91zAs65Z3X7fbMc3m?=
 =?us-ascii?Q?Zv33B6WOqsMglt9vvfitheK4iLHq37hCNmoR2YBHjXTZQUK1tHvXyXsB+/KB?=
 =?us-ascii?Q?yLTYPe7gRek55uqfdNMUJhTTlnMb+WJkltWkEfj7mHLH/4n0o/398gXRKNkL?=
 =?us-ascii?Q?zbGg2ZZWw5XqKKCo48shHTB50LtN0pglFvxbBlk2/b7PBaR8cdUCXqyKFWkn?=
 =?us-ascii?Q?NRBhUsrdrXp5sHjMEXMHpG+QVi0mK3JWHfWqz6fW0edk48UuwjlWTH5S6c7e?=
 =?us-ascii?Q?vT8R9wylyztjOY8U++SzR2Tj1LrpZL9yrs/vhVTd5nvUSgasUx6/U9VvahGl?=
 =?us-ascii?Q?Xw1NR8Zr4UruFfKercBcEruI0YUiz3kEhuGhYkr1khabpbtmN7u0vtyWiJMO?=
 =?us-ascii?Q?ki+BkUElkNI9//T5DBgnI4keJMiwpP8hV6KVCryjo78pcm+/DptfAgHDsD2c?=
 =?us-ascii?Q?wTR7HqRf93mFUdaPCFtmdBIfaDVNEZIkpSB+fElwnJU4gLfOITjzD14xXuoB?=
 =?us-ascii?Q?l6B+bZySI26XXNZ+D379O1FJSl8Z00LPbg269Ixp2pIlXyDtdVWXXNAtGuBC?=
 =?us-ascii?Q?XplIcRHcgJcsKemJjqk9KVrvJaCPjOKAGAnZNnLoTdFcc/mbycCMuLEWEFBd?=
 =?us-ascii?Q?Ue5UptBLU2TA1029CUyFD0MiNIgwg6jcoP2X2A6bBUHh3Z/BNSiAv+RnneTY?=
 =?us-ascii?Q?8StRX/yTaEhPvBvblJszM9uOMecSrgp7ZS+SATw1VJ0VKnyE5pS6Ly92QQOb?=
 =?us-ascii?Q?tyvLleqHPocsZ4otKt8t9GXSMz7niqQ4foAJ/gzWQaPrdgzpiJwC/C8MuBx+?=
 =?us-ascii?Q?8wwXsbN5IIY1JBCCjJvJ2kpY8zJlBNmo189wRFew5YYH2Q0PwgfWH2sd+0YG?=
 =?us-ascii?Q?KpZmEbo2wlYxZ/3ZTldVpFAQqJi8z536N2qmydb16Z0Mc36urxIvWlgV6zac?=
 =?us-ascii?Q?peUrBLij2pqCIUVxAgmvdVG3h0yJGkGwKeaRnatOQpk+KuY68nmlXJbCkD3W?=
 =?us-ascii?Q?OVbsDMohl91TviXg6YIKVotvt8uBoJyKwaao3oc9fDu2O4XEpeU9GiusS09S?=
 =?us-ascii?Q?nQCc7da5xufXR2khRfJD1RziHmJIjhaBiPa9ANcheA7KFaNNgGmMJnMroklg?=
 =?us-ascii?Q?6uj03MXrjj6bfsr7hIBcyUf6I1ApwBqkICMs/oAtOqC1mswqmd/vQBAP7I3T?=
 =?us-ascii?Q?tdOWWGbCG+6Z1RqkcqsjrG5Uv8IOihKQqe2S/WjoWpj4zob5Au55KYgArOem?=
 =?us-ascii?Q?LJJh0K4mZutpO/MGjeiXkvPIkOPa0Agod+g5+IuUsVs6Em8bjl7ZldULQ6hq?=
 =?us-ascii?Q?x/XhiUqywU3lK+4sRV7vpHmM4K+6ixVdNXI91wGCHIO9Q/Rb9XCibJuCW7fn?=
 =?us-ascii?Q?VPJpkHQVew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a608742f-4d1b-4be5-2b95-08de64948090
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:56:50.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcF2A2caTfLTEdkHi8wcKAf8pDFo7PZ8k2eSXJ6qL/O7ebOaJv8lSOIiY+1Ybe2p6z2B8RkuqzKP0a+1rEPipQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604
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
	TAGGED_FROM(0.00)[bounces-257060-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 15C4EF0343
X-Rspamd-Action: no action

Remove fec_enet_xdp_get_tx_queue() from fec_enet_xdp_tx_xmit() and add
the tx_qid parameter to it. Then, calculate the TX queue ID for XDP_TX
frames in fec_enet_rx_queue_xdp(). This way, the TX queue ID only needs
to be calculated once for XDP_TX frames during each NAPI polling. And
since the number of RX queues and TX queues in FEC is generally equal,
the RX queue ID can be directly used as the TX queue ID. In exceptional
cases, fec_enet_xdp_get_tx_queue() is used to calculate the TX queue ID.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 38 +++++++++++------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 75971b39fc44..b2a6830e6c9b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -79,7 +79,7 @@ static void set_multicast_list(struct net_device *ndev);
 static void fec_enet_itr_coal_set(struct net_device *ndev);
 static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 				int cpu, struct xdp_buff *xdp,
-				u32 dma_sync_len);
+				u32 dma_sync_len, int queue);
 
 #define DRIVER_NAME	"fec"
 
@@ -1890,6 +1890,15 @@ static void fec_xdp_drop(struct fec_enet_priv_rx_q *rxq,
 	page_pool_put_page(rxq->page_pool, page, sync, true);
 }
 
+static int
+fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
+{
+	if (unlikely(index < 0))
+		return 0;
+
+	return (index % fep->num_tx_queues);
+}
+
 static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 				 int budget, struct bpf_prog *prog)
 {
@@ -1903,6 +1912,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	struct sk_buff *skb;
 	u16 status, pkt_len;
 	struct xdp_buff xdp;
+	int tx_qid = queue;
 	struct page *page;
 	u32 xdp_res = 0;
 	dma_addr_t dma;
@@ -1917,6 +1927,9 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	flush_cache_all();
 #endif
 
+	if (unlikely(tx_qid >= fep->num_tx_queues))
+		tx_qid = fec_enet_xdp_get_tx_queue(fep, cpu);
+
 	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
@@ -1988,7 +2001,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 			break;
 		case XDP_TX:
 			rxq->stats[RX_XDP_TX]++;
-			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync);
+			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync, tx_qid);
 			if (unlikely(err)) {
 				rxq->stats[RX_XDP_TX_ERRORS]++;
 				fec_xdp_drop(rxq, &xdp, sync);
@@ -3939,15 +3952,6 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 	}
 }
 
-static int
-fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
-{
-	if (unlikely(index < 0))
-		return 0;
-
-	return (index % fep->num_tx_queues);
-}
-
 static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 				   struct fec_enet_priv_tx_q *txq,
 				   void *frame, u32 dma_sync_len,
@@ -4041,15 +4045,11 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 				int cpu, struct xdp_buff *xdp,
-				u32 dma_sync_len)
+				u32 dma_sync_len, int queue)
 {
-	struct fec_enet_priv_tx_q *txq;
-	struct netdev_queue *nq;
-	int queue, ret;
-
-	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
-	txq = fep->tx_queue[queue];
-	nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	int ret;
 
 	__netif_tx_lock(nq, cpu);
 
-- 
2.34.1


