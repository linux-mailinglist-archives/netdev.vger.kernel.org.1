Return-Path: <netdev+bounces-252604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COTgI6jbcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:23:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A0C6F935
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7941300DEC5
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF1A3815FD;
	Fri, 23 Jan 2026 02:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cL79vBMg"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266E9369239;
	Fri, 23 Jan 2026 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134980; cv=fail; b=C/HKD1FenxI50Qw0xZp/jqnHfb2w3tI8rsDvwgmVsgpcjRBNarVWNODd/9WGByxKrZ3KBocihfq220sUb5MR2Y1/z3ALzZUUxXZNqpzBxNfsmube03d01oegPxGUhwLKszOcTopzfduGEzEpvElZpzIXXcT6OggDN60FO9gTkXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134980; c=relaxed/simple;
	bh=fCBpTFMXDGCp+w5Gla4zwAqz7Q7C4omwxEXy3xX5jv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NKj0b3kWEegtVk4brJtpLQgYjufNFGkQXX+GrFS6YbIUbYMkUlszl+3oakrjIqQlz/SPK0H0qBy0OQKQH5s1M2vNo6Q7JqEd5T9fdY+Xht+el6abSEPjt7Z0v2uZX24sYbj+OJj3imVE1uRqXDT1FKclt+RQtYqYm5eOKLIp03A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cL79vBMg; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msTjMUZKxDxqMi9uzMTgp5gvYEbie7jgs/aGi2Ap70hbpamW338oE1FK/I8Y4w+GooQFfWGrE6+l+Yn0GJWH5D65MgSxhjbkOoso+G3Jc1TiU1eTobF3UBS59a5+sCUXalVS/1cnfORTTaX8S/6lCGttJGFW0i1/0wg1w8KREkkJ6NO4S9Bid+7dNcwiQhGF4TZ2QWPyZLAKo9ODO9GwU8Bf+T92JoQG3h7bP4cgrnCKZ6Kukrz/LRQcKYs0uBuvCg1hxywK5nBGNCiDyrb01+kgzqrOZPErIy01GBlxy/j6nGAU12fQx+Dv5OQCWIzNo4HrZP1QlemKYXOfcN65AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+d9WkCqdg7LMSVp1VUabUHYeMpgZtSC/5qmDRiHfrCo=;
 b=sbeHG26CUMro5AcDUZWSyi83FetbJqY7v05M6vx9PUA4/mqwDzfGIOfm1ujT+VazZr65uPkBU6L6dmumT6DFpmxAyWg+nFOxf7uYJTMB4V4Hk64s64QrMEj5cMZl/HXU7ys6H6N7jFH/BGRmvKLC1e+0EWKtlrO9P4cByBCcGmzbPXDx4cfNVPgR5yFnbu4Lui8m4l09e9Ohnye3ik6rbxaYiJFdsi60bJaTgxhlFere0tBEI7v6Pmzrr/xOm+kX5sAMQY2XTzWdMphSkKU3761C29UKr3qpe3TTI36fB7FNqApeuhFHtydcwBw/M851xg+iZpSM/PXRcTn3hTHVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+d9WkCqdg7LMSVp1VUabUHYeMpgZtSC/5qmDRiHfrCo=;
 b=cL79vBMgE3q+TKhdE/oFwq45Y/kW9jEir8nr4FPolvFFqb/3R/EYZnvq1GTnBfvlld758vSKcULl7BLtv0yvs4iGr5Oe0iRAg1+XbyWgm+8XwGwZRakhzX36G33RBdcmgw+xSwXoJZVlccxl0N3Evr/99GrMd7fCIUZs7xTNLVVd02q5pcs729bW2h/Yb37Upl9ebAW7+sNF8PR5dFVtDD6GMahpnniGu0KLzuKxidEyDlI0mYKCo0yTJkU+xE6qDyVi4/txK/FxWEy+CZBocYUi1l/hXfmQ+m+0YDsBWYFdbsyS96NEk+pGu+3sSMka8SWVkcwkzvyUxPcTtmMDCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:22:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:22:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v4 net-next 04/15] net: fec: add fec_build_skb() to build a skb
