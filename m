Return-Path: <netdev+bounces-303020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PfipB2N2Q2p1YwoAu9opvQ
	(envelope-from <netdev+bounces-303020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:55:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 140DE6E16FA
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:55:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=GfiNADLx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303020-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303020-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 022853033A6C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8983EB81D;
	Tue, 30 Jun 2026 07:49:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBF3EB119;
	Tue, 30 Jun 2026 07:49:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805758; cv=fail; b=QgV+VtZKTfksVVUeU1IHUNvqeb9OpPF5cdA8OdWclnq+WlxT/p5OmWRNOK4jgbebjYB/Q64DhyElU4I4ty0DzqxeRbR6pXn8dksnzuFEON1bczQi6zCld3IZvrj0JihCCjTBY7KkkQvaZQsTPvYTsfc/wk/LtR4LkQC0G/wKuQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805758; c=relaxed/simple;
	bh=xYFpmxa07SM0sB/YsTIStfDmmymlNCMfOf9sdlEp5+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e6eUNTo9nZmnCgc9i0dATZGp2XAXfVCzQGytpET0A8NXUdILjtnmEmyNDH/4Q6AmGb2fn5gKLiGwuj0s91SgzYcn4kdCvBqjVNHOg7aVMQN2sKkJyWvyBXwFDQjMdpirtjA7yE8BEgIyzgYPBZqwsj3J0mp4yKsNjiXvF9dSh5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GfiNADLx; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTsWYVw9kNTMyIh4qRSoFlUHNQSk7vdnVUiBRMUZFWIsrt9lhrrzYYuNkVGHfHiMMsU5OTRDpRcwZiG7BIaGtXxZvf/8aHaiS/zARqSjAPoywt6Nz2s/S5MA0/rUtZOZMDzhK6JtEnYd4+8Nq5jKXLtL1Vm+Ge4/5oXiLo8ARzrtCTU2la6u+/aRL3cgwrswHzu7pAJHlvwjuUoKogBsqB0vRQncTafINDL8bDlRnumDMKRVvjWWxSlPAWtj7pbWf8H9z3/zncJmWN64LBahivrNxDGC0K7HiO9Z67iyUprMDaCPLDXG1XucIESO4nMdUnMyqvWE+gUGkPYuE1FbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L60EmV1Xc031R3GK0ggOHzJ5YHjfAxNz6KdYexjM28k=;
 b=ASGSIV+qepg1HcW4GIXP5WA3gCkbpJQ2HAWMgimhWPHaDJQXVV/W1Uy3uj0afbnus8lshGrzLMJaVXEGFi+1KZIrvF4M2OC+rCWzos9I+vUSkiA4CCsvCvzzK7PVooGE2UJeN2BjNyK7IDdOkGsuQhLxEhw6l5ITZ4h6sgOXTO+qoMKw3pIhNvlNc6TNnnDKBUvOKcbcJUATkoJXJJ+zHMo0K81nhmehSYnehZ3+BKlfvFtYYd8g7cr8vTzw+5og+oIdA2vBw6Hn+tm0cf5She/uL9HfzhvXINZN9WA2MtfKbVIlVet9Bjy11E36aUHtFFDFcQ3zx+TXMEDmzKMXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L60EmV1Xc031R3GK0ggOHzJ5YHjfAxNz6KdYexjM28k=;
 b=GfiNADLxkbFOQngmGjHtv/WFdQZ+f55ZyWPpVMD+NXjVXwEVvgstQ53XXzh6wg/h0cGOVbTkB91FrUvBzEF+K8em0/++3cMkmmO+HwFiiMxcjvXUjvOuerDkg43hlU+0kUJEbpSy8GpTtKiDzDbOjg1pTkDcXRS0Is/Wz/T1MiASdJ6DlajjDezwp5dvqO8O9BjI86vTIwbZ4C/hTn6eIC/JEw66D0vpiHZ1yBuYi8umZfUeq7DBGuoSzTBt4fcMcZhZcyZeUDVgcvQ2pmIE4jWpmlTr7f19DEiL100gdMfi5AyxI/5ZZFU0jrR8fR30neNuWvlje0J3NjFl/43EYA==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:49:12 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:49:10 +0000
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
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 06/14] net: enetc: simplify enetc4_set_port_speed()
Date: Tue, 30 Jun 2026 15:20:28 +0800
Message-Id: <20260630072036.382761-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 43158760-69fa-41eb-56c5-08ded67c1274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|19092799006|1800799024|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	jUCJ3YS0hF+QbNFz5weHEZpKxoXS1V56JbgYoQF3z3Gik2qugGWP6pUxHXsqe+sQyBj4JS99se7fJPYaUr/5mV4fx6uWB0Lt9AZZz5ANJ8AbVsArtpljGsTrn+zFFDU0nX62feZEMKa29hxcH/FGDtpaMkZXltw6RjwPC0Up6HDJbCTXnIHaIS8LxebnY73Y5BIDHlNvd92eIAOOxmsnhstBlzB0FmTD6Q4zlQKqq7jVvDlTPHf7PC1S1R0DpmOLW7/TxvJHfxLnfbD9LLaVYUcB2fZk76TtvgkYmSJpHlGmDJQHm4MpbkrcvJYyMP7WrT3V6CxE25ib0olp69JGmIUCBYP6kuqN8FQ0v5cdsnmZzaI6t+swIOl7PzbjREwqfSB1plyVs9mzddc32h1cHQxrkBWd5IDiD7vEIRpT84ewpPq8yqDVvxqbRd12WNoKthb1+BrzLp7ucNYM5Ykp6JR/iVzmpXXlAZMTuSc88JgvL8uBh7KiNJAIzns+HLboyhkcctqNxnBtEr+cT1q3hyDW4e+sZqXIp+ZTU6w43JvibT1YySbsSWvVzm31sh+bGiAqMB1B8WhQ0Be572vcyn5+GO8GP/xjbEWRQ0vVFPTP6jmFVPRvMaI9EPooBLO2ZlD4UYuZ9+lJjpaJxdTYDeT5Y+8Td6XWuw/bDVD77u8Hc1LVV2gdftrFozQFJM16PH5DDW160W8nVLGr9mBhDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q8aPcfoD72Qb1Lk5Guo48NL45CBLdX/nrAy2E1E0LFeiGgZOHXsDmkIgsrrl?=
 =?us-ascii?Q?nwBrU8TBy/6LYUKrLFHycRWm7gKYglt53t0yHssuj5WnmDQNmsRbCVNgUuXj?=
 =?us-ascii?Q?K2oHDeKO7qXOm94SAUlFi9iVi2RK8MKlODIDQ4algpc5kk2xcdiiiskgSm3i?=
 =?us-ascii?Q?IHUS+HC9oYkrV2tbPC5USgtIiRt9FIiGDOI2iFAImd40SpaRXE5ZEGtTY8jp?=
 =?us-ascii?Q?wiOHpJBGxL92jUngNKszvg9aQBPvTsRECHaJpSUskRdRNFe8TANidPA1DjOL?=
 =?us-ascii?Q?NK/htEFfc9+OVm+UdO1JmMrr8p2KbwGxYgBGGzI3b4mTJGzjeUOn7kJxpMnC?=
 =?us-ascii?Q?wINxWueSJ8UjXnz0E1M+xBZ9ipLgAV3s6boP/GTZ1YrRczXYh0DGuAvTgMty?=
 =?us-ascii?Q?zolWtK8lWZa1IYaD0FrVPBdPeFvXXLqXD9Hdhk2gDZRdpPzUdHmOa+opbsGs?=
 =?us-ascii?Q?YOISQ4tYVlLlEzBK72qjuv9XTLdKhczz50LhGZmITX3Qgaxlz0aioIsrJ19A?=
 =?us-ascii?Q?QO6y4AN1ZGH7MQxZ2c35bg+pDMFV/Ulcx2/LelHM/zD+1mtYRqAJ9vF+pnD5?=
 =?us-ascii?Q?rdWUujz63QEC1w9NyCvo0cYwK3a3zN+uarp65uY6k8ueCHBlanvQ0cjc+ZBF?=
 =?us-ascii?Q?QOPW+7dg8rsPUEWKGKGIcjp/b+QYOVqpltgsNyp/TjDjPvEwKcaCJdfJ8kpO?=
 =?us-ascii?Q?hwpf13TcQo1hgfqvmaMO8gsKtRIuRQ534rjtLX6+XsHztLOb9fxXUA44hKQs?=
 =?us-ascii?Q?KXhykqWpHOK3X9Ow7VEOEjIfj0CYTcFCCevj+Vkk4FcgS5S2nWKBbN1f6rjb?=
 =?us-ascii?Q?tD36ZTRt5whehgmVF6LUEKHwKWwaryShxJHv7mE0RuB8nz2sm2oAF89bf3yC?=
 =?us-ascii?Q?ir1dfJSSohFnrcR7sbp9ORLkyS9r06ezsO1U1TxGOznCDPAjd+IvTYPhlHt5?=
 =?us-ascii?Q?zEwSrwDkX8slzs0OGJIhwn7owUGsp2LbvO8wjIDem0WrDnHIrc4r2alqIzK8?=
 =?us-ascii?Q?DEjshHmhEdsacH4Fs1UBMbrX97ks599yU1Iva3p1l23HGXoFh/1YGjiZCeup?=
 =?us-ascii?Q?Up2AmRJ9KKxSRKP3GQiVGeuWFPZ4VGOGonXr/NeVRoungdc4lQM3qOHB5YrI?=
 =?us-ascii?Q?GL2X0znNLyjT5ZsuQS2S+DI18KtuxlQWGTvwjpMlrtlLJxGLjR5tl98uecxs?=
 =?us-ascii?Q?vJ2JxBYnrJfFROAO7itzC7LPRJ7yjIZQbkvbyHm43SPm4Wf9lOCQFP4TmF8L?=
 =?us-ascii?Q?JIDRkPSAxw5U922Yh+fEcEWT6/HJpenjRqdGn8mKrcrNlLiRa51ccq1mswgi?=
 =?us-ascii?Q?3dDwzhfsVTmXiRgUcQHfyg6jaQ8Zh+eJijhIpZzOrrkbRM90EB+10xhsb3IY?=
 =?us-ascii?Q?6cc2LnBQoH/xYRPtPgHu99FvNzpwS2V++j7U1ftmQkdKfA+aZBxaRyBUUjqI?=
 =?us-ascii?Q?cEjwKUYIAmnoB9IoVrN1JoNESTXoyIUBAwSQrX3EtHCgTVaMVeWu2TxttFrE?=
 =?us-ascii?Q?u2gagQPBonw5w/qbUtjiRMXbxkxk0QrmHprAexZDsdiseHKbtJDtq7BueAP7?=
 =?us-ascii?Q?TMYsYYYnaaIdUdkOrZ+26epBrs3W1GyTL6IQlsH214LJRWh6hxB5eMx+3qAy?=
 =?us-ascii?Q?UQTQ1CqAklPKmAF3mDtvntQHJBkxQlQxgjY026Z2G//sV79uegsmuascQoG5?=
 =?us-ascii?Q?Z/EVPEfRdsoaF6xd9svPuCByS7GF9cqEnHgYplNlWLkHa/PhKNkotKjKPz6V?=
 =?us-ascii?Q?9OHpW5pmC/ZVUnH7WVedDMMSlvjwuUrw/Xwys56CymvpY3b7XRNW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43158760-69fa-41eb-56c5-08ded67c1274
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:49:10.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGtM9AkyXsObRi8EtZUNEkZVZiCdraHM9IWPmg6phcYPmnocS5pUBX7Fz4f6rDFeNoArBNSobiW3DOO7my/ffaLyNHkEH8nnmxAsJ/JtvF53pp3/NNvQ9SB63XllIwk6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303020-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.nxp.com:mid,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 140DE6E16FA

