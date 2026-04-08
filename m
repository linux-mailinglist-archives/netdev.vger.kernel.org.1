Return-Path: <netdev+bounces-276293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EwFAyX11Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:26:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B53B78C9
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7148C3024168
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 06:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61263624BE;
	Wed,  8 Apr 2026 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S8Bz8MzI"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CA016132A;
	Wed,  8 Apr 2026 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629473; cv=fail; b=uIk6Wo9um6oYMalGiZdpX76mawBHvDTCiR/7YF4H9DalKJtxLl+KXQldcTXpF3OwfZTXbKeR+hWQz2sm7ZKttCdjJxv7OdI4F7imvjaCZjdlUnSguCwJjMhAtVM89DQLInQyuDUlfZqB0iKVa5c2Q3OUxDF460gEQsoNAr7EYxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629473; c=relaxed/simple;
	bh=NPqgcWbdB/7KhCIO52sJ/IIiay9u/eZrUteOlGOvs94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rADqc3eEBmgQ4dRIePoBC2AI6lzhAtmFXUo6mvnsA7E1ElBuIJgpDnoxjIy5GxuWLt2iF/TO9ci71gSiC/q0mx8qHAQsSxcr/d4oQb2P55uzfs1KnTfKgZIBIKrfq1DUKJmxZM1nNSlM3t4Uhk/SrCvwFEKh/DESyO1/J+3yu2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S8Bz8MzI; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+dJ+nB5vQM6CkBzXL0/VWzZUnZRCYgeCrUHTFK9L5XHp5wXPhxw5oLebx6Tw/olctOSSPpAQ9GY+h4R/ChKX/8kat/xqATj29BrsElRMdc6NgDI7ZdDkHHo7f0iiDaVyF/VFWpCLv5OucMrDRmOE/Z6WoNie4Oj5Y5WX+FswPLiFeSzDBfXVwmhYowatJFLIO0c7iA/VeJkBzOn2xUYmDMMTrhwYFheqfqfC9vlDLnC0YnkrWm8eX0v+1B9Uyf9R6ZcHhxAYg0PPnFpxf+xzHMjMDgKBJ0SzzHGINJbqtdTdHdqOT/7XlUaaT/iJZiZ+yYJm0x1JyhtGapZpJ9liQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEq/obT2YGv/7x0WmxaFUi6xeleK6w2s8uKfAcEn5Ho=;
 b=bDmyc+PyNYa5IFQm2ozunCmUBifKSzuKfqoYAzmssWDvNXXj06mt6FWAWSp59IU+afcVVg+cc4gCabejBcR5kKDTdOJLrzEpveVGC7jgplXQLqvUc5MIMz+D1M/0Mytlr57p3I8tfEmHgSL7zaXPWgjut6aqeH9n95lGCWcTJAAKMATVSb0OfXzol1+F33bLm7hPLjoBxswzMIXeHiUl/4BX+kqQxUjHfxlCpmWkNGQbm1wtcNk5YpfNFsYwjAZ8o8URed/BAi8zGRZWrA6GjoU4VCYiww0+x+yj5BmBlzt/Yxw/UZPKANgruDL8jewyqu7a8dejpgAcuy743CsP2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEq/obT2YGv/7x0WmxaFUi6xeleK6w2s8uKfAcEn5Ho=;
 b=S8Bz8MzIDMQnlzZgK1l5iT6/OHMjZwzuwiiXoudWUXhLHeDAkEIa8D0+uDWCZC0L3HdKYdPSwTil0pDSTfL3w8urDD/+OL2XjUF6KinVrartGBobr5bpXVnDtDLDL1p3tgYyq01+KKvnY3MOhDU++iYvK19oW6qh1LZq5Ie8Q7wwd+ZbvZtcb16g9yZyVrwdfcHNO1PdNGrPUnVzJV54BfJBVLjitK7G43fyFvQ7CWkYrT8EXHfYKcPOey0KFBX5pHxZsGCSKIkGpZhZ2i3pDza3omHpKinUevj2VzZ1uAGKIexbQ1jCrePzZhrmkAGjBP6tAVd9MTw7VXfslY65yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PAXPR04MB9024.eurprd04.prod.outlook.com (2603:10a6:102:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 06:24:27 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 06:24:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 3/5] net: enetc: remove standardized counters from enetc_pm_counters
