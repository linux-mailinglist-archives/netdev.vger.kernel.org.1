Return-Path: <netdev+bounces-286518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFACOSWWAWqXfAEAu9opvQ
	(envelope-from <netdev+bounces-286518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:41:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7A650A3B1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283BF3059319
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FEE3BB9FA;
	Mon, 11 May 2026 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a3Y4lLHt"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031C3BADB5;
	Mon, 11 May 2026 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488516; cv=fail; b=D5+YpvRqhMPTrVMAovzbWNbA1a5J/7qomc8JrPk1iWaKf/H8vuzm2/3mCQdErWsuEZLPwlaD4xe68AhMm7cHlDQCJit4FcxTpmrJ2VcsR3biQQPX/HsYlZCntrQFvAt5uYax0pcoeTBhmYrvicaP2bfcK4Wr6qgUlYpVfsdTLAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488516; c=relaxed/simple;
	bh=WuDVe9lw/pLquF5kvyONzccGSioL6D99czA0DUtdDk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I073lYXQXQiQp3ntnGp1fxAGYQR2/0qC7ZfrCsRlc/3IaThgC/z5x4ModfO7XHJlDKan1YYDOt87THjM1tftB/heeHQObnYMhq+YBJNBIkqomJ5fzDxQs/YkCZm2qOcVQMLpIsH2pGLsbY9p+WZjiUMjLDc8ex1J3JgyZ0Ld+10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a3Y4lLHt; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYqz2wjpmlV9w0bk0s7e2uETXRCobEXVlKB66woXInvfnv8efaL+Z1Lhbn0NgKQdURPAjm7sx+NuDhXAPvvxOjTuNyrE/E4/F86lZ2eT2jCl/mfHvj8WehvDMqAM1uOmr/kJeHhoEybCSuKHSZTx3Lx0F3Mwat1QumrW07izMC//dnl/0j+DX720h51B8NjeIUCQ2TJ1tsa9ZikA82A5feTmsOQZNuduMgDKYH6kencqZJSkh2LsFxNXgnte1DzVx2mrvJ3CNodKfTnVXmbTPwr6mFvYITgKJOnvPl95Xn/rX9GUkTzqUhOGwP8PU3ojv5mvD+O5aUUQyTFYcX3CkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7dRZZoVd+T+RSoo04zEJM+pAqOoqZNh1hCx3DApChI=;
 b=XiltGB8rHLQnXfcuME/VyY+mYOko39PeFdSCLG6zbWz9IdcKbx/WTQkQHMhj40rJeUpfpZREyfQGJlXhymNrupZqyx1RGTj71LWPmK9s1STDiriIS+/KnVHkANxY136qDyz5ghr9GEiadwXD/luIyIaC9EK7T3d4U1nBBrn2qlUAJqQR5+9WdBdAPCRQSrjaY5+heo1/mzya70i0LsIcxoS3e/ROqtf7LfyaamvCQ0v94NCCPvkdYXeaSETLuqrEUx/3stSsu04zrvi9WLfdP8ugAIresRWcBX6714/JukNGED0mG3l/M+H2JTVf6Fh0j5GcKqGa2+5OmT6XrsElqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7dRZZoVd+T+RSoo04zEJM+pAqOoqZNh1hCx3DApChI=;
 b=a3Y4lLHtIuEjD0FfjZJtjUcZNMvJxOErxG7Ump6D606qXzG6ABSBS2q5hFXs4iM78pkPGzXa99aSN/UzMa244yTlH3WDwYullTYOcQfloohgD6Qpzbnl3F+yUiCYeTG6Ei2CBin3dr/yCGm0fCaHDVKIKpwvoSqNUaq9JJDvqG5tdK1jtkBb0tL5bZtvUwlj2IUXTZ7OHFlUgYYzEPW4Fr84iOvkgXb0V1a+qHLjav9opHFlNN5oqmeYbKhaMgxcf7lW3wEBTzTBApKAo4nKa81M0lfOBBUthjboRPEplp8G9sfoMXvXNEBUBPQ91jsdDO3phOWwwO3rW6WgTvPt0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:34:49 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:34:49 +0000
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
Subject: [PATCH net-next 03/15] net: enetc: avoid VF->PF mailbox timeout during SR-IOV teardown
Date: Mon, 11 May 2026 16:07:53 +0800
Message-Id: <20260511080805.2052495-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511080805.2052495-1-wei.fang@nxp.com>
References: <20260511080805.2052495-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To PA4PR04MB7502.eurprd04.prod.outlook.com
 (2603:10a6:102:ef::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7502:EE_|PAWPR04MB10055:EE_
X-MS-Office365-Filtering-Correlation-Id: 156eebf7-c883-4da6-e7ee-08deaf3829cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	A1nZGNykUbaVUfkUAkIc2+ACk3fSrNN0pnM+d4peKetdyFEFLuB9scSS5l2zaibkSsywDhbbdo8XRzUcKxNP8PBx9ZWo673r2C+N/rhp0NmGYYv9YL2p/C3qePC1J3smZfuFj6oAAMJtpQMoyLRJz8tsY1hR+0Wrt8m6uvbktYZrOaXwfenxC2LhrsRgoRRIM4XUJ1/Pf6vPhHn+ZXsi5UuRs/yJQhnZBT24F9nQLgnRDQOI3vFKjxVU+sTzLfd3EEn4SvMbf518piKHpKE7fFY5ttOLTfTDKnFHSRkrQAtLkWyGfI9SqxbY1/4CX71Cl+FrCuiWq6RRtlZrqnG6vIWr8hnAbQ6ANfXSq788MVBaKpAhLDIkZBqJMtJQf1H6rncMDaqww0tm9XCeHcqbDhOwYvInRn1UuxMMF6QFtOj5eqkTXZCY1QJCTebJ0osPHotSqaBwvQwxQ3pdir6iIJTSO0LTDGImVC6Vpuw0VG/tedERmeWDxD8zuOpHVrE67efnOCIeC74P/Iz39yCVu91UcuYB9ZGoHk6lDSySivWAsQ4WOFdiGcUFvhSL8zVRfmkh8ABAiwHwghq+PA3NfwoAiB7EescJveYTa+cDrsIOHuc/YgV359UbY1yyns0gM5OGmTofInKwTxytp9xxU3hA2+LlWrOi8MkEmbETCSDSeOniPYfWQtDhcGHo8TF3iVIh9O0izKuOplPewJYhhM5Z6nLcvyh488Qqc8urdC5Tb5eFZGL2Km6scXMh0GD1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mIzxAg6diFd8mLIBk4OFBOtWJ74u4dhEW6zCmlmafwoGXYyGC8N1rCxLn/c6?=
 =?us-ascii?Q?WlkWK/+3RWZQjJcSqpB6J3YvbYPzcuGMGcOty4PKBcp9WRz8nPr5KCSxmNms?=
 =?us-ascii?Q?Z/xw93Y9NL1pzatELak44KtE9Yh3iY/00l+ENJn49+Www3Y/X6YBRGnxXiaR?=
 =?us-ascii?Q?+d2DQXMYllsTPyNQt3k/JjBx/uUmzi0XuVhr60+Yy+mswNpyp9FTFTdyVcoe?=
 =?us-ascii?Q?R7gn2O7TptomdiUmVWRzGldkDxtkR93RIT8nxCKXMGAf+2/3Ubduno2cPgDs?=
 =?us-ascii?Q?KZQ/2Dx1h/v6v76OXM5pNPEkPKdh0PFklKdGMzEnbdhTn6qP8WO6HQv8m4Wg?=
 =?us-ascii?Q?SH0hjVsLk0xAKUko0PFgfIrx8q3O9j0LYzwFjVtPMJlqd4ZJNntHR/DKeb8g?=
 =?us-ascii?Q?qH7lCVyq1xACiVe9T3/8c7Zoo+lira/NAgGTws9mJBmYvwyxmwDH4/mgfmdO?=
 =?us-ascii?Q?WcM83aXGPfXDy47FdNqF97bbqUmwGpEg6Jtjmd50yAiIecMiYE63KHlPeWnk?=
 =?us-ascii?Q?1Ejr1JNJ9Sxl/oVVlapTfRGfNLvhWVIrl+HIf/YWbIWiJluMX4kk/HqNpHO6?=
 =?us-ascii?Q?oP2uFPQeVl35/NcYfcOLVaIO/VXZLi/5ovcVUAwieGAB5pUk27Z5tzrsVWYV?=
 =?us-ascii?Q?+TwzymE4oUlI06e6kC5PSv1mWe3H/MfJVUlMDLR5MVS3BtHVnnixkn1lil/Y?=
 =?us-ascii?Q?+Ob9EnsIOMDuK+EUQKIL0HESoxub8mE0qD7XZL5RCLN3bkMG1I/B3iyZRWqP?=
 =?us-ascii?Q?JsjVW8I62oN+/cHz0ziXfG9wEfEYKZNyxf5yrALDGUMSt8YmctxMre1KAWSp?=
 =?us-ascii?Q?jdDS6oS0SKuqPWtvsOLENpM50KKL74TLB6FJBtaKdEN6wzz6Mp4Kkou/Dcxc?=
 =?us-ascii?Q?tsohO09FKJohtWvWOh0exeNPFUPRJPldd5nJuzM1Sc2Kq7g1fhJWivRXDMT6?=
 =?us-ascii?Q?YAubgMeVxSAqrhZRcK448xdvT38x1af8LZcrcIOpWdVwFVi1K6/WQ1A+ySAg?=
 =?us-ascii?Q?oVIluZcFSBNiLH6Tf2fyS8Vz8T7utpggEXa+oNanD9RKO7yXnoPN932/XOeH?=
 =?us-ascii?Q?DTxiqZfMhhdSIPs/bwK90abxArCNGE9HRdDsZv+hYNgWJ3ZP+eHr9C2NIe2q?=
 =?us-ascii?Q?5GWvG2D7VxDZ4L9V/P+uQg2X2Jhu8gwWhXg+44GcVQUA1jj6kPBgpyNhOSw2?=
 =?us-ascii?Q?lNhVMtLJs+875lSYrz2Gt8HhidsdWVMeyR+x/IbmaImNJ/W65EsYgZpX3Y15?=
 =?us-ascii?Q?3oPH7OE90ZUcs25la6U7bOdic3utrA8YAsh57wizN+uYPLhQh9H1nAxMDM8a?=
 =?us-ascii?Q?DnHu0nObC4bdQsAV15wdb6SZ9+g+bBA/6iqZODUZLrdTYJmp2WVx1WllKGdO?=
 =?us-ascii?Q?4aZV0FlfazPKQNby0buqETBykXlyriBwqE+vtOrnBc33ImoMYoYA6renekfv?=
 =?us-ascii?Q?T377BC/tWUPLHgt2cial57iYKRSOIlZI2et0wNnkuTYjj/FNQe/PKs85qpqd?=
 =?us-ascii?Q?pB2Jlr/L4X9fTRRd+X9pg0iYD2uJmVYh+HIK6vzMr8/KOhGZmmyXJSohqnBs?=
 =?us-ascii?Q?eoROmXv9IEs1i1S+F5KbyjMEScv4DlMRvU3Mcge1/E7/EjVcJJY7JERirsET?=
 =?us-ascii?Q?v/sTh+VWcJQY8bx2yyqpSbLFHOQC48Lt7Xjc7pMyw3Cu9noUT6PCWFAXklTb?=
 =?us-ascii?Q?dXoXEMlmerEDBpRQ4L74jnXcnqbbSFOaKGp8dPJSDgqzkX8njg0Q4QNfkYX2?=
 =?us-ascii?Q?CEXggiDc2w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156eebf7-c883-4da6-e7ee-08deaf3829cb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:34:49.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsEa2vTHpObB1qUsSO2YwNE2eZ/h5ADo2ygb3mGWASJX47TSLoKunIYVwr9H9E6R6E8Mw9CXUkMaHjgpJEOOUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055
X-Rspamd-Queue-Id: 4C7A650A3B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-286518-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

During SR-IOV teardown, enetc_msg_psi_free() disables the MR interrupt
before pci_disable_sriov() removes the VFs. If a VF sends a mailbox
message during this window, the PF cannot receive it, causing the VF to
timeout waiting for a reply.

Since the timeout occurs during SR-IOV teardown when the VF is about to
be removed anyway, it has no functional impact on operation. However,
more messages will be added in the future, some visible error logs may
confuse users. So fix it by calling pci_disable_sriov() first to remove
all VFs, then safely clean up the mailbox resources. This eliminates the
race window where VFs could send messages to an unresponsive PF.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index b1620dc00146..3ebc48c3fdf3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -484,9 +484,9 @@ static int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	int err;
 
 	if (!num_vfs) {
+		pci_disable_sriov(pdev);
 		enetc_msg_psi_free(pf);
 		pf->num_vfs = 0;
-		pci_disable_sriov(pdev);
 	} else {
 		pf->num_vfs = num_vfs;
 
-- 
2.34.1


