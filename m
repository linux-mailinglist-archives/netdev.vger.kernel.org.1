Return-Path: <netdev+bounces-286700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOD7OA3xAWpfmgEAu9opvQ
	(envelope-from <netdev+bounces-286700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:09:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCBC510E12
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC48130E6F42
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9FB2BD5B4;
	Mon, 11 May 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FHaOLb4/"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE88288C96;
	Mon, 11 May 2026 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511646; cv=fail; b=InKB7dc2qD/Yanm819SG4dHWQOc+TOvD//l+CGgtu2xvnzEE7jzpvjeJ//80w+z47uEuDmhhLkn+k3XU4dMtDL6iAEenvMOBeRBe43IH9YKUeQorn+95JsZ8aExtyFda9yNXfTnCPFg3eP1etpitzDuVlWXl/ZsX8GWTGEZBojY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511646; c=relaxed/simple;
	bh=68kB0XG5WJ4FkpdJilPbLIQkPZQyGJqIb+S82atYpOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OHI3S2Qk/wdcd7BpBNun9f4hXxmzY/xGbXEEmkZuxQh/pJqfP/YpDsUbVh6Ti/PJh7Awlg7MlMJH9oMyGa5qN8TsM4tWJ5kKBqv3kFl7P4CD/vRE+SOwuzHer7u+thaUCOjgJUO01Ak70xZDktbTmpflYpxlJ2Ry4TiLEy0y9ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FHaOLb4/; arc=fail smtp.client-ip=52.101.72.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2q2/Jx5FGlXPTcd4a+eXlf8kMLDlwhKDwEzDWGSF4as+JUxwrWPKwS366VxDF4UCKM14cLRCiVbX8h8iI5qrIXDE9a5ikrl4X0ISGzzxLldeZJlSUeAuTfscT5bXbXOdcJ0BD8ZRtoFEoqPy0mn3jqok4Ck0PuTbMcJC6Kz2WMyYfGQtc8lyxIP5nVNNbk2zsj+Kq2QExkZlsQs32V72eyzCpqLlo4rKJsdqYclezdaZdOVOvJM+C/Ezuqp0NY2i1Jk75g09JqD2Nrli8K0cJBLT4vyQiu7+zz8Qqa+9CfIQeB5ERJhks6GUI5i6mtjtTLIC/XOIe0hAJODdNJkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uu6oODdrfFst0hEEG2qMTfs0my0ajnkCwg6+fmG211o=;
 b=Lru0D6XuYpob8cHmWXuDzUyZ8Vaen9I7dzQLgKDcWvuiMCLdevrJfy3egSUGjN80tkEjq+x5MPknB7y4SitZzV1K5IIthRTOtNOzIzTLpgVSAuSubeUb32hDVrZyZKES8+2sdhTTcRf7F7cO5oogQaDApQ9aUL6HkJXp9DENzIFCDGOyIAAGsgSkFYCUY7VQCFPPLvHwwTCxPX1vxJjlEwzXB/JEL3wHf7O+nheeuN0uBP34gCKcjd6Uw8PeCqjp9fcQc23EQIgICCzL0jgxYWv4z+MM3oLKY5kcm5jEqoSvNIHDrD+C1NLPGrxP/WVZd1tLwnfnpKpI2lvMFn7ehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu6oODdrfFst0hEEG2qMTfs0my0ajnkCwg6+fmG211o=;
 b=FHaOLb4/JnYoocsRgLrmxntqYFhLVkSbZ7ai/k7e2sULBpDIq9FDrdy+VfYXNrCmyhcLMw2NIflNNVcbnxfwZpw9XF9eILouBizQ/MOzZdPI0FkhvdI/R3I8vAVqCNmfA5qzRNvEj3oaT7JPEgfEKAgZY4gMmXhqrb7RXZwDlEyO2NacUEs0P/1tdacFhRPqSjNsSeOHMbn6l7j1wvuwVGPRkRPo11SBotWDfjlkE6xRK4cw/4OwOHJPUbpQxB2nTJ9826HbtnPWBGTw2c5BBp2XwGZWhEUMB0PUQrgcViApAISSzWzatfkWNUGrBGs/ozIB1QJZCm/2LwMGfKmPZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 15:00:39 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Mon, 11 May 2026
 15:00:37 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH phy-next 1/5] dt-bindings: phy: lynx-28g: add compatible strings per SerDes and instantiation
