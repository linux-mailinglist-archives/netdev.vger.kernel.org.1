Return-Path: <netdev+bounces-275743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI9CMyok1GlxrgcAu9opvQ
	(envelope-from <netdev+bounces-275743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:22:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 666BB3A783B
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEE44303C532
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 21:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD64938B7DE;
	Mon,  6 Apr 2026 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cXDQGkjQ"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AEA38F22F
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775510536; cv=fail; b=Sza3RFMzmqIXIg0EUeAHkO6bL9gG9PorkqRwFAn81Lc3XSlMs9B7NuQcQ/rVD7kcz1iSdQQLqkyVIqw7nv7dc2Uw4HRWH5UTIIrnm3epim3UEk18OiFcOazF6VlzJ5y3D0BJhzwew90QekwzIuCrP7VsP4+iiEIaBQC9yyZH/FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775510536; c=relaxed/simple;
	bh=rAL9uGaJtJPmAdvExNB7gkZ9F6r1bNhqcd2YrSK0hl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ATwwI62GdQ8/uBzZpg7zbeuD+9QlVFaEgSzfGE2QsJF+4Ebe/+6H1oHNSTY6dI6monxlE/orHMfvNIIqYecZSLaqRJZBfsKe42Hb5OgWQHaXP1PbIh+BQTcUCuau0Xb9y43ZiYNh/qGnGeW27T+LgXGuWQJct+ytS0AmoMSdZVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cXDQGkjQ; arc=fail smtp.client-ip=52.101.83.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCQonroFJbF+uaR55wfIHKArDBC4SOakxwTqt3FJBRQW5mtBEKuL1mrXiC+jvUTFU+RKac28UaASTi5gAZmNe2LESNy48PnvYmfHsq4NBxFgcfkV9sm7mIxy/mNjWcxxwtlfPs1Ga9XYv2c+aXHDHENKQELHoENMUFhpv9KwQ4qb2knfhkoiNbmtw5PkqxiUGAkHVIKgVI7tPjLb6rrcdp8eF5197Fw+V/LUCn4dkX+XG9y4RZlEE6UKOhw9q28tx/op2kuSp/qA7gnReCR64uSNc5BZrr9fUbR1KGXdR1t++dmyVULb9o6wcCZ4zF93lIF54O5XTNZmGwm6ohd+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjK7mSJPWHqYr+IlcX83ju2zwzhRAmrXX2EeXE01pbI=;
 b=o+fO2BU/Xbe8tSe9J+2j0iCnt4m063g2pPIxt5ALGP8QSl7zbHfd4YUh+Hw5o75xE5/wA8LsRsJ7PZ6TGQhqwkna6J3Pns0rkwZWxMAA7F/1vIIjlCGdTeD0fMId89ny8BKgZZYrjEl0WP5DG0kXpEk7cv7yxKY0PchAl9q7wrN9P26atnncEiwuJLAmncDlb5fg/az+bSfNZtcNtxKnXF7UKe6RvLgSNXN9YXYbZCQm7j7Cq+WYq884GpZP+LEQqpOds6OmtvM5N/hru2PfUCWzLCkvKe9XQJrRZbeBkuH2gTh4NTr+HTzTb2ND6insdPbq7UbGM5OyPRnzKkCeSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjK7mSJPWHqYr+IlcX83ju2zwzhRAmrXX2EeXE01pbI=;
 b=cXDQGkjQCp2ABO5xkwPYEVrvUQCNY625hZicVL9bdJMgFoI7eYSrij3KVsTVUW4zRsu8xvcSfdUC1KAtz0Es3cKYq3Qb9SUMMl8tpBQPhctLcd8rQcIKSyg2GYplzfbRrt3JuKkd90jQMwUW4PSUY0MOHrCQaz08yEDu5lycIxI+fn+HUf9ZvCtcXRiZVj0VIpbIg8dZMBRZvThtc2hgj7lKL4r9W88V5EkZrrGhHUYwpmyM1xJoFOSnzuqAEUUHPD2dtXYhnQz0cyu3YEgGbe9u0klLAWKU1Sw0aumshfEYHeJahf3K1F0L4O3b+rgiVebwbnGqPELvkMVfeqrOzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS1PR04MB9583.eurprd04.prod.outlook.com (2603:10a6:20b:472::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Mon, 6 Apr
 2026 21:22:12 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 21:22:11 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next 1/4] net: dsa: remove struct platform_data
Date: Tue,  7 Apr 2026 00:21:55 +0300
Message-ID: <20260406212158.721806-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406212158.721806-1-vladimir.oltean@nxp.com>
References: <20260406212158.721806-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIZP296CA0005.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::13) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS1PR04MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc0bd59-53ce-4ba3-5ca8-08de9422911e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0rLfVGMN8bzX6q8bp9p6/1zgKSSGe98tHpXFinYbO369CTxhnMMR4nOi+V60fHXaOTsNK5qYiH1yC3S8EAaAPpJ3GmU9yTeog2RHxHXQCOgncJ9WwWMLzr/t8cTHqxNChFC2aV43huQmg1PZ3h7VdpJaRjgsgRlx7oiu8MrOwvgW4ITvwmQP9RBa5vzeMiGABbD5TJtaatBjGJ9KZO5Tr1EKTMS8Vui2x9Nb8oqN1EMhwCPYHTNPkxoaRV7vaF6TNpFga4BK93h9ykg2ald0BwC869NuQPYE1HnU1RosFuQWjnNek6Bvx/t4dZY3UJ51RwfEBplEY/UouV0A2jyuJNOPAHhaOrABB+wsaDltqnRCAKhf0ZutkH1zSUwr723+o3wXjC/7009ASv1SbWjE7pGR/md0BC0qQ4rmVgt+pxbgmVBvqMZY8l1TmoCCUdaTJ51Qlq8kPO2qr4yrsVTefwdA2t2/Mjvlfz1pZGn6BJAqpSXVSu/+XOuio6jNmSihaQ9c35RV8YFcbKQ+BCWd0IMYAuiyebZduWoX4DhEo9OvrMHn6cCWnEiwtHJsiph7+wrMcDJSA9l64O0RrYQYFDTdfcdjR6zHEJa/vnrqk+HYV8AwlBPjqz8r3CGXDZND29KRdRTyVeGTvyZh/BqOWfs66WTCr5WzbdWv7G4HJzfZJfiUiXD9y81i0pmVzYpY20+ctJRPiE1ZRR8sofgETuVwOojs/eRdbMjcXc/xWtg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fVtpSkctIfC2l8G7kWrrZCcBLRfCZ23hNe0nPbOZJlGPpmJrYH3HRdw7nJUh?=
 =?us-ascii?Q?mjhdqTxMZtVJsoKcZ6NDno9uaaWXUH1KVwXHgGzjtXn0gdmtLkjq08pP4OF4?=
 =?us-ascii?Q?hAF1OvbQ2j3mwN9y0KDKA1c6nLwTFs8Ny+A53j1GxRAKpSxpJQfD3bvMpDqs?=
 =?us-ascii?Q?wZFVrTawYdh/qLY+6pB/Z4kSdB9nYQK0lUNtcPDqSaLSm92/mtgYfYs6aciN?=
 =?us-ascii?Q?wJ6FgOsvggX9JjWZXX5vLvgsEuM3qAdVW8ZPFBAP8APqV22Vr5I9JeOtzTdt?=
 =?us-ascii?Q?LOzmu7VaRiBSt06wzeUXUjDHXNrOa49Z9JcMSCC+Fd9++TM/zEvt8X4PwngW?=
 =?us-ascii?Q?Wyj5v8i4LZCnkLFwXKaUUaKCi0t/sjZw8nfxjP5DpDDeYi5LB4cFctwVEL1F?=
 =?us-ascii?Q?/kcuIuqxgOSNX5yIw4iTSyzP28sJ8KN2Z1dT+9Lb5GI1ueH9fJE6grEbUYJl?=
 =?us-ascii?Q?ebvs7IQScY5BDl2u9d0JCiIAiRUSNMd3zotc48wtnrCnHR9jgiHrSXacbHmD?=
 =?us-ascii?Q?sjRHd8qO+8b5LfPWisHtUsyBSpdThNJHGMF/TwxaOajdUnOKaZu0tp+qlojQ?=
 =?us-ascii?Q?pR+jHEsOkvCZ23YrJ2f57VblFHPPAslRMDzVL9Gv1J1eFr6dE0mcqYkhs6Jm?=
 =?us-ascii?Q?Jap7KN7af1IG1KEpKLPAN0tTgdagModTe1mwFk4tfyI1/WjmofJDv4e8LEi4?=
 =?us-ascii?Q?ty64ydUcSLht3TptJ7uuNJkupAug3bbfxjIQH6dOcDMp07j6FrybX9gjXc24?=
 =?us-ascii?Q?chtfXtPqLukZV2AeJ3I/gBdFYiN9kD9Cnb7ZrX/w+XfG3nFAV7AXzVBpKetk?=
 =?us-ascii?Q?Hp2q0h3ZJxnm0OM8DZpLiz9Q27lOHEIddCkqS/UiBcpgyGxs6WYyt6ha6x6W?=
 =?us-ascii?Q?ffVglnd31+G/bjkIULn4Laajbh9/JrIzoWHb0Gt9xMRf+cSYBw3rv8Ar+jBI?=
 =?us-ascii?Q?dm1JSj51HWT/X/GwY8Zy3CQxhZMw8mtMgHTgDajE7dGWkbR2KiGYrB69bRZS?=
 =?us-ascii?Q?U3Cqq6BpvgXkuP8/ziA1swhSDS8r9SBtyTFsd9JSrog81lmR10s1O9FgnGW/?=
 =?us-ascii?Q?8teGSZbGwCWguq/Nkg0u67mH5zU55egK8ydoPJZ29V4/yPl8crbKkOUAmlMO?=
 =?us-ascii?Q?gPsFzRIt37nmUay5+L4J8xqCEDmVqE+93/3kQGmMxmLQNHshPokGTjFaMXw+?=
 =?us-ascii?Q?1i1kw49/3fUIZn/R1LcpYTEDauZRsJI6xmv2kODqmYpTuT+p5Bg2gxa4sZaH?=
 =?us-ascii?Q?ignRNKfyEpoB4CRbccO+N30wXd2iZZgplkhY1j+UgezxHz3GJCH9+QBQ4+ni?=
 =?us-ascii?Q?9HoLGu+y4ExnSsMuABZhBYc0g+GHnDPiu2XP9yKPa7TR2kTfTdy4a63MRhDc?=
 =?us-ascii?Q?1okJ5+bn1nZkAl6/9kuWtjz6g1dcTK0RuqlNe1/BeC7TLwg90BhvQmIQ4jOZ?=
 =?us-ascii?Q?8p5hq0GfKoCuNit2jRy4xTexVW/5l+BmiiVpiUUwe6vgz71Cch+PJZ7uJuXq?=
 =?us-ascii?Q?QIWLXkSAJ3AIkRd8TJEjniumCnC/rYujKlJTG6EmV+E4QVAIF1pLUVLL9QFK?=
 =?us-ascii?Q?K29D7IZGg/jqwQPfd6NEtvxfgeimUY1ta9T/rxkR432NlidJgAKi3TplwrGM?=
 =?us-ascii?Q?9IBQMrytvbAQHpdNMB02VHtQkp9a3sNpbrIGTS+Y3weg9AluhFupsmJiD64s?=
 =?us-ascii?Q?tqY+/ME0qX7TBUN8ecLVhMYzqbp+3TDl1FV261JJ1DBnq+DCr0psdOGuzIzO?=
 =?us-ascii?Q?miYe++Jxi79J5ElUhRS5oRVUfWXMvjBBJICxhjSgAhxoE3fuP2Eayc8gsQds?=
