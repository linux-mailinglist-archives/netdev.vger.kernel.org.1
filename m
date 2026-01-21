Return-Path: <netdev+bounces-251753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HnBIlRKcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:39:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40459507C9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69D60642433
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54C837E308;
	Wed, 21 Jan 2026 03:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jIRxeU0R"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B01637B3F3;
	Wed, 21 Jan 2026 03:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966496; cv=fail; b=koLWcuu2bXwEyRdJNLNh3ljVXxGKbez6nsgOAvRiQ45rqT4QO1UReYuyjOX8OL92af73anUrIFD1Yd1DEBYZ0sF2cIv3NrVlV7fC9EOKUVMIzgKqO7ndX1uplBByVf2F+LV9ghP2XvWK32CfYgGwo6KIJah4hxDvD+a1WzSvm2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966496; c=relaxed/simple;
	bh=83F6hpKD5emlga6Emz+3NyhKrKFPOtauPNrkpiQGNSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JGBHJkmNPO7vu7EUYrDzztCkA8i1Gru/XWUwrB4ZH/p4PXEaQTb31fUew99Ch0+tOmD93NmiSEEXsO4j7xHwuBlBPWn6kl950CKyiQVYAiae7iyTnak+eDX0fJrWqKZoxPFztDAIfxMQgi+JGtpdriTKyAdwgUVXeJBdJb5qssk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jIRxeU0R; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdPj4Zu4pwLnD7EfbMmm9uRj+KQ+afQkOx8cuY8+lfewaOeUZ8ikZfmTgfBvTtlFRWGwxzwwl3p+2MQmrl9rFINgmO+ta/z3nbUVwvhlplu4kfCC0qJDyhZj5HThcPeFbkQ5qCl0W5CckZsF2bFpT/b9aApIkTwXMRSAm2ObIYxs8N6VLrxzDASyAKNX6FVBAkcim/3hGW7aZ7yVmT8u1d5wEwxTObn2/e9IKk2i4XlAjF+WGyIrRevg72LW+d+DTEoTeiXuCWFmOw5o5w4Cv6r3fZpfEBZWogEx+MAi/qmQMt1lGFNV1Rc2d+AYF61esBWbMWgZwWpfgpMWHbv9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwIpD6yQVr1QMgKZfsUUT0iB2WzL9g0OWjJfphdF13Q=;
 b=MirYP0Q3Zn0dJFW2Nn6yobBbJOjGFWkbybZfAZdhy0UIFZRa6hYwj/Sc5VZkKW6cMVOmwp2M6zzy7iHnQr3GcmvL0xHigHxltNOiDzkJESx6K044zykWyGNV4IrAefWIsr5lKIi6HsYHkY/qq5dwvXjbSpa9F9SBuXEZOBMWL/mkVfkP6Yx+qc2b/SB+mo4AzaTSlk47DyYuKhLWftijM1+ULu/RhEZeWRYOZQJ6RrJZio1IhZlNYQdxGi3Nwymp/Rwb9OysO6wCmPBhnmeTUbF6HBwN93yGHA/9K1WNebpJ6cJCSEt2S25fsVOvnudWB5KPrdO5f9jbqgKsjxwjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwIpD6yQVr1QMgKZfsUUT0iB2WzL9g0OWjJfphdF13Q=;
 b=jIRxeU0Rx19Y7q5LnZYdy7TizAXXDsymWQHH98cfJ70+FjFiiYsJUAHdLuR992QtNnor2R+6nEcl3DWXBsb/u1PDBaUr6oqto+tvM0rJB7vt3Cnwh7NXBcne06OFQZJ2G1L1G0bM6ix22nxMuWoeYlZlnV5qsQoZCe4y76vshPLHA330nKfGPsdTNoJowyn7Tg2na7ubNJpHhPhGh5B0PwhaFWI2KyuEZn4SDzm8RA7rLomYSTrySwK+CxGu05RxP77UU5rgPITacfvN3UIFM+G8St3//dwGbBRw54Iw7kcWAB3kPYJFOlQas2JDcmvHvi2wlhJZlv5ySa/MmAcvMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:34:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:34:51 +0000
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
Subject: [PATCH v3 net-next 07/15] net: fec: add tx_qid parameter to fec_enet_xdp_tx_xmit()
Date: Wed, 21 Jan 2026 11:33:49 +0800
Message-Id: <20260121033357.3261464-8-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7d51609a-8409-45ea-0a08-08de589e0908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1+oZBKfN7fAfyuatsr+ANQTc4lUmdN+XZNnpYqUonLtKVfnFDyH/Dq8bwsWU?=
 =?us-ascii?Q?JzdODBNnvgDmlQ9GYED4w75N6P1ci+N9blHEz9ZVsYFLX3CYucRp6L1r+CDQ?=
 =?us-ascii?Q?ZvTMMpXI5cVetqscZys7LFp1vuJ3tzAbn79FrFVp1z5akqSrZ/R6P56PBIVS?=
 =?us-ascii?Q?h5LJZ3AAfji2dEyx459uFCKJZIK+SuNfz5E/sZWqMijQ2Twa/naIIhvsKFzS?=
 =?us-ascii?Q?ZUeY1L4wJ2xs8O//bDpHQBFGcsWX/xeprceT1RJ28QjwO+0aIlFW+qfgOL7e?=
 =?us-ascii?Q?3VDXxb6g6INkBzvzusJ96DfGFFXCPFZ6Hb+9+vmZ3cTxY2qvCHB3rHqrIxg3?=
 =?us-ascii?Q?kqQkmQLI5C9czFjOtt74PenniEBGQfobhTGlTP71R7ql3eCa9Qle0CaCmfs9?=
 =?us-ascii?Q?krWcOiBVtI0PUm3/3EibKK61mZ53z3xmEAVZrjHgLQ7QvljQZ6wSk4BlfTt5?=
 =?us-ascii?Q?cVd+FuX7VWRDWvHIQrFn0uclPEpALJMTnYosQeS8ofpssqcVli6v1y67my7b?=
 =?us-ascii?Q?XH8K1ow2F+lXKti5KuhraDixS+kGc3d1Q2T5Kf5t8Wn0BWIb1ajGfbKJ1giz?=
 =?us-ascii?Q?ZIA6FduAuPApbS5vmCcYCxEzwOxHVvo7QJPW12bIe85GzGQyxOVQUc2kORKS?=
 =?us-ascii?Q?UnWTXXoNrGI7JeAfFjkCjEW/W4ks6Ow2JBLdh9RruLqh/CmoVmbfvr69FoMs?=
 =?us-ascii?Q?KqTl3JwupddQHehN7hrqIiqtyQ1JwwcOuaDPNfiIPxpUNZyokjdgs7rz05x9?=
 =?us-ascii?Q?gwZoXEnRW8aW2PB0o9+bxf40Zs9x2/Gj98pLFSTvc3Koj3i2eSBJooFAXxC2?=
 =?us-ascii?Q?p6ugdOmpgWzfhZubpPa3DD0HZSlHhKf1Z8KD3dt+41JUjkXD4AC24t0XOMlB?=
 =?us-ascii?Q?xuKnK6tzElXQZQl0KKRoaOIC1rXwAapC44UIpNv07hsjpADWvq/7x/cL/4zD?=
 =?us-ascii?Q?LhtLFyHkBZM1Y2ganzTEUgiMKxxqWCXCi7pKdgh//qdsR1Dt7wCMsl82N47k?=
 =?us-ascii?Q?J7BGOP8B47jE+vBPJFWH8IABXfT80E8oVXu/jQbih+U23wO9ssMPIMoFr7NU?=
 =?us-ascii?Q?/3HlnLbWuQ/9IWtI5pVZn3dVEsp3vBwdzwiIqBjPW4Eza4jJuJA4o9TsQE4b?=
 =?us-ascii?Q?3FI3zfMQwV+2F6oBy2yyC63+0IIwufU2pIv01adpTKH3FBcdfAoQKfpk+FhK?=
 =?us-ascii?Q?qeE9wUjA5baEvjhjX3+9eXG9WXSPK6ZbkZmnFaTe0Z6OSNjfiuFnUaA1n+e6?=
 =?us-ascii?Q?FoLJ3yCTHDaHcBjV9s9rZou7NXQGg0WSDjVmMJe63SEIldUhKrSxeL2NCIpG?=
 =?us-ascii?Q?gtaoP6cYWTSs3AlVZLzVr4ZR9jSBpsQOXN0QTUAiDztseGk6r1B2gJ4rY7nC?=
 =?us-ascii?Q?jBK7u04DjlPwFtTUHq588gsYPgiE49nT5/w6bfX/FwO+CLG5bjjCnIuZaUrt?=
 =?us-ascii?Q?s7422w5EhJz+UQqrTEusqrAywfwsIQ8cBiyjZaijvKuZ6AqC25JB7NP8GK1n?=
 =?us-ascii?Q?HWbqXvbQBPegXY1ComZuIseoeWG1GHrWj7NdjR1cVj+UBbwV92UmrVJ+byqF?=
 =?us-ascii?Q?15wq5xJH+sp6IX+fd2T1x63x7/2L3tRMub6zLzfiXuzYpUEIEV1zc4tGg5Au?=
 =?us-ascii?Q?+rkuD7xT3UNGMEqKfNjjhho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qvnske3dACGiIJPVyLXnXrd5Sow31+4NpUIDnkPddKgGzqjotVOudH04TxR8?=
 =?us-ascii?Q?Lp2RpBl0F/Hgm0yEZfBrdGPelknSyePfKUs33VBWhARYUXKFi1vWQcJNAefd?=
 =?us-ascii?Q?hTWeAv6fuyDgrWX/FqPpI4MgefbPHreRz8fOe0DHgPYdrhTTbwAA0uplUjTU?=
 =?us-ascii?Q?Sd3dhgPwLTFHkXEqSWjSfXbPsAqD+IuMXRJ5wGgaBbHCBZVmnqPmM7kySBxl?=
 =?us-ascii?Q?5k9epzywYG1RnRF55rTHCPbzXjEYt4FOkhCx12Jwvutqiwn9COo5HCNIxXoa?=
 =?us-ascii?Q?bmfn9bpaaOcLHlb5TGOXP48y89RtDftoaFA1EdWhp71/4OO8CKvZ6jJgnELC?=
 =?us-ascii?Q?ggxzul+8ziIR/T8AGhkYHyxSMe3u+8H/bPtU8omOvtN9r9kc21NMzORs8y27?=
 =?us-ascii?Q?5sqZABr6HKegdL7TgANMSXj+imzM2nw2rNeJn7fW35dlQdgAsc1aGqp8yrA+?=
 =?us-ascii?Q?hVliXltyWb9le1O/Pv0f2r19W0dzqyJa9hU8ThXZmoeJefbXetFtWm3ymnJR?=
 =?us-ascii?Q?7Jl916zxlJJJ5PBm6gY9S9LL97tAtELBqus3G8rs3XNBwtW/JajVwPdHnUX2?=
 =?us-ascii?Q?8ARF6xu2BrcZvpuD7alvUuW4wo/ORJizwsW1igx1i5SyCjxSc/or/i7UFx2E?=
 =?us-ascii?Q?9j+8APMX3n7VETORY5HzrM2OBUOc+kP2T3N61rDwiRrO6SN6AXRtGR5/Cz/r?=
 =?us-ascii?Q?A0W9HjXNNER7FWRWPj4oRj2/z2BovviHReuCP/U/3jOOql06FZiMwvTSufvK?=
 =?us-ascii?Q?heDMzyejLU2PCjp1u4XQXvcHmFLLAFyJr0pHY12OT5frs18E1RNexfEqg3JY?=
 =?us-ascii?Q?S2mbW87qBoM/JBtncLJG5nhsWQVT14KZBY96q9LICHuzAwOcy/ZxbTJhhXGQ?=
 =?us-ascii?Q?vFYRjXfpf/DHUZZyaDroYBr2mi1P5lkjwJWEICAnSwkyRHQIVmbQ7yf78clv?=
 =?us-ascii?Q?qYEr6ttf6TdnqvugvLbpzJdqpKi10v3BUtSHMyOrOqTN3lOlCW7kFdNM8NYX?=
 =?us-ascii?Q?0bmGc0Q5Hqj4SCl9tOLXYjIxp4zOvovaZCvtaPHdTbfLwoU5mptYUPWnn4Ya?=
 =?us-ascii?Q?DfuTujw61ZrXjgAMBSSQibdEy/9mbzsApF+El5+klh6fZKASMNEnuOdv3KuQ?=
 =?us-ascii?Q?NHW7sOK6vB+b9tZ7kEPlneEq1uFx1g7BodU1sq8xDJtK1L5qDux3nu0cDPNA?=
 =?us-ascii?Q?VXTBGrd4X0pnEMX3qhzl9vpCXfkfsyVsoeKJHoB5Lc9XAJrwA+nyDCQIbY54?=
 =?us-ascii?Q?4Yx4Ja+Y0xW82NJ8C+CvyKjHgtIZ8zfwWre/ZtpcveR8gn7BwxvUXBanCf9x?=
 =?us-ascii?Q?hs+dm0pmz8xYVUXsiXbUOxa1RtgarmYYw0/dquMXYrLTAAMNn6ocb51WHYLk?=
 =?us-ascii?Q?q9f4SmSmk0zOhQn9ZOoW77X62AlWo6O+1a7BDpV2CDAxx2lwmDgRm9CIu6IF?=
 =?us-ascii?Q?bSy/IszozB6/K/0ixWw29pv/WngaoPRYk+gkcic0MsleMGNn2z34MaJyhtDl?=
 =?us-ascii?Q?YUVqa2yIHl4tClyvoQyFDscMPlVIqipHe5Qyf68zoTkZ6thNLUwnFH88I0+7?=
 =?us-ascii?Q?XOPinjPS83HrwDFIvn5IBlubzsCe4c6cN6uRy8+kTxI1IfXyG1OEb+KgPzZD?=
 =?us-ascii?Q?g/9pRcuayHnAPbR9YECS+3yl5y+d+irV7FeVksa9yOzoTZB19RmUAxm6fVqn?=
 =?us-ascii?Q?HZrxcDoh7TBBJNx/f3wuyeeizSdV8hWnJZB5Rxd7G36Mf0wwrwvTU70cBx0E?=
 =?us-ascii?Q?xLDs6sy0kA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d51609a-8409-45ea-0a08-08de589e0908
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:34:51.5077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5XF4meicEA4JCtajheRKi4sxrrCipbLMQZ0mehwSSb/SyEDZ2ydhhco4u0OZxa9L6sHNxSSLU4LhTUqEQtsBA==
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
	TAGGED_FROM(0.00)[bounces-251753-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 40459507C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 86447a7cb963..b60c736da027 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -79,7 +79,7 @@ static void set_multicast_list(struct net_device *ndev);
 static void fec_enet_itr_coal_set(struct net_device *ndev);
 static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 				int cpu, struct xdp_buff *xdp,
-				u32 dma_sync_len);
+				u32 dma_sync_len, int queue);
 
 #define DRIVER_NAME	"fec"
 
@@ -1889,6 +1889,15 @@ static void fec_xdp_drop(struct fec_enet_priv_rx_q *rxq,
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
@@ -1902,6 +1911,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	struct sk_buff *skb;
 	u16 status, pkt_len;
 	struct xdp_buff xdp;
+	int tx_qid = queue;
 	struct page *page;
 	u32 xdp_res = 0;
 	dma_addr_t dma;
@@ -1916,6 +1926,9 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
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
@@ -3938,15 +3951,6 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
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
@@ -4040,15 +4044,11 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
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


