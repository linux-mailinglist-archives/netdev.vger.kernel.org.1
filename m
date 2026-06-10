Return-Path: <netdev+bounces-297567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1oFrJl4yKWrpSAMAu9opvQ
	(envelope-from <netdev+bounces-297567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:46:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF5667F77
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:46:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Q5HpIgZj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297567-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297567-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4C3C300EDAD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7923E1D19;
	Wed, 10 Jun 2026 09:46:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F953537CC;
	Wed, 10 Jun 2026 09:46:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084764; cv=fail; b=CwOhWELtXuNnOja9fYXMC/EC4KX9Pt9vmf8hdvgD3lb/OkOkYfCL9QwKqNtHc/d/kI+kNsn3c3wcayieD4Egsq42lWCgMTWOLXKC2o46I8azjPhofpFra3xG5TUtGgnN3r/z/mhc/9hwDyfw4NUTpfODeZUH9+Rf29NqKLgsuFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084764; c=relaxed/simple;
	bh=qZ3cK5C6p/MpBiE0b7ENtin8ZGfxYiVIwdSS9EojarA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jbolEadjF69NxFMSvYLwVzdy6fcCwByDUsxGKElkcZdDGb0SXPZVDOpQ5WJdj8d2l3z6zv3PcyRprr1ggra2Kaax3kiGRbo6suKYducoQE/aLFrNKGsoHml0a9zRbF3zLLUXC1yfv2v8WxZlRRT8uXYnMVIaiaC4Ols9t8zJ9AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Q5HpIgZj; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lk0lG1FKt4tIT8jig3NSHhpOvvu8MsmdVft4LP8W5cfTJA1bRasDZ3fijy7Bp8MM5ZHUy0GzgbOT/MylnhTYiUM6q9mtxo1tsZIJFPNrtfWoHH42UBT69w2bHv1eIkmANj8093HWilv6/1lMvSGUDdgAFZf4BZY+zY7flt0MZkW7TNEE5Tpa1sUXRYIBil5wgxgCQSxUpkoFC+YzFq2KARrvO4xPWgAq/2vR1LDcjb+vp6vG69kK3LPczwR6KJd0nMx+7HWwEo7T0eKN32kh3iqiOfzl5MSxDjx+9I4VLrX2b9r+De6In6nCXMeFujCf30UU6nQXU/kdZj0OXco33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7AclxIC2hYlX6qygvAw38sHtl7sz5uy+yIbfJhrEBU=;
 b=t1BjgUIwrZ3ofN4OAebgIiB/j1M3vQzC2mhKaYQZX8NASoK3E+5nOp8EzSSMamGYh30qA5QCak3U7BGtzWcbBPxrzmZ7Je6TSOEdQYHqZhnXrJXvxT/jOlu/4X8r9wqGxOSz4UfvernGwbZIJIV69PeaL3hCC+ohwdR7BQNNUYYmWoCf/ZklQ4b7205HVJtRFMpQSGIcObk+M19FQUDc6KZ6hPFm+bvcGYMjmzgVV4QiuZmbh7zgmg98jMQtC8W4bJ4t6xE93sqgZG1EI97L+iCisI9FbL/QErGrKzSne2zEakHp52WKOTi3/CH6k98a7qfRscaxfzJLigpxe7moUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7AclxIC2hYlX6qygvAw38sHtl7sz5uy+yIbfJhrEBU=;
 b=Q5HpIgZjMa82wl2CwTVn89me/1hhbw3lsLCr3MdDKGwxNvoAFj2caQSNE/0nXMqd4yxv4beQ1DUZAWw1QLV9SHMKN9sp44Ul6PaidaEsPDrdLajTgRcjI87WxXCAG1Q7cbOt086YgxntJ/LV8Ooff4F6vPWLfFLzCl8BLE5226PrcjMiFA72+YZiPKjM1J44bdNF+U8W+WKWkaHh9Unj9EG9PWb877zFs13ch+fYNEVe8mId3f798Lh12SMM9VCTZO8HsnMsYSNilofzpp6T33dX5oJ+06IjAXIpkNyvX1qsJtECTHksYjD81LY0DDlu7xVwdYHV8U8hcRbXskIdow==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:45:57 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:45:57 +0000
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
Subject: [PATCH v2 net-next 00/15] net: enetc: SR-IOV improvements and ENETC v4 VF support
Date: Wed, 10 Jun 2026 17:18:29 +0800
Message-Id: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::10) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e76e9e-11b6-4208-cc34-08dec6d51231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|921020|18002099003|6133799003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	6O9AYwWvAbTe9S6845aa0BXYH2C57nW3aLryYcDLleA3aYCoNUgi7VrLpo1Y7MJAmYZPtZO1bKBXZ61/Gd/8dK0qTnnxcgdBTHfnx3vG/qXGPQJnAwZng5apZmud88yzHMIBaqggKiskMz+PeQ+v8smTm9s+++EtzKwDnynIhhJiH0N9iYxv3FM8TPYUlTvgj3DHKN03s5fN8pXHg+2d8Fk12HNxWZJo5dDEFT6aeSeUsJyuFOGOizuZxSq86cf7nhqVG7R0Ki05SfuLfZprYCUgCKsc4JyrxlIzFaTY0WiRZ3MulhiR7B5m6mNuhQoI0dixmGn10Y5BDARzKIQBWz7PxMGnMYmwy2IycFQBqdLYl0+NY68AVqov88vI8acSL/PENXmiUddok52mF9itzrFi4plyBRD24TzK9XUa+3PjbnoPF9sT4q4ReklSz6vy5cxkz2aPYohk3srb2EDvvO9UcUhDhQZgtBy0bELeVzkbOUDiOft7h4vZ46k7hrP9s54XcvIPEWAcEVNWd79FbDrjfAs3CTJdkDFA1na84j9Fym47bQRR0XC6SwhPdbC/Of2SGS5mrBdoH4cpKuu0O5SQ/yOZvCeJy5U5Ns+vPvmgKy1KBg8ksFgjK1BZ2UQyDhMcXdtUNniWlzRD7susLJb2uPi4FLhNN5xpmcdcTNjrK4Bjfsd3/mkpM6S//+BAL18auyeUXw+N8CIxeNNz5zAmfA4W+y0M2QVHbptftiQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(921020)(18002099003)(6133799003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VQhYAk+1s5PhcaY+bH/bfpgjU11xrbn7/CGCcZdZhKFQQ0JmPcMT28henu8c?=
 =?us-ascii?Q?B0ordh4hwWzHehxMwHd83aDOebd8JY/KlIHAAm4w/HwCLN2d/PE9Fkg6twq/?=
 =?us-ascii?Q?cl5eX+prlIPXA0GKUYOCbVo6izNa4aArW1/3nI7hT7mZ2QL9kVQM6aC1UG2K?=
 =?us-ascii?Q?Y92+xENvrDqii0sPeyX4IvMQSIsE50HkWBU0n72/RbxsRe7rdtgXg33ehE2g?=
 =?us-ascii?Q?WsjbiRyNOPCXhShbINgAmlv9xF+d31ZQqSOX3CSgYN/V5OlBbj8lycPkI127?=
 =?us-ascii?Q?GkY3nFF3efvu0htKbPDNkDbjSCKz1jtC8FJOivM7VeEefGaooN7LCjqGFQtD?=
 =?us-ascii?Q?Ks2NFYfBPovCv2YJsY45MGDY2gfbQzsgAJ+Srw6d6zygtsELSwkFedDnIft8?=
 =?us-ascii?Q?ZbA/3n+M/CqWQ3ohaRStvJkcUCvKMQX9g8RqhrqGjCQJM+kxmnA0lFfCAAJC?=
 =?us-ascii?Q?wl90sEIUbKxZ0EWE2D3HNKOS12NDEIVOikd4FHw9OJvGPWABzMUY99zZqIt1?=
 =?us-ascii?Q?+31G0+Yws1YbIRXNtRP8r04R+BdBhlwzGr7mkicP+U7b2DIjEsVsz3FoJWZX?=
 =?us-ascii?Q?70mKaQRwvHVPI0xqx6ouc9kOZ+ekL/c7JA7d1i/2VE1NQCWYJHQnoa+Oua8S?=
 =?us-ascii?Q?oVfeLwUfAJejgo3kzZ0xt+j3DtgXzp/ZBZzqpieJiPI19adtSSznA4XbSXRc?=
 =?us-ascii?Q?wZfrCBEcfFPhdmRj+ZAGlwTWX9OXIEllLp0DEUUU3Hkn7YpjoaQFhWpz1P/G?=
 =?us-ascii?Q?Sg31XwtW6AFG3zOlaxu7skvDku++VVCveUoATyzjK0f3pbTVGlTRV7egpZE7?=
 =?us-ascii?Q?gzTveoRE4gL2SRvXVNsHysRXnGR5lrSmOYxRgIF3N/+NXb3izusyDqXX1huc?=
 =?us-ascii?Q?aTdmB/GmCt3BS5XcfNBixmicEJjupwo8gFJALQRIhiSfFm4vXFer72y2jmgX?=
 =?us-ascii?Q?TKUJZJKTlQFQHMTGUnSAb6CLpmY2f7k8sJGsGQ3Eih/CacaZ6ERejBN9zUUN?=
 =?us-ascii?Q?Qb5PXUQYoekU1gx0ux+uBqL8NkvYKcrDwDw75IRgPdN3+DqZDXlFOmrdAEGd?=
 =?us-ascii?Q?q59I4kP8XZBU/ekA+ttdCFCJ840Tgxth/vHmE5pRzcDc/M+Lz1Twz2CoqcaK?=
 =?us-ascii?Q?n6yYMN6GxUouPG00Z4itzlBrzmT/petf5VYxeiuIQm6EbgyGnNSuCni1XABA?=
 =?us-ascii?Q?NsRFckNXKDaLiR9W0HjyaUsJnQo9tZ28xil4ZUnh/idHgew/Cr8C0MmED510?=
 =?us-ascii?Q?kYPiL+KcOFRyAL9DvtVgOrheClLhtapoRTG+zMvwn3oRSjrslou/j5MYMEQg?=
 =?us-ascii?Q?KvtF6e0yepvBI1zYQTI3CkR5uPzwSwLhk+LRG923hFYcuQHKjzTazYxKwOnK?=
 =?us-ascii?Q?Y5sALfj46Kvg4kMDCdMCrTNgDaTEoObL22x//XI4l8hmDHnf0rrjVDlLkE4r?=
 =?us-ascii?Q?UtYXTXvdM+MBlVDCo7IMVA4XsF45wMBc3SrEgq7MPhTuHEZut4wTZ6aomVPB?=
 =?us-ascii?Q?uxQX9xRtn3j8VCt+YyoveyK7uJlNB/23BP+Ippd3gyhT9FXZCo3GCjiPoqO8?=
 =?us-ascii?Q?G+MGz/58hscK8gHHZpL0fx8LrjQ+SoyslziKi0u3/5sDpKhQ6wHY6xrLFKFb?=
 =?us-ascii?Q?GSHGS9L6OUwNbtC4nbD5f3dMIKUSFJh2zcLHEZ4c31M7pmxQ7SQ7SSS6tG8A?=
 =?us-ascii?Q?f6p0YAfYz+tjHvqngqqat+AA/y49nzcpWv+/W/WMU3YY7S5YJHCSjjW7bnyM?=
 =?us-ascii?Q?TOobKeo/Xb7doFwjB/zek9QRSX1dlv7ad2roNRIn3lkF2Z7ij/sn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e76e9e-11b6-4208-cc34-08dec6d51231
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:45:57.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9p+KjhPD9FjaJlLcLHKDtBSjT82Sh+/5kO9reM+A1vb7XplameUDTERj0XdhSNLbVjT6eg4t400dY+0BaRK29aRXBd72i3938ZtQUniyBBV8etsIPZWKnbEtTmVE3nd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297567-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36AF5667F77

