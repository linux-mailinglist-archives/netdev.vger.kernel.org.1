Return-Path: <netdev+bounces-251751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJmGJQxKcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:37:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0918D5079D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51C5F7E42F2
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76E6374181;
	Wed, 21 Jan 2026 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K4exjnX/"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7273136E49D;
	Wed, 21 Jan 2026 03:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966486; cv=fail; b=bemXn60iIfePq+dfUktViCXufpzPRh/vR39S8IxYDY8FDtWtpy6K6KpUcMFtVQls1dfEFdYR4oyqA9DxKjiCOKK3Mo5jCsSmH/owrXNdV5JNZa/4pI9gVq2qU5K1QqknqppAQN8v/OWgmNqEJmk7/bf1mUxherKUU9mgQW0qSY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966486; c=relaxed/simple;
	bh=PKnRTuy2nCS0OcVjBuU9b4aY9YxdjxJ7X54semzTMG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gLYrnpNt8/AOPqI0XACMR8svkTtTS3BHgjJy+rsRx1URv0/rLWR9a7Yt98o/N3esCvluSB9hKHGVmXbdIJByPhYC08qyayypx3u0D1hPDn6cscH0srgIvnZwf8CGfr44PdccIJj/xG+UMGF1C36MdGaJbz5QF0AUWjsIXitt18U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K4exjnX/; arc=fail smtp.client-ip=52.101.70.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gad0Yp1UNtSP2rEq13CuV+56kSF3GCD/2NZBX3nuvVfrrG9/3DSqa1RfT3gwPugmhO++wCoesi3PWwf+3UYe4YMU/NQoNv2jafC3t3srBWPxqPXVyP0LfazIKBRD8Dblakqy2poUVZ42kuK8IfHfsa2SeJTzsMUTZ9z9OR8jMysPD6v+IWkFuPOFdV4amw3EAPujmibclztFDopk+oiE7qe8JBGXhWLf25Vy/BwdDlZa/YJt0NZhRLF5/pLBtsDJCSy1wM7h7El3x3Y/em4bLzHAY5wALnmkhMJlMg+Ce5E3uTX89aeYOoy67ceQ5OhQyjNhuaaWpkY7X8xWxiShNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbHEHZYT8gvspdSmk5ZMSEj0QwUFHSSXLoZMqEr9J/g=;
 b=GpkW3UbuixoyaMihNbPpFTjUDqlWMwLLzG7oZLDsDwtTGYMU7M7mieis99YjvLd5e3wKZifXUONrZ5I3p3y2d+kBnBgW+B2g/FJ/tTYo7RkVoR8z7jjFACffV5sA3NtKxu3lt06vdVQU+KQsDio4Qa+yFik6GYNEDxbFjG+fIwFkF3AmGdPC8vZ5IzOLryRTl2dq8yYDliHmdWM+3OMEvpn1Dy+RPgTrGVYw2yg4AbzuklCRZW2l9xZg9mTjIl51ax1BPRlghuUmjfxPxaH5Nr68NPi5dbrAQYCRDI3unPqWOfadzBdLngcM/M4Dv/MdnruFA2pI2PisIs7CJSeliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbHEHZYT8gvspdSmk5ZMSEj0QwUFHSSXLoZMqEr9J/g=;
 b=K4exjnX/BgQnmwlatKl8I/zGPWOcbmOJMbR8xIjVuqJ30P39ZhCI0BQUtPXqFLGZhjRBXxNQWEp/Jdi2n5dIeg49Fltlnhv63/DTVrxW+rFNeuNSLN+eEFmgF/ip8kIwVnDLL8YBBIaAxNGvIPeR/bMBISsAkWVeMeeFmO+144wqUhJsRpAwIOKqHHRhdLAaMr9K+oc1pqK5fxCdiom/qokaXbX1xRWBN6q714Ke/h5mj9HZcaK1pdLRWedjiNh/H3ZKF4iZ+Dx3duX9edAMR8YmGVRganeQeuFZPnWasoYvVWqTrUVfVmYRNb38Zxq0U2C4kfmK0Zk9syAGuWSWFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:34:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:34:42 +0000
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
Subject: [PATCH v3 net-next 05/15] net: fec: improve fec_enet_rx_queue()
Date: Wed, 21 Jan 2026 11:33:47 +0800
Message-Id: <20260121033357.3261464-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121033357.3261464-1-wei.fang@nxp.com>
References: <20260121033357.3261464-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: b42e6326-9f67-4bfb-bdf3-08de589e0357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dbEcMJqPKD99o/5j4EK8d+HjmUeXTu2PnfMsXxgcLepMjjGzFkLLjuVT13UF?=
 =?us-ascii?Q?FemlHAIrf6S+Q7wvBXAXsLB5I9Sm+ompUh+UqEzJKAoP40XMk5TTb4MJhG1V?=
 =?us-ascii?Q?hFpgPInf3neU6j9nO3zhUJ77BxWgjhXdHfgW/R9oXRixk80qQhQxckAgV3pg?=
 =?us-ascii?Q?YJ5cmbFFbWxGdX+jTMp3PDBZCKvLT9Bxl5z2Sd2loLRwKK1cCjw42Awi/DU+?=
 =?us-ascii?Q?JQRTwhJX9U7ovmDLh6tppy99lPDN4WBHaDwHNtMmac3viN3xftHpRvUbjivm?=
 =?us-ascii?Q?Wxj90eBx2U5gDhlzv9I2xZ1Fq0/IRAMDn2ownHT95e222GzF/jEJuD8VddAU?=
 =?us-ascii?Q?xF/i+Oi1WpapB4P92/ceE7d8GM3nzYcH65gJot/SMuu5ZkdlT+oYmBYSbfJq?=
 =?us-ascii?Q?CtAO5GQDU6wJaVcmJnLb/dn9qCg0QTp8im8OzM1oq91TBNK+5TYC22pP0hyB?=
 =?us-ascii?Q?WSrefPUvBhVh4woId5yTJ1bmtVj390WI/0CPpZM5CP7woJVyoRkBilTqHqUG?=
 =?us-ascii?Q?QLONe7w43UUKPxZte3GGv7UiO5B9FsVIAOl0yZxjcXz5Q9Ox4vZd03pqIl8w?=
 =?us-ascii?Q?AB3LzzhDElkYsf7e4RFQ/YIGg6nP8MGaFzm2ZVeCLL5kN3Q5ORfgYfq8sXd9?=
 =?us-ascii?Q?dwmZPIot9AF6h1yKwcUoGuQv3Cyqitk5VeJb8xZATg/R4NkVBDkV4u94QgA7?=
 =?us-ascii?Q?rtvd9nw6X+Dbrt4i9vK0keOhAH733CjsnufuZP4/21O4aemmPXlmjJVe7MOS?=
 =?us-ascii?Q?9bHukuU80FfvtLWDxIhaguJ5IOPy2+dxlrVYohbyAtGH8mz4MhfktdBfeImu?=
 =?us-ascii?Q?slJpAs63n/m1W2q9iZhVW6S6vjQkCR1S2AfgmxfAiZc+14ju8QmIKMZ1Ql9p?=
 =?us-ascii?Q?UQCSnoAgfS2jXAmQ1PErIJNsbZ/uxNwLB0WhIUTctkmnY+/gCHDBkuCFky/F?=
 =?us-ascii?Q?Kxfi7zjNkQkaneFhreqVJL9RDeCyyo32OMNW66uptt36euCbAK5YiGTWQo3H?=
 =?us-ascii?Q?RAttpK7jaYEfUvKm+7FCjUBWVx4aiHwbDgHpWIRJIDSwVnatnkd8l6xRixGb?=
 =?us-ascii?Q?fnURwJJSN60M+x2/9YNB1KZtIrAZdfDaqRlnW0rD5hnouWWl3idCRYnbN1Qy?=
 =?us-ascii?Q?lSMsVIF731qfYa1lgMrauHOBPN00Wmo0EpCEsOTovEnYG4kdh30Ij3MsoUhe?=
 =?us-ascii?Q?v+9JKaQxxrBcUbBFbPIcfBrLbtlPCw4X6j6G7b9OcNSdiGx3yhldnXXWX4Fk?=
 =?us-ascii?Q?o7IOPSBTBqrGrvg5Ukz7chcM0A6TJHhsIVOiyv78iTu1KAJe+QEieyd45LKj?=
 =?us-ascii?Q?kUaINNf4qmIwlm8g+gWH2akg2l7KNojvMYIxx28L3W3wm+yhSGGVcEeb8Nfp?=
 =?us-ascii?Q?4/BYcdMw/wQfSpKYWVxvgujC72W8AWjuRBQ2P6xcbmnNDFe54QdsILgfJgZ0?=
 =?us-ascii?Q?b5oqmsbDjzUdNOudGcFEYXiJYjT97f8BdqSOkuxw9kFDe68jGveYY3ZLmXud?=
 =?us-ascii?Q?/s9IV5z1YTJTqvuLbmrZ1DyUdQ6WLcW/Lt9NYf2vA2vSnOSEwuKUxv8Ou9du?=
 =?us-ascii?Q?MJskl4aZlZumj40E+Li4TtDpfro9JhWFb9pQKdYsguzRG1tss9pbYBSzRkLk?=
 =?us-ascii?Q?vlZtNo6cHOC8KSMVTqH+Je0G2X1flgw4294rSLBWe17k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1jxjnRMgboIPU+hQp7e4+dQJKfGJd+ys1ezl62h76f2/sYm8AOZ+3TZzovct?=
 =?us-ascii?Q?FfrX4IZpNbxOZs95gVm/tMh3E/x52rfENbfCMwR+u0NXqsTWLhdF06vlMvxP?=
 =?us-ascii?Q?zNUi55YMrncAAN6t2ybaxxyqsdtkfAkfW/ZU2F6DkIVfm/au6i+WkQz3aKIm?=
 =?us-ascii?Q?QcCgLGiXVFVItc5WOTzIJk19EqKlZcXUKFnecIgaqb6r8G5eIn1DMxgysl9c?=
 =?us-ascii?Q?JlplCiPlIj+OeQwN2CkcByHpcg8JsHYVp91HTXt2jBVSsVIkVT1hOe6/l/5o?=
 =?us-ascii?Q?nY96kLuHhYUi10h5rQDvZ5DCdEAnnR3OsVK2awlyAYonL8Ih7W0ijRr2IMAU?=
 =?us-ascii?Q?fygEo3xi7VkcE825L6KuVlTj9fnQQePhcXwgi8HZAfzioIZqxbqebcInOCSJ?=
 =?us-ascii?Q?S7VKjJwUgTQpDqdlDOlQs0gvttTQvhufFfcrtQbAx5Vr4FW48KY+SqPLZTuj?=
 =?us-ascii?Q?3D1tELNRZptgD+EVqhB5Gy2HRyPugsu2Nndu+25tR2n6aBD8Hx7EbLZYa3zy?=
 =?us-ascii?Q?38dgSDyrjmudHXWTvW3XOLr1i8uWiuYXeVF7aD8AMbaddL3n2/m8jr/OQCnH?=
 =?us-ascii?Q?H+aVEd86tSdFRLMjoAe96F7wVIFm3jT0KT4oXhcclVppI2MUHzYCyPjTVkYh?=
 =?us-ascii?Q?4vRXok00qQUkq75/aBu/xMZLPHna17tTQ0JDM20P8aFiRo23j/8j2HomdWal?=
 =?us-ascii?Q?5CzJIEA2+9wTJcN0cCDUpOzudA10yWwYguFnt/FKBgI7YfKCgl5SKjQZX1ja?=
 =?us-ascii?Q?xBDAWjx7uW8CYqIzpYxpsCLRwDNfy0LHXJTpMIXgJ6gokNV7kPiXcb4dB3Uc?=
 =?us-ascii?Q?UJpp8fPDR3D4hpZ0dc9nbO9O36gFGyirzYJjStQdYqEAWTCze4U8o4x0ZvFx?=
 =?us-ascii?Q?aII3TGWHOUzhqRVLb77R6mGaq5U9IhckBDiLLjbGcEW4lto/6YI4iqc2BxTa?=
 =?us-ascii?Q?iF+8bNSXI3+TdAZ4pMYTDMVpSep3SZtLAQIOqc9YBbGr+N7EF9DrJZywajJC?=
 =?us-ascii?Q?OJdI0lnrwM6JKZJMM9q/c2Wsa4+tWMjxauMScq+QKiaZaGxnAgVbZ0UIuzIq?=
 =?us-ascii?Q?KSdG9bbrU72KsuonjRbUNIQPhhe6ZBCh0HZJbo5cbcnPKJGCHYIpM/OFn5p4?=
 =?us-ascii?Q?enKKvK7bZsf+D60GMwJWRnWl6dNSGur6id/M3TWAy0IhgO6XZf2c1Hna1L/i?=
 =?us-ascii?Q?mXwAHxEV6sM7egaAqNmSLY9CXJ+ENGhI+M/UF79Xiv11UG/UTzT0v51q1tLQ?=
 =?us-ascii?Q?LkQL7A1x3s75OPKTQWJUTgnMXevOzGLMWcxkRu2iBnWir0wIlKp33HY1BRPb?=
 =?us-ascii?Q?mmqSs23feN0Pnd/1PZhlQokoDHX9QIW2OQTFbzTfRU8t8TNYehO/dQ615+er?=
 =?us-ascii?Q?a5UDyQrGe7qemCkAxcnnKKKG7ITNbjcpWrTj2few20jSxSZv0g91Xl0BE6O2?=
 =?us-ascii?Q?6mqc8RJMa6LYNxEMqWzEzb3zXGL2ju8dRzgPTgHGyrwtZgC/OXwcTU99typl?=
 =?us-ascii?Q?HIfdrJZT4LBOc8ddyW8kD+uSig/5DRkSmtdwQIRGwtTYA0rHF00hqCWDCkgZ?=
 =?us-ascii?Q?e+mRVXQU093ZYK3+aiY5epsF8CitJjbkJ1+sBRXBfdc7zleF73k4g/vBujkK?=
 =?us-ascii?Q?lNozta957i3PzKceoWXcS36UnwdHdaHx9grtPtgyxgu6US68H2IxpZWm1o55?=
 =?us-ascii?Q?vA6JPsVy17jkzGlzmXq6n2FUjvKEm9/F7oMCF2d22YQc1cHQtGb2jwEr1rfo?=
 =?us-ascii?Q?EmBeWHa4UA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42e6326-9f67-4bfb-bdf3-08de589e0357
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:34:41.9494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBzgcDJkytIurGfm8uYylERtQFbpMYsaQLv+s8aoShCBDWKrWsS/h3/A9WieHXyAtj7BBdnragICLJRR0phuCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251751-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0918D5079D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch has made the following adjustments to fec_enet_rx_queue().

