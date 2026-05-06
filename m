Return-Path: <netdev+bounces-284909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM4+CRFc+2mUaAMAu9opvQ
	(envelope-from <netdev+bounces-284909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:19:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5304DD0D6
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C78BF3026F39
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF2448C8A4;
	Wed,  6 May 2026 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AjQd7V6h"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359F265CDD;
	Wed,  6 May 2026 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080612; cv=fail; b=IiFnqtSsUq5m9ezfrssatA+36f+vwJCuIGS8j6Eg/JwXCIKaYD887bPnRoFCORYGa4bY6Qt91NN2M/x4F/Iiu33AQYD1WDc1SrY79BUbXqR+ZzQSWLLvDsoS66XgxG6ArXyRTed4pvTT+T93G10hkThx5oulNGz1T9fRASdzxv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080612; c=relaxed/simple;
	bh=YgcrTSMTk7eB5IevlVW5At5th05TAWdV0/1eW/JKyx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kt5O3WWQ1MaSA2Y2KWD6IGvGPx+enn7jAAAflHQgT2YF0OCO4h94ZXqNwkutS/1xRjnJTbGcJvy2IgYS/yrpw48XFveLNcydYkNqXKP7TwsT0/9cMViscjGnKQTeA9GVc/N0a4HP5E+6WzAY+V1Xd1uzU6F2zx8bY12CcFxnbkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AjQd7V6h; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPmnIQUpMR0X9CPeP4HQCZg8SiWgFSR0i/K6TrJIv4LljF+JxAeRF2DxeG16aQZPhlzFgXPdqp1YPIikTgo3g+CoDk7Hz1LxjUgasjAEwz2RpkdPhOFdd6zA4LLykmfUVKXzp53da2F0L/RAwCnjVDmOqgmnTu4V6vb9So83ztmEGQ8j4Z7T5tDaCI49j8Mt3qLmTaioKlS5+prDYCkyF+2yeHqr33jlhm3nURV4Sh4Y7hiofnk36DfFRSnuFJSIkyXWqj4wUfh/7O5d9sOgHefEG2hkOQ7hbzCaOenkjjj9ikLBTeAa46vxTmNBlQBZR5i2lsQl27IGeN3x6SPM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz/gRczS5DKRZlrDs3aDB+Jv8vPV10Hry+3iKAcQdFQ=;
 b=EZM8rCSVg9ujeIt3MORjqZCHpwjE8nu/lrB2Y5OPZIA/Q6Tewb+as5nwPHjFNZzbvIOvkDzsb5T0bHxwb2mE7wq/l1Uu0bOuBUX//5ZlN592tyZGVFd882mrQb7zWeqlOBwO2WPBO/NnlTRNSiTwMmqUGxgl87fMcSKgAx4pnT1au4MRYapnEdtMV4EQEALESYDTt9ceiWGg4hod0ys6jbYSgllNNHAoTtj30EQHk17msJ2ZPK2uL8tPoMUKM8sU4B00xI2UiLf07YgR8cqnmyiv1SAnTK251qlZu1uZRLTGDIYataKKQYyoEs4og8fOLaJV8I/nOpJOK5UcpAcqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz/gRczS5DKRZlrDs3aDB+Jv8vPV10Hry+3iKAcQdFQ=;
 b=AjQd7V6hTuwUXXSvdDvzKOKBCpeY1TooNe5bjgqHNZ9232tCdrGL7wCRkpKWQMf6ols+BqevZbVkz7Ajh2OxW0YxWIpCDBGtwrrvgXKNcbfjuPaCOTWcPmzOOsrL38sR5GgbA8ziDf7YMXIfSJDqohUxNiBUlD3riPEooyvVtpIjn4RKtn3b2X7aThVkCBIUAz3xzDNe2gfVezlZl/K9oJGS6ZFlI2sl3x8T9/sof4tu9O5n6jqdoSje8utMSVFqjEAdWB5YqAPX1ESr8VXVN0z5k8KetxC6uqZYzDmXQMpKsWDl4J17I1xoCk9QFaXsvJPns2sWul9sxPzO7LkDNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by AS8PR04MB8277.eurprd04.prod.outlook.com
 (2603:10a6:20b:3fc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 15:16:26 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:16:26 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 12/13] dpaa2-switch: add support for imprecise source port
Date: Wed,  6 May 2026 18:15:39 +0300
Message-Id: <20260506151540.1242997-13-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0017.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::11) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca6c88e-85a3-4d60-a513-08deab8270e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	24/TQvgZ38gdGaSHpzlwbUQZON5t+A3p2qm5RSNcvETsRiW4efpN2krlKUkYyHzPOjN7bY9pruRWHiH21R+WbPtUMzNLLDOBVelHGa3RStV2SL33JnOsCcf+MpaaKKvIzIz7Q4xPz9KdiGUq0DmjSRh/fI+ViEiRm8KUNTz0Gcjlm/EQIwz1HcPZEU2KyeY+4K5JhcxJVzMdTEj/AHPIQ85MlzDvmvCFwhHIP0VQ+7W9ObZXWMDXezt3TzYCNodMr9VYoCLpT1mpqCNe+I00fh41nNYJcWhTZOnRosGW2ZkgXMEjRiLqpC+8HiW699d+c+HvqPyWcHNdzSWKAJCvX2BjjxEu+IMmX6T3yhcUbEGwPCX0HHgsWhOlmhV+2nOcFQ3ZJBno7EaiDIG4VjEfExtpPsl9ERKveZbKRbshsAXCeh0hQpWqbf6v/m0DIYawCA/JQTzl+F1KMOHMbP4vV5bvkwG679xZaCrg7wmjEBGxvubPfGmOpbWakKYNc/PqeheBiDU45HEd5YJ2V+xcTTlcA4jmWbpErlF8IJBOlyzzz3ScTvzWNbsLOgJ49Kd/umdoWiEF1vxUTJWFZomraPAHEdOvehsLS8nNIxs5Em9fiqjKZh5BuL7x2yXEMGjzTReWC2ulpulgV5kO2QjjnNr54ooNUpUtU7oH1EShguz/g/vrXDsSnSKsDzcPjwaz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J1taDOKGReszsfV2/S6ZBlA4dhsS42ZyG29CRsBcU0I/3OlGI/UJCkFo7vZU?=
 =?us-ascii?Q?05pzOVBqFpXJBfQXgDzI6WLKdXNmN503Inocl99PNbV7FvUHb9AlSjzqK+B7?=
 =?us-ascii?Q?eiUhnEy8rZWD/4MQlTRHWzZxIKooS2CpGptAZW/nfSK3235yQGYq+cBp3rbD?=
 =?us-ascii?Q?hBRf6CUNbZGxMC+G4S0bxLQF6UtAia3VTDdbfKM9b/7Vh++QDlWwzGDVslSd?=
 =?us-ascii?Q?uWFuEOYgcyal39pTXtdo+5sJmG5i9P6MOJK+6MR+4M35Qk1Bjn3HNZAGuzqR?=
 =?us-ascii?Q?c6mWLveYHCDi/WZweePbfNuzS2i2SvrsjUqzy23ZPp1kTwzSCKxBSVWXvhL1?=
 =?us-ascii?Q?5G7j8rUkdxIDBCYm7aiLq4dT1dPughV0PZo7zvti6F2mCHHMlYSH1gorr+Lq?=
 =?us-ascii?Q?D/b0q5GvqXcXTRYZL2bROt3OEetQifIA5oNXEKWy5NSTsQlWbo4MF7ulIDql?=
 =?us-ascii?Q?PwrVfl+UGuMIUgws8U3JHQa4O/RSDXfLHzgV2Vm0tOo3p1rVMi94ST0VSoXT?=
 =?us-ascii?Q?dd4nEeh8Vh9mmw/v9onixHml2SH5ewk5nhylik9UWWzRfG6UukTKh1UemjCv?=
 =?us-ascii?Q?qn/QZptrhN8FdHWdwx2fQFXx2rdKkQXWYksGFg/dywJsWVgEqX0HcD0q4Era?=
 =?us-ascii?Q?6ARgqvboxsdqXRNDnAqq9DNo0LAW97uRP4Q6ByiWZCrjy+kV95ksoV8Ia+Hk?=
 =?us-ascii?Q?vyYN19W0w4gBIzmMrOYtr1osumpls0WRrzP4RTDa6eBfoJ5bso4EZp3omAdN?=
 =?us-ascii?Q?xMYkBr4orAANZhcpcrJ5idcQpOUgNSAOR4IuO8K6MVhBVzAyCedCOOFI1vQP?=
 =?us-ascii?Q?QnC01Tf7T/IuVYrHICG/47+GZ/Bb4Hbv6Dq+Ba7b7eOOmCd9nqJROySBSod+?=
 =?us-ascii?Q?FdbfEqIEpPayXdL80HOunwd5BjI3+LEhOx+PiRY+/dtI3v2stBuGXM6fCudA?=
 =?us-ascii?Q?Yh73C2AnV9WajSQII+onKh6ekqIzmDWytsLFad/YNqYK19q8h9UKW7+TUMWj?=
 =?us-ascii?Q?QrGo8DC9E2c19Oq3nxj9AmdPB0OaoGJviAzdnOFAeSEaapseMSyRLrP1eDum?=
 =?us-ascii?Q?POjDeTPD2Y9G9Esvt0l38HBYUkwYx5IS1px8b72kySj4ExCUIqBORhLc6G7H?=
 =?us-ascii?Q?cFR5caMxcF2VuKtTtXAwKqesKKDbabK6ySDkuJVtfE8eXfEVbLQstecxylUD?=
 =?us-ascii?Q?D8vioKyEhuMocmeGbAWQTOyFQ10pWapIfEc8BwWkYGyXV2NUZ0CwmveLm296?=
 =?us-ascii?Q?ZMJ8Z1sgM5eNErRO31RbzBHJuRRSgj5BwRaB1hb8IzLnu2rMJdiCTpGeXA/A?=
 =?us-ascii?Q?So8ZnJGiafH10SC3Mqtvr4GAGxuR/zeWQXDcO09hLinDIQH8ZK1fgZBRGVwV?=
 =?us-ascii?Q?kF5Zs9pMwfVrsQsuCcOdf9QSCxN0cu3yTdmTDUa7rpCOX8tHagTQZaCidxFb?=
 =?us-ascii?Q?yKZNNl5zx7NXf9mlElR6kjwT0UuPt2jDm4swBOUWySeop0fIwq9cnrqjHyhl?=
 =?us-ascii?Q?Q2Ss/ji4pCKX8vbNbcJ/ielxwaNLyRDhny43xVIUz++JWozJYFuEGhvCs3qW?=
 =?us-ascii?Q?cXajkR6Jiw2dIpCnsQwkkNut+GcIB6J3Uy+EMrpXmOJ5zGtWJ3Qv6PJyz8Zd?=
 =?us-ascii?Q?pFnKUlpaj59ENm5CQBuVFZ9sp2NVsqO/qfCAdOwxxNj96cH/qNbg5gOJIDqc?=
 =?us-ascii?Q?you8yBAnDV4T0JexcKtgFyuOsDNK+6IX8KeJLJYwlyme2pSovk4TAvBI9gg4?=
 =?us-ascii?Q?9Gzc/B5Mgg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca6c88e-85a3-4d60-a513-08deab8270e3
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:16:26.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMWiF6VOS7nfld9o2KvRmUktz8M0MRTEaf+ZSoU560c7Yeq4ebyF/1ylr1In+SM0SRKt8ZKuuF/4/izvKbICeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277
X-Rspamd-Queue-Id: 3F5304DD0D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-284909-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

