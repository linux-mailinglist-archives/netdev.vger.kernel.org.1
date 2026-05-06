Return-Path: <netdev+bounces-284911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKaFM3pd+2n2aAMAu9opvQ
	(envelope-from <netdev+bounces-284911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:25:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DF84DD29C
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7B9A30C0337
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7B84A1382;
	Wed,  6 May 2026 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QPg3RxdE"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC99C44D682;
	Wed,  6 May 2026 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080618; cv=fail; b=oNK2vbea610EIqY7hCyfEAiSX+gmw4EZ+myKOekgbUNFuzt/Sw62wGKNuKX219N4RW5fRyL+Nkz8XgjilMyFN5EDGIWWz4gFBxv1iY0mZUMqfLnMzuUWgDotV7MWiDw5fYEkzweJfXz/PKzOshtsHvv4Zh6uZR4qdny2glufEfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080618; c=relaxed/simple;
	bh=kaCVpVisCRnXRpMOlsx/LRSJjpaWC15a6PgtYCfRUmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S0XxoZIJ4vE9/YLXwtIlt9AmEPiLgHUTaGVaUYTHsQlvpfKvFfUEN4kY9U/zyUMsJIDPFPJfZOHOxRY8SfJ7gnpH6xDXytiBK1HJsrORvD05sCTsyiDjo9KJTDxdVrGONNT7UdmoWEz+zxiwAiUXRIe4iYGe10S5kaGeKETPweg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QPg3RxdE; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHOpiJIfHKysxdK611uL1Zq7SPJp+K2pvlCii9Ett3I+77lORUt4C4RMCkt1Ndd29688CrAK3sPp5Q6n5pJjuNeLwq0dyFkYoyut/q2ns2eImqpfuUQkNbrWptmWAXgOS2ixoOhUN1qqfbJsxI3IsmYqc2WXMt/U6ERC0HvJPeFcc46OhT5SZy7SMjvwjSPp+pTWRZr8w7Y9iOx0BG7Q0sXI/MkmyO5HdPd9AFPuGO8s3jsaeUz+wmWGPTQBqKCmLjSkc7Lf2ykZpa6w+RLOZqQYNyQLbiMKPsegly0pETE7wlmVn+LFdhcWP5CyPfH46k+ddUiNstEe7cRbQ8zKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsQI5sNqmaWyFD8qYkVhIibUwIAgjyJnYZUFCIgncQg=;
 b=tLCTCapiHuvXDXRadqAlz3SfJvVEmv4orD92hYPZcCBNf2TEnT31NmbDpl36QY1cmfSzzdFI9VL5gMx/9YzKwfYhLBjNDKglGUCChFflQsoJ0eaR7WEbIahS4chnI7efxX8jhv+qJXizoGf1JomIrOZpuQ9NIEvtcd57rfbU3EKnuWpiOjeYEl2nCkmupTaeu/XysEv4c4jAUkj6LfQcGSuW1uw905OREY7Ks0qqE8ZPa38u4hnhCMvM/Q/QRXBUrCFfhoV04igONGq87bZxLfmrbXbe6tXquSNz9wYG6F3szjnmuNVeDgt19vP3MOiojDg7JdfPa6muOVxW9E57AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsQI5sNqmaWyFD8qYkVhIibUwIAgjyJnYZUFCIgncQg=;
 b=QPg3RxdEw2uSTb+ctGBHZ1qybGsrzmJJL9B8n7pvg165UOT7iqrPr14zOB9pxmxvMDV+Fzok9Fr9I5AjrxrN7Faxrq+737uzBV5amBe/PQHZ2n10Oe4gVtJHdDgbYPrrtawGx9KZjRdX8aPNGDsR8qnCBBTLLunP3Lbfs6Jrmru3LElaOHwx2M5OSfGMpb6SfUPmvSD4uDrHifKLXRev9m2lEZe0HvhNhsdSlRcTZHFvAvrul1tX3PpkjfO8gNFcCaM8Mq7q1jgoO30H7vmcyrQnEkoCCC1h1wNEFf5VooTlTQeY/4mRhe2DKW1EkTFu3JfOmYjaRgd1k+pVKDct0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by AS8PR04MB8277.eurprd04.prod.outlook.com
 (2603:10a6:20b:3fc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 15:16:29 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:16:29 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 13/13] dpaa2-switch: do not error out when the same VLAN is installed multiple times
Date: Wed,  6 May 2026 18:15:40 +0300
Message-Id: <20260506151540.1242997-14-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0024.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::12) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: a501dc6b-507e-43f4-6eaf-08deab827282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4K7e2BxPZklPiGX3yC3YmbaGV4LDekdFPO1TFazzgZ4k4QxNLJrWbfPj11ZJX9R55XlgtKTiZLA//xrX4s23JwjRJobnkqCqk0OAnpaou4DrroEP7g6OHm8AWsg0baFndXEI1xdAlLQszs+DFtj6r7P/U+zFBpL/bz/5cFEFwb56hbUo/+gG7yvjeW0uWLjUzA/B0qX1QyUfb2ttPU/da0eApHW5OmxyjvcfdasLrARysi6wQ3BhIeGRRxwnlUogIA/OdtSZZSeg5Ub2DC9vNIfze/+hhoW3r2FXWZ3TFzCa8fYaQNv8a+lrZfzOwIYTrdLx9/So79eb8tWyn2aHy3/gKQfg2dTTuKDbaGzwPAtwLt/HVE7Ii5iwUM/nJmFnb0Sso2kTn1Eb3+LXO+Kt2kyS+/93JwlNpFjvhMVSJ/Wz4RhuxwLCx/cAge+Jqw7CxlFyIq2KZ43q+vKdGYNhnr+8rmgLy/XhZ/K0TOTzIc7IxxlPqRN1U2+ZpXt2Db9Rx5U2i1uuJoWyosbgJfjH40+SWPojD6G8SJEP7gMW5+7YG7aHdNoNUGDyUeXKOmGFQRoE8p67/6ifBpBD2lo1Qxw7DJt3qL2GFcEMfmjfscIWvUCE4dk3p8N3pkj3Szov2dVMWDleVKSec4gsGsFyfcGLDdxcHgxmU6OGVmmpHwDPQPFFZuGcG6ZbKfBj0ndg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jxl13nVTlA3XwvjJxAcc9w7//59L/XrDs4Eiezht18uyCWgiRelR4gOdCtgv?=
 =?us-ascii?Q?D70+AdcUznGY2ZhHztD6/1RMQo7zRFtUJi4R1Fq6MUEHzdNrKJ2BfYowIZBq?=
 =?us-ascii?Q?hnnUB1EtltZ/DGnmIF1XoQDQltSKqOBYMlWIdSq+1v4aqxyDg2e0PF9sgbw5?=
 =?us-ascii?Q?ZcbuAoOZo88SFkT7WeDcbe6JR1NzLk5izTJdssbHOPvSzrpmLGHbio/g23dh?=
 =?us-ascii?Q?CdIbd4TKJrqz6QoOlrpSAO/bCyHNXV7zoKZEjaXb1WQPdwEpXRpI8V1ZRt+K?=
 =?us-ascii?Q?gWwmCqVGLoO9fCll1Vj6YgG1IHMc7sciHROr0kgjf637caOQ1Ca3ZGMsaiQe?=
 =?us-ascii?Q?ZkBPXv5grH05sxcfuqTR4YhajavalJ2ntaSg89RudfoUzYfMfRi6zRBBjmUl?=
 =?us-ascii?Q?cno94Ee5H62Nbn0RCUinOeyZowBWbtCTqW89cTGV338MrFDolHqyg1jVNqxe?=
 =?us-ascii?Q?prhlYKxFpDjdLxwljix3RWFQUKPGPXBekgp9pn/Kb46lkfOd+v2bB6VT/qvE?=
 =?us-ascii?Q?VrNHkJ+eDw+VnDL6oQKQ+OPRrha8HCKtKE3aO0WC7hBzgrCfJl5gA2/IpNkV?=
 =?us-ascii?Q?rnsO/ebC7Yy57lQNVuI/YEf+vd1cn0fuD00b2pI9/5xk6XhHFXbOZiTdgZjM?=
 =?us-ascii?Q?Ir7uu2LYzq413UJGaeBEYr+Gap77JTE+ssEgnRH3uyqwUs6z31kRCyrt6Dnk?=
 =?us-ascii?Q?lFhDkY9aQ2bE5d2Aq8mA8tuGHMOcBqGk2IDPwlUFF1C2HLuwrVtD5vrWGgiS?=
 =?us-ascii?Q?xSw2dkiYS/6+HQbpskUBje5rZPhpT8nq8oJ/TUgZ45uXIaxywERXbo5QupTg?=
 =?us-ascii?Q?8KFW8GzBm4EQLE6zsLm8zJfIXdcIevJYJxcd9rfwprshyVqdoiJdTbqKru0/?=
 =?us-ascii?Q?cFEVxkII5WJN+lpPrdrBPq/IoUUGM//zC87Mz0Q+YUfQRbfTti2JGOVtnRKA?=
 =?us-ascii?Q?5Ll39+5td6vHF9qbR1oEOOdZOMwk1TVWglIlL0y9Ow1KQJwEq3uOoa2h2i/B?=
 =?us-ascii?Q?cCnwHO4iQcvXi/+UF3ONKXC/is2MuduWvZaUh0SnYH+ixNCAkxsepQrqAcL6?=
 =?us-ascii?Q?AZgHAFEbKf6FH2LL1PbHMpPGRelYlNGhIAREnl0ALdXd/E3R0GKxZiMlzDU2?=
 =?us-ascii?Q?jplUlVFqreNNBb/TJImIrZ2UAviVgUKIDLEKXUctSZI/ghBn6IzqHsaucDLi?=
 =?us-ascii?Q?P/eroVo6RQwCRi3gnPX/iK9oKYcJRypY6QKMsGLVzWD/NfQS86xhPjmeKFMW?=
 =?us-ascii?Q?7ex1/+g1DHv489B4I+PmUT7lIEXxOdzZ+Hox7hv/Sdcn7Pt0BQHbqSp5VrMN?=
 =?us-ascii?Q?Atrz/pmQQn6yX4qGeKOYUKSUOyzVrTQIoRiwc0FDmwTaXAmzybetfqXo1ITY?=
 =?us-ascii?Q?g/U1WDA0xdPNpEgRfbmaaym9BMulzzXUgG1ftO+jbTbOEmr+vDB6iR/wKikq?=
 =?us-ascii?Q?4cRO0v1srr6ghzdq94g58C7LE5omiFyaIW47aqN4XvxcckBmomi0DMydg4Zn?=
 =?us-ascii?Q?mX0cbqH0qmh5L2pbpQng3dTEKz6+XB7xvmEmOebUC+v7x+jhlVPuTIIhj9U+?=
 =?us-ascii?Q?KcYZ1vfHjdn9w6hN2LXD3ETjBv0kLHHq6kv0MMOMNDj8Pzst07Cn3EpKI67z?=
 =?us-ascii?Q?l6P8UffS1vAni+X9G//F3FNsd8qgJn45Xy3IpdRdtPieUtV96DCLxkLc+FYN?=
 =?us-ascii?Q?gA1bHAmBuzhcD6aVBhRljm/oHVMBsIeasM7UoWvBwnWK/dMUL+J13tx+5th0?=
 =?us-ascii?Q?UERQzPIUbw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a501dc6b-507e-43f4-6eaf-08deab827282
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:16:29.0872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACU3hJYqTyXD4sij7kJsYqsGNWEjG9IS2/OF/wZakiJUrdBb7OgLxRX/quGRDs5tTiOtSMkBSqXyfnu8fXvGZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277
X-Rspamd-Queue-Id: 55DF84DD29C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-284911-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

