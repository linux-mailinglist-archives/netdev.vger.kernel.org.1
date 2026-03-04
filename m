Return-Path: <netdev+bounces-264063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPkaLwawqGmfwQAAu9opvQ
	(envelope-from <netdev+bounces-264063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:19:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C46BD2086F1
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3601B3049387
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 22:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF660372EC3;
	Wed,  4 Mar 2026 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bLAoFATH"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3829994B
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662163; cv=fail; b=dp/n7jWpQARV5/OoO6POD97G2SklRmTVjN74ZorKQftKt9hZDEVn8JzoX4KmO/wQYQxcAZgV9pMbD0aunmrFl/4uTk/LnEL+Vqr2mitMu5KEIIXM874zCFBxnNtJYZLfMRXekvzDXrncoBv3uJJHTctBPpE5JlDYH4Aes3KVUYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662163; c=relaxed/simple;
	bh=9BxCelZRRy612owwTyL5ZjU2AQHsSpgTrsqiczAMd8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WhuIfX8Pq/bZD70rrQKYAdN8t86dTTUn6Xz2hxtIsmfcQ2QLCUer9sHWbiTYf/PVqYwoHAHHfcBWnbFKuoGDKD4eC0SfXlantcalgCk/41e5fg/dVxNzVMva/DVkNhRd1amDN22K9sWMSGNjl2ndqUFLiStWfoUVVnGObj1ma0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bLAoFATH; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls31DRH70YgpyqIXaTIQq8+yKchocBGyE/MaE4P/aEWrVKvk6tl5GfOUtGj9ZSDbrOOE47hwceAjgCq+DRv07LbVB3Oo9oF514GL8OzVfjeCuntW8guTP45sMgdOG52toUrtDiHq3NRsNejt+9i3k439O8fjo/zGG64BgZP0kjIf0qk41A17qJl8euZP1cw/kGSPhGE5HW1TH9X0ubSyMMaOzSElnLcloNkB0jCLryEcIScJoBYfkt1iLpwsCcvUSUzLiozZ6+IcZxEARskB58wtD30YH8rd4kYyKM1KCJiwhIiWY6D8r8T0zOLVQMxenGqXbkmNzmplPlYG3/GHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWlHSNmx9k//BBuSphDZVixZXasgiRPFJU2XR6u2zv8=;
 b=G1vaIs8zMrjiInrV+RWvv+j3Ic2woOHmY6BsIb5aoYhAx0dDH9f3WBMkXSK76vSopXbYjlPfyD5xhyV9miKoLMphmyKXkaFqlUVB4fbi3ubOAiZ0vAuzBJ9A3e8q2yC7ywdAmuPqOgs2sT2wI0UL/BEMCIQt1rTDPy/MNLdl+6XV5BAy2wOeANMa6HJKPI18Kge9v6kUVx87HklVqjMcnXo8sU0QUD3MxOgZjhmyOi4Ve7Ask8GboW5im1HRrq9FgMFQ5Re2UaVt3/EIf1GqZxSa2gOzerKA2R3s7DqrKZl0FFKudavIDGW+2I9vX76BKyGMikan4cOS6q2ypLngvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWlHSNmx9k//BBuSphDZVixZXasgiRPFJU2XR6u2zv8=;
 b=bLAoFATHvfPgo3he0uDN/0rn6bVA0B7qgqUkCZanr82G1ijwdmipvDmuGdiTweylF/P7zUCJJpdUqVlYv5rhQ8Nz/dBq/oejW2a24vMSVl/6+86pfxoO3LMvBniFhIGrGtxLVy61o9WT/btT8IC/dxB97MA1oAFxyMe4c6kTSUakTetwmNqiSjuwLVMjQqWXef+h7P4JdYKDJs4WYdvbODNm31eghNQk8WkUl/H8iPT/biRYxe0MegH4qZEYIRKBpnWxFwgfuXD7Ok3TtjHfo7j1XozO2e+r8M9rzycrebPnXyMZJi1ohiqM3cl5x6fhe15ejRfZqaW5yB2giAUPBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI2PR04MB11097.eurprd04.prod.outlook.com (2603:10a6:800:293::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 22:09:12 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 22:09:12 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net 2/2] net: dsa: sja1105: ensure phylink_replay_link_end() will not be missed
Date: Thu,  5 Mar 2026 00:09:00 +0200
Message-ID: <20260304220900.3865120-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304220900.3865120-1-vladimir.oltean@nxp.com>
References: <20260304220900.3865120-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::40) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI2PR04MB11097:EE_
X-MS-Office365-Filtering-Correlation-Id: 30bb5edf-c146-4928-8adb-08de7a3aaab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|10070799003|19092799006;
X-Microsoft-Antispam-Message-Info:
	IOMwKv3vRfv0gjmOy67DiKWd5SS2+X03Pbl0HpKAQUV81QbMtczifzNYdNQ2VDSRvqLaQOBIZ1NaPBPf7QsRlXp+3EqLfVxFkxaqQcV6dIAK5YCCPJhJ/4zFdpWYRqEkShTvXrkvq5OSIyTNo4AkBBJRUAI2dRDa/0SpKc+cjhl7k6Rzha/I9nnrq3OMaHxiybGBecXEQBFWjNRb56XODnq7Wm+HFwazr14BjNtrPBKaJRRBZUqGtS5iJTQR811HN12Yomj5x51oJagUZEHIHB/Q1J4pzh+UcSEa8UDiKxe6whk+fG+b575nTWrXvDD5843l2r3AEU/Sxm69PQl8cTrIOGxNXG9q8GQCkU28PsgpWnx0FopUCHOcT3/I2QRdnO0noHte+lBi6ts4TzS7jZGxleoXBV/xsgoM++5o/E1VJGK1URZK4xYyQkxB57jsealMsCIspdttixXz3JPi5OY/IpXBm4g9zMIjDI+dDNR5UEgaZoElgS7zhcF1+faEeKo/MiARWwsEsuUx2yIBdEPRLDwIyeEf6efwKzWMtKYTLxHP4wqxkSaDCWWleIOULG+C15F5F8IWAFHIpPfo3i3tMhWfXc08nJkLBtn6OhoYbvyxM7+CswyIfQr+TWD2npuH1C50LGKRfuwTplwlzoY6F/EIzrm1MIC9uBr9Al9upp29xm93Uw5i/ha1AZINteeTfA+OkUv0C0a3Fn9/LMsG9zD/K4QXFB3Gh52fJIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(10070799003)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+QHbtHGBcOsHKDQnHZCRa9U1CFOewP2bbcrOdUfAlQWGK34oh93qtUHHv604?=
 =?us-ascii?Q?kwE+qJyu5C3FNeEDqM1vxotqbFRb2HTsM+Ncds+x39DTaFCLuEJf0y/H2s8m?=
 =?us-ascii?Q?oeDaLPQJYrc7p9YUofuXVJre72QQC2VtTMh69VKTmBiY1jXUJu4vr2QhH1AO?=
 =?us-ascii?Q?VlPUiJ0S16NyzzoRu8RLSfpaEbdFNrxse3rdYUjQAa063qBtN8dpcDmf22d/?=
 =?us-ascii?Q?s7HtL5yNUtyZlzH9QqxI+0XPvP6tMnNphOpucdYzWm7gY7nOtZP/v2xh0ikw?=
 =?us-ascii?Q?hA9iUxmQIjNxYBh8kS2Q4KrHlcjosFBguGAGyEvXo/oT7yUtnTq1qKxsQvNF?=
 =?us-ascii?Q?HHvJET01QWoBVlqQxlIoGEGn/aJGMXc1Seppu0zNkrt/JPyVafv7xrCRZisK?=
 =?us-ascii?Q?hQ9I9VBaRsSOGdPguKDS4wtyNa015I6lQDHuIWfPPW+6Vb80PX+EllXcjLck?=
 =?us-ascii?Q?38Ro0DX8r+3l5JrRz2nCcWqUczr71YiYl0lWXcLGSxmj9qZJ63nVEAGjupf0?=
 =?us-ascii?Q?2b+0bmXaoBbikaKaCnep6KN9cp+naMcCagE5msZaqSDxr5UBm31piGMAKxX+?=
 =?us-ascii?Q?dAnWXAs4vi1UFUhmFpqaAKDP2UI0zqi5cyDANF6paLjlpv5t+fD1bv8YdW8V?=
 =?us-ascii?Q?Vz0AD466BIKmafkpOcH87e0Vb/6ajOvA9LgpdC8J715Jx4ldvW5ClJuqnPIv?=
 =?us-ascii?Q?+x2vk233syMbcv9aNP0fZBxqGbdPTyRUa4WThEMAuvGIy3QGF9WvJoKf8mJM?=
 =?us-ascii?Q?XuFCecJEe7/XKXndEbTemnqEmsGtSbIvwhcrsnoF4AkZWa0IRXvd/Nuh51dy?=
 =?us-ascii?Q?TgrR9aqoaktXJy5LiUcPUkpKsZHeDdAWlIIfKzBTTLlb8KMUoUWKLHEcWpUL?=
 =?us-ascii?Q?z2odc0x8eMDSP1TtlDLamB9FzTttQq4e8npZFKSw7zQhwKOTv5EihtfGcmpQ?=
 =?us-ascii?Q?0Fl7g8YQzTXkroKiuRQ4M28P3cjaOhs2q6NRDwQTCK6hbF35axQhZ/kcy6B1?=
 =?us-ascii?Q?irqRyaJTtwYQJAzKi2Z3IEeVeH/lyHptS01NgixGK1fIENvyKGSjId3qut9q?=
 =?us-ascii?Q?5RL9Ie5Xde2jk1pkMnyEUE6k4Ujc2xC8NK1QeybEXl62LVC4tL1C/cSPXtot?=
 =?us-ascii?Q?4BiuTCWDEwder+sqGkuEKDOrgnJU1iwVm5QSMaIgkGONsJDNlQ1VCtIlXO0f?=
 =?us-ascii?Q?UsSOse4q/wFI89+dHViOcdyGHXLmXA7stbVW35Hy7usVprP/9tfL5d5N3hE/?=
 =?us-ascii?Q?HMCX7vKmc4sC1jROe4fxdQoTT6k8buMZd+ALR9yOid+w7T3tkWJBIWBygYRd?=
 =?us-ascii?Q?bV8RvoCDqR64COlIK1FXO5wO8B68QYrvEFMBQBIHiml174O1aFQqV5xaWecj?=
 =?us-ascii?Q?qAqXTqh51MhjF48reonn1/vmugk3DlZoQeZMGq1GP45HLYacZnEJi2vJzxdQ?=
 =?us-ascii?Q?HSyKjWkuBXCNoKpbPhf7y1kGq4x9AF5fxstWZc8Ch4ZczpdK/lXnHlzli/+0?=
 =?us-ascii?Q?YaIOkFdAmj5KSZEukNumC8Z6aCwJn45dxpYIkh3jJk0pabWWzL3FXJBf0XhF?=
 =?us-ascii?Q?wGOVKN+jj421BCV1H4P1X0ElKsaWczYn2NOv9KnfyiHcG1sNhWXTgIAa2qIX?=
 =?us-ascii?Q?mgIr9huqBWsdlYKoSp+SzPjshEHdlMg1bNDsUk84wXiz2t32oInDgLb5R5Sd?=
 =?us-ascii?Q?ecoCpbtDnHjeDXIkgowk2GDfq2j1//sYZr/rRnQ+kjdRRTTb9RGMirMYed1y?=
 =?us-ascii?Q?qfnTE6TB2pAyh3soOa8ZhYAtG8B5fsLJbKS2lJDvVzaMkRGYYi2oHuycyfoU?=