Date: Fri, 23 Jan 2026 10:21:32 +0800
Message-Id: <20260123022143.4121797-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123022143.4121797-1-wei.fang@nxp.com>
References: <20260123022143.4121797-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f511ccc-5036-4551-4c98-08de5a263d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zcXejbeB5oN5njkoTPctvxnMDkXvKPXBI4C9vbLgG4tJASTyhYBUol7jz764?=
 =?us-ascii?Q?fMl/wAkeMHqY9KzYpaQ438bJWSzhIRMn8NMI+QR5ODNl4uqdTszeg8ySLeKW?=
 =?us-ascii?Q?jsl5g+WxIzd6Hs2KGHXHXfPTUaPmmRarRpwFkaCWR5yT0X9XAinw67J9bd7k?=
 =?us-ascii?Q?HUN6bPQmFyMxgOx0yaz3gChUnJFzBF79M5BGJxtI/ojWeCWhhNAe2RRXQtvX?=
 =?us-ascii?Q?c96vS4tb44TI5fBn9lmbUsw7gKN7yLCqOxE3hj8dx9TfZCXS2E6JG0raFZAR?=
 =?us-ascii?Q?N70TSGTL6lohBHJs4nNy4+/K97ZHqS73OHT4HIbEN8qOWs8jYo7qD5LIG8hf?=
 =?us-ascii?Q?IiuIxYWd9k/jt3GYZFpachcun29FE6QB65cjkWkLE7ypf3zhEcRpAFIQFBBz?=
 =?us-ascii?Q?I7FWiPAa+4ZjfkYx1gI7eSgcbcDbSrze4E+kSdOa/P3QjOKnZKemZjMJulUS?=
 =?us-ascii?Q?WOMORm6GbFqv9Kvd87/zQgF5YEjdoF4vC+x0MDI07UkWfVM9AGqCLFBekzAm?=
 =?us-ascii?Q?Qo9PewJhF3SPk2Zn4kc24KlZrekvJZYclYSHJv3q2geAYIHp835i6tV2zwhJ?=
 =?us-ascii?Q?zx8Sgbqd2+yDu03mWpBpOGLlxLqGncTdEx76Ntq6HLeKXE17Hi9FlhZ1wPUP?=
 =?us-ascii?Q?cUMh/t9yDk/TPPn0pqbh+hyB0eCqPiQ22qw0cgxjj9hsjryuFnLSLt0nRMzB?=
 =?us-ascii?Q?ft8zgMLuHTzArjNOUf3UEPUOj/7JLT32y6DYinVMS3hHB8Byb/5mBtF97snW?=
 =?us-ascii?Q?uJi35XkvORs0iuEsA0mDUDCUHK792FF3kFnCxZSRghbmk+5/BDTlQySZy6y7?=
 =?us-ascii?Q?1eVdXOVZHAFq74U4ug++lGsJalYqAbf1j8Oz/kWtULRpt1FhFyJ1uoomhTAP?=
 =?us-ascii?Q?tGKnjXlg7pSjy9ecIezeGkZX+xPiKFjjR9Xc06057/kWeKfwIQm9X6SIzKL4?=
 =?us-ascii?Q?pWl9H5I8USOC5jKLe6AjhoM8vjulQ5csa0vTFuQqm+hedUdPSqq6Il9k/fct?=
 =?us-ascii?Q?vMowie05jdyUyNIIUGfYT3RnB5GabFt5MSSinRoQq/4LSy2IMlR4r3SDw9vR?=
 =?us-ascii?Q?u3UuXRsA+E0FtqMXGgA7yDjPA5PVaqifbPWv2cLHQ18rhg0RrkgQjkmZdEvt?=
 =?us-ascii?Q?QcP7WaZGjzzplLW/PM67HqyxtpIWBtzmlW2pxkFJzB4scuATsL6pZ762VERJ?=
 =?us-ascii?Q?gUIOZ6XYrV+5iU5EUWn6e9uLBenWRJsicX+Ne1k6Ljnt/kHSA/1cJGrHW1We?=
 =?us-ascii?Q?QY3BEi5AFnCl0M5Jdf8LhLccVhz9X3nIkklw7w01ZIGevesMZi4cjUt0256m?=
 =?us-ascii?Q?MzNN6JCjFI+S9yfwuiy8B06JMSvxiIrX0F8vew0wc4fOTCwOtLnGX3u07IKn?=
 =?us-ascii?Q?ar4vtCjn7Nzqn0kD9z7N8rFv9LpbtgRrz2H1ZQkE/jTk6y94d4k+kpoWf6FQ?=
 =?us-ascii?Q?mgutiPbXh0OnUXK3oMIYAwvwp8tXqLGPBeXKY9v578LjVZKjVlpC/rb3w4bI?=
 =?us-ascii?Q?gBWvrQfZoCAA8AOXsNobp4Qey6bYySgRts7WEdMkwrSIauZAMf0ll4WAIWuE?=
 =?us-ascii?Q?dueKjSHFmGH0EBNhz58P2PF74TUuIvk3dJTaKBu6m5xFFl7ST6XmQyExsnYL?=
 =?us-ascii?Q?0SCaaWA00tBVVILc9g48A5s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?87JHRyeuv6UQgxnOZSQoo4J+75wFm9nhQCtt9msGeecxB+BjCz/yJyh2QcjF?=
 =?us-ascii?Q?aL4R3n0uEngtHof+NbaSoaVcKT4iwHpwOI5ygM5OGaZxyffXlnlbQmprgNR1?=
 =?us-ascii?Q?RBDXmOQcYLjBQVsk9uzgm2f162DyjwSDitMg6dhxT/5fLO9oAtjesVNB7esx?=
 =?us-ascii?Q?ssNpBLhxQJ6I7tFKbVKeQJyGH/WxhPxNU/2uXm0aKq3qO6itxVPuTwoFQeAJ?=
 =?us-ascii?Q?357HwiDaFlwvjaGJ4yuquuF137WJ4rfhX8KtH8qXZajn0pI/BNftuTIHrEcd?=
 =?us-ascii?Q?HTMMfeqGQPvOqfg3hYlYzc4CK9uakOVxmgPuIb9I8vr+QHGSQSF+3HMM9wza?=
 =?us-ascii?Q?foztJu9EgU94zORIr74wTWVPLmRu23WtW7HdboVYMwb/VvydpiUt+dWwENF1?=
 =?us-ascii?Q?ibSUKTLsyUkOVMKxBagZwGu9ZlQUYTKwKmErF3fkNzvrEO72R2qAm9Qy29Ms?=
 =?us-ascii?Q?qF/CtQQ5vFW5wz6bR5A/szSEG4/U1GYBjhSdSMqFIq/3GDgRsqVVtjbB0z9w?=
 =?us-ascii?Q?dYdYBwbRFPvwX57CXdraA29EA5mb9v2PuEItQ7+ICbalX6DecfRCpeoQ2m8B?=
 =?us-ascii?Q?G31N9CVaFxMSTnT9VDvbxCTr9emEdPa1b+FSiv8y07Qw4KgGrs7iX4yhhUXO?=
 =?us-ascii?Q?V5Y2gSsyvxy1xj8UdcDohrTY1ulzq8O7c0WN7dfDQDZxqnu/GakjaicIuFfH?=
 =?us-ascii?Q?lCTXTe9WYxMnGsHFzwbXmbcWfWyZBl41Qdjo+b0Vu1BI3Eu1LtJi5MWYHxzZ?=
 =?us-ascii?Q?dHd/ZlMZHffwWSx7yeHy8ZpfmwHlHfrnq9OezGFEmns6kAlmh/l1tcyDlehl?=
 =?us-ascii?Q?E8zGc5WetMJqA+OAFSUSn8ofkXYDU7Uo5A9GwIaiy8DLw9Lz3voj1pybNVf1?=
 =?us-ascii?Q?u9rvaVqVcBwIHhUbw97R2UrlZyLOH1kOkqDXYik6wZpKN/HN1xIZJQzg+b82?=
 =?us-ascii?Q?Ip9NRQW26TtRNnD5U+hxXf6pXaAsd9dSTmaIT+bhAc5jEJLq9kQc8DXqzGMO?=
 =?us-ascii?Q?N2E9NMaspLhwa/XjBlCSrzh/wgoTkthhHTh9NkDzxnsRUKn1nax/eT9fX7Em?=
 =?us-ascii?Q?yZp5AOCTDUO4EFHUlf3D9dTlhq0343nXnl5+HRwx4VWqfE1E8eM1v3N8pKBy?=
 =?us-ascii?Q?nUn1uWhsNS1TL8FwIaQmouY24uLZ0hTqt74oRn2oBDfYT+8AdRaS+TaTrRV+?=
 =?us-ascii?Q?+6PiaNP3T/i+pEYPBLsS4eh8TQ9Rws9Ovq8gOBz1l1zst67/Z5vOQL78DATz?=
 =?us-ascii?Q?GsChBqWVLEKiEHz/d6rVa6+sXlgR5He+U96aD5W8eve5TYOJVLd4baHD378G?=
 =?us-ascii?Q?gK3o9+Uu6PChWlhqkRx3NLM0ynzEKEx014GyfHp8xsI9xkHf2qs1gbL5xEO2?=
 =?us-ascii?Q?iM8O70TEAp7J66e3msD5ud3W5xRO/jhYaqC8zFhtdBre78nyAXFH1b4JFbK7?=
 =?us-ascii?Q?zlID2ZFw72QcMPtpFYW4QwrNfTmv8pS4nAka38heFizjf1arPNwQz+r2kGid?=
 =?us-ascii?Q?uG+PBbCGSAQUctr+zs6aM1VQX4M8VVyyFJUKt/iT40Rjr8dCUBSVxrgexCV9?=
 =?us-ascii?Q?y7W/baBQQin7pfHH4Fpc6wroYNmf2lwC027AIaBrxy/jiVrT/sDlUguRwrLZ?=
 =?us-ascii?Q?UiH83C7VJtAbexNLGWy4CU6FSz94GDEINFO1e821yTEwUbA/M2cazBFD7IIC?=
 =?us-ascii?Q?mYo9hmxASG9j4QgyZ2t+jL605+5Lph4ayb0/qWpEeTE89leu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f511ccc-5036-4551-4c98-08de5a263d31
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:22:21.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYgAAtWrjHG2BzCOmmOrnxAZL/fl3yT9l8YHsoJQhehMiQA6ZEI9f8aUxB7WiUxOldEr++EKo6d36itqTEvx0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252604-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77A0C6F935
X-Rspamd-Action: no action