From: Wei Fang <wei.fang@nxp.com>

This series enhances SR-IOV support for ENETC v1 and adds VF support
for ENETC v4. For ENETC v1, the trusted VF management and per-VF
configuration query via ndo_get_vf_config() are added. For ENETC v4,
preliminary VF support is introduced for i.MX94 and i.MX95 platforms.

On the PF side, the series introduces trust level management and MAC
address assignment for VFs, and implements ndo_get_vf_config() so that
userspace tools such as 'ip link show' can query the current per-VF
configuration. The PSI-to-VSI messaging infrastructure is extended to
handle link status and link speed queries from VFs, enabling DPDK-owned
VFs to obtain accurate link information from the PF.

On the VF side, MAC address filtering is implemented via the VSI-to-PSI
mailbox, supporting both unicast/multicast hash filters and promiscuous
mode control. Since the ndo_set_rx_mode callback is invoked with BH
disabled and is incompatible with the mailbox polling path,
ndo_set_rx_mode_async is used instead. Link status notifications are also
supported: the VF registers with the PF and receives PSI-to-VSI messages
on every PF link transition, keeping the VF carrier state in sync without
polling.

VF Function Level Reset is handled explicitly to restore the PF-managed
MAC promiscuous policy after each reset, since the hardware default after
FLR enables promiscuous mode regardless of the policy set by the PF
driver.

