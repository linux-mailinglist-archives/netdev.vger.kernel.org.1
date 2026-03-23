Return-Path: <netdev+bounces-270496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHEjNCgpwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:51:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7963A2F1761
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 538AB300D4D6
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6617D39BFF8;
	Mon, 23 Mar 2026 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xrs5nD0z"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DDD39B96F;
	Mon, 23 Mar 2026 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266654; cv=fail; b=YpS8Hc6o3pdJgv7cIUEf8GMN/zClWvArcM2VdDvqrD7YlgsiLxoEVI9P+85JDM4mjnEHyfyVWtTXEUshRAxfiHIbvThNyHAXSV+u6Oql/JDyqmNn034OsrPigD783y5zEeKfAitOot1se17uhGWrXyS2Ifchluh1N3j+mxXjF7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266654; c=relaxed/simple;
	bh=0/1hqXoQ6pMrmkM1991wDmGKnfABCwf1mcHJSPu6mbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XOZD2nJkGoTDJIVU6r+l/miENIVX5DtBw0gD1Xc+8oHaeLukDwx2MEcgIVojXel0pedZ79EI5WH2ENhFjyYIiERVkFNxzXidThghbpregao+M5/Db2M4CBGxzdvMN0v5UMtOVCfgQnBuR92Z74ZQK8uEN0weYYnioA0hHB3dQAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xrs5nD0z; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHOw+CvLUNfq+NeA2JtUI01YCHHfP3jG+nkFoPTmXY3qenK5uTCuI+imvPnXvPApIu1O98tyMB+MtaxuxlkLcuABVIpJtwtthpw8vsQmwpX3N2RVIeY6oBc2E0THHEGpJB/i93b9r0Tn4MmizreQhV+vbx/Tj0vcxJcpUTmwjGOIandswRtGJ+Ib5YDMc9qrklo0HqEKL1iRmXRfk9FPfMB1IVEIno1Hrqny1J8S7giGnQmlHNMOPzJFviZoRmpSAm9uo3MIjZxqRbwvqiI6bV+5J7/MvEEAllil1HaaGdTv3fd5yKO+EZRHXqLRSnZn039Xt3Ygand4AHp1AI9jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ye5A91M5Yd/9W8GauM53gChZcyrPkzPAwIZMFzP+/6o=;
 b=b82vIO02G1qYZI9wI3yTvES/f2I0BVJf5jL3lYffwYMQ2ysr0clBkclMB67DS4lfBLSqiueD36dzG8r0RzDpFz59VCIq8805nubg+POPXd1URRCYkQBLg607UTcgUCHXoJwpsWQTGeyMhHhU05TcxIItnXgKKK4EVw+vDoe7zKvSm+NqCWknVIWGWx1bmIzY9CfPeVai6SQJOUMcmopW+fqKckS9/wPW6SBH6UjZFP6t+EmJZHyRKq4ftiGiEjOPM+4qEGjpA7dNoQEZO5+KdNfjbkzjMZrYS6la3eKcLIcJNqwDWM6MlOqFOyfgtQb5ZhaevIcHwPVofHenVjPtUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ye5A91M5Yd/9W8GauM53gChZcyrPkzPAwIZMFzP+/6o=;
 b=Xrs5nD0zfv7V39UbCW7xwPcnDfvUplm4wShrjiLw82efkLbQCFCPElV7zz9bb53gyOOuRr1wTgwNJ0LFhPwXYO7Rmr1uUblv15d26WaLXvbgFmpcXpmOiJ4E7qnzSglBlGPge4tykS/zTrzt95KZ8xV3dcVgPdA6KuX+fh6kGvlktvrPpOaQvXLAmF2m99iI9zzpEmtz8pKXgWY+suwbl1sFAoOMWkHejuyIgB/1D9tTikVxbXcJsv5+fbIgMGBPZSFxco3JskL/oDXK0WAfNsE3/RWt+JaZB3XgRVpTfsizVcwyUtluvucBG8c1XCCaMrvwH3Abf0dGgc2MsLiuNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AS5PR04MB9924.eurprd04.prod.outlook.com (2603:10a6:20b:67e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 11:50:43 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 11:50:48 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/3] net: dpaa2-mac: retrieve MAC statistics in one firmware command
