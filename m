Return-Path: <netdev+bounces-294781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vpjZC4Y+IGqYzAAAu9opvQ
	(envelope-from <netdev+bounces-294781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:47:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AE4638C1E
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:47:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=dMrG86Qp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294781-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294781-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0979930A3B7A
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2326D3B388B;
	Wed,  3 Jun 2026 14:36:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82D3AA1B2;
	Wed,  3 Jun 2026 14:36:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497412; cv=fail; b=TTV3LHbSR+pRp+AyXwiv83Mba1bKlWG5mYXS+AtA73EgiLUYPRQfWvmKh0vkHc4NV7TzZMFLXXLzWCs+07xevuSlC7zcCJnCpg3TN7do4WpKFAMANnW4obfnDmScCF+h9/eEex8FGXgbz8eaZoKQWX0H6SGUS8AqnSuz0uwc97c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497412; c=relaxed/simple;
	bh=8lgi0NGHCag/iH9/wJWyPvhg6i1ozDJM+Bjbga4Qtl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c7z7bsVSwZ2MVCpXrQnOC7t2Jh0GaB1bOdc9b5LuRdII5BEPAEiscPp5e1f785zv/j1wkxh3fa1RVt7bD8hABy3hCkZcqkxgxfVp2kvKWmWFaP1mf6aGxjqbSds2KAxsFVgXNOgkLuS6SsgztJh/CJJdonlZnqTGQL1C9KyuXFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dMrG86Qp; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzePnSRGsNKLqaOlk9ZQdCyZQmEHu9x4G7Dskl4DiOSyTfeZKoBxJDzwtneHWYTr35+GlEmK89NMPF7AYsKpwTJC7m+8XzDgA+G89cv8RNKIavFUz19B3C8f/icaycFqEZuS8Ri+IV3COWQm+5w4w0Plr3ojGqdji7rAN8zQHBqQQnIKoQp5oelvZCYzT1rGFUcwcVKTs7ru6veSI2MOGbXqwaAd9au79/S2ChrCgUQubGcigIMd7xT1A4WqS4I0KiopO4m4V75fflj1DgAFx90OfUy9M9IiBv2I5aDiIMM4s8Qvo2h6kol2Z9GNiUzXyTTCrmuNjoZpfpUnsHu5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbDfglY7uwJF1fCPoNFukZMT4P64qz+5FYXw3Iw147o=;
 b=Z9vDoLo9pqTLNnKP2sjvhvfRU4PU1scXVAJNY81Aa0R1R8is3mVjLuxNBY8KmSBFtzhg7AARWvXBHWiRQBfIWCUqYMSknIW2KmobcJeM2g1TihUCuRP/29Pr2b5UKIUPY6eUY701xO8tSl2nx9H9YmWqwgHG08PpMJ/3asJPoLvcRfGg25DIbW7jd8Oa10ol91OQysneGi8YvbvHYOignPMmRaEbzesIMHpzlvajp/l/vuMocrgDqVubcDh3aZq5yVLwF4kpjmUGPcUJQiAsYoznQsj40nVx2zdBHuy2tCwXJvjJCrqESuFewEkgD12uIpAyFVJNBJXI743KKWFhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbDfglY7uwJF1fCPoNFukZMT4P64qz+5FYXw3Iw147o=;
 b=dMrG86QpJATlRtqQ1AXH+d0xfHJ4KJTWPvjftCe4PnnGq3ebPEIkgt/xYqNU40KfxuZI/f5WzBoL5+5CntkW8F8NBGMZajRgucOhIupG1Oztixq0BSdnIF92b3jTuAV8P6mXA/xV82UpZlz3+rrqoyLWPgGxrefodFmBKV7KCp5RIL+cv0hfjaWVi5IjoqGSZffCWoK5qFWaF1ZDvKj5fTl9NbhJaSr9joMmgX9HqRGegGS7aFfgGeGbAWY85RPSo7JeBGEvD0IAoxy9YPXLcxU5ChcQAPwBrRJZAG7YkvmkQpM0EHVVP+vHpAbs+/b12CVP8bDCClZop96zad/wyw==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10974.eurprd04.prod.outlook.com
 (2603:10a6:800:269::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 14:36:44 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:36:44 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 03/12] dpaa2-switch: change dpaa2_switch_port_set_fdb() function prototype
Date: Wed,  3 Jun 2026 17:36:14 +0300
Message-Id: <20260603143623.3712024-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::15) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10974:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe25990-7d2e-4b4d-4020-08dec17d8886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	HBL9vxVGQrDWA2sdtawfxSmli7IEDQBrxhgc42smpUdOsUvIv8s+bUlJxXA+oEfnyQSh4Vz2onDzu32+nPvTFXcQNOFTB+pDrDG0Tm/7jtXRGm1kwddJs/2qdfzsjWrGPWBDro5srIieKI1Vpvuv5YPxG06488INWxFNnTV7a75iXdYQDwwSYIAD1dH4twrDXYABVG3pTSddlJhUWDjTIm8RNV/6RgMYLYZwOL7P6QClt8komdbOAFwqR/452jJetkwpHvV/HQKCwJaWs4l4Mf9E9Ids7OtVPM75a2LgXCRAiTjY7SRgT5zOmVYigVl3dOIgHm+GBRciWD6yYS10chQIuZemq8Bw4GMaz34bnfcxn6iH0iU/SsyQ0YGmWunZRh6juPQh/RfunREzOYt1/bhs7WtqK3p1q0vOycSvZFw6CuEOFP4b2OLHrJcS9+V4a6tmtXJFL5tLc31CZjtuvhxsP5UTe/i9drLRGzAybTESJ1CgS1kTomtM6E3p24szjGVqgRg13NBlEcIsJYIV6NmUgYtiZiT8OeSAjpFhfwZjY+Y6SwaowNni+AZIDLDWjgVWg8dlOto5pV49N+OKSBVOnU8jhkdt9HsJ3XF18AAc/M19bk/lgTwFB/3G6BxeR31qclcFzC1CcItcsM3s2BzZ4Wa6E6aUuJv/8euMXQ4qZ+Dc/c+DvBJVIlE1BOTQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OvEuCYfhsQ+AE/Ep9H3+AlFkxjt0vuruVeTo4oDOllAca9EHIJrhafvy3R4e?=
 =?us-ascii?Q?SVKdQTYKsxehxNTciSU9C9luMzH1DxZnsKI7YHqECwJ11ltJmoP3SAqg/rTh?=
 =?us-ascii?Q?bl8jfm0kUp1r1jpkK+T8dKJvW3TrJyEP/Vud1FNgk6dP6gDrI64GgSDuZy6a?=
 =?us-ascii?Q?6MbH8nLJK5tKxAlr8wMhqpT1bS/bPJPRj83I4sNiP4MCeNFEH8tu3wEgPUYk?=
 =?us-ascii?Q?plFXbdAXzm9uANV6WP5kgwFleHQq/tjzjEExo/3qpASgNdzE9QuY8UVSAbuB?=
 =?us-ascii?Q?gxkxHFRsdP52VtijH5/531a8jTkELb5B0jBERxuT9QzjLBsn570d40LybRb1?=
 =?us-ascii?Q?Ay0ydpaLXl3GB5U1x1SSX9xNlfMMR4qAPCiyMhrk9pBDBHCxBJ+T0MLIB5lR?=
 =?us-ascii?Q?omrx/YqrOdb/CdY9rE0x7psO51MFI3VsLA/K0T/RlcH4gPX91E5+fq0Impdr?=
 =?us-ascii?Q?UNeHgU7c9atQ7aK1mituBrRL/pK0MFVR3yDWSAUTFwMZ+kmmiRm688I4T38D?=
 =?us-ascii?Q?d3C/EuPHZcAukBKqlFEdgcDcE+rUJU3CaokSnjAz/zrEvE5urTWAIo2yG+sg?=
 =?us-ascii?Q?SPqhrta0V1Qe0M0xttnR4xzBSEEcY8KKNP7qjiJcn5hHVHXEeBX3/WiJdqAp?=
 =?us-ascii?Q?H45SdTA37NitabY1q18yj8Ly4kJK0daI/0EoNoWUKtqpeQgDPn2xM/xS3LNa?=
 =?us-ascii?Q?/b8Lk2LmUykfom7sqfct6dKzul0NFo/zqr/gS4oHCxDlMPAXiQF6CoQ7Q8rW?=
 =?us-ascii?Q?1s+TIvX5PGm+mwg8W2PLScK6kBqpGT0fBLYoyjseosxVAD+z6TtoIG/4OoT2?=
 =?us-ascii?Q?/wc6Coe2fOGWS+oVk8H+EyHrRTdvVinJnUnJ1b1S5M94GiKCUdhM8EcvnCFo?=
 =?us-ascii?Q?734P3eTHYkxDYfOR0d3CaBhBwpi3b5YQhn2gG4yAI/ZOderUR8JYZeJyUBkb?=
 =?us-ascii?Q?/pzT/WrMTdXLd5g65A98Ttcns1yWMPTMpyJMLxh7ap5uonKhP4xJsw2WlHI8?=
 =?us-ascii?Q?WLh+Mtu1n6rpjzWnFCk6Ecv9lPWGUSP59/goGzzCC4UEe+/5mw2NTVLd9WAU?=
 =?us-ascii?Q?ocDJho03YUDrjfOtaJ1J2a9Wbm3hk1eNQtHP4SxVrW7T0IjgOlozU77Y4+RL?=
 =?us-ascii?Q?Hwep9WhncnvpDm83cv5dpRoXcViih38PCa8qyeq1kn6NoWEv2P2sVzCwrrqV?=
 =?us-ascii?Q?QWpO5l/69tzLytCD1BIl4CoIiRN9q7XBNEDezKrwGPBwk9IWxmINNe+1Biq1?=
 =?us-ascii?Q?HE8sXpupFbBxLYzlIwbp1u5YIrD1oAyuk0SbMu2OCNkIMAaRJkASy/3wgjOq?=
 =?us-ascii?Q?6vtm8wkSArn8+tHBUpPaiEohn1IfhD9+NpSfuZWEMVmwLPVtHn/9DOXhbuxD?=
 =?us-ascii?Q?Lzil0AfNZQqideXPFZwDpthkl1Gq+Co0SjHelnvfZ+axQ4KneBI4Mt+UYDqp?=
 =?us-ascii?Q?EhmtwvVI6Q1PvBtBE3NfuwPEPV0lXfoI1eNka1CYa2w1y1MwunnwtlmfmnKN?=
 =?us-ascii?Q?f2FBfgz+cXAkjKmxWtaVzBBEQIQhe/yIHmoiPuh75bXkLnpU+M7XChrEPjnB?=
 =?us-ascii?Q?e+z1nJcpVktSdGQHRMNhIy2qVyBPLZaf9AdWh3LScKzHuf9LLN5jswr+7oT+?=
 =?us-ascii?Q?Keayyn9N6C5AEhEpNDFn+va+Sfr6AAK2lT1fb+LzL2nYuM2QUr2Zbbn6Sxt8?=
 =?us-ascii?Q?IypLq89oX1cGJir/ekibwlYDeofOG0BeJGhAR+H72ugokG8uKcWTFK05PTRn?=
 =?us-ascii?Q?6YUCWBVoqQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe25990-7d2e-4b4d-4020-08dec17d8886
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:36:43.9969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJmXRYtzbY06KY9nEaD54oFC5wwEk0NO5mTIt+tirp7XgEYJqj/rTO21bjn50AhlOsKkKbSh7cA16+dLsOOfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10974
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294781-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1AE4638C1E

