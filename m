Return-Path: <netdev+bounces-304497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5n9uMCqVR2pebgAAu9opvQ
	(envelope-from <netdev+bounces-304497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:55:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DBE7017CA
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:55:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=xMVlnUng;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304497-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304497-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDE5B3128F5D
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90DB3CA4A8;
	Fri,  3 Jul 2026 10:42:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1053C98B5;
	Fri,  3 Jul 2026 10:42:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075365; cv=fail; b=fe8pPTVVgRLBxQAeIw/oyPNZpMSaJHtlgB5GzKkol8PtduU0lRBI230QCD5lMlsSMpVkP6ifF1IxKp+iAAXpB3z9PqZLtKrEcVh9JyWEWd03YnqiImw1b1/PKs7/vpHDN7fjeN53oTpUtYbHw3YwvBRn0KujMm9y9MJcdvBp7yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075365; c=relaxed/simple;
	bh=aZmIZErC6WppxGRcOqFiwHnvBhmJAKtQwHeWtX9cUoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GDYC12aQyd39FTxdt6VpKSn0/ZopUox1Yec1qyhMNgTjfV5FPT7hEEuw4pcSOuvzFc9nbrELwzLvhxmb4YN6OyU039BBgtoGuWaPtGMYA7EJFRWMnsvVUKtBS/NWf+p6UgSfFRlRTRz7cxD/XyIA3T/ywnUHPkCGTbx/IDGc1xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xMVlnUng; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpH20wPbls6e6j1fmHdY69spdSTEzoe6h5mYqlD0qqsz7YTT2XmxBN32fGyuldO+KxO95Bcqs31LlgSF0TFKYsAkKCmhe+2anX6dndQ2CIZCsh76QStpt6ZUNfgYwJYPmvFo5jmnnQZ6NFw5MCyB2DHpeToA1c9NwiwNzjn5wiY/yxmUAlWMMjneP7rrU+lV4kywabLAEY49gLgG10jTkKUemwb7R7WhBmqm82oPOVZMtY4BFkvudFz6NjDnlBD2AcgAbw9HRUcUs0CZls1EN57dXpOyEMzT6LarVSmWOiDtLPQYQgz5+cU4WLTu0yYtC2TfKcEW0c336cmoZFZC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6P1XDl/blJqwa9oId6g7d4vomc7I6t5cFV8DvJINbs=;
 b=ZMMQTwAPeZLu5/sFeBeSBfmQgZAYrymA2wgDwY0W0zDE+zp6j8VD7yaAl0ch+O1H7yz5/5J8WP/I44yDJItCgPfo5a0NndluvZuC1OaDZp2hjNJoKK1GIqgqYeM6C6Izxec9nK1Ku4EZ4CmmCZVd8RQgQVfCrKQ+cIei3yKlnDagRJWRNpM080PZFVt2gaFT+oIh0LiDzi3vfGucbdcODVDklaUykj8xK4VgbOqZpS2LnRK/rvIXMX1rZ5mANWDpkMQ3E81eHgIqNbidx242kkdaaVBhU2CqXl4hWOvUEscrzSzMQo/7FUVzJ1Oqxfc7i8Rv+XNM2g64emJs7oeJ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6P1XDl/blJqwa9oId6g7d4vomc7I6t5cFV8DvJINbs=;
 b=xMVlnUngoFKnVz61zmAPBtOJZ3mOC/sU2x98kJ36oqWxpgXdIidDCbwgLasZJtS92auXq2UL3nTLRz0KiY9FhyFtO12yruChlBAEUatSGUX4GZZkOonT+YseKT1kDck27/kMcuKP/AknrP6q0vaj0Y4VKikYyTA24EcgyV0TafJjXcHbYbkZfGmqurdpMLMWrw7ZFS50p1NElfziq4oikgCuwnTR6JbPNfcC4kNJ72/Q6us6no6ECCSogcGyapt0RoBch+VmTOdjsIxlqooJKy4S4DeC0m+yugVFqc73vbrrMdg+Pi5ZG8gQ1e1xXSe1wCQe7cqSmtfXCS2G48Wq0g==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU4PR04MB10741.eurprd04.prod.outlook.com (2603:10a6:10:581::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:42:41 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:42:41 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 07/14] net: enetc: differentiate phylink capabilities for pseudo-MAC and standalone MAC
Date: Fri,  3 Jul 2026 18:13:21 +0800
Message-Id: <20260703101328.550714-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703101328.550714-1-wei.fang@oss.nxp.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0134.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU4PR04MB10741:EE_
X-MS-Office365-Filtering-Correlation-Id: d1dba45c-aedd-4aa3-0ab9-08ded8efcf06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|921020|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ne6FCTfnkbTuoEzP8Q/rfUHiWuQEKOEc+psohYdQYbJyHTLN3hCKUneYhQyRL2NKmtf2pMb+h1SEcHhhPj07lLORmQJAA+HN6QnTjG0y2fIO08LNmPuRK+Y1rcgmunRb9/sRpTEeJm1Be9ar3SO9jxQJqGyozkIYxchJ6ihKwaK26gGF1zd/CJTgK5JBUZZsepGs7Dvz4KKj1ckiNCofLq85zGmNe8K1JgMHt+0An31Qnzic5CYV+2KKvH9D2Dar6S/2WWAB4Y6caqfce1TW3WLUnJnAE5+kH9ZOibiKU8JHuqwrqL9MNDPsshrRogtXwR0NeY36ZefosJ0aPVNNxMB9H1n71XUF9Gg9e9YmsieKPWK4/WoaQMg+dhNcwxNEnwhc9np6T5GCR6q1hX/85YUl1iP22Guq6fyXtkso8B3WS+LL01NoKhxuernDhDZb6HzQSvW2vPROSdQpNAakSQJQ1yGHXtcRyybLSl+V+Z7Ik8MZVUuvkXVYlkgCi07+NqHfrBdPY9wwxscAUPzy5BfWLhPsURsWuM38RyW+GsXadH7xvRYbbKxRK29js6pLSD5HZrFWvkERPzfIDHz9dF2dykk6vA7Kt0i2ucDM+4m1gRt59hsTXzqJ33kBzGjdOMbQhZxKVgO1cZCYqqtI8Ow0bHaAbTEIwN7GezpNyIGzrQAd+tJHrn53VcidnzI8Ub6JGnQtVkc2nwe149B9Og==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(921020)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u+nujqXxN97XFkoAeRDKSgl+w6rJ77Zah7N7QAyADivO8iZa6hWJcnFnlofq?=
 =?us-ascii?Q?Oq6zvna6/s/xWHnjb3hoADbe+vvkzKnvW7+PyXjaqMFY+dO0vXp85ULkvg0D?=
 =?us-ascii?Q?aCC7t+qRw9LA0sYwfpSSvZDZnCqlpomEnfkWC2v/YiObfbs3KwopKw8ltUjM?=
 =?us-ascii?Q?Tlc6cG5CiXeAMEeb+u3WIermW7+mjmT6BSkNhsjaps6kLKRyJAq4VelGDB0O?=
 =?us-ascii?Q?m9tRjz5CStEfxwLHVblM7gi+mjBB3RVtl7qPEKx9cez3gxm0QKeJ9ZqJ/i80?=
 =?us-ascii?Q?ifL//2GKmTTcFCb55Wma2jJz6kDI3tBRfZuZTplFwhS6e0N1fCuhD5otCJ6x?=
 =?us-ascii?Q?Ka+qZfdrsZ2JUV3XHFlVyzjLU3DdAlttqnPUnzAm/o0G12QxUAd038bd3asg?=
 =?us-ascii?Q?yrCt69Kla111h0Gm3nCtCCJUxGoWc8oa0bBi+CSzuX10YHeCqMq8E5Iv6Gzh?=
 =?us-ascii?Q?6/kN30GVto+wxN+NNdMjx0q3AUkhNPNDbEkAZ50Lpj+snbsJU1EYvTyekLqk?=
 =?us-ascii?Q?XklZ2YGaLLqkd4Cf8Ru/LnAhVYXb3rdvQmOD/Lue3/8ZvcD3p0IRSbctCzKM?=
 =?us-ascii?Q?aM13/q9fFHjw6a/qASw6RcxqL78VT1FgYOrG+BK2Zxb0kmqmEgqWO+bPi5c1?=
 =?us-ascii?Q?utkmYOlwX5vXznv7SUDzv96BlOWT7OI2LXMpn1MFQlB8QutP5OfqIzCWWS0O?=
 =?us-ascii?Q?yfq6KiYBLjkTs6kYmFP0F6mGNP6E7SC9jPonlLqtiECNzUriEN9mgC9N2K89?=
 =?us-ascii?Q?rXFXaTmXGs7Oula8Nck/h8qNlXstCwAc+PRPRzrXellGC7AZX/NwvRmGbQ62?=
 =?us-ascii?Q?2T0AUE0aCxBlg9jxZxq458zqx7rUcbXWux6aE16kjFOLXrRK5Jxs8BiN07wI?=
 =?us-ascii?Q?nasXfO/hvGWt3ia1nprkRUi/nBDoM9vo8E3AAuWLb1SSOs0nR7klpdREE69l?=
 =?us-ascii?Q?5Gfc4z0DOCQKvdt8g6wFPzLOf9qTV4TW99mTsWRa9rTY0Y++umomYWCMpWtM?=
 =?us-ascii?Q?oddzixQTDRHMCbXhH8rODatja3dMzSSniqFbMre2Vl3I+0G4DzQEZEBg6bwd?=
 =?us-ascii?Q?r3DY+2Yh/S0djWJpHTTyYdxlnSzrPRz5OvfpeVsTprGzXNBGMdGNM82rj/25?=
 =?us-ascii?Q?2eVvVyD96CM/dkt+2p4EOGOgbR6oL59kIyUuRDnk08RzHTWX0wP02Oz3V9Ht?=
 =?us-ascii?Q?nob6xGcFxv4b1oC5EWBvQfl3YvVXwLnAa8ymiplfo0whpH4byTHgt8IhXDBQ?=
 =?us-ascii?Q?I3tqiPetfaVYwmEo3VDJfTKcEED/6UU68Td7VrDEZ/ExvvtHLVN4IPbpHh3X?=
 =?us-ascii?Q?VSg+UpvGuIetkZj542iDItv7Jq0N852hJ+djox+F0PC1452UMzIJeSCRcUyj?=
 =?us-ascii?Q?QE60P9DTALHdBnqnxwN820DZEz72MDlaXQxCmJs2NN8wUWZDjIlKxA3EbHrN?=
 =?us-ascii?Q?SfLvXS4LVdM4AzTPfiGkPUVDlaglHVhK8Bv7/bTBwn7Sy3LktPcp7oYSZK2N?=
 =?us-ascii?Q?tu2KqEdryWMgp2cfRZ4gSVtweAd9su8EnrZByMPzie1GazOAiP0k3NA/Dmxj?=
 =?us-ascii?Q?PVykTLloOs2O4oqpl185rhV2/UlGd28VRVj2J4cSZdlJTjpHybN6RRag4N+J?=
 =?us-ascii?Q?HKU1OhQ84exuAADDW8HSiZM4XiMXUpwNeU4xBpQx/Xt42/vK22JH8odJkfe+?=
 =?us-ascii?Q?sSNsszS3QIr/sS/5D64e6Sy0FjL2relzYa1N2pahi8hOMyHKbGLHY/ZkU4mp?=
 =?us-ascii?Q?ckmwrlmO/L7Kn3/BooiIbOwEYTkhnTQ14DAkfW2RgjDlnYKPkvMv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dba45c-aedd-4aa3-0ab9-08ded8efcf06
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:42:41.6622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7e/bj1QQBHH+A751gPUi897uXxgiLVo7AxsDHAd5sXK/ondgmm7vkklw9H9JfLYpeCY8E//HKKtFV0cSOV7K9Zz+WJ/sKUZ1EZ25PBeyBlMW2S16eAmrlRVoWRM5YHz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10741
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304497-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:maxime.chevallier@bootlin.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38DBE7017CA

From: Claudiu Manoil <claudiu.manoil@nxp.com>

The ENETC pseudo-MACs are proprietary internal links that do not
implement any standard MII interface, so restrict their supported PHY
interface modes to PHY_INTERFACE_MODE_INTERNAL only.

Since pseudo-MACs can operate at any speed between 10Mbps and 25Gbps
in multiples of 10Mbps, set their MAC capabilities to cover the full
range of standard full-duplex speeds: 10/100/1000/2500/5000/10000/
20000/25000 Mbps.

For standalone ENETC (v4), expand the supported interface modes to
include 10GBASER in addition to the existing RGMII, SGMII, 1000BASEX,
2500BASEX and USXGMII modes, with MAC capabilities up to 10G. MAC_1000
is replaced with MAC_1000FD to explicitly exclude 1000M half-duplex,
which is not supported.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  1 -
 .../freescale/enetc/enetc_pf_common.c         | 44 +++++++++++++------
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 06a9f1ee0970..8839cfb49bcf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2017-2019 NXP */
+/* Copyright 2017-2019, 2025-2026 NXP */
 
 #include <linux/timer.h>
 #include <linux/pci.h>
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index f24269a48c26..75ee117e9b1d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -602,7 +602,6 @@ static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
 		val |= IFMODE_SGMII;
 		break;
 	case PHY_INTERFACE_MODE_10GBASER:
-	case PHY_INTERFACE_MODE_XGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
 		val |= IFMODE_XGMII;
 		break;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 3597cb81a7cc..781b22198ca8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2024 NXP */
+/* Copyright 2024-2026 NXP */
 
 #include <linux/fsl/enetc_mdio.h>
 #include <linux/of_mdio.h>
@@ -359,7 +359,8 @@ static bool enetc_port_has_pcs(struct enetc_pf *pf)
 	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
 		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
 		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
-		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
+		pf->if_mode == PHY_INTERFACE_MODE_USXGMII ||
+		pf->if_mode == PHY_INTERFACE_MODE_10GBASER);
 }
 
 int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
@@ -400,25 +401,42 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 {
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct phylink *phylink;
+	unsigned long mac_caps;
 	int err;
 
 	pf->phylink_config.dev = &priv->ndev->dev;
 	pf->phylink_config.type = PHYLINK_NETDEV;
-	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
 
 	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_SGMII,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_USXGMII,
-		  pf->phylink_config.supported_interfaces);
-	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
 
+	mac_caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
+	if (!enetc_is_pseudo_mac(priv->si)) {
+		mac_caps |= MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD;
+
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_USXGMII,
+			  pf->phylink_config.supported_interfaces);
+
+		if (!is_enetc_rev1(priv->si)) {
+			mac_caps |= MAC_5000FD | MAC_10000FD;
+			__set_bit(PHY_INTERFACE_MODE_10GBASER,
+				  pf->phylink_config.supported_interfaces);
+		}
+
+		phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
+	} else {
+		mac_caps |= MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD |
+			    MAC_5000FD | MAC_10000FD | MAC_20000FD |
+			    MAC_25000FD;
+	}
+
+	pf->phylink_config.mac_capabilities = mac_caps;
 	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
 				 pf->if_mode, ops);
 	if (IS_ERR(phylink)) {
-- 
2.34.1