Date: Mon, 23 Mar 2026 13:50:38 +0200
Message-Id: <20260323115039.3932600-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323115039.3932600-1-ioana.ciornei@nxp.com>
References: <20260323115039.3932600-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0006.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::6) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AS5PR04MB9924:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fba0cd-922e-429c-6a78-08de88d26c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	spxbnhBA6BtaU8njDrbAYoRJxN0CkFsDH1DrrLyXkDjbvlTipfc8hkPCd8v3f25BnMkN2vFi8JSRUsJxpFQu4xmgADcPlaZfEB7I+KrIpdJdpX1m10hnirf78wbmYIrj/CFXdOzRaloTv4CfPdIzayLT2H3Vimm+dGT2CmEIFhVAwNCPDEz7pE0iu4RhNgubWD9Bl3bcn9KTBxBzrlXRvs6lSCccCo6GZ8F3eIHuvZ42h3sMnnCBQPc6FNjHp/d8OEZAVTpqCELcqPGwOB769V8dp8urtURkDjmD1ijsivonb3FtrcO3Qfr0CNMxKwAvUg0Uk8HRERVQx7VRxXGEdaDzKtaBOFWrlf4rxyYtIx9XBIqms/WF6TRB2YV/wivwMIXOx9RDo6W4srIinkGZRXVNG0w1VKyL2yN0+Jmnnvcke2Y1OknYu1cgJqBBoqoW2mxbFNYfmYH7O1x0lZsWMiWp+A85hNucwib2KU7C4M392j7Rxr64H6xldkJJOIL9KP4BKx6UucwRKTQjwCuPYQHZG0NfYeWEADm796ysmD+acuL/HoXjH7v68jxbHtMnnQJ6z50n0fYVLp71SNFzp1jYqssvt1+2FTjXj9hZIwfPEYs4Nw/kMW7TQka8jES6npi3YF7oYKGwyjkcaMvJFaunduVNPuE4qUg4ulWeDAmmpOBE7QK4/8CL94XQbwKH9Eph1cYuk57+mZb4vJDkrI8xsZ9Bxbe8RAfjzsrPjHw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IZPbvvVkZaFIRsVOgMWGZohKQRNeuKo00NHchkAxE/OAVzBab5MiKMFOeWoh?=
 =?us-ascii?Q?ryXc9YVDmak3ybTRyPFdHCqPYKaK9399+tgPjf4L5O90fsT62sCUPu0pg3os?=
 =?us-ascii?Q?/7tATIBjfA/utWeWgXJpLwHcIfjAS1CyXWNmeBaVZa0k5D08QwCoqkZH8Qxe?=
 =?us-ascii?Q?2h9NMI+fTKjJ4UdGO+1PJjmMOjWyMl2kSXpxUEq18P6567xFfrLJyFtdOr63?=
 =?us-ascii?Q?JtSJgalH1xpJWLi3qpSrniHvkB8vFTcb9l9J6ollDYZ06LuPTEDjBnQsgbMh?=
 =?us-ascii?Q?Ig7U/68NiKNu/4zFXaKJsc6ioEQYcVI79Vaf2jiUvr8wAu6feg6YIQYik3DC?=
 =?us-ascii?Q?r4a2lfl9a9Z+GuGAT1JXiy60RjplWjDkSJXYtICFj6SVbWgvtI9VWCLAE7Bo?=
 =?us-ascii?Q?AojGBDJovu2YEoIX5IZoh7Gx/YdCsYmlGjuqhAMz0AT+uf8gMz4qRiR+A9iJ?=
 =?us-ascii?Q?owAQhGG8AJsizsH4ARMxkuXBdrGdnt4GxcDH3O55r1IR/MtaIb0/NE+Wp83S?=
 =?us-ascii?Q?5+Tl/rn8Rir5bG9fDaAMYvTdl9rjocTBLqKPDYlhuagh3OZ+E28C94IPKQLc?=
 =?us-ascii?Q?3xWQs5w9/kI+zIXfV4Kk+yCWXc5AVIgZuGUGSBlInubsN7BSp8DtztjeqGvI?=
 =?us-ascii?Q?YkhOhNsQk6X/wyaqK5oNCkn3t/5vqfJ7u0fk5GYxnTgDMl2mGrg6GGoc8T5e?=
 =?us-ascii?Q?TfI3PaNgF6EFhEju35ruFTfRGD0wWkhcXP8Mh9gq8Il6FAVJRtTwWIZr/oMq?=
 =?us-ascii?Q?+pxdSScFQCkQCO7iy2GUpGZOweuBRVksNMRspBNvaeyOKR11R02yKHaLeb7f?=
 =?us-ascii?Q?Kt7yld6xD14/G0JRksdLTF1eGJQZjx9abrXa3RWcc5+iDHpssmt9jEMTh+Bl?=
 =?us-ascii?Q?DLVq8c5RfMmmar/g5+tE9ra/qJe8UTQOejDwsFjkwEkxzWWkTJphps60tffJ?=
 =?us-ascii?Q?jhLNM0BeIwhsMTYmSCGV4CzMly04BChJK+8qCrHVZH0qVhuEcyCUATRSfIN9?=
 =?us-ascii?Q?BLtTh5HwjUFk9TCKzdyecuwMgoQPmOTtuNpuNX6Cns5S1qyaysRfEKhoBEIL?=
 =?us-ascii?Q?FazfoTQ9OhhHO9cRxoOCb5Cv9a4eDjVisSwaKsZqvXeV1mW89HJ+Gsmb+9re?=
 =?us-ascii?Q?1hPhKoZazTexTFxPUHnKIdCrR1oLIoVEWrTPYlhYHzs/iOtM7D8VCdVS4sDJ?=
 =?us-ascii?Q?UneUaGOCO0CK29m8vjll0TzeXzobtrw4b+a8XqNPrXvo0Ks4V4X6L7omDMKN?=
 =?us-ascii?Q?e8l+amtTDsaoVaeL4Uxa5eYmxeQhIdAncAcN3qIFFNHMKPGxBZ1MScqsovge?=
 =?us-ascii?Q?0bY7aG57uDFECmvT/3jG4v6pVNqpcknzKmy65lYUCuF2RiEoqHfxBEPn7y9s?=
 =?us-ascii?Q?DrZ/6DW6687JYfJ2SwRlFiRS1S/gAtSG8dqH3tk4OPz5MhTZOk0ZiKKhVZ3w?=
 =?us-ascii?Q?/Y/frIKHQm9QtR7Qf+fLrjqFaTB02bfSZ8jGfnX6NntxSEpklZEbP1NoRWu6?=
 =?us-ascii?Q?R3ii+xL6wJ5I8kkIk+ufjIaAJXGi+4e5EgCzC0k8P/O4CUWREvnFXuvmQK3i?=
 =?us-ascii?Q?L2GWeP92IE/VbcpVTE7XkgSby8FecsMHVBVGG6wl5W5spIuMDvmomr/CNs+J?=
 =?us-ascii?Q?WjRFpmy8/sKjGNxVArlEYZJHbnSQl0w7zXCyc6PWmJUS+WZTAVs7+5dwxwO2?=
 =?us-ascii?Q?nMw10//xBMuAI6UDyKQe9tWYjj/qonNPMRBXquvy9VvxUlBhD5VnVVVhLdNJ?=
 =?us-ascii?Q?8Q7X6L1rSg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fba0cd-922e-429c-6a78-08de88d26c80
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:50:48.0018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i71SgPbBdsAajaWBWRWROdyjYBXm1fWra1U9KiwC8/2h0CBvlkqptgVi/mjzRjBPYIHRx5BScXWAMS8ypDNtWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9924
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270496-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7963A2F1761
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The latest MC firmware version added a new command to retrieve all DPMAC
counters in a single firmware call. Use this new command, when possible,
in dpaa2-mac as well.

