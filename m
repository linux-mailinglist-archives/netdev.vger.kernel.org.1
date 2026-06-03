Return-Path: <netdev+bounces-294780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GZWuJP5DIGrpzQAAu9opvQ
	(envelope-from <netdev+bounces-294780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:10:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E855E638FB1
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:10:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=LbvJd1BL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294780-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294780-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E3A732AF0E2
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0794C3AEB27;
	Wed,  3 Jun 2026 14:36:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA51D3AD510;
	Wed,  3 Jun 2026 14:36:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497411; cv=fail; b=O31doqrZXMsfYD1zIV53IrGmLnsYf2i9xdCImsHSMAsXSZb3x7J4SO+M2xEMh55Rx7HD27SnFL9hqzW4pllAdaeMrT5Tn1iARbmWtIiejmKYvasliOoKTYwyYv7r8IWXpPmbkX/Lb+ARQRuKzN1porsvowG5QsvvIwscFU0iHpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497411; c=relaxed/simple;
	bh=jxtrWTE3hXXdrAq+bOV/39B5RIs4q0L6MecSMeqYoaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fmpnA9fsL0D9s8heg402gr6NhY3HhCsYLApOoF0y60iJJ7j/X86I4aF7alFg/3bQIVcktj7GO8F6XQVU7cL9oERzEnCtGI01EI2vdn5PQDodrCEUYGZLY0fnEiqdLNeP69Llv/hb91vUHhUKVOhlkEw0U8FKGnhxVsqy0HQ9VAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LbvJd1BL; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDekpTvQ+nyB/IfgfnMt9SFGnrFllsl6qdD1YC49xGi1ueZ8JmR2MyQOnzqUeucUdjQ8hk/FWSM0ZRMJA+/YIRQ9r16h+1YXEksS99xlAtXLLCArv20igvnoKR4J9lM+pq9IqYz3px18Cub8SVarEQr2qnsjD51Dv2T9vuvAjdl4SGtAl+ZUQISjcNjPFLDDd1uibklBXZJfaGWxqfRCmOmX+iR3p9RJUoTYlZJVMF0sdIhiz191QsP7dK1VoZV5yT2r5bsYwJvqBygqhP3LSM0101Onbvm3POVR8kqrF4AmmJNozrZSYrMlLBe6JCTahmH1XR13fQjpak42kCBD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QhrMKtAjQBc0ZNBeUtWVsVPBs2b03PyIH3Eu3fIVHs=;
 b=HYqIW8J40vbAgO8thx9j9i1j9XwGpZ2Iaabq+5FyYZ50WJ+kaU5rXomlKk2WGxBCW5J5QRSpCxpzEEgLCcDig0s0S4s0eKdLh9fDr4xhrj9maWgjs+kWpDkxKq8sQcVlO7ZPKl5nSavfkLZgvw1m4Wt+q68zWGtmJwApkT1P4Yw2BMlEkdCzKimgO3VfAXghg91CRcxznS8wJCEt+4xdxzw5lxRgEv/TXLlDCXPvkhDnbe8ZyT4hzTPa5IiwbgJIFoojXh++xcb4WuD3VDdA0ExIOueUP19LN2oyh9A8SPYOZ1IlUoQ9xPDECptTrrDxpStatN9R3J9MR4xA+6yPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QhrMKtAjQBc0ZNBeUtWVsVPBs2b03PyIH3Eu3fIVHs=;
 b=LbvJd1BLUgNTmI7IhxhjTvHCT19kKAwHTTyMSS+f2v/D6LxlbJDgVmreQ9t5f7U+02/aYtiLaRAMXV2W3wjZFlYe/LsAuGVkC7Lzj+ljOgx1wpZnO3spMHbSecUWlBycXw56eQU/v7Ehw7gTYZqDVzlgjbUNIGeYsGQPphdEFnVkyXdXlVU6EMS/KAGqvqR1o7RET2PgEQbdMqFnqm2PEeG51QnSsBqfjvw/ev1dDpNQvpaOXL9DQ3++xq+f925CmrP5SR2C8B7jPfWd0rWXnLIEwhN5ZkQsQTFfYf9oVPu+DmIO7jG6kCMiXClOgWWR59+tHt0jX7x4iw78N1frtA==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10615.eurprd04.prod.outlook.com
 (2603:10a6:800:26a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:36:46 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:36:46 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 04/12] dpaa2-switch: extend dpaa2_switch_port_set_fdb() to cover bond scenarios
Date: Wed,  3 Jun 2026 17:36:15 +0300
Message-Id: <20260603143623.3712024-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0443.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::17) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10615:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f9352e-0ccc-49d7-f965-08dec17d8a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	yLP76UbEVxQ5oOAvcuFBmQ8FQVBJimkUVKyGL3jMFzWztJQXlTzNoZewQdWoEby121/xBjzYLPzPohp/1pgKNrqcFNHMqA8EWPxjrCxeOebi4dTUZ0qw4OtjaZtY7qvwIlj2YqA1vQEmHOKip9t0QatRaIm37qNWkSboskEcOdwvWW9Gi0s/SkoMJ0rYG9apOaMIpy94DMkgQ/Geo0vttzlGVa74fZXDrDWMz8ygoqELXvgvSjHYDKuuBXXBCG3w2xzntJo3cniv7N+epI7hLlZPP3mgn1hf0cM584l45H9BnEItnYHJrGqEp/xNMx08eUAyxpWEc4BISjjRFGTmoz+OaT1V/bfYEdNDsk+rjEnKxCdXNEPkYnRTM3SUMX2mD4rp91pY9rMXq7+G6b4CFdZHvyXHPXRpj8924oAKFGFZi1XzmIHZKk2k7Nr4w8IilvuiCG8hUP8od2d+X8sSU1BrgvJbsJEAMHBRbxX0ygnt1lC+/+UGxHEQ6c3woaSGlVklAEfu0NjCXl0e6dBHPbWg2tX3zXe5hjoxtMx+CT3Tz1IbpdkeqtfoZAvQBsVC9VqsXUJFIjtTZIzLZDNBdRNuyLlRvHvJlqVJZQyfnVd4LowLv1ZN1YVc3IyC0EHTWiWOcZ2UD49lopu27QDLjbFcEDU8SqWdNz97bvnoIDYfxaqWfB97lC7fpT5FbV/c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ndz8fesLYzUtEqxnBXTqAEUczV0zzezOAK0CepOzDeT8uBh3GqMx7XdnmwZj?=
 =?us-ascii?Q?zqalii0fJocgDjmmqUd8dQfD/RCZn8sdKijaiZTipY0rZQe39rnnHJ/W1abd?=
 =?us-ascii?Q?d91g54G1tuaF/5bn2qUXYQD58jZTYtKBgUy97itTE3+6Is9TWyjEpCW166en?=
 =?us-ascii?Q?j7ny2+fgypfazWSaH+VUMUlDhMs/RRbssI2kSj2vYR9AQZ3fdO+UjnC98PQD?=
 =?us-ascii?Q?Kxqh/69V3UiaRhyxZALrnKK81xnbJ0NApP5yE7KUhCA6zSAQ96d/nRruGqFS?=
 =?us-ascii?Q?KWtrXczTDMBXe8H63YA8Vw3OusdlKGWCbSFfga4d4z2poSsrZNfJ/oi1bmUa?=
 =?us-ascii?Q?+2JFHHVSfYe4C7ZWrI3942CSXAGBPPDWA291u+G4d/i8JMONsTzGFrnzKi+N?=
 =?us-ascii?Q?85Xf5vGXvk20mw903HIPHk3XB1OhJSl6K0GHniSG6bFJT021FDyphxWwxqX8?=
 =?us-ascii?Q?gf7oWkbWIwZYG6shypHqdjKPeA4S8WRKaUYwMvT7+1TnmkYPAzFMRN7jiU6i?=
 =?us-ascii?Q?BY/4d2zv0UBg6Ek7z0uOQBa7BdlFZixpiJNWYGqrM5/ukD+2Aru2Z22bOgmf?=
 =?us-ascii?Q?Ai3sYRk1RIJ/7Nz2l61VCJZhwiRmqSBoId2+auQROklDp5m0xZMWMEYBJmP3?=
 =?us-ascii?Q?mHc47z9kyepa11hH4xkE81i+HLoA9Xmlpf32NL5IvWyIRXjJh9eYncklm2zQ?=
 =?us-ascii?Q?zvSQtFF1eZAgmSVEtVtIGPsywgEsOjI01WXneQtKYkg/Vb0TfcKva70EB4Qa?=
 =?us-ascii?Q?Xay1NkEui/Zq4cT3RRbz0KCXim+Dxv8vauuqvvs4xzf+PeWjheYBOoEypqG1?=
 =?us-ascii?Q?kgJaJxnePnXHcZAaVdJU9y2ysZMWCud+kCVvPizsmL7vYWa2hXX5+MTGqk9v?=
 =?us-ascii?Q?tlX36RgG2+af+l00cbn35KtTd8iqBfoeH1Z2hfsDLm+VHXsM48tpbq44b6+V?=
 =?us-ascii?Q?6JFxNVpx9BWT/FLhj9FpU8knb+3FiImudQOfVjxkVfvYiZafz6c/DsEBF5z/?=
 =?us-ascii?Q?RnHAoGTfAhs+McNDqjK6o0mNbfPHCqPUMxr2JPlI3r7ZEBGrEfpzbFYI5mdf?=
 =?us-ascii?Q?tRCDX8kZj7AWQtBBy6r+gRbwH85pfh9IGcZTG0mDVAwh0hA7Gxc2+YAJbKsz?=
 =?us-ascii?Q?aZxXlpl5ZA5ZcTBJAm/b/uE33PHkmQqPPg4kAn/8GnEtcVSyIqUCZWxd8tgp?=
 =?us-ascii?Q?rg09+sqMeXJebAK8oe8vP9ysVMF/aoNj87S4UUDuEO0VyJP8eMzDYyuRUS2j?=
 =?us-ascii?Q?46DC2/VBL0nr2+omBOAnbHDrfV18cPXoiuvzinIiAEAR2l4Hn8dEXMF5y1UF?=
 =?us-ascii?Q?TpmnaSJyioK9qBDXNmAUc2wCrwqkioee4YNv0Kr2Uma4SpJWRx8uP3zmn2Ra?=
 =?us-ascii?Q?vYs/SPm4KvJuJCyTOg1CVf3QtxHovQq53zF7mhFr8SBYrXBEcbMaCu0s8WvL?=
 =?us-ascii?Q?kN5X4te+9Ojjar7eP9ycqmM84nKpsrC3f31oTm6HvqIbZD7vwr+hcg1J6Z7z?=
 =?us-ascii?Q?pY+eXvBahwRoZhXac5FytqTUprVAEUlcAje7DxOHP///fL8TkwKACgYn8lo0?=
 =?us-ascii?Q?Qrn0sooB+mz2KlgDDfoODdhn2HbxhMHf875oRycLsrzYj7+3lUtX/75vjq8y?=
 =?us-ascii?Q?AyDCL32pzgDES5LMDRW5IAoFXNiUVR5f3ve2meNQMv3BqRcgVj90evm3R8LQ?=
 =?us-ascii?Q?vNAuggwwpDHB9vL/B6gesikFLfVOzY+t+dbrpKpCkHvgLohWWCL2HVjGlLBT?=
 =?us-ascii?Q?s66i4QjAFg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f9352e-0ccc-49d7-f965-08dec17d8a08
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:36:46.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rijQeOVnXwpAYMoP0ZNd0SLITlcTFzgHxyCEzI1UVIClZJoDZBXs4bGAeBmTNa9kftGmIil17fLr6dCPMVpww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10615
X-Rspamd-Action: no action
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294780-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E855E638FB1

