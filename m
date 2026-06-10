Return-Path: <netdev+bounces-297568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Div+JmcyKWrrSAMAu9opvQ
	(envelope-from <netdev+bounces-297568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:46:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F01667F7E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:46:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=vO8kxxSl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297568-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297568-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20A7A30320B2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BFF3E2750;
	Wed, 10 Jun 2026 09:46:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A093E314A;
	Wed, 10 Jun 2026 09:46:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084768; cv=fail; b=mmYU7EO5sd/eZxUSdEdlKnc4R4+AC7AXgptSfRa3ifzmn0IsfAwelHDudZb59nmI4zL+sGZ23THHggHOu1UVhlWWbKMdOisfpq9JaDZsBeFhsCNsxefwxB7GjZnxlYBFowD8KWBgp82rp70UcgGJ6huUdLzj7jxaLTgxRfQV3Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084768; c=relaxed/simple;
	bh=8/QlATumDZX5v9KWolhN16wLU1v90ZEJ5bux4gIcexA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ObZTegBwrzxG4yN3hmge2Zs3kIWgoIXoPhx7GRgteWVAGzGzHyhmdE6KFgpLWryIC/0gqEKZyADVcADZM1Xifobh0FdsU5buvOKQuI0aHP2zP6ceVk++N9U4Q5nRP0F9FMw8WimWznLnBGBDYwmNqJfDEVtXDMmfhGz9L621z5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vO8kxxSl; arc=fail smtp.client-ip=52.101.84.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNpdvE7rKVjH1S8t3AWbZQ91JJo2sKVyRsxSPcj6brwtfKngqFcHyjgdtoaW6oHJNcS7RCSs6us/rHIPBX5cnKA2QwkNF/l/zQ/ct2kD2VYhh0lVZ77Zy8WlIbOsgKqzh+HnMmyupyqVH1ChI9aKpA4YR5nIZz2MgdgrYCyWXRTSERMTw+yVtfGs4wQR+dn1PQhfl1zxJ09wZfVH+aHlIWfxLFykCL9lvmNlMWq4jUTNnKRMGE/vaw3hylnfE4l6yCCbwWSRuJ2+JFTyhZgyZZGkz2NrAGKXOuRG7hl51Hpospxx+uPbTa/IB4/jTDk/Wwl289LgVs2sUJQNpd/Qhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/26+04Y3ceHz2yQZs1jZWZZCW8xMfbjQWcn+r7iNsX0=;
 b=GVCODwGKf1RnI2U1uQFd7oLqE3JQ2r444T02Ou2AQvtj1LgtZ9tH70gp+IIIrZc5jgnrAJlyxP/Mt1JnThG96nOlnPkLsKhDs4Jxr++OBtY9VobvtXBF4jPsiS2doAwgrvUb0TG1Q+iHkz8tlhvPA7MHZEiqpXcWlHvTZ+FE05Udc/BF8iKaUCFFiNshTsaVYm0yKMtbb+fWBIxPyZGGwFIacerN0n0jIDv5+YDRzFF+aP3bxe7ptk2p4AiskZBmcVLsdoQQB0Z5zajPndQH8nMc7uCfzrxVJ/v8QrahSH+P/oG2OTC9IZhwxIc9DZJ75a2NfTsmlYg61oP2kzQ5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/26+04Y3ceHz2yQZs1jZWZZCW8xMfbjQWcn+r7iNsX0=;
 b=vO8kxxSlV//yrin7M+mWar71qc7udtafuIoZdbwH5d3qkRrikAY/LhX4DqRnRlZpJfxArg9gBeSNxa+KP+n46gMJP9kLZAoVpAN+/5YADIuEv/nlNNtVHbzHkyQrG4gMKrsPU91yh6ME3/qMN1TPH3CJB586tWaY/TGvYd6Q2U4HxQ5vPIFZwREnOkRBPjzG7LdSIo+nZrcMqRcnVpwHp/DXTxpzbuCZrUxJ6dEY6ZKtuz1hoHaFInfv44EBd86hin3mDq8ebhaUctLssVA+oQm2f8iTlm3DiMmwLKfPZIKNuNhVNddgXfpwyuX+HYJxyroIvW29rYCt+XR4st626w==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:46:03 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:46:03 +0000
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
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 01/15] net: enetc: add trusted VF support
Date: Wed, 10 Jun 2026 17:18:30 +0800
Message-Id: <20260610091844.3423693-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
References: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::13) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1f3ffd-17c5-449a-6e45-08dec6d5160c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|921020|18002099003|3023799007|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	3zy1beXrEf6myhYsOkLRC2M5XiHyxtr4GzY48SDAcQjsGfNLMVRps9s1GgzddPmLjLQO2MtZfgbM0zjmZLRRH+WBCu/ax8MyMB4stkbiF8UU6E319Gf/kt3tticJuH0WUJGOH/SWXCzEG7x2FzdLcLlnrWEdatEU8WVsuZiA/6bOH0wwoqeR2PQaQLWZmLj1Ncbhzaqqy+OlHYevq4zYN12Y4I/kVtFGqTTyMBrHL+Q4tYx/cHIllEX6hr8F+qftRu+NaPhNTeBkB3tXd4rslL+JC1QKjByYD+Pd4sxv4LoYVUJ76WwgKZDtt0oJd4aoOILLdFoSCPa2aJ9ndpPyOmQOW5jmb01yLkqWtaCwwJDbiEyE+AWlk2/u4j+Lfs3/HXYMeDm5N/ylh5t9iBFVfYQ0xSgTPCkMYhLYbBtCBimxJ8cuuMQbf4L505B0pmorJYKnMQKPuMyPqJXZUhYJIfQB5YzLSVFibYG7+t4cnEH7YjEo/57ev2AaQQTOEwKeVYXACGy4UCcIbVfiYIBg5Mmr8nwrGYdFfFUNiWnHSLG2u0Xn/riM/t6c+J5K+45huL3pTMghSJ5NxYsjdj+2sR9pTkUq0rGJq9oZFjygUJwIp8vvy9o6XjAIfUE/V5IlU+qT9ErlJ4fRw/6luUD4s2scYua9S2ohmhW4wRvGtn5MJw6vcWO9eyl4uiRnR28/BTHFq17SZadYiWwcWxlFd/oMbW1ULDlEshxJXc4rdjY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(921020)(18002099003)(3023799007)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UqH8KiDQtHfplvMIj+V9ZZzb9sG5a8j9S7UYjSYZLTPgHKQbaEjXED5e/G1p?=
 =?us-ascii?Q?Xj9PSzwnG8OyJjUTYZFbbgJhvDvieFQSYk14MSctUfm4dfBcr5HG/GYkb92d?=
 =?us-ascii?Q?jaCwqBsigSIJrqmxZXSXG2NFlFrXoMOeFj5TNu8ItKPlL8KLPA7BOIVJwDDc?=
 =?us-ascii?Q?fOlY3w8q7JFxfayOO390nN/j9PJKZLTPdYcczy0SNuQh81o3aFgwYPRufArh?=
 =?us-ascii?Q?dv9SePybotNbqtH9m+JVWVCwNSMmL1DT52/QArN/D4Xk4DYMlP6zQRF7pf5r?=
 =?us-ascii?Q?5HthuOBmmXJIqQygA1uLQ23M750lUVZJZBLOGyDwEcCgkJRdd28Cdc4sRKae?=
 =?us-ascii?Q?tnXQfu7tMXReQ7Sv3wV7Wyqbc6lvJGAaav0Z83aVVeyjLfC2Drv/PNUy/bUR?=
 =?us-ascii?Q?QsZa587LySuld9SS835fYA/MqZp+1Q9ZVD8XttdVAKG8HUxjxpAJYNIn5Gze?=
 =?us-ascii?Q?jUic4Sc/Vu8L3VcPzTeG9cm2TYZ0YlCjwigLSh3gxSPzx4NX7/H0d87Ifdjt?=
 =?us-ascii?Q?HrSCleGsLAmIa5baNJ1uAUGWL440eXjm1gklI5Q8u/qHcZlwy+ZmaK324rdF?=
 =?us-ascii?Q?1mapjIIQBVEQqRetH+2yk5y4r3aEjo9bHoK+Tes2AWv/qyQp3X4jz07AzWF1?=
 =?us-ascii?Q?Gr8TUWuOrqMbnBjnCk2+UzucDa1Mj/Trnf1D6bO+bQkOyzyXkOK75hraakd4?=
 =?us-ascii?Q?yfNOX6e/t2NgF+jGsOemI8S8+BvWuEOpLALFe/la/GJSuq1mgIyVLQkR4epQ?=
 =?us-ascii?Q?qQBxQxmVikaz5zsZi0rP+Jqz4AaMdx/j44hr2s7/tJj6ANJ5qpFqNzhuYCmf?=
 =?us-ascii?Q?Kl/mXb1I2g/Bw+r5w07x0FclyUwGH+dKL0MDk6jQQGEe9Hp7uyS/kQN9yKV0?=
 =?us-ascii?Q?d1VG++5dKHSUnZK1YihCls7wWnP+UlH8iWPQHihQi5tA6dQz52Kb4/sFBCMo?=
 =?us-ascii?Q?F4BNnTBzLazHo+t14phutbcTziharX2t/SwiS/tnQpR50FTepvjF+++v4LQo?=
 =?us-ascii?Q?+5Mbte4W/AJk6w6uIxh9o+5yvkxcsg9QX7JTD3v4MF0NTx36nn/kD1IHED6c?=
 =?us-ascii?Q?PMP8plw533C73bywrDqYHHMIMKPNlfZqtSUvWMmb9hdOGd4+PGIs5wx78m7z?=
 =?us-ascii?Q?WfFIDvcEh8SfnX67PyXukXzYisSKskXZ/LtCjnY5hAiSamS8nZQny7v7fcaU?=
 =?us-ascii?Q?nRxUhVZe+dnpsDaALzWMmzrlE7EEyA8KTMybrUhRJzB0tLKH6ZiFnbZF4Y+k?=
 =?us-ascii?Q?7koXzOBGd3dgbJNXWk31qYxR1nCy6wc+MCKiaf7R1CNCpzQwKjGiYAEwj8PN?=
 =?us-ascii?Q?8hmddEl+oclsHtFD5IKWCMNULogEVUAk0qonb8RHCcnfghSWoCYgoaCtxQKN?=
 =?us-ascii?Q?wd3SV5vhYLKeHkfPuVkYwicpwyCHtEZtasNztfECu7Bw917lONRI0GeeOJYM?=
 =?us-ascii?Q?JxelDkyeGrRqdtNtw8aI/uYpFwNUZgTvl8+1aVfaL40B36H54HAqSXozWmSw?=
 =?us-ascii?Q?hohEg7wL8kZLrUu80ecKcc0nokjz/KSPTfe/ggQSzLX4/NgwIvlyCVAW4MFh?=
 =?us-ascii?Q?1Pi76AfSQ5unCTvr3jYhkgVTsCKE8p2nRT6BJRpIBCR2NGLVw+q/P7srhYT4?=
 =?us-ascii?Q?vWJWhMfAqXOmFyqkrlN41/kFc4KIpVIe8xamTI2eHjX7Ds+E9PlTHDZ5gVpX?=
 =?us-ascii?Q?iIbgCEWwhf0RyUTGhFDhebSkAfwtwhQ92bXgzvdCSa2KoxreihcOXc75Czyj?=
 =?us-ascii?Q?XP9o73ow79wCQnvTG7mradZ7B9VlUVakyhElWvDUw3u4AF5Dphh0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1f3ffd-17c5-449a-6e45-08dec6d5160c
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:46:03.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LhyAlDsUyJQjg7V/HSiz01o+PgomcQtC3M02RFl/EAtAj50kaPEEKTVUmdxj3VkFrJLWdgfSKFS/ZmPEWZeF4RxutSeCCb3/Yj93G01q8SgKYykIOg/03LG70W5sR0p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297568-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39F01667F7E