In order to use the dpmac_get_statistics() API, two DMA memory areas are
used: one to transmit what counters the driver is requesting and one to
receive the values of those counters. These memory areas are allocated
and DMA mapped at probe time so that we don't waste time at runtime.

And since we are planning to add rmon, eth-ctrl and other standard
statistics using the same infrastructure, make the setup and cleanup
processes as generic as possibile through the dpaa2_mac_setup_stats()
and dpaa2_mac_clear_stats() functions.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v5:
- none
Changes in v4:
- fix dma_sync call and memory leak in the cleanup
Changes in v3:
- use dma_alloc_noncoherent() instead of kcalloc + dma_map_single
- reduce the number of lines that have more than 80 chars
Changes in v2:
- fix fallback usecase by using dpaa2_mac_ethtool_stats[i].id
- use the __le32/__le64 types for cnt_idx, cnt_values etc

 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 201 ++++++++++++++----
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  10 +-
 2 files changed, 171 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index 422ce13a7c94..5a7fda6a2012 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2019 NXP */
+/* Copyright 2019, 2024-2026 NXP */
 
 #include <linux/acpi.h>
 #include <linux/pcs-lynx.h>
@@ -15,7 +15,118 @@
 #define DPMAC_PROTOCOL_CHANGE_VER_MAJOR		4
 #define DPMAC_PROTOCOL_CHANGE_VER_MINOR		8
 