With the addition of the LAG offload support it has become apparent that
depending on the order in which a bridged bond setup is created, the
driver could be requested to add the same VLAN twice, once through the
802.1q filters and then through switchdev.

This is because any VLANs already installed on the bond device when the
bond_enslave() operation happens will also be installed on the switch
port through the .ndo_vlan_rx_add_vid() callback. Once the bond device
becomes offloaded, the same VLANs will get replayed and installed
through switchdev.

 $ ip link set dev eth4 master bond1
 [  165.008131] fsl_dpaa2_switch dpsw.0 eth4: configuring for inband/usxgmii link mode
 [  165.021020] 8021q: adding VLAN 0 to HW filter on device eth4
 [  165.083351] fsl_dpaa2_switch dpsw.0 eth4: VLAN 100 already configured
 RTNETLINK answers: File exists

Avoid this by not erroring out when the same VLAN is installed or
removed multiple times so that we avoid the above issue. Also remove the
netdev_err() since there isn't anything that the user can do to prevent
this behavior.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 8353d2230c72..644f720a7ec7 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -372,10 +372,8 @@ static int dpaa2_switch_port_add_vlan(struct ethsw_port_priv *port_priv,
 	struct dpsw_vlan_if_cfg vcfg = {0};
 	int err;
 
-	if (port_priv->vlans[vid]) {
-		netdev_err(netdev, "VLAN %d already configured\n", vid);
-		return -EEXIST;
-	}
+	if (port_priv->vlans[vid])
+		return 0;
 
 	/* If hit, this VLAN rule will lead the packet into the FDB table
 	 * specified in the vlan configuration below
@@ -1993,13 +1991,8 @@ int dpaa2_switch_port_vlans_add(struct net_device *netdev,
 	struct dpsw_attr *attr = &ethsw->sw_attr;
 	int err = 0;
 
-	/* Make sure that the VLAN is not already configured
-	 * on the switch port
-	 */
-	if (port_priv->vlans[vlan->vid] & ETHSW_VLAN_MEMBER) {
-		netdev_err(netdev, "VLAN %d already configured\n", vlan->vid);
-		return -EEXIST;
-	}
+	if (port_priv->vlans[vlan->vid] & ETHSW_VLAN_MEMBER)
+		return 0;
 
 	/* Check if there is space for a new VLAN */
 	err = dpsw_get_attributes(ethsw->mc_io, 0, ethsw->dpsw_handle,
@@ -2115,7 +2108,7 @@ static int dpaa2_switch_port_del_vlan(struct ethsw_port_priv *port_priv, u16 vid
 	int i, err;
 
 	if (!port_priv->vlans[vid])
-		return -ENOENT;
+		return 0;
 
 	if (port_priv->vlans[vid] & ETHSW_VLAN_PVID) {
 		/* If we are deleting the PVID of a port, use VLAN 4095 instead
-- 
2.25.1


