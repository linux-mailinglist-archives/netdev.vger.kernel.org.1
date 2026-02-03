Return-Path: <netdev+bounces-256142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM1aOGaJgWnuGwMAu9opvQ
	(envelope-from <netdev+bounces-256142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:36:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A72D4C2F
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 795A3309E174
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B08836BCC3;
	Tue,  3 Feb 2026 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KUZLsTdq"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE153369961;
	Tue,  3 Feb 2026 05:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096269; cv=fail; b=XeXJDKHI67UjA4f0CL+zKRz7vH9BBq0WLGK6GLm0YK7C/+BOe8ywqzAGDg0BvE2dlNqGuXocCxvNoLdHd0rWfXuM8RnvkMdCAqZbtc0nuVp90tm8cB5RYP+dWVh6da9O1dZz2DlO5R2X6Er3Amo1AsT55PaFCRPVvcZ6Nprx2R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096269; c=relaxed/simple;
	bh=hvz6M3+GWC+MtQztcyZjItSjPcbrnyTW8eh6jiaw7e0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lBji8hZX+kTI+xcdeAQDHOTtlV1EITDmsBrBrCAefWog0k9qxG9krB+wjKTlMfbbcNDF8MsORMwuhyEr+4oy4zbvPQ+widdzKxfjYrXisvASdfzj+KPbCKX745BIy/lkKGtW4mn6wiM4gPW5HXhNrOu1CNPistpzlcjqLpjvwKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KUZLsTdq; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCD1cILkBRXpVFhpemX1R+LSEhgdteDtah0AgfEdmByHUvcmyZJ5InxkuLw0qkWLUs5Tw9hpGd5lK4ECB7RV8WqbNVg/fgic4r9TPyzAirWBA8s/Dc3iGKxEk6nspPsv2Y48ZGK1LkKNFYadAyVAfWKUjtV+28eS3EhmRuPVWARruo6Lc0/BG65XnU5xBZY2vAU3GjLnyMH7TMqqiBiso8HtPMbD9Jx30EBtrO/zjXsedYo1KY5wyWGMykns5Ap41S0Gk1zCAau1kPIeCWhQV1ls/u8DczMMwfRnPIBBTG9PzMqCJDykIiHGLSdCyAxgkyQ3J1J137TaDNfIuBMbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwFi7ISLddqipkQTpcF2hm9Yj44/Fe7vhCvwEJxlRN0=;
 b=vt6o1ofAUyhaF4nn4w3tBQKs9QH3EEp3y67uz3XYiLB/9vwG6jYFiw6wGrn9GQj4C4W7KYFEniw1/1hKoN1s26W/0H9C7TnHL2ui9CVyaYD1WHomQ+5nYZK14F2WNnl1U2KJNVyx4Xzg6FY03kmgA0zJP2v3bO+FwjdCYip012o+BaIrxBgeiN/SMVJjjzWxr7ogaQb6HRjcgRpekGkLT7/2xmn8fhc9zmIWGgfl5aFV7yT+mdjCCv2t1BCx07zjqkFeXW1bWxbMpMs3Dm/G1nA4SqXDQ8ONfhVJQPeUZKP9R6QN5umy4a9wFJtS2TyNbJmFv0/MP/+K8GPTq0jTpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwFi7ISLddqipkQTpcF2hm9Yj44/Fe7vhCvwEJxlRN0=;
 b=KUZLsTdq0/UAZVMd8RZpefP4OOqeo16fz9utYIwVXAJm9DVCPjoTSri4tEM7Wn5iQrXec8fgYkcPxlkJ2dT3cc/CmW9+9M2ZUVFOH0SoqbvojdS0tLCE+VcODgZxFnIhJjjhJFxQ47Xw9q7wCWkQTMGZRDiJHtpq17pN88DJqBTaCA5tpJeeCDLZeh9g5jJCetf8DJsRTiesw2pL/ZCnqm0QAtP9pWo3K3d+iFK2eDiOdjHAdn473kMN/blYyhv3UWh1whneFBSGLRJuM5ZaLGj/MtEC+Fd4mYIQhErQhRYA8ywiIESP5g2okzfb0ZkXYj2Wr9hON/NJX5HJudv+rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:23:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:23:30 +0000
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
Subject: [PATCH v6 net-next 15/15] net: fec: add AF_XDP zero-copy support
Date: Tue,  3 Feb 2026 13:23:29 +0800
Message-Id: <20260203052329.1085444-16-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203052329.1085444-1-wei.fang@nxp.com>
References: <20260203052329.1085444-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f037a7-9202-475a-67ef-08de62e45dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zJxQIHraLNio00eacvGc0KoIcNlYB3sdSKorRCo0azVoDyudg1DW6YoCES3v?=
 =?us-ascii?Q?E71jIiGeghZ992FFNWRaZo83v7wj5NLFvQE2oolY9yn9WAFXB4h8cQkvasxj?=
 =?us-ascii?Q?uNkcexeSj3KE4f0g5XGmfCBWCzqjjZ4nGCrld4J+CJaGQ7fZNZpM5jV1upNI?=
 =?us-ascii?Q?lCHv4jExYN0CDYkS9FxwEGv/JwT5lFBYJR+MTww0y4KBxIuYRoQ6Q8OPYyvg?=
 =?us-ascii?Q?yQpN4doNYEMcNu26t/qNKWqPQr0rS3qukbs4bS/U7tWqpZ4yaCIQRayk9uxW?=
 =?us-ascii?Q?nJhy2MiWutoMiYOlEqFchI9UB7tAvc5bX6DbMau44b6QFd4/fycfao877IFC?=
 =?us-ascii?Q?yXTgedKSKbKqmC5YAFA5WheNa2C1gxipgdItGE6ATzua8V+x0P8XJ18Vov76?=
 =?us-ascii?Q?1BZFTzcF/q7bHmAsSg8RC5RxtfpaRCbOOXkXggclG3r8mlWdzYkQ6DL+bQCI?=
 =?us-ascii?Q?1uVbQ+aSSQaY+vfBkBg5eTk+tH3GkyWjFbyp2VWucyVuN0WXZf8NZLum9tO2?=
 =?us-ascii?Q?7LbJLx8evL9ZThmM7uSz7PJMSEf5hMNvIu2SfzMGTHRcSSDj3Sp/ioORcjvW?=
 =?us-ascii?Q?ySG5w8em1m5oyETdF9LC3o8WrZqZRiL9RoWol/hGQ4ZpWRb5xqRGd+sAi/PK?=
 =?us-ascii?Q?c3kfb7fL8rqKsgSODw5Yigk3qH1rEFdIgrsPFWJa9yoYEqBF2Dnm96p68a+T?=
 =?us-ascii?Q?gR3JmSgmVvx7bNq7vRK0+jjZ1R3GKmFWWJrn0hQm5URHxb9Y/5U/WnQRWc2H?=
 =?us-ascii?Q?OKyzgrx6hE0ZABlR3Jdf1jtgUnUu4VsSA/DabT4t6ExkAq+z3roGbaZmOoEy?=
 =?us-ascii?Q?aTzsm5PvpjgwlMXfQ/6GJye3bmN2iqIUwz0nasPuGmXt5W8ZNQUohQyhykoO?=
 =?us-ascii?Q?ZNe1igQpkzhEp6pL8DQEnL7Ssn3oBzxyIBz1aFCRasgbCqa8Ayp6oVyfwjCL?=
 =?us-ascii?Q?FU7OicgsFPvxlsiZa1gXchHFn3YNvkzgG68QsTzGjY/rAiWmJz5vzPNgV+qP?=
 =?us-ascii?Q?u/3Zb2vvFfyTXq0aRKZ7p3FRCmq+6eldFk2kIvZjGlXuvdCi4iAjkhBA/CTg?=
 =?us-ascii?Q?g80c0nCq6MA35HFHRTZ97QM2D/LY0UpfE+Ksp8D87TM12Tr9m7QfiKsYZmM2?=
 =?us-ascii?Q?Apj4FHUx1iICGgGVfV9WPK88pCwIW/G6uztK087Henivwa3eWnCpklHxMfaO?=
 =?us-ascii?Q?EmLcJfnJhYLnjdnsHY7Ni0jMj/4ro5XB5fdKHLbgNNL+hdDqUKBnWyOayhTs?=
 =?us-ascii?Q?vFUyLiZG3BkLzYvj5VQ6M114B1E3lPtX+mUj+nP3UZjJ63WY5/zh4XOGi55w?=
 =?us-ascii?Q?qQMHYgvqH3VZLO8g60nTHnv3/HqpQ21BR1FrsNAmgxZUUiA5xThr0osivtLB?=
 =?us-ascii?Q?LuZ4p/rrUkPqiF1uDgUT4Fwh8CR8T+FAuNZwNz5EOcUnsZyagiSyQ+r4+RDJ?=
 =?us-ascii?Q?zfAlEGNXPEgu1ivBKtxVVzuWzYed/LK4ArItIzeUyZoJgNOKwEfStqv90uZw?=
 =?us-ascii?Q?B6gKIVA4hpT9dGksvwmSP6qTgG3EkkjeO7O2xr3qTEbDVrcUMla0ZQw4corV?=
 =?us-ascii?Q?JAWjdixOYcKfdHU+aDaZ9vKNZmbNBMeHS3nheDabAO3P92jpumbTLIzbkFS9?=
 =?us-ascii?Q?nRq0AlEHYD/zG1pTPxp5KyeMrN4iZjY3CooWPXqKgk3z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0G2e1iWvQnBRGboHnSZAK0DC7kC70qUlzkaitS57ZZEBF4QjMTfdqjn8R8vc?=
 =?us-ascii?Q?9yfMiQSYYbRdSS8lOV6GvwfTtj8YpmkPwoZTKWwIKkhkzMkw7ED6Iszh6UFS?=
 =?us-ascii?Q?N/DgssEz5ecrxMdOLbhXknE651GOj8Y73QpGKTRfpx2C59kEPkidlzCS6h/q?=
 =?us-ascii?Q?vW634gFOnzXm0cb4J2eFnD0xdB52ptzCGahxSOAkwL24MXszMmPZHpicw/7f?=
 =?us-ascii?Q?9No35ehleeLY3xXr0k6cvpkNHsQAoY7EqsdehJM+o+onBow9t6NVPo13eCoQ?=
 =?us-ascii?Q?f70QVN7JhNFeroLAOCObFDu7EsGtXZlIcGkeTc3La0Z0tr5tH2JRvJ3L8SJd?=
 =?us-ascii?Q?3E+MGsrz4sJK2kB0Yh/AvOTHGRhlUEdOnQ5jhpz7P1rKcTQokNm5wxMYpCLI?=
 =?us-ascii?Q?nSS48sOsR/Q9Q4/j0ejWMP42MueOlRyX0CrymyqtE2kfwn5TToWzLwFhbsL6?=
 =?us-ascii?Q?HeCFTS7YRk9QU4rcOV0vNF/8Jip1wGzhTHLC/BJROH5vW4YBJsRR4ngKnoed?=
 =?us-ascii?Q?E/rHrpQCqH5hYbEQRGcTynbOiXgDCYCE13D5bIe8Nc7TrGAbzHCAhV/cQpem?=
 =?us-ascii?Q?4XTIYJNWLQiDY2LXNCpvbHn1LZmhd2JjMJ7YL4n2oUpYY9zk5r7pTB/4aF8O?=
 =?us-ascii?Q?0+Kn6OZKwCCyburnzi9zj6MxaEFnnKFn4DBF6WjcIG+6OC8TP/ACxfThm7Vj?=
 =?us-ascii?Q?whOiE3/OiTf5UZycAXX71GInoj+gR8Mkh5S7ZxxoP/VgH3h8CRx2+lAdINJl?=
 =?us-ascii?Q?+fb/bVEkXQCv2t/E6xKQrXD3Pef6SKLm8OIuXRJwOBH8EN43WWSYyK+zKOfZ?=
 =?us-ascii?Q?sJ+7/Hfnls/zt3XY2Djm1fR23cboZaF/HJIqF5WuxKVeM8AtCaEK6LZ3nMA3?=
 =?us-ascii?Q?4KYUsD5tsAk10ry16/Sk5q97B9NkQKY341u278iWghqr00Zuw4mqf+SlG1Pb?=
 =?us-ascii?Q?anKvfym+gYeUKEP/wMY6E5dx5TOScrOnHiZLkVtuvDyEWXLILiC2WQ5CQTas?=
 =?us-ascii?Q?RdaBe02laJGlOnhKQdyNCuhX/hTXGnqe3OTVVEBxnPyG40HwZZT50wEOYvaE?=
 =?us-ascii?Q?M9lKmIuI4pVXu38rTLeCtJsHEyVglIy6rrjgThedFHQlkIPParcfDj29zrFz?=
 =?us-ascii?Q?YmlnNn1Xp2VBEFSbHJr8AgbomFveHCIbg8gnT34NigNFiW8VNh7cIh2lLkCc?=
 =?us-ascii?Q?vzXe2rd1sbUROhbKpckjEAetuEK5hTj6dcpsriil0cyHGdojT7RX8UYQ4zez?=
 =?us-ascii?Q?H98ztIWFU9joe5JNfbrJyHGLrPhgBn1EUmC9Nvy5dDqG69ViHzjuUVaOtMg5?=
 =?us-ascii?Q?3PDk3OB8aKqPZDRQ15g/ROfjCtH9BvAV2yFKtso8vjDfKhF7Map5C8tW1jmq?=
 =?us-ascii?Q?TtTdb4BozslmAFOab4NgN/ParbABJl+6dvP4Bv8andmzG5VWJt6OQnBo4dIf?=
 =?us-ascii?Q?orkDWii0MAADzYClTDMxRMwJmN89zdmOhxBxA+qmXI2LvKKFm23GhCllby87?=
 =?us-ascii?Q?8qvyVX5vIbuf8kbw5KTxal+dDok4wbooBaBaIii9nl0Cwm7Rm0rYV7YZYsRT?=
 =?us-ascii?Q?oNQfjUdftiGunHdjIy6u4lUNE54hTynIWE4NpvSH4hdnBf4sixTEtBRbNI4Q?=
 =?us-ascii?Q?kFPFBglrovSSgZQ49Ms5KXsrgu3/mHzhgmaRto0E9tT37WT0Tr1choGG4aQK?=
 =?us-ascii?Q?Ci9bnwLoZNUlRuad1fSnBlAai8Ym3hILoITtptqD5nFHuX6VZTPYumJqwhCN?=
 =?us-ascii?Q?mJiMNkLhPQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f037a7-9202-475a-67ef-08de62e45dd9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:23:30.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBOSh0/Et07xVTRFAG188gQDg4WOVajxWkm83F1gp4FsgRkpvlTPMplvN7cn3mV7tayxwSVMfaMwZjxXjKfFcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256142-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imx93evk:email,eth0:email,nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6A72D4C2F
X-Rspamd-Action: no action

Add AF_XDP zero-copy support for both TX and RX.

For RX, instead of allocating buffers from the page pool, the buffers
are allocated from xsk pool, so fec_alloc_rxq_buffers_zc() is added to
allocate RX buffers from xsk pool. And fec_enet_rx_queue_xsk() is used
to process the frames from the RX queue which is bound to the AF_XDP
socket. Similar to the XDP copy mode, the zero-copy mode also supports
XDP_TX, XDP_PASS, XDP_DROP and XDP_REDIRECT actions. In addition,
fec_enet_xsk_tx_xmit() is similar to fec_enet_xdp_tx_xmit() and is used
to handle XDP_TX action in zero-copy mode.

For TX, there are two cases, one is the frames from the AF_XDP socket,
so fec_enet_xsk_xmit() is added to directly transmit the frames from
the socket and the buffer type is marked as FEC_TXBUF_T_XSK_XMIT. The
other one is the frams from the RX queue (XDP_TX action), the buffer
type is marked as FEC_TXBUF_T_XSK_TX. Therefore, fec_enet_tx_queue()
could correctly clean the TX queue base on the buffer type.

Also, some tests have been done on the i.MX93-EVK board with the xdpsock
tool, the following are the results.

Env: i.MX93 connects to a packet generator, the link speed is 1Gbps, and
flow-control is off. The RX packet size is 64 bytes including FCS. Only
one RX queue (CPU) is used to receive frames.

1. MAC swap L2 forwarding
1.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -z
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 414715         415455
tx                 414715         415455

1.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -c
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 356396         356609
tx                 356396         356609

2. TX only
2.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -z
 sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 1119573        1126720

2.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -c
sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 406864         407616

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  13 +-
 drivers/net/ethernet/freescale/fec_main.c | 779 ++++++++++++++++++++--
 2 files changed, 748 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index ad7aba1a8536..7176803146f3 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -340,6 +340,7 @@ struct bufdesc_ex {
 #define FEC_ENET_TX_FRPPG	(PAGE_SIZE / FEC_ENET_TX_FRSIZE)
 #define TX_RING_SIZE		1024	/* Must be power of two */
 #define TX_RING_MOD_MASK	511	/*   for this to work */
+#define FEC_XSK_TX_BUDGET_MAX	256
 
 #define BD_ENET_RX_INT		0x00800000
 #define BD_ENET_RX_PTP		((ushort)0x0400)
@@ -528,6 +529,8 @@ enum fec_txbuf_type {
 	FEC_TXBUF_T_SKB,
 	FEC_TXBUF_T_XDP_NDO,
 	FEC_TXBUF_T_XDP_TX,
+	FEC_TXBUF_T_XSK_XMIT,
+	FEC_TXBUF_T_XSK_TX,
 };
 
 struct fec_tx_buffer {
@@ -539,6 +542,7 @@ struct fec_enet_priv_tx_q {
 	struct bufdesc_prop bd;
 	unsigned char *tx_bounce[TX_RING_SIZE];
 	struct fec_tx_buffer tx_buf[TX_RING_SIZE];
+	struct xsk_buff_pool *xsk_pool;
 
 	unsigned short tx_stop_threshold;
 	unsigned short tx_wake_threshold;
@@ -548,9 +552,16 @@ struct fec_enet_priv_tx_q {
 	dma_addr_t tso_hdrs_dma;
 };
 
+union fec_rx_buffer {
+	void *buf_p;
+	struct page *page;
+	struct xdp_buff *xdp;
+};
+
 struct fec_enet_priv_rx_q {
 	struct bufdesc_prop bd;
-	struct page *rx_buf[RX_RING_SIZE];
+	union fec_rx_buffer rx_buf[RX_RING_SIZE];
+	struct xsk_buff_pool *xsk_pool;
 
 	/* page_pool */
 	struct page_pool *page_pool;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7aeaa055c2cd..2e049b7dea55 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -71,6 +71,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/selftests.h>
 #include <net/tso.h>
+#include <net/xdp_sock_drv.h>
 #include <soc/imx/cpuidle.h>
 
 #include "fec.h"
@@ -1041,6 +1042,9 @@ static void fec_enet_bd_init(struct net_device *dev)
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
 				break;
+			case FEC_TXBUF_T_XSK_TX:
+				xsk_buff_free(txq->tx_buf[i].buf_p);
+				break;
 			default:
 				break;
 			}
@@ -1475,8 +1479,91 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
 
-static void fec_enet_tx_queue(struct fec_enet_private *fep,
-			      u16 queue, int budget)
+static bool fec_enet_xsk_xmit(struct fec_enet_private *fep,
+			      struct xsk_buff_pool *pool,
+			      u32 queue)
+{
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct xdp_desc *xsk_desc = pool->tx_descs;
+	int cpu = smp_processor_id();
+	int free_bds, budget, batch;
+	struct netdev_queue *nq;
+	struct bufdesc *bdp;
+	dma_addr_t dma;
+	u32 estatus;
+	u16 status;
+	int i, j;
+
+	nq = netdev_get_tx_queue(fep->netdev, queue);
+	__netif_tx_lock(nq, cpu);
+
+	txq_trans_cond_update(nq);
+	free_bds = fec_enet_get_free_txdesc_num(txq);
+	if (!free_bds)
+		goto tx_unlock;
+
+	budget = min(free_bds, FEC_XSK_TX_BUDGET_MAX);
+	batch = xsk_tx_peek_release_desc_batch(pool, budget);
+	if (!batch)
+		goto tx_unlock;
+
+	bdp = txq->bd.cur;
+	for (i = 0; i < batch; i++) {
+		dma = xsk_buff_raw_get_dma(pool, xsk_desc[i].addr);
+		xsk_buff_raw_dma_sync_for_device(pool, dma, xsk_desc[i].len);
+
+		j = fec_enet_get_bd_index(bdp, &txq->bd);
+		txq->tx_buf[j].type = FEC_TXBUF_T_XSK_XMIT;
+		txq->tx_buf[j].buf_p = NULL;
+
+		status = fec16_to_cpu(bdp->cbd_sc);
+		status &= ~BD_ENET_TX_STATS;
+		status |= BD_ENET_TX_INTR | BD_ENET_TX_LAST;
+		bdp->cbd_datlen = cpu_to_fec16(xsk_desc[i].len);
+		bdp->cbd_bufaddr = cpu_to_fec32(dma);
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			estatus = BD_ENET_TX_INT;
+			if (fep->quirks & FEC_QUIRK_HAS_AVB)
+				estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
+
+			ebdp->cbd_bdu = 0;
+			ebdp->cbd_esc = cpu_to_fec32(estatus);
+		}
+
+		/* Make sure the updates to rest of the descriptor are performed
+		 * before transferring ownership.
+		 */
+		dma_wmb();
+
+		/* Send it on its way.  Tell FEC it's ready, interrupt when done,
+		 * it's the last BD of the frame, and to put the CRC on the end.
+		 */
+		status |= BD_ENET_TX_READY | BD_ENET_TX_TC;
+		bdp->cbd_sc = cpu_to_fec16(status);
+		dma_wmb();
+
+		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+		txq->bd.cur = bdp;
+	}
+
+	/* Trigger transmission start */
+	fec_txq_trigger_xmit(fep, txq);
+
+	__netif_tx_unlock(nq);
+
+	return batch < budget;
+
+tx_unlock:
+	__netif_tx_unlock(nq);
+
+	return true;
+}
+
+static int fec_enet_tx_queue(struct fec_enet_private *fep,
+			     u16 queue, int budget)
 {
 	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
 	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
@@ -1487,6 +1574,7 @@ static void fec_enet_tx_queue(struct fec_enet_private *fep,
 	unsigned short status;
 	struct sk_buff *skb;
 	struct page *page;
+	int xsk_cnt = 0;
 
 	/* get next bdp of dirty_tx */
 	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
@@ -1560,6 +1648,14 @@ static void fec_enet_tx_queue(struct fec_enet_private *fep,
 			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
 					   0, true);
 			break;
+		case FEC_TXBUF_T_XSK_XMIT:
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			xsk_cnt++;
+			break;
+		case FEC_TXBUF_T_XSK_TX:
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			xsk_buff_free(tx_buf->buf_p);
+			break;
 		default:
 			break;
 		}
@@ -1619,16 +1715,37 @@ static void fec_enet_tx_queue(struct fec_enet_private *fep,
 	if (bdp != txq->bd.cur &&
 	    readl(txq->bd.reg_desc_active) == 0)
 		writel(0, txq->bd.reg_desc_active);
+
+	if (txq->xsk_pool) {
+		struct xsk_buff_pool *pool = txq->xsk_pool;
+
+		if (xsk_cnt)
+			xsk_tx_completed(pool, xsk_cnt);
+
+		if (xsk_uses_need_wakeup(pool))
+			xsk_set_tx_need_wakeup(pool);
+
+		/* If the condition is true, it indicates that there are still
+		 * packets to be transmitted, so return "budget" to make the
+		 * NAPI continue polling.
+		 */
+		if (!fec_enet_xsk_xmit(fep, pool, queue))
+			return budget;
+	}
+
+	return 0;
 }
 
-static void fec_enet_tx(struct net_device *ndev, int budget)
+static int fec_enet_tx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	int i;
+	int i, count = 0;
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_tx_queues - 1; i >= 0; i--)
-		fec_enet_tx_queue(fep, i, budget);
+		count += fec_enet_tx_queue(fep, i, budget);
+
+	return count;
 }
 
 static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
@@ -1641,13 +1758,30 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	if (unlikely(!new_page))
 		return -ENOMEM;
 
-	rxq->rx_buf[index] = new_page;
+	rxq->rx_buf[index].page = new_page;
 	phys_addr = page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM;
 	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 
 	return 0;
 }
 
+static int fec_enet_update_cbd_zc(struct fec_enet_priv_rx_q *rxq,
+				  struct bufdesc *bdp, int index)
+{
+	struct xdp_buff *new_xdp;
+	dma_addr_t phys_addr;
+
+	new_xdp = xsk_buff_alloc(rxq->xsk_pool);
+	if (unlikely(!new_xdp))
+		return -ENOMEM;
+
+	rxq->rx_buf[index].xdp = new_xdp;
+	phys_addr = xsk_buff_xdp_get_dma(new_xdp);
+	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
+
+	return 0;
+}
+
 static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 {
 	if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
@@ -1802,7 +1936,7 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
-		page = rxq->rx_buf[index];
+		page = rxq->rx_buf[index].page;
 		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
@@ -1932,7 +2066,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
-		page = rxq->rx_buf[index];
+		page = rxq->rx_buf[index].page;
 		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
@@ -2046,6 +2180,268 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	return pkt_received;
 }
 
+static struct sk_buff *fec_build_skb_zc(struct xdp_buff *xsk,
+					struct napi_struct *napi)
+{
+	size_t len = xdp_get_buff_len(xsk);
+	struct sk_buff *skb;
+
+	skb = napi_alloc_skb(napi, len);
+	if (unlikely(!skb)) {
+		xsk_buff_free(xsk);
+		return NULL;
+	}
+
+	skb_put_data(skb, xsk->data, len);
+	xsk_buff_free(xsk);
+
+	return skb;
+}
+
+static int fec_enet_xsk_tx_xmit(struct fec_enet_private *fep,
+				struct xdp_buff *xsk, int cpu,
+				int queue)
+{
+	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	u32 offset = xsk->data - xsk->data_hard_start;
+	u32 headroom = txq->xsk_pool->headroom;
+	u32 len = xsk->data_end - xsk->data;
+	u32 index, status, estatus;
+	struct bufdesc *bdp;
+	dma_addr_t dma;
+
+	__netif_tx_lock(nq, cpu);
+
+	/* Avoid tx timeout as XDP shares the queue with kernel stack */
+	txq_trans_cond_update(nq);
+
+	if (!fec_enet_get_free_txdesc_num(txq)) {
+		__netif_tx_unlock(nq);
+
+		return -EBUSY;
+	}
+
+	/* Fill in a Tx ring entry */
+	bdp = txq->bd.cur;
+	status = fec16_to_cpu(bdp->cbd_sc);
+	status &= ~BD_ENET_TX_STATS;
+
+	index = fec_enet_get_bd_index(bdp, &txq->bd);
+	dma = xsk_buff_xdp_get_frame_dma(xsk) + headroom + offset;
+
+	xsk_buff_raw_dma_sync_for_device(txq->xsk_pool, dma, len);
+
+	txq->tx_buf[index].buf_p = xsk;
+	txq->tx_buf[index].type = FEC_TXBUF_T_XSK_TX;
+
+	status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
+	if (fep->bufdesc_ex)
+		estatus = BD_ENET_TX_INT;
+
+	bdp->cbd_bufaddr = cpu_to_fec32(dma);
+	bdp->cbd_datlen = cpu_to_fec16(len);
+
+	if (fep->bufdesc_ex) {
+		struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+		if (fep->quirks & FEC_QUIRK_HAS_AVB)
+			estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
+
+		ebdp->cbd_bdu = 0;
+		ebdp->cbd_esc = cpu_to_fec32(estatus);
+	}
+
+	status |= (BD_ENET_TX_READY | BD_ENET_TX_TC);
+	bdp->cbd_sc = cpu_to_fec16(status);
+	dma_wmb();
+
+	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+	txq->bd.cur = bdp;
+
+	__netif_tx_unlock(nq);
+
+	return 0;
+}
+
+static int fec_enet_rx_queue_xsk(struct fec_enet_private *fep, int queue,
+				 int budget, struct bpf_prog *prog)
+{
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
+	u32 sub_len = 4 + fep->rx_shift;
+	int cpu = smp_processor_id();
+	bool wakeup_xsk = false;
+	struct xdp_buff *xsk;
+	int pkt_received = 0;
+	struct sk_buff *skb;
+	u16 status, pkt_len;
+	u32 xdp_res = 0;
+	int index, err;
+	u32 act;
+
+#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
+	/*
+	 * Hacky flush of all caches instead of using the DMA API for the TSO
+	 * headers.
+	 */
+	flush_cache_all();
+#endif
+
+	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
+		if (unlikely(pkt_received >= budget))
+			break;
+
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
+
+		index = fec_enet_get_bd_index(bdp, &rxq->bd);
+		xsk = rxq->rx_buf[index].xdp;
+		if (unlikely(!xsk)) {
+			if (fec_enet_update_cbd_zc(rxq, bdp, index))
+				break;
+
+			if (fep->bufdesc_ex) {
+				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+				ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+				ebdp->cbd_prot = 0;
+				ebdp->cbd_bdu = 0;
+			}
+
+			dma_wmb();
+			status &= ~BD_ENET_RX_STATS;
+			status |= BD_ENET_RX_EMPTY;
+			bdp->cbd_sc = cpu_to_fec16(status);
+			break;
+		}
+
+		pkt_received++;
+		/* Check for errors. */
+		status ^= BD_ENET_RX_LAST;
+		if (unlikely(fec_rx_error_check(ndev, status)))
+			goto rx_processing_done;
+
+		/* Process the incoming frame. */
+		ndev->stats.rx_packets++;
+		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
+
+		if (fec_enet_update_cbd_zc(rxq, bdp, index)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
+		pkt_len -= sub_len;
+		xsk->data = xsk->data_hard_start + data_start;
+		/* Subtract FCS and 16bit shift */
+		xsk->data_end = xsk->data + pkt_len;
+		xsk->data_meta = xsk->data;
+		xsk_buff_dma_sync_for_cpu(xsk);
+
+		/* If the XSK pool is enabled before the bpf program is
+		 * installed, or the bpf program is uninstalled before
+		 * the XSK pool is disabled. prog will be NULL and we
+		 * need to set a default XDP_PASS action.
+		 */
+		if (unlikely(!prog))
+			act = XDP_PASS;
+		else
+			act = bpf_prog_run_xdp(prog, xsk);
+
+		switch (act) {
+		case XDP_PASS:
+			rxq->stats[RX_XDP_PASS]++;
+			skb = fec_build_skb_zc(xsk, &fep->napi);
+			if (unlikely(!skb))
+				ndev->stats.rx_dropped++;
+			else
+				napi_gro_receive(&fep->napi, skb);
+			break;
+		case XDP_TX:
+			rxq->stats[RX_XDP_TX]++;
+			err = fec_enet_xsk_tx_xmit(fep, xsk, cpu, queue);
+			if (unlikely(err)) {
+				rxq->stats[RX_XDP_TX_ERRORS]++;
+				xsk_buff_free(xsk);
+			} else {
+				xdp_res |= FEC_ENET_XDP_TX;
+			}
+			break;
+		case XDP_REDIRECT:
+			rxq->stats[RX_XDP_REDIRECT]++;
+			err = xdp_do_redirect(ndev, xsk, prog);
+			if (unlikely(err)) {
+				if (err == -ENOBUFS)
+					wakeup_xsk = true;
+
+				rxq->stats[RX_XDP_DROP]++;
+				xsk_buff_free(xsk);
+			} else {
+				xdp_res |= FEC_ENET_XDP_REDIR;
+			}
+			break;
+		default:
+			bpf_warn_invalid_xdp_action(ndev, prog, act);
+			fallthrough;
+		case XDP_ABORTED:
+			trace_xdp_exception(ndev, prog, act);
+			fallthrough;
+		case XDP_DROP:
+			rxq->stats[RX_XDP_DROP]++;
+			xsk_buff_free(xsk);
+			break;
+		}
+
+rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			ebdp->cbd_prot = 0;
+			ebdp->cbd_bdu = 0;
+		}
+
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		dma_wmb();
+		bdp->cbd_sc = cpu_to_fec16(status);
+
+		/* Update BD pointer to next entry */
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames. On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(0, rxq->bd.reg_desc_active);
+	}
+
+	rxq->bd.cur = bdp;
+
+	if (xdp_res & FEC_ENET_XDP_REDIR)
+		xdp_do_flush();
+
+	if (xdp_res & FEC_ENET_XDP_TX)
+		fec_txq_trigger_xmit(fep, fep->tx_queue[queue]);
+
+	if (rxq->xsk_pool && xsk_uses_need_wakeup(rxq->xsk_pool)) {
+		if (wakeup_xsk)
+			xsk_set_rx_need_wakeup(rxq->xsk_pool);
+		else
+			xsk_clear_rx_need_wakeup(rxq->xsk_pool);
+	}
+
+	return pkt_received;
+}
+
 static int fec_enet_rx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -2054,11 +2450,15 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_rx_queues - 1; i >= 0; i--) {
-		if (prog)
-			done += fec_enet_rx_queue_xdp(fep, i, budget - done,
-						      prog);
+		struct fec_enet_priv_rx_q *rxq = fep->rx_queue[i];
+		int batch = budget - done;
+
+		if (rxq->xsk_pool)
+			done += fec_enet_rx_queue_xsk(fep, i, batch, prog);
+		else if (prog)
+			done += fec_enet_rx_queue_xdp(fep, i, batch, prog);
 		else
-			done += fec_enet_rx_queue(fep, i, budget - done);
+			done += fec_enet_rx_queue(fep, i, batch);
 	}
 
 	return done;