1. The function parameters are modified to maintain the same style as
subsequently added XDP-related interfaces.

2. Some variables are initialized at the time of declaration, and the
order of local variables is updated to follow the reverse xmas tree
style.

3. Replace variable cbd_bufaddr with dma.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 35 ++++++++++-------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7e8ac9d2a5ff..0529dc91c981 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1839,26 +1839,25 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
  * not been given to the system, we just set the empty indicator,
  * effectively tossing the packet.
  */
-static int
-fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
+static int fec_enet_rx_queue(struct fec_enet_private *fep,
+			     u16 queue, int budget)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct fec_enet_priv_rx_q *rxq;
-	struct bufdesc *bdp;
-	unsigned short status;
-	struct  sk_buff *skb;
-	ushort	pkt_len;
-	int	pkt_received = 0;
-	int	index = 0;
-	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
+	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
 	u32 sub_len = 4 + fep->rx_shift;
 	int cpu = smp_processor_id();
+	int pkt_received = 0;
+	u16 status, pkt_len;
+	struct sk_buff *skb;
 	struct xdp_buff xdp;
 	struct page *page;
-	__fec32 cbd_bufaddr;
+	dma_addr_t dma;
+	int index;
 
 #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
 	/*
@@ -1867,12 +1866,10 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	 */
 	flush_cache_all();
 #endif
-	rxq = fep->rx_queue[queue_id];
 
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
 	 */
-	bdp = rxq->bd.cur;
 	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
@@ -1881,7 +1878,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 		pkt_received++;
 
-		writel(FEC_ENET_RXF_GET(queue_id), fep->hwp + FEC_IEVENT);
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
@@ -1895,15 +1892,13 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_buf[index];
-		cbd_bufaddr = bdp->cbd_bufaddr;
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
 			goto rx_processing_done;
 		}
 
-		dma_sync_single_for_cpu(&fep->pdev->dev,
-					fec32_to_cpu(cbd_bufaddr),
-					pkt_len,
+		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
 
@@ -1979,7 +1974,7 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(ndev, i, budget - done);
+		done += fec_enet_rx_queue(fep, i, budget - done);
 
 	return done;
 }
-- 
2.34.1