From: Claudiu Manoil <claudiu.manoil@nxp.com>

Some mailbox messages require a higher privilege level to be executed
on behalf of the requesting VF. Introduce a trusted VF flag
(ENETC_VF_FLAG_TRUSTED) and wire up the ndo_set_vf_trust callback via
enetc_pf_set_vf_trust(), which is shared between the enetc and enetc4
PF drivers.

The first message gated on trust is the VF primary MAC address change.
An untrusted VF that attempts to set its own MAC address will receive a
ENETC_MSG_CLASS_ID_PERMISSION_DENY response and the hardware will not
be programmed. To prevent a malicious VM from setting the VF address to
the MAC address of other VFs or PF, thereby eavesdropping on the traffic
of other SIs. Furthermore, a malicious VM that arbitrarily changes the
VF's MAC address can achieve MAC address spoofing and bypass security
policies.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  7 +++-
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 38 ++++++++++++++-----
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  1 +
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 +
 .../freescale/enetc/enetc_pf_common.c         | 23 +++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 6 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 4e771f852358..f7c532758e1c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -277,11 +277,15 @@ static const struct enetc_pf_ops enetc4_pf_ops = {
 static int enetc4_pf_struct_init(struct enetc_si *si)
 {
 	struct enetc_pf *pf = enetc_si_priv(si);
+	int err;
 
 	pf->si = si;
-	pf->total_vfs = pci_sriov_get_totalvfs(si->pdev);
 	pf->ops = &enetc4_pf_ops;
 
+	err = enetc_init_sriov_resources(pf);
+	if (err)
+		return err;
+
 	enetc4_get_port_caps(pf);
 	enetc4_get_psi_hw_features(si);
 
@@ -570,6 +574,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_eth_ioctl		= enetc_ioctl,
 	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
+	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index edc1277bb586..78114ab3e482 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -7,6 +7,8 @@
 					   ENETC_MSG_CLASS_ID_CMD_SUCCESS)
 #define ENETC_PF_MSG_NOTSUPP	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
 					   ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT)
