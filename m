Return-Path: <netdev+bounces-257061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC+1IAZdhGmn2gMAu9opvQ
	(envelope-from <netdev+bounces-257061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:04:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD14CF03F0
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17C0530135F2
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4580F3A0E84;
	Thu,  5 Feb 2026 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fa5Ty6aR"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797738BF93;
	Thu,  5 Feb 2026 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281819; cv=fail; b=n3EXGDCCHFpoX3kOwcpK5JY5+SI57kUGt3REjw36DQK0UYXiLSJ/K8lZa209HrYTzw/G15kT9VR2VO2qWgJjeJL3Dll4hGm14BIgc7B7etNmNQyyq3X0Iq/WpmUu0OaBHlxaeGnQo9gvu8M4wbNFk3gliIK1r5WL964LMcNPCyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281819; c=relaxed/simple;
	bh=7yAo/AhcEsnfRPwLDAVkKhIkGGOr9YHybxl+3pkG6K8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SusPyZBOrjb9ZIeJJKM2eJiw9P1nYqC107sSgZHenPN8+squqOgaF14hWc7Sk8I3ZTYF1o/iCM/1m+Gizlsg8a4vt5dIGo+m6mf2+rewrZugf4eXymQ3JP+zcK5LML+vLC9odzPWTxf85fVTzdGUwYLLwmSZiXQBA1KzJTUgNo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fa5Ty6aR; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVgx+ngwLpniYD6r/iQwPjE3O7MT4A3lNvS7VaUFxhL21QEU2CCiBT00OEFSyzQFBDbZ7vhvrougO/s11/tT2UXHzONCpXyFqFN29pzx9keB0iztgMJS0QFsJtnTRQO9Nxsx09NUs6vLPIN7lGyA7PbYQMfMApXKtvUY5nQX+rD7UZw6lR2RfxAARq6RWa+91uQvH4juGUQoi/09vY8bBpc9M04CDGf8aG2hydkYfalvREiBnGMmR+LEKtjYGcIWVQUei975iw0IV8dYnsVbLYojg7wWYr17j8Lc5OZZoiYuvLe9ZK2z9XtUq4ilPqUCYzyLNl0HginLIvDleHqyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOVDfOOtgMrwVbTMsrVHxRSSp0oQN1DqkJtwetJVQSI=;
 b=iY5LcsgCigO1MmfiXD2bC7k2j/S4lkI9loD+iFYwS8scGxDMUFar9+992SoD3T6rxHfZdvGz+v4gKjGsXTNgiKjPYiwXNiGWIlYV415qJKh0tuT/FtNDIVv20TBRkVOTAll02RMyLQQj3KTByRzeNX+s2p4dBX6aGUoptl5H2ameJMXcuw1vj49mAJt9F7t70fo5y/Aa+5vRY9hpOuM+8PxlXfo9cX7xOkNvZWLSM08aEToSImxVsB/zucOp7ZWk6hSk15GdmT8ZhUE8PJEJJ6zST4OzXwo4c+hUbiOYQu0ut/jnM+jZ64jbXlOaY/Sx2xSJhiQD6jClBshvzSeUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOVDfOOtgMrwVbTMsrVHxRSSp0oQN1DqkJtwetJVQSI=;
 b=Fa5Ty6aRUB1ss9NXJ1jqHh4SnWdN0jz7G2VEzGVo2w7+/nMtuOYmrn6FvIVlXR3pWzpR5ChfyHmL8KBRgV9pmD/DhU/6gMAskCW5iEBC4iCgyICh1+9rj7Zq5rXWNRIqyMY4mJaM2y0XReYa/VI6QqCDlIZ2drBjt1C1/VB07uG/MIc1DT6TSxxsqSJiSm8X+PG4dHKxrpE2V2xwJ86ym87xaa3XiocotFnKOxDSLjSkcn4yFnRnOfrDpv6tPTYLfKKpMrjO9G+7ukTaVQsnPLX7gt0E7uUvaZelN6gr5AL92L27OUrgacSJiKTePiui6hBKmo/cNjdB/uR0RLFPSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:56:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:56:56 +0000
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
Subject: [PATCH v7 net-next 08/15] net: fec: transmit XDP frames in bulk
Date: Thu,  5 Feb 2026 16:57:35 +0800
Message-Id: <20260205085742.2685134-9-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c083d9a7-95bb-4263-571c-08de64948390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q0JiBMIL0ZznyTyaHsxhJ/vpVMdAEbtjovayRQi1r0xITSusKDHcJ0wCzXlX?=
 =?us-ascii?Q?XFqXu4dXxKy+D6gex9cWo1WQztgJaDtN5VDmiBgTAHDXR6770UeWS3Kb0Wr9?=
 =?us-ascii?Q?QCm076lNY5QWjCsTzAD1BgYo5IhAvrik3GRHWTGdUnEO3Ng+581NSrz1tTbj?=
 =?us-ascii?Q?oXTjAo5cQmQ/YKPXKPaFEp0qGVGxNMHeRQ2sWqoRRsLeosYR35E1S31V+Uel?=
 =?us-ascii?Q?PRZ6f234FrLvHxAXH7ZX3IBfBahRWWFzbwWBsCAUWzAeslxRpMwkdpmNsu85?=
 =?us-ascii?Q?BE36KITd3n3JbQty+XX52SHZZAvv4aiQunVpT1LIyeXdEvfDHXgB0ajieSW5?=
 =?us-ascii?Q?EAIxebJg79Mp9udoa0GwF2A1RgkW55G5CRq8JhRPiKYoL89wqDqCypUcVRBU?=
 =?us-ascii?Q?5VX20NrdgkLYOpy9X8kDcHgbFp3YYtPQwBKLu7i76Wh2jTgoRCHYMbcbCYEd?=
 =?us-ascii?Q?C/+1GlvpqvnSe/a7ZHIoRqHk27YU2H05TaTHJxBtQD9sd6vBayOTzuZvmAUg?=
 =?us-ascii?Q?BJzNWXJnHdvYDDxoYTxlYVoZUumdPxqb2xvVh2O9Lg/0cg6WZZPrXtsp6F2E?=
 =?us-ascii?Q?VXevhJfPaz+BNsSIAekp1Ac62EEdANNcEC5A4aD2ydFm26IBfP/WZKRcQhyO?=
 =?us-ascii?Q?QivbAwuxFIrGmtvsO3JC9ltL3r//qOZVBx6IAV5DTwAePJsP/FtgHsC1amqD?=
 =?us-ascii?Q?90jTneCQ/+uX32wefdrh7I2Xp0mbSYJHEGS8cZWsPgJB0/d6MHisUsI3S/y2?=
 =?us-ascii?Q?6dZoYOJeFkNha9hB5Iw7kejZgh12Ht3ET1MLWQQjn10wKSTHapFEhtq5gevo?=
 =?us-ascii?Q?ck6y3AODCWdOMbfLCoIlNh3JPcji9bqy4m+YP+D0rLxIehZO8e6hOkCFwzlp?=
 =?us-ascii?Q?Ly0cN7BlwAzOaqXHojB8zjUUJMSVsfdvUs6pv5+J5t/5/69cVdT1oCCP/23n?=
 =?us-ascii?Q?yqFazFKygGYmYup8hUDhpwZVCAOJVR3SRpfrGvJIZORIKacuVqajn3afcGUn?=
 =?us-ascii?Q?0WhhTt9PcLaEAsxKrqoG5YnOmJ/jYBgvgOh6SLM6ipLK8oHZIJZw4kudpKAq?=
 =?us-ascii?Q?iZ42SQBPeKCDBlZvrhEryfXQLNUzpkipa7Oz/2eGVQtR28cBOCjOmLD8SCHl?=
 =?us-ascii?Q?ZpMshDLOMzQ7aFqBluuFI2UjjGSWo9AAYnDrIcNCZV6UbpfQe8IZbGw9+cbt?=
 =?us-ascii?Q?3Jmj6Fd37yDStsHUlTMDZM1OkaupqKkTQEbCCqoqjkwbbCJF/4nBbcwND2QH?=
 =?us-ascii?Q?sxbmgoP1EL1oJAlDIfRglzsUL2bimn9yOotWbie9U7PGhFbXyeSQxhGdw5AR?=
 =?us-ascii?Q?LA2vUPizPdsCkOljDIxbVNbCoLeqH+fljdECwmNmFBZACZr1rDLM5fqbGW22?=
 =?us-ascii?Q?sztuqw65Z7XPQsYWpzzSkA4jAfcz7B537IF/wqx3L3XfTpjtFH2MouhpUT9A?=
 =?us-ascii?Q?902FtiO3N3iRDnHcVgeNPwEIS/iAmqdRWOYwwzQSpqXOO9/5iQGAsd0gdU9t?=
 =?us-ascii?Q?ztjtOIXVx6EAWdvSGXEtaeW92CYKmiSLzI5BW9VjbJ92G13pO+gl2WKnFF2x?=
 =?us-ascii?Q?UMnEAzi//TfEb3RF2iiQkKv2l/FHzqP+hJMNFYhF63ZNOzcFCWffhY7lgxPG?=
 =?us-ascii?Q?eN0PFGtN27+ujmav+JyB4GhLJlANrNY0ygh9WRs9vBfT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQK7p2plpYNrWhMYj53S2xWX9Ao36FMDJ9JUaq73JU6X8n1jEPSYqptw1No3?=
 =?us-ascii?Q?R9qKl3LvgyB+7D6gEt+nZszismwTNLD3IsLBE2aDlYHbOFc+dqiY+lm79Qp0?=
 =?us-ascii?Q?H0cDfPtoCIbmVFP4I9pX0hODftGeXCZYEULGLH2b8sBJVeEtiXb0wFxP2ZFM?=
 =?us-ascii?Q?trLImb5L4Me5Krd0WtAzQtRKkQKCyxqekZdKjT0kjLWSPfWMr2kFZqihhI2i?=
 =?us-ascii?Q?aQnUSBJeqiiUTzPLpDF0/mHRKVV8R1VN8cjND8FX/ivXIgLVQYlknChGXTas?=
 =?us-ascii?Q?5MV5SkktcQUlkgaiyzr6Hbqu/4cF0rvugQU6erL/GI2mBk72SlDauuKrr20Y?=
 =?us-ascii?Q?+GTw0GWzakvprs+5GrpPRSToH0m+0hdVmx/uziB0wXH0EpfqhT+kSUdefpOF?=
 =?us-ascii?Q?xdKoG+ndIUWSMTCpu2aY6HTGoOlDwImUxzlFQ0R01RftYVysbXBJRwBIUa+J?=
 =?us-ascii?Q?Sr+XGf55ggt1qvMRoriToi4LsBaGKQ14coDk0FxQ8bQ8NsuyGm4m/ndAWnFf?=
 =?us-ascii?Q?zvr7/EeIZAAWX630GxTgMT2571VtgkgYy7xN6bslNDItosy1+YczuHEAxRiH?=
 =?us-ascii?Q?DZEvParGjRNBrAe83H8Jcco1YQPAPW1D2iACaX2XhDAc8u6bhhT+ARUAb4tq?=
 =?us-ascii?Q?kzjOpu//2ekpzv0B03RLF3n9fx/CkyG1hwLMXJyqhUEBvv007/EZJ2HL0yK6?=
 =?us-ascii?Q?TliblyFMBTgo+TrFVu+oSlfQkDU8FUPK6HspzMrdOeAAYNgAYZbkGYSPC+ow?=
 =?us-ascii?Q?V8q3+zuls7yX9/SFnhXkUNnFNfpnqo/SMqLIZcfxNEwDYJrI0j0+uTlQTYFo?=
 =?us-ascii?Q?V4yxYSwIvLd0dpr+mB1eiOGJVMQF3Y7qjltQjuhmp4DEBQ/TegoMQqGF7fgj?=
 =?us-ascii?Q?R7K/zNAxN79yZKCcnbO4lcE514A1AZpoCYb5XZuHiFEiVaZ9blLx4ggw3JbN?=
 =?us-ascii?Q?MLguTXpFGV3/LLlCMi0HUQj8bE89fTvj5VrNazn7JwXbBNdKHe22G78b2kVZ?=
 =?us-ascii?Q?/46zAVyl78y/L6qeR1Jt0LYvXgq561P4xaF/bnPJAs3p8GfryIZumDpUMvdP?=
 =?us-ascii?Q?uG0+n5Lgd2ktQlzxtAoPEiNgAiR/uQ+n+fXke8FfSDjsGS+5BDsgHO/jlTzW?=
 =?us-ascii?Q?Dw7U3yYvVXXKgun6H8kg+ahbIcDk8O+4AdfWsclVk0q09R55oFdq4S5G3PUZ?=
 =?us-ascii?Q?N8ra8kIE1xWopjrcpMr7Uhm688adS+9EXx6Z6qUJyeGq1NV3aoE51osH1OGo?=
 =?us-ascii?Q?mAeBD1XdJKRYJDZtnBt6qtmHmOk3aFVUZ+DfMwugk+SPC/Sd9lWYNXQ4m0QL?=
 =?us-ascii?Q?OoU7rnS8Lk1gCPIZGaKrskQnyWjyBcdKySYNMo6cYGNTpfMk1PGlMzehbkGn?=
 =?us-ascii?Q?Ybdz6u48+Ww70T4U9HHW87X60sKrG1fJeB5pQaIh//Q/+5OwlFOprdY36Hqw?=
 =?us-ascii?Q?3naiENV3r9gf/z9mD3Rmv7k57O6sM9bKJhT7nThWWAm6RomWGtrjVpVft3OY?=
 =?us-ascii?Q?IQ8rzg616clXhNUFgA6/xC2ztFWIY0ow8ndSYNn22em9F+q636+kWT0Apadi?=
 =?us-ascii?Q?Qn50t4sQlPYq4hfbxzPMahpA/lhIIZ7QQp4fQtMXRrI4Oib1g16exktatKlZ?=
 =?us-ascii?Q?qt2puGtoLAuIeWaOWNeFQ8PQY9ePlpyZBgotF4Q366Jh9R3Xx72qCPSSf7j+?=
 =?us-ascii?Q?0btWaF9Mrha0w0RHMSOUHSLExHlGvf2pxUxqwdjt/dsi78FPBByz6QXXmOXs?=
 =?us-ascii?Q?6weJeDROwA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c083d9a7-95bb-4263-571c-08de64948390
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:56:56.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53jDVMhUDtpa6GjHqF/XnV1nlFjTZGpJ92G1CM/hZEPtSB0wc/HnoWMN1Ywu/TXUqDS8RC8Zym5kXmLTNpSjww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257061-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CD14CF03F0
X-Rspamd-Action: no action

Currently, the driver writes the ENET_TDAR register for every XDP frame
to trigger transmit start. Frequent MMIO writes consume more CPU cycles
and may reduce XDP TX performance, so transmit XDP frames in bulk.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index b2a6830e6c9b..fd89947c5f5f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2006,6 +2006,8 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 				rxq->stats[RX_XDP_TX_ERRORS]++;
 				fec_xdp_drop(rxq, &xdp, sync);
 				trace_xdp_exception(ndev, prog, XDP_TX);
+			} else {
+				xdp_res |= FEC_ENET_XDP_TX;
 			}
 			break;
 		default:
@@ -2056,6 +2058,10 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	if (xdp_res & FEC_ENET_XDP_REDIR)
 		xdp_do_flush();
 
+	if (xdp_res & FEC_ENET_XDP_TX)
+		/* Trigger transmission start */
+		fec_txq_trigger_xmit(fep, fep->tx_queue[tx_qid]);
+
 	return pkt_received;
 }
 
@@ -4037,9 +4043,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 	txq->bd.cur = bdp;
 
-	/* Trigger transmission start */
-	fec_txq_trigger_xmit(fep, txq);
-
 	return 0;
 }
 
@@ -4089,6 +4092,9 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 		sent_frames++;
 	}
 
+	if (sent_frames)
+		fec_txq_trigger_xmit(fep, txq);
+
 	__netif_tx_unlock(nq);
 
 	return sent_frames;
-- 
2.34.1


