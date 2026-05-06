Return-Path: <netdev+bounces-284907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM2kAu5b+2mUaAMAu9opvQ
	(envelope-from <netdev+bounces-284907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:19:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6024DD0AB
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 304103024A16
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21098495501;
	Wed,  6 May 2026 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hvppb/si"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC0495508;
	Wed,  6 May 2026 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080601; cv=fail; b=FYqLMlvlB1ePgIPJqmgHfg61irrK4WXWBK/3EHFYoueK0VqwDl6q9y5acpkSET9rvqiCX2jvCSEM4RvIhBViCfbeb2zY4Gxrh1TqL2tniR4dDINW4JkKkNJA3lTr4Xls9sr4dfFnVjjtxRaYXYTMSsDfrKsw6WDPUKvd8jeDxRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080601; c=relaxed/simple;
	bh=/tYtQseD/O4A/xl7p6Weg6EufBvtdn6a95h1XYDH+FA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQ8qKhR/bSlAw3BcSgf7fVw6/J9QVZ9cfpOOHX8KOYSbpOqp34OSE48iQjeHHXR4LlQ+Mnfxd7Y588SkPg9v4XTbaG6R/rcLp0f9uPQcxNsy4UXZ1gisTj2gjlXHuJnxLbUcJA0UIgtuEj1h0OQxK/qbFBTxVHQLPGVQwJ9chsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hvppb/si; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4P5JwWh/HU1AKC3LEYvmAw/crgiN1XByDkUTHL20ynaMR7EDOhwkgnNoRSYUwp49nzLftz5skx/1WfOoXAGvozgrQduEo2TUg0kxOAuuGaVGLnkRqPz+KlfX/KkwBxpIaXONAg8ijKEK//Wvb9NMlSJ4YkRqaqA+LSU9sUHRrDfbMS2UHVcgVZwU/GrB//lQf6yA8TqsonQEGM+guxk6o2TpnvJiA1yRLF8h+giiNnbbmsJVUH7Xqe7SyxVvNmFqHfd6bQDBrY2ftazi6Fzld4cmG4tsbg9Wt0hLWmrgOLqwEqLwFKbbuUeks8iysuHQGpjP35bq7RI15ZdxCXp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7E3PB3adoMSoA7GpEic68PpF/o228pdMJya9L/amrms=;
 b=VY9Pc2S2H1byHZB016tFvuEhjCyOBIncb/tl3AaZl5mqvwDDHMi0NEmympJx7rMiqShLKqMJHpC78DX2s1jOSboMpsxy2ZMTtKli9jx/iuf1KEK4srLkQj4SDA51hsltw8eCOPCUiw5KXWfY83s4+05vemoNS0aN4qxXcTgp9HXYz8I1P4MDYYCiUhYzHXsh0cWKXeR+1mAOI5/rSweqje2DeiP7Ptfrtau81rc/Wl97sm3fv94FdMfqhAi0nq2w9j9UhYbuC/rGiOfRLe7NkCIi89kj3GlLKYIWR9XUorM5QSuOzK+CDyYrVx2tGRWJztLHkRRjJ05d6KZG9txBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E3PB3adoMSoA7GpEic68PpF/o228pdMJya9L/amrms=;
 b=hvppb/sidYdYOSMnI9X7l2k6x3rhTbGG6s4y0+/44J+bdekUYoX7kZy84sRZnhmPzA712MbrsLmdZvqtWMA6/uMrpBT08VwOE+TvcpmMDbkDAbfk79CvqkGcOv079d3OmF6Dnu7FsVgdr/QFc1LHvvrIUqr4ynJqEE18DNW2IFBnh7d/B+DiCzPgMHGBI+GLJ/XNLT1ob13G83i/w+GrXkbQfU6L6reSOL1bBV3BkcK1Hdx89Ijd4bMMy+qtjwRpiF6I8U39KXwuhObymTGtQd6+8QrVygEOqrbVuTyBVUlyyhQHXRZF3B3Fx/HWHoFvO6FOFn5GGawlmpA0CZEXeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by AS8PR04MB8277.eurprd04.prod.outlook.com
 (2603:10a6:20b:3fc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 15:16:21 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:16:21 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 10/13] dpaa2-switch: offload port objects on an upper bond device
Date: Wed,  6 May 2026 18:15:37 +0300
Message-Id: <20260506151540.1242997-11-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::7) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6e9094-e4d2-4ae2-2c87-08deab826dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wTypUjCmbArCa6o2WQZ5YwWmSrRWlL1BQvbvuHLeT1mbz2zSosmKotxCKSWRhU/lUtjBlAEfFJARrWUHfxHxrg1WndjIMwU3ZyFcHBYi4pfC+vRYUVheJa6eHDyKYd7953w7kaAAMkLgIwqRirUXCoFLBD9b1LkYxsH7OvDTbtAKR6Nj0BEvNEGcI4dwfRDQ9Y7b6KoU7+IO+Z3dKKmQSumI5pSHUcnXE3unfmNuIumLuD8N5V5PSOynJMUqOGSdH6JuYpYrvkr/NfBXd5x2jsX059vo1PowGojzGPWGO1AQCmGh5JuAPFDu0ExG6zXnSf3sK8/s1ctdqbzAE1Vgsgg6OP7F9zeejEzZYsvEKgPoqHh0QZ+LO2fUQzIdYPhdWPM+7RRodIaK70U1MENF7qe4V573G1mGrhzSNHn+2le2US7ofbf3CKGZOKmiihfi629TrmAdcI+B3v1CYpTeq+N/jpG+6/AHamfZHmk3VID2L08MDTJ434bFJucylsmkpMFp7lR0jC9h+XSWCEMGQzS8rRdR+kmlDiu78LaYl9udvmE0+3UB08GNB7dMdz6NBgZnB9qCfCqgDgoc9zsmKcH1rpMUYILWvFJDh0NiPhEv4appFkcM49IhzF6q6fH38Oufz63wm6F09AJiGb8UxN94forbGLSTDZWiCgU7Gw/6BanBiSCkPDZz7DfeGNKh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HpbvGM94sRz4U00iBvbK466n6PYL6uQY427KoWzQ7GROordYpUPSLNKJ62Cm?=
 =?us-ascii?Q?Xn4AY7X9clfU68ZU1reqt1H3mWS51NqwrHcS1Fe2X5zSOkSgdg1r1rfUoOvd?=
 =?us-ascii?Q?iPHeaPcOV/kyxHYlpl1gSI75E+KbW5+RkOzndf/NLAmbDqxboYo13AjbA4z7?=
 =?us-ascii?Q?Lwex5C418+PfP4uxM5fPPJJienv7uH2MFP6vNFt00IkM9DZykSHuWjRyseTG?=
 =?us-ascii?Q?z8covDReHiUoxAnii0MgYjB2k9VUhFxPiAqzucn+nMJB7kkXIGJ1KdAcfZ4Y?=
 =?us-ascii?Q?zlqnyjNYJDkUXnSJIY92xUrGls6o7Zoi7/2ifpRYhFWK2zE1EALFgq798bu1?=
 =?us-ascii?Q?AxCyk78vOIRuj9dvMgcCWJ3p/DAd/k6qCAqis2CaHL1voo01RHDAkgzECR7B?=
 =?us-ascii?Q?GOFr/mCOuztNmbzToP7YqEddIUg8kjLeex/GZMT/gcI0iOqG+emVxBDONBbm?=
 =?us-ascii?Q?1U6RctXAM6ctGxI+4RHxMtVYmUHztI63IQrXKwRiMcPeura0/4V6FOCurqYz?=
 =?us-ascii?Q?soPNAdMxwN2+fMYVra/1b7CVYOQbHP1mgNiaez9Xbx77txnH5einE9M2XGOm?=
 =?us-ascii?Q?rGHzWj817zQUALpkohkQYk5XzcB+QrsZljRTtlqKdW1wB8Jr1p5euoIL0x4K?=
 =?us-ascii?Q?eX/VAM5+Kn+chZRFXib7KahIU7YnBrbr6eFY96jNI7YpqUo0Ewcp/5ledkVa?=
 =?us-ascii?Q?jf0nh+qK84fzmPx0CsDCnj+70gw5FbLKWOvbBusNwquLCwbah+qcCwA7Bix2?=
 =?us-ascii?Q?uJqaWHMzShCEDAr4HqjDYe+TL/MAay7+ROZNDcfefjXjHiO1+jDvmfN4TOCh?=
 =?us-ascii?Q?vl+QxTnOce2CX9WpTK2EDNXqeHn9EM8JM0Z3JC5OopxA2bStx0I5iAy1820G?=
 =?us-ascii?Q?CKjDDKWd4eJgYGL9rEzkW28Osc8OxO8n6YUSwUd2lep50zF9sS3gTQSmby3L?=
 =?us-ascii?Q?fytEh9bMd4JdA9lrZhREcFsvW5H7OxOm6pWkthS08NFGI1E5Vg3Rr+r5PaKp?=
 =?us-ascii?Q?WsifABqddt1ImkqrnDjX9hH0WxHxuKBTGOj8Cfg7aWNEgmAN0wla5hEFZuIJ?=
 =?us-ascii?Q?ra0PmHOpXnwPAHYhz9TGYzIE8/hRx3PDGLMTfVEJQMDZ669S5EyJ4qJBURSQ?=
 =?us-ascii?Q?t6Yn3gAd9yWlN+kRon+q8VAGorxIRaB997r4Uq2z/5TG7UF7Sh9QhM0m6GKA?=
 =?us-ascii?Q?NI4ZssopMkFf5WczP5ORqkN8He+r/ySkSVeuPkfKbKuneFxvClyHaPtIW/i1?=
 =?us-ascii?Q?lsEQAnSNMoWtn/hqdwJdtlnhEKznIb3Mt3HPHR5jKDbGerlj/SG4V3We3vEh?=
 =?us-ascii?Q?eIsOCOZGIPliTSEeMN0gYJCIdks4HYuRZOLPEqXEjPJkFCiq9zXp93WbBhdN?=
 =?us-ascii?Q?40rmsV0rYh7Okoyaca+gWiAsZpi28GQg9pDvZ9f6P0Tq17aVttMphAGQ+8sy?=
 =?us-ascii?Q?L1F+5E/vRb6PYIjrQbCxQqA8uTVUjGckh7vmqh3sm+1HrxSEbNSog+FOrF+L?=
 =?us-ascii?Q?Icida918ZNPpfPfuIbu3puyvEY0JUITqjRXhdyj45vz/n8e77FCPs1u15SII?=
 =?us-ascii?Q?LK36cRX/DABn12aYATG4YqEngbBWUBRxS2b4v4fuvW6vsr0seBIKA7I3eRe7?=
 =?us-ascii?Q?teeP6gbT1Dn6UJAXqcZPS3rx9F+6/05k7KoseR78h2mETRkExaCNoHf5uoDa?=
 =?us-ascii?Q?peAMr63FBSeZ6csqDLHsHGdY0icxN7Q4B6JnO0Rrm7q7G5VnCh/LuGDbam8+?=
 =?us-ascii?Q?6QYCPKTSOg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6e9094-e4d2-4ae2-2c87-08deab826dd4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:16:21.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaXKXaEB7xPhhBaRa3LfoWDSsIkO/lYKdaZ7jHUFIEqjSI+JsxwdX1Ts9JPvXd80+4QWhhp8FPGoYT1bNgdwag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277
