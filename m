Return-Path: <netdev+bounces-297574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IIl/ACUzKWoRSQMAu9opvQ
	(envelope-from <netdev+bounces-297574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:49:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D041667FD3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:49:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=FuZlUCCk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297574-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297574-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2511730643AD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0AD3A7F45;
	Wed, 10 Jun 2026 09:46:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013048.outbound.protection.outlook.com [40.107.162.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703823E1D19;
	Wed, 10 Jun 2026 09:46:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084807; cv=fail; b=ealg9fTHarp8b7shOwIz/m/43k+Fal90GHMrTzTG+hUXZTnDj5IJOh0dOwMwMn4t4I8QvGTceaaKQLqLJA0PHj9RQHCaEvhSqGG2mh6pO+J7l/Llajs7wrRJYqY4RLBW14QhzYoCjHL83TtttwgUyVaBpn9pLw+Bc0zhWcAOzck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084807; c=relaxed/simple;
	bh=daB8e3udYGoP+kxJa21N9AAiNCqOMozYuq4NYP0tgZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V6s4vAY+TVwnv8dySVasHwXwaoeobGZyvAs6MJRyKTF4k3/64IgycBwBm68/h2ko4jkxam+3AiFNH+cDRuWFkC97D+YhkekNlny6p7zdYF0rfvOWnmpqdAmXjGGi2IrlQFA2lZT0a9J7pywtRucbqVuz4A6vL0gUt8Vhtf8iAHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FuZlUCCk; arc=fail smtp.client-ip=40.107.162.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sr0XViAjPniO3nGDEo8UhjleW8GbND+CE+9D+5aONDNBeBUInpPXpL97MfnZONrV+TUn32aXVkfmWX+yD8oXI3yZFW7RL9D9kra6XlVaQOWaZN+AKzRmHJRe9pSQktDO+gtYwOaaSfk8ytZOqVc1s/mtCo3u9yY0ajBWliNhFenpKgCPK8cdyr1ya7QqhbFVknKhs7+2BRz3aoVTspz0w/Qnt8ksNApj9drCuv+sMZ1uGE4sCv+Xbo7z3sHb2jm3ZAYcpQLWsaQfBDAZ+mJ4IQ6m66kvjh6yycto2ysl+Z3fuCYYMk7sQC+x6ic/gRSJ1Hp9zvpsIuVeJmrxDRbWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHV84roRGfc1MJ81KYS9ayDqvDccfU/JH3t6e4gnlhI=;
 b=U6lyHQ5nziQ8ofZeMcXyjz9inVgoiKKESlqMqLieMewyWw5dFakb/3b3+KKzEGcURfqT9kzrjKnESv8r7U4YajZwuVbT7ItgHzBCysPKXlgMd1UkNIKgPEl6Fa7IUsUA8ZhsPUcyn/fvSEBLF/YInZmbgBbJAVZ9J7VQrnb5SXZx+7jpuAq8AzLFzd6LdastBUjX3CBrxG/bOQR/9IVVdgvR2Xd02Zs+aqIQS5EscHTSQuIzLKbmuoWAMBiyPagGRxFmtAE4qvIvhnQKlT2vWPsShNlCBfixOiCoggQeLvx8k2+zIv09zcJPYWFEuoFSh4TWsCWyH9BZkwRXgn+UJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHV84roRGfc1MJ81KYS9ayDqvDccfU/JH3t6e4gnlhI=;
 b=FuZlUCCkvZHfTolGc8OfjMvuY6cznb01NV+mKy/ApZsnOOj5+4TZ4+jXBMosLt+fSqbQcYqC6ZAAIWDkkw1jjJtiRodIDzI0IwE84NPk0eAhzEArRmPzZgCwilngb+ZeX3AggfHS1ouGO1wF0JExRaJj3BeIRaBV8rjgIC02oVhJumuRFwXU39/Pb+fkMKYDvneULAGijF5wRVDEJbb2eznrqTX5NgFnFey+RGfBCYeY6chOjZs09GNqFrd7eo9AH0dKEVTZy3i6SRr/IE1MnlThXdAr5MMVC8t+ea3SFJyXdwtRe9VxXf63VYcnYCGxpsmOFu03I7rupKv0l5sU+Q==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:46:42 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:46:40 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 07/15] net: enetc: add .ndo_set_vf_mac() to the enetc v4 driver
Date: Wed, 10 Jun 2026 17:18:36 +0800
Message-Id: <20260610091844.3423693-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
References: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: e92b6a78-7747-4622-941b-08dec6d52c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|921020|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	4rZht0hfrB7gPjFq6rtFsQDLleiVbav1AtvGFXstJ7qiXrLJ2/77ZXkZuVoEypaw0VB6II//t9A2VmUMy+7efhH+0TP1cOJhsZRRoD0Y2eQ9uwn3236u5qKta1cy0XuZn3aeCMU6dOVxGpidaWa/zKPyLTnCbdKMTcwiyL4Q968FOdC7uj9rCbH9kJ+s+Kj8POHYtLjMKrxqaWAz24AhgluGLx4oTkYXLBaUfAfmo1RsWECMnQHlDjoY9Vy7mLWe/kPeCrIjOxoclCwx6nZcgHW7M4H5NfjXiVxyQYyy2pfeJIjh6ut6AkTDRW3286kIO7RvJV9XMWrZMXGSNvcwzOo/EUgbz8RHJrrNDzjEd9THiXhfPpLegVLiEkIV7VFdo5Hparfig+p9Nbts4Dso9VxikKIrNHHhesg//jJXgdNmq8zQJFXRONqyPX/gkfnNAUOr+OjXGGyMTug465pRCWSy4lbEBYXSN/VTNV78HP7Cj/E1QkzUtwQr/iFS4JEAmPargnT9wYTp756BKCgtci5Bl6dKIfH7wgTn7G+lVErNakPUbA+KbZQ0ykAZE+YpyrOIfv21yVaDXHJ8wP07WKUjzYodpZKYPPtvF/2SoMVnVLirN69A3HIeBe6hfhnGJ20LlUBq+5lt/L2S6Ggx3PDAmma460WUOUYbMtt2bv7QzVAfWHmzPA1RXHY2W+d/OywYLuxzk8+b6XKWn7veP86DJ/8IpMFWkHXMaPLH+N4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(921020)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9/FGUuAGJL+rn/OpOfwQyxxFUWkPsE/fmL+s30ydzb31T1SI/rf+azzdmxeX?=
 =?us-ascii?Q?nUbSwYgcuseQ3cv25wHNF7F05sowojBdGD+tGLro/rNcqDs4ZTz4kqHPNy0a?=
 =?us-ascii?Q?Fe7mJ5pKYbvS09l6J31AV3reHUzOEWmQSNbvlu80WV6QN+Dl/SW/B8zOCit+?=
 =?us-ascii?Q?owdpeoULzeHnfbLXJmGJ8KEWExwEYoMpvIjiHsbGB5xr1f1pmhXTvSArbJBI?=
 =?us-ascii?Q?M63FDyFUJNJxBGDZUMTQPyRpQQ9IpSBDLwxFVTlx15mkHk+GX7lmhuv3OpfY?=
 =?us-ascii?Q?W2GXfmgIQtIcPsI0V0OKkeGnXkkg1bZg6qPgFoHLPsAO5zwYnPbmLxRHJhju?=
 =?us-ascii?Q?63E7KtjWX4WML362p6h4bkdGQTOA+o6VceYbU4q/swjfiaTTrj4FiDnXybi/?=
 =?us-ascii?Q?xhJGy/B2SrHAVFZ9Pn+NV60rzf+X3XuRaBBxGnQ2UnC5JORnb2fxdcQKz0EC?=
 =?us-ascii?Q?ZyA/NmzqVEWW2cHaKYdXUfLCqMEqmBqs7dpUJrhyPEAJLJuv6ogAubAGDluR?=
 =?us-ascii?Q?4QU8thjWiQYArLFHAfgj0f7jXc5yZqKIMmdoaxJX3mIb4NHnbJKbrKCKc+yF?=
 =?us-ascii?Q?eIJJLgfgaLUqlLJW6I/pTRF7GZV4t32p2H25ZZt23G3QmXpsYTnexVu5Y11K?=
 =?us-ascii?Q?AuyRreSh+JHY9rxLjGNjyjKyubZs16LWTZO4HsVVPphZkgAMq8wtEMqGjfbj?=
 =?us-ascii?Q?u91OzQK0oKRajkrDx6us1eD7eM5jlHDpHRTVMfcaMu82VLUBKXS7oE82BLut?=
 =?us-ascii?Q?0MHDCPs/cur9eWlvfsn8H/WZJGOSxr/NSUdeypN1vR+2Ty1WLjNPWie9uZ5b?=
 =?us-ascii?Q?nKCFHAxMcjAAcFhW+f0EONEy8kEfl4s6AKQvQ77lZVKampmZmcrW6QsfEryr?=
 =?us-ascii?Q?vKSfs8tje/VTN67LEYzzLZSlT5UejTq4NHYCioqS7knwI2Javyuq2wp1IU36?=
 =?us-ascii?Q?CeKKnGhwLUFUrcO3mR1oS6lQyuB+WkfzA9MpGtVJ56XCyXaAYA788XzYGF4W?=
 =?us-ascii?Q?OdwSDi1LDDOQBAUzIYqSJ6q9wvzJiB7Vat0LbxwloAbb0I361R2/GfR2HKqu?=
 =?us-ascii?Q?ZKPVU7Pv/wBiM3O78/AUoI27ClEXJbkxkv6XAL8pH754uLl5w81jO0P2vUKg?=
 =?us-ascii?Q?0WKRvjdRrgcDF21HoN4vPzaNS2JOJNNRsmDlGtNseSSVceApbSR+rCNs78iM?=
 =?us-ascii?Q?cfSvlHCDVKavFAWc+gq0aupS7/vMbPxz1kLKDIxdiWcZ3j9Bg5w2u6E1Ij+Y?=
 =?us-ascii?Q?sOvuIho4LQWDOlKnh0L5/zfwPK/0NrLBbpvCFNlrD3x31L5mT/mvLt8ATDJY?=
 =?us-ascii?Q?JTaPEeNIsniX3aPkSqncezUK59VBVmX1ccoDBlf5VUgCi+DrVvv7+nAGNpM6?=
 =?us-ascii?Q?frwkxJjupYWHrhHjEUbftcC7l16xwLNTUHkHhcIol4+lgfQl4ShpVtzNpdJj?=
 =?us-ascii?Q?p0+5qkMol+G9qT5fL2D8tghplqxoMNIasQagGopxCH5U3KiwWLPYX28xpEV9?=
 =?us-ascii?Q?WrEW5ALKV8uBDUTUyZngv1tlZ1wkjc3zSUi0lHCOW9UV0kqS0/DoIk8FDEzF?=
 =?us-ascii?Q?mcxFCO4K04KCDnunFWNjZfIQ64HTAVXiE9Hj7/srtxujxNgrwwSn24j/8bqY?=
 =?us-ascii?Q?BBBhU9P0fIf+vDqbaqHB3Jyl9Woc0qHjOMv5sZrgs+MlHztMhcziQSTQFJ5b?=
 =?us-ascii?Q?iaKe2YnjVogojImFNZd3ikOovYmk9v8xP1bFDfmq/AorfpYbF8lf8gh5q2aI?=
 =?us-ascii?Q?JtYcwbshOcBtBa7INOc8ayXextY1NPFiihfSG9/6T7qqcmI+LW9p?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92b6a78-7747-4622-941b-08dec6d52c67
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:46:40.9539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJPBJuc7ea2O1XormillW9FXKpcTToUF/oNvS9vJlUBkwUs2VIf8KIrcOjujU40T5gIL94W4KyRPRt5Rj0IiEepTEow5FxHNsDovMHciaPResMEAuv5oxEQkTMDjvM1j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297574-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,NXP1.onmicrosoft.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D041667FD3

From: Wei Fang <wei.fang@nxp.com>

Add .ndo_set_vf_mac() to the enetc v4 driver to configure the MAC
addresses of VFs.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 4b69c19b2319..d310506a6fd4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -575,6 +575,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
+	.ndo_set_vf_mac		= enetc_pf_set_vf_mac,
 };
 
 static struct phylink_pcs *
-- 
2.34.1


