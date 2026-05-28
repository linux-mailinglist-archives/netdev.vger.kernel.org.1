Return-Path: <netdev+bounces-292787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMkIJkh/GGpBkggAu9opvQ
	(envelope-from <netdev+bounces-292787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:45:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDCB5F5D9A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DFAB309BEDF
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE694410D1B;
	Thu, 28 May 2026 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hiCNAsE1"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB8640963D;
	Thu, 28 May 2026 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989718; cv=fail; b=ZPGiHnoj4V38GlwUEBNrECdf6Qgl48l4J1c0b0N7Zsir7Swvb1ecUPVEGtJlCnJdX/5TYLMZVGtQOrndauR9AHmDwqR92El+Y8aglis+namCZiubI4T5YeY5D4mRgWx1oGqMHYIQcCRfEoZpff8bcHeRvM6nup+ybwCWnwHLYpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989718; c=relaxed/simple;
	bh=/OkFmwIzrntvsm4Z3Sz2K7RkXtjs4qjnKgiGa/k3Me8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UtpyZ9kNqfU9AXCOz5Ft/KNKqwNFTDqMvOGk29EAFrmWLKcVVkqpr98Omh71vrSnu5cfarqVTviW2bU4agLMHfzWSsuQBWI723wG1khPW/13bz6P1/e0u24ZqBqOuSRHhE4I2BQVz9OykwNfOC7jogIuJGeZBWQVVLmXStXWzJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hiCNAsE1; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJFfvJYNZkvbksca3/x7lra8UrM57P603PkvWfhedmWhexP2AtmyAVOZg3YVeb2yFcm1l6YIRr4gLN9ty+iODxAgpfehqBwsFCZ6jBJqG36rC0bfCO9RlGxHfo8P0YCfYFBIPVPz2/DBMQJr+Jk6hOmIi/ML+SdKSyB2AG+OhhO2Tf5ew1ro24x8w9CpdJ67GqYVmEKdZuePZJya9Rt0S1ZH7OpFoha2SCOBunAkMF2AIbyL55DWivpcuQwYtcmBIaCiixGXnpFXFaDrimgy29FejDcWW25llxHIuaX04PQ9DhL+W6yspEfN6kWfDwUelZIOK66xfvnf+rvO3vjz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oai8LVlNxOOnu80jZET2W7Nr6Qq6ZXiexZ0CCCFKbgw=;
 b=J4Rcx+tsopchrtQoizXLqp6HWYC9uBqy7tANxqklEcJCvx1cjQ71rDqWFcIkF17pJss1ma4nPexrYMOVkmd9A82mVC3zFoesoFch0CO91He6YNIRASkeQmqXZ+m9NVZUSKc9WoEtH7lHVhnglSkmsvm0mNewRp37N5jur3HSwR7CfV7KXeGg7MsnC4WyZI+nEAZDWfrwpoyiAiRDNTHdwC8h2ma3ipjr3muliVxbcli1A4WEsFrxLUaH36vgwsW+5PHgMqFOaCG9CoG6p+YndDQkDRwgnMVHhdcxJQWA/F3/t407VL3Vhsh+juFCX7eDEgfoVjxqxso7hIqmx7BJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oai8LVlNxOOnu80jZET2W7Nr6Qq6ZXiexZ0CCCFKbgw=;
 b=hiCNAsE19sksuwpfEA17QmHPFvFYEsuDhGBzEP1BH34Ehtz9V4Byrbh9aU/1qWFCMwZpPk2vrODGoZCZ9nlmptCE3ksqEkowAuW7E8sGMFzl2a6tJ81vurKvBXrQgQjxEe45Gol2wMZYOmj6K4Xiy6PyoITTTFjUpwYUeB4nmNVso/LDZoxrO/ytnmeq3oVhsJvW6VCOmK6jFoJg81OWo+FVPBUXtFTlVB7JIBXtX5Z2M4Y/8B/nGBoreFso7xciDZXJ/IxayOYBYWS3shIEkE1ZYaEAwLyP0Q64nfMYKiBas9ew+zhaUEhY2TjoCQIlNzei9HSYX+t8vQFWpX94cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by DU0PR04MB9657.eurprd04.prod.outlook.com
 (2603:10a6:10:31c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 17:35:11 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 17:35:11 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/5] dpaa2-switch: support VLAN flag changes on existing VIDs
Date: Thu, 28 May 2026 20:34:51 +0300
Message-Id: <20260528173452.1953102-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528173452.1953102-1-ioana.ciornei@nxp.com>
References: <20260528173452.1953102-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::6) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|DU0PR04MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: abee623e-cbf6-4709-21c9-08debcdf782e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|11063799006|5023799004|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eep5NBHnd5uOaCQS3VTtRmKNr6vVyVv2h3xlZTzOWLK+S5HAMnDsc5hd8Y0usE0qhKJJY74H8hYHkW/rT9fhOd/OxY+swUyaT3y2U9KJh8E/9upFLQPz5jY9s1LBSqzP3hwlAkj0w9I45y9jy8dX5heKvdE5RzDQxzBB47HdrLtN5qHcwiarFEJ0HvwcvSGqfdZzL4D76qRaSIfO6es8IrW7au+HIbMn2QhNj+0xL6oULehYIOtIzxWf+qlGeIq9ZR5WpxzGvxdOasi6+6Ff/m2xYxEfWbB/NdX/9tiQLFG2qJBkmIYUWtdjHDEdZd/9HeAO0sM1oPDQU0mmklCowUCmhJTDJtMVFm9pG7pimyG96vPosk3UgubK+DBMkPOf23kG7Z1ikT3VDVUqFVHyosBMNGpdt1fVZGtqlp44ppgIJ1Q/K9zO6Hs7aSAr7SQDTW0/Ono9IxCEP/kV3wM/zgeSimZ/jQYcxCtw2VVZkhqOYokq9BRsoFfhTej1JvgpF2L8TPyX24N0sNbQebuvzcS7eeTppxCD2RXpKDWtte6qe9LezXR2Ff9kA/uoE3YCpAE0vmD3XqknBjiNjmykZ9Tn9KHwLdqlRoLULWR4F8zSlIcLcpQGr2kHUL2kKs/qRSNCjQtUo9kP9NxJrhcHUJGBW39QoV6WkISik5kriy1Ml4crG887EshS1+om8YXB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(11063799006)(5023799004)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LVDeFZRtcTcgDsla9Z5dMVlhXwRsB8l4Iv/MJX1J0oKA6l8f0hRtit5j+ExZ?=
 =?us-ascii?Q?NqvsmHVpN8n9dr/TJ7wCDrPOKrQyynBfWi0p5/U3ZmjUZU1p9cogiuQXtyFt?=
 =?us-ascii?Q?fQE00LJfnnQoVe4/w67KsYtMJ3Qt5QTjZsBMQQHlPHsxsuLYCDLHThiw9LlO?=
 =?us-ascii?Q?nkOEfaxbLRGO4+L8xU/FBKis8Gx5py99eXbNFj2kCJBlil8akRdAD+PSgUm8?=
 =?us-ascii?Q?1nf6ssqC4y+xxsu4G6vxdiY20903en6mN+UGyOWMPKPFnInXRbNgdIwj0QHG?=
 =?us-ascii?Q?WK/+DDj9djfihf6pdHigGpSSoRM612EgDnhifUCVlN3FT1Zmcy/fqDxS5r+M?=
 =?us-ascii?Q?A7mjVOZ3HD3FT6OVmI8+YRLIDc7JjT6Y9jBHprsu7a/ccH2RkOY4O8/2rBAN?=
 =?us-ascii?Q?r6Rz0jTQe3pQtyfphkFa1dricVLNuYKlX73hKMW6RxPNe4ZdT/WjdNaXBfjs?=
 =?us-ascii?Q?iMtsdni7JHexhzWNOKUntXi179JflNRLcsYtq1wNHgiRZRJpFCf5TP7NONAP?=
 =?us-ascii?Q?/R0nKlDAQG68gwnOGaRnI3drqQhQAKXG14N7Ha58MnBCubrcHs42QjHtMuJb?=
 =?us-ascii?Q?ENjYKqExdWFz4ld/KNcLAsilPshHBc9TVoCtDYMaEXa71FIv0nvY0DjHheKU?=
 =?us-ascii?Q?ep/m8LBj3euokR7+5cA6DrGYUxrfTgYEBG5cemU31IkvmibsUuWJngfvYY9u?=
 =?us-ascii?Q?SXhABXHVNhPb+mPoVBWZUn5E6gwGdCa48KvfxGN9TdIIkNPySu5BtN8aWGJZ?=
 =?us-ascii?Q?fIwdllmew8Wu942i9vDDkqj+eoiwRf5oWNMlw5ctguuPBZzQYuEMSo/pcnkX?=
 =?us-ascii?Q?axo5ve5hxRz2vrfsoSV5MtFXGJ2o0O/iDGVefYsxB/LsDnlcTqzyxSskNLLO?=
 =?us-ascii?Q?tacwx6NLFMHL1meBt70tJDrewSVVXCFRetQSBQQynSScNGT5wv7aPtJFwxRx?=
 =?us-ascii?Q?+TuXS5CWsbTJrLchTvCrtMsGqdugsBvYT39UwqfZFCrwD+9u3vXqvmPKAYwe?=
 =?us-ascii?Q?C4d+tSYKN/b90EWD3yXwklV5cnPJsdyT27Q/BLzPBEIq4iQJdbn0f04DkXNr?=
 =?us-ascii?Q?MSIsT3EHBz8KAcIPQOXRC8qugmouEOLzxBDJyXP/4UqtEnRZm1qfJnyk/3iU?=
 =?us-ascii?Q?iL8lHf9hbHwRMvPE81joBuQ+Lg7DdLvTXOaOmwA85jTs+zuBYVBC+w19EMQC?=
 =?us-ascii?Q?A58b718YCTt3HFXz7xQf8j2FgbuIek8vCGQc2HlZPzmjJk11+Pm5E3cVFNFn?=
 =?us-ascii?Q?0/HyblWEHY3JZVDzO/2jQOySbPr9PpYPzhnSCrJDetcfEqpEnEAs2/P8DgG3?=
 =?us-ascii?Q?RimCtY/LA7QRIPoRXSfA/0PnGVdubLcSN6gxVIglPG74A46wzjppeafJ4/Uy?=
 =?us-ascii?Q?61JQEIKeOpj3yDd/86KJiok+A3f3rsmXSNEMGnYbpAQ6EI2l3C16Z+GyUPvG?=
 =?us-ascii?Q?NZbf0tR1Qz+iZfzkGJO0LWF+LvqsZ6kkimWUgyoRYzwquHSSihzeTZvMyVBR?=
 =?us-ascii?Q?aHbk9hbkht1NcQKxQUmwEnIyLJekQQEjVvWFaROImPXX+zJyJeJv9Qc2hfc5?=
 =?us-ascii?Q?CljJ8cOV4/0A7zQLT30jLywiYLVNQYpt11+HVbwdU2unK8APouMdusQV3R+Z?=
 =?us-ascii?Q?gnjMWbkePBRJU2/vfYI/DF2COs3ClTQ7ct1B6jvUonMHWLCiKNJsVZU1Kued?=
 =?us-ascii?Q?k5P4qqLm8tHOpNchInCwiv5RmwlMkbBYm1j7H87+l4JESQPI3qPiJVcYcSI9?=
 =?us-ascii?Q?fgzvUzD3GQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abee623e-cbf6-4709-21c9-08debcdf782e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 17:35:11.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3svWsm6KuFmuRAIMtP8bpDsIQrs5PzWCoaIuzwiCr3TAelLvdVXgFd3UAqwot7HR4609plSO4CuNtVdKgFM2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9657
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-292787-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9FDCB5F5D9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The switchdev core notifies the driver on VLAN flag changes on existing
VIDs through the changed field of the switchdev_obj_port_vlan structure.
Without this patch, the driver was erroring out from the start if the
same VID was inserted twice, from its perspective, even though the
second call was actually a flag change.

 $ bridge vlan add dev eth2 vid 30 untagged
 $ bridge vlan add dev eth2 vid 30
 [  458.589534] fsl_dpaa2_switch dpsw.0 eth2: VLAN 30 already configured

