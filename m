Return-Path: <netdev+bounces-292234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBNlN2jCFmrOqgcAu9opvQ
	(envelope-from <netdev+bounces-292234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:07:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 400B45E262C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76D7B30BCD06
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDB13EF673;
	Wed, 27 May 2026 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aZhqoeN9"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA63EE1FE;
	Wed, 27 May 2026 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876011; cv=fail; b=Ot/KNkp0E6fzBx97EpFI9nQcBtvS562R23ACJxA9osUIihxOSl8BHvcIZyepuQ8M1ivNXBktBpJm1quk2nu39JlGIqgjjeBpw7RYw//8bMbEe7xaaIspHHLMV5ggC1kucCKLl1qmJZWjheDcmoszX5gVvN9qRVXD/JY5Uz6RlrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876011; c=relaxed/simple;
	bh=gVZmcrfUmRMQvijKNEXRUe4AGmjssmK5DN7dnIzV87k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iVjuPuCFgEtCclBJfH7gbiAcwbjQCBsyzKVv/sDqVq6+OiYuHhEzaxcegLjyW54pBh1Rljn/oyEOg8RRRxAFZN2Vd8VI5+DFrC260+z1f+CpR/XqaB5VB85xWdRz8gKXlStdlUOxsDondz6IlXeInHoJUBv7u2++ZViT8drSZJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aZhqoeN9; arc=fail smtp.client-ip=52.101.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoqDfg5Mx8PwhaiaW7mEaNoKBrxZF8CjMlD02DLX+MdoaZdIpbcRJpd450/2EuDK7Z8hus/lhn3Iujy9k9hEh1CUAlp0iFh4Iwiku6f/Dh/L6EXYfvmNTfNepO0ubLDmRGdbsFmkBrN9JJRMRMpHBFfk17sh2lodPKICN4SHfQEOojVTRKYeCNDphtxnboeglQaBAMtBN8LZH5zlBo1ksx5Qs5uevg6ZSCXminHZL2clrA9ElpiMxBofP6NsZv7yViQcuzOwfyo8fnhbzhJzpjz9tBdiuzcFUpdTShD4FJkCDCZO+UuaT79F4fxWLZQLjFOs101NZpnEpd0QBtBefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H771QB6IBNIAE5LvmD6+LrCSnnCtMX1uCAR9n81DUlA=;
 b=J9Pbt+KUdOejs//pnn9TYdd9DV9y3Z+/rXogymWWiSl03J8+Odh9AMmfhXAvl8x7zPTWzks56uFdoYHkuMcuAZ2+VF+wv0sha2J7dA2TcAVqNSMrudbMeM7+ExxlKulr4VdRC+d2EMlRU8WsL5n9N8ly1MiAsMTX4lG1x2XIqKaUjhqMTx1utqumEI3FAIolDIIms9bXcDN9e0Ht/YCd9qYnPa3TA6UwDQXPYzypDnVE1qNDosha6GiUBC+kzLg7JNEeHN+G22kdHhRVo8xaC/35BHmMh67aOsgIB3D9CjsiE9AxDYaTKwsxeOz05O/iDvW6LiUXpY3yoRE7XCzulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H771QB6IBNIAE5LvmD6+LrCSnnCtMX1uCAR9n81DUlA=;
 b=aZhqoeN9r4xh++aouB35uvjrp8oKtm0GAktaWgBxTIFs2EBe3IgnErtiwdcjz6lZyuQTLp3b5oBb7+LZmjJoUm1rRfWt6toSFx4PDBv/qtUwTkfXj1/zczelhCXL/DEHNso9QiaC44e80SP1sc3GGl6NYbPUwgcxWN5tw2+zqz8fDs7LshFMhwawfDitY803ZqasxyDaKliQNvEMMvg4jAk9IIBQFnDA+Bz+98ykGfT089pq/EeDUh154CLteSeMwmGcS0aX021q2yc7JLetZjcnuso/Mo9hBIyfte6Bb6WSM54BD8CWj4r8qNNAiY2pJ1RH2Gcg7lrPJ6H2xZZJmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AMBPR04MB12205.eurprd04.prod.outlook.com (2603:10a6:20b:758::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 10:00:00 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 09:59:59 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 7/9] net: dsa: netc: add VLAN filter table and egress treatment management
Date: Wed, 27 May 2026 18:02:15 +0800
Message-Id: <20260527100217.794987-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527100217.794987-1-wei.fang@oss.nxp.com>
References: <20260527100217.794987-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0217.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AMBPR04MB12205:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e38556-8033-4a28-157b-08debbd6b6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	G3PBiW7xMvhd3qDGCvngliBUbmYXiJV+57oLk/BYXWQquv7evR9FiemdSXLiGgBNyOaCBWsuYEOo8AAhgN8lFFhJk7So6BWToH9n3gsqm60jS0ADdrm9RBvu8THs034+FMIj8/KRF+KPDyI9Dbs2jOlVHLYgUXIMJcRkSGCm/7Pyt+NlQ3wlW9CaU3C8gA0BbSAS9jk4EWSyNG39g6KAiX1ctCbntQBTfRe2LVbBB9Yg7mjLeN0eiap+ltao4vE/QpUvJKWOMtHixJBRTZ7A1GzAlJOlkssgwNBiATXuZYCP5QOAUnduB7Cb9UJ9ePfrh4+FUFqZxxI1A9+tBAwUTfcjOOG/XzPxC1YPhAFy0DgNX4cMjbj1ZLyCI53n6Tqbs1T0/RCCaSvIe43CbDMLr0GRqIrMe0Gvg1JrNr8EZvYowbMN+KXhvVn2cLwO2xYr6ScwC5/lmZhrQBEm9yNIHPurALDL8EoY5TWCGo5Ay6+IR5Wk6VmvOSPqHQO41l6OqhTSR8VRZO4CCX5ZE5owLi9InEQ9Z/o4Y9K9Eia8ZCYRQV+MBWdv/2ilidFenbSS/GrCOAvb0Eh3cFD2D2WUsfyqW4ZA7BgdW1gqrnMUnM6yg0FutRG29+HYkde4GjE0Ty6dgqQpsIpDfoG1OXJhBbB7OdHMmUVfbSG+Cvyv/rPRinlRTJ109zEiTT6wp7xuz+4sVFyNNw+2ZcVxoJojFPnvh0FcX+MXdnillvYiZ9E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pbijy/oEdTzMibHSk6hLsppbjpgp6Npai141LoRRKRLHlVHFdqbzAqBwewEU?=
 =?us-ascii?Q?Lemglc3YUSnNMFREjtWF9Z1ju/f9YgWgLZkeY2lfUt3AvmKvDjHcj8M0c16h?=
 =?us-ascii?Q?6ec29qq3chA+mTdxZQMmKZZCc48PQUvSABKitFEwYMP7IRIfyl7cGxD+JfZ5?=
 =?us-ascii?Q?0Lqd2ByttneJGCZKVrI5461UJN7Bt6YygwQGpWT597Y2ND4Do9Agq6nC4Zna?=
 =?us-ascii?Q?Dt15j0atZY6LoT97LbjmYTQU4s9m28dozjb0Qte1NrRy38W9fKmz1ikHZP54?=
 =?us-ascii?Q?O/kSg5KcuGkc6ZX/9G4ZfbC3yHq5jPTEMgF7H+gX3ALFx++GoYM8Uz9CpATB?=
 =?us-ascii?Q?jIUSW2AazPIA7pk8DZm81F2d61vlcyGCF/y+TPAo1vONbGNShyXDiwEDjp1Q?=
 =?us-ascii?Q?XHmfTCQZEPdLSX1QeeCxNsFYtzVU6CT5G4t01AfEj3j4rJ2ZIC1lUNgojrOO?=
 =?us-ascii?Q?b7MLxqa5Mgyx0KqqLwdTJj7+rhry1yWOcnl2hiZtV5rpT/wPT9nuVn8FRjxO?=
 =?us-ascii?Q?ZPXXg1UrfhvYeCqz9xxXF90W7O39DAZbYecSzXQKVZBYj7yoYb4/uaeGNbl2?=
 =?us-ascii?Q?ODeoSASFN1Nl64mzmNliI8hJ3PuaSfG4tNljQtwEM5m3sWfrGpoF6nChkOSs?=
 =?us-ascii?Q?itsNZUFnHvOgrf/EJkatprRmHJYv2CDhTQ9tO8AuQD/oSDJe8dNT872FMZ+d?=
 =?us-ascii?Q?Z4YLUYvKxAIDX0yZzgzEcD5SY1WKxCsmyOSuAUcznTkg1pr0eOTb5SVWUkLT?=
 =?us-ascii?Q?2RzSBOwe5WCrKBVJyD9RFHaOuDbQAdgW7qBCh3ax9m+QFP229YqjFd8r72ua?=
 =?us-ascii?Q?DnGiTdam0EmCPTKboBoyPIGS+mQ7s9xoH7l+bUv8wCxhwMiWQpUpppCuMZ83?=
 =?us-ascii?Q?XuwHzAqo5i4Up5g0XSdRyKwta1NJJsO93qJ3P8fdWSM/9kZE0UZEDOLJYrvR?=
 =?us-ascii?Q?E3d7hXV4lyC9PnAiYlhTyVdBsppHog8yfhBgLcWwfDrd3TpLvu+PuU3JM0sd?=
 =?us-ascii?Q?Hp8HlYydeUGsPJO9/Vw7skKHlL3jQN9mt0AY3zP/0dkECBLNSRoTYNZqTnnB?=
 =?us-ascii?Q?xKN/w8DlWydJxCx+MWJ8X5y8A9jfOHskajssrOO6FyG8eBkhrP0FW4pywhVS?=
 =?us-ascii?Q?N6SSCCcjKzODSxAnxk3MHHMzarHqkUXjT/f5QF21ZsLzPjQjxZpkBwEH2SLf?=
 =?us-ascii?Q?hLjM+lgNJFp8wNjBQcYZ8GRXhbrOvlp3Dr6gy8UHfZEbsnZwXPYb869Hm5bs?=
 =?us-ascii?Q?8BfFMVsZgEb8bRNXnXDkZVngYSh9zWysn5ScDn0VUxAE3Uh4R1NcbTnoJZOI?=
 =?us-ascii?Q?AChu7AQXn+d0JCg0CwLudGmG/V03EhYZTTX6e5c68u9cXbNF4Q1aVEYODbn/?=
 =?us-ascii?Q?vk4gT9Oy1sAelLEwTYvbelrYHvmsS9lkYWu2YRSXVTl8J975OF4bDNogeNQ2?=
 =?us-ascii?Q?wMuQXW5sC4hWQA+LUD2v+9nWKU+ULIyIrOGeTCzboNwiF2Y5ODn+EyDBAa9o?=
 =?us-ascii?Q?J4rWbnPjNLGK4uzUh6ZoT331cKiI+rizBh86c1IViZftqMBz49vEfn+KGiri?=
 =?us-ascii?Q?Ei55znHj3/jHdKmmJ7Vua1kamLg14E3OKZdNtqudOCug7bbX8WnHbIRkJv71?=
 =?us-ascii?Q?37EpbUszULSaPcFAXfTkJRimkp/uemXBxq+SHebdALNOYrHkqA1gY27qnkmG?=
 =?us-ascii?Q?W0YBFvMdI2xr34qCIS4UOONKX7ouCvFkMMnoJO2N73Iam88svB6toGBU5Mgm?=
 =?us-ascii?Q?gte9zIAO7fKshdoyRSWxIspf2IZ3Wb5jsZbJxMH7gDwAKiGMnCE4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e38556-8033-4a28-157b-08debbd6b6b3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 09:59:59.8752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KC/jzYsv4XNeTpnGzWrLgerGqEssOoe8dNJjoR2Qw385kWHhZrrTa2OoSSm4Uw9prWIc3vDVn+uMuD0SNCDRERRSXXYbOAYE21kFiYGsvgOOGVs/vZXjR690cpPz1m+t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12205
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292234-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.984];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 400B45E262C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wei Fang <wei.fang@nxp.com>