Since there dpaa2_switch_port_set_fdb() never fails and its return value
was never checked, change its prototype to return void.

Also, instead of determining if the DPAA2 port is joining or leaving an
upper based on the value of the 'bridge_dev' parameter, add the
'linking' parameter to explicitly specify the action. This will enable
us to pass the upper device that we are joining/leaving in all possible
cases. This will get used in the next patches to determine what kind of
device the upper is: a bridge or a bond.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- none

Changes in v2:
- none
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 33 +++++++++----------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index d082ecf9b125..8026a5014105 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -62,8 +62,9 @@ dpaa2_switch_lag_get_unused(struct ethsw_core *ethsw)
 	return NULL;
 }
 
-static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
-				     struct net_device *bridge_dev)
+static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
+				      struct net_device *upper_dev,
+				      bool linking)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct ethsw_port_priv *other_port_priv = NULL;
@@ -73,10 +74,8 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	struct list_head *iter;
 	int i;
 
-	/* If we leave a bridge (bridge_dev is NULL), find an unused
-	 * FDB and use that.
-	 */
-	if (!bridge_dev) {
+	/* If we leave a bridge, find an unused FDB and use that. */
+	if (!linking) {
 		/* First verify if this is the last port to leave this bridge */
 		for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
 			if (!ethsw->ports[i] || ethsw->ports[i] == port_priv)
@@ -90,7 +89,7 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 		/* If this is the last user of the FDB, just keep using it. */
 		if (last_fdb_user) {
 			port_priv->fdb->bridge_dev = NULL;
-			return 0;
+			return;
 		}
 
 		/* Since we are not the last port which leaves a bridge,
@@ -101,12 +100,12 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 		 */
 		fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
 		if (WARN_ON(!fdb))
-			return 0;
+			return;
 
 		port_priv->fdb = fdb;
 		port_priv->fdb->in_use = true;
 		port_priv->fdb->bridge_dev = NULL;
-		return 0;
+		return;
 	}
 
 	/* The below call to netdev_for_each_lower_dev() demands the RTNL lock
@@ -118,7 +117,7 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	/* If part of a bridge, use the FDB of the first dpaa2 switch interface
 	 * to be present in that bridge
 	 */
-	netdev_for_each_lower_dev(bridge_dev, other_dev, iter) {
+	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
 		if (!dpaa2_switch_port_dev_check(other_dev))
 			continue;
 
@@ -144,9 +143,7 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	}
 
 	/* Keep track of the new upper bridge device */
-	port_priv->fdb->bridge_dev = bridge_dev;
-
-	return 0;
+	port_priv->fdb->bridge_dev = upper_dev;
 }
 
 static void dpaa2_switch_fdb_get_flood_cfg(struct ethsw_core *ethsw, u16 fdb_id,
@@ -2062,7 +2059,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	if (err)
 		return err;
 
-	dpaa2_switch_port_set_fdb(port_priv, upper_dev);
+	dpaa2_switch_port_set_fdb(port_priv, upper_dev, true);
 
 	/* Inherit the initial bridge port learning state */
 	learn_ena = br_port_flag_is_set(netdev, BR_LEARNING);
@@ -2088,7 +2085,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 
 err_switchdev_offload:
 err_egress_flood:
-	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	dpaa2_switch_port_set_fdb(port_priv, upper_dev, false);
 	return err;
 }
 