This patch fixes the above behavior by, first of all, removing the
checks and return of errors on a VLAN already being installed. The patch
also moves the sequence of code which checks if there is space for a new
VLAN so that the verification is being done only for VLANs not know by
the switch and not flag changes.

A new parameter is added to the dpaa2_switch_port_add_vlan() function so
that we pass the vlan->changed necessary information. Based on this new
parameter and the flags value, the untagged flag will be added or
removed from a VLAN installed on a port. The same thing is also extended
to the PVID configuration.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 100 ++++++++++--------
 1 file changed, 58 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 4022635171b5..505ccaa93ee4 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -298,49 +298,68 @@ static int dpaa2_switch_port_set_pvid(struct ethsw_port_priv *port_priv, u16 pvi
 }
 
 static int dpaa2_switch_port_add_vlan(struct ethsw_port_priv *port_priv,
-				      u16 vid, u16 flags)
+				      u16 vid, u16 flags, bool changed)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct net_device *netdev = port_priv->netdev;
 	struct dpsw_vlan_if_cfg vcfg = {0};
 	int err;
 
-	if (port_priv->vlans[vid]) {
-		netdev_err(netdev, "VLAN %d already configured\n", vid);
-		return -EEXIST;
+	if (!port_priv->vlans[vid]) {
+		/* If hit, this VLAN rule will lead the packet into the FDB
+		 * table specified in the vlan configuration below
+		 */
+		vcfg.num_ifs = 1;
+		vcfg.if_id[0] = port_priv->idx;
+		vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
+		vcfg.options |= DPSW_VLAN_ADD_IF_OPT_FDB_ID;
+		err = dpsw_vlan_add_if(ethsw->mc_io, 0, ethsw->dpsw_handle,
+				       vid, &vcfg);
+		if (err) {
+			netdev_err(netdev, "dpsw_vlan_add_if err %d\n", err);
+			return err;
+		}
+
+		port_priv->vlans[vid] = ETHSW_VLAN_MEMBER;
 	}
 
-	/* If hit, this VLAN rule will lead the packet into the FDB table
-	 * specified in the vlan configuration below
-	 */
+	memset(&vcfg, 0, sizeof(vcfg));
 	vcfg.num_ifs = 1;
 	vcfg.if_id[0] = port_priv->idx;
-	vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
-	vcfg.options |= DPSW_VLAN_ADD_IF_OPT_FDB_ID;
-	err = dpsw_vlan_add_if(ethsw->mc_io, 0, ethsw->dpsw_handle, vid, &vcfg);
-	if (err) {
-		netdev_err(netdev, "dpsw_vlan_add_if err %d\n", err);
-		return err;
-	}
-
-	port_priv->vlans[vid] = ETHSW_VLAN_MEMBER;
 
 	if (flags & BRIDGE_VLAN_INFO_UNTAGGED) {
-		err = dpsw_vlan_add_if_untagged(ethsw->mc_io, 0,
-						ethsw->dpsw_handle,
-						vid, &vcfg);
+		if (!(port_priv->vlans[vid] & ETHSW_VLAN_UNTAGGED)) {
+			err = dpsw_vlan_add_if_untagged(ethsw->mc_io, 0,
+							ethsw->dpsw_handle,
+							vid, &vcfg);
+			if (err) {
+				netdev_err(netdev,
+					   "dpsw_vlan_add_if_untagged err %d\n",
+					   err);
+				return err;
+			}
+			port_priv->vlans[vid] |= ETHSW_VLAN_UNTAGGED;
+		}
+	} else if (changed && (port_priv->vlans[vid] & ETHSW_VLAN_UNTAGGED)) {
+		err = dpsw_vlan_remove_if_untagged(ethsw->mc_io, 0,
+						   ethsw->dpsw_handle,
+						   vid, &vcfg);
 		if (err) {
 			netdev_err(netdev,
-				   "dpsw_vlan_add_if_untagged err %d\n", err);
-			return err;
+				   "dpsw_vlan_remove_if_untagged err %d\n",
+				   err);
 		}
-		port_priv->vlans[vid] |= ETHSW_VLAN_UNTAGGED;
+		port_priv->vlans[vid] &= ~ETHSW_VLAN_UNTAGGED;
 	}
 
 	if (flags & BRIDGE_VLAN_INFO_PVID) {
 		err = dpaa2_switch_port_set_pvid(port_priv, vid);
 		if (err)
 			return err;
+	} else if (changed && port_priv->vlans[vid] & ETHSW_VLAN_PVID) {
+		err = dpaa2_switch_port_set_pvid(port_priv, 4095);
+		if (err)
+			return err;
 	}
 
 	return 0;
