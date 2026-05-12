Return-Path: <netdev+bounces-287161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAyNJh03A2ow1wEAu9opvQ
	(envelope-from <netdev+bounces-287161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:20:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C4D522402
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96AB4333F46C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181383A2E03;
	Tue, 12 May 2026 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IcpylkVc"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482163A05FB;
	Tue, 12 May 2026 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591803; cv=fail; b=jKlSSiePRLPt4dsrewp8ATTcoKilWTVV8/HIWmd7J+NudTgEExh1ct/JXtUb6S3xThT/kVYA2nLjumktUuXzgapOzc2Pigxur2jykT/RrOfRxf8cwiMSa6kyJVYUC7tzgNTR/as3sBkBMWf0ljC0Dp+1xR06nMApAs4E6TZ5X48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591803; c=relaxed/simple;
	bh=p0N8jbgNdCv7CIyd1H0gc5KZVwoT3N+U+rgeZ2p8xhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XwstfV69ij9m1rzgUsAlUJpij+l5zhTblPEcjHfwAFKD5vVjGdqlGgsZuhKdUzN74N82RXvIoe1irWXOfjxaF/rnH46RjVgcRpQEqnxpVOPq9JQMWmyns9maPRYu24vO52iQU8nmVbVvv+KAHr6z5H7ez+JCeeE4+Um/ZQWQRo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IcpylkVc; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiC5ByUEy5fLBNbXFTw3q1aXnJijikRSrXBBo609POFyrrkJMhnqnEJUe45rK5JTOKuBl4RABkkWUTnV8eH7G1unATX9vKuZ0uSkCULyDLQc+UP1o1Lbp3cheNUAVE40U6xxasDByw4VPAjgc+StXv3sBtIwDKTJjDzIdGjfogijxk1oVJXfRMnE5gotbwyRtIHGW84EqBbkIW42QHFXvYz7+cjvDj5TTYxG5qLjq1FBDGH3pVEgV5Pu1X+x+Aucut/tGUss7Da2YLiW7xgYWoebyV5pXNZWIszPyEIW4Oy049/pG9jiNWAbf1My+K+DvExO5U8aFpWte6C0awwfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhNXGz2rbBaJteh/HovRLwhWKqr4dJxhLwti4B6B9Cg=;
 b=Nkkv6ZWIiNiCZS28OIF8BKUC2KoDcQew/fiJQD4J/RTw5A9bQ1lw5Y8QrOPHkp416XaYRXLc+bYMhPoutCbBJvNMXkocNaXkqPv7bNPY3qNNoyhN7aSIq1fIhrPFi9Dd94x8L2RsPVaE92qPcEwdbz2mWQqIwDl10dSa7fAqWrzyIYlqhEybcjki4nQbn02whR2jzZikQO6CZ/xljvPqDxrA/8sza3TITXL6ayolZ2/UvLTZq4/9c7oqnVJE+6TTFjIu/qjyYz08R71Uweo6GgZc9HmcnWJgaDshW/APiZHMoM6fG05sJ55ed+xMvIdmzHiweuED+YNojI0DOewVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhNXGz2rbBaJteh/HovRLwhWKqr4dJxhLwti4B6B9Cg=;
 b=IcpylkVcBR4iFGNEgGvUHriwhWKMvrKTAYXOQOsz/gQPNlSRGx92+NT72c69E3AfOn4AcE1xoYZxFXBfPOMqcWxSncRzNXqgPWE5TBI7YS71TAAHnyYf01XxF36zqFNo0MECssA09iOOjTOCNn1sT+SArCLGAEYepsffFAmZoJtQzhSsdHH8ooDW9wyj3Iz56I30XcFjhhXqg0YVtNpVxMfL11p3PenmQYTmKAI1ark5ZlhfWWYBfLtDtcNE+7JtxFs7XKGRZkqtp1uvf/4gxgiK8ULRa/L/y3qHnpV4hemo1yHkix5KDnPEyqQsLT+gEcXo+CYThSd9ok6T1C0LTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DU4PR04MB12328.eurprd04.prod.outlook.com
 (2603:10a6:10:629::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 13:16:38 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:16:38 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 10/13] dpaa2-switch: offload port objects on an upper bond device
Date: Tue, 12 May 2026 16:15:51 +0300
Message-Id: <20260512131554.952971-11-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512131554.952971-1-ioana.ciornei@nxp.com>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0037.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::16) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DU4PR04MB12328:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6c47d9-1a69-4105-c644-08deb028b330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	r/vGq77g4LFvLW5OLXcRBTjTZOJiC9lHQPkYH6P7ywtqsxZuG61spkbzrd+cjoVUJbyKdAHURG94xjv6OZd5+IVohCqWcTaMdVuChaRjwNYpWFug/iaukZPSp5OomHSp1v4+6Y34oAsHvZPuhxBm8FcB3Nt1wXXmO2hh2FnUkSukmWj4H9SSNMvBazo8wQ5yN2kVudabMCyma6TbLrWtJJqrc75/suM1Zke0qJkM3ZGlNRrTu3uaYroFGVw2AkNQsc7WTQPYjALJ6Wvd0Z7ceJyvD4DihyW5WXZn1E26qFHN++9f3WCxPbDDRblX/fHZdSTq8m6BM1HlsLij0qa7WLjHFIJHqDRZVmZbdTwqJTNr3TKmH0jWGO0ySupFXltxHbOvLgAahTeWZFMSTEGgrWsuujWIyHEu0YgyaFFmB1B6QUNY11aemoCFmd/PxuFyZe340G+LuXIUTiLxizNW0kyBtgz/zqwgRe1cduYMVjhRgmAA0e+E/4zxPuipP/gWmMSfeJD9gLPPePcHch/deIqYXDC2UOggdYQEqlkoGf15sEczlunGD2XmYnsfYakHfN/L0GSqIr+NJdQjBBH5HF1Fq53lBw4rWRUE2OQTyoBCGXQK5nqDZ9NZL/QlAtt0MgcHcJiXP/2LAHSVPvV5iO+lYW4NzMA6LKkQt5LdcpmZXAUeYGpSvaYhk7YZMi7T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vBCRJV2+UwjeA/8+rJm7PGTRtOJmXBSqwusS7CvP2AjsCzZgcwLShVuRc1NT?=
 =?us-ascii?Q?Nh/NG9xy6qiyKnbRiSn4j7ttzYxtf/ks3ZiWn6XIOzu1iEP5X7m2gS7ngxZM?=
 =?us-ascii?Q?ybmD5z/y7hcvkZ3vVbzdxH82whjplzsmlzorKcQ8AiqMxMou1JH8ie2uSAqS?=
 =?us-ascii?Q?HfhkhpTpX8q8iDqj63WZSyqomUf1fXA1ip2zEdmuoJHckmWGhJEJHHmjeNHu?=
 =?us-ascii?Q?3ue7dLvjxiB5yQaZvqSTZ1AXjOah4eGm1V7qRjsPTzbL7xfYotp7y4NwQg4P?=
 =?us-ascii?Q?SmrIIKND5OVHrmRjiD27SiF/LFWO8r19jmgXiwimvEa8CHDbUP1nE2ij7DAD?=
 =?us-ascii?Q?vwp3UTId/kcVtjQzAvmdXVyuWF+yT/7PQSlrTOAM0e6dhGYJ0bki50c2Gegp?=
 =?us-ascii?Q?k+xUnozsn6KBOMllyWbZ452AvzKxT387qcVj49QofidmADMW4gx3b2n+DnQW?=
 =?us-ascii?Q?UQdBhYgPDn67zOwjALW89KxURrGv1VriCG6A++c7EQtJVolbcNUGu+uriKm1?=
 =?us-ascii?Q?27rJhassEmYPIqFd3U6ToeYlvZwSu/6ccZHPmEX36NULXE0fNk1slRJhFtTh?=
 =?us-ascii?Q?EAerskS74p+7PuMWLVMSDntVzUv99cUNpeVHD+TAH9bbaCkrY3K55UG1HuSU?=
 =?us-ascii?Q?xRvd0e1JYONY1otKRZq24hg8KxChFFj2NIfW2MyELfyxoBOPSBjSduXqryCz?=
 =?us-ascii?Q?2fytiC2Bb1o30gvjHFGqC8rUKoXlEWzwM4Ff66prsDs4i2OqIIVak1r20hoB?=
 =?us-ascii?Q?D+VfvE7HiF/ORV+OhN/eAg74EXDmjdtoW+Oq5RJxGY6vIcHcxK+pn5RbwEOp?=
 =?us-ascii?Q?oMxPEOgWt9TKouW0tbMQFuRkEoeYELy6yC2Agkcw9fDiDQZ/A2t7EXKvhyYU?=
 =?us-ascii?Q?yYijPk4ibReP6rHLPeTaezW9YLsWUXH75Fy+O9K00633NvrNMIAMyhpmk1pU?=
 =?us-ascii?Q?gGCwRG92bdEhqLsy/1CxdqkW+yvV6+TO5EJzX559uLC9i/kLpEDj0ZEQ1vUR?=
 =?us-ascii?Q?nLer3or/Lwt/iQCN/QHjTByY/DUJQXHo+xc+hq8d8pFY8Pjk3l0RF143WueY?=
 =?us-ascii?Q?WGDJp9qnTqf47CoXrPVjv3OmBXvDoS8XWaXKauPhAiVUTUImKMc/y+NQcGiV?=
 =?us-ascii?Q?pkUTA8BhdM3nerTyGrShBCtn6qHdfJc6eVQTCy/3LEAnY+N2UH0H2pvsnuIK?=
 =?us-ascii?Q?07MDcZdRu2PvvwPAJ0vXLnxMJe5MF+rgUiKiWsrVGLOOgZO5KiIWLHp2n65t?=
 =?us-ascii?Q?ATT3ju2UfZ7biV4R9gAvcIBcZd77ybE/8wstOeUCpoHJvjntFmiLrSOtuCtu?=
 =?us-ascii?Q?if7dADrPYkONpb0i6Z3ghq7LSIujKTp9zyA81EwghS2/wbXYJaSjkJkGVQqR?=
 =?us-ascii?Q?/U+oDEZ/5A1Aj7foWhf13tbM9f05xrxRI7n2F2/EITaYb/xSXDI+wB0K2tAt?=
 =?us-ascii?Q?l7Mi79k6wLH8tHkKX70J3EjhL5KrIxMwl8pLy3YGNB+ZuiON8RR5Jhc8y/Hm?=
 =?us-ascii?Q?eb92tyeLoHAC+/FldwOY3Yy6LzTFiIotXRmU3eN+RfFfReTHJVR4T6QWwDs0?=
 =?us-ascii?Q?mwnqhl59fG1Qz+ubFuZKfh6+CZq0jmYzN/abz9YWB00GsAItTwlufuz9138z?=
 =?us-ascii?Q?yFbzy0pLRNZ2cKYle845TjqqPTSeAOLP+iVH1/KiSZq4GIbUPvNWaBImkEjU?=
 =?us-ascii?Q?YX7PcccNr3BHZXXLwjjS8U2GT1VZb8cYnJZJcoe1xRwhvTbVZODh6ySdIVQ3?=
 =?us-ascii?Q?zM7nbiMovw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6c47d9-1a69-4105-c644-08deb028b330
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:16:38.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRaGDR7swrj9KEjcbcQO3f3VC5sqqx4ASvgM59MNPfV0yHjMdNtNjhmp1UQWHhvjvOIBcVXjbTgzRksWOXozpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12328
X-Rspamd-Queue-Id: B1C4D522402
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-287161-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
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
Changes in v2:
- In case dev_mc_add() fails, remove the MDB address from HW with the
proper function, dpaa2_switch_lag_fdb_del() or
dpaa2_switch_port_fdb_del(), depending on the LAG offload state.
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 72 +++++++++++--------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 46c148a8aec3..e8c00a269b98 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2070,24 +2070,40 @@ static int dpaa2_switch_port_mdb_add(struct net_device *netdev,
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
 
 	err = dev_mc_add(netdev, mdb->addr);
 	if (err) {
 		netdev_err(netdev, "dev_mc_add err %d\n", err);
-		dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
+		if (port_priv->lag)
+			dpaa2_switch_lag_fdb_del(port_priv->lag, mdb->addr,
+						 mdb->vid);
+		else
+			dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
 	}
 
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
@@ -2188,9 +2204,10 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
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
@@ -2201,11 +2218,18 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
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
@@ -3053,37 +3077,23 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
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