X-MS-Exchange-AntiSpam-MessageData-1: Poef0zbw8tSc2Rnh5+4WZE0hjgb9iZ13Rp8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc0bd59-53ce-4ba3-5ca8-08de9422911e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 21:22:11.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnoGFMF849IqtAzAYVZ3hdt3X6cp8O91vgKhGEVJ0hM2v6TaB4Jb9YptxLDfgnOXo1n2DcQ8U1NwaYkNvW6gtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9583
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275743-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 666BB3A783B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is not used anywhere in the kernel.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 Documentation/networking/dsa/dsa.rst |  5 -----
 include/linux/platform_data/dsa.h    | 17 -----------------
 2 files changed, 22 deletions(-)

diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index 5c79740a533b..fd3c254ced1d 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -383,11 +383,6 @@ DSA data structures are defined in ``include/net/dsa.h`` as well as
   well as various properties of its ports: names/labels, and finally a routing
   table indication (when cascading switches)
 
-- ``dsa_platform_data``: platform device configuration data which can reference
-  a collection of dsa_chip_data structures if multiple switches are cascaded,
-  the conduit network device this switch tree is attached to needs to be
-  referenced
-
 - ``dsa_switch_tree``: structure assigned to the conduit network device under
   ``dsa_ptr``, this structure references a dsa_platform_data structure as well as
   the tagging protocol supported by the switch tree, and which receive/transmit
diff --git a/include/linux/platform_data/dsa.h b/include/linux/platform_data/dsa.h
index d4d9bf2060a6..fec1ae5bddb9 100644
--- a/include/linux/platform_data/dsa.h
+++ b/include/linux/platform_data/dsa.h
@@ -48,21 +48,4 @@ struct dsa_chip_data {
 	s8		rtable[DSA_MAX_SWITCHES];
 };
 
-struct dsa_platform_data {
-	/*
-	 * Reference to a Linux network interface that connects
-	 * to the root switch chip of the tree.
-	 */
-	struct device	*netdev;
-	struct net_device *of_netdev;
-
-	/*
-	 * Info structs describing each of the switch chips
-	 * connected via this network interface.
-	 */
-	int		nr_chips;
-	struct dsa_chip_data	*chip;
-};
-
-
 #endif /* __DSA_PDATA_H */
-- 
2.43.0