Implement the DSA .port_vlan_add and .port_vlan_del operations to
enable VLAN-aware bridge offloading on the NETC switch.

VLAN membership is maintained in the VLAN Filter Table (VFT). Adding
the first port to a VLAN creates a new VFT entry with hardware MAC
learning and flood-on-miss forwarding; subsequent ports update the
existing entry's membership bitmap. Removing the last port deletes
the entry.

Egress tagging is handled through the Egress Treatment Table (ETT).
Each VLAN is allocated a group of ETT entries, one per available port.
Ports are assigned a sequential ett_offset during initialisation, used
to address each port's entry within the group. Untagged ports configure
the ETT to strip the outer VLAN tag; tagged ports pass frames through
unmodified. Each ETT group is optionally paired with an Egress Counter
Table (ECT) group for per-port frame counting, allocated on a
best-effort basis.

A software shadow list serialised by vft_lock tracks active VLAN state
across both port membership and egress tagging. VID 0 is used for single
port mode and is ignored by both callbacks.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 423 +++++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h |  24 ++
 include/linux/fsl/ntmp.h           |  15 +
 3 files changed, 462 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index d4475ad7ed6c..4db42c888470 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -37,6 +37,27 @@ static void netc_destroy_fdb_list(struct netc_switch *priv)
 		netc_del_fdb_entry(entry);
 }
 
