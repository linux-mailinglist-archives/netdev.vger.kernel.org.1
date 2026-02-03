Return-Path: <netdev+bounces-256131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLJ5ELGHgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:29:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF05BD4B59
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25301310E35F
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B26366061;
	Tue,  3 Feb 2026 05:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ru0lC4y7"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4FA36605E;
	Tue,  3 Feb 2026 05:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096162; cv=fail; b=jnHJ+iMiMRj3TXR9Nz4JJdNZjAPDi5tyI+w1bo+Aa/g3ppEw1vgeXLqs4d6fRSmpISA2AU0oeEV6dWrbbXl/YIrtinMRf58N9kD0tjb4VshfLfTWVB1PugtcH3A8gDPnQILe9WC5s16IDhWf7sJ5kRHP2iHhAEgZKZNY1IOa6VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096162; c=relaxed/simple;
	bh=xdG5pfEBCJMeWqKCay7/HwCZKDqtrffdQOUV735Oz8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IVfXlrLNiAwTjk6ab4MsmIbRwVnS2sT7SCfp8eBtfGivdRIsKSoPkfu5UfrmcuX2t2zL2u/vkSLaxGqRnZvp4K20bS96QM6DhdfNAIDMImzM3+3IpLue0/OKSf0wNilwcp/V+AmcRt3gBp2krLqb1hF7e2EYKm8Zej2wrozSRMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ru0lC4y7; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIZW03/ZOncx3Y2vQ8EQzLlJY5K/mkLvykjW9VFMNfbDc400lG648jhaTPGJ9kfbeV+cpGfEME3ceq9wd7S7Vh0wbq2h1JqFa5sqss9hSo5ZYQ/moKmNHMRqGx9gGNYT75Gp3PZu9LINm+0RgJ7PMGX783dmdtNzs3+/fk9A+D8sub7kR0nRYUpBQT5y+Qp9diHDqQzDTJI2Oyv5TEMTJTITxlvT86tJjPObSExsZ5Fq7hSZHtOy1sDvKawHOOFkni3fOwPcH//FGGV2T/J+XIeFwCerpPOSe2CG7sa4jofK7d/lV1Sb/9iYukW/3ZhkuCqHzoUK5MrlsUQ3ADPBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aybAXKhP676j4z3Cx/OGyzy3DO/e3lwPwEw0FVULR0k=;
 b=DMJPQQ8kDkGx++SIFdHb6xTMxqZ9q2b2Q5PZCOiCW4ZUPUdglG3YAwasDgfET6gk5v+2OTCEutegIAvrPS2yyZr8ycXDLHeol1Zt3IVr+X/rWikBeoa1dfbmp11pwpXGNu15CLJyPZFYTPSX9NISJrLF6ad1udyfAtRL8QpgWOdJLzk0/AlTYVyeq4tPCMrG9C3YB4j97Vn7/TFpBtBjjlIH9b+Uudg2/AqS8LMW46B14AllKDcB1xDsjJpsdO7GDprgQ9LT1yaFCl5f8vG6s7EKOMxOjlYn7HAqzaqLa/ENOr7Meqano5eEmYOX2dAiW2/ObtR+zex4f18uX7Fx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aybAXKhP676j4z3Cx/OGyzy3DO/e3lwPwEw0FVULR0k=;
 b=Ru0lC4y7GtfeCBZ/TxiYJyeUA+mLvKxGhXtV3bz7+n8Fq7Inq2ApYX7hIuxoJGsNrDdzjHrWEcdChFn+RqOwOa7vbYwhRXsXtqQlowbClHx8LT9zdQ4qwyvi9ractL14MaI/UxYSkFkdnD57fcfb4/iAMR+kaZDECZXPJEDa3MPLkRqYw8VNYaP5ZjkpmZoHhPuAa5CxxJueUKaZA4Whh2+QApFqq9XZDdiKCkuttrGufvUYVYOLvdY06LL6ozURUCvo0XhBZiLZQaMDZnPsZhAsIjt+ATlB4+MwAjZQ5VWhOVB40cgZ4KtjduZm4jOQq/UuGSycOByELtFr5sHgOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:22:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:22:35 +0000
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
Subject: [PATCH v6 net-next 04/15] net: fec: add fec_build_skb() to build a skb
Date: Tue,  3 Feb 2026 13:23:18 +0800
Message-Id: <20260203052329.1085444-5-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a4e290-bbc1-4a13-dbfc-08de62e43cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YLSsO6Y9odzZvUe6Sjiag37YAPodaAsOHSvBtTUpI/KC1jc2ZmvJJ0S5D0X3?=
 =?us-ascii?Q?CI7nPKEOYdQhwWwZQrUbZbj2Ms6u+n6XVgJw99QN1/bV1bVhoZE6uYN7sc6X?=
 =?us-ascii?Q?4FjbnqNmW4UwqW1Xk7nGfP+G5LjNN6Zr2dr527MhTAKe/bAhNooLJXkv6s42?=
 =?us-ascii?Q?2A88BI0y0QrZ8Ck6sNoQ6Af6d4s+GhKH9c/k/V1adPvb8tQZmkgSccjx3y9M?=
 =?us-ascii?Q?36sYAI4g7/FAnNbyzU7EOI2JCxOdtmGcQDEPIoEHDuXyfo1FMD7wX7LjMauS?=
 =?us-ascii?Q?G6Xa2wxbuk8yVpVq+ONmPjDesPDvSzI0PUGhWgzw92hE7Izx6WmvV7bZvZu9?=
 =?us-ascii?Q?YOIlLJMoxvPJrm8HmVEvP6lET8/QKSsLmlWaOQmJ1NnIlGe6oSOTW5TZTU1V?=
 =?us-ascii?Q?siqF+ILJTVt+Q7BMGoAtM7iDGvuLtoR3gTrmH5DVhJn6ifcm8cmWmcJSoIQa?=
 =?us-ascii?Q?Rlyw27Lag/XFZNGZH3WoPioJE+RkFZhqW4LWHD7ox4f4jzWgeueAVfAK0LLH?=
 =?us-ascii?Q?AR6TKbs8dQ4OuHYofsEgvcA0LnalrtRX25vZLRhEjBQapQMnfGrD4o7gT8LJ?=
 =?us-ascii?Q?pXEFXOszxqNbljp6blHw2tA44c8GznGwWZn/AmHMpSX7X1nbvrjNIFl0eNvp?=
 =?us-ascii?Q?fUZ4N1COfCi+mr8pKDnUXpwY4Tt0r2QK3d+D/DOJpun1+43XQa8UidITU6yP?=
 =?us-ascii?Q?Dtqq5f8tRxZFdB9PbSZPvD65bvvYp9NLZrCQN8R+wJRLN/wC4ujbVw1V8ocy?=
 =?us-ascii?Q?cdEMVQBSguAh72FS6+qEtYpjUzW37NRo0NKFUoXuHdYqsg99jtd4TXtxuRYM?=
 =?us-ascii?Q?GhNwqRDPMkFPmo9VWcvHA8JHm7hD5EuJpkB2gBs1s62H8zZsnOszoJ1F8JVx?=
 =?us-ascii?Q?NjSBS4Wg2wGIDWcYaWAyjTVtGeJIr1WpDUMT7W/AvxW8eUh5nsVKbBShQ2Je?=
 =?us-ascii?Q?UxGWMMIegmMnmCABy3KPXYEWll4qxMN4CN7KiiMApp/jrARWDZIgznzoIrDz?=
 =?us-ascii?Q?8zzV3sy/+Sn6xVQAOAVDsvAZpUAizBHif2XtdwDX0urXZHNvL95I67vPWczl?=
 =?us-ascii?Q?JJddpCAbRrKf0utoNwzxgHQEO6U6h40emo43k9USof3/1VR6XZGvR3VXDi8v?=
 =?us-ascii?Q?w+/fCEdXRCuSKsnMjAfPomIfoGqtyq1RfkKj3AezWkBz4vRnqRFYEe7rdfGa?=
 =?us-ascii?Q?Q1bPmz+ELctwc1vx9Ee3u+bKHk6RpgY7041WqBRRBJV7Ub1B2nuD8ACOaxP7?=
 =?us-ascii?Q?uMMQqqH6GbkdEe8O7QFoixs99Zh0T1Ui+g5iy9i87kyRUCMGLNSoR3+P4TQB?=
 =?us-ascii?Q?gGCotYMZ26Yrq+vXhLKf6z528BTtWAK0oBCzsPyJYfkHip8twCa8W/nVI8vM?=
 =?us-ascii?Q?MGjkqgUmsbB2THyTE2vZwWprHdbBKuf4ivmifHVjfXgewblHRZvS08q3X5dx?=
 =?us-ascii?Q?X4tIVYqbvbvEbjenYCLwukc4StdZo8yZnX4g5LaDD5WT+LsMK+oVHJWR8bOv?=
 =?us-ascii?Q?5toVmv6faFRIVzKqWl+Qo8L21z7Zw87abg0xrUmTcXZcUvhwl/9MxcZ19CIg?=
 =?us-ascii?Q?+QODOKEpEkMZaMBgDrIdOf28tndZNXnHXc5pQMU69ZLqGhpNC6MNGrmF4pUC?=
 =?us-ascii?Q?bM/eqergThZw8aZB+QGmG30=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KduWe2tfEGYTS/a4K1ho7caxWFQ9m9gqJOZSydD5MXOSYTSgcrWHXfLJPjdB?=
 =?us-ascii?Q?p2EGotc4MBCBScc6Z8ZjKKkg97UGrd63tjHVk8gmAzOAFI4QvA7icj1HtIyK?=
 =?us-ascii?Q?miOgqX0gOx6g8PZkFktDBFxdMPqW2CVJDoUP2gIBTcdXcZ5IEP3IbhyGQeVh?=
 =?us-ascii?Q?8qi7lqgByb1jR37ldt3RHg2unktr++nHXT7IjgXfy+Y1QIcGlWcizroX/6Ld?=
 =?us-ascii?Q?4UkT69pdwGBhfCePf/MonUh6uVI4FFoRlojKlgaokI1IedKsH+t+ck+gI0L9?=
 =?us-ascii?Q?5zyDPCtTjg+IsycMj9y5EwPSTSFUVIztf1+Oh6IiP9leoNGFoH1CXk4xnugG?=
 =?us-ascii?Q?8jcOb5C/21oOVibfr12Yftyn3NzRMni2QCXnJ1N7Iml14tny0Cu1jk5qVL9N?=
 =?us-ascii?Q?2GLIbRTsaJib2VdWJmzkDNLyXgwpOS1Xhh+Ocd62EUfwoqknL2F8vw7j1Phy?=
 =?us-ascii?Q?1sOXUe7A4c57oOZydUsSOFmMyLiVr7bMd6AWeVf1kGgBpwdlbqZJznCkyfHx?=
 =?us-ascii?Q?ITsgalBB6OA9iiz/KCkGVOUPLnpZaDsCKgEW8woMqWkpMBhSQ2uqOa93NMVB?=
 =?us-ascii?Q?ZNB9pUx/l8mginuQDg7UASKVtWB0wwVVQ6KsXkI37tNz3od5SlLJDTMD+W2S?=
 =?us-ascii?Q?AEh+7mJ6d50bsNCh9zafHXNciSIdIH46QkIwHAtA7Rl7xu5gmvQMjKOyv4GT?=
 =?us-ascii?Q?mhf/IJMUfCGNRxqnuGjRodU6ocn2JQ+9jq+wvEL4dDF/GXMMA5RQKqnD7Bk+?=
 =?us-ascii?Q?2vNh4MoWlqayFxnv3o/duhsYU6jaQnOQjdII4SddDNKL9R1W+3g7/VsuO1EE?=
 =?us-ascii?Q?0adjMU6zrfx0RtiGYTTKA5fyjAObkYowpfp/NtNCJHQBIQC6N4Z8tFkvLlnn?=
 =?us-ascii?Q?psbD8tU4yoo9DrMHOMHSMATpzpRfKW9dzvK1pV8MRsnw2v1LQ+hQ25hqvv0o?=
 =?us-ascii?Q?DB3v9hJ26rLkV5agx7ERDmhIpXcAuPOgPNALagLssd4eAEMC37baILhP4smu?=
 =?us-ascii?Q?U69F16k4WhhG6s4lhwtbQQ2jUQ3PteMnJQtExA2mNvVkIBfG/eLG+zA9qi5F?=
 =?us-ascii?Q?cI+B4evijI5gCs0eVHpSV71zBO2nuLBh1DJzEB3rK5RS9tT0yT5HvENhpPwl?=
 =?us-ascii?Q?Y3dhySXccMzXRjDeEtwEaSI549xXWk4inReZTVgqQ2Uq+F9sFDFGmsItqMhQ?=
 =?us-ascii?Q?ORWEqStzxdKrOooggMf1cRrl1fQ/u/plvnLOBaxyxW7ed4yVWpB2/gIYS5ad?=
 =?us-ascii?Q?Y5dn0otZGOQ3gt60rCtsFyARBhndNwqQ5QJ8uTUKVVuTcY+SYpNm3VaNi4ZS?=
 =?us-ascii?Q?Kb9hmwK7fijrClSStzmJt7bFcevUrkDO7xEZvtoA795leBkf/pB/11YoWl4b?=
 =?us-ascii?Q?AfFAtJAAdspunn65olQ88V3otaBrk4FAWkAsx4dPsHZ//CDU4FzX1rBnf3VD?=
 =?us-ascii?Q?cOlwXaUs2ruG9h7OXQUCwwkX6rPlRrppWNcybrMr0Dimwjfx5BCZ8VVTh/6v?=
 =?us-ascii?Q?7fpTLd7RZjRxRbpRbP0FvgMw9KOQIzSg90B1qoLUvX4n2fTKQp/zxknT8rWr?=
 =?us-ascii?Q?e/Psr8v/nmIqTy8k2SdPjOMaBzi4fVdZSns6ZeVEvzKYQv4+oz1jzlHLdLtn?=
 =?us-ascii?Q?WcY0n347EfJNvDVJcX5jaRgT4lpQIflRyE7gu4DLL0uCPtFrfw+/99HKGPlC?=
 =?us-ascii?Q?9bD8316Fb1fFMy+1+oeZBNUOJz9NfoGdsThmVmwWogc+eILc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a4e290-bbc1-4a13-dbfc-08de62e43cfb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:22:35.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/AOvT4rHMPP0LzHNVOnDwR7FKCiotFaivEvhytvFvtBzbVQoSiLb5X278vHJ+GrG3Y+alBetDE5xreFnjcVGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
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
	TAGGED_FROM(0.00)[bounces-256131-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF05BD4B59
X-Rspamd-Action: no action

Extract the helper fec_build_skb() from fec_enet_rx_queue(), so that the
code for building a skb is centralized in fec_build_skb(), which makes
the code of fec_enet_rx_queue() more concise and readable.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 106 ++++++++++++----------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c5d303f2aaed..851608d04084 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1782,6 +1782,59 @@ static int fec_rx_error_check(struct net_device *ndev, u16 status)
 	return 0;
 }
 