@@ -2102,19 +2502,22 @@ static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
 {
 	struct net_device *ndev = napi->dev;
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	int done = 0;
+	int rx_done = 0, tx_done = 0;
+	int max_done;
 
 	do {
-		done += fec_enet_rx(ndev, budget - done);
-		fec_enet_tx(ndev, budget);
-	} while ((done < budget) && fec_enet_collect_events(fep));
+		rx_done += fec_enet_rx(ndev, budget - rx_done);
+		tx_done += fec_enet_tx(ndev, budget);
+		max_done = max(rx_done, tx_done);
+	} while ((max_done < budget) && fec_enet_collect_events(fep));
 
-	if (done < budget) {
-		napi_complete_done(napi, done);
+	if (max_done < budget) {
+		napi_complete_done(napi, max_done);
 		writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+		return max_done;
 	}
 
-	return done;
+	return budget;
 }
 
 /* ------------------------------------------------------------------------- */
@@ -3405,7 +3808,8 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
 				struct fec_enet_priv_rx_q *rxq)
 {
 	struct net_device *ndev = fep->netdev;
-	int err;
+	void *allocator;
+	int type, err;
 
 	err = xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq->id, 0);
 	if (err) {
@@ -3413,8 +3817,9 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
 		return err;
 	}
 
