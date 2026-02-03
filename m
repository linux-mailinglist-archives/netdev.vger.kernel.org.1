Return-Path: <netdev+bounces-256130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJiiKjqGgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:23:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB6ED49C5
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 572B5300BC67
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252F8366803;
	Tue,  3 Feb 2026 05:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D7sRVd6G"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744D936605F;
	Tue,  3 Feb 2026 05:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096153; cv=fail; b=BcZAT35ZT79PD72PaELh+CcahRy415KkGKTcQx7kbvgbGLoXW9JP+VdGoIwRrd9gt5DXWnbdgoykGSOzLjSVQtLtuS2NkONyIBY8Fk8mLISGW90k9TX/Fx1rkmRNfasD3RnPn871aO+Q7CfWo6LdJ926R5qoEZjBvRrlt4RTTII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096153; c=relaxed/simple;
	bh=jHe6t8pgVAsepns3mJ7YPFDc8toue3WjE1HybU+RQh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bLd0an7uqj9gAY5Eedu4d91iDEYsAzyKmnrAdAh68aD8/gqlvZlu1Kk9mrQE4DVOzDbaMeRWnZX4okqbUIzmpyTv6bxsL4H/XPLZLDd6zarVNjNpM5y7WNZ4DtVhpPQC+2kOb/ae7nPUJIMCK3EEi/EBecyVqttPGcxqFRP9JU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D7sRVd6G; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VM6pOlVemkxzPO7NDXOzZXGfajHkEf7toTCTU+XXdiUuOuVz+BBCHJ6L8zSpsjBFoowg/FWoTlR/dMIyxM95qUEBXtuN3v6oV2DD6oN/Zak7FfQxlV5+3AeA5W6qtwYj6ylERee2HMBnLgOF1zn8I6h2cFzNBJO3uN4eLtPfJHyQWlUG+0A0MQXEK2jz0tj7/YMtaAJiKIx6ZuV5caFYH1ipvE/DGTOov0DYVj2/ilQ9byXJwz2J3f0SfHkCQ3wFc+I88aroIeGT7S5RBRmMJC/d7SIlWk8IbNFeCoKV/Hcus9jq/20vVkxPz67IDv6yB4cE9KRCZ2Qhea52vGa0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p579Nm5zIFUBNV+a7fLnSxrUAu3/YWLx3eUue7EHtTw=;
 b=oW9sxnZonILElfrX3X7upJJu8o5K2/sXgOf2Vi81JZt6Yp1003O1Egb5WhJyB742EgvquOxqGbfaizSr7x9fmV0e0iMTmBxNdcN0XDco/vR8N3Zkghie4awNUzeWOUOGTCuT0CW2MX+Lnm7ZLS5Dt6lTE5wK0EfyOQ4G51NnigA4QN2NTSInopTA7Afk+0FzU549ZwzBg1xpbFKAKyRYxwpSUME8vc5wGd3RLSYjC4Lz2rUEu++wXnIHeGFNGGIkFWA7ZpjaGg4UMRWhqnAMzNPvTtqFg8AoCnDexrBiSIYJp5Ka/jlbqH+sU3ZjtW821W0FK2D29c16yi5XPnSNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p579Nm5zIFUBNV+a7fLnSxrUAu3/YWLx3eUue7EHtTw=;
 b=D7sRVd6G7K2U6iJATNCitCs7bE0LULg0sAj/Oe/DnTXKVX2PjTynRx+y+eMclV/Koc1WFLXN/CYSAARvOJ2ZCx95B0Cfag/6ezHQotMILaNeb5EjMFN+l+eX5r4duB2PV6lbjssnJNYM4o90Q7JRs5hrtm2O8waRVfVIDBkF4SaJzW0yutUqr/njo5ZnURDHrcVCgn0LQ5L53RgbP8buqAQUPLGQ6gmmX7qTFYezOp3AHjS46bsMgjikzCu/MzhYSYKNg62C0dU4RQUzeoGMasDCRILLqDzfKRv8GJptNtfF5YrT9qVdcHJFJ6b6+xknc1LCQnAiChcd3WhrdFheJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:22:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:22:30 +0000
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
Subject: [PATCH v6 net-next 03/15] net: fec: add rx_shift to indicate the extra bytes padded in front of RX frame
Date: Tue,  3 Feb 2026 13:23:17 +0800
Message-Id: <20260203052329.1085444-4-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b624ade-b591-425d-43ba-08de62e43a1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DmBiw/qzzULTxQrGDHi4lkfMQdbIEgU1wyB3k7JXns/uULlX+2DZjVFLp8Yd?=
 =?us-ascii?Q?+pJ8L6Uk+LaLJ2+t+pgHoMXMsiFcyFNq/kCeoQQFZrIrmkzuS3ygM2cbfbwU?=
 =?us-ascii?Q?Z3o7abY8VtijKW4Tmwnbl2xtvr7jZtDO78m0zMaEYk8h+H8hEg10da08xayC?=
 =?us-ascii?Q?9T8IU994ju0IRcpY3k71jQ7MgISow3owapzzZAjPje2UGfNOQsMBf0mUcdET?=
 =?us-ascii?Q?V+Vgnk73kRW3bi25SolzaZbh9eDw9a8dorwNU/deTimTqqFGiRRC+K0m8Nv3?=
 =?us-ascii?Q?5XiBWQZR9hejS+0wO9BXk1f2NCLd2REEfRnLuII4TpWw3HfGHmgKOEs8iq3s?=
 =?us-ascii?Q?LUI4wS6krXwFWklPIyzDL0MNPo3UrqYIbINQgD+x1Z/ZM+xiUSPiDX2IuBBs?=
 =?us-ascii?Q?GABmf3CiwZQ8QFAJlgf8fLI1OvG0+d1xS4OeYfZu6oP7paSG7N1epT0ZayRM?=
 =?us-ascii?Q?t03nRNl4uZnTSfYybp3h72hPyGJkTGjM/ZDkDeOCTt+Ltwj26EFrl+OvAQGh?=
 =?us-ascii?Q?kFWqAtYrJEUH2bOg/Uj+ay4BMDz5bgY0rbqcgy+LvvYFbz3Vn1O1KgbQxPhb?=
 =?us-ascii?Q?1p/4ezZR5ldvJofwnnssLTxDmH6A/PMC0G1LPk1m3RobupWAK7p/24Mit45X?=
 =?us-ascii?Q?eTx8b9hcJ+diM84a48ab+wTD0xpHLbmF8kp5xOwJtDjWE+5BsaI7HZXrbBdP?=
 =?us-ascii?Q?SoueeSmu8PKlDZcrwikrrNVfh1iZACGChMzGIVlhx1Dv0n9Mh69gwJa7Yjpc?=
 =?us-ascii?Q?3hRo21+KeA/f3B3oBAbSfoFQqRFTHhImnpZEWagtARSTnseVC6sTDHAJUUIs?=
 =?us-ascii?Q?gckERQbgxHNPfNVbnVy8npd2ISvpcoKPAp79wcGsEE0mvGze+hed3BGl1p9N?=
 =?us-ascii?Q?vp7nu/EeaDlblJ4YPrJnMvk5eEaSZFIm/4tcg6PVRpwlJp/0yFwzlOl6zOPt?=
 =?us-ascii?Q?i8exjEkH+PqjlUZWTjtYJQ8ZRB2VgrEWGpkoSQm8czqqG+yI8IDRhdTDueeX?=
 =?us-ascii?Q?u6Zs52+gcgKfJi2pcqKgMtXnpNb6MV8R3aRazb+RUkocmdxSmo9lMWiD/z57?=
 =?us-ascii?Q?UmtrVu2PRPsbkhV4Osgm3pm0gmATvZIPRAWZtymBjd0pE2wwXigTSMkC776e?=
 =?us-ascii?Q?lr6k0j8HUddk/IOKFdHvgM37hflbgsmG+EXlqTh9mKTjxLUIY0yzQqAJp75c?=
 =?us-ascii?Q?5D5P+FKrw/TuPyn3jzbTdtbfTHS779Rd12VCbKWmvi8Tx4XlH69C437qiW0I?=
 =?us-ascii?Q?lSehbsTKVgCdtG6YV0sUVay4f9UV4bsPIoiR8w5QPC7fVQe3Z4vewh4+tn/W?=
 =?us-ascii?Q?eKtVActQ7Vo5uvhA6Zh92ldq6KpPntX+veWLeNK3rH1+mNu+/ONYo/GHKLrS?=
 =?us-ascii?Q?lobTLzse+k/MPpssIpsWWQzacT4rJhDTf9HAYKvhM84hhWBtbrEIPR3SKaF4?=
 =?us-ascii?Q?DrQa1lhhQN/cFN7mbdmolM6jjjs7sfyb+rNJs23PH1qHS3GxLj9SK9PJkFsT?=
 =?us-ascii?Q?k9I2SvnOk3KnHi2MFqeVhzhIOEvnhqO7m32Bk07E+rcMARepwoUpX0qDmXlu?=
 =?us-ascii?Q?DZbj1vWYBeXjXTICxKWiI/Asqv3pveVEFPbzSMuWOV/OAiRHwl8NeibfUCn1?=
 =?us-ascii?Q?Wezq718Ta54BDOL3tRc9nGdQ1Z/mBSMypz8yHBFNLTKF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H1Dv9ifrq7SrA5qNxd4okqlwk/wPStBy2vcUmH7iDQnaC9hf0Tx4xyqjvnlp?=
 =?us-ascii?Q?GWoRJdcUQfYC5kpdAyvm6gFa2HOHscaUsZmxdsJ9VYmWCBEH2yYhfmtPgSJr?=
 =?us-ascii?Q?9354nRNoUVXQR9YxiLHDMD+UVXi350dJ+H8Stqz7m5rsGYHpLgQYW9/6hYpg?=
 =?us-ascii?Q?9beL4XmbZvtbkBRDz8/zTRNJ+nB6Pxu1Wm6kh8wRNP7/G2nvou/sUKHpcRm+?=
 =?us-ascii?Q?R7HLwAi8bttkHATkiIt4usCl/JhisVn073Pd2u3ZSt1A2o1EHIfDElFunOmV?=
 =?us-ascii?Q?DqPKnp+E8O6C9DAQvZWsMXXRRmreMcIYjyEWpvO8jUAZZRmV0VIYjk/PrlY2?=
 =?us-ascii?Q?1eobqmqcl583wcyFL0uvJZbNaKk2b8vA18BJWN1xT4625mzxmLppYUBTjfru?=
 =?us-ascii?Q?lEeNTrj2LLK9Bmt7qU5BEpgKqSzmOn1f54aFpVvGOcdihsa48RASUfWg6nE6?=
 =?us-ascii?Q?NmAkQapNuGeZ/xmL6/ZqWICEaJqcDg5iyo90L3RTeIsWeCPO3acYxQcPPBdM?=
 =?us-ascii?Q?/8dCnbR6AA9tHzwKYX7bz4ftglopOMtmJdT4rh8mYtw6blnYbLjBducKJFtT?=
 =?us-ascii?Q?wiC9j4cl7QRT2hUI51036m9ShbKuEfLXifw7uuzxuB4a8Eu97Jc855ifADif?=
 =?us-ascii?Q?SIQ8PZg1rid1wQn8vfrbWfY1lXfrjBND8zMqQtfmQUgKofX0qOtyp5dcQ5Dp?=
 =?us-ascii?Q?svGPayyEpO46bKhFDvVnzwYZb45FxjBhfqABMC7SnQ0wl7Kqr/960bXa+TVE?=
 =?us-ascii?Q?W/AurtOxRZnRAYCNGxihf+hzAo49RCX/l1/8ha67vyQBdH8XqkSWVCeZXwA2?=
 =?us-ascii?Q?jLo1rBYgLdKZics2KqrZRHlag+4MD0dHrFS3wxjs53HUhHpZaHbcdUQvJVHK?=
 =?us-ascii?Q?NiR7Ays3qxt8QCL3ondpCxRsLAv86a56slN3x2hKrwjyE6yNIdvabXCLwap4?=
 =?us-ascii?Q?osM5oKGkFYjmDOvMhUW4Y5EUP0ptX9jl5rDPJ/Zs5qm2JbJK+cqf8AI26WiM?=
 =?us-ascii?Q?ahg26mFG+axknqv0pKdsPugq8+DW8dSygP9OAauCTzReBKufN/zKyHhiW5wZ?=
 =?us-ascii?Q?EBRBPjFTGF3pF5XhHaZgaFJsY0z8eqcuD69D94A7V//vfUjpBctk7wcjY7bZ?=
 =?us-ascii?Q?6IBKlGdBejEOrcF4VK3pb0FEcirDS1AXMf6aLB0LgYkNfbV7ug8dvex+v/wg?=
 =?us-ascii?Q?kjgUFzRR9Xk2aKYEn/7kVz0qBEooxRJY5zLhTB/NhSfvV4cQf3107d/4p/8/?=
 =?us-ascii?Q?dWnfyB2XkTJLJ2h4Ip6vN5OFySjHOpNfMD3Ul/2U2cITbIj3yLJQ39/VdqTa?=
 =?us-ascii?Q?jO1OWx3OVbL2TonPrqjDDJcbISi7osTv9GMAeOjxZYp9q96v+mPw7RUFBD9P?=
 =?us-ascii?Q?5IQHO2WgE7HIaafKLcQKWYAwMuICpnkzUXJtUnwwdgUDUIfl+CKqjGo9eH+V?=
 =?us-ascii?Q?VebkKSTyJ5gNntmoXjukRYaX/EF7LAVlWnXYc/0PWyDlCYLotpAymMDQkaNU?=
 =?us-ascii?Q?WG1wGLMaJ+U22z3yiwDlDr3DAvfmkgvKqU139L1ckmPbEZitKywAPrLfH5Bp?=
 =?us-ascii?Q?Hp8aLsjqIMsjy5KF81J9LKfL5A6wNPov/rHXiS3WeOSKpDqKM8GfniIqyF9T?=
 =?us-ascii?Q?wbQDctQBXjZ40xSMuk5zvkRqBOtomXF0zASMk6fsQKP4AsEqNPykrgsP08jf?=
 =?us-ascii?Q?eoKGVVllfOLCJqMO3rclWAzIEezhCWaa1ZpFSwornph++PZG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b624ade-b591-425d-43ba-08de62e43a1b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:22:30.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9MGCvNVxODjMU6dW0IS0D/l2ZdKup95e+RR0eUHq3vThjyxjmzu3rCOVc9mCqPvyU+OK6kXk/1JaEL9GL5pLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256130-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: DBB6ED49C5
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


