Return-Path: <netdev+bounces-264165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCqBHMb0qGmfzgAAu9opvQ
	(envelope-from <netdev+bounces-264165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:13:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C7120A748
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A1D30E184B
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 03:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B92750ED;
	Thu,  5 Mar 2026 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MNcNCj9L"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360EC277C96;
	Thu,  5 Mar 2026 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772680245; cv=fail; b=sAvSb3OZoXYK+/VQmZG1w88J67XCdbbiwC2N6e06fl8Ea+vxTTxweGl5oJONLUbQQaz4hLglPSxzb2ScugiyBt9EHJ9Zl0TjoLTFXzQIAKJr0OyZ36XsxqiBZAoxOx6JrlJQwQx4chMmm57pNFdebYqYOWdZjEoU5uErp05DQoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772680245; c=relaxed/simple;
	bh=Rr1EaEsE6GHuLuFLpf79tt0KQJGbYOIwkPZG9HkoQRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LYZ3cuPk7igJzxS1qEoZ59zPtgB7K2Wq3+hIXzMjsboZgdWOMj5HPm1vnSH6cMIyyjwlwJ7yGi1P9Gx4ZX7ttGHSSYny062njmQgXGZ5+xKSQRCF1gdZW0paK8/ekHN0aFOS+b5KVD6eSI6roxEj6OUDFQVr9u/p492PE1hULMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MNcNCj9L; arc=fail smtp.client-ip=40.107.130.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2WXvtVwVMxoRpYjWh7iGFSCD4nwqRGIkY+75twlHEpXiYAZty63Ct/nxO4kFYuQNiih0glM7w79LhptLFB4xUwUIZcvS2kqYu/9cHjGj2OxOsVsZjQsiHKWTKsC0UGcxDHG/nUuozNGnx/F1sqpqf0MuPfwcpuCiAWV81zmHCLn5+jYTkKJKtgKf6BLg4SxjK35ZACpKBYKky992hPJT5C719izKd0i4pCAM/cX6F5McXof5VNS1QiwjnSYPjib00zIRi1khNoDpzGp36bxPSpwebMA/qv3XQcI84CVbEGgHlSzlmmp6g6lZ7wAw4JKSE49cV27ALYsXRheNqeGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6SJKb6VyY0rpsCJ1k1Ml452WnA+c6bpnEdJMcCg1mU=;
 b=f+4gSx+sOieY0o5e3neIH9zJWxnGwqWJ3oaukGfZeS8H2o5WzunL8Zz6L983vdDNQDkDu5Fgz5dyJSCRKOK8wT07GtEALEuVewLL2vTWXMoN17/lM0t4sflG63xcS23sEMUjPgPpVzo6GrL/FcPMUUp2/pHKaZ/tqCPCyS9i8uPqR+r/wOdQHntxNH3+LqAK5S6FuqxJgiaQTMTEXbVnHuLT3qEjznSlJESt3VofeyKEi3gZqxSTr/9U8KwL+x37kQQKW1WUgeV972OollooKmAUxn69wKDVYoiXTZCL10HVcGTFRcYT3VEgXIwB8W/LusU6S+RAbNSm7fUxQ0wF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6SJKb6VyY0rpsCJ1k1Ml452WnA+c6bpnEdJMcCg1mU=;
 b=MNcNCj9LWz5cJa19gjnTTadCyNHK5nHZhQGhghgen10quxq4Q+hQotCkKYKFofmFLC1DZgY4Y+ATps4gEShm1al6LKBH0IlSXueNCxLlK+K8iW72fqQJlxDUC6L1q72+lVyc0x3wnkLoPbMKYyUBYKlzqKifXoF7vkCAooQ4Ef3KHVOros1AVv/PlmLVhTg0uI5ZeiygBVx+iQ4E4vzEPIgC3hA3f1MVwGsXveI8F/tMpOqA1gi4y6Y/efLU6oixlZVWMmXXv+txJyXHroUFtFZ+38XcOO9YDaqnIO9YxKD9X8TqY+7mkfX7AFtoYvrG4h91HZrF1wsfzKzH7AI5ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB11471.eurprd04.prod.outlook.com (2603:10a6:102:4e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 03:10:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 03:10:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexander.stein@ew.tq-group.com
Cc: aziz.sellami@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 2/2] net: enetc: do not skip setting LaBCR[MDIO_PHYAD_PRTAD] for addr 0
Date: Thu,  5 Mar 2026 11:12:11 +0800
Message-Id: <20260305031211.904812-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305031211.904812-1-wei.fang@nxp.com>
References: <20260305031211.904812-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0069.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB11471:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a935cde-8e11-4b14-635d-08de7a64c895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	foOsiTLQ4tVSTd0A6+bR8AkMDxbZm7Mjan4oLK0fzjm8PaeKo5dIq2uUzjuE4bNXCZE/13tJEyTygPaFwLI/jkJkCB4wsoBV74zWNKkUXzxvqXTWl+ld8YpqMGU9P0fAx7JG2AWGjtnqageUPr1eVi7yoWP020ZJSxPSgFCOh3ihkPKHPu6oAF5VrXTM8OnXGB76qYahN2S31mXtN5QKOB18oOfwOL5edOxNvEDInd8HeyBk8q8llZK2CM7LamDPt+epfSnBXlSmBIEj9jus9pWKVIK53OSkN2An2Qi2Yo0SFtDrkstLsrT9gCQpZZCT3dK2UeMgB5GEbYYq8qseNR4fppmdglOk2KWKdgzJ+82J2M9EFXfJ+oLdxDoGHFRRkYdSpYL51Io46Yof0xDU4PJdfQj7v6qGBAGT+N24k1VMbsGgIn0O4NECXpPpJyz3whAaDYBfrKuvmOyoOr+/dXCcAvQGIzI8bCV3kvh/kR2X9Izy8ugb0Ajd3Y1S0VZwP+IAvYPNbhh93gYPc1bqIw3d5Byjnie/WMTmllN9DyB99mJB3Qe/PDDg0MvpkYBG7CSLqRTB4Jw4Qh9wtb8BkMFzSbnMv4PLKRlIbSjYZc299Dmako1ZrsiSbLWv9t8cmTqoGwIDk4qRmg2at5MaQGW/uHeNvTGScknj6YIkeqB2xxRPQdJM4IcKHBeOKy/9FCcnZAshR1r7brQRzejWpOh3DzIC/H29rqfAdsdqWfqPe3MydNqwOioAS4kfX2f5N5yhbxSIyInsAgZTGYwrq9sduBFGqTlnvI7AXHJp/jk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?87ZPyQhgPwtWwd20UtuBw4iN2uZu2+t+yl6XqiFwPp28NYiJxge9eQosh6x8?=
 =?us-ascii?Q?vZfOagfh/tRe4KM9Pk0D/D96N5zY3wzEOKjCw1gG39TRfqlgWR66LOA3I96l?=
 =?us-ascii?Q?IazhuDfiC2k05RIZi9P7BacmbBvymA0ua7P359X5KN6WqhQtfzn/hHPpq/+D?=
 =?us-ascii?Q?2b6WDASM4AwIJOTuj1i66tPLg0OE04kSkPtrgjejYEpxNk8op522HMqHCmpm?=
 =?us-ascii?Q?/aOBN1E99biy9gDaE+zo5ZoD9OTgronTW/Ylr+DMrzXO9ZxjVRsipgVce6cA?=
 =?us-ascii?Q?8479AshKIg92wrDVgpkWo+W/tqBVwuo4texNeJn+JOVtIyYNIg9OhdGlTlFz?=
 =?us-ascii?Q?qyKAV+zG3+d7gSMojTOTwMG0eFhYnGvFlmuc8qbdQjaHiHLkGKQREzU6dsL1?=
 =?us-ascii?Q?9DdOB1moXOv59+5rJGX0B1zfm1bpfUCgWW+S9JBnjV8msuNHY3ZWJ82WmUMF?=
 =?us-ascii?Q?w6GqIw0RjwOg21PVutYeW5AZ+fD5dUaGoBbPNzTQ5zKe5gkcngX85170Md+F?=
 =?us-ascii?Q?OZnWs9zwlOCQCB6xA32i1IDypJhuSIIrukeLtt+/0PvvV70EJ7vt5ZAouRwC?=
 =?us-ascii?Q?zZMKw8ga5Mp7nnlcoDQtYHMaZlhljtn3MWiC4pWRi6CHGPATpf9snGR97VkB?=
 =?us-ascii?Q?JL5UL5LqSgitLB+JnIf/1QgNBQ9Y2QVyDPy84A2PP7wao7BUO/3LSJJUHm6h?=
 =?us-ascii?Q?1kaivD9uPcjErvdMGJUrzDG/QST3P4K6gzyxJdHSKzwtNiGY3buPF+cChL3Q?=
 =?us-ascii?Q?a9qghWzFXSKQnGkyFXLZjrQnzknkUSKwqBj9nroWPds+BUoUXlFcEmQkUbHQ?=
 =?us-ascii?Q?Pf2w8h7m/G5AOxqXpemHZzSFOulXDXrs0wKzG8SuBQ0LmpuIa7rQhKaKJgQ3?=
 =?us-ascii?Q?dSIMYUEgX2fEaFiXr228mBzkFsNMRryREk+Ix9cdOEyl1SH/7xxeQcl9Z5bS?=
 =?us-ascii?Q?mIdHtJzxjb03hUDp4tORfb5gVQvoeIdhTe3KCKWgBxiJk2UW5/9dmDVSycJE?=
 =?us-ascii?Q?rmRUj+HkVhelAElhszHU7Vs6hTdz+piBe9ff0mYSgI04Pn4Nmob7SklCg+hN?=
 =?us-ascii?Q?zcz/J7FiHn7fweeqWh10LqRgUkfflxw8XfCEHPV483vapXHmVT9jxw5614aI?=
 =?us-ascii?Q?Yv7cpZcKTYT7z3px5HIlT7qSA6fzPi9oUI4PqYMmqXxBYwah07EGTTwzZsaw?=
 =?us-ascii?Q?FFLlHCRTf2WArX51GS2Fwni+VUXm9sb82KJC9K5lONSdykI58bDznowFItDP?=
 =?us-ascii?Q?z1siuVS8shMHXDGrzZZGTDSRp+ulS3QWPhDcOuG4KiMmvtI/2a2/re72pMzB?=
 =?us-ascii?Q?P6n8RIoWG1vRWAm3tdDwcpocf398Pu39uaY5CIiUYuidG0W2/AScASbSgsbf?=
 =?us-ascii?Q?krZUPFkp9ECDZMpM9T+CAXqFJNSOagqQvKpJuCkWQzXMibGRqfkILjO45H+7?=
 =?us-ascii?Q?phzSWfFfTnzL0qOVfzsncTHzR3BzJa+riGnc3zN1Lc9vNx7046aw/rbIMtIg?=
 =?us-ascii?Q?JrnVC6dCP5UgCwWJmC76gI4Wk1y1eZRH7dWnUnmnvqiZ518CSjCU3WwpriKJ?=
 =?us-ascii?Q?cd0n7+6J+8E9UEbNyYVaHHp0oFnHCPAPMHTLDhsx/5NyNiL5qkGQkblKfYWJ?=
 =?us-ascii?Q?25zivMwalPC1345H3nyWUxYWQnMDCe6clgpFtveZegm1wD4ZOqdEplY4175s?=
 =?us-ascii?Q?h2UMPBfUd7K7LUp7MHlB31y7FUU1aJYjNTlylcoMEh2syMKN+PWWZRjjiCFK?=
 =?us-ascii?Q?U4x2owWQGQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a935cde-8e11-4b14-635d-08de7a64c895
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 03:10:41.5544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWKCaNg6MAE0Dgc7OlMLREu5YxkoqNQV+hfiGFloESEghMXL9ue+MaABJbRsB/sXPS+Y5+yGupC0kNYrdhtOfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11471
X-Rspamd-Queue-Id: C5C7120A748
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264165-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

Given that some platforms may use PHY address 0 (I suppose the PHY may
not treat address 0 as a broadcast address or default response address).
It is possible for some boards to connect multiple PHYs to the same
ENETC MAC, for example:

  - a PHY with a non-zero address connects to ENETC MAC through SGMII
    interface (selected via DTS_A)
  - a PHY with address 0 connects to ENETC MAC through RGMII interface
    (selected via DTS_B)

For the case where the ENETC port MDIO is used to manage the PHY, when
switching from DTS_A to DTS_B via soft reboot, LaBCR[MDIO_PHYAD_PRTAD]
must be updated to 0 because the NETCMIX block is not reset during soft
reboot. However, the current driver explicitly skips configuring address
0, causing LaBCR[MDIO_PHYAD_PRTAD] to retain its old value.

Therefore, remove the special-case skip of PHY address 0 so that valid
configurations using address 0 are properly supported.

Fixes: 6633df05f3ad ("net: enetc: set the external PHY address in IERB for port MDIO usage")
Fixes: 50bfd9c06f0f ("net: enetc: set external PHY address in IERB for i.MX94 ENETC")
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index f0e103615e88..92a0f824dae7 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -438,12 +438,6 @@ static int imx95_enetc_mdio_phyaddr_config(struct platform_device *pdev)
 				return -EINVAL;
 			}
 
-			/* The default value of LaBCR[MDIO_PHYAD_PRTAD ] is
-			 * 0, so no need to set the register.
-			 */
-			if (!addr)
-				continue;
-
 			switch (bus_devfn) {
 			case IMX95_ENETC0_BUS_DEVFN:
 				netc_reg_write(priv->ierb, IERB_LBCR(0),
@@ -590,12 +584,6 @@ static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
 		return addr;
 	}
 
-	/* The default value of LaBCR[MDIO_PHYAD_PRTAD] is 0,
-	 * so no need to set the register.
-	 */
-	if (!addr)
-		return 0;
-
 	if (phy_mask & BIT(addr)) {
 		dev_err(dev,
 			"Find same PHY address in EMDIO and ENETC node\n");
-- 
2.34.1