The dpaa2_switch_port_set_fdb() function is responsible with determining
what FDB should be used by a port as a consequence of changing its upper
device. This patch extends the function to also cover the circumstances
in which a DPAA2 switch port offloads a bond device.

This will allow us, for example, to setup the same FDB on all DPAA2
switch ports which are under the same bridge, even though not directly
but rather through an upper bond device which is bridged. How the
function does this is by first determining a DPAA2 port is already under
the same bridge and if so, choosing its FDB. To cover the entire
hierarchy in depth, we add an extra walk through all the lowers of a
bridged bond device.

When leaving an upper device, the DPAA2 switch port must find a new FDB
to use. If before it just searched for an unused FDB to go along with
its new standalone status, now it first checks if the port is still part
of a LAG and then uses the FDB of any port that already left the same
bridge.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- none

Changes in v2:
- none
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 121 +++++++++++++-----
 1 file changed, 91 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 8026a5014105..b851376b8e1b 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -68,15 +68,45 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct ethsw_port_priv *other_port_priv = NULL;
-	struct dpaa2_switch_fdb *fdb;
-	struct net_device *other_dev;
+	struct net_device *other_dev, *other_dev2;
+	u16 fdb_id_old = port_priv->fdb->fdb_id;
+	struct dpaa2_switch_fdb *fdb = NULL;
+	struct list_head *iter, *iter2;
 	bool last_fdb_user = true;