+static struct netc_vlan_entry *
+netc_lookup_vlan_entry(struct netc_switch *priv, u16 vid)
+{
+	struct netc_vlan_entry *entry;
+
+	hlist_for_each_entry(entry, &priv->vlan_list, node)
+		if (entry->vid == vid)
+			return entry;
+
+	return NULL;
+}
+
+static void netc_destroy_vlan_list(struct netc_switch *priv)
+{
+	struct netc_vlan_entry *entry;
+	struct hlist_node *tmp;
+
+	hlist_for_each_entry_safe(entry, tmp, &priv->vlan_list, node)
+		netc_del_vlan_entry(entry);
+}
+
 static enum dsa_tag_protocol
 netc_get_tag_protocol(struct dsa_switch *ds, int port,
 		      enum dsa_tag_protocol mprot)
@@ -222,6 +243,7 @@ static int netc_init_all_ports(struct netc_switch *priv)
 	struct device *dev = priv->dev;
 	struct netc_port *np;
 	struct dsa_port *dp;
+	int ett_offset = 0;
 	int err;
 
 	priv->ports = devm_kcalloc(dev, priv->info->num_ports,
@@ -251,6 +273,8 @@ static int netc_init_all_ports(struct netc_switch *priv)
 	dsa_switch_for_each_available_port(dp, priv->ds) {
 		np = priv->ports[dp->index];
 		np->dp = dp;
+		np->ett_offset = ett_offset++;
+		priv->port_bitmap |= BIT(dp->index);
 
 		err = netc_port_get_info_from_dt(np, dp->dn, dev);
 		if (err)
@@ -831,6 +855,8 @@ static int netc_setup(struct dsa_switch *ds)
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
+	INIT_HLIST_HEAD(&priv->vlan_list);
+	mutex_init(&priv->vft_lock);
 
 	netc_switch_fixed_config(priv);
 
@@ -858,6 +884,7 @@ static int netc_setup(struct dsa_switch *ds)
 	 * hardware state.
 	 */
 	mutex_destroy(&priv->fdbt_lock);
+	mutex_destroy(&priv->vft_lock);
 	netc_free_ntmp_user(priv);
 
 	return err;
@@ -867,6 +894,8 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
 {
 	netc_destroy_fdb_list(priv);
 	mutex_destroy(&priv->fdbt_lock);
+	netc_destroy_vlan_list(priv);
+	mutex_destroy(&priv->vft_lock);
 }
 
 static void netc_free_host_flood_rules(struct netc_switch *priv)
@@ -1025,6 +1054,369 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
 	priv->revision = FIELD_GET(IPBRR0_IP_REV, val);
 }
 
+static int netc_add_or_update_ett_entry(struct netc_switch *priv,
+					bool add, bool untagged,
+					u32 ett_eid, u32 ect_eid)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+	u32 vuda_sqta = FMTEID_VUDA_SQTA;
+	struct ett_cfge_data cfge = {};
+	u16 efm_cfg = 0;
+
+	if (ect_eid != NTMP_NULL_ENTRY_ID) {
+		/* Increase egress frame counter */
+		efm_cfg |= FIELD_PREP(ETT_ECA, ETT_ECA_INC);
+		cfge.ec_eid = cpu_to_le32(ect_eid);
+	}
+
+	/* If egress rule is VLAN untagged */
+	if (untagged) {
+		/* delete outer VLAN tag */
+		vuda_sqta |= FIELD_PREP(FMTEID_VUDA, FMTEID_VUDA_DEL_OTAG);
+		/* length change: twos-complement notation */
+		efm_cfg |= FIELD_PREP(ETT_EFM_LEN_CHANGE,
+				      ETT_FRM_LEN_DEL_VLAN);
+	}
+
+	cfge.efm_eid = cpu_to_le32(vuda_sqta);
+	cfge.efm_cfg = cpu_to_le16(efm_cfg);
+
+	return ntmp_ett_add_or_update_entry(ntmp, ett_eid, add, &cfge);
+}
+
+static int netc_add_ett_group_entries(struct netc_switch *priv,
+				      u32 untagged_port_bitmap,
+				      u32 ett_base_eid,
+				      u32 ect_base_eid)
+{
+	struct netc_port **ports = priv->ports;
+	u32 ett_eid, ect_eid;
+	bool untagged;
+	int i, err;
+
+	for (i = 0; i < priv->info->num_ports; i++) {
+		if (!ports[i]->dp)
+			continue;
+
+		untagged = !!(untagged_port_bitmap & BIT(i));
+		ett_eid = ett_base_eid + ports[i]->ett_offset;
+		ect_eid = NTMP_NULL_ENTRY_ID;
+		if (ect_base_eid != NTMP_NULL_ENTRY_ID)
+			ect_eid = ect_base_eid + ports[i]->ett_offset;
+
+		err = netc_add_or_update_ett_entry(priv, true, untagged,
+						   ett_eid, ect_eid);
+		if (err)
+			goto clear_ett_entries;
+	}
+
+	return 0;
+
+clear_ett_entries:
+	while (--i >= 0) {
+		if (!ports[i]->dp)
+			continue;
+
+		ett_eid = ett_base_eid + ports[i]->ett_offset;
+		ntmp_ett_delete_entry(&priv->ntmp, ett_eid);
+	}
+
+	return err;
+}
+
+static int netc_add_vlan_egress_rule(struct netc_switch *priv,
+				     struct netc_vlan_entry *entry)
+{
+	u32 num_ports = netc_num_available_ports(priv);
+	struct ntmp_user *ntmp = &priv->ntmp;
+	u32 ect_eid = NTMP_NULL_ENTRY_ID;
+	u32 ett_eid, ett_gid, ect_gid;
+	int err;
+
+	/* Step 1: Find available egress counter table entries and update
+	 * these entries.
+	 */
+	ect_gid = ntmp_lookup_free_eid(ntmp->ect_gid_bitmap,
+				       ntmp->ect_bitmap_size);
+	if (ect_gid == NTMP_NULL_ENTRY_ID) {
+		dev_info(priv->dev,
+			 "No egress counter table entries available\n");
+	} else {
+		ect_eid = ect_gid * num_ports;
+		for (int i = 0; i < num_ports; i++)
+			/* Reset the counters of the entry. There is no need
+			 * to check the return value, the only issue is that
+			 * the entry's counter might be inaccurate, but it
+			 * will not affect the functionality.
+			 */
+			ntmp_ect_update_entry(ntmp, ect_eid + i);
+	}
+
+	/* Step 2: Find available egress treatment table entries and add
+	 * these entries.
+	 */
+	ett_gid = ntmp_lookup_free_eid(ntmp->ett_gid_bitmap,
+				       ntmp->ett_bitmap_size);
+	if (ett_gid == NTMP_NULL_ENTRY_ID) {
+		dev_err(priv->dev,
+			"No egress treatment table entries available\n");
+		err = -ENOSPC;
+		goto clear_ect_gid;
+	}
+
+	ett_eid = ett_gid * num_ports;
+	err = netc_add_ett_group_entries(priv, entry->untagged_port_bitmap,
+					 ett_eid, ect_eid);
+	if (err)
+		goto clear_ett_gid;
+
+	entry->cfge.et_eid = cpu_to_le32(ett_eid);
+	entry->ect_gid = ect_gid;
+
+	return 0;
+
+clear_ett_gid:
+	ntmp_clear_eid_bitmap(ntmp->ett_gid_bitmap, ett_gid);
+
+clear_ect_gid:
+	if (ect_gid != NTMP_NULL_ENTRY_ID)
+		ntmp_clear_eid_bitmap(ntmp->ect_gid_bitmap, ect_gid);
+
+	return err;
+}
+
+static void netc_delete_vlan_egress_rule(struct netc_switch *priv,
+					 struct netc_vlan_entry *entry)
+{
+	u32 num_ports = netc_num_available_ports(priv);
+	struct ntmp_user *ntmp = &priv->ntmp;
+	u32 ett_eid, ett_gid;
+
+	ett_eid = le32_to_cpu(entry->cfge.et_eid);
+	if (ett_eid == NTMP_NULL_ENTRY_ID)
+		return;
+
+	ett_gid = ett_eid / num_ports;
+	ntmp_clear_eid_bitmap(ntmp->ett_gid_bitmap, ett_gid);
+	for (int i = 0; i < num_ports; i++)
+		ntmp_ett_delete_entry(ntmp, ett_eid + i);
+
+	if (entry->ect_gid == NTMP_NULL_ENTRY_ID)
+		return;
+
+	ntmp_clear_eid_bitmap(ntmp->ect_gid_bitmap, entry->ect_gid);
+}
+
+static int netc_port_update_vlan_egress_rule(struct netc_port *np,
+					     struct netc_vlan_entry *entry)
+{
+	bool untagged = !!(entry->untagged_port_bitmap & BIT(np->dp->index));
+	u32 num_ports = netc_num_available_ports(np->switch_priv);
+	u32 ett_eid = le32_to_cpu(entry->cfge.et_eid);
+	struct netc_switch *priv = np->switch_priv;
+	u32 ect_eid = NTMP_NULL_ENTRY_ID;
+	int err;
+
+	if (ett_eid == NTMP_NULL_ENTRY_ID)
+		return 0;
+
+	if (entry->ect_gid != NTMP_NULL_ENTRY_ID) {
+		/* Each ETT entry maps to an ECT entry if ect_gid is not NULL
+		 * entry ID. The offset of the ECT entry corresponding to the
+		 * port in the group is equal to ett_offset.
+		 */
+		ect_eid = entry->ect_gid * num_ports + np->ett_offset;
+		ntmp_ect_update_entry(&priv->ntmp, ect_eid);
+	}
+
+	ett_eid += np->ett_offset;
+	err = netc_add_or_update_ett_entry(priv, false, untagged,
+					   ett_eid, ect_eid);
+	if (err)
+		dev_err(priv->dev,
+			"Failed to update VLAN %u egress rule on port %d\n",
+			entry->vid, np->dp->index);
+
+	return err;
+}
+
+static int netc_port_add_vlan_entry(struct netc_port *np, u16 vid,
+				    bool untagged)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_vlan_entry *entry;
+	struct vft_cfge_data *cfge;
+	u32 index = np->dp->index;
+	u32 bitmap_stg;
+	int err;
+	u16 cfg;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->vid = vid;
+	entry->ect_gid = NTMP_NULL_ENTRY_ID;
+
+	bitmap_stg = BIT(index) | VFT_STG_ID(0);
+	cfg = FIELD_PREP(VFT_MLO, MLO_HW) |
+	      FIELD_PREP(VFT_MFO, MFO_NO_MATCH_FLOOD);
+
+	cfge = &entry->cfge;
+	cfge->et_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	cfge->bitmap_stg = cpu_to_le32(bitmap_stg);
+	cfge->fid = cpu_to_le16(vid);
+	cfge->cfg = cpu_to_le16(cfg);
+	cfge->eta_port_bitmap = cpu_to_le32(priv->port_bitmap);
+
+	if (untagged)
+		entry->untagged_port_bitmap = BIT(index);
+
+	err = netc_add_vlan_egress_rule(priv, entry);
+	if (err)
+		goto free_vlan_entry;
+
+	err = ntmp_vft_add_entry(&priv->ntmp, vid, cfge);
+	if (err) {
+		dev_err(priv->dev,
+			"Failed to add VLAN %u entry on port %d\n",
+			vid, index);
+		goto delete_vlan_egress_rule;
+	}
+
+	netc_add_vlan_entry(priv, entry);
+
+	return 0;
+
+delete_vlan_egress_rule:
+	netc_delete_vlan_egress_rule(priv, entry);
+free_vlan_entry:
+	kfree(entry);
+
+	return err;
+}
+
+static bool netc_port_vlan_egress_rule_changed(struct netc_vlan_entry *entry,
+					       int port, bool untagged)
+{
+	bool old_untagged = !!(entry->untagged_port_bitmap & BIT(port));
+
+	return old_untagged != untagged;
+}
+
+static int netc_port_set_vlan_entry(struct netc_port *np, u16 vid,
+				    bool untagged)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_vlan_entry *entry;
+	struct vft_cfge_data *cfge;
+	int port = np->dp->index;
+	bool changed;
+	int err = 0;
+
+	mutex_lock(&priv->vft_lock);
+
+	entry = netc_lookup_vlan_entry(priv, vid);
+	if (!entry) {
+		err = netc_port_add_vlan_entry(np, vid, untagged);
+		goto unlock_vft;
+	}
+
+	/* Check whether the egress VLAN rule is changed */
+	changed = netc_port_vlan_egress_rule_changed(entry, port, untagged);
+	if (changed) {
+		entry->untagged_port_bitmap ^= BIT(port);
+		err = netc_port_update_vlan_egress_rule(np, entry);
+		if (err) {
+			entry->untagged_port_bitmap ^= BIT(port);
+			goto unlock_vft;
+		}
+	}
+
+	cfge = &entry->cfge;
+	if (cfge->bitmap_stg & cpu_to_le32(BIT(port)))
+		goto unlock_vft;
+
+	cfge->bitmap_stg |= cpu_to_le32(BIT(port));
+	err = ntmp_vft_update_entry(&priv->ntmp, vid, cfge);
+	if (err) {
+		dev_err(priv->dev,
+			"Failed to update VLAN %u entry on port %d\n",
+			vid, port);
+
+		goto restore_bitmap_stg;
+	}
+
+	mutex_unlock(&priv->vft_lock);
+
+	return 0;
+
+restore_bitmap_stg:
+	cfge->bitmap_stg &= cpu_to_le32(~BIT(port));
+	if (changed) {
+		entry->untagged_port_bitmap ^= BIT(port);
+		/* Recover the corresponding ETT entry. It doesn't matter
+		 * if it fails because the bit corresponding to the port
+		 * in the port bitmap of the VFT entry is not set. so the
+		 * frame will not match that ETT entry.
+		 */
+		if (netc_port_update_vlan_egress_rule(np, entry))
+			entry->untagged_port_bitmap ^= BIT(port);
+	}
+unlock_vft:
+	mutex_unlock(&priv->vft_lock);
+
+	return err;
+}
+
+static int netc_port_del_vlan_entry(struct netc_port *np, u16 vid)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_vlan_entry *entry;
+	struct vft_cfge_data *cfge;
+	int port = np->dp->index;
+	u32 vlan_port_bitmap;
+	int err = 0;
+
+	mutex_lock(&priv->vft_lock);
+
+	entry = netc_lookup_vlan_entry(priv, vid);
+	if (!entry)
+		goto unlock_vft;
+
+	cfge = &entry->cfge;
+	vlan_port_bitmap = FIELD_GET(VFT_PORT_MEMBERSHIP,
+				     le32_to_cpu(cfge->bitmap_stg));
+	/* If the VLAN only belongs to the current port */
+	if (vlan_port_bitmap == BIT(port)) {
+		err = ntmp_vft_delete_entry(&priv->ntmp, vid);
+		if (err)
+			goto unlock_vft;
+
+		netc_delete_vlan_egress_rule(priv, entry);
+		netc_del_vlan_entry(entry);
+
+		goto unlock_vft;
+	}
+
+	if (!(vlan_port_bitmap & BIT(port)))
+		goto unlock_vft;
+
+	cfge->bitmap_stg &= cpu_to_le32(~BIT(port));
+	err = ntmp_vft_update_entry(&priv->ntmp, vid, cfge);
+	if (err) {
+		cfge->bitmap_stg |= cpu_to_le32(BIT(port));
+		goto unlock_vft;
+	}
+
+	entry->untagged_port_bitmap &= ~BIT(port);
+
+unlock_vft:
+	mutex_unlock(&priv->vft_lock);
+
+	return err;
+}
+
 static int netc_port_enable(struct dsa_switch *ds, int port,
 			    struct phy_device *phy)
 {
@@ -1297,6 +1689,35 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	netc_port_remove_host_flood(np, old_host_flood);
 }
 
