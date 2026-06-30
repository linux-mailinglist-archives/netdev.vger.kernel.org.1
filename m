Return-Path: <netdev+bounces-303019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Y93KTN1Q2oUYwoAu9opvQ
	(envelope-from <netdev+bounces-303019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:50:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCCA6E1626
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:50:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=HncSFShO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303019-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303019-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E26F73028E7B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220943E867A;
	Tue, 30 Jun 2026 07:49:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252BD3E6DF5;
	Tue, 30 Jun 2026 07:49:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805752; cv=fail; b=OeKw+KtasJYr1cylx55tjS/+mYUMZ+GkztPnryoSurNkKVtaNJNdWLBxPP2aZs3q4MVJxhwCVJZOpZJS5VwmFcxcC07UWC9AthhPTC0eu40U61CNb1KxgE5h5YecQNx9l7/dRi0b/5yONuj/Ov72hFgdOGi++Zx0MsJovFV3pL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805752; c=relaxed/simple;
	bh=Uu/FsTOSg4zMHV9RFjw9OUszYGNTUQo39EWNqwYNKaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CCHuUueEf4S3QjV5iNuKm1uow2MTQQQJk66kWCTgjlZs+EpVvcJgFu2G1JO5MVF+XvOlnTVFEQXn+6NFCV/uzO9mmoj55UBRpALBQpLaiVDpLVpeBugpi74z9/pRt4JYw8r2ufZ/se0bmIAXtRJmtR65BMj8prjHIF6s0DOgQl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HncSFShO; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nx7xwsS9XgwYodNeQLgdRRwCoaZ24yvhebHP+AMXUqS3b6ZUpiDWIoIXeCt3DUlLrJXunynDQD966bH0MkW+rJTvj39SHl6ISiHraHVDuLDapHd610Fj2ZInhzOXEex2aljejB4Ddy7zyHBz6bHe7+k04uwgLxINGZMKa29CyJ6Qb2/gLSSWh3zeAWLkXCF+Tl3m9HqQyoLA5fGPpdtqopyt64W2vThmCbA/neHsczoph9Uq+jRoeiWsvj8sSOC1gc+4uB8uKkPQaTPsEIm53vsTpku32kF65iN3gITrZfzeDCJfibPgpplLTz6+32LD2xbcmpLoc2vOucYb7VN4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6uEoZVelqqiPHG5MINFGev4roHy4M8lixp1YqZumD0=;
 b=sxjuWv3ejZNq33zLbb6jpSjHFEy1+ij9Bh6nDDzVLXX4oyPx5jc/pOl2M9ycVi7BopbMhkHBkewXtJ1cargic/j5CsoOgDZurlwWL3JPQj5NPLR9THlj6Dj7UPImDXuwMPvjPA+3nlqXmIeQlve+1l2bl+0c5HN0ks1dXVQyRLE57HUWyZ+OeIlBBYSbLKVUmSJG82uIyoexWAf2dZHhXO9tWj7bxAV8ltugumMyXWeDidb51ybDBk+lsG/B6/H81IhuFQ1+cP3L88F4Syw3XaRJVazSjASVRz3VqlTFo1k+aC8K14KvgrCFIDMNQUrk8iPAsj0QYyS1ND5OWKBl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6uEoZVelqqiPHG5MINFGev4roHy4M8lixp1YqZumD0=;
 b=HncSFShOEA9WQwLDpXu0HJowlZ+n8R4oDygeGHkuifAYp5uEyTsEVj7ctesYPnqpt3mqifxa7oNdRPijtQy5UT8USHdBlG79oiLxaIdzY8kXOm+fblDKRopBYZbP05fA+l2cgOBNgIv9UeZTPSeB2/NWbXaSyca9xHDueeP7giYIjEvB8Qpwrqlbbe6SxCc7k6DOkn6F2MJyWQjcE8cUa309hyB5hXCyutFyxSF9EX9SViu2az9GU8YY25XwlcYJkdcdM9dA5vbCvyNSOfQ+zgygtuptsg+t4pX7IoCeyEGZNzlhRxbOUFuzOpdKYdJwpj1fwh0Fn5gYN8ANJ12vaw==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:49:04 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:49:04 +0000
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
Subject: [PATCH net-next 05/14] net: enetc: use PCI device name for debugfs directory
Date: Tue, 30 Jun 2026 15:20:27 +0800
Message-Id: <20260630072036.382761-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) To
 VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db379c4-79ac-433e-a3ea-08ded67c0ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|19092799006|1800799024|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	Okqh6EjoqGG0AoMDanD9AK7RmKA1gawby+5oXJTRIPooPU4vKIf2nXYkE/B9akyvgoGYNUym2i/zB60lRKjWS3ZiUpGqUcWqFHuDeQomSlbGqwuPvJfLaQcWNuHbrmdgvDs5No1VsZdMNqoKfuYesUVTMwFx5lhO/uKGmSF07uLYy4Oub65BEtyF5woozQHF1CQIbMRTAlBDwOa8q41Acsb9LmkLZnZPTiPciUXysCGjVcQ9x9k7Ik76ohGVgc0IP5YkqvuCWLCPXOCwOX4aI+IH9OxhCfWafoKa5pxMOLPXI6YTJBFlEMaL4luIBelWLoQXTA0U6N8ma3FYdYr4fInnCsfyscZEuAcX0SosN7jGDD24i/PbHwmC8/M8cSDwpxym6EHjwfF9xaQZttSSbAuFCknR18HZXlwYtKG6RA9LSWrpeDbnFDvcyvPcQ22sb6tEO08nD00JTIza0k3NO4AzSZoGckXS8mOZlMVPssfs2Nwf9J0SDPFNJaV0bsEiZEv+5JnCXuLydhqTjmf33sWdG15tWXrKGm9hk29O9L6IV3KYOEftGRnPITv97YlztSs5f8wEzYMOSDKqdXQ+jDuclHvWEY+Sci2/yZBp1A9QG+9QoSnhFRNJfCJWngHbMYbN5xya9S+qCpE/vOg3EakPWYs6iYneKd4MEl4DWXTHhEGe8sDubRYFhTITz/PV+e83YAzVAsDNBoP3YlLXkg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8r1m9+mjypqs82vleyQM+m8HnraJXxIWccRHx3RpG0TV9PPtbUkERNMCpRsb?=
 =?us-ascii?Q?O+3e3r5CjjKi+keyAokeII6SFJXiFw0NfCWFCoKzlQw/3PKMxCZsvnQnF/fs?=
 =?us-ascii?Q?xhWPl+KkjvNvC/2tFmMFe9+JlC90Lac/erN2ssUpGYnixUTP4uJ+zbK3+xD3?=
 =?us-ascii?Q?yEEJmpSbuv2T/la4Or7iHR7MuJk9z2mvv9ij1mhK+RVzYJca4zyZmQ7azIZs?=
 =?us-ascii?Q?ajMZmMsBXbyyQb3nD4VVpoPA1u+wBgG+nJIliKisoXabR/kG3K30q+KK+3SK?=
 =?us-ascii?Q?+78wVi/PHuAqVsQ7ZMovCvteaijbBMntsx4fih/TGXzkWs49KCcWTY8S3Na1?=
 =?us-ascii?Q?tKwpCbJz73frUw7xidnJcUHwW1cWLPe1w5BIiENN3Tr06MlJ4cAlnX2UHsfm?=
 =?us-ascii?Q?pjYPj2ZXuYCdje2GBQGiWtvC9+AvYgrshUl1VZuT6qIbsa+iNi41XateCM1e?=
 =?us-ascii?Q?RpsS3I1AQB1FtnCvLgg3hhqtWIcYQhfyKyJgvTUjE755IhxouEqSZfwsnXnk?=
 =?us-ascii?Q?+5M4m5HDb8BAFHo1utB9RTQO5bb5ET1L+0RQxkUsKAohtugxnssWrHb/fkg3?=
 =?us-ascii?Q?e33HcpZsXrmu7RP/Bj+BMMqq+ihDxsq20M/epD5+64XZXnWzyRFtxqh5usuQ?=
 =?us-ascii?Q?HcYlENdQfLn3kFl+9CxyYyWnwd44Yu54yMT0lGUIxTelhuJcJ2zGmsOdJ8fp?=
 =?us-ascii?Q?5mUX3sMQ8JPJ36S3no9LwDX06TlxFLJ0ftU937EaeI0SM+QB9wcN+LzgwpZn?=
 =?us-ascii?Q?vSvkmg5xBZpiCkvFy9yb/KR9wd5h6FrJR4AOmf0RXTZrqH1e/MjOywtbsVUV?=
 =?us-ascii?Q?AmLfNrxDZRgCB0uFpRM6FrZycmZqwKJsNAf2ZHhl7hu2nUi3JguMCTopo9Vw?=
 =?us-ascii?Q?VN7dTwS+n+EedWf+RU4AORsicljwptO7RIWsjTIHuxeJ1iZKFw4/YADCI9NZ?=
 =?us-ascii?Q?UNwCimyiNNAFypYoXCBq8NZtem9T81yNmdyZRMXnQgMxDSrjdgpbNG2qKsJR?=
 =?us-ascii?Q?6vWtaAm6ZOa6HqlVmik5OZMMIKCzAMt/QL7SZly4vYvCKrrb8qp2JnllhPrE?=
 =?us-ascii?Q?PE9998Wbdcbnr3uYv5s2+AuUGVPLF4b4sQTCSObVTorJxkk3/FQziZTFI/Mv?=
 =?us-ascii?Q?MWXWTN8oWuALgxIPfMf9zg8AimdHjYuR1vRj2OlE2yz4PahOxHlWgl+malYO?=
 =?us-ascii?Q?g4BuQutnNQXE3rogUgkQ6ijloZ1oECZDaGmJGf9XyE/5zBEvuE5DQAQ8G5l8?=
 =?us-ascii?Q?YNS4j6fghzjJuZLJmuVr7B9VRIjkvK6queeFjDc6gP6z8M8c3h6WWQqZkgND?=
 =?us-ascii?Q?R9Y/8fmDMkXrf+4tivREm5npldvL8IbVlsHrYQ9ht0wQuqxfMw76tbqr53P7?=
 =?us-ascii?Q?1M3XHWCs6K0h2jrU5wdBApg2+uy7VhS1KoncFtKmqlceozNCYz1BcPPeQbya?=
 =?us-ascii?Q?/69ChTfwr/LPQ4kt6l7XOfp/89VXayHThB6vJqWMGGgVGviPXk5sUel7vsX9?=
 =?us-ascii?Q?O0kNJ8L4UjQeW7sp1aoAw5I456rwleJRT1m+gBtWJccAvokd1krm2RSaHTxd?=
 =?us-ascii?Q?s5U5ZTRqWgwbvM6U1l0WdnWpyN0zyN2nO6gaKQPFKjBgG25HSOuPN9kXVKAk?=
 =?us-ascii?Q?IvsPF32mndq2SZyVDNcCEYb9YaqRmFr4GojtM/XhZ54Oj1XHBNqQ5GTIjgU7?=
 =?us-ascii?Q?0eSWfHK2wi6FnxWxdGYj0PVKshSiqPWIWxkcpo52XYCyMKCRUvtg9wyLl9em?=
 =?us-ascii?Q?TAv735jhtVB4AFB8kJOqHQXHQjwrdNaP/e8CDccs/WMW1B1CIAt/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db379c4-79ac-433e-a3ea-08ded67c0ec0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:49:04.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Udkp7GXXSvc8aFFUEur2ThNvbfQCTpnT7wlL5tXDztLmY6Bxe17/L0hs9DBsFMxTB6LcEuyf6CGWeqQb3Fndx5lpFlazBjqw88W0HaZ8Qmp1mf/Ounnsyuid9WUxLjI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303019-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,NXP1.onmicrosoft.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DCCA6E1626

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


