Return-Path: <netdev+bounces-254718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDlmIy07e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:49:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA105AF16F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FB8830DB56E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAD23815EF;
	Thu, 29 Jan 2026 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dKQmjmQr"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42453815D3;
	Thu, 29 Jan 2026 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682908; cv=fail; b=GN8MKjmxhQCjl9lgCPMgYEvRPAObTW6vSSd2d/JU0wlWwBZ9HIAA8k6OSCMOcyr1ydAjJKFuyz+5fwDP5DBRhVqJivQlfG3Lb9OleLmm52pGTof1RpXGY5O8EoE29c/iHAsBpp9IGox9TtOTQ4a7Sx1DNnUwjBJ/LKKDvEHmptY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682908; c=relaxed/simple;
	bh=ceYHAtnTgF0dgYuXzGS8iXZ61xOa4wwFXE5dhcwJTRk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DgERBK1AgjcUl0s6fc5aPCM0oR7kCG4HssIEPSRQpTeuW5dOzouj3XTFXSb6rpv4gdo5b2sTKID1FrmiEldhM4ZHYRyEzHmHFU/vClcH5hC6QieP1X+KgsoFlAb6omcq4XXbQwlUyejOKQP5bMxUHm8DG5gFyo43zw1KEfdo0bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dKQmjmQr; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHWn9jBsl+KtTHwe3hCHVM5LEG3TC1TBLC3nJMts4k7Du2nk8kQeIhigYyL4wt2jKn8d6gGA17f5Xe/0gA+1eESqUSmlG88Ub3uoIBMN3x/bEoUOyyfak1RmHMYSl4elCS8ulWPygr/viwcDkWphCQJH75K1zukg3p8wV+ijgVa++br9PAT+P/JfeZvR7XK7AfznxnlndyTWKAg/FS6b3XghoSUJSXr0wHiRyZXHnNEcBWx7cBKbEAtNSIfL2NAUN8M47usP+SHduBLWmQp4z9OiyziTWwkLN+eeAg5smONaJ6JNx7PtXKpCI/yWGXLu/cvg7cxxp6bMaOFKuFDdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFUrcqY9j96sFquhBhGLomOcCwfSiKDJBZ2pKrmBQ4g=;
 b=HMWbL20yX9woKgzUV6dX1FDq5r5K22qtjYlDXEsJ/pXuef49OPSTRIJR9ao8iteR1FddDoeb+AXGZ3WiXmJoHVv2rs+GfyEovQuTKtKB7VFP7WbK68vOUeasicANtJ+uMFGfXJTXiJMnfh0pNTjUsUhgef+XS93ho62qrPxk3dNxFaUmm21yO5NcxYhmeZuAOLnDgarUVa3BnxK9D2B3KgE1uLBP3LN3mz5//48d3NCl639KHDYzvagicQs6jy9Ib4urzVWbUjo4IRKKnjLO4l1sidAa7tVUiwGpSbS26iqrdbbSyYsQc4Q1Ngt5/zjMXRWbSH22uoMAnwsYhNVIeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFUrcqY9j96sFquhBhGLomOcCwfSiKDJBZ2pKrmBQ4g=;
 b=dKQmjmQrePn6Y02okdpy16/g7+PhccSHo81NObOkSZYBxiGhAEplQgyAQjpeBeNWSob3cBiWIhFk9DjIMIkXYjwtMpqUu8hAj3FRJgf8eLTw7HpYWySunhGLlpbIvwYebOyPbZheELEoBO2k41MgPnQpR3cJLhoVLgrtDT0oubRvk9coEVg74erREbLGvwWq8G6Sdhx5bM86qQ6Fb3L2GShNknFuGasuYcOGsDj7hRdmRTPvDYpp21rxx+XZ8/rryC3ahqfNE/IPrasFxcP2NXu8mfaZ9Pl1lmxrwM48THA+CJ3U87P/w/ucfuFC5wS3loHmnj1wAkx9tzy5D5U1aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7264.eurprd04.prod.outlook.com (2603:10a6:800:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 10:35:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:35:03 +0000
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
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v5 net-next 00/15] net: fec: improve XDP copy mode and add AF_XDP zero-copy support
Date: Thu, 29 Jan 2026 18:34:32 +0800
Message-Id: <20260129103447.1893129-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VE1PR04MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d3fa9e-8490-4f7e-01b5-08de5f220fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MiGoTDV7CebtGqc95zZfcFUClRMwKyJWmGjFr/lU6VJ+dGKc1DKyr46Mj4UA?=
 =?us-ascii?Q?iqvDnHLYLV8QX2Pj3VeabsKRvIq/FEPO7ZDjs3ezAqsxh/tEEUY0x9o+iIdE?=
 =?us-ascii?Q?wJywWBA/1jmbGFuofuPL2/GHChZQtu5dm5tjIp04EiRWpJHFgWhWkFnZAgZo?=
 =?us-ascii?Q?QRl1yLe6+9+JmbvSN4MkSDmAa5uMRTwk7PDRPpCmvupOxhG9c5GRhU5v9Ma1?=
 =?us-ascii?Q?U4wRil4l5V8KNaAtKqORaI94IusKhcekHpRSYHangfDbEejInYcnduTMQ9Rk?=
 =?us-ascii?Q?5jzP6rICZAhxzFhIRBFCRrVcxX9nvPkGm/JDthDsL7Yk9EMoGi2RIvY78hc0?=
 =?us-ascii?Q?SslY1kZxjfED/x+mnSpX0qE3Zhn74eACkebPnMoh3XqWdGLhyAPjVMayurD8?=
 =?us-ascii?Q?2eGlYFtpV8rfcmqzd49NRP1Y/J5daIU0GjLGVYxgiIWFO1wByEp4B5bRFAzy?=
 =?us-ascii?Q?vy7JMTXLBqEFyZt0JSugTkonMnjpyt4ixb9oOhZin2WdL9Lmayck2D+qnpTy?=
 =?us-ascii?Q?rVV9hezufSVk0fbACVcWAi+8R3S2U8FzxfOVB2eQF6bmCD0bx+86TrFEyE62?=
 =?us-ascii?Q?NCLn+l9/shmkFCVilVtZo+bSCvfOBmLETdmijexhs5grm1USc+tHl89NTStu?=
 =?us-ascii?Q?ydLu+fRM+H5rd1FExayHYJeCRRcEgNVl35Nc/CFX2LGSgkXE5V4qqg09oP4r?=
 =?us-ascii?Q?QawZJwaQJNsAuKrBZc7yt/H80ZJ52UG1JgBDr7EtKrCY22rVyPI3JKwXRj/i?=
 =?us-ascii?Q?96gVw3YdRh056i3kmy+AcVKAGhoOfoJno4iYoxjXE8E1Qyr+kwQZCFyOlX6B?=
 =?us-ascii?Q?11EK8QwHSmEwpt3RYEG5Um9fs3lbHMbGu7wI0gEGy2UsHfgMckbfUIv3QvDz?=
 =?us-ascii?Q?ap12V790TR7RsmaxJ/JQg1Mtl59WSRTSLPebBD2Fv1ayTUuLw6mKBGapDqS6?=
 =?us-ascii?Q?TOnpEh9EZsxASTC8mzHLZusgJoe+crMv2j7lHFLUYznXgU1WrzxZ+3Vq5hyy?=
 =?us-ascii?Q?Roz/welWK/HH9IeSIZ3yZG62K4Kxs/3JlJMg7I1l42uL4myXZSiEksSTqfmy?=
 =?us-ascii?Q?s9qQ40J0DmR73KiC99sTlNiRrd2bVChN6jpZO57i1MtmtEd7eGzmJcBq4uSA?=
 =?us-ascii?Q?dlrn4DHYxiAHHqrxOFnnUNe6LXlt7T9DCWv384g9oyACETGbOD/xaFGHPf9x?=
 =?us-ascii?Q?UqzoKvk7hb0pN3gZcSgy+VHr7Fk7+Kwt7DvXFkJO/QM3Sqn5/ZoqrIp+TKf0?=
 =?us-ascii?Q?HWVjRPT+SgnEWVW3C7rPdZ3j7h1D7WDfTu1vZsaRiTGb+WLlh0Q4n4xpGxJ7?=
 =?us-ascii?Q?8hT2PVhh/mxwV+Un2GaYhT4ORmeJhLlldj8c8okAsFeqp1t7AYjG1EVGN3Fy?=
 =?us-ascii?Q?D4qDmVv1vNK9fk/7zEXSNqrblZdnq1WYH+G/i5vEKIJFPKIpTjHTmVdVznsS?=
 =?us-ascii?Q?uYtBfm3FOzOfelxhRmZ2qad1NIYT1HeRmmDZucK4R4I56OcS/FwliYsfwqw5?=
 =?us-ascii?Q?vCM7bQ+PyQC84QnXhdjVedgTTPuJfjYciJO0TSz2HT4FlQQWIMjsmeg/OxOY?=
 =?us-ascii?Q?JSVBCwexm7Nj+bZS3e0DfYXbNQydn7aRhYXhOvfUqogAeFgAYZJpvgwrs5Nw?=
 =?us-ascii?Q?cjZZ8cZ1HG4snfsRrR6Cnw/kfr7XkBppkQbpLAze1/ST?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OOzyBSWI9BP8LcfDRtwftM0qJP6rYjSrD3EvY4evFYkFut0vN+lgfSOZ0bZF?=
 =?us-ascii?Q?cKRymfo5bFfurltchHFA0W7DGOG/x/C6y6c1tMo+WNGmfJHkWSn3xUSgqyRp?=
 =?us-ascii?Q?LuJy+TKhCyNoPwbAoqg8h6KFZGqzsVHNnVinzQkYaCjGbJtRSb/OHFxRQRog?=
 =?us-ascii?Q?DKwiy5WN7PA/t2ie2j5DU+YSLY/peD1FiOk/DJ8fv46/KUht2CWKxM7iFpHF?=
 =?us-ascii?Q?pY8DGjgzXzkKSytT2bry1x9hE72u/s6ltAHmR0C/eYpykS3S4Al1/7Pl2EMk?=
 =?us-ascii?Q?i+iSk4RAAXRaQn6FBHIyB+LUkp9tKpDWwYT1/+J4BG0hS+plv0o+F7/qPRzT?=
 =?us-ascii?Q?GQR0YikBAXROhSAw/R8P6I+2IMQesiSIB3HIA1awxvdGS3nNCXB/3baWJeGZ?=
 =?us-ascii?Q?pvmr4K8JVuPrndLkLKF90Rlc7wg83SnraMVnRX3k0FyTS7R8qBjjW334IDkd?=
 =?us-ascii?Q?1Q6sSKLRVOLQh/nhYZ/vXDaQksPkj3SUsE5WKthzH1r5XZkWx3QexlKlWZgw?=
 =?us-ascii?Q?gbonEGlJhvFrd/9eTDGzyV6j6vpWmWx3tTSQTW4kD7Zvcs/LVy9xvssLpe+I?=
 =?us-ascii?Q?5eOZMTHIRC5U4C6W7wMNplovF6f1cAjL5yNcif8n2/CYuc/uOVydgk82U/KT?=
 =?us-ascii?Q?U9AZSgo6rOXuOiOL/+WQLRlFbr8Rtw+wfu34I/EHMEvRuiLFAR320mHAf445?=
 =?us-ascii?Q?dDwQ4VgU6wBOmpZ4OpdRSX8wzLZvdANs4r5o5YM55kOgoH2xtZgt5Rut1q+C?=
 =?us-ascii?Q?wi8GNDbNV3PIilE7Lq81KuDMTWWUnoUMsrRKoMOMopzvfOgiH6WzpFepIdTs?=
 =?us-ascii?Q?CqmMdbuk+0ZkiIaONGOFiAP8J017L8f8wdQIhpb4Msz29TtKCrMRHYNvVmrf?=
 =?us-ascii?Q?cwlergvDGIz9KqKIbH+hXWerfWkcPfPVIgX2DsRcaXEFXca81U7TY3fOxUFF?=
 =?us-ascii?Q?QHMhg3Pax1sHwxfgZMsayGO+QV/MaXYTipq/VOyIkAREg8uVzvj0sFCbZfiP?=
 =?us-ascii?Q?2eHLVHV8Pm4AOUq/GIE2xmWOnlqQmU+EjDDMNrFIvssI6fZ7zniVtWLvRbxB?=
 =?us-ascii?Q?FV+wGo2r8ms/+iDE64WPTWnQhsZ/wokJS41UuE2S+tw6Dp4Wa0XiWcZ65MAF?=
 =?us-ascii?Q?GdEH+bM5Iqn9JisTFDSouJZ54EKpptMFlADDlcbd52YEC0B2efN6a7qY53bp?=
 =?us-ascii?Q?+hDNPe1zMwnSRGTk1SymM7CFrZ7tcEBmLTKRkMlX7qMc5Ir/ya1aFvr/lhGt?=
 =?us-ascii?Q?MkFFrZPiEqPAhB97TdkcoU5JqSraObxat5iEaf6cY7p+SmaDoBIGaF3N9adu?=
 =?us-ascii?Q?qQaSyrnGtvQceO4zSL7tEKjMQxaJfOipIj5yEut1pDUGDtDzQlBcVZvxhzw3?=
 =?us-ascii?Q?ltedC30QRXFqhTyEp2XBnViNBiMKj3JvA5vbuVqT549loLlXXgMNlEAoJtOw?=
 =?us-ascii?Q?aNAukpkrFcWwUzBjaFgi5CUbV0/80LRqL2HFxD1uGFiNzWs6odxs5s2foW1x?=
 =?us-ascii?Q?1c0uIGlqR+nQI9TOZGhKiF7ctgbL8Reiy6I5pf2+U53bQOWLAIlO3V+yBYP+?=
 =?us-ascii?Q?iAqQOPxGR0Ln0YbYiZLPGotk4nPi5zxdKfYLe5OsstGsMwN0EGdaLtvzN4e/?=
 =?us-ascii?Q?BgrPe/KesMKVGB8nCBZ//MoDvRoeEIObUTyInAGWbccm9+8zFUiLJDI4pyoF?=
 =?us-ascii?Q?hymJAephEmTYMCJDiJCJP/h0CHDZSCJi/fTXJx5goM9XaHFlWKZ1KQZhYDQv?=
 =?us-ascii?Q?tokBfw0JaA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d3fa9e-8490-4f7e-01b5-08de5f220fd6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:35:03.4299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHd2lPBwPP9J1j2LerhZD6WATicLylpwRh0evH0RW2HkprGSyyNp6MWyqyORIVQJhD7va9AafwrsDFNTAdR+JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7264
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
	TAGGED_FROM(0.00)[bounces-254718-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imx93evk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,eth0:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: EA105AF16F
X-Rspamd-Action: no action

This patch set optimizes the XDP copy mode logic as follows.

1. Separate the processing of RX XDP frames from fec_enet_rx_queue(),
and adds a separate function fec_enet_rx_queue_xdp() for handling XDP
frames.

2. For TX XDP packets, using the batch sending method to avoid frequent
MMIO writes.

3. Use the switch statement to check the tx_buf type instead of the
if...else... statement, making the cleanup logic of TX BD ring cleared
and more efficient.

We compared the performance of XDP copy mode before and after applying
this patch set, and the results show that the performance has improved.

Before applying this patch set.
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   396,868 rx/s                  0 err,drop/s
Summary                   396,024 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   684,781 rx/s                  0 err/s
Summary                   675,746 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   208,552 rx/s                  0 err,drop/s
Summary                   208,654 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s

After applying this patch set.
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   425,778 rx/s                  0 err,drop/s
Summary                   426,042 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   698,351 rx/s                  0 err/s
Summary                   701,882 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   210,348 rx/s                  0 err,drop/s
Summary                   210,016 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                354,407 rx/s                  0 err,drop/s      354,401 xmit/s
eth0->eth0                350,381 rx/s                  0 err,drop/s      350,389 xmit/s

This patch set also addes the AF_XDP zero-copy support, and we tested
the performance on i.MX93 platform with xdpsock tool. The following is
the performance comparison of copy mode and zero-copy mode. It can be
seen that the performance of zero-copy mode is better than that of copy
mode.

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

---
v5:
1. Update the commit message of patch 6 and 13.
2. Fix the potential memory leak issue in fec_enet_alloc_rxq_buffers(),
so free the buffers on failure.
3. Only initialize bdp->cbd_bufaddr in fec_alloc_rxq_buffers_pp() because
the other fileds of bdp will be initialized in fec_enet_bd_init(). And
move the initialization of ebdp to fec_enet_bd_init().
4. Refactor fec_alloc_rxq_buffers_zc().
5. Add a check to rxq->rx_buf[index].xdp in fec_enet_rx_queue_xsk(), for
example, for the xdpsock tx only use case, the RX buffers are all NULL.
6. Refactor fec_setup_xsk_pool(), so add some new helpers like
fec_enable_xsk_pool(), fec_disable_xsk_pool(), fec_alloc_new_rxq_xsk(),
fec_alloc_new_rxq_pp() and fec_xsk_restart_napi(). This refactoring
ensures that when fec_setup_xsk_pool() fails, it can revert to the
original rxq configuration.
v4 link: https://lore.kernel.org/netdev/20260123022143.4121797-1-wei.fang@nxp.com/
v4:
1. Remove the unneeded semicolon in fec_enet_bd_init()
v3 link: https://lore.kernel.org/imx/20260121033357.3261464-1-wei.fang@nxp.com/
v3:
1. Fix build warning due to missing break for the FEC_TXBUF_T_XSK_TX
branch in fec_enet_bd_init().
2. Add new patch 7, which is separated from patch 6
3. Collect Reviewed-by tags.
v2 link: https://lore.kernel.org/imx/20260116074027.1603841-1-wei.fang@nxp.com/
v2:
1. Improve the commit message
2. Remove the unused variable dma from fec_enet_rx_queue_xsk() to fix
the build warning
3. Remove fec_txq_trigger_xmit() from fec_enet_xsk_tx_xmit()
4. Separate some new patches, patch 4, 8, 13.
5. Collect Reviewed-by tags.
vl link: https://lore.kernel.org/imx/20260113032939.3705137-1-wei.fang@nxp.com/
---

Wei Fang (15):
  net: fec: add fec_txq_trigger_xmit() helper
  net: fec: add fec_rx_error_check() to check RX errors
  net: fec: add rx_shift to indicate the extra bytes padded in front of
    RX frame
  net: fec: add fec_build_skb() to build a skb
  net: fec: improve fec_enet_rx_queue()
  net: fec: add fec_enet_rx_queue_xdp() for XDP path
  net: fec: add tx_qid parameter to fec_enet_xdp_tx_xmit()
  net: fec: transmit XDP frames in bulk
  net: fec: remove unnecessary NULL pointer check when clearing TX BD
    ring
  net: fec: use switch statement to check the type of tx_buf
  net: fec: remove the size parameter from fec_enet_create_page_pool()
  net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
  net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page
    pool
  net: fec: improve fec_enet_tx_queue()
  net: fec: add AF_XDP zero-copy support

 drivers/net/ethernet/freescale/fec.h      |   14 +-
 drivers/net/ethernet/freescale/fec_main.c | 1641 ++++++++++++++++-----
 2 files changed, 1252 insertions(+), 403 deletions(-)

-- 
2.34.1