-	struct list_head *iter;
 	int i;
 
-	/* If we leave a bridge, find an unused FDB and use that. */
+	/* If we leave a an upper device, be it a bond or a bridge, find an
+	 * unused FDB and use that.
+	 */
 	if (!linking) {
-		/* First verify if this is the last port to leave this bridge */
+		/* This port leaves a bridge, but it's still under a bond.
+		 * Search for the first port under the same bond which already
+		 * left the bridge.
+		 */
+		if (netif_is_bridge_master(upper_dev) &&
+		    rtnl_dereference(port_priv->lag)) {
+			for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+				other_port_priv = ethsw->ports[i];
+				if (!other_port_priv)
+					continue;
+
+				if (other_port_priv == port_priv)
+					continue;
+
+				/* Found a port which is under the same bond
+				 * device but already left the bridge. Use
+				 * this port's FDB.
+				 */
+				if (rtnl_dereference(other_port_priv->lag) ==
+				    rtnl_dereference(port_priv->lag) &&
+				    other_port_priv->fdb->fdb_id != fdb_id_old) {
+					fdb = other_port_priv->fdb;
+					break;
+				}
+			}
+		}
+
+		/* Verify if any other port references our FDB */
 		for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
 			if (!ethsw->ports[i] || ethsw->ports[i] == port_priv)
 				continue;
