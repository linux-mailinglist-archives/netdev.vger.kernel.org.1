Return-Path: <netdev+bounces-304494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8t/AASCVR2pcbgAAu9opvQ
	(envelope-from <netdev+bounces-304494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:55:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A44F67017C0
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:55:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=gVyOb6Z6;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304494-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304494-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE6E030E92EE
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E432D3C1F5B;
	Fri,  3 Jul 2026 10:42:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928A3C5DA6;
	Fri,  3 Jul 2026 10:42:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075349; cv=fail; b=hFfEYowi8VkF1bQbQ8ovTTOVUEslKqGnn/a16DuOVAAjMuOv+IFT2satdQgj6x1H56SjYX06juYZ5EVJRE0t5RjTtBwFYTObf3A0CPFb6ixOFX0dA/tW6fvIqVc6QaE21Yc+++TGcezRBdmt4dCYnjOOR/FbWJaUdBYmHmJ8XvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075349; c=relaxed/simple;
	bh=Uu/FsTOSg4zMHV9RFjw9OUszYGNTUQo39EWNqwYNKaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jho6FJa0zd1l6qcyBujj/GFrIsPSAnnB9MhGz80kUkoSx2lr70QERz9af8fxGRbRGGNb8Qmguh9gn8ws+iEsz4t/mE/27tHtxdnWjlJDj1BaoToPMgwWIfAt//r+RaZIMJAnyWx8uwnipm0ph8dW/WKtVcT4gDdqKGttdDhxOPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gVyOb6Z6; arc=fail smtp.client-ip=52.101.83.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SukMLcalc4vFJlxrr67QkA2wy8N/WC4bc6s/HFhZFpRYyYcDT/cj0psagreKQMwMcBi+dNH4kXQyB3O+ELmllnmv6nhJjATLjmBRmU/LJ690OSAsAKRCgIXjZM8OHf6JYiIW1qv0aTaynExgyMaW82IhwkQ2/KRAjqk6osKXPcfd+sD52R0jmUpkqutpYl4eg2043VB/989+rZIQcazkmluf4bkRQdnWC/lRpsQ5ORcWDXcXbFDPqGds7VmlBvP/JkR48rXa1JOWwXqvBJkED5vhF8HjvCYrN4nxG466sLl2cK7Bey79jzQuCtSgj7gaFuukiZDj+L8VfPeRQtD+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6uEoZVelqqiPHG5MINFGev4roHy4M8lixp1YqZumD0=;
 b=dfa5IvSSlKYiiiWqrbAXIvF41608kbjGnGd3WwUe2x08RTNzm2ztE4x5b0SkxTYHwQgUIGTqm0FjsFu8B8bVOQlyldNnQmX8vUIOLsMFVZg4XmP+FhuxFOeo3R9fz9i9MImpuaulxYQh4+OK/DrDyDh6zj8x72noZ3Jur+VsUQ6ZnlPdONOzzaBJu7jnzniirr4gnOryiF6Ku9e6vIHfogkRIK7lQbG/frcwrEv05s8w3euK6NEieFzLbcIyejF4lh26fue3XSb5q1+orgbz2RJ9bwQ3qd7PBxfkXJh5h7qNngFJA4kT25NXuBUXg16j+MNUK6j7HV4tOUhJq8PAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6uEoZVelqqiPHG5MINFGev4roHy4M8lixp1YqZumD0=;
 b=gVyOb6Z6hcnz6/9Hx7lbrbB8qdaWjLRmumbg+wa9Zi+mI86iPaaXN9KDBApX3IC7RvoO+EN/JiH5iEOYYKu3n5xGzHp8WSp7TBbFthfY/ga44TkqnbE8ZIGuv1laV3TYwJDYT89GVs6pQG15qQXVB7o81KZVJbb8f78vYXfyHdZdmVUZtwbTU7foCjJBbCiIaJgUL5SDMWsYCvtA+Bd1KMeh+cM3yngBJ0q/o8EBRQlm7z1fwQNHiNMBWFRNbPs9UeICT+qskxq6zv7gVjCvlkFhpL+g5ojU91/5Fc1bzxutngKWJyt4zhbECre5M1+6Z+CVAxgGHrixSXcbpoPBwA==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU4PR04MB10741.eurprd04.prod.outlook.com (2603:10a6:10:581::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:42:23 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:42:23 +0000
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
Subject: [PATCH v3 net-next 05/14] net: enetc: use PCI device name for debugfs directory
Date: Fri,  3 Jul 2026 18:13:19 +0800
Message-Id: <20260703101328.550714-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703101328.550714-1-wei.fang@oss.nxp.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU4PR04MB10741:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c67164-2ab7-46ec-924c-08ded8efc404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	afPx3AXjdpBr1ppdGi4p8znO4uQhGvm3wb+WlFfMPHXzDyvqTHNCoLNe/AAV0S5TDnFbSo0SI5OlFx6MpNh9Own5ZSVsxSI/pg5hRf25U1PUAaTNDQj8FE2n2logXGhW3XejGHxIEfKr0vtoewiNNd8SoZVfL21mJcEnxbctXX/sOHGFQK1I7/NaAA54dGca5ZRxBPBCBZ8LiJuLZnkFzxMrgBk/UBMc9/ot+j5FoRulEaagr35SmOhuvhuEbixWsea87jqrxUKQmCLO7CterRFsxAqqKbxJanfn0+PrE8S5yjXqRClqU1/uGO4rmRjKjwx6BXZoDH3kuVH9FAW8xAeW3WS6+OSbUnCVzIsyxnbe4xY39eU2y3Q525zWuLPsH1cTuSCAKE0JBXL8XG20OssAJEmmY3+M/lBj2bRuQMCtzv85P5O6K3XVXtTznxkkpFqSNQJzTBShE1pYj9NqUi8QpLwXPSAJ5vsQgp48Ed1EBgKjZhgkKunVZbS1MUK3rFvbocug01QIuzdFAm/mW2uisbnw3QLpI8xWeh7XM9O0iwiWYInUuZGtwT94ttw7tWaiLMyXRQqwQrNCOSxloB72+sGNyf3BDScSNb+gmOvocFqCEgQ1kyEe8aetzBoYJcP4KAydjlopXH2022AO0u2I5CdLlUAxo0gdbfFcLwnZEgEZu2AXpNtskS7nhGUoFu8gIcimMMVEy1Cfy3E3kA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1CjBSxzuKemSM++AMib/ExZsvPT4QhYEqmfGVdFdInTTb5oDHmg8e97dt5cD?=
 =?us-ascii?Q?zgHm0ea10hhxDDwnq/Q9MimpRQrYdKB1hDxNapGzkQISN2kOcSFdtPFJauBS?=
 =?us-ascii?Q?WDGAQwVdumhA3l/9dDtnnMgOtH85VFB93PsGnqqB0JCWwEDIkadyvkbE94Ra?=
 =?us-ascii?Q?VqwIK++yejeWsqZgf9eeL/MMRR+g3x5H3bQD6wkeATdOaQPIjVhGBdEmrvvs?=
 =?us-ascii?Q?eBEB01FPaTKwY3G4mMKFYV6bh8cIaXEr2WlSpAFmxRh+DR/IFaifiuMIVds3?=
 =?us-ascii?Q?XyCx3FtvxY48yF1gvEAxKGhk7EXN+i8Tc21vtgsFrJvm+1lgypqsBwRDeBUj?=
 =?us-ascii?Q?prGMYTezpsU64SmJbLFFeKURsrMM5SPhSK/RaED4S+Yzix6Z5IEAE9HbHSVs?=
 =?us-ascii?Q?0LsULOR+OCHB45a20WE6MoFtWyy1KoolOITsUvNEMjqB7iPOa6XdCZdGnNcm?=
 =?us-ascii?Q?lEhWfvj/Ct3SpMzxrv0JULN6nmVSLAYn+l9zWVWgvuxf+Dy6KGNjRVQDi9/F?=
 =?us-ascii?Q?6V/EaO7Ty9BHspBSgdD/VSnUvcJhYSl4GAgsWIz+ZcbxcV/Shf7yZgW7bkAE?=
 =?us-ascii?Q?A4YQYQvfsyBPfvYrW4buivszaa1ZWM7gaCN5hbC/uQYkSt4FHXORY5bTR21X?=
 =?us-ascii?Q?AkGPqht+2MwvsqlOUpQy/s1A4PwaH5mg4U32u5y7KRTdoM9iqWzh6ouUXbmo?=
 =?us-ascii?Q?pLuJemgcP6x5o9qYOzrWc/vEGj/K09pHQPhEaA/DmuooZMv9tlXC9BaKzjeC?=
 =?us-ascii?Q?wkS3IGfhf2UEePvgBmxxHH8xu+rEZVATHMjsSBOJlXlCvJPwukAYMVn/HvTw?=
 =?us-ascii?Q?/7ChKmVKqiorbqlcD7yYs9z3sMrL6uXUFqafxu5XP3krizNAMq5W+c10Go0T?=
 =?us-ascii?Q?TgqxIl//wt6jaKvSXbBXYUO4aV7NDsS0dlXTNxeZoKMQdHHfgt9XA5tNrVTU?=
 =?us-ascii?Q?WsB6hyPveM0sf/QAEkio/qa3gKUivEM11uQhCP9UiQOkvrGq/ZfmESY1Fh0m?=
 =?us-ascii?Q?rc3HFtwoMPO8KUA/v2dqZtX7X50hbaFk3QDYO445G2C+bruM4fh2soYN5Mbt?=
 =?us-ascii?Q?LfNnrpW+fT6Jpiv4CwPsLV7t/z3NJv9FZD+Ex7e3zn8R2CcbtFiCGurhnX1w?=
 =?us-ascii?Q?KUbFLfC6BA8bGraIf07ha97bsl236MV47FBMX+0ojsxrgIiNYGqZDHjjLi0l?=
 =?us-ascii?Q?iUD8zq77p8HQxcNlHNKAETaVp92m//J/z9J69b+3h+Ifwp227uX2T7f6y0Ns?=
 =?us-ascii?Q?apLPX6CIn3oocHqAxBOWfGbynF68YAADJjtFBaTXiVP1h5CRTBwjc9wtAezd?=
 =?us-ascii?Q?uLb90vYJK8NodbZ9Y/Vg8rkuai6nRigLg2Wabz2QcQOtMfynuJ79p01CQztz?=
 =?us-ascii?Q?hLrzJuILj94l5UUoxQcaewJz+AIRovprFTXojB5HjcoP5ecBYggICkJZF8cW?=
 =?us-ascii?Q?IR8FPzCOp3oSaW+sf03auH+HEK0Mmcfz110Rc0J1dvYhfzuvZnfiqUWd5A6y?=
 =?us-ascii?Q?eJf+aQsOpzq9jLDxyhooDY7qOhKYIKbVmYSx5SwSSc+05bHmY/1rfic/ZZ/X?=
 =?us-ascii?Q?eTq5SfwInByErPmi+L+5S0u4dc5BcOExa/PLd39HhPWS1lD7XkgL1G4kh9Yi?=
 =?us-ascii?Q?3Cvd+3uVvE4/1mLrn1JeQEbtoGBAxb2q1YeqjAL1WUZIGGblooTRLOEWQNdV?=
 =?us-ascii?Q?scoFAT0zz7y1ktYUOWI3JijqN2zavCpN77TCEdeG+rKnPxiHeyIKTDegVuyW?=
 =?us-ascii?Q?LZm8BcEzE0N/sttSj6nPao+nVusCT53e/7FYe7o0+6uEEHl8rOur?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c67164-2ab7-46ec-924c-08ded8efc404
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:42:23.3216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+NXpLpmu415d+od2JT9dD3hKBg3Xu5eZsR0oHAcE2dB2FJuMmvUHNYrT/1VURKqaUSO2UxsC6zYwkK1d7gSeEDxOCeLNKNVhGwp2r5JEF1BwuDVLQSHUq1tUVIGfjfy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10741
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
	TAGGED_FROM(0.00)[bounces-304494-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A44F67017C0

From: Wei Fang <wei.fang@nxp.com>

enetc_create_debugfs() is called right after register_netdev(), at which
point ndev->name still holds the format template "eth%d" rather than the
final assigned name (e.g., via udev rules).

Use pci_name() instead of netdev_name() to name the debugfs directory.
The PCI device name is unique, stable, and available from the start,
making it a more reliable identifier for the debugfs entry.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index 4a769d9e5679..be378bf8f74d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -81,10 +81,9 @@ DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);
 
 void enetc_create_debugfs(struct enetc_si *si)
 {
-	struct net_device *ndev = si->ndev;
 	struct dentry *root;
 
-	root = debugfs_create_dir(netdev_name(ndev), NULL);
+	root = debugfs_create_dir(pci_name(si->pdev), NULL);
 	if (IS_ERR(root))
 		return;
 
-- 
2.34.1


