Return-Path: <netdev+bounces-62772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4712D829174
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 01:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F53285796
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 00:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA2E23DB;
	Wed, 10 Jan 2024 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sZkLexq3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722F2112
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 00:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJz0kyYKF3K9eu0syQ2oOB0zFO51N8g0RUbSW1izr3T/YjhwymRecD6leL+bfbzAmnAawNjtEbCd9azPxHKSfztL5zq5YwFOulrbRLnK/Uxwdk5KESQsrCvVr6fjIAf4IZAKjUYygTizmDxB7AxnZ8GzZS/rE5TUt2W8IfdBnjXmKwQbpP6T3eWOYOvPa8jKF0tG73ILNVQXmnj8w7HZTytqTmakE/c4PoHQFPZM5GswMfAULXjRhZa105SgQnSrwfYHT4JsX+aruVdv7dbUN/SXcjyZMh60JSIkeFLQJyG7ZngwIeKy4fLmKtmL+YA38/Yiimc2ALKRFLf7uAFvaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTlAMJbpxTNYZfZT10LTTaQjmj2KqbL/9TgPDElU5/I=;
 b=MIBVaraNXDLRvPOXxY74cnf+8FwS7oRaUhsgRWfcSm1a6vujf1/v1WcBZUczGhQRflTYe5kNcc4J+RW8AFTBIvO3zdFGt68DxIMpNCwN5j6rJFFN0jFh5uPCiI52ms+6JRy/zd+m4JQ7T0ILDSuA5/54it4STzufkJk27O46kgSjKuj9g/4DRWvwMOHvIgyn5xDOG7NyNuVcz00AhJMKqJw/R9hcabV9uy08QlhNM1uMMaMLtZ9o6RDgvD/xnQ/pAAfEwA0v8jnQHpnAHmMpzyzFeVRMRKH2NDZP+mWrtrqHy8GnqIi3i21wog4m8hwFi34j64NDEFd+GYD1fuv8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTlAMJbpxTNYZfZT10LTTaQjmj2KqbL/9TgPDElU5/I=;
 b=sZkLexq3laqTBJksiv7BWfYQ0ZZ4whEmC5oLlkuzn6TfuAEtXTuKUgkGBVYJg5ipBFwsQznZqBmG7cEqRv0EvdS6bo6Z2hVkqnxbkn1IYPpbTNFbpXHjctHtmELqEn6zCP84g24hbnQGAUD2dyaqb5Rtj8sOWz/B/SfqzSGAzh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 00:34:13 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 00:34:12 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com