@@ -2135,7 +2132,7 @@ static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
 	if (err)
 		netdev_err(netdev, "Unable to clear RX VLANs from old FDB table, err (%d)\n", err);
 
-	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	dpaa2_switch_port_set_fdb(port_priv, port_priv->fdb->bridge_dev, false);
 
 	/* Restore all RX VLANs into the new FDB table that we just joined */
 	err = vlan_for_each(netdev, dpaa2_switch_port_restore_rxvlan, netdev);
@@ -2432,7 +2429,7 @@ static int dpaa2_switch_port_bond_join(struct net_device *netdev,
 		return err;
 
 	/* Setup the egress flood policy (broadcast, unknown unicast) */
-	dpaa2_switch_port_set_fdb(port_priv, bond_dev);
+	dpaa2_switch_port_set_fdb(port_priv, bond_dev, true);
 	err = dpaa2_switch_fdb_set_egress_flood(ethsw, port_priv->fdb->fdb_id);
 	if (err)
 		goto err_egress_flood;
@@ -2529,7 +2526,7 @@ static int dpaa2_switch_port_bond_leave(struct net_device *netdev,
 		goto lag_cleanup;
 
 	/* Setup the FDB for this port which is now standalone */
-	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	dpaa2_switch_port_set_fdb(port_priv, bond_dev, false);
 
 	/* Setup the egress flood policy (broadcast, unknown unicast).
 	 * When the port is not under a bond, only the CTRL interface is part
-- 
2.25.1


