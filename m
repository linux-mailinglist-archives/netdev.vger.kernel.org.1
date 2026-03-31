Return-Path: <netdev+bounces-273579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IR1HWWxy2kpKAYAu9opvQ
	(envelope-from <netdev+bounces-273579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:35:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A1F368DC2
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 851BC309B707
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFEA3D6CC7;
	Tue, 31 Mar 2026 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JHYA3vab"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCEA3D6CD1;
	Tue, 31 Mar 2026 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956523; cv=fail; b=cgUmkJOwJ5ra/r7ZTLv36d6YJ9FPj/D/cTWI3HsKF7DFMKeJrhhj5i21qqbz88pPhuEgCX9PVFy8dBHJv4pWj7DlJGlIgN5oIG1/dJed2W4eNafk+uNaN08YzGuqzycZ6GmCXSiCNpCb37trsltZjCBt8OH00hXgMYJ+NLVO6Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956523; c=relaxed/simple;
	bh=7HSB2dE6vpsK0/UwCaQG69LI3UUEHuXUT6qrDbuRL0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CjR4/zROXgWJGPtoz7M+hyzCsjYIaCwBAQocZnOEQfMcm1tectDTcVULLM9olns7GYaz8gi2mHcUyElBxfhvVln6UrAEsd8m2iTJnxqwQPp6m6/Q46KzMjZA+JYagZQ6vJdE7xdL8IFgdi5aag3/NKrx19raOqywXQdhlwWsSfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JHYA3vab; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsrG2kP5T5VXbMU31C43ZFknccYNXSwXEcVOJtjz6J1EQ/1G/5UMsjEWXFSlUL77gKzhd6cNiWMqe/Av+xV9ffS/FvZId2ZeNvUTByAFMjCLeROSj4O46T7qCrEwXn1pUw2pGR+FZH51ovTNk6BuXDBanSCj2VDWaT453Yw8EFJRDB/E+uYO2wdlZhxJrh61ii8EHaGqLA0naqve6eqCkhUa5kGse8scjpqNEzAURZzJqTZqNfdW11kHKM9B3504Riw/W/t+W0M+UtNZ3k5dGTpnXpzNauPH53xjeJe1jhR8vnJYrHydp7Vf0jU+OeV/ipk3Wgfn4vxOuBozPU3raQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/XZWFlsxzM+0lZxykfSK1STJKtwotZ7hmQM6Y2ONMU=;
 b=boAQp2gw9/Q6qWslXKfT2ek3f9t6VjB8x8CgWK7CB7wM5uvk2u0jzb3iVtvYbHyGToS2/wODDTD2jPvFil/Gj6z88GcGjUMmc6SFfveu08hzZNBaw6xJbHYjVJGBCTEekD/yjA9pe7lRpdT6wx5AhQGn6ez6s9yMwjFo5eWEVMWARCyPt/jgQBxZCpirvWOsVgepPl7j1zKJjIKbjKqyP2n5PC2OHPQUFucBl/G+LYnRvBZ6cKw1L5w34oQrbZo4NIKR/7TLEyhbdea0ZHfGvp/rlbzjg+/2v/iDGIuBsx6zSZi9tOcy8FDloDRHjfji7deJR+WGgWv0TihvGTAcpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/XZWFlsxzM+0lZxykfSK1STJKtwotZ7hmQM6Y2ONMU=;
 b=JHYA3vabjBC8kjFY8CrFlglWuMEoHzkVHAL7Ulpe4WT6SE2+oeblYu3GFnbUZtyFpVIk4f8fJX87gSlvWtsA9rYnOWGNxrO1tfTeV1HfFYR3M018OM8C3Kr6xhRr5r413zWZ9Z6MCTwlixE16mrQ8q0NylxPNUzdw88iXacIeMR8sDDlIqBFQ5Fklagldb7PakCupJTo1GmyeuUFvAzU/G4CMDPJNFfrcJAUVOXpK5BA83OPeaeWCAuwSMVpFXSh3H1AG9a0w8tP7rRE9PwckT0xPr+lYWxMS1emct5DYt1AVztWqHCg/leveF48End6tL29/VNUsagLnn4i8RdBKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:28:37 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:28:37 +0000
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
Subject: [PATCH v4 net-next 01/14] dt-bindings: net: dsa: update the description of 'dsa,member' property
Date: Tue, 31 Mar 2026 19:30:12 +0800
Message-Id: <20260331113025.1566878-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331113025.1566878-1-wei.fang@nxp.com>
References: <20260331113025.1566878-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0151.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::14) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: 699348f9-d19b-4067-0de8-08de8f18a474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|7416014|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	ic1szvQjiPROdUF1mzRcK3hDJ9uIa9V2y7z4E/0OBzpCoKxnPL7auQsnvZjwhm4ENJOXRIQ1HtVgnq0zNb5qWIx/cs+59+av0oZxbZJAAtQ+qF32C2rUNEaY3e47Ky2MdCCeRziZ+eXEYu0zYPk6tvPmYVbZDyuRWP6HuHQ6S26XQ/1/JU4SQY5z319CDumFceRuXFlQtZf/eXIxUkkffr3aNkocY+J3YBn0UKb4n6L7kaW/eFGRpL8nhW4Wp0V5A+GIMK/vhYr6DsEfFvJn//vrSssLHEdGQLy+06zJyzbeP2ion1oaQxQEQ0d2zxuy4RyNkM9xntrbyh9fgN83dJGY1LyZPQ3A1sVywwiz7f6Aznd4HfYsNUFxVc4u1ufuojk4zfFZNeiBbcOodT++0eEAS3dcbqVu0sXMdK0m39VM5l3upJkNUb7m5G1DZW+QlDu9SyKAGZ2lOPY8Vhluq+QBVsuhZY41iXEV8sZEtWVG9mjMDsY3pDglIjLsFu3UZAtMzM6fYlYzV+3dVRmKunhy6zFrRA3bpmYAf+DqaSqj/uXImLsT6AKEgSRKllOe7X4cd8QvubtvxaxjOtLc4MoyTGfU4Bmyb5yY7rZMrAqxxxTpGJUheri4afJTVLkwgFNsWw/016EwBTzyovLzMQP0+QpjFBxoUNaiSC/mGRVPZKd/1wsb9+sdh2ZUe3VMB0rpDfefyG3AGOd65eCchNukatPZ0TAw4/YVU/MZDr9nbTanE/+7deNj5YlZLIaBoCswX/Y89SGEmLSr7aRFPnngzjhURFzteoNPbU5d6RBedtqH6c/RYPhLOgBXMOUn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EkaFy9cFsnxnLcIGuBI1hx6ZbCFDVt30eevP9CfosK8OK96fyxfbBQJN30a9?=
 =?us-ascii?Q?0RtGya+EmLU1byj/El2Sbsb3QJNL4JQGpJw/0MxYtu8qeJyVtbFig9UrIYWC?=
 =?us-ascii?Q?FUfvZcpciCr1LsL9YQgNgpXPgAjY3LYgoY7xm6381ewROsHaBxoij4Nhx6Xa?=
 =?us-ascii?Q?CDx3D4z97DkR+QntocG2HWN79u20es0W3vRw/7P/pKgcwdE38W+vlI3Cd5eO?=
 =?us-ascii?Q?1QeYUmX4Zmy30d3Z1YyzxqqMcY5EzCsTlL6QbOsqUFd2v78TsW7dBFNprExF?=
 =?us-ascii?Q?Fkz9LiiypssjcebE48BN1A2RqS612apqm7QTB4JFnWVJ5oateD1W7FVaVpmi?=
 =?us-ascii?Q?LzC8v3eDKefMOpGvo5k3Hy/T+49GtyBoImsRurtcT/bel+QaEXh+qUwIBvbd?=
 =?us-ascii?Q?5BkNmqzx1Q2xYbsWdnmygGfEGp1wZ0d68w5pk3D+wzup4e7y4GUKLBJnTT1J?=
 =?us-ascii?Q?6UQ1jYjukLDXZ/2fPRBTjja6939/6t5+3wU+l6SowidqNpH2Tuox5l8lv2lA?=
 =?us-ascii?Q?R+nZClVPNOAs0RmHMrUD3Z9rvgxEeIb07ezK3X3OqQ3E6SozP1/K7/P6wpeD?=
 =?us-ascii?Q?r3Czg3DoMMYxphh/Pp+QgsKh4/DyKuy0mUkBkT5WEBWgnSG/AJbFyCx9rWd/?=
 =?us-ascii?Q?iv3l32sayPJNl3gEYGsneNQa/ghibW5JvIFSKPIdwdEGwwe0PZ22zg9x8oTV?=
 =?us-ascii?Q?fk+9a8ppykQditViQNxOeiu4hGFfOhdBS5Ivtm2gN3zczdUJwuQ8RSA2rIOr?=
 =?us-ascii?Q?a3fH/wk75mG/zW2RT/15FkZMvN780aZUsgDMGcqntGxELo8pL/fQ/ELjTQBb?=
 =?us-ascii?Q?BcG94lPSFNSVBT/z+7Hv4Mg6ws5wTQ8aygZyxRTRlF0vG8ck3G4htsPQLSi9?=
 =?us-ascii?Q?Y9x1Kz73nOFhKX4aPm5w1A9p9GvBC62CxvrsLzQrSmTJTxsdrOfakP3fiakV?=
 =?us-ascii?Q?DaInOgJD9GE3hEnW1dPvFfiit4DZjZBksyLixn/lR0QR1Zywlw/OaZjoLusF?=
 =?us-ascii?Q?qui9AjzaQmlrHO1U/wSTuJKU0yxG4fuvUAl8k5RIRdlpUSlwLdmUe4dx48Ey?=
 =?us-ascii?Q?K0zAN9jemd6f8eYA7SQ/xlQy2QaJ/ThJYqyu4O6FWbnnglKY0CRv9Z1+PLCx?=
 =?us-ascii?Q?HF9dSPgrz05se/1sLuQPo+M893v2O3WI0VYcUiq5wiEk2HPwblASd3n5JBwN?=
 =?us-ascii?Q?Ci+zzaBi7JQMi06CKwW0ZzxMd/eHqZA0qrLN17VToWs5aPNSEJdta93y2Xac?=
 =?us-ascii?Q?quuE10z9OFY5VGJF+1n6yuDfj54JrXWdlHRdXv9+XUEEmMXIjPDZkERboXxs?=
 =?us-ascii?Q?zXdRRujYvfPgXz6suBqzWBzghouFnicVluLgD75ioZr9TwArow6y1dHH1HHq?=
 =?us-ascii?Q?3+TtWERDBIG+EPBSKi491vWwubCCxPrco6UcKf+Eloujsd0qeHlea4hPkXJ8?=
 =?us-ascii?Q?hKGRFW45BitSvvOuCUWoW7PF3Zeldxv2Wj3XQqZNfFNRGgSGY04Y2Wl1em5o?=
 =?us-ascii?Q?3OzBO+DvmcbE5kuXAZK12wxURL60ifGlVtVP7CiTFZlXqh3F0EJ96SWs9M8Y?=
 =?us-ascii?Q?nMy9f11s65EqQQkiy/dGsMgcTV6uO6ZoXFBjoIGrL1LT5qU/IrVaDAGypOvL?=
 =?us-ascii?Q?+gaJB2Mh/Db1J9ltyXv+TIpR6RJ/h7V3pZu7NbojlAQPFMsT32wLis6JrjMl?=
 =?us-ascii?Q?1ujNXT8t9M3al5lDuY0pZ+DRjWOmxfnZhaCIiZE9dHUjdHt9K8xyMlE6Ofac?=
 =?us-ascii?Q?tvqK1R9xaw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699348f9-d19b-4067-0de8-08de8f18a474
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:28:37.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yt1Ep+oo/lW8DTeYOGJvAg6kQKp5iik2hrh8CI6BiAt2+/L17Mxkrjtvk0CP9gph7CnM2gmZC8Dwhvb2Hv4w4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273579-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: D1A1F368DC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current description indicates that the 'dsa,member' property cannot
be set for a switch that is not part of any cluster. Vladimir thinks
that this is a case where the actual technical limitation was poorly
transposed into words when this restriction was first documented, in
commit 8c5ad1d6179d ("net: dsa: Document new binding").

The true technical limitation is that many DSA tagging protocols are
topology-unaware, and always call dsa_conduit_find_user() with a
switch_id of 0. Specifying a custom "dsa,member" property with a
non-zero switch_id would break them.

Therefore, for topology-aware switches, it is fine to specify this
property for them, even if they are not part of any cluster. Our NETC
switch is a good example which is topology-aware, the switch_id is
carried in the switch tag, but the switch_id 0 is reserved for VEPA
switch and cannot be used, so we need to use this property to assign
a non-zero switch_id for it.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index 2abd036578d1..801e1411e5c2 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -28,7 +28,11 @@ properties:
       A two element list indicates which DSA cluster, and position within the
       cluster a switch takes. <0 0> is cluster 0, switch 0. <0 1> is cluster 0,
       switch 1. <1 0> is cluster 1, switch 0. A switch not part of any cluster
-      (single device hanging off a CPU port) must not specify this property
+      (single device hanging off a CPU port) does not usually need to specify
+      this property, and then it becomes cluster 0, switch 0. For a topology
+      aware switch, its switch index can be specified through this property,
+      even if it is not part of any cluster. Also, topology-unaware switches
+      must always be defined as index 0 of their cluster.
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
 additionalProperties: true
-- 
2.34.1


