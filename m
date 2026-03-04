Return-Path: <netdev+bounces-264062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFX4BhWwqGmfwQAAu9opvQ
	(envelope-from <netdev+bounces-264062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:20:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6B92086F8
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C5D430A1568
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 22:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A100D351C13;
	Wed,  4 Mar 2026 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SR6surX7"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49066280A5B
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662157; cv=fail; b=sc6i9w8LUuySdhduuXTQFePNFUFZq5i+ilkdoOv61iKS8DWwO8BTVEZ3Qtc1tGcv56pUoWyuqNX5gpLgMKyzmdPqPyZjXCcsz6rbyODXLDhB/EPc0xOmIgaRLNhLnHr0nBQfOnQDHbFuASyRvw066mOBb76N3msE4XGLWjI6LHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662157; c=relaxed/simple;
	bh=p7Lgk6ygsGfw4OUMb8Zj4fAVDnB5E3ZQSYZaHKGLCm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RsWWjztFvAKvdK2HjrPanYV65upH8XaYtLulCLiPdGeLvHu6bd1XqGhrKLombevGu/8azH/BUDpp6FFuC/474yC/UJtXrUR3liiv2JXXo7ce9wUN7mJHMqbIQaQCMK+TKZl3dRUV9PDyzmzfXZ8wVS7SEezghg6/fXkepORCnmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SR6surX7; arc=fail smtp.client-ip=52.101.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xk/Ri2sUpl5mGX28aJEi1CjMCRacK0be2cB98rDsbI66ELTsV+wLNGv1q1ScytkWlU69BaGld+1mVjGOk0iyilTjDMjq9wJvthXXesjTow/FMuT+X+SaHmpOh9ZthVx/mL8lrp+Ue3fF/8y7qCNdQzovHEPu6Xi1DzDUT7IFWJQLbNITfYLrPc4Nuwjkzq3HuA2Y00zuRMQ8uLFkFGxt4DKqAuyDpSG8RKs0+RTvQu/xZJFKvE4T1RgbYhYc3ZhoCNtsAWZDJN0WtxwMP9Hl0WIx/TwsGcO/9LGi+xAdGBeHggMifRJr0v8hB6kjkgH8FCPPJQA+Q1VDMLQ082tMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tho/iY39r7UV/RmN9bXCuteEmad19dEIt/PyH5RmSeQ=;
 b=GE9QXqFCsI5pJ9Loo2f2Sb7J01t8kKgmCOJCm57R4og2L+mTZpfR4HtaemqeCkNYEP4s4A66u+PZeOlaYrBSCuyBAWhcBiyE1E3saX+/0M3xy4edxB8E9YjXZ07yqicuuzc0Hl8xI1pHnCWJ/91XaOf9chEjcU+X2GCea5S2j/PImaT3J1xvejHjQ1HNmwv7j1VIKn2MgaNu92dUooCYrAZyfQ6rRdFD6vCtYd52hYVDllVFzITfuiUZU+uFe82NecCwbbuRwYpPrtGrnFRGj5uOgcIKbR/5pHj+gV8UgALpaU82NTyWk7REQwDqBrIy/wktX4R2uTaLiDWYvjkqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tho/iY39r7UV/RmN9bXCuteEmad19dEIt/PyH5RmSeQ=;
 b=SR6surX7TpHGSV5aShylGPeR6a1Md1wN8Fl6fyePyP0CTGF8GGi+5on7ZK3GUth+gtDsIVGTqg8hNPYmIiOqI4AGGlVdvQFCPA0AcwfdWKpuo6xq2N1hjvStxk44/ezSk8LI3g/JGUEWSqp9U4xsCJmFwman7nWxciXgVqFo+m4pOtBLOHYwVb9IqZa/AHdWrzNMm5Umf5ifHmtxqwTwIveS9Qq493HlGonfpCr9LF0maG+h4qNEHFvHuDpvqrOLhA39W8IF4ts56oFpBzvuuJ+B1c4hVI0YhSrZX2rYMvuIxbkYpl+LHBpwOJcDZcbrjShFdjHDnrK2+cpJGNUY2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI2PR04MB11097.eurprd04.prod.outlook.com (2603:10a6:800:293::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 22:09:11 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 22:09:11 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net 1/2] net: dsa: sja1105: reorder sja1105_reload_cbs() and phylink_replay_link_end()
Date: Thu,  5 Mar 2026 00:08:59 +0200
Message-ID: <20260304220900.3865120-2-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 17312958-9d73-40ec-7702-08de7a3aa9d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|10070799003|19092799006;
X-Microsoft-Antispam-Message-Info:
	Z7q9BpK+7vpNRn0ZWbcnKrvBmg6Tp3A87Dg9qf9ox9HnBvi5ULqsBIH4Hzy7cl6Xw8Ewln57cYslrC9kPThQ2yTPTpV3+q8v5IQ5oykDrwKuzAaua7i4XUEng46XNlVyPNXrakXOA364mG2WeSzpPn98KZ89/JsuQrntyk1BHuRvL8hVVB0SyhASQ0/Nw+xmxtS/i0a9hLpT2n9entPLoJ2dqEVmSNosrxSj6xn+FdTJ2LoqgO4H8dJoO/aaXVMnU42lzcGSIsrNNPncUmmBPAUs1BhUMMJ5owTYk/0zV+m1P2PUJqSRMYmKcoLCjmVqwxKs2Kwe0Z3uPlFDo9yA1Bvhh+Kup+8gJ9aGpRFxNksiVdO+N1xqGBLw/Vys1XKXuB1Z2KyPW9+fgKdYwrfsfINj7V+qzckrJ7JE189eJIK9EImW5Bq567HEy6z2LxgSofwYgacXeUYOq47cHOsGtBX7BVTk8FhS93amp0rP573pph9V5lPfCEnqOVldheS71Wpe3p2ZQYLFi2cw8NQicO2ecZWEzVIKsfLWc5z7/070srqDfKxvuccXLxj1XSdyJGfkHs/01ai/VcVg28vr4OkYVQGEbmHpfaZFEjnI4H4TN867hLPnNY5XvlqYUM5SDNqkYlA+HVoqImMxKoWIVbZVQBFJWTlzaVOpZgNfyg8A7gskxFCngxSQCkCMsoY8f5dPkW+HZNBWt/n1juO7Q8O1k5A28oSiCf++jkBJ8G8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(10070799003)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WROaaVWwDSNOdJL9u9UQHDE8wuwZe0QHXDbGFJcrPwXmr02z/sp+IHriMTCV?=
 =?us-ascii?Q?10kM5DNvFFv0PTUbc6bWfpnyVrtSDyE3jRlNQnlPzv/WwXlJiFqAO1qoTogM?=
 =?us-ascii?Q?85qIuclkMEkP1mdP0QgouHlOuG4XsWFDjgIziVNNqpoRhS0Nhvxp3jVFl2dz?=
 =?us-ascii?Q?gbocF0pUOFCA3AjGHsCN2g7avNJxq+c+aeuss+6QHNUB40U1J5xEXnZRsoNq?=
 =?us-ascii?Q?Gm0RPgcAVVdPFtWXYTmToeY51FY5wKikxR+rmMd4jyvlA4YBkfWSM/CKk7x+?=
 =?us-ascii?Q?wiEZ2zlRqfGS6bQXH2T+NKVvfWk8DJ8wnoMoql/LJc8aCJzmPYDKWE8CtIcK?=
 =?us-ascii?Q?kfWoG8jM9jHqtT86qnZMXkcKy/20MUqP0XCNUjtiazb0H3CPQ9KaCAEQL+ob?=
 =?us-ascii?Q?dk+dzZZk9bEkJyQdh53HkR4Yq+tfxJBWPo23N+h9djJm/xN0r5iqKqRD3aeV?=
 =?us-ascii?Q?Grrb9NQ+EsWVAv0YsfHkT0Y9uKBoyM9mRgzJmWhGsJTw03pkaUsiegW3iGc8?=
 =?us-ascii?Q?9gxpQxc2FmGtNaY9mrZQijJ3s59ZKW9WozqQ02m/uadUScfF1FrVbol1lLEn?=
 =?us-ascii?Q?gdImRCABgEvAJM0gCUDQRmDWXYHYU32NLeuKuTEh2+HHRyMG+8rQ+CFo1eqY?=
 =?us-ascii?Q?FoOVc+9aL38P0EZDVsTqqTx1won7/WuHSNyPl3QzsvgYGYE5SoZ1ip6C7Vhq?=
 =?us-ascii?Q?ORcD6/RAiR/ewknnZCBsPZ1DwLcj1d2xblGlntB2NlwtzWpJ991TYj8kfG95?=
 =?us-ascii?Q?WUggKwxxd0/FdBhO6vxF81xlBu22tXtdn01lnvEjXhV0bVELxIFeUSWbUpz2?=
 =?us-ascii?Q?qh0GqIX50u5KtMUxEpuYMySPkceZ4AhKOZzr/1Hl4y+Hm4Z4G0VBzzTbZvsN?=
 =?us-ascii?Q?58u2Q6OU0/7afjUpJiuGQFwaZlnws7+0U4bXdThth5txLNYNNrhblMWjaHBe?=
 =?us-ascii?Q?29b6HhHXQ/Vza1MhF08sIjCq82tPuVwTBk2o615JgtrYAG5A0vam41sTPYC4?=
 =?us-ascii?Q?OwXr69XtIN7ipw3BlRrhaBSSEXzuFVF90uQPBLWmYSuj+Zn0Q+EVSIWcci4v?=
 =?us-ascii?Q?SxOAzz3kNtL2augqIsU51iak8FzBKtVpSVj0jjD3k+vgMIea3piUj1ayn9EI?=
 =?us-ascii?Q?oEWlubQDJ8wBpq9dlqx99AZ6b80dWyzavsqWhtA1yQ9h1kFdBgNmQzWCUS+h?=
 =?us-ascii?Q?bHXC4GiGaSERGF5DyAYhRl6nlFW+sPzQr/jcUdha7sqn79G3TEZD04HDsVcG?=
 =?us-ascii?Q?zuTH9zshuaftsIX2jqdKHjuLKddpKgeLayw4Gimiv7WtEbQyD4bMJm1IIOGe?=
 =?us-ascii?Q?IY8Hl2wasBKkBsa+FGkJ4NUjpMp/uVY17mAYlZhau9x1BHZxXIyLVVPiFe98?=
 =?us-ascii?Q?CQgiyrhsbnaz7/idNcFsGjAIXOFyJTTx+pWvY4aMBhnSoh3XBwirwjqPg0nz?=
 =?us-ascii?Q?NSupXhBXnTbmQ2BSsXZo/xAbBxZcEW5ufx5eQM9LajiW72e1HGARxLRqGUlt?=
 =?us-ascii?Q?A7Mvs1CSP2AZ7XX14PWy9Gttj/uIB4V7orc6qdBRrjKWeY957hoFPekUqKC6?=
 =?us-ascii?Q?SS8fguTDv7eKG92aPDo3Cbrv2FfBQcMdJualzE6zwUH01uhHaUNu6/0vkUg3?=
 =?us-ascii?Q?Hm7yYFtE3je7t0ADcFX5uj31ezi5bdmiO77MQj65ROJ9e77dNbKF2qcYCc59?=
 =?us-ascii?Q?grRDCl232Fx2HhDpImrs0XdzxzPQUYHzGM/dWiUd4aOykgGlwfbBI2HqtkI8?=
 =?us-ascii?Q?vymruWxo1cIjYD9MW/VBX9NPii8Fkx+U0nQ3uapY8Og7i9x1Qzfs9v79gvO2?=
X-MS-Exchange-AntiSpam-MessageData-1: VN+iXt7AEbGEzBDj8ttYVXMPvzHODtWEZ0c=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17312958-9d73-40ec-7702-08de7a3aa9d1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:09:11.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +n8PwGr67OXXpgaRvhWRAjTvoR9gwHwnBMB/MFQ7Lj/QXULmwHhHXl6ZPxXW2cWXtbjHvYFfxR6HBAt6X0tQhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11097
X-Rspamd-Queue-Id: 6F6B92086F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264062-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

Move phylink_replay_link_end() as the last locked operation under
sja1105_static_config_reload(). The purpose is to be able to goto
this step from the error path of intermediate steps (we must call
phylink_replay_link_end()).

sja1105_reload_cbs() notably does not depend on port states or link
speeds. See commit 954ad9bf13c4 ("net: dsa: sja1105: fix bandwidth
discrepancy between tc-cbs software and offload") which has discussed
this issue specifically.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 94d17b06da40..bf720d96bad8 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2339,13 +2339,11 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 			goto out;
 	}
 
+	rc = sja1105_reload_cbs(priv);
+
 	dsa_switch_for_each_available_port(dp, ds)
 		if (dp->pl)
 			phylink_replay_link_end(dp->pl);
-
-	rc = sja1105_reload_cbs(priv);
-	if (rc < 0)
-		goto out;
 out:
 	mutex_unlock(&priv->mgmt_lock);
 	mutex_unlock(&priv->fdb_lock);
-- 
2.43.0