Several preparatory refactors are included to share infrastructure
between the PF and VF drivers, such as moving msg_task and mac_filter
from struct enetc_pf into the common struct enetc_si.

---
v2:
1. Remove duplicated macros from enetc4_pf.c
2. Check pf->num_vfs in enetc_pf_notify_vf_link_status()
3. Check whether msg_hdr->len is changed between the msg_size calculation
   and the memcpy()
4. Clear ENETC_VF_FLAG_UC_PROMISC and ENETC_VF_FLAG_MC_PROMISC bits of
   vf_state->flags in enetc_msg_psi_free()
5. Check pf->total_vfs before calling mutex_lock(&pf->msg_lock) in
   enetc4_psi_do_set_rx_mode()
6. Check ndev->reg_state in enetc_vf_msg_task()
7. Check the returned vale of vf_reg_link_status_notifier(), and fall
   back to the legacy netif_carrier_on() behavior
8. Add ENETC_LINK_STATUS_NOTIFIER_REGISTERED bit to priv->flags
9. Add netif_running() check in enetc_vf_msg_handle_link_status()
10. Refactor enetc_pf_send_msg()
11. Add sriov_enabled to struct enetc_pf
12. Improve enetc_msg_set_vf_mac_hash_filter() and
    enetc_msg_get_link_speed()