Date: Mon, 11 May 2026 18:00:19 +0300
Message-Id: <20260511150023.1903577-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB9976:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c94bac-fa61-46e3-5a33-08deaf6e0f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|366016|3023799003|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5cLh44CwhKBEfnJHQfVPZ22LLSo80B0jZRaL7kbOk6ol8DOCRc8oxfudkLMBwAcpTP7Hl+FZlIyub1KRMGB7qG3w5XN6m0TmYGktEqv0Q67F76afYrSYcfAIwz/6uJBHTP1Jt2h+Fj2ouSAqpu71GhGiz42tlC8JQELXkssYnuejrpcZCR06Bqz2J54m+80vFce6og/JnFzZgM/ouJSLb/O4TQHgYsCStubqcTaNSO7mypvKGLfh+f8NwXgKZIo4CjI76wyd8CdqjMUizeccq6yUebZnppYehjlF86scPcxXu969Aj1WQ9il8gUC/xhzx3D3cCuD76hSHp2H+ni5GBEd+oc+Z2a2GdutGpD0rF9ihlsj4NcYrwJRjUyDik5fkMFen5t1Jbr8q9b0pJaqI6okdyfoSM1S4vzDH+vCBlPTh8s/C3szhBTqX79wb/6QmvUeIu/TX5BpkdQS7f36NTH1+/0Suz5PCZtAA10EyFSrPK78+ZJ7zYw1DZb4mnThk7KrAI4X5Kz3noFs+HOMmwrUCVD3YnY9+LcJKuLv/K5P+QcSp6hqxK76qnnN2URYI/afl5JdJ4QTnYWZvcg5GwNdejJHHohyMlS/Lo5OSKOgqouRTUb98J7GTN+npjj085oLMqq1AwC2Wv2CZqzAjM6kvn6iOR5EIjLHADQsyNlYynCaOrK0E1yqgMFpDEIQCMxQjpSvZTyHy20GhQeGRA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(3023799003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Aq2fdcayBNMId0xm0tIBaAjJEO8RQW0DIZ5I+EgvTa+WP74KwVYONEizAfa?=
 =?us-ascii?Q?pOvdNmLZFFwiO4t8cWqUX4W9f58T9KAWis0+ZxJdbS2RvsKBq1tJux95OsBA?=
 =?us-ascii?Q?8BqW/d9zet8f4UUrVS/pCcQ6otyoX7xCtke9JK0PVDK5pgVbDhU4LTD3S9a1?=
 =?us-ascii?Q?W9dmjSDjCKenjYIrmorgH6Ole1moDkri+uZd8BK8d5rMgYtSlDMzp8MWWhCd?=
 =?us-ascii?Q?YqkIFd5gSj1kNAc4X8aW748K8/irh7jsCYqtGE0/Jy34PEo2slJE9JcfYnLp?=
 =?us-ascii?Q?2NpCWRPJ6RKapLs9xRj7I3HoUGgZJILKnM5PKFGrCnjx4lVrtt6Hxm5Dzh3t?=
 =?us-ascii?Q?pAv1adZy576oIrBynBbxkEVUK62cbE7h1hfbbRM7JU2JvDo8o1+ivaFfD7yC?=
 =?us-ascii?Q?y7TW3xQQ46t31SQmxb6W28LimCN6UDoROIfpqnjqvm/HBtUcbtQgMK0+mSg/?=
 =?us-ascii?Q?KPLBUM2dpPcYlzSVdxaM1etczy4UlQsoON1pAtcW7UOuGDE+xpsrSFdaJh3C?=
 =?us-ascii?Q?/TYa3hv4TP8diahedoivuvxxtFZ0uLKGm43EEXH9guhsi7m3Dmc9robRHeGk?=
 =?us-ascii?Q?ey6NNU9+wZ6/AaJQBMMQYwb1AJ+2o/Ug1/fA7SYjG36W5zBEytMWysOXiNuW?=
 =?us-ascii?Q?av5QviFUtjckHJapebGArRENfJ49TuDysLf3m25n4Wjptjw4o9fEYVAG2NuT?=
 =?us-ascii?Q?pEfQW9ZG6ir3R6GVUMsEnuU7DRm7/xmBnjyrnWg3GEFg4coDEce8WNlUUr56?=
 =?us-ascii?Q?C4RhGGX6szxphkG3Nk0Ne8tTs6HBnwhihH6/gF3CQIWkBetkQvxSnCEzGLsx?=
 =?us-ascii?Q?/BMxcxXNvJvuJSIk6Pwp7xvRyt1d2LtLob7zYukzgBCvD0xkx7nhwbcjo6Ie?=
 =?us-ascii?Q?vS6yIzmzTUbS3plK+yC7lxHxWOVGlLkLg4Nz5/dTdJzzEPwjCH/oHnd7/x4J?=
 =?us-ascii?Q?A+Qyf0nymdkv7k6PNO2Jr80Cmp/RXiWTPpdV54ULvP+n1JsDECEsF2Wt6jLc?=
 =?us-ascii?Q?TekRLBuQ/ftn8dRPRtY37aEMxFY6ghqtINKbadETH4ceytFRj3gY+18BtG92?=
 =?us-ascii?Q?tC7/7+jv9gbE89mfi6hzpwhsSslXm7+0n67O/YlsNNyswvsE/PcrUvany7u8?=
 =?us-ascii?Q?/uYDNm7Gs7ssHwAcWGY9oOmLjqsA+QpSiewcdn/vbMIZ7ptNrgPzQH+iFl6h?=
 =?us-ascii?Q?CFC8oMj/6vY4ui99HXOV+9G3F3ToZsfcvJNQmi31jH7axqxRHzgzgKSWYg5i?=
 =?us-ascii?Q?Z2K6tM8UrnNKwJkDaRrt+vjZg+59KjGCBqbqzJSI0hQgUWKrhJFRiUmy/06F?=
 =?us-ascii?Q?fK8mqnU8Jjzol5ftg/vjXO0+TgvyqR1WSQlmflLtlasGkW9y1XOtGfXNYogx?=
 =?us-ascii?Q?BgpV/SpS+19YOC9N6U7iiHzzl0vmu6RN1wh3heMc5vXPcGQn2em0IcFwnDCn?=
 =?us-ascii?Q?j+ZWLXoWEwIdzvJONSHfholFHcBSAQ2E7hBS7MzGcDqFd5tAn1uPzoC80WuH?=
 =?us-ascii?Q?8ZXIMK/7GhjuAPgGlQMpVKZ0szqmD3y/DCA87DfIzspi+Luv59jThrOYasSD?=
 =?us-ascii?Q?jEfD1LzkeDwFSdktrCnTrQ2ywCx/S8IL1ymT4ptvdyHKs7lnV1Q1HZ+HPOtM?=
 =?us-ascii?Q?aF/Xa1gp0L55tX2rzS1Rd3JxSTsZlrPl3/CcRmeGyehbI6YgGugdZNVRkQKx?=
 =?us-ascii?Q?ErlkJKMzlYwDVY2X8yo1LJ1yq4YCAW77XQFcUWjzJxYcR8Dx/3VglzQtyeu/?=
 =?us-ascii?Q?ube2p9Vk7A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c94bac-fa61-46e3-5a33-08deaf6e0f2e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 15:00:37.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWgi0nzur4YieaiiAeqvhCsXw2dyY43qpWyxOaaGUBjlJizc10lQIn/lxCp2U2mDPfnZDICYlSl5hdz+ZRU9yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976
X-Rspamd-Queue-Id: 5BCBC510E12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286700-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

The 28G Lynx SerDes is instantiated 3 times in the NXP LX2160A SoC and
twice in the NXP LX2162A. All these instances share the same register
map, but the number of lanes and the protocols supported by each lane
differs in a way that isn't detectable by the programming model.

For example, not all lanes of all SerDes block instantiations support
25GbE.

So, using a generic "fsl,lynx-28g" compatible string and expecting all
SerDes instantiations to use it was a mistake that needs to be fixed.

The option chosen is to encode the SoC and the SerDes instance in the
compatible string, with everything else being the responsibility of the
driver to derive.

An alternative considered but dismissed was to add sufficient device
tree properties to describe the per-lane differences (implying:
supported protocols), as well as the different lane count.

Any decision made for the 28G Lynx should be consistent with the
decisions taken for the yet-to-be-introduced 10G Lynx SerDes (older
generation for older SoCs), because of how similar they are.

I've seen the alternative at play in this unmerged patch set for the 10G
Lynx here, and I didn't like it:
https://lore.kernel.org/linux-phy/20230413160607.4128315-3-sean.anderson@seco.com/

This is because there, we have a higher degree of variability in the
PCCR register values that need to be written per protocol. This makes
that approach more drawn-out and more prone to errors, compared to the
compatible strings which are more succinct and obviously correct.

NXP SoC reference manuals clearly document the SerDes instantiations as
not identical, and refers to them as such (SerDes 1, 2, etc).

The per-SoC compatible string is prepended to the "fsl,lynx-28g" generic
compatible, which is left there for compatibility with old kernels. An
exception would be LX2160A SerDes #3, which at the time of writing is
not described in fsl-lx2160a.dtsi. As "fsl,lx2160a-serdes3" implies it
is a 28G Lynx SerDes, it makes "fsl,lynx-28g" redundant so we don't
accept it.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org

Previously submitted here:
https://lore.kernel.org/linux-phy/20260114152111.625350-3-vladimir.oltean@nxp.com/

Changes:
- Update commit message to remove leftover information stating that we
  use the per-SoC compatible strings to impose constraints
- Add review tag from Rob Herring
---
 .../devicetree/bindings/phy/fsl,lynx-28g.yaml | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
index e96229c2f8fb..8375bca810cc 100644
--- a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
@@ -9,10 +9,37 @@ title: Freescale Lynx 28G SerDes PHY
 maintainers:
   - Ioana Ciornei <ioana.ciornei@nxp.com>
 
+description:
+  The Lynx 28G is a multi-lane, multi-protocol SerDes (PCIe, SATA, Ethernet)
+  present in multiple instances on NXP LX2160A and LX2162A SoCs. All instances
+  share a common register map and programming model, however they differ in
+  supported protocols per lane in a way that is not detectable by said
+  programming model without prior knowledge. The distinction is made through
+  the compatible string.
+
 properties:
   compatible:
-    enum:
-      - fsl,lynx-28g
+    oneOf:
+      - const: fsl,lynx-28g
+        deprecated: true
+        description:
+          Legacy compatibility string for Lynx 28G SerDes. Any assumption
+          regarding whether a certain lane supports a certain protocol may
+          be incorrect. Deprecated except when used as a fallback. Use
+          device-specific strings instead.
+      - items:
+          - const: fsl,lx2160a-serdes1
+          - const: fsl,lynx-28g
+      - items:
+          - const: fsl,lx2160a-serdes2
+          - const: fsl,lynx-28g
+      - items:
+          - const: fsl,lx2162a-serdes1
+          - const: fsl,lynx-28g
+      - items:
+          - const: fsl,lx2162a-serdes2
+          - const: fsl,lynx-28g
+      - const: fsl,lx2160a-serdes3
 
   reg:
     maxItems: 1
@@ -60,7 +87,7 @@ examples:
       #size-cells = <2>;
 
       serdes@1ea0000 {
-        compatible = "fsl,lynx-28g";
+        compatible = "fsl,lx2160a-serdes1", "fsl,lynx-28g";
         reg = <0x0 0x1ea0000 0x0 0x1e30>;
         #address-cells = <1>;
         #size-cells = <0>;
-- 
2.34.1


