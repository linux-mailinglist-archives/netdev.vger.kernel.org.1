Return-Path: <netdev+bounces-286521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBbcHX2WAWqXfAEAu9opvQ
	(envelope-from <netdev+bounces-286521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:42:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 637FE50A3F5
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63FE7306C7D9
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D843BED56;
	Mon, 11 May 2026 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B6jK/vmT"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF63BADA3;
	Mon, 11 May 2026 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488532; cv=fail; b=dhZY5aZFslGR+9WqwtaSBMuSSehe6+YF06F31jsJiFVQKR0z3f6ywqN2UKnC+9LvM56/4lzi9M67ErtFWhJQtwknEsOCGHJqCdCCjZsOxSM79PcN0QAiGeAoUP471XYlsrkI9njysPWkODABAzOozL+YHQ9lDKOfFDZvv256NHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488532; c=relaxed/simple;
	bh=oXWzqgVcMM6KbAwXtV8X/S+zDAcYxjUS56Rp9trLc/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i6Vstm5W2aFXC28M5sv8mYU8m1vNf5NLf5Xe5/g+2teKWC85SFxRnyo+0eVIJNms/dEy89Ozli0ztd+q1skyJYwyoSPFT+GNs8Sp5NMWeWtHMt9AvzyKnzOwh1Ner7jOp9KEjAltAvu5lzgr7QZch/ainWOvcawXd3XfCAoAiXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B6jK/vmT; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClKdV0r+qTh2XjzzJVKTAvy0ecSFrDljoPDSGKf6l/7/2tzxIjUTFLE1Ri8FE5BMNo/a8uWqNgTxatU7RpkTRQQtW04LfDPBclWct4VdqEy9ngl8pFLbDHwN/lTES2ekX1wLUOlJS0CxbH8gq+7bhsklYymCTdOi42bSZRGiqmmsDWj5oHzRV48D+1ZrWwfIdP+kDFwlb1v0Q64xXXGF8Z2+cUAwH+pR1Xa5kyzeCebHq1+2gVPO8Ep76oGqsklCCRj4E3DZKo6VQKpvgHBRAOeM8W3aXXtpIc30qlGGkrnuZxM6XYzTSCm+elI8DYHL7P/5E3BYGiSSgLz4/EEY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOpJz3h9/ae4bMNWurlM+uGnxVbcBmIwnUL1Yv309Pw=;
 b=DE8PHnIGFDTBIARvGnOGGim2yfLKaPv0ykjehdjBmli5HbNL5DeiQYx8qm5YGAGdNB1lzGBgj+Bney4TqmeJQYRyoq3He1Zy3hCDUtCQ2YeO5hXtm89bkoABkboH6G9Rr4jrkwwAVmjR5VbzFr4tbH6xEbD2jbiiMThuzvwTuzxmTHfmivDqir94Dh9vP8frlMcK/aruIkTwVlrHsHigtLbUr62728Wz7aMOQECAGjolYmTSvsOWRrpTTMO5NIsw3yxkqjdcqSRx+KqbchUnTA3dVrrGYfhgqrf8hfenIEqkq8VZn4LHyziPoOcsUbh6mjZyj4szaJjXId1Ne9uonQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOpJz3h9/ae4bMNWurlM+uGnxVbcBmIwnUL1Yv309Pw=;
 b=B6jK/vmT28z2K2snXfcKCk7po5hn3BHO7rGifyMDR8rTfY0IXsdxt6SQ/E5DINrCq1HaIEfiUCq7+/S/HVzb9KLaVqrSYdi478f5cuMg6mDNe/X3wo2uH+LiTC2RFpSQxfNOMWMEiDy1RfdpQRqg87kUUXMDSri3CDt2YCYNUT+hm65jH4F/r0Q05sweAJVcvNg74kuUKUFIA6qFSteVdrbNq74RzFdZ6tm3ulH+Dr8BsnpMzT/4U9YUG4ORMSm3lSP18M+TcmEHui8tDo/u/RRYFwO6Ifcer8M8IIFp17KEWIrlAS5mYS1eTQqYRBVPlxIdnkzUX6vnGfUOX/a8aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by AM9PR04MB8322.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:35:16 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:35:16 +0000
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
Subject: [PATCH net-next 11/15] net: enetc: add generic helper to initialize SR-IOV resources
Date: Mon, 11 May 2026 16:08:01 +0800
Message-Id: <20260511080805.2052495-12-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB7502:EE_|AM9PR04MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d53265-0322-4522-dec7-08deaf383a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	9e2Ag/iMtW6KFgiFE7SkXVEqksZ/qIucY6oF29yNN11603q2osyR3JxLe1j6lPlYpjrnzVCTKuJ1xOPgivlW3V/qbcfK4UTYDAu16jzXao3lp1zaEiPUy5VWYJOp7GPB+YAolDa8i1lpidOyZ/Rrvc+xfr2NrbRk9fTKIc6LrHmp+uGm8E8c9cnNxm2IQ5O7ZGohPJai+Ffp1k+Q8knAKjuSU+0tWSQlJOYNzK7E9BxZxBAyKLULWxvwAvh9021wiVJszalOaomgEFsu5X4f2goCZGQcE2Y3+XPxC5Uhx62Hk3jlyoRwfu6+YBU7c+4vsck1qcsrKlsXTQOznEI9sjeGOc6jrUa4ae9KWnlfXuOJRKGkspsDiX/42pVelDOwFkoBAYT1R8Q0BfovxN4YGSAoqq+WyBAFyqu3gFt12jb6nUbgN5FvudiyQGSd3NGTUWTYDlz3a6p+XILF5wpwQfPxtzEbv7lnifDPlYvgpN9Bch1fudqaNL4WgEe+fJc53lNkwT18AePEuSKS9FsaL4a0dzFHezgiwlv9nXjqYgsplyuiwBrzTMfoZbAEpiw60T85OOh2G2HdSxW4SlstHJN4NT7PVsHax0veig/2/nIUcy5ODO2zO39J9l7jkW0f/n5Hu8RHardh3f9eN/uGduLD0dwk8LGqzpuJf8o9rYBXXXQkRWTmZTc+lHNpyItt+C07Gx7NUboK2znXYwlh04K6WaZBYKiaH0qWO43DNyD4r8fwx/uI85lM5I6woLXH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7fINVZ5lF2zpkOkI3Q155tszXA1XYrCSyHZayDROXFLz5ekaBHtmaXUSHgG5?=
 =?us-ascii?Q?J9AU99ESK0y3tUodzFI7lZJy3w8sSUbbKSCDcmPPWlgZft0rimn+fevXXzM4?=
 =?us-ascii?Q?91rTjZlSnmC+S7iV3pVzMwpWxuCXzyNWnCByIyTgOOMsjxVmusFJSnxxGgJ1?=
 =?us-ascii?Q?tj/O2n/BWVWhd2G4+gVttX+JYDj61NUPWGK6fGQ4BZBvSoMNbrJa8nSi1ah/?=
 =?us-ascii?Q?kEJQGgY+ETmQkgpc9P9CrP4aXY2ESobNQFznqtiDI7C/U4JVUzv/SPRVrOmM?=
 =?us-ascii?Q?X8te/LWznyxduyDlx+ysENrJqeafvzFPsgHV66AMr5bNAhY8dHPd2P+71Ixs?=
 =?us-ascii?Q?HZbayuF2tb8ZTrw5sfgIKW8tsi0D2d1v+Aa56DM6DnIiGa2b1ijdVHt4YSwF?=
 =?us-ascii?Q?mMZg2cdSwje2CHNiLSn7mBzicf4ZIWKAYdF+V5qmAsvHCVWxA+EOGuh9aezm?=
 =?us-ascii?Q?KJ2om6tN6yOYxXd6VNEJSHBmTxHMf1bEgrSb5KM0gx2yh9VZbKlx/qGadhh+?=
 =?us-ascii?Q?ltn1vm9OcHgb7T/BIomB1G9uWs+qYDLVcOzUO2K6DvxfmJ1xzxiFbQdpG575?=
 =?us-ascii?Q?orYWwVimmJIjfOoX7LkliKSqkoMvXrHX3SzcxNi9frSHh3d1ByNjH9v0Kela?=
 =?us-ascii?Q?l9PgZKXT1Rz8HVLRPjOQhtSYQqZE79aOqyXwK+PQFkxAIfbdmXDMvFPww9SI?=
 =?us-ascii?Q?WYtrYkyFQBBPZl+J1R/HP51Qr/rx4Ci/XlFYAzWW1/1hLwRANJIIkccd3vjf?=
 =?us-ascii?Q?skrdZ+RtcXgZ8+mwDTGHAQeYcwkdOmQTbwhIwXpavoctUwwww8qxU8m21X49?=
 =?us-ascii?Q?CD+SwCnvwa5Q8OcRs8GRW0np3Ud1AzSkPgOsL4MFdDhqaPx+Nk0Kprs2hQOA?=
 =?us-ascii?Q?JCAaviZ8Zo2F466Qt6n4JPmHazqqezmT+7AK+sikrsXLEssvk9ugIakLqkdz?=
 =?us-ascii?Q?IsGVwIKuq+UTI6Uqr9SZuaqs/4o3NkyWNihiid8+VcqtrxbGE1aEA8cLHtqd?=
 =?us-ascii?Q?9T5GvM+gs//aDTSlRjmUhTk6qzE3kDpLp1axrafR+MBxOosBusIs2GR1l0ys?=
 =?us-ascii?Q?5fZ35NBIy8CbgQlalxlkiYz4MRykrINvRfXS1KM6i3ByRTJDz552D0naNVwG?=
 =?us-ascii?Q?dRGfUfg8FjY1zF9BiZr4pJpwrrxukvpNPBBc084gbHo0a0fw/uvjMc6U6TAc?=
 =?us-ascii?Q?YeLI8fbBPO4fBWFJDn7IfTylzZXVjKo3SV3UEu2JLIAOFNMIDtTaQ0grzzHO?=
 =?us-ascii?Q?uEAfT8xzgdXtccpWT6SVp0w9XFVM2PxBnzlzAXRzJow4IqA1ThKUYBLFBnnu?=
 =?us-ascii?Q?Z4QgrZlqjfeM6Wds71s/om2VJaj7djGJdsaSSSe1JYK8xULkyh28d0U8ekL1?=
 =?us-ascii?Q?VGkm61lWZKBAbhFTxSBOKQAzrYqjMzHF102h4/LHsVQnC20WQ2XTllyO/7aQ?=
 =?us-ascii?Q?3Qurf1Zk0aRj+4hO+nHs0xwXpLCR/GXYQ5QSulu5bFQNvgvzDojvIs4GaGoS?=
 =?us-ascii?Q?rom4+Dx2kVD6WVPSaPuFveYIRgnPE07FEBLTKLW782pwwWbC7tqcmCzuW/OM?=
 =?us-ascii?Q?28wQdjYQ3Sb2kYwpuA7QDCz13cY+doQ5u+OaUPB0Za/CfUFlyI6TRkqV3Xzy?=
 =?us-ascii?Q?xjmKOXMz2vAc6p9DSJrZuW2Jsj1blwN0KCeKAYILmRNUgEz1Dy5v5gVUwj3P?=
 =?us-ascii?Q?eR7lUY1pvRf9yALX03rhCoJx4g8eZHvleXV1JXgcHC/3OAeLOy1kG1P2djwV?=
 =?us-ascii?Q?q5RrnCzyCQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d53265-0322-4522-dec7-08deaf383a14
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:35:16.2478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLznHZ2yB21x/HjsQQpyy7jeSKmD6jwJXPZpchUojYRGIWihnvt8lY4Ya4KIufx6LmkUPmlnCpwFlBCNEYK7hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8322
X-Rspamd-Queue-Id: 637FE50A3F5
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
	TAGGED_FROM(0.00)[bounces-286521-lists,netdev=lfdr.de];
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

The upcoming ENETC v4 PF driver will support SR-IOV, and its logic for
initializing VF resources is identical to the existing ENETC v1 PF
implementation. To avoid code duplication across PF drivers, factor out
the common SR-IOV initialization logic into the enetc-pf-common driver.

Add enetc_init_sriov_resources() to handle:
- Querying the total number of VFs supported by the device via
  pci_sriov_get_totalvfs()
- Allocating memory for the VF state array (struct enetc_vf_state)

The implementation uses devm_kcalloc() instead of kzalloc() to simplify
memory management. This automatically frees VF state memory when the PF
device is removed, eliminating the need for explicit cleanup in error
and remove paths.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_pf.c    | 15 ++++-----------
 .../ethernet/freescale/enetc/enetc_pf_common.c | 18 ++++++++++++++++++
 .../ethernet/freescale/enetc/enetc_pf_common.h |  1 +
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index b126a624e6dd..13a1c9bdfee8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -868,13 +868,9 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	pf->si = si;
 	pf->ops = &enetc_pf_ops;
 
-	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
-	if (pf->total_vfs) {
-		pf->vf_state = kzalloc_objs(struct enetc_vf_state,
-					    pf->total_vfs);
-		if (!pf->vf_state)
-			goto err_alloc_vf_state;
-	}
+	err = enetc_init_sriov_resources(pf);
+	if (err)
+		goto err_init_sriov_resources;
 
 	err = enetc_setup_mac_addresses(node, pf);
 	if (err)
@@ -952,8 +948,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	free_netdev(ndev);
 err_alloc_netdev:
 err_setup_mac_addresses:
-	kfree(pf->vf_state);
-err_alloc_vf_state:
+err_init_sriov_resources:
 	enetc_psi_destroy(pdev);
 err_psi_create:
 	return err;
@@ -980,8 +975,6 @@ static void enetc_pf_remove(struct pci_dev *pdev)
 	enetc_free_si_resources(priv);
 
 	free_netdev(si->ndev);
-	kfree(pf->vf_state);
-
 	enetc_psi_destroy(pdev);
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 76263b8566bb..60a330ee03b7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -435,5 +435,23 @@ int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid)
 }
 EXPORT_SYMBOL_GPL(enetc_vlan_rx_del_vid);
 
+int enetc_init_sriov_resources(struct enetc_pf *pf)
+{
+	struct device *dev = &pf->si->pdev->dev;
+
+	pf->total_vfs = pci_sriov_get_totalvfs(pf->si->pdev);
+	if (!pf->total_vfs)
+		return 0;
+
+	pf->vf_state = devm_kcalloc(dev, pf->total_vfs,
+				    sizeof(struct enetc_vf_state),
+				    GFP_KERNEL);
+	if (!pf->vf_state)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_init_sriov_resources);
+
 MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 548323d29f36..ce499cfcce30 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -15,6 +15,7 @@ void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
 void enetc_set_default_rss_key(struct enetc_pf *pf);
 int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
+int enetc_init_sriov_resources(struct enetc_pf *pf);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