+#define DPMAC_STATS_BUNDLE_VER_MAJOR		4
+#define DPMAC_STATS_BUNDLE_VER_MINOR		10
+
 #define DPAA2_MAC_FEATURE_PROTOCOL_CHANGE	BIT(0)
+#define DPAA2_MAC_FEATURE_STATS_BUNDLE		BIT(1)
+
+struct dpmac_counter {
+	enum dpmac_counter_id id;
+	const char *name;
+};
+
+#define DPMAC_UNSTRUCTURED_COUNTER(counter_id, counter_name)	\
+	{							\
+		.id = counter_id,				\
+		.name = counter_name,				\
+	}
+
+static const struct dpmac_counter dpaa2_mac_ethtool_stats[] = {
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ALL_FRAME,  "[mac] rx all frames"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_GOOD_FRAME,  "[mac] rx frames ok"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ERR_FRAME, "[mac] rx frame errors"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_DISCARD, "[mac] rx frame discards"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_UCAST_FRAME, "[mac] rx u-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_BCAST_FRAME, "[mac] rx b-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_MCAST_FRAME, "[mac] rx m-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_64, "[mac] rx 64 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_127, "[mac] rx 65-127 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_255, "[mac] rx 128-255 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_511, "[mac] rx 256-511 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1023, "[mac] rx 512-1023 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1518, "[mac] rx 1024-1518 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1519_MAX, "[mac] rx 1519-max bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAG, "[mac] rx frags"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_JABBER, "[mac] rx jabber"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ALIGN_ERR, "[mac] rx align errors"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_OVERSIZED, "[mac] rx oversized"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_VALID_PAUSE_FRAME, "[mac] rx pause"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_BYTE, "[mac] rx bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_GOOD_FRAME, "[mac] tx frames ok"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_UCAST_FRAME, "[mac] tx u-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_MCAST_FRAME, "[mac] tx m-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_BCAST_FRAME, "[mac] tx b-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_ERR_FRAME, "[mac] tx frame errors"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_UNDERSIZED, "[mac] tx undersized"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_VALID_PAUSE_FRAME, "[mac] tx b-pause"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_BYTE, "[mac] tx bytes"),
+};
+
+#define DPAA2_MAC_NUM_ETHTOOL_STATS	ARRAY_SIZE(dpaa2_mac_ethtool_stats)
+
+static void dpaa2_mac_setup_stats(struct dpaa2_mac *mac,
+				  struct dpaa2_mac_stats *stats,
+				  size_t num_stats,
+				  const struct dpmac_counter *counters)
+{
+	struct device *dev = mac->net_dev->dev.parent;
+	size_t size_idx, size_values;
+	__le32 *cnt_idx;
+
+	size_idx = num_stats * sizeof(u32);
+	stats->idx_dma_mem = dma_alloc_noncoherent(dev, size_idx,
+						   &stats->idx_iova,
+						   DMA_TO_DEVICE,
+						   GFP_KERNEL);
+	if (!stats->idx_dma_mem)
+		goto out;
+
+	size_values = num_stats * sizeof(u64);
+	stats->values_dma_mem = dma_alloc_noncoherent(dev, size_values,
+						      &stats->values_iova,
+						      DMA_FROM_DEVICE,
+						      GFP_KERNEL);
+	if (!stats->values_dma_mem)
+		goto err_alloc_values;
+
+	cnt_idx = stats->idx_dma_mem;
+	for (size_t i = 0; i < num_stats; i++)
+		*cnt_idx++ = cpu_to_le32((u32)(counters[i].id));
+
+	dma_sync_single_for_device(dev, stats->idx_iova, size_idx,
+				   DMA_TO_DEVICE);
+
+	return;
+
+err_alloc_values:
+	dma_free_noncoherent(dev, num_stats * sizeof(u32), stats->idx_dma_mem,
+			     stats->idx_iova, DMA_TO_DEVICE);
+out:
+	stats->idx_dma_mem = NULL;
+	stats->values_dma_mem = NULL;
+}
+
+static void dpaa2_mac_clear_stats(struct dpaa2_mac *mac,
+				  struct dpaa2_mac_stats *stats,
+				  size_t num_stats)
+{
+	struct device *dev = mac->net_dev->dev.parent;
+
+	if (stats->idx_dma_mem) {
+		dma_free_noncoherent(dev, num_stats * sizeof(u32),
+				     stats->idx_dma_mem,
+				     stats->idx_iova, DMA_TO_DEVICE);
+		stats->idx_dma_mem = NULL;
+	}
+
+	if (stats->values_dma_mem) {
+		dma_free_noncoherent(dev, num_stats * sizeof(u64),
+				     stats->values_dma_mem,
+				     stats->values_iova, DMA_FROM_DEVICE);
+		stats->values_dma_mem = NULL;
+	}
+}
 
 static int dpaa2_mac_cmp_ver(struct dpaa2_mac *mac,
 			     u16 ver_major, u16 ver_minor)