Switch ports configured as part of a LAG group are not able to provide
a precise source port for all packets which reach the control interface.

The only frames which will have a precise source port are those that are
explicitly trapped, for example STP and LCAP frames. For any other
frames (for example, those which are flooded) we can only know the
ingress LAG group.

Take into account the DPAA2_ETHSW_FLC_IMPRECISE_IF_ID bit and based on
its value target the bond device or the specific source netdevice.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 10 ++++++++--
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 59ed06ed7ef6..8353d2230c72 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3075,9 +3075,12 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 	struct sk_buff *skb;
 	u16 vlan_tci, vid;
 	int if_id, err;
+	u64 flc;
+
+	flc = dpaa2_fd_get_flc(fd);
 
 	/* get switch ingress interface ID */
-	if_id = upper_32_bits(dpaa2_fd_get_flc(fd)) & 0x0000FFFF;
+	if_id = DPAA2_ETHSW_FLC_IF_ID(flc);
 
 	if (if_id >= ethsw->sw_attr.num_ifs) {
 		dev_err(ethsw->dev, "Frame received from unknown interface!\n");
@@ -3116,7 +3119,10 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 		}
 	}
 
-	skb->dev = netdev;
+	if (DPAA2_ETHSW_FLC_IMPRECISE_IF_ID(flc) && port_priv->lag)
+		skb->dev = port_priv->lag->bond_dev;
+	else
+		skb->dev = netdev;
 	skb->protocol = eth_type_trans(skb, skb->dev);
 
 	/* Setup the offload_fwd_mark only if the port is under a bridge
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
index 96d780980d77..6d7a503f9be7 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
@@ -87,6 +87,9 @@
 
 #define DPAA2_ETHSW_PORT_ACL_CMD_BUF_SIZE	256
 
+#define DPAA2_ETHSW_FLC_IF_ID(flc)		(((flc) >> 32) & GENMASK(15, 0))
+#define DPAA2_ETHSW_FLC_IMPRECISE_IF_ID(flc)	((flc) & BIT(63))
+
 extern const struct ethtool_ops dpaa2_switch_port_ethtool_ops;
 
 struct ethsw_core;
-- 
2.25.1