+static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
+				     struct fec_enet_priv_rx_q *rxq,
+				     struct bufdesc *bdp,
+				     struct page *page, u32 len)
+{
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc_ex *ebdp;
+	struct sk_buff *skb;
+
+	skb = build_skb(page_address(page),
+			PAGE_SIZE << fep->pagepool_order);
+	if (unlikely(!skb)) {
+		page_pool_recycle_direct(rxq->page_pool, page);
+		ndev->stats.rx_dropped++;
+		if (net_ratelimit())
+			netdev_err(ndev, "build_skb failed\n");
+
+		return NULL;
+	}
+
+	skb_reserve(skb, FEC_ENET_XDP_HEADROOM + fep->rx_shift);
+	skb_put(skb, len);
+	skb_mark_for_recycle(skb);
+
+	/* Get offloads from the enhanced buffer descriptor */
+	if (fep->bufdesc_ex) {
+		ebdp = (struct bufdesc_ex *)bdp;
+
+		/* If this is a VLAN packet remove the VLAN Tag */
+		if (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))
+			fec_enet_rx_vlan(ndev, skb);
+
+		/* Get receive timestamp from the skb */
+		if (fep->hwts_rx_en)
+			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
+					  skb_hwtstamps(skb));
+
+		if (fep->csum_flags & FLAG_RX_CSUM_ENABLED) {
+			if (!(ebdp->cbd_esc &
+			      cpu_to_fec32(FLAG_RX_CSUM_ERROR)))
+				/* don't check it */
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+			else
+				skb_checksum_none_assert(skb);
+		}
+	}
+
+	skb->protocol = eth_type_trans(skb, ndev);
+	skb_record_rx_queue(skb, rxq->bd.qid);
+
+	return skb;
+}
+
 /* During a receive, the bd_rx.cur points to the current incoming buffer.
  * When we update through the ring, if the next incoming buffer has
  * not been given to the system, we just set the empty indicator,
@@ -1797,7 +1850,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	struct  sk_buff *skb;
 	ushort	pkt_len;
 	int	pkt_received = 0;
-	struct	bufdesc_ex *ebdp = NULL;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
@@ -1867,24 +1919,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				goto rx_processing_done;
 		}
 
-		/* The packet length includes FCS, but we don't want to
-		 * include that when passing upstream as it messes up
-		 * bridging applications.
-		 */
-		skb = build_skb(page_address(page),
-				PAGE_SIZE << fep->pagepool_order);
-		if (unlikely(!skb)) {
-			page_pool_recycle_direct(rxq->page_pool, page);
-			ndev->stats.rx_dropped++;
-
-			netdev_err_once(ndev, "build_skb failed!\n");
-			goto rx_processing_done;
-		}
-
-		skb_reserve(skb, data_start);
-		skb_put(skb, pkt_len - sub_len);
-		skb_mark_for_recycle(skb);
-
 		if (unlikely(need_swap)) {
 			u8 *data;
 
@@ -1892,34 +1926,14 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			swap_buffer(data, pkt_len);
 		}
 