Date: Wed,  8 Apr 2026 13:58:47 +0800
Message-Id: <20260408055849.1314033-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408055849.1314033-1-wei.fang@nxp.com>
References: <20260408055849.1314033-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0043.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::6) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|PAXPR04MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c38729-a82b-4165-3869-08de95377c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2hFgJtimtrtSqKkiPtPXJrJJSyrpTFUkbWJLE+KoGitdMNQ+hxh2bJ2DrJML7/rhBIZI0411L+My+QkIQkH5Rh5NEo3VHL7s21yedD2GFxtUtTyevoWYw9TUp5WxepTweA9//xYN7bSOKkULa8gGt40z7/Wi47KJRLHzbgm10xnM85vaZcOy64rQkclHV4wO5rdv8UBXeNSGq3OtNBiJ1H7oGhbsZm5oz83bEIJfksedwA7GcKUr3KWIsVnfg0AwIbr2y98+0tkq2a4NCJJAuNi7EVdPGioLv664HCutnKhCA5rVZfDVek22P2iQhowRbxucwGNijUBTugSO8sne1mJcv6nXC6TSvf9pZIyOQWIEY+TPtMU49FHNEbZ/I1fFo7iymowTcFV1T0dbsSm5IbuotPvN5J2509YfP5OgEwdZhFQ1vv8Sq0k5YEBUtZaW/J46YL+W0j3mEgZI5jGAVD/S0APYj+wBeZISL8fQaW+aXzMJEos0HefXRCJPE+/Fi8okTyxCRRZ0gbbPHFG9upGvHm6fcBD5vRyGtCi7qqnK64U8Er+85b00hvvAXW6qL3dYUe4N3T9hqLReEA1DDzVJf7oZ1ZVXMXx1cIiKXZdvAqMeEo2oYDapXGqo4nusxwGt33F5++/TX7Q8qEG/nqzSQSd7p03A7mafeOqa7OWWpIj8tEAtmE29Um3ASGPpFUy7j84X6awhQNqoKZkK94/ANGdrERwQeN2ZgCIJbwvj+vbTZ0FyKxgFA4M9j0PTas1UEI+gHW7D/tWTm7CE93XUFj/2w8r/zDIiRkSKSKs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QQriWPXHgE/9Vhh8MCMi1vRwyD5O1bFgsk/UV/wNovUtF/qKmcukP7npQsJr?=
 =?us-ascii?Q?PUUeOdyvhqP3KHR9x5u1++I+wo92xRVpMD5Ck6S29ww1lCfZof+T9f1MZBG1?=
 =?us-ascii?Q?OEQEFtLqqk/z3nkCfC44Q56s0GC3SfPHsLfvOWCLKfQnOaCf7JsbSMvsLIcq?=
 =?us-ascii?Q?1+h2UzSHsEdM7uHnl+5ulwDl75gyeUY76zXLgJR/+H0pdFvVlZEh5NMMBtkX?=
 =?us-ascii?Q?D0IkUy1CGNOOl7F2pLtN9RgXWEioa8JyWOem4HqmCkCqu4yzN0Hp0YM+Ddra?=
 =?us-ascii?Q?VSib+bhl9mcNtDkYJnbqdELaCMWrxESttGMS6QcGKw75L/VeFun+s37uVBG5?=
 =?us-ascii?Q?diGb9DK6S33aDzwwFQAGThXnXrvVtwkh0UM1pB20CwcUcx5o34ROk0tDW6+0?=
 =?us-ascii?Q?9dzQjXgo9dyprA3kCZ0wn9XaE3wM+aEwrWRoClJ62ybw7J9vUpbnn2yXCVMO?=
 =?us-ascii?Q?K6LNtMO5lsDAaBB1RAp4KNYzWnmD2LhkWpOrDWfqHmscOwgxnsth0EPd4YNG?=
 =?us-ascii?Q?yuyKlHdzXSvjGGjYmtIXC6nIkWsgM+ftpZVj3Dj5yUS+/gjDnR0T1CLydeZB?=
 =?us-ascii?Q?iYTF6CC8LPj/KwrsAtaIDxjdtEnRETcn6JlGke9VoUPmUH70bKR1ydgMLMRB?=
 =?us-ascii?Q?cCCjmmohJSDodMBBFxojAyLNIM1GyWRnL1F29dYMjOijjFXHuguBAGPVgT7x?=
 =?us-ascii?Q?O37DvGv9i5uy+KSSyRlqEy/zjJnhTFRsmg8HhEFBCbLD6eViJU+RgYhGiIo9?=
 =?us-ascii?Q?sOgLp9ZjFQ3IEepEE/JbeV0K7318AL8+TG6qPRI3ZF25OByUqyclGSaue4Q3?=
 =?us-ascii?Q?5/JMuo3XF84YaXN0YcL5BGAqC5XQRyIsSku9VO4OECe5Qr0u+jmeKgETftwk?=
 =?us-ascii?Q?GtAl4t7z9xz5JiUoezqy6dBiZYTiwMHKAyQVFhlfJB1NpEjmlr2A05xYPFpq?=
 =?us-ascii?Q?ZezFit8opzSujIXZoJOFdQay6bNyf5PwFlfN/FTo2DLDvBnyk3QodACz64TK?=
 =?us-ascii?Q?Nq2HmJqAKXmUbDlopoe+GyFHc0WCEVrMfYp/3aR0WqVlX8VjihbDft0q5tAZ?=
 =?us-ascii?Q?Tgj9DCu3EjS4Z+A9ucGJ8sAV0bpODWx9fJBIoJQe1jFCk+aIPXvgyV5YXYb+?=
 =?us-ascii?Q?pu/UOZHETEwz6yx6dIHiCS8OEoepWvqXM4iptnCNJGjo+GsVZ1ekQEbaiUWr?=
 =?us-ascii?Q?DTOSN9+OKRLA5gIWlLRiRaViRWa9b1e0cMw9S0l4nRsRCXG17POa0zGViF4p?=
 =?us-ascii?Q?twK9f7Ui3imFp5kYyp96mkRnerHcDN1ojZ4pyP7QObwTFPDDO/jKZlAIKfSB?=
 =?us-ascii?Q?1cd/wwNrT4huH1hccCJmfsXCSM1s/DMxrQgPmQx41AdmbVqrwqa7hlwTVDzW?=
 =?us-ascii?Q?zUn/pHrRUCUy7lU6BGn+Ws+PkF9a3ta0+LE7Hhtg9Lxv0dqE1fPM0XbiwoE1?=
 =?us-ascii?Q?lCU8gDeeh4++EUBRmvmhtOv6l+azyg/ULIuhF6aZuR/GMeiFF4DGox28J293?=
 =?us-ascii?Q?zgZsQP4ElTrHZ1SjDpyuXK7O1q8jxLS+soYe/TiXCy3BkmhvEER7x2Xu6st8?=
 =?us-ascii?Q?fuxkbQwo4Zo431GmgG6IqLXF/PN72lkCRyUeIaOzSRnKMXkMopviHlKW64wx?=
 =?us-ascii?Q?xmhhIax8E7jWLUIoLzJl5a0hRIfvb7gEzOZQtmv1lHsoxz/irUuIwV7qL3js?=
 =?us-ascii?Q?fMxIJTqbyPSt3MAVio5gfSlBD+9cbeYGL5EQe6AAWlqIW9xvMImf3yNDzDH9?=
 =?us-ascii?Q?uBW/raDt8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c38729-a82b-4165-3869-08de95377c0b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 06:24:27.3576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgqqktLv0yEuoVYw/I3IjTEYR6lrhuUn2vQGWI51wQJ8QVbO/H1a6zFpWS+AtOA9mZQ+bOTqzcEl053tAdXzdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9024
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-276293-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 770B53B78C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The standardized counters are already exposed via the get_pause_stats(),
get_rmon_stats(), get_eth_ctrl_stats() and get_eth_mac_stats()
interfaces. Keeping the same counters in enetc_pm_counters results in
redundant output.

