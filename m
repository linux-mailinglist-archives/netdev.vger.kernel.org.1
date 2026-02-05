Return-Path: <netdev+bounces-257056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNIuELFchGmn2gMAu9opvQ
	(envelope-from <netdev+bounces-257056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:02:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9773DF0396
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7ADD30649C7
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C4236655E;
	Thu,  5 Feb 2026 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l86zjxY/"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B1836EA9F;
	Thu,  5 Feb 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281794; cv=fail; b=d4a1Zzh6/GF9GWmM8YKf6n6a6o4XUt7ctxqTwl5z4tQPkv2CNgmN3SucAM2emgEddSPJFJAQYGAxTlITqTX4NIeGpXf5A18XOmsk4IGaLLYvkGs/yxBsIWNu5BQ9N1Nsao/RIkNGtLiJsZjcv6qNu1CU9nc5VUSUGXaWDVDXQsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281794; c=relaxed/simple;
	bh=jHe6t8pgVAsepns3mJ7YPFDc8toue3WjE1HybU+RQh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BYx/8gRkYPoirhR6sNVJxRA44h4V03ZYndc1KnGizY90GPWKrJJKMDvEXzG4VFFOtWvVcc0STWocfQCx1Ap/oAOroJDEpcqteC9bCdCI+edgzP6QaVjRGe/ze7L+EXzlK9Qx9WCXBX6hpa8QuiAhGOTMykxsFXvramE2MfaTcsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l86zjxY/; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ae4jvq6NsIv1SO9xM0LDVYwTpFO+X2GFR/S3vwZf7y5UXk9l220Vaiy8kJ8HlsY8GzkDmpawnqtboN2zQAPe3Gtzkhxq4/fEIc7+zReL8feye4e9TOYeOdL/K5ETBWyOQzF3igt7KIv+Ega8T93Sq8RKOYmJ1AnaHMxskp34JIha8Kzc+Ynuf+9oFgLVeZTnwUCHXX7uUEsH3WuUfJKDEbb7PPpBmxV2/eZtpV1NRSIDmb66mfGgI+S06gpqkCBjyyHmkbRHQ71czYmaziCWxbqTCJsLbQIG8IX96CXNaf4IULMD1c9vz5/pTP4t7NVHnDHSOqK7rduHJQFsWf2QXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p579Nm5zIFUBNV+a7fLnSxrUAu3/YWLx3eUue7EHtTw=;
 b=DcWdii07x8RdQ/QiOB0vUJa1uIQnp/cClt6Utq4uwgx2Yq/2EPabGhpz2irpltNyOtXRjCSpj/5OmYjSygTEAAyU4dIvPVLfDNn7T8M9V7bKZm6I2a7+c+QtdNZRP9iiFynq+wihBxNXFjvsQv1hekr+cZ+6yWK0wfCyjmMXj8bQIhU+rMo8gsSIozRUOL7FXKr7XnnVmuKxAWZUCX/ISvha4JarOLNfLrQ/gOhnYvD3E23NiIr1rsvXbmQ+U0RUKVKcwXIGAqu6s6Rn6sp4YZhXuBBrm04T7EZ799YBmeNq+l+V95cW+pgutgSNNji3KDImpOaeofXf9jiQjYsinA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p579Nm5zIFUBNV+a7fLnSxrUAu3/YWLx3eUue7EHtTw=;
 b=l86zjxY/2ezEldSDzAxyQntrwTq3C0mHr8LFFma7mGubed+Iij1rlZkuuuFNb/cEGhjGShi8NnNDtuGIXqdiuEBRZInztNQbF+cKNPtd3j7MRM1KK1SS3DDZlXU5sEQvSCLqnc7T6Iyqi8J1Qv16/hOw0WGAJs4Lf5+TDkgKc2+xseJqenWK2UfTGPScCPEPSViehvNIoHx/JlEFyODVhTFFJa040vrliWhXiR7VlhadIpiKtMYupy7gZfQXZ1k7wFbFPjMsw1S5CVwma8EEoXKWq+su7RQ4pOBZMtKa0HHlTF6S6NwRUM3NNhlhvOMf9iFsJ46VbPAyjerb2mvC7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:56:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:56:31 +0000
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
Subject: [PATCH v7 net-next 03/15] net: fec: add rx_shift to indicate the extra bytes padded in front of RX frame
Date: Thu,  5 Feb 2026 16:57:30 +0800
Message-Id: <20260205085742.2685134-4-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bc3255e3-bc04-45c8-3dce-08de649474dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jYTywC5+bKcAw+sD5ZIjNQ4XbZhiClL5QNOI1oDHhhGQLeFxAkQlxW+E4VJW?=
 =?us-ascii?Q?KwBufzGgwbeBhE5RcXrvgODAK5eNDfMzR3eL0YxOM9p8Y+6bs+i7jxCulLg8?=
 =?us-ascii?Q?a3L/ZweWg9cjS7mK+BLalvfxj5+zonJXEXYwmQMIPhUGHVQppPJeicloHr06?=
 =?us-ascii?Q?rQu7IxsW5Jy7D5/7iJMCJfaAsfokEt5HGVH4l5zJHw+AY4OH/UwYmfJZvhXU?=
 =?us-ascii?Q?RKSI43Dd3Hpa1iaTgV3Hy9QGFUQNSSAH7nCpXQWCQ/mC2khLYiC5gnwpIIXW?=
 =?us-ascii?Q?9jFcMcYDC8oWgK3bOTeOy2qlb9VEn/4IHrzEddf9nOAzvZlXVYk2y2Ca43sR?=
 =?us-ascii?Q?nIO0P0tJGCJxykNtpNbn5NGv1Ku06Je5F/LS8b1ilj03qHXH++O3OxneAuMl?=
 =?us-ascii?Q?nT8GsSZMgJGqgxNCFDa9NKCyBsK4QApNCJpX9u/FsLzcDR0Awd3dw8LLEc7X?=
 =?us-ascii?Q?Gh9/99P0YKUpj2VHu5xOzOZx6kL7yH63t3T5yT41MrM6nPnNlrP4tc/SIHEs?=
 =?us-ascii?Q?L+YS9it2ZUWm5NEh8cM9qYPs9qkbubxa9vmsNpTuF5OInRXuHp1X4xVeiwQH?=
 =?us-ascii?Q?MaUYOBYGP/Uh234SNlq9JyocXI377g4e85mPWwEcb+/1QKRNifzHd/6Bettt?=
 =?us-ascii?Q?C0JWCSq3FCycl1XSsnnISDMgrdenJqPUBapgUluZLObfjfVD0UdMkZ+NuH7J?=
 =?us-ascii?Q?c81A8Y89hZGw5z9Xpw6FVqSg4zdWZ0ZfivLGNyehVrSbgDMxpPQa0hhnm+jL?=
 =?us-ascii?Q?y+Af2CpczLrQWvkyCeNW1tVRzkCfL4QbZGVOPxFHdMU3jD6thVORVqkulQiW?=
 =?us-ascii?Q?8alCWcZE1eY3Hg6R8KuQXqXCAjCKNPl5btD1LPpmZGJlfOrClKttoNgFjdEY?=
 =?us-ascii?Q?AAVceMpOTVakxmwf7bynuTR/JmIkXCMLqPeqfskT0xURWpbO2IdQdrClLueH?=
 =?us-ascii?Q?hXHDr3Ltp19bzugUt94/FvWA/ivN2nQcIj1lrE2XNCrU0382oQq10vgYxKiI?=
 =?us-ascii?Q?YOfsodwpcOwp8Pkyf6wBGDl2+V5hv4JI3fHTRQQS6ZkxQCllPx8CFqmxxeE+?=
 =?us-ascii?Q?CPUR20kjfC2XO2cirMgJ3JPNbX3MvskNGIHXD9e3K5fpoZqGiGeHwzl/dp+u?=
 =?us-ascii?Q?vhkeB2cJkRo2aoN56gFpFOD2oJ0WERuQ/o6845fRwbW+NyNTqxrD4ce4SgX3?=
 =?us-ascii?Q?USyNCe2Vv9WgKo9R9JwUsBFSVuDR7c2J0EFq4k+ZjuB/pD/AFMMzmt05f4lP?=
 =?us-ascii?Q?6fVaEVbtjYQIXxuLnnYvK5aVzDfKI6Q/wtkfjTv3Im24B8tAi4skPc2xiJbB?=
 =?us-ascii?Q?QFVTIUb/QCVieEcBTOvCl0af8vl7C36XUSOZCt4ofjGcv/respy8WkiZzBR+?=
 =?us-ascii?Q?XyTYOaMEMMM5F8d5kUleOMnqwmBnsjTGkiGm2UkYaEfKP7p9F2RZUcAyx/yU?=
 =?us-ascii?Q?CzqUS7aeZqRpM8bYs56zg+pomTBVzgEnUsWngmu4phgni8d7OBYMZ1su9xc0?=
 =?us-ascii?Q?yV5OZgYxgjmsKsuxhQBnLRD7O2Z7G+X2IwpJfu+ENTnXUpy9IgJ43An/saru?=
 =?us-ascii?Q?U7MpPnPBTsHPM9tY3qlqHgH09K4bGEkGp4C+0PPinHM066pytQN23Oquyxf8?=
 =?us-ascii?Q?3zzAspNbKkbl/ebo/SBYWWQJ/F3qaPdw+0Ng2xNjujRc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WSPaqaXliWFPGl+QdKP2cDQ8zl40duaY3LsJyXCGewkU8qreqlomWxDj7QHg?=
 =?us-ascii?Q?EcaRZ3SubXM8z80M/INA1ok7Tx5KA0c4jtXunHcQwfz25DFOX9BjTKXpO/Wn?=
 =?us-ascii?Q?rpbPft+6gpjsNxdggiT2zzgT1q8lpGoXTjDfM0fwLU7e7lG9/KAfsVbVj0W0?=
 =?us-ascii?Q?RlHZP+Z+9pwig8DGsFMjFwM3Bj2N+8KN0rKtw19PBtu/44xsP1d9iPnTzKkR?=
 =?us-ascii?Q?Kwr4Vu2ZXcVWKTjQqz4pt6sDKwdpVZi3JEztEDmH6SIn7w9/56swTOHL2KU4?=
 =?us-ascii?Q?OrhEtprahBvjP6SyXWyD9crBbG2Frbfn/uoCu9EUqibDqZcoowvgQlzPiQhV?=
 =?us-ascii?Q?S/tgvLvmDPZwg+qxW27uDDvq/X15cURDkr/2Z7sqY+WYDRrdX/WWhgRWBpTy?=
 =?us-ascii?Q?OeWA2papktx2zdegnKKSkF3Gj2XdmNGesIpc73t49S3mrgxP6repGJBnljAC?=
 =?us-ascii?Q?cPXcTW2zvNOpU79CfMoV8QQvrxXZKMA3znFvU4fpBRSzWkD6E2RBZkd4Jqz7?=
 =?us-ascii?Q?ryNgaqoixYEIfEyMlNhfuBK38vwdDfjR0YNzdF2lrBJ0PBVQoWh+t2kcOSZh?=
 =?us-ascii?Q?7g0zuFn6gbYixnjvQ+qxbi2Ag+rW3LqhZvk/wVGyhgwNzRL8S20Qe7/sQ68K?=
 =?us-ascii?Q?np6LzQwuQxKKIrtL6fJT40iLpmAHWBTb2snPgRqwQUaKq35ckzUtspt5rcNg?=
 =?us-ascii?Q?UmX7Sy3qyfoi8QPwJB8D6WL1QzUxjAV3kfNLzhHmtElxSiwFzUym/TgNG4s/?=
 =?us-ascii?Q?ZLvVCl3ppL/sr/Ew7octfT+QS9rh3zsvUmQ+PizP4dxghENqCjAkswwRXYAf?=
 =?us-ascii?Q?bw1EfldivH2PoDgmoGr5hmvljISTYfzQMYU56Mxgoj4BW0gtgA8169RlYCJI?=
 =?us-ascii?Q?TPLK4a4OSTJSq9DPSGgjNgqhT9XKHgbXSuQdL4uy0hH3dQSwBOIus94zFgH2?=
 =?us-ascii?Q?rjts0xYyCUtFDyNIsU8LvZfqsp09lcvliJs0/nbPoh69ti/Q8Pp/DlqKQbQX?=
 =?us-ascii?Q?jyhfKCl/gdlv2UpMnLupcFLPhLqzt7COZUlWqj4bBSPK+QD6zJVU6kfvi5EV?=
 =?us-ascii?Q?J3NVw7WXsLaUSy+c11XXCFgkNhmR0y/kVaz7E7Jc3+wez/yxO8TzyyBL+Zz7?=
 =?us-ascii?Q?z+xlRR6Ter+uQ0/Racuw8/SVpjmQaELlk1M0Uh9jitfM6UbGOHJNiy2P7XXV?=
 =?us-ascii?Q?Kuu7yvEYzHRgzj/oD35/FTPQoRW61Tb94IFMM92ZseEGl2D39KXDpJ3sE+na?=
 =?us-ascii?Q?IO6DYafLQYC/OT/+a+2WmJNhyiifGj4RJm1RaRvavXpJR92dLyCXkFJwQahm?=
 =?us-ascii?Q?a7qkfDAZGFVAG3FBrHfeRJ4fD57GXXYwZ/KlsTy/G2ql+BqzYmzde2znMm4o?=
 =?us-ascii?Q?GEdk3sBvZPUT3ZTJqI3wGUkPjUsKfpWgRPyPNAo5ONbxOuX25mW/vOKOwug7?=
 =?us-ascii?Q?Je4e8/vyrbzNN0JVyhbqDvIlDlv+HLOg24aubglEPbloqt+k8SH58XvFl8sR?=
 =?us-ascii?Q?P4LdYG6fB3q1CTwjYPbGqlWmHCcJMsPTOmi0o6R3iNVXbNncctxHdf2jzLEn?=
 =?us-ascii?Q?e2cFGY/g9h7C40fCUr9nWLZbzzZAXYskGwSv+3kcBTPkXXbwrtwst4KxG51n?=
 =?us-ascii?Q?SQkka1s49/srMGOXrx8RNPrEVjQbDRjwsg9AcHNRCJN2auRU2OmCQlM5JfPy?=
 =?us-ascii?Q?n7mLDxz9dF3P89Ysd1QTgQ8Sw5y5E5yY72NGf5aqMiBbRU1Ziha0VK6XOLpk?=
 =?us-ascii?Q?sMNVzE85Iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3255e3-bc04-45c8-3dce-08de649474dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:56:31.3678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptB+jhMantXILSrrqbF5OLCbEGKuWr3WAdS5FjzRAltQZi0RJlnT1hOmw8H62Wwl+q428bUJCXn3AWY6T0KudQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-257056-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9773DF0396
X-Rspamd-Action: no action

The FEC of some platforms supports RX FIFO shift-16, it means the actual
frame data starts at bit 16 of the first word read from RX FIFO aligning
the Ethernet payload on a 32-bit boundary. The MAC writes two additional
bytes in front of each frame received into the RX FIFO. Currently, the
fec_enet_rx_queue() updates the data_start, sub_len and the rx_bytes
statistics by checking whether FEC_QUIRK_HAS_RACC is set. This makes the
code less concise, so rx_shift is added to represent the number of extra
bytes padded in front of the RX frame. Furthermore, when adding separate
RX handling functions for XDP copy mode and zero copy mode in the future,
it will no longer be necessary to check FEC_QUIRK_HAS_RACC to update the
corresponding variables.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 21 ++++++++-------------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index fd9a93d02f8e..ad7aba1a8536 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -643,6 +643,7 @@ struct fec_enet_private {
 	struct pm_qos_request pm_qos_req;
 
 	unsigned int tx_align;
+	unsigned int rx_shift;
 
 	/* hw interrupt coalesce */
 	unsigned int rx_pkts_itr;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index ee4a20d8c438..c5d303f2aaed 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1800,22 +1800,14 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	struct	bufdesc_ex *ebdp = NULL;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
-	u32 data_start = FEC_ENET_XDP_HEADROOM;
+	u32 sub_len = 4 + fep->rx_shift;
 	int cpu = smp_processor_id();
 	struct xdp_buff xdp;
 	struct page *page;
 	__fec32 cbd_bufaddr;
-	u32 sub_len = 4;
-
-	/*If it has the FEC_QUIRK_HAS_RACC quirk property, the bit of
-	 * FEC_RACC_SHIFT16 is set by default in the probe function.
-	 */
-	if (fep->quirks & FEC_QUIRK_HAS_RACC) {
-		data_start += 2;
-		sub_len += 2;
-	}
 
 #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
 	/*
@@ -1848,9 +1840,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		/* Process the incoming frame. */
 		ndev->stats.rx_packets++;
 		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
-		ndev->stats.rx_bytes += pkt_len;
-		if (fep->quirks & FEC_QUIRK_HAS_RACC)
-			ndev->stats.rx_bytes -= 2;
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_buf[index];
@@ -4603,6 +4593,11 @@ fec_probe(struct platform_device *pdev)
 
 	ndev->max_mtu = fep->max_buf_size - VLAN_ETH_HLEN - ETH_FCS_LEN;
 
+	if (fep->quirks & FEC_QUIRK_HAS_RACC)
+		fep->rx_shift = 2;
+	else
+		fep->rx_shift = 0;
+
 	ret = register_netdev(ndev);
 	if (ret)
 		goto failed_register;
-- 
2.34.1