@@ -970,6 +989,7 @@ static int dpaa2_switch_port_vlan_add(struct net_device *netdev, __be16 proto,
 		.obj.orig_dev = netdev,
 		/* This API only allows programming tagged, non-PVID VIDs */
 		.flags = 0,
+		.changed = false,
 	};
 
 	return dpaa2_switch_port_vlans_add(netdev, &vlan);
@@ -1803,25 +1823,19 @@ int dpaa2_switch_port_vlans_add(struct net_device *netdev,
 	struct dpsw_attr *attr = &ethsw->sw_attr;
 	int err = 0;
 
-	/* Make sure that the VLAN is not already configured
-	 * on the switch port
-	 */
-	if (port_priv->vlans[vlan->vid] & ETHSW_VLAN_MEMBER) {
-		netdev_err(netdev, "VLAN %d already configured\n", vlan->vid);
-		return -EEXIST;
-	}
-
-	/* Check if there is space for a new VLAN */
-	err = dpsw_get_attributes(ethsw->mc_io, 0, ethsw->dpsw_handle,
-				  &ethsw->sw_attr);
-	if (err) {
-		netdev_err(netdev, "dpsw_get_attributes err %d\n", err);
-		return err;
-	}
-	if (attr->max_vlans - attr->num_vlans < 1)
-		return -ENOSPC;
-
 	if (!port_priv->ethsw_data->vlans[vlan->vid]) {
+		/* Only check for space in case this is a new VLAN from the
+		 * DPSW perspective
+		 */
+		err = dpsw_get_attributes(ethsw->mc_io, 0, ethsw->dpsw_handle,
+					  &ethsw->sw_attr);
+		if (err) {
+			netdev_err(netdev, "dpsw_get_attributes err %d\n", err);
+			return err;
+		}
+		if (attr->max_vlans - attr->num_vlans < 1)
+			return -ENOSPC;
+
 		/* this is a new VLAN */
 		err = dpaa2_switch_add_vlan(port_priv, vlan->vid);
 		if (err)
@@ -1830,7 +1844,8 @@ int dpaa2_switch_port_vlans_add(struct net_device *netdev,
 		port_priv->ethsw_data->vlans[vlan->vid] |= ETHSW_VLAN_GLOBAL;
 	}
 
-	return dpaa2_switch_port_add_vlan(port_priv, vlan->vid, vlan->flags);
+	return dpaa2_switch_port_add_vlan(port_priv, vlan->vid, vlan->flags,
+					  vlan->changed);
 }
 
 static int dpaa2_switch_port_lookup_address(struct net_device *netdev, int is_uc,
@@ -2146,7 +2161,8 @@ static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
 	 * the dpaa2 switch interfaces are not capable to be VLAN unaware
 	 */
 	return dpaa2_switch_port_add_vlan(port_priv, DEFAULT_VLAN_ID,
-					  BRIDGE_VLAN_INFO_UNTAGGED | BRIDGE_VLAN_INFO_PVID);
+					  BRIDGE_VLAN_INFO_UNTAGGED | BRIDGE_VLAN_INFO_PVID,
+					  false);
 }
 
 static int dpaa2_switch_prevent_bridging_with_8021q_upper(struct net_device *netdev)
-- 
2.25.1