Subject: [PATCH net] net: dsa: fix netdev_priv() dereference before check on non-DSA netdevice events
Date: Wed, 10 Jan 2024 02:33:54 +0200
Message-Id: <20240110003354.2796778-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0093.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::46) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|DB8PR04MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: e4be1016-00d8-49df-354e-08dc1173dda4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZaDDqPP/4sv4zDo+m1y5HW17sRvNQblENKRHVy0aToBT8wPkv7YNKYLdlucaaWfW8u67xRDS+FRdofRKV69geSfQx+rvJHPt//ougrl+1z1/T9Xg07rjr1XCse0DUiUehFdl7xXHi2+rqqcyVv+grzSgW4GfCFc1R4VUxCyF4xWuAoUx8AbWO/WzCYyFDV8IVasjt157efjJJyKkcfL8DD31sXpCP7IawyTeQYzp3r7utyGifh9zjGHGqJiwI2u8o13ds8STac6hhvV3NiPv37dStWCGh7ReX4EWpXx+sSVCxNoeBGYYBZtWgumlHHitFDsL1+1VQ9p29oaCC94go78W0AkMG+v3kfUoIAi6tFv5K8oGUUMVsI5EXFj0wAzQTsDhp4vdmjNZXoUf5UlU82zPc8fQZ1mVOequAkm0C/H38Th1GxWMCmmLeJeJjr8mTsDIbSBdgvd1EpWa0a6EBhXf2F2bllXDZy5wDQRZdMGrCB5/fDzTicr5K2ahqIJaq9yMjp0/uORVMcOtonBcJXV89G2rmynoOt1JH+HjPzYlBXgysod0yeqgFyiRbSYPAp1s6TjrpMlJzLr8eKC2xxNKYB6Nznk3F75GZqikeww=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(66946007)(41300700001)(38350700005)(86362001)(36756003)(38100700002)(6506007)(316002)(26005)(2616005)(1076003)(6512007)(966005)(6486002)(2906002)(54906003)(66476007)(478600001)(6916009)(6666004)(66556008)(52116002)(8676002)(8936002)(5660300002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gneTUBHQ43AeuApdTpTbJIVarYXkYe+Y9LM2xTCfkm0lOA+bYbKq6sK3lJNC?=
 =?us-ascii?Q?K4SFvJCSxCIZtr9KWWi6PkiZMKu6A5sUu8vCe23R9Z6Y4jIWdMaR6wDMnVzX?=
 =?us-ascii?Q?N5SNjMMOrk0dT4H/tg5FVkDC3ZwXuJ4/QYjmRdF1LVOxyG/keapD4JJUTnFF?=
 =?us-ascii?Q?zwiyeh+sMTke8dLYR0+6JSgkCkeW59jC53qPPpg5MUbNQO35/FhQCimg9SxK?=
 =?us-ascii?Q?PKsekBjPZy/wDj18umRRivrMzzXZhvNtXtq9dixTuLQW8MRuPi3f6wurF34O?=
 =?us-ascii?Q?Hc1uzXPXjDTXQI7AgOMIDsbatCZdeVlPXOuDaPK7X8deLAmxMoYEeCf1q4S9?=
 =?us-ascii?Q?tIqa6ijWcZrDxc1AOaJL1tMfGChk7CcCtJkhmHkgS2mpWL4j/5OklEbOKFRz?=
 =?us-ascii?Q?aUqC4kSHuKHO4l07u28lVeT+ESSLY3Qyz2jfjAQd4bQ75ewK9M2Z4yhCHXiO?=
 =?us-ascii?Q?BmK17VSOIBs03f8AhbqfSwauSfHN/ZoEdI9zyAVnzFTl8KwbabazibPBkn7C?=
 =?us-ascii?Q?OARjL3Kxg+Ar8pr4Lk3yTIZUut+LWcZgq921pE1vcl/s1kjXKMi3IIez61N0?=
 =?us-ascii?Q?Lwq78RZfT2f7ZW2GkdzKOXYlss9wLayNoSAu/jv8ekVCyebzMkMObE8n5Mzq?=
 =?us-ascii?Q?RK2YxBuAe8fkMDw7dZToaCyXQo2kJbhl/HhEqIAeMimXABWgsgpCN7Oa7R6n?=
 =?us-ascii?Q?Gp0SbxtJ7xoP4l3YSIiExj/Ne26pFhJoiwz5SHsCN/VVKZmlEXb53bS5nCE+?=
 =?us-ascii?Q?yc9xq6tgL8HHED1JOg793ZVgfW6Ow1dsQWsZeQLHqCELnN1drlbDnCWrJ+Mp?=
 =?us-ascii?Q?4H9oh5Rr23gDqQC242YKmkd8fnHDYbysmYx+YKzO8fFUKqNIoc5o7rGpunUV?=
 =?us-ascii?Q?0cr4UuykJofX4OheVqHIkFJpp0hYnQUZZoSRlHScuV3FTGuwCDZqX4ymwWCb?=
 =?us-ascii?Q?3dF8h87EgQNYu0QwvuJrJy6N441M5zgCGaUWmR5YCOZcAt5ujxA7dS2gqfUd?=
 =?us-ascii?Q?ka/ljq9VsDmESSZoItG4d3uk/UdnCtbHydixy6PdAE+SK/aM0R/Do58EvPOs?=
 =?us-ascii?Q?3YYIGMGdnO+hwJ1WORVAKGs8U5KZTzcgU9sA0e4fCsSB20C//JcrFBotIJeg?=
 =?us-ascii?Q?dGdxy/9A1uTSZC3J2EBiRjowZcszVcWY9tumm2nZpSMMd5OAmWGNEZxYqJ2N?=
 =?us-ascii?Q?4m79HM7SIjl95MlGrR/wzg5hKXMGuQPvnVPDUx3izRhGpexcImTQfvXE9nXA?=
 =?us-ascii?Q?YzOeM+vkDd9g8htnDRoVe5YU26Fp1Av6wcy7o94LEz8qrtL+yWvfptwPHJgC?=
 =?us-ascii?Q?ldWqUg39VlmYF0V76k2ru/CEDKBRdL6mmANTICrU7x9XLqGhRiX1NGtyf5jc?=
 =?us-ascii?Q?T0iWj/EwwSdZiv68HSQ2hwoAR1iij30tWrT0kBQZ0mH9VX0qsfjJUesYWH7N?=
 =?us-ascii?Q?DGtPo1wop1vxsGqWRdYI8pkEADNsYEaiIyciJgOjyoqF4cISVBYLI7oc+7Qa?=
 =?us-ascii?Q?wCERJgNy5hkVmqwA5uRRFoxiJLmwceX29+qoiEb9v2juTGU6lcnB/JNYtNa+?=
 =?us-ascii?Q?iz1hM62H5CkREXcuO4RNgd05SaCYpsPHmQvJ5KIpc5ba7ks/subrcMXwONeC?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4be1016-00d8-49df-354e-08dc1173dda4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 00:34:11.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7A3vh2BHSSKVy0dcf9tnsSPm7Dhb0Sp0EiuGiIPXhb80j6tler5TzPg991fLcQkH/UsKQ0P53UwITrIlf6NxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

