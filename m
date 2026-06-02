Return-Path: <netdev+bounces-294063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHRQIjOGHmqhkQkAu9opvQ
	(envelope-from <netdev+bounces-294063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 09:28:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E0629B16
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 09:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DAC430CE380
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 07:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FBB36E460;
	Tue,  2 Jun 2026 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BHldxtU4"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011028.outbound.protection.outlook.com [40.107.130.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75E3403F8;
	Tue,  2 Jun 2026 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384853; cv=fail; b=pcv1BKyUmnNJxDLaDX1lrqSafK2jBNCKEARkq/Y665IhSalzHZnzVz82l2xHIwmP6gJSSIPfAkzhqYQimM495M6ZBc95SmO+c+VdfC8vCqLhJg/jc0fhwq2ekCoy/OQm7UvAJWZcQXU7T55S2x1amYPNQEfxsYfR7HcvUnJtv64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384853; c=relaxed/simple;
	bh=1RIrFRvs3NLBedELrrgsVfoBh8dWdOfKmnyVNBnx0tE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K++Ca4iHLOITlhclfVNz1poDfQl+bGkYMvUVnW2GbrfAdAy3mGjoV7bGPOwLxUbIA3ZeH7v8y+bWRQjCH9YPI6lricNNgeClstGY5ryEY9Y3EtB5SEW9qVJsJVJlLGVId6umAhLEawMHodKnff8PBeDUVTUyhXkLtB5vlMbWkUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BHldxtU4; arc=fail smtp.client-ip=40.107.130.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APah+9JbbTU3HOD4gsHFgPGm2992hxFqHNCxSK4ggfTJdatUVMaxdj5Jt6XbjStUrEcDZQ7b5gae09NVNOFaSZEJ71stAbZs28cS30nVYHQQCNLZ1WkD6DHF1uwnNeHhFhvc1I/aVRFzqrF7rGQQsmGPMFZs+Pk1fLBIvpI14Ss7L/8L08sgQ+05DxCBfYFxRfZWDDPaN+8nDJPkbEhxboO//7bB1S+tywc3GQdjf8RBIkJAcc0jElhF1NeaJdCpFJV1LBUTzUM3iLOh0Yh0H7URKQKgXNbt1fB2azNzudyStNmHQm1vclC8RTMmqXSoVC+TuewW7aTa3LlvBz1Ijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5airljjDLuMIH8cJtpHKGVjh0WtGoiFPg6lBbS8mJk=;
 b=qZ4l8qDcfJzDhVzICACr+E7cXNnTHn58PifBGrnuGNre4tN0N1HMHJOPbFmaVS9hJgEF5Ce8JSn49yMhC0iLruEJqbkqhmYFCSXWkOKCc4NXQSWN4emZln/RwURwMelO1HPGsqCygBP7k1q/3l/PI0tMPXTPl1WQyVrpJyFMX2g747wbdFnzvOOjM7sJaaojENKAmrsLYO1ayL8DiI5TIqFAGDF+a7Cat4AOV9uTcnt3I/lYra0BY8DX5wPheIqD/Xbgrb9e47r5qm9t9REf/O1zB8Z+LN0+IsnFA/D46LWKowgNNGjOc1A//0oDvVCNAsjYIJRTLslLG9v/EVulJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5airljjDLuMIH8cJtpHKGVjh0WtGoiFPg6lBbS8mJk=;
 b=BHldxtU4CquL5ayeF3bbpqLGjcDyFt3V8SnsR2hyMWida7Vwv5FAfDhnP6gDG9ZeG6iDLtLf0e3T0YXjMe59CGqZq1VhekTJBYMci8lS/l9BlBHoMNlVrW8g9V0h5zsK0IS8g7CV+EsYy/xhitoGtMNnP8A4jni/oP2ipYBUlXAnkkuoVAVC7DP6vVPw2E5C6MXvJbAYsF/EJNev30KAUd4L7uhT1d+fhHKTmXj2YLvBCyKTGXso7aacpS+918TYjxZ6F8vT7nUU7i6IdAkDdJjKBzuEZ72VRIiTqCPzgkGqec2cM8I2Y1CN758AsUb2/s4MJCoBZHKBeUBLDW6hlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM9PR04MB7684.eurprd04.prod.outlook.com (2603:10a6:20b:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 07:20:50 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 07:20:50 +0000
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
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 6/9] net: enetc: add helpers to set/clear table bitmap
Date: Tue,  2 Jun 2026 15:23:10 +0800
Message-Id: <20260602072313.3162120-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
References: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM9PR04MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: a59f4a49-468d-443f-6723-08dec0777938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|19092799006|376014|921020|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iLLl1UuhLYMBYzTvWRce9n+6rFC7v5sAfUYhAKqLH3X4naZVf+5LaSMY55BrkQEy4mx11Jp3ZQSfBJLh3GbrIFCtB/hYVqXh+sg4rZPw8TxwRiDvtkrkZETMN0r8uUwOzFjyoYtUWL+IN0jXX3HIx2qFO8nfreeEQVa/0s9vP8buf1GHBdSIGLzzEcxpZU1Uqjl2rRqIIbDLpqMdoLAoeoPfeyMQAN/nBxAab1azsEl4OFQzvquWlaz1aLcYzASKCYt3ajaE92Ph4ycubakft77cGDgr0yzRQzgaBbcNc6GuxBUIYL3mp5JnMxPFYiNxpgUD2yX1zPBpwZy6iYt9D7AIsfIlu0bUMdaL2hglcaesI1XTTU82FZI7oCFTWwlNJpDvHfHjrQv2EF68tVUi8Enfo2t2bdVtT1HX5DyLI9tCETMAR054+u8/xUJa3T47Eakf1BCuRKDM7ojf6bjBU0lSstuQKqAMUWpOJf/ZPP3em6fQ7M72PkCrN5a7GgAeulLPqr1DjBNwiv1qfKlSIN+9j3ycE95De0vsFTnKDwITPBH2ufMJ9gx8t5/1pLkSTrHjSg2nKQ2jYNqQ7prQstKKN2ElLOxQhyrasgNVb9EgFyEEbJqFrKiTPUO7vzyU/TagunMokcfUt9BNX+YYdvYlbwzUwoxjGgt54UtTkCOuDd+4dBsoF5DJ9rrS3klkTQUDdh+SuwFvpGAmNEQ8cl1ZIjSjw0sO6z9t9G7Mk7w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(19092799006)(376014)(921020)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?camAtxxqfBGu9PymBcxeUrdJ4yYVgdy2T4SvYnt4dHE+i14jPA7EOiA+bQIp?=
 =?us-ascii?Q?f5V0GJlKpGnR8ZNa7TRVDRhS/zJssN9qlQ4oS+0Crqb9hRpDzERhkqPHnj0K?=
 =?us-ascii?Q?2VFKQgCa5j/RZbkeetnohH4RBbn8gZvrlrDEHTnvkOX+O1fCJWcTSWA7Y9bA?=
 =?us-ascii?Q?VYNOZ4IgjFrcfXX6ukJ0JvNCcphJlCp1X29c8uFHgsKcYjXPavMrnpIxtklp?=
 =?us-ascii?Q?BVzfqk31bWnkjQc2O2UNnHv4UWS1seTKjy+xHHQaBWVkfORNdWhEq+LX0KSm?=
 =?us-ascii?Q?2khdEJpD41tiajpZiGF0YAq5pogJvPHpfc3z9UtiAV3jPlS6URmZVeLRjapl?=
 =?us-ascii?Q?/thdgMfxJFZuPPRFISwMuWZexXHVxQ+BElkOiAcAiu2k89dhgeOaEBaXmse7?=
 =?us-ascii?Q?HZjpL5Q8MIHbcZBvEicErgUoHSM5qAK79ruIVVXc4cU98ifEshRYsnC0PlcQ?=
 =?us-ascii?Q?b1+sfqRNuO6pbTO3H4MzgCdOZ72/+fmiKYzG+e2WgqEW0dkQCK9LRKUVr9oj?=
 =?us-ascii?Q?e8uUrrbcxwJViPKT+4DYD9kvKzhZ+lQHOoRQPIuh9EhG2EvVsPvOWJH3bmKB?=
 =?us-ascii?Q?cevTUgv+osSHhlJEr0ev/PBGQNOaa3FRWX1ouqheal7CjM5WGMn2WAb220hs?=
 =?us-ascii?Q?mR2IXB8qv55E8Fa/LJOWnYecee0zdTqcyYTMc8T+ay57EkA/S2T2u4ohqm7k?=
 =?us-ascii?Q?/L/SX+lS5/imeDGs1lFbX4rls2fP2eZpzegNB4FVGVBWQnIeoWF6YNrEd6m+?=
 =?us-ascii?Q?Z7oaQfYy1uBR8ENfYLgxldPNeVyEJQ5YD9Ni9slHTPmcm4Ox4Wh6oqe7i6P3?=
 =?us-ascii?Q?9hLEq7E+pkH/Vqtfc6Zhyh0FVGBvLSyMO7YGCMspdI0uiUj8v2QbGxzX8rrq?=
 =?us-ascii?Q?ijyUF2hs92AYPsGrfIrw/HnlawK/1wMN5kWo/GSCKEeSd5gDJwDYmdeJlx1e?=
 =?us-ascii?Q?UA0GeM9LHaQp/4YSs+ZHi61LAlQp6w+TzA1/IY0abIGD0/bQ6e/YjRBSiK5x?=
 =?us-ascii?Q?7KjD8XKRMW8BXKtmK6I2QkOJ3T4RN36BrkZXwnDPB+hdxnlb2J2AnSqhGSr+?=
 =?us-ascii?Q?l9BgBrTS1VJCMIHI/kgcwhJ1vJ/lG+6f+zw96/ufAlsjax9KhVNAmylxvzHK?=
 =?us-ascii?Q?lIcH525qQPXDTckI9erwFm8/L5xCt/GT3iU683d2z5xUhp7VpTH+xUEti9LX?=
 =?us-ascii?Q?mp0jn1Ivtw/poArJ4kkTeMDQV1y/w50B2+CP6MhbbYPr6kw7UBea1jOZumHt?=
 =?us-ascii?Q?epZlJB+n8K47ld0YElWwRiBhNSsf43el/38CUx01a21SN51Pq9C/ih+DQ77z?=
 =?us-ascii?Q?V99+VvC8eVZofgPUk1iRJna94z6x4rMCZO4AGGEQDTS5cDxXfmFz5Nt/RMtU?=
 =?us-ascii?Q?V+nBx1/29JEeH/lNpMLnUc1p8lHRaKQJXgXng4pUvuygRVZBjzIkemip5Hcs?=
 =?us-ascii?Q?DctLCQCUV8lW66LUsb8XRzO2+oynXSOwmIkFvHI3FcmHKoPySIBwWuWAbpkz?=
 =?us-ascii?Q?gJJcBE02KblJQfmYNZ7PwVmOkJup9n0e575MkiANU3E1baMrUPYlIXuSlRNj?=
 =?us-ascii?Q?VF16bXThIDITn87JvXXtA5MatNHn6XmlUAoiqRtogYl3GGIfn2LyupNpQWlb?=
 =?us-ascii?Q?Rpe7qnF4EtC3fJxTC+1Oc+FrAlXGiTLsy/tF0IDdl7B0YST72xoArlyWHLrO?=
 =?us-ascii?Q?9euw+F+pOvr0yZ16q3puCfg668q2Qt/bbCbR0XlZ9Hj6b5mJ1Ukp2dUMnrUw?=
 =?us-ascii?Q?QfM+2QWLfB74yxx0QrY1xzj2k1htDy8eskDPU0GuD7GjYa1HtGyD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59f4a49-468d-443f-6723-08dec0777938
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 07:20:50.2879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uepna9gCdbojL58g47F1N2sj/dAqtBX3pr3kRUfHIClXUC2CeQQ1FnyJaC6Upbn4rIBbUannRYfyxskHDtnlSV5xlZ4+XaeD5qy3xCzJsrFcuh72nbVYPMcl/Y6g9QIN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7684
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
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294063-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 084E0629B16
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
index 03a4ac6af56e..b2db91683e7b 100644
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
index 1e087316d4f4..531c3b9982ee 100644
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