13. Add more comments to the driver
v1 link: https://lore.kernel.org/imx/20260605065550.3038579-1-wei.fang@oss.nxp.com/
---

Claudiu Manoil (1):
  net: enetc: add trusted VF support

Wei Fang (14):
  net: enetc: move msg_task and msg_int_name to struct enetc_si
  net: enetc: add link status message support to PF driver
  net: enetc: add link speed message support to PF driver
  net: enetc: use enetc_set_si_hw_addr() to set VF MAC address
  net: enetc: relocate enetc_pf_set_vf_mac() for common PF support
  net: enetc: add .ndo_set_vf_mac() to the enetc v4 driver
  net: enetc: move mac_filter from struct enetc_pf to struct enetc_si
  net: enetc: add MAC address filtering support for VFs of ENETC v4
  net: enetc: simplify and rename PSIIER enable/disable helpers
  net: enetc: restore VF MAC promiscuous mode after FLR for ENETC v4
  net: enetc: add VF support for i.MX94 and i.MX95
  net: enetc: implement ndo_set_rx_mode_async for ENETC v4 VF
  net: enetc: add PSI-to-VSI link status notification support for VF
  net: enetc: add ndo_get_vf_config() support

 drivers/net/ethernet/freescale/enetc/Kconfig  |   1 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  43 +-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  11 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |   1 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  90 ++-
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   6 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  26 +
 .../ethernet/freescale/enetc/enetc_mailbox.h  |  90 +++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 579 ++++++++++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  62 +-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  21 +-
 .../freescale/enetc/enetc_pf_common.c         |  96 +++
 .../freescale/enetc/enetc_pf_common.h         |  13 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 355 ++++++++++-
 14 files changed, 1289 insertions(+), 105 deletions(-)

-- 
2.34.1


