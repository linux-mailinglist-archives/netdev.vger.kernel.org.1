Return-Path: <netdev+bounces-297583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3hDMMxU0KWpSSQMAu9opvQ
	(envelope-from <netdev+bounces-297583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:53:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7065A66807C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:53:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=EGz2VVow;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297583-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297583-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FCC8308CC49
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FC93EFFCB;
	Wed, 10 Jun 2026 09:47:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E823EFD21;
	Wed, 10 Jun 2026 09:47:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084852; cv=fail; b=b9v3u71EIixZyYPZkECFkbWW1gHiHHRva5weUvF614xNJm9S7JGrodlcbuBpJUTdb3Bv2HMBx182+Hkgv2PXV4d79JgnMGWlkR/mDUjkCog9q67HEoHqxXuD/WwiCSsd0PD+PZa09gvTJ5JikdjyNQilaiCvpAqWSJ/i4L9qiN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084852; c=relaxed/simple;
	bh=v81uUEXOzTxbPAmnnwhMfycPxAbOlpY8fmcS8zFAkww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HMGk25v3FxL/Mwbtdt9fDdERF0nnpXhguL6SHDzwNDBeV78GcU4w6028Px5eDqtzxuhxeeNKh7+VXzq2Su7xF2qZYpJMZE5eY6kInUzOC+RQATM6KX2No4z3mEDW2SFoWD3gzVZ48S3mpJHIWcfFr6iDHhfi3qBc5GfmPbaGva0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EGz2VVow; arc=fail smtp.client-ip=52.101.69.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrIRyufoF7OJr7OXg1hwVhofeFCcPqcvrJ7OnOoYzZ+9rluo7VZYKaVp1y54BQOxAwA6ss6l8qDbmNl323IqxcV/OuBCb44W3sL9Z6s2f9LxcR1iFGJgld7ypmcNNcPL9trc9HiCpX3TOF07lr1+GIhJdrlRlDTuBJUXVr8O2corYMnQQBbkzPdxIj0yWP6+F97X9Tf8zPClvILYrPrwY0qr1uh0xfFDyssO91QBJRBepu3l+oOO1QeLjdJuT1dfNZxu3mqhqxqknEdJZlYN8IOFsItRX2H6Heut/CI8mQhvlRERYB2CwawWqlCPW+LbvNkgS6yR1yy8iJ1PyCILgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zo/EJGqpWQQwJOeuZ3YsdEo8pShNHpKnQONSPwqejQk=;
 b=AMI0ReHNS0SxNFZheXtYDgPPvO3bjHBGZn7+6ke9ct4nfYv3s4k6dyplxU96kf1hpJL3zmMY9lwHoeFJ55AOQ7hGmU70gL8ukWTrMNl+PfDxbOPA2B06r7m0mQVTCQ0HBIziFhBTbJWmtd0dP4XUdnjpIOhiHISW1D5eGHpZfV3kO5TKRw+58jiy/+zPIrDjAGixy4Il2Rxoyz0GZqf8CJINZZMmdhXQj9Fus3KiyN1zKSkx3YY0WcOBskRaW7alErxLAfXLsrIk3teN4wQxJXSB7tlyNB+48TAB64P/1nmpj9q47reuaoV+B/r0v3cwqbCJ2jb0w+pTUPwDBp0GHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zo/EJGqpWQQwJOeuZ3YsdEo8pShNHpKnQONSPwqejQk=;
 b=EGz2VVow6gHsYXuG/1Q6UvQIiHx6n2D+0QuGc30CpequQu1hYzrTaMWn7I1amX2QdYYMOhM3bnZN4nwJaqthsFGRpDfAngCqrqaW3+b3rcKXJZrWqWL0Ay3ZUTLqRl8/4/IU/S+JoxdXC9auypuQxx7ojEzPuvtRrulxZ8SArfw+nRMJ2nKDD568eCnNanOpJXSVmehhE1IPSK9jOcmVxaYBooMOOMpyf95yrODZnN/aj+0FpHUxeSPxOGrLIuUr400Ys9Ds+Cx98K34BhwlOGnf76kXOw4hGRq8Xb4tRCrYs/6lL2fGywLqzbtmK0g4JUrQcVtnPlqpZVW6Q8/Oiw==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by AS5PR04MB9875.eurprd04.prod.outlook.com (2603:10a6:20b:652::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 09:47:28 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:47:27 +0000
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
Subject: [PATCH v2 net-next 15/15] net: enetc: add ndo_get_vf_config() support
Date: Wed, 10 Jun 2026 17:18:44 +0800
Message-Id: <20260610091844.3423693-16-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
References: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|AS5PR04MB9875:EE_
X-MS-Office365-Filtering-Correlation-Id: b52b521f-0efd-417d-0c59-08dec6d547ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|19092799006|376014|366016|6133799003|22082099003|18002099003|921020|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	NXdLhKY3cS0JQCSZvsacvHwy2uMPk+2HIS1YXQQwsj4aIoZ/k/GB9Y5A3WNiEtmEx79u6wXIYgjvSMlBFKYl5V2IyrjDIfnISlf6KqtS3GsDziYExfbgppWZWiaIy9kUQISXFhMzmyShpXW3L4wBNm6o/MZjqFL+EvNS9XQ9cGA2IKTqxJgG5F6F0ncPQ7MjkZPETs8lsw+pZn7QqFVZGPzGPhV7sG/ZNHItKmoRzL1xgcjAU7A/9iCw3QLBvDuCThXTyO5De0X/nqmwJTuyCW27vooYTu/1z66A8J5L7yWYqHLjtr5fqtWxzQhQcHN4QHs8ScVCHYnLFFtPVNv00YeAjH315gQ0YyikX5A0wq+nGvZfTN5gxe6GazhcyHbxt8zOGOCt9Le1wpMsyw6DEOBffLJ26A+YuHIItueUUz94g2ouxvOewcsTh/4LyS1DN6Ieq8ccOMLeR8jIL5Bgjeud35QqYz30M+4e4iK/gKtJxT0z9psdJsT7ETG7j02F1qxABbcSB/JdiqnyEC232Edl+wZU95VjN8Tw8l8i4PDg4ZNTDWzMhL8sPVPumm9kFf0pAmDssJdmGkzqND2JJYJYz4SzV7mCBKaM4TEwtOKOaTMQU/l4+1Ft9eQJl52d+52XgSWAfdESkSvobSyDYhkQ7D5aUtiPgu+qgkC5hB5HAQiyVXYtn/4nbvKyXLhCVNi5zx3zHG0syA0kdQ7yC6dQshEScTFSiqwFUmIchjA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(366016)(6133799003)(22082099003)(18002099003)(921020)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lf39ZhqI6GSyyFEGTrbGW2I6bU5S6amVY6T6EmbsSYv9DEEX9H9UYlvwQAMH?=
 =?us-ascii?Q?bKhSGOfhVFmd7H0kfeEzyI+khX5TUdZETyywLFQvX/3TpO3OS2YiVjhrGCOt?=
 =?us-ascii?Q?0azN/zx23yZEg6URDL4hSr/c4hNHaHwzzPguC/ElQQGmnWCv6DIgzyb+un18?=
 =?us-ascii?Q?dh+1n2tTykcpPvMMZxswWlKxA0gQb9CvHE44zN5Kh/qZHQLoxQXPlWEU4puA?=
 =?us-ascii?Q?ZOUmEtXZDHJ+kQOvsVEc2MFGMGmKkkvZ/LAKvj1CilGDrJRJsf23ZyACSZcp?=
 =?us-ascii?Q?zkHi8A+/Sm7MnrXOLuSMs5ewKWa+WaWNAuEp3lijQKdVHcPgbnqVGTBauC3y?=
 =?us-ascii?Q?mDED+/RlAOczdjQ48WDmc5t2whke2xCgnBrQeKaj6sltCPE5Y1LGO8VZI3O4?=
 =?us-ascii?Q?mH4mmypereZGEtNRRns7THPzvYMxn688a/6ME1upf9ul+2mbqBPA9s8u6NXO?=
 =?us-ascii?Q?XAMjCnr5k/yubjFM5Ydbxi4eO7gaEmPUOA1OLSJl4w37w0EtgTLX35TVJG9A?=
 =?us-ascii?Q?4Ada713EaN4KmFM4Ybi7p9q/scfpLwXwthkaZ8keyIPKHSVa2XDEN1dfIvAM?=
 =?us-ascii?Q?ynmygwj61WHaFy5poVNeEcrHqtxveK4wEeB1nezVxdBCsGkSot6k8geqj449?=
 =?us-ascii?Q?xQt4XTPDQaZpbG35rPKQjrTfT3+XdhwDNbjrBuoiN5DOP6aM3YylBmwaFY+i?=
 =?us-ascii?Q?YpaJYHco4x7up9Pu2pSO/MWduUEyZhW5UVOIyus6iqipfJi6m1f+hDy1wm3x?=
 =?us-ascii?Q?WrqQCOoCg+ib/FYjSkgVD+3pNdWEoY1/k5rQ5z3fj4hIPq3lZtDHf2ulEfu8?=
 =?us-ascii?Q?9vFJXjFZi8nZWOZtNEEyyLKgtC3+ZniZItYSURqrmtpj114Wz1ne7JQJ1xMx?=
 =?us-ascii?Q?pwGO5WkLsf+4E7Rjb39sf2MiDSDbpai7ry7Pv545eLCVLw0Nr+RdGn4EG6TK?=
 =?us-ascii?Q?bYhacoJOD5PX24IoNEI5HBSP0d+RWMiLW5NsTjcw48Hqt5be08MPIzjJ8ljN?=
 =?us-ascii?Q?ZekWmzOI7okFaxrknjxYDEhqLJ30maERcAPpS8Poq6DO9dGnJySO1z1hbAAR?=
 =?us-ascii?Q?C6Jga6Zxk8P1NgEbKmZaHXZkfapSmK3UZk48XbbauZG9+J8D7oNKXNhU4p0X?=
 =?us-ascii?Q?YzM9oMEvXZB3nIwxmt0uV54Phq+zxP9zqF7Ux+Iq3ECVYHNPrwOIuxeKcHku?=
 =?us-ascii?Q?91pK9qYPIYFiDuCYMKnwReVaZYiS64+40/d76t1K/H1BqDGYwxqgm6m8s/bd?=
 =?us-ascii?Q?vyxzz/Wi8lk4PYkHGVnFJlyYm3bme9eVXuUv82cWsRWc12LR27ILYUZwcdmz?=
 =?us-ascii?Q?oVB2qkXtgteRGfVSn20NU5LySCo1X7UrCLmFn3J05eBybObCWQy+i77oT7IF?=
 =?us-ascii?Q?UrMAe2/QVPVBIwL4goActOPXjgec/juGoLjSMfDoQBbTrjUhqTofPkckIQXi?=
 =?us-ascii?Q?W/E79ZMX0UAGypbSoFUcukmIZYF8NBHtlvc3DSPcjn1DIiezFrowAsx6x3Fc?=
 =?us-ascii?Q?78lrl470l7Y3YIxx19fAMgC/MZaI6VNTopweaIGx+pvAJMSyNKuM2Y0ddhb/?=
 =?us-ascii?Q?yq0ZErGlePe9S7GhFKLIYPvwD24Ej9E8lIoBp+yFsbRyRM9G2a6sfV6s+brD?=
 =?us-ascii?Q?XdF4pZddZAlNUoE0OlM4eeh8YBxpx4PxXNvdcnYYy817qS2rpcTGDo4yWNGF?=
 =?us-ascii?Q?lLkquchgdCEkRHF4kuu1wiHtPrNBw6pURW8e+/asn53YspoaInKq50fsitRx?=
 =?us-ascii?Q?UczB/W0LoSjIUoQQku0lh3jdyIYBwPvfZgZkL+OwoYOwklqL6mZz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52b521f-0efd-417d-0c59-08dec6d547ef
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:47:27.4308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGC99V0KlOW+RUCOUj4u3/n1me9HkfSe1np/dUOO+AwC6TJq1bXhPa5SMD6FSCYESzIVlv4BB1fi1Sp6BR3JSsjBOPfCrePs8miOtiaJP5kEfF4pxwzjGhFk27wTkclI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9875
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
	TAGGED_FROM(0.00)[bounces-297583-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7065A66807C

From: Wei Fang <wei.fang@nxp.com>

Without ndo_get_vf_config(), userspace tools such as 'ip link show'
cannot query the current VF configuration from the PF.

To support this, extend struct enetc_vf_state to track the per-VF VLAN
and spoofchk settings, and update the corresponding setter callbacks to
persist their state when the hardware is programmed.

enetc_pf_get_vf_config() reads back the persisted state and reports MAC
address, VLAN parameters, spoofchk, and trust state through struct
ifla_vf_info.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  1 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 24 ++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  4 +++
 .../freescale/enetc/enetc_pf_common.c         | 31 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 ++
 5 files changed, 62 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index c8059c67119c..4faff9e62749 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -615,6 +615,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
 	.ndo_set_vf_mac		= enetc_pf_set_vf_mac,
+	.ndo_get_vf_config	= enetc_pf_get_vf_config,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 209a3503609f..f11d401ba4c9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -243,6 +243,7 @@ static int enetc_pf_set_vf_vlan(struct net_device *ndev, int vf, u16 vlan,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
 
 	if (priv->si->errata & ENETC_ERR_VLAN_ISOL)
 		return -EOPNOTSUPP;
@@ -255,6 +256,17 @@ static int enetc_pf_set_vf_vlan(struct net_device *ndev, int vf, u16 vlan,
 		return -EPROTONOSUPPORT;
 
 	enetc_set_isol_vlan(&priv->si->hw, vf + 1, vlan, qos);
+
+	vf_state = &pf->vf_state[vf];
+	mutex_lock(&vf_state->lock);
+	/* Currently only C-tags is supported, so tpid is always 0,
+	 * which indicates ETH_P_8021Q.
+	 */
+	vf_state->tpid = 0;
+	vf_state->qos = qos;
+	vf_state->vid = vlan;
+	mutex_unlock(&vf_state->lock);
+
 	return 0;
 }
 
@@ -262,6 +274,7 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
 	u32 cfgr;
 
 	if (vf >= pf->total_vfs)
@@ -271,6 +284,16 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
 	cfgr = (cfgr & ~ENETC_PSICFGR0_ASE) | (en ? ENETC_PSICFGR0_ASE : 0);
 	enetc_port_wr(&priv->si->hw, ENETC_PSICFGR0(vf + 1), cfgr);
 
+	vf_state = &pf->vf_state[vf];
+	mutex_lock(&vf_state->lock);
+
+	if (en)
+		vf_state->flags |= ENETC_VF_FLAG_SPOOFCHK;
+	else
+		vf_state->flags &= ~ENETC_VF_FLAG_SPOOFCHK;
+
+	mutex_unlock(&vf_state->lock);
+
 	return 0;
 }
 
@@ -528,6 +551,7 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_xdp_xmit		= enetc_xdp_xmit,
 	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
+	.ndo_get_vf_config	= enetc_pf_get_vf_config,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 378ca4464538..55057073416c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -12,11 +12,15 @@ enum enetc_vf_flags {
 	ENETC_VF_FLAG_TRUSTED		= BIT(1),
 	ENETC_VF_FLAG_UC_PROMISC	= BIT(2),
 	ENETC_VF_FLAG_MC_PROMISC	= BIT(3),
+	ENETC_VF_FLAG_SPOOFCHK		= BIT(4),
 };
 
 struct enetc_vf_state {
 	struct mutex lock; /* Prevent concurrent access */
 	enum enetc_vf_flags flags;
+	u8 tpid; /* SI-based VLAN TPID (0: 0x8100, 1: 0x88a8) */
+	u8 qos; /* SI-based VLAN QOS (priority) bits */
+	u16 vid; /* SI-based VLAN ID */
 };
 
 struct enetc_port_caps {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 52e7d2d2149b..597e020a0128 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -527,5 +527,36 @@ int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
 }
 EXPORT_SYMBOL_GPL(enetc_pf_set_vf_mac);
 
+int enetc_pf_get_vf_config(struct net_device *ndev, int vf,
+			   struct ifla_vf_info *ivi)
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
+	ivi->vf = vf;
+	ivi->spoofchk = !!(vf_state->flags & ENETC_VF_FLAG_SPOOFCHK);
+	ivi->trusted = !!(vf_state->flags & ENETC_VF_FLAG_TRUSTED);
+	enetc_get_si_hw_addr(pf, vf + 1, ivi->mac);
+
+	if (vf_state->vid) {
+		ivi->vlan = vf_state->vid;
+		ivi->qos = vf_state->qos;
+		ivi->vlan_proto = vf_state->tpid ? htons(ETH_P_8021AD) :
+						   htons(ETH_P_8021Q);
+	}
+
+	mutex_unlock(&vf_state->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_pf_get_vf_config);
+
 MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index b2a2b06c794a..0e487ea9c0a5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -19,6 +19,8 @@ int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
 int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting);
 int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac);
+int enetc_pf_get_vf_config(struct net_device *ndev, int vf,
+			   struct ifla_vf_info *ivi);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


