Return-Path: <netdev+bounces-254722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI07NPw5e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:44:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E794AF013
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDB5E3050415
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02583859D0;
	Thu, 29 Jan 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ke0YpXww"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013064.outbound.protection.outlook.com [40.107.162.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD982385EEA;
	Thu, 29 Jan 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682921; cv=fail; b=Hdv1aih0MDJjN28J34jUwwlx/qrPJ3fdMQoeFfujqgokb3JOixaZ3QTHgjH6K0GslVk2BO3AJnQgeBAEh7SWgHMz3GHkaqZ8nlKLxQdZfFhmsZwSvO7jpCi7D/8W/F4dLqRhgU603BQB/R2wewCBqJAieViZ/6Yceu9mPTMwCmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682921; c=relaxed/simple;
	bh=jHe6t8pgVAsepns3mJ7YPFDc8toue3WjE1HybU+RQh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dw3AT+AE4vMqy8e2we09kqJN1khrKXS6k3uQdjJHY+kZMHndckDrd9/hhwXw7y4puKfNUVT5OSxNCXR2Yhu0mpuDF4CC4YUxntdncfZTPQ9scYTm2evlgL+xMK5jTJmULnjOApAh6HujLAn0GhR06Mc+t7OE43WBMV7glsI157o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ke0YpXww; arc=fail smtp.client-ip=40.107.162.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnaLFEGPSy7Pdg+wXfZgXu8ExjjE63oxxB/8mK1NCtS2F8rxPX4zBeN3dtHxHdY4lUKRAAfqyztWs2EOi2QE8PT6qKSmBHe+yG/y40BgYtFe1h7fh6F5zdcgmmhw20VylYN1xPZE9E1hcTvAHw0gSX49ZqMJfZvP1+mZid1MRUu8ZGnDjJ6cIeZr5ce6NxjEItPAZOk+2WjFkziOmChV9xRcSje9otjQlrL84QaNrIQH7oKHCyDLpK0JCD8Sx6S6ktR33z5Tk7FEvQ1f5kjD45+aMrTYdmSV+V2T8r0fxhc637bxukzD1TMLwP97iHc0c4MQVXNq+7cMYy9ggC9jaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p579Nm5zIFUBNV+a7fLnSxrUAu3/YWLx3eUue7EHtTw=;
 b=iw4P18MEs/MTcsJt4nLSyE/zzWWXF3QYlt4qv1jKHyW0fvYeVAnkFP3AajMWoP9aWlS5ejc4U9CnuoIf6PCdA/T1SCzOjkBI4+9Txp4ZSZSsAwfURTGoFpFQDRtsSYchYE/UjxXrlsnHb70ezIxlOBaDji6fjsSfp6TFjcfMRX+A0Jca/z4pTMSg/w0w3IIDKf5CMfK6JjNEaoGeTHeB//tlXGP4iHPKBYT0CGIWybFjh9Mi3mwwmwd0uOMdZWlnnw6nJXOhMiyHQCBmevI3zh887tqnSKEKek5Bx/Vc1J5f/xZhjPNBoer9NO/bQJccKQeV/c3dVMbNcAJUIQA2qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p579Nm5zIFUBNV+a7fLnSxrUAu3/YWLx3eUue7EHtTw=;
 b=Ke0YpXwwcKVhTGoks+3jBn6udOEGUWCwcWI8mKsQ1bq0kpiEK4393LW5TTUlfVWw5VYWtP3lQN3dmmjXvxLyoYV4sckp+EsRVC9JxsarJQi4F9clz8Ae81061tvt2i7ve/DNKMTTGVp2wbaL7ihdvyn4hZFZqTSRQY9ioe5Zi+UcIrEIYsFcqFbtjaJXFY318ckTwsHOo7Zeb/5J6Ryu5i27IStE9IVDvXkYIfydYc53n9liWyUt3r+v9jYmb30DwNhtVlBORfz0ZE6tWFT1Ntdn6sm+b7+bZceAaN9PwMOFEhgXgydQBL1vKTfdrXEIJ7Ac0HQ8U/5EuFSsyOmnOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:35:18 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:35:18 +0000
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
Subject: [PATCH v5 net-next 03/15] net: fec: add rx_shift to indicate the extra bytes padded in front of RX frame
Date: Thu, 29 Jan 2026 18:34:35 +0800
Message-Id: <20260129103447.1893129-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129103447.1893129-1-wei.fang@nxp.com>
References: <20260129103447.1893129-1-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10843:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b79f48-83b0-4ad5-7618-08de5f221885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SZFQolfB+fut2aoQss+cl9AS81xBumxqkrjvhzubnbwWtjx3nqbD4C15ilhn?=
 =?us-ascii?Q?qLs9R7KOg2JceasohTwViPgWErjB7a0YrqXwYPrvCDyKPzyBYNAJM4N1j8jk?=
 =?us-ascii?Q?+/0PgRmrPisif1WhypivVzNS7m2CCOKQqpD5luF2wG6Z2IepT4/BzXN1y1Ec?=
 =?us-ascii?Q?/kho5gR1omMuk1jJgbLI8kD6DWEZvLTIZDVI1yd4GdLd4EQkt0kRKVJ0feoZ?=
 =?us-ascii?Q?LTK6c3SH/eYhn/FyHWTFBX8oXwGRmoD2yb4pBBdyQ8vOrpB4eAJwy1WinDgM?=
 =?us-ascii?Q?BpPzxsaGsCSPri9p+rX1cTidGeR46rQVwEe6dAq+8IPC/h3/+Q2ZqtBhAy8n?=
 =?us-ascii?Q?Uk+6kRcy6Pq0gz5lCR32BFnViFO2YKDyt9sKuAo2/ZOml+7sMRIhswtmfJDT?=
 =?us-ascii?Q?OOhAed4e/2XzhLnz37Ky/6JrIddDxSwl87rfH1XttC0bCFblENXH9Acq4LNO?=
 =?us-ascii?Q?mgvIlFEzMcHdrA3mhSKQehVvmy1Hg4/feOtfkx7xOGNkEZWfvpSTAoYUFapt?=
 =?us-ascii?Q?DwPyRrIWuRlrhQyhXWuy72cGu9NYY8lRKfeLG04ilmJ91lpdVaN68SvtZg5I?=
 =?us-ascii?Q?XkC3Yr9r/Q/TBNABXpWn59+C71Zk1YYFum4IzRZHDj3JgBVISS5mrkVOpUtN?=
 =?us-ascii?Q?ansCb0Mx48PVyN28Jvxxi/Bz1RqTnLXEN0oo1cHk9BiQiPgMfxoTMrB7xDpN?=
 =?us-ascii?Q?5cyu+LpsI+mCCgr95Ab2RZ224ddO7clFzP3FaBE+5ahlgvD+AqRRatxWi1qh?=
 =?us-ascii?Q?4w8j/+i0A+il5pVv7rr18u4rJc4zTZdw1tuz3Acbbk33Gjhks+YyP8W/yYoE?=
 =?us-ascii?Q?kCQ0Fzgoi1CpnLgppga9h3tpkoN6H5BMDmgosG/liaOB9xE/FNFVY2Z6TaMZ?=
 =?us-ascii?Q?aapb+EI5ci0R2TBuvQTnRS60xgoAlxAfl+NVdGWEn8xHLqrwc7ZsIjn/KJp9?=
 =?us-ascii?Q?wdGMXLa+vanMTPDUE8lzJuD+905wKollL34FxMd0O6fdbD2yYSMm2DznZf+e?=
 =?us-ascii?Q?/grC7hq5KuILc+YRTOQq3f210Hkez5sGEW7R0C5Ncwvb3k6N4rAWeBizD6eH?=
 =?us-ascii?Q?1Abd1JtvdP4m6xHJ4l3fG2utQVbHhQ8NTZkmt+2OJF87YxR0sXwar/j0vVv0?=
 =?us-ascii?Q?iZZKUsdnLBJN3HNr62piPlRo+i/zGBXClYwcwAuYpKVq8ZG7Cl/ofUtXVkdD?=
 =?us-ascii?Q?80/NBREXt7O7CJ5VtwkQA5lfHCA7EKEEQbTr+tuUuVIa/NGooXCFFG+cPPkD?=
 =?us-ascii?Q?CJ0wlCWAbDa9TchVIURlBJZOk11M4XSmtXfkVRVDE2n9Zpeo6PyAdjAsZ7Sl?=
 =?us-ascii?Q?nPZtj08B4SK5yHOdG29WhsMqCinaUsDl17PGBYDUbbg1VIjqaHQk/OSWbUlX?=
 =?us-ascii?Q?HFHKOJQs5fY+xo4zCAn4hXsund4iiQnmsnf69bqIhBXP4RvPKeP/7SirV7v7?=
 =?us-ascii?Q?7ucOpvqI4fCwr1BVef2yGmLcwIuD7rEVMMFayeSDcVXov2E90QY6s9ocOQOw?=
 =?us-ascii?Q?NU7JP6NDCV3rjCUFE3m3wiv2nJiHoMWfh2WZw+IF1SCsLMVj7o/SivzSELrV?=
 =?us-ascii?Q?PqKmsAcDqv25GBsgyifwcPM1IiZLlzfQ2sD5KGvjyt1CjLJf33VVcE7g7h+Y?=
 =?us-ascii?Q?9aA5Vbi1/mabSt4ZqnAjSP1Se0erIodp33RsE8TcZIDL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dDIRe4f2AIOo7CsQHTWlT/r/Eynhpj6o1c6n7MCEtbKEYn3/EruMSBmYhKYQ?=
 =?us-ascii?Q?bG/j760qTsyZaURi66aI4kDTftSSLOrq4LLcvLS2SJ7J8Ji6xFlLsOwczo5C?=
 =?us-ascii?Q?2730GxXMa5vekSUfEbWoNiAlXwyW1BqWYv3C0d/Z6taV6ZcKbz4gDuX//cmB?=
 =?us-ascii?Q?Vx2xZuBuXQCQRfDTM06JHG0z3t5DX9OO2ME2WNG4aGBO79Ua338AOPcB/nGH?=
 =?us-ascii?Q?V3l9BlTMkOIrOHwazsLWi0Fvf+lbV43tqzHd3F2xKX4Z230d9j5UVuDC8PZ0?=
 =?us-ascii?Q?XnyX1WrZa9CWgHuCTalurNWrR1vpY+S3n+hiHt9UbPVSNZ7DV4zTQwJXIWZu?=
 =?us-ascii?Q?2Ie2hbCakxZKsV2m6BJiJhZ6ZWRxv7jM42sYz0n6Z400gpv4E/dPNBLn2BkD?=
 =?us-ascii?Q?W7b00mvCdWdsAINsCfuoRp86yBMf/xu/2rLemrZ66GLETucaBLUK0B0Gymzy?=
 =?us-ascii?Q?RCMeF3qRdi+qsoaq5JzruDtVhsODFiBrIoecDiWfn6BAUi8BWB4lZoUHb50n?=
 =?us-ascii?Q?nPGuFxH6ZCapqOKpwhb1XxWW2zv7yKmDXPADVTAFPXkPXe+GqO2uvQECVrUV?=
 =?us-ascii?Q?DhTzjqUAeX8IinOK1Rh/ijC6zC9GZ56uh2UmKDHZlpgBxUMkCuJLEs1uNqP6?=
 =?us-ascii?Q?FvldMz2R9Ot/Ydc2AHtLw5F1WeiF94m8GiWoLlxGZH0l8+n/yxYocuk02Sap?=
 =?us-ascii?Q?WSdp8NTT3ZOmTJ82pEy2iT7cXIGvmk5WYyg8fjO/q/+0kKDq2CsNtpSXOpqg?=
 =?us-ascii?Q?a/GQph72vErK34m6j3nPYGX8zSSWXNWA5Bypq/MDWddQyIS5BkXv0llwc160?=
 =?us-ascii?Q?rsBAlphT0t6APsTZuBTcl+CkwNsYck89FAohlAT82xy3khwZeOPS+XTDf3C0?=
 =?us-ascii?Q?ZZ9Bei/b6eSLFcLW7S5058UubT6g/4TwuPW620NDkaWz9Vr8tazmuxsmKV1f?=
 =?us-ascii?Q?c6480N/T0PKbKSecY1aT789paITHjHRZOc6Ga5TqupTCZgkulKuRgrF9SS62?=
 =?us-ascii?Q?l7EFNsQKu6BtN0Y7659YgVK4G96VpiGdjWjxK1/fSX39XN473L06yL5PLSz4?=
 =?us-ascii?Q?LQSsak+dMSIL9tg7bBJlyAqnxb9iU+1UT9Zqm1uUxfbptFKDYvdw9Ggqv88Q?=
 =?us-ascii?Q?ZLOtxj/ngx+YlplRijqAypIUL2HgjGpV4g0FlpGrIJcODz/Pn/KOB5MrSBT3?=
 =?us-ascii?Q?txA6joPk9zmisMSklsiCHv+NouW9JqZt8iE+uYO9Un1MEAKEYtNhWZhsOFDS?=
 =?us-ascii?Q?54nZwL6W6ZMo9ZYQD7VyVSerkwFZUVbcZuB7lms77xm2zWn34Yc1RaJE29Tw?=
 =?us-ascii?Q?o9veemaWN8SCqatJABXyG7H/voOC0Vqt5eQ3k4mgKdf8aHRViDmqZBl7Hqjj?=
 =?us-ascii?Q?AajCyeEWTZ23EHi8EVJZ8LjYk7cUneeE8eykEFOOlx+yEceSYBw32WkaqhQ2?=
 =?us-ascii?Q?3iB9rqNBjD/GMciHQUIjENAmWpaIz3y6b093rYy4Gm1jygTTuGh8rKtCKM09?=
 =?us-ascii?Q?AHiqbWdyJtlbJJMnqFtA5W3Ji5giix1C4LS2PdwcdwS21FWe22Ht4QZ79nCC?=
 =?us-ascii?Q?+2+REpdgNwoKJiSlMVqtN7xEPb4zpG5utKOxgojGXP+h4IBM80XQDI9BsGTl?=
 =?us-ascii?Q?yK3nQIbJLurmJwGLBYoq/qbOlDSAm9g0lDZ+gCQ7XfGN/ZL7YRnbq7gnQYOn?=
 =?us-ascii?Q?VlL0WP+tzzaQ9CwR8QcK+3bEL00dJ0r/Jhl14zx+jS5289yC9rYBwR08dUIM?=
 =?us-ascii?Q?vaxVmpnqCw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b79f48-83b0-4ad5-7618-08de5f221885
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:35:18.0849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsUfJc+zryoIB9gZHK7ibEFrRQwW83hZf1X8F616Gb9dDeeJKDaB4DGMn/C2s33CyIegaxq7ECCtjNv3MSY61g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10843
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254722-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E794AF013
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