@@ -32,6 +143,10 @@ static void dpaa2_mac_detect_features(struct dpaa2_mac *mac)
 	if (dpaa2_mac_cmp_ver(mac, DPMAC_PROTOCOL_CHANGE_VER_MAJOR,
 			      DPMAC_PROTOCOL_CHANGE_VER_MINOR) >= 0)
 		mac->features |= DPAA2_MAC_FEATURE_PROTOCOL_CHANGE;
+
+	if (dpaa2_mac_cmp_ver(mac, DPMAC_STATS_BUNDLE_VER_MAJOR,
+			      DPMAC_STATS_BUNDLE_VER_MINOR) >= 0)
+		mac->features |= DPAA2_MAC_FEATURE_STATS_BUNDLE;
 }
 
 static int phy_mode(enum dpmac_eth_if eth_if, phy_interface_t *if_mode)
@@ -504,6 +619,11 @@ int dpaa2_mac_open(struct dpaa2_mac *mac)
 	mac->fw_node = fw_node;
 	net_dev->dev.of_node = to_of_node(mac->fw_node);
 
+	if (mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE)
+		dpaa2_mac_setup_stats(mac, &mac->ethtool_stats,
+				      DPAA2_MAC_NUM_ETHTOOL_STATS,
+				      dpaa2_mac_ethtool_stats);
+
 	return 0;
 
 err_close_dpmac:
@@ -515,66 +635,69 @@ void dpaa2_mac_close(struct dpaa2_mac *mac)
 {
 	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
 
+	if (mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE)
+		dpaa2_mac_clear_stats(mac, &mac->ethtool_stats,
+				      DPAA2_MAC_NUM_ETHTOOL_STATS);
+
 	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
 	if (mac->fw_node)
 		fwnode_handle_put(mac->fw_node);
 }
 