-		/* Extract the enhanced buffer descriptor */
-		ebdp = NULL;
-		if (fep->bufdesc_ex)
-			ebdp = (struct bufdesc_ex *)bdp;
-
-		/* If this is a VLAN packet remove the VLAN Tag */
-		if (fep->bufdesc_ex &&
-		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN)))
-			fec_enet_rx_vlan(ndev, skb);
-
-		skb->protocol = eth_type_trans(skb, ndev);
-
-		/* Get receive timestamp from the skb */
-		if (fep->hwts_rx_en && fep->bufdesc_ex)
-			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
-					  skb_hwtstamps(skb));
-
-		if (fep->bufdesc_ex &&
-		    (fep->csum_flags & FLAG_RX_CSUM_ENABLED)) {
-			if (!(ebdp->cbd_esc & cpu_to_fec32(FLAG_RX_CSUM_ERROR))) {
-				/* don't check it */
-				skb->ip_summed = CHECKSUM_UNNECESSARY;
-			} else {
-				skb_checksum_none_assert(skb);
-			}
-		}
+		/* The packet length includes FCS, but we don't want to
+		 * include that when passing upstream as it messes up
+		 * bridging applications.
+		 */
+		skb = fec_build_skb(fep, rxq, bdp, page, pkt_len - sub_len);
+		if (!skb)
+			goto rx_processing_done;
 
-		skb_record_rx_queue(skb, queue_id);
 		napi_gro_receive(&fep->napi, skb);
 
 rx_processing_done:
-- 
2.34.1


