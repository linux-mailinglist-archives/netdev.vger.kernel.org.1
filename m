Return-Path: <netdev+bounces-288835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHuOC7iBCmoo2AQAu9opvQ
	(envelope-from <netdev+bounces-288835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:04:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EC056542D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D44C30098BD
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2718377006;
	Mon, 18 May 2026 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="grh8snPm"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193ED3822AB;
	Mon, 18 May 2026 03:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073426; cv=fail; b=X2uXzmHP+5ds4U4pydlYAzAUl3+Cy/4tK+Wv0pYG5WGARUdg9R0VGpaDHb9LBg3D8QmDHXSvCz4Ryi6f5EdWiDW5S61EmB8Hgxt8If6XThHHGja80GvQYmFnBUA0g0ed3Wa6Go58qv/zEDbkSJyXUxST3v9nCjmuOxB8v7Bzi7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073426; c=relaxed/simple;
	bh=0mX9eKjhwV+0tHAGDlWjwx21GCQK5D3pQ2Qz3kssKOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pxFQ8mmTbPV3J5p8+FEBUEU5Hy3zQK11637PoMEDVWzFE6A4llm4O/8KkGD5IduAAiw7PNrlrRlwT5YQCC5wy9VIfMeF0WCw7kviCN0akqRajhDCPn7EDj2ZV4yIEDoXCPKABrPpE+lqsmFFEMRLisUwLtC73v2Et983TjLW6+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=grh8snPm; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMGCnooDP7dQdQwFx299G+nIzsrfJaa43i83tJ857SFhZWjory4seWDEwB5SlDfqlElk+XAecFLxa9h9NZPEZ4H95YZZKq/Cvw++bW0xFSS3umggKjTul72ZNr28ASeNQy5eC2lzSt1H/Szli32y9Vv0IyNKAqj9S5pRHXeXoxcMo9U1ZHRDzunDsWMV4fgU5oGYm+FJc+lSq/Ff31dVVi87a1kULdu/p7hoHX7JjlfENyjLOuWXZwOpSn6JzUlZCPvGhPqLuxhWdlbHtvvmzXQtBgbBEp+CI+xw78N9eXdMQ32TWJT3R/pVFOk1TcPRlfRCD/aSgBC8NHbaMSxtdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IUwPfSxGy8AXsxXQ8XyMI2H3OD5NN1gY7/JxMgwmdQ=;
 b=CRLbkVS74X/MY0D/DXwM9aL9htLhIw+nCssh6cTA0c3pdOASaUfPrKeOg8L4SfTiFOJydOWRzbhrAPnhZYvSdCWOZxa1djnmlEUS+CcYNvQJTkv/3xt0tBvnMYTohOt2EUHDPzStpVSqm+CxOq/Dvk53PuOWOhva8EE8p6C1pxKJDlIlvEd3F+MiOzGkPb0JiERgHymms2ss2zYNfcscR3BQ7oJcqweEBHwSVLWPHT4d9TFqUiw5/sBci1pSOav5ZG/wegjtHwQ2ckl+f5ZotgUFi4YplUYwc2YEVBZYT3uPf3OMWBLuT+AwqXUnW1kBtKOSuWGMedK2ekTwZ/D8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IUwPfSxGy8AXsxXQ8XyMI2H3OD5NN1gY7/JxMgwmdQ=;
 b=grh8snPmEQSV+OOjG82U/NLNPY4L4Igz1E5Tp+BYZJ7kG1g2wTLtdB+u1xpiQrr1Pb86YlFbasRh/yTWlbpCBgW+YuIlwTjEuDZA/3d6A8n5gnMc0jKmYMwif3+LAt9mrO3rFT5lrDumeTnygXhaeP7t0BIkdkjzXQU1JmgrUexNFVhG5U1Rj+OhpMk7dvDYZAyJhES3DkXuuxqs5Ejwado5hNejGs3X+dz4cuq8T85wyBSbhjFrvCDGIdBO0qNWAZNzY9lNGhQar4Ykb8rbBkK5u25QjemSHXS1WK/i3nsFXxDtTXB6Gl2rRCDBcWdXPpOhNmBF7IolRTy1Z/XfTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA3PR04MB11180.eurprd04.prod.outlook.com (2603:10a6:102:4b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 03:03:32 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 03:03:32 +0000
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
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v2 net 8/9] net: enetc: fix initialization order to prevent use of uninitialized resources
Date: Mon, 18 May 2026 11:05:34 +0800
Message-Id: <20260518030535.1057228-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518030535.1057228-1-wei.fang@nxp.com>
References: <20260518030535.1057228-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA3PR04MB11180:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bb23df-660f-4c6a-2e7f-08deb48a0b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	TIg2ZIPUhxfrXMXhr9XGHsAAavYUr/N3Kg9bffNvcnswv/y9P2W3HeQHYPOPWyT1NktHzV8uxbePRGjr3WNlfrnRgVVGRXJ1dojL2eYtqOnXpGBrhBfDhPrdzOLuSZrFwGeTWDUsT23QPEk29netFKvUQdEInMYZveUpmlWv4EDkroNdzGieP05cnBT+GFi6DWWGAB8jjVivKknTixHHuhrtLixL2TDQdYyh78WFTmUkxxjcw2UOfHr0eQbVpHiB9syl6ScPogtC+02Mz3s80Rl6NRE5ppMnE4iDLZjOAN0IImlAZ+Hfc9zA2KlesGFSbofgVNgwnMHlnFuXdJaPR2g4BavpZRq+lyT4ocOcZ8dDx9rBmIYeuba1y/nuL/98yIoUeBXQyvaA06AAkaqmbZDSso6WPb8JELC7uWK4gPmznHiDIhVSLhWg02vjBxzyCqJwDr/hLUHIHnrJb+7+Agh3aMj41V4uwA5cTYKUzGhMCCEFnIw3HREWSuOLnpb/4InnuRFudiZWfV9nZhfk8s6SqsLQF9Door3HybNYgcnaKgxFhP/3LAFtz5XwRA6QTzdOq8JUvZFs5Yn8+2FpnlGNVVIqohjp5CjAfbsLyyGsAzDi00yahCPbtBDlrHGukCQ8XVnD87vf80PZ5mHkNyotDIaqgxe02O5XcTXITWS7Gn445B10RZbeb5beKk8S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d8tGQNydt+OV55jzY1MCA6k3LwiVpLUdMzF5L6X6kJTUkSiF23uGxUGSlOod?=
 =?us-ascii?Q?MMma+p6JRst5F9CFNMdgxoUn2oEH1kLUjQuSqXMSkn2P2l2QHqvPEy8IDOIZ?=
 =?us-ascii?Q?Fia7a2wzWNlA0QViGM5lXTCFnPGQWQetADmvwgruBD9d8fL+1EyIcg6MK2CR?=
 =?us-ascii?Q?1Z2isjWLk4Zhw0lp9gIEZhl4NLYwJVZGp1EpcLb0J7+UkplDEyHKlJ9WGyt8?=
 =?us-ascii?Q?UxYPs2DnsmCS1RzGpv2/8Zwmd++d22hBtnqITYYxO188t3SfD68T2Y/9eQIW?=
 =?us-ascii?Q?KdyWUcd/FQ7QvujHN3Sad/Ny5QocybWLKuJbojChfW+ZHAfBGd+23vShipLN?=
 =?us-ascii?Q?3/Dp1oZ5rWzKdQI6U6iwZKFfh61hXvaJB4oCxjs+YW9chPCXY6kyCXPeQ7oF?=
 =?us-ascii?Q?2NnomJG/uDQ67e9Crk01tKE/V6wSRPMuFBVHxQJrrimTkwNirfiXg2mOtllN?=
 =?us-ascii?Q?f+dnZsEMOmUMo+tVsxalKuvSy/Uk9rVLro1owyMotZVJF4nkNSZ7FfSORuFZ?=
 =?us-ascii?Q?4JDjNIO/p5GRLxWgFMz1ewtk2Q8G0OA+bSaL17au4gPSxrrnVSScj/soenHV?=
 =?us-ascii?Q?aJB/kQUoks1ptZr6sRvwU0RGHK6dJv2p3T7SNHw0uWcjMkMdSCvUXCJTqsqd?=
 =?us-ascii?Q?WlBbETm/b57+Plu5Ixbh+vARUVNAHP8Mt8MRF04twPrWCxZv8EIiCJrEXun1?=
 =?us-ascii?Q?MVKHSVxA4HnPKBrvfjjz92IlxaRcfvZBw1AE9U4HOinIfcSWupvHNgh7ekDi?=
 =?us-ascii?Q?eItVscwHX3zvlh60b8R/lgffVrO/MNDz8AU8wKWYp3nzrvtGBu7HiDNt5BU4?=
 =?us-ascii?Q?QIxIBU33jFXsDbQ1+h2AzaSQIN/9aE/dc6BuqnzCC8wtoo4DrF2YYDYKIrmq?=
 =?us-ascii?Q?TYcteGiw252LsIPyBXOkZVah6MPMYYSEhdbys4p6+g7hHMPvoqtCO7WDp2GU?=
 =?us-ascii?Q?VFFP7Na2HA4ZhCj+kC2qEt2TN+UmYlBhG+zHK5SH3q97nzWU0CKXV9e99Q3x?=
 =?us-ascii?Q?Oj2NvSTnCxbAfKwv9omB+B9CUJCyyGduYqlrZ9e/LVHxMWC5qs7TeW753Uxs?=
 =?us-ascii?Q?NkoZz5FeVRwjmbQXfBmsfwk0/SD82R3nnOKj3vH3zlBoMQ024komsxBKtTUf?=
 =?us-ascii?Q?Ve93FQKe78pKSqxe4bU6mzaOHG4XfByF9BZbGH2sVxocjNIGCuIcs6WsWTIf?=
 =?us-ascii?Q?6hUD/ir8FZD46oGYjqV/QGzJ3HB8O/ma+jeEbY/4butK4S6D0Rh0NJarmncX?=
 =?us-ascii?Q?ttlVgotjBNQLChmqiWvFezfhbdRitEf/5ACpzb6Jtzg4qen9nPULJnNBx+W/?=
 =?us-ascii?Q?u8GIqqftFjKMAPsHkdsLkL+SmvcN1sWGZguRDkn3fD92Z7y7T3eJCmgmAAXH?=
 =?us-ascii?Q?LkXr6H/lXsd4Hx/v45Ezpqh2USMI1H3JhjqBiA826tZE8ppc2X0jKLS/oww/?=
 =?us-ascii?Q?J5wVxiVQ/C0KtBj70GoV4VEq7SXOFXkH9ch9OPBszrHdwjIkew6dNG/YwPo/?=
 =?us-ascii?Q?SdN3SjsclREmHeDa2/HdXRFBYWlaAchdj2XTyJqeU3jw8C/dQmrnWfkmHqLQ?=
 =?us-ascii?Q?YkMWGd+kLgqE04hUpaAh8+CzdPz1Q4+cGpNF6gPYik8zJI6oNSaod/1rFgYO?=
 =?us-ascii?Q?XupcDvR8rfBw9renILiAyUGYTGXYRgbLy/N2YubLARjiKUmlblyv8Wk0uJAV?=
 =?us-ascii?Q?s9Ga4YARKtYVNDLRNVHBFLMPQbZ2j5P7KqFUlcmdSAlkiNfn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bb23df-660f-4c6a-2e7f-08deb48a0b82
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 03:03:32.7115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pxjjP1Kox1pigt+2NDYoq/llQJoAMhW6g1P8MeVfvN8o6teSvrnOzMMwvKiT3oePJGn2qrXrw3JB9/nhuQlkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11180
X-Rspamd-Queue-Id: C7EC056542D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288835-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

Sashiko reported a potential issue in enetc_msg_psi_init() where the IRQ
handler is registered before DMA resources are fully initialized [1].

The current initialization sequence is:

  1. request_irq(enetc_msg_psi_msix)    <- IRQ handler registered
  2. INIT_WORK(&pf->msg_task, ...)      <- work_struct initialized
  3. enetc_msg_alloc_mbx()              <- mailbox DMA allocated

This ordering is unsafe because if a spurious interrupt or pending
interrupt from a previous device state fires immediately after
request_irq() returns, the registered ISR enetc_msg_psi_msix() will
execute and unconditionally call:

  schedule_work(&pf->msg_task)

At this point, pf->msg_task has not been initialized by INIT_WORK(), so
the work_struct contains garbage values in its internal linked list
pointers (work_struct->entry). Passing an uninitialized work_struct to
schedule_work() could corrupt the kernel's workqueue linked lists,
potentially leading to:

  - Kernel panic in __queue_work()
  - Memory corruption in workqueue data structures
  - System deadlock or undefined behavior

Additionally, even if the work_struct were initialized, the mailbox DMA
buffers (pf->rxmsg[]) may not yet be allocated when the work handler
enetc_msg_task() runs, resulting in NULL pointer dereference.

Fix by reordering the initialization sequence to ensure all resources are
properly initialized before the interrupt handler can execute:

  1. enetc_msg_alloc_mbx()              <- Allocate all mailboxes
  2. INIT_WORK(&pf->msg_task, ...)      <- Initialize work first
  3. request_irq(enetc_msg_psi_msix)    <- Register IRQ last
  4. Configure hardware & enable MR interrupts

This guarantees that when enetc_msg_psi_msix() runs:
  - pf->msg_task is properly initialized (safe for schedule_work)
  - pf->rxmsg[] buffers are allocated (safe for work handler access)
  - Hardware is configured appropriately

Link: https://sashiko.dev/#/patchset/20260511080805.2052495-1-wei.fang%40nxp.com #1
Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 35 ++++++++++---------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 39f057fe85c7..a999f1e7817f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -109,6 +109,15 @@ int enetc_msg_psi_init(struct enetc_pf *pf)
 	struct enetc_si *si = pf->si;
 	int vector, i, err;
 
+	for (i = 0; i < pf->num_vfs; i++) {
+		err = enetc_msg_alloc_mbx(si, i);
+		if (err)
+			goto free_mbx;
+	}
+
+	/* initialize PSI mailbox */
+	INIT_WORK(&pf->msg_task, enetc_msg_task);
+
 	/* register message passing interrupt handler */
 	snprintf(pf->msg_int_name, sizeof(pf->msg_int_name), "%s-vfmsg",
 		 si->ndev->name);
@@ -117,32 +126,21 @@ int enetc_msg_psi_init(struct enetc_pf *pf)
 	if (err) {
 		dev_err(&si->pdev->dev,
 			"PSI messaging: request_irq() failed!\n");
-		return err;
+		goto free_mbx;
 	}
 
 	/* set one IRQ entry for PSI message receive notification (SI int) */
 	enetc_wr(&si->hw, ENETC_SIMSIVR, ENETC_SI_INT_IDX);
 
-	/* initialize PSI mailbox */
-	INIT_WORK(&pf->msg_task, enetc_msg_task);
-
-	for (i = 0; i < pf->num_vfs; i++) {
-		err = enetc_msg_alloc_mbx(si, i);
-		if (err)
-			goto err_init_mbx;
-	}
-
 	/* enable MR interrupts */
 	enetc_msg_enable_mr_int(&si->hw);
 
 	return 0;
 
-err_init_mbx:
+free_mbx:
 	for (i--; i >= 0; i--)
 		enetc_msg_free_mbx(si, i);
 
-	free_irq(vector, si);
-
 	return err;
 }
 
@@ -151,14 +149,17 @@ void enetc_msg_psi_free(struct enetc_pf *pf)
 	struct enetc_si *si = pf->si;
 	int i;
 
+	/* disable MR interrupts */
+	enetc_msg_disable_mr_int(&si->hw);
+
+	/* de-register message passing interrupt handler */
+	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
+
 	cancel_work_sync(&pf->msg_task);
 
-	/* disable MR interrupts */
+	/* MR interrupts may be re-enabled by workqueue */
 	enetc_msg_disable_mr_int(&si->hw);
 
 	for (i = 0; i < pf->num_vfs; i++)
 		enetc_msg_free_mbx(si, i);
-
-	/* de-register message passing interrupt handler */
-	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
 }
-- 
2.34.1