@@ -86,25 +116,32 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 			}
 		}
 
-		/* If this is the last user of the FDB, just keep using it. */
-		if (last_fdb_user) {
-			port_priv->fdb->bridge_dev = NULL;
-			return;
+		if (fdb) {
+			/* Switching to the FDB of another port which is under
+			 * the same bond device. Release the previous FDB in
+			 * case we were the last to use it.
+			 */
+			if (last_fdb_user) {
+				port_priv->fdb->in_use = false;
+				port_priv->fdb->bridge_dev = NULL;
+			}
+			port_priv->fdb = fdb;
+		} else if (last_fdb_user) {
+			/* No other bond lowers to share the FDB with and we
+			 * are its last user, just keep it.
+			 */
+		} else {
+			fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
+			if (WARN_ON(!fdb))
+				return;
+
+			port_priv->fdb = fdb;
+			port_priv->fdb->in_use = true;
 		}
 
-		/* Since we are not the last port which leaves a bridge,
-		 * acquire a new FDB and use it. The number of FDBs is sized to
-		 * accommodate all switch ports as standalone, each with its
-		 * private FDB, which means that dpaa2_switch_fdb_get_unused()
-		 * must succeed here. WARN if not.
-		 */
-		fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
-		if (WARN_ON(!fdb))
-			return;
+		if (netif_is_bridge_master(upper_dev))
+			port_priv->fdb->bridge_dev = NULL;
 
-		port_priv->fdb = fdb;
-		port_priv->fdb->in_use = true;
-		port_priv->fdb->bridge_dev = NULL;
 		return;
 	}
 
@@ -114,18 +151,41 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	 */
 	ASSERT_RTNL();
 
-	/* If part of a bridge, use the FDB of the first dpaa2 switch interface
-	 * to be present in that bridge
+	/* In case we are joining an upper device, be it a bridge device or a
+	 * bond device, we will use the FDB of the first DPAA2 switch interface
+	 * that is already present under the same upper device.  For this to
+	 * happen we have to extend our search so that we can find any DPAA2
+	 * interface that is a lower of a bond bridged port
 	 */
+	other_port_priv = NULL;
 	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
-		if (!dpaa2_switch_port_dev_check(other_dev))
-			continue;
+		if (netif_is_lag_master(other_dev)) {
+			/* Search through all the lowers of the bridged lag */
+			netdev_for_each_lower_dev(other_dev, other_dev2, iter2) {
+				if (!dpaa2_switch_port_dev_check(other_dev2))
+					continue;
+				if (other_dev2 == port_priv->netdev)
+					continue;
+
+				/* Skip the port if it's the same upper */
+				other_port_priv = netdev_priv(other_dev2);
+				if (rtnl_dereference(other_port_priv->lag) ==
+				    rtnl_dereference(port_priv->lag)) {
+					other_port_priv = NULL;
+					continue;
+				}
+				break;
+			}
 
-		if (other_dev == port_priv->netdev)
-			continue;
+			if (other_port_priv)
+				break;
+		} else if (dpaa2_switch_port_dev_check(other_dev)) {
+			if (other_dev == port_priv->netdev)
+				continue;
 
-		other_port_priv = netdev_priv(other_dev);
-		break;
+			other_port_priv = netdev_priv(other_dev);
+			break;
+		}
 	}
 
 	/* The current port is about to change its FDB to the one used by the
@@ -143,7 +203,8 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	}
 
 	/* Keep track of the new upper bridge device */
-	port_priv->fdb->bridge_dev = upper_dev;
+	if (netif_is_bridge_master(upper_dev))
+		port_priv->fdb->bridge_dev = upper_dev;
 }
 
 static void dpaa2_switch_fdb_get_flood_cfg(struct ethsw_core *ethsw, u16 fdb_id,
-- 
2.25.1


