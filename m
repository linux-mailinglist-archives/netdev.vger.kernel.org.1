Return-Path: <netdev+bounces-271866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOAdJa7SxGmw4AQAu9opvQ
	(envelope-from <netdev+bounces-271866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:31:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F86232FD96
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6881F307329F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CB03B5821;
	Thu, 26 Mar 2026 06:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XEGATroa"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012004.outbound.protection.outlook.com [52.101.66.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE03B3C0C;
	Thu, 26 Mar 2026 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506503; cv=fail; b=c4M+NhkyJENnGu6QIJm73dkaKEFsZ6ouDscm52s12TNDQlIWuB04ZdTvPOkBB4j43dS8ybEJMvzAFCRAF9VHm2e1K9nclFO4O8TOhEG3C5uxzOFVq0H24sDhyFGbKUNC0IL7eYaePjzGwpd+KwXCzc5qc4QypdaUk0aLdXkAHqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506503; c=relaxed/simple;
	bh=+fn2Y7X+WJAkS3qzg0+RTs/Wlujx1aziCSlAEo6Fgrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wc+H3pAmpf4EtjE62IYIA+0C1iNxVA4TAH8XYbPdM+qCNTaqUoKjvu1HxNqd0opzxklHYL4pspC+A9ecrAEUcSGATHA94OTh9owPDT+4r1z+c+WU9FCb0TIP+OOurZuM8Mg0wECA5VzangB7eXdBwoypHMAo9T+mXzmlPStTntk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XEGATroa; arc=fail smtp.client-ip=52.101.66.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoDNz2WopqYmhIfsJpjUJsyqbcBmwlTYZVK5+aSsqPULLnNSJH6/Z41QWbBieApCU76HRmjTho1gQRdYj1KdVkhtI9Ytd7GjkhcYUAffsy05xvxXXsHvzAoHP5q5mWHrX2UJAQaZTxP3N2NsMo75pRu5wqIepPaBZGVIXlljV24Q6Cm5WWwI7a24rq0SZmYM1e6KcYw/sOF10HZz8l4/SSfxc9SW6827aa0mLjxwnld9q/+Xdh82If5hE7Yj+Eoyg1Jkc0F8xRrNWhgYmFuPWQ166fAgY3+GvtrPJ5TnvxpHoXFR6tx3zNN8tsiFMhp9M2GGqPT0PsQd0PsSry+J1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hA0A79YWETmRTGTqe7Mp/rjfjw1D2YkkH7VrA8J4Fio=;
 b=kClwqK2BRVm9b0plI13fUMBHRGT6gySS+0rHTpouQ/Ntp7IG2Vxz91tMUoeoFvVG932xmH07TKNVZG//3BWdcPTE4IwQPZh+zcjxFIKjDWM64YxZXRWLNx4fiLNo9NMYmlwcKD/UV4F9pl2pKhH3YZ3FZWs0GR49t3O7iCsct4GS7LFDjPkYIIHeC8fQGUL5LMg4GECK2ST1WA22PyyhuY0nDzoi9cJ9cjBEKkYhQLlYRWDUT6ZlwH5BfN/3jMfVv6XzmKF2YXo3TIPOwE+tXjyTINou7Se6n1y6bedRnpcimSjdlWh/GTTikXaDSSOfo8PfA+I1Rrn0mtQAWqyYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hA0A79YWETmRTGTqe7Mp/rjfjw1D2YkkH7VrA8J4Fio=;
 b=XEGATroa6wzgDyhDrVIEstZM/KzbO0uoCWTQDQlkLr7DMkJxPd0PkKYv4pw71W8yMr4quIIMUlBdlWQxfbYKNMRpg37YDXdNAG+lU7v1cjem64M53waCJjVMGTUR0ppaYYtU7501ltAns90vXCjkctHmRdYhAfK9V6MYSbyvDUzptyulNNP3lQuhTs5I/VYLBctIkSKcccmE8KBp4DAOiceZdW/rY5POuOEkSLL5LBEv7INi8b6etj8meGsFmfGfhCNrImuWdJ5aN7mQIfFQ1EZYFpJo7nDqLR798j4HmZE/eIvjm6GKV2xe3TSzN0JvHtRgbTTLFXTyBTMz5pQNfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 06:28:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:28:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net-next 08/14] net: enetc: add multiple command BD rings support
