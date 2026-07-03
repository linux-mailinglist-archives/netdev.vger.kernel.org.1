Return-Path: <netdev+bounces-304499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SAaHBkmVR2pkbgAAu9opvQ
	(envelope-from <netdev+bounces-304499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:56:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 839507017E0
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:56:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=aqUkeUAH;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304499-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304499-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A843F3025C3A
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841F23DD870;
	Fri,  3 Jul 2026 10:42:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010050.outbound.protection.outlook.com [52.101.84.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DFC3CAA2F;
	Fri,  3 Jul 2026 10:42:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075379; cv=fail; b=HN88mJGtrZxgCDCVr6XxRlN2EB+1Jts5Y6gENdOgmrLZjEezwbXOPnG+5ite88usLG4zFijtWw/J3oBpl2dl1obbBTmmRxpAAvkcNbXT9j98bukjpXSp1IpDT2gSBpxwgRZ9bQSYTPpckCr/g1MYbJ6p8NeWHQNowkjTBCnZc0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075379; c=relaxed/simple;
	bh=XKD6xvrfVu8mH4lBD+ZuWbD8Fbd1xu9EJHwDhOceSgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O2PN562y0q1LpxcU16MjZ1mEs07zjY3ooR+/SSKOA2hwjgtJ0v3/24gBvUwSDbmCSVN+Tlr28dHUSm9QwVI5mZDfdEbJPZAzTuQioQLCVCD2h2G4cvb2zrIGPNaoGnSgXOQoQ2J+9Pg+jgfdv8pdDb08fUjhgCtuZ62JagJPYnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aqUkeUAH; arc=fail smtp.client-ip=52.101.84.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iy+N4IQYKWcmKE/vBgBga2j+m1j7iKAJQQiLWkzNq3oPTWhtddeBpGm/ooTwOpb9mu3w0bAVx82CO1aUr7xljApOWSKaSLu8sRDdgrzBcYSIPc50IHME/fiY8cKrpQvZ6bV81d/MtFXoH1UX6fzfERtAdeR9GzXAV4YTRK//B4K+TIbkgLCGOvKT5flmDcNjKnRsvOZIHq1kVfrZvkz0q0NPUi5AiPbQRhFHm2lNhOj/dpVWvTxlYXszZTbMdGMReaia1QjskU1nTorMzt3E3K7FNIum9MT8+xlUKnmMbqxZ+g9lGNTQRFkLhgc+dhFqBtGlxSmCWLfhppLu3z4ZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmvpWVF47jUc8h9psj97e6zsVGtTYxdvQZtCviyJaDU=;
 b=a3Rt2tPaPKD9fqdc+p9+8V6msf6PNHWnTaWMZj9+TxepMwBxBsYuXj8y00s5rT+lvV5kfHo/0C6Y4HG2NPNgYg7XJ6rh0Vt6a/7scX6iq3S+Q6U3YWoyIfQji+IZMewG9VuPOwyWGd3nkwtWh8RBE9o+rpil6dSCAY488Kf33O5GoXw6otGnOHll1n8WOpKkyqcO+b6/gc2d78X19/BcsJAs3HjdO0G8RFe67WfU9emMM9L59LtYVJS3KajITu6uhKNhm5YfsFfEUJNqQEdaxJKwZkrGUSwaXZKDK0n5O49MxBd61WFG+2liZD0zOa8f4+zM963FUGvH4Cyf6E9Ltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmvpWVF47jUc8h9psj97e6zsVGtTYxdvQZtCviyJaDU=;
 b=aqUkeUAHmVg8SBKBmvj1WpFjylGev2EG6SR0LGvIanzAJBUYV9TcqlGIOE5d6PDQMAhkyDC4ftB3NJzlinEBoOezSp+qNk/oTJCIdoS6ySO8UDCLYch0QPiQh63tIOotyzF6yuwgL1+K9oM7IgQ9tRGUU4ZskUVW05Noxt1oTrHhpMSmhtboRnzp3G1b0XmlsGH6sYUd1uz0LlFIMciY0NCpL+6Vk+DsU34i2HW0cbTNOoPWd+3eMgS2A/NNH/LT52yiQ0LoBA8oJ0BlsXEBMjDU7R8eAAX9Mkd2FWAO5dzWn+yJLawQZwhYxBKsxll4YaHjYWZjtEXdcKM6Etuulw==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PA1PR04MB10867.eurprd04.prod.outlook.com (2603:10a6:102:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:42:55 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:42:55 +0000
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
Subject: [PATCH v3 net-next 09/14] net: enetc: open-code enetc4_set_default_si_vlan_promisc()
Date: Fri,  3 Jul 2026 18:13:23 +0800
Message-Id: <20260703101328.550714-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703101328.550714-1-wei.fang@oss.nxp.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0032.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PA1PR04MB10867:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f22a2ed-97b4-4b99-8edb-08ded8efd71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	akOF0BoagN21IqBWipPn98dTsua2H1hlHseUMfrgAERbJTy6KX0PTSZqPn2f/6v/fdtm5w6BN2D0AoNKXwfKLHrkSc/YTHdQcDk4pISbiMfhPLm3awrV1x+iXgl96G92C8DA9kH1VqNt1RC7petHB44APvo53nWU6t9nF9z8B/YN1c0J0UScN97Fb3sxZcM+zoY7SVsGgNAIUMGoKh0fa9xUfKJrg+1kC4Do4IQ5MFzpc4TefXgIQy/sDPw+V1F7RC9RNzOg+Ut0TfjQw0CRvH1pmL9zaKPgv70OcpXiC2I0r7Sz4LwNxCw4M8d06vBe0N28/DDvufuBP3ZyS9ojLQAQDSxT3kdt2ZKEAYBzT5xIh+YGkANUHpkCMhIspfAAS8UHAusKLG/738YyKS4YFd3lM6+OjGPDi3LXG/vQxr6+rx+eh9V5344JJDy978Wbi/PK37QDww+O1vBAkwOqUaE7Rz5Wch2QcY+6S6v12q1EoUYnxZw8OYDqzxlUIqzy4kJVqldaQmb1eE7HCOUaAvskmRXmKRku2+RVDlHNrlPWToTgZcxQ1H4EglpUBaBUXWWQkkLey/j2pJRqjNuqUmcBSHeMtmGqFdnMyVy7u0NC+y47HMPIMCinOzqL9YrjQhy1qkXjsuTkKlmeQQTdJ/OcjMZ4UQO5qjtDKZLWxbtlNJ818hMlp1INQxKKDZ9VG7QFRL9N6yzvyKhsGkI8KQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(921020)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ZvngwWcYQ04UXA3tUhVgaCgMCIAZpFEPKdtQcqP+XD87Wm4CXkBtN/9O8ge?=
 =?us-ascii?Q?KYJYmcOdS9eMDnSYnsLP6POQcYE8ziRON2OWRbYXLWKnJ25+WUmz7bK1CcCt?=
 =?us-ascii?Q?FL1wlVVgm7dLx0hVACvv4UaWHJkM4YBOe2gYCzyKLmc7v0208SUnXEXTsndv?=
 =?us-ascii?Q?JJEljlEsQLwB7443Nyf0Hv7UomLB599uCxWAYM1Y6q2exgXgTrlKr9ihMYb6?=
 =?us-ascii?Q?STCp6xR2MKgHvC0RpGmEH1Cyf8LMzn2mWpw4kGIYHbK+yUoditAWJL3uc16P?=
 =?us-ascii?Q?kqr3AoXdaZWul1zI2BtwjBQQJc+1NSNtvEpoNa0fn43sBG1nTuQTrD3Jl5cR?=
 =?us-ascii?Q?XbTwIB1xGpDyEwjK/eyE/bblLKrMwNaSTEflfqgf9zuYDYult+3qIBRMUkZ7?=
 =?us-ascii?Q?+4uC2uTNdY9loCOlXN/+NtD2JL9f+UoUeZyMblbHlfbF2zmI4/ouktNQCXn5?=
 =?us-ascii?Q?SjbyxbAINcAvuGj6BAGhvb6IBRl+f+JUi44MfBV9+XJ4mW121CPjFqggG//z?=
 =?us-ascii?Q?EKjJUMij/7gxHtyro/4bt0Yy2cOZDyEYLYoyLJRNSQIB54PchDwUJpSzO+Pr?=
 =?us-ascii?Q?WN2ywb3QZDiedMttL711hBrJaorIyVPLmAVcYg/idTkoZwRr/2EAQMGbEbMg?=
 =?us-ascii?Q?NMpG/TbqaV3Rl3a7uqwiwbwe9ZIYnmUhSTDDqc1jwsS3nenPrSwTeGc1UkdB?=
 =?us-ascii?Q?QLpqfVKVuUUrdD+OVlZS0qE1a5ffQxNcLt8srLvMHYdBYoczZHJnjGVSOnUs?=
 =?us-ascii?Q?UsbcswPrcSWKQMKbRiE4yWFmSBZC3fq3z8JxUKaU1rVlXQOg+xvDM772axEE?=
 =?us-ascii?Q?kcmwYgLtTt32tS9uCbPMLuwRsEFZgxx0GxFXmqGCpdTeu2JIw5PB7V12F2UV?=
 =?us-ascii?Q?pgmjzd4vuKTo8NNUNS0I9AKoomr8SnbOzVT79UE2s22u/347Gt1JNVIRDCcD?=
 =?us-ascii?Q?A5PwCWtrCGxSCtn33p2yAitEH+LjdW7cKCz0Y9uRheVQ2mPNUvruEDJKgjk0?=
 =?us-ascii?Q?WxUrqZk8IxEKNYnREDSv+4VedPHKj4PiPpP6KsJlppoUxUwaRtXV8W9UDL6f?=
 =?us-ascii?Q?G9N8UH2lXjLIU0mlS1Fhy1pj+LrEeQK7quBJBzOPS3hZ68SdLjTOu0uOEkfI?=
 =?us-ascii?Q?1XrvfkVPeD0TnZOB1iFLYRx2DjUv/f98biA8itQklt1rQ1lC7z1lFTj1yHsv?=
 =?us-ascii?Q?m+2tgZPu6KKsj6+VNlCQoBc5U16NW5csWxWXvC4Su6sTq1ommVKHRB777fqT?=
 =?us-ascii?Q?BjeHZQwsbVVcqvBi6Itp4hShLsik2TeYoZhnoOFgTGp3wMelsPhSwgehJnhi?=
 =?us-ascii?Q?DYkcdFM4a1fqzI989xf4Qu7M2/lS/48oqfe/4nKrar2fVsucubS5q1xlkLKU?=
 =?us-ascii?Q?NJ/CniQEDa1kaKOfs/x1jxi6Zx/3dzmwjWOf813a0P78VlKa6/uIcxs1QOYv?=
 =?us-ascii?Q?DDSXLwqahc8RxkcziQagQqz6yrA1HWcTxJfuvnikuX9Y8LIJf+9fGTnD0pGJ?=
 =?us-ascii?Q?eAolJVOKDj10HGL788TcqEx+wfalovkbe2NtN0pn0Jn2csyysKAtfYbIfzbh?=
 =?us-ascii?Q?Y9aCy91pB9REBjEM8Tj/kitt3UdarWiQkOVwANXv1R9EqnFmTmuzSB1pW7RR?=
 =?us-ascii?Q?FRBIHzAaFB2Ub34ZbrumVI34wB6yOFzS2Erum6dzdyOqIauspC2/kU/zLZhI?=
 =?us-ascii?Q?98nbF8TqZD8VfpFIOca4Eby2KW7NFcm0rB//qSHb0o5n9qtadCJEBN+/YKk9?=
 =?us-ascii?Q?++C8Ma9sJxwCmvM+xb5pjxaSNQM0p5tF7vp19S0ZUggd4GflHnaL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f22a2ed-97b4-4b99-8edb-08ded8efd71b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:42:55.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kz+dnz9rN7jzeCYJGFRAyh/SeKD017k0CX++/DMpPwjYA2rX/F3oqbbvjP+lWyhR80TPAYJCuON+B7YiYcqMYFUMlNquAJypO1tcGoqsv2MNQM5PXhdWGyGgJuDcuDoU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10867
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304499-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 839507017E0

From: Wei Fang <wei.fang@nxp.com>

The function enetc4_set_default_si_vlan_promisc() is only called once,
from enetc4_configure_port_si(). Open-code the loop at the call site
and remove the single-use wrapper.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 859b02f5170a..505e4abf6c37 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -307,17 +307,6 @@ static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
 	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
 }
 
-static void enetc4_set_default_si_vlan_promisc(struct enetc_pf *pf)
-{
-	struct enetc_hw *hw = &pf->si->hw;
-	int num_si = pf->caps.num_vsi + 1;
-	int i;
-
-	/* enforce VLAN promiscuous mode for all SIs */
-	for (i = 0; i < num_si; i++)
-		enetc4_pf_set_si_vlan_promisc(hw, i, true);
-}
-
 /* Allocate the number of MSI-X vectors for per SI. */
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
@@ -361,7 +350,9 @@ static void enetc4_configure_port_si(struct enetc_pf *pf)
 	/* Outer VLAN tag will be used for VLAN filtering */
 	enetc_port_wr(hw, ENETC4_PSIVLANFMR, PSIVLANFMR_VS);
 
-	enetc4_set_default_si_vlan_promisc(pf);
+	/* Enforce VLAN promiscuous mode for all SIs */
+	for (int i = 0; i < pf->caps.num_vsi + 1; i++)
+		enetc4_pf_set_si_vlan_promisc(hw, i, true);
 
 	/* Disable SI MAC multicast & unicast promiscuous */
 	enetc_port_wr(hw, ENETC4_PSIPMMR, 0);
-- 
2.34.1