+#define ENETC_PF_MSG_PERM_DENY	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
+					   ENETC_MSG_CLASS_ID_PERMISSION_DENY)
 
 static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
 {
@@ -61,31 +63,49 @@ static u16 enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
 	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
 	struct enetc_msg_mac_exact_filter *msg = vf_msg;
 	struct device *dev = &pf->si->pdev->dev;
+	u16 pf_msg = ENETC_PF_MSG_SUCCESS;
 	char *addr = msg->mac[0].addr;
 
+	mutex_lock(&vf_state->lock);
+
+	/* Untrusted VFs cannot set their MAC addresses by the mailbox
+	 * messages.
+	 */
+	if (!(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
+		pf_msg = ENETC_PF_MSG_PERM_DENY;
+		goto vf_state_unlock;
+	}
+
 	if (!is_valid_ether_addr(addr)) {
 		dev_err_ratelimited(dev, "VF%d attempted to set invalid MAC\n",
 				    vf_id);
-		return (FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
-				   ENETC_MSG_CLASS_ID_MAC_FILTER) |
-			FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
-				   ENETC_MF_CLASS_CODE_INVALID_MAC));
+		pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				    ENETC_MSG_CLASS_ID_MAC_FILTER) |
+			 FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
+				    ENETC_MF_CLASS_CODE_INVALID_MAC);
+		goto vf_state_unlock;
 	}
 