From: Wei Fang <wei.fang@nxp.com>

Since phylink only passes valid speed values to mac_link_up, the switch
statement with its default fallback to SPEED_10 is unnecessary. Replace
it with a direct call to PCR_PSPEED_VAL(). Also update PCR_PSPEED_VAL()
to use FIELD_PREP() for proper field masking instead of an open-coded
shift.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 19 +++----------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 6a8f2ed56017..dea1fd0b8175 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -148,7 +148,7 @@
 #define  PCR_L2DOSE			BIT(4)
 #define  PCR_TIMER_CS			BIT(8)
 #define  PCR_PSPEED			GENMASK(29, 16)
-#define  PCR_PSPEED_VAL(speed)		(((speed) / 10 - 1) << 16)
+#define  PCR_PSPEED_VAL(s)		FIELD_PREP(PCR_PSPEED, ((s) / 10 - 1))
 
 /* Port MAC address register 0/1 */
 #define ENETC4_PMAR0			0x4020
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 4143438ea7a7..b21ff362c31e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -631,23 +631,10 @@ static void enetc4_set_port_speed(struct enetc_ndev_priv *priv, int speed)
 	if (speed == old_speed)
 		return;
 
-	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR);
-	val &= ~PCR_PSPEED;
-
-	switch (speed) {
-	case SPEED_100:
-	case SPEED_1000:
-	case SPEED_2500:
-	case SPEED_10000:
-		val |= (PCR_PSPEED & PCR_PSPEED_VAL(speed));
-		break;
-	case SPEED_10:
-	default:
-		val |= (PCR_PSPEED & PCR_PSPEED_VAL(SPEED_10));
-	}
-
-	priv->speed = speed;
+	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR) & (~PCR_PSPEED);
+	val |= PCR_PSPEED_VAL(speed);
 	enetc_port_wr(&priv->si->hw, ENETC4_PCR, val);
+	priv->speed = speed;
 }
 
 static void enetc4_set_rgmii_mac(struct enetc_pf *pf, int speed, int duplex)
-- 
2.34.1


