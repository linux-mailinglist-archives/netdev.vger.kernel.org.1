Return-Path: <netdev+bounces-287163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OlOBiAtA2pe1QEAu9opvQ
	(envelope-from <netdev+bounces-287163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:37:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABFB521596
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A3B3291D8F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67373B2D0B;
	Tue, 12 May 2026 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QbZhLoH1"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F81A3A2E16;
	Tue, 12 May 2026 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591806; cv=fail; b=HGduw11WnpA3qGf7xZ2oZWppJ+2rtPtty0LxH12veNSc6z8nawM0mblpE3PHhr9sN5rjp/kLIZfR/hKbrHp00nyd/fgah5oA7WD3jPKgWOg4EIO38hG7i0xpkR5qVDDW14C4ms1YCsxf1H431PEFi/2i38O2u2ew+3pyo0Oux8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591806; c=relaxed/simple;
	bh=MmxDDFixzXpMCyzRJfx6dyPzcRoozh48VwpP3GLmZws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QNZSFPKmUKT52GpKQwttwYsfjlmhdaMH32BUVAuERYR9NxGDmn3J9Ph1tXGi1w+EWV/UEz3qCl9uOWX050T/qhBfrRrY4YLTiVKOl6uNmRrWmr4zGsi3CyAlFyiuZyAEf/h8WVkAm3HPb3M6Wbp4y2VuA/JNJsYmztZi22z0G0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QbZhLoH1; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pgwy9FgAPIRtVnGkQm3FakuK+wBhgqLl8NSmb+sRhQLEetXZvleyObE5eFpupUR/5DgIl2kZEcwSxnLdwfSBwzR690AEnWsmkGmWtcoCtIBrlcpPvWHeTQJnw1Tw/s1Oqu1frSX7xAeWZAO+3f8XkzsYEL3rDbZ2PfxYfkI4hYAld7kGkzl2tbcogFEqwHkMAACKPoNV2pSKNINg2Hq9MSA0+YOLATOo567ITXicllouzVOw9wmsOviYlUQEGVugTTcbkE1ALnapkfgsYbzpz4sxZJsuepxTn6gTnvuooxPCofPTluwLBbVy43eoEdhfDiYFwo7be6ynkN+arUcQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQEifLNi7BkTnhM518u3fQZY9lrqdQ9jxUvUL2bvYAg=;
 b=shj2LKwv3VPw6c4itMbBL+FWIxd29h1vylU/h9XT4NulAC0krtWCQYr5zTyhFUlAC6k8bxq/NFH+tk7oRh375fvtBLdRncv8PUqkVpUfM+aU4Qw77R0DksyDvhyPzIvrTaDAP2Jr28jD31D9fOqYzer1jPLs1XlXlYhqoIRjSezsyUskNQOfDEYZdKCxLH8ogcJxwo6NPdZxpdEFfMHK2HN7/2ZlaCArdfFL7HCreZWSKOkzy53Sfw5WLGYoUc3MogHvBB2rvrwO1v7TgIPKyKC4D++nS/qpKpqwAgEn3B1M/9zLTZCh4a+o1FlhPI9HlDsVFLANTfa5mt5XJwTzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQEifLNi7BkTnhM518u3fQZY9lrqdQ9jxUvUL2bvYAg=;
 b=QbZhLoH1hakKxJ6YR5EGSAyKZyd1JoV4daVtDOfq3N8KLbMyEt3hjKF2IkDf9xwVf95x4JQDKxLxCgdxHj8pnNNHXBnOQeI0wcQiT1Iv47B9yLKTd+XSy4s5+6CXw86xbbCcK0+2v4Jpwp/zcj8DJmuJs94mNNblmgLQRLCWNe96WRZ7pFy1lo+NdIyOaFYeAwGlxPDz/xL6+XfVIwxljnjgK+LRP2euS1EADDiOvVHLZ/0p2KCZVRY1KbI2wNefKQpjxGHRYa/v313bGbLQpcsd/3dhuW03fpX4Mmsmz1JkJWHfxSGbMbTB+wvYxpEgcXWqQKWT2ff0Eg+sjro/OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DU4PR04MB12328.eurprd04.prod.outlook.com
 (2603:10a6:10:629::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 13:16:43 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:16:43 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 12/13] dpaa2-switch: add support for imprecise source port
Date: Tue, 12 May 2026 16:15:53 +0300
Message-Id: <20260512131554.952971-13-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512131554.952971-1-ioana.ciornei@nxp.com>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DU4PR04MB12328:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba96f60-00ca-4819-101d-08deb028b636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|18002099003|22082099003|11063799003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	opQ2eHBOdO1MNlcFH+DZADxDjWKV/40tnhdBTb1PPci723QTxzZ36na9jKbk0hp6jc2DN2tp6gvl4QFF2PSA8dUpv0WvK4FsXTWNYCoDhOjflPYAHooC8ggm2A4pqPi+dDFe9v9/BB5eZFGv0oFBgoAAtPhYpy57Toftqo1mKGSR+TlxMI3nHWO+xBRqhoxbiFJ1vLZLJsmhi3J3fAwE+XvhB9CeT6uCwrSH1t6xHYYLAN6JR2yjKdA9X/zBgpwJsoD78epFHO+oWFMcd2wd2HHkSMen01HF6V/QU9O6Jjat9J5ogf07o8D+JwtfyV6K063jAMksgqkZ+F2igmvPo1PYOD10081j7xPE9pj+SkXhBSMRhPLykkLkAKphZsOtzTVRliLR0IDQFK4Yvb4zrWELLkDkoYhHlvGlbi+SJgAIi+5uOByXFJRI4V+iPvE6gTpVyEcJOjg4QPhQJGtNsvFuwpIF8QrI4FPrP8QJY5ecOMxsJ6FYNS1Q+p5lv2+dyGQxs1gSFrpoLnOM1QGL2iKLEMYoTkART6EH8EaxZpulv+8/zQKiVDC0jqGWGphJJT9I/TcrpzkHFZg561AeOnKdtyDD7OCA0R7p0RQK8zDT85BcFZ9lVwu8LHjHD86UQMJojCN1Bkm7r9GlAs6KAf49NjEhDf90Do+fWl2s6986o7GlB62nnrEfSjLWTcTW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(18002099003)(22082099003)(11063799003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W7EWGBRsPF2y82oZNfv5dLClICFObRl6KtlpSrKLb2XWl2HbBzZROOGAgYSg?=
 =?us-ascii?Q?dwuk5VgmbPBv2YOnja9WvlmOzgObJ3z5/HRPFEJ7+qT7PaA8vEOW4zF8/kCp?=
 =?us-ascii?Q?qpDIT5MKiapzZOi716g3Khg6J7NtZBbOBlLG8q3jx23XfZmLehy6KxvEBtYF?=
 =?us-ascii?Q?KJ2CwQsZAK/z1TH8klE0boxjRU7JQqrADUGSSXLqBdmsJK+epQDNdUYL4QT9?=
 =?us-ascii?Q?H50NQCb4t51whYYJ2qgAo6+1zBdl9ZXa8yhnpi1gQac76OkUlqt2Uv6oyMa4?=
 =?us-ascii?Q?8KkTAn3zK8CUQW4+/jnjE3pYEIqniXL4dr0AUqu0cqmQ2PRVXarkXnGHP8UP?=
 =?us-ascii?Q?o+3IqZaBUNOof1e7dByVvvVzaWzZH7HsIB73gCIV9bg0PyIy9EGw64xyTUBZ?=
 =?us-ascii?Q?fnffLGtofkd0BUDMdFnqvGs9XJK0qDZ7DmnXmWWwhfyka0NSpVhzDagaHVbk?=
 =?us-ascii?Q?KrmR96myKuqCNaPYnAh9B72HcaW7pJyI78VIihuP91IpLP90MWO1o6JHifb2?=
 =?us-ascii?Q?YtByD/6ae2aUvFtOR9em+TC5DbSkWGqzryLEwOJxvREhnDZHDILoX6i2dUJY?=
 =?us-ascii?Q?plFsFdvejdzbn6fOGxvZenHWs3YDJHoKt92NbdFwCRrDT+x6/rR258vhIMCT?=
 =?us-ascii?Q?L2NHOattoDuJD/IZeNCoxXmDUOpvc2vcp4RyoI9GvqGN7ztmThnsRkgahHb4?=
 =?us-ascii?Q?RI88yLpnMMNSX/GqmThzEYIhsO3o6uBjFyZPvPwjmAzZtTbyNyozWnb9vVzf?=
 =?us-ascii?Q?jSjClEejdiKVw8FaTL4l2SJX5YfwEzNF2Ofkh6MILGETAMMF0TkY3Fgu+3uS?=
 =?us-ascii?Q?Ca4QhLP33P3Y814eZGdK7Y9N+ahnPEsZmmov9ubSQKpjWxYX2lYgnDlwM6M/?=
 =?us-ascii?Q?OtonY56EDjb6QgC4suTPpJfEmq6vQyOSbufW+t+aF6g5mRT+sjLSDMW8d4b7?=
 =?us-ascii?Q?EsRQo3o0X84P9aktHzSWdrWRBysU31fI51uPxORNX0KYWdIIXU2IV17qoS7t?=
 =?us-ascii?Q?d3SwBIPLmw+VWf7HyKU0ot3gsNReeexR/FiDEKH7BbwaqEHBdlMPe/2hnCSc?=
 =?us-ascii?Q?5Go1yMSRyJqjyCezLbtW00WwjW7JdB3UzLIeTWB/42JVJoKo1AmI4n5NAF6n?=
 =?us-ascii?Q?e9FfXP9iG5gGS6akkj9cJGqeKEM3SZR9/sLRMemMlZRgEqfua/PThBK0qg16?=
 =?us-ascii?Q?ougr1QoJVDJH6Ao8eAMzOJP9Sq0aRG+//S0QxXORul8wF4+NL4yXnRPhfoYt?=
 =?us-ascii?Q?VW7/su1CBrAaJFp70nAUwsy6tgLarxJ6NePY/G5GzBGK7ni1fbEzpfucwKmE?=
 =?us-ascii?Q?RPuos/hJEgfaAL5UQ0tUUo4Gxjz9MStql/uGCTN8JSNCgs0w5oPDDoSvlNGf?=
 =?us-ascii?Q?WD6B8haAHR53VroqflP5x8Y1uDbMrj68FwXZuKV7kz2lE8/QLQFjlA3Pd+1L?=
 =?us-ascii?Q?5tmI9gucdIIuGxa8EeGdWdW7T8c0sUs12hcWJNIqMXmpkGkd66GYaiWOOy4e?=
 =?us-ascii?Q?n/JnXHFkCeoH4HbOIA1LEN4dHjxnYoXtKTL/oH5xvyDhPkY/G4xhUOjgJ+XP?=
 =?us-ascii?Q?VyLY13PhjpTvT7KXKkCgeSyQ+zghGEcTvuS0crsHDrBoNcll60t82Q1MM1th?=
 =?us-ascii?Q?ghgO3Ejt+Wa0yUuhK6ifSQf1PUPOX2Uabh4CAcdfs+YJUgvnRNv80IVeQ+ex?=
 =?us-ascii?Q?osv9TIkKnl/teXD48aV1yNBOJURdJf1GvC97OI4lAIrxQO4uN2/qiDQcvrTo?=
 =?us-ascii?Q?1BuW5g8Hag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba96f60-00ca-4819-101d-08deb028b636
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:16:43.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2PKsafb1xZlQRLH2h/eXK8ejkA+PdP5ZFjipJGwKWTJMpvKBZ7A1pemU+2DneUjOL1PgDS8IHjeGJxrOmEHxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12328
X-Rspamd-Queue-Id: 6ABFB521596
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
	TAGGED_FROM(0.00)[bounces-287163-lists,netdev=lfdr.de];
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

Switch ports configured as part of a LAG group are not able to provide
a precise source port for all packets which reach the control interface.

The only frames which will have a precise source port are those that are
explicitly trapped, for example STP and LCAP frames. For any other
frames (for example, those which are flooded) we can only know the
ingress LAG group.

Take into account the DPAA2_ETHSW_FLC_IMPRECISE_IF_ID bit and based on
its value target the bond device or the specific source netdevice.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- Fix 32bit build by using BIT_ULL
- Take a reference to port_priv->lag instead of reading it multiple
times.
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 12 ++++++++++--
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 98cf404d4ac8..0acebb386486 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3142,14 +3142,18 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 {
 	struct ethsw_core *ethsw = fq->ethsw;
 	struct ethsw_port_priv *port_priv;
+	struct dpaa2_switch_lag *lag;
 	struct net_device *netdev;
 	struct vlan_ethhdr *hdr;
 	struct sk_buff *skb;
 	u16 vlan_tci, vid;
 	int if_id, err;
+	u64 flc;
+
+	flc = dpaa2_fd_get_flc(fd);
 
 	/* get switch ingress interface ID */
-	if_id = upper_32_bits(dpaa2_fd_get_flc(fd)) & 0x0000FFFF;
+	if_id = DPAA2_ETHSW_FLC_IF_ID(flc);
 
 	if (if_id >= ethsw->sw_attr.num_ifs) {
 		dev_err(ethsw->dev, "Frame received from unknown interface!\n");
@@ -3188,7 +3192,11 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 		}
 	}
 
-	skb->dev = netdev;
+	lag = port_priv->lag;
+	if (DPAA2_ETHSW_FLC_IMPRECISE_IF_ID(flc) && lag)
+		skb->dev = lag->bond_dev;
+	else
+		skb->dev = netdev;
 	skb->protocol = eth_type_trans(skb, skb->dev);
 
 	/* Setup the offload_fwd_mark only if the port is under a bridge
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
index 96d780980d77..d481183e8698 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
@@ -87,6 +87,9 @@
 
 #define DPAA2_ETHSW_PORT_ACL_CMD_BUF_SIZE	256
 
+#define DPAA2_ETHSW_FLC_IF_ID(flc)		(((flc) >> 32) & GENMASK(15, 0))
+#define DPAA2_ETHSW_FLC_IMPRECISE_IF_ID(flc)	((flc) & BIT_ULL(63))
+
 extern const struct ethtool_ops dpaa2_switch_port_ethtool_ops;
 
 struct ethsw_core;
-- 
2.25.1


