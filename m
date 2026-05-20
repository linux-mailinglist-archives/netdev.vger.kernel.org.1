Return-Path: <netdev+bounces-289786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KpDFDVaDWpuwQUAu9opvQ
	(envelope-from <netdev+bounces-289786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:52:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A107058873C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6425B30A8658
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663B734F26F;
	Wed, 20 May 2026 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YWISqvlh"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E030566E;
	Wed, 20 May 2026 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259361; cv=fail; b=KOefZy5XHXy6NUvQL9AmmApnzPrBMsxeiB1UhryFSteIvKa3TL0LIu0EVE5b4KVh9Jq8iJW3xAx/2vDOPFN4uuyNR2pKlytlOLVvL3r3p8rpdIQmyEBLHtYS+KRYg/Jolc3TuZ20MfuXaF/nYs+DGC4SJb1vIQpwB+CO2pMw9n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259361; c=relaxed/simple;
	bh=gn4Q8jWQPsC7S6u5aJOGbAdDEkcK2RG1fkpUKafZSd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gDX9ddNu+jpFdJcH+3logVUq7AjxJkMIIDqtI6JcUccp7PrD3OYLCFixqMuw4w0qMTmwlYUqyOCoXEMHuqRxOmqNFB5VGXODK8b0olMTlOYd06n2YmoT0+YZK5LBCFS5s3nJBoDbXzeUw761a6PzB0ZLNkkBqH3WefwRX+ZdTAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YWISqvlh; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpuT8TfQToeINx7OwEDLqHVPGJqw6jhBOuWN0rcpf1dApaE6aB6cyTiEdi+ASrFkcHy+AQ3sBh0dWTCE7vY90cRDxETxVeeqPPX6zZv1G8eb+MByFkgW69bfQMiZe1lMGn4A6rXmeLsuxX8AKalzrODzgCpHfBab6sqHHbUxI9lsWseCxepdp9ngHg0Y1SR3rWKHha/+e7331ML/IytZHtgVsxSGKOed2K2I0axG2M2q1AEiUb3ZVQ4U3hQinwrKOXgB5qcNePq0R62Ze3MLWVAmlqzvEsK6YN7NSx4UVtSKgJ3CkCb4wIBsMFN9/5krmiIldmwmNzUeRLJy/dlGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1NePTMQkheurv3ZesBS98wTc2Z5z8HaphatNlThklM=;
 b=VRUfmoj41+WmnHTsCX4MPkvsT8+Yjq7W26t+LtPBm78pO3u2/5Ccl+kV/vCexbvZVDCCcvo6TnMkfZmYVqm4Ap4H4hqXtWmcOodOKBWC96y65W1ZdHSSRzxIHPpRYQg64yWEruDiFRU1ageFA0dUyJ7Bqniw+w9l7L4GjWeAGsDVqdpNL5Zu3UYvYzwh1Q8B5+jluYO3SOADrUvKjXbdZj4xUgMEvNX2Q4Th3QkShQQoifgS2VWCA0BE806eMnunc076VBMFrKYcwvMWtTwDdVvQGvRddHx+iL0ryANsMuN/wclPtshgpA8c/DCDyT6g2cE7/8OyUIQyvpKGvpV2jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1NePTMQkheurv3ZesBS98wTc2Z5z8HaphatNlThklM=;
 b=YWISqvlhkmQVtXZvqBZoj//BKNOeXvVixf/UWmJodJxvY0n9unXqZ/TUVFbfiSYDJhCXZvEG1f+RhfWgg6/4cHMWVUD3HYdFK6IZuWjk23RTCIUD4XrC1PrVttPhn63ZFGXWNAASCmuQFO0OudbZCBw+JiiHek9t8zhFIfN/HL6tZLfUfyAtMD+6Gjd3wJ9IsQC215k2UIpxN65ZUoufPD0ZUWcwuy8Y9+FckHx8/GUKyMovlcM0yZhmAUah1w90aXh9lU377D8KhWZANOi5Q7WMmDIJhTL2WhGNUS5WUYCNnk2FwTD0O+2e7EfGmEBqiHXcN/VB8wKQ0o1SYH1djA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DB9PR04MB11659.eurprd04.prod.outlook.com (2603:10a6:10:607::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:42:35 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 06:42:35 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hramamurthy@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v3 net 8/9] net: enetc: fix init and teardown order to prevent use of unsafe resources
Date: Wed, 20 May 2026 14:44:20 +0800
Message-Id: <20260520064421.91569-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520064421.91569-1-wei.fang@nxp.com>
References: <20260520064421.91569-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|DB9PR04MB11659:EE_
X-MS-Office365-Filtering-Correlation-Id: f45fffc9-7206-4bfd-7ac6-08deb63af9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	VP8O00KzFDtRx3l5GVWNaagHOUOdpEsF6MCmyyvHvWzJMd6chDTJS9uN9e9ZEeDOqzL3q7pfQ0bNqA0xpaCzFZVqlPfqifWmQAUP3w8KZideSAyxrj37GnK3PCDRa7DzHlMYqI6vxXheNncih4O3BiRUapmSnMafCuliyYv/MM0Pu1YHqBed79UNF123YnVXTRvPJH51rTNlUzp9SItWhAmC8EGWWFd6MNyGIIALcWew9PVawJQeeydj5WeNQep9kX46Euh5GH5CSFq/A59oawpwaVzTMtHd/Qk0PSHqvbG1TWoQ/Axpr490HBz7K1V0+sW48a8lno/u+tGMOvblkSLl4ipwqkruxpgxW2nN6Ra6AWZCcZeFfNrgFkUP1tAvTaKi1NAHsKwCJ2ESsnVscKOYFKe0SH2EwCEuxcsQPU05940Osk2Y1MRc6tDOQ618aexDWJARf/z6NkBWYcr6Wjj0ngBrB43dda0uXPB9UDGBX70CnaaBpTc5eoaWXhNQvjUevWuOJQPK1tdSL+xL1iY8Lg52AEqI+eZkKxF1PpBc4SzkF2fc80U24JsgF3axzaZzUdH/dF6mEJdXSMHDYk8gazaC8YXYw/rfC1yyKzgSo7r0nAmAT8b6cSoB6y9xi8ATakmUgo9H6pPUX71I2RONvpKWyCsoFiQggC+0MQYWXjqb5B9ldmbcKigVNdEO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7dKgszoKq9yCgBDJS7NzwzwK6C5+cA+KqFgGZYkR5ei3ybWa8eCauqFpY48O?=
 =?us-ascii?Q?tMiUCtipbWtnvr5lc9wS7+iqC3FeEkJl5XGnORnmpgRqJ3fBKsMGWToyGJ/V?=
 =?us-ascii?Q?VLUlnG4yNxE4S4mhsmMsCaHHaxsAEIQR60JPwzQAOInDHBFdP5wEXNGCOeFN?=
 =?us-ascii?Q?fHfQ8T3XVov8npzBXDgB4NXfDjrxEcIgI5MgCFs6ewAURuaTIfxDZv/YPKkU?=
 =?us-ascii?Q?iv7HRZ9VAsxH3ZlMcsSR0DE/Z07DdDv2GQO63Fz08HwdcE9/SrDAS0RTkXfs?=
 =?us-ascii?Q?HSn4STiMSRifgiKzn2ZeNwe8QvcNnKTBO5cqGXlxn19x0JTkDd76Gu4OhwrI?=
 =?us-ascii?Q?m54Miz8lGUGcPJzRg2q1pu9oUIIaG/622Dq4dfRTeIlVOJz5ckvyOwd6qhIE?=
 =?us-ascii?Q?Ez/vtysPoMqNalAgHRmlBVXvigkaAUsBfTCmO28WbX//yDegEyIy9SQ/nuy7?=
 =?us-ascii?Q?oCEXCvXAvyl7LnitKKzdwVCmgDTHZBEpcMTj4XmwUTsaSXC+B016lm6005pC?=
 =?us-ascii?Q?Mx6j7/GiT1/lmYWCvRUSwlXJdxbEa2UvfWB3IM1d56zp07Gb7zTB39etG9fL?=
 =?us-ascii?Q?uibsF0EJDaYjpVpNScTzJ6TXoNs8LL4AgdFuMP6oha0oIHXF4dtnEKpow3GC?=
 =?us-ascii?Q?e8wfwHvMFB3f2g2OMjhxVGA/NIHEPcF29T0NYwP4ExiKEwXffc3g2+sqWKdw?=
 =?us-ascii?Q?+684rk8ebSY3Uvk3MjE/5bcgyoq+WOwNoixjn5xgCzjHd5kANNdTMa+Q++5W?=
 =?us-ascii?Q?wjKn+G9pEI5YwiEWV8kx89qpWD1OsHa6XQAk0Yg9HvZMfc4+wOm0CnAXXIH7?=
 =?us-ascii?Q?8fR/f0pef+VzSj/ovkhMiWdQ8Gw+Ul/oTGZ/RZzoqc7VdiR+jgty+2Mh0qyH?=
 =?us-ascii?Q?Sgbl2ofDSIxQookGOJFhVBpC/I2uN9PN8dTszHtEwBdx6BR+yIiNGmYB8m4j?=
 =?us-ascii?Q?dcXphQXGvy/6rEnn8W2sFS6IpucJfUhlN2Ky7M+Wk3NayCxa38PYsJ9MdRPd?=
 =?us-ascii?Q?u+GqGvEYhC9IZdXbkGIO2Hh2j6KW9/7vYiYK+KAseUG7RA6/yJvR1ALcsuZ3?=
 =?us-ascii?Q?DJYuapj3zOZ9xANmfV+FD6RBIr3V7RDmNxJZe6XcLawNRyJpIM6k/0cupuxF?=
 =?us-ascii?Q?VM4k/dfDWPB5mOStdB04DM86PrvE/ov9SFFN34bIcSvO2xrr0B/PO5eB53Qp?=
 =?us-ascii?Q?TXY7c1lP90qPTQZSeyUYoEMBkUt2A6x1RIYu9xtNha6UyLakNkC+M5JdS3xF?=
 =?us-ascii?Q?DKvdFbdsz+OKFne1MjrJ7Oi3P+D+QJOhierqCafanphBmAWIMtKHKi9acUBN?=
 =?us-ascii?Q?rANETD3g1IGW8OTnZKpaWglzHE8dI4twdvCI6FUHAFQZE2BTDTNcZmVFJ1po?=
 =?us-ascii?Q?XK/1KYoRtOtga9fzsLzP3ldwmfdhmU0oXh6azaVW7HAcMKW0mh1sobf10oah?=
 =?us-ascii?Q?K3i7f1qhVhasRy3pTk6Qufk8vDKtogwUdjgVB4sSFJhfbREF0J10dExgB/yj?=
 =?us-ascii?Q?x78vJR47Hk604pW9ej6yQB0dGGz78PYDKByylz4gmGxvSKbL8otCsPQRqnff?=
 =?us-ascii?Q?AZhJu86ohMXeKUuo6fYJmJ5GgoTI2Tgu6K7Ju8sTIvKL4ZRshrh6v1kF0Fjf?=
 =?us-ascii?Q?SEMAwbMJtBj3inTn94qNY4Q5EHqMvSmWddU24Nw+vWM2Cp4R6wg6FPwW1uW0?=
 =?us-ascii?Q?hsqwXC6+/bH0zGx3YmKfIuSXkxMBo5sTLvD96RY23E8/a3j7N3X4VPOwp+Q+?=
 =?us-ascii?Q?H2xgOS8dxA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45fffc9-7206-4bfd-7ac6-08deb63af9da
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:42:35.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pt3znIDQeCTqV5HLmL4o4exYcSu56XgGyfwJRml/oRN/aXFPYy9NwzlZlV8v0XUZVdOTC2fyzkrSynzoPjlsaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11659
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289786-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: A107058873C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Additionally, even if the work_struct was initialized, the mailbox DMA
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

As the inverse of enetc_msg_psi_init(), enetc_msg_psi_free() also has
similar problems. For example, if a pending interrupt fires between
enetc_msg_free_mbx() and free_irq(), the ISR enetc_msg_psi_msix() may
schedule the work handler again via schedule_work(), which could then
access already-freed DMA buffers (pf->rxmsg[]), leading to use-after-free
and potential memory corruption.

Therefore, the order of enetc_msg_psi_free() is adjusted:
  1. enetc_msg_disable_mr_int()       <- Stop new interrupts first
  2. free_irq()                       <- Ensure no IRQ handler can run
  3. cancel_work_sync()               <- Wait for any pending work
  4. enetc_msg_disable_mr_int()       <- Re-disable in case work
					 re-enabled it
  5. enetc_msg_free_mbx()             <- Safe to free DMA buffers now

Link: https://sashiko.dev/#/patchset/20260511080805.2052495-1-wei.fang%40nxp.com #1
Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 35 ++++++++++---------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 3136e8321e4d..c09635e7eb3d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -118,6 +118,15 @@ int enetc_msg_psi_init(struct enetc_pf *pf)
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
@@ -126,32 +135,21 @@ int enetc_msg_psi_init(struct enetc_pf *pf)
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
 	enetc_msg_enable_mr_int(pf);
 
 	return 0;
 
-err_init_mbx:
+free_mbx:
 	for (i--; i >= 0; i--)
 		enetc_msg_free_mbx(si, i);
 
-	free_irq(vector, si);
-
 	return err;
 }
 
@@ -160,14 +158,17 @@ void enetc_msg_psi_free(struct enetc_pf *pf)
 	struct enetc_si *si = pf->si;
 	int i;
 
+	/* disable MR interrupts */
+	enetc_msg_disable_mr_int(pf);
+
+	/* de-register message passing interrupt handler */
+	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
+
 	cancel_work_sync(&pf->msg_task);
 
-	/* disable MR interrupts */
+	/* MR interrupts may be re-enabled by workqueue */
 	enetc_msg_disable_mr_int(pf);
 
 	for (i = 0; i < pf->num_vfs; i++)
 		enetc_msg_free_mbx(si, i);
-
-	/* de-register message passing interrupt handler */
-	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
 }
-- 
2.34.1


