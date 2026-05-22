Return-Path: <netdev+bounces-290746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PqqEU8hEGqjTwYAu9opvQ
	(envelope-from <netdev+bounces-290746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:26:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9AC5B124B
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0C973036BD3
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BFE3CAE63;
	Fri, 22 May 2026 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vnbh7YeN"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013018.outbound.protection.outlook.com [40.107.159.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0063F3CAA25;
	Fri, 22 May 2026 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441773; cv=fail; b=KlhT98uMCnRH+o/SEf2JZClLprEYgPuSYF0euflYsAKOCcr1I/aUIBH1eo8TsomqNMHrpUqWM4hPfxfWTC4DhPiXMpyYkrSJG50CjnCRNT36c2dMiRmRkNbMHi2eMGWVdLGpsJGYKCXQr2ss97Cg32X0LERq4Tt6Q0M2rkN+Et4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441773; c=relaxed/simple;
	bh=kefgn9yTvanZc0mnMVal4X1fHCwjlp7c9lHqW1B6MfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uTPclUr11a4LbDt/dMCuOfA5twVnuSuvCdP8p9BIWd0WMYdf9YKhS+J61UkowTltKzLQUt1H2XzFLFp/tfj37R9TDUwIcp9qpfWKXqB4/+7ZsLJSPvzIgZ64SzbYBvxtAgl1Wpss5bRHHf+7zxOWjBvS5/CE2YrpxSyweoscn4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vnbh7YeN; arc=fail smtp.client-ip=40.107.159.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIK1wXHXkuCq/KhEkSficGuQryC5qXRSmQWHe5GEbjaQxHXlRbl4x5YVYQSjWAg7/r45tFu7KqRrzf3+xswMua510nfTio+7yoydCo6Tywj+h4EPuNYL6J4/fq73SnVWr1WLVKXz5HTWZffUeLRtu7WsakngfMe4o3ToAVBc1MFHnaWE6PL1QECj/5BYSACf1zY8G27KYC8OpmJt2neBglI9kN9X/Gd/T0KflM5M7wP9zsPsvFSfhdlz1Bgr/YEeGy9ARXWrqYFIMvuuBX9tyoBPeZsuhBQNxn1P00c8m1ra2lm4fts9XH7nt9Pq5Fan4H9zIh85zNP5axt2azKbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKk4dkqRTy3bCCnIqELzRdNy02fNc2O7JPXxV3Ak5qI=;
 b=niWyQ6ZSbPcSVUgulIPebI905VZLYg5dpdE3R/a/R7DJgbxIeAx0vW3SCJRyARBBIjQgrWuvMSeLvuD+Z16CM823OPysTRmPgjj+WuErptRUBenDZwdvX6JEIaXYRkVlhBMC+ysgwSlMLCB9wVfBUHAZp0PcZRYr5BXR/y4P+pCOCGcJGzDTmDqOb6no8ZpkUtaCHxFtsMEmpdpj6Kawe1yEfZcqqgGgymwvytEHxdFs4y4r6sd8+GI6TvIf2csabnYISaHaZz27yy3Ax1ybuNHd3p7bxIVEL5uVAJb/93WgG2ZcUruDlkfq5yyhvCeOOGNSQEZzPbWzAvLEajTZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKk4dkqRTy3bCCnIqELzRdNy02fNc2O7JPXxV3Ak5qI=;
 b=Vnbh7YeNs64jMhe5fVHFUUxViXyJWcRzvUJ+TzlVp2YoAvUqoI4nncFPh9nL9sxTHNC5Q7iwYOLWAR3/r3DqVxHgfh9PfsinW7ouMOW4UqBEK7Xvhw3ASNboxCixdzz0lQH64bZnYfgZQ8T84I5T0ylxhLPqiV7+h/Z0+pANq6psNKX2ksAEj97ttPQb5zhkDDMo3FShFImErZWFA3zr384oEnj3hv9iuc5fEJBTcF2bZSz3+fvsT7/PslQoM4GhNRyzMHt7fQEM5DvBeY8fT80oepLI+gSkXIuSEA8wZCTyFhXXQVBZCQRccWqYYQKFy/dEV8JnacG1SZixVcb7Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA4PR04MB7949.eurprd04.prod.outlook.com (2603:10a6:102:cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 09:22:49 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:22:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 12/12] net: enetc: dynamically allocate rxmsg based on VF count
Date: Fri, 22 May 2026 17:24:38 +0800
Message-Id: <20260522092438.1264020-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522092438.1264020-1-wei.fang@nxp.com>
References: <20260522092438.1264020-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::6) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA4PR04MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 6376a531-a252-42ae-886f-08deb7e3b11c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|19092799006|22082099003|56012099003|18002099003|11063799006|38350700014|6133799003;
X-Microsoft-Antispam-Message-Info:
	7VejxXFj99Xu1A+OXqadiD+qpYq6yryksb5NSdh5jB0EooRzGiBv9bdXl5STrOyz6iLlxDu/ahqLPH+gh89aMh4RT5z9FlLOv/JKb4M+bLlVwBt1ENyVdL/94yqR3hDwEonQWTSRvsDoUVERGg6zBAklxY5q/P6jKk5TLiv4UaNxnpdzoSXvJF6GdgftMrovfCZnAAb1s1kipX4ZfqCKtP2HQrXts+sQJmMbudw9F4jh5WOqF0YzuB3xWY/Mc5ZZVRKQ3iF3EHGBWEne+Rt6qPc8yfU+nZgXxRBrZHrgbkmcTtbAaTtTNkVMqFpGBwOa3pRD3dspkXLtaMxsqQz2jPZxeVxqFL8PM10wk2M5kJhKlywI6tp1X22i63P+ZzJmejMf2EqxaLD3JCa+fX5aMcE3i8mgHBt3pyIn1rdXa5+WXnBz/WDdE+aXZVsUeRJyoWvIEZ7PgsK2TyLJbvPe5uK6Is1sh3pzXtLXuuBHn5CkL2KJFkxmKugKzbsfIX7mhnlnwJGAkNUYxSNcZH2IqDNXy+HBnmbuoXky7gdyEDNic/XIapE7sxsqE5JdGCPPLmiTgnMgw3CBtXDZRwFD2DN8P0KM1BODH4Lj2SUbO3SxDcbwOCvKgXSmBxWE2F7jVLpuQPCO+brp2Z9qEr+VznIUVNWaBfHNpa0BtZelz3nu027mzBZw6zuHzgT2TKRKluI4wQ+A9UuvbdmOU6kHUdEAVzG9QtmxvtqHfh5WQ3wrNqE3CeUVjmvXi1Bf0rgs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(19092799006)(22082099003)(56012099003)(18002099003)(11063799006)(38350700014)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mNzFi+hkLjEXd+kTo7qgZq8R0N95nQUFaqdPOM3iTrQwiDh9o+wTocjNoJ45?=
 =?us-ascii?Q?NniVT7s/OyB4TpQ3hlzt2Nqtfbp//aoH73J40U0upxRpumwalzrL0IMl5GjO?=
 =?us-ascii?Q?TO6P/7t/cP4kE0NRD7WaSm3ulVjAMBDnRMm3dqxceN6xgAahlE6D9fxih8an?=
 =?us-ascii?Q?kGOOwZSnApzI0SG2KhNQnIganT88N79nVXsyxdsXFEmjO0G3vQkw9QwPDdfm?=
 =?us-ascii?Q?YCtalaKAj/sPUpxTNasJSMH9Hryw59RRWoUOI34NjReQKM2VBIH20mA8P58v?=
 =?us-ascii?Q?H/8Pnwsj+z/g14kXaoDJA4mxj9KOovNZ6v0JGbPSGYigcdJ255eFQoZuCUSv?=
 =?us-ascii?Q?h07wt5RKKrGcN5OUR3FvSL7btEx44iiMtfV24u2Re0ZOO48iZas0wrSI65ZY?=
 =?us-ascii?Q?4dfOd6G8bj/QwM/a5Yu/w5z2MsIZbRaJ2YRKESxAXR1xqfUPJHI51ZtQkab6?=
 =?us-ascii?Q?QH3Ff0XkAjLXIMQIVg+P8xGXFONG5XGq35R6juWQobwkkBKiajdevPD0679+?=
 =?us-ascii?Q?mg6PH+RW4Y4BBiSo/2zug27oGuaa/vXTh3DPuljeDZMOu/mcnA66mJPoF06i?=
 =?us-ascii?Q?16AsZMYAEM2PRYyh0EX7Cw0xcD40KtckWigjntSRGyhXhcuxE286WoJ/Gnzr?=
 =?us-ascii?Q?1jib5VsKvCXhj2KHGJAZQWzsY38KHhlhNhjvi7oxcsW8Cy0RJMYckReTFj6I?=
 =?us-ascii?Q?IohenzFZbOoJQ7nnUer789w8w6RDoffyc+wng3HQnB5nTBnPoi1fax6tLOT2?=
 =?us-ascii?Q?aDI/lJ6k/tgKy+Pe78/nA0jw1rWF+MD+/Yd2Il3BaWlhGyYNjPUIWnGbGr5s?=
 =?us-ascii?Q?d8H8wZCwef/NHG5ZcOREfAOw/rsNeFJEJWFs+cQobCb/BrZtYNaROL1qlDaL?=
 =?us-ascii?Q?UwioiEgODQlOAexB3L5GnONmdqvNYzJ+SdnnpMasLmMtIaShbO0kFedyvmMD?=
 =?us-ascii?Q?KuaG1ftV8kaPU4vjygBZQzLXTc+bwTTYY+zcUjQojlLkz3hhr+g/vIX6EVNj?=
 =?us-ascii?Q?itJvP2Im9jVvjmoOIjXVchon6Y2akMRflemHyFdHRZKFVgoCYcdbhvAN0ITA?=
 =?us-ascii?Q?JlfWgZWBwQklcdmTnCCEVrbKJb+x9rOhNPm6EDo7gj12p2GURokrAEszB3cX?=
 =?us-ascii?Q?8EKko18TlIGE5x4TIq+3G1t2rAjKy7HEzM3FcI8KYeLj5ENxWFhCSUFv3FQk?=
 =?us-ascii?Q?5sLB4BgPgwKonQk99JntdkMZK++kPfvgHI0rP3zy9SQ1oHgh8SNnRinlJpyA?=
 =?us-ascii?Q?VW2/TIhZamMcKZ1PkO7MyrdikI7lP+9KEiFkQ3O2Mn6F80ctbT8cNMmTxBNG?=
 =?us-ascii?Q?YYOjCw0LkTL6q8+hz/3m1VepWd1auSblIvIURYWvm6Z/qn01vMjgwIagVIf6?=
 =?us-ascii?Q?XvrfDOHdOE4qH4zbV7gK9gZFLvy4aRaFvKhZi8b/Ztbr9aecASwwVlDVbvtv?=
 =?us-ascii?Q?3lK2m+Owrhea0p40Yddq/J9dMA68+X01KJKi9rX4aw/LVNBbWa+iuTBE4pUn?=
 =?us-ascii?Q?eZGXZTamZSrC/QkOjdOvCoVEZso0QQSX+KvPl71slSYBTglSYTt6g61yn3hM?=
 =?us-ascii?Q?6ryY9e/oMB4B1pK9LScxSrPikmxdmmRe7Z4pQkz/d/Jsl64EScwV/6JKivK0?=
 =?us-ascii?Q?uflHK6blP4yUX7EBPuSqhUCXPZEE2CqtH8op/qTXZWA1MRlolPEp2TuMlBgS?=
 =?us-ascii?Q?j5Z6vUr0XtOv8fNtKYFfv0hkvzS6f4dC0xaGys7C2PzEwFTufloz19/BotLM?=
 =?us-ascii?Q?0AFYAIeN1A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6376a531-a252-42ae-886f-08deb7e3b11c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:22:49.1388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IKKwmagmnSHakht/Lut71i892ry3hOJLb/oRJBq7NNEbU1keKQtwegjpGL8ib8l8Cbj+1xkCaTIQOrCzuEydQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7949
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-290746-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: DB9AC5B124B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The constant ENETC_MAX_NUM_VFS is defined as 2 when enabling support for
LS1028A. This works for LS1028A because its ENETC hardware supports up
to 2 VFs. However, ENETC v4 has varying VF capabilities depending on the
SoC:

i.MX94 standalone ENETC: 0 VFs
i.MX94 internal ENETC:   3 VFs
i.MX952:                 1 VF

Using a fixed ENETC_MAX_NUM_VFS for memory allocation leads to
over-allocation on SoCs with fewer or no VF support. To better match
hardware capabilities and avoid unnecessary memory usage, change rxmsg
memory allocation from a fixed-size array to dynamic allocation based
on the actual VF count retrieved via pci_sriov_get_totalvfs().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_hw.h        | 1 -
 drivers/net/ethernet/freescale/enetc/enetc_pf.h        | 2 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index e58cc81d199d..bf99b65d7598 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -681,7 +681,6 @@ union enetc_rx_bd {
 
 #define ENETC_MAC_ADDR_FILT_CNT	8 /* # of supported entries per port */
 #define EMETC_MAC_ADDR_FILT_RES	3 /* # of reserved entries at the beginning */
-#define ENETC_MAX_NUM_VFS	2
 
 #define ENETC_CBD_FLAGS_SF	BIT(7) /* short format */
 #define ENETC_CBD_STATUS_MASK	0xf
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 64e2c738e8e7..285b7e5c48fd 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -43,7 +43,7 @@ struct enetc_pf {
 
 	struct enetc_mac_filter mac_filter[MADDR_TYPE];
 
-	struct enetc_msg_swbd rxmsg[ENETC_MAX_NUM_VFS];
+	struct enetc_msg_swbd *rxmsg;
 	struct work_struct msg_task;
 	char msg_int_name[ENETC_INT_NAME_MAX];
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index c423eed6bc78..6e5d2f869915 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -443,6 +443,12 @@ int enetc_init_sriov_resources(struct enetc_pf *pf)
 	if (!pf->total_vfs)
 		return 0;
 
+	pf->rxmsg = devm_kcalloc(dev, pf->total_vfs,
+				 sizeof(struct enetc_msg_swbd),
+				 GFP_KERNEL);
+	if (!pf->rxmsg)
+		return -ENOMEM;
+
 	pf->vf_state = devm_kcalloc(dev, pf->total_vfs,
 				    sizeof(struct enetc_vf_state),
 				    GFP_KERNEL);
-- 
2.34.1