After the blamed commit, we started doing this dereference for every
NETDEV_CHANGEUPPER and NETDEV_PRECHANGEUPPER event in the system.

static inline struct dsa_port *dsa_user_to_port(const struct net_device *dev)
{
	struct dsa_user_priv *p = netdev_priv(dev);

	return p->dp;
}

Which is obviously bogus, because not all net_devices have a netdev_priv()
of type struct dsa_user_priv. But struct dsa_user_priv is fairly small,
and p->dp means dereferencing 8 bytes starting with offset 16. Most
drivers allocate that much private memory anyway, making our access not
fault, and we discard the bogus data quickly afterwards, so this wasn't
caught.

But the dummy interface is somewhat special in that it calls
alloc_netdev() with a priv size of 0. So every netdev_priv() dereference
is invalid, and we get this when we emit a NETDEV_PRECHANGEUPPER event
with a VLAN as its new upper:

$ ip link add dummy1 type dummy
$ ip link add link dummy1 name dummy1.100 type vlan id 100
[   43.309174] ==================================================================
[   43.316456] BUG: KASAN: slab-out-of-bounds in dsa_user_prechangeupper+0x30/0xe8
[   43.323835] Read of size 8 at addr ffff3f86481d2990 by task ip/374
[   43.330058]
[   43.342436] Call trace:
[   43.366542]  dsa_user_prechangeupper+0x30/0xe8
[   43.371024]  dsa_user_netdevice_event+0xb38/0xee8
[   43.375768]  notifier_call_chain+0xa4/0x210
[   43.379985]  raw_notifier_call_chain+0x24/0x38
[   43.384464]  __netdev_upper_dev_link+0x3ec/0x5d8
[   43.389120]  netdev_upper_dev_link+0x70/0xa8
[   43.393424]  register_vlan_dev+0x1bc/0x310
[   43.397554]  vlan_newlink+0x210/0x248
[   43.401247]  rtnl_newlink+0x9fc/0xe30
[   43.404942]  rtnetlink_rcv_msg+0x378/0x580

Avoid the kernel oops by dereferencing after the type check, as customary.

Fixes: 4c3f80d22b2e ("net: dsa: walk through all changeupper notifier functions")
Reported-and-tested-by: syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/0000000000001d4255060e87545c@google.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/user.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index b738a466e2dc..b15e71cc342c 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2806,13 +2806,14 @@ EXPORT_SYMBOL_GPL(dsa_user_dev_check);
 static int dsa_user_changeupper(struct net_device *dev,
 				struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct netlink_ext_ack *extack;
 	int err = NOTIFY_DONE;
+	struct dsa_port *dp;
 
 	if (!dsa_user_dev_check(dev))
 		return err;
 
+	dp = dsa_user_to_port(dev);
 	extack = netdev_notifier_info_to_extack(&info->info);
 
 	if (netif_is_bridge_master(info->upper_dev)) {
@@ -2865,11 +2866,13 @@ static int dsa_user_changeupper(struct net_device *dev,
 static int dsa_user_prechangeupper(struct net_device *dev,
 				   struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_port *dp;
 
 	if (!dsa_user_dev_check(dev))
 		return NOTIFY_DONE;
 
+	dp = dsa_user_to_port(dev);
+
 	if (netif_is_bridge_master(info->upper_dev) && !info->linking)
 		dsa_port_pre_bridge_leave(dp, info->upper_dev);
 	else if (netif_is_lag_master(info->upper_dev) && !info->linking)
-- 
2.34.1