Extract the helper fec_build_skb() from fec_enet_rx_queue(), so that the
code for building a skb is centralized in fec_build_skb(), which makes
the code of fec_enet_rx_queue() more concise and readable.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 106 ++++++++++++----------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 68410cb3ef0a..7e8ac9d2a5ff 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1781,6 +1781,59 @@ static int fec_rx_error_check(struct net_device *ndev, u16 status)
 	return 0;
 }
 
+static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
+				     struct fec_enet_priv_rx_q *rxq,
+				     struct bufdesc *bdp,
+				     struct page *page, u32 len)
+{
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc_ex *ebdp;
+	struct sk_buff *skb;
+
+	skb = build_skb(page_address(page),
+			PAGE_SIZE << fep->pagepool_order);
+	if (unlikely(!skb)) {
+		page_pool_recycle_direct(rxq->page_pool, page);
+		ndev->stats.rx_dropped++;
+		if (net_ratelimit())
+			netdev_err(ndev, "build_skb failed\n");
+
+		return NULL;
+	}
+
+	skb_reserve(skb, FEC_ENET_XDP_HEADROOM + fep->rx_shift);
+	skb_put(skb, len);
+	skb_mark_for_recycle(skb);
+
+	/* Get offloads from the enhanced buffer descriptor */
+	if (fep->bufdesc_ex) {
+		ebdp = (struct bufdesc_ex *)bdp;
+
+		/* If this is a VLAN packet remove the VLAN Tag */
+		if (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))
+			fec_enet_rx_vlan(ndev, skb);
+
+		/* Get receive timestamp from the skb */
+		if (fep->hwts_rx_en)
+			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
+					  skb_hwtstamps(skb));
+
+		if (fep->csum_flags & FLAG_RX_CSUM_ENABLED) {
+			if (!(ebdp->cbd_esc &
+			      cpu_to_fec32(FLAG_RX_CSUM_ERROR)))
+				/* don't check it */
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+			else
+				skb_checksum_none_assert(skb);
+		}
+	}
+
+	skb->protocol = eth_type_trans(skb, ndev);
+	skb_record_rx_queue(skb, rxq->bd.qid);
+
+	return skb;
+}
+
 /* During a receive, the bd_rx.cur points to the current incoming buffer.
  * When we update through the ring, if the next incoming buffer has
  * not been given to the system, we just set the empty indicator,
@@ -1796,7 +1849,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	struct  sk_buff *skb;
 	ushort	pkt_len;
 	int	pkt_received = 0;
-	struct	bufdesc_ex *ebdp = NULL;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
@@ -1866,24 +1918,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				goto rx_processing_done;
 		}
 
-		/* The packet length includes FCS, but we don't want to
-		 * include that when passing upstream as it messes up
-		 * bridging applications.
-		 */
-		skb = build_skb(page_address(page),
-				PAGE_SIZE << fep->pagepool_order);
-		if (unlikely(!skb)) {
-			page_pool_recycle_direct(rxq->page_pool, page);
-			ndev->stats.rx_dropped++;
-
-			netdev_err_once(ndev, "build_skb failed!\n");
-			goto rx_processing_done;
-		}
-
-		skb_reserve(skb, data_start);
-		skb_put(skb, pkt_len - sub_len);
-		skb_mark_for_recycle(skb);
-
 		if (unlikely(need_swap)) {
 			u8 *data;
 
@@ -1891,34 +1925,14 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			swap_buffer(data, pkt_len);
 		}
 