-static char dpaa2_mac_ethtool_stats[][ETH_GSTRING_LEN] = {
-	[DPMAC_CNT_ING_ALL_FRAME]		= "[mac] rx all frames",
-	[DPMAC_CNT_ING_GOOD_FRAME]		= "[mac] rx frames ok",
-	[DPMAC_CNT_ING_ERR_FRAME]		= "[mac] rx frame errors",
-	[DPMAC_CNT_ING_FRAME_DISCARD]		= "[mac] rx frame discards",
-	[DPMAC_CNT_ING_UCAST_FRAME]		= "[mac] rx u-cast",
-	[DPMAC_CNT_ING_BCAST_FRAME]		= "[mac] rx b-cast",
-	[DPMAC_CNT_ING_MCAST_FRAME]		= "[mac] rx m-cast",
-	[DPMAC_CNT_ING_FRAME_64]		= "[mac] rx 64 bytes",
-	[DPMAC_CNT_ING_FRAME_127]		= "[mac] rx 65-127 bytes",
-	[DPMAC_CNT_ING_FRAME_255]		= "[mac] rx 128-255 bytes",
-	[DPMAC_CNT_ING_FRAME_511]		= "[mac] rx 256-511 bytes",
-	[DPMAC_CNT_ING_FRAME_1023]		= "[mac] rx 512-1023 bytes",
-	[DPMAC_CNT_ING_FRAME_1518]		= "[mac] rx 1024-1518 bytes",
-	[DPMAC_CNT_ING_FRAME_1519_MAX]		= "[mac] rx 1519-max bytes",
-	[DPMAC_CNT_ING_FRAG]			= "[mac] rx frags",
-	[DPMAC_CNT_ING_JABBER]			= "[mac] rx jabber",
-	[DPMAC_CNT_ING_ALIGN_ERR]		= "[mac] rx align errors",
-	[DPMAC_CNT_ING_OVERSIZED]		= "[mac] rx oversized",
-	[DPMAC_CNT_ING_VALID_PAUSE_FRAME]	= "[mac] rx pause",
-	[DPMAC_CNT_ING_BYTE]			= "[mac] rx bytes",
-	[DPMAC_CNT_EGR_GOOD_FRAME]		= "[mac] tx frames ok",
-	[DPMAC_CNT_EGR_UCAST_FRAME]		= "[mac] tx u-cast",
-	[DPMAC_CNT_EGR_MCAST_FRAME]		= "[mac] tx m-cast",
-	[DPMAC_CNT_EGR_BCAST_FRAME]		= "[mac] tx b-cast",
-	[DPMAC_CNT_EGR_ERR_FRAME]		= "[mac] tx frame errors",
-	[DPMAC_CNT_EGR_UNDERSIZED]		= "[mac] tx undersized",
-	[DPMAC_CNT_EGR_VALID_PAUSE_FRAME]	= "[mac] tx b-pause",
-	[DPMAC_CNT_EGR_BYTE]			= "[mac] tx bytes",
-};
-
-#define DPAA2_MAC_NUM_STATS	ARRAY_SIZE(dpaa2_mac_ethtool_stats)
-
 int dpaa2_mac_get_sset_count(void)
 {
-	return DPAA2_MAC_NUM_STATS;
+	return DPAA2_MAC_NUM_ETHTOOL_STATS;
 }
 
 void dpaa2_mac_get_strings(u8 **data)
 {
 	int i;
 
-	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++)
-		ethtool_puts(data, dpaa2_mac_ethtool_stats[i]);
+	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++)
+		ethtool_puts(data, dpaa2_mac_ethtool_stats[i].name);
 }
 
 void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
 {
+	size_t values_size = DPAA2_MAC_NUM_ETHTOOL_STATS * sizeof(u64);
+	struct device *dev = mac->net_dev->dev.parent;
 	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
+	__le64 *cnt_values;
 	int i, err;
 	u64 value;
 
-	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++) {
+	if (!(mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE))
+		goto fallback;
+
+	if (!mac->ethtool_stats.idx_dma_mem ||
+	    !mac->ethtool_stats.values_dma_mem)
+		goto fallback;
+
+	dma_sync_single_for_device(dev, mac->ethtool_stats.values_iova,
+				   values_size, DMA_FROM_DEVICE);
+
+	err = dpmac_get_statistics(mac->mc_io, 0, dpmac_dev->mc_handle,
+				   mac->ethtool_stats.idx_iova,
+				   mac->ethtool_stats.values_iova,
+				   DPAA2_MAC_NUM_ETHTOOL_STATS);
+	if (err)
+		goto fallback;
+
+	dma_sync_single_for_cpu(dev, mac->ethtool_stats.values_iova,
+				values_size, DMA_FROM_DEVICE);
+
+	cnt_values = mac->ethtool_stats.values_dma_mem;
+	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++)
+		*(data + i) = le64_to_cpu(*cnt_values++);
+
+	return;
+
+fallback:
+
+	/* Fallback and retrieve each counter one by one */
+	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++) {
 		err = dpmac_get_counter(mac->mc_io, 0, dpmac_dev->mc_handle,
-					i, &value);
+					dpaa2_mac_ethtool_stats[i].id, &value);
 		if (err) {
 			netdev_err_once(mac->net_dev,
 					"dpmac_get_counter error %d\n", err);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
index 53f8d106d11e..6f4981627961 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2019 NXP */
+/* Copyright 2019, 2024-2026 NXP */
 #ifndef DPAA2_MAC_H
 #define DPAA2_MAC_H
 
@@ -11,6 +11,12 @@
 #include "dpmac.h"
 #include "dpmac-cmd.h"
 
+struct dpaa2_mac_stats {
+	__le32 *idx_dma_mem;
+	__le64 *values_dma_mem;
+	dma_addr_t idx_iova, values_iova;
+};
+
 struct dpaa2_mac {
 	struct fsl_mc_device *mc_dev;
 	struct dpmac_link_state state;
@@ -28,6 +34,8 @@ struct dpaa2_mac {
 	struct fwnode_handle *fw_node;
 
 	struct phy *serdes_phy;
+
+	struct dpaa2_mac_stats ethtool_stats;
 };
 
 static inline bool dpaa2_mac_is_type_phy(struct dpaa2_mac *mac)
-- 
2.25.1