-	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
-					 rxq->page_pool);
+	allocator = rxq->xsk_pool ? NULL : rxq->page_pool;
+	type = rxq->xsk_pool ? MEM_TYPE_XSK_BUFF_POOL : MEM_TYPE_PAGE_POOL;
+	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, type, allocator);
 	if (err) {
 		netdev_err(ndev, "Failed to register XDP mem model\n");
 		xdp_rxq_info_unreg(&rxq->xdp_rxq);
@@ -3422,6 +3827,9 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
 		return err;
 	}
 
+	if (rxq->xsk_pool)
+		xsk_pool_set_rxq_info(rxq->xsk_pool, &rxq->xdp_rxq);
+
 	return 0;
 }
 
@@ -3435,20 +3843,28 @@ static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
 
 static void fec_free_rxq_buffers(struct fec_enet_priv_rx_q *rxq)
 {
+	bool xsk = !!rxq->xsk_pool;
 	int i;
 
 	for (i = 0; i < rxq->bd.ring_size; i++) {
-		struct page *page = rxq->rx_buf[i];
+		union fec_rx_buffer *buf = &rxq->rx_buf[i];
 
-		if (!page)
+		if (!buf->buf_p)
 			continue;
 
-		page_pool_put_full_page(rxq->page_pool, page, false);
-		rxq->rx_buf[i] = NULL;
+		if (xsk)
+			xsk_buff_free(buf->xdp);
+		else
+			page_pool_put_full_page(rxq->page_pool,
+						buf->page, false);
+
+		rxq->rx_buf[i].buf_p = NULL;
 	}
 
-	page_pool_destroy(rxq->page_pool);
-	rxq->page_pool = NULL;
+	if (!xsk) {
+		page_pool_destroy(rxq->page_pool);
+		rxq->page_pool = NULL;
+	}
 }
 
 static void fec_enet_free_buffers(struct net_device *ndev)
