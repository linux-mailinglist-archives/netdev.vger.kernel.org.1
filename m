Return-Path: <netdev+bounces-287167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIy5KUosA2oR1QEAu9opvQ
	(envelope-from <netdev+bounces-287167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:34:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E49521462
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 087BB30CCA2E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8F438D41B;
	Tue, 12 May 2026 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SHQrxH9F"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013039.outbound.protection.outlook.com [40.107.159.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E522749D6;
	Tue, 12 May 2026 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592201; cv=fail; b=h/vr6+86hxCBNm1w50rOEeKkvO/VYXEaKF8q/23bmB22J1wl7aJHUB+Xv1jeToWnd2TOUkvDVlGBiBapTCk9lgAsW9NJZnGOai7eixkKg+rKfvfgWyCNsku5H1lOwwE79tuFz7bwfp+oCSChIqz2RBdUoblCQ1UJ9qAaV3YE50M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592201; c=relaxed/simple;
	bh=3501q26RzV3U+NeV5fsBoJv/5Hnkckqwcd9/Es0T3bE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fu1+ZEi2Ocknd2Ff5czN+DLtPL+qE+Ktknga0F9SB/NGRZYdyhlhPJv6X/8o4crmQZYBdCUHoQognRCNhpVyDCqB7Lv1uc4krO5yOdxcQMsfjmDkZ2zVH+KQhTumXm2QuL8zWNItJ5zM/Pm0M6E/bd23yvpD+p41RHHzw4TKmHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SHQrxH9F; arc=fail smtp.client-ip=40.107.159.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqH+u/W6aBeNKThsZZbhAHvD7bO6wHOGyIwPn0iBAAbhJgtq1fNanfy2ZnQff4cUoSnpjQWOZl3yRM+8n6ebn3x9QovDQgvlRwTmsyjY74VVrUAsUbHKdYecM+Qf4Gs/hRciLCmt6FEquz0q0zPAEOzdKNrh/w5ubo4guPLWELWupwqP6lvDGQenls3bfJbtVWRm/FQWb145soXxT/G1NPpzAvKZ7teiYrTSHd+nOiY5YHETb3z1XJEWBoBK7K2LZBMVjeII1mL73giKs5ud8STIZunKAz0XBbRG6Jx86/UQ4SL01/CJ9kQVE3UHaNKUCvFK5dPTVYBWNWlz0hDQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgNhhWUPf7YJRk4Dd6SQ9iQDP9Vs7rHck6uJToKmt9Q=;
 b=Ib9qwtt+m+HieKJ2LAorfEXPlNqa5VBoh2r3VEhEixdLLf8zduy3d7YuFAbTSmmtZ5NbwyjzbGPQ4ghkCIniI7T6axkr1eEqpsslDzeQArgeKwsTeL7h9wts9tRjKgg/Fz6Zum1Jq391com4oLMnIp7YxKtlTxLq3iZKoRbrgS/C+Wr8zmSC24XCpUCt5TxWaU1AhDRyJOE9PSKHWz/FKgcRE6xDv+/7oxLMYGLWZEHNcFvNyUu8yykAce21yYooj+yXjb+KzN+3bxu6V9D52E8Kobm5ChVOBXZ69dvZq+2abPS0WgHnmUUy0iCS8TsjGONdSDJdqb5aEDehMaZ7Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgNhhWUPf7YJRk4Dd6SQ9iQDP9Vs7rHck6uJToKmt9Q=;
 b=SHQrxH9FPggD8zfhw4bM8Eh2HeLaIXrNARkdiF0fq4v4j+204OkQhjSV3iePROTlxX/RJLhJfWm6BEKDmqysTUErXNIOiwTaWKUyU6HaLMniay7/IYofxSOjFasyOtunn/uv4GqjDTVU6LFiLx+WczuVdPTYXhZTCl5wvsMVYGhDHe434nenlssA5fe8CatHQ/Q/f/Iu6TREw3cM8v7oWNi4eswZGL3hE1qEJD5431FNKmperIyXmwKeLzGxQbiiu+LEQ8RvbbfRigSOdkOu514RJxFKlfuzWDhEwSrP93lBfSMoBmaRXqKJ8Do6kgdqDeMTW5kc7PU0J3JuWelPJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DB8PR04MB7004.eurprd04.prod.outlook.com
 (2603:10a6:10:11c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:23:15 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:23:15 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 13/13] dpaa2-switch: do not error out when the same VLAN is installed multiple times
Date: Tue, 12 May 2026 16:23:10 +0300
Message-Id: <20260512132310.956626-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512131554.952971-1-ioana.ciornei@nxp.com>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::19) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DB8PR04MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b8f911-992e-4e1f-06ca-08deb0299fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6dcp4f/Xl5qFcVNga7rkuEdHWs6TT/TI3dklDfai6PfVupuUo2KeUjPTo/vYc5XAsF8fZjeA4zEF778vWtF6WgLyEUoima9Yp9EhrTrAKnN5dEsJhK0BJmT9mPk0LbaBFnB2bMCn4s9alExxs4OrNZTVHht/yCkDnQAF22xybxHpmicfIvNEfaHprIwSl8Kstj2/4BEu6DWyxlxQekBoyGquTXGa581Xx/8WeQB6tFlgtWo055v+YkFWLN3fXp+wcobpGEtSykMliTGALsvAnrM3yQcIxa7qXVOGdpX/fVut++dGJia2jET7RLnxHmvEvxfujTTyT5dGbWRFeqJXWFzFu/rVc2RUABaKUenn7blNfNTIPJBjgxQAqQDetlpSR/s6hH7Ur3PAZ2kl1FLJ5ths4Y6DLRd59Y8efzLR/y29qxBpbkflcbZvfGhsEDN36Y1k+nGm5z9Nyeog+7oH4+OH4S1M2ti2X2V6UeUnuqpZzzhkNr4jBEXmhJ7QMiY4Hm0mE/uRz+o08TqgbcI4lWo3Dqhjd6xknpO26tSmRb42yA5D0HH6sLpdXl8ME8anxCtL7HGIwh/qJqROZmmrsOdsCSQKf+xIEUZtOvqr5dCQIViCzcdovbKuxpAkH327o4qHJcBgvvZEWEaZiDJ5Zs8u5bQBVC+UeJ9kLQtwlcnnqQElx9hZl5Zr814mDVSK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iviABHJ7TkkNmyZdIzRyhQIXFhjQIdDHD7Pj1gE3kVOVPd8S5EwO+ZjoMzvP?=
 =?us-ascii?Q?MquQxZB1ILpmFbwBQjU7JhAi4nMzbquJPlwvVd8rICIuoie88gEhchhunN5Y?=
 =?us-ascii?Q?/jdcjps0R/uUDutSHnHGvtuE0QiZXb/F2OPbcf67+j2jCjw2t8PKu9Iflll9?=
 =?us-ascii?Q?G2WYyi29BvVQUO+YERx1pY24s4fEJ1YHZb08u12BoXzTeSSeK1NRTWSw0DRA?=
 =?us-ascii?Q?UCtkS6mTFuFg4bWrbatb2bNJJjUXAbrAdLHVhPs1PXdYav0r0I1xySPqTV1p?=
 =?us-ascii?Q?Gp8uMTHyZJ4c75hWOR2cNGHqbjYm63ey4AIrzKX5IWLM/tPr44TNLH5mFPZl?=
 =?us-ascii?Q?vSMMraPLoS8Cuqffokbk9zrXGvb14WbBikLh8DRP1rG9/VvKrghNgR19C/c7?=
 =?us-ascii?Q?n+BcSrRruXIa1Q5d3JDOvtqhiDHcVEUjnYItzY8Y6lcB1kUSTAApCBmMwDVd?=
 =?us-ascii?Q?S5sMDkyla9qcTNnCdyhaCTHFmBtD82+W5Xz3sC0YsblCOOIjSXFqjXaqz19Q?=
 =?us-ascii?Q?24h2k2Dhx66CTsp2p1gwcsVdDWBCiDJdc7zwIh7XdhzkYdjmjvmvhzPEArX1?=
 =?us-ascii?Q?iXyzDtX4iFI0RZiWrFyA427wzCL5RMc4ZaLawKFoqkKnBkE1THQiHIvrHErc?=
 =?us-ascii?Q?nxdBBnYMuSqj36G/KWjlOrXrC7XG3TbWq0kZ+/P3LymLAdfG9PKPZj2PEnff?=
 =?us-ascii?Q?e3f0L8leg64xKwsuag9OnseUK9P4ysbs7auzQfiNST3E1/ATWaK/Mhx0kkAJ?=
 =?us-ascii?Q?tLnf2giJTRSr0gJBVngdpE/XUll37uFI3DKKzYoUSmJTuaS7LtG2cLg6nwdf?=
 =?us-ascii?Q?AXiHS2DstwAqedVzTnk7R7trtxGywc5wlrAUlQEw6mfU6IhNDq1ufBBh25X+?=
 =?us-ascii?Q?51roPmg/6Jop/AEZbA2Uw9EuDmFSKuK9vCweFhJGIdDT+MKnaHt5hJh3hoBm?=
 =?us-ascii?Q?xsXSWZjfH8HAPArpzBldPJpTQLBHf1Vypp+n4kqO3PrHNdqwTUHjQUyP2q5n?=
 =?us-ascii?Q?8Bln3gVWL76jH3liwA4q4UkeXp3RkY1q9bHekxNi43tOQlti9LWZavw/3Hr2?=
 =?us-ascii?Q?axxMPH25fWUUUW3O0QVl2aJ0ZwpDj+P9Tq5laK9ihnRLa8dlujSi8DpfyByq?=
 =?us-ascii?Q?LGat5oMd41rXgUwH2bPytoi1JMFXVfXclI0z2M2HcXvPef/dNSmBuGrJlnOb?=
 =?us-ascii?Q?ygfzpdxP3qxoMjfqvfZBVUzq7o/imdL6Tre0SFgGmu/QWKL46RLRsFA3xdaB?=
 =?us-ascii?Q?sDdr8+dHp4M3WYIbKbsbPKXEG2swkftetfi1G2Zr/eqtUQpGumciss1cuqQe?=
 =?us-ascii?Q?PfNi4dtrwfZjYld7A4zVrFgLOo6NuDeJGLrtKPbXmOgBihkFdQev9wiJIWmQ?=
 =?us-ascii?Q?BvDhf5gc9WpJGds1vzgCvHthXkC5IqNE4+AMl5YnbxQXAMn9rO+938NNnZxn?=
 =?us-ascii?Q?kdl9Yx2wEilxFyHc0Ph9hLfPLxcg8SVNszV5GXfGvz08CfgGSv+KRYd1e0WC?=
 =?us-ascii?Q?smAuVgd8BU2i5mA1FefX8nrLkUF21kRZexNWAUNnH+9pte5oahNixCH6W51n?=
 =?us-ascii?Q?3nkdUD3tQZSWqbk5uxckiiRiAdG58tDP9l4eCQTFn1D7DUAqtWU+jzTII7/s?=
 =?us-ascii?Q?DZITc+DQ8ODnrOpqav465k1Jq2XrQ04f/t4YC/EoGDKRZxQF+YOcSbt1Z24l?=
 =?us-ascii?Q?d71JoPbpl5cyBgxZ8HvoBgBjroBU40XCNcLJw6aNxzGT2swKOPZudnpDuKtS?=
 =?us-ascii?Q?1rDnGyHNOw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b8f911-992e-4e1f-06ca-08deb0299fad
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:23:15.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: feNQt+PyNRziBcF37s05Gbj40LT423R/R/zLM2hsKyKcX5ToDziAdNSbt9cVLHa/IwPAzLfNtPtGUhl2l6muXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7004
X-Rspamd-Queue-Id: 46E49521462
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
	TAGGED_FROM(0.00)[bounces-287167-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

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
Changes in v2:
- none
---
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 0acebb386486..b7b07ff8c60a 100644
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
@@ -2003,13 +2001,8 @@ int dpaa2_switch_port_vlans_add(struct net_device *netdev,
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
@@ -2129,7 +2122,7 @@ static int dpaa2_switch_port_del_vlan(struct ethsw_port_priv *port_priv, u16 vid
 	int i, err;
 
 	if (!port_priv->vlans[vid])
-		return -ENOENT;
+		return 0;
 
 	if (port_priv->vlans[vid] & ETHSW_VLAN_PVID) {
 		/* If we are deleting the PVID of a port, use VLAN 4095 instead
-- 
2.25.1