-	mutex_lock(&vf_state->lock);
+	/* PF has higher privileges. If PF has already modified the MAC
+	 * address for VF through .ndo_set_vf_mac() interface, VF is not
+	 * allowed to set its MAC address via mailbox messages, even if
+	 * it is trusted.
+	 */
 	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
-		mutex_unlock(&vf_state->lock);
 		dev_err_ratelimited(dev,
 				    "VF%d attempted to override PF set MAC\n",
 				    vf_id);
-		return FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
-				  ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED);
+		pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				    ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED);
+		goto vf_state_unlock;
 	}
 
 	enetc_set_si_hw_addr(pf, vf_id + 1, addr);
+
+vf_state_unlock:
 	mutex_unlock(&vf_state->lock);
 
-	return ENETC_PF_MSG_SUCCESS;
+	return pf_msg;
 }
 
 static u16 enetc_msg_handle_mac_filter(struct enetc_pf *pf, int vf_id,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 2d687bb8c3a0..8957e74314d1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -540,6 +540,7 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_set_rx_mode	= enetc_pf_set_rx_mode,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
+	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
 	.ndo_set_vf_mac		= enetc_pf_set_vf_mac,
 	.ndo_set_vf_vlan	= enetc_pf_set_vf_vlan,
 	.ndo_set_vf_spoofchk	= enetc_pf_set_vf_spoofchk,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 285b7e5c48fd..eb977da2be71 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -9,6 +9,7 @@
 
 enum enetc_vf_flags {
 	ENETC_VF_FLAG_PF_SET_MAC	= BIT(0),
+	ENETC_VF_FLAG_TRUSTED		= BIT(1),
 };
 
 struct enetc_vf_state {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 6e5d2f869915..44c546b77d3f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -462,5 +462,28 @@ int enetc_init_sriov_resources(struct enetc_pf *pf)
 }
 EXPORT_SYMBOL_GPL(enetc_init_sriov_resources);
 
+int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
+
+	if (vf >= pf->total_vfs)
+		return -EINVAL;
+
+	vf_state = &pf->vf_state[vf];
+	mutex_lock(&vf_state->lock);
+
+	if (setting)
+		vf_state->flags |= ENETC_VF_FLAG_TRUSTED;
+	else
+		vf_state->flags &= ~ENETC_VF_FLAG_TRUSTED;
+
+	mutex_unlock(&vf_state->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_pf_set_vf_trust);
+
 MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 57d2e0ebd2b0..5bf7c20aba42 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -17,6 +17,7 @@ void enetc_set_default_rss_key(struct enetc_pf *pf);
 int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
+int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