Date: Thu, 26 Mar 2026 14:29:11 +0800
Message-Id: <20260326062917.3552334-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326062917.3552334-1-wei.fang@nxp.com>
References: <20260326062917.3552334-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: c33b91f6-3d1a-4d9b-7be5-08de8b00df42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|20052099010|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ksmTMWEqjjb1cJMrH0uBmxXsd2dirwVOfNcWnWFXeE3AWVJ+tyVCYfpETMrgkKCLDMULHXNcFDRSSvb3OWRFhUlOziwYuio16iWaslS6Z7TiL/yKs7us3Kd6jVuWDWLXgJqbWB2O39XrXx92s3upqQ+G4ujb8jpngpD6xy1SCYIM562e3/nAWJWUaYPeWNgBJdlVvi0dluAKv7lO5QM6MjuPNSLsCfTKaQDfH2NovMgn5ncRM+bjbBK5zYwwrwwGlyEu2Wfe8/LWG37DJK8LqzK97BYEQ0vK8XcFmUigLkfCI5LZlO5hYmWy4AkLA16qCAXnp5rhfxBIgf3VMzUlm68FccA8euFj8aXfY9E1Jx2rqmCQ03BnDgxtty3i9ZDJAnm7fLfoakHfSpbzqB58/ivbtzOdBhmuHR7A54egIgPxXdNmZMVMdHxSQ9HYGcf3Cd2BfknZf469lvyW9g3nxD7D8hZsmq7BYKCIEokmeaUpZ44PRny7wLdjcq1/ovMzSEDTJf4KFyCA2gKV1uPBkY8UX+TeJKhGO3bIhFqDYLUiyIa0F9HSgT03i/8p7JaTuctmvGIm89xOkGZ+m6Sf2Vkn0nuBdLjxpTHHeznCR3L0WdLhgkuNqyG2SfVYRsGRWQ49tuT31t5gZCf2cfnSActT49T8GUilJ6l8AuHP6FonFOQaZd5MpxR/DBDJivA/2O5yESCnL1dN1Usfps9PZyOUYl08HjQKtee2Nwfrp80wBmfuI6P/Mynaf8jeruKsSjSq98qqN2rQP4zJ/OBFS4vV/65A6WPUFQekAzIr4nVZHkH+jZdxLJb4vMJWss07
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(20052099010)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mai0gTblg2ZFLMsYSoM9qCGVW+kBEpxlB+xwZteMDH1YfI3HAJwwdM3SGy1H?=
 =?us-ascii?Q?ZQimHI2iETOXHDuoqLXSL1UapEBJUzVmD3LUI2yb+noxwmcFTqJ8x9IWGH4R?=
 =?us-ascii?Q?eYbjR5QgjJqK1VPcOJAGqJtem9IXLM7QoZQiHINCyaDringwbTXQKHVmBfZE?=
 =?us-ascii?Q?g3owzCufz44efXKdEc1NGCGcmgaPxacWUb8Bks0Be7tYSFw2rIMkZJCRkHXk?=
 =?us-ascii?Q?/nZvdhuagqBOAQ6f3jLpbPf5Bes6XRz2GlXmnxmnED9BDsass9KmtexPVPNr?=
 =?us-ascii?Q?L8Yp6VGOSnd89aZBT4RkNLK3f+apemKiprG0ywZQUjs2Bfv9xirlFWQ/rcFE?=
 =?us-ascii?Q?UOCL+Ed7RqO/7t0JhWQY3VHQTUNxhks4aJlsMmRu7MRRFyIza8Fy0g0GrqPL?=
 =?us-ascii?Q?9dIQiNO17HbwD50vSAVemBCYSe7M64XZQ1vi1ebD+qTWv0qMLAGEbXFFOCaE?=
 =?us-ascii?Q?BkNgb8K6iTQi6yUbqWtfTLqgohXrTUWvEirVO7B+ujiwROrDm2qbj4Fg4N5n?=
 =?us-ascii?Q?TmSHBFRpLjUqHGbiZLbHYjeZbvTCBEQjTAlEoi0tUFUs64dtaTktCNqGlsOY?=
 =?us-ascii?Q?B+2sQ656oAJLk3IJiKiQT803p41qIMwjvFNw2GyMG3D4Da9H/nqovoEl/M0c?=
 =?us-ascii?Q?uz0To/PTctlVK8cRBMLME/QTPLHobsloTdpCxcmgeLJKKeuMalAmGybXimh4?=
 =?us-ascii?Q?3Djc2EVY8wj04YzxoE61Y9FrxcaHiyYq2aF2e5ZtlBaGj9IpnNPgeL1nTPAT?=
 =?us-ascii?Q?j+oO+TyOG33W58VsD2an7aA++ZdeHe0Ow4LA3AQC2whPhUJoYfNmsUcYMzEP?=
 =?us-ascii?Q?nmJFYtO5M2YfnUyOQraJ8qAXMMUZEO8XM6sCMQyihCVB0eYxMIB7BfQcvS5A?=
 =?us-ascii?Q?o8auxeoWgq0cxAtVBhtNWXOlGgyZhMfEFevwCAWjVnytOLlDy+5zu7lIwvbd?=
 =?us-ascii?Q?V9E4/9YqZca7kJTGihGLSTfcqBQtBLNEGZYGv0acL9DXR5mu5jfypxs7MIBS?=
 =?us-ascii?Q?oiEANB5r8p1fbXPXCksfyAPmVz+itfhL4mHJjgoV1Jfh//PfXCmt+eRxyPP3?=
 =?us-ascii?Q?kmxELpau+llzTxOrpAQtYRVqvDZSYgfd9oDGfsvjEP03ZrLdaSKw3onLv0Nl?=
 =?us-ascii?Q?tFGyTdEXxCimNty4N8zgvOd8LEHySY3zFEw0ZNX9AD5Pt2w6/lku6rJ9sho0?=
 =?us-ascii?Q?SRV0MrdOFDYYtroa34cGHMmxopjRGc+oszTai4FI7CNx93V8wGciVpp6p8LN?=
 =?us-ascii?Q?LMljDxFk+X49nBNrXzT+C67LsIAVBFsSRlRW+OK4I9evzQhevIurjjD5+Fmj?=
 =?us-ascii?Q?N1JGnGqumY57nZr0FumMB0vfpr02+YbbU5qRQzBEkUa417d00YUg1uzeJKa5?=
 =?us-ascii?Q?AF4XAKDwKecUh25fg153O+0nbHGkx6jwoq5t/C1SJwvVOTylqejQwhlYrrsS?=
 =?us-ascii?Q?gH+E20lL1KXwNoXFDBM4g/xinO+uhEbexEYTQCivIb2FhDmH//6UzvQRj5ej?=
 =?us-ascii?Q?I6oVtfB5d2ITdzpvVFzGET01cHiT35ka39NqIyS4kjPnCUehRjspn2D9EYm7?=
 =?us-ascii?Q?pW1GAfNKcCV9siXtwM9CTuLz8ZIzH+zohYClr5LcQ0FhQ4YXYjz334FHmCcg?=
 =?us-ascii?Q?d+jQDOgbNBEbDe2vqJJPJFU1Xssw0TLOnPCu91CfQXT+AUYMhMBkOeAtqQUv?=
 =?us-ascii?Q?7j5fhHYxkHdMcG/B4cWPvibx2uYuzk5ITWGmS65x0UbrZwdf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33b91f6-3d1a-4d9b-7be5-08de8b00df42
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:28:19.6381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVX3HHgXLBB4VowxijyoQ1EJo/L8C8BUnTZWYaLpiLtCaWrFyPo11VNAJYEOiAu8JDC3ScRywCoEfaN6VRuaaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271866-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 2F86232FD96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All the tables of NETC switch are managed through the command BD ring,
but unlike ENETC, the switch has two command BD rings, if the current
ring is busy, the switch driver can switch to another ring to manage
the table. Currently, the NTMP driver does not support multiple rings.
Therefore, netc_select_cbdr() is added to select a appropriate ring to
execute the command for the switch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 960d5be8ec42..5679b866af48 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -125,12 +125,21 @@ static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
 	u16 status;
 	u32 val;
 
-	/* Currently only i.MX95 ENETC is supported, and it only has one
-	 * command BD ring
+	for (i = 0; i < user->cbdr_num; i++) {
+		cbdr = &user->ring[i];
+		if (spin_trylock_bh(&cbdr->ring_lock))
+			break;
+	}
+
+	/* If all command BD rings are locked, we need to select
+	 * one of them and wait for it.
 	 */
-	cbdr = &user->ring[0];
+	if (i == user->cbdr_num) {
+		int cpu = raw_smp_processor_id();
 
-	spin_lock_bh(&cbdr->ring_lock);
+		cbdr = &user->ring[cpu % user->cbdr_num];
+		spin_lock_bh(&cbdr->ring_lock);
+	}
 
 	if (unlikely(!ntmp_get_free_cbd_num(cbdr)))
 		ntmp_clean_cbdr(cbdr);
-- 
2.34.1