-		/* Extract the enhanced buffer descriptor */
-		ebdp = NULL;
-		if (fep->bufdesc_ex)
-			ebdp = (struct bufdesc_ex *)bdp;
-
-		/* If this is a VLAN packet remove the VLAN Tag */
-		if (fep->bufdesc_ex &&
-		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN)))
-			fec_enet_rx_vlan(ndev, skb);
-
-		skb->protocol = eth_type_trans(skb, ndev);
-
-		/* Get receive timestamp from the skb */
-		if (fep->hwts_rx_en && fep->bufdesc_ex)
-			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
-					  skb_hwtstamps(skb));
-
-		if (fep->bufdesc_ex &&
-		    (fep->csum_flags & FLAG_RX_CSUM_ENABLED)) {
-			if (!(ebdp->cbd_esc & cpu_to_fec32(FLAG_RX_CSUM_ERROR))) {
-				/* don't check it */
-				skb->ip_summed = CHECKSUM_UNNECESSARY;
-			} else {
-				skb_checksum_none_assert(skb);
-			}
-		}
+		/* The packet length includes FCS, but we don't want to
+		 * include that when passing upstream as it messes up
+		 * bridging applications.
+		 */
+		skb = fec_build_skb(fep, rxq, bdp, page, pkt_len - sub_len);
+		if (!skb)
+			goto rx_processing_done;
 
-		skb_record_rx_queue(skb, queue_id);
 		napi_gro_receive(&fep->napi, skb);
 
 rx_processing_done:
-- 
2.34.1