Remove these standardized counters from enetc_pm_counters and rely on
the existing statistics interfaces to report them.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 40 -------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 36d1a2b810c2..504def405489 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -130,57 +130,17 @@ static const struct {
 	int reg;
 	char name[ETH_GSTRING_LEN] __nonstring;
 } enetc_pm_counters[] = {
-	{ ENETC_PM_REOCT(0),	"MAC rx ethernet octets" },
-	{ ENETC_PM_RALN(0),	"MAC rx alignment errors" },
-	{ ENETC_PM_RXPF(0),	"MAC rx valid pause frames" },
-	{ ENETC_PM_RFRM(0),	"MAC rx valid frames" },
-	{ ENETC_PM_RFCS(0),	"MAC rx fcs errors" },
 	{ ENETC_PM_RVLAN(0),	"MAC rx VLAN frames" },
 	{ ENETC_PM_RERR(0),	"MAC rx frame errors" },
 	{ ENETC_PM_RUCA(0),	"MAC rx unicast frames" },
-	{ ENETC_PM_RMCA(0),	"MAC rx multicast frames" },
-	{ ENETC_PM_RBCA(0),	"MAC rx broadcast frames" },
 	{ ENETC_PM_RDRP(0),	"MAC rx dropped packets" },
 	{ ENETC_PM_RPKT(0),	"MAC rx packets" },
-	{ ENETC_PM_RUND(0),	"MAC rx undersized packets" },
-	{ ENETC_PM_R64(0),	"MAC rx 64 byte packets" },
-	{ ENETC_PM_R127(0),	"MAC rx 65-127 byte packets" },
-	{ ENETC_PM_R255(0),	"MAC rx 128-255 byte packets" },
-	{ ENETC_PM_R511(0),	"MAC rx 256-511 byte packets" },
-	{ ENETC_PM_R1023(0),	"MAC rx 512-1023 byte packets" },
-	{ ENETC_PM_R1522(0),	"MAC rx 1024-1522 byte packets" },
-	{ ENETC_PM_R1523X(0),	"MAC rx 1523 to max-octet packets" },
-	{ ENETC_PM_ROVR(0),	"MAC rx oversized packets" },
-	{ ENETC_PM_RJBR(0),	"MAC rx jabber packets" },
-	{ ENETC_PM_RFRG(0),	"MAC rx fragment packets" },
-	{ ENETC_PM_RCNP(0),	"MAC rx control packets" },
-	{ ENETC_PM_RDRNTP(0),	"MAC rx fifo drop" },
-	{ ENETC_PM_TEOCT(0),	"MAC tx ethernet octets" },
 	{ ENETC_PM_TOCT(0),	"MAC tx octets" },
-	{ ENETC_PM_TCRSE(0),	"MAC tx carrier sense errors" },
-	{ ENETC_PM_TXPF(0),	"MAC tx valid pause frames" },
-	{ ENETC_PM_TFRM(0),	"MAC tx frames" },
 	{ ENETC_PM_TFCS(0),	"MAC tx fcs errors" },
 	{ ENETC_PM_TVLAN(0),	"MAC tx VLAN frames" },
-	{ ENETC_PM_TERR(0),	"MAC tx frame errors" },
 	{ ENETC_PM_TUCA(0),	"MAC tx unicast frames" },
-	{ ENETC_PM_TMCA(0),	"MAC tx multicast frames" },
-	{ ENETC_PM_TBCA(0),	"MAC tx broadcast frames" },
 	{ ENETC_PM_TPKT(0),	"MAC tx packets" },
 	{ ENETC_PM_TUND(0),	"MAC tx undersized packets" },
-	{ ENETC_PM_T64(0),	"MAC tx 64 byte packets" },
-	{ ENETC_PM_T127(0),	"MAC tx 65-127 byte packets" },
-	{ ENETC_PM_T255(0),	"MAC tx 128-255 byte packets" },
-	{ ENETC_PM_T511(0),	"MAC tx 256-511 byte packets" },
-	{ ENETC_PM_T1023(0),	"MAC tx 512-1023 byte packets" },
-	{ ENETC_PM_T1522(0),	"MAC tx 1024-1522 byte packets" },
-	{ ENETC_PM_T1523X(0),	"MAC tx 1523 to max-octet packets" },
-	{ ENETC_PM_TCNP(0),	"MAC tx control packets" },
-	{ ENETC_PM_TDFR(0),	"MAC tx deferred packets" },
-	{ ENETC_PM_TMCOL(0),	"MAC tx multiple collisions" },
-	{ ENETC_PM_TSCOL(0),	"MAC tx single collisions" },
-	{ ENETC_PM_TLCOL(0),	"MAC tx late collisions" },
-	{ ENETC_PM_TECOL(0),	"MAC tx excessive collisions" },
 };
 
 static const struct {
-- 
2.34.1