@@ -3488,6 +3904,9 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
 				break;
+			case FEC_TXBUF_T_XSK_TX:
+				xsk_buff_free(txq->tx_buf[i].buf_p);
+				break;
 			default:
 				break;
 			}
@@ -3603,7 +4022,7 @@ static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
 
 		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
-		rxq->rx_buf[i] = page;
+		rxq->rx_buf[i].page = page;
 		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
 	}
 
@@ -3615,6 +4034,33 @@ static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
 	return err;
 }
 
+static int fec_alloc_rxq_buffers_zc(struct fec_enet_private *fep,
+				    struct fec_enet_priv_rx_q *rxq)
+{
+	union fec_rx_buffer *buf = &rxq->rx_buf[0];
+	struct bufdesc *bdp = rxq->bd.base;
+	dma_addr_t phys_addr;
+	int i;
+
+	for (i = 0; i < rxq->bd.ring_size; i++) {
+		buf[i].xdp = xsk_buff_alloc(rxq->xsk_pool);
+		if (!buf[i].xdp)
+			break;
+
+		phys_addr = xsk_buff_xdp_get_dma(buf[i].xdp);
+		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+	}
+
+	for (; i < rxq->bd.ring_size; i++) {
+		buf[i].xdp = NULL;
+		bdp->cbd_bufaddr = cpu_to_fec32(0);
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+	}
+
+	return 0;
+}
+
 static int
 fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 {
@@ -3623,9 +4069,16 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	int err;
 
 	rxq = fep->rx_queue[queue];
-	err = fec_alloc_rxq_buffers_pp(fep, rxq);
-	if (err)
-		goto free_buffers;
+	if (rxq->xsk_pool) {
+		/* RX XDP ZC buffer pool may not be populated, e.g.
+		 * xdpsock TX-only.
+		 */
+		fec_alloc_rxq_buffers_zc(fep, rxq);
+	} else {
+		err = fec_alloc_rxq_buffers_pp(fep, rxq);
+		if (err)
+			goto free_buffers;
+	}
 
 	err = fec_xdp_rxq_info_reg(fep, rxq);
 	if (err)
@@ -3950,21 +4403,237 @@ static u16 fec_enet_select_queue(struct net_device *ndev, struct sk_buff *skb,
 	return fec_enet_vlan_pri_to_queue[vlan_tag >> 13];
 }
 
+static void fec_free_rxq(struct fec_enet_priv_rx_q *rxq)
+{
+	fec_xdp_rxq_info_unreg(rxq);
+	fec_free_rxq_buffers(rxq);
+	kfree(rxq);
+}
+
+static struct fec_enet_priv_rx_q *
+fec_alloc_new_rxq_xsk(struct fec_enet_private *fep, int queue,
+		      struct xsk_buff_pool *pool)
+{
+	struct fec_enet_priv_rx_q *old_rxq = fep->rx_queue[queue];
+	struct fec_enet_priv_rx_q *rxq;
+	union fec_rx_buffer *buf;
+	int i;
+
+	rxq = kzalloc(sizeof(*rxq), GFP_KERNEL);
+	if (!rxq)
+		return NULL;
+
+	/* Copy the BD ring to the new rxq */
+	rxq->bd = old_rxq->bd;
+	rxq->id = queue;
+	rxq->xsk_pool = pool;
+	buf = &rxq->rx_buf[0];
+
+	for (i = 0; i < rxq->bd.ring_size; i++) {
+		buf[i].xdp = xsk_buff_alloc(pool);
+		/* RX XDP ZC buffer pool may not be populated, e.g.
+		 * xdpsock TX-only.
+		 */
+		if (!buf[i].xdp)
+			break;
+	}
+
+	if (fec_xdp_rxq_info_reg(fep, rxq))
+		goto free_buffers;
+
+	return rxq;
+
+free_buffers:
+	while (--i >= 0)
+		xsk_buff_free(buf[i].xdp);
+
+	kfree(rxq);
+
+	return NULL;
+}
+
+static struct fec_enet_priv_rx_q *
+fec_alloc_new_rxq_pp(struct fec_enet_private *fep, int queue)
+{
+	struct fec_enet_priv_rx_q *old_rxq = fep->rx_queue[queue];
+	struct fec_enet_priv_rx_q *rxq;
+	union fec_rx_buffer *buf;
+	int i = 0;
+
+	rxq = kzalloc(sizeof(*rxq), GFP_KERNEL);
+	if (!rxq)
+		return NULL;
+
+	rxq->bd = old_rxq->bd;
+	rxq->id = queue;
+
+	if (fec_enet_create_page_pool(fep, rxq))
+		goto free_rxq;
+
+	buf = &rxq->rx_buf[0];
+	for (; i < rxq->bd.ring_size; i++) {
+		buf[i].page = page_pool_dev_alloc_pages(rxq->page_pool);
+		if (!buf[i].page)
+			goto free_buffers;
+	}
+
+	if (fec_xdp_rxq_info_reg(fep, rxq))
+		goto free_buffers;
+
+	return rxq;
+
+free_buffers:
+	while (--i >= 0)
+		page_pool_put_full_page(rxq->page_pool,
+					buf[i].page, false);
+
+	page_pool_destroy(rxq->page_pool);
+free_rxq:
+	kfree(rxq);
+
+	return NULL;
+}
+
+static void fec_init_rxq_bd_buffers(struct fec_enet_priv_rx_q *rxq, bool xsk)
+{
+	union fec_rx_buffer *buf = &rxq->rx_buf[0];
+	struct bufdesc *bdp = rxq->bd.base;
+	dma_addr_t dma;
+
+	for (int i = 0; i < rxq->bd.ring_size; i++) {
+		if (xsk)
+			dma = buf[i].xdp ?
+			      xsk_buff_xdp_get_dma(buf[i].xdp) : 0;
+		else
+			dma = page_pool_get_dma_addr(buf[i].page) +
+			      FEC_ENET_XDP_HEADROOM;
+
+		bdp->cbd_bufaddr = cpu_to_fec32(dma);
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+	}
+}
+
+static int fec_xsk_restart_napi(struct fec_enet_private *fep,
+				struct xsk_buff_pool *pool,
+				u16 queue)
+{
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct fec_enet_priv_rx_q *rxq;
+	int err;
+
+	napi_disable(&fep->napi);
+	netif_tx_disable(ndev);
+	synchronize_rcu();
+
+	rxq = pool ? fec_alloc_new_rxq_xsk(fep, queue, pool) :
+		     fec_alloc_new_rxq_pp(fep, queue);
+	if (!rxq) {
+		err = -ENOMEM;
+		goto err_alloc_new_rxq;
+	}
+
+	/* Replace the old rxq with the new rxq */
+	fec_free_rxq(fep->rx_queue[queue]);
+	fep->rx_queue[queue] = rxq;
+	fec_init_rxq_bd_buffers(rxq, !!pool);
+	txq->xsk_pool = pool;
+
+	fec_restart(ndev);
+	napi_enable(&fep->napi);
+	netif_tx_start_all_queues(ndev);
+
+	return 0;
+
+err_alloc_new_rxq:
+	napi_enable(&fep->napi);
+	netif_tx_start_all_queues(ndev);
+
+	return err;
+}
+
+static int fec_enable_xsk_pool(struct fec_enet_private *fep,
+			       struct xsk_buff_pool *pool,
+			       u16 queue)
+{
+	int err;
+
+	err = xsk_pool_dma_map(pool, &fep->pdev->dev, 0);
+	if (err) {
+		netdev_err(fep->netdev, "Failed to map xsk pool\n");
+		return err;
+	}
+
+	if (!netif_running(fep->netdev)) {
+		struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+		struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+
+		rxq->xsk_pool = pool;
+		txq->xsk_pool = pool;
+
+		return 0;
+	}
+
+	err = fec_xsk_restart_napi(fep, pool, queue);
+	if (err) {
+		xsk_pool_dma_unmap(pool, 0);
+		return err;
+	}
+
+	return 0;
+}
+
+static int fec_disable_xsk_pool(struct fec_enet_private *fep,
+				u16 queue)
+{
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct xsk_buff_pool *old_pool = txq->xsk_pool;
+	int err;
+
+	if (!netif_running(fep->netdev)) {
+		struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+
+		xsk_pool_dma_unmap(old_pool, 0);
+		rxq->xsk_pool = NULL;
+		txq->xsk_pool = NULL;
+
+		return 0;
+	}
+
+	err = fec_xsk_restart_napi(fep, NULL, queue);
+	if (err)
+		return err;
+
+	xsk_pool_dma_unmap(old_pool, 0);
+
+	return 0;
+}
+
+static int fec_setup_xsk_pool(struct fec_enet_private *fep,
+			      struct xsk_buff_pool *pool,
+			      u16 queue)
+{
+	if (queue >= fep->num_rx_queues || queue >= fep->num_tx_queues)
+		return -ERANGE;
+
+	return pool ? fec_enable_xsk_pool(fep, pool, queue) :
+		      fec_disable_xsk_pool(fep, queue);
+}
+
 static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	struct fec_enet_private *fep = netdev_priv(dev);
 	bool is_run = netif_running(dev);
 	struct bpf_prog *old_prog;
 
+	/* No need to support the SoCs that require to do the frame swap
+	 * because the performance wouldn't be better than the skb mode.
+	 */
+	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
+		return -EOPNOTSUPP;
+
 	switch (bpf->command) {
 	case XDP_SETUP_PROG:
-		/* No need to support the SoCs that require to
-		 * do the frame swap because the performance wouldn't be
-		 * better than the skb mode.
-		 */
-		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
-			return -EOPNOTSUPP;
-
 		if (!bpf->prog)
 			xdp_features_clear_redirect_target(dev);
 
@@ -3988,10 +4657,9 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 			xdp_features_set_redirect_target(dev, false);
 
 		return 0;
-
 	case XDP_SETUP_XSK_POOL:
-		return -EOPNOTSUPP;
-
+		return fec_setup_xsk_pool(fep, bpf->xsk.pool,
+					  bpf->xsk.queue_id);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -4139,6 +4807,29 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 	return sent_frames;
 }
 
+static int fec_enet_xsk_wakeup(struct net_device *ndev, u32 queue, u32 flags)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_enet_priv_rx_q *rxq;
+
+	if (!netif_running(ndev) || !netif_carrier_ok(ndev))
+		return -ENETDOWN;
+
+	if (queue >= fep->num_rx_queues || queue >= fep->num_tx_queues)
+		return -ERANGE;
+
+	rxq = fep->rx_queue[queue];
+	if (!rxq->xsk_pool)
+		return -EINVAL;
+
+	if (!napi_if_scheduled_mark_missed(&fep->napi)) {
+		if (likely(napi_schedule_prep(&fep->napi)))
+			__napi_schedule(&fep->napi);
+	}
+
+	return 0;
+}
+
 static int fec_hwtstamp_get(struct net_device *ndev,
 			    struct kernel_hwtstamp_config *config)
 {
@@ -4201,6 +4892,7 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
 	.ndo_xdp_xmit		= fec_enet_xdp_xmit,
+	.ndo_xsk_wakeup		= fec_enet_xsk_wakeup,
 	.ndo_hwtstamp_get	= fec_hwtstamp_get,
 	.ndo_hwtstamp_set	= fec_hwtstamp_set,
 };
@@ -4328,7 +5020,8 @@ static int fec_enet_init(struct net_device *ndev)
 
 	if (!(fep->quirks & FEC_QUIRK_SWAP_FRAME))
 		ndev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				     NETDEV_XDP_ACT_REDIRECT;
+				     NETDEV_XDP_ACT_REDIRECT |
+				     NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	fec_restart(ndev);
 
-- 
2.34.1


