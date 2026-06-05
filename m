Return-Path: <netdev+bounces-295685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CxghOm56ImqMYAEAu9opvQ
	(envelope-from <netdev+bounces-295685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:27:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A5682645F6C
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:27:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="cj//kAjH";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295685-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295685-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0BB1304FF48
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D28477E48;
	Fri,  5 Jun 2026 07:23:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C036478E33;
	Fri,  5 Jun 2026 07:23:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644197; cv=fail; b=ayJcPwRR4cxhz6a+JozxOn4JCrV0thxe4+6CEK8yHNLf1JwIufRScavLR5ePm63IgtF6LNM6Wg9eyd1cpGIybvlVXhcscKpsklXZXu/vMIqRYKa0XwW9KIlUOS7F0//HARa6HG88lNUPrcJJDIaKZ1BBF4kYjCcGkANc7uETkwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644197; c=relaxed/simple;
	bh=uW59UTzj61n0LeP2s3LJNdwAjd8D41A1iJN9kocu1Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mGdz+813A+I2jyw6x9D+8m6ogVSsT1y4PjP58TwZguhVyGBNixVbrmJlNmSSwmRWqBBWDYAt6jynRdsL3WFPleAtqCss9vldU3Ziw5+rotVDSQ+RPxK364y/QDnjdi7GpkWNdUjTQ78CmP3b4IUJ4Gt+rzQLNQhG6bRW+q8yR18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cj//kAjH; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdOFylKnVYMp5qNd0/+OWxcGfIhX04Cbm/xPoFb23dtKbliG5IQVM0VcVMB7lyD8zmcNzaCO0B674iVXm+Vki5P3Nkd/k4M0wyCbIqvGYMH3hFJtpss7QtuGt6kawtTbSdIpj7Iplk1813G03tbst3fr/An5bB0O8Js0YJ/GelV5RX6Fwar4HkLA38US5pm24k5jpVAFhHivndVplEwKJ89yEYbsFOip009y8/auQ5pO0RQrdO68IBbquy+tXKTUNfdZxeQiLhdkFC4xfkXR43DTFJpBKyhIf3W5WRibuwosJUIZ8aQAJlxDuocF8jC9NqKdAEPkewCTxa62NdD9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSCu6wu3qeFShYvuhcKYDEuR2Rb652syIrk/Hv573/8=;
 b=TO+7GCW+Iiz2iM3aPYrbpH5ScETwT/ikC8zyDhGYEQuVo4chuPIUdUA/xATY5SVkugUoVWfY3bnMpuxGf8CDv2nxCbPc3PRbJcZM2lAIIAn+Lp5sSlPC+rQ7oSaLkkAfcL/lU6BBU5AROg8PXVE5c2lP04hYjlwDqTgDY7z+t1nbA0nPg1pT5ppvF6mmJwtUEjuN6y+dAa7uLnUtiIbovcBvBSmKegu5eNlak3eZIgVYo1HxCn9ZKsR3AcqsVhWuOSYsuwhCm8cRExWs1V/XK0kOz6j99i37Sq338ZOa83skCcyM/zJUCq78mtc/W31cNRhuuuFyK/o3F37VHlsPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSCu6wu3qeFShYvuhcKYDEuR2Rb652syIrk/Hv573/8=;
 b=cj//kAjH1qfaRMW57EWtpDRiiNYViilgXxBBpzBYs+BvAuPYO0W9tbjPtgK0pY23zI312yA782IC8Wqczzrom4M38nXzfY9VRKwHLu7TW1N7A3gSQZIiU2/E+cHEsEFvUFciaPS+LAJbudvHVXja4ELTeUN42lrY6MbizgbpXJEoOI0XMAQeQzvuOJ6I2+LuPjDULsmHqMTYV0REnM16uYwVBogq3g8wNRw91fcY9xx/d0afM9yFsrpn8QsU45WQpFwnymGUq0XHGZc2QHMyWojmlhtyg1uDCvjBvIREh7AaI29uG8UlhsKs/OxLrhEcXCRMwDlWoAJcPj0hbrnx8Q==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:23:12 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:23:12 +0000
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
Subject: [PATCH net-next 03/15] net: enetc: add link status message support to PF driver
Date: Fri,  5 Jun 2026 14:55:38 +0800
Message-Id: <20260605065550.3038579-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e65603e-170f-4c39-6128-08dec2d34d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|21046099003|22082099003|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	TYuwrG/uOsZQTOXgBayyW5wJGWxRf5M6DaykBxqqcW03xw9ngb5aU/4nQ0EVG7NjFcJS0HjnLgqUzXdgJNyouwaGRKO7cqmObd6VA9tle+n24aO5Ltjr6A5iV8pRTeVBo1iiElGM2iTJ3jjjiZoSdG8h2ApRTjidmg7omUht+llmOm4vpLg242jKeP40mU36Nb55mK9O68bGD3oj/fbRCzkqUPOHjap+/yLj9ywO6O1AP/tSpQ0vM4FLHz7CHHP67dGkaaiW3+SS0BRcosxgWI/huu8ruCDfDgebfVZ8bezd4UJJ9G5wVaZvxT/h7qVLrqIPIZOeI8rbLC4vMt+ZJfsBH1+t6BmddS9SPXrMkdFMK3Bbsc+kDKuJd9+a0iVxm6y+yWFyyNYPnYwJySPG0WvvOGuwIaZq2ltqkuT8us6UCuzY2Hgnrk7YbGaw2tSx/d58oTmVeTlYKQFAyOKL5lMK0+8OuB149iOd+jDKWBCh/NCb/nhu8LgtAkqoVws60pdEw26y09kYDUBw9efsL7Ixmyk7Pp5lVmQD52sGmqi90qc7QU8yykVh+8plfH9Fx7nd5koMJvzUTYMhFQAtkBujV4aldJKzuGlQfEkkSD9oAj/XGgmZ/q5rf5MHa43OQaOsQohyJb186lHIKb5VTwX35iuhXS7favI2Pqn6Vs6QDdr8nRZEVB+JpHF/KHDq7v9A0oOdJBcrryN0MfmpHYldvndcNBlRxs/XW3bXJJw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(21046099003)(22082099003)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yV/ks2TnjJngqyL6D2+oZv/2KCicuw/mSeEEt3LSAcaWDKupiYW7jC9sTwcy?=
 =?us-ascii?Q?wuANycdH1yt6WTJTz3qDht3N6HTtkauOk9FbnPLFIn9b13yaW7/b8ZSpnbGV?=
 =?us-ascii?Q?7IiNzlHkCMkqoXUwK3S0Wvedquo1bc34ZtHMhl/LnoIpoGL4NjERLBvmkQah?=
 =?us-ascii?Q?AlWOf/3cGd2BOEAYajsQ1S3ONEYZC9CZ036Dpfi9AKafUJeGQa9dJgjW960q?=
 =?us-ascii?Q?pixp3wSk6hIH7JLdbYVjUodfzXmRWF1UdN4Fl+21b1FLCl3uG/a0Yu+xBsI8?=
 =?us-ascii?Q?rUpNNZuFcm+5dDg9yXXpdgcn8kTBaS+8tLKveQkwvGvtnxBXUW67AA5yn3/t?=
 =?us-ascii?Q?DXnuIANDAIrYqoQbQnXxr8X5tj419nvGxzWKpphwIS2fhjM/Yn+LjDxLGR0j?=
 =?us-ascii?Q?M7zHFemSudrRUmd/MGmUvJ+pD56UW7EQl/oTJ4h/IKokr3xHQfju8FsDWYmJ?=
 =?us-ascii?Q?mVj85t4nuZDy0thvV4i/rTDdPLHLetFCGDFxv9k71ba16gbDIRICGJsJ/2GB?=
 =?us-ascii?Q?Ef8u4H1U2Adrf1nUGP75YLcrTDoyGt26x3aom0P+zyBJNvPPg4dW/d5dBNwL?=
 =?us-ascii?Q?LSt6QF4kBUTnm/8Y/uaKxVM9M6ZjRDJI0PuwfRVOeSos1nsXcJd+WPixikkg?=
 =?us-ascii?Q?LJzM4lNnkJ4bW8lEv83b0+lLRLM5cJ2wL2E7ZWZ7DW7ZqlABQ0gqQcoj0FMs?=
 =?us-ascii?Q?PjpKvmJPn6pNqzm+PdKzSrRetse/ZmThq5294sZPJC61m0MHeUtEpkROhP5X?=
 =?us-ascii?Q?Omn9p7U8s7ry0KjbIiAx/t8wNAhwXbU/AFsrYl4/jZ8MHGr73bGNNyYDTo/D?=
 =?us-ascii?Q?dnaPtcfmzhnx8ezFrNjwewG9Mca3QfuVW2dTyPkaG/3QgdGjyy2KAHV2SYTr?=
 =?us-ascii?Q?Rv/1NhRSQMp5jmOKJcUuo7xxrnKsuuQHpyGRuFtVjjyjfxgYa81qtj68ZMU9?=
 =?us-ascii?Q?pyvTo5fpgw1GtfrpPFTUaF8eDJhTRm1/RvzgGeFbWByIl3IuGuZa2QLhgZ+F?=
 =?us-ascii?Q?wOgDyUEOYp2cHz8c9qHRpyAgWVUUzuvKkbLglg47qQnevjjp6CZg3ll90HZw?=
 =?us-ascii?Q?wIjDPhxFP7Pz/LLtJ4bFDBydu6tQ91221JvN6bphMlKBjSKzVI2rLJYUcDa0?=
 =?us-ascii?Q?echb2P9KyjXz5Hk3PmTTkjW03qQItJfOAn3gF10x51Q76ByqnIv8CSZf0+Bp?=
 =?us-ascii?Q?8++rifmYsCr4yxJLTrzx8tTtEPkUvYvw2lDvre2GLOQUx+1L/nal98oUhMbp?=
 =?us-ascii?Q?YEH9VaDObpAg88R9Dqlp8G/vYZ9LcrrR4QX/C6SAebNca5Qb13RWDpKT1DjZ?=
 =?us-ascii?Q?Ke0hiIsXd+dsAEZUH44S+z4ocuxO+YPgA7sY+0xp/AyzQRxtyyJVqbAS6u84?=
 =?us-ascii?Q?dwdHtH/1U9/xXJ/bgLqDJNFvII/n9UsHETmBqATkiVmv15LooR3OmKYuw8hb?=
 =?us-ascii?Q?B28Q+nhgQ6m4bOdRrK9Qt6hf5838JniZyxHUIRoU7cVEd14KIX+UmiMjYDH9?=
 =?us-ascii?Q?DGVxy6qKfqvC+v6KxD7AZeN0fU9kVC+xx7BVYi1lhOR/arp5pNsTQiN7u3l1?=
 =?us-ascii?Q?dZPCUthC6sQqXDNldnqKUIlDA5VQdo6m/TlThu9NCFKdMENl8ciGXcfAulew?=
 =?us-ascii?Q?GwzxtQ9Bu3z+eDR/v57P7YFgCxRxxZgPw175jdFzweuvlY+7J8TpaDjzk9R0?=
 =?us-ascii?Q?a7i75JuJQNIMs7z4ik73D/RwYae5KfY9TZ+nE+Z5HdUlXfN/EVsylss9uK3/?=
 =?us-ascii?Q?lz12Co+0lrbpQjiUOEsvyVT2yf8+C8H+MGwBgq7jsnNCgbZXnn/X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e65603e-170f-4c39-6128-08dec2d34d57
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:23:12.6105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWFuC9C0qpdQd/qwMEYs98/GHMKCwECBppHZrW97MldSKOE4XFNuoC0eRB8Fcxnud9ju9iZdxn9SitACf3MRrk4mMIarjngVci/bl++dG9yLrLQgYhgGltnRY/iKwu20
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295685-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,nxp.com:email,oss.nxp.com:from_mime,oss.nxp.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5682645F6C

From: Wei Fang <wei.fang@nxp.com>

Add link status message support to the PF driver using three command IDs
under message class 0x80 (ENETC_MSG_CLASS_ID_LINK_STATUS):

1. ENETC_MSG_GET_CURRENT_LINK_STATUS
The VF queries the current PF link status synchronously. This command is
not used by the Linux VF driver but is intended for DPDK-owned VFs.

2. ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER
The VF registers for link change notification. Upon registration, the PF
immediately notifies the VF of the current link status via a PSI-to-VSI
message, and continues to do so on every subsequent link state change.

3. ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER
The VF unregisters from link change notification.

PSI-to-VSI notifications are sent via the ENETC_PSIMSGSR register. A new
msg_lock mutex is introduced in struct enetc_pf to protect concurrent
access between the phylink callbacks and the VSI-to-PSI message handler.
The bitmask link_status_ms_mask tracks which VFs have registered for
notifications and is cleared when SR-IOV is disabled.

Two functions are exported for use by PF drivers:
  enetc_pf_notify_vf_link_up()
  enetc_pf_notify_vf_link_down()

Through this mechanism, VFs can accurately perceive the link status and
report it to upper layers such as the kernel network stack, containers,
and virtual machines.

Note that currently only the ENETC v4 driver supports this feature, while
v1 does not.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |   2 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   4 +
 .../ethernet/freescale/enetc/enetc_mailbox.h  |  18 +++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 152 +++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   4 +
 .../freescale/enetc/enetc_pf_common.c         |   2 +
 .../freescale/enetc/enetc_pf_common.h         |   9 ++
 7 files changed, 185 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index ee52ff929576..ad211eefd9d4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -940,6 +940,7 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	enetc4_set_rx_pause(pf, rx_pause);
 	enetc4_mac_tx_enable(pf);
 	enetc4_mac_rx_enable(pf);
+	enetc_pf_notify_vf_link_up(pf);
 }
 
 static void enetc4_pl_mac_link_down(struct phylink_config *config,
@@ -950,6 +951,7 @@ static void enetc4_pl_mac_link_down(struct phylink_config *config,
 
 	enetc4_mac_rx_graceful_stop(pf);
 	enetc4_mac_tx_graceful_stop(pf);
+	enetc_pf_notify_vf_link_down(pf);
 }
 
 static const struct phylink_mac_ops enetc_pl_mac_ops = {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index bf99b65d7598..37c6060ccc82 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -80,6 +80,10 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 #define ENETC_SIMSGSR_SET_MC(val) ((val) << 16)
 #define ENETC_SIMSGSR_GET_MC(val) ((val) >> 16)
 
+#define ENETC_PSIMSGSR		0x208
+#define  PSIMSGSR_MS(n)		BIT((n) + 1) /* n is VF index */
+#define  PSIMSGSR_MC		GENMASK(31, 16)
+
 /* SI statistics */
 #define ENETC_SIROCT	0x300
 #define ENETC_SIRFRM	0x308
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
index d9677da38989..43b9ee2ab3e4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
@@ -107,6 +107,7 @@ enum enetc_msg_class_id {
 
 	/* Common Class ID for PSI-to-VSI and VSI-to-PSI messages */
 	ENETC_MSG_CLASS_ID_MAC_FILTER		= 0x20,
+	ENETC_MSG_CLASS_ID_LINK_STATUS		= 0x80,
 	ENETC_MSG_CLASS_ID_IP_REVISION		= 0xf0,
 };
 
@@ -118,11 +119,23 @@ enum enetc_msg_ip_revision_cmd_id {
 	ENETC_MSG_GET_IP_MN			= 1,
 };
 
+enum enetc_msg_link_status_cmd_id {
+	ENETC_MSG_GET_CURRENT_LINK_STATUS,
+	ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER,
+	ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER,
+};
+
 /* Class-specific error return codes of MAC filter */
 enum enetc_mac_filter_class_code {
 	ENETC_MF_CLASS_CODE_INVALID_MAC,
 };
 
+/* Class-specific notifications/codes of link status */
+enum enetc_link_status_class_code {
+	ENETC_LINK_STATUS_CLASS_CODE_UP,
+	ENETC_LINK_STATUS_CLASS_CODE_DOWN,
+};
+
 struct enetc_msg_swbd {
 	void *vaddr;
 	dma_addr_t dma;
@@ -161,6 +174,11 @@ struct enetc_msg_mac_exact_filter {
 /* The generic message format applies to the following messages:
  * Get IP revision message, class_id 0xf0.
  * cmd_id 1: get IP minor revision
+ *
+ * Link status message, class id 0x80.
+ * cmd_id 0x0: get the current link status
+ * cmd_id 0x1: register link status change notification
+ * cmd_id 0x2: unregister link status change notification
  */
 struct enetc_msg_generic {
 	struct enetc_msg_header hdr;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 8d4d0689807d..c93b4e6913d8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -128,6 +128,113 @@ static u16 enetc_msg_handle_ip_revision(struct enetc_pf *pf, void *vf_msg)
 	}
 }
 
+static u16 enetc_msg_get_link_status(struct enetc_pf *pf)
+{
+	struct net_device *ndev = pf->si->ndev;
+	u16 pf_msg;
+
+	pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+			    ENETC_MSG_CLASS_ID_LINK_STATUS);
+
+	if (netif_carrier_ok(ndev))
+		pf_msg |= FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
+				     ENETC_LINK_STATUS_CLASS_CODE_UP);
+	else
+		pf_msg |= FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
+				     ENETC_LINK_STATUS_CLASS_CODE_DOWN);
+
+	return pf_msg;
+}
+
+static int enetc_pf_send_msg(struct enetc_pf *pf, u32 msg_code, u16 ms_mask)
+{
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	enetc_wr(&si->hw, ENETC_PSIMSGSR,
+		 FIELD_PREP(PSIMSGSR_MC, msg_code) | ms_mask);
+
+	return read_poll_timeout(enetc_rd, val, !(val & ms_mask), 1000,
+				 200000, false, &si->hw, ENETC_PSIMSGSR);
+}
+
+static void enetc_msg_notify_vf_link_status(struct enetc_pf *pf, u16 ms_mask,
+					    bool link_up)
+{
+	u16 pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				ENETC_MSG_CLASS_ID_LINK_STATUS);
+
+	if (link_up)
+		pf_msg |= FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
+				     ENETC_LINK_STATUS_CLASS_CODE_UP);
+	else
+		pf_msg |= FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
+				     ENETC_LINK_STATUS_CLASS_CODE_DOWN);
+
+	if (enetc_pf_send_msg(pf, pf_msg, ms_mask))
+		dev_err_ratelimited(&pf->si->pdev->dev,
+				    "PF notifies link status failed\n");
+}
+
+static void enetc_pf_reply_msg(struct enetc_hw *hw, int vf_id, u16 pf_msg)
+{
+	/* w1c to clear the corresponding VF MR bit */
+	enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIMR_BIT(vf_id));
+	enetc_wr(hw, ENETC_PSIMSGRR, ENETC_SIMSGSR_SET_MC(pf_msg) |
+		 ENETC_PSIMR_BIT(vf_id));
+}
+
+static void enetc_msg_register_link_status_notifier(struct enetc_pf *pf,
+						    int vf_id)
+{
+	u16 pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				ENETC_MSG_CLASS_ID_CMD_SUCCESS);
+
+	mutex_lock(&pf->msg_lock);
+
+	pf->link_status_ms_mask |= PSIMSGSR_MS(vf_id);
+	enetc_pf_reply_msg(&pf->si->hw, vf_id, pf_msg);
+
+	/* Notify VF the current link status */
+	enetc_msg_notify_vf_link_status(pf, PSIMSGSR_MS(vf_id),
+					netif_carrier_ok(pf->si->ndev));
+
+	mutex_unlock(&pf->msg_lock);
+}
+
+static void enetc_msg_unregister_link_status_notifier(struct enetc_pf *pf,
+						      int vf_id)
+{
+	u16 pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				ENETC_MSG_CLASS_ID_CMD_SUCCESS);
+
+	mutex_lock(&pf->msg_lock);
+
+	pf->link_status_ms_mask &= ~PSIMSGSR_MS(vf_id);
+	enetc_pf_reply_msg(&pf->si->hw, vf_id, pf_msg);
+
+	mutex_unlock(&pf->msg_lock);
+}
+
+static u16 enetc_msg_handle_link_status(struct enetc_pf *pf, int vf_id,
+					void *vf_msg)
+{
+	struct enetc_msg_header *msg_hdr = vf_msg;
+
+	switch (msg_hdr->cmd_id) {
+	case ENETC_MSG_GET_CURRENT_LINK_STATUS:
+		return enetc_msg_get_link_status(pf);
+	case ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER:
+		enetc_msg_register_link_status_notifier(pf, vf_id);
+		return 0;
+	case ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER:
+		enetc_msg_unregister_link_status_notifier(pf, vf_id);
+		return 0;
+	default:
+		return ENETC_PF_MSG_NOTSUPP;
+	}
+}
+
 static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 				   u16 *pf_msg)
 {
@@ -203,6 +310,9 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	case ENETC_MSG_CLASS_ID_IP_REVISION:
 		*pf_msg = enetc_msg_handle_ip_revision(pf, msg);
 		break;
+	case ENETC_MSG_CLASS_ID_LINK_STATUS:
+		*pf_msg = enetc_msg_handle_link_status(pf, vf_id, msg);
+		break;
 	default:
 		dev_err_ratelimited(dev,
 				    "Unsupported message class ID: 0x%x\n",
@@ -228,7 +338,6 @@ static void enetc_msg_task(struct work_struct *work)
 		goto out;
 
 	for (i = 0; i < pf->num_vfs; i++) {
-		u32 psimsgrr;
 		u16 msg_code;
 
 		if (!(ENETC_PSIMR_BIT(i) & mr_status))
@@ -236,12 +345,13 @@ static void enetc_msg_task(struct work_struct *work)
 
 		enetc_msg_handle_rxmsg(pf, i, &msg_code);
 
-		/* w1c to clear the corresponding VF MR bit */
-		enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIMR_BIT(i));
+		/* If msg_code is 0, it means that PF has responded to
+		 * VF in enetc_msg_handle_rxmsg.
+		 */
+		if (!msg_code)
+			continue;
 
-		psimsgrr = ENETC_SIMSGSR_SET_MC(msg_code);
-		psimsgrr |= ENETC_PSIMR_BIT(i); /* w1c */
-		enetc_wr(hw, ENETC_PSIMSGRR, psimsgrr);
+		enetc_pf_reply_msg(hw, i, msg_code);
 	}
 
 out:
@@ -361,6 +471,7 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	if (!num_vfs) {
 		pci_disable_sriov(pdev);
 		enetc_msg_psi_free(pf);
+		pf->link_status_ms_mask = 0;
 		pf->num_vfs = 0;
 	} else {
 		pf->num_vfs = num_vfs;
@@ -388,3 +499,32 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	return err;
 }
 EXPORT_SYMBOL_GPL(enetc_sriov_configure);
+
+static void enetc_pf_notify_vf_link_status(struct enetc_pf *pf,
+					   bool link_up)
+{
+	u16 ms_mask;
+
+	mutex_lock(&pf->msg_lock);
+
+	ms_mask = pf->link_status_ms_mask;
+	if (!ms_mask)
+		goto msg_unlock;
+
+	enetc_msg_notify_vf_link_status(pf, ms_mask, link_up);
+
+msg_unlock:
+	mutex_unlock(&pf->msg_lock);
+}
+
+void enetc_pf_notify_vf_link_up(struct enetc_pf *pf)
+{
+	enetc_pf_notify_vf_link_status(pf, true);
+}
+EXPORT_SYMBOL_GPL(enetc_pf_notify_vf_link_up);
+
+void enetc_pf_notify_vf_link_down(struct enetc_pf *pf)
+{
+	enetc_pf_notify_vf_link_status(pf, false);
+}
+EXPORT_SYMBOL_GPL(enetc_pf_notify_vf_link_down);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 07bb9aab89aa..549ea3f4b5cb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -60,6 +60,10 @@ struct enetc_pf {
 	const struct enetc_pf_ops *ops;
 
 	int num_mfe;	/* number of mac address filter table entries */
+	/* Message lock, prevent concurrent access */
+	struct mutex msg_lock;
+	u16 link_status_ms_mask;
+
 };
 
 #define phylink_to_enetc_pf(config) \
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 44c546b77d3f..e3bed5580d17 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -458,6 +458,8 @@ int enetc_init_sriov_resources(struct enetc_pf *pf)
 	for (int i = 0; i < pf->total_vfs; i++)
 		mutex_init(&pf->vf_state[i].lock);
 
+	mutex_init(&pf->msg_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(enetc_init_sriov_resources);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 5bf7c20aba42..bbe21c739cf7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -26,9 +26,18 @@ static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 
 #if IS_ENABLED(CONFIG_PCI_IOV)
 int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs);
+void enetc_pf_notify_vf_link_up(struct enetc_pf *pf);
+void enetc_pf_notify_vf_link_down(struct enetc_pf *pf);
 #else
 static inline int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
 	return 0;
 }
+
+static inline void enetc_pf_notify_vf_link_up(struct enetc_pf *pf)
+{
+}
+
+static inline void enetc_pf_notify_vf_link_down(struct enetc_pf *pf)
+{}
 #endif
-- 
2.34.1