X-Rspamd-Queue-Id: 9E6024DD0AB
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
	TAGGED_FROM(0.00)[bounces-284907-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

This patch adds support for offloading port objects, VLANs and MDBs,
added on upper bond devices.

First of all, the use of the switchdev_handle_*() replication helpers
is introduced for the SWITCHDEV_PORT_OBJ_ADD/SWITCHDEV_PORT_OBJ_DEL
events. With this change, setting up the 'port_obj_info->handled = true'
is not needed anymore since it's now handled by the new helpers.

In the DPAA2 architecture, there is no difference in adding a FDB or MDB
which points towards a LAG port. Unlike other architectures, we do not
need to populate all the possible destinations which are under the LAG,
we only have to specify a single queueing destination (QDID) which
represents the LAG. This all means that handling of MDBs in bond devices
needs to have refcount mechanism as with the FDBs.
This mechanism is triggered by calling the dpaa2_switch_lag_fdb_add() /
dpaa2_switch_lag_fdb_del() functions which were added in the previous
patch.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 66 ++++++++++---------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index cce0af47ca07..17a7a64064b5 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2060,7 +2060,11 @@ static int dpaa2_switch_port_mdb_add(struct net_device *netdev,
 	if (dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
 		return -EEXIST;
 
-	err = dpaa2_switch_port_fdb_add(port_priv, mdb->addr);
+	if (port_priv->lag)
+		err = dpaa2_switch_lag_fdb_add(port_priv->lag, mdb->addr,
+					       mdb->vid);
+	else
+		err = dpaa2_switch_port_fdb_add(port_priv, mdb->addr);
 	if (err)
 		return err;
 
@@ -2073,11 +2077,19 @@ static int dpaa2_switch_port_mdb_add(struct net_device *netdev,
 	return err;
 }
 
-static int dpaa2_switch_port_obj_add(struct net_device *netdev,
-				     const struct switchdev_obj *obj)
+static int dpaa2_switch_port_obj_add(struct net_device *netdev, const void *ctx,
+				     const struct switchdev_obj *obj,
+				     struct netlink_ext_ack *extack)
 {
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err;
 
+	if (ctx && ctx != port_priv)
+		return 0;
+
+	if (!dpaa2_switch_port_offloads_bridge_port(port_priv, obj->orig_dev))
+		return -EOPNOTSUPP;
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		err = dpaa2_switch_port_vlans_add(netdev,
@@ -2178,9 +2190,10 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
 	if (!dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
 		return -ENOENT;
 
-	err = dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
-	if (err)
-		return err;
+	if (port_priv->lag)
+		dpaa2_switch_lag_fdb_del(port_priv->lag, mdb->addr, mdb->vid);
+	else
+		dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
 
 	err = dev_mc_del(netdev, mdb->addr);
 	if (err) {
@@ -2191,11 +2204,18 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
 	return err;
 }
 
-static int dpaa2_switch_port_obj_del(struct net_device *netdev,
+static int dpaa2_switch_port_obj_del(struct net_device *netdev, const void *ctx,
 				     const struct switchdev_obj *obj)
 {
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err;
 
+	if (ctx && ctx != port_priv)
+		return 0;
+
+	if (!dpaa2_switch_port_offloads_bridge_port(port_priv, obj->orig_dev))
+		return -EOPNOTSUPP;
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		err = dpaa2_switch_port_vlans_del(netdev, SWITCHDEV_OBJ_PORT_VLAN(obj));
@@ -2985,37 +3005,23 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
 	}
 }
 
-static int dpaa2_switch_port_obj_event(unsigned long event,
-				       struct net_device *netdev,
-				       struct switchdev_notifier_port_obj_info *port_obj_info)
-{
-	int err = -EOPNOTSUPP;
-
-	if (!dpaa2_switch_port_dev_check(netdev))
-		return NOTIFY_DONE;
-
-	switch (event) {
-	case SWITCHDEV_PORT_OBJ_ADD:
-		err = dpaa2_switch_port_obj_add(netdev, port_obj_info->obj);
-		break;
-	case SWITCHDEV_PORT_OBJ_DEL:
-		err = dpaa2_switch_port_obj_del(netdev, port_obj_info->obj);
-		break;
-	}
-
-	port_obj_info->handled = true;
-	return notifier_from_errno(err);
-}
-
 static int dpaa2_switch_port_blocking_event(struct notifier_block *nb,
 					    unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
 
 	switch (event) {
 	case SWITCHDEV_PORT_OBJ_ADD:
+		err = switchdev_handle_port_obj_add(dev, ptr,
+						    dpaa2_switch_port_dev_check,
+						    dpaa2_switch_port_obj_add);
+		return notifier_from_errno(err);
 	case SWITCHDEV_PORT_OBJ_DEL:
-		return dpaa2_switch_port_obj_event(event, dev, ptr);
+		err = switchdev_handle_port_obj_del(dev, ptr,
+						    dpaa2_switch_port_dev_check,
+						    dpaa2_switch_port_obj_del);
+		return notifier_from_errno(err);
 	case SWITCHDEV_PORT_ATTR_SET:
 		return dpaa2_switch_port_attr_set_event(dev, ptr);
 	}
-- 
2.25.1