+static int netc_port_vlan_add(struct dsa_switch *ds, int port,
+			      const struct switchdev_obj_port_vlan *vlan,
+			      struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	bool untagged;
+
+	/* The 8021q layer may attempt to change NETC_STANDALONE_PVID
+	 * (VID 0), so we need to ignore it.
+	 */
+	if (vlan->vid == NETC_STANDALONE_PVID)
+		return 0;
+
+	untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+
+	return netc_port_set_vlan_entry(np, vlan->vid, untagged);
+}
+
+static int netc_port_vlan_del(struct dsa_switch *ds, int port,
+			      const struct switchdev_obj_port_vlan *vlan)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	if (vlan->vid == NETC_STANDALONE_PVID)
+		return 0;
+
+	return netc_port_del_vlan_entry(np, vlan->vid);
+}
+
 static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
 				  struct phylink_config *config)
 {
@@ -1575,6 +1996,8 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_mdb_add			= netc_port_mdb_add,
 	.port_mdb_del			= netc_port_mdb_del,
 	.port_set_host_flood		= netc_port_set_host_flood,
+	.port_vlan_add			= netc_port_vlan_add,
+	.port_vlan_del			= netc_port_vlan_del,
 	.get_pause_stats		= netc_port_get_pause_stats,
 	.get_rmon_stats			= netc_port_get_rmon_stats,
 	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 4fbd12825b67..9ff334301fbc 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -74,6 +74,7 @@ struct netc_port {
 	struct dsa_port *dp;
 	struct clk *ref_clk; /* RGMII/RMII reference clock */
 	struct mii_bus *emdio;
+	int ett_offset;
 
 	u16 enable:1;
 	u16 uc:1;
@@ -94,6 +95,14 @@ struct netc_fdb_entry {
 	struct hlist_node node;
 };
 
+struct netc_vlan_entry {
+	u16 vid;
+	u32 ect_gid;
+	u32 untagged_port_bitmap;
+	struct vft_cfge_data cfge;
+	struct hlist_node node;
+};
+
 struct netc_port_stat {
 	int reg;
 	char name[ETH_GSTRING_LEN] __nonstring;
@@ -108,10 +117,13 @@ struct netc_switch {
 	const struct netc_switch_info *info;
 	struct netc_switch_regs regs;
 	struct netc_port **ports;
+	u32 port_bitmap; /* bitmap of available ports */
 
 	struct ntmp_user ntmp;
 	struct hlist_head fdb_list;
 	struct mutex fdbt_lock; /* FDB table lock */
+	struct hlist_head vlan_list;
+	struct mutex vft_lock; /* VLAN filter table lock */
 
 	/* Switch hardware capabilities */
 	u32 htmcapr_num_words;
@@ -153,6 +165,18 @@ static inline void netc_del_fdb_entry(struct netc_fdb_entry *entry)
 	kfree(entry);
 }
 
+static inline void netc_add_vlan_entry(struct netc_switch *priv,
+				       struct netc_vlan_entry *entry)
+{
+	hlist_add_head(&entry->node, &priv->vlan_list);
+}
+
+static inline void netc_del_vlan_entry(struct netc_vlan_entry *entry)
+{
+	hlist_del(&entry->node);
+	kfree(entry);
+}
+
 int netc_switch_platform_probe(struct netc_switch *priv);
 
 /* ethtool APIs */
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index a678f1e1ee42..7677e7151fd9 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -267,6 +267,21 @@ struct bpt_cfge_data {
 	__le32 fc_ports;
 };
 
+union ntmp_fmt_eid {
+	__le32 index;
+#define	FMTEID_INDEX		GENMASK(12, 0)
+	__le32 vuda_sqta;
+#define FMTEID_VUDA		GENMASK(1, 0)
+#define FMTEID_VUDA_DEL_OTAG	2
+#define FMTEID_SQTA		GENMASK(4, 2)
+#define FMTEID_SQTA_DEL		2
+#define FMTEID_VUDA_SQTA	BIT(13)
+	__le32 vara_vid;
+#define FMTEID_VID		GENMASK(11, 0)
+#define FMTEID_VARA		GENMASK(13, 12)
+#define FMTEID_VARA_VID		BIT(14)
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
-- 
2.34.1