X-MS-Exchange-AntiSpam-MessageData-1: tpO25oUEFeVr+HVpd0p9qP0mNE6QVeDHcl0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bb5edf-c146-4928-8adb-08de7a3aaab3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:09:12.5768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3xXpkNmQfr7g/uy6Yfz0I+MWSLeONn3bBB1N5JvniLawx1VCezYSrjWWf9f40TwyhutFI5n9OMkEM3+kei79Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11097
X-Rspamd-Queue-Id: C46BD2086F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264063-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

Most errors that can occur in sja1105_static_config_reload() are fatal
(example: fail to communicate with hardware), but not all are.

For example, sja1105_static_config_upload() -> kcalloc() may fail, and
if that happens, we have called phylink_replay_link_begin() but never
phylink_replay_link_end().

Under that circumstance, all port phylink instances are left in a state
where the resolver is stopped with the PHYLINK_DISABLE_REPLAY bit set.
We have effectively disabled link management with no way to recover from
this condition.

Avoid that situation by ensuring phylink_replay_link_begin() is always
paired with phylink_replay_link_end(), regardless of whether we faced
any errors during switch reset, configuration reload and general state
reload.

Fixes: 0b2edc531e0b ("net: dsa: sja1105: let phylink help with the replay of link callbacks")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index bf720d96bad8..c72c2bfdcffb 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2341,10 +2341,11 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 
 	rc = sja1105_reload_cbs(priv);
 
+out:
 	dsa_switch_for_each_available_port(dp, ds)
 		if (dp->pl)
 			phylink_replay_link_end(dp->pl);
-out:
+
 	mutex_unlock(&priv->mgmt_lock);
 	mutex_unlock(&priv->fdb_lock);
 
-- 
2.43.0


