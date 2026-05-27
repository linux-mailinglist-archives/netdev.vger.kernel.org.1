Return-Path: <netdev+bounces-292233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA1aNCrCFmrOqgcAu9opvQ
	(envelope-from <netdev+bounces-292233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:06:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3E45E25E0
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED1CE30A9301
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA323EEAEC;
	Wed, 27 May 2026 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BabAuk6l"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E33ECBD9;
	Wed, 27 May 2026 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876004; cv=fail; b=Z8sxTcfdCjejM7IRpO26C/hO9MDuAEbEfuxe7I0ZjYdVmlXba0TfmtFqRdYsQg9qa7pz3WcJFo/n+TuUFt4xQrxxloe/NgxTJ/sogliIlRcHfJrJNDorpdPpwJxTVgjMwesOceJbSMusMVv/2yVjVaAQdXJaAl4wYfc/w4NaR0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876004; c=relaxed/simple;
	bh=kLcjhO7dtDiRKJkcVi6iaRp0N1SRhqLzH3XLCcE9FoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y0/FfWk7+jjhyqwA79uqMk4sDaZ1cR1ELsw4pVLp8nFicuBYDkYJF492Si1VMLzBj0g+Ll7agjjtVjRgTPEuflN0vgnA1C6URl2blAQ/xSiFIvvI+mEL6OBKi8z+6qm0PxQK5H5cFeD6z7LOxL6NzxNw2dnIlWJsiHa92hwbH9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BabAuk6l; arc=fail smtp.client-ip=52.101.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASWBm5LfsuFjW3+vR0nxUsrNJ0aZBWMN6Fp8743VzBakNRDYHM1OZfOwCDvtmbl9Nn4N3VfxbhIZKzE4hkPqBlSFmfbCopBELHJ7TfaA1VM40V1U2V3DUSCOV3PWPmMjJwmf4dQfCdbLQDNPdkCrxp09zZ0YvolLgnxmn7eN/I/U0ghQeJCDTA9zsdvSzPyOuXEm6rKQKdW84WRV18DYRyj0HNZWKxx3ay2NuFqC9/R5DOCji2ahp9KsuDGVJ+ej31y4AT5IPkZU5u4g/hekIW/HJlKQYpMpDY25zMqPEYctXUIz52Tp5eptTEKY+iYSgJHeXIgUQUmDk+WpF0w0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqdG0hvj/8ESaoKqJRKYKQBvah+RF2uwVS9jehpdDOw=;
 b=q1ahIzd6+uVP7D6SJfw+x+3NvBz3ubdFkjH6enTwju9qO2eqeDJWbT/UzKTD94pa4tgHwF/kisaPAW8LwhT750vfVBxd/oqgZHJaIzxQWlDV07m7HQ2kQ0c/3GoAXDtxFd21ttAyGSEdoO+brr/9OYxZaONyzw8Bh1eb79xIW917/hIXde4u3x56ZMdVNluJJMnZdU55eWf45avgkhaJpOwGQeZqKs25qZyne5cd8KCJf5pxHCu6EKw8SmHsHO+yKP6zVcc0UeDWtEetg+rIwkZS+XUT2nXATIBm3yNPj1XVV5rQORyRfWrc0IOUj8tuzrGr2p6UqJXs6qmSFlccuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqdG0hvj/8ESaoKqJRKYKQBvah+RF2uwVS9jehpdDOw=;
 b=BabAuk6l5snrY8cff7/2OepwiZog1S2HR0eDspX1RiFmabGytFIOq9xma06EStJlsIlZJX0JQKhWeEsRESMiCotmlmQZd1wLUbBdLTBpTb5ACJbTE1l2qeEVVlSUvcV9z+pf+F7zFPEbEKFRZtn3iiKI50edgprFAtn4HHb23LipKBMtcWz1iIXfEjB93kuuAFSZD8Md296YM5zrieobyy4sgFdUy9jxrfeolLClDdbUuxm9BP5P5WBBF5rEbEBn+fgdxHXXQLvQFZ+qrcej+VSm2y945+unMAkXkB2Yczcw7FsMSP6pIe/VgpxCkH+PHk0uweLOCLgDIv1a9g11Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AMBPR04MB12205.eurprd04.prod.outlook.com (2603:10a6:20b:758::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 09:59:53 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 09:59:53 +0000
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
Subject: [PATCH net-next 6/9] net: enetc: add helpers to set/clear table bitmap
Date: Wed, 27 May 2026 18:02:14 +0800
Message-Id: <20260527100217.794987-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527100217.794987-1-wei.fang@oss.nxp.com>
References: <20260527100217.794987-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::19) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AMBPR04MB12205:EE_
X-MS-Office365-Filtering-Correlation-Id: 430a2476-04c3-49a0-f4f2-08debbd6b2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|11063799006|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	0RXUMoDu/PukJorZcmorrgIqbHxEIpnSkmfqkH3rjZYlU45puI7MT3PdOxYS5nzshcMZpINf94t408VPIWTgobbEp6FH0+mHTMIJm+qmPOAP1n8A2L0/pTTqFJ6To+WmAObaSO7QmLUqrR2Yk23AET/sxGNmd3xABW5MjiB39bUZ+0Xi46K6gDDcQ5T55wm+FM4lJ72yqGdfZN+s+Rk6/LGWNk+l9/ErdxPW/tNMmNzK5cBs/4ChV6SwRXblhh0dT+GMZMAIc6u3Z54kSq7w3mP9AhgdWdg/Ls5hiAGpwgLNa6/Vqji0BbOMMEmLJt/h5fjulvk74p8Ne9FEh/CIL6mmTf+ihbVt0mYQqsk93qdat9VvlAfEAY/iwQJU3nXdM9nHaxyJK8cSnr8s4qzQU9jzarqgWQxP1NUZ6Jkv0UvXhA2fiZTMY4fuSihpC+KwmKrCsnEbfvmu7agiaEi/ZP+BjtCXpqLbDRnJsOYI6bBlPujwuOuEXBL3RI8T8w1wIX4bJeFEbOqqYYzPIRJeWvL6mujfkw1TYwL6JeaDnAZROV9ZG1ykF/+1wBrTe7w3ZHaLIe2gO5YvAUinifr9Ewin5qtKWxNutxIytqedDMbvC3+MU8qBhwXkAP2Cvn1B/b+w3TMnW5LyJTooj+xlyarVroyvQFylWY2i1qtCIW4EQC0H4tLSWtI6vE2uChjXxGFDHlTQpkdMnyQu4HdFBgH8+M+FGMT+ZoE8/jD/K88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vowu2kZysaBoAYMvcBB6GJBGTqj9GJvEcQpVKL5fF9A1dF5JAe/fyga8wq32?=
 =?us-ascii?Q?9KQmm1xxl7uqw29OiKuZi2+eGXmU5mpmTvM1HKg+OwlGjIO8Ofl5YyjbTl48?=
 =?us-ascii?Q?VygzdIwUAfejfZwuwWRb8JfNASELEXPxUo0MYLAkZIWa5PfRoDblDckrCdsm?=
 =?us-ascii?Q?zl3cd8lkc6qXwC+mKr7la8Ki2Lu3qnUUg6FuTMWy+YBBN5nKO7Z3VEdk7DcU?=
 =?us-ascii?Q?ptT1w9TAK7oVRF5aDV03xh00aLbaThziFbrlER22ZIqMZE0b4H2gp9Q7O+AD?=
 =?us-ascii?Q?xBEmQFw+BTL0PQ1NdgIqHMKmhgZUNs77KYpXW9rmQJxtlUCvz7/OCW2WwL+F?=
 =?us-ascii?Q?eUpDHiOLfNylUrwotw9kxb+Z8HvtkwI56w6Fp6CF5XGt/hj+01e3fdxewTZQ?=
 =?us-ascii?Q?oYh23gNQyZdWFR0yqWaU4hOyomE4yUPcWMDPKrwvmZLHS2pY5elk2u0HwHVG?=
 =?us-ascii?Q?SL0gY0AqhW6Tv+wIMS6NAoHg/yCkXJBVDr0xz7N4jithQDE1OgOvyJJQWa1J?=
 =?us-ascii?Q?+P5Br2Av+zK8n7sG44GhH5uJY76XPoHj173DmHgGsi1X6Gkciq6UMBpC4RZS?=
 =?us-ascii?Q?1LLGbGfl4od7C1AsJJMpac7Wk+UBEp5VegJDJB0C9mTYtCmWro+Hmi7nzeK/?=
 =?us-ascii?Q?gtp+7t5mX0YQYhkPse40M6jBljMUNLbTOxiou6rynm1/NobRy1qUl4QdfssX?=
 =?us-ascii?Q?fuEMhqFxVdMgdDdSKPBrqOaCnY8OgKRXn6wOJPFmO2Fz4hWcm1ejFo7ixZwp?=
 =?us-ascii?Q?iJj7yLJL9MG238a8Q8srNps9ybEyGRJAm3R24WH3GyYArrhLS+WHvYLY/pOt?=
 =?us-ascii?Q?hK4nUW4vWF2SdBk6QH/U/knw4inecEpQagON3A/KSeKsxXYpR11cBQ5fCJ0e?=
 =?us-ascii?Q?eiLnOBKaZ49e5m6fp6ZCV3LyXv/A431z8dJvKmfqKspb1VSfO8qEB54+Wsd7?=
 =?us-ascii?Q?Bszc3j2udMSopfi3kc442xTdNBvGSYbOS3M5iwj/pja2g6vVQhw1AdqihPnx?=
 =?us-ascii?Q?Qu+R9ohZCp5gNS8sXK0UTNPET0q5vwtLKnzTKwqrRC9VAY0hTO2jPxs7FuhE?=
 =?us-ascii?Q?aUcbV0q7/2w6IU+iv0e6O5nGxd7Aa2GA9tZvq1Ty07DBmdW5PLYsQTEXd/hC?=
 =?us-ascii?Q?7JcUl08OMFPfnxshoSNoZ0LMtzcrkZ6JUoX+kFqingBTQnXmFuuuNsvU4+um?=
 =?us-ascii?Q?k7+UX+qzbmOPwyAtNYOb2tsN4O4tVfc7IVmae4rlVhJZ6+isNsQECuqKSMMn?=
 =?us-ascii?Q?JYWLw8nVPnKo/vdBVMs9eYHTZmT/3qluidE+DaWUzC35YBJl1Q/ypeEL0HBx?=
 =?us-ascii?Q?MJz3Z9Hp8KCye5hCztMK2mLxdQvnb7IqEloXxZrdncrEkAYQDDAHJ1uYxppb?=
 =?us-ascii?Q?ZATDf/PzFdqZ6WtpgubwVgtbugZ7gDzPTmKGfpvYevkFByvWk3SmSwbeirZ/?=
 =?us-ascii?Q?xHwFsTBBcOsPRaIhVqQ42U9w5rhfSKoS3FAfIe6oIU2TLz95xZRfXoOn1zbU?=
 =?us-ascii?Q?Vo1CfUaQyEr2zNe/b3tLUOabZOtquL7dKA23DEe9KtiZUXTmNhYf3sTNCVAc?=
 =?us-ascii?Q?h7ZIt+EMM0YarMWeVhE63+a93S3J675PdUvoQ53QdI9X3vMpOWfIPWtyuQz7?=
 =?us-ascii?Q?bSeOusKGwo0mKfD2n8W+ac4OGsiEEgTvRZS9il4ebEV+7BGAm2pdcIMqo92p?=
 =?us-ascii?Q?UfLEOMMceGHCMyUzqeJiFGoNnfu8UV52Qh8vvOofJZz4NWBRuQJdDm5hBFtU?=
 =?us-ascii?Q?q6JUAitil7CzSDautzpEDM5AGPwNuSMdFO/scIj+GBNOlyevESxl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430a2476-04c3-49a0-f4f2-08debbd6b2af
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 09:59:52.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBGCmP5E7KvnQEzwskLyPjWR5d+tMIizZJz6C6DlmoD63Coe6maYaAGT105ezN7HrgWfVKaz73dSIVW9NzBy6KHGC2cerXYCeQdo/umonJkZbYn2XFlSCj1tBu57LZGE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12205
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292233-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 2B3E45E25E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wei Fang <wei.fang@nxp.com>

NTMP index tables require software to allocate and manage entry IDs.
Add two bitmap helper functions to facilitate this management:

ntmp_lookup_free_eid(): finds the first zero bit in the given bitmap,
sets it to mark the entry as in-use, and returns the corresponding entry
ID. Returns NTMP_NULL_ENTRY_ID if no free entry is available.

ntmp_clear_eid_bitmap(): clears the bit associated with the given entry
ID in the bitmap to mark the entry as free. It is a no-op if the entry
ID is NTMP_NULL_ENTRY_ID.

Both functions are exported for use by other modules, such as the NETC
switch driver which needs to manage group index bitmaps for the Egress
Treatment Table (ETT) and Egress Count Table (ECT).

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 24 +++++++++++++++++++++
 include/linux/fsl/ntmp.h                    |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 60e2ed68ed62..98f8e41e0267 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -47,6 +47,30 @@
 #define RSST_STSE_DATA_SIZE(n)		((n) * 8)
 #define RSST_CFGE_DATA_SIZE(n)		(n)
 
+u32 ntmp_lookup_free_eid(unsigned long *bitmap, u32 size)
+{
+	u32 entry_id;
+
+	entry_id = find_first_zero_bit(bitmap, size);
+	if (entry_id == size)
+		return NTMP_NULL_ENTRY_ID;
+
+	/* Set the bit once we found it */
+	set_bit(entry_id, bitmap);
+
+	return entry_id;
+}
+EXPORT_SYMBOL_GPL(ntmp_lookup_free_eid);
+
+void ntmp_clear_eid_bitmap(unsigned long *bitmap, u32 entry_id)
+{
+	if (entry_id == NTMP_NULL_ENTRY_ID)
+		return;
+
+	clear_bit(entry_id, bitmap);
+}
+EXPORT_SYMBOL_GPL(ntmp_clear_eid_bitmap);
+
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs)
 {
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index b9d4a29abd23..a678f1e1ee42 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -271,6 +271,8 @@ struct bpt_cfge_data {
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
 void ntmp_free_cbdr(struct netc_cbdr *cbdr);
+u32 ntmp_lookup_free_eid(unsigned long *bitmap, u32 size);
+void ntmp_clear_eid_bitmap(unsigned long *bitmap, u32 entry_id);
 
 /* NTMP APIs */
 int ntmp_maft_add_entry(struct ntmp_user *user, u32 entry_id,
-- 
2.34.1


